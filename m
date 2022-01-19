Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EBB493594
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352088AbiASHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:38:17 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:29536
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352070AbiASHiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:38:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahaQCaySE09m3eL6qgv4HaE3zmnN7KU+Rm1UhGjGXJJHoG47sFIwvEAFSWlTurpz8E7P/eKGY01/QU71Zeyc+oyPhNdD0vAlC6d9HSZWBnduuJS+Clq/Tm6IYdhmZzKHl0tEolSqcK7vaf1FsYl6uqcvwTPJM5woald9hmyuDAjF4Q/Z0QZpVKaSvM/8OGIxvO1Joqu5dCmKNaO3lpDCH0QelwMr2IQAMuFvZ6U4tXG4/gNVuIns1y7sNgcDFEg/FxP0Dzsp8Q+HNrhWH9P1EWB/9GPO/gmAkNfSQvOa/M+yMf22aBQQgn6X4LcOL9pMpXEktcz8RvktXHcSVAoq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvfZmg/c6Gbqq2vY26s987dhQ3HrH7gh9cQ7JFBl8WA=;
 b=nJ6QfKG4/YXd2Ycg+em+lorknDHTInTvt96Zj4BCNVfRZHBGUNbiGthd6fVLMGhpoCkAwpa5dQD6yL4g9ADf4DyzxAUOtSgaDGWTlTkiuqCp3PhcZKLp/5AvN4UaN52foWjtEVaJqot2Uc9AuxQQmKVPQbKe4+m4UuaA8VV1edlMGSWTs5pMzYKyVl4gZp+tuJtbML/bq5OKQwX4+1aOJddlgMQoOPLNWuUJFFZ4/Za54rDsTyBzPr/Zl0KbGjPdlyWtP8NXXSCRjiYOAbu2Rd3wUuRhaelAgHHAdsn5cWz2yxxgRIiiuz8V+hD7Vce+5fKB7pf1JKZbd/kUAZHXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvfZmg/c6Gbqq2vY26s987dhQ3HrH7gh9cQ7JFBl8WA=;
 b=Im/Rl+XzikP24uOUyWQo3TLyr4dYVph5C4XAm41+oouKdKwEcS7SA30/+jlRsuu9Pk/RTyp8hk/tRxJirjQTD91UN+GVqrp2FyS/uq6bOQsFNflpu8ieq5+MzQjwqHRrEbEUxVbQnJpnKX3wKcfOiX92GXE746lvNqP+qhoJdKrkenMVMmLe9ScsP3lUBetlihE72H2YsCGBxIaEH4fGOBgc0vGY2gQJ4LSM9A+0We9c49l8iIrHNmO30HbbMTHuRBTSzyf9yuDOcq0f7C0kVXU/WnjNFEe0491Om3qIUuvExxd73kchku7PizQbSyJn2Emytt+H5+RQob5m7lGo6w==
Received: from MWHPR2201CA0039.namprd22.prod.outlook.com
 (2603:10b6:301:16::13) by SN6PR12MB4670.namprd12.prod.outlook.com
 (2603:10b6:805:11::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 07:38:13 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::c2) by MWHPR2201CA0039.outlook.office365.com
 (2603:10b6:301:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 07:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 07:38:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 19 Jan
 2022 07:38:12 +0000
Received: from [10.25.78.231] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 18 Jan 2022
 23:38:09 -0800
Message-ID: <3ba51978-2aca-c2b4-e2b0-7e06db221618@nvidia.com>
Date:   Wed, 19 Jan 2022 13:08:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 2/4] memory: tegra: Add interrupt mask
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-3-git-send-email-amhetre@nvidia.com>
 <c78b8062-20a8-262c-99de-8c6b481584cd@canonical.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <c78b8062-20a8-262c-99de-8c6b481584cd@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9742c25d-0ef0-4178-ecc1-08d9db1ea5f2
X-MS-TrafficTypeDiagnostic: SN6PR12MB4670:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB46706C9B8577A16A3493CBF8CA599@SN6PR12MB4670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:192;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoE+jlcrIJoMa0WvU6Mphhxk6KpNZYc5qbUUdBz9bSiLqRX0KVxavwqhwdo4EWy0F3KsGYCOcM68bTVuFtxZv2h7J5mH+mOM7JG/cBukOJCse5NWcZ9S+IiBERVSfiFUh8SZTW+ad2ZntVSw08QUyD7eWOJGyMj1ORangukTKR0dNRPcax2XQYfatZGjZkI+PKDFzM7y4Azsr4hQ4WRohSgJdCbmjvEkBqrlzWARZyHXddlr9CTC9+i+towJUS0YbVjyjyclQqiCq0BamvyS2rYieiuoyPWtT8NphrzyYs+Rhd5uPIUVb817dDQri0Z6/lseQwoibAMbacjD0txmVE1/KqfsyuNI2G5OpWvxojD5MO8HwD2fGOvmkAqQ3aRTlMSwdPlYBB0XYa5DWnzOTW4z5ZvBMSsIRq3AVffk5EQPeftAZL1RRI9/krTz3KHJkFQF4FlJYb4s/ZGTfyJTBj5rClQJt283shFWNx+dmFQXgAdSQ+GJk17sBl0UnFTgrbQx4eQHPc7CTVoMJ7qPj+n8xepp0Qri/LQXBAHYROfQAlpFvRcnK9J0YMGspyoc2GSivS9W0ML2wPre5OJmlLKdE8HzfpPvaWd+CWr3sC9pHdoVQygyz4fpiWpDRP5cWtqZI1NleS0Bq+FTS+5g7ZGy0Mhu+jxv5rcNskqJ6affHK8WMN7QLq/t/QztNJwRWAhue/xluDggC2IfKGYg7wXErx4roNZz6HytB+BvB8wC+6DyF3u/1kichFqdJ0E82X1SnrKWlxm8wV7HxNx4W9ei1Ld0D3eEDmEHXOPWzku6tKur10doqiPsbMwqEG3MN/Q0E54r4SoS1evMxYDmjA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(4326008)(70586007)(6666004)(36860700001)(81166007)(40460700001)(8936002)(70206006)(356005)(107886003)(26005)(2906002)(31686004)(86362001)(83380400001)(54906003)(16576012)(316002)(110136005)(508600001)(53546011)(2616005)(47076005)(8676002)(426003)(336012)(82310400004)(5660300002)(4744005)(36756003)(186003)(31696002)(16526019)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:38:12.8048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9742c25d-0ef0-4178-ecc1-08d9db1ea5f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4670
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2022 2:02 AM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/01/2022 19:45, Ashish Mhetre wrote:
>> Add interrupt masks for all supported interrupts on tegra MCs.
>> Update interrupt mask value for T186 and T194 as per supported interrupts.
> 
> The commit subject is too generic. The commit description need to also
> describe why you are doing it and what you want achieve.
> 
> 
> 
> Best regards,
> Krzysztof
Sure, I'll update the commit message.
