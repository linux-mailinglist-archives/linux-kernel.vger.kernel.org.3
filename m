Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2609D52EFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351272AbiETQDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351277AbiETQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:03:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C209817CC85
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:03:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so12104739wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8majVaaRFX8Wh5ZOC9VJxfCvtD4QSkQyH31Ee4iRhsI=;
        b=Oe3ywFIqeVRmtO3/d4WWwP29CUpRc94g8g7K5iLFYXRJQuQiLxTwSbA6bcnyGRB3vj
         Lu/CW4jrs7BesV6bPGRBzAxTZWDAOoRbWl26Ta6MFGDMF3E+QCQiHpaIWz0iA7tzAQ9H
         ix3P1RZXnRgHuqLC1y83GUEWk8SQawubA/JSWd7MztNe18tovt3+wObY3W6H5wNDiwuG
         TfuXU9rYPqNWJLlwCiFVN3AGbaVqIid1cduvxsYgO52TG50p2139G0NmHTGKdkE1Pkum
         kuRC1m4za7SAxfIo0QWWU4pTrSQSxdAoQOPX1eCSCNVbZk0qmAuOd+A2qlaEZNMj/28D
         JbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8majVaaRFX8Wh5ZOC9VJxfCvtD4QSkQyH31Ee4iRhsI=;
        b=KP6VLQvIO82ybQSd57M9c67Weupv92Q2TKbwFDex/xkvXDvlorBq7WUVQYkoZEWs4N
         Krvstia4KUgP6/Az/TWq+TbnBZ5d88Hnd5/b+gOyzbjTjle2mrvwyij8AQfhgclXKSJW
         7EAEfOKPiq3h37jV4FkTfob5dVg+f6C2qq0Q9jCYB0H0G/ztOCL68ND3VXCl8lN+RFzz
         FTzVFRAwknnQ2jt4JwEZQRjE61IhTxLiD51d97S7YwHj4p0TFatmf6BF4pVJE7sRWu87
         /x4eTZLmgDp1FWC87LmT2hz3t23Dcs6eS9s/eCTYihnTDDQTew2LxeIhgmSKUCqRLpMO
         BsHw==
X-Gm-Message-State: AOAM533Hk6ZoG7VDtbhXGvIinGCgcfkhZCTVeamSAxcHsAq8V+2SV+Vo
        jZ8m13MI8bEdzK0HTsdV3qCtozpun3p74hzqSk10AQ==
X-Google-Smtp-Source: ABdhPJzXPKyz1kXDpsWAoOsigJ3lhRkAjSvk79H+yXKkZ+RmLOzHHwH5j8uu+MzzDFnrJcho5c3eiQxecOkPV2SAqBA=
X-Received: by 2002:adf:e70e:0:b0:20e:7523:f01d with SMTP id
 c14-20020adfe70e000000b0020e7523f01dmr4659346wrm.300.1653062579063; Fri, 20
 May 2022 09:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220517135805.313184-1-nick.forrington@arm.com> <20220517135805.313184-2-nick.forrington@arm.com>
In-Reply-To: <20220517135805.313184-2-nick.forrington@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 20 May 2022 09:02:46 -0700
Message-ID: <CAP-5=fWJpprvPaxoYE9YVq=eRjMKV0GOQky1AjWwdrAZqkh6rg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf vendors events arm64: Update Cortex A57/A72
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
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

On Tue, May 17, 2022 at 6:59 AM Nick Forrington <nick.forrington@arm.com> wrote:
>
> Categorise and add missing PMU events for Cortex-A57/A72, based on:
> https://github.com/ARM-software/data/blob/master/pmu/cortex-a57.json
> https://github.com/ARM-software/data/blob/master/pmu/cortex-a72.json
>
> These contain the same events, and are based on the Arm Technical
> Reference Manuals for Cortex-A57 and Cortex-A72.
>
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/arm64/arm/cortex-a57-a72/branch.json |  17 ++
>  .../arch/arm64/arm/cortex-a57-a72/bus.json    |  29 +++
>  .../arch/arm64/arm/cortex-a57-a72/cache.json  |  80 ++++++++
>  .../arm/cortex-a57-a72/core-imp-def.json      | 179 ------------------
>  .../arm64/arm/cortex-a57-a72/exception.json   |  47 +++++
>  .../arm64/arm/cortex-a57-a72/instruction.json |  68 +++++++
>  .../arch/arm64/arm/cortex-a57-a72/memory.json |  20 ++
>  7 files changed, 261 insertions(+), 179 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
>  delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
> new file mode 100644
> index 000000000000..2f2d137f5f55
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
> @@ -0,0 +1,17 @@
> +[
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED"
> +    },
> +    {
> +        "ArchStdEvent": "BR_PRED"
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDIRECT_SPEC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
> new file mode 100644
> index 000000000000..31505994c06c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
> @@ -0,0 +1,29 @@
> +[
> +    {
> +        "ArchStdEvent": "CPU_CYCLES"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_CYCLES"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_RD"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_WR"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_SHARED"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_NORMAL"
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_PERIPH"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
> new file mode 100644
> index 000000000000..1bd59e7d982b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
> @@ -0,0 +1,80 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_INVAL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_INVAL"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
> deleted file mode 100644
> index 543c7692677a..000000000000
> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
> +++ /dev/null
> @@ -1,179 +0,0 @@
> -[
> -    {
> -        "ArchStdEvent": "L1D_CACHE_RD"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_CACHE_WR"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_CACHE_INVAL"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_TLB_REFILL_RD"
> -    },
> -    {
> -        "ArchStdEvent": "L1D_TLB_REFILL_WR"
> -    },
> -    {
> -        "ArchStdEvent": "L2D_CACHE_RD"
> -    },
> -    {
> -        "ArchStdEvent": "L2D_CACHE_WR"
> -    },
> -    {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
> -    },
> -    {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
> -    },
> -    {
> -        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
> -    },
> -    {
> -        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
> -    },
> -    {
> -        "ArchStdEvent": "L2D_CACHE_INVAL"
> -    },
> -    {
> -        "ArchStdEvent": "BUS_ACCESS_RD"
> -    },
> -    {
> -        "ArchStdEvent": "BUS_ACCESS_WR"
> -    },
> -    {
> -        "ArchStdEvent": "BUS_ACCESS_SHARED"
> -    },
> -    {
> -        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
> -    },
> -    {
> -        "ArchStdEvent": "BUS_ACCESS_NORMAL"
> -    },
> -    {
> -        "ArchStdEvent": "BUS_ACCESS_PERIPH"
> -    },
> -    {
> -        "ArchStdEvent": "MEM_ACCESS_RD"
> -    },
> -    {
> -        "ArchStdEvent": "MEM_ACCESS_WR"
> -    },
> -    {
> -        "ArchStdEvent": "UNALIGNED_LD_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "UNALIGNED_ST_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "LDREX_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "STREX_PASS_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "STREX_FAIL_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "LD_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "ST_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "LDST_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "DP_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "ASE_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "VFP_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "PC_WRITE_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "CRYPTO_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "BR_IMMED_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "BR_RETURN_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "BR_INDIRECT_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "ISB_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "DSB_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "DMB_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_UNDEF"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_SVC"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_PABORT"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_DABORT"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_IRQ"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_FIQ"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_SMC"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_HVC"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_TRAP_PABORT"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_TRAP_DABORT"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_TRAP_OTHER"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_TRAP_IRQ"
> -    },
> -    {
> -        "ArchStdEvent": "EXC_TRAP_FIQ"
> -    },
> -    {
> -        "ArchStdEvent": "RC_LD_SPEC"
> -    },
> -    {
> -        "ArchStdEvent": "RC_ST_SPEC"
> -    }
> -]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
> new file mode 100644
> index 000000000000..344a2d552ad5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
> @@ -0,0 +1,47 @@
> +[
> +    {
> +        "ArchStdEvent": "EXC_TAKEN"
> +    },
> +    {
> +        "ArchStdEvent": "MEMORY_ERROR"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_UNDEF"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SVC"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_PABORT"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_DABORT"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_IRQ"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_FIQ"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SMC"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_HVC"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_PABORT"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_DABORT"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_OTHER"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_IRQ"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_FIQ"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
> new file mode 100644
> index 000000000000..e42486d406b3
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
> @@ -0,0 +1,68 @@
> +[
> +    {
> +        "ArchStdEvent": "SW_INCR"
> +    },
> +    {
> +        "ArchStdEvent": "INST_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_RETURN"
> +    },
> +    {
> +        "ArchStdEvent": "CID_WRITE_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "INST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "TTBR_WRITE_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "LDREX_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "STREX_PASS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "STREX_FAIL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "LD_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "LDST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "DP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "VFP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "PC_WRITE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "CRYPTO_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ISB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "DSB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "DMB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "RC_LD_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "RC_ST_SPEC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
> new file mode 100644
> index 000000000000..e3d08f1f7c92
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
> @@ -0,0 +1,20 @@
> +[
> +    {
> +        "ArchStdEvent": "MEM_ACCESS"
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD"
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_WR"
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
> +    }
> +]
> --
> 2.25.1
>
