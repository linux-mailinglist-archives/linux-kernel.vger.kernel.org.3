Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAE5873EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiHAW3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiHAW3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4B5145046
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659392960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nO9rzt8RTgLMwaRqiQxl7KyQRLvb8DJJM7mg9Wbz5oA=;
        b=MWkfHk1V/4wfMDOq8KEvf1fNtptZXw9ldL3S/lHVm2R08uu1L9dIFFAGF7HTSDRusQyCtz
        +NRl2HA50/g0Aymu3LA14+guCWHaxuzDDBAUmr94+ggv7nDAZkkI2WreOOFUqO3l3w1wsy
        kNs6kwTszYBFbFftCDVew2zN6gD+jvQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-zJACZXFlN6y65ROtzu3tvQ-1; Mon, 01 Aug 2022 18:29:19 -0400
X-MC-Unique: zJACZXFlN6y65ROtzu3tvQ-1
Received: by mail-qv1-f71.google.com with SMTP id u9-20020a0cec89000000b0047498457e00so4389179qvo.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nO9rzt8RTgLMwaRqiQxl7KyQRLvb8DJJM7mg9Wbz5oA=;
        b=ynxk8c6Gsx/H81r2QIsJbCn+sC++xLBCrDSKeNM2x/RKWnt+mwjOQl1Tb5gPQYnpXa
         2xyryez7K2pdUBwRThcbgxF/Mr5tck1XqEPUjaIzXh4O1bV4FVxmAGrugvJNtIncp7Zh
         wS2lCHe3inRbvbDwr9q08W3yBitZ069O3Pyf76t8Le8YbIuB1qSLf5wd7Z//Ejywt7oZ
         tEAxTmF+iFOTy/oSU6P34bu+Roodo8XgrDpgoRlS0V0D3dWEo9cHkNg7xk/MtTxkruz0
         t8S3rxJ8B6KNkYV4eIY+qj8sJGEUaI0g8O+B0L1YHYF0U2Q0ygJye3Tbug82Gu8lX/68
         dDjQ==
X-Gm-Message-State: ACgBeo3AhyADLMZzhBBiQ3EfFw8ZYsGMKejqC8YiDSF+zKz3tZgyqwtj
        D2GMwYYBD/xXAyUL+3KpUVBfe6NG3vTC9xj7d4iiDNgLNWRzn1tgekwUANtGWEJ0LFeGchmWYDD
        3wYrVEpULUjT0ZnbMWCP6WFog
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id fv9-20020a056214240900b00432bf34362fmr16036109qvb.66.1659392958755;
        Mon, 01 Aug 2022 15:29:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7U7Dy41L+g9zzEtqQWOsczW+Lm3ky/InocSNKlujTF0RjMOD7NpOwKWOi3xT9bPkkckbVqMg==
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id fv9-20020a056214240900b00432bf34362fmr16036096qvb.66.1659392958531;
        Mon, 01 Aug 2022 15:29:18 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bs8-20020a05620a470800b006a34a22bc60sm9424218qkb.9.2022.08.01.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:29:18 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:29:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 1/4] mm/swap: Add swp_offset_pfn() to fetch PFN from
 swap entry
Message-ID: <YuhTvDIC26trwr18@xz-m1.local>
References: <20220729014041.21292-1-peterx@redhat.com>
 <20220729014041.21292-2-peterx@redhat.com>
 <8735eglkp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735eglkp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:13:58AM +0800, Huang, Ying wrote:
> > +/*
> > + * This should only be called upon a pfn swap entry to get the PFN stored
> > + * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
> > + * of pfn swap entry.
> > + */
> > +static inline unsigned long swp_offset_pfn(swp_entry_t entry)
> > +{
> 
> Is it good to call is_pfn_swap_entry() here for debug that can be
> eliminated in the production kernel?

Sure, I'll add a VM_BUG_ON() there in the next spin.

> 
> > +	return swp_offset(entry) & SWP_PFN_MASK;
> > +}
> > +
> >  /* check whether a pte points to a swap entry */
> >  static inline int is_swap_pte(pte_t pte)
> >  {
> > @@ -369,7 +387,7 @@ static inline int pte_none_mostly(pte_t pte)
> >  
> >  static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
> >  {
> > -	struct page *p = pfn_to_page(swp_offset(entry));
> > +	struct page *p = pfn_to_page(swp_offset_pfn(entry));
> >  
> >  	/*
> >  	 * Any use of migration entries may only occur while the
> > @@ -387,6 +405,9 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
> >   */
> >  static inline bool is_pfn_swap_entry(swp_entry_t entry)
> >  {
> > +	/* Make sure the swp offset can always store the needed fields */
> > +	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
> 
> 	BUILD_BUG_ON(SWP_TYPE_SHIFT <= SWP_PFN_BITS);

Logiclaly it's okay to have SWP_TYPE_SHIFT==SWP_PFN_BITS?

Thanks,

-- 
Peter Xu

