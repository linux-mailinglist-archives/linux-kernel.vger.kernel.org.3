Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18AF54837A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiFMJeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiFMJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:34:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2089.outbound.protection.outlook.com [40.92.98.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A9011833;
        Mon, 13 Jun 2022 02:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivEmY/e16+u7lrlhqdpfSYxzpPSrpfENs37cyQmy7ySnqGmOnH3B1oTL7ZqsyIGBBzbt6Ph3WEfCx+ogf6k4Ze5FbiKb/MyPQBRaMWWAqI0rMWYkn/eXHSYN5succ6Xe+DrMA+RTLRT71CB5PF43dIINuqAaGvkZE748KhXyme6Shm/10VPn9NXYrGeEVkynUFg101xLGxvusjQ2VTuywlor7GZCibNeEOnZq+Wv9ic7czwdqH29HnYNqPMKKQ9+VBUvMTkAQPjX2/a35oZdcfMtbcUraemMQgoGTy4jA738Nng9au2sIKu5say41k6gtCqzp7A61hIA0vVVwRfPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9OFfVXdgt4omenZi6SlPtoORTKLWgoN8JPA3Z5yslo=;
 b=Dc3s9gqfIfm2DgopxaIhQkdPyORqW9cwDdgeV2XJ+WbXkFLjIi0RCLhO+4n1c+KvwZpzT0z1u36ADunHk9IdR5wwQSdX98eSZwQggOmJW4p8PwsVIk2D6z9HhQ7NRnteM1AllZ4nsEz7z1FWTBs7UPvBZBt54dvrvidMe1/SqU71UaOpMshkiM34GJZRijpOdaXmcJetKZawxDLDLuvP1ne9k4+XETAJV3ApsAqT38CKQ+TQlHa7V7rigWTbthIee9xq8ubaSDE/++9dvvj92lMrQfDx50PW26j2WyNn5dxgLP4Pp43xfY7FdivtLUCSTiCSiYj8Eipx2Le5H8iARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9OFfVXdgt4omenZi6SlPtoORTKLWgoN8JPA3Z5yslo=;
 b=LzhqkDj8rUKmL3/Sc+lepnMvZZl8qoJknXHXpmnibt27xiSSolDzbf1zL0virvfwVVPsn99QLFHogd5Ilq5os/1VIMZz9AURydgZIK7+QuFoldKPWRtb3g/k7KYjPaqMhTehqUpP1020G/qWIq8KULN+Cnetz0lULBwj4XzLi+EwVoCSexVr6ncbj/5in3wpRdoiIoF4JclQJWt8m9iOvdQG1wT8SbIjcnJFn8suOz6LFHUqdFok3nde2NHe0CciJdc4YfI86cg6yRza9eD43TbYpNEramvA8KblNPfQ7fNCZlO0oN4dpQCvjXzha/1ryLmt7cbm+nCqDiNHHyW0SQ==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by OS3P286MB1445.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 09:34:03 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1%9]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 09:34:03 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1] ACPI: Make acpi video driver available on !X86
Date:   Mon, 13 Jun 2022 17:33:47 +0800
Message-ID: <TYWP286MB2601F3FF324862A2E81FA70CB1AB9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yD8FmN4tPqwMysFSNOEpconeo8A5IGAHqXJJggep2yg=]
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220613093347.3917426-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a72f1372-ecd8-4a77-a05d-08da4d1fda95
X-MS-TrafficTypeDiagnostic: OS3P286MB1445:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXDrnCtw4xsB7Zr3F2siODAxtCh9Cyag+adsBcRkvvCZxzMEK1a8sypKBf8bbCzb/r6YXct8+IWK7XEvNaK82DNid+g+2Hr+VkhVETJu+GYTNihBIPrmR00rjjjqchcLxUoNS95UgELq+lBiAoiCr10K/9F2THzXdQBEaqS3tPm++ACzJqHAa9QiXYHlWdlCnEokLYI4hvVSsLENYVlCjg2Us5l42xsBHE9/Cn2mJ1sPjWCFg0sOYc6x8nmXEeRQG9hFnEau4SJWfhrxxgkkIY20DULMIvssYl/WfBDQp3B1ul4ezWi+TJGdZrRNQspQoL5iM3mYm9zelyXgZFaiPMPgaNu5/hwohbvs0fHK3BUm8dX4War+cdDYiTs9AgEjZkoVcH8N93RhRq+LNuM+crj2XMcHsf+9wWfF3RoLkGeaBaLL4RmMpwMvGWbSirD2sLfocnGOJA8CSyvAPR32AcWz3Xok2BZUXjAw0vJbDHLnKNhMRhuxIOI7F267AfQPcLsvTi7T11eFde9FD58HFo5Nx445rLzILvmV+29HLx5uOc52sP8Ysksm9qIPKrMXbfQJVh1l/7WwUWBYfoGODg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0wMO0Im3Itp2KLJVIwENVFEDqLG3P40PqYOOMJ+9McSD85k0z305imr7DDx5?=
 =?us-ascii?Q?QgZf5To4ebIIeMVvgLX+UGB05ta0hcBdOjbTMKs2gq8SOWK6IWjjAcdvdln8?=
 =?us-ascii?Q?hBp+YEObgNLTkSaOJ3eK/8WBTbs+sm+vJXJoAWZFtrp2fceCETPl2narta1x?=
 =?us-ascii?Q?wvIV0N9dgBjkVPIvaWy7s0W3y2uD3sA23/IiKT1vid0nXP4uRYe5mCgB5uzJ?=
 =?us-ascii?Q?uKBmtrhW7VDO+wYUx2IgNGa5cr2m4X00kgDxw48LuCOu+Tk90pDTtN3VbyuY?=
 =?us-ascii?Q?lJvvtJYNpxSt4LxeBMdusWsLPN7ILxQbLbZjNZ9KDoAeP+yzbTyiR0gGg9Hn?=
 =?us-ascii?Q?GqlemGMDjNhHsW5YHqdW5/yippY6VdiMoBJWkiwckX6l/vySn5Uc4+aYCb1i?=
 =?us-ascii?Q?EGcUf4jZPAukMjVPmP0Qty2Xt0EzsHM0iEjnXGx3w7bSv0bF2SEPpxBOPwsI?=
 =?us-ascii?Q?SC0mG9y+pB4Qe6nCy9z2Oa1biWi4MdlJXn0qyFiUc6FTr6utppKwYvA3RMaA?=
 =?us-ascii?Q?NLtZAASlCABTmmntT8FZMzGLZHI6VOk6141DVFa5U9e6My7v11HtUDIL2j0i?=
 =?us-ascii?Q?L0++jTqz3ZqAchQ5M51ASG1cjmHYdfsBWwsbV37FIVWtyt6kY5XUx4bz3c0+?=
 =?us-ascii?Q?XAnS48nqbx9XLWBcrV79OUfF4RWwjsbel1YntEN6jHHgGupeRlC2C+/C2bIS?=
 =?us-ascii?Q?ra4hsRMLukLivWeTOHOjuUldr9YGCh0htju8/3IAfzwebqEq6y1HQL76ii5A?=
 =?us-ascii?Q?VchjV6axgiVB1AzjmsTf96CbITyZp8BmHw8rRfkHSqY4iU+6i1MAspNn83Gi?=
 =?us-ascii?Q?9j6u5V+AG50V6zaKzBkyPk7t/Sis3pjVj9iGScIzaGDhkG8ohGsWn3e8qLPw?=
 =?us-ascii?Q?ZGH5PJnaJsOLq4EWK5YCZ5VKg6YxdpoayUw3cpB3sEH0FtvQIzuMNtqPRXkA?=
 =?us-ascii?Q?f4a8zolIOECU+CCYVu+A8pHv4TeH+/SBH6gCaG0nPCLCuwHA6/eZT8oAZ0aW?=
 =?us-ascii?Q?34hdfVS7Qo6DhBNd1oBhZ/Lv9ZmUOwZR0GCJl/OCq5/PlPJqE9eQr9YtqCe/?=
 =?us-ascii?Q?tXlhiI1BvSM+x41pRrh3YUnuKbTQvalNXtxlXDb/CUdC3v/tf+wUXPGwWLTp?=
 =?us-ascii?Q?wPLDAqK43KZVi1XFR2yNGzA7kkHnUjnoN3XieGQO3PLT4USoG2X1IP6OE5ie?=
 =?us-ascii?Q?I4ncFmWobjm+PKpSF4+H1rHFAvi2ybM/tPjkeeNt6atdaMhANBsmtfvI6Blj?=
 =?us-ascii?Q?X1uckzSGZK0yGLJylzx85ZRw7HtsqKPdMICmAfO808x3MLeY6b5c2UR8P10x?=
 =?us-ascii?Q?w+5KYvgX3qEOzv59y3wzuhwr+740W6UqooKdk6OBcrgNOmKPH9oUJrfGTGmk?=
 =?us-ascii?Q?MKGupWsIXb2dj79pDGgTpvXbndHHcH5gyiX2MKrg1jmMCiT/AWmjUVHpnooO?=
 =?us-ascii?Q?WH+5pGJ+K+w=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a72f1372-ecd8-4a77-a05d-08da4d1fda95
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 09:34:03.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

ACPI video device can also be found in arm64 laptops, so drop the
Kconfig dependency on X86 for ACPI_VIDEO.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1e34f846508f..a25c36e0c863 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -210,7 +210,7 @@ config ACPI_TINY_POWER_BUTTON_SIGNAL
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86 && BACKLIGHT_CLASS_DEVICE
+	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	select THERMAL
 	help
-- 
2.25.1

