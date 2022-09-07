Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAC5B1040
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIGXNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiIGXNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E8EC5796
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A05DA61B04
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CFDC4347C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662592392;
        bh=G3Kwfw6T/4eq7w7+tSEG/rt/8cNRggabZvdgJ8K8jVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IaEKHEJ4Y/H/AQUlpUWV4ze842sN+hC6Gsu6NTdTUQguAPNr3tCuFTwt3+baSAIft
         v61lR+XSlU4uRNQKinOam8faVgET/UrnzhiCV8wz4FoCzDm+gZ7aSP0cbLCwL6Dk5q
         h9r2QsUMJDasfcs/nfT0GOnkMbWULzBau7aqv13VsgngXkZci/jjb3a0w+/EBhfCYh
         OSDFVSpQjmE3ufwaBHBdsxayhJ9o2zFOB5qkYkmU3izMuHl4M9m6182sWwbfeVzLB2
         l4fV3W0jZDm1Nh6u/9NxE6rJozm3OrxEUUm9/h7Xu/wo/uGAiQbq0i9Hc465f/roGF
         v/rXHVGhLa0NQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1279948d93dso20040840fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:13:12 -0700 (PDT)
X-Gm-Message-State: ACgBeo3gsLTADPqXdDQ2vRm4MKmP8drKlt4Z6jBPtxrdXiAtgZq4xjqG
        luBzh/Lj8tIvQfqMw2z7BOp++4mDfcBm9lJjcpg=
X-Google-Smtp-Source: AA6agR6EUvI484CIZrlEo84tOagm6hHSjYZeWoaJRcu++RhG5L5/01Uq0OQUqqUYMmTw0LqxMpSyj9Bp5oVeiMRlJHs=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr405514oab.112.1662592391107; Wed, 07
 Sep 2022 16:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220905111027.2463297-1-heiko@sntech.de> <20220905111027.2463297-5-heiko@sntech.de>
 <CAOnJCUJ9hC2xhoxuBPCNHEEZACeWckEL-Tc7xS6ECWrfx5KXhg@mail.gmail.com>
In-Reply-To: <CAOnJCUJ9hC2xhoxuBPCNHEEZACeWckEL-Tc7xS6ECWrfx5KXhg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 8 Sep 2022 07:12:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTbfdUQEGDnosKaZrFLh58UVdnDRQUXc-N5p+11aLPT7w@mail.gmail.com>
Message-ID: <CAJF2gTTbfdUQEGDnosKaZrFLh58UVdnDRQUXc-N5p+11aLPT7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] riscv: use BIT() marco for cpufeature probing
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        atishp@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Sep 8, 2022 at 6:50 AM Atish Patra <atishp@atishpatra.org> wrote:
>
>
>
> On Mon, Sep 5, 2022 at 7:15 AM Heiko Stuebner <heiko@sntech.de> wrote:
>>
>> Using the appropriate BIT macro makes the code better readable.
>>
>> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  arch/riscv/kernel/cpufeature.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 729f7a218093..08f7445985dc 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -289,10 +289,10 @@ static u32 __init_or_module cpufeature_probe(unsigned int stage)
>>         u32 cpu_req_feature = 0;
>>
>>         if (cpufeature_probe_svpbmt(stage))
>> -               cpu_req_feature |= (1U << CPUFEATURE_SVPBMT);
>> +               cpu_req_feature |= BIT(CPUFEATURE_SVPBMT);
>>
>>         if (cpufeature_probe_zicbom(stage))
>> -               cpu_req_feature |= (1U << CPUFEATURE_ZICBOM);
>> +               cpu_req_feature |= BIT(CPUFEATURE_ZICBOM);
>>
>>         return cpu_req_feature;
>>  }
>> --
>> 2.35.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>
> --
> Regards,
> Atish



-- 
Best Regards
 Guo Ren
