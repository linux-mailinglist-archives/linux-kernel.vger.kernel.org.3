Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87453301C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiEXSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiEXSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:09:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397026B09B;
        Tue, 24 May 2022 11:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Q2v4tOwGW2d76P1lFxFf0b+ZX8ilcNAVVRmWS9BObDvUhRAsmaDbdZ78DtkQoXLaU1Tl4QUTY1MLAJp2xZOa2ND3S1IEEoBa18rM4d1lTY2CyaoBqJG7idSr9VZ7f89S3iXFBB0b+mKl7+mUa9lWQ2gObGBi1GvTjs2G3DdCIFeSjOkWxebIfMsmHzoKC2T6WXytijkuFbbdEw0y2Hr60BcDpVW6qj4+HZEIWNOiu7LIwjEy5Vd0sLgWa4b2XqmV27nalM7lRt93VgMNgBJ511M+rm/zHSBcaZ0kN3fgDZT808A2fHBuiYR5faTIkI4Ch7C3lNslkoLra53gR0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEo4fxKPxAxhQDXaa90LCmjmokvxxgdk1UFNmvioJqY=;
 b=miKz5TxFDSMPude5DCcCSC4B6TQ1DeI2etz7/YmpiawxfLDERgC4pnL3iaW0CM5LtnT8H/4OjBtOwAqlb6k54fRFzVk4vsQqLXpraekb6yqKDozhfhM0G/cZw7ssKdeWq/sFowS6QbJGssBOGVb7gARoQeFDlPGYhtTFjSLGFCrjHl6LNrRm+AkISKYN9kvY6WhWiae49Qn+UaazVsV4Er9tx6BW9s00hMqjLAu9q2i2kd8poeyGM4vL3qUaEX9gmW03LjeriE5P/QEdgOSFy8gLcon8twhBjNLgt7Uued1HNpcatS0T/HThfuXPcNvDK/Q8FmfL9vdlisxXNJIq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEo4fxKPxAxhQDXaa90LCmjmokvxxgdk1UFNmvioJqY=;
 b=cO5WqzL14bsoE1GFabhovIJMLJD7XE/XBTdF/zYnNFy89d5n+hbXGwyFxPgpskALEMeVvjMDUHEEN88q6HwDuh3jABcD/G+f+NAB9wfSgYli55rDxGme7dr66p8QGeFW53wKX8GC0Q1U9IJ7hye39/unA66vRQLZfqq3eX/2XUk=
Received: from DS7PR07CA0017.namprd07.prod.outlook.com (2603:10b6:5:3af::14)
 by DM6PR02MB4331.namprd02.prod.outlook.com (2603:10b6:5:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 18:09:54 +0000
Received: from DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::85) by DS7PR07CA0017.outlook.office365.com
 (2603:10b6:5:3af::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Tue, 24 May 2022 18:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT020.mail.protection.outlook.com (10.13.4.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 18:09:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 11:09:50 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 11:09:50 -0700
Envelope-to: krzysztof.kozlowski@linaro.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.23.123.15] (port=51136)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1ntYyc-0001ek-Lh; Tue, 24 May 2022 11:09:50 -0700
Message-ID: <266f4fe2-e8b8-24f2-085d-fcdb87f90731@xilinx.com>
Date:   Tue, 24 May 2022 11:09:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
 <20220518194426.3784095-2-tanmay.shah@xilinx.com>
 <45fea4a1-387f-9684-a90b-58b695b54172@linaro.org>
 <c97d61b0-8a38-5054-d5f1-bc7c5e7bcf61@xilinx.com>
 <1b117e49-28d0-da75-68ee-c2fcef9fc9a9@linaro.org>
 <c7b248f4-9ec1-2ae8-c7e3-55f37592f56e@xilinx.com>
 <014a6c1c-2795-f066-f103-9a97afc35da7@linaro.org>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <014a6c1c-2795-f066-f103-9a97afc35da7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4678abb-5933-4b01-121f-08da3db09ad6
X-MS-TrafficTypeDiagnostic: DM6PR02MB4331:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4331A90CD8DD9DD543AE95F8CAD79@DM6PR02MB4331.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M4pL3lgWMp1Cb0FKsXYyhGZ69l4aa2oyxz0nGcLxuiRC4bfyIg7uHJg4KV7pNUU/C4OgILUdpOa7huY8Gtx0LcAqb2aNkZqgV59kkh5QlS/TvuLapcZtWztVU7owVOngq8YioEjTIUnzIrJP+cayYf0lW70RpC17YWdQoQq+eyDc6v3Njz7zrYWGsPFrWMP3USBxmAKYFBi57ixQSX4TamUNr7zHN62zSFSEXltmuWEmMNuVJi13+YmM/5HnzrjWk15bRQUTq4f2QjwHbqNZYEMuiR9R0596l9rY1/EY4YracZNQOOWQOIjjupFfFZzoAzAudOWX67G1YYSqzfFoXhlfiYcXtkhnrT/82tymho0WTRgw9uS+MIEvI2Gcxteet8MPEYJixE3BwzzP8s5IYbm/cM2Vw+WMY/ArDf/BGY0mbPpcJx8WXOzlFRTrnoi2j2P2pxK7/HMpHXqcXmUKoJYT9hi/5tWhAtC60CE0cd1DFnWVapEzDwUptfFULqcXgnE1jWTZ0lPvfc/WcDoCvyGGYpGlKxfDvBbbd3eAO58RGeaQnpVOK+lNgCIIYBnOq5q3Q8QgbvBD4EjX3J6UijBoJ2X8/zY+m6G/n2mdAJ1YHtZmvsazg/p5rtKJIwZP0V6wydwMrmF7Eq55et0Oa0efSj7AAEc0r96b5vhkCfy6iY3sxKMSOYxcarL9h9RFSu+6f/VXUeaUJlFKbQNZd7D2KsoQ8KgJf9G5XpVAQA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(40460700003)(508600001)(5660300002)(44832011)(4326008)(426003)(336012)(47076005)(9786002)(70586007)(70206006)(8676002)(54906003)(316002)(186003)(6636002)(36860700001)(4744005)(31696002)(110136005)(82310400005)(26005)(36756003)(7636003)(356005)(2906002)(31686004)(2616005)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 18:09:54.6668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4678abb-5933-4b01-121f-08da3db09ad6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4331
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 10:28 AM, Krzysztof Kozlowski wrote:
> On 24/05/2022 17:43, Tanmay Shah wrote:
>> With this, I will add 'maxItems: 8' in sram and memory-region properties.
>>
>> If everything else looks good on schema in this revision, could you
>> please also review next (dts) patch in this series?
>>
>> If that looks good, can I get your 'rb' on that?
>>
>> so we can reduce scope of reviews for next revisions?
> There is no need to resend after receiving a tag, so the amount of
> reviews/versions won't change.

Ok. So, is it fine if I send new revision once dts patch is reviewed.

That way I can take care of any fixes in dts patch along with bindings 
in next version.

>
> Best regards,
> Krzysztof
