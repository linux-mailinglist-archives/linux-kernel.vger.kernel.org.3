Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66A8510A99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355052AbiDZUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355030AbiDZUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:37:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915431A8C22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:34:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 17so35401lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aU1nfmW7ZgdT9Qa1tRExDdIJcvLzr/71e6MMUKD+f14=;
        b=L+04/VSvu1o2iLCXuaCNLPQgteB9nxjsaUItY80e35KA07eJCca0YXvYS8yXsehgAp
         gJwV1fDjZTTu27Nk2EVmh0GDdfERG/5DXk0qeuBgd2nFP0RDyeiTP1b0WfMuEAvcfEHQ
         tNSJqHRlQoAbQ+NR67QcpnTTT87zUPLTpmtpq5HgLEtmx0wlgRbbTaHwoTamu+Pq5W4W
         D27sEwR9kh+F0dh9lSZY4JSbb48iY4yOWiVIi/NMXsJh73r5t6XBQDJqfwbqLXCJk0Df
         uO9Z362RUBuDni5ds34LO1tG4fWsrgPKCw55j+7XUDm1gmZr9P4WjsNLa10eqM/3ZJwp
         vn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU1nfmW7ZgdT9Qa1tRExDdIJcvLzr/71e6MMUKD+f14=;
        b=8A1QsZJdp6V26RL+RKi2ZGzcI0VDobVMLzYjbJVnwPyPeA6JdGVu3cLQ6Twq5fd0RZ
         BBjjyPVv3S1sDgHaJdi85KRxeYxA6sLdmAnpNAB/9aLvLhEPZF6+LfGF07DjwZY9/R5x
         tg++sQhbRrLnxtu0zYs5WsaMZWfDnGOrP3nOxY0WyCHYXgeBixiAaI2BC/IgV6nd3y5w
         syp20DDo27MRX0eKtO2xQ3bOXOxYqXECCH4a46SL5t6sexo87ZcLopA8h95VI8cXo+bY
         nehqev33NLAu8rt8KR+1GuZsYEj6PAd1g5jHzZ1PPGS7HnvpxDtnyR+Vwuqm3o1sTID8
         JtHQ==
X-Gm-Message-State: AOAM532lskWcggTGkhG72jcbo7VtU+Q2xmURwesSc5YBoXu9RZ0+HIvj
        cxkyynI8f48xZbvTMCQlUeb6GV7LFerKJZ0KwKfOdA==
X-Google-Smtp-Source: ABdhPJx5KH4AYYyWahlSyUhGXyJBSiXHd1WrZoegFj2ZOcMkv0OyCYrGoJDFZHDu/w6tvACgKascP5gl/cHc/KfjvDQ=
X-Received: by 2002:a2e:97c7:0:b0:24f:5a7:f398 with SMTP id
 m7-20020a2e97c7000000b0024f05a7f398mr11417653ljj.231.1651005239369; Tue, 26
 Apr 2022 13:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220325233125.413634-1-vipinsh@google.com> <CALzav=e6W2VSp=btmqTpQJ=3bH+Bw3D8sLApkTTvMMKAnw_LAw@mail.gmail.com>
 <CAHVum0dOfJ5HuscNq0tA6BnUJK34v4CPCTkD4piHc7FObZOsng@mail.gmail.com>
 <b754fa0a-4f9e-1ea5-6c77-f2410b7f8456@redhat.com> <CAHVum0d=WoqxZ4vUYY37jeQL1yLdiwbYjPSPFAa1meM5LUBDQQ@mail.gmail.com>
 <CAHVum0eF=CmqXabrJS7rsVxhQLKA7v8iG1SjThcEJ=_zAUhRsg@mail.gmail.com>
In-Reply-To: <CAHVum0eF=CmqXabrJS7rsVxhQLKA7v8iG1SjThcEJ=_zAUhRsg@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 26 Apr 2022 13:33:23 -0700
Message-ID: <CAHVum0dF8w6ang3gN2w4W3tg2M08TXNpNfWNcDER5RfaxPE3oQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Speed up slot_rmap_walk_next for sparsely
 populated rmaps
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 9:29 AM Vipin Sharma <vipinsh@google.com> wrote:
>
> On Fri, Apr 8, 2022 at 12:31 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Sun, Mar 27, 2022 at 3:41 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > On 3/26/22 01:31, Vipin Sharma wrote:
> > > >>> -static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
> > > >>> +static noinline void
> > > >>
> > > >> What is the reason to add noinline?
> > > >
> > > > My understanding is that since this method is called from
> > > > __always_inline methods, noinline will avoid gcc inlining the
> > > > slot_rmap_walk_next in those functions and generate smaller code.
> > > >
> > >
> > > Iterators are written in such a way that it's way more beneficial to
> > > inline them.  After inlining, compilers replace the aggregates (in this
> > > case, struct slot_rmap_walk_iterator) with one variable per field and
> > > that in turn enables a lot of optimizations, so the iterators should
> > > actually be always_inline if anything.
> > >
> > > For the same reason I'd guess the effect on the generated code should be
> > > small (next time please include the output of "size mmu.o"), but should
> > > still be there.  I'll do a quick check of the generated code and apply
> > > the patch.
> > >
> > > Paolo
> > >
> >
> > Let me know if you are still planning to modify the current patch by
> > removing "noinline" and merge or if you prefer a v2 without noinline.
>
> Hi Paolo,
>
> Any update on this patch?
>

Hi Paolo,

Still waiting for your response on this patch :)
Please let me know if you prefer v2 (without noinline) or you will
merge this patch without noinline from your side. If there is any
concern or feedback which I can address please let me know.

Thanks
Vipin Sharma
