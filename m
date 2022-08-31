Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893495A87EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiHaVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C6F32C2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661980161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7Gxcm/s5JjFXHzoKoyt8QS8s8qTIKG6E+N6uf7ppnw=;
        b=FAb4WlklL3KknZOocXoXZ8D6js2ET7AOFnp7RgoL0IxK9nMZIkMLZyxPZJqmc87rPe2uQG
        ee2YzgCO4Z1Ii6VZ3AqauvTkcHUvBbuy7wmLCVuUs1IXzIEaxHLeiJiVzf6ZE7rOZ8TNzh
        S3jpkEltYZADx0PM6OZIngsWs4WIEfM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-yWwy2qHMPeejgnJLok1-hA-1; Wed, 31 Aug 2022 17:09:20 -0400
X-MC-Unique: yWwy2qHMPeejgnJLok1-hA-1
Received: by mail-qt1-f199.google.com with SMTP id fv24-20020a05622a4a1800b003445e593889so12057898qtb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=O7Gxcm/s5JjFXHzoKoyt8QS8s8qTIKG6E+N6uf7ppnw=;
        b=e7q04sG2JXHfp4fJk4Dnfw4FPw0YkRULP14O2zAkAy7x0EbXEVMngr1NR1TBqFWyev
         MAd112aeC1eOOfzAWSenOrAMrmTl8dlQT/Mfet3SxWXQ9e5uNhqxyVTVEuIvA2ta0i25
         xWl06YZZ+uD+X8KbSosXVbso4In8jBHeBhMCcbEo8OTUppmRuz9skk/8zwzoW0s0K0cT
         ACwiQtYxkNOh8YiAeO84FYh/+Nxrryr3L5FmjOtDgdq55YLX5tQ0TZx6c/S2X4mrrD7G
         K3i2z/TpJ4IGhCB9WOwLgg7JKy8wzFJ/Gc3ecKyUnjhswP1//9JKiths+zR54iuFTDeS
         PYNw==
X-Gm-Message-State: ACgBeo3DWfsUhuXOt18sEAbp0gE/J6Ti/GpND+c/PM7FvFfzO8fGySWr
        WSvYdcU/q+nRmuOdBPs17baIblXBpq+ditTjNkSzZvUbSvIlW8RLyXpXERhiVK7pfs26/tvz2rj
        6NyAZ+XINGlBN79U9g0qailw+
X-Received: by 2002:a05:6214:2a4b:b0:499:eb9:6ed3 with SMTP id jf11-20020a0562142a4b00b004990eb96ed3mr9976096qvb.66.1661980160119;
        Wed, 31 Aug 2022 14:09:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7KnucFaurEW/OxhH/oVN1y7qvS5ITOg5YIp5lqcCuKoGcQLmHlVatvAlu9P/DXe+Mq5ON7rA==
X-Received: by 2002:a05:6214:2a4b:b0:499:eb9:6ed3 with SMTP id jf11-20020a0562142a4b00b004990eb96ed3mr9976082qvb.66.1661980159943;
        Wed, 31 Aug 2022 14:09:19 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006bbc09af9f5sm11066305qko.101.2022.08.31.14.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:09:19 -0700 (PDT)
Date:   Wed, 31 Aug 2022 17:09:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
Message-ID: <Yw/N/RuCdcjlOZPS@xz-m1.local>
References: <20220831083024.37138-1-david@redhat.com>
 <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <Yw+uASvgWU5+9PvI@xz-m1.local>
 <CAHbLzkpH=a-gbwZYfJx6qD_Rvz6AEP+xwCKDbwJRPNt9W3Anxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkpH=a-gbwZYfJx6qD_Rvz6AEP+xwCKDbwJRPNt9W3Anxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 01:38:21PM -0700, Yang Shi wrote:
> On Wed, Aug 31, 2022 at 11:52 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Aug 31, 2022 at 10:55:43AM -0700, Yang Shi wrote:
> > > On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > The comment is stale, because a TLB flush is no longer sufficient and
> > > > required to synchronize against concurrent GUP-fast. This used to be true
> > > > in the past, whereby a TLB flush would have implied an IPI on architectures
> > > > that support GUP-fast, resulting in GUP-fast that disables local interrupts
> > > > from completing before completing the flush.
> > >
> > > Hmm... it seems there might be problem for THP collapse IIUC. THP
> > > collapse clears and flushes pmd before doing anything on pte and
> > > relies on interrupt disable of fast GUP to serialize against fast GUP.
> > > But if TLB flush is no longer sufficient, then we may run into the
> > > below race IIUC:
> > >
> > >          CPU A                                                CPU B
> > > THP collapse                                             fast GUP
> > >
> > > gup_pmd_range() <-- see valid pmd
> > >
> > > gup_pte_range() <-- work on pte
> > > clear pmd and flush TLB
> > > __collapse_huge_page_isolate()
> > >     isolate page <-- before GUP bump refcount
> > >
> > >    pin the page
> > > __collapse_huge_page_copy()
> > >     copy data to huge page
> > >     clear pte (don't flush TLB)
> > > Install huge pmd for huge page
> > >
> > > return the obsolete page
> >
> > Maybe the pmd level tlb flush is still needed, but on pte level it's
> > optional (where we can rely on fast-gup rechecking on the pte change)?
> 
> Do you mean in khugepaged?

What I wanted to say before was that the immediate tlb flush (after pgtable
entry cleared) seems to be only needed by pmd level to guarantee safety
with concurrent fast-gup, since fast-gup can detect pte change after
pinning, and that should already guarantee safe concurrent fast-gup to me.

After reading the other emails, afaiu we're on the same page.

> It does TLB flush, but some arches may not use IPI.

Yeah, I see that ppc book3s code has customized pmdp_collapse_flush() to
explicit do the IPIs besides tlb flush using smp calls.

I assume pmdp_collapse_flush() should always be properly implemented to
guarantee safety against fast-gup, or I also agree it could be a bug.

-- 
Peter Xu

