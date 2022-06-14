Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC5454AE17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiFNKQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiFNKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:16:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7646CAB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:16:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z17so8164030pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oTkAGNxSsgwh181G3BLhMwBAv+cbui9P3idq5VmFQGM=;
        b=ES5ej2rgDrlGH8dRgEjHP3Ajh/fz1iwNUYmmemjcYKpXO5XFU3DOL8sS1zPlM1JWD/
         M+AG88HYuxLOm3X17LYS9mjsPMlJKZE+3tCTtPc3aVA6rQC9mnqtrYZn1mjKhS1jIiC1
         i2ubhSGZ2bkD0h9vsRgzr6ggfg6ObI4/+QEiwNpy+ppHhkuWjtSty78AUbV3gbYV9X5a
         u1Vy/dCrbAVGNRUFXaA+ogcXdsbYy8eQF5ucglzPhsvc+B0XbjqkGjCOofQk3ZMsLIsc
         QAOB29EOmUKzaJ41u+2tFlZT5SkJuuhic2htcM80Q8Q2owjvblFxtZR/LREicRdjDm9M
         UJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oTkAGNxSsgwh181G3BLhMwBAv+cbui9P3idq5VmFQGM=;
        b=fOu10OugcuGErrlLH9JZg2dwnbrJ6WFdeI1r6wxzyiUcppAmfj3On+mz/9326Z7Hl2
         528T3rQE0aMAcHhkTLwff+9qzvta52xZJUiDpu+263bw4AiIWQIqmT8tLdDhfmpOfZ9J
         nCWRUF1VciUy2earMFB3fOaLdcfqKW+Kd6FMpnZDBMlBxEt9r2obfO8XHpIYHJgidzUj
         FBdx9LM12TlPT646mtxXpwXdnAoYHO9D5e1iZfj2fiXtJpDK6k46e63fObwqaig2h5tF
         2s/08tFh27hMEo+7rmtPBx3bJN1OmkFeq4lMIFVbNh0KNfcWghMfgDXiGwfabK9jgGv7
         5A5w==
X-Gm-Message-State: AJIora9r8V5X/La9NCsHFQHxDbBPpkOWydvsNTviZCEd40/lT18jBGtj
        rFMKibXb0hR3jAaQFKV6k9LXGQ==
X-Google-Smtp-Source: AGRyM1t2q5DkfR+x8hOBD7VS8Mfd6S1lbkh60IoJKjXPNhpv6TAtDjhd1eKRVbE6QRwjKL/3vmHhoQ==
X-Received: by 2002:a05:6a00:cca:b0:51b:ed40:b08a with SMTP id b10-20020a056a000cca00b0051bed40b08amr3668131pfv.19.1655201768714;
        Tue, 14 Jun 2022 03:16:08 -0700 (PDT)
Received: from sunil-laptop ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b0051b97714703sm7022842pfw.187.2022.06.14.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:16:08 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:46:00 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?utf-8?B?Sm/Do28gTcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] RISC-V: Create unique identification for SoC PMU
Message-ID: <20220614101600.GA53270@sunil-laptop>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
 <20220607131648.29439-2-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607131648.29439-2-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Tue, Jun 07, 2022 at 04:16:44PM +0300, Nikita Shubin wrote:
> From: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> 
> The SBI PMU platform driver did not provide any identification for
> perf events matching. This patch introduces a new sysfs file inside the
> platform device (soc:pmu/id) for pmu identification.
> 
> The identification is a 64-bit value generated as:
> [63-32]: mvendorid;
> [31]: marchid[MSB];
> [30-16]: marchid[15-0];
> [15-0]: mimpid[15MSBs];
> 
> The CSRs are detailed in the RISC-V privileged spec [1].
> The marchid is split in MSB + 15LSBs, due to the MSB being used for
> open-source architecture identification.
> 
> [1] https://github.com/riscv/riscv-isa-manual
> 
> Signed-off-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> Tested-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>  arch/riscv/kernel/sbi.c      |  3 +++
>  drivers/perf/riscv_pmu_sbi.c | 47 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..50dd9b6ecc9e 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
>  {
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
>  }
> +EXPORT_SYMBOL(sbi_get_mvendorid);
>  
>  long sbi_get_marchid(void)
>  {
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
>  }
> +EXPORT_SYMBOL(sbi_get_marchid);
>  
>  long sbi_get_mimpid(void)
>  {
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
>  }
> +EXPORT_SYMBOL(sbi_get_mimpid);
>  
>  static void sbi_send_cpumask_ipi(const struct cpumask *target)
>  {
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a1317a483512..15ab3dc68e7a 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -693,6 +693,46 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  	return 0;
>  }
>  
> +static uint64_t pmu_sbi_get_pmu_id(void)
> +{
> +	union sbi_pmu_id {
> +		uint64_t value;
> +		struct {
> +			uint16_t imp:16;
> +			uint16_t arch:16;
> +			uint32_t vendor:32;
> +		};
> +	} pmuid;
> +
> +	pmuid.value = 0;
> +	pmuid.vendor = (uint32_t) sbi_get_mvendorid();
> +	pmuid.arch = (sbi_get_marchid() >> (63 - 15) & (1 << 15)) | (sbi_get_marchid() & 0x7FFF);

This statement generates below warning in rv32 build.

drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_get_pmu_id':
 drivers/perf/riscv_pmu_sbi.c:715:41: warning: right shift count >=
 width of type [-Wshift-count-overflow]
  715 |        pmuid.arch = (sbi_get_marchid() >> (63 - 15) & (1 << 15))
  | (sbi_get_marchid() & 0x7FFF);
     

Please take care of this when you rework this patch.

Thanks
Sunil

> +	pmuid.imp = (sbi_get_mimpid() >> 16);
> +
> +	return pmuid.value;
> +}
> +
> +static ssize_t pmu_sbi_id_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	int len;
> +
> +	len = sprintf(buf, "0x%llx\n", pmu_sbi_get_pmu_id());
> +	if (len <= 0)
> +		dev_err(dev, "mydrv: Invalid sprintf len: %dn", len);
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR(id, S_IRUGO | S_IWUSR, pmu_sbi_id_show, 0);
> +
> +static struct attribute *pmu_sbi_attrs[] = {
> +	&dev_attr_id.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(pmu_sbi);
> +
>  static int pmu_sbi_device_probe(struct platform_device *pdev)
>  {
>  	struct riscv_pmu *pmu = NULL;
> @@ -729,6 +769,13 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
>  	pmu->ctr_read = pmu_sbi_ctr_read;
>  
> +	ret = sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
> +	if (ret) {
> +		dev_err(&pdev->dev, "sysfs creation failed\n");
> +		return ret;
> +	}
> +	pdev->dev.groups = pmu_sbi_groups;
> +
>  	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  	if (ret)
>  		return ret;
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
