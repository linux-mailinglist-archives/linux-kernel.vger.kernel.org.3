Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901C553079D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352157AbiEWCXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiEWCXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:23:30 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEF236333;
        Sun, 22 May 2022 19:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653272559; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=iZSGIfnqE+bHAhHjujSRSO64D3YMEopKfjoLrPBx/j+pVorx4d891upzoNcpEnu/3xBxC2HtyoaFckMKe4pRLyb4Vh4ksnB3NfZBEGazgaFB3jH8bOscdV2ZeJlPm7kVlt86+Tpbt3By3rpoyr9fofm/t7ZJ9l9WG1JV6SMIja8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653272559; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/bikDoNadTZ6sMn+hHaOJW6uJ31maMd/Si31cdfcYis=; 
        b=mtNsFq2m9oASdzOCE4xAc8wVe9hzu6Dah2I8GNSooPeT6r89fI4FAmsLZseQzCWgbG15ICJc8bcH1ZGhjgAtMg4brjlngWGV8W2Lgbta5Ifmkz/USBHqa385FpSi+9SoN1blvMH1jqSdp1HYFy/zpMqxffCRxmU8yeOsBrxiQ1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653272559;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=/bikDoNadTZ6sMn+hHaOJW6uJ31maMd/Si31cdfcYis=;
        b=E6xmZ+EqL0V0hv93+SPFeB7j+QXdg23pFjfOgdtgg0shs5+TPxhUQhzx/BMocvLb
        N/wJBwinggrtDGcO2RjphCYE/nUb1AR7qG+iXBiO/yZvKEW2CTTLvn/wlg7cWYo20UZ
        mL4j+AjMDOkQzmvvnBpr9l9/KJkk9mOvf1kmCSyA=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653272557856227.86815470753436; Sun, 22 May 2022 19:22:37 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 19:22:37 -0700 (PDT)
Date:   Sun, 22 May 2022 19:22:37 -0700
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Mark Brown" <broonie@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-gpio" <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "linux-sunxi" <linux-sunxi@lists.linux.dev>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Message-ID: <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
In-Reply-To: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
Subject: [PATCH v2 0/4] Add regmap_field helpers for simple bit operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122679ddfae04c50b5b33a6dca3600004477de8be21dc9306b7d1a0f2b80457038f61e60c8282682:zu08011227d64192b8e6f9589b71d11c610000c79bf4f25f6fa4ca04288fd5a467da0b9525b5b9612b2ba4de:rf0801122c8ab4b92b865059789a955cd900009791a4b0c70d2d1d6a9c8ab15d12e8f8f7024cd3f1bb54c7d5c6c55947f8:ZohoMail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

This series proposes to add simple bit operations for setting, clearing
and testing specific bits with regmap_field.

Li Chen (4):
  regmap: provide regmap_field helpers for simple bit operations
  ASoC: sunxi: Use {regmap/regmap_field}_{set/clear}_bits helpers
  pinctrl: bcm: Use regmap_field_{set/clear}_bits helpers
  pinctrl: st: Switch to use regmap_field_test_bits

Changelogs:
v2: fix regmap_field_test_bits compile error in drivers/pinctrl/pinctrl-st.c

 drivers/base/regmap/regmap.c          | 22 ++++++++
 drivers/pinctrl/bcm/pinctrl-bcm6358.c |  2 +-
 drivers/pinctrl/pinctrl-st.c          | 23 ++++----
 include/linux/regmap.h                | 37 +++++++++++++
 sound/soc/sunxi/sun4i-codec.c         | 78 +++++++++++----------------
 5 files changed, 99 insertions(+), 63 deletions(-)

-- 
2.36.1


