Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6901C55D825
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiF0R4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiF0R4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAF0DD130
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656352575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mg0Natnz3fvAeghSvOE7uGBbb8dCDKfIOYVJA1IZdI=;
        b=Zb0yvIIiR1MYdKc+CI1hAaKGqdoF6EFUZtiMBbbjOIwRfl/Tg5dmqiK5J+Vh3XO8WMjoTB
        9mRIkXi06Svl5pJ2ZAyCl6kKCeFRUg+I03tgIuDndf/aFZyjOx3bZJwDXmkm9u7g5gl4/k
        z1ck+U8BUt5+Nd/OQIbdhAy3s8TSBRs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-cwrii3WkNGO6XUs5CzURUQ-1; Mon, 27 Jun 2022 13:56:14 -0400
X-MC-Unique: cwrii3WkNGO6XUs5CzURUQ-1
Received: by mail-wm1-f69.google.com with SMTP id r186-20020a1c44c3000000b003a02fa133ceso3874252wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7mg0Natnz3fvAeghSvOE7uGBbb8dCDKfIOYVJA1IZdI=;
        b=prtKnGiZCQDGaZxYjrnuclLx2Vn4+i4efP3Xhgefd0PU9aPQKfMAhC17px3/1pzmTc
         XBc9YG00fVBBQuHZiMvHYPH4O6LLSrqpfAV9XBh8ddhYHPFFMwl8Dhdv249t+DCg7qAo
         QBfLxjBBOtjA3s962HGvnX5+X1iL2TuRvgsqdpbV5fSAYjddr+acySv44gzcHA0s77yn
         bQpLoj6iqN1/V56woTGEwF9E9oDbGPBRTeDjMiZDRFNMr5QuAbdakdX28dyvPa0agYKQ
         F0HAH4TYJ6cRi0Zo7AA9i4qgdUKYCvlIz2O7RvTWvfvBy5qXSMTMlujkTrWLm6DL41c4
         GwVg==
X-Gm-Message-State: AJIora9MuvkMvoIHNvKTHrpZk2eE1tzPw3FZ4uawm6dcp3N4ttXLhpyY
        TXvYDZIertdQMaqDup5qnDTFWhE4Yx16naQyUgHxfq7HBhaRjps3OJwVjSfbhi13GmVifKzuVxH
        pIdiE+j7uV2wHsGo8rTpf+uZG
X-Received: by 2002:a7b:ce06:0:b0:3a0:39e0:b322 with SMTP id m6-20020a7bce06000000b003a039e0b322mr22328475wmc.55.1656352573195;
        Mon, 27 Jun 2022 10:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9Y7H5IcsM3l7PZbohhBaSs2zzWjrBXo14Wtwusb5syFFsweFwhx/NmH5jUhL61mdYxQz8JA==
X-Received: by 2002:a7b:ce06:0:b0:3a0:39e0:b322 with SMTP id m6-20020a7bce06000000b003a039e0b322mr22328450wmc.55.1656352572958;
        Mon, 27 Jun 2022 10:56:12 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b0021018642ff8sm11776063wrm.76.2022.06.27.10.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:56:12 -0700 (PDT)
Date:   Mon, 27 Jun 2022 18:56:09 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <YrnvORvPKbzgxLCu@work-vm>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <YrYCeYy0rjfGhT/W@casper.infradead.org>
 <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
User-Agent: Mutt/2.2.5 (2022-05-16)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* James Houghton (jthoughton@google.com) wrote:
> On Fri, Jun 24, 2022 at 11:29 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jun 24, 2022 at 05:36:30PM +0000, James Houghton wrote:
> > > [1] This used to be called HugeTLB double mapping, a bad and confusing
> > >     name. "High-granularity mapping" is not a great name either. I am open
> > >     to better names.
> >
> > Oh good, I was grinding my teeth every time I read it ;-)
> >
> > How does "Fine granularity" work for you?
> > "sub-page mapping" might work too.
> 
> "Granularity", as I've come to realize, is hard to say, so I think I
> prefer sub-page mapping. :) So to recap the suggestions I have so far:
> 
> 1. Sub-page mapping
> 2. Granular mapping
> 3. Flexible mapping
> 
> I'll pick one of these (or maybe some other one that works better) for
> the next version of this series.

<shrug> Just a name; SPM might work (although may confuse those
architectures which had subprotection for normal pages), and at least
we can mispronounce it.

In 14/26 your commit message says:

  1. Faults can be passed to handle_userfault. (Userspace will want to
     use UFFD_FEATURE_REAL_ADDRESS to get the real address to know which
     region they should be call UFFDIO_CONTINUE on later.)

can you explain what that new UFFD_FEATURE does?

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

