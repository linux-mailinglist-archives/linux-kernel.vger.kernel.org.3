Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4054391F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiFHQcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245177AbiFHQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:32:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D342ED900;
        Wed,  8 Jun 2022 09:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIeTMqcX+raYdopKBMeef2gU5eaUkp6C9kxfEiZmaoWNuWFgxJvizv/vVdzNBvxqFY4ONJdRJJp3eo4VJZY7E1qHfl1UUHVKjCoNsdBF17aK5dZY3941lxeVEJG6mCgWZ2gYjVN6coRElBUwO6AMo48dStaZznRgGZUPt9Qg3/cMRFXwDA3Ob3QEiNRZyUSluAwNEAtZf7cvxZmOrE7yssV2IxsWY4sZLmjdW8uhobKKlP1+/8v2g9uW9hfDZngMdV544NzSn2TEaSIIL4GMEE+sM9M7TtrT/Ee5T5tYokNtAbmNMyrKuXU0bgyhX9e1En8Cod0KJ9uMAFWC1Ylbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdtv0vJ8dwz/1zHirgguVPmYTc0YX0a+GWV/cIDOn6k=;
 b=BO68Az5aI8Ems1zoCRWksvA91Z1FY/L0sbBzEZhRE6tY2X6wkQPKOTFtSCbxyxziXDSSTXivBqvh3zV+QBAsxkCS84QDHVsPwkpCponn4rNjgBBvOX4XjHCrqGZ4vRiGhpYWKTFzB5JOQH1/xQubdVPit/nITVLkp9bcV3uXVLBfhpi147Fp7tMTD0rCaaSnyZth1uiAwNnUMDoxnGJdIqTcFX9vTTOxYNBdIN8bdr+2wcAPrRsJ2RlZYlzkrgaLKDtnslVrlsD7o6maZZJ7hDcpOYLJ8gLB7bJ7Ti604E4Jmyf6DbvxLTZlYY6Tu1O3mA2Z4XUaopZiLb/cPrlJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdtv0vJ8dwz/1zHirgguVPmYTc0YX0a+GWV/cIDOn6k=;
 b=NZINo2PmdNGKPysAt0oAcslnE+96CrBZv8fPNfIVoFane+tYvd69GtbwCMP1+7VPsYJoxIb3CtugQYACPybW/nugqgh0b1nWXFHCuzR1Id0W+ZXJ72HldjyRzrAOPwVv76MNcH8YDqfE1TDOQgY9CSeRA7l6Gz03j67kxO/m4TN/pKrdikdPH5H9kS1JnEBVnAo/k6iYcTo+vmHXD+jeFkNFTqGrbmkDA+SgVE5RO9PA2iTv/yXAigcmKriezcs+MUcT41ignWZZXep7SiskVjPAAKhuzmKcvesA2RGokuRq7HZx6tFoX1i3sdMta0CpJ3ulbbSKBVWQ2XUUa6c2og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN7PR12MB2724.namprd12.prod.outlook.com (2603:10b6:408:31::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 16:32:37 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%6]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 16:32:37 +0000
Message-ID: <d46d3e62-b573-4e42-fda8-ca7792446863@nvidia.com>
Date:   Wed, 8 Jun 2022 09:32:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix kernel doc for struct line
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
 <d796b54d-7559-f9ff-bb4b-4e75a707db2d@nvidia.com>
 <YppEqYTZyWaulKjI@smile.fi.intel.com> <YppEwbZSad/pRdUv@smile.fi.intel.com>
 <CA+PwDYdf7JEimfYG9ChTHp=Dds_Ljx1Y2KK-H5zfeu52=NxXFA@mail.gmail.com>
 <Yp3Rgo4/09/bsvna@smile.fi.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <Yp3Rgo4/09/bsvna@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3667313e-dace-404c-368a-08da496c7f66
X-MS-TrafficTypeDiagnostic: BN7PR12MB2724:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2724BAAFBA93F8BBB8B7DEE2AEA49@BN7PR12MB2724.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9/uVGJXHbVB+aizOL2rhLGFACDsuRDrMuOWF28OICpGmeSwSDRB2mpGhR7veVO+ppUuPeMoC0nH6/sIcySAn1J8HV4cpWzEFjIDJMSjPnF9AOxgRGzGP7JjiVO3FmPrZg/8GzXpLXkj/f9ZVtszhfC9dTUE4VWP9049U8X4lIgeM9nmXnokaZSnDvgo+4V7e46czEdw+zjf3vB79ztanDN10J8UcNKb1HqtqkfBFmmYTh8tCo59Pqu6HlWTxelKX/MxmChbYoriMI8zGAhPWeYDio0aTZ4fEnBf3+b+H4m5Xtsa9tK8xS8t0BNrcjlPbT2Z8ujcnAPTPtr1ZHEXlcwy7nKCZS/RJ1xh3j84+lX9J2r7GHEdEqeCUdFWpSnzw5U2GehzS+jixZZ2MXnZD8AQUEB+LJrTCU5uzzdBWasme3e2182tJvSg3OW/V8Wwh/skVOnwCA91vI7VR98TsAGI9k+F/O7Ldh0YNS0bUVz/PdG1y3qgKT0jMLOQqxJM98eh3+O3dA5zAC0IPHli8lEUmagKk7p+2t9QPO5tnQILdSNldH3GodZT1JH0a3LKwt1BK+e6eNEYnNzz4KBUiKAg8U0EF7/fi5auTGOyk6m2cVDNdyqIuOsPZB8O+XzLJ85Yq0wl4QZEJkBxmXJIN0w7pV3cIMq8Y59iuthrQbq/7n8Kp5pLrOFYMxDbr0ftFQeQ1g43554Zc4h48kke4NC39dY6zldiGbHLyosMKE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(66946007)(4326008)(66556008)(36756003)(316002)(508600001)(110136005)(54906003)(8936002)(66476007)(31686004)(8676002)(2906002)(6666004)(4744005)(53546011)(6506007)(2616005)(83380400001)(186003)(6512007)(26005)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDgwTGdYUlJKR1NyOUlDVEVqaitNS0V5WGRsT2kxR1V3djVjME1rd3drQmNs?=
 =?utf-8?B?bXgwRElDc3VsdnY4eTJ2M2gwTFFvNmZsd1lmSjM2cTRPUk5SWHhGOXlPTEJF?=
 =?utf-8?B?TENKekg4NEE3YnJoZy9BNTdkQUZUbkdSU1FWVkxLNUQ0RjVNYTZLd1FIWDhW?=
 =?utf-8?B?eUZwYXVJTFBWdGJaSWFiMkZKZUpXRHU1bjZXd3p0MVBNRERTNEd1T00vVlZZ?=
 =?utf-8?B?M1hVSVRQakVpZGZZbHYvN29OVUFoWmU0T2g3T3M1a2tUTzRWQUhOOWRPWW1E?=
 =?utf-8?B?alJlOEl5RFNDM2lTZ2c4WkozS0RVbnF5aTVwbExSQW53MjVObUZQTjdEWXVG?=
 =?utf-8?B?NWlXbFQzVGRMS3JzdmlWeEVzWExxeWNVZERWWXhUSUNBelRpS3JWbU1icmwx?=
 =?utf-8?B?ZTBnb1NpWm9OM0NjMFlSVXdjY3A5ei8zSnkwTVBNV3BZN0F0VC9IaEx2TjIr?=
 =?utf-8?B?cWRsT2VDNE40OXJUWjA5Smw3SWNmcTR0bmFaK05aeUE1Vnl5YkNyT3FqYVcy?=
 =?utf-8?B?dkQwM0M0S09TdS9FWU45bXBVMHNqTjNmUHh1WUNIMlUxZXJnMzNJVmhHYmtp?=
 =?utf-8?B?YndzeHVWMlJDS3ZyVGI3dExMbmtmN25JcVBEYVA5WWFpa1VQdWdsSDg1VzBl?=
 =?utf-8?B?Um9zM01Hb3puVkNDNExCK21nQmREeGZibHp1VUZpc093NDZxQ0UrWEdZN3pU?=
 =?utf-8?B?amFoY1FLTFQyOFBoNzBuU0ZTV2tWd3lyOHdmMmVBdUtOK0VPY1dXUzE4VWlZ?=
 =?utf-8?B?Q2FlbFdNVjgrTXI3STdJVmtTMmpCUG9zdHlvWWgyc3JZM1FIaG1ja1ZLNnBz?=
 =?utf-8?B?eGJ1cGVjcVoxL2NJRFE1dngzVitsclczeGNiNFY5ZmM0K2kwMm5melRNSkEw?=
 =?utf-8?B?L1FDWXJaK243T1lIbTl6ZXQvempHcWNRQlJUc2UrblJ3eUdhK3dWU3lod2xs?=
 =?utf-8?B?Uldybm93YUN5N3k3Z3RIWUpTUzI0U1ZZdzErNnFsd2Q2c2xNZlM2MSsweWZR?=
 =?utf-8?B?UjZ2WlVHRmJtTTVsV3EwRnpEdngxK0dGTDhFckVpMHRSanNrRmJnYUU1K2ZI?=
 =?utf-8?B?OGU5UThLMVJ0aFV6RkFjaEEzQlNrTS9LdWhuYUdsWUtyd1FEcWE4Y1Y3eWJ5?=
 =?utf-8?B?azhjRHJucFhENkQ3NjlqN3dwREk5bjZHdTdHTGZMc2wzM2pwcmJnWlhxNVRR?=
 =?utf-8?B?ZU1vUm1vcndsaVRBOTh0SWl4cVI0UzlWZENwcEF6cFl3c2hyRWw0N1pUWjJE?=
 =?utf-8?B?TXJkWHl4V2FObkEvc2pjUTBLYmJHaW0xK3hKSzZBeUV1cVIrdGpYeDZHRmlF?=
 =?utf-8?B?MXdWdGJMUXVOMnkyMzI5akcwbE43N2k1cEVRaGJhd2h0NWc0ZUttejdCc25B?=
 =?utf-8?B?VnBPNllzaVFUbDA2bFVTaVNmb00xOFd2VzdEM29NMTNlaGVPU3B1cXA3VGVM?=
 =?utf-8?B?dVpyMldOU1ZnaFgyeXFyR3MxZ1BNTTVjTUZZOUVlc2tkeURVWURBVjBvNXFq?=
 =?utf-8?B?alM1QXYralNPT29TTWxRQTFDN3g0S3gxWDdlUUsydy9jQ1Vwc3EwNkN2aXRx?=
 =?utf-8?B?VXl3cDd0d2kweVd3b2dUZVNLU3h0N2srREZIMDdOUENka25NeFovTm5RdGNt?=
 =?utf-8?B?anU3eVVYZFhmUGRuRGNwUEFhSmpyUkxHV05iVlNOa3B2WlI1VFY5U095OFI4?=
 =?utf-8?B?R3FzSTdndkxjSkdyS3BVanRFMXRwc3ZsSlZOeTV4Y1VsN0twL210UUQ5azd3?=
 =?utf-8?B?dkg1WlU1RFFycUxvc0s2VmZGWGxtM2EzWEplQzFyVTkxbXRjVmtsOHFvcXVB?=
 =?utf-8?B?VlgySms0WUNhaUw4UFJMdk5FUTAwc2N3eDdrMGF3eENCVlJmakU0OFRQVTZC?=
 =?utf-8?B?UnFScnpINTJ0RU9tRUd4MklkcDRtRlMycXRZVmk5SHU0ZThMVGdjRXo4SU1D?=
 =?utf-8?B?QThlYUFvMldEYS9lQnhwMk9CNHdJU1VrNmZuV3IwMGFzMUc1alZUWGUraHpH?=
 =?utf-8?B?WjRQem43SjFDd3Ewc3pYUnFyNEJJSkFxTTJ3SE8xeVVCY0VoRUVyNkU0Y055?=
 =?utf-8?B?YUFJNjV1KzB1UjlMczdzL2YvMStLbkY4NUloM01sRzIwSDNnNUF6ckE2RG9h?=
 =?utf-8?B?YitpMGwyS25Nc3RHWHdXbjcvamtpclBMWGdmbjFoa3pxYnVKS2IvMFRWeE0w?=
 =?utf-8?B?czJtOXBKRXZZZHg4aFo5bmJxVUdxTUdhZFgvTStIU2JTUFRHR2ZKWkxyQlhP?=
 =?utf-8?B?R3Jvb1VnN3pzQVhqWTFFSUo1dUUvWmZDYnFndlhEMUx5blBjd0hOZE44SGta?=
 =?utf-8?B?WE00YTVPRnNZUGJGSFhKTzJKdWNYNUNxd0FDSC9RRXZEemhPYVhCZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3667313e-dace-404c-368a-08da496c7f66
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:32:37.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdRVQJBriyNdYorWN1Af3Wcabujos0KfpHjNo/P+4qJjaIADyzjWRx3KE3UK4pqseyUoRFoUOAEJjiK+j7222g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

We need this patch to get rid off document warnings.

Best Regards,

Dipen Patel

On 6/6/22 3:05 AM, Andy Shevchenko wrote:
> On Sun, Jun 05, 2022 at 01:11:54AM +0200, Thierry Reding wrote:
>> On Fri, 3 Jun 2022, 19:28 Andy Shevchenko, <
>> andriy.shevchenko@linux.intel.com> wrote:
>>
>>> On Fri, Jun 03, 2022 at 08:28:09PM +0300, Andy Shevchenko wrote:
>>>> On Fri, May 20, 2022 at 10:10:49AM -0700, Dipen Patel wrote:
>>>>> Acked-by: Dipen Patel <dipenp@nvidia.com>
>>>> Thanks!
>>>>
>>>> Bart, this can be applied, I think.
>>> Or do you want it in my PR?
>>>
>> This would need to go in through the HTE tree.
>>
>> I can pick it up, but it looks like Linus isn't happy with this yet anyway.
> It's merged as far as I can see. Feel free to pick it up, I'll drop it from my
> tree.
>
