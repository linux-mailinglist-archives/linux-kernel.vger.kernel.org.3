Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5272654A773
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353452AbiFNDP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiFNDPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:15:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB62D1C6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:15:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id r1so6666119plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X20XqUG2gPAVpTAbsbAwNoi/uST6VyCpegzSApOjB3E=;
        b=EmjKAQ1yo9tlCNQ5ShZ8eeDUSVfFmuekpqG7pnCRO/yi8MGB+IW/iz+ISXCJk1Q+cO
         XDbO2j19zeIuBaQqPByQfy09Oa0z6NBP79DW+f5JyJ6R4OzIfkMuSQPDOhIw44pwguPv
         5GA1ZAj+3hp3BCmQMBKEb+KTXliOXaEzulBeWVdp+uUx6DUeL75kkk2gl01PP63vCHNV
         OlSkKfMVijd0i6MtoMDNNZL+eolM8GfRGt3fmrn9RwB4MSnRbKFYb7tdjjFTmqRV2UX+
         bJ++oDBCuEHE4jvFd8lZeY6JsxgWKkjpSTXWZ3AxmwsfsmLK8Oe64Ax6aQWyNRlGpwPq
         jTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X20XqUG2gPAVpTAbsbAwNoi/uST6VyCpegzSApOjB3E=;
        b=u+GTbLfTmW/lGq/Zp/slVhzrlGxNLnWhGAGwpz3rSsI3GMXFOnZr5hNZx5xSLcABoN
         sSosXVCkG+efymjkPY9n5ZHvP2o6RkPvzGvBr4IKhlogjvoud48lsHuiEFAPR/8ALM5z
         Sv4p3cf7JlacEq4QtXS6W/VYnWtmbp+/MAn/eKzzq6p62uP9d6LeY3WuJGURFptr60wB
         4m35767zYKJN4UXc9oZ5RjfAaQbiPFtBWaXWHxbE2XZEP4OFWWqBGbhyINed+TXVThhy
         +m4oUPMUq+I2LB9QZWUXfjTxkhVza4Uh7FydcHF31dorenYgH3h7OQuUH8WJNB/RoEsc
         jOJA==
X-Gm-Message-State: AOAM530QcfDti4Fw7qAr3DvgZsjvmMuORNrbkYvjqcJPt9pJtfqSK3i+
        SkbriNPL91nsE9ajdaWBMNJMrg==
X-Google-Smtp-Source: AGRyM1ukUxeZ2cHQoIed+a0v/M0Zp41L5bIUZ6Z3UnO9Gt2OahHai6e2mnsTlgui060S1ZC8xOQjzQ==
X-Received: by 2002:a17:902:c244:b0:168:c4c3:e80e with SMTP id 4-20020a170902c24400b00168c4c3e80emr2492000plg.18.1655176553058;
        Mon, 13 Jun 2022 20:15:53 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902820400b00163fbb1eec5sm5855864pln.229.2022.06.13.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 20:15:52 -0700 (PDT)
Date:   Tue, 14 Jun 2022 11:15:49 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: hugetlb_vmemmap: introduce the name HVO
Message-ID: <Yqf9Ze5ox00TaV8v@FVFYT0MHHV2J.usts.net>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-4-songmuchun@bytedance.com>
 <4a6023f3-0fbd-32cf-7e52-bc72e2b4a407@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6023f3-0fbd-32cf-7e52-bc72e2b4a407@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:39:59PM +0200, David Hildenbrand wrote:
> On 13.06.22 08:35, Muchun Song wrote:
> > It it inconvenient to mention the feature of optimizing vmemmap pages associated
> > with HugeTLB pages when communicating with others since there is no specific or
> > abbreviated name for it when it is first introduced.  Let us give it a name HVO
> > (HugeTLB Vmemmap Optimization) from now.
> > 
> > This commit also updates the document about "hugetlb_free_vmemmap" by the way
> > discussed in thread [1].
> > 
> > Link: https://lore.kernel.org/all/21aae898-d54d-cc4b-a11f-1bb7fddcfffa@redhat.com/ [1]
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  7 ++++---
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +--
> >  Documentation/admin-guide/sysctl/vm.rst         |  3 +--
> >  fs/Kconfig                                      | 13 ++++++-------
> >  mm/hugetlb_vmemmap.c                            |  8 ++++----
> >  mm/hugetlb_vmemmap.h                            |  4 ++--
> >  6 files changed, 18 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 391b43fee93e..7539553b3fb0 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1725,12 +1725,13 @@
> >  	hugetlb_free_vmemmap=
> >  			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >  			enabled.
> > +			Control if HugeTLB Vmemmap Optimization (HVO) is enabled.
> >  			Allows heavy hugetlb users to free up some more
> >  			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
> > -			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 (default) }
> > +			Format: { on | off (default) }
> >  
> > -			[oO][Nn]/Y/y/1: enable the feature
> > -			[oO][Ff]/N/n/0: disable the feature
> > +			on: enable HVO
> > +			off: disable HVO
> >  
> >  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
> >  			the default is on.
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index a90330d0a837..64e0d5c512e7 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -164,8 +164,7 @@ default_hugepagesz
> >  	will all result in 256 2M huge pages being allocated.  Valid default
> >  	huge page size is architecture dependent.
> >  hugetlb_free_vmemmap
> > -	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables optimizing
> > -	unused vmemmap pages associated with each HugeTLB page.
> > +	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables HVO.
> 
> Heh, it would be convenient to call this
> 
> CONFIG_HUGETLB_PAGE_VMEMMAP_OPTIMIZATION (HVO) then.
>

Thanks for pointing it out. I would take Mike's suggestion. I would change to:

  When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set this enables
  HugeTLB Vmemmap Optimization (HVO).

Thanks.
