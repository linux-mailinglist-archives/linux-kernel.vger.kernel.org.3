Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63A4E4EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243071AbiCWJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiCWJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:07:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8DC74857;
        Wed, 23 Mar 2022 02:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHwm1XxEJ++aRnhz/kXfkY3X9whO0gXRHInB4zJziz9c7VJFmz8i/nfO2INQHmSlXRCVuaQLgBxsLfh7LhIOCe3AOPD7D7/ZzaG5agScm9CSqWGzBBwwm3fxBDZw5xT8nwslqH7g49+5q+sERrIM1J3toyTLzz4llBNiTWjJh06W6oEBBTX3Wn/TvNMYoesakG9QVJ67GVqZ4yfHsnFbuyij4H92ApRNG3+dCN2j88MFCsINK9XXD7iroPqPPJQZ2+xwbhuVD/6M4YNYs998olFyo6g5ZdkizzBF2Dlscjk5lYlUN0DZmCrFLuq9iu7zLW9GWCPbhnlGHqZ9Icck8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0m+dSKorIGiCCLRmZGvC9o4UTEIPRRurNfOfagCppS4=;
 b=Mz9HjM+iX7wjvJTH07CiyIlV0i5qDhGIRD+X/H8zmABwnNWzdURP9nafTe0qHxmI8u0AI2QlcQNKWveLMEsPKz03OS1UvLf388hIzSFgzTFkmYlyXZxT98XsoxbV3EdY7/XUaOf+PIrmJ8CfsDushpsP4yGETNYYOki/RJShMHwwy6EaxdJ0EPmf0nOiHtrOnPXibrsZgXJCQLQMeSKwbSl2mUtVyXSDqRyEFcadU/k77w9YD9WyJWFcDhJZ33egZcEEaU1C3hitt+qCAh+47GctM4eExTIC8368R8VkhFzGDFRT+e31VLNH5YEkAsUK4pSpOd/oGMgOSv5GurfTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m+dSKorIGiCCLRmZGvC9o4UTEIPRRurNfOfagCppS4=;
 b=Q0j3gyvyy+wlC+Air787YS1zEaGY1fNGACJcQCHYESyLn5HrK3HikNrXekZLim2KNQVXPFgKhRZNCOiUr601J5hiz8oEtzk79+Eh+pvarLdIfQRPEkmYWfVufUcHIuMet3pZJMCsRfDiEZ6cdwo3zSDh5fUbe4s4ERF1oSfnpx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:06:14 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 09:06:14 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/5] imx-jpeg: Support dynamic resolution change
Date:   Wed, 23 Mar 2022 17:05:53 +0800
Message-Id: <cover.1648023273.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 752b9fd9-fa09-4d1b-ee3c-08da0cac61d0
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4901E2E47E5125CF8BCF9EC7E7189@AM6PR04MB4901.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIbSBo5JeZAt75+3uQ6oI7uk4Bdk4z2tP6UYP6gLlpdv6k3tJusOcB9TSIEiCxEigUeUN1wUhQzdXoih2uN4RLh8SuqGCQh4makcLi/vRatIBoUcJBsG/IEhQfs29Z/l/rR1f+RRhqpyfuazJw4OeU+z5urTWr1bRom/z90Shv/in0VaXYe4/BaRAG5djGbYOIu2R39N0wQbHw7Kwmq4oDCEbMRbXn6FlVVJR4v4BfJAwy/LVeW0Iz6KUjPvsA4j3Yiz065a6P90BCRXCCxYGw5Fi/9kOld8ytNBg+tcy9Kv7d05cDdIfYWZ9IiDLezY7J+ASek+TRqvU/cyLTMM4E/VOd2ycPVPJ4eqih6MWkIZLhI8k4qD2VwmSMbxy1zv07E65fCBbPDLBCZx8r1i2fvOtaUXdOx0eZIi9nryMGbjmGfYLdtSKeCDYySOMLcJIIpCeT558jp1frMKEwCBEgOi0+/wPzZaMSax3ahkHeIKx4jS0/ptI1VxGDtjpburS2gW/0kucAukC7Q+eJuaBPOrafv96JvZMrePC5HxV/8DMOrg/JfqkaAzzEtAJoskGXxWbmyanJJ4W6cILpnXNdKQz0PxIJnsiWsLuW9nN4YIZZ7Rd5o0fFJpUhJdkyOpt6Kn70lOkRy7TbTBjVQPkMA231coDopN0WUzXeyEmDRsIR+idY4Dk0Tk947qglIIMEJbXTaAE6FI/BfnLA0KcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(38100700002)(38350700002)(316002)(8676002)(4326008)(66946007)(66556008)(66476007)(6486002)(6506007)(86362001)(508600001)(8936002)(83380400001)(4744005)(7416002)(52116002)(6666004)(44832011)(5660300002)(26005)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKuALmlWyzfdmvx3aUXhgwBnxo7wP9tqNJHGj1vOuw8YXXV2cXi8m1+az6Tz?=
 =?us-ascii?Q?5FbUtADtTqRP8wOzdIVUEcKwxFhUDO1Rzfa4Gi27lnN4KQ1Sl1Y96IctSg5e?=
 =?us-ascii?Q?GpCj29uWvWyxFN1aoeO1OdGGA9RYsKz1f4tGZfmg6gXbNBBBxKAjotOLWuCx?=
 =?us-ascii?Q?eeIivjfoEkGHkn8oRti6k1pcCb+SXkgG/Xc+h1Eo0m2SNK0lEudrLjumaS4r?=
 =?us-ascii?Q?PD3qFIl45oRR9oFgW9d+ieF+jWiwh0mUb05xW5bjARO+KU4tz9kwn1tixe4/?=
 =?us-ascii?Q?gJIHWpDKbMAU4aLnReytiV541XmehbUq6WAYSZufbTyObKfwdTUNynbOOYoa?=
 =?us-ascii?Q?Wg0KEVA0J1ZSC4ESslUpciCjvtl+QU4BoGe9yAYuctaZ2ujG9xdIjx5pKMBM?=
 =?us-ascii?Q?qkLbx62ckKhpzJAc0/SfDPEOiI+KQlBQHnOACNVjC2RunDLrJlJU1Bhh6Rhf?=
 =?us-ascii?Q?iTHhPv7QFK2Eo+YgYj33cVtDWeKJQvRE11au8597vDGLyeErYPMZ2N5SFRmH?=
 =?us-ascii?Q?jYzrWs6JGJz2Tka7+y3IAMMU51d0Ec+DYzs/BKim1+A4DfGuBrSHpM/YLJ83?=
 =?us-ascii?Q?eQanJRm9U7G9kiheQGxeGdud3+riK0KPOxX5OpqSguNOvqJ3Y26daMK96Z6v?=
 =?us-ascii?Q?9Vghb48FoG1LLo9NAYphb7shNKZRLZmSA55MLxZsS4zbdk3i+XkGef7054bQ?=
 =?us-ascii?Q?rmOcRGh9kGpZje0VMKcRpJSXzd60FspuR3pIWT8eFOG+vhUMM/R+VZwOBU3C?=
 =?us-ascii?Q?lBDLRK809GMNxmGTPZ/O2+ZObZ35qJeOMbNIgJjYIRnmeF5Q80OjstEI5D2T?=
 =?us-ascii?Q?QUJBaT4EELGeDyH3zjljp9gdp5wiFnfyI5Cghjcc5ualKD4hQNETu42E8Vfu?=
 =?us-ascii?Q?7JkMWatXmBDEj0K7TeYM+waVhvXqd3yAMSWkwp4u7gB5nnNCk12/ljskg7dn?=
 =?us-ascii?Q?OEt00bTXK0WIQGMY3yWB/KC2+dRFMMkQu8MW8MhrYh4e32pt7GUX44QdXnOv?=
 =?us-ascii?Q?3zu6WyfBOllK+UTONCogrrSbdhlVSq9TuCPy4T0HDT2i9hDoLDpxdOA10R/w?=
 =?us-ascii?Q?AU9mP+ND/20N6SDZxkieoAq0Ybt5t7rDYLXTdSc8lommauPTmdriZm3qyR97?=
 =?us-ascii?Q?OkpNeh5jPEKiidtt+9LqTNcFnbX+Skaj/bXEZp0RiKyTZe1qZOGVdnHReK8/?=
 =?us-ascii?Q?JsZl71C9HFKKUHecli1MM2VRhAPeNs1MOzReCT9YqnaLpLYRC/FqyW79iSK+?=
 =?us-ascii?Q?od0Pf5llLpeZf9SG34jQyLx9UfQ02U4tzY/HhD9Y8Jhj1FtObR3xaYK77Du3?=
 =?us-ascii?Q?7yn0cLRYfNG2rOkcBk/B5Aam4wKkn0AZnZxU4Mlv/2XMNL//UycPpZykRk8G?=
 =?us-ascii?Q?/Qug9KN3/euU4FyESc1gntyRFQjy/1ukNC2UswmqHVYVzqYRFOTIsa9vEIDK?=
 =?us-ascii?Q?2oIYS28AERpZE5o+AVgjuSMtlHiTgXAZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b9fd9-fa09-4d1b-ee3c-08da0cac61d0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:06:14.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHcl1LIWFazqc2LQGRBiNn2zn4j692wdKHViYipBGmTbGrqX2+ptCXOGH37ouwOY15wYz/hDp8FhnRerWXWwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patchset are to support dynamic resolution change.
Avoid decoding error or even kernel panic.
Otherwise, the Gstreamer v4l2videodec will fail to decode jpeg
who is not decoded to yuyv.

Ming Qian (5):
  media: imx-jpeg: Refactor function mxc_jpeg_parse
  media: imx-jpeg: Identify and handle precision correctly
  media: imx-jpeg: Propagate the output frame size to the capture side
  media: imx-jpeg: Handle source change in a function
  media: imx-jpeg: Support dynamic resolution change

 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 249 ++++++++++++------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   3 +
 2 files changed, 174 insertions(+), 78 deletions(-)


base-commit: 71e6d0608e4d1b79069990c7dacb3600ced28a3b
-- 
2.33.0

