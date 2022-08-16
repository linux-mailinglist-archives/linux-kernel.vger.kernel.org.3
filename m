Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9C59565B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiHPJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiHPJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2101.outbound.protection.outlook.com [40.107.22.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656523FA3F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daU1TX1b8X4CGZUoAnYrR3FLD24qLDo8i/JnLaxCrhA6tGbICvNhBK/GqRwFYvdLrU4mMCLKxRUIPO4eNQc+D9YiFYkfp1dycZwEsUIhbfFFLvGtJ2fGMdD2XVwUFlwFRaRUhsI/dRIyUQk7PbTzXNCopw1fbHIOp7RaHvUBhjzdSjQM9KT5SHU5F4p9aJta/CNpCgA7JDMAsiv7clwOFViWkPWaaqM3LniEgPgV0/fB9jROqWE3LGdUHocelDT/czpI3xZPHnXTab13MOkrr3k/E0/MEQPVJzd9mn5AFjXmm5B9MB2w2vjY+YdeRtdSG/8ANa2TgdNklCCG84iI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXWUPq2Ar4AIXkZqFkFmQ3nJAI04CHQLZHCiqt/6c88=;
 b=RJzL2N5p10vMZ5LiqemEMBjuPxTmTfK2R41mV4LqBZdLqsCjUHNP0OKU5BjwfVezy+Y/bzYCcPhqDSQ0mhNsyuOAVUhoIKl8z8nFVR8GS49oKTyC0E4TEi+DKxmxuJ0o7kvCrdkR4LefVx8kjnEHW0CxmYDgBsZ7n3qV2QQx1Oht7QtKXN0x9ZaMkPuCye6VxALSqIdEwDKi/aD5SyYtRqcJSGLHyF+xYDMbI0UUqD4idy0+AFoQEZa4Hrk4wJROSG17L4Oz57z1/hwdOd4khVHtTiUOIvT4ptVHLLSGgCo435EmA+5LQPxzKNTyaVI465fr7wcgrhE2D2IMwDVv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXWUPq2Ar4AIXkZqFkFmQ3nJAI04CHQLZHCiqt/6c88=;
 b=gyYrFlDGDvM+LbFXfuKf7hebGJAEFgqLLlKxlXr4IkEd1dvvEkDG9ognz+fA2eaE8aqPKOXMiBo+lmd9di3RC1AonYmyNazWXfoaVBnPS8gpsbs3Pgb22kEtyOOV2qGs3iSPtYNXSVoK8kEairpB0spDy0G0T8quTHjMYp0H8hQGGZk7BhqB/4l8czYBhBe9aAYQitTEkCRkcCzDde8qT36VbiNX3R9UVSlfII4sP8BaK8onFuy2c/puKC+D0txD2waUfUdeVkM7SM+mEWlKBTcpT08+g+yOn8M8zvaQKCFF+qVtq0Q1EGTk5IPZ+h9GYQcAROMPy+AgEHRTYqe8Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AS8PR08MB7943.eurprd08.prod.outlook.com (2603:10a6:20b:53b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 07:50:09 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 07:50:09 +0000
Message-ID: <32f11326-4c20-56f9-3537-a8099cc3cc46@virtuozzo.com>
Date:   Tue, 16 Aug 2022 10:50:07 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v1 2/2] Drivers: virtio: balloon: Report inflated memory
To:     Nadav Amit <namit@vmware.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "kernel@openvz.org" <kernel@openvz.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
References: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <20220809095358.2203355-1-alexander.atanasov@virtuozzo.com>
 <83B75FC4-595D-496B-91EF-ECCE16D1E2CE@vmware.com>
 <93df4e05-30d7-8176-23a6-948c1bfe4225@virtuozzo.com>
 <F230BF95-0EA2-4A12-A21A-E967E07589FF@vmware.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <F230BF95-0EA2-4A12-A21A-E967E07589FF@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0210.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::34) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee5937b8-4407-4733-5456-08da7f5bf100
X-MS-TrafficTypeDiagnostic: AS8PR08MB7943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu2sTFd+oRrCkqqyD4J+s/5LYw4SnB+tTzYyNI82FCvtYps8NTN8/B3pOhGVHVGBwKvou/UNGnIoLD5OhayQw9kcwHi8ptY+HOcfsYqjaFZWivYO6x5HtHSBsvT60PmGdEs/wuEqaAC3BMuzhPehFPMRDrbT3kt9rsKJrdT/gxn7yWthZCpr5WTrVIYxag2lZ67ruOWEA8AzlUT9BZyM6pQO55GlbJRk+FiD7PPReiVUlrKVMPhB0zkf6MN9tepmOMeIhtHL4kULO9/BhnsjZZwePnkd+mnK6OAEZogO/1jBMoXSK/SKBClGd8R9UFsCVT0dvBiR0VTc4Nu6x+GhaHeGB92M4FcEjLO0c30uRbiNY+u8CnmGNR/b+PC8MP9GV7MHMZoTIUKiBQ0w642X0BWNGVgzjC6YAj/hyqU+CcMCpeiIIrgJ/rmZqBgb/oHK7Xeem31x4FE6hh4uZZX9ef/67WBYRwHigEWT+AGgH6fMBG/EKQ98gaOxhcKSI5fxJP12B0onH3QfuGeNpyO2TqTxM4N5LuPIOFIKsT6py0F05ECqFdWXg1Zx+5n9Vz+ggTsPJp8eXzhwnPbdtWKmVSFm1opH57MNjz14NxzlibkcFBTdgbWBIub0lFgsf1qKQRvzC6ZvdssYna2s4UowS/os3vTdIHODd09usW82f+r4ifRkwKI1nELWeFfGh9u7xTjgJVuj6KBo1Q07OpSBnUDbKqOVqWrHkg6g9SjWObnftAouWdAVHaa0Z8n6+JBtsZOWI8tRzO7exuF8MDTnZqenf2LedWoRQICXngBirDbimvR+AEp3L6AIFfVfaW5mmkvsY3kta/6AxscALXwJzhpo9qQ/GJDhMfia1Sc2l64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39850400004)(376002)(366004)(38350700002)(38100700002)(26005)(5660300002)(66476007)(6512007)(478600001)(6506007)(86362001)(52116002)(8936002)(6486002)(53546011)(41300700001)(8676002)(83380400001)(4326008)(2906002)(6916009)(44832011)(66946007)(66556008)(31696002)(316002)(31686004)(54906003)(2616005)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURUZ3pKOFRJbkplNUlnTHFjSWxEWURwMTRqc0JMLzRrTnYvbEpSUjdqMUVj?=
 =?utf-8?B?SXFQRnVSbnBjV09KUFNSSnZHc1VTcUFVQnpJWU5sMGp5SmdHL2kzNm5MNmRn?=
 =?utf-8?B?Q3RrcDY5cjNIL05IT01PVFJmOWl5a1Q2cW9tc2Y3YnNSZUdzTjBHMy9IVkly?=
 =?utf-8?B?b0YwblhZL0NvZkFTeDRiakx3dFIwT3Fodmwwa3VQdVhEVmROb2YwZ2hCR1Yy?=
 =?utf-8?B?ZW81cUxVOXhNWFMwbFI2UENaNlJiVmNlSDhvby9nNFRlNWhaNWxUMnZyTXlk?=
 =?utf-8?B?Mmo4WkZCWnRESlp0TVJIK1FNTEo2R1dBVmNZVTlLbWRVSklubHNHL05CY0Zw?=
 =?utf-8?B?cVVQckZzWXF5R3VSOUVqUXBHZGYwdjdlV01ONS95OERWQjhlbXM1c3lUanRQ?=
 =?utf-8?B?NVkxVXc4SmJPMzVqcDVvL0w0QkFvVmlYNDIvMXZnejh4VGp6V0d6U2RCVmF5?=
 =?utf-8?B?UGlIYjhUOGduU3YvR2daZjgwNFdxbG81Y25IRDdTYlRoN1poU1FtU0F6VTVy?=
 =?utf-8?B?N2VNUXJ1Kzg2eHY4VERJMTlvNk1PVVZjWSs5ZlB3QXFyVklTem45YjZqN3k2?=
 =?utf-8?B?N1ZRYkk5ak84UzY3a1hGMWtIRzZ1b0xzZjBYYzlyMks3cjZWUm5weE14emgv?=
 =?utf-8?B?SFVNTHdvNFFvd1FXdlovSWkzR0xxNjF4NE1xazJPLzdRN3NQcTFsRnBGSDQr?=
 =?utf-8?B?Rzc0TUQ5MVdoQ0VsOWJWUVpVRENmTEhSWjhuZ3M3aTkxSGMzRU80aEpFbVJr?=
 =?utf-8?B?bU9WSjRCTENaU0hDVWhOaksyWTNmbGxDZ0wyNEc4dHVxclU1KzBvNng2bjJa?=
 =?utf-8?B?QSs2TVZuaC9UZy9YT2dtYkg4WER1bldSK1hoQUhuSlRJbGZwZ0hJNzhkUHhq?=
 =?utf-8?B?YkZtVXIxak1FMHFrQkF0c2FBOEZtZitDakJtRjEzZktrRWdGVEpoVGY0T05u?=
 =?utf-8?B?enh3TERFNi9lakI1ZUp1VjN5cC9rTm9PRjh4NU9lTXN5V0RMOE1yZXUxSzJG?=
 =?utf-8?B?Z1V6cFFyQnIrUmlUdk1FSXlzTEFUaUl3akd4RnJqRzlBS1ZKTTJtTnRkUEdF?=
 =?utf-8?B?QUxORXcydGoxUGVYZkVaRUNMNk9uNXhpNXFJNFEwM01sa0VMWWNNdXQ2aitW?=
 =?utf-8?B?c1JQdThTaWliY2NvaTlBVGpSMklsbDd5TG5sbzdqWHpDWXd4T2lpaTFjbzI5?=
 =?utf-8?B?VU5iMUFrV1Y3QWdjVjh5QlhCZDVrMTJuRmRVdnB3ZHFISHNFbmpRUEpJREpa?=
 =?utf-8?B?TFdBdWZwVEFiRThSa2s0Qm1GcnBDeUNXeXBKZDVoM0U3SHhVdkN3RDNMRWp3?=
 =?utf-8?B?MHg0eWZmOXp2UE5SSG1IWTFpNUNOWnJKY0o0RVhDRzhweVRJZmMyRTJUaHpX?=
 =?utf-8?B?Z28rUHJBaTNuR0Y0NUs2MFBiVUE4TVJEWEdDMk1YWWtsUmoybnBEVlh6V2w3?=
 =?utf-8?B?L2FrK1hGd3Z6U3d4WVV4OWQva1pTZDV5akJoalFHeUxmbVl0LzRWTWRPR1Vm?=
 =?utf-8?B?Nk1idmUxUW05YjhJMjhZR3B4QVZNcnJON3VUTG5uVnh4Q09WblJvS3dZM1VX?=
 =?utf-8?B?aUFRVHRXMVYranphOW14eTZKd2ZQQ2pPZXhzaUFrNm1WZWN1enE4d3NSbEZP?=
 =?utf-8?B?SDZTTFlkRUFCMjJFRjhlSWNCRDdTVVRnZWFGNDlleDMzdm9WWVdnUTRQV3Mv?=
 =?utf-8?B?RG9hNXdFbGxwckszcS9MMHoxeW1ueUw0Z01oQlkxdGU3OW8yc0NnVHpnSVFy?=
 =?utf-8?B?dG1BL2Q4RVJFOGVmSTgydFd5cVNXem8zMTI2T3NVazZvNzF2MGtnd0JNTlFq?=
 =?utf-8?B?RVlkOE5rS1A5UGM5SFZiSWhveVNYUEQySUg2S3ViVk5NYk04SVZodjJzVjMx?=
 =?utf-8?B?UC9YVzBUa3AxcEZYT3ZnaXFTM2tEZkJTd2ZVaXBOaFIyWUR0bGhKazJKSU5L?=
 =?utf-8?B?TjdnYXg2NDZiaGpIQXZYNXZVUGZKUWFQV1doSEIycFovYnNoQlU4MktsNUJt?=
 =?utf-8?B?TitEZzgyQ3E4cEdka1BLVEx1aENlUUJmQzlpK1lkK0pwQWFEY0hSdkZIcWdW?=
 =?utf-8?B?dzJRS2FrbEVvcVpqZ3BrdXR5SWdCWFg1UFh0dWY5bFU5Y0lRVmdJRERucGJj?=
 =?utf-8?B?am4valNDY1h5RzRrT0lKOGw0M1ZKelpzWW9TY2Nzb2FrUG5mTXJNZGpQZ0VK?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5937b8-4407-4733-5456-08da7f5bf100
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 07:50:08.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ym5BlLcbnPg8bnMRa2nc6DmrKCwhRL9WT89at6zZ7zrGrhsTLlS2l+9tBXOd2Knf5SBugtuShS2CgnNFWWlp2drDuYbKebypUZTnASLqFGy9/CiObEYYlzL9NkGXSLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.22 19:05, Nadav Amit wrote:
> On Aug 15, 2022, at 5:52 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>> If it is going to be a place for generic logic may be it should be
>> renamed to balloon_common.[ch] ?
>>
>>> as possible. I made the effort to reuse this infrastructure (which is now
>>> used by both VMware and virtio), and would prefer to share as much code as
>>> possible.
>>>
>>> For instance, I would appreciate if the update upon inflate would go into
>>> balloon_page_list_enqueue() and balloon_page_enqueue(). VMware's 2MB pages
>>> logic is not shared, so it would require a change that is specific for
>>> VMware code.
>>
>> I looked at the code and i do not see how i can reuse it since
>> BALLOON_COMPACTION can be disabled and as you say even for VMWare it
>> would require updates on other places. Looks like if i do so i would
>> have to handle update from each driver for both cases. I think it is
>> better to clearly mark the spots when drivers do their internal
>> recalculations and report to the core. I see only VMWare is using
>> balloon_page_list_enqueue , virtio balloon is using only migration and
>> i don't see how to hook it there - i haven't checked the rest of the
>> balloons but i guess it would be similiar . I agree it is a good to have
>> a common place for such logic but it might be better of for a separate
>> work in the future.
> 
> Fine. I would live with whatever you do and if needed change it later.


- balloon_page_list_enqueue and balloon_page_enqueue are called under locks.
- they work page by page
- different page sizes different hypervisors
- pages to bytes conversion again different page sizes

I will put the new code in balloon_common but i can not reuse what you 
propose for the reasons above.

-- 
Regards,
Alexander Atanasov

