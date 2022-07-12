Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833AA571707
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiGLKQm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiGLKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:16:31 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70833AC067
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:16:30 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2046.outbound.protection.outlook.com [104.47.22.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-nmuSjXB7NjWti4gZfm93ZQ-4; Tue, 12 Jul 2022 12:16:27 +0200
X-MC-Unique: nmuSjXB7NjWti4gZfm93ZQ-4
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0165.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 12 Jul 2022 10:16:25 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 10:16:25 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] Input: touchscreen: colibri-vf50-ts: don't depend on VF610_ADC
Date:   Tue, 12 Jul 2022 12:16:18 +0200
Message-ID: <20220712101619.326120-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712101619.326120-1-francesco.dolcini@toradex.com>
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0172.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::20) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb77056b-98ff-49c0-7c16-08da63ef93e1
X-MS-TrafficTypeDiagnostic: GVAP278MB0165:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: LgTwEXmfQu+nzdnaQAVfJic1xQ7qeDETw1zPyDSCohG5m7bW1GssqJJtk+GdnSLlO3smJGnIPlXr9FyU2xCSoIqjjSP+7jMaTQor4iADRAXdyCqrmkkbNBVzBGIp946NeOeyo0DIvrnLeF/hOYOUlyHc1QzL18v4Hh0s3+1WiZqdEX2a3wm+tB21oQIPnFHeD41C7NRFPCFOW/SPCUfp9KGjqs1d+2BHrTIcPmwxBWnxiGb3u5MLMJo6YO6rt8IAk+/NC04CLPGFEWOlT0KaQGThg+pi6CZteH3UzEG7v5v9Ye2PeS1KAZkqqvpNo7Z4Euv7oEfLssvYGF0ljKsH1A1KKADTjJ7q/Xk7VN271qSaKe/vVrxnLrUbcHClt+duNxdCtHb+WcREgCOQ+CweTA+y7ftCxZGZyPQL/BTTzH7dyJcX5hKZmt+4bKb0ag7wv22dYnx2n/r4S45LTfBFU4Vl16/vGpeZRx+4265UBbTErprPCtcjgzUCjuNPCxq4UxpViBpArxKjastHiB7OjkOvRRjJ1HXUcSV6U1a7VlMqo8rTikNOhD690/9cSVbzkseoVpFpHEBspMu7XdPnkivwsXDD2oMd+Fz6iRHpHEtH5JIjMnUvAd3PqLdDG7wup0qL28WM2LNGqJnzCQMImUjD/idMjgiOiceYmPdeVVuK2ZiKtQ+eYp/sC5hqIira7SH/hCHgYraqBkyDbjJ4ve3ibXvFw3R5vwW2sIWisMm96oo8I2mPolyiLMlMgAkAmN4wVaHWOTyeR35D6Yytlg4IcAu6cqRXSBqsLvy5KzmoNyXvtml3gYQJJdNNpikP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(5660300002)(4744005)(8936002)(86362001)(26005)(6506007)(6666004)(6512007)(2906002)(478600001)(52116002)(6486002)(41300700001)(44832011)(38350700002)(38100700002)(1076003)(2616005)(107886003)(186003)(36756003)(4326008)(316002)(8676002)(66946007)(66556008)(66476007)(6916009)(54906003)(83380400001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVWmGZZmHOCCsdbgRbtfjLP2OsHHH6nf2omsq6WasboqtsXSJ08Log17MZXl?=
 =?us-ascii?Q?4okt49LleSHBGvhknw+hq8r+7IVFI129LSPZECq1zgLRo9tz/367H8nAMA3U?=
 =?us-ascii?Q?l2qHi6dddsaLt9iIy9GH4c3qQjtp0nzTt1oCVPp4RgjgMHZBVOy3SKNJqMeS?=
 =?us-ascii?Q?r/HXuqoEf1Ad6tLJoiOYh44n1JUT9iBCghgnhZ924QR/tZlmOJRng6MrMVel?=
 =?us-ascii?Q?nRZTx+mR4nTlFCqiE6CuC3CmJx0iM6Gdmp/3ohj5x2n3ihaUocIqwVAclwtO?=
 =?us-ascii?Q?UKIJ4b+WL99I3ooiws/iNII8Rn9xGWjnM3h658REsNfr7wiRzOClHVMfJKV0?=
 =?us-ascii?Q?7n8+E+PpcUoDfvUQNs43e1tMA+lC1/yJL/Uerja5pcPYV7H2a99qdUjT04P6?=
 =?us-ascii?Q?Npd2twGRSml3SSbPK6a3+tWPHNWKmsiHvBA+XxBpavb0AlCaRvyAkBvPGwAh?=
 =?us-ascii?Q?3tZP7ku5YnTLB4ymZr7cFkI0+PUzaHNKqiURw2t5fsJQSA8KB46WdGyC+MRA?=
 =?us-ascii?Q?oQw+LFLmz+KrFjPBRge98vgfOB0QBaNSGpgoIgUXgQrSNBJq1jaimZlu/GZR?=
 =?us-ascii?Q?qCDuDokObCcYPf3cNS/SOTTtz3lY+hIozjdS0dvj2IxRhWn1rrHJQwrEL3bz?=
 =?us-ascii?Q?3cYDK4+H/2RQjeWbd27R16wIahbk+bKwvCc1ZK+Ha2vQoJHOMuEpuUe2W8wU?=
 =?us-ascii?Q?cezi7a3CcLrWqGnrf3tKRjpz0Tk1LzgSkbkcPtzkY+bIYvHXWRcxkYJYHKH2?=
 =?us-ascii?Q?wLM9PrXfudK5kzIXU84N9DX90bc5mAYtR+Px1EmORTzSIwuVoI3UIRKBGZcT?=
 =?us-ascii?Q?b9gcaaQclD4sMOX+il5jssVbwj0URDbhmccq2LX+AceMKw7aq9TBSBzWgOaF?=
 =?us-ascii?Q?D4rXLZITC9jMrbBHzd/BFVuC062PAhNsGp8I60PEB1ePoBc5WN7KmU+johq8?=
 =?us-ascii?Q?pUWG/hFOfyu0CnMSNxN9qWvLzXxC6HN1fLDu2MuWuG9epnZ7DZ3ggkcHdO7O?=
 =?us-ascii?Q?L5AQeNy2KwYkO8/UNspJePlIADanRX2EifV2BWKVzvD2zda7VL1/87nl6QC3?=
 =?us-ascii?Q?jZcjPyI/FrqT1heMUp6EIfZpNgosfS3asfFxarLzpZ/ZiuRTcjkXyYRZgaP6?=
 =?us-ascii?Q?bpnVTvN3ZWzWhE0PB2QRA6R7OnJjEhYXB5Y4L1/w8Cu5CQRxRX9+nLyC980H?=
 =?us-ascii?Q?/CzOzB33Y5bmguO/L3WnbA4kpRC3KzZxbKNM1OzWTdn2ewB1imxj7I9BlG7E?=
 =?us-ascii?Q?wKlGyX2aoBDujwGP3obA4udIBnNCiqgE+KElutVVASDVMIO/6Ti/qi9oFHhY?=
 =?us-ascii?Q?xYksCrEs9P4kA0SqQx0POv/6+Ebw18jW9GRWjgAhwPedvmka8YD+B6Y8/MNH?=
 =?us-ascii?Q?3Y5K7eYz3pRwevJSXpxFfg4jUveqdxCJIVMQyXQb6HOdaSXjZIOm9haXE6qV?=
 =?us-ascii?Q?0oEF5Z4Bf1df4kL8X8jF6ufFPb+WGiE6OSOGYr77rMDqATICjHafjTDQ31nF?=
 =?us-ascii?Q?pa666/3Vp1nN4CinD66Ofl2MFTf6LC3Tr6OtYwgzBXqh8T+RY2KbFV3YHViD?=
 =?us-ascii?Q?4t+GTdzNVW3+PDYXWb12oOksb30xPDN6YwhbnaTmoBuAJIzR7XENQ5BKuBuT?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb77056b-98ff-49c0-7c16-08da63ef93e1
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 10:16:25.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niJBDVxgR+s9Kq9ToYEbQifQm0z/JzF96zA5JgU6oNcBEuTYAoWeS0su9Ai6yrz6z3CqqxaunUcRf08zcXs6YsNrNPrEHl709+lfgpdd5Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0165
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Any IIO ADC can be used with the driver, so do not depend
on VF610_ADC.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2d70c945b20a..dc90a3ea51ee 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1335,7 +1335,7 @@ config TOUCHSCREEN_ZFORCE
 
 config TOUCHSCREEN_COLIBRI_VF50
 	tristate "Toradex Colibri on board touchscreen driver"
-	depends on IIO && VF610_ADC
+	depends on IIO
 	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have a Colibri VF50 and plan to use
-- 
2.25.1

