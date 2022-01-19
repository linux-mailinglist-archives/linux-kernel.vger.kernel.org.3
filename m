Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A134936B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352688AbiASI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:59:04 -0500
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:33836
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352325AbiASI7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:59:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdJ1siKktAzVQubfwYsLTrV8H0ACLbGJxXbUKu6p0o0Zk5HpCvew6h3Jw0PtZnIqX9qAPA/m9Nlbtp2MH3WiDZDdGIifFvyC4tQ+9x3OdlzlTF+AWNyN66n6kQFKEf6aiQ62yymxG9ZsZJarnbloS/vXtwbOy2MfeN+MmpeJQBe/NZeTYdaE4tzlI66sSG6nRK3nk1AuMyRGoUUbjsDo3yrX2IHkqQFJfYAOkdOO7kBq9LW1hQnE1UVLghmmOMJg7QCzXATVff1Ee8cpv3Pr7MtF8Hxynso/c+lq2BuByidNJQ0Z6tOokHP4wZALcBGwR0TAqS+Vcg2N9AWbbKtlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGW/9XR345TxH21O4OrzAr/voxN8PJ/cVIKBkcJ8MWM=;
 b=eGq1kGuyDE/1TjZuH5cOenBRKEPVwueNf6mhBsAWPQZ0VewYucRyBw77zVCXiKhw62aUd0maJAf44oXKfaLytePVVaEKHGc1uTQDXOCQcDo+B3tgBf9xRbbJc1InyMEYnb/6DBMjcBcRQWAiy11aX8hyIkLFcblIc5YtDvKwgQbuBqmc1UwqlodhiMNKp9gu/DXrDTI4Xz4DtdERXNV18l0m+bBNRr41ixZ4QkpjmaPkDiYxsf4yRMOdZZ9EwnflnDuhGBbN2i4cLhEkY7Y2PLqXrE8rnMdZWkjqdUsOV7/ghsL5OLhOVN9guHvqzQkSq/68HwVwMxz0iOKXsmFg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGW/9XR345TxH21O4OrzAr/voxN8PJ/cVIKBkcJ8MWM=;
 b=hwolvlIS6CXBwo6MgE5D/QxBZ9zD887lOKPNUQSo8IDa8zFsYBeSd4HaZZEZye6z6RYLA45JHrfciCBO5XjSKgNj0cN7xvAtWbnA68pHklsZWGj6bcHFj4pRy8m3PhVxJ/M9q5+P9+Vk9lXbpqR4fpe3c8DO72fKzGsQ6wLS2VeJkBnLK/peCTJx6rnLgR6oasQ0t8HF6iexMrDVoqXcwil3tM5Z2ZP/0RFL7TnTScA/UqMq49+KRM0U0vCXxF9MDs2J4oAKtRbzwWvgX2r6K2l8P1ES2U78oBceos+xZND+cAieRKiKDfWTrodwrqxTQ4qNVZEKVomQxODogmPbTQ==
Received: from MW4PR03CA0236.namprd03.prod.outlook.com (2603:10b6:303:b9::31)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 19 Jan
 2022 08:58:57 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::70) by MW4PR03CA0236.outlook.office365.com
 (2603:10b6:303:b9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 08:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:58:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 19 Jan
 2022 08:58:56 +0000
Received: from [10.25.78.231] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 19 Jan 2022
 00:58:52 -0800
Message-ID: <33a31c71-2e74-5a62-2b78-6134319a304f@nvidia.com>
Date:   Wed, 19 Jan 2022 14:28:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
 <e10bffa7-3b6d-fb21-583a-1a3f907ff6b9@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <e10bffa7-3b6d-fb21-583a-1a3f907ff6b9@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72cad90-18d2-4e08-6977-08d9db29ed3c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5492:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54921BA273AADB054C6FF768CA599@CO6PR12MB5492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0r9z2tTM8BSSo2ipTayqivGGDNAahzFdIj3vvnvFSzG6ddxoS01NIO+OrxmZrswE5+kEE2qNabRNbZzb5S8zONjHwXCKxqefCiXYR5cukQUq+dX5A91cFUCgxrPcuq7FyrW1ikK4wzTfF241h9pU4VkEMwIHL9nS4Ug8YzAO/Q/ygM3YN6x9VRPnHOnMmj+CNXiaYZKhPixdksG6Ip7ySHQ3XKxk7MNEMCknjMEJm2ph4K42xHMc8jHqBte1QFa/+suXiAFdFsJxaGqtWcyM5cD79Yi0YwwJ6Ii1jc77ljX0lF5yJykIbW35I9HFqui4DAZ6esmVRN6LhMyqrXIZOzapSF4KgxIt3TIbqQzxa6XiEndVidc2OO4KpsmjKyTokz95+ZZNVLhiyNjD3Ju3lMPk5XiXeMd+c2k2lXn4T90If6EM5DN+ecF56vwJO2lswP2puxBbE5u15uEchEgk4feVaoscWF4AF7I5Tzmdekn7lixVRpVz87g77jlwIrzRiLneggUUH0h0bETyrCNBY5iUGHW4p1WZOghNvTUPTfhj/5a0iXG9GdXpbXjkhYBgUrZK4JBfqX6hZDecBe2TgQhwD9BlYPjMk4pPVQ0ilp4sPlww+gruILp4QpDM3ZWjn8bAb65MFggDBBCm7hDphivqOUjlJkvfzUqledIK8DBbtvL0X0pqufqI0ixapzQ3fJKmRzu2fcckPhE8B+/caE1KM+h3Aoq/swyXLluNDPZW6MJynHMfQp+aTDXbpvdiOT2cKYwNLwvs7LbTp0G4Va6RQNQo7hc3/np3lr3YDmKW8iR+y+lzdgmplnFuEns2fCIajAhzUu1za9/JIEHDLw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(356005)(8676002)(40460700001)(107886003)(54906003)(47076005)(426003)(2616005)(4326008)(36756003)(6666004)(70206006)(53546011)(8936002)(16576012)(336012)(86362001)(31696002)(5660300002)(70586007)(31686004)(81166007)(508600001)(36860700001)(16526019)(2906002)(110136005)(186003)(316002)(26005)(82310400004)(83380400001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:58:56.8999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72cad90-18d2-4e08-6977-08d9db29ed3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2022 4:32 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 11.01.2022 21:45, Ashish Mhetre пишет:
>> +static const struct tegra_mc_error int_mc_errors[] = {
>> +     {
>> +             .int_bit = MC_INT_DECERR_EMEM,
>> +             .msg = "EMEM address decode error",
>> +             .status_reg = MC_ERR_STATUS,
>> +             .addr_reg = MC_ERR_ADR,
>> +     },
>> +     {
>> +             .int_bit = MC_INT_SECURITY_VIOLATION,
>> +             .msg = "non secure access to secure region",
>> +             .status_reg = MC_ERR_STATUS,
>> +             .addr_reg = MC_ERR_ADR,
>> +     },
>> +     {
>> +             .int_bit = MC_INT_DECERR_VPR,
>> +             .msg = "MC request violates VPR requirements",
>> +             .status_reg = MC_ERR_VPR_STATUS,
>> +             .addr_reg = MC_ERR_VPR_ADR,
>> +     },
>> +     {
>> +             .int_bit = MC_INT_SECERR_SEC,
>> +             .msg = "MC request violated SEC carveout requirements",
>> +             .status_reg = MC_ERR_SEC_STATUS,
>> +             .addr_reg = MC_ERR_SEC_ADR,
>> +     },
>> +     {
>> +             .int_bit = MC_INT_DECERR_MTS,
>> +             .msg = "MTS carveout access violation",
>> +             .status_reg = MC_ERR_MTS_STATUS,
>> +             .addr_reg = MC_ERR_MTS_ADR,
>> +     },
>> +     {
>> +             .int_bit = MC_INT_DECERR_GENERALIZED_CARVEOUT,
>> +             .msg = "GSC access violation",
>> +             .status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS,
>> +             .addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR,
>> +     },
>> +};
>> +
>> +static irqreturn_t tegra186_mc_handle_irq(int irq, void *data)
>> +{
>> +     struct tegra_mc *mc = data;
>> +     unsigned long status;
>> +     unsigned int bit;
>> +
>> +     status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
>> +     if (!status)
>> +             return IRQ_NONE;
>> +
>> +     for_each_set_bit(bit, &status, 32) {
>> +             const char *error = int_mc_errors[bit].msg ?: "unknown";
> 
> int_mc_errors[bit] isn't what you need and .int_bit is unused, which
> suggests that all this code doesn't work and was untested. Please don't
> send untested patches.
Yes, my bad. I will update this in next patch.
Actually I made sure that the patches build without errors and also made
sure that they does not break anything. As for reproducing each of these
memory controller errors, I agree that I haven't done that.
