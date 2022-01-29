Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65224A302C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 16:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiA2PD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 10:03:26 -0500
Received: from unknown-3-146.windriver.com ([147.11.3.146]:10400 "EHLO
        mail1.wrs.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231262AbiA2PDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 10:03:24 -0500
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 20TF32QB028568
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 29 Jan 2022 07:03:03 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 20TF31MO010214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Jan 2022 07:03:01 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 29 Jan 2022 07:03:01 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 07:03:01 -0800
Received: from pek-lpd-ccm2.wrs.com (128.224.179.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sat, 29 Jan 2022 07:02:58 -0800
From:   Dongyang Wang <dongyang.wang@windriver.com>
To:     <manfred@colorfullife.com>
CC:     <akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <dave@stgolabs.net>, <dongyang.wang@windriver.com>,
        <ebiederm@xmission.com>, <legion@kernel.org>,
        <linux-kernel@vger.kernel.org>, <varad.gautam@suse.com>
Subject: Re: [PATCH] To fix the below failure of handling page fault caused by the invalid input from user.
Date:   Sat, 29 Jan 2022 23:02:58 +0800
Message-ID: <20220129150258.5896-1-dongyang.wang@windriver.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <7de781c8-f71f-35e2-a335-f9b13de691db@colorfullife.com>
References: <7de781c8-f71f-35e2-a335-f9b13de691db@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred and Andrew,

Thanks for your feedback.

>Hi Dongyang,
>
>On 1/26/22 03:42, Andrew Morton wrote:
>> On Tue, 18 Jan 2022 17:19:52 +0800 Dongyang Wang <dongyang.wang@windriver.com> wrote:
>>
>>> [786058.308965] Unable to handle kernel paging request at virtual address 01000004
>>> [786058.316286] pgd = 38a99693
>>> [786058.319080] [01000004] *pgd=07800003, *pmd=00000000
>>> [786058.324056] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>>> [786058.324100] CPU:  PID: Comm:  Tainted: G         C
>>> [786058.324102] Hardware name:
>>> [786058.324114] PC is at __copy_to_user_std+0x4c/0x3c4
>>> [786058.324120] LR is at store_msg+0xc0/0xe8
>>> [786058.324124] pc : [<c0c0587c>]    lr : [<c0871d04>]    psr: 20010013
>>> [786058.324126] sp : c3503ec4  ip : 00000000  fp : b4c9a660
>>> [786058.324129] r10: c4228dc0  r9 : c3502000  r8 : 00000ffc
>>> [786058.324132] r7 : 01000000  r6 : 546d3f8b  r5 : b4911690  r4 : 00000ffc
>>> [786058.324134] r3 : 00000000  r2 : 00000f7c  r1 : 01000004  r0 : b4911690
>>> [786058.324139] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>> [786058.324142] Control: 30c5387d  Table: 0edc2040  DAC: 55555555
>>> [786058.324145] Process  (pid: , stack limit = 0x25018bdf)
>
>Why is process and pid: empty? Is this some kind of kernel process calling?

The pid is 8369, it's a userspace app.

>
>>> [786058.324148] Stack: (0xc3503ec4 to 0xc3504000)
>>> [786058.324153] 3ec0:          b4911690 546d3f8b 01000000 00000ffc b4911690 00000ffc 00000000
>>> [786058.324157] 3ee0: 00000ffc c0871d04 546d4f73 c3407801 c3503f28 c3407800 00000000 b49106a8
>>> [786058.324161] 3f00: c4228dc0 c087abd4 00000002 b49106a8 617b9d03 00000000 00000000 c121d508
>>> [786058.324165] 3f20: 00000000 bf06a1a8 d1b634cc 16b26e77 c5af5280 00000100 00000200 db806540
>>> [786058.324170] 3f40: 00000001 c121d508 00000008 0000005c 00000000 00010008 b49106a8 c0601208
>>> [786058.324173] 3f60: c3502000 00000040 b4c9a660 c087b474 c3503f78 c121d508 617b9d03 00000000
>>> [786058.324177] 3f80: 2303d6cc 00000115 c0601208 c121d508 b4c9a660 b4c9a660 00000001 b49106a8
>>> [786058.324181] 3fa0: 00000115 c06011dc b4c9a660 00000001 0000005c b49106a8 00010008 00000000
>>> [786058.324185] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
>>> [786058.324189] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6 800d0030 0000005c 00000000 00000000
>>> [786058.324201] [<c0c0587c>] (__copy_to_user_std) from [<c0871d04>] (store_msg+0xc0/0xe8)
>>> [786058.324211] [<c0871d04>] (store_msg) from [<c087abd4>] (do_mq_timedreceive+0x29c/0x484)
>>> [786058.324218] [<c087abd4>] (do_mq_timedreceive) from [<c087b474>] (sys_mq_timedreceive+0x88/0xbc)
>>> [786058.324226] [<c087b474>] (sys_mq_timedreceive) from [<c06011dc>] (__sys_trace_return+0x0/0x10)
>>> [786058.324229] Exception stack(0xc3503fa8 to 0xc3503ff0)
>>> [786058.324233] 3fa0:                   b4c9a660 00000001 0000005c b49106a8 00010008 00000000
>>> [786058.324236] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
>>> [786058.324239] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6
>>> [786058.324247] Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
>>> [786058.601808] ---[ end trace 0000000000000002 ]---
>>>
>>> ...
>>>
>> Please describe the circumstances under which this occurs.

The system crashed after running 9 days. 
Unfortunately, we don't know how the user space APP running, it's a black box for us.

>>
>> Please also describe how your proposed patch fixes this.

Do some check for the input parameters from the userspace. 
This crash may be caused by the APP, and I know the right way is to change the APP's behavior.
But I think maybe the kernel side also can do some checks for the input parameters?  To improve the robustness?
I'm not sure. but I want to have a try, so I pushed this patch.  Thanks :) 

>>
>>> --- a/ipc/mqueue.c
>>> +++ b/ipc/mqueue.c
>>> @@ -1211,6 +1211,12 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>>>   		goto out_fput;
>>>   	}
>>>   
>>> +	/* checks if buffer is invalid */
>>> +	if ((unsigned long) u_msg_ptr < PAGE_SIZE) {
>>> +		ret = -EINVAL;
>>> +		goto out_fput;
>>> +	}
>>> +
>
>I do not think that this will solve the problem: u_msg_ptr is user 
>controlled.
>
>If < PAGE_SIZE causes issues, then 2^32-1, or PAGE_SIZE+1 will cause 
>issues as well.

Thank you!  you are right. 
I want to check the validity of the u_msg_ptr. But it seems this check is not enough now.

>
>What is the kernel version where you have observed the issue?
>

The kernel version is 4.18.

>>>   	/*
>>>   	 * msg_insert really wants us to have a valid, spare node struct so
>>>   	 * it doesn't have to kmalloc a GFP_ATOMIC allocation, but it will
>>> @@ -1262,6 +1268,10 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>>>   			store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
>>>   			ret = -EFAULT;
>>>   		}
>>> +
>>> +		if (msg_len < ret)
>>> +			ret = -EMSGSIZE;
>>> +
>
>Why this change?
>
>EMSGSIZE means right now: wrong parameters, no message removed from the 
>queue.
>
>But: in the line you modify, a message was already removed from the 
>queue. Thus I would not consider EMSGSIZE as appropriate.
>
>>>   		free_msg(msg_ptr);
>>>   	}
>>>   out_fput:
>>> -- 
>>> 2.26.1

Sorry, rewrite this part like this:
        if (ret == 0) {
                ret = msg_ptr->m_ts;

-               if ((u_msg_prio && put_user(msg_ptr->m_type, u_msg_prio)) ||
-                       store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
+               if (u_msg_prio && put_user(msg_ptr->m_type, u_msg_prio))
                        ret = -EFAULT;
-               }
+               if (msg_len < ret)
+                       ret = -EMSGSIZE;
+               if (store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts))
+                       ret = -EFAULT;
+
                free_msg(msg_ptr);
        }
Add a check before call the store_msg.
About the return value: EMSGSIZE.
How about this meaning?  #define	EMSGSIZE	90	/* Message too long */
