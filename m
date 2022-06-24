Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70885558F75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiFXEFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFXEFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:05:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6756392
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li8ygfnIm6MqTB6Fup5b9m61jeMJWKWEZkbbnjGahhMK6OanxNGyWG8ZGuv3gLInWz45OmjZUl/xYLK3hpPww3NX2S2VyImwwPVK78pEOggpYs6zYIOv54deneIY5S8RSE54D0W4XOhne2mZXqfztWUbYDInd836GvZqeQbElRtkA/9kJMHl14qaYtsyCyPfK8DzvbeT/jsnUM4/Goc1/3leaqx5BOUv+bsLnzFaqyeniXKJAzZJfsMpcHKwQGgNrC5MeDUJvM5TxOkGupY740tkfCegdUP2Y25BBY4UlnciX+GDSnyngMaQKlrHdOAGTI85pb9T9+AGxkiHJGTq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW1M3a4/5c0hUUgnIM9qf5V+7Cpe22O+jH7m05iTPcU=;
 b=YQxFERTuccRSJI2KiQxI16RSMYEAVTeIQyFYoFLTcLuEWlvkog+hl4xHWQsXnEHY7glrOH6kaTa6rVN6PmxbhGWGLc76ZKjQs9QcT4Z7XH5vWsltBsV398yhIhNROm9XQ8Hvq4rhy6Zrdytqn5MWTigM/Zy8RhzmS0owbuC5oujj+czQaKAMJoCm+KpRnsNmnmtjGv+bMhDdDHWkOBTmATaZHQLV1J0FqWncgS/xsbGKRkmmz9hRfp8K6uS0+ua6v/YaQWIMF2yXreOsmWKzc0gyvLn8XD4iiNHdqb4/rHuab+W9I9O9WT1J6ErdxO03BGHLN+pDDa9DpDbcJSMLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW1M3a4/5c0hUUgnIM9qf5V+7Cpe22O+jH7m05iTPcU=;
 b=hadJzjubnh11nTy9zjjsajBaeTq7IvpAWcWPSabbiYz7keO6K3BjZZEQx9yaWQyIs11lJFpkRMHieejUUpwvLZVYwavuuFjCJyPyDz+cZd9cMWH9DzyvFgWFYBLe94iwHTF1iJnp6zvc3vE2ip+TFpHle/v+c0l+nQDZJ4ADoYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (52.132.180.152) by
 DM6PR12MB4515.namprd12.prod.outlook.com (20.180.252.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.16; Fri, 24 Jun 2022 04:05:02 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::bc2c:1f18:f03d:895b]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::bc2c:1f18:f03d:895b%7]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 04:04:59 +0000
Message-ID: <4027cf04-d39e-d8fd-b3af-c1873757bb39@amd.com>
Date:   Fri, 24 Jun 2022 09:34:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>
References: <20220612163428.849378-1-yu.c.chen@intel.com>
 <76c94a3b-6ca2-e0e2-c618-42b147d2737d@amd.com>
 <20220624020723.GA11803@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220624020723.GA11803@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4378e6f5-61f9-4b96-3be1-08da5596b4bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiukJfJMGOivR+XOwjkSc1+GIthC5bX+0fNKSjBmYHqd+jXFJF4MTsVkob4on7T39Jc41feK5ovaSc7HWCAyTfQDBWUJaBdxnF0Lv5C01YifIkI6UVYUZcZiV9uASEuJYP3/N/pCbRZ/blM+XtIpHVymEY9Ie21YyRVPjJRP8vtmixFSNcGxE0BxAiJAhQYX15ZCVMzaG/I/Mm02GBYAdMNDC35pXxYH0tXgT/Txc/eXmMtijKqRxvbi4LgLtlr4RltEBGV1Yb/WSJbktHE7GpAG0B7cR5ShIsPKlBCrxp7qAzbTntSsAY3L0y1OewgZN+qtl0Dso0St1Lmd9TLaUzp5tlIstjtijB1jeNAhw3YziBGSI1fEF/HWVbyFEhvhiLu/B4YMERjdkQsSg9AQdLxl+qKyn5wXu+oozs6TatMGJEGbsgooMLVibz8WEfiybrEmhMQVfYwMnEzmUvy+Nq2F5QXBVF2QS/HmMnsvlH/EuyUlNVtyBO19L1WLOq4pEdui7P6AqbqktaPzdkw5mYQg3+5BPos9/8nccEKaTSBmaeuXiG6Zw/eIBKjjBgiYSSoJdzV4XJP0EjU4VQwnUfMNPcpWv9P8tBZq4TW123Bo+pIowBxNcK1XaeWBTeIXI24S+n2NwpmutSmetPOBUnr/MtqfDZogXJ7tXP7sJFTKKYSfOBb+ioc7BQaNKmBs8unbLesWvHIcyn81+QyTkpHlpR4qD3mlBYKd/oD1EQjk/bJLSniJanTZXutr0rshcx1lXfR7Q59Vy3YU7PmP1eS7WLbDYWjnbBMHmJC7C2qcr7LrjKNrzzl+wa/inJQZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(83380400001)(6512007)(41300700001)(26005)(2906002)(31696002)(6506007)(53546011)(6666004)(5660300002)(478600001)(2616005)(86362001)(4744005)(6486002)(186003)(66946007)(316002)(7416002)(8676002)(8936002)(38100700002)(36756003)(6916009)(54906003)(4326008)(66476007)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZXY01GTFVEVWtYcTdGVU9VeDZlRld1U2dSSDQ5ckJzcUJtUjRWQ0pkV2xn?=
 =?utf-8?B?a2lBWEd6RVZmdHl2WmhlQnQya2J1amUvVjJLbmt3QlNvTGdMY0xndm9ORXlK?=
 =?utf-8?B?WGlRcXZ5TWtqZVhtNFc4N0k0aWRWZy9OYjg1SmJsQStGU2N0Q3VZTkdyUU5L?=
 =?utf-8?B?NW9Tbi80VURROXZKWVNhbjdsOGIvcGpLc2Y2VjQvaGp0UGxnYXZBNS93VXI3?=
 =?utf-8?B?Rkd5elVqT2FHeXZXeHpWUDZHK1o4L2s3OWgzOFZlL3d3VUREaHh1bjhDSUJ4?=
 =?utf-8?B?cFc4bUdvd254cU9URUtoamh6cWxoUm41bkNBYlMyR2FBdGJhRjUxbDN6WjNS?=
 =?utf-8?B?cEtMYWxvUStYb3FYa0xOd2ZKNjF6bk5sSGwwZUtKTTcxcksvQzVRMnVaSmxU?=
 =?utf-8?B?aHZ6MHh2TGlEZllrOFltdVJkamxsYks4MFRVTW9WQ3NsSHZ3QTZaM2JEcE82?=
 =?utf-8?B?YW1OQXNOdUFtcmVoV1hWNGhpLzZLRGIwcGF3eFA0M1hodHkxQTV6VWw5K3Q0?=
 =?utf-8?B?TnlkRTNZMjlkUnJrRGVMNXpIZEVFUXhMUXdLY2JRRHViQmpWd1lMWGo5cDdq?=
 =?utf-8?B?ck1jN3VzL1RxVGtZeFVzMzZVdXlVM2tHWG0wcElYZUhYUlhuR09qZjZ0bEl1?=
 =?utf-8?B?LzlBeC9lajVPTU96dDdxOSs3eVBRUlhpb1pHZklYV1FNZUUxUFlOTFI3OVBF?=
 =?utf-8?B?OGliMmxqS3VMTHRDYitUcTg4U0VUSHpFZjd6dkJtNVU4MG4zSU44TGxwNTBt?=
 =?utf-8?B?N2hrYjFoSzdKTXQxVVUzM1NMRWVDaTlnQnZUYUNqZEdpTzF1K0Fja1pzZWQr?=
 =?utf-8?B?UWZ6RTNlY2UwYU01WmhEdktmQVVORWJxdFFKRUhCTjQ2TnBZa1BXUm16QU52?=
 =?utf-8?B?SVFDaVVkRHV3M1VIRkRvdG5NNnIybzhOK3RtOGpod2RTYVltUnVMWW4wUzFu?=
 =?utf-8?B?MFhQRE5EV0ZMdDlXMStEQTJ5ZWd6MXFpS1hnYXpGVFVuNmJZZzQzSFJjM2xh?=
 =?utf-8?B?RnFLQnVESGtGck1GYXJ5cUxWZU42SnIydUhlRG1QM3o5YU5aV0s1dUpKZ2Fo?=
 =?utf-8?B?WmdRUUhxNFhDUENBNUtaQnV6M3N3K012dTVwTWRTclZmTTlrRnp5WmlnWEk1?=
 =?utf-8?B?YWRWd0F3dHBsaTk4MHJ1b0s2d1dXM05xb3ZDbUNsZy81NFUzZmNIdW5BUGxw?=
 =?utf-8?B?MFlMdTB5MWNhZ1U3RCtKNlgrTXA0dnZKZ2NCTlNzT29NbzVwNjVBNStqd2ZO?=
 =?utf-8?B?QUdlVjUrYndFU3BqdkN1V0cyVU92RnBlbmpzaEVEcTR5UWdyME5ubms1NkpM?=
 =?utf-8?B?TXJLa0FJS0ZUN2dIdVVpMDVUMmRBUjArdmZyak0rbkNQcnIxTDJnL1hJUVdW?=
 =?utf-8?B?NENPd085RTY0cEsyTUd4L3dCbzJReG12b05veFVuN1BhZ2U0QmtobTE2Um9r?=
 =?utf-8?B?aDFtenZ4SHFYUzZveXN3b2k5K2JCWUhFSGdoc3E0OGVpVkFVQ0ZNc1dXZTFM?=
 =?utf-8?B?WnpWRkxEZG1JYmdVUHZ0VzMyZVBvMEV3WWZNbUlicWlwMHNCdU9oZHpIVHhO?=
 =?utf-8?B?aE5pbE8wM1ZkR2U4aHpKZU1Tc1VZblNmYTJyMEp6b2U3cDQ0Sk9ualJjRzVV?=
 =?utf-8?B?bEw2NFdKbEJFWUhlVnd1S3ByWXl2eXh0anBRVCtOT3ZWdlhzaFF2RzRiWU5J?=
 =?utf-8?B?K3oxSldreFNuYjlJS3pZZ3h4Q3k0Mk1ISlpueXVGb1FOc21vUVNIYUdGVjgv?=
 =?utf-8?B?WHRCV1JjS1JoTW1VRjFyei9Sc2lUYWFxM1FMR055bzdqWkY3S3UxV3RRV0NI?=
 =?utf-8?B?WUhLQ0hMYWtEVDc0TzEvUnZuWHNnOVFQdVZvSTdVOFZoZWs2cUxyTUFtN1Jk?=
 =?utf-8?B?NlpZalhQRHcrTEhBL3lEOG5wb292aGNTK3RRSFhuRCtPZWFrYmFVLzJqd2R2?=
 =?utf-8?B?SFhpSlA3NVVaZkhKemZPdEp3ZE5SaWNlVktndCtkbTdGQm5jcTVkdThmcjZV?=
 =?utf-8?B?M2ptc1d1Rkh3TUYvdHhiVGhUR0lHSG5ZaDNVYWhtcGdkZDd6d3QzaFJMZkM4?=
 =?utf-8?B?OXZnQXRNbGJjc1B3OGs5QjJPVWM4Yjdxcm1INlRqNDBETzVSWEgxVGwxOWtM?=
 =?utf-8?Q?p3X0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4378e6f5-61f9-4b96-3be1-08da5596b4bd
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 04:04:59.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWPm473C5SH8KtaDMyRIDAxioPtT0IZiytm13FmiHfMlz4QyB+KZImLwkeKxGIqFvcG5qtQQDlmdWzj9vsRbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 6/24/2022 7:37 AM, Chen Yu wrote:

>
> [..snip..]>
>> With v4 on the current tip, I don't see any need for
>> a special case for systems with smaller LLCs with
>> SIS_PROP disabled and SIS_UITL enable. Even SIS Efficiency
>> seems to be better with SIS_UTIL for hackbench.
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Thanks again. Would you mind if I add this test report link into next patch
> version?

Sure.
I'm assuming the next version will disables SIS_PROP and only
keep SIS_UTIL enabled which is the same configuration we ran
during this round of testing. The results should stay the same :)
--
Thanks and Regards,
Prateek
