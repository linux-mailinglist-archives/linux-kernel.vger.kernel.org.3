Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759A55FF28
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiF2L7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiF2L7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:59:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE13F8A0;
        Wed, 29 Jun 2022 04:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0+m6mQOLAvXheaQbCaudalxSveHVuulN2S5je6jzXbOI0GhsdcflplUTnVQ6dzwBYSaX/byQhzY2vzDZEmb8PaWIfnGKPUCCJRuPIgakNwIP7F3D2mLB/L0E0Ah4vi3LtpCclQsJ+eHCLkoBUfIe+qCEpn4tuhbyVogqDNr82r7S66XrKQ2vhC51LqnPiHTvvIPTef2RjmXrvzA+Ot2+7p/Edn3qvKW9jvVRst4Hi7+Ymo5AQ0OFvEemrTFX0UMRmiPrv5KIiGv0nmmVzfY7lBYtv0Z8GSOBylBAr0tylnaCt1WIhN4vBMgr1ohO31kkCaZWfasz3Tsdw3iYfhTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCKDhIH3rvpUkw/ouHPGTcSnLxYvPdXYmDepkmNbSQw=;
 b=C2tHFfAIhongEqYdCz6t8qNevqg0Ixx05WL8qkM/WhoEYV9Jzj1ksBE5ErnalGvl3u37eUTWRWxjsJ/IHrWzN1adfBmdqKDpWbarA7260YQEq7VzqOTHlfvcH7PWkJGx3IwnDpab2WQLrUvvVwCA18zmfe/tuQjWf+PM6aueWUli6IWfbQH6Dz1G4EZEqKAQlDMTy9XSCfiw93eZrGJk4Yg3fKTBk9iLWvTZnGKADK1dBXq1HHqpfXTsARINDboQ3XNV6cnA7iO4liGaItMEB+/3OXJWsRHkpmXfIDZXBExHj6aghJPs5F/K+NjkM8Gy0oKOVbVXU3byykPxdKBbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCKDhIH3rvpUkw/ouHPGTcSnLxYvPdXYmDepkmNbSQw=;
 b=DlaSveI+kBky8ARQF0BqDXBsrcsB9pZaL++V2VtoDn8ovuWfcauc+4/YH4V92kE2cn7flLlHmKwrY+Xgho+pn8e4FnNVetAAg/exYCbdQhLS/eE66Tk+MgVksL6/mAERD4hJ5zxfJek8X6+t3MOF4yFduWHTaT/7Ly/xk1VqjbE=
Received: from BN9PR03CA0983.namprd03.prod.outlook.com (2603:10b6:408:109::28)
 by DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 11:59:39 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::99) by BN9PR03CA0983.outlook.office365.com
 (2603:10b6:408:109::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 11:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 11:59:39 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 06:59:34 -0500
Message-ID: <a653cb16-4aa9-693a-ac32-cc7b1b999b92@amd.com>
Date:   Wed, 29 Jun 2022 13:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <git@amd.com>, <git@xilinx.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
 <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
 <6f5a1b1e-b484-3a15-00be-2c1ddc09468e@amd.com>
 <e43bede7-2a0a-5114-e9ec-9e1449bf4e47@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <e43bede7-2a0a-5114-e9ec-9e1449bf4e47@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb7f97d-dec7-465e-2450-08da59c6d897
X-MS-TrafficTypeDiagnostic: DM6PR12MB4864:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mM8KL8ZWcUJ7qJzECM4ou1a7OMJ8BebHtOf5PC2zNqRVNj6xGfVEdVuSvNx+KhYkTz6yzMWtRS8lJi/xy6tVb4r7oTYHN89Grdnh5yTcFz9WfU2QgdmaEQKxLuF+v8Pztk1R+IVEG8rPDNU90v1qTsSZbfks/yGU1VELGSzxpN6VDCQ4dfRNp1/Y90ZEqN23wpE5X0/5EQmcL2TOz2Hb/MBp/aPc+r/NQwmJN9xLLpaX2hEAHfYQkpkOcyQvDDcBQNto1T0jaF37AuWJMIvPtMqrf1ozIowdEB9lr2Cbc4JYXDIUSyHqp5XyDdq+Y4CffUqGnivUIrtD2JnZ23mM+B5abO3AlOubboCMvb5IU54SVpAaDH62MhPn641a2kj+blTPHL9/5Gd5dFozNd0Ia/b1quy2HcFIcnoQ5hWpZuJ8IAwcczCQahYkPqVuMSI5wr+1PG7tIe0vaijorBF0w3qq3j3z2FrbQaIjkxMtTWr6VwXsBFNDfFkhPURuJJCQBRGnbkQ+yYEeJ71Vgc6X4QzyPqs+WnW95SH5ySE9Ubc0sXlkYhGfk41lUxqkTkKSLTpkarFJW1WnL3oNvUa9EDB+hiedqcAIau1cRsV/A6Ei9Stpm9qiE+5AzG8tHpAowkzcRan13xoJh+vBTIouCp6sNl3PjwhJjPbX1/qZqZf2xY0cp+K79ZZIJM8bRb8cScnuyj0tUjYg/kABPz5ASt7S05LpnEMgaEAlZhcZxAviESNjzg3SqpXlb83GJR1dqiWt5ZrYTgT+otHm/7lF/otVRBJ/nDrGboN8zk0EHaH9Le4pwmiwfgHDLhwTLVSBQBytst4qcmK0UpcRfqhJZx9qNdiygVglUoumiTcDLx3mRrjj2gYKxfajAP/g6ppbtzHdEXTUplXHO1GJ+EnBtxajElohNwDlLmqt/oJU4to=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(36860700001)(31696002)(86362001)(41300700001)(82310400005)(40460700003)(8936002)(5660300002)(44832011)(478600001)(2906002)(966005)(70206006)(186003)(70586007)(53546011)(54906003)(4326008)(426003)(47076005)(336012)(356005)(921005)(8676002)(16526019)(36756003)(107886003)(2616005)(31686004)(110136005)(81166007)(83380400001)(26005)(40480700001)(82740400003)(316002)(16576012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 11:59:39.7902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb7f97d-dec7-465e-2450-08da59c6d897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/22 13:45, Krzysztof Kozlowski wrote:
> On 29/06/2022 13:23, Michal Simek wrote:
>>
>>
>> On 6/29/22 12:07, Krzysztof Kozlowski wrote:
>>> On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:
>>>> This commit adds documentation for Triple Modular Redundancy(TMR) Manager
>>>> IP. The Triple Modular Redundancy(TMR) Manager is responsible for handling
>>>> the TMR subsystem state, including fault detection and error recovery
>>>> provides soft error detection, correction and recovery features.
>>>>
>>>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>>> ---
>>>>    .../bindings/misc/xlnx,tmr-manager.yaml       | 48 +++++++++++++++++++
>>>
>>> This is not a misc device. Find appropriate subsystem for it. It's not
>>> EDAC, right?
>>
>> We were thinking where to put it but it is not EDAC driver.
>> If you have better suggestion for subsystem please let us know.
> 
> I don't know what's the device about. The description does not help:
> 
> "TMR Manager is responsible for TMR subsystem state..."

ok. let's improve commit message in v2.

TMR - triple module redundancy.

You design the system with one CPU which is default microblaze configuration 
with interrupt controller, timer and other IPs.

And then say I want to do it triple redundant with all that voting, etc.
If you want to get all details you can take a look at this guide

https://www.xilinx.com/content/dam/xilinx/support/documents/ip_documentation/tmr/v1_0/pg268-tmr.pdf

In short TMR manager is servicing all that 3 cores and making sure that they are 
all running in sync. If not it has capability recover the system. It means cpu 
gets to break handler (it is the part of microblaze series) and it restarts all 
cpus.

And TMR inject driver is module which is capable to inject error to internal 
memory to cause the exception to exercise that recovery code.

Kedar: Feel free to correct me or add more details.

Thanks,
Michal
