Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9250D5252AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356518AbiELQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356506AbiELQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BF85207934
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652373285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgNwvZiNKQbPzzXRivhIk29V2U2Bsc1enjkVdinryPo=;
        b=Xwo6nlL/sHJdl40U+QRW+1HXoS1EZ0iooCAGEvbUyoTb+crXc2xJ8XFn7uvFTWpY7YhHsY
        hH7h+41mDd62gR2OMpHYpvXEwWYynRhx8nQKa5z7ThTaV6DRLGNrpW/jWyP4oLDv+ehBBC
        4p3nrNXEQwA3kjNugmS4sufLigZuk8A=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-q7xYXWGAM0KtC3-5IfahFA-1; Thu, 12 May 2022 12:34:41 -0400
X-MC-Unique: q7xYXWGAM0KtC3-5IfahFA-1
Received: by mail-io1-f70.google.com with SMTP id r137-20020a6b2b8f000000b0065dbbc04e94so2555482ior.16
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IgNwvZiNKQbPzzXRivhIk29V2U2Bsc1enjkVdinryPo=;
        b=ADPmcIiTzh6zXGH0lHoZdebK+EGvDWFGhu6ruWSUSw/WxLaDAgNw1awueYJEUkIEmQ
         G8WjouBuoLnzGKv4XTdxEmZlShal7hlw27MAlqsR3whyp++TwsaDOIqBYJpNSPb2VftB
         Kw4DuwnsZ6nA2xsiAmjPXGMaJN4oQSolwsI4UMHtiL8u6GeWTm0taXZF+J+lKgwoRJfp
         cbqTISLbIku3M6boFnYFKpCBdrQjST+ALI00nhgFUKK3Zf1czIfLGgc73e5X53xEuG89
         uEHFpE4Kvvgupf5wvEK4IQeKx7tKt6R6ItBi4ga8TIr8Etb0jhdBqtlZNPgAZA1LCAif
         nlgg==
X-Gm-Message-State: AOAM530g9PjJlDAS5QK1n3LbVtuH6eG56/YLdpZrbYvwb0LbA2vNKRrk
        Q2PQPhbWECJRrP7fQt8kYqXLBbwlD2P9WGbysosS3a37Mw5ddKLWuVSvo58LUjUdZiyA7Oobig9
        5uCfYCquruDYQwIrk4V6lUVrn
X-Received: by 2002:a05:6e02:5a2:b0:2cf:8e6e:a5ab with SMTP id k2-20020a056e0205a200b002cf8e6ea5abmr474785ils.63.1652373280372;
        Thu, 12 May 2022 09:34:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnYLcElP3RubY+gmeBqxhu3mbpK6fQq97iY6aWfy2ptM8oqCoh3b//Ce/oaarAzKkPNvK9Bw==
X-Received: by 2002:a05:6e02:5a2:b0:2cf:8e6e:a5ab with SMTP id k2-20020a056e0205a200b002cf8e6ea5abmr474771ils.63.1652373280155;
        Thu, 12 May 2022 09:34:40 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id x1-20020a029481000000b0032b3a7817b2sm1525119jah.118.2022.05.12.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:34:39 -0700 (PDT)
Date:   Thu, 12 May 2022 12:34:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 06/23] mm/shmem: Handle uffd-wp special pte in page
 fault handler
Message-ID: <Yn03HkVrzSzYkpn8@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014844.14239-1-peterx@redhat.com>
 <d3a0a870-dccf-186c-e079-96b8309721cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3a0a870-dccf-186c-e079-96b8309721cd@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 06:30:59PM +0200, David Hildenbrand wrote:
> > +/*
> > + * This is actually a page-missing access, but with uffd-wp special pte
> > + * installed.  It means this pte was wr-protected before being unmapped.
> > + */
> > +static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
> > +{
> > +	/*
> > +	 * Just in case there're leftover special ptes even after the region
> > +	 * got unregistered - we can simply clear them.  We can also do that
> > +	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
> > +	 * ranges, but it should be more efficient to be done lazily here.
> > +	 */
> > +	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> > +		return pte_marker_clear(vmf);
> 
> What would happen if we do a unregister followed by a register? IMHO we
> should start with a clean uffd-wp slate then. Your comment makes ma
> assume that we could receive stale WP events, which would be wrong?

I'd say it's not wrong, but it's true and actually expected.

Firstly, userfaultfd (by design) always allows false positives (getting
same message multiple times) but no tolerance on false negatives (missing
event, which is data corrupt).

The latter should be obvious.  For the former, the simplest example is when
two threads access the same missing page the same time, two same messages
will be generated.  Same applies to wr-protect faults.  And it'll be
non-trivial (or say, impossible.. IMHO) to avoid those.

In this specific case, it's about when to drop the uffd-wp bits when
unregister.  Two obvious options: (1) during unregister, or (2) lazy.

Here I chose the lazy way because unregister could be slowed down by this,
and that's when program quits.  In short with current approach we quit
fast.  We could have leftovers, but we'll take care of them when needed.

One important thing is leftover ptes should not be the major way uffd-wp
should be used by the normal register -> wr-protect -> unprotect ->
unregister sequence.  Normally the process won't unregister probably until
it quits, so the leftover does no harm to anyone.

Meanwhile, any user who wants to avoid the lazy way can simply do a
whole-round unprotect before unregister.  So we leave more choice for the
user and by default we make sure no syscall will be easily slowed down.

Hope that answers, thanks!

-- 
Peter Xu

