Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA64BE65E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379560AbiBUPt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:49:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379526AbiBUPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:49:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F7F2459F;
        Mon, 21 Feb 2022 07:49:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4DtuTROhG9EOgd90xMxb02BB5YCv+TK7ZuxPKNEGZ5t5TSvzYfdX5YX0Il17jRpVK820ltCz+fSHYczJUhcwLRVjQ5zZY/Tuw2J6JcAzvxLXqxQY0PAK6VJqDL4fbTHzA4V+a4WoyXdhrd5otspHxXH3dm3PKhvR+iOpsOiSahZ+8OFNpu8f2a3u5ZE1IWceAbL/sz+pwf36XvyKyG54oxMDO0q+FrPweTnSLmxnE5MCaxK1m2GHqdeYO+VUBNQC3WZzDXLISz/gxe6X1vdiJnrp21fOANdqIgaiqsWOfZHTGE+jKX+juiHSA09EKSkPsR8Ql1rGJ9RmuAc66M2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKZqDgrQIhTAopC2D34EIHLHiBrEF9oblKvc8/O8i0c=;
 b=EX6NodiRBzHh0ueG4grQze+5yiDpVpVA0ZGO6YF9tvq0uZq7Q6vuZoArJy4SbMlMr62PZ4kTdqqSC6unf6oIaJC2oSZtlp7Eo0cYEoaXUK1B+ud9nif9hPfouVWJFwQwRvyF5aii+OBE2gQ4D5IRuhuG1V5zYYLwiSbdpWWTGFWSxNrtLp7kZM4CpVo96SBG2Z06sEpytpHxTed5hnDRmnc7qdRqlBt5ORPDQvGhqgAO85QEkERxSYIrj+NbCMJEHMS06VDPEdtkU2erKMQdAYTEHti0fXAHbaK6YeD5ettTYnCY+sr/tDo7k6zIihxj65G8L9sdByAssACOD7xSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKZqDgrQIhTAopC2D34EIHLHiBrEF9oblKvc8/O8i0c=;
 b=GZMfq6t24tqOF643hZyDguaNGZdN2Oj70XDy/PoRmpAa29OwkKTaT/aSfSUUBLe3WnfcbJkl1nD1JT0s0oNY8Wp1nIIafN/I5IsOlx6kIJycIZh+8FkILynZ3HdYcohm3s1s9ccdZy3DdjabdeKF9At3IWToYl7J065NJ77QqJJPdjNfrRFwkYTtMvm4EfIO+4NtjIYDXkLZpVqX1PwbcyeZ1Dima56XkynokOSd4P2YJPLmaexbs8odZ7kpjXO1gR2Pxshue1wJlliJKC5IZh4NmLTsg/hvxp7Yhvw6T7lUmjUXvoJ0Sicuu86iK9L5xR84SK0unMMfeFQD+w92Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Mon, 21 Feb 2022 15:49:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 15:49:24 +0000
Message-ID: <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
Date:   Mon, 21 Feb 2022 15:49:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::28) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b034f608-2dc2-4d15-f17b-08d9f551bb92
X-MS-TrafficTypeDiagnostic: MW3PR12MB4441:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB444158B76D1A87BDC12BC65FD93A9@MW3PR12MB4441.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXUPKXSSL1sx4bKilPn+XZ4Uob4kWuhh+M21l/Dj+FgLUUbNAvuffrmoAVOqn+vxZ2ytZdezMoof6rOO76+ZI1ELHF+XVAJw7rWerST3ouKhCXEa8PR3eCkHv3mg0cPfkGRDtHEsXA5r2RCNA5D78dZI0TtKqy7B9+gt8xNCC02FzZvA03mnhnI3brTMbwtZskVFZF7QnDYNaG8Wq3Maj8P8yhJp0+eHJPTUnS/PzAxAGOVOo+A3iZaRN4usZ6RdU4f5e/lxN9tQvkOMkFUsb1EMYQx/cgjkcozMkmxhCMNh30qywo6y1Y2qUoYXUmRoiM6rl1Ocxo+Swj/QCTWTfNg6qO6zQRG3h1t0vg0WxEtAk0QQwFEvo+zzUBl+WCkQpORtvVP1qSKCbA2p4Ez5KA4mgyxTMQw1FPmhyqNQYbf9UOPRfDcJJJvnEuRAT9OtBlsZpUq5XZzIrf3qqf7MAB6NgoK6LVu2zjKvibnWSBd/QIpdiS7T63tqBXeRWpShG+mCRr9ghZ7m/r1JzjnnMQ4juYGk3ZEb+bjIAPqTGYmXl2o+C3fUdBGDEYAEV/3CxesZoU6wLwnTeDHUHvUE4w7b9C+A+2J6K+CY2Lu7W8k17dc4yluRJIxTMQ5AgjBfSy3HS1OSKjY/BN83/1KvP8jVZltvH4nfqwGBidmErIVhfUvYiPvBLQv7Hpkczr7Fr4+2IKEorUduiPgypXBXLKTqWligR9wekafU3ALIJaN+Dvya6Uws8cj2Cdxq20WN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6506007)(6666004)(508600001)(6486002)(6512007)(31686004)(53546011)(2616005)(55236004)(2906002)(38100700002)(66946007)(5660300002)(186003)(110136005)(26005)(8936002)(316002)(31696002)(86362001)(83380400001)(4326008)(66476007)(8676002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEltbkY0S2FwRXkydFFnUTlxRFhxUmpxalRtZm0zQ0UwS08weXQyRXJYVm5L?=
 =?utf-8?B?Zi9JdWZCWkI2K3VseDgwVFNGbEhLZWRHOHFvNHc1MHU0WXBWOGxYMlFlZTBW?=
 =?utf-8?B?WHB6dlYwREIvVjg1MCt2RVd5d1hhSUdlc2hYZFJGRFFWa0xUWXZkVm5ROGFI?=
 =?utf-8?B?dlA0cktSMjVNcFdlTVd6blNSOHdyNW13aHV4L1g2NWNiMGphUlBxeVRUWTBo?=
 =?utf-8?B?dFd0MzByRWN1akp6K3JOdCt2T1pJd3NhNHpiK0lESkRnd0ZLZTlvekc4cVNp?=
 =?utf-8?B?TFpRV2Z4SzJlbEVMcElocWh6dTNWV3pMT0JDUDNLVFR6cEhjU3lOaVhGd2Rw?=
 =?utf-8?B?QUlHYmhiQ2Y2cytpcnlUZCtqYnVOUFNuZXVuR3dnNVZhc0t3WnZVOWVSSlEz?=
 =?utf-8?B?a3ZNS0JHTzNoUWZBeXU4M2hFS3MxejF6Vk9IR0NscEg0TE9CT3kwa1ZGampi?=
 =?utf-8?B?QWZzYUNZNG9PbVBBMzlMYjhHT3ZsRThDM2x5NTEwa1l0eFFzOWszbjRwR0NZ?=
 =?utf-8?B?L01QWTVIMDhoVDI0RDB2MDI5aDVqNkN3WHdtUmdtTUZuV1lUSG1iU2VJSVVN?=
 =?utf-8?B?dC95M3NUblMzYkRwVzJ5MkJ2Nk5naHRBcy9lT0xqdDBlbnJ6dHR1MUlSZFlF?=
 =?utf-8?B?ZGtOc1Zoa0NYaUIzU1Q2cG9kcDZxellqZ2JmTFJYK3hkL0R4Q25NOU50WEpX?=
 =?utf-8?B?MG5PYVk4Y0xtVTFzY3BnNXZhU1krRU0rMHcvWFJFM0czRHhicE1WUzVkNlJF?=
 =?utf-8?B?RWhORDhBOS9BdWdqOXprTEhvaEk3SW1OZ1Q3RVpPOXpxMGIwUms5MSs4NytO?=
 =?utf-8?B?UlRyaG9LVFFsR3RERjlNejUxNVhrMGRHVDZTQm9HSzEyTWRNeHVOTEhSa2d2?=
 =?utf-8?B?OFQ5T1NqSStEeVJSRWs4WEkvY05rcWFTRkluMFNaVkNWMUdiMHAweERwUGl4?=
 =?utf-8?B?NUVmR0llV1M1cW1YQkdxcVRzYUxMYThINHdFYmQyNXo3YWluRmRuYzAzVm1v?=
 =?utf-8?B?Q2VMb1dNMUkxaHJmVzdLTjJOd0crYW1xOGc3azg5SzBnYmlEblZsd2tBSExR?=
 =?utf-8?B?MnROT3VSemxRNGVHN29KZW5zVUthcGdPWldzK0RUdDNaQ05vSml6LzkxNXlt?=
 =?utf-8?B?VHhWa3RCYURkZWxKUnAzTjdmcnR3bWdUN2dyZGxYcnRUZG5IRmsyT3dmUTMy?=
 =?utf-8?B?UWZua2V5UWp4NEpxWkZadmZvMk5wZzVBZVlsR21id29MSzgvZnFpMFNoMmtu?=
 =?utf-8?B?bHJNU0RlbWlFNzI2QklUQzdrWUQ0K2h2TGdDT0N2QnU1SkxOa1RGNDZBZjJT?=
 =?utf-8?B?ZVdsZTRFU1VoSlEzcHF4Ymh0VEJBd1JCa2N3aXliQW1vd2dsTXo5d2ZFaWlu?=
 =?utf-8?B?dlYwM0lqdWZ6VUZOanR3NXRKYzVnaVVmSnNQMGZkTkEwTFdsOGFHTXpTVzlI?=
 =?utf-8?B?T2pybFdWVlNsSjAwZjhTY25UbTUreExHbjVteWpxSVY3bXRwQWl1WDhrdDJj?=
 =?utf-8?B?UHdtQTRYMk1HczJXbnNtdzI2dk9DaVptTlM1OGhjK2k2ZG92aTFValNsNW1m?=
 =?utf-8?B?RVcxTkk3K1RPeSsxWTNMeldWUXFFUWZVNWV0SEp3NEpkc3g1dWk5R01zcTNF?=
 =?utf-8?B?ckdHRXUxWEwrVzVvWHZDcERHN2Mrc0VGREFoaVlGWHFVdnE4eFpXdHcvRnZS?=
 =?utf-8?B?VFFKVE8vYTlIYVUxcjRLbEhyTGZ2ZXEzby9qQlRCTmlXMjh5a05Qay8rTXFD?=
 =?utf-8?B?QnFUNzBlanV5NVZsWVZXN3JoSGtHS3hveXVHcjRnUlBQSVo0TWxwNlg0MnVJ?=
 =?utf-8?B?bEdKOE5kMkphdyszaHh3TTlUS2ZPaXdicm82R3ExWmJqaDEzdWNXam5Zb1Yv?=
 =?utf-8?B?S1R1alNZVG52MUd0TmMvVmowVWtYandoY1JrQ1d2ZVlXVDgwTUpnTDVoWm14?=
 =?utf-8?B?VGxsby9DSFlSNUNSejJPYlVlOG8vaGdMZHV6NSs0ckxORE5heEJSNkVTbjRB?=
 =?utf-8?B?d2I5SGhTdUZadDcxOUNwTUc5ZHB4VjFGc210bklMNGtxTlgzWXhPTjFjck1o?=
 =?utf-8?B?YXV4emRrRm5aLzJwNC9DSTl6WHd4a2UzMXcza3VYQVNHeWYxVHZvZVhZZTI5?=
 =?utf-8?B?a1Y3UHRzalVWS3Z2QzNNZDMrNEtWVjBqVzBXT0ZWN1pLejZMaitQSmVOUmpP?=
 =?utf-8?Q?WO16SiGMo3BR0tCxUsY4nqo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b034f608-2dc2-4d15-f17b-08d9f551bb92
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 15:49:24.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtdpmebR8J+L31rNaD+22eOPQIAr0EGzHmHdSfhlDwTsK0OpDmlFeljSQg3rLe0i6ehxtDWDJWE3mRAEZWjXaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/02/2022 15:43, Guenter Roeck wrote:

...

>> We observed a random null pointer deference crash somewhere in the
>> thermal core (crash log below is not very helpful) when calling
>> mutex_lock(). It looks like we get an interrupt when this crash
>> happens.
>>
>> Looking at the lm90 driver, per the above, I now see we are calling
>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>> hwmon_notify_event() I see that ...
>>
>> hwmon_notify_event()
>>    --> hwmon_thermal_notify()
>>      --> thermal_zone_device_update()
>>        --> update_temperature()
>>          --> mutex_lock()
>>
>> So although I don't completely understand the crash, it does seem
>> that we should not be calling hwmon_notify_event() from the
>> interrupt handler.
>>
> As mentioned separately, this is not the problem.

Yes I can see that now.

> I think the problem may be that this is not a devicetree system
> (or the lm90 devide does not have a devicetree node), but thermal
> notification currently only works in such systems because the hwmon
> subsystem uses the devicetree registration method. At the same time,
> CONFIG_THERMAL_OF is obviously enabled. Unfortunately, the hwmon code
> does not bail out in that situation due to another bug.

The platform I see this on does use device-tree and it does have a node 
for the ti,tmp451 device which uses the lm90 device. This platform uses 
the device-tree source 
arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451 node 
is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.

Cheers
Jon

-- 
nvpublic
