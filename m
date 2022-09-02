Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC105AB979
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIBUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIBUeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B38E286C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662150843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzVIoDE74/+VAO67vvsLdiWzQ40qTEUZOmIctAhfkOk=;
        b=TcIL50UkR7BmKcPPGMYej3lXf0p+ESWijIkWiDlGSTDAoqhhNCVYrtOXzsZU1SxpE2MJPf
        /jif/Zk/h3JiThRgX35D4QCrZi31+vE4yTtVxcBoJGTAkNq9lvHH+m2ryDqMGvOi/gRZQr
        uEmfuYT4wUAx5+0O8me9o+NexZddtR4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-U_b6EKfmOXiRKzfsvhTX8A-1; Fri, 02 Sep 2022 16:34:02 -0400
X-MC-Unique: U_b6EKfmOXiRKzfsvhTX8A-1
Received: by mail-qt1-f198.google.com with SMTP id e30-20020ac8011e000000b00342f61e67aeso2386966qtg.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bzVIoDE74/+VAO67vvsLdiWzQ40qTEUZOmIctAhfkOk=;
        b=8CUax2hwpxzECC5BVcwLfFxid3eyuzhD7Wmqq7TSPu4hRe1t2h0o5669N2p+njqUyX
         lFKyhew5ELlOYNRcr4knKORQWYnPvM0DInxOSEtftvt6c3hCCaIIFQOZiQb0ci/FdEk3
         oSiMjZYIVjOw/o/qLZARjKdPVG2kYVXywgtTQT2LPT91n1k79WalwI8Sr9i19LKJC0ZH
         YbYOj7Jnx0WUEQIemEDrO2RkYbwtnvKnkmamD0j8A/K+7HN79ZiMt4TABhBzsSGZBvpO
         m+zNNSP1x2GGd5PZCX75KZumc7+gAN4Okqw4rYVZ1rx/LkmP+2e5I4C4erG7KQJkpnnq
         5dAg==
X-Gm-Message-State: ACgBeo1HEBDwgKQ4CNFmGCKLHkCSNW38fPSm21j5AnvTanHu/P5kXwS7
        QWuH8ePu80iKvrX1JpwMThkywM/Ytyn5YtGtXX7UxcZ5ZlDPzBg+r3StFN2dWsJw9JlAsgtOPd0
        PziAag3FP6z749OTvs1D+/7S/
X-Received: by 2002:a05:6214:f21:b0:498:fada:9416 with SMTP id iw1-20020a0562140f2100b00498fada9416mr27426238qvb.84.1662150841653;
        Fri, 02 Sep 2022 13:34:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR66IV/RH+gSIrgn9dSAl9c65XLtxRKXEx/Lv53pYBTVoUka8qJRbitW0RQzp8Z/YjcuFDziUA==
X-Received: by 2002:a05:6214:f21:b0:498:fada:9416 with SMTP id iw1-20020a0562140f2100b00498fada9416mr27426220qvb.84.1662150841464;
        Fri, 02 Sep 2022 13:34:01 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id f22-20020ac87f16000000b0034456277e3asm1664849qtk.89.2022.09.02.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:34:00 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:33:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Message-ID: <YxJot6JbFl0HnXq3@xz-m1.local>
References: <20220901222707.477402-1-shy828301@gmail.com>
 <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
 <YxIofPiI8jvGzcjC@xz-m1.local>
 <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:45:20AM -0700, Yang Shi wrote:
> > How about another patch to remove the ppc impl too?  Then it can be a two
> > patches series.
> 
> BTW, I don't think we could remove the ppc implementation since it is
> different from the generic pmdp_collapse_flush(), particularly for the
> hash part IIUC.
> 
> The generic version calls flush_tlb_range() -> hash__flush_tlb_range()
> for hash, but the hash call is actually no-op. The ppc version calls
> hash__pmdp_collapse_flush() -> flush_tlb_pmd_range(), which does
> something useful.

One thing I found interesting (and also a bit confused..) is that the ppc
code used the name flush_tlb_pmd_range() to "flush tlb range in pte level",
which is kind of against the tlb API design..

The generic tlb API has a very close function called flush_pmd_tlb_range()
which is only used to do pmd-level flushing, while here the ppc version of
flush_tlb_pmd_range() is actually flush_tlb_range() in the generic API.

Agreed that it may worth having a look from ppc developers.

-- 
Peter Xu

