Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5F5144F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356193AbiD2JBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347883AbiD2JBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:01:35 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150079.outbound.protection.outlook.com [40.107.15.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6186E02;
        Fri, 29 Apr 2022 01:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI2saKNr7iOzfk9U4EYXht46c76Y2EQc2gobwCbc3D0mN1a8akLcFZYUq5akyLmi2F7OmVOAVREyDASsGqZb8yrP4NVHoCuwdxmAgykXZ+pk7BT7/7W6R08dOdaL/JCdzTriJSS7qQx15FcACS+wTy+guguB9IVUmfgcUut8JzagYSPqeQXbrppFwMW9kxRebQV2ZVmryOhU6k1QiR3OoU1U2mBpAH/fd0CJlJEpCGkqT/tyAZ31PKp77heWet+DuVx5VroPYDUNC0f0pJ/R8VoxQQn1SPzi8DVNDqWn0w1bLEFBdvIHfXivTvBjCmeA1XSIBEnYCnrEFYLqP8ofMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7RRaTFjmSbM7HSEuXXR41ASDpyb5tfKFaR191EujIA=;
 b=ho7txe9P94AyH+4wmeKZMo/X8TtCMwcIi8BSSh1hqfk485rN/aK5v4+Dn/ozmwhGbTZWfGa/h0KmwY/UM7mK4iM8ZMdxQRcmscU7nbr29287h8Eo4+iCC+MDeS6HpHk/Hl7NMY7ETQFawPE7bXnJ9LLKp1XWCtghgu8emYwuGqNXsHJiYZw/zIAxJTZdfdkLUo3WE/AkxZwyooGvtfXgMSOy7UcYywyIsLlxV3Jl7mUUw2eZmfJc1hmHsCKYr4iKrsfO6efjmMUstbiVve6laWSdCeY0xVJhEPMpLFqHEDIZOI2AV3iYe1xtZuHDN7bEDwRzfbyTDfJkWB4LO7/qEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7RRaTFjmSbM7HSEuXXR41ASDpyb5tfKFaR191EujIA=;
 b=AsdAUXeuz+wzM+KtSnh5pg4g+tTza651uzTFB2k/SObTss/+s6TTgAOCZHTdKhdNQ9Ng+xxzXuCXaL0YWXbW/wn5MX2E4oDkY9Jh+IqlLQJq3QJ0G1wqySnssB/ejeiwreliNpJorUM9uBRMDLsOzR0BsKN3YaKYYsq+qVJKPag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB5225.eurprd04.prod.outlook.com (2603:10a6:10:20::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26; Fri, 29 Apr
 2022 08:58:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390%6]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 08:58:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: wake up when error occurs
Date:   Fri, 29 Apr 2022 16:57:57 +0800
Message-Id: <20220429085757.18443-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ed51219-1d7e-4af3-3c8f-08da29be6563
X-MS-TrafficTypeDiagnostic: DB7PR04MB5225:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB5225C8DBFBF32B1C6402E2A1E7FC9@DB7PR04MB5225.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PI8ml+9+0CYAYycpU2k1xNI7Cmd+CdLhO6gg/E2AS7dk/0DrdGKfROMi+zlL2I5naaENwmwtV5gEgPs2k6ubyQuxUiCGRvF7ngOruHrDC3fVjcV/fe5MkOwlVMYdOEKKO+peQvTjjaIgxnoI+VTyCEtYIds454F1CkoFwVxJgU8nbsppbTDQVm1nJyE6Dv4Ymf2uUjcivCpmtd2kdQVXjXHHLqzxIUAAqhdZoXma4TPjNK/qTeccSm8BOJKyGoHFCDuQTjS0/S6POCTZHA8BSF/vtqZmQHdfW10lT3NxxCIGRMEYIyAIVsV0nUgGCwMZ1u3favn5rhIgEVqO2ToSOlJcG/f+x35MXeBFLoO4WzxynUGvDGKXLbflpS59727CaEwVMIYVVcmP8wUCuf1Pq6guuZgZQcbdmFOB3sSHHgIeNq59CYckoH44SZX94U/uyWkRIDlKUfZG0JL4ZQUlBAKpVjC0qaXxcK27jbzcaGjx7sSnITUWiJCYs44E+D50yVeAOHzVOIOefyPEEBx3gRf4XguS+EoU4yTB7Nf0LQ0opoWeQOSzeKgE+cqd/EBV82iwpjBAoX3Rm85yh2ZH16+QuZxSAK5M/i6gs0vqP/8tV0bRogB0jWBHrKI2KFXw87+81etQGfovLyKGdzttpBPvcKY+hl3S1Do9IwVtc174pfYctJroUfS9rFCg9c+UBBUk1Z+y7QjcgYIN2HxKSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(1076003)(2616005)(86362001)(38350700002)(38100700002)(83380400001)(316002)(36756003)(5660300002)(8676002)(4744005)(44832011)(7416002)(4326008)(8936002)(66946007)(66556008)(66476007)(2906002)(52116002)(6506007)(26005)(6512007)(6666004)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bo4UtZB+0FlhiRm88WAQmqwkFoteJzBs5L3SEX5MGqgddetqzA+9YB39yrC1?=
 =?us-ascii?Q?lKSWm+wbnGpN+fxRt4/CdK5lzyEFCBNPQvKbHtgHx2Fy8Dq79hOcWP6ruqwC?=
 =?us-ascii?Q?4XlSiWC1H1C56IeSz1rjNhcSXxOwJhIwnLael8AszgEHh/qRFllBHe02uHND?=
 =?us-ascii?Q?VF5B8wRVKwFSMSHkyVE03JvIo10Z96JR2J9O9MqCifx34efNcCORK0X5wJA7?=
 =?us-ascii?Q?mNbq6EvjioSqRvdLLp2xAD7NOIc2eM2t05iAzd1CLt0enmuEx+gPVpFB5Ftk?=
 =?us-ascii?Q?BqoPsUR4Znui5ybRPlTlgLqkEZJ4PwcXTekjhjnMWiKlW+iHccACSXWGzuZv?=
 =?us-ascii?Q?vwQ5r8VjlZnb/yAl2QtSIPD3YiAEX0kUsPOtZDQVpYj9bU7duD3RNEXxDuKl?=
 =?us-ascii?Q?/+ffPhhzj7Tz+qvojt0rAhIch7eIxcSkpkeyTveo7o2WyPE5Df9PB8hZjxXI?=
 =?us-ascii?Q?JpldbFtQqidkwMicpSOA4dWYtGdCyOKcc5K9KzSf+eH0Ivj9AWAm+02LNHEa?=
 =?us-ascii?Q?qgGDLU9ig1yvKCvHVQZBbwp7vb/ndNXqvjZboHfXtC28h35GkJux8ibmrWXZ?=
 =?us-ascii?Q?ql9iFQM/A8mH+HLf3350tjw+j6o3XEnWshPHAtXFhKspw5pT5uyXFNhp3QDo?=
 =?us-ascii?Q?Dy9X8iPvWl/F0yuD8zfsGSNiIPF8a1wKtDqSnrXH4TdZRMNJKPfEYC5iDcsF?=
 =?us-ascii?Q?KSkwnjqcMMiN3ilJxDRkTFA7RcuvzdTEstQG9vYUdzMj0xquPYtEEZRa/NGY?=
 =?us-ascii?Q?zbamv5Bc5jsVSh0ktyXf7KONqC2j4XcUKa+AyulbwkKhY9ZVxXKNzMsD3W+t?=
 =?us-ascii?Q?c4HfvNuYvQCEiFuUfN1Cb0+XixF42btUkZiH+Dwlso3Hs4YwoBOrAPjaMXlA?=
 =?us-ascii?Q?16BORp0ZVOxxxSeQlfec1hrO0L2cXUMYCq7dS5wmAvLr5fFuLNUHpoBZp8rz?=
 =?us-ascii?Q?MAiwtsJQ1RqDZNdPVNgbigZeYngAd1SaD3j7WZ+JGYXC0naNRTayzDAZmcTP?=
 =?us-ascii?Q?9bVIhLPi59f1FXdLxCBkbijRjFhIj7tUmk83afSMt6GMURwCv9JU/yQtu3uS?=
 =?us-ascii?Q?byfdHd9UbDZnJC3MmBXSiwxyBtWYTcLK1IuUdrRdj6qkPYLy9w1oWjSWsrXJ?=
 =?us-ascii?Q?rw2pe5rEIA74ZzlrUkkzuzuOfmcWq9VKuzNazUs8FULy+RifoAjEN4dXS33k?=
 =?us-ascii?Q?5xof3n+V6UXUPPXNEwbrdPwlj3jMPYgoGlDPG2blZm0Q3FdARLMOhVc/gubQ?=
 =?us-ascii?Q?0DU6imrtlKLF+ujZo2CSSaoX7bmcaPtOeWcJfmzzas4yw14SC6sUm7Tfvuxy?=
 =?us-ascii?Q?MUDlyw3+Nb6Be6n410687a05Dqe4qj9jw/jyQ8cbQKaD3lq+HBRNoR0eNsV1?=
 =?us-ascii?Q?103VEybRKqG9hQvGjDDBBHTVRSh50o8YZ8U1d4GN+Wl8h9yX+5HFETzsO7nD?=
 =?us-ascii?Q?W1+xPZWCwcZPDxEOGMXIz2PkruaN+7O0vz3Ldk8UXWN5y1qdjtuJ02z3+Wf7?=
 =?us-ascii?Q?8c8ut+iREARqd+xkJEKWoEMydb5lQFyT/+vYzMcH1tHTk/qsYiATkp8xU9Ai?=
 =?us-ascii?Q?QF9WgS6MpLUNb2rb013oU73irUdIJeCaIqsvTdR//er/N5hb2JeZdHPZrtDV?=
 =?us-ascii?Q?GxCI/3pQ4b3UA3NXRXQHtIGTIROHB4nmFD/86D4IQ9KdkVXM+giVfQ1PMHF8?=
 =?us-ascii?Q?+Tx5ilvieNX4+RLn7byUUYwTjGguqvTpkitCEghajZBPwY2Y7nig7X+hNwvl?=
 =?us-ascii?Q?+cMCqCMwbg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed51219-1d7e-4af3-3c8f-08da29be6563
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:58:15.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3kKSVRNCiqryBH5KItaZoZf8vQ8uByjgWYpkckXrT0gemYuLyQjsdbymDUWlwlPgdluzuKkaHm3aw9msq6J+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when error occurs, driver set error flag,
and driver need to wake up the poll wait

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 49747e0ee96e..a5de72f644a1 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -73,10 +73,10 @@ void vpu_v4l2_set_error(struct vpu_inst *inst)
 	if (inst->fh.m2m_ctx) {
 		src_q = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
 		dst_q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
-		if (src_q)
-			src_q->error = 1;
-		if (dst_q)
-			dst_q->error = 1;
+		src_q->error = 1;
+		dst_q->error = 1;
+		wake_up(&src_q->done_wq);
+		wake_up(&dst_q->done_wq);
 	}
 	vpu_inst_unlock(inst);
 }
-- 
2.36.0

