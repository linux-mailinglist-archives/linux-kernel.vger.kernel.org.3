Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE6582965
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiG0PPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiG0PPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:15:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D33AB32
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayB/p22mCdTTWqasjmjWvnELc1WOfYGf1CGkxwnOJEWtL7bpGsk6j9Xgmps9x0zhQlZWdA2iFsC5+5y7FGg3MFo0fH92VU+XlHvG7e4eEpAb+re9pkCoXF8IQZf9c3r9Y+p0LOzuDMC7EzeKguU5SagCd3uOaDupILPz2ovxA6gEtTHRA+mDkmd+o+97D/EsbZs+mQKjJizuB99kMI/i+RXVDxjw6WJCvFxmILpHMjRTkei6epm/vjVLozEvh/Clnp53xTgpEHkdy7sMreflMP9kD+Nv3rhQdWowwZBZo/wFLnqrH/9hvj4hjTpdEag3EJeFUfo5rHopz1mfw8al8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi6GOIcZhB0BYW+51FfPHw39H6d6zuki5vJSoVU3hi8=;
 b=Tg3YuizeLYe8yp+PuXIp1oojSCdDHOzxEa9DnIF2x2nOSmt4RyN8O5IWDz6YVpFxWl4Zmc78uw517/TyIGvCaS2l17lChvDpkpy1QrnAvC4OIyhn2dKcD7wUe+YeipYj1EPq6WPzENNXo6n+uU7qS5Mpy4xAF/fvNWvww1En2C8cnGrvZ7iC/WsFp55KhKCFzxT8igT9PkAHxr4uLJJ0XHuQPAB7ADs/aQMM8QJcxZ+2iv0o+WtNOhpbmtimBPTNILhLUE7RmkOoU4dED28aReecSb2d4jvB34oC7wBOsAY2RfNVUn/HUvRYU5UqaBpbV5PKtraOxPC1F5MrIQ3vPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 145.14.71.66) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=zeekrlife.com; dmarc=bestguesspass action=none
 header.from=zeekrlife.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geely.onmicrosoft.com;
 s=selector2-geely-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi6GOIcZhB0BYW+51FfPHw39H6d6zuki5vJSoVU3hi8=;
 b=dL8OSajSYLcWRs0BaarFswxe046gCpEMUN10XQgolhkyVP5g64gbwAw27mRJnHnk+wgO3Lw8VFO2JLt9z2EONvN0ChEl1A0yxdNZrIUqSWR+tfhOaG+bfjPPITDWTFYeStaJEl354K7JNADsi8hxhPDol7fx83S3z7DWz7AuXmE=
Received: from TYCP286CA0007.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:26c::12)
 by SG2PR02MB5950.apcprd02.prod.outlook.com (2603:1096:4:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 15:15:41 +0000
Received: from TYZAPC01FT057.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:26c:cafe::43) by TYCP286CA0007.outlook.office365.com
 (2603:1096:400:26c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 27 Jul 2022 15:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 145.14.71.66)
 smtp.mailfrom=zeekrlife.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=zeekrlife.com;
Received-SPF: Pass (protection.outlook.com: domain of zeekrlife.com designates
 145.14.71.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=145.14.71.66; helo=CN-BJI-EXP57.Geely.Auto; pr=C
Received: from CN-BJI-EXP57.Geely.Auto (145.14.71.66) by
 TYZAPC01FT057.mail.protection.outlook.com (10.118.152.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 15:15:40 +0000
Received: from localhost.localdomain (10.186.3.29) by CN-BJI-EXP57.Geely.Auto
 (10.186.65.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 27 Jul
 2022 23:15:36 +0800
From:   Chao Xu <Chao.Xu9@zeekrlife.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Chao Xu <Chao.Xu9@zeekrlife.com>
Subject: [PATCH] mm: remove duplicate mm_types.h and unnecessary declare
Date:   Wed, 27 Jul 2022 23:15:27 +0800
Message-ID: <20220727151527.8054-1-Chao.Xu9@zeekrlife.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.186.3.29]
X-ClientProxiedBy: CN-BJI-EXP28.Geely.Auto (10.186.65.25) To
 CN-BJI-EXP57.Geely.Auto (10.186.65.69)
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 701c7781-0926-4611-2f64-08da6fe2de79
X-MS-TrafficTypeDiagnostic: SG2PR02MB5950:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/mb4QIpJlFXVR6HTJZlwzowBL7gFtyrd+loq/RLX6ymzUlQNb72gnC8lDJk5SEnEesxaw6tu6XZru39/Mpa5iNopNp1e9j+VCCM9d9KBuQ76qtx4IeEqPbYOx4ofxs5CWqkQ80jK/W+ep1du1cgzrUdIe1bxAJbnF5Dn+/p9HJnoXddy8SI3Uelf6CwaGskLojKJ2/mR/bEJh177IGoCy8Y9Cg88SjC9ITWoL6szXoPlV5yDrEeZFcIzjerEMzvL3hAXnuFJgbtZ6zoTGXHLaV4R6hP+Fl/VRd2YAjF4L8UvaXdukYsp4vSun924g5HUew6hOjr/gfu7wK01p/UdaMNXRcf7P0zlzzZR3RSNx5a6ImHdk8eQwPDtSRcKwj7MkcVl/AIbX7jenzzSKr6eC2BRFEUB9y/bpbWWj78XzJw2gpJDKpNcU5OIu+MRAnZkhyb89NEY1fAIZnPyrwrwTP3HuuKgNTxItxMRQ59MvcyXirDIfJd6kWlnSE4+DwQwjdiekvS0pmgQqyyTT2pYQDaAlSqSy+OBZBjbOx1/4e/HVH7L4ofpW+HNLlfZF25A/39cQhlH+D+uJjEXbGIoQlStyXAt/rmOYJx9wfr+vJIgnEDYNOzKTTNkyQeKj5zNCrZENC1SOEo+LvrIBBtSRFn9d9x3PYM4xTKuCKB/v9ihV8aS6buic8Jat31Nph/bVPnkz7UeU3wbmnrFeLqVlQVVvrjjndfduXxRsXqL8C4r6DV5SYfOJO3ae1f2fwH9n55jmnmByexdsb98Lj19q0YsamXzZBpuF5w2LwsLT5YLuCVqXHhJ3ub509b1gl0Q6jATBbQ/jslyfqRpb2WYg==
X-Forefront-Antispam-Report: CIP:145.14.71.66;CTRY:DE;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CN-BJI-EXP57.Geely.Auto;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(46966006)(36840700001)(70586007)(83380400001)(82740400003)(2906002)(36860700001)(81166007)(36756003)(40460700003)(316002)(70206006)(4326008)(356005)(86362001)(82310400005)(8676002)(6916009)(478600001)(54906003)(26005)(6666004)(8936002)(107886003)(36906005)(1076003)(16526019)(186003)(40480700001)(41300700001)(336012)(2616005)(5660300002)(47076005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: Zeekrlife.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 15:15:40.3998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701c7781-0926-4611-2f64-08da6fe2de79
X-MS-Exchange-CrossTenant-Id: 6af81d03-dafe-4d76-a257-3cc43cb0454f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6af81d03-dafe-4d76-a257-3cc43cb0454f;Ip=[145.14.71.66];Helo=[CN-BJI-EXP57.Geely.Auto]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5950
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_types.h have already in page-flags.h. Duplicated import
header file and struct page declare is not needed.

Signed-off-by: Chao Xu <Chao.Xu9@zeekrlife.com>
---
 include/linux/mmzone.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..4a20676c63f1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -18,7 +18,6 @@
 #include <linux/pageblock-flags.h>
 #include <linux/page-flags-layout.h>
 #include <linux/atomic.h>
-#include <linux/mm_types.h>
 #include <linux/page-flags.h>
 #include <linux/local_lock.h>
 #include <asm/page.h>
@@ -1339,7 +1338,6 @@ struct mem_section_usage {

 void subsection_map_init(unsigned long pfn, unsigned long nr_pages);

-struct page;
 struct page_ext;
 struct mem_section {
        /*
--
2.17.1

=E5=85=8D=E8=B4=A3=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=89=80=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=8F=91=E7=BB=99=E6=8C=87=E5=AE=
=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=EF=BC=8C=E9=82=AE=E4=BB=B6=
=E5=8F=AF=E8=83=BD=E5=8C=85=E5=90=AB=E4=BF=9D=E5=AF=86=E6=88=96=E4=B8=93=E5=
=B1=9E=E4=BF=A1=E6=81=AF=E3=80=82=E6=9C=AA=E7=BB=8F=E6=8E=A5=E6=94=B6=E8=80=
=85=E8=AE=B8=E5=8F=AF=EF=BC=8C=E4=B8=8D=E5=BE=97=E9=98=85=E8=AF=BB=E3=80=81=
=E8=BD=AC=E5=8F=91=E6=88=96=E4=BC=A0=E6=92=AD=E9=82=AE=E4=BB=B6=E5=86=85=E5=
=AE=B9=EF=BC=8C=E6=88=96=E6=A0=B9=E6=8D=AE=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=
=B9=E9=87=87=E5=8F=96=E4=BB=BB=E4=BD=95=E7=9B=B8=E5=85=B3=E8=A1=8C=E5=8A=A8=
=E3=80=82=E5=A6=82=E6=9E=9C=E9=94=99=E8=AF=AF=E5=9C=B0=E6=94=B6=E5=88=B0=E4=
=BA=86=E6=AD=A4=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=B8=8E=E6=94=B6=E4=BB=
=B6=E4=BA=BA=E8=81=94=E7=B3=BB=E5=B9=B6=E8=87=AA=E8=A1=8C=E5=88=A0=E9=99=A4=
=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E3=80=82

Disclaimer=EF=BC=9AThe information transmitted is intended only for the per=
son or entity to which it is addressed and may contain confidential and/or =
privileged material. Any review, retransmission, dissemination or other use=
 of, or taking of any action in reliance upon, this information by persons =
or entities other than the intended recipient is prohibited. If you receive=
d this in error , please contact the sender and delete the material from an=
y computer .
