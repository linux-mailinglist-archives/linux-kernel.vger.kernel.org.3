Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8759F493
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiHXHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiHXHxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:53:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E283F0B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcB9Z3bFcczKk7wtKC5nQVBu8N3Q4GL0wdoB4e5sH7W6tLqWBhq0Bw1Zv5hhLuoiHsonxOCN+CGPPiwrqJEl5OiCj5lkgh6JDK7uXDnwAr8ekH51wQGbzKrAbsYjJ5wToEWi8Is4aL54kFW9pe0T02p6kw8dLEwjCWpFcxv6PAo2uaq1b02ZeNlDsE8/JYQdACRjIgLMzIOHZDwMikbemwrZST+e8LutMgmG4tu+lMFl+5y+y8hDifUKImxHsAvoAo4KEoqXN5grZO4I6fj5XuKx0RN6QUHhME5GcBz3iyWQsJThH+1YNXyuGRgBnEHoS5qGt61fo8k7MobMcbxdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkIxuyy5pzJelKesrY/LPLk9cocN/ap/QPZEgUIbrzg=;
 b=Z9m9E5ayQ/qdJdiSyujmZQKeJpl20/oTWCRweTIwIOK8H0Yd5JGFU4gNJCohMK1k/hykpImzZVivhwtk/qXXp0zBpfMnxBkUiGO81TOV9Pc3K9hAQ/NFbBgSJopdpGkPZt3qkABodLbB9BLUQvHDAjhrZASgtTGFwL9ihitcY3K5ivkE2iqugUzJuEn1mZbORSoo3s3cG9WOeaQnrkOAzDOT9n72qNZOIxMec9GPmqJAUgBmj6TzIvy+jAYDndw06poXydhSyRORuY7Jma1xLcVL2CYlxFH2HrlLMMbB9dNXjzzGf3c7i4gVNqdXC7U9DVXTmUGt1BiXMYy9o84aaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkIxuyy5pzJelKesrY/LPLk9cocN/ap/QPZEgUIbrzg=;
 b=ozuIkMOpo9AQqJFGaHz2j4dbYJKrlNXd+dQJyXc0muFk5J9pElqYAuCSIg+LLD2TkiodVKAEDuXTTDG1WGwQz2vHdXGEtwZOfkM+I25RKBzD/WeuJIzhRi3RSwoVSXOSJRoXsk10RLc1uJYasC+jn8RWbtTNJUv94XqD7Zi9blU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BYAPR12MB3031.namprd12.prod.outlook.com (2603:10b6:a03:d8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 07:53:44 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd%3]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 07:53:43 +0000
Message-ID: <64c55bd4-5792-7222-9724-68ae62d0e98e@amd.com>
Date:   Wed, 24 Aug 2022 13:23:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2] perf: Rewrite core context handling
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdNKJllCVMci3ov@hirez.programming.kicks-ass.net>
 <aab04cfb-2dd5-89dc-213d-7fa253615864@amd.com>
 <YwSWhXW+BUA3WkIE@worktop.programming.kicks-ass.net>
 <cf2cdf28-8678-8e61-9992-a460e61d3ce2@amd.com>
 <YwXSyWE9BqTwi5aL@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YwXSyWE9BqTwi5aL@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::29) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5424b8b6-4642-414e-0387-08da85a5c433
X-MS-TrafficTypeDiagnostic: BYAPR12MB3031:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 942e85FbON13kFEflBjRVRVx1Oca+8W+FnB4ofYtpqPPbVViRtWEi5I6s3H/AqHtYq/g0QaABBfC7RfZqjet/gfsS7nXaJJh3i3vcddIkaZhBSRdl2fdrotHo2p0cDhKDUAzFPwvC+0cULG6c084Jso95qPptSkcke1+lbzBPFfym0RcuQSx446HqNIxpPsciJdykBOQFcPBmz38CT1eH0KUvfoFNOPQ4vtKzerBLwPw6Pn3m0ZuBLmI1ZXG0xQoWrPsO6gUiwAXigWjox9lFmGNyDzoyrMo05EgALJOhnDovsV6mToJvZQVVHOJnAe9ZZ0iPsVu8WGkcLIk1twv+IkgjmgHTJ1FbgL6Tdah223XarmSV/4gq5f2PSJSwa55zCvAi3S6/Ou2sNvZUzeCa4Sd1vVG0/lYccrYDabRduy9mSSqUyWahqS04TXcKlCh7ThefWKat5Rpq1jdkU5hGEBw4nJE8+DN1UdpwilC6U22anRnTXGf0nIBGW/eOBs3y75PIEEfTPdk1sASxLrn9Rr2rptpOc1O6fwpJgRNGrsfD6JrLkQkjpiAY13tLUJq+ydXBBOGko7CDwTgOnRarcvM+5bqEIetGDiNlVhq4VeOoLjP/0lOtohL7ygKFJ/BbKOjQ3+pRau5eOoPxEBkzEjkggSEf+V+iqe6jiYocXwDUxIv8td6bJ4rrPp7dLCZpKJuwlm4XnhFUgnuD6XYYj6gqAnLWxyG1RfKH5/GRfE8BqrrJEgclNukwFlYVqxuuBrqZtaGtOvbSYJgxryJy19oWrQqiEoS7KXivFBxkSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(4326008)(8936002)(41300700001)(53546011)(6506007)(8676002)(66476007)(66946007)(66556008)(2616005)(31686004)(2906002)(4744005)(36756003)(44832011)(31696002)(478600001)(6916009)(5660300002)(7416002)(6486002)(186003)(38100700002)(6666004)(6512007)(86362001)(316002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJadWZWcW5SQzN1R3JZUlZyMEhXU2FjVHo3R0FWSGVYUjFQTXU0VEJ6OU1j?=
 =?utf-8?B?NUxDTWRKdXBWRGRCRkliTnlVc1ZINEswdW4wV1F2NkNoT3hmSWErTkc5Rnd0?=
 =?utf-8?B?R0RteGtQckM4SkI0TTZTRWlkUG9PMnFsTW5lWVloY25jZ1JIQUh6V2dobFJN?=
 =?utf-8?B?N2ZpKzZidEZkanVJL2NhZHJ5THZBeUhabFl2Q2JucU1CUmVyOFVHcStBSXpW?=
 =?utf-8?B?VFN1aFRaS2FzM084Q0RvaVhQVDF1cnA2dCs3YzJDSVJBVXl2NmdqMW8zdm5U?=
 =?utf-8?B?T0JEWm1hK3hYM3RSNW9sdjgyUjRCTmVDTTdjVSszM2RLb3V2bTA2ME1wczZy?=
 =?utf-8?B?b2gyWlJzVmlSV1ROMXZ5MFB5TTlwMVI3SHh3dkhaSEVzZnhHRytFYjQzaEFz?=
 =?utf-8?B?RkI1MDhZdW91MDVTeW42ZVZwakNmem0rYmQ4OVhyNlMvb0RnY0pMRkVyVTF4?=
 =?utf-8?B?QzRFZDd1Z1kxWUtjc292SEpRSXpwU1R2WkxTQmNCRXp1Vm5ramZLSUhwM3Zz?=
 =?utf-8?B?OWM0cHhPOWhCcERPQ25nUGRqcE1PYkZtSkxXdTFQTzVVUVk3cGo3V1Bjc2cy?=
 =?utf-8?B?V2p4OTZWSDdOaWhKZFVFQ3gxVGZ3RURaYkMvQnJxQ2xJWHNIbGs1OG16VGJt?=
 =?utf-8?B?SlV1dkhtNm5CejFrMTZ5TWJTWUVselphZmxIYXBaM0FhVW16VEFwMXdMOC9M?=
 =?utf-8?B?a21jUkZFVEpEZmk4RzcwdHljcjAxdEF0QWJTemFDeE1XSjRTUEI1UnVqaW1K?=
 =?utf-8?B?cjZUVTJBUGE4VXFrVkxiM2dNWlp5ejBKS0ZLbklTeU5iRUdTekkvUXgwZ2Js?=
 =?utf-8?B?bHdKdTVzbVpTWXlzMnlPZG1hVVF1Nm90cjh4K2ttNitJbU1mUXNNUStzR1V0?=
 =?utf-8?B?Z1cxSHc0NzRNS000ZUp2VDBDVU8ycWU0TkFDZWt2WnBRbUxjNjJtemJwNGJR?=
 =?utf-8?B?dmpBT0lmdTliUHdRRDlOak8vTXBZVWZlemlGaXl0QW9Zb2xHQVZaYmNjc09r?=
 =?utf-8?B?RTFiUU5XUE1zMmZLMW1rdndya1drbVVubHNyZmYxSVJ5eHoxd0hkVTJJaFIx?=
 =?utf-8?B?eUxtRzdYR2s4a042MllzRitHb1N2QkxWaHN4N3JNalJHMjlBU1RtY1I5dlFi?=
 =?utf-8?B?NGk3elI5Mjg2a0lKNTArUjQ4RlVGN0gxaU1rZ3VGTUgzeFcrNXlDRjVJWStv?=
 =?utf-8?B?TytVbkJmc3lpL3EydGNIdmlwMHhsNCtMNXlyd2ZvbjZtbVNqb3pQNEk4QkpK?=
 =?utf-8?B?eHZmWWVOTnIxMmp5OVV6MTlhZGJZNVUrdSs3ZEJHdytXYjVXOTJwb0NhOHFk?=
 =?utf-8?B?bFVBQ2ZPQ1BhYVlZTGxBRXZ4aFM4VFAvbkxPYWJLdlpPUVM3M1VpcC90eUw4?=
 =?utf-8?B?Z1ZsODVibUlyam1KenhaVFFQb3lBdGhUQmx4a1FOcktKZGVDMmRodHpxZm9m?=
 =?utf-8?B?aVhtUGxhTjZmRVRWQkFiWFFRTlU5b1IxSEJDYjRFcjcrUjdwanZWamNDRTVN?=
 =?utf-8?B?eUIwTjd1QTg1cE1MVjhJNk1wNWZWUEtQNzdwS1o3ZVFTNVZkcXFkS1h5cW1B?=
 =?utf-8?B?U0Q2aXNXdHN2aUg5MXN1STMzeGtHVjlmY1pKVUNiUFQ2VHlCdWlKSDh6Yzd6?=
 =?utf-8?B?S3ZDNWtOWU5MNkpkeGU2NmJCN3VrcWFOZXR6YWJCV3duVVBqQVo1ajFBZnk0?=
 =?utf-8?B?UHlXaDhUN1hCL1lnNmk5Z2p2QzVMMHlmSWkwZGhmL2o2M2RuWFlPSUpWUXlt?=
 =?utf-8?B?SzRQeUFIb0Y5TEZWaHllbmsycW4yOXltamdEQm1hT3FJc3JqMmYrZG1WZm5u?=
 =?utf-8?B?a0VKNXBJTGRqc2UrUFVDUTR1Z04ybkFXMnFHNU5wdC9KUHptSFBCaFZ0V1Zj?=
 =?utf-8?B?Z2RHbFNkQ3JQV3hRaU50azBGVFZYYnY1WEJodWs0WVdVcTVYUWlKUVg2UXNV?=
 =?utf-8?B?b0thMDE3QU9TWHp2WU1aSTBtc3l6QUZhNjNJaG1YQ2FiRjFHRTZqNTJxN3J4?=
 =?utf-8?B?Mldvam82bFZlWHFZTGZtZi9ZcGlUNCtPb3BiVGNUMENTMmNmQVprRWdJY3Uy?=
 =?utf-8?B?dFora200dUNiVGN2MWovTnlndXZheVFDTDdmVlV6S2xBUzM1RDZzWUJzU2RG?=
 =?utf-8?Q?Ta9oUvxVU1pC4nbHRp+bXZOAQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5424b8b6-4642-414e-0387-08da85a5c433
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 07:53:43.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVTWPv504Cg0ac7rWwkXJFjdRtrKqJ/VA6kjnC/+H0T+az/5BkaczbXv1kbmQBcZEopIjk8Yw7R9t6OIOtXwdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Aug-22 12:57 PM, Peter Zijlstra wrote:
> On Wed, Aug 24, 2022 at 10:37:36AM +0530, Ravi Bangoria wrote:
> 
>>> Now, I suppose making that:
>>>
>>>   {-1, NULL, NULL}, {cpu, NULL, NULL}
>>>
>>> could work, but wouldn't iterating the the tree be more expensive than
>>> just finding the sub-trees as we do now?
>>
>> pmu=NULL can be used while scheduling entire context. We can just traverse
>> through all pmu events of both cpu subtrees.
> 
> But imagine the case where we have 50 event for a PMU that can only
> schedule 8. Then we have to iterate 42 events for naught instead of
> directly jumping to the next PMU.

Yes, that needs to be handled. And, IIRC, you proposed maintaining a list
of leftmost event from each pmu subtree.

Thanks,
Ravi
