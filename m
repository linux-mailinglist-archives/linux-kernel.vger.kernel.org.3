Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFAC4EE367
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiCaVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiCaVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:43:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBEC23193D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g22so840216edz.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXeiIxrYUJtigOz8DNlmN/XSb8iuNB57fGunl8ww6Io=;
        b=bK9I6HTS+CF6jaF5ezoVOdcXPtA9dyceM3FfAFVbCo8rHiMmKW8dcnUZf8Tmhss+fw
         pY0N//tjDS87qIlRW5WeNAGpm1mcFbQJhKRWFkC64brym24z62osnRN4qZL+I8Un+qQ6
         NSxD/KeL91CoKYjZNNip/XFPkVdk1Thck1LMrjV6nNxi/iEh0cOKbCofDAMC3ueb+rbX
         8k7o32yD+8fF4KJeFa8MyV7sPRg2tEVt6lK8SNk+ZnJMMGpKmGj7Qi9HVxiKDL5DFzNv
         6pW93FOWI1rVTT4wCLuP5CE1vfpAn2H/qM86R74oay6CZtcP6SDxKG5kg71Ii+xbsA3s
         0tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXeiIxrYUJtigOz8DNlmN/XSb8iuNB57fGunl8ww6Io=;
        b=hrugy3k+8FFYucAjIB+LyXJu7Def8+LYAfA0lMUp+fK+PsYn3aS7cVlykskWY5pyJg
         HK/HClF3RMMUVKA9c2Z9pdWwQ47yASNv53flh+YT8wLGWFslIkFzIZ/UN7MHxWHWfKRl
         NZuPSukCMJUtmTXV5atSazZ57WdIZZrMw0xMJkiCoyg29AIDG0nd/wwHqqfm6rcrEp6e
         Nxw5LHC6oQoQoFMA0y0q2WNRLc0YlgCpFzN8SnhiGxdtKwTJFNXOzZaCow+OBJTNX2/+
         craOeVALhOOQiIbejMGX4eienrlPjNBtaqOIHU491x4k2EtNqvCbCGJ3nnuD779ya0t4
         XzAw==
X-Gm-Message-State: AOAM532CdsM484gkpwq05R0SGczN57tqZpHMC+M8T2j6GoJgE68Ln+IV
        mUx35Tsd456S2rmtTwpk9xs=
X-Google-Smtp-Source: ABdhPJwmFVuepYdJZKFdMJNIedJ932o5rNR2hJGBc1RoUI9Z+nk4FnLQl2d5iPQbn5vA8JnGUlJFfw==
X-Received: by 2002:a05:6402:d67:b0:419:48b:a762 with SMTP id ec39-20020a0564020d6700b00419048ba762mr18113658edb.291.1648762926313;
        Thu, 31 Mar 2022 14:42:06 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id dn4-20020a17090794c400b006dbec4f4acbsm244387ejc.6.2022.03.31.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:42:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: refactor rtw_ch2freq()
Date:   Thu, 31 Mar 2022 23:41:46 +0200
Message-Id: <20220331214146.15161-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331214146.15161-1-straube.linux@gmail.com>
References: <20220331214146.15161-1-straube.linux@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_rf.c | 40 +++++++++++--------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_rf.c b/drivers/staging/rtl8723bs/core/rtw_rf.c
index 7e4bf42fd1ac..4f120c894998 100644
--- a/drivers/staging/rtl8723bs/core/rtw_rf.c
+++ b/drivers/staging/rtl8723bs/core/rtw_rf.c
@@ -8,31 +8,27 @@
 #include <drv_types.h>
 #include <linux/kernel.h>
 
-
-struct ch_freq {
-	u32 channel;
-	u32 frequency;
-};
-
-static struct ch_freq ch_freq_map[] = {
-	{1, 2412}, {2, 2417}, {3, 2422}, {4, 2427}, {5, 2432},
-	{6, 2437}, {7, 2442}, {8, 2447}, {9, 2452}, {10, 2457},
-	{11, 2462}, {12, 2467}, {13, 2472}, {14, 2484},
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
 
 u32 rtw_ch2freq(u32 channel)
 {
-	u8 i;
-	u32 freq = 0;
-
-	for (i = 0; i < ARRAY_SIZE(ch_freq_map); i++) {
-		if (channel == ch_freq_map[i].channel) {
-			freq = ch_freq_map[i].frequency;
-				break;
-		}
-	}
-	if (i == ARRAY_SIZE(ch_freq_map))
-		freq = 2412;
+	if (channel == 0 || channel > ARRAY_SIZE(ch_freq_map))
+		return 2412;
 
-	return freq;
+	return ch_freq_map[channel - 1];
 }
-- 
2.35.1

