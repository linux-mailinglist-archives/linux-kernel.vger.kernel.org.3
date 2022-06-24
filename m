Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD4559EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiFXQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFXQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:36:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A21F47545
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:36:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b7so3370935ljr.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0kR56a3js8tVSJ/80FTzZmMgZbMcBIHC4Horg01B0c=;
        b=VHI4cibUu1nlWHaj0e1TN23hEBzchsJwNJ7pRPD9JLXj/JbuL64WYgN1Dd1IRkvPac
         ygipsK+DMHwpIQRsRsbkPu/+djsjTlnueymy5PTClA6o5M5jXIqwHrOIrFtmNyXbhiAY
         kCHtINfa6mI7k46ERe3C4mRVz9huLOLE/9ERK2CbRPYKdq9/dVDOC7BDdmQJZOQ9L3rh
         kHTOpCht0iCElT4L53YjSkh8ELGmiV/61uC9oA5sOwy8KOLsBFEPRq1xqbTaVTAqzzHA
         rrsXjD2OIPdEy28yftHFvR5TnUVUVvdaKNm4ZmDwswT0iDB3YQ+h16vkjyIlglLcnDlR
         Wp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0kR56a3js8tVSJ/80FTzZmMgZbMcBIHC4Horg01B0c=;
        b=ITv/OkvsROU87nHfykx3q4IMD1FgzXG7Tq5j/xEzyvGI0F1eD/z2NRp5vdFhsH+xJz
         W89cdZ/AQXYB9CV5x2FcUMLEkabk4EEVcLltkGHjUGYH6tbhkzLIizAkJ2u5M9BNxn/V
         bYATGiNbEp8vO7sbB6sY+QRpWFDXi6xQ4RcCPCaOKWGpwbPaXsuYSFd6Jgp3xl9vGAx9
         Ru2eJ/5fyWaJEJZvsOUNU1l+7AKWi5f+TTyIj2Q3tb+oaVMKnnzP9Ossu47iIhVeN5c4
         akIKMQMF3jafvItPITW++/tmiALxiIAWYRLcJXkPFQgJrfERjhS068WcxSrdLMVZR2S8
         vdMA==
X-Gm-Message-State: AJIora+aQgW/ujFilgjm+UwStRo0juaVcVWajdTAHFXXcAt7vge3nH4k
        r6BIYo7j3dJGzwFfUphVU5631oyPKaWkcRXqQug7ZQ==
X-Google-Smtp-Source: AGRyM1vL+EaPdx915agnP8RGtkdwEKmVIyCaqnwD+c2dfRqzuQVoNAkH4rIjSHdD14nbycbqpt00uWwh6peuqigJjOg=
X-Received: by 2002:a2e:22c6:0:b0:25a:8c16:baf with SMTP id
 i189-20020a2e22c6000000b0025a8c160bafmr6868072lji.132.1656088571108; Fri, 24
 Jun 2022 09:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655761627.git.ashish.kalra@amd.com> <1dbc14735bbc336c171ef8fefd4aef39ddf95816.1655761627.git.ashish.kalra@amd.com>
In-Reply-To: <1dbc14735bbc336c171ef8fefd4aef39ddf95816.1655761627.git.ashish.kalra@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 24 Jun 2022 10:35:59 -0600
Message-ID: <CAMkAt6o7jjZ9baQfTUO-r8+u0doJVqPm=fz88nQwuxh6qpBS_Q@mail.gmail.com>
Subject: Re: [PATCH Part2 v6 47/49] *fix for stale per-cpu pointer due to
 cond_resched during ghcb mapping
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-coco@lists.linux.dev,
        linux-mm@kvack.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Alper Gun <alpergun@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jarkko@kernel.org
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

On Mon, Jun 20, 2022 at 5:15 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Michael Roth <michael.roth@amd.com>
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

Can you add a commit description here? Is this a fix for existing
SEV-ES support or should this be incorporated into a patch in this
series which adds this issue?

> ---
>  arch/x86/kvm/svm/svm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fced6ea423ad..f78e3b1bde0e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1352,7 +1352,7 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
>  static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
> -       struct svm_cpu_data *sd = per_cpu(svm_data, vcpu->cpu);
> +       struct svm_cpu_data *sd;
>
>         if (sev_es_guest(vcpu->kvm))
>                 sev_es_unmap_ghcb(svm);
> @@ -1360,6 +1360,10 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>         if (svm->guest_state_loaded)
>                 return;
>
> +       /* sev_es_unmap_ghcb() can resched, so grab per-cpu pointer afterward. */
> +       barrier();
> +       sd = per_cpu(svm_data, vcpu->cpu);
> +
>         /*
>          * Save additional host state that will be restored on VMEXIT (sev-es)
>          * or subsequent vmload of host save area.
> --
> 2.25.1
>
