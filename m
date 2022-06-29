Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9541D55F662
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiF2GJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiF2GJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:09:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D433A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:09:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id n12so14178381pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErSVijo4gWjx6UrCAwONPztAe8R2oF0W85jecg+exAw=;
        b=STRTs5aHz8sCESg4GzZ3Z3aIdi9WYtSo/2nhppvil81gcwVOiSJFW77LZFaMT95quA
         EeFxz50WUWso2tAZvKmg3POssQK7WT+ZQU3zVibVe4MTzKI58Io0BxE2SMPb98Fn+24O
         9RZuBlP6Mro9S/FTu5eZN2o91ggvIIwpCuJ7LM9S5zx7tzuwI3Ve+9fFcpr6xT+5YmaP
         jbkphfmbsw9QF4pExdTL7/5Zc7eJ8+ogju1hhRn45y1UqDzW8lE8n1paZOB7hxlhPCYP
         f33eMJYihfK9KNbC/e2QQFxytx4Qanab0kC74s6xe8GKs2fVHidmd5Lu8IpbY9LsTFzf
         I/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErSVijo4gWjx6UrCAwONPztAe8R2oF0W85jecg+exAw=;
        b=jOuCD56hNHZtcqbT/I/THQH9el+z8zJ8wulFDHdGZZGGR4tU2+r2By3367Lk8ZP3Kx
         hnWzPYhvuevKFamYAhl3e35rjyXs4IPcI1yFcj32NHguraC24JGppAOuCFdP3vPdWWDv
         FatDrdY6KvgnB5irBP1ew9vazYaHMSaIiI1OpXpJpIzcPZ3sZ2QowMiCRLqXuKCuz8K4
         XxjOyvyjnBjoc5bPenMIA5KX97ChGrc2ddlIFRBkvoUD+NiFzg5DIN7hWhPzgPR6VzC8
         /QwBfOIxlolTDt+dHMSJtRi8rPjnvdsmQoY7vcs7LCSLjRQmeHyoD6bdDbii9iWrJHtC
         PuDQ==
X-Gm-Message-State: AJIora/zKlgDSMFo86uCxI8p7x0a3JqTaNUZEPZDFMsZpVoTKIhsLAlc
        I8QhOUJ1z7CxPpVECgEQ24u8Gg==
X-Google-Smtp-Source: AGRyM1sZ3ol/YQTUAxlsQmxuakEsImj5mW2Jtdib3RUM/ulJPF7vMpcU1RBoGr0OwaHlE8u11GeaRQ==
X-Received: by 2002:a63:6e44:0:b0:40c:73a7:b6c9 with SMTP id j65-20020a636e44000000b0040c73a7b6c9mr1587570pgc.285.1656482980262;
        Tue, 28 Jun 2022 23:09:40 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id n63-20020a17090a5ac500b001ec8c53544esm1018126pji.46.2022.06.28.23.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 23:09:39 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:09:35 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
Message-ID: <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com>
 <YroYaWVvNZJvtqsH@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YroYaWVvNZJvtqsH@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
> On 06/24/22 17:36, James Houghton wrote:
> > This is needed to handle PTL locking with high-granularity mapping. We
> > won't always be using the PMD-level PTL even if we're using the 2M
> > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > case, we need to lock the PTL for the 4K PTE.
> 
> I'm not really sure why this would be required.
> Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> with less contention than using the more coarse mm lock.  
>

Your words make me thing of another question unrelated to this patch.
We __know__ that arm64 supports continues PTE HugeTLB. huge_pte_lockptr()
did not consider this case, in this case, those HugeTLB pages are contended
with mm lock. Seems we should optimize this case. Something like:

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0d790fa3f297..68a1e071bfc0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -893,7 +893,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
                                           struct mm_struct *mm, pte_t *pte)
 {
-       if (huge_page_size(h) == PMD_SIZE)
+       if (huge_page_size(h) <= PMD_SIZE)
                return pmd_lockptr(mm, (pmd_t *) pte);
        VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
        return &mm->page_table_lock;

I did not check if elsewhere needs to be changed as well. Just a primary
thought.

Thanks.
 
> -- 
> Mike Kravetz
> 
