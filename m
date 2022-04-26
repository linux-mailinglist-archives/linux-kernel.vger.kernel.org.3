Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C013650F1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbiDZHKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbiDZHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:09:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5310937AAF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iur6B5x9Ya56WutEJ0RhJjL19Fwgud/ljumAdkeIjWWMSI7e7XP70eC6GvM9MZ0mEm5RHhuUjYkjz0zs74hX4KkrDkCbtN4DECqdGJW1MwS8RWyRA5M4RSa12uMiyfIZcNvIKkJnPHHObL+XYL9bVoM0VUtGcHqhlNntxBl7jNb1Dgx50D5K1QCp7lLHjdjf/vIi4iS5Wvjmpwnobys0dMUDwoxG+oIZyH1j/IvxatoWeODEjzex7m7YftdsrZyLxYufSzCeMOqL6Sv1auf+Q31xiZUiFwBRC9/6a7ih8c4AIOCzIotqPbLUlWaZPk6FXpJIds8lOLUs1sPdrlrOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg3R3gLlByHbSRJ64IHOFp9RLADHvi/isWY3bpv/gmk=;
 b=FJ64Q9+Nbp6sQXKjamJ9vazGOnzz19R166QfrPa/tOCXHuI0zfHmMo19sEURaDoRfFlGUq03jQJSfjpx4TQ2T3VZL9aQUkGMFufsImGLavgq8pJawhRat4/wxel4KR9F4ctyZMfS3aBAfmOu1Q0ZB+MqK8ioVZ5qv4c2dNV+nyzWX3DkcSxFBDIn/n9zgLUzjjTdDNMpZHn2CSrQ1WYIHyFwBis3h2BKnj+g34725VRvSdxfhzpVOuocHh54l/vrwouoLPgweoJw+YkJktI14wGc9H2PeqvzdTWcF/N0Vulj/LsVB5NzfQd9I1nR4YFehBkS46i+ZtjZepJTkI0SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg3R3gLlByHbSRJ64IHOFp9RLADHvi/isWY3bpv/gmk=;
 b=ev3dD8DCBe1ppyDt6jsJkxop2QGTnTffxrXoEVwh8IlqyKQF7MnFjdwa8xHhGtydczQ2eD1ZMCJtiXH09GL2k7hvPSgfxsnPFWWxyYnskaw63kvOQ/h0sk1DsIcGp404HMjh9iStf9w0BSaL/idE6748wJ6vQXCbrKJcsTC8LBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PSAPR06MB4437.apcprd06.prod.outlook.com (2603:1096:301:81::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Tue, 26 Apr 2022 07:06:43 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:06:42 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, joe@perches.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH v3] ring-buffer: simplify if-if to if-else
Date:   Tue, 26 Apr 2022 15:06:28 +0800
Message-Id: <20220426070628.167565-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5205f3d6-85f7-41b2-b4cc-08da2753512e
X-MS-TrafficTypeDiagnostic: PSAPR06MB4437:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB443733313FA355AFBE05E7B1ABFB9@PSAPR06MB4437.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRLVtLJ6/2dvoVJ/z89W1BQbSmjbqhd9VD5zwja8dxsCKtiGklH2NsiVL6gCmQ2kMeyH4Rr4cj5KrsDpLNHD6odtRbf4pcu1YaeLxXOu1NF7vDDkW/sFokK3LkXu9ADc3OzjYY5xRQ5xv7WY5+ShGjqr+HJAMIJ7knkglh1NPAm1ExGcWf3AaQiNdaHXystDNh1q6uQDZ4eTK1J7PkRuSsnIQoWWK/L/WMMDdreXaY/QkF2QnSV8nZw5/V68qz3RXSYj9xS1JzVjr5E57hL8ktVN0hyZCowcQNrfAtUUsiYhj6mrSCb8+eMHhOzktftGi20uhhzii6zmhRTTunhMI6SZppGCiT0aV9o0c8aUApxuoNFXg33E5J+Txw/gnPHAgf3Vy6+cKDCw4aj4Iy+6rKP21gF0qeqbrlJMsX0W31i/OiPPjS7xYvUE/pV8DAnVpMmf/zykFNjRzIMEnPx2o1cWXeqyWH0jzd76/tXBL5DEeMgJEIocRb15vR7u6gFV6tk4s3yMIBpY9wKJRzpZ5Za0u9Qa2w8XmULtoMUBdsAU4r4al5ne3pHKDpZlPMSttBEoGBmjFuyXjO9rkhsjY5OM2yEMmIefQqyv3er0V2vzXtDpNo+tv9TUBHad/XdFJskuz6k68U+IPSjQAqnUo8goCn/CReQ/FfqVJ+zO7EoHSZRVC3ZiCdaa08vqOvumAvHfCzIqM8cck0w/SKob7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(86362001)(110136005)(83380400001)(6666004)(4326008)(5660300002)(26005)(316002)(38100700002)(38350700002)(186003)(8676002)(1076003)(6486002)(66476007)(2906002)(66556008)(4744005)(66946007)(6506007)(52116002)(508600001)(8936002)(107886003)(2616005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0RI95sX7BhARtD/R+mI5YW2CjtxvXb4fxJQJxjnOW0I2hGDoYCbTmDDmYsj?=
 =?us-ascii?Q?xXjVi9jnit7prUYVDBFSNiqpnubFV5grBO86WChZAUtVVg6LVtbQbu5atkTC?=
 =?us-ascii?Q?8sp3b0qzAXJxTa0RC3Xz42qa+2GMwXvTCuFlGU24cclGF2bgPpMix/81AZcM?=
 =?us-ascii?Q?c25Mr4qbXfsRBUd6SWCLGDgPYuRYsdy27P0O9lmJUKXMb4PR8Pi+I1U4f660?=
 =?us-ascii?Q?v0or8VmilMEcF+RggG7ItXNv7T/eDplgnP47w3JJ+lV1yOXlrp/ci381Mu3V?=
 =?us-ascii?Q?dWrkjPmQa+zvLQH8p9vRFlqrNtQSCgAWhztXkpffZpmWsfxeemkIxMdXf+24?=
 =?us-ascii?Q?LWDh0ZNEcC9K821ZOtp6m8F1ck+5WaCgigIlduBwY2Te2CevwuG5+KaRpNLm?=
 =?us-ascii?Q?IIyGMlSJ0lOLMtnjWKbHZUODqOl6YEJQxNoJNGo3eihRma+7etcHhJSqaSHd?=
 =?us-ascii?Q?07SOexW/KZuidny9oML9PEZWG6oxkLTdcNMRW9w3n355cXqaQ3mWXvPIB7ng?=
 =?us-ascii?Q?6sSMKICD2eDgTkARSr+EYXRWz+HrMgb2HALuqwySarmhJl3oT96rULwhgIff?=
 =?us-ascii?Q?7fYfQWuFCViFvJ5JTxPUZ4AZH/EH5qKpmxzC7VcfPDgCPUfmH3fdbPJXoELm?=
 =?us-ascii?Q?fFfyyCQb7vm+LeGxrAEBqTw2CS3jZJ6132AcbGI8ymcT2wA3sw+QqHHSdISS?=
 =?us-ascii?Q?SpoP6og0UyRW1Xke2bjDObK72raP8mmyqevod5BFpi86cqgcTIsA5PwVLfvD?=
 =?us-ascii?Q?CgXn5Emxt12QCr5Z20U0Xxp+Hbu1qzUd4fv+g/0KGNBOnj9yJJfVbSCRzqeJ?=
 =?us-ascii?Q?RVa1Z4rYU7nPjkDj6MpcG2BvX2011b50F0cPdQvK9BvefvBHUZkmNI3TCaR4?=
 =?us-ascii?Q?qr7SLCYzehfmHRocSN/u6dnWT3CPDIiqVz5OSeBWymAniHxW904k82OZvATu?=
 =?us-ascii?Q?lmFEov2Cc9rK/SF0Jt0uFQpRQvrnKDSwfNhn6iJAPoYPU6KFBoGbHW1fbJBx?=
 =?us-ascii?Q?GZNV8dZ2l6xxX/v0lNiJ8TjLszUStLoJ8/2mbfnzjaB4AUzL1og9a/euGSY5?=
 =?us-ascii?Q?Ylz7wzvcx/Ihzl/ZVqzGBubvFSy/JpcFve2USx4+UpVWBQhd4vzYx+TTc9Ss?=
 =?us-ascii?Q?8YkFP3fioydgLiHN3owWOkxcZu+aFW5QoK0rFya1IR9edFEHHNoLgSM6UYW3?=
 =?us-ascii?Q?ckswVeFGDiHWaZkWw+4WlH1jkAskUNsx+/Ez9Aen/VOFtSZQbYOzb8AGsYiL?=
 =?us-ascii?Q?LIuE1As2QBlIX5yrmkufhUJ4Qe4PDU1x0jeq5aNdXgzHmGBACVmKaAMOKxcJ?=
 =?us-ascii?Q?pzAIF+8QxL2BCAMkMYIdK+LOjb8l1TPVCfGLalXHdfqL0cWJ+KcxYNWaNCh0?=
 =?us-ascii?Q?MCyu5VXMOAQPRvxiz/LfAbJWhkcAsPkg+Z37526czxf93DjMXrApFyZKIixK?=
 =?us-ascii?Q?3zfH2GhMV6d0yS1+0K/wfvMV1Cr+MJWcvtt89X4wNGV5mlO7dIQtsRt21VpL?=
 =?us-ascii?Q?scPX1Nidfz9mekIwHmpfJ64c6JTsa32us9OU0wUWIx0zd7WgG/h/KQ1jquPx?=
 =?us-ascii?Q?f+Bv/DBs3AWiv+9LTuloteZZmhq2HJll0dOd5NM4ndDj2Kl3HXVb86v6g76o?=
 =?us-ascii?Q?tNiLCl5abaZCl7B219+IvPUdhM7SIY7OY/SLfRqKBpxDMBIXij1KD05Flrib?=
 =?us-ascii?Q?81mTXMwRFbCa4zhAo6M8yDUx4v3GsdmqllyOlH+Kv8JFB9VPqVPyjkVkpwgr?=
 =?us-ascii?Q?mQJkULluWg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5205f3d6-85f7-41b2-b4cc-08da2753512e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:06:42.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RImPiTD+l0f0THCLn2tJ7HHp4ppUZx0bkdsQntch8iwWtFDRSQZf27lxNRgFvm8fjVPo8GtHDq8incnSowRG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4437
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if and else instead of if(A) and if (!A).

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Change log:
v2:
- add braces to the if block and make pr_info nicer.
v3:
- keep the original line breakage.
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05dfc7a12d3d..655d6db3e3c3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6011,10 +6011,10 @@ static __init int test_ringbuffer(void)
 		pr_info("        total events:   %ld\n", total_lost + total_read);
 		pr_info("  recorded len bytes:   %ld\n", total_len);
 		pr_info(" recorded size bytes:   %ld\n", total_size);
-		if (total_lost)
+		if (total_lost) {
 			pr_info(" With dropped events, record len and size may not match\n"
 				" alloced and written from above\n");
-		if (!total_lost) {
+		} else {
 			if (RB_WARN_ON(buffer, total_len != total_alloc ||
 				       total_size != total_written))
 				break;
-- 
2.35.1

