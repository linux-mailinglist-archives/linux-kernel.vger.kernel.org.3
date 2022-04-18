Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AED504B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiDRDSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDRDSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:18:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2096.outbound.protection.outlook.com [40.92.21.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76715FFE;
        Sun, 17 Apr 2022 20:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3f29JWodCWalouwmNxJu1zqp1IUTzjNYs2Ke245jEkQaymmxF/kZ2RPN0PJlweBHIcr8VYJo2u48CxMPSoNOeqcOg7ePo7nWKbfnfaIyc8DZ/FcZmEAoymiqEBRC5IJ6KodGoeiAcDnMBlG4nTrjESdGCGNNj3XalTQSvmz8Sry6f3JejvuoiILKpyBxiDJB5zpER9xtLvGXM0v8dFgJP020nUEAT29a/yHRsHw/oqmES92h/XZKFoIKRV1krU0OZ0/t0kl4d8uUyVjv4hpvGhdsFv3QC76AeCmxPs0f2NAONihKbJBxfGJAIiDb6jxVqvOuehSw8um3+PAGnHlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9eDzz+nAE5vKfek9Ytvme5zlHH87KNQADpKAt20WDs=;
 b=hW6P2bkuRIPbOvaE9DMNRSa5/r+yxX0mYD04MjA2hmU5uffeHJLTiaxetpwshY3iixp2v2ui1oFauz4/DfWn8I75ng4KbKqwyVzS3vliwFSM4Ifzf2F8qmh7SWmdM+7yXwlujVTbvXDWNvY/YvbQ5yAMmfEVxi1WzbLeVJGf2WP2tCoNCPQPmaycTBbTngxakA228z9S+peoaHiR5LLHpHE4TjJfAJbBIyRT+Q5cQ1bSJt2T1BFSt6a8OiPOfgA9hxfH8UdLeeZZ5LR0DMLEu9nMIaIq+eAXcxN5cImLyOeUBXn1RevspQng6rRj5WMcLMbGvHdVIi0I6H/V2iuJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9eDzz+nAE5vKfek9Ytvme5zlHH87KNQADpKAt20WDs=;
 b=oPoG4oRz8MrvsnccUVswgXwZB1tUluKz8Lg/fKddimSmIQlWaLYs3XD9tf0B5xMhiBoAMnrYEo4xHKYCjkA/HJxxtSDbWGUtvqlpemImeHzgYKwYtd89HfrCmpQGaBeJu3RAyzdy9t/1Eo1c7J1k5U7ixRs1ynI73i4JdByxZNWmEsbQ9X9vlLYXvdHnAS5mkoQWVRrUUx9EDynPtRr+5TRF93Sx70xrDAPXNEvvaFQvMKeEadh3WEAsEHqO/9qB642bBf1I+1ldAvDACRpaeGzPRhhwiNel2CLsIxbsiHkvMdrEAFMlArGQi1cwGRoMW92SwS2yhaOFrXdSQJ01XA==
Received: from CO6PR03MB6241.namprd03.prod.outlook.com (2603:10b6:303:13b::6)
 by BN6PR03MB2803.namprd03.prod.outlook.com (2603:10b6:404:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 03:16:02 +0000
Received: from CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992]) by CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 03:16:02 +0000
From:   Tao Jin <tao-j@outlook.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Tao Jin <tao-j@outlook.com>
Subject: [PATCH] hid: multitouch: new device class fix Lenovo X12 trackpad sticky
Date:   Sun, 17 Apr 2022 23:15:17 -0400
Message-ID: <CO6PR03MB62418A2C022A8E9EDC11A633E1F39@CO6PR03MB6241.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [H/3vC9L8WMoOOKpYjFJXldefwZ6YPmoD]
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To CO6PR03MB6241.namprd03.prod.outlook.com
 (2603:10b6:303:13b::6)
X-Microsoft-Original-Message-ID: <20220418031517.36284-1-tao-j@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3add4633-40b5-4bac-01ef-08da20e9c42a
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiTzvpWxvWYRCitoSl4QfY+Hf+Y7wmJl7S2mMuq2nVgi6IpSKfwbop4T32j5zK+IN4s+JwEiJJE3zBydU6EW/W6fzhK81+A5cei5NsQtUnXy1vFo6uxsonEkZqyoEvzMvR/b6OEd/wWiFkT1PJoIB90JTkhk0nFXDlIIoyDUjds+ehELEKS0dl/KvwdFkRo2+NzRDwH8GhXS8bkx1XlQGESazXzWHDo09HOZ/i4I58G51FRrnkzNjUv7SnlpXbA4uTMfMU0y7qFGzBylBFMkUpoupEBK7Zebp0GcdRf0dNStLXLpLJhRj/ZcI09lSYeWJxQcgkYdvMu1f26N+Fs5fQaCq9eSXP2VaX4Mf80/A4UtA6Q0nvIwgmNw/ITdUD7M7mTfb5LgBB2DFFvWXnSAB6r/cEBQ4HXzaQFardJwYOS5CT+49GW5sl+vGNuPXJ2jnqGfcwzRD7tb1K+vhrSr2n/bhbeR8ZJgJpN166IJodX1WHct76aTPfWiEZzcB7MRbLAWXrhSItVrqPtvwsDRj4HnNs7lyo3aaC+DEcsuFNyvqkK+ZnOTUvr9MbYYtW+WJZ4qccPgZTLMSFCYyevTkDlOgk2RSpQntF1wMND8n7+HnaXldYhIufFZ8hGV/ewy0rECEC326oniyonkTdgPhXEwB4wl3qPFddqI5aikr2yzARJxhNeDZqemBwhkzL61v4xDG5+ELNRJz32qOoG42vRT+4R6z9guzM7PumUuVc8fIkEypjLVvh5vNlA70Oz8IU4=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2803:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T58I8F/hLPBoWOLp0dE3bXWOseDxHgaBmYgZQvYV9vA9kAJwcsv8r/DLqcUsreRZU9LiF/HU7XQPCRgO4q0l4PTOnm9X6dBte9RqnQbh4p24iw7I8R/D0TQzqINeF7GOEaYfEkzoPb2vvF64mqFpWMngWetpO7mJZnbR4Q+aosW5/Vqk23E73UcT02pIAb78nO8s2uh7ZHz85CyPNIPjJpBdsobr2mRstGonrBpwRvE0EfISeU98X80t5LkafvdZXrjuUab50erYY5D+XGldAbjfyce3ZiJncU9s0zL9kjuF238p1mNgR3KrmXWnezn9qS7lZwOQ8fsayxFOYIloLYuGt9Q4BQpNJT51azOWUn+oubeiGlU4pN2g8uT3tp+0G7TKGN+yH1A9yN2JxafQ32iuMkG7bmGIO+anTOHBSexc29hWua3+hOXM0vvWp51sY6tnQFF1BkxkiVf0tK1NqeP4Ms2/Vl6taequz7uquJkGyI7REveIj8A9UaJHLL1pTHppz8s5Ba7whijNAw/DT9gwKSjspVFGIf0zgL5+Q/2evKT+8nR0Q0wjxo+bWMDP5qCDZYMygsioFLMAjngnQQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0teKiGq2pQx9msa7snO1XOf94zaaWK7V6BWTxvcVfkSKi3E1cQGg8hcSc+Z?=
 =?us-ascii?Q?FXUJOtlJv3eJtBWroG11QQgJDmqhAY2hfEJlA3hCZWyh54oNi1wVgIwVNVos?=
 =?us-ascii?Q?cucZPDxZvVpoku2p+k1Sfsids9coyJsv4mUWgoW4xqCOc5akkqB/NGSAo5De?=
 =?us-ascii?Q?36jvh8t+Y+XRdTM/86a0ZmKjCnoHLKA3wAdH9r5a+66vI/WEpzyDYtg0yYvr?=
 =?us-ascii?Q?ZEINP+mIpoVK0FHWm2R6l1v6OhU+XZb74jnQevQfuRuSQaQeefL6AVaVTlTf?=
 =?us-ascii?Q?tHNHryJGntW7QPdhsvoG/Jt+2WDJFx9Q4m8RxBrBtPH4FeDw2cnnXbySYQKC?=
 =?us-ascii?Q?NH4n7gHH9fHYHXsJzQLrGZqp8JGwb8Olx5aEiMiNB4ZsdLtSLzb6+rQnyiGy?=
 =?us-ascii?Q?dVmU6SKuhO2SQfGRV8sahdJ2rVcX9Ekh4ZuSOh3/1vl899xLxYtBsz+faLpW?=
 =?us-ascii?Q?f8robkTXvQkcm46zdpKLxveVFNctfqJRYhWunXleLFb/ynHouH31Pk1wrc4C?=
 =?us-ascii?Q?N2MJejPol5n3tsMbAMIZ4OcSbjmg+BhS+DkuF6VxwsF2SDvkOtnoJdi8+gzX?=
 =?us-ascii?Q?vevR1hUlopU4HRzBZLHrJnsQK1Dw088zveV5+8/ThN862oVtX8cNBkOCYqR9?=
 =?us-ascii?Q?XSBE37Trn/IBbmW8/UQailx7DX6ZlFBxlNRgaMo6vBPLoSsjK6KB7AFvnVc0?=
 =?us-ascii?Q?FR8fCqmRUa690MqPPGda34B/uXFV5EpTvX8Ux0NF+WVBg8shQcLUjFEAxByP?=
 =?us-ascii?Q?n6ZkqH336yRvpIk+xuAAwRAh1lXss+xXUfNvnb+yEWaBRvC+eqLEqZhj48fB?=
 =?us-ascii?Q?x63XoRll5G+HyVNyV/+7CzpL5d0nPkEfmrx3HWp4rzu+s22sbjoDXF0ujbu9?=
 =?us-ascii?Q?vBeQsGBr1T7bXfu44rq01H/F1x1hWQiHnQZDUw40nHhBQ7IU6z59f2YS7xX/?=
 =?us-ascii?Q?ZFs65yedv+OQd1sBLQsHUx7c6tqxllNlS0xCtnCNldShYTHINu3BDZ68FyHY?=
 =?us-ascii?Q?5NHkuIqBw/cKbLtsGZWue82hWZ389/xDHrFPq7Ku3XuITNmqwvx4HW4+DPng?=
 =?us-ascii?Q?q2hfO7pK9gYcg0nzaEYRBA2+PUdLXdW+j2OWK0r4Zzj0iDcBqLtQeDYF02A8?=
 =?us-ascii?Q?s3Ztcw+Ym1cIc/RfxAwWcREcl18z7vyqvkuxoZWm1K0deoxZK/A6jEeoov3d?=
 =?us-ascii?Q?JAgeHLhK0YuwdEP/Eymj/CNLp6X/2dDcMHFi+ixzYnVc27HJPhzuyBStP/3Q?=
 =?us-ascii?Q?EwyFryaY7a7RcPc9hCfAtmX/UwKbPu5apG9jO0Ce2rLAPLZIrUGViMoFonGd?=
 =?us-ascii?Q?2iuNtaNDVTAXk03Gyiwr772sR81DBbl6hFhCZaHqW/koMll/w+JdyfP/LrIc?=
 =?us-ascii?Q?rHaVanIMykUjWcVZEFGiO5eJbZDeXbPOPwKKTiK1GJ1Daadl6egD+ANppB1J?=
 =?us-ascii?Q?uB2svzZExPI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add4633-40b5-4bac-01ef-08da20e9c42a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR03MB6241.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 03:16:02.3321
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

The trackpad of the given device sends continuous report of pointers
status as per wxn8 spec. However, the spec did not clarify when the
fingers are lifted so fast that between the interval of two report
frames fingers on pad reduced from >=2 to 0. The second last report
contains >=2 fingers with tip state 1 and the last report contains only
1 finger with tip state 0. Although this can happen unfrequently, a
  quick fix will be improve the consistency to 100%. A quick fix is to
disable MT_QUIRK_ALWAYS_VALID and enable MT_QUIRK_NOT_SEEN_MEANS_UP.
Since it always send reports when fingers on pad
MT_QUIRK_STICKY_FINGERS is also not needed.

In addition to this, I2C device 04CA:00B1 may also need similar class
but with MT_QUIRK_FORCE_MULTI_INPUT disabled (but it does not harm to
 enable it on non-multi-input device either). The respective owner has
been notified and a patch may coming soon after test.

Signed-off-by: Tao Jin <tao-j@outlook.com>
---
 drivers/hid/hid-multitouch.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0dece60..3ea57f3 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -194,6 +194,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_WIN_8_FORCE_MULTI_INPUT		0x0015
 #define MT_CLS_WIN_8_DISABLE_WAKEUP		0x0016
 #define MT_CLS_WIN_8_NO_STICKY_FINGERS		0x0017
+#define MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU	0x0018
 
 /* vendor specific classes */
 #define MT_CLS_3M				0x0101
@@ -286,6 +287,14 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_WIN8_PTP_BUTTONS |
 			MT_QUIRK_FORCE_MULTI_INPUT,
 		.export_all_inputs = true },
+	{ .name = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+		.quirks = MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_HOVERING |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_WIN8_PTP_BUTTONS |
+			MT_QUIRK_FORCE_MULTI_INPUT |
+			MT_QUIRK_NOT_SEEN_MEANS_UP,
+		.export_all_inputs = true },
 	{ .name = MT_CLS_WIN_8_DISABLE_WAKEUP,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
@@ -783,6 +792,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONFIDENCE:
 			if ((cls->name == MT_CLS_WIN_8 ||
 			     cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
+			     cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU ||
 			     cls->name == MT_CLS_WIN_8_DISABLE_WAKEUP) &&
 				(field->application == HID_DG_TOUCHPAD ||
 				 field->application == HID_DG_TOUCHSCREEN))
@@ -2035,7 +2045,7 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_DEVICE_ID_LENOVO_X1_TAB3) },
 
 	/* Lenovo X12 TAB Gen 1 */
-	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X12_TAB) },
-- 
2.35.1

