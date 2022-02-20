Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270644BCF95
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiBTPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:49:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbiBTPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:49:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9096C532D2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:05 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qx21so26875664ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXWkUCOam5DNv4E6wTMBoogFAVwI0cIVhZM2na4fJgA=;
        b=mtImQpHEx86uqnWxdQ0PqfY0vygneLhldx924GSLvq36VlEkuiZ81yXhLqW0/ofFRi
         /0tamkzK9cv26VUmezQ3LlX16A6KXhnn8TPnCY/Ms9fkGI+R7WfEDYJpiiSg3ZquIqj4
         REVrBgPuUTr0OBaQhgkIJNUV1nssa37fj1vtevnqywCUo9REq78tE84jd/SakHVpPvlr
         KtrMtMlt12FRinzcRO9qx0rPiTsCeQTVf6A2UaxwE0Ci4iAD2tnKG7ZqlfgaDZQ3Ho98
         O1SpTCsETD7DbFVdFNBSwqx82brANRDnBYilThNv7FefucN+lRDGuON/31gh5L+gLfJa
         kZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXWkUCOam5DNv4E6wTMBoogFAVwI0cIVhZM2na4fJgA=;
        b=XjWprij2a+VyWbaiMdiNnGPKPBGUuJgahiLU14H1FlV2HTtfOs6B9xjWWxKc9I+oWg
         t5SFo3BAk5OwIAItRLpqkYVXrmCnrNSBzM6ZRk9VDGwLx+/jvSXjhUF3o8HiJnddxkPz
         RHObBWSY9ZajQKKRITXTGCtriVwGE0W5QopjHnIfH41nWOVF4uYoHwlxodw4dRpCp99z
         CP2Z11xQbyfg51tHPkeKE+ItSOdHrnhw2VupDF5Kc5hbsbZz9zYVaOWvDXO+7/z0jCIO
         AvYvyXD0qxGSp0gNNd6F3vfbzETPvsh1G/Qj6cW14Yxmk0b5TtVBhoqOh8TbihlFQQ9A
         VswQ==
X-Gm-Message-State: AOAM531Oh55eQX01n8T6mMBCdxehPmCriapmyJf3vIc6Y1wL9QtC5X9Z
        wELS0L1Xosp5pbcucmT/YgeXV06+584=
X-Google-Smtp-Source: ABdhPJw4p4xCogA3E/+PYwGpEybaM8V8Sf/TLR1wh8jgUnG3vMiuCdy6l9yXLJNzA6Hg7MGTkNA89Q==
X-Received: by 2002:a17:906:d41:b0:6ce:78b0:8113 with SMTP id r1-20020a1709060d4100b006ce78b08113mr13281771ejh.357.1645372144149;
        Sun, 20 Feb 2022 07:49:04 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id ew6sm4178979ejc.217.2022.02.20.07.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:49:03 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: remove 5 GHz channels from ch_freq_map
Date:   Sun, 20 Feb 2022 16:48:45 +0100
Message-Id: <20220220154847.7521-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220154847.7521-1-straube.linux@gmail.com>
References: <20220220154847.7521-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for chips that operate only in the 2.4 GHz band.
Frequencies for 5 GHz channels can be removed from the ch_freq_map
array.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_rf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index e704092d31d0..51425971782b 100644
--- a/drivers/staging/r8188eu/core/rtw_rf.c
+++ b/drivers/staging/r8188eu/core/rtw_rf.c
@@ -17,22 +17,6 @@ static struct ch_freq ch_freq_map[] = {
 	{1, 2412}, {2, 2417}, {3, 2422}, {4, 2427}, {5, 2432},
 	{6, 2437}, {7, 2442}, {8, 2447}, {9, 2452}, {10, 2457},
 	{11, 2462}, {12, 2467}, {13, 2472}, {14, 2484},
-	/*  UNII */
-	{36, 5180}, {40, 5200}, {44, 5220}, {48, 5240}, {52, 5260},
-	{56, 5280}, {60, 5300}, {64, 5320}, {149, 5745}, {153, 5765},
-	{157, 5785}, {161, 5805}, {165, 5825}, {167, 5835}, {169, 5845},
-	{171, 5855}, {173, 5865},
-	/* HiperLAN2 */
-	{100, 5500}, {104, 5520}, {108, 5540}, {112, 5560}, {116, 5580},
-	{120, 5600}, {124, 5620}, {128, 5640}, {132, 5660}, {136, 5680},
-	{140, 5700},
-	/* Japan MMAC */
-	{34, 5170}, {38, 5190}, {42, 5210}, {46, 5230},
-	/*  Japan */
-	{184, 4920}, {188, 4940}, {192, 4960}, {196, 4980},
-	{208, 5040},/* Japan, means J08 */
-	{212, 5060},/* Japan, means J12 */
-	{216, 5080},/* Japan, means J16 */
 };
 
 static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
-- 
2.35.1

