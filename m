Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05D52A318
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347484AbiEQNUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbiEQNUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:20:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1F42EDA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:19:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x143so772570pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=60d3oJvctUxP/oTDei+2vsfAh7UJD05S6Mlxv1MfLJs=;
        b=sLa33qxuX7UQPweU8Gv5f68rW3IohaL9w81Io56m7BktAWuiQeYya2euk/CRddIg6X
         3dUMKSAN5oRPQe2+cL2YOeJFF57TqPja5oIE3IiMQSEDjAga6E6avBr+UBhtiRxbw1YH
         JbtcVjFjaTjJ0JN4CFvqiXDRBBu4Krsv6FtL0SikHC1nFxQKABO9wiCn2suidjv/4AH7
         FrbhUw9goNTqOserN4X52WYNhiU25LGiEC2RAe0OMcicYmMPvO13wwX89VoEfLXpVfQl
         C9gKhthX4plG4zN6Wg1otxB4fLsmZXvh3Ux12IumMnOIA8SJUw6uvyK/EMdz51rmxKFP
         TETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60d3oJvctUxP/oTDei+2vsfAh7UJD05S6Mlxv1MfLJs=;
        b=EAdDZHB76oWN0lSsgz7GU4iI4Vsgt13SETmU3lKPDHIaoBoXtyjMlV9l10EMpKzwq6
         KEkihXpK61lu9TfEITVxB2zO+2R1jSegCgdz7LdeLMiYSiUozoRNoXY8/BxffSbflmB/
         UkHQGiUyUo0OX9HjkW+4MEPFk8489+SMVhcFDuomaIPrbBKDtQf4M/SPvcpVH3lalo4w
         dik0JAZf6aGenkHXI5TkYQEbQ+2BHjxf0MrRg56HvpUKOOH/gkMNzQO1iVudccBOjqzU
         nnq+tY++4sb/VFKEUCQOUJIOwkHp57cEKNBxVUh5+Klt99s3fRwwrmQ+uz0uYh67K5u1
         MOpw==
X-Gm-Message-State: AOAM5329gh0r/zCHKvTRvrQcMfLmjvjO4AwmgRCYVJZxSZl9m3PeFSTF
        Xj7Ok7DMXQpwvvi7usFesvOuwA==
X-Google-Smtp-Source: ABdhPJwB9iU6V3h6T0XlcmvIfaDGUz0JvPDf0l9LKZih5qd1PFE8NwDzdbfnm0ljbPBHqRWK4ehk4w==
X-Received: by 2002:a05:6a00:174a:b0:50d:44ca:4b with SMTP id j10-20020a056a00174a00b0050d44ca004bmr22671394pfc.0.1652793598742;
        Tue, 17 May 2022 06:19:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090a910300b001df71667c3asm1569744pjo.54.2022.05.17.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:19:58 -0700 (PDT)
Date:   Tue, 17 May 2022 21:19:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] perf tools: arm64: Add support for VG register
Message-ID: <20220517131952.GE153558@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517102005.3022017-5-james.clark@arm.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:20:05AM +0100, James Clark wrote:
> Add the name of the VG register so it can be used in --user-regs
> 
> The event will fail to open if the register is requested but not
> available so only add it to the mask if the kernel supports sve and also
> if it supports that specific register.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm64/util/perf_regs.c | 34 ++++++++++++++++++++++++++
>  tools/perf/util/perf_regs.c            |  2 ++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
> index 476b037eea1c..c0a921512a90 100644
> --- a/tools/perf/arch/arm64/util/perf_regs.c
> +++ b/tools/perf/arch/arm64/util/perf_regs.c
> @@ -2,9 +2,11 @@
>  #include <errno.h>
>  #include <regex.h>
>  #include <string.h>
> +#include <sys/auxv.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  
> +#include "../../../perf-sys.h"
>  #include "../../../util/debug.h"
>  #include "../../../util/event.h"
>  #include "../../../util/perf_regs.h"
> @@ -43,6 +45,7 @@ const struct sample_reg sample_reg_masks[] = {
>  	SMPL_REG(lr, PERF_REG_ARM64_LR),
>  	SMPL_REG(sp, PERF_REG_ARM64_SP),
>  	SMPL_REG(pc, PERF_REG_ARM64_PC),
> +	SMPL_REG(vg, PERF_REG_ARM64_VG),
>  	SMPL_REG_END
>  };
>  
> @@ -131,3 +134,34 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>  
>  	return SDT_ARG_VALID;
>  }
> +
> +uint64_t arch__user_reg_mask(void)
> +{
> +	struct perf_event_attr attr = {
> +		.type                   = PERF_TYPE_HARDWARE,
> +		.config                 = PERF_COUNT_HW_CPU_CYCLES,
> +		.sample_type            = PERF_SAMPLE_REGS_USER,
> +		.disabled               = 1,
> +		.exclude_kernel         = 1,
> +		.sample_period		= 1,
> +		.sample_regs_user	= PERF_REGS_MASK
> +	};
> +	int fd;
> +
> +	if (getauxval(AT_HWCAP) & HWCAP_SVE)
> +		attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
> +
> +	/*
> +	 * Check if the pmu supports perf extended regs, before
> +	 * returning the register mask to sample.
> +	 */
> +	if (attr.sample_regs_user != PERF_REGS_MASK) {
> +		event_attr_init(&attr);
> +		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> +		if (fd != -1) {
> +			close(fd);
> +			return attr.sample_regs_user;
> +		}
> +	}

Just curious, since we can know SVE is supported from reading
auxiliary value, can we directly return the register mask as below?

  PERF_REGS_MASK | SMPL_REG_MASK(PERF_REG_ARM64_VG);

Except this question, this patch looks good to me.

Thanks,
Leo

> +	return PERF_REGS_MASK;
> +}
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index a982e40ee5a9..872dd3d38782 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -103,6 +103,8 @@ static const char *__perf_reg_name_arm64(int id)
>  		return "lr";
>  	case PERF_REG_ARM64_PC:
>  		return "pc";
> +	case PERF_REG_ARM64_VG:
> +		return "vg";
>  	default:
>  		return NULL;
>  	}
> -- 
> 2.28.0
> 
