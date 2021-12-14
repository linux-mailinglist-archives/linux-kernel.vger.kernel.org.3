Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA76474738
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhLNQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:11:42 -0500
Received: from repost01.tmes.trendmicro.eu ([18.185.115.23]:52689 "EHLO
        repost01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233370AbhLNQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:11:40 -0500
Received: from 104.47.2.54_.trendmicro.com (unknown [172.21.168.253])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id AAB0610000851;
        Tue, 14 Dec 2021 16:11:39 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1639498299.372000
X-TM-MAIL-UUID: 1fca4483-9b49-4ae3-8460-4368a171a57d
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (unknown [104.47.2.54])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 5AF10100002FB;
        Tue, 14 Dec 2021 16:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIjMzBJnM3icaK/u6y4nJ8jpRh0PTKzDgC5AdgHo9I/3cr9Mp5hl92unhoutjq4uUTqzoVtIyyyMHShbkjFzLwBJRGkYo31u5JxpjgyYcz8HC3jHyUf2kqgc4XkIDU3/TxPkeqssuOw+/NNPPIHoSjBqI1L6J7PzfHM7eOxgiAsQraX32LCogLoxHieUa8tto6/+EDcFQ+yDxSEKbUcHT6Q64diJLQPfLu2AEY/FH22Gv7+b5TgkzdpA2LCIW6M9ZibMXYJnxjA2oZoQQ6NNqB4M/76p1Gsj/GjEgiQrbEsM/i2Urg8YWthqpHts6+XN1Z775/Tro/13BV49gNaz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EgkGJgFeW4eKckqOwuoYdnEgV/YXFdoz85zhR+6+NA=;
 b=LppS3H8A+ipyS9OHC4ZBEnrx/XoFZxogMeacqSiUmgkwblyJmD6dpszI1TFgSoX/OaMVJr8geYdyJOZ15jSaei2pr/bAeVwVDWKfeD9Jb54PeRCZ+jKo0F4n+QfAyd47ks9y1Qdcy2eddZqHA9x+9xGo/9ZS3QGYnHOb91q78zazOiUGRfEED9fmEMdWQNReQ0WYWIppVkcPS5FQF6TY63nXYCtH96tGhzgybiQwvrfXD2PWqI2nYEzDSuX2LY1CgOk1O22baMvYCRvKeJFYpTKyrOkvBCB+lmMuo5Dz61CoGbSyhxSWVmtqoHvi617vKg9JFRJilmWMVCu3slfHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Date:   Tue, 14 Dec 2021 17:11:31 +0100
From:   Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Yurii.Danilovskyi@opensynergy.com
Subject: [PATCH v2] virtio_mmio: pm: Add notification handlers for restore
 and freeze
Message-ID: <20211214161124.GA202691@opensynergy.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: AM6P193CA0050.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::27) To AM9PR04MB8415.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e27067de-a10a-414e-1450-08d9bf1c681f
X-MS-TrafficTypeDiagnostic: AM0PR04MB6644:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB66449F641B3241AA7C610AD3E1759@AM0PR04MB6644.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YCCXnmaKBgVJ9LczVxFawaIioL0TWHToH+xC//AsWnopObE0Te7phzmnQoPaMsYYIFHfQLu5JiQR3lE/dttj6E8AuZXxCCC10zFKEWF9i8PsWSVlYJefVnqa9GBq2PT4xNB0qHJBSRHDadKUIQBFMHiWqdMVJLXNhSy5Qz828hiXFhkjKXYKhnJrpFOIu2uW20lYedKA9P6NyixIh3lm24X2u7KD4j7zlHPF475QahxlbUAOoJPafyYvYwDxv8ZeBF6fert/d1DSds0ZFYWKwii/YXQWJHmWzb+kMAzexWjG4rxbcw7lKDvP4hwZ8plSHX5o2DH8kI3nHS5hWyE6s1u0AtKpLyh3stL3ItdhKuni/ePnWMug43QHolRa/Vi4iLoPtQhA9LLo1WLlYCAANlcFM9ANBVs3Auon/GYQd/lLgZaRrg3fYqr0F8+hEOpNs4fkfJT/sq2s50nI0hU226zaOg/oLbp/Ltj9asZMywliWphTbjvIWHe9v4xsV4xcSQaNt5PYe3bIJ3uehqEGb0VYZiHo0XMATTAePEAD6q058DHb/bHgILry8SfPBBYvtH02hI37bqJm91tfRpJcAtihs1TvjCqYclm6VEOzo5d9veLCGLnmowD/wju67F91ptx3M2kYt+5cepmtcOPdtcRju20l+YnQK6hYlHwpzxjyxAaEZgDjbN9u61r8kY341S+WuKrogDsXuPFof8QA7Qj/boJ0x+bgbmDYyYl39k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(136003)(396003)(366004)(376002)(107886003)(2906002)(8936002)(1076003)(42186006)(54906003)(2616005)(508600001)(15650500001)(186003)(8676002)(4326008)(316002)(52116002)(5660300002)(66476007)(83380400001)(66556008)(36756003)(26005)(86362001)(33656002)(66946007)(38100700002)(38350700002)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUcwT05BbDRSYmYrc3A1UzQ0eTJta3UwY1REbnZucEJ6NERUMmpTWmhJTHFP?=
 =?utf-8?B?MEh3RFQwcGN6b1FoR2Z2NDhRbFgrQURZMXQ1QnB4OWNJVnc5UDNnS3Q0Y2JV?=
 =?utf-8?B?Rkg0Z0hpVzgrVUQ2QU1MS243a2oxZHlqSWlyT2JQOUlwQXZUbTMwYXp0OG9m?=
 =?utf-8?B?K3AvOXVGLzlXdnVZS1RsZ3V3aUJLMjBOYytXNE9LSGF0ajZRRllqSjhRcS9u?=
 =?utf-8?B?bnl5a2pOTk5xMDZESjNBTlhPcFg0ZnpzenNFVGhsWTlNcEFLVGE3SnE0TSt1?=
 =?utf-8?B?Z0hESXUzTU9TV0Jac0R6QmtLdGNTbElIUHJVckx6NlI1aElPNEx3VFJrV3Zq?=
 =?utf-8?B?ZDV0OTh1L2tvb3ROOGQ0V25DUVhBUDR3N3B0QXBMNU1Xbk4rem0wMGN0b21y?=
 =?utf-8?B?UENmS0FNVFlGSHhrdTZBcm9VbzhVSS9QTXVwOUwrWHVySTREclA2aFVVbXdW?=
 =?utf-8?B?NGJscVNKN2xUREMvK0VsOHAzM0JScXdHWkRuOGNEcExFTmVBRHlSZ2N1Uzhv?=
 =?utf-8?B?RVpPejRrUHh3dEdtNnhneFZIMFFVa253VlpVOVhCNHozS25zZTRwMmhFT1hW?=
 =?utf-8?B?WURxRjg0d3p2KzZoSVE4Mkk3a0VSY0lZU3JTWmVxQklHM2pheEVQWGJpcHFt?=
 =?utf-8?B?M2s2amtrWmRCUWNTeXB6aWlzTzk4TWlpTEZkZ2JBbENvNmNnRER1TGtEb2pz?=
 =?utf-8?B?RlVGQlR0OStiYnRMM3lGUkx3Mmc0alRnVjMyQXRuckZITFdxYXJ1RHErd2pS?=
 =?utf-8?B?L05hWWhFblIxczlQZ3ZLTG5rdWU4U2F3NnlOWmdQL0hkRWhRYlNZNTVvZlAw?=
 =?utf-8?B?eHdsT2Q3OWRmTFRsbWs4KzQxWXRRdzFnREZHVnI4L3VBbXpBNUIxS3lkTmVj?=
 =?utf-8?B?MlIyUlRMVy95L2luTlFTeDVqMUg0WG9pNFlKdXdDZmp1VGtWam0xelVNT28w?=
 =?utf-8?B?a2libnFiZXhKNFgwQ2RSZU40VHE1VnNOdURvMmtTNHVvdXhEa0drK28xUjlo?=
 =?utf-8?B?OFpVVm94MGlETCtLb2pKVGlqb3dCUjhidVNNb3d1dldQVjF0ZzUrcThONkdZ?=
 =?utf-8?B?L1VkTTFCQTNaMlQ3Wm0vMy9ma0tRV29JUnR1SUpVY3NJMEtWTm5wRnVLZ1Zw?=
 =?utf-8?B?TVpybjdNd21WYVkzaWxSQ3p6UHlYMy9EZjlmQnNvTVorVkdQMVIraVFKUzJa?=
 =?utf-8?B?K24yL1E1cWczWkVLRGQ2YUxYOEJlcERuWXZKdUNVNnB6c1I3NGhoSTZLbk0x?=
 =?utf-8?B?MTB0YzdtQWdCQWs4K1JUY2tEQ0FrdkpiZ2k3M3daNDVpM0NRSzZlamFBNzdv?=
 =?utf-8?B?c3FkQTdzazgxRlJHMzZwMjdvd1d5aERBTnNHTTlYMFF2RWZ2YnpJUWZMWEMv?=
 =?utf-8?B?SWRTcXpEVU4yWVB6WWFpTHp6eTc1TkIxMWFTdSswd252OHhaWDdaOHpQc2tC?=
 =?utf-8?B?bmJTczVjTm4wNXRuSklGWmlwVEZudTZZMVpLQVBwd2tZWWFCVlV3ZVVsNGhp?=
 =?utf-8?B?WUt1NE1oRnN4bUxDUnNSUThzVFBXRno0V2M4dW1ROFZnT3B1SXkrWk8rTjZQ?=
 =?utf-8?B?dzhiWEZpY0oweDUrL3BXVFZSWi9UQU1YUUVnNmY2WDA4VSsvWWdxTlJWQnpZ?=
 =?utf-8?B?Z2JuUXRya0Y5dFFnSDRzMllwOWFHRisyd0Z4Y3hrUitpT09aZldNR1FENDdO?=
 =?utf-8?B?OVBzK1VNcWN0NjA1bG1ERHlaK0gxQlB0SVpZOVhCVzhsY0diVEsyZGpjZ0xL?=
 =?utf-8?B?OWZlVzB5L1phWGprbUVHZWdLOGxkeHpheUJMbDJ4MXI5em44cmFzN2R0Q0px?=
 =?utf-8?B?MkJONmt0ZGtpczk2OFdzanJHWkFCVlMrMXdPMHJyNW4wU1ZuOEQyWkw4S0ZD?=
 =?utf-8?B?ZHQxOWlaRDNWN3pKajUvSTZpWFhtb2k1VWl6aFlIOW05bzJOdmNHT0xBcytt?=
 =?utf-8?B?YklSTm1vMy9FZi9DYVI0aDRvMUpqcUYzSk50RTVmWDlHSEg0VU1lVUdzWVcv?=
 =?utf-8?B?ajJvMlc4TnA3WGlucnJhc1g0aXpUV1RWa25ZNC9xeHZacVFFdnowNGZ3cGdZ?=
 =?utf-8?B?VythdXkwdTdUWmlJc0RiQWVxbldQS240RlNGb1NmZ1ZXV0E0SlJHSG5WMHZr?=
 =?utf-8?B?L3ZQaC9hZUxkYWlQVEprSEhJSHZYdkpocVhlQ3dhQ2xqdUxDRFBDMGZqS25m?=
 =?utf-8?Q?Y74xB5DOizR/WJUD8LN8WFE=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27067de-a10a-414e-1450-08d9bf1c681f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 16:11:37.7899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN0FR2CVKgis1r+dj5eodRcDwnzcqgqldDj4S9KShOkHLSYAwJA+rLkg/Ur7N9czvPaGtdYW1g2WAoLhhjogRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6644
X-TM-AS-ERS: 104.47.2.54-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26590.001
X-TMASE-Result: 10-0.838400-4.000000
X-TMASE-MatchedRID: yukh9NhPBiSioKUtUDGXZW095hplj6TX5elGd2HzE5PC97iW4thF9jvW
        btlGaqAeD4OH+c/JVqYf04XYJUFJ7GJZXQNDzktSGjzBgnFZvQ51KAHzaN/tsBe1yJq6HIhH0Eq
        FjE9+26idA7Mu4KSHnb8WK3DIX3w5xJp9LQiVVvyeAiCmPx4NwHJnzNw42kCxxEHRux+uk8jHUU
        +U0ACZwNyLdlRcsuuVKKpDI1EsApEE24yGV7eGH7hhGWvGwwHu+rL5VW+ofZc=
X-TMASE-XGENCLOUD: 19f8dee7-45d2-424c-bf19-54a4618eec96-0-0-200-0
X-TM-Deliver-Signature: ED68F231212DD652D06323B4BC1BA8A1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1639498299;
        bh=8HdhF+kUChSzrRM5tqqQkpErzwiDGvPcW84JVU3rET4=; l=1724;
        h=Date:From:To;
        b=eNjGlRLOe8RXjbcb++ViuxA7eRiYyHJrUei0aXzFoWGCjXEkLMNUqwXtiFpg+0WGt
         wxMMTE03GJcfPcjG6yGh6F4/qkjGVlBSsstccuAnmKrCQAQcnTH2dq3JUOkNVnbJPy
         VNcJDFG6uvt0LuCkoGhsfbGUQwlehkVdq/Q2eJs1oxMXO7rz0ZbqR77K0d2hgumFea
         gw61ovY+hjvJ5c50uCoKScRiS6GBV+9KB1oyhEglQuesthwjn3vt2OSgMqJC/9y1Wy
         5cE3NRDGQSXSPKzMh6DRU2HwlDjPTaw4RKQfwlcrQZ+McKWdbtmz0vSZQVj0RMveo5
         689pRQTJNOaKQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yurii Danilovskyi <glyd@opensynergy.com>

Handle restore and freeze notifications from the PM core. Expose
these to individual virtio drivers that can quiesce and resume vq
operations.

Signed-off-by: Yurii Danilovskyi <glyd@opensynergy.com>
Signed-off-by: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
---
v2: fix build for defconfigs with CONFIG_PM/CONFIG_PM_SLEEP disabled

 drivers/virtio/virtio_mmio.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..d5a2e8d2f31d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -762,6 +762,26 @@ static void vm_unregister_cmdline_devices(void)
 
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int virtio_mmio_freeze(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
+
+	return virtio_device_freeze(&vm_dev->vdev);
+}
+
+static int virtio_mmio_restore(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
+
+	return virtio_device_restore(&vm_dev->vdev);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(virtio_mmio_pm_ops, virtio_mmio_freeze, virtio_mmio_restore);
+
 /* Platform driver */
 
 static const struct of_device_id virtio_mmio_match[] = {
@@ -785,6 +805,7 @@ static struct platform_driver virtio_mmio_driver = {
 		.name	= "virtio-mmio",
 		.of_match_table	= virtio_mmio_match,
 		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
+		.pm = &virtio_mmio_pm_ops,
 	},
 };
 
-- 
2.34.1


-- 
