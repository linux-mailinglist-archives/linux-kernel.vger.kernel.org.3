Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE9533D12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbiEYM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiEYM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:58:28 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E8A2053
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:58:27 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 90so7286249uam.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlfGy88ZCD4lOyKadsaMaTpiuM8NkVCXt/blXBLLSuM=;
        b=WHFRS+3QBk6oxN3FURojB0WbB+U5Yk4Tva5DSe1TmlglfwC6xSB79PK/twKoeeqJ1Y
         gQflcIaHygkWIFezpZLWDfiOFK22NGlWiFbkUz+Yj9mUz4IxO5AgavlQVUh0kzFDtPAK
         a+B3yfQtzc9NgH4DISF44l9SiUYBu3GDdx9ixgMeH5sxMf8Yvs+zgemvkbfX2vO6ONo0
         r+YOZWI+r7OSj8wrgAO+9rps8TxuTpl3N6RfXJGU/gnwbeyBYfnPaB5nXonXH+0eXJS9
         D5Hdo1CY2iAnRhw5CeM976/rMLav8uhQr3sPxmOyPXwcb6ZJDQ9mbfgXWWb9SebA8+Lx
         HtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlfGy88ZCD4lOyKadsaMaTpiuM8NkVCXt/blXBLLSuM=;
        b=qST4jl4eZl0dwuPjhIqk+GI3KsEnc+yyaThclYa7zEfFsoGgnHVDuwgPrsPUXLUVRR
         wodaDyR49lXzQomWY++7wosoTE15uRfVvxVoqVZUZnHie8fJunTXEGPTIXNQdWkp948W
         7tlW8qcm1P6gPSGYFVA5u7vljRfVNpPZN5tsF40Cl6a3gK4M+LsFeZ62XOWW+Bh4zpGQ
         jLxs5fEfFGUla2P9wP17oFig5B9gA9jZb38Y2M+fMxZZFRd3yqqifVwu0xlQVJn5ycJN
         SqV0mlZcAeXR+cxMIZJC4SmOUUZ0ChZwkOHKu28y//EL0iTm2M7Sqj5KPrWx+zVr6eAK
         zAjw==
X-Gm-Message-State: AOAM530N7TAVq61oY9ChXzBZDkIpkZjUTiTNsEer2qkZ/cpQWxC3dyMV
        BDxoRXqtzJr7MA1RLKG9VscHo4H3ZAUmyEQrVdJP2g==
X-Google-Smtp-Source: ABdhPJzfhaqn9oVCwhK40BxeJIQuF35mF5wePsIFZ0TXRA5Q0PqzCtwusZwnQpv5NWrM7h8rgrwcPPg78uDjv8XYTps=
X-Received: by 2002:ab0:310b:0:b0:368:c7b0:5a6c with SMTP id
 e11-20020ab0310b000000b00368c7b05a6cmr10054921ual.108.1653483506483; Wed, 25
 May 2022 05:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220525093938.4101-1-ravi.bangoria@amd.com> <20220525093938.4101-5-ravi.bangoria@amd.com>
In-Reply-To: <20220525093938.4101-5-ravi.bangoria@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 25 May 2022 15:58:15 +0300
Message-ID: <CABPqkBQ-4vpG_d-u-Q-pTQ_wDg_HhqNNC3dSLFE6MS5Bp3qTDw@mail.gmail.com>
Subject: Re: [PATCH 04/13] perf/x86/amd: Support PERF_SAMPLE_WEIGHT using IBS OP_DATA3[IbsDcMissLat]
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
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

On Wed, May 25, 2022 at 12:42 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS Op data3 provides data cache miss latency which can be passed as
> sample->weight along with perf_mem_data_src. Note that sample->weight
> will be populated only when PERF_SAMPLE_DATA_SRC is also set, although
> both sample types are independent.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 6626caeed6a1..5a6e278713f4 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -738,6 +738,12 @@ static void perf_ibs_get_mem_lvl(struct perf_event *event, u64 op_data2,
>                 return;
>         }
>
> +       /* Load latency (Data cache miss latency) */
> +       if (data_src->mem_op == PERF_MEM_OP_LOAD &&
> +           event->attr.sample_type & PERF_SAMPLE_WEIGHT) {
> +               data->weight.full = (op_data3 & IBS_DC_MISS_LAT_MASK) >> IBS_DC_MISS_LAT_SHIFT;
> +       }
> +
I think here you also need to handle the WEIGHT_STRUCT case and put
the cache miss latency in the right
field. This IBS field covers the cache line movement and not the whole
instruction latency which is the tag to ret field.
In the case of WEIGHT_STRUCT you need to fill out the two fields.

>         /* L2 Hit */
>         if ((op_data3 & IBS_L2_MISS_MASK) == 0) {
>                 /* Erratum #1293 */
> --
> 2.31.1
>
