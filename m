Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97453547967
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiFLJAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiFLJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:00:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1751E50
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n185so1469706wmn.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BSwA4NeVgnxLtuLfBKKExOEIpE9041JXV4ItPWNPtss=;
        b=Phou/fv0D1wJ4Nk2pfva5TbGOkuRvzB5hCvplrKRFOl/E/aof+dvqIV0hEg7B8yWA2
         boGSuUryK0hJY/CJr9pfeCKgO8aBpITFUNTkAfI2yfs4h8oPM5j7bbtdchgPKTxhphMi
         REgT3rfdCzXU5GZMDjqVC2Rut3LVv5IF5cjDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BSwA4NeVgnxLtuLfBKKExOEIpE9041JXV4ItPWNPtss=;
        b=yD0iMgxSRV8WQxFWVUwUe+yWZ1I/Glxn+vAtXBEXtGQWaGurb4Vh0GrYlbkBvlcdnY
         gOLRcSig7BtlBJzFtUhPVCOU9DFSbnJkRqmrDJzw8WpV3FOd7dqjNXEOLgSNTOEO/CRs
         EYvqx62nlBNQtnoo8syj7QCeqOva8BcExrtkQJ+MC7c3LX+LmL86vgFPYdJbHOOB9R39
         jxJAX73FBoRSVnyTelUWMhufFuM7qs/wOWwlGz/xXcJUjvOdF4PPfznqTHKS6g0+b0Jl
         6yuAnswHCgsMk5xfXNbWM/li6wDuheJGhNOuH8EONWog0/qxV0BV5X8FgChvuQw7MB08
         lQ9g==
X-Gm-Message-State: AOAM530b1FxWU6DzhukJwZTFfjfaQC8VSG9Rtdd0qW5FNW2ZRijrSUz7
        S76JaAL+3XjXzS7iw4Yqp5xAOw==
X-Google-Smtp-Source: ABdhPJwNsBIpVclTS0sPJeAUmur+L0XJo1yT8PTf/ts7qsn4fvkqtJUHn+dBs1UinPtS7am6gjEEiw==
X-Received: by 2002:a05:600c:358f:b0:39c:7fe7:cbe2 with SMTP id p15-20020a05600c358f00b0039c7fe7cbe2mr8463834wmq.46.1655024439801;
        Sun, 12 Jun 2022 02:00:39 -0700 (PDT)
Received: from localhost.localdomain ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id d34-20020a05600c4c2200b0039c5b4ab1b0sm4798603wmp.48.2022.06.12.02.00.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 02:00:38 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,iov_iter v2 3/8] iov_iter: add copyin_iovec helper
Date:   Sun, 12 Jun 2022 01:57:52 -0700
Message-Id: <1655024280-23827-4-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copyin_iovec is a helper which wraps copyin and selects the right copy
method based on the iter_copy_type.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 lib/iov_iter.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d32d7e5..6720cb2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -168,6 +168,15 @@ static int copyin(void *to, const void __user *from, size_t n)
 	return n;
 }
 
+static int copyin_iovec(void *to, const void __user *from, size_t n,
+			struct iov_iter *i)
+{
+	if (unlikely(iov_iter_copy_is_nt(i)))
+		return __copy_from_user_nocache(to, from, n);
+	else
+		return copyin(to, from, n);
+}
+
 static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
@@ -278,7 +287,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 		to = kaddr + offset;
 
 		/* first chunk, usually the only one */
-		left = copyin(to, buf, copy);
+		left = copyin_iovec(to, buf, copy, i);
 		copy -= left;
 		skip += copy;
 		to += copy;
@@ -288,7 +297,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 			iov++;
 			buf = iov->iov_base;
 			copy = min(bytes, iov->iov_len);
-			left = copyin(to, buf, copy);
+			left = copyin_iovec(to, buf, copy, i);
 			copy -= left;
 			skip = copy;
 			to += copy;
@@ -307,7 +316,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 
 	kaddr = kmap(page);
 	to = kaddr + offset;
-	left = copyin(to, buf, copy);
+	left = copyin_iovec(to, buf, copy, i);
 	copy -= left;
 	skip += copy;
 	to += copy;
@@ -316,7 +325,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 		iov++;
 		buf = iov->iov_base;
 		copy = min(bytes, iov->iov_len);
-		left = copyin(to, buf, copy);
+		left = copyin_iovec(to, buf, copy, i);
 		copy -= left;
 		skip = copy;
 		to += copy;
@@ -766,7 +775,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 	if (iter_is_iovec(i))
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
-		copyin(addr + off, base, len),
+		copyin_iovec(addr + off, base, len, i),
 		memcpy(addr + off, base, len)
 	)
 
-- 
2.7.4

