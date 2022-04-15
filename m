Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45672501FED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbiDOBKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbiDOBKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:10:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE356C02
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrXhSJK8tBoS55FK7Pg/kN6BPMq64J6o0iByIfhT7WONK4xD+N7QSHqcUzsp+V9a1VadLJEzfm9XRr0MWbUClC1KHmFvrGWH/S9twF/vJBz2l00aMaSxEEjfb8m+Y72y42sjqza+tWIQDxnzc73eg5nAfROWqBSO1d1XLW2708wS4lsJxSK7xhgFNKpk1jRnU8E4BuMtZklwOUpryPTXSy5osMvz27oGf9+rc1ho3QFTJI7mLPIQf6SGYNIzfgi3xpmtaVZjIpT6cF6tr/enwCAJ2niMPHmtu/7wKTDGJaeVxk6IUzgpKYjv/roHnd32fHxP7aK3kpJSHEQj1T7Kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WI6UZpoJCUOjdEd7ZN3CR9bgHRfDY0N0e63fWvqbuA=;
 b=SsMrNyhwjCP+nw8HBErmjJh1S77pwOa0B1Z/v/8EhpYidxEfl5tvLlw/6vnkyF+zug8QEsw7Gp3o0H9Xu1vn31Y39sAlKQE4iV0h05GWLPSXsQYrscVR4FsAgj/jbYVsPgm2xChSIJSPynDwwIzU2szgZpqo6tjodFVukDnpBA7Tej05u0LY74S4t5TCBNUlelf5SLGNtFpKs5q8R10LK5pfVGJ0DrVORcBHU4Wp1jtw+IoEJ5hsj+m56ADVccZKdQmFhWbdSQgRZiUPIIQx0bzZsoGqaGCK391QDsHLXIGY+lSR3YaEVSaDnTZyvIqMG1rca8z9pkIMUNyn1EuCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WI6UZpoJCUOjdEd7ZN3CR9bgHRfDY0N0e63fWvqbuA=;
 b=ZpimkOUD6sogCo5a76o3zepaNk34BZGv8MGs9s44VvMQZfSG3X8seoe8/RIopB1ElwkjPhUFmWMhLI5otj6zCnes8Di/WaIZl2cF4of+ttU7vERUJAveN+gAdGavJKGimP1NPX144LE2XBYsyGv4U14D3ndk9nVr15GlexLN4wbvNfRpIsR5UvIXqnP0i2hApngwyr9uOn1Zs9skfYbP8cfQSE9AYvEcuHNsDkQbDxlfdY1t1XwtcpU4ggIN5D5i5SMDRTbFWNHnfq4fvEpqM+CY6W2ljSMDB21AjIGAkRBE2CWQYUBBpL4I72NsIWAMJG+iQgyDvoO/ds4cnxToAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB4696.namprd12.prod.outlook.com (2603:10b6:a03:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Fri, 15 Apr
 2022 01:08:12 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14%2]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 01:08:12 +0000
Message-ID: <a07a8bab-9962-d7f4-a49a-e44ece203032@nvidia.com>
Date:   Thu, 14 Apr 2022 18:08:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] mm: recheck PageCompound() before printing out info of
 head page
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220414235950.840409-1-naoya.horiguchi@linux.dev>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220414235950.840409-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c6f397-3094-49c5-0294-08da1e7c699f
X-MS-TrafficTypeDiagnostic: BYAPR12MB4696:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4696D9E15A715B16224881E1A8EE9@BYAPR12MB4696.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJVBRGsUlaBtDyItuvgW1Wmaa3IuV1qG5qrrDu1x3qO0sdsPas06/QmPGNRxChxb7hv7kDlreCv44HcxUok4pMtVU34cDPeinafB4lJ/iGsDKIWJv5u7xdKwk+q6pGXKFAY0gNVmN/ZsrPUCfZC4ZkNdWQ1cOtNOW7yVG+NbI1wCbkTDLOIqWLEkjQkax+l/qIXcskUxQn3tTxof3Chc0+0M6v9zchr8KpC4f+OK4pBpO1b5RWLq9sdjoZkoWbVNudbjQvqnMT1nQ8lT+bhFIEqmxN+758OVmzPO8McEj+jAcARPR2kprMcwRnTVb6VwINND7huiH5gxpFtL1pk1kNqBgsCr8oStRRZ53yBzSDsq+cuis4ZgKHXf3cQFxOWvAV+bbEDAlPEKotTIWAvTIr/0s128s3BID9WsaFeC6PzN8nh/vgieyXftVJdCRdrxKRtJc3L5JXIrNj9xovfnK4rrUwEQcE72vrRLEMhaj4U0WzioE9UwjQbWWnG0+YGsIVw5K/iJYoVrSyvw19mMnAJwFQW8i//p3fLupwjJcmGdtMg/e7nHJejF8JQhvWKNeZTKOI9kQ2B9orN8mw6gWzR/f8RqXrUj93mAEhgHCiEV9ig1Uq8OM18O4/Ne3LBhNspn/z5mOkco81SMpxsYiaaOuEpC5nhLncIl0OsROlFJLqneESDu+Uweq9543s5SaDUPZjBBvMYpAGMG4lMj2Ztn9TebTTEM7GV2d3+sKt8feWst8/Xi3e+KVl+om+k3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8676002)(316002)(36756003)(4326008)(6506007)(508600001)(8936002)(66476007)(66556008)(66946007)(54906003)(110136005)(31686004)(186003)(26005)(5660300002)(83380400001)(86362001)(38100700002)(6512007)(2616005)(2906002)(6666004)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejA4bUQwdGh4ZGUxdmU2dndEZVVkc2dZYk4yelVuQ0FZWmNDNlFIR05ZWVZU?=
 =?utf-8?B?M1ZKNTRBNnd1ZEtaZUk0VUpQRkdmZk1GaWZXZ2VMYlErTkNvOTN4THIvZ2xX?=
 =?utf-8?B?T1dsMGlucmVRd0RGc1dxVDNucVJpMWZObWd5TWdGejMyeGIvMVNEOWRBQnEy?=
 =?utf-8?B?VDZlL0JaZDJJNW5ycno0YU1sZ1hId1NxblRNSndFSEZ3aldvL0ZKUUhMK1Jq?=
 =?utf-8?B?ZDNJc2NjRWZGem0rUG9BRDZlTzBhU1I2dTJhTHd2Q0FUZFRnRmNUZ1Yvc01u?=
 =?utf-8?B?bnJJWFJQVEJsRXZtNm1qNUtuT2ZVNGI1YnZ0c2JnTndGUkVZTGtDSjdNNlcw?=
 =?utf-8?B?L2x0NE5Dd0lZUitCME4wM0twUGdxNDFzRzJTeTJEb1luVEN6MXlNMVRONk1C?=
 =?utf-8?B?ekJlWGd5SVpZNFZrY3U0dFhXamRLTmtwY1ZsbTd2WEd6QVN4QWtKMHJaU0Ey?=
 =?utf-8?B?WVVFZUVTVjUyTUVTVlZZcVdaeUNlYXhZK2w0WEl6V0w3dGxKYVRRSjU2N3Bj?=
 =?utf-8?B?SDg4N0ZvT0k2MmJIa29NREdHNmthTTU5VUh0dGVZeW5IbU1CMVo3RXJvd05H?=
 =?utf-8?B?TFRybnJPZmJTcHVsWXJYMlBHU3lqVklJS0NtMG1vSVlCWk1kcUk4ZE9SbGlB?=
 =?utf-8?B?dHVBQ2VFRy9LSzhTTFVRM0NKY25QaGRqMS9hYlNCdlE4RUVVSkk2c1pjbmNZ?=
 =?utf-8?B?VGdVazJ4TXQyVlVsT2YrbmxWUU1nSFkyVU4waTg5V3Q5RzRiTm01WEtzQm5Z?=
 =?utf-8?B?dzEvZ1QxRnJUYjlwRDQxaE5kZkRFbjhodkduOHRidUdpb05XZk5xaDZ5U2ph?=
 =?utf-8?B?VjkrajI2RWVxbFd6cmkzVzJ6M09tMXdobEJQM0Y2c0xOSmhRNzV5dXhhNHND?=
 =?utf-8?B?M082QTZBVTNWMURXVldIZVJJS3ZiNVBHY1RxQ0RFSUpCczRoZi9rbVFDd2Jy?=
 =?utf-8?B?ei83UlEwM1BLM3FHQ1RSMWx6NXFVRDhiMUFIS0RuR1ZwSVVXdEk5VnZjQmt0?=
 =?utf-8?B?b1dsYlZ5Qy9UMDZkZnVOVVJ5REZ0ZzdrbmtiZ3lWL1NLRVQzQktvUDl4Mk5h?=
 =?utf-8?B?TGlzNkUySzBsNjArYXNqanBYWE9BMzNkTGJseWhYQStXMVRoWWIyVzZDVUNn?=
 =?utf-8?B?aUVMODJTQWlrUEthaUJaNThKUXRzQkpRbzZ1cllkN1FOSjI4cmg4aWFQOFBR?=
 =?utf-8?B?ZGhTNDJnS1o3ZGh4UXFMc1I5RzBVYTBvWGlIT0hCWEZRY0tuMjlpYXZoUlpr?=
 =?utf-8?B?ODlpYnovOFFta1FmeHVNVGpDVFFSVDVhS1hvMlVtSHFzZkNWa3ZSbTlwOHYy?=
 =?utf-8?B?YmRMSllDeVV1UlBJUmhGZCtnQmNYWURwdTZxOU4rL2JUMnVCMUpCYXEyS1ZV?=
 =?utf-8?B?MDhsQldmQ3NxYStmdUdhdUZZMnFILzBxd2V5djdYc25xdDhDVUgrRWJVRnls?=
 =?utf-8?B?TWNrd0k4MloxeDNyVGJhWGZneExHc2Rhb3krNVlTZ0dtMUVwRGpQeTQ0WTNt?=
 =?utf-8?B?allkTWZpRmdxc1l2ZEZvYzVRdHdCUXBEZzR2SnhheXBVZXNkVytjYTlvMHg4?=
 =?utf-8?B?Z2hHc0dKQy9rOWhwTWlmdWl4alRkVThTa0I5Y1kyOW9xMDYrZFFlS3NNWDNK?=
 =?utf-8?B?YzFYMWxsYlEra3ZWNXBBa2VuMlNTRmliWU5oOGR0QjkrbGl0WFBFcGNFQVFQ?=
 =?utf-8?B?NUtIUS9lM3h0eCtSOEtQMzlsZzluK3hDNnArSXFYY3dzQ29qWUY1T2duK2U5?=
 =?utf-8?B?ekl2QThDWGxiRGdDdlIrS0JPbVpGRGdJQkh3K2RxVi8veGtIQzlaS1BROGo0?=
 =?utf-8?B?cjJNbWxFSXRnaGhmYVljeUN4U2F0eUJwM3FqWGc5aXl1MEdwZ3NjK1NSYXRz?=
 =?utf-8?B?RmdtQ1FaREdBYWxtcDlOWjgzZitzWFh0VzRrNGxJSUVGb1JjOE9TbkRBYmhU?=
 =?utf-8?B?TjUwM1U3SDV4c0hJLzcxWEczZUtxRm1MalpTY1VKNElwSUFabjJodW5FQndi?=
 =?utf-8?B?VVFyNnpzQndkVEhlN3lZelBYOWlyQ2YreW1FdFZBMHJZbytGNmJhK2g5Szdw?=
 =?utf-8?B?NTdSMjFUblNuVlRHUUFobHcyT0Y2WlhoODZFSzFmcFNYWHFIZk1qZExLVWxZ?=
 =?utf-8?B?azlHRnVmZjBtNTVhUGttQlpxU0Nkd3luVnV3L0krazJoZUlqY2NYS2dEWjNX?=
 =?utf-8?B?dno2STc1d0hZRXIwaERDYmhLdnJtREJiQk95cjVrRi9LUzJDelM5VXJiR3Y5?=
 =?utf-8?B?YlFZQVNnaHlSM2U0QlpqRDBUUjF5OWMrY2tUcWpvYkh3WTZGT1h2R0MrbnNH?=
 =?utf-8?B?QkxqZVpqQXhkY2Vad2xiUmkxTFg5ODZFcTk0MldPd0R6M0FnY0s0Y0owcHJN?=
 =?utf-8?Q?4quri1yN38auBT8c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c6f397-3094-49c5-0294-08da1e7c699f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 01:08:12.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dCuu64e0HVSzCTAgHoJ50xb9puDliuGG2j0NmgMa9IuW28ha0ZmN/Cxvlkod3VI5UWVELi/ABxKmIPqLupEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4696
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 16:59, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> The following VM_BUG_ON_FOLIO() is triggered when memory error event
> happens on the (thp/folio) pages which are about to be freed:
> 
>    [ 1160.232771] page:00000000b36a8a0f refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x16a000
>    [ 1160.236916] page:00000000b36a8a0f refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x16a000
>    [ 1160.240684] flags: 0x57ffffc0800000(hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
>    [ 1160.243458] raw: 0057ffffc0800000 dead000000000100 dead000000000122 0000000000000000
>    [ 1160.246268] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>    [ 1160.249197] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
>    [ 1160.251815] ------------[ cut here ]------------
>    [ 1160.253438] kernel BUG at include/linux/mm.h:788!
>    [ 1160.256162] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>    [ 1160.258172] CPU: 2 PID: 115368 Comm: mceinj.sh Tainted: G            E     5.18.0-rc1-v5.18-rc1-220404-2353-005-g83111+ #3
>    [ 1160.262049] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
>    [ 1160.265103] RIP: 0010:dump_page.cold+0x27e/0x2bd
>    [ 1160.266757] Code: fe ff ff 48 c7 c6 81 f1 5a 98 e9 4c fe ff ff 48 c7 c6 a1 95 59 98 e9 40 fe ff ff 48 c7 c6 50 bf 5a 98 48 89 ef e8 9d 04 6d ff <0f> 0b 41 f7 c4 ff 0f 00 00 0f 85 9f fd ff ff 49 8b 04 24 a9 00 00
>    [ 1160.273180] RSP: 0018:ffffaa2c4d59fd18 EFLAGS: 00010292
>    [ 1160.274969] RAX: 000000000000003e RBX: 0000000000000001 RCX: 0000000000000000
>    [ 1160.277263] RDX: 0000000000000001 RSI: ffffffff985995a1 RDI: 00000000ffffffff
>    [ 1160.279571] RBP: ffffdc9c45a80000 R08: 0000000000000000 R09: 00000000ffffdfff
>    [ 1160.281794] R10: ffffaa2c4d59fb08 R11: ffffffff98940d08 R12: ffffdc9c45a80000
>    [ 1160.283920] R13: ffffffff985b6f94 R14: 0000000000000000 R15: ffffdc9c45a80000
>    [ 1160.286641] FS:  00007eff54ce1740(0000) GS:ffff99c67bd00000(0000) knlGS:0000000000000000
>    [ 1160.289498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [ 1160.291106] CR2: 00005628381a5f68 CR3: 0000000104712003 CR4: 0000000000170ee0
>    [ 1160.293031] Call Trace:
>    [ 1160.293724]  <TASK>
>    [ 1160.294334]  get_hwpoison_page+0x47d/0x570
>    [ 1160.295474]  memory_failure+0x106/0xaa0
>    [ 1160.296474]  ? security_capable+0x36/0x50
>    [ 1160.297524]  hard_offline_page_store+0x43/0x80
>    [ 1160.298684]  kernfs_fop_write_iter+0x11c/0x1b0
>    [ 1160.299829]  new_sync_write+0xf9/0x160
>    [ 1160.300810]  vfs_write+0x209/0x290
>    [ 1160.301835]  ksys_write+0x4f/0xc0
>    [ 1160.302718]  do_syscall_64+0x3b/0x90
>    [ 1160.303664]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>    [ 1160.304981] RIP: 0033:0x7eff54b018b7
> 
> As shown in the RIP address, this VM_BUG_ON in folio_entire_mapcount() is
> called from dump_page("hwpoison: unhandlable page") in get_any_page().
> The below explains the mechanism of the race:
> 
>    CPU 0                                       CPU 1
> 
>      memory_failure
>        get_hwpoison_page
>          get_any_page
>            dump_page
>              compound = PageCompound
>                                                  free_pages_prepare
>                                                    page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP
>              folio_entire_mapcount
>                VM_BUG_ON_FOLIO(!folio_test_large(folio))
> 
> So in order to avoid the BUG_ON, recheck PageCompound() before __dump_page()
> prints out information about the head page.  Precisely saying, this does
> not close up the race, but mitigates the impact to just inaccurate info,
> which should be acceptable.

Actually, I don't think it really closes the race even to that extent,
because a machine check (MCE, on x86) could come in at any point, so
rechecking (without locks) won't really completely fix such a bug, right?

> 
> Fixes: 74e8ee4708a8 ("mm: Turn head_compound_mapcount() into folio_entire_mapcount()")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> I'm actually not sure how widely the race condition could affect.
> If we can consider this as a bug specific to memory_failure(), simply
> replacing the dump_page() with simple printk() might be a proper fix

I think we should have separate, limited, special case functions that
are safe for use by exotic things like the MCE handler. And so just
doing a printk there seems better to me.

> (I confirmed that that fix also works).  But if any other dump_page()'s
> caller could race with freeing thp/folio, the more generic fix
> (I'm suggesting in this patch) would be desirable.

*If* there are other races, they should be addressed separately, IMHO.
Because MCE should be a special case.

> ---
>   mm/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index bef329bf28f0..fce63b200bea 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -93,7 +93,7 @@ static void __dump_page(struct page *page)
>   	pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
>   			page, page_ref_count(head), mapcount, mapping,
>   			page_to_pgoff(page), page_to_pfn(page));
> -	if (compound) {
> +	if (compound && PageCompound(page)) {

If people decide to keep this approach, then I'd go with something
that makes it clear, like:

	/* Re-check, in a semi-doomed attempt to avoid racing with MCE: */
	compound = PageCompound(page);

:)

thanks,
-- 
John Hubbard
NVIDIA

>   		pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
>   				head, compound_order(head),
>   				folio_entire_mapcount(folio),

