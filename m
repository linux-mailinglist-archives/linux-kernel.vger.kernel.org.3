Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBBE4FD749
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380493AbiDLJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348755AbiDLJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:42:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0066307
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:49:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so26670611wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLO4zosCA8nE9DvNLF46kus59KF6UMHLO3hA0XUyCu0=;
        b=Azpijn2rOgdJZGUc0qVJDuSetYwfNNDb1vqJ5+Ql6G21GVtBQFksfp4CV9y9B9B9SC
         S4eL0SUV1ZH+RB3t1DuWAjGTtbFivC6WT5k8FcufblYh+QP/7IyJHUFBGRBrBIpLkRTW
         ulRuHeVO5ePiXhTgmul0SZ75dLfAYre/f2zjdQ2qSmHeIATUJjhq6DJA4lE086b1b9eI
         jJL2va9LhBD1dMVEi7NHherSmH7NGTUs+MnPpwNGe8K7hyA2j6r/s7BjP+QY2zGrAf2K
         aAVFb8gbiJLxP7gJgCFKY7hSXG7vjfEDimwaUD5MyYKt3nVVXBu6Td6c8v45nemGXaZ4
         71HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLO4zosCA8nE9DvNLF46kus59KF6UMHLO3hA0XUyCu0=;
        b=Vw4XyxhfWXZ6e2hvtPVndGYQjPX7+URTxcbc4y7srezDmngPByqIAVZHPo5wgTQzPQ
         cMkZLyy5fL27J78WvmGoz7s3B+xDgHcbIRl3R9Y3dHzoj31qvjCVOXSorWJMBZ6hnAjN
         vGu4108EOxxWZoVa5yal9GQ8jiasmudyLk4PALvjYfA1dH4axHXJW3Svpmb0yPgiE3bB
         nc8KTj4FCCfiNZs7ZpEMbK8v1ypdMPHyMQJZjeJHLYgkWX12XURmDAVW8a4P1brLr3kD
         mDYR/6YeeeR3QqZb+lw9egCgI3l1NYRtClXPnfeolpVn5H5fERni/bpr+BxG841b1mBa
         b0PA==
X-Gm-Message-State: AOAM532ATB2bLP7PR1RbNJ8stvirVgnuqJJ+nB/50AmPB3KmdBawNsji
        6WpqqyMHN/2t+2Dqigi+0uA9K4+tlPpOpjXDy1dgsw==
X-Google-Smtp-Source: ABdhPJxF95JCCcN5RhKTviM+y37q4+iL9Eoj2Mx9p2TEwsDmj/5Vlgen4Fx596H3QELIoIR7mjRa0J8WFgNv1+QVWI8=
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id
 98-20020adf816b000000b002037faea245mr28667247wrm.619.1649753356379; Tue, 12
 Apr 2022 01:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-7-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-7-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 09:49:04 +0100
Message-ID: <CAJ9a7VjwfoZg6HZfs7obzx2-AGMs0OL-2roTXjez04ik2dU4kA@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] coresight: etm4x: Cleanup TRCCONFIGR register accesses
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        Anshuman.Khandual@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 17:19, James Clark <james.clark@arm.com> wrote:
>
> This is a no-op change for style and consistency and has no effect on
> the binary output by the compiler. In sysreg.h fields are defined as
> the register name followed by the field name and then _MASK. This
> allows for grepping for fields by name rather than using magic numbers.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 12 ++---
>  .../coresight/coresight-etm4x-sysfs.c         | 46 +++++++++----------
>  drivers/hwtracing/coresight/coresight-etm4x.h | 16 +++++++
>  3 files changed, 44 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 3f4263117570..445e2057d5ed 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -633,7 +633,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>
>         /* Go from generic option to ETMv4 specifics */
>         if (attr->config & BIT(ETM_OPT_CYCACC)) {
> -               config->cfg |= BIT(4);
> +               config->cfg |= TRCCONFIGR_CCI;
>                 /* TRM: Must program this for cycacc to work */
>                 config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
>         }
> @@ -653,14 +653,14 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>                         goto out;
>
>                 /* bit[11], Global timestamp tracing bit */
> -               config->cfg |= BIT(11);
> +               config->cfg |= TRCCONFIGR_TS;
>         }
>
>         /* Only trace contextID when runs in root PID namespace */
>         if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
>             task_is_in_init_pid_ns(current))
>                 /* bit[6], Context ID tracing bit */
> -               config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
> +               config->cfg |= TRCCONFIGR_CID;
>
>         /*
>          * If set bit ETM_OPT_CTXTID2 in perf config, this asks to trace VMID
> @@ -672,17 +672,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>                         ret = -EINVAL;
>                         goto out;
>                 }
> -
>                 /* Only trace virtual contextID when runs in root PID namespace */
>                 if (task_is_in_init_pid_ns(current))
> -                       config->cfg |= BIT(ETM4_CFG_BIT_VMID) |
> -                                      BIT(ETM4_CFG_BIT_VMID_OPT);
> +                       config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
>         }
>
>         /* return stack - enable if selected and supported */
>         if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
>                 /* bit[12], Return stack enable bit */
> -               config->cfg |= BIT(12);
> +               config->cfg |= TRCCONFIGR_RS;
>
>         /*
>          * Set any selected configuration and preset.
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 21687cc1e4e2..53f84da3fe44 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -180,12 +180,12 @@ static ssize_t reset_store(struct device *dev,
>
>         /* Disable data tracing: do not trace load and store data transfers */
>         config->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
> -       config->cfg &= ~(BIT(1) | BIT(2));
> +       config->cfg &= ~(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE);
>
>         /* Disable data value and data address tracing */
>         config->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
>                            ETM_MODE_DATA_TRACE_VAL);
> -       config->cfg &= ~(BIT(16) | BIT(17));
> +       config->cfg &= ~(TRCCONFIGR_DA | TRCCONFIGR_DV);
>
>         /* Disable all events tracing */
>         config->eventctrl0 = 0x0;
> @@ -304,82 +304,82 @@ static ssize_t mode_store(struct device *dev,
>
>         if (drvdata->instrp0 == true) {
>                 /* start by clearing instruction P0 field */
> -               config->cfg  &= ~(BIT(1) | BIT(2));
> +               config->cfg  &= ~TRCCONFIGR_INSTP0_LOAD_STORE;
>                 if (config->mode & ETM_MODE_LOAD)
>                         /* 0b01 Trace load instructions as P0 instructions */
> -                       config->cfg  |= BIT(1);
> +                       config->cfg  |= TRCCONFIGR_INSTP0_LOAD;
>                 if (config->mode & ETM_MODE_STORE)
>                         /* 0b10 Trace store instructions as P0 instructions */
> -                       config->cfg  |= BIT(2);
> +                       config->cfg  |= TRCCONFIGR_INSTP0_STORE;
>                 if (config->mode & ETM_MODE_LOAD_STORE)
>                         /*
>                          * 0b11 Trace load and store instructions
>                          * as P0 instructions
>                          */
> -                       config->cfg  |= BIT(1) | BIT(2);
> +                       config->cfg  |= TRCCONFIGR_INSTP0_LOAD_STORE;
>         }
>
>         /* bit[3], Branch broadcast mode */
>         if ((config->mode & ETM_MODE_BB) && (drvdata->trcbb == true))
> -               config->cfg |= BIT(3);
> +               config->cfg |= TRCCONFIGR_BB;
>         else
> -               config->cfg &= ~BIT(3);
> +               config->cfg &= ~TRCCONFIGR_BB;
>
>         /* bit[4], Cycle counting instruction trace bit */
>         if ((config->mode & ETMv4_MODE_CYCACC) &&
>                 (drvdata->trccci == true))
> -               config->cfg |= BIT(4);
> +               config->cfg |= TRCCONFIGR_CCI;
>         else
> -               config->cfg &= ~BIT(4);
> +               config->cfg &= ~TRCCONFIGR_CCI;
>
>         /* bit[6], Context ID tracing bit */
>         if ((config->mode & ETMv4_MODE_CTXID) && (drvdata->ctxid_size))
> -               config->cfg |= BIT(6);
> +               config->cfg |= TRCCONFIGR_CID;
>         else
> -               config->cfg &= ~BIT(6);
> +               config->cfg &= ~TRCCONFIGR_CID;
>
>         if ((config->mode & ETM_MODE_VMID) && (drvdata->vmid_size))
> -               config->cfg |= BIT(7);
> +               config->cfg |= TRCCONFIGR_VMID;
>         else
> -               config->cfg &= ~BIT(7);
> +               config->cfg &= ~TRCCONFIGR_VMID;
>
>         /* bits[10:8], Conditional instruction tracing bit */
>         mode = ETM_MODE_COND(config->mode);
>         if (drvdata->trccond == true) {
> -               config->cfg &= ~(BIT(8) | BIT(9) | BIT(10));
> -               config->cfg |= mode << 8;
> +               config->cfg &= ~TRCCONFIGR_COND_MASK;
> +               config->cfg |= mode << __bf_shf(TRCCONFIGR_COND_MASK);
>         }
>
>         /* bit[11], Global timestamp tracing bit */
>         if ((config->mode & ETMv4_MODE_TIMESTAMP) && (drvdata->ts_size))
> -               config->cfg |= BIT(11);
> +               config->cfg |= TRCCONFIGR_TS;
>         else
> -               config->cfg &= ~BIT(11);
> +               config->cfg &= ~TRCCONFIGR_TS;
>
>         /* bit[12], Return stack enable bit */
>         if ((config->mode & ETM_MODE_RETURNSTACK) &&
>                                         (drvdata->retstack == true))
> -               config->cfg |= BIT(12);
> +               config->cfg |= TRCCONFIGR_RS;
>         else
> -               config->cfg &= ~BIT(12);
> +               config->cfg &= ~TRCCONFIGR_RS;
>
>         /* bits[14:13], Q element enable field */
>         mode = ETM_MODE_QELEM(config->mode);
>         /* start by clearing QE bits */
> -       config->cfg &= ~(BIT(13) | BIT(14));
> +       config->cfg &= ~(TRCCONFIGR_QE_W_COUNTS | TRCCONFIGR_QE_WO_COUNTS);
>         /*
>          * if supported, Q elements with instruction counts are enabled.
>          * Always set the low bit for any requested mode. Valid combos are
>          * 0b00, 0b01 and 0b11.
>          */
>         if (mode && drvdata->q_support)
> -               config->cfg |= BIT(13);
> +               config->cfg |= TRCCONFIGR_QE_W_COUNTS;
>         /*
>          * if supported, Q elements with and without instruction
>          * counts are enabled
>          */
>         if ((mode & BIT(1)) && (drvdata->q_support & BIT(1)))
> -               config->cfg |= BIT(14);
> +               config->cfg |= TRCCONFIGR_QE_WO_COUNTS;
>
>         /* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
>         if ((config->mode & ETM_MODE_ATB_TRIGGER) &&
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 3b604cde668b..4c8d7be3c159 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -172,6 +172,22 @@
>  #define TRCIDR5_NUMSEQSTATE_MASK               GENMASK(27, 25)
>  #define TRCIDR5_NUMCNTR_MASK                   GENMASK(30, 28)
>
> +#define TRCCONFIGR_INSTP0_LOAD                 BIT(1)
> +#define TRCCONFIGR_INSTP0_STORE                        BIT(2)
> +#define TRCCONFIGR_INSTP0_LOAD_STORE           (TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE)
> +#define TRCCONFIGR_BB                          BIT(3)
> +#define TRCCONFIGR_CCI                         BIT(4)
> +#define TRCCONFIGR_CID                         BIT(6)
> +#define TRCCONFIGR_VMID                                BIT(7)
> +#define TRCCONFIGR_COND_MASK                   GENMASK(10, 8)
> +#define TRCCONFIGR_TS                          BIT(11)
> +#define TRCCONFIGR_RS                          BIT(12)
> +#define TRCCONFIGR_QE_W_COUNTS                 BIT(13)
> +#define TRCCONFIGR_QE_WO_COUNTS                        BIT(14)
> +#define TRCCONFIGR_VMIDOPT                     BIT(15)
> +#define TRCCONFIGR_DA                          BIT(16)
> +#define TRCCONFIGR_DV                          BIT(17)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> --
> 2.28.0
>


Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
