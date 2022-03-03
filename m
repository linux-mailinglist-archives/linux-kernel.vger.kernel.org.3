Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769244CC43A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiCCRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiCCRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:46:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671B2FFE0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:46:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x15so8977829wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVrdfQqHlQRP17iPWD96K5pPQc2M9YlWOrUbW8e69bs=;
        b=YIA+zL+kU0ofCJmfw4aARQaZOj9MfhEDi0pzl1d8NoGqLgiDmPKkfVmoOXJlM6uFVF
         ceTNTFW/japJNqxiYw+3IweAwAAk5ZZYZYuINGB3MzB9K/9V+gJ87mCQzQoZRN25096m
         yfgGeZdhYM1jqlSZKJ5xY8+GKNauKY0pvK+OU6WKDq9BcHkV9pd9jbPkqVTwMWJVfnM0
         jg44WFBfWkmBJHKuI4isL1Spq+CjW97hvqK7xNum7H04Zx8JQ0XKhwckVB4uxgrbr0SD
         gMdUABbEkb3XyE5G7ltokcgEJZA4QDZ8sSITsFLGGbI8F2gclRd3nn3CWma9S2e8uu8P
         UHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVrdfQqHlQRP17iPWD96K5pPQc2M9YlWOrUbW8e69bs=;
        b=tqE6XyFY3y6dD5lY7LX3R3DygTAfpfXu052LcHfZ6Om0XvTD1Qn2cbbLzCJTmXz6Lv
         b8Bv/A29dY9WGLCkV1fwZxzOwOgzifw7Mxrhfa5oNPjyeWvKCcYnmA7TT6SoNnly6Ajk
         frJK9f8AlYTkwbfsOoj/w0iCd72QsuAuW9r6aLDkgu9ELPgegSpSR3XxivimUNJGq2hz
         fdNlw5Xbs1uiyfLC0dZ5642gZEugOzQbltHRq2ZnTJGikLkUOtfa12ELqIdChwvIBWAJ
         P3ePv1IoNDLTQQFG0nlUDioAvn5gkeAE/Thhul1sv4cBbCwu3mWjmE/HcX4lhvWCbvsQ
         OgYQ==
X-Gm-Message-State: AOAM530P2lPc9etdu/ae0/1ZK55CMYIY4a/h6RutOa3g8egdevbfJlwv
        X3LhInKg7f6YpMt4nci/a1JoV2/NhSbBlcaNjw+KBA==
X-Google-Smtp-Source: ABdhPJwzr4xFCzbsMj9ho2v2/HHIFz7d8+4DPwLZfPz9RmdehzhMeXAuERztFCAYQF/MCAcmbdp3Dc2Vb4kn4Om4ePM=
X-Received: by 2002:a5d:4c83:0:b0:1ed:e255:2c5 with SMTP id
 z3-20020a5d4c83000000b001ede25502c5mr27290854wrs.649.1646329562968; Thu, 03
 Mar 2022 09:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
 <20220225033548.1912117-3-kaleshsingh@google.com> <87v8ww6bl0.wl-maz@kernel.org>
 <CAC_TJvfTZP9+EKFFXQUeGOWJb=WK2Wkd53bPOX2gaz0Gh5o8OA@mail.gmail.com> <87r17j0wsi.wl-maz@kernel.org>
In-Reply-To: <87r17j0wsi.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 3 Mar 2022 09:45:51 -0800
Message-ID: <CAC_TJvcA8F1x_ynYco9wXeVguOW+OmTB7Z0J-8ES4wVPMxMyFg@mail.gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 9:29 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Kalesh,
>
> On Wed, 02 Mar 2022 17:24:53 +0000,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > On Tue, Mar 1, 2022 at 11:46 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Fri, 25 Feb 2022 03:34:47 +0000,
> > > Kalesh Singh <kaleshsingh@google.com> wrote:
> > > >
> > > > pkvm_hyp_alloc_private_va_range() can be used to reserve private VA ranges
> > > > in the pKVM nVHE hypervisor (). Also update __pkvm_create_private_mapping()
> > > > to allow specifying an alignment for the private VA mapping.
> > > >
> > > > These will be used to implement stack guard pages for pKVM nVHE hypervisor
> > > > (in a subsequent patch in the series).
> > > >
> > > > Credits to Quentin Perret <qperret@google.com> for the idea of moving
> > > > private VA allocation out of __pkvm_create_private_mapping()
> > > >
> > > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > > ---
> > > >
> > > > Changes in v4:
> > > >   - Handle null ptr in pkvm_alloc_private_va_range() and replace
> > > >     IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
> > > >   - Fix kernel-doc comments format, per Fuad
> > > >   - Format __pkvm_create_private_mapping() prototype args (< 80 col), per Fuad
> > > >
> > > > Changes in v3:
> > > >   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
> > > >
> > > > Changes in v2:
> > > >   - Allow specifying an alignment for the private VA allocations, per Marc
> > >
> > > I probably badly expressed my earlier concern.
> > >
> > > Yes, an alignment is necessary. But how often do we want an alignment
> > > that isn't naturally aligned to the size of the allocation (i.e. the
> > > power of 2 >= the size of the allocation)? This is what the rest of
> > > the kernel does (get_order() and co), and I thing we should follow
> > > this.
> >
> > Hi Marc,
> >
> > Thanks for clarifying. I think making the alignment implicitly based
> > on the size here will create unnecessary holes where PAGE_SIZE
> > alignment would be ok and potentially overflow the private VA space
> > earlier. Is it not a concern?
>
> I don't think we should worry too much about this. Even when building
> the kernel with a very small VA space (commonly 39 bits), we still
> have a quarter of that reserved for private EL2 mappings. That's
> pretty big.
>
> We will use a bit more of the memory that is set aside for EL2 page
> tables, but this shouldn't be a problem either.

Hi Marc,

Thanks for the explanations. I'll update as suggested in the next version.

- Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
