Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D7514455
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355768AbiD2Iii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiD2Iih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:38:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD23186F2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYuKKXGBPv8cAOfVbRGjxvTkUtKHsYM1Vf+25Pawna2IbDyH+8ucdr86GO9vl0PPze7wjQ60QlZjFUfIL9m+XQVYasTQIVoPwRv6MX/hXSj9hr1WPInKHS3TucaNjbxkQYaE3zVHgf+nqMma1/38HdP4KC+PUm/VHSlGZ29pnoeeAiVNiGbEk7VbslxZsEahKVmPEnsmlYLSpYIqZHI7j2xLBqYoK6ekf5L352YoDY0r5/tHYcCeIhKAHTb2HrEkyDEqeuXndzZDa7WiZiBGqmjrEXJlDwdZfLGTTXdTopzM0/H1b+pzUzQPVxrjCox4auMHwjRZVXFyHqUH1iLUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlUGXJwAVxsCCyjwz3lKoFx2G9dJsX0umNb+91UBMy8=;
 b=EwUNkr9JF55Ml+CL14PeVVvMyjgaBjJ9v7P2JKKnga5lRgV7VpKI3T6bC/Os5X1HKtHbV3ikK3gE882ppSi6Xd3TSLlqkZ5plflq4HKPwU5qQHaQkYOe1Ms2qbp9c75gX/jiRreaCPpA5XuudElgqluxXlUrWz5RPJXgVCRoRja2lCTqNlVKgt49sh9USfu96EfVfCQJ4ShycZPxnE2bPBgwWZJkp7N/8u3uPTPzw+ke/rnbPpwUAt6O68ZnDhSeuXA1dypiT44Wrwj1iidGdTFiWHUXssZTAuCeeW8mb3g9uvAsAZXI9N2lvL2Zpen3fSbbaVWbsDOgN81AwUP6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlUGXJwAVxsCCyjwz3lKoFx2G9dJsX0umNb+91UBMy8=;
 b=hixtpDCXrEsSp9wB+eGLh1ZL4vyQXz68z94cjiVMAbcKqEixZzs/jDeznPQ/LpD9a7Tm8B9MoGaEBLtOLUqJ5MG2wjdcsJRcJ+lyjY5UTZ3qsSqumOYW4BT5G78RtS338lZr2En6ceanQsz3JWbgKtyR4SQGZ8Kp+JSOwxd8Kyg=
Received: from BN0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:141::34)
 by DM5PR02MB3829.namprd02.prod.outlook.com (2603:10b6:4:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 08:35:17 +0000
Received: from BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::94) by BN0PR07CA0012.outlook.office365.com
 (2603:10b6:408:141::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 08:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT010.mail.protection.outlook.com (10.13.2.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:35:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:35:16 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:35:16 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.50] (port=34450)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nkM5s-0007Hy-8a; Fri, 29 Apr 2022 01:35:16 -0700
Message-ID: <93cbb33f-e1b0-a64b-2b40-b800ec4083ac@xilinx.com>
Date:   Fri, 29 Apr 2022 10:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] firmware: xilinx: add support for IOCTL and QUERY ID
 feature check
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
 <1649242526-17493-2-git-send-email-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1649242526-17493-2-git-send-email-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e8625c-26da-42d2-7a92-08da29bb3043
X-MS-TrafficTypeDiagnostic: DM5PR02MB3829:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB38293B770349E4A7D4A89A5CC6FC9@DM5PR02MB3829.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7KXwlDqnkKnwri/+PqdHhfhAWAmkm09c2ndS5PUmFNK1S86heHNUrC7lKlRIP/mpKwfB9KBnf3aDzqemxsNbU4ewPkaBc1wvL59mbqyqdfzo11vr623Z2DCYLbypB7le9tvSOKSqvTQ+nDCl7fvI75B/zdpMWr4xjVmWH29s4rwlFMO34w1BJXyYpKrQEy6j6sGY4JKXTjEtmZS427z7TyQ/OT8Wa7sLFbtnq+zeTvFv8kYRROh+OMB4zxjF/aggoQwl/7IGT/bk0qPDMcaRCURpPW+xcV9Zit+XVMzBhmD8PpD9Z6XxFDbjYCx6kRS2jXOAtt9J7R9FZMJnZyInWRmsyHaHi8tjZan/v2ckmzKeLo05NtQg65FGqSIcrkPjtuw0nYMoehhT1S/1indvMeyn2Wr6Bbp7idntgUZ8J/aGvkp5WjUD75uwqFhvggdsdZyEAjHTsPmxgdU+kao9gz0h++NT2B1Hf2HJtST8T9T7Vsh6bTYhYvkgPkDdrXyuhpCGzaOsixq2WratRnKs7IszgJJnxVBahwZD6T7hfju84BxRurrAwICO7DvlG/9MoRNdfzwlGabRGsKbUFdPu9gU+5l58d5IvOxMwhaUNV+U8TeCBjAw//0bYxsyq/VOe74RqAyWoGXFWjUFBevca84Mx/XEQfm6VVqh5fSngfNqPRQDBhHUnT69wvNjDdH4+1n0bpNFm6jgN0Q0jR5YSxDNClXD7NMOU84EGNN2V0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(9786002)(8936002)(40460700003)(26005)(44832011)(36860700001)(356005)(53546011)(6666004)(2906002)(7636003)(54906003)(110136005)(316002)(70206006)(36756003)(4326008)(70586007)(5660300002)(8676002)(508600001)(82310400005)(107886003)(426003)(47076005)(186003)(2616005)(336012)(31686004)(31696002)(83380400001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:35:17.0448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e8625c-26da-42d2-7a92-08da29bb3043
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3829
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/22 12:55, Ronak Jain wrote:
> Add support to check if IOCTL ID or QUERY ID is supported in firmware
> or not.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 62 +++++++++++++++++++++++++++++++++++-
>   include/linux/firmware/xlnx-zynqmp.h | 11 +++++++
>   2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index f21ece56695e..41ca41697790 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -36,8 +36,16 @@
>   /* BOOT_PIN_CTRL_MASK- out_val[11:8], out_en[3:0] */
>   #define CRL_APB_BOOTPIN_CTRL_MASK	0xF0FU
>   
> +/* IOCTL/QUERY feature payload size */
> +#define FEATURE_PAYLOAD_SIZE		2
> +
> +/* Firmware feature check version mask */
> +#define FIRMWARE_VERSION_MASK		GENMASK(15, 0)
> +
>   static bool feature_check_enabled;
>   static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
> +static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
> +static u32 query_features[FEATURE_PAYLOAD_SIZE];
>   
>   static struct platform_device *em_dev;
>   
> @@ -168,7 +176,8 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
>   }
>   
>   /**
> - * zynqmp_pm_feature() - Check weather given feature is supported or not
> + * zynqmp_pm_feature() - Check whether given feature is supported or not and
> + *			 store supported IOCTL/QUERY ID mask
>    * @api_id:		API ID to check
>    *
>    * Return: Returns status, either success or error+reason
> @@ -208,11 +217,62 @@ int zynqmp_pm_feature(const u32 api_id)
>   	feature_data->feature_status = ret;
>   	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
>   
> +	if (api_id == PM_IOCTL)
> +		/* Store supported IOCTL IDs mask */
> +		memcpy(ioctl_features, &ret_payload[2], FEATURE_PAYLOAD_SIZE * 4);
> +	else if (api_id == PM_QUERY_DATA)
> +		/* Store supported QUERY IDs mask */
> +		memcpy(query_features, &ret_payload[2], FEATURE_PAYLOAD_SIZE * 4);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
>   
>   /**
> + * zynqmp_pm_is_function_supported() - Check whether given IOCTL/QUERY function
> + *				       is supported or not
> + * @api_id:		PM_IOCTL or PM_QUERY_DATA
> + * @id:			IOCTL or QUERY function IDs
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
> +{
> +	int ret;
> +	u32 *bit_mask;
> +
> +	/* Input arguments validation */
> +	if (id >= 64 || (api_id != PM_IOCTL && api_id != PM_QUERY_DATA))
> +		return -EINVAL;
> +
> +	/* Check feature check API version */
> +	ret = zynqmp_pm_feature(PM_FEATURE_CHECK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Check if feature check version 2 is supported or not */
> +	if ((ret & FIRMWARE_VERSION_MASK) == PM_API_VERSION_2) {
> +		/*
> +		 * Call feature check for IOCTL/QUERY API to get IOCTL ID or
> +		 * QUERY ID feature status.
> +		 */
> +		ret = zynqmp_pm_feature(api_id);
> +		if (ret < 0)
> +			return ret;
> +
> +		bit_mask = (api_id == PM_IOCTL) ? ioctl_features : query_features;
> +
> +		if ((bit_mask[(id / 32)] & BIT((id % 32))) == 0U)
> +			return -EOPNOTSUPP;
> +	} else {
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
> +
> +/**
>    * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
>    *			   caller function depending on the configuration
>    * @pm_api_id:		Requested PM-API call
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 14f00a7672d1..1ec73d5352c3 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -29,6 +29,11 @@
>   
>   /* SMC SIP service Call Function Identifier Prefix */
>   #define PM_SIP_SVC			0xC2000000
> +
> +/* PM API versions */
> +#define PM_API_VERSION_2	2
> +
> +/* ATF only commands */
>   #define PM_GET_TRUSTZONE_VERSION	0xa03
>   #define PM_SET_SUSPEND_MODE		0xa02
>   #define GET_CALLBACK_DATA		0xa01
> @@ -460,6 +465,7 @@ int zynqmp_pm_load_pdi(const u32 src, const u64 address);
>   int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>   				const u32 wake, const u32 enable);
>   int zynqmp_pm_feature(const u32 api_id);
> +int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
>   int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
>   #else
> @@ -678,6 +684,11 @@ static inline int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
>   	return -ENODEV;
>   }
>   
> +static inline int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
> +{
> +	return -ENODEV;
> +}
> +
>   static inline int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id)
>   {
>   	return -ENODEV;


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
