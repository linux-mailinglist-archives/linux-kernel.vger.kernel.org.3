Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3614C4BF3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiBVI3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBVI3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:29:23 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE62156973
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:28:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so40502617ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8Qt+r4eM4DrLuqCbIAtNlNxohCAgIis75bTjKzOeZE=;
        b=krOwPs+UMEImQthUATA625wTEwjSUvuTI8wkMRUv1ltR7DdaxHuV1NViX3I9pN+KQA
         Ysg875Yb2RsOe02fGGFcKdo+Mu4OfkuZWlz+ajY2TYsW6sYyyv0Gm4OUvGhTkK0LKgEU
         IFoLvvqeFfIa0cjeqDyTg5jsfpd/JY6Dqiszn/X/oT75p2T7LGu4+LXLWVLRIK1JbIVw
         MftvvXggpw6yYWL7LEcPe2yHfhd91Ud3zjZ8vHaGvB4N5RJMJcVnOeMVM8GOfdxooabB
         eVGGtr+iaTEq8Jk4YXVmgqvojSOuiESRn1b2Mr4lApexQeSAqV9/Sj7Sm7WIRyBIR5I6
         xUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8Qt+r4eM4DrLuqCbIAtNlNxohCAgIis75bTjKzOeZE=;
        b=IzF+RAHgXIJ8emApyb8/h21VtNXVRBgm+9M0e+1SKMTovsf8NLdIj3iRixRHCCQXIC
         ghzvc65iZiQqBbSnwsBZDU0KmiZA2FN80HS8fjbNocVBDdDK2d4EQ6fex1IRVOxU9EMJ
         iBoI8c2/PYzXzmR6oGCTi45hQt6WywFWRaAS0mnpHBDzP+T/whQAil8yOZt386WCOX8q
         azxRy0/rhbK5FTmr1pJR4XobUbXcOUTK1jtrlb/9k3sUDAuQvy/4FNvdryvq17POsWu3
         fF9fo9TVWqb6S49XH8TAj+DJzNmyLvtdBm8CNZ4Ngf2wjgXdxUBJ3RnKPNk8+iZ+dqng
         h4aQ==
X-Gm-Message-State: AOAM533VXJsuX3ycfPACWWyOP+rCSCdUSiWgJkxBvG+w1j9MoU6kQeZu
        VsL5NvwkX3LxBaEZlipBz6k=
X-Google-Smtp-Source: ABdhPJxEojS2irNC3wsBpceWlVvsHXXxGyj4u0/tHBWP6VE9P+OI1+P9j1Be/tZvOLP6UwpZ+Un6xA==
X-Received: by 2002:a17:907:b96:b0:6d0:ae6:d153 with SMTP id ey22-20020a1709070b9600b006d00ae6d153mr17770616ejc.699.1645518537636;
        Tue, 22 Feb 2022 00:28:57 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id v12sm9831926edr.8.2022.02.22.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 00:28:57 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/3] staging: r8188eu: remove 5 GHz channels from ch_freq_map
Date:   Tue, 22 Feb 2022 09:28:45 +0100
Message-Id: <20220222082847.6687-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222082847.6687-1-straube.linux@gmail.com>
References: <20220222082847.6687-1-straube.linux@gmail.com>
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

According to the Realtek documentation the chips this driver supports
are 2.4 GHz only chips. Frequencies for 5 GHz channels can be removed
from the ch_freq_map array.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
Changed the commit message.

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

