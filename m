Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C190D4A9759
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358159AbiBDKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:00:41 -0500
Received: from mail-sn1anam02on2058.outbound.protection.outlook.com ([40.107.96.58]:26182
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358124AbiBDKAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:00:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLkT7ER8gLxmNXX9AD0y5NWWNi6M75ZRzcTNXivAOfAOQ44JKYnUf/jgpDAsmVkO1YPFcW4p/3LIgXEgrJS/xsynMMb+2Gednh47uVK+PrrYyu+FRj5G/tJxLqr8t8fAPRokbN0hpFWzSIhNeaexB1ixEMmY+TM6b3M0pMT5G5hGV9b34u2FPDKL2A4sISiK9UoSxLFT5/xRt5r9s1abDxBcSdiHG03I/+dsrzsU9/iHeqKrYeFMOYfBnvRwL7Bjqp7bTt2jAhnzWs5cw9tycIUS8yW93GQob5THGyr0Ct8ISXD2t2nP9iljOevfkglEDB2wj0mkLscymUnWtR9tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltAWgwi6BLpcxmjoo3IH5z30TTPptEuQaBSZMfJPG5E=;
 b=m1hJrdE6KZQ6tbZE8ufFXjRm+BJpQRgew44ToLFLLLRmDg1/4GzS/aszVPJD1JZkMq1J81dzeROHcHGH9SgRjtNX/dHmwwRLmIf1GL3mhBd2GuoIC1/GB+J9Y0muXHzbcM47Y39o1Q1P5G1hb33qVH1lJJ3lGfeGlqLGR8J+WDMES1ZbhasJbJvkltfl39yf6m4z3g2OVPQ4qx0speFehmvClaIO275Wj6NyvDh41toMzwWjIv12AQj5Qaar064RajAQjTNQ1H/8Tfv2ZBzH7hsiQcOR7mSB1IA5QRucCh9Uz4xy1/ghHsy44vQuve25TWCf0UaG9Nv5OqIeNMuDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=renesas.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltAWgwi6BLpcxmjoo3IH5z30TTPptEuQaBSZMfJPG5E=;
 b=sEUfTl4dNl4s1ixz+vBx/JuFAP/zLpafYHg1BftEiGG+1jt39mgR/OfEDJxYMM8xgo88txOZfAoZVpScRC6hFGbntg6Z/ShXo0lIsYNC4LBZHQ8n40t6S7ffbvzLKz7l/65p+XJi/PKBLHGG5xh0nuu/B/RLTIjFYUpBy7x07Wk=
Received: from SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24) by
 BYAPR02MB5926.namprd02.prod.outlook.com (2603:10b6:a03:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 10:00:33 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::24) by SN6PR01CA0011.outlook.office365.com
 (2603:10b6:805:b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 10:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:00:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Feb 2022 02:00:26 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Feb 2022 02:00:26 -0800
Envelope-to: alexander.helms.jy@renesas.com,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 arnd@arndb.de,
 robh+dt@kernel.org,
 sboyd@kernel.org,
 mturquette@baylibre.com,
 geert+renesas@glider.be,
 david.cater.jc@renesas.com
Received: from [10.254.241.49] (port=48382)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nFvOE-000EE0-DD; Fri, 04 Feb 2022 02:00:26 -0800
Message-ID: <94993d27-948c-bf41-869f-c050a2efe0f2@xilinx.com>
Date:   Fri, 4 Feb 2022 11:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 0/2] Renesas 8T49N241 device driver
Content-Language: en-US
To:     Michal Simek <michal.simek@xilinx.com>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <geert+renesas@glider.be>,
        <david.cater.jc@renesas.com>
References: <20211021213106.315-1-alexander.helms.jy@renesas.com>
 <008026a5-a9a5-0d13-867d-fc99e95af09b@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <008026a5-a9a5-0d13-867d-fc99e95af09b@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132d09bb-6cb0-433d-7b87-08d9e7c52ef3
X-MS-TrafficTypeDiagnostic: BYAPR02MB5926:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB5926CBBADB27896CEF0F81B5C6299@BYAPR02MB5926.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8Ovb809In7pGJ9z3fXGJ2t7gOTu6S7ycIuHGlebH2bqkBdxZJDh090YoVOB3yaldhBAipibBVVlGS/X1IrQAxyPMbnF29eXBev50dkMMMM26Px9nndFqXlUFeZ2zTJc3w/Y8raRf10p4Hzm+QahmqVnvnwsn6YfkZtP05xq9dOa0LMdVE1tgsqglPR3ehZIGduYQP8PjeWzFQIok5nsCevN9dtzBZwbjB8vm8KXpCpn7wVNgHlc+vz9UpphOxviGLTi8J1pVLwowt5kAo9rGp722yHJGWUypZSyjdUtHSQaHJk51rzCGe8pj1PbzqS8jfiIC57RBd/y493D6jGj8HaTKj06ja8L3Ifwdri81jmAbOFowWvCE3WDpQywg8JqQYeH7nt0g93cMZ9xG2b5kx9DTapNuDaRe35a+reCUJNBD2izZRsZRt3CPSEPqosOup5bZ82pPTdhWAiJynF2bjuV9JZGcl7HwDo03mQ7tpXreUNQcZmWKZhF52gLVnzcXkcCfh7w7PHxrrTAJ7PQxuRncHqF9MhfNFfMFkC/yjf/SjuMoJI8QvbNcelfPh0loWXdJa7OQYKQj7kvpqWJUwWKhzD+fyaYijEc9LW1Wha39VKDUVLY80raQMNtZI3Kj6qrNzO4y5L4dsTxQ9xLvX669IsOFQhzy6elw9OBMJg6+KwhO985FzEQOlt/Q8gMpf+XZfzXD514D4jOWE/7kA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(83380400001)(2616005)(316002)(82310400004)(31686004)(110136005)(508600001)(54906003)(36756003)(44832011)(36860700001)(2906002)(6666004)(31696002)(9786002)(7416002)(47076005)(53546011)(336012)(426003)(26005)(8676002)(4326008)(5660300002)(7636003)(186003)(70206006)(70586007)(8936002)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:00:33.0824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132d09bb-6cb0-433d-7b87-08d9e7c52ef3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5926
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/22 10:36, Michal Simek wrote:
> Hi,
> 
> 
> On 10/21/21 23:31, Alex Helms wrote:
>> Changes in v8:
>>   * Use __ffs instead of ffs
>>   * Change from 64 bit to 32 bit division
>>   * Minor math changes to avoid possible overflow
>> Changes in v7:
>>   * Rebase on v5.15-rc6
>>   * Rename renesas24x_* functions to r8t49n24x_*
>>   * Implement determine_rate instead of round_rate
>>   * Implement prepare/unprepare
>>   * Use devm_clk_get_optional and ensure clk0, clk1, and xtal are attempted 
>> before dev_err_probe
>>   * Use ffs() in __renesas_bits_to_shift
>>   * Remove regmap read/write retry
>>   * More consistent debug logging
>>   * Resolved many C related naming and initialization issues
>> Changes in v6:
>>   * Rebase on v5.15-rc1
>>   * Ensure Rob's Reviewed-by tag is included
>> Changes in v5:
>>   * Rebase on v5.14-rc2
>>   * Move driver files from clk/renesas to clk
>> Changes in v4:
>>   * Add vendor prefix to dt binding compatible property
>>   * Remove clock-names description in dt binding
>>   * Remove redundant 'input-' prefix on clock names
>>   * Clarify the settings property in dt binding, add data type
>>   * Fix define spacing
>> Changes in v3:
>>   * Clarify settings property in device tree bindings schema is optional
>> Changes in v2:
>>   * Correct missing semicolon in 8t49n24x-core.c
>>
>> Alex Helms (2):
>>    dt-bindings: Add binding for Renesas 8T49N241
>>    clk: Add ccf driver for Renesas 8T49N241
>>
>>   .../bindings/clock/renesas,8t49n241.yaml      | 190 +++++
>>   MAINTAINERS                                   |   7 +
>>   drivers/clk/8t49n24x-core.c                   | 752 ++++++++++++++++++
>>   drivers/clk/8t49n24x-core.h                   | 242 ++++++
>>   drivers/clk/8t49n24x.c                        | 565 +++++++++++++
>>   drivers/clk/Kconfig                           |  21 +
>>   drivers/clk/Makefile                          |   2 +
>>   7 files changed, 1779 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml
>>   create mode 100644 drivers/clk/8t49n24x-core.c
>>   create mode 100644 drivers/clk/8t49n24x-core.h
>>   create mode 100644 drivers/clk/8t49n24x.c
>>
>>
>> base-commit: 519d81956ee277b4419c723adfb154603c2565ba
> 
> DT binding has been already reviewed and driver itself was sent long time ago.
> What's the problem now?
> 
> sboyd: Can you please review or pick it up?
> 
> Arnd: IIRC someone told me that if there is no activity it could go via your 
> tree too.

I saw that kernel bot reported 3 issues. I have fixed them and send v9 and 
hopefully this can go in.

Thanks,
Michal

