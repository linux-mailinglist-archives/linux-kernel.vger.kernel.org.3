Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D459B6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiHUXBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHUXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:01:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DEF1F2C8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XczdTIRauEIsUAo+Ku+lMK2bQl7oZmH9ifpPxZNS7VbBkmWvlFzf6gHnLgHvQDmzuEv1grGiIEZR9JPPMDSIt8DdKVkXy9jmWb7bXBymzEyzu472+k+2iGiDKoSEHnzkUlWHNzjfiyWfc56YBOjN7HC6jERuNpofHYRF8A3nmNBPcxesC43IgFOnxzoQFewm8Wksfn8eDkp72qSFvmYXWYDTp4vSRWkF9UQqFvD80Mb+b5iGlKyouLUZoVqYx1bsBXx28vwKXZTtBFVcTDq3ScaAuFOLx9ZabeHFnnY9MMQd/umGc/5eZ91wbxfxSmLIQLlO8XnDwtQA4VLE7kEeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEowzH6ZOF0NMaL9ny5ybnzu5nZAnxLRrP9cmb34Wfs=;
 b=ThvF5Pqm25KaEnExo1i1yhy+eTEOcR8fgIcpTVdODOV4XFY/NWiP4JJOH3aHEHiv3hLZInrMt4O3nqWZgzt7iBXq5C3KNjsCkGXjeqUMhFk3AqY9yWAVRvJRGyVuB4+wiF6XBVlpkckgu3WnIBMVBLvFeBiwyPMt/+xir286lvJVAGgRhXr0CqRe9SNLDNhHQREGJMxSWCfhfAuy9XaXFPeibE2TAgvZsVnVuQpht1XWIeqESYusTAgu7rFLDE3qkzb1h84hLxLEAgIE0RvwvH0gI5lGLe9Oki5EjjBkhi3RKkWLlgFJFZTmMDWjI0Co2NQvHUZPcG0R9WgrPmdNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEowzH6ZOF0NMaL9ny5ybnzu5nZAnxLRrP9cmb34Wfs=;
 b=HCuEaQwbgtbRrBk520besPbT4c9jboiijcQoAofmKcF7xT3uYDOb2WobBhq6b/Y+OCbhWFtW0a1TJvWsLbTi09oLmcHKhlCE2dHg/cf1RN4tIKN3MwRD1GjC7EMcJgAEqKOj9odtP5XX8V+9pwcyfZ/eARfqJlg2/KfbsXgoDI0fyzgBjxZNuUe7wiUela6zd527/lGBkllhqsVsVSl4NzIkbv4WGSL4GprgSGLT1rGfOHbUOJAKjVX14XQd+PX+ZYgce+1lxw+8On+6sX42gX1PRjmmQY1fABLFcIgA4OawDzvfcxeI3B/SOMumbSJ4yZ4aup2witl5ln5gTBYRGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Sun, 21 Aug
 2022 23:01:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5546.022; Sun, 21 Aug 2022
 23:01:44 +0000
Message-ID: <eb451328-0b78-f4a3-005e-2b2601d0fdde@nvidia.com>
Date:   Sun, 21 Aug 2022 16:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [syzbot] general protection fault in sanity_check_pinned_pages
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+c14f12d4b695168145b0@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <000000000000fb7fc005e6baf0f3@google.com>
 <20220821013453.fea6ca8a3a4f241e6560ad79@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220821013453.fea6ca8a3a4f241e6560ad79@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9eae66b-2357-4826-768d-08da83c91e54
X-MS-TrafficTypeDiagnostic: BL1PR12MB5993:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQe2a2EhCgmaFfCJtT9xpPVsmZ/pMDXDW+hZpqza+hK9T90sjmOZVZlxYkUn/VzAx0eCs+lKV2lskbhGtOByi4oZiXw+5700HBOTgFrAzRHKEfucpZfx5gN9nAIScdXM7oFne8LRBu6EAIVIbQ8RO2kD05PyMaipVk3w9H7+iuC3hRXD2J2l0ERz0L4/ghijalNe5uQOVXZvLizHuBBK1pQTEDGJlUV0g3xbc2bQOzCdU0QyPSLBnMikLmZA0zeMF3eGGdHkDcAvvzU00RgJTdjNaG4AJQ9OIBW/mGd6abmKS1vuPZR6Y6WZX5MCaUbmFegKwoMQahE0GCk5sSbVrok5UyzWEdBDBEs+ZAm69Qjy2NZvRaBUCxz59GoMTiLFPfY1coM2wZlh3BB4OZUlxeWXiYzDur4AYcDIfgrE4i5TEC6xFY1k0WY8lOznrgYbjZ0Q/M/iessPJ5HErMwn5MknnYjf5iWfC+ii4UDLNHBvnxoiXYyXD6AC9ebglIp2Ar0/LwCQ75lpR7YNLudgIkU9RHBgDfwhm89tsEG7pamWRfVmji4mEEV+AxN36OPzDF9SPJJLoSstMssW4kvs3SM1P7oQ32QpbF5N0MsDRodl/C7s/50p9nB8c7VRqX2fhoIEMpko8Ey/tHFvvcqfRtKTEi+dzSLU84kPMKue4C93ipOEsqag8wLVk4q2mU882LyU8gv0AAxfK5wUijfIRq36VuouEoODPB1Ch+kpA7XflcqgwV69R9IWGamGUcRSmm05HnkcHu95vmg4AKsEoFYxWeYIAgss9CiKI33Eo4NoF7XASXv/5W+cqWACy/pP3Pkt5rc4b6bXgJ8/Q1T6Em6Rly7S/ObXlYmecjQq5tzIfoWPfhaEFFJa+bfAtUlvej103i20vFiq3jncLOfVRsNxRGtOTSRG/sTHp6zr0uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(6486002)(6506007)(107886003)(966005)(41300700001)(478600001)(83380400001)(66574015)(186003)(26005)(6512007)(2906002)(2616005)(53546011)(8936002)(5660300002)(316002)(45080400002)(54906003)(110136005)(38100700002)(66556008)(66476007)(4326008)(66946007)(8676002)(86362001)(31696002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURKSkxMNGEzSlNYSU4zdzlqN0w0ZmhMQXNMVzMyWFU0U2lMYWI1VHczMnVM?=
 =?utf-8?B?Qmh1NkFaMTQ0OGQyRTBHQWlhMWhneW81WnhrWDJnVmtwWk9McDdrL3ZOWXNI?=
 =?utf-8?B?OVE2SG14SC9DRUJKVWVmdWUyT0FSaHMxaitUVVhZN1F4a1N1UVVDakMxMmFS?=
 =?utf-8?B?UXFKK2NnRk5NYndXZFhubUczUkl4ZmRiTUY2cTF5UGlOVERZVHpkeDJ1Mkl4?=
 =?utf-8?B?RFNTM3cwVXZJcmJEMm93NkJ3aUV2M1Zxa085N09UTjNBM3NUWENWVlFqZWQv?=
 =?utf-8?B?TnJINTZFemZUdTBGV1JnaFVSMmd2SzZGMWVIYlptdGg3MTgwSDJnM3J3WHNw?=
 =?utf-8?B?QVZhSFVGZVJVSzBKeXRrK09kOU04UTI3QlVZWG1PaVBIdzMvNmpZeTBzQWJo?=
 =?utf-8?B?ZjBKakM4dlo5dGl4ZnE1Q1FJeWVQVS9USFU1SkkxWFVHTEhoNXppMWdram0w?=
 =?utf-8?B?TE9GdFJrZWFQUTJGU0w2VUUxcXpTTzFuUWgzVjZQd3dvVldwUHJBZzhsd3Mz?=
 =?utf-8?B?eklqR3ErRnRneWdqYmF6NXp5RnIzRlV2Z0s5My9CYzg3QjBGVm5KK2Q5eldj?=
 =?utf-8?B?RytsejJobS9reFZPMzh6VHB6OE1KWEVkaDU2R2F1TkMwT09GQnFTL1FFeTF4?=
 =?utf-8?B?aWxKUXRsMHl1TXZtWGJ2NHQvM05OaTJwbjBEUUdPeDl2OGkvWGx2WVpsclNn?=
 =?utf-8?B?S01UN3pDai9uZUZ5RlZrRFhOTElFWTVhN0hWUXIyOVR0eHBOTTVFd1NJNU1v?=
 =?utf-8?B?QkpwM25FYmVMTnphMm9lQ2tHa3psSnVubXVieGlmb0NEY0Q1Y0J4WjNhV2Jm?=
 =?utf-8?B?OTMwbXQzdndxTzloYll6cTZ0UFZuUEpQdXhGMjJOanlIWWsvbUhPZk9aYzBU?=
 =?utf-8?B?c2NxSzdKYmh5R3pFWDRabXZNa0xJTmVKUEl4MnBrVHJIcldnSnZaNUlZd1F4?=
 =?utf-8?B?SExZc1dycVdLN3JLRE5JN2d6ZGFwakNvdGsyK3lkTFVUQmJBeUhQYTlLNEhy?=
 =?utf-8?B?a1FvT0FDV25LNFBoY21PNS9ETjNtSENGV0hpZ2hCeHdjcFY0ZUxQdk94YTVM?=
 =?utf-8?B?RnVCR3pjNHZtUDJpbUxaQ0daSVA3NDA0MjZ0c05HZFh0b2MzekNITGVseTJu?=
 =?utf-8?B?UTVFdExRb1dXWTRDY0x6VnF3UnJZMGZVKzdwcVB1Q2QxNDI4alphQUNCdXpv?=
 =?utf-8?B?NGtVYktFL0RUQmRIL3VoY1lhR3BEdTZWMlNEUTZvQlZ6VHd6S3pvMm55UjJn?=
 =?utf-8?B?NlRnekpBeHRuR3hES2ptenFpeGVQam9udHpSSksrb3g4REMyZGdwOGROUkJs?=
 =?utf-8?B?NWJzUmU1RXJQK2tLZW9rdmF4Z3JERExkQWtqdm5idE9OdmY4UUdkWXhsMU80?=
 =?utf-8?B?M2x1dUZvZ0tMekFRYU9ET3ZKdGtMeHZ6OGVrNGlsVzlFOGZQVCt2eWdFM3Jo?=
 =?utf-8?B?VytyR0xtQy9tMDUxeWVIODd6a01HZ1ZaZkwrblQ3UFduZy95V21Ba2hiMktj?=
 =?utf-8?B?NHYzWlJDaU9pdUR6d2RXdjd0eHBUSnFSS2hZWXhRN2FxVlplaHVlR1krTFpF?=
 =?utf-8?B?Wjk0alhqNVpybVVEZWJ3SzgraXBiYVUvZm1wV1Y0bnd1V2ZUcDdqVFc4MFVp?=
 =?utf-8?B?ZFVmT29VRnFweWt6bS9EVkVTT1JuM01rU3NlbEREeXRQUDdackNzL2FvU2p4?=
 =?utf-8?B?bjF3SW1PY2pmcDZMT3pSWlB4dkZWczRxaGZNdDV4Y0J1WTRxaU43K1VZdGZk?=
 =?utf-8?B?aXcrY1hNc0R5Qi91OGdjeFhnTFozU2ljekdLWU9jYythWlFWSEprTDFlZUd3?=
 =?utf-8?B?SmVRbDNpSGE1b1JsaGNJNHh1a1ZTRXZuQVhCN2tNOVByeTFFS3FaUUlXQWxD?=
 =?utf-8?B?UWdKYkE3Uy9SOTVTNzNBdEs1Vmk3Y0ZRQmxLdjRmQk1jcEpSK25LQmcxT2pJ?=
 =?utf-8?B?bm0rcmhJS0d4WEliOElZdjJIYXdHcUZnMlhWZnVkdzl5cWlZVzNnMlJNcHc2?=
 =?utf-8?B?S0RMRWNpZW1Jd2ZvcVo5dE9uUzJkZWMzNFZXZFZURjVmUkhSTDYzMkxlYldv?=
 =?utf-8?B?a3RQQzdjQzdaMmdWQ2dQbTBMMzgwYTZBNnJJcE4rRmtiSHZLYllIVWNpMFRa?=
 =?utf-8?Q?TMbudw31PNM+RNU60I9Pfr221?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eae66b-2357-4826-768d-08da83c91e54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 23:01:44.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ao33cjXByykhPjcFFZRt2xKUCW1rEMkF339UGITFprLYFvMZo+dSyXxE+G/eOCbYYRT5u0bAoIHvMgc8uIZoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
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

On 8/21/22 01:34, Andrew Morton wrote:

>> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>> CPU: 0 PID: 3608 Comm: syz-executor314 Not tainted 6.0.0-rc1-next-20220817-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
>> RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
>> RIP: 0010:sanity_check_pinned_pages+0x25e/0xec0 mm/gup.c:52
> 
> Thanks.  Another GUP explosion.

OK, so what's happening here is that rds_cmsg_rdma_args() called
pin_user_pages_fast(), and after either finishing the RDS send
operation, *or* perhaps after failing early due to an error, it then
calls unpin_user_pages_dirty_lock(), which crashes due to a NULL page*
in the pages** array.

commit 4d1225cd5560 ("mm/gup.c: simplify and fix
check_and_migrate_movable_pages() return codes") gets involved in the
code that NULLs out pages during migration in gup.c, so it is under some
suspicion here.

A bisection would be very nice to have, but meanwhile I'll look at the
other gup crash that arrived in my inbox at the same time as this one.

thanks,
-- 
John Hubbard
NVIDIA

> 
>> Code: a2 06 00 00 e8 f3 8a c9 ff 4c 89 f0 48 c1 e8 03 80 3c 18 00 0f 85 8e 0a 00 00 4d 8b 26 49 8d 44 24 08 48 89 04 24 48 c1 e8 03 <80> 3c 18 00 0f 85 8b 0a 00 00 49 8b 6c 24 08 31 ff 49 89 ef 41 83
>> RSP: 0018:ffffc900039df6d0 EFLAGS: 00010202
>> RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000000
>> RDX: ffff88802763bb00 RSI: ffffffff81b28a5d RDI: 0000000000000007
>> RBP: 000000000000034e R08: 0000000000000007 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
>> R13: 0000000000000001 R14: ffffc900039df7c8 R15: 0000000000000000
>> FS:  00007fc2d0fe9700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020001600 CR3: 0000000076052000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   unpin_user_pages_dirty_lock mm/gup.c:311 [inline]
>>   unpin_user_pages_dirty_lock+0x4a/0x4c0 mm/gup.c:299
>>   rds_rdma_free_op+0x28d/0x3c0 net/rds/rdma.c:501
>>   rds_cmsg_rdma_args+0x32c/0x1540 net/rds/rdma.c:797
>>   rds_cmsg_send net/rds/send.c:1005 [inline]
>>   rds_sendmsg+0x1c5c/0x3040 net/rds/send.c:1316
>>   sock_sendmsg_nosec net/socket.c:714 [inline]
>>   sock_sendmsg+0xcf/0x120 net/socket.c:734
>>   ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
>>   ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
>>   __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7fc2d1036e39
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fc2d0fe9308 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00007fc2d10bf408 RCX: 00007fc2d1036e39
>> RDX: 0000000000000000 RSI: 0000000020001600 RDI: 0000000000000004
>> RBP: 00007fc2d10bf400 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc2d10bf40c
>> R13: 00007fc2d108d004 R14: 632e79726f6d656d R15: 0000000000022000
>>   </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
>> RIP: 0010:sanity_check_pinned_pages+0x25e/0xec0 mm/gup.c:52
>> Code: a2 06 00 00 e8 f3 8a c9 ff 4c 89 f0 48 c1 e8 03 80 3c 18 00 0f 85 8e 0a 00 00 4d 8b 26 49 8d 44 24 08 48 89 04 24 48 c1 e8 03 <80> 3c 18 00 0f 85 8b 0a 00 00 49 8b 6c 24 08 31 ff 49 89 ef 41 83
>> RSP: 0018:ffffc900039df6d0 EFLAGS: 00010202
>> RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000000
>> RDX: ffff88802763bb00 RSI: ffffffff81b28a5d RDI: 0000000000000007
>> RBP: 000000000000034e R08: 0000000000000007 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
>> R13: 0000000000000001 R14: ffffc900039df7c8 R15: 0000000000000000
>> FS:  00007fc2d0fe9700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000002034d000 CR3: 0000000076052000 CR4: 00000000003506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>     0:	a2 06 00 00 e8 f3 8a 	movabs %al,0xffc98af3e8000006
>>     7:	c9 ff
>>     9:	4c 89 f0             	mov    %r14,%rax
>>     c:	48 c1 e8 03          	shr    $0x3,%rax
>>    10:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
>>    14:	0f 85 8e 0a 00 00    	jne    0xaa8
>>    1a:	4d 8b 26             	mov    (%r14),%r12
>>    1d:	49 8d 44 24 08       	lea    0x8(%r12),%rax
>>    22:	48 89 04 24          	mov    %rax,(%rsp)
>>    26:	48 c1 e8 03          	shr    $0x3,%rax
>> * 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
>>    2e:	0f 85 8b 0a 00 00    	jne    0xabf
>>    34:	49 8b 6c 24 08       	mov    0x8(%r12),%rbp
>>    39:	31 ff                	xor    %edi,%edi
>>    3b:	49 89 ef             	mov    %rbp,%r15
>>    3e:	41                   	rex.B
>>    3f:	83                   	.byte 0x83
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

