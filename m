Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB5493661
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352522AbiASIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:34:04 -0500
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:52206
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350260AbiASId7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:33:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLY5oXzJui4/9Nx/yBPrHsiWepSR4Ne862DqSY0+55/KpO8LKEdr/3MGg43OjtCQngflnqoRkpdaKYepgPZ49bqbidEKRdZwMPM4bBq6MUCYf0CqOp2wIDQbcAFUOMWkezOXLLq0s0XJJVJIPslNs1lpnkqjtm39VC/M9uIGWQeQeqQUb7Py/VRNx6Ki+mXtQ24/3jmXRhcmYqcQot9OWL8qzswbuYOJdvCfUd1tIO4lZAQxR4FscTrWNsIDgjHJGiE8lNEm4S5D7BFEU5dQmLfIANdPhXHpZ2KdIkcYxxI8d64I2z33vqiSbkTeLie0uKMRRSHgwbOLTTvcnytIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSrWODNweAGITCQz3WQk1aTHcLrkYq5l4tDPpFpUeds=;
 b=h8bcbG0oGuH5TGNUMNJY8zyPvoca18eVaTlvHjjH88B6ZYXlodKKnLjs7kRUzQk+G2XytL1ISj+NxutjZ4bH0ZeluV6wecYIYctkxu3QpvpCMqQUu23gIoPeM35gbETdht6Iv5SIW/AKVZGEF7H9edz2yaUg+xr1BpBW9ri2Ww0MbLp/iVf6OuN3tCuODAJ8vbvKTdJwlEhRNRV2PF53udg17ys4f0MJk0EQCWTKzDDQ6duwM/NWKDbZpJ1qvr27VdqlqrBk5B3cnN8oCUcxb7wDNbUB3lP/M50rJ76NaM583gqJQyUkAWF/3yErdIqq8iQGT8qZGA0iv+nkyyBxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSrWODNweAGITCQz3WQk1aTHcLrkYq5l4tDPpFpUeds=;
 b=gNfCJI7AGiHZnxRg67Uh/hwwgA87NXJJb3Znd/YuHjaZHc4lJvXfrjGRrbAF5Ier77ePCYtFsFC2u4c598srQAOfawSM+XKEHkbWrFQ21fAH8AsWe+7CsuwfmcWL5Q7DMimLbavxfQSGk3E5aGIejmS/gdQbylVX5D5lXXlvpS00lSgieCDFOIbGLOF5m2LolMw0Ht5IrhVtQYz+m91+SsQdSIQfBUr/RZrNwKJOxhVn0uS3B2LkheGrwT7mL1/l1Nab7PZ7lCx3wUn0zruTaAqHyI9nlr9jMuHwqKtLzLBT/MPMWYvdkEhPhK3d8iGtwLiOES0de4t6X9CZuxjQsg==
Received: from DS7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::29) by
 MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 08:33:56 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::d9) by DS7P222CA0008.outlook.office365.com
 (2603:10b6:8:2e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 19 Jan 2022 08:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:33:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 19 Jan
 2022 08:33:55 +0000
Received: from [10.25.78.231] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 19 Jan 2022
 00:33:51 -0800
Message-ID: <d2db0bda-2582-8b0f-db18-7cc80824fbde@nvidia.com>
Date:   Wed, 19 Jan 2022 14:03:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
 <dd9bacd6-1365-d9f9-1b28-c603bfa708d7@canonical.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <dd9bacd6-1365-d9f9-1b28-c603bfa708d7@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d489d753-d717-46c3-ad68-08d9db266ecc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB39504C42B6526B39D1C2461FCA599@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iR7Xn4QGK4fexfvR+TyH1XWpwV6psBfXnLk1n3ep5EQEIdrshFGW4ObeONcYwU9wAcC7BzNxRcQ4ks8Lool4P/c9TxPYnQfqSt+e5fT5IVPgWgTFI2dfCSM1U+sCCv7eNjYI0dSB7/6TALqT1bfdnxzAUusonWKtXbZcBHhw7PBCixGQNac/VadIHCYrCL/PX3ReaxD8RzfK6RudO0XaHu7+SKeaFreC4sJGlSiXhstP/U9jG4hg8RQjj5uGpKDNlVn/7vR0CerzHhWixJ7adVI3XOy9gLNGbYbF5BOXS3zu9iIE4iPaBNzQOu1LmHtaYOKGfId9sV+3Eh6OQ2l+rBeBuX9ErYHgkdMs6pxOO2QDvMTJjY9lO+0Dn0OFX7NH4600nWlORzTgqlRyh31PpRHKJLh1WracXm7aR5pVZaJj3TUsw0Ul1xYibZFitKKcumL8Yt0jueZ8Fp6oP0R8lxvQGx36abwYzLKm+ZXvitmiMgDC4TBeK7VP/ppNtyMG0/7qmXJ8YqqunG6qiglfpRKhscRwGhWkzY9Q6EZQl9Ob3vP4YEyyH9yVEVny5hUWglVcgh+8fix8vi2fDiejW9+UVNiPx7bU4lA2oCQLU99JVZg1KkuhjmsIr1oQ3yMSnYCxlWPQpRGctaGmexWEsDIc3+N+0jVtIUAiFLZwwhdYT2fwvEnhCpp6jriyGZ3dUAevAMcIcTdQtBk4nKKCXMZWlk+n3qM21E5kN0xndFXT5DjTxNxmm6ozX2SJVJl1M579UX+wx1EpEq6pgcuvMr6C+9RII0sUJyuGZBGh4Ziu9UdrrCaGGHWa5iy4Q/poUQgWGmchNGn4Xb299zpXVg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(70206006)(336012)(40460700001)(36756003)(508600001)(8936002)(4326008)(31696002)(31686004)(36860700001)(26005)(54906003)(2616005)(110136005)(186003)(316002)(2906002)(5660300002)(81166007)(16576012)(83380400001)(53546011)(8676002)(47076005)(16526019)(82310400004)(426003)(70586007)(356005)(86362001)(6666004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:33:56.2064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d489d753-d717-46c3-ad68-08d9db266ecc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2022 2:26 AM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> Cc in the future also Dmitry, because he was involved in these drivers
> quite a lot.
> 
I'll make sure of that in future patches.

> On 11/01/2022 19:45, Ashish Mhetre wrote:
>> Add all mc-errors supported by T186.
>> Implement mc interrupt handling routine for T186.
> 
> Here and in other patches - please use Tegra186 (and similar) to be
> consistent with existing upstream naming.
> 
Okay, I'll update the naming.

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
> 
> Where is it used (read)?
> 
Oops, int_bit should be getting used in handle_irq for checking type of
interrupt. I'll update it in next version.

>> +     const char *msg;
>> +     u32 status_reg;
>> +     u32 addr_reg;
> 
> Please describe all these fields with kerneldoc.
> 
>> +     u32 addr_reg_hi;
> 
> Looks unused.
> 
It's getting used in patch 4. I'll update it in next version.

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
> 
> Don't you need bitops.h for this?
> 
It didn't throw any errors when I built it. bitops.h is mostly getting
included from one of the existing includes.
Probably of_device.h -> of.h -> bitops.h

>> +             const char *error = int_mc_errors[bit].msg ?: "unknown";
> 
> int_mc_errors has size of 6, but it's index (the bit variable) can be 20
> or even 32. Are you sure indices are used properly or maybe
> int_mc_errors missed initializer per-index?
> 
That's true, I have not implemented it correctly. I should have looped
over int_mc_errors[] and should have checked .int_bit with bit and used
index of that element.

>> +             const char *client = "unknown";
>> +             const char *direction, *secure;
>> +             phys_addr_t addr = 0;
>> +             unsigned int i;
>> +             u8 id;
>> +             u32 value;
> 
> Keep order in reversed xmas tree plus name it in a meaningful way. You
> read here several registers, so which one is value? Probably you meant
> status?
> 
Yes, I meant status. But tegra30_mc_handle_irq() is implemented in
similar way. So I went with same names. I'll update the names and order.

>> +
>> +             value = mc_readl(mc, int_mc_errors[bit].status_reg);
>> +
>> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
>> +             if (mc->soc->num_address_bits > 32) {
>> +                     addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
>> +                             MC_ERR_STATUS_ADR_HI_MASK);
>> +                     addr <<= 32;
>> +             }
>> +#endif
>> +             addr |= mc_readl(mc, int_mc_errors[bit].addr_reg);
>> +
>> +             if (value & MC_ERR_STATUS_RW)
>> +                     direction = "write";
>> +             else
>> +                     direction = "read";
>> +
>> +             if (value & MC_ERR_STATUS_SECURITY)
>> +                     secure = "secure ";
>> +             else
>> +                     secure = "";
>> +
>> +             id = value & mc->soc->client_id_mask;
>> +
>> +             for (i = 0; i < mc->soc->num_clients; i++) {
>> +                     if (mc->soc->clients[i].id == id) {
>> +                             client = mc->soc->clients[i].name;
>> +                             break;
>> +                     }
>> +             }
>> +
>> +             dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s\n",
>> +                                 client, secure, direction, &addr, error);
>> +     }
>> +
>> +     /* clear interrupts */
>> +     mc_writel(mc, status, MC_INTSTATUS);> +
>> +     return IRQ_HANDLED;
> 
> I don't think you are actually handling these errors as stated in commit
> message. You only log them. Please adjust the commit subject and message
> to mention the actual purpose/action of error handling.
> 
Yes, I'll update the commit message.

>> +}
>> +
>>   const struct tegra_mc_interrupt_ops tegra186_mc_interrupt_ops = {
>>        .clear_interrupt = tegra186_mc_clear_interrupt,
>> +     .handle_irq = tegra186_mc_handle_irq,
>>   };
>>
>>   const struct tegra_mc_ops tegra186_mc_ops = {
>> @@ -886,6 +985,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
>>        .num_clients = ARRAY_SIZE(tegra186_mc_clients),
>>        .clients = tegra186_mc_clients,
>>        .num_address_bits = 40,
>> +     .client_id_mask = 0xff,
>>        .intmask = MC_INT_WCAM_ERR | MC_INT_SCRUB_ECC_WR_ACK |
>>                   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
>>                   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
>>
> 
> 
> 
> Best regards,
> Krzysztof
