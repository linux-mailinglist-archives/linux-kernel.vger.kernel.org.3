Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF5514456
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355803AbiD2Ijz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355815AbiD2Ijo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:39:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D128A777E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncu0lO7OytiyC2WYvai7iVeHESAAhL8XMkH/gyLe5I523qjznHolWFJ/wR+6mlnGjqswgJBa/LBmhbMvaLWLmw394JJQR6QlqFSVzmswNWyrJ804MH3BysKsXn8JxfHa3aqt49vvn6ha1VUZE4klDWifCLazKxAhjMcLKcLcuykZ7hCnRDKUkStsW5kZeVT4TQV+LDzf3HaxwI8HFSyBQoZ2JxlyA6W6L+hrRfDwCXFDTGcT4WD4Xa8BZex/rTwPvIeHWJKcak9N3zvtUWXbSaB7ZNrGZbDr0cLjQXZjkAysMnBUcoRF/zdFmMqcRnwd+aNez/nA1Gk/rQLYRT5ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZGCC7ZajxlfZJ8cDUD0BxoPH4MAuXGnXcgI+GDLhGk=;
 b=S14kbxgcxgoHgN+fgYPXqdIXo+E4bzGad3stnS16u+WFFH/ZW5CZpiWCakPr99cI0sIhy1UOfAytkmNZWl+BziEXJY0vhkwmtN6VwvGse09NbxHfMW6WZSJFXumHwUTs1DCZrdaKMyjgT4HecDChXG4nDyuGZLgaKyb0JNg+3idshtDbFs6BFbMxUntK8Ebca3n7dsGOWHULQcUa+WwyhQ6OZr+ZGQyOf0ag+P6QmpqZc46WtLZFrIqeJCyiWZG8KoolilPPuFrvxQsOzmhZyHMUbXAKuwu+cqlJJOeqtDB/aImzkHW02AMl1UuC3EH0DtQuln0CDwlcxs3eVYdc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZGCC7ZajxlfZJ8cDUD0BxoPH4MAuXGnXcgI+GDLhGk=;
 b=bC9ObwgoOKyelz62YH/f5UUFm19643Eh1DhdfeBHA3kTIl1I5nK3P403RVKOjvpmuXCRc+um91eMvyCX0u1uDkjY4la7G6PTvauLnzyYWDU70vbBgu0UBzLncfiQDoh9pLSUGBygjykLhtolEfHIK7EBjcTHCKVUZ4fLIzcqEUo=
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by DM6PR02MB4571.namprd02.prod.outlook.com (2603:10b6:5:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Fri, 29 Apr
 2022 08:36:25 +0000
Received: from BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::76) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 08:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT011.mail.protection.outlook.com (10.13.2.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:36:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:36:24 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:36:24 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.50] (port=34552)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nkM6y-0007Nh-BR; Fri, 29 Apr 2022 01:36:24 -0700
Message-ID: <50cc8c4b-4b75-d9f4-f0e8-bc246345920a@xilinx.com>
Date:   Fri, 29 Apr 2022 10:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/4] firmware: xilinx: enable feature check for ZynqMP
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
 <1649242526-17493-5-git-send-email-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1649242526-17493-5-git-send-email-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 755032d1-44c8-41f4-fe44-08da29bb58c2
X-MS-TrafficTypeDiagnostic: DM6PR02MB4571:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4571DFBE55F145C56B8F256AC6FC9@DM6PR02MB4571.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdHiJmklwvpPt5AkVoXqpaHcs5i84kXL4p9fMXngrYjEG2xn0wkQR5McDu7JphHmrWAoMXrD2qMy+DFG6hI0qdBurOFsxKsXI/4NQzjlLKBEiFGcGlgjLC/aJ1GHU/adLXzWc1kCmXw9EnOp4XcxBfUtGoDOeEIDWMTlgbKhtcyGRUnm7Kcpf1QFDek4rcyFiPHVAT4kxKmmlpr2QjseYkMimXlki3kQCod0lkOqYTUWvdgmg+pC7tUeSJkhPzIzXZQO7r1el/wevL61MRAVjqmbbMWgZZKsJvs6BszUqeQ3yLTi/gw7l8cHMRVXlXVCYeJqh0vfYBxp/Bo9XRG5pymxlXHXFTwNVv3KB5PCWiYQ21VmSSeiVm94AHL0FmeJ0IwM+5KmnHSrGO8lAWSS6pxeOoeQ8vMsAqpjS1KjIc0C1GqbeyNxigqAcGTg0XlFQhACwyTDJiZ0paU7woNa2WfB0VS2kTcCqp2hdIYHK4egAIhx1LYl5dpoqfjIrVI9vWnargglVREJf8z6VE5lWns5RO/ZOHaQm+dov+6Qih5MIuQWqfHyzQlXFuAM0AjVzGYcNSVpnO5L4cLkke9GunZZ8PjbGLUHFUE1SdXSQqOIGzzJYWQPKpEjrFgPEkUjmsePx3EK70gEcMFkPYOWSIMQ1S78LAzrXf9DL7tGu8mp2eOpKbMiGjHzl7Uj+3+Y8bCpGUhVTpx8x2hhr1B9ozVEzA/ALH3OAeSfIym+7ok=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(26005)(31696002)(2906002)(36860700001)(31686004)(82310400005)(508600001)(8936002)(316002)(9786002)(356005)(53546011)(186003)(107886003)(2616005)(54906003)(40460700003)(110136005)(7636003)(426003)(336012)(44832011)(8676002)(83380400001)(6666004)(47076005)(4326008)(5660300002)(70586007)(70206006)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:36:24.9737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755032d1-44c8-41f4-fe44-08da29bb58c2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4571
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/22 12:55, Ronak Jain wrote:
> Enable the feature check if the PM_FEATURE_CHECK API returns success
> with the supported version for the ZynqMP. Currently, it is enabled
> for Versal only.
> 
> Move get_set_conduit_method() at the beginning as the Linux is
> requesting to TF-A for the PM_FEATURE_CHECK API version for which the
> interface should be enabled with TF-A.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 6ee94f31ac98..7977a494a651 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1662,6 +1662,10 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   	struct zynqmp_devinfo *devinfo;
>   	int ret;
>   
> +	ret = get_set_conduit_method(dev->of_node);
> +	if (ret)
> +		return ret;
> +
>   	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
>   	if (!np) {
>   		np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
> @@ -1670,11 +1674,14 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   
>   		feature_check_enabled = true;
>   	}
> -	of_node_put(np);
>   
> -	ret = get_set_conduit_method(dev->of_node);
> -	if (ret)
> -		return ret;
> +	if (!feature_check_enabled) {
> +		ret = do_feature_check_call(PM_FEATURE_CHECK);
> +		if (ret >= 0)
> +			feature_check_enabled = true;
> +	}
> +
> +	of_node_put(np);
>   
>   	devinfo = devm_kzalloc(dev, sizeof(*devinfo), GFP_KERNEL);
>   	if (!devinfo)


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

