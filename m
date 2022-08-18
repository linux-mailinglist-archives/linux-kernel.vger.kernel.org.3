Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E3598329
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbiHRM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbiHRM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:28:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CD659C5;
        Thu, 18 Aug 2022 05:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrnw/e7USW+T1EEF5F+8LSZ6E9bzSaYbuzD4UXk56fMhXnsBm7YKwJBLEyUunewUDfUrpX0EQwHIdgc54qIey0Cs70xr1BUSpCiBvsLE/fmjcEh3B7TUEVEXqlWfiG3mb+Y24BpVa1oBsqZY0GwwnkoHC8PjSbDlwCgpzkX0E4YkkOFEDG30KhPrpIOjHTWeEsDZq47Mxw2nr5+fbOkl4gvYmzxqtKaN+r/k/7RVOVfSBojCJpwfxfkj02JEa7w3NBnJGl8UVjCuvBGZ9hWxqp+Pjm+z/zdu4AWobnNN1P3b+sVikPoti/VPSf3S4fKTSUTA5UZPzGE39RklpodLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iC7sNT+PQJaXWb8QYgpkim5IwMnYoUgTExA+8jW07w=;
 b=iLdA0RhlPIpbS8z5UBBE0jGQ4jsSUVJBD88OCBtgHFmyX3uVs/Iy1vd2eekZiEZCOd97Sl5qiJGQuuPctW7Omtcu76kkBxfnXKWotg1L9xLItgxcylCbtSuHx4wChDgVjucCskj4BG0Z50vVWQXLI+vGfq9n0E8nC05BQybS5qoIRVzmlabj6paOCm09yqR4l1ZoQHHlUkR60x/vxy0M+Itx3QRzXbcKjLXkgda3RuHSwGueutNb29Y0/4IM6WipcU0VVpqBcAcuk9BZe5lnCjk7RMPDCMYoTnuwYzM3nZuT/SeoaNsyjX8qCOwcQZ/+UB1n9nJ5LpiFK0eUAHY1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iC7sNT+PQJaXWb8QYgpkim5IwMnYoUgTExA+8jW07w=;
 b=WBeSXxELRSTuyUfE6tVoe+vJQ8l5pNWzdrFBPDahIggRmjaXzZSOT3+7Jixzb1Vln1XCEW/Fqy71AFq4kqdD+z7BLi/0zsVWFp4B7LmGs+lBQlv4pee87Pz2TpfoLETW6FRgxUDjnqMWn/0l0ycllisYukM+wUT4aR2ngN3pfotaLgBNtYT7AXFv+cTuquiBbIKazlmWcY7rTILrvZseW1+mJLktloCJEk94hyM8/8e8LkM0g9Px+FuD/KqVJO+tfuXzvNpQhfWGsra15LqZKHhXUIWEro72YvIU/ed5sLg8TSViMZWrCxrWLiiyBrPlrX9HdfPGUYHEziEYOdoHzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2854.namprd12.prod.outlook.com (2603:10b6:a03:135::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 12:28:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 12:28:01 +0000
Date:   Thu, 18 Aug 2022 09:28:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] flexible-array transformations in UAPI for 6.0-rc1
Message-ID: <Yv4wUJfrkZ0tmCin@nvidia.com>
References: <Yug4IJHugXBzPWFH@work>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yug4IJHugXBzPWFH@work>
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5704cd65-1018-4a48-7945-08da81151772
X-MS-TrafficTypeDiagnostic: BYAPR12MB2854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCTGrcYmEx4XK2qBA14S31/Wd9nXxgl3naWnWkAx0mjjx7wL317n620q246gQwIVIjotD3XnZupyhoXKQ+LVBacc9g/vHBaM7YgA8SVy0R9BoA4/Evson7tqo+wNqcChwk4e42nNnK1LbsFAsNcclg02RlFj1MTyz/9eszeZ4cYuhVbfGLTYsLXpXh9aGT7ehhnEMsvFn0oK4iKuV5XKnvUTKd2Ba8g/L1O32DVJnuS1yQMWsgk0JClWNBtvCPt20wu4V3G8OEwBA+mPKyhcm+oHckacM6EQGNKtKvX1klVw202Cv1k98ckGwxZYGyecVZnSSIP1PzcNZ7YKxMyXOnIrPxIHMu7iDax4K5X0P3Ow67iFkeERdSIrXNZrVh0pqvNJbFEjznEVsocUYR1pY1DpEvpIW8zOFUhzL4s49ZQVn8Mhrj0E7rJe2hOi4rDNJ65YIevU2AkfNTpRcyju7KhWSxvWL4oA9sIvCQArRZrTJrIsQ1H/eHVqkTK2ObFAfL1r4vbUG/GXfySOrmZxpZ2XOHBLcFtj76PMqCuI07c6W1iCgQT31IGGprU/+CW4vDQ8m7h2ykyNolYqioQjOoQn0stwQQX+54fsbJ3SIbBf18aOwviNOAL95u+NyOSuEwK8mbV6C79AauoH3pGWlNjeAx+4fOEvtGqTMAG/p9XMXttVxpLfdT6gAVhK7SsXXqvXW8JkQTnbTBJvENz7XSS86epGf3upYtuKmnbV+Z5bG/dxCBCN0Ms46Ouuiq1ZLHs8kUIPQUOlYk2XFQu2vaGeMq91LXgqAt6qMYb0kKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(26005)(6512007)(38100700002)(2906002)(6506007)(186003)(83380400001)(4326008)(66476007)(66946007)(66556008)(8676002)(36756003)(478600001)(966005)(6486002)(6916009)(54906003)(316002)(86362001)(41300700001)(8936002)(5660300002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xj230GJEyg4NVTkdnpLUKB4f0LupFI9gJpVDsMIJcUvCC4qt8sASS3mq+vTK?=
 =?us-ascii?Q?xTsYZU/EZZ582s78PKyey69L6lWJBkB5GjYGtoA452KSrQwkJ5H+d+ACbDDl?=
 =?us-ascii?Q?w1fg6XFDqwuOfFDstuczrw2X0tiSD6uprOEbmeMjkm3hQ5FbmmQuliAjG3pF?=
 =?us-ascii?Q?yuHNAHoY8y2T69t9jJwnKzn4qIgWIlsqtkA3FSIiqh+hgCP/vZ7mKeQUWsOW?=
 =?us-ascii?Q?PH7hd7fiVmdFK5YDD7TQ5YAmCt9d7XdoOltNy2m/ROR3D4asJAE9lSAoBlyN?=
 =?us-ascii?Q?1iRwEWHq/mGz3TjZZQiqfWiy0VfEK8gjd7p90v8l0pk3eTcZKdbipefdXTYu?=
 =?us-ascii?Q?/eg3RQ+/7gvgupGNMcYMS9ALrJUqv8I45DWzdArr2btdghzf/Uir8B+Bn0k5?=
 =?us-ascii?Q?kjDaErgZc5CEHyBr9euQsGy4ZXE6GVl1tJDLycMk7anCtjVChSGvOEY3aBSF?=
 =?us-ascii?Q?djsX4uVxOi98lq1+yu1Ni1kKDDCfPSsWVg2Lo2CQceKwjSO4q5zfEHrzUH3S?=
 =?us-ascii?Q?5UFtlfu1GJRnSzIT3Q+0iJFSERzEIm3hDQoJBlChcVYhRrdF61aRRgERqbUF?=
 =?us-ascii?Q?6v6gZGa4YYlv3BvbNx/W2+eCdrz+9yiXjdvNGUOjUdPqGNeOwtPrA98emKG+?=
 =?us-ascii?Q?Z1BE7wnFExBgkSWHFru5+fhJS6RpntdxWkuQmwe3NOBc9Bv9R3ova/HI11bV?=
 =?us-ascii?Q?yQsZNevCJN+c9j9ofxZmzsXCA/XMhSq9h3dhEYekTfEFzyfURBu2xaOPeao3?=
 =?us-ascii?Q?hEpOxwWOHgyxZfI/sdsA7pF+Zzq36ETzg0+2h2s9AM0k3w8ActmlkizJl9Rw?=
 =?us-ascii?Q?Whxifk/eI+CrRDSSLVAfSFy3a8YZT4WJEy3PFwAEefLGUnxJ2f438e8E+cqT?=
 =?us-ascii?Q?IO3K3oQw8cwqFOHynuquYF/6XzUba+wT7BPetJ3HgBe7lU9iwQhobX3lb/rC?=
 =?us-ascii?Q?6ig0nq6H/gt4AtPnJzCA602177V1IplQPwmM3yiaLqOVBWrOQGcWd2GytoRx?=
 =?us-ascii?Q?x8AEZ8rZPMvMjzda9RjCdPz8iJh513ll0jbVPFJy/ouhu4b6R+GhwVlzhsI5?=
 =?us-ascii?Q?tmUSHo2eH7Ay0Fj7zpqzVuHGTi+6o686qLN1sia9fc9qZCsJd3lsGs7DSmUk?=
 =?us-ascii?Q?zPX4Ndnm8HwypwwXrAQdd3ZATuZw6fxuCknI/TEeA4uNcqJpqM8Fxkl61X6B?=
 =?us-ascii?Q?/V0S4G0KhxyNOlA9rVx0lrvS3wD2M0UHuzfFnnW0yohi9913GIkbrJIiTBHt?=
 =?us-ascii?Q?r7Dhq4KRZTiSR+ZPdQgeTq0XfAv6F6lIbpMKNx+w9uR7rHYIDOYso/AzfSXJ?=
 =?us-ascii?Q?q6MIaXxggp8I4MvK0VmwVqWxiBTTRJDeW2LzyXec5PKrum9RGkIurbKy1xU5?=
 =?us-ascii?Q?TtodC6nDS44bqng2+EHtDjOYPUmcJfzzxjAenxcDJKypcoQFtCvPjVDJOmeS?=
 =?us-ascii?Q?l7S+CBNMGxKkFRsy1B4qDDcV3IaHHrKRdMwblRow0HI3bq6a1QEXLvKSgbZD?=
 =?us-ascii?Q?mGxRyTxsaKWkoTS7DuFY3sTc02GLnR4A1MYBzwoCVCTMWp8ka9cGO3m3V2Cu?=
 =?us-ascii?Q?wagwU6zGDLFide/TDguZGDEIZIGU1W58CuTMwP93?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5704cd65-1018-4a48-7945-08da81151772
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 12:28:01.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QynO/RpRa2oNo6zTzU5LLPiOf9sO8gwqlVofCV019A9fW4qSbo1XTEF2AnTngQr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 03:31:28PM -0500, Gustavo A. R. Silva wrote:
> The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:
> 
>   Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-UAPI-6.0-rc1
> 
> for you to fetch changes up to 94dfc73e7cf4a31da66b8843f0b9283ddd6b8381:
> 
>   treewide: uapi: Replace zero-length arrays with flexible-array members (2022-06-28 21:26:05 +0200)
> 
> ----------------------------------------------------------------
> flexible-array transformations in UAPI for 6.0-rc1
> 
> Hi Linus,
> 
> Please, pull the following treewide patch that replaces zero-length arrays
> with flexible-array members in UAPI. This patch has been baking in
> linux-next for 5 weeks now.
> 
> -fstrict-flex-arrays=3 is coming and we need to land these changes
> to prevent issues like these in the short future:
> 
> ../fs/minix/dir.c:337:3: warning: 'strcpy' will always overflow; destination buffer has size 0,
> but the source string has length 2 (including NUL byte) [-Wfortify-source]
> 		strcpy(de3->name, ".");
> 		^
> 
> Since these are all [0] to [] changes, the risk to UAPI is nearly zero. If
> this breaks anything, we can use a union with a new member name.

This has trobuled the RDMA userspace by creating new compiler warnings..

We discussed this and I thought you agreed not to send these changes?

https://lore.kernel.org/linux-rdma/20220628135623.GA25163@embeddedor/

Jason
