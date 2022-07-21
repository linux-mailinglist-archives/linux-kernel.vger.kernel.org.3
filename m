Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341F657D467
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiGUTxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF320691D1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658433197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ll575DJoxkh8lFqVhc8EJOSqoHRZjxOqFyBiQJk0Ho=;
        b=DfsLr0fM0pJUonwuGN1z5xvQ+lyp/Ut69Z4NIU0bivAr6YZNCLTKu7tj+vTMXEl6NrUJDF
        +MIBCh4EItdRJxoAAoGrEBiTfxZVuhgQdVm3J4+I1bv5Nzxfr2XUoBRVgjQZioLGSh2DPx
        MHzV9Vx3skHQXrg0dujKWbHY4EDvmM8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-fZiRqnJZNjKiPf6-rxYExQ-1; Thu, 21 Jul 2022 15:53:13 -0400
X-MC-Unique: fZiRqnJZNjKiPf6-rxYExQ-1
Received: by mail-qk1-f197.google.com with SMTP id w22-20020a05620a425600b006b5f48556cbso2071688qko.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Ll575DJoxkh8lFqVhc8EJOSqoHRZjxOqFyBiQJk0Ho=;
        b=fI+1NOiHxcDQnUCpcnG3FNFVvQBvI4krihbiaxV5kYHrhde63nP+2iDNtcwGs/+gYu
         11HtkcRHynanXllenuyGHEfurA5rTlSOgEjqVJXYB1uhFhQRGEQ6z7Ky57ecCJ5uM54f
         OgXodfhR+m88yYMp5Xg2ij1BRQm8TdsrfvIcIU5nF8bjBsFePq71Tz3uCw7lwZIdZanT
         SkeUoaR45rbU8Gu6MmSRKsZOi52ZEOgFuL5xN2AdRQ3Ocy+oFal8f5K01OIKGEK0IWPJ
         ZRCBZKLGKq0KXEEW5Pw+1h14cctXwVHhEBkmDxJ8vFm5hG6TlIYnIkyIBEES/cAM5x8x
         Lp6A==
X-Gm-Message-State: AJIora9chX8lDCbC716uGBHwIDVtBelH1tmnihKXETg8kcXNUsoA1xQ6
        6zmOVwfQeobn5RHgUyjt6kWArio4UQcyOtYScTLJgv2eKnbJIgTV18NloqCAmzCARlhIfQsV67Q
        v9j7O8350i48XZ9cPN3E8KIQs
X-Received: by 2002:a37:c401:0:b0:6b5:e0c5:39f4 with SMTP id d1-20020a37c401000000b006b5e0c539f4mr46588qki.455.1658433192864;
        Thu, 21 Jul 2022 12:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqQdd9qUU3kIybPnGtmypi2hKHjCJQKLjdXOkzbmByKXn8wi2UcUFtmm3Y40UUfhsPdWP+ww==
X-Received: by 2002:a37:c401:0:b0:6b5:e0c5:39f4 with SMTP id d1-20020a37c401000000b006b5e0c539f4mr46565qki.455.1658433192574;
        Thu, 21 Jul 2022 12:53:12 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a415500b006b5ed1eccc5sm2259278qko.44.2022.07.21.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:53:12 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:53:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 20/26] hugetlb: add support for high-granularity
 UFFDIO_CONTINUE
Message-ID: <YtmupryTFRJWRW/t@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-21-jthoughton@google.com>
 <YtGUARcBHxLU0axU@xz-m1.local>
 <CADrL8HXYab_VJS=Y0h2OSiCrj2pYbDJME2P=Tsn9jcDRbcqR1g@mail.gmail.com>
 <YtGh46Jr0EGpqW7s@xz-m1.local>
 <CADrL8HX1YbDArmPsGUH+7b6dNxDa3Xo+fd5npGgz=RFehSw6iA@mail.gmail.com>
 <YtmkX73/wzptkZbu@xz-m1.local>
 <CADrL8HVDtnDg0M4C4A7LN2dmnT2bMXSjJadE=guKFniK_EPdkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HVDtnDg0M4C4A7LN2dmnT2bMXSjJadE=guKFniK_EPdkQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:44:58PM -0700, James Houghton wrote:
> On Thu, Jul 21, 2022 at 12:09 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Jul 20, 2022 at 01:58:06PM -0700, James Houghton wrote:
> > > > > > > @@ -335,12 +337,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> > > > > > >       copied = 0;
> > > > > > >       page = NULL;
> > > > > > >       vma_hpagesize = vma_kernel_pagesize(dst_vma);
> > > > > > > +     if (use_hgm)
> > > > > > > +             vma_altpagesize = PAGE_SIZE;
> > > > > >
> > > > > > Do we need to check the "len" to know whether we should use sub-page
> > > > > > mapping or original hpage size?  E.g. any old UFFDIO_CONTINUE code will
> > > > > > still want the old behavior I think.
> > > > >
> > > > > I think that's a fair point; however, if we enable HGM and the address
> > > > > and len happen to be hstate-aligned
> > > >
> > > > The address can, but len (note! not "end" here) cannot?
> > >
> > > They both (dst_start and len) need to be hpage-aligned, otherwise we
> > > won't be able to install hstate-sized PTEs. Like if we're installing
> > > 4K at the beginning of a 1G hpage, we can't install a PUD, because we
> > > only want to install that 4K.
> >
> > I'm still confused...
> >
> > Shouldn't one of the major goals of sub-page mapping is to grant user the
> > capability to do UFFDIO_CONTINUE with len<hpagesize (so we install pages in
> > sub-page level)?  If so, why len needs to be always hpagesize aligned?
> 
> Sorry I misunderstood what you were asking. We allow both to be
> PAGE_SIZE-aligned. :) That is indeed the goal of HGM.

Ah OK. :)

> 
> If dst_start and len were both hpage-aligned, then we *could* set
> `use_hgm = false`, and everything would still work. That's what I
> thought you were asking about. I don't see any reason to do this
> though, as `use_hgm = true` will only grant additional functionality,
> and `use_hgm = false` would only -- at best -- be a minor performance
> optimization in this case.

I just want to make sure this patch won't break existing uffd-minor users,
or it'll be an kernel abi breakage.

We'd still want to have e.g. existing compiled apps run like before, which
iiuc means we should only use sub-page mapping when len!=hpagesize here.

I'm not sure it's only about perf - the app may not even be prepared to
receive yet another page faults within the same huge page range.

-- 
Peter Xu

