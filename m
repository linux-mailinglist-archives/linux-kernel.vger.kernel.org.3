Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD947315D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhLMQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:14:16 -0500
Received: from refb01.tmes.trendmicro.eu ([18.185.115.56]:49207 "EHLO
        refb01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhLMQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:14:14 -0500
X-Greylist: delayed 836 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 11:14:14 EST
Received: from 104.47.13.50_.trendmicro.com (unknown [172.21.19.81])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 8A42F10D50922
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 16:00:19 +0000 (UTC)
Received: from 104.47.13.50_.trendmicro.com (unknown [172.21.168.253])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 620B4100022DF;
        Mon, 13 Dec 2021 16:00:16 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1639411216.051000
X-TM-MAIL-UUID: 8b6dbdfa-6435-416d-b391-5a6a4c9f02e8
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.50])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 0C8C110003E58;
        Mon, 13 Dec 2021 16:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RavcRbZnBHOkL0PYba6mHw/gBHU7SjLLMtsje0tqqDYpUz8Y0VZaIiNkva0soXytX/XYK2JlT7IHyVOv9/el8mZkbYqKjdH77DfGkQvhVBK/dNy6iCEWCKxL9K38DDIkBxFrRYvV7hZZzm79kbWt3QaQ9dMu15h8isZsOwxQ+T9EfW1Qj8AgZ/Q97veZT0P1iyDV8smL0H21AirZS8Tj9GW9J9e8vNPiPB6lYiiYun80BLLusIHkPigtzGp7RcbTdWAi4muBVF+XoRYXuAUuks0tMwDzzDujFMQpG2dXPon1XpMGemNRvEDaz9xpURFQN9DZ/zf/1PU3fiG2LN+hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQxtqnC687uESce1WJxc3qnJ6cz60BgMtRgvT9np2zI=;
 b=V+DgFBLSnjHLWOfLIF3/lAg5AREa6VJhz/IczvyzcMJPuF9RbtCMHsAP1XBMVWeeajn9mB3n66+WLkx9MiaglLBPRLLuMj0vhKDWOCrp67WclPu8WdAG2/iuTXMyaePg/Qu64xDTFVy40W139TAJmiVPm2JnGDNHjreKJHFhFZhn0ZiwOQsKxuyxu7Nm+JYCW30ojOYlAHVHMIHKBmms/wmWr1wCnVgOWzN4vcejYahW07ZR+cZNTGT2rCTHWGHk41eHna1Ax2DWklEKbURMTttfWOqZNwUf6vdjt+xueh2GHAh3AdOyjIrKjmS/YCJknhQdRSbXTKxqnmyKhJDYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Date:   Mon, 13 Dec 2021 17:00:08 +0100
From:   Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: [PATCH] virtio_mmio: pm: Add notification handlers for restore and
 freeze
Message-ID: <20211213160002.GA202134@opensynergy.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: AM0PR02CA0188.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::25) To DB9PR04MB8412.eurprd04.prod.outlook.com
 (2603:10a6:10:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04914237-8dc9-4387-0f58-08d9be51a68e
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2390:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2390661E5B72D19158576546E1749@DB6PR0401MB2390.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AK77xCBP++xmecZeyKlc5pa3pUag/OmxGb4fUVHDWG/XpHW7V1BV9jk0IqQGxjq5m+zIk5QZQb73tYPyyWK3wi8UHurtCIV620GrLHRf1dbETwo801aPCCHfJUuQzEVCFmJgDC5eOqrVdegoD4ji49Oh3Ys/GOzb198YXxBEd4+ZwJ4/0BhBSf+rVJUzkTTpvbMxFIb3aH+UZ7b8xfkr9FNsn8u6noaxrcyUXcYzq/IXFJEhRoNHTElRxrEEJeh5PGHWlWKawgMV1PH2DXrk8qr+c4Z0EiEkPtuooTfMRHfD7CEqkmzqxBts8aDIwt5WpeJiuh0yJbu2t+wzivEB7dogVxgy9TeJjlsclFzCf/A97p7xQk2G8LaDc8rIxGRS/JpHjs5/znt+DXtZSi+QufWYxUu7ycShmGjeVXOlF7TxmaVWzkxLypF0n0CXFHhIBblIwtwETLDsndo7D26T8bFo6KSH6WDFerxnEi713rUAsyCi+ZYPHkH63mx/m0rHW2ZEieo1U0EYVe0MAtWbumJok04tVMhWd4bbpli/JVdxQxIyDybXPVpQ9+W2tQOLEwq8+Tkz/xfpaGAdk6FovGa9LPlKZj7sksVgIjEMk6KwKcErB24gHbhzLhU/cxOyym6KEqe+Q0DRkD71Q/BdW9GYml/iwHn/YzhG4stmJTMIVbPhOvLJEkGQjA+gHtR+IqNOmdWLT8uOcNPOCYqg8VXGwtsX1vOQh4QNeHbFpfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39840400004)(366004)(396003)(376002)(316002)(36756003)(107886003)(2906002)(33656002)(2616005)(38100700002)(38350700002)(54906003)(8676002)(26005)(8936002)(83380400001)(52116002)(66946007)(42186006)(508600001)(66476007)(186003)(1076003)(4326008)(15650500001)(66556008)(5660300002)(86362001)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWp6eG9VQSt5MmJYa0VnT0hxNlhjeEJUWHBxaWM1aEcrZithMGdYRUFvWFRO?=
 =?utf-8?B?ODAzTWlMOUFUUzB1N2pnZDZBaWxNb28vSkhaYzhRRmdzekoxM3NFSnJWekFZ?=
 =?utf-8?B?azBXYVJNdHlUTFF2bzZBRWFzWUVFUmxrMHR2MmJsdmsvelRsN2pnZlU5dzZ1?=
 =?utf-8?B?ZHZFblRPUmgxS3c5OWJWMGpIM055NXF5Y2ovY3dJV1pUYnhBaFFtT0xaY0ZG?=
 =?utf-8?B?N2xGbmRtUlBoRlQ4WndtVjhSeXd2UDhPVjFkWHROOVo0aW1qSFlJb3lDYzY5?=
 =?utf-8?B?bkR2K0Y3N0ZJMXo1b3hTV01Dd0NoWHVuSmt0T1VuY3daeGM0RGROdEhEVVpI?=
 =?utf-8?B?WVZ2V3Y3V245ZUFVSS81d3MvT2pWVmpIZm8zamdTeDVtQ2VKUWs5UGRWNW1Y?=
 =?utf-8?B?bmlVZUFYWklHY0JSbWFGZnBxN1JpWDVsaXZDVjhUMjJhbDRqaHdveXViLzh1?=
 =?utf-8?B?QnlHTk93TmQwU2o2dlg3VmNFZys5dHBDYUV4bzJqMGJVOVRvZmpNQm5KaXhF?=
 =?utf-8?B?cUplUGh4T3kybWR4WVlxMjNpS2FSR1dBRmNsZ0hOaEk0QkxyZFBKRVQrTWw1?=
 =?utf-8?B?Q1NUU3ZpckZyR2NGNlJQL212QUtLeXdpT1F6QmQzMHVXWXpEak0renVoMHYy?=
 =?utf-8?B?UEtXQU8rVkU5dDVvKy85eE51UGVxbjV3aXp4T1NSQ25qOTJ5R0NlK3l5ZnZ2?=
 =?utf-8?B?M0huYjE3NUc4ZWtJWStjZXJtVjJtQ0JVMkhKVWZjY1I1dmxDMjZXdlFIYlFk?=
 =?utf-8?B?Z2tmSmNzVTcvcUJGRXNVMjc0UkJZblIvSWlyQ3oweTBKK2FHTVc3QVRhL2E1?=
 =?utf-8?B?VmFKZzk4R0NObTJtVmVsSGM2bjFJVnY4ajBMOFJBamFCYnY2UlJuNmx3QVN3?=
 =?utf-8?B?eUVacXpqclR1N1lWZkJ0bjRIS1JIRWJQMXFzaTkvMUloVXE3d1VkUWUyY1FQ?=
 =?utf-8?B?NnhFTEZDWnVzWUJ2aGo4SkNsMjFBNTV0V21CNmF3RHVpUkhYbFBrZWV4NHJj?=
 =?utf-8?B?Z2g4eFFQOXpURUZsNW5aRm4wTzQrRHlvb2VMMmtRT3E1c05RL3BQb04ydmlt?=
 =?utf-8?B?Rm9CZk9DNzgvWVFSK08vMGpnR1lTa2FkMXdERUtBdzRaS3hxQkROeWE1ZndY?=
 =?utf-8?B?TzRHQ1JZTTVLMEVUcS9vMGRLcHNzdElCMUlLdndGVzBJcUFSZGdoOTFaTVRK?=
 =?utf-8?B?Y01IeDhrYWNwQ21rRkk0SFMrenNCUmh6My9JQUs2RnMyZEt0TDJRQXgrRW51?=
 =?utf-8?B?MklQSU9VdUhTK2syWjZFOVE1WDhmcmlMYmU4QlZKUEhobW50bzNrdWszNXVp?=
 =?utf-8?B?YXViWDN1c1laN1J6aVJjcjhHTWFaVGhGT2RDTlRCbVBrT2w1NTRhSVp6K25S?=
 =?utf-8?B?UXVyTlB2T3VzS094MXpvUWtJM0NqZDAvRXlITHZoRHE1dEw4QUdtL0JLaUx5?=
 =?utf-8?B?alJXbEJwU0huZm1zMW1Ma2FJb3ZkN2ZkM2IzYmZzbnRlY0RBK2I3bmFNRXAy?=
 =?utf-8?B?cDNvRlgxcjd0T3EwZjY0dWpVV2lnWWJMRDRhcVRFSWl4SjYxK1hLa3g3M2wz?=
 =?utf-8?B?cnB0ZWtkTllEdUt2ajdnRHVRa1VaNGFLOElUZDVzSzJ0MlNhTG9nczVDZkpm?=
 =?utf-8?B?UHNKeEQyUkZyeElUZE5UWHZ3eHVlcjd3WkR3NXl3TUF1L0l0R1BZVEZUamY2?=
 =?utf-8?B?WjJzd1JveFYwTmtBRnlEc1ByTU4vK29jY0pUc3RQd01PUHZxcFQrQjZnRHpZ?=
 =?utf-8?B?MXpNclcxMHpwME9CNzlTNS9jVFVhTFdjakZLTXFVVzhVU21qenF4ZmdCeHAy?=
 =?utf-8?B?SjVTOVVVN3l5OVRnZnd0UDNPSTBmU0tSeDZ3VVhWT0tUR1ZEVXVnemsxMFly?=
 =?utf-8?B?TnVTdS9mTiszRCtvUHNMQWt4b0NRbk5qQkxiZjBEYUYvTzlCbFNuVGIzSmZN?=
 =?utf-8?B?VTBtQW1rV3h1SDU0bnlHRWJ3NmpsYURtdTdNOXEybGFxeDVtK1F2ckpPMi8z?=
 =?utf-8?B?dk9yakJ4L09WNFUyd2g1eHFPOWg1SWZ6SFlEdHA5UlJFdmE1WVpmSFNWVkho?=
 =?utf-8?B?cjNQWmMwU1o1bFFiZEt6WHBERmt4d1BxUGFDUFFaNE5KNGhhQnNoY3JlL0F0?=
 =?utf-8?B?VUxuN25mNUovaFpzVnB5bWcvTElvcVBSR282YThZVFFsNXFKTGVWd3dCcW1p?=
 =?utf-8?Q?lGYvqfIdQ64J+mG/KnnzzgI=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04914237-8dc9-4387-0f58-08d9be51a68e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 16:00:15.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZANiOEiN1YUEXRxw4rwEeIkq86jlT2AY2pYNnglav2jChPsRLSXamLRv7IB5PlGuWIz9k+aHToXyDgZhEUQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2390
X-TM-AS-ERS: 104.47.13.50-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26588.001
X-TMASE-Result: 10-0.009400-4.000000
X-TMASE-MatchedRID: aJlYsjcyCKmioKUtUDGXZW095hplj6TX5elGd2HzE5PC97iW4thF9kAc
        6DyoS2rIj6kCfX0Edc6tL1mMSnuv1/V1unj0D4HCEVuC0eNRYvIzAx8HYox0h3QWhLVqLFM1aB9
        oBARr9ljoHOpl9ZcDR1+24nCsUSFNjaPj0W1qn0SyO81X3yak8zl4Xl0zbG3xr7dEX/vDOyJrLJ
        /Ih+6ECqAc5IUuJc0AtRESxzsllyp+3BndfXUhXQ==
X-TMASE-XGENCLOUD: 070a32a9-dd8f-4f93-889a-5f28e2263664-0-0-200-0
X-TM-Deliver-Signature: 7451CC838A859017DF4A605CD1C0D715
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1639411216;
        bh=ByaXkn133jbrs4zH0fzDsUazQlr2iAUy7Iu0fA05cpI=; l=1646;
        h=Date:From:To;
        b=MxKyPVh6SNftZq84oJOK7eEmZlYAeyomV3HIV9vvYHV8PNZNOcUFUIyqrIwB6X06B
         HgVP34criLdAmSRwGWWD8xZPMHKQrDyYP8mG04MUoeMtbrom525b3Y8JaG6jl2IOhu
         5GlwU3T4Uu7rcUokUSUIPqQwQhelxO1/AhoOqdlPtw2KOKEzZzWwur5x06Afhsku4o
         kaHmBKxE9PErwKtUey+FNIywDgnzKJyC9QVNeLq1s0gt/46Us1uV6D0vLNR2gI1h36
         wVFDiCwq/Mw+qTr0WOWh9uZy8+OKBjyoKlDqz4AKqHrh8AyVkQ6vlwF7NW9JJr75wu
         b2ZFbknByHJeg==
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
 drivers/virtio/virtio_mmio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..af79f8c2a2f2 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -762,6 +762,24 @@ static void vm_unregister_cmdline_devices(void)
 
 #endif
 
+static int __maybe_unused virtio_mmio_freeze(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
+
+	return virtio_device_freeze(&vm_dev->vdev);
+}
+
+static int __maybe_unused virtio_mmio_restore(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
+
+	return virtio_device_restore(&vm_dev->vdev);
+}
+
+static SIMPLE_DEV_PM_OPS(virtio_mmio_pm_ops, virtio_mmio_freeze, virtio_mmio_restore);
+
 /* Platform driver */
 
 static const struct of_device_id virtio_mmio_match[] = {
@@ -785,6 +803,7 @@ static struct platform_driver virtio_mmio_driver = {
 		.name	= "virtio-mmio",
 		.of_match_table	= virtio_mmio_match,
 		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
+		.pm = &virtio_mmio_pm_ops,
 	},
 };
 
-- 
2.34.1


-- 
