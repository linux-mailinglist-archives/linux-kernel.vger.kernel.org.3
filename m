Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734B046D362
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhLHMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:38:02 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29162 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhLHMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:01 -0500
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J8Gl94L0bzXddF;
        Wed,  8 Dec 2021 20:32:21 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 20:34:27 +0800
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <keescook@chromium.org>, <jlayton@kernel.org>,
        <bfields@fieldses.org>, <yzaikin@google.com>, <wangle6@huawei.com>,
        Joe Perches <joe@perches.com>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
 <Ya/BnndSXKHiUpGm@bombadil.infradead.org>
 <875ys0azt8.fsf@email.froward.int.ebiederm.org>
 <Ya/iv33Ud+KRt9E9@bombadil.infradead.org>
 <17a19e3e-7a66-de73-ca83-078869f4d025@huawei.com>
 <YbAcISNGYlpSkYee@bombadil.infradead.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <22e685c0-9f0a-3fdd-f319-a272dce1fca3@huawei.com>
Date:   Wed, 8 Dec 2021 20:34:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <YbAcISNGYlpSkYee@bombadil.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/8 10:44, Luis Chamberlain wrote:
> On Wed, Dec 08, 2021 at 10:10:08AM +0800, Xiaoming Ni wrote:
>> On 2021/12/8 6:39, Luis Chamberlain wrote:
>>> On Tue, Dec 07, 2021 at 03:08:03PM -0600, Eric W. Biederman wrote:
>>>> Luis Chamberlain <mcgrof@kernel.org> writes:
>>>>
>>>>> On Mon, Dec 06, 2021 at 05:38:42PM -0800, Andrew Morton wrote:
>>>>>> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
>>>>>>> --- a/fs/inode.c
>>>>>>> +++ b/fs/inode.c
>>>>>>> @@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
>>>>>>>    	{ }
>>>>>>>    };
>>>>>>> -static int __init init_fs_inode_sysctls(void)
>>>>>>> -{
>>>>>>> -	register_sysctl_init("fs", inodes_sysctls);
>>>>>>> -	return 0;
>>>>>>> -}
>>>>>>> -early_initcall(init_fs_inode_sysctls);
>>>>>>> +fs_sysctl_initcall(inodes_sysctls);
>>>>>>>    #endif
>>>>>>
>>>>>> Here's another, of many.
>>>>>>
>>>>>> Someone made the decision to use early_initcall() here (why?) and this
>>>>>> patch switches it to late_initcall()!  Worrisome.  Each such stealth
>>>>>> conversion should be explained and justified, shouldn't it?
>>>>>
>>>>> I made the decisions for quite a bit of the ordering and yes I agree
>>>>> this need *very careful* explanation, specially if we are going to
>>>>> generalize this.
>>>>>
>>>>> First and foremost. git grep for sysctl_init_bases and you will see
>>>>> that the bases for now are initialized on proc_sys_init() and that
>>>>> gets called on proc_root_init() and that in turn on init/main.c's
>>>>> start_kernel(). And so this happens *before* the init levels.
>>>>>
>>>>> The proper care for what goes on top of this needs to take into
>>>>> consideration the different init levels and that the if a sysctl
>>>>> is using a directory *on top* of a base, then that sysctl registration
>>>>> must be registered *after* that directory. The *base* directory for
>>>>> "fs" is now registered through fs/sysctls.c() on init_fs_sysctls()
>>>>> using register_sysctl_base(). I made these changes with these names
>>>>> and requiring the DECLARE_SYSCTL_BASE() so it would be easy for us
>>>>> to look at where these are declared.
>>>>>
>>>>> So the next step in order to consider is *link* ordering and that
>>>>> order is maintained by the Makefile. That is why I put this at the
>>>>> top of the fs Makfile:
>>>>>
>>>>> obj-$(CONFIG_SYSCTL)            += sysctls.o
>>>>>
>>>>> So any file after this can use early_initcall(), because the base
>>>>> for "fs" was declared first in link order, and it used early_initcall().
>>>>> It is fine to have the other stuff that goes on top of the "fs" base
>>>>> use late_initcall() but that assumes that vetting has been done so that
>>>>> if a directory on "fs" was created, let's call it "foo", vetting was done
>>>>> to ensure that things on top of "foo" are registered *after* the "foo"
>>>>> directory.
>>>>>
>>>>> We now have done the cleanup for "fs", and we can do what we see fine
>>>>> for "fs", but we may run into surprises later with the other bases, so
>>>>> I'd be wary of making assumptions at this point if we can use
>>>>> late_initcall().
>>>>>
>>>>> So, as a rule of thumb I'd like to see bases use early_initcall(). The
>>>>> rest requires manual work and vetting.
>>>>>
>>>>> So, how about this, we define fs_sysctl_initcall() to use also
>>>>> early_initcall(), and ask susbsystems to do their vetting so that
>>>>> the base also gets linked first.
>>>>>
>>>>> After this, if a directory on top of a base is created we should likely create
>>>>> a new init level and just bump that to use the next init level. So
>>>>> something like fs_sysctl_base_initcall_subdir_1() map to core_initcall()
>>>>> and so on.
>>>>>
>>>>> That would allow us to easily grep for directory structures easily and
>>>>> puts some implicit onus of ordering on those folks doing these conversions.
>>>>> We'd document well the link order stuff for those using the base stuff
>>>>> too as that is likely only where this will matter most.
>>>>
>>>> I am a bit confused at this explanation of things.
>>>>
>>>> Last I looked the implementation of sysctls allocated the directories
>>>> independently of the sysctls entries that populated them.
>>>
>>> With most sysctls being created using the same kernel/sysctl.c file and
>>> structure, yes, this was true. With the changes now on linux-next things
>>> change a bit. The goal is to move sysctls to be registered where they
>>> are actually defined. But the directory that holds them must be
>>> registered first. During the first phase of cleanups now on linux-next
>>> all filesystem "fs" syscls were moved to be delcared in the kernel's
>>> fs/ directory. The last part was to register the base "fs" directory.
>>> For this declareres were added to simplify that and to clarify which
>>> are base directories:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ededd3fc701668743087c77ceeeb7490107cc12c
>>>
>>> Then, this commit moves the "fs" base to be declared to fs/ as well:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d0f885a73ec6e05803ce99f279232b3116061ed8
>>>
>>> This used early_initcall() for the base for "fs" and that is
>>> because there are no built-in sysctls for "fs" which need to
>>> be exposed prior to the init levels.
>>>
>>> So after this then order is important. If you are using the same
>>> init level, the the next thing which will ensure order is the order
>>> of things being linked, so what order they appear on the Makefile.
>>> And this is why the base move for the "fs" sysctl directory is kept
>>> at the top of fs/Makfile:
>>>
>>> obj-$(CONFIG_SYSCTL)		+= sysctls.o
>>>
>>>     Luis
>>> .
>>>
>>
>> Root node of the tree, using "early_initcall":
>> 	Basic framework,  "fs", "kernel", "debug", "vm", "dev", "net"
> 
> register_sysctl_base() and yes these use early_initcall() as-is on
> linux-next.
> 
>> Fork node. Select initcall_level based on the number of directory levels:
>> 	Registration directory shared by multiple features.
> 
> Sure.
> 
/proc/sys/kernel/random/
	random_table
	driver/char/random.c
/proc/sys/kernel/usermodehelper/
	usermodehelper_table
	kernel/umh.c
/proc/sys/kernel/firmware_config/
	firmware_config_table
	drivers/base/firmware_loader/fallback_table.c
/proc/sys/kernel/keys/
	key_sysctls
	security/keys/sysctl.c
/proc/sys/fs/inotify/
	inotify_table
	fs/notify/inotify/inotify_user.c
/proc/sys/fs/fanotify/
	fanotify_table
	fs/notify/fanotify/fanotify_user.c
/proc/sys/fs/epoll
	epoll_table
	fs/eventpoll.c

I haven't checked all the sysctl subdirectories, but it seems that many 
are not shared by multiple features.
Most features use the sysctl mechanism simply to create a file interface 
for configuring parameters.
There are few scenarios for creating directories for other features.
There may be tree fork nodes, but only a few.


>> Leaf node, use "late_initcall":
>> 	File Interface
> 
> I am not sure this gives enough guidance. What is the difference between
> fork node and a leaf node?
Leaf node:
a) File, .child = NULL
b) Directory, which is not shared by multiple features, .child != NULL


Thanks
Xiaoming Ni

