Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1776597B40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbiHRB4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHRB4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:56:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CFEA00E2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhMNc1p9e4l238oJEqg4jcLPp3us2/437PmnUVmRA3Ui5AkrwlM987I+WYv4feb6PPTZMCyfo0sugYZoBKrRTGwFDALFpBquGUa+DjfBkZmEI33QpHYbDj51tWRwfuY1r6sQtpN4XFrmA2UBTNBBt4ehy1mBc4gB8y11p6TW3iwoD4z0F7HKUkIHrtaBibIm0uUFiSG72GNno4OwA/o1tblGT+l/kOUdMSnGTKuNtpapJZPFy2Ht41qlNnopVyfooohozooqgp06jGes22HxpInGHj50sCVElrTgo7TpZ115kfMVeVfyx2xCOTRWL0bzug+/tI/Uf63Syu74935rBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76IQdPubhMWITmpzgq+05WjE3ITgDSyIf3LKiC1ibmU=;
 b=UkgnkZvNyF0TMj8YtG4vVg/pp/8h00DVR7tntXyL0GyLttGMfB7mamoYQfccLIklDsmRNK6gA5vOyiDs8VMQrzgkRJT3ZJXShld7+iUxC/nzMcH6P5y25ys3MGVUZ83xIbgazviepfWDmTX6fq8FFZ265vaswEjRv5NcUo8shD13J4PqrkwhpbS70ZBFMrqbz54giRx8tmvNjO1O8W7plr3BBda72aHm4Mb1qZ8cPJ5mnXwBfzb5qABMM6ftqlSDoJO6JOuqmPZ9su4xRIU9+1Sb8Rr80XPZmcgVGpVLv+nbLO9ShBv5qTBdf9Vlj5cD5cn2qY942YXj/81Nlal/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76IQdPubhMWITmpzgq+05WjE3ITgDSyIf3LKiC1ibmU=;
 b=UZ2zgG+fHoxWIyGOsPkZXeO/9pFi6IF/+VygqaSEpHRJCbxnlcD+cMtqmqxIzVpLCnrEzYUaMBRnwU2ztPH/lvO8oRYByqTA9gM3mfCcW/vlGRu0HdfP6i/OxKO1gWP7R6WbLAgqo8F/N0HD677IJWkg7cnTYlPoZDZuYjB815XqDrnv5z+fgHyWxNv7t0tRllvPz6mBdnEiNxuGqA6w7x+7xB7apucAmdffPiWBB5F6Gnme8u2sf3dkFiqvgqA0hOa3zkzyme5RgcjxulQXCp3MT3kPi4Jde4YZx//GluAAWCnaS0jDcWImYJacG5Asas7LapiGx7wid5X4XXpj3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 01:56:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 01:56:48 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v5 1/2] mm/gup.c: Don't pass gup_flags to check_and_migrate_movable_pages()
Date:   Thu, 18 Aug 2022 11:56:22 +1000
Message-Id: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660787700.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:a03:40::49) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e53ff4d6-ba70-457c-b645-08da80bce955
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UX55uI7KKIsvWzb4FHZ2lZDP4N2dV9cjrNH5q9xrjWpXJlqFIhHlBWyH2GViw59OVfqmJ4mmjjVKPf9FjqJHqkDwyDZTms4X512IHXdYkWz/OwrIUSlow8zqaUVyXPJ0ft/s4mAJrJo3x8YanD1OPFGul72r9kHa9lFSnlOglP0ieoWYNd3Hx0t1UpwFh0Gr3ixnx1a528fCGNw0bT6Bc8Nf7w9Pjf4cRAwRWct0Ue9+Bv73ZC7cgWEFgv64/bYjagMjqrDL5n/MY+amwxAcYviEY7XtlxzHTYvDaX25RDWVAvkfA6cP2Qn9PnfZz9vWtawKPuOMS23mqpYJ/OsM1YMxvROiHG+LB24b20y8NP5TaBxWA7zhY25BEBc8bnBh0jmMDBV4l5352GhqycPI52kjn0sOxjdiAsDYA7iVd3jpX+e0sRPYXVfiZ4K714M3jjy0KY5TWo5RurIFJAlxJckoJHjyTv9tf2I2gy/NGwdPKAlx0F69LN5ufF98ECJcUazhrxJfUjuiHT0EkOVFAzasBbl8WwMH2U0heyF5fJ440v9z9ltGfEB+c84XVDcXlXSU3yHG/K3yfCcOaknvSzBMN/gvh9HTdIaorUore7LUmUjytJVJHE7/vEyZ2rVmmGBMZY6ct5+qykkWuVDUTuMLPaWMt2MFOuUimf737oOoex/FafxWvZ40R3sLMt0zZ7ZEr9Xu7GqZdpFWJ0L4MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(5660300002)(36756003)(478600001)(7416002)(6486002)(107886003)(316002)(6666004)(54906003)(41300700001)(66946007)(2906002)(66556008)(8676002)(8936002)(66476007)(4326008)(186003)(6512007)(2616005)(6506007)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXk0dVkvz7xIAbHRkSjIgVXneuvzTfWUdr4NbyWqqIay/t3UkNZNxbC96nMB?=
 =?us-ascii?Q?DVqq9l+SjKCduG44C6aXWjMipe4LNkRHkAhEBWl8v2Qj2kxkX76GVwiEIsy7?=
 =?us-ascii?Q?bKAGybLEJEwMYfAQUVA9Q/HrGrUXdI8pEgjuJeQyCuUxu8LD940WohpjpIoC?=
 =?us-ascii?Q?Q1TNv8KngoUHIxeAmK2yOoLbEDKCzvmzqCs87SOjhhHWW+oNxDI17S5/Qyk7?=
 =?us-ascii?Q?o+AWg8IzjW2Dn3ZIY/ZeHpt4jk6e57I5/bQ0Jo27OMT+3TEktVl22Il6SMzv?=
 =?us-ascii?Q?97DQVMY2CMsWDVVJ4HsEriOz4bf8OloOFDDd7zpUO5cJ/QAU3AqqXvGGBj6L?=
 =?us-ascii?Q?C9c/dujL2E5PGkwEiX8/kbLtJwf3cCq4YqKolOZqTxwP2Y4C2KI/RMahfuE8?=
 =?us-ascii?Q?+4n974TALH0EDnqe41oOttT3vfruXviGKkd85oUEcSg/nXnBZxNVxK9HdSVJ?=
 =?us-ascii?Q?fXhk61dC+NryAecE59B4h8Rex0i2EsOvoeoVqPO04xF5XHeyvqWwF+JHdiPi?=
 =?us-ascii?Q?f0PiBz1XKXREyFNSpgSkPbFb+RJ+gYNxzYaw+YNv47eTGOqcoQny8XQMUBlW?=
 =?us-ascii?Q?PVRYpNAgh3F2ObEOgV9LLjK3AX0pjQyx51BHq0vHFXsnpgubEVQEkUhP8CXj?=
 =?us-ascii?Q?9yp82OgOFCJPJv8eQJ4z0P/MTR/72pCHYPQI6Q0+qIFNjTiWX3vTEKSmfcp1?=
 =?us-ascii?Q?EWMeW1PlHywsRhdCWs0tiDgz1eUlFI6ibdP445aEoaC9CRxoXX53mmwiNwsP?=
 =?us-ascii?Q?keRB1gYZc38vIBp0rPtTrDCiFHS0T0E6LikSwN9UncVNI2cNkDGZ3JQaiZQf?=
 =?us-ascii?Q?FgjzSQsccmXj2fFitluEsYP3G/o7TxdOUtn24q+r89lHVc/nwDammrjG8W7M?=
 =?us-ascii?Q?l8WwxN/ui2vj19w8UzUrVj9kzFBUdrnPAbsDQjdpoFLXKjYxMLnJZHyP26kD?=
 =?us-ascii?Q?JrOYVJ9wT+dTKa3CHxIcSqIL10xyCHAC+OGJkF+nHE6jlom/K+kNp4EIDrLQ?=
 =?us-ascii?Q?W073cEYkKIPKQzKYSiL46fWJcdFr3+k4ahtBnLMRUVsVRuVa++Cg0+FYaF+R?=
 =?us-ascii?Q?Y3IJzSWqp+U0fGXpH1gkavaFWiNbntj5f+gRFKsuUOJyVOpKWcQlGYtnAj99?=
 =?us-ascii?Q?eKRfIODky1rkc9RFp8cBog2PfBd9dFbUR1FMjMp77AWwToHev+LMh/HANhYI?=
 =?us-ascii?Q?3ySSVQZMd2yT9/d127bchHdy+546hb26eiYWJJy60k56DiLYlqkMxW8OPC3o?=
 =?us-ascii?Q?7I7eFGhRk3rB+UzENRJnuAZANT2UGZDcCd8+9n3U8dnZSgyS8ZgKkoms+QND?=
 =?us-ascii?Q?7ZulygPGk48WXfxXnKXySaYC2XXV5ScfciVJpHUeGNL4QepJQbPeRWIMkSBI?=
 =?us-ascii?Q?zqje4I/h+7wPN0UIKpLQ9uTD2sWab2JuVYVId/S3TvexfGutFrCvfkOVhAZX?=
 =?us-ascii?Q?i5/SVORv7DXHUEcAjfz0qI9LDgMCSbo/Mm8nwWode04pVo1M68ewI6U5OEHW?=
 =?us-ascii?Q?4MyqMkkC9R8G6zLEG5NPnkAzjxzeRiIbm2/6BPIY3J8+fTPSCEHHAwMTGpCU?=
 =?us-ascii?Q?QF8PgpFqQmBi9ZrbfNY/s+BzkKFwSQiPJiiFzGRa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53ff4d6-ba70-457c-b645-08da80bce955
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:56:48.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrzoU1GmGql4u7cEBfCOzz88WICsGnlruuzSgTppYOIwAj9HpvaDl2prUBgg4p/EcltM4kHQ9pb5wfDvA/xIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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

gup_flags is passed to check_and_migrate_movable_pages() so that it can
call either put_page() or unpin_user_page() to drop the page reference.
However check_and_migrate_movable_pages() is only called for
FOLL_LONGTERM, which implies FOLL_PIN so there is no need to pass
gup_flags.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>

---

Changes for v3:

 - Move WARN_ON() out of loop
---
 mm/gup.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c6d060d..a2baa8b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1907,8 +1907,7 @@ struct page *get_dump_page(unsigned long addr)
  * Return negative error if migration fails.
  */
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages,
-					    unsigned int gup_flags)
+					    struct page **pages)
 {
 	unsigned long isolation_error_count = 0, i;
 	struct folio *prev_folio = NULL;
@@ -1941,10 +1940,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			 * Migration will fail if the page is pinned, so convert
 			 * the pin on the source page to a normal reference.
 			 */
-			if (gup_flags & FOLL_PIN) {
-				get_page(&folio->page);
-				unpin_user_page(&folio->page);
-			}
+			get_page(&folio->page);
+			unpin_user_page(&folio->page);
 
 			ret = migrate_device_coherent_page(&folio->page);
 			if (ret)
@@ -1998,10 +1995,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		if (!pages[i])
 			continue;
 
-		if (gup_flags & FOLL_PIN)
-			unpin_user_page(pages[i]);
-		else
-			put_page(pages[i]);
+		unpin_user_page(pages[i]);
 	}
 
 	if (!list_empty(&movable_page_list)) {
@@ -2023,8 +2017,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages,
-					    unsigned int gup_flags)
+					    struct page **pages)
 {
 	return nr_pages;
 }
@@ -2047,13 +2040,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	if (!(gup_flags & FOLL_LONGTERM))
 		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					       NULL, gup_flags);
+	/* check_and_migrate_movable_pages() assumes pages have been pinned. */
+	if (WARN_ON(!(gup_flags & FOLL_PIN)))
+		return -EINVAL;
 	flags = memalloc_pin_save();
 	do {
 		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					     NULL, gup_flags);
 		if (rc <= 0)
 			break;
-		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+
+		rc = check_and_migrate_movable_pages(rc, pages);
 	} while (!rc);
 	memalloc_pin_restore(flags);
 

base-commit: 360614c01f81f48a89d8b13f8fa69c3ae0a1f5c7
-- 
git-series 0.9.1
