Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5600470A57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbhLJT3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhLJT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:29:04 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C5C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:25:28 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso2623357ood.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2O/k+0WJjv36z9ljqaNmunhvSO3XD5bqz1h3tYoPxRY=;
        b=QjUG+ueAqVzUrkK61BmuZKUhyPFdYuTG08nwJtv0O04h6TCDcG8WoBBrV578HnVBUp
         12Wqg4pKnlXVYKgbkfPkBHbIg0DYw+IaGRmLIAXA0X11AUX499qwVMiuJCFLmUslSWw4
         BJsAWGbl57SN0XzFo8U4L9gWco6vSIOv8SR6Fy3J6UBz6EtK+LCNDouMdKZUYSjc6MDO
         AymiEhiRxIF8dlkEgB/iq2zdURKSYJMchthlIwOtwns0CofbY5qvwqbf8+hybK0IXwok
         cxqLAD4EvN+8HtzaEFuEKcCA1Mb2ddnP/KCeGJ2uRPDpCy1vCG6qEF5Nr09Re2b9jqmN
         2R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2O/k+0WJjv36z9ljqaNmunhvSO3XD5bqz1h3tYoPxRY=;
        b=NoCJKDD3OLjnutYQm+I/gIfHYrCE0GFv0iBJcURNyyW7p4pP4ELOJAIlb0WGinIooK
         ZPRxhYSkMiPxXXl4OwLSgsuuvbUJwvVvwvB/YeA5LAzZbMVAQwn4mO8gqX+tgJTLWgAJ
         HNX2qvqEkIyJC5k/OgpKk84nj+lsjCarbrP8co8lPlzIE7c5AaY++YtBqurlko817YAj
         tRfdGLQwo5CkSL5M3I/VFaY2X1w1cJCfy8cUu0EifH5rod9fthA6QKEHotaKqjsWRcU1
         CHUHgwQdxz3i3HkFVyJ7H+ra4uZBJziyEObz819U+tMrm/UOvBUf9McGlQOu7Dh5+iS1
         t6Hg==
X-Gm-Message-State: AOAM531XRhkCc1zJCiw0TAVJQNbMlp8xeD7l0SrJ4XZZjzdv5Kf9ckol
        XLZ7/BLaEuk5WKBgC5JoxLGw1Sh07UhRQJkcEw83ow==
X-Google-Smtp-Source: ABdhPJz/b54e9nJbJ5xI/FnYU6tWOhDugbvhk07RZSn0BQ6FmckTR52Hi5ZxW7/JCtRBdlflAX2DB/ODsLypeqrGTXk=
X-Received: by 2002:a4a:3042:: with SMTP id z2mr9506922ooz.47.1639164327855;
 Fri, 10 Dec 2021 11:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20211117080304.38989-1-likexu@tencent.com> <c840f1fe-5000-fb45-b5f6-eac15e205995@redhat.com>
In-Reply-To: <c840f1fe-5000-fb45-b5f6-eac15e205995@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Dec 2021 11:25:16 -0800
Message-ID: <CALMp9eRA8hw9zVEwnZEX56Gao-MibX5A+XXYS-n-+X0BkhrSvQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/svm: Add module param to control PMU virtualization
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 5:25 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/17/21 09:03, Like Xu wrote:
> > From: Like Xu <likexu@tencent.com>
> >
> > For Intel, the guest PMU can be disabled via clearing the PMU CPUID.
> > For AMD, all hw implementations support the base set of four
> > performance counters, with current mainstream hardware indicating
> > the presence of two additional counters via X86_FEATURE_PERFCTR_CORE.
> >
> > In the virtualized world, the AMD guest driver may detect
> > the presence of at least one counter MSR. Most hypervisor
> > vendors would introduce a module param (like lbrv for svm)
> > to disable PMU for all guests.
> >
> > Another control proposal per-VM is to pass PMU disable information
> > via MSR_IA32_PERF_CAPABILITIES or one bit in CPUID Fn4000_00[FF:00].
> > Both of methods require some guest-side changes, so a module
> > parameter may not be sufficiently granular, but practical enough.
> >
> > Signed-off-by: Like Xu <likexu@tencent.com>
> > ---
Thanks for this patch. It saves us from upstreaming our equivalent patch.

In the long run, I'd like to be able to override this system-wide
setting on a per-VM basis, for VMs that I trust. (Of course, this
implies that I trust the userspace process as well.)

How would you feel if we were to add a kvm ioctl to override this
setting, for a particular VM, guarded by an appropriate permissions
check, like capable(CAP_SYS_ADMIN) or capable(CAP_SYS_MODULE)?
