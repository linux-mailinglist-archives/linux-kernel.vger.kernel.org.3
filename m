Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741695513AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiFTJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiFTJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:05:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA412ABF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:05:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d129so9733053pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3UAMRgLNUKIxsrxlZlgJWjAL/qolC/AWmLK/+MOtFbU=;
        b=UuqARljvt2lDepH6j3+On0x8yTeDj7JkXgMOkTHBJFvzV4XNnbPVVgNM9AMphFEIhh
         yBH/qPyqO8aHdFOHI4K/ZlSa0iGmE3KuvqtKemXbstoFSdxwuYy0EIhdf3X5Vfp4pzb3
         hDBlFnp2xqY8vtn1RXCLYHTceZ19brPP4253HFAjAJr20ijxluZ48t/vOV+dvZtKE1Ri
         P3Qm1MhYnhC/yr4pk2ydDPYJockJvJ8+f/vEaUzO9L7nIKDiMWV+PCNzoJnLF5LToHhZ
         VOc2KL+3iaNPKJN6DYGb32YS6BDhcbEf3bQtfWtYbbiWH0rGP4vl1U/Vh+LlieBvlAfK
         unqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3UAMRgLNUKIxsrxlZlgJWjAL/qolC/AWmLK/+MOtFbU=;
        b=MMLIJhOne3PwT6LZtDDE1OZuqzeGE07kB2Qgem751Oi3EjoT1V/ZrLFfYz/Qfvzp1J
         Qtexi5/ckHN1831/IBsWBgU/JQdQEj1qB9ahEfetRrJg5ndNN/Xofzbp3PLEoUvewS7G
         KMXwq2n/DYQoQ3opytSsgEcHuILbB9bMSKUWzZpSid4iNx32ecTLr8YDU/naV/hLF16X
         ld2EpfKZvhDy6dlkbQQB25JkvD/a/ZWqrpBtWWo2XurLICwvqUmVvaeA9cdB26SqwYXH
         zbrM1EzjFwzYMHWVsyixE8gV7mv3hViOXPfVlFcyupIX7WMRJLXAN+X3LFu403Ei3zhC
         5UMw==
X-Gm-Message-State: AJIora9yf1lrOeeq0cvaLxwiiX5vtdUCBVAEgYUI2LA2FFQxM3wRKa2H
        ulMCzUJwTH7SlrHKfQV85pzKCg==
X-Google-Smtp-Source: AGRyM1uFneyj/aNF0LntK4npbU3wUwEEFOJ5Gi7b2Ac3jTlxoh2hJBKVvvO6kYk72pHsKmsc5l0txQ==
X-Received: by 2002:aa7:8426:0:b0:525:23bf:1b78 with SMTP id q6-20020aa78426000000b0052523bf1b78mr4184127pfn.26.1655715915994;
        Mon, 20 Jun 2022 02:05:15 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001624b1e1a7bsm8059940plk.250.2022.06.20.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:05:15 -0700 (PDT)
Date:   Mon, 20 Jun 2022 17:05:10 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        corbet@lwn.net, mike.kravetz@oracle.com, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v4 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap
 compatible with memmap_on_memory
Message-ID: <YrA4RpM2SMn5RNnq@FVFYT0MHHV2J.usts.net>
References: <20220619133851.68184-1-songmuchun@bytedance.com>
 <20220619133851.68184-3-songmuchun@bytedance.com>
 <YrAgUtV6wD6CIrad@FVFYT0MHHV2J.usts.net>
 <226243a9-b4f5-182e-1a5b-7b8d5c28f3b3@redhat.com>
 <YrAv18GnMOcQaAxz@FVFYT0MHHV2J.usts.net>
 <YrAzeHbYt1mAs9ue@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrAzeHbYt1mAs9ue@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:44:40AM +0200, Oscar Salvador wrote:
> On Mon, Jun 20, 2022 at 04:29:11PM +0800, Muchun Song wrote:
> > > > Although it works, I think PageVmemmapSelfHosted() check for the 1st pfn's
> > > > vmemmap page is not always reliable.  Since we reused PG_owner_priv_1
> > > > as PG_vmemmap_self_hosted, the test is noly reliable for vmemmap page's
> > > > vmemmap page.  Other non-vmemmap page can be flagged with PG_owner_priv_1.
> > > > So this check can be false-positive. Maybe the following code snippet is
> > > > the solution.
> > > 
> > > How could that happen for pages used for backing a vmemmap?
> > >
> > 
> > It cannot happen for memmap_on_memory case. Howwver, it can happen for other
> > cases. E.g. the 1st pfn (of boot memory block) whose vmemmap page may be flagged
> > as PG_owner_priv_1 (if PG_swapcache is set). Then, the check is false-positive.
> 
> If this can really happen, which I am not that sure tbh, maybe a way out would be

I need to clarify this only can be happened by using this approach implemented
in this patch.

For a boot memory block, the vemmmap pages are not slef-hosted.  So the 1st pfn (of
this memory block) can be allocated to other users. e.g. an anonymous page with
PG_swapcache set.  In this patch, ALIGN_DOWN(pfn, PHYS_PFN(memory_block_size_bytes()))
will located on this anonymous page, then the check is false-positive.

[                  boot memory block                  ]
[        section        ][...][        section        ]
[                   usable memory                     ]

> to just define a new page-type as we did in previous versions of memmap_on_memory.
> In that way we would not for flags, but for its type.
>

I think we do not need to introduced a new flag, we just make sure the page
passed to PageVmemmapSelfHosted() is a backing page for vmemmap. Then we
cannot incur false-positive.  The feasible solution is walking page tables
to find a vmemmap page's backing page.

Thanks.
 
> But as I said, I am not entirely sure about the potential fallout of what you mention.
> 
> 
> -- 
> Oscar Salvador
> SUSE Labs
> 
