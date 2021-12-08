Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA62246CAAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhLHCBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:01:03 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:50400
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233974AbhLHCBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:01:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIKoJRLNN+0TkI1pY/6PdSQY6gTWL5t7oVCDk9Zb5bke8OEwrC1YxEU8Ux65wCibtalzbJ+/jnKByoolsimVGXdl0IvQqXpWpKLrzZaplqGfODv27qdJ+oT7nNwb6SOmmTTrIePG23w8wdm8N5W0rQ9Z4PQ3aMuAQ/5HIhYlbMCgFWNsr1pBvDgosTmH8sZ40T9ZycBY1u+JSixg3J/04V9fPPtu4GjH0LrKGWAJRyvQdlOCguz7GGMQkWvrC6y+gxUt3tN+BkynX+yzaQc3+AkOJcAFqPIgdBov174MNKTuTMNSHKrFjUu17tdRf1LdSLANuUp05/1bQtdrnytrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irJrHldIHwkydgGx+Q8/Y+HBL7e+KndhujfjmXSfQHQ=;
 b=e7AcZc69F1vKDo3Pcf0SYgUiZWF9FP0QWmwFUdjI9nE+A+9iHLgMNsC0VD5zVCrUvoSNRmzEmFm+J8hG8Eia6Cx/mCyScfPBUPMAS1beS+UKPGy8FA7NEZ+pHzVvKFMAtItzY4II9S0F6CTvo8K5SodbMs4AiixdLsIsLCM4tEYvk0orT2E6PCwvnB6A9OXfpg9hkTwC58OiDClPyRZGDNJ1ozQk2P6hJe3VlW1wJDSV8pEkwMBqYVU015ZjSu0C8GmdAXf6fsD/568qkS0HjHZ6oxt2kIxi07kOHRr1eJZ1sklEAhzC6vbaieO/PjzkHVaqcX6dkhJXElwvtbNnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irJrHldIHwkydgGx+Q8/Y+HBL7e+KndhujfjmXSfQHQ=;
 b=Ja3rMvXMK891j3314kBcl3bo/abGwF5VABMgqOTXBfEqUzYARwJgasGTTU1OEtB5VI8Up9VJab/PfCW7CIUm4HRKO9Yj1PzYfRku6/xPRNXichPsil0dfPsmMcOF1C8qgGuMu/UaIM+WYAGeGaXSI6ggzzkFE6SElJzq93F1eHzTKqpotEJpVpV6LJKm87wx0F8BSZWgXcLr4arMMPZrDwywsuoOR+Hmq4FNv6168W2Fn5fJHpBCM92B20oWX1QzS8UglyFlD5k5yeQeXtLQpvrrbj2wBgH8BN+U6Rlv229oabUZ8Xl18YWPwyO22B2NWA4N1Xbc/j+j3DYpr7DPCQ==
Received: from DS7PR03CA0335.namprd03.prod.outlook.com (2603:10b6:8:55::34) by
 DM6PR12MB3100.namprd12.prod.outlook.com (2603:10b6:5:11b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Wed, 8 Dec 2021 01:57:27 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::b4) by DS7PR03CA0335.outlook.office365.com
 (2603:10b6:8:55::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 01:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 01:57:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 01:57:24 +0000
Received: from [172.17.173.69] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 7 Dec 2021
 17:57:21 -0800
Subject: Re: [RFC v3 02/12] drivers: Add hardware timestamp engine (HTE)
To:     Kent Gibson <warthog618@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-3-dipenp@nvidia.com> <20211126013041.GA10380@sol>
 <246d1ff4-ec51-b4bf-a664-4559c45021fb@nvidia.com>
 <20211208012136.GA18163@sol>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
Message-ID: <f9ec603c-045e-a218-9cda-587c6c1c0a16@nvidia.com>
Date:   Tue, 7 Dec 2021 17:59:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208012136.GA18163@sol>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3fff15-e3c2-43ac-c641-08d9b9ee164a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3100:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3100FC2A1B23665C236FC19EAE6F9@DM6PR12MB3100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHjY39jiZbJAbEx2Tza6dWo+UGbHzmnSRgygxsHBEJZ9QkRvCaZ2bDK/DjA0cefBy3EVExYnp0O7Pqj1UTaDYLc9V6hiSQGpfdzHS8NR2xv7mWPePCpN+Ig/HR1p2KqDuUuqY9Lb9pAPM/9LLsHguf5seLkPdz21sMauUv0NQdgCr5I+ozUAGGulFKqLgF19g+a4EGC9V/K/7KFpoHsfdIezr6OztUKCkNodVLen5Q2UG+Bvw9vvk5IQrjXXGWhob1LmqsiirgBJ16ypLDpRL4ndQonAoma9EcE24j9YnyEKihH2zaSsmg03pvXBhaYf/6nZTEQmglkMyMkoox7sQp85JxubUNlOPztlqkNGyj3vimFFvVAuAdjVeN97DYf4ePob1cluQtkOVzDWrkkwt6agd4WAqdNEONHs9TmeFxplo/HRr0IWJCFFuYaoAOyDQtdBAs2+Ijg58KF1djN91UYGcdPB/+DTQ5xAMIKTOXf/WUZ7/huUFPe8akV+lO3WyLdLbeo0Z15va2BOXLzkZw6liprz1w6OoAPEWGDBf3WgqUC4DteOuEfJVA8moCNwF8bnmxU67z0sQmqjY15yxAdTIbMk2gdjALdlShXuAhMUKyCd1Atdypp74NGmu8w9RtNY72sO/HbgxEJ3YfquRCdIA7NEmv+lF8kqndXam2qniZyJGosPumb555virjSLxYDmgqywJ4f473oVj1k39UiNaH6hDlqwAILRw7bbC4pKkNAJiVSvB79lPOjjAJbAnDEdmw7RQolpJapBZEvsjQ2fyvcM2KMmcXIR3BOyt9gSaWKg1Q+P298JO2u0RjvZm/nFI/OIzWED37MyScm9NQ==
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7636003)(186003)(40460700001)(356005)(16526019)(31686004)(6666004)(8936002)(4326008)(5660300002)(336012)(8676002)(83380400001)(426003)(2616005)(53546011)(26005)(16576012)(2906002)(34020700004)(316002)(86362001)(82310400004)(7416002)(6916009)(70206006)(70586007)(36756003)(54906003)(36860700001)(47076005)(508600001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 01:57:27.2459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3fff15-e3c2-43ac-c641-08d9b9ee164a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/21 5:21 PM, Kent Gibson wrote:
> On Tue, Dec 07, 2021 at 04:36:35PM -0800, Dipen Patel wrote:
>> Hi,
>>
> [snip]
>
>>>> +/**
>>>> + * enum hte_return- HTE subsystem return values used during callback.
>>>> + *
>>>> + * @HTE_CB_HANDLED: The consumer handled the data successfully.
>>>> + * @HTE_RUN_THREADED_CB: The consumer needs further processing, in that case HTE
>>>> + * subsystem will invoke kernel thread and call secondary callback provided by
>>>> + * the consumer during devm_of_hte_request_ts and hte_req_ts_by_dt_node call.
>>>> + * @HTE_CB_TS_DROPPED: The client returns when it can not store ts data.
>>>> + * @HTE_CB_ERROR: The client returns error if anything goes wrong.
>>>> + */
>>>> +enum hte_return {
>>>> +	HTE_CB_HANDLED,
>>>> +	HTE_RUN_THREADED_CB,
>>>> +	HTE_CB_TS_DROPPED,
>>>> +	HTE_CB_ERROR,
>>>> +};
>>>> +typedef enum hte_return hte_return_t;
>>>> +
>>> Wrt HTE_CB_TS_DROPPED, why is the client dropping data any of hte's
>>> business?  It is also confusing in that I would expect the dropped_ts
>>> gauge, that you increment when this code is returned, to indicate the
>>> events dropped by the hardware, not the client.  But then you have no
>>> indication of events dropped by hardware at all, though you could
>>> determine that from gaps in the sequence numbers.
>>> Anyway, the client can do the math in both cases if they care to, so not
>>> sure what its purpose is here.
>> It is used for statistical purpose and hte being subsytem it can provide
>>
>> standard interface in debugfs (so that clients do not have to) to anyone interested.
>>
>> The dropped_ts could represent total dropped ts by both hardware and
>>
>> client. I can add debugfs interface to break it down further if it helps in statistics.
>>
> Updating stats is not what the return code here is for.
>
> And what if the client discards the event AFTER returning from the
> handler, say in the threaded cb?
>
> If you want stats fedback then provide a function for the client to call
> to update stats, rather than piggy-backing it on the callback return.
I agree, will work that in v4.
> I'm unconvinced that stats are a worthwhile addition, and you certainly
> don't need to bake it into your core api.

Wouldn't it help in debugging i.e. quickly check using this interface

if there are drops for given application setup?

>
> Cheers,
> Kent.
