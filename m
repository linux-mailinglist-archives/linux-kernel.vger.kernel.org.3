Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F4523134
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiEKLNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiEKLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:13:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6D1ED284;
        Wed, 11 May 2022 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652267594; x=1683803594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VE7K9gMh3/DHq2/WOHPkc6irQyhIwSWoqYEC5egAEPc=;
  b=jX6x9KVBqYU9jTB35LbtOfvPORxVgxdhuSc3iTDXNTEGPbRe+SaO39Oq
   QarwULEpXjjbVr8MUIpZPst0dQKMrGTxkH02LjCE7Px/NEGc/35ZVJTcI
   tcCoty3WkZvz4lICxjlzKFNFSY4UEhoTTpI/iErpiOaqIWyaKY/L5s3vQ
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2022 04:13:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 04:13:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 04:13:12 -0700
Received: from [10.50.27.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 04:13:07 -0700
Message-ID: <7a7b4657-ec75-7984-1a6e-50ff928ab09c@quicinc.com>
Date:   Wed, 11 May 2022 16:43:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs
Content-Language: en-US
To:     Shreyas K K <quic_shrekk@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Andre Przywara <andre.przywara@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>
References: <20220511080247.1530-1-quic_shrekk@quicinc.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220511080247.1530-1-quic_shrekk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreyas,

On 5/11/2022 1:32 PM, Shreyas K K wrote:
> Add KRYO4XX gold/big cores to the list of CPUs that need the
> repeat TLBI workaround. Apply this to the affected
> KRYO4XX cores (rcpe to rdpe).
>
> The variant and revision bits are implementation defined and are
> different from the their Cortex CPU counterparts on which they are
> based on, i.e., (r0p0 to r1p0) is equivalent to (rcpe to rdpe).
>
> Signed-off-by: Shreyas K K <quic_shrekk@quicinc.com>
> ---
>   Documentation/arm64/silicon-errata.rst | 3 +++
>   arch/arm64/kernel/cpu_errata.c         | 2 ++
>   2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 466cb9e89047..d27db84d585e 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -189,6 +189,9 @@ stable kernels.
>   +----------------+-----------------+-----------------+-----------------------------+
>   | Qualcomm Tech. | Kryo4xx Silver  | N/A             | ARM64_ERRATUM_1024718       |
>   +----------------+-----------------+-----------------+-----------------------------+
> +| Qualcomm Tech. | Kryo4xx Gold    | N/A             | ARM64_ERRATUM_1286807       |
> ++----------------+-----------------+-----------------+-----------------------------+
> +
>   +----------------+-----------------+-----------------+-----------------------------+
>   | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
>   +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 4c9b5b4b7a0b..2518657e6de1 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -208,6 +208,8 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
>   #ifdef CONFIG_ARM64_ERRATUM_1286807
>   	{
>   		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
> +		/* Kryo4xx Gold (rcpe to rdpe) => (r0p0 to r1p0) */
> +		ERRATA_MIDR_RANGE(QCOM_CPU_PART_KRYO_4XX_GOLD, 0xc, 0xe, 0xd, 0xe),
>   	},
>   #endif
>   	{},

Why not include r2p0 and r3p0 which are affected by this erratum? I see these revisions are present
in our SoCs as per the document.

Thanks,
Sai
