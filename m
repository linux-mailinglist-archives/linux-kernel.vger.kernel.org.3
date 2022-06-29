Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B656005C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiF2Mqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiF2Mqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:46:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904FA34BBA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxFDp7zPj8Oy1bqtAQNrNqZDU7JsZPBtS8Jt1mCwNjwaZLVKrD0LY/X1KRY3Vbdm5hKmJ6JBOFm4cdjIZTvlXT5JEHxryqhpun78BeiTfSbEMNScZf511PGvizd5ov2njjoqsHkIPaDl6TxMBTAU2z+2ut2Bp8LTV4nJq7SHcH84jtb0EXsMF0rMgQgkOFM+aFEqYGbGoWmrmgdxIyncckgw0ewZVcpJ1eqchjfBHSNH+vEiVciNqUxa+9Iqp77eTX+8POpeBjWfTZlGdA7vF1klLFjfolfn46MPuNrslXC8VfPAHrgvnMllO28DSOxinTchc7X3nZZCeK0M1klKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef48JyrAxLUac9ArjBTK+gnxEZyfTzuNORtYq6gDQW0=;
 b=nfANOSEC0G/sWR6iIUB/NqWci0THLTfcZVtK5G9UnhkX5k+LinOckDiAI+d3T4pwoOzyiIc6GOJITY9tiaxCDUdDrm16W5KshSooYwiyl+biopGbFJjLZKOTSR6wF7xRTfx7MSF15+kdf9ZPKeXrIdVc6wem42dRlGJPRkA3uJDoZ0QbM6ZxK7rf6PhVYXJepO+KNq+nzhPjhKfTzo0zCcVnAL67ftfmVNteakFXC3I18XMcqp0F8gwQy6FPg0dCSAkvi50kcy+zFO/papJRLz7PDflcl7Njs7cyMVcKwAQJoVRMGY011X1Z0LlKAMkUXpoi28vmzH51oQOBRfL0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef48JyrAxLUac9ArjBTK+gnxEZyfTzuNORtYq6gDQW0=;
 b=mDenVhzunig5zf1+P2JlKelY/5hzAn3lhTv4mrALIuOKbhzaxoDfhLEvaMGE6UvS9Jc78NcnoYOxKJrOtdNJtsl1jA81jIe3P1o4pmmHGzRICuwrM8lNCxBL7JjkLWTCrCYsyfqIQEI01L+Qd8gT2X8j29IEhs3c/2IlrpWItWg=
Received: from BN6PR19CA0072.namprd19.prod.outlook.com (2603:10b6:404:e3::34)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 12:46:44 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::87) by BN6PR19CA0072.outlook.office365.com
 (2603:10b6:404:e3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Wed, 29 Jun 2022 12:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 12:46:44 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 07:46:42 -0500
Message-ID: <4dc8f6ca-73d1-5e8c-dbd6-751e0a0d9542@amd.com>
Date:   Wed, 29 Jun 2022 14:46:39 +0200
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
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220607224253.54919-1-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3b5137d-9b88-447c-ff7b-08da59cd6c2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4403:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPmN78FkOyoJJ+heA+trspSID6+oM/KvbxS2GFgZS5wwryNbAj3p8ssazk6f98Kxp6qGteHIRoI9IAc5/pbuUFyQx6ipBPACzs1329XqegWT1RZYlgXlVD81VRDWjsRANWpeJSnTReHs0iopAWqwrC+HDOHz5B2oADQHBcTzZNFxOoO4Tr4NWjlOROZXnOcTAMibnCcXT38yABDHrcEM2a4SZlChYwMQrv2gEPqIbbaJ9DZpDNN0bIpEJLi9Ujj1fDv33/rAHq2zaz9/EzwwDAJG9sk16UsK/rj3jFLrCH/R2HlSCAszjP6MZw0kLc24ZGXApMBqLBVIcK1+AjxojGhSPKC6utcQOSItPidQl38OIVwhbCxXeqJ15owateh2iq/zlApKRxzmLcHzRvFVpOxwqzUTSVimi0j4V58+uJtrsfuz5dHyS+l4VOmKPYTplrUvxJMbHuoUiy29hjfxIRjDc2/lZ1rohYFq5wV3PALZP1bWp4f5r952phbDN9P0mRflrYWdNjCANMTPXhKgfM1saPI+W/NJcFAxS40YwyW/Kpkcyy/tcyzHnM3C6xdlpZ9UEUePJq1JsbAMLyvrhkIZhmrQDM3rkEupAmdtFuQPEXX7Ym03vRMjm074MZ5s0gfRtFqEuHZImi0/oOnuG9rVQgMrvIc64HPSqL1IcjCunfgLzocv41tMKWhxcepl9Y7NHVm7MQXYqZSJVO2FE8NRLdZhqMdXRHydIl9w767dWzsnO3SByF8EiDSh5bIAkZjVfiXXoklfRzOIiHkf285Tq1GcUfJvoPDRCaLJsQg65zokae8u8diu6SCduKU3w7EmQi/clEK0eoZ3weC5XMr5xYLUNv9JulxHPwG86nQkF+wAjNPihsPvbIM5K8EF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(31696002)(36860700001)(86362001)(41300700001)(6666004)(82310400005)(5660300002)(44832011)(8936002)(40460700003)(2906002)(478600001)(70586007)(426003)(47076005)(4326008)(8676002)(356005)(186003)(16526019)(110136005)(36756003)(2616005)(336012)(70206006)(31686004)(81166007)(53546011)(83380400001)(16576012)(54906003)(26005)(40480700001)(316002)(82740400003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 12:46:44.3646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b5137d-9b88-447c-ff7b-08da59cd6c2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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


Applied.
M
