Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422F34AEE19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiBIJce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:32:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiBIJbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:31:18 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035B7E04FEFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:31:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSOSJ7zXRjetmX+liZO15XrSnwW4LCYiljtscs12O0sy7fBZTkNVQqyZWmj08a3Qlvd7Dts9P2C8Vtv4kyS5qvqbTIYLIEw9UMQmvMD+5sKAJdfoiwTlUCeSZO9E5XZCr3ih6uKEL2K9geefoy3w/1VSuml1Mst7lgrnhkNQp5wGhevbKZJxSLVcvPmpQC9k9AXYUdVWS+rT7UqFMoBA2xOVg9ceJTIzcNUpTZFJgUJDbLUEkz4Xy4GOZ6ioKTZ4X8AxmdLfGbmuFHoJTv73LQMYxrA5etp6nWLCZagi1IaHYvv0g4g5Yls7ymJgN3hHYB9AjND4SnT8bH3g3NBp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmP6C9Qiz10L9OdqqItKjsqiZMw82RYXHJZEs8qPyBc=;
 b=Q7+HdUcgIPSLBfEJbgPKCAQePh9VT0I6+7KuRBlwe9uY2nJa71DNVtMgYhd5XMgqJRp09VIo9PUXpARaXLYfnioK1JISrR46aMS9t04yjKMB3IxUrEOwABAjm6pZaPwr815GLTBVcShSufMyIfrKwqMAX+VxPIFnnRT2ZQxyvIeerkfmF6o+9K+WtPVN2iUEhQX4pWiPXUeGUfqyAbOGgOs3N8HB9MslcmBSJDWHd/CLQSo7Dq+Q9wfJhsATZlfEFz6FQ7B184gCPxB9vULYMH5z4hGcSY0MJEddNEToToezROQC3y7Le67oSNDVeytjvjVk4sE1sRZeFeuUusrz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmP6C9Qiz10L9OdqqItKjsqiZMw82RYXHJZEs8qPyBc=;
 b=Zxx07Lnh5vhJ+YwX5C82ibfnl17JTKjmd0w4svdTlkU0U3JopGKQ7kmmtnImpQraEMOHZExCQ+zVh6yn9HN2kv9HSsaRbdwAca/flSvh5YbCNZEl7WJ780FNFpHjR1DYIG1n+Dn9ksnOf8vb0SoxA8NW/UQMV8xCpFg7j0XWgtA=
Received: from DM3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:0:50::30) by
 PH0PR02MB8745.namprd02.prod.outlook.com (2603:10b6:510:4b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Wed, 9 Feb 2022 09:29:42 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::69) by DM3PR03CA0020.outlook.office365.com
 (2603:10b6:0:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 09:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 09:29:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Feb 2022 01:29:41 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Feb 2022 01:29:41 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.49] (port=39952)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nHjIC-0002pY-Kk; Wed, 09 Feb 2022 01:29:41 -0800
Message-ID: <d73c3b2d-2b46-4921-beff-fe7843f22325@xilinx.com>
Date:   Wed, 9 Feb 2022 10:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 2/3] firmware: zynqmp: Add documentation for runtime
 feature config
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
 <20220209082709.32378-3-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220209082709.32378-3-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccdb9c44-0a89-43b5-ffb5-08d9ebaeb375
X-MS-TrafficTypeDiagnostic: PH0PR02MB8745:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB874530AA464DC20DC26F767FC62E9@PH0PR02MB8745.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pT4sqZ+yJ2Vg7tat+mlrK+7rDmsGdTFEMKxubK9VEhjF1J9wJT9bRbPalcHY4JeDM6U+yrI0w8AQwI1kG+KUDST73pjujSLwD5nIBtsWFPO9G0Pn7U7rcS9rjlqWlPthpjwgK4dkr0Y4ND/GM8kAiEgjJjrmG4M7XlA8QEdVVAvDdESbwum6rO+9Yrl3QBSISZzQKdwu38nTM01Dol2cMj433W5FDbBAuOpulL4YSblQ0XoXeo3nzY6tAevN4SeH5nH5CtAH1O3by6ISNJO/VLfjRJMgGmKCuX8ImDtKm4BFnpRAGEKGjZYZFhn3eVmTZt3ydsd/j1ugZBr7MfcsQNthHeXoh0vpC0AL6ZfO3JMhBZfTpLOpM0baUAaGPkaOUcOj4AhXESqiQhHMgxXyZdrV7lkMUFTDgjtPZgnhgJ6dNbJU+K1PYMiLmwx+2/hvuA1my4TSL/ugiwVARJyTehi94a5mZjNeZyU2Is71oecf3pRhaqrkA+aS2P8MSOtosDTxIItPJveQoN9yfXsX+9JuIhfLAdffa7cHk4Nd4qS9eMscqwEL+I8YqzR7fu30fYdN1N+JMjqbtyUog4RDqHybv7RH3LbTYzBI8o2nclsEh5GopCqwMfIwXeYrMntyBZdwnyEKLMQDsaTljfpgeOJHrotTaf9IuJvSyIbdu09sRVyUuYT1pmp6x42WtHO9W9u/LJWgeUzue3na0oo+acW5vGLjgzvbsWgHqQzkgPU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(4326008)(9786002)(2616005)(6666004)(53546011)(44832011)(26005)(186003)(5660300002)(70586007)(336012)(36756003)(70206006)(8936002)(426003)(54906003)(8676002)(107886003)(7636003)(31686004)(508600001)(110136005)(31696002)(356005)(40460700003)(36860700001)(316002)(47076005)(82310400004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 09:29:41.6390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdb9c44-0a89-43b5-ffb5-08d9ebaeb375
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8745
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/22 09:27, Ronak Jain wrote:
> Add documentation for sysfs entries like feature_config_id and
>   feature_config_value for runtime feature configuration. The support is
>   added for an over temperature and external watchdog features.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v5:
> - Update kernel version for sysfs documentation
> 
> Changes in v4:
> - Add separate sysfs entries for runtime feature config
> - Update commit message
> 
> Changes in v3:
> - None
> 
> Changes in v2:
> - Update commit message
> ---
>   .../ABI/stable/sysfs-driver-firmware-zynqmp   | 141 ++++++++++++++++++
>   1 file changed, 141 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index f5724bb5b462..c3fec3c835af 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -113,3 +113,144 @@ Description:
>   		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
>   
>   Users:		Xilinx
> +
> +What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +Date:		Feb 2022
> +KernelVersion:	5.18
> +Contact:	"Ronak Jain" <ronak.jain@xilinx.com>
> +Description:
> +		This sysfs interface allows user to configure features at
> +		runtime. The user can enable or disable features running at
> +		firmware as well as the user can configure the parameters of
> +		the features at runtime. The supported features are over
> +		temperature and external watchdog. Here, the external watchdog
> +		is completely different than the /dev/watchdog as the external
> +		watchdog is running on the firmware and it is used to monitor
> +		the health of firmware not APU(Linux). Also, the external
> +		watchdog is interfaced outside of the zynqmp soc.
> +
> +		The supported config ids are for the feature configuration is,
> +		1. PM_FEATURE_OVERTEMP_STATUS = 1, the user can enable or
> +		disable the over temperature feature.
> +		2. PM_FEATURE_OVERTEMP_VALUE = 2, the user can configure the
> +		over temperature limit in Degree Celsius.
> +		3. PM_FEATURE_EXTWDT_STATUS = 3, the user can enable or disable
> +		the external watchdog feature.
> +		4. PM_FEATURE_EXTWDT_VALUE = 4, the user can configure the
> +		external watchdog feature.
> +
> +		Usage:
> +
> +		Select over temperature config ID to enable/disable feature
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +
> +		Check over temperature config ID is selected or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		The expected result is 1.
> +
> +		Select over temperature config ID to configure OT limit
> +		# echo 2 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +
> +		Check over temperature config ID is selected or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		The expected result is 2.
> +
> +		Select external watchdog config ID to enable/disable feature
> +		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +
> +		Check external watchdog config ID is selected or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		The expected result is 3.
> +
> +		Select external watchdog config ID to configure time interval
> +		# echo 4 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +
> +		Check external watchdog config ID is selected or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		The expected result is 4.
> +
> +Users:		Xilinx
> +
> +What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +Date:		Feb 2022
> +KernelVersion:	5.18
> +Contact:	"Ronak Jain" <ronak.jain@xilinx.com>
> +Description:
> +		This sysfs interface allows to configure features at runtime.
> +		The user can enable or disable features running at firmware.
> +		Also, the user can configure the parameters of the features
> +		at runtime. The supported features are over temperature and
> +		external watchdog. Here, the external watchdog is completely
> +		different than the /dev/watchdog as the external watchdog is
> +		running on the firmware and it is used to monitor the health
> +		of firmware not APU(Linux). Also, the external watchdog is
> +		interfaced outside of the zynqmp soc.
> +
> +		By default the features are disabled in the firmware. The user
> +		can enable features by querying appropriate config id of the
> +		features.
> +
> +		The default limit for the over temperature is 90 Degree Celsius.
> +		The default timer interval for the external watchdog is 570ms.
> +
> +		The supported config ids are for the feature configuration is,
> +		1. PM_FEATURE_OVERTEMP_STATUS = 1, the user can enable or
> +		disable the over temperature feature.
> +		2. PM_FEATURE_OVERTEMP_VALUE = 2, the user can configure the
> +		over temperature limit in Degree Celsius.
> +		3. PM_FEATURE_EXTWDT_STATUS = 3, the user can enable or disable
> +		the external watchdog feature.
> +		4. PM_FEATURE_EXTWDT_VALUE = 4, the user can configure the
> +		external watchdog feature.
> +
> +		Usage:
> +
> +		Enable over temperature feature
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the over temperature feature is enabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 1.
> +
> +		Disable over temperature feature
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the over temperature feature is disabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 0.
> +
> +		Configure over temperature limit to 50 Degree Celsius
> +		# echo 2 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 50 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the over temperature limit is configured or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 50.
> +
> +		Enable external watchdog feature
> +		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the external watchdog feature is enabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 1.
> +
> +		Disable external watchdog feature
> +		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the external watchdog feature is disabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 0.
> +
> +		Configure external watchdog timer interval to 500ms
> +		# echo 4 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 500 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the external watchdog timer interval is configured or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 500.
> +
> +Users:		Xilinx


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
