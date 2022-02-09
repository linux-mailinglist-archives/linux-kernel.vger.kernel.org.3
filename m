Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071F54AEE09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiBIJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:28:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBIJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:28:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF0E0BE56B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:28:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFsE5Jati2I94WQCWdYsqfPf/B9APQww3pZRjM0ToYv9TJVjgUFbExNbBVCNlR3u7TrEjBx746YpxscDLPaxBJCMSsBeo0NLH8k0iXgo/6RpkKUJwb0WzIHsMMb7tWaVgA0lzF2l8ONfIQL59qAG0dCJSArjcLJCYj487bEUPVXtfpSD/KtA4HAdo8BaOvuMG4wS8gtpPp9u2AemtiVpSE3bOBJhz/+uZ9tKSBkqcuwY6czqgiDBezX9Gw2gM6G+SKzqfRQmKBM6A/BH+jyKX6A1mgYDKoqw3l0K0WFBxrHwgroG/1uuRbW491gMJrfLDd62fLPraNafnkEKBVteNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AtpjKIQOEyQ+tB1ENFcasP07GhfdeApKQ8dAFAOJy0=;
 b=kK/YXJVr6TlpSOCtFqU/9fp+PPPquMhzxOf7hFw7YtSLRMv+KunCLdyd0Tga71OrTFcLPqN+27mPmOoBpCKaQMfEEeiIMKoFRrVXJ05QDX8n5PNq6PoWv/WQlVlMU+kyamlVNE5ulReIaui+nAykrtdG4TwRZXkKQcRbScwFEFw8Lw8WqIDYjXLWXghNIhCTraNTsFy2tbmy64QtXf2dcnPO+FxfuVH661aWMswJWoq9kuVb6cA3VsEkIj938JWyR2IOrzMk9I4pTpDsZ0Via2PgIcCANScSQqIveNzKHFSCxIPBZzei2HVAWdDyYsFTjDGltnPYsbfaiC4DbVSYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AtpjKIQOEyQ+tB1ENFcasP07GhfdeApKQ8dAFAOJy0=;
 b=q2Xnq/JCA85lz0r7KSYKPAKl5kzNzOKKqowz7Om+q1umIjWCoU48x2DuCfACBPeKFtdIMJrOd8XntdbHGFeBx6+pQag+iuZJviIK5fARaLS7n4oWse4VnJzTqT9GKGaakDYRy8DcJtuGkVwTeRcX/E9WXaSLh7sKvcwIqVsHriM=
Received: from DM3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:0:50::12) by
 SN4PR0201MB3501.namprd02.prod.outlook.com (2603:10b6:803:4d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 09:28:07 +0000
Received: from DM3NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::a1) by DM3PR03CA0002.outlook.office365.com
 (2603:10b6:0:50::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 09:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT011.mail.protection.outlook.com (10.13.5.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 09:28:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Feb 2022 01:28:02 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Feb 2022 01:28:02 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.49] (port=39816)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nHjGc-0002R9-Gs; Wed, 09 Feb 2022 01:28:02 -0800
Message-ID: <195d35e3-dcea-e651-ff54-699c3019b6c6@xilinx.com>
Date:   Wed, 9 Feb 2022 10:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 1/3] firmware: xilinx: Add support for runtime features
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
 <20220209082709.32378-2-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220209082709.32378-2-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8420cd-90f3-4396-7b8d-08d9ebae7ae0
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3501:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3501F7EBC4631124A3AA0435C62E9@SN4PR0201MB3501.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6CzAtVdOa9gEMchSNab6m74sPNHOHmeDNig9AaFuEPsXbLQUmgn6c9kTKT+awIT+8h7I3kiSQDyFhCYilHx3oFmojTrv0A8F9nOj0GZTEWTC0sDr/GiE2F2ubfykvcpd1Qgj4h2kPy030PWO0nJ78Al8yAzANWHUXoYd1LDGgVZM8NCZcvostmB2Hmls4XJyVo1ZSNF4xGwi/YtJABi/0Vx5jyIXodOPhtWl6p0eWCS6fGkRgCv589qjG++I5dnLFldUNUeD39Ukl+nV1akp1wxRILsMZ6qUxRWfCVFTpxzTlNnoPv1NRJQsF/77oMqzmvl7MBwJitn0dzYcmUqoX19NBxPKNXUUFv/70ftBaRwexL0tnpn3uAbUeKhhQYyYGxla7OuOsNXQOHl8Fg1GT/kPKITH/Qd5q+LgBTCXqfG/043iwmNxsfhchNTWVK+SIO2AqNCCtG6p/MKeokoKOe1o6kJiqjWcaTIUv/LHy9sYBMP1qflDeJSo41fTJ6Gj9ZIIwBb3KjSxBQK2pZljMgJ2o1IDl/saiytvQYWf8a2u7GG7Wh3kQ8+QOMSGFJXhun479XOE038cJIjEDrzK/5SlTzMflIdRoDFYRACfGoo3tYlrM9WGSFaa564meUGCptutWg5al8tkujqbkQzCptgeDRfjldkb4m01KZ14Dy47tPkxGh3zudA6mpG2j/kLZOYgVJucKwnQQpa9ZXOdMroHsGyUbXSlbhxB/P7dHc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(31696002)(316002)(4326008)(47076005)(9786002)(53546011)(8676002)(7636003)(356005)(8936002)(6666004)(508600001)(82310400004)(2906002)(54906003)(336012)(36756003)(36860700001)(83380400001)(186003)(31686004)(44832011)(40460700003)(426003)(70586007)(70206006)(26005)(2616005)(110136005)(107886003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 09:28:06.7223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8420cd-90f3-4396-7b8d-08d9ebae7ae0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3501
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/22 09:27, Ronak Jain wrote:
> Add support for runtime features by using an IOCTL call. The features
>   can be enabled or disabled from the firmware as well as the features
>   can be configured at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
>   Similarly, the user can get the configured values of features by
>   querying IOCTL_GET_FEATURE_CONFIG id.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v5:
> - Resolved merge conflicts
> 
> Changes in v4:
> - Update commit message
> 
> Changes in v3:
> - Resolved merged conflict
> 
> Changes in v2:
> - Resolved merged conflict
> - Update commit message
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 27 +++++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h | 25 +++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 450c5f6a1cbf..0fa6cae4969d 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1156,6 +1156,33 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
>   				   0, 0, NULL);
>   }
>   
> +/**
> + * zynqmp_pm_set_feature_config - PM call to request IOCTL for feature config
> + * @id:         The config ID of the feature to be configured
> + * @value:      The config value of the feature to be configured
> + *
> + * Return:      Returns 0 on success or error value on failure.
> + */
> +int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
> +				   id, value, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_get_feature_config - PM call to get value of configured feature
> + * @id:         The config id of the feature to be queried
> + * @payload:    Returned value array
> + *
> + * Return:      Returns 0 on success or error value on failure.
> + */
> +int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
> +				 u32 *payload)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
> +				   id, 0, payload);
> +}
> +
>   /**
>    * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
>    * @subtype:	Shutdown subtype
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 907cb01890cf..cf557fbeb8c7 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -143,6 +143,9 @@ enum pm_ioctl_id {
>   	IOCTL_OSPI_MUX_SELECT = 21,
>   	/* Register SGI to ATF */
>   	IOCTL_REGISTER_SGI = 25,
> +	/* Runtime feature configuration */
> +	IOCTL_SET_FEATURE_CONFIG = 26,
> +	IOCTL_GET_FEATURE_CONFIG = 27,
>   };
>   
>   enum pm_query_id {
> @@ -376,6 +379,14 @@ enum ospi_mux_select_type {
>   	PM_OSPI_MUX_SEL_LINEAR = 1,
>   };
>   
> +enum pm_feature_config_id {
> +	PM_FEATURE_INVALID = 0,
> +	PM_FEATURE_OVERTEMP_STATUS = 1,
> +	PM_FEATURE_OVERTEMP_VALUE = 2,
> +	PM_FEATURE_EXTWDT_STATUS = 3,
> +	PM_FEATURE_EXTWDT_VALUE = 4,
> +};
> +
>   /**
>    * struct zynqmp_pm_query_data - PM query data
>    * @qid:	query ID
> @@ -447,6 +458,8 @@ int zynqmp_pm_load_pdi(const u32 src, const u64 address);
>   int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>   				const u32 wake, const u32 enable);
>   int zynqmp_pm_feature(const u32 api_id);
> +int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
> +int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
>   #else
>   static inline int zynqmp_pm_get_api_version(u32 *version)
>   {
> @@ -689,6 +702,18 @@ static inline int zynqmp_pm_feature(const u32 api_id)
>   {
>   	return -ENODEV;
>   }
> +
> +static inline int zynqmp_pm_set_feature_config(enum pm_feature_config_id id,
> +					       u32 value)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
> +					       u32 *payload)
> +{
> +	return -ENODEV;
> +}
>   #endif
>   
>   #endif /* __FIRMWARE_ZYNQMP_H__ */


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
