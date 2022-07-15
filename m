Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3D575C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGOHQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:16:09 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02B43E73;
        Fri, 15 Jul 2022 00:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0ahJ/6gfTz3zMBdP9+UNUPz7cVpWdB2BjAmKgY+yHsrERosfdYIXeZeqGMo2Yu5o46K7Z/wH3llPbIZ79SdtEyj1oIY6OsbFoatp4OZ1llxGXTAf6SzN9Hrrm8BNeCkC7KCqfugAZrSzMRLTsek0IybaALWTIPFvHGzLdrOdLksWSYyLNaq63IdO6t2pGDXa7/K1IGxKNWMTzAULbaKbqXb+TRXSqjbW4H7scHMiKSeIP5wPTvcwK/jdHIHOOVeNBB//tOwdwtXvn6m35tdjceLXIYJQMwyHQSicskZECo3ocfT6qu9O50PwSX4ylz0M690jzUDGrKqKDOAatgjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/9evKvtSVnk7gt3RJHci9JxH+67RM/sLbDAF7n9f18=;
 b=KjzHNIFTMH+1LbZRyEPCcHpDTi9W/O9PZuKpGc7YGgBYi1wC6BbbNOgbvSpe/az1GMAQyHQz126vVnPTAU+ZlRxJrSFVhTPKdcahl/NUB8gbWdYMeDe/Cj4RLPRCVU3lWicYeDQujyIXOEE26ojrGWuIGTfe0VqlPWa6i3o5S0Y8ouZF8PbnPV1hzoScSghH+q79hR8cSb5GF1imxymPJDwMW9yIbJiWFZjgMipNYUknElC+Iq2xybEErESZE0VQTgTxEPZ5qy5Q1y7/QN42RuHQgr1IwsaAK1de5Ff0P70MQPwG5PHLsUBPfnLYL/2aR/SrXCtgOwImTZFAc0qfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/9evKvtSVnk7gt3RJHci9JxH+67RM/sLbDAF7n9f18=;
 b=aqQsqPH6XPIBOTs/ZXO1YX2GbeQRIyzBxxScEit+VDGzO9NeqDdmCYrnVJGQMgxINyDTr7F5C9pwgXMa7AWv3sVlaf3AP5gZ64W3srAoq4TZ+QQbEbzZ/gUNMesBu3rULVYc4v1fFI62R/jXqufafCg7ZfEwpP6YVKoF9Plp8qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by HE1PR0401MB2362.eurprd04.prod.outlook.com (2603:10a6:3:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 07:16:05 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5ed:ec65:3631:aca8]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5ed:ec65:3631:aca8%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 07:16:05 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: insert picture startcode after seek for vc1g format
Date:   Fri, 15 Jul 2022 15:15:49 +0800
Message-Id: <20220715071549.14531-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32475af7-2e57-4a12-c361-08da6631e173
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2362:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LKG3kIn37MNxi5FlEsqq8oTZ308FbAus+C/po4in9k22CWkM4k6YNcOqRQm4Z1zIPyodoKJUvOCDwoaFmcbCexH06OAUFhCYfXPqmA8gX0zL88wPPNkLxwo+4rs0ldDYqZ5e5ggT5OXROJzb+o5uZiHaNzLQRdBuO9vRKr0Yxv3bjtuziZUd/uvpelo+X5sk7Jq2rEa9hL2TueWyAgGUVSCSjaqvbIfavy0Bdh0wbnDEOJAkr89Z+my6+sK8n9YRWgYjR/lxOx9OJ/9BXIFwMLGv6Zs5hB9f8ufxdZqlZ6CRUPotA8skDevf7YlKgM15DqZZ2h5B0uxNpDkOgLuGjGOOFHzk6H4FS0uzUGjyqQz87URap29L3IZELYTdo8ILnY7KlHoKBzTMZaMzXN2GwouCdhknt66BFUdoJzB4xU5nw+soa8rkU29jHlLpjKUPvkkahje32uCpN0RvDKs+I0MUl68cwC5Y+q5Rj40qe6x7GmqLC76f3XbnxbPcV1PQuDD2+dkHf9EXuNHloIVQHAXX1VJCQDqFmF8h63WlayYeSM+zgpqYipVagJxVpOiRtVUHKcEiUyCAIs3DcOChbCpFFwrLWMo0J7B9NDkzkobqjRABEW2mFaiel00IJUmUysARUhq8E/L05ZGKHLGal+I3U7bKlW18p1X8pzUY9bnzKCzs4I2KCYhmxh6eClJHTWhB4REO++wMmkb/FaltNUI28IPoo/i2MMl56IgX8HuMqEUnvuNaY8XRXSd58xtXB2bbBsqykRVuFuf/Ykj95MXWUWtfDQVFdDWPF2HEbfyhl1Oc9DqspKo4KWM8v+ympR/j04SfhprnkeTY2UYSnQccW9o+QVOo8++jEsZhRObVnOXxBd1+MflLynUkEu9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(316002)(8676002)(86362001)(8936002)(5660300002)(66476007)(6486002)(66556008)(4326008)(66946007)(1076003)(186003)(83380400001)(2616005)(41300700001)(38350700002)(38100700002)(478600001)(6666004)(6512007)(26005)(6506007)(44832011)(2906002)(52116002)(7416002)(36756003)(32563001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ayy1VYerAvHpXgVu2c6D0nn/ayUuEvBqsOKbhSFhwDBJusZL4BdHtKR9Q8Jp?=
 =?us-ascii?Q?bx1IoyHp/n0aZLRuMn/U2ozMYwtY0kv9aCVlyvApQFA97MZudjspVcZc5S1t?=
 =?us-ascii?Q?MUlf5ZTVzAm/x2jNqPdWoBm8B0I2yIdqmqoAJeUdAU6cW2qbn7xTZfYgUsKo?=
 =?us-ascii?Q?Zsratf9V8uPXg8jsPJNYT7qQ7jXC6qz9c47DqlrlVBNrdTiMULe8r6/Ktf2P?=
 =?us-ascii?Q?I1I5hq+e97kt77ymtMUSzjRzWV0qmzIQMfwHAQJjWSLGuR1hQfqAo+PZLehG?=
 =?us-ascii?Q?5jCx2Hs05vIq+ao7jWJTBg8rx/vXcv+1cUS61vqrwqFc8tzuDg6Qm/yKahQt?=
 =?us-ascii?Q?7/YFUtGQ0EffB8cblsdtI6HhRbOExf04AFnHElD1pDU5szdtCMuLMoHehd8V?=
 =?us-ascii?Q?WpbVcVoe8g83aR4PY9O1zJBrC7m+VIGvrap9IQDGx1YBXbhLX2eFHWas0tYU?=
 =?us-ascii?Q?I6TRYZ5XsmC1L2+7BH3ozW5NQMIGWpgG170r1Up3BiYs015feA53OB3Ps3e7?=
 =?us-ascii?Q?4/Abk4UgQ4jnWlymfbikoa/t25ifwCPZ2TOuxYzCQ5Kk+rMKQVtn0K/g5nXP?=
 =?us-ascii?Q?rMA8nxhNengzqbqllSIMotZ/K5/6+CXGtrr8urG8f9YplOUxhwRCk685naQj?=
 =?us-ascii?Q?wkmfsfr9MFGOpjrpCXzsgjDuDEXs5VsKE5YvA6Ps0lWjWyZImLa3nfcECTjs?=
 =?us-ascii?Q?PsuTwtvYnygj21qWMvTYOB8PAN4kk6BvgM/ChjfNQUuprub4Dd/CAtW/bFid?=
 =?us-ascii?Q?hA2doUUAII55hWgroDE7NO+30jhC2dtR4o9r/P5DdSx2HLSNcYUxRTzoXs8S?=
 =?us-ascii?Q?4E/B2uspU/6cQjJCIHzxWgbIY7HlcvsaenBQABaVjd/4QL+yoweWAJHd+zRE?=
 =?us-ascii?Q?4xkH6m9z793qbSWqvg+Xsn0yhKKe9gKT0emuE9X4cd3LWeCBrylil3nmy2Wa?=
 =?us-ascii?Q?f9ukxpt+saV6JXWKsKFpFzC+41QfRbMOxRBTta3TA40jv5ZM0vWJUMgm05EC?=
 =?us-ascii?Q?Fm9rUfm6iqplKdFjgWlmfoNLLJ2NZQ13XRMs2kqlrWdgHFq3ovJZlkz8+90d?=
 =?us-ascii?Q?azQ+x+0drbpWj97vkxaN8BlcVH2aL0LmAnX8n4C7WHV1RzMPboi2njLRpljp?=
 =?us-ascii?Q?2+kp/c4uCc2jJGNRw0l3YSTeGJJDU6sX1FN4JsNuM6S/hdZDvOOmSby/Nr3z?=
 =?us-ascii?Q?38SZ3DO2BLNhCJC/RdM1Mm3lVJkeSrEqkdATQeE1Wh7kyC+bLIvM8mEBecBR?=
 =?us-ascii?Q?Vn5r7i0FuTmvuVr9PokPPE8STNEY8fmmskkK4ghQXe8GPFAkQZJilk1gvRWe?=
 =?us-ascii?Q?nzyGGKvrCtpaUjOxbdqJqWbrJtjmWcs6d9mJP/NDiLBwh2pwCakHlHwsEJt+?=
 =?us-ascii?Q?2WxDmMfpaTWD9Er2Azg4BRXBku3t8WXhzssMTyMH4NfL4is+8fismDSyQV0N?=
 =?us-ascii?Q?Z6/b0+6KWFVCKtrWaUvmWUnHJM4vsvYyibJvSwwbyAjBBc81IUBXLxR3v9hW?=
 =?us-ascii?Q?UVyfJMT4IUX78SIvMSdkO7lhlNv/7ibT3GyHo/xQ+quepVseXeW4TH9p3P4w?=
 =?us-ascii?Q?tRrD/gbbbKHZ8DnsVLwmbbKBJlgwjwqlQAO3s4jW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32475af7-2e57-4a12-c361-08da6631e173
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 07:16:04.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ss7HPOHwz1KshoyBVsKETpSaFZgYWwEKtQawNNXiHiRFVol6ADBvEuR4CLQ7jVwAQl+X7L+9Rfr9u+4yyR8wkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2362
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For format vc1, the amphion vpu requires driver to
help insert some custom startcode before sequence and frame.
the startcode is different for vc1l and vc1g format.

But the sequence startcode is only needed at the beginning,
and it's not expected after seek.
driver need to treat the codec header and the first frame after seek
as a normal frame, and insert picture startcode for it.

In previous patch, I just fix it for vc1l format,
and should fix the similar issue for vc1g too.

Fixes: 7e611606f6b07 ("media: amphion: only insert the first sequence startcode for vc1l format")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_malone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index f4a488bf9880..51e0702f9ae1 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1293,7 +1293,7 @@ static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
 	vbuf = to_vb2_v4l2_buffer(scode->vb);
 	data = vb2_plane_vaddr(scode->vb, 0);
 
-	if (vbuf->sequence == 0 || vpu_vb_is_codecconfig(vbuf))
+	if (scode->inst->total_input_count == 0 || vpu_vb_is_codecconfig(vbuf))
 		return 0;
 	if (MALONE_VC1_CONTAIN_NAL(*data))
 		return 0;
-- 
2.36.1

