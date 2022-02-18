Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0594BBDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiBRQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:43:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiBRQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:43:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A223191E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV5l5wv/KaCacock5Km08zCu+hkW/lhEkVojzexx4RN2XAS4cY0WAv62Gkt9KGbbcZYH9sb5Fp4cpQGtRQbWgvVXmPIp+AT6vQ91CdZFqY7mwwXecQFMrgU2i8boNYB6Zal9a8tU2KuSUYC3rA08HoeC0RRY8C/67mY0KBW7rHgsiplAG2QKOOLdjLxBbxwRwJ7GyxZm0RTXKKiDcNiJa0gaxS9w/VKMD34Y2NotTqF0+3TF53eEQi7FYC8dp/5m3masj+NarhCcVUoh9g108pS+4M1oNt4AxxGcFNR2jhfLjUf0OCmtUIY0x7II9yfBk2QgCXQ7qz4WblzM7ZSKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MslRGygXUxw4eUY6DZAMYVVa1QO86/VajVINhMn5Ds=;
 b=RWyvPSA2UQr7/foWiLb4fuoiXtu8so5lsUSBma5aLWbG0wbHA3Z+7KG9n1TbrlaDUPX6AKk56Anf+RpVieOSaXuaTlwG1areo3zvtXjkqna5lyINEWoeHvqigzwmexpCpz19qHEzBFeJ5KXy0/6igpMFzIowFDVjSeTti955vYpFxt2WOf8pPlqkVXhtYOMnoYlc2CeSyhwU/CikxUeHOHw8Pf6tCcHXt+zpz74k6qQURDZ+LmdkbNAWT2ROfDJzFQGm3MoMAKYfJFhVxF/j/h8JWAwE52J6akXWlRySk/sIjetzAE5LHws0n/+SQfzqVn+DUJJ+qY8wQTlikDz8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MslRGygXUxw4eUY6DZAMYVVa1QO86/VajVINhMn5Ds=;
 b=pXLZpLhTiVkR3OZf/i9X71xNdcitQ2CtTzCTyDKHJ+7Bb5131JFx70rHFYL+TK8UoQQSy+9zRJ7ytgbxKp7vkf0/LWYl+khElT5UH5AlcjLM1C4llHykZMIZlBNKJuDabaQPJwsQJlYzEH4csYqp+MGMvjKMWDa30/cf7tcmSMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 16:42:53 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4975.017; Fri, 18 Feb 2022
 16:42:52 +0000
Message-ID: <e15fd1ac-d3f2-d6e7-19db-be7d3f80d67c@amd.com>
Date:   Fri, 18 Feb 2022 22:12:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [tip:sched/core 27/28] kernel/sched/topology.c:2284:39: sparse:
 sparse: incorrect type in assignment (different address spaces)
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <202202170853.9vofgC3O-lkp@intel.com>
From:   "Nayak, KPrateek (K Prateek)" <kprateek.nayak@amd.com>
In-Reply-To: <202202170853.9vofgC3O-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::34) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa007b6c-5225-4f33-56e0-08d9f2fdb4cf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5210:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52105CB1C6F77307A3A7868098379@BN9PR12MB5210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCK7j/rsIF53l511EIhFVGrKOcZKlUmB3TF6LOd4fkfFrDuL+IeAgTxMT4pf7txUlAWi/OZ1VNzsjfwiWD7dwdF1PEseqF2FML3MbBBqYpeFX6DWSkbmYnwhhzAtOLrgr0G0+8Wv6hn6hzMY4x7vjeFvLAJO1mjy6XKEkUjHGQAx/+5qsHDFRDbEV39KLx8Js5mEWBHw4p6sWYcLYTZNsHrcqECgRVpA1jRfTjnvDQ9zLJ/rHZ4KJmtZMlFQVDgsiwjddC3D8SOom+WJWXrzOmVgkPdlduOtKh8lfu4Ji9Licdv4KIUcnMFb+rcUmVoWyQIOZYh2dvFoxklHdMQi8NOB0ErfiwZYZaNZG3xg+2h94ZeTUM+nWH+ZneSF9dRK7YXkGhn3MMYpklUkCxX4Wdg8XNCnAWrCxkfsSSd2O69NirIxjAK2Lc6dqPHrEiy0Zl866UCUHS+FfTISvw2Atubm1oJlo0XqWfAyrJYkTLp1n55jfbIF0mC36rmSmEJ15bIDFKyJEK8hsvlB92mTAgYcHetRC/p0zD/3kjMGjbJUgU6xPtpgp/VB0Bjum5NsCc8Rp/jxPcdJlTOJVbSdijMbxI1TXL4O/t0Pqe+t5z2Ql48azNs/wBAwKWib9FDTIQURQlj2AY5n06cyPBB5Fd6ZrBeNvefRziPg6cfmL9/Cvg0Gn+HRM3l4M/o7J2ZkVXBiUVrSeb6xY0G0C3dXfxu6VeSKlzN+bU/Enn7ZTuZ3VofKNmj/eDBDco5M3EfUOerqPrFtnnugfXLL8Lo4WS90v68+VtsPV/FFa3GXLml2cvnGNOWSRaqXi0QFFEWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(186003)(5660300002)(6512007)(4744005)(66476007)(66946007)(66556008)(2616005)(8676002)(4326008)(966005)(6486002)(54906003)(6916009)(26005)(6666004)(53546011)(36756003)(38100700002)(508600001)(6506007)(2906002)(316002)(83380400001)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NBTDZQaklNR24xVXpJNWl4cGl0aGJNL05xb1NOV3BuTUd0bjdKQ0xkcjRS?=
 =?utf-8?B?amk1TE5SOXgvZVZRWHFlcmN1Y2RjbjdUaERuQXVuam5ydEdDaExHQ2FqTE9J?=
 =?utf-8?B?cHE3eFZVcmZxNlh6bWpWZHVHOGZvcmxxZ01YWWg2TVhsQnJoWnpsRlUyR1RS?=
 =?utf-8?B?cm9naFVWUmJublUzM0UvYnY3NGk3blU0V0NyV1FYUC9YcDJlTFBkcktrNmVL?=
 =?utf-8?B?V1dkT0RjVFpOd1oxWUt0dHk2WGRDUmpOMzIwMnNxWHNxWVZqTkxld2J0Vkwy?=
 =?utf-8?B?dmFEYWdQOWxuNWFqUGwxMWlQanh1MVlXRXdsWXhqQnlkMyt1bEFHdWN2eVpO?=
 =?utf-8?B?blRidFE5VWF0aTZTVzh0eXRGWDZqeVc0REdvUFY5U29IRGxXWm1WUnIwUUtn?=
 =?utf-8?B?ZnE5azM2OTdTTWkvcjBNZDlHRWxXNjh1dDdVRU81SVRUMVcrVWhqUkREYjJl?=
 =?utf-8?B?YTY1WGxNckhoa3gzNG5jYWcrNW9ualhsU1Z2M25GNHFkMDUxWUhrMi9MbEdO?=
 =?utf-8?B?TlExamMvY0VKSTJoRlhFNnVhSWRkSGYzaTlNRTlGU1NJTEVtVCt4cVEwc3pX?=
 =?utf-8?B?N012Y3ppWGNyZzBDZnkrS25Qd1lEU0lrMXZBQUp6cmg4RTVTRVNnUEJ5aEEv?=
 =?utf-8?B?MzB4ZEs1TVBDZnFBbXUzd2FiamR1Z0cwOGZlWFJQV2I5Ni9mMTFBM1hjWXdh?=
 =?utf-8?B?KzIwYVhhdkxKem10Sk96WWttYTRDVlkzYmRONytVcE0zUCtRaGZXUjZvVUhG?=
 =?utf-8?B?K3dmcXJrQkk2ZU5nVVh0Um9TZ2FKOFVLM3dGRG1mNDBsZ05LWUgwN0hIcFo5?=
 =?utf-8?B?dndQL08wZGJkcXIyYW9ZZFZSM0tWMVN1eWZqeUN6VENUVldXWklxYUxZWHdh?=
 =?utf-8?B?Z0libytTZGdFZi83bkE0MXJSV2ZydllPL1dYLzZJSG9Pa3RWOHVtUXdocmJG?=
 =?utf-8?B?QWdqQjRnL1lZMzBmSmIxVFdCbjMvY0hlTXZ5RnVzaFNyZHBxNlMzYmpJQnpu?=
 =?utf-8?B?UU91aFlaZjFpdmNhWm4reHNGNFo5elU4YnFIOFhBNUdTQVhGTTNBUG1TbSt6?=
 =?utf-8?B?WllrODNmN25ZL1kwK0xGcGZUOW5VTHhBaFVVb1k1NTE2R1BadXpKa2tWQ0ov?=
 =?utf-8?B?US9kcnRQQTF2SW1meHNSMHFYZEtMYThJZkhDZS82SVBHbWkzSkZUTkFYRVl2?=
 =?utf-8?B?dVFMUWZqVkFYRWgvNmxBMHBXb2w0ZmxvbVZJc09VUmJtUGF0UFk2R2ZRdnhC?=
 =?utf-8?B?QmFUSzJvQThoQjZJSm9oYVpRZDBDZitqN2E2bE56TlhYdFZEUHJ6UHgrNTA3?=
 =?utf-8?B?bExqa0dialExTXluem5YcThYS0c2c2pwZXloS2JJSkR3bWxhV1N1VW5Rb0xr?=
 =?utf-8?B?NjFQMTlidXQvRnpzVmFWdmc1NDdCbjk0Q3NDUlBtUVdGWE81MWRzakRLblBP?=
 =?utf-8?B?RzVBNkJLUUNjSTNBZTgwRVpaN1J4QTZ1YzVCbGJtQ2lyN1RwYmxOR09hTEJI?=
 =?utf-8?B?QTI4ZXZoc2F6QkFkOXl6QWFUMXh2VGw5dVpFdWxxWE5ZOGphQkxHS21xSWdE?=
 =?utf-8?B?WXpoUFI3K3VaeGJNQkZPbmc3S2trV1FNMHYycW1pc3JBenFqeFJqa2hkV3NC?=
 =?utf-8?B?YXJ6ZG5IMTNaMG5jbjVqTXFFWkJRa2U5eVZCc0NwZmpFOStFRTRzV0UydVU0?=
 =?utf-8?B?K3EvU1JIL1h1cytXRDlLQlJWUVFGOEQ3bW9kZDZHNGdkUHhLRytud1g4Qmxu?=
 =?utf-8?B?bVJ0blNWTXRDTUpRRnFKWkt1R3I5Y0FWWFhWa1BtQUVxOVJtVjlWZ210cXJs?=
 =?utf-8?B?dlRFeDg4VGF4elpxbVhZUk1XYWpnZGNtUVdJQ0pMS1RQcVAwaGhsNldEakd4?=
 =?utf-8?B?Um9NSXdzZjlRZzZ0ZThuVERMQ3pCQlJRL0lmaWNsTEdQaGJxVExTL1Z6MVNw?=
 =?utf-8?B?VFhoSXM4UFRFK2k5elFCV0s0U0JOdHlKWGhaUlJHZjJEdmc3RE1aTTRvUnhO?=
 =?utf-8?B?cW5zRHJDQUJ5OWpENDhIeGlNanBIRnZSUDkyWjJTYmtjd3BpQVNJREY5RDVJ?=
 =?utf-8?B?SVFmd2QvY24rQnZHbDd3M2sxMGFoQW9vV2luTDBrb0FWaFhkcWpsZjdvd3BW?=
 =?utf-8?B?bTRmb2tqY0tSZllQd0VlZTh4V0hteW9aZjFsUkYza0RnZVVmcS8vbGtySnVF?=
 =?utf-8?Q?QM3gh9w43kdpwGK6up94m/8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa007b6c-5225-4f33-56e0-08d9f2fdb4cf
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:42:52.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf/DDsIZEsGp71diyhEot55bnyn7jfxYFJ+0wnE5y3jt78TRRv7aQJ1oWFyxwjIsG8y5lBy+y6Rj2pb/ppk15Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On 2/17/2022 6:28 AM, kernel test robot wrote:
> [..snip..]
>   2282					/* Set span based on the first NUMA domain. */
>   2283					top = sd;
>> 2284					top_p = top->parent;
>   2285					while (top_p && !(top_p->flags & SD_NUMA)) {
>> 2286						top = top->parent;
>   2287						top_p = top->parent;
>   2288					}
>   2289					imb_span = top_p ? top_p->span_weight : sd->span_weight;

I was looking into this sparse warning when I noticed
that the variable "top" is actually redundant - "sd"
and "top_p" can suffice for the computation "top" is
involved in. I've created a patch to fix this warning
and remove the redundant variable top while at it.
https://lore.kernel.org/lkml/20220218162743.1134-1-kprateek.nayak@amd.com/
--
Thanks and Regards,
Prateek


