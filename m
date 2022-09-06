Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E95AEEC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiIFP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiIFP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:28:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5169A6BF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:40:05 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286EbI5C029842;
        Tue, 6 Sep 2022 14:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gi2ZlfxV5Hgfo9RiYLHxLSZPMR7vam++rfIqtzjSQY4=;
 b=mWqExy/Wiz6255uGl+9653onJ3O580ccHYf0IL43u1mZ7zV9CLcDMSbgUwb8gCI8n8Aw
 eS2/17X5PiZ17Hq/ow9fVrD9QvpYr+RwSlr1h6OcEiTXg3GDS+VdWfsn8tXvqJ9bz2zE
 o4kaSQPTl5UDEPOd2ysadJQ/2gO2o8lbnMeq/l74yIGQ5Vi9iVlF9m6eiNAnUr2sJZiL
 Sdc/QWf7Z6EzKGK8HMZ/dNBh6DmRDLT+zTcgUmvwKfB3Izxw8AuhMBBdukY2ju2IBKCZ
 R0c7LqdoQNV2Jdy8vqYCbddtuTW1yjEZon9Jbd08putGzvH2KUyRfPQj9fk0T1/FKePp WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3je7ersyy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:38:35 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286EbGCN029698;
        Tue, 6 Sep 2022 14:37:59 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3je7erswh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:37:58 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286EaZkN020454;
        Tue, 6 Sep 2022 14:37:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3jbx6htvcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:37:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286EY4CG40632812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 14:34:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2103CA405F;
        Tue,  6 Sep 2022 14:37:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1783A4054;
        Tue,  6 Sep 2022 14:37:31 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 14:37:31 +0000 (GMT)
Message-ID: <a072fd10-ee7e-469f-c203-978cd7da566c@linux.ibm.com>
Date:   Tue, 6 Sep 2022 16:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [RFC PATCH RESEND 07/28] kernel/fork: mark VMAs as locked before
 copying pages during fork
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
 <20220901173516.702122-8-surenb@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220901173516.702122-8-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mfguNNVm0_tm7y6g6IsvzoVzzb6lC0DJ
X-Proofpoint-ORIG-GUID: KUCBt6EYsH8QfRM1q5ERagYwC0h9nhBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_07,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=956
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060070
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
> Protect VMAs from concurrent page fault handler while performing
> copy_page_range for VMAs having VM_WIPEONFORK flag set.

I'm wondering why is that necessary.
The copied mm is write locked, and the destination one is not reachable.
If any other readers are using the VMA, this is only for page fault handling.
I should have miss something because I can't see any need to mark the lock
VMA here.

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/fork.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bfab31ecd11e..1872ad549fed 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -709,8 +709,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		rb_parent = &tmp->vm_rb;
>  
>  		mm->map_count++;
> -		if (!(tmp->vm_flags & VM_WIPEONFORK))
> +		if (!(tmp->vm_flags & VM_WIPEONFORK)) {
> +			vma_mark_locked(mpnt);
>  			retval = copy_page_range(tmp, mpnt);
> +		}
>  
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);

