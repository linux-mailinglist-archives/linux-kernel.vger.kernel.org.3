Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48151514454
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355781AbiD2Iit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355775AbiD2Iip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:38:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E5B92332
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnqIS5gwa8zL4b81hmV1Oi2d/1uealc8RSMDo6A8orq1EIfXfD7sqSnB3ORallXzOmSEeRJ4orwTJgcQ5rMUUxjXeMq1ASCGrqft59G6dJKlsSEoTGf9QLBlF68Ptpae4JQuiXLAZ3LRgOlYqOS5GRjTXuXuDd26IKAJOl43BQBxEDTkFpEfiK83DZDvlrWTRiyzJWZNVmyujsJAwuvqIl7HkM7g3u3mRgDY/F+oVqwxY1LdJ2A1CVy2Ya5IBoImNmV6zSKSSylNO5de8ouaGS7BnvAKOW4KcNxW9pUqMsXVkrx0Y9vX2YkAk3GgxC/N3g4RTdJWnceYdik7cwxLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FN2Dv+55wSaSrJFQu0pnsyxXLVklHO44qlNfKlbvK8=;
 b=TPOse/r8Q6N2oijBD4Z+KzIzLsyODgjfuJUxWDfwBFFehCRBLPw3DBm1jxX/5mcLcWVlWWPUF2EWYRDzFyx208jWOfiIn9YTzaqW46RtmgA+avbhwaRcgEN5mJiO7jWES29fFTVyAgLcQHloKZDVw3PQe+Ukx11zfcKqXaIozLutC6s/VcAaYDKsTPuf7XXGDjBcLkr5ZvcF9ZLxfjBO77IoQg244D/IxgPwOspcpKs+omdalinmow7tHmwPn3Djk+d6eRN5DWs7AwsIMmVi2l1lY451Gd5oRY5OgnNrjoeCFpqsbqz6IYklQsjOUgjjKsjpXaI/7fxwhX+7B5IxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FN2Dv+55wSaSrJFQu0pnsyxXLVklHO44qlNfKlbvK8=;
 b=X2l4nJsFwhOeCM5oK7PPA48Rq0Q1Vf7CT4M9BcebOG1UiTB9zKGZPCCC3WQbnCqeV5zQdK01XndVq6rkVCZgQ35yGv5R7wucnfmaU7d+hJAUCV9m9BdV6eauxFM7mPwwcsf5bCwM3q7xmGroledW6XZM7iL4m6/BBdzkZg9bo0o=
Received: from BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::13)
 by SJ0PR02MB8733.namprd02.prod.outlook.com (2603:10b6:a03:3da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.16; Fri, 29 Apr
 2022 08:35:26 +0000
Received: from BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::ba) by BN9P221CA0010.outlook.office365.com
 (2603:10b6:408:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 08:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT017.mail.protection.outlook.com (10.13.2.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:35:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:35:24 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:35:24 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.50] (port=34462)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nkM5z-0007S1-Sk; Fri, 29 Apr 2022 01:35:24 -0700
Message-ID: <a5736830-2e25-252e-6811-9ec37bd052d9@xilinx.com>
Date:   Fri, 29 Apr 2022 10:35:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] firmware: xilinx: add new function for
 do_feature_check_call
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
 <1649242526-17493-3-git-send-email-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1649242526-17493-3-git-send-email-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c96d2ea6-c57d-49ec-fa63-08da29bb3583
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8733:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8733722420792E5C7838CB1DC6FC9@SJ0PR02MB8733.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9x7MV0OjbrOKjolrOjvy31o6W0+d9zz7DOTIPumMnZF5EJvSDMuVGhvPb/q2+cGqACPZK1fuFKhGYBA7mBQshp5Jg2nHVF4O20Rux8dH3VjXC73EmMsdjFjKBhV4oqpBEI+Vjw6kmV/l9B5380N4fOEmnIkKhmeJBj9RtKfkrcgUHbe0yY1QjbRrElzVw0yM9f3MgUCcYwMY+hhNd3yj73iveEZQXcbAKUmVQsxJRyhUKrEC8UM93K8kl0w91cnRv84BxhjaNtUl57GIASQkznJcHnQDU5mqVfT2653cX7e0AvYN+L8hAiuhkd7fUhrkeyKgB06c4K5TSVrLQxbiGAes5cXDG3g29S8W3J2QwTEunrFVlVg10eEGQytZIisEaI7jQeXqEXlQD3Z4aFR0Qf+LWtvt5wwpk2/+sTYOjc7suBFAIiuJC9JMxfU+9+t58acAFtKU9/Qe3GPxp419rWil61X1tOTJtSqPhH2+DS5Hw99lxM7UF/c+zNLlRJHJYDuGPWBXyHxp8a/Kq8e/R566qBIeMuaj6Y7rW/yUUtlOTLJQeId0u6kwGhKGsPI2wRKISqwb2efl135Jz4WF/jsTDh5kHdK+SLDZPB1xSnqjnB8Hw8l25h1goU/AC2rpRziQHMJgePw6dxYEsXEEbFrTUYWUjwjepis2kww8xUsJvlUXJebthatYjPUcjXBQU70ZQbhv/tyUs5dfl++8UimTor5fp7pySqNOiaIxFow=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(2616005)(426003)(53546011)(508600001)(54906003)(31686004)(36756003)(336012)(47076005)(316002)(110136005)(83380400001)(107886003)(26005)(6666004)(40460700003)(44832011)(70586007)(70206006)(8676002)(2906002)(4326008)(31696002)(356005)(7636003)(8936002)(9786002)(36860700001)(82310400005)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:35:25.8561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96d2ea6-c57d-49ec-fa63-08da29bb3583
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8733
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/22 12:55, Ronak Jain wrote:
> Add new function for sending feature check request to firmware and
> call it from zynqmp_pm_feature().
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 41ca41697790..d27a3b20227b 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -175,6 +175,23 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
>   	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
>   }
>   
> +static int do_feature_check_call(const u32 api_id, u32 *ret_payload)
> +{
> +	int ret;
> +	u64 smc_arg[2];
> +
> +	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
> +	smc_arg[1] = api_id;
> +
> +	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
> +	if (ret)
> +		ret = -EOPNOTSUPP;
> +	else
> +		ret = ret_payload[1];
> +
> +	return ret;
> +}
> +
>   /**
>    * zynqmp_pm_feature() - Check whether given feature is supported or not and
>    *			 store supported IOCTL/QUERY ID mask
> @@ -186,7 +203,6 @@ int zynqmp_pm_feature(const u32 api_id)
>   {
>   	int ret;
>   	u32 ret_payload[PAYLOAD_ARG_CNT];
> -	u64 smc_arg[2];
>   	struct pm_api_feature_data *feature_data;
>   
>   	if (!feature_check_enabled)
> @@ -205,14 +221,7 @@ int zynqmp_pm_feature(const u32 api_id)
>   		return -ENOMEM;
>   
>   	feature_data->pm_api_id = api_id;
> -	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
> -	smc_arg[1] = api_id;
> -
> -	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
> -	if (ret)
> -		ret = -EOPNOTSUPP;
> -	else
> -		ret = ret_payload[1];
> +	ret = do_feature_check_call(api_id, ret_payload);
>   
>   	feature_data->feature_status = ret;
>   	hash_add(pm_api_features_map, &feature_data->hentry, api_id);

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

