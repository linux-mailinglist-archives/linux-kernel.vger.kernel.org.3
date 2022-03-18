Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1144DD5EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiCRITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiCRIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:18:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B932D9198;
        Fri, 18 Mar 2022 01:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM1pRZBlX/2PPRARAIpWnRtoDWXIll+nbu/MrWecfXGqvHVVo+W8QibV3IcxJ9w1fMU0EywnRhzJ8kBH82yU9kCJqLkFE5+ClEAXBnMCj8xqUS7mnaq1DqsD0xnN2/ox/ADJIMlHEXzwJvr+2Zh8SLxbnsF4NxgD2wUoAcTraXoMFerQiM4HFaHCP03+8Uwr1b7mU3mjSNGIYWeVBkHdIm+Tc2fH3ZxUgeTsKkwFRKackajQJm4jly6Et1o+OuH+iwy0u8SVP5Dtk+hx7pnTLyLo4G/ZnqjeOzLYvd6vTYuXBvA6zDIxv3j8HKmqahLJDbTQqgJc7sjIDi4DyP/WOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmiwjKiLpp1ieB5rDWXFsz70aBHOHo4IFQMpx2g3/CM=;
 b=QM4USn8iCkD7u1lzA14gH5iiZGkRC0uYUj7hrjuczIcPHtG/89xXwiElp3vXvLGeOU+uyv5ItBN/AngmJbgOHH+QXsLiOHtrkQRStOzZfW/sTEc+fLvu3nBdaSXB5JpsmGvXtvoW5/fdqQ6VasZ6kQxGOQhcJ50mY+YC1Y6dtc/8oSmpCsARRRgJof0PnJQa5Vhzb1IvL8lRqyQJ2JjvRjzC7l838Y+V+DGk25IWrn2k8nXl6a59U+ypkFthlC9BKtY6IFCziLlIYkolYmVW7dovmUs3ILWmi+YSaSmsW5YPvOvqPYLtFDZW9vvnCc2O88i9y9eiVhGbd6tumw/QhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmiwjKiLpp1ieB5rDWXFsz70aBHOHo4IFQMpx2g3/CM=;
 b=gsA6Cu/U7rJkOviQ2GwFqSQnf7Q9gvmqsRjru9uOBrYj+ATCPZzz5nXMLErlR94QONWKufePbSfIatRpBh0SCeivL6UR8Rw0hnPpIjn0mLza7gYjHC3/tiN7Im/Ge8V1slyEh/QnQBYKKEJyQ5ab3oEBbl9SGucXQU+QIATXPuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by AM0PR04MB3954.eurprd04.prod.outlook.com (2603:10a6:208:63::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 08:17:35 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2%4]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:17:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] imx-jpeg: Support dynamic resolution change
Date:   Fri, 18 Mar 2022 16:16:50 +0800
Message-Id: <cover.1647590462.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DB8PR04MB6346.eurprd04.prod.outlook.com
 (2603:10a6:10:10c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0120675c-54db-4c34-21da-08da08b7c1f5
X-MS-TrafficTypeDiagnostic: AM0PR04MB3954:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB3954FCB3F60B2F478235B820E7139@AM0PR04MB3954.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZm+N9/xdJHSXVRhnPitNp4bR2UbOsdELsl/eZZ/I3LbhSvkLUPP2YNdZDJsqMP0kFZ+sHveut0DckQadRufJVOTVte8ozyCzMUp82j7Oy5P9od+/gO0xbrWrdF794W3NGvovKY8HuvzwjuPl1mT9rDcvpDP7oJIsF4aJQaaX1U7N1JpHfqQXZfhYOQ6BNzp58e7mmhJ0cTXBVxsb3tv8l6Qc+B3o4wahforhVKPED69gsKdjXY15i3YOOjjb+khB9F/IGOFgafYssLr7jy4qismuiT8Zkd/nRV/Bj5WZwgLOZtQkKqPHZW8fWJGMu9Es7UiH/2YSH+i7jrt7YcN8lyMbRUOOmbHatqjoVZsmG/Ep7t86sAMU08EQwgKZae848+9WXoaFs0I08llhDDDUTlp0iJ5/ABKh/IDJ7Uo18YxnSK+NhMTUAy/h7TZEB3WHlGzkL+EN7rUi5FUsTjnsoofLioxr1En8Y5JvOkF4meeG553qUs2pzc69nz5fNqyknpeXfZEo1Ct6YIYQGbGjjgtvEb0qST6yGEAR13qOzK61TG71RjyI8WZVmSQe0aL9nX8Ed0R91YslBNfU6DvaNJEfsqAJSdBL/RmlSyWIBJvJK4HmJNVhVA3bWBSmUqn3urir5DjV9qY8GzxYQndJ/5rLzdytpvD3lsNcX8kjA1DGs3TXuP7M1IaQSYNwtf2K7L90jnDg5hbW1KKNtvfKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(6666004)(8676002)(4326008)(66946007)(86362001)(66556008)(66476007)(38100700002)(38350700002)(6486002)(508600001)(316002)(2616005)(186003)(26005)(36756003)(83380400001)(5660300002)(44832011)(7416002)(8936002)(4744005)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zaxBGKpXQbpCnyBbE2KCN415bV5Op9tcD4NZ/RbYQF/GL9RzhgJ5DjifKxOs?=
 =?us-ascii?Q?+e4IwpIEW1E2fNTynGZljpXhYyD+viuYcD6/fijMAJRRqJhLnY/eN3wkckel?=
 =?us-ascii?Q?WP+6W2xtmgeiIA7L+uNuwDtNQmoR+LJzY1sUpjlhiCRo0KOmTfgWUqQzS7Zj?=
 =?us-ascii?Q?TZSAuccQlrCy3TkM7iXimGT9yFq8NbuSwATp+Owp5axRTY8IW5ajoiWBwU0l?=
 =?us-ascii?Q?+lcNqbSDG6EV2yflp+PgwMxcanysg5NubB9CPz0Hw2FV4MxfeQfN3yQaLgcr?=
 =?us-ascii?Q?KRb/KH5oiN9QapXxVZUh2IalIGda+aENN9eslRhg9uBb4OUzOtZHJHrsJpSR?=
 =?us-ascii?Q?g2Rgom2Rcrcmyjoh5+9gen7xnjgGWv9xdNwDYPhi3CQ+nJTDtQvt9d9E4azf?=
 =?us-ascii?Q?3I22rd0FzdQo/z+EMsewGD72EgOf0/rbbhpy5tPAIW8gI0lfc9Zd9BQNhQDT?=
 =?us-ascii?Q?rD0XOtMT97NhMpnNmIaQh5spNH5I9UQquYc2sx94WiFHI87xkqbs0ur2/uyi?=
 =?us-ascii?Q?UtlSCm4hcXwqjfExy5W297Cdzu1ebpxz+c86AGoFCHZKOHZDBIU6DxiCQNxm?=
 =?us-ascii?Q?Vu+n6mrjN6eanOixxloJ8B4uh/ZW2FyupQEBXS5sg187xP/rX+jWRS6fHHVN?=
 =?us-ascii?Q?FOtOlz918Wg4RsYZWRzJHA4IFfyi1HsVNg+zu1VhwgDzbdceTkG9wFOvd7yD?=
 =?us-ascii?Q?Fv/WDAtHG1rNaMr3yv+m2Qm13w0bgmGOALBsiKns3AmBfEy7rAkY1isVZgKX?=
 =?us-ascii?Q?JkytxYTeFGNERdWP+SnUJs54uSGF2i/0iClvrOdD28BRFem3TqOu2QTpfe3j?=
 =?us-ascii?Q?UyryCxKuVNvq7f/NBil+cQjf7OPQx1cmj4/QSKxpaxCLBcVj+yaTCcGqSZZm?=
 =?us-ascii?Q?bugy7HWqgED+Lk9VOi0nm0nvmLeJ2pf2aeIOTFZc6rLWBv2B1p873Npx5ijS?=
 =?us-ascii?Q?MXwxtiZOBU/NfxaPzTrpng12txuf+jTzNItkIV69b93rHX3RXlqoy7QFifpR?=
 =?us-ascii?Q?UbUSS7dChPSxCJKpiDlkIF6MhdwrA4+yZe1ZGTI27Ag+6iAyVMVSjMUFniZl?=
 =?us-ascii?Q?aEGNzWwwg/mZCRls4mxXRO3z3ixsnIMvVms8yzIj4hhWsDaeeMkErfnhKRRu?=
 =?us-ascii?Q?VduCO0b+SOv63je7yXtNj6haDWorqc+jLYcV19nVYMLmMRbPT6Eji3B+7J2G?=
 =?us-ascii?Q?x2zNZ6t/wXk/OZa+kz+jNLjnDNfPOzLA0o2FkS4w3mcrYOZFXs507J2dLz1i?=
 =?us-ascii?Q?wiOkacTcm2pGTR36M9wRrBwA/Fagky7Ag5FkB7soC2nztCvxyNgXRtl63s88?=
 =?us-ascii?Q?KqQhKFxQk/hUJ9aC+fBvk/OnxuY+fcmTiPoEg5VoptfPKdBfuzpbkoUZwnbo?=
 =?us-ascii?Q?VVnLtx0aQ53kQCIJsvh8xXmpK/hO4Odkm/vcI81BRMllYABbyVJaofc5MrrW?=
 =?us-ascii?Q?YITqlaWxQGv2bdrJjI+3Sjyh6iWV52+J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0120675c-54db-4c34-21da-08da08b7c1f5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:17:35.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCDABCUtXQU955n8MHtWA0t0wW/6+IyQDfVye2mM/vhSavIw4Vc/6coEmJE6gBbzR6Ym2e0hzAxpySxqq9KFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3954
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

 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 244 ++++++++++++------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   3 +
 2 files changed, 169 insertions(+), 78 deletions(-)


base-commit: 71e6d0608e4d1b79069990c7dacb3600ced28a3b
-- 
2.33.0

