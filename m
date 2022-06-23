Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6789E557CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiFWN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiFWN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:28:52 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072024.outbound.protection.outlook.com [40.92.72.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F094AB1D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8B74A23Yb2EfRsLOEX0kSzxS9+fpcRDUNAQL95SYdpZG6qOwqyxmGmZCbPvoyfZVYNU5Ei/I2ESh36MG9fy9hMx5HUS018FFjdIyAQhfe25Rx9Qm90HzUP/E6Igc0484A24L+7v0mwIFixcVRlDbNndzXOBQ4t6M2wjPQ+SeQTDopE4ZOOJImVLmKmH1eOGaHdOrw5czyyCZQfiSAfKjgN+P+BhtJcnPAsCKR/XMZcgB/phMBsx/oIkpVdwF6HFwfxuLeao7IP1zZeyW5TUzukJBZl8anDFy8OLwqy8hgZFLgM1K3UvZYo59hdggnWrP67o31wke5JGtFaXpPnwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzKwUPPwRsT8aFCwmg3dhf6ejMVeAjjL62OmP2YB0Pg=;
 b=G++fCvbOGf2XNYm6P4Wcx9+PGkWzb3gFdxKENQhVce2gSE8L3FswFZcw0aCZB1m5d52Gahkj+iS3Oegm83TSO6HolWlHtGT5z4O8+w3TfnTzOtOkkvVjvTj6pnVry4OBwL+0I1e7uAeXJeKh38AHRD3EwUaAJSJsY7dVtEIFPd9tw29vcaffw8cf5lf0NFTsLE9K1kOZYkuTQQflAawhABcepLzt9cFfi/bn0Oz8D6H+vGc+PE/MDPRvyoCpUgL0eC0/bmAohBQOHHIycGaOLmAdRv+JzaVfwxDJfv+N8dnDHbI0DOPLgRhNkplUPdJQ//je6IXA78fVZgQ+WK0ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzKwUPPwRsT8aFCwmg3dhf6ejMVeAjjL62OmP2YB0Pg=;
 b=jdVsqD9FxE2nRLb9SwlcEM3/aTovplLi6KyxPWrKto+RbT4TrIP46H6MPUgU47L9h9p3u/fwu0SkXtUMwvUqaS6Lvh9EGG8fiyhI/XtWCyXc1Rhus9tmDJ1kA1vMD2oVZzOfrtsbOYnl/g8IGUahbuqcW93pkduF7H0Eqoq242Jl86KF2K0FAOG/J5cYFuqp/6sPZyut4GoN5Uit2+FCMJwSlSEZJaZXNFzbBXmZItnsPJlC2qXnV4fJhyJWKr+4vO9LORf2T/YU9GSxYjn1eUqxEaKu0EF5bgd3Xh2mM92OJwn31LDtzJbV4Nws7SdZkJ18b2y1havozcdGM3Eyog==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM0P190MB0658.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:192::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 13:28:42 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 13:28:42 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 3/3] Staging: rtl8192e: Cleaning up error handling
Date:   Thu, 23 Jun 2022 15:28:29 +0200
Message-ID: <AM9P190MB1299389D146BD8638CE08676A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <AM9P190MB12995A5916BDAE3F2A8222CCA5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <AM9P190MB12995A5916BDAE3F2A8222CCA5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [M7CD4SDWYHchTAOQ5FnME3NLocgdfFk8]
X-ClientProxiedBy: AM6PR10CA0062.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::39) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a65e8082-c87d-4740-21f0-08da551c4ab2
X-MS-Exchange-SLBlob-MailProps: 6H6McBavlAg3x/+3LEOY9jnKuPfemMPELl+tVhsMsYEsIC02p/2VFEMCyFHjDvoLMFQBaGOchOJbNLxQZ/5cGJEZiRmp9qyXpXDgtdU7J2VCoo8fIpTcb3yEUobx7WShYeDffnEGcQbMX6rSI4cGEs9RfmwOwNBRLJ/eVSxEYuHgHA14zIbMETEOhP05r1Hr6RhqvG8PMS3aSy4ynUBxjQlDx0Zij3pVVVHgT15fDxAc5ze1W1CT9+ucBrzWIOsHqvso6M/YpBuWDFfev6Cohq35VVR33PghsdOu3ZQki+55d6FyQnXAdUn6MLxrjnQE21HS5MklOdJ6vWvHJIlV+J60/qxkpqDKAD8GoO8ZS2YF956bG/FOZfbdH2K9LXuaAl/KN745/LS1nuCxQsig37iEHoSoCqYX01IacFzXXnHo2Q/CvvIaggESKKH+KTF5Qow4UdnpQwUT+NmwTdnKa0Ws76xyrx/fh9oguiXDzyygpQhNbweAfywHJcYn6Rq5CeCRQ1HWaoBoO0UqkN209UKYbT0rr8jO7w/SINgWD9+k0adjdTiG7/MvC37XsX4BmteB9jCU8MtNvUGC4MH4VXRir61z/eJ1JiW/P3u1LtWWFYvNc1Hy5WO0b35XWnoT4yoi0Ck+d11Camz3ERLbq4v51DqW2O0cBl1SMA/n4n2VCmE5JMD2+uhYMXMW0wbyjPsi6JRX3SkRo/OQUcDOXPZD92IyMUBAz/5PqtVU80nzGVxs5XEfti32shTLByYsiMT4E+kzlZg=
X-MS-TrafficTypeDiagnostic: AM0P190MB0658:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuDczw/AXY+C9CjX9pXzSuxjAGXY+wJaugJVdeHupLfq1B6wNG0z3d7yVyJnsikOn5Y2ltVqIaAPIcoiXddH/PEIYviY1PLNfut3CzCE3V+UK4xy8u28uujWdq7ra//aYKOpbx0ou4xddUCLIhCYXg9Ko0MoRY1u8OpgPEt7kuwjmEX+GRb1JN0mG/Onf2KNQZkMrxbixC3GEiPhHZiq9Xq92YD7ia44fqSQcnMlbk8+QVgnDizsrrb50UJdUlzqVzLYsQZcGciM34s6vYehYsjx+BLSvzdcgsrAivHBq8YQmdBieBE0Q65r+RQh+tC2rR+J1xEQO8h3R/xJTCf0a2LZPCRqcel68aK2gLWlMnumVP+hDiCdTmf+V31MD19uCr6YdnvzTIhT4mTnF30kXgxUAR0LbS8wWjdcm62HUTcgE2bsybykR9oTYkEWP52ZVlV6Feu9HalYfw9xiu6DfyQi4uc3y8h6OPqXPpIi/zR1YlD26Fd6u5pqJOnXDWGGNCjusswyN/A67+5AhWcf2Z6p4l5qXV8waYjxOVgB53N2qrxZU5FWqz7X8bBmGayU3Km3e6useLIN9Z4dfnIxzj7eOa2mI3kb20SpeRGOJzf6DaGenR6SjB9wM1GyZvO+MMZME2d41igA5mzgP94v9A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3f8s+uqXBAoc4yv+ECfRmRUv77LNsdQtOjxsHet3jDzDguHm8CtsjDgagIEk?=
 =?us-ascii?Q?GerBb6qDNffWyHOyc3OP4pmOP/Z6EOi9IgFbjFYJ4BbVm2BliZcjvS5Jh2D4?=
 =?us-ascii?Q?FBumG1HX7NsM2qK0WTwlAzBFOfoxASv+X0BdOWnMUYX8N7f0SwTjw8IpxcFK?=
 =?us-ascii?Q?JB+0R9mDXDGnOKaoPWHBFD0XP/pGYZSZFfRa8LzA9iLdqXP0fPKej1u2sAaT?=
 =?us-ascii?Q?2ZCvXGVqtFZUEdomfzJ+y/tcFvY6qkA+wGR57obmx2oPtNTakW+qg9ICX6NK?=
 =?us-ascii?Q?LzVo1+9dHhlCHYYH8J9HCutV4dxGLv6V224ehixHlzMg3cxmCGB4E8nzcgoT?=
 =?us-ascii?Q?pnfOCbte5ybGwMmdnkwTyAnlHMmGjDKfDEdg8DUGHNVvX8xxsWw55qdF1V+H?=
 =?us-ascii?Q?/lGWJMuyZVoTIhYA1n77C18Cpu7KLia8AFkgCaHEroD60ri0rCO2cTlqBl1f?=
 =?us-ascii?Q?DhWXLq2PEqRVybR5AraMJifvfkc1X0oAzEcGlLj17QRIGmptgKOJOLK9f+xw?=
 =?us-ascii?Q?IsenRFSFQ2csoEqxJzcTb++R08kjSUTPNPFBQZN1RmNODk7/+O5r8jJW/yl4?=
 =?us-ascii?Q?UEo/J9gtAlcjYWQvQKCkFMbhL/ipvF6FEO0820EdDNJmFqWwYyoJe050Bwfm?=
 =?us-ascii?Q?t/o1lP3QXrQDhrxKcDBVWhB5bC3XiyhepYG0skXzGdUqt7qpwQfJcUlx5Fgg?=
 =?us-ascii?Q?rXB3ZzM+PxSVqsmwNeCxhG2uEg2UtYvOkSCwOrAk9kOqJxUbn9RUCu6zTfrd?=
 =?us-ascii?Q?Nrg38it/d9ZeWpx7EwHyvSuoz2um2f9jj6hLGSLlAmly6AOksC2Bi9LvOo+0?=
 =?us-ascii?Q?BdW989jdRkGpqZSJi034AiTGFj6hh2gNePbWmjEEVRUm1zGRAybKG0u5+0GF?=
 =?us-ascii?Q?pqKIg2MGtU7kmtyCFSePUt9RUNxeWgxrZ0XYQOJzWTa/JBU7id08kKXCu5YF?=
 =?us-ascii?Q?Iwv5aP7tQX5kZlOAXLqcAr95AXeCTB/TEyDzF7JwB6FHtYPgBw/vxzGdGJ/B?=
 =?us-ascii?Q?gO46/EAeSspWZm2frRqcgDsuWmyl9/AfeL+UxN6U4kdknVRGmWnr6Z4+jKb/?=
 =?us-ascii?Q?znpyu7SIxASmwlNIUwuwMBLzM3HSVfFrCwDlP8hhxQURv/dvdMHQ+4SjFSir?=
 =?us-ascii?Q?7WS0yxPtbMmnZl4XKdKJQJfeCIfr90mMb6uGBQlxXMGtydYbsnRUza42jTBX?=
 =?us-ascii?Q?zlZyfHP62ZtK/ToIgKX3pFnAHc517pXK7VWkVHhDnKmefYZw7NFnVzmcu1tY?=
 =?us-ascii?Q?nYNYWtburYGcpLTrkjhUiftJSTApm2XdXY5lVAzjPQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65e8082-c87d-4740-21f0-08da551c4ab2
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:28:42.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved error handling to one common block.
This removes double checking if all txb->fragments[]
were initialized.
The original code worked fine, but this is cleaner.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1307cf55741a..42f81b23a144 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -214,19 +214,19 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 
 	for (i = 0; i < nr_frags; i++) {
 		txb->fragments[i] = dev_alloc_skb(txb_size);
-		if (unlikely(!txb->fragments[i])) {
-			i--;
-			break;
-		}
+		if (unlikely(!txb->fragments[i]))
+			goto err_free;
 		memset(txb->fragments[i]->cb, 0, sizeof(txb->fragments[i]->cb));
 	}
-	if (unlikely(i != nr_frags)) {
-		while (i >= 0)
-			dev_kfree_skb_any(txb->fragments[i--]);
-		kfree(txb);
-		return NULL;
-	}
+
 	return txb;
+
+err_free:
+	while (--i >= 0)
+		dev_kfree_skb_any(txb->fragments[i]);
+	kfree(txb);
+
+	return NULL;
 }
 
 static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)
-- 
2.36.1

