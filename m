Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB585B0A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIGQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:33:26 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9E1A7A8A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:33:24 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-127d10b4f19so11607093fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EmmUroBnQkKtzSpVrUefA2RMcw7wGhyCwtTDIpKDhrk=;
        b=PknB9Wzlt1y0TbVGAQBs/L0GjuCa+I/M92/+1rXq+zMC0AfruyxAtxyXEcTrEW3Vir
         cA9HDVdlT3akhMsuiWIl4IkuaARR47abE+oak4c84rqaZ6Wqm954cE3zE5Dt/cB169lY
         d0+OfeBlFYvDD9SMqAnejNpB/yNOlyzgUkk2vdcPPpLVh8hRhYmWS3Hgc+MvxSVKawT2
         vcTRd/hlqclFLK+91YwLOBcYjJ8WQiIkc9b5GDImrPRgLDTWzvuLrvyhXtsdHMta1RxV
         x6pnLBQUEkh0tTGjcjzOnB15ruIEkZDQPywrjHEsfW1sajwj/lIre/0Vr2JJ5CaiCpE5
         nodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EmmUroBnQkKtzSpVrUefA2RMcw7wGhyCwtTDIpKDhrk=;
        b=xcBP3zmTtgbgop+lD6LPuCoSW7/iS4DrXulD8uKGLx+gnj/DqR2otC9C4jkHdvIfEG
         uUsfRBFheTig0g5jk7J/s4THEwE1yYOZkofkz1P4JDb1UD8R0w8R3+na41X90M42I5b+
         OWyoEWm635u+F/xnXFdSb960zHak2DrqOOpznJIv2VIs48mFCrvOgsMuqyP+NZD88SQI
         6azgG+fY4TicSMkUk2w5TohzuPKNEKOpspsiRjeBiPT/JCf+NKRJBCyHsukmHnGphsM0
         rxI2oFycFGp3vkb4PF4E3Y5oh4EmIqU/9Qa1OJFP1+yXYvhtibKtf55HqG+9dvzwfOka
         W4Xw==
X-Gm-Message-State: ACgBeo3BD7wSlutMba36OdGOyq6N5PAtlH6f5go+t6LVoJrklfWa5lj3
        H7sR5v+XsG0058hUdVcY2wlWA7ak7h1U4eHoaKW+Lw==
X-Google-Smtp-Source: AA6agR4kzdBfcMicmpDRKNagmkro3jVBoG3aMKLRx/kY02XEbylzC5Z20E/hkkos05UKSPVjscEoWuqIuFX1v8fHD9I=
X-Received: by 2002:a05:6870:41d0:b0:126:5d06:28a5 with SMTP id
 z16-20020a05687041d000b001265d0628a5mr2299318oac.181.1662568403992; Wed, 07
 Sep 2022 09:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220907104838.8424-1-likexu@tencent.com>
In-Reply-To: <20220907104838.8424-1-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 7 Sep 2022 09:33:13 -0700
Message-ID: <CALMp9eSPfxPunKW-K6LLPxsXdaeezKU=2G9Sdh7FS6VGb3goFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86/pmu: Stop adding speculative Intel GP
 PMCs that don't exist yet
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 3:48 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> The Intel April 2022 SDM - Table 2-2. IA-32 Architectural MSRs adds
> a new architectural IA32_OVERCLOCKING_STATUS msr (0x195), plus the
> presence of IA32_CORE_CAPABILITIES (0xCF), the theoretical effective
> maximum value of the Intel GP PMCs is 14 (0xCF - 0xC1) instead of 18.
>
> But the conclusion of this speculation "14" is very fragile and can
> easily be overturned once Intel declares another meaningful arch msr
> in the above reserved range, and even worse, Intel probably put PMCs
> 8-15 in a completely different range of MSR indices.

The last clause is just conjecture.

> A conservative proposal would be to stop at the maximum number of Intel
> GP PMCs supported today. Also subsequent changes would limit both AMD
> and Intel on the number of GP counter supported by KVM.
>
> There are some boxes like Intel P4 may indeed have 18 counters, but
> those counters are in a completely different msr address range and do
> not strictly adhere to the Intel Arch PMU specification, and will not
> be supported by KVM in the near future.

The P4 PMU isn't virtualized by KVM today, is it?

>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>

Please put the "Fixes" tag back. You convinced me that it should be there.

Reviewed-by: Jim Mattson <jmattson@google.com>
