Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B052986D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiEQDwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiEQDwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:52:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8972DABF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:52:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p8so15780959pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSM6wVFC/mVMfsxQOTfoNPtAY9TOEtVxrvAuav03prg=;
        b=GtJjkmI/L43qn/3ogE8DrcyyWxxFdKOA54+ZqdMNSgMJyxeKdwS9NDoYHGz3XAAKkq
         nvRmk1cfqZGlNg50FfK+71/kPFq3Pd87SHDsQgHH3eoqRMRHMpxfmBlBgXFzEFyxO8dn
         uTKM9/qHuCyqxrrnopqUTymstMZXI6g6nCwxdxY0D+m2AuEV/WwudaBHbBYYYzP48rxQ
         65YLM8KdC4zdFMpHasIsBePfPOThByKMVO7f5aGsXnFgxwbn5eBpNmEiHuaVg7weF36P
         SDQuk5cQhqiqUlmmNdCmsLKWTccBtvtKocwHLV40NT+Ij7aGQ+zvhjRMRAE3TR9tnWlr
         gZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSM6wVFC/mVMfsxQOTfoNPtAY9TOEtVxrvAuav03prg=;
        b=JIgoVsxQC1ZOzOHKsISMCXO9QIxX6X2w0WO5wGitrC/HgkxGxJ06PH6e3Eq80Yo6Zn
         RFt2d2C+VHP/vrVU/X40nth7ELQUqHB9MOyGtUm2aJ/3UmQG00hzprjDFzxl7+rsg1fw
         E3UUMcVd67n2s+ObE/2CJpZK/4g2775b7s6cuYCi4GsmeQ8/7ZpK/vDZsyM6FD7HsmvA
         PQIkIraxWyKeHUjejJ2DHRDJ4YyzKjUTgqcAL2SE1elJ70B7aGdz0Wxo+yChI+gzzhIh
         ScaDgUvpTLKdhu0U6dqwEWM68UTKS1U2JBbYik12/0bSHV+aHH05M8ijvJM/qNR6gndm
         euSw==
X-Gm-Message-State: AOAM532Ij8m5mX2qapBl1G31O5Mn5mWQjdLUrOtj4G/0Tp4paYHJwFm+
        nLjnQ/6G7/IfrRcEwDX+A5I4RQ==
X-Google-Smtp-Source: ABdhPJynzXrKKF+8HCiNT42Gd9ddW0DtWdDBFJiZshptXN+TCskfLssajmzFGsdxpEisAtCJJXwEUw==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id c1-20020a056a000ac100b004f129e4b3a1mr20609726pfl.63.1652759537058;
        Mon, 16 May 2022 20:52:17 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i1-20020a628701000000b0050dc762813dsm7556911pfe.23.2022.05.16.20.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:52:16 -0700 (PDT)
Date:   Tue, 17 May 2022 03:52:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Drop RWX=0 SPTEs during ept_sync_page()
Message-ID: <YoMb7AiSGBE4kUKT@google.com>
References: <20220513195000.99371-1-seanjc@google.com>
 <20220513195000.99371-2-seanjc@google.com>
 <CALzav=d36gccJv345Phdr0AJx9=6=TP=iZ60dscgQr64Rq4Kew@mail.gmail.com>
 <Yn7+HrYbXhror09V@google.com>
 <CALzav=eogd=sNaPOSW3_9hLSZ6pXe5eakHLr5vm8bUiwQrmA6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=eogd=sNaPOSW3_9hLSZ6pXe5eakHLr5vm8bUiwQrmA6Q@mail.gmail.com>
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

On Mon, May 16, 2022, David Matlack wrote:
> On Fri, May 13, 2022 at 5:56 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Fri, May 13, 2022, David Matlack wrote:
> > > On Fri, May 13, 2022 at 12:50 PM Sean Christopherson <seanjc@google.com> wrote:
> > > >
> > > > Drop SPTEs whose new protections will yield a RWX=0 SPTE, i.e. a SPTE
> > > > that is marked shadow-present but is not-present in the page tables.  If
> > > > EPT with execute-only support is in use by L1, KVM can create a RWX=0
> > > > SPTE can be created for an EPTE if the upper level combined permissions
> > > > are R (or RW) and the leaf EPTE is changed from R (or RW) to X.
> > >
> > > For some reason I found this sentence hard to read.
> >
> > Heh, probably because "KVM can create a RWX=0 SPTE can be created" is nonsensical.
> > I botched a late edit to the changelog...
> >
> > > What about this:
> > >
> > >   When shadowing EPT and NX HugePages is enabled, if the guest changes
> >
> > This doesn' thave anything to do with NX HugePages, it's an execute-only specific
> > bug where L1 can create a gPTE that is !READABLE but is considered PRESENT because
> > it is EXECUTABLE.  If the upper level protections are R or RW, the resulting
> > protections for the entire translation are RWX=0.  All of sync_page()'s existing
> > checks filter out only !PRESENT gPTE, because without execute-only, all upper
> > levels are guaranteed to be at least READABLE.
> 
> I see what you mean, thanks.
> 
> And I also recall now you mentioned (off-list) that the NX HugePage
> scenario isn't possible because KVM does not let huge pages go unsync.

Yep.  The other thing that's semi-relevant and I've mentioned off-list at least
once is that our (Google's) old kernel has a different NX HugePage implementation
that _can_ result in RWX=0 SPTEs.  Unlike upstream, the internal NX HugePage
implementation shatters a huge page _after_ installing said huge page, whereas
upstream demotes the huge page before it's installed.  If shattering fails on huge
page that L1 created a huge page with just X permissions, KVM is left with a RWX=0
huge page.
