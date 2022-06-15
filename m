Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE58654C4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348273AbiFOJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348204AbiFOJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B2003A181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655285821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dNw/R51TWM4Lx/vPA0cEiIg3iaOBbrHMuRKSdvNKOs8=;
        b=GT5zZUWvkDKUg4mSLKbpi41KUtNhp+iFWiIG4fLYLjH28y90wUY3Ui+prPylaFPPVKl+L0
        wXRa1TS2i5mc/7FQgg+jYYDOD8kBUxbjEqXqm6yC/HHHD3uN03+MEqZD8UQ2J7AvRWdHK6
        aOyVTPsxvrRTBKjRm6bGpPmMa64mmA8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-IXrBLdLpMyWYS5AV6sqTVA-1; Wed, 15 Jun 2022 05:36:59 -0400
X-MC-Unique: IXrBLdLpMyWYS5AV6sqTVA-1
Received: by mail-wr1-f72.google.com with SMTP id m18-20020adff392000000b0021848a78a53so1685344wro.19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dNw/R51TWM4Lx/vPA0cEiIg3iaOBbrHMuRKSdvNKOs8=;
        b=c1wGKQdmu4AZG4jj6bI2magj3SO4WtE1rJYLBnrFMyRyb4MkkVzfa4xBDN6kmEWoFX
         2sqVqlpp42i0NNZIArhKo776zwkrjTzUDnxTE3GMETgrY/F231oxBAH39CHprAfYlflc
         sBYNHQF27YjiYvmiIxSFFh9TeXj2kSe6z459cTbtjSxEukJzjSaaQwzwef5B4vN9KSrs
         cMYFzIOrrM+cxN/5CTey2EC3/fQ7Gq/FrY+DMNBxeMLWy3/HFmREqHyMom+imwALkQ6I
         ySG5LTiTlEH4VeaiiGpqXQCioJFmzrYd9YfQC6tIBvYCScp3zuyU4J2ORUe/deHjZ4zG
         Rb1g==
X-Gm-Message-State: AJIora+gIXvlZ4U8CXujgMODX9DFrGy9LLdCxCUfyHSouw9MnFFgPd+k
        56lvo1sDEpBb+NCHrB9ujRdHsa5fv1x4MGF0MnocB4VjYYbAwrydSpadeU0yquxWQx6uj8DuyZc
        S7y6UWHIR/FXZnRfczXK1HoIX
X-Received: by 2002:a05:6000:156c:b0:218:5f5d:9c61 with SMTP id 12-20020a056000156c00b002185f5d9c61mr9197821wrz.134.1655285818373;
        Wed, 15 Jun 2022 02:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssl/jJYq81qq2KZOEAIQfXCR1k7dMbwfxJo3LlKFMzxbwAQ8XqzUsy+dnHpmNnbov1a/rtAQ==
X-Received: by 2002:a05:6000:156c:b0:218:5f5d:9c61 with SMTP id 12-20020a056000156c00b002185f5d9c61mr9197809wrz.134.1655285818176;
        Wed, 15 Jun 2022 02:36:58 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003942a244f51sm1682638wmq.42.2022.06.15.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:36:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     mail@anirudhrb.com, kumarpraveen@linux.microsoft.com,
        wei.liu@kernel.org, robert.bradford@intel.com, liuwe@microsoft.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ilias Stamatis <ilstam@amazon.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't expose TSC scaling to L1 when on Hyper-V
In-Reply-To: <Yqmf5UGbNKyGz3dD@anrayabh-desk>
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
 <87sfo7igis.fsf@redhat.com>
 <eaefdea0-0ca3-93f1-a815-03900055fdcd@redhat.com>
 <Yqmf5UGbNKyGz3dD@anrayabh-desk>
Date:   Wed, 15 Jun 2022 11:36:56 +0200
Message-ID: <87mteei7yf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anirudh Rayabharam <anrayabh@linux.microsoft.com> writes:

> On Tue, Jun 14, 2022 at 07:20:34PM +0200, Paolo Bonzini wrote:
>> On 6/14/22 14:19, Vitaly Kuznetsov wrote:
>> > The latest version:
>> > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vmx_enlightened_vmcs
>> > 
>> > has it, actually. It was missing before (compare with e.g. 6.0b version
>> > here:
>> > https://github.com/MicrosoftDocs/Virtualization-Documentation/raw/live/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf)
>> > 
>> > but AFAIR TSC scaling wasn't advertised by genuine Hyper-V either.
>> > Interestingly enough, eVMCS version didn't change when these fields were
>> > added, it is still '1'.
>> > 
>> > I even have a patch in my stash (attached). I didn't send it out because
>> > it wasn't properly tested with different Hyper-V versions.
>> > 
>> > -- Vitaly
>> 
>> Anirudh, can you check if Vitaly's patches work for you?
>
> I will check it. But I wonder if they fit the criteria for inclusion in
> stable trees...
>
> It is important for the fix to land in the stable trees since this issue
> is a regression that was introduced _after_ 5.13. (I probably should've
> mentioned this in the changelog.)
>

Personally, I see no problem with splitting off TscMultiplier part from
my patch and marking it for stable@ fixing d041b5ea93352. I'm going to
run some tests too.

-- 
Vitaly

