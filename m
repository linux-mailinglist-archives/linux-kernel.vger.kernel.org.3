Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82470527FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbiEPIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiEPIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:34:49 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20093.outbound.protection.outlook.com [40.107.2.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB00E0A4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDvRKJ4x/XoOkNWOs1bdyMT+AZtBTNjiwOIGvr8TnPHfQ4md0Oo5bQUCCYqsalUChZf8xej1kXjxzJbJ1BoKJl84S3UgIqhi+zzcuFrqLBJQmaKxaCMUCGrfcb1CkR6bvU4VyL4l0nvJ8t9YN66vstJm9tPQZ2J+gc+2J0IK4CHoDZE2ZDjPllhwV01bgsChAcFAkUe/a0UvlCpZ9BMRc4gmRiwYcPIEixfwHUo+L7bRhjiuO3zo0cOEeTBGse0O3CTiT+y4jE7FJocS6p8CARfv4kmcpEnY9x16PlhjJzzRa7x1uU9IqbJHSWQIVy2+qKDmV0vHDpCWtvmSv8cFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VieIhbOY4sZ3YesmJb9Y4OMhk8nzEsJgG1HxgC4we9M=;
 b=nU/ZMjgmUUT92OQvF5yA2Ic5/fk0Al2Rv8osT3VBnayShYYfwwQYpCmPFnINUHOfZN/K58t+6IRgmCxnOkkRC5LivQSoYpWXENKI6Hhw/t3aT9g4tcvBe/JCBWje9hEbcKFOULrsq5cw+WnZDb8PK2z1NfKmzhlCI19+/74Ws3kF4cW+DkwpXX8by8u+fz0E1BcXeytod1sStBz9jjaQNLWl86wehLh6aFnDvYDU9zG176IE9hzW8zNsCgKcaQQyX905zIgfuyl7CoPvY+AV9gPSIE5UO3Srdlc1yKjLzcHXOmdoU4zinmWy4uQ9Te2UzSZbpyFo7FTieZD3+hovwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VieIhbOY4sZ3YesmJb9Y4OMhk8nzEsJgG1HxgC4we9M=;
 b=Y8U/Ipn+BR05CFoEksoCpAVF+W2qGBnIRkVrwz2RM/FzBSvRz4goMl+0Li8w9JILI6QMYKZEz88wK/KUd0YvR3h3x8lzokC9Bc5pMjgD4wih08CTNQuky2gJeJcDFw3f0q5nvxKX0S2+Dp4Gywx42JXfOVbh/apJzijm9yCRMxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by PR3PR10MB4048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 08:34:43 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7d61:b91a:e773:4e]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7d61:b91a:e773:4e%4]) with mapi id 15.20.5250.017; Mon, 16 May 2022
 08:34:42 +0000
Message-ID: <2c6f00f4-e8c2-3ffd-fead-cbc2b6e8f88a@prevas.dk>
Date:   Mon, 16 May 2022 10:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, gcc <gcc@gcc.gnu.org>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <eaf82e8001a370d7be779bd15163f7210a968e8b.camel@perches.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <eaf82e8001a370d7be779bd15163f7210a968e8b.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0087.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::28) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b41b2fa-d8f9-4d42-e7db-08da3716ec57
X-MS-TrafficTypeDiagnostic: PR3PR10MB4048:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB404812F64AC83DED718C1F6793CF9@PR3PR10MB4048.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jr/9K1wo8j+Yrar+A5NfCj3/jmz3v8CcMo58nTLbCDM628Phhi+cMtsrL44IZdUuoDWt1/k4IjbuUCEXo0PhBwNa+3QEK1X1dQBBxnx+KEVhAoWc+DUgc39NtGJFGuBaaljziY9tgaIU2mYEZ4f06n7XQUjfiu6zJBe8/55qcjL+PBRC3SbgtCMZnErtW4dT2PiJgmsiZP80eD+PONo0CPRkOjeIGtE/tFIxZecotM3oFZTjSkiDJQvTl/DGZ5KD+v6cw8MdLnkcnfh2gg+aZj2p9XneP9lN8PvBT4jEU4huq6zE50VjOGqs2pZMjxPD0XE7usRt4GclIUJc5X8DMnv1gDdDwU2Pe/Q3bPbQv95yTxyuJD/WSzIil/XUPLUtB/5Tb5wvsQY3sA0vrpkdGWk6h06pJOvrBpJ3bWFozPl6TQ/Jpmiw2mme9urJBtH4w0cvbCn4fzEMqfuB9kIkMfGk8QyBHgdnJ8SEzQVWBXnoxuOyCAh6qpV6kW5NBFj88SP0I0cZrzzgu6deUewLGICD/ol9kEDkvcjQDfzcLkuQfS/KgSyDnPE9EIs3YfsBM5bhapYa7ATP9zMwtJvw42bVVjVbqwWs7mKY9fYgVjYmcgsP0wRrBY4UwU9xWYTTCFJO0+7GT9pgON1/54yY+2LrUp8V4JWkY796PlOCYWs4dSE8KWM5Yf3SXqPPqkV+7r9EeSKHdkq12zv3tCP5tEcHHct4VJFMygp1aO612GK72jH3VvLkAXHhL4wmj7cKXiozRpq8C4CfgpZkGG8ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(8976002)(8936002)(38350700002)(54906003)(5660300002)(6506007)(36756003)(4744005)(31686004)(26005)(6512007)(2616005)(186003)(110136005)(316002)(2906002)(38100700002)(31696002)(4326008)(44832011)(86362001)(66946007)(83380400001)(66476007)(52116002)(508600001)(66556008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJRYUVFNFJVRnVoM2Z2d0FSdTFGWWp6c0liMUtTSm1Tanlrc2JTakQwV0t4?=
 =?utf-8?B?VjExak44VmhmVUVrUTJWdndzaGltNURkNnpVcU8rYjVqSjdYSk1wOVRNdXZ0?=
 =?utf-8?B?QzMrWGJ1NzVlUGsvRmlhNm9tRHd4dnpRRmFIZnlxbFFVZzdrTFRvaGNkMzhU?=
 =?utf-8?B?Q21uUmFFc25jMGNWTnd0ZVdLNjlldTI2TUlsRjlzYmlXemVFdTV2TkVKZ21h?=
 =?utf-8?B?YmRDYWVMbGRaaWw2Z1cxempCakFxSUtxYVBXYTdWcnNGQ0I1NlFwREVrYnUy?=
 =?utf-8?B?Tk12T0Q0ZkxibUZxZVMxY0NsZHErVkNUL3hlTGZrTHlIcUhCWEcyWEkxVURm?=
 =?utf-8?B?T3d1blBzUTJkcUhqN2FrRlpWSmVHYm5MYnRPRFZaV2hnVEliaWJncEczTyt2?=
 =?utf-8?B?alZZOHYzaEtOd050UVI1Sk4wVTRtK25ud01TQWtBcmtPNUx1T29tQnp1eTFK?=
 =?utf-8?B?WlFPblpURDZzZTZvTVZveVRDeFlYbXRwOHYxR3d2ZnM3RjlDRFhadS9RZnhv?=
 =?utf-8?B?dlhiczdNYlE4UHFJczNXalJVYU9LbEc5Z2h0RWNXSk1xdGhqTGpKcWY0cDRW?=
 =?utf-8?B?dlB6amI4VTlrMnZkNlpHRzBtYzNCWVE5bG5uQ3VDcVc5TzF1cUZPVjdEZWo0?=
 =?utf-8?B?b2tzd2hPVUZrUnNQd0phbHFJK1dydngwQVFBaWx5aWFZbzVKZjc1M0EyYnI2?=
 =?utf-8?B?RXNNMVc1QW1lY3NuNUw3dVBBMWJkSTRROVJlbnhvQ0Y1NlZNSllzSjRJa2ls?=
 =?utf-8?B?VW1WUzVzbllldkpkSnFOVE55SmxFbnk5UWxvWFhuSUNzZzhrVDJkblZWUnY2?=
 =?utf-8?B?OVU4czA2TXJxcXcyK1Q2dUVwZHVvQ1RrUlFxNGhtSTBGTFBwTXBvZldOdmNG?=
 =?utf-8?B?VGpveGNXZllEeVJkRlFYQTQvN1JwVk9maG9pR3BvaVBrZ3Q1Rm9QY0FidWhh?=
 =?utf-8?B?Nkx4cHJjVFNNa1RQTnNuU0tVY2dxS3E4d0xUTTBZSXl2MkxweWFabS9yZG5H?=
 =?utf-8?B?NXNDcmN4UFlHZjdzdVhSaHpBWGR4ZU5MY2RiWGc2MlFWeE9TSVNnQUYyYTNp?=
 =?utf-8?B?SnpsektnT1Q1UjVsT29iZCtxMUVXODNyZnBnMEZvNS9HRHBwTXhRalkyUEp2?=
 =?utf-8?B?R0owcHpKdFl3RUxzNklveE1HaDlQdU9mSHFjT09ML21ldEExTGJ1VjRYZVI1?=
 =?utf-8?B?Z3dJWC90Rmx2MUN0SHVDdDAxempXU1dpMWpXOC9XMmVieEQ0WDVaRUp1TUFo?=
 =?utf-8?B?aG1ZN1VPbFFYcnpWclZVbzQvV2dtYVMyb2tTYkMvUVVpQUIxWTJQUkxrYjlK?=
 =?utf-8?B?VEMxU2FsSzhHRFBkUUJPanFrZzU4VlFRNElFUCtFWXZrMUV2YUlRQTUyeDVH?=
 =?utf-8?B?TVN1bVVPZk5PUTdTZk1ZUXF2ckNLbHhZVFpnbUQzZnNXRndjbGwzbWgxOVVM?=
 =?utf-8?B?TWcwZE5ZL0QvQXYySTNPUUM0cFpjQWJKMy9ZYzhxQU1mcFJ0cWVSZVNLaXY3?=
 =?utf-8?B?clR2ZG5qUjY2akJmcXd5OFd6NnpKZm1xVCtxZjlXY2g5Nk9nVEd6WUFXYjJN?=
 =?utf-8?B?YkVpd2QwYUF1cVJmSytJcUNveGw4RHBGT1UwUVR2M0cwM0EzU0hxaHIxWVhz?=
 =?utf-8?B?YkJGbDk3b00zWDR1OG91eldFYVVOOGNXaXlJYzB5TWtKOEhjZjk1aTJ2MWh0?=
 =?utf-8?B?bDJYNk5qZ255anNEdktPdEpWWFl4Yi91aUdDbmdwb0tCMDFKWWRHeUZlcVdj?=
 =?utf-8?B?WHRQemtSSVBpMHZjdWJibktIdkI2ZklsZXBsUytqSktOeFpCT2Mwc2w4MFBM?=
 =?utf-8?B?endrR0lVeUFwTDV4cnJJRnZiQzlhN20zcmpTSG43amc4Nlc3S3BRWWFhdUMy?=
 =?utf-8?B?SzFLRUVrQWU5NnF0a2RGRXFRNGV4UW95dG5jMEhCM3dHUGxFbFZjdEp6S0pL?=
 =?utf-8?B?U2hGVkpWQXd2Y3JwL2FHVzVQYVdMb1lmeFlZbTZrTk1weU9FUkZ4NDh2TFQx?=
 =?utf-8?B?ZDBTbEtlMStVdUZnNEM3YWQ4alh2WmkxbElQRmFaY0dUaFJRaWhMa0c3MmxN?=
 =?utf-8?B?T3FIL282ektlRDhiZzhXZ1RKbFkyTU5yOFJ5dENYTDRyOTdUcEVWYWRGMjNJ?=
 =?utf-8?B?THYvSTVtaHZtbGg1Zjdyd2tOYlcvQlZ2QkFsSW54cExIY1VYOFF4Ujc5YWtw?=
 =?utf-8?B?RkNaZjhudEtFVDJoYmVnV0ltendJSU10L1FtZHFKNk5mVTVnTUVBWnZMNGNy?=
 =?utf-8?B?Z2xLTGJYTmdWVWpqcHdlSEtzQzZ2L21VSEk4aTlFY0xoc3BrR293OU5HRjh6?=
 =?utf-8?B?R0R4ckRQVlR2ejVlUWU4VjZyVzI1YlZwMzdIVm5lZzZuaTJKWTdlbjFNejFa?=
 =?utf-8?Q?qrZHIKn5jihDT+gY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b41b2fa-d8f9-4d42-e7db-08da3716ec57
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:34:42.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3RcegYb2L4qtQcIBAm9CGzxbF+nuoehNawAcaYXn3/KENhH+dFwPCJZouInezN9jAZE1WBQiozCKV3tLgmPejNSby3emt7bvsfQ+xeFTdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4048
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 09.18, Joe Perches wrote:
> On Mon, 2022-05-16 at 14:00 +0900, Tetsuo Handa wrote:
> []
>> Changes in v3:
>>   Revert suggested change in v2, for kernel test robot <lkp@intel.com> found
>>
>>     warning: Function parameter or member 'flush_workqueue' not described in 'void'
>>     warning: expecting prototype for flush_workqueue(). Prototype was for void() instead
>>
>>   when built with W=1 option.
> 
> Odd, perhaps that not a valid error message and is a defect
> in gcc's parsing of function definitions.

Nah, gcc isn't buggy in such a fundamental part of parsing C. It's not a
warning from gcc, nor from sparse (or smatch).

It's from the perl script scripts/kernel-doc .

Rasmus
