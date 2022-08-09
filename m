Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE958E3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiHIX5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiHIX4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:56:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2098.outbound.protection.outlook.com [40.107.114.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA0680498
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYjjJ23IxMtcKUrhK0OSXNQpbzOsudzUAq21urcsGMJQB9D7ITDwuqr2aAAJfaBwq5Nye9WBIK6roT2fYrJIr+aPQVdzMKbELoYSNq2sInRlvtGVj+rB0WxMbUuxgK5oHr8RRWqVYUCISVVY7u1Is2UTlIkHM1eNpxXPlwwyCsqWc98rMWtTUdBg0JW9paVHWAKytc/T3ckHZo/Q1ZPEk47/Jz1ufpgw+BYNEadFZqN67jwRfsNeCBXUDrl0dAsIbgqfnb3wGi35a/meR2EGm7xZwAY0SMK0NzkVsvAR83khZerh2FG0DUIMQcy862TzQg8J2K/aFWlKk/FqH4N7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOosBtrXDEc2hnMY7h6BVqNCPWGQebK783p24L28IcA=;
 b=g3ptG/QzCo60fY5oAr5dFtEt6nYN9MDlqTJ9iCqr5dKzAoc6vNJ8PDQa5nCnV95heGqyKce3hy8OHJZk0b4Cggl2XZP9ix7KPp/BnmBH4OE8nWuPGeSeVp8Tay5PZ16bfzS1CHs2X0ZHfSdffMHv9aL+uwblxANcqB1wnDOLdoG5u/B35rOWuF0HpA60vUI3+zlAi1sKJXgK7k05yQbZwqN/41U4hXnEoAgJMNFQw6r1kZEU2Pl35xBILigfiU6sXS/+ddJuyvJTzE3yTeRblyVzZZEerypzlcvkjjPbvy+ntePW5Ld5cO35aWoNCPFVgJb2MygBJ2QL87hwFLiAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOosBtrXDEc2hnMY7h6BVqNCPWGQebK783p24L28IcA=;
 b=oLGAHhqxFyaDW2npj3+hwgru7AGBfDD2NHSqCc3H0r6bO+PqHHS7ZRrMEZ8Rag10wmFfpRmVN4ehYOe+6Vb6t7W/i4+lYjoVQ2Cmym2L1TkrSIJ9FqinOy2l4qZQk6wTa8UM9d7yzkImasz6AySTdzwdM8F96K8+KZPG2EtKdKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OSAPR01MB3905.jpnprd01.prod.outlook.com (2603:1096:604:5f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 23:56:48 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::cf2:7a63:ffc5:5cfb]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::cf2:7a63:ffc5:5cfb%4]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 23:56:48 +0000
Message-ID: <874jylots1.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ftrace: makes ops_references_rec() inline
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Song Liu <song@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Date:   Tue, 9 Aug 2022 23:56:48 +0000
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18640c26-5f31-449b-3d56-08da7a62d292
X-MS-TrafficTypeDiagnostic: OSAPR01MB3905:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OnaWBHa8OdC8+zSaYZSxlaZjGg5HSZ3kuqiI8N6czHn2qT7HoHyPWVmPqqL29IhhM4FfHLWNmpjduaheBvE140NRbRzbyeADUANpSY6Eo2u0EFel4erF13eIKtveZXDvstjcTOP4D39F1J3qKHRnDc68yOrD1SsSj6g7PvLjm50N3AqGCcbS31Bk8e0JRUtZSXM586FvKfxNbFV/O40G7IZWtuUs9lKaYLTw2x3Wwr8oF9BfW05ySXP6UXEKmPrNVu4NAyaaVsmzASRKxAb44PBtMUePYzUXdmF2cRfZRneDj48AHpzhsnZ0rB5VRsjUmHSgak/zqhilNNjSE4tU/M212rcwHW4so0JG5zoSUo4UBCwyig6+T4N9GpfxtdzJBZM1ZVtRPO4agO9/+52ZcE7/sppC18yzYydszc5qDXYPjhsG82ktkrf2biVoGiQFnhJxzt46Mec46gTMVmzmSAhujvayQ7p1KwD7vjwNs3BfE+ZwWnvEOGWLA6+WzTckhBKSgHF9TVNHbH5wF5h+ql39W+PIA1w8h2xcPZedytJRqgjALimq401O2R6F3s6D2gBumq7Clk/d6NRrJOegTCEK6xxnx1VeQnoS4O6AK0pp8r4dw8jXH3WQbajCyRf+6ZmwOuz6onF5GiJAOXcCWW4B+cbUVcKzgRvZ2MzVkAnrrIzcPQTmaUPWlC2eU0ozz1G0SkYj/n57ZNcj1RWDlGMkwrRO8ce3ryqbNFAApjjaO+PwvXtD1XPw79BcN5gNHTH3msuu2tC4jjUdmpAYYwCmJwHcVUh4avplUTDBGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(6486002)(41300700001)(478600001)(2906002)(86362001)(36756003)(110136005)(316002)(38100700002)(6512007)(38350700002)(2616005)(83380400001)(6506007)(52116002)(26005)(186003)(8676002)(66476007)(8936002)(66556008)(66946007)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USpznFp518QyG3w/n5Elza336/2McKeogHC+DhGrlksCHPuLgF8wQWdTQKdO?=
 =?us-ascii?Q?fRB0ThaA0S2GzejpGNOJ+LeA7GhW/hIBQ1qDXVjYMpbaqujHPHkPq7osZqvZ?=
 =?us-ascii?Q?Fm9Jb7+8HtCGg38B3TprlFykHU9y/kahwtpIRCCUewTtIkpGdfsCk7xAYkM7?=
 =?us-ascii?Q?jIRdipeC95wwXcacSVbykPbrvbsi1B/l9B5xXeZOThX1CekEEpoDWtVa2eAD?=
 =?us-ascii?Q?/QFHOJkgHBC8e2Z8ZNhdhYWkH01rmmYoOegFLyNcuqUlbp7qOJAbUh2J47Y/?=
 =?us-ascii?Q?jUBpbwVLqZpQM4OMRESK/BaA7oEGavE0oaUkMVuzKV/+1aQ4hMxxtJYTUzTd?=
 =?us-ascii?Q?jyPgGMZvhUBmox13zgc/q5kQ1XxHsR8m7JE+FXRS7qdss/O2oKSXJYeUyxH2?=
 =?us-ascii?Q?PtceYE8g1GCaH+amS8fZ5aimrgMxCsZmqHEDTeel7V+XO4Nr9a9KZGlVzRFE?=
 =?us-ascii?Q?j5iVaPwbkj73AXKXFQs9V7ISsyVNGIsxjrKgapG3ajV/zCBzMB5ok6Ywp8BJ?=
 =?us-ascii?Q?XLVrt3WeEbRCP0ymcm59tl3tzHLL/+aE5Kl9seIWkMAuS3WJILimAgVgzW/Y?=
 =?us-ascii?Q?0U2sSOKvhtgjEPOPZAVNmWwqZFJcqdbxwdSoNx8YzUqlZYkXwYtv/4LIehY+?=
 =?us-ascii?Q?tXPRKM6hKn1SKZYTw5lqa6rP3TYxGd4ZscyuyHuDOCRdyI0i6F9sp64NFyVE?=
 =?us-ascii?Q?wS5KOtqFVfpbGQXszaTfq4ML1dlFgY4iQHoKzljJHyPSluHDd4i3aa3QTyAH?=
 =?us-ascii?Q?PgyW46J+bGEpb6ICM4TrzYJozQdSjAhR2coBCoUte308aVKkR2V88W78qgor?=
 =?us-ascii?Q?Ro7lHrXb95QDPL2emD587IKxw2LBdK/8714Wvh2H/0B35j74YH4WFzBrxAxw?=
 =?us-ascii?Q?Q2qdbBHhmzrN7oKW7wDWNa+9y3iAXzFI+j3UxEnBUhF1QTsfV2rwEXiKSHOc?=
 =?us-ascii?Q?dJAPZU+qfXhXh61nCB9prEsu20j3mdx0g0HP6PlGUr4vfISvHnDYjQEYtrH0?=
 =?us-ascii?Q?W9iGNWjvToSFQQFf3+C7Lf103WX9Rc3+6Hk3Gq9KzhNRFDnkhVj3JrVb3MZB?=
 =?us-ascii?Q?qLDRGGTQqfZhRmFD9IvIcaJ6Rq4QXu+hiao5iGJjN+UQ1IISGeAFolgMUJQZ?=
 =?us-ascii?Q?CJnd316kMLjfjk4QNlAGhoAS4EXInavuxx4veQ80OjzehmIQpebq+mmvn2Np?=
 =?us-ascii?Q?F0KNIEWyQ/orRJNuZKICeiCx5Au3EGm+T55NQoaETyaLDl3STNBmu0aItUJQ?=
 =?us-ascii?Q?e7YW41hYEVbeUsPv3v1d671q9lTvhMFszK4umsHOJAnhx88atfhWx3sYNwt/?=
 =?us-ascii?Q?n0bVY7uApianhM205QpDO3J/L182dImPU/dmibkpwUWBZRqrjNJxpDTthF6g?=
 =?us-ascii?Q?I46SuDnxFVn1RjxJhH2deaF5TNe4YQg6/9Au/GiBQIm+ivmDOmrmiUiVBaTa?=
 =?us-ascii?Q?d81Nnkqq2iEJixkjl6kW1+2IKjrhgcP2IpKCHDLZQS3RIUJ1ClRByexDkn4U?=
 =?us-ascii?Q?PSPazB0koaKh4VBz/X7kBFEHspR0knf0zSJhk79WsQ0Dr4q1wV3LFClbw8Uw?=
 =?us-ascii?Q?8Wugm0phFVAdEHJ0uayFwr3pw91GH1g0nfujiOnruL8Q1iuffcMW1VFKHKRc?=
 =?us-ascii?Q?sFupLz4NfVmHzNPmNwWQ+EQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18640c26-5f31-449b-3d56-08da7a62d292
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 23:56:48.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWqMYvtXbdjT0Ex5xKmGaADgRzFDDRqlGJa0wBqLFqTvt4kuE/WI6SHWtl+5vO0tsTWkooQkFX2iOnEv0A/QUKqjc06e96mIRT4syvLDk+lw4hclvSIVIRBh9RXeFoEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3905
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


commit 53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the
same function") removes "inline" from ops_references_rec(),
thus we will get below error if .config doesn't have CONFIG_MODULES.

  CC      kernel/trace/ftrace.o
${linux}/kernel/trace/ftrace.c:3149:1: error: 'ops_references_rec' \
defined but not used [-Werror=unused-function]
 3149 | ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
      | ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [${linux}/scripts/Makefile.build:249: kernel/trace/ftrace.o] error 1
make[1]: *** [${linux}/scripts/Makefile.build:466: kernel/trace] error 2
make: *** [/opt/disk_cd/morimoto/linux/Makefile:1843: kernel] error 2

This patch adds "inline" again, and fixes the issue.

Fixes:  53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
CC: Song Liu <song@kernel.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..b52782857f97 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3145,7 +3145,7 @@ ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
  * If the ops does not trace the current record function, skip it.
  * If the ops ignores the function via notrace filter, skip it.
  */
-static bool
+static inline bool
 ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 {
 	return ops_references_ip(ops, rec->ip);
-- 
2.25.1

