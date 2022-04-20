Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA99D5086B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352459AbiDTLOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiDTLOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:14:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239C23E5C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:11:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q20so964401wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=60zzKcjTCPwbmakqWfB1fDtmewNBaOu9rlb+E9ZxVuA=;
        b=cXqr5uB6R5vWGLtKqGTn0r5CAE6Wihjg+ESFiU8Es0xV1d0JaXnFC/DHTqKfsVCzxb
         12dhsweNaiZtkAs6jEEqBFXi/7Pl58PROE9ncCSrXj8SmYMsrubC5BsXxEbHnFZYvC2S
         u2Px6KK9b0urjv2OjnhpxG+FIrKlN2gdlEiBPkT2CFkYZlzSX8/IFh9jJV5bH9TkQMaJ
         X8sXpAvnfxCtXk6BRj5uNHyCA8zT8HLOeVIqRph8oKtPVfZ23riKGf0wJT26ZN3zTbIW
         DVRiY1E1FAbwsyInoLO00Zv9Tih9Y2srZD5Mb7WwMHH+o+pp+zsLzCBabpUswMP54WvH
         bG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=60zzKcjTCPwbmakqWfB1fDtmewNBaOu9rlb+E9ZxVuA=;
        b=mfAoJ58t7+teewKSRrSEkpvL6wzdmzmGCGgK//WEisvCne6m1PcFJSXISBAQP/T/dQ
         dyujooZ9EO7NPQBz1oNOuOjppYcNDgeAs1LowlwffS19H1/+RyniwsViakp+PRQDPAvH
         Z/fNnQ/lOUCXmeHsr2BL8qGa2aIwr+N52GNSj63S5KFWs08TDKP5DMOIR6cdwm/S4lEN
         2Lj4lbUHoq/Q//y/Xt6l+DbYn84HoFlVu73zZDgUk2uIBzQBYwrgRqexWyTnWU55xbtu
         qC01IH9k8Aa75Q/u7Dmr3neEHMsLRybBu63ItiffH7/AgmrHrbi5SVmUmBQN1cgQWwMk
         3K/A==
X-Gm-Message-State: AOAM530CrXA8NnLvqTWniLJU/safvOdxpdYScbKd4kqCUr2cUWj2yYRf
        SBwAsLL8Ede43i8NXuo9GC168w==
X-Google-Smtp-Source: ABdhPJxxxO93KhiiiQkU1b+14GwP5LAeB302skbHFkdW4gIYznIP9477ARGZAkft9xbZGipV3DsdUg==
X-Received: by 2002:a05:600c:3494:b0:390:8a95:1b95 with SMTP id a20-20020a05600c349400b003908a951b95mr3089004wmq.15.1650453105485;
        Wed, 20 Apr 2022 04:11:45 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:64a4:39d5:81cc:c8fd])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm15987523wrg.70.2022.04.20.04.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:11:45 -0700 (PDT)
Date:   Wed, 20 Apr 2022 13:11:39 +0200
From:   Marco Elver <elver@google.com>
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, young.liuyang@huawei.com,
        zengweilin@huawei.com, chenzefeng2@huawei.com,
        nixiaoming@huawei.com, wangbing6@huawei.com,
        wangfangpeng1@huawei.com, zhongjubin@huawei.com
Subject: Re: [PATCH] kfence: check kfence canary in panic and reboot
Message-ID: <Yl/qa2w3q9kyXcQl@elver.google.com>
References: <20220420104927.59056-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420104927.59056-1-huangshaobo6@huawei.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 06:49PM +0800, Shaobo Huang wrote:
> From: huangshaobo <huangshaobo6@huawei.com>
> 
> when writing out of bounds to the red zone, it can only be detected at
> kfree. However, there were many scenarios before kfree that caused this
> out-of-bounds write to not be detected. Therefore, it is necessary to
> provide a method for actively detecting out-of-bounds writing to the red
> zone, so that users can actively detect, and can be detected in the
> system reboot or panic.
> 
> for example, if the application memory is out of bounds and written to
> the red zone in the kfence object, the system suddenly panics, and the
> following log can be seen during system reset:

Interesting idea - however, when KFENCE is deployed to a fleet, the same
bug will eventually manifest as an OOB that hits a guard page (because
random placement), and produce the normal out-of-bounds message.

Have you found new bugs this way?

But doing this check on panic doesn't seem to hurt. But please see
comments below.

> BUG: KFENCE: memory corruption in atomic_notifier_call_chain+0x49/0x70
> 
> Corrupted memory at 0x(____ptrval____) [ ! ] (in kfence-#59):
>  atomic_notifier_call_chain+0x49/0x70
>  panic+0x134/0x278
>  sysrq_handle_crash+0x11/0x20
>  __handle_sysrq+0x99/0x160
>  write_sysrq_trigger+0x26/0x30
>  proc_reg_write+0x51/0x70
>  vfs_write+0xb6/0x290
>  ksys_write+0x9c/0xd0
>  __do_fast_syscall_32+0x67/0xe0
>  do_fast_syscall_32+0x2f/0x70
>  entry_SYSCALL_compat_after_hwframe+0x45/0x4d
> 
> kfence-#59: 0x(____ptrval____)-0x(____ptrval____),size=100,cache=kmalloc-128
>  allocated by task 77 on cpu 0 at 28.018073s:
>  0xffffffffc007703d
>  do_one_initcall+0x3c/0x1e0
>  do_init_module+0x46/0x1d8
>  load_module+0x2397/0x2860
>  __do_sys_init_module+0x160/0x190
>  __do_fast_syscall_32+0x67/0xe0
>  do_fast_syscall_32+0x2f/0x70
>  entry_SYSCALL_compat_after_hwframe+0x45/0x4d

Is this a real bug? Or one you injected?

> Suggested-by: chenzefeng <chenzefeng2@huawei.com>
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> ---
>  mm/kfence/core.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 9b2b5f56f4ae..85cc3ca4b71c 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -29,6 +29,9 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
> +#include <linux/panic_notifier.h>
>  
>  #include <asm/kfence.h>
>  
> @@ -716,6 +719,29 @@ static const struct file_operations objects_fops = {
>  	.release = seq_release,
>  };
>  
> +static void kfence_check_all_canary(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +		struct kfence_metadata *meta = &kfence_metadata[i];
> +
> +		if (meta->state == KFENCE_OBJECT_ALLOCATED)
> +			for_each_canary(meta, check_canary_byte);
> +	}
> +}
> +
> +static int kfence_check_canary_callback(struct notifier_block *nb,
> +					unsigned long reason, void *arg)
> +{
> +	kfence_check_all_canary();
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block kfence_check_canary_notifier = {
> +	.notifier_call = kfence_check_canary_callback,
> +};

Sorry to be pedantic, but this is a pretty random place to put this
code. Can you put it after the debugfs section, perhaps with:

--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -748,6 +748,10 @@ static int __init kfence_debugfs_init(void)
 
 late_initcall(kfence_debugfs_init);
 
+/* === Reboot Notifier ====================================================== */
+
+< your code here >
+
 /* === Allocation Gate Timer ================================================ */
 
 static struct delayed_work kfence_timer;

>  static int __init kfence_debugfs_init(void)
>  {
>  	struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
> @@ -806,6 +832,8 @@ static void kfence_init_enable(void)
>  
>  	WRITE_ONCE(kfence_enabled, true);
>  	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> +	register_reboot_notifier(&kfence_check_canary_notifier);
> +	atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);

Executing this on panic is reasonable. However,
register_reboot_notifier() tells me this is being executed on *every*
reboot (not just panic). I think that's not what we want, because that
may increase reboot latency depending on how many KFENCE objects we
have. Is it possible to *only* do the check on panic?

Thanks,
-- Marco
