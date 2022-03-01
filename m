Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4284C7F18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiCAAUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiCAAUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:20:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F56C24F16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:19:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q17so19874456edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQJGpmwFtFwNXc5097mgkIYQwk2uZL35ska8T+NcJow=;
        b=KGs+vZGMy5o9gCgPNjwPwkknTqUWH9d0S8bb/zRio2fK8Dv2rghQHeRb0KEjWTL766
         2eIDXGI5icCSPszRCMqnEqI+Ha1KfrCWpoKB6bcg2eFOwWSpydNvr466GcYTP26Qg4/f
         tARKJddn0pc3oXyPqf7e2kZhmrBDolzHBC6A3OZd+t+PvBtzkjeZK8qyG1jh7nHP3u1p
         J9gr4HZL/3Kst9h2MP4Dg4o46b86zGUY/caqwKWf+zElIuBnRV0U2M9wprxl/qaPdjBo
         IKyHzc3dSqsD21R/j6kvXuEL0gGMs20crzxMIkCYT/GjtIVhwUQsjzlX0uyoKc/veH4H
         pcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQJGpmwFtFwNXc5097mgkIYQwk2uZL35ska8T+NcJow=;
        b=4CrOYKFACy+ReftOxdQKB2ZkntbHM8DJhn1hHYm1mTmkCX/aZKI+Z+Ohb7z1Yuze+F
         OLBqeLl8hjCxrnFy98tU+X8IFifYKX0hiJAjS9KXFXC6B5oMm5UJTt7GYuu8h/ruKYTm
         XN4tPVyqwd16v/iJaqo/4swztREJMaNFsg79USBhR/t6tBIIiTfsn+Ih52cwymU3s0pA
         Cm5MBFVTLRULYY+jWe2syFCmVP87ivrtaoMHcOVNK01in0kSwFl+2RI9+qoVF6ZBjr2k
         ui79QoU2TlG7QLJEkcOF4xWCXMV/UwPhaApBiZ5f7figbdAtyASnb8Xkb+0jkC2S/qt1
         5tsQ==
X-Gm-Message-State: AOAM533SFhEGIfIlXyCuNCqcxjF84TTAigVbKxWD2tFJzrZgE1gtNRKc
        Zizl2cFGzSxSEv+BjmTKbvQG3U/3kSWweWJy6tgixA==
X-Google-Smtp-Source: ABdhPJwbRsNCxk51HWeaG7jiibestzZo1q5Nx/1XbkzzXZJfTLcI/499zyc44C5Nrb1RGZc9hjfxsYkftsWi47dzHb8=
X-Received: by 2002:aa7:c982:0:b0:406:3862:a717 with SMTP id
 c2-20020aa7c982000000b004063862a717mr22163022edt.358.1646093995992; Mon, 28
 Feb 2022 16:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com> <20220226001546.360188-15-seanjc@google.com>
In-Reply-To: <20220226001546.360188-15-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 28 Feb 2022 16:19:44 -0800
Message-ID: <CANgfPd9yGgXxT_Mue9DKpmtsCSrUQHCME7GcqYScEwxFwetimQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/28] KVM: x86/mmu: Skip remote TLB flush when zapping
 all of TDP MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 4:16 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Don't flush the TLBs when zapping all TDP MMU pages, as the only time KVM
> uses the slow version of "zap everything" is when the VM is being
> destroyed or the owning mm has exited.  In either case, KVM_RUN is
> unreachable for the VM, i.e. the guest TLB entries cannot be consumed.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index c231b60e1726..87706e9cc6f3 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -874,14 +874,15 @@ bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, int as_id, gfn_t start,
>
>  void kvm_tdp_mmu_zap_all(struct kvm *kvm)
>  {
> -       bool flush = false;
>         int i;
>
> +       /*
> +        * A TLB flush is unnecessary, KVM zaps everything if and only the VM
> +        * is being destroyed or the userspace VMM has exited.  In both cases,
> +        * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
> +        */
>         for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
> -               flush = kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, flush);
> -
> -       if (flush)
> -               kvm_flush_remote_tlbs(kvm);
> +               (void)kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, false);
>  }
>
>  /*
> --
> 2.35.1.574.g5d30c73bfb-goog
>
