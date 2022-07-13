Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAFC572F74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiGMHpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiGMHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E33AECC7B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657698306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OeJ+iFREKEPDGzZIidEw0qYmCZVogFXpaPgElmJEdn4=;
        b=Q3bidCWhVnCNoblXxC5POphG+9H2xaTaIEdrQTOuZvoSKS/iFgym1WkJHxDBIY/ro0X+Sg
        2TAuxmRerJTlpp93uihGD4Aw4VchPN71YXL4eOxjrj4bb2mRlfOboAa9mFBKMKj/uHLjJG
        caLDZU9zSZDNE/3cSDqTnOxOMqKiJFQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-PEH9Gn3lPNGTIfk0sXQkCQ-1; Wed, 13 Jul 2022 03:45:01 -0400
X-MC-Unique: PEH9Gn3lPNGTIfk0sXQkCQ-1
Received: by mail-ed1-f71.google.com with SMTP id j6-20020a05640211c600b0043a8ea2c138so7768382edw.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OeJ+iFREKEPDGzZIidEw0qYmCZVogFXpaPgElmJEdn4=;
        b=oIL6mmgRY5EJLX1fFVzGuHSt/BhTwrt75ET9DrZsLt4s+f30POuQqztY+Shq9A9FNa
         Q86owHE7FVbb9EuPM3WtzF7Hx3mjEe68oFlqF1f8b78aZFS5fMJPARDUM1lt/WgFQ83j
         X0WrQrye8/bOxTOv5R2ayhqLOYe5oAGXyCseMfFQnNTMb4VUbM2IakPIFC6I1JnnUvWp
         ARYpmHETrvXfIRnzaPuPq2YFq/l0AV6rudUmSeDxDd/p5oDL82jnTVeAu8Tm4l9v7hPT
         INq7kRYPH2wGE/L68LINeDiAvxlwnFROywG6t3d1A6MrHhB+wNbAjHGlFhH3xb4G5eZ5
         EHVw==
X-Gm-Message-State: AJIora/j5fsweK5rj9W/SFxVpp3zz2lRCBxbpAzlg7dx/3bxGKWblB5F
        El1x/EumICClNBoWBbMWCYI/gYc52KblKXRYXlxgunh+Pq5qCBjoHkOYswQ/H0KVaLOi3pleZoE
        3ix7JHAYJ1kWc6Vxie8ybVPye
X-Received: by 2002:a17:907:2723:b0:72b:5af3:5a11 with SMTP id d3-20020a170907272300b0072b5af35a11mr2069776ejl.584.1657698300816;
        Wed, 13 Jul 2022 00:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u0i5rjFfrpSqjEmGzpTqwuvm4Y57W/o6n5JXE6u+yShz8Ylot177o6FwB5C48121akrJRf7Q==
X-Received: by 2002:a17:907:2723:b0:72b:5af3:5a11 with SMTP id d3-20020a170907272300b0072b5af35a11mr2069757ejl.584.1657698300651;
        Wed, 13 Jul 2022 00:45:00 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e24-20020a50ec98000000b0043a6a7048absm7339793edr.95.2022.07.13.00.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:45:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: nVMX: Always enable TSC scaling for L2 when it was
 enabled for L1
In-Reply-To: <ed923f16-86a7-1f87-f192-c935371dc48c@oracle.com>
References: <20220712135009.952805-1-vkuznets@redhat.com>
 <ed923f16-86a7-1f87-f192-c935371dc48c@oracle.com>
Date:   Wed, 13 Jul 2022 09:44:59 +0200
Message-ID: <87y1wxo3r8.fsf@redhat.com>
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

Dongli Zhang <dongli.zhang@oracle.com> writes:

> Hi Vitaly,
>
> On 7/12/22 6:50 AM, Vitaly Kuznetsov wrote:
>> Windows 10/11 guests with Hyper-V role (WSL2) enabled are observed to
>> hang upon boot or shortly after when a non-default TSC frequency was
>> set for L1. The issue is observed on a host where TSC scaling is
>
> Would you mind helping clarify if it is L1 or L2 that hangs?
>
> The commit message "Windows 10/11 guests with Hyper-V role (WSL2)" confuses me
> if it is L1 or L2 (perhaps due to my lack of knowledge on hyper-v) that hangs.
>

I think it's L2 but I'm not sure: there's no easy way to interract with
L1 (Hyper-V) directly, all the interfaces (UI, network,..) are handled
by L2 (Windows). Prior to the observed 'hang' Hyper-V (L1) programms
synthetic timer in KVM too far in the future but my guess is that it's
doing that on Windows' (L2) behalf, basically just relaying the
request. The issue only shows up with 'hv-reenlightenment' +
'hv-frequencies' (in QEMU's terms) features as in this case both Hyper-V
(L1) and Windows (L2) trust the information about TSC frequency from KVM
but the information turns out to be incorrect for Windows (L2).

-- 
Vitaly

