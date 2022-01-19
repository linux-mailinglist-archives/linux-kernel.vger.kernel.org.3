Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970C9493686
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbiASIrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:47:15 -0500
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:24336
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238461AbiASIrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:47:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvUBZ4ffmdBMuZjUuQV4gxJ1paFSZoyy3SGsMMTwZpjYqieXNv7kqToQhW4Ro/Do/upPrfvb1rIIKX4sTpYDFohusnX9iM3KukKzpeQI8XhlT3DSU0O7yv6YlXu7lu9xkqo9VsmeeQ63xwYM6Ob4IugpRempvNATZS6v1d0i8Q4BCro4b7E4TriJfmZNnUTig4GwTKtMyw/KIHg0UEi/5VciPyCU2Vo9eH2/vXDf6+pISVsMRt9qYFXE1gIOhch3a05MM8Q5Ct4DZCFzbTFZUFaixizsaxesguGUXB8kGVKHCeQRXPvef6BTnauy9u/0EzfB0778P+DVQ9kBSxlbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9ALC3R+A+5POobjBuxPZzPdfMkNDhKwiotKr5EstN0=;
 b=Leug42zi5Rs0sN6b40aDslS6I1KAgAl2/KnsCThTL2DgwiSQLS5XUsiSWzLsWgC9hMbRQ0HCanBRjbCd4mLOkILH4V19GCpOduFRP0Q/MwhVycc03Lb/AaBKORgXdKl2ctq0GlO0jJ9BjWtw6beIGywv7nNCE6vwaJGYDWhoAAOywiX6v/578CjFJXORtuQY4lA9cgPS0VZYMm/d+JhAEvx6V0XZPZn8UdeedDgc7Y3CJCseqH71y7pmYdSHb/eqwSVYvztpFWJ5s0qTIOGvFtr1pZBI580oFukynsKTRXkGH+H8wmAsPpSYK65+n3/Q3yg5YNr3N2iRYgs8RuU5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9ALC3R+A+5POobjBuxPZzPdfMkNDhKwiotKr5EstN0=;
 b=dqLJLwF/dJwCe687FawZ/FgwG+xrz/PaS54TYnD387v7aLNjcWya79RM4B3UFr4H8D8bMzN46Zq0Cb6Twkuruf/yvOOQ+28CM/wqkwxYksixQ2UQwTD0vdTpxzE7QKu0RxoARDDBXPocPpAPmq8Hj6yWXDEaQFOz7+lrWNzT7coTJwLNzTfKLoIh4oFeai9YWaQPLqv7qWdztDAZlOzATWQRGOhCGv267uH8d37Ouy6ucQ2gCoRywguxnlSqHp/xeBPBU56p4aKvRK6y2rktf8LWKExE26pmpb3liJIxCjPId15Gh2VyA6Gocv1CgQFvTh6QJhCgoJSkOAjXX/ORcA==
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 08:47:08 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::c6) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12 via Frontend
 Transport; Wed, 19 Jan 2022 08:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:47:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 19 Jan
 2022 08:47:06 +0000
Received: from [10.25.78.231] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 19 Jan 2022
 00:47:03 -0800
Message-ID: <fb2fa56a-f1eb-bb19-36ab-a2d460dd3a9b@nvidia.com>
Date:   Wed, 19 Jan 2022 14:17:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 1/4] memory: tegra: Add support for mc interrupts
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
 <1c2dacc4-566a-929c-2100-37b6f9bece98@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <1c2dacc4-566a-929c-2100-37b6f9bece98@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e66b86-e9c7-4fee-f763-08d9db2846aa
X-MS-TrafficTypeDiagnostic: BY5PR12MB3891:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB389114E0A4261917BF4A5F14CA599@BY5PR12MB3891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8kws3cMJIHfz6dZdVUukCoBp06XmnrtA+HdedF7Nk4iK/TBpyFxAbobpl0DrYwm7Tw3P8YdxPiSZtmxPL50oRJY/yIog3FKsLa8xVdAHtqjfpAOHP5aSsrjJEUkrUNaMxf/R8xPVm1g2cwwDQZ5135rU7sW3xgtbxRfF/Typ9zP3nfqY+a8U0bkaxvRn+ZJMVx06QBt+UqtgHz0BKkOEZjbHXki9DG1OvF+h9xdfYYhciiZaA06V+7Ln0QHK88uSjPcsb8Qt/CledUxMiXctqg66i3lawKVBXI987jf5T2X/0Iy35H6a7udv4uOQusRoLCmuiB1rimAXF4piQjVP6ODrsmZkW1cabO9i6MQ3ATtY0t/YmHYUN9UNaQDvSPTB6H1SSIY3WzZ6AYDIO+d7v1bnMJ6YjJa28k6JSBjaX14rVQrkPlN4RHsYRTxY8hP0/4RGcriCNtk8RkLIqq9Cg8f07efGQ8YZ9c1ruMP/6QWz1x72py9iHHRw7UoFVQ2yKAnMAYw/GR3B8QlS04hHVFk5l5/04zBXEek5BroH/2UytZoclkACC3pYmqvrYOoHl/FkYTfMYMulydEXMoYJFJoIdCUOL5hPshlJi0Ad5XUaBhq2rvkF+1F6OTlkJS0mHvPVf6Mycy8HcLIFgYOHEDgyO+szacxFftXdQjWUyhmZlwNVQkIfHKc5E0eG0kmkvGL0M3BrOMXpyPM9GAHgr/gZ21xE1dhNGxi5hdU7HF/Oar1CQMXAawuBRFnKpTzS4TuQOIJSOpX67lxuDtMl4QqyH0/Rh6NE4QWFtH9Lmgm2++MQZ0SjQUVdjoTIONrraEXl5TSV5D+pEBeJPywSA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(70586007)(81166007)(16576012)(356005)(40460700001)(70206006)(31686004)(83380400001)(336012)(2616005)(36756003)(426003)(82310400004)(2906002)(8936002)(54906003)(8676002)(110136005)(36860700001)(31696002)(47076005)(16526019)(26005)(186003)(508600001)(4326008)(316002)(5660300002)(53546011)(86362001)(107886003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:47:07.8701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e66b86-e9c7-4fee-f763-08d9db2846aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2022 1:43 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 11.01.2022 21:45, Ashish Mhetre пишет:
>>
>> @@ -765,16 +768,21 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>                        return err;
>>        }
>>
>> -     if (mc->soc->ops && mc->soc->ops->handle_irq) {
>> +     if (mc->soc->interrupt_ops && mc->soc->interrupt_ops->handle_irq) {
>>                mc->irq = platform_get_irq(pdev, 0);
>>                if (mc->irq < 0)
>>                        return mc->irq;
>>
>>                WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
>>
>> +             /* clear any mc-errs that occurred before. */
> 
> s/mc-errs/Memory Controller errors/
> 
Sure, I'll update these in next version.
>> +             if (mc->soc->interrupt_ops->clear_interrupt)
>> +                     mc->soc->interrupt_ops->clear_interrupt(mc);
> 
> There is no explanation of this change neither in the code, nor in the
> commit message. Please always provide detailed descriptions for a
> non-trivial changes.
> 
> Interrupts aren't cleared intentionally by the driver, otherwise you'll
> never know about early-boot memory faults which happened before the
> probe. Hence this change is incorrect.
That's true, we should be logging early-boot memory faults as well.
Ideally there shouldn't be any early-boot faults as all clients will
be up after MC, right? But I agree that we should be checking and
logging if any interrupt is present.
