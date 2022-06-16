Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B354E5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377847AbiFPPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377791AbiFPPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:09:14 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E679403CF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:09:11 -0700 (PDT)
Received: from 104.47.12.51_.trendmicro.com (unknown [172.21.167.194])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id F198B10000629;
        Thu, 16 Jun 2022 15:09:09 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1655392147.867000
X-TM-MAIL-UUID: c4c88b1c-4293-4143-95a2-ded176a585db
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.51])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id D3E0210002186;
        Thu, 16 Jun 2022 15:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui+WtvJZX/f1HdhCX5FvmiDfwDLqcYXEaYyC1LExS9A+atupTVjHIc/uat/S10xsga9Ex2ToGt+/zoynFsviKa/UsZ4unKwoBhihqbc2x0xsayGmOBFELa6ovGp/tSDwqpNK+zxpFbqZJjtJkCDqaW4Ihru6N0nNxosW+JFL4eXvovSt8oJcLuLV8xLmv3QWqqWlbpeoRO54jfkvXtuF5WgtZUQlAR5wOqt9+53A3nt+8y7rHO7XHJwUgR05Was77j4gG6rE7iq1g0E32Q/vj5tAgCJnoyFrTzG8R+3PgsI+pWBq+CZCuZEN9qGs9JG6/LVZE5JZe8DYMMS/vghWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGlXuOP4R2yAE8t6h5fM3M74kZjhZ536rYGyuRuwzHc=;
 b=jsM0LI5GHk0txaZEqJZvKl7Y3UFrL4ilxG/hXoY8Maamtk5US9wO3uo5s9l/yZzXH0q+gaHS/9lcax3H3SoHhWkv7rQEQZ4EvJki/+MMX155vD9fiPSqG8tLX3/jbe3eJPrRPwazSQrXeJKwKkz9NgYaDDKltOZkCieZ+/LW41pjTQ2kuHgo6kUqZdxjHrJouYHvMfl+M603U3wsiQCMTWg+yiFcQuIxhmxV388Zg4MX10bMYdpyp1lz9L3S4YZKiu3/Lith8HjfO9eeEjjC0XypGdO33VA+N9XFiKd8QfrRQlOTRtV04A5dUnD5oqFAYqfpsmnKEkb/Gj0vAfSk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <0222bc88-e3d1-243b-ffb1-111ba6bcd764@opensynergy.com>
Date:   Thu, 16 Jun 2022 17:09:04 +0200
Subject: Re: [PATCH v2 2/4] char: rpmb: provide a user space interface
Content-Language: en-US
To:     =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Avri Altman <avri.altman@sandisk.com>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20220405093759.1126835-3-alex.bennee@linaro.org>
From:   Harald Mommer <hmo@opensynergy.com>
In-Reply-To: <20220405093759.1126835-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0215.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::22) To DB9PR04MB9627.eurprd04.prod.outlook.com
 (2603:10a6:10:30a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35ee185e-b5e8-4cfb-7ef3-08da4faa2809
X-MS-TrafficTypeDiagnostic: DB7PR04MB4729:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB47290A12BF79CB12FE873747E5AC9@DB7PR04MB4729.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUuPvxvD83vujkDcy7vll8O9p73t/a6JTnBViIRjOMX8NKKgi5nz/9PubjGfgR3eSQ++erz6UrFwuDsyDCN3bZwhA84jFgFXr4q/a3PoGx61wg/F27FL5/mjqIs7Hd79aPS7NV4DPNc0UKTOjnDn9w3FHnTTjmaBPeC3b7CcX7iyVVB1hqV0PZ+hM896OeyE9Kw8ofD896OvVV2WXKNG1NzxVP7iAckANoNvPCkyqCCXgamZ87VKNLVSqdfS0VuiqljT58rpsKqfuLFugA8loK8ErqvT6XqasGNtkWGt7HJ4RYmJGBjmN8GfnU6ISsvEEJSO+GJkT7zvUhm6nRjw3igGuiTBNaor9zfUohFhsT825zv8TNDCxxIQozd24g7bVUuXQo3HwqXCs3CSQq8deuveX+8CpLtfl7ZEFBxC9WGpRenP7ARQWxdvMexSpdQJgfrKioPa9Sde5gHdCHMBXHneS9C+5nhqQeWxRovTX5sjlyho9H9GdSeI/JnhTrl5B1HSYU6XNURqoifspKMdK/IagzOMN/KhxlfPGTmfy0BoZ8djuuiv7Fdnw+NhaWSXz5uoTDs8EiNf67jWsndF3Sxqwwsl2UmvORG69WEWUmOmzm6/jM9YO5HqD/8108b4xEDMG/udVicshrZkn2cb2882ZhwERzm0hPTtwokl/dXGOWl2U92tAPSpdo+p9qqqtXOaRq93aURJCw7q40q2A0q1DHksvGGdLi2SnZqp6LU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9627.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(7416002)(54906003)(2906002)(66556008)(42186006)(4326008)(316002)(66946007)(186003)(8936002)(8676002)(31696002)(508600001)(36756003)(66476007)(5660300002)(15974865002)(31686004)(38100700002)(26005)(2616005)(66574015)(83380400001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGl1TUpLa3lGSzFYSmN6YlJnMWsreHFpN2wyRFVQcEE1aGlHdnBRUlVTTEh4?=
 =?utf-8?B?aUhTM1J1VzNpMGNhdWZKaElJMlcvZDZXTUd5enBQeFoxME1PY3ltSHI4bUxv?=
 =?utf-8?B?dFRsTmNCRGFMZU4rTzZPUmFua1FaWDFIeGJLT2tkNzhXMDFYbUN1d3R4dDFk?=
 =?utf-8?B?R1R2Zkgzb1Ayck5yOTNvUUZ5SzExTGplN0t3emgxTDI2T3htd1VPaXpiS0VB?=
 =?utf-8?B?MEFHQ09GdGNjS0QyRkxyOElLM1o1RDB2VWUwd2RNTGtpTVFZb0pEU1FyY1kx?=
 =?utf-8?B?N2pncDRIZTF6cjFNM2Q3Qks0UEhxRjJCZUJqbjRSWWNnenRLSHpzN01ZNkJs?=
 =?utf-8?B?OE5ocElSdzNqTnRzelpaUTdPZEQ3M3pqNTFMQUgxdnd6OTNsWXJZcXh4K2l3?=
 =?utf-8?B?ZEYxMkhkTVJjZkZFSDBzS3NqSjVWdWpDdHlsVUQzcXY5VEFhN3NjWGN0clVj?=
 =?utf-8?B?QXplYUp3cnVEKzFHVi93WHNEZFlFdkxtYjl1Szl2bGVTemZjVmVSSHI3M3Ja?=
 =?utf-8?B?c1RNN0pNL2tsSXRROVlraDU5TnRLeVNwNThCMkR2Y2pLcmhCZGx6RTgrR2lP?=
 =?utf-8?B?aXh4NVMxMDI3aEFzVWxmOEd1Z2VFZDJjZDgzVHhFMGsrakxxTWhCYnlBb0ZV?=
 =?utf-8?B?Ync5WFZKOHFwYUVTWlBGam9Gc21WWkxUVmtXdGNqL3lLQ0ZZQkFGZU5aVzU5?=
 =?utf-8?B?bjByampONE1hcDd3dlk3ckJhYXZUTWkvK0RSM09nczJVdmZSaU4wbU1HYjY3?=
 =?utf-8?B?b0xsTUJQZ280UlZUVlZBSFVkNlRkaUJhRnd2bUxVSGwxak1oRU9Lais5UDVF?=
 =?utf-8?B?MDJkdDMwSGdrRVo5eEJlNGowQ2VFMld0d09WbEdBZld5aHU1d08xdUJ3RHFS?=
 =?utf-8?B?dmZocGJHN2t3SWt3ZXBwRkt3OGNtUGNSeThmTkk5azJLWVFSOFUvNzFWSXFL?=
 =?utf-8?B?WFJZR3RkQ2JyNDJOa3N1T2ZWeGpvUzQ3clZKd0c5V1J3Z2VYTXZTSWtBVXBh?=
 =?utf-8?B?NHM0QUl2V3NWQTRKS3VJMnUrRU1NZEQ4aHFXTEFaeGs4dTQ5WlZXT3FaQU9U?=
 =?utf-8?B?MXpjODdEUmZESTl4aTlsZ2ZWYkhjR2lKczhjTWoxZmJNUWdVdTJ2bVZOMmwx?=
 =?utf-8?B?aEh5dnJaWjllT2JkMTQrRUNDNFdOTDg5S1N3bkNCdXp5Z21SZDh0VlR4QXpi?=
 =?utf-8?B?NE1CYllIOHIyWUhJZXJJcXYwTU9udFYrV2h6Y1Uwc0VIejRtQitXc1Z5L2I2?=
 =?utf-8?B?VUYwZHpYeHJONkNSNjJ5YTV2cFpWb2VyandVWGswT0F5R3lnYWt1emNzci95?=
 =?utf-8?B?Tm1QOFdNOGZZU0pwSUlXeXJSUU5nK0g1dDFOMzM2bnhJaVlVeThiUkVXcGZ6?=
 =?utf-8?B?eXV5eCtQbjc1TWRaNWhxWmJnTXZXVUtpVVZJZEJmZWx2bDF0SnJGT0dsV3hY?=
 =?utf-8?B?cG5kOXdhc2JqdmxRUGJQbDNMNTNmL2g1K0pLRUd1cHNXMldyTFhITTZMT1JJ?=
 =?utf-8?B?R1dVZ3FLWlhZL00zQlRBVHRLV1BvdStOc0FFMVhzaWNMQnRMN1Q3SlhqczJv?=
 =?utf-8?B?dmQyWElIZnZBZ1BzSzh5eXExQzJLaTJ5T2ZjTEl3K2xseG8ydU9zUTI1bW9W?=
 =?utf-8?B?endTenk3dkhkMzh0QlNBdzJGYjVZQWVHSk4rdUJuNFVKeWFGcnN1RkdBbG12?=
 =?utf-8?B?eEVEZ2hkUnI2S1lhK3B3ZHU2YzI4Z09lMU9Gdk9ZTDF4aHBQL3R2SGxtVm8r?=
 =?utf-8?B?UUloa3IzeHJiN1pZOUFPdHdXREtNMXdLNStsYytRMWdXRFoxMDI5OVFiOTg1?=
 =?utf-8?B?d2hrWmpyWi92d2FERDErdHdkR3laK2Y3UUFIMTBWQmtSWlVRR3RLUytOMWR3?=
 =?utf-8?B?RVZJd2pFalppMmI5SWc1bEl5VVZ6bEo2WDR0YkR4cElETklZVjNIdXVDTFov?=
 =?utf-8?B?cGVWWXdVTU52YWJtNFpqcUt4amxLVjkrUWNjbkMxU3lXS0tadktRcGNwUlpH?=
 =?utf-8?B?dkFMMzZNalJsSjl3NzdPSDdlY1ZBVWoybHNZc3NoSEU5RjczTXUwYlBrMktR?=
 =?utf-8?B?NVFtNmx5Q1daem1MNE1vSituUGVqaXJwV3BMYkV5Q2JlQjlpeGd2WlZRdDB0?=
 =?utf-8?B?L0hxalBaNnp1d3U0MGhjcHZaanFIdktsQ2hKNWtIc242WWxBVkppSDFNQW9W?=
 =?utf-8?B?WU51cWIwM0hBdkdaZTh6SXdoMHNtWjhuY3ZKM25DdjYybFUxMlMzMTRPYmdD?=
 =?utf-8?B?R2xpaU91WGRKUlhJRVNlSmtKREZuQUtKUXpKcWN2T1EwWDF2TnFEbHQvdG5t?=
 =?utf-8?B?OWhURVhtcmNIbEllL0pyZDMxSWxML3lXZEFKN0NYNFlqRVRjSWNpQT09?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ee185e-b5e8-4cfb-7ef3-08da4faa2809
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9627.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 15:09:06.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVCMXhsh6f1L1rz/4oGcn84h+LiIH+umCX5dzUYyNIWYlav9B206AnVckg6jvRE2HqRCCdmBk330oc7eF3Up1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4729
X-TM-AS-ERS: 104.47.12.51-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1004-26958.007
X-TMASE-Result: 10--21.186000-4.000000
X-TMASE-MatchedRID: xcONGPdDH5oMek0ClnpVp/HkpkyUphL9jkDrBOJwwnQ8JmmJxjOaQXvU
        CoLZpk+xqpuQqy2q8hMNXG08J6BRwgHBiEj907KSEVuC0eNRYvJZDdHiTk9OcGkdgYWZtIXp+JA
        7jYabDQ4JrYom7Vk1LlQMkg6i1g2R6RQOyyexTiEmZusHWPhfCgFkGmUzEj/OVz8J52OVy+R+7G
        CmVnLE9WB9JqWQXWHoh+/2Gl63OaywQEC6hpSorxmCYUYerLHrjlRp8uau9oYUoJOBFYW8Jo16N
        b+wd14QKuWrqthYmDN8MjflxuzQKyfdCFu+J/OI9k5nZzZVBSCEDRWMikvPr9Mlpj54hDxPzrlB
        6ufbD0LKeuGCarp3g4iEKUa2WZLOptmPmlZc5SIrCLswi3NpjcXAGOt+hSbWGoWeWvFzM8yAZb4
        2KeiTPG09bk+1wFrPModguxHirQu/WXZS/HqJ2lZ0V5tYhzdWxEHRux+uk8jpP8tMOyYmaA==
X-TMASE-XGENCLOUD: 97fbeb1c-e7fd-4fc9-9c17-ae806a74a0bf-0-0-200-0
X-TM-Deliver-Signature: 163CA7077BFDA0181113BC5171B7E660
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1655392149;
        bh=N9XEpuPidboXaSRNXj4dR4lGdAUVSnplf7M5dJGL61c=; l=2852;
        h=Date:To:From;
        b=GpSLhBG0gWSZ8DpF+tYx4yhcBSvIUK0mDjmOmaJNLjO1OS8t+mL/WNhnTtuKEopnU
         J3ibbFU/mNgxfSBS4dZB6SjaPmz/kEwLfcG6/+H54exy2kQR9oqq5+OOYIhbsm8YnL
         +S65u/XLUojVqt/SDGcpqvrGwGPz+948v+i8UvOy25pif6yJpatT6fbYJm7+G3fgMT
         tJkdTkyoZvnMtyb7MwcAN2vsgi6sMRHfQ8vpbCYlqve3by3DsVbOf3E4LFv9uc9ZyN
         7BpyYrLNyhQqci+A/SCvpD0UL9C4aVL6b2J9x7W0jQ/d4iZqGG9CWJ67BWt168Jbb/
         GKunvIcg5u11A==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 05.04.22 11:37, Alex Bennée wrote:
> The user space API is achieved via a number of synchronous IOCTLs.
>
>    * RPMB_IOC_VER_CMD - simple versioning API
>    * RPMB_IOC_CAP_CMD - query of underlying capabilities
>    * RPMB_IOC_PKEY_CMD - one time programming of access key
>    * RPMB_IOC_COUNTER_CMD - query the write counter
>    * RPMB_IOC_WBLOCKS_CMD - write blocks to device
>    * RPMB_IOC_RBLOCKS_CMD - read blocks from device
>
> The operations which require authenticated frames or will respond with
> MAC hashes of nonce filled frames that userspace will need to verify
> share a common command frame format. The other operations can be
> considered generic and allow for common handling.
>
> [AJB: here the are key difference is the avoiding a single ioctl where
> all the frame data is put together by user space. User space is still
> the only place where certain operations can be verified due to the
> need of a secret key]
I have less problems to understand this reworked ioctl() interface as I 
had with the older one. Nice.
> diff --git a/drivers/rpmb/cdev.c b/drivers/rpmb/cdev.c
> ...
> +static long rpmb_ioctl_cap_cmd(struct rpmb_dev *rdev,
> +			       struct rpmb_ioc_cap_cmd __user *ptr)
> +{
> +	struct rpmb_ioc_cap_cmd cap;
> +
> +	cap.target      = rdev->target;
> +	cap.block_size  = rdev->ops->block_size;
> +	cap.wr_cnt_max  = rdev->ops->wr_cnt_max;
> +	cap.rd_cnt_max  = rdev->ops->rd_cnt_max;
> +	cap.capacity    = rpmb_get_capacity(rdev);
> +	cap.reserved    = 0;
auth_method is still part of the structure but not set. Means arbitrary 
data from the stack is copied to user land.
> +
> +	return copy_to_user(ptr, &cap, sizeof(cap)) ? -EFAULT : 0;
> +}
> ...
> +/**
> + * struct rpmb_ioc_cap_cmd - rpmb capabilities
> + *
> + * @target: rpmb target/region within RPMB partition.
> + * @capacity: storage capacity (in units of 128K)
> + * @block_size: storage data block size (in units of 256B)
> + * @wr_cnt_max: maximal number of block that can be written in a single request.
> + * @rd_cnt_max: maximal number of block that can be read in a single request.
> + * @auth_method: authentication method: currently always HMAC_SHA_256
> + * @reserved: reserved to align to 4 bytes.
> + */
> +struct rpmb_ioc_cap_cmd {
> +	__u16 target;
> +	__u16 capacity;
> +	__u16 block_size;
> +	__u16 wr_cnt_max;
> +	__u16 rd_cnt_max;
> +	__u16 auth_method;
> +	__u16 reserved;
> +} __packed;
> ...+

-- 
Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <== Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail: harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah


