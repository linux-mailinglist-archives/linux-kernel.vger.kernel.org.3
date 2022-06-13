Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E85482CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiFMJBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiFMJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:01:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D871A457
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:01:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u2so5198031pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dpkFPXwH8N70T2WIaGxLUqPTMbphsnf0gmKqluawR5w=;
        b=jreuVdGv6lf5T0ak6AmbOb79gJnnkRPj55ArCmGE+9q16i/W4yyNDItf+WoX7Qod5G
         v6Ox4HL5s5CdRLXadrGeF9+4Wynirq+pruiqrLo3dEHkQxKemDm1crfIGSX/af8U4H8G
         4C7mHWsJFyrFCOc+ib9tMZqfARjHodA6d4eOZiuETuOkQ/rc8Mv1UnyIliNECrRxECG4
         fIG+fhBliVI4qncveDU2MhhbOzrroRrk0A32z4kSia98SqfrgclP1EqbOGuysZBxxYEO
         YQNfmC1G2eIVQi7sgTmJveQCRndww8IW1Zp43yhq7vOIZS7SLn3NOKfnwKK5neAAEzzv
         oKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpkFPXwH8N70T2WIaGxLUqPTMbphsnf0gmKqluawR5w=;
        b=1jpiHh7cseiqOhWnehvP5e32XPAoYN+JKyOy5FFSvI67FrHTZdUSxgSUyBLNBwj6B8
         cBuafFzaP5s8cgQZj7Bpq6BGovozz1yrYGU81lkAZ437OqgcVqdToUlgWt/+/bKNXy89
         kCWVdLvwyAX7DvPB438n6VNLZPf2AlbPu/lfiTtEOvB5HIshSg13bj1pVhfJCFvckLMB
         jd1OFow2ic+cnkHjEVUOLMNJBXt38wvHuhQzbKCpjETmYWdH+kBEUfGwgt6dEJGdjr2D
         5DRvKckrBsfAMepMpDGASu8D72MdcVvl3t26d8TqjbhdAV+2syAYkmS0VCLmoH6FuEVl
         +a4A==
X-Gm-Message-State: AOAM5334PgkbMb8s9Ne0S8lQiVuumZjelzAZM/dSPbUw0WuGTLZ39Lbj
        XRGezQ5ybf2hSmMcL6Yol+Z1Uw==
X-Google-Smtp-Source: ABdhPJxApn2CFCOq6CupZRjITh38l7zl4N2mKhELqQ9kxxOlAbz6FnIv59v+4TjqrZcmd0e/7ENCnQ==
X-Received: by 2002:a05:6a00:410a:b0:51e:6fc6:e4da with SMTP id bu10-20020a056a00410a00b0051e6fc6e4damr20340880pfb.84.1655110907858;
        Mon, 13 Jun 2022 02:01:47 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001638a171558sm4509347plq.202.2022.06.13.02.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:01:47 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:01:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <Yqb89waW/jcsgRgo@FVFYT0MHHV2J.usts.net>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-7-songmuchun@bytedance.com>
 <Yqb2bA25HhLU/mpM@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqb2bA25HhLU/mpM@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:33:48AM +0200, Oscar Salvador wrote:
> On Mon, Jun 13, 2022 at 02:35:12PM +0800, Muchun Song wrote:
> > -static __init int hugetlb_vmemmap_sysctls_init(void)
> > +static int __init hugetlb_vmemmap_init(void)
> >  {
> > +	const struct hstate *h;
> > +	bool optimizable = false;
> > +
> >  	/*
> > -	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> > -	 * be optimized.
> > +	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> > +	 * page structs that can be used when HVO is enabled.
> >  	 */
> > -	if (is_power_of_2(sizeof(struct page)))
> > -		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> > +	BUILD_BUG_ON(__NR_USED_SUBPAGE >= RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> 
> I need to take another look, but from the first glance there is something
> here that caught my eye.
>

Thanks for taking a look. This is introduced in commit f41f2ed43ca5.
 
> > +
> > +	for_each_hstate(h) {
> > +		char buf[16];
> > +		unsigned int size = 0;
> > +
> > +		if (hugetlb_vmemmap_optimizable(h))
> > +			size = hugetlb_vmemmap_size(h) - RESERVE_VMEMMAP_SIZE;
> > +		optimizable = size ? true : optimizable;
> 
> This feels weird, just use false instead of optimizable.
>

This is a loop, we shoud keep "optimizable" as "true" as long as there is one
hstate is optimizable. How about:

  if (size)
	optimizable = true;

> > +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf,
> > +				sizeof(buf));
> > +		pr_info("%d KiB vmemmap can be optimized for a %s page\n",
> > +			size / SZ_1K, buf);
> 
> I do not have a strong opinion but I wonder whether this brings a lot.
>

I thought the users can know what size HugeTLB is optimizable via
this log.  E.g. On aarch64, 64KB HugeTLB cannot be optimizable.
I do not have a strong opinion as well, if anyone think it is
unnecessary, I'll drop it in next version.

Thanks.

