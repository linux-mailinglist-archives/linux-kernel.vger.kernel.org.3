Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45B34CAB7E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243776AbiCBRZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiCBRZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:25:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC3CA31A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:25:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk29so3903028wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bz7qotst5wZ2RH1Ycd9IIg729giMypmnjudyWeu+UwU=;
        b=lvmC6OwysBVJcR6sJCUrR+wOrgbPj+ANTmN1KXU72r/93w/a8+Hdqgb8MfLsG43iYE
         zYMxmv0GrzTjXS2FAs2VhCWlRf5n+pYIN590AcBgJ36WqobqzS6erQN+QMF2T+8TDk33
         DPCZ7tKakr8buBALDa2Iv8OIsfNJbvTneuAs7N5W9Rex4CrI4onp2LZYLTghetUf4JCc
         tR/VEWRSHJwl243How9otm9mr2PKSNztegqbAjdO5gWLxDRvIXKUZnCP2HdYtIdflf/g
         Cmffy3GqwRa/C+Ycx0agEajPx9vlD3SIWg6+9NoAkyTlAE+ItKPy3tly4uLagG267KHe
         xupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bz7qotst5wZ2RH1Ycd9IIg729giMypmnjudyWeu+UwU=;
        b=UU/tDsiBjKP2Lu42FEuyIXeaHREW4/DAq6kh1sVYD1kWAHKd1tZ+M1lgWYZjXJwQgc
         pXe7Dc7uVCwCZnd53UMssL28X8RfJl5orcZzkcZ/GyyTMGnp3VtrLFkJgBTu8oANS/Zz
         IWH+AUg/WuNAKlUlMsA2htAjV+0NoCPOqPCqh5jZ+Qaak6bb7kO6UumB4uQ6WOPCOEJ+
         5vBVyKK0WLHLx+yfPKuxzGgy6/dSIUrV8ZjP0Z/PXFCB+VrN4krNCpvVZc/ooLoiPTDd
         p4XGsdZ8L8H2/89kUbALuIwdBbzCpDAnRV9uL2w5RmeyKRaKPRAa9gWdlos3Dhug14Xo
         REWw==
X-Gm-Message-State: AOAM531SOSb996h54XxZNaoZE/nGbHU8lEBUQIK6pm7RWxBaeC5XvuJM
        K2XeLMEF14uimxkyPzvRnkSX8+4Niy1V7yCRlQjVdg==
X-Google-Smtp-Source: ABdhPJyvAVYsK6bS1ULRzdVEwTranzJPFva6nkK9r8cZMojwnXMSs7MamfTIXIP3rnb2zflw1aKln/RKLG3YyPjdHWc=
X-Received: by 2002:adf:ca08:0:b0:1ed:c0bc:c212 with SMTP id
 o8-20020adfca08000000b001edc0bcc212mr23553444wrh.577.1646241904615; Wed, 02
 Mar 2022 09:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
 <20220225033548.1912117-3-kaleshsingh@google.com> <87v8ww6bl0.wl-maz@kernel.org>
In-Reply-To: <87v8ww6bl0.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 2 Mar 2022 09:24:53 -0800
Message-ID: <CAC_TJvfTZP9+EKFFXQUeGOWJb=WK2Wkd53bPOX2gaz0Gh5o8OA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] KVM: arm64: Introduce pkvm_alloc_private_va_range()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:46 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 25 Feb 2022 03:34:47 +0000,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > pkvm_hyp_alloc_private_va_range() can be used to reserve private VA ranges
> > in the pKVM nVHE hypervisor (). Also update __pkvm_create_private_mapping()
> > to allow specifying an alignment for the private VA mapping.
> >
> > These will be used to implement stack guard pages for pKVM nVHE hypervisor
> > (in a subsequent patch in the series).
> >
> > Credits to Quentin Perret <qperret@google.com> for the idea of moving
> > private VA allocation out of __pkvm_create_private_mapping()
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v4:
> >   - Handle null ptr in pkvm_alloc_private_va_range() and replace
> >     IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
> >   - Fix kernel-doc comments format, per Fuad
> >   - Format __pkvm_create_private_mapping() prototype args (< 80 col), per Fuad
> >
> > Changes in v3:
> >   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
> >
> > Changes in v2:
> >   - Allow specifying an alignment for the private VA allocations, per Marc
>
> I probably badly expressed my earlier concern.
>
> Yes, an alignment is necessary. But how often do we want an alignment
> that isn't naturally aligned to the size of the allocation (i.e. the
> power of 2 >= the size of the allocation)? This is what the rest of
> the kernel does (get_order() and co), and I thing we should follow
> this.

Hi Marc,

Thanks for clarifying. I think making the alignment implicitly based
on the size here will create unnecessary holes where PAGE_SIZE
alignment would be ok and potentially overflow the private VA space
earlier. Is it not a concern?

- Kalesh
>
> This applies to both this patch and the previous one.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
