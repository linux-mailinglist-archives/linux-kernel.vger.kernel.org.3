Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F28504B41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiDRDVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiDRDVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:21:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2089.outbound.protection.outlook.com [40.92.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A2183A9;
        Sun, 17 Apr 2022 20:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXpK3bS3dFz92az+yZQgi9SO70fYIDPuStzt5qHPXdgphLwdc4rx7/Rjc0OAPkqRUscKYZUvfTovkzoBedx+bLQkKVP8vEnJVCp02xSfzVYHzQqHOq8A71P207H2742pbD4Uh+Wu8oW2M3aSRyjGwt+3w0ZWdw9VhYPbWJo5qVK0rum7NL+E2623q7szqW7a8TYtnkofqIol0iRDFklhVz7V2+rA7COLanXo6CqUJODSyn1zzpJFz3ef0leUl53RkXkqHCW4PXqU8/jMzbqUDYZ8pBMcR8Eko4PV0Fo6rY0u1ENrgNKFd7tISrsJTTj57wrviKFDo9nN+oXFLCpL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk4SZu+jR7Tjm6cQm1qNpd2g7Qn0ghP8evtjrW2RY8M=;
 b=YNv49LGc7TjzmkuukzkjSKneR8QdRow+XTxAjoUdAVXY904SN4UPK0ZuzSxwG30+A6aVodTotUNPb86sbCPA63Vt+lumSXLQiPlQnYfKG8mWiwl5QS2yxLQ6Oxs4pTsf61JDxdjj/Oa3SX1+84s5ybou9QSachpg6NVXb3O38GsgeorHvnZugHNXyb1rrmb8KPK2KnQ1LTqvUuF08YXfqVpRs0Z2sIQF9huGQNfsSYZQUiiFn3Q1/QQfOUWms3HZTTR/AXW7dKzCF1NWUxhUHnaYj/U341qvAcD7k3pJmAi3aNHE09mZCQpWZPlxJ3I0ykC5VRzyugCb51HaNvgCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk4SZu+jR7Tjm6cQm1qNpd2g7Qn0ghP8evtjrW2RY8M=;
 b=Kv/9Wt9H34NoOAIve7ZUeJetmf/0V0VQI/i+SGDbqziCHzCBw+7x8H1hu49QQjFjTLak5QSLLICl87NZCQvSlInv1ojWhIHtuIfHY4ElhQ4W8+zkowj5LY0bLEzLYxSFRNFDdBuBUyp2xzevNcC/XbKtF3ejRkGPayEfNDHYcHVtRPIOQX/Vlf9eWt7jkmzi9dIkE5UdyFCRbqmthHsL5sdUYHDdzmF224metc8D4/UZLTefbr1aCykSTz8GuegBYihJtJj9HQLSuqhsC1csL/Hcz8mIOh4BMUA4fLLMNNcFvr2fU/MFgDEIywiaLC7kJixnX/QnaMNG8B/mI+9WMg==
Received: from CO6PR03MB6241.namprd03.prod.outlook.com (2603:10b6:303:13b::6)
 by BN6PR03MB2803.namprd03.prod.outlook.com (2603:10b6:404:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 03:18:57 +0000
Received: from CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992]) by CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 03:18:57 +0000
From:   Tao Jin <tao-j@outlook.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Tao Jin <tao-j@outlook.com>
Subject: [PATCH 2/2] hid: multitouch: improve custom quirks kernel parameter
Date:   Sun, 17 Apr 2022 23:18:27 -0400
Message-ID: <CO6PR03MB62415B5977AF75C5B753E73CE1F39@CO6PR03MB6241.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418031827.37423-1-tao-j@outlook.com>
References: <20220418031827.37423-1-tao-j@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [y4Ipa3BRE2iMwtouKB4bqH4sLFFkNTwu]
X-ClientProxiedBy: BL1PR13CA0260.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::25) To CO6PR03MB6241.namprd03.prod.outlook.com
 (2603:10b6:303:13b::6)
X-Microsoft-Original-Message-ID: <20220418031827.37423-2-tao-j@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e8dc4cd-3e9a-4863-bb73-08da20ea2d17
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiTzvpWxvWYRCitoSl4QfY+H6OINTa2VFd7O6L1T5rYjHH+ybC6ZZRik1QjKSRhpk5soJt+GfMxK4p9+tcCrQdjZ7Xny+AIIpeeFZTQZb5wneOO/Y9vySRwfo8tQhvHn7CN1CBeCogdySuGnIhmpvLXgg6TGVTNFN7PGS/4c7rjFQB+20X7unvf1hbApq0ZTCcebeFH1qChC8S73FI8CgFSktgAq86vza/in/W7wd+WgYEo34jvCshuZBveS0txroe+oeSlIThHFydNGsv8/FpplvEF7gIUBn+PYRGsg8US3TjhmJDoIG9ufyY8cbBzO0jlOWB4JL+/kFvcwQgEfzD8Uo3QR2tLlH+yxNyrYdaUHE9CR3XIa3wVba01Sdkk+SoJZWgE6G7x3hsaJ/sIiERqdWb9H6/EbsZSwvFyFaqH0y1XZAD0oNXytba5y5AXZHdCxL+SpdrgOWuRYCghJjwmShNi+yNmJpdOFI58aCW14GWHYUhRZZWloZ9fSkb3B3zoDDv4Iyr6XRwyGWGMPd62u+LSpO1RvlX4Y2aHU8wProldCB6J60JZWf3J+y4E1fs2/ZV2/SSpyfg+ALbC3XoSMB/2/wNciOcYAhLASwQsha4v2MGEzxbdQDpke/s+CX1P8n9lDZlaRXPcPYb0Et2Nf5lsCKm/DR0aeMjZDBCV56OecypMeK3soRFs7j+6jedmw+QvH7EPYb8/87NjJPaYjBpWnHawKI0Q5GtLVFAHg9ye/HomIdK4/TPlPVfb7KGs=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2803:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EinjgVQIU8Po5+yboiu57EvPYugC1NhccAy7QqWgszXhqS5xLkzDoC2udSHeQkrpzTESlf8XrnSlL7acUSKMnALO8pjcMiZOOEjxfhWTdineOmLUcuUFOgx67eAz/MCQ11qOssecvioMBeH0gxlT15hNr5MdSMiSXWoJ3uyjhjF648VqX7/+sBLEpz7fnvdDyftSxCpp/ueTz2gsv3/hXGlnytSh6Y/k4sM8bo9/d9eZ84TIbSZ2habuIxr/cwWrQyVum/lQL4Y7Bqw2uPRuCPVyIUvnLpvuLW073+xp1wAaEfWbZaGF9Yg3KwdsuOr5Yyt56SfY6PWKrEDmDFu8qGZ1u2rncSd0LUyM4FEJvUD+FpjyBhtQw2Gfccji8FPr5hdu5dBdAcMa2aODwD9eJ2d9TUWObgWuBJUSABwwPXX7wUNuMzQIeE7G3XP/SX0zN9987P3Cz6rufEmImXgBoEXtGgtyhqjlxdxbByh5jMguKHcsQJT19VI70Nk2vLJlcOuMAIweb6q0BUaPlPgBCZTGdVoGqQAS0pC8xiZpRV55B7qj4iQFXwBQqhTlk4zOr0lM3170+qoPnZ4TwB/1Ig==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08gOtESjTvxyZ/Y2CVxl+vI3US2DhyTSNVYRw6cXuhq29FImECP/u7rgnWxa?=
 =?us-ascii?Q?nfWKldCdBQFX1IjYpU+OKtLq5Y3tPYCRcXGu6vB8Rs28d6qe+Tm3aQ4muXwL?=
 =?us-ascii?Q?PsWzjsMpH7t0VDsA/Lhv5bEM/N7/JN6oTLkvXvj3J0PIPZVfS4LNLt017SMx?=
 =?us-ascii?Q?rQUwxTsrYYiNSycwuj3wf09TCzEninlg3Hm/S/80Wiro3sedYH2/T+VjT374?=
 =?us-ascii?Q?hQGOwekgI+EMWFYVB7xjgY8qUu3MEeqxVcnnN4ibHbq5Fwz6Nl+p6uQJfAoO?=
 =?us-ascii?Q?/igmLVyN6YO7W6Otq2yi8XNpSYMPDnrguAuedigQBid6iuRMjU7fILRlWmaD?=
 =?us-ascii?Q?ykhJJzTmQ5DMqxNJaT8lgXgnUehqcC9o2iNMRZ6RqLWBKzHe6Q5oOe8re0sR?=
 =?us-ascii?Q?LF2yOuVwotfz0Vy/tSqfIXDgyv8NlRo6GA/hpVWUkpuLl3gWg48HJzhnooXU?=
 =?us-ascii?Q?9Gacg55FbN8ai8CJNCqc2dWR9cmh8R7TPWNjeeYyFAml2n/Meld136uQ3xHc?=
 =?us-ascii?Q?xbj77Wc/j/G6dOai3/GKTLIeaY+8Rg8YET9RIBa7ZGKKqG4zlQmCUbjA9vY7?=
 =?us-ascii?Q?VZDSj0ckhpEyXyVGBoN8B00A92lI9TsSIWC0gISoxDVpubaYc7l8uZjmWxaj?=
 =?us-ascii?Q?PpoWc+YGHpUQ172RBLvfQPAs2AwJS7Zv+yLbW0Jz8lFTQgc7ibEk9YZrJMT/?=
 =?us-ascii?Q?cK5BtsIIKtua6mfCd6UxeFGgm+HNDEHGU7gkH2b5mhYFjDQLyu8Bx+NAOfcn?=
 =?us-ascii?Q?QtdjjGc78bshu+8lpZIgjjQ/uX6ayYulHUTOvFyXUSPNhS9FTHRhti4bQG3m?=
 =?us-ascii?Q?89k6zODyehpECbRNvqne7GBVo/8PbITyWMPCdVovbVFCZttv+S2VYsvsOymA?=
 =?us-ascii?Q?t8nsLhOobmLFS6L/5XHnePY0DyefXBagq0bfgkmjdbDWG0VqMZTQxD3fkNB9?=
 =?us-ascii?Q?y0etaLt3FRX6y4aZHNjMFoSnp0L9lH6moqUJA6rgbQeXiJwoK0LM7e+KUhR5?=
 =?us-ascii?Q?ZFbhOIqTN8mfJzts4vREpCbxuok6C3zjtuo3ppYn8GMKsnguLE6PEZaVKqJ9?=
 =?us-ascii?Q?dhVUrclNBxmd5xdD/x5uUCdrpOScdc66YktvY5cKRGueUg6IEBniMdv6xJ1z?=
 =?us-ascii?Q?12TyvEtmvOCvCLsgubV7Sot/drs1LQBq8+C3CXCy+txs4b8gV3il8J/nIx+S?=
 =?us-ascii?Q?pJPsxkHrUivvYsmCcVg5Y+KodONeHSY5+gojl7aFQ9h6BzmRTETWXdpb0u/e?=
 =?us-ascii?Q?OUxe+yvA3fqLX//1Cm4Z2skK7lfibK8yDkP6GiCslXVnx9auxQqiFu56Ev7M?=
 =?us-ascii?Q?VnMSO/Ns878ZoNQ5n1MUjhvZ4IuYo15otXsaPlg8X40DAZlbB7LislAMNVqD?=
 =?us-ascii?Q?o17dP/dhGLdSToCDCRCSZfxhWAFEOoR3gQAEuyv2Mecb/QK6pXUlEPLKwU+u?=
 =?us-ascii?Q?Kvd37sRopZg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8dc4cd-3e9a-4863-bb73-08da20ea2d17
X-MS-Exchange-CrossTenant-AuthSource: CO6PR03MB6241.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 03:18:57.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows a list of different quirks to be matched against
corresponding hardware ids in case there are multiple devices present on
the same system.

The code borrowed some idea from vfio_pci.c

Signed-off-by: Tao Jin <tao-j@outlook.com>
---
 drivers/hid/hid-multitouch.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c6d64f8..f662960 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -398,9 +398,9 @@ static const struct mt_class mt_classes[] = {
 	{ }
 };
 
-static int override_quirks = -1;
-module_param(override_quirks, int, 0444);
-MODULE_PARM_DESC(override_quirks, "Signed integer to override quirks in mtclass, must >= 0 to enable override.");
+static char override_quirks[128] = "";
+module_param_string(override_quirks, override_quirks, sizeof(override_quirks), 0444);
+MODULE_PARM_DESC(override_quirks, "List of quirks and corresponding device ids in hex to override quirks, format is \"wanted_quirks:vendor:product\", multiple comma separated entries can be specified.");
 
 static ssize_t mt_show_quirks(struct device *dev,
 			   struct device_attribute *attr,
@@ -1714,6 +1714,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret, i;
 	struct mt_device *td;
 	const struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
+	char *p, *qk;
 
 	for (i = 0; mt_classes[i].name ; i++) {
 		if (id->driver_data == mt_classes[i].name) {
@@ -1753,9 +1754,28 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->group != HID_GROUP_MULTITOUCH_WIN_8)
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 
-	if (override_quirks >= 0) {
-		hid_info(hdev, "overriding quirks with: %d(0x%x)", override_quirks, override_quirks);
-		td->mtclass.quirks = override_quirks;
+	p = override_quirks;
+	while ((qk = strsep(&p, ","))) {
+		__u32 wanted_quirks = 0;
+		__u32 vendor, product = HID_ANY_ID;
+		int fields;
+
+		if (!strlen(qk))
+			continue;
+
+		fields = sscanf(qk, "%x:%x:%x", &wanted_quirks,
+				&vendor, &product);
+
+		if (fields != 3) {
+			continue;
+		}
+
+		if (id->vendor == vendor && id->product == product) {
+			hid_info(hdev, "overriding quirks of %04x:%04x with: %x",
+					id->vendor, id->product, wanted_quirks);
+			td->mtclass.quirks = wanted_quirks;
+			break;
+		}
 	}
 
 	if (td->mtclass.quirks & MT_QUIRK_FORCE_MULTI_INPUT) {
-- 
2.35.1

