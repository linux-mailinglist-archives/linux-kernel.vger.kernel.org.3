Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177D5AC57D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiIDQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiIDQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:50:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EBC15719
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 09:50:15 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284GN4Er022356;
        Sun, 4 Sep 2022 16:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=B6Gg+IbmF96VX2gQI6DkUdr2TE7NFgdOmCAf0nr6gZY=;
 b=KRkDKkqbIdUggMH1M9zSc1gBHBoSJsqJ0FBnXfUCDynAbunPpV+DrBNWqfMZr+64HxDK
 BPqdgsS16h3kKkwQFGnSW2K1A6P91nB8NM8i+9OLyEuDd8JBqEH8lOoCHthZNZ8Znx0c
 3Rqj7WpBf/qGoP1JEVrG74AhyVFIvATPFa3dfyynN8KGvokaUTbG1RaFa7v1kHZKwAwF
 tmDADkn5bPat8gHM5F1v7+6FW7BLEaV12FoKCILOUpyJuMlQCqg+fp2zGK23yoUEaey2
 URSDwL7YyFFqpxO8HOfLVZEjIuJ0qT1oXQaf9mXnDtv5D5+5H8nhs+MxooBMRZ7MGwmL Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jcyg8rbn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Sep 2022 16:50:05 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 284GfGUF011547;
        Sun, 4 Sep 2022 16:50:04 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jcyg8rbmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Sep 2022 16:50:04 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 284GaP0M027522;
        Sun, 4 Sep 2022 16:50:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8s2g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Sep 2022 16:50:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 284GkZIM41419230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Sep 2022 16:46:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB7D3A404D;
        Sun,  4 Sep 2022 16:49:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9000A4040;
        Sun,  4 Sep 2022 16:49:55 +0000 (GMT)
Received: from [9.43.81.44] (unknown [9.43.81.44])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  4 Sep 2022 16:49:55 +0000 (GMT)
Message-ID: <bb46d28c-57e3-4cfd-b5b3-e4c6db1f003f@linux.ibm.com>
Date:   Sun, 4 Sep 2022 22:19:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: swZmHjysbqEXO6dfNDbXoGgg3e-qJxEc
X-Proofpoint-GUID: KZozTIfBpPdqdGNk-_hamk5yHfyQbeXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209040084
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 10:04 PM, David Hildenbrand wrote:
> On 01.09.22 18:28, Peter Xu wrote:
>> On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
>>> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
>>> PMDs") didn't remove all details about the THP split requirements for
>>> RCU GUP-fast.
>>>
>>> IPI broeadcasts on THP split are no longer required.
>>>
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Sasha Levin <sasha.levin@oracle.com>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Jerome Marchand <jmarchan@redhat.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  mm/gup.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 5abdaf487460..cfe71f422787 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>>   *
>>>   * Another way to achieve this is to batch up page table containing pages
>>>   * belonging to more than one mm_user, then rcu_sched a callback to free those
>>> - * pages. Disabling interrupts will allow the fast_gup walker to both block
>>> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
>>> - * (which is a relatively rare event). The code below adopts this strategy.
>>> + * pages. Disabling interrupts will allow the fast_gup walker to block the
>>> + * rcu_sched callback.
>>
>> This is the comment for fast-gup in general but not only for thp split.
> 
> "an IPI that we broadcast for splitting THP" is about splitting THP.
> 
>>
>> I can understand that we don't need IPI for thp split, but isn't the IPIs
>> still needed for thp collapse (aka pmdp_collapse_flush)?
> 
> That was, unfortunately, never documented -- and as discussed in the
> other thread, arm64 doesn't do that IPI before collapse and might need
> fixing. We'll most probably end up getting rid of that
> (undocumented/forgotten) IPI requirement and fix it in GUP-fast by
> re-rechecking if the PMD changed.
> 

Can you point to the other thread ?

-aneesh

