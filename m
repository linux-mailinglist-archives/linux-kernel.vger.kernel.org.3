Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80741529663
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbiEQBAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiEQA7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:59:42 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1A46165
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:59:39 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id f13so6459076uax.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOFwWvCzKdZRiDREe2Yw7hYWmMD5WfY21+v62r2lSAQ=;
        b=NTVAN5OeH9zigQ0ls1wYbMQdNrPMZcFb9eIgEhfEZr2WW26Rik9MXZfufZOyienHwS
         EtCJYc9E3eLm7MDJG7hZXuyEeCr40N7ediAdDIWhArm2cAg9D7Kr4e032+E1U32YWc0G
         /U2iI4O3u6CXHMWIP5u6U1Xv8y+Q6zs+nQg7Jq0QVXIkrjokFICe/7s/jVdSPh+5/qWY
         70LTFRRCGbO7ofPPDFdPz1f0TJw+0iS0eHH+3Cjqt7Baa1sF7vuwm3w1pMHst+p+nxP2
         SVvvtyCQq4Gw03JOqXql1xUiJoPxveThLJHhVFiOWQOTyNE5bN9q8KE9ns01rX5MbfHb
         TXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOFwWvCzKdZRiDREe2Yw7hYWmMD5WfY21+v62r2lSAQ=;
        b=PellfF91FTeK1PRBK19MuOdugnfFkqisIBpoPot0euf2tICjtgqebHpAJH2J3QRbsp
         I/3AF6ZlfK0rBOf0bviH1mm+GTDu79/dcFq35zHg2lmNh7d9XcH7WQLnv5l63YqQ2l+8
         N+wB9RJjG23ClzaqkehHVfjBj/wXQd4LAGj37jmziggzMp60E+7ojMW+QWFt1DxGbj4h
         rCTmG0tSF66SMXdoee8OFO3HFZl9rAZPZh6jyddyXkWjEidJnXcpiDIC0pQNc5XMYQ3L
         BhQoTB9reu54phElIRozh7Gjnm8YEfOnm/AKSitTSnuo4StA1bJEv5XVL2iThm1kIwhT
         8GCg==
X-Gm-Message-State: AOAM531gmSn+C4xq/qNX+P06eqPePHJc/uGbnGaM0Ma0DHUGp1ZI6E0s
        vEcOp47ISXQzRw4Hs7omS6luYLCaUUBZYrxjXwttIH9VovM=
X-Google-Smtp-Source: ABdhPJzUATlCmOwVxvtyGMPLZTFI3CdKHj+ab34xGnvXgjnRelrRNAxacHbpkOiuBmn4Vnfm9PRhXxXIbgYbEjTZfX4=
X-Received: by 2002:ab0:1525:0:b0:365:95fa:4e51 with SMTP id
 o34-20020ab01525000000b0036595fa4e51mr7147536uae.121.1652749178730; Mon, 16
 May 2022 17:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220516154838.7044-1-bp@alien8.de>
In-Reply-To: <20220516154838.7044-1-bp@alien8.de>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 16 May 2022 17:59:27 -0700
Message-ID: <CABPqkBSL8BLN-mWXNJX9YYCn26kK1J-nz2B_vFjbxLPw+P1uHQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Run AMD BRS code only on supported hw
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, May 16, 2022 at 8:48 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> This fires on a Fam16h machine here:
>
>  unchecked MSR access error: WRMSR to 0xc000010f (tried to write 0x0000000000000018) \
>     at rIP: 0xffffffff81007db1 (amd_brs_reset+0x11/0x50)
>  Call Trace:
>   <TASK>
>   amd_pmu_cpu_starting
>   ? x86_pmu_dead_cpu
>   x86_pmu_starting_cpu
>   cpuhp_invoke_callback
>   ? x86_pmu_starting_cpu
>   ? x86_pmu_dead_cpu
>   cpuhp_issue_call
>   ? x86_pmu_starting_cpu
>   __cpuhp_setup_state_cpuslocked
>   ? x86_pmu_dead_cpu
>   ? x86_pmu_starting_cpu
>   __cpuhp_setup_state
>   ? map_vsyscall
>   init_hw_perf_events
>   ? map_vsyscall
>   do_one_initcall
>   ? _raw_spin_unlock_irqrestore
>   ? try_to_wake_up
>   kernel_init_freeable
>   ? rest_init
>   kernel_init
>   ret_from_fork
>
> because that CPU hotplug callback gets executed on any AMD CPU - not
> only on the BRS-enabled ones. Check the BRS feature bit properly.
>
Thanks for catching this. I tested on Zen2 (Fam17h) and it did not
trigger the problem, yet I think
the problem in amd_brs_reset() is there.

> Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-By: Stephane Eranian <eranian@google.com>

> ---
>  arch/x86/events/amd/brs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
> index 895c82165d85..bee8765a1e9b 100644
> --- a/arch/x86/events/amd/brs.c
> +++ b/arch/x86/events/amd/brs.c
> @@ -57,7 +57,7 @@ static inline u64 get_debug_extn_cfg(void)
>
>  static bool __init amd_brs_detect(void)
>  {
> -       if (!boot_cpu_has(X86_FEATURE_BRS))
> +       if (!cpu_feature_enabled(X86_FEATURE_BRS))
>                 return false;
>
>         switch (boot_cpu_data.x86) {
> @@ -112,6 +112,9 @@ static inline int amd_brs_get_tos(union amd_debug_extn_cfg *cfg)
>   */
>  void amd_brs_reset(void)
>  {
> +       if (!cpu_feature_enabled(X86_FEATURE_BRS))
> +               return;
> +
>         /*
>          * Reset config
>          */
> --
> 2.35.1
>
