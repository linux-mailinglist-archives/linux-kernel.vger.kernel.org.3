Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC848A40A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbiAJX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242630AbiAJX5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:57:12 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E86DC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:57:12 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so4007579ooj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSSSnrqTuvGyEJlGAFCeYpACHeVTMvACrp2X7lsYlbo=;
        b=nNGZGb/fCIB2jDSCk/PIrO7Qauom/vxWfeoXRAUwsXGjTX6HlFoNaAe7E4j2jjz/iq
         kTI7LDXzhhHRvjsTwUMV7ZQcXimqzFeJBGIDiNOw5Z8q/D+Mrdt5yhXH8t+6PKR9odPO
         qiv7zA0RPNhX/VN6yJKVAlrhG1q5ZHCN0QqadS1Gnw0GjqkTxckyha+XTV9jAX9Kwo4L
         AxKer6I6rT/aDJUmuyuAVVYtsQzhyYq9TAXFgL/+xMO84xDncNKTQZBRO0F/vQxfGhXx
         Ww0JHxmJoBAXAIgYj1Uh75HxAWJpc6rq6zNyIW/DF7gGZ3b15XuUuSgM73T4U2bb0aak
         YGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSSSnrqTuvGyEJlGAFCeYpACHeVTMvACrp2X7lsYlbo=;
        b=Xj47oSPFsfBZZKRyLKCYxOIPxBnOWO9UlSXapbNwGenXiZMZ1MHXK59afQtjfzV5I4
         nBSC2emIkfI0ZXtU9G3DJZ3OqY8ewmxefJlo6tkRroDvrbbM7HPoSLvxTc3we3Ws9fK3
         rSMkUBgTlI4mf50zRfd3jYrvKc9Oak8Ioa5NRjadGn3JUsGEmNPRtdInwKvqLQqLWnJO
         rmmRmlr1DPH1/0mJsRknyZed5fg22gNGRx+irhnvu0sEaDxbUC26aSA3Of9MPDWrglqy
         lMD4m99T3pFmlTairGSX/naX9bYyn/y74LhptT2ynKgOFYB5dq+XXXkcAcK1ZDQUjU4O
         tlAQ==
X-Gm-Message-State: AOAM530xGy+8X76PbF+uN/grez4KoFBT6R8EGQ50STYlUShOjYUw8F1T
        nli4qPHyEEljnuHbAUd6AoWpRWHmdg5xL+60lwaMEg==
X-Google-Smtp-Source: ABdhPJybT9OWDGZiQuBy7ZZfZDdvwUtX2enEK8TtOnoWTNRfA6QdvKJLhoeaodRUZv+xWokigwspjYrcy/3TIUFdvD4=
X-Received: by 2002:a4a:ac0a:: with SMTP id p10mr1471897oon.96.1641859031601;
 Mon, 10 Jan 2022 15:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com> <20220104194918.373612-2-rananta@google.com>
 <CAAeT=Fxyct=WLUvfbpROKwB9huyt+QdJnKTaj8c5NKk+UY51WQ@mail.gmail.com>
 <CAJHc60za+E-zEO5v2QeKuifoXznPnt5n--g1dAN5jgsuq+SxrA@mail.gmail.com>
 <CALMp9eQDzqoJMck=_agEZNU9FJY9LB=iW-8hkrRc20NtqN=gDA@mail.gmail.com> <CAJHc60xZ9emY9Rs9ZbV+AH-Mjmkyg4JZU7V16TF48C-HJn+n4A@mail.gmail.com>
In-Reply-To: <CAJHc60xZ9emY9Rs9ZbV+AH-Mjmkyg4JZU7V16TF48C-HJn+n4A@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 10 Jan 2022 15:57:00 -0800
Message-ID: <CALMp9eTPJZDtMiHZ5XRiYw2NR9EBKSfcP5CYddzyd2cgWsJ9hw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] KVM: Capture VM start
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Reiji Watanabe <reijiw@google.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 3:07 PM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> On Fri, Jan 7, 2022 at 4:05 PM Jim Mattson <jmattson@google.com> wrote:
> >
> > On Fri, Jan 7, 2022 at 3:43 PM Raghavendra Rao Ananta
> > <rananta@google.com> wrote:
> > >
> > > Hi Reiji,
> > >
> > > On Thu, Jan 6, 2022 at 10:07 PM Reiji Watanabe <reijiw@google.com> wrote:
> > > >
> > > > Hi Raghu,
> > > >
> > > > On Tue, Jan 4, 2022 at 11:49 AM Raghavendra Rao Ananta
> > > > <rananta@google.com> wrote:
> > > > >
> > > > > Capture the start of the KVM VM, which is basically the
> > > > > start of any vCPU run. This state of the VM is helpful
> > > > > in the upcoming patches to prevent user-space from
> > > > > configuring certain VM features after the VM has started
> > > > > running.
> >
> > What about live migration, where the VM has already technically been
> > started before the first call to KVM_RUN?
>
> My understanding is that a new 'struct kvm' is created on the target
> machine and this flag should be reset, which would allow the VMM to
> restore the firmware registers. However, we would be running KVM_RUN
> for the first time on the target machine, thus setting the flag.
> So, you are right; It's more of a resume operation from the guest's
> point of view. I guess the name of the variable is what's confusing
> here.

I was actually thinking that live migration gives userspace an easy
way to circumvent your restriction. You said, "This state of the VM is
helpful in the upcoming patches to prevent user-space from configuring
certain VM features after the VM has started running." However, if you
don't ensure that these VM features are configured the same way on the
target machine as they were on the source machine, you have not
actually accomplished your stated goal.

> Thanks,
> Raghavendra
