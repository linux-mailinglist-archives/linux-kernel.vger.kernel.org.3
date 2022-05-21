Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5352FD69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355296AbiEUOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbiEUOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:41:43 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10027FCB
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653143152; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KzRBCy6nuN+o2hvX7VXDJYETFntHoCoojNrRM9VSaWwbLoJ9MXDEdlf8JHmEXhDDbxR4NEbm+rfp9B42SUpwXHGFQZkLxuLbtFwdVgEfdmuSuCPQa+DXNHlDFkEHzRDbsuV3MrlpWhSVOfHHR2N9G0aIwz8ibqEb84nLnkJb8Oc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653143152; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=0o0p0h8Ax2NeemybyRFKBFg4kvyShrFo2MI2nwUZclc=; 
        b=Re3TrzM22+rPOUwA+O9juEp/XlETyA3TKyqOn/YZLPKPAhl1zFUXLTNiizMsVbDrCCkwyVv3bbxvEGxi3GaK59c6PsVn208gOpSIpi6VgpvX8PVaieeO7d86HYRU1Oqsagcgye+D2+2Fhxe9B5vdu2CnfHKKVbzZgIodGwd3I4s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653143152;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=0o0p0h8Ax2NeemybyRFKBFg4kvyShrFo2MI2nwUZclc=;
        b=FdrzD73CjWTFt+Hm6uB92L3xR+23nGpXxmDcny9Bndgv3qZdnMfCtJJQjhpKy2jI
        8rfjSjMR6bNcNl3+BlMnB3ERdEzUZkkK3koWlNJUricaT74b1ZuwbB5O+k1VV6Y7fmE
        fdw/lv4jNHtD20YoNce1xh8g9DlSDhCKXlhN5Qj4=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653143150983181.57000929052094; Sat, 21 May 2022 07:25:50 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sat, 21 May 2022 07:25:50 -0700 (PDT)
Date:   Sat, 21 May 2022 07:25:50 -0700
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
Message-ID: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
In-Reply-To: 
Subject: [PATCH 0/4] Add regmap_field helpers for simple bit operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226a0c92b0a8773c6508a06de8b0000498615caf2de6adef463dc6ad000c21eec5ddab3dbd9b221:zu08011227b19d2d40d37a8becfd63841c000034b6705f54b48ba1b5a2a1cf7cf960982e0544e860dd55949e:rf0801122c239725de1f0a6682d775822a000055882629dd4d26703f9f0ac12d296c5a81d1c3193b491674a3fa194ae69f:ZohoMail
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

 drivers/base/regmap/regmap.c          | 22 ++++++++
 drivers/pinctrl/bcm/pinctrl-bcm6358.c |  2 +-
 drivers/pinctrl/pinctrl-st.c          | 23 ++++----
 include/linux/regmap.h                | 37 +++++++++++++
 sound/soc/sunxi/sun4i-codec.c         | 78 +++++++++++----------------
 5 files changed, 99 insertions(+), 63 deletions(-)

-- 
2.36.1


