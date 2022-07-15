Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303F457662D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiGORiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGORiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49BF152FF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657906686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+QJFgzXdNV/CBVZ6SM9/IIKX+DwJmeA8immjPOoWrIc=;
        b=e2tZYFO10CBMw0LiEHtHne/UE4PVLeaL2qEo+8dYJVyo9gx/D9p1/MdvNR/wryzkfkU3WL
        XqY2+PSMgaVLAmGMnPl9MmRsHUOaQoCF0vsyYK7l4V4pPu/63XeVWTSyQuKkWH2dcxlrQC
        b8V7Y9uS8OEivCRTcDrNg7YTRRT64Lg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-A5oDm8IKN8Wfqkw_LaL7fA-1; Fri, 15 Jul 2022 13:38:05 -0400
X-MC-Unique: A5oDm8IKN8Wfqkw_LaL7fA-1
Received: by mail-qt1-f197.google.com with SMTP id x16-20020ac85f10000000b0031d3262f264so4042509qta.22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+QJFgzXdNV/CBVZ6SM9/IIKX+DwJmeA8immjPOoWrIc=;
        b=rJa4ODGk3/5K3HYCy6wd3Hy6TjD9IZ4whnRluLppHvKcujxGlPKKQsCfY5RSCh+9/k
         JD3d7Y+p4qUFPYhWVR9/rDEwkEO7AdQa1CZG+82X/rBRlTrFJzNDejK49QgKgWnGuana
         pBhLuaJWhuXMhCUTRaC2GbjojevDG+kPo26+yHeyyrgpve/Z19ZXk2qO6IJ19DtSQo+5
         HaJZZiuV2G5Pv39Se/MNZjNpNWOTUSJpn0CCoxK/32FIhhtH3WB2p8ZpNNZbRg1ELVwP
         E7IX3vAZ9XDe39feHmpBgBU5hbirdiOmjqxhhmVzyYnRgXV9PErhhTyiozQ3NzlfiPcE
         V2Bw==
X-Gm-Message-State: AJIora8qaoDLXBUBWqm/KHZ4Kouw1q8ZQZpmWwHnOtOceUp6w0u1fe8f
        1Yy184Ti4XGasy1g0L60qeZ9otIUs1L4aqelUgbBwXRfu6n2gkAVT5h0X03AdS3BhJbsEV9IIJv
        4Ncr3YhThlpKUFpSCAVOppXNn
X-Received: by 2002:a05:622a:3d2:b0:31e:9704:dfe4 with SMTP id k18-20020a05622a03d200b0031e9704dfe4mr13304146qtx.240.1657906684767;
        Fri, 15 Jul 2022 10:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t7MbHPD0/BZrxEZLLpMTZMXqpIbIlTg/PFCo+sShkoR38wOq6CLGHtWYk9DfydCQqcXSO1/g==
X-Received: by 2002:a05:622a:3d2:b0:31e:9704:dfe4 with SMTP id k18-20020a05622a03d200b0031e9704dfe4mr13304133qtx.240.1657906684408;
        Fri, 15 Jul 2022 10:38:04 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s27-20020a05622a1a9b00b0031d3996d304sm4271352qtc.17.2022.07.15.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:38:03 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:38:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <YtGl+bqat/H+wtk8@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
 <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
 <YtFfHU3fb/ncCG6O@xz-m1.local>
 <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com>
 <YtGe2qIO038e627p@xz-m1.local>
 <YtGj/YYixDT0npgL@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YtGj/YYixDT0npgL@monkey>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:29:33AM -0700, Mike Kravetz wrote:
> On 07/15/22 13:07, Peter Xu wrote:
> > On Fri, Jul 15, 2022 at 09:45:37AM -0700, Axel Rasmussen wrote:
> > > I don't really have a strong preference between the two. The second option
> > > is what I originally proposed in the first version of the minor fault
> > > series, so going back to that isn't a problem at least from my perspective.
> > > If in the future we find a real use case for this, we could always easily
> > > re-enable it and add selftests for it at that point.
> > 
> > I'd go for fixing the test case if possible.  Mike, would it be fine if we
> > go back to /dev/hugepages path based approach in the test case?
> > 
> 
> No problem going back to using a file for private mapping testing.  Removing
> that was more of a simplification, because of new MADV_DONTNEED support.
> Just want to make sure we also keep remap and remove event testing.

Yeah definitely, thanks Mike!

-- 
Peter Xu

