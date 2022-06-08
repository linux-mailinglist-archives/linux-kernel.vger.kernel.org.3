Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B1543278
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbiFHOZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiFHOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:25:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03697DE15
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:25:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 15so18502629pfy.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+EIrJeMtiCyIrh4+i3M1UpFfZXZfQHuF1Sbl7JZWQrk=;
        b=ErhCcQ+zorEADPY2AD7hI6XkUOCyMXT5DX1PZ7JbMFOOHHrfacQHHmMJ0m7m1IGLx1
         BX/8w8jxGzV0uzabmKaXsKSbWMtGI1lUzGWQUkdPEAICCpAA9iihbdPZVjUeu4spTlJo
         ZSeTdZM6ITxHA0PceBeqVqtz53ZmOD9rsCEOrTpD8zGz1t8UfgvJ+YqZaTWW3cUwHGSs
         Cj1OLnWvF/CEpC4R//TdJQQUVX24DgjtvGvWnROLzBJfBe/lewTEjUJTT66mgGLCyBNx
         sePLtusf18IqVd960xiXPKjSB+6NH8Ja64bV+uhIy8idCAmqL5Sv7AuPqxEPOmPsFstp
         dvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EIrJeMtiCyIrh4+i3M1UpFfZXZfQHuF1Sbl7JZWQrk=;
        b=vEeRTXnbbazpLpQE1ar9SviI+Lm4h4vZWPbt7XqIGpi4p4zSQx8mh6FBbam51VU/4q
         1wiwwR7RbA2H4Uvvk30BO/h4M0tbkqzV9TcNu8I8x0ZMMeJgr2Rx6Ro2Knk5BaC2Azm8
         YYHppH89I6OuXR4nUCdxnL4Q+SCurx3hEAYEp/IX+PDsu324D0Ruw61gZQnfUo82xnx+
         +4KvdP3mEcfEP/KbJr4YoNR2sCdNIMnjAHnNiLm+B9LQArkmzBtMhpR3uFf56l+ppvT1
         0zJ3/m1z9IKCb64j6N3w+xKZPbB+C0aWi4hzN1JsGcjKl7TAoKwb0/duXYoymWKKLjRy
         3Q9Q==
X-Gm-Message-State: AOAM533xpG600jbhb4RA1aRkOhsmBW0WpDhfFc1RDXmMwriPtD1wQMvX
        FJwVEhN3uoN9LH4rKMz1DFA=
X-Google-Smtp-Source: ABdhPJzHmxLSt5atCAU5vvhojZs9Z/2Ph0gctt0fg+djQ27zInfEmKtnXjC/BgQLVaiiKF6l9g7TvQ==
X-Received: by 2002:a63:8241:0:b0:3fe:2e64:95f0 with SMTP id w62-20020a638241000000b003fe2e6495f0mr3394281pgd.190.1654698304348;
        Wed, 08 Jun 2022 07:25:04 -0700 (PDT)
Received: from ubuntu20 (n058152048072.netvigator.com. [58.152.48.72])
        by smtp.gmail.com with ESMTPSA id ik16-20020a170902ab1000b001635b86a790sm14665905plb.44.2022.06.08.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:25:03 -0700 (PDT)
Date:   Wed, 8 Jun 2022 22:24:57 +0800
From:   Zhipeng Shi <zhipeng.shi0@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, tglx@linutronix.de,
        schspa@gmail.com, shengjian.xu@horizon.ai,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rtmutex: Provide proper spin_is_contended
Message-ID: <20220608142457.GA2400218@ubuntu20>
References: <20220607091514.897833-1-zhipeng.shi0@gmail.com>
 <Yp8ZaHHBrHzg+o49@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp8ZaHHBrHzg+o49@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:24:56AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-06-07 17:15:14 [+0800], Zhipeng Shi wrote:
> > Commit d89c70356acf ("locking/core: Remove break_lock field when
> > CONFIG_GENERIC_LOCKBREAK=y") removed GENERIC_LOCKBREAK, which caused
> > spin_is_contended depend on the implementation of arch_spin_is_contended.
> > But now in rt-spinlock, spin_is_contended returns 0 directly.
> > 
> > This causes cond_resched_lock to fail to correctly detect lock contention
> > in RT-linux. In some scenarios (such as __purge_vmap_area_lazy in vmalloc),
> > this will cause a large latency.
> > 
> > This patch provides the implementation of spin_is_contended for
> > rt-spinlock.
> 
> Do you have a test-case or an example?

Sorry for late reply, here is my test-case.

After apply this patch, max-latency of vmalloc reduce from 10+ msec to
200+ usec, this because spin_lock is released halfway through 
__purge_vmap_area_lazy.

But today I find if I 'chrt -f 10' to my test script, There will still be 
a large latency in the vmalloc process. After trace, it seems update_curr_rt
leads to resched_curr. I haven't figured out the reason behind it, and I'm 
still trying to figure out why. I would really appreciate your thoughts 
on this issue.

Below is the test module
---------------------------------
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/poll.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <trace/events/kmem.h>

#define TEST_MALLOC_SIZE 64
#define MAX_OFF 20000

void* buf[MAX_OFF];
void* fub[MAX_OFF];
int off = 0;
int ffo = 0;

u64 total_time1 = 0;
u64 total_time2 = 0;

u64 total_cnt1 = 0;
u64 total_cnt2 = 0;
u64 alloc_time1[16];
u64 alloc_time2[16];
#define DECIMAL_BASE 10


#define MODULE_NAME "vmalloc_test"

unsigned long long duration_max = 0;

ssize_t vmalloc_test_proc_write(struct file *file,
		const char __user *buffer, size_t count, loff_t *pos)
{
	char set_str[4] = {0};
	uint32_t set_bits = 0;
	ssize_t err = 0;
	ktime_t time1, time2, delta;
	unsigned long long duration;
	int i = 0;

	err = simple_write_to_buffer((void*)set_str, sizeof(set_str) - 1u,
					pos, (const void*)buffer, count);
	if (err == 0)
		return err;
	if (kstrtouint(set_str, DECIMAL_BASE, &set_bits) != 0)
		return -EINVAL;

	switch (set_bits) {
	case 0:
		if (off >= MAX_OFF) {
			printk("buf number exceed\n");
			return -1;
		}

		time1 = ktime_get();

		buf[off] = vmalloc(TEST_MALLOC_SIZE);
		if (NULL == buf[off]) {
			printk("vmalloc buf failed\n");
			return -1;
		}
		memset(buf[off], 1, TEST_MALLOC_SIZE);
		off++;

		time2 = ktime_get();
		delta = ktime_sub(time2, time1);
		duration = (unsigned long long) ktime_to_ns(delta) >> 10;
		if (duration > 8000) {
			printk("%s:%d, elapse %llu usec\n",
				__func__, __LINE__, duration);
			return -1;
		}
		total_cnt1++;
		total_time1 += duration;
		alloc_time1[fls(duration) - 1]++;
		if (duration > duration_max)
			duration_max = duration;
		break;
	case 1:
		for (i = 0; i < MAX_OFF; i++) {
			if (buf[i] == NULL)
				break;

			vfree(buf[i]);
			buf[i] = NULL;
		}
		off = 0;
		break;
	case 2:
		if (ffo >= MAX_OFF) {
			printk("buf number exceed\n");
			return -1;
		}

		time1 = ktime_get();

		fub[ffo] = vmalloc(TEST_MALLOC_SIZE);
		if (NULL == fub[ffo]) {
			printk("vmalloc buf failed\n");
			return -1;
		}
		memset(fub[ffo], 1, TEST_MALLOC_SIZE);
		ffo++;

		time2 = ktime_get();
		delta = ktime_sub(time2, time1);
		duration = (unsigned long long) ktime_to_ns(delta) >> 10;
		if (duration > 8000) {
			printk("%s:%d, elapse %llu usec\n",
				__func__, __LINE__, duration);
			//return -1;
		}
		total_cnt2++;
		total_time2 += duration;
		alloc_time1[fls(duration)- 1]++;
		if (duration > duration_max)
			duration_max = duration;
		break;
	case 3:
		for (i = 0; i < MAX_OFF; i++) {
			if (fub[i] == NULL)
				break;

			vfree(fub[i]);
			fub[i] = NULL;
		}
		ffo = 0;
		break;

	default:
		printk("input error\n");
		return -EINVAL;
	}

	return (ssize_t)count;
}

static int32_t vmalloc_test_proc_show(struct seq_file *m, void *v)
{
	int i = 0;
	seq_printf(m, "max: %llu us\n", duration_max);
	seq_printf(m, "avg1: %llu us\n", total_time1/total_cnt1);
	seq_printf(m, "avg2: %llu us\n", total_time2/total_cnt2);
	for (i = 0; i < 16; i++) {
		seq_printf(m, "[%u ~ %u): %llu\n",
				1 << i, 1 << (i + 1), alloc_time1[i]);
	}
	return 0;
}

static int32_t vmalloc_test_fault_injection_proc_open(struct inode *inode,
							struct file *file)
{
	return single_open(file, vmalloc_test_proc_show, PDE_DATA(inode));
}


static const struct proc_ops vmalloc_test_fault_inject_proc_fops = {
	.proc_open		= vmalloc_test_fault_injection_proc_open,
	.proc_read		= seq_read,
	.proc_lseek		= seq_lseek,
	.proc_release		= single_release,
	.proc_write		= vmalloc_test_proc_write,
};

static struct proc_dir_entry *root_irq_dir = NULL;
static struct proc_dir_entry *entry;

#define vmalloc_test_FAULT_INJECTION_MODE 444
static int32_t vmalloc_test_register_procfs(void)
{
	if (NULL == root_irq_dir) {
		root_irq_dir = proc_mkdir("driver/vmalloc_test", NULL);
		if (NULL == root_irq_dir) {
			return -EINVAL;
		}
	}

	entry = proc_create_data("test",
			vmalloc_test_FAULT_INJECTION_MODE,
			root_irq_dir,
			&vmalloc_test_fault_inject_proc_fops, NULL);
	if (entry == NULL) {
		return -ENOMEM;
	}
	return 0;
}
static int32_t vmalloc_test_unregister_procfs(void)
{

	proc_remove(root_irq_dir);
	return 0;
}


static s32 __init vmalloc_test_init(void)
{
	int ret;

	ret = vmalloc_test_register_procfs();
	if (ret) {
		printk("register proc failed\n");
		return -1;
	}

	return 0;
}

module_init(vmalloc_test_init);/*PRQA S 0605*/

static void __exit vmalloc_test_exit(void)
{
	vmalloc_test_unregister_procfs();
	return;
}

module_exit(vmalloc_test_exit);/*PRQA S 0605*/

MODULE_AUTHOR("Sun Kaikai<kaikai.sun@horizon.com>");
MODULE_DESCRIPTION("Hobot GDC driver");
MODULE_LICENSE("GPL v2");
-------------------------------

Below is the test script no.1
-------------------------------------
#!/bin/bash

x=0
while true
do
	for i in {1..10000}
	do
		echo 0 > /proc/driver/vmalloc_test/test
		if [ $? != 0 ];then
			echo 0 > /sys/kernel/debug/tracing/tracing_on
			echo 1 > /proc/driver/vmalloc_test/test
			exit
		fi
	done
	echo 1 > /proc/driver/vmalloc_test/test
	echo "loop $x done"
	x=$((x+1))
done
---------------------------------

Below is the test script no.2
------------------------------
#!/bin/bash

x=0
while true
do
	for i in {1..10000}
	do
		echo 2 > /proc/driver/vmalloc_test/test
		if [ $? != 0 ];then
			echo 0 > /sys/kernel/debug/tracing/tracing_on
			echo 3 > /proc/driver/vmalloc_test/test
			exit
		fi
	done
	echo 3 > /proc/driver/vmalloc_test/test
	echo "loop1 $x done"
	x=$((x+1))
done
------------------------------


> 
> The thing if _this_ task has higher priority than other tasks waiting on
> this lock then a simple unlock+lock won't do a thing. That is why I
> ripped it all out while it was half way done.
> 
> > Signed-off-by: Zhipeng Shi <zhipeng.shi0@gmail.com>
> 
> Sebastian

Zhipeng
