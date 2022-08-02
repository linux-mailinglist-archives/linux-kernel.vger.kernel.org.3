Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8831F587D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiHBNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiHBNlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:41:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B560D5;
        Tue,  2 Aug 2022 06:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKpHeq3RtYEeerK213PFNuiH0OQLeUtGT/kA773POrEhDLbgKe+RdDz/7tOc6E+HLSPzTq/1fWSDDLAAIYmFo0fnpcc3l/8/IrzmQ05szsDC91/MxAPNVLfLQXpJWk5l5cbeX3mkgeC2PKgQEVXus96nJ8A7ICtRohGJ4bJkhFm/6LLgolXNKdPIQD0nsTnDFwf0gbHNhOJ/v585Hf3ro7/0BDg0xuqqQzyF5NKbz/3Ut8YMcy5sKqlAi4a8oFzqEU0ljb9GFAaE98nbmsa0nDipoHz/2x6PYSQ5vE5sDc9sAMCtK4tZjhxTWTDeWZX6EBHJcvXi08bQp3x1D6GuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HKP7cqthpUO+aHGQX/TnOgHj0oCeCSYFIWhFne6xt4=;
 b=Kbcqpg6ortR7RXAlq/Iqynl1CCJTW4dqVvtcT9ycDcCNpZcGrnU39EvC0GCEBo9rac8kkK85uGuORPEPHc26gQj2AY+SAsifaf1QFSuwDZL534skiDVL9L/gxh1188m18s+4q6fEYm60rsp/3VT+8odZlUy/997rw/o3KYf4bw3cvauRBqr12V1sgRU57M/PQfZVxWT0wyQo5DTwFiWL4lN7i5mE0VXG8cHSjaP7cIPLp/ZjqJxG9QhLk48NcXMi7Ilu2++DfsJlMbKZmVbJstQUMWq7w1i+RQZODLblmCyb94KuqgNIiRB9KjSBfPSaQnhxgoR06/R+DDWlXrEZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HKP7cqthpUO+aHGQX/TnOgHj0oCeCSYFIWhFne6xt4=;
 b=Fa6vtsEHqiLyh9lDomg0iAXHkkv8Jd+JQLg8G90+J99UqNYZ6G/6NQGWX1lDwUxVwoe+SISVsABw/uEJXUwu7VMyG/9JJgs1T7eErfO54t+w0WzD7BWCWe0F8Xo2qq2laXXk2x65np8mO725/efTzMrygEDzVIWHVGG+qejwtPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY4PR12MB1574.namprd12.prod.outlook.com (2603:10b6:910:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 13:41:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3c71:7261:3f01:63a7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3c71:7261:3f01:63a7%6]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 13:41:38 +0000
Message-ID: <efee40d7-d2a4-959a-1eb4-3f949a575bf0@amd.com>
Date:   Tue, 2 Aug 2022 08:41:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/10] x86/resctrl: Support for AMD QoS new features
 and bug fix
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
 <13d16a59-0b13-8484-380c-21deb864f0f2@gmail.com> <Yujw0FOMj3tS0f3k@gmail.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Yujw0FOMj3tS0f3k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:c0::48) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6764f9a8-c5f2-4cfb-b152-08da748cb92b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1574:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk5hG78ElaZqko6226gyuEIVel8wg7FJVD8MDANXkbBCPN7A08IZUR6nUwLhBvnNj6V5Vx6v9oXba5mxMzO7Hw1Z86E8tL5C9cQD95YsgDBuoGB4jS0FKN5xm/XvD2KeCNDfB8wKNBVgEQpjHQYhtS7jXP1GvTE8pJ5CP1iRe1ZRWfFnzwmJ2DFhabba30144mdubgr5H34hpCHp9DsrgAk8/+Wkjn95VxRUufVWOyFt70MxcwnpRWNr+jutYbpCoIyf3d85r7A/bmEWuFko6sApScTxqcGt+NE9CfdB0+uOxkdZo60hpOc8CfSbZ3zi0QpIl6eBR3mw5NMnX+w5riGNCtuRSNlP9YAiXET9/j8NrFCMqt1N7xZGTTU0JfqBmKG9dT69FWanUdPRcaotQa7OVyE9GHobS5+TQdksBj9Q45rnGzgXxLOuQN95kF8XPi3N3qow/DxM01mA5yNk5FooK0U0SVGM6xgGQlYxAKxNJiRE9g+3pWW3EDbGBWb/lxwr0PLsBkBqa8noi20CDVSSQaTh7nP7nFmzXjmIPmmBwC+byJhO9WP2tev/DRX5F6WFUWD8ciWcLCI+jXmdTGnQdxVFtObmHudnL7327oB5aTXlIoT+PSzK+fc4x2yi7vu5Xd5PVgV2eep2U142Z4JNZb4Ss2Dvoo7EK21aXNQgxdjgQElZRUXP9PpUi5Mqx99iKYAzW/9MrkeJuwaM2TJ2DoGawfhu3gFtuFmT/nzhoyeBeOz9AjdNyJudKEHytlFxAj6lxnb+0Y4lO8YseaLP6wKZmDwvwAi8CWhQfdaNbEuaUXzS8WG95W7N24u55gfMefN2iO89UXJJwY0TAFvG6c2YHRztKDEki5pwOaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(45080400002)(6512007)(316002)(478600001)(31686004)(38100700002)(31696002)(26005)(186003)(110136005)(6666004)(6486002)(2616005)(8936002)(53546011)(36756003)(6506007)(41300700001)(966005)(8676002)(2906002)(3450700001)(4326008)(66946007)(66556008)(66476007)(86362001)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2V0R0xvSlJWSFlDeU04Ny90V3RYNndlN1NEY0NBbitNRXRFbWVTYjVkbFJR?=
 =?utf-8?B?VjJLWC8zeGR6eUJnWnUzRFNHcGd0Q2wvb0tzSEd1RC9wUlhtM1R5R1BsUlUx?=
 =?utf-8?B?R0psanVjSFZid3lhOFM4bHdOUGFpcUdCdlUwZDdwV1MxYUxQMHdhNjZTUWtz?=
 =?utf-8?B?TS93cnVGMEYrdXFFbnBTc2Y3d1VJbDJDUllIbm8xTWdDTnV4ZGUxaHpDVGNp?=
 =?utf-8?B?TDZkYmVZZEpMSU9MeDBMNXlRWUVkR1k2WXJrajIrVWVydXlKSEtSMmFhOXlr?=
 =?utf-8?B?ODUyUWJTTVdhWFMybDlhTnRZWVpUdmlHQzJPcHF0RURvbHFtZkVoK0pGYkZ2?=
 =?utf-8?B?M0d6STdVZjh0d0dvYUpzQXY3dTQ1dGt1REp0bTZ6bGQ4L1hWWW9xWVY5SHlC?=
 =?utf-8?B?TUpmT3ZXS04yZS83N0JJTmU1aS9nNk1pUzd4M3BQYzhCS2F1N04zWTNoakxm?=
 =?utf-8?B?Ny9MVEw3S0l6Z3ZZc3dMN054K1BxZVl5OVRMMlFHSmlvR2NiVmI5ZjFBcnVR?=
 =?utf-8?B?QWkzTDZaWnRDdm5lREE2VXhIUE5vRE04SlVoVTVVQ3ZxTldpSkN4RjhNc2Fw?=
 =?utf-8?B?R25YWW5rcWM3U0tIUjc3QmZ3K0lXMUdMSDJnaFZ1NU1yNkJwWFhFbUh6Nndm?=
 =?utf-8?B?VCs3SUVUbjBqVEYrTlNTWjd0SVZhaXlUOHVCY3phdG5ERGpCRUhzQUFBdnZK?=
 =?utf-8?B?NUpWTE1meTBsQldPV2NBTXJsUUpZUXBxcE9oT3F2WmtEZjJEa3hmYnhUem9Z?=
 =?utf-8?B?S283MWhzcGRidjZuN3V2YUNYdW5TaWJWMFd1OVYwTTZzR29tYzQvUDNITVk2?=
 =?utf-8?B?M1JXcEd6MWFWaUEwTWk3UVpZRVQyWUVGTmRsaDFJcit5Q0VGTERBTk5wRlhZ?=
 =?utf-8?B?aGZ6OXQvMWluTm5QQXFBa2xqQm9YZTNVYXo4TGdHaEJreWRNRDhLVGxRZzlo?=
 =?utf-8?B?amNjMUltdWdxZzF5SXU3NmxMQjgwTW01V2o3ak9MMHl3V3JjVVdMN1ZjOXYv?=
 =?utf-8?B?eGVEdHRmVzJrM3dLaG51c0d3Y1p6Wkc2UGg4eExqY3B4SEJudDFXUUt5SmJ2?=
 =?utf-8?B?T05WWkV6eUJreU9lSys2Tk5QN1hLYVRMd2s5bDNkcWlQZXk4ZUk4K013RE5q?=
 =?utf-8?B?VE9ndDh1MTFEK0FoMDVoNzEvNGpqNktKK1ZablJRY0xsOGpOaXplQ2xHNjJt?=
 =?utf-8?B?TitOclViVisyaTRJYWpLR2NZVzdyaUMyU3lwZWJvSEswUTFaNXpwQ2I0clNP?=
 =?utf-8?B?L2ZhblI3bHd6ZjFDNW00RWN1Qlp0Z012Ujk2NE1KWElTZ1BySkxkbU1zd0FJ?=
 =?utf-8?B?SWNGeXhldW5GN2tlMkNGWEZYR3IvYUxWTk9zZjY2MG1pR0JySWlXc0JTbFdM?=
 =?utf-8?B?eUpveUh2bXQzVlFuaVVkemdubCtOaU1BZmdHYi9NUWpxSGh2WXUrY3FwSzFD?=
 =?utf-8?B?WjVHL0UveURwckk3OERwZnlHL0pyczJjRHgzT3U1UGZ0MDhUZHdDWlFhckVr?=
 =?utf-8?B?R2hQb0dwZHljVTY5VjZtZ0xzT05OR2JnQXdtMkJsQzM0T0Q0SWZnSEQxOGEr?=
 =?utf-8?B?ZHg0d2RVRlVVSDl1MWR3d1NzYjlBK2czekJGN21EaVBMQVBxWWFZVzczZ29Y?=
 =?utf-8?B?UG5uS3U2RytnWnRaNS8xL1N6YTFwUmMvOHY0dkFmRTdVVEM2T0hqU2RtNVR2?=
 =?utf-8?B?Qkxsb0xMSkxCUExnKzNPYnVHbVBmWEVHcllBU1U1V0srYW1iMTQ1Tm1OR0t4?=
 =?utf-8?B?NDFwZCtRelE0NXZXWFhyQ1MxMk5xWVpSckVZdSs4b3Z6OTI0Zm5GQ0d0NG5h?=
 =?utf-8?B?VDhpNHpRUzF0dTY3L2Zrd05oOFRSczNlL0dhVHllWFlSWCsvMHc1VXdTQVhp?=
 =?utf-8?B?cjl1V3ppNUxNcXQwTE1mZjJvSUNHclpNbDJFRldDbkhET2hONVUrMDNuT0g1?=
 =?utf-8?B?MGpXVjVDcG9na1ppZElDZytJQ2VLVTEzZEVrS1RuMWQxV0Nva1gwWXZMdkJk?=
 =?utf-8?B?UzhNQWE2L2wvaHFGV1kxeWtEWDFiQVhxdEtTdktBU3hPRldIMVhWdVRYZ0ZV?=
 =?utf-8?B?aURmVkM5UW41bjhtUThvZi8xcEVaVUx5bjQ2RWcybzFzODB1eTBKWDJzYU5R?=
 =?utf-8?Q?Mp1o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6764f9a8-c5f2-4cfb-b152-08da748cb92b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 13:41:37.9595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLQiLKcy/KvQURU9Cu/wUzvvtBZJ60xTiTzgo72RwpDQdMPVRgGLnuKILArlRoAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/22 04:39, Ingo Molnar wrote:
> * Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
>> On 8/2/22 03:55, Babu Moger wrote:
>>> v2:
>>>   a. Rebased the patches to latest stable tree (v5.18.15). Resolved some conflicts.
>>>   b. Added the patch to fix CBM issue on AMD. This was originally discussed
>>>      https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220517001234.3137157-1-eranian%40google.com%2F&amp;data=05%7C01%7Cbabu.moger%40amd.com%7C90f7a070780f42fc9b5808da746ae74c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637950299744423989%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=tZNlIIolEGbVfZmbeADA%2BHjLE%2BPhNWKDfcHfL2cNUuE%3D&amp;reserved=0
>>>
>> Shouldn't this series be rebased on tip tree? I think it's odd to base 
Sure. Will re-base on top of tip next revision.
>> new feature series on stable tree, since patches on the latter are mostly 
>> bugfixes backported from mainline.
> Normally that's true, but AFAICS the patchset applies cleanly to latest 
> -tip as well, so 'stable == tip' in this regard.
>
> Series looks good to me (without having tested it):
>
>   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thank you.

Babu Moger

>
> Thanks,
>
> 	Ingo

-- 
Thanks
Babu Moger

