Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0645A0F05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbiHYL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiHYL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:26:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFAF832EE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:26:31 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PBLogZ026452;
        Thu, 25 Aug 2022 11:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=6A06woBR/q196VX7s2hmXjoHgljGUazOm+PtrpxMR58=;
 b=Ih7X9n/87MDRVVk1ffJFb2VFrvyf/Ejpqy9M8gRRLcyuMJyHc6dmjlkumtoVLPYo+ND3
 VOStNsZWa6jKP1onFuHGmtmEaxOiiGgJVN3uhUpq6rOxoW5mTc2lMKYAMyTv419fy5X3
 871gfKRjVJp4L+2FrykGMLhEBFSQlS8qmWqRQzP2WPBfIo9ADncMJWUZKrHZw5Eo4U0A
 +LCf71MGX3YhXNc6KbTEvauHyoUBMS9yyKTvv1K1BFDESp9nTv/45wvpz9FsTwZroCmb
 f7/q4ISEi0B7bYwuiv/sMaR5f2te3qWKkT4/RBhjnJwxsHMznfJkxKJWDq5pXHnp2yvR 0Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j64h7gq4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:23:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PBNjd4015588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:23:45 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 25 Aug 2022 04:23:38 -0700
Date:   Thu, 25 Aug 2022 16:53:34 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Michel Lespinasse <michel@lespinasse.org>
CC:     Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kernel-team@fb.com>, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 10/35] mm: add per-mm mmap sequence counter for
 speculative page fault handling.
Message-ID: <20220825112334.GA23298@hu-pkondeti-hyd.qualcomm.com>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-11-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220128131006.67712-11-michel@lespinasse.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HHldoLC9XfyxZbpoue1XcmoLSQENsrDK
X-Proofpoint-GUID: HHldoLC9XfyxZbpoue1XcmoLSQENsrDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:09:41AM -0800, Michel Lespinasse wrote:
> The counter's write side is hooked into the existing mmap locking API:
> mmap_write_lock() increments the counter to the next (odd) value, and
> mmap_write_unlock() increments it again to the next (even) value.
> 
> The counter's speculative read side is supposed to be used as follows:
> 
> seq = mmap_seq_read_start(mm);
> if (seq & 1)
> 	goto fail;
> .... speculative handling here ....
> if (!mmap_seq_read_check(mm, seq)
> 	goto fail;
> 
> This API guarantees that, if none of the "fail" tests abort
> speculative execution, the speculative code section did not run
> concurrently with any mmap writer.
> 
> This is very similar to a seqlock, but both the writer and speculative
> readers are allowed to block. In the fail case, the speculative reader
> does not spin on the sequence counter; instead it should fall back to
> a different mechanism such as grabbing the mmap lock read side.
> 
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  include/linux/mm_types.h  |  4 +++
>  include/linux/mmap_lock.h | 58 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0ae3bf854aad..e4965a6f34f2 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -523,6 +523,10 @@ struct mm_struct {
>  		 * cacheline.
>  		 */
>  		struct rw_semaphore mmap_lock;
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +		unsigned long mmap_seq;
> +#endif
> +
>  

The previous version of patches [1] had maintained this sequence counter
per-vma which is more granualar. Can you please share the rationale behind
this? I guess, this is more maintainable as we did not scatter the write side
changes but nicely hooked into the mmap write lock API.

I have tested ebizzy test with per-mm and per-vma sequence counter on x86 QEMU
and aarch64 platforms. The results indicate that we are taking classic page
fault route 5% more with per-mm sequence counter but it did not showed up in
the end results (how much time it takes to do fixed number of operations). So
I am asking this only to understand the reasoning behind this change.

[1]
https://lore.kernel.org/lkml/1523975611-15978-9-git-send-email-ldufour@linux.vnet.ibm.com/
