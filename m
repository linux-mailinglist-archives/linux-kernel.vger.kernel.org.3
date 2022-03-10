Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049834D4399
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiCJJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCJJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:35:57 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85764139CEF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646904897; x=1678440897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/IalRAFcuzbyyT+wYoMtKv0yxgtlvFF8P0B3U3hiXSQ=;
  b=i/+u5RqfjHoslcV1YQ7rwy2T+vl9VyZ5fhlWMmgeGIkWjuerLtvOr1kH
   OpcKKh7QfpfZH39HDwE/eo7etj5GZZXOmNlciui3kRGRcJ4KM0PKhwk1r
   3ribAEkbKjyk1wEeFSOIVawv33CLXOIjUqbZReVREJPF3bp8mdm/PjR1N
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Mar 2022 01:34:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 01:34:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Mar 2022 01:34:34 -0800
Received: from [10.216.27.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 10 Mar
 2022 01:34:30 -0800
Message-ID: <3846d4ff-c8ab-3c44-1974-fee451894c0d@quicinc.com>
Date:   Thu, 10 Mar 2022 15:04:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] mm: madvise: return correct bytes advised with
 process_madvise
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Rientjes <rientjes@google.com>,
        <edgararriaga@google.com>, Michal Hocko <mhocko@suse.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1646803679-11433-1-git-send-email-quic_charante@quicinc.com>
 <YijaP7cC6Sclxc29@google.com>
 <B156E4D9-C3DD-4EBD-ACE2-CA55A8B3A3F5@gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <B156E4D9-C3DD-4EBD-ACE2-CA55A8B3A3F5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Amit for the inputs!!

On 3/10/2022 12:20 AM, Nadav Amit wrote:
> ---
> mm/madvise.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 38d0f51..d3b49b3 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1426,15 +1426,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> 
> 	while (iov_iter_count(&iter)) {
> 		iovec = iov_iter_iovec(&iter);
> +		/*
> +		 * Even when [start, end) passed to do_madvise covers
> +		 * some unmapped addresses, it continues processing with
> +		 * returning ENOMEM at the end. Thus consider the range
> +		 * as processed when do_madvise() returns ENOMEM.
> +		 * This makes process_madvise() never returns ENOMEM.
> +		 */
> 
> I fully understand and relate to the basic motivation of this
> patch.
> 
> The ENOMEM that this patch checks for, IIUC, is the ENOMEM that is
> returned on unmapped holes. Such ENOMEM does not appear, according to
> the man page, to be a valid reason to return ENOMEM to userspace.
> Presumably process_madvise() is expected to skip unmapped holes
> and not to fail because of them>
True, that ENOMEM represents the VMA passed contains the unmapped holes.
Pasting the Documentation of do_madvise():
 *  -ENOMEM - addresses in the specified range are not currently
 *              mapped, or are outside the AS of the process.

Internally process_madvise() calls do_madvise() in a loop by passing the
vma it received in 'struct iovec'.  And I too agree here that
process_madvise() is expected to process the unmapped holes.

> Having said that, I do not think that the check that the patch does
> is clean or clearly documented.

If it is about the Documentation, how about adding: "Since
process_madvise() is expected to process unmapped holes, never return
ENOMEM received from do_madvise() to user". If the code changes can be
made further cleaner, please suggest.

> 
> In addition, this patch (and some work on process_madvise()) raise
> in my mind a couple of questions:
> 
> 1. There are other errors that process_madvise might encounter
>    and can be propagated back to userspace, but are not
>    documented. For instance if can_madv_lru_vma() fails on
>    MADV_COLD, userspace will get EINVAL. EINVAL is not documented
>    as a valid error-code for such case in either madvise() and
>    process_madvise() man pages.

I agree here with the man page documentations too and felt the same
while going through them. For the mentioned case too, in the madvise[1]
man page, EINVAL return type is only talked for MADV_DONTNEED  and
MADV_REMOVE. It should also contains for MADV_PAGEOUT, MADV_COLD and as
well for MADV_FREE. The other missing return types, which I came across,
in process_madvise are:
EINVAL - return from process_madvise_behavior_valid().
EINTR  - from mm_access()
EACCES - from mm_access()

Thanks,
Charan
