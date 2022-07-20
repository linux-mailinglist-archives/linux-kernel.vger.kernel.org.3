Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380D757C03F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiGTWq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:46:55 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE37255A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:46:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso9134093otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L6ONf5ncBROvqp8ldt4WaxSQOKhi80VGBXn7MyeukQM=;
        b=OF2F9CSZB9dqPMw9JeJAkZYBC49PxC8TCHuYSx0KzkiBwalvgpJt7XRlNs8Ce1K2lA
         brLh8Td3sWspE0ZXoaE/QAZ/dL96Bnm7Yw5hlK8PXufEhP57CWgFR0J4QQDFTIv4MChO
         JInIWUSV8uOGbxolJ/RtdequmVH84QVO66o4TDiRg/yw80ezxcdEwyrdHa6JPkJzfkzg
         EHAfQmenRDQqrPaEPwHoDGSb7inZTZLD99d04aivMxQq/AqHAYh7B5N0TkCNiXEtdKaY
         TxGhclRVTWvnJMe6N4jTEUV46ZFA2G9muTf8FH0YhZgt0W2LwRvNwxAtDv/DNiEdQsP8
         MW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L6ONf5ncBROvqp8ldt4WaxSQOKhi80VGBXn7MyeukQM=;
        b=GIUTXlHOCLf65aFmNh/6hlboIIyIhooQ8J7bNIjFd54XC/9bGb83siSnr5PpH0KZ1a
         WR0xGh2ZMmGRGChI2MKb8b9Vzr6arub+VpcU+9Ks3unDtIZUschBeJdLjp2uP4T6gjtK
         WiGN+2w/JB17Cim1ycrXGfVX/QaU8+O0z+JO4kzgb0RP2mSygJqEqfgK1+07BlRKuctr
         nm4HilkJozSPH/oCaCqxbaV+ZsQr0c/+vopo8Meaw910Snf2ZdQG3QHSlhqLQwx26lDZ
         BTKJedJj2e+8hGGSiIDRfc54Z0G9VkQFxRv7HQzlGP+o5Cr/TtdQ0MxbIBLQgNDov8K/
         ydng==
X-Gm-Message-State: AJIora/CwQugiAI36pYePziTqLEAXp53otB3Mu1KLfc7yvwUD92Ob2A1
        zZPaUWuZ/5abTyN2nMab/SW8oKxnuv8lsU7mraHp1w==
X-Google-Smtp-Source: AGRyM1uPF6DlqAUTYGw9rwWhLZe0IbZS8bttwlHpwkLIdngm1dXnNU/Q4NNnFl79sj+FOUsPicgVXN4MCKX0nyDM0UA=
X-Received: by 2002:a9d:38e:0:b0:61c:7323:6202 with SMTP id
 f14-20020a9d038e000000b0061c73236202mr14777740otf.267.1658357213389; Wed, 20
 Jul 2022 15:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220709134230.2397-1-santosh.shukla@amd.com> <20220709134230.2397-6-santosh.shukla@amd.com>
 <Yth2eik6usFvC4vW@google.com>
In-Reply-To: <Yth2eik6usFvC4vW@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 20 Jul 2022 15:46:42 -0700
Message-ID: <CALMp9eQ_ygX7P-YKGQh0mZein6LcTM=gMbQpi8HNfm7XaFi36w@mail.gmail.com>
Subject: Re: [PATCHv2 5/7] KVM: SVM: Add VNMI support in inject_nmi
To:     Sean Christopherson <seanjc@google.com>
Cc:     Santosh Shukla <santosh.shukla@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 2:41 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sat, Jul 09, 2022, Santosh Shukla wrote:
> > Inject the NMI by setting V_NMI in the VMCB interrupt control. processor
> > will clear V_NMI to acknowledge processing has started and will keep the
> > V_NMI_MASK set until the processor is done with processing the NMI event.
> >
> > Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> > ---
> > v2:
> > - Added WARN_ON check for vnmi pending.
> > - use `get_vnmi_vmcb` to get correct vmcb so to inject vnmi.
> >
> >  arch/x86/kvm/svm/svm.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 44c1f2317b45..c73a1809a7c7 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3375,12 +3375,20 @@ static void pre_svm_run(struct kvm_vcpu *vcpu)
> >  static void svm_inject_nmi(struct kvm_vcpu *vcpu)
> >  {
> >       struct vcpu_svm *svm = to_svm(vcpu);
> > +     struct vmcb *vmcb = NULL;
> > +
> > +     ++vcpu->stat.nmi_injections;
> > +     if (is_vnmi_enabled(svm)) {
> > +             vmcb = get_vnmi_vmcb(svm);
> > +             WARN_ON(vmcb->control.int_ctl & V_NMI_PENDING);
>
> Haven't read the spec, but based on the changelog I assume the flag doesn't get
> cleared until the NMI is fully delivered.

Ooh! Is there a spec to read now?!?
