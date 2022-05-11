Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF3523B59
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345424AbiEKRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbiEKRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:18:58 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069C319CB74;
        Wed, 11 May 2022 10:18:57 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7ca2ce255so29020937b3.7;
        Wed, 11 May 2022 10:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IznQYPJ44n5aKvSC9fpTkKkn7z/3b/M/dwJg0jZxqw=;
        b=UZoSH7U1ZU4IJswwvMlV2yHvBOtMb9kMDhSMB+fHcNQn+CI+MhkoNRnA1mVdfv9ABk
         DWJKfRHT66asvGVFP1NkJ8+FqF3ng0tOVeH+h8M8oNkSnYlcsaeHDII+F4OL9RAKVDJo
         qlakjP76g26sMmQlh7wi8Qv6yCbpbDbdFZBJN7SAPvotYUmjG4+gEYEpnqelX5e0wXJN
         17pa9Hs5Yz5lMcMDUAF2DBne1MNFijZejntR+sIs7lHzA9paciFlU5qyk+tpvUa27c3+
         qeFW/Dmq8iHMvwokuQ1Tix+Dbr8GFBYk0bRNLLNttZ+EjtUYUbGD6vQ5VNYzIbqPqW4Y
         dpxw==
X-Gm-Message-State: AOAM530LoYBoWSrjpIb5PNCs8dJUWoe94U8qjVscj5VFBI416bAUCcsy
        og9IyPTwJcArPXbtVzjldqrb5oHATdMUaYyx+Sc=
X-Google-Smtp-Source: ABdhPJzUy92OlQ44g7Aet0Kzhsu/S503joAemeA2YFFg0+m09LtO13jWRSTPjhINJs/E1oMPFNJvuhTiv0OPDL2K1Rg=
X-Received: by 2002:a81:2f4e:0:b0:2fb:2c97:d66f with SMTP id
 v75-20020a812f4e000000b002fb2c97d66fmr26882271ywv.196.1652289536285; Wed, 11
 May 2022 10:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220502205052.1257462-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220502205052.1257462-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:18:45 +0200
Message-ID: <CAJZ5v0htY-7yc6dbtabnRLWkegiJy3OGg9jfXCk=LVbsD+LKgw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Support Sapphire Rapids OOB mode
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:50 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Prevent intel_pstate to load when OOB (Out Of Band) P-states mode is
> enabled in Sapphire Rapids. The OOB identifying bits are same as the
> prior generation CPUs like Ice Lake servers. So, also add Sapphire
> Rapids to intel_pstate_cpu_oob_ids list.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 846bb3a78788..76d59b3f35e4 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2424,6 +2424,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
>         X86_MATCH(BROADWELL_X,          core_funcs),
>         X86_MATCH(SKYLAKE_X,            core_funcs),
>         X86_MATCH(ICELAKE_X,            core_funcs),
> +       X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
>         {}
>  };
>
> --

Applied as 5.19 material, thanks!
