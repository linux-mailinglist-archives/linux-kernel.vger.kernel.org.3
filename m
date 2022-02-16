Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA04B8ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiBPN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:56:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiBPN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:56:36 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C79222F26;
        Wed, 16 Feb 2022 05:56:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQaJVpQTwpb5xE5C7w87oZoQVbJqPwwngjWbFoVrXjTauH0gLMI4N5CL3aoho4XwzJ/G0/vhBHxrd195axSzsH1AbfEwe7Pn445my182fSQUciVWC0VS6Mf/UYyI6taT0tWfxy8A7+96P+IBY932J0mmTWtjFFC/kFGmwPemCylRtaLMtFS5VUer3FsHusq9SR/J2h+7Ww2B5DWubH6lg7ju6CzAjKsH2gL7ovKGK/KfiF4+TDmdotZHS0c+FREZ68jYyp++aVi+ImZn6un9NXviyDk7idn6h74Ta+le2MHrUgV3Uy9TjxSTp8w17JlEJ5MCvUimG1xVWfLSqMAjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/hgr9lLJfDDd/uiJyheXN8aKPgguiAOAdFWECH4rms=;
 b=Mh/NevgYm/GWgDe1CgMlio9sSbCoPAB/a3J+hY9JD/Mca3sHNp+EgNsb138fpmxSFkeTEWEv1y0zRxWdH4KhJ+APnoxTVDY2M1ozZVvo0KBxmzY6Lv6FADA0TOcrSI1we1YkbuD8TBx6f4xl9Uny2sBoQI1q9VIJMO1BdHCq57r1QQ3yuZepZH0NMoeVoAgL/9uVILhOsKJlAmcbbg+xqFzxt26yUzGnpIyOtXgulhfrks3ysk9jzzqzaGsxJVST/bzdAHzPOmVZ9QR6Y3tox/Bt4ACh+fIEK2tXY6fysUUhHO+gzJtPXXKOCsyVZPklpdQhSg+AuBA04I9gmHsj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/hgr9lLJfDDd/uiJyheXN8aKPgguiAOAdFWECH4rms=;
 b=Dlnd4olLLl+s+HuQGhVywkdAxmgRQyTOJVLk8XQo5PQYpsoKqsvM+vN/eKppbxMM0a9eyXlYcjI0iVFgCzUljPuK8Fa7qmLV8s65zZD76ZUjM6aQmu28hdlick/nV3bIa75siw3/GhAd/32CPBR7NGJ6dqJspI9eVE20SqI7jKGdNAj8rBEwlWsfMHT6fgzebN5hoy8cyvg9BBo4GqC3rCQzQE9lp+66fbQXJOQQSC/KrHU0kwxlkJSS/CrWrEyuLF77HuFjINAXMy5rfgd0PKPQI9zQqhhq2GYjBENU/96IFaOlILeioU2H6jC/A/Kgw+WQEPA6l7ASWWveSjN7iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS1PR06MB8465.eurprd06.prod.outlook.com (2603:10a6:20b:4c6::13)
 by AM6PR0602MB3430.eurprd06.prod.outlook.com (2603:10a6:209:4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 13:56:19 +0000
Received: from AS1PR06MB8465.eurprd06.prod.outlook.com
 ([fe80::d080:8a90:d939:9a54]) by AS1PR06MB8465.eurprd06.prod.outlook.com
 ([fe80::d080:8a90:d939:9a54%7]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 13:56:19 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iio: core: provide a default value `label` property
Date:   Wed, 16 Feb 2022 15:56:04 +0200
Message-Id: <20220216135604.3435769-1-nandor.han@vaisala.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::9)
 To AS1PR06MB8465.eurprd06.prod.outlook.com (2603:10a6:20b:4c6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce792e19-892c-4115-e5fe-08d9f1541b83
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3430:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0602MB3430834B28A7B87E0125ABAB85359@AM6PR0602MB3430.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RY4ZkHBQ1V0iKNPf0ZDhU+P6UHR7PTlAU+DfH9Js7fZ86bFq34SbIGnmBaqhEEU6nL8vH7wItzXgQ0Y3bXcJHtGhkCyZKuLLyO5d2XzYrLOKZncAQuOSPa+69qG5ADBtAv2dRgme+BHnN4CNN/aagb167WZJKtZ5v9XQXsDSRYUBSRzOveQ7yNB9tJGXnqBBdt3ngtsAhTicK904tirVJ7dUxYFtunLu7sSxnXB0vlbM2tL24q8n0xykaiqNUghNZaVdavykioQN7ieDdzXy5IzQif0npWloEl/AkueSbiLtaKNXDCBfcMYIQDRz9kajOF2nZJhSRaYs7sa+df8yGOxdwo26UrAd0WxTLee6sjcVkT8jkC9R9WFMF8U0XChLinE4Ul5vNfle7Wq7lIa3vc5XOelKUZx/yniKZPbxB1ImBUzH4kCo56c7mpasEioWExxkDyxVOT3u4zSVAdnz1a40IBpYx/suFgiOnUkbEuJDQ/AiH51sL33F2XIg6qh3qDq2f1RpquDUey4SvrMjjBWFMP6zO3rSRRZZXzkOUZvWkdbwTDFKcWwVzF4xAYJojJxdfTv8BI4d3+J9CLOJqAEYUsoFJ7qCwqwuyqCtyDo7ClCogYPE1/qsSUWeFtE9Cfvp5KsiwCt/D3P+OWF0f6InAMypx94aK+pyt9R+WknexLHRcOHZOpZglZp7eZRF5DjU4Jq5yfbJ1VC+Qy4SK0l5EztTMwXl866cU3bjAtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR06MB8465.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(44832011)(498600001)(36756003)(38350700002)(6666004)(6506007)(5660300002)(38100700002)(83380400001)(6486002)(52116002)(6512007)(186003)(2616005)(1076003)(26005)(2906002)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oUA/gzihq31CwKp6WmObdRGk3qYO8RJR5euupvJ6zVntaTBCbJDfu8/0hrxh?=
 =?us-ascii?Q?K45Ek4jAdNCKeLeodopokdYYWnnPITBdbwwRaVj93I9X20rGDlRaDlBxOYaL?=
 =?us-ascii?Q?bxUKf6HGCmsGj50W+FusEqHL1osWfHADqcf1JRuw8Mn5iIyeJGxEVfY79N8i?=
 =?us-ascii?Q?vigKPDxfwILProbkw8NIo5Dl5RnZNUAg984XC9b5DPxTeNuu418wZj7/YjC3?=
 =?us-ascii?Q?cLiIMeM0tftsz2FClzv5u4I8N6KT6ppmzQSeGxiAvKBLEqeLWpzgiBUodftQ?=
 =?us-ascii?Q?3O2hJ8WfMjeb3ObBK7HWLr+CrwzmCxKBvAWZ/zH2ZyfS7cRrq0rZ2Xlvorgn?=
 =?us-ascii?Q?CD4HuZ8GIKBE/pDEbja1DjHPUCJws+WZHaSmvYjxVRTgrr7AQM5XXo/dlezH?=
 =?us-ascii?Q?JBXJ+gRborkueTQKvwu2caJzg0DI1Ph1yrHnxRF3a83N7lzMQZew3RqKfKzf?=
 =?us-ascii?Q?WE2/BTFX1LADbC5399SRdzly1Y49qqi9KcgN0aj6zaqk5zhQQi6m5+wI+lin?=
 =?us-ascii?Q?4VC8cwKEqWT3mWYyw+CruJ97/Y2REgOh2tP9ZrXVosqBFk0GQTbTieRYb7i+?=
 =?us-ascii?Q?1k7PZExob+e5Xm1VoWyxAe7TDqetATUnZBLPKVL6wpys/Ig1N3XGivzAVYZU?=
 =?us-ascii?Q?gY+1f33jbThV3DS8/HsqRhbQSf29L0l2zr36HWdhASZ/kkTNleW4lWwE9CVI?=
 =?us-ascii?Q?31+bGKJM11je6ZYcBDs7FndlXB6W4A62pmwOfqSUoX/ez9t9n/nA8e+w2gth?=
 =?us-ascii?Q?pv6UbsvwAWPe90dDvD+fhr3E7uUdMJmib2hevpMuSAVQNqp9e4+TDRRQPNNr?=
 =?us-ascii?Q?eq6mHxwzCguSEOL7vjwyWQh1USeX8fA+7EkPcpvDjejFEO+KwayZhPIJMM0u?=
 =?us-ascii?Q?+PMvwZL5qGNTNTZb7kfHfz4rYXKiaN0nt2VPY7YItRcRRjX0eJGAS2CdPqME?=
 =?us-ascii?Q?YFGSRs/ERz+ZIU1/3pAd79xBCLCGTphhk/P+sY88RrQ2HweiUX17RBEgh0nO?=
 =?us-ascii?Q?inHXQ3x1MBQFtQ6eymR5izFan7Hhp+YRdKucj2ZUr3EXzeK007Wij6rXvRtD?=
 =?us-ascii?Q?/gYJNfWTdqoioTJQdGE/jYI2yhngNWoRtchHcNT/NtLydkYkUnumYV4+adpg?=
 =?us-ascii?Q?PGIoEBWxoxwu/icuP/8Q8UWpJNDpz85YGAeNUok8bbYJsvE1tZEVHWoTWGLf?=
 =?us-ascii?Q?/MtuMFTAin5mtSLcl2ncuJTG+4oT4Mh5UNmCAOi/zoOICbDjRS2JzS3KLppA?=
 =?us-ascii?Q?M7wnHLgE6YuXsJT4AvAo3P0tqCGhkdNszTvI8xvV+rB+KTzxmDrvaH7TnJCC?=
 =?us-ascii?Q?xW5P11men2gzYCTjczY7XQ0epB5bvAhV6N4K+vl7Q1r2RWkXhVmnCq05soyz?=
 =?us-ascii?Q?0CiXrzJPiAy8i6Ar0paiRALNpcKTV7ziW1HUU6yMdJOUnxBsYjDTZzbK/goq?=
 =?us-ascii?Q?RFCcPfyebx4O6Z51um6QBu1Yw0zAe0gJRjs9bdeVNdh4B8OqMsuUn+M5AKxx?=
 =?us-ascii?Q?LkrYPaVpVfean4PCiME6CErgy+8OrQt/3GgijxsP6TWPv8gxRU50MkVnFX0q?=
 =?us-ascii?Q?QQIiHXcklDGxINPGhG21KRssBG7AKrTl3k45/iJA7nebSayv32uWQYrxUwer?=
 =?us-ascii?Q?V0IKBBf99NY4dLEuS5tCJKc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce792e19-892c-4115-e5fe-08d9f1541b83
X-MS-Exchange-CrossTenant-AuthSource: AS1PR06MB8465.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:56:19.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8RT9oKSLeva1P/kenJuwNnyN4bqAiEgp756Hm+FB5sK9KxynZXPC95/nrSykQuQez0/vktsm/7WqwjNtOT5xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The label property is used to correctly identify the same IIO device
over reboots. The implementation requires that a value will be provided
through device-tree. This sometime could requires many changes to
device-trees when multiple devices want to use the label property.
In order to prevent this, we could use the device-tree node
name as default value. The device-tree node name is unique and
also reflects the device which makes it a good choice as default value.
This change is backward compatible since doesn't affect the users that
do configure a label using the device-tree or the ones that are not
using the labels at all.

Use the device-tree node name as a default value for `label` property,
in case there isn't one configured through device-tree.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---

Notes:
    Testing
    -------
    Using mx6sxsabresd dev board with device-tree:
    ```
    &adc1 {
        vref-supply = <&reg_vref_3v3>;
        label = "adc1";
        status = "okay";
    };
    
    &adc2 {
        vref-supply = <&reg_vref_3v3>;
        status = "okay";
    };
    ```
    1. Verify that label property is visible and readable:PASS
    > iio:device0 # ls -la label
    -r--r--r--    1 root     root          4096 Jan  1 00:00 label
    > iio:device0 # cat label
    adc1
    ```
    2. Verify that default label property is used for adc2 device: PASS
    ```
    > iio:device1 # cat label
    adc@2284000
    ```

 drivers/iio/industrialio-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..bd26df90ce41 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1895,6 +1895,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	const char *label;
+	const char *node_name;
 	int ret;
 
 	if (!indio_dev->info)
@@ -1906,8 +1907,13 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
 
 	label = of_get_property(indio_dev->dev.of_node, "label", NULL);
-	if (label)
+	if (label) {
 		indio_dev->label = label;
+	} else {
+		node_name = of_node_full_name(indio_dev->dev.of_node);
+		if (node_name)
+			indio_dev->label = node_name;
+	}
 
 	ret = iio_check_unique_scan_index(indio_dev);
 	if (ret < 0)
-- 
2.34.1

