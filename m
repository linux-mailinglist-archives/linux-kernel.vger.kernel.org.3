Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900584EA330
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiC1WnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiC1WnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:43:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233AA4CD49
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:41:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bq8so17616576ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSGMUwSwwoLLYmM3DxccJfgGzUMvXUzZDLyfSZkPBWw=;
        b=hk+wcIWxCLf4sNqsonO3Oh6An8qK1acIBJsIO+BUdTMRg1qwh8Z+EKm6L6lr+xvb7N
         pyez1YPbgsOCtJsl0mRmxohYAuApCOdJnaGazAqcl/Ibsh9N1G4Gr++le9paiJLXrA/h
         w4lKCrHz3vW26Yd3ywx7s7bOTRI376tXhj0oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSGMUwSwwoLLYmM3DxccJfgGzUMvXUzZDLyfSZkPBWw=;
        b=urzO2qaNJEMgSDi7psfnf7ZEvIQV+YtMVQrkv5kb+Oqkn6LeTRXRcTJHo9XUdULGbv
         f9QKEv15aNO+hVjZFVbExYzd0dfzpQTCbMRY8t9f8kpr/+A2H/cOpqY0rjIdslOfG8BY
         2cvFP+/AYGf4QaP3wgMZs6iopTz5tlInIF5mI95wGyHmru4Qryely4RjFjoBkbnvjmJf
         6xoESUyXEfAiITEbZhnC8RXik0TpqWkjKeMsM0uNp8MVWFaA21es8WoRZu3AKl1cDsNC
         Xg638l5LOBOBy+tY+7lJPcXNFStYC2FLo3M0pQe2R3aLnXE8A6w2fqO4KZqMlCMbURBy
         tMyA==
X-Gm-Message-State: AOAM532WYviHvNAcYLinhcKdbiP1+KRFgM+pXzg5VnFiT9JHk4taltr9
        Q+o9y5PZk/q1F7SPuB6WOcOVRA==
X-Google-Smtp-Source: ABdhPJzCmwwdGne6xblxUaLuB54XD3pmnlnat+9i9zpry/1AqC/SPqlg5eCYj5c3OqGRlmN8oCynZQ==
X-Received: by 2002:a17:906:2bd7:b0:6ce:698b:7531 with SMTP id n23-20020a1709062bd700b006ce698b7531mr29710061ejg.146.1648507286741;
        Mon, 28 Mar 2022 15:41:26 -0700 (PDT)
Received: from localhost.localdomain ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm6392714ejo.190.2022.03.28.15.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:41:26 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/string.c: simplify str[c]spn
Date:   Tue, 29 Mar 2022 00:41:19 +0200
Message-Id: <20220328224119.3003834-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220328224119.3003834-1-linux@rasmusvillemoes.dk>
References: <20220328224119.3003834-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strchr(), which makes them a lot shorter, and more obviously
symmetric in their treatment of accept/reject. It also saves a little
bit of .text; bloat-o-meter for an arm build says

Function                                     old     new   delta
strcspn                                       92      76     -16
strspn                                       108      76     -32

While here, also remove a stray empty line before EXPORT_SYMBOL().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/string.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 485777c9da83..6f334420f687 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -517,21 +517,13 @@ EXPORT_SYMBOL(strnlen);
 size_t strspn(const char *s, const char *accept)
 {
 	const char *p;
-	const char *a;
-	size_t count = 0;
 
 	for (p = s; *p != '\0'; ++p) {
-		for (a = accept; *a != '\0'; ++a) {
-			if (*p == *a)
-				break;
-		}
-		if (*a == '\0')
-			return count;
-		++count;
+		if (!strchr(accept, *p))
+			break;
 	}
-	return count;
+	return p - s;
 }
-
 EXPORT_SYMBOL(strspn);
 #endif
 
@@ -544,17 +536,12 @@ EXPORT_SYMBOL(strspn);
 size_t strcspn(const char *s, const char *reject)
 {
 	const char *p;
-	const char *r;
-	size_t count = 0;
 
 	for (p = s; *p != '\0'; ++p) {
-		for (r = reject; *r != '\0'; ++r) {
-			if (*p == *r)
-				return count;
-		}
-		++count;
+		if (strchr(reject, *p))
+			break;
 	}
-	return count;
+	return p - s;
 }
 EXPORT_SYMBOL(strcspn);
 #endif
-- 
2.31.1

