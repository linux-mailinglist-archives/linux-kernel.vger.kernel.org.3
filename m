Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4791847BB01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhLUHXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:23:31 -0500
Received: from mail-sgaapc01on2047.outbound.protection.outlook.com ([40.107.215.47]:21632
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235129AbhLUHX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:23:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB+DxpDLvIyS4G3gSBYYIP01TQ1wO+ytIduOpnnxWQvNEcJfVsOmPLD+LnM6vyOQsP2kLhAfNi9hIZ0wiIPSDDUmuaEqtwN2VkU8PoSHraZsWe5mpdNxL0SzZZ1nWibMFXfpmrarMr/MgEXVH8+2hbzPfI4qR7rnl8xcnbEc22f71ztlW/FMFYKEH3xRssbz5BCMhSLUBvJz0LlKOyJ3URjXv3axX7sw5D5p/QgmN2ioH3rA4qpUTbVRy56773K862cRL/52iNQbMeoLaHqWW3CM7jHiVnqDA/YcFPGApCpOB7+Ngs9kjNw4YuAxRZaO72Tf5llVZH6MB2sRjPuIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61ZbCxcSYEkRnrDTpVANgRC50TTwSixvVJ8I/FmbOeU=;
 b=ToWiqMgCvY/5AmtbSnYRgszdnMwHwWmCGy2MB6d0dG4aCfkw1xsx89HLhUQE3ZB373EAOGwyXpQGyesBqQCWQCKhz7MxAFbw+dc11EaqjD5PhmWAF6jV5RAXH75dY9hp21480YK7Hlk2flqjGYArAxI30xJ7l8mdOMhuLC5stlY//6LeQwBuFpmSz/uw0lCs7nIVdoH3CVDxJVTdoPiOO8spuaHsiNrdGSWsOlrFdkQM7xL6wVc1AS1SShkaexe3vT7l1xjcl0ZSC3bCz9NL5V0YgiIstWH/AjAQ1UL3lD9aBqfVXrD11FjfLWN4jM6CbPZAutnWGyNycjCnDw5IRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61ZbCxcSYEkRnrDTpVANgRC50TTwSixvVJ8I/FmbOeU=;
 b=YZ8LoPyedp8gxBdE3B7EO1GzzPu1fJfNmfZrg5wgkZuX7aCMe+Vwu4pNYTjunkO52aPtw+yKZQGYuIJ2teztrc+ZajioEFd7qn5xyvSUUeBvvjhOQ9Fe/JwyRI7/zWIYgLXdAbyePPZKfsxm1QHmnJ6+8meeoZZRA3kOvJe9hWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from HK0PR02MB2497.apcprd02.prod.outlook.com (2603:1096:203:21::22)
 by HK0PR02MB2706.apcprd02.prod.outlook.com (2603:1096:203:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Tue, 21 Dec
 2021 07:23:26 +0000
Received: from HK0PR02MB2497.apcprd02.prod.outlook.com
 ([fe80::483f:813f:a012:746d]) by HK0PR02MB2497.apcprd02.prod.outlook.com
 ([fe80::483f:813f:a012:746d%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:23:26 +0000
From:   xuhaifeng <xuhaifeng@oppo.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, xuhaifeng <xuhaifeng@oppo.com>
Subject: [PATCH] sched: optimize __cond_resched_lock()
Date:   Tue, 21 Dec 2021 15:23:16 +0800
Message-Id: <20211221072316.42-1-xuhaifeng@oppo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To HK0PR02MB2497.apcprd02.prod.outlook.com
 (2603:1096:203:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f992b08-f8ee-4211-8693-08d9c452c72b
X-MS-TrafficTypeDiagnostic: HK0PR02MB2706:EE_
X-Microsoft-Antispam-PRVS: <HK0PR02MB27066328E24C6EB2810E77ABD27C9@HK0PR02MB2706.apcprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaggwYQzHjtnXyF91DBlQAyE9m8edWsDM+U5y0gao3qV+/+p2PcyQb7rWW1WN2/Kwu1CGAalALu5+Ymz6hYdYfpdGZZcOTsYqcRKjSC9NPHMGYQDqyUlnwzE5MSWXwAuuvjVjWCI5lHfcnlQwVcL+vIOLma4df2YLvRwdnbMNTpcOEexiNvthRgcoaiyYZN7jrVfxpTAB1nyUHBTO+3AXcV9BZnnXC16d6O57u1XtKFBHJx0f1/G/vhcid/UFtfQtydo8yvLn5RytnZf7W0IKcz/F4hzDpPhqcWEkiMsqLhl4jofWeQ5AmAUuCKa7p36oR2oNEnJd1r5TZJR0lUq9D/ZUjGjK9lCa4ZMSFoSOZ2rD8BxvxncWcHFcrUAjm2rMOfkEkzj+GcFLvLjKaffB+c86b8WqBOsRfHSXLIcMlFKyt++Q2r28ExX/f4hx55LsWsvHWXKLurZ2gYGDDcT/oJZNgUL8e6eDxQGTPhJfHyyuzcxRQNL6t+JpPSVFGdC/scEME7V71lfH1qDuAHhxzdGcM3SMzatAHrYd7tdh8X02V0ds+JCns7aU6eyk3HQMBYro6U9p88dInRm4VbP4BOFCIUgnF0T7H4ubifGatwBq3oJfAFKKB2TgFjbVVTtQ2K3c0Tp0VlJarmhls2CbaalFA0WcjAuakk3wXb0B91+PFWqnxCOFzwdfv67/hUCHo/NzQMgP0XU8X+Q9cmaFYtt/s5nK5cQq4Gpw+j0NS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB2497.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(186003)(8676002)(26005)(1076003)(6512007)(508600001)(83380400001)(5660300002)(6486002)(86362001)(2616005)(36756003)(38350700002)(316002)(2906002)(66476007)(66556008)(8936002)(4326008)(6506007)(66946007)(38100700002)(107886003)(6666004)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mv2Siz9TWQQPyhDvtGZLLcfJRijMYyyssrluNasvfQr0cUrCvI9gt1QUv2qB?=
 =?us-ascii?Q?bji/ZpHgIBjuzr4ZitRKePO7RyYc9GdiRuq21hf0kDEsmIVW65WYsWBL+DfI?=
 =?us-ascii?Q?lgHg7C4nLNPjpVUW35PHi5xR4OHnrtJzD7x8pBdkrAWxxZ6c6UQ6dLZiOPTJ?=
 =?us-ascii?Q?wqitex74UmR4ovhmzIETbVkfA2Nhnv0n0k6Nd8bAeGysC1qT5kL5W4sd/peA?=
 =?us-ascii?Q?iRtMbOlp/KEWA5LJYnoRcJL5hcvIM+7D8P4qEI/2eqXP313eVAVARLxMGpPn?=
 =?us-ascii?Q?GduTSySvOLGCeMxzLAiBYKJJLTdmcULTADpgYortbbPJLg2lNHyHV6bWrF+B?=
 =?us-ascii?Q?xUtIHHRxrHJdQmEyHKj2lOBO6jwqWe05nRu1oK2NB6AtcwCrl7WKghAKcaqf?=
 =?us-ascii?Q?6zq3t5h93rlV7qB9Ifa0fee30vhhroRd5Kwu/wKUj9CvJHI+MxH4S28647/O?=
 =?us-ascii?Q?xM+h+zIIZY6GdsM88iUhF6ceR/FH4G41JPz3RkJb5BkS7bVxdFak6PCnA7g9?=
 =?us-ascii?Q?OQhm4li7qZZ1DbDtd5LmRu6xeqFQxVsx+gRrldtriA5hOmHNgwtNGJ/TdFCD?=
 =?us-ascii?Q?R4coPoySJeQdQdJe3+0leZ16STmuEGBGdkzrkiCpGbsSZfEStt0LgY83EujS?=
 =?us-ascii?Q?j/vBOdyUedLs5FkmIzp6fzdv0yYAfPMaBJP1qjKd2ZbX2GhZ2VQVPUbfCWQE?=
 =?us-ascii?Q?rMJAWInkIxlHuI1fHxdxgMRHRliNi/RoIS29IQQ3UKcga/tKvZpzbdZAonbd?=
 =?us-ascii?Q?us3iMnRg+heCWlP1VR4qBVZyRJMfIrXZnntD9/0R2P+TjtTgIESHjT4WuMWP?=
 =?us-ascii?Q?nfUXVKgvxPr2KqVK8KFRayfjVqKCjW1cyVr1NCIu4BTC7n3q035dVwOQNLMB?=
 =?us-ascii?Q?lJZqXJu9yOZZjefIciPDVSD41GS0wMCAODwG2vSvEoWLwDeACx6z6VcuvpZa?=
 =?us-ascii?Q?As3bbinIISAJHl8D1DoA1rKs/q1OGZUscAneLxx6ZRqWh2zkRjpnfmdoyqoc?=
 =?us-ascii?Q?sWc3Kgl/NM5Yp10qUrTIMzZX4B3rESul6hhJtkC18d8gmhiSl3WDv47xd43s?=
 =?us-ascii?Q?uKPB7EkXTRuY2fF4YNIsYKEInk1vNvfDlICDYky8ssNt9k6AdW0jFYnfxfUs?=
 =?us-ascii?Q?jNuC1fAzPqcIJKo+LwFMRRTWyDADEZVgrWkZRvgu8hYQ+8Ed5WSTTKYEbm96?=
 =?us-ascii?Q?JbHYwlahT5yszrtLl1Y5HiGXduMean/EVdfjfEdxoBKYB/QXJtxEN1OOx7tI?=
 =?us-ascii?Q?cfTORdtzwxkBzhgU/vEW0yeow93UQVYUvDE/BxwQ4DlQgemeO4x1qxKgYHWs?=
 =?us-ascii?Q?Iu9pcTAE7AbNnLPUzmOoU0anmuQKfHypJ8X82V0qWsn0o84Wc5FSCFp6EEbt?=
 =?us-ascii?Q?bWNcn5j7uMcyO4l+RaEhPgn8SA4a5e8L4F/n0o3TaLoa/F+HQ9EYvfbd8t+9?=
 =?us-ascii?Q?f6XO2uxnOSmsi+P2HdCoKV30nYjicYhNlB7yQkzc4hAxUl2InQlvBPT8GWd3?=
 =?us-ascii?Q?saOocbuHR4rea9rKLgSjYMbv1wJVTgVNG5E9wHB/wx03wxDo3sL7qQrpvAz7?=
 =?us-ascii?Q?A0gXfRY76Ov1H7cIDpS/N5XnYMbg+tqHS+EJQAO7PU+ufBgFsvDmPY+9CguN?=
 =?us-ascii?Q?H1rJA3svLnJJ8zuj9vbpC64=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f992b08-f8ee-4211-8693-08d9c452c72b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB2497.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:23:25.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryKuW2LaHK1xPLVEKGxp0VNM52aks43rKu0TP6E7DDYZ3cjsT7zXOoeXx1UiQBdbJ+XimQGFnKI0yO41oXkGYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if the kernel is preemptible(CONFIG_PREEMPTION=3Dy), schedule()may be
called twice, once via spin_unlock, once via preempt_schedule_common.

we can add one conditional, check TIF_NEED_RESCHED flag again,
to avoid this.

Signed-off-by: xuhaifeng <xuhaifeng@oppo.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f95a1ea..fb011e613497 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8219,7 +8219,7 @@ int __cond_resched_lock(spinlock_t *lock)

        if (spin_needbreak(lock) || resched) {
                spin_unlock(lock);
-               if (resched)
+               if (resched && need_resched())
                        preempt_schedule_common();
                else
                        cpu_relax();
--
2.17.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
