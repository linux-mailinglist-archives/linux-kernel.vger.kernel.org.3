Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D379D574C05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiGNL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiGNL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:27:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADF5885A;
        Thu, 14 Jul 2022 04:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJl8QtY10eG9Q1fch8sR8R0892BnMgn5/JRdD6qKJcmjr1etyahnKFU95FngHk1Vstz9DHoU/mn0qW89zHR1Yut3l4WnOH98V1VwcizJf+JUFKmdcXYX5ACnSKCgAmYbWdLjWxIV6NxefF6XecO0fYXce0GdOC/tYg6jfoVcPP14Y6ZNbTfV76PcDrFjWjwx3/ePc0lbpT0roozie2U7dPWrHfCy9hs6AgqQOJ9XsWwojuBHK3oiiaVDTqBrtLbGxBWWb+vc+oS6IG4c6P5I1qN7kN29FxyFdKoxidFe6MUK/SgJLuvJjXlzWg8G3JOXsAWwksQWfDBO2LD7ZFvWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLS3/kE86UTPO297iPfeEkTCgSKGF6sqQdihn4AI2rA=;
 b=gbtKidMNSSpmrDDlteuUJylIjWCLMs+07ODNCgiT3v4fHFfyHT4hHfyx/6tO0N+MGHzxULtPeDqHpphVmy+w1/ezF9spsOBwiOSj62n+sQXjmxraipgoYVm3FWXzoLkGKd5rELNIebNQoceDqB9dMr6ZBK3PxAN41H6B9jGM/ZsNOrJ+xg5N+aXq6amzHlL8a1OfmedjlE/melEYnQCLdH0POYESgPxGkrJUjzvA8dnWhMNHmocUIjOjnwjzAP67cbXXv6nwK07PqQVmLRpkRHZjHkfVixpLbnK7kkPgGeIK5rpwfj+6mTTDUyx5mCQtBQ3wHA5ExO4nd4OmQMpYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLS3/kE86UTPO297iPfeEkTCgSKGF6sqQdihn4AI2rA=;
 b=t4y0h1MMf4BKbH/Ic5USWUfydHvr5ERZDay26t+PPShQ7jsoHuAakTRfpeA9gheLXC1jXE+2al5XkrVR3c7JrTXtOhkdygVEIxJ6HoeyBuO9dI6gHKQetPaEoQSN1dPB8LXaCDnNeP4IoC+BPWSTwmv8yzrVFJOSfg1hpBuKTlk=
Received: from DM6PR06CA0074.namprd06.prod.outlook.com (2603:10b6:5:336::7) by
 MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 11:27:04 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f5) by DM6PR06CA0074.outlook.office365.com
 (2603:10b6:5:336::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25 via Frontend
 Transport; Thu, 14 Jul 2022 11:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 11:27:04 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 14 Jul
 2022 06:27:01 -0500
Message-ID: <155c77c3-25d9-7edc-35bd-56e6cfb19ac6@amd.com>
Date:   Thu, 14 Jul 2022 13:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v14 0/5] clk: clocking-wizard: Driver updates
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <linux-clk@vger.kernel.org>, git <git@xilinx.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80fc2ff7-902c-4a0d-8083-08da658bc770
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0174:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U283dCt6WDEzRlNMU3IyeDgwejl3L0czN1VoZkpHSitRK2x0a0dQSEJQSE1p?=
 =?utf-8?B?WXUzWjB1ckdLWjMvRm12dXQxQWlkUzlDMTVOdVJTZDVNZ3RUTHhxeWlwemU0?=
 =?utf-8?B?YkFGN0FCcUdONTB4L21wckxoVk8rVm5ZVXhVV1lIV2ExU0dXb3JSQUFUWTlu?=
 =?utf-8?B?a1o0czQzRHVqL29UZ1FrKzlKRHFxSm9UWU1mYkVhWnBBU0owUDA4OGx0cDRB?=
 =?utf-8?B?RjAwZFpMckZwdjMxUnVYdENaSWh2T2ExZEFTRk5iZytXL0xtMHU3N2Z2bHdx?=
 =?utf-8?B?Qm04a0FyenNEanRvY2dmdmxJVTJsQVVwMjJpeEtnQXdLM1Z1NWtaN3N3a2JK?=
 =?utf-8?B?WUZUL0U0UXJOc0dnRHVXRTJVSXJiM0xqYlVLNG9ScGwwVzBxQVVvOGlqbzEx?=
 =?utf-8?B?eWpTS2EvTEFtd0JadjNUbDJJTDRhRFZKWGxKZE8welFOZjhUQ3RVK3E5Q0xs?=
 =?utf-8?B?clBzNTZqWkRFN3FncGpmcXdrbjNreWhCb2xrVk9sRUd2OUNyTG1NNEk5RFBy?=
 =?utf-8?B?RDVhUDBwRlFkYnYvU0M1MEpKUVNEWiswZ0FBVndCdHhvUjVtZTBMTVEyR1Fy?=
 =?utf-8?B?b04zZS9FRXJSdlhEZ2VONGNwWDVOZnZ3QXRmM3dCSHVCZXRoWDBERExqU3pF?=
 =?utf-8?B?ZkxwSVNvdnBlRlpMbVRRRGtrZGJHNnMyMGpGMEhyYU5wRzdtNVRvNzRxRXV3?=
 =?utf-8?B?SHo5dlZrbTYwL24wcG5hRGQrQkZrQXp3NHdzVzQ2NTJqR0NBc0w5SlBXcVRS?=
 =?utf-8?B?NnJYelRaUzc3R3phdlg4dk1rYXdteHZicEYzOUIvYWFxVGMxTVZrU0UyaGYv?=
 =?utf-8?B?RDFmd3EwdExOZG81Q09vZ1JJNmRsaDgrUVdFTHJCVno1eW5HVEF4czc1cWJN?=
 =?utf-8?B?VUNBc2U1Vmowb2s3S2hIZXZ3dDFnV09FMkE5RjlMZldWNjM0bzJHQkRoNlI5?=
 =?utf-8?B?ckUxTFl6MVVOQ1Yza2VaY0p2L0t2c1NOUUl5d2hpZ2R3QlIxSWxXV3VyeDVx?=
 =?utf-8?B?U2JyS3Z4NDdQY1p6aTE4a3BDSGtwWVNBeldrMmlVWU50aEVQRC9KNWN3Ri9M?=
 =?utf-8?B?UEc5eXF6UFExMEdkKzluQU1uWHhFNkorQURGTFhkViszcVlwK3lzTE5Kc0xo?=
 =?utf-8?B?bjlxMDljNU5yTmZsVk1hbXUwY1Z6RngyVFNRdE1CWVZUaDBtTGJUNy9nM3Zr?=
 =?utf-8?B?eGdNOW1qKzFrVGNJeDl5NDdqb2ZMcU4wWXlnMXozcHMvaVZzVlBZUFd1Wkh3?=
 =?utf-8?B?VzNjN3U2K2JsRWQ1QTlIbjlFb0I5Y0hPaHFPalRQQlRHT09HQT09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(40470700004)(36840700001)(966005)(36756003)(53546011)(6666004)(31686004)(83380400001)(478600001)(426003)(47076005)(26005)(16526019)(2616005)(82310400005)(41300700001)(336012)(186003)(2906002)(44832011)(40480700001)(36860700001)(110136005)(15650500001)(54906003)(8936002)(356005)(31696002)(5660300002)(82740400003)(70206006)(86362001)(316002)(16576012)(81166007)(70586007)(4326008)(8676002)(40460700003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:27:04.6151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fc2ff7-902c-4a0d-8083-08da658bc770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen and Michael,

On 4/11/22 12:04, Shubhrajyoti Datta wrote:
> The patch does the following
> Update the versions of the clocking wizard ip.
> Move from staging to clk directory.
> Update the bindings.
> 
> v12:
> No change.
> Rebased
> v13:
> Update the clocking compatible
> Add the change removing the driver from staging
> v14:
> Moved to the xilinx folder
> 
> Shubhrajyoti Datta (5):
>    dt-bindings: add documentation of xilinx clocking wizard
>    clk: clocking-wizard: Add the clockwizard to clk directory
>    clk: clocking-wizard: Rename nr-outputs to xlnx,nr-outputs
>    clk: clocking-wizard: Fix the reconfig for 5.2
>    clk: clocking-wizard: Update the compatible
> 
>   .../bindings/clock/xlnx,clocking-wizard.yaml  | 77 +++++++++++++++++++
>   drivers/clk/xilinx/Kconfig                    | 11 +++
>   drivers/clk/xilinx/Makefile                   |  1 +
>   .../xilinx}/clk-xlnx-clock-wizard.c           | 19 +++--
>   drivers/staging/Kconfig                       |  2 -
>   drivers/staging/Makefile                      |  1 -
>   drivers/staging/clocking-wizard/Kconfig       | 10 ---
>   drivers/staging/clocking-wizard/Makefile      |  2 -
>   drivers/staging/clocking-wizard/TODO          | 13 ----
>   .../staging/clocking-wizard/dt-binding.txt    | 30 --------
>   10 files changed, 103 insertions(+), 63 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
>   rename drivers/{staging/clocking-wizard => clk/xilinx}/clk-xlnx-clock-wizard.c (96%)
>   delete mode 100644 drivers/staging/clocking-wizard/Kconfig
>   delete mode 100644 drivers/staging/clocking-wizard/Makefile
>   delete mode 100644 drivers/staging/clocking-wizard/TODO
>   delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt
> 

I was looking at comment in v13 and moving to xilinx folder was done in v14.
v13: https://lore.kernel.org/r/cover.1631623906.git.shubhrajyoti.datta@xilinx.com

dt binding is also reviewed by Rob already.

You asked there to get confirmation from Greg that it can be moved out of 
staging. I didn't see any reply from Greg about it but not sure if this is 
really required to get.
Greg: Can you please ACK it or comment?

And in your v13 reply you said that you will pick it up
https://lore.kernel.org/all/20220112204055.CF098C36AE9@smtp.kernel.org/#t
but I can't see this patch in your linux clk tree yet.

I have also see that some people are sending you pull requests to merge it to 
clock tree. If this is something what you prefer I have really not a problem to 
do it.

Thanks,
Michal
