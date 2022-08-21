Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674759B6B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiHUXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiHUXSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:18:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A202DF43
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9qw90BFohqaXf2NJ4BkvdxrGiIA6KcKla5UADhG6pZDISNrJZs14W0DrEQVJhgNry3L3GqdMxd5UK5+R/AgWXE5psXtsDZgRP70+fHLvy0YHQWtEzcNtrBM2KKfkJye7JtvDP+eGo81g/rxvDY7NxO7teUCfjJ6FH4RhUmVlIzpJ082V4opJS8yMA6bD3vQdthlCmWUOBjc06egfU4DwUV+ayukJ04kPZvF580XIf17clGdHhedS36TwEGuZqjMIj2YX0w+K40xKa2c1rckbTm7ayoAClcG5KoeCk15KAS+bw7cVJp/hgMQtrYLBstwmHjCAHl5c50t1Xwg2L55zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlibX8UT2dEl4eqwyg9vZ4HahtLZDY4WQPju9NkLlc4=;
 b=gO9zuibP/jVLkrtpUA8SiYb/qsYUCiyrSlihzI/3C209M3l1c1syBse6+GJOq4/223KoqnaJSQ66HUft7DkP5XRvgDdjnP97jyfvxnJjDcj3KESnc8YJDaiztRt4qg8DopNDg148vY6io/vkiLCGmyK9v49MMK9BeLRcIZsVkT8/0dlOkxOP56jnxF7TSKKQUQoeTpIVGf5k5rTzg5J1uQC+U0MCGvTAn/PubLp/jNVxX5+8bSbVm4Xmmh1xULDtSY9mPQXBtrfU4vtUbTehqO4KNErgmjtOS+LKb6yN70oxhZgk06FcYETo9ytTB2s7P+pOey/nB4PZLNrNyLD4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlibX8UT2dEl4eqwyg9vZ4HahtLZDY4WQPju9NkLlc4=;
 b=FwwBThtSpcbz26tDtEa/kLcH0+O2gcLU8vJRMIudBAKH/NzdcPjnTuIKajj7jK8a5cXDr9O0aTZfnsT3a0KIUeAVZ7Ab02iqTXkGvmvisGJFPg5jMq2hQftLoCeuf9yJhQvf6UaK5oZqApqDS14/YQszvvC5xVXZ+0GPJnsucmYMigH4wg76uypFGMcwrtAvSaxjonYLDx12rJezUk2Cz/UGBfrz5j0BAWo/VYCScsvfksdrtSMEZ+/i+nbrNWjRTR1e9okYYgAeSER0qHHFvZSjvfbecv+RdBdGwChYHftl/FaS/mf3AaRdpHEIYErcI7DSUkqqlqmU061J17bdZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Sun, 21 Aug
 2022 23:18:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5546.022; Sun, 21 Aug 2022
 23:18:51 +0000
Message-ID: <0004c00e-e50f-5dcf-20f9-1b8da0822bfd@nvidia.com>
Date:   Sun, 21 Aug 2022 16:18:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [syzbot] general protection fault in vma_is_shmem
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <0000000000002c73fd05e6ba3e0b@google.com>
 <20220821013246.a706fa7c2d8cb494efdba02e@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220821013246.a706fa7c2d8cb494efdba02e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c0e6d7-88b1-4360-2403-08da83cb8223
X-MS-TrafficTypeDiagnostic: CH0PR12MB5123:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZRHJlAUk8BL8cmKtdjqk4dvozeGL6Aw7JvZD/eSzwwVk4pUAuYcyu4QEzvzxm9m/JJoSX652CMEhouwpJ2V1D+eScaT0anmFz4yx9j/yBI76peTnfWn4SX6TAl9LeZiblU1dMQnkDxGhc1MWGk3vwJUAUMtmoCTWbsogMloh2OxWR5Rq2ORVRgnDCF+HNQEOShack3Mem7BBkgexeYkSzZckMjW15tOQmSzmpA60tTZ34i+eQqCVza4rGVcnAZwXFcFUQ1G6A7jF7O4PYqWfHS45jOq1FILQ2vmR328TPGHHibYk+Kg5eHRZZjpy/Gq2HhSgrf5xByCc1OiCjk4a5KCOONRIZsSVndqQWzaZv5KyIQRjnbnVuDMeO0im8z/hvTjggORFrGhPKBsoPcVFHQkui7IAfFKB2mY2eILzVnjkrOs5cEkE4GE8wsysR8XVViMQBuaOTAwq3mv2W+fVZzCLhwewOmaPR/strSzYOCJLG+c4c8vOtsnP06HbWAKiRXZcwhDMy+fAs0tw/zoADY+Lw6tUO9HSXr6sJcG6Lk1Ma7TJc/ii7o85ErJCfR9KxFL87cg3pdeKMMcilXt7Caz/wr078u7rAIP92PcKdDGmjIQNH5q9qy0pDlLHXQJZlWttirxV9SRhm+OqwaNbQaitxxJE66ed/ZeezpL13TyB+lwgifRR0QWRA4iAM7bGbJxNgYmYRFDoLsa3psWrQ8Yw1eZqftfZGm5KrIe3UhT+H9JIQQ1FcnOqS40iqzL7bfQ3u1XKDYCz7tChe2k7GtqW0ee6ryS6TBUcfd/8TylBe/efQqiRgywVxKqQ1fg9uuSiqQVr7zMSwkiMFVCR7pAvHKjZX90J4GBP4PIrqOn5MLklMWKLh2uFc6eDXMtdZq95natDNZsvaHvzFzF2xkxIvZvkgTrrYKbpFRn85EXsyLG2CRmkykktRY2H3PJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(2906002)(6506007)(53546011)(86362001)(31696002)(6512007)(26005)(966005)(107886003)(6486002)(478600001)(41300700001)(5660300002)(8936002)(6666004)(186003)(83380400001)(2616005)(38100700002)(316002)(4326008)(66946007)(8676002)(110136005)(66476007)(66556008)(45080400002)(36756003)(31686004)(54906003)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FxamF2R1kxbmRoR0VoL2JTb0pxTkhWMjNXNC9VdmVBVWc0UDNNYS9VNmJO?=
 =?utf-8?B?QTF6OW1Jb1NlZjhTRFNacTVhdTVPSlhRLzNBdGdzdmg5bTNYQTM2WVE3M3dq?=
 =?utf-8?B?bU5zUTB3Nmh3OHY2Q1IwVzk2VDFDYTNaR1h2ZHBiaEEwUS9YOTJsWXdYYXZz?=
 =?utf-8?B?RjBGMWFIMXZ6TkZSenZXNWNoYjFLT0dpMllMSDhZeVIzSG55K0VXeWRYZGNk?=
 =?utf-8?B?dXVLV2ZaY2xIN0Z1emRWRnlyZXBKT0oyUFc4RTkyNGZwSzdyWkVrSkd3RmdM?=
 =?utf-8?B?ZmpVWlB0RmlTamVGY3lyaCttUDlxWUtTYkhYQlgrcGdpeUFVejNXRTlFVFBo?=
 =?utf-8?B?eTRHSnMyY044RG1KRUZQNVhoMzNySDJ0TXN5M2RZSVYrZHRIUTFwTHJ4a096?=
 =?utf-8?B?S0tvYWFQRmIzUVpKSDlQR1BMeVhOZmRmVzZSbzM1VmxVdFlQdGFyOWk1T1V2?=
 =?utf-8?B?S3hHSXYrYklUNXBuUkFFQkVtejlHMk5HSmZxZ0lxbFE1V2JZSnc2WUthbysx?=
 =?utf-8?B?eG1DTjFXUTB6U1A0VjhxNDJnWDNTQldEdnUrU1UzMy8vZUVRK0owOVBoTnpE?=
 =?utf-8?B?ZWxsbmhyMWROUXg5NFZIY1d1MmNPLzlReWpQMndEMzZ5SXZNbFE0VWZQRnNz?=
 =?utf-8?B?cXNlRVNZQ3hvNzdSU2xCYnBDT1dNVUVyM3pKc0VYTXBMc2ZaTEVaSzV3ZXRn?=
 =?utf-8?B?QUh5MEtrN1ptekloMG5hTUVlV2NjYjRWMWppZ0JkV0E4NjI2Z1RPQzZQVm5x?=
 =?utf-8?B?QmdGa1dqQkZQTUxiTXc3YVJrVW1BNGMwM0Q3WEk3WmFJbFRZQjFOblg4Tm9z?=
 =?utf-8?B?R2ZEd0pKTmtBSURjeVlGY0N0MVlpcXZYMFYwd3F4cTNiMWNCbjl1WWJmb3Zj?=
 =?utf-8?B?NUI2NGtZUHVMTjhnYm9BbFNOQjBVSDIwcll3amIzTXRURG9xT29hMnZ1QXFV?=
 =?utf-8?B?endiWVdsbFExdjlFVjJlckNjM1k5MnZnbFVuV3lwbldVOVpzbmlubTNOU2t0?=
 =?utf-8?B?OWZKYlA2RndmWERaeTh4UkxkU1MraXhaMUdQVTcweDZpeXVrWlNCVTJuU0pW?=
 =?utf-8?B?QjJzWUxFb3VWZVY5aURCOVJHbTZNbzRpKzlHSzNjdXVZZXpmd2dwRkk5dzVs?=
 =?utf-8?B?M3RQZTc4c3ZLT241RGloMVVGNkZyNG9IQUJCdmV6cmRDVWdNZzV2UURUeDdv?=
 =?utf-8?B?RmxpU0FDTVJMUlNTalR5UUY2a1pxdy9UZFdGSHFXNkI0dUpvSEZKZkh1VHYv?=
 =?utf-8?B?bWxyemxlWktweGhPWTdITi9GS1M4eVBBVVFLSmZvdXd3VVFMM3F1d3VLTTlG?=
 =?utf-8?B?TXF2ZTlaUEhNQjVFZXlQUjhsY1gyRmhyMnF6Y01POVVJeFJMWkcrQXd2dis3?=
 =?utf-8?B?UlBrNldMNEtidk5sbUhNU0toYWRCLzJQc2ZMaGZwdjdHRzJrdHBIQkp2WWF1?=
 =?utf-8?B?aFJkUmJBNjU1N2s5dWh5clVOd25xMDdSNU12cFNZMW1VRXBwQmo0Um13bVVo?=
 =?utf-8?B?NG03cGVrSXAzQWNZYjhmMzRtbHdYTXV0YVJvWnoxcU1Bcm9QN1pNZEU2RDlB?=
 =?utf-8?B?K0NQOXl3d0RqTVBuUjlwUTdFdk95UlFhY2FVSko3WGJqeWRsaGlqbmtoTitW?=
 =?utf-8?B?UDVwYUttYW9Rd1dsUnVjK09VVzl5cVVEeEE2TGt1Wkx1RU8zSjM3RlJwU0Ry?=
 =?utf-8?B?cDRGd0lwTGQrNVZpSFR5SUVOQ0hOUGtERGdGL3NBRDcyQ3FBYlVWYkR6OUtB?=
 =?utf-8?B?VUxiU3RpeEdlMUhteGNCcHYxRU9IcFFTQnlOaE5qeHAzL2FmK2F3VzVLbHV3?=
 =?utf-8?B?OGhYaG9jQ0NqcTFjb01tQUlkZTZyVWxRbFZSemhEcHZLRmZuYzFqcnFtVXdF?=
 =?utf-8?B?SngzazVjWlZGRHNabkJPREE2QTlYTEo5bUVhR1R0WVBqUXVsOGU3Z1lpQzRr?=
 =?utf-8?B?N0Ewa2ZhU2QzbUFTTDBOWSt1aUh4aEhmcjNMSlUvbTd5aDZiVEg5Z1FQRTZD?=
 =?utf-8?B?ZWxNQVF0SnpFY0wzcnBGV1JQRGF1OVdpUUZZTkZzNDNJaWREdG1Id3JCYjh2?=
 =?utf-8?B?a3pyMnJEVFlkV0RQeUZvNDhXdkRBWWlxL2N0OENPaXh0VzVsS2Q0bm1zT2cx?=
 =?utf-8?Q?IxFcX7erEBqs63YaFq+WWNBuh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c0e6d7-88b1-4360-2403-08da83cb8223
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 23:18:51.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jin6pkYHfOKJNiT/FB0KS1ybjYaoxtBlQep33Wd2Gri78pUBcXkVsoRuCfqQaH03xK1SARq93YQSK3yk+cHD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 01:32, Andrew Morton wrote:
> On Sat, 20 Aug 2022 23:14:24 -0700 syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com> wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
> 
> Thanks.  Will a bisection search be performed?
> 
>> HEAD commit:    95d10484d66e Add linux-next specific files for 20220817
>> git tree:       linux-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15133023080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
>> dashboard link: https://syzkaller.appspot.com/bug?extid=681bbbb80445ead3c040
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1100a92d080000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123d1867080000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com
>>
>> general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> 
> Seems that io_pin_pages->pin_user_pages gave us a null vma* in the

Agreed.

> vmas[] array.  We haven't messed with gup.c much this time around -
> just one patch from Alistair ("mm/gup.c: simplify and fix
> check_and_migrate_movable_pages() return codes").  It does touch this
> area, but I can't immediately see how it could newly cause this.
> 

Neither can I, even after looking at both of these recent commits to
gup.c in this branch:

commit 4d1225cd5560 ("mm/gup.c: simplify and fix
check_and_migrate_movable_pages() return codes")

commit 0e5d6dac6b65 ("mm/gup: fix FOLL_FORCE COW security issue and
remove FOLL_COW")

As you say, a bisection would really help here.

thanks,
-- 
John Hubbard
NVIDIA

> 
>> CPU: 1 PID: 3607 Comm: syz-executor359 Not tainted 6.0.0-rc1-next-20220817-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
>> RIP: 0010:vma_is_shmem+0x21/0x40 mm/shmem.c:254
>> Code: 73 02 e9 20 fc ff ff 66 90 53 48 89 fb e8 07 2c cf ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 10 48 81 bb 90 00 00 00 20 8f f7 89 5b 0f 94 c0 c3
>> RSP: 0018:ffffc900037cfb68 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 0000000000000012 RSI: ffffffff81ace949 RDI: 0000000000000090
>> RBP: ffff888071b00720 R08: 0000000000000006 R09: 00000000000000e4
>> R10: 0000000000008001 R11: 0000000000000000 R12: 00000000000000e4
>> R13: ffff888071b00000 R14: dffffc0000000000 R15: 0000000000000000
>> FS:  0000555556ab5300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fa3c8f13260 CR3: 00000000718f5000 CR4: 00000000003506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   io_pin_pages+0x25f/0x430 io_uring/rsrc.c:1207
>>   io_sqe_buffer_register+0x14e/0x13b0 io_uring/rsrc.c:1254
>>   io_sqe_buffers_register.cold+0x351/0x445 io_uring/rsrc.c:1346
>>   __io_uring_register io_uring/io_uring.c:3711 [inline]
>>   __do_sys_io_uring_register+0x96d/0x1110 io_uring/io_uring.c:3878
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7f548fcdfbb9
>> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffc644b88f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f548fcdfbb9
>> RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000003
>> RBP: 00007f548fca3d60 R08: 0000000010000000 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f548fca3df0
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>   </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:vma_is_shmem+0x21/0x40 mm/shmem.c:254
>> Code: 73 02 e9 20 fc ff ff 66 90 53 48 89 fb e8 07 2c cf ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 10 48 81 bb 90 00 00 00 20 8f f7 89 5b 0f 94 c0 c3
>> RSP: 0018:ffffc900037cfb68 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 0000000000000012 RSI: ffffffff81ace949 RDI: 0000000000000090
>> RBP: ffff888071b00720 R08: 0000000000000006 R09: 00000000000000e4
>> R10: 0000000000008001 R11: 0000000000000000 R12: 00000000000000e4
>> R13: ffff888071b00000 R14: dffffc0000000000 R15: 0000000000000000
>> FS:  0000555556ab5300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fa3c8f13260 CR3: 00000000718f5000 CR4: 00000000003506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>     0:	73 02                	jae    0x4
>>     2:	e9 20 fc ff ff       	jmpq   0xfffffc27
>>     7:	66 90                	xchg   %ax,%ax
>>     9:	53                   	push   %rbx
>>     a:	48 89 fb             	mov    %rdi,%rbx
>>     d:	e8 07 2c cf ff       	callq  0xffcf2c19
>>    12:	48 8d bb 90 00 00 00 	lea    0x90(%rbx),%rdi
>>    19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>>    20:	fc ff df
>>    23:	48 89 fa             	mov    %rdi,%rdx
>>    26:	48 c1 ea 03          	shr    $0x3,%rdx
>> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>>    2e:	75 10                	jne    0x40
>>    30:	48 81 bb 90 00 00 00 	cmpq   $0xffffffff89f78f20,0x90(%rbx)
>>    37:	20 8f f7 89
>>    3b:	5b                   	pop    %rbx
>>    3c:	0f 94 c0             	sete   %al
>>    3f:	c3                   	retq
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches

