Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FE4BD60E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbiBUGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:13:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345045AbiBUGMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:12:48 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8A110C;
        Sun, 20 Feb 2022 22:12:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BejHcNL7/EZNqsdAPagKDtHd5cVAZmL3IKh58ipn3Q+btUDu3bH+itu043SWR+ftE9G4stK73Ti7795atDXT6GZ9U7XY+RU2zjpHhwU7uJp05m8sNz3hgAPedFkDExujdMm00kl3tGZpNg5+kRbBlaKnPU8f0jeclv7G83xRfvjl23CAIA84m0h0NcYDo0OhiCAzYInyPyOhFcIzwiNF5IONZbEzQLPfLHJmEAuD3kP77jeq/JBZDtZECDfW34rGsQhKqkAdQ4OybHgkPaCmbKNVGngIBiyZodMqm9jM3OxsJz/Rn7W3jKhIL5BBg1lC7e1Q9ccKLedOf9QQmUF8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDHOpRkvaL8TBkStfB3/tjhywB2nWYq3xxwNn1TQsnA=;
 b=g3MLCY4FTOM1+eKnk2TkNWsVdlr/fE+nYatKKvTKOUbE7o5id9J91NGSjXc0e3ixTjA1tghkrG3mQ85DB7mo8wzWDfVux+0hoZbxs3z8WdWuFk+is92lRtrDtd0NxCqkADaqrZWjG33/blB5lxlIEK7xE1SUIDwCiXvRUH2x3cguTQi9TCQVVfmvOeX/OO5SfjTafh/CkIs3NWDdl8dLlLX/lVmYwdmsGOA5GPLF/1fIQ2Z7o39l5dpGRgkIJyuPPKEPTJz4SF2oqDA++8p84ydyplnnjkUlbCT2saD59mM2GfHkfEhVhLQqDrMugEnnB3oTSymA17bDoO1AWS5YmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDHOpRkvaL8TBkStfB3/tjhywB2nWYq3xxwNn1TQsnA=;
 b=EKlnD5gbe8mVDc2oOqh+j0UZKUT6CO2Y6BKEeLx3dGmSf6ZLX61bHF5t0HJe60Hb/02k3B2KzjuEFos1Jyoiyj7Zby3hFTYEMTd1jI8LCP534WOh+JwrPjTmljT+ydDzgug/0qSWYYGFm3NapAsLKrJE38UN4rplTvNUh80vsKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:12:18 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 06:12:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 13/13] MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
Date:   Mon, 21 Feb 2022 14:10:32 +0800
Message-Id: <6cb0ee3f33ab563ef8771a640b9a31bb11000cb9.1645422822.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645422822.git.ming.qian@nxp.com>
References: <cover.1645422822.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714280e6-7181-4e70-a599-08d9f5011cc6
X-MS-TrafficTypeDiagnostic: PR3PR04MB7322:EE_
X-Microsoft-Antispam-PRVS: <PR3PR04MB73226B12EEF929DFD6A5E67AE73A9@PR3PR04MB7322.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yOLbUt3LgeuUPnQ/RNgxCrA4dkH4fxpbzbBF8fbPZgw2TKgePdq1ByBGu/zkJWu0Xmwt7u9qKiGwCzwCVDmunLdD62Ku5oztGnEXSZB+3sTQbpKSCXVn0O13Q2UyhODTuCcrY9kzSp65T9LzhcW2OWGEt8YS9o1J2NGsFlF9dW1fxm69wE7xqi55J8U2GzUW3KIXwAN+DSs4dfVDv9L269YuVeEVKFHyPXC2vaYB5JWyxvWrZLZB9SYt2pC5p6VIi4V1k/fwx39WugR47Px5d4rHig0ckX+Dlevf5BmwfOGsx6UlPAQj/aQEu0Vk/AzYD8iw+3C34RcuWBmnYJirmq9qjA6Kmg+UPm2JKc2Bcz2dah/Puhn4wjxFMraBRM9wgAtTTs7lDlAEzugk67/7kg33aDi0NPXxcf6mNpy/LeBqv5XGfEmtDUXX4Djjbq3I/fYf5FkBPxgScSdWo1Q3r6KB4gs03gNSqMgBJFSx6BEVl2J+SLqLHQjleSvjdRo7ImKy6DzBOLW6m8c42NdMnIYLZmm2AdIltMnE/Q4kNlyBt+triQCMNgakoS4UE2juVcCj4+wwwublVmFUDp1O32FRdld8ZWVgm7yECdFdbMZokMZbTkSs2wR1EvThA/l5lm8SXj+G3PoRWvF9P9CnyPazkPUhlGbEgAzDmsrTYpL4SK5xXdIBkT3VMbmyo48mlrkVceQWfMyJK5qRASqHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(66556008)(36756003)(44832011)(26005)(186003)(4744005)(2906002)(508600001)(316002)(86362001)(7416002)(5660300002)(38350700002)(38100700002)(8936002)(2616005)(4326008)(52116002)(8676002)(6666004)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+s/0v8cZMJOW+6zx+EWsi3cb/q20HEx3JlVGSqE7CSXvMYNSobyDkUweyUnl?=
 =?us-ascii?Q?rouIQILYdCFVPxF3O+xh1LGWxKu+sFU1oyzvvNm0QdjCjsZ/ZeGAerQmOJku?=
 =?us-ascii?Q?DOcP+wsjTl9ZLf2RsWO31xWo+qvlAoT5Fv/UtuOzDD153iq9mLtq50NmkQg6?=
 =?us-ascii?Q?1D5HfDZFEgNmHn893UQqeRtmDZm/vLrO/5myO750JWuIataRRAf0nKkJQN8q?=
 =?us-ascii?Q?sXCPqZICcdQwR9puXCCAR+usjrkTmXkKKDiEhBXYmeUkmfP0svdjKt8c/vpS?=
 =?us-ascii?Q?zPPOgb/YAss+0nQrQ/mA9J7Ywc71lKPFSv5ygBpZxOD1hkxXPQpuFvC/H3yP?=
 =?us-ascii?Q?qabn8zpmQteQoBE9r6oiC+cNq+Bn3SA9fl0DYI0JmKN2Z6MAn+m6bMpjmf9T?=
 =?us-ascii?Q?xx0JNgrZMEiRLhNYDBRuXgqVYehvdJweyWxSuYi+WdHzDbntBXOUjXpOK2T6?=
 =?us-ascii?Q?Ze79sIWMQm/D41o03n4jF60OC8zDAWgX5uhsZt09euWRcwevcnUnxu4vNQEq?=
 =?us-ascii?Q?YOa3X7puhBezdQbu/lbmD5xPEiogzl6zvNo0s2u7YNvdQLdqS1NC6qCNvJPK?=
 =?us-ascii?Q?r0FHrwgclYp0p+BClAeyJWcyo1saKbgTFPhwFpSM71sjMbg1lEhddqOzr9Jw?=
 =?us-ascii?Q?7WdU0TW/AwMron5x8xJqffUA3xi8cbD6KJ30wIG7+dlT0nUCUL6Nb9WmwxFC?=
 =?us-ascii?Q?hMXxvvNZAoRhSul0MvVO55XvqFQDoLOlI0vNfVck8O22RZhfUR9rBaRkx4+A?=
 =?us-ascii?Q?JLZYUHj8pBI3aIhj87k+HKGc1i8EiaC1UnXpuVJNHr+OMSx6WzolGYZ1CzQP?=
 =?us-ascii?Q?ot/fumnUjgXOv9dtXNoXHR9znhRyTYC7i/c465z6Y9A9NaFKd0itD8+dfPHw?=
 =?us-ascii?Q?JpYRZHyyBjsNZElpUEnAOl43i2OkDoQrcylLIDuZC9ZhkYnUofq/oaQ/kDSh?=
 =?us-ascii?Q?uO6CpWIqFLDcVBgawPDFh13xPn7olMGdhtJOJ5puvXUOFlNKfDDGoE5WP4LE?=
 =?us-ascii?Q?r6OTZJNrq/T+DbDP9mmEuzmXHjs441YyK6BCLHi4fdo0sK4qbTvpXkiI3W/v?=
 =?us-ascii?Q?UL9D6AeItheVJLFK1FnVTBwh2/qXnuKY7yFDnidbZsWwysCUwZhcW/iWTLim?=
 =?us-ascii?Q?KaFdrpHfdRTYZU+qMYias3FjUwLIVbwQrcLur0l4fb6k4cByNuf9TQgGkJXC?=
 =?us-ascii?Q?sXaTIotuSwlcRYLcpBVhBX0f7uF9MAkLXQWEqpL1zyqDu9r2MYkSd05yqvCk?=
 =?us-ascii?Q?TfwByUzIUmXM3pL5boVbcAoEbjw5mkv6GdsJyf6lSz64hAPza4fly3jVChfK?=
 =?us-ascii?Q?5E8yoIQbpVxp95+/8A4N+uRhdnHGB9ppZAIR6cG8v4q2+sK4XE0dptuWH2Io?=
 =?us-ascii?Q?RqD6595J1T6vxUisfwXQdTq9VcJbp5HbNLr2Vuz8Mzhk/uIrY6SACocyh2c2?=
 =?us-ascii?Q?EUMtt965WQr8OpJE1Y5HUgQZ2uyIjzY/UTsgEgSl5zXpzNQ4+606zgqNBS8x?=
 =?us-ascii?Q?7Zo4KO/N2f84t8+eML0FAPotwCnxnoC7dkD3N4u0v5ksx3cg2rqepDuevoYY?=
 =?us-ascii?Q?XlN35BFzShzGdIpFo3CB6jwRk3L1dP6vcvtV8D1WWcuodbYPbLl0LSDWsR8V?=
 =?us-ascii?Q?F35ISP0+kjAsSKhFOJekKbc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714280e6-7181-4e70-a599-08d9f5011cc6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:12:17.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLCIoO7JKRYbLeFjZ4PgkIxl2tOXEOnKQKxif+TfkND2dc4M4qbwPK6ryR1HWBPuh6DF7yd5yDdM+8QP+GorTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMPHION VPU CODEC v4l2 driver entry

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83d27b57016f..80b21f36702c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1030,6 +1030,15 @@ S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 
+AMPHION VPU CODEC V4L2 DRIVER
+M:	Ming Qian <ming.qian@nxp.com>
+M:	Shijie Qin <shijie.qin@nxp.com>
+M:	Zhou Peng <eagle.zhou@nxp.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
+F:	drivers/media/platform/amphion/
+
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
 L:	linux-iio@vger.kernel.org
-- 
2.33.0

