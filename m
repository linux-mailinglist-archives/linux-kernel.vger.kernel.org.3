Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3BD501DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbiDNWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243294AbiDNWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:03:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81825986CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:01:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso4330674otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6v2JIcnO74S/p5+dirBbOGSaV+ed6VcSDjiH/u/D+aI=;
        b=ZdWf8c6V/Syu7A3HkxAQFa/Bgv5Qbwbrt6vdDRNRWkJL7ZPkFVcoSkpQJimgIKwt6U
         t2vvPcGYn/9DRRPbcaL2Vgs95NE0398gIwKWVAYgCxSpJI2P5SNXSSRkkVIBcboR4K4Q
         iebdiKEDddEtKCnig7/Z8+KzV3Gj5Fw+aNSrQRMtiE1y44jXguho42vmfGGIUG00yh6d
         8B8RHtzrr67BQdc+NhEkxjRQXaV7AU1jQHDo2GJ+JgWj5A8DSmA86BkekOhfjEwVFYxo
         zGhjCFVKatUioNh1i1RFgSmc5T9dYVgKKri87aCOHsYwS5Y+n5aal79M0w/h+JDBOSKL
         2mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6v2JIcnO74S/p5+dirBbOGSaV+ed6VcSDjiH/u/D+aI=;
        b=OhaHQ7n/KyNEHLIBzfRrgLld/mdCEz6vvBxB/68Sqj1JDyGxYk/jRW/WDxxCQKlm9l
         P/oesSxwEYQQLnw6V+d3ql/JgrFoqrWvukgoGUcEXHaAaqZ1O9F7ioQPeDP/7a+vY1z2
         vzA8Q4/8eeqeoYyUWN2wNrU7lzZRL5nx2n1JIQXa3pTkWsVPPg260pEzTiawKNf1QZLd
         +p8Lgmc2nDxnYPQ8CX13hQE6qogggxN+vmPcONFiQVwOvAAeZbJOZOX/lwt9Hi27g+px
         b911GT+pvbxixfpvFQl2gfI12Dd/OAoaKE2dMb9o1tfh1q8NJJf8WEC5Kw2HUQT5I1f/
         gQ1A==
X-Gm-Message-State: AOAM5330zA/cLWCpY+mt0ZCFw50OTcN0fekiNFiAX/2GvOkPkUw1+38M
        NtW8C6rcc9GfQLUNVDHZRX2dgdp8Sr28rB3PY+mgCQ==
X-Google-Smtp-Source: ABdhPJyqrcwqArrcLRNNcSEbE2YukhZ6PQK+xbbqWzkAXEL9KKXaFiylu5SQb94jq2n8a+UclADYeWviMm/r3bgy7Zs=
X-Received: by 2002:a05:6830:240f:b0:5ce:60e8:294a with SMTP id
 j15-20020a056830240f00b005ce60e8294amr1638687ots.14.1649973675627; Thu, 14
 Apr 2022 15:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220414010703.72683-1-peterx@redhat.com> <Ylgn/Jw+FMIFqqc0@google.com>
 <bf15209d-2c50-9957-af24-c4f428f213b1@redhat.com> <YliTdb1LjfJoIcFc@xz-m1.local>
In-Reply-To: <YliTdb1LjfJoIcFc@xz-m1.local>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 14 Apr 2022 15:01:04 -0700
Message-ID: <CALMp9eRjNd5_VFOsAoANkoaCTkKSHp3awrABZ5LR20+VoXZuAA@mail.gmail.com>
Subject: Re: [PATCH] kvm: selftests: Fix cut-off of addr_gva2gpa lookup
To:     Peter Xu <peterx@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 2:36 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Apr 14, 2022 at 04:14:22PM +0200, Paolo Bonzini wrote:
> > On 4/14/22 15:56, Sean Christopherson wrote:
> > > > - return (pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
> > > > + return ((vm_paddr_t)pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
> > > This is but one of many paths that can get burned by pfn being 40 bits.  The
> > > most backport friendly fix is probably to add a pfn=>gpa helper and use that to
> > > place the myriad "pfn * vm->page_size" instances.
> > >
> > > For a true long term solution, my vote is to do away with the bit field struct
> > > and use #define'd masks and whatnot.
> >
> > Yes, bitfields larger than 32 bits are a mess.
>
> It's very interesting to know this..

I don't think the undefined behavior is restricted to extended
bit-fields. Even for regular bit-fields, the C99 spec says, "A
bit-field shall have a type that is a qualified or unqualified version
of _Bool, signed
int, unsigned int, or some other implementation-defined type." One
might assume that even the permissive final clause refers to
fundamental language types, but I suppose "n-bit integer" meets the
strict definition of a "type,"
for arbitrary values of n.
