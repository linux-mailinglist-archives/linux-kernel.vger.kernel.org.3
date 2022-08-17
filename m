Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6EE597748
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiHQUDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiHQUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34918340
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE386151C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED50CC433D6;
        Wed, 17 Aug 2022 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660766620;
        bh=0ZcQMibMEVZJPOojqwq2yBUXq0LRnX3KICwqnQfqKLw=;
        h=From:To:Cc:Subject:Date:From;
        b=Hi3P8xdLSdIRaXdyCEilVUGu31fLrjs2H8b1VQ217qL7JEa/6KPFRJjRrTfnYihB9
         r6z6ImlHAgBnf5vzPQmxudqvNiNTt+wJdzYdTFJHFUmelT3UPf8pknlXJF2fCI/Gwk
         GlkfyAQqNTIseRoLdVpeuyHIePIpiFXEJaYpR4In96sECKk/hIXdMtq84B+si8N1OE
         JGlQK9IC17FvHsR4zyLxanoPRP65aASolOouBG3AjZViAPdf0HgytjuKb8veoe5mLZ
         w8dZI6DMsc0SdE1XBag55q5WXk0/ezTcHOkq90rFHqwGdq6EdywXREM9FX0vYm3UkL
         ls2NOUwaWC3wg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        pali@kernel.org, josef.schlehofer@nic.cz,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH linux-phy v2 0/4] mvebu a3720 comphy: Fix serdes transmit amplitude
Date:   Wed, 17 Aug 2022 22:03:31 +0200
Message-Id: <20220817200335.911-1-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- fix
    static const char * array should probably be static const char * const
  warning in patch 2
- fix wrong parameter order to function comphy_find_best_tx_amp()
  in patch 3

Original cover letter:

This series adds support for setting serdes transmit amplitude for
ethernet modes (sgmii, 1000base-x, 2500base-x) in the Marvell A3720
comphy driver.

The amplitude is set according to setting in device tree.

Finally the Turris MOX device tree is changed to set the 2500base-x
mode tx amplitude to 1025 mV.

This is needed to fix a weird issue wherein when A3720 sends a packet
to Topaz, and the packet contains a long sequence of 'J's or '\xb5'
bytes (these translate to '010101010101'... in 8b/10b encoding), the
packet may be lost on Topaz due to FCS error. The probability of
loss grows with number of 'J's:

  loss
                         ______
  100%                .-^
                     /
                    /
   50%             /
                  /
                 /
    0%  ______.-^
            90    114    125     number of consecutive 'J's

Marek Behún (4):
  string.h: Add str_has_proper_prefix()
  device property: Add {fwnode/device}_get_tx_p2p_amplitude()
  phy: marvell: phy-mvebu-a3700-comphy: Support changing tx amplitude
    for ethernet
  arm64: dts: armada-3720-turris-mox: Change comphy tx amplitude for
    2500base-x mode

 .../dts/marvell/armada-3720-turris-mox.dts    |  10 ++
 drivers/base/property.c                       | 130 ++++++++++++++++++
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c  | 109 ++++++++++++++-
 include/linux/property.h                      |   5 +
 include/linux/string.h                        |  18 +++
 5 files changed, 271 insertions(+), 1 deletion(-)

-- 
2.35.1

