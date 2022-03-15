Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200AA4DA386
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351510AbiCOT4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiCOT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE6DD4ECFC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aUjoakwf6xALGnQpzSaxujSWRmQPS+GTmQFpua5/GrY=;
        b=I8ILVrlM4mtUj6rL3mVnQIMmMPY4UEuSzAC6IB05g72xoxij5ECmHwcr9129TEZGxV+cSz
        lnamYnT2ORHdpsYEfQya6c4K2jByr5QZNMiiePfe7rEJUH6D9AyScl1JDj/G3jgmGsDPRt
        NtHoGL4WYv+DLTLClqcnSzD7R365qpg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-CP9xfKCtOEKvC36WO8z9Rw-1; Tue, 15 Mar 2022 15:55:27 -0400
X-MC-Unique: CP9xfKCtOEKvC36WO8z9Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EED21C05EB2;
        Tue, 15 Mar 2022 19:55:26 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7C9D400F74F;
        Tue, 15 Mar 2022 19:55:25 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B9ADD416D5E9; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153313.997111717@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:38 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [patch v12 06/13] procfs: add per-pid task isolation state
References: <20220315153132.717153751@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /proc/pid/task_isolation file, to query the state of
task isolation configuration.

---
 fs/proc/base.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

Index: linux-2.6/fs/proc/base.c
===================================================================
--- linux-2.6.orig/fs/proc/base.c
+++ linux-2.6/fs/proc/base.c
@@ -97,6 +97,8 @@
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
+#include <linux/prctl.h>
+#include <linux/task_isolation.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -665,6 +667,69 @@ static int proc_pid_syscall(struct seq_f
 }
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
+#ifdef CONFIG_TASK_ISOLATION
+
+struct qoptions {
+	unsigned long mask;
+	char *name;
+};
+
+static struct qoptions iopts[] = {
+	{ISOL_F_QUIESCE, "quiesce"},
+};
+#define ILEN (sizeof(iopts) / sizeof(struct qoptions))
+
+static struct qoptions qopts[] = {
+	{ISOL_F_QUIESCE_VMSTATS, "vmstat_sync"},
+};
+#define QLEN (sizeof(qopts) / sizeof(struct qoptions))
+
+static void show_isolation_state(struct seq_file *m,
+				 struct qoptions *iopt,
+				 int mask,
+				 const char *hdr)
+{
+	int i;
+
+	seq_printf(m, hdr);
+	for (i = 0; i < ILEN; i++) {
+		if (mask & iopt->mask)
+			seq_printf(m, "%s ", iopt->name);
+		iopt++;
+	}
+	if (mask == 0)
+		seq_printf(m, "none ");
+	seq_printf(m, "\n");
+}
+
+int proc_pid_task_isolation(struct seq_file *m, struct pid_namespace *ns,
+			    struct pid *pid, struct task_struct *t)
+{
+	int active_mask, quiesce_mask, conf_mask;
+	struct task_isol_info *task_isol_info;
+	struct inode *inode = m->private;
+	struct task_struct *task = get_proc_task(inode);
+
+	task_isol_info = t->task_isol_info;
+	if (!task_isol_info)
+		active_mask = quiesce_mask = conf_mask = 0;
+	else {
+		active_mask = task_isol_info->active_mask;
+		quiesce_mask = task_isol_info->quiesce_mask;
+		conf_mask = task_isol_info->conf_mask;
+	}
+
+	show_isolation_state(m, iopts, conf_mask, "Configured state: ");
+	show_isolation_state(m, iopts, active_mask, "Active state: ");
+	show_isolation_state(m, qopts, quiesce_mask, "Quiescing: ");
+
+	put_task_struct(task);
+
+	return 0;
+}
+
+#endif /* CONFIG_TASK_ISOLATION */
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -3286,6 +3351,9 @@ static const struct pid_entry tgid_base_
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+#ifdef CONFIG_TASK_ISOLATION
+	ONE("task_isolation", S_IRUSR, proc_pid_task_isolation),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)


