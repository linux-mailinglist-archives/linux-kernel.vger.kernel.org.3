Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0225AE7EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiIFMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiIFMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7387C313
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662466625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnYxCw0s/pHwUcgtnSLKilEtMuOQUNoE7iSVP2/GuxM=;
        b=NMvKmmT3DN4MZCgb/0C4WD4i/dPwM7wdz6qb/f9k210V1zrL2cVnKyoN96MU2BxJNiO1h6
        5ewwmb9N0OxrOfIZ29qN5puQ8ALKuOquPIooChf+3hRSGAQZQS9gRjIPwajwUCYJA9ql8L
        DFR2KvSMeX8D8QZVY6w6nPCFVnvFRzM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-QCilDikbNNy9Ln2TArlz2A-1; Tue, 06 Sep 2022 08:16:55 -0400
X-MC-Unique: QCilDikbNNy9Ln2TArlz2A-1
Received: by mail-wr1-f69.google.com with SMTP id r17-20020adfbb11000000b00228663f217fso1666633wrg.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date;
        bh=TnYxCw0s/pHwUcgtnSLKilEtMuOQUNoE7iSVP2/GuxM=;
        b=VtVXe235eW0sGStB1Fm8HC4btMPkHo+dFrFwgVcPkudbXRPhNxTMkN4G+SFFOJO9N7
         NTMP3Al0OJZykFTUZySlXDWUWl1Jn/TEfvC8AbK2vlJvolkCxf7kx8YoS3/5VUVkGBTA
         I7TbqNpOeG5Wu1QGfG978MUl2RBw/VfZUSMtPz0WOzFLRNd7Meu5GaanGFcshkNqPc3y
         LC1Njml/HnvYSFOCEJxxtHtnMtCNd3MK7Dol1WUTQF4c+h5z+l/p53UagvR+g0ZP8JyA
         K4ZW2kQ9co4EC2309kkgsQTey1TKaGXwvh6WJaKB6bGjE/SRvfl0NBBap7+BZ5tBOKER
         8euQ==
X-Gm-Message-State: ACgBeo14xki+wh+1KMfliZjRvt2upAKKL81XTdAhc60t/k1qfkLKtNe1
        A3s7r/b/eQ9awbv72BzKGRt1L0n45SIAH5875a5olwiR6dWfH1YVijHx36LcYcuEzjuRri5UdAM
        X5AaI8DMETf+HLhkvSJ1y0WEA
X-Received: by 2002:adf:e310:0:b0:226:d19c:de22 with SMTP id b16-20020adfe310000000b00226d19cde22mr26172628wrj.314.1662466614121;
        Tue, 06 Sep 2022 05:16:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4CcQEYIk18pbFfzipD0R+pCzU/bzwI1h5fPF7hIAYNbl6y6c/wj3uC/cOZgBdAoQPkjYqJgw==
X-Received: by 2002:adf:e310:0:b0:226:d19c:de22 with SMTP id b16-20020adfe310000000b00226d19cde22mr26172603wrj.314.1662466613935;
        Tue, 06 Sep 2022 05:16:53 -0700 (PDT)
Received: from dhcp-4-160.tlv.redhat.com (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600016c600b00228d8420f57sm2728379wrf.95.2022.09.06.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:16:53 -0700 (PDT)
Message-ID: <5c6491f72aa134c0470fea2c742ed14b198f051e.camel@redhat.com>
Subject: Re: [PATCH] x86/aperfmperf: Fix arch_scale_freq_tick() on tickless
 systems
From:   ypodemsk@redhat.com
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com, pauld@redhat.com,
        frederic@kernel.org, ggherdovich@suse.cz,
        linux-kernel@vger.kernel.org, lenb@kernel.org, vschneid@redhat.com,
        jlelli@redhat.com, mtosatti@redhat.com, ppandit@redhat.com,
        alougovs@redhat.com, lcapitul@redhat.com, nsaenz@kernel.org
Date:   Tue, 06 Sep 2022 15:16:50 +0300
In-Reply-To: <20220804131728.58513-1-ypodemsk@redhat.com>
References: <20220804131728.58513-1-ypodemsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping?

On Thu, 2022-08-04 at 16:17 +0300, Yair Podemsky wrote:
> In order for the scheduler to be frequency invariant we measure the
> ratio between the maximum cpu frequency and the actual cpu frequency.
> During long tickless periods of time the calculations that keep track
> of that might overflow, in the function scale_freq_tick():
> 
> if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> »       goto error;
> 
> eventually forcing the kernel to disable the feature with the
> message "Scheduler frequency invariance went wobbly, disabling!".
> Let's avoid that by detecting long tickless periods and bypassing
> the calculation for that tick.
> 
> This calculation updates the value of arch_freq_scale, used by the
> capacity-aware scheduler to correct cpu duty cycles:
> task_util_freq_inv(p) = duty_cycle(p) * (curr_frequency(cpu) /
> max_frequency(cpu))
> 
> However Consider a long tickless period, It takes should take 60
> minutes
> for a tickless CPU running at 5GHz to trigger the acnt overflow,
> pick 10 minutes as a staleness threshold to be on the safe side,
> In our testing it took over 30 minutes for the overflow to happen,
> but since it's frequency/platform dependent we choose a smaller value
> to be on the safe side.
> 
> Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in
> frequency invariant accounting")
> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c
> b/arch/x86/kernel/cpu/aperfmperf.c
> index 1f60a2b27936..dfe356034a60 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -23,6 +23,13 @@
>  
>  #include "cpu.h"
>  
> +/*
> + * Samples older then 10 minutes should not be proccessed,
> + * This time is long enough to prevent unneeded drops of data
> + * But short enough to prevent overflows
> + */
> +#define MAX_SAMPLE_AGE_NOHZ	((unsigned long)HZ * 600)
> +
>  struct aperfmperf {
>  	seqcount_t	seq;
>  	unsigned long	last_update;
> @@ -373,6 +380,7 @@ static inline void scale_freq_tick(u64 acnt, u64
> mcnt) { }
>  void arch_scale_freq_tick(void)
>  {
>  	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
> +	unsigned long last  = s->last_update;
>  	u64 acnt, mcnt, aperf, mperf;
>  
>  	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> @@ -392,7 +400,12 @@ void arch_scale_freq_tick(void)
>  	s->mcnt = mcnt;
>  	raw_write_seqcount_end(&s->seq);
>  
> -	scale_freq_tick(acnt, mcnt);
> +	/*
> +	 * Avoid calling scale_freq_tick() when the last update was too
> long ago,
> +	 * as it might overflow during calulation.
> +	 */
> +	if ((jiffies - last) <= MAX_SAMPLE_AGE_NOHZ)
> +		scale_freq_tick(acnt, mcnt);
>  }
>  
>  /*

