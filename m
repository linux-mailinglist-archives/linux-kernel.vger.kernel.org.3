Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD44B3244
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 02:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiBLBDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 20:03:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiBLBDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 20:03:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746F3BB;
        Fri, 11 Feb 2022 17:03:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCeUb59LTCyK1ZNfpZZrLr2HDnr2umLXTQUQSwqih+SxIxYRkPeGK8l2ZHqT04sSO2YYr7+iOZuvlOKghxnHVisPUZs7oTwYIp6NxjAcBf3nNDVrpfStYX3S7HjQFCHBRZvTRmQmJpUu24+mqY6pv0hzVOpakNHoZj5MDz3n4mEQ4Ibq8IcifMDVPilg09TcyYEO0PZCou7HB4FWf4pfDR0Ps6hF3UZC//u6zwitYR0DauNBnegiZ/pltlCTBJxOWrbVztO7ADUwUG2jaaDimEAM/6slioCbWhSLFPY3IBOIZKjAA2kq/52CC3twFfik/1HDbakZifLpmfHL9gydpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8srxekw+44E60yM4IoM+8tC2CjNMDLgI13DdVLrrtuc=;
 b=TdVu4tOIi/LJPvH728CoQtmMoGgxPuY/s7qabXt9+DWa36PQqhOdEPfhvlhGYC4X6fSbyRpSdf0lj1puANw+uwX118OZjAU6bk30uGsMkLNj1YRhMDJ0dA9k+zjUV77vogPyDT/sqPqYPw+Mzy0bQG8APCEPKp9k5meWA3+vV1brx6DDpuzjZoksfdad6qTPTVQjdE7sFGFpD4JnGVA5B2cTMc/cok114KuC2AlyGCJiCRrRT1hgVVQmyvLqBlVnXQcPyYtDmJ5fiRXl2XN2c7H87H04MMfVc46h3hT99eenGiMdFYBY7DIf2IHxAela6o5ZQEMJ7hTsJx0MtDt9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8srxekw+44E60yM4IoM+8tC2CjNMDLgI13DdVLrrtuc=;
 b=gMIeTTv3Pkg20Zs5/lOpcsIV7MDCVf4ut0fXqMek4dhYuishngPBaelWZwXBc1F/WCz2WovX13oy6YXCaCTmZGb9cBFw1SAWHzEE9PdqjSzZELBQRQIzJId06ZXSyM7n97+vl4iJbhlJveac8zncGgr/BgXsFZO49Tw4tqnL8Fc=
Received: from DM5PR19CA0055.namprd19.prod.outlook.com (2603:10b6:3:116::17)
 by SJ0PR02MB7743.namprd02.prod.outlook.com (2603:10b6:a03:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Sat, 12 Feb
 2022 01:02:57 +0000
Received: from DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::1d) by DM5PR19CA0055.outlook.office365.com
 (2603:10b6:3:116::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Sat, 12 Feb 2022 01:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT054.mail.protection.outlook.com (10.13.5.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Sat, 12 Feb 2022 01:02:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 11 Feb 2022 17:02:56 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 11 Feb 2022 17:02:56 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 trix@redhat.com,
 linux-kernel@vger.kernel.org,
 robh@kernel.org,
 devicetree@vger.kernel.org,
 yilun.xu@intel.com
Received: from [10.17.2.60] (port=60768)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nIgoS-000Bc0-2S; Fri, 11 Feb 2022 17:02:56 -0800
Subject: Re: [PATCH V1 Create empty OF root 1/1] of: create empty of root
To:     Xu Yilun <yilun.xu@intel.com>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20220126054807.492651-1-lizhi.hou@xilinx.com>
 <20220126054807.492651-2-lizhi.hou@xilinx.com>
 <20220211153801.GA1273192@yilunxu-OptiPlex-7050>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <14bd131d-c978-e669-df55-45b58ff3bf6e@xilinx.com>
Date:   Fri, 11 Feb 2022 17:02:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220211153801.GA1273192@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd3b50e-efba-432d-8c3d-08d9edc36867
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7743:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7743554EABB94B539B54E43AA1319@SJ0PR02MB7743.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reQu9h9GvPz7UxYQmSYM41/MYK5RDDYRL2dtKNO1zhjuHEiEBa76PlTYHDG6fmIzy1hOkz2kuM/gwkLQXIUtmRDNJeGRJ08VwKOtQE3AOtCMf6aPrCHJ/nyR+EE43HdM8wNn7WIXitrzEUYxcgvS5mwYb21TXq0rVz8MvvEDh6Kapqaq1pQrcxgWpCV4vMdi0+ukVbA1iz4De02gzGJb3DFAeI9ez8skk11huBB1K6utQ20JumI6ag0uHkJOCOGRqEcGCzbOSKwcIkc7ba9Bi2mFqT3Z0But9voAmVbDDbGDMQbt1+7ohUSLJ4ttrIkmhMeFw0Q4XYR8ZAk8uRsxU8WiEAIkMq+0fkKfHhkCVEDx5UVdxCEKkOHZJtgnGX/lB4NX9BXMHMzCjoIVa6Hcq19a5oVxL3igqOoMOvh4gPz3Iizb+6o58ohwaLuUioqwkMY6RjESrkwnWrReiewyFXdkbVZG+PG2AJnXcGl3gWI6kwnY6Wa2nN8+61QBTc5gXbSfTblTRAt9/4JMXGc11XImjskmj5sGsPwKB6Xw+2OHMMiMFZ6vvlLnHrTuD4WzOUSIJZALh9bBQYVRd0EmmkqDmEWSm60p5+1/TN5YNQx5NHhDm+dBAdNGG7xOvAexLh/aOlXe5nr3ZUDd+pIVq5jgj295/9HILzaD/COBElg6jxDSSSq73OwzRnkgZVyOgrYqdwaOQ14Y1HmHRlpbMrQPryORLVGMqtmY9ToOzHkoPHTN3s475BLbAy34V/jitlYERG4fTjDzsLrLUfVEQhbv4UXPQaPNEr0dQ02ZhLKKJPQMf+y1/Wyxu0KV5wR1
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(4326008)(53546011)(356005)(8936002)(966005)(44832011)(36860700001)(70586007)(2616005)(5660300002)(107886003)(47076005)(7636003)(186003)(26005)(70206006)(508600001)(36756003)(426003)(31686004)(31696002)(2906002)(316002)(9786002)(40460700003)(110136005)(82310400004)(54906003)(336012)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 01:02:57.4720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd3b50e-efba-432d-8c3d-08d9edc36867
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7743
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yilun,

Thanks a lot for your feedback. I will revise the comments and send 
another patch.

In the meanwhile, based on our previous discussion,

https://lore.kernel.org/lkml/20220111070000.GC979169@yilunxu-OptiPlex-7050/

I will propose another patch to add an of_pci interface which can be 
called by pci driver probe routine to create device node for it.


Thanks,

Lizhi

On 2/11/22 7:38 AM, Xu Yilun wrote:
> On Tue, Jan 25, 2022 at 09:48:07PM -0800, Lizhi Hou wrote:
>> Add OF_EMPTY_ROOT config. When it is selected and there is not a device
>> tree, create an empty device tree root node.
> Maybe add some description about why a empty device tree root node is
> needed. Note that the Patch #0 will not be present in the repo when the
> series will be merged, so add your description here please.
>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/of/Kconfig         |  3 +++
>>   drivers/of/Makefile        |  1 +
>>   drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 55 insertions(+)
>>   create mode 100644 drivers/of/of_empty_root.c
>>
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 80b5fd44ab1c..42afb126f91a 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -94,4 +94,7 @@ config OF_DMA_DEFAULT_COHERENT
>>   	# arches should select this if DMA is coherent by default for OF devices
>>   	bool
>>   
>> +config OF_EMPTY_ROOT
>> +	bool
> Also some descriptions for better understanding?
>
> Thanks,
> Yilun
>
>> +
>>   endif # OF
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index e0360a44306e..c65364f32935 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>>   obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>>   obj-$(CONFIG_OF_OVERLAY) += overlay.o
>>   obj-$(CONFIG_OF_NUMA) += of_numa.o
>> +obj-$(CONFIG_OF_EMPTY_ROOT) += of_empty_root.o
>>   
>>   ifdef CONFIG_KEXEC_FILE
>>   ifdef CONFIG_OF_FLATTREE
>> diff --git a/drivers/of/of_empty_root.c b/drivers/of/of_empty_root.c
>> new file mode 100644
>> index 000000000000..5c429c7a27bd
>> --- /dev/null
>> +++ b/drivers/of/of_empty_root.c
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2022 Xilinx, Inc.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +
>> +#include "of_private.h"
>> +
>> +static int __init of_root_init(void)
>> +{
>> +	struct property *prop = NULL;
>> +	struct device_node *node;
>> +	__be32 *val = NULL;
>> +
>> +	if (of_root)
>> +		return 0;
>> +
>> +	pr_info("Create empty OF root node\n");
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return -ENOMEM;
>> +	of_node_init(node);
>> +	node->full_name = "/";
>> +
>> +	prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
>> +	if (!prop)
>> +		return -ENOMEM;
>> +
>> +	val = kzalloc(sizeof(*val), GFP_KERNEL);
>> +	if (!val)
>> +		return -ENOMEM;
>> +	*val = cpu_to_be32(sizeof(void *) / sizeof(u32));
>> +
>> +	prop->name = "#address-cells";
>> +	prop->value = val;
>> +	prop->length = sizeof(u32);
>> +	of_add_property(node, prop);
>> +	prop++;
>> +	prop->name = "#size-cells";
>> +	prop->value = val;
>> +	prop->length = sizeof(u32);
>> +	of_add_property(node, prop);
>> +	of_root = node;
>> +	for_each_of_allnodes(node)
>> +		__of_attach_node_sysfs(node);
>> +
>> +	return 0;
>> +}
>> +pure_initcall(of_root_init);
>> -- 
>> 2.27.0
>
