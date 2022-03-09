Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48964D3591
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiCIRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiCIRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:02:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99973192C96
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:50:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso1853609wmr.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZgHou8MqoXhRtzbJoo/yhan8iXTUzQE6PBiS2FKYRVk=;
        b=ApCIZr+MN6aee2cgqpPw+PV2CFMmrVy6Tba9Ix98g0JMbS/aPhT2nRYGytV5+Ew1dK
         z0tHBjwNiHk8ULLoDS6I4IZtOD1vgXLJ6jKahOF+IevRmjrWjq4mt6e2HLiiL22auFD7
         MnRfKwypFDEgPWQJnHfOysoynPTsTdtaTl0uYlV7qZCkg7zwXRBiAvgulaFHIPHCW0x5
         Hnuu1IVwWai8BPnp6D9ccORnN9fLNaPf57yibDLFRvp1pBm3n06ltkKX9Je5tohqyKmH
         OCBB1atg/D7hEWIqw31e2vKDb8speQ438g9RZRyONaVt0go3FMRBOFD7EDZjPJEfAe+j
         YQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgHou8MqoXhRtzbJoo/yhan8iXTUzQE6PBiS2FKYRVk=;
        b=1YVNKkZVL1RiUD/d9Mk5HCkB3CcXUS1oPF+6Fnq2MFg9J9UPGZIrqT83nY6LooY+Yr
         TE04FZvznh514Kgmz4oCIWH4+tW00K3OIr7Odo/yBEokv5cnyFkAG8uDXHV/3dzmSi++
         WscuEshIN221ptPL0AwqUT3xKa9SrMoBw8RXHoDEEfzhHKSeEWtAnlF8wyL7fs479Xpy
         GyFqTm+TvdjAD2vnGsPVpJ49iApNldMOnO9VYVjf8UOst7XPZ7zjhMUyabLLaXlmFUAY
         KvsCyVhtNEe11aGOu3UTokMjUq1C6BTtZoLxt1wC81Vi3YYSL7ke+JQBoye7dcOvUOBl
         cRZQ==
X-Gm-Message-State: AOAM5314EcS3mWIKt/VCfjQA7fOUTHJOy8N+bEk18fcwd4wwxbPEilo5
        JWlaKG6F96SiHEntGSDa8n6mrw==
X-Google-Smtp-Source: ABdhPJxsfLI0wVXG0HYqp8aGshE147e4FbNfGYA0n96plE+EG/lqB6ihUwJsiKwXUPa03ZDRH3qAhA==
X-Received: by 2002:a05:600c:3b1c:b0:389:8677:6c73 with SMTP id m28-20020a05600c3b1c00b0038986776c73mr210606wms.192.1646844648795;
        Wed, 09 Mar 2022 08:50:48 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:24bb:c5c7:5788:287d])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm5972989wmj.5.2022.03.09.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:50:48 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:50:45 +0000
From:   Quentin Perret <qperret@google.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Scull <ascull@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
Message-ID: <Yija5cY6j/B25Psw@google.com>
References: <20220307184935.1704614-1-kaleshsingh@google.com>
 <20220307184935.1704614-2-kaleshsingh@google.com>
 <CAE-0n52LmVRkrSNN=eJf+TYYnmesVjFv99nnetYvRWshm82rOg@mail.gmail.com>
 <CAC_TJvc6LYp95BXQc0DSBBBAZpYpixa+NyHKMLFWsBADD5Ubhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvc6LYp95BXQc0DSBBBAZpYpixa+NyHKMLFWsBADD5Ubhg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 Mar 2022 at 15:09:18 (-0800), Kalesh Singh wrote:
> On Tue, Mar 8, 2022 at 12:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > It looks odd to use an error pointer casted to unsigned long to return
> > from an address allocation function. Why not pass a pointer for base
> > like the function was written before and return an int from this
> > function with 0 for success and negative error value?Otherwise some
> > sort of define should made like DMA_MAPPING_ERROR and that can be used
> > to indicate to the caller that the allocation failed, or a simple zero
> > may work?
> 
> I wanted to keep consistent between the pkvm and traditional nvhe
> code. I will refactor both *alloc_private_va_range() functions to take
> a pointer and return an int error if that's preferred. There would
> still be a case of this kind of cast in
> __pkvm_create_private_mapping() which does return an unsigned long
> address or ERR_PTR(...). It looks like it was made to return the
> address to facilitate use as a hypercall (@Quentin CMIW).

Yep, passing everything by value was much easier to cross the EL1/EL2
boundary as that avoids having the hypervisor map kernel memory and all
that fun. But Stephen's point is fair, so no objection from to keep this
little dance confined to the hypercall wrapper and make the function
signature nicer and easier to use for the rest of the code.

Cheers,
Quentin
