Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC256576634
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGORj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiGORjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 873282BD6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657906753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okIHgoCNos0gJ1ltx/Qs4rJoOZ4S1PC829YaSz7zsCM=;
        b=d11F+iUkmU6EIa/RyJma60Lj+Gyaj2rKOY23FCEWIyBh+W//9KgR5lAjstF0F3UNqVzvPZ
        e1QVrm//QVqt9DoF/c4jA2sOPsLHQG8HSXMIS+SEHbB4ltWZffbtZhs451P/tLIF1+zbOT
        LAXSAxqaEX9vKyN8+8yHtwEDPZpzrEg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-vFD3SBUeMsWdOKONeYyQLg-1; Fri, 15 Jul 2022 13:39:11 -0400
X-MC-Unique: vFD3SBUeMsWdOKONeYyQLg-1
Received: by mail-qk1-f199.google.com with SMTP id az32-20020a05620a172000b006b58ce94435so3911050qkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=okIHgoCNos0gJ1ltx/Qs4rJoOZ4S1PC829YaSz7zsCM=;
        b=lbLjTs1ksb1wX2kk9JVj3Z/ZQGAJD07y+jUw9WZJs8Rp6KiIuC+yXIE63juw9fEvSv
         qQ3d8vX0f2KQmxA74criaBKu1hEFX+uF74hc6H+x3UdXyGDSxt6doAYe1ha6kdeDZSUh
         rYA0W/zOF+HxzmBgFvaR0sRFlL/sy49LI/r9DeOZ73S88pOx/M+6ScRRt/rU87nk7+2H
         gm3b41wZG4sFN5viOrt76RREL6WPerA0yVi1gY0PPDKvoLEA2v8ftjleHcwPLpj5ax0r
         Zpa8zp6GjqoU+fc/zNsA57q8TVCOiR+bqt0RsyN/SN0xWhWp/rzpluN1IX0Ujsipu19W
         GW8w==
X-Gm-Message-State: AJIora9kYnQIXh/UcRQ2JuRhnvRqqnp56dAacUxAsvd5l2cE+qyR/b+k
        ylA7CqK30i7QRUnuxXCx0+nAOsBjlQcJI8cOrfA17swdY15BLOnToLSV4wWT8oI90BFhM9Xw4eY
        agTuUWzdAP3/RXVeoGd9KJvGQ
X-Received: by 2002:a05:620a:4107:b0:6b5:c5a8:b563 with SMTP id j7-20020a05620a410700b006b5c5a8b563mr5431798qko.583.1657906750323;
        Fri, 15 Jul 2022 10:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ttfm79EV4yyQ/OZ1KZGLrBE/4IghOIlt/6k6zahvulyR583FbGQND3x5DinIQUrP2enpN1PA==
X-Received: by 2002:a05:620a:4107:b0:6b5:c5a8:b563 with SMTP id j7-20020a05620a410700b006b5c5a8b563mr5431779qko.583.1657906750035;
        Fri, 15 Jul 2022 10:39:10 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id fu27-20020a05622a5d9b00b0031eb5fa4b50sm3842236qtb.39.2022.07.15.10.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:39:09 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:39:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <YtGmPI41S4w9iwr9@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
 <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
 <YtFfHU3fb/ncCG6O@xz-m1.local>
 <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com>
 <YtGe2qIO038e627p@xz-m1.local>
 <CAJHvVcji14hUsqg=yrtevEqwMtZi7Xwyj4yUnLMaZi0DBqPTHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcji14hUsqg=yrtevEqwMtZi7Xwyj4yUnLMaZi0DBqPTHA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:28:44AM -0700, Axel Rasmussen wrote:
> On Fri, Jul 15, 2022 at 10:07 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Jul 15, 2022 at 09:45:37AM -0700, Axel Rasmussen wrote:
> > > I agree we should either:
> > > - Update the UFFD selftest to exercise this case
> > > - Or, don't allow it, update vma_can_userfault() to also require VM_SHARED
> > > for VM_UFFD_MINOR registration.
> > >
> > > The first one is unfortunately not completely straightforward as Peter
> > > described. I would say it's probably not worth holding up this fix while we
> > > wait for it to happen?
> >
> > Agreed, Andrew has already queued it.  It actually is a real fix since we
> > never forbid the user running private mappings upon minor faults, so
> > it's literally a bug in kernel irrelevant of the kselftest.
> >
> > >
> > > I don't really have a strong preference between the two. The second option
> > > is what I originally proposed in the first version of the minor fault
> > > series, so going back to that isn't a problem at least from my perspective.
> > > If in the future we find a real use case for this, we could always easily
> > > re-enable it and add selftests for it at that point.
> >
> > I'd go for fixing the test case if possible.  Mike, would it be fine if we
> > go back to /dev/hugepages path based approach in the test case?
> 
> One possible alternative, can we use memfd_create() with MFD_HUGE_*?
> This afaict lets us have an fd so we can create two mappings,
> without having to mount hugetlbfs, pass in a path to the test, ...

Sounds good. :) We can also rework the shared hugetlb too.  Wanna post a
patch?  I can do that too, let me know otherwise.  Thanks!

-- 
Peter Xu

