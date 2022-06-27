Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E355CA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbiF0MCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiF0L5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:57:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FBBE0E;
        Mon, 27 Jun 2022 04:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiQp6RSK6Bp5CrUbB+NIMtpZ8WbZ4v3UW4tOW6dSq8Xv1i6SJ3HAPlX8Oc+X8YMSkqlA3tL+byZlNPWYeeJtw6aug3AXQFknZHzWpYGTXdw6AODsschrXYXhvHgQGNOVpQlDYqIVwtJnsYRpSXqVw9mQ4mmeStndQ/mehMttDGoJHB3wO09UJoEUEmaM3ZnZluGqvZhRo4C2To2msEiMGbAN2ZgchDlwGBseLQ10PSgNm68DuNE4rr4PfVoRXctSU51kOVeHgRfLuDMfd1Yds6wqhJ5pFZEF+tj4aTne0d2/c5BXW9GPnsoTR694I1zMQDX8F8D2oMdX9dKUzuqyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FAhb/jWOMwJX3RJdhgmcwf1MNNk4DXJwGeLYVsIaeE=;
 b=Not35WzUxiIg3bDruN6FEW7xvzC6WV5wBxmHnbOlTc3GRYqKFDNp2A2eW3Gp0JPFg5sQY9HSK5AQ48cDYYVjnoJqIrbuyLGxdfc/Vqb0VU0D3g5fpjDxGbF4PgrBv6OB8ttIxXHoSPCeqS3PQU88sOwwi3GoQk8kbzhfvg21k89yeY8bl/9ThHfvmyfiWMsDbXWsjy/HYBK9lQ3CLkO3xobFMLK67frpoxRWJcgTiyRoGin4L/GLr+ydF5mU9tbIVa8d9PwugpPK4Zlu8X0olYClpKWqi0vF78pExEbgavL1/kqQT/WifPSUBTuarYEH6ItmhiJiSLnFZyG3uVJOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FAhb/jWOMwJX3RJdhgmcwf1MNNk4DXJwGeLYVsIaeE=;
 b=L3EoLTjW80ze6griDse9ckkocIK/aKkTjzCNr5kVLY3+3lTXD7fpXtOgvVr96Ry2SSv50MdRt7qIIMQQ6UQTc8vVqlUF7lXPwAWy7qL4ru7nqRarYZWeJzN94Tal+UcvFjuAcVxKCWDJGNbaCNCMpPTUm2d7PL8RjCEI/2YVhHFxZH1u1cZcM6BYkujiuzv0G/gXZl7tDcxTXwGXwFSTdFGZQlhmXlMQrXnot8dk3NTi1y694DAfM7Da3ooS2Fq0gMzskQH5esSEswXqspcdKVtaCu4/8LVYfiKvCNEBoW5mQpnnyOd1Cc38uvI/Io6z7JinSgv2QM5exB/PxXNM2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 11:53:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 11:53:32 +0000
Message-ID: <bb1353fa-0c05-76eb-4d88-e43f60dcfec0@nvidia.com>
Date:   Mon, 27 Jun 2022 12:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build warning after merge of the tegra tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Bitan Biswas <bbiswas@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220627091519.323d5a82@canb.auug.org.au>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220627091519.323d5a82@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0551.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc87ae4d-e2ba-4b5a-dbc6-08da5833a88d
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bj3g+ai+6bd7xeAJQQN4fza/KwQAnO2ZKLchaYF0Xr7UVapCeVDXB0qhuxcQlxUH4aw0Q+swsoy5eprmecdesWR8Ee/p5qU2XJ16izgV8TuVFAA7gpOe5bj8DYQeYauF2eOfouLGRf2VmgC6jI77SkU4Wxqz89xIAW8RjirUoEVWLXbc26p+9mRX6/jwHEbUGhgNZ00J4bUKydpJktirIxDRMwuISkcQ1JIZVbyQC6wLX73IPpCa7DtXy81KKrWn6Lm3e50HqKFeji806HuA0FcuF32T4UTXdFB7bmj9YDOXLaDspYO61nVOafiJtuzSM+riOoFUJF/BaFwYNPqCnKZsRv336o1rqb1YviNzzrH2z6mbmi2IuCDoxcIbKvcUEgqI10JYI0f1yaY7/M9+o7pZY4n364c5JL6GzTGTuvn2TV255ejGz+eCmhS2s7YQZyNtd7JUPdq9h7QrC00ujwmo8WiRFFvzWvOIfb0Bg+z6CrnrdUFAEBaddwcx0FMoeYnuHWkOKs44di+06zTafF5nV2ZAegeq454zo3I4tPn5ch+eWhXYK9odqMF9+3lDpq6pA024zXV2kaK/YfiKDPSMBRVmFcDBd70e/dfA5ujyGtckjVdSFUt4QM7Iols8KI5n0PLmluCjRQ1bV5vtu5Z9HQxvjrE1AG5RyZjAh72oDGgsTbsf4gSzGxQoIruqZTJJcPNcuXo1sODtyMhzifPg06klojbf2ctEDZigxRqhEwzF05l1FZX5sIO/MqwsZ8wSDAfWVi3Z5RmxclK/wkJcX9Fd2gh5jHZHE11G0uPgAlr7Vn7ZNVZvH45QNvUn3vNFvCpT1tpugpT5PUx7UTXPcdiYdNDAWeAWl0/XooHw38IJYDc11A4T6u/jvmHfLzFXWuM++wdHeh02zjB6z95HFmWvcxxJFkGkKOQTf+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(6666004)(41300700001)(6486002)(66476007)(6506007)(2616005)(66556008)(8676002)(966005)(26005)(83380400001)(38100700002)(6512007)(86362001)(31686004)(31696002)(478600001)(55236004)(36756003)(4744005)(53546011)(316002)(186003)(54906003)(2906002)(8936002)(110136005)(6636002)(5660300002)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnEvSE42TkRmSjBtSGc1RysybnRER1RaT2xPdlVybXFnZ243cVpwZmljakRn?=
 =?utf-8?B?VEl2Q3Z3WWxRdmlOZ1RjVitpbHZDU3hVWHdQdkNqMWhQVWYyUDhlUVBtSk9N?=
 =?utf-8?B?cHRVYXdYRTJ5OWhGSXQwSitqVXR2NWpsZXVHdlR3OXFMNCtWemwxL2c5L1or?=
 =?utf-8?B?Mm05b1kyZjdSRTg3QWN5WERPdVZSa1JiemJ5bUhONXgyOFpHMFhGS3FsVkY2?=
 =?utf-8?B?S3BVbjRDWlpyK3h4WkJtSTVySDZGWExtMVVHWklUZkxDSXl3clp1VmJhNkxm?=
 =?utf-8?B?c1N6Sks3UlVNUFNrZ0VqN1dQeWV1UUVrRlNlTFJKT0t5bUlhdVZZY2VDUndH?=
 =?utf-8?B?REsxdi9YSnZ1bExNb2F0RExHVUJTVGpIY1J6T0p3ZVF0OHpzMC9PVUllTmNi?=
 =?utf-8?B?V2xEL0gveE9qZnZRWXVWZlQwY1NRZmpxRUk3elVhUVdMaFhvR2dHM3didWxT?=
 =?utf-8?B?VUE4eGozUE82ZnNudHJTeUZSUFA3bDAxTEtBNi80bDE1QjNCa3Jjb2F4MTlv?=
 =?utf-8?B?UkROaFRURCtPM1pnZWlVdEQ4VnI5d0NCa25zSFZyeUJ4Z0pHUWtXK3lVUGdv?=
 =?utf-8?B?L3R6VHBrREpaaWRHZ0pJNEN4bU84T1UwcnRvVFJCNktoNXB3NC9jZEQ0RlBm?=
 =?utf-8?B?OUpHYm1pdlR1d3lVQlo2VHJnUVJ2eVJFYjBhR0l1cVBhYmluWUQ1Vi9maDln?=
 =?utf-8?B?QWhqMjZrekwwS3E4cW1NR2hpRnB4eUVUL2VvbHNFaDVKeG1SRWp0UXd0TWZz?=
 =?utf-8?B?RU9Qb0xSeThuTUdQQnJ0QXZ1VzZtMyt5dTBSV2EzSi8wMUtrenJraXliOVNY?=
 =?utf-8?B?RzVGY3hmanZRUzFlSE0zYW1Cd3EwREFteFFnNTNMYnk1RTRjS0w3bVVHSk15?=
 =?utf-8?B?ZUdhZUZZcFZtRTRDSWZ2ODFqeWIzSDAxSXBTRlozK0lpUWtKUFphTWJlbzhx?=
 =?utf-8?B?UjN4dmIwOWx2UDBCek5jVzBHTGJTV01VOExWcVZtUm9LUHdaT3hyQzRKOHBI?=
 =?utf-8?B?UFh1MG1UUUVvSjJneUxHOEoyMGtnNUEyZnR0NUIwZHQ3L2djZmNsRVIyeGhz?=
 =?utf-8?B?OGRad1c5WjRLb1hxRHFTc3ZqWFoyRzREOGdrQ3F5anBrZDFLcVRZUHU0czZv?=
 =?utf-8?B?UnRjNGFrMDdiRUROSXhlLzVWelhFVitmWDE0b1pndjN0WXQyZXJEck1ER0xZ?=
 =?utf-8?B?Qlk3RFBudjl4aUlCTkI5YjIwUmZHSTlJaDY1Q2p2bjhuSis2TWtjZG5LcWNK?=
 =?utf-8?B?TllFWGFIcGR6c2JIa043TzdxSTRkblVBQy9TaGcwU1A5UXhkMFQvYytwUmp6?=
 =?utf-8?B?WkRJWkpUNDFUdGV0TytuNGRZcDFHM0lRNVRyWlpmYnQxZUQwUmtWTUdLb3ph?=
 =?utf-8?B?R3VkUkhETTJqM0JqSFN0UndPbFNmTXkzSnNRNkkzTFFNR2xOTFE2c1FzZzZU?=
 =?utf-8?B?aTZMa0Y5eTBKR2lONERpNXRwUTkxK3ZmV3d3U0Q3bnVvMUsyTmZncGpwMkxt?=
 =?utf-8?B?dlI0YU1YMVdTQXBJSXRrTWRtV3RORm9pSHZENHgrZDA0Sk9zUDRVMUpvOFp3?=
 =?utf-8?B?MEhkNkFHOHVDSlFieCs2aWxnTEFjem9ZMXVZQ1QzajQ4Nkl5YkdTbnExOTBS?=
 =?utf-8?B?enMrYlVPSnl2bkx2Yk9EUkJhcEk0amQ1ZWRUWTZ0bnR4dkZ6cXZnZW1rNTJh?=
 =?utf-8?B?MHhBMjhqK0x3QTBLSHNLd1piVm1UZ3RtdlVZZ21YTDMwYXRxMHJzUGJwOVcx?=
 =?utf-8?B?cWpnSGI3QnhQanhQZVpiclptMTlnSnREYTltL3lLWVFiaTFQSjQwN0ZJeW1N?=
 =?utf-8?B?NE5kVWl5VmlKTEhEbXlKNlA0ZUFZQkR2REUyN3pMaGhCZkFYSUFrTjJ6NG9l?=
 =?utf-8?B?Wnk4bjRKTGxLSVZZMHcxLzdjZEdMbjB5ZXY2YWZOd0h2U0o2SnVHYUo2WFlu?=
 =?utf-8?B?TC9rUmo1YXFEcWJlOFBCTjUzNzBldEhxMkQ1UFdyaUtNYnUvSkJ5Ym53c0Rv?=
 =?utf-8?B?RHhNOWNBM3pxaVlTMTZLb2Z4MzI3aWF1cU13SEsyTTdjWm9FNlprNmRlUC9a?=
 =?utf-8?B?NjVBZVFGUWV3ZEZ1ZWw1MjVJZ0p4SkgrQnNRaDN2TXlCTVU0c1ZXcU1VQkFw?=
 =?utf-8?B?WThvYk1JSk9MMTFJbExMSFJ4czdtdHgzaklCTXMxQWZsZ25DWjVhbUtJTEl6?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc87ae4d-e2ba-4b5a-dbc6-08da5833a88d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 11:53:32.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK42kwtxb7HbE5/55ZtKlQv/yk3tJLHYdqEx7l/urgw9Q9kLPDwlV73/Wj1eVo6SjnbhZ1+l2mNv9GRV7d3efg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 27/06/2022 00:15, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tegra tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> In file included from drivers/soc/tegra/fuse/fuse-tegra.c:7:
> include/linux/device.h:136:33: warning: 'dev_attr_production' defined but not used [-Wunused-variable]
>    136 |         struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
>        |                                 ^~~~~~~~~
> drivers/soc/tegra/fuse/fuse-tegra.c:441:8: note: in expansion of macro 'DEVICE_ATTR_RO'
>    441 | static DEVICE_ATTR_RO(production);
>        |        ^~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>    2258fe488a20 ("soc/tegra: fuse: Expose Tegra production status")
>


Thanks for reporting. I have sent an updated patch to fix this [0].

Cheers
Jon

[0] 
https://lore.kernel.org/linux-tegra/20220627114119.110825-1-jonathanh@nvidia.com/T/#u

-- 
nvpublic
