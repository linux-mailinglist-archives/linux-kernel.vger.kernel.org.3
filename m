Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B146522A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiEKDzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiEKDzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:55:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A72108BC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:55:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x18so671575plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGmy4QLI/8fGmA3FerkRtku5TKK3UOkAtDIIlXf/W7s=;
        b=Lvz2NFU0wxJq7i37Ze4DZNA+uM0xodpQ2/GD0sncaN3Rc26o53fkHgOXTmfUTOGYMe
         PQ8YhJRQE2joOk55gZTNRlr0yhTfNgbEswFespAwO54TVWi3uXnQh34OkhOecNRke75l
         vkqlDGGRVgUjE7Hj88oeaMjrx58TpDNV9ffOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGmy4QLI/8fGmA3FerkRtku5TKK3UOkAtDIIlXf/W7s=;
        b=4kSNnlZGqG+7/nhTCm5kQ4sIW26Ke8wMkPdJMUgoLNHbLYXApWMOfmPLggVTQYOIFt
         fI4sHTbV6DC/HV2WmXJJluJh1T1uOISJBWRC1m3PJ+YK1O1vNDKl8G25Agy45vKFrbvQ
         DW7wP2K8smhu5GHiAFTkowSHzM9wXCcx9Lw6EQYCyXNvaJNpB8K6crYmVMV8pgPvg91O
         KQIpqA07rhFrifID6H3Ny1IjzyHTEFTjyhPzfbbiNoEtkip9+P/bnDEmicgs3iJMTkpR
         ZcaV5TodIYSnKKpwE9Ucdhvh0aEGKJgbwxu2GxngZ0BAap1HiIEKKhrTdMP0/zjQsBKM
         v9Ug==
X-Gm-Message-State: AOAM531JZ3VYzgYYIQ9d/QWrAUh3GXTFuJoP7hvw7nITHDWrs0bDPvdj
        17mPzQ5G/P+L0GoL+2cpS+sD2s7/c58upQ==
X-Google-Smtp-Source: ABdhPJzw3DCldBbT9UirZQI+OHb9LG4rGmq8XkuDK/k9AREZfDPPdxjaEuFH1i4LKnAoxp/vAOJzyw==
X-Received: by 2002:a17:90b:14ce:b0:1dc:eff5:52b6 with SMTP id jz14-20020a17090b14ce00b001dceff552b6mr3169500pjb.148.1652241330638;
        Tue, 10 May 2022 20:55:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0015e8d4eb1f7sm442789plh.65.2022.05.10.20.55.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 20:55:30 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,net-next 2/6] iov_iter: Allow custom copyin function
Date:   Tue, 10 May 2022 20:54:23 -0700
Message-Id: <1652241268-46732-3-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652241268-46732-1-git-send-email-jdamato@fastly.com>
References: <1652241268-46732-1-git-send-email-jdamato@fastly.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling copy_page_from_iter_iovec, allow callers to specify the copy
function they'd like to use.

The only caller is updated to pass raw_copy_from_user.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 lib/iov_iter.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330..ef22ec1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -253,7 +253,9 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 }
 
 static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i)
+			 struct iov_iter *i,
+			 unsigned long (*_copyin)(void *to, const void __user *from,
+						 unsigned long n))
 {
 	size_t skip, copy, left, wanted;
 	const struct iovec *iov;
@@ -278,7 +280,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 		to = kaddr + offset;
 
 		/* first chunk, usually the only one */
-		left = copyin(to, buf, copy);
+		left = _copyin(to, buf, copy);
 		copy -= left;
 		skip += copy;
 		to += copy;
@@ -288,7 +290,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 			iov++;
 			buf = iov->iov_base;
 			copy = min(bytes, iov->iov_len);
-			left = copyin(to, buf, copy);
+			left = _copyin(to, buf, copy);
 			copy -= left;
 			skip = copy;
 			to += copy;
@@ -307,7 +309,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 
 	kaddr = kmap(page);
 	to = kaddr + offset;
-	left = copyin(to, buf, copy);
+	left = _copyin(to, buf, copy);
 	copy -= left;
 	skip += copy;
 	to += copy;
@@ -316,7 +318,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 		iov++;
 		buf = iov->iov_base;
 		copy = min(bytes, iov->iov_len);
-		left = copyin(to, buf, copy);
+		left = _copyin(to, buf, copy);
 		copy -= left;
 		skip = copy;
 		to += copy;
@@ -899,7 +901,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
 	if (likely(iter_is_iovec(i)))
-		return copy_page_from_iter_iovec(page, offset, bytes, i);
+		return copy_page_from_iter_iovec(page, offset, bytes, i, raw_copy_from_user);
 	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
 		void *kaddr = kmap_local_page(page);
 		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
-- 
2.7.4

