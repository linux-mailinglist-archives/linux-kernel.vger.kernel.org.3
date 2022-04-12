Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB44FE05C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiDLMdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347101AbiDLMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:33:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ED5AA56;
        Tue, 12 Apr 2022 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bZGwtg721/vos0v+4uWN1TQ12j+Iplb0bq7iDFHye/U=; b=dFPxbnB71bTRSTVuJtilE/1Cy+
        pF3Gg/tnO5Yaa257/TYB+1PuOxGO7dXb+HiqAXOjKqGB0bE+oSkjGgOUwV80zae3LxboSniNCPLjC
        wShzx367Wa+MXUMwD+tnH5DmS06luLsPyDhuhebcAct4LI2aiGrfqaG93rQwXEgLg+MGZXdRI/vZU
        S1Nw2RNa+QQtcwK6RLevnd0W5UqBjbEp8bM2z9dw5K7mtNAgDveiCTCjlAbSYnaDtof8b3iaY+uq+
        GVo6jyMCf7PbgOhA2U7psb2iA/Z8L4JlyQZd7zULW/CVqATvYUtjcGlK3KBiHp0xQuHzpLBKWpkfM
        FdPpM4Ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neF2o-00DILC-Jg; Tue, 12 Apr 2022 11:50:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B152300C26;
        Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 46DFD3017A05F; Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Message-ID: <20220412114853.904077681@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Apr 2022 13:44:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/5] freezer: Have {,un}lock_system_sleep() save/restore flags
References: <20220412114421.691372568@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael explained that the reason for having both PF_NOFREEZE and
PF_FREEZER_SKIP is that {,un}lock_system_sleep() is callable from
kthread context that has previously called set_freezable().

In preparation of merging the flags, have {,un}lock_system_slee() save
and restore current->flags.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/acpi/x86/s2idle.c         |   12 ++++++++----
 drivers/scsi/scsi_transport_spi.c |    7 ++++---
 include/linux/suspend.h           |    8 ++++----
 kernel/power/hibernate.c          |   35 ++++++++++++++++++++++-------------
 kernel/power/main.c               |   16 ++++++++++------
 kernel/power/suspend.c            |   12 ++++++++----
 kernel/power/user.c               |   24 ++++++++++++++----------
 7 files changed, 70 insertions(+), 44 deletions(-)

--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -538,12 +538,14 @@ void acpi_s2idle_setup(void)
 
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
 {
+	unsigned int sleep_flags;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return -ENODEV;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	list_add(&arg->list_node, &lps0_s2idle_devops_head);
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return 0;
 }
@@ -551,12 +553,14 @@ EXPORT_SYMBOL_GPL(acpi_register_lps0_dev
 
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
 {
+	unsigned int sleep_flags;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	list_del(&arg->list_node);
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
 
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -998,8 +998,9 @@ void
 spi_dv_device(struct scsi_device *sdev)
 {
 	struct scsi_target *starget = sdev->sdev_target;
-	u8 *buffer;
 	const int len = SPI_MAX_ECHO_BUFFER_SIZE*2;
+	unsigned int sleep_flags;
+	u8 *buffer;
 
 	/*
 	 * Because this function and the power management code both call
@@ -1007,7 +1008,7 @@ spi_dv_device(struct scsi_device *sdev)
 	 * while suspend or resume is in progress. Hence the
 	 * lock/unlock_system_sleep() calls.
 	 */
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (scsi_autopm_get_device(sdev))
 		goto unlock_system_sleep;
@@ -1058,7 +1059,7 @@ spi_dv_device(struct scsi_device *sdev)
 	scsi_autopm_put_device(sdev);
 
 unlock_system_sleep:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL(spi_dv_device);
 
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -510,8 +510,8 @@ extern bool pm_save_wakeup_count(unsigne
 extern void pm_wakep_autosleep_enabled(bool set);
 extern void pm_print_active_wakeup_sources(void);
 
-extern void lock_system_sleep(void);
-extern void unlock_system_sleep(void);
+extern unsigned int lock_system_sleep(void);
+extern void unlock_system_sleep(unsigned int);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -534,8 +534,8 @@ static inline void pm_system_wakeup(void
 static inline void pm_wakeup_clear(bool reset) {}
 static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
 
-static inline void lock_system_sleep(void) {}
-static inline void unlock_system_sleep(void) {}
+static inline unsigned int lock_system_sleep(void) { return 0; }
+static inline void unlock_system_sleep(unsigned int flags) {}
 
 #endif /* !CONFIG_PM_SLEEP */
 
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -92,20 +92,24 @@ bool hibernation_available(void)
  */
 void hibernation_set_ops(const struct platform_hibernation_ops *ops)
 {
+	unsigned int sleep_flags;
+
 	if (ops && !(ops->begin && ops->end &&  ops->pre_snapshot
 	    && ops->prepare && ops->finish && ops->enter && ops->pre_restore
 	    && ops->restore_cleanup && ops->leave)) {
 		WARN_ON(1);
 		return;
 	}
-	lock_system_sleep();
+
+	sleep_flags = lock_system_sleep();
+
 	hibernation_ops = ops;
 	if (ops)
 		hibernation_mode = HIBERNATION_PLATFORM;
 	else if (hibernation_mode == HIBERNATION_PLATFORM)
 		hibernation_mode = HIBERNATION_SHUTDOWN;
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(hibernation_set_ops);
 
@@ -713,6 +717,7 @@ static int load_image_and_restore(void)
 int hibernate(void)
 {
 	bool snapshot_test = false;
+	unsigned int sleep_flags;
 	int error;
 
 	if (!hibernation_available()) {
@@ -720,7 +725,7 @@ int hibernate(void)
 		return -EPERM;
 	}
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -794,7 +799,7 @@ int hibernate(void)
 	pm_restore_console();
 	hibernate_release();
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 	pr_info("hibernation exit\n");
 
 	return error;
@@ -809,9 +814,10 @@ int hibernate(void)
  */
 int hibernate_quiet_exec(int (*func)(void *data), void *data)
 {
+	unsigned int sleep_flags;
 	int error;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -891,7 +897,7 @@ int hibernate_quiet_exec(int (*func)(voi
 	hibernate_release();
 
 unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error;
 }
@@ -1100,11 +1106,12 @@ static ssize_t disk_show(struct kobject
 static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t n)
 {
+	int mode = HIBERNATION_INVALID;
+	unsigned int sleep_flags;
 	int error = 0;
-	int i;
 	int len;
 	char *p;
-	int mode = HIBERNATION_INVALID;
+	int i;
 
 	if (!hibernation_available())
 		return -EPERM;
@@ -1112,7 +1119,7 @@ static ssize_t disk_store(struct kobject
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
 		if (len == strlen(hibernation_modes[i])
 		    && !strncmp(buf, hibernation_modes[i], len)) {
@@ -1142,7 +1149,7 @@ static ssize_t disk_store(struct kobject
 	if (!error)
 		pm_pr_dbg("Hibernation mode set to '%s'\n",
 			       hibernation_modes[mode]);
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 	return error ? error : n;
 }
 
@@ -1158,9 +1165,10 @@ static ssize_t resume_show(struct kobjec
 static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 			    const char *buf, size_t n)
 {
-	dev_t res;
+	unsigned int sleep_flags;
 	int len = n;
 	char *name;
+	dev_t res;
 
 	if (len && buf[len-1] == '\n')
 		len--;
@@ -1173,9 +1181,10 @@ static ssize_t resume_store(struct kobje
 	if (!res)
 		return -EINVAL;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	swsusp_resume_device = res;
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
+
 	pm_pr_dbg("Configured hibernation resume from disk to %u\n",
 		  swsusp_resume_device);
 	noresume = 0;
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -21,14 +21,16 @@
 
 #ifdef CONFIG_PM_SLEEP
 
-void lock_system_sleep(void)
+unsigned int lock_system_sleep(void)
 {
+	unsigned int flags = current->flags;
 	current->flags |= PF_FREEZER_SKIP;
 	mutex_lock(&system_transition_mutex);
+	return flags;
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);
 
-void unlock_system_sleep(void)
+void unlock_system_sleep(unsigned int flags)
 {
 	/*
 	 * Don't use freezer_count() because we don't want the call to
@@ -46,7 +48,8 @@ void unlock_system_sleep(void)
 	 * Which means, if we use try_to_freeze() here, it would make them
 	 * enter the refrigerator, thus causing hibernation to lockup.
 	 */
-	current->flags &= ~PF_FREEZER_SKIP;
+	if (!(flags & PF_FREEZER_SKIP))
+		current->flags &= ~PF_FREEZER_SKIP;
 	mutex_unlock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
@@ -260,16 +263,17 @@ static ssize_t pm_test_show(struct kobje
 static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 				const char *buf, size_t n)
 {
+	unsigned int sleep_flags;
 	const char * const *s;
+	int error = -EINVAL;
 	int level;
 	char *p;
 	int len;
-	int error = -EINVAL;
 
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	level = TEST_FIRST;
 	for (s = &pm_tests[level]; level <= TEST_MAX; s++, level++)
@@ -279,7 +283,7 @@ static ssize_t pm_test_store(struct kobj
 			break;
 		}
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error ? error : n;
 }
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -75,9 +75,11 @@ EXPORT_SYMBOL_GPL(pm_suspend_default_s2i
 
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
-	lock_system_sleep();
+	unsigned int sleep_flags;
+
+	sleep_flags = lock_system_sleep();
 	s2idle_ops = ops;
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 
 static void s2idle_begin(void)
@@ -200,7 +202,9 @@ __setup("mem_sleep_default=", mem_sleep_
  */
 void suspend_set_ops(const struct platform_suspend_ops *ops)
 {
-	lock_system_sleep();
+	unsigned int sleep_flags;
+
+	sleep_flags = lock_system_sleep();
 
 	suspend_ops = ops;
 
@@ -216,7 +220,7 @@ void suspend_set_ops(const struct platfo
 			mem_sleep_current = PM_SUSPEND_MEM;
 	}
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(suspend_set_ops);
 
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -46,12 +46,13 @@ int is_hibernate_resume_dev(dev_t dev)
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	int error;
 
 	if (!hibernation_available())
 		return -EPERM;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -97,7 +98,7 @@ static int snapshot_open(struct inode *i
 	data->dev = 0;
 
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error;
 }
@@ -105,8 +106,9 @@ static int snapshot_open(struct inode *i
 static int snapshot_release(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	swsusp_free();
 	data = filp->private_data;
@@ -123,7 +125,7 @@ static int snapshot_release(struct inode
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	hibernate_release();
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return 0;
 }
@@ -131,11 +133,12 @@ static int snapshot_release(struct inode
 static ssize_t snapshot_read(struct file *filp, char __user *buf,
                              size_t count, loff_t *offp)
 {
+	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	ssize_t res;
-	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	data = filp->private_data;
 	if (!data->ready) {
@@ -156,7 +159,7 @@ static ssize_t snapshot_read(struct file
 		*offp += res;
 
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return res;
 }
@@ -164,11 +167,12 @@ static ssize_t snapshot_read(struct file
 static ssize_t snapshot_write(struct file *filp, const char __user *buf,
                               size_t count, loff_t *offp)
 {
+	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	ssize_t res;
-	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	data = filp->private_data;
 
@@ -190,7 +194,7 @@ static ssize_t snapshot_write(struct fil
 	if (res > 0)
 		*offp += res;
 unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return res;
 }


