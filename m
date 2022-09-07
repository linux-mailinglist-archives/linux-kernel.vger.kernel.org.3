Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E975B0F10
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIGVYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:24:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC698D33
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:24:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t70so8971850pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sMQZJyXMfoKZiEunfF/Gh6oLQoPXC7E+0fe21wEbc8c=;
        b=EqYHk7oQSe0x9VrpXRLuIb6iuMh9fPfo+qrUmiODFlDWVSUO1J7+YkXR4t6nDvU1AY
         ZIEWHO0UhZEAnwhhoskKKRK7/R4FG/ZYkekEKRzAXNq+1nVPgeuZo3zRmEyAiaegWW3E
         bAq+57J79A5YFp1q6Zm0rG7zAcs59v68FNeKtUx75TJwk8Ka7SLKrvSNBzF0PdNv6gnX
         jxnDfvF8evtNHChlAYQWvD8Ul8IlRA0GqjPwJofpk4+JHLHGoOCplDe1VZgibTpF6Za2
         Kk1PjuxtW9UbsV867AH7BwBDB+jmxNQeyvuax9bCJcJVh2OCoHhwkpyolUPOGIXLmQRj
         V87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sMQZJyXMfoKZiEunfF/Gh6oLQoPXC7E+0fe21wEbc8c=;
        b=tUXgClChwS3jaCDdLSuaIgHPqZVQimxGBMep8y3bRNwRFxcbMj27wsj100MnzyPrva
         OGGwwsexZwwGzRQPsTuy73TMGsUGI6a0WZC2qEX+A3DyoNfo0MTfwMecJaOEesTrT8rw
         zCj9dmMzC/hMcGpQw/GB3QnIsyR3+xesCr7sXmKv7axGc130vtHN355Sg3LrrJFLNg6q
         +vtvH285h63E3XLcFMFC31lWVeMm3cYdOl0KtGYaOzQhY5tz/gU0wAFzBg9ZbtnauWhR
         JBms6H9Hbydw0fCvy69BXeV/chxmQ/z6+Ez3wvmlo2bGj+/bIpKX1V9aVW/tJuN8etDQ
         fz5A==
X-Gm-Message-State: ACgBeo1rD1v7V6w926GX+ZWgq1ABVl7qfMyZHUVyDCKIZ6QHIKethtzY
        Jf0oc3Z0SGRA/7B8lHrF+CHdfCedGvFvMkZNQyM=
X-Google-Smtp-Source: AA6agR6/1FXIRQSKgzUhu4PEPPStby0UGJVvimjKDzJKdUsDC9pMsai0iYwWi/JrzXRSqxb4s+3+B2eXJIVOp/BS4Fg=
X-Received: by 2002:a63:91c7:0:b0:42b:9e30:580f with SMTP id
 l190-20020a6391c7000000b0042b9e30580fmr5008321pge.206.1662585841824; Wed, 07
 Sep 2022 14:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220907180144.555485-1-shy828301@gmail.com> <20220907142246.c7d6f55e1b56fba3e16d974b@linux-foundation.org>
In-Reply-To: <20220907142246.c7d6f55e1b56fba3e16d974b@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Sep 2022 14:23:48 -0700
Message-ID: <CAHbLzkr==CoCP6U+zNhX8_Ug+sG-P7xwyuf_1yCWwKF8XzGj3Q@mail.gmail.com>
Subject: Re: [v2 PATCH 1/2] mm: gup: fix the fast GUP race against THP collapse
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     david@redhat.com, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, aneesh.kumar@linux.ibm.com,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 2:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  7 Sep 2022 11:01:43 -0700 Yang Shi <shy828301@gmail.com> wrote:
>
> > Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> > introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> > sufficient to handle concurrent GUP-fast in all cases, it only handles
> > traditional IPI-based GUP-fast correctly.  On architectures that send
> > an IPI broadcast on TLB flush, it works as expected.  But on the
> > architectures that do not use IPI to broadcast TLB flush, it may have
> > the below race:
> >
> >    CPU A                                          CPU B
> > THP collapse                                     fast GUP
> >                                               gup_pmd_range() <-- see valid pmd
> >                                                   gup_pte_range() <-- work on pte
> > pmdp_collapse_flush() <-- clear pmd and flush
> > __collapse_huge_page_isolate()
> >     check page pinned <-- before GUP bump refcount
> >                                                       pin the page
> >                                                       check PTE <-- no change
> > __collapse_huge_page_copy()
> >     copy data to huge page
> >     ptep_clear()
> > install huge pmd for the huge page
> >                                                       return the stale page
> > discard the stale page
> >
> > The race could be fixed by checking whether PMD is changed or not after
> > taking the page pin in fast GUP, just like what it does for PTE.  If the
> > PMD is changed it means there may be parallel THP collapse, so GUP
> > should back off.
> >
> > Also update the stale comment about serializing against fast GUP in
> > khugepaged.
> >
> > Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
>
> Is this not worth a -stable backport?

Yes, I think it is.
