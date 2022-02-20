Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CBD4BCF93
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbiBTPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:49:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbiBTPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:49:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE4532D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:06 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so26968317ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTYsVbDSvOAH4QYIkGgRDagMrOUXfFeihf5F3hcHwp0=;
        b=JEkHopJZKie/5DpEOnlLTQV+KtGhmNVl3cJqcA0CZGOZErKJxZvqO3g3aK6DHFuetW
         giGTYma2wCdU7kOlbDPI5FziKoLV4ukFcPnKy25N5PKSmZHKhBjN3aZ/m84nFwITAa98
         MhbGTXcAi/C1z3l1WMYeB8VTeYm7vzHvuU2seJX29IH3/NjBjhvqw8cfHNlanrai3C9B
         +UOZJ85ITqFLAqqs4lADjzCO+FNI6WRoiXwklnkTP2oG2Q67n9uwBKLOZmJZQ82GaAHB
         QTqOBElNBjhMChfMUTcFHm+RSP9wLcSx0uqoFVeSvNrfWWCINHgjkqM0iNi19sR9zwly
         v3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTYsVbDSvOAH4QYIkGgRDagMrOUXfFeihf5F3hcHwp0=;
        b=fNccwCiBi9TbBIYC97QNHtx8bUMYDdKLbRyoyzn0G1/s6ot0zO2zzvO0RXzGxO6XBz
         Qs897Vrs2oaATxvplgqhqfSALTWjZBAZtgtzcSsAIVWRZGTLnRItTCUZbhpsJp1PEFym
         anW0zPXhJ+3GKEcFWv3KNRz/LEz/uHt5lmyiqjF40gYey9dC/S+QB3FzXelD/fEgmg5M
         7gYv9wRxhwTxbzhuLRIaXWHnTM1IUoxYbS50Ce3mwlBmcQEV+1EpWWZ/RONp0aDFxxgh
         cgUajKpJleXoZUuHMIWY5GFce8PQPZYedvyJIMVwnMzCjCH9BNwmT4Auhcw3cBjqwFBt
         mBJg==
X-Gm-Message-State: AOAM533n8b1umprW8HrR40qGB7i0pb3j2LWSvrjaTLrN86r7vwzg2wQv
        1fY4NNyVMDEQpj1fKcOXmIo=
X-Google-Smtp-Source: ABdhPJxdPwhPAac2wjri7r1WjHPjTNs0Zti2xNCwFgEFycMioLNm+X7124lC2XdcWXYkGpElccuBRg==
X-Received: by 2002:a17:906:538f:b0:6ce:98ad:3100 with SMTP id g15-20020a170906538f00b006ce98ad3100mr13288782ejo.566.1645372144858;
        Sun, 20 Feb 2022 07:49:04 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id ew6sm4178979ejc.217.2022.02.20.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:49:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: refactor rtw_ch2freq()
Date:   Sun, 20 Feb 2022 16:48:46 +0100
Message-Id: <20220220154847.7521-3-straube.linux@gmail.com>
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

Since we have only channel values from 1 to 14 we can convert the
array ch_freq_map to a simple integer array and use the indices as
channel numbers. This simplifies the code and avoids looping through
the array to get the frequency.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_rf.c | 40 +++++++++++----------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index 51425971782b..945a40e6511a 100644
--- a/drivers/staging/r8188eu/core/rtw_rf.c
+++ b/drivers/staging/r8188eu/core/rtw_rf.c
@@ -8,32 +8,24 @@
 #include "../include/recv_osdep.h"
 #include "../include/xmit_osdep.h"
 
-struct ch_freq {
-	u32 channel;
-	u32 frequency;
+static const u32 ch_freq_map[] = {
+	2412,
+	2417,
+	2422,
+	2427,
+	2432,
+	2437,
+	2442,
+	2447,
+	2452,
+	2457,
+	2462,
+	2467,
+	2472,
+	2484
 };
 
-static struct ch_freq ch_freq_map[] = {
-	{1, 2412}, {2, 2417}, {3, 2422}, {4, 2427}, {5, 2432},
-	{6, 2437}, {7, 2442}, {8, 2447}, {9, 2452}, {10, 2457},
-	{11, 2462}, {12, 2467}, {13, 2472}, {14, 2484},
-};
-
-static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
-
 u32 rtw_ch2freq(u32 channel)
 {
-	u8	i;
-	u32	freq = 0;
-
-	for (i = 0; i < ch_freq_map_num; i++) {
-		if (channel == ch_freq_map[i].channel) {
-			freq = ch_freq_map[i].frequency;
-				break;
-		}
-	}
-	if (i == ch_freq_map_num)
-		freq = 2412;
-
-	return freq;
+	return ch_freq_map[channel - 1];
 }
-- 
2.35.1

