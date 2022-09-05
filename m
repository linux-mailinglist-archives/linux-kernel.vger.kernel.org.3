Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DF5ACE16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiIEImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiIEIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:42:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319932BB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:42:27 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2858QjhW015626;
        Mon, 5 Sep 2022 08:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=91lRCYFJmEiq8wadcEKGgbR+p3CuqJdwATguCeH8GtA=;
 b=c1hEl3nfdK5Lfi/4iF44G5lg8FfV7EcDDYG1SsVyXexSM7uUvCnxLc3W4q/DCH6++ihn
 AUpYwl4LhQG0Z0ZFS/NofA+6BDC+VOdEj66L9Q+PLd9DncqvA5my29bo4FBAZh6cMU9a
 2up30STiBmHeFtTHBVhhWqUG5/HdJ0qfwmyD1hFEPXzZrIdm6c91pgwMZcJHkKrWz2vk
 4XidU1lX5zAZhsQO48tjEJ30OLUQsCSx1h2Ddi2KpSOOMJS/wqgLnERvgc17WMszid5i
 xcbkozEI34ZPV65GyLkRdh7yZ32LszMDHBY82Ljh0yJv4hLh3QrtYiemRYt1x/z7rJ28 Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jddkxrbxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:41:19 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2858RIl6017410;
        Mon, 5 Sep 2022 08:41:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jddkxrbw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:41:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2858Zv5O012552;
        Mon, 5 Sep 2022 08:41:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3jbxj8t5d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:41:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2858fD4141222454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 08:41:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDA1F42042;
        Mon,  5 Sep 2022 08:41:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0BC542045;
        Mon,  5 Sep 2022 08:41:08 +0000 (GMT)
Received: from [9.43.107.234] (unknown [9.43.107.234])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 08:41:08 +0000 (GMT)
Message-ID: <64faaca6-bbcf-bbfb-66c8-b8e80fcdc6bd@linux.ibm.com>
Date:   Mon, 5 Sep 2022 14:11:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
 <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
 <YxD00K1lv151X/eq@xz-m1.local>
 <CAHbLzkrA-jKzTBq_Mn3NZYc91exovv1gH2LNzetCNiVu8+W6Kg@mail.gmail.com>
 <2368d91f-8442-076f-f33a-64b51b44825c@redhat.com>
 <e87bad0c-47fa-5e6d-9c43-f2f66da32a76@linux.ibm.com>
 <8e1aaa19-0d28-3381-3ec6-920a474f5f3f@redhat.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <8e1aaa19-0d28-3381-3ec6-920a474f5f3f@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LBHboaHYTCbFC3V1F64zdMmSYGct1sUK
X-Proofpoint-GUID: USZsLXGhUNo4jj4GYycrjD0PC_HSyl26
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050040
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 2:08 PM, David Hildenbrand wrote:
> On 04.09.22 18:52, Aneesh Kumar K V wrote:
>> On 9/2/22 12:02 PM, David Hildenbrand wrote:
>>> On 01.09.22 20:35, Yang Shi wrote:
>>>> On Thu, Sep 1, 2022 at 11:07 AM Peter Xu <peterx@redhat.com> wrote:
>>>>>
>>>>> On Thu, Sep 01, 2022 at 10:50:48AM -0700, Yang Shi wrote:
>>>>>> Yeah, because THP collapse does copy the data before clearing pte. If
>>>>>> we want to remove pmdp_collapse_flush() by just clearing pmd, we
>>>>>> should clear *AND* flush pte before copying the data IIRC.
>>>>>
>>>>> Yes tlb flush is still needed.  IIUC the generic pmdp_collapse_flush() will
>>>>> still be working (with the pte level flushing there) but it should just
>>>>> start to work for all archs, so potentially we could drop the arch-specific
>>>>> pmdp_collapse_flush()s, mostly the ppc impl.
>>>>
>>>> I'm don't know why powperpc needs to have its specific
>>>> pmdp_collapse_flush() in the first place, not only the mandatory IPI
>>>> broadcast, but also the specific implementation of pmd tlb flush. But
>>>> anyway the IPI broadcast could be removed at least IMO.
>>>>
>>>
>>> pmdp_collapse_flush() is overwritten on book3s only. It either translates
>>> to radix__pmdp_collapse_flush() or hash__pmdp_collapse_flush().
>>>
>>>
>>> radix__pmdp_collapse_flush() has a comment explaining the situation:
>>>
>>>
>>> +       /*
>>> +        * pmdp collapse_flush need to ensure that there are no parallel gup
>>> +        * walk after this call. This is needed so that we can have stable
>>> +        * page ref count when collapsing a page. We don't allow a collapse page
>>> +        * if we have gup taken on the page. We can ensure that by sending IPI
>>> +        * because gup walk happens with IRQ disabled.
>>> +        */
>>>
>>>
>>> The comment for hash__pmdp_collapse_flush() is a bit more involved:
>>>
>>>     /*
>>>      * Wait for all pending hash_page to finish. This is needed
>>>      * in case of subpage collapse. When we collapse normal pages
>>>      * to hugepage, we first clear the pmd, then invalidate all
>>>      * the PTE entries. The assumption here is that any low level
>>>      * page fault will see a none pmd and take the slow path that
>>>      * will wait on mmap_lock. But we could very well be in a
>>>      * hash_page with local ptep pointer value. Such a hash page
>>>      * can result in adding new HPTE entries for normal subpages.
>>>      * That means we could be modifying the page content as we
>>>      * copy them to a huge page. So wait for parallel hash_page
>>>      * to finish before invalidating HPTE entries. We can do this
>>>      * by sending an IPI to all the cpus and executing a dummy
>>>      * function there.
>>>      */
>>>
>>> I'm not sure if that implies that the IPI is needed for some other hash-magic.
>>>
>>> Maybe Aneesh can clarify.
>>>
>>
>> We still need the IPI for the hash. Another reason for architecture to override that
>> function is to help them use the right page size when flushing the TLB.
> 
> Thanks for clarifying. So the radix variant wouldn't need the IPI anymore, once GUP-fast is handled differently, correct?
> 

yes. With this patch https://lkml.kernel.org/r/20220901222707.477402-1-shy828301@gmail.com we can remove the
serialize_against_pte_lookup(vma->vm_mm); in radix__pmdp_collapse_flush()

-aneesh


