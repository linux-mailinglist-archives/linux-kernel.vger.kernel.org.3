Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51159EBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbiHWS7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiHWS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:59:06 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF4BC800;
        Tue, 23 Aug 2022 10:28:44 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-334dc616f86so397597737b3.8;
        Tue, 23 Aug 2022 10:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Fei1rF3NSSQKgbs5Sd7HsXB5+dr1affULk4oDxJiBOE=;
        b=ZBnwl3y8fcGwei0P+Rp3YAXz8tYaOuAKa7MT1WTdmbOaQxQ9Ra8YWfVAi1zHX7X8UK
         LWNzp8pXPT0WM+DPg/vaoDtH4/8gVWhQx087U49EMRSpQRyst41ahlSqFv2Rw8sAPBVI
         rh5W59uoxjKQay+/YTwJAdkXlHt3ddbDRWKQMhoH7Q3Iq2d7cwNFQxCwb/Nsl+eArjCC
         BTof/mMB4rwaabClXNFNf/fq1We5dA3xfOPlxZkF4hKubbq69rdQqy+giDieESXxDFmV
         DPeGgtMpwA3IV1AD0SMFpYS07nsqB5Wz/yd+m+bnbehhFcUz9TZXy0mhiT8+yO5y8Zrz
         gk3w==
X-Gm-Message-State: ACgBeo3z6XkJoLvQolgkwSVPUmvv2opyIrVSZT9AtPEdy+ZwMUV8IxWy
        U5fCKcoz4TRrRd6cx3XqT+XPJMjexMWWTbGwQVI=
X-Google-Smtp-Source: AA6agR7FIn0NECcITTBddzAU8V8XttOQLQP3QOcQLh9bCaJ42BvX86wNTXLVeXX2/1RE3HQt9pcsubuzy7LrC7QfUGA=
X-Received: by 2002:a25:c204:0:b0:692:72b9:a778 with SMTP id
 s4-20020a25c204000000b0069272b9a778mr25314309ybf.81.1661275517030; Tue, 23
 Aug 2022 10:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220822111816.760285417@infradead.org> <20220822114648.725003428@infradead.org>
In-Reply-To: <20220822114648.725003428@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:25:06 +0200
Message-ID: <CAJZ5v0hGinW8STisx0Wb9DgtcPj+rYVAja4dW-+Bo=MCKu-DNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] freezer: Have {,un}lock_system_sleep()
 save/restore flags
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 1:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Rafael explained that the reason for having both PF_NOFREEZE and
> PF_FREEZER_SKIP is that {,un}lock_system_sleep() is callable from
> kthread context that has previously called set_freezable().
>
> In preparation of merging the flags, have {,un}lock_system_slee() save
> and restore current->flags.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/x86/s2idle.c         |   12 ++++++++----
>  drivers/scsi/scsi_transport_spi.c |    7 ++++---
>  include/linux/suspend.h           |    8 ++++----
>  kernel/power/hibernate.c          |   35 ++++++++++++++++++++++-------------
>  kernel/power/main.c               |   16 ++++++++++------
>  kernel/power/suspend.c            |   12 ++++++++----
>  kernel/power/user.c               |   24 ++++++++++++++----------
>  7 files changed, 70 insertions(+), 44 deletions(-)
>
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -541,12 +541,14 @@ void acpi_s2idle_setup(void)
>
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
>  {
> +       unsigned int sleep_flags;
> +
>         if (!lps0_device_handle || sleep_no_lps0)
>                 return -ENODEV;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>         list_add(&arg->list_node, &lps0_s2idle_devops_head);
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>
>         return 0;
>  }
> @@ -554,12 +556,14 @@ EXPORT_SYMBOL_GPL(acpi_register_lps0_dev
>
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
>  {
> +       unsigned int sleep_flags;
> +
>         if (!lps0_device_handle || sleep_no_lps0)
>                 return;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>         list_del(&arg->list_node);
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>  }
>  EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
>
> --- a/drivers/scsi/scsi_transport_spi.c
> +++ b/drivers/scsi/scsi_transport_spi.c
> @@ -998,8 +998,9 @@ void
>  spi_dv_device(struct scsi_device *sdev)
>  {
>         struct scsi_target *starget = sdev->sdev_target;
> -       u8 *buffer;
>         const int len = SPI_MAX_ECHO_BUFFER_SIZE*2;
> +       unsigned int sleep_flags;
> +       u8 *buffer;
>
>         /*
>          * Because this function and the power management code both call
> @@ -1007,7 +1008,7 @@ spi_dv_device(struct scsi_device *sdev)
>          * while suspend or resume is in progress. Hence the
>          * lock/unlock_system_sleep() calls.
>          */
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>
>         if (scsi_autopm_get_device(sdev))
>                 goto unlock_system_sleep;
> @@ -1058,7 +1059,7 @@ spi_dv_device(struct scsi_device *sdev)
>         scsi_autopm_put_device(sdev);
>
>  unlock_system_sleep:
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>  }
>  EXPORT_SYMBOL(spi_dv_device);
>
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -510,8 +510,8 @@ extern bool pm_save_wakeup_count(unsigne
>  extern void pm_wakep_autosleep_enabled(bool set);
>  extern void pm_print_active_wakeup_sources(void);
>
> -extern void lock_system_sleep(void);
> -extern void unlock_system_sleep(void);
> +extern unsigned int lock_system_sleep(void);
> +extern void unlock_system_sleep(unsigned int);
>
>  #else /* !CONFIG_PM_SLEEP */
>
> @@ -534,8 +534,8 @@ static inline void pm_system_wakeup(void
>  static inline void pm_wakeup_clear(bool reset) {}
>  static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
>
> -static inline void lock_system_sleep(void) {}
> -static inline void unlock_system_sleep(void) {}
> +static inline unsigned int lock_system_sleep(void) { return 0; }
> +static inline void unlock_system_sleep(unsigned int flags) {}
>
>  #endif /* !CONFIG_PM_SLEEP */
>
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -92,20 +92,24 @@ bool hibernation_available(void)
>   */
>  void hibernation_set_ops(const struct platform_hibernation_ops *ops)
>  {
> +       unsigned int sleep_flags;
> +
>         if (ops && !(ops->begin && ops->end &&  ops->pre_snapshot
>             && ops->prepare && ops->finish && ops->enter && ops->pre_restore
>             && ops->restore_cleanup && ops->leave)) {
>                 WARN_ON(1);
>                 return;
>         }
> -       lock_system_sleep();
> +
> +       sleep_flags = lock_system_sleep();
> +
>         hibernation_ops = ops;
>         if (ops)
>                 hibernation_mode = HIBERNATION_PLATFORM;
>         else if (hibernation_mode == HIBERNATION_PLATFORM)
>                 hibernation_mode = HIBERNATION_SHUTDOWN;
>
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>  }
>  EXPORT_SYMBOL_GPL(hibernation_set_ops);
>
> @@ -713,6 +717,7 @@ static int load_image_and_restore(void)
>  int hibernate(void)
>  {
>         bool snapshot_test = false;
> +       unsigned int sleep_flags;
>         int error;
>
>         if (!hibernation_available()) {
> @@ -720,7 +725,7 @@ int hibernate(void)
>                 return -EPERM;
>         }
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>         /* The snapshot device should not be opened while we're running */
>         if (!hibernate_acquire()) {
>                 error = -EBUSY;
> @@ -794,7 +799,7 @@ int hibernate(void)
>         pm_restore_console();
>         hibernate_release();
>   Unlock:
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>         pr_info("hibernation exit\n");
>
>         return error;
> @@ -809,9 +814,10 @@ int hibernate(void)
>   */
>  int hibernate_quiet_exec(int (*func)(void *data), void *data)
>  {
> +       unsigned int sleep_flags;
>         int error;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>
>         if (!hibernate_acquire()) {
>                 error = -EBUSY;
> @@ -891,7 +897,7 @@ int hibernate_quiet_exec(int (*func)(voi
>         hibernate_release();
>
>  unlock:
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>
>         return error;
>  }
> @@ -1100,11 +1106,12 @@ static ssize_t disk_show(struct kobject
>  static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
>                           const char *buf, size_t n)
>  {
> +       int mode = HIBERNATION_INVALID;
> +       unsigned int sleep_flags;
>         int error = 0;
> -       int i;
>         int len;
>         char *p;
> -       int mode = HIBERNATION_INVALID;
> +       int i;
>
>         if (!hibernation_available())
>                 return -EPERM;
> @@ -1112,7 +1119,7 @@ static ssize_t disk_store(struct kobject
>         p = memchr(buf, '\n', n);
>         len = p ? p - buf : n;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>         for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
>                 if (len == strlen(hibernation_modes[i])
>                     && !strncmp(buf, hibernation_modes[i], len)) {
> @@ -1142,7 +1149,7 @@ static ssize_t disk_store(struct kobject
>         if (!error)
>                 pm_pr_dbg("Hibernation mode set to '%s'\n",
>                                hibernation_modes[mode]);
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>         return error ? error : n;
>  }
>
> @@ -1158,9 +1165,10 @@ static ssize_t resume_show(struct kobjec
>  static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
>                             const char *buf, size_t n)
>  {
> -       dev_t res;
> +       unsigned int sleep_flags;
>         int len = n;
>         char *name;
> +       dev_t res;
>
>         if (len && buf[len-1] == '\n')
>                 len--;
> @@ -1173,9 +1181,10 @@ static ssize_t resume_store(struct kobje
>         if (!res)
>                 return -EINVAL;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>         swsusp_resume_device = res;
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
> +
>         pm_pr_dbg("Configured hibernation resume from disk to %u\n",
>                   swsusp_resume_device);
>         noresume = 0;
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -21,14 +21,16 @@
>
>  #ifdef CONFIG_PM_SLEEP
>
> -void lock_system_sleep(void)
> +unsigned int lock_system_sleep(void)
>  {
> +       unsigned int flags = current->flags;
>         current->flags |= PF_FREEZER_SKIP;
>         mutex_lock(&system_transition_mutex);
> +       return flags;
>  }
>  EXPORT_SYMBOL_GPL(lock_system_sleep);
>
> -void unlock_system_sleep(void)
> +void unlock_system_sleep(unsigned int flags)
>  {
>         /*
>          * Don't use freezer_count() because we don't want the call to
> @@ -46,7 +48,8 @@ void unlock_system_sleep(void)
>          * Which means, if we use try_to_freeze() here, it would make them
>          * enter the refrigerator, thus causing hibernation to lockup.
>          */
> -       current->flags &= ~PF_FREEZER_SKIP;
> +       if (!(flags & PF_FREEZER_SKIP))
> +               current->flags &= ~PF_FREEZER_SKIP;
>         mutex_unlock(&system_transition_mutex);
>  }
>  EXPORT_SYMBOL_GPL(unlock_system_sleep);
> @@ -263,16 +266,17 @@ static ssize_t pm_test_show(struct kobje
>  static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
>                                 const char *buf, size_t n)
>  {
> +       unsigned int sleep_flags;
>         const char * const *s;
> +       int error = -EINVAL;
>         int level;
>         char *p;
>         int len;
> -       int error = -EINVAL;
>
>         p = memchr(buf, '\n', n);
>         len = p ? p - buf : n;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>
>         level = TEST_FIRST;
>         for (s = &pm_tests[level]; level <= TEST_MAX; s++, level++)
> @@ -282,7 +286,7 @@ static ssize_t pm_test_store(struct kobj
>                         break;
>                 }
>
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>
>         return error ? error : n;
>  }
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -75,9 +75,11 @@ EXPORT_SYMBOL_GPL(pm_suspend_default_s2i
>
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
>  {
> -       lock_system_sleep();
> +       unsigned int sleep_flags;
> +
> +       sleep_flags = lock_system_sleep();
>         s2idle_ops = ops;
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>  }
>
>  static void s2idle_begin(void)
> @@ -200,7 +202,9 @@ __setup("mem_sleep_default=", mem_sleep_
>   */
>  void suspend_set_ops(const struct platform_suspend_ops *ops)
>  {
> -       lock_system_sleep();
> +       unsigned int sleep_flags;
> +
> +       sleep_flags = lock_system_sleep();
>
>         suspend_ops = ops;
>
> @@ -216,7 +220,7 @@ void suspend_set_ops(const struct platfo
>                         mem_sleep_current = PM_SUSPEND_MEM;
>         }
>
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>  }
>  EXPORT_SYMBOL_GPL(suspend_set_ops);
>
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -47,12 +47,13 @@ int is_hibernate_resume_dev(dev_t dev)
>  static int snapshot_open(struct inode *inode, struct file *filp)
>  {
>         struct snapshot_data *data;
> +       unsigned int sleep_flags;
>         int error;
>
>         if (!hibernation_available())
>                 return -EPERM;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>
>         if (!hibernate_acquire()) {
>                 error = -EBUSY;
> @@ -98,7 +99,7 @@ static int snapshot_open(struct inode *i
>         data->dev = 0;
>
>   Unlock:
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>
>         return error;
>  }
> @@ -106,8 +107,9 @@ static int snapshot_open(struct inode *i
>  static int snapshot_release(struct inode *inode, struct file *filp)
>  {
>         struct snapshot_data *data;
> +       unsigned int sleep_flags;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>
>         swsusp_free();
>         data = filp->private_data;
> @@ -124,7 +126,7 @@ static int snapshot_release(struct inode
>                         PM_POST_HIBERNATION : PM_POST_RESTORE);
>         hibernate_release();
>
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>
>         return 0;
>  }
> @@ -132,11 +134,12 @@ static int snapshot_release(struct inode
>  static ssize_t snapshot_read(struct file *filp, char __user *buf,
>                               size_t count, loff_t *offp)
>  {
> +       loff_t pg_offp = *offp & ~PAGE_MASK;
>         struct snapshot_data *data;
> +       unsigned int sleep_flags;
>         ssize_t res;
> -       loff_t pg_offp = *offp & ~PAGE_MASK;
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>
>         data = filp->private_data;
>         if (!data->ready) {
> @@ -157,7 +160,7 @@ static ssize_t snapshot_read(struct file
>                 *offp += res;
>
>   Unlock:
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>
>         return res;
>  }
> @@ -165,16 +168,17 @@ static ssize_t snapshot_read(struct file
>  static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>                                size_t count, loff_t *offp)
>  {
> +       loff_t pg_offp = *offp & ~PAGE_MASK;
>         struct snapshot_data *data;
> +       unsigned long sleep_flags;
>         ssize_t res;
> -       loff_t pg_offp = *offp & ~PAGE_MASK;
>
>         if (need_wait) {
>                 wait_for_device_probe();
>                 need_wait = false;
>         }
>
> -       lock_system_sleep();
> +       sleep_flags = lock_system_sleep();
>
>         data = filp->private_data;
>
> @@ -196,7 +200,7 @@ static ssize_t snapshot_write(struct fil
>         if (res > 0)
>                 *offp += res;
>  unlock:
> -       unlock_system_sleep();
> +       unlock_system_sleep(sleep_flags);
>
>         return res;
>  }
>
>
