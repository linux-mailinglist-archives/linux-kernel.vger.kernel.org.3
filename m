Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DC4980AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243084AbiAXNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:13:15 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53460 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242951AbiAXNNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:13:01 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nBz9V-00036x-42; Mon, 24 Jan 2022 14:12:57 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Subject: Re: [v5 6/9] RISC-V: Add perf platform driver based on SBI PMU extension
Date:   Mon, 24 Jan 2022 14:12:56 +0100
Message-ID: <13483045.gklhn8uf4L@diego>
In-Reply-To: <20211225054647.1750577-7-atishp@rivosinc.com>
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-7-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 25. Dezember 2021, 06:46:44 CET schrieb Atish Patra:
> From: Atish Patra <atish.patra@wdc.com>
> 
> RISC-V SBI specification added a PMU extension that allows to configure
> start/stop any pmu counter. The RISC-V perf can use most of the generic
> perf features except interrupt overflow and event filtering based on
> privilege mode which will be added in future.
> 
> It also allows to monitor a handful of firmware counters that can provide
> insights into firmware activity during a performance analysis.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---

[...]

> +static int pmu_sbi_device_probe(struct platform_device *pdev)
> +{
> +	struct riscv_pmu *pmu = NULL;
> +	int num_counters;
> +	int ret;
> +
> +	pr_info("SBI PMU extension is available\n");
> +	/* Notify legacy implementation that SBI pmu is available*/
> +	riscv_pmu_legacy_init(true);

Just wondering, shouldn't the riscv_pmu_legacy_init() call live in
pmu_sbi_devinit) below?

I.e. when you detected the presence of the PMU sbi extension you already
know that you don't want the legacy one and you have less control over
probe-ordering (when the driver actually probes) than the initcall itself.


Also, I think a better naming for the function might be good.
Right now just reading

	riscv_pmu_legacy_init(true);

suggests that you _want_ the legacy-init to be enabled, while
in reality the function means the opposite, disabling the legacy init.

So maybe something like
	riscv_pmu_disable_legacy(true); ?


Heiko

> +	pmu = riscv_pmu_alloc();
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	num_counters = pmu_sbi_find_num_ctrs();
> +	if (num_counters < 0) {
> +		pr_err("SBI PMU extension doesn't provide any counters\n");
> +		return -ENODEV;
> +	}
> +
> +	/* cache all the information about counters now */
> +	if (pmu_sbi_get_ctrinfo(num_counters))
> +		return -ENODEV;
> +
> +	pmu->num_counters = num_counters;
> +	pmu->ctr_start = pmu_sbi_ctr_start;
> +	pmu->ctr_stop = pmu_sbi_ctr_stop;
> +	pmu->event_map = pmu_sbi_event_map;
> +	pmu->ctr_get_idx = pmu_sbi_ctr_get_idx;
> +	pmu->ctr_get_width = pmu_sbi_ctr_get_width;
> +	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
> +	pmu->ctr_read = pmu_sbi_ctr_read;
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> +	if (ret)
> +		return ret;
> +
> +	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> +	if (ret) {
> +		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pmu_sbi_driver = {
> +	.probe		= pmu_sbi_device_probe,
> +	.driver		= {
> +		.name	= RISCV_PMU_PDEV_NAME,
> +	},
> +};
> +
> +static int __init pmu_sbi_devinit(void)
> +{
> +	int ret;
> +	struct platform_device *pdev;
> +
> +	if (((sbi_major_version() == 0) && (sbi_minor_version() < 3)) ||
> +		sbi_probe_extension(SBI_EXT_PMU) <= 0) {
> +		return 0;
> +	}
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
> +				      "perf/riscv/pmu:starting",
> +				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
> +	if (ret) {
> +		pr_err("CPU hotplug notifier for RISC-V PMU could not be registered: %d\n",
> +		       ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&pmu_sbi_driver);
> +	if (ret)
> +		return ret;
> +
> +	pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		platform_driver_unregister(&pmu_sbi_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return ret;
> +}
> +device_initcall(pmu_sbi_devinit)
> 




