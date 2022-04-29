Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88674514457
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355782AbiD2Ijl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351551AbiD2Iji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:39:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3BA777E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8kTu3ib/OXPAvCwLyubOtYR7daHH6LyGQOKtHnVNRIVT1O7V/eX1sW65WF649m2MIfnSmHHrlr05BMsJP6HJR1Pi0rFJUDSxs/XPsUzailGjnUlvRlOi2GoymODuwoXSAjcX2XugQ10Ksab6/qM4Iwq+oXQIeaOj+IyH9CQhUfO3XN2/uUUSPVRQEHmDDGCNkcGdjK+CQCT7zJ1kMzwTC7ANjRgZOoE6i7j6Wue0Q2PbfSHyLU3z+2TQ7ZUmFqM9BJ7Tjadxayha+iOxeCzjjGGkyeONO8/Bpu6Zu3tNQNuYW3a/d5R9hKRlHRiRw/mYbW3fAGOhe42gNTtDQLHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgaT/21XTkpD1nvzOYyutfrx45Zf9w36C4tPHA/itVk=;
 b=TFxB6xglOycnTvJ3anKNHOkh8ianMhSXVfvpLw1T5/oNQkVRF1YJLTj/MeXBnYIUvuhw2hYV6NmK80M+p8jYGA4G8/z1pgvHHBkmRFL8C7QzNsfyHnd+WU+fMdbmuAZt0R90qDyuwx9p09PJRe96/AxYQ70jln6SB9vbSg/WnwsmpMyUunYinpnsmvfQvp1Y6y3wcb2eHE8F0kjtiCMaqV3iShQL4U8PBIIjc3ohpSqTEY4U++KSlz7F8ngw5iqfTBbhDqloVFEeDMbTtG/jJXB32Z4yp6yqtzjy2CVUvncQG+5a0Zyfad+PhEyAqFLHjc6jR2oSbpu89qK5x82I+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgaT/21XTkpD1nvzOYyutfrx45Zf9w36C4tPHA/itVk=;
 b=Fo4lkS/1rVQSgq6o9QdM7Yi7arV5SOx48dTuiW+UrNAaWzsa78TFCc5hMZZr6mjL5G7JwzDEuK8sOlCxKex0uzBztNJ5JHtYMSH+nVf34ZA58Wsm7xFpO5oBnjitrHUykILSxpyZwtKrYETzC7QZeSntdCqKt2dI0LC9mNpUQGE=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by BY5PR02MB6818.namprd02.prod.outlook.com (2603:10b6:a03:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 08:36:19 +0000
Received: from BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::a2) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 08:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT007.mail.protection.outlook.com (10.13.3.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:36:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:36:10 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:36:10 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.50] (port=34488)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nkM6k-0007ZT-1a; Fri, 29 Apr 2022 01:36:10 -0700
Message-ID: <113eb367-9cd3-252a-cc10-e90722b9d288@xilinx.com>
Date:   Fri, 29 Apr 2022 10:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/4] firmware: xilinx: always check API version for
 IOCTL/QUERY
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
 <1649242526-17493-4-git-send-email-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1649242526-17493-4-git-send-email-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa22ebb9-6e6f-4900-e423-08da29bb54fe
X-MS-TrafficTypeDiagnostic: BY5PR02MB6818:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB68183F4F275303508F6AE434C6FC9@BY5PR02MB6818.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMvRi0WsYk6MW+daApkMYwGANfmt5bKvD7RRIRllt/mLJk6I7yF6WRRQTFOVTrJOvyElDqzwC8UJJIfxuo1GTkk8Ppq4SePNBWinK1WFPa+uutJvYXncjLOJKh4Esbl86bEHKd2CVQnG5ytamw/uMp9XHJET8+NCEDJAbqeZ397tDFQCroF4D1Tn7TJxStvrdLcXVHzkmuCOYj39l7ykiiIFuAzcoaDfMoPiSgR+S8F+alGHOQGvRzBA9vzrwULmrSPBmoY+ljwyqz++8e0cwON16XXN4H9zBgX/5GC0X7gxdMKv1TYkU1fzuletrSIzQVhnzmVbmfOUKplP8x08z0f4UyHfRkALVgkd6FXpTYjRt+4VZCeXn3wQ0Yar/AarslWK08dOxWjyNzmIMsJDk336Im5anwf8zZ/iLZcTHQterUoGJBFf6E4GWTJlIJLn27uy4o25U9xUar2GuT5/EkpxnMIwTRaHtCOfaM2sM67trq2B//ESWLj+/U8qh6dQVmO3ScRcmwVG2cQaSKbA59Lg/kLMOMuJSlMBDyr8Iq98tnycjhKrmsag8lj0nsacb625bN7EfLp8hsG2G+s2c+TpgUaD/0V9Z+YSxYKtxzQ8JiVNldY9Tb4bMmi17gP9Kbt/XUhynC2J2ZfFxZJDh+0q1AhKbQRtF9FDuyO2PrDukwwnvXLFIAnCa0HDI9tTlg2+xSWVkcmeOvoibGLNPyEB6Ug2Kq/3k9hzlPOd+m4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(508600001)(82310400005)(31696002)(2616005)(336012)(426003)(107886003)(53546011)(26005)(356005)(7636003)(6666004)(316002)(44832011)(2906002)(36860700001)(70206006)(186003)(36756003)(5660300002)(70586007)(8936002)(31686004)(110136005)(54906003)(9786002)(4326008)(83380400001)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:36:18.6554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa22ebb9-6e6f-4900-e423-08da29bb54fe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6818
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/22 12:55, Ronak Jain wrote:
> Currently, we are not checking feature check version for PM APIs as
> the support may or may not there in the firmware. To check the whether
> the feature check API is supported or not in the firmware, allow
> checking for its own version.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 39 ++++++++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index d27a3b20227b..6ee94f31ac98 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -175,7 +175,7 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
>   	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
>   }
>   
> -static int do_feature_check_call(const u32 api_id, u32 *ret_payload)
> +static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
>   {
>   	int ret;
>   	u64 smc_arg[2];
> @@ -192,22 +192,12 @@ static int do_feature_check_call(const u32 api_id, u32 *ret_payload)
>   	return ret;
>   }
>   
> -/**
> - * zynqmp_pm_feature() - Check whether given feature is supported or not and
> - *			 store supported IOCTL/QUERY ID mask
> - * @api_id:		API ID to check
> - *
> - * Return: Returns status, either success or error+reason
> - */
> -int zynqmp_pm_feature(const u32 api_id)
> +static int do_feature_check_call(const u32 api_id)
>   {
>   	int ret;
>   	u32 ret_payload[PAYLOAD_ARG_CNT];
>   	struct pm_api_feature_data *feature_data;
>   
> -	if (!feature_check_enabled)
> -		return 0;
> -
>   	/* Check for existing entry in hash table for given api */
>   	hash_for_each_possible(pm_api_features_map, feature_data, hentry,
>   			       api_id) {
> @@ -221,7 +211,7 @@ int zynqmp_pm_feature(const u32 api_id)
>   		return -ENOMEM;
>   
>   	feature_data->pm_api_id = api_id;
> -	ret = do_feature_check_call(api_id, ret_payload);
> +	ret = __do_feature_check_call(api_id, ret_payload);
>   
>   	feature_data->feature_status = ret;
>   	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
> @@ -238,6 +228,25 @@ int zynqmp_pm_feature(const u32 api_id)
>   EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
>   
>   /**
> + * zynqmp_pm_feature() - Check whether given feature is supported or not and
> + *			 store supported IOCTL/QUERY ID mask
> + * @api_id:		API ID to check
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_feature(const u32 api_id)
> +{
> +	int ret;
> +
> +	if (!feature_check_enabled)
> +		return 0;
> +
> +	ret = do_feature_check_call(api_id);
> +
> +	return ret;
> +}
> +
> +/**
>    * zynqmp_pm_is_function_supported() - Check whether given IOCTL/QUERY function
>    *				       is supported or not
>    * @api_id:		PM_IOCTL or PM_QUERY_DATA
> @@ -255,7 +264,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
>   		return -EINVAL;
>   
>   	/* Check feature check API version */
> -	ret = zynqmp_pm_feature(PM_FEATURE_CHECK);
> +	ret = do_feature_check_call(PM_FEATURE_CHECK);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -265,7 +274,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
>   		 * Call feature check for IOCTL/QUERY API to get IOCTL ID or
>   		 * QUERY ID feature status.
>   		 */
> -		ret = zynqmp_pm_feature(api_id);
> +		ret = do_feature_check_call(api_id);
>   		if (ret < 0)
>   			return ret;
>   


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

