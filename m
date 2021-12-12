Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DFE47198D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 10:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhLLJ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 04:58:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29185 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhLLJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 04:58:51 -0500
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JBg5g25fQzB6dw;
        Sun, 12 Dec 2021 17:56:39 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 12 Dec 2021 17:58:49 +0800
Subject: Re: [PATCH v2] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <ebiederm@xmission.com>, <keescook@chromium.org>,
        <jlayton@kernel.org>, <bfields@fieldses.org>, <yzaikin@google.com>,
        <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <julia.lawall@inria.fr>,
        <akpm@linux-foundation.org>, <wangle6@huawei.com>
References: <YbEQG1MrjHreKFmw@bombadil.infradead.org>
 <20211210085849.66169-1-nixiaoming@huawei.com>
 <YbOMSUBRWAUFyDbQ@bombadil.infradead.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <02907871-95a9-8cdb-ff73-744e3feb4257@huawei.com>
Date:   Sun, 12 Dec 2021 17:58:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <YbOMSUBRWAUFyDbQ@bombadil.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/11 1:20, Luis Chamberlain wrote:
> On Fri, Dec 10, 2021 at 04:58:49PM +0800, Xiaoming Ni wrote:
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
> 
> It was nice to have this documented in the commit log, however you
> don't provide a developer documentation for this in your changes.
> Can you justify through documentation why we can use init levels
> with the above information for the sysctl_initcall() macro?
> 
>> The sysctl interface of each subfeature should be registered after
>> sysctl_init_bases() and before do_sysctl_args().
> 
> Indeed.
> 
>> It seems
> 
> Seems is poor judgement for a change in the kernel. It is or not.
> 
>> that the sysctl
>> interface does not depend on initcall_levels. To prevent the sysctl
>> interface from being initialized before the feature itself. The
>> lowest-level
> 
> Lower to me means early, but since we are talking about time, best
> to clarify and say the latest init level during kernel bootup.
> 
>> late_initcall() is used as the common sysctl interface
>> registration level.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>>
>> ---
>> v2:
>>    Add a simple checkpatch check.
>>    Add code comment.
>> v1:
>>    https://lore.kernel.org/lkml/20211207011320.100102-1-nixiaoming@huawei.com/
>> ---
>>   fs/coredump.c          |  7 +------
>>   fs/dcache.c            |  7 +------
>>   fs/exec.c              |  8 +-------
>>   fs/file_table.c        |  7 +------
>>   fs/inode.c             |  7 +------
>>   fs/locks.c             |  7 +------
>>   fs/namei.c             |  8 +-------
>>   fs/namespace.c         |  7 +------
>>   include/linux/sysctl.h | 19 +++++++++++++++++++
>>   kernel/stackleak.c     |  7 +------
>>   scripts/checkpatch.pl  |  6 ++++++
>>   11 files changed, 34 insertions(+), 56 deletions(-)
>>
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index 570d98398668..8f6c6322651d 100644
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
> Nice.
> 
> Yes, although I went with fs_initcall() your documentation above
> does give us certainty that this is fine as well. No need to kick
> this through earlier.
> 
>>   #endif /* CONFIG_SYSCTL */
>>   
>>   /*
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index 0eef1102f460..c1570243aaee 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -195,12 +195,7 @@ static struct ctl_table fs_dcache_sysctls[] = {
>>   	{ }
>>   };
>>   
>> -static int __init init_fs_dcache_sysctls(void)
>> -{
>> -	register_sysctl_init("fs", fs_dcache_sysctls);
>> -	return 0;
>> -}
>> -fs_initcall(init_fs_dcache_sysctls);
>> +fs_sysctl_initcall(fs_dcache_sysctls);
> 
> Seems fine by me using the same logic as above and I like that
> you are splitting this by bases. Likewise for the others, this
> is looking good.
> 
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index acf0805cf3a0..ce33e61a8287 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -231,6 +231,25 @@ extern int sysctl_init_bases(void);
>>   extern void __register_sysctl_init(const char *path, struct ctl_table *table,
>>   				 const char *table_name);
> 
> Yes please take the time to write some documentation here which can
> explain to developers *why* we use the init levels specified.
> 
>>   #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
>> +

/** 

  * sysctl_initcall() - register and init sysctl leaf node to path 

  * @path:  path name for sysctl base 

  * @table: This is the sysctl leaf table that needs to be registered to 
the path
  * 

  * Leaf node in the sysctl tree: 

  * a) File, .child = NULL 

  * b) Directory, which is not shared by multiple features, .child != 
NULL
  * 

  * The sysctl interface for each subfeature should be in the after 

  * sysctl_init_bases() and before do_sysctl_args(). 

  * sysctl_init_bases() is executed before early_initcall(). 

  * do_sysctl_args() is executed after late_initcall(). 

  * Therefore, it is safe to add leaves to the sysctl tree using 
late_initcall().
  */

How about that description?

>> +#define sysctl_initcall(path, table) \
>> +	static int __init init_##table(void) \
>> +	{ \
>> +		register_sysctl_init(path, table); \
>> +		return  0;\
>> +	} \
>> +	late_initcall(init_##table)
>> +
>> +/*
>> + * Use xxx_sysctl_initcall() to initialize your sysctl interface unless you want
>> + * to register the sysctl directory and share it with other features.
>> + */
>> +#define kernel_sysctl_initcall(table) sysctl_initcall("kernel", table)
>> +#define fs_sysctl_initcall(table) sysctl_initcall("fs", table)
>> +#define vm_sysctl_initcall(table) sysctl_initcall("vm", table)
>> +#define debug_sysctl_initcall(table) sysctl_initcall("debug", table)
>> +#define dev_sysctl_initcall(table) sysctl_initcall("dev", table)
>> +
>>   extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
>>   
>>   void do_sysctl_args(void);
> 
>    Luis
> .
> 

Thanks
Xiaoming Ni
