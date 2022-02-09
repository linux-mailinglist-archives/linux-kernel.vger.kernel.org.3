Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14554AFED5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiBIVAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:00:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiBIVAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:00:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5500DC03C1B8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:00:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so6426724pja.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 13:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQu/Hvwu+5JuPznaoKbB1EorddMM7fTfsGLmiQAYQZI=;
        b=K+wmv2hyR2o8GJLwGQa4S1j9XHcyrLXv9yntJQKJagwDON8Q4/S+YXfDU2qt15cdj8
         psPnt98ZiiT/D200xM9bDtrQ+CHf0LP229pyfFLh6cDD59cDrRPapKdmsU2YxPaifnKe
         UaGx9jo1pxf2e2+/+N9hOIr/dkWmr15Shzpa6k9f4Q5YeeKsXXp6oTtNbBDJfvGrjCcc
         7ErBHiYR8KOQT7AMrFSVpQGW5SF1pUvj1eAnhqQqGUr5z4Hqjk7npHA62tBUcPzdwSMt
         0SNkAjeg+iyaUzwrsHebnzsx23Cz3DtSQfz/J8gUmuud0TgSB51o8R6BG0tYGhVtBjhk
         Pleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQu/Hvwu+5JuPznaoKbB1EorddMM7fTfsGLmiQAYQZI=;
        b=a7Iuc11+4IvHoTpIZt7y8xnFa3P2GCoAQE50heCdWtIWYRE+qIiREGfT3rRP2eQxhC
         Su2UYMrWwti4B7Mk32QqtC9ffuUpv4H/9c/ojiy+piW0PsbeLIC16VOuCW3b/YCRlMza
         PT694YFUiGm984ytz4q5H+UN8/TAWlFWiyGZWJUQEuF0Abgfm7vP1Y3cm6xoicblV48V
         9li4dSxenRZMmOsccL155KkFn1qfFTiMhnDdvK0VHwY9BAul6zWH7C0JfpVuXBqtCzYm
         CSmj3ZXcV6GXNi+Lr8x1Gm6rMVy3QmZREYCJifZ3PsGkhxJec24GhGznOKW/vTOPGDhd
         L76w==
X-Gm-Message-State: AOAM531KrTSL5npjOTbOVC+VZo2sDr1KujQBdX2Y68Ggds2jU1GZ+mP5
        y45dWov9QorYkE81JWHu+Ygc3Q==
X-Google-Smtp-Source: ABdhPJx8Oyd3yTeg3mHyfIsOkM4zJW8IzZ3Jcigqxn2P7vwLLElRvREdwVT1CY7UdHpK6bQKXsj3bQ==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr4013103plo.89.1644440412425;
        Wed, 09 Feb 2022 13:00:12 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d8sm14043624pfj.179.2022.02.09.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:00:11 -0800 (PST)
Date:   Wed, 9 Feb 2022 21:00:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        David Dunn <daviddunn@google.com>
Subject: Re: KVM: x86: Reconsider the current approach of vPMU
Message-ID: <YgQrWHCNG/s4EWFf@google.com>
References: <20220117085307.93030-1-likexu@tencent.com>
 <20220117085307.93030-3-likexu@tencent.com>
 <20220202144308.GB20638@worktop.programming.kicks-ass.net>
 <CALMp9eRBOmwz=mspp0m5Q093K3rMUeAsF3vEL39MGV5Br9wEQQ@mail.gmail.com>
 <2db2ebbe-e552-b974-fc77-870d958465ba@gmail.com>
 <YgPCm1WIt9dHuoEo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPCm1WIt9dHuoEo@hirez.programming.kicks-ass.net>
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

On Wed, Feb 09, 2022, Peter Zijlstra wrote:
> On Wed, Feb 09, 2022 at 04:10:48PM +0800, Like Xu wrote:
> > On 3/2/2022 6:35 am, Jim Mattson wrote:
> > > 3) TDX is going to pull the rug out from under us anyway. When the TDX
> > > module usurps control of the PMU, any active host counters are going
> > > to stop counting. We are going to need a way of telling the host perf
> > 
> > I presume that performance counters data of TDX guest is isolated for host,
> > and host counters (from host perf agent) will not stop and keep counting
> > only for TDX guests in debug mode.
> 
> Right, lots of people like profiling guests from the host. That allows
> including all the other virt gunk that supports the guest.
> 
> Guests must not unilaterally steal the PMU.

The proposal is to add an option to allow userspace to gift the PMU to the guest,
not to let the guest steal the PMU at will.  Off by default, certain capabilities
required, etc... are all completely ok and desired, e.g. we also have use cases
where we don't want to let the guest touch the PMU.

David's response in the original thread[*] explains things far better than I can do.

[*] https://lore.kernel.org/all/CABOYuvbPL0DeEgV4gsC+v786xfBAo3T6+7XQr7cVVzbaoFoEAg@mail.gmail.com
