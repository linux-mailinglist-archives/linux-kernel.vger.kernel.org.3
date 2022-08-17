Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928985971AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiHQOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiHQOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00139410A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660747376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjZe8Vmc144tOlC9BhcpPSSqL3xq9DbQHAEA2c55U+w=;
        b=W4gonXlempj7r0H+r0/6+0/Upl2Xf+L8TbEHVwNrsZbMd2Lw49O0j/TNEFysplvRjZclb4
        I8LRBRYFe/JfUF88yPDSnANIWQLUiQ0B4OjNS1+DXjNnlk8pqlYc2o26Z9JvmaPAAFvCjX
        N/0XuwFWJuffnv6GTK+3az6DUx49M2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-pno4RYIqMC-WKaU8LvkS5g-1; Wed, 17 Aug 2022 10:42:55 -0400
X-MC-Unique: pno4RYIqMC-WKaU8LvkS5g-1
Received: by mail-wm1-f72.google.com with SMTP id c66-20020a1c3545000000b003a5f6dd6a25so1172489wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=bjZe8Vmc144tOlC9BhcpPSSqL3xq9DbQHAEA2c55U+w=;
        b=rZYQq01enlnbwBwQpfZIF57HGyrNXlPqWJi8D4NzCn18OFhPlzKh0SIaIJX5JJXvuJ
         fdPCz3m/+cpDR3otEywdiyIqNhrvWV3zdnFwUnH4M09ubL1uTEajx/dn6UrdeS89frFO
         XlxGiHhh0RiKy8T5kzdGTSG75g8vQkqHYzym8z4jeoYd+Guk8I1GJkzdHdgZyHBNUVJX
         Ji2hw3B5YAs2c1ar421b/bQZT0lOG4GDuFHu5NaIqZDbrfmFJXemlGeBXMtgB2ajDn/a
         tIi0YWJpxOHuV4PFzveOVkqEJWHgiAcLOJ2sQgO15/MRcWn2Pzjlc51LKHTEYa19PQxa
         RRuQ==
X-Gm-Message-State: ACgBeo0bODUCyWflybBtp+fRqF6WRkw+skhdmHIW7BrgrljH/KD47ovO
        8FuI1LrTsfsEiiho60KpFowPogTm+cBpEO3QDtalN1IWwvMg1wpTYjx+nX+nVBO9QNBQaL/r8nU
        LhssRCV15mbWVSaElhKr3NtiK
X-Received: by 2002:a05:600c:3d19:b0:3a5:c6ef:a875 with SMTP id bh25-20020a05600c3d1900b003a5c6efa875mr2336352wmb.66.1660747374688;
        Wed, 17 Aug 2022 07:42:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5YbAWrT75CQs7EPLDUNaqGsrAc0TzV2wqB74/+65VRQAtS7ImCQhlWBz1LLjBGLWy6cZh5pg==
X-Received: by 2002:a05:600c:3d19:b0:3a5:c6ef:a875 with SMTP id bh25-20020a05600c3d1900b003a5c6efa875mr2336334wmb.66.1660747374529;
        Wed, 17 Aug 2022 07:42:54 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id q13-20020a056000136d00b00224f5bfa890sm11926902wrz.97.2022.08.17.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:42:53 -0700 (PDT)
Message-ID: <f784199190fd070b97178b72c09965e5f02905c0.camel@redhat.com>
Subject: Re: [PATCH v3 03/13] KVM: x86: emulator: introduce
 emulator_recalc_and_set_mode
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 17 Aug 2022 17:42:51 +0300
In-Reply-To: <2e191acd-0b71-784a-2c14-6e78351788cc@intel.com>
References: <20220803155011.43721-1-mlevitsk@redhat.com>
         <20220803155011.43721-4-mlevitsk@redhat.com>
         <2e191acd-0b71-784a-2c14-6e78351788cc@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-11 at 23:33 +0800, Yang, Weijiang wrote:
> 
> On 8/3/2022 11:50 PM, Maxim Levitsky wrote:
> > [...]
> > +static inline int emulator_recalc_and_set_mode(struct x86_emulate_ctxt *ctxt)
> > +{
> > +       u64 efer;
> > +       struct desc_struct cs;
> > +       u16 selector;
> > +       u32 base3;
> > +
> > +       ctxt->ops->get_msr(ctxt, MSR_EFER, &efer);
> > +
> > +       if (!ctxt->ops->get_cr(ctxt, 0) & X86_CR0_PE) {
> Shouldn't this be:  !(ctxt->ops->get_cr(ctxt, 0) & X86_CR0_PE) ?

Ouch, thanks for noticing this!
I'll fix it in v4 (I'll wait a bit if I get more review feedback before sending it).

Best regards,
	Maxim Levitsky




> > +               /* Real mode. cpu must not have long mode active */
> > +               if (efer & EFER_LMA)
> > +                       return X86EMUL_UNHANDLEABLE;
> > +               ctxt->mode = X86EMUL_MODE_REAL;
> > +               return X86EMUL_CONTINUE;
> > +       }
> > +
> [...]
> > --
> > 2.26.3
> > 
> 


