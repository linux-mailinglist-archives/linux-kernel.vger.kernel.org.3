Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1294562621
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiF3WdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiF3WdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 799906583
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656628392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7KwLoH0d9jahqdN5gAGjp/0Ed77DbKf9u/QbOUdSiM=;
        b=Fiyl4c2s7/FCV48b4uOvCcf8+ZfNkTo/qlHCcleoc8Zt2q3KbHpTXDEK2Rub/IpwBmloE4
        h4I9jjzzmOFiVpyJzYGAkQY0ObODGibWKlqGxQ46rQs0HRy2v05ClwiXGt6cuQ8ISYfGHP
        8ng2X2m7HjDwATBs0u7e49AY0xymL5o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-l4cjxFuZOo2ZpTZTFqv3cw-1; Thu, 30 Jun 2022 18:33:10 -0400
X-MC-Unique: l4cjxFuZOo2ZpTZTFqv3cw-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so160908wmr.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7KwLoH0d9jahqdN5gAGjp/0Ed77DbKf9u/QbOUdSiM=;
        b=7YXcl7u+JoDE4aAjB5d4XiblqM//oACf1tlHkKuGgiMZN68zLQ8EP248g/HYDUXCki
         xlJW5S40IuY70/uetLA+9PfWqfCmGGKSCbt1W6vxJ0lZBZTTiN1tleq143t1bhCdc4mc
         s2dWliNeUJ+X17/wmdQtmW3Fkrf2In7GnYllz+h0glhguo1lLGLLxTPHXCjdJQrXcZab
         sXZwvC6mOBzZo8Dcf33qFrNtsI6htrTXWpo9BgG+n54uDTlX5TtBgz5Qs3B+/RVv9UTN
         Ttv6V+jWTsil/nqx5cpQ0fsnUXPfMWN6NKuYTS/1389XDgzytc2JIRQEs0QvohT7Wnoe
         MkAQ==
X-Gm-Message-State: AJIora/JDX4Xen9PqmzXpq5wCv737vNI4USi1rhKYgtav3hfIQhKJxua
        9Opp8h3SKIG9W506EqFlZzT6Tq3lzS/PHiF/dvA/Aj0Pp5+IDo2oK/VKdWi7ch4uzb+PBpqfnvh
        L2A+MvPhqAVB1GaSgm9jZDxeM
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id p9-20020a05600c204900b003a0536bc01bmr12804849wmg.151.1656628389749;
        Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s0NtFXC0FlUaliXhCXoOcENAR69+spVwYicuXfWxSDj9OAt+BI6mrAcCGFYu+NNT4zLgABNw==
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id p9-20020a05600c204900b003a0536bc01bmr12804822wmg.151.1656628389367;
        Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0020c5253d907sm4308387wrz.83.2022.06.30.15.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:33:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v4 1/2] kexec: Turn all kexec_mutex acquisitions into trylocks
Date:   Thu, 30 Jun 2022 23:32:57 +0100
Message-Id: <20220630223258.4144112-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220630223258.4144112-1-vschneid@redhat.com>
References: <20220630223258.4144112-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most acquistions of kexec_mutex are done via mutex_trylock() - those were a
direct "translation" from:

  8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()")

there has however been two additions since then that use mutex_lock():
crash_get_memory_size() and crash_shrink_memory().

A later commit will replace said mutex with an atomic variable, and locking
operations will become atomic_cmpxchg(). Rather than having those
mutex_lock() become while (atomic_cmpxchg(&lock, 0, 1)), turn them into
trylocks that can return -EBUSY on acquisition failure.

This does halve the printable size of the crash kernel, but that's still
neighbouring 2G for 32bit kernels which should be ample enough.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/kexec.h |  2 +-
 kernel/kexec_core.c   | 12 ++++++++----
 kernel/ksysfs.c       |  7 ++++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..54d7030d3c41 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -390,7 +390,7 @@ extern int kexec_load_disabled;
 extern bool kexec_in_progress;
 
 int crash_shrink_memory(unsigned long new_size);
-size_t crash_get_memory_size(void);
+ssize_t crash_get_memory_size(void);
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
 void arch_kexec_protect_crashkres(void);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..16370926b21a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1009,13 +1009,16 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
-size_t crash_get_memory_size(void)
+ssize_t crash_get_memory_size(void)
 {
-	size_t size = 0;
+	ssize_t size = 0;
+
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
 
-	mutex_lock(&kexec_mutex);
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
+
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
@@ -1036,7 +1039,8 @@ int crash_shrink_memory(unsigned long new_size)
 	unsigned long old_size;
 	struct resource *ram_res;
 
-	mutex_lock(&kexec_mutex);
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
 
 	if (kexec_crash_image) {
 		ret = -ENOENT;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index b1292a57c2a5..65dba9076f31 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -105,7 +105,12 @@ KERNEL_ATTR_RO(kexec_crash_loaded);
 static ssize_t kexec_crash_size_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%zu\n", crash_get_memory_size());
+	ssize_t size = crash_get_memory_size();
+
+	if (size < 0)
+		return size;
+
+	return sprintf(buf, "%zd\n", size);
 }
 static ssize_t kexec_crash_size_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
-- 
2.31.1

