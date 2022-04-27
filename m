Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969AA511D45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiD0Rd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244024AbiD0RdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:33:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46030DFD72
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFe3P6AyKAWMhfV4CrJRMlvHvnSBjcGySlf0rY5pnOspKNW6kwogoFRhlM0TJL7HHHUiSz2Y+o/SRkzbpaCekMH796bU1dCkNEmDwK3ONd2uXtZMerE8nISThJ5fpXtDqQhMGtQmIFjepwswkPmrkmN4uVBKCCOlnrEQ6voUYBnBF6p1mdbJ9eqp9MxAJ4rQW+Cm1FVV7gLO9Ny1TwYqCY+3ijbzZ1ECapztCf0QUCUtImfRuUQxnex9b6qEQDAsT7ozcmM7tsTa9zRn4AI9JK+GHgYYVaLLbXtEZGBWexiMkFpgZAMdQnM2Kl8fMnyB8MCqY6frmNEllCyUDWqoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuvnGV6SQUQM0NOePtK8XRIxdyjc6oBjQmMxMgzz/Yg=;
 b=fNbYaOZY860dv/hKX3nB28Jwd+b1rDS6bFrM+wHkZAX7l8unrmXuLwzfEFnBRKxjFoQ+r/guc5CPjA9jyzVjHTZYxN8SMQAC+sE6Tpr8UgJVO2clSZ7kIx6eaDe398EHmNoaQbgzseDa9Ey7V4ahKbw5/6pqY/ua4ayzCoAyGaR0OxwGoUj/Iv9dukxET8pRGHJv497esPTmV+8mQZTVaRc9xhF9zyWUSMVaGfy4yFPekBeEkfkvwlDng2odtT7rhxr5j6bDUzsf8JyNn1IrPL+5ifrrW3CGX97zXD4/ExNOQgK+48uPpDkozugsXm00xJ/gOMCKL+eLmfWebtBV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuvnGV6SQUQM0NOePtK8XRIxdyjc6oBjQmMxMgzz/Yg=;
 b=EqkhsLS+gWFqoRmsS4ZNzZj20C2L36kk1jscb1zoL6cH3wynwFdYlQVNCwF+Ad7m4Ojy4IhIJ/78pp2kX2r+VLpuPgEM30RKi+TZveC/27s3vqXfEZ16q6sNfHJ8QLakAskYO9wYWsa5triumspEabqMt1MkK3/f0kut9Hsc9mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6329.prod.exchangelabs.com (2603:10b6:806:ee::12) by
 CH2PR01MB5782.prod.exchangelabs.com (2603:10b6:610:45::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Wed, 27 Apr 2022 17:30:08 +0000
Received: from SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6]) by SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6%3]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 17:30:08 +0000
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] Documentation/process: Add embargoed HW contact for Ampere Computing
Date:   Wed, 27 Apr 2022 10:29:58 -0700
Message-Id: <2e36a8e925bc958928b4afa189b2f876c392831b.1650995848.git.darren@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650995848.git.darren@os.amperecomputing.com>
References: <cover.1650995848.git.darren@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:610:4c::29) To SA0PR01MB6329.prod.exchangelabs.com
 (2603:10b6:806:ee::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab15e839-b530-4fc4-b4fe-08da2873932e
X-MS-TrafficTypeDiagnostic: CH2PR01MB5782:EE_
X-Microsoft-Antispam-PRVS: <CH2PR01MB57828E0E5DF2CD60A295AD85F7FA9@CH2PR01MB5782.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMIyiJz4U2CRMY8Dzr65LQLIZoK4ELaAVV+XJXEQVgaWGJcigJhltmkKX8ZUAY7v0WK4/MwZZM+ocCHKgDmpMsEsBf8EdWspNOaL5B5Gk21O7Sm8Z/3N3WwPHg/Nu83gMUn++0wuRS/AMyU/gsAWEFc7U1S2ClZEkdVaCvXZea6fmuxNMA9+72FxnI0Gut1wPzuVjvAIGlFYPj0nMe4O1e7GhXtqFbSy505cbDnsG8dwI53m0hmGIHfFJTRiaiy05HFWBqB7vNQlHmOosq2YMBcmi3gy4XS8GaxoWM3Ch/fagl6rODBHLRJQe3XD1jAU+TmvlcKrmhk1ZuEgmXh2vXcKAxFMGMz5SvmOYdJ9KDzKMVVPMK6e243lGSG8KNN+EDvSinEftmKPRJK8kHmHvpVmGzJaZOk67JHoXHatJWFQCu7TExaoK+agYRMVrJFBY/htkVSwrmRXpGPKOHKt6HqkQva7na4R4iRmVF7wITET61lD9bfIhZgFZ4FsqRh7XEQcWNLiafGE6oQSCtl+sxA4c2diMveJM5RLk/piS3sUOUC4Js0wqvVeJUrUwJR8llIpx9Waqx75IiinQDy6u3Fvo+SBJfRN6VJHe4oXQyOyX9nGtdMvQXoRXrrQcz9V8NYCaJtGt8iL86GdLumx3WCsn+JKjiym2OOdfWDE7IY4P+PZ/DYWuUvi6kM+6V6eLQgct3e43C3dq63IcbR9ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6329.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(52116002)(2906002)(6506007)(186003)(2616005)(8936002)(4744005)(6512007)(83380400001)(26005)(4326008)(6666004)(6486002)(508600001)(316002)(54906003)(6916009)(66946007)(38350700002)(38100700002)(8676002)(66556008)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yiox6NflXp2v+oV0kTgqEaGMo/A5WSGdrWmp2cL7TfVHO477QgOp8qsIOLJb?=
 =?us-ascii?Q?sNYfGf/UMZ8WSpg8WN8wXgDfTqfjoirzIajGO+zTaibzAjnnZAjwiUpt5fDH?=
 =?us-ascii?Q?3eYAcyHIBG4VQoJrXS0lfUhMb4u416BHkeX2NP7jfRRjGD52PczkFKDIEtwN?=
 =?us-ascii?Q?AQgJZ1yXWwwqIEsXTCSrh3JqMyY6pLnnM9pa5iF0dANzTlRCY5AMmjBervkk?=
 =?us-ascii?Q?SfMF4RbpD/QaRU0xpreSTSi0vuE45fiAeqYs08+Q5dBH7L8693P3Y7K5ESgO?=
 =?us-ascii?Q?vX6XxrnkEnAirnT/y+eGJLTtf1kJqQ/A7BlHPrbGXVkCCovhC5w7BpY2vsqu?=
 =?us-ascii?Q?NIHP2oRWuZ7huCktlwRUkiSlAHe445KEv2vcyJIV6ZEdyFoJjRH5WY0GiGwp?=
 =?us-ascii?Q?6wF5TK02Fh4aiJAbIxAoF76+LuwlzhxKCZsSTi/LgHE0AJcIx5E+ZWeB6usq?=
 =?us-ascii?Q?XKG+KtDI1p8RJfoIU+wAw0iHw/jtgygOFj13P0YE2/VUnP5muvtDfFJTZF63?=
 =?us-ascii?Q?aPUYG90gqZu7XCa3YHI7bolmE4Os2YWMmyliOVPVdA+Kqc+hTtuDzNQT9XpE?=
 =?us-ascii?Q?QYq8bajEnDs83LRVPu/C0MThqmIHsrfaIIP6GW9eZUzlSkjxRn5z8nFxWwK4?=
 =?us-ascii?Q?q8xvxEZITxSy2QEXdRFCTbIUUXktIyQnOT/tHD1OhL8uh+yn0jOdIVKA4zHN?=
 =?us-ascii?Q?rdRKUTKkU9NiBDIddohPCF9I4Y17ReXrtgLecMYrGpfxA6nORhhK9X5QJ5tF?=
 =?us-ascii?Q?0ws5ltiCqMYzjNIf6fzefL7l1YaSx0oB4FNhugw5uzntrXV/1k//XhFS5pws?=
 =?us-ascii?Q?kmOSXdoO7o4sEfMNyaOO6OFCNBRtPvsAI4I0AYJXWjkcwrEfzPNRYXyl42lD?=
 =?us-ascii?Q?3ub5Gi/5Cr2BxmJth6v37z1JSsGfgmJSrpXcsg2amtysgwHw2QUYdBxT1Hu3?=
 =?us-ascii?Q?R+j4vltkAtunvEi/INmKuIh341MQcYOSnJDT8hf1QrnUweQUXIi3TuQxmXIp?=
 =?us-ascii?Q?nfxXsODRGTSQmXpd9P1lydxV1uf2jn/Ol7REGzWNFMVUdndI+cEY5s8+WBvC?=
 =?us-ascii?Q?izzP3I8m1gVOSvzQL74UhgLixs5HQC1cOigzvSTQVtEDXxNEoRzJBpXuq0Hr?=
 =?us-ascii?Q?jRZf+/6qKWBAnfwMiZLyVvX03pMoIMzl9Ml1FUddK0QywIjMkLUNHElZcAZD?=
 =?us-ascii?Q?rztJRWD65qGKyM+gX+3KQ8sVWYoNZX+p92m/jSmeKVlF4CqVXgcjzIvA4Ijy?=
 =?us-ascii?Q?MMeTAslDoL1nSPO8uQOT2ynBtzbnLicaIEIbuasGJpSU9+ZZTTu7aUipYPao?=
 =?us-ascii?Q?UTO8bN1yMGJQMNk30Di403gJSDnsBvXiY4IxJv2euwmE+4ED+8Pm2Fvn984k?=
 =?us-ascii?Q?KVT/TaGNqnV+knwl5tI8OpfZaP8dFUR7+F3Ms+ZlmpkFYCNBf1HKI2pLS997?=
 =?us-ascii?Q?pjckelhXwJtSGqBuZJ5wqky5vFxVqFCdiS5/Fk57vTY7QA3IDneAW28xYkXl?=
 =?us-ascii?Q?HUKAama27p2BQ4VB4v9jjDPbaBbUkDDBYVRjo+qMas3US7qF910CO6piFYgP?=
 =?us-ascii?Q?iVvMenpjSSPE3rhaIlVLuP3SR/39t+XFzajET49/sELmwAVXYrf/9USN0Oex?=
 =?us-ascii?Q?lcJmq4TTXhi+rBixrhtC7XWeiwrglpj5Y21mBeTniwlqGVFaQSBNlQAOMuWK?=
 =?us-ascii?Q?UyjlXCfXJ8FcdGy9mD08BtPXQiWxFbFZGT01hImrT0oXu5NlFIAWpn+Oyfvs?=
 =?us-ascii?Q?P8NZkFazuVVPVeeXd8xuT1QveZ0FZL2JLBjagiosqhKciFw22c0e?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab15e839-b530-4fc4-b4fe-08da2873932e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6329.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 17:30:08.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2UKoU7Qe5dSztGiscVzRHgumprbYjsLIRI+8xYAfKNa4G2hNZNnujaddhdmnmRAxp5PDzEM728ZMrvRlwcv66/roFm2lx4DQzTFF85Qp55f9onayNLZD1qS50j/knGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5782
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Darren Hart as Ampere Computing's ambassador for the embargoed
hardware issues process.

Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
---
 Documentation/process/embargoed-hardware-issues.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 4f9efae02b6b..98d7bc868f2a 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -245,6 +245,7 @@ an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
   AMD		Tom Lendacky <tom.lendacky@amd.com>
+  Ampere	Darren Hart <darren@os.amperecomputing.com>
   ARM		Grant Likely <grant.likely@arm.com>
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
   IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
-- 
2.34.1

