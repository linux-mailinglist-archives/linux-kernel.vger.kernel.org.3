Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F5F553CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356022AbiFUVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355986AbiFUVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:07:15 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072037.outbound.protection.outlook.com [40.92.72.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929BD36300
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPvvM6rbnnoj995hKiVJIWVVd5SWRWfOJMGlg/H2OF8WMz6z3uU4LvNcdTX1peniUzLJbwE9+Lq06f9YQv5lhLCR7ja8bdwt+o5xFXUF+a4CkkYZHmxfnXpnrY+Y8tIvqkS/U39ojU75LdTqJOMsmP7uTu6EromoPSpNwH3lrBmiweXsNyhJEoiLcFRVM3fKj/IPQA2ycaYupyLw5o3t9/G24mOfuQ2q1f99LxQO2cie/jWFtz+/7Rt1BPiJE4S8I3dnVWMBZ0w5X4IzXKnANTvISBarbnhT1MA40U1yu3Zs10EuyGF+TH34pea2w9Uk3He59dvHHGyp8y0ntiHbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB49K0jywoEl8uEn9J/RLl3Hwu38s/EKN4ssHeI/8ik=;
 b=QLSjSxj029E1IzCE9Kzr6O4Ez7NlNQN4WQ1nJH/5kLAtu4CEya036zPacIgm0e2aiWi2I/ooF44QyHIoaHUH1C0jwDLIb1xRGCKKyzlTEqcKmRiQZ+7GXcDb6bcytgG2/o82rIHGzZ1sHNq2Yikv3c3fkqEmzSeFOK18zCBcmGgnWR36VP7SRXdOCFQYCT7s7mIrnwhBGWek3rqJmAzzjDK/c1I6EIsZvvc12TvHDRRzBwG660rMrKXtyXKaQ6AV5GDqvLRkJXfaMA+DkwmTIEqjX4MUqbaQ4Exab/vkfZFU9INbunEeMvkv4aNh9ljhhXUv/7mFtSsQMJDFZsbkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KB49K0jywoEl8uEn9J/RLl3Hwu38s/EKN4ssHeI/8ik=;
 b=W1/mHXLVPsBVSwT9nTnDVc3mgcYnGdkHbCGa6y7lkAPQ5MBHD1hPtqITME8qoLw3n1r/p/seV7qyVHqi29KfeSPsXh5qVeRxrt83U4IbTdHfdHdaUhZ5XTM2Jq7b3tYGnT+pd5iddK66rZ25R2arGGitcUcnMd8U5nacYuh5juyXOXuCzUeBn9WZtX7qx12V0osXUcBr70wRJCUC8p5eoevYmG6z0z7T+uOSGvQSvwVhRpfnea9KfuhaKJqI5mPA6jLnpjSnT9frdwYnndUIxeqqFr3SJeKZwPEFwuX46WHgfzDB4LRswt4xJyc7JM70UpEAHdF8Z5ZLdX3ArTGjsQ==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AS8P190MB1654.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:53:01 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:53:01 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: rtl8192e: make sizeof type-independent
Date:   Tue, 21 Jun 2022 22:52:55 +0200
Message-ID: <AM9P190MB1299AC4FCE60C59C35034DCEA5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2Y99tAezpQj9Y2OiQkrtqlRvZfrxurvSiXY3X9IKbgx8XHAQjcqiTOGyR4I+QJ/X]
X-ClientProxiedBy: ZR0P278CA0040.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::9) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <20220621205255.36053-1-f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7332c9b2-c61c-4627-2bb7-08da53c807a6
X-MS-TrafficTypeDiagnostic: AS8P190MB1654:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OW/r3Bmf3K98WHJQjC2zqEjgBWAo74AEzPG8fMREquSTfmIv08nMfl4Ec9EVj62UOrKBh9kz13cXC2xHCIIcvCrlxXchgt5drkX1bJ2Hb+Ew4zguRJhOSiyVtRrIBJinPi3B0756Bw0iQPLE4o9Sc5DDnV3hPOkl0VPlIadL0Ej/hdnXRN0pvPBCb9Nge6qxRzsNl1e+lrDUot+aGvksVyuLaTihqGvN7ujS6fukkZM8U0ZX3SCJIu/2lJaHoLl8RCt5zK7Qb89TSE5heNA1QCNrVxP8UCOyrofUApukhje/G4bFuuS7CJl9ES/JoR9Tx7lZ7IImurPOWp6hGR8Xfyh3l1KMrR4/xln/2/2uhhdc3a0tK6jSM7SMnb3kEtkBZOAQM8D93dZ96ngRQVnlf7iStfzbvMPRB/4zBGV516hqhGud9Hr/hiY0p5EMT2YaJOvfRMG/c5cOsGK5aMoktvqXPcM0+72d4IjjA6TJUmNO0U2zAKf283uMU1JglSUNuxUbop5V1ma6MwdZ3Q2jIO3TpPm7Muo+xEk+cUM9xdcrhaP+UUURONtnlfpJ/2nw+hfHN358Ndd+UXs3ptYzfw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9fbshec/hQziZ0ca1kfu3C14ikSQx7IG40t1JJ2xSNmMST+d984bFawnd952?=
 =?us-ascii?Q?QM5QpnoCnadY+hSmMW8Vy9JckcN0W0Rv6c8K7VwDQe3DUlP56hGhSTaBqaKH?=
 =?us-ascii?Q?qKCbpwZ2XzJ191Hk8IxMcXMYxsKNTov9C+MsvTZDxQ2xV9EBMaiSQcn82uV7?=
 =?us-ascii?Q?OdFPISrHNfbmDn7QfHSyWaAj6pCZcWzJFkr7ZLOAykcBwCVUUS+ycQEbY35c?=
 =?us-ascii?Q?zmyctus67LJjOJ1ZxUEhi/Vi2FZ+FC7G5EO3fiBdOkORTfPcOGt/rO03eXsm?=
 =?us-ascii?Q?oSKwkSqqgBLPmuVboUCDJVFsZAkn7mCU6gA8z0zDjfgAhhpkfofYgbv8ybGc?=
 =?us-ascii?Q?6hZYUwzMYfozenYRBOTdqgZjKan3pgUpzKL8HePYdbT6YLOVxJr7HQUflqTA?=
 =?us-ascii?Q?ysopzTR+iwQjwEJrJxuO5iXpUjGrWWik6pWaUhsaSYE7mBQTQoNH8O/230S1?=
 =?us-ascii?Q?+/oJ+WpuD4z7FwBenZrw5BME2qFclJLJEoukVgv+DlEGzPDDJ40RwLsnEO9Q?=
 =?us-ascii?Q?LcQrmhSundkyLHNEruSmHMIvdQgPwzwNQp/C4cMIgtOFo9gS8zYhcL/o/AF8?=
 =?us-ascii?Q?ZkLQxemGZFciQs9seEU2eUUF46Py9MOFyJJgg4miY0nkssdHj4lF/o7kL8eO?=
 =?us-ascii?Q?iv4GbnARbnZ8ux4qi9EqaNn8KfRqgSws9f5TDx/ilU6khfA1y5bdEK/zGL9q?=
 =?us-ascii?Q?y6x+3yDn0Bb5DSUzPGY54cWVv7V4D3YhiGkC5RDgOsKySkDXkgCG5UA1yDAO?=
 =?us-ascii?Q?fW1sdMgpIjEXg5WrbSHbp/nbLsey7gyEmiPDcrhjzzbr17Hhhug5XFy/G2RF?=
 =?us-ascii?Q?jDo2oZg3QzDPSFtoQjMcVod0s8XImm1AVnzsZt5dkgAbxr3qin4YCxRflD3L?=
 =?us-ascii?Q?wm8pY5T0N3Gmyssd2wvXixwjLXmBO8BXGaJ3lbZil+H3EHnW+U7yTBqWE6uZ?=
 =?us-ascii?Q?844NDTFG2DCyy2uplF+n/lD1SSFlxNTaDd8NqZLdSXGq53kushvm8CQGIjZx?=
 =?us-ascii?Q?gUadopqGFGxNq6xZ83C4cJ59zdAUYPOfOvMfVqHUcmg9IP1BEzR7RbMDAXuQ?=
 =?us-ascii?Q?oXpjKWTiAKFXjifAdwNVr8er+K5iiuVMRIw0FjXRl1IIr2AeR/bqYK/yQqjw?=
 =?us-ascii?Q?HV/4LOcZys1f2m2lA3EC8sbXZs6kMjW1RvAtgXaYyYZIPUaYJvIT9sw9YDx6?=
 =?us-ascii?Q?xAB9Q1HrCXTZOmcZFbHal+R5luX9rmgv1lbHVm3C72Dm3XGrH5f6W7RA4ThN?=
 =?us-ascii?Q?IlAcOv0cuiTv/mDOQWC5hr41eCOLUTLkvQiQ6GFr3D8T6NX/FGUogl6Mxftw?=
 =?us-ascii?Q?dJ7NuDz58x8ihII70+OlcdkHJfIuCLp380OcnwXpDxlFO9YaREP72oFqCj+z?=
 =?us-ascii?Q?sX1pHHTa6EbawVKc7kGuLvSyBvqO66DjhMk3qj7Tu1VsEO8YcYow9wU2PNPr?=
 =?us-ascii?Q?i+R+v0G2z76uw812geXxlg3CuPqQZ3Ety1kxM5OFyBk2KfrJ2CNmim+TnuT5?=
 =?us-ascii?Q?So8cR9L3PSFaEAc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332c9b2-c61c-4627-2bb7-08da53c807a6
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 20:53:01.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making sizeof operator type-independent.

Reported by checkpatch:

CHECK: Prefer kmalloc(sizeof(*txb)...) over
        kmalloc(sizeof(struct rtllib_txb)...)

---
Note: First patch, trying to follow kernelnewbies tutorial.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
Changes in v2:
 - replaced kmalloc with kzalloc against memory initialization defects,
   thus also removing a memset
 - made error handling more consistent

---
 drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 37715afb0210..bcccde91fa0b 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,30 +205,28 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;

-	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
-		      gfp_mask);
+	txb = kzalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;

-	memset(txb, 0, sizeof(struct rtllib_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = cpu_to_le16(txb_size);

 	for (i = 0; i < nr_frags; i++) {
 		txb->fragments[i] = dev_alloc_skb(txb_size);
-		if (unlikely(!txb->fragments[i])) {
-			i--;
-			break;
-		}
+		if (!txb->fragments[i])
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
+	while (i > 0)
+		dev_kfree_skb_any(txb->fragments[--i]);
+	kfree(txb);
+
+	return NULL;
 }

 static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)
--
2.36.1
