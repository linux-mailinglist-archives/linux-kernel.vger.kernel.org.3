Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F452E365
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbiETDwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiETDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:52:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2096.outbound.protection.outlook.com [40.92.21.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B46146740;
        Thu, 19 May 2022 20:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZcEWSw82uEHaMUAJ/3MaPzmN122sjKCdF1rZAy/gYisAWUgWZyXCqbZZM5JeErcqL7metUv0KXbK9c9qGd1RJ4tm4orBHMX8GbMt2PR2CbaEdje6sTvbtMzrm6rqgutz6sRjMgYr8QaSBg8rVLUtAUJHCgc4nZGnW3ge6LaZjhTpfWMfFVQtudNTNlwhexu0l0d2Z6iclFvGuoONSis778tr4z3yQO1p9gWIz967C+keZswHiIabazEY80C9Mk7ASvrGuYp/pMSoCPEBD+ISt/D71py3BwzOUBxTUQreVVhnHJ3n35tUp/cwfq+cWuRtEHpcscr2k4tJfjDLeksqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhDGjrcp/W6pqBm0MFf+EcrxugXlEezPjVkqYm7LFr4=;
 b=D+N6TOGcNKKPK9tt1uQ07lcpwIfdfrVmJ9Aeu3ISulLWMjh8cj/Tm7fcAgrlSFQdvqdERD2vqpOSMXQtb3js0I8evrseP/8f2uYzx4vGU5KP3sMBQlIEc0orzL5jvUPydOVghBzMmhk+dqMmFdro6sZnsEZJm8/Y88aXyUejVLyRdjEfHAPa76aCW4bkQfbkXGodX8vIAkT02M6SgrR18GPSWlhh7GYn+3nfnkYOiC2LQOWDRPzYVTyCfmjVRcjR2n6GnGPVEm1DP3qJNT7bY1agW5VenxSKtwV7nvPt7n+xuQGrfhtn0b71Fp3ss3FFJnWfEU8abO1j9d+NSkxs/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhDGjrcp/W6pqBm0MFf+EcrxugXlEezPjVkqYm7LFr4=;
 b=PU75LOrKV9TSda7g5y5/mznelZUV5mABhLtp7GMHON4a5X67EV8MlvKyaR5X0RZ/XTob7yUMPCwGHwuAEi90y9gn9gTi4Qd5f1OvR8bZ4Nr0y30W5r5zwR5+P05s5uFZhV+aSHyhOdLOX2MFoFqbpYDfy18Qjl5fOLpvd7ZGNBjPkv9a6kovLG/IWKZ4O88EBQiBDCp//57OL/DRTZtCUVCSKEQ5JspWjZb0RuCx5ygeHQu0w1uHlEMPZGqZ+RDInmIGTCsVOrk0yMlnEF0DJaBBCYAuqdiXEdb3ihx+ZIVROXoxtbKM+uSmDl9wLGs0BQpwtuScIk1jxNTYtvfHJg==
Received: from CO6PR03MB6241.namprd03.prod.outlook.com (2603:10b6:303:13b::6)
 by SN6PR03MB4319.namprd03.prod.outlook.com (2603:10b6:805:f4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 03:52:22 +0000
Received: from CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::8878:85ed:6645:78d4]) by CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::8878:85ed:6645:78d4%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 03:52:22 +0000
From:   Tao Jin <tao-j@outlook.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     Tao Jin <tao-j@outlook.com>, Jiri Kosina <jikos@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hid: multitouch: new device class fix Lenovo X12 trackpad sticky
Date:   Thu, 19 May 2022 23:51:32 -0400
Message-ID: <CO6PR03MB62414DD2A91566B0D4C1C1DDE1D39@CO6PR03MB6241.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [oRXHewnecZPya+tVaP6oAjw/5y+iC4na]
X-ClientProxiedBy: MN2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:208:23e::8) To CO6PR03MB6241.namprd03.prod.outlook.com
 (2603:10b6:303:13b::6)
X-Microsoft-Original-Message-ID: <20220520035132.176177-1-tao-j@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b78fb6b-7c95-4adf-2096-08da3a1424e0
X-MS-Exchange-SLBlob-MailProps: ZTmCor6bjd8OJCgoy8C5yGeJXBz04qw3WePb7nLbo2SbvvBWooyJ3oO7zV2+ZKM933mWU4JlWQkj0040g5CmEJ+Jl7AB3dJFotjYE4AmZCkCW+rv27K1xKpdd4q1T/ARuVt1fvzItzEdDpwgt3ZiSF24gCh35lpJBZVkIugV1O/H48CFs80vVKxD6E1CuRG1q2TYv/1MCIRJFJNe/hvf6mO/FtGoD2pSpuJk91MkclGLKacSQ27ebGqt5YIbyTpLgvTKjXeiazXitx66XhzTPCITTXam8GAGX80mXTOUh3/fpUrs30VSJAR5xCCWf/9b2+X6xHmnFX2BzJHuN/b5946NgC3qwWPvbLqUPse8MTOJIFD1evQVBvOFvX5PMQveZJVeqD38VBWFETOOtlEPIhRg16t9uv099qlj3JrKzeeUf8hQydX4SNg3u4z88/j7o7yAa9+LTblcTlnq/dYMxcz45q6kou05zYMn8waDKv1ARJOtZe2LzatbwPE2BF7Jsgc3aYOdhetlkk6YW5Ose3ucLF1S91WFsG+jeKk2EUI/Oj8q+A4vs44R47whrLeyNoAyizvoHCJMKUNhDQga2PtTSDJEgSM2EshtS2uCWhSKGZqDoc9EMQ2wnjt9QtQPsTarPbBtgT8hcWPidiZQd9DOiMfD5EFDco8yPP6aS/Z048UiKBUYPuDThI1FSj8YFJ/kBZGv6S9SeAM4EcBsmJeTPEfbCkL9V06w9SfJoi8oZLc/+p3Qx70GnnxTDhxHanseMHfBEbwtO+p8X/zWNXx7DsQwEcWaENH0gmavs9j/iQd/QnSJ6iUDj+o6hnNP
X-MS-TrafficTypeDiagnostic: SN6PR03MB4319:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xM0Na6uaI4l3z07r4qt4k4vAmBzWAanSuzUdaiNqtxWIXqNra3LfQFKj21DU1YV2zV5XHHuQVcCZ76uowMNLUsV31v7/fz5GxHQNqAArDPSEmtrQZER7jhZpb0tUiE5cNAsPeMg1I/c29zyYUV/PDdoIoLbM4FT5Yv395v+3fdHyj6s0cdQFe/L4O2ghkGeg6J/myrWw9vbs3qyyj9sjKXOCc0AuqfJfUrGVoAE/W0YeN5wKWCGmyaE598c6zRDw6SM5Pu/cFXsoO1OS3zxUGOg4x1pnCi7deHskeYmc9ic+PDPw3RgQTABkXmLHHmHQ3WcRpRkKt0Ao9pjatuJUdIeIVagFyZkUETtwW50nfOCWqko8dfuWwunOEqBPjiYLlMsl0LYn3Ng5I8lRdz4V9gWctrjCKE0HgzrW4UbufZYEbhsFY6UUKjkWULdkQjh5AQALHWu2MSdw0rnK2haFYxVVqxmlSWwMACNmSDWGIbD4PSfA8kpf867L+5z6PWgJ6YDksVIG0x6wIc9kYGJ8/uHleAH8Jxs8ARnshKlMZLGkgnwtOXI+wYc4H8+1X4n1tZv9le+J1Ekx8HfLRfocdw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gd9UxUqHxIFw8OfUFx3owzXeVVRy7RTxqXCVq5bRlv6A9Q40taQKvWcBzpeL?=
 =?us-ascii?Q?hylHdT78T5Dq/SmAeZBr/7zE/mJdyuzjL+a93g4h3kLFrMmd3qrnDqwlqWl+?=
 =?us-ascii?Q?pf59w+39tGWASbYU84paR+BKLNnSstdNufvOpfPq1ffyCcJm7EDixxLWXd0I?=
 =?us-ascii?Q?ivlgo96rjUdNHOBcwhK6WP1+sY0HrI+AS9gAI/GZ0fUjvlz1+0DPRV3Iu8Oc?=
 =?us-ascii?Q?Jgg+m1CL9yeQvTdf8EniSZl6FSowC+kHSjoONeuAwPw0PN6oj7cZ5fDQ+par?=
 =?us-ascii?Q?F0zpYhf00FVUKz0MqNtR8KQHqpGcMAU0MwATPzzArghICfJ103rInKlUUmqj?=
 =?us-ascii?Q?ZC+/yvld/ZTFg7JFJa1C6TC4Fae+Z9TIXvZ8atzn3Oaiyfyfcyejf0Qupf70?=
 =?us-ascii?Q?zUYFZUNeeEieQVT2OaklbWZ/LF0hgQ1ZckIbIWPkhM+jGYkrQhOKnnZ4Ox5f?=
 =?us-ascii?Q?9iYyda64oIBuajdH20dRfPVGZ2hQxaMQedu0ZB58Ov071zghitkFTdmlXD3Q?=
 =?us-ascii?Q?FpyOfNtESU796LIRKGFHiCdgjSvC3+0YKVbYGJKzZFCJSWLMhdEmHx/gPkeo?=
 =?us-ascii?Q?1Ovl/wwRuQYOsr97dRIR7nTXYyEaWOEOp9bcBtOhSFOdHb/UG4rOf+6tJd3s?=
 =?us-ascii?Q?N+/BDkAOYKiY7Mp7gYCKz/BLoONvdwmiGL9Moc+M5rc+0Kuhu5Hrhcf0PiHL?=
 =?us-ascii?Q?bbVcV++vlQ+utg0X2X9n6ijTZRZpi9nEB4YEIznIJkXG/94qG3dpxHodgExV?=
 =?us-ascii?Q?AUjdJ6D3AUaw3Nz9izY/GDttui1KOLUJf/Dle6OThmLcj/YEHCkbMLLduefk?=
 =?us-ascii?Q?zzq2zNRIAmIlJ1ry3dkdhwmSs5N8EmmNPfnhRT6ExFAKHmvxQVqLbo0dyXZV?=
 =?us-ascii?Q?0RoO4hgcmkOgsX4neqSt1WshgNsz2jNnxHxdhSmNFOQtJtNUPySTSaw2qesp?=
 =?us-ascii?Q?tHlmxsyrwZtBV4Foev2/tJ7WVVUzoFXLGwoKcYJzExxoHS5ZPBU4TX22uaaj?=
 =?us-ascii?Q?ecKoCOSblN6ODFfhHgaY18llz/bF/KAfkwolPie+qU1N5W+eutZQaHiipREY?=
 =?us-ascii?Q?Zc1E0jZal1Cfq7ZLnUV4HCR4FhaF3yS3HWdK7ToJfxSHTvnKi8BKyDGSiiQM?=
 =?us-ascii?Q?Z8a0571zmo83EmrHtCVc4LG5QZ0CgWnhQhRSrRebHZt8Ft6asVHVZTkc14sP?=
 =?us-ascii?Q?VEetrHcveBD0vtMHB+s0VjMRs2VjK1NNSyTjKGXCHHbV/rUFSzLcZIrtCGS9?=
 =?us-ascii?Q?qcs3AWts3zU743Al7hxK4DAZiXg7eYykyBdmpoCit4gaEbi/A3eFHv5zdztv?=
 =?us-ascii?Q?XhHL9njTPKHFQHsTzFTdIaF/5nNn1g3PXaMPH5PjdozEB3RERehCGCvuy72w?=
 =?us-ascii?Q?HHYB1qnBhYbH3ZkOjLTnDv/fryni5LhCsCIVcEzlkblKKNDnJJ+S5Cl8ST2n?=
 =?us-ascii?Q?bD593EARMaA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b78fb6b-7c95-4adf-2096-08da3a1424e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR03MB6241.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:52:22.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Test for hid-tools is added in [1]

In addition to this, I2C device 04CA:00B1 may also need similar class
but with MT_QUIRK_FORCE_MULTI_INPUT disabled (but it does not harm to
 enable it on non-multi-input device either). The respective owner has
been notified and a patch may coming soon after test.

[1]: https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/130

Signed-off-by: Tao Jin <tao-j@outlook.com>
---

Changes in v2:
  - add test
  - add STICKY_FINGERS to make sure the test pass and extra level of
    protection. 

 drivers/hid/hid-multitouch.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0dece608c023..ab64d67cd7ab 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -194,6 +194,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_WIN_8_FORCE_MULTI_INPUT		0x0015
 #define MT_CLS_WIN_8_DISABLE_WAKEUP		0x0016
 #define MT_CLS_WIN_8_NO_STICKY_FINGERS		0x0017
+#define MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU	0x0018
 
 /* vendor specific classes */
 #define MT_CLS_3M				0x0101
@@ -286,6 +287,15 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_WIN8_PTP_BUTTONS |
 			MT_QUIRK_FORCE_MULTI_INPUT,
 		.export_all_inputs = true },
+	{ .name = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+		.quirks = MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_HOVERING |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_STICKY_FINGERS |
+			MT_QUIRK_WIN8_PTP_BUTTONS |
+			MT_QUIRK_FORCE_MULTI_INPUT |
+			MT_QUIRK_NOT_SEEN_MEANS_UP,
+		.export_all_inputs = true },
 	{ .name = MT_CLS_WIN_8_DISABLE_WAKEUP,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
@@ -783,6 +793,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONFIDENCE:
 			if ((cls->name == MT_CLS_WIN_8 ||
 			     cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
+			     cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU ||
 			     cls->name == MT_CLS_WIN_8_DISABLE_WAKEUP) &&
 				(field->application == HID_DG_TOUCHPAD ||
 				 field->application == HID_DG_TOUCHSCREEN))
@@ -2035,7 +2046,7 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_DEVICE_ID_LENOVO_X1_TAB3) },
 
 	/* Lenovo X12 TAB Gen 1 */
-	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X12_TAB) },
-- 
2.36.1

