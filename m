Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08236577E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiGRJIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiGRJIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:08:48 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC2B1928C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:08:45 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id z12-20020a056830128c00b0061c8168d3faso6955564otp.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyN4R4wxoBxOYspFa5dE/mkU9oa9JodtT8mt47nKD20=;
        b=ASu0WTSHFZTnJxmWsucJT2xg3U3pJ9JDjAT++73osXtDgaNaPEkLXxKn9fjFQcesZj
         yuq/KorlL6gF9V0/pWqQYG22JPWrtGnBN2d5mSNRUcFLAbQGia5AUKLBQZcUQTUEe+8f
         /rgjgMTabag6/QWzBowTZNAEZZ25J1dA5junzkGMbt9uzzpKZYyAVrQpF4VwEeJWXRqv
         qRUzxeOE1sPEh49iMO/ukNr+EJegIACLVSWu5WgBqAV0C4gP+hn21xpL5D4S0Wq1n+bc
         PkjrHpQGP1LL7SAVgne+3TtKgXudqRHaX00bbazPD6Iy/45iHIVZfSAbvz6Ij3gi00MZ
         MViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyN4R4wxoBxOYspFa5dE/mkU9oa9JodtT8mt47nKD20=;
        b=QYVH8ywyJwYgIATiws28kGMImA3NC7OMtTYmZypWkuSongTYtrMP9IcX6klPTzfeuk
         rsUJFbmrwj86t/kfPd05gCrRH68Fxzfpi+8WmFIQ0FqFSJZeO1HY2qs74S7F9gbvLwp6
         2Y5Io1b+I01kOcylkOcqNXG0FIh23c/V/ecWUqmGRQRsY9IRZT4kQbUl/W5kg7hRsYrO
         JywE6eFXYhHDtUQ6GP36bCpc1UeHxhpDF4tsg32N9GcJatTB5RgiI0p9PfjNADymsAqL
         hW5aIOIwsAb27tXIZaHxbAOBY0oTuWnHyG3adsf2IXYDM1wNZtESPt0i28r4XsMdI205
         cccw==
X-Gm-Message-State: AJIora8S8mBVHB4EL7VzVA9unzwJ8oD+m4XlKFFzPoI10ClKfr1dzqR9
        QP8vbFLixF43WTjhHfHTYVO2dphCAL2tJvV6331iiRqg02Wu3w==
X-Google-Smtp-Source: AGRyM1trl6Ac86+5L4VHnfQf/LcT7deUAzD+vON1lIJfOtePo+yI0pY7we08AjsL5W7qoPc56zZ6NTGNdM9naMbHcpg=
X-Received: by 2002:a05:6830:108a:b0:61c:9fb5:6784 with SMTP id
 y10-20020a056830108a00b0061c9fb56784mr1754550oto.299.1658135325046; Mon, 18
 Jul 2022 02:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220715235824.2549012-1-kaleshsingh@google.com>
In-Reply-To: <20220715235824.2549012-1-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 18 Jul 2022 10:08:08 +0100
Message-ID: <CA+EHjTxXX_d8M9VGCBokoKCCuvOoR_1u4JrSNKPTdN3qp9bQog@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Fix hypervisor address symbolization
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        android-mm@google.com, kernel-team@android.com,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Sat, Jul 16, 2022 at 12:58 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> With CONFIG_RANDOMIZE_BASE=y vmlinux addresses will resolve correctly
> from kallsyms. Fix this by adding the KASLR offset before printing the
> symbols.
>
> Based on arm64 for-next/stacktrace.
>
> Fixes: 6ccf9cb557bd ("KVM: arm64: Symbolize the nVHE HYP addresses")
> Reported-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Even with this patch applied I still don't get symbolization unless I
disable randomization, either by setting CONFIG_RANDOMIZE_BASE=n or
pass nokaslr as a kernel parameter. I tried both and in either case it
works.

Thanks,
/fuad


>  arch/arm64/kvm/handle_exit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index f66c0142b335..e43926ef2bc2 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -347,10 +347,10 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>                         kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
>                 else
>                         kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", panic_addr,
> -                                       (void *)panic_addr);
> +                                       (void *)(panic_addr + kaslr_offset()));
>         } else {
>                 kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_addr,
> -                               (void *)panic_addr);
> +                               (void *)(panic_addr + kaslr_offset()));
>         }
>
>         /*
>
> base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
> --
> 2.37.0.170.g444d1eabd0-goog
>
