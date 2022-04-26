Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5950F48A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbiDZIgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbiDZIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:34:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D844B6E550
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcFJhbzWsoI6F+6NYxYYNJv0+/w6Hdms+3mppbUVdJFLp/uTUjEh8AdQBx1LYX5JbX3151MhATMX0lhT1byVtb824Zvb0Lgb770xs7CrvQBWIb9KmD48S1TE1iO+deK3uViJrIItvTLGFrekO13I1BJVrXyLT8FFd37gVVH7daVFC0Llpq+uLbwQpWoxUKNzVeDeZ73nq74fE9FWkXLRfN3+i/QQRm0nLUZ6MKmrnTV3zgUTTvMNupYT2LrubiVbiaca371wRZC2m3xUv1VRWq+bxkwBVxBa1qtYgDbiOvUUFTB4pgs5QP5OPFP5tnTyZ3ZjRedNMfAo7kP1eKB9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFqXuY219pQYqdcnExefYu3BoAMa/pMzNdZVT5eZxrU=;
 b=ms3U5QcZXLpPYFYJqdqknkeqBqvOx96fiDNcbbKMCNCvQeDsNpc6ZPcfULyNxJxCK3bD+cOtKiOtlQjmo9hzK1hyajNGhJTZCU/dl+yjLPYv9+G2xMgPXLHG8p3qXAgD1LBxxSGtFLBnVgCifEJFnIhkSvm3vIjWV/8DGi5CKTgx53hYjrDJJALkLk8RddV6BCpRfkHR3LB8xOPc4myweqSZfaRnGEHzyFB500TU2/AS6PUA5eCXxyg0b8bZcUtsk5TDiGDYQncEwF1udKIxThKoNe61e7+UiXtWebvh7lcyd7PBln8JNHwt0/oWrvqkhIdv0vtgM5IA5Hx9B3gHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFqXuY219pQYqdcnExefYu3BoAMa/pMzNdZVT5eZxrU=;
 b=dW5Ot29LSIcdKdhAXEcdH+fFPs1yPCloAQNiE4H/62cfhKq4bNB62Gj5l0WOBhZXUO/8CYde4xC2/WC/g/eokSGzFLJ3p/d4ClRZ/cWCehzA8Cki52nfjsSys1CRJ+AblWR8wbuWMfBCi4VgJWEMfORYsv2CxWWTdUygJ3nbZDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB3952.apcprd06.prod.outlook.com (2603:1096:400:6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Tue, 26 Apr 2022 08:26:10 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 08:26:09 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mm/filemap: Fix NULL pointer dereference in pagecache_get_page
Date:   Tue, 26 Apr 2022 16:25:48 +0800
Message-Id: <20220426082549.590899-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdec9c02-e6d4-4b3a-8996-08da275e6a72
X-MS-TrafficTypeDiagnostic: TYZPR06MB3952:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB3952AD1C799A2DB1E7DE27EBABFB9@TYZPR06MB3952.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmTCgQR1BPJktKI97vqL1Hx0FTWJT+5zsCWd7Yi+7g6nloknufiy0nSPUYiK2/5fM+l3EMDjG0HmpbojTj04f4X0PxP13laXvWOkRsmKXKQzuHQREiCNWbIkBwVGJ5ZZbnMHI6XgNy+Yaj1pCu4imOJd85Cn79SL26GIrnANPitjHY9EmHSleoterG18RI4WHZzh6LDOsuWYJ/sM09c0uQV/uPthD87iFzSGXnujOBqAdTpMj4g3m+ugNIWbRtnJQfD80MplMQ728cq1pmEVkF9k8pYtad7POfBkyde6ltEKfgw41Hq89GrEQ52hW7x02YkXNt5W5ovs9jTxavBjS7wofsm8s/uDYIET05D0HaVDBOZm3QbUCv7H5PtEkF2QKWk9VUuIjDadPV5bA/KrCU+fqoacQp+1eDI93YN20d4YE6YXP9vS4EBJD9n7WLNy/zy28pgXlN9TPtof3xZEJ9qYxJYDvv+9PtbfRTbdWvfEYs+r2kFssYJHwc4fhROxiLLD7j/e2uaclXrYkEc/oPujjEdt12P6M53jkY8Tb/Bu85ccNH9UDqW6JvlLcXjPxWJpPL2OMAcNkCmFRmGYsA187Gzrn4DOnXx2zSjuYdYPdymLXq5NggQlZO4hS4+uCQOkAPSyKIGtxSnq+TpHnZP2RjXhnDLbPfYi5fRRXiNHq1O9suDN9Wk9wCfZBo9GXycBeOFiA1zFcIgdPa5EBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6666004)(66476007)(66556008)(66946007)(4326008)(8676002)(4744005)(38350700002)(38100700002)(8936002)(6486002)(6512007)(6506007)(508600001)(86362001)(186003)(26005)(83380400001)(36756003)(5660300002)(2906002)(107886003)(316002)(110136005)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fk73PeyQcVh5/TrjXIOCRrIa7x0uSShtF4cxddDyzc9aKxtWVP2z6nH1UxgD?=
 =?us-ascii?Q?WWwKr74f2W2ne3D8qb0iWhwD1njIqo+tVNgPlnv9QMaTRMguZAHeoAlhXMvT?=
 =?us-ascii?Q?/JC7ah3iGtezsdE5KbDVi+JsJkcbv56Ear/y8ezkYrSe7oIwzrX3amnMoCOi?=
 =?us-ascii?Q?8Spww3oiCc9kCVU0AHwq3No0opeqC7uVMV+6HBoXap5ZJK6GBCQ0DInoKmb+?=
 =?us-ascii?Q?27gplmriAgVlSmC/WwASh9TvzqTe13u8onDoSnt9F/ZyxNWGehPryfKCa94R?=
 =?us-ascii?Q?QxmNrHHetljcwaI16eMHRp6RGnciNBK6Yjef7cDlKDa+E2i/MrVDBcfo4ogg?=
 =?us-ascii?Q?VK8KcBBM6vpYFVJ/Al6PhPgaSSRvdq+pW1xJrKRaZ9nU7CEjWZF9JD4SURDE?=
 =?us-ascii?Q?8ybQBHyAANZGHlfX7It70ndlWZz8qmy7nuQso4JoB+g09J/5KxGFu5Dt5axh?=
 =?us-ascii?Q?j4mN3lltyANDRZ5GfR/UCGR+0tWs3oEtZfmjlRGfwHSG0q9d00wJaKP1QpO4?=
 =?us-ascii?Q?vcl7eQ7kfLl72YQO1wKeYD4NCHzxmVjXW+Qf71nE99yNtgJqef26qt48/G60?=
 =?us-ascii?Q?BMWC+e6PWjHnKqaI9z07STjsMDxeb/wt2E+TsLXv3PR9ABPY7+Ber3D2l4Bm?=
 =?us-ascii?Q?sgwfGYsFOP88gITsTakA8URWlsGKUa9mbWDvBVgmi2FGPnEG7F9gEmdP0BAk?=
 =?us-ascii?Q?Mp8ojSAuO9i2/qXH0RN2jIWvl2x1p5ArzaHhWUtMpwOX7DdfsTOTmVc9ZDBV?=
 =?us-ascii?Q?caOabmW3MiTLj23ml0sYfw70+hSyT0V8p4ObfAK2tkN8dhM7DKRiSHR8OnjW?=
 =?us-ascii?Q?8PQVJ3C1fjUnOXVKaWrHB5refTFUMT57H8VS+jS00g/+CBnuuSn+bIyYz7Dl?=
 =?us-ascii?Q?iqnPx/8/o/+0WBnSnonRhZbaqIbqtb53m4TUgAB+NYfaJvKtFrN40LV7zpod?=
 =?us-ascii?Q?+75+tRnh5elGIIvl6hzHZxUgr7ojDgrEJf/MmuBuHGQ9qYDMwbdBkDt5+gxX?=
 =?us-ascii?Q?BfT9wzvTiRz9QZFugpAZMLXYk1G+v1HmGgVOqtktNA9o3eg4syURDn5mT/tk?=
 =?us-ascii?Q?1D9mJWwVZ/CTASUyUb4X1VTAE7frAqBH2g16w815iBsTeTECasdXm0O5YR6X?=
 =?us-ascii?Q?NxSdD4KWLMQo9M/JOSobIBWdZIy6kEeSBTjrpA+gwis+M6uJBt+btpByV4fT?=
 =?us-ascii?Q?FFmem12OCaTGeT5NulvBh5eLk+WDxFz7tM+raHp2iur687dEX3Djxxive2RY?=
 =?us-ascii?Q?BfeF8GVKbNBDouv4wZK0LWLJlGLYmfyOyQMzanzU0Ga3NB5UnbreevlWS/pl?=
 =?us-ascii?Q?EJNTyyLPDPtx0YSE4tFzMRXkRm/oqvNhbd/FuG37X1ScDp1k+8i+BSB/SExu?=
 =?us-ascii?Q?qUX/8NXtzWSX/YLTtFHkrzZ3jPhgs8zYT75ielE48Lt/eeqxxt5ycahpSsS6?=
 =?us-ascii?Q?FrLIa3iixc3QQFuRaL5l0xSr1UGjjv5fLWR3AhFlpTxlG9GUhoZglIOtCRr7?=
 =?us-ascii?Q?W4EwC9CNAWe9b0CM6vgbVgIb8DiN0Z5ZiT96IRowXl1kNzDMntYqmn/xFnSz?=
 =?us-ascii?Q?MRKb4X9Pf/sx3DG1XdQOmrZgGZWbkfA7b5vBZLDGq/u+IJgBt2SBAFc2a5uB?=
 =?us-ascii?Q?g+MZ39yuN3gB8L+lYC9LJwh1AmdWCVeilhnVMTpXG7a+2pvWZV8nw/dxIQmy?=
 =?us-ascii?Q?fprL3PziTwL4W45SKnHylu/Yd3V37z6FL+P1O6U2jZ1VW8SafsJqhZhRDgVy?=
 =?us-ascii?Q?xkQZE6Lpjg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdec9c02-e6d4-4b3a-8996-08da275e6a72
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 08:26:09.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /25ix0cXy5j2yhGsjdwyfW0ECH/BVw8g9IrdXtlmvm4sFy2N81B5jNnNvU8lG1fW8dtPl5PGsVwxN13ee3YNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3952
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck error:
mm/folio-compat.c:128:17-21: ERROR: folio is NULL but dereferenced.

'folio' would be NULL when getting a reference to a folio failed.
Add a NULL check before dereferring 'folio'.

Fixes: 3f0c6a07fee6 ("mm/filemap: Add filemap_get_folio")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 mm/folio-compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 46fa179e32fb..54b17c1246c4 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -124,7 +124,9 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	struct folio *folio;
 
 	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
-	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
+	if (!folio)
+		return NULL;
+	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
 		return &folio->page;
 	return folio_file_page(folio, index);
 }
-- 
2.35.3

