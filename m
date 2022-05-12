Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A252473C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351140AbiELHoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351099AbiELHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:44:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E41A15E5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:44:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c12so5190146edv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrDbGhLo7XaClO51j9YJvUywtHQ0+/I5lMy5wJbGhKc=;
        b=DiruNwr0imBp+10H53dtlHhIGwryjAwAWWCxLchPrV+5Ds5esyMWKjS3HAq8f4h/7O
         VZ8MmEQaRkIYQ8sFGjoZL7WHBNcERhJ9n5ZHJMUFreePm93eQoOr4FDrKr4sWpp1fB4N
         paupObkAaW1R41KdMj35taLnJ2UhWNnuoOsss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrDbGhLo7XaClO51j9YJvUywtHQ0+/I5lMy5wJbGhKc=;
        b=g6c+atKDr80rO98lI0qqLjxUsbz8wl9J1kM/XjjLWv/MNApjHslreQALfOVfMVBAXT
         Q+2zPu+znH4pov9Hi+Dp2Gat5glipMylWNgTWDHPhCvdpCWt8tITwAJPO+kliZxw2cgn
         EL7ejKJf/0nz8Sdx1oXT/Pl4u5Ksmw0C+7xaxNbS+Q/m8phiRJXkU06WBe/zt1RtJjA3
         Sgdw/3Ec9S5CUiAq8jeYaJ6o0osryGkXjZjvoNXta6pBsiogGR8I2EjoZ8yBjeS5TFl4
         UNf529h4GwDafv05UaJTDAUqqaoiGDxl8PRB6IpxzCl+cOk6KqHqXKWlxMbLVIW8yTXR
         cWyQ==
X-Gm-Message-State: AOAM533UwyrCqVFd6mM/WfzlxlJlTj+lwYZDV+gVbLO+tr3oRh8cq6yT
        OFnKj3Xf9UoJuWpk3uzDgvdmzQ==
X-Google-Smtp-Source: ABdhPJx58tfL7OheWyZCoXsZi7LTgs1k6P5QALJf6eVDOoqqZCFTxJOEZzC3/cKaG5YF/CTWwcEUwg==
X-Received: by 2002:a05:6402:4241:b0:428:177b:5fd with SMTP id g1-20020a056402424100b00428177b05fdmr32950480edb.193.1652341444209;
        Thu, 12 May 2022 00:44:04 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-59-245.cust.vodafonedsl.it. [188.217.59.245])
        by smtp.gmail.com with ESMTPSA id cm10-20020a0564020c8a00b0042617ba63c0sm2192721edb.74.2022.05.12.00.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:44:03 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     tommaso.merciai@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Date:   Thu, 12 May 2022 09:43:58 +0200
Message-Id: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mixer controls support for M98088_REG_4A_CFG_BYPASS register

References:
 - https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf p71, p113

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 sound/soc/codecs/max98088.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 429717d4ac5a..f8ec2f164e08 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -486,6 +486,11 @@ static const struct snd_kcontrol_new max98088_snd_controls[] = {
        SOC_SINGLE("EQ1 Switch", M98088_REG_49_CFG_LEVEL, 0, 1, 0),
        SOC_SINGLE("EQ2 Switch", M98088_REG_49_CFG_LEVEL, 1, 1, 0),
 
+       SOC_SINGLE("SPK Bypass Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0),
+       SOC_SINGLE("REC Bypass Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0),
+       SOC_SINGLE("MIC2 Bypass Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, 0),
+       SOC_SINGLE("INA Bypass Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0),
+
        SOC_ENUM("EX Limiter Mode", max98088_exmode_enum),
        SOC_ENUM("EX Limiter Threshold", max98088_ex_thresh_enum),
 
-- 
2.25.1

