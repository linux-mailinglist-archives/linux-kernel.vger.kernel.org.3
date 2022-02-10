Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBE4B0863
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiBJIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:32:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiBJIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:32:39 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300094.outbound.protection.outlook.com [40.107.130.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701CA25DD;
        Thu, 10 Feb 2022 00:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjrPhPjIPE1PMCdB/nfkzHNNdV+RILY62Ge9b8mgZK8rH/eJ932C+bznic8jTWgS8ul9SfLYQRbv7iACIQCZl2UNgEuQ8qdTju/z6MQDX714XpljNWWqVWrF/OnF6A9WQHJYQAmnYWvPyqDEGu6LjkZmcUjwqts5HzdNBHLYxohMfJNeMOF20fPN7uWulxIO/mxAWanKNNzOujrBwYOjE/htPBoIetek6ezfikxXlqvQzPQJWDzT4pBiW+sQWQjubkYVNJQTU6zxXb3VPXVwbTV2Xsb8tjtI7TwDVWhwg/kneGrTG3RxmP8RGmFaO/mKFXJ0mygYWziO718chngR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ggKPGWl+X0iwvVauYUDYHRVFeOlbgtEvySwTrcfY6A=;
 b=FscPzr0Bm1TaBed+YoSilmHKCNRgrVVoqGiiUJjklneocQtAdiDWR7LJcom+zh544/Lv9tQi77RtDBh4bavhrhn/z4bN1rZ9cdFyb6QLAZ9w8SuBv3q29+yOSGuguaMpg0qcxmO5D0gmXFnTQsvjU3jJFPojsP6GPBD2PTSm50l9bb8P7WLOU9rVMsAZLaEsJ/dwGy0O7ZaeyU92eS5J8WIuYYHiZw4gSyaoYaDixupiLzmf8k2Q60FDZdhZcmaWyh+ZS770gKQcwJJ1/xMhl7Q2C6xNI3oIYgWDEMlBclVzhspeNevuEouZwXTEQc905OxqrbkiB8zuk1LfeHAACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ggKPGWl+X0iwvVauYUDYHRVFeOlbgtEvySwTrcfY6A=;
 b=b6BP5AxuC78pi6y+N+NoHHN+9+yeOndixAUWYGckiVR7fdRR3WmYrG6uy8O2aYJhFtzxRsuXmEaUK1DLMxC1wTlwdu/c9nSCiuD7P17V8WycboZ3P9caEF++iK9S2KfUwAqvG36S5MhyN+ViiA+jdHz85V8/zbXSYbmvsgBiOeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4068.apcprd06.prod.outlook.com (2603:1096:820:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 08:32:34 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:32:34 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] media: tda8083: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:32:24 -0800
Message-Id: <1644481944-15001-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f83c7b8-1bd3-4628-4cbd-08d9ec6fe29c
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4068:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4068A9D912E1878140C29DB7BD2F9@KL1PR0601MB4068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT+yy0i98QToRZ8Pz42Z31lwss4LZfv1lJSNrRiMgAUghLivS1BaJovC68sYqK7DS7f8fuFh0mY2TBMjWrxqK9tlaPcGSnmy0Uh0ync2zmrUbMOfnprVK8woGrmc5AXpPIcfgWSUhPKpXM77qqA50eh8+C2Npw1ZdqGPLLH2Lu8pkrpBWwLQtgWgRD8f85cvJ6B9LT5OYl9wBrlpVIoYn7MsAcrNiHZIOxQyhV0kebRss2JscIXbuwYa9DqoJxoZvpNatM8yu+muhBtDjTL+gVsAXEoSEBViEIHluadetRIBoY9/n6xU+npC3UmrRiOaJgd+FdPvHKcPBtJvjDPag7Hk31pG8rDEB64X3JfZIUS8mZgXHILs8Y8q/jZV1/9Y5Dgi1v3q+Nt/9OpG1GjpDdFNkwgKfSpMvjF9jAU9C1oh5nqvwLyPrfzBwmqCmFFKERfbMm2jK/u0pXW00LSk1buUkMUXQaTQHjkxYvYrZV9+XVsQQh4f2eM3eXxnhDM5RATOeTmF54CJunlfs2fBw+O3WyX3kDWx0i0dQo2tRp0xmcJqpsZ9FwFjhK4p3sMWe0lOStGljFqXGneAdZZRWJi/FW2d6gt6enaZvsVyXSHi2qlZRDPnBo+0zaMleqg9Tr/HruKbLsn7/dic4mmDFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(86362001)(186003)(6486002)(83380400001)(508600001)(4326008)(66556008)(107886003)(36756003)(2906002)(316002)(2616005)(8936002)(5660300002)(26005)(6666004)(6512007)(8676002)(66946007)(66476007)(52116002)(4744005)(6506007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cHDVLmpvHVQvMun6/1KjlE3YRq2dmaz8jD3GneR6J3LqsSwdLHwmkkWvxCcbJLEPoQn43//yoza2UmhCaL+b56wtoQdhjApbwjmYLPEtpEbHOjEb6QvWvosK5WiUoPmfMaTBYX+QQxibTvkjVui7k3UiRihj1jVDSCXsC9m1aW2mIfDtWTFj9+vJGWnq7oVb35Kh68sO/vEVSVlCawzZ4VRks6lXrA9gvzaWc9kxBVu3LXzmvoobPkVrf225ic01PwPssENSW2DkSpgROAUQr28MwMuVTKXw+J2z9ktNn7o006X9r2E1RWOytnTCQqhi1YpCTRMRKqXd0rjSxfin9XFAYMiCtuQ1sTIt9EtUBNKb0O9tGhY0F3+lqlO2kT5jRmLBwq21M6hdvQTkutWFkHUkHlcBfrv+pH6+8bcvg7wVA9VEV+tWhXVp8jVcq4QI
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f83c7b8-1bd3-4628-4cbd-08d9ec6fe29c
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:32:33.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkvwVhhZoiPDtY7EC4D5xTg+NjL6o9w+nloTlYM0LpYLAx6+Fba3g67I0DffgiTz1P+ExWjgbcjjPiI83wCwag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4068
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

It is better to use time_xxx() directly instead of jiffies judgment
for understanding.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/media/dvb-frontends/tda8083.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/tda8083.c b/drivers/media/dvb-frontends/tda8083.c
index 5be11fd..49c4fe1
--- a/drivers/media/dvb-frontends/tda8083.c
+++ b/drivers/media/dvb-frontends/tda8083.c
@@ -162,7 +162,7 @@ static void tda8083_wait_diseqc_fifo (struct tda8083_state* state, int timeout)
 {
 	unsigned long start = jiffies;
 
-	while (jiffies - start < timeout &&
+	while (time_before(jiffies, start + timeout) &&
 	       !(tda8083_readreg(state, 0x02) & 0x80))
 	{
 		msleep(50);
-- 
2.7.4

