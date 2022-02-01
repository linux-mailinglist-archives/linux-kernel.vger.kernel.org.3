Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D692C4A544A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiBAAuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:50:08 -0500
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:55393
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231311AbiBAAuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:50:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiUqEhFlI+yXyXEYktoJHW4Ugi/7XXvlfcARrWS68Gl4tMEiVIMr7HoLeOsLP241eCS5u/c/v+8/5Yh1Fis/oV2EzvNAiNWAmVOwFdjbqrdQEveQNTDUYRKDfJO/VTNGKmY+zzNklV2AnYObJ8rKyRjGu/C37RCI80wWERtGmzob1SK53nxSH2gJQkZUYno0RiTqkjOsqv4jDw67kue48fk2TM2Krk72joCvZaQF9v+wlGYlSNbItqH6K479UdHi/YKl3ir4BPl3AOID7xjbk98EapFGJSdxs2kU6hRNYl4VQGiHPrs+OW8zt8uVTjX7ZodiRPM44gG9qWmLQJD5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGIvMTQx9wI9Y3zHrHo2RjEF3krxmZOyHA9eq8rhUSE=;
 b=lDf2Zr6+wLYLvdNu0vK8EVp99u6E9+neE+hY+Nqda783zzhFAwwKc27Bt4uP/aewpo9iERc/0Caf3Lh3+cCYWBPDkcKkV6lBKw8LcGZJte1GqN+gnQ6IUE/YuqXXGqgs37L4gMZMQWesfWDnBgF4hmLHm7hyzdqQx2Z538HawI7NJ+5J63SjD3qCiCGW1TMzbeWwfCnov8wqP6qlIAF16G1pEmbPt2GgfcUNhXRchL1dVytlBLhmYz0I2zAmG2yyvOoR2o3f9c/UNHZ292WeP5DNpkhrtgnNI+OOHGbQQ7kwjnjjds22+CJU1U6FdUEpBD/xZT10EJjtHE8jvbrJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGIvMTQx9wI9Y3zHrHo2RjEF3krxmZOyHA9eq8rhUSE=;
 b=cc5NtO2JaN+VUy4Hu8edvzNuW1S0gdCvNhIuLHU6KoCgBQgZk/H8uVfeIci5KiPw8qr9snuAT17bf8W2hAFmHtAeZUKVXEFT9UeG+bbbsuVQhs9FGxPqj4zbB1IUqB4Pea0SfHRe6w0DkyUvk6V7HXVA3ghalMAb7JId7B9Nzm0=
Received: from BN9PR03CA0807.namprd03.prod.outlook.com (2603:10b6:408:13f::32)
 by BL0PR02MB5684.namprd02.prod.outlook.com (2603:10b6:208:85::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 00:49:54 +0000
Received: from BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::9b) by BN9PR03CA0807.outlook.office365.com
 (2603:10b6:408:13f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Tue, 1 Feb 2022 00:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT020.mail.protection.outlook.com (10.13.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 00:49:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 31 Jan 2022 16:49:53 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 31 Jan 2022 16:49:53 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 trix@redhat.com,
 yilun.xu@intel.com,
 linux-kernel@vger.kernel.org,
 robh@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.17.2.60] (port=35296)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nEhMn-000F2V-He; Mon, 31 Jan 2022 16:49:53 -0800
Subject: Re: [PATCH V1 Create empty OF root 0/1] XRT Alveo driver
 infrastructure overview
To:     Lizhi Hou <lizhi.hou@xilinx.com>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>
References: <20220126054807.492651-1-lizhi.hou@xilinx.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <17d60142-c72f-1a11-45de-e9a2974abeb8@xilinx.com>
Date:   Mon, 31 Jan 2022 16:49:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220126054807.492651-1-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce173449-692a-458f-4f70-08d9e51cc316
X-MS-TrafficTypeDiagnostic: BL0PR02MB5684:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB5684CD0B5E650800C7B47CD5A1269@BL0PR02MB5684.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhsn9FIIjDoAJp89D4BsszV3YVAqOupqUl0MFBXAuxM/If7tDjwAF1yXzCM0uv12FVp0pASt08/aXR6UNHebX8gTYPp8Eo9bdkQqYL5Meo30lvfIk2olASDi9mxfigcxx/0asP+qLIKHwDJkbICBY/dmyTS/ifnTuPbujU56Uclsj1zEhjIZfTyHOv3/kZ7nsD3frCtURe3O4eK7MWY0veCRZaY40IQqKS13uUvPY5sB9mS+4zmW/duztz+qeuBgHsjiBgrsB2djwuwwgwu6NIfJoe26JtdBmPF3l5Lcq93x8DeM/9mfs23KVLYmBx13mpOSoqTfHgzV/hLY2uyeEeJ25xRajUyu6JGSsNjZgGkr6lFRQXaIgglcPtGrv0WFuhWzTkIVn6Y0o1gRsz/Q5D4DAxFZWfEC7FUXZi2unFNl55o7NYClszox6ldNuxezXk8Nm+oVf37A/fOoGpmVq/ACOkYNS/FWPMMQvtToyAXy1UoBc98sjbMy3Gv4J9rJoUGuyEAliSj/WLyM7ZI2eIznBEntO42EiVqGAz9M0iLzIDLKBCMhh/bnwaxZY1A8tXA/39NhX6jC57OgkJFoj30UqELlf09tTy7Y0mzu98dfWgpK9FyduVyrVwAt3LikLTQHsgvmRE4Vq4mRKNw/c3Od7gAHQckjSUjTxsX0MNZafUnVjzp7ZfJNj3fvP6gEV/OddZDsvX3hLjdHmFRNugdHkl1i2s/eOel3drer6QLtXnPtu9dtFR3k8Vw/C2HyQ+d43xSDHGG8wCWUlqQXXQe6horwu+JYK6jilZe7XyAuNCJnAQCpNRQFD6e+XGpMRN01/MNcQjgZAQyMyxciaA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(31696002)(966005)(7636003)(54906003)(186003)(316002)(110136005)(44832011)(5660300002)(508600001)(82310400004)(2906002)(8676002)(4326008)(9786002)(36860700001)(8936002)(47076005)(70206006)(70586007)(26005)(2616005)(356005)(336012)(426003)(36756003)(31686004)(53546011)(50156003)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 00:49:54.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce173449-692a-458f-4f70-08d9e51cc316
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5684
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


We are still waiting for your feedback and guidance on this. Could you 
take a look?


Thanks,

Lizhi

On 1/25/22 9:48 PM, Lizhi Hou wrote:
> Hello,
>
> Xilinx Alveo PCIe accelerator cards use flattened device tree to describe
> HW subsystems or endpoints. Each device tree node represents a hardware
> endpoint and each endpoint is an hardware unit which requires a driver.
> The product detail:
>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>
> The feedback from the previous patches was to create a base tree if there
> is not one and apply the unflattened device nodes by existing Linux
> platform device and OF infrastructure. Please refer to previous discussion
> with device tree and fpga maintainers.
>      https://lore.kernel.org/lkml/CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com/
>      https://lore.kernel.org/lkml/20220105225013.1567871-1-lizhi.hou@xilinx.com/
>
> This patch adds OF_EMPTY_ROOT config. When it is selected and there is not
> a device tree, create an empty device tree root node.
>
> Lizhi Hou (1):
>    of: create empty of root
>
>   drivers/of/Kconfig         |  3 +++
>   drivers/of/Makefile        |  1 +
>   drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 55 insertions(+)
>   create mode 100644 drivers/of/of_empty_root.c
>
