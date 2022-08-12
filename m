Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12561590B72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiHLFX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiHLFX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:23:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3DA00E4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dvy5oBudKnOBiROLKC1x/8Reg59+CaNY4IpKZQAZSGDVRYtN2hkwTFqmJQ4py9+IGK16D+gIhrgi0qsKaCJa4Q/ropfu7+PuDozxpHCT7zXIUwJBlwuQY5cYQi9DW49AR5Yp+crPwsLTJn6HzF3elYDInaE+XOCKgrKA1i4O1kEk0oHsxfSdUQYb0upbqgtc7VaKuBUtJzPoVUBYkVB0MJXFtMf9qLK7cupOfCtEx9hZWLZeHmhvTKW/3xishSxKjpC6IIvlAlXOiBmMOsHSfZ/ZG8dUFImsmyD+AYPNp9FiaaqRABy5n8JL/ObLq3jYupEIYD/h7yti5NPEF7hrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51rvVXCforVG/VV+jnIVuOgd23Hpr3PwEdWaoS4K4Ag=;
 b=PTPt+wTpDUSpwP2bldMCKH4yyt1/aWuT+4hzf0sDIvVFgwvDUnxYad95ckafB7tr0dAduHbPNbKiZ8mGf5apSt3e+vprYTnOxBYjZ4LWU4Gvk3G6S2zuO72cN3dkGDBvIWLHjDYVJtk1MZV99+nm+ZtFmQqujeSPO9OdwStCHgHaMhDT3YNNSpOvp14y/GctGHNUPSDKozfOHrQ7D/1P754xUdvjd3MHZbZvMfXEkCITzhFQjsaH0GjjUe8tc8sib1rZuktw7+z4jw0B+g9ojHpZvG0J3tdVYtQ7Nj4IHJkwm0oIFYZMrQNIV7tyxUgtBUNJsdE03P23lw/dZ5H0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51rvVXCforVG/VV+jnIVuOgd23Hpr3PwEdWaoS4K4Ag=;
 b=WyOup/eT8jSp0HsvOo8t4CDibuFbMl7zXDqHLiwS7USFBzqrTeprs67kcgSdly0UNs38C+j0C/XJQj4oN3+NgP4s/vLKe2vSZqWveRoFJGCzntnK0nFbD/8zTV9DvzuofDwT/OzJC9mKmtUO5k5r0J3RtAs23dhWvhBiRO85K1MEK5555WxLKxT/UMtXlhywOF7xFShKOirHz1MPk15lgQpAmc+6s6G3wjB06X1AoDqicL2gymZiIVwQdseo01QEjJDkifnSdMxoOaeYRuwlPplmYLHplnFFBEcIazop5SjWaXqUU+mg2q3Wvgpv9Y/5f23N0D1YooypguhBTjUjMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB3978.namprd12.prod.outlook.com (2603:10b6:5:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 05:23:22 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 05:23:22 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org, Alistair Popple <apopple@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Date:   Fri, 12 Aug 2022 15:22:30 +1000
Message-Id: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c049e8a-ea4d-4c64-9c17-08da7c22c646
X-MS-TrafficTypeDiagnostic: DM6PR12MB3978:EE_
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEqxDmnTGkCMcmXruL2YwA3gFXLqkbLkJlU3S2HPk+1mKgakGYz0hUdlcCfj19RmX4X32nFRsylqHDFZIzo+dfbuWaYYqQcsptsrKlhVlv5C/qrZkDXa/YWIGXY/91DHeNE6ewiDYxq3V+cgA1HRyLhxsUp5Wv17UL6lCyVxNM9bCV6hLSb7ig+DPzs2VxmZdFsbOx3h9OSR6otIvRd+XqiTNI3dFpuzHCDtC/660UGlucj/CZA/ycC/sPyityWsGTKH8EPdcbQx6X3tdsl1lNNcMhl2YVgykqaSHzbpnrnXyMe2W9faavnIKncBoWiI8gnttj6wz0Pkr3w8fizFS+QtL/TevYmrgEKT+KLHjrzLV+82qBe2HA+G9vLrj+zfcr6Q32TPIw7/X2XM8eGT9+2IktoR3tVflme6URMpEsLsFZ3plfT9Ad/whE4YMhhf05Ct+vNAdEWZO92Qy20R3JeZjid7wJY+uSPND4eNB6/GDH+meh7MHVW21CMjvFjl5fitdB5wroEjVtFshLqHpP+qmC0VLevEaDy3iqcvWxkCJXkXUnOa1aJt0KPx3INNfm6KmhzX4ykOZ8Qd9Rc7y2ydlU3OVM5TwnJDtei621MD1P2e19kS77X/HHoESeUO3VuLLGQC7UMNgQCTtaPnQLVo4NypW3wwCkfnrwE5mrh+JxwZCmKeCCE4vwgaUlQxBGfgMEuI8Yd+DRexlJwSDbRXBWjZvzva5CPSUau/MDmqG8STBjNltUHENXa0h9T65/h6pJFE37fX8XMiz6AfvwldPz2wau5B82+0ImukwhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(5660300002)(6666004)(6506007)(41300700001)(26005)(6512007)(8936002)(86362001)(66946007)(316002)(54906003)(478600001)(66476007)(6486002)(66556008)(4326008)(8676002)(2906002)(36756003)(186003)(83380400001)(7416002)(2616005)(38100700002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6v+vMlQXzvaJbQolEmbNflt4yfX7aFofHGyhM++QGIFQeaIFv7CSciF+P3u?=
 =?us-ascii?Q?3/7O7ziuxvxVfCuYTqXL19KrrRsa13UV+lVsIylGzc/Ierly5iB/gM/wEDwz?=
 =?us-ascii?Q?QmdYnuspGpLYI1hrg2+x8u+QzS8ndOiETC29HpHHpcUAR48neThnCGgHXIfu?=
 =?us-ascii?Q?YYoJDCxBMtCmKO5i6BcaJrYSYkTGqbhbLGDybC7TJZmPwnBFreGPa7NF358f?=
 =?us-ascii?Q?6rnYos3Hx4NEBuWKz09bKhjT+zMHig0VRJJUGjOoI8Cddf8tbcen3BRIu/Wm?=
 =?us-ascii?Q?z+syZn970WEVDbPEKlq2GI0YnvJTe2Gu+uVvD3IVBcyQwPu4tGPryAg2HpLH?=
 =?us-ascii?Q?MMc7fnZRkkdapz3jPUE/aPZpcYeucu3Bs9s9xCwWxGvs4L11IXwMIPiDhR+W?=
 =?us-ascii?Q?HKIwSwvOLXJSOOlUEcqvIJN5HjVRA6zfmPsU0oDWPhTc3leMOHCkA6vV8/eH?=
 =?us-ascii?Q?r9el79EPHORm8acRpttSZsyA+Zl/OrWjURpll/GnTNpRrUSPYUa7GWkHZthB?=
 =?us-ascii?Q?n3QaJcsPi3PHUNnFwWQxaIMjDHTA9Rz3sn9ckIqyNioZmHTEAIfrHq9b2fYO?=
 =?us-ascii?Q?IXhNc0o9X+gfObi7PiUNDma6nG7BNVbmzD5Xe58d+9UMKtqg/2dcBFekIcdS?=
 =?us-ascii?Q?i5PVmB15yZtRH3OCCv3yBQ4Pgy1chcoNJrDScv7SI1W1x82/WJJwCNeEU0Y8?=
 =?us-ascii?Q?EC2xOUQC3Z8uvebUCCvMC8ZjraiwIM/xZX+V05ty22MpgSjU0AOOyJH3FN4Q?=
 =?us-ascii?Q?Cb/D2sqQ7MoTpfBn9pF5sJgPqT8O9YuYPh1CxtgB06lw+J6Kpq7Fp8GPWfx3?=
 =?us-ascii?Q?COvH61zFCUOjhjq1iYzaUK1FniZY60THAqjV3rPvQFKB7pcC4MY8kN5PSLps?=
 =?us-ascii?Q?qSX7lcuuOqq/poOHhqjzwMctiOKEQCevC1kPJpxbaf72buE3IS4A2btkVtdY?=
 =?us-ascii?Q?Q65NhPjalvEPWo21IsP7ukWJMjmz3aLEp2zD4u3xkLyjiOQacOTMwJJ7eu7G?=
 =?us-ascii?Q?zuywhUWsdQ8aJH2SswS78h2Vc99KKJM7Cit83xBKD9yJHO4gbOV3j1L73img?=
 =?us-ascii?Q?evEymKZn1EAUQaxiQ0UtalDN64ujhxKgxjalofZtEgr1qUk7vR78t6QB3dDy?=
 =?us-ascii?Q?n6INJorN+aVF4v92WM56N2L8suD4fGv8DusI8w4z65xOzDlysB/90HMBh29L?=
 =?us-ascii?Q?QZ8Rp3UlP5aa8ZWUAM5FSCf9Sw6EcWzvtkj+b46GrYxPzhF18C7hjbBb9Ddf?=
 =?us-ascii?Q?MYy8WslNPCA1iofcr9tsrMnhAAvA6vUrVfpj8hAm7/H2lAnOug+pPQQs8A6Q?=
 =?us-ascii?Q?RyOKiP/R8Zk23aSqnk8YI6wajWOG1npuUxE7XLJrHkkU5HdlrFavaGNyvnlw?=
 =?us-ascii?Q?wCvOYfmo7Vsu3fe7fjke0ZI6S4rPce3XlWK7FGCHFrvaQzbQbQ2hlebsAEyU?=
 =?us-ascii?Q?CV4ZVQ+niPqzG0tGEPYBurTKHQeLAcZ2C8xHj0oa21SnTMctYZBBuu4VxbZy?=
 =?us-ascii?Q?KPw/3M0I3yruqfrajQF0G6VATcuue2eJbHQ1T8hHGIqvN+EkkwBxhx1t1/ha?=
 =?us-ascii?Q?Cl8yxfNpNb1EAMJUCFKoQsqbg04kLe15rYsCDxT6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c049e8a-ea4d-4c64-9c17-08da7c22c646
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 05:23:22.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FojY0PWVXMMSgYG5XSWloU6ebwTYWyYRbS+oPpTh6qg5GvFfFM8e4lzn7255JF2EDXpXjkupyi7dVACL1tcpIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3978
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migrate_vma_setup() has a fast path in migrate_vma_collect_pmd() that
installs migration entries directly if it can lock the migrating page.
When removing a dirty pte the dirty bit is supposed to be carried over
to the underlying page to prevent it being lost.

Currently migrate_vma_*() can only be used for private anonymous
mappings. That means loss of the dirty bit usually doesn't result in
data loss because these pages are typically not file-backed. However
pages may be backed by swap storage which can result in data loss if an
attempt is made to migrate a dirty page that doesn't yet have the
PageDirty flag set.

In this case migration will fail due to unexpected references but the
dirty pte bit will be lost. If the page is subsequently reclaimed data
won't be written back to swap storage as it is considered uptodate,
resulting in data loss if the page is subsequently accessed.

Prevent this by copying the dirty bit to the page when removing the pte
to match what try_to_migrate_one() does.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reported-by: Peter Xu <peterx@redhat.com>
---
 mm/migrate_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 27fb37d..d38f8a6 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/memremap.h>
 #include <linux/migrate.h>
+#include <linux/mm.h>
 #include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
 #include <linux/oom.h>
@@ -211,6 +212,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			migrate->cpages++;
 
+			/* Set the dirty flag on the folio now the pte is gone. */
+			if (pte_dirty(pte))
+				folio_mark_dirty(page_folio(page));
+
 			/* Setup special migration page table entry */
 			if (mpfn & MIGRATE_PFN_WRITE)
 				entry = make_writable_migration_entry(

base-commit: ffcf9c5700e49c0aee42dcba9a12ba21338e8136
-- 
git-series 0.9.1
