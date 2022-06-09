Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49425444CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiFIH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiFIH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45FD01F4FD2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654759671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wii0zR07KfthhhOdHcY7fAYYXEPbr/dpqwRhIU0EtzU=;
        b=gUyLwVVS4vOD6uGZibKYTn1QpK5614oceZU1edpdvGtbrB7z0eJ/WK1k9QLZfOVACQW+el
        4E2h/J69/qta7mJq95EsJGj5mj6C0217wpRsxpi19EE/YSarvGpHIPS5bguLtDOqspZ9fx
        7rmXABurroBmgN4Lg6TxntY2UJzICV8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-jYQ3aPsnPlmCrnw4zS1I8w-1; Thu, 09 Jun 2022 03:27:50 -0400
X-MC-Unique: jYQ3aPsnPlmCrnw4zS1I8w-1
Received: by mail-wm1-f70.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so7928295wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wii0zR07KfthhhOdHcY7fAYYXEPbr/dpqwRhIU0EtzU=;
        b=gHBbD2Qypuj7XUCrArzBAuRkz4en2h5G0maXnMexumryVo3hjW65Ax2ojJVsqo6HoS
         YgH/9DGGBXdZ5vbhBvd9gsrT+3hCI5p3Jkhje2L+S1l1PCZasnF0jEktBCPJKd1rWVxm
         wwBRU3DVVHQ/CMJbkGMAxE/T/3EyAIccpG96Aovyx/c4TWHDk3OZIBHUMf0dYuqp90/G
         sWFfF8X5oqbj7FzfwA8oduOgDQ31UzHDW9RWBkpAzU5k0zw/SEf8mm0bEjYQmtztMcjj
         Q8Rs4nAjkybCJO8DUQhJk0pOT/JpdYibF06dJ4FHNyNrhzR/ETnQ/vUkQNC32uLVyggu
         u57A==
X-Gm-Message-State: AOAM5337l+iqDlcQF2JfOJKBmerMiTdoeFKvovrH0n0VaDCpP1wX/ccT
        W/aTDAl1HwPn65zkExY1TO/kgmdMaxKE/IcPqHBp08dWk3uwHk6+h3Jk6ChrucDgJz8G0/sCgps
        LXilAlYgu/w362BcaOF65mdvw
X-Received: by 2002:a05:600c:5021:b0:39c:6571:e0b0 with SMTP id n33-20020a05600c502100b0039c6571e0b0mr1876987wmr.177.1654759669115;
        Thu, 09 Jun 2022 00:27:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5ZXIHrCIXcJnhibfPD0CZh9Ngp8vvh/E5AiHEI7gYeWrse3XiPFktxnvKe0MJOZc1qhXZLw==
X-Received: by 2002:a05:600c:5021:b0:39c:6571:e0b0 with SMTP id n33-20020a05600c502100b0039c6571e0b0mr1876963wmr.177.1654759668924;
        Thu, 09 Jun 2022 00:27:48 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b002184a3a3641sm8459301wrs.100.2022.06.09.00.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:48 -0700 (PDT)
Date:   Thu, 9 Jun 2022 09:27:46 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 048/144] KVM: selftests: Rename 'struct vcpu' to
 'struct kvm_vcpu'
Message-ID: <20220609072746.op7ez4rmdn2wmynj@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-49-seanjc@google.com>
 <20220608151815.7mwlj3eppwmujaow@gator>
 <YqDH4m0TxLcK5Brw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDH4m0TxLcK5Brw@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:01:38PM +0000, Sean Christopherson wrote:
> On Wed, Jun 08, 2022, Andrew Jones wrote:
> > On Fri, Jun 03, 2022 at 12:41:55AM +0000, Sean Christopherson wrote:
> > > Rename 'struct vcpu' to 'struct kvm_vcpu' to align with 'struct kvm_vm'
> > > in the selftest, and to give readers a hint that the struct is specific
> > > to KVM.
> > 
> > I'm not completely sold on this change. I don't mind that the selftest
> > vcpu struct isn't named the same as the KVM vcpu struct, since they're
> > different structs.
> 
> I don't care about about matching KVM's internal naming exactly, but I do care
> about not having a bare "vcpu", it makes searching for usage a pain because it's
> impossible to differentiate between instances of the struct and variables of the
> same name without additional qualifiers.
> 
> > I also don't mind avoiding 'kvm_' prefixes in "KVM selftests" (indeed I
> > wonder if we really need the kvm_ prefix for the vm struct).
> 
> Same as above, "struct vm *vm" will drive me bonkers :-)

Yes, that is a good point.

> 
> > If we do need prefixes for the kvm selftest framework code to avoid
> > collisions with test code, then maybe we should invent something else, rather
> > than use the somewhat ambiguous 'kvm', which could also collide with stuff in
> > the kvm uapi.
> 
> Potential collisions with the KVM uAPI is a feature of sorts, e.g. tests shouldn't
> be redefining kvm_* structures (I'd prefer _tests_ not use kvm_* at all, and only
> use kvm_* in the library), and I gotta imagine KVM would break at least one real
> world userspace if it defined "kvm_vcpu".
> 
> That said, I don't have a super strong preference for kvm_ versus something else,
> though I think it will be difficult to come up with something that's unique,
> intuitive, and doesn't look like a typo.
>

Maybe just abbreviated "Kvm Selftests", i.e. 'ks_'? I won't harp on this
any longer though, so if that doesn't look good, then we can proceed with
'kvm_'.

Thanks,
drew

