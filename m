Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870BD4F993B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiDHPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiDHPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:21:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675A28E0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:19:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so6519026lfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+8vDhlfI4e4YJv+IZTf5GLdPIP5zWmwVbN2toxVSMg=;
        b=jshp7JPnZ4b52+DpFX5Y7Vjj4b1CaJc2SNgBkw8B+DSqjKnbv7Cg+CNajMqAA7WCyF
         C56eg1ViIFm5bwetBBFybAOIvRV3MytbgdrQxNjn2RLRAqNNcvpFnw9D9j7FUGnwLUTg
         KbWxscVCkjniUELcyzYEilP0x3uaKUAYnoE8mgVhXUHrBZY2mRcuZuhMUX/7yNB90gRS
         afUQrgghKOM3XWD8X7EMys7ekOvwSkKWPZyvk04rwsEL6TA4+wv4A+wxoxHcpCXg9WuM
         0bYvkGcEL1IvFoT5zKW6lLWs0vSq0RT3/vTkuSLSC6z9TcKl/knFq3HbV5MxsIS7+v4v
         lP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+8vDhlfI4e4YJv+IZTf5GLdPIP5zWmwVbN2toxVSMg=;
        b=zEAvCoozoueATAiaXbBL4tKhfGtsOK53xH6vvUcze1ntpY4MRVmftdqL/D+x0KW9ZT
         zz54n8dw57sgQnXgCdElnf4Ry1qT4ybk23izYr/ozsDJeiqwm9DCxjXRwawT1qf6AEyu
         l9v3kyZjShd/j7VoMzo1drZSpMqub0BGABXJ/K7L5+81qaAMLU7OWAlG4qgfJpcr4f2K
         MfUkyssOAfz+l5Sj5/oLk1oCo2wdTcr1ZBPkOihXF3vHgel9tfElRoOcBdkg0LZLx8Bx
         yRYBam7/yNtxsaCYQp2F0o4RbjIsyhxlQ8NulggYUGF/8ChuC4zfWKYTGNFPV1YT3ktG
         X25Q==
X-Gm-Message-State: AOAM5309gg9ui9fYOMOkg6dDB7Bg8zytZjZNUGkCmFNx2oi5Tjj57KeM
        1ytiqBf3PSMnujEx+mN8f4c8U3QhW/nPmOJBORu8sg==
X-Google-Smtp-Source: ABdhPJwtxrgOXmxyAVyhOkL1FRuBeD9s0pRubNWmG5wx3JVJqzDJvcZMJV+8sK0Jy+5m6EpphQksAPmfZlMx1O5FCVg=
X-Received: by 2002:a05:6512:131b:b0:44b:75d:e3d0 with SMTP id
 x27-20020a056512131b00b0044b075de3d0mr12721443lfu.685.1649431147929; Fri, 08
 Apr 2022 08:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210233.782250-1-pgonda@google.com> <Yk+kNqJjzoJ9TWVH@google.com>
In-Reply-To: <Yk+kNqJjzoJ9TWVH@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 8 Apr 2022 09:18:56 -0600
Message-ID: <CAMkAt6oc=SOYryXu+_w+WZR+VkMZfLR3_nd=hDvMU_cmOjJ0Xg@mail.gmail.com>
Subject: Re: [PATCH v4.1] KVM, SEV: Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 8:55 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Apr 07, 2022, Peter Gonda wrote:
> > If an SEV-ES guest requests termination, exit to userspace with
> > KVM_EXIT_SYSTEM_EVENT and a dedicated SEV_TERM type instead of -EINVAL
> > so that userspace can take appropriate action.
> >
> > See AMD's GHCB spec section '4.1.13 Termination Request' for more details.
>
> Maybe it'll be obvious by the lack of compilation errors, but the changelog should
> call out the flags => ndata+data shenanigans, otherwise this looks like ABI breakage.

Hmm I am not sure we can do this change anymore given that we have two
call sites using 'flags'

arch/arm64/kvm/psci.c:184
arch/riscv/kvm/vcpu_sbi.c:97

I am not at all familiar with ARM and RISC-V but some quick reading
tells me these archs also require 64-bit alignment on their 64-bit
accesses. If thats correct, should I fix this call sites up by
proceeding with this ndata + data[] change and move whatever they are
assigning to flags into data[0] like I am doing here? It looks like
both of these changes are not in a kernel release so IIUC we can still
fix the ABI here?

>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> >
> > ---
> > V4
> >  * Updated to Sean and Paolo's suggestion of reworking the
> >    kvm_run.system_event struct to ndata and data fields to fix the
> >    padding.
> >  * 4.1 Updated commit description
> >
> > V3
> >  * Add Documentation/ update.
> >  * Updated other KVM_EXIT_SHUTDOWN exits to clear ndata and set reason
> >    to KVM_SHUTDOWN_REQ.
> >
> > V2
> >  * Add KVM_CAP_EXIT_SHUTDOWN_REASON check for KVM_CHECK_EXTENSION.
> >
> > Tested by making an SEV-ES guest call sev_es_terminate() with hardcoded
> > reason code set and reason code and then observing the codes from the
> > userspace VMM in the kvm_run.shutdown.data fields.
> >
> > ---
> >  arch/x86/kvm/svm/sev.c   | 9 +++++++--
> >  include/uapi/linux/kvm.h | 5 ++++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 75fa6dd268f0..1a080f3f09d8 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2735,8 +2735,13 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
> >               pr_info("SEV-ES guest requested termination: %#llx:%#llx\n",
> >                       reason_set, reason_code);
> >
> > -             ret = -EINVAL;
> > -             break;
> > +             vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
> > +             vcpu->run->system_event.type = KVM_SYSTEM_EVENT_SEV_TERM |
> > +                                            KVM_SYSTEM_EVENT_NDATA_VALID;
> > +             vcpu->run->system_event.ndata = 1;
> > +             vcpu->run->system_event.data[1] = control->ghcb_gpa;
> > +
> > +             return 0;
>
> Kinda silly, but
>
>                 ret = 0;
>                 break;
>
> would be better so that this flows through the tracepoint.  I wouldn't care much
> if it didn't result in an unpaired "entry" tracepoint (and I still don't care that
> much...).

Ah I'll fix that up.


>
> >       }
> >       default:
> >               /* Error, keep GHCB MSR value as-is */
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 8616af85dc5d..dd1d8167e71f 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -444,8 +444,11 @@ struct kvm_run {
> >  #define KVM_SYSTEM_EVENT_SHUTDOWN       1
> >  #define KVM_SYSTEM_EVENT_RESET          2
> >  #define KVM_SYSTEM_EVENT_CRASH          3
> > +#define KVM_SYSTEM_EVENT_SEV_TERM       4
> > +#define KVM_SYSTEM_EVENT_NDATA_VALID    (1u << 31)
> >                       __u32 type;
> > -                     __u64 flags;
> > +                     __u32 ndata;
> > +                     __u64 data[16];
> >               } system_event;
> >               /* KVM_EXIT_S390_STSI */
> >               struct {
> > --
> > 2.35.1.1178.g4f1659d476-goog
> >
