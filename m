Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8A4C3112
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiBXQNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiBXQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:13:47 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C01B2AF4;
        Thu, 24 Feb 2022 08:13:10 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4DA5022236;
        Thu, 24 Feb 2022 17:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645719037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3AVbMEK1Kj2Wq9B+4ntgjAAH5iOrMVQj74iBl24oPtw=;
        b=ITei4q9+8nn/DYKLqakBypCqB2YpmgMFhVkxmsND14t8x2SN3jXGfW0/oVaGBvbnwN+dX3
        vwOanXjcD2um8NA8npBeore3XYI+pRrYa/vfRZ1hqYI/NKnX18vbOoWJOP/xTsCQF+Rdf7
        ZsNKPmPLk2WuLgaho/Vlt601Xapzg8k=
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 0/5] pinctrl: microchip-sgpio: locking and synchronous output
Date:   Thu, 24 Feb 2022 17:10:16 +0100
Message-Id: <20220224161021.2197263-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are boards which use the output of the SGPIO to drive I2C muxers.
SGPIO right now is broken in a way that when the software sets this bit
there is a rather large delay until that value ends up on the hardware
pin.

While digging into this, I've noticed that there is no locking at all
in this driver. Add locking for all RWM accesses.

Please note, that parts of the modification of the first patch are
removed again in a later patch. This is because the first patch is
intended to be backported to the stable trees.

Michael Walle (5):
  pinctrl: microchip-sgpio: lock RMW access
  pinctrl: microchip-sgpio: don't do RMW for interrupt ack register
  pinctrl: microchip-sgpio: use regmap_update_bits()
  pinctrl: microchip-sgpio: return error in spgio_output_set()
  pinctrl: microchip-sgpio: wait until output is actually set

 drivers/pinctrl/pinctrl-microchip-sgpio.c | 101 ++++++++++++++++++----
 1 file changed, 86 insertions(+), 15 deletions(-)

-- 
2.30.2

