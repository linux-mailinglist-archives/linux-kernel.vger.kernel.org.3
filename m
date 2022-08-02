Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0905C588328
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiHBUfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiHBUfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4DD413E92
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659472538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p3U/5BApyUmmUvsft8lwvJPhjHAwYqDE5trVI8sMuPI=;
        b=TEAvSPrxeOde0HM/LhQ4ubRIE4WR6yb8ecHLsVMGI1ZX3LFstOlmGcpIZW/HstVL6CZqqB
        iW1k8DOjRV6sVICik5+8IfzdBaGzDqd6N/t7VQUGpuBwQJ/EJVpI8OplIQNoZp0Jy74gLP
        JSA8o2+oGTYTpwKqtwfDM0XhnGqeNRA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-64L62DzxPr-cXBjQuOYgtQ-1; Tue, 02 Aug 2022 16:35:37 -0400
X-MC-Unique: 64L62DzxPr-cXBjQuOYgtQ-1
Received: by mail-qt1-f200.google.com with SMTP id v6-20020ac87486000000b0031ee0ae1400so9746405qtq.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3U/5BApyUmmUvsft8lwvJPhjHAwYqDE5trVI8sMuPI=;
        b=QTeIoxtuleUkcKaP+LjmBY7zPAhU7P4aKuwCGwiG6FLuLjY+hFeY4+IU/vq5ZGHooG
         SMk87mtgDKFXQ2zGyC6Qxd3xV7G7eD1V/MF/XkYfGZLrAjubpb1ix1MG5qnRTRXWT8io
         Hlac1yZR65R1zb+5vJ1RE2QgLsOcbemvX9V9gD8LIEIeEfEiQuq6j4p5n33VFGI/PJKd
         uiWZ2MSD9Y/9QFcXBnQV9YWrFz+Yi39XsRvZynmL81FWpHHny01k+Eeudw+M096xvVfD
         C7F5DQbUik9MZPqDUbDbpNzwWa157WFVYCK7vJJDYV/uNMKaaeSNOqg69RHKTl5SChhu
         Y42g==
X-Gm-Message-State: AJIora/LL55h9AcdBlXFvAXV3SSndhNfmorqpSvhCKqwyZCWVG4IIycx
        ZSHhy3gEuD5144qxRP+RWRJNFTm7Gsrdru6k6u0G2kdJQTKyy3w+UPHwe51s3sld5VepQjfCdzy
        15nDZAQZfXKYXCoN6J2i8i6Lk
X-Received: by 2002:a05:622a:1791:b0:31e:f628:f4b4 with SMTP id s17-20020a05622a179100b0031ef628f4b4mr19636419qtk.217.1659472536417;
        Tue, 02 Aug 2022 13:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1voIR8oG53y0v8V5Ahmi4x98Er+qjWvc3N02EkxNLibhCfZqH4PPMi5/CcPR9k3KbXjjOjecA==
X-Received: by 2002:a05:622a:1791:b0:31e:f628:f4b4 with SMTP id s17-20020a05622a179100b0031ef628f4b4mr19636401qtk.217.1659472536195;
        Tue, 02 Aug 2022 13:35:36 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a0bc600b006b5f68bc106sm11130072qki.110.2022.08.02.13.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:35:35 -0700 (PDT)
Date:   Tue, 2 Aug 2022 16:35:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
Message-ID: <YumKlqjv8PaafpER@xz-m1.local>
References: <20220729014041.21292-1-peterx@redhat.com>
 <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
 <YuhVJmSsgs4Q1bYJ@xz-m1.local>
 <49434bea-3862-1052-2993-8ccad985708b@redhat.com>
 <YumFs0jpCc/Mwjzf@xz-m1.local>
 <24ffea6e-ca66-2b94-c682-48a42a655fd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24ffea6e-ca66-2b94-c682-48a42a655fd1@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:23:49PM +0200, David Hildenbrand wrote:
> > I don't think we only care about x86_64?  Should other archs have the same
> > issue as long as there's the hardware young bit?
> > 
> > Even without it, it'll affect page reclaim logic too, and that's also not
> > x86 only.
> 
> Okay, reading the cover letter and looking at the code my understanding
> was that x86-64 is the real focus.
> 
> >>
> >>>
> >>> Besides I actually have a question on the anon exclusive bit in the swap
> >>> pte: since we have that anyway, why we need a specific migration type for
> >>> anon exclusive pages?  Can it be simply read migration entries with anon
> >>> exclusive bit set?
> >>
> >> Not before all arch support pte_swp_mkexclusive/pte_swp_exclusive/.
> >>
> >> As pte_swp_mkexclusive/pte_swp_exclusive/ only applies to actual swap
> >> PTEs, you could even reuse that bit for migration entries and get at
> >> alteast the most relevant 64bit architectures supported easily.
> > 
> > Yes, but I think having two mechanisms for the single problem can confuse
> > people.
> > 
> 
> It would be one bit with two different meanings depending on the swp type.
> 
> > IIUC the swap bit is already defined in major archs anyway, and since anon
> > exclusive bit is best-effort (or am I wrong?..), I won't worry too much on
> 
> It kind-of is best effort, but the goal is to have all archs support it.
> 
> ... just like the young bit here?

Exactly, so I'm also wondering whether we can move the swp pte anon
exclusive bit into swp entry.  It just sounds weird to have them defined in
two ways.

> 
> > archs outside x86/arm/ppc/s390 on having anon exclusive bit lost during
> > migrations, because afaict the whole swap type of ANON_EXCLUSIVE_READ is
> > only servicing that very minority.. which seems to be a pity to waste the
> 
> I have a big item on my todo list to support all, but I have different
> priorities right now.
> 
> If there is no free bit, simply steal one from the offset ... which is
> the same thing your approach would do, just in a different way, no?
> 
> > swp type on all archs even if the archs defined swp pte bits just for anon
> > exclusive.
> 
> Why do we care? We walk about one type not one bit.

The swap type address space is still limited, I'd say we should save when
possible.  I believe people caring about swapping care about the limit of
swap devices too.  If the offset can keep it, I think it's better than the
swap type.  De-dup either the type or the swap pte bit would be nicer, imho.

-- 
Peter Xu

