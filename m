Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7054DA8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353402AbiCPC41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346845AbiCPC4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:56:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3746669;
        Tue, 15 Mar 2022 19:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccDwSlc26hqfLMsPT8k6K5ThpjuuPQfeicW5Nbgyz+2KiSlXEWDXlbemnJ2NE5N/zyX3lvnnAeJXsBSi/KiCfmyqA+/Lw8b0/+XlQeUXigHhomKzGK/Y1ri1zAQ1v57PpWzN2tM9iiNr2bosfsmM4cc9arkeCRla8+PMEDHXWBV0OYq5mDOhkhb32xykz7140OKt6U5itVZ6GVp54Lg+pyUXS6JquZPW4Iqv+ay8aa2s9UVJ22xLjE1gN6Nhz1/LQqFzE1DsJJqilgOn2BoGNlie9ZRzih7Tz6+xi6ocdpETzSRpG51LSf7oQz/f759Bjp5dSbUyBIws50RFsJhenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUF1oFLDcz7yyDnilrW8odNlFvJvmvcu/vladr/fR5Q=;
 b=F1y2Icegc1jk8nbK68QI76A4UsbFDl0QtiThuVkaARFzjXbNJIwZWOZ3o1vxVIVz2k4RF4i213ijwtN3S+kmVc2z/R7IZE1kIDbQMJos0InjeoJMoG/TBy40+SvhMq+o8ejx4qD4EUMSHTDm2C/SaL3bM/FeRb3Mocfux2IdB6bnxokPyS9ouvba/SWzVzNtnCX54ngNy9Dh9TR1eqbd4+12rrmetMcjeR/uexCDSq0MzlrbefFVNPx6IDmLVYWoKNpwsoSIzOZZPPsZr/ZV15IHbw89RwIT0hrdBbLxUvJ5s3w2cV7crLqAks9D7FC2yUBBQ/2KMd8Qf6jn8jlWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUF1oFLDcz7yyDnilrW8odNlFvJvmvcu/vladr/fR5Q=;
 b=I6kFo5k219VliuY0w8jK3CQFToNOqKMbaNe8p+XRG6mw9qXzMp8P7xoQq+nNhxx0Idrf9F0/IgCYFKRHduKhWsEnrGD53yCZF5bSfEzgofVRfZ9TPNmzmsKDolhgGIj0xbLRbOmjGkFqitnT0YD3ThgqHQfC46ckbfd6INtgOp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB3998.apcprd06.prod.outlook.com (2603:1096:400:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Wed, 16 Mar 2022 02:55:05 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 02:55:05 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com, sfr@canb.auug.org.au,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] Documentation/driver-api: nvdimm: Fix sphinx build error
Date:   Wed, 16 Mar 2022 10:54:43 +0800
Message-Id: <20220316025445.103920-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:3:2::19) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b87d4fb-14f7-4095-1e3f-08da06f85f68
X-MS-TrafficTypeDiagnostic: TYZPR06MB3998:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB3998B7409A19AEFAC80FB975AB119@TYZPR06MB3998.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P++i/2zzACBvfjD3JtVWP6d0ea4EtYiJNZGcqVyCFkpfid2jGzIBcziBaRuuylv5ysCop+zDZMTMRb5RPCL6F3d8bgrLJDCUvcFGgygPnIECXVxfI9UZDDCll+HCg+TsIzx/Hs0iUImM7s14R7yAVXiL4WLn9/1r6Y93Dm1jvujgnYvIajEMja73WhIITt6CzDV873RgzR6W16b0JoxWPMXW/wYA7qk/Y+vD2GSvbwf0i1qXXZ4liH69uvSr+Gu45EyW40GU9Z0rXZw5JTGc20NlH44vArScHYaz5anRZlMHrlcNWaplX8SpxaHXxp63HCEmFulJI4VYiwU2yhKTKKHZw4kgX19Wu8w6GpNv/cJqpG8oClJGvEBcZuBdLRPY+fJf+t1U88+b1qPm0tYcZiXbtJGErWf85gR5Mf+vazKjmq/XN93pgU/NyX1w7GVtk0d9WchZd9spDsUQva8wZAZl3rKCR7Y4PygChBw0eSegJM5L/Pe0qOF+YsMp08gUMO28+ctFwHHKHk+HFAhDsyHDzxYR97OqGqB0vThKahUxq48eIll6VFvhthjbAT+KDfZgCYe7+8v15ofEfGbFtbkYu9vg+QwKO1j9S8upeIEyAqvEunAbIcJydppmC3SPxOYV61MzBKmEhpKkk8IWmi7NHEv8k6inccwwICVYHp/BbaiqPVhy6vHAm7JiQStAGu82ZYtGWTxOshfB2GhfVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(316002)(110136005)(83380400001)(2616005)(107886003)(186003)(66946007)(38100700002)(8676002)(86362001)(66476007)(4326008)(66556008)(26005)(6666004)(508600001)(6486002)(38350700002)(2906002)(6506007)(52116002)(6512007)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDBLm4j10eD9DOm4R37h71+u2ZsFlyHRTvSarjxKU1m76x+edUiUkf5btGsA?=
 =?us-ascii?Q?bcQG962dD2+BcJu2uaLLRO9jOdJ/4p4Qrs22IcsQQEcfXWuZPhM28Y/qLkVh?=
 =?us-ascii?Q?n/myzcSzk1GIWnhIPvDKUkP4WiL2ZwIX0XObPWb3Zgmn/sIMO5WqZuoQYN4c?=
 =?us-ascii?Q?vyWnGwGK/ABaE++2OwDum0nLX7uYVJarkxm3+9vpySxUAgE8+PggQMNUsIOU?=
 =?us-ascii?Q?AjE3/T4Xcvvm53mO+s+bYjwVU3HDNGJV86SYGXh8rBDjZ3lV5nYAPkRHpUeE?=
 =?us-ascii?Q?kaRZZNSuv4rh8+9wUe1saeTiNuP6bxXKXEhu6a/5f10hAm4GHpJrtJT3sZKf?=
 =?us-ascii?Q?lZBzEb0kO3Cd/l+8/X0TvSH3ZJ4FUveDNcSEtUS7HX/m2mqDoXabRoa/Hfbo?=
 =?us-ascii?Q?XlXVm3ab7jMiP83ktr4tDo0vqOYJcx3Dr4CCLxqQUMe28cLb7ITmslAnm3q+?=
 =?us-ascii?Q?ReU6v8S6f2rt214NlxZX6WRVWHQMOq8wmIkFyWKVkCJgshO0ojvmYtRO+/jc?=
 =?us-ascii?Q?01ZHakp8Bjqm3pexdjqx3j8Qfom2xrJjWa8ks6RuKhLbf/q0eZI7779yvXeC?=
 =?us-ascii?Q?av+xZPsHYkvCL8yPkPwNdh+SsHs6fE63F4LcWtop9uVGwUndgkZGhzUB1Hy2?=
 =?us-ascii?Q?MkLw2lWUoNUr1lE/sGBMt9i4+NWcrn2+0+BROA18zqqr6JITkzlpsjBX+kZ4?=
 =?us-ascii?Q?wrdja0klioagzc9q8yyzRB0SHUy7W4nZGOcgb5CHizZApJNuRJc+gZzcb+B6?=
 =?us-ascii?Q?XEO5QLpVwedwtZVKRs3htye0IDcroxVqqgmR0DYp1HxTDNRL/yE1r/aFUcpE?=
 =?us-ascii?Q?C8p5jq8UKP5Dom2y85gi9mSIcNo3vncV/MDGwVpn2XaafjOcYfR/bAT9e05T?=
 =?us-ascii?Q?4ovltk7QuM+sQcsa2S55DxeKaR2mfYgcA/dtyTJBvG6ZbQbuFHLvI0p26Bg1?=
 =?us-ascii?Q?7+KrdPDOI+BK7H34nHeN3ZvQIsvEDzzUvbmX57/0JkT93Sj9nzbieJdgQFfW?=
 =?us-ascii?Q?6vFnEcJjUHx94HoGkUl6u28zHIhkbRDVu2q+W8hN0IvL7NBetrXWiBzGqOUB?=
 =?us-ascii?Q?4//AkaHXa0wChMNl4gKaBW0yfxW2VFnJV5lJpt+gzVM060ZAWZW9T86SHYuk?=
 =?us-ascii?Q?bn8RkfPgNzz4yN6QLkElR51fxRdGzPcEhgqbQ901unijMYUq8Vs+lJ9TCViq?=
 =?us-ascii?Q?Zgc3hbqybmcNAuQfoVtCCUnohmbVeMM5jke5jtCm31g3vsW5RdljELSaufjK?=
 =?us-ascii?Q?ZjYyEZZlq4x6d+KMQVkU5zBRJCqeR2hBg3XB/0mWTJmKlDefAzFGhrzPEjWI?=
 =?us-ascii?Q?9MVe9fO3ZdSi6VroVheLd7HKxDPq7JyV39gHRWBrkbFRdf2mI/3j31l530mi?=
 =?us-ascii?Q?Tu2NIqEji7n/X9KV34l1TzNM7le9e8yihx15xHkibsaBa8oDDPQi/FAsDqPm?=
 =?us-ascii?Q?Uu0fmUIU3Wks4eXix2shdvP5axqiKFmq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b87d4fb-14f7-4095-1e3f-08da06f85f68
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 02:55:05.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7G5Ruo/JACJVEcsvgsZVzrOk9XYYNYvgQnwjUj0Ec924S7mCSVSgL2KVKqCj8oZo5bKtQcRk8in3rZNEMdLcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3998
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following 'make htmldocs' error:

Sphinx parallel build error:
docutils.utils.SystemMessage: ./Documentation/driver-api/nvdimm/nvdimm.rst:
146: (SEVERE/4) Title level inconsistent:

PMEM-REGIONs, Atomic Sectors, and DAX
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Fixes: f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/driver-api/nvdimm/nvdimm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index 7917f6471092..8e6922583571 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -144,7 +144,7 @@ can be immediately attached to nd_pmem. This latter mode is called
 label-less or "legacy".
 
 PMEM-REGIONs, Atomic Sectors, and DAX
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+-------------------------------------
 
 For the cases where an application or filesystem still needs atomic sector
 update guarantees it can register a BTT on a PMEM device or partition.  See
-- 
2.35.1

