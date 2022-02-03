Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8C4A8FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355027AbiBCV1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:27:22 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:11777
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232038AbiBCV1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:27:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdxZ/NjKcoIPCXxZyOT6Q+f09J1cXSxizsVkr/bO0T9gUiTETQLaj6U3mI6qppAZplFrglz6MOWyccK2gM2aH1TI3eHO2cuPpjwY/pw0SFapP5u3ynVjDMkTvR0BW/la0nm8JtFke/8kTrs+6LGCZV+L2vvPzPT9OSzuI+u+ScwdUvchMDYN+lplkK6EZj8qjh7LpaSFrDMjkOjp4ez8D16pU1qEFhB4qO9MMwZ9xI44lNr1QglUqgdUBr8Gu1Qku1eXA9MJ+Ab2oiKBOdbvjG5miZnHqJVDZsXlJt4TEqxZ602LOdm71F/USHvja4zAp1yNkzcKDVrjC8fAZP6YQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfHevPEE6NnVPrcHLdeqlwK2PrBNoKagNSSOLdOkPsY=;
 b=FnDwkmYslnPO+S6pH273i0WFD8qwVHgJI76CaiqeAIfHMPku1QETeUssTnIdKtJcQWF5eYcwclqAnkEtJoiDHiujdirZAeYtYSM6zAkloa/PGqmwJzOsq+EdXEERObrn79z4e9Euw4wzeQAcYFrQCYocp0sqt92OnxpQcHyJr341OCGk/yMHYdTlXrP1tXJHvlaxGZE2EVK6013/Y1uQaA0eJvESegBYMJvqTiqdCnDNb/x7ydb4FRIrGe9pwlW6m92iJx8xheAq/Z7e56V9yGHNUf6jqWucwUGhKXdn7mpxEK2P7grazQ8zqUTL6tk8wc1+DomPx8VULTstEheOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfHevPEE6NnVPrcHLdeqlwK2PrBNoKagNSSOLdOkPsY=;
 b=GQEUjEvTatjzb8VsZPXayWEpqOEaxss8zE4cK77/9ZuImzIeDDANiRnEQN7RVT+P/tzjvLe8ttmTdiWdd+6wRGIpv0cYoO47CzTvYYxcnHHqyAtc0NzqVdlTf2Iv9nMNd7n72QxNJXLmuuiGLk+Gl4edzRm8uYx8r01v7e/ochw9W4gPupZBRe8F48vJ6su+UzLtJgc8zBR05bUjSALqnzRPNnK9pYyjuPQRZvEtScT0+14bFkRfpfe97VPSZwCVN7IMIdyE5LbhwuK0APi+7d60k/3jehq0OxJP1sG3kmVfZsEHlgtojhgMKyyEf+8dJbAoo6QhaBsW9j1POagTGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 3 Feb
 2022 21:27:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:27:19 +0000
Message-ID: <7239e60d-9873-52b7-2e05-43d5500d6459@nvidia.com>
Date:   Thu, 3 Feb 2022 13:27:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 4/4] mm/gup: remove get_user_pages_locked()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-5-jhubbard@nvidia.com>
 <YfvgQHewEbN3lR33@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YfvgQHewEbN3lR33@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129405b1-5fc4-4561-0f1f-08d9e75bf547
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB248865728BEDD9DCFB2BE187A8289@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XSBhbTc/cDVDG58DaMAJ2f4FclgPqxojZ97EpleMPSzHscKULmTgrd4H6TBUa5PUVCuKUIlCGwckZ8UADuifEwTaqchlku9anSslxVVuuTmzHQuGx3WP1YeU0gYtmXWZ+tR30TLUgzorfW98XV6lKJf4AnjxfAqSoBFlJ92E47bZsWMv99SNn23xcOmIW1BjO7YDqhCRQKPFHWG4o6BKlR4ezUgD8Q+kxmpI0Wv0M3t+FA25DZ+JF5FCpYlQZMr5pKiFpdo2NovYTcdFRlVhd35jtXBQJJ15Nz7af2ZU9MgFkKSSHACe6/5cLKHsGwJBuhSoEEDP4++o+1k3+ur3w2/mu56uWVV9Vj1/6o5ofAiSOq+T9ZXwEZXy+atDvrozFYbQhSlGDcyT+PfKU+9hgBFfKGdMyElsLEymUjlpWzwC5fRujHICkaHggzCPBJa0eX5LDCAL9RrByDJDZuIGDmfb2NZjuvtGUsRGrx/gTxzlKuVKvW8GlM8ous14zLNQzwhmOOqcXiIug8+coFcYZoFrIW8sP8pCi7lOCHWI4szBUoThnfuOl1Ljvy/Rr4WyRUq4TRONzTq6BYgLhSekMR4hV6mq7vizXVaL6jisRIcIR76Wsf0LfTXAqJxtIv0rUkWuLD1z74VMFV3M3fArSNlaVSh08sZh/v+47ogf8TCNwoUgZJZD1uD9FmZYpu+x45nMW2hP+Z0fyE0leCCTbg+xFyVCc0my3as8ixO4LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6916009)(66556008)(6486002)(4744005)(7416002)(54906003)(66946007)(6512007)(66476007)(508600001)(83380400001)(2616005)(31686004)(2906002)(107886003)(316002)(26005)(186003)(38100700002)(31696002)(86362001)(36756003)(6506007)(8936002)(8676002)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJIaXhscmlBZUZ6b05CVVovQUZ1SktZcDc2V2txeTBkWGMvU1czY3BWb1Uv?=
 =?utf-8?B?QlowVEw3Mm1vSFNyUGpNVlo0dUxYMkh2YVFFdXFjL1FHZ2d5TUFpb2FPLzNB?=
 =?utf-8?B?bUxBUlVackM0czlFTGRQcHJwdEJoaTZhNlB1eEtqWSt1VENad2phWGFNa0Zu?=
 =?utf-8?B?b0dQb1RqVUFzWWNwZkkzSUVSc0FjVkFpaGM1L2N2bkRQblBTMlpVYkNjRVZy?=
 =?utf-8?B?Z2p0bGxPS2ltclBrZkt0QUlXVUl0ajB2VnJjZ2lMVGZGYUVOZUlqMHpEVEVV?=
 =?utf-8?B?VFVZSUlCRUlKRmtmY2h3SkRhZDBCRWZHcHlrM0ZXSjVOb3dvdVFjOUl0cHhC?=
 =?utf-8?B?ZEtsZW5KZnZxQnBOZ3JRa2w2WDNOM2FJTVMxMjRlN2JPeUtIVCtUMHB5Um9o?=
 =?utf-8?B?SXEyeEcwSnJGU1BWTGxmZThLSEVBcnJKMFlWR3dCTFduTzlOOE5qZUQ4ZzYy?=
 =?utf-8?B?dmhLTncrQ2l3cDd6NVVqTFV6bk9LK3RBeGtBeEliSFcxamQwSll0MG94QTkw?=
 =?utf-8?B?Y2pSNG41WXdreU1ob2hCcEpZMXBjRGpiR2N5N1ExZy9RY2ZkNCtuRWVzQWRN?=
 =?utf-8?B?NTlKMFRSRVRwamF2LzdZME9TZXd2c28xd2hGZk1ZTUNObkw3ZEJqeUpISDM0?=
 =?utf-8?B?djhEZlBRdnhoTk0xallYaDNBc0drVk12TGdEbTRjZkNURHo1MGdDeUpOcmU1?=
 =?utf-8?B?LzN4SjNqZmd6dzlhY0hndE1tdnJVMnY3a3hWUjM5YXp5cHhjYWwydHFBVDdu?=
 =?utf-8?B?R3BWb1Q1UEs0bTBhdVU1cFNEK3Uzd2k4SWRqeFhNc1BVRDRwblZvc1NxV09W?=
 =?utf-8?B?RlpZK0ZLeEhnd0E5S1NZT1hvWjZ0TTR4T0cybndHZUxpbjUxVDB1Qk5mYTJZ?=
 =?utf-8?B?L0ZLNTN0Yi9GNDJkWVlSTkdyVVJwdnVSWEY5MHExSHNEQmxxUmZnVTAxQ1J1?=
 =?utf-8?B?MGxkenRGSGIyWTNVblBRbWRmYkZsWkFCWHRoeTIwdWIxZk4ybXhWcS9LdnVV?=
 =?utf-8?B?eFEzRWxPR2VMMXo1NmpoMVpvUHpuVkZZejJYQ3llUFlxbFl5TXV1SjEwVjky?=
 =?utf-8?B?VWhjSU5qWWJITTdMSlFUaUgwMS91RzZGMTNrOG11L0RYL2kvaW1aeGxDMHJV?=
 =?utf-8?B?SjdWbFgwNGJmN2ExMDNVSXN4K0NYUkxsZnJ0MmZSaU5CcVpTeE45T1YyMFY2?=
 =?utf-8?B?MlFwQXJsVlI1K3FTRGZQTVJkd3MxbjVOZzY4MWRMYkZOWUxnY2EzVnlrcDdM?=
 =?utf-8?B?NjlqWXJLbW9xL1orUkVqZ0k2SjU5K2dtbnoxcGNHVkpKL3BrQllFUDVPT0c5?=
 =?utf-8?B?QWFQSUJDY1k1WG8zdTFFV0NNa1hlakZCYzJpaTJpeWFwY0tTN2Jrbis0WkJw?=
 =?utf-8?B?c01BVVpSSHpBWTdSZjNhdlQzZDdiYzRGaGhoUlN1UGVhUndzYXV1SEhGV3or?=
 =?utf-8?B?YzREcTBPWW5wQjBOVmk5L0M5azlKd2NEcDkvWVltVmNLemxFbnNTV2pTYUhU?=
 =?utf-8?B?bERTdGVOeElCZ3JQSzhkWlRtVWpHREdPVHYzeG1sV0t5a1kxcUV3UW5oelVw?=
 =?utf-8?B?aTlLZHoxZitQY0lUZ3o2TEZXbnFaRERiUUNucU5wS1VEMk5QelVSUjdXTWRs?=
 =?utf-8?B?bDc2TDRWNTkyYVpaaWFkV0VVMGZFV0Y0dHNSNGxkaEgvb2JVUlB3U3F0UEFz?=
 =?utf-8?B?bmpaby9CYXRYMFhFTnVhVVdGTWt1NjVpT2JPQXVkZlBYZ3dValZ5S0RUcTI4?=
 =?utf-8?B?eklXemkwMnZESWwxQThFSng2ZXhXV3BabWZWTVhYOHo0S2Z5TS9zcVk4N0JL?=
 =?utf-8?B?RWlIWlZjZkdQRDBuU2oxZ0Q1S0svTDJ6a1U2cFU1K0lPSW5rVGd6UDFpRXNY?=
 =?utf-8?B?dkFyUnB4RGljTm1hYndmU0gvaTZuQzcwMU1nMWtyUmg4THJmMCtvNWR1OEFY?=
 =?utf-8?B?OVdhVGJWY3BaWDR0MC8xS2ZlaXJGMDU0b0swN0lFM3dVb0hJUmVIMWE5R01J?=
 =?utf-8?B?YURSR045bDR2WENibENOTEtjcFE0WkZpWXM1VE9uamRnSGZSYXdNNDZZcWd4?=
 =?utf-8?B?SVlBdkxrRU1menNkWndTdDhKckNZbmg5M1pGc2tNb090cThVbWg0UDJHUita?=
 =?utf-8?B?SUZRWlJsMDBhYWkzeTBqUnJYVU83SHg5M3VsZlFLUUxDanBSbkwyNXVPemdB?=
 =?utf-8?Q?5AgAxopQB1RwvA6zMnexnto=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129405b1-5fc4-4561-0f1f-08d9e75bf547
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:27:19.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ite58sibcaoTEBzmjVozn5zwQG8Dk8iQAsfb4w8Z/UsDh/JO5o7sYhqGo0Zry7bTXxSCOpi3WNh933xLpsnsYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 06:01, Christoph Hellwig wrote:
> On Thu, Feb 03, 2022 at 01:32:32AM -0800, John Hubbard wrote:
>> There is only one caller of get_user_pages_locked(). The purpose of
>> get_user_pages_locked() is to allow for unlocking the mmap_lock when
>> reading a page from the disk during a page fault (hidden behind
>> VM_FAULT_RETRY). The idea is to reduce contention on the heavily-used
>> mmap_lock. (Thanks to Jan Kara for clearly pointing that out, and in
>> fact I've used some of his wording here.)
>>
>> However, it is unlikely for lookup_node() to take a page fault. With
>> that in mind, change over to calling get_user_pages_fast(). This
>> simplifies the code, runs a little faster in the expected case, and
>> allows removing get_user_pages_locked() entirely.
> 
> Maybe split the lookup_node changes into a separate patch, as that
> allows to document that change even better.

OK, I'll do that.


thanks,
-- 
John Hubbard
NVIDIA
