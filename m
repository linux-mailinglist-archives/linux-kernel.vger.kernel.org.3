Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FE4D9026
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiCNXNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343597AbiCNXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:13:41 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E703BF8F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:12:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o5so5056798ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jcGFDnk2ZGG1bJEADu4KX2ojHtFBsAIu/76P0Vp8qQ=;
        b=dEkCRsYp+MJ88Ryr09A72p/YdO6yGqO6HYOT4j+2PmSf1Fc1i9uuNZUJ+dRzhXIR6c
         hxl6+bTXY9g96VrCHB0rf9zglCVg57wIzPMGUcl5G2N5nJP47hZFJ5A4EU3etADVLZgi
         rCnORkYhOEfIzI1brWjsOm2WChZta6k5dxI7S2kWeXNu/p9wcGlH00DgLS5xj0VIdA9+
         kRr9gSd3K2K6tVeJ2E4Pc4R6dxc6xmvfG6BS2pPF+t9G64rYVLNSg+w8f8XYM9gZuG4M
         eD2+VeyTWRB3lxjb3FjgONy4cWYZK5gUSzWbV3xwfDDe8hn56mHOHgTPMbNq8JcjBCJS
         8t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jcGFDnk2ZGG1bJEADu4KX2ojHtFBsAIu/76P0Vp8qQ=;
        b=H2E51Y9H52nFBCztQopCu9nPKzRLLPNeOPSanly7RxhULT9lyjSVDZz/SmRGYZ/Unr
         9o//NKb6SXk4EtAJ3e3lcQD8MjQkp87nvbt1T20FXb8KgBCFObk6Pf5A7HbynrvRY96z
         8t/FN9IVrmN2OwB2zlC0HXLpY6x2tSVEgSFDcXqzaHLMSfqYtDlbMNGK2AKxgVF/R8JI
         hw9JMm5MB0NVEbRu4mWZ6bDg1jurxC7uWUyakPt2I64ZLWAUVGQS3N8KjjHydv9MtLH0
         +Exs0/6ftfuvtjYEgwszK5J9+hxNkMvSfGaTPMJWqrn+H318N+rAb4BJzpbQdeNW2b7o
         /e+g==
X-Gm-Message-State: AOAM533+DPyVUo6Go187+Mzi0aWDRPS8LQD5lwr3M9HY2hLLJx8uaWGJ
        It8otAx1Xbpted9zWq6QE/lFqyZjSL1H7ETJrtcRPA==
X-Google-Smtp-Source: ABdhPJwOFHiGKaFjeiuAVqn0xvjObYV2J61nUJiTd5dhiZHHRCKHynlwkSXGaPtMkDjYwpTL95ZQnsnKJb988XLF1wk=
X-Received: by 2002:a25:d512:0:b0:61d:aded:1743 with SMTP id
 r18-20020a25d512000000b0061daded1743mr19108638ybe.526.1647299550552; Mon, 14
 Mar 2022 16:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com> <20220224172559.4170192-5-rananta@google.com>
 <Yi+DS/BUPMiB+B0a@google.com>
In-Reply-To: <Yi+DS/BUPMiB+B0a@google.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 14 Mar 2022 16:12:19 -0700
Message-ID: <CAJHc60zTDrwM_cEBKACQjqxceKbCV65mMM83xgPa0xvxMtZo=Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] KVM: arm64: Capture VM's first run
To:     Oliver Upton <oupton@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

On Mon, Mar 14, 2022 at 11:02 AM Oliver Upton <oupton@google.com> wrote:
Hi Oliver,
>
> Hi Raghavendra,
>
> On Thu, Feb 24, 2022 at 05:25:50PM +0000, Raghavendra Rao Ananta wrote:
> > Capture the first run of the KVM VM, which is basically the
> > first KVM_RUN issued for any vCPU. This state of the VM is
> > helpful in the upcoming patches to prevent user-space from
> > configuring certain VM features, such as the feature bitmap
> > exposed by the psuedo-firmware registers, after the VM has
> > started running.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>
> I believe this patch is superseded by commit:
>
>   5177fe91e4cf ("KVM: arm64: Do not change the PMU event filter after a VCPU has run")
>
> on kvmarm/next.
>
Perfect! Just what we needed. I'll drop this patch.

Regards,
Raghavendra
>
> --
> Thanks,
> Oliver
