Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D11523DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347123AbiEKTmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbiEKTmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:42:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7F5A140
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:42:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso5866717pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TuQvAjYL56J1wcA991ESErwZaRbs9RKZeONpZ++M1bM=;
        b=Exxf/ZyAPjPBjbpa8Yw1q3Mu/rcVDfLT3UljovGIY5j2ZZf8h+pcF7210ou6k8XfhC
         /wUyPDDwXvTypJPd2u9OYloikf2JdAJ21j2V2Uw9epvWf76iG3ZQ1ts+RTGkhoAAPTmj
         B88AXrJu2PxY0A+KgoBKA5wRiIl/gzgTy5P1jG1p0nvbh7cIqHRBSt/eBxsCK3hPVTZy
         o7bJUAMQbfjuPPnw9TZuasjaBktFxt31QpH5HOHyNryL8548YE8ov+fPgYRGfYLSE+m1
         YIghH41hKFf/DjFAmuhhwS3iTa+q252WqPBFAZBERu1Khkj9674Gx+Bab6vKc45IlS/R
         Ut6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TuQvAjYL56J1wcA991ESErwZaRbs9RKZeONpZ++M1bM=;
        b=5w5mvtYRbqIAupgtpVi8wVo8cOxfJw5Us7DDSQjMkkGCQV0FW0yljcDvyZaNbm3Ngd
         GP0eSFFVmgIV/Z+bZ1bFYlqS2euxFESwJRYQowygle3NwJOxGss7b7B3+DnKfuknNzWs
         yWR6n1gDzLvp9x0PoH2K4OKlL+DELyTfMri/BamVShQmWRiEX95pTp72UfEpkhskmV4o
         k+CAREHhSXOu+/FJ/qmD1qRbqRSxecUBC/0OsBK9HRRTRWrdDEO6HOeU4Ynp1IMJQSWB
         U5a5qY4/RLD+kmjQizVaGP+DgCGcjSwdt8H1u4d3oykSRADoeHJySeHHn9tSzu2rsm4I
         ppPQ==
X-Gm-Message-State: AOAM533zNaIv5alD1h2kIfKwTVDZ5WPvEKLhZ6LhD/a2HKgk3CqqVC3S
        pPX3aUkbIboFNl1X9csWfeT8bQ==
X-Google-Smtp-Source: ABdhPJxkyyiCNTwjIA2mhaEpk/H3hvWzD0LUa95/KcxPqTTwOrYxt/saZw7+AHTuVPJ4hAxxOtejIg==
X-Received: by 2002:a17:90b:4a01:b0:1dc:b062:da0e with SMTP id kk1-20020a17090b4a0100b001dcb062da0emr6977001pjb.87.1652298138085;
        Wed, 11 May 2022 12:42:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090a460b00b001d25dfb9d39sm331136pjg.14.2022.05.11.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:42:17 -0700 (PDT)
Date:   Wed, 11 May 2022 19:42:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Zhang <zhanwei@google.com>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Sangwhan Moon <sxm@google.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Zhang <jingzhangos@google.com>,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Fix incorrect VM-exit profiling
Message-ID: <YnwRld0aH8489+XQ@google.com>
References: <20220412195846.3692374-1-zhanwei@google.com>
 <YnmqgFkhqWklrQIw@google.com>
 <CAN86XOYNpzEUN0aL9g=_GQFz5zdXX9Pvcs_TDmBVyJZDTfXREg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN86XOYNpzEUN0aL9g=_GQFz5zdXX9Pvcs_TDmBVyJZDTfXREg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jing and David

On Wed, May 11, 2022, Wei Zhang wrote:

Please don't top-post.  From https://people.kernel.org/tglx/notes-about-netiquette:

  A: Because it messes up the order in which people normally read text.
  Q: Why is top-posting such a bad thing?

  A: Top-posting.
  Q: What is the most annoying thing in e-mail?

  A: No.
  Q: Should I include quotations after my reply?


> On Tue, May 10, 2022 at 1:57 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Tue, Apr 12, 2022, Wei Zhang wrote:
> > > The profile=kvm boot option has been useful because it provides a
> > > convenient approach to profile VM exits.
> >
> > What exactly are you profiling?  Where the guest executing at any given exit?  Mostly
> > out of curiosity, but also in the hope that we might be able to replace profiling with
> > a dedicated KVM stat(s).
>
> Yes, the profiling is about finding out which instructions in the
> guest trigger VM exits and the corresponding frequencies.

Do you actually what to profile which instructions _trigger_ exits?  Because that's
not what this does.  This profiles every exit, regardless of whether or not the exit
was due to a guest action.  E.g. host IRQs/NMIs, page faults, etc... will all get
included and pollute the profile.  Over time, the signal-to-noise ratio will likely
improve, but there's definitely still going to be noise.

We actually tried to upstream histograms for exit reasons[*] (link is for arm64,
but we want it for x86 too, just can't find a link), but it was deemed too expensive
in terms of memory cost for general use.

An idea that's on our (GCP folks) todo list is to explore adding an eBPF hook into
the exit path that would allow userspace to inspect e.g. struct kvm_run on VM-Exit.
That would allow userspace to collect all kinds of info about VM-Exits without
committing to ABI beyond kvm_run, and without bloating the size of a vCPU for
environments that don't want detailed histograms/profiling.

My preference would be to find a more complete, KVM-specific solution.  The
profiling stuff seems like it's a dead end, i.e. will always be flawed in some
way.  If this cleanup didn't require a new hypercall then I wouldn't care, but
I don't love having to extend KVM's guest/host ABI for something that ideally
will become obsolete sooner than later.

[*] https://lore.kernel.org/all/20210922010851.2312845-3-jingzhangos@google.com
