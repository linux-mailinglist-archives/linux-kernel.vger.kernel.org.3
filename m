Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA0147D697
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbhLVSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:24:55 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:56342 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbhLVSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:24:53 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:50884)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n06IE-00DHk6-MV; Wed, 22 Dec 2021 11:24:50 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:47466 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n06IC-004wrR-9I; Wed, 22 Dec 2021 11:24:50 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
        <87tuf79gni.fsf@email.froward.int.ebiederm.org>
        <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
        <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
        <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
Date:   Wed, 22 Dec 2021 12:24:08 -0600
In-Reply-To: <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com> (Mike
        Christie's message of "Wed, 22 Dec 2021 11:32:25 -0600")
Message-ID: <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n06IC-004wrR-9I;;;mid=<87pmpoxzuf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194jyDU5R7FpENXqa8npM2lamawzXnFLtk=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1804 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.6 (0.3%), b_tie_ro: 3.3 (0.2%), parse: 1.32
        (0.1%), extract_message_metadata: 17 (0.9%), get_uri_detail_list: 5
        (0.3%), tests_pri_-1000: 5 (0.3%), tests_pri_-950: 1.04 (0.1%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 89 (4.9%), check_bayes: 88
        (4.9%), b_tokenize: 11 (0.6%), b_tok_get_all: 12 (0.7%), b_comp_prob:
        2.9 (0.2%), b_tok_touch_all: 59 (3.2%), b_finish: 0.70 (0.0%),
        tests_pri_0: 1670 (92.6%), check_dkim_signature: 0.44 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 1.13 (0.1%), tests_pri_10:
        3.0 (0.2%), tests_pri_500: 9 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> On 12/21/21 6:20 PM, Eric W. Biederman wrote:
>> michael.christie@oracle.com writes:
>> 
>>> On 12/17/21 1:26 PM, Eric W. Biederman wrote:
>>>> Mike Christie <michael.christie@oracle.com> writes:
>>>>
>>>>> The following patches made over Linus's tree, allow the vhost layer to do
>>>>> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
>>>>> io_uring does a copy_process against its userspace app. This allows the
>>>>> vhost layer's worker threads to inherit cgroups, namespaces, address
>>>>> space, etc and this worker thread will also be accounted for against that
>>>>> owner/parent process's RLIMIT_NPROC limit.
>>>>>
>>>>> If you are not familiar with qemu and vhost here is more detailed
>>>>> problem description:
>>>>>
>>>>> Qemu will create vhost devices in the kernel which perform network, SCSI,
>>>>> etc IO and management operations from worker threads created by the
>>>>> kthread API. Because the kthread API does a copy_process on the kthreadd
>>>>> thread, the vhost layer has to use kthread_use_mm to access the Qemu
>>>>> thread's memory and cgroup_attach_task_all to add itself to the Qemu
>>>>> thread's cgroups.
>>>>>
>>>>> The problem with this approach is that we then have to add new functions/
>>>>> args/functionality for every thing we want to inherit. I started doing
>>>>> that here:
>>>>>
>>>>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!eIaEe9V8mCgGU6vyvaWTKGi3Zlnz0rgk5Y-0nsBXRbsuVZsM8lYfHr8I8GRuoLYPYrOB$ 
>>>>>
>>>>> for the RLIMIT_NPROC check, but it seems it might be easier to just
>>>>> inherit everything from the beginning, becuase I'd need to do something
>>>>> like that patch several times.
>>>>
>>>> I read through the code and I don't see why you want to make these
>>>> almost threads of a process not actually threads of that process
>>>> (like the io_uring threads are).
>>>>
>>>> As a separate process there are many things that will continue to be
>>>> disjoint.  If the thread changes cgroups for example your new process
>>>> won't follow.
>>>>
>>>> If you want them to be actually processes with an lifetime independent
>>>> of the creating process I expect you want to reparent them to the local
>>>> init process.  Just so they don't confuse the process tree.  Plus init
>>>> processes know how to handle unexpected children.
>>>>
>>>> What are the semantics you are aiming for?
>>>>
>>>
>>> Hi Eric,
>>>
>>> Right now, for vhost we need the thread being created:
>>>
>>> 1. added to the caller's cgroup.
>>> 2. to share the mm struct with the caller.
>>> 3. to be accounted for under the caller's nproc rlimit value.
>>>
>>> For 1 and 2, we have cgroup_attach_task_all and get_task_mm
>>> already.
>>>
>>> This patchset started with me just trying to handle #3 by modifying kthreads
>>> like here:
>>>
>>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1234__;!!ACWV5N9M2RV99hQ!bvqZOWy7TxQyq18L4I_a5MxP2OX0V2imOYEJrWsc-LkyVTI_zpFzxyV2pM_dgYywwH2y$ 
>>>
>>> So we can use kthreads and the existing helpers and add:
>>>
>>> A. a ucounts version of the above patches in the link
>>>
>>> or
>>>
>>> B. a helper that does something like copy_process's use of
>>> is_ucounts_overlimit and vhost can call that.
>>>
>>> instead of this patchset.
>> 
>> I don't fundamentally hate the patchset.  I do have concerns about
>> the completely broken patch.
>> 
>> With respect this patchset my gut says decide.  Are you a thread of the
>> process (just use create_io_worker) are you a separate process forked
>> from the caller (use a cousin of create_io_worker but don't touch
>> create_io_worker).  I think being a process vs being a thread is such a
>> fundamental difference we don't want to mix the helpers.
>> 
>>> Before we even get to the next section below, do you consider items 1 - 3
>>> something we need an API based on copy_process for?
>> 
>> I think 3 staying in the callers nproc strongly suggests you want to
>> reuse copy_process.  Which gets back to my question do you want
>> a thread or do you want a process.
>> 
>> 
>> For me a key detail is what is the lifetime of the vhost device?
>> 
>> Does the vhost go away when the caller goes away?
>
> Yes. When the caller, normally qemu in our case, that created the worker
> thread exits, then we free the vhost devices and stop and free the worker
> threads we are creating in this patchset.
>
> However, I'm not sure if it makes a difference to you, but we also have second
> way to free a vhost device and its worker thread. The user can run a command
> that instructs the the qemu process to free the vhost device and its worker
> thread.

I dug a little deeper to understand how this works, and it appears to be
a standard file descriptor based API.  The last close of the file
descriptor is what causes the vhost_dev_cleanup to be called which shuts
down the thread.

This means that in rare cases the file descriptor can be passed to
another process and be held open there, even after the main process
exits.

This says to me that much as it might be handy your thread does not
strictly share the same lifetime as your qemu process.


>>   If so you can create a thread in the caller's process that only performs
>>   work in kernel space.  At which point you are essentially
>>   create_io_thread.
>> 
>> If the vhost device can live after the caller goes away how is that managed?
>
> When the caller goes away we free the devices and their worker threads.
>
> Either before the caller exists it does an explicit close to release the device
> which frees the device and its worker thread, or when the process exits and the
> kernel does a put on its open devices that will trigger the vhost device's release
> function and we free device and its thread at that time.

All of which says to me that the vhost devices semantically work well as
separate processes (that never run userspace code) not as threads of the
creating userspace process.

So I would recommend creating a minimal version of the kthread api,
using create_process targeted only at the vhost case.  Essentially what
you have done with this patchset, but without any configuration knobs
from the callers perspective.

Which means that you can hard code calling ignore_signals, and the
like, instead of needing to have a separate configuration knob for each
place io_workers are different from vhost_workers.

In the future I can see io_workers evolving into a general user space
thread that only runs code in the kernel abstraction, and I can see
vhost_workers evolving into a general user space process that only runs
code in the kernel abstraction.

For now we don't need that generality so please just create a
create_vhost_process helper akin to create_io_thread that does just what
you need.

I don't know if it is better to base it on kernel_clone or on
copy_process.  All I am certain of is that you need to set
"args->exit_signal = -1;".  This prevents having to play games with
do_notify_parent.

Eric
