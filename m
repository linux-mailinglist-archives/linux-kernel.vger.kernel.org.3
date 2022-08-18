Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975B25990CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiHRXBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHRXBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:01:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16843C9EBA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:01:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c24so2386002pgg.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=SxaLsX428RZ1ZZyMkLyl/R5gnokZLMcHhNXNy7HvM88=;
        b=4+Y1eqAiSxrv3E//VJOhwkg21D0C7aB4SuNyn+JjsLKC7DbPsOtjZWhnGw2mRfsutM
         E1PX4UErDhJZVs/98LTU5RAjvUaEsGOHujGX2T6KDVh09ayC3+dR94khPNTnpFIdouJ0
         lLzYwf38HARVztEwMQiEmwDSvIi/B7FG79sHmkaEPCcPmD0zh42aDtjfdYHz2rj16o8F
         s+ZVFOrbD8ECGqHSvvnEVgTB9rta8Wi4SJjKz2igTa6HOeNHozFPDAtu/Vc+4aDXqHCS
         BB09QsEy1rjSqkN6cxqtm6giw80SjKkQYNnlgL/DpyY9Sznb4t5OfxPAbom5ehHVNfq7
         9t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=SxaLsX428RZ1ZZyMkLyl/R5gnokZLMcHhNXNy7HvM88=;
        b=BbTj8r/HGSwSJyD+AHsHk6BWsPSF0X+9gsFiuSBc4eNsWlpB6QXz6ISpCGlvYIEipR
         nvGqZzwRj6GxnrqgBg9jAWLtePsep1dsABAcYHW0sF9Y5c98c9DzcbRTOefCg4QowUR9
         BVbL2KO2YZ92/B5zKHMjsk1kdZxIsSAdytJETQbcpJwk6+51g7CnoWWj4j6uiMOBcPyy
         YZGZiWWvBQ3GxrmAOb/yahjWUoSiJsKMI+DCzapX6IUIHV38BSPHVL/wNUn1ZCEHBoDo
         KOo6OREV5FLVJmpUuuB9BVPoWQ1hxsvcfWT1v9DTKfd15aEXn5O+H5V6/mxjwgiEOi7P
         HfqA==
X-Gm-Message-State: ACgBeo3XT8AQI91hU0gL3iack6pnSm8QfwOyXi81F7PPUhriCSsBb32I
        1sBEzryjkmKWfNL+ZvxfcjCcVg==
X-Google-Smtp-Source: AA6agR4QWYuIV+qJ9p70dFLi1/xjsepfLeYAl9faAJ8phNMASnzbYpPMSRRVeZfJRDtc7u1ZjwizFQ==
X-Received: by 2002:a05:6a00:2409:b0:534:98c0:e53a with SMTP id z9-20020a056a00240900b0053498c0e53amr4995295pfh.11.1660863709462;
        Thu, 18 Aug 2022 16:01:49 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a6e0d00b001f2fa09786asm2041811pjk.19.2022.08.18.16.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:01:48 -0700 (PDT)
Date:   Thu, 18 Aug 2022 16:01:48 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Aug 2022 14:36:50 PDT (-0700)
Subject:     Re: [PATCH] perf: riscv legacy: fix kerneldoc comment warning
In-Reply-To: <20220812143532.1962623-1-conor.dooley@microchip.com>
CC:     atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     conor.dooley@microchip.com
Message-ID: <mhng-1907479c-dc4c-40c0-8cf1-4c4fb2b8a804@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 07:35:32 PDT (-0700), conor.dooley@microchip.com wrote:
> Fix the warning:
> drivers/perf/riscv_pmu_legacy.c:76: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Fixes: 9b3e150e310e ("RISC-V: Add a simple platform driver for RISC-V legacy perf")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index 342778782359..2c20b0de8cb0 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -72,7 +72,7 @@ static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
>  	local64_set(&hwc->prev_count, initial_val);
>  }
>
> -/**
> +/*
>   * This is just a simple implementation to allow legacy implementations
>   * compatible with new RISC-V PMU driver framework.
>   * This driver only allows reading two counters i.e CYCLE & INSTRET.

Thanks, this is on riscv/fixes -- given how trivial the actual diff is 
I'm OK just taking it without the Ack/Review from anyone else, doubly so 
because I probably broke it the first place.
