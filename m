Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAF50BC82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355269AbiDVQGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376307AbiDVQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:06:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2031.outbound.protection.outlook.com [40.92.21.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BD5E157;
        Fri, 22 Apr 2022 09:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXEfS3YzJHlPKKvo1soZeLQjCAqMPAeTQyQ1w/uqmXBi86Q41rVwexyxlw57RZINriVokLCn7eF8PMfZOeRm2ovJjfeNtHQ6UNxM8Y7d6BhTO52KTFw7uJ0ueuPEHg1JflNC+yfLtcBO2rojiZqDdpBTbwtxQxJNpVo9R6gPAEjHXf5Ne1PB0yzvdtXvysWnWA3cYQ3mRYi9J+xkhKwr2HixdjZEKsGK+rZ5QISA2K0RvQ6uixbBfXr7TfVNegmtIFfUE/jNQI+pKMgCIdPSkTV1v+S/MN50IFkOFRKjIei08WDzNqohKaV1n4GWeMnnp+Eo5O45vwLgc2nL98NPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBiWX7yEUfEk7mpXtQQGrm6vN3vRvCXaaarN+9t3hrc=;
 b=YVeyh16IGSjpy6mjcVpSG7Z08ezrMylszwHrtNxlba8DvN58m5pVJAeTJZHVaEamPrrhSQeL0TKoqhCYXDm+Xr9EQC/D7zJhV3Nvqia/dnQgyLuo61z3ozsuheQWZQGDTFghB5o/RzV2J7gxWXjjE9sKZrQgWKzZxqiGewIu9785Ql2BCGiBpHeltop6iguB0iyI7pylfjy9NJJuD/pDDcsj1+fRxkgFgqy1/8uFc57ND4w/SBxI2XNC4QwXS85jb/mopEpivG/xKNarqaEuVLFje+b3pQSO1YKdg9exLi3TClK9KhgJ1sD8CaMcvCmoOa9SLv5hclluvBtzvKb/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBiWX7yEUfEk7mpXtQQGrm6vN3vRvCXaaarN+9t3hrc=;
 b=FnJPc5OBzPHNMShuXOAbHjEahU4d/O3SwmWbkuRzkgLw2e+lKA0mooPaN3/w90i+Am0ui03gamueR3CwSMlvqcKZPvY7hDGyAiz7/kRz3nVcYaYTk1UvFP58tx56iHQgQbLE93RutOtynO5iBkpDx6D0+G1dg42X7YiQzuHnWJWJs6O0tbzlIKkqncjWluGVJLBQGvlOmWBhdSEnxO6GCZ9UhJHLVVxqdhM6K6uTTvGx9EsOu8mXrrV5mW+nzLqrlY0Q5xleR+CPqN2u4bdD6+64GLRE1jGcnzadS40Kr/yfSC+6ZFraU8f4Ff9/E+urUg24zGAdfD07LIA3jRXDGQ==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB1685.namprd20.prod.outlook.com (2603:10b6:910:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:03:04 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:03:04 +0000
From:   icenowy@outlook.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 2/3] Bluetooth: btrtl: use board DT compatible string as config postfix
Date:   Sat, 23 Apr 2022 00:02:30 +0800
Message-ID: <BYAPR20MB2472E58CDDC6B56773A050FABCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422160231.1072810-1-icenowy@outlook.com>
References: <20220422160231.1072810-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [J9oeLPeTfYsRuFZxyCX9oQJldRlnxkhq]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422160231.1072810-3-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e54a173-6c65-4a66-dabb-08da247994ee
X-MS-TrafficTypeDiagnostic: CY4PR2001MB1685:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlVPdg8toQQFsGTLZRlSh7bGTDqWVrY23i4OGekRPavASQjiQ0UxNM4xSPn3nZweYfXNOvO62s45nSo6eeUJiFuGgT0QMKwMcE0MikfhJweJDkKZJVZAJhzWFPzvDXUe+2i4bwvZ3yqwRhDifT6Bk584utXBnYjQ8Yd3uwCpLnTWvSsOCDCcYELDbvSwEINQ//WDxmp0LTiP4wsBlKBxYxgxcT5T+OXB/QN3jHUr1x2uU4BA1zHo9ftMmBZAzF1fdmkGzxw81vMlDVfr8o3qXVERihr+fXUvcFxDcrUrdHnvfKzLsde0Gw6bNQslPT4XRVHssuNp7DRUef21mLdiSXv904ZnWX0mBjDJmmyFq6uAH3S4fn0t9MGXuoejXxX2drBImslPlFuoXqGpCReg1vhbk7GF0UYuBp5I5HP2N+SZdJcn8YmHMzStHXE0+JTn/pDidXDRK2uejNBHKWdhP0iGBGl0AIs1be5lgDFfZ1IY+O7eZ7klaHqd59tSpYiqch4FHmZQxF/AMqLuK7L0N/94DGo5LLKEAUoawh6lruoflGhlfZEYX9H8LUKWWGgEyrQrxLCGXw4NH0CW8rQOCA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jfmSYp9cT8++AwSyiY6uJ0KoBFCyY2NKYbEbUxJJJS4sNGJIzv9femVk/sME?=
 =?us-ascii?Q?Gj/75dXRvCn81jAFTHgS5uYx4ILkjpJQmvZorI0or/YKJUtdiW6upqBo3FZN?=
 =?us-ascii?Q?EB2T8ILHoSPacveRB3orKz/JHutLJz8ZrI65M4NBgCFCRS3kXj0ayLIKTiAK?=
 =?us-ascii?Q?JsBqvJJUUVTZmylX3QCVB/3oTIDSFYw1SauFOjWKk1wXT0gA71T9SXoKNh9Z?=
 =?us-ascii?Q?mlCh02VwaF2Sx8MIkcLt0Re1TnESLbQqA9fny1N/usc7co/DfOUkfmwLIHzn?=
 =?us-ascii?Q?IukiSpUph1E4XsMBcFOYogE6RmQBo4QSOJLArwO7MSfStduA1YM2XBSi2A1b?=
 =?us-ascii?Q?auwxs9m87STfnlZe1xZ9bjxXK9omhOUKZgNZ/oPPufUMhie7ZQzwXeKrbjTJ?=
 =?us-ascii?Q?w7C+OszGhcBEFuYmfigppO34M5Ir1rtSHE+hlRmrCfW3rT6Ybf9vFXxi7uPD?=
 =?us-ascii?Q?NUdjG27PVEJKAzs8JY/SwqC5UglsxlggBaP8OQ8MTpd+AjFyvpEVUAFOpM8N?=
 =?us-ascii?Q?36HKBtiLpB3l2mv1AeFQDT4bx1otLZSX/N1SUvO/iqgTkYTVQ2COVEcRy/u2?=
 =?us-ascii?Q?LF6uQ99+DOgMIcJks2uptLVyC4G//1NqX8g6z8rSdzVC54xB8SEC3iQAUyic?=
 =?us-ascii?Q?Ti/B7ShM+6h+VXDD5iMe2XIWZ857qISyQHlkV/YovDEFWqKUiGvG48Sjhojn?=
 =?us-ascii?Q?eYkXzOJvYveUBRl95n/Swt+/sRcVBEpBJ7ht+cAFfbO7bXTYSyUY917ZF5Tb?=
 =?us-ascii?Q?1xVZ+tl0JixSQcd/5GRa7pBz7a0ktqLuYgw7VOlindaMCKO8jeaaXUuyFeHm?=
 =?us-ascii?Q?lfOTDVJIKO4uZ0JIaKDGTdiQAvODvXe2Y2wPBPf6qZr77pT3PhtCOxFNhsRN?=
 =?us-ascii?Q?3LTWdZ8YQY/KznV1UxoTPHlavrnZ6zPW8/bZUHkoi2bB2PJ5zeS/m31BxIDt?=
 =?us-ascii?Q?6exxa9aUJ8pLhUUrX6C9K5hHZxLRUm6R1UfOiJradR2z89upFNL7L8bNr8/i?=
 =?us-ascii?Q?wS5vBkFogYlPv4gyipbDAaE7oANi37Ycx2Az7w6aUKZCGB2VTs9PbXa3Qub2?=
 =?us-ascii?Q?m8AyAEatGxclTn5cZDNqrch5T1IYJTCsVLI3h36wQwzOlTS9qbS8RvhYl1VL?=
 =?us-ascii?Q?B4tRuz68pcnJ6vKudY7mGd60EBWR32GAk78AcmMacR9CLigLVWj4miHVk5z7?=
 =?us-ascii?Q?kz+lti7HdVdEZ2oyMvkVAwqLE0nJOGxDbqYI/zNKyjoQB8jvbbeYZB/nnYUO?=
 =?us-ascii?Q?75Yreeq23o/Cpob2qFNQ2+RaHJIYvGXJkFyFNxikISeXyd68KeDnIa6g4Ggh?=
 =?us-ascii?Q?h0nQ0cHNjISBviFjghdL4CZ5Pg4ecGbJ/qFh0VztHQesw/BnCSdSTXDQT602?=
 =?us-ascii?Q?H5TE3J5ITOmBX1b/wJNJRhsC86QIo/Ena02sXn1kXfTRQxOfQ+Q6Rcjhy9Xa?=
 =?us-ascii?Q?SFHvJmZdJWY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e54a173-6c65-4a66-dabb-08da247994ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:03:03.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2001MB1685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@sipeed.com>

Mimic the behavior of brcmfmac driver, which uses the DT compatible
string of the board as the NVRAM postfix.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/bluetooth/hci_h5.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index c5a0409ef84f..d1f90b23a5e0 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -817,6 +817,7 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
+	struct device_node *root;
 	const struct h5_device_data *data;
 
 	h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
@@ -847,6 +848,32 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 			return -ENODEV;
 
 		h5->vnd = data->vnd;
+
+		/* Set id to the first string of the machine compatible prop */
+		root = of_find_node_by_path("/");
+		if (root) {
+			int i, len;
+			char *id;
+			const char *tmp;
+
+			of_property_read_string_index(root, "compatible", 0,
+						      &tmp);
+
+			/*
+			 * get rid of '/' in the compatible string to be able
+			 * to find the FW
+			 */
+			len = strlen(tmp) + 1;
+			id = devm_kzalloc(dev, len, GFP_KERNEL);
+			strscpy(id, tmp, len);
+			for (i = 0; i < id[i]; i++) {
+				if (id[i] == '/')
+					id[i] = '-';
+			}
+			h5->id = id;
+
+			of_node_put(root);
+		}
 	}
 
 	if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
-- 
2.35.1

