Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7BA53E9DF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiFFJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiFFJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:32:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1AB4B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:32:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q7so19045807wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DILDsr0b9hqKpzHkSK5EkqNENVkelrpz3368vmKRnRQ=;
        b=K3iIi0U81SdwLg437LEDDbrh1s6RRYAb/HYOoQgkk6UcO4dNCa7D4Kuy2/oheMJess
         Jz4E5ub7+ZhVinK0efcD0dQTPTQlNqA6o/BT6KnNRu4OV0GsE9Zv4Q7yKi0g7kHyTkhS
         hZ7zXBrmLk0vS3iXgAS5DEfRI00Us9zK0jcmp/z1gktNOMkPArbBLPk4cNDH05IQJZGn
         jLd/QMJhttYCevIWTZaHB12PRr20JR7De5I4htbXUJ8wXcKEtqDw1juBfzyHsES/kCSb
         GZ3yuHlqHfTQw0QB60lR8OCzaHMEKgLCmDsipKlslOGhTPK6uvTl5ZOaGUXEW43UNQ7i
         WNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DILDsr0b9hqKpzHkSK5EkqNENVkelrpz3368vmKRnRQ=;
        b=BqsDJdUrvZcWiDV43oCcV8TSSV/vgMEYx9SHEgrwLMhfiK05eAqW+hAHds620eiq3M
         VYFh9NLbEn0RU/CgnHEGaOaI6wfTNVtJHw6V7a/zGKRDOPoMLrl1drna2CtalT6LFfW8
         DN/aOeyCR4m/jQRZkjyM82J51JvQBOWu8te15hlSsteIYefvCaXlkBlP59hhWbA5i85z
         +gfXmviNylBKVAn+sNfehpi3jvxaMtMD+HqSP8tobyJDt8f0KkxQ/1LXY+e7miWKtSI+
         Z3SauMBK5s3BzgYk7kJYSuWvCEknLqMekJxuNpbCJoY5fyi8TK8WUlfLgLdSHgTSAMZ5
         P5IA==
X-Gm-Message-State: AOAM530KXW/cE359vuq0axs9VTwp5lee65wXXBhdUKqHdqaxroHm/KzD
        GPg4jdAGO5ZCVyp9NsEn5jQLgjfWkJzIg9Tf
X-Google-Smtp-Source: ABdhPJx+oRFZ+CN+fAAHTjHqkljtgqFJ2cn4uX2fDxDW75/GWl2ErIDYO2Zn59XfMwbkQkeK7XzUJQ==
X-Received: by 2002:a5d:51d0:0:b0:218:4277:c786 with SMTP id n16-20020a5d51d0000000b002184277c786mr2313736wrv.255.1654507941470;
        Mon, 06 Jun 2022 02:32:21 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0039c3ecdca66sm9941335wmb.23.2022.06.06.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:32:20 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:32:17 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev,
        kernel-team@android.com
Subject: Re: [PATCH v9 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
Message-ID: <Yp3JodkEgYUsQ4EV@google.com>
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-7-vdonnefort@google.com>
 <d91ffb42-4440-7c07-6a87-3cce9fa3dcab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91ffb42-4440-7c07-6a87-3cce9fa3dcab@arm.com>
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

On Tue, May 31, 2022 at 10:17:01AM +0200, Dietmar Eggemann wrote:
> - Vincent Donnefort <vincent.donnefort@arm.com>
> 
> On 23/05/2022 17:51, Vincent Donnefort wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> [...]
> 
> > @@ -6834,22 +6887,36 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  	if (!task_util_est(p))
> >  		goto unlock;
> >  
> > +	eenv_task_busy_time(&eenv, p, prev_cpu);
> > +
> >  	for (; pd; pd = pd->next) {
> > -		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> > +		unsigned long cpu_cap, cpu_thermal_cap, util;
> > +		unsigned long cur_delta, max_spare_cap = 0;
> >  		bool compute_prev_delta = false;
> >  		unsigned long base_energy_pd;
> >  		int max_spare_cap_cpu = -1;
> >  
> >  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> 
> Internal EAS testing of this patch-set version has revealed that this
> doesn't work against LTP CPU hotplug stress test. `struct cpumask *cpus`
> can't be used when it is empty. This can happen in case all PD CPUs are
> hotplugged out since we `and` the invariant PD cpumask with
> cpu_online_mask. We need a:
> 
> +               if (cpumask_empty(cpus))
> +                       continue;
> +
> 
> here.

Good catch, thanks for trying the test suite.

> 
> > -		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> > +		/* Account thermal pressure for the energy estimation */
> > +		cpu = cpumask_first(cpus);
> > +		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
> > +		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
> 
> [...]
