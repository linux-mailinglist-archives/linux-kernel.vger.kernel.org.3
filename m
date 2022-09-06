Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0A5ADD82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiIFCoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiIFCoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:44:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF526BCC9;
        Mon,  5 Sep 2022 19:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEa067bkTQ7ZxhZiV+937vcp65e6lstML+RUWeJgSfdia+/I5Hd00dAC/BpD/2xJyAxCVNq9Zq2xIZLTQllVrAHXwYtDhVcRWJqMM8+GtQ8h0S/H3FCg5ijsLD00xZZKbb3aw0MJpLfnxna84HkiAHRgJTixtgOvor5iNSiRX+Jfv9SjKMdqIX/gLiIZi3rNbI7yjz78/zgBN4TLkZ5L6g9C1QcdXk/RzGURp7tfSLP7p9Q9Q17Xy82IezulqfaDk8nisUHPi15BWxWizcK6AGgzp0pvqK7N1rl4HvwynBfKjhbpg3YwfRDLwct5BUWBU1mEdKGh3motAGudMJB4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhnAovAMTzTq54OVcpTQxkHOCHeLOFZomj+NMAcDpTU=;
 b=SRQZIstWrkKBWBhfAnAW+YT9DXuITSYSXpYOFfGthHgieGqeYZq8/j/HtNl1uOI6boy8i+ZN5EQGsTRQ323sok1F0SscDv7lulMkd1vJgwZksgLJVzyGg9JKLBaYO8gqmRhHA/bgik0KSeVxxO8qkGMWNvxmk6qr/F/Xem2X3B14WFDiwADQRt5b9sQalyKtWh6gBx6n0ZEnYyOEGqhy6d7zdbbax5OQkOuoOapo5xsn+AWk9V7CHjIttjUJzJlx1TdXsO0Up+x0XYjlG9BM6Q3faWR1Df1lJx03sA0xt9zTL4VqO81f3wUzky8yWKvAMJ7gtvScAUTd54HdjeCOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhnAovAMTzTq54OVcpTQxkHOCHeLOFZomj+NMAcDpTU=;
 b=XhKGUBZ5HgtWSELbF/36sx0Lpx1aS+fhwz2heJ4749JBlTh51c9fhFoqYAOi0bkgau66/T3dx6CIJmIMgAsmdn2yQR/RwN+4KzrqXzeoDJk+CKa9Id2dkz2y89eNBrly7aahhMZcG6Lnsp2ad4IXwkAELlXj+bjyPUiwZO0S+SWqxhMasSx6tmd4Gmz3F81qTdRrKD8Tq2oa7sQoVMZBsDATj+4pSvAynyxg4R0fvA7kBr8/k1yfuUkgH0LlCWyghqpjUUNsYl5tWFkuc4OtNKyr+o9HeiWJt8E6yBmuChwhdobL5QASwxcpxnHxNrRuPEi0ANGOYUO3/ARSd9/fOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 02:44:07 +0000
Received: from BN9PR12MB5195.namprd12.prod.outlook.com
 ([fe80::f102:dc46:b03f:1d6a]) by BN9PR12MB5195.namprd12.prod.outlook.com
 ([fe80::f102:dc46:b03f:1d6a%8]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 02:44:07 +0000
Message-ID: <8d33abb0-51ab-67c4-50b3-ae95a5d9fb55@nvidia.com>
Date:   Tue, 6 Sep 2022 10:43:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] phy: tegra: xusb: add utmi pad power on/down ops
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Jim Lin <jilin@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, bhsieh@nvidia.com,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20220816082353.13390-1-jilin@nvidia.com>
 <20220816082353.13390-2-jilin@nvidia.com> <YxS6FBeyS1Cs7xhI@matsya>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Organization: NVIDIA
In-Reply-To: <YxS6FBeyS1Cs7xhI@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:820:d::11) To BN9PR12MB5195.namprd12.prod.outlook.com
 (2603:10b6:408:11c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9de1149-2287-472e-83bc-08da8fb1aaf7
X-MS-TrafficTypeDiagnostic: MW4PR12MB5643:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGUJeY4urzQ8okuVMEC4REXXldJdbh8R9S+HIz2nN9MRYHnjBKRXDP2pSo/kXfUjmIYWO7S8JMsVzTV+AWPBuqVRZ0uX0KVr8dYZbQcAFxOHaRKdwL72PEVfbpQkjFdBLvDkcP1qbaitea9rhsAQ/UdBFigLSvEaPtPFuItUTWGHr4y9YxSpZEWCbA9kOzGcom9JYEbokjF3CmvqyQAw+6lSHIull3UjNSYznWSBux8K6rL+1rCgvJ/Q20B5MOTrOMpT9bKNeg790qTRBJPHaFYhUWy8TN8jvCcJ/7U1KqNkmUTJUGQbKFswsDxwPEYQQSGuiVCi4yYFOZALg2+xRm8dbtc6hYszGxTyyP06HMrlxSLuGisq98KwdO8nGCNfO+KLimfazm9ZXJsgT/BC5YyeVunmrd1324ne1Vl8ZbROh+RTEdfSIlUou50hQEgXAFwVRmAiQ1kptfPb640C5AVjMG8qf8r/aoxI7P8dUs6mWQ8OAxd3Xx8QVTcSWlSHLEUMSJx1Fl7ZxVwZ36+0xjxEWOA18zE7bBURM/oIylQO1FBtBu/n5yxk4Jtnj+tLnZHIms6WJputrPumbwSx/T7CxaLiSYzgG0k1uvY0MQizQzxPEQnhZKISL3IG/t72QTL/PKG0Z2aCPIRFuxMV2hBkTO0dLY++G9cW1dnOgiljq/OCsCi/4CVIMZ6KdEWZLenblZlLZmhatryDtfFZcopMoRHxv7Vdqthhg1PdNY8lRizyp7K3zCdYrRev7ykpd76t3lyTB3NxAl/dOrpdZowwrn+qBoHVO0Ym+9xhvS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(186003)(5660300002)(53546011)(2616005)(8936002)(26005)(6512007)(41300700001)(2906002)(36916002)(86362001)(36756003)(31696002)(31686004)(6506007)(6666004)(478600001)(6486002)(316002)(66476007)(4326008)(8676002)(66946007)(110136005)(38100700002)(83380400001)(66556008)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNJY1JTVVpoL1dYeFhFajBQYmVJbHhXQXFrd0dNUDVUWW5tVktzaVNHRXZi?=
 =?utf-8?B?aXc4aTdqWXdlY1JnQ3ZUd3Y1eXNWRHRkTklvWkFBY0Z0S25yNnJHZVZheFQx?=
 =?utf-8?B?R0d6YzlDRjNlbUVEL2UxY0ppYW9ESmpsa3BjSENGMjJxMTJpVjNlbCtTckdE?=
 =?utf-8?B?emlvd29RQWRnc0FpRHYrSXQzeUEvUndRb2ZUcjVXck1teXpxdjdnclFWWUxn?=
 =?utf-8?B?ZmxWdWY2UUthc2ZQR2xyRG1RT3hmU25LUWVtVUdMaWk0S2VZM3RZQitoQnNa?=
 =?utf-8?B?U1lFdVRSV3JmUW12KzdwTnhWcHduRW15RHVFdkRJQ1hNc1pTTWt4ckhkckxy?=
 =?utf-8?B?aXB6bHBxZ0NhUzVlaXlUYVFEMXc0d0g3eURPOTFmOVFURyt4enFBc3FYMGJk?=
 =?utf-8?B?cUtZYUNNNU9LNEdMRnJqajBBUkVZTWF0MWlEL1AvL3huWldCaSszaWxxeHJq?=
 =?utf-8?B?NlVhbkdXNjlITHpYZE5tZk9mWEdTaGVPMUpxWkpmeDZhQ3JGNU5NeGorZE5l?=
 =?utf-8?B?T3VjOFpnb2FvT1BBMitFblBkamNYTEd0WDhSbkpmUzVQZmtIS3NXd000QWFF?=
 =?utf-8?B?amhjak15N0pNRk1VbXNZQXdsNzZ1d0Ivc292T1hMRUkzQjBsaStEdDdSb2VC?=
 =?utf-8?B?ZHg5cmQ0OXUwaWRFNGxXUThIRldMZWpvMFRtejBnTmdaUGg2ZjVBd1hveHQv?=
 =?utf-8?B?S1crclJDRHFuRUdVKzh3RDZwZ0grRWExRzVDUjdGVktoVVZyRERqQWU2VXBP?=
 =?utf-8?B?cXpqK0dyQzcwWnFyK3V6Sjlzcnc2ektiVnd6TmZKditsMERUblFrNDJEZVZn?=
 =?utf-8?B?VEd4MkI1bUZaemZWQVRyRjFEYU5CNlY1bWQ4cXMzRFJoUEtaaG5pbXh5eVZK?=
 =?utf-8?B?WGpTemdmMFVxOG5YOXJrK05OQ2VGOXg1M3VsNWRRdURmRUkrRDJJNTRsNFFO?=
 =?utf-8?B?bzVLZ2dYUlh5d01BUEovVm5ITTB3a1dCTm55Mm5qNitodmV3Wkc5dU9nSWsv?=
 =?utf-8?B?dDVqR2UyR3MzbVZNM3lSQklyUWtWT2hhT2NuSzZ4c2Z5Q3Z2aERDbTZFaHhL?=
 =?utf-8?B?Nm9ZeThsbDA5Q0hGczNZTUYxdkFKNTkwTkZKaFlBQmM3YU5kb0pDeVV4NGpE?=
 =?utf-8?B?QVNyK1FGZXZRVVIvVEpoUENtbHc5aDJUdDMzWEpjRmtRTStNQUdxSEZONWt2?=
 =?utf-8?B?SEZ2dXZGRncwbi9saFFkdzJRdTl0aWVhL3NaQ01qSUpoaTV0clFpNlV6R3pi?=
 =?utf-8?B?VDloRTFMamVtNUJXa0xmM2VXNUlDa1lDTTZzdklVbHA1YnVLemNrQm5DY1dn?=
 =?utf-8?B?SXluVmZNYWc4bWZlVmZGOUZmZlNYbjlaOW95ditOV2NQcklBYXIwNUQ5MDYv?=
 =?utf-8?B?QzRoNFYxN2Vhc3FETEE5Q0RlYWZpZVZVQTJzaHJqbyt2QmJaeTdGaG5TamNK?=
 =?utf-8?B?QnNFaUY2ODNsWUJYKzYwd0Y1K2JSSFJuaHczRzZUK2w1UVRaT2dKN0luR2Rx?=
 =?utf-8?B?NFJqK0o0MXVuZis1S0orQTVZc3FUY0RKbUlFd2Z3TWN6WElobVppMWFJdHRj?=
 =?utf-8?B?eTBhKzN0WWk3RFdxUmJ2UFNnTzZhSjVTY0FRa2RVWEJLc2ovcFNKNHNRYmFW?=
 =?utf-8?B?bk5maVpnV2w3Q0puUGNxZFNCTXk2cTRJQ3NVblVDTkFTaWZnYm9HOXN3QkRo?=
 =?utf-8?B?Wk9xUlYzSGdiaE9TTGN6VzRTZW05YlJwajd6YmFLVEIyek5HeFJtcnVxa1JY?=
 =?utf-8?B?bUJlajRUUmlIdTRDM3FvTWdSbGZOMzI4MWd3NzkyVUFjaG1MaUpPa3hGSWRX?=
 =?utf-8?B?bFYxMlc5T1lzeGJrNm5LWlJjelFrNGVjVzRjRS9YR2I4UEp5NGFBaHdDd0VT?=
 =?utf-8?B?K2ZGZDlhTFptdmRTdVM5M0grR0Nucm5yYnFDb1hwUXN0TlorTk9neUxleHJ6?=
 =?utf-8?B?ZFZ4KzNyN045NXFuZGVCVkROdTh0dmk4YXJXeHhuWlM5NmlGU0JiTVNmaXBO?=
 =?utf-8?B?RHhqOVYzK1RGalc0TjMyVTAvTlRHaVBPWTFpbXdyYUI4Q3RWYWtnRm4xSkVx?=
 =?utf-8?B?dGZkK2pEN3BJMVlnbkpMV2pMbXU0Zk9EeU93RXg2ZHk3NTI1SGU1NzgrYWxK?=
 =?utf-8?Q?xcN/hWNii+ukY+RnoC3062K7K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9de1149-2287-472e-83bc-08da8fb1aaf7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 02:44:07.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0sZznjMa9Qt/BWcisj2r4jGXYHwQERkywE5f5bPsexsJdkbxD8ouUskFngLsnOLagkEktuYv24FLUtJETL9aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,
Before the device or host is being attached, we can keep most of the
transceivers powered down (PD=1/PD_DR=1) to minimize power consumption. At this
stage, in .phy_power_on(), we enable only the single-ended receiver (PD_ZI=0)
for detecting connection. Upon detecting device's or host's connection, host or
controller driver will invoke tegra_phy_xusb_utmi_pad_power_on() to power on all
of the transceivers (PD=0/PD_DR=0) to equip full link functionality.

Thanks,
JC


On 9/4/22 22:45, Vinod Koul wrote:
> On 16-08-22, 16:23, Jim Lin wrote:
>> Add utmi_pad_power_on/down ops for each SOC instead of exporting
>> tegra_phy_xusb_utmi_pad_power_on/down directly for Tegra186 chip.
> 
> Can you please help me understand why do we need to utmi power_on/down
> exported and cant be handled thry phy-ops..
> 
>>
>> Signed-off-by: BH Hsieh <bhsieh@nvidia.com>
>> Signed-off-by: Jim Lin <jilin@nvidia.com>
>> ---
>> v2: update copyright year 
>>
>>  drivers/phy/tegra/xusb-tegra186.c | 19 ++++++++++++-------
>>  drivers/phy/tegra/xusb.c          | 22 +++++++++++++++++++++-
>>  drivers/phy/tegra/xusb.h          |  4 +++-
>>  include/linux/phy/tegra/xusb.h    |  4 +++-
>>  4 files changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
>> index ae3915ed9fef..5abdf81aa143 100644
>> --- a/drivers/phy/tegra/xusb-tegra186.c
>> +++ b/drivers/phy/tegra/xusb-tegra186.c
>> @@ -1,6 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>> - * Copyright (c) 2016-2020, NVIDIA CORPORATION.  All rights reserved.
>> + * Copyright (c) 2016-2022, NVIDIA CORPORATION.  All rights reserved.
>>   */
>>  
>>  #include <linux/delay.h>
>> @@ -638,7 +638,7 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
>>  	mutex_unlock(&padctl->lock);
>>  }
>>  
>> -static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>> +static void tegra186_utmi_pad_power_on(struct phy *phy)
>>  {
>>  	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>>  	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> @@ -656,6 +656,8 @@ static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>>  		return;
>>  	}
>>  
>> +	dev_dbg(dev, "power on UTMI pad %u\n", index);
>> +
>>  	tegra186_utmi_bias_pad_power_on(padctl);
>>  
>>  	udelay(2);
>> @@ -669,7 +671,7 @@ static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>>  }
>>  
>> -static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
>> +static void tegra186_utmi_pad_power_down(struct phy *phy)
>>  {
>>  	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>>  	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> @@ -679,6 +681,8 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
>>  	if (!phy)
>>  		return;
>>  
>> +	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
>> +
>>  	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>>  	value |= USB2_OTG_PD;
>>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> @@ -849,15 +853,14 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
>>  	value |= RPD_CTRL(priv->calib.rpd_ctrl);
>>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>>  
>> -	/* TODO: pad power saving */
>> -	tegra_phy_xusb_utmi_pad_power_on(phy);
>> +	tegra186_utmi_pad_power_on(phy);
>> +
>>  	return 0;
>>  }
>>  
>>  static int tegra186_utmi_phy_power_off(struct phy *phy)
>>  {
>> -	/* TODO: pad power saving */
>> -	tegra_phy_xusb_utmi_pad_power_down(phy);
>> +	tegra186_utmi_pad_power_down(phy);
>>  
>>  	return 0;
>>  }
>> @@ -1486,6 +1489,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
>>  	.suspend_noirq = tegra186_xusb_padctl_suspend_noirq,
>>  	.resume_noirq = tegra186_xusb_padctl_resume_noirq,
>>  	.vbus_override = tegra186_xusb_padctl_vbus_override,
>> +	.utmi_pad_power_on = tegra186_utmi_pad_power_on,
>> +	.utmi_pad_power_down = tegra186_utmi_pad_power_down,
>>  };
>>  
>>  #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index 963de5913e50..49873718d54a 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -1,6 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /*
>> - * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
>> + * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
>>   */
>>  
>>  #include <linux/delay.h>
>> @@ -1458,6 +1458,26 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
>>  }
>>  EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
>>  
>> +void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +
>> +	if (padctl->soc->ops->utmi_pad_power_on)
>> +		padctl->soc->ops->utmi_pad_power_on(phy);
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_pad_power_on);
>> +
>> +void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +
>> +	if (padctl->soc->ops->utmi_pad_power_down)
>> +		padctl->soc->ops->utmi_pad_power_down(phy);
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_pad_power_down);
>> +
>>  int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>>  				    unsigned int port)
>>  {
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index 034f7a2c28d6..8cfbbdbd6e0c 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -1,6 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>> - * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
>> + * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
>>   * Copyright (c) 2015, Google Inc.
>>   */
>>  
>> @@ -412,6 +412,8 @@ struct tegra_xusb_padctl_ops {
>>  				    unsigned int index, bool enable);
>>  	int (*vbus_override)(struct tegra_xusb_padctl *padctl, bool set);
>>  	int (*utmi_port_reset)(struct phy *phy);
>> +	void (*utmi_pad_power_on)(struct phy *phy);
>> +	void (*utmi_pad_power_down)(struct phy *phy);
>>  };
>>  
>>  struct tegra_xusb_padctl_soc {
>> diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
>> index 3a35e74cdc61..70998e6dd6fd 100644
>> --- a/include/linux/phy/tegra/xusb.h
>> +++ b/include/linux/phy/tegra/xusb.h
>> @@ -1,6 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>> - * Copyright (c) 2016-2020, NVIDIA CORPORATION.  All rights reserved.
>> + * Copyright (c) 2016-2022, NVIDIA CORPORATION.  All rights reserved.
>>   */
>>  
>>  #ifndef PHY_TEGRA_XUSB_H
>> @@ -21,6 +21,8 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
>>  					   unsigned int port, bool enable);
>>  int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
>>  					bool val);
>> +void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy);
>> +void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy);
>>  int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
>>  int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>>  					 unsigned int port);
>> -- 
>> 2.17.1
> 
