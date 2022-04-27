Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E4511092
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357884AbiD0Fhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiD0Fhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:37:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1614D9E0;
        Tue, 26 Apr 2022 22:34:43 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R1jrb4016461;
        Wed, 27 Apr 2022 05:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qvcqSETCnrSsVB/BY/2FeP2hnvOR7fL3OJ1Z/zo8n8Y=;
 b=k1nI4OI10xALs2/hzr8UhYW9h9IrOmFoU2I5Q/J/BR8YqvpScp6XwQuC2BuMHkrHTl5u
 IIh3PCTtMf4gF7x1RoVAZX4mOanbC7zafMrFoUViASCe6Vw/R2pXo6wWT7qKnGJ5kzTZ
 2/DWGBEQC3dWgsXqnVTnGjBDFeNNNiY91XGL7MOWGV8F9f4NYxHSutfdN96QmicQQcoa
 CgjgmWI0Kq8z5KvHiYq1442XaiJ4nOL7TGswFnnz6YB+nogLJ7bJDI8VOAV9xoKC6dkq
 OFafQVpbJ1BWUzBPEWkk5DUVlR0v+VCEv3kLn0T20ZLtcWdZcdlLUVIU5Do1lC7aT5EB vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpvf2ayjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 05:31:24 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23R5Qnkr022931;
        Wed, 27 Apr 2022 05:31:23 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpvf2ayhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 05:31:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23R5STgZ009553;
        Wed, 27 Apr 2022 05:31:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj5dqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 05:31:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23R5VV7a197362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 05:31:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44AE0A405B;
        Wed, 27 Apr 2022 05:31:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9325CA4054;
        Wed, 27 Apr 2022 05:31:06 +0000 (GMT)
Received: from [9.43.50.189] (unknown [9.43.50.189])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Apr 2022 05:31:06 +0000 (GMT)
Message-ID: <bab0d3f3-9f03-142c-7f53-86cb8cb178e4@linux.ibm.com>
Date:   Wed, 27 Apr 2022 11:01:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 07/14] mm: multi-gen LRU: exploit locality in rmap
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-8-yuzhao@google.com> <87zgk7xi13.fsf@linux.ibm.com>
 <CAOUHufbRLUg8274At8ZkUMUz2ghuGs52AvJsMkjQR=6-pusEhw@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAOUHufbRLUg8274At8ZkUMUz2ghuGs52AvJsMkjQR=6-pusEhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wSnKa9i6LJ4CkALAKM198ug-RE1mkUcQ
X-Proofpoint-ORIG-GUID: GLXECfseS7nZckMSqJ77FNySoyWBaJ6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_01,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270036
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 10:08 AM, Yu Zhao wrote:
> On Tue, Apr 26, 2022 at 10:33 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> Yu Zhao <yuzhao@google.com> writes:
>>
>> ....
>>
>>   diff --git a/mm/rmap.c b/mm/rmap.c
>>> index fedb82371efe..7cb7ef29088a 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -73,6 +73,7 @@
>>>   #include <linux/page_idle.h>
>>>   #include <linux/memremap.h>
>>>   #include <linux/userfaultfd_k.h>
>>> +#include <linux/mm_inline.h>
>>>
>>>   #include <asm/tlbflush.h>
>>>
>>> @@ -821,6 +822,12 @@ static bool folio_referenced_one(struct folio *folio,
>>>                }
>>>
>>>                if (pvmw.pte) {
>>> +                     if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
>>> +                         !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
>>> +                             lru_gen_look_around(&pvmw);
>>> +                             referenced++;
>>> +                     }
>>
>> Is it required to update referenced here? we do that below after
>> clearing the young bit. Or is the goal to identify whether we found any
>> young pte around?
> 
> referenced++ is needed because lru_gen_look_around() also clears the
> young bit in pvmw.pte. And ptep_clear_flush_young_notify() will return
> false unless mmu notifier returns true.

should we then use a mmu notifier variant of clear_young in 
lru_gen_look_around() ?

-aneesh
