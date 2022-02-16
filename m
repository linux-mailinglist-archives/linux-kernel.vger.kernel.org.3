Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1B4B89BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiBPNXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:23:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiBPNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:23:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DA235
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:23:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so1167115edk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zXZfl0XIWRjkRZ0dozOmWUjU7MCzgPN2wpHMAJSXPzU=;
        b=DTVbVHsJ/imRiaAao8Krt2WuQkYi1deLV5YvJ8QYt/rKA6JarTm2cYpNNUI2O8UmvI
         IhAMXsJcZ7qaNmSIpQ7yFIYFnmVKTxxxgU2Cl+C9Kt5bglq0OqDl5tJd5r6j/SpQtXI1
         QPe6v1NSYAgxd5tuou6ALOXNpL3dXKbGK37Puj/rC4sF01VECUnsr2ENU0XimMei2NM4
         7hL1u9MxD5shEKKPUZmbCbK8TJoVu46hdQ2yEp11e2eXZjs06IJOfE4lG8whEp9hMAm2
         wv/ildB0Og7tr9qFx2eswAGuS0FMZ03AAmDlHAqRPEuNFd+kqsBFnlurxbLtExFUzMw+
         InCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zXZfl0XIWRjkRZ0dozOmWUjU7MCzgPN2wpHMAJSXPzU=;
        b=2RWGZoD5+eD7z35n/VScFexFzK975VqTqpigiced2lOa2uu+K1rvJalf4Ov78wZpZL
         jI7/SqHWoacwCzopSQ2cSLX2n2v5j+jcsboIw9vcWjJFDge7WwAFES0I4fHjZyaPTi1k
         gbbltlph6YWz3J/CcnXSLYmkiR7Z4jD6x0TXTQSY8jVXyPRXz5Nnpp4Xi0hOmDAkw6z9
         wjPY0+sug3KYnzUQKSv0PpCvewbwsK2pQKuuNgnFDAZu1UsZ1bbLHulWidiKDfZQ3GsK
         XmO2PCjbBxHiDx4LDXL8diyqnmJFyvLLiwtjG9KCe6Ln4/rm29f4VHHoVi2HLW6DBntD
         4XJw==
X-Gm-Message-State: AOAM533RkEPmNkEkbEf+jkSEtBlpiCmnv+2nLsUYu4Z8nOUkCrF3M68H
        mj2f7CkLS+nEyIF+xxr06Sryw6WKvzGHX4oEJqc=
X-Google-Smtp-Source: ABdhPJxqDHVBb+WqLObOWjeCzZ/I6vQn1Wv22KfI5/XcJQo9FQmzv/4Ipbs/nvrIoTlBuCEk10+sEA==
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id r24-20020a056402019800b0041083e321d7mr2984426edv.159.1645017782121;
        Wed, 16 Feb 2022 05:23:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id s2sm2127882ejs.113.2022.02.16.05.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:23:01 -0800 (PST)
Date:   Wed, 16 Feb 2022 21:22:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
Message-ID: <20220216132257.GB56419@leoy-ThinkPad-X240s>
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
 <20220205153940.GB391033@leoy-ThinkPad-X240s>
 <4d5951ee-d7d2-1e76-eb24-5f3c46d1662c@arm.com>
 <20220208130047.GA273989@leoy-ThinkPad-X240s>
 <e68839bc-b4f0-1fe8-1748-484254ded37a@arm.com>
 <20220211104528.GA475776@leoy-ThinkPad-X240s>
 <d59e99ad-dfc6-27ee-d952-7455d8e9fda6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d59e99ad-dfc6-27ee-d952-7455d8e9fda6@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:29:27PM +0000, German Gomez wrote:

[...]

> Thanks for the suggestion. I recorded the following stacktrace:
> 
>  perf-323841 [052] d.... 3996.528812: arm_spe_pmu_setup_aux: (arm_spe_pmu_setup_aux+0x60/0x1c0 [arm_spe_pmu])
>  perf-323841 [052] d.... 3996.528813: <stack trace>

Yeah, this show arm_spe_pmu_setup_aux() is called in perf process.

>  => kprobe_dispatcher
>  => kprobe_breakpoint_handler
>  => call_break_hook
>  => brk_handler
>  => do_debug_exception
>  => el1_dbg
>  => el1h_64_sync_handler
>  => el1h_64_sync
>  => arm_spe_pmu_setup_aux
>  => perf_mmap
>  => mmap_region
>  => do_mmap
>  => vm_mmap_pgoff
>  => ksys_mmap_pgoff
>  => __arm64_sys_mmap
>  => invoke_syscall
>  => el0_svc_common.constprop.0
>  => do_el0_svc
>  => el0_svc
>  => el0t_64_sync_handler
>  => el0t_64_sync
> 
> So for a v2 I may include something like this:

The change looks good to me, please see below minor comment.

> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index d44bcc29d..aadec5a0e 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -45,6 +45,7 @@ struct arm_spe_pmu_buf {
>      int                    nr_pages;
>      bool                    snapshot;
>      void                    *base;
> +    u64                    pmscr;
>  };
>  
>  struct arm_spe_pmu {
> @@ -748,7 +749,7 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
>          write_sysreg_s(reg, SYS_PMSICR_EL1);
>      }
>  
> -    reg = arm_spe_event_to_pmscr(event);
> +    reg = ((struct arm_spe_pmu_buf *) perf_get_aux(handle))->pmscr;
>      isb();
>      write_sysreg_s(reg, SYS_PMSCR_EL1);

Just nitpick (or it's just my preferring coding style), we can define
a local pointer variable 'buf':

  struct arm_spe_pmu_buf *buf = perf_get_aux(handle);

  ...

  isb();
  write_sysreg_s(buf->pmscr, SYS_PMSCR_EL1);

Thanks,
Leo

>  }
> @@ -855,6 +856,8 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
>      if (!pglist)
>          goto out_free_buf;
>  
> +    buf->pmscr = arm_spe_event_to_pmscr(event);
> +
>      for (i = 0; i < nr_pages; ++i)
>          pglist[i] = virt_to_page(pages[i]);
> 
> >
> > Thanks,
> > Leo
