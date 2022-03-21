Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905624E2C96
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiCUPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350444AbiCUPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:44:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252DCFE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:42:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b5so1815769ljf.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HD4yrGJ09wTomQwPFW+U4jZvquDPNjiXAIbLn3DIW0c=;
        b=pDFK/K/WFaLSiapiN8ZpMU4Ikivm5cYZnu5jBoc7ITv6o8borkSRWT2IqzphTEKHmH
         u/Yd/CUgtuQa/sEA2UGrNQvIo7dEdEb3d7B/ct7w+zsnZXyfuf3mDgMxIMd0JMMmbuTK
         RtdMwJ6niMZyUutU0JNLwLSHFOj7fAQDxHkS/P+gFQzPzKR+12IxFcqxwumAfMO46tdB
         qf9qCT+kU2GVTjnX7QtTHwJxyzKFSakpYSWf9Fg+A7NBHqcLBji6/ItJrW3wgBx9/DP4
         k1R6mJ8jMZrbFads4NEasgiTSi23poKx5x671st0l0O/FV4KIF8j1nSBHs/rcvR6OW4P
         xCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HD4yrGJ09wTomQwPFW+U4jZvquDPNjiXAIbLn3DIW0c=;
        b=RuwLY4PYsE/Hq/hpzcfS9QbH9p8epehlYs1Dc9rgmewnkeVyQyLX60j47JxxKAVXI3
         MOwzMK7lAEsfubBN9HPdd0dSg3gdmMkae6KElNxyudS6MgvHzl+nSl1yTyIlx2qGYDcP
         lrRs2tVJLFxNC8Eb4KkCZW2EmgMXfz8m5C6KzOiJgHj2WerIQC6ghjKJJ5DRtJhruBYZ
         e/++tJ57yuXNgM3d1Rbft/AwcPfnezZike2A57F/8F9P4BIxiuZNVduXtKcEm8gHHW/O
         8601BoohFcOoJivu9RSAQ84gkgmvicsfP+ff18Qp5ZRaFwIBUbqqYZSkgBcC7hUmChTb
         cI6w==
X-Gm-Message-State: AOAM531ymxjk/Hzaovh6M8s9wwinSkVk4VWuZ4QyhlQsCHv+TR8aayQI
        6DiPIkNzJKFfQqGOsKPm1y8jvBaLfyW9MWKMLlJzWQ==
X-Google-Smtp-Source: ABdhPJw6yfhfXFLvwTSE3Iq+nqo2RW6hRoNSCj5GYyKqSAMa6D02GARGqafQuHuHuwvGzj1lN95xtWue7aoBAMwTTZE=
X-Received: by 2002:a2e:9654:0:b0:244:bb3f:6555 with SMTP id
 z20-20020a2e9654000000b00244bb3f6555mr15455039ljh.282.1647877370721; Mon, 21
 Mar 2022 08:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220321150214.1895231-1-pgonda@google.com> <f8500809-610e-ce44-9906-785b7ddc0911@redhat.com>
In-Reply-To: <f8500809-610e-ce44-9906-785b7ddc0911@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 21 Mar 2022 09:42:39 -0600
Message-ID: <CAMkAt6pNE9MC7U_qQDwTrFG5e8qaiWZ6f0HzR+mk4dCNC2Ue8A@mail.gmail.com>
Subject: Re: [PATCH] Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Marc Orr <marcorr@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 21, 2022 at 9:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 3/21/22 16:02, Peter Gonda wrote:
> > SEV-ES guests can request termination using the GHCB's MSR protocol. See
> > AMD's GHCB spec section '4.1.13 Termination Request'. Currently when a
> > guest does this the userspace VMM sees an KVM_EXIT_UNKNOWN (-EVINAL)
> > return code from KVM_RUN. By adding a KVM_EXIT_SHUTDOWN_ENTRY to kvm_run
> > struct the userspace VMM can clearly see the guest has requested a SEV-ES
> > termination including the termination reason code set and reason code.
> >
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Marc Orr <marcorr@google.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
>
> Looks good, but it has to also add a capability.

Thanks for the quick review! Just so I understand. I should add
KVM_CAP_SEV_TERM or something, then if that has been enabled do the
new functionality, else keep the old functionality?

>
> > +             /* KVM_EXIT_SHUTDOWN_ENTRY */
>
> Just KVM_EXIT_SHUTDOWN.
>

Will do.
