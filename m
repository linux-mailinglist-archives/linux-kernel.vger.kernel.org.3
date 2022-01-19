Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27D1493591
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352064AbiASHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:37:06 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:9601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241096AbiASHhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:37:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0dhCfsOJvZus60CPIxaK/JKOk9RvRHg04vjOAhApSS3BYfvgNwEYyce2qZJWwkw27tzzV23T+70kJdwb+IqeSLftOsjsM1wxdOvVPFJgZEuPpXsVxnOydsVRV4W6B1L6aUaXiDOoPeP6nSWA0OrV+QgCUJ6PXmqa0Thg7K7bxw1gDV0opqFkuy9AnhLL8IajwTyLelkdjfvTLuyMIGmpW9vgqJxWnGYxB5voh5j7z12vo8/cIg49QCW1nzTs/mw0eFZGo962BUls/nczP8bUcXhtZ6iDKlvdTva/Z2ndAz5jVACI0hyo19zUX/bGDxvVcg9fVOsiSky57+r8I3elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsCt4kBkLnqAmAfXFfvPezeo5ea+wnHPyKr+JkG1VGU=;
 b=PPNyfR2rHX/1d4cKX4nnIQ7Ytc/l5ws9AZsxZMdVD18kj6OqkLySxuNMoXJQp1OB2GqswI6UnhQmW8/koCLzi0XiZnwv/+3qpq/ZpaqjsPiJi/d9JkQIWuqMtS3906UIvNSryBP/NBRDAxWJupnDasdyRRqUw6JKpVVloNYuXcDdH8UUNqYf9NbCSLR0TDnM02qzD19oE0qhFRGmU8u7/aTVJpLWUvM7qnK+n0YqtRMjIp6MxjuXP1J0b5GTGxqzlD10YwHQLLE8KFJK1A0k9Wb1DnXlXvhpoC0Z7OxBbZCgPIs0wAGUidFng3Vh9g6rZMpQ6TQgcLfLSDIhaWqHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsCt4kBkLnqAmAfXFfvPezeo5ea+wnHPyKr+JkG1VGU=;
 b=QOw6QW7Z8XHhoFDUQRjnTXusXoCXwc5BzzI12Q+hspNqNQujq5Hyj8cdgjerIE4LeIMcXrrJoBv4+AuuJ7P0xY3ljtUsKo9A0Fs8/p/hN729Toet6ifeOffdZFg2LlQd7QGT5b0Sn1UdJQOkb44vD2LLR8ueEvQLXTLWMX5R0zNTuz+w1e563bE/NTT3iOz7osidKF/TmfwgO4FtI7MUxemT3iAqu8b5J51Yj+lDtljaMtK7e/S4EVcGx7wFlUjUv4/dgvrxYIwWndOLWpc6/Ss0iP41jotrWC08ao83iLeaPp8EYFruiSLuHU/hpCMRORwOaiZYiliocyIzR7AJAA==
Received: from MWHPR13CA0017.namprd13.prod.outlook.com (2603:10b6:300:16::27)
 by BN7PR12MB2705.namprd12.prod.outlook.com (2603:10b6:408:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 07:37:02 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::cc) by MWHPR13CA0017.outlook.office365.com
 (2603:10b6:300:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2 via Frontend
 Transport; Wed, 19 Jan 2022 07:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 07:37:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 19 Jan
 2022 07:37:01 +0000
Received: from [10.25.78.231] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 18 Jan 2022
 23:36:58 -0800
Message-ID: <fcfb2415-1ed8-a375-86b9-dc8c57106f87@nvidia.com>
Date:   Wed, 19 Jan 2022 13:06:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 1/4] memory: tegra: Add support for mc interrupts
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
 <c71e09a8-0170-ce05-3fef-3e32c990b377@canonical.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <c71e09a8-0170-ce05-3fef-3e32c990b377@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b614c99e-d0d4-46b8-ea27-08d9db1e7bcf
X-MS-TrafficTypeDiagnostic: BN7PR12MB2705:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2705D20A0B1DCF657E13CA28CA599@BN7PR12MB2705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nQmIfcpo54PXL44D9nV0usG2FymHMTBs9xIomvEmQZGFNonpT03q33YNDcOVGA8QDrS7w8v4olQXqTJLPauaeo5wf7twKhU7oGtKl8V8DCIO9upW5g5WSjDzENia1DwG4bI+eOsI+ub2Ir/0yeCRlN0bB2lGbXTR8+XOhX3TB+vdxIsmencaGpmYU476OFxejrpRypR+HEqaBBSDRNwLdw7ZlVtzYbVDzL93c4hIuoipYdnp8RgZ5DSWTu7NJ9ePGnYHQf6stLDmkF0sGhhUdiLF520pYSycvm0DwFcysASGb6tiMwgmso6M1wH7Hn2HdA5BxeI9WS+yD/NF3ghTgBj4/2l3WN8B1EYPj1c5lrd5RFaA2Iw3afIrKIEWzJzF20PvNSFaIVYnearUfYRdPvdPXaLGqEWXNjxOH1vQvDx+Q6ap8AnW0tp3G8c5nofkWhmcjuqmrBW+7IuoHlfyTW28wX+5adAbfeOjn81XYi3IHEGT1ZWfjjPHKQ++qjX+F80BPk7fKklzi2G9kPpDHYz8AIpbGgHpr0gWYfZVRw/V8G4QAyWpkXMFu8TY3kiF/7sao6RhSOLnNJZRG7noQxX0fipAbVkYP/weyUQqwuWWGdAaRHSFFoFURS0vgLxax0sCAUrSHW5UoXBgj6IA8aGk3AGKDHSJ/ZCTpizB7DpXaFiSy4gKPsBVGIlzmCDJrL1i5vSRbFtagWIAV13zTfsOMmLtIcI6VH6lUI6RAY7tZlEu2T082ec+0Fdd5lRZFzma8GJtHw3KJ1ZPdNOezImjuoPjZlGG5n7oyiG1JhmmybWFUu+gV+vvNYwhgA3su99CSAINE0pgLc8DkzMMA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(2616005)(40460700001)(5660300002)(81166007)(36860700001)(54906003)(8676002)(107886003)(26005)(36756003)(47076005)(8936002)(31686004)(110136005)(16576012)(336012)(6666004)(86362001)(316002)(4326008)(31696002)(53546011)(186003)(356005)(70586007)(426003)(16526019)(70206006)(83380400001)(2906002)(82310400004)(508600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:37:02.1423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b614c99e-d0d4-46b8-ea27-08d9db1e7bcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2022 1:59 AM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/01/2022 19:45, Ashish Mhetre wrote:
>> Implement new structure for function related to mc interrupts.
> 
> s/mc/MC/
> 
Okay, I'll update these.
>> Move handle_irq into this structure.
>> Add support for clearing interrupts.
> 
> The subject says you are adding support for MC interrupts, so before
> they were not supported at all?
> 
Interrupt handling and error logging is not supported from Tegra186
onward. So the patches are for adding supported interrupts and logging
them from Tegra186 onward. But you are right, subject/commit message is
misleading. I'll update it in next version.

> Here you also mention clearing of interrupts - another new feature. One
> commit for refactoring (adding new structure) which does not change
> functionality, second commit for adding new feature.
> > Different question - why do you need new structure for just two function
> pointers? Why these different IRQ handling functions cannot be in
> tegra_mc_ops? To me, it's unnecessary code complexity (plus performance
> impact, but it's not that important). If this is really, really needed,
> please describe the rationale in the commit message.
>
clearing_interrupts() won't be needed. As pointed by Dmitry, we should
be logging early boot MC interrupts as well instead of clearing them.
Also, I'll keep handling irq inside tegra_mc_ops instead of adding new
structure.

>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.c       | 14 +++++++++++---
>>   drivers/memory/tegra/mc.h       |  1 +
>>   drivers/memory/tegra/tegra114.c |  1 +
>>   drivers/memory/tegra/tegra124.c |  2 ++
>>   drivers/memory/tegra/tegra186.c | 14 ++++++++++++++
>>   drivers/memory/tegra/tegra194.c | 12 ++++++++++++
>>   drivers/memory/tegra/tegra20.c  |  6 +++++-
>>   drivers/memory/tegra/tegra210.c |  1 +
>>   drivers/memory/tegra/tegra30.c  |  1 +
>>   include/soc/tegra/mc.h          |  7 ++++++-
>>   10 files changed, 54 insertions(+), 5 deletions(-)
>>
> 
> 
> Best regards,
> Krzysztof
