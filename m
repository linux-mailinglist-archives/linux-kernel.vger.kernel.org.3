Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85454B9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351238AbiFNTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357939AbiFNTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:00:56 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551ACC6E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:58:31 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 19so10362664iou.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UcrIrSk5Swd+nvSBeuVYmeu1PhD4aHQkIlKjjep/U/8=;
        b=gXwMwJILGwkplNokon5zOdE2RQ1Qwvww6dSg4uCJAviXw5icGHnP09W33KGxS29FEj
         lQmoqXPAK+SY+SmDsCO/uWap3n/Movp3Wt4rOczfaAgqPoAhpMfjyUVxCTjKBao8mOHb
         xNde4umF8iDkfU55A43FTeYvB/iSrFz+vmF/5fknkICPrZ4tHShvwl3ctm6Jte1duC9w
         vGIuBcYhURzJCMJ0clNbF4yJswoL63YXLGidU23WgOeR+iaDgxtj7l+QnDEogu1l+H7l
         NemjvgzAPpKbQcnFV8aV5xNVWnYnLA+pLXhiZY49PjBL982JWxAL2SISJKdAwponp74I
         homg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UcrIrSk5Swd+nvSBeuVYmeu1PhD4aHQkIlKjjep/U/8=;
        b=mfrJNumJdP4qpoRxbI9MaL/F7H6V2jKbCNtkWihzBCZEw6O9Q/vVoLc9bH0hNS/YQW
         FG9cj/u2mEQaeTzhtaABBzthNi76vtWTdFBycfazf/YbfWvM1TOkuJTxGwXcJPecS9na
         HNbFeASv8AfOZX/kh3o3mXqcrwIp2iy9uob7Q/B9y+ori09WKhjpGkVXShAr0ke0K4mz
         QJBgtjusXae5EJHIhY10/fytDBEOu5WeBrR2H7asbrqqFygcGf2Hv8soTY0c2/TIJlx6
         AkreCCdnNAkPpWBADk/VYF9ZEhm9twULsgziRFne1kzJO1rYZ3PLx1bQ5quGUXTok9Ur
         HtgA==
X-Gm-Message-State: AOAM53116yirZzioYmCdyU5qj4oHp6xWO5vMwyByEa9LpBhbno2il3vR
        9iH9OoH2S4Rw1sp+VzIyv8X4dVT3sR8uglhBLcxBlQ==
X-Google-Smtp-Source: ABdhPJxkbeBOlNzS42LkPVnH7oYNg5c6GJRwXSXygjn2ujomA+SXpQWuvJtL4QMILjs/tOS/P8Vv380wMtHehK1DSBU=
X-Received: by 2002:a05:6638:13d5:b0:331:a6f2:3dbf with SMTP id
 i21-20020a05663813d500b00331a6f23dbfmr3907072jaj.9.1655233110381; Tue, 14 Jun
 2022 11:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210820155918.7518-1-brijesh.singh@amd.com> <20210820155918.7518-24-brijesh.singh@amd.com>
 <CABpDEukdrEbXjOF_QuZqUMQndYx=zVM4s2o-oN_wb2L_HCrONg@mail.gmail.com>
 <1cadca0d-c3dc-68ed-075f-f88ccb0ccc0a@amd.com> <CABpDEun0rjrNVCGZDXd8SO3tfZi-2ku3mit2XMGLwCsijbF9tg@mail.gmail.com>
 <ee1a829f-9a89-e447-d182-877d4033c96a@amd.com> <CAMkAt6q3otA3n-daFfEBP7kzD+ucMQjP=3bX1PkuAUFrH9epUQ@mail.gmail.com>
 <SN6PR12MB27671CDFDAA1E62AD49EC6C68EAA9@SN6PR12MB2767.namprd12.prod.outlook.com>
 <CAMkAt6r0ZsjS_XtVYnazC8-Z9bHQafLZ7QFq2NqcRQ2gZbUyPg@mail.gmail.com> <SN6PR12MB276764F83F8849603A2F23478EAA9@SN6PR12MB2767.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB276764F83F8849603A2F23478EAA9@SN6PR12MB2767.namprd12.prod.outlook.com>
From:   Alper Gun <alpergun@google.com>
Date:   Tue, 14 Jun 2022 11:58:19 -0700
Message-ID: <CABpDEum5cmODpA1HQUqG0doKv32AqZ0L9eA88nfg=F=OTMigxA@mail.gmail.com>
Subject: Re: [PATCH Part2 v5 23/45] KVM: SVM: Add KVM_SNP_INIT command
To:     "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc:     Peter Gonda <pgonda@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        "Roth, Michael" <Michael.Roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Let me summarize what I tried.

1- when using psp_init_probe false, the SNP VM fails in
SNP_LAUNCH_START step with error SEV_RET_DFFLUSH_REQUIRED(15).
2- added SEV_DF_FLUSH just after SNP platform init and it didn't fail
in launch start but failed later during SNP_LAUNCH_UPDATE with
SEV_RET_INVALID_PARAM(22)
3- added SNP_DF_FLUSH just after SNP platform init and it failed again
during SNP_LAUNCH_UPDATE with SEV_RET_INVALID_PARAM(22)
4- added sev_platform_init for SNP VMs and it worked.

For me DF_FLUSH alone didn' help boot a VM. I don't know yet why sev
platform status impacts the SNP VM, but sev_platform_init fixes the
problem.


On Tue, Jun 14, 2022 at 10:16 AM Kalra, Ashish <Ashish.Kalra@amd.com> wrote=
:
>
> [AMD Official Use Only - General]
>
> Hello Alper, Peter,
>
> -----Original Message-----
> From: Peter Gonda <pgonda@google.com>
> Sent: Tuesday, June 14, 2022 11:30 AM
> To: Kalra, Ashish <Ashish.Kalra@amd.com>
> Cc: Alper Gun <alpergun@google.com>; Brijesh Singh <brijesh.singh@amd.com=
>; the arch/x86 maintainers <x86@kernel.org>; LKML <linux-kernel@vger.kerne=
l.org>; kvm list <kvm@vger.kernel.org>; linux-coco@lists.linux.dev; linux-m=
m@kvack.org; Linux Crypto Mailing List <linux-crypto@vger.kernel.org>; Thom=
as Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Joerg Roe=
del <jroedel@suse.de>; Lendacky, Thomas <Thomas.Lendacky@amd.com>; H. Peter=
 Anvin <hpa@zytor.com>; Ard Biesheuvel <ardb@kernel.org>; Paolo Bonzini <pb=
onzini@redhat.com>; Sean Christopherson <seanjc@google.com>; Vitaly Kuznets=
ov <vkuznets@redhat.com>; Wanpeng Li <wanpengli@tencent.com>; Jim Mattson <=
jmattson@google.com>; Andy Lutomirski <luto@kernel.org>; Dave Hansen <dave.=
hansen@linux.intel.com>; Sergio Lopez <slp@redhat.com>; Peter Zijlstra <pet=
erz@infradead.org>; Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>; David Rientjes <rientjes@google.com>; Dov Murik <dovmurik@linux.ibm.com=
>; Tobin Feldman-Fitzthum <tobin@ibm.com>; Borislav Petkov <bp@alien8.de>; =
Roth, Michael <Michael.Roth@amd.com>; Vlastimil Babka <vbabka@suse.cz>; Kir=
ill A . Shutemov <kirill@shutemov.name>; Andi Kleen <ak@linux.intel.com>; T=
ony Luck <tony.luck@intel.com>; Marc Orr <marcorr@google.com>; Sathyanaraya=
nan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>; Pavan Kumar Pa=
luri <papaluri@amd.com>
> Subject: Re: [PATCH Part2 v5 23/45] KVM: SVM: Add KVM_SNP_INIT command
>
> On Tue, Jun 14, 2022 at 10:11 AM Kalra, Ashish <Ashish.Kalra@amd.com> wro=
te:
> >
> > [AMD Official Use Only - General]
> >
> >
> > -----Original Message-----
> > From: Peter Gonda <pgonda@google.com>
> > Sent: Tuesday, June 14, 2022 10:38 AM
> > To: Kalra, Ashish <Ashish.Kalra@amd.com>
> > Cc: Alper Gun <alpergun@google.com>; Brijesh Singh
> > <brijesh.singh@amd.com>; Kalra, Ashish <Ashish.Kalra@amd.com>; the
> > arch/x86 maintainers <x86@kernel.org>; LKML
> > <linux-kernel@vger.kernel.org>; kvm list <kvm@vger.kernel.org>;
> > linux-coco@lists.linux.dev; linux-mm@kvack.org; Linux Crypto Mailing
> > List <linux-crypto@vger.kernel.org>; Thomas Gleixner
> > <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Joerg Roedel
> > <jroedel@suse.de>; Lendacky, Thomas <Thomas.Lendacky@amd.com>; H.
> > Peter Anvin <hpa@zytor.com>; Ard Biesheuvel <ardb@kernel.org>; Paolo
> > Bonzini <pbonzini@redhat.com>; Sean Christopherson
> > <seanjc@google.com>; Vitaly Kuznetsov <vkuznets@redhat.com>; Wanpeng
> > Li <wanpengli@tencent.com>; Jim Mattson <jmattson@google.com>; Andy
> > Lutomirski <luto@kernel.org>; Dave Hansen
> > <dave.hansen@linux.intel.com>; Sergio Lopez <slp@redhat.com>; Peter
> > Zijlstra <peterz@infradead.org>; Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>; David Rientjes
> > <rientjes@google.com>; Dov Murik <dovmurik@linux.ibm.com>; Tobin
> > Feldman-Fitzthum <tobin@ibm.com>; Borislav Petkov <bp@alien8.de>;
> > Roth, Michael <Michael.Roth@amd.com>; Vlastimil Babka
> > <vbabka@suse.cz>; Kirill A . Shutemov <kirill@shutemov.name>; Andi
> > Kleen <ak@linux.intel.com>; Tony Luck <tony.luck@intel.com>; Marc Orr
> > <marcorr@google.com>; Sathyanarayanan Kuppuswamy
> > <sathyanarayanan.kuppuswamy@linux.intel.com>; Pavan Kumar Paluri
> > <papaluri@amd.com>
> > Subject: Re: [PATCH Part2 v5 23/45] KVM: SVM: Add KVM_SNP_INIT command
> >
> > On Mon, Jun 13, 2022 at 6:21 PM Ashish Kalra <ashkalra@amd.com> wrote:
> > >
> > >
> > > On 6/13/22 23:33, Alper Gun wrote:
> > > > On Mon, Jun 13, 2022 at 4:15 PM Ashish Kalra <ashkalra@amd.com> wro=
te:
> > > >> Hello Alper,
> > > >>
> > > >> On 6/13/22 20:58, Alper Gun wrote:
> > > >>> static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd
> > > >>> *argp)
> > > >>>>    {
> > > >>>> +       bool es_active =3D (argp->id =3D=3D KVM_SEV_ES_INIT ||
> > > >>>> + argp->id =3D=3D KVM_SEV_SNP_INIT);
> > > >>>>           struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_inf=
o;
> > > >>>> -       bool es_active =3D argp->id =3D=3D KVM_SEV_ES_INIT;
> > > >>>> +       bool snp_active =3D argp->id =3D=3D KVM_SEV_SNP_INIT;
> > > >>>>           int asid, ret;
> > > >>>>
> > > >>>>           if (kvm->created_vcpus) @@ -249,12 +269,22 @@ static
> > > >>>> int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
> > > >>>>                   return ret;
> > > >>>>
> > > >>>>           sev->es_active =3D es_active;
> > > >>>> +       sev->snp_active =3D snp_active;
> > > >>>>           asid =3D sev_asid_new(sev);
> > > >>>>           if (asid < 0)
> > > >>>>                   goto e_no_asid;
> > > >>>>           sev->asid =3D asid;
> > > >>>>
> > > >>>> -       ret =3D sev_platform_init(&argp->error);
> > > >>>> +       if (snp_active) {
> > > >>>> +               ret =3D verify_snp_init_flags(kvm, argp);
> > > >>>> +               if (ret)
> > > >>>> +                       goto e_free;
> > > >>>> +
> > > >>>> +               ret =3D sev_snp_init(&argp->error);
> > > >>>> +       } else {
> > > >>>> +               ret =3D sev_platform_init(&argp->error);
> > > >>> After SEV INIT_EX support patches, SEV may be initialized in the =
platform late.
> > > >>> In my tests, if SEV has not been initialized in the platform
> > > >>> yet, SNP VMs fail with SEV_DF_FLUSH required error. I tried
> > > >>> calling SEV_DF_FLUSH right after the SNP platform init but this
> > > >>> time it failed later on the SNP launch update command with
> > > >>> SEV_RET_INVALID_PARAM error. Looks like there is another
> > > >>> dependency on SEV platform initialization.
> > > >>>
> > > >>> Calling sev_platform_init for SNP VMs fixes the problem in our te=
sts.
> > > >> Trying to get some more context for this issue.
> > > >>
> > > >> When you say after SEV_INIT_EX support patches, SEV may be
> > > >> initialized in the platform late, do you mean sev_pci_init()->sev_=
snp_init() ...
> > > >> sev_platform_init() code path has still not executed on the host B=
SP ?
> > > >>
> > > > Correct, INIT_EX requires the file system to be ready and there is
> > > > a ccp module param to call it only when needed.
> > > >
> > > > MODULE_PARM_DESC(psp_init_on_probe, " if true, the PSP will be
> > > > initialized on module init. Else the PSP will be initialized on
> > > > the first command requiring it");
> > > >
> > > > If this module param is false, it won't initialize SEV on the
> > > > platform until the first SEV VM.
> > > >
> > > Ok, that makes sense.
> > >
> > > So the fix will be to call sev_platform_init() unconditionally here
> > > in sev_guest_init(), and both sev_snp_init() and sev_platform_init()
> > > are protected from being called again, so there won't be any issues
> > > if these functions are invoked again at SNP/SEV VM launch if they
> > > have been invoked earlier during module init.
> >
> > >That's one solution. I don't know if there is a downside to the system=
 for enabling SEV if SNP is being enabled but another solution could be to =
just directly place a DF_FLUSH command instead of calling sev_platform_init=
().
> >
> > Actually sev_platform_init() is already called on module init if psp_in=
it_on_probe is not false. Only need to ensure that SNP firmware is initiali=
zed first with SNP_INIT command.
>
> > But if psp_init_on_probe is false, sev_platform_init() isn't called dow=
n this path. Alper has suggested we always call sev_platform_init() but we =
could just place an SEV_DF_FLUSH command instead. Or am I still missing som=
ething?
>
> >After SEV INIT_EX support patches, SEV may be initialized in the platfor=
m late.
> > In my tests, if SEV has not been initialized in the platform
> > yet, SNP VMs fail with SEV_DF_FLUSH required error. I tried
> > calling SEV_DF_FLUSH right after the SNP platform init.
>
> Are you getting the DLFLUSH_REQUIRED error after the SNP activate command=
 ?
>
> Also did you use the SEV_DF_FLUSH command or the SNP_DF_FLUSH command ?
>
> With SNP you need to use SNP_DF_FLUSH command.
>
> Thanks,
> Ashish
