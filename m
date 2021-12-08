Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF27D46C8BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbhLHAiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:38:07 -0500
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:8032
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229503AbhLHAiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:38:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdNGl8m9Oclf3+6gYlZ+QbJo+emsmFr4xpmkaj7krW/0zs496sCOlHfeChbMN2z8ETMh2mXK8NNmSjd2h4HN8WVO9ec4BuJNx3Ge7Nis6lViTwXKUZYs/hWXBUbv8sVPTfOfQbSzIC7zwJW3hfB7sJ9lFmYDB8wA4kv2q+ogiivzfM0LiZf8J5H3e9MBZzeCwM/gC1GF72lPAhaqKhsp0liYbmyFwaWPA6St+KfONWoHh8bIYrNIn7EGES3EIkvyPKGcNtDBEyEU1gHTxoMx0XT1UWwiuweUruSS7XgWpY8KM5y+ZXqREYkYcXTixVdeUV2HB490jIWOFm1UAtjNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSy+nSF5+UPGN4hAc/0S2di30RB4Wbxiy73Ctvg3vIg=;
 b=RvnFxWrlSmikxkj73miILyu1FxU/XvBFPWIJg3vnM1Q0YsHAwivsPdGScjucZLXUG4S/U2Q3MtwdWau0dvUhxOfeCWc3wjc4vb1DLHC4MsKdUQ37OtjR9dqsdGmofBiunY7ekvLFLnA2tX/5TkuOlyYPWR339p/P0bARtlhDZmAuL7XYzpLbRNEf1UykEpAGS4MHyJsfUpdUfjdLYnx9A6b26Lrw2sT02ZHg+jLLAtKoQRIWQQQqj+LnA+NSIs38vvFhEWraUY8MYERSWMzY4x5ivcGdmOqz5wjpgY99gNu84m3yTFHTlXh+9cOKCUhoOobIdMczX6DdTa7swJaHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSy+nSF5+UPGN4hAc/0S2di30RB4Wbxiy73Ctvg3vIg=;
 b=ijOQUgBVa4rTeNzAzWi5NsRxIY5jJf/SQhwW1T8tExTiNd+j7Sh5MnemRrtxe4dLtDavD/IcU2fAdE7qtf7TSS64/nMq8YvV1MZyrHudsj5cu/1hRuqTidyyklF3j3julKTIvTZfDxB+ZBzbaXPCJkqkA1yw1LGfO0diAfPnspQKS5WoKU6n/M0SdFFA2Z2meZ7nf8CboG1AZ0uPWQnNEO4kQhhoqsjtTEwt+40Kf/mCERtRR2wGzlvsyepdyDa870HCG9CKvywBWVd2TpFs8ZBFu7JiEZxa6t4f+hq4Oft4GAV2xW26O7GZgPKF+TOnsQcn8rIhaRUSeYSPZnadug==
Received: from BN6PR19CA0053.namprd19.prod.outlook.com (2603:10b6:404:e3::15)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 00:34:29 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::10) by BN6PR19CA0053.outlook.office365.com
 (2603:10b6:404:e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 00:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 00:34:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 00:34:27 +0000
Received: from [172.17.173.69] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 7 Dec 2021
 16:34:25 -0800
Subject: Re: [RFC v3 02/12] drivers: Add hardware timestamp engine (HTE)
To:     Kent Gibson <warthog618@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-3-dipenp@nvidia.com> <20211126013041.GA10380@sol>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
Message-ID: <246d1ff4-ec51-b4bf-a664-4559c45021fb@nvidia.com>
Date:   Tue, 7 Dec 2021 16:36:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126013041.GA10380@sol>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfa5be69-f916-40cc-bed6-08d9b9e27f4c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44082473F490DD77F5F858CCAE6F9@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsMjWF4Z0rHBuwt4JlOCnnxAp2yT9sWl9ZwIVsaTKYvAJQ5BCBuJRUTAN7c/JcwrPIQl7WTc4LzJbra3HFwIqbhtpddf453Q2SZGMq1WC1EiZnT8PG8WSNwiMZ9RWckswZ5gG5oMKnCRchi1FPPphYlZttYrkQJLkvRuC4wSkthmAFWwJniRR4A+JJcwCSzTINCYtpLl364mOO47P3Z4+Ldgj292TsvG4uhnmy5EXgG3TPawW8ny9+rWd22iojjK62ek3O73IbjMpwqbyF21eIzK6aqdP4vDGAxr12X+qlNGh6F+JFJVQjDMCQo0Shdf4w6z3XRVf3LC09+SGPaQPnybcnW0y/cTpu5mh4mLpmJTWs9J/2118K7RU48Rmr9ajS2YHnFy6H2e7LEOlUC67UYvNVhUBrDgt+Xde4jmUPvOGrqnrVR9VVkUmPQavtET3zNuzjk3gC7t++EOGxET2ZNf8Kcj5WevbfHIstq1jWYdNUxFXLkfFvLk0THhwNW8jAjfBn2/usBdf+chmAtbQQVFcysxN2kGURZ3wwtEP9hLjbo0QnMbZiR+ZOz00uwvOr9K/ZPZ8RKSw5CXUrnRYOkHKNa0PEpAMZ6IM2hCcjPlsAYR2wBHqx2AAbN32pBaSBOtFQqZ8tM0uX9PR/llio4VhHz2VXXWaDB0X+kVAqurbnyTYt9BliT/eSlZLwC54Qu0/30YhrQI6N2jAOjH+8ODlKUg0wm0ggJYqV1MvQFHF7IPK+8srjADTw+eceN6jCq3wzqWDPfG0CTTtcqc+J9rgVwZff1GP56BM/R33KgW6ThXP7/09DMGiyH2EeDrXHHxsGXp5k2YxBBf1x4s2g==
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(5660300002)(30864003)(4326008)(356005)(31696002)(7416002)(47076005)(82310400004)(40460700001)(86362001)(8936002)(8676002)(31686004)(34020700004)(70206006)(36756003)(6666004)(508600001)(2616005)(53546011)(426003)(7636003)(54906003)(6916009)(336012)(16576012)(70586007)(83380400001)(186003)(16526019)(2906002)(26005)(316002)(43740500002)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 00:34:29.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa5be69-f916-40cc-bed6-08d9b9e27f4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/25/21 5:30 PM, Kent Gibson wrote:
> On Tue, Nov 23, 2021 at 11:30:29AM -0800, Dipen Patel wrote:
>> Some devices can timestamp system lines/signals/Buses in real-time
>> using the hardware counter or other hardware means which can give
>> finer granularity and help avoid jitter introduced by software
>> timestamping. To utilize such functionality, this patchset creates
>> HTE subsystem where devices can register themselves as providers so
>> that the consumers devices can request specific line from the
>> providers.
>>
>> It provides below APIs for the provider:
>> - devm_hte_register_chip -- To register the HTE provider.
>> - hte_push_ts_ns() -- To push timestamp data into HTE subsystem.
>>
>> It provides below APIs for the consumer:
>> - devm_of_hte_request_ts() -- Request timestamp functionality.
>> - hte_req_ts_by_hte_name() -- To request timestamp functionality by
>> using HTE provider dt node.
>> - hte_enable_ts() -- To disable timestamp functionality.
>> - hte_disable_ts() -- To enable timestamp functionality.
>> - hte_release_ts() -- To release timestamp functionality and its
>> associated resources.
>> - hte_get_clk_src_info() -- To query clock source information from
>> the provider
>>
>> The detail about parameters and API usage are described in each
>> functions definitions in drivers/hte/hte.c file.
>>
>> The patch adds compilation support in Makefile and menu options in
>> Kconfig.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> Changes in v2:
>> - Removed buffer abstraction layer as well related APIs, HTE now will not store
>> any data, instead will pass to consumer as soon as it is available.
>> - Removed unnecessary dynamical allocations
>> - Removed timestamp retrieve API
>> - Removed release, unregister related APIs as their counterpart are resource
>> managed.
>> - Added kernel thread implementation if consumer indicates threaded callback
>> during request API time.
>> - Changed hte_req_ts_by_dt_node API to remove device node exposure from the
>> interface, instead consumer will their device node with property name that
>> indicates the provider it wants to use.
>>
>> Changes in v3:
>> - Addressed grammatical/spelling errors.
>>
>>  drivers/Kconfig      |   2 +
>>  drivers/Makefile     |   1 +
>>  drivers/hte/Kconfig  |  22 ++
>>  drivers/hte/Makefile |   2 +
>>  drivers/hte/hte.c    | 907 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/hte.h  | 248 ++++++++++++
>>  6 files changed, 1182 insertions(+)
>>  create mode 100644 drivers/hte/Kconfig
>>  create mode 100644 drivers/hte/Makefile
>>  create mode 100644 drivers/hte/hte.c
>>  create mode 100644 include/linux/hte.h
>>
>> diff --git a/drivers/Kconfig b/drivers/Kconfig
>> index 0d399ddaa185..b3c8332bf5c7 100644
>> --- a/drivers/Kconfig
>> +++ b/drivers/Kconfig
>> @@ -236,4 +236,6 @@ source "drivers/interconnect/Kconfig"
>>  source "drivers/counter/Kconfig"
>>  
>>  source "drivers/most/Kconfig"
>> +
>> +source "drivers/hte/Kconfig"
>>  endmenu
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index be5d40ae1488..087c08e846e6 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -188,3 +188,4 @@ obj-$(CONFIG_GNSS)		+= gnss/
>>  obj-$(CONFIG_INTERCONNECT)	+= interconnect/
>>  obj-$(CONFIG_COUNTER)		+= counter/
>>  obj-$(CONFIG_MOST)		+= most/
>> +obj-$(CONFIG_HTE)		+= hte/
>> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
>> new file mode 100644
>> index 000000000000..1fcfe17cf28a
>> --- /dev/null
>> +++ b/drivers/hte/Kconfig
>> @@ -0,0 +1,22 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menuconfig HTE
>> +	bool "Hardware Timestamping Engine (HTE) Support"
>> +	help
>> +	  Hardware Timestamping Engine (HTE) Support.
>> +
>> +	  Some devices provide a hardware timestamping engine which can
>> +	  timestamp certain device lines/signals in realtime. This provides a
>> +	  hardware-assisted timestamp to generic signals like GPIOs or IRQs
>> +	  lines. It comes with a benefit for applications like autonomous
>> +	  machines needing accurate timestamping event with less jitter.
>> +
>> +	  This framework provides a generic interface to such HTE devices
>> +	  within the Linux kernel. It provides an API to register and
>> +	  unregister a HTE provider chip, configurable software buffer to
>> +	  store the timestamps, push the timestamp from the HTE providers and
>> +	  retrieve timestamps for the consumers. It also provides means for the
>> +	  consumers to request signals it wishes to hardware timestamp and
>> +	  release them if not required.
>> +
>> +	  If unsure, say no.
>> +
>> diff --git a/drivers/hte/Makefile b/drivers/hte/Makefile
>> new file mode 100644
>> index 000000000000..fc03bdf44427
>> --- /dev/null
>> +++ b/drivers/hte/Makefile
>> @@ -0,0 +1,2 @@
>> +obj-$(CONFIG_HTE)		+= hte.o
>> +
>> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
>> new file mode 100644
>> index 000000000000..ca91d48f48b9
>> --- /dev/null
>> +++ b/drivers/hte/hte.c
>> @@ -0,0 +1,907 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2021 NVIDIA Corporation
>> + *
>> + * Author: Dipen Patel <dipenp@nvidia.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/err.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mutex.h>
>> +#include <linux/sched.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/hte.h>
>> +#include <linux/delay.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/kthread.h>
>> +
>> +#define HTE_TS_NAME_LEN		10
>> +
>> +/* Global list of the HTE devices */
>> +static DEFINE_SPINLOCK(hte_lock);
>> +static LIST_HEAD(hte_devices);
>> +
>> +enum {
>> +	HTE_TS_REGISTERED,
>> +	HTE_TS_DISABLE,
>> +};
>> +
>> +enum {
>> +	HTE_CB_RUN_THREAD,
>> +	HTE_CB_NUM,
>> +};
>> +
>> +/**
>> + * struct hte_ts_info - Information related to requested timestamp.
>> + *
>> + * @xlated_id: Timestamp ID as understood between HTE subsys and HTE provider,
>> + * See xlate callback API.
>> + * @flags: Flags holding state informations.
>> + * @hte_cb_flags: Callback related flags.
>> + * @seq: Timestamp sequence counter.
>> + * @hte_name: Indicates if HTE core has set name for this timestamp entity.
>> + * @cb: Callback function provided by clients.
>> + * @tcb: Threaded callback function provided by clients.
>> + * @dropped_ts: Dropped timestamps.
>> + * @slock: Spin lock.
>> + * @thread: Thread task when tcb is provided.
>> + * @req_mlock: Lock during timestamp request/release APIs.
>> + * @ts_dbg_root: Root for the debug fs.
>> + * @gdev: HTE abstract device that this timestamp belongs to.
>> + * @cl_data: Client specific data.
>> + */
>> +struct hte_ts_info {
>> +	u32 xlated_id;
>> +	unsigned long flags;
>> +	unsigned long hte_cb_flags;
>> +	u64 seq;
>> +	bool hte_name;
>> +	hte_ts_cb_t cb;
>> +	hte_ts_threaded_cb_t tcb;
>> +	atomic_t dropped_ts;
>> +	spinlock_t slock;
>> +	struct task_struct *thread;
>> +	struct mutex req_mlock;
>> +	struct dentry *ts_dbg_root;
>> +	struct hte_device *gdev;
>> +	void *cl_data;
>> +};
>> +
>> +/**
>> + * struct hte_device - HTE abstract device
>> + * @nlines: Number of entities this device supports.
>> + * @ts_req: Total number of entities requested.
>> + * @sdev: Device used at various debug prints.
>> + * @dbg_root: Root directory for debug fs.
>> + * @list: List node to store hte_device for each provider.
>> + * @chip: HTE chip providing this HTE device.
>> + * @owner: helps prevent removal of modules when in use.
>> + * @ei: Timestamp information.
>> + */
>> +struct hte_device {
>> +	u32 nlines;
>> +	atomic_t ts_req;
>> +	struct device *sdev;
>> +	struct dentry *dbg_root;
>> +	struct list_head list;
>> +	struct hte_chip *chip;
>> +	struct module *owner;
>> +	struct hte_ts_info ei[];
>> +};
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +static struct dentry *hte_root;
>> +
>> +static int __init hte_subsys_dbgfs_init(void)
>> +{
>> +	/* creates /sys/kernel/debug/hte/ */
>> +	hte_root = debugfs_create_dir("hte", NULL);
>> +
>> +	return 0;
>> +}
>> +subsys_initcall(hte_subsys_dbgfs_init);
>> +
>> +static void hte_chip_dbgfs_init(struct hte_device *gdev)
>> +{
>> +	const struct hte_chip *chip = gdev->chip;
>> +	const char *name = chip->name ? chip->name : dev_name(chip->dev);
>> +
>> +	gdev->dbg_root = debugfs_create_dir(name, hte_root);
>> +
>> +	debugfs_create_atomic_t("ts_requested", 0444, gdev->dbg_root,
>> +				&gdev->ts_req);
>> +	debugfs_create_u32("total_ts", 0444, gdev->dbg_root,
>> +			   &gdev->nlines);
>> +}
>> +
>> +static void hte_ts_dbgfs_init(const char *name, struct hte_ts_info *ei)
>> +{
>> +	if (!ei->gdev->dbg_root || !name)
>> +		return;
>> +
>> +	ei->ts_dbg_root = debugfs_create_dir(name, ei->gdev->dbg_root);
>> +
>> +	debugfs_create_atomic_t("dropped_timestamps", 0444, ei->ts_dbg_root,
>> +				&ei->dropped_ts);
>> +}
>> +
>> +#else
>> +
>> +static void hte_chip_dbgfs_init(struct hte_device *gdev)
>> +{
>> +}
>> +
>> +static void hte_ts_dbgfs_init(const char *name, struct hte_ts_info *ei)
>> +{
>> +}
>> +
>> +#endif
>> +
>> +/**
>> + * hte_release_ts() - Consumer calls this API to release the entity, where
>> + * entity could be anything providers support, like lines, signals, buses,
>> + * etc...
>> + *
>> + * @desc: timestamp descriptor, this is the same as returned by the request API.
>> + *
>> + * Context: debugfs_remove_recursive() function call may use sleeping locks,
>> + *	    not suitable from atomic context.
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int hte_release_ts(struct hte_ts_desc *desc)
>> +{
>> +	u32 id;
>> +	int ret = 0;
>> +	unsigned long flag;
>> +	struct hte_device *gdev;
>> +	struct hte_ts_info *ei;
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	ei = desc->hte_data;
>> +
>> +	if (!ei || !ei->gdev)
>> +		return -EINVAL;
>> +
>> +	gdev = ei->gdev;
>> +	id = desc->con_id;
>> +
>> +	mutex_lock(&ei->req_mlock);
>> +
>> +	if (!test_bit(HTE_TS_REGISTERED, &ei->flags)) {
>> +		dev_info(gdev->sdev, "id:%d is not registered", id);
>> +		ret = -EUSERS;
>> +		goto unlock;
>> +	}
>> +
>> +	ret = gdev->chip->ops->release(gdev->chip, ei->xlated_id);
>> +	if (ret) {
>> +		dev_err(gdev->sdev, "id: %d free failed\n", id);
>> +		goto unlock;
>> +	}
>> +
>> +	if (ei->hte_name)
>> +		kfree(desc->name);
>> +
>> +	debugfs_remove_recursive(ei->ts_dbg_root);
>> +
>> +	spin_lock_irqsave(&ei->slock, flag);
>> +
>> +	atomic_dec(&gdev->ts_req);
>> +	atomic_set(&ei->dropped_ts, 0);
>> +
>> +	ei->seq = 0;
>> +	desc->hte_data = NULL;
>> +
>> +	clear_bit(HTE_TS_REGISTERED, &ei->flags);
>> +
>> +	spin_unlock_irqrestore(&ei->slock, flag);
>> +
>> +	if (ei->tcb) {
>> +		kthread_stop(ei->thread);
>> +		put_task_struct(ei->thread);
>> +	}
>> +
>> +	ei->cb = NULL;
>> +	ei->tcb = NULL;
>> +	ei->thread = NULL;
>> +	ei->cl_data = NULL;
>> +
>> +	module_put(gdev->owner);
>> +unlock:
>> +	mutex_unlock(&ei->req_mlock);
>> +	dev_dbg(gdev->sdev, "release id: %d\n", id);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(hte_release_ts);
>> +
>> +static int hte_ts_dis_en_common(struct hte_ts_desc *desc, bool en)
>> +{
>> +	u32 ts_id;
>> +	struct hte_device *gdev;
>> +	struct hte_ts_info *ei;
>> +	int ret;
>> +	unsigned long flag;
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	ei = desc->hte_data;
>> +
>> +	if (!ei || !ei->gdev)
>> +		return -EINVAL;
>> +
>> +	gdev = ei->gdev;
>> +	ts_id = desc->con_id;
>> +
>> +	mutex_lock(&ei->req_mlock);
>> +
>> +	if (!test_bit(HTE_TS_REGISTERED, &ei->flags)) {
>> +		dev_dbg(gdev->sdev, "id:%d is not registered", ts_id);
>> +		ret = -EUSERS;
>> +		goto out;
>> +	}
>> +
>> +	spin_lock_irqsave(&ei->slock, flag);
>> +
>> +	if (en) {
>> +		if (!test_bit(HTE_TS_DISABLE, &ei->flags)) {
>> +			ret = 0;
>> +			goto out_unlock;
>> +		}
>> +
>> +		spin_unlock_irqrestore(&ei->slock, flag);
>> +		ret = gdev->chip->ops->enable(gdev->chip, ei->xlated_id);
>> +		if (ret) {
>> +			dev_warn(gdev->sdev, "id: %d enable failed\n",
>> +				 ts_id);
>> +			goto out;
>> +		}
>> +
>> +		spin_lock_irqsave(&ei->slock, flag);
>> +		clear_bit(HTE_TS_DISABLE, &ei->flags);
>> +	} else {
>> +		if (test_bit(HTE_TS_DISABLE, &ei->flags)) {
>> +			ret = 0;
>> +			goto out_unlock;
>> +		}
>> +
>> +		spin_unlock_irqrestore(&ei->slock, flag);
>> +		ret = gdev->chip->ops->disable(gdev->chip, ei->xlated_id);
>> +		if (ret) {
>> +			dev_warn(gdev->sdev, "id: %d disable failed\n",
>> +				 ts_id);
>> +			goto out;
>> +		}
>> +
>> +		spin_lock_irqsave(&ei->slock, flag);
>> +		set_bit(HTE_TS_DISABLE, &ei->flags);
>> +	}
>> +
>> +out_unlock:
>> +	spin_unlock_irqrestore(&ei->slock, flag);
>> +out:
>> +	mutex_unlock(&ei->req_mlock);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * hte_disable_ts() - Disable timestamp on given descriptor.
>> + *
>> + * The API does not release any resources associated with desc.
>> + *
>> + * @desc: ts descriptor, this is the same as returned by the request API.
>> + *
>> + * Context: Holds mutex lock, not suitable from atomic context.
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int hte_disable_ts(struct hte_ts_desc *desc)
>> +{
>> +	return hte_ts_dis_en_common(desc, false);
>> +}
>> +EXPORT_SYMBOL_GPL(hte_disable_ts);
>> +
>> +/**
>> + * hte_enable_ts() - Enable timestamp on given descriptor.
>> + *
>> + * @desc: ts descriptor, this is the same as returned by the request API.
>> + *
>> + * Context: Holds mutex lock, not suitable from atomic context.
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int hte_enable_ts(struct hte_ts_desc *desc)
>> +{
>> +	return hte_ts_dis_en_common(desc, true);
>> +}
>> +EXPORT_SYMBOL_GPL(hte_enable_ts);
>> +
>> +static int hte_simple_xlate(struct hte_chip *gc,
>> +			    const struct of_phandle_args *args,
>> +			    struct hte_ts_desc *desc,
>> +			    u32 *id)
>> +{
>> +	if (!id || !desc || !gc)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * For the providers which do not have any internal mappings between
>> +	 * logically exposed ids and actual ids, will set both
>> +	 * the same.
>> +	 *
>> +	 * In case there is a internal mapping needed, providers will need to
>> +	 * provide its own xlate function where con_id will be sent as
>> +	 * args[0] and it will return xlated id. Later xlated id will be
>> +	 * used for any future exchanges between provider and subsystems.
>> +	 */
>> +
>> +	if (args) {
>> +		if (gc->of_hte_n_cells < 1)
>> +			return -EINVAL;
>> +
>> +		if (args->args_count != gc->of_hte_n_cells)
>> +			return -EINVAL;
>> +
>> +		*id = args->args[0];
>> +		desc->con_id = *id;
>> +	} else {
>> +		*id = desc->con_id;
>> +	}
>> +
>> +	if (desc->con_id > gc->nlines)
>> +		return -EINVAL;
>> +
>> +	desc->hte_data = NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int _hte_wait_for_ts_data(struct hte_ts_info *ei)
>> +{
>> +	for (;;) {
>> +		set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +		if (kthread_should_stop()) {
>> +			if (test_and_clear_bit(HTE_CB_RUN_THREAD,
>> +			    &ei->hte_cb_flags)) {
>> +				__set_current_state(TASK_RUNNING);
>> +				return 0;
>> +			}
>> +			__set_current_state(TASK_RUNNING);
>> +			return -1;
>> +		}
>> +
>> +		if (test_and_clear_bit(HTE_CB_RUN_THREAD,
>> +				       &ei->hte_cb_flags)) {
>> +			__set_current_state(TASK_RUNNING);
>> +			return 0;
>> +		}
>> +		schedule();
>> +	}
>> +}
>> +
>> +static int _hte_threadfn(void *data)
>> +{
>> +	struct hte_ts_info *ei = data;
>> +
>> +	while (!_hte_wait_for_ts_data(ei))
>> +		ei->tcb(ei->cl_data);
>> +
>> +	return 0;
>> +}
>> +
>> +static int _hte_setup_thread(struct hte_ts_info *ei, u32 id)
>> +{
>> +	struct task_struct *t;
>> +
>> +	t = kthread_create(_hte_threadfn, ei, "hte-%u", id);
>> +	if (IS_ERR(t))
>> +		return PTR_ERR(t);
>> +
>> +	ei->thread = get_task_struct(t);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ___hte_req_ts(struct hte_device *gdev, struct hte_ts_desc *desc,
>> +			 u32 xlated_id, hte_ts_cb_t cb,
>> +			 hte_ts_threaded_cb_t tcb, void *data)
>> +{
>> +	struct hte_ts_info *ei;
>> +	int ret;
>> +	u32 con_id = desc->con_id;
>> +
>> +	if (!try_module_get(gdev->owner))
>> +		return -ENODEV;
>> +
>> +	ei = &gdev->ei[xlated_id];
>> +	ei->xlated_id = xlated_id;
>> +
>> +	/*
>> +	 * There is a chance that multiple consumers requesting same entity,
>> +	 * lock here.
>> +	 */
>> +	mutex_lock(&ei->req_mlock);
>> +
>> +	if (test_bit(HTE_TS_REGISTERED, &ei->flags)) {
>> +		dev_dbg(gdev->chip->dev, "id:%u is already registered",
>> +			xlated_id);
>> +		ret = -EUSERS;
>> +		goto unlock;
>> +	}
>> +
>> +	ei->cb = cb;
>> +	ei->tcb = tcb;
>> +	if (tcb) {
>> +		ret = _hte_setup_thread(ei, xlated_id);
>> +		if (ret < 0) {
>> +			dev_err(gdev->chip->dev, "setting thread failed\n");
>> +			goto unlock;
>> +		}
>> +	}
>> +
>> +	ret = gdev->chip->ops->request(gdev->chip, xlated_id);
>> +	if (ret < 0) {
>> +		dev_err(gdev->chip->dev, "ts request failed\n");
>> +		goto unlock;
>> +	}
>> +
>> +	desc->hte_data = ei;
>> +	ei->cl_data = data;
>> +
>> +	atomic_inc(&gdev->ts_req);
>> +
>> +	ei->hte_name = false;
>> +	if (!desc->name) {
>> +		desc->name = kzalloc(HTE_TS_NAME_LEN, GFP_KERNEL);
>> +		if (desc->name) {
>> +			scnprintf(desc->name, HTE_TS_NAME_LEN, "ts_%u",
>> +				  con_id);
>> +			ei->hte_name = true;
>> +		}
>> +	}
>> +
>> +	hte_ts_dbgfs_init(desc->name, ei);
>> +	set_bit(HTE_TS_REGISTERED, &ei->flags);
>> +
>> +	mutex_unlock(&ei->req_mlock);
>> +
>> +	dev_dbg(gdev->chip->dev, "id: %u, xlated id:%u", con_id, xlated_id);
>> +
>> +	return 0;
>> +
>> +unlock:
>> +	module_put(gdev->owner);
>> +	mutex_unlock(&ei->req_mlock);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct hte_device *of_node_to_htedevice(struct device_node *np)
>> +{
>> +	struct hte_device *gdev;
>> +
>> +	spin_lock(&hte_lock);
>> +
>> +	list_for_each_entry(gdev, &hte_devices, list)
>> +		if (gdev->chip && gdev->chip->dev &&
>> +		    gdev->chip->dev->of_node == np) {
>> +			spin_unlock(&hte_lock);
>> +			return gdev;
>> +		}
>> +
>> +	spin_unlock(&hte_lock);
>> +
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static struct hte_device *of_hte_dev_get(struct device *dev,
>> +					 struct device_node *np,
>> +					 const char *label,
>> +					 struct of_phandle_args *args)
>> +{
>> +	struct hte_device *gdev = NULL;
>> +	int index = 0;
>> +	int err;
>> +
>> +	if (label) {
>> +		index = of_property_match_string(np,
>> +						 "hardware-timestamp-names",
>> +						 label);
>> +		if (index < 0)
>> +			return ERR_PTR(index);
>> +	}
>> +
>> +	err = of_parse_phandle_with_args(np, "hardware-timestamps",
>> +					 "#hardware-timestamp-cells", index,
>> +					 args);
>> +	if (err) {
>> +		pr_err("%s(): can't parse \"hardware-timestamps\" property\n",
>> +		       __func__);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	gdev = of_node_to_htedevice(args->np);
>> +	if (IS_ERR(gdev)) {
>> +		pr_err("%s(): HTE chip not found\n", __func__);
>> +		of_node_put(args->np);
>> +		return gdev;
>> +	}
>> +
>> +	return gdev;
>> +}
>> +
>> +static int __hte_req_ts(struct device *dev, struct hte_ts_desc *desc,
>> +			hte_ts_cb_t cb, hte_ts_threaded_cb_t tcb, void *data)
>> +{
>> +	struct hte_device *gdev = NULL;
>> +	struct of_phandle_args args;
>> +	int ret;
>> +	u32 xlated_id;
>> +
>> +	gdev = of_hte_dev_get(dev, dev->of_node, desc->name, &args);
>> +	if (IS_ERR(gdev))
>> +		return PTR_ERR(gdev);
>> +
>> +	if (!gdev->chip) {
>> +		pr_debug("requested id does not have provider\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = gdev->chip->xlate(gdev->chip, &args, desc, &xlated_id);
>> +	if (ret < 0)
>> +		goto put;
>> +
>> +	ret = ___hte_req_ts(gdev, desc, xlated_id, cb, tcb, data);
>> +	if (ret < 0)
>> +		goto put;
>> +
>> +	return 0;
>> +
>> +put:
>> +	of_node_put(args.np);
>> +
>> +	return ret;
>> +}
>> +
>> +static void __devm_hte_release_ts(void *res)
>> +{
>> +	hte_release_ts(res);
>> +}
>> +
>> +/**
>> + * devm_of_hte_request_ts() - Resource managed API to request the HTE facility
>> + * on the specified entity, where entity is provider specific for example,
>> + * GPIO lines, signals, buses etc...
>> + *
>> + * The API allocates necessary resources and enables the timestamp. So calling
>> + * hte_enable_ts is not needed. The consumer does not need to call
>> + * hte_release_ts since it will be called upon consumer exit.
>> + *
>> + * @dev: HTE consumer/client device.
>> + * @desc: Pre-allocated timestamp descriptor. HTE core will fill out necessary
>> + * details. Optionally the consumer can set name field of desc, if not
>> + * specified HTE core will set it as ts_con_id. It will be the consumer's
>> + * job to free any allocation related to this structure as well name field
>> + * in case it has set that field.
>> + * @cb: Callback to push the timestamp data to consumer.
>> + * @tcb: Optional callback. If its provided, subsystem will create
>> + * thread. This will be called when cb returns HTE_RUN_THREADED_CB.
>> + * @data: Client data, will be sent back during cb and tcb callbacks.
>> + *
>> + * Context: Holds mutex lock.
>> + * Returns: Returns 0 on success or negative error code on failure.
>> + */
>> +int devm_of_hte_request_ts(struct device *dev, struct hte_ts_desc *desc,
>> +			   hte_ts_cb_t cb, hte_ts_threaded_cb_t tcb,
>> +			   void *data)
>> +{
>> +	int err;
>> +
>> +	if (!dev || !dev->of_node || !desc || !cb)
>> +		return -EINVAL;
>> +
>> +	err = __hte_req_ts(dev, desc, cb, tcb, data);
>> +	if (err)
>> +		return err;
>> +
>> +	err = devm_add_action_or_reset(dev, __devm_hte_release_ts, desc);
>> +	if (err)
>> +		return err;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_of_hte_request_ts);
>> +
>> +/**
>> + * hte_req_ts_by_hte_name() - Request entity to timestamp realtime by passing
>> + * property name that contains HTE provider phandle, meaning of the entity
>> + * is HTE provider specific, for example lines, signals, GPIOs, buses etc...
>> + *
>> + * This API is designed to address below uses cases:
>> + *
>> + * 1) For the consumer device which acts as a central device for secondary
>> + * consumers. For example, GPIO controller driver acts as a primary consumer
>> + * on behalf of in kernel and userspace GPIO HTE consumers. The GPIO controller
>> + * driver specifies HTE provider that it supports/wants and it becomes opaque
>> + * for the secondary consumers requesting GPIO and hardware timestamp through
>> + * that GPIO controller.
>> + *
>> + * 2) For the providers which are dependent on other hardware modules. In that
>> + * case it forces consumers to go through other subsystem or driver making them
>> + * secondary consumers. Same example as above applies here as well.
>> + *
>> + * The API allocates necessary resources and enables the timestamp. So calling
>> + * hte_enable_ts is not needed.
>> + *
>> + * @dev: HTE consumer/client device.
>> + * @propname: Name of property holding a HTE provider phandle value
>> + * @desc: Pre-allocated timestamp descriptor with con_id set by the consumer.
>> + * HTE core will fill out the rest. Optionally the consumer can set name
>> + * field of desc, if not specified HTE core will set it as ts_con_id. It will
>> + * be the consumer's job to free any allocation related to this structure as
>> + * well name field in case it has set that field.
>> + * @cb: Callback to push the timestamp data to consumer.
>> + * @tcb: Optional callback. If its provided, subsystem will create
>> + * thread. This will be called when cb returns HTE_RUN_THREADED_CB.
>> + * @data: Client data, will be sent back during cb and tcb callbacks.
>> + *
>> + * Context: Holds mutex lock, can not be called from atomic context. The mutex
>> + * lock is used to serialize multiple consumers.
>> + * Returns: returns 0 on success or negative error code on failure.
>> + */
>> +int hte_req_ts_by_hte_name(struct device *dev, const char *propname,
>> +			   struct hte_ts_desc *desc, hte_ts_cb_t cb,
>> +			   hte_ts_threaded_cb_t tcb, void *data)
>> +{
>> +	struct hte_device *gdev;
>> +	struct device_node *np = NULL;
>> +	int ret;
>> +	u32 xlated_id;
>> +
>> +	if (!dev->of_node || !propname || !desc)
>> +		return -EINVAL;
>> +
>> +	np = of_parse_phandle(dev->of_node, propname, 0);
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	of_node_put(np);
>> +
>> +	gdev = of_node_to_htedevice(np);
>> +	if (IS_ERR(gdev))
>> +		return -ENOTSUPP;
>> +
>> +	if (!gdev->chip || !gdev->chip->ops)
>> +		return -ENOTSUPP;
>> +
>> +	ret = gdev->chip->xlate(gdev->chip, NULL, desc, &xlated_id);
>> +	if (ret < 0) {
>> +		dev_err(gdev->chip->dev,
>> +			"failed to xlate id: %d\n", desc->con_id);
>> +		return ret;
>> +	}
>> +
>> +	ret = ___hte_req_ts(gdev, desc, xlated_id, cb, tcb, data);
>> +	if (ret < 0) {
>> +		dev_err(gdev->chip->dev,
>> +			"failed to request id: %d\n", desc->con_id);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(hte_req_ts_by_hte_name);
>> +
>> +/**
>> + * hte_get_clk_src_info() - Consumer calls this API to query clock source
>> + * information of the desc.
>> + *
>                                ^^^^^^^^^^
> Get the clock source information for a ts descriptor.
>
>> + * @desc: ts descriptor, same as returned from request API.
>> + * @ci: The API fills this structure with the clock information data.
>> + *
>> + * Context: Any context.
>> + * Returns: 0 on success else negative error code on failure.
>> + */
>> +int hte_get_clk_src_info(const struct hte_ts_desc *desc,
>> +			 struct hte_clk_info *ci)
>> +{
>> +	struct hte_chip *chip;
>> +	struct hte_ts_info *ei;
>> +
>> +	if (!desc || !desc->hte_data || !ci) {
>> +		pr_debug("%s:%d\n", __func__, __LINE__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ei = desc->hte_data;
>> +	if (!ei || !ei->gdev || !ei->gdev->chip)
>> +		return -EINVAL;
>> +
>> +	chip = ei->gdev->chip;
>> +	if (!chip->ops->get_clk_src_info)
>> +		return -ENOTSUPP;
>> +
>> +	return chip->ops->get_clk_src_info(chip, ci);
>> +}
>> +EXPORT_SYMBOL_GPL(hte_get_clk_src_info);
>> +
>> +/**
>> + * hte_push_ts_ns() - Used by the provider to push timestamp in nano
>> + * seconds i.e data->tsc will be in ns.
>> + *
>                          ^^^^^^^^
> Push timestamp in nanoseconds.
>
>> + * @chip: The HTE chip, used during the registration.
>> + * @xlated_id: entity id understood by both subsystem and provider, usually this
>> + * is obtained from xlate callback during request API.
>> + * @data: timestamp data.
>> + *
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
>> +		   struct hte_ts_data *data)
>> +{
>> +	hte_return_t ret;
>> +	int st = 0;
>> +	struct hte_ts_info *ei;
>> +	unsigned long flag;
>> +
>> +	if (!chip || !data || !chip->gdev)
>> +		return -EINVAL;
>> +
>> +	if (xlated_id > chip->nlines)
>> +		return -EINVAL;
>> +
>> +	ei = &chip->gdev->ei[xlated_id];
>> +
>> +	spin_lock_irqsave(&ei->slock, flag);
>> +
>> +	/* timestamp sequence counter */
>> +	data->seq = ei->seq++;
>> +
>> +	if (!test_bit(HTE_TS_REGISTERED, &ei->flags) ||
>> +	    test_bit(HTE_TS_DISABLE, &ei->flags)) {
>> +		dev_dbg(chip->dev, "Unknown timestamp push\n");
>> +		st = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	ret = ei->cb(data, ei->cl_data);
>> +	if (ret == HTE_RUN_THREADED_CB && ei->thread) {
>> +		if (test_and_set_bit(HTE_CB_RUN_THREAD, &ei->hte_cb_flags))
>> +			goto unlock;
>> +		else
>> +			wake_up_process(ei->thread);
>> +	} else if (ret == HTE_CB_TS_DROPPED) {
>> +		atomic_inc(&ei->dropped_ts);
>> +	} else if (ret == HTE_CB_ERROR) {
>> +		dev_dbg(chip->dev, "cb error\n");
>> +	}
>> +
>> +unlock:
>> +	spin_unlock_irqrestore(&ei->slock, flag);
>> +
>> +	return st;
>> +}
>> +EXPORT_SYMBOL_GPL(hte_push_ts_ns);
>> +
>> +static int hte_register_chip(struct hte_chip *chip)
>> +{
>> +	struct hte_device *gdev;
>> +	u32 i;
>> +
>> +	if (!chip || !chip->dev || !chip->dev->of_node)
>> +		return -EINVAL;
>> +
>> +	if (!chip->ops || !chip->ops->request || !chip->ops->release) {
>> +		dev_err(chip->dev, "Driver needs to provide ops\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	gdev = kzalloc(struct_size(gdev, ei, chip->nlines), GFP_KERNEL);
>> +	if (!gdev)
>> +		return -ENOMEM;
>> +
>> +	gdev->chip = chip;
>> +	chip->gdev = gdev;
>> +	gdev->nlines = chip->nlines;
>> +	gdev->sdev = chip->dev;
>> +
>> +	for (i = 0; i < chip->nlines; i++) {
>> +		gdev->ei[i].gdev = gdev;
>> +		mutex_init(&gdev->ei[i].req_mlock);
>> +		spin_lock_init(&gdev->ei[i].slock);
>> +	}
>> +
>> +	if (chip->dev->driver)
>> +		gdev->owner = chip->dev->driver->owner;
>> +	else
>> +		gdev->owner = THIS_MODULE;
>> +
>> +	if (!chip->xlate) {
>> +		chip->xlate = hte_simple_xlate;
>> +		/* Just a id number to monitor */
>> +		chip->of_hte_n_cells = 1;
>> +	}
>> +
>> +	of_node_get(chip->dev->of_node);
>> +
>> +	INIT_LIST_HEAD(&gdev->list);
>> +
>> +	spin_lock(&hte_lock);
>> +	list_add_tail(&gdev->list, &hte_devices);
>> +	spin_unlock(&hte_lock);
>> +
>> +	hte_chip_dbgfs_init(gdev);
>> +
>> +	dev_dbg(chip->dev, "Added hte chip\n");
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * hte_unregister_chip() - Used by the provider to remove a HTE chip.
>> + * @chip: the HTE chip to remove.
>> + *
>> + * Context: Can not be called from atomic context.
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +static int hte_unregister_chip(struct hte_chip *chip)
>> +{
>> +	struct hte_device *gdev;
>> +
>> +	if (!chip)
>> +		return -EINVAL;
>> +
>> +	gdev = chip->gdev;
>> +
>> +	spin_lock(&hte_lock);
>> +	list_del(&gdev->list);
>> +	spin_unlock(&hte_lock);
>> +
>> +	gdev->chip = NULL;
>> +
>> +	of_node_put(chip->dev->of_node);
>> +	debugfs_remove_recursive(gdev->dbg_root);
>> +	kfree(gdev);
>> +
>> +	dev_dbg(chip->dev, "Removed hte chip\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static void _hte_devm_unregister_chip(void *chip)
>> +{
>> +	hte_unregister_chip(chip);
>> +}
>> +
>> +/**
>> + * devm_hte_register_chip() - Used by provider to register a HTE chip.
>> + * @chip: the HTE chip to add to subsystem.
>> + *
>> + * The API is resource managed and  _hte_devm_unregister_chip will be called
>> + * automatically when the provider exits.
>> + *
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int devm_hte_register_chip(struct hte_chip *chip)
>> +{
>> +	int err;
>> +
>> +	err = hte_register_chip(chip);
>> +	if (err)
>> +		return err;
>> +
>> +	err = devm_add_action_or_reset(chip->dev, _hte_devm_unregister_chip,
>> +				       chip);
>> +	if (err)
>> +		return err;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_hte_register_chip);
>> diff --git a/include/linux/hte.h b/include/linux/hte.h
>> new file mode 100644
>> index 000000000000..f4dd5415a493
>> --- /dev/null
>> +++ b/include/linux/hte.h
>> @@ -0,0 +1,248 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2021 NVIDIA Corporation
>> + *
>> + * Author: Dipen Patel <dipenp@nvidia.com>
>> + */
>> +
>> +#ifndef __LINUX_HTE_H
>> +#define __LINUX_HTE_H
>> +
>> +#include <linux/errno.h>
>> +
>> +struct hte_chip;
>> +struct hte_device;
>> +struct of_phandle_args;
>> +struct device_node;
>> +
>> +/**
>> + * enum hte_dir - HTE edge timestamp direction.
>> + *
>> + * @HTE_RISING_EDGE_TS: Timestamps is for rising edge.
>> + * @HTE_FALLING_EDGE_TS: Timestamps is for falling edge.
>> + * @HTE_DIR_NOSUPP: Direction is not supported.
>> + */
>> +enum hte_dir {
>> +	HTE_RISING_EDGE_TS,
>> +	HTE_FALLING_EDGE_TS,
>> +	HTE_DIR_NOSUPP,
>> +};
>> +
> Your tegra194 driver doesn't support direction - it always reports
> HTE_DIR_NOSUPP.  Do you have an example of hardware that does support
> direction?
No
>
> This might be better as a raw line level rather than an edge direction.
> See my related comments on patch 09.

We are discussing this on 09 patch, will follow up there should I need

clarifications if that is ok.

>
> And the third option should be "unknown", rather than "not supported" as
> this is a reading being returned, not a feature being requested.
> It may be unknown because the feature is not supported, but that is a
> separate issue.
>
>> +/**
>> + * struct hte_ts_data - HTE timestamp data.
>> + * The provider uses and fills timestamp related details during push_timestamp
>> + * API call. The consumer uses during retrieve_timestamp API call.
>> + *
> What push_timestamp() and retrieve_timestamp() calls?
>
> General comment:
> Documenting how a struct is used in an API, rather than what it is for or
> what it represents, is a maintenance nightmare.  If it is subsequently
> used elsewhere or names are changed then the user is now obliged to update
> your documentation.
> And they will forget to, or overlook it, as you yourself have done here.
>
> Descriptions of what the API calls do should be in the documentation of
> the API calls themselves, not the structs they use.
I agree, will correct in v4.
>
>> + * @tsc: Timestamp value.
>> + * @seq: Sequence counter of the timestamps.
>> + * @dir: Direction of the event at the time of timestamp.
>> + */
>> +struct hte_ts_data {
>> +	u64 tsc;
>> +	u64 seq;
>> +	enum hte_dir dir;
>> +};
>> +
>> +/**
>> + * struct hte_clk_info - Clock source info that HTE provider uses to timestamp
>> + * The provider uses hardware clock as a source to timestamp real time. This
>> + * structure presents the clock information to consumers during
>> + * hte_get_clk_src_info call.
>> + *
>> + * @hz: Supported clock rate in HZ, for example 1KHz clock = 1000.
>> + * @type: Supported clock type. CLOCK_* types.
>> + */
>> +struct hte_clk_info {
>> +	u64 hz;
>> +	clockid_t type;
>> +};
>> +
>> +/**
>> + * enum hte_return- HTE subsystem return values used during callback.
>> + *
>> + * @HTE_CB_HANDLED: The consumer handled the data successfully.
>> + * @HTE_RUN_THREADED_CB: The consumer needs further processing, in that case HTE
>> + * subsystem will invoke kernel thread and call secondary callback provided by
>> + * the consumer during devm_of_hte_request_ts and hte_req_ts_by_dt_node call.
>> + * @HTE_CB_TS_DROPPED: The client returns when it can not store ts data.
>> + * @HTE_CB_ERROR: The client returns error if anything goes wrong.
>> + */
>> +enum hte_return {
>> +	HTE_CB_HANDLED,
>> +	HTE_RUN_THREADED_CB,
>> +	HTE_CB_TS_DROPPED,
>> +	HTE_CB_ERROR,
>> +};
>> +typedef enum hte_return hte_return_t;
>> +
> Wrt HTE_CB_TS_DROPPED, why is the client dropping data any of hte's
> business?  It is also confusing in that I would expect the dropped_ts
> gauge, that you increment when this code is returned, to indicate the
> events dropped by the hardware, not the client.  But then you have no
> indication of events dropped by hardware at all, though you could
> determine that from gaps in the sequence numbers.
> Anyway, the client can do the math in both cases if they care to, so not
> sure what its purpose is here.

It is used for statistical purpose and hte being subsytem it can provide

standard interface in debugfs (so that clients do not have to) to anyone interested.

The dropped_ts could represent total dropped ts by both hardware and

client. I can add debugfs interface to break it down further if it helps in statistics.

>
> Similarly HTE_CB_ERROR, what can hte do here other than log it - and the
> client can do that themselves if they have the need.
Ok, I will remove it in v4.
>
>> +/**
>> + * typedef hte_ts_cb_t - Callback provided during devm_of_hte_request_ts and
>> + * hte_req_ts_by_dt_node APIs call.
>> + *
>> + * The callback is used to push timestamp data to client.
>> + * @ts: HW timestamp data.
>> + * @data: Client supplied data.
>> + */
>> +typedef hte_return_t (*hte_ts_cb_t)(struct hte_ts_data *ts, void *data);
>> +
>> +/**
>> + * typedef hte_ts_threaded_cb_t - Threaded callback provided during
>> + * devm_of_hte_request_ts and hte_req_ts_by_dt_node APIs call.
>> + *
>> + * @data: Client supplied data.
>> + *
>> + * It will be called when client return HTE_RUN_THREADED_CB from hte_ts_cb_t.
>> + * The callback will be called from thread context.
>> + *
>> + */
>> +typedef hte_return_t (*hte_ts_threaded_cb_t)(void *data);
>> +
>> +/**
>> + * struct hte_ts_desc - HTE timestamp descriptor, this structure will be
>> + * communication token between consumers to subsystem and subsystem to
>> + * providers.
>> + *
>> + * @con_id: This is the same id sent in request APIs.
>> + * @name: Descriptive name of the entity that is being monitored for the
>> + * realtime timestamping. The consumer can set any name it likes. If null
>> + * HTE core will construct name as ts_con_id. It will be the consumer's
>> + * job to free any allocation if name is set by the consumer.
>> + * @hte_data: Subsystem's private data relate to requested con_id.
>> + */
>> +struct hte_ts_desc {
>> +	u32 con_id;
>> +	char *name;
>> +	void *hte_data;
>> +};
>> +
>> +/**
>> + * struct hte_ops - HTE operations set by providers.
>> + *
>> + * @request: Hook for requesting a HTE timestamp. Returns 0 on success,
>> + * non-zero for failures.
>> + * @release: Hook for releasing a HTE timestamp. Returns 0 on success,
>> + * non-zero for failures.
>> + * @enable: Hook to enable the specified timestamp. Returns 0 on success,
>> + * non-zero for failures.
>> + * @disable: Hook to disable specified timestamp. Returns 0 on success,
>> + * non-zero for failures.
>> + * @get_clk_src_info: Hook to get the clock information the provider uses
>> + * to timestamp. Returns 0 for success and negative error code for failure. On
>> + * success HTE subsystem fills up provided struct hte_clk_info.
>> + *
>> + * xlated_id parameter is used to communicate between HTE subsystem and the
>> + * providers. It is the same id returned during xlate API call and translated
>> + * by the provider. This may be helpful as both subsystem and provider locate
>> + * the requested entity in constant time, where entity could be anything from
>> + * lines, signals, events, buses etc.. that providers support.
>> + */
>> +struct hte_ops {
>> +	int (*request)(struct hte_chip *chip, u32 xlated_id);
>> +	int (*release)(struct hte_chip *chip, u32 xlated_id);
>> +	int (*enable)(struct hte_chip *chip, u32 xlated_id);
>> +	int (*disable)(struct hte_chip *chip, u32 xlated_id);
>> +	int (*get_clk_src_info)(struct hte_chip *chip,
>> +				struct hte_clk_info *ci);
>> +};
>> +
>> +/**
>> + * struct hte_chip - Abstract HTE chip structure.
>> + * @name: functional name of the HTE IP block.
>> + * @dev: device providing the HTE.
>> + * @ops: callbacks for this HTE.
>> + * @nlines: number of lines/signals supported by this chip.
>> + * @xlate: Callback which translates consumer supplied logical ids to
>> + * physical ids, return from 0 for the success and negative for the
>> + * failures. It stores (0 to @nlines) in xlated_id parameter for the success.
>> + * @of_hte_n_cells: Number of cells used to form the HTE specifier.
>> + * @gdev: HTE subsystem abstract device, internal to the HTE subsystem.
>> + * @data: chip specific private data.
>> + */
>> +struct hte_chip {
>> +	const char *name;
>> +	struct device *dev;
>> +	const struct hte_ops *ops;
>> +	u32 nlines;
>> +	int (*xlate)(struct hte_chip *gc,
>> +		     const struct of_phandle_args *args,
>> +		     struct hte_ts_desc *desc, u32 *xlated_id);
>> +	u8 of_hte_n_cells;
>> +
>> +	struct hte_device *gdev;
>> +	void *data;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_HTE)
>> +/* HTE APIs for the providers */
>> +int devm_hte_register_chip(struct hte_chip *chip);
>> +int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
>> +		   struct hte_ts_data *data);
>> +
>> +/* HTE APIs for the consumers */
>> +
>> +int hte_release_ts(struct hte_ts_desc *desc);
>> +int devm_of_hte_request_ts(struct device *dev, struct hte_ts_desc *desc,
>> +			   hte_ts_cb_t cb, hte_ts_threaded_cb_t tcb,
>> +			   void *data);
>> +int hte_req_ts_by_hte_name(struct device *dev, const char *propname,
>> +			   struct hte_ts_desc *desc, hte_ts_cb_t cb,
>> +			   hte_ts_threaded_cb_t tcb, void *data);
>> +int hte_enable_ts(struct hte_ts_desc *desc);
>> +int hte_disable_ts(struct hte_ts_desc *desc);
>> +int hte_get_clk_src_info(const struct hte_ts_desc *desc,
>> +			 struct hte_clk_info *ci);
>> +
>> +#else /* !CONFIG_HTE */
>> +static inline int devm_hte_register_chip(struct hte_chip *chip)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int hte_push_ts_ns(const struct hte_chip *chip,
>> +				 u32 xlated_id,
>> +				 const struct hte_ts_data *data)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int hte_release_ts(struct hte_ts_desc *desc)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int devm_of_hte_request_ts(struct device *dev,
>> +					 struct hte_ts_desc *desc,
>> +					 hte_ts_cb_t cb,
>> +					 hte_ts_threaded_cb_t threaded_cb,
>> +					 void *data)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
> Rename threaded_cb to tcb to be consistent with other functions.
>
>> +static inline int hte_req_ts_by_hte_name(struct device *dev,
>> +					 const char *propname,
>> +					 struct hte_ts_desc *desc,
>> +					 hte_ts_cb_t cb,
>> +					 hte_ts_threaded_cb_t tcb, void *data)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
> Make line wrapping of hte_req_ts_by_hte_name() consistent with
> devm_of_hte_request_ts().
Sure, will do.
>
> Cheers,
> Kent.
>
