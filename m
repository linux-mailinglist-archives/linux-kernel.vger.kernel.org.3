Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E835910C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiHLM0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbiHLMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:25:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8EF60502
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:25:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220812122541euoutp02717a8bfa89a710752b733880a949327e~KmIxWfe1H1944419444euoutp02M
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:25:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220812122541euoutp02717a8bfa89a710752b733880a949327e~KmIxWfe1H1944419444euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660307141;
        bh=WESLTj5OX5vVlhcNzo7Y0VD2lQ0iI5c5Q/Vx9qNnQPg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=V5mdsljhgtqOP1e8bXJI0jLTy5GMCRKx0l+mReH2XaT9SZGKtfgVmY5MN6F1VvtfM
         Pi3KqcoPD1N9GOW8ZLlw8SllOQkNo0YVy40BJFbXaENUbNcy+Nk55iHro1BxacNwSL
         eXuktyZFInIMsWf8l1Bsoj0DkjU0PUXiJMsqPnNk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220812122540eucas1p2734d63c9a9a6c1c5017f89f058b44f86~KmIw9GaPA2658126581eucas1p2J;
        Fri, 12 Aug 2022 12:25:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5D.62.10067.4C646F26; Fri, 12
        Aug 2022 13:25:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220812122540eucas1p2abdde59aaf1837c34e0aed594339bc72~KmIwdyvRZ2580425804eucas1p2O;
        Fri, 12 Aug 2022 12:25:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220812122540eusmtrp28655a74bcd1fb8d2c8de53260db57b9a~KmIwc2Ydi0040000400eusmtrp2l;
        Fri, 12 Aug 2022 12:25:40 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-9d-62f646c4c986
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.6B.09095.4C646F26; Fri, 12
        Aug 2022 13:25:40 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220812122539eusmtip1a014347098a791f9f93116cdda114141~KmIvuXHOT3016730167eusmtip1I;
        Fri, 12 Aug 2022 12:25:39 +0000 (GMT)
Message-ID: <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
Date:   Fri, 12 Aug 2022 14:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220726200739.30017-2-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7pH3L4lGdx6pWoxoaOVyeLXFwuL
        zXOKLTpnb2C32Pt6K7vFpsfXWC0u75rDZjHj/D4mi3+9BxktDn54wmrxvA/IPXX3M7vF8feP
        GS1a7pg68Hk8OTiPyWPNvDWMHjtn3WX3WLCp1GPTqk42jzvX9rB5bF5S7/Fi80xGj74tqxg9
        Pm+SC+CK4rJJSc3JLEst0rdL4Mo4POU1c8HapIqDfcuZGhgf+3YxcnJICJhI3Jr2kK2LkYtD
        SGAFo8T5i/uZQBJCAl8YJQ4f94VIfGaU+PfnI2MXIwdYx+sfqRDx5YwSPWdWMUM4Hxklvi27
        zwzSzStgJ7FwdhMriM0ioCpxYtc9Roi4oMTJmU9YQGxRgWSJZ/8Xs4PYwgJuEtvPTgGLMwuI
        S9x6Mh/sChGBNImr/+6zgixgFtjBLPF1zk2wIjYBQ4mut11sIDangIPEms65TBDN8hLb384B
        u0hCYDOnxMkf0xkhHnWRODrhHCuELSzx6vgWdghbRuL/TpBtIK/lS/ydYQwRrpC49noNM4Rt
        LXHn3C82kBJmAU2J9bv0IcKOEt+m7WOD6OSTuPFWEOICPolJ26YzQ4R5JTrahCCq1SRmHV8H
        t/PghUvMExiVZiEFyiwkz89C8ssshL0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525i
        BCa70/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4yxZ9ThLiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        m5y5IVFIID2xJDU7NbUgtQgmy8TBKdXAVHXyw9Jd0x/2GO+QtBGf7Gb16s8tfp6UfUnKYpsq
        X7y2/zXnee25eKei3pnTptT9NrpxJ1ZO7I+4QddttfQ6tY7dKy8dvFB5O9IscOnUS3niD2ND
        bkzi2XH0u8pOn6vBfta33nqb81UuXbnc5VzHvCghw4mJMl2ZK590Pjl/PTTdOT7I2EqlIXKl
        VJ5Y6ZavG6Lqwm/bNN+c/29D3s/48KUpu0tYN4WwRW1Y5plzP0WgyO7Rxlvltq9V7zOteFDY
        dPHSrV9SLFfzsmafPmexddVk2aX5NyZwGWq4c1+XWjr9isCMcy/6cmpWmtdxCt2o23HD+JTh
        ilPbW69VX3VKldzns6zRgOl3jjlXWqa2vBJLcUaioRZzUXEiAL9o89/lAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7pH3L4lGczcwWoxoaOVyeLXFwuL
        zXOKLTpnb2C32Pt6K7vFpsfXWC0u75rDZjHj/D4mi3+9BxktDn54wmrxvA/IPXX3M7vF8feP
        GS1a7pg68Hk8OTiPyWPNvDWMHjtn3WX3WLCp1GPTqk42jzvX9rB5bF5S7/Fi80xGj74tqxg9
        Pm+SC+CK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0Ms4POU1c8HapIqDfcuZGhgf+3YxcnBICJhIvP6R2sXIxSEksJRRYvuTryxdjJxAcRmJk9Ma
        WCFsYYk/17rYIIreM0r8njudGSTBK2AnsXB2E1gRi4CqxIld9xgh4oISJ2c+ARskKpAsseDQ
        UjBbWMBNYvvZKWA2s4C4xK0n85lAbBGBNIl9k14zgixgFtjFLNHT9ooFYttJRondbcvYQarY
        BAwlut6CnMHJwSngILGmcy4TxCQzia6tXYwQtrzE9rdzmCcwCs1CcsgsJAtnIWmZhaRlASPL
        KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAo33bs5+YdjPNefdQ7xMjEwXiIUYKDWUmEt2zR
        5yQh3pTEyqrUovz4otKc1OJDjKbA0JjILCWanA9MM3kl8YZmBqaGJmaWBqaWZsZK4ryeBR2J
        QgLpiSWp2ampBalFMH1MHJxSDUxtU2oaFgl+P2POM1v7WvLJn2sl5d8sk7mQtEREKGymZswe
        Vl7ue3uUfflZIl2vat0zcgpQ4ze9ff7nselXRaLMlUUynhd+STty6+yLJDnFu1zPX/J2XuYN
        lvXcpaqxcpUda96ryRFTJrM/T/58M3xtG6/v07KqTR/3uPzuX3JLyo2p67bwhfD3U6df2i2e
        +7avrzzsAve5ZY/m66mcD5d//LlueuIe97r+qvwE28JNP+fvdtcp3bqYd+69plk1gidfN7z/
        Vv1y2/Onz6ZMypF+vKjjj+vjNSlFCt+TapYzbzyec2XWjx43sZj/+QGaYdWHVop9PdjEbdmy
        LMLDo2hzy5f1F/o+73yr/s1i7c18JZbijERDLeai4kQAjnlrK3sDAAA=
X-CMS-MailID: 20220812122540eucas1p2abdde59aaf1837c34e0aed594339bc72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
        <CGME20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228@eucas1p2.samsung.com>
        <20220726200739.30017-2-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 26.07.2022 22:07, Sam Protsenko wrote:
> Fault info obtaining is implemented for SysMMU v1..v5 in a very hardware
> specific way, as it relies on:
>    - interrupt bits being tied to read or write access
>    - having separate registers for the fault address w.r.t. AR/AW ops
>
> Newer SysMMU versions (like SysMMU v7) have different way of providing
> the fault info via registers:
>    - the transaction type (read or write) should be read from the
>      register (instead of hard-coding it w.r.t. corresponding interrupt
>      status bit)
>    - there is only one single register for storing the fault address
>
> Because of that, it is not possible to add newer SysMMU support into
> existing paradigm. Also it's not very effective performance-wise:
>    - checking SysMMU version in ISR each time is not necessary
>    - performing linear search to find the fault info by interrupt bit can
>      be replaced with a single lookup operation
>
> Pave the way for adding support for new SysMMU versions by abstracting
> the getting of fault info in ISR. While at it, do some related style
> cleanups as well.
>
> This is mostly a refactoring patch, but there are some minor functional
> changes:
>    - fault message format is a bit different; now instead of AR/AW
>      prefixes for the fault's name, the request direction is printed as
>      [READ]/[WRITE]. It has to be done to prepare an abstraction for
>      SysMMU v7 support
>    - don't panic on unknown interrupts; print corresponding message and
>      continue
>    - if fault wasn't recovered, panic with some sane message instead of
>      just doing BUG_ON()
>
> The whole fault message looks like this now:
>
>      [READ] PAGE FAULT occurred at 0x12341000
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

I'm not very happy with converting the sysmmu_fault_info arrays into the 
decoding functions. If I got the code right, adding v7 is still possible 
with the current approach. The main advantage of the array-based 
approach is readability and keeping all the information together in a 
single place.

I agree for the items listed above as 'minor functional changes', 
though. Those sysmmu_fault_info arrays might be a part of sysmmu hw 
variant to avoid decoding hw version for each fault.

I'm not sure that the linear scan is so problematic with regards to the 
performance. You really don't want your drivers to trigger IOMMU fault 
so often during normal operation. It is just a way to get some debugging 
information or handle some exception.

You mentioned that the transaction type is read from the separate 
register in case of v7, but your code (here and in second patch) still 
relies on the reported interrupt bits.

Could you try to rework all your changes in a such way, that the 
sysmmu_fault_info arrays are still used? V7 is really very similar to 
the v5 already supported by the current driver.

> ---
>   drivers/iommu/exynos-iommu.c | 162 +++++++++++++++++++++--------------
>   1 file changed, 100 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 8e18984a0c4f..766d409e084a 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -185,38 +185,36 @@ static sysmmu_pte_t *page_entry(sysmmu_pte_t *sent, sysmmu_iova_t iova)
>   				lv2table_base(sent)) + lv2ent_offset(iova);
>   }
>   
> -/*
> - * IOMMU fault information register
> - */
> -struct sysmmu_fault_info {
> -	unsigned int bit;	/* bit number in STATUS register */
> -	unsigned short addr_reg; /* register to read VA fault address */
> +struct sysmmu_fault {
> +	sysmmu_iova_t addr;	/* IOVA address that caused fault */
> +	const char *name;	/* human readable fault name */
> +	unsigned int type;	/* fault type for report_iommu_fault() */
> +};
> +
> +struct sysmmu_v1_fault_info {
> +	unsigned short addr_reg; /* register to read IOVA fault address */
>   	const char *name;	/* human readable fault name */
>   	unsigned int type;	/* fault type for report_iommu_fault */
>   };
>   
> -static const struct sysmmu_fault_info sysmmu_faults[] = {
> -	{ 0, REG_PAGE_FAULT_ADDR, "PAGE", IOMMU_FAULT_READ },
> -	{ 1, REG_AR_FAULT_ADDR, "AR MULTI-HIT", IOMMU_FAULT_READ },
> -	{ 2, REG_AW_FAULT_ADDR, "AW MULTI-HIT", IOMMU_FAULT_WRITE },
> -	{ 3, REG_DEFAULT_SLAVE_ADDR, "BUS ERROR", IOMMU_FAULT_READ },
> -	{ 4, REG_AR_FAULT_ADDR, "AR SECURITY PROTECTION", IOMMU_FAULT_READ },
> -	{ 5, REG_AR_FAULT_ADDR, "AR ACCESS PROTECTION", IOMMU_FAULT_READ },
> -	{ 6, REG_AW_FAULT_ADDR, "AW SECURITY PROTECTION", IOMMU_FAULT_WRITE },
> -	{ 7, REG_AW_FAULT_ADDR, "AW ACCESS PROTECTION", IOMMU_FAULT_WRITE },
> +static const struct sysmmu_v1_fault_info sysmmu_v1_faults[] = {
> +	{ REG_PAGE_FAULT_ADDR, "PAGE", IOMMU_FAULT_READ },
> +	{ REG_AR_FAULT_ADDR, "MULTI-HIT", IOMMU_FAULT_READ },
> +	{ REG_AW_FAULT_ADDR, "MULTI-HIT", IOMMU_FAULT_WRITE },
> +	{ REG_DEFAULT_SLAVE_ADDR, "BUS ERROR", IOMMU_FAULT_READ },
> +	{ REG_AR_FAULT_ADDR, "SECURITY PROTECTION", IOMMU_FAULT_READ },
> +	{ REG_AR_FAULT_ADDR, "ACCESS PROTECTION", IOMMU_FAULT_READ },
> +	{ REG_AW_FAULT_ADDR, "SECURITY PROTECTION", IOMMU_FAULT_WRITE },
> +	{ REG_AW_FAULT_ADDR, "ACCESS PROTECTION", IOMMU_FAULT_WRITE },
>   };
>   
> -static const struct sysmmu_fault_info sysmmu_v5_faults[] = {
> -	{ 0, REG_V5_FAULT_AR_VA, "AR PTW", IOMMU_FAULT_READ },
> -	{ 1, REG_V5_FAULT_AR_VA, "AR PAGE", IOMMU_FAULT_READ },
> -	{ 2, REG_V5_FAULT_AR_VA, "AR MULTI-HIT", IOMMU_FAULT_READ },
> -	{ 3, REG_V5_FAULT_AR_VA, "AR ACCESS PROTECTION", IOMMU_FAULT_READ },
> -	{ 4, REG_V5_FAULT_AR_VA, "AR SECURITY PROTECTION", IOMMU_FAULT_READ },
> -	{ 16, REG_V5_FAULT_AW_VA, "AW PTW", IOMMU_FAULT_WRITE },
> -	{ 17, REG_V5_FAULT_AW_VA, "AW PAGE", IOMMU_FAULT_WRITE },
> -	{ 18, REG_V5_FAULT_AW_VA, "AW MULTI-HIT", IOMMU_FAULT_WRITE },
> -	{ 19, REG_V5_FAULT_AW_VA, "AW ACCESS PROTECTION", IOMMU_FAULT_WRITE },
> -	{ 20, REG_V5_FAULT_AW_VA, "AW SECURITY PROTECTION", IOMMU_FAULT_WRITE },
> +/* SysMMU v5 has the same faults for AR (0..4 bits) and AW (16..20 bits) */
> +static const char * const sysmmu_v5_fault_names[] = {
> +	"PTW",
> +	"PAGE",
> +	"MULTI-HIT",
> +	"ACCESS PROTECTION",
> +	"SECURITY PROTECTION"
>   };
>   
>   /*
> @@ -246,9 +244,12 @@ struct exynos_iommu_domain {
>   	struct iommu_domain domain; /* generic domain data structure */
>   };
>   
> +struct sysmmu_drvdata;
> +
>   /*
>    * SysMMU version specific data. Contains offsets for the registers which can
>    * be found in different SysMMU variants, but have different offset values.
> + * Also contains version specific callbacks to abstract the hardware.
>    */
>   struct sysmmu_variant {
>   	u32 pt_base;		/* page table base address (physical) */
> @@ -259,6 +260,9 @@ struct sysmmu_variant {
>   	u32 flush_end;		/* end address of range invalidation */
>   	u32 int_status;		/* interrupt status information */
>   	u32 int_clear;		/* clear the interrupt */
> +
> +	int (*get_fault_info)(struct sysmmu_drvdata *data, unsigned int itype,
> +			      struct sysmmu_fault *fault);
>   };
>   
>   /*
> @@ -293,6 +297,46 @@ struct sysmmu_drvdata {
>   
>   #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
>   
> +static int exynos_sysmmu_v1_get_fault_info(struct sysmmu_drvdata *data,
> +					   unsigned int itype,
> +					   struct sysmmu_fault *fault)
> +{
> +	const struct sysmmu_v1_fault_info *finfo;
> +
> +	if (itype >= ARRAY_SIZE(sysmmu_v1_faults))
> +		return -ENXIO;
> +
> +	finfo = &sysmmu_v1_faults[itype];
> +	fault->addr = readl(data->sfrbase + finfo->addr_reg);
> +	fault->name = finfo->name;
> +	fault->type = finfo->type;
> +
> +	return 0;
> +}
> +
> +static int exynos_sysmmu_v5_get_fault_info(struct sysmmu_drvdata *data,
> +					   unsigned int itype,
> +					   struct sysmmu_fault *fault)
> +{
> +	unsigned int addr_reg;
> +
> +	if (itype < ARRAY_SIZE(sysmmu_v5_fault_names)) {
> +		fault->type = IOMMU_FAULT_READ;
> +		addr_reg = REG_V5_FAULT_AR_VA;
> +	} else if (itype >= 16 && itype <= 20) {
> +		fault->type = IOMMU_FAULT_WRITE;
> +		addr_reg = REG_V5_FAULT_AW_VA;
> +		itype -= 16;
> +	} else {
> +		return -ENXIO;
> +	}
> +
> +	fault->name = sysmmu_v5_fault_names[itype];
> +	fault->addr = readl(data->sfrbase + addr_reg);
> +
> +	return 0;
> +}
> +
>   /* SysMMU v1..v3 */
>   static const struct sysmmu_variant sysmmu_v1_variant = {
>   	.flush_all	= 0x0c,
> @@ -300,6 +344,8 @@ static const struct sysmmu_variant sysmmu_v1_variant = {
>   	.pt_base	= 0x14,
>   	.int_status	= 0x18,
>   	.int_clear	= 0x1c,
> +
> +	.get_fault_info	= exynos_sysmmu_v1_get_fault_info,
>   };
>   
>   /* SysMMU v5 and v7 (non-VM capable) */
> @@ -312,6 +358,8 @@ static const struct sysmmu_variant sysmmu_v5_variant = {
>   	.flush_end	= 0x24,
>   	.int_status	= 0x60,
>   	.int_clear	= 0x64,
> +
> +	.get_fault_info	= exynos_sysmmu_v5_get_fault_info,
>   };
>   
>   /* SysMMU v7: VM capable register set */
> @@ -324,6 +372,8 @@ static const struct sysmmu_variant sysmmu_v7_vm_variant = {
>   	.flush_end	= 0x8024,
>   	.int_status	= 0x60,
>   	.int_clear	= 0x64,
> +
> +	.get_fault_info	= exynos_sysmmu_v5_get_fault_info,
>   };
>   
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -453,68 +503,56 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
>   }
>   
>   static void show_fault_information(struct sysmmu_drvdata *data,
> -				   const struct sysmmu_fault_info *finfo,
> -				   sysmmu_iova_t fault_addr)
> +				   const struct sysmmu_fault *fault)
>   {
>   	sysmmu_pte_t *ent;
>   
> -	dev_err(data->sysmmu, "%s: %s FAULT occurred at %#x\n",
> -		dev_name(data->master), finfo->name, fault_addr);
> +	dev_err(data->sysmmu, "%s: [%s] %s FAULT occurred at %#x\n",
> +		dev_name(data->master),
> +		fault->type == IOMMU_FAULT_READ ? "READ" : "WRITE",
> +		fault->name, fault->addr);
>   	dev_dbg(data->sysmmu, "Page table base: %pa\n", &data->pgtable);
> -	ent = section_entry(phys_to_virt(data->pgtable), fault_addr);
> +	ent = section_entry(phys_to_virt(data->pgtable), fault->addr);
>   	dev_dbg(data->sysmmu, "\tLv1 entry: %#x\n", *ent);
>   	if (lv1ent_page(ent)) {
> -		ent = page_entry(ent, fault_addr);
> +		ent = page_entry(ent, fault->addr);
>   		dev_dbg(data->sysmmu, "\t Lv2 entry: %#x\n", *ent);
>   	}
>   }
>   
>   static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
>   {
> -	/* SYSMMU is in blocked state when interrupt occurred. */
>   	struct sysmmu_drvdata *data = dev_id;
> -	const struct sysmmu_fault_info *finfo;
> -	unsigned int i, n, itype;
> -	sysmmu_iova_t fault_addr;
> +	unsigned int itype;
> +	struct sysmmu_fault fault;
>   	int ret = -ENOSYS;
>   
>   	WARN_ON(!data->active);
>   
> -	if (MMU_MAJ_VER(data->version) < 5) {
> -		finfo = sysmmu_faults;
> -		n = ARRAY_SIZE(sysmmu_faults);
> -	} else {
> -		finfo = sysmmu_v5_faults;
> -		n = ARRAY_SIZE(sysmmu_v5_faults);
> -	}
> -
>   	spin_lock(&data->lock);
> -
>   	clk_enable(data->clk_master);
>   
>   	itype = __ffs(readl(SYSMMU_REG(data, int_status)));
> -	for (i = 0; i < n; i++, finfo++)
> -		if (finfo->bit == itype)
> -			break;
> -	/* unknown/unsupported fault */
> -	BUG_ON(i == n);
> -
> -	/* print debug message */
> -	fault_addr = readl(data->sfrbase + finfo->addr_reg);
> -	show_fault_information(data, finfo, fault_addr);
> -
> -	if (data->domain)
> -		ret = report_iommu_fault(&data->domain->domain,
> -					data->master, fault_addr, finfo->type);
> -	/* fault is not recovered by fault handler */
> -	BUG_ON(ret != 0);
> +	ret = data->variant->get_fault_info(data, itype, &fault);
> +	if (ret) {
> +		dev_err(data->sysmmu, "Unhandled interrupt bit %u\n", itype);
> +		goto out;
> +	}
> +	show_fault_information(data, &fault);
>   
> +	if (data->domain) {
> +		ret = report_iommu_fault(&data->domain->domain, data->master,
> +					 fault.addr, fault.type);
> +	}
> +	if (ret)
> +		panic("Unrecoverable System MMU Fault!");
> +
> +out:
>   	writel(1 << itype, SYSMMU_REG(data, int_clear));
>   
> +	/* SysMMU is in blocked state when interrupt occurred */
>   	sysmmu_unblock(data);
> -
>   	clk_disable(data->clk_master);
> -
>   	spin_unlock(&data->lock);
>   
>   	return IRQ_HANDLED;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

