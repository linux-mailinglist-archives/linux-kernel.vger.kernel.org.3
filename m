Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5349DEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiA0KGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:06:36 -0500
Received: from mail-psaapc01on2043.outbound.protection.outlook.com ([40.107.255.43]:43841
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236254AbiA0KGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:06:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF2dSsEoSypiIHQLjPDrbFrHx+FO+S+iYQWGAYF+VORImGpHn+gbTLnNsPag57j/gVE8LOaydVUGgp1U9Cd/eg0haHi4Heod9Jk2bb53tm02llSoEopFt4wK9noEwRg/NRNjlUJWNajKRRSrgd1axcHIs+ayvlO3KOIk9wTU0DOtXFOt46X+0phDkDTQKMPBc0jr1YiQHzKyFf7C8KzjWr6Ld5kL8iOT9RvE3P//Cbja5QTauk2IWryJiJGgMSJm5mKk6fTTlXwdfBQkn+RsRBv/+q/UQAa0vG4Lfnsd0rCfGYBOuxFcMzFYPGSgQdT3vmw7uv02q+JQ40U8i3q9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eDdlRodNT1smNfCpngsTKKNuv2Rs4JoL87AsmEEyuw=;
 b=JrWDEn3AjC9/LexaugIoeCydknGub+YDv5MebZgOxPioOCQEjGOPBc6GdpAXvtMwk3jFUrivKS8mkMc7hOjFXbmFk/wGd6etnFSzoOXtnaFNFCYoUxoaKVdTBsJ0SgzzPIIPxv2z99jdLEfhBYdWq37l/I5OFgdlxobohGbijZHcVWBX86RtfoRZ00XcjYyKYk5mxfp6nUPsvSjigDT3JqOVW1eKm6GQmiWToyxMHkHki2T7kRkav9/qPrlI3/No2uSnyxW2fOwWt/Fs191K4lf2Rz0KRIkPeRlzN4k+x/MMPXCgc5mHb/4EapHn2p9q9gH1eD3HyUVfoeyQw+hN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eDdlRodNT1smNfCpngsTKKNuv2Rs4JoL87AsmEEyuw=;
 b=aiG1Ww1Pc5/tKNJ1M8Ia8P9qXxvV0JLKK7jtbYpUTg/URk6+Mx9yAqxpp0CtU1bejg/TDag8o7exaTUFdT7YJQjkT0wmljIq4R4e1sXF3rReaTUDeZxbG4QDS0oaqECLpEo+NfVISaLENrkd7zIH/VGb3kMzeYu8FKwd1WAc7+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com (2603:1096:4:177::10)
 by TY2PR02MB4239.apcprd02.prod.outlook.com (2603:1096:404:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 10:06:31 +0000
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::10d3:b8b1:21ac:d260]) by SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::10d3:b8b1:21ac:d260%3]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 10:06:31 +0000
From:   hanchuanhua <hanchuanhua@oppo.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     jszhang@kernel.org, alexandre.ghiti@canonical.com,
        wangkefeng.wang@huawei.com, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, liushixin2@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanchuanhua <hanchuanhua@oppo.com>
Subject: [PATCH] riscv: mm: Remove the copy operation of pmd
Date:   Thu, 27 Jan 2022 18:06:22 +0800
Message-Id: <20220127100622.11856-1-hanchuanhua@oppo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SG2PR02MB5379.apcprd02.prod.outlook.com
 (2603:1096:4:177::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c95856c-0d50-4c74-d47b-08d9e17cb0e4
X-MS-TrafficTypeDiagnostic: TY2PR02MB4239:EE_
X-Microsoft-Antispam-PRVS: <TY2PR02MB42392B796981F35C808F5737DF219@TY2PR02MB4239.apcprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +g0OGmQNX233IHgTnW2ESEoYp651zKr8MLTwMSlIyeskWLIIXrwMZqmonJfHKayrAQWReOA7dP2xKlCTkF+p9LgLPTvENwc2HnR/N5FDobNfM3Ow6H03LPFI2oWuHEsdm9680xYrZ4Jc50ciXqqdOEYZVe1/0tHNnGaJ887G/qNWasEbZnhIEOgB5uETB2zHvnyIFyZHugRLGaUpSeps/kcF9EG0VhM8pgl+SR9evsbaXAHWWauNbqz23fyq9mgOtZAEk//cuQwrrE41OaJoJT3v0+6O9tJlfSX1BKkHRNYfweUngqlAFAikch14oDhnKnofVfuGzdMLlIglvVFVoewOhJvvRO/lt2BQK4nkFJJIdU1n4nykRH5jkaDnhgbzNYDKNkk87KD23jJM1/SGu4cXPIndlL7eU7HuxEh2iWBdFjm8WD1eC+ulV+7PExI24PI0GsZODXN7ArwUF3C5BhXKv7v3MwtJQWPrBcnJYRq0K/BxEv1+wgOBja8QhqAMue5eU6udU7kRmEGczUAGEzcO2c+VF58l3oCbBABVzXj2KSg4qrzgapMWK7ot8gVpa97tQAeMyaaqO/Q/QsPfnbdNwviX8AnBMpB9g/EiomPRAKfwTaANTqzSxHKKeO85hdnZaXRJAxgw2JtmpuLPRNEPyHERxEkZYHfaNw+elLT5Ovdtm+EtLb3q2zoImR0Cf7ZSjt2M74BpWZpGoihWdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB5379.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(107886003)(86362001)(4326008)(66476007)(36756003)(8936002)(7416002)(8676002)(5660300002)(2906002)(316002)(186003)(38100700002)(83380400001)(38350700002)(508600001)(52116002)(6506007)(6666004)(6512007)(6486002)(2616005)(26005)(1076003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxsJ+RcVkQzlBaXhPlv7IV6jk4AlGCLGvg4qgZXf1nI61rDGDpoUePuR8Ln3?=
 =?us-ascii?Q?kexo257J1gm/bfQPbXm7Kgj77MPD+E5SZEAHk32lKjXQ6DRQhswDH9kS+1ha?=
 =?us-ascii?Q?rCWHjLaYPJB2kTL1nPplLB6hYfH2l8KETusTHr33kk6b4/vO0fThyiOvmsF1?=
 =?us-ascii?Q?Xn9zPyJbJldeH6+hDCZ57KkmRGXy8lQFww1rsw9LvdqPWUBhFyKIYYrcO31/?=
 =?us-ascii?Q?feULa9KppfQsG7wnKL38lmHrYW3CdmTC27jLN0exyyEgKZMziCE1+jxau3Y4?=
 =?us-ascii?Q?3SvZb3mHeC15zOTtd+BNAy1dSeGE1QEJOE9J87vZkOXQVUoyP0wf8kIuxITL?=
 =?us-ascii?Q?w8r5qwDNyPdFFM+v6JsOOJgKVfcloEv3kuRYXR++tbVSoZPGdo5ZNkDTIR1i?=
 =?us-ascii?Q?tcvfhuQ5u4SN39atyKTvzQgy3If6sPrj5MGoZ0Xd1wbh5mtRQue/EddkY6q9?=
 =?us-ascii?Q?InUFPekNKmMHKmyVsS07tQARZfNqtes9ox21OvLMR0a72kosKCeNnaudCudH?=
 =?us-ascii?Q?hTLG3Ioqs0nQzm6/I450hdzGtyRX2lXBeeY9pHB7HjILLnTHmMzityFmQQa1?=
 =?us-ascii?Q?sBD0O44wUmiJSYo6o2rBd7qe4sM71ZxmrfJgs2bMQP4/6hDTWycl2mIBLYmL?=
 =?us-ascii?Q?9vbk6isVSP9lOU94l7i7F5FvizdsjHwi8vQE7c60R42Q0dA6SyyW2PR6/mLq?=
 =?us-ascii?Q?tZihkJ5JB41XejKoPg1AgispqcdgQ9+R8ShXeg9pN0XTU+J1vfle8CmJX6I3?=
 =?us-ascii?Q?pl7G1MROhGkKGzjApBK8ATrU5cWfX1YTbfEfG77LmyPMCafbZJ5fHjZk1yzx?=
 =?us-ascii?Q?64R19yRT0PyKNThXYe7tEQp1XJaKvT2JS79p3pejszAtFXLMLFrhAzteW+o9?=
 =?us-ascii?Q?vJh2eDR/IEXg9hYt++KTF5B88bm2x65ssB0+kCYBRNLfDfQyEC+myogM6zHk?=
 =?us-ascii?Q?FkjZCd0grNRiZQBOKfGZBBJFC05hNbPMjCSoBJ33Dqf4RMzq5B/Zi8OidW90?=
 =?us-ascii?Q?HNZgly0MfEkVW3pOJ3nQFOS3x3tkGLVIdPAWDk8q8cma9281KGl9rX9VQPFe?=
 =?us-ascii?Q?NEwTolcQL/VD1vD82qvJXJXVWX/qloj1GOhfNAvHQlyoCpBJv50181CQ3Xg4?=
 =?us-ascii?Q?iWtx4RgYqVdKVx5wu4TdTc0uJ4s8m9KIiTm95iTrpx4EnT/78JkFNWUDWnc5?=
 =?us-ascii?Q?TNWnzbuVeZln/0dOiWtJP640e2DknSdXGssO81UMAA2uzRDt/vkOuek6dgs+?=
 =?us-ascii?Q?cC9qNt415qIdXce8gUoWpWyGwu/y8/KhNjpwC9ri3D+hffjWJViYdtyCyGo0?=
 =?us-ascii?Q?gkvqsN2OuTPFlhtvDccLBbtMnvH7199vDbaHUpvhkerLkxW32InktUM+HfP4?=
 =?us-ascii?Q?G19bk0BcZRee3pWglOs+9bMjG1eVqEWZ4fz6ZFN5kjRbQkfLP0vK9PF1wnOr?=
 =?us-ascii?Q?LL3DS0GlqQW7lfvNlt0O/TeaSJighWYeupLEdKxtCL8hjM9B7CTz413R407t?=
 =?us-ascii?Q?MYeqI7z/T8wxdj7b1O9MzNab869uVV3hwyT3s0AyAWd80+qO6dx0jfyO2iVr?=
 =?us-ascii?Q?BSR96lMrzAUO2LIX7B9F5W8vpYqnP7VcYwlQwarr0UUmOcj5H+99LOuqlQm2?=
 =?us-ascii?Q?bfr65ZbZlDLODF9SyxDxmEk=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c95856c-0d50-4c74-d47b-08d9e17cb0e4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB5379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 10:06:31.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPQInN3Sz7ZVGluKz+dYF+x6Z7Qv7H6sxNm6HkiV1oopILlMldDnuJgq/nqfg4HDJwNnoAHQD/5c0LHpj0d5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB4239
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all processes share the kernel address space,
we only need to copy pgd in case of a vmalloc page
fault exception, the other levels of page tables are
shared, so the operation of copying pmd is unnecessary.

Signed-off-by: hanchuanhua <hanchuanhua@oppo.com>
---
 arch/riscv/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 4e9efbe..40694f0 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -102,9 +102,9 @@ static inline void bad_area(struct pt_regs *regs, struc=
t mm_struct *mm, int code
 static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned =
long addr)
 {
        pgd_t *pgd, *pgd_k;
-       pud_t *pud, *pud_k;
-       p4d_t *p4d, *p4d_k;
-       pmd_t *pmd, *pmd_k;
+       pud_t *pud_k;
+       p4d_t *p4d_k;
+       pmd_t *pmd_k;
        pte_t *pte_k;
        int index;
        unsigned long pfn;
@@ -132,14 +132,12 @@ static inline void vmalloc_fault(struct pt_regs *regs=
, int code, unsigned long a
        }
        set_pgd(pgd, *pgd_k);

-       p4d =3D p4d_offset(pgd, addr);
        p4d_k =3D p4d_offset(pgd_k, addr);
        if (!p4d_present(*p4d_k)) {
                no_context(regs, addr);
                return;
        }

-       pud =3D pud_offset(p4d, addr);
        pud_k =3D pud_offset(p4d_k, addr);
        if (!pud_present(*pud_k)) {
                no_context(regs, addr);
@@ -150,13 +148,11 @@ static inline void vmalloc_fault(struct pt_regs *regs=
, int code, unsigned long a
         * Since the vmalloc area is global, it is unnecessary
         * to copy individual PTEs
         */
-       pmd =3D pmd_offset(pud, addr);
        pmd_k =3D pmd_offset(pud_k, addr);
        if (!pmd_present(*pmd_k)) {
                no_context(regs, addr);
                return;
        }
-       set_pmd(pmd, *pmd_k);

        /*
         * Make sure the actual PTE exists as well to
--
2.7.4

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
