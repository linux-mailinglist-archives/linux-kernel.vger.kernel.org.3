Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D374CD2DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbiCDK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiCDK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:58:07 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130125.outbound.protection.outlook.com [40.107.13.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874E1AEECD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:57:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThO+soIg+IPjezsp/m2qCBhIfNknKYqao+GLcT/VoLq34FphpYCfe5FVcYwfvTijk/Gl0lgEtZyxor06lk3bBtQaS0mYanqUVfmnDfS8wBC38mmwQyhT9hvD3WOslMcNtb4VQtVZlfdTYybweuEz2wsb8noG6Lmi7NKyyOX7KxfaL5sQWiUaSxiEss6KCi5kO6Xh4XLxzWKJCwgdf+uTG57mBLtDwDjpQS4hxElfEf283nnC8iwSzFJaxNC3q8/OfU4g1CuDfavFXiuOyiRRHp0v4DMUkD47LxP5folBOd3KWuYSMn+dwTcbnlORTiOuxPZEWud1CY6N/X1DRZCovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBQHdYB935MdP8xOqHUikRu+X4VHYsniLOu7826zc7Y=;
 b=mxjfvstc4nwC5y7hcinsyJQXVr67tlUhv6brqbL3Cq/p9qxtCDzC8MrTOMBp5j4NSu5rY0mR7UhQh/Kdt16J0FX0RFnKYZ1JLRHlEE67o2d4VPnSHHpNSidFMwxLca+sVZ1nV11oIQlTMAkP0J4oBo+W1s06FXgeXRvMKmTNDAYOuj9F2uCoDh2MBHSMzoXjPw7EOSZ3v7f3WxA1kZMJ6+F5d0fmsJ6RlEUn2ePadkqSAcuQIhh/q2d136N2pN3+A3Ym1cgUNnv9RpmVws52X3xa5Cb3yXBNaqUIDWBT2HGz/6pTCTurESqCcFnxutJGMl3bicVHyRX9oZKFtmgrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBQHdYB935MdP8xOqHUikRu+X4VHYsniLOu7826zc7Y=;
 b=glOb+FgEwZ3vfKqkYLiTav7yjw2MyPG4XQKAN2+2Ym6+lRi8hIDhhfHQix/JrmBgps5E6dbdG8ee44KVnaOL+v2icM83IwMuC698xbJDhuIFuctzmJJUM779rghtCvOYtteYY3R1N/2Fr21SHhyvkPQz9cQspsJM+Kz77xZp+rA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by VI1PR0202MB3519.eurprd02.prod.outlook.com (2603:10a6:803:23::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 10:57:14 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::2c21:5ed9:a7e6:6cdf]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::2c21:5ed9:a7e6:6cdf%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 10:57:14 +0000
Message-ID: <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
Date:   Fri, 4 Mar 2022 11:57:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Daniels Umanovskis <du@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0501CA0001.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::11) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73346347-542f-4d27-579c-08d9fdcdbdab
X-MS-TrafficTypeDiagnostic: VI1PR0202MB3519:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0202MB3519ECB9E6DFE858E52B52A3BC059@VI1PR0202MB3519.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqxlAVlqyLPOdMJzeiiheXtw0mboG1xMROt5cTIMFZpArvehqQF8Zj1WH5D/YYGmH/0DsG3HEp195MOms1PD2otFw/UQJ/h/s48udEURL79eT06ZjbFgW4oXB4mBTuwcUqwA/WOUCffCz0dv6IyK/qT0Gft/f9NtbBzHGgWryWziaYITk1TSulxHBQOjIlfgSYdLsSI6ltsnjbuid85JWPHPaMSe17erj9CWl4UBaakHq0Atz5EhjtCe2hd+65hn3ALhQFeZ6br00ZrXGdTO8eYIk7QKRNYIJqrNj4AqSeBZTOYVODAWDYt5upGN9nP5JoKdJwQeC/b9brRRnk7lsXtjyH86sNl9MyxDgAp6oB0firoBMLm2a8YxDwU+R6DDejXM935XuTLAj6A5NyaQSlBl8doSd1+lpRe12U27G63AxxR828OASkn7C+Vo+7s6kzwgiorP15nyuRtrIj3YhpBC5B1dV98ZB2XzxEmEcOJkdvQMS9NQkRKDM36LgAq/8XUOc68S+QOd/luiOZdTJwg/0v2a5xUYVOr7llFrQqmPPmsw7if9CqCxXqONy8/HphexiZ0QtRaD2ZRZdFwjm/yojEFQL81USTIue6jMyxSI+FW1UzKQJLiCwS5nvGz4S+GOgQlHUuaJCtWk9EausZjgMqv0Bz4ERktzcnoB0u6N/q6SkK6Njc3KnVy7jqdlNnbepuq8E+8d2neHVD7J3ciPz2NHkmHOzx5irwZF9PlyQ9kivtzLTlzOsjDqyxfAVbBg0XWHGLKhT8LzDkVhmN1rurwVlOT9Jaoi8R+F+0VvmMOvoZGdU9iuHi8RoCDQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(396003)(39830400003)(346002)(136003)(366004)(186003)(2616005)(26005)(54906003)(4326008)(31686004)(316002)(6916009)(36756003)(66946007)(66556008)(66476007)(8676002)(86362001)(6486002)(83380400001)(2906002)(966005)(5660300002)(36916002)(8936002)(53546011)(38100700002)(6666004)(6506007)(6512007)(31696002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJ0OE1Ec1h5QUpSUi9PMlJiSmpYYUwwekQxa211ZEFZdGlxVm5Zd3k0bXVa?=
 =?utf-8?B?Z3RNMXYvYWFXWFlsdjFKOGxtdUkvbjdUWVhXZWJjMWljb29meUJOdzR4M2Y3?=
 =?utf-8?B?VGVSbXdBT2VLWTY1Y3VCcDJGcVFIRldaODNYYkg1RDI3dHNqdWVPcmZMRm9J?=
 =?utf-8?B?Q1AwMkNrQW1Uc1RMZmp3ditkYWtxUDBtdnVMeU9XRWpBRC9wMEFEUEU1bWli?=
 =?utf-8?B?YnhSQVRBNVFMeWplWHBoMm1kcFZPVVo3S3RqYlNPcEY1RlIxcmY1Q3U1dTAr?=
 =?utf-8?B?V1RneVROaWRneCtsS2ZCUHJIWTRGWkJMN3NJMngreUs2T1RrclRvTW1IYlZG?=
 =?utf-8?B?R012Mi91anQ2cU5Jd3JFSjUxM0plTHFVREJTWTZLTDRwdzNUa1l0Z2t5RSsw?=
 =?utf-8?B?Zys2Y2VlREl0dktZazI5Y2FwOVBJOWZscDM0KzRuR3B3WnlONGJ6MWZHQTdP?=
 =?utf-8?B?NkFGOGtPSWIzSGZ3dEJVSkpJWkpKRVRQcnFZbm5HdS94eVBGdFpPWnU0SEdo?=
 =?utf-8?B?KzZCZk1YZ2JVL1haN0VWNlRqcm9GVXkxbDBOTUV0N0RWVFUzbEdMc0YzQnVq?=
 =?utf-8?B?MmYraUxwWkExQmdJdlYzVDdFeDhnYmxTZmVVWVRnaE1GVDQyMk5oVVNWS1dl?=
 =?utf-8?B?RHhsK1RyU0RzSE56VlhLQnN6dU9xSEZzV29OM3M2dGt0TWFLaVdHWkhBQ015?=
 =?utf-8?B?R2xDM3BWNDV4WHk1ZklMbS9zbm1rTHN5YUFIWDFYclRPRS8zdjJWQ3R3VFpE?=
 =?utf-8?B?QmZQQjREYUkrVVQ3U0FLWWxoSVRTVEtHRFBRM1AzSU9hbVg4cDdFNC9UYUlt?=
 =?utf-8?B?NmtxdnFMQ0tBdnpBL1IrVytzU2UrZTBRTE8zazgvazE0eEw3Y2FsV3JPY3hY?=
 =?utf-8?B?eGNaR0FkQTZXcThrOFpJU2hSMnZDN3ZkYWV6Wjl0VmRiYUE1QmxrWjlZaG1w?=
 =?utf-8?B?aW5EYjA4RmZIQ3dONHFQMmYyQmpVVEt6SitQM0J5YnpQbEJLQWRYNHFxa3hp?=
 =?utf-8?B?dE1lUjdFRE1xWFFhMjc5SVh6eHRETHhOeHlMbUY0TjlMbDFCNFJza2JUMm85?=
 =?utf-8?B?bG1KeERWeDNOV1J5dXJrR2VWNTllZ3ZtQTBBcDlQTEhpQTVWSDI5V0RyVjVl?=
 =?utf-8?B?RXkyd3IyMkw1UkJEUmRLVHZCMndVb2JydW5xa0dmZWFrSFpqU01xd294dFk4?=
 =?utf-8?B?Y1JOY1RpNUpIUi90WFdBSmF1MUZXZHE3VTEyZGd6U05zY3pyQ09EaWREK2pT?=
 =?utf-8?B?S0FGSWl6c3dFUnREUUREYWlrNDdtQjl6SHFXRldXbHhXK1hJMGhDRm1NdDZL?=
 =?utf-8?B?Q0VXM0xvcnVuV1hwMS9sSUtUdkwvMHlIZE1SM05JdExGd2lwR0g1ZVhEZ0lm?=
 =?utf-8?B?eVNMVGZRMUVhS3dNd3IrdTdvNFEvK3hqbGd5NDE2RzNPcjdxOVJDaFA4cGRZ?=
 =?utf-8?B?Yy8wenRsblZGZGk1S0ZRUWFPSHBoQnBISHJkamF6YXN5SUxmZThNQ0RSWk1Z?=
 =?utf-8?B?ZStydk9HVEx2Y1dJNnVjRnNaZW1ObDlCY0I2d29rMGFlcHh2SUJjSURuU2Vm?=
 =?utf-8?B?VFZ5UFRITHlOMHhkSzNPUXgwV3oydk5RMkdYVnJ1YVhOWFR3VmpXbTVackVp?=
 =?utf-8?B?elFZN2RIdVhzZ0pWWlEzeEIvZy9ua25ucElyUEVWYUduN2JBb2RJNytiM0cy?=
 =?utf-8?B?ZVd6Vjg3YjRkZ1d0NkFUTThIUTArc2NjNHU1SzMwdktKL3dGbW1DQUEvd2ww?=
 =?utf-8?B?bGZrTVk1bEt4WXZ1RXoxMzhpQXgzUStoZFozM3M2YzFUWTBGaGpuTjdpN25r?=
 =?utf-8?B?Qkxja0Z2eVM5emhFdFB1YkdUZERCMVJ0S1M4dVBPZXpuOE5Cc21qaEtxRDRU?=
 =?utf-8?B?UGt0RXhPK2VBSUV1bnJqdE9ZNGRrM2pYVFdlUEdScE9lOEVUK1FRWDJSNzFB?=
 =?utf-8?B?dHplSjB2dHZqK0NReU5EbUtVcmRvZHNLdzdKbGF5UHA5ZTNUQjBXZWFOemJV?=
 =?utf-8?B?Q3UxcjFqaUxtTTVaalpLMFhRWXlJTnhseUVacWZDS3ZPenFSUUJrakpjMm1Z?=
 =?utf-8?B?N2F2U1VRWi9sRmZiQkYrWFBaemZiMllWUFJzbjRMeXBYV0xaTG5YWGw0TWpO?=
 =?utf-8?Q?TSDI=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 73346347-542f-4d27-579c-08d9fdcdbdab
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:57:14.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsGUTBMc2NBDUMJz5gvFM1AQK1QJ9oVjE/JQkJAb4n939WUHct1y2criCJBLmfp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB3519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-04 07:57, Peter Rosin wrote:
> On 2022-03-04 04:55, Saravana Kannan wrote:
>> On Thu, Mar 3, 2022 at 1:17 AM Peter Rosin <peda@axentia.se> wrote:
>>>
>>> On 2022-03-03 04:02, Saravana Kannan wrote:
>>>> On Wed, Mar 2, 2022 at 4:29 PM Peter Rosin <peda@axentia.se> wrote:
>>>>>
>>>>> Hi!
>>>>>
>>>>> I'm seeing a weird problem, and I'd like some help with further
>>>>> things to try in order to track down what's going on. I have
>>>>> bisected the issue to
>>>>>
>>>>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>>>>
>>>> I skimmed through your email and I'll read it more closely tomorrow,
>>>> but it wasn't clear if you see this on Linus's tip of the tree too.
>>>> Asking because of:
>>>> https://lore.kernel.org/lkml/20210930085714.2057460-1-yangyingliang@huawei.com/
>>>>
>>>> Also, a couple of other data points that _might_ help. Try kernel
>>>> command line option fw_devlink=permissive vs fw_devlink=on (I forget
>>>> if this was the default by 5.10) vs fw_devlink=off.
>>>>
>>>> I'm expecting "off" to fix the issue for you. But if permissive vs on
>>>> shows a difference driver issues would start becoming a real
>>>> possibility.
>>>>
>>>> -Saravana
>>>
>>> Thanks for the quick reply! I don't think I tested the very tip of
>>> Linus tree before, only latest rc or something like that, but now I
>>> have. I.e.
>>>
>>> 5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
>>>
>>> It would have been typical if an issue that existed for a couple of
>>> years had been fixed the last few weeks, but alas, no.
>>>
>>> On that kernel, and with whatever the default fw_devlink value is, the
>>
>> It's fw_devlink=on by default from at least 5.12-rc4 or so.
>>
>>> issue is there. It's a bit hard to tell if the incident probability
>>> is the same when trying fw_devlink arguments, but roughly so, and I
>>> do not have to wait for long to get a bad hash with the first
>>> reproducer
>>>
>>>    while :; do cat testfile | sha256sum; done
>>>
>>> The output is typical:
>>> 78464c59faa203413aceb5f75de85bbf4cde64f21b2d0449a2d72cd2aadac2a3  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> e03c5524ac6d16622b6c43f917aae730bc0793643f461253c4646b860c1a7215  -
>>> 1b8db6218f481cb8e4316c26118918359e764cc2c29393fd9ef4f2730274bb00  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> 7d60bf848911d3b919d26941be33c928c666e9e5666f392d905af2d62d400570  -
>>> 212e1fe02c24134857ffb098f1834a2d87c655e0e5b9e08d4929f49a070be97c  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> 7e33e751eb99a0f63b4f7d64b0a24f3306ffaf7c4bc4b27b82e5886c8ea31bc3  -
>>> d7a1f08aa9d0374d46d828fc3582f5927e076ff229b38c28089007cd0599c645  -
>>> 4fc963b7c7b14df9d669500f7c062bf378ff2751f705bb91eecd20d2f896f6fe  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>> 9360d886046c12d983b8bc73dd22302c57b0aafe58215700604fa977b4715fbe  -
>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>
>>> Setting fw_devlink=off makes no difference, AFAICT.
>>
>> By this, I'm assuming you set fw_devlink=off in the kernel command
>> line and you still saw the corruption.
> 
> Yes. On a bad kernel it's the same with all of the following kernel
> command lines.
> 
> console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=on ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
> 
> console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=off ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
> 
> console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=permissive ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
> 
>> If that's the case, I can't see how this could possibly have anything
>> to do with:
>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>>
>> If you look at fw_devlink_link_device(), you'll see that the function
>> is NOP if fw_devlink=off (the !fw_devlink_flags check). And from
>> there, the rest of the code in the series doesn't run because more
>> fields wouldn't get set, etc. That pretty much disables ALL the code
>> in the entire series. The only remaining diff would be header file
>> changes where I add/remove fields. But that's unlikely to cause any
>> issues here because I'm either deleting fields that aren't used or
>> adding fields that won't be used (with fw_devlink=off). I think the
>> patch was just causing enough timing changes that it's masking the
>> real issue.
> 
> When I compare fw_devlink_link_device() from before and after
> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> I notice that you also removed an unconditional call to
> device_link_add_missing_supplier_links() that was live before,
> regardless of any fw_devlink parameter.
> 
> I don't know if that's relevant. Is it?
> 
> Not knowing this code at all, and without any serious attempt
> at reading it, from here the comment of that removed function
> sure looks like it might cause a different ordering before and
> after the patch that is not restored with any fw_devlink
> argument.

It appears that the device_link_add_missing_supplier_links() difference
is not relevant after all. What actually happened in the header file in
the "bad" commit was that two fields were removed (none added). Like so:

 struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
-	struct list_head needs_suppliers;
 	struct list_head defer_sync;
-	bool need_for_probe;
 	enum dl_dev_state status;
 };

If I restore those fields on a bad kernel, the issue is no longer
visible. That is true for the first bad kernel, i.e.

f9aa460672c9 ("driver core: Refactor fw_devlink feature")

and for tip of Linus as of recently, i.e.

5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")

Which is of course insane and a whole different level of bad. WTF!?!

I wonder if I can dig out the old SAMA5D31 evaluation kit and reproduce
there? I think that's next on the list...

Cheers,
Peter
