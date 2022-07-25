Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CDE57FA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGYHkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:40:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92701274D;
        Mon, 25 Jul 2022 00:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ0uogXiIV7YcEHBkOsrZLhEiSivzDy6Q3q/bjwLzyQsMqFDA6jRH2CWNH1OB1lAD9ZfU64KjpiJwds1oiwMm/XFDLk6nZcnQ4c0X11TZUNPWQ1gSA+AvrJvilIlxQykaDIa8Gji4Tjm0PAwXgdBjtNP85M5XJE1fa6kiU0Z3hQaRjna8g4UZA87xMaMK7lf1ZPsmNm4DFB4O+iofc71SpGrO+O0hiNgTrUdDljd5RH089day/sk+ak7R+mw99ojvcvzZ+yka0jK6rvG/9qpo+rsyoRYSO5Ton36WCZVcPjHR4ph05zpt9F1XFPSSzGsiZ//qG8QtV5HD8o1tDG7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAqVjdSq5qkK622t5vMXyU6MNRe3UDCnxcxsmDkZr+Q=;
 b=K8iZqwqTn7Qrfw1D/HF11ni7em2CovxfsDOkVSuBrwHAfvsmRBhq4YDj+o86g79T9s5hIqgUw1qu2IPmPGOrz4eTwrOy/4dd/3K357M3dro4KKV7zMSR0QdY+BLzZh3mlaJlyZ3M9CoHPLiiAh+qgVyHPboLCoKs/3jgI4RM1zXNSSGyNdNB07gvGsJnUEzQeYI0hNZNMzb3bdPIy1EknHF3ziQ1TrUMMEl4TcSVcKSUi8Ls+n/MnnTftASMHG8jDHmVQkjwnXMCq2HSzPb4Fh64We8PsC4Mx5XawIIPBYv5HJP05R435D6veU/boc+ydNrcIF5rpZGfv2HZGXH4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAqVjdSq5qkK622t5vMXyU6MNRe3UDCnxcxsmDkZr+Q=;
 b=A6KnqSLrseeGjEMyqcym85B8FJQMtM9AsC08sRlvAYCr5W/IO0gSazYvphDx6NxRBxcl3qS9kdDCjDNz4q7WHu3sPK1Y/Kh9l9bz+cUy4C16lw6yPWm+mwOZozK3gMHb8XGt+4aX1DXFxBNmIpfNSvy1Lj6KLTENi0Kvaex8p6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by BN6PR12MB1890.namprd12.prod.outlook.com (2603:10b6:404:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 07:40:44 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::1d6c:b7e8:bc5e:191a]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::1d6c:b7e8:bc5e:191a%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:40:43 +0000
Subject: Re: [PATCH] crypto: ccp - Add support for new CCP/PSP device ID
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719161328.7907-1-mario.limonciello@amd.com>
 <188ecbc9-8624-2b74-7963-5f1b909ddf2f@amd.com>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <edd96cb6-aa74-bc21-9275-ca9e1f80c100@amd.com>
Date:   Mon, 25 Jul 2022 13:10:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <188ecbc9-8624-2b74-7963-5f1b909ddf2f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b07d977-6076-498d-389f-08da6e10faef
X-MS-TrafficTypeDiagnostic: BN6PR12MB1890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpYIzff3MJrjIHXa6TxhusktoSpN4cfA1CdRV3TmxknrTN6sC7wdz5lUmOYX1GQbi9hEsqPvn3GkbZqFz+s6qsMAvMi9QndMMB5za6WD9miiVjQ3kdhSMTX9LzlSsY75mb6Wt1avSwTRc8S3yUCSWf6hM7FlIuZphJb0FEs7Rs6coLIUGhnrtSfNgnG1YgCGKodAlC/lOccdW/bCpV+y+WMN+3hq4PJT8cXZZ8dEeTVrNSxlk4asfk2UQ4xWoX04vX0OyNZNB7L+hEU2pdawrILbpszxOEIdsFTmIgW0QrBrAfIajfwiBFqvesEkIHal+5jp2rqu4oCsteCN8IR9oYM3SsjzteHB70Ub9UC7UrMNpOERB5mt91FtRiKU3BFXihAd0tomjDBd2RmmUm/NmFyfz2A4NqQEojuCiIN01Pd4WKE4txUy6ct+E52dTwH2gxRHUi+QW73PjUQkF8blwLXeO5RBpFD6m1H5Zhr2qbwsD8V4JTTiDjm2mqXz6OUS7R46ToQ3P1moGLXoSxm1l8maWo+DZybz2uJvS3Ze7NvaKlfWTB4seUuxiLab38QzTRa5q2ji7EOl1lbiMCDmwTV1+/LKUd6Ma5oyFXVssI+0d+t5XfM0TAdcdZ9HSO18iuBa5jRo4nXlgeU6zCfIeqxyu6eNVZoHzyFDbEorMQxYGC4ny2xUmHAj8SXKCkvTLNQB/vC6owxDnBD0Zmy7i7UmNUXB4LaZlA1TdhShsitm+aLgErsNVvs8vpNru3+TiwRAepv+iHpGOXaZ1Up5oxwrf3LoDMRxekVlSgJvrXsqa1Cu7n5/7mAW9wfkRoBkn6agHOJtih73509cqId68A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(186003)(4326008)(66946007)(66476007)(66556008)(8676002)(2616005)(110136005)(6636002)(6512007)(31686004)(54906003)(36756003)(6506007)(41300700001)(55236004)(53546011)(26005)(2906002)(86362001)(31696002)(38100700002)(6666004)(5660300002)(316002)(8936002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZ6eWJyaVpRVlYxYVMvbWNnTkhMYjM1Yy80TnV5akE1dzdpa0hXc1hoUGto?=
 =?utf-8?B?N3YrVVpUZUhFaGoyQlVubmlkTEo0MFQ1VXNOQnF5ZWcrNUJsZGZTOFZvMmNU?=
 =?utf-8?B?aXlNRCttempBUzlGZUJvbytOcy9mTmxQUUlmdmhNRFlpSGZ0TnZrWDQ0NHht?=
 =?utf-8?B?dVdSMS9tblZXZzhqOHMrSld0emNWL0s1bE5XMkVnZlpIbkZVMDVtT3IxVXlR?=
 =?utf-8?B?NkN6dzdIZEZNaGdTYXBZaVdYOWc4R25nZnhlaFJiRkVaOE9XYmdsQUt1QWVG?=
 =?utf-8?B?TWs3UXdSMDBiYXR2UnhWcWZDcUU4YWc3dWJoM2QraklhT2xGUzJVcjY4REpk?=
 =?utf-8?B?dW9yR0lOQ1VqbnNYa0I4T0RCcExvN0pFTXJ1T0F0U0lIcThXejBzS1Z3MGww?=
 =?utf-8?B?SFRNUm4yQlZVL2ZFNFhxT0VJcG5WWktYVWJreEkxZ3BERUJoNTR0dm1RcU9T?=
 =?utf-8?B?NEovanVueU4yQUYxUDB1OGlKWUF0am1JWWtBUHRobG1WTmdtKzFhTjFBSUpu?=
 =?utf-8?B?UXA3ZWFjRmdldTE0a2VSTnNHdzlTUVZUd1Q3ZDdyLzVNTWVobFc0ZlU0RERt?=
 =?utf-8?B?dTBDWE1qS3NQRXVhRG15am1BVnZxa2RSQnAyZTJmbDBiMTh5TjJ2SXVjNjRF?=
 =?utf-8?B?eWd5QmJyZktZczh5U1p6aWNxVktCZENnU2FkS1JGQlNuY1FBMUFrNUlOdWpS?=
 =?utf-8?B?WmNLY002MUVaWm5oOURTV014V2JNbjd0eUkrOWNmZUNwZjlBTVBtUUl1QXk1?=
 =?utf-8?B?SmEycklCRHRXQzc0SG0xRFdTdFdVMFMvUTR5aEh0K1RZZFdldjBHdjRUTzls?=
 =?utf-8?B?MjJkWnQ3Z1NIMWJUVEJjVDlMeXI2OXEwMlVFVFRMUUlrcDd6QndWLzNqdWpP?=
 =?utf-8?B?eTRCK3BhVlJ1ZFI3S2xiYUkrZTUzSTU1TUIzUlFzdkd1dTVPK3Zjb3p1T1Iy?=
 =?utf-8?B?REpBSFluRGVyZ3lwZXN3TzM3aHlpUXJPaFh3Mnh2ZXM2eDd5bEZSckpTaXhu?=
 =?utf-8?B?UzRLTlRqV09MZytXZ0kxQUZIME5WWXFzdURKV3lkVEYwZS8rblZFRDdiWktG?=
 =?utf-8?B?YktPREI3d09rYkJIZkMwYlFTOW03YXVTVzFQOEpMbHJDVEpqVTJNSUlYTktV?=
 =?utf-8?B?QmNSbUZFR3JsV1YrS3Qyc3N6MzlmeWZDb0FWOHdqZ2xQZHc4YU1NejdEY0xs?=
 =?utf-8?B?aDhJYk8yU0U2dU9yQ2lON2hwaHlZaDJmSW1tWGo4bU5pQzVzTyttcHhDUHU1?=
 =?utf-8?B?NFlMYnI1Z1ZhNFpUdUJ5TkhNd01nemNRYkxib2ZkaXVHSnlTWXQ4V3o2UGNa?=
 =?utf-8?B?VkRjYXpPMEVYYTVBSk5Zalk3VEFvUFNKa3dtQ3o2S3lDdnJvMHJ0UWtXZ2RS?=
 =?utf-8?B?VVQvY25PWXgzZWp3M3ZNamhveEVZdHc3RTMzaEpXNVRoNFVUQndFM0tDenI0?=
 =?utf-8?B?L0UwWkVhSmF1bkdwNmE3VzZSYTBmcURySnIydU9hSXJXYS9yTGhrVFNqcERp?=
 =?utf-8?B?RWN1bXErbkRoc2l6cnNIYXovT1FZNmFlTVF5QU1VV2xGOUxhZHBsNWlBNWVX?=
 =?utf-8?B?SDJ6REJVQmJHSlZWWEVjdnJwSmdJSEpPK1J5KzRNakg2RWtNQ1c2MmtxOWtQ?=
 =?utf-8?B?T1UxZEk3djN3MlZrZmtFSkhQREY0bUdOZDgxNklNNXFIZlV3aFViY0IxVkVO?=
 =?utf-8?B?b3JzUVdpUnJrclFRUnoxYlZWcEJ5QlA3YnRscXpHUmJLcVU0WldsNmQxa2E4?=
 =?utf-8?B?Zjd5UklwL3VYVmVIb2tOcE5oZGpQdTFHSjQvTUxieEFFMGlKZW00SDBWUVJZ?=
 =?utf-8?B?M1Job3I4NjdPcTNmMUwrcCtmUzI3cTB3RFh4bDdRNk5jRmVhdmpmNGQzc0xF?=
 =?utf-8?B?dnFDSlhkaHE0QTFIcHhlTGpjTnZCZi85bkx3THVmb3VYWEV1T0pkNDg5M1hz?=
 =?utf-8?B?bzZCMGphd1pqL0l5dVZSdTZvby9jQzdDc1BIMzZxR28wdUhUZm1FQ2JndFUw?=
 =?utf-8?B?SFJUbXR1ZEZoekd0NHQyMU0wZVZ2R1c5bll0ejMzaFR5cFdPNEVIK3lScTUx?=
 =?utf-8?B?T3IzK1NDMDZhdWMvcWsyalcwMnNKZzVhYUNkSDdWUnduMVZkQjQwN2xPMG9w?=
 =?utf-8?Q?UPPXOVYKvbHD2XRB9XBchZewB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b07d977-6076-498d-389f-08da6e10faef
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 07:40:43.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0oMtt0ndCrYQKFmqZ3gJBRcGcCvPyLqDPNl6nrxn2iPE7yHeXzk0ZHlFxWR31E5QhgtWFyyIDli6JpFWUvJhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2022 6:28 PM, Tom Lendacky wrote:
> On 7/19/22 11:13, Mario Limonciello wrote:
>> Add a new CCP/PSP PCI device ID.  This uses same register offsets
>> as the previously supported structure.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> 

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

>> ---
>>   drivers/crypto/ccp/sp-pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
>> index b5970ae54d0e..792d6da7f0c0 100644
>> --- a/drivers/crypto/ccp/sp-pci.c
>> +++ b/drivers/crypto/ccp/sp-pci.c
>> @@ -427,6 +427,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
>>           .bar = 2,
>>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>           .psp_vdata = &pspv2,
>> +#endif
>> +    },
>> +    {    /* 6 */
>> +        .bar = 2,
>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>> +        .psp_vdata = &pspv3,
>>   #endif
>>       },
>>   };
>> @@ -438,6 +444,7 @@ static const struct pci_device_id sp_pci_table[] = {
>>       { PCI_VDEVICE(AMD, 0x15DF), (kernel_ulong_t)&dev_vdata[4] },
>>       { PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[4] },
>>       { PCI_VDEVICE(AMD, 0x14CA), (kernel_ulong_t)&dev_vdata[5] },
>> +    { PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
>>       /* Last entry must be zero */
>>       { 0, }
>>   };
