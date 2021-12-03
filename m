Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807AC46781B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352410AbhLCNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:25:14 -0500
Received: from mail-mw2nam08on2083.outbound.protection.outlook.com ([40.107.101.83]:51521
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232181AbhLCNZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:25:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3IL0AZPPaavI5WOmsf4Kk0EQ+u1/6tn45CbLR0E8dj7tNbVdPApDxfzHFYYHBUxXELdULS4t50POajxnmeLw9p/dSPkzIUDq4FU3SX8rnzdUpmgHBRjoo1KAv1xBAfEQd1766gx3eQODYyI9nfxO273Rz/fhZLYrlEoGJ70xRG4HP1SA9wABWPG4VFq9JXes1z6iJbcF/P0qbn2espl5OHjfU/S2potnnIGQXwhk7Il10sYigxmfdej7HMRC4ORG98dGayXmCPvwoT12Ym55624ZYldbfAPDtc+A5Fsa4ZkdSV4gruRfa19kuj5Qht6h6San4ypbwDYhmeRHd1aJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUJcwwZur5XRQOn7g2bVdZpC42dS+Ps0RRogs5/qpv4=;
 b=UrfrMR34PiwiBdxZZ9+9FnnPJP70cLZ2L2Lo/B6CYJiqhM14aGupoczf3K591gj+XNaWhFksym8DQcQ52gPf0f2muzQW69Xs4ikLD59jzIa3atfxYusdk6I+sJJnR0HxiLrwliCPLz9gPlvyTsAzeEbu7ZmtxCrA01l2B/sfEQYS+KtHQpkUhqFI+cXqNMGYoizLs/qjNiYscFQ0V8QNptwrm995g4RFV0v8ecFVLF4yHXvMqTx3v0aP6p0llZQ2W9WK5r1C6DOiPR5nvHbiby+HDWXvg0Jqs89DpynlBwEI+2ClWL21tQ94Vz0y2LfvJ9+71aEM+kMddaeISWjIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUJcwwZur5XRQOn7g2bVdZpC42dS+Ps0RRogs5/qpv4=;
 b=YgBoHa8Sql4+s55rQeYjaSUALcpy5pCRMwu/YMAP/EgXaQFCCfIuBK2Ycuc5Q9aI1qDCv+K4dRKLK1A9bc3MuTUeVQaDcCjSG/78RI2ybRAJmvaHIxlhApFjesVeGwiHEnLNSG85RdBQqxiYdus5CFUdKeK6wXcLkRvK1JpMBjQ=
Received: from BN1PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:e1::30)
 by BL0PR02MB3684.namprd02.prod.outlook.com (2603:10b6:207:44::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 3 Dec
 2021 13:21:41 +0000
Received: from BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::cb) by BN1PR12CA0025.outlook.office365.com
 (2603:10b6:408:e1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 13:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT007.mail.protection.outlook.com (10.13.3.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 13:21:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 05:21:40 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 05:21:40 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.254.241.49] (port=41274)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mt8VQ-0009c1-3C; Fri, 03 Dec 2021 05:21:40 -0800
Message-ID: <6887f803-f929-a483-c15d-759ec345e219@xilinx.com>
Date:   Fri, 3 Dec 2021 14:21:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 4/6] arm64: dts: zynqmp: Add Xilinx SHA3 node
Content-Language: en-US
To:     Harsha <harsha.harsha@xilinx.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>
References: <1638213623-32613-1-git-send-email-harsha.harsha@xilinx.com>
 <1638213623-32613-5-git-send-email-harsha.harsha@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1638213623-32613-5-git-send-email-harsha.harsha@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fda94a1-53ed-44a8-da4c-08d9b65fd7ec
X-MS-TrafficTypeDiagnostic: BL0PR02MB3684:
X-Microsoft-Antispam-PRVS: <BL0PR02MB3684479782647B8279092127C66A9@BL0PR02MB3684.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0CWSWoKwbWAGfNZ1fcRPudkNzqzgsemKUYQf7sVaMkkhz6wh0c1geeirz9gxjmgWy04wxFPbLEyi9YtElVWXEABh35hqDBOl8kebZdkA9QtmoQj3MpMc0J/9WnrENyc3J9o8QHlmLQPs260IA1OBBXB9cpn1Pu+03nBGcONlzmdhKhKD9sr/6ZDJNCr73bdUQt85bYNmRAXFIE5sySiz7akcIG4YVrOj/hwOG5qCEE4nOaSapMrrsu77aHL3RRQ0PijYhzyD0LUwPQxCn8TYY2wKUY6ZRJBH9SEdW4wsrsAUqMxiMHVnBc9e1ZrmSDPZUJFf1vcUK5+tPy5FKTUECvA6RElRQAf0l4LD37+RLZDWFHA8ZcoDRHVgJu12Bt5gvmlyTqDoCbw3aeJ1eXgoZj26Pc3+MNL+BNld2qkMhjSj4uzwvWp5g7T9RVgqNcXmaTpdOg4ZZhqcjUgX3thXcrxh0rdBYwSyH4mo36FWBx0g0ekJZ9ta/4BzKN4sx8Po1WK3a+JudNAkKQB4YbAYY7ioE96eBTG/ZlZdt8Ka5rSGTPuuMc33wOK7MBodZxIeDN3jc3Gw/yJ64OI86xoDSuts9WY+02U+YoYjh0SYwU0SXvJTpUHeF3g7Qelbhq7rx4t96brbN3gRkOQZIfeVkia+v5i3lmf0ThHL7FkB5w+hZrVQb4vrbMZYtg+fLhbBtw0W83gzUZKFug9BQTfMe+V+7tgaMdEty0MRU6NUTvMoxURFueHarZjrix6vh2lfhNMRCYXpjft1sYTYxN2yFb33+bjZ07XZ4BYMw6cKnI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36860700001)(8936002)(508600001)(53546011)(6666004)(36756003)(2906002)(4326008)(54906003)(44832011)(356005)(110136005)(9786002)(316002)(7636003)(4744005)(82310400004)(107886003)(70586007)(47076005)(336012)(31696002)(2616005)(31686004)(5660300002)(26005)(426003)(8676002)(70206006)(186003)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 13:21:40.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fda94a1-53ed-44a8-da4c-08d9b65fd7ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3684
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/21 20:20, Harsha wrote:
> This patch adds a SHA3 DT node for Xilinx ZynqMP SoC.
> 
> Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 74e6644..33b7ef6 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -174,6 +174,10 @@
>   				compatible = "xlnx,zynqmp-aes";
>   			};
>   
> +			xlnx_sha3_384: sha384 {
> +				compatible = "xlnx,zynqmp-sha3-384";
> +			};
> +
>   			zynqmp_reset: reset-controller {
>   				compatible = "xlnx,zynqmp-reset";
>   				#reset-cells = <1>;
> 

I will let Rob to comment this but I think this can be discovered and 
there is no need to link it with any device now. That's why maybe the 
whole dt binding is not needed at all.

Thanks,
Michal
