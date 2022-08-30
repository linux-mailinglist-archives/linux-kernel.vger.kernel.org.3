Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D05A66FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiH3PL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiH3PLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28E7A52F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661872281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Uj1KSGVvpg1e2uy6Lmq+BilnZLZf+fvAkkGZhgZ/JI=;
        b=PrtntdDA40DHFnBfitRJ9AUBYLMyJO/2eTj7cCG1/1HdlMXzvOSF9AftZsYePw+Um5x5lQ
        LlT9fgetvct0vkWYqDZiWQzkpaSLwD2+iETIGnepgkax+mQIfcd0zchEa35STzLhHUuaGL
        YGlTiKd8974zid1C4R8TvoXX3FAbWvg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-lbs1wQghP6ODrvOlIQ0NMA-1; Tue, 30 Aug 2022 11:11:19 -0400
X-MC-Unique: lbs1wQghP6ODrvOlIQ0NMA-1
Received: by mail-oo1-f72.google.com with SMTP id z15-20020a4a304f000000b0044b0ae69807so5250562ooz.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=9Uj1KSGVvpg1e2uy6Lmq+BilnZLZf+fvAkkGZhgZ/JI=;
        b=mZseJi0cD5XF8Fsoj/UKR96ez1VqlyGdRUWWgP5+qmDqcbYddUXef4L78la74mc/ZW
         jAGtNGLENTDr39x912WtN1vaY0nRJZT4SYDJ8R7/p6QTHfoEHjCS8rr5SughkhzDKvAv
         U7Mpkj/12rJck5s3npXEPs5LG41q72yHuwKnQ01/F8SE2feL68mfOH9PKvT0F0Vu+7D+
         ttrGl4d18u/B8lcMCxIUvUYtgvm0TlQN8yO8EOPEEgqXEh69JSPlFlK00QiKyPlzCXgD
         eMo5jc+1GelIs8gFPaaZslxoczYe1q62PEbhvgd5uLK+RGtEnXY2xuEjyRoVOcG4yMmm
         NtwA==
X-Gm-Message-State: ACgBeo2fPVlX1Q2NggfY4RyXhFwCDFlVQmE+DQU27zlR82/wtJp5jjWU
        dtOiLnIin/MAxnJy2kUK8ZcxLoHPmhic6DKTkkf26GoMI+vcijY8m2hq9+KWYF/ImBkWKVj9sRP
        5fNt6d4tt7Gd0INZcPKJAF1iC
X-Received: by 2002:a05:6830:1e64:b0:63b:25dd:ed07 with SMTP id m4-20020a0568301e6400b0063b25dded07mr5689836otr.159.1661872278756;
        Tue, 30 Aug 2022 08:11:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7imdzhCAin1zc5CWFAJrLO27P5NJLOlKojo5DBQINDuHfcvZzdAo7eVrmJH+TF0TXpUXCpRg==
X-Received: by 2002:a05:6830:1e64:b0:63b:25dd:ed07 with SMTP id m4-20020a0568301e6400b0063b25dded07mr5689827otr.159.1661872278524;
        Tue, 30 Aug 2022 08:11:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e5-20020aca1305000000b00344e3751fc4sm6192535oii.36.2022.08.30.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:11:18 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:11:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpivarc@redhat.com
Subject: Re: [PATCH] vfio/type1: Unpin zero pages
Message-ID: <20220830091110.3f6d1737.alex.williamson@redhat.com>
In-Reply-To: <39145649-c378-d027-8856-81b4f09050fc@redhat.com>
References: <166182871735.3518559.8884121293045337358.stgit@omen>
        <39145649-c378-d027-8856-81b4f09050fc@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 09:59:33 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 30.08.22 05:05, Alex Williamson wrote:
> > There's currently a reference count leak on the zero page.  We increment
> > the reference via pin_user_pages_remote(), but the page is later handled
> > as an invalid/reserved page, therefore it's not accounted against the
> > user and not unpinned by our put_pfn().
> > 
> > Introducing special zero page handling in put_pfn() would resolve the
> > leak, but without accounting of the zero page, a single user could
> > still create enough mappings to generate a reference count overflow.
> > 
> > The zero page is always resident, so for our purposes there's no reason
> > to keep it pinned.  Therefore, add a loop to walk pages returned from
> > pin_user_pages_remote() and unpin any zero pages.
> > 
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: stable@vger.kernel.org
> > Reported-by: Luboslav Pivarc <lpivarc@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index db516c90a977..8706482665d1 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -558,6 +558,18 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> >  	ret = pin_user_pages_remote(mm, vaddr, npages, flags | FOLL_LONGTERM,
> >  				    pages, NULL, NULL);
> >  	if (ret > 0) {
> > +		int i;
> > +
> > +		/*
> > +		 * The zero page is always resident, we don't need to pin it
> > +		 * and it falls into our invalid/reserved test so we don't
> > +		 * unpin in put_pfn().  Unpin all zero pages in the batch here.
> > +		 */
> > +		for (i = 0 ; i < ret; i++) {
> > +			if (unlikely(is_zero_pfn(page_to_pfn(pages[i]))))
> > +				unpin_user_page(pages[i]);
> > +		}
> > +
> >  		*pfn = page_to_pfn(pages[0]);
> >  		goto done;
> >  	}
> > 
> >   
> 
> As discussed offline, for the shared zeropage (that's not even
> refcounted when mapped into a process), this makes perfect sense to me.
> 
> Good question raised by Sean if ZONE_DEVICE pages might similarly be
> problematic. But for them, we cannot simply always unpin here.

What sort of VM mapping would give me ZONE_DEVICE pages?  Thanks,

Alex

