Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B4F57D219
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiGUQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiGUQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A909E89A9B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658422641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYkkBe6l4cX/NT5fsK6oNEqOI7IEBj6r0KNIEZJp5rs=;
        b=KTPZZab8Q6JChzn7OgUrBoYADo8OGqiLHc9dCiF0di+qAYn9CVn3w2fvyfAJFAm7AsehAN
        DkE3b9f0VJjDS0yGq7A7r1LGgNf+bofaZDzP6zOtEes3PHJIkWdB5ggYWmuZsXT9btcYsL
        J1aoMM56T/jIKC7C4v29jiqhUOoggrc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-lwwnccWANRCQ__-PUbLS6A-1; Thu, 21 Jul 2022 12:57:18 -0400
X-MC-Unique: lwwnccWANRCQ__-PUbLS6A-1
Received: by mail-qv1-f72.google.com with SMTP id ne15-20020a056214424f00b004737e7bcfa6so1397990qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYkkBe6l4cX/NT5fsK6oNEqOI7IEBj6r0KNIEZJp5rs=;
        b=fLDpF4n8D6qkEns1/s07uYdR96xiQge5Ig6KZqoULlTcY53DPXYgQz9KY6bz3JApRk
         k7Xl2GO6rUY6YMsLssp2tv20ulN4U2oGWq9g/AKeehOHeXFQlCy+8VFqfA8kDlOLZ6uE
         Wi9Kc2v6ACvuQcBDNEUccdEXjRq1iXa7nAapcSvdH7Asfe4w3JKm3lVoMXYpDNp54jYQ
         qltJ0wN8g7szv1k0H4BP1VTH8EWINswtApEFUrF44sUYodRMFgQuUzYHixhXZEl5+4ce
         ueo+c9HD6ThMFa6E/Swf+DPAxpMlyvLN5bWtiN8Idh4WnpuI8ALIipZHM1zyVsXpgkjm
         FRNQ==
X-Gm-Message-State: AJIora+NhuNNZGua52i7Q5B42RrsQokNg+wIrEV1cu/4AnsKivfVUb2P
        s+HHgJq6jN3FdB1p6wckjny80oHxHGBEDxUOm9EawZsMOX9hJYc/1HOFMBeBu03KP0g/3HCtvtV
        IYn+eiBYZu4a0aaX8fIw0T241
X-Received: by 2002:a05:6214:519a:b0:473:6d83:17e9 with SMTP id kl26-20020a056214519a00b004736d8317e9mr33980093qvb.115.1658422637679;
        Thu, 21 Jul 2022 09:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tKfr/Iqt4xNR2rSwhG38OkcKQpC8U78lMeM2rzT2mJddVbR2NygckqZ5bcu3ovsLkOvv11/g==
X-Received: by 2002:a05:6214:519a:b0:473:6d83:17e9 with SMTP id kl26-20020a056214519a00b004736d8317e9mr33980061qvb.115.1658422637327;
        Thu, 21 Jul 2022 09:57:17 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bn31-20020a05620a2adf00b006b5ef0aff29sm1631388qkb.87.2022.07.21.09.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:57:16 -0700 (PDT)
Date:   Thu, 21 Jul 2022 12:57:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <YtmFa+BdYkY3SSVP@xz-m1.local>
References: <20220720220324.88538-1-peterx@redhat.com>
 <f0d193c2-9b23-6f3a-9208-2a615febe0c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0d193c2-9b23-6f3a-9208-2a615febe0c2@redhat.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 09:28:47AM +0200, David Hildenbrand wrote:
> Modifying your test to map page from a file MAP_SHARED gives me under
> 5.18.11-100.fc35.x86_64:
> 
> 
> 53,54d52
> <       FILE *file = fopen("tmpfile", "w+");
> <       int file_fd;
> 56d53
> <       assert(file);
> 59,61d55
> <
> <       file_fd = fileno(file);
> <       ftruncate(file_fd, psize);
> 63c57
> <                   MAP_SHARED, file_fd, 0);
> ---
> >                   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> 
> 
> t480s: ~  $ sudo ./tmp
> ERROR: Wrote page again, soft-dirty=0 (expect: 1
> 
> 
> 
> IMHO, while the check in vma_wants_writenotify() is correct and makes
> sure that the pages are kept R/O by the generic machinery. We get
> vma_wants_writenotify(), so we activate MM_CP_TRY_CHANGE_WRITABLE. The
> wrong logic in can_change_pte_writable(), however, maps the page
> writable again without caring about softdirty.
> 
> At least that would be my explanation for the failure. But maybe I
> messes up something else :)

Correct, I missed that part.  I verified that the same test also fails for
me easily on a xfs file test of an old kernel.

Let me touch up the commit message for that.   Though I think I'll still
keep the Fixes since the patch won't apply to before the commit, but I'll
mention that's only for tracking purpose.

[...]

> Can we turn that into a vm selftest in
> tools/testing/selftests/vm/soft-dirty.c, and also extend it by
> MAP_SHARED froma  file as above?

Sure.  I'll post a v3 with that.

[...]

> > @@ -48,8 +48,11 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
> >  	if (pte_protnone(pte) || !pte_dirty(pte))
> >  		return false;
> >  
> > -	/* Do we need write faults for softdirty tracking? */
> > -	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
> > +	/*
> > +	 * Do we need write faults for softdirty tracking?  Note,
> > +	 * soft-dirty is enabled when !VM_SOFTDIRTY.
> > +	 */
> > +	if (!(vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
> >  		return false;
> 
> I wonder if we now want, just as in vma_wants_writenotify(), an early
> check for IS_ENABLED(CONFIG_MEM_SOFT_DIRTY), to optimize this out
> completely.

Hmm, it may not even be an optimization issue, since when
!CONFIG_MEM_SOFT_DIRTY we have VM_SOFTDIRTY defined as 0x0.

It means !(vma->vm_flags & VM_SOFTDIRTY) will be constantly true even if
soft dirty not compiled in.

I'll add that check too.  Thanks,

-- 
Peter Xu

