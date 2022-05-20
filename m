Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA552ED54
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349893AbiETNji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349096AbiETNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:39:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39482169E3B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:39:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p22so14353316lfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3BeEGshpUebf40S3dI2nHaMHUGbrc9YgGRUe6v3NrQI=;
        b=6qt22nK9IyDROp+1mPdWrxlvzi6NjO9eSG5Nen/b2A4439rifjlgxwQdu1H0oZvaEI
         zsREZJlUH9Q59JA4/xx902iUi8jdSn8cRb9yxLBKOpTVgUEBc8mktfK/Gl0D93Izd/ul
         Onz+P2Nvnbw9a32QqyeG9cgY4Z4J9mdF8qFpYKjfy+87PufYse2QuuIZCUVPPDlNvAKE
         ik5nL2LZ9Bk16e0vHts9nXx0icITt1ybjlmSAmRoFKOj9CpUtY5Q+f5Jk/vtT2A2l3gX
         tjGCSyXpFudAPCrNP09RJNhINqh3uz45V4pH4Lmn9DWgW4Uk7j2mupibV5+qfh9CEpti
         MVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3BeEGshpUebf40S3dI2nHaMHUGbrc9YgGRUe6v3NrQI=;
        b=kEBE965qPYrinNpYl6gGR4uNfDfTU2/jsBMfJwLwsNt4L2RE6GcS4ox8OLQL/T7A5H
         tGX1/O5Y1Nyn1PA4kklFgcdyDLDEZXa8fGxxOd/EzJPWCNDjJNsVClEbI3Rd/nns41vk
         5FvBUBtzCxs21jm7gLh7CIjitBzzALgCjxVvj7mJ9QxvoYpAfyidu+DdtsoRzuTsydxU
         A/ICjtDcTn0zfN8Vti9pkfULuH7i9Lmy0D1MCCL1ssPno2Uvn/aFiPfInopEVfMixcgC
         /8XKsVaAAxWgXMhLXzybCAXQ4YM8p2Xu02sm/wJoC1uTaPvhaZmnUw5aE3HZCgzQbhNk
         1rrA==
X-Gm-Message-State: AOAM532d46XyKuxRSqD8w/+zO/7Ub/PfL97XybY+7LBwt3yiQ5SjHHJI
        0+lwYpN0BevUgSDHF/1UJ5t/Kg==
X-Google-Smtp-Source: ABdhPJyT1m9j6Hn8ES8585uw0TDj+nJSjxY8pFZYdW/m0XbSSumm094xJFwQQSPevh3hEaAT3pcheQ==
X-Received: by 2002:a19:4f04:0:b0:477:b6c7:9771 with SMTP id d4-20020a194f04000000b00477b6c79771mr6778897lfb.182.1653053972054;
        Fri, 20 May 2022 06:39:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e7-20020a2e9847000000b0024f3d1daeacsm323659ljj.52.2022.05.20.06.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:39:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C70E6104AAB; Fri, 20 May 2022 16:41:24 +0300 (+03)
Date:   Fri, 20 May 2022 16:41:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com
Subject: Re: [RFC PATCH v3 2/6] [PATCH 2/6] mm: add merging after mremap
 resize
Message-ID: <20220520134124.6glbfzhrgzutfor6@box.shutemov.name>
References: <20220516125405.1675-1-matenajakub@gmail.com>
 <20220516125405.1675-3-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516125405.1675-3-matenajakub@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:54:01PM +0200, Jakub Matěna wrote:
> When mremap call results in expansion, it might be possible to merge the
> VMA with the next VMA which might become adjacent. This patch adds
> vma_merge call after the expansion is done to try and merge.
> 
> Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
> ---
>  mm/mremap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 303d3290b938..75cda854ec58 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/mm.h>
> +#include <linux/mm_inline.h>
>  #include <linux/hugetlb.h>
>  #include <linux/shm.h>
>  #include <linux/ksm.h>
> @@ -1022,8 +1023,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  				}
>  			}
>  
> -			if (vma_adjust(vma, vma->vm_start, addr + new_len,
> -				       vma->vm_pgoff, NULL)) {
> +			if (!vma_merge(mm, vma, addr + old_len, addr + new_len,
> +					vma->vm_flags, vma->anon_vma, vma->vm_file,
> +					vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),
> +					vma->vm_userfaultfd_ctx, anon_vma_name(vma))) {

Hm. Don't you need to update 'vma' with result of vma_merge()?

'vma' is used below the point and IIUC it can be use-after-free.

-- 
 Kirill A. Shutemov
