Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86B4F74DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbiDGEkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiDGEkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:40:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8B82AEC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 21:38:42 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220407043837epoutp01584d2713fcca5dc4271b3aebf65c5f89~jg1trhu3Z1948019480epoutp01j
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 04:38:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220407043837epoutp01584d2713fcca5dc4271b3aebf65c5f89~jg1trhu3Z1948019480epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649306317;
        bh=VHmiI3d9Xut6qR1GYICSsDU2ZZOA18eRLKHPPyc307U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gsLIui/26xmkGg1aggE86NzFbPATs+W5xDdBC7PqVyhV9A8IItAFFbyCp5m3ig1oQ
         HrSE8zos0LU7JVxVlQhTLVesGxXIgoH2/N86f0tjDlarHycEODlt3LJlcAeYAPpLJp
         3UMZmlu6EWdyBhKkn0UDHkFSCAGvD2g0l4dSXiMQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220407043836epcas1p13f0f98ede8308b35b0f47a79dfa6b61b~jg1szUUrR0490404904epcas1p1P;
        Thu,  7 Apr 2022 04:38:36 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.235]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KYpY61BKFz4x9QC; Thu,  7 Apr
        2022 04:38:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.DB.08277.9CA6E426; Thu,  7 Apr 2022 13:38:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220407043833epcas1p4c3282e9e8cfcff21a51689e6d2293050~jg1qYaJLo2685326853epcas1p4M;
        Thu,  7 Apr 2022 04:38:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220407043833epsmtrp1a1bcb069d063580f30896571bb102714~jg1qXh0UA0407204072epsmtrp1R;
        Thu,  7 Apr 2022 04:38:33 +0000 (GMT)
X-AuditID: b6c32a36-1edff70000002055-71-624e6ac9a435
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.30.24342.9CA6E426; Thu,  7 Apr 2022 13:38:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220407043833epsmtip2893e9265cfc281b777249027ed4cd0b3~jg1qDrOc40096900969epsmtip2c;
        Thu,  7 Apr 2022 04:38:33 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] soc: rockchip: power-domain: Manage resource
 conflicts with firmware
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c8664eae-4a10-bd1a-8898-01b96c05331e@samsung.com>
Date:   Thu, 7 Apr 2022 14:04:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmnu6pLL8kg/vWFps+vme1OLvsIJvF
        /0evgaymN+wWmx5fY7W4vGsOm8Xn3iOMFp8e/Ge2uN24gs3i1sSbTA5cHrMbLrJ4bF5S7/F3
        1n4Wj74tqxg9tl+bx+zxeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
        kkJeYm6qrZKLT4CuW2YO0GFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALTAr3i
        xNzi0rx0vbzUEitDAwMjU6DChOyM2atWsRW8CKy4NIGrgXGqYxcjJ4eEgInE4ScnmbsYuTiE
        BHYwSrRM/cYO4XxilPi19iArhPONUaJzwk5WmJa2F0uhWvYySvTuXsMI4bxnlDg+v40JpEpY
        IFni+7FGsCoRgaWMEje2vwNLMAvcYJTonqEEYrMJaEnsf3GDDcTmF1CUuPrjMSOIzStgJzH3
        4Ad2EJtFQEVi1sz5LCC2qECYxMltLVA1ghInZz4Bi3MCxc8972SEmC8ucevJfKhd8hLb384B
        O0JCYAuHxN1bc5khfnCR2HhvKhuELSzx6vgWdghbSuJlfxs7REMzo0TDi9uMEE4Po8TRZ30s
        EFXGEvuXTgZawQG0QlNi/S59iLCixM7fc6Gu4JN497WHFaREQoBXoqNNCKJEWeLyg7tMELak
        xOL2TrYJjEqzkPwzC8kPs5D8MAth2QJGllWMYqkFxbnpqcWGBUbw+E7Oz93ECE62WmY7GCe9
        /aB3iJGJg/EQowQHs5IIb1WuT5IQb0piZVVqUX58UWlOavEhRlNgCE9klhJNzgem+7ySeEMT
        SwMTMyNjEwtDM0Mlcd5V004nCgmkJ5akZqemFqQWwfQxcXBKNTCZ98RWyP6uMzspcHQKq4WG
        5cF/565P/rP/pezSGe/N4loy70vd3z3rfijT2bv+gosnMPr/FuBgaMsrs97xe7UJY63qXgPr
        JrNtfQqnQtoYKsR36nIqsVeHbWm4K/s4MmR6XG3EZPsY/j16pb7TDrcquspmGH3eLTWFoTTF
        Y87lOXVKS478au6f8HnlJM7f0sWmGmdX5/crij5vrS971pjkLOAkMit5X+Xd99YO3l9N67gc
        79+xW8257dJkXpOEH9P+35j4mnXy8+OXfhiYS++vsBGyyn7253XG8S++AS0HT8m1hKdldz5w
        Xv55kWdmeVWW4cqz04wClmcvXW/8ZcahExJFy+S8F7G8XlmptE+JpTgj0VCLuag4EQBlqM7u
        PwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSvO7JLL8kgyVT5C02fXzPanF22UE2
        i/+PXgNZTW/YLTY9vsZqcXnXHDaLz71HGC0+PfjPbHG7cQWbxa2JN5kcuDxmN1xk8di8pN7j
        76z9LB59W1Yxemy/No/Z4/MmuQC2KC6blNSczLLUIn27BK6M2atWsRW8CKy4NIGrgXGqYxcj
        J4eEgIlE24ulzF2MXBxCArsZJS5sWMgOkZCUmHbxKFCCA8gWljh8uBii5i1QzaxmFpAaYYFk
        ie/HGsGaRQSWMkr07//FBuIwC9xglJh+fBsLRMt9RonuyT+YQVrYBLQk9r+4wQZi8wsoSlz9
        8ZgRxOYVsJOYe/AD2GoWARWJWTPng60QFQiT2LnkMRNEjaDEyZlPwOKcQPFzzzvBepkF1CX+
        zLvEDGGLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNS
        y/WKE3OLS/PS9ZLzczcxguNOS3MH4/ZVH/QOMTJxMB5ilOBgVhLhrcr1SRLiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qByXBP+fkK6V0dK1fIq0nMFNlS
        NHG2zONtxcqzzEO9/nyL+jI74XFc8bKm88fqKjJzl91ZHfB/9bvtJsvPMisGxIlXSe5ViRPl
        VNwj/vKuxfyctiqXsjVnRQpvPg+Y/ay7sbn+6ckNW//8tbJJuR08L+ihaOMF8fbC2Ny5Alu2
        ztv4NyjfRVmlny3xHcPnKIOnHZL1fFGmJrnPvRM/uBYH75q7k+HpgicJq7obZc1+GjO+dOMV
        /1uxdM6px63ld+aoSE14M6dmX9ztnx8EmFISUsQlJ3AEbJ1iHLQqXH3ixhmB74+yHjW1FDPI
        e9mgZ5vxSlfwyGVztyl99jqb9347elA1Wd577a/DfyvnvExQVGIpzkg01GIuKk4EAIyYoecq
        AwAA
X-CMS-MailID: 20220407043833epcas1p4c3282e9e8cfcff21a51689e6d2293050
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220406094558epcas1p4fa0c77a5acd6b73c192f6b19136cd5f9
References: <20220406014842.2771799-1-briannorris@chromium.org>
        <CGME20220406094558epcas1p4fa0c77a5acd6b73c192f6b19136cd5f9@epcas1p4.samsung.com>
        <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Thanks for very detailed description.
I understand this issue.

Instead of adding the specific function for only rockchip,
how about adding new function pointer (like block/unblock or start/stop and others)
into 'struct generic_pm_domain'? And add new pm_genpd_* function
to control the power domain. Because it is better to use subsystem interface.

Best Regards,
Chanwoo Choi


On 4/6/22 10:48 AM, Brian Norris wrote:
> On RK3399 platforms, power domains are managed mostly by the kernel
> (drivers/soc/rockchip/pm_domains.c), but there are a few exceptions
> where ARM Trusted Firmware has to be involved:
> 
> (1) system suspend/resume
> (2) DRAM DVFS (a.k.a., "ddrfreq")
> 
> Exception (1) does not cause much conflict, since the kernel has
> quiesced itself by the time we make the relevant PSCI call.
> 
> Exception (2) can cause conflict, because of two actions:
> 
> (a) ARM Trusted Firmware needs to read/modify/write the PMU_BUS_IDLE_REQ
>     register to idle the memory controller domain; the kernel driver
>     also has to touch this register for other domains.
> (b) ARM Trusted Firmware needs to manage the clocks associated with
>     these domains.
> 
> To elaborate on (b): idling a power domain has always required ungating
> an array of clocks; see this old explanation from Rockchip:
> https://lore.kernel.org/linux-arm-kernel/54503C19.9060607@rock-chips.com/
> 
> Historically, ARM Trusted Firmware has avoided this issue by using a
> special PMU_CRU_GATEDIS_CON0 register -- this register ungates all the
> necessary clocks -- when idling the memory controller. Unfortunately,
> we've found that this register is not 100% sufficient; it does not turn
> the relevant PLLs on [0].
> 
> So it's possible to trigger issues with something like the following:
> 
> 1. enable a power domain (e.g., RK3399_PD_VDU) -- kernel will
>    temporarily enable relevant clocks/PLLs, then turn them back off
>    2. a PLL (e.g., PLL_NPLL) is part of the clock tree for
>       RK3399_PD_VDU's clocks but otherwise unused; NPLL is disabled
> 3. perform a ddrfreq transition (rk3399_dmcfreq_target() -> ...
>    drivers/clk/rockchip/clk-ddr.c / ROCKCHIP_SIP_DRAM_FREQ)
>    4. ARM Trusted Firmware unagates VDU clocks (via PMU_CRU_GATEDIS_CON0)
>    5. ARM Trusted firmware idles the memory controller domain
>    6. Step 5 waits on the VDU domain/clocks, but NPLL is still off
> 
> i.e., we hang the system.
> 
> So for (b), we need to at a minimum manage the relevant PLLs on behalf
> of firmware. It's easier to simply manage the whole clock tree, in a
> similar way we do in rockchip_pd_power().
> 
> For (a), we need to provide mutual exclusion betwen rockchip_pd_power()
> and firmware. To resolve that, we simply grab the PMU mutex and release
> it when ddrfreq is done.
> 
> The Chromium OS kernel has been carrying versions of part of this hack
> for a while, based on some new custom notifiers [1]. I've rewritten as a
> simple function call between the drivers, which is OK because:
> 
>  * the PMU driver isn't enabled, and we don't have this problem at all
>    (the firmware should have left us in an OK state, and there are no
>    runtime conflicts); or
>  * the PMU driver is present, and is a single instance.
> 
> And the power-domain driver cannot be removed, so there's no lifetime
> management to worry about.
> 
> For completeness, there's a 'dmc_pmu_mutex' to guard (likely
> theoretical?) probe()-time races. It's OK for the memory controller
> driver to start running before the PMU, because the PMU will avoid any
> critical actions during the block() sequence.
> 
> [0] The RK3399 TRM for PMU_CRU_GATEDIS_CON0 only talks about ungating
>     clocks. Based on experimentation, we've found that it does not power
>     up the necessary PLLs.
> 
> [1] CHROMIUM: soc: rockchip: power-domain: Add notifier to dmc driver
>     https://chromium-review.googlesource.com/q/I242dbd706d352f74ff706f5cbf42ebb92f9bcc60
>     Notably, the Chromium solution only handled conflict (a), not (b).
>     In practice, item (b) wasn't a problem in many cases because we
>     never managed to fully power off PLLs. Now that the (upstream) video
>     decoder driver performs runtime clock management, we often power off
>     NPLL.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/soc/rockchip/pm_domains.c | 118 ++++++++++++++++++++++++++++++
>  include/soc/rockchip/pm_domains.h |  25 +++++++
>  2 files changed, 143 insertions(+)
>  create mode 100644 include/soc/rockchip/pm_domains.h
> 
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 1b029e494274..bc0afc52299b 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -8,6 +8,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/err.h>
> +#include <linux/mutex.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_domain.h>
>  #include <linux/of_address.h>
> @@ -16,6 +17,7 @@
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/syscon.h>
> +#include <soc/rockchip/pm_domains.h>
>  #include <dt-bindings/power/px30-power.h>
>  #include <dt-bindings/power/rk3036-power.h>
>  #include <dt-bindings/power/rk3066-power.h>
> @@ -139,6 +141,109 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
>  	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>  
> +/*
> + * Dynamic Memory Controller may need to coordinate with us -- see
> + * rockchip_pmu_block().
> + *
> + * dmc_pmu_mutex protects registration-time races, so DMC driver doesn't try to
> + * block() while we're initializing the PMU.
> + */
> +static DEFINE_MUTEX(dmc_pmu_mutex);
> +static struct rockchip_pmu *dmc_pmu;
> +
> +/*
> + * Block PMU transitions and make sure they don't interfere with ARM Trusted
> + * Firmware operations. There are two conflicts, noted in the comments below.
> + *
> + * Caller must unblock PMU transitions via rockchip_pmu_unblock().
> + */
> +int rockchip_pmu_block(void)
> +{
> +	struct rockchip_pmu *pmu;
> +	struct generic_pm_domain *genpd;
> +	struct rockchip_pm_domain *pd;
> +	int i, ret;
> +
> +	mutex_lock(&dmc_pmu_mutex);
> +
> +	/* No PMU (yet)? Then we just block rockchip_pmu_probe(). */
> +	if (!dmc_pmu)
> +		return 0;
> +	pmu = dmc_pmu;
> +
> +	/*
> +	 * mutex blocks all idle transitions: we can't touch the
> +	 * PMU_BUS_IDLE_REQ (our ".idle_offset") register while ARM Trusted
> +	 * Firmware might be using it.
> +	 */
> +	mutex_lock(&pmu->mutex);
> +
> +	/*
> +	 * Power domain clocks: Per Rockchip, we *must* keep certain clocks
> +	 * enabled for the duration of power-domain transitions. Most
> +	 * transitions are handled by this driver, but some cases (in
> +	 * particular, DRAM DVFS / memory-controller idle) must be handled by
> +	 * firmware. Firmware can handle most clock management via a special
> +	 * "ungate" register (PMU_CRU_GATEDIS_CON0), but unfortunately, this
> +	 * doesn't handle PLLs. We can assist this transition by doing the
> +	 * clock management on behalf of firmware.
> +	 */
> +	for (i = 0; i < pmu->genpd_data.num_domains; i++) {
> +		genpd = pmu->genpd_data.domains[i];
> +		if (genpd) {
> +			pd = to_rockchip_pd(genpd);
> +			ret = clk_bulk_enable(pd->num_clks, pd->clks);
> +			if (ret < 0) {
> +				dev_err(pmu->dev,
> +					"failed to enable clks for domain '%s': %d\n",
> +					genpd->name, ret);
> +				goto err;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i = i - 1; i >= 0; i--) {
> +		genpd = pmu->genpd_data.domains[i];
> +		if (genpd) {
> +			pd = to_rockchip_pd(genpd);
> +			clk_bulk_disable(pd->num_clks, pd->clks);
> +		}
> +	}
> +	mutex_unlock(&pmu->mutex);
> +	mutex_unlock(&dmc_pmu_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_pmu_block);
> +
> +/* Unblock PMU transitions. */
> +void rockchip_pmu_unblock(void)
> +{
> +	struct rockchip_pmu *pmu;
> +	struct generic_pm_domain *genpd;
> +	struct rockchip_pm_domain *pd;
> +	int i;
> +
> +	if (dmc_pmu) {
> +		pmu = dmc_pmu;
> +		for (i = 0; i < pmu->genpd_data.num_domains; i++) {
> +			genpd = pmu->genpd_data.domains[i];
> +			if (genpd) {
> +				pd = to_rockchip_pd(genpd);
> +				clk_bulk_disable(pd->num_clks, pd->clks);
> +			}
> +		}
> +
> +		mutex_unlock(&pmu->mutex);
> +	}
> +
> +	mutex_unlock(&dmc_pmu_mutex);
> +}
> +EXPORT_SYMBOL_GPL(rockchip_pmu_unblock);
> +
>  static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
>  {
>  	struct rockchip_pmu *pmu = pd->pmu;
> @@ -690,6 +795,12 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  
>  	error = -ENODEV;
>  
> +	/*
> +	 * Prevent any rockchip_pmu_block() from racing with the remainder of
> +	 * setup (clocks, register initialization).
> +	 */
> +	mutex_lock(&dmc_pmu_mutex);
> +
>  	for_each_available_child_of_node(np, node) {
>  		error = rockchip_pm_add_one_domain(pmu, node);
>  		if (error) {
> @@ -719,10 +830,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  		goto err_out;
>  	}
>  
> +	/* We only expect one PMU. */
> +	if (!WARN_ON_ONCE(dmc_pmu))
> +		dmc_pmu = pmu;
> +
> +	mutex_unlock(&dmc_pmu_mutex);
> +
>  	return 0;
>  
>  err_out:
>  	rockchip_pm_domain_cleanup(pmu);
> +	mutex_unlock(&dmc_pmu_mutex);
>  	return error;
>  }
>  
> diff --git a/include/soc/rockchip/pm_domains.h b/include/soc/rockchip/pm_domains.h
> new file mode 100644
> index 000000000000..7dbd941fc937
> --- /dev/null
> +++ b/include/soc/rockchip/pm_domains.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2022, The Chromium OS Authors. All rights reserved.
> + */
> +
> +#ifndef __SOC_ROCKCHIP_PM_DOMAINS_H__
> +#define __SOC_ROCKCHIP_PM_DOMAINS_H__
> +
> +#ifdef CONFIG_ROCKCHIP_PM_DOMAINS
> +
> +int rockchip_pmu_block(void);
> +void rockchip_pmu_unblock(void);
> +
> +#else /* CONFIG_ROCKCHIP_PM_DOMAINS */
> +
> +static inline int rockchip_pmu_block(void)
> +{
> +	return 0;
> +}
> +
> +static inline void rockchip_pmu_unblock(void) { }
> +
> +#endif /* CONFIG_ROCKCHIP_PM_DOMAINS */
> +
> +#endif /* __SOC_ROCKCHIP_PM_DOMAINS_H__ */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
