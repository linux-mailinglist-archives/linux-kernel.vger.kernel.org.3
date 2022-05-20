Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E552E5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346450AbiETHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346318AbiETHLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:11:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D512616
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:11:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so7003023pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KUgn4q69DG5zIlC1bOLKat5AESimquHJFEcH7Mymww=;
        b=RnsS8rlcaqrcj3RhK36pn8NouGunnnwM0GWKWK3X1PoabzQ9x/1iAvkQLVXobtqqiM
         ckZSnIumZQpT0Pn4mHGXaQGJs831i9051mt2zMMjIB2XhqpiqHY8bdQK0fBaG0UzRLoL
         naPm0yF6A6L94p3Q2Soc1gjNiohCOmp8PNK2xsJ1qIt96FT3yDkxJr3YdN+/AofbvEvv
         viiJ12IC5jdwnOJpCr2ZYAjcUz0d5cNGgjyvZNDDRv2FFmf08kbSdTBBLUn+EpnaRT41
         YrATyb3OhG5XZvVh8xQe3R/6NeJ9DaM/oG6826oJKua/ka22lR8KaQ90kEd3mlS4ekaU
         2VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KUgn4q69DG5zIlC1bOLKat5AESimquHJFEcH7Mymww=;
        b=0OfK5DNbTqN3Yr40VO6F2dLE9dLyMVvdBrEXDJI96LYjgaBt/ixTcR/m95dcFP00x/
         4wB8OaV2T1DyVmajnIcfzRBBsY3knZss4vLdJxE6wrShMGb6EYDUqDISFVnc3elsvhvH
         2l2/uSkDIQq4u7ee8wjvUeFuFN+p/GLDld0Kh5gDnZM3CYb/B9gVHTgWv3H2qjdngIdj
         egQ3nVzLenuadJLrmHsUbcMvg0kAVnVtk6hj9vIoLcACEMh1gSqECckLYrp8L4lDBBGA
         ZpJCe0MKSyP43Jd+NnQzX6R/auLjHenX8NdrqKpnhmoyAhVw/iB7hBoPcUY0aJ+2QArV
         G2Ng==
X-Gm-Message-State: AOAM533SVqfzaRdCXNBpKMS8PfG3PoPpgn7mntKhSvirgX2hAQJ+erV/
        eJOefKfONd0Z6jrB2YQgIQAYkqv/vBprFQ==
X-Google-Smtp-Source: ABdhPJy2CdwQr543isCK/keOAsVtpqVPpZ286CuyvQTXDJe5qsQURjhpmTDYka3gLq4fZ2UvZmCJZg==
X-Received: by 2002:a63:5a09:0:b0:3c2:5dfa:285c with SMTP id o9-20020a635a09000000b003c25dfa285cmr7271718pgb.381.1653030667026;
        Fri, 20 May 2022 00:11:07 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b00161b3d5e3e4sm4965168ply.304.2022.05.20.00.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:11:05 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com, mst@redhat.com,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/3] memory-failure: Introduce memory failure notifier
Date:   Fri, 20 May 2022 15:06:46 +0800
Message-Id: <20220520070648.1794132-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520070648.1794132-1-pizhenwei@bytedance.com>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce memory failure notifier, once hardware memory failure
occurs, after the kernel handles the corrupted page successfully,
someone who registered this chain gets noticed of the corrupted PFN.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/linux/mm.h  |  2 ++
 mm/memory-failure.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..665873c2788c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3197,6 +3197,8 @@ extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
+extern int register_memory_failure_notifier(struct notifier_block *nb);
+extern int unregister_memory_failure_notifier(struct notifier_block *nb);
 #ifdef CONFIG_MEMORY_FAILURE
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 #else
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2d590cba412c..95c218bb0a37 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -68,6 +68,35 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
+static BLOCKING_NOTIFIER_HEAD(mf_notifier_list);
+
+/**
+ * register_memory_failure_notifier - Register function to be called if a
+ *                                    corrupted page gets handled successfully
+ * @nb: Info about notifier function to be called
+ *
+ * Currently always returns zero, as blocking_notifier_chain_register()
+ * always returns zero.
+ */
+int register_memory_failure_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&mf_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_memory_failure_notifier);
+
+/**
+ * unregister_memory_failure_notifier - Unregister previously registered
+ *                                      memory failure notifier
+ * @nb: Hook to be unregistered
+ *
+ * Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_memory_failure_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&mf_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_memory_failure_notifier);
+
 static bool __page_handle_poison(struct page *page)
 {
 	int ret;
@@ -1136,6 +1165,10 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
 	num_poisoned_pages_inc();
 	pr_err("Memory failure: %#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
+
+	/* notify the chain if we handle successfully only */
+	if (result == MF_RECOVERED)
+		blocking_notifier_call_chain(&mf_notifier_list, pfn, NULL);
 }
 
 static int page_action(struct page_state *ps, struct page *p,
-- 
2.20.1

