Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30706530806
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiEWD1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiEWD1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:27:50 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1931DC5;
        Sun, 22 May 2022 20:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653276382; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fkmQofsjO+98dyFjLpGMGHm1rCncUDAyVURj/wuCa1Lwf4gfnPPWTJ4eVbyKW+T1GP1bn8lPJqJuksKgyv6s1m5bCVeY55DIqpZnA+fdVNXc0W5AIiIAK98u8YfinXmuR8RSkoGhcLi0MzAz10cd5ApLkdCLkVHGmaOIY22nk6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653276382; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=C742maqsDCBLsWwyHCaXutaNY0ihb9hU+CWHxStgtiQ=; 
        b=Uf9nSk3CbEfQlRubo7rS6lacSEy/SmD9PRx31jpTNojQlCi8J9GTI+UHJE1QS3jXHPBNqOO8QmHqYGVoZ7IdlSpBV91qsNgerfOAbMA8q9LKv7wzi/Afzbc6UuqpnOPZLs+pOTRCpl0Ag+tc5UG93/xEIGSxEPUSwHvk6qhctk8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653276382;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=C742maqsDCBLsWwyHCaXutaNY0ihb9hU+CWHxStgtiQ=;
        b=MuiXSWXaQblyXU7N2UOjDIDgh3hROh2SwxbZzygJZAqpm9FQVDs571CiXWFBwNCn
        LlFwrsPCP/x3657WxjDPscduScjNo/YjyoEpFeQOBi528cGFUdUJjNJn253VRcBI+LO
        3AE639LQvAyyIzj3R8aN2Og7se3E1wHPiznkfzfg=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653276381726254.10901340424653; Sun, 22 May 2022 20:26:21 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 20:26:21 -0700 (PDT)
Date:   Sun, 22 May 2022 20:26:21 -0700
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
Message-ID: <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
In-Reply-To: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
Subject: [PATCH v3 0/4] Add regmap_field helpers for simple bit operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122609b6495b0c41cf82ced2a6ad0000f903c0e7190508f10076ffa5cdb32a023e35d13ed8b5d0ab:zu08011227bd8716150e3321602f2377d5000022b88056309117e13cdd01d78586ed1f8e0a64231e3faced36:rf0801122cc6807eb4e9570bc3e723b81f0000ff2f6e76105ff9bb52a1afb89282b1e4a8b4dd0f7d4d1861ae81fe261e2c:ZohoMail
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
v3: fix regmap_field_clear_bits and regmap_field_set_bits implementation,
    reported by Samuel Holland

 drivers/base/regmap/regmap.c          | 22 ++++++++
 drivers/pinctrl/bcm/pinctrl-bcm6358.c |  2 +-
 drivers/pinctrl/pinctrl-st.c          | 23 ++++----
 include/linux/regmap.h                | 37 +++++++++++++
 sound/soc/sunxi/sun4i-codec.c         | 78 +++++++++++----------------
 5 files changed, 99 insertions(+), 63 deletions(-)

-- 
2.36.1


