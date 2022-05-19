Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F152DB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242665AbiESRZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiESRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CFA503B;
        Thu, 19 May 2022 10:24:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y41so5691020pfw.12;
        Thu, 19 May 2022 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aez4xKkQFiC6cLQoLCSDnU78rKX2tZ7O2uihdwY+gWM=;
        b=a1gmaGVsBWgj8W0Ucn3OWFhvF/01NImYP50L+JkvTxNU6+V+3rp20qVM+mTtTCKDMz
         FAc2Gnd2oFzwp5hWXQsMc0dXwFVmpA2UsaxqzWluk6793qpF9tsHKxb2N+CGyl9lyugt
         zuQKBLCSXPuii9QMdz7DhJdlvtwgCVKl7ADO63ZV3gQg9RKqOKy+qIsjlLgv7KHisQ5O
         4/Doyf0JlPj0/6hnUHB/3a3de+JgshjNQskdJAmVSX3LEx3WAbLBiirB6QD/rJaU62/k
         MQ/UQNFPcBLz8b27gJmRNMiDUVFdsG03lZgNSvlnU1FQ/wIm+L1XCEsQd7jpS7ado8Nm
         QqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aez4xKkQFiC6cLQoLCSDnU78rKX2tZ7O2uihdwY+gWM=;
        b=3ymAPrpmeIEPb6JlZbtr0BuHd3FG2bAuKYs/jgxD2bTh+NKABXP9rnA4pCiKZR873p
         LYgTNtVpserv9Dcq5/y5U3OhnjWXNW2dMDtcHAFEjbVnALxuhjFuiVD/AYU3MuA0goYx
         3ZqGV4sPVfKUXJcCoxFZPxQelVWKz1wX8drCMGr3i+jyZXYbvrvvj1H6qkGINpxAjAZE
         ffMYH0vk4fdizIDWP58Jkmh/dg+FKY98MuXZc/43iiGpqLt9+0ru/ZUXByPrkX181sB+
         0dCr7vSSmr3gBJNYb/M08B2JqDeVutqc1zSaVzJ3jf5Zv4ogvoOxh0YfIcaNupEU6UjP
         skGw==
X-Gm-Message-State: AOAM531cpJlUD/7mlyfmKUnh2SqZKhQ48utrJcDmV/at3H2TkEyFRTvL
        68tBPq5sjF1MxPpwDjgXqk6tRvEClAfl
X-Google-Smtp-Source: ABdhPJyDTVqemec481fu2a98YNEPDxW1lSMzFlRcj5H/c1FC/s0T9u9nb+ujrC195v2JIu/E2GYAmQ==
X-Received: by 2002:a05:6a00:234f:b0:4f6:f0c0:ec68 with SMTP id j15-20020a056a00234f00b004f6f0c0ec68mr5742305pfj.14.1652981079196;
        Thu, 19 May 2022 10:24:39 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:38 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 04/28] lib/string_helpers: string_get_size() now returns characters wrote
Date:   Thu, 19 May 2022 13:23:57 -0400
Message-Id: <20220519172421.162394-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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

printbuf now needs to know the number of characters that would have been
written if the buffer was too small, like snprintf(); this changes
string_get_size() to return the the return value of snprintf().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/string_helpers.h | 4 ++--
 lib/string_helpers.c           | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 2e56b4ce98..fd9c150a12 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -19,8 +19,8 @@ enum string_size_units {
 	STRING_UNITS_2,		/* use binary powers of 2^10 */
 };
 
-void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
-		     char *buf, int len);
+int string_get_size(u64 size, u64 blk_size, enum string_size_units units,
+		    char *buf, int len);
 
 #define UNESCAPE_SPACE		BIT(0)
 #define UNESCAPE_OCTAL		BIT(1)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index c890e83f59..9a08b5d774 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -33,8 +33,8 @@
  * at least 9 bytes and will always be zero terminated.
  *
  */
-void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
-		     char *buf, int len)
+int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
+		    char *buf, int len)
 {
 	static const char *const units_10[] = {
 		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
@@ -127,8 +127,7 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	else
 		unit = units_str[units][i];
 
-	snprintf(buf, len, "%u%s %s", (u32)size,
-		 tmp, unit);
+	return snprintf(buf, len, "%u%s %s", (u32)size, tmp, unit);
 }
 EXPORT_SYMBOL(string_get_size);
 
-- 
2.36.0

