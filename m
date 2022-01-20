Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1406F494667
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358448AbiATEVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:21:31 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:14208
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234241AbiATEV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:21:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esHPpF1c9JTMPMQuAD+HznC6lucQZEjEgSqpsL/ennSVwEZxqfoCwqC1JgFMLXYHdgUlsx4u+fczExv0Wah+5+Z17ATMIOTtWXVNO6SCR5wPq48gyz4C2jJV6KOE8hzKTd2Y/wd29WOX71PSWdqNwltksZr6n5IINsMV/C1fL1f/39LLGZRy7WiNNC/+QZ9l+QwOrEf2kixgBCkFMyV6eLIc6fdtES1uz8kvUpzZCerWvni5F1eyyu8tGPjMZnbuxgQ/oMtDzsiDInDa1/WZQ6VjMAW/S1SagmUaySE5B2RBTXPxc59grTB6O0djUTB7Il6ZcWWcS3TDqa0QkEjSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn0w3XJ27eMZIndDTf2Ydk/4dK/B3Yo96DPLin3WC8A=;
 b=Z0ReG5ZoPSLZy/HWwJt5LJtl3231o83AVRLmV7DtMLPpwtZswmAhDFCkXVMrk1Eo+aIsvopZmc1d7rq3B8V/TNMjTf1c3YhV36mfxn5LVZoWeGIWWsC54QdYLQAUKIhcH3ozsND0ASKInexJtlatorQJyD/PR/ntp1By1q0dLg0CWp9WZmA22uWg9gQ6eC8YTCxejdF+GiqEnwWewOn2jqhtHjIIhbKxI4KsH6c9faOKL5CwFxTsrQ7H26n9ClEN5zxmpLj1/JZ9OX0/Nh5Gi7XtZ0pmaO186DWIUmW17dvRLr9gKo4ND+8ThHUTSY4qrzloh/vx1BTKolRSbW6Zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn0w3XJ27eMZIndDTf2Ydk/4dK/B3Yo96DPLin3WC8A=;
 b=N3MV0LcV5kt/6VX/Epib7lsB3SUULwJs61LfnHXXUjt5TQ43ArZiiP9rPW0y9NxdDelqU3wyVy3GIQT3RPxEKlClfYfBQJuc9zA2pVzFiBkTsuNM2ApYZ/C5Uo2tUSrubI4/TrcrgnWRsYnBLtZGhvTz/XbG7j6wHlWUeg2FQXa6lNl1N+jBGt9tiz9exgnHhlJRr/VWfum8R/TnPlScEFXYFQ3bCzBe0Rwq6jFZ1SpoeUZxzZF07XbaYgCmxz4yZmACj3glNTVK13tMtD5jSKqy77wsAfvnLKpLHFWhstZ3tVDQyHiDsLJlD8Pm86FG7uYwJZEMTRtuCCr6ABNupw==
Received: from DM5PR13CA0050.namprd13.prod.outlook.com (2603:10b6:3:117::12)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 04:21:27 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::20) by DM5PR13CA0050.outlook.office365.com
 (2603:10b6:3:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4 via Frontend
 Transport; Thu, 20 Jan 2022 04:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 04:21:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 20 Jan
 2022 04:21:26 +0000
Received: from [172.17.173.69] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 19 Jan 2022
 20:21:24 -0800
Subject: Re: [RFC v4 01/11] Documentation: Add HTE subsystem guide
To:     teng sterling <sterlingteng@gmail.com>
CC:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
References: <20220118002214.18271-1-dipenp@nvidia.com>
 <20220118002214.18271-2-dipenp@nvidia.com>
 <CAMU9jJoFAG4taoN0SSbVGPFMKyUnkT9VkrtatGuRpU-ek+hJ2g@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
Message-ID: <7c8a32fd-8233-cc69-d4d3-668a3a14aa14@nvidia.com>
Date:   Wed, 19 Jan 2022 20:25:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMU9jJoFAG4taoN0SSbVGPFMKyUnkT9VkrtatGuRpU-ek+hJ2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f646ec52-0f0d-47c6-d872-08d9dbcc53b3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4316:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4316AFE56174E1546C139950AE5A9@DM6PR12MB4316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oz24bH1NFn5NzFaCZVJb1kRH09u1pvFlIjI+gCpNbfj8E3LbSO0ysXl/hpTJXgi4sNe8Iy7VH3Eb9xvufyy0nKVrv8UwMVWevRT9hP1ARMrb4VSi3nUTlFzy/ThLT2mOx20s+IfyjYg+FVDdczKEQpmW1iY7ydd95bWEJN1TnBpvOFIRNCZYRCpk94ExIkk2olfT0caUiriIBttQdLsfqgG889pjEFQA9ZTpul+TTpnxb2hPIw9BWUoDfUwdI4wmo+fZGEb9wSKcHJgd6WaQtNm5yH3lGNDxCeNX8jnZ8jhdRBEBu2LD1U8aVwpoeJI4V286uqsNQokc5ak0IQLshAMidUzycfAbrSvRgrISIDien8K17uzFrBTWoMcnUDCTKgm8Y4sb5b9Y7LOKK2+/tdZG2DeYBSiU46x6PKw9do2xARE9jf8ZeMTp+Cz7607OoeWNB6/elhfBQDg3NXWqIN70tp7+6pYNsA2RkY0iPaWdXN8bOJvK771IfeTqDbCuSmW73kra6cQx1ssFc0j5mmOVM91drImnH4J0LcSDyPGXt6tevm9c8w3IGOt27VEHKF2Yaal5OsRv8k4XFHXuKvOn8VLOM7OzFqFfrJoSbISFzC8gZfruHgN3/pIgiNDfcHhZpy+0nRUNTwGVJmVI1xIw+O7wUIOrT//nEgX+ubjbuZZ31jD1l+u4RotOEsBcfIF1ZJaTtcDzujWp0jRCduHyXq/OfmBMW8cFPBYLFh2Qa9HZT835yd1C/YfrgzT6v4gAHQAsI4+1o+o4n1gbaySb1Xoyfy2TsA1vAMKAF8EHeiwksVJ9UE6TotmjFKAQCxXywZNlSAgHgD4IOeLxKw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(16526019)(2906002)(508600001)(186003)(54906003)(336012)(53546011)(31696002)(26005)(16576012)(2616005)(6916009)(31686004)(83380400001)(426003)(8936002)(8676002)(47076005)(36860700001)(356005)(4326008)(6666004)(40460700001)(70586007)(7416002)(36756003)(70206006)(82310400004)(81166007)(316002)(86362001)(5660300002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 04:21:27.2648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f646ec52-0f0d-47c6-d872-08d9dbcc53b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Teng,

 I believe I added in patch 0003. Before sending this patch series, I did make htmldocs and did compile successfully. Let me know in case I am missing something.

On 1/19/22 6:03 PM, teng sterling wrote:
> Dipen Patel <dipenp@nvidia.com> 于2022年1月18日周二 11:06写道：
>> Adding hte document which can help understand various APIs implemented
>> in HTE framework for the HTE producers and the consumers.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>> Changes in v2:
>> - Removed explanation, instead added kernel-doc references.
>>
>> Changes in v3:
>> - Addressed grammatical errors.
>>
>> Changes in v4:
>> - Added new API hte_req_ts_by_linedata_ns description.
>> - Removed hte_req_ts_by_hte_name.
>>
>>  Documentation/hte/hte.rst | 83 +++++++++++++++++++++++++++++++++++++++
> Hi Dipen
>
> A document build warning will be introduced，Need to add it to the index:
>
> 1) Create Documentation/hte/index.rst
> 2) Add hte/index.rst into Documentation/index.rst
> 3) Add hte.rst into Documentation/hte/index.rst
>
> Thanks,
> Yanteng
