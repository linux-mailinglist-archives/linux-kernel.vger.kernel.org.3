Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025FE487FD2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiAHAFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiAHAFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:05:01 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5164C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:05:01 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id h5-20020a9d6a45000000b005908066fa64so7445629otn.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 16:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIQIMAF9RLT+C4D5YuRDhHVaZflXIUIUiQfqwkcoWZc=;
        b=ikRLN/s+6VutL3/OAv9/D8Jt2GzaaDDFBTBjvFaNhLcP59xDsK76CcNlzc4oMBOwvc
         UodXoB8hp54v4YFwcJxBfHQoyZOxoD1KzRVhLjlrtXjMZ0kC/iGoTZH/bl4fz0ea+ER3
         Dd6O6lLHatYVKexOUaY4+UdpkbMut0ZQWhp+xoET0+ViFkHdL9PAOTCEnOnGuUhRVAYq
         5xd7e0TjW+HC1AYlN3jhHqlHe+wD8UU3lli7sEi6wuM8YwejdHniz5x1YpypSMC+KP4N
         bza8pbAUy1ess2KEkKTP8RDE1JvFMBkG3bWqEnfOBv4UnBRMOkZdssMMEE+iUi6lxhsD
         FCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIQIMAF9RLT+C4D5YuRDhHVaZflXIUIUiQfqwkcoWZc=;
        b=wtBNdP7aBCQQ3HrDn/WmCVqT7k48jD1I8s43oSBCoad175v0JxDDYdBC/5L30fK8w1
         lGRKrlgLqeDL2K9tV6+7ZZux/qWi0Sem063Xc8xTnyvaOEjvLqSEEfnltSxSJnGh798+
         Bkot1eqtB5nCvbcerxy83azW3/Mb4DSaR5022k09+hvqzxPiDgPrcAbsvY/dDyzuoscz
         ht847npv5VZoapqulOf/47VSZ8Y8GJ6L10ktV/zBWWqdvc+vLeCcNOF3zHaSq8fKSPFJ
         FX2VHs/ROK22NMVdW/IyGuFVEBs0YCb/T3Knt1OOrEJPun6zG9lM+MTU33//3Gx5HKA9
         SgQQ==
X-Gm-Message-State: AOAM532IKb8YRi4AAgLYFm8miqrs+o4NU0t5jF6Vdk7ACmRdoV2EXvys
        3EUowu2PGomt8TL09I/iptW93UPmQjEQDFKOd7+ETw==
X-Google-Smtp-Source: ABdhPJyvaiFT2G34coGt3czDQ/iLkIq+EgyiHgmZSbvDmR6/D06mxLvwlCBW5kXpWCbVDzlXbPJqPLrmwno45hzKJ4M=
X-Received: by 2002:a05:6830:4a9:: with SMTP id l9mr44223760otd.75.1641600300700;
 Fri, 07 Jan 2022 16:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com> <20220104194918.373612-2-rananta@google.com>
 <CAAeT=Fxyct=WLUvfbpROKwB9huyt+QdJnKTaj8c5NKk+UY51WQ@mail.gmail.com> <CAJHc60za+E-zEO5v2QeKuifoXznPnt5n--g1dAN5jgsuq+SxrA@mail.gmail.com>
In-Reply-To: <CAJHc60za+E-zEO5v2QeKuifoXznPnt5n--g1dAN5jgsuq+SxrA@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 7 Jan 2022 16:04:49 -0800
Message-ID: <CALMp9eQDzqoJMck=_agEZNU9FJY9LB=iW-8hkrRc20NtqN=gDA@mail.gmail.com>
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

On Fri, Jan 7, 2022 at 3:43 PM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> Hi Reiji,
>
> On Thu, Jan 6, 2022 at 10:07 PM Reiji Watanabe <reijiw@google.com> wrote:
> >
> > Hi Raghu,
> >
> > On Tue, Jan 4, 2022 at 11:49 AM Raghavendra Rao Ananta
> > <rananta@google.com> wrote:
> > >
> > > Capture the start of the KVM VM, which is basically the
> > > start of any vCPU run. This state of the VM is helpful
> > > in the upcoming patches to prevent user-space from
> > > configuring certain VM features after the VM has started
> > > running.

What about live migration, where the VM has already technically been
started before the first call to KVM_RUN?
