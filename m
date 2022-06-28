Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8CE55E842
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbiF1POs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347961AbiF1POd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:33 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01932CDE3;
        Tue, 28 Jun 2022 08:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKBxI1CaASA8cvAxyr5EXS/C8ITjaVoxj1Dha6ZcMYfPRP70/5o5GXteRtIBZmOJqbP0flkHxj39a3nW/8gZ7jbn+Ddrfc1E+Pl29ND/64yHVlmXfiH6ZjzOJMkFRM6I8Uww/ELo5EYW+VcAZ8/JtLJFuE60V38suGY+y3bIZ5KewIQatA+gHEKIbwFXHWHTe3L6Nd7eI9T1JHw7F1yNaeGlxmD5YT+iFqYLfqO1UReWp2hEaYqXi+qHAYZBkXMhodWpr3u1D7M0NcqBn1J8nGw11cmiSsuv1PhTT5cyVF9Ny0zFUsfSQtTs322s25iTwj1gjtpuKVToXwpmkukMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1lVJh7KojLoi0T/c3QVXgkE4VL0tcjHR8b1t+uy6JE=;
 b=Q+vvdFsZrqidMCuf8yN/3pjqM7MlFnAUeHaX0gQtC2XlDsOFiXvlXT9Xp10hTgqivaVbo+nqHa0t0iInla9vfB/WkLDDSPdLpS0/TiGvqgU91zTTvwKjNb9I8RN0MdDlOQGck5H9aOGeHpcWh7JDq6ZazglCCat7ehXjbvc59Mw69YHiqT79wLMUlL0shCUYDeVhpTWnuRKHXgnwGzAvrHfvCaAhMdjzqQJhzsoAUuS6Dd2UTj1IKp3H/ah+qfk1viaH9PxIA+HMCNxq9oG/213ntN2ZDCK2MdNJMJ6IzzInoJBJbCenfJz4CfCLwjSo5ly/YeqRCtFPZs6NDOixDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1lVJh7KojLoi0T/c3QVXgkE4VL0tcjHR8b1t+uy6JE=;
 b=PwaSOk2ZOyhmrML+hVToK3vQXcjRcfgUEIjQSc4Mm8hrIhHxCffMV8DX1rNsLYloT+qz1mGrIUNgqZCE7mfLd3gI1G9YUvX2MWIYcnH4JhUldsyX+C3SqlvVtLYHuwwgC7hkag1Ot0deueYXF20HmO8OMhBu3zUwh4iu2VHSa0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 15:14:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 15:14:28 +0000
Message-ID: <3ff059d8-2d89-6ea1-209b-3c8855561acb@amd.com>
Date:   Tue, 28 Jun 2022 10:14:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] HID: amd_sfh: Ignore uninitialized device
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220626081339.7243-1-akihiko.odaki@gmail.com>
 <b17f4e85-8a35-65ab-34de-0978bdc4cfea@amd.com>
 <8c95e3d7-cff6-c56e-e197-fdd0911d81aa@gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <8c95e3d7-cff6-c56e-e197-fdd0911d81aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7591fad-d73f-49a9-1ae4-08da5918e501
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AW/G5z59K07pqG70giEKqlYnqokxyKd5rvKgV0/A0Xr5deyV7hiwkxujU9nLTTVDOHPHDjbtlqapRwscS1CTeS4a68puDQhcZN0auoTtCp15db0awAENuo6tqXGgJzrBzGApN2e+kCQ49fp/qUptbf/yNgWrPmM6QkgTc9CnmXPqL9uRYtHA//h1EafUrQCAcXropny82KMG+6Kf5LTbTJGTNnf35D1jvHeaK5jvoJQq8jcMmv4MRxPF20xK2mYatiS4ns6cE+i/65WWpVaVIW4SqIfivvXmPbDC5NiEDi22VP13U826hFgIiNWfJyUdOdNO0zy8tqwvB5TzRN+DF3Bv32yk/xtHuEL5JYx5s5dUeSbgx/XGxQx7TfbuAkaDGNoYkrYjLGzMdolNQ2E6SicuvfItlf9pPRMy1DpmDW2lfAymChi4HT20wxtOC7RxO0H9IqCmp0gHOg8dk60M5gExPhpzYVXkjXYnFkT162mrs8XiBoHZX0n0Sqoxc9q5TgUq2iGA0oJa+ItEAUf0ZvPYCyWd2SAuZ8vcL5XyVhFj0qnHiVzn1oPVmYxScjk/Fx8DtfsA2KX1lvkcV0cItF1C9GK/mUml9km5tUompu485n8ZA6kg2T4jGe9wv0+yH3Vnoy9kL8TGjWNMSbLznvKybwLt4U3SYIRjfxdboeJ/IjqUTAvvoq4CGq4h1mNuax1CEKA/7/m8bjp3TA0/gYxMB62iDck+oz2nrlfwEnxJzl+K+BuQu+k/NikMbRESpcEMFDBAIaipAmdWbCf2At4bxw/orvAeqXUToIbamIdR4JBtxt7Wtxx90DKkzv7z73wxHNmpOTjZBCLDYK3Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(316002)(66476007)(2616005)(2906002)(31696002)(66556008)(6486002)(4326008)(8676002)(66946007)(8936002)(54906003)(478600001)(6916009)(186003)(38100700002)(6506007)(6512007)(86362001)(53546011)(5660300002)(41300700001)(36756003)(26005)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWZtSDhCZ0NvQkoremZIZmlQQ0xydlpYdFhIbXFiZW43a3QySVpCcmw0WmlI?=
 =?utf-8?B?eE8zNDdVYVhmU1dpeFQvN0g2K01ZZVZRc1B6U0gwcjM3b2k3NkMzODBBd2FC?=
 =?utf-8?B?MW0yR3c2VVQ1aFBrMXJlc29vNXZvbTUvbGV0UnJDcW1uTmR5d1pJanhFdnRG?=
 =?utf-8?B?Q2Q5cWhJcGhEa1dSNTNLdG41Rlk4RXBDZGs4TE9Gci93bkJUZUFzV3ArV1FZ?=
 =?utf-8?B?OFFZUkp3RnJkODlBdHhKS0wrZzJqQ1RuVnFrWlFHaUFRV1Jvd0s5KzJtWWRG?=
 =?utf-8?B?STB3VG1aVjFkNTFuWGhMaUIvU05EUnZsU2dRMjlieTd2YjBOclJtRUdaT28x?=
 =?utf-8?B?d0xXQzVmUGZWZG51b2lZd3ZxTUQwNXRwTG5PWWN4S0g2STlZd1pGYUFuMjBr?=
 =?utf-8?B?MHY2MWRvTlAvYmx4ZW5venpzNWFnaFkyRnZ4TUpTWVk4aVdlVW5lL0ZKYk05?=
 =?utf-8?B?ZWVmRHk3cXQyTkZKWkYwY2g2cTdVTWtlM2J4aEpQU3Y3V0lqWWxrQWJBcHBM?=
 =?utf-8?B?bmFLWFlqaGJzTzRybFlCRUZlSmZ2OFhKK2ZhYWFLV1Ivck9PV09YOC9GVFpT?=
 =?utf-8?B?Ly9PckZsWUN2UzR6cmpqamJ2OG92cTk4NzlpQXVBVTg4YWlmRVkvVVVPOHlP?=
 =?utf-8?B?WjZ2RWhqNkVpV3lKQTBpT0FaR0RERHFIL3hORWY1WU83WVFGc3g4Um10dW5y?=
 =?utf-8?B?WmI1NlRwQytoUjVselhNelJzWFBoNzFBcVE5UVJXNVpQdmRvb1QrOUxGa3VN?=
 =?utf-8?B?NjFTTHYybDdIQ3lBVFMxZ0xod3ZTdjEyRkN3bDB2K1Ira0haOHplZzJPOVpT?=
 =?utf-8?B?QlVyclI3dmJqTk8xQmF4S28yTTZONVBEYzAvbDVUMlFnVjdZQlducFBTbjg2?=
 =?utf-8?B?b3Fvd2hka2dlRGNGVi9FUmo3cHEyZVRaZ1NEdWVMbmVJTkdiMy9VZllJVlZB?=
 =?utf-8?B?ZjV5TndvbTZ3WGxYZGJrMUhYMWQrVEhJYmVLTFVwRzlQd1FXRVc2MW1saFk5?=
 =?utf-8?B?MFlLNnJYR0pEKzkzeS85Qm9qNFNpbXc3U0JxYnJiOTRiQkRrcmRhWFFHQkoy?=
 =?utf-8?B?UndxUkpsUGtEUWdtYzZwK3hrSml2REF1ZXhNeXJ0Vm5sUHpGU1djZ2d0WWNx?=
 =?utf-8?B?QW9VbzJmODk5alh2VSs4QWZWZU15bXBHaTN6UWpCMk9OalJ2OVFHS2xoanRD?=
 =?utf-8?B?dXVxeU01cGxhMStNR2U2S1J5R2xLNDJLYkcwSXVDVWZvN1M0MGJTT2VINHZ3?=
 =?utf-8?B?MTB3d3RyRlZUdkFqRjhodGJNVmlObWxNRGMyUmNDVDdKR3l2L3dNb0xyajRh?=
 =?utf-8?B?QmlnUTRoaE9TbWZCandscFdYNXhBdWpySkprZ3VlQ0VpRmhIZnQxQ3BlOVRy?=
 =?utf-8?B?aHduRFZjUkJnTGlMVjIvS2dTQzVSeVIvamIrRXduMEYwU1Evekhkelg5TXk5?=
 =?utf-8?B?MWZ4akJJelJwbUZXS0UxWDgzZGtnK29uZVgvQzBrelBjWlJsdmE5UHNQSzU3?=
 =?utf-8?B?Q1ZpNEN3M2pNTWIvSXJNSEhFd01Ea08yNkJ5ZXgzV2R2MktlUFFnS0JHMENG?=
 =?utf-8?B?bk56dTl6OUlCQ0NkZzJ3WDVnUmg0Vy9XWnlJNTVUZExJVmdGY014aS9aYmVw?=
 =?utf-8?B?UFFUYURpd2RVSXJ2MmpENHd6SjdEVmN6Q1diKzJYK0Z3N1hCSjI3R1FRTVpa?=
 =?utf-8?B?ZndxaStvdEQ3Y0tldW5XRi8raDV6S3dOVFI3VVdUeEY3Zjc1N0dtbkphaUxp?=
 =?utf-8?B?VW5qU0V3MjNaZVpsdHMvcW9MM1ExUGNpcjRubHhHSmhFbW5sWFY2WXczL2Rr?=
 =?utf-8?B?Q2x6NFZ3TVJPU0I2R25kNG1ETE0vODh0MDluUm1JbVNXSk54U2lKTzJ1UEV2?=
 =?utf-8?B?cUMzUjlLdXJuTGliTkloRk1pWTB1cDF3OVE5YkV2dldWK3Z5WjgyWkVjN0Zv?=
 =?utf-8?B?dkt1Ymt3M2M3U0U3eEl6elRiWHNlQnFGcEw3Z2lHRE1CTDhnMkgwV2llZDhz?=
 =?utf-8?B?cGROeUc4RW9TbDRUSStHRndvdnhIOUJOc0VRV2Q4V2cwUDgvQk5kSTVCUWdP?=
 =?utf-8?B?cGh4ZkJjUmgrNFk2QmhyK3Jsb3RtZkFUcVdCZnB5WTJWTk83WW1UcUZGQnd3?=
 =?utf-8?Q?eHmlHAsxcalXRdygHSTFuFbCc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7591fad-d73f-49a9-1ae4-08da5918e501
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 15:14:28.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj+Sdt5x8Foh/YiNsZI3emJcxLcmNfDDRJlJUbi3Rl6zdR3B1TunJn5fk6fGggTzR4d8KWq6KKDBy99P+2B5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2022 10:11, Akihiko Odaki wrote:
> On 2022/06/28 23:42, Limonciello, Mario wrote:
>> On 6/26/2022 03:13, Akihiko Odaki wrote:
>>> Lenovo ThinkPad C13 Yoga has AMD Sensor Fusion Hub, but it is not used
>>> because Chrome OS EC Sensor Hub is used instead. The system therefore
>>> never loads the firmware for MP2 and MP2 does not work. It results in
>>> AMD_P2C_MSG3 register to have -1 as its value.
>>>
>>> Without this change, the driver interprets the value as it supports all
>>> sensor types and exposes them, which confuses a userspace program,
>>> iio-sensor-proxy, and makes it to use the non-functioning sensors
>>> instead of functioning sensors exposed via Chrome OS EC Sensor Hub.
>>>
>>> Check the version bits included in AMD_P2C_MSG3 register and ignore the
>>> device if all of the bits are set.
>>>
>>
>> Have you already confirmed this failure happens in 5.19-rc1 or later 
>> as well?  I would think that b5d7f43e97dabfa04a4be5ff027ce7da119332be 
>> should have fixed it.
> 
> Yes. I confirmed it with 78ca55889a549a9a194c6ec666836329b774ab6d.
> 

Thanks for confirming.

> b5d7f43e97dabfa04a4be5ff027ce7da119332be deals with the case where it 
> advertises v2 but it doesn't in my case.

In your case it actually goes down the v1 ops path then right?

Basavaraj - is discovery unique to v2?  Or does it also exist for v1?
If it also exists for v1 I think that's a cleaner solution.

> 
> Regards,
> Akihiko Odaki
> 
>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
>>> ---
>>>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c 
>>> b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>>> index dadc491bbf6b..4137e5da77ad 100644
>>> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>>> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>>> @@ -271,6 +271,8 @@ static void mp2_select_ops(struct amd_mp2_dev 
>>> *privdata)
>>>       case V2_STATUS:
>>>           privdata->mp2_ops = &amd_sfh_ops_v2;
>>>           break;
>>> +    case 15:
>>> +        break;
>>>       default:
>>>           privdata->mp2_ops = &amd_sfh_ops;
>>>           break;
>>> @@ -317,6 +319,8 @@ static int amd_mp2_pci_probe(struct pci_dev 
>>> *pdev, const struct pci_device_id *i
>>>           return -ENOMEM;
>>>       mp2_select_ops(privdata);
>>> +    if (!privdata->mp2_ops)
>>> +        return -ENODEV;
>>>       rc = amd_sfh_irq_init(privdata);
>>>       if (rc) {
>>
> 

