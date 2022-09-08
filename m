Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B75B273D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIHT5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIHT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C92BFDBA5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=POf439emxhXrOrr156ZeESPCz55AZP+6XMtLj7BfFZI=;
        b=CJDmlm4XAOlVEDeFNHeRJOYtJYCW7zUPNV6lylZ9hpTz+VBDppZa/MAKSrDBRnTX5JRA2p
        74dvQ+McvgrwEiQmCHHQl95QkcmeAYi04qA/SvFKmdCVKd/Yp5xV8i8s0BnRbvfpyG0PJo
        Zj/eEXWCyYweUN6CJE3/i/z0TETyQx8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-BuWPzhxhMsCXfUGpofza8Q-1; Thu, 08 Sep 2022 15:57:17 -0400
X-MC-Unique: BuWPzhxhMsCXfUGpofza8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A67D985A589;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47908945D2;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 215FF415CD54; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908195111.661824729@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:29:00 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Prasad Pandit <ppandit@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH 1/7] cpu isolation: basic block interference infrastructure
References: <20220908192859.546633738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of codepaths in the kernel that interrupt
code execution in remote CPUs. A subset of such codepaths are
triggered from userspace and can therefore return errors.

Introduce a cpumask named "block interference", writable from userspace.

This cpumask (and associated helpers) can be used by code that executes
code on remote CPUs to optionally return an error.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/include/linux/sched/isolation.h
===================================================================
--- linux-2.6.orig/include/linux/sched/isolation.h
+++ linux-2.6/include/linux/sched/isolation.h
@@ -58,4 +58,33 @@ static inline bool housekeeping_cpu(int
 	return true;
 }
 
+#ifdef CONFIG_CPU_ISOLATION
+extern cpumask_var_t block_interf_cpumask;
+extern bool block_interf_cpumask_active;
+
+void block_interf_read_lock(void);
+void block_interf_read_unlock(void);
+
+void block_interf_write_lock(void);
+void block_interf_write_unlock(void);
+
+void block_interf_assert_held(void);
+
+#else
+static inline void block_interf_read_lock(void)		{ }
+static inline void block_interf_read_unlock(void)	{ }
+static inline void block_interf_write_lock(void)	{ }
+static inline void block_interf_write_unlock(void)	{ }
+static inline void block_interf_assert_held(void)	{ }
+#endif
+
+static inline bool block_interf_cpu(int cpu)
+{
+#ifdef CONFIG_CPU_ISOLATION
+	if (block_interf_cpumask_active)
+		return cpumask_test_cpu(cpu, block_interf_cpumask);
+#endif
+	return false;
+}
+
 #endif /* _LINUX_SCHED_ISOLATION_H */
Index: linux-2.6/kernel/sched/isolation.c
===================================================================
--- linux-2.6.orig/kernel/sched/isolation.c
+++ linux-2.6/kernel/sched/isolation.c
@@ -239,3 +239,116 @@ static int __init housekeeping_isolcpus_
 	return housekeeping_setup(str, flags);
 }
 __setup("isolcpus=", housekeeping_isolcpus_setup);
+
+DEFINE_STATIC_PERCPU_RWSEM(block_interf_lock);
+
+cpumask_var_t block_interf_cpumask;
+EXPORT_SYMBOL_GPL(block_interf_cpumask);
+
+bool block_interf_cpumask_active;
+EXPORT_SYMBOL_GPL(block_interf_cpumask_active);
+
+void block_interf_read_lock(void)
+{
+	percpu_down_read(&block_interf_lock);
+}
+EXPORT_SYMBOL_GPL(block_interf_read_lock);
+
+void block_interf_read_unlock(void)
+{
+	percpu_up_read(&block_interf_lock);
+}
+EXPORT_SYMBOL_GPL(block_interf_read_unlock);
+
+void block_interf_write_lock(void)
+{
+	percpu_down_write(&block_interf_lock);
+}
+EXPORT_SYMBOL_GPL(block_interf_write_lock);
+
+void block_interf_write_unlock(void)
+{
+	percpu_up_write(&block_interf_lock);
+}
+EXPORT_SYMBOL_GPL(block_interf_write_unlock);
+
+void block_interf_assert_held(void)
+{
+	percpu_rwsem_assert_held(&block_interf_lock);
+}
+EXPORT_SYMBOL_GPL(block_interf_assert_held);
+
+static ssize_t
+block_interf_cpumask_read(struct file *filp, char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	char *mask_str;
+	int len;
+
+	len = snprintf(NULL, 0, "%*pb\n",
+		       cpumask_pr_args(block_interf_cpumask)) + 1;
+	mask_str = kmalloc(len, GFP_KERNEL);
+	if (!mask_str)
+		return -ENOMEM;
+
+	len = snprintf(mask_str, len, "%*pb\n",
+		       cpumask_pr_args(block_interf_cpumask));
+	if (len >= count) {
+		count = -EINVAL;
+		goto out_err;
+	}
+	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
+
+out_err:
+	kfree(mask_str);
+
+	return count;
+}
+
+static ssize_t
+block_interf_cpumask_write(struct file *filp, const char __user *ubuf,
+			   size_t count, loff_t *ppos)
+{
+	cpumask_var_t block_interf_cpumask_new;
+	int err;
+
+	if (!zalloc_cpumask_var(&block_interf_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpumask_parse_user(ubuf, count, block_interf_cpumask_new);
+	if (err)
+		goto err_free;
+
+	block_interf_write_lock();
+	cpumask_copy(block_interf_cpumask, block_interf_cpumask_new);
+	block_interf_write_unlock();
+	free_cpumask_var(block_interf_cpumask_new);
+
+	return count;
+
+err_free:
+	free_cpumask_var(block_interf_cpumask_new);
+
+	return err;
+}
+
+static const struct file_operations block_interf_cpumask_fops = {
+	.read		= block_interf_cpumask_read,
+	.write		= block_interf_cpumask_write,
+};
+
+
+static int __init block_interf_cpumask_init(void)
+{
+	if (!zalloc_cpumask_var(&block_interf_cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	debugfs_create_file_unsafe("block_interf_cpumask", 0644, NULL, NULL,
+				   &block_interf_cpumask_fops);
+
+	block_interf_cpumask_active = true;
+	return 0;
+}
+
+late_initcall(block_interf_cpumask_init);
+


