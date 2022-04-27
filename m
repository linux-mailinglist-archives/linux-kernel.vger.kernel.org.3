Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADD5127B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiD0Xvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiD0Xv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:51:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC581159
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpnko0UHFEqAiToPAymMw8I1LP1bhF5b9WF9sB97FWm4LfizWBFFsWq5CDbOI4NZZnTsVSTltiiqbaWmlt1mlaOuIUXfnH2adECA7PaaD3nrPPyHSE839SNCuvJhjNk202p6BjRo79cowKI6+9buHhhMkizawySlzo+C3cE/vTRCxjGvgKmm3fhslUJJLlhLzUZ/EQVxbhgwSJzN3QD8VXnA6CEaoA0LLpW4sJ/D53+mAVTGBKCDU3DHIeMsNCtwl2PguxapDNxhGwxh+r/Y3uclL1Gt7rN14h33WJcVg9BenqJw7GGLxbqiWiYEScbEKiWWIcvQtmTlu9D74ThncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3PcgAq61db0d3FQynOtVsTzbdG6LZerLxkMUs8xt20=;
 b=mYMaCQQyoyIGvWlsRkCOJp53ggWRnkKGyV5KHG8a28VgIeUZVoiDkQv+7mBimJrp3R774uk70mt3QqEjDx0Cyg/e1Wk0orRUuuUb70TS85LB++B81f6UE3WigmzJQZVzMmzSbRlwcMClExXBNmiDatteOPon8B8XVH+Z9Ejb6U5tjpaYJDcSfgAISqQ8Wl0NIlbvkaDwO+WL5FJWo6YBIs0CIRZtzpXIUaktnKKO+BoOn6rCctinPheY6356lNkEjdtxA9m+2nm0vdXkGCZIH6BS8Bbx6yGcZxx+w0Q48JLWfW9NpL44W1EkqSyTSmopsxBhFNey0/BBYEXM6oOn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3PcgAq61db0d3FQynOtVsTzbdG6LZerLxkMUs8xt20=;
 b=sngR5kdGo/RLX0bCw8Rdm/ywNcCGwJbpRumwJCyZ/1MQ9Omwg/ewz9PZ4HNudFuAoF18U7nCWwYOQkkpyC70M9plyI7oaW+Jvy3qofyJXGcrCPHBs/jrleBGPNK4f2weEXKkkhqiVf2Bkw1GWfN5yr5tfPvrACJidKpYbI3Yol3TIZAc3z4vIi1gAR6KnA/d+AvXRArffuQd0CvpeOglOXbFThAlwtSbb9DVHh5InW5iVhgyVuoEXtJzvgocwPRRl6oaG1vN4+laiDmnWZvq1vE2pB4+IxnoCmuz1B5xb9wqJz4f2gHT8pUWzvJyAB7OAbpuIdRJt+GNhsnGKStE2w==
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by DM6PR12MB3290.namprd12.prod.outlook.com (2603:10b6:5:189::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 23:48:12 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::37) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 23:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 23:48:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 27 Apr
 2022 23:48:10 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 16:48:09 -0700
Message-ID: <137f764f-8397-204a-94f0-6ba1cdb12d77@nvidia.com>
Date:   Wed, 27 Apr 2022 16:48:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in
 get_any_page()
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, <linux-mm@kvack.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0211a0ba-3e73-4464-2a42-08da28a86381
X-MS-TrafficTypeDiagnostic: DM6PR12MB3290:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32903DAB0BAD3BA7C1052C52A8FA9@DM6PR12MB3290.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zY3Vr3/0mhZGvg6q09uCob2jWCEGB6Yzu7rr1QP4K7aSIxjSTijMaDVm/vK/R+7bk07XcmBLP4l4DrP47bDVThPjcy0cJ7Ka6LRyz69lOSKpF3UXF+9ufQEKBZHsn3ZUi4m3Do3p/9FqciplY3g5MjqA5YENeDoBsYogq9788mi6AiQWzwSaIE2WqNr6aR043zby5+nVsZ7j2xlLQ4IMjjgsocylW7djMqV7n9H7tYXuEU1UudhVaLjhhutzS886X0etMj/+RI9a8kqTS2O40b6XVFnBkyHt3Jn70cAOB5Awe//c/dMaDsJUvi2CbatWPLHatu7WBcvJj8Rd2EyDK4/vQi1BNnwVB4DSebWMcOO5FfRz1IqwnHjlLbE68TPSTVXvkOutGd1ChVAyhQObbCCiJddELCHBxzL29gGzLa1funRGyotNhA7mKtLWC6Q8IaS+2CWMrhCZIDvLICCMG07agELH2AL8pWBXTRUHfa8vmu9Uzd03pJAVobiDwIiWXUCDP6yfUtfML2LeRUiix0XsfY1SNVPl5pUFb1kwe1p6O6VojQQEId5fZRNlTqFtpLOmY+bY9NTvJk56Rq6frY/7kyhZXcs6FnOvSrcv8yIlxTjJuSxsFdYV+mrzqbvVbfDttu0mtH1H/rg/ouUhdsaZ3ZcLxZJmVJyA8VnO1SgReCv8H0nVMHLZw6EJc38zotb0dG96SgAnwCndYuHZIucsUithqArv51P1Q5Rw3zadxS1FMm743QtfA/EyEtPW9lWmbeMSQViAMXOU/qSKzW5293Bx6ouw3RRdPjafQD0eQ19jCG9r82xlZzohoBJL+pzzBJAQkhtr4EiKTpxxFQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(36756003)(81166007)(966005)(5660300002)(2906002)(53546011)(70586007)(316002)(70206006)(16576012)(110136005)(508600001)(8676002)(54906003)(83380400001)(26005)(86362001)(356005)(36860700001)(31686004)(6666004)(8936002)(40460700003)(4326008)(186003)(336012)(426003)(47076005)(31696002)(2616005)(16526019)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 23:48:11.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0211a0ba-3e73-4464-2a42-08da28a86381
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3290
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 22:32, Naoya Horiguchi wrote:
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
> So replace dump_page() with safer one, pr_err().
> 
> Fixes: 74e8ee4708a8 ("mm: Turn head_compound_mapcount() into folio_entire_mapcount()")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> ChangeLog v1 -> v2:
> - v1: https://lore.kernel.org/linux-mm/20220414235950.840409-1-naoya.horiguchi@linux.dev/T/#u
> - update caller side instead of changing dump_page().
> ---
>   mm/memory-failure.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 35e11d6bea4a..0e1453514a2b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1270,7 +1270,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>   	}
>   out:
>   	if (ret == -EIO)
> -		dump_page(p, "hwpoison: unhandlable page");
> +		pr_err("Memory failure: %#lx: unhandlable page.\n", page_to_pfn(p));
>   
>   	return ret;
>   }

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
