Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7164A96EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiBDJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:36:15 -0500
Received: from mail-dm3nam07on2087.outbound.protection.outlook.com ([40.107.95.87]:51937
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236491AbiBDJgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:36:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpVxtqcf+3m8J9mvEDRwDjSSAGF6Oa+N+DmDoaddYtqgQf0RyAuRuJrT5DikowmeTNIqvO4rJgpbQG+4IsoVyPwRCcwXf9nP0Ji/aVZAWY1uvpBjk99HmSCNuHFEUb8bN3ldwtd7oj8PqjT79ZGfPTWVq2qu/dYpZWxBFfQqXG3S55I8VyW1wn6Y8St7VjwXqzHs3dL4vQTnTiwnL8YXwJMkfmdTfmMuIBZdS4wrOTpL1/mEjXtNbu9BOZJ6cGZxe0GnG2EsBL2GFui1+09Tr0MddMvf/UtviYOy4v/9TXW0qexbHIyKLIgXlEzLWgQGh1SVgKOseKcCcTKe8U4/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5/v13e0zbCTdbiIruov6vmZwxrPr+vhv/OVjEsv4SY=;
 b=HXj2TD3GlymycRKSBYy+3tJtNpIdYsRbpK3bIkPte2QTn5KShqHUwV8oTh32mXlaEbAgorZ7biQcJ68E4wVFKYwFKKgbfI9vBINCu+KuPwyF4hf90ixptEw4VLnjcx+/Pl9qK5ChOFqrtw3LTG3WwsyOLNa0J88I/HUvPTynjeo48O0XUwcXS0+4jWZlG791TajABj5Nxn4+RlqGUjd+Y5aFD3mermYB09IL8WRGSxPOMhreUazbkwMkistAQvX9FtYtyPhrDzPkPa0t+UbUEcbE2H0SqJYkpCXAGA8JOmKw3QOPW54+a3Ca/Z89YS3n5cAxKH5K10S7BhVBMU5qgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=renesas.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5/v13e0zbCTdbiIruov6vmZwxrPr+vhv/OVjEsv4SY=;
 b=I93QrtbXVOzoin/eLPQ1r4h1Pn1QUl5dc2PoCbRRDH7i0xAua5kASMtGRul2SbeMkbP42/0EUCNRQ/rkZQFQOHS2RAyhhW4S/i5Y7aOrsTDR7Rudg2ygzh8Rjyks5mIhGZKIPNR3j1CUhR0/AROmBGqGifi4XszhvQ49kzhhf00=
Received: from BN9PR03CA0844.namprd03.prod.outlook.com (2603:10b6:408:13d::9)
 by SN6PR02MB5293.namprd02.prod.outlook.com (2603:10b6:805:6a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 09:36:10 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::9a) by BN9PR03CA0844.outlook.office365.com
 (2603:10b6:408:13d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 09:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 09:36:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Feb 2022 01:36:09 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Feb 2022 01:36:09 -0800
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
Received: from [10.254.241.49] (port=46380)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nFv0j-0009NC-6l; Fri, 04 Feb 2022 01:36:09 -0800
Message-ID: <008026a5-a9a5-0d13-867d-fc99e95af09b@xilinx.com>
Date:   Fri, 4 Feb 2022 10:36:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 0/2] Renesas 8T49N241 device driver
Content-Language: en-US
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <geert+renesas@glider.be>,
        <david.cater.jc@renesas.com>, <michal.simek@xilinx.com>
References: <20211021213106.315-1-alexander.helms.jy@renesas.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211021213106.315-1-alexander.helms.jy@renesas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b32a7805-088c-40fc-fecc-08d9e7c1c6c2
X-MS-TrafficTypeDiagnostic: SN6PR02MB5293:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB52933FACCCE9E29B77AF4D7DC6299@SN6PR02MB5293.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGVl8o3TkdLRwKc7GTZgn8qbiWa+90BWcA1+ITuTyJnJPmJ++z1AbzxAvgyuoXFFS2cehCUqaedeSZE2/SADzDqslQnzJoBJGscCJXdB0bGkaJ3W/7a8k4TsYD62CmnJI89eJqSgihE3eDpBuMWC5ngA9j3N863mGpYdciqCi9s5MR61lJgo2Cdf29Ymarzjeex6AECgcLUHgYG0asW8ILGCIynlcQxQuOHZbJg9cW0kO1UofMCrXB3aGptpKTpKR6bnlx4106EQgDmiNlM3ps+uzv9vnZUElde95UMLWkFPuOvchVp6Obk4PZDDMsRqiNRRi8hZ55MgJm3bvB7fitz0TCn7a04Ezw+KPed4JMKno9p8ei/hxz+F2yRkWIJ/Czw8aVxpqmWc7fA09GASoHv3CudXwBYP2rW80+W4lhHn7WaFbGl3W9PwuyH96sar82uRTbVnZqozpJEEosr8YK/CoJVjnTX+BFFltwWV2r0y90i+WAROkFS83bcd41rTuo6JLiSsprPmQZEA2/rbMiyEZm6kvIxBXpK4jCZMyU7hslwBwREUFYaPhedTD6l59Nk7Sg5XHwDIkYfTcigfTZJmXe4/AHzCvdCQCDubCug5vRjEGSi4IpzCkB9nbkL+iwIR6tbJucPiGdhbkIqUyT3Y44mzEQOyhNEr7Wy+Ge2KRK45LGSZYJ4RDzUXxS5dUkhh89wBnqI4tsXNmFKmYA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(2616005)(26005)(426003)(336012)(31686004)(83380400001)(107886003)(316002)(9786002)(110136005)(54906003)(36860700001)(6666004)(31696002)(8676002)(4326008)(2906002)(186003)(7416002)(5660300002)(8936002)(508600001)(47076005)(53546011)(70586007)(70206006)(36756003)(82310400004)(44832011)(7636003)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 09:36:09.7601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32a7805-088c-40fc-fecc-08d9e7c1c6c2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 10/21/21 23:31, Alex Helms wrote:
> Changes in v8:
>   * Use __ffs instead of ffs
>   * Change from 64 bit to 32 bit division
>   * Minor math changes to avoid possible overflow
> Changes in v7:
>   * Rebase on v5.15-rc6
>   * Rename renesas24x_* functions to r8t49n24x_*
>   * Implement determine_rate instead of round_rate
>   * Implement prepare/unprepare
>   * Use devm_clk_get_optional and ensure clk0, clk1, and xtal are attempted before dev_err_probe
>   * Use ffs() in __renesas_bits_to_shift
>   * Remove regmap read/write retry
>   * More consistent debug logging
>   * Resolved many C related naming and initialization issues
> Changes in v6:
>   * Rebase on v5.15-rc1
>   * Ensure Rob's Reviewed-by tag is included
> Changes in v5:
>   * Rebase on v5.14-rc2
>   * Move driver files from clk/renesas to clk
> Changes in v4:
>   * Add vendor prefix to dt binding compatible property
>   * Remove clock-names description in dt binding
>   * Remove redundant 'input-' prefix on clock names
>   * Clarify the settings property in dt binding, add data type
>   * Fix define spacing
> Changes in v3:
>   * Clarify settings property in device tree bindings schema is optional
> Changes in v2:
>   * Correct missing semicolon in 8t49n24x-core.c
> 
> Alex Helms (2):
>    dt-bindings: Add binding for Renesas 8T49N241
>    clk: Add ccf driver for Renesas 8T49N241
> 
>   .../bindings/clock/renesas,8t49n241.yaml      | 190 +++++
>   MAINTAINERS                                   |   7 +
>   drivers/clk/8t49n24x-core.c                   | 752 ++++++++++++++++++
>   drivers/clk/8t49n24x-core.h                   | 242 ++++++
>   drivers/clk/8t49n24x.c                        | 565 +++++++++++++
>   drivers/clk/Kconfig                           |  21 +
>   drivers/clk/Makefile                          |   2 +
>   7 files changed, 1779 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml
>   create mode 100644 drivers/clk/8t49n24x-core.c
>   create mode 100644 drivers/clk/8t49n24x-core.h
>   create mode 100644 drivers/clk/8t49n24x.c
> 
> 
> base-commit: 519d81956ee277b4419c723adfb154603c2565ba

DT binding has been already reviewed and driver itself was sent long time ago.
What's the problem now?

sboyd: Can you please review or pick it up?

Arnd: IIRC someone told me that if there is no activity it could go via your 
tree too.

Thanks,
Michal



