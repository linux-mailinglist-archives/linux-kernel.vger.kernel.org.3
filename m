Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665BA509AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386755AbiDUIkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386745AbiDUIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:40:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA63890
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:37:19 -0700 (PDT)
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkW9w1CZrzhXdc;
        Thu, 21 Apr 2022 16:37:08 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:37:17 +0800
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.111.5) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:37:16 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <elver@google.com>
CC:     <akpm@linux-foundation.org>, <chenzefeng2@huawei.com>,
        <dvyukov@google.com>, <glider@google.com>,
        <huangshaobo6@huawei.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nixiaoming@huawei.com>, <wangbing6@huawei.com>,
        <wangfangpeng1@huawei.com>, <young.liuyang@huawei.com>,
        <zengweilin@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH] kfence: check kfence canary in panic and reboot
Date:   Thu, 21 Apr 2022 16:37:15 +0800
Message-ID: <20220421083715.45380-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <Yl/qa2w3q9kyXcQl@elver.google.com>
References: <Yl/qa2w3q9kyXcQl@elver.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.111.5]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 13:11:39 +0200, Marco Elver wrote:
> On Wed, Apr 20, 2022 at 06:49PM +0800, Shaobo Huang wrote:
> > From: huangshaobo <huangshaobo6@huawei.com>
> > 
> > when writing out of bounds to the red zone, it can only be detected at
> > kfree. However, there were many scenarios before kfree that caused this
> > out-of-bounds write to not be detected. Therefore, it is necessary to
> > provide a method for actively detecting out-of-bounds writing to the red
> > zone, so that users can actively detect, and can be detected in the
> > system reboot or panic.
> > 
> > for example, if the application memory is out of bounds and written to
> > the red zone in the kfence object, the system suddenly panics, and the
> following log can be seen during system reset:
> 
> Interesting idea - however, when KFENCE is deployed to a fleet, the same
> bug will eventually manifest as an OOB that hits a guard page (because
> random placement), and produce the normal out-of-bounds message.
> 
> Have you found new bugs this way?

We haven't found bugs in this way yet, but we have proved that this way works through injection tests.

> But doing this check on panic doesn't seem to hurt. But please see
> comments below.
> 
> > BUG: KFENCE: memory corruption in atomic_notifier_call_chain+0x49/0x70
> > 
> > Corrupted memory at 0x(____ptrval____) [ ! ] (in kfence-#59):
> >  atomic_notifier_call_chain+0x49/0x70
> >  panic+0x134/0x278
> >  sysrq_handle_crash+0x11/0x20
> >  __handle_sysrq+0x99/0x160
> >  write_sysrq_trigger+0x26/0x30
> >  proc_reg_write+0x51/0x70
> >  vfs_write+0xb6/0x290
> >  ksys_write+0x9c/0xd0
> >  __do_fast_syscall_32+0x67/0xe0
> >  do_fast_syscall_32+0x2f/0x70
> >  entry_SYSCALL_compat_after_hwframe+0x45/0x4d
> > 
> > kfence-#59: 0x(____ptrval____)-0x(____ptrval____),size=100,cache=kmalloc-128
> >  allocated by task 77 on cpu 0 at 28.018073s:
> >  0xffffffffc007703d
> >  do_one_initcall+0x3c/0x1e0
> >  do_init_module+0x46/0x1d8
> >  load_module+0x2397/0x2860
> >  __do_sys_init_module+0x160/0x190
> >  __do_fast_syscall_32+0x67/0xe0
> >  do_fast_syscall_32+0x2f/0x70
> >  entry_SYSCALL_compat_after_hwframe+0x45/0x4d
> 
> Is this a real bug? Or one you injected?

one injected, construct red zone oob, echo c > /proc/sysrq-trigger to trigger panic.
The call stack example here will be deleted later.

> > Suggested-by: chenzefeng <chenzefeng2@huawei.com>
> > Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> > ---
> >  mm/kfence/core.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 9b2b5f56f4ae..85cc3ca4b71c 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -29,6 +29,9 @@
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/string.h>
> > +#include <linux/notifier.h>
> > +#include <linux/reboot.h>
> +#include <linux/panic_notifier.h>
> >  
> >  #include <asm/kfence.h>
> >  
> > @@ -716,6 +719,29 @@ static const struct file_operations objects_fops = {
> >  	.release = seq_release,
> >  };
> >  
> > +static void kfence_check_all_canary(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> > +		struct kfence_metadata *meta = &kfence_metadata[i];
> > +
> > +		if (meta->state == KFENCE_OBJECT_ALLOCATED)
> > +			for_each_canary(meta, check_canary_byte);
> > +	}
> > +}
> > +
> > +static int kfence_check_canary_callback(struct notifier_block *nb,
> > +					unsigned long reason, void *arg)
> > +{
> > +	kfence_check_all_canary();
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block kfence_check_canary_notifier = {
> > +	.notifier_call = kfence_check_canary_callback,
> > +};
> 
> Sorry to be pedantic, but this is a pretty random place to put this
> code. Can you put it after the debugfs section, perhaps with:
> 
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -748,6 +748,10 @@ static int __init kfence_debugfs_init(void)
>  
>  late_initcall(kfence_debugfs_init);
>  
> +/* === Reboot Notifier ====================================================== */
> +
> +< your code here >
> +
>  /* === Allocation Gate Timer ================================================ */
>  
>  static struct delayed_work kfence_timer;

thanks for your suggestion, I will modify it according to your suggestions later.

> >  static int __init kfence_debugfs_init(void)
> >  {
> >  	struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
> > @@ -806,6 +832,8 @@ static void kfence_init_enable(void)
> >  
> >  	WRITE_ONCE(kfence_enabled, true);
> >  	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> > +	register_reboot_notifier(&kfence_check_canary_notifier);
> > +	atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
> 
> Executing this on panic is reasonable. However,
> register_reboot_notifier() tells me this is being executed on *every*
> reboot (not just panic). I think that's not what we want, because that
> may increase reboot latency depending on how many KFENCE objects we
> have. Is it possible to *only* do the check on panic?

if oob occurs before reboot, reboot can also detect it, if not, the detection will be missing in this scenario.
reboot and panic are two scenarios of system reset, so I think both scenarios need to be added.
 
> Thanks,
> -- Marco

thanks,
ShaoBo Huang
