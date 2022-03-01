Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C74C7F56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiCAAgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiCAAgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:36:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BF838DB4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cdw6yBYSavgk0bYLGEqnRZei6+HHd7f57u86y/Z/FwfHvMdePjDqC8U4E1Vi5kbzFxOfsVYmm0dhvghzdXCs3D8U1Onc+hw6Ug/qj7pjqySRONQT17m53VjhErtj+WnetxeCNWlr/2Y3WkKkDfHDw6XsL9PErUtNcvVGHSlllHf84qJWeH0Pz+Rh/1xW/RxPA1fmP/LNz3Gv3j0lanZXoRMC5IQsNwOvWnXe5HXqUjX1SqG37EqseMk3wi/s3Gfv6yOvbdEDB3kzO/3ekdc67sblQUjnmFrJtu1nPAT/jXe/rcERdvhr6UItLrPYH8/JA8XLgHoSkC0LBNndIYdt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAF8vFjLNhJbEzDGHKCXTxjvVKKIXEDDQq9K2TSV6b0=;
 b=m/G20gXGLIrdhzLK3Dp3hbe1HRaJRVB2E60UJeM5LAwLZ2ENAxrO3BzBaWl1ULITss15nlv/sw8VSgp9zNJn2n4pFuqfaM+HZM8V8Kj7QH0It6CAVgGLJzzNRK0MZzSnzOCv923Spot1z2HfvR4eWpCxvSx+ftYpKgZ37w8wrdDb15R5wjtPrqUDFhKvPLgqR4XvhkWo8m/i/2PTddkalnSy6E222M+Tky4GtrwgSXByyqW150mfLVexeCtttfD1N7hMSmfCtAs1acC19Ee2KPiskxxjZs4SzmYaq1Y66hURVz4cGW/Ly0XeCsLOyRr3sWehh6vJqCBQwMvHVcD0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAF8vFjLNhJbEzDGHKCXTxjvVKKIXEDDQq9K2TSV6b0=;
 b=FIMVox74CjEW1/0q2Hgp8e5Z2Izp0Tp162GQyPZHdWySJanlSXV37KMDONZ9Xyy5iAOZCHhn17m545Jm/4Qj219cmj6P8YZYvO6MIh9hoWZEMhoVUSbVC/uwV95WMEI29+2+up67Ox2pWjeU85smo6qFCDwSVZf/H2bXeHYzeUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6329.prod.exchangelabs.com (2603:10b6:806:ee::12) by
 BL0PR01MB5219.prod.exchangelabs.com (2603:10b6:208:33::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Tue, 1 Mar 2022 00:35:22 +0000
Received: from SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::7cd6:6594:ce3c:6941]) by SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::7cd6:6594:ce3c:6941%9]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 00:35:22 +0000
From:   Darren Hart <darren@os.amperecomputing.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Arm <linux-arm-kernel@lists.infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "D . Scott Phillips" <scott@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH 0/1] arm64: smp: Skip MC sched domain on SoCs with no LLC
Date:   Mon, 28 Feb 2022 16:28:59 -0800
Message-Id: <cover.1646094455.git.darren@os.amperecomputing.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:610:5b::39) To SA0PR01MB6329.prod.exchangelabs.com
 (2603:10b6:806:ee::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21af4431-a0bc-4e3d-72db-08d9fb1b5e3c
X-MS-TrafficTypeDiagnostic: BL0PR01MB5219:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB5219B2CE915B34DDB352DF86F7029@BL0PR01MB5219.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OQUBS62zhfATWZrqksXevokiKtD57uQ6ajkUwSmtk+NYvI4KsqWovFYu5+g1gwsPU+o7/AvBFuggotoOhGN1T/s7YywPtTMjOQIUpgZaBdw4vrOYIDhq0W0LuO7arVQ815eZz7Fu7QSnikUIIsq7Q+mdiFuAnyEoOuAQyDrg5qs6LMFArAyMMkZcP7WX22tY/W4t0i+uTVJ7Cwla2ucJbCaOqb9JdtcJPeVrg9tuiPtQ/qfQvepXIdMbo9SwBl7y7O/PcxmL6QPkD41BOFqnjZsfVbAT88L24cpCNjgnLo68vrma1LUkAKKrpPU3KnlT87nJ3FisNyP7OApZYVr2XLk4xB1EhrIbUPTSCPy3fszX075X+OnIX1EHbUKlSj1t8sVHGfme4oSqgHkP2WA/iCcZx913BG32VFFg4nEYO9IWWE9jx1nDzOcIqx6UKA9XSqC4nuCtWK34s9ovdqWPQjrrYs0WubR8Sgb5GV9pP7LBHdXkHuC6j24RrDhiIMY4Y562YifADQ/lnDdV4N0W/0V+/8HwtUX+tCIX/aFyHNe1oSmWgMqrC1Ki0WKTG6Y5aPLAhJ+rFcNYb4JGVKS+tot4ROdft0TsX/9WLXekWKg4+0+ssqKk9QimhobzBKSDQZDLe0/X9d4jMV9B1uSupT5Vb4w2L/h1onsgXTdscptjMXFoaWF5XgY9yOCHl5Mr4nAgRFpRouTYfc1ga5uvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6329.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(26005)(186003)(6512007)(5660300002)(8936002)(2616005)(38350700002)(38100700002)(107886003)(83380400001)(52116002)(508600001)(6486002)(6666004)(6506007)(110136005)(316002)(54906003)(4326008)(8676002)(86362001)(66476007)(66556008)(66946007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FxkO9L+QNr8R8vB6WOpztgD+KJb45VltLmggoiUcNGEaTRmwPv2Vp/juAw+A?=
 =?us-ascii?Q?3/ZFAmVic/sJ+XKvyQMb7e2bSbpre28GUrvBBNpArGQw+JC7vsBAeEk9v4lw?=
 =?us-ascii?Q?0xNOnucJ9BuwfcFOuIm9mdPe1qkRpGB03cKyMLH5VoJKQzCYSZIQuitdxzYw?=
 =?us-ascii?Q?pI2ifW9ULNpHjDa/Hs82t96Q9Sym5iRcPtAyaljdMuc9aEdAmDKVtXOg3aEn?=
 =?us-ascii?Q?KDZTWC6+IucA7919vUKj97N7furUpzimCjroK2wSlqRLCJAgWwB+rhReU4Ht?=
 =?us-ascii?Q?du7PvwZMSJDMWtZ38oXDe4sD+2kC/4TOUT50+mAvhXcrYYpmeaNjbSi3+x9r?=
 =?us-ascii?Q?d2bgmyxQ7nnqqIttfsDw36aDutXIBfgUG+ew8c0pGapvp557bds3AhZIcS+6?=
 =?us-ascii?Q?zTuxW7pW2tI+NtXIPChCDJ607zc5nmaf8tK8vcCV2wRmrlLuNwI6AYMZDaBH?=
 =?us-ascii?Q?/AsM3DCR0X24XZe67lRvDYmWGZC1FKi+GYG/VVnxLshOGHTSYml1OjVfGZQ0?=
 =?us-ascii?Q?Eh1rt/5KUb46Hs1Z61Z8mTnhpjkUeESSqsQyM9ROEdWkvbrB64T127+9hAeW?=
 =?us-ascii?Q?tMtKx3l6ENGEUOXCDOu2v3TE0LIs3MFDtwnl8Wxp/l+ksUbGYasWSLkxdAEa?=
 =?us-ascii?Q?T682jVz1doqplxzMYZGyzLiIIY7K0g4S8f6lB1nXJ+/Co5Sp3TFm/2ajUmMQ?=
 =?us-ascii?Q?ogLcSiQmh1KELYBbezaHnr9jN+iyW7QReJGSTDIBM74WBe4OOztixN8hjG2D?=
 =?us-ascii?Q?T35ypPRkUkfZfco7vW9u/P6kQdAmm6x3A8I2mlJrhHDOss1YmO8APt4dW+Qg?=
 =?us-ascii?Q?SjVb+3Oxa0s//KpBtAn0xo7lknUSndGRAR3rlSJq+PF8QbjS86tQK0LQXlo7?=
 =?us-ascii?Q?SvXZpQd0IFRbAquhNHu6xN4GlozXdCnp9hbynXvO3lPMIqp3GsijJhMiYiHR?=
 =?us-ascii?Q?mC3XUU8wOlHmKrPhdFKcZYW5P+xF52TwHL02VfCIqj01uN2lc5gjVlUaCx8L?=
 =?us-ascii?Q?5kiL3Lg8Q2l9E/1mnmvfL1vrgd7Uk4/sVWn4Cq9l3EQLScZbxYgc7bN7Kyb2?=
 =?us-ascii?Q?YesCHAu9mvkyYW6KsFADXehZixgvM8/ji0kzRNcwWn9SEWIooyrhibGx0PXE?=
 =?us-ascii?Q?Sij7uW4oPHbIVlMkb0JywICJ7xe0do0F8S+x0tB6tO87zP8H3tHa83xUAtap?=
 =?us-ascii?Q?p+W36SDpF8lN+EXlQcvNuU6ZJB7dOPjRbvxJGIXBSpkS96uZ1BnJlFd+LyLE?=
 =?us-ascii?Q?8YJYMkVP4g9xXSEI99/3+Lyiak/xlxPwPEIkB4WuFTYCgfjRPAr+c128BpDs?=
 =?us-ascii?Q?1pEE7w5v6R2bQgsoEFXe6wZGDSfWiY/GbjU2c6ONXKghkSuZZAr9sKftkq1o?=
 =?us-ascii?Q?WH0Mpkcnu7ePxTfTAZm2/qhAJYY+4GnGDZ2ykG2SXB+KMukFbEf0JgBPUDka?=
 =?us-ascii?Q?v3My6Qf2ttufsVvjfFrYLUrpaLA32XGqiuSnY5u8ZLXYP1RfE5EkuX2m4rMs?=
 =?us-ascii?Q?2BEbRYvpZkj6F/S4I7iG/BC3qrIWcEFGxMvr2Ya+h+GBy6BHNtLcgd4fW3Qj?=
 =?us-ascii?Q?BXAutaWEnwg7YlZLP4b12hNtE3Q2H9kSjDAPiUfMq/wXyeykXnLJ4GmsSKL8?=
 =?us-ascii?Q?7oFiYU9prjMVQlucl4SIf6RtzwShPlyyftCLL+mVhL+X/yZLgjD6rmYav6nl?=
 =?us-ascii?Q?FY9wGLg3cwrkH+2viHZinfoyAUEPLeDaMbULSE/b/VeWGAWjCZB1bFzAviyL?=
 =?us-ascii?Q?l8AxcADxgQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21af4431-a0bc-4e3d-72db-08d9fb1b5e3c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6329.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 00:35:21.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUQN3eEzugMMQiUwMl4/Z7L+cPoS/5tfaoB8TrqtwUaRZw81MIxTXjRGnkqCeexLEGqq3jQzAw0vgYoTvyUmI+lrnPgy3iroJuheQqHLpu4yP9KGNFFzq7qXTPv5gSpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5219
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the feedback from Vincent and Barry, I wrote a version of this which
performed the test in topology.c and added an ACPI pptt API to detect ancestry
of cpu topology nodes. In the end, the new API felt forced and was inconsistent
with the other APIs, and the detection loop was pretty ugly with a lot corner
case cleanup. It seemed fragile and not very extensible.

This version follows the approach taken by other architectures: wait until smp
cpus are online and take advantage of the stored cpu_topology structure to make
sched domain topology decisions.

This adds a single point to test and decide on which sched domain topology
should be used for an arm64 system without impacting the scheduler code, acpi
code, or the construction of the cpu_topology structures. I think this is a
cleaner and less invasive solution which properly encapsulates the sched domain
topology decision in a way that is easy to maintain and extend over time.

Vincent did mention in an earlier version that by relying on cpumasks and
removing the MC sched domain, I didn't address possible future architectures
which may have clusters without shared cache and an MC level with shared cache.
In this version, I limit the removal of the MC level to topologies where the
coregroup weight is 1 (so it doesn't impact such future architectures). I also
think that by encapsulating the sched domain topology decision into a single
function after smp boot, it will be simple enough for someone to support such a
topology if and when it exists, allowing us to create a minimal solution to the
immediate problem of BUGing on the current topology.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Barry Song <song.bao.hua@hisilicon.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: D. Scott Phillips <scott@os.amperecomputing.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Darren Hart (1):
  arm64: smp: Skip MC sched domain on SoCs with no LLC

 arch/arm64/kernel/smp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.31.1

