Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBB4CE736
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiCEVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiCEVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:33:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A25D65B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:32:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so8541538wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 13:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uOr8Mm2UMX8CYmOmgKbBBZx5cvoPs1qxS2PxBA8vz4k=;
        b=QzL5nxH9hFMfqcHPu6yJ0qyG/eQiu/Qk1vAswl3BIRmkKXUdLiWlWmT8xcCnUXMaeY
         lxQW2ll349eSEqNWjN7uAyJtKVGK+2gbhDkW7vBPm84Y6QzXHT2yvw167Grz/d3S8sas
         eV8Qq8uzh6JFje9aMOG2DipI80KI2DvgaLjjrMA4/vO7rwgRXsdedtcbI8aLRezk57fw
         JDJSDu+EYp8rMdnepRo6+QsU3rKh9P5OvINWS8rPh4jRAFVxr/21rjpvFdIdTk5LgV9E
         pEdL48lfg0TWhuEv9ZtUn+mJvZpwCIVppjGSZWrLYkkYOmOcG0L0HwIj0MjYCc3EXWSk
         2vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uOr8Mm2UMX8CYmOmgKbBBZx5cvoPs1qxS2PxBA8vz4k=;
        b=6tsqs7ctURJyy088pCNVr4tfYDD/xgIS2bjAqzjLmAnv7jJeqllJ8lOpqkEAvuNUHi
         GdyoayKuPMgNG8rEvsSrdLbvrlVyKCqjcEWn1IofnpcGQ/wiE+8YbEpzCPS7MNZnGfDB
         TCtNQpMhvpOAP3uJT2oY22eZP+9a4jngwF8GfMPFBIuJXsufoD5q34bKWmiZsPlSLo2Q
         VEKWWSVhfOnldIDK/raqbe1TDaxFAjvrAdNxlLbNIPMUVhsEU65V0UIJx/Uav70ApG//
         l0uUlfeFbn6n5QbLNmpPNLasTYsdte2HfL3h+mPAMne1ZQxpavpxL/sakcW1HULySvCo
         UVvg==
X-Gm-Message-State: AOAM532UIqCfe9/xq3kS4DQuuQc0stukWHubFOc+jWJhVkrzUZsUHPcL
        8ZHE1aerJOsfe/CSs5s6lkI=
X-Google-Smtp-Source: ABdhPJyDxP/+0SHUzahPGF2vPJcSIz/SqBrSQ/zZfE1XMLt7nZfp7102pxcssHtBhpYP41xd7nXobw==
X-Received: by 2002:a05:600c:5105:b0:381:811a:ce1c with SMTP id o5-20020a05600c510500b00381811ace1cmr3559375wms.109.1646515936238;
        Sat, 05 Mar 2022 13:32:16 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id az32-20020a05600c602000b00381892f346dsm18837806wmb.2.2022.03.05.13.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 13:32:15 -0800 (PST)
Date:   Sat, 5 Mar 2022 22:32:14 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: vt6655: Remove unused byRFType in rf.c
Message-ID: <640bdbc0ff135c6a63d6764fd81a8bb24d5053dd.1646512837.git.philipp.g.hortmann@gmail.com>
References: <cover.1646512837.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646512837.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove byRFType that support 5GHz band.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/rf.c | 404 +-----------------------------------
 1 file changed, 1 insertion(+), 403 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index ba7056f5a5da..4498c9d400f2 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -152,333 +152,6 @@ static unsigned long al2230_power_table[AL2230_PWR_IDX_LEN] = {
 	0x0407F900 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW
 };
 
-/* 40MHz reference frequency
- * Need to Pull PLLON(PE3) low when writing channel registers through 3-wire.
- */
-static const unsigned long al7230_init_table[CB_AL7230_INIT_SEQ] = {
-	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel1 // Need modify for 11a */
-	0x13333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel1 // Need modify for 11a */
-	0x841FF200 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11a: 451FE2 */
-	0x3FDFA300 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11a: 5FDFA3 */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* 11b/g    // Need modify for 11a */
-	/* RoberYu:20050113, Rev0.47 Register Setting Guide */
-	0x802B5500 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11a: 8D1B55 */
-	0x56AF3600 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0xCE020700 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11a: 860207 */
-	0x6EBC0800 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0x221BB900 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0xE0000A00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11a: E0600A */
-	0x08031B00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* init 0x080B1B00 => 0x080F1B00 for 3 wire control TxGain(D10) */
-	/* RoberYu:20050113, Rev0.47 Register Setting Guide */
-	0x000A3C00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11a: 00143C */
-	0xFFFFFD00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0x00000E00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0x1ABA8F00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* Need modify for 11a: 12BACF */
-};
-
-static const unsigned long al7230_init_table_a_mode[CB_AL7230_INIT_SEQ] = {
-	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel184 // Need modify for 11b/g */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel184 // Need modify for 11b/g */
-	0x451FE200 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11b/g */
-	0x5FDFA300 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11b/g */
-	0x67F78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* 11a    // Need modify for 11b/g */
-	0x853F5500 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11b/g, RoberYu:20050113 */
-	0x56AF3600 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0xCE020700 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11b/g */
-	0x6EBC0800 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0x221BB900 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0xE0600A00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11b/g */
-	0x08031B00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* init 0x080B1B00 => 0x080F1B00 for 3 wire control TxGain(D10) */
-	0x00147C00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11b/g */
-	0xFFFFFD00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0x00000E00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW,
-	0x12BACF00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* Need modify for 11b/g */
-};
-
-static const unsigned long al7230_channel_table0[CB_MAX_CHANNEL] = {
-	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  1, Tf = 2412MHz */
-	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  2, Tf = 2417MHz */
-	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  3, Tf = 2422MHz */
-	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  4, Tf = 2427MHz */
-	0x0037A000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  5, Tf = 2432MHz */
-	0x0037A000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  6, Tf = 2437MHz */
-	0x0037A000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  7, Tf = 2442MHz */
-	0x0037A000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  8, Tf = 2447MHz //RobertYu: 20050218, update for APNode 0.49 */
-	0x0037B000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  9, Tf = 2452MHz //RobertYu: 20050218, update for APNode 0.49 */
-	0x0037B000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 10, Tf = 2457MHz //RobertYu: 20050218, update for APNode 0.49 */
-	0x0037B000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 11, Tf = 2462MHz //RobertYu: 20050218, update for APNode 0.49 */
-	0x0037B000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 12, Tf = 2467MHz //RobertYu: 20050218, update for APNode 0.49 */
-	0x0037C000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 13, Tf = 2472MHz //RobertYu: 20050218, update for APNode 0.49 */
-	0x0037C000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 14, Tf = 2484MHz */
-
-	/* 4.9G => Ch 183, 184, 185, 187, 188, 189, 192, 196  (Value:15 ~ 22) */
-	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 183, Tf = 4915MHz (15) */
-	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 184, Tf = 4920MHz (16) */
-	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 185, Tf = 4925MHz (17) */
-	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 187, Tf = 4935MHz (18) */
-	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 188, Tf = 4940MHz (19) */
-	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 189, Tf = 4945MHz (20) */
-	0x0FF53000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 192, Tf = 4960MHz (21) */
-	0x0FF53000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 196, Tf = 4980MHz (22) */
-
-	/* 5G => Ch 7, 8, 9, 11, 12, 16, 34, 36, 38, 40, 42, 44, 46, 48, 52, 56, 60, 64,
-	 * 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 149, 153, 157, 161, 165  (Value 23 ~ 56)
-	 */
-
-	0x0FF54000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   7, Tf = 5035MHz (23) */
-	0x0FF54000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   8, Tf = 5040MHz (24) */
-	0x0FF54000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   9, Tf = 5045MHz (25) */
-	0x0FF54000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  11, Tf = 5055MHz (26) */
-	0x0FF54000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  12, Tf = 5060MHz (27) */
-	0x0FF55000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  16, Tf = 5080MHz (28) */
-	0x0FF56000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  34, Tf = 5170MHz (29) */
-	0x0FF56000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  36, Tf = 5180MHz (30) */
-	0x0FF57000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  38, Tf = 5190MHz (31) //RobertYu: 20050218, update for APNode 0.49 */
-	0x0FF57000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  40, Tf = 5200MHz (32) */
-	0x0FF57000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  42, Tf = 5210MHz (33) */
-	0x0FF57000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  44, Tf = 5220MHz (34) */
-	0x0FF57000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  46, Tf = 5230MHz (35) */
-	0x0FF57000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  48, Tf = 5240MHz (36) */
-	0x0FF58000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  52, Tf = 5260MHz (37) */
-	0x0FF58000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  56, Tf = 5280MHz (38) */
-	0x0FF58000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  60, Tf = 5300MHz (39) */
-	0x0FF59000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  64, Tf = 5320MHz (40) */
-
-	0x0FF5C000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 100, Tf = 5500MHz (41) */
-	0x0FF5C000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 104, Tf = 5520MHz (42) */
-	0x0FF5C000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 108, Tf = 5540MHz (43) */
-	0x0FF5D000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 112, Tf = 5560MHz (44) */
-	0x0FF5D000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 116, Tf = 5580MHz (45) */
-	0x0FF5D000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 120, Tf = 5600MHz (46) */
-	0x0FF5E000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 124, Tf = 5620MHz (47) */
-	0x0FF5E000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 128, Tf = 5640MHz (48) */
-	0x0FF5E000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 132, Tf = 5660MHz (49) */
-	0x0FF5F000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 136, Tf = 5680MHz (50) */
-	0x0FF5F000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 140, Tf = 5700MHz (51) */
-	0x0FF60000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 149, Tf = 5745MHz (52) */
-	0x0FF60000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 153, Tf = 5765MHz (53) */
-	0x0FF60000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 157, Tf = 5785MHz (54) */
-	0x0FF61000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 161, Tf = 5805MHz (55) */
-	0x0FF61000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* channel = 165, Tf = 5825MHz (56) */
-};
-
-static const unsigned long al7230_channel_table1[CB_MAX_CHANNEL] = {
-	0x13333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  1, Tf = 2412MHz */
-	0x1B333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  2, Tf = 2417MHz */
-	0x03333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  3, Tf = 2422MHz */
-	0x0B333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  4, Tf = 2427MHz */
-	0x13333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  5, Tf = 2432MHz */
-	0x1B333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  6, Tf = 2437MHz */
-	0x03333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  7, Tf = 2442MHz */
-	0x0B333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  8, Tf = 2447MHz */
-	0x13333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  9, Tf = 2452MHz */
-	0x1B333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 10, Tf = 2457MHz */
-	0x03333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 11, Tf = 2462MHz */
-	0x0B333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 12, Tf = 2467MHz */
-	0x13333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 13, Tf = 2472MHz */
-	0x06666100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 14, Tf = 2484MHz */
-
-	/* 4.9G => Ch 183, 184, 185, 187, 188, 189, 192, 196  (Value:15 ~ 22) */
-	0x1D555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 183, Tf = 4915MHz (15) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 184, Tf = 4920MHz (16) */
-	0x02AAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 185, Tf = 4925MHz (17) */
-	0x08000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 187, Tf = 4935MHz (18) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 188, Tf = 4940MHz (19) */
-	0x0D555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 189, Tf = 4945MHz (20) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 192, Tf = 4960MHz (21) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 196, Tf = 4980MHz (22) */
-
-	/* 5G => Ch 7, 8, 9, 11, 12, 16, 34, 36, 38, 40, 42, 44, 46, 48, 52, 56, 60, 64,
-	 * 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 149, 153, 157, 161, 165  (Value 23 ~ 56)
-	 */
-	0x1D555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   7, Tf = 5035MHz (23) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   8, Tf = 5040MHz (24) */
-	0x02AAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   9, Tf = 5045MHz (25) */
-	0x08000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  11, Tf = 5055MHz (26) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  12, Tf = 5060MHz (27) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  16, Tf = 5080MHz (28) */
-	0x05555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  34, Tf = 5170MHz (29) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  36, Tf = 5180MHz (30) */
-	0x10000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  38, Tf = 5190MHz (31) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  40, Tf = 5200MHz (32) */
-	0x1AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  42, Tf = 5210MHz (33) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  44, Tf = 5220MHz (34) */
-	0x05555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  46, Tf = 5230MHz (35) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  48, Tf = 5240MHz (36) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  52, Tf = 5260MHz (37) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  56, Tf = 5280MHz (38) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  60, Tf = 5300MHz (39) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  64, Tf = 5320MHz (40) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 100, Tf = 5500MHz (41) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 104, Tf = 5520MHz (42) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 108, Tf = 5540MHz (43) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 112, Tf = 5560MHz (44) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 116, Tf = 5580MHz (45) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 120, Tf = 5600MHz (46) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 124, Tf = 5620MHz (47) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 128, Tf = 5640MHz (48) */
-	0x0AAAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 132, Tf = 5660MHz (49) */
-	0x15555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 136, Tf = 5680MHz (50) */
-	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 140, Tf = 5700MHz (51) */
-	0x18000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 149, Tf = 5745MHz (52) */
-	0x02AAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 153, Tf = 5765MHz (53) */
-	0x0D555100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 157, Tf = 5785MHz (54) */
-	0x18000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 161, Tf = 5805MHz (55) */
-	0x02AAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* channel = 165, Tf = 5825MHz (56) */
-};
-
-static const unsigned long al7230_channel_table2[CB_MAX_CHANNEL] = {
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  1, Tf = 2412MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  2, Tf = 2417MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  3, Tf = 2422MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  4, Tf = 2427MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  5, Tf = 2432MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  6, Tf = 2437MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  7, Tf = 2442MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  8, Tf = 2447MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  9, Tf = 2452MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 10, Tf = 2457MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 11, Tf = 2462MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 12, Tf = 2467MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 13, Tf = 2472MHz */
-	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 14, Tf = 2484MHz */
-
-	/* 4.9G => Ch 183, 184, 185, 187, 188, 189, 192, 196  (Value:15 ~ 22) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 183, Tf = 4915MHz (15) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 184, Tf = 4920MHz (16) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 185, Tf = 4925MHz (17) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 187, Tf = 4935MHz (18) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 188, Tf = 4940MHz (19) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 189, Tf = 4945MHz (20) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 192, Tf = 4960MHz (21) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 196, Tf = 4980MHz (22) */
-
-	/* 5G => Ch 7, 8, 9, 11, 12, 16, 34, 36, 38, 40, 42, 44, 46, 48, 52, 56, 60, 64,
-	 * 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 149, 153, 157, 161, 165  (Value 23 ~ 56)
-	 */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   7, Tf = 5035MHz (23) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   8, Tf = 5040MHz (24) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =   9, Tf = 5045MHz (25) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  11, Tf = 5055MHz (26) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  12, Tf = 5060MHz (27) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  16, Tf = 5080MHz (28) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  34, Tf = 5170MHz (29) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  36, Tf = 5180MHz (30) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  38, Tf = 5190MHz (31) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  40, Tf = 5200MHz (32) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  42, Tf = 5210MHz (33) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  44, Tf = 5220MHz (34) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  46, Tf = 5230MHz (35) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  48, Tf = 5240MHz (36) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  52, Tf = 5260MHz (37) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  56, Tf = 5280MHz (38) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  60, Tf = 5300MHz (39) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  64, Tf = 5320MHz (40) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 100, Tf = 5500MHz (41) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 104, Tf = 5520MHz (42) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 108, Tf = 5540MHz (43) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 112, Tf = 5560MHz (44) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 116, Tf = 5580MHz (45) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 120, Tf = 5600MHz (46) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 124, Tf = 5620MHz (47) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 128, Tf = 5640MHz (48) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 132, Tf = 5660MHz (49) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 136, Tf = 5680MHz (50) */
-	0x67D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 140, Tf = 5700MHz (51) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 149, Tf = 5745MHz (52) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 153, Tf = 5765MHz (53) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 157, Tf = 5785MHz (54) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 161, Tf = 5805MHz (55) */
-	0x77D78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* channel = 165, Tf = 5825MHz (56) */
-};
-
-/*
- * Description: AIROHA IFRF chip init function
- *
- * Parameters:
- *  In:
- *      iobase      - I/O base address
- *  Out:
- *      none
- *
- * Return Value: true if succeeded; false if failed.
- *
- */
-static bool s_bAL7230Init(struct vnt_private *priv)
-{
-	void __iomem *iobase = priv->port_offset;
-	int     ii;
-	bool ret;
-
-	ret = true;
-
-	/* 3-wire control for normal mode */
-	VNSvOutPortB(iobase + MAC_REG_SOFTPWRCTL, 0);
-
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPECTI  |
-							 SOFTPWRCTL_TXPEINV));
-	bb_power_save_mode_off(priv); /* RobertYu:20050106, have DC value for Calibration */
-
-	for (ii = 0; ii < CB_AL7230_INIT_SEQ; ii++)
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[ii]);
-
-	/* PLL On */
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
-
-	/* Calibration */
-	MACvTimer0MicroSDelay(priv, 150);/* 150us */
-	/* TXDCOC:active, RCK:disable */
-	ret &= IFRFbWriteEmbedded(priv, (0x9ABA8F00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW));
-	MACvTimer0MicroSDelay(priv, 30);/* 30us */
-	/* TXDCOC:disable, RCK:active */
-	ret &= IFRFbWriteEmbedded(priv, (0x3ABA8F00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW));
-	MACvTimer0MicroSDelay(priv, 30);/* 30us */
-	/* TXDCOC:disable, RCK:disable */
-	ret &= IFRFbWriteEmbedded(priv, al7230_init_table[CB_AL7230_INIT_SEQ - 1]);
-
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPE3    |
-							 SOFTPWRCTL_SWPE2    |
-							 SOFTPWRCTL_SWPECTI  |
-							 SOFTPWRCTL_TXPEINV));
-
-	bb_power_save_mode_on(priv); /* RobertYu:20050106 */
-
-	/* PE1: TX_ON, PE2: RX_ON, PE3: PLLON */
-	/* 3-wire control for power saving mode */
-	VNSvOutPortB(iobase + MAC_REG_PSPWRSIG, (PSSIG_WPE3 | PSSIG_WPE2)); /* 1100 0000 */
-
-	return ret;
-}
-
-/* Need to Pull PLLON low when writing channel registers through
- * 3-wire interface
- */
-static bool s_bAL7230SelectChannel(struct vnt_private *priv, unsigned char byChannel)
-{
-	void __iomem *iobase = priv->port_offset;
-	bool ret;
-
-	ret = true;
-
-	/* PLLON Off */
-	MACvWordRegBitsOff(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
-
-	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table0[byChannel - 1]);
-	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table1[byChannel - 1]);
-	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table2[byChannel - 1]);
-
-	/* PLLOn On */
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
-
-	/* Set Channel[7] = 0 to tell H/W channel is changing now. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel & 0x7F));
-	MACvTimer0MicroSDelay(priv, SWITCH_CHANNEL_DELAY_AL7230);
-	/* Set Channel[7] = 1 to tell H/W channel change is done. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel | 0x80));
-
-	return ret;
-}
-
 /*
  * Description: Write to IF/RF, by embedded programming
  *
@@ -612,10 +285,6 @@ bool RFbInit(struct vnt_private *priv)
 		priv->max_pwr_level = AL2230_PWR_IDX_LEN;
 		ret = RFbAL2230Init(priv);
 		break;
-	case RF_AIROHA7230:
-		priv->max_pwr_level = AL7230_PWR_IDX_LEN;
-		ret = s_bAL7230Init(priv);
-		break;
 	case RF_NOTHING:
 		ret = true;
 		break;
@@ -650,10 +319,6 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
 		ret = RFbAL2230SelectChannel(priv, byChannel);
 		break;
 		/*{{ RobertYu: 20050104 */
-	case RF_AIROHA7230:
-		ret = s_bAL7230SelectChannel(priv, byChannel);
-		break;
-		/*}} RobertYu */
 	case RF_NOTHING:
 		ret = true;
 		break;
@@ -684,7 +349,6 @@ bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
 	unsigned char init_count = 0;
 	unsigned char sleep_count = 0;
 	unsigned short idx = MISCFIFO_SYNDATA_IDX;
-	const unsigned long *init_table;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
 	switch (rf_type) {
@@ -706,20 +370,6 @@ bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
-	case RF_AIROHA7230:
-		 /* Init Reg + Channel Reg (3) */
-		init_count = CB_AL7230_INIT_SEQ + 3;
-		sleep_count = 0;
-
-		init_table = (channel <= CB_MAX_CHANNEL_24G) ?
-			al7230_init_table : al7230_init_table_a_mode;
-		for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-			MACvSetMISCFifo(priv, idx++, init_table[i]);
-
-		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
-		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
-		MACvSetMISCFifo(priv, idx++, al7230_channel_table2[channel - 1]);
-		break;
 
 	case RF_NOTHING:
 		return true;
@@ -773,10 +423,7 @@ bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH)
 	case RATE_12M:
 	case RATE_18M:
 		byPwr = priv->abyOFDMPwrTbl[uCH];
-		if (priv->byRFType == RF_UW2452)
-			byDec = byPwr + 14;
-		else
-			byDec = byPwr + 10;
+		byDec = byPwr + 10;
 
 		if (byDec >= priv->max_pwr_level)
 			byDec = priv->max_pwr_level - 1;
@@ -819,7 +466,6 @@ bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 		    unsigned int rate)
 {
 	bool ret = true;
-	unsigned long dwMax7230Pwr = 0;
 
 	if (byPwr >= priv->max_pwr_level)
 		return false;
@@ -846,16 +492,6 @@ bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 
 		break;
 
-	case RF_AIROHA7230:
-		/* 0x080F1B00 for 3 wire control TxGain(D10)
-		 * and 0x31 as TX Gain value
-		 */
-		dwMax7230Pwr = 0x080C0B00 | ((byPwr) << 12) |
-			(BY_AL7230_REG_LEN << 3)  | IFREGCTL_REGW;
-
-		ret &= IFRFbWriteEmbedded(priv, dwMax7230Pwr);
-		break;
-
 	default:
 		break;
 	}
@@ -888,7 +524,6 @@ RFvRSSITodBm(struct vnt_private *priv, unsigned char byCurrRSSI, long *pldBm)
 	switch (priv->byRFType) {
 	case RF_AIROHA:
 	case RF_AL2230S:
-	case RF_AIROHA7230:
 		a = abyAIROHARF[byIdx];
 		break;
 	default:
@@ -898,40 +533,3 @@ RFvRSSITodBm(struct vnt_private *priv, unsigned char byCurrRSSI, long *pldBm)
 	*pldBm = -1 * (a + b * 2);
 }
 
-/* Post processing for the 11b/g and 11a.
- * for save time on changing Reg2,3,5,7,10,12,15
- */
-bool RFbAL7230SelectChannelPostProcess(struct vnt_private *priv,
-				       u16 byOldChannel,
-				       u16 byNewChannel)
-{
-	bool ret;
-
-	ret = true;
-
-	/* if change between 11 b/g and 11a need to update the following
-	 * register
-	 * Channel Index 1~14
-	 */
-	if ((byOldChannel <= CB_MAX_CHANNEL_24G) && (byNewChannel > CB_MAX_CHANNEL_24G)) {
-		/* Change from 2.4G to 5G [Reg] */
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[2]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[3]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[5]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[7]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[10]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[12]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[15]);
-	} else if ((byOldChannel > CB_MAX_CHANNEL_24G) && (byNewChannel <= CB_MAX_CHANNEL_24G)) {
-		/* Change from 5G to 2.4G [Reg] */
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[2]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[3]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[5]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[7]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[10]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[12]);
-		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[15]);
-	}
-
-	return ret;
-}
-- 
2.25.1

