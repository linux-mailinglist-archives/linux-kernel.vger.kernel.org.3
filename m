Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384BD475401
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhLOIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:02:26 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:57984 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233451AbhLOICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:02:25 -0500
Received: from sas1-369099ba34c4.qloud-c.yandex.net (sas1-369099ba34c4.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3d96:0:640:3690:99ba])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 646B845C3FB6;
        Wed, 15 Dec 2021 11:02:18 +0300 (MSK)
Received: from sas1-7a2c1d25dbfc.qloud-c.yandex.net (sas1-7a2c1d25dbfc.qloud-c.yandex.net [2a02:6b8:c08:c9f:0:640:7a2c:1d25])
        by sas1-369099ba34c4.qloud-c.yandex.net (mxback/Yandex) with ESMTP id PtHqElSo2Z-2HfuGowU;
        Wed, 15 Dec 2021 11:02:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1639555338;
        bh=bcZSGKL367ori0UFRkqTy8+oGoWm2KH6xaqkLIRJDZg=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=hcqh8T87JyccZqYMJrd+7jEZo5+qpM4qpRnVZFUGrDCHq/ZA/Agr0vq3N0c2NwR5L
         /pj5GAS53e5sapd9LSMTFVt2wA0HYAGJx+tNESH7z7KIgWb0yrZH0U3802B4Fk+R08
         mz7sjIDtFfSiE3CXDmVCFioR6N9Bo46XUuVefhwo=
Authentication-Results: sas1-369099ba34c4.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-7a2c1d25dbfc.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3cfgOP4KNN-2FPqUg6l;
        Wed, 15 Dec 2021 11:02:15 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Wed, 15 Dec 2021 11:02:14 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [v4 05/11] RISC-V: Add RISC-V SBI PMU extension definitions
Message-ID: <20211215110214.62ca2474@redslave.neermore.group>
In-Reply-To: <20211025195350.242914-6-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
        <20211025195350.242914-6-atish.patra@wdc.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish!

On Mon, 25 Oct 2021 12:53:44 -0700
Atish Patra <atish.patra@wdc.com> wrote:

> This patch adds all the definitions defined by the SBI PMU extension.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 97
> ++++++++++++++++++++++++++++++++++++ 1 file changed, 97 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h
> b/arch/riscv/include/asm/sbi.h index 0d42693cb65e..7a14ca06ba8f 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>  	SBI_EXT_IPI = 0x735049,
>  	SBI_EXT_RFENCE = 0x52464E43,
>  	SBI_EXT_HSM = 0x48534D,
> +	SBI_EXT_PMU = 0x504D55,
>  };
>  
>  enum sbi_ext_base_fid {
> @@ -70,6 +71,99 @@ enum sbi_hsm_hart_status {
>  	SBI_HSM_HART_STATUS_STOP_PENDING,
>  };
>  
> +
> +enum sbi_ext_pmu_fid {
> +	SBI_EXT_PMU_NUM_COUNTERS = 0,
> +	SBI_EXT_PMU_COUNTER_GET_INFO,
> +	SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +	SBI_EXT_PMU_COUNTER_START,
> +	SBI_EXT_PMU_COUNTER_STOP,
> +	SBI_EXT_PMU_COUNTER_FW_READ,
> +};
> +
> +#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
> +#define RISCV_PMU_RAW_EVENT_IDX 0x20000
> +
> +/** General pmu event codes specified in SBI PMU extension */
> +enum sbi_pmu_hw_generic_events_t {
> +	SBI_PMU_HW_NO_EVENT			= 0,
> +	SBI_PMU_HW_CPU_CYCLES			= 1,
> +	SBI_PMU_HW_INSTRUCTIONS			= 2,
> +	SBI_PMU_HW_CACHE_REFERENCES		= 3,
> +	SBI_PMU_HW_CACHE_MISSES			= 4,
> +	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
> +	SBI_PMU_HW_BRANCH_MISSES		= 6,
> +	SBI_PMU_HW_BUS_CYCLES			= 7,
> +	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
> +	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
> +	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
> +
> +	SBI_PMU_HW_GENERAL_MAX,
> +};
> +
> +/**
> + * Special "firmware" events provided by the firmware, even if the
> hardware
> + * does not support performance events. These events are encoded as
> a raw
> + * event type in Linux kernel perf framework.
> + */
> +enum sbi_pmu_fw_generic_events_t {
> +	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
> +	SBI_PMU_FW_MISALIGNED_STORE	= 1,
> +	SBI_PMU_FW_ACCESS_LOAD		= 2,
> +	SBI_PMU_FW_ACCESS_STORE		= 3,
> +	SBI_PMU_FW_ILLEGAL_INSN		= 4,
> +	SBI_PMU_FW_SET_TIMER		= 5,
> +	SBI_PMU_FW_IPI_SENT		= 6,
> +	SBI_PMU_FW_IPI_RECVD		= 7,
> +	SBI_PMU_FW_FENCE_I_SENT		= 8,
> +	SBI_PMU_FW_FENCE_I_RECVD	= 9,
> +	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
> +	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
> +	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
> +	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
> +
> +	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
> +	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
> +	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
> +	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
> +
> +	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
> +	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
> +	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
> +	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
> +	SBI_PMU_FW_MAX,
> +};
> +
> +/* SBI PMU event types */
> +enum sbi_pmu_event_type {
> +	SBI_PMU_EVENT_TYPE_HW = 0x0,
> +	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
> +	SBI_PMU_EVENT_TYPE_RAW = 0x2,
> +	SBI_PMU_EVENT_TYPE_FW = 0xf,
> +};
> +
> +/* SBI PMU event types */
> +enum sbi_pmu_ctr_type {
> +	SBI_PMU_CTR_TYPE_HW = 0x0,
> +	SBI_PMU_CTR_TYPE_FW,
> +};
> +
> +/* Flags defined for config matching function */
> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
> +#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
> +#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 3)
> +#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 4)
> +#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
> +#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 6)
> +#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 7)

It looks like you have a typo here, the defines in OpenSBI are
different:

#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)


> +
> +/* Flags defined for counter start function */
> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +
> +/* Flags defined for counter stop function */
> +#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> @@ -82,6 +176,9 @@ enum sbi_hsm_hart_status {
>  #define SBI_ERR_INVALID_PARAM	-3
>  #define SBI_ERR_DENIED		-4
>  #define SBI_ERR_INVALID_ADDRESS	-5
> +#define SBI_ERR_ALREADY_AVAILABLE -6
> +#define SBI_ERR_ALREADY_STARTED -7
> +#define SBI_ERR_ALREADY_STOPPED -8
>  
>  extern unsigned long sbi_spec_version;
>  struct sbiret {

