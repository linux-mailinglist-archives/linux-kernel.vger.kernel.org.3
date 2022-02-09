Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14134AEE15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiBIJcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:32:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:30:59 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF866E0C5BEC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:30:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3rO/tYVpQlY3lV2u/iYExawhF50OcW5KHegbBVA09JvgMe/kBt4l3OC3+97T6PPBuJySQWNCRqB4ZEfxEXWimWdDJPHpjOHjxnAqazuBzxRt73I0T3RLbdd+kZSDIUgN0QzKrvEjXDjVUbE7LsUH5ectTb5PiZOhSL3fnkC6UDKO/7/LU3vewjxYI0Qwhag6aa9TCJl5H2Fzp4IEONM6dK/gkMb7ik/YefEp+dnjoC4YFCOrMLZVIxdeFMl7whrhTs9Xu4nkxlCqP3X6pIEllaFCwT5ykIu8esYUyq5DZfqYgMwp+y8gQRtQOlv8SwxsUjFWXhdetDBMpyP8YtnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UnzYzCpq5cV6lEBLwi+iAVma/PLJ8BphB33xX+Yj/E=;
 b=P5orXajdNdMte+XadKcyZuUFV1TI6hWVkDGp2bmdhBhrVnkD1b2GZ23YR1GXTHz5vLdsOdWeFWoSCCvbhxIfbqIymjqyO+5cKKP/gM8on5CWgZp/TaapaadikUCt066HiTUJbZgCtjRtQcivYifLVL2G5BdgQDg+xrMwLBuYwV9hCNvisVU4QW4nLvUM0zIbyUwiQj1tM6puA51lOLR1nflUVvrNnmddyCxnwMiuG/r9Y0iNBTmqFo2ez+DrWz4nCp68xz19Tm3evhJvT9LdPlL2GVkzAcE/bltkzg/MlUd1gRx3ma2tJ8RfOarg2uPVSXPpiiN+ZMe90nfkWFTjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UnzYzCpq5cV6lEBLwi+iAVma/PLJ8BphB33xX+Yj/E=;
 b=Cc9udWq2EytL6HNQ6qG2IisPu7qQ3D/bmgcPC4w8KTTKP2d8yoKt5nbPH7sXYDLm8cAcVEQMYemsPgaRHuJWOdZ/Gaa8Jq54Y3IVVFWkNbcjdlTG7WAUUrGGdvu3tZdfYhhLP3nTL3/PyvZXb34LfSCT5t2//uf/YJQcyXFf/fk=
Received: from DM3PR12CA0068.namprd12.prod.outlook.com (2603:10b6:0:57::12) by
 PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Wed, 9 Feb 2022 09:29:54 +0000
Received: from DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::f3) by DM3PR12CA0068.outlook.office365.com
 (2603:10b6:0:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 09:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT017.mail.protection.outlook.com (10.13.5.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 09:29:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Feb 2022 01:29:52 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Feb 2022 01:29:52 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.49] (port=39968)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nHjIO-0002q1-1e; Wed, 09 Feb 2022 01:29:52 -0800
Message-ID: <2ef7c8f9-39cd-1c3c-6f96-9dd8cf5f851c@xilinx.com>
Date:   Wed, 9 Feb 2022 10:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 3/3] firmware: xilinx: Add sysfs support for feature
 config
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
 <20220209082709.32378-4-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220209082709.32378-4-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 866852e9-4446-49c1-c7d2-08d9ebaebad4
X-MS-TrafficTypeDiagnostic: PH0PR02MB7557:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB755736DDE16053520DC44C07C62E9@PH0PR02MB7557.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3hemcrE/mUlyNNa9vCd3KIsjS2ElfUlHO3rPlDQCUOYlMZP71u6N7RxvKQa52lOXTpj5QuovSBbqUbjdff63zN76Lt/qiw4WfkIAIp0mClCqLiNvptZmNdq8EHPa7PLxIr+l2F/jInj7m8s/fZflpt4iZ5bGHFDo6D8ktvJXDZG3rndkdq9ggwMzadVBmvpFshKULK1K+HP8sVeyg87GCQJJycEx9Btle0xCYl12JEXQr1KEd2LFq3Shny4hqmzbovm3RS06hrMxsCWV73B5jXj8DTrkzU+5/HtUsk94BJtXMBQsQ+rjgMptWnl2MURjdKMFawJSFNM20Sy0MNOdoKWoVRkCupmOxMPfabObgemQPQyebAyutBg14F1rXDSqd/z/3t/NS/uoN3M+auzz8fmoFRZnER1biOsczyFNmVQ4eBkSA8AtSSWn2exXTXbEKdaQ8YRJAqklEt3bCmZium1TIp7Dc7eNZGga+wQ71VWIyLtItH1fFJzue8NKaHRDxnjjF3TnBWW2MJnBeQKLWFQkGWE89jP6io/prY9gH3Fw43o7y9DaihH3+eD2/XHhkdfBTkt5RE/KB+10RPS3mmXf28rsLRGkKKzdN8KhJa+3OXCRTlTEk+JJ2AgdBtR9xJgDWSXXecwyk64Cbvpitx/Cw/Vx1rd58PdSSkF1CkO+G0KnqPryP4o4Rxd5VL1OKxD9G0uOIaGhAFFRI7SdytokaSzpd3cpxQhXgJjF8k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(36860700001)(316002)(53546011)(40460700003)(36756003)(31686004)(6666004)(110136005)(5660300002)(70586007)(8936002)(9786002)(70206006)(8676002)(4326008)(2906002)(44832011)(7636003)(82310400004)(107886003)(426003)(356005)(186003)(26005)(336012)(31696002)(2616005)(83380400001)(54906003)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 09:29:54.0042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866852e9-4446-49c1-c7d2-08d9ebaebad4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/22 09:27, Ronak Jain wrote:
> Add support for sysfs interface for runtime features configuration.
>   The user can configure the features at runtime. First, the user need
>   to select the config id of the supported features and then the user
>   can configure the parameters of the feature based on the config id.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v5:
> - None
> 
> Changes in v4:
> - Update commit message
> 
> Changes in v3:
> - Added zynqmp_devinfo structure to store device instances
> - Modified feature_conf_id from atomic variable to u32
> - Update commit message
> - Resolved merge conflicts
> 
> Changes in v2:
> - Update commit message
> ---
>   drivers/firmware/xilinx/zynqmp.c | 93 ++++++++++++++++++++++++++++++++
>   1 file changed, 93 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 0fa6cae4969d..7d8cb2ec6f8e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -41,6 +41,16 @@ static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>   
>   static struct platform_device *em_dev;
>   
> +/**
> + * struct zynqmp_devinfo - Structure for Zynqmp device instance
> + * @dev:		Device Pointer
> + * @feature_conf_id:	Feature conf id
> + */
> +struct zynqmp_devinfo {
> +	struct device *dev;
> +	u32 feature_conf_id;
> +};
> +
>   /**
>    * struct pm_api_feature_data - PM API Feature data
>    * @pm_api_id:		PM API Id, used as key to index into hashmap
> @@ -1451,6 +1461,78 @@ static DEVICE_ATTR_RW(pggs1);
>   static DEVICE_ATTR_RW(pggs2);
>   static DEVICE_ATTR_RW(pggs3);
>   
> +static ssize_t feature_config_id_show(struct device *device,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
> +
> +	return sysfs_emit(buf, "%d\n", devinfo->feature_conf_id);
> +}
> +
> +static ssize_t feature_config_id_store(struct device *device,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	u32 config_id;
> +	int ret;
> +	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret = kstrtou32(buf, 10, &config_id);
> +	if (ret)
> +		return ret;
> +
> +	devinfo->feature_conf_id = config_id;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(feature_config_id);
> +
> +static ssize_t feature_config_value_show(struct device *device,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
> +
> +	ret = zynqmp_pm_get_feature_config(devinfo->feature_conf_id,
> +					   ret_payload);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", ret_payload[1]);
> +}
> +
> +static ssize_t feature_config_value_store(struct device *device,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	u32 value;
> +	int ret;
> +	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret = kstrtou32(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret = zynqmp_pm_set_feature_config(devinfo->feature_conf_id,
> +					   value);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(feature_config_value);
> +
>   static struct attribute *zynqmp_firmware_attrs[] = {
>   	&dev_attr_ggs0.attr,
>   	&dev_attr_ggs1.attr,
> @@ -1462,6 +1544,8 @@ static struct attribute *zynqmp_firmware_attrs[] = {
>   	&dev_attr_pggs3.attr,
>   	&dev_attr_shutdown_scope.attr,
>   	&dev_attr_health_status.attr,
> +	&dev_attr_feature_config_id.attr,
> +	&dev_attr_feature_config_value.attr,
>   	NULL,
>   };
>   
> @@ -1471,6 +1555,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np;
> +	struct zynqmp_devinfo *devinfo;
>   	int ret;
>   
>   	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> @@ -1487,6 +1572,14 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	devinfo = devm_kzalloc(dev, sizeof(*devinfo), GFP_KERNEL);
> +	if (!devinfo)
> +		return -ENOMEM;
> +
> +	devinfo->dev = dev;
> +
> +	platform_set_drvdata(pdev, devinfo);
> +
>   	/* Check PM API version number */
>   	ret = zynqmp_pm_get_api_version(&pm_api_version);
>   	if (ret)


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
