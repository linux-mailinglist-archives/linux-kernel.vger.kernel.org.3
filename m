Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E2554ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359097AbiFVPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358862AbiFVPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:12:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075095.outbound.protection.outlook.com [40.92.75.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26603EAB9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5eRM/EKLlqvcLEEdCemt5bC4VA47BfQHUe20kyt7J5sHN2Y7oNROT4LgMMo0tn7c9C163g/D/xzrMpoXsXxRYT2k6LEjgEVfqt2HDULrrsj/AjLyy0XCs723e1yQDto0eanjoq+Z4vbbVJHeMW5DGbEbsUOzjN16udBTo+Z5x+FODeBJLAg+zXfniIR48RUwpg+Rus/MKZ0Ki3kGILx3+7ho91dKYcIWOi1uXoq40o1gA2bOMo+swd/fxH24pcvcaP4S3uVlwhHE+2t5TcsJ8re8Sm7xyLG3R3wH4efKA5G60yd1607cW/SbzH6ZYI/vsUtfC36opMZehISuahkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn4sEBEiEWUhZ/vsdXprt4Jb9PFngHHWNz2hgFdKAWU=;
 b=UDkel80p3reULHWW/2hMiPFsak8859PJhE0uu8ZzuRZ7Q3VKqCf6FPhWuBFLEqFduPWBamEy/Nodz8XCPX+djiswarRGiX3xDF41Er6/EWkXaSLXDpHHn/JcpKkLpwLBzydRwbmExLZwNW4UZJTFFKenKzQ9CUAIaxsmIWccQN49lIkuufd+wASj6tMD7VrQksFsayW0gvuMhriRysYLw8bT81QhoBWq71BqNVEovmkB8GTLcFzUFEdolQf2z+zbGiXTvFxpAsZ3daMvxTdRja6A206QumflxTmuO6l6dX1yiKOJjDCQnaICIgWnvFsyA4i6AQYqc7IZuPPDAQ1obg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn4sEBEiEWUhZ/vsdXprt4Jb9PFngHHWNz2hgFdKAWU=;
 b=ljrU7mf8IjbABoijQJ3huFH/+jCqEzXNXV4Nux4DPVCQPJlfH0a3KQkm1QUieRlSer/R+EiMTRzxCIh3r4Ur2tvswfbTE/Ml+cOkVhn98K1eVWb7hfMDKwYl6mLG39dAZq8R/ABkhIskZiWFFWkUxPZbs1OUELMshPb/jG92EKAEe/1fb7n8ippX79svXENo102B2xARiOn72dROkJ1Z4tkRZzXkeuWxoCZAZtj9YFxBMoVAkqfytQ5Z2MHd5NUenLoidmfcgiswJQXBzrx898A+XEJ7/xRjDl0os4nmsEo59z+QxRCRo2dHJJN5+fAk9FxtT64CsseokN4fTU3y1Q==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM7P190MB0582.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 15:12:47 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 15:12:47 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Staging: rtl8192e: Safer allocation and cleaner error handling
Date:   Wed, 22 Jun 2022 17:12:43 +0200
Message-ID: <AM9P190MB12998F5B07AB1191DC54E62BA5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ycFGbqTmiLU4kV/hLIkFBnvN3vqqaiYw]
X-ClientProxiedBy: AS9PR0301CA0044.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::16) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <cover.1655909205.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04c1b1ee-2680-4d7a-0600-08da5461aa9d
X-MS-TrafficTypeDiagnostic: AM7P190MB0582:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T26VmuLf+UbBCTzQOIwxJaQ020nWqe6Ugt1drnkEspM5BqgFXgFCaC2lTy/it0rZjMYrNW1D0Ijm1M/sJJjNMTMfVBySXQ/K4rQpDokn7DmaDeOgPfasi33RDHSPoR08aHswkfssJPaadKEc4q+fgyue2c0v1alWqwGrxBZI2uOBbkvDAGv3MtHlZiIqTaLKCR583zQiJ8Zx3rph89ciOxERqZj70PWkILL8fwXjY1vvQXSM+FWgqB2wp311FeTjXfoDFpwJow6tBZme476j8sJS4524aNpfxe7v1zGDFYBm5SgZQcShBNGfX2BiZX4wgz/5qMBsVs8l8KbeCU6ty25uNZsz1Dbr1nrkAMSrArHG6JV8mxd0V9UESbEiWgMkvFOjWdvVssx4iifPSVfQ+WGftby3OiyD3Cg2QfaMnopEjqGZLR1yoTX46Qriu5m7zX+9Jbiuud+jHQc6pmuQQTkZMgDU4EzFGFJaQC8GNgeKP1gpyAzrWZAYppIjjMaoRJAxL20CXeDwOYVVQP0PCkjkh0ryJR2ARSnNguBqB31dxDlkGdAXjcCOqjHh85CZXrrf0fTSNhZXWvnvCXTTvwcL+LEj1GC9xjzliQnN6vGAPbGYl9SDC+AITsZ0y9EhNn+4oA+m7zQTl0SRKBvcJg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rjjCVoaXLza1ok7uG85B+/3DUYHWeC+RsbbP7MwT8E/EZpp6GorkfJy5WqD2?=
 =?us-ascii?Q?tgtaHz6tBGJP7a4Ir6lrOJ6+OCl+x+9KrHfWvV4/DuI63QMuVYFT1xhLFe5F?=
 =?us-ascii?Q?/L1WbytrubR+KpbbleyYMpKg6+NcvCoknxgxwp3N6FRa07O25cgD518wonOp?=
 =?us-ascii?Q?72kStpOF01dOmpxwtutqb2Y84pNqcX8DU7eQnSivjulxxLW1Rm6XY4fNqD7X?=
 =?us-ascii?Q?SAO2TYjKbBOGrR0KagC//QqOZoAEp5Ymh2H8u3IVTgIuhuQmuLiFtL92jv/9?=
 =?us-ascii?Q?PvTjDeRfdahsd/jXibApwOORpg2ngDpEhoWO6olY7VcAyORD1WP80yG/1oGt?=
 =?us-ascii?Q?KlE3McuVCI3TfUHitJA+mXKKzq9MIiF6S5XCgz7FoXx6RE5BzkNOYN9CqaBe?=
 =?us-ascii?Q?S6jiJRLSl4LG8chmFslm3wQSQsIaDqW9vUUsU5F/xw7D2DeQCq1iU8EBC12R?=
 =?us-ascii?Q?o9xdDjn3mFLTu/nK+Y2cL65A7DON9DeWYwADlaOkOKgvemKIJLF1PLPvk/G+?=
 =?us-ascii?Q?lx+o/MbCocXBkivhZ0guB5T14ZdSxcN4G3NY5IQKO8swuINjRAa/C2DsO5Qz?=
 =?us-ascii?Q?IDvkkwBof89rMqXoTGkfCzqx76ysHHHiQbKQKAcazQjJaU/DSLgWDieykzaY?=
 =?us-ascii?Q?SaI7+rQv0GpeALG3QSv+IKnOFcAAbADbTxMsKhbXUdZBLg1EYcB6GEfO0XI8?=
 =?us-ascii?Q?lJtFRlTy9Z0CeeS3tXp17ezfeU6wa83i9TaPDvlvhSUTX2Ze/pe9koaShczr?=
 =?us-ascii?Q?+BB5zNntXT1XL8AUZOJ7IUE00zEtstqO/HREdTU9DDYKg2ljwZ7flTC+NqW4?=
 =?us-ascii?Q?9j1SSjmqsoVCAV/Aqrd0zqww/JSVAoDsZtJkjytHh9/Llxqmj9Y+YIaf6MDl?=
 =?us-ascii?Q?6FOKb0Umdh90M6pRGVon0IZm0RrOo2xCQX43/xQqTDO1aJ5jKPwepOmJloij?=
 =?us-ascii?Q?EdZYyY14rkpyQ1WV9GyUC10adF2tl2qwPvf6Yu62mk8C3gf3riZjk7SDhO+i?=
 =?us-ascii?Q?C/z96BaiKPAK60wO4zGu+59ouksxC2oLUkzseS+uDlK8fyRG+gO1ARn5l/u0?=
 =?us-ascii?Q?aHdnavRr0pjhZITqHHsRvcIzpiNigZpDZvS2yFWmjMePuqcC1nTuTNoTQbis?=
 =?us-ascii?Q?smGc7FrC7hkKt5HGpJuNV8WKf2iYO6EcY98ZXYNxwajUEDkqOrB4nVjUytu2?=
 =?us-ascii?Q?fj7GEYFuJOBLtBP7O8C6jmse0Y+sNXmaY2k7rA9KXRViY60hveqoCCwA63s0?=
 =?us-ascii?Q?Vg9IBAaRtuTD2l41J8x/ZxvqRAK8SEhVCD3RVvTHA4Ve+x2cCmeNyemSvLkf?=
 =?us-ascii?Q?cjMcic7kj4dB54lc0pZ8fCxNpuxnwaqWgA6ak/T9EIPdTn50XvGkatoxe6oS?=
 =?us-ascii?Q?9PXfu4DWs/BDnnxICO3aj11+i1zCpJcpdtGzRikQv5paGBkAnQwn71a7kATu?=
 =?us-ascii?Q?Wgj2MowxqvY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c1b1ee-2680-4d7a-0600-08da5461aa9d
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:12:47.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
  - replaced kmalloc with kzalloc against memory initialization defects,
    thus also removing a memset
  - made error handling more consistent

v3:
  - Split into smaller commits so that it's easier to review

Felix Schlepper (3):
  Staging: rtl8192e: Use struct_size
  Staging: rtl8192e: Using kzalloc and delete memset
  Staging: rtl8192e: Cleaning up error handling

 drivers/staging/rtl8192e/rtllib_tx.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--
2.36.1
