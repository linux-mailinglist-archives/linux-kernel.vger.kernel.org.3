Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC51513C92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351720AbiD1UXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiD1UXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:23:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370EFB1AB0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:19:51 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 12so6493785oix.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mP2dZIg49i0nx6hN/uSu0sPbA4AamYLAjMK1jPC0V3w=;
        b=S7y8kcdcygzpAizHWfOc2pPFnbYhQfyNg4+kSYrCKxGfkJSzDYH5ZTPwbyVcd5KEKp
         5M9o2TjpjxJX7gUd8AkFHeef71gPMrfTxgucCazyOIleU5BPkTzFAGD00s1UwvaKj3Z9
         PJr+7847FK6QFfMOIm68Yad2EMWziKPo+oekA+3r4qYJj5I9VmKuUZIZcA+wERAylSmR
         gvY0swhDrGr8iFuFUnp8wHV3wlz+TJ1aHo4Hmjxnh2gxKZ+PFZbFXIaa0l46QvU4+mch
         deje8jLXAHdreTQZjo16PIBxX23X+3F6mIMlOMEUsvR/EyrQEHN1Wfmrc0dFiNRUvPrq
         +zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mP2dZIg49i0nx6hN/uSu0sPbA4AamYLAjMK1jPC0V3w=;
        b=xx/agnabvsifgp9yQcpbk8k4MUXTzIfk8yIJPebk2eWhF7vuiuPhN9rsY76qcR24xn
         OnWBkA1pzNEKhEyIQDICTlWoY88vUtmDn1g/rhCCspoeqhbx8ObHHNA30fPN/vjAmwCe
         kArUavI5R/jsfXeoRQ4MyIQQA8EOatCXqPP0fxmhgOiEO7GhHMPU9L1gZ/e4JiSmBTXv
         4R1SKxw/3vQDTMC/9iKDeqxxk5CjWael6EYCP5UpFanxlxT4W0wEbcC8ZEaukJNCFXRL
         ynb0RB2ddvV3pJSm6MA7NDrEhoAwJkxGnX8eyMhR3K//u40j09qekaXlx3ZxXKVxUkWV
         YNQA==
X-Gm-Message-State: AOAM531RM0pEFn2DHRkONj/zqc3tRVr22XJRQoWu3hb6SjbKRlkWwcVV
        Fk/yXUdxR04xQ0p3q301eNY=
X-Google-Smtp-Source: ABdhPJwD9CTmFzKeUdj2tI/XXpF/h3vLn0q0cKXhcXLsGZ6knga/3qdO3GVT45ODKBxnhB57vLnDGA==
X-Received: by 2002:a05:6808:1244:b0:2f9:e450:4bc4 with SMTP id o4-20020a056808124400b002f9e4504bc4mr16771429oiv.290.1651177190506;
        Thu, 28 Apr 2022 13:19:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bt30-20020a0568201a9e00b0035ea84682b9sm459598oob.45.2022.04.28.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 13:19:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Apr 2022 13:19:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Message-ID: <20220428201947.GA1912192@roeck-us.net>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:06:35PM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Avoid allocating a new VMA when it a vma modification can occur.  When a
> brk() can expand or contract a VMA, then the single store operation will
> only modify one index of the maple tree instead of causing a node to split
> or coalesce.  This avoids unnecessary allocations/frees of maple tree
> nodes and VMAs.
> 
> Move some limit & flag verifications out of the do_brk_flags() function to
> use only relevant checks in the code path of bkr() and vm_brk_flags().
> 
> Set the vma to check if it can expand in vm_brk_flags() if extra criteria
> are met.
> 
> Drop userfaultfd from do_brk_flags() path and only use it in
> vm_brk_flags() path since that is the only place a munmap will happen.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

A build failure seen when building ppc64:corenet64_smp_defconfig also
biscects to this patch.

mm/mmap.c: In function 'do_brk_flags':
mm/mmap.c:2908:17: error: implicit declaration of function
	'khugepaged_enter_vma_merge'; did you mean 'khugepaged_enter_vma'?

It appears that this is later fixed, but it hurts bisectability
(and prevents me from finding the actual build failure in linux-next
when trying to build corenet64_smp_defconfig).

While looking into the patch, I noticed the following.

[ ... ]

> @@ -2773,30 +2888,52 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
>  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
>  		return -ENOMEM;
>  
>  out:
>  	perf_event_mmap(vma);
>  	mm->total_vm += len >> PAGE_SHIFT;
> @@ -2807,18 +2944,21 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
>  	validate_mm_mt(mm);
>  	return 0;
>  
> -no_vma_link:
>  	vm_area_free(vma);

That really looks wrong. vm_area_free(vma) can not be reached
after this patch has been applied.

Guenter

> +vma_alloc_fail:
> +	vm_unacct_memory(len >> PAGE_SHIFT);
>  	return -ENOMEM;
>  }
>  
