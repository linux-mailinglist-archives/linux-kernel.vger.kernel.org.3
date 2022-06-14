Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E026654B53C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbiFNQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344649AbiFNQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:00:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9173F885;
        Tue, 14 Jun 2022 09:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgtMQfWs2HUzf38nDijdwAKIw1Iusm19M2r3ERbG+Dqzwvahp+sLnNzxDr/x0EEM7t1ijzApLHH4+WicQNQkuXWAEm8H6rs/pmZh7TuUbn8+EApgME4j+rD3j+9668vXQbPF/6Sh6U2nQmcbGMDGufEQpjGGh59KlB+LpOiu0g2hcqJHF4/rK7LkQGqXxYdFKoxpuqWRHVl7O69KoIr7VDGAs02rLs/PN0KvfGdUb0h3RYvUg0v2UFvLcTVUNuSrRCWvvpj712Mh/g7ujS98mjKQu1tlS3frmhJlnwXxQDNGk6D2I7oUVM44t1jym1r4Zq3X3ZB2AO2UEEN74bN2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc7xX0x3AGd/UYMeosIy4d+31oCMZJdCgUDR7o4DINs=;
 b=gRHlz7tvM3UXgvmIOL4mhvWik2KjuiWX6EP8shQBY2E6OAvYYQvmVIgFGQTZOxIzHb6y8piLzVMvHXsJiTWWXvUC1CwGo4Cpe5RQikNB8SyV58SZ0LRevVNiwbIAddz+M5xdy9HrqK7XChzguCEezsQpq79BgXCTmUftSybYCr1WVC9gfl6QSyOwUJ1r6hO4hf1H4CuexDXv2adHqJGwTx391mvHJ6TRDJyJy0tZcta9pzdsszOXqG2OPasR2fAEJyrgb05oZIG157/MYpVdaziLNJDRKgmygbNtggMeGhovaHj5Rfiq2T4ULWCG+uYd0lc0W+HcYItUwUQxN/WrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=precisionplanting.com; dmarc=pass action=none
 header.from=precisionplanting.com; dkim=pass header.d=precisionplanting.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precisionplanting365.onmicrosoft.com;
 s=selector1-precisionplanting365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc7xX0x3AGd/UYMeosIy4d+31oCMZJdCgUDR7o4DINs=;
 b=OfU+oBs2VhNrhmpylND90NdkjZWSmIfvClT+OTmi2gtfqN2BZJBjlMbpPt9V6fNpOxeiKGe0U0yKxAW5stbgrOoTA62fEWBjhxTjZbjOhEGIuKG3HnQx7X2NpQfc5dujF6aTHszoPJB32xLuXkbRYWkCipgarG4sVZcggvslxzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=precisionplanting.com;
Received: from SA1PR22MB3196.namprd22.prod.outlook.com (2603:10b6:806:22b::8)
 by MWHPR22MB0288.namprd22.prod.outlook.com (2603:10b6:300:7d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 16:00:17 +0000
Received: from SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0]) by SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 16:00:17 +0000
From:   David Owens <dowens@precisionplanting.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ti: omap-mcbsp: duplicate sysfs failure after PROBE_DEFER
Date:   Tue, 14 Jun 2022 10:59:31 -0500
Message-Id: <20220614155931.2706437-1-dowens@precisionplanting.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:610:54::17) To SA1PR22MB3196.namprd22.prod.outlook.com
 (2603:10b6:806:22b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fa70070-9914-43bf-62a9-08da4e1ef9bf
X-MS-TrafficTypeDiagnostic: MWHPR22MB0288:EE_
X-Microsoft-Antispam-PRVS: <MWHPR22MB0288C7046171ABDB046D3139C0AA9@MWHPR22MB0288.namprd22.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGqETwJfI7UOZoI8OIb89Du8vC+5SYzbHpMDAbBix3Pxt2aJF3rNQBBYMdF3OySXOZQvcc1Se2EViEjlMShNnXA19imyJzlWhPq4hOWJsOi10mCFt7s/nDKzaUFheyNn9GZi2a2NLipA3yNIYQPoogk3i20yAVQQJ5x15I03hMCow/p1iSzW8HR4do4ecVunomYKY951BdbyHx9LlB3hZHAT0Wc7puwtmmcEvmy9nWLRgRLKcM32IRHsB8w7ONr0HCswAIm1/LBBaVssxB29m0IqSWYMPJFxr7rn2L4ih7pXg0UZ5t9V6tjpsoDQO7ftrDnB9UTewd0OuX3yTzaFUuw03mvxZVF8joFbHLu9D71T6PgX0SxD1SKuCP8qVuRjtmstrytcW/Gt0fW++dpbSmSrzPl+VZKvCFNGHAM7F+SIJE5AWS4P4i3p/+QLLCO5rd06OGwxBm6mECoCBKHddnZy55GAWZW0nNW5hbVzBX+yx8XO80pcNskWGSjcXoyRGw0AicimhVVKR+qIuF1NU5Mlckjv+WXtexczGQT381x2DL+FHDFSZ8TzO8lT6+FzM/dpg+FNkBSNA6ZKoHUdpkEAThxzp3B4SK/+ukg/pwWWmxSJ3PjGhdwUFjM4h1g9bFnJH3AdBSyIwjLdIHdmUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3196.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(39850400004)(36756003)(110136005)(316002)(83380400001)(86362001)(66574015)(508600001)(2616005)(41300700001)(1076003)(186003)(38100700002)(66476007)(8676002)(4326008)(66946007)(66556008)(6666004)(6506007)(52116002)(5660300002)(2906002)(6486002)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PUNwmKAZMcCkLJlZe4TqUoL6tO+6GiM8hKuQ+ET3EJiwnOjs1fS696O9tGq?=
 =?us-ascii?Q?wwZXPnZtgVs2lFOJb2zr095eAVTvgXxibyQLtwiiVjyEFOuL42bA5Y8Xit3w?=
 =?us-ascii?Q?33d5k/DGDpP+iOn17joJPI3WWS5YAKVE2tCMkaZ5B3AX2djbFilk5CjXSc8b?=
 =?us-ascii?Q?yPOu/wKfgCjthVXFUhQeibRR/KSmQF3V3YcOvaYV6xiXZ5LJMYSnKmrK6/Va?=
 =?us-ascii?Q?iVjH4ZbY0C+sq+4B87JRrb/plTD0yD/69z85SNWySWyj5T6+XpwUucFTg3fA?=
 =?us-ascii?Q?NVOvkR/vZViEnmCIMHjvHgYUiMFZvQLkza7yHM/wmoOOi7mBwpEt5ssbteln?=
 =?us-ascii?Q?lVS+SSwRxXpflG8YV9ANpcC6SEszZSat/SyLc+UxTbFQ9/SwAijjD0r6ogyf?=
 =?us-ascii?Q?NJM1CZvkzG4DGzcL7ViHhPdJds1XemHFEC9VOseYzDVy+yrsdUd0NZkVReia?=
 =?us-ascii?Q?FtHoLDMZ7SSbKiHvwTVvKSDoooai4Stx5ZTfDRoPrzG9qae27GPoHmNvw7lo?=
 =?us-ascii?Q?at552JxROqhNa8G2VVarETbapFvY+XK0A+eWZkdGk58Pc0fZKgwLaHqf/gGM?=
 =?us-ascii?Q?7mDsBVrV+4x+SdbEdue6Jij0rgVvU8qZFaJcPhfkKfFPKlYFHA5bkaL5DD74?=
 =?us-ascii?Q?jFWuc7r1m8JetDD52RA/XaGbChJzxxG3J9hHUj7+arhJPBlUdt2dkA2Iv6Gf?=
 =?us-ascii?Q?olKmzhNEmYa4JsZFE2WuRKWIZJBmvtHQ92E7h+WkD9kHP1XBUW7Lf7VNqYJK?=
 =?us-ascii?Q?C7rzlNrOMpcWmn5+hDb3W1KoTEO57/8kyu3yx8yZMyszI3GSuPnAuuJyz8X4?=
 =?us-ascii?Q?bqrTB9dokooOnMt2XL/yOKBna8/vFCNMRb4Rj8N3N+1PfplRyTERrM0IgcKt?=
 =?us-ascii?Q?+dZWHsjYY4WZLG4a2r1sgWf+6uV8KKMeDqLXBKY6kdSumAAk4uiT8U8t/ctp?=
 =?us-ascii?Q?rDG2YVne7Li5XMphlISvngZD2VWk+aExtKWhIwb6W3YCNq7xOsfY6J+7kXUB?=
 =?us-ascii?Q?ZA0INhFYlDe4jEqX0w02RMTUvqQtXcrm0SbhlKGStDTHfSeCRDCUKg/RiToQ?=
 =?us-ascii?Q?HxbooFVV+QA8LQD4OfJ7stUGGAuDT95GHrHVYUZ33/gNcnietzR6WTx6g8s2?=
 =?us-ascii?Q?DkSxTfryOXUn6ps25Ti73Y+11cvnNlW5y5B50pG/iA3/EaWnbG6U9cAioKFg?=
 =?us-ascii?Q?G85wK+dI0MyaFujIzzvWMxLvIV0UREZE9g5D8Q3LFbEqsU5RBvvAIgcnhw5o?=
 =?us-ascii?Q?nhMp0LfGdYcZRaJIwx1j5FhNiXAZ6aKIZSKLbgoP0fE4CTeNeEXSb4EjQjRU?=
 =?us-ascii?Q?RKhyeo70sbl9rkqQE/5/0HX8zN5q/sotXPyLpz1fieHvPWxnPIbAPyGy3nfX?=
 =?us-ascii?Q?HIXPudZpdDEnMEbhFAQQxM2hkOEB2sb3QDZD3D+uBb7LOsJmaj5G4aHEeqTc?=
 =?us-ascii?Q?71zLA8IQPKZa+oTTxo4xsWwZHBPbtwYqa0O6plfrjLG+IepxdqwgRSXjsi1B?=
 =?us-ascii?Q?yR0wL0JXEMUjh6B8DZMkXaTRW1uFUzDvANvkNFuDgAHqYto2xMBKQNwIiTFz?=
 =?us-ascii?Q?pY9BpKAYZCzNxszVowkvz96hgIzbRgVxHcbhTj74HmAuJrxSA+Wo1OzaELQ4?=
 =?us-ascii?Q?HsxAckQpZXW7Rik6qu/JPbFgE7QM/3nlBOy6fOwM4Ih73qjnUQc1T8Zin6J1?=
 =?us-ascii?Q?apM1NzuAfG1QThnKIpOsFfFgl6SBJmXOrfo7BA2OkxTspeo00nSXmocsFIVO?=
 =?us-ascii?Q?uGrSxeBzFM14XkxKZdHuHJKDvXK50VUbk34hFdi8uuYYCK8Z7sI9BAVVh1Hi?=
X-MS-Exchange-AntiSpam-MessageData-1: U68pQXD3mcoYFx6NXYRcMCABMZKgxK7Sczv2kmewSPFl7+tefKVtQdI+
X-OriginatorOrg: precisionplanting.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa70070-9914-43bf-62a9-08da4e1ef9bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3196.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 16:00:17.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa593af2-61f8-4d4f-988a-e9c4c02b7f57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X/F3DFzvOuGFc5jBJwqSkBhc1sZk3w//d5igRn0177LkxRSM+2Yuqd+/zIe3YW3eElsRfEtWMlMqDrBYlbTTMM+lIQ/hwXXNHSrRLqPF+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR22MB0288
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to sdma_pcm_platform_register() can return PROBE_DEFER, leading
to omap_mcbsp_init() being called multiple times.  sysfs node creation
fails in subsequent calls to omap_mcbsp_init(), which prevents
the driver from ever successfully probing.  The resulting errors can be
seen during boot:

[    1.749328] sysfs: cannot create duplicate filename '/devices/platform/6=
8000000.ocp/49022000.mcbsp/max_tx_thres'
[    1.759643] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 5.18.0-yocto-st=
andard #1
[    1.767181] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    1.773498] Workqueue: events_unbound deferred_probe_work_func
[    1.779449]  unwind_backtrace from show_stack+0x10/0x14
[    1.784729]  show_stack from sysfs_warn_dup+0x4c/0x60
[    1.789825]  sysfs_warn_dup from sysfs_add_file_mode_ns+0x104/0x150
[    1.796142]  sysfs_add_file_mode_ns from internal_create_group+0x10c/0x3=
ac
[    1.803100]  internal_create_group from asoc_mcbsp_probe+0x270/0x454
[    1.809539]  asoc_mcbsp_probe from platform_probe+0x58/0xb8
[    1.815155]  platform_probe from really_probe+0x14c/0x34c
[    1.820617]  really_probe from __driver_probe_device+0xcc/0x1c0
[    1.826599]  __driver_probe_device from driver_probe_device+0x30/0xd4
[    1.833129]  driver_probe_device from __device_attach_driver+0x8c/0xf0
[    1.839721]  __device_attach_driver from bus_for_each_drv+0x80/0xcc
[    1.846038]  bus_for_each_drv from __device_attach+0xe4/0x170
[    1.851837]  __device_attach from bus_probe_device+0x84/0x8c
[    1.857543]  bus_probe_device from deferred_probe_work_func+0x9c/0xc8
[    1.864044]  deferred_probe_work_func from process_one_work+0x194/0x3b8
[    1.870727]  process_one_work from worker_thread+0x200/0x4cc
[    1.876434]  worker_thread from kthread+0xb8/0xdc
[    1.881195]  kthread from ret_from_fork+0x14/0x2c
[    1.885955] Exception stack(0xc1069fb0 to 0xc1069ff8)
[    1.891052] 9fa0:                                     00000000 00000000 =
00000000 00000000
[    1.899291] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    1.907501] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.914215] omap-mcbsp 49022000.mcbsp: Unable to create additional contr=
ols
[    1.921264] omap-mcbsp: probe of 49022000.mcbsp failed with error -17
[    1.928405] omap-twl4030 sound: devm_snd_soc_register_card() failed: -51=
7

Signed-off-by: David Owens <dowens@precisionplanting.com>
---
 sound/soc/ti/omap-mcbsp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 4479d74f0a45..b7c1fb70cb25 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -1403,6 +1403,10 @@ static int asoc_mcbsp_probe(struct platform_device *=
pdev)
        mcbsp->dev =3D &pdev->dev;
        platform_set_drvdata(pdev, mcbsp);

+       ret =3D sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
+       if (ret)
+               return ret;
+
        ret =3D omap_mcbsp_init(pdev);
        if (ret)
                return ret;
@@ -1412,13 +1416,9 @@ static int asoc_mcbsp_probe(struct platform_device *=
pdev)
                omap_mcbsp_dai.capture.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
        }

-       ret =3D devm_snd_soc_register_component(&pdev->dev,
+       return devm_snd_soc_register_component(&pdev->dev,
                                              &omap_mcbsp_component,
                                              &omap_mcbsp_dai, 1);
-       if (ret)
-               return ret;
-
-       return sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
 }

 static int asoc_mcbsp_remove(struct platform_device *pdev)
--
2.34.1

This email is intended solely for the use of the individual to whom it is a=
ddressed and may contain confidential and/or privileged material. Any views=
 or opinions presented are solely those of the author and do not necessaril=
y represent those of Precision Planting. If you are not the intended recipi=
ent, be advised that you have received this email in error and that any use=
, dissemination, forwarding, printing, or copying of this email is strictly=
 prohibited. Neither AGCO nor the sender accepts any responsibility for vir=
uses, and it is your responsibility to scan, and virus check the e-mail and=
 its attachment(s) (if any).
