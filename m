Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1781151201E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiD0RdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbiD0RdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:33:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B713E9BB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeYWmVHraSZ5+VpS8PfMKn5Vly75KSByDj2FCRFfOX+fbSqR8+KKxGxnTRxOs0fZKlKeGNlqpLeWtEmo/QwzPHXmZLL5zvrHrp57M7tJQcVaQ7Zb1f3n+5GAD09046hANcYoI8ywGN7V0v5cIRyq7uSchiP8tJmLR1bA24fDJdW2rBs6W3WCNeqxwexAPZtogmeQypIN8QyeYhkBmg/PXr7yHifSoZM4SNWvxRCMiDnuRhizvdd/YenqcrKUWca0Ki7sCjhRZKa/DedW/9BbI3oOAjglx/rT1BR0WsA1T29aRWpj3vh0in5ptTK3PVjdQRs+0gGiZAlLUmHPhu/xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ukM6j7kCg+10gdrOAk8iK1/wjlOxs4bbRcmUOJCx/g=;
 b=F0U+yt50sOm2mrxyRaiVSyNsMXozHpduOBT6q7WRmGECzzWz974IDffh3eC7O7JafrxOu7d0BK3ahh/V7lgSz7S5dCj9adp1Vk51S5Oslyu5Jd0LDeBv3r4DJYzp2tQ3/xSbKXnQ+zJD/Kfbu4goydvjl48uYLzUEjbJveNYMqeXHXRW3M/Lsp9SfKvdHWYi8dkFXZbdfRQFB8qluMzDcmU0CDHMdWa/gJ+rMWt1t1BqWq27V49wlutUKUVO7fNiFlNhZwqSl04D+rLGISgQqat3EuDjKB8cXtYuD2J9E1LBFS/BaBcgB1XM8c/Z8ZLVzltJY2L/JkamoJyLnQpcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ukM6j7kCg+10gdrOAk8iK1/wjlOxs4bbRcmUOJCx/g=;
 b=HZyFy6nPE78TSqvm2+ZBKnV7UtMi071XR1hqLCt0+pywzr7T8ps8mJFzi1wEKZeXgF/Aq8akZ4i56R5rTXaTVjFYlknTXpUIYFRWX8XURrCSAeOeFAeWmlE6B3oLxiMmeDz798wL9S1vPEpmAOpOOTpfqwjKVj32JHQpPI0Nkug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6329.prod.exchangelabs.com (2603:10b6:806:ee::12) by
 CH2PR01MB5782.prod.exchangelabs.com (2603:10b6:610:45::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Wed, 27 Apr 2022 17:30:05 +0000
Received: from SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6]) by SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6%3]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 17:30:05 +0000
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] Documentation/process: Make groups alphabetical and use tabs consistently
Date:   Wed, 27 Apr 2022 10:29:57 -0700
Message-Id: <ec574b5d55584a3adda9bd31b7695193636ff136.1650995848.git.darren@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650995848.git.darren@os.amperecomputing.com>
References: <cover.1650995848.git.darren@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:610:54::28) To SA0PR01MB6329.prod.exchangelabs.com
 (2603:10b6:806:ee::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baed0536-7e51-421e-9853-08da287391a7
X-MS-TrafficTypeDiagnostic: CH2PR01MB5782:EE_
X-Microsoft-Antispam-PRVS: <CH2PR01MB578222E05E8CA36109A1994CF7FA9@CH2PR01MB5782.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsbC29ZO82q5pHDLAqDoEiBpL/BBLJNnKaM1ohmvgr5POoAIBfDLbwoPca7NFyY4jK5Qzcd92EXG80p6B+Y8jynNX7/FGuHfr5b3piHZ/Nq3RMb2Jk3PVEOcb1A+7+SNbqoeAauTsuXIKfe2KncBaBP99ESkmzWkj9evq2tX5EcV+jNb7mmBzAS7OKykq/ba57PgIDyuPV5f/Dxzk/wO/W7FnRi/oAtwuABTKUeMywJRaxirvvN20y/yeWs5z4/X04ZD+6yb4Vrkan/ZILPzD2zEFGzaDxPVEjjwIf14MvNfCbhoGTIaHrHhlMM1RO7I49ak0T+dH70IJC//PxeFrz5FjQ0zqGyv3XUrFw/JoNmYX52L0SpRIvZ4Db5ghqIPTMSSCde+NZFCqr52gapagY0ibT5mrOQe/7lefzWaojHBItBkMPWCbHPKw29JZ3tBaUCP9W60fZLgabbJE8BddkSuI2oNXS6VFcyt34ApPPwIEwzLwaDwweBou1uynATFJa4eyaqzo9ygZFZYGSzDCNQsdQNjre8cA+GfXnVQy5H2D+n9BFddMHl4SfmR6N8yE3h0ADIuLYYdxibpEo8tobe8INdVDBOYq2z/C1L7fxS4yDW0btcMuEoc0AiXHyfeVN8ix28OXEAMMeCNpvdELf4+ZlHx8Jgcyy7TI2/wQXLUfHm1vTsU/Q1jfb3VcvXcR41YIjuu+qbV10iioKcTsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6329.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(52116002)(2906002)(6506007)(186003)(2616005)(8936002)(6512007)(83380400001)(26005)(4326008)(6666004)(6486002)(508600001)(316002)(54906003)(6916009)(66946007)(38350700002)(38100700002)(8676002)(66556008)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fv1h+KaJsfoS6tNVPAQOpw/ExHIvCspc2g+xxb68t7IF13DSWqn4Uf2N2cKH?=
 =?us-ascii?Q?1aJkiyZpqji61RvRSFxQp7cw8IBEQc7M6W9EAIBx3FSJk9Dk9WAlyxER9Bzw?=
 =?us-ascii?Q?IQw9Qus0RWAzeVeOvvBDp40d4rxPQgzgEhBxCo3EPziTAyXa6hrZS9+MuC5C?=
 =?us-ascii?Q?VPriWE1EtB2BSC+cXf8DrKOMxY/2HqvZeF/EdtrN5C3QFa3GLy7k50udtWeY?=
 =?us-ascii?Q?XeKMwB+hPRWfK05647ApJCiU6UFn7rkpaf86eHMP51LWsBtAOwkmor1j905g?=
 =?us-ascii?Q?hIAx+1Aglt2sDp7afrKJWcRP5mXRS6uubf2iSJFyZox7cBnBisiX88emGV/a?=
 =?us-ascii?Q?znfDFfLK4jNZDHp28zxoml73Vf9lle6XUeDOsIBwK9hV8g3ShsxtqXmMOhJh?=
 =?us-ascii?Q?6dwU1BW5I3ESEPGJTB5NKAg6lq9ZjDd9ehz+9XQ75tq8bYy6Jc5yoXU2/F+C?=
 =?us-ascii?Q?BmAVSCb2Xr4UHg/u4yw+JD7dv8ybYkzxme8YWupbJ4sBzSfJIi9QHZs3PQJR?=
 =?us-ascii?Q?iW3dj+JID8H8Hc9M0TqxFvt8RYMaAbfEwAp6NLuwYIeLvG0FQRNOX4CjldeW?=
 =?us-ascii?Q?qVe5IcuL8i9rcfYHSAZwuFpT3tC6aag7/2B2558oLzJzU9uzznasCyLs/nAF?=
 =?us-ascii?Q?xE51EmAS9A6ISbja5ClsVFpN8o8tZZUcVvotD379/E+tdE9rEkowyYcUL8u5?=
 =?us-ascii?Q?77niaq1IcD7p3XM9mzlFRlABMXcWbiaxoao48rBihJYHuEdS16cT3MBOlLpg?=
 =?us-ascii?Q?E1CXqTFENRcmoRCfUuFUvLGyetfz3M0Vp6sHGbD94Kv+N/gS9I9c5ErMsu/O?=
 =?us-ascii?Q?3chQn5vyIdjyOrrTQ6TbhZRdyRINFq/I1NQvesf5ZhVtyMoD6KyNeVlfWIBD?=
 =?us-ascii?Q?BgQxj2+rACWmMn2dgSL7Jvts191b1WqbPytVHibmlItbScMy9yMLf+9IXeIG?=
 =?us-ascii?Q?lrN+rvlk4wiZVcQgSI3//oGTS9pyLob50hDlj4tFMNizbhP4J1KGw56Edwhh?=
 =?us-ascii?Q?bt5ZDQFU6z0iiniHJr9sT4QROtM64uIHa0CnhPt9CE/bokRD4ZeqQlS7SScB?=
 =?us-ascii?Q?D1yvchN3PPxfa+/hdDF7j9Z8OuFlbdJ3ArWfYh0g52vHhSVP7Ee69Zs+Ze5W?=
 =?us-ascii?Q?lObclprd0WU4D1tObyJUBubiP9znu4YjK6RfIJC9fZizuoGujg7JIoldbqlY?=
 =?us-ascii?Q?ouvzUsCLhwqwvV6Hs0R2tz25TvfqiESVM2NXLIOiLQqEwfBUXrXPwWDfP3kA?=
 =?us-ascii?Q?rltX2X11ZTcNYJyH+mXDFtz1LZp8J0dutlRybizxfj1WaUxQ03JB0xQIwlbq?=
 =?us-ascii?Q?fsdfPnMNlrTbP+6aTAroAJuP91fAP2dbGB0Q0+Y6Ub9Bn8fksDx7sL214Zir?=
 =?us-ascii?Q?NHj7tXMLCpA29Q/f7IeX2lEw1AnotT82WD/h+Lz377nUfEwNdmXQEFGTAj4K?=
 =?us-ascii?Q?Hytgk7HJHeoKnLiUBqZse6p+81AOkX4P6RCSAjKns/6twDdNFZUbY1IPAKRW?=
 =?us-ascii?Q?RxG15BM6dkXalKAbXNGxQgwgGAGwww7X0gGULvpSNNW+K8OfUCV8XwirpBFh?=
 =?us-ascii?Q?5cEieve1Pxd9HeosSJxiAPWHGF/eB2stNQ3CKrI2IecEM95XFuRvaWeIB5VA?=
 =?us-ascii?Q?414aR8siefDk8cW3iIOVqPf5qdEVDpBEGMijOSu/geWsRyfFVjBh6q/JJbxU?=
 =?us-ascii?Q?/oKIJv3+2rBYoMKr33drX7yLsQ+6noQV8EA0Jrfgfka9Lw262dQLUwpwcl3Q?=
 =?us-ascii?Q?KjwCfgyFYStmUj3tVFIGcUosp3mZRfD3FdEVrAdTqzPl2glOMNSw?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baed0536-7e51-421e-9853-08da287391a7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6329.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 17:30:05.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlDIMxGM7aAAxYVpJ0BWD1A53auFXqx6z2HzTSHIa+WB/xlOT1ZQWvw1gTSGak4cYt3Cj/mO1DDTutHdaGAtNt+nMG0jYhG7Bd4aOPC2CNadUR49IkQkAEj8v/FXQx0s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5782
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list appears to be grouped by type (silicon, software, cloud) and
mostly alphabetical within each group, with a few exceptions.

Before adding to it, cleanup the list to be alphabetical within the
groups, and use tabs consistently throughout the list.

Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
---
 Documentation/process/embargoed-hardware-issues.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 6f8f36e10e8b..4f9efae02b6b 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -244,10 +244,10 @@ disclosure of a particular issue, unless requested by a response team or by
 an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
-  ARM           Grant Likely <grant.likely@arm.com>
   AMD		Tom Lendacky <tom.lendacky@amd.com>
-  IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
-  IBM Power     Anton Blanchard <anton@linux.ibm.com>
+  ARM		Grant Likely <grant.likely@arm.com>
+  IBM Power	Anton Blanchard <anton@linux.ibm.com>
+  IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
 
-- 
2.34.1

