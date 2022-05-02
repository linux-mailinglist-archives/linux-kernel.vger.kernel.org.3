Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA651752A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbiEBQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiEBQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:58:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B06273
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:54:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 4so19034145ljw.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuwSXDS47usg98UbOCK/I9oPEzbY53h2cc8iNFbvNdQ=;
        b=aMhh8jxi4MJNkWjHLMMsq21pu+OlopMpNWh/ZkcBXDP72LSQ4XoW3ys9Aid/fsiFyo
         6f33+KLowYyiwr5MPmEx92h34cmNTRYgDAIVeUP2R88OpMo9h8QovxDHFK3K2MgcpUKz
         ozK4fCy0XFBENiG1s2ch0aKV/O5ZaTi/x/rf3Gu3d/Ty0zraKgMEMbwQcDjlCH+O5H5M
         jNvG/4k8zJtPPOkFF25ROWlzpr84s1xlORhrOMkw2L/V/mYnL6wRS4MiqeHULVlFyJ/P
         5XgedszkbvcnOnkQ/YO2on9T3IYpk0esfVTWBj0ne3SrkozSH0e7Ug//kG0aP0qbR925
         4x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuwSXDS47usg98UbOCK/I9oPEzbY53h2cc8iNFbvNdQ=;
        b=E+ff8O4vgVkdCmGiCGu0eSpjv0w4JBH513jJH8o9kyh0P7LJWUfO/WlWEry8yvtkPD
         rkpv6jITGLiAf+vh+ggdJTunx0ho9eJelZoJOVq9CFwYQ/xJdfAWqhzJplAdgDZ8CWYl
         Tx25s/JVuZ8xOj6zaK+gpzL3HfmTxQFpR2mZHAahmA5cj0H15ert/Ah2G+4vl0z/5XXx
         IUsHchAA8q3zyS9pVWrs3pQVM1Bl7ZRKqzmY66PghTOAGZ/4WiQzwyRzNly/XV2kPFlv
         4HpeHe6mOdFTZ8ww64I9htAY3fx/R3A9L1AXpf1xEwIGs0azGsuDe9YDGPfH7/8Pv6//
         7QEQ==
X-Gm-Message-State: AOAM530U0F6WRZFuG/euz0MAGehNgC4ZJeCzAkHMo/3vsqgHfYG7ctQZ
        1hx/GduDDi3DvkadXwaszSZ0PcHlSDxZ/j/b8+HZag==
X-Google-Smtp-Source: ABdhPJxidiAuNREg4SBCMW3M8snJ5Qcx2YyO7ESaLOxRuKvXGNp4UO7ALmr+WQsQqrydLCtL70Bgahl47Xz4JvKAbVg=
X-Received: by 2002:a05:651c:104f:b0:24f:3fc4:1892 with SMTP id
 x15-20020a05651c104f00b0024f3fc41892mr8053610ljm.399.1651510497220; Mon, 02
 May 2022 09:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220420214317.3303360-1-kaleshsingh@google.com> <165117574186.3115452.6818682378273681624.b4-ty@kernel.org>
In-Reply-To: <165117574186.3115452.6818682378273681624.b4-ty@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 2 May 2022 09:54:45 -0700
Message-ID: <CAC_TJve+n8gXbG_XY_rb+DC7399SSmP6BRc5x7X=cvht50XLYA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] KVM: arm64: Hypervisor stack enhancements
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Changbin Du <changbin.du@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Apr 28, 2022 at 12:55 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 20 Apr 2022 14:42:51 -0700, Kalesh Singh wrote:
> > This is v8 of the nVHE hypervisor stack enhancements. This version is based
> > on 5.18-rc3.
> >
> > Previous versions can be found at:
> > v7: https://lore.kernel.org/r/20220408200349.1529080-1-kaleshsingh@google.com/
> > v6: https://lore.kernel.org/r/20220314200148.2695206-1-kaleshsingh@google.com/
> > v5: https://lore.kernel.org/r/20220307184935.1704614-1-kaleshsingh@google.com/
> > v4: https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/
> > v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
> > v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
> > v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/
> >
> > [...]
>
> Applied to next, thanks!
>
> [1/6] KVM: arm64: Introduce hyp_alloc_private_va_range()
>       commit: 92abe0f81e1385afd8f1dc66206b5be9a514899b
> [2/6] KVM: arm64: Introduce pkvm_alloc_private_va_range()
>       commit: f922c13e778d6d5343d4576be785a8204c595113
> [3/6] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
>       commit: ce3354318a57875dc59f4bb841662e95bfba03db
> [4/6] KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack
>       commit: 1a919b17ef012ca0572bae759c27e5ea02bfb47f
> [5/6] KVM: arm64: Detect and handle hypervisor stack overflows
>       commit: 66de19fad9ef47c5376a99bb2b00661f1c788a94
> [6/6] KVM: arm64: Symbolize the nVHE HYP addresses
>       commit: 6ccf9cb557bd32073b0d68baed97f1bd8a40ff1d

Thanks for applying these Marc.

I was wondering if instead of taking these through kvm-arm64/next,
could Catalin consolidated these in arm64 for-next/core with Mark
Ruthland's and Madhavan's stacktrace patches[1]? This avoids conflict
and would allow for the hypervisor unwinding changes[2] to apply
cleanly.

[1] https://lore.kernel.org/r/20220413145910.3060139-1-mark.rutland@arm.com/
[2]  https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/

Thanks,
Kalesh
>
> Cheers,
>
>         M.
> --
> Without deviation from the norm, progress is not possible.
>
>
