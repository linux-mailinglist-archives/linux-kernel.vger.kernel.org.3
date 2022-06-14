Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6054A7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiFNERf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiFNER3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:17:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A6101DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:17:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e11so7531095pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6dJRIYQeBiwdqkEyQXK5bbwytY5J/MNh7n1Czybxz00=;
        b=hSDYK+5NMFmmgN7ucoYKtg/LTTSdpexcHGmpof3CyC7gtJ8xv7mpAi7dCXAkG1Ujl3
         8aVAWBhsQ7UZy34Y/RTX4uX0zMGdt8nOLYXI9yI+l+NHxTvOIXTnHJm84fDVRoknFK4w
         R3LV26gHoJEfHSjTt1co3ls/niUVQ82Y2MzLb3xTyJeFydyddYBbBbdE/Yb2GXZFH/q7
         5Uqh3jKVPklh5/RHY04Q2ZffwuTnJqAFC+VqeyP1ex5dl+IbYEmzJrOgN6ymEr1NZNT4
         hVgAitP1FlSbnBj3I+nwLf+MYyQ9GicsR8oYs6am3LC8WQOSqH4INbcqHlKqTguXNEbY
         OjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6dJRIYQeBiwdqkEyQXK5bbwytY5J/MNh7n1Czybxz00=;
        b=GSsbOZQnfnBqTeNPTYkXpZfbYF3Ipi8SIW1TwLXTkLSFyVfqE2F5Rkdmg07etf4eCU
         V29wP8bNBVLSbqmhyRP7si9ezOHm+4Bx0TDunzKQUvxPvjwULthVklPr2KzKfIF0VF4S
         kBnh4cz1jJM+bJPUvQHz3r4JBbRORtZOh19BUqfK76yu/+ZeafAJiZigftegufRm7zWf
         nTEe4Pch2TNOxybSpIRxciq/yfXgHs/JoM++aXOKmkt5t7fMA1BzFJ0LUKa3sazhbFS8
         AsilW5d7hv08naNScqWN1rQmL8s7zByoCwpzeRY7J+biC2aPzlZ1YldVMi/bzmN34oM3
         Uz4A==
X-Gm-Message-State: AOAM533qJ2oHg9QfaYTvgRyxSBT12I/s8S7IUa3jles9TVGmxX+aI22z
        vRLYX6fJG2+4uZozmBj9epnFQA==
X-Google-Smtp-Source: ABdhPJxgft2ux5nboh5dJXvGaSOZCadJLfXkYbghmSd5tJoQ0IpefLnYqg45oxkagiMpeZ9FAHRl4g==
X-Received: by 2002:a05:6a00:729:b0:4f7:77ed:c256 with SMTP id 9-20020a056a00072900b004f777edc256mr2734122pfm.1.1655180246058;
        Mon, 13 Jun 2022 21:17:26 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id cd6-20020a056a00420600b0050dc7628162sm6205484pfb.60.2022.06.13.21.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 21:17:25 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:17:21 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <YqgL0ZcU5dhhO5uL@FVFYT0MHHV2J.usts.net>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-7-songmuchun@bytedance.com>
 <Yqb2bA25HhLU/mpM@localhost.localdomain>
 <Yqb89waW/jcsgRgo@FVFYT0MHHV2J.usts.net>
 <YqfUxscKfUhT35jR@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqfUxscKfUhT35jR@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:22:30PM -0700, Mike Kravetz wrote:
> On Mon, Jun 13, 2022 at 05:01:43PM +0800”, Muchun Song wrote:
> > On Mon, Jun 13, 2022 at 10:33:48AM +0200, Oscar Salvador wrote:
> > > On Mon, Jun 13, 2022 at 02:35:12PM +0800, Muchun Song wrote:
> > > > -static __init int hugetlb_vmemmap_sysctls_init(void)
> > > > +static int __init hugetlb_vmemmap_init(void)
> > > >  {
> > > > +	const struct hstate *h;
> > > > +	bool optimizable = false;
> > > > +
> > > >  	/*
> > > > -	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> > > > -	 * be optimized.
> > > > +	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> > > > +	 * page structs that can be used when HVO is enabled.
> > > >  	 */
> > > > -	if (is_power_of_2(sizeof(struct page)))
> > > > -		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> > > > +	BUILD_BUG_ON(__NR_USED_SUBPAGE >= RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> > > 
> > > I need to take another look, but from the first glance there is something
> > > here that caught my eye.
> > >
> > 
> > Thanks for taking a look. This is introduced in commit f41f2ed43ca5.
> >  
> > > > +
> > > > +	for_each_hstate(h) {
> > > > +		char buf[16];
> > > > +		unsigned int size = 0;
> > > > +
> > > > +		if (hugetlb_vmemmap_optimizable(h))
> > > > +			size = hugetlb_vmemmap_size(h) - RESERVE_VMEMMAP_SIZE;
> > > > +		optimizable = size ? true : optimizable;
> > > 
> > > This feels weird, just use false instead of optimizable.
> > >
> > 
> > This is a loop, we shoud keep "optimizable" as "true" as long as there is one
> > hstate is optimizable. How about:
> > 
> >   if (size)
> > 	optimizable = true;
> > 
> > > > +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf,
> > > > +				sizeof(buf));
> > > > +		pr_info("%d KiB vmemmap can be optimized for a %s page\n",
> > > > +			size / SZ_1K, buf);
> > > 
> > > I do not have a strong opinion but I wonder whether this brings a lot.
> > >
> > 
> > I thought the users can know what size HugeTLB is optimizable via
> > this log.  E.g. On aarch64, 64KB HugeTLB cannot be optimizable.
> > I do not have a strong opinion as well, if anyone think it is
> > unnecessary, I'll drop it in next version.
> 
> I do not have a strong opinion.  I think it adds a little information.  For me,
> the new logging of number of pages vmemmap optimized at boot seems a bit
> redundant.  Here is a BEFORE/AFTER comparison.
>

Well, I'll drop the "new logging".
 
> BEFORE
> ------
> [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
> ...
> [    0.330930] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
> [    0.350450] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
> [    0.359282] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.359285] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages
> 
> AFTER
> -----
> [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
> ...
> [    0.409068] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.409071] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages
> [    1.246107] HugeTLB: 16380 KiB vmemmap can be optimized for a 1.00 GiB page
> [    1.246110] HugeTLB: 28 KiB vmemmap can be optimized for a 2.00 MiB page
> [    1.246123] HugeTLB: 512 huge pages whose vmemmap are optimized at boot
> 
> When I read those messages, I am not sure if 'optimized' is the best
> word to use.  I know that using alloc/free throughout the code was
> confusing.  But, wouldn't it perhaps be more clear to the end user if
> the messages read?

Well, I agree with you at least. "free" may be more friendly to the end
users.  I'll change the word "optimized" to "freed".

> 
> HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> 
> Also, how about having report_hugepages() call a routine that prints the
> vmemmmap savings.  Then output could then look something like:
> 
> HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> 	 16380 KiB vmemmap can be freed for a 1.00 GiB page
> HugeTLB: registered 2.00 MiB page size, pre-allocated 512 pages
> 	 28 KiB vmemmap can be free for a 2.00 MiB page
>

Well, we eliminate the prefix "HugeTLB:" for memory saving log.
Maybe it is not a good choice since it it not easy to grep the log
(e.g. dmesg | grep "HugeTLB" will not show saving log).  If
we combine both 2-line log into one line, the log becomes a bit long.
So I'd like to not eliminate the prefix but gather this 2-line log
into one place. I mean "HugeTLB: registered 1.00 GiB page size,
pre-allocated 0 pages" is just followed by "HugeTLB: 28 KiB vmemmap
can be freed for a 2.00 MiB page" without any log insertion in
between. But I have no strong opinion do this, I'd likt to listen
to your opinion before making decision to do those changes.

Thanks.

> Not insisting on these changes.  Just wanted to share the ideas.
> 
> 
> Overall, the code improvements look good.
> -- 
> Mike Kravetz
> 
