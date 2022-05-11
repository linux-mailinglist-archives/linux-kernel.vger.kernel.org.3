Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A0522A97
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbiEKDzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbiEKDzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:55:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34C3213324
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:55:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 202so687400pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkAZPhAkhghXKAcrYQ097N+yUjSoD43IH6MO8WVhkW0=;
        b=XTIXKAsQLSW9h7YC+Hl0jhrCRlhJoL7ZN43rl4HojAKB6QTZDyKFGdsQ3+/4q11Gf9
         1yrehn7dms/+YB3orW/WWboVn+fzhaRuXuXvjIXG6v7vC15AgKmlBlD8gilh49cnbXYJ
         dkZW2WjQK5eGZGAmm374sgwDgQoibYPvNPMlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkAZPhAkhghXKAcrYQ097N+yUjSoD43IH6MO8WVhkW0=;
        b=t1C/oga0umC6+5Hxn5nWw72jhpEGtS4H38+rS4JdDFD2oJO8sPaLDrdSKErAMfcjK2
         4EWcyS3XbLtjJnwdR64sT6Kz7UE/Z+/rwJdZTBaQNqmbeVenA5d9dURtdFNM1pBZ2bOG
         f/b3laMYVADcbTSE+A/MlC+0RlPlBsN8atSa0/nhRasC7lMWh4N8KfCymX9Tid22WgIL
         1kHA4RW4LDOYR2urqYEmxj94AgNhyClQrXW8uO6zvhTig2e2u18WEPxo3wYS9x+HpED+
         QR77/ThJi/Zjzftvi9tpx7bs+7YmhLG2Wm/Dgl3BnfRD/Z5Zdcht1pDoTwJlnBgyHmwF
         HYsw==
X-Gm-Message-State: AOAM531D25sDMSEsqySnQTAwFr3qANMt05LKKl2wJLDYAnpU8HOkUKi/
        P3fwQVfIJ2w4amtpjSX45s5ZtA==
X-Google-Smtp-Source: ABdhPJxYgsPGtWhs7POp5A5xnYfBle+QWXILF7HGaYr8jorK2248KV18yTDhWf6EaGfBzvQ3RnPdig==
X-Received: by 2002:a05:6a00:10cc:b0:505:ada6:e03e with SMTP id d12-20020a056a0010cc00b00505ada6e03emr23348965pfu.45.1652241332539;
        Tue, 10 May 2022 20:55:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0015e8d4eb1f7sm442789plh.65.2022.05.10.20.55.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 20:55:32 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,net-next 3/6] iov_iter: Add a nocache copy iov iterator
Date:   Tue, 10 May 2022 20:54:24 -0700
Message-Id: <1652241268-46732-4-git-send-email-jdamato@fastly.com>
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

Add copy_page_from_iter_nocache, which wraps copy_page_from_iter_iovec and
passes in a custom copyin function: __copy_from_user_nocache.

This allows callers of copy_page_from_iter_nocache to copy data without
disturbing the CPU cache.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285f..58c7946 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -142,6 +142,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+size_t copy_page_from_iter_nocache(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ef22ec1..985bf58 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -895,6 +895,26 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+size_t copy_page_from_iter_nocache(struct page *page, size_t offset, size_t
+		bytes, struct iov_iter *i)
+{
+	if (unlikely(!page_copy_sane(page, offset, bytes)))
+		return 0;
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
+		WARN_ON(1);
+		return 0;
+	}
+	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
+		void *kaddr = kmap_atomic(page);
+		size_t wanted = _copy_from_iter_nocache(kaddr + offset, bytes, i);
+
+		kunmap_atomic(kaddr);
+		return wanted;
+	} else
+		return copy_page_from_iter_iovec(page, offset, bytes, i,
+				__copy_from_user_nocache);
+}
+
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-- 
2.7.4

