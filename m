Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8F57A5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiGSSAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiGSSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35FBB10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658253602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4H+rsOc5ri6cPvLLlf9mcdJzz04LpDxRf1qPLjyAxw=;
        b=DZUKWvUSvil+p5+ELO+YaAYY0hXCA+O4Lz9hgRdIktB7/HZPq840F16DMOlfs2glG08vxW
        KAIEMSSCTDCb2itXbVoOr1LI1mY3p92/2gwUNl6ISH+ksfqMOjxOhmp//uUrq2LsWwoo9o
        edPjw+UGyglNUCPU6ve/SS+9iJKFVzQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-nBLz61CAOYe_Ka-OFPL44w-1; Tue, 19 Jul 2022 14:00:01 -0400
X-MC-Unique: nBLz61CAOYe_Ka-OFPL44w-1
Received: by mail-ej1-f70.google.com with SMTP id gr1-20020a170906e2c100b006fefea3ec0aso3311184ejb.14
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X4H+rsOc5ri6cPvLLlf9mcdJzz04LpDxRf1qPLjyAxw=;
        b=bWFUTk+8htwt+UXGQ2uNHk8HWCEKY2saypX1eFSudQuOclqxgjZBELdXNo6ITCWpvw
         pwB2GekSoZxycdRVrYcShEYbCcyzMvKS/JyMxfmdyV6EUZTqo9gSGTQ7cpxb2U1SDC7a
         dzJ7SP8iT8uRIit2qEAO++tSFJj2MoC32ZVvZtea4Y3QvrLMoc04zQO01pcR0vrZeMDG
         mTYdLD/BMmx47gWPJgS7afwhY6yAsCE4chSxunrCQXBIubALhv6C3wZxUAYeH2zsrCjA
         WZ4Lal3xFBmgnWYVtzxYyyzF5dxgz+sS0JKZcoFdRaRew7qJEK6czzcRn+OtCm9GJ1dM
         kfbA==
X-Gm-Message-State: AJIora8QxzmNZlv6iuS1zN4UjHzZZbD2EGNyrEDTx2KpcVEBhPtoYcwz
        gunTtY5u476XtaVwnlwmqO5/NRE7mTmmVetIyWnhxvP8cd44pSRIwtyfRa8WfJJVKrqVwm9MIN5
        4f0QfhCgCuBMeDNr1RFzd09/f
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id ck1-20020a0564021c0100b0043af714bcbemr46166882edb.14.1658253599880;
        Tue, 19 Jul 2022 10:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1un05zRzTJUTELeW/WWmA1XHyE5sCWDP1etxSMwlooTC/29lJi02ohKW1/iSNGN93Lz9PLsbQ==
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id ck1-20020a0564021c0100b0043af714bcbemr46166862edb.14.1658253599682;
        Tue, 19 Jul 2022 10:59:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id c7-20020aa7df07000000b0043a7c24a669sm10771519edy.91.2022.07.19.10.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:59:59 -0700 (PDT)
Message-ID: <463eaa3a-6d1c-3282-6723-df285bbaa2d1@redhat.com>
Date:   Tue, 19 Jul 2022 19:59:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] KVM: x86/mmu: Memtype related cleanups
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715230016.3762909-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220715230016.3762909-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/22 01:00, Sean Christopherson wrote:
> Minor cleanups for KVM's handling of the memtype that's shoved into SPTEs.
> 
> Patch 1 enforces that entry '0' of the host's IA32_PAT is configured for WB
> memtype.  KVM subtle relies on this behavior (silently shoves '0' into the
> SPTE PAT field).  Check this at KVM load time so that if that doesn't hold
> true, KVM will refuse to load instead of running the guest with weird and
> potentially dangerous memtypes.
> 
> Patch 2 is a pure code cleanup (ordered after patch 1 in case someone wants
> to backport the PAT check).
> 
> Patch 3 add a mask to track whether or not KVM may use a non-zero memtype
> value in SPTEs.  Essentially, it's a "is EPT enabled" flag without being an
> explicit "is EPT enabled" flag.  This avoid some minor work when not using
> EPT, e.g. technically KVM could drop the RET0 implemention that's used for
> SVM's get_mt_mask(), but IMO that's an unnecessary risk.
> 
> Patch 4 modifies the TDP page fault path to restrict the mapping level
> based on guest MTRRs if and only if KVM might actually consume them.  The
> guest MTRRs are purely software constructs (not directly consumed by
> hardware), and KVM only honors them when EPT is enabled (host MTRRs are
> overridden by EPT) and the guest has non-coherent DMA.  I doubt this will
> move the needed on whether or not KVM can create huge pages, but it does
> save having to do MTRR lookups on every page fault for guests without
> a non-coherent DMA device attached.
> 
> Sean Christopherson (4):
>    KVM: x86: Reject loading KVM if host.PAT[0] != WB
>    KVM: x86: Drop unnecessary goto+label in kvm_arch_init()
>    KVM: x86/mmu: Add shadow mask for effective host MTRR memtype
>    KVM: x86/mmu: Restrict mapping level based on guest MTRR iff they're
>      used
> 
>   arch/x86/kvm/mmu/mmu.c  | 26 +++++++++++++++++++-------
>   arch/x86/kvm/mmu/spte.c | 21 ++++++++++++++++++---
>   arch/x86/kvm/mmu/spte.h |  1 +
>   arch/x86/kvm/x86.c      | 33 ++++++++++++++++++++-------------
>   4 files changed, 58 insertions(+), 23 deletions(-)
> 
> 
> base-commit: 8031d87aa9953ddeb047a5356ebd0b240c30f233

Queued, thanks.

Paolo

