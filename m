Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465605AF043
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiIFQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiIFQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:20:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C1AB02
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:49:21 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286EgFNa022749;
        Tue, 6 Sep 2022 14:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QuvjyXhwXDinpisjO+yl4VyEGU5BS4zofifyeBh4iwI=;
 b=J1FqD1G2VKm6hrkmlXw2pfyTtPQEvgFq46wM8eZ/7yHU0aYjq9ngLwsoeKfJvQucyAIr
 WDjpbYmqzJXX7y4Z3WjeYHycM4bJcIPOVUkBWuVTZH97+0uv2ZYYYM925Jny/qMkMPNH
 yecANwdNDoomn9b/skW29llxR9McbqeQiYdjex1D1CfXE+o5g1SfDIKIK8GwpeK/zjDs
 a/6pRnIGmcea4GkLGrW1IcDvPzuUUEiiIxF1MGBEhRipXAuUgFi1Vjoubru/ZWmOlLk/
 xZ14xBjhGbOXuePgbf721kTKHJ+G/oILbg/O+p+a+HRLQLpTa/X7hCMTW8HfZhqPiglw 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3je86w02h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:43:40 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286EhH0Q027612;
        Tue, 6 Sep 2022 14:43:39 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3je86w02b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:43:39 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286EYW5a025865;
        Tue, 6 Sep 2022 14:43:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8tvgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:43:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286EhXmP22085968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 14:43:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C67E4A4060;
        Tue,  6 Sep 2022 14:43:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FCDA4054;
        Tue,  6 Sep 2022 14:43:32 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 14:43:32 +0000 (GMT)
Message-ID: <dcefc6dd-f8eb-945e-37ab-3c0c4e4e20f2@linux.ibm.com>
Date:   Tue, 6 Sep 2022 16:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [RFC PATCH RESEND 08/28] mm/khugepaged: mark VMA as locked while
 collapsing a hugepage
Content-Language: fr
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-9-surenb@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220901173516.702122-9-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HAsvOrmXhzmMe1mizRzjteVCQHSodYnt
X-Proofpoint-ORIG-GUID: X4lgGR3UYbHPHIYuWj46oO-L8lLKddx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_07,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=878 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209060070
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/09/2022 à 19:34, Suren Baghdasaryan a écrit :
> Protect VMA from concurrent page fault handler while modifying it in
> collapse_huge_page.

Is the goal to protect changes in the anon_vma structure?

AFAICS, the vma it self is not impacted here, only the anon_vma and the
PMD/PTE are touched, and they have their own protection mechanism, isn't it?

> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/khugepaged.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 01f71786d530..030680633989 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1072,6 +1072,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	if (mm_find_pmd(mm, address) != pmd)
>  		goto out_up_write;
>  
> +	vma_mark_locked(vma);
>  	anon_vma_lock_write(vma->anon_vma);
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,

