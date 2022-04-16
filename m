Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3C5035F0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiDPK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:27:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCC617E13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:25:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso6803972otj.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAwdY3/hpZa+mDgOL5jFRGta3ky0j/Xe63lExx20fBM=;
        b=HVr29EqsqK3Zl2aR8tUdn+y3xstnHREd7s8CtWCSqIvUVgS0oLKIa3ibRiuEJFsY1u
         /UCCFzQ3T88Q5CArGa9lSjdPbSbjA/C1R7atgIPAOGnSrsdqXyWqtswmzCHOf1JVnMct
         Cl2RnzDt//+tu1fBM+AMLrkAGvpE/HBPE0LjyWJga8KaNqx1FRcFHBLPdyTwlWzjoEQD
         iyfvsLyVqBPpcyEXJZmB0MBg7v/YiArtZh/w449/Z+MqeryRkgoCl+ExvyNdHYCxswwE
         XedvTbaO0rgtbfBvMUH1l/JhdT4uuf/X+s/YxUTmcL/U8QF62vkY52p7DiLF2WK1t1yB
         rDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAwdY3/hpZa+mDgOL5jFRGta3ky0j/Xe63lExx20fBM=;
        b=C12Lp0tyK8LRX3m9KfRDq9Wy3FGhLvfJUYbhT/1czFe4S6BkhDJStfQ/ukSv2vz1eL
         pDU89VzNKcDukC5sOGVBpGf38nJ1fz+5NGBfrJu1BYGLfaNo0DPf+7p/Fv+dDyIuIx3J
         zhyZnimPt1KsPMMIiMCpu+LRhXc0VqFZizIHn3OjKvyam4qfi1DNxhiouSlNHroK6EIE
         81lMPXY9ZOlq53FLh6QbtigR8d0ef+k4OtB1nyLtT8IBIyil5fmBhcfLyKAmrJNAc+kc
         6TV10CC3DAj4e+3NkHCED975VnucnOMXC1zrIk4kqypbD2+beBlwgu3SoFInpzjQZKct
         DNaw==
X-Gm-Message-State: AOAM530u0dSR6ix0+x+NfOujxrls38MB5JdZEenVDkrj77SeVHxVohGb
        uUQZYcJavrv+ET5hclFvffkyIHVc80NrbQ==
X-Google-Smtp-Source: ABdhPJyLKZhUaF8GS1HD5pzG3omywEfOv5Ge4CVMmZ4eh2pLDTxKQnOI/7pgVbCkE9sNl8AOamyhzw==
X-Received: by 2002:a9d:65c1:0:b0:5b2:3556:a612 with SMTP id z1-20020a9d65c1000000b005b23556a612mr961395oth.132.1650104708229;
        Sat, 16 Apr 2022 03:25:08 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id r3-20020aca4403000000b002ecf4d70c83sm1910132oia.27.2022.04.16.03.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 03:25:07 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH] staging: rtl8192u: compare strcmp result to zero
Date:   Sat, 16 Apr 2022 05:24:34 -0500
Message-Id: <20220416102434.97567-1-remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add " == 0" to the condition in both else if branches to address a
possible bug. strcmp returns 0 when its arguments are equal, which
evaluates to false, often leading to errors when used in if statements.

Currently, the statement in the first else if branch does not execute
when its arguments are equal, but it does execute when crypt->ops->name
equals any string other than "WEP" or "TKIP".

Similarly, the second else if branch does not execute when its arguments
are equal, and it only executes when crypt->ops->name equals "TKIP".
The else branch never executes.

It is unlikely that this is working as intended.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
There is a similiar issue in
drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
but I'm not sure if it's incorrect. The strcmp on line 2847 isn't
negated, but the ones on lines 2851, 2853, and 2855 are.

2845         /* IPW HW cannot build TKIP MIC, host decryption still needed. */
2846         if (!(ieee->host_encrypt || ieee->host_decrypt) &&
2847             strcmp(param->u.crypt.alg, "TKIP"))
2848                 goto skip_host_crypt;
2849 
2850         //set WEP40 first, it will be modified according to WEP104 or WEP40 at other place
2851         if (!strcmp(param->u.crypt.alg, "WEP"))
2852                 module = "ieee80211_crypt_wep";
2853         else if (!strcmp(param->u.crypt.alg, "TKIP"))
2854                 module = "ieee80211_crypt_tkip";
2855         else if (!strcmp(param->u.crypt.alg, "CCMP"))
2856                 module = "ieee80211_crypt_ccmp"; 

drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index 9885917b9199..d6829cf6f7e3 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -688,9 +688,9 @@ int ieee80211_wx_get_encode_ext(struct ieee80211_device *ieee,
 	} else {
 		if (strcmp(crypt->ops->name, "WEP") == 0)
 			ext->alg = IW_ENCODE_ALG_WEP;
-		else if (strcmp(crypt->ops->name, "TKIP"))
+		else if (strcmp(crypt->ops->name, "TKIP") == 0)
 			ext->alg = IW_ENCODE_ALG_TKIP;
-		else if (strcmp(crypt->ops->name, "CCMP"))
+		else if (strcmp(crypt->ops->name, "CCMP") == 0)
 			ext->alg = IW_ENCODE_ALG_CCMP;
 		else
 			return -EINVAL;
-- 
2.32.0

