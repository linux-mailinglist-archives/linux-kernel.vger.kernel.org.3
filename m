Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E24CCF1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiCDHfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiCDHfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:35:09 -0500
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B5EA2F29
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:34:21 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 2247XY0G007345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Mar 2022 23:33:34 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 3 Mar 2022 23:33:34 -0800
Received: from pek-lpd-ccm2.wrs.com (128.224.179.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Thu, 3 Mar 2022 23:33:31 -0800
From:   Dongyang Wang <dongyang.wang@windriver.com>
To:     <dongyang.wang@windriver.com>
CC:     <akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <dave@stgolabs.net>, <ebiederm@xmission.com>, <legion@kernel.org>,
        <linux-kernel@vger.kernel.org>, <manfred@colorfullife.com>,
        <varad.gautam@suse.com>
Subject: Re: [PATCH] To fix the below failure of handling page fault caused by the invalid input from user.
Date:   Fri, 4 Mar 2022 15:33:30 +0800
Message-ID: <20220304073330.13587-1-dongyang.wang@windriver.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20220209072820.18238-1-dongyang.wang@windriver.com>
References: <20220209072820.18238-1-dongyang.wang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> On 1/26/22 03:42, Andrew Morton wrote:
>>>>> On Tue, 18 Jan 2022 17:19:52 +0800 Dongyang Wang <dongyang.wang@windriver.com> wrote:
>>>>>
>>>>>> [786058.308965] Unable to handle kernel paging request at virtual address 01000004
>>>>>> [786058.316286] pgd = 38a99693
>>>>>> [786058.319080] [01000004] *pgd=07800003, *pmd=00000000
>>>>>> [786058.324056] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>>>>>> [786058.324100] CPU:  PID: Comm:  Tainted: G         C
>>>>>> [786058.324102] Hardware name:
>>>>>> [786058.324114] PC is at __copy_to_user_std+0x4c/0x3c4
>>>>>> [786058.324120] LR is at store_msg+0xc0/0xe8
>>>>>> [786058.324124] pc : [<c0c0587c>]    lr : [<c0871d04>]    psr: 20010013
>>>>>> [786058.324126] sp : c3503ec4  ip : 00000000  fp : b4c9a660
>>>>>> [786058.324129] r10: c4228dc0  r9 : c3502000  r8 : 00000ffc
>>>>>> [786058.324132] r7 : 01000000  r6 : 546d3f8b  r5 : b4911690  r4 : 00000ffc
>>>>>> [786058.324134] r3 : 00000000  r2 : 00000f7c  r1 : 01000004  r0 : b4911690
>>>>>> [786058.324139] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>>>>> [786058.324142] Control: 30c5387d  Table: 0edc2040  DAC: 55555555
>>>>>> [786058.324145] Process  (pid: , stack limit = 0x25018bdf)
>>>> Why is process and pid: empty? Is this some kind of kernel process calling?
>>> The pid is 8369, it's a userspace app.
>>>
>>>>>> [786058.324148] Stack: (0xc3503ec4 to 0xc3504000)
>>>>>> [786058.324153] 3ec0:          b4911690 546d3f8b 01000000 00000ffc b4911690 00000ffc 00000000
>>>>>> [786058.324157] 3ee0: 00000ffc c0871d04 546d4f73 c3407801 c3503f28 c3407800 00000000 b49106a8
>>>>>> [786058.324161] 3f00: c4228dc0 c087abd4 00000002 b49106a8 617b9d03 00000000 00000000 c121d508
>>>>>> [786058.324165] 3f20: 00000000 bf06a1a8 d1b634cc 16b26e77 c5af5280 00000100 00000200 db806540
>>>>>> [786058.324170] 3f40: 00000001 c121d508 00000008 0000005c 00000000 00010008 b49106a8 c0601208
>>>>>> [786058.324173] 3f60: c3502000 00000040 b4c9a660 c087b474 c3503f78 c121d508 617b9d03 00000000
>>>>>> [786058.324177] 3f80: 2303d6cc 00000115 c0601208 c121d508 b4c9a660 b4c9a660 00000001 b49106a8
>>>>>> [786058.324181] 3fa0: 00000115 c06011dc b4c9a660 00000001 0000005c b49106a8 00010008 00000000
>>>>>> [786058.324185] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
>>>>>> [786058.324189] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6 800d0030 0000005c 00000000 00000000
>>>>>> [786058.324201] [<c0c0587c>] (__copy_to_user_std) from [<c0871d04>] (store_msg+0xc0/0xe8)
>>
>>I would search here: __copy_to_user_std should fail if the address is 
>>invalid.
>>
>>For whatever reasons, it produces a page fault.
>
>Totally agree with you. 
>
>>First: Is this reproducible? Does it fail immediately if you pass an 
>>invalid value to mq_timedreceive()?
>
>This crash info is from another team. It can't be reproduced until now.
>Yesterday, I changed the 'u_msg_ptr' and 'msg_ptr->m_ts' to a wrong value, but don't cause crash. 
>I will watch this part. 

Status update:
Sorry, after changing the "u_msg_ptr", "msg_ptr->m_ts" to the wrong value, I still can't reproduce this issue. 

>>https://elixir.bootlin.com/linux/v4.18.20/source/arch/arm/include/asm/uaccess.h#L464
>>
>>It seems ARM has special optimizations (CONFIG_UACCESS_WITH_MEMCPY), and 
>>I cannot see if this is MMU or NO_MMU
>
>This is MMU. 

Best Regards,
Dongyang
