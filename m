Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E685452ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbiFIR03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiFIR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:26:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044E2A26A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:26:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so21649439pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l1RuhhV6V3rfp5Bg8hx1s4i266VbTUWDrdyJUQ4dZ/s=;
        b=K/m8QIRv7PzfZ8gR37Iz3JTnF8ld3GeHoJ+AlQsO4o4ny8OmIyTH+saZtzNDu00ypt
         iL+jEyTxfiPvuy54Z/rgCKnf0Yhan0vb3U+hrpkPtvOL/w2QQdJ/nCRa008IGHM+ZNYo
         2FgeO3hIrQxGimQO/tFnhsQTsVV3Bk6AU5D1CKLoYFvxnAvMqk7qIgDv5mq7Q960ISPF
         iGonQgP4DZR5mY4g6oAXp3Rtnmacb1KUBPXXmfXkgUGiAOkqwiy/VhSjNbkynULYnqtt
         1BgYc6No+/RhgJGwVhpu5Z7uTCfDFaq4U0RRKJPqjcfP/uIyvvCn6BDOdjrKyhyIkUpv
         77FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1RuhhV6V3rfp5Bg8hx1s4i266VbTUWDrdyJUQ4dZ/s=;
        b=6Ga3+dmK4XzDli4+PVgjfbln7pcpNJPWidfpyElIQxD6KLuDEgcyaRxQCBTwkNt0c/
         vf1SO2aEY1D2KBrRPHncpHHZhmjm5peXjPcgVhDWLwREtAVvT6lCKpxCHKjbLxCAxsWJ
         NtZmORMwUsK7y29laZIXToT8M145HbN3IU8TxdaMaOrDnCtPAlZoPJqi2k75ZaG7uA2L
         hA8jlKZ5dA9i+Ca3i8XpYljKWDfTgx+Xw2/tvQ/LW9BIt8BeV6E52uum0d+8GbYbWDtc
         0XRY4thCTU6TFLvmF6HfK55K8eG1vbB7o2hvTEyYTpgpzctlbxjnNlLcQzbVBiFJ0R66
         hxsA==
X-Gm-Message-State: AOAM533k/qylcDhtX7Aaa4DCr6AKKCJH8AD1COhBjCQk8e0uSQ41WUYV
        y//qEov3o5uWBGRHppwr0mXFDQ==
X-Google-Smtp-Source: ABdhPJzhgeXbiz+ywNavrbxguD36Vhl0D4w/oHsd0RbaLIihA0Go1kYM5LbdRl1SJZDOasHJa/wasw==
X-Received: by 2002:a63:5:0:b0:3fe:2558:677 with SMTP id 5-20020a630005000000b003fe25580677mr9928929pga.113.1654795584274;
        Thu, 09 Jun 2022 10:26:24 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709029f9800b0015e8d4eb242sm17127418plq.140.2022.06.09.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:26:23 -0700 (PDT)
Date:   Thu, 9 Jun 2022 17:26:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Raghavendra Rao Ananta <rananta@google.com>,
        eric.auger@redhat.com
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <YqItO2cbsGDSyxD8@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <93b87b7b5a599c1dfa47ee025f0ae9c4@kernel.org>
 <YqEupumS/m5IArTj@google.com>
 <20220609074027.fntbvcgac4nroy35@gator>
 <YqIPYP0gKIoU7JLG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqIPYP0gKIoU7JLG@google.com>
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

On Thu, Jun 09, 2022, Sean Christopherson wrote:
> On Thu, Jun 09, 2022, Andrew Jones wrote:
> > On Wed, Jun 08, 2022 at 11:20:06PM +0000, Sean Christopherson wrote:
> > > diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > > index b3116c151d1c..17f7ef975d5c 100644
> > > --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > > +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > > @@ -419,7 +419,7 @@ static void run_test(struct vcpu_config *c)
> > > 
> > >         check_supported(c);
> > > 
> > > -       vm = vm_create_barebones();
> > > +       vm = vm_create(1);
> > 
> > Hmm, looks like something, somewhere for AArch64 needs improving to avoid
> > strangeness like this. I'll look into it after we get this series merged.
> 
> Huh, you're right, that is odd.  Ah, duh, aarch64_vcpu_add() allocates a stack
> for the vCPU, and that will fail if there's no memslot from which to allocate
> guest memory.
> 
> So, this is my goof in
> 
>   KVM: selftests: Rename vm_create() => vm_create_barebones(), drop param
> 
> get-reg-list should first be converted to vm_create_without_vcpus().  I'll also
> add a comment explaining that vm_create_barebones() can be used with __vm_vcpu_add(),
> but not the "full" vm_vcpu_add() or vm_arch_vcpu_add() variants.

Actually, I agree with your assessment.  A better solution is to open code the
calls to add and setup the vCPU.  It's a small amount of code duplication, but I
actually like the end result because it better documents the test's dependencies.

Assuming it actually works, i.e. the stack setup is truly unnecessary, I'll add a
patch like so before the barebones change.

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index ecfb773ec41e..7bba365b1522 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -418,7 +418,8 @@ static void run_test(struct vcpu_config *c)

        vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
        prepare_vcpu_init(c, &init);
-       aarch64_vcpu_add_default(vm, 0, &init, NULL);
+       vm_vcpu_add(vm, vcpuid);
+       aarch64_vcpu_setup(vm, 0, &init);
        finalize_vcpu(vm, 0, c);

        reg_list = vcpu_get_reg_list(vm, 0);

