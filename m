Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFA55351C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbiEZP6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348049AbiEZP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 431C962CCC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653580719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ml+2Un+2KZ3TVl6sG/A1YKmOT5qa0U4xSuVqhe5us5Q=;
        b=XljZ6GtvORUT9OXJAiKFl+0nXZEhiGw/V/lF4mt2TqFrmOM625lziYtP2caNB9b7s6WG7d
        qAdLboIv+Ae5uKklD7dhxsKoCcTE4/23tZLP8CgmN0TTMgQoMvBvuMQF4cpfbKrmm36B84
        4PTDN23vkK0qqCMgIklulUurlyzDOj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-nyIWnIUcMqSjShNryX3hAA-1; Thu, 26 May 2022 11:58:38 -0400
X-MC-Unique: nyIWnIUcMqSjShNryX3hAA-1
Received: by mail-wm1-f70.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso3233165wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ml+2Un+2KZ3TVl6sG/A1YKmOT5qa0U4xSuVqhe5us5Q=;
        b=KipGoBxIU3oc2MpEbzyP92JH90hG9zzYynMTjuzaXBdyV6louMw62C/LKrRxfuDOEO
         WeO5t6CuQSYv3lbu8M6FU0hg6z9/JmaV+NRMeehX4lFDzw63ehDl68h7C1b70qYlePuz
         zknHaQiYr4f2d07zVsLyLFLzZ1xcBStXcPLffEjDcMiAp/nx36nKThIk9zV3fh0PdIWH
         fMRPUWAG3iITKypPa1f7RzQUhSpZaMLFBNr0MMBN3REOpO9FmwqUxYDMs+Gvq6O/c1My
         mKl4WFUp4n7sQA84KAoBg2b9ijdqsYyYdI8JXwYRpW/FoRt459NBQF95eEgv68xYSjbv
         QtwQ==
X-Gm-Message-State: AOAM531gUi7e3Thydx152RbalyQk6oYScDaasfPCJGnDa/LO9V1kaWuL
        M36WE6R+OPOlj/r5fJydXkKlYF8NR/Djm+B83fFNE1JluAUvwvfgv3iHdD94hDnvG41Gt6HRZUy
        gjRN86/8leKgk7GnZqxjBiVMm
X-Received: by 2002:a5d:5310:0:b0:20f:d075:a386 with SMTP id e16-20020a5d5310000000b0020fd075a386mr20240814wrv.619.1653580716982;
        Thu, 26 May 2022 08:58:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdX8n5lSKWjtB6SLf0Xw9OV0sMrXkpS32U+mbMh81UcGn5/PbIvXgE8ZxMaKh5qUfr3PU+aw==
X-Received: by 2002:a5d:5310:0:b0:20f:d075:a386 with SMTP id e16-20020a5d5310000000b0020fd075a386mr20240794wrv.619.1653580716775;
        Thu, 26 May 2022 08:58:36 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k42-20020a05600c1caa00b003942a244f57sm644180wms.48.2022.05.26.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:58:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] KVM: x86: Harden _regs accesses to guard against
 buggy input
In-Reply-To: <Yo+hkH9Uy0eSPErf@google.com>
References: <20220525222604.2810054-1-seanjc@google.com>
 <20220525222604.2810054-3-seanjc@google.com> <87r14gqte2.fsf@redhat.com>
 <Yo+hkH9Uy0eSPErf@google.com>
Date:   Thu, 26 May 2022 17:58:35 +0200
Message-ID: <87leuoqo9g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, May 26, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> > ---
>> >  arch/x86/kvm/emulate.c | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> > index 7226a127ccb4..c58366ae4da2 100644
>> > --- a/arch/x86/kvm/emulate.c
>> > +++ b/arch/x86/kvm/emulate.c
>> > @@ -247,6 +247,9 @@ enum x86_transfer_type {
>> >  
>> >  static ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
>> >  {
>> > +	if (WARN_ON_ONCE(nr >= 16))
>> > +		nr &= 16 - 1;
>> 
>> As the result of this is unlikely to match the expectation (and I'm
>> unsure what's the expectation here in the first place :-), why not use 
>> KVM_BUG_ON() here instead?
>
> ctxt->vcpu is a 'void *' due to the (IMO futile) separation of the emulator from
> regular KVM.  I.e. this doesn't have access to the 'kvm'.

Well, if we're not emulating something correctly for whatever reason,
killing the VM is likely the right thing to do so I'm going to vote for
abandoning the futility, making ctxt->vcpu 'struct kvm_vcpu *' and doing
KVM_BUG_ON(). (Not necessarily now, the patch looks good to me).

-- 
Vitaly

