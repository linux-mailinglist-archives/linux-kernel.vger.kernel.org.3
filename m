Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2D5111AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358316AbiD0GvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244328AbiD0GvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:51:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928FC14CC39
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm76LxlXFLnTK7ghxXWswFIVcJTuIfq8jle1vswI6xU/JfYieIXrW1dZMtvkKVFWPBRTOzBUOYlXC+4WVPKL0rLXcXzRGSftMKC13P3SH/KAFwtaPm9GkNIsgM8xG1WV2YfnzRJTupBGkHm0XtCAUvnAHNomU4JczNQKGOjM/cllfWBxe7RhyfjwjgiwhvIM9Atj71UQ48S8j6ctqckaD09cx/Akd70qbPI3vOrTR5i1yu0iRxSJ325HCafQLM4Jzwe8LN3/C5+4ZdwgB73PKgzsqTYvOVyXfAre2rTv4WVFX2fpHVZfjjIH1GZsBrXWCorZlNPUQgape0DjYl1z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRnLQfqpv3GTB6t8aWxaYbJHvN4mcJa3aLIB42VWDq8=;
 b=capil/sR5/gP9wdm/QuzUlzBwdiLp2xyhzUsmbcgBQcNrMEiyZQThgQp7EzBDV8IlKwTgZjrZx8XEQxh7nZIo06RReaZgg0sAO7Gk3VG+SJ+jKE0aRf8lK/p+81+y4u9AEs3YKp0+jlsX9g2pnL9syah6+nIliDp1XXtl3Rbqz4FSfw6HySOyuTXf21eFOgeThg2RWbg922JK2D6tKU8QY0QeKNVeGWhWtBSNo0jiBQGj4ZIIkzhnNJPkE9YKXoTtGjIRn5wakete1JhbqR/+NitzId6HdlbeyjEAqrh6YszL4Crt6QYpfAlXLu/waPH7kvCx8bb4SIk4ZUkh8X/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRnLQfqpv3GTB6t8aWxaYbJHvN4mcJa3aLIB42VWDq8=;
 b=I/dT8R7h9Ir/Gm5cXxSFNuupzGhNSu6UshwdmlXUOEDFyWD+h+Ss9dNYOP9hPgKKHK81NqmyYfVxIgegWjsw9qjMXzUnWONZp1sc1fyGnBfubX76s0jI0xVyA4rJe4Wesinw+0SWGuuzOzrs7gSVX+ld2W1kzMAMcKTt9CbYSSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PU1PR06MB2424.apcprd06.prod.outlook.com (2603:1096:803:30::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Wed, 27 Apr 2022 06:47:51 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 06:47:51 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mm/shmem: Remove duplicate include in memory.c
Date:   Wed, 27 Apr 2022 14:47:17 +0800
Message-Id: <20220427064717.803019-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::20) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b94597e3-f284-4f90-295d-08da2819d90e
X-MS-TrafficTypeDiagnostic: PU1PR06MB2424:EE_
X-Microsoft-Antispam-PRVS: <PU1PR06MB24248C71BE48FF932CD63123ABFA9@PU1PR06MB2424.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FN6D2w1lcipgG3ugFU9gsXB1f7J+uDLXABOA52JE8UewPMzd8ZbBQwdguNm7AuyxbU07YFBTiOrlrJgSONKQ8g/vi00IElENMHOvIeU9xxT6E5TxPfuC3+QIZSFNKMSP5ys8nCJctcv9zjXPB3V31ruvnj9vRe1phTmKrdvtsOPZAvkm6OeWR1ERwV8cxTlsYpr9p19KD1WYKTJTi39E85X7toyGE8ZCSVMZqXh+QhYZsjfEPApMO4c5FiStsSX7nAAD04C7f/IFb9bLQhksf9KuRKCGW0WdUQ1pRbB/TKL9YEFYP4sVwKtJYtWKcX8WpNQWfnYBfLDkIE2y/ZEM+X28dF40/OFeNbDHsfWbQA/ltLMQVeHNE88k2nRdpL88G5IKA6d2iPtQxSLRdjxMJ+L5nHXFBNo5LvLwHt3dBsD/wmQjzyLh2hIuvN/EomKKtsqCOsGTIlW9BLyEiXQX05F5D6jUGokiiAIqHz5g0yI1bht/f1EjUXBoDT9Yx+01PrCUb3s3kmNc/5+1jYtH6ryrvFnVTyDEbl2DR4Rwk1H7Cg/res0IkMQsCLoJwkIOuKKIadrj/Gs9DubqlyYRUuGgUxPgSqPlVXeU4BMAOGoUGNpx1dSwgaaKUzjX/0qRBH40G+QJXVOkgsX/Pyn9xCFIQmOvJ95EWCnm84JaGx8yNWYf854Dpd1UHVF87mv4r7VD8NV/J+qTJCWTfPkG3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2616005)(4744005)(186003)(8936002)(52116002)(86362001)(26005)(6506007)(6512007)(6666004)(2906002)(38350700002)(38100700002)(83380400001)(107886003)(1076003)(5660300002)(316002)(4326008)(8676002)(36756003)(66476007)(66556008)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPP9be/dKtdjomufW2BPzgG8MMrI3fLDd2PvGX4XYJ7uhPOy3L2gxi8n55u1?=
 =?us-ascii?Q?L5y+MgVOdCh/48V4S1cCNxip/rMz/7UZEkcoxwuNAQL/6EV5YWRq1rPtku8O?=
 =?us-ascii?Q?atuXsH0Ut4rRpU8/zx3gcCpgYnO2do8lyd4Fi52HdU7nNjwjo0arjCNRTPoC?=
 =?us-ascii?Q?hXS51oWru6VXnPPprPznlfYqiBPwr5TuvDMwAthHdnwNPwAFWYohpsH3rDYO?=
 =?us-ascii?Q?BBsHiOqsBFfHpdHFqSYDN2yaibokGg1pSWYauCJVH9c0TANcz/uaWnX9CQ6L?=
 =?us-ascii?Q?9l/9Mlxq1EnTW0Jd/9GMSlRvUZBgF3saTeWJjrMma/RXG4VV5bHMZUX5og1k?=
 =?us-ascii?Q?rtxPoiOrnZS8ytSINIHaGMxE/bY1tdPCsjE0TLfIwiMJs2NS6GqlIoQ9WsRq?=
 =?us-ascii?Q?gJ52994FJpOraHgnjTjMxW1XI3f2awXqvi3Hy83G5cZURszOD+PHbkYIP4xo?=
 =?us-ascii?Q?HDb+SGjmkYBGgScBEH4zQSZRIHUVMhcfwW9ZpXyZWI9ErQ+q2LCrrXHvPzea?=
 =?us-ascii?Q?9r/cWhADU/ms/PdxccbKygS322btrgtNhiqjdXWotQQ/BFeiOcE/NdSFppKb?=
 =?us-ascii?Q?v6pUOiER58iHbCSmYmEo67GHBxuvJq2LfCfbyoRwH3tWVdae0JNG8GSX8W4B?=
 =?us-ascii?Q?Usc+6Z+mAuuIueAYJ4OiQ85DMB8jqMqwFekgqs4c6P8MfhwcgwQIcz2yzv6y?=
 =?us-ascii?Q?EKIxSAdEmMxT9DBFJ3tf3TB3qiGyZuGJ/6aPjCJO8CbNVn1ewvzEDCcThAJd?=
 =?us-ascii?Q?P/iPB+61CwNyP3KLC2n+eFvHDPHJ2G7uFSoR+JBhorKHgIzFn+Kw5Y1PB3Zt?=
 =?us-ascii?Q?tNaLwShF7wHFnR1B9E76/ln+RqBO1T2YVBGIoqb+oZcue0V9DZLD304W/tWU?=
 =?us-ascii?Q?iG/oUlKdth7y54SRWvzISjHDwHYtCbCwoONfMDHDVjIi/LRZ+fdnzWT4scg3?=
 =?us-ascii?Q?OhF9Nya5xaa+e9jYRyVtMZO57nJUY/RDJDtce/oA3Ipd1l5MNsnH1m5Gkk8u?=
 =?us-ascii?Q?+RLdI3hilAEc89Lr4K0AVIi2E6w63p3Uny0jC10Q4vGBzObKDxTY//nuJDKN?=
 =?us-ascii?Q?4J3gJzkj9kmBIkllnggKzbvLUq6jnju27SbddCmo1BoD9jswZc6gISb39zIs?=
 =?us-ascii?Q?E07Ggk6VXjPRXjcOwlhAiMGWkBnKCVksEhFfr/jrx22NLbhuBQpwNz+U0aWq?=
 =?us-ascii?Q?DxvbYCob/uBSzzQHe8m9ajspsFgHzLt8mDJrHG3O/gYdGMmluI1GOdQ2cXL+?=
 =?us-ascii?Q?p/pQIjowmowITgdOnON8MSIMIgoulAZVGCTLTOzGYKs74ZmVtqidETRSoDFD?=
 =?us-ascii?Q?m/JXZgHOQO8UCzGvVw4v+KVrLEVmCcIkEe3wMXRqMR+mzeUNLjoen0bEyKej?=
 =?us-ascii?Q?WVH8qqSJHaztaL5Q3lRAQLJri/lvHisl883z832WApiAFYD3XUXHHILHiRh9?=
 =?us-ascii?Q?ZvqWtpvec2qWHZJQRaUjvcmsHCweh1nfF0lDcVnXSRDX3Cb+8jSOft5KpTv/?=
 =?us-ascii?Q?pfmUYJzoOPqNNXcaPlZv64I6lGgRY1rehpMwMkwp057wtbB//XptQdu9J1IT?=
 =?us-ascii?Q?cAoRqk6S0ZzZ4bQWqRvkGspuWbk0+UbZzRtAL/4F8wZLFfOSoipKpy4I6f/0?=
 =?us-ascii?Q?EaD/x0aawI4RbkO7dFdH5a3Ixu/2SfM5VaCgrb31XcbEy9NVptrR3QVNuSju?=
 =?us-ascii?Q?+um2W/mkDNVELcT3hBM+t5G0ch0v0J8kvq+p0GSoq6ZStnw8X1MA1EKg1pNu?=
 =?us-ascii?Q?QvIIsqhu3A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94597e3-f284-4f90-295d-08da2819d90e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 06:47:51.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6M2cz/OiQ3xojReTEhapOod+ZqU9YRSGPi1wXZtjudQqDivBKGZu8OP9QGqjUkbqL2X5BgAmZS/qK2BCxrhWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2424
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkincludes.pl warning:
mm/memory.c: linux/mm_inline.h is included more than once.

The include is in line 44. Remove the duplicated here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index f93b8e87464b..d925df9e476a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -74,7 +74,6 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
-#include <linux/mm_inline.h>
 
 #include <trace/events/kmem.h>
 
-- 
2.35.3

