Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0794BF3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiBVI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiBVI3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:29:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A6215678A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:28:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u18so35049481edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0UMhoqvO6ENLxC1LYsXqT72OwTuutJDRaWt1RySjxzE=;
        b=frQy8xE5Q48UYglVBLtvg+MTWzX1vQejrd8uuX/0WsUkOqCechJJCFAEKyCSsvgLmN
         i2hcyjrQW5aerzDaveJCGvbAPZBXV+cfuzcvElznoO1KS0Eg9BD8/VnPSstA1ZJB+cYD
         O+/om76OPESqB1JcBpChocbdIpEP6oAS+R65b9zfe2wiSQ3B+ElKj/eUNz6rIOEfcpev
         QdpQIc/B767WGnAo9BJmzp4GvZzF0G64xkch0oyYXV12sr0bNwEiZbnlA8C0Mazq0Flb
         IIq/k7PPXxtgBMnNuqsIOr/MtU+xJuGFw2Jf6MmD/bSJo9GZMc0ARFteGUzqIvPSJMVX
         ClWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UMhoqvO6ENLxC1LYsXqT72OwTuutJDRaWt1RySjxzE=;
        b=m23/3Dsml/mQNFC7+LCBRgNqbiEzJ28BJ4zLzTyEFKdWZUCa+3gDRirniymhW+ibVY
         dqvhq4Bcz/v7Qq2fD5p3KOKL3P24FxpXhYCGtybVxePHIx6rJtfhXAPI7JNIj4KYELuv
         DVmNLWkdo/rDbu9J9Xf+ffLzyrs83NvqGcJuq06/VCNMDwMHjJKACMcwfwAXPnxkszBX
         rFg+BfoUB4yPGcT2jw3KQWec4Z7d5C52zxYQJgsvhOL+K3e7fxRFC6X1fa7R+gjkfHMx
         Mj5vSWyOyke3hyyLeK6MeeTw4IgbArlwrmRQETBX9gyDVE8BFe9xkZfYgPVImdbmpysl
         DYSA==
X-Gm-Message-State: AOAM531kog2jm31uba6drTIGpcOvVQJ4GUV4KD7Xbe6q08i+R4j0lYmA
        mFxiUxUlfjTJfYpQTWWRLqM=
X-Google-Smtp-Source: ABdhPJz2e1oWv0FkjbWR3Z//1hhYeL5xwBnQ9MW/NyOEOt+kqyCib93ouedmgh+gvwlQNYxTn23NJA==
X-Received: by 2002:aa7:cb8b:0:b0:410:9aaf:2974 with SMTP id r11-20020aa7cb8b000000b004109aaf2974mr24726526edt.173.1645518538404;
        Tue, 22 Feb 2022 00:28:58 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id v12sm9831926edr.8.2022.02.22.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 00:28:58 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/3] staging: r8188eu: refactor rtw_ch2freq()
Date:   Tue, 22 Feb 2022 09:28:46 +0100
Message-Id: <20220222082847.6687-3-straube.linux@gmail.com>
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

Convert the array ch_freq_map to a simple integer array and use
the indices as channel numbers. This simplifies the code and avoids
looping through the array to get the frequency. To avoid out of
bounds array access return a default value for invalid channel values,
like the original code did.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
Added a check to avoid out of bounds array access.

 drivers/staging/r8188eu/core/rtw_rf.c | 41 ++++++++++++---------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index 51425971782b..68178699a0c6 100644
--- a/drivers/staging/r8188eu/core/rtw_rf.c
+++ b/drivers/staging/r8188eu/core/rtw_rf.c
@@ -8,32 +8,27 @@
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
+	if (channel == 0 || channel > ARRAY_SIZE(ch_freq_map))
+		return 2412;
 
-	return freq;
+	return ch_freq_map[channel - 1];
 }
-- 
2.35.1

