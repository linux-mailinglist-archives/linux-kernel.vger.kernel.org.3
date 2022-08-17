Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43065967BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiHQD33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiHQD31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F027FE77
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660706964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RR5bzl/FFsvb9EIwHBGZXkpeL0zuQN7q9Hui9bCl8JY=;
        b=JAoq37S9iXJHlFwhDXXmbAmhiEdOnhMLvjzKYofDRXjRLF6z/yTgLUOaENx9IAyJoqRFuq
        vFnBRwAb5bwCRG9yRURSVwn1SrQTdeFErlnZOP54Fyjmx60Rl2Z9WT3qUxY0qIRYjbEBKk
        lP6jf6ssBaXRf1bjJKVTWimJQ02PAkI=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-7a4pa-_TM4ONjiTeLeDoWQ-1; Tue, 16 Aug 2022 23:29:23 -0400
X-MC-Unique: 7a4pa-_TM4ONjiTeLeDoWQ-1
Received: by mail-vk1-f200.google.com with SMTP id r5-20020a1fa805000000b00378dce47c06so2538579vke.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=RR5bzl/FFsvb9EIwHBGZXkpeL0zuQN7q9Hui9bCl8JY=;
        b=avs3fRIcBxyWtV+VqBt1qLftTBvP/6ufr6cge3d5oNaNDFQj9m2M7DPBXycwkVXyty
         NPeZkkKNlzK+oCitZE/YZ+do4Du6781I8usrTudD6CJOHki4JtoFDuaFkxWZD09PvBOr
         IWmjV681YIMNRtCI02yJmVi0d8esT4qsODEl17iV+N/lhKWRCuEUD9qqko8BNlLpGUty
         M9kMF0QUW8vRQbl+cECsJVy/95ExMgyoH3XrbuJfzBd8zKbbZcEHyKjSSK5CnRjwLwAH
         iWDWnLIJ8IGMH484hq23pfJjcURntT91CiUyYZ8IKQi5+zYBhDGJ/PftvKNcYpBOznSM
         995g==
X-Gm-Message-State: ACgBeo3qvIQK2RzY8ZVnOgRxV4ZrC2V9hmjNGquirGsmRMNUyr9MEBU9
        xElPIXQ+937ow8ALD1jNOrxtuClyEV/OYYmolkZMGGlOVpwUSU4YC6XE/Ro59A04ls9ELkiZFxU
        S1InZ6BSa15H8OHbgbB9tXqb0
X-Received: by 2002:a9f:358c:0:b0:387:9de3:6c8a with SMTP id t12-20020a9f358c000000b003879de36c8amr9875407uad.94.1660706962883;
        Tue, 16 Aug 2022 20:29:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fcp7kFFEeySED5iDFA+pzHhLU8J+5uKUdwRJl7tWznWLtKxiDNgfeB3BylX7kqYieWkBxzg==
X-Received: by 2002:a9f:358c:0:b0:387:9de3:6c8a with SMTP id t12-20020a9f358c000000b003879de36c8amr9875398uad.94.1660706962518;
        Tue, 16 Aug 2022 20:29:22 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a800:7e7a:dbd2:b312:9b9c:dcb7? ([2804:1b3:a800:7e7a:dbd2:b312:9b9c:dcb7])
        by smtp.gmail.com with ESMTPSA id n65-20020a1f5944000000b00378fe8518dcsm9828486vkb.51.2022.08.16.20.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 20:29:21 -0700 (PDT)
Message-ID: <e9b456cee5032c62cab6b9a3ab1411196d4d1c3c.camel@redhat.com>
Subject: Re: [PATCH] KVM: x86: Always enable legacy fp/sse
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Date:   Wed, 17 Aug 2022 00:29:17 -0300
In-Reply-To: <YvwODUu/rdzjzDjk@google.com>
References: <20220816175936.23238-1-dgilbert@redhat.com>
         <YvwODUu/rdzjzDjk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-16 at 21:37 +0000, Sean Christopherson wrote:
> On Tue, Aug 16, 2022, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > A live migration under qemu is currently failing when the source
> > host is ~Nehalem era (pre-xsave) and the destination is much newer,
> > (configured with a guest CPU type of Nehalem).
> > QEMU always calls kvm_put_xsave, even on this combination because
> > KVM_CAP_CHECK_EXTENSION_VM always returns true for KVM_CAP_XSAVE.
> >=20
> > When QEMU calls kvm_put_xsave it's rejected by
> >    fpu_copy_uabi_to_guest_fpstate->
> >      copy_uabi_to_xstate->
> >        validate_user_xstate_header
> >=20
> > when the validate checks the loaded xfeatures against
> > user_xfeatures, which it finds to be 0.
> >=20
> > I think our initialisation of user_xfeatures is being
> > too strict here, and we should always allow the base FP/SSE.
> >=20
> > Fixes: ad856280ddea ("x86/kvm/fpu: Limit guest user_xfeatures to suppor=
ted bits of XCR0")

Thanks for fixing this, Dave!

> > bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D2079311
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  arch/x86/kvm/cpuid.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index de6d44e07e34..3b2319cecfd1 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -298,7 +298,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcp=
u *vcpu)
> >  	guest_supported_xcr0 =3D
> >  		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_=
nent);
> > =20
> > -	vcpu->arch.guest_fpu.fpstate->user_xfeatures =3D guest_supported_xcr0=
;
> > +	vcpu->arch.guest_fpu.fpstate->user_xfeatures =3D guest_supported_xcr0=
 |
> > +		XFEATURE_MASK_FPSSE;
>=20
> I don't think this is correct.  This will allow the guest to set the SSE =
bit
> even when XSAVE isn't supported due to kvm_guest_supported_xcr0() returni=
ng
> user_xfeatures.
>=20
>   static inline u64 kvm_guest_supported_xcr0(struct kvm_vcpu *vcpu)
>   {
> 	return vcpu->arch.guest_fpu.fpstate->user_xfeatures;
>   }
>=20
> I believe the right place to fix this is in validate_user_xstate_header()=
.  It's
> reachable if and only if XSAVE is supported in the host, and when XSAVE i=
s _not_
> supported, the kernel unconditionally allows FP+SSE.  So it follows that =
the kernel
> should also allow FP+SSE when using XSAVE too.  That would also align the=
 logic
> with fpu_copy_guest_fpstate_to_uabi(), which fordces the FPSSE flags.  Di=
tto for
> the non-KVM save_xstate_epilog().
>=20
> Aha!  And fpu__init_system_xstate() ensure the host supports FP+SSE when =
XSAVE
> is enabled (knew their had to be a sanity check somewhere).

Thanks for the feedback Sean!

I have near to no experience in this code, and I hope you can help me with =
a
question I have, based in Dave's commit message:

> > QEMU always calls kvm_put_xsave, even on this combination because
> > KVM_CAP_CHECK_EXTENSION_VM always returns true for KVM_CAP_XSAVE.

Any particular reason why it always returns true for KVM_CAP_XSAVE, even wh=
en
the CPU does not support it?=20

IIUC, if it returns false to this capability, kvm_put_xsave() should never =
be
called, and thus it can avoid bug reproduction.=20

Thanks in advance,

Leo

>=20
> ---
>  arch/x86/kernel/fpu/xstate.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c8340156bfd2..83b9a9653d47 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -399,8 +399,13 @@ int xfeature_size(int xfeature_nr)
>  static int validate_user_xstate_header(const struct xstate_header *hdr,
>  				       struct fpstate *fpstate)
>  {
> -	/* No unknown or supervisor features may be set */
> -	if (hdr->xfeatures & ~fpstate->user_xfeatures)
> +	/*
> +	 * No unknown or supervisor features may be set.  Userspace is always
> +	 * allowed to restore FP+SSE state (XSAVE/XRSTOR are used by the kernel
> +	 * if and only if FP+SSE are supported in xstate).
> +	 */
> +	if (hdr->xfeatures & ~fpstate->user_xfeatures &
> +	    ~(XFEATURE_MASK_FP | XFEATURE_MASK_SSE))
>  		return -EINVAL;
>=20
>  	/* Userspace must use the uncompacted format */
>=20
> base-commit: de3d415edca23831c5d1f24f10c74a715af7efdb
> --
>=20

