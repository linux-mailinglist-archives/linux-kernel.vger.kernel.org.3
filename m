Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179E157C854
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiGUJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiGUJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:58:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478F381B1E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so765411otn.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1cw8n2s++yGrcoRACgo1RACYLLvGocB0lSZfMf+v5k=;
        b=GAiOHo1VRSqtmwOO5seALkjK17Xl0J2NPoHCbEV3V07AP4Q2diSeRtvxSgavPHZl2O
         8NkgO9GuJGz5vkg6RGY5AX0645gxSAAi0+fNRbfT4mSLeoi0cOBpH/pHgmmtcUCsLIwk
         5EFuw/QBuJxkhjgWqt08kwIN/JVUy/1J1zRTpEaOWGHnkZpmjeMafnxpAGL6hdwz0EkV
         6lsSAmvB0GJYnA/+1nqw8/SUbEZNTOtnhzSW4jP3lFvH/ZfvGFDFxlKXzdN2trkCQlH2
         CXdK/0a/22SEDyIMh/oa5dmVfs6B0HrwGLiXw5Z/Ro4cSU1Wwirr+HjCB9lamCBoOZHk
         udqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1cw8n2s++yGrcoRACgo1RACYLLvGocB0lSZfMf+v5k=;
        b=LHsRsgUW08uE3zdbDrGrYgNXcL3S+IXu5PQLpwYcQIMxWixsOoVTepHp+9kt/nj8tM
         qtThP7wl3t+oxRcX6zm5tQ4GqZ9ZWIvRetzyT5RRQWDUH0i7i+SvlmJEuXQx8bWwIuJd
         NPvi5M6tWPTIqwOzTMYSjOXUFYp2+G0LHSo9Nqr2zKL5R23YZvJZrhr7jEHQaCw+OZrZ
         JHw2PJz5Ubqa3v4fE0FVhgr2wh/jEZWccvSlBeHkqMfDKaBWpjA0pCX4SfecPt9sLRud
         p9KJdr+8mqFDG7516NJfgNjXI+sVb8g+rcZe0/M8LV+PZfaKXihz4w/7oJh/aIVUbrdT
         Wu4A==
X-Gm-Message-State: AJIora+lwWG18PMelL3Wu+gHjJM2yQ0N8b3XH0Z3LL3SGyursLs4ilyM
        YF2N1Z4MusNcwrIR5V4mkaQu1mZQN8YJllCTHrfMRw==
X-Google-Smtp-Source: AGRyM1v2hPhTASw+wF+XVDBlk1CI1nNorxhP4r6p0nuR1mYXYF4mAP3CWBqFwNTgIpR5+p7wQj950bEmAKkn/BHUbRU=
X-Received: by 2002:a9d:5f1a:0:b0:61c:50a1:df3 with SMTP id
 f26-20020a9d5f1a000000b0061c50a10df3mr16441497oti.102.1658397500469; Thu, 21
 Jul 2022 02:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-9-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-9-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:57:44 +0100
Message-ID: <CA+EHjTxtwjf3dMhrBFa0iTMPayV0V0dM-z_Gk_hSQn_hr4zYow@mail.gmail.com>
Subject: Re: [PATCH v5 08/17] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Thu, Jul 21, 2022 at 6:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> This can be used to disable stacktrace for the protected KVM
> nVHE hypervisor, in order to save on the associated memory usage.
>
> This option is disabled by default, since protected KVM is not widely
> used on platforms other than Android currently.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Just wanted to point out that I have specifically tested this as well,
enabling PROTECTED_NVHE_STACKTRACE but not NVHE_EL2_DEBUG. Works as
expected.

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>
> Changes in v5:
>   - Make PROTECTED_NVHE_STACKTRACE depend on NVHE_EL2_DEBUG, per Marc
>
>  arch/arm64/kvm/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 8a5fbbf084df..09c995869916 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -46,6 +46,21 @@ menuconfig KVM
>
>           If unsure, say N.
>
> +config PROTECTED_NVHE_STACKTRACE
> +       bool "Protected KVM hypervisor stacktraces"
> +       depends on NVHE_EL2_DEBUG
> +       default n
> +       help
> +         Say Y here to enable pKVM hypervisor stacktraces on hyp_panic()
> +
> +         If you are not using protected nVHE (pKVM), say N.
> +
> +         If using protected nVHE mode, but cannot afford the associated
> +         memory cost (less than 0.75 page per CPU) of pKVM stacktraces,
> +         say N.
> +
> +         If unsure, say N.
> +
>  config NVHE_EL2_DEBUG
>         bool "Debug mode for non-VHE EL2 object"
>         depends on KVM
> --
> 2.37.0.170.g444d1eabd0-goog
>
