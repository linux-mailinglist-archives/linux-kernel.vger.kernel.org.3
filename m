Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D094BA737
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiBQRfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:35:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiBQRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:35:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03452B04A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:35:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d27so10321252wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRCdZMkcIxUVwSBHB2GWnc1ofQ7iJSL4NNdZG9r2K80=;
        b=yVPMfbJXCzijsV9omxwJJqtvi55kkbE7UpdaTvDW2xNhDj8fj5VM+6It4OPqheRa7a
         030lFLNJ8Re36ILZ29C136bNfxln+msk91I3OaFUo+LUcU6o+BOdA7pHZZSM7r3MACLT
         I4CCkfC1w4W61vwgtPoCrSKiAJs9EDIEKI+oGLqtPB4jPjbhUsdvL0GXSRk43hEN+Ily
         kY6MaFUim0MSFQlvbazbsfGmkHNXDUzXg7mfAm/gTll9PtYQyyHXmR/XhJY972oVvTHz
         Qqm+LLEDge1qzecchv1h5lefsAkZLWswGIUANIN4Sn8pOagJWgFVH7zeLd2ZDbmZhydD
         s7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRCdZMkcIxUVwSBHB2GWnc1ofQ7iJSL4NNdZG9r2K80=;
        b=v3HKMg8RyP4Sf543cILZ92/b/Jx48xBageMF42NsM8hG6Etw3XDFh1YAJpyE99tBRm
         iRaVc8SEixYBnSmRYCeLbnMaSvzkcyax5lCN0zQeayD1RLwVGCRlwrw30+ov3xs+E6yh
         EjHpR4jKpVd4IbeEPEFL1zp3kYMmVmyfUZQuzxciGFQekhhNxf4OWuUNiVNjtJEBW4Sj
         UMaFIQxtPeqCqbbymJx7IbL8hpIKV1RXA6vWG3oC5W/tKZkgYRYY8InIBqCxZzPMaBgF
         uvt7k0S3rRTlX4GclvnaF3T8EX8MDv/EIEp+0hpzvaL8KXvRRC8YhsYKC74KJ0u1nsXa
         zbDA==
X-Gm-Message-State: AOAM533DoLSo7rIlFKJKlyGNJU8wTw0VOJKAzLghgtSyn4DvNDlxWLlQ
        UrbQRz3LA7Q+V7OSbSqgRZ3N6jQMOtLwfXgQmF6hNA==
X-Google-Smtp-Source: ABdhPJwV2rypE1JfqTqxxGZ7Jeeva6Vt8AVtID5UxRkwrmKUUJ7vpDOvWrVUiMg4nt9wYvuOunxceOUvKIlTpzlqVek=
X-Received: by 2002:adf:d4c7:0:b0:1e3:31ae:fd49 with SMTP id
 w7-20020adfd4c7000000b001e331aefd49mr3059989wrk.519.1645119313382; Thu, 17
 Feb 2022 09:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com> <20220209105706.18852-3-quic_jinlmao@quicinc.com>
In-Reply-To: <20220209105706.18852-3-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 17 Feb 2022 17:35:02 +0000
Message-ID: <CAJ9a7Vj2eZOD-2v5Y+CPgBZiDsAw39N8YFK3xX4sozc1Rs1D=Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] coresight: Use bitmap to assign trace id to the sources
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Feb 2022 at 10:57, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Except from STM and ETM/ETE, there could be other sources. Each
> source needs a unique trace id. Define a bitmap for the trace ids.
> The position of each bit represents trace id of the source.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 48 ++++++++++++++++++++
>  include/linux/coresight-pmu.h                | 11 +++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index a90097f88425..6cb55c3f41d5 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/mutex.h>
>  #include <linux/clk.h>
>  #include <linux/coresight.h>
> +#include <linux/coresight-pmu.h>

see my comment below about using coresigh-priv.h

>  #include <linux/of_platform.h>
>  #include <linux/delay.h>
>  #include <linux/pm_runtime.h>
> @@ -25,8 +26,11 @@
>  #include "coresight-syscfg.h"
>
>  static DEFINE_MUTEX(coresight_mutex);
> +static DEFINE_MUTEX(coresight_id_mutex);
>  static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>
> +static DECLARE_BITMAP(coresight_trace_id, CORESIGHT_TRACE_ID_NUM);
> +
>  /*
>   * Use IDR to map the hash length of the source's device name
>   * to the pointer of path for the source
> @@ -51,6 +55,48 @@ struct coresight_node {
>  const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
>  EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
>
> +/* Init the coresight_trace_id bit map. */
> +static void coresight_init_trace_id(void)
> +{
> +       int i;
> +
> +       /* Trace id 0 is invalid. */
> +       set_bit(CORESIGHT_TRACE_ID_0, coresight_trace_id);
> +       /* Trace id 1 is fixed for STM. */
> +       set_bit(CORESIGHT_TRACE_ID_1, coresight_trace_id);
> +       /* Trace id from 112 to 127 are reserved. */
> +       for (i = CORESIGHT_TRACE_ID_112; i <= CORESIGHT_TRACE_ID_127; i++)
> +               set_bit(i, coresight_trace_id);
> +       /* Skip the trace ids of ETM/ETE. */
> +       for (i = 0; i <= cpumask_last(cpu_possible_mask); i++)
> +               set_bit(coresight_get_trace_id(i), coresight_trace_id);
> +
> +}
> +
> +/*
> + * Return the first zero bit position of bitmap coresight_trace_id
> + * as source's trace id.
> + *
> + */
> +int coresight_get_system_trace_id(void)
> +{
> +       int id;
> +
> +       mutex_lock(&coresight_id_mutex);
> +       id = find_first_zero_bit(coresight_trace_id, CORESIGHT_TRACE_ID_NUM);
> +       /* If no zero bit is found, return error value. */
> +       if (id == CORESIGHT_TRACE_ID_NUM) {
> +               mutex_unlock(&coresight_id_mutex);
> +               return -EINVAL;
> +       }
> +
> +       set_bit(id, coresight_trace_id);
> +       mutex_unlock(&coresight_id_mutex);
> +
> +       return id;
> +}
> +EXPORT_SYMBOL(coresight_get_system_trace_id);
> +
>  static const struct cti_assoc_op *cti_assoc_ops;
>
>  void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
> @@ -1750,6 +1796,8 @@ static int __init coresight_init(void)
>                 return 0;
>
>         etm_perf_exit();
> +
> +       coresight_init_trace_id();
>  exit_bus_unregister:
>         bus_unregister(&coresight_bustype);
>         return ret;
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 4ac5c081af93..1e2c5ca4c6e6 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -32,6 +32,14 @@
>  #define ETM4_CFG_BIT_RETSTK    12
>  #define ETM4_CFG_BIT_VMID_OPT  15
>

The following additional defines and function should appear in coresight-priv.h
The coresight-pmu.h file contains data for the interface between the
drivers and perf.


> +/* Coresight component supports 7 bits trace id. */

additional comment here to explain that 0, 0x70- 0x7F IDs are reserved
by the architecture, 1 is default for STM

> +#define CORESIGHT_TRACE_ID_NUM 128
> +
> +#define CORESIGHT_TRACE_ID_0   0
> +#define CORESIGHT_TRACE_ID_1   1
> +#define CORESIGHT_TRACE_ID_112 112
> +#define CORESIGHT_TRACE_ID_127 127
> +

can we have these names a little more descriptive -
e.g.
CORESIGHT_TRACE_ID_0_RES 0
CORESIGHT_TRACE_ID_STM  1
CORESIGHT_TRACE_ID_RANGE_LO_RES 0x70
CORESIGHT_TRACE_ID_RANGE_HI_RES  0x7F

Additionally - now we are declaring a #define for the STM ID - it
would be better to use that in coresight-stm.c stm_init_default_data()
to set the trace id for the STM.

Regards

Mike

>  static inline int coresight_get_trace_id(int cpu)
>  {
>         /*
> @@ -43,4 +51,7 @@ static inline int coresight_get_trace_id(int cpu)
>         return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
>  }
>
> +/* Get the trace id for the sources except from STM, ETM/ETE. */
> +extern int coresight_get_system_trace_id(void);
> +
>  #endif
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
