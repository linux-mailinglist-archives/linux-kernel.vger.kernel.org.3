Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928D050ABD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442021AbiDUXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376864AbiDUXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:11:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472F48886
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2PKtQzUy7HEdMjpyqXWv772xRQOCRXpbpEY24iuMkMExFFjfL1nGP8pQpKuBMyxdrdc4eH9HmzZYgSALIb2TPePdCoHt/5ZVcSNYHPTdxTcnog41ECa2MvHH3zc5P4xXmxk7ikBf5HwolORtfnvRbjPUTpU3btkoS/JSJNh6vOlviSy29Aj7zv7k2OilQ3RzplKYuC7ZGvq/Fl9h80NEfKFMbfopZB7rB72JrBlJByZgX88rEnPjSxxgcwt/LM66Tiw1dw0mnlWAYj07wNI7OQOLrBwK2MHo+02a8hDzlH0c7jXQ327J8BHPpF/W0M/nKkkAdggpdQ0cWJltXi9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxGSohZ3HohNLTCdEGkKpFTbPFGo2rfXiOOaY1UPXII=;
 b=YZ2FeL8H1Q5SVCeQ8I+xWD6uTpHbHpnxuT9+nJ3egkm3JeI6EzwhESY8IGNs7/bJq/7LSIdtX6hAdfnik7fYDgCuPs1sJFRmAR2wIS+HG1yvK8o9RBt4F5BdGD6v+T7rThSU6q5210sOwH+G0/gIu0guDdRh+3Yr9q0nZs8uUcxfAFBwjZnJRHYpgP4kHklaZ2rjfsDIOhDSmLVxBiw2gj+pQ6AcoTv9gStM33zeBbChmkBoTbtZiSwmAN1dvfDQOvhNawnKd5ISAHkvvbdoxeTnjq59wpiHnygc8cMj/EZKpXXuo07jq66Z3Wd50X2wpkhqp8Wdj0LUAAYjJ+19MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxGSohZ3HohNLTCdEGkKpFTbPFGo2rfXiOOaY1UPXII=;
 b=nB4RAjri8D+hA20KQ9tY0fjW1Jk8Ie8xQj7gQggu+Y1VNQy24qRFXDkxs/GeIXPoM1PuRVuRiJTbWApzdFSwLX2QubJbS/cZEP5JYXmbNBXSTUmnTy3CBKqVDRm/2rfJ12qwVw4LilM6yRagmHIcju+9feaWblaxTSUU1Jwnjdom13Ar7526+eaFa3dzHQ31ABAPPtIqEC2buUytTICmjYnePPENPwY3sNlzrgzkNbQVhvEy2zR9fp64DlA4nO7BPO3M/6oaT/NmY1Hw3Fa7/mEyLXgDWClTJ8dVwVErirKjc9MwyrcqVABn4bEyYgWGfuKjUWQhXj4kYf3mLl7ekQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 23:09:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14%3]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 23:09:05 +0000
Message-ID: <8378400d-09d3-66ec-5391-96a157477dbd@nvidia.com>
Date:   Thu, 21 Apr 2022 16:09:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re:
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220421164138.1250943-1-yury.norov@gmail.com>
 <92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com>
In-Reply-To: <92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0071.namprd07.prod.outlook.com
 (2603:10b6:a03:60::48) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 859aedbb-d8c6-4499-86cb-08da23ebeed5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279FAAA3521127EE8418936A8F49@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tn46M/hudxlkmyiPN0Gv6BLM5aJHLuRD1w8nisTouQgR5A+Gyw9hM/mvEVnutIgKoQa2vMQ9OUBhuIWotxStZKVtUB7L+xZO4u3gn88KjSnvhk6yZ5bYyTNcEwZQyC4gkUm9slWsT/To6uaDzITG5VxaB29qUiL7ZScLxpKwmenUBxcTUCm/PTZpDng+HptNRL2JLsyN0gwG8sJQHfDAAL8jdhdF+hzXxR/01jKw1bSczgg6jIHD2mpaUnksziDDuhstzl83ERzM4KMT/oXQ9j12kDc4Mq1oOfKCc5ltuna/E6LDL5iKYmwR375nvGBS2Hvo3dfwUkIU9/tHH5gxITIxwIOguXTfSxSRv0U6JJZJ+nhi+sljbkjaqtiT3lsA7b4xSah6UR8bmbNt+plWNRNZtaQtpoDXhWR0w+Ix97blAslNjckxXnF3ZDF0FjLdFwBrvHmlyb3maKJMxV6r8/zDWkoIP/I9rmgNkRYOmxWq0306OPoe8RtBRxsPmjNAUJCZOFzxcpBwXIB7HZ+rFAsTdu1QeQ1bxfm8rEwPYqtOHs+wRfHXIcOWP3pOtke7iSRsqadCVjpyoJlRq5gJI7lsPPW1HWTkPJ0mD4ybbEaCdh95IYinqOY2/U5cg7UrWQRCiArD/Z+vUOwMImwVNTRRVrruzclJReLIWGozqsQAhetV37adq1EAQCiYVFkDrYOzXiIBzxNrfLSonOTJiiXZP9Vk1EqWgNFyFcO2vmtptMc46mC5aThLBLOfJ5n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(3480700007)(110136005)(7116003)(316002)(4744005)(8936002)(8676002)(6512007)(66476007)(66946007)(66556008)(38100700002)(86362001)(5660300002)(186003)(53546011)(6486002)(2906002)(6506007)(31686004)(508600001)(2616005)(36756003)(31696002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCttWHpObFY0SXlKZm11OTRVSEhIYjlZbVlDSEdwMHpLbGZEZkFyTTFWTnFl?=
 =?utf-8?B?Qk1JWGprQWlwNWowK1hTL0ZzZGVpbTYxRE5LUU85YXJuS2hNZnFyaEdXTjRL?=
 =?utf-8?B?d0ZtZHVPMnlmZzNpcU5rdml3UFVQSkFxbmFxK1FkU3JyN0MwNTZZQ2x2V2xW?=
 =?utf-8?B?VmRERDV3cExURkIyNFFkTnpHdGErTHh6MnY0ZFhBR1I1Y1hTWmVuVzhTZTR4?=
 =?utf-8?B?NlhrTjl2cU9hZlZOSnoyTktGRFk1MzRteWNsK0ZoeXlGdm5EdUp3U1FkendP?=
 =?utf-8?B?SndNaG51Rm5Vc1k0WlpodW4xWGNuM1VNQmlqWVpuaHdxYTFoZmcrSnN1UE9i?=
 =?utf-8?B?ejhvOVlYZENWb083Zk4xZGVoUDVacmpKM25USEh3cFFsOXRvMmo3SG9RWnBX?=
 =?utf-8?B?bzQwcDJtdThINjlnbS9ja1haYlQvNCtTYmNabloyNE5MU25QOXF0ZllMS2lr?=
 =?utf-8?B?YUF3T2RIL0IzbnB2RmNLWnNuY3Z3bHNYWGpEVmhaekNmTUlaV2NhRlMzUmpl?=
 =?utf-8?B?b3RBVGRKSm5tRlJqUjd4eWUzK1hocmxpdGN6SktvU2Ric0F0aWRLWHZXbnMz?=
 =?utf-8?B?ams4UCtjLzFiQzFSckM0VXEvTmNFNzJkWlREMUVlNkVJYlZhbnZjL3dYVmNo?=
 =?utf-8?B?dnJKcUxBUHR1S2NYRkN5S0lsTG5GVWJxamlnNFpvWGlEOGxqSkZkYWVaVGlU?=
 =?utf-8?B?YXJJb0lLZTZQU29YcHhFQUZDSXlFQzhJdmFmamdheWFIbjFlQnRERXVmd3dL?=
 =?utf-8?B?d2xaQkJmWkRtUG5pWjliM2RmMzM1ZGdIZ3B1U3BJWDV2VHExWXNVTG5nYUI4?=
 =?utf-8?B?cVVoVHo0Z0EvN1RqUnduQ0w1QlAzRExuVXRyYlZkNHRQelZHK0djbTdpNVZB?=
 =?utf-8?B?TFgyMnBQRkxROVZiRTVoV1R2Tnc4VDlnRmtSaFdqUkJJNHV3dzV1ZlhiMVBw?=
 =?utf-8?B?ZVRTWTh3UmdSQTA4c3VjUFF4S0luUTBmTk1HY1JFYjdrcXpaZzlISlV1cnNO?=
 =?utf-8?B?Yk9ISXdLaUdvTWpvWGwxS3JUdzQwQU0xQXZsRzV5bXlHanBWSFF4UURXY09N?=
 =?utf-8?B?YldTUkV0UHUxdUQ2ejYvZWRGUCtvNnBFbndXZXB5Z2Y5THFnSVlvRktwZFBj?=
 =?utf-8?B?cWFiNDM2dUVnYWFaZDVOVmVZYmJwdmVSYUhlVjZmd0d6cHlpTzBYWmVEWEFX?=
 =?utf-8?B?RWFpVWJ1dlRFSFJHdTZ2ZnZyd3VZQWEzNlVnd3BtQkVQeWNlYmJRcEJVODdt?=
 =?utf-8?B?MnBWNFZld01lTldPRkJmVnVaNytPTGx3MHZzSSs3MVJ2c0JDZWZPNmFqNnhM?=
 =?utf-8?B?WVFDbyt1RUsrT0k4VFFNbjRDYWVtQUEyOVZLRFJUdEJGZGpqN1FFYUFXeEIw?=
 =?utf-8?B?eG4zeU9PekptMXhlRGhERUl0V0cvbHNvYnpDV0g4cndBZWEzRjhudlh0RWpN?=
 =?utf-8?B?ZWtBTEVpR2k4R2hVOW1OMkszN0VEZ0MvdXFiS2dGTmdOMU1ieDVIQ2dqODdZ?=
 =?utf-8?B?VzFnbStxRTRmMmZ4c2MxSzZudkh2Z3o4L05yZjNkbEdIUnpOQjhTNDVobis2?=
 =?utf-8?B?ZGNGSzIzTXdMWE9RS0g3QmhadkhHeFk3M045b2psZEhMT3o2bFl3cTQ2U1VZ?=
 =?utf-8?B?S3lyQlNjenJMVERiMHR4aFBUZ2FrclhmN21LdjFndHQ2YTRqT3M1Ynl6SC9m?=
 =?utf-8?B?MEZMbjF5L0FNbXo1RUxIQ3o0VnFFZ3QrUzhiWUVabkpsZkRpSmRIZTFrMlI1?=
 =?utf-8?B?Y3ZhWE9jeHRQamdpS21WeUQvQ2lEOWxQRGF0ei9VRzY4Y0dFRjl0M21rSVJp?=
 =?utf-8?B?TlRzcTArVGZ5d2pSWHJnUUl5RDRQdlpiQVRBQXVRQW91cEtwaGF4VnlndVV3?=
 =?utf-8?B?Q0ZiZGNlRE0xYXFuQ1VpNlowcDJBaEdka1dXc3hRM2JkMjlyTjlibkIrdW8z?=
 =?utf-8?B?VzBXa2Z5VzE3UXczQVBWRU94dGNqeXlzcnRXSVd2blNSenZPTnlHZmwxQk41?=
 =?utf-8?B?VzNWUXZaVmsyTG5JZXpVTXlMMnU4cnhZUCt4VjNwbHpkdVkvMEJEMm44L29Z?=
 =?utf-8?B?Z3hrQjBwdjhWTmxXVVhOMG96aDNPSzE4S1BMd3pOVDFObVZTSmlzWnhIemNw?=
 =?utf-8?B?a00vMU1CTVBxd1V5SDhhSHBlSVdxTDlDWXlINVVRWmppRjRLVlpYcWZveFZs?=
 =?utf-8?B?cUU2WWswM3VLRHZhVzExQmkyUEJpTXZraFNrV3pKMHQ5WlhlYXZtbkQ3OFNz?=
 =?utf-8?B?M0R1bHNFNll5MnFlMnYxbDkxSHI1ZnJMRkI4dHExMjNLbWUwaW9Lbm5wY2RL?=
 =?utf-8?B?cGs5bGNmNmRSKzBrOFNISW50NGVxdndVTUVuZEJ2ZE10OGxVTkczU1RoWktZ?=
 =?utf-8?Q?YG4tyPKr+NbYaTbc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859aedbb-d8c6-4499-86cb-08da23ebeed5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 23:09:05.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dsod3BYJpPeoAX4BBojXx3/OSNny+iKeAvaZbqnGduqD8yEGM7wnmjDQe0LqQIUpJhwiEN0tOtKHxwpgkMXcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 16:04, John Hubbard wrote:
> On 4/21/22 09:41, Yury Norov wrote:
>> Subject: [PATCH] mm/gup: fix comments to pin_user_pages_*()
>>
> 
> Hi Yuri,

...and I see that I have typo'd both Yury's and Minchan's name (further
down), in the same email!

Really apologize for screwing that up. It's Yury-with-a-"y", I know. :)


thanks,
-- 
John Hubbard
NVIDIA
