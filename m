Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA82544C67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbiFIMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiFIMph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:45:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43EC19B68E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxiJKMlmrjFm7elsv+fpQKAGQRsrhoBTjPU4OCPfHrZ0cYb+Tv1MHCNOMw48RYrVC3yKOyphkT+y4YwbHiN2T1JwCmbgj28gmfZCUQckzLjAwnO5h96Ko84jpy7oikOJzOGGzEUWmQYf3+ZUblVmrEJCS7J+E9R8G0urbcp8BKhxqaoC5eaYluVF9x8Ghil+4lm7vFDjFRaN3hkWaO7qHDIUlgH/oyX1gibqurVbJ/sOCngfP5Ik7dvvVtr59KmdP8PjODBKjGR5xUJwlDWnwgGKi75p1khQ/5NBTGdPR67tRsvk21CrqefHITWTQcGQpd3sFI0fD6tTP9+75ZHLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YusOJu3njgDBCEHqpOasP3KUIP02VjB7oNYX2ZXux9Q=;
 b=mHQ74Dz1g+ZoBuF8lHiUdOxBR64IMtx3gyC25vNZh9l3xuFeA5gi6Hw1zsp4Tb2HcBmZzYkVgSPjEvZf9i/9sKE6hNXsFqg1/V/VDSWwL4LKE8wjBA0Ac2YJalRigndpxZCqrFtU3ijIRqvUnvs8ww1QC6dVt+81mSrj+fZZIZtTOl4FK3myToVpu9SwN97xJzxT3CqVv8rtrl/oJPkUMqAtYSQjw8nLiJ0eFNCNuAohei0Zf57X/BbzeEehtAiYiATVSLtNOFbpq/vHP8R8jn7ROnDj4lMa8G6HZ9t41dDusmpujdctKllnAFgfRhurDJji1Cxcf5TeBbDnzFy0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YusOJu3njgDBCEHqpOasP3KUIP02VjB7oNYX2ZXux9Q=;
 b=p3SepnbkA+HrwK1Ir+0Ff/HPNzgPvyybD53oOVmBtdfcUTftnNqVu/rI+sq2/fZpzdSWUP6+GVWaeTgBEp6LdRAyclCF+FGt+xc0ZDPbWW8c86OqhMR3MVz0jbQtvNa+jSwa7aM8OGLzsz9TJCzkHnPEf9tAT4rWxj9Fjdi+ia4=
Received: from SN4PR0501CA0113.namprd05.prod.outlook.com
 (2603:10b6:803:42::30) by BN7PR02MB5140.namprd02.prod.outlook.com
 (2603:10b6:408:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 9 Jun
 2022 12:45:18 +0000
Received: from SN1NAM02FT0058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::b8) by SN4PR0501CA0113.outlook.office365.com
 (2603:10b6:803:42::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5 via Frontend
 Transport; Thu, 9 Jun 2022 12:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0058.mail.protection.outlook.com (10.97.5.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 12:45:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Jun 2022 05:45:17 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Jun 2022 05:45:17 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.50] (port=55876)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nzHXI-00025l-Tq; Thu, 09 Jun 2022 05:45:17 -0700
Message-ID: <f3d90ce7-59cd-8f62-ec1c-93cd40bc631a@xilinx.com>
Date:   Thu, 9 Jun 2022 14:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] firmware: xilinx: Add TF_A_PM_REGISTER_SGI SMC call
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@xilinx.com>, <michal.simek@xilinx.com>,
        <abhyuday.godhasara@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220607224253.54919-1-tanmay.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220607224253.54919-1-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beb2a234-f69e-438c-8ef2-08da4a15e882
X-MS-TrafficTypeDiagnostic: BN7PR02MB5140:EE_
X-Microsoft-Antispam-PRVS: <BN7PR02MB5140C1A5A40684EA22336D8BC6A79@BN7PR02MB5140.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gaw0k/Ujox1XMTk5YAJSHSvBVHEVolfIAXJQj4JCcbnXZEKrX+0ffp/ZwRGM8DoJ+xrcPA987ZIXefYQByPKWsLReJMvtjjWiwePQn9dSgrv0jFbti9PHMOEd84qtPlHJtoj31T+8UjaoxSEaIuPuLaks8UEmPZHjtAVbmaUtMCNNiCRF/AT30q/K7Mm6vV1MFcwNuNCQ8eDLG1PGr3HZWT3vnzpwcYoir08gxRjrXOQw4CsVdy8cuVLKP7hqp3AwNRLQmYBOVxyoxyqygWULi1/39ihYRUFp5Anx/hiHU1sllg4qxjjBvkTqhM7TlSvX+kCVCrElJYZIe7cJ77NdadwTzuDFHXu+KArJz8EZiCD5EYrMOL0gYJyEbHh3ESGRgkHur0laS9Dz2vsbkzFRWrgs7THHzTnbQcbNP8lja3qtTg2GnLpYxqLFl+hajCVsGMX6C9F9XGF/Y9kKniXrHwf76jnGtqyRYUgjIeFZcRS26dfnWKf1Cas/QJ4260vjOFtrd26B5CCbo4k0fv/7bT3TsT9VJC8vp3S0Z+Zte0U/5gc41XBEeP1KIFUAhUX9vfPXkj8jZ9ubPLZNMDnXZa6KxFPgtFj+9A9mJmSf6SBAMN7u1hSz4lROSvvU3w5RmNblQlHfbrJg67HErFGY7k8JjcTeXNW0Bqq+74CRuqh7kMrNALpZIw1276//iZwSxbYS9P9HkMsQLNziV/bTLjQHW3pYYEKkGGYNZ3CN1w=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(4326008)(47076005)(70586007)(54906003)(70206006)(336012)(316002)(6636002)(8676002)(31696002)(110136005)(2906002)(36756003)(2616005)(186003)(426003)(44832011)(508600001)(53546011)(26005)(8936002)(9786002)(40460700003)(5660300002)(83380400001)(36860700001)(31686004)(7636003)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:45:18.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb2a234-f69e-438c-8ef2-08da4a15e882
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5140
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 00:42, Tanmay Shah wrote:
> SGI interrupt register and reset is performed by EEMI ioctl
> IOCTL_REGISTER_SGI. However, this is not correct use of EEMI call.
> SGI registration functionality does not qualify as energy management
> activity and so shouldn't be mapped to EEMI call.
> 
> This new call will replace IOCTL_REGISTER_SGI and will  be handled by TF-A
> specific handler in TF-A. To maintain backward compatibility for a while
> firmware driver will still use IOCTL_REGISTER_SGI as fallback strategy if
> new call fails or is not supported by TF-A.
> 
> This new design also helps to make TF-A as pass through layer for EEMI
> calls. So we don't have to maintain PM_IOCTL as EEMI API ID in TF-A.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> ---
> 
> Changes in v2:
>    - fix commit tag. add new line before signed-off tag
> 
>   drivers/firmware/xilinx/zynqmp.c        | 16 +++++++++++++++-
>   drivers/soc/xilinx/xlnx_event_manager.c |  5 ++---
>   include/linux/firmware/xlnx-zynqmp.h    |  7 +++++++
>   3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 7977a494a651..d1f652802181 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -2,7 +2,7 @@
>   /*
>    * Xilinx Zynq MPSoC Firmware layer
>    *
> - *  Copyright (C) 2014-2021 Xilinx, Inc.
> + *  Copyright (C) 2014-2022 Xilinx, Inc.
>    *
>    *  Michal Simek <michal.simek@xilinx.com>
>    *  Davorin Mista <davorin.mista@aggios.com>
> @@ -340,6 +340,20 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
>   static u32 pm_api_version;
>   static u32 pm_tz_version;
>   
> +int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
> +{
> +	int ret;
> +
> +	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
> +				  NULL);
> +	if (!ret)
> +		return ret;
> +
> +	/* try old implementation as fallback strategy if above fails */
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
> +				   reset, NULL);
> +}
> +
>   /**
>    * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
>    * @version:	Returned version value
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 5dcb7665fe22..2de082765bef 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -647,8 +647,7 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
>   	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/event:starting",
>   			  xlnx_event_cpuhp_start, xlnx_event_cpuhp_down);
>   
> -	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
> -				  0, NULL);
> +	ret = zynqmp_pm_register_sgi(sgi_num, 0);
>   	if (ret) {
>   		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
>   		xlnx_event_cleanup_sgi(pdev);
> @@ -681,7 +680,7 @@ static int xlnx_event_manager_remove(struct platform_device *pdev)
>   		kfree(eve_data);
>   	}
>   
> -	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, 0, 1, NULL);
> +	ret = zynqmp_pm_register_sgi(0, 1);
>   	if (ret)
>   		dev_err(&pdev->dev, "SGI unregistration over TF-A failed with %d\n", ret);
>   
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 1ec73d5352c3..cbde3b1fa414 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,6 +34,7 @@
>   #define PM_API_VERSION_2	2
>   
>   /* ATF only commands */
> +#define TF_A_PM_REGISTER_SGI		0xa04
>   #define PM_GET_TRUSTZONE_VERSION	0xa03
>   #define PM_SET_SUSPEND_MODE		0xa02
>   #define GET_CALLBACK_DATA		0xa01
> @@ -468,6 +469,7 @@ int zynqmp_pm_feature(const u32 api_id);
>   int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
>   int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
> +int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
>   #else
>   static inline int zynqmp_pm_get_api_version(u32 *version)
>   {
> @@ -733,6 +735,11 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
>   {
>   	return -ENODEV;
>   }
> +
> +static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
> +{
> +	return -ENODEV;
> +}
>   #endif
>   
>   #endif /* __FIRMWARE_ZYNQMP_H__ */
> 
> base-commit: 73d0e32571a0786151eb72634f1a4c5891166176

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

