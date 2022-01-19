Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21EF4936A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352639AbiASIxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:53:43 -0500
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:21459
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345394AbiASIxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:53:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9g2U1LTZJoI9b8hehdsonYcxSJ/SD5tRSI23mEHOMnF8g8AbfWWpIqRUz6LBmx2XYUuYVKb7ezVpDwDeaVkItij+PbzwQAX2tRj/8AowC3dTAq9//E/3Eask2UrSJ8ilLg9XnvY5ZmdocqrrWsMqf318rQPeT0qDKA4ALoqCoC6fEyX56+PpPky8sUYpKZhKTq+hUsWkfZhEjNXriH1gbyfeS3aEjw3erRgLkcgSm+WqRJ01Er1TA+N01GlfOp8DBLjT/yntK3FH0WRuvbvX8Oo6hYJhEE212mVOGhrXJemfn7MYcZN/0N0rRl0lN4On8VZ2Rsux1m1gM99jrPh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp+ICFjtBO2wDLsCVIr+qq58AJvYpGwSsNrtU/sKMLw=;
 b=BqPSrN7FD8DpBe9KW3GIgGTauyj7Dv0Fck5bNnwZyOygHjOKUatARkSR0O6FWJKnByNH+Pjg6gWWa4ERewaBKG+89cpiDgSf7VbNGJes5WYRBLtKOKNBCe7Ybp471uDsn/Hl6Ho0kMymuInWV38cHYZt8RhVBFNBPmSwBUUyYjfWgQFTuVfBHe6DKqE0KMxlS6Aysbvr/UWla9DnxGU/m7WD6nrdy2YuI5ZXzH/MmbDKxEEL13y2aZBiu6Oush4i5IGLezo5zh0wvBE6LKkGB7Ezd1aA0AehySVeMKiEqdn1xh8FLEdYo9k0EjZCKnTQGJI1m2V1zCl5l/UiZ2Y2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp+ICFjtBO2wDLsCVIr+qq58AJvYpGwSsNrtU/sKMLw=;
 b=GmxKTurS1i+0+bSqbW8d1DP9vNbuwpxGQ6x+bp5M/XlxteKgcvzZ0PW9eoKENRfNFm5nDWeA40mDwaRqdqs9H6W9M6pYwiUjEO/y2GYTl19z68SS/pWjwiQ9H02ITkW9+QjQLthLWWs7sjTVoxmEdf5ZK7FSq4w0IcYz9dkFGQueJUsRW8M0PUsir25/+vfIdd+b8wdaisUVg8XC0+MIyyfkeFk4ajnUPXS4RCpYj4ThY6W9K5fE3meO/CXASQqMNybm+ftSiFDuBmo5yYiEqLYfU+mLaU1MZ2se1x9kDECfGRR/hxNA4cXYWsVMpKI/jvFM4NkXALk3d4NNx6e/NA==
Received: from BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34)
 by MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 08:53:34 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::33) by BN8PR04CA0060.outlook.office365.com
 (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 08:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:53:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 19 Jan
 2022 08:53:33 +0000
Received: from [10.25.78.231] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 19 Jan 2022
 00:53:29 -0800
Message-ID: <a926e5aa-4872-5585-d367-da815518915c@nvidia.com>
Date:   Wed, 19 Jan 2022 14:23:26 +0530
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
 <f9ca5794-55ac-803f-8606-f0b48e826eb7@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <f9ca5794-55ac-803f-8606-f0b48e826eb7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8ace445-263f-4116-dcdc-08d9db292cdd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3983:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3983C976C4549D8574071F6BCA599@MN2PR12MB3983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4Q3i9jTa0zzjUkHGw06poCGFB8o+y7lqqC/KvH+bU3Vqnn/WAPSq8zAb01LXUCkRXNULzbi5MeIG4IsZeS4mTBifRopI1gtPWOMwKORDckBKfMS9ebVyGp1U5JfYqToHiB6QpHKENS+KLtzJgnqRvlmv438oAeBuKZ9jnMIV6eNDhG+iZb+EoU68Xww/QYOeiCtfU1YYhDg6AGRpMF2oQXbv6Le+UvHsC+ZHTmrAn58sIQJmW5pFxB4bRYr/LAb+49eRXXzocd6Vef0DEAokCckadPvS/E/872V9Bj29ZDZM3P1w41a6xwyAPLjLJMpscV4XGG3roMJy0PX3EjJL3qrw9KBLhQkcDO3W+yl5/ZmYBq6kFkHZ0ypBMvgFdvBGBlgU95yO0+gMuE15NMKI1AftWDCKq5w7cYU+eG4gm+vXKuoHHc7GtkW9ZJPTRBcD4Zv6jTv5tupBzF1rHzVnuKFHU30psWoLQ6/CxsnoZjxFbW2hRExjS7MqD4Zt+didtGV+ggHTcLjK3E6oUK3sAUWRyV30TTFkxLXnkoW6nSAXCxHd/WUfixrwPA1uyR/d6KKi8Yqe9DA01CyTWeEWzQvGr0P511fu2LVh+fmv3M+FbUGN4Kf44le7dOoFkQ4tAL8mgSk2GR8OfKeTu6BPYCPTWPJuRbLuE1yPGS8tb4M4QOamFgkW8mCYUXtioMLJgdbTFD4aOM87inSaYXCPCekNt1NxkPRMdDyZ6M7ymXf7kSRoEyAo9j7tY0lN2YR6+W9W6mX8DHpLOvHYXrwrTpaQ3OVkn7uLqf3cQzAWsUIkZZofsg1RmVfa/ANw0NXkTX+o3FlWUhO+C3gDhBRgg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(31686004)(70206006)(5660300002)(4326008)(70586007)(426003)(2616005)(86362001)(53546011)(110136005)(316002)(107886003)(16576012)(36756003)(8936002)(26005)(31696002)(336012)(82310400004)(47076005)(16526019)(186003)(8676002)(508600001)(36860700001)(6666004)(81166007)(40460700001)(83380400001)(2906002)(54906003)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:53:34.0796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ace445-263f-4116-dcdc-08d9db292cdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2022 4:31 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 11.01.2022 21:45, Ashish Mhetre пишет:
>> Add all mc-errors supported by T186.
>> Implement mc interrupt handling routine for T186.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.h       |  17 +++++++
>>   drivers/memory/tegra/tegra186.c | 100 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 117 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
>> index 2d4f495..7817492 100644
>> --- a/drivers/memory/tegra/mc.h
>> +++ b/drivers/memory/tegra/mc.h
>> @@ -44,6 +44,15 @@
>>   #define MC_TIMING_CONTROL_DBG                                0xf8
>>   #define MC_TIMING_CONTROL                            0xfc
>>
> 
> this empty line is unnecessary
> 
I'll fix this in next version.

>> +#define MC_ERR_VPR_STATUS                            0x654
>> +#define MC_ERR_VPR_ADR                                       0x658
>> +#define MC_ERR_SEC_STATUS                            0x67c
>> +#define MC_ERR_SEC_ADR                                       0x680
>> +#define MC_ERR_MTS_STATUS                            0x9b0
>> +#define MC_ERR_MTS_ADR                                       0x9b4
>> +#define MC_ERR_GENERALIZED_CARVEOUT_STATUS           0xc00
>> +#define MC_ERR_GENERALIZED_CARVEOUT_ADR                      0xc04
>> +
>>   #define MC_INT_DECERR_ROUTE_SANITY                   BIT(20)
>>   #define MC_INT_WCAM_ERR                                      BIT(19)
>>   #define MC_INT_SCRUB_ECC_WR_ACK                              BIT(18)
>> @@ -159,6 +168,14 @@ extern const struct tegra_mc_ops tegra186_mc_ops;
>>   extern const char * const tegra_mc_status_names[32];
>>   extern const char * const tegra_mc_error_names[8];
>>
>> +struct tegra_mc_error {
>> +     u32 int_bit;
>> +     const char *msg;
>> +     u32 status_reg;
>> +     u32 addr_reg;
>> +     u32 addr_reg_hi;
>> +};
>> +
>>   /*
>>    * These IDs are for internal use of Tegra ICC drivers. The ID numbers are
>>    * chosen such that they don't conflict with the device-tree ICC node IDs.
>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>> index 6766cc4..4f3ae71 100644
>> --- a/drivers/memory/tegra/tegra186.c
>> +++ b/drivers/memory/tegra/tegra186.c
>> @@ -146,8 +146,107 @@ static void tegra186_mc_clear_interrupt(struct tegra_mc *mc)
>>        mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
>>   }
>>
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
> 
> I see that these VPR registers present on all SoCs starting with T124.
> It doesn't look like you need the separate IRQ handlers at all, instead
> please extend the common T30 handler. For example, you may add a
> switch-case statements to handle those T124+ specific bits differently.
> 
> static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
> {
> ...
>          switch (bit) {
>          case MC_INT_DECERR_VPR:
>                  status_reg = MC_ERR_VPR_STATUS;
>                  addr_reg   = MC_ERR_VPR_ADR;
>                  break;
>          ...
>          default:
>                  status_reg = MC_ERR_STATUS;
>                  addr_reg   = MC_ERR_ADR;
>          }
> 
>          value = mc_readl(mc, status_reg);
>          ...
> 
>          value = mc_readl(mc, addr_reg);
Okay. I'll use same handler as Tegra30 with additional Tegra186 onward
bits.
Also, shall I change name of tegra30_mc_handle_irq() to
tegra_mc_handle_irq() as we are using it across all Tegra SOCs ?
