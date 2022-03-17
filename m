Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C592A4DBCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbiCQCFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiCQCFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:05:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D91DA72
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:04:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w4so3268198ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUrHaSdQj9PquKEUMEM9Xb4AyAVyoYlqVXVXozaoPAI=;
        b=fPjxLTmYhvqOtp/sQjU3H5TDfvaKf6tz8FJj6N+ajz5xQuCiumRq7FM1WWMCLYbBwG
         Wen60MDFoY04zkBVoDdUrXp7VvEIS4i8ns+9A5PIcoFxJlBiWkNeBne7xJ4pB2Dhmeud
         kjQy2Y53a2ADXCu+2kOy2LDG93fGh1GEgmJVnz1WIVJgr77cdq2IsBrKhee9ILOGBOas
         t7BanWBMNThbn9vbVueSNuuq2bdkx8oB+7Ch1c/KRxJjWi/7sBc2tI1oGJiLTSV1Z7eS
         aaD4PQZsk5NnUdWbLLWHHOTe8dedQSkrhEg7NB78nzf4Jq+peHX19uFhlc5oX3IiHL9U
         8ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUrHaSdQj9PquKEUMEM9Xb4AyAVyoYlqVXVXozaoPAI=;
        b=o3aJRGlQyc4Buon3er+AwfIiHItXwIey+qZPfzzorS4BxxMkm3Wk+TxvLs79rIzvNb
         6XgWwM7o4Fgq/DhJLZo+/BDBFEnQQT6IKByatPCRGJ9O2o1kdv+McbPPVT9yhLdDPX2Q
         ic5Gs5cstlmnxAaxFBo85A8ud9x3JmRDL964sbiufWsZcq2M/Ufs329ibQFC5XgnxbJP
         xfLYx6Gr3CZ3n1sZX60zhfsqSfo/ITcf8ZSXm/c8yTTyJOSL12vIXdLneVr9J8BAKoTM
         R6GOrnLUjIxQSMiShc7kpCsYK127gn2rpjsiholgjH4rvNjXW7iW1NV74FvhHQqI4xKk
         CFcA==
X-Gm-Message-State: AOAM5308ox/mdSX2F3KVRnpq1LrxnNUzAIUVIL0qAoenbyKHF6D02V3r
        LYSz3c+lYxPpscG0VjemAn8=
X-Google-Smtp-Source: ABdhPJy1GuquPEQNCp9zMrQe716lJ9/ZhpruJNY+Orkx3v1aluCewiaKiW5s80w13YLHRdaTKwx9Fw==
X-Received: by 2002:a17:902:8ec7:b0:14a:c442:8ca2 with SMTP id x7-20020a1709028ec700b0014ac4428ca2mr2493858plo.12.1647482640368;
        Wed, 16 Mar 2022 19:04:00 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm4767133pfh.83.2022.03.16.19.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 19:03:59 -0700 (PDT)
Message-ID: <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
X-Google-Original-Message-ID: <20220317020357.GA2135497@cgel.zte@gmail.com>
Date:   Thu, 17 Mar 2022 02:03:57 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from ksm cow
References: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
 <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Delay accounting does not track the delay of ksm cow.  When tasks
> > have many ksm pages, it may spend a amount of time waiting for ksm
> > cow.
> > 
> > To get the impact of tasks in ksm cow, measure the delay when ksm
> > cow happens. This could help users to decide whether to user ksm
> > or not.
> > 
> > Also update tools/accounting/getdelays.c:
> > 
> >     / # ./getdelays -dl -p 231
> >     print delayacct stats ON
> >     listen forever
> >     PID     231
> > 
> >     CPU             count     real total  virtual total    delay total  delay average
> >                      6247     1859000000     2154070021     1674255063          0.268ms
> >     IO              count    delay total  delay average
> >                         0              0              0ms
> >     SWAP            count    delay total  delay average
> >                         0              0              0ms
> >     RECLAIM         count    delay total  delay average
> >                         0              0              0ms
> >     THRASHING       count    delay total  delay average
> >                         0              0              0ms
> >     KSM             count    delay total  delay average
> >                      3635      271567604              0ms
> > 
> 
> TBH I'm not sure how particularly helpful this is and if we want this.
>
Thanks for replying.

Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
save memory, it's a tradeoff by suffering delay on ksm cow. Users can
get to know how much memory ksm saved by reading
/sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
ksm cow delay, and this is important of some delay sensitive tasks. If
users know both saved memory and ksm cow delay, they could better use
madvise(, , MADV_MERGEABLE).

> [...]
> 
> >  	struct vm_area_struct *vma = vmf->vma;
> > +	vm_fault_t ret = 0;
> > +	bool delayacct = false;
> >  
> >  	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> >  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> > @@ -3294,7 +3296,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  		 *
> >  		 * PageKsm() doesn't necessarily raise the page refcount.
> >  		 */
> > -		if (PageKsm(page) || page_count(page) > 3)
> > +		if (PageKsm(page)) {
> > +			delayacct = true;
> > +			goto copy;
> > +		}
> > +		if (page_count(page) > 3)
> >  			goto copy;
> >  		if (!PageLRU(page))
> >  			/*
> > @@ -3308,7 +3314,12 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  			goto copy;
> >  		if (PageSwapCache(page))
> >  			try_to_free_swap(page);
> > -		if (PageKsm(page) || page_count(page) != 1) {
> > +		if (PageKsm(page)) {
> > +			delayacct = true;
> > +			unlock_page(page);
> > +			goto copy;
> > +		}
> > +		if (page_count(page) != 1) {
> >  			unlock_page(page);
> >  			goto copy;
> >  		}
> > @@ -3328,10 +3339,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  	/*
> >  	 * Ok, we need to copy. Oh, well..
> >  	 */
> 
> Why not simply check for PageKsm() here? I dislike the added complexity
> above.
> 
The original code check PageKsm() twice, I just try to keep the original
semantics.

If you think this patch is reasonable, I will try to find a better way
to realize this.
> 
> -- 
> Thanks,
> 
> David / dhildenb
