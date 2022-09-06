Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4875AF84D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIFXQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIFXQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:16:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E917EFC1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etwpQmYSTnad/idmTJROJU9fQmM3IAY0A4PJ0HN8Jpr6TGSFYNePiKeC1Ut7klJJQroqjiNap/SWGtQPrUvV3APhjYJFMTZrzLkgO+qRHYseWdAFV1XZKyUAtLNu2jTeyWhWDg9624/qZmVTGPRJTqzuY2e8dOSpdr8yZuXh4+XFDCSA5Fb1mscrOeBdU6+JmeWZm6iTWG86kMTXnoxBuuSlyQmfJ0Z3ghnN9EEYDCVJSHqk1HvYE0dEw9pCFNEfRZ4EkssclRiTWxbOIZNIMT89R614er40/scONV7dBQicrrShBNGgEdF3Ik7uw8kz7AdwAExfEIfSDW0gBU9Y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwmkAFUWQQRbc8VGA6x7XE5VCUZGVYjw1XvkFrUTn+U=;
 b=XwtZcItqYXYje0ng2TfHjn8taM/DVTcILEwA1Vy1S6cAkRrOKQdat/6rPOl4kgxYdIKj3lIt9Mp4WPXPnzT6hsUfrdSPCk98aFWfLbE7yuUaTB1oDSQGBdQ8jTfAHm3nfkXJijn2NCh4+K/v7GwtqrJUbm0NXcfi1S95P2iMQll3uaiGeYMFkeyNaAMJZIb/eNTlmGvkiFHvAg6xzQKOVw5QZs36JB6DSNJxH9k3aG9eD4HAUL94LXXgHRnYQJOfHLKSPFo9cgDbk0qqhjtOrLbRgzFiJa+E+dfUXiBZJ+xvvGa+lbUMGOq2HIRvHsSHC1AMqkoVLS4pT43/JF1NDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwmkAFUWQQRbc8VGA6x7XE5VCUZGVYjw1XvkFrUTn+U=;
 b=j1LdksawMIu0KHzhAxx3nuOx7/yxDryhGueXoYjrzC3vePPllpYYACrKfafFhtwf8X2dmUrKtSv0g/ueaxfIGJkef1VXjlj1iQz2aCRbT/2s5KZtgkZIaLA0Keq+b3UFr3c5gOVAThuKhpcwkgi1Vp8p6SAKOIkISlq+ARV+DFdag++tRPNQgnHa0tdzdfooxJLceSETyrZofZ/yUX8+jzaaEV7237v2hdg2pbw0Xt5XF1Be0haqwsITCEUXHnaTCxFM+weZ3ZilQVGcDgOm8kg26CHxqDrwu/insYwBUMn2G+P3RphT3qqvIm2VCLMG8MJT1U9j5p0ke21RurVcJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 6 Sep 2022 23:16:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a4df:917d:22d6:6ea1]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a4df:917d:22d6:6ea1%6]) with mapi id 15.20.5612.012; Tue, 6 Sep 2022
 23:16:44 +0000
Message-ID: <778f60b7-97c7-3c35-1b40-40cf844fe89e@nvidia.com>
Date:   Tue, 6 Sep 2022 16:16:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <YxdPi2E63aO0Dgyd@nvidia.com>
 <4516a349-49cb-fd7b-176a-f1a9479906d9@redhat.com>
 <YxdZlCly2ad1rtcI@nvidia.com>
 <40486dbb-9f19-6fa6-d46d-99d2b033883d@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <40486dbb-9f19-6fa6-d46d-99d2b033883d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7633d1-04e4-4715-8329-08da905ddd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vESbI2/qK9fFybs3jRb7MU2eynBCrjkGUVHXCgdqsitTd6LkyTgbe/d6HfmrMoK2QIPOpHUqJZ0KXbmBYm4DGqfc7qM5dLLpzVC5i6GhZ6FRaA4eActTH4B/Is62ywGWc+57D9B/tl6i5hvpE8nCIT94bXpr0l18wsp+MNVaRK9k8WJ/x3ERKnDVGhM5Qv+zT2JENuAL/+Do4gEqzwuDBzRYEr7esx8EgEDV2nnL/ogMVT92Z9jqvwADZeHESfmnvIuqGUBFZ/NRtPiOA2wOJUMVVEkUJlplKcSbf/MCBBFr7AavwxESGPDKt4Mn9lMYacAxjtIu+ZF8dyYVQcNYatydYtrZB96VZq5tRWbrKxi+o6imYw29Sni+it5GSw3qGOe8cIlsMd/5JFAaD0POU91s+BdAEwmR1X9F3rCWJWIixMwj1H8dNhH9Ph6+ZqdBlCG86yPpvC8nANQU3cYpGXkUjCKaLvuE8LQgPcYnAvzrwOdJo1uqCd2yaqCeA+dMXjfAZQPKM2/fjhMTVxdLPV+Ls7Ot4KA+z4C1Dyym49olFftDf2gcNu3z0H/HoLMILIaSLbpBOwAUl7Tqf892BvrtH5a5eKUqV6zKmPkFo8vOFxkBL9EGPHteQ7ZXXgKgZcoOTbACcIqNMD6njavitM2Js1ppXkfTJ2DkrWW9l1TY4UQ1+lk6oWwVHcSBeb2j1rvnqynYkXTTXiCKk7IdXDOmZCuVSO/5Xyw5qbZHQjT6FSmIQFd2xUe5jJPiRT2oFxfkXb0dFIVFVSeO+MuFwYeO0p4Srh4kePfMYvcPqhqdcnxZ7HCKj39hPCziUUYP6F+fuDZAnKT/L9DypzHQJcW/GqUeBfMmHSVQaMZTLObB3vO/kD4qpp15IR5rWs/a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(83380400001)(36756003)(66946007)(186003)(2906002)(2616005)(31686004)(5660300002)(53546011)(6506007)(316002)(26005)(4326008)(6512007)(8936002)(66476007)(86362001)(66556008)(8676002)(38100700002)(6636002)(31696002)(41300700001)(110136005)(966005)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUVwTTNPbmZxVklWekdwT2VFWWZ0eG1LMW44cWx3L3NIZDRFY2FIMTdac1p5?=
 =?utf-8?B?MHp4ZS9sdzdXb1I1cWxnQ3Y1NnRXeEZKdStlYjJMOEs2Z1FRZkcyM0ZKUTRS?=
 =?utf-8?B?K2x1NThZMmk0WHQ3NnVaOUcwUE5zdi8rQkY1dzdSWUdhQXkrV05OZG84SC9L?=
 =?utf-8?B?N3hTK2FNMVlYSTRDUlZqM1I1Mk55eXluMzhvSnpBMHg4eExYRWJhNFlON1la?=
 =?utf-8?B?N0NlUTRCdVhmTGdHajhSaUNNQmp4WHVMd3ZjVlhFZzIraHJSeHMvU2s3Vzhy?=
 =?utf-8?B?R3k4dzRIZ3llL2cxZWR4a1pRa0h0b2Q0dzRSZmYwRVc4MnBURUNtYjNPTzlX?=
 =?utf-8?B?SzEzZ3BPNmE1dmREbmNkaHMwOWU3bllyVDdmMUl2M29OUUtpQVBicnRySU1a?=
 =?utf-8?B?RGlVTEZqRHhOaXlaUzNDY20rY2xCdWZlLzdrS0RBMU95SFRjYTRLQUU5cWZ1?=
 =?utf-8?B?Y2ZJbE0zSldGUEVrbmE4akFGeUxXRHZmdlA1SmNXakxyK3dSQTRrcDVsZkxw?=
 =?utf-8?B?KzJXc1NKMkJCVlhlam82V25tdEpvSmhmWFhySFEwM2pobmVtMklMMnF5dnU2?=
 =?utf-8?B?anIvZTRVRlAwWmh4cnlKR3MzcktOaHp5VzQ0N0Y5UHNhc1c5STlJYks2bC9V?=
 =?utf-8?B?dDZDVUZ0eFl4VTdteXBIc0dtR3lBZWtTNjVTVW0rS1JQQUR2WVhIVFFRL2VX?=
 =?utf-8?B?M0JhSmgyUHBQZmhiOVJhNzNEVHk1L1dIcy80c0VYM3JpNEx4L3hmVkw5RTdK?=
 =?utf-8?B?SU9QWnBvdjZvNWdPUnVlVjJWTU9PeWVnWFBWR1VscEJpSnJ1Q01rSVNuNnhK?=
 =?utf-8?B?N3Y2eVJ0NHJpNnFEU1RhUDVDWndmNzlBY25YdEtSREVyQUJwL2NkdGtteEl6?=
 =?utf-8?B?ZlM0Y0ZWNDVRM2RYdDFQS0JKQ3FkUXBWRzhrQWQrS054WjJjU1ZyWkVtNGNl?=
 =?utf-8?B?cDZITjh1ZlFHYi93OWg5eSsvdXRGM2NKMDdOcVQxc2luWXRmWFlpbkFQc296?=
 =?utf-8?B?eG1BY3FOSGtoejRhTDJGdWkyZlZPL3hiUVFyUHZhTnkvczcvamR3TTlEQ2Yz?=
 =?utf-8?B?ZEUrZnB0QWI5TEhUL3ZmOFI3cWJiVVRDMFVJN00xRy9yMXY3QUs2MWhxT254?=
 =?utf-8?B?eTNuNVMzcC9oWm5SelpSMXZ6SUJocW5IektnUnU0YWpaK1Y2NDZMQU1Wdkts?=
 =?utf-8?B?U3FPRyt3UEhLQ3lDUks0RjNqNFcrcmJvaFo1V2FyQ0RrNUJuSEJ3NmZzWnE0?=
 =?utf-8?B?cFMyMUZiN3FkSDlNa3E1Rm9wckd3aDVIUU01VlJZNmpDYU90TG1YdURKM1NN?=
 =?utf-8?B?SnE3Q1dkbVhDa0hnTFZ0cXM1UzljcGpYSitCQ0ZQWVNVV2JGZ1R5QlE4Vyt2?=
 =?utf-8?B?ZW9aT1VXclR0a3pjNTl0Y3JQY3laZVJyeE0vUDZwWFlkbmhvSUtSTGZURnNs?=
 =?utf-8?B?WTQxRnF2bGRzbEhCOG1SbThKYzY1SXg1WWszWThjR3Rpa1JlNWR3UU8zUUFu?=
 =?utf-8?B?dVBJUVNOVmxNTGJNTVc4MklEaTMrMS82czJKT0xlL05rbkdjc0pGYTdsaGs2?=
 =?utf-8?B?bXp4a3Q1Q2dVL0p0MHJ2Y2FqVllNc2dJNHluNUhtV2JwTDdXUG43RXVJVW1R?=
 =?utf-8?B?eEsrWGN2cU9RMWRXRmpZU3RmN2wxSENFQ3FSY09TL2xvdk9JZmo0RG9CQWRF?=
 =?utf-8?B?TFpqcm9PbGxuQThjdlRVNzBTNFhWaVlOeWVqOE52UU45ZVA2MnFKR3ZxdG9l?=
 =?utf-8?B?a1pZOHJ4aWd4WERuU2dJR1ZWZ09oMU9pREFTaGpWYUJ3c0RsSXZvWFR3M0RE?=
 =?utf-8?B?MVNJVmE0R3NQMWZvd0xlNEJ0a1ZWQVRYVmliSldXTU9PM2xITFQxMFE5cEdS?=
 =?utf-8?B?L0VHZW5yamxBbmg2eXdQRlp2cDAxdEk0S3BuR24wTWlGZWJvQlhqb2ZhZkVr?=
 =?utf-8?B?RkRJK1E0SzRXaDIrQTN4a1lVeDV2dUlZSlg2NlBPUThkTERRSUYreXhWSjJ4?=
 =?utf-8?B?cTFyWmdLbWJXbDdXR3FsRHp5ZmNvZjRQUSt6Nk55VWtrOW9sTGVBSWxGNEZn?=
 =?utf-8?B?OTMzQ3NLOWxWdlcwRlJ4bG5aNDBsQVNMUFBHbEdNRXVYaklmNkhQZjVINGts?=
 =?utf-8?Q?BwEeg1UHEv/yHg5/X2kMHGeUv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7633d1-04e4-4715-8329-08da905ddd62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 23:16:44.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM75wibxzzbbGJjL/QpHc9FZl3jl7LlKMO9Ul93UHBsmKdOtUv0vRXL++taqhYqE+VTfpmRwMh+XHoAH0NjN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 07:44, David Hildenbrand wrote:
>> Though it is all very unlikely, the general memory model standard is
>> to annotate with READ_ONCE.
> 
> The only thing I could see going wrong in the comparison once the stars 
> alingn would be something like the following:
> 
> if (*a != b)
> 
> implemented as
> 
> if ((*a).lower != b.lower && (*a).higher != b.higher)
> 
> 
> This could only go wrong if we have more than one change such that:
> 
> Original:
> 
> *a = 0x00000000ffffffffull;
> 
> 
> First modification:
> *a = 0xffffffffffffffffull;
> 
> Second modification:
> *a = 0x00000000eeeeeeeeull;
> 
> 
> If we race with both modifications, we could see that ffffffff matches, 
> and could see that 00000000 matches as well.
> 
> 
> So I agree that we should change it, but not necessarily as an urgent 
> fix and not necessarily in this patch. It's best to adjust all gup_* 
> functions in one patch.
> 

We had a long thread with Paul McKenney back in May [1] about this exact
sort of problem.

In that thread, I recall that "someone" tried to claim that a bare
one-byte read was safe, and even that innocent-sounding claim got
basically torn apart! :)  Because the kernel memory model simply does
not cover you for bare reads and writes to shared mutable memory.

Unfortunately, until now, I'd only really remembered the conclusion:
"use READ_ONCE() and WRITE_ONCE() for any touching of shared mutable
memory", and not the point about other memory barriers not covering this
aspect. Thanks to Jason for reminding us of this.  This time I think I
will remember it well enough to avoid another long thread. Maybe.


[1] https://lore.kernel.org/all/20220524163728.GO1790663@paulmck-ThinkPad-P17-Gen-1/

thanks,

-- 
John Hubbard
NVIDIA

