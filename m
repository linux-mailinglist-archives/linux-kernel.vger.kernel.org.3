Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B7473538
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbhLMTqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:46:39 -0500
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:42464
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241212AbhLMTqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:46:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9hZQxGkmL4yOD9itwLnrIKBGrRkA8h2uFn/u96zn8GpLHjERe4B8wLlbOAeYB7DxH6UWioJG7EVQWk+2xIQE3GK3t3ppcsrPn2XaCKh8IY5NeQNA2uVMcimssCZeyLqpVVG7PxoSerGBAf84mn4fVs7OeFHEp2vUGcsO2dAJRYl5GAeMwGgzZ5/gOjD3IOM3DbtNw+i8RfZcZD5bIm2YAJWJukkAHTS7zTn/WukZ3OeZNBdaSvjgHv66/+I2PbmOfOWiMwE5EJRvatjSDiudWgagzI+UVnWS0CWnJPewouz+F7JJYsjAfDRsxGmDnkdy51XvB6wtrlUP6arQuO2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JORq3If8AdkvCttbEui86Ri8MQomeMAGz13LMQXY+8k=;
 b=bqP9+8gY9YowPJeBRC78/6Je2rSOUqtMmTgFF0901dwxPftLBRNt4pHpGip9RouGAXlFFLBs69lzvMsGZTUcdunCW/nqHrU1Fti7i6iKZ82EH5oCNLH1QIFZsYNIXZPuXk81R/pT/Przn9mngN2WsAEAQaQSl3bQZf2ljjtgiRkSSZNlTCSq7tIGObkVzJDhPvqZFIxlk4LVVjnSHtVxiYYxKSjcJffO74IgKqc/TSd6iPzjxY8KDGu3mwO/jj13ejVyMv53pP3dW+j9UmhOxhDW0uzYoSh1ypphExOzbbehaPAclCgC+SkBt79g1aN9F6JN9TCSaAvpDp7DWorzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=metafoo.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JORq3If8AdkvCttbEui86Ri8MQomeMAGz13LMQXY+8k=;
 b=Z0wUKgY10OQytkNzOhv48lfOzRhyersao8bRgptfmmgPrprxi9T9eX3pBQGvjLnEWOsWqG6qSvEtMSf5ivU/uQNb7ujIuu7I7yL0kdj4S+pzFXlXSNo0t1zRXHTXW4AD8q/SnszavVycfdZNDBwXaV/TLn0kmlw4B3vmYgXdB88=
Received: from DM6PR07CA0049.namprd07.prod.outlook.com (2603:10b6:5:74::26) by
 SA0PR02MB7145.namprd02.prod.outlook.com (2603:10b6:806:e2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Mon, 13 Dec 2021 19:46:35 +0000
Received: from DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::c4) by DM6PR07CA0049.outlook.office365.com
 (2603:10b6:5:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 19:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT009.mail.protection.outlook.com (10.13.5.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 19:46:34 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Dec 2021 19:46:33 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Dec 2021 19:46:33 +0000
Envelope-to: michal.simek@xilinx.com,
 ben.levinsky@xilinx.com,
 sergei.korneichuk@xilinx.com,
 lars@metafoo.de,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.71.116.145] (port=54116)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1mwrHM-0007C9-So; Mon, 13 Dec 2021 19:46:33 +0000
Message-ID: <a8505570-6d9f-bd56-e98c-e25ea17a8670@xilinx.com>
Date:   Tue, 14 Dec 2021 01:16:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        "Sergei Korneichuk" <sergei.korneichuk@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
 <ab9e009a-5e35-ae49-2c8e-65be6ba36d7f@metafoo.de>
 <acbd7749-7bb2-0de2-5658-2b62ace9520a@xilinx.com>
 <b8b24b65-786b-2a4e-5548-5e5e8bf988be@metafoo.de>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <b8b24b65-786b-2a4e-5548-5e5e8bf988be@metafoo.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ead425-2747-4e10-a7a9-08d9be71451b
X-MS-TrafficTypeDiagnostic: SA0PR02MB7145:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB71459807DABA0DDF48CD59B2CA749@SA0PR02MB7145.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkJBLmamBOXXGP76HaoAk0s9ZjcnbkYJSuG8o5xne2Q/uDqW0fFKDTgICtqxuLe7q7081W7SQPsagM+ZzBnR7FFzMMHHyGoc3RABS1/Pwr7P2+9w3Fp5enus+y8JZGg7AL2fct+fv44G/R0CrJbiKl2mc4yTLokUkzqeDNl31PoOsQsSEXvP5jexGGSV6BczmaUCxRIX6Gfw+usjuv3A/8B8b+RPLyYyWAWgiw4aJEE5NUd2TjoCFufMCjxc+Oj6fROdFcbGYUaOueYPUFk1m77NwmQrI2Nxlm5x55T2BJEPySzezGnBhNAAGpBWhxW94RtjEKyNNe8NQC0GUDK5Z5m4oIaGklD7CrsDXaxquUpJAC9Nubj6f3WHmKNF05cYI6j+z0OXI039JfGwPol1rykW9XzKgehtsn0toyIM6USTQRrHk3REoVcUZ/yNimvD46l4/Tvumpfm3d+9vXzvZmWqk7gv8jRh5jIqGPCrwjh++1p0ePztdnOWc+JHyXmL7QL3Vphtoq3xY41/w3GPirU5dS3/Lzfz4Yrsk9e61LU6HGtPohAt9SdjEnSjymXJEKXmcksD1tpuRbLsSYopwID1ZcZjIfW7+EIWtauYrDf97ZWzhSN4RmZYpj1cU8PC2J8MnEycvXM0Xs74G74O49Gz4idBnqc7z7a8PH15r+GYfg88P3FN86vD7zp8B7w72yQbHqtssC+dhlocfvreKDsoZ0RGbRHTx5uQGSmx2NNyO4uFcrzEeb+KuPyeF/UOpndwCGsy6qNBI8BOG4aVHwsIdTbRIhamX8LjR9mhvZfo3uagonLog6daOjG18wx21tjo7VkhXmr+dlm7zJjkdN7PabrLm/BhxPtzmHg1F9c=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(356005)(966005)(70586007)(508600001)(31696002)(53546011)(4326008)(9786002)(82310400004)(5660300002)(7636003)(36860700001)(83380400001)(2906002)(6666004)(44832011)(7416002)(186003)(31686004)(26005)(4744005)(426003)(8676002)(336012)(2616005)(6636002)(316002)(110136005)(47076005)(54906003)(70206006)(36756003)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:46:34.7470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ead425-2747-4e10-a7a9-08d9be71451b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/21 1:13 AM, Lars-Peter Clausen wrote:
> On 12/13/21 8:31 PM, Tanmay Shah wrote:
>>>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> [...]
>>>> +
>>>>
>>>> +    i = 0;
>>>> +    for_each_available_child_of_node(dev_node, child) {
>>>> +        child_pdev = of_find_device_by_node(child);
>>>> +        if (!child_pdev)
>>> A return or a break in a for_each_available_child_of_node() will 
>>> leak the reference to the child node.
>>
>> Do you mean I have to use of_put_node for each child?
>
> You have to put a `of_put_node(child)` before each break or return in 
> the loop.
>
> If you search the kernel commit history for 
> for_each_available_child_of_node or for_each_child_of_node you'll find 
> many fixes for similar problems. For example 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1b391e9712db
>
I got it. Same concern was posted by Mathieu also. I will address these 
comments in next revision.

Thanks,

Tanmay

