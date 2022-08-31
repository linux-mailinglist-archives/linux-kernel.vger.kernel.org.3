Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FE85A8615
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiHaSw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHaSwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7016C0E5D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661971973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rMGNs2YUPmBpJtRzjX0jo2J/6RpATG/lLCVwNu3BD9E=;
        b=WzejkKiESLOMJrcqDBFAZLLakPopFL4XBbPHDKjEqcblEs5tEq8ITkPyoinxTlOt7FI2Ye
        6Fpbdb5ZAC0QegSb9s6/eDH+ErUo7iSFyw5sfFGo8CEWwFsPmBESBC5sZB1ghqHKTOVxyR
        Ka3m16Ek4NajYSvG3fBa9bQzaJKGf5E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-lOg0AO_3MH-BuwnYYP-3Vw-1; Wed, 31 Aug 2022 14:52:52 -0400
X-MC-Unique: lOg0AO_3MH-BuwnYYP-3Vw-1
Received: by mail-qt1-f197.google.com with SMTP id v13-20020a05622a188d00b00343794bd1daso12023254qtc.23
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rMGNs2YUPmBpJtRzjX0jo2J/6RpATG/lLCVwNu3BD9E=;
        b=pAg1IkSghNbAHqRzDy7afv/vFiDlzw0tc13iYCSibRrmLr8QEjMjFornJszkeuIZLe
         lm/pCGFCakFbtO4EwrHImMSomTr7mpjeMUdDdm6YpW5aHNqQAsgO7Wd4zTI1c/bLr943
         iq2UEdwoEzdh/EpbTiDKV9rLhRsBsnpVpQfrPrzAZkS8jtMA7N6qySzUgkF3wzvkHjAM
         0+sYf5Ow8Y36n0rpxSawlb11J+potg1UHlXK5RmHCx3c4eYVTSa8283o0ss4/4TAb7Gd
         /idQDS9PZakDtMDp9IqJcEQkGUTlq3Rl4hX+E4+veZo3qa4Iy96ZGD/tqHfsE1hyw02m
         VZBQ==
X-Gm-Message-State: ACgBeo2ehXu7VWMqnHe39DxKiLhTFTx2fWaV1l17OcB+fd/Br12sZ3UF
        D3/oulivdgaUIZY1s6dhNjf6lB3VMlUtqoKRp4/KQRiKrQ9+Xl36QCAyyJ6x0r6Cfp26t6KAXA1
        euwMMbt+BRvU7u43g6ba7I0f9
X-Received: by 2002:ac8:4e8b:0:b0:344:adaa:4fa8 with SMTP id 11-20020ac84e8b000000b00344adaa4fa8mr20523910qtp.559.1661971972122;
        Wed, 31 Aug 2022 11:52:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6u6wthlC6RtruUhaUvCG/dkpgkAwvjQIxQOs6+sy6G2IJ3PdVaD/l27aq+oFT60W/b+J4WNw==
X-Received: by 2002:ac8:4e8b:0:b0:344:adaa:4fa8 with SMTP id 11-20020ac84e8b000000b00344adaa4fa8mr20523890qtp.559.1661971971882;
        Wed, 31 Aug 2022 11:52:51 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id d5-20020ac86685000000b00342f7beccd0sm8823057qtp.45.2022.08.31.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:52:51 -0700 (PDT)
Date:   Wed, 31 Aug 2022 14:52:49 -0400
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
Message-ID: <Yw+uASvgWU5+9PvI@xz-m1.local>
References: <20220831083024.37138-1-david@redhat.com>
 <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:55:43AM -0700, Yang Shi wrote:
> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > The comment is stale, because a TLB flush is no longer sufficient and
> > required to synchronize against concurrent GUP-fast. This used to be true
> > in the past, whereby a TLB flush would have implied an IPI on architectures
> > that support GUP-fast, resulting in GUP-fast that disables local interrupts
> > from completing before completing the flush.
> 
> Hmm... it seems there might be problem for THP collapse IIUC. THP
> collapse clears and flushes pmd before doing anything on pte and
> relies on interrupt disable of fast GUP to serialize against fast GUP.
> But if TLB flush is no longer sufficient, then we may run into the
> below race IIUC:
> 
>          CPU A                                                CPU B
> THP collapse                                             fast GUP
> 
> gup_pmd_range() <-- see valid pmd
> 
> gup_pte_range() <-- work on pte
> clear pmd and flush TLB
> __collapse_huge_page_isolate()
>     isolate page <-- before GUP bump refcount
> 
>    pin the page
> __collapse_huge_page_copy()
>     copy data to huge page
>     clear pte (don't flush TLB)
> Install huge pmd for huge page
> 
> return the obsolete page

Maybe the pmd level tlb flush is still needed, but on pte level it's
optional (where we can rely on fast-gup rechecking on the pte change)?

-- 
Peter Xu

