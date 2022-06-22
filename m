Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6345C554ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359129AbiFVPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359126AbiFVPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:12:57 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-oln040092065104.outbound.protection.outlook.com [40.92.65.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD973E51
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvnmX7HXUJPouxcus2v4mb7tkcF49Z4WitXy3jaJBcDhI4HXNCSfN4sTApzLkyQ3OdFXEj0xvMJowyMKUSBU7Fh6Wam6M/5gp7SwsU3SYYUG4oxDQhdN7goi3mxYperxDRKEH1+UOGn4/CH0yX3iNxfKKUV0MxvFh2cA7ExzYaLMAY3VmuTkFFBgXYS87t8+KqnVCmm79iBZaYhhxlcSSPZB/hhc3p4uoZf2JAR+tjVU3mVzG8nAqdn5MFKZT31HVDkDXS1ovxTNYKFJ+kGrt6LuCGfevViDb5uM+oKY46t68wEHTOExp5fAgRx4rvfCAL2dJFkd0yOfnQI8ptk4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbj7WHQf/Rs1qFDF5NLSsjUCq+gBzeq6hZQQ0hUOwo0=;
 b=YFmlGBoAagqxosPa/ed2trSn4Kne3S4No3xR3cngMnEja8A73PCOtFXnwL5Vhv2AWP62ZRfsELki71bYMsvqR7oXuKe2srlycRZk5GQkewJO5s8bYG0eAGujThrHYAnLXXn0RUbYZcXQ7fAZ2f2u9VSMjOGNeHDyJhyQA15bNftRwovQbbI7PCUg1/AKeIJVuqCvPmdqBWP6qP0C2+qaXD1yLJDoVtJewpuE2bcboCSC42K2ggxgM78E7tnBkjq2mCwrS9uRnA+UOVKI+tYrLxb0vlz+qS45tTI4Wo4Fjl9xmFmHZvh6Eo99o15ssQfQHBl9TWdjrfhejm+szNfEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbj7WHQf/Rs1qFDF5NLSsjUCq+gBzeq6hZQQ0hUOwo0=;
 b=dYD1AyCIx5rl2ytfLjEBn+WOCRF3Q6h+zas4SKSbKC/fS/GmB3rfdF9hzrzuBJcCwf8Clivj1rbk3ZjmM81Yi6TlQ6/a6swpHx8j297WBEkuN24qfUgxjzHxA7JaT7v/g+OxuW/Y3RmttlO0w82DGBMYpq9WYcwi3x3jgtkwks+1IgT2WxaPaEG1B0Q/E/tAXAEk76JUYHWnYOUVguFoEi3HpouXV8XPYzA/ty7L56aujYmdvodOJzJhc1nX1OE9BrO6LFeOvNDCtVE6AT9YCjv7g4Vokz+y3jlTrOTdfdb8CtEz2ahTyqp0eG3nl6B9rrCKhEMMNnAPAeQKdYFTDQ==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM9P190MB1041.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:261::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 15:12:51 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 15:12:51 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Staging: rtl8192e: Using kzalloc and delete memset
Date:   Wed, 22 Jun 2022 17:12:45 +0200
Message-ID: <AM9P190MB12995D1FF1EECE4C633A865FA5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655909205.git.f3sch.git@outlook.com>
References: <cover.1655909205.git.f3sch.git@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5c3w/I4vcSH2imGGdhMB4ZabZlJRnrz7]
X-ClientProxiedBy: AM6PR0202CA0056.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::33) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <6f31c80a18bf00c80394b9db349fd604d95116a4.1655909205.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19df9361-ce78-40dd-2f16-08da5461ac7a
X-MS-TrafficTypeDiagnostic: AM9P190MB1041:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xp2vQ6S5FT0jeq5ozUWup95kf3loe5B8tuhQ16tjYARfGlgmws+nH7IJypxgFOa+E5MePBZ0HV08KArUEd4G4pIoNNKXLZqzP54+vt6eOa1vGq62x/jvdIWYujZfFzwDZvN9qmcwn5rBcLmP5ee6B0A80XbDefG+oS2L0Ceb5yVa7JqYpTCNSe0x4z5uRiS0m7hnvISb2BtOk3zqpCvn3Xhto+EqZMp2ZPM5KpV61zYRKDQxIK7//41weoeBjvZaYp2EjB7W5ME5WS2rqYkicUu8rixN7bQQ9OmRurV/82vwNGNsOfn6YmCNCOPNdrCEXBGtaAdFXjDh3JYPL4/bsol36TK8/nT5e6+bCx9xxIhFlOaX4RQwbwwr7XwQJkiO5g4rJPwv2r963txrdz8TESk0XuqRMGBIoBGdIH4e7UQ4XSUdxalpJdsXDkkoTlhkqO+xRQRQgVTO6Qp/s8zcKqm1xazJJLau/GsLFkj9+0VC+NudC16twPu59czczPLNT5yD8nH4UGj6csbRDyageZwmdxPuxE4n000j0U5Z2iPnQfd56MLdBUkF3mgVWz2wVCQJQ9z52KFLcEZlIz/RTe1t6KtMnI9owgW3YxDg+gySAhih1T2vU943xsNSebYB++HkxMp/q8o3U+2cA3HM6w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YHl8tiAKwwacKbRqjLULS8L7wVN4evhZ1aBL7BLU21k6xq41nwY42Irpbblv?=
 =?us-ascii?Q?tlSal1FjIwVyW8G/v7CbKZub090TSCzx/CheZZpznfrSTOr33cIppOXX4AHb?=
 =?us-ascii?Q?PzFB3MPvhgHcw8PKlQn8e8lfVLYhsE7WF+8wQF7gQrn6BKSyZHELdJ3Ktmka?=
 =?us-ascii?Q?X2M4V/WCCuHwc/YKS6yUHqSShCYsPYvr22zxy8eScFolkkl9v1UwM62mIgFK?=
 =?us-ascii?Q?FNaGc1tyrxjJNJ/7GB1S4EYYw8YHcrUmbq2Jz2vQR7wLWHrd5tK+grt2TuGD?=
 =?us-ascii?Q?FqeCS18Pj3uf5rsdyBqHXF0v+hKkJRmeMBINiU28sak4HVyWebi98w2Xz9uG?=
 =?us-ascii?Q?xOEOwP6+5q469ZgKNgy6bCdmC2Uaz9v7dSoPFMWgii7E7Cw6dnBd816deNiJ?=
 =?us-ascii?Q?0l0dLsK68CIT9EZH77aW2lTxu8Qu8IJnps/JApkYoo1nFmEHTz6P+eq+QjE1?=
 =?us-ascii?Q?STM6oVtDC16pJRPusRy11ZJhucEOY9Rw9Lmq77jZ8J4h2jsS/UcWyBU3LnH9?=
 =?us-ascii?Q?mNhXYGJK4jPfZe8sDGDmkZf+40N8KaaF3YU8bc69kjHSjJI/TE9b8FvrZ/ux?=
 =?us-ascii?Q?C/ggPprAHk+8dIrXTV1IRzo6UK0S5Sp7g8oBDUU8CzofwLffrnm73UPNY+ms?=
 =?us-ascii?Q?4mvX6xmrg17O339Bbo0EkU8P0MQyiF8Emm2Lgew7qBt12mwUWqUSHoHATPKZ?=
 =?us-ascii?Q?KCKfTPm8yfpV+fi5gic6VsjC0EwLBdxyDzrOt+wLcdAV+3lDCQ2HPFKtZgBi?=
 =?us-ascii?Q?zY4GzEN9mCJaFMutkJ8ZkIVtW66DCTlUDnPZ1dYTZsts0EHxq1OXf2bxK250?=
 =?us-ascii?Q?sOpOOmQjz+8Cp5+9rSusxoJ3EWkEKi2AAF4DrTuIrtk9hvwGt66SVCU3lNDn?=
 =?us-ascii?Q?HnmHD+1evHCWGG+3tm0VRJlAjp+XvVK5iYlDJuUyt2Iu0ibowsAuVhRLROiD?=
 =?us-ascii?Q?JOWrBM3ecz+QLg9mLKbla8X4Sx1euKU+CgriNBcTm2kcEkq8PeCdG7McwT/0?=
 =?us-ascii?Q?CKK1HbrfpfhwIUW2Kb/PQnuErXAP7iyzioWGSv1SQn0bAWBMdZCwYWGDPurK?=
 =?us-ascii?Q?3TPDvq7pHkU3bwBc3DD956A6GtTI1fW7a+kVU8i/If51AHrAxAa4uLfoIJL8?=
 =?us-ascii?Q?oUXKiI2M2GhpNcrQJ7LiZIQ7QNuK9oPzYoDOZIsYUpLHV5MFzE3gVBAdo3Xw?=
 =?us-ascii?Q?g6fF8rN/WRUBxcIVvViSvSEKK07sN/QOIcNZyOcXtSrndX/5uOnluQcODIla?=
 =?us-ascii?Q?D0Tp8MCn3eVrdvRgjjh1hvZkjV0sLT8dPtXXH9lbkGp4hV71fmnpfWkf7/du?=
 =?us-ascii?Q?pewEL+WnlbCk/TpSpnKhEalyAGaIvDfg+e3uPuKPe1ZonGkmGheuf004AU6C?=
 =?us-ascii?Q?/7DuRweZPVMQvCCWIGPbzV4I97leBbdg3iatHJ1HUWKpKIk8mBgqBIQK/fwc?=
 =?us-ascii?Q?sdF8fHs0SUg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df9361-ce78-40dd-2f16-08da5461ac7a
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:12:50.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using kzalloc, we can delete a memset and avoid
memory initialization defects.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index f2ef32e943ae..1307cf55741a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,11 +205,10 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;
 
-	txb = kmalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
+	txb = kzalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-	memset(txb, 0, sizeof(struct rtllib_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = cpu_to_le16(txb_size);
 
-- 
2.36.1

