Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25577474AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbhLNS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:51 -0500
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:35616
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236989AbhLNS1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcfNnS9QSRHQ9FGno9pQARW9u3bSfCmJn9/h72Fbh6Mye0C+3jFVHQs1MpFtWmhsIyUb9zPwfh/LBgf7zAdwnJMdYtMMCa3JoT9qhTf6uQAciEnKDWL9/9hqaSGhxwrV21IZhTZRGq6Vga5qRWGrVwmIlfdz9BWhu0dWNWfX3b9CE4I89Xi/M+No+4TemTztXz6Cjt0QI1ojTTE0N48s2IN46xay0e6LJoAD+BIJ+8hJXsNrAWQn6Lphsg0ZoWDoqljJ5ZVv+5QFgMDWj7Xf6fnqGrnFTfOviYzdoT2lZZ62bN7GW3IQoDr00Geiwk/vV0SLnZL//XxqHEzgiFm7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yuo3gzonx1s/VpgN1gx/qiR31yP4lC9Tba8Xd/KFtOo=;
 b=KIsZFTl0dxGz97hVfO5D7rWZ1robWo6zdeRSVSsXP+cY2bSZJ+We4pncjzn9kjnXdBBu+lIUIQpaoi9LdpK9xsRMUF0vykfQDdq26ocK6zy3s0sVNdNzA6S38HGk1eIHXmsSe5NSd39/NJzJ1uFOKKrGU0+QoVcIYPv185dsejaABPk5CME990b99BgZoUHRsjUznWuE05sFPk6GyoKFCqx95jOFg7qlmTECiFfiK47f89koTY0Bw3A8Hhf8egzMZc6lAXpx6b+NuaFJnTrWt+IMmxgXyJtn6aELcsfoASP/WkThR4V0U3xbNTLJIKqRIQ/FwaI9cZoo3IDizIN0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yuo3gzonx1s/VpgN1gx/qiR31yP4lC9Tba8Xd/KFtOo=;
 b=H87Hnol+9+nbYhpfIkflsOBXXrhyYS0LTok3u48JuloPEAQ+Q91LlfVOpEh8+HMlR95mwmo0WVVRe2rRvU/2yqe3KjHp2uHENIWAMzvJUvXL/VoSO9hiKwETPD5HTHxGzq3bbwcd3zq9ZJ2r9w4F/0N38nSj6uJHOMPm2gqtsOL+p2Q+5xLQvq8ZMSDd3IAh9Jj2mpzXNzISDFxi5K5K8IZ2gWYCd26lCaM43CsR08fa0V9sVqWtmXBNc3wWXQzxmtzOaoa7/9ub/y59jMNbGaVuSOYaTRO6YzRQzwJ9JRq21Kme7sS6lfckxM4pqpIDBWjYTuNxQvfoP+GF6I4uVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 18:27:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541%3]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 18:27:48 +0000
Message-ID: <6fa79f98-3df8-0f64-8284-b1fbb3e424a3@nvidia.com>
Date:   Tue, 14 Dec 2021 10:27:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC] mm: introduce page pinner
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
References: <20211206184730.858850-1-minchan@kernel.org>
 <78b01f68-ffe7-378b-fcaf-0bd3140da088@nvidia.com>
 <YbfS1m9tBwYMnRqJ@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YbfS1m9tBwYMnRqJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90c54c2-8e55-4eff-9b92-08d9bf2f6e2d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2726:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2726283CD90DCF661A10BC09A8759@BYAPR12MB2726.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwOP7YJfq1L54clvpQKPpRz89nEPpsMuSumoeb1lKWYhY1+/mfzoLuv6LbOBEa24yOVUmdVOiakWx00cEx7m51faQNesJAhSQY7zcLU/iuxI+9SYQ7nMUdPr/YfDsbMRQaL/02kWBfDAopEglElXzP/dwIO2FJqcBARgSiNiQe6/AbJnHePfqIYpGtv0TM8XIkr07wk627P0tju8TCKQutmPY0gRu3Q08OdNwbJaP7iznyxMgw6DBvwOkxFtEHlYKHzEm6ksl6knk07SsttUA6P3Tr85b0xVcvsPMXjH7iah8lexfT9HDMe0cFLHHvTxdXUUC9dYTw/hkbOWq47DDdXsSMY7wL0a0iO2pppGfkMcflp+eQMop+Libd7xlIS0Lpv3B2lr4sI1FG55FhYLsHsSPQyVxc455D/aAnLjOyvRI2imq7wjFp/vDwtZzpf0mPbQIjpiyTHdN158mIwA9SPBmSPGexb2erOPA0HOU+A3wLEKWSqUYsxQ/c4HIgRHJdSmmwvf1Hp//8jJ0hSvO9pTgXDMi8TGTo6tDjOKhmHG/UeDt7OPIB9zoyKYcD0MiTVHpVLZVx0sxcM1EwQ3LlOdGGOXeOymkiMjjAsdAmju7wV8pQ6Fd7YzLd3ZtymWpcXALO+NzPDgw0RIgLWfGgZ3o8kNhniswf4gbO1/z4sZpBmRApgFVMMRBpHWT7KReSpLpkKl+3lSrw8XU7OEzTUTVtGvAeWYolG2DEalo29Ztx7bTs52qnWJltmwux9jqv0tqFXsrDeU8Tdo/hjolfOrtvhiCi1oD8a4wzr3HCLNIi9XSNSwJmfL5OLip4MIOSr0wm8lE7jAeGweJEdRKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(26005)(186003)(966005)(508600001)(2616005)(36756003)(6512007)(6916009)(86362001)(31696002)(31686004)(2906002)(54906003)(53546011)(6506007)(316002)(66556008)(66946007)(8676002)(4326008)(5660300002)(66476007)(8936002)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5GeXRFZEVjdFJadzNuSEhtYzRHTVZWMlRLSFJYc2h3cTdZNGRqZ3pHOWZS?=
 =?utf-8?B?cGV0bVpIdFZDYU9CeHdqeFdZZkVaOFRLSldGNDZGck9EZVhuZWhTeDlxVWlq?=
 =?utf-8?B?eE1oMjRHQmpIbmRTaE9TaVBmdWZtREFJa2dlRlFOQkJobWVneFZmQUVSOXIx?=
 =?utf-8?B?YWZya3FEWUVJWHhlZDVpSjhxM251RHJhaTllMlRtbjFnR04ybDB5QVJ6Y0dl?=
 =?utf-8?B?UUF3UjVyMlZLanAvVFl2NGVFQ2RUcmg1ZjFGdFpFajV6VHhVQVBPZXJ4Vi9Q?=
 =?utf-8?B?Mi91M01tYldtTHhta2NyUktvbW52QzNuc2MxMzY2Zm1lWlVrM0gyRGN0YWs2?=
 =?utf-8?B?M1dvdnZocm5ZYUZ5Z25IZnE4MlNFQ21KMmVqcS9YdkJuKzhHMy9uQSthZHF6?=
 =?utf-8?B?Y3RBaDZiNXJiRFlYSWxnZTZ4YnlnNnpQMW0zSnVxQjJhQ0Z0Nm4wRG1xU1FY?=
 =?utf-8?B?NXF3bXlPVlNOVDB6MDZMb3dZR0JZQlljc1BCK2RWTTloVmZQbEFBS3ZHMWhD?=
 =?utf-8?B?dk5lVElCcjdDaE1GRHFrZkhsL2ZYRXZheVJrN1IzR1VKTytNTXFJckRNaHRp?=
 =?utf-8?B?ZUJuWGZlMHdDQjN6NmVpNTJRMzBqaHNGRElxZ2tvUjBMZVhObmdtU2xwWEVw?=
 =?utf-8?B?UEtZSjFaMkVWV3VZT1hxT3RqQzBnSEhKWmw4ekRkS244d3BaandtNlBTeWFR?=
 =?utf-8?B?UWw3Q2dGR2VIOENmYXhickdFTVVSUnFKQURiNTJoQXRNQXR2ZU43KzM1UnRV?=
 =?utf-8?B?Tk5FSEU3ZVRTT29wNWU0U2JuSWtvT2lXbWZFVGd2SExncllnV3ZrTVFrUy9h?=
 =?utf-8?B?WWRrbE5Mc0JHYnM5bGNBSW1pN0xTTGMwR2dqeThCdmNWYStmK2p6cU5INmRw?=
 =?utf-8?B?MERObkN4K0o1RjdzbDA3MzBmQ1lVeUg3VEVHdkhNaTBGRUJXa2ZkM2djWnBZ?=
 =?utf-8?B?UHZ4LzBLSEFLSExNNGdab29RUEduZWtibkY2SWVUNjZSM1Z3YWM4VFA4WlVM?=
 =?utf-8?B?RS9paDc0ZklYcW1SUWtTbCtqNkJzT0FLUThoRTJLeEtnaXhQQ1RBNVA0dFkw?=
 =?utf-8?B?WFRNb2pYdVN6TEFzN09RY0I0N291TjFKd1ZTVWpKMklhVUFwd1JVaGpZdGVE?=
 =?utf-8?B?RlBKK2lCK0psNUEzNmYxanU2bjd2cDJkc1JGc1VhcjJEZXpHdWFvVmxnNzdY?=
 =?utf-8?B?MFBNaG5LbEVQa25zMVg3bWdXWDVZVzMxRzlsQURxcks5UGZCVE1maUV0aEMr?=
 =?utf-8?B?SHE0VWIydlUxeWJyaXZMNnRqcmN6Z2JUYlpkM3BIQzRZdFJZNEYrT0lNeTdQ?=
 =?utf-8?B?YjA0WGVFMGExV2VJYXNXaFhwYnVXcnVMTnlzY3E1a1VScXdSYVQ5Vk5TU21W?=
 =?utf-8?B?cDY1blQ1eFd5d3oxUkFlSEt2QkxpWlN4Zk94Mk83R0pGY0RPRUh4ZEJDRnpQ?=
 =?utf-8?B?VjdGZWlhaW9xVWUxbytPMzlEQ2NZTy94N2l2VVd2YjhndTVQdTg4dmk5YUVL?=
 =?utf-8?B?NldRcjdKWnVQdTFxZWhzbWZiNVFVREhPcFpzTUZHNlZjNFd4bDhZNHdkbU9h?=
 =?utf-8?B?WUx0MGViZE9FTlhGOFNGR1cyNllCWFU1R3dlYUdVSnlWMWx1NUhpRjhpSitQ?=
 =?utf-8?B?eHVSTTZ6S2ZaUnNiZTViWjhabW91WGV1SGZ0TkNQa1J3SGtJdk83SmtjODk4?=
 =?utf-8?B?a2hmZkFRWGdHMnM1SFR2Ynk3bndXUk9wS252QkdGdEhybUtweHVYL3B1VFFl?=
 =?utf-8?B?Vm9CdkhxNDZ2ZGV1TlJsSHVBNklMMUZmbzRIU3FpNDNpUUpxbGpnTXMrOFE2?=
 =?utf-8?B?QVg2OVFjTFl0bE15WFJLZzRHNm95TzI0MzhIWURnTjNaVFpBeWxJd1BxNW5Q?=
 =?utf-8?B?dFJOdTlTUVhHVElZR0FPeVJvejlrUDhRQjl5T0M5RGdhODNFRkt2MW0vL1Bp?=
 =?utf-8?B?ZzRrY3FzNGhMa3BGeDVxVUx1Nzkya2xtMHo5L29zMFRjbFdMNHZzTjd2SC9N?=
 =?utf-8?B?bXV4Rnl3UXZSckV2STYvSVVxcUpSeTFOM2tTTUtqcmZ0RFNyTFJwRmRSdGpz?=
 =?utf-8?B?NTVEUUJ4RXRRMW51anFNeE9JVTVSTWl6UThjbmU1Tk04a2MrN1I2ZW1SSWI5?=
 =?utf-8?B?dUVCN3RzNjZTR1ppL0lkZHFnMUt3UmdSU05RQ2h4K3lrZDdzV2ZDSzVHVFox?=
 =?utf-8?Q?f0/pACCJtsh/dMB7zHaifrI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90c54c2-8e55-4eff-9b92-08d9bf2f6e2d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 18:27:48.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGqeWQP3/UjvvQYH3STEnTc+JufoV8qOSVcfAVBsQ3P+pJaFYiVdvKIXbeI3SpvQAQjcdTsc/aAIfMjgEtfEJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 15:10, Minchan Kim wrote:
>>> @@ -62,6 +62,19 @@ config PAGE_OWNER
>>>    	  If unsure, say N.
>>> +config PAGE_PINNER
>>> +	bool "Track page pinner"
>>> +	select PAGE_EXTENSION
>>> +	depends on DEBUG_KERNEL && TRACEPOINTS
>>> +	help
>>> +	  This keeps track of what call chain is the pinner of a page, may
>>> +	  help to find contiguos page allocation failure. Even if you include
>>> +	  this feature in your build, it is disabled by default. You should
>>> +	  pass "page_pinner=on" to boot parameter in order to enable it. Eats
>>> +	  a fair amount of memory if enabled.
>>
>>
>> We can do a *lot* better in documenting this, than "a fair bit of
>> memory". How about something more like this (borrowing from the updated
>> commit description):
>>
>>    This keeps track of what call chain is the pinner of a page. That may
>>    help to debug Contiguous Memory Allocator (CMA) allocation failures.
> 
> https://lore.kernel.org/lkml/YbfQJ0eTkkImUQ%2Fx@google.com/
> 
> I need to rephrase this one to cover other sites not only CMA since other
> reviewer also want to see the failure from compaction.
> If you are interested in, please chime in in the thread.
> 

Actually yes, this feature is potentially a general-purpose tracker of page
pinners. It's not inherently CMA-related. One could use it for other cases, such
as any of the NUMA or HMM migration cases. HMM's migration between CPU and
devices fails if pages are pinned, for example.


thanks,
-- 
John Hubbard
NVIDIA
