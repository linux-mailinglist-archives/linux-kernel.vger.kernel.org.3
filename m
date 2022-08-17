Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E670E597688
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiHQTc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbiHQTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:32:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21800A4B3D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C3CEB81F0B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF80C433D6;
        Wed, 17 Aug 2022 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660764685;
        bh=folaEiqwvPtEOi1ekaQcirtyCHSCVGrI+j/lwWcW9o4=;
        h=From:To:Cc:Subject:Date:From;
        b=cBDJ7OdwSban6nhrj+lYajXImQUp/x28+Vh//RpP1ThS8CLRlGJYbseB5U+LQh98P
         8jLEihOuV+itRpV4zyUuXusoF3qJqRmJZ6b9XqORWlrHLUiGvcpw7ppWVoWm0boDHM
         6mDDmOIM5GRXCIFzXbMJgNkRShMbmhjjUNl6h99ezfCqFZFQaC51tOUQ5U4jKmmNS4
         rpyZZrV3v3al3Dy3mM1sgjmQsptXMyOip2f/goUqzNU8KbNhlzQMPgQdFcPWVkoEpd
         63b3DkTFgFfOHbdj49L2jUq+Da+fvF5R0SNplPZuwhVRhN9q9QEHoW6ccKHJJafi8o
         G14hfwD8UywYg==
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
Subject: [PATCH linux-phy 0/4] mvebu a3720 comphy: Fix serdes transmit amplitude
Date:   Wed, 17 Aug 2022 21:31:15 +0200
Message-Id: <20220817193119.4463-1-kabel@kernel.org>
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

