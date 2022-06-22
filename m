Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF25552DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiFVRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiFVRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:52:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342E344CF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:52:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a15so9564083pfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CM4RfzBmVh3C+Iy74tc4MTRNqz/4SgRhoKdMoFuie3A=;
        b=LT5VSzIFADk3yZFFJCf2grfn5gX10ZlwVQywoHo9oWynlEqhcFpZNIO7Vo7cdrI8IH
         cqFVg3xMhjlIiXuobkgLZ74e7AMGUjGvhjaOXbuYdtufQLi4c1tIG4HR7fecgp+Anx0R
         4SLy1Dpz+FlPvOuzvNETxs86OIdeBbr3TFGoR1iMWtiKqnzx/0+5b7oF+yUn1dbShqEM
         H15faq3ZdwAYOArsI+7UpCcFaMEE03T0l7zfgPGghFvTUKAiX3c/3qiNAiauHDdGyiOd
         C8i8pCUqe9FQkpKbyufo5Fme6LsdwY2alYOTxmk+z7uEHt3UEm7icsz1Bbn8h5DECPjw
         3uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CM4RfzBmVh3C+Iy74tc4MTRNqz/4SgRhoKdMoFuie3A=;
        b=s8+MSGEZeaZCshJNri+3IU+LLvl1YnPDsw4AY45t89k+Qkfm6dpwtT3XZnNJ0oCXZc
         353Ibeh7JtcYrpxHRQH6qiOAGYOJj4IV+/hhBCH29GbWqPH2eTC9AgT8SLjemESal1xp
         DjN+SbiSms1DoPWaZC5VDjEIUq7fRWYZ+7/oaRf4mj30AnL4GmjdVrxM8wJ6A0x+/M/c
         wSrf3RkXgSYAA9ZQRuVZxY7cmZ+/AB8ub59lRqwZgn31GX1UMYini6TSzR7gMCh0Pr9Y
         U4DDQ4h9Ffxg9tpfZQ/sLBHnlH7QiU7oH/c+5UHcVPLrBFIzY4zJHPgdpzhNLojBkYTz
         G/Vg==
X-Gm-Message-State: AJIora+H+sAWTwk3+O9Z+4r5rzZ1QIQ+m4MbXLt7PbFt23ux5XV5v1Ct
        DfC/jjXGDlDgJjjm76h30QhhVQr7igz1Qg==
X-Google-Smtp-Source: AGRyM1sP84E1mBLGYiykEHXI+HnhMfce8TyrVRgWTitaAG6k8H6/gMN63LEbAINlAMsVgHqPwlevSQ==
X-Received: by 2002:a63:ff19:0:b0:403:7c60:ae96 with SMTP id k25-20020a63ff19000000b004037c60ae96mr3756287pgi.466.1655920335023;
        Wed, 22 Jun 2022 10:52:15 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id p8-20020aa78608000000b005183cf12184sm4033040pfn.133.2022.06.22.10.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:52:14 -0700 (PDT)
Date:   Wed, 22 Jun 2022 10:52:10 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH 4/7] mm: thp: kill transparent_hugepage_active()
Message-ID: <YrNWyqxIKsQq1ky5@google.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
 <20220616174840.1202070-5-shy828301@gmail.com>
 <YrIU2iP0H5LQbV7R@google.com>
 <20220621175412.02d90df5f381de0cd676adf8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621175412.02d90df5f381de0cd676adf8@linux-foundation.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jun 17:54, Andrew Morton wrote:
> On Tue, 21 Jun 2022 11:58:34 -0700 "Zach O'Keefe" <zokeefe@google.com> wrote:
> 
> > > -bool transparent_hugepage_active(struct vm_area_struct *vma)
> > > +bool hugepage_vma_check(struct vm_area_struct *vma,
> > > +			unsigned long vm_flags,
> > > +			bool smaps)
> > >  {
> > > -	/* The addr is used to check if the vma size fits */
> > > -	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> > > +	if (!transhuge_vma_enabled(vma, vm_flags))
> > > +		return false;
> > > +
> > 
> > During testing my work on top this patch, I found a small bug here.
> > 
> > Namely, transhuge_vma_enabled() will check vma->vm_mm->flags (to see if
> > MMF_DISABLE_THP is set); however, for vDSO vmas, vma->vm_mm is NULL.
> > 
> > Previously, transparent_hugepage_active() in smaps path would check
> > transhuge_vma_suitable() before checking these flags, which would fail for vDSO
> > vma since we'd take the !vma_is_anonymous() branch and find the vma (most
> > likely) wasn't suitably aligned (by chance ?).
> > 
> > Anyways, I think we need to check vma->vm_mm.
> 
> Like this?
> 
> --- a/mm/huge_memory.c~mm-thp-kill-transparent_hugepage_active-fix
> +++ a/mm/huge_memory.c
> @@ -73,6 +73,9 @@ bool hugepage_vma_check(struct vm_area_s
>  			unsigned long vm_flags,
>  			bool smaps)
>  {
> +	if (!vma->vm_mm)
> +		return false;
> +
>  	if (!transhuge_vma_enabled(vma, vm_flags))
>  		return false;
>  
> _
> 

Hey Andrew,

In principle, yes that would fix this. I don't know precisely how this fix will
be applied, but note that the subsequent patch "mm: thp: kill
__transhuge_page_enabled()" won't apply on top of this automatically. Also, I
wonder if we should add a comment for future travellers who wonder what kind of
vmas don't have an associated mm (it was news to me); though, I'm not sure if
vDSO is the only such case (though show_map_vma() seems to think so), or if this
just asking for stale comments down the road. Maybe it's fine as is.

Thanks,
Zach

