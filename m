Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92DD5B11B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiIHBB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIHBBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:01:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431913F17;
        Wed,  7 Sep 2022 18:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9gjpGMh4YZacCW8xXYTz0LUqosqnur5E0EdOL02Vf9guHGnXdc9D2zYrzWGkrz4ILSSL66Bf5+6zWFGDtMaxZLOyqFgJFq8UoQ01LwK/Sz8auTlC/ItBw08Bp/T51RC2po75RXegkdkuagYNYPSv9IzMl6H5oVQM+2pbhdUz6jyCWU7Xl8G4T8Jp5ppEcY5cPjWxUURgGNdL1M8nzeCkcyQSo2jsaOsSnavPdcMmJZPRAZ2zsI9C17yuRP497qbGjPeK3cU5fKU+iYWNk3iis6LO9QDj5SpKuugHcc4JisYPDusViBy8V38idQVFTwo1fZ4bpAndl31g00oukla8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP8hGUHXXdzFWQqWFfwhZHOAhVCep2H1VjE/ZFjNUK8=;
 b=Frlao9K9SQwfjJO8pD30m35NhG6nuHH19n+q8hIc7YRBTbeAzI3JgrpRM66ZZuuuDrbNdo9kCVCk2dfi8eVHos/jCKFs6Z9XL9evkgvD2WNI+z7/tvnmAHMhRfyXhdsmOaevpXixDX+i2GBcAz5CiqTLoEJjCncsB+tRfmG9OYkIQ8Bgs1ZcVXsqmHt/E6yASm+BQi8vv8gnjK+68gNzgC/kgfyOtYUsNMzG74GbW/Ys8LtzGorIR/VcLBdSlxKoBkUfZ6y6IJIKjj1xhGe6JzjDcEeOMUlpyBZoxTGrTpJBQ91hZ580p9JHUVEbSBxnAkyP4HTCfycFQe47PAum9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=googlegroups.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP8hGUHXXdzFWQqWFfwhZHOAhVCep2H1VjE/ZFjNUK8=;
 b=NIdsHWiFlJ9jZdUDMv1c6yptoSSfHGJQhxYWqXuCP9sPvIA2uVEbPzIFGYqu+8IIJ8jn9QNLygu6k9ijpDjjwtLlAaPaykYplecdCFPXZpxwHUM22zo0l/WKDMB+59DJepDFKdTrXhBe+solX26nu65Vra2SNGwmg32e9eApcfrB4F40I28Ln5CtcxMScEMAiC11mChBDzQUd7s9jJUiSdCKT+CKORSesUgp2LUiLQTX1Y0a2mnPkUTTMpaO+P0v+APmp1rXlk4lzCbq5M0mN2/eH6nsGQqW0JK9xDW5oNdvbp8Bj0VMheHhgpmeiRtTRqr9yWo7srTFAnN+Nf+zvA==
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 01:01:19 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c8) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 01:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 01:01:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 01:00:42 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 18:00:41 -0700
Message-ID: <eb26e739-1b9b-d76e-bc60-0ba08818b096@nvidia.com>
Date:   Wed, 7 Sep 2022 18:03:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [syzbot] usb-testing boot error: BUG: unable to handle kernel
 paging request in follow_page_mask
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+6b3a1fd733d73b7a14d7@syzkaller.appspotmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        Alex Sierra <alex.sierra@amd.com>,
        "Dan Williams" <dan.j.williams@intel.com>
References: <00000000000098580e05e8033b9a@google.com>
 <20220906172218.b50521a3caf73095983a907e@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220906172218.b50521a3caf73095983a907e@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: a876a6b8-5a58-4aa8-24ca-08da9135a37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTJUeDBGamdzU1I0bjc3djZCRVNMRzNjby9YN1pEbUdhUkFtVUl4SU8wcEt0?=
 =?utf-8?B?ZHlwUTZhSmxYYVdmSWxxai9lWEZGVjdXMFFMT29BZldXcE1tbHJPMkpuWFB0?=
 =?utf-8?B?dDQ4dkRoT1hudTVrRWNBRUVSREw2WURaZG9oZFRhbUJ6VTZPakZrbXQyRkFj?=
 =?utf-8?B?RXRDL1E1ZUdxRlY1Q3RsRmZUT25IdUVSeTFzdTY1bUhldkY1aVpnYm5Mdnlz?=
 =?utf-8?B?bEJrelZaYXl3Rk0yWURJdFpEK3BTLzNBbE5CUmhKTzdNYW5jaE5RYVd0M1N6?=
 =?utf-8?B?Y0VaektpQ3FHT2VMR0NyM21hYXAwcHhDNVlTUE1IODM5d0Yxc0RjdDhSTk9N?=
 =?utf-8?B?b1oybndNU2J5YUI2d3l6b3FWQzBKWUNWejhEenYyNnRMR1AzZ21UKzhTY2xj?=
 =?utf-8?B?ZXF6OUFLUlFmRjJtelk1SzIweWwrdDZHWlBwcElxNCtLd1lFSnNxWU10OG16?=
 =?utf-8?B?NGp2NUpPR3pscktWL0lrVVl2SUpaNWdaVnRwQW44RmlxK0VHOUJLUWxGQkZu?=
 =?utf-8?B?UWtZYlE1THA4TCs0SWFWYmhaSVp6empUL1plRHVGalNFdWp4QytLK2ljUEp5?=
 =?utf-8?B?UzVxZlFMWDVlMlJudFl2Qy92di83MWN0ek9lYS9WZVE4TUlDSnplRUs5NTU2?=
 =?utf-8?B?eWJYZVJsTGs1bHJCZXcrUEJpYzBVK3gwbFZORDVCc05vL2lZbTVTRVYzdE8v?=
 =?utf-8?B?KzA3VFFBeXdiOTZPT05CQTlzY0dTUGI5N3QxaVhZTlFRRW5SUTQ5YUJNZml0?=
 =?utf-8?B?MGdYaEc1WHduVkpORGh2dCsrVFJPcWdjemUrcWx6aEQ5azNONUthZGJ1VlFR?=
 =?utf-8?B?VTduQnMzUjE4NXRSN2ticVIyYmRGKzlUVFk0eVZKVzN6MTl4bU9hTVJoQWF3?=
 =?utf-8?B?VUVhbm1sOWJvWTlndThiTG9aUWJMQ3BIYktzOVlmak1FR3pCbDlnR0VrUEtD?=
 =?utf-8?B?blMvYnFLNXFaM2JzN1k5VEhPWHZZeUFGSTlJVXlleE5VbmV3cWs2NTcxN21i?=
 =?utf-8?B?cCtuYnptbDMyZlR3UG1pK0hJVFVBcmVkWG52dEw3Q3k2cDBHMlNHY1pOQUc4?=
 =?utf-8?B?S082aWhrOEtraEQvbzVSL0RWK2FzaTBMRmczRW0xWmNEWWFIY1lFSm9wNkdq?=
 =?utf-8?B?cURpY2pWa3JWa29hREpDazE4V1lXMFR5bDhtVW9mWHNWZkZmRmtsNWRkRVJx?=
 =?utf-8?B?TjIvcm5hNEFGeXRGVHByUDhxQkJyNUZpdXk0WEZOdEMwYU9UY3RkQ29mUmdR?=
 =?utf-8?B?Y3dlaDBJcUtEWS9yUHM0ZFhIZDZ4Tm9GcDNVUVdCUEFtRURsVkxFR2ZXU0l2?=
 =?utf-8?Q?Dc2swqFHX1/+c=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(40470700004)(36840700001)(40480700001)(81166007)(966005)(45080400002)(40460700003)(356005)(41300700001)(478600001)(70586007)(70206006)(8676002)(4326008)(316002)(54906003)(31696002)(16576012)(86362001)(110136005)(82310400005)(36756003)(26005)(426003)(47076005)(31686004)(336012)(16526019)(186003)(2616005)(5660300002)(6666004)(8936002)(83380400001)(2906002)(82740400003)(53546011)(36860700001)(99710200001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 01:01:18.6613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a876a6b8-5a58-4aa8-24ca-08da9135a37a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 17:22, Andrew Morton wrote:
> 
> (cc some of the gup.c developers)

I wrote down some of the more obvious analysis results below, but I
don't have any insight into how this happened.

> 
> On Tue, 06 Sep 2022 07:44:25 -0700 syzbot <syzbot+6b3a1fd733d73b7a14d7@syzkaller.appspotmail.com> wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    4e55e22d3d9a USB: hcd-pci: Drop the unused id parameter fr..
>> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16b2d4d7080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
>> dashboard link: https://syzkaller.appspot.com/bug?extid=6b3a1fd733d73b7a14d7
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/05f931abacee/disk-4e55e22d.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/9b749a498398/vmlinux-4e55e22d.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+6b3a1fd733d73b7a14d7@syzkaller.appspotmail.com
>>
>> BUG: unable to handle page fault for address: ffffeefda00001ff
> 
> Thanks.  A bit strange that it came from the USB tree, but I assume this
> bug originates from Linus's current.
> 
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 0 P4D 0
>> Oops: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 1 PID: 687 Comm: kworker/u4:0 Not tainted 6.0.0-rc1-syzkaller-00049-g4e55e22d3d9a #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
>> RIP: 0010:native_pud_val arch/x86/include/asm/pgtable_types.h:347 [inline]
>> RIP: 0010:pud_none arch/x86/include/asm/pgtable.h:829 [inline]
>> RIP: 0010:follow_pud_mask mm/gup.c:730 [inline]

Verified in the source code: this is crashing due to a bad address
in the pud pointer:

follow_pud_mask():
	pud = pud_offset(p4dp, address);
	if (pud_none(*pud))  // <-- crashes here


>> RIP: 0010:follow_p4d_mask mm/gup.c:782 [inline]
>> RIP: 0010:follow_page_mask+0x1a9/0x1c90 mm/gup.c:846
>> Code: 00 80 88 ff ff 4c 01 e8 4d 89 e5 49 c1 ed 1b 41 81 e5 f8 0f 00 00 49 01 c5 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 18 00 00 4d 8b 75 00 31 ff 49 83 e6 9f 4c 89
>> RSP: 0000:ffffc90001e7fb10 EFLAGS: 00010a06
>> RAX: dffffc0000000000 RBX: ffff88810e732500 RCX: 0000000000000000
>> RDX: 1ffff2fda00001ff RSI: ffffffff8167fdbd RDI: 0000000000000007
>> RBP: ffffc90001e7fc48 R08: 0000000000000007 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 00007fffffffefc0
>> R13: ffff97ed00000ff8 R14: 0000000000000000 R15: 0000000000002017
>> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffeefda00001ff CR3: 0000000007825000 CR4: 00000000003506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __get_user_pages+0x3f2/0x1020 mm/gup.c:1193
>>   __get_user_pages_locked mm/gup.c:1399 [inline]
>>   __get_user_pages_remote+0x18f/0x830 mm/gup.c:2109
>>   get_user_pages_remote+0x84/0xc0 mm/gup.c:2182
>>   get_arg_page+0xe4/0x2a0 fs/exec.c:222
>>   copy_string_kernel+0x169/0x460 fs/exec.c:639
>>   copy_strings_kernel+0xb3/0x190 fs/exec.c:655
>>   kernel_execve+0x377/0x500 fs/exec.c:2001
>>   call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>>   </TASK>
>> Modules linked in:
>> CR2: ffffeefda00001ff
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:native_pud_val arch/x86/include/asm/pgtable_types.h:347 [inline]
>> RIP: 0010:pud_none arch/x86/include/asm/pgtable.h:829 [inline]
>> RIP: 0010:follow_pud_mask mm/gup.c:730 [inline]
>> RIP: 0010:follow_p4d_mask mm/gup.c:782 [inline]
>> RIP: 0010:follow_page_mask+0x1a9/0x1c90 mm/gup.c:846
>> Code: 00 80 88 ff ff 4c 01 e8 4d 89 e5 49 c1 ed 1b 41 81 e5 f8 0f 00 00 49 01 c5 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 18 00 00 4d 8b 75 00 31 ff 49 83 e6 9f 4c 89
>> RSP: 0000:ffffc90001e7fb10 EFLAGS: 00010a06
>> RAX: dffffc0000000000 RBX: ffff88810e732500 RCX: 0000000000000000
>> RDX: 1ffff2fda00001ff RSI: ffffffff8167fdbd RDI: 0000000000000007
>> RBP: ffffc90001e7fc48 R08: 0000000000000007 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 00007fffffffefc0
>> R13: ffff97ed00000ff8 R14: 0000000000000000 R15: 0000000000002017
>> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffeefda00001ff CR3: 0000000007825000 CR4: 00000000003506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>     0:	00 80 88 ff ff 4c    	add    %al,0x4cffff88(%rax)
>>     6:	01 e8                	add    %ebp,%eax
>>     8:	4d 89 e5             	mov    %r12,%r13
>>     b:	49 c1 ed 1b          	shr    $0x1b,%r13
>>     f:	41 81 e5 f8 0f 00 00 	and    $0xff8,%r13d
>>    16:	49 01 c5             	add    %rax,%r13
>>    19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>>    20:	fc ff df
>>    23:	4c 89 ea             	mov    %r13,%rdx
>>    26:	48 c1 ea 03          	shr    $0x3,%rdx
>> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction


The fault address captured in CR2 (ffffeefda00001ff) matches what
is calculated in the above line:

%rdx             + (%rax * 1):
1ffff2fda00001ff + dffffc0000000000 == ffffeefda00001ff

Note that this is an odd (as opposed to even) address, in fact it
ends with 511. This is never a valid pointer, but it does look like
a calculation gone wrong.

I'm short of ideas as to how this happened, though.

>>    2e:	0f 85 d4 18 00 00    	jne    0x1908
>>    34:	4d 8b 75 00          	mov    0x0(%r13),%r14
>>    38:	31 ff                	xor    %edi,%edi
>>    3a:	49 83 e6 9f          	and    $0xffffffffffffff9f,%r14
>>    3e:	4c                   	rex.WR
>>    3f:	89                   	.byte 0x89
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

thanks,
-- 
John Hubbard
NVIDIA

