Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FEE5652AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiGDKnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiGDKng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:43:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C2E07;
        Mon,  4 Jul 2022 03:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C587aOfrCAMbRXBKQaS3FalbMoNXh6MEwO7nMTbRaDRWYXPjEz2boXNQD1jEajtz4JXoOgN+9/B26QIe+l4HA+L5l6K5Y37mg2v0JANWIqoqm9+meZHvMNqDcOR2G0Rbvycxfoao8bBOrl92SBfEAFT1hcBfYN4TLbOXRu5xd87kqjLiLynX7vOFkOEZWdaGR/K92fQj4MyVNVJitkPv7ZHwC9+MA2MsZl+GMXlog4P5aq1h2MjjCHpr0HZMScJRbhnpaPEp2QN9fMmqJUKNBXh+EfGzZCNU+SLxU6Ytr8r2x8YbIZjeuEJLMwl/gVfFyItjmJBsCuAA9y3bjwDPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C8P+B0wLiR2ZDAWKpdWmeWUbV4Hpo0CQo4/CrAB5Tg=;
 b=RO07QRXvW/dkyO3we5zXfq/UqDh7ga3GDIvNPW49trIoYftwCAfgYAjTAz8SkARa9d8YI6Q4cHKj++3/U+sTzEBZWdcZj/ouh3JgTNuyOqDMG4fwceX8+iiMSGVQGm+yXqoKAlO5inAThIL2SKuajhESsgP6brQy8m0wOEiIoaIdxhwcSgIjDt4l85FN7JAxqh2GrZKRETQiAy9LeOs8sXN2XDIvdw7yeVtU67cBldZYHAk/JY02QMfJD/HeJjkgvhjzFysWyA0b6xs8gvu3MTV/fcoKxqLYU+NL1b/j0UCqSGoQKLJBQLEQdq07u0pK/f+AbhdNcSH0Tva9yKTIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C8P+B0wLiR2ZDAWKpdWmeWUbV4Hpo0CQo4/CrAB5Tg=;
 b=csKJY9uWfjB8mW8S7Nrd5j0OykBn3E7EO4k7ica68t8yAHdgDqb9tOUC958L6e94UduIuK1P+QrMIQfZCRDPSXQwlHmTZ9RMtvhli+6qikIADnkx+xUhFRcVmk7d50lTlEfgqmZN2KravPiHF6rTq1V8mvcyfNbThWANst2amZw=
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by DM5PR1201MB0170.namprd12.prod.outlook.com (2603:10b6:4:59::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 10:43:32 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Mon, 4 Jul 2022 10:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 10:43:32 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 05:43:29 -0500
Message-ID: <1d6eba67-5a63-e1b2-c9cd-583b950ddca6@amd.com>
Date:   Mon, 4 Jul 2022 12:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device
 properties
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Conall O'Griofa <conall.o'griofa@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
 <20220603183224.540b3808@jic23-huawei>
 <e2efcf6d-ed85-dc6e-64e1-f0efedd4a673@amd.com>
 <YsBYvPKfZRLygCyz@smile.fi.intel.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <YsBYvPKfZRLygCyz@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 935638a0-86e7-4de9-c45e-08da5daa0a31
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0170:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq1895HnZecU5mXwRGlln9FETa6e8CKOC93w5uztE7ioUL6rmI/2ogUTFLhnaHNT03nAtdIYrLwQP4s1iuETEmqA/IPj9OlDoym7gG8Io1Nxdtjbbu48VOAushpykmJlTEMG5LNlmpHWUc8dd/ybe5CW8dkuHZsCGJypeLeHSLygfyGR4+xw5OP5OGHa99DNkTRAl059v9w1Ucpd1iKNAeeHVdyVJ0/HBirmRtx1+PjqWnpblqSwL3pO4FTkNJMsAIIX8OX3BpOElCgyFcWjjAsADBh1ibvncAwC7RwrEHY7tsMWnPo5dogL0Y6Ab88DrrWZpKz9NwzY7YIOO2ZH1f5B0G1B6tm18Nad3xKKznZuOe5Zl+sGIt5AxYaFniZhdySxZIda1+DdbMSbrau7SMrAit57x8G1yRVvjM7UePyRYXgulRVkT5aYWtPKepc2ein7QX7AVdITt5oeGpPqCe4JC3wUgmYRpd8vuLes4wEZE7IIWySotsp45vVEURHpyIX8o0u5sSgmNMU15PUSrIKnmTZr8ByDc/8GEuKaVMmFB4DYuuoU6uR1GX0XRgN0Udxp7g7+WJ6LV2HLFeKKbYy33iyivKvGraPZXDsSsCVGGJtCqN+3NoMpcGRBA4wt8LJkfXq8fAQEssAEPf9L9MK8K9vi4jTZ0nkrGH//qpZHDxcjAmOrO3J5WMh3tBTfPVopVKgSe16LDF2Yoo+zKmuDEjhj8tvVbiKQXjJuVDqijYYnL700UkY7+nDeXNysjc6rBiT5NkFgd0XAI/eI9m33Fu8hIBF4dSQnaSfT/FuNDsyfyxLowfUn0wB13NneWY8+rA9rdFSS0TV+xm5jU/dV7BkFf4PzIosvP8Za5YnL+TJCgMR9xdkLRxrR6rnXNJlFJ+yDVTh/d92Y+34KeYd7zkS+/+DVMec/Md2g7mQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(40470700004)(36840700001)(46966006)(4326008)(478600001)(5660300002)(44832011)(81166007)(82740400003)(31696002)(8936002)(356005)(6916009)(54906003)(8676002)(316002)(16576012)(86362001)(40460700003)(47076005)(426003)(70586007)(70206006)(336012)(2616005)(26005)(16526019)(186003)(107886003)(41300700001)(2906002)(36756003)(82310400005)(53546011)(6666004)(40480700001)(36860700001)(34020700004)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 10:43:32.2266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935638a0-86e7-4de9-c45e-08da5daa0a31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 7/2/22 16:39, Andy Shevchenko wrote:
> On Mon, Jun 20, 2022 at 04:58:04PM +0200, Michal Simek wrote:
>> On 6/3/22 19:32, Jonathan Cameron wrote:
>>> On Tue, 31 May 2022 17:11:17 +0300
>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>>> Convert the module to be property provider agnostic and allow
>>>> it to be used on non-OF platforms.
>>>>
>>>> Add mod_devicetable.h include.
>>>>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> These both seem good to me, but as the driver is fairly actively maintained,
>>> I'll let this one sit on the list for a while so others can take a look.
>>>
>>> Whilst it 'seems' unlikely anyone will ever use this driver with other firmware
>>> I am keen to reduce the number of of-specific drivers in IIO just to avoid
>>> any chance of cut and paste.
>>>
>>> Who knows, I'm trying to run an aspeed-i2c driver with ACPI at the moment
>>> because it's handy for a emulated setup, so maybe the same will one day happen
>>> with this device :)  Weirder things have happened.
>>
>> Conall: Can you please test these changes and provide your feedback?
> 
> Hmm... No news?

Anand unfortunately left the company. I have asked testing team to test this 
patch and they can't see any issue.
That's why:
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

