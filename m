Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055D24FBF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347197AbiDKObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347269AbiDKObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:31:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019683B298;
        Mon, 11 Apr 2022 07:29:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s137so11614171pgs.5;
        Mon, 11 Apr 2022 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nDpC+8Nt8swqUMB30zr9ru/FTgIOVV9P8mvYZePDesw=;
        b=q74U30l23iQBFOXwJd99wG6So4NW+6KP2zT4drdQum/6ZHAG0vZRFfTxxfEVmcPmoh
         HN0uxLMme1J2cr9Ppfxp6outoLVGvJqmNcHwkbOem1ANKd/LzdO/67GFgoWNVUcjE4qZ
         wBTvVsy+Ja40yrC/cjd1UmukAo+ul59ouTauVodXOgIjXiJqXJoT/7BKzbgq5+nIUEWj
         tS/AGkUIiD2gim4F3z05Yix7N3nch3P04Lwuy9azXYLcosA8IOYZOQcMT/2WPJak18km
         uuHpw+nCVoNwg9CV7x1UkuXvH62SgdxPtQltqz+w2/9TAl+BkM+UYsobhMH2UXEWG6bQ
         o0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nDpC+8Nt8swqUMB30zr9ru/FTgIOVV9P8mvYZePDesw=;
        b=SFVAIwO7omks/2iIYW2AcUfFGAM93jIsJiPfZYkHbc3nDhQKXg1D52LbvJW/3kivqX
         AT4HbIGulonUSnevmgo99d5cRxKec/VxdfpePk2xjBs/IZa+kC3MDAnpHccQRiwB1LEA
         QHYmJZ7VqrzGDs1kc2WocqGzLlJkBbsYx5Pu5PKzBSwtzs7WnLF/waKvkUVGASIKbxmc
         7p6S9DpqHWdj/7QRFQaQoa2CukCCELjfhXVDwvgPNIynCE9H1V5YdfVrwtRdnnWaZ68+
         aP9EwsKiaRoY00Ikthw9pJqyOn9E6dzvdKVuiomtQ4RLKfaiUkK7ZHfB9e+0D3uUt74y
         8Fzw==
X-Gm-Message-State: AOAM531DrAhlOenEO+U6ROrHmf/KSygvlAtA7d7BUBoGTSbOzK+NfF6T
        NecE/2jTNNc4Wv717UIM5p4=
X-Google-Smtp-Source: ABdhPJw9iDBfYSL0PEOCtTlMjeVbVl9sDVTg93cd/ps9BKiKmtZ1pLH4ZPrmN0a2qx4X0RDUStd63w==
X-Received: by 2002:a05:6a00:1510:b0:4fa:f5fe:ffd5 with SMTP id q16-20020a056a00151000b004faf5feffd5mr32929048pfu.2.1649687365432;
        Mon, 11 Apr 2022 07:29:25 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm20756973pju.44.2022.04.11.07.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:29:25 -0700 (PDT)
Message-ID: <edfc8bd1-8dc3-9e88-d9c3-6a427b039a98@gmail.com>
Date:   Mon, 11 Apr 2022 22:29:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] perf/x86/amd: cpu_hw_events::perf_ctr_virt_mask should
 only be used on host
Content-Language: en-US
To:     Dongli Si <kvmx86@gmail.com>
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jmattson@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel OTC, Netherlander)" <peterz@infradead.org>,
        "Joerg Roedel (KVM HoF)" <joro@8bytes.org>
References: <20220411134651.740234-1-sidongli1997@gmail.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <20220411134651.740234-1-sidongli1997@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongli,

On 11/4/2022 9:46 pm, Dongli Si wrote:
> From: Dongli Si <sidongli1997@gmail.com>
> 
> perf_ctr_virt_mask is used to mask Host-Only bit when SVM is disabled,
> Using it on a guest doesn't make sense and make things obscure.

Or you can work it out to make nested vPMU functional on AMD.

> 
> Revert commit df51fe7ea1c1c
> ("perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest"),

This is not a typical revert commit.

> Because it make things a little obscure and this #GP has been fixed in KVM.

Please check the chronological order of the related commits and the motivations.

> 
> Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
> Signed-off-by: Dongli Si <sidongli1997@gmail.com>
> ---
>   arch/x86/events/amd/core.c   | 19 ++++++++++++++++++-
>   arch/x86/events/perf_event.h |  3 +--
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 9687a8aef01c..5ac7d9410d36 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -533,7 +533,12 @@ static void amd_pmu_cpu_starting(int cpu)
>   	struct amd_nb *nb;
>   	int i, nb_id;
>   
> -	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
> +	/*
> +	 * When SVM is disabled, set the Host-Only bit will cause the
> +	 * performance counter to not work.

It's ridiculous. Based on the AMD APM Table 13-3. Host/Guest Only Bits,
the performance counter would count "Host events" rather than "not work".

Note, your proposal change should work on the L0, L1 and L2.

> +	 */
> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
>   
>   	if (!x86_pmu.amd_nb_constraints)
>   		return;
> @@ -1023,10 +1028,16 @@ __init int amd_pmu_init(void)
>   	return 0;
>   }
>   
> +/*
> + * Unmask the Host-only bit when SVM is enabled on the Host Hypervisor
> + */
>   void amd_pmu_enable_virt(void)
>   {
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>   
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return;
> +
>   	cpuc->perf_ctr_virt_mask = 0;
>   
>   	/* Reload all events */
> @@ -1035,10 +1046,16 @@ void amd_pmu_enable_virt(void)
>   }
>   EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
>   
> +/*
> + * Mask the Host-only bit when SVM is disabled on the Host Hypervisor
> + */
>   void amd_pmu_disable_virt(void)
>   {
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>   
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return;
> +
>   	/*
>   	 * We only mask out the Host-only bit so that host-only counting works
>   	 * when SVM is disabled. If someone sets up a guest-only counter when
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 150261d929b9..fa1428ca60b6 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1138,10 +1138,9 @@ void x86_pmu_stop(struct perf_event *event, int flags);
>   
>   static inline void x86_pmu_disable_event(struct perf_event *event)
>   {
> -	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
>   	struct hw_perf_event *hwc = &event->hw;
>   
> -	wrmsrl(hwc->config_base, hwc->config & ~disable_mask);
> +	wrmsrl(hwc->config_base, hwc->config);
>   
>   	if (is_counter_pair(hwc))
>   		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
