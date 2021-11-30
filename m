Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377CC463A73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbhK3Pqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:46:30 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:42222
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243046AbhK3PqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:46:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3tL6uzYFSSv64/fnIEYHzrEg7XOWeLCjB2j4AgwYNRg7IF2tzofMecvwAUyKXxmwPHfaO8ldPGRf2VipJuSGJHrBY8jdP9r1N4ENuB4VKBGqMwFadYApHa807DP9chfZqhn02cplcBLJLSUDfFuItvKQeZ4gTMOOleZt/vtDX1DcODr13a76DNp47O0NYLTs/4O+rw9YCIdipzUDFDdy3do7yLDkRgL3O3mZKeoH9ArdpAdmxgK4RygybJgAmtLeQ6bqPMYvtohg3oF4Tq6g5QtoLE65h/+8XIgUMF6hSjju1qObrvYY+/St78jzWWK8YkRulQOZ6JaHLauRP+HCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS4lQU6yRFTRakTDtTXry04y9U+spRrdpDwUcX5F+FE=;
 b=DY4OFlQpRPmQu6U1mKJ/vL/afMdD2UTh08CsUCqKWkB/Iux/iUBq4Uvdu7kX0B/OJOiXzAMYJEU4OIbii44YDStOdSkAyufyutlIKze6y0uuaA2rDyBzrRFZXfOxJhl3n/TJKa5+8CeLEEHiohztXZPzv1VEfHJhbCxZtSLw2JyppRb7uv3YPE2z+G9QDvBwvNkWWCcA52SGiPAV+AYQal6veKKP2oF+gatHevM0BO+Sj9A9NV3dsBmjiTKamnYlFJco9mAv6BsjMXYgRztwMT2AWgh407EspbbdwJXeZguBfQyzUq5xMabCNecxQaxX9By+D257/airheX6x4Nslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS4lQU6yRFTRakTDtTXry04y9U+spRrdpDwUcX5F+FE=;
 b=AgluZVkGLs3BmsXTLL5Ao2yD6W8OEnD4/lcfmQSinEOKt65pSWsmTT7S5LvMux9LD77t2Y7Ei8NFn4LbGGkg82zKONxd7l6rLY/ww81+Qg453+xnvBLEir/r8HOUGFlDZJGFeJy3cLjrlt0GmlgHUTKo8OO5wplUU7PefG+Qie4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 15:42:55 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e4ec:6c3e:84fe:f92a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e4ec:6c3e:84fe:f92a%3]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 15:42:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     peter.chen@kernel.org, pawell@cadence.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lznuaa@gmail.com
Subject: [PATCH v2  1/1] usb: cdns3: gadget: fix new urb never complete if ep cancel previous requests
Date:   Tue, 30 Nov 2021 09:42:39 -0600
Message-Id: <20211130154239.8029-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
Received: from lizhi-Precision-Tower-5810.am.freescale.net (64.157.242.222) by SJ0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:a03:3a0::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 15:42:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae387c11-b3d6-4f8c-9766-08d9b41813c1
X-MS-TrafficTypeDiagnostic: PAXPR04MB8476:
X-Microsoft-Antispam-PRVS: <PAXPR04MB84764BDB5A3CF6DFDC5BB2D988679@PAXPR04MB8476.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wUolhPV2RGnA451+rXgyKX4/zT4XaSnN2ajaX5tegwD3t1N7nlxM2GM+VbsMXlmgop6NHASt8DwxMIENEe7OR01a5yzPEhQroyb3jp4tcqpoM2XPfs9y2PGSJI5MJc831MJQJDCKGz0eqwkScKHpXfBLGE/lS0d5bPBPxxlFuHlczFREtClYLWWzYXnH1T17PKto0T1OhfMMzzErX05e+wby8qu73rSZM41U23QkSZ1nvjYapR8X5ZFkOV4XwV2n1eCBM9/zrlzR0dXnD/O4ptwVmpRrfh+F82Vqkb3+1PLKLoceOAZ/Gvp6VYfKPGZTL97ZChQakiNAsTnRNarpFpzErHcDcxai8niAmkhxXiH/fZdb07l9ftjTURrPTgXoVGHOkuwH6nw6sydOyrz0E71G192IkvQEtHKLSpCNu2wVPa+zQC201npld7X7neizEqu9aPeHxgdeyflpS6i+huxsQcLpXW+jBkJDUbIlqNrbW/R7uKyzENBjUHPKTt7QHFPyBtP+JOYxsbyRU4N66XmjrV1rRljCjDNz9RDXIwDUPew7oWB2TyqcuzsuDUbKO9GukvUcpcQG7HC8JAif9LK+LlVI2pig6R/YPkxo6r4AilhCtK3uGrwUwI3dYYm8XlgNoaVUtTmBcERjkQB58CSfkNM4kDCtmA7+d3tByPMlUHsfcjusazs63Si8k1Ev2tJD7gJ8x4ZKb/a8gMXn9fcwl+R2LUTq2eWFDSoTg3SV9+a8xrMW026mTglvopA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(8676002)(52116002)(6666004)(83380400001)(8936002)(186003)(38100700002)(6486002)(1076003)(5660300002)(26005)(2616005)(38350700002)(4326008)(956004)(66476007)(2906002)(86362001)(508600001)(66556008)(66946007)(6512007)(316002)(6506007)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tm2UQMDZlWh+AMjUINRiBfE7kMk292HUtNnx3KB4H47i+NODENztbfJupAqg?=
 =?us-ascii?Q?7GowJ6KwSu9bYiInDZnGZnJDWlcD2+CTM9fS3fUWWhN+Iksco9QFRmUcqVLI?=
 =?us-ascii?Q?hZc8Q+ncudzj/LH2bOCqDbjO1DMorYxF6hJb2uDn7ZI3UVtHjd0MWY3JpobH?=
 =?us-ascii?Q?VTq/AF0r1vp2leN52z5V4jxEOz6lR7aVGoSacSX2ldKR40kbBfaZWFYbV0fZ?=
 =?us-ascii?Q?M61UZ02DlQzyE5ZPDVbe4dXUfuEKqJqxCuWCAQ609O4NovVoCaeUcGUFbmOB?=
 =?us-ascii?Q?+/DsZBZTdLB5OODxk6DHmMGhSQQGFIp5xW1godApwxO6L0m6zNRg3PzaLO47?=
 =?us-ascii?Q?tc3mkdGo1oIX0ADxeQnA7/g9pfmkEXoBLWZiOhiBpRN1BMa/Sb9K2TeLitvY?=
 =?us-ascii?Q?JIr9AvF/94M3g8w9W+APcanandv9jHAm41xSw1kW6/UyJ67+4G6zamoSK/+5?=
 =?us-ascii?Q?48xPsRcT/+IeK1CbFQz0Hox9pxTYWL3khMxibnEz8c37mmNJ8wsByVzG6gt9?=
 =?us-ascii?Q?SIpcCb3OAhwRO+wXFujy7klNWVj87c0bEkGv8xoXwk9Vte1zbgErm7ONb5DZ?=
 =?us-ascii?Q?Ah/Fu8qaxYzy9rtDULXhDYUOITUiVKR8crsoBwf+zrbK2L7jtui8cq538V0N?=
 =?us-ascii?Q?bkrhD8OdTvH+YWXRz8RMYTF+83cJlkZrzokTDkmo6DvcCfByCfKoH2AFTgV1?=
 =?us-ascii?Q?R7PKcll6HQw498vGX3fiK7+YcN9ECx9fHMtwWXBQbX+5KHPm41eMKepx4eWm?=
 =?us-ascii?Q?SF1rYpklU3xwB5LSHIkjBrWmhT2ivKQG9XgNPGhfaD0P17nHbbD3dCfWX2Cl?=
 =?us-ascii?Q?7Rht6m+p4FUk8drCYAucK78mab/bKN4dAuxJH/KQy6ZWWJW5to8oYjYDJycO?=
 =?us-ascii?Q?aGu2g8SEruB6vhQwtZ7yILzrMtf3s++q61iEMGrAr8P2N408fmJ4dkr482rG?=
 =?us-ascii?Q?vBelzQObZaK2OoN6k/+dOrHt8YNiQvcdG4u/bq2tzCrdYNXJ03mkWEYQItCJ?=
 =?us-ascii?Q?0j9RgTQyCb9CexMt1MslO+9brIuzKgkjAqF1XMOu5OfkTf16Wue+w31Mhc2T?=
 =?us-ascii?Q?PjeaafbOLk3ue2HhUV5sBzgysXtRn7CbguBMlc5uPRe1nmmxmartVHW/6dPO?=
 =?us-ascii?Q?phLwcZTl1TE8HYkOZ6jt8LAYzBkD172uARdHGiibY8KzMSVcSEa30jMtpQWG?=
 =?us-ascii?Q?F/6EnJIGzztjtbMwOimwUbJjDev1qdIHX3TGaOiAbMrMOXYG9eTim3cLLOe+?=
 =?us-ascii?Q?g38Pl9K8dkUkWW6mZ/gh/BJX6LbMxVAfQpjqyi3bMwUNeYuOf49UBAHdeE5B?=
 =?us-ascii?Q?0tw9thcXmfzrWSfNf2Vt8UZVqOeHsZ7NA4yV7lkB0qvahc26rqHfLThwvdYT?=
 =?us-ascii?Q?3/r+jZ6q3eaLnhU4s5rPKVqH81JE8rJntjMJctN5upQTNfiKakv24LDyk5MO?=
 =?us-ascii?Q?ovavi1ABDIwFYyUAO3eUTuEIe70aicyorNkgwA3PUp95QBjaVfeh25xQ+ITy?=
 =?us-ascii?Q?Ayat74TliHdcrT6zYKlJSBuCNittsB++rFuF0HRx2pebA+T2GIeptMciOqa2?=
 =?us-ascii?Q?Yh6gzBYdXaSmGU5IVFcN3yHwddLx/UpjwUblj4P2CoNdcN9CpLVz7PSC8v6z?=
 =?us-ascii?Q?LC2MEPtJqn0L2rSXmYnlizE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae387c11-b3d6-4f8c-9766-08d9b41813c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 15:42:55.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVRegXqGNG6WZkUGILB9al8dwNF852sPlUqnE+Xu+csTQ/cF1kFjVjYLcn1LyILxRT9DblToIt/evml9rbAz5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue was found at android12 MTP.
1. MTP submit many out urb request.
2. Cancel left requests (>20) when enough data get from host
3. Send ACK by IN endpoint.
4. MTP submit new out urb request.
5. 4's urb never complete.

TRACE LOG:

MtpServer-2157    [000] d..3  1287.150391: cdns3_ep_dequeue: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -115, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:1 SID: 0
MtpServer-2157    [000] d..3  1287.150410: cdns3_gadget_giveback: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -104, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:0 SID: 0
MtpServer-2157    [000] d..3  1287.150433: cdns3_ep_dequeue: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -115, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:1 SID: 0
MtpServer-2157    [000] d..3  1287.150446: cdns3_gadget_giveback: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -104, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:0 SID: 0
	....
MtpServer-2157    [000] d..1  1293.630410: cdns3_alloc_request: ep1out: req: 00000000afbccb7d, req buff 0000000000000000, length: 0/0 zsi, status: 0, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
MtpServer-2157    [000] d..2  1293.630421: cdns3_ep_queue: ep1out: req: 00000000afbccb7d, req buff 00000000871caf90, length: 0/512 zsi, status: -115, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
MtpServer-2157    [000] d..2  1293.630445: cdns3_wa1: WA1: ep1out set guard
MtpServer-2157    [000] d..2  1293.630450: cdns3_wa1: WA1: ep1out restore cycle bit
MtpServer-2157    [000] d..2  1293.630453: cdns3_prepare_trb: ep1out: trb 000000007317b3ee, dma buf: 0xffd5bc00, size: 512, burst: 128 ctrl: 0x00000424 (C=0, T=0, ISP, IOC, Normal) SID:0 LAST_SID:0
MtpServer-2157    [000] d..2  1293.630460: cdns3_doorbell_epx: ep1out, ep_trbaddr ffd50414
	....
irq/241-5b13000-2154    [000] d..1  1293.680849: cdns3_epx_irq: IRQ for ep1out: 01000408 ISP , ep_traddr: ffd508ac ep_last_sid: 00000000 use_streams: 0
irq/241-5b13000-2154    [000] d..1  1293.680858: cdns3_complete_trb: ep1out: trb 0000000021a11b54, dma buf: 0xffd50420, size: 16384, burst: 128 ctrl: 0x00001810 (C=0, T=0, CHAIN, LINK) SID:0 LAST_SID:0
irq/241-5b13000-2154    [000] d..1  1293.680865: cdns3_request_handled: Req: 00000000afbccb7d not handled, DMA pos: 185, ep deq: 88, ep enq: 185, start trb: 184, end trb: 184

Actually DMA pos already bigger than previous submit request afbccb7d's TRB (184-184). The reason of (not handled) is that deq position is wrong.

The TRB link is below when irq happen.

	DEQ LINK LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).

Original code check LINK TRB, but DEQ just move one step.

	LINK DEQ LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).

This patch skip all LINK TRB and sync DEQ to trb's start.

	LINK LINK LINK LINK LINK .... DEQ = TRB(afbccb7d):START  DMA(EP_TRADDR).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jun Li <jun.li@nxp.com>
---

Change from v1 to v2:
 * using peter suggest's fix

 drivers/usb/cdns3/cdns3-gadget.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1f3b4a1422126..f9af7ebe003d7 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -337,19 +337,6 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
 	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
 }
 
-static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
-{
-	struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
-	int current_trb = priv_req->start_trb;
-
-	while (current_trb != priv_req->end_trb) {
-		cdns3_ep_inc_deq(priv_ep);
-		current_trb = priv_ep->dequeue;
-	}
-
-	cdns3_ep_inc_deq(priv_ep);
-}
-
 /**
  * cdns3_allow_enable_l1 - enable/disable permits to transition to L1.
  * @priv_dev: Extended gadget object
@@ -1517,10 +1504,11 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 
 		trb = priv_ep->trb_pool + priv_ep->dequeue;
 
-		/* Request was dequeued and TRB was changed to TRB_LINK. */
-		if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
+		/* The TRB was changed as link TRB, and the request was handled at ep_dequeue */
+		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
 			trace_cdns3_complete_trb(priv_ep, trb);
-			cdns3_move_deq_to_next_trb(priv_req);
+			cdns3_ep_inc_deq(priv_ep);
+			trb = priv_ep->trb_pool + priv_ep->dequeue;
 		}
 
 		if (!request->stream_id) {
-- 
2.24.0.rc1

