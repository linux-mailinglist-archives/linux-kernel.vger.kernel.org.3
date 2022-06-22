Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2E5551B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376679AbiFVQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376969AbiFVQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A39E240E6C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655916534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TsYvcK94CLyN19FcLWL9j2fJcEng9VRlusxpm2EaQ78=;
        b=WAe5WC8Ss0uGQ529/aXFS/VwS1vkNREv/X6kwDsbFKlRKsROwKTSMZHtkndbvwbE89d3YY
        DXxdKylfX601q9RId79wkPkLS51ITwd/o4VIgCPIjPfaX5FcipfMHlWQunPBavzb/O31y2
        c8dMS7kuPTbEcgmWc6RLWyzVrPseE9Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-JHkSljF_Ow-FMzSp83KpYA-1; Wed, 22 Jun 2022 12:48:53 -0400
X-MC-Unique: JHkSljF_Ow-FMzSp83KpYA-1
Received: by mail-wm1-f69.google.com with SMTP id 2-20020a1c0202000000b0039c94528746so88079wmc.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TsYvcK94CLyN19FcLWL9j2fJcEng9VRlusxpm2EaQ78=;
        b=O1MJrGlkcvA+3lX8qQRZq/9jYZ3Y82vJcXzrqlL885V04GxokQcxvD9vpceMod0x6m
         ZJbnW2xaNHIaVwtoy5GownhQTyBndD0Fq+wOd56mW//qlPiyqNTWrJpoht8K45prUfIM
         VWsY6JDIGyvMsc0t0wFCzbM7+GjbxIrm7UUyOKnycOKdqwa8STp9C2P/I+2rir9f+UPX
         AIU8FwRpUMVucj2PRoqI50UQZQkWYCRAz/Up/O1wsInW4P82NWWEriidimBAzaaLowr4
         7Nzb+CR5sI9nfTvyQqbdbpVZWw90AZH56bpmAmPO4QYIfSFIxPHekiF+27XHdFhWF8d+
         caWQ==
X-Gm-Message-State: AJIora+io14v2UQCfDObKSofk3ctXUMYk+avR3SAql4lJ7AKyMi/We0M
        s2zba+2VpRlVzHJYqB4ANdgFgqtyezDXwZMmJ3oKV74P7rFAt+opcMEP6/4AIf/nW3lojz4WoMG
        nToOJUwd1MSY+cJcX6YUhzK6pTLL6qwQMyB1KkEcqRorY2QJmEwheh6RUxLT1suAm2X+nvMTb9u
        BP
X-Received: by 2002:a5d:5c07:0:b0:218:544d:4347 with SMTP id cc7-20020a5d5c07000000b00218544d4347mr4097204wrb.107.1655916532400;
        Wed, 22 Jun 2022 09:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tD1Omp9j7WboyJvnAdKjQwHzBIA8+iFDuEPk56mpyiXFlUxOwd48frZ+hMc7f+XKqs0+sxRQ==
X-Received: by 2002:a5d:5c07:0:b0:218:544d:4347 with SMTP id cc7-20020a5d5c07000000b00218544d4347mr4097165wrb.107.1655916532057;
        Wed, 22 Jun 2022 09:48:52 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d50ce000000b0021b9a4a75e2sm5100297wrt.30.2022.06.22.09.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:48:51 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ilias Stamatis <ilstam@amazon.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, mail@anirudhrb.com,
        kumarpraveen@linux.microsoft.com, wei.liu@kernel.org,
        robert.bradford@intel.com, liuwe@microsoft.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Don't expose TSC scaling to L1 when on Hyper-V
In-Reply-To: <YrNBHFLzAgcsw19O@anrayabh-desk>
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
 <592ab920-51f3-4794-331f-8737e1f5b20a@redhat.com>
 <YqdsjW4/zsYaJahf@google.com> <YqipLpHI24NdhgJO@anrayabh-desk>
 <YqiwoOP4HX2LniI4@google.com> <87zgi5xh42.fsf@redhat.com>
 <YrMenI1mTbqA9MaR@anrayabh-desk> <87r13gyde8.fsf@redhat.com>
 <YrNBHFLzAgcsw19O@anrayabh-desk>
Date:   Wed, 22 Jun 2022 18:48:50 +0200
Message-ID: <87k098y77x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anirudh Rayabharam <anrayabh@linux.microsoft.com> writes:

> On Wed, Jun 22, 2022 at 04:35:27PM +0200, Vitaly Kuznetsov wrote:

...

>> 
>> I've tried to pick it up but it's actually much harder than I think. The
>> patch has some minor issues ('&vmcs_config.nested' needs to be switched
>> to '&vmcs_conf->nested' in nested_vmx_setup_ctls_msrs()), but the main
>> problem is that the set of controls nested_vmx_setup_ctls_msrs() needs
>> is NOT a subset of vmcs_config (setup_vmcs_config()). I was able to
>> identify at least:

...

I've jsut sent "[PATCH RFC v1 00/10] KVM: nVMX: Use vmcs_config for
setting up nested VMX MSRs" which implements Sean's suggestion. Hope
this is the way to go for mainline.

>
> How about we do something simple like the patch below to start with?
> This will easily apply to stable and we can continue improving upon
> it with follow up patches on mainline.
>

Personally, I'm not against this for @stable. Alternatively, in case the
only observed issue is with TSC scaling, we can add support for it for
KVM-on-Hyper-V but not for Hyper-V-on-KVM (a small subset of "[PATCH
00/11] KVM: VMX: Support TscScaling and EnclsExitingBitmap whith
eVMCS"). I can prepare patches if needed.

-- 
Vitaly

