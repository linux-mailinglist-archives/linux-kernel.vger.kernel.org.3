Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F329A54CC3A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiFOPKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFOPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:10:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E03136A;
        Wed, 15 Jun 2022 08:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxr2IrYPSL8xTxwKGEcpAW+VXfePKpwO/XIobbDhEWAWxiBwrWSHCUr1IHB9ETaBw2XExB16rBU5M8vbm0w1CXtrqu6I++0/I4r5saS8NpYPXRW2kTtvkVZWvlZcTZ09lEONDPp7ZwtBu17vHs5mecofGQuPnBfB2+YSdiZjuQo5VrNpwwlWRi8iRKAMYm3kIHmX67Zwxb7tgXhOh8+i/wleZXB/fSy19XVag1SCtg6MrUHy68UsEIjKcnmqjZGhKYEQoy1q9GdJRNEUPYcMqsWc6nJEAA2Ww1yBZVPT6rFdWCVGkMYtDnftCuTWZl85YxqEp8Z133Qw/Q6FZ/T9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb9/To5FprBt50yMAtHhBdm0ff5DnmrhCVTcePy2LLM=;
 b=mtw09XYI/jPUD57TDOFTUJfaoyVRt9cWGI+d8iYtihXDhoi3yymBFb4/TnJRXixlxahfhFohRosnlOCjLeZ3Y8HyE/lKe1hYSX4Tke1vT/y3rpgw1NAwrHXf7xK1RisW2ntzp8iLZ71zYgXFzeOwRqcWAxyj1e0X+XRAuugbkZ6UzsDnRVa4OkeVrPOxRZammGJ/sGIVjJqTCEVpawW54/0BFkL70M4qirwml3atPCZBl9qpZIay1bw3AWSJGNweEx3bMeYCkj0dqha6/aij75sgqfbUr4UuOg+LG3YvhajHrlZpFYvr/0zFFjGqPxBbYtvLHkJGBVIHtn1Zal1G9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=precisionplanting.com; dmarc=pass action=none
 header.from=precisionplanting.com; dkim=pass header.d=precisionplanting.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precisionplanting365.onmicrosoft.com;
 s=selector1-precisionplanting365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb9/To5FprBt50yMAtHhBdm0ff5DnmrhCVTcePy2LLM=;
 b=Pic5XGCvDbXtqrz4RdCkJUYZ+YLQqjKu3kuT5mS3ulaFmJu7WBRL10c0zDFIKdXHoB2d5SRgd7aWZ0VSgk+fwJsrVEI0EEQssOVqHxVSfkbC1eThTo3rHejSWy0iKPVWaDdqVpk1QuTjbzDNLO9fVTegRtiwwbmzqcTuAqvQyPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=precisionplanting.com;
Received: from SA1PR22MB3196.namprd22.prod.outlook.com (2603:10b6:806:22b::8)
 by SA0PR22MB2272.namprd22.prod.outlook.com (2603:10b6:806:81::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 15:10:09 +0000
Received: from SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0]) by SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0%5]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 15:10:09 +0000
From:   David Owens <dowens@precisionplanting.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: ti: omap-mcbsp: duplicate sysfs error
Date:   Wed, 15 Jun 2022 10:09:55 -0500
Message-Id: <20220615150955.4140789-1-dowens@precisionplanting.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:610:50::27) To SA1PR22MB3196.namprd22.prod.outlook.com
 (2603:10b6:806:22b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f1bd85-8e5f-4a05-cded-08da4ee12324
X-MS-TrafficTypeDiagnostic: SA0PR22MB2272:EE_
X-Microsoft-Antispam-PRVS: <SA0PR22MB2272E82ABEB8D2A68131B1C7C0AD9@SA0PR22MB2272.namprd22.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmBhTzbFQY4sfJnfaJUEV7tiEOIX8QvxfkJzE2X7Saoji8Y3PybfMTn+te6X8WMFAa3yMx9SEvd45IhI4wddjaCGgczTUGh3uRfLK7jIipbUbF1LXvkbvCMyY6k28mM/8kwhfCxrKdx0dTLjzWgiaMjvij3UBaOYcE0F/WP7QKgkwFetN7VmCJr0W3qT81/bWUSZDnroBVfk2o0//9GahtN8puX0w48U/7sPKZrAM+TbUdKZ/7WjRmoFJNaLif6b7oUH9rhYBqtdlhSSybAa2PTAQSUbP2Y29G2oOBZVz7b3sh+z+SHdV5dWmIwJTyAW1Z3vgrx8hLT1TU7Nn6qTP1iemX/M3joYif6QDZREGY7h1fwbIDIGNGsfKZXVGxL9pO58EvxvX5OLGU4luKkBMN9oNA5QUilWDxMm+Ilv//RrxhxIepwt6suWWiSlBNU+1HALaTbbIiw4YRkdcgu44dKjTyxK5eYrkmkxtW+7SvfHYsEFrYIvNvwxqP3gchqxRYhob7Q+iuRMrJ7z3xVkp0vTWSFhGIAkSWsBLDfY2z0HW01FGmHvCKiF1f8hW4NqaPmyOZEvZUcPxHpoJnC/xXWUoqs7zni637esTn7gh836aFx79RrtF07oFpc2YjZUV9FttY3u10NCj2fNNl+rJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3196.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(39850400004)(66574015)(38100700002)(1076003)(186003)(86362001)(2616005)(41300700001)(66556008)(66946007)(66476007)(4326008)(36756003)(316002)(110136005)(8676002)(8936002)(6666004)(508600001)(6486002)(52116002)(6512007)(5660300002)(83380400001)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3SyuF8hYys3+byyz5Cx2CiaFDDfL+efum7ORRGESXB3bOZK6krNRqJOoxTMw?=
 =?us-ascii?Q?cFjvsxfsCT0au9elLJDKeTtmfOc2nf43DTUxf91DrbCgrOWhLic/gQ49qHIJ?=
 =?us-ascii?Q?nid+5eQ2d12FM1XPDQlZa0UjlsMa9mthlg9Y1fwLDWxwpHsaA/Q67JZOW75d?=
 =?us-ascii?Q?fZMeVEwTdWLVagNYceFWT2P1wtATlSv8pNg/HW3bro1Gw2aPTS0g61mgBhQR?=
 =?us-ascii?Q?ZsXCpN40rE+hNJeNjapLd+FrB34ACbuiktepvuWud7LOWd2KVd7S4MoyTQOT?=
 =?us-ascii?Q?cZIOttzcUT3X9hrRyjRs6SGfzCwoyC/bYpixd/m05PeFt+vPZELFxN2HStcc?=
 =?us-ascii?Q?bBqrkjBjA9XOtznD3+u9WtaxAbeDVUqIN2zXp2IbXmpLKlIOZTx7bOqwQyqO?=
 =?us-ascii?Q?nFlCxzPNsYn+spMAmqCFxyy/Om7rL7bKy6I1mi+5spzK5peoujgbmfWd2MlN?=
 =?us-ascii?Q?HyMu/bTI9yl3e6Ir4nCWifH0Tg6fctrwtSZ3CkhauIZ1HTJBHzSdGl4qP3eg?=
 =?us-ascii?Q?fKnmMloldx1sh/BNLLpbzkmUrdgpJS2ETdWu70CboER1FxUWdm1f/01twC+d?=
 =?us-ascii?Q?3FGXKhfpx75S9YkRvcjYJT7HYlB1A6LDOu9kAIlTrjv7agSldp1+cib8wzOu?=
 =?us-ascii?Q?Vv63rx9TYXYZTv/QVVzxj1vNm8ZZX/KTgKR+wFC1WXAADakeg7Ih7ZxYT2aE?=
 =?us-ascii?Q?jbl8io48Szj1ytGyRCG+GgKVzoSF5pT3yrL3nNYcqxnRtd17S1MhoLCfuGcm?=
 =?us-ascii?Q?K5xruYXXrzoaKPbbVA5/S5pn6fWdfQUURtEvjFVoa7g/yMIITUwV96Jf0KTc?=
 =?us-ascii?Q?LAuDfnOobcn4WIVb2FmgHtp1kJxX2HP/JAJPP84J38mw+IdEo6PUPFO4sOZ3?=
 =?us-ascii?Q?p7pN4jEsS2HU15jfELAF/p1G7VdwdRd0Y0P+tsQ4Uf0cKId1FjxHCchPBWv1?=
 =?us-ascii?Q?3z5Yw9wdX5qb9FSGE5SKtY4fZSwk0I5PdEqSjjn4zpwCbxrS5x1u+cFz2qNW?=
 =?us-ascii?Q?r1oUlqSKmQcLqiLMH4S5F/bPAVtHhD9b78yTPcuhLwgLGDEJOxtvsQPmyfvZ?=
 =?us-ascii?Q?w8FY+xtfWKbTbmY3AAxsWWodS3qXnq7+mhQJy568rBV9EDfqZNKdWD3rI6Vu?=
 =?us-ascii?Q?TY6k24hnZuqrJOtOFgzsblNmNBhKmQG1lQVA3GBNc25m3wMbMeDIo1adkkV4?=
 =?us-ascii?Q?igFfR1HAHhkUKjknHh+UXnRzz+SBaC8fZtQYsK8fdc53F6J9XbxgBrEpiK76?=
 =?us-ascii?Q?jee8KEVFi3by7nL6NypztZSYcYyU5w+7EVlMvh1LLZdoUAzuVtNjCxWrul7l?=
 =?us-ascii?Q?6r+ZSapjcB8PiCVNFY8mDMdDhGP2hC82Y5G5U1Xyl6sz2su1lZ9FT6A2hr/R?=
 =?us-ascii?Q?cVAbfFsOwuYbs+JEmWG6yMNdHHo8VQdEdojnghK9FMQ27S8185n3Mm8RETbv?=
 =?us-ascii?Q?iXBvUIZOTdK6XHJwHG/QPezxHKKQ8dfJXeHU0ga1kn+CUgL0hDwgjpnJEyTK?=
 =?us-ascii?Q?hUmHGfcSwalXFqhhf5Oap2a6KoNdXBG9Lh+sz1hQ2bYgp/Ky7ZvXHw0HtdkA?=
 =?us-ascii?Q?FIfUXpa9dzhDS7uS4vpwWUKCE92dt8TF+cVv9uBO8SD7r5h4oJekWpxTqwX0?=
 =?us-ascii?Q?/FjlJTCrqojkSszcBpeAAxE3yT+p+Oc5N5eMO5zLtnLEV2rKmnsP/8wsjfdu?=
 =?us-ascii?Q?UO8/76jf6O7At+e1hS3BGQgqNg0uXWUeExh5uBvOX+qAlQuO0pGmt6WXFlc/?=
 =?us-ascii?Q?lK2pB+l4A+nFO/J0JA+GeVR9isXa0I0QV5A1Vz81kKNx8P/astulfHGQS0Kh?=
X-MS-Exchange-AntiSpam-MessageData-1: +RYWQAs9P0AQ4Z6rcA3L8s1jRR3YpE2qNMJqqRGcXMkvC4eijbgIpziu
X-OriginatorOrg: precisionplanting.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f1bd85-8e5f-4a05-cded-08da4ee12324
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3196.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 15:10:09.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa593af2-61f8-4d4f-988a-e9c4c02b7f57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VM8QXTR3RfDRihYPmm0JrXqmpiQnfqGP5Hp53ExJfh1LLx7KXnCSvOZc4Gn/efIAwABTSczairyG4PxC35S1OXzqAz31FtEqyKNcNVbBgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR22MB2272
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to managed versions of sysfs and clk allocation to simplify
unbinding and error handling in probe.  Managed sysfs node
creation specifically addresses the following error seen the second time
probe is attempted after sdma_pcm_platform_register() previously requsted
probe deferral:

sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/490=
22000.mcbsp/max_tx_thres'

Signed-off-by: David Owens <dowens@precisionplanting.com>
---
 sound/soc/ti/omap-mcbsp-priv.h |  2 --
 sound/soc/ti/omap-mcbsp-st.c   | 21 ++++-----------------
 sound/soc/ti/omap-mcbsp.c      | 26 ++++----------------------
 3 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.=
h
index 7865cda4bf0a..da519ea1f303 100644
--- a/sound/soc/ti/omap-mcbsp-priv.h
+++ b/sound/soc/ti/omap-mcbsp-priv.h
@@ -316,8 +316,6 @@ static inline int omap_mcbsp_read(struct omap_mcbsp *mc=
bsp, u16 reg,

 /* Sidetone specific API */
 int omap_mcbsp_st_init(struct platform_device *pdev);
-void omap_mcbsp_st_cleanup(struct platform_device *pdev);
-
 int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp);
 int omap_mcbsp_st_stop(struct omap_mcbsp *mcbsp);

diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
index 0bc7d26c660a..402a57a502e6 100644
--- a/sound/soc/ti/omap-mcbsp-st.c
+++ b/sound/soc/ti/omap-mcbsp-st.c
@@ -292,14 +292,11 @@ static ssize_t st_taps_store(struct device *dev,

 static DEVICE_ATTR_RW(st_taps);

-static const struct attribute *sidetone_attrs[] =3D {
+static struct attribute *sidetone_attrs[] =3D {
        &dev_attr_st_taps.attr,
        NULL,
 };
-
-static const struct attribute_group sidetone_attr_group =3D {
-       .attrs =3D (struct attribute **)sidetone_attrs,
-};
+ATTRIBUTE_GROUPS(sidetone);

 int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
 {
@@ -347,7 +344,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
        if (!st_data)
                return -ENOMEM;

-       st_data->mcbsp_iclk =3D clk_get(mcbsp->dev, "ick");
+       st_data->mcbsp_iclk =3D devm_clk_get(mcbsp->dev, "ick");
        if (IS_ERR(st_data->mcbsp_iclk)) {
                dev_warn(mcbsp->dev,
                         "Failed to get ick, sidetone might be broken\n");
@@ -359,7 +356,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
        if (!st_data->io_base_st)
                return -ENOMEM;

-       ret =3D sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group)=
;
+       ret =3D devm_device_add_group(mcbsp->dev, &sidetone_group);
        if (ret)
                return ret;

@@ -368,16 +365,6 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
        return 0;
 }

-void omap_mcbsp_st_cleanup(struct platform_device *pdev)
-{
-       struct omap_mcbsp *mcbsp =3D platform_get_drvdata(pdev);
-
-       if (mcbsp->st_data) {
-               sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group)=
;
-               clk_put(mcbsp->st_data->mcbsp_iclk);
-       }
-}
-
 static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
                                    struct snd_ctl_elem_info *uinfo)
 {
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 4479d74f0a45..395493a2d965 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -595,16 +595,13 @@ static ssize_t dma_op_mode_store(struct device *dev,

 static DEVICE_ATTR_RW(dma_op_mode);

-static const struct attribute *additional_attrs[] =3D {
+static struct attribute *additional_attrs[] =3D {
        &dev_attr_max_tx_thres.attr,
        &dev_attr_max_rx_thres.attr,
        &dev_attr_dma_op_mode.attr,
        NULL,
 };
-
-static const struct attribute_group additional_attr_group =3D {
-       .attrs =3D (struct attribute **)additional_attrs,
-};
+ATTRIBUTE_GROUPS(additional);

 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
@@ -702,8 +699,7 @@ static int omap_mcbsp_init(struct platform_device *pdev=
)
                mcbsp->max_tx_thres =3D max_thres(mcbsp) - 0x10;
                mcbsp->max_rx_thres =3D max_thres(mcbsp) - 0x10;

-               ret =3D sysfs_create_group(&mcbsp->dev->kobj,
-                                        &additional_attr_group);
+               ret =3D devm_device_add_group(mcbsp->dev, &additional_group=
);
                if (ret) {
                        dev_err(mcbsp->dev,
                                "Unable to create additional controls\n");
@@ -711,16 +707,7 @@ static int omap_mcbsp_init(struct platform_device *pde=
v)
                }
        }

-       ret =3D omap_mcbsp_st_init(pdev);
-       if (ret)
-               goto err_st;
-
-       return 0;
-
-err_st:
-       if (mcbsp->pdata->buffer_size)
-               sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_grou=
p);
-       return ret;
+       return omap_mcbsp_st_init(pdev);
 }

 /*
@@ -1431,11 +1418,6 @@ static int asoc_mcbsp_remove(struct platform_device =
*pdev)
        if (cpu_latency_qos_request_active(&mcbsp->pm_qos_req))
                cpu_latency_qos_remove_request(&mcbsp->pm_qos_req);

-       if (mcbsp->pdata->buffer_size)
-               sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_grou=
p);
-
-       omap_mcbsp_st_cleanup(pdev);
-
        return 0;
 }

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
