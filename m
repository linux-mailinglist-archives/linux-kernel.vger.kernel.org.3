Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC688495997
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378561AbiAUFud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:50:33 -0500
Received: from mail-bn8nam08on2058.outbound.protection.outlook.com ([40.107.100.58]:62944
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230443AbiAUFuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:50:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw5t8zNEkDEdh6F5y/e2U3F9SY1pwUeImJocTSBUE4nudW0kfhp8HBq+eS1oFMl21hrXNMhsS04Mfs907OSqRmq+eZkZNCXaeM0oMLxmqEYMKcb9uAs7gclGmFHmWbjMJu2J3ZRTIseAoSWEoc0YfVn6m+Y7Q/3/rD4Ut1zuOJS0icFjmIgsXE/LhP3l3mMEii2krpn0+NqQYP1UltuZMcPUP1uP8ihA/ARCt9m5wQ27KzuPp9i/ntukHCnm/kCt0JkOwxT0F2UoOHAU4iSCxIFcownn0xw0uOZVCfr6zCyjk3REl/c0Yhn5eXL40aZfIawQ7hjAHIp2EVAu6viYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ4vjm21OzZrTLAPP1/S2IDiRheJwEdsjZLAAm2ADx4=;
 b=RaZ7/KA4KnnJqOdBXGn3QnhXR3ol3NJ0x7Q4VE/9i4Q5RlCWQ713Tk0qNBoKiEKVxLE+vEdIivPEUbxMnDZARCIh4LCkG1MqV7QRoUe39U6NX/samnxbO2vK11UHln9nE4BaNCtTDljg+29pVBNjrA7nKK3YAjkQwMq5ijvCyGR5+gOVl7Ced7UFFlaL0zHFO1fjYjdmDV0dgf6jalTW9mIx6imQRVQHIFB4BxSOs81qAOfobL93u7UKwcldDtfFORLdjBEc+nnUQO0nkjz3zkfIM6GLylUTkdobxoWJymPfnspJSUo0BhBRDVjbEpOJhmBl1ePoldjArzjMfLl04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ4vjm21OzZrTLAPP1/S2IDiRheJwEdsjZLAAm2ADx4=;
 b=Oylce9KwlyGcgWiF7XhpCbrA8BAa5KwbIOEp2sBiS5REZ+N1F+V1Cl9WDtwiu35vP6CgEt3DqUjNckj4K0DTWxd0beVZ5QUV2WpROhJj29GYGOhAR/ZQCiPNewBZ1LiCZVnCWMoqgQLsmuyEvQ6650QTQyOnGOYAl41Jnmd4Nycvl0bGdZIS3JG2FXTotbKc0bp5yg1Y/xLdX4uzvI2fMrbILPdOYm76u2j/hK14hS4MXh5WymdfLeSiE34yPTKbSRK6jdev5Z6I0Xg4dwq7vLnvXvQ8mIKb4UPSFu8B4C0BpLd7lSnMGhrSWj3TH+z9pCdbPqFB31Hb0bjnLuhpKw==
Received: from BN8PR15CA0044.namprd15.prod.outlook.com (2603:10b6:408:80::21)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 05:50:30 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::91) by BN8PR15CA0044.outlook.office365.com
 (2603:10b6:408:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Fri, 21 Jan 2022 05:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 05:50:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 21 Jan
 2022 05:50:28 +0000
Received: from [10.40.163.9] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 20 Jan 2022
 21:50:24 -0800
Message-ID: <913e5496-c2b0-0d62-dafd-eb85ebbd72eb@nvidia.com>
Date:   Fri, 21 Jan 2022 11:20:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V2] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
References: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
 <3ebf9021-8df2-3d62-7f6c-0ff660e93735@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <3ebf9021-8df2-3d62-7f6c-0ff660e93735@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad414cc-665e-45f6-8cfa-08d9dca1ee30
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB291864A8EED6ABBFBA44A108CA5B9@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nL6cVjk+DcMgrCUd9oetC/PmYPAZZD/ZK2uNuQn3+LoENol7AO6q1+khW1ziaXozI/b8WbNVQz05K6OKMdGhrhYvhey+vlCIsuK5EeBc+qIGwWdDE9joL/fs4z2+WqgUFlj3exHvcEhgHTfzKwe/mNRzRYraXYQRvN+9EzFxr+5XllQzjbZjWiNM71Yyg9yy1bbkNhHldv13ZpOqYMr68yzB6TsvzZT9FTboRgvHbfw0O+zh2xUzc/WsPla/pe02MfH8QgTE+iyzq9n34fr0yVKgmoz3qY2Bz1r4ZY9HF0033YaV4/mPuWH6M1SXjrEszVYUvfB27eV2PQvY073O4B56wVc4HI9AloIdvR64hebms8pn6QOYUhyM3ENf/XtfCB8YecCPPWo7PcoHOCVyxGsYbZuORT+zjE2iEw3HvsJdqqdTFr/vRVAgG4JPoNItLBY8bTR9T9lHSeHUIsL/B1np/TZlbe6yTXDUCKtatVxVo+lWjI/XUfnasHNJ6E1KQughOfAa0kZMEETDeTy9MIU63LfDJ4kMzn0pbwlxWai2OibzQfpYMtMUN0EEiqqR1zChSZG1o6dd/U55fLWxaWXybx4hySaXesuW/6Vgiv8jxWf63mxmKnWLRlzfh/2XyE5cYrRo8QXnN6EwBwUiIFU5PBDYMNjCSWYeqYvq20vfIj2q/ly7czARpOeGJPr023LbxTHRrKuX/qbhcQ68M0SB+JYAzQmpAP3plZsXX3II6xhBaAW1lcE4s5DOOHrsvNr+JS2hIsJrnDajRcmqkuzz0uFeJAPuXak3dPXHVNQnkGC7uEABiUWj4e8G+V7cjpvWG2Klyon6L7dhyIsjhg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(4326008)(16576012)(336012)(316002)(47076005)(8936002)(36860700001)(31696002)(83380400001)(110136005)(53546011)(81166007)(82310400004)(508600001)(54906003)(70206006)(70586007)(31686004)(186003)(2906002)(40460700001)(2616005)(5660300002)(426003)(16526019)(26005)(356005)(107886003)(86362001)(6666004)(36756003)(8676002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 05:50:29.1921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad414cc-665e-45f6-8cfa-08d9dca1ee30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2022 6:23 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.01.2022 12:02, Ashish Mhetre пишет:
>> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
>> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
>> Add error specific MC status and address register bits and use them on
>> tegra186, tegra194 and tegra234.
>> Add error logging for generalized carveout interrupt on tegra186, tegra194
>> and tegra234.
>> Add error logging for route sanity interrupt on tegra194 an tegra234.
>> Add register for higher bits of error address and use it on tegra194 and
>> tegra234.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>> Changes in v2:
>> - Updated patch subject and commit message
>> - Removed separate irq handlers
>> - Updated tegra30_mc_handle_irq to be used for Tegra186 onwards as well
>>
>>   drivers/memory/tegra/mc.c       | 73 ++++++++++++++++++++++++++++++++++-------
>>   drivers/memory/tegra/mc.h       | 16 +++++++++
>>   drivers/memory/tegra/tegra186.c |  7 ++++
>>   drivers/memory/tegra/tegra194.c |  5 +++
>>   drivers/memory/tegra/tegra234.c |  5 +++
>>   5 files changed, 94 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index bf3abb6..badebe8 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -508,7 +508,21 @@ int tegra30_mc_probe(struct tegra_mc *mc)
>>        return 0;
>>   }
>>
>> -static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>> +const struct tegra_mc_ops tegra30_mc_ops = {
>> +     .probe = tegra30_mc_probe,
>> +     .handle_irq = tegra30_mc_handle_irq,
>> +};
>> +#endif
>> +
>> +#if defined(CONFIG_ARCH_TEGRA_3x_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_114_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_124_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_132_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_210_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_186_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_234_SOC)
> 
> Ifdefs are unnecessary, please remove them. They are okay for
> tegra30_mc_ops, which is known to be used only by specific older SoC
> versions, not okay in case of newer SoCs.
> 
Okay, I'll remove these ifdefs in next version.

>> +irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>   {
>>        struct tegra_mc *mc = data;
>>        unsigned long status;
>> @@ -521,23 +535,64 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>
>>        for_each_set_bit(bit, &status, 32) {
>>                const char *error = tegra_mc_status_names[bit] ?: "unknown";
>> +             u32 status_reg = MC_ERR_STATUS, addr_reg = MC_ERR_ADR;
>>                const char *client = "unknown", *desc;
>>                const char *direction, *secure;
>>                phys_addr_t addr = 0;
>> +             u32 addr_hi_reg = 0;
>>                unsigned int i;
>>                char perm[7];
>>                u8 id, type;
>>                u32 value;
>>
>> -             value = mc_readl(mc, MC_ERR_STATUS);
>> +#if defined(CONFIG_ARCH_TEGRA_186_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_234_SOC)
> 
> Please drop these ifdefs.
> 
Yes, will do in next version.
>> +             switch (bit) {
>> +             case MC_INT_DECERR_VPR:
>> +                     status_reg = MC_ERR_VPR_STATUS;
>> +                     addr_reg = MC_ERR_VPR_ADR;
> 
> I mentioned previously that VPR is supported by T124+. Hence ifdefs are
> incorrect.
> 
Yes, I will remove them.

> ...
>> +             addr |= mc_readl(mc, addr_reg);
>>
>>                if (value & MC_ERR_STATUS_RW)
>>                        direction = "write";
>> @@ -591,9 +646,6 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>                        break;
>>                }
>>
>> -             value = mc_readl(mc, MC_ERR_ADR);
> 
> Don't change the order of the code, just replace the MC_ERR_ADR here.
> 
Okay, I'll keep the order as it is. I just thought that higher bits of
address are read above, so why not read lower bits after that.

>> -             addr |= value;
>> -
>>                dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
>>                                    client, secure, direction, &addr, error,
>>                                    desc, perm);
>> @@ -604,11 +656,6 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>
>>        return IRQ_HANDLED;
>>   }
>> -
>> -const struct tegra_mc_ops tegra30_mc_ops = {
>> -     .probe = tegra30_mc_probe,
>> -     .handle_irq = tegra30_mc_handle_irq,
>> -};
>>   #endif
>>
>>   const char *const tegra_mc_status_names[32] = {
>> @@ -622,6 +669,8 @@ const char *const tegra_mc_status_names[32] = {
>>        [12] = "VPR violation",
>>        [13] = "Secure carveout violation",
>>        [16] = "MTS carveout violation",
>> +     [17] = "Generalized carveout violation",
>> +     [20] = "Route Sanity error",
>>   };
>>
>>   const char *const tegra_mc_error_names[8] = {
>> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
>> index 062886e..9b1b0dc 100644
>> --- a/drivers/memory/tegra/mc.h
>> +++ b/drivers/memory/tegra/mc.h
>> @@ -44,6 +44,8 @@
>>   #define MC_TIMING_CONTROL_DBG                                0xf8
>>   #define MC_TIMING_CONTROL                            0xfc
>>
>> +#define MC_INT_DECERR_ROUTE_SANITY                   BIT(20)
>> +#define MC_INT_DECERR_GENERALIZED_CARVEOUT           BIT(17)
>>   #define MC_INT_DECERR_MTS                            BIT(16)
>>   #define MC_INT_SECERR_SEC                            BIT(13)
>>   #define MC_INT_DECERR_VPR                            BIT(12)
>> @@ -65,6 +67,18 @@
>>   #define MC_ERR_STATUS_SECURITY                               BIT(17)
>>   #define MC_ERR_STATUS_RW                             BIT(16)
>>
>> +#define MC_ERR_VPR_STATUS                            0x654
>> +#define MC_ERR_VPR_ADR                                       0x658
>> +#define MC_ERR_SEC_STATUS                            0x67c
>> +#define MC_ERR_SEC_ADR                                       0x680
>> +#define MC_ERR_MTS_STATUS                            0x9b0
>> +#define MC_ERR_MTS_ADR                                       0x9b4
>> +#define MC_ERR_ROUTE_SANITY_STATUS                   0x9c0
>> +#define MC_ERR_ROUTE_SANITY_ADR                              0x9c4
>> +#define MC_ERR_GENERALIZED_CARVEOUT_STATUS           0xc00
>> +#define MC_ERR_GENERALIZED_CARVEOUT_ADR                      0xc04
>> +#define MC_ERR_ADR_HI                                        0x11fc
> 
> Please put these regs right after the MC_TIMING_CONTROL. There is no
> reason to separate them.
> 
Sure, I'll update it in next version.
