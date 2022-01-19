Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28904936DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352831AbiASJJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:09:52 -0500
Received: from mail-sn1anam02on2076.outbound.protection.outlook.com ([40.107.96.76]:9281
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352482AbiASJJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:09:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHl53FuSkLTsFOlBpoMTwYmh8Fo7EebWWhJ6qXEGp28TwyAcPnunEJ8JSNC/m0nzxAMzf3RF5+a3A5rNgLu5pC2ztQDq0wVJCcs42sgZIdccCH1MwJZEHfD+Mmee36Mx/sC0kSFAGQDDC4199ig0BWidExyp/H01uopZ17Be+2WfdazayXXZLfAbA2YdOoF9Y43ujWObkaE3ZjV6oByrLb1A13QnPCzvNu8qsy1s4TG2/QyzJ9c6ZGp2zAzX3bllxTM8vYyLmj31KtDxO+MsPqFoA1rWU8utkioHrWKh4Fc4Wk2xTgOzxxXMjnpMh4NYBgIvFxrsRz6NViooA/z86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEKWSgbf2+ddrBpFS/5R+kr9iclmQ5MbXsLPrj/asCY=;
 b=SNuyfSdWgERvOChpeOI1bnLK00AOLetsVvjjBYzp1JPNbNv6IBzSVfNITDmH4Ua+18PcoVs3X1KgCG1Fx9TfGXyYkM/DIVklT1irjde5dye1tS/hs3vLBqhpAWXOeIZ4jD3BG/mUtL4VG/c70DOq3xwuUr3QzbsxgcyZr4i9ht6uoXyAajfXM8g4fs+fF/UCt5rx1VlGr7kJwZTqTO6rx6ZdqwzLG7xVlvANfrH94/HnkP9pDjuedk+2PZGdZzusbxbPQQDHEmsJ8WaRxnpkNpBaFqsbUSEtrOqFjMdYoBf/5A/dINqQ68MmUZ5+/prLHxDdR7G3q6Z/LKM0lWsYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEKWSgbf2+ddrBpFS/5R+kr9iclmQ5MbXsLPrj/asCY=;
 b=WkMboy4cBuFm2MvVDVljeWeM440zUksbBgcI9Oi8V3eqERfjqz1jnpYtgo7+AB+E9vGI6ovj5vfIGgPjRitO354xmU/NmgWsBWHy/OciRmho2PKDfAKrfsqUYCNIRfBqgpKuSCSrOLc5M7PhQSbG8N/xUgF2nL07H1JMPZTHxclupZqoxkTfVidxNdT2YveysS2D5lOfPVcxPvJaM0ckg/9PR3Q7fNS/+HIXgx23Epjs2mm6vwjCSWUOdcpbxii31fPDY2RpJWd8eeJSGOWQxKWMWZiX5SqdCXRntBBpH7iEfEZJXYqHjf+c1JUKdg124Kwm3cPvuDkHqlLfW/qOyw==
Received: from BN6PR19CA0086.namprd19.prod.outlook.com (2603:10b6:404:133::24)
 by BN6PR12MB1188.namprd12.prod.outlook.com (2603:10b6:404:19::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 09:09:44 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::a6) by BN6PR19CA0086.outlook.office365.com
 (2603:10b6:404:133::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 19 Jan 2022 09:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 09:09:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 19 Jan
 2022 09:09:43 +0000
Received: from [10.25.78.231] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 19 Jan 2022
 01:09:40 -0800
Message-ID: <89f20af4-de3a-01be-baff-014bcca9df82@nvidia.com>
Date:   Wed, 19 Jan 2022 14:39:37 +0530
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
 <0b584dfd-04f6-d7f7-f08a-003b89e557f5@gmail.com>
 <b250e2f5-b095-3767-519d-40e42e0a832b@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <b250e2f5-b095-3767-519d-40e42e0a832b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41baa920-39c3-40ed-6614-08d9db2b6f38
X-MS-TrafficTypeDiagnostic: BN6PR12MB1188:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB118801E627D639F4F4932965CA599@BN6PR12MB1188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHVXEYM+ce64OjZvPM/XxRe510wY4ckKWzUrqIbJskNz2Cc1wbG6MwfbY7xYi6HyFu/L78P1wLQCAEeGB6OI9T1eURnRisMrj1PSXmmLFv7rrZWudxVGoNCzXpaeEzGgpV0tgrTUGPk25dbHqqzWNtd4Hgc6NlxEUx31WU/92ht2qRbKsFHkuUYL5PXlmWWEzhE/uOw4Oa3lI7dGpBwzl7pSnAIIIfmdqPsOFcH4VBdqz21gY+dlfPCMJ29Czol7kTTQFSSQM91Z7Uoybv4OKXKUrkEMQF92K2Ww8g4vLRkTy93gfo6nUlaaX5IOTrc6VAmqp5Fazu8YW9koaAlH2p9LD6/8uJmLZKqAsyRH5iwTcfqYq0iANLjfG42IzZKAPiAL6JVXDasUz9nYbS873TmKAV0Yf0PF1AS50S2AahXccV4KbEesAe2COohW8v7f4opkeylc1obXUeuP4kFGEIV2V8TTmYnomJoAObSet7vAiNeZUACzZVTI107actANQdzzMumwT8I75e6K8kcfFhBz882nQM2k1zNAlqIph+LsUKIkmJwNFAmq5LOOPGGD4tiP042b2UyNqIWOMGh6oqfB4bHK3lO+5Y+IoZAPjecqzFDzBid0gZ+MqlUvZ32fMEXmghcYe79+PWrC0rOtIAnxj1OGAukerC/+BoQ5Rfv0A3QW2ER8tXvj9fo51qJp2MiNxwGfnl/XkV/1UN77LDOeZrd3kN5aoUglBHpFqmgsc3cun+K4KIxg9FK/KclI9+Dvd7w5iHr/XC+RVAn25pj9exq4rpTe4p3ve36JiETXLh1dROWsiVYAG2+CJtDEP9KADJNUyMi08l9XqfS8xQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(70206006)(81166007)(107886003)(6666004)(186003)(31696002)(86362001)(36860700001)(8936002)(356005)(83380400001)(4744005)(31686004)(70586007)(26005)(53546011)(2906002)(16526019)(316002)(36756003)(54906003)(82310400004)(426003)(40460700001)(8676002)(336012)(16576012)(508600001)(110136005)(47076005)(2616005)(5660300002)(4326008)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 09:09:44.3804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41baa920-39c3-40ed-6614-08d9db2b6f38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2022 4:54 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 12.01.2022 14:22, Dmitry Osipenko пишет:
>> 11.01.2022 21:45, Ashish Mhetre пишет:
>>>   #define MC_INT_DECERR_ROUTE_SANITY                  BIT(20)
>>>   #define MC_INT_WCAM_ERR                                     BIT(19)
>>>   #define MC_INT_SCRUB_ECC_WR_ACK                             BIT(18)
>>
>> I don't see where these errors are handled in the code. Is documentation
>> that explains these bits publicly available?
>>
MC_INT_DECERR_ROUTE_SANITY is supposed to be part a of Tegra194
interrupts. I have missed adding it and will update in next version.
MC_INT_WCAM_ERR is a MC channel error and is not applicable in upstream.
I'll remove it.
These bits are defined in same documentation where other errors are
defined.

> 
> MC_INT_SCRUB_ECC_WR_ACK shouldn't be a error.
Okay, I 'll remove it.
