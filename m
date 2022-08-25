Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F45A1A66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiHYUf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiHYUfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:35:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B1A2D86
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:35:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d12so797511plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L4DrXRzmNACqrECbSvsoVicvWrBCIZ0K0tYDPC755BI=;
        b=E2Qo9lmSdvHNWGIs6lAZ5j37P2g3qIVLKFFOIMnIZ8CqtisQAIrQv9ttEGVpxQup0s
         5+vGZ6blXM5E2Vhr8bmyMavsA2SmlLJA/ZCaGnbD2ORKjPjeIKNojZDKQ0To0sPChhXS
         7Q9iUTpx5d1SUtlPk28AEJ2kf9I2Zp78vZnoZ68nDPViNZLYboEKhqKVAi5552sK0vl8
         W06LiOnz/JU6PABom0KwymcUfUcnS3iiCRLwRz/YyZEysCG6nBCwdSh/S87Tw0DihSkX
         LhaEBKDqPNbN3toikdU4bXfqK2jd1N8h6OXTWoG/aFYobxRRVPWcdnH9IlE5f9cWUOFK
         wuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L4DrXRzmNACqrECbSvsoVicvWrBCIZ0K0tYDPC755BI=;
        b=vpyIG4G3ieD7UsMgeEOELn4OUCfJYwi7+a55i0pyqCPss1L42TZwVUlQLFqYP1eXc4
         i2Vt+v78LP1GyE3zSDXtTVMDUA1P4vPEAVGQ8mum+DLtPLHTxoj9l/4u6NUefecN3ldk
         IHMjdtw5hHyRGFNWhrog3KIwMukS2StdFoJCi5B3Wh6j+5WxDG4lNCzZfaGxcYW3h1oh
         DD5rtDiV7Zct+8h/Y4/l76PJFrVsNWdFDxjUIIEe00nQtrD3vx0aM9EQNYNQIvblH+CL
         ffP0adfrHDV9CZ5Dik4acH4nNfR4oIU223ukSPUyP7/uC1QQ+Wyj9LjyALFFtRlyYJET
         uyAA==
X-Gm-Message-State: ACgBeo15W3SZ1Tg4wpU0sqtVQqUeUA6fTTRbuTd4fUuCuS+C93yvVhc7
        WmJCImUTmW2uGvdb91QZp8yzTu1GAHYcVMwwiGkxnQ==
X-Google-Smtp-Source: AA6agR5o/BI5hIFitjoAA8GeVFQrA/Hf1t0B93XoID64kS4s2RWTTnHZFlYS56lDiYyaqqA3tqiPfDZbeTvqlHi5JxU=
X-Received: by 2002:a17:902:f681:b0:172:f8ee:b1f7 with SMTP id
 l1-20020a170902f68100b00172f8eeb1f7mr659020plg.19.1661459717768; Thu, 25 Aug
 2022 13:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220802230718.1891356-1-mizhang@google.com> <20220802230718.1891356-2-mizhang@google.com>
 <b03adf94-5af2-ff5e-1dbb-6dd212790083@redhat.com> <CAL715WLQa5yz7SWAfOBUzQigv2JG1Ao+rwbeSJ++rKccVoZeag@mail.gmail.com>
 <17505e309d02cf5a96e33f75ccdd6437a8c79222.camel@redhat.com>
 <Ywa+QL/kDp9ibkbC@google.com> <CALMp9eSZ-C4BSSm6c5HBayjEVBdEwTBFcOw37yrd014cRwKPug@mail.gmail.com>
 <YweJ+hX8Ayz11jZi@google.com> <CAL715WK4eqxX9EUHzwqT4o-OX4S_1-WcTr5UuGnc-KEb7pk6EQ@mail.gmail.com>
 <Ywe3IC7OlF/jYU1X@google.com>
In-Reply-To: <Ywe3IC7OlF/jYU1X@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Thu, 25 Aug 2022 13:35:06 -0700
Message-ID: <CAL715WJEkT6heVT1P2RZw_5NxBcORCrBTS60L_RZT-05zr_zsw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: Get vmcs12 pages before checking pending interrupts
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>
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

> There are two uses of KVM_REQ_GET_NESTED_STATE_PAGES:
>
>   1. Defer loads when leaving SMM.
>
>   2: Defer loads for KVM_SET_NESTED_STATE.
>
> #1 is fully solvable without a request, e.g. split ->leave_smm() into two helpers,
> one that restores whatever metadata is needed before restoring from SMRAM, and
> a second to load guest virtualization state that _after_ restoring all other guest
> state from SMRAM.
>
> #2 is done because of the reasons Jim listed above, which are specific to demand
> paging (including userfaultfd).  There might be some interactions with other
> ioctls() (KVM_SET_SREGS?) that are papered over by the request, but that can be
> solved without a full request since only the first KVM_RUN after KVM_SET_NESTED_STATE
> needs to refresh things (though ideally we'd avoid that).

Ack on the fact that the 2-step process is specific to demand paging.

Currently, KVM_SET_NESTED_STATE is a two-step process in which the 1st
step does not require vmcs12 to be ready. So, I am thinking about what
it means to deprecate KVM_REQ_GET_NESTED_STATE_PAGES?

For case #2, I think there might be two options if we deprecate it:

 - Ensuring vmcs12 ready during the call to
ioctl(KVM_SET_NESTED_STATE). This requires, as Jim mentioned, that the
thread who is listening to the remote page request ready to serve
before this call (this is true regardless of uffd based or Google base
demand paging). We definitely can solve this ordering problem, but
that is beyond KVM scope. It basically requires our userspace to
cooperate.

 - Ensuring vmcs12 ready before vmenter. This basically defers the
vmcs12 checks to the last second. I think this might be a better one.
However, isn't it the same as the original implementation, i.e.,
instead of using KVM_REQ_GET_NESTED_STATE_PAGES, we have to use some
other flags to tell KVM to load a vmcs12?

Thanks.
-Mingwei
>
> In other words, if the demand paging use case goes away, then KVM can get rid of
> KVM_REQ_GET_NESTED_STATE_PAGES.
>
> > KVM_SET_NESTED_STATE in VMX, while in SVM implementation, it is simply
> > just a kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
>
> svm_set_nested_state() very rougly open codes enter_svm_guest_mode().  VMX could
> do the same, but that may or may not be a net positive.
>
> > hmm... so is the nested_vmx_enter_non_root_mode() call in vmx
> > KVM_SET_NESTED_STATE ioctl() still necessary? I am thinking that
> > because the same function is called again in nested_vmx_run().
>
> nested_vmx_run() is used only to emulate VMLAUNCH/VMRESUME and wont' be invoked
> if the vCPU is already running L2 at the time of migration.

Ack.
