Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA637485BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiAEW50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:57:26 -0500
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:22624
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245153AbiAEW5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:57:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rncjs3U5miZVV8ymAq99aa7EXH7+txZpi07zFfVxUE8cwF0s2asyMnwGvd/+ntgBrzARXdqC+N0nVneotkA4dau7x+gqxJqZ3FlwwKajmtwT3fQOv24NdgGUNNaIhTTGWNqTDOrLGiK7sBqocHCtJveDmb63dEZUf1/UzcEapMJKzYj/gVJseYDk1PvLUf84ONBxynntK4qk2hkAuS+Gast2NavmICfY2PRbOk5WOUp8hkp0s+Yq3gIQmLYWdYcukmMbhppridqfe+mKHJPsmKGBIt6NOquIN0keWRM7P2Y2h5SilEBeV5ZbEB4X7DC59dKU92HFoFIb/F076siKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Jml4yKGgz+x3JaOgTvWcF5aVgmK417mgRLejxz1iTU=;
 b=Bv3zBky1vvmpw8dDRAWNgHyCP9mdn80pDC5h5MAaDWj7MVogUQtsxTIqBO9ZYZhQfKVFPtN0AQi44Av+BPLE+aSfTMkUhF+gLDN+yOwwmu6laEOR+XmvgNUaRtP8aJFtPL88bWl78AhJUPhqNJ9Klir7AE8PoZiUOja1XROGdIPMwtTvbAyffnaKG7Ek2H3SmftZKhBh/lxnmoSUZpuR3MorWb04juFiSIEcUnetLitsnZAzZvKa9tJfVHYD2UjFB6GB9CwjK/TNAcmWC37ATM6XwxkmEI31vlsIcNdUyQe/JzF6gu1OmveTGwQvcc7S2Zs7ahKzKR5U6Cd5/iEWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Jml4yKGgz+x3JaOgTvWcF5aVgmK417mgRLejxz1iTU=;
 b=PihulWsKd0WF/+YdjmVq6i/qhYNT0I1qmx5T5a9lrdmF8+qth+F5KpU4sRuoi73nYLb6Ga36441F8jSkU7qLS8gGuqiNofGqdeVTZozsNwaPnT1OkaTENn2nXpQ/kwKEcThxpigEqk6XSt3KYYUpE85ca7mMrrRrnr9oUNoSX98H8qz7fTaVVS7PKg192pKnjds/r9K8K0hs4kqyFzJYAB8YXA4xn9UY+kNI8BM+ER3vRlf4rVvGxiS7gny5idvVIXQcMechFSKcOiEPieHeeY4+9FBVCc+/xJO7bqb5HdwDJr3z7y59twGNoXzjjBd65YBg4UvEX1fPvxPYf41TNw==
Received: from MWHPR19CA0014.namprd19.prod.outlook.com (2603:10b6:300:d4::24)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 22:57:17 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::29) by MWHPR19CA0014.outlook.office365.com
 (2603:10b6:300:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 22:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Wed, 5 Jan 2022 22:57:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 5 Jan
 2022 22:57:15 +0000
Received: from [172.17.173.69] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 5 Jan 2022
 14:57:13 -0800
Subject: Re: [RFC v3 09/12] gpiolib: cdev: Add hardware timestamp clock type
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
From:   Dipen Patel <dipenp@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <498da060-b02d-528a-9dbc-81dd22fc13a0@nvidia.com>
Date:   Wed, 5 Jan 2022 15:00:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202005349.GA7007@sol>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8fda927-a3c0-47c3-c207-08d9d09eb861
X-MS-TrafficTypeDiagnostic: CH0PR12MB5234:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5234D1FFEEC254BD8EAD91BBAE4B9@CH0PR12MB5234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 251phr4WELwNemvji/D6p4OxDyhELrn8PjGzuodi7BDhYlUfCT6mtqU0hlDa+KQLjvQDsUq5oIhwwaD5/faYvvCSJwUCzMpZ/cu2svI/hce9JeKAQVyWcDsvp6KLbOqWl96tDUPjiB/SV+Es4ahCxBkJ/fJ/2UJhP60usqt57H84mJBEn3lmnpKY/cZEEJSo6RRmVAF4pJS2BgJ7hg+D/XxUUYOzeelOV+8sJBHJcvMijJby2qDDPynCQShqvHuUvcGKa3AQMEU53MxjvrUp34sJdiRBvWQ8/lYyta7pwx6tcOBZSDsOl0HNzPeIx9BR/xk+Ysi5WP/uXzaWfURUSYCimyd1QUb9H/ky2iHI3ATzPl0Jv5VkKGohIx8k9vtOZmxSi6P6pmvC/Hmvu+HYrwZRjcAW8hc6SKqj1VkZ6Owz8hpR0MF1cbR8gEPlYib1uHBRrRdcYV96kdecyXxWzBvVvY0h8H/7WFrAiIz6Yl6Y+TPiK6P9rDhpEhXLJpKfQeK7nYcpCKDc3+N33F3nLpE5QONZzJLdw0e1B/uSfF5vLgUijQZnT5c5gdf6VwylM5hpa/kARpern0Dj+iIZn/4xxeFYMMQ+G7PPFsuThvdWBq4vOjkVdS+xHEp/rRa0Zgc0mA76LwFi9fyPOpK5IlFaY3yYRZsQzdygztc4dn7YdiXVOBR9kz0Cl0YtlvKOOW3UG5mYDAzTmQRsF3ZyctAgb5T1JU0mOEJK8Taw3E8GdHPe1+QPOGxjMBpbm+zDm2o5896iWSm4Ycsbg/pJkNofLex9kolIQXk2ZYL2yk19hR6xWIphyxIkJzQYuPSTX1/1frb+HwXg0XSA0nE7eg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(36860700001)(54906003)(31686004)(6666004)(508600001)(7416002)(40460700001)(82310400004)(47076005)(2906002)(336012)(186003)(16526019)(26005)(8676002)(4326008)(2616005)(8936002)(70586007)(70206006)(426003)(53546011)(86362001)(83380400001)(6916009)(36756003)(5660300002)(356005)(31696002)(316002)(16576012)(81166007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:57:16.5366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fda927-a3c0-47c3-c207-08d9d09eb861
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 12/1/21 4:53 PM, Kent Gibson wrote:
> On Wed, Dec 01, 2021 at 10:01:46AM -0800, Dipen Patel wrote:
>> Hi,
>>
>>
>> On 12/1/21 9:16 AM, Kent Gibson wrote:
>>> On Tue, Nov 30, 2021 at 07:29:20PM -0800, Dipen Patel wrote:
>>>> Hi,
>>>>
>>>> On 11/25/21 5:31 PM, Kent Gibson wrote:
>>>>> On Tue, Nov 23, 2021 at 11:30:36AM -0800, Dipen Patel wrote:
>>>>>> This patch adds new clock type for the GPIO controller which can
>>>>>> timestamp gpio lines in realtime using hardware means. To expose such
>>>>>> functionalities to the userspace, code has been added in this patch
>>>>>> where during line create call, it checks for new clock type and if
>>>>>> requested, calls hardware timestamp related API from gpiolib.c.
>>>>>> During line change event, the HTE subsystem pushes timestamp data
>>>>>> through callbacks.
>>>>>>
>>>>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Added hte_dir and static structure hte_ts_desc.
>>>>>> - Added callbacks which get invoked by HTE when new data is available.
>>>>>> - Better use of hte_dir and seq from hte_ts_desc.
>>>>>> - Modified sw debounce function to accommodate hardware timestamping.
>>>>>>
>>>>>>  drivers/gpio/gpiolib-cdev.c | 161 ++++++++++++++++++++++++++++++++++--
>>>>>>  include/uapi/linux/gpio.h   |   1 +
>>>>>>  2 files changed, 153 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> [snip]
> The code here has to deal with the general case, not just the one example
> driver you have provided.  So in general there COULD be gaps in the
> ts->seq, right?
>
> I do see that using the ts-seq for sw debounced lines is problematic
> though. The debouncer itself will be discarding hte events, but that
> shouldn't be considered a lost event to the user.  You could track
> how many events are discarded by the debouncer and subtract those from
> the sequence numbers reported to userspace?

This could be little complicated, especially for "hybrid" scenario where

cdev debouncer receives partial events to discard and rest is dropped in hw fifo

in hte core. For example, if there were 5 events to discard before debounce period,

cdev receives only 3 events to discard and rest 2 is dropped in hte core. In this

case, when debounce period ends and work func gets executed, it will take 3rd event

as that was the last seen in cdev debouncer. This makes both ts and seq unstable and

out of sync. In the absence of actual hardware which can drop, its probably hard to

simulate and implement complete solution to tackle this.


>
>
