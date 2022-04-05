Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332BA4F502D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840756AbiDFBLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358756AbiDELRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:17:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60099.outbound.protection.outlook.com [40.107.6.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D12FE4C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU0sk68PzGIhYW8CDqLJqGEXaeIkNFORzLHwpjk/WOFzGerfJBpXNBfa3AZrrcFSl+0EfphM6KtopZ/ZcrlLCNftwDwe4Zu7HdLNOOSUMMS+rUh2UON1j7+NMQMfRELpGo6DNwVuROJaemp8dXdM2w51SUeQiApn16sVMsYKF23saJ1Mnx3gPT82CPJfQW6kjjxXhknzZWdlThnj/TbkKfiRFaJYS7cwSHFtEocZxvs3Ksy4d12RYP2UFxaWcb0b6vi4+3zGZHkjgCaWC93zjUWksxjo/o6SaVjWAedA21hwBhkpfNS/Xc+OxnxFAiyZzYu13B9VYLlOasFJYezqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMWX7KJ6b8noFlsoQQyonSz7n48F/kydxRqITRD5RT8=;
 b=B5h3b0+2ORCB9YuQgcHmbFXXIfsIYv6LmVJj6cqWHUvVCNYVlINEoQOxgtS3uinrjSVFfgiE6YFy6q8GDCsK9RXsQ1MvDm58dmMK7zWdhZJk0b/oW97YyXTfj1s/ePvQBA0rWuqqs4w7Io87JZ2CLHY3Cq+Zuzc+lST4aJyYRPzPYvL/5K3u7tK182JmBXMHy8PmiCMm2u1ImIF42TIJDGauff24n4YfNIbElT/rlTYc7iUpJ0mawZLz3tIu1aVWqCae1rTqWCOy5OFxKiMIuk247E4Tu83N1drENjtvfH83WWWfG1/Tyrxx5Cao8brBuXWyQAeto97dHriUET/4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMWX7KJ6b8noFlsoQQyonSz7n48F/kydxRqITRD5RT8=;
 b=oXo3gj08kQz6d5SGMmoBhtbiIX9kVfKjgNsCGQcZxlbymh1AlMW0Qt8aPGMvPDE1/wKmcl7bfzJxyE0buHxS42tEo5tJM1oJmv9aWnls8knfH9zUSQRTt/eG3ziSxKnc+uHKSDSBWyqjL4JN4m6YMgbEC9y/0TjDf/byBM7hs0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by PAXPR07MB8793.eurprd07.prod.outlook.com (2603:10a6:102:244::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.14; Tue, 5 Apr
 2022 10:20:21 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::2505:5d08:7490:d517]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::2505:5d08:7490:d517%7]) with mapi id 15.20.5144.016; Tue, 5 Apr 2022
 10:20:21 +0000
Message-ID: <89009285-c75d-0f09-5b08-d133c42a18f9@nokia.com>
Date:   Tue, 5 Apr 2022 12:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Hisashi Hifumi <hifumi.hisashi@oss.ntt.co.jp>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: mm: swap: locking in release_pages()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0062.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::39) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d842f29-8ca0-4c4e-3ed8-08da16ede3f7
X-MS-TrafficTypeDiagnostic: PAXPR07MB8793:EE_
X-Microsoft-Antispam-PRVS: <PAXPR07MB8793A051ECA9C5FC1F54E07F88E49@PAXPR07MB8793.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yB3DfRSr+DDfvyWVnay6RCeffRcLAxkyLRJrE2Zpsc1Shi2Z1/+OoQskE4Xq/O4vtRTa99HfoDGS3kVJaVghL0LOa3pFj3b0mZUbNoxFoN+s0LuYynHc2mzh1j380CGqaAHUgRyi0p0/+oDfLPDThZZw1lNlPGTtrMet+jjGOHNckSdir57jtAADSPTmG6XcMo12J+y/TGTXJMhtm2l/SveTcdhlbQmxZ59FBHDw8e4F0Zfse3tD3qt3luRU/ynkC5ymN7ge06v3ABCjgrQQGClKr7nEOlCqcow+TWUNxJzkGmgvX6EROQXzl/tscQBipP5gUMve8wxGVBeYx23sA5mCn01t47JupgRQYM7h8H5taj/eqF9qVPyZEGPt3dl95dHutgGc3wVOfPyHaH0cJC1HS67XoKNyOFVhq4RoEzCUcGd4McvzDuZzrbfAl9KZjhv+MjB5GcJ0Xs30Z3ZYrUOu0sWXQMEaMl39Jbhqehp5b3Ebf+aarFqwNPU80bIm5/mI/b+3i3qLK9OAVTm/ln4wMx/PuWwG1Syg5FXI153bcUXYIsc0e+bLe3pJqkxH35GsO+A1hQ/UeFlvF25AHw0vWXms6Fq8w7sgITCUKv7VdeP23mtAoHhUUPDVSWC4N4bzGXmisa5LxkU9zYZY0uAq9iDpevL1i3sLN6oTdJrH9Uv814aJlO9Mrce4i8RZQVYMER3VsxH98rh2N3ipWIPQG7QduMA3IQ7+K73e7lxu2buQXIyUAT/LNodC1gMx2JOLyTTlfN73AEdaw58qcGHl+sTZliFiAzOyMEvfFwY4XQ6+g6YZMswfw32m8FTUYq8LLIu51j2ZQ954Cazi/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(508600001)(2616005)(36756003)(26005)(8936002)(6512007)(6506007)(7416002)(186003)(6666004)(31696002)(66476007)(8676002)(38350700002)(66556008)(66946007)(82960400001)(5660300002)(38100700002)(86362001)(6486002)(921005)(52116002)(2906002)(316002)(110136005)(44832011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHNWWjNUS045TUVyOHV0dnFia1BtdElTV3BzcFdkeFpPUXRHVzM4VFJFWmRp?=
 =?utf-8?B?cGN1dEhGam9ZREtGVXJHcDdnRDF4SHpNc0JWT3lIOHdSRVNzSWtwN2FFVitM?=
 =?utf-8?B?U2F0UklXL1BhUjhSSHJXclpEVW4wQXdvNHdNYkErMU05ZEF2YjdQNEw0bG0w?=
 =?utf-8?B?MUNNRGxieFA1V0NrS0ZvQS9yR0dUV1phQ3QrQXE2Vk9DZ3dxMU1QczVpck1N?=
 =?utf-8?B?a3Q3WEp4U0R0Tk0wYnM5My9iTitKUDFPb2JCMmJ2NXFkNjhTZWNaTzFpSE92?=
 =?utf-8?B?MkpzeWkwQ29LMlZhbUVwTHlkYnNOZE15V0FHK2hRVjdaYnBqNkYwWDBSMlY2?=
 =?utf-8?B?TmNqRU9ScmJ1QmxzK1VzMXB1MXNBS3l4aklCNGNDeVF5RTI2L0VrZlVuUmgy?=
 =?utf-8?B?Q3BRd29WempxV2tuODZhcWExVGN4OEc2T3dIVVF1ODdWckRuTFFCTlZXTXZV?=
 =?utf-8?B?enl0RHlpaHVzNitWNW5LOGc5Sk9ZZkpSNitmMnowQ3dKbjhXYmhyV2xYaVAy?=
 =?utf-8?B?ZzdGTVhxL1RJMDhieUtoMHQ4UDBLbkNiSXpnVzFPT1piOEZzT0didDZXTVEx?=
 =?utf-8?B?RFRTMDNjQ2RZcWxrMWJ4TjlnRGI5MjZ3VjlPODlTdS9GWEphbG5TS2NkQmZJ?=
 =?utf-8?B?MDg4RzVEdll5SXpxa3diLzJ2WjBFOE1ucW0yUkdVNHNrekI4NzNPckJITGtx?=
 =?utf-8?B?WVZSVEZIcWVRcktDdjRNOTlPbEUvcnRzTlpRald1anQ2R09Td3NZck5VZU1S?=
 =?utf-8?B?b1E1MlBmRnA4WXRMeVByaU1XZ1NnWXNzUU9iNENGWUtqK0Z1N2Q4NHVmdm94?=
 =?utf-8?B?SjhQNHBSVHplY0RMWXNCZDk4bTVJMlRRY05UaGNlK3NYSWF2Qk9TSUNYN2tO?=
 =?utf-8?B?aUZPR3NSUHppc25Yb1AwTWNtMEhGRmpZWVNnYy93Vm5LQmMyelFDNkpOL3Iw?=
 =?utf-8?B?WC9uRlZuMENidiszbC9yZWk5U2tIMVVTdGtnMnlBcEwyRWJ4UlROV0xwY0tB?=
 =?utf-8?B?eFVZZHljc3ZRSHh3MVNSRUtsU2RxbmZjRUJIbTRCZ3cySHNkaDYzZHRRQVZF?=
 =?utf-8?B?UGhOd1BrWWNlSC9tME0rNEZBaHI0L2hvODk1akNlS0FsYUQwSFlUdWZMdkVy?=
 =?utf-8?B?amdvYVluMWZmY3hid1hMc2pWRFJnMjI3WlltK2NrTGJCS05EVnNHTjRLNEs4?=
 =?utf-8?B?c0MyZHhZRS9BMkJOcUpRdTFVbjFFbWR4QzdNVm92WHN5UmVIQjMwRmJWL0FN?=
 =?utf-8?B?MEJ4cXorbDJzaDl5UWhCemwwdm1TUU1neWQrUXpHVVBCSFBDa1kvTHZRdnhp?=
 =?utf-8?B?RG83eTJYa0RMRDhXVFJ4V1Y2cVZUUlN1SkcyZE0zUXpXWHd4TmxoQ25OTkVH?=
 =?utf-8?B?WGg3NlJNY2I0cTB4MFVpN1ZnMER2RkZGT3pyczRBNllHbXBVdEtYdVRPWXVG?=
 =?utf-8?B?Y0FBOUlyVE5ieHJ2WGhEd3ZMcDFteE1JVGZuVTF3SUFtUG5ZL283dUhBQjRs?=
 =?utf-8?B?OFZrU3lPeFNseEZaL1F1YmZSNFVhWU50NERoNWdZTmJyL3VhN2dCdWpUVExC?=
 =?utf-8?B?VHIxa096WU5qN0NabVBmOHRwOVFHLytYTkNWUVhWL0JmejF6Z2VkNzY0RTBJ?=
 =?utf-8?B?SXNUVzgvNTAxaW9rMVZaZ282UWJJSWUrSmZXNm5nRmkxV1FRdW8wZGxsc2dQ?=
 =?utf-8?B?KzRkRGdPK21jU2tyd21EUURLQ0IzSnlPb1RXZmtuamNFZFpEMFNETnRTSnV0?=
 =?utf-8?B?T0ZyNXlQSGExUGhtOHFhci9uY1BldlBpN3daa2Q1Vm9UQ2lreHZ6aENUS1RE?=
 =?utf-8?B?U2xrc1dxb2MvMFl2bmxKRE9xZGpLVTZrYThPVTUzZ0gzbjdLdWswbW4vMEhD?=
 =?utf-8?B?MDh1QWI2c0VsazhVUnBqUWtaVXJidUlZbTJ5WDJSVHkrelZSZDZLdnpKVDZp?=
 =?utf-8?B?dlozamxJMnlLbWFFaHVHMXNXWFEvQmdXTkMrMGd0aHhuQ0ZPS0RmNDRzbkN6?=
 =?utf-8?B?WmNZcVRIYzg0cEovQ3R6TURhOERDU0E4WC9rblRKQS9EYXZNWkhmSXM3VUZt?=
 =?utf-8?B?UG9LMzhySzBuMmxORnpma3hUc3lVcGdhMXFCYWRuTk56ZXE1Um1WcUFvTUho?=
 =?utf-8?B?bTJLK243MlU1cmQxYkhZV3hhQVlsZDEwbjRiTEJwa3NvKzN6QjRySGd4UW1Y?=
 =?utf-8?B?VTBPMktpdDkxc0ZML1hFVERaejN1WTFHUVVtd0ltZWxHRHpGSDhqMVl1NUNj?=
 =?utf-8?B?ZlJkdnRDc3NIM1BqWUpHaEhiLzluUEpzeEFsbnM0TFROYXN3NFlObTRvWFdn?=
 =?utf-8?B?VCs4TlI2WmN0ZDdkRVNjQ3kxa1lmcVZnY2hESmgrTlFzYkxEMUM2WUtIZFlS?=
 =?utf-8?Q?/n+kaOjG+hPpN3Is=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d842f29-8ca0-4c4e-3ed8-08da16ede3f7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 10:20:21.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx6GnbJDps3qKdGb+J2FaTQktI9REaCZpna2Lgpdadgu0J43jPucsVZp068LibsR0wq0XcoviBAXZNm0VNDj8nyJRLT3XgN3GX0kFMLG6YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8793
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear mm developers!

After experiencing a crash in release_pages() [1] I'm trying to understand the locking in the release_pages():

No matter if we consider v5.17 or v5.4 (as in my case), they both have similar locking patterns:

v5.17:

if (PageLRU(page)) {
        struct lruvec *prev_lruvec = lruvec;

        lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
                                                        &flags);
        if (prev_lruvec != lruvec)
                lock_batch = 0;

        del_page_from_lru_list(page, lruvec);
        __clear_page_lru_flags(page);
}

v5.4:

if (PageLRU(page)) {
        struct pglist_data *pgdat = page_pgdat(page);

        if (pgdat != locked_pgdat) {
                if (locked_pgdat)
                        spin_unlock_irqrestore(&locked_pgdat->lru_lock,
                                                        flags);
                lock_batch = 0;
                locked_pgdat = pgdat;
                spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
        }

        lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
        VM_BUG_ON_PAGE(!PageLRU(page), page);
        __ClearPageLRU(page);
        del_page_from_lru_list(page, lruvec, page_off_lru(page));
}

What I don't understand here is, what guarantees us that "if (PageLRU(page))" condition
is still valid after we swap the locks in "if (pgdat != locked_pgdat)" case?
If we check under one lock and VM_BUG_ON_PAGE() under another lock, what actually stops
it from crashing as below or BUG() from time to time?

1. Crash of v5.4.170 on an ARM32 machine:

Unable to handle kernel NULL pointer dereference at virtual address 00000104
pgd = e138149d
[00000104] *pgd=84d2fd003, *pmd=8ffd6f003
Internal error: Oops: a07 [#1] PREEMPT SMP ARM
...
CPU: 1 PID: 6172 Comm: AaSysInfoRColle Tainted: G    B      O      5.4.170-... #1
Hardware name: Keystone
PC is at release_pages+0x194/0x358
LR is at release_pages+0x10c/0x358
pc : [<c03367a4>]    lr : [<c033671c>]    psr: 600c0093
sp : ccec7da8  ip : 00000000  fp : 00000002
r10: 600c0013  r9 : c0e054a0  r8 : 00000001
r7 : 00000000  r6 : ccec7e68  r5 : 00000000  r4 : d435e280
r3 : 00000122  r2 : 00000100  r1 : 00000001  r0 : 600c0013
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 4d2b2cc0  DAC: 55555555
Process AaSysInfoRColle (pid: 6172, stack limit = 0x36239b43)
Stack: (0xccec7da8 to 0xccec8000)
7da0:                   c0a11970 c0ea3380 00000000 c0e04e48 cb8fbef8 ccec7dbc
7dc0: ccec7dbc c0e04e48 d435e280 ccec7e64 d435e280 00000000 ffffffff 00000000
7de0: 00000000 cb8fbef8 00000000 c0338654 00000001 c0345f0c ccec7e28 d0d0d0d0
7e00: 7fffffff c03af3e0 000000fc fffffe00 00000000 00000000 cb8fbdf8 00000000
7e20: 00000000 2f2f2f2f 00000000 c03ac448 cefdc02d c03af738 cefdc02d fefefeff
7e40: ccec7ea0 00000002 ccec7f60 c03ad6e8 00000010 00000000 00000000 ffffffff
7e60: ccec7ea0 00000101 d435e280 0000000a fffffffe c03ad6f0 00000000 ccec7ea0
7e80: ccec7f60 c03bf24c ccec7ef0 c03b9738 cb8fbdf8 c03bf24c ccec7f68 c03b1eac
7ea0: 62395b18 c0e04e48 20d0cab6 ccec7ee0 cb8fbdf8 ced8e580 ccec7f68 ffffffff
7ec0: ffffffff cb8fbdf8 fffffffe c0346468 ffffffff ffffffff 00000000 c03ee290
7ee0: 00000000 c03d16e8 cb8fbdf8 cb8fbe7c 00000007 00000000 00000000 cbb26580
7f00: c0268e64 ccec7f04 ccec7f04 c0e04e48 cb8fbdf8 c0e04e48 c0a108e4 cb8fbdf8
7f20: cb8fbeb8 c0a108e4 ccec7f68 00000000 ffffff9c c03bf790 c9cced48 00000000
7f40: cefdc000 c03b3950 ccec7f68 ccec7f58 cd2a2540 00000002 00000000 00000000
7f60: c3043a90 cd768440 79377e71 00000047 cefdc02d c03c55dc 0000000a c0e04e48
7f80: b0a9b7e8 b0a9b7e8 b6d695a1 aaa0fd60 0000000a c0201204 ccec6000 0000000a
7fa0: 000002a4 c0201000 b0a9b7e8 b6d695a1 b0a9b7e8 b07056b0 a5c2b128 00000000
7fc0: b0a9b7e8 b6d695a1 aaa0fd60 0000000a a5c2a344 a5c2a348 a5c2a474 000002a4
7fe0: b6e5191c a5c2a2bc b68922d3 b68e15d8 600c0030 b0a9b7e8 00000000 00000000
[<c03367a4>] (release_pages) from [<c0338654>] (__pagevec_release+0x28/0x44)
[<c0338654>] (__pagevec_release) from [<c0345f0c>] (shmem_undo_range+0x358/0x714)
[<c0345f0c>] (shmem_undo_range) from [<c0346468>] (shmem_evict_inode+0x11c/0x2ac)
[<c0346468>] (shmem_evict_inode) from [<c03bf790>] (evict+0xa0/0x1b8)
[<c03bf790>] (evict) from [<c03b3950>] (do_unlinkat+0x1d0/0x2a0)
[<c03b3950>] (do_unlinkat) from [<c0201000>] (ret_fast_syscall+0x0/0x4c)
Exception stack(0xccec7fa8 to 0xccec7ff0)
7fa0:                   b0a9b7e8 b6d695a1 b0a9b7e8 b07056b0 a5c2b128 00000000
7fc0: b0a9b7e8 b6d695a1 aaa0fd60 0000000a a5c2a344 a5c2a348 a5c2a474 000002a4
7fe0: b6e5191c a5c2a2bc b68922d3 b68e15d8
Code: e5933000 e3130020 1a000065 e1c420d4 (e5823004)
Kernel panic - not syncing: Fatal exception
 

-- 
Best regards,
Alexander Sverdlin.
