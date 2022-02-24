Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A614C2424
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiBXGl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBXGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:41:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0331E17E36A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:40:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so4892282pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnvCoIs0/c2vqX4LLgh+v4j+mtPNEusN76pBE10KU9A=;
        b=adjXXIpKTM3UkYtOvwfXWKwU5zOSngzz1k+Q60tovu5Owx8jq56YeQL3zaMfC1yt24
         evxsv84d1hmtBicGADAhC1420eZufOvqHQP7HyX5L9GiBriKe/DyxwpfqGUntv63l90D
         mWvlxh6P3SFF1v5DRVgcZ17jssHSPlQxsN4U0CcPKFYG12Jb3FZPEZ08viFYXR93W0ww
         hhCitFlAwq29wKVEypjEANHbQhXq+8Vi/3esXLnCDd9uxpz8mdyoPurRWeuDDOoyq3gq
         90F6iBS6nhqcchg+U1ExJ2fgiH+Ns1pzbxI+7J9/FFkS7w37zEQKsM5riD2MoOS4yRha
         AuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnvCoIs0/c2vqX4LLgh+v4j+mtPNEusN76pBE10KU9A=;
        b=wDgcSRMd3UEivEE3STuM/XSm7mHjS+mAotyxVlJ8sJm63hBRZieeSrcDaGNmUxcI5E
         U0mKcaL8uK2qYNdemBogGCFFmp8Dhqn+dcIc6/9gY97VVsvVXZVOv7GlvopODbiIrquK
         Mj+LaRhN0nmXNWmrReL+LNeNcAbVv9YAsLxWHAYCjCeqQkjDYbPukG19OLD2THfy16ki
         lTSHC2y+p3peFYNmxvtMPPguoxfc9buiaL2LZW9IsHQheVqhH4Que/dDagidtkYsWUPv
         zYc5EXSapZk6RImPBRJAJJJCBLmNqd/5gb+b1BsfCSW61cdJnBeM1ObeHpNDYeVUnoft
         rsfg==
X-Gm-Message-State: AOAM533pgEChBqzVR5wC7ziHLk1w2/qiLN9kzuftAs1TBhi4GVgVZX5l
        Gspm92qgudM68IKNopEuBvU=
X-Google-Smtp-Source: ABdhPJzP+MOntAQn0G1ULYguihQZhslOvo9EMbQqn9LxmNgmJO+hSoIGJj3JY1KYuKuLoTxn5gghLw==
X-Received: by 2002:a17:902:ce05:b0:14f:8ba2:2339 with SMTP id k5-20020a170902ce0500b0014f8ba22339mr1190889plg.152.1645684858284;
        Wed, 23 Feb 2022 22:40:58 -0800 (PST)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:47fe:f358:be6:4577])
        by smtp.googlemail.com with ESMTPSA id j12sm1729109pfu.79.2022.02.23.22.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:40:58 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com
Subject: [PATCH v2 1/3] staging: rtl8192u: fix broken debug macro
Date:   Wed, 23 Feb 2022 22:40:29 -0800
Message-Id: <20220224064033.1530924-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YhPI5iDRUpzYWDyY@kroah.com>
References: <YhPI5iDRUpzYWDyY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There is an extra space in the debug macro, when CONFIG_IEEE80211_DEBUG
is switched off, compiler will complain.

drivers/staging/rtl8192u/ieee80211/ieee80211.h:470:42: error: expected ‘)’ before ‘...’ token
  470 | #define IEEE80211_DEBUG (level, fmt, args...) do {} while (0)
drivers/staging/rtl8192u/ieee80211/ieee80211.h:470:47: error: expected ‘;’ before ‘do’
  470 | #define IEEE80211_DEBUG (level, fmt, args...) do {} while (0)

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 15207dc1f5c5..ab1e380688ee 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -467,8 +467,8 @@ do { if (ieee80211_debug_level & (level)) \
 		}                                                              \
 	} while (0)
 #else
-#define IEEE80211_DEBUG (level, fmt, args...) do {} while (0)
-#define IEEE80211_DEBUG_DATA (level, data, datalen) do {} while (0)
+#define IEEE80211_DEBUG(level, fmt, args...)
+#define IEEE80211_DEBUG_DATA(level, data, datalen)
 #endif	/* CONFIG_IEEE80211_DEBUG */
 
 /* debug macros not dependent on CONFIG_IEEE80211_DEBUG */
-- 
2.25.1

