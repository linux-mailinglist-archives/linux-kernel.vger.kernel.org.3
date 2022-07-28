Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA673584430
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiG1QcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG1QcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:32:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B454CB3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBeZAodvdpfcgbqazXDsjWt5LeTFyx9O330KJfmZBD+SllWenqilSdfQlqjD4BM+8EtJGOzhbhlYDLSV8zvSrRSv5Ioe0CIInGHyrNIbUh+uyruCC5HyGGhxBV5G/Jxc8PBt3pZKdaPrr6TeLAzo+zoMzoI2U8ejFsZncw37Sqjd8ymcleXnZX07yJK7p6U0YI1FlxrdbjWp+TM8sqzKtKsiarzKZws/GXEKX3/mWBpTLASRsNSIn4iSx/Z8uQQnuPfgDScy2T4yGeUVwvMgaiGU5xnfB/F4EHb9C8JoJDGWLYikMKLAV1zVpXgN8BD/VC6djccO3x4xCsa1KaVrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6//We+O7AzLOkVwJnaqDuRbyCgnO3m4XcHQ05QrMv4=;
 b=KU+CzP0nG4DHGorIUDL81rwvD4Zd0pQTXVyz1Ls+i1Jgo7RS6SpCUoXiCYQ5evKYfZm2ssPSH3arj1vU/5mIC3MheGgLfUMeFU6qMjkQTxomJ2dKfzrbHUSsr2+qJ/EQpEz5k+ZWxb0uAFUA/Luac0+LeBsFz6PVpN0PjIWg0wYs7XjmWhRv81s/RqTEZWiY61LBwbmCvjLjr6Z7e9jYOs/MgfIyBA1unA4aJkpOwyjsPBJrb0mHoYtbv1cOzbToar+hSvN7X6OxxBjF/ea4Mg25Tpk1nk3AWapEJ8fOo1iflzw04wNZk1iUEVeQVR2lqOQuJjzH+PNXlKStnQ05AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6//We+O7AzLOkVwJnaqDuRbyCgnO3m4XcHQ05QrMv4=;
 b=g6Me3DtR5wYTrwXd/1qZQIQrpMTMGCVXUwg98wlRKJajs2OgYb8AofWwmEfg8IezOfMawDd54TEyJCxjzk/kdyUcSRSL6ieuJpzJ+2YzjVqyeBc55AJPmCqpP7tSFyWQtvosQHSr8OMv61/QVo8bJZLYj/4CbSs/0FfGJmA/RF7v8IQXD07PZ7Zu4p1g+jAIy8WZdmS0n3QmgG7Q/u4cE7gCII/RiFhuVYUhC1p98/RyvGenn1Gz8JmLkF8/6MalKODaBQhmmwA11POZ8pTDuV+Ozh/6/4meMv3/+nHz+rSJID8Upr8JAM6FjONmYaAFPt2TYlisq4xSV4B6EdShUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by VE1PR03MB5822.eurprd03.prod.outlook.com (2603:10a6:803:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 16:31:55 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::7d32:560f:9dd0:c36]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::7d32:560f:9dd0:c36%4]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 16:31:55 +0000
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
 <501b52ba-7691-0263-c007-38174c7e5c22@seco.com>
 <20220728152815.6h4ytx52ll2gzjj3@skbuf>
 <532c8141-2a8b-6842-c9a2-cc4d17afd73d@seco.com>
 <20220728161948.gzc7kekygrfdumq6@skbuf>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <97f030ca-fb8c-3ff1-0b8b-12571cf11249@seco.com>
Date:   Thu, 28 Jul 2022 12:31:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220728161948.gzc7kekygrfdumq6@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::27) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c96118-f553-4cda-8a3d-08da70b6af35
X-MS-TrafficTypeDiagnostic: VE1PR03MB5822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8yw8rRlajHhGVFOemKez9uKJj+K8YWYY2DwOY0iY6SFTaiLpLap+ix6qMJYe/mlrAe9ELzsA5wfUoCkR16pGdioaj/00SuCyPvn+ETVxHYbTMlYqQrZIedo4XRQHciV+LKvokL63xuEiMd8JWMRnDQBxCG2bPHXhQzE7ByR7OuwGWstzIbtB3qHPzfqYtwHfWJH9Ofh0O4SuS6qLxPvuvu7tKUzLTQyvZCzormkrYBUxRgiTUzAMkngV62PZ3OCS4Afqh1vD7CaxISJ57ztGX4BgfD4aIig0LZbN4WTNCWNfHo0cob1J2tR12xr2DkmpykYrak25ZzO6MXELuWoI8pKpQoEe2+DzHupETOmQICPPcM6+927UggOHIa17+UydOGxxxOoZ++s1kA6cc0cTtIuL+ZRBDHueCp/tkrvXF5FY+pfGmzyTR5uX0SXreB47L2Nt6iLaEnbAv8UaB+SWMdC5s1ItSE8/G+0DWsyMUqMYLj+IMGLueQfCjifkSVxZ2BW7WtHWw1NemYK+1G2PyOWkyNm8DF0ZLyHXJxSOp3kbHMokL0uTdI94WUTQkkxPE20Ev4twITli+KDK/NL5R5FY58uUMdSbGdRTWzIHG0xSAxgXtTtGlDzQTYge+92u9kn0B3r0Fn3dcUHQRxrnCFKA2uxkVXk2SYpeNe5yDk3iGR9yGE6C+GvL7R2al0atgVl5Xm3ZiH7fe/XcR1ueJXXudSU5koXgRpzw5d+itz2UYrGd0stVHkL/quOP+pUau5n8RhZlkTvaYjrUab32LiExRLoNAhpJn+ZWy1+7QBjnpwrFtL8UwjkmMVSrGG9n7dhKE/dQftcttBJa9wW1p60qRStJcUbH8oA1kkDwt/Yy917M12ofzW3QW7Zb0TO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39850400004)(346002)(376002)(6666004)(316002)(53546011)(2616005)(86362001)(54906003)(52116002)(31686004)(31696002)(36756003)(6506007)(8676002)(2906002)(66476007)(66946007)(41300700001)(38100700002)(66556008)(38350700002)(4326008)(478600001)(83380400001)(186003)(26005)(6512007)(8936002)(5660300002)(6916009)(6486002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDFlZmlZYnlUWnp4c09XQytEem1Nc2dJYU1ubXRoeE1VWS9aK21scHNoZ2dV?=
 =?utf-8?B?SzM2bEVFV1VndTJZejM0TVdaNGZFUUQ3VjZRZTRKTVUrbm9nQ3E4NEtJUSs0?=
 =?utf-8?B?RHBCMWhQaFFnQVRkaEprY1QrQzA0ckdJbVQyK01PYktiT0RkZ1pwb2VVQUJj?=
 =?utf-8?B?dHl5NlVoVWZwTE5sUlhNZE9PUm4zNGZ2WVh3SnBtMTNaR1RaUVVDaElSelRQ?=
 =?utf-8?B?Vm9wOXpmVFYxMkJrRGEwbU42Njk3cWJKTVQxRWQzL2NsWkRac3Z1UEFjTysr?=
 =?utf-8?B?V0VJSlMrSXZsaCsrSlNFdlY2bjlIc0p0YklUVlRZd2k3WWRadGdMa2NrUVlq?=
 =?utf-8?B?TVVHa2szTm9QdUROSTVJNUh6clcyczZZbE5aa1dpOUdWeEJJMGM5c3lSV2F2?=
 =?utf-8?B?Z1JkYi96T2JnbzY5akFaVTBicVlsc2JuTnZQRDZhMWt3bEtNYkZsR3U4Ym5D?=
 =?utf-8?B?djloZnZ1RHpnVngzWGFSLy9mSVBjUTNOa056NjRJYnV4bkNTRnY0QTIrU1NS?=
 =?utf-8?B?c2ZmNjZkamM1SzF6SVBpZFk0WjZWSEN2Z2xodXdreEx1ajAvYVFkSTlTNmM4?=
 =?utf-8?B?VDFRSVNBM0ZWVXRSc1dYZWJ4YWNIK2daQVg5a1lQT1UvaWx4bGtKRGlkZnFu?=
 =?utf-8?B?TWpwekdRK25rUjRyY1A4Sm9KbS9yajhHNDVDNElGaEVxUW9wbzZQc0ZmSEdo?=
 =?utf-8?B?VHNnVGxoVzlJNjdRSGpab3hRTFFEOEpselo5TWh4ZEpidHJGV09MaW5NcW10?=
 =?utf-8?B?ZXJmL1V2RG5jTUd3aVBzV2NuNGFyTkN4cDZURWRJQnVwbXlzTStYNzRQeVpt?=
 =?utf-8?B?MkZVS2tJM0dNaGFjMkY4OGpGblJRVzFqdlZFQWJJSXN4amZGcVYvMjNCbUx0?=
 =?utf-8?B?OWQ3a0VJK1M3a0lNTkt2bW14cjdTcmhmMDNpU01wWW91SXg3S2RBSzZPMFJr?=
 =?utf-8?B?K21tRThtS3dMai9mL2V0NXRZdm1iUXcrdlNsMW1vTzBOVzRaNWNwbkVxTXps?=
 =?utf-8?B?VnRQNFVrT3prNkxLdjBIaGJUVUptWjZGaThmcmtLZ1d2UmRhSnNGNmd1MWtL?=
 =?utf-8?B?b3cvQkRERWxzVmJ3U04yQUpaVU5SYkF1MEtUcEc2aThseTBrUktCdDhTbW15?=
 =?utf-8?B?eEhOKzc4VHV6ZmpTbGh1eDJidnlYcXErYVFyT2Jmb0JpRlltRk8zWFRTdk5S?=
 =?utf-8?B?amk1TEdxOXdrbnpSNUVsOCtQekRiQU9kQmtwaDA3K1JFVWFlSWhybDNlYitu?=
 =?utf-8?B?NUhCQ2xjMEJtZFZVNXNkQVMzN1IycjlYTVlXbDcrTDZMOVlKRlV1RHhKWE9r?=
 =?utf-8?B?MGhLZUdyT0JxNU5sQXZRNzBQazFOSitIWGtaNVQ2Ym9IREw0RFhGaytaZjhB?=
 =?utf-8?B?d3hoWXhLSGFQUGlyV2F3Zmh3aStGUjJHNXJheWE1b3gxS0ZMY05BZVdRSU8w?=
 =?utf-8?B?WkROeVczSHpiQ0YzQjlERlpkR1QwNzZlTFE2NUhITFF3ck45SXIxMDZXQUFm?=
 =?utf-8?B?RnhUR3V5NHJncWFCcEhZcVhoVnErY1dyWU9CZWY2b2ZRNlZjbFhuNkNvdWZ2?=
 =?utf-8?B?ZmUxc0V3Z3N2aTVXcHRiS0FDYTNRYkcxT1NHZEZhKzEyY2VONWNiTmIzYlc0?=
 =?utf-8?B?OVk0ZmVPZENOT3VLMlBNTnlMME5ncXlvRlJvY3d6V0tjdXhsQjBNVjEydUN2?=
 =?utf-8?B?VkMrSy9FbkQzbS91RExQVVZTL1laa1o1aHdzaDNLVlhCQ0hmcHQ5Z1p4Z2F0?=
 =?utf-8?B?Zk9YUWpyQ1ZCYXYyNDZ2MjBocWpOaHlPbkowZnBqOFVHVk1FeExzMnFDRGhM?=
 =?utf-8?B?aGhXdkNkd0loUFhONjBxeWxZTE1oK1RrQkVHVmdPNG9lZk94WnVqVGJnK0dQ?=
 =?utf-8?B?KzFORG5xR2xyN0NTODVvUkJUSm02eU5ZYUhnSDV6b0gwdzJRSUQ1QTZxMHF1?=
 =?utf-8?B?bFAzYW9JT1VpdEtGaEgyVjl1d3BkZmc2NUF3b2Q3Q2Vzc3JhNFZEUDhjWEVN?=
 =?utf-8?B?QTV1Mm9YYU1zMkJFTkMyMnVpNkJWUHRxNGljTkFrYUJuNkZEbytsVmg2UkxB?=
 =?utf-8?B?UmdjTGpzVDBka0ltWk5RNC9BbDVKQTV3NWU2Y2x5S1dUSFJzcHhBUm84dHdK?=
 =?utf-8?B?T1laaG9oQ3hMb3pGUTdjUlRlSHpkWEh5S2kwZW43bXhSbWtIbE5acXpZeHRq?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c96118-f553-4cda-8a3d-08da70b6af35
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 16:31:55.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8uDrRQku8lOaix0EiRFxfY2G6MZAuefl/alTU8zWmn86hq6uX3z1tm/UaXAKqRWzITteSUiFsD/nglwSR5oUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/22 12:19 PM, Vladimir Oltean wrote:
> On Thu, Jul 28, 2022 at 11:43:40AM -0400, Sean Anderson wrote:
>> > All of this should be rewritten to use of_device_is_big_endian(), and
>> > reduce the whole thing to two cases (I don't think native endian makes
>> > much sense anyway). I also wonder what the result is if none of these
>> > properties is present...
>> 
>> I think regmap_get_val_endian would be better here.
> 
> It needs a struct device.
> 
>> >> +
>> >> +	priv->regmap = regmap_init_mmio(NULL, base, &extirq_regmap_config);
>> 
>> It could also be done automatically if we pass the syscon dev instead of
>> NULL. The only downside is that some regmap error messages will use the
>> syscon device
> 
> How do you get the struct device of the syscon?

Oh, interesting, we don't have a device in this driver.

>> > Finally, what is the actual benefit of using a regmap here? It seems
>> > like a very roundabout way of performing a RMW on a register whilst
>> > holding a lock... Passing NULL for a device to regmap_init_mmio() also
>> > seems to be an extremely rare idiom (only 5 cases in the tree), and
>> > this doesn't seem completely right to me.
>> 
>> The benefit is that you don't have to write (yet another) set of
>> endian-converting read/write functions. The above (non-NULL) usage of
>> regmap_init would also address your criticism here.
> 
> I don't have a particular attraction towards using regmap for a single
> register either, to be honest.
> 

Yeah I suppose it's not a terrible burden here.

--Sean
