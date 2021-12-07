Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2E46B145
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhLGDNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:13:33 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15706 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhLGDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:13:32 -0500
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J7QFX2XlWzZd20;
        Tue,  7 Dec 2021 11:07:12 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 11:10:01 +0800
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <viro@zeniv.linux.org.uk>, <ebiederm@xmission.com>,
        <keescook@chromium.org>, <jlayton@kernel.org>,
        <bfields@fieldses.org>, <yzaikin@google.com>, <wangle6@huawei.com>,
        Joe Perches <joe@perches.com>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <48fcbbc2-5832-3258-5822-b554e6df3366@huawei.com>
Date:   Tue, 7 Dec 2021 11:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/7 9:38, Andrew Morton wrote:
> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> 
>> To avoid duplicated code, add a set of macro functions to initialize the
>> sysctl table for each feature.
>>
>> The system initialization process is as follows:
>>
>> 	start_kernel () {
>> 		...
>> 		/* init proc and sysctl base,
>> 		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
>> 		 */
>> 		proc_root_init(); /* init proc and sysctl base */
>> 		...
>> 		arch_call_rest_init();
>> 	}
>>
>> 	arch_call_rest_init()-->rest_init()-->kernel_init()
>> 	kernel_init() {
>> 		...
>> 		kernel_init_freeable(); /* do all initcalls */
>> 		...
>> 		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
>> 	}
>>
>> 	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
>> 	do_initcalls() {
>> 		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
>> 			do_initcall_level
>> 	}
>>
>> The sysctl interface of each subfeature should be registered after
>> sysctl_init_bases() and before do_sysctl_args(). It seems that the sysctl
>> interface does not depend on initcall_levels. To prevent the sysctl
>> interface from being initialized before the feature itself. The
>> lowest-level late_initcall() is used as the common sysctl interface
>> registration level.
> 
> I'm not normally a fan of wrapping commonly-used code sequences into
> magical macros, but this one does seem to make sense.
> 
> I wonder if it is possible to cook up a checkpatch rule to tell people
> to henceforth use the magic macros rather than to open-code things in
> the old way.  Sounds hard.
> 
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -943,12 +943,7 @@ static struct ctl_table coredump_sysctls[] = {
>>   	{ }
>>   };
>>   
>> -static int __init init_fs_coredump_sysctls(void)
>> -{
>> -	register_sysctl_init("kernel", coredump_sysctls);
>> -	return 0;
>> -}
>> -fs_initcall(init_fs_coredump_sysctls);
>> +kernel_sysctl_initcall(coredump_sysctls);
> 
> But this and several like it are functional changes.
> 
>>   #endif /* CONFIG_SYSCTL */
>>
>> ...
>>
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
>>   	{ }
>>   };
>>   
>> -static int __init init_fs_inode_sysctls(void)
>> -{
>> -	register_sysctl_init("fs", inodes_sysctls);
>> -	return 0;
>> -}
>> -early_initcall(init_fs_inode_sysctls);
>> +fs_sysctl_initcall(inodes_sysctls);
>>   #endif
> 
> Here's another, of many.
> 
> Someone made the decision to use early_initcall() here (why?) and this
> patch switches it to late_initcall()!  Worrisome.  Each such stealth
> conversion should be explained and justified, shouldn't it?
> 

static noinline void __init kernel_init_freeable(void)
{
	...
	do_pre_smp_initcalls(); /* do early_initcall */
	lockup_detector_init();

	smp_init();
	sched_init_smp();

	padata_init();
	page_alloc_init_late();
	/* Initialize page ext after all struct pages are initialized. */
	page_ext_init();

	do_basic_setup();  /* do other initcall */
	...
}

Between do_pre_smp_initcalls() and do_basic_setup(), no sysctl interface 
window is configured. In addition, all sysctl data has initial values. 
Delayed configuration does not affect the behavior after startup.
So I think we can change it to late_initcall().


Thanks
Xiaoming Ni
