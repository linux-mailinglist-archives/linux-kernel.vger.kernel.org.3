Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FFE522B09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiEKEcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiEKEcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:32:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DB87A1F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ6imAXoPoKRpTPX53V7Rjwq++cTEuSp3kT4OZNL4EVASft2mtSEg44h7sDl59zPiy07faIfCSonMLB5w+ekqcGagT0aClPlQ8pFkazv4HuSHYRJ4PDtOikTUtkMW/nw7Ego3OP3d5R5mzgDRlpMB92i6nDsJl5M7jJSHbIjcehjS3oP3niExrEAwxzSgz9iX+uVzIFJpVXoletsCwXHed9SVpqLuXV/oTOs5dbOHdgy3kNLWfmc4HonVv1eaaG6QbPxh3K3YeBk8l7k4Mf1CbGxNse/a2s07yYrwn/2JiaKtqpzQFbeg+/QIeTLakJ7NpdW7mMUmCI07KUAvEZ0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9svdHHg8y5jfdsixMh/oDs7XTRwYoOMtwZiFwLmQUY=;
 b=YIvAwoLH6oeU1MizSWwwsyeMkhM82fYv8SQQTFdJmQyFDtxH8Z90vXhS9H+tzKPvQ71I/xFZ+GRchYfnfe1kfIdw2bR703o7x9ff3Bnc93sGZtPtgVRcET4dF2XH+zW2KdB3K8Cx9nbwv3Z51uvrmf6M0JDGovWCJ0cYdhtSnGjkYs9H8AvTXkvKd8joByqty2+EB0GsMtrGeivLcLHigHH8K9EV8Vx5gA194ORSKPNz8R9f/Ty1HJvhp0XMsdXjCDxCkUZxfQLhvIz0+B66DV93HNV1tz4CasfJvXBZzIUGRZ79YZi3rO6w2cJS38IBJE9mXV/0UUeJKy7YwFl7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9svdHHg8y5jfdsixMh/oDs7XTRwYoOMtwZiFwLmQUY=;
 b=AAiDFbA+1qgdjqv6wRTYAj4pLO3FmXCMIKx2L9dCvdApr2omM7FQIxLBCBBn3D3a6XSrqPvMIz4Hk7gT3mM7mnJWK2bF2aQRYchy5Wzo24XAP6vMsT8Vz470zRPX9VXGiBUCcV7LxaquRnwohkEogOy8qbqUn8dVZ+qkfrAC7ymTNl7+nrVAiHDgc9jeNXwRP9KmU7aQBIIeTFfgF4K3CYtfnrUbvKYzPR//vmvayKU3kEMEihhmjX1S0ceIao0JBAHqqK7BzgZ6ULt+HhUoOKHHLaFqOQ/xGKbLGeG5lE0EmuXg3xKdRJbWoXVB9IMAAGG0c+pW+mq5qFydmqHiKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR12MB1765.namprd12.prod.outlook.com (2603:10b6:903:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 04:32:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 04:32:07 +0000
Message-ID: <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
Date:   Tue, 10 May 2022 21:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Ynr+wTCQpyh8+vOD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 901f9b20-e396-4881-8264-08da330734d2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1765BD217891DC79F89A6DFCA8C89@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9/ChZDmbupPi0IoyAmedTTnKaJZiL55inFqycrpzV04xC4cjnCJqXttrf6hQEyyLnvhQMzr+gjFQnHHy2MhJt93Zjm9YijKHKy8ER/z5VseI0tO+zGcHKQtQXvP8refFZ6fpwEM6/V3cqyFoO8n6pRXZcaPb7qXgGtrLe1Vlgq5u86FT76BshZpGEHDQEb+UlK410QRs+XXKQBqhqt9lh27AG/nE1Y4TCknK+bqx1IPJ9OufO7zcOrWlaMNiL+tA8TtBzDza0T80UgecIH45uhNKRyLWPw3yX3r8CIGVYaV0yoiWJkazAoMqhSxyFiwcP/fh/XwiLi6dshaD9X/2L6YgO7Hef18UDMXmscJ+kZTngIK88C+tdF9gBk0aFf3ehZcb4vfKtMnvBxEF81y1EfwwRpSH6hyLQIBYURcRmi7ym60emI7h1CNg11ALQ/92xFqL4luehUbgPLBUosCORMuHa7ZkAClOXGKrmXSV33N/P9hhKnDktNhmxvbaaZS9mzPbOiZCC1ADy6v+Gz1vN+lTh3FDMmAAN8Dmxq5+aQHVhG/1jWCYA4kvGN79bdw5W+H5n4eJywMVTxgNFqmSczlgO3te2MftaeoJpmNKgofcXd7r5vejpmKQzxNDpu4CGXbasOxzECB/C7FTrI6Qw7gGRBXi6pjPfylwMbGbbL9vSfwHDSUaoaGjr+wMTjUDTV6FDGGetbl7U9hFNb76coftBi+tC7IeOz0LnRjsOhub1qRgRV/+/JZRdKr5Kn8DQ+Yk074Wv0ifD96AMq2zcDPBo+uv9lIbj/Iub55NEJVqdfww6X4R3XG36/Jj7CnSHd8lXlrxJgd6fqYKvAjmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(2616005)(26005)(83380400001)(6506007)(31686004)(38100700002)(5660300002)(6512007)(8936002)(36756003)(2906002)(508600001)(66476007)(66556008)(66946007)(4326008)(8676002)(86362001)(31696002)(186003)(6916009)(966005)(6486002)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRGc2VXTytpbW95YnJSRkZ3aEg2aFVIZWMvb1J2dzAvTFgxRm1iR3U0aW00?=
 =?utf-8?B?UnhIZVpZUHMwYTdJZFRQMmMvTjUrNDBRYks2Vk1rRFVWSmFiMnhuNno5YTFM?=
 =?utf-8?B?SURSYldnTnliK3JyR21aVXFMNlliVWR0OGprQUtIVHphQWNHcGZQMEZkdE9K?=
 =?utf-8?B?VURhMFl2VTdXcmNsZWhlWlV2em8vUlVFTDhlazZLM1l5YkxpNlVpMWNWRzFB?=
 =?utf-8?B?RGM3VnBHQUFiRkpwZUdkNVNveE9jMWRMU3VWSzJmNWRuaHVFSGNCQmhrR3ZG?=
 =?utf-8?B?ZnJoZDJOQlNGTkZyR3FKcWNpbDhtZ09ZYzZwN3NkRmJWRi9sd2U3ZGtVaXY1?=
 =?utf-8?B?OXdIVjFvOVZjRXdqQUZWUWdqS1pTS01HYTJRMWdnWXI2Ti9UeksrcmlTcEZO?=
 =?utf-8?B?ZmdFQktwdCtvTE9NOUFZMHRIdUR3R1NXdCs5NTVDM2JsOHZGTjBEcVdVbk9L?=
 =?utf-8?B?c2hvczRWQlhCQ3ZYc1cvcmoxY0RBak5TTkp6ZGRHdnBacjB3R2YrTVVEUlVk?=
 =?utf-8?B?Q2lZVktWMUpDQzg5ZndTbENJUnh3eEV1NCtKTUZhMnErVllhTnF6TkNCNWJV?=
 =?utf-8?B?RWtYa0tKNFhPQldFa2V3MjJQdU9XTFVaMFczZHJEaHBtekdZRHB1Y01aSzJt?=
 =?utf-8?B?aForMHNjQjdQd0pmUTQ3Qk1DY245S3QybDc3eFB2SGloRWdTeXVERTlYeSsy?=
 =?utf-8?B?S1oyR1BaejZpbzFGZVZ0WHNXU2xTWnQyOWc4K3ppblNTNWsxSFNmY1ptM2FW?=
 =?utf-8?B?dUlWUXVISHUvMk1xK0VrdDI1Vzc2M1k5cUFaY1pabXgyR1hUUkxZY29sejBV?=
 =?utf-8?B?bE1DS0F0bWlPMTVIOThmVUJYdzNtWVB5V0duYmZ0eDFrSjVtOU0wMWN1NWFo?=
 =?utf-8?B?dExLa1NHMGNNY1pnWjAvUGRSUVNoZjJLcjY0RWpBREhpSXE1WThOWXBmUkto?=
 =?utf-8?B?SXVKTndkY0s1MFNPcUx5NXlVZEhmQXNyc2FTK1FVQjBFejlMMU96cUZjdkpH?=
 =?utf-8?B?ZHZTeFlxQkZTVTN0ak9uSG9oWEdudVE0NkVVL2RKK29NYmRjWnBpQ2xLT1Rq?=
 =?utf-8?B?UktRbDl3c3kzdGlSdnpIc0JhOURkeVZnTnJ4d0t1Zk5kZGR3ZUFZQnozQWVW?=
 =?utf-8?B?OVB2QU4zK25nMjBFa0k2RjdEYWY2OE5CUjM3TWtOZ2g0RTR0bWJzZ2lIZW16?=
 =?utf-8?B?S3A5UWNQb1Buc0xLUXJ5alEycnZEM3FBUW40VUJhazNxU3NnZnpWTnJPWDNq?=
 =?utf-8?B?RkVoMHRMREZNcjlIOVhhMnNzdUpzVnREUlpWeGpDQnN5aVN4ZHdyM2Y4WjVC?=
 =?utf-8?B?aUM5dS9kckhEVjhZNnhoVUJzS3BhckhuUDVqRHoxQVpFOG1EN0oybGtKU2Zz?=
 =?utf-8?B?S0dpMGpqbUk5L2MyZENKN1RaaWo3RnJTaUN0VitVZEs1S2pzWlU0OEtRaWQ0?=
 =?utf-8?B?RW9KdEpoczFUZEl1VGt0Rm8wUXJXbWJJNG85Tjd3V0ltc2ZsdHRRU1VRdXRO?=
 =?utf-8?B?QnFOdDVtNXQzZlBmL1Q4RHJuVUxZM0NYdXI3dm9LYmpyWmlqT1UrNFNpb1pj?=
 =?utf-8?B?V200ZGlaSXBONjUyRjRoYUlyYldnWDNTNjFWSXV3ei9TSzFLd21NSFVSQ2RE?=
 =?utf-8?B?N293Z2puRnNyd3djTnl5NG5nRnhRYVJUeTNpWmwrQmJDajdSS29UQ2R4bzho?=
 =?utf-8?B?SUVtTkVWUDNhUmFrWmlmYmhvdHg3ZlRCWjlUZFMzYkkzTllEV2ZSc0xJdzFW?=
 =?utf-8?B?K0hIV0dIMDRNK05jMVZ3TFVNcUpjOHlSWi96QUs1YS9KZnU4Y25KWkZSR0dR?=
 =?utf-8?B?azlkM0RmTWQ1cGNMeEtmdnl2MWpMTDRCNlVnS3hKb0krcTR6S2lIejZhd0FM?=
 =?utf-8?B?Tm01OE1lcTFzTkFybTZrU25UaGp1WTlidDdXSXRXdnpmRFNRdkRJMnZHWXIv?=
 =?utf-8?B?eXNoYjU2UElLWmJCa0FnVXpZd2RqSmtRenpYRHBwMjBERHhvRnQyb2NoUDVv?=
 =?utf-8?B?ZHhrVW9sZlZoTmFFL2hPS3lhSU9aSFZuazZHY1NnbVVETXgyNCtyRFA0VStl?=
 =?utf-8?B?T0FyU1BYSzFIMmpSSDJPSWVDU0UvUjB3Q09GQ3IzcE5zYWxOaTdSMURDOTV5?=
 =?utf-8?B?c0psbkNZRzYvbWtkdnV0YlRrV1FnOHVUZTVDV0RLY3gzMnFUR0x4SjloNnpa?=
 =?utf-8?B?S2t4K29aK2RtRnRXcG1XZS80YzVRT3JoOCtsU1diVnJueVRQYmhOeWY5OWVa?=
 =?utf-8?B?RmQyaUhVdGRxbWdwMCtkUDJ1M3ljLytlZlMwTjkvakFMMHc2NkgrT3VtaDBh?=
 =?utf-8?B?dnR3dHdtcG9OUHUrSVZZOEkvRW9Od1lZYkliSTNaZFJDdk9pWmJvQWhpc3Ny?=
 =?utf-8?Q?nhanZ7V92/DkzXlA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901f9b20-e396-4881-8264-08da330734d2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 04:32:07.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWfCs36sfmTfBRTwRmLqnVljetpOut2cIKat5FezH9qmXhEQ3UyMD9f4qJKg1NUbFtv0A7qLxilloKUOwzIoVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 17:09, Minchan Kim wrote:
> On Tue, May 10, 2022 at 04:58:13PM -0700, John Hubbard wrote:
>> On 5/10/22 4:31 PM, Minchan Kim wrote:
>>>>> +	int __mt = get_pageblock_migratetype(page);
>>>>> +	int mt = __READ_ONCE(__mt);
>>>>
>>>> Although I saw the email discussion about this in v2, that discussion
>>>> didn't go far enough. It started with "don't use volatile", and went
>>>> on to "try __READ_ONCE() instead", but it should have continued on
>>>> to "you don't need this at all".
>>>
>>> That's really what I want to hear from experts so wanted to learn
>>> "Why". How could we prevent refetching of the mt if we don't use
>>> __READ_ONCE or volatile there?
>>>
>>>>
>>>> Because you don't. There is nothing you are racing with, and adding
>>>> __READ_ONCE() in order to avoid a completely not-going-to-happen
>>>> compiler re-invocation of a significant code block is just very wrong.
>>>>
>>>> So let's just let it go entirely. :)
>>>
>>> Yeah, once it's clear for everyone, I am happy to remove the
>>> unnecessary lines.
>>>
>>>>
>>>>> +
>>>>> +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>>>>
>>
>> With or without __READ_ONCE() or volatile or anything else,
>> this code will do what you want. Which is: loosely check
>> for either of the above.
>>
>> What functional problem do you think you are preventing
>> with __READ_ONCE()? Because I don't see one.
> 
> I discussed the issue at v1 so please take a look.
> 
> https://lore.kernel.org/all/YnFvmc+eMoXvLCWf@google.com/

I read that, but there was never any real justification there for needing
to prevent a re-read of mt, just a preference: "I'd like to keep use the local
variable mt's value in folloing conditions checks instead of refetching
the value from get_pageblock_migratetype."

But I don't believe that there is any combination of values of mt that
will cause a problem here.

I also think that once we pull in experts, they will tell us that the
compiler is not going to re-run a non-trivial function to re-fetch a
value, but I'm not one of those experts, so that's still arguable. But
imagine what the kernel code would look like if every time we call
a large function, we have to consider if it actually gets called some
arbitrary number of times, due to (anti-) optimizations by the compiler.
This seems like something that is not really happening.


thanks,
-- 
John Hubbard
NVIDIA
