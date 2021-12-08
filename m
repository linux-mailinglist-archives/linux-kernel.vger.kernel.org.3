Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31946DCCA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbhLHUQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:16:09 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:15360
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhLHUQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:16:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iynJ/Iu75Cf7drJzPCdXdo0xtzkJLr7LcKTWMoAdyJHjeV/51/alBxdfQ3ajQ4JKeznJ/PgVDDj/ZXK9ZycfPDq1hIU9zp+OyKDm73QXqmRr/x4KJmibF8NO4SjyKhxT9w4IObuL/kCZpCqhu9ZesNltmnft4fn6dWAFn2OO5/Hd68gfAESLg/KnI//KrQqbOeivYpxBb3uAYGWW98oh+/UUC4uv9BFn1ieCdjvU6hgtZO7V1akTNcU3o4XTCE6OGOO2lcSoxVSnHSwQOnfy5EDaF/GMK+3Vb6FQuoBkK66iDbJdjykO34vq0ROLB+nlqanSEGOSy1BEmHrS+w1n/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz7Zd0rz8zzz/vbMHckCTnl/eEg111NdvyIQkTwwZ28=;
 b=gF/60h4M/EVmmSoO5W1isN7KqqSqxaISnO0x7WkbIDWzCyhuJ4r+ZShixDcr/ixoHVOYwSnsUhkSlgqDylRVsuJ0H0FXo9hS+WKCoEoiSN6Q7c/VnuOfRMVwFC1+EyDgnTb1mJx6e4GIjWox7kDeMVAvjkB+B1YOd5TgFZgkNZUN+CuGMzzCgxNxe8gRm48LptYKB8Gf03FXkeGYNUN5OQttmQq/g/8vFuwCLpSOhevRFqIL6Y6wfw4MFE2sKENGUUy4ZVm4eC68V4Oh7N+XoNyI1R2P8mrSANUd4AnkDRw3KzlIufn39zYSMyAMQaNUx61Y5E/xuhtetIWcFjn5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz7Zd0rz8zzz/vbMHckCTnl/eEg111NdvyIQkTwwZ28=;
 b=qmE1CnJhkpIo040GNdWXrhvn5PKdbWoIFRBsUr7RK+knlJKYOoKtmppnqBroMKS5KdtdNm1rUqp1ybFTGHCVt9XSz07QxZUsK4gnDZ4kYUFKXRRk4+TJNcvVt1dwvlAnTyKQkwvGpi6VM5ykf7Ke087N5KqC9Cpm+6wquCfpCRHcmdtcVSXdNnKj7gELtJ8K0DpC7dzLIHvqWFa/LDUroD9rFNDWRKm23Rx+H5wmvLQl23TMc7ezZEoU8FZXDJftvP5SBZ9VpbX8L0DpD6hphHTpiN0tieRLo/Dd9TKxr72ipZq4ZmHlFoW6SbKWk7b/kt2C6XCgQSojq3vi6/N98A==
Received: from BN0PR04CA0183.namprd04.prod.outlook.com (2603:10b6:408:e9::8)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 20:12:32 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::a0) by BN0PR04CA0183.outlook.office365.com
 (2603:10b6:408:e9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 20:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 20:12:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 20:12:27 +0000
Received: from [172.17.173.69] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 8 Dec 2021
 12:12:24 -0800
Subject: Re: [RFC v3 09/12] gpiolib: cdev: Add hardware timestamp clock type
From:   Dipen Patel <dipenp@nvidia.com>
To:     Kent Gibson <warthog618@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-10-dipenp@nvidia.com> <20211126013137.GC10380@sol>
 <9ad666ec-eedd-8075-73e6-1e47a1eb228b@nvidia.com>
 <20211201171638.GA31045@sol>
 <4c7c3db1-a1b3-1944-4278-cb37e8a4f373@nvidia.com> <20211202005349.GA7007@sol>
 <395ba111-d620-f302-d0e7-8f20f39e6485@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9e53c30f-63e5-b2ca-a2ef-f85dab596b3c@nvidia.com>
Date:   Wed, 8 Dec 2021 12:14:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <395ba111-d620-f302-d0e7-8f20f39e6485@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 816c92af-7ba2-44b4-cdbc-08d9ba87111a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB406312C92A94E7D86CB0C460AE6F9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8lvQ/kXbUQI2ra0sELa5JgCDYE9nX4xjQXaKZalSjVtZnHtOLKKp/LATm4ljXTWrV3LONjXRBA4Z6nC5l436BRiNuloEj9ECuNMF5bRJRC1KLtahQAUyDdBuF/EAQ+3z4VmWwhgOJZd49DuxMb+twCP9KQJyjV0KgOaO5zEoKyjOmiKZHhkHvFDo+ZmTiCot132Z3X3lpIHh7qTn7Lai2mz9sKOinbsRS/4w4287UgYxTVYY9aorHCwabSDivSkpYPOIT4VoSKqx0ewcO7x+4B7WYhC7+wk2ULPwj5LUiZ3BsmIOTgO6dLW0qX/Dx/iY9MC1I2GAu3l1gwTqZFecrG+443+ATsp6A/fP6qvBqgUXGqMn1gGTPORQbQpxUcDIMlQF5SLcci8KcAIldTmnbGw7TQi7Tq3btle+0QsSdrwPQyl37YK5dNXsT7OUMMslXMVHL8SjqsRybDj7YCxqC1jm4Y/5LOFJ6DfjNQ+IWTA7GxryWVlhMQyqsXb5iX0qSvQDQ3t83G8dxSm46TXDX50CfLT8+3r+sUS9usFDRcN8OKhk65t9vMs/Ds9rEm+UEFN15j0GAXUv9it5QsIOQM8vlSnpFPLWqScGfhE6ziJsRUINDmBxq6IcrlUldy1eVB3B7JI5jB+RReEd0NNYq3BxFGos8sqskBfYEuydpe8oFVh4TJdBD2h9OubbhVjFQVWpgSHiTxRwD2mXm3AuF2y4fYosgyS6GAkUAOL6o5z6hFFqzEQm0/bQRrvcbGYQlX7RUMejvjHUEsGMflc0zW3jOux0BGijpERpR5upKQTOO7Tv5jHFVHDZXK4L4Rt67B/eTma+Prb17VPNPZTxg==
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(8936002)(86362001)(26005)(8676002)(5660300002)(336012)(31686004)(31696002)(7416002)(4326008)(70586007)(16526019)(34070700002)(186003)(36756003)(2906002)(2616005)(70206006)(40460700001)(316002)(16576012)(54906003)(82310400004)(6916009)(7636003)(36860700001)(356005)(47076005)(508600001)(53546011)(83380400001)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 20:12:31.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816c92af-7ba2-44b4-cdbc-08d9ba87111a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/21 5:42 PM, Dipen Patel wrote:
> On 12/1/21 4:53 PM, Kent Gibson wrote:
>> On Wed, Dec 01, 2021 at 10:01:46AM -0800, Dipen Patel wrote:
>>> Hi,
>>>
>>>
>>> On 12/1/21 9:16 AM, Kent Gibson wrote:
>>>> On Tue, Nov 30, 2021 at 07:29:20PM -0800, Dipen Patel wrote:
>>>>>
>>>>>> [snip]
>>>>>>> +	if (line->dir >= HTE_DIR_NOSUPP) {
>>>>>>> +		eflags = READ_ONCE(line->eflags);
>>>>>>> +		if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
>>>>>>> +			int level = gpiod_get_value_cansleep(line->desc);
>>>>>>> +
>>>>>>> +			if (level)
>>>>>>> +				/* Emit low-to-high event */
>>>>>>> +				le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>>>>>>> +			else
>>>>>>> +				/* Emit high-to-low event */
>>>>>>> +				le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
>>>>>>> +			/* Emit low-to-high event */
>>>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>>>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
>>>>>>> +			/* Emit high-to-low event */
>>>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>>> +		} else {
>>>>>>> +			return HTE_CB_ERROR;
>>>>>>> +		}
>>>>>>> +	} else {
>>>>>>> +		if (line->dir == HTE_RISING_EDGE_TS)
>>>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
>>>>>>> +		else
>>>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
>>>>>>> +	}
>>>>>> The mapping from line->dir to le.id needs to take into account the active
>>>>>> low setting for the line.
>>>>>>
>>>>>> And it might be simpler if the hte_ts_data provided the level, equivalent
>>>>>> to gpiod_get_raw_value_cansleep(), rather than an edge direction, so you
>>>>>> can provide a common helper to determine the edge given the raw level.
>>>>> (So from the level determine the edge?) that sound right specially when
>>>>>
>>>>> HTE provider has capability to record the edge in that case why bother
>>>>>
>>>>> getting the level and determine edge?
>>>>>
>>>>> Calculating the edge from the level makes sense when hte provider does not
>>>>>
>>>>> have that feature and that is what if (line->dir >= HTE_DIR_NOSUPP) does.
>>>>>
>>>> As asked in the review of patch 02, do you have an example of hardware that
>>>> reports an edge direction rather than NOSUPP?
>>> No...
>> So you are adding an interface that nothing will currently use.
>> Are there plans for hardware that will report the edge, and you are
>> laying the groundwork here?
> Adding here for the general case should there be provider
>
> available with such feature.

I have a doubt as below on how edge_irq_thread calculates le.id (Only for

gpiod_get_value_cansleep case), i believe clearing that doubt will help me properly

address this issue:

- Does it have potential to read level which might have changed by the time thread is run?

- Does it make sense to read it in edge_irq_handler instead at least of the chip which can

fetch the level without needing to sleep?

>
>>
