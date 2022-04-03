Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8164F0B70
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354926AbiDCRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiDCRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:00:31 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07olkn2034.outbound.protection.outlook.com [40.92.43.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE565A5;
        Sun,  3 Apr 2022 09:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4nCFh+v86raunjJcxxfLPuACenmlpCqDe12utrj5N4HJ63LdaLIXrcn7MOTJnjR6J5nZghgECMWabWNlK4V4C+dZSqA4TjKBzwpBODfHRhPQvUwMTZlsc7+1Iynh9lZ+ham0R3ZTgXwvUWib5VxSpr1yrkcDhhZDwOjF0ia3jckDsFzUNI5+DpLCLk/rZ9u+h6GRPAgXYuM3o3+jHyqz/Mq5bEOkERu296u+pMTb7R57PE9eNW7SYMQnFtt8idZBFbQO4gfcd9XjsXoItK9xdrp5X3JFerMIgc5aoMQTIGzccCGQojErZHzWC8UDfP/ezjg0C6jOghbjyYzFzTS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HP/YBde/Eu/GQPo6FRjpZXipxAI8q2uUDpFMgblGhI=;
 b=Kt6lEuJWAH+We8XMkpAMYIVV1hBc7CVyhMBOYjwY3vxQcLIzU+xPax2TpGqK8ovXI6gviR9cHLQEJYRDXx0n+G9ABS0ef1DdTWV3QcoRF/zbDrimUpw42Bw86CaoJQwkQ1/tED+iWsVX9z1pg1UIB7KZ5rD+q7BGmGPxK/OWDl/dAfWFzNY/SMFvoAFz2m3r6TWBadHVAZhffyMDx2238Vi+82lPzUOx079fQREzE/aSYmPrUtr4TKmcueWK21dClNw3j6rhratrN6fakTP1DL06wr8QTDHZ8FSeYCqFCVStrRe7ImnzYbYXRx67C+Du+b2tiPwW1KWq/ERddwfTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HP/YBde/Eu/GQPo6FRjpZXipxAI8q2uUDpFMgblGhI=;
 b=i4mz8fF+W+AOQv3BNSmI+2XfcGXDXj5vI/yBx9/aXkqJYi0nJEEOFW6K3hONohx6hJpWbzqGNIF504J71UGVu8O3DjWVcPZoyNUVIHPGqraAJE2z7+RfygwXXxy6hCcsIB/FeT6clyeeaH6r6osj0zSaBODABmwOjR7wi+s0D69UNx0zdxmRp2ggfQImErwpyMUUk0gY1ndYMqfz574cq1BBdLQfI4rIzKrC2XBgEjO6bw4eh11FMVjyrQz3A9gq3tRTxprIMUcastqHGC6Ef2eGdOANEU7mEUsgFWQf/hUzwvaFofVkB1yI27BF9fix6L+pKCng9o2V4Fo+e5tWSA==
Received: from CO6PR03MB6241.namprd03.prod.outlook.com (2603:10b6:303:13b::6)
 by SN6PR03MB3679.namprd03.prod.outlook.com (2603:10b6:805:42::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sun, 3 Apr
 2022 16:58:34 +0000
Received: from CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992]) by CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::98cd:da57:6117:c992%5]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 16:58:34 +0000
From:   Tao Jin <tao-j@outlook.com>
To:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc:     Tao Jin <tao-j@outlook.com>, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: multitouch: add quirks to enable Lenovo X12 trackpoint
Date:   Sun,  3 Apr 2022 12:57:44 -0400
Message-ID: <CO6PR03MB6241CB276FCDC7F4CEDC34F6E1E29@CO6PR03MB6241.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [R+4PqUyPtpkSjJd0qOcLvL9Siv3M803g]
X-ClientProxiedBy: BL0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:207:3c::27) To CO6PR03MB6241.namprd03.prod.outlook.com
 (2603:10b6:303:13b::6)
X-Microsoft-Original-Message-ID: <20220403165744.18050-1-tao-j@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c342227d-f984-4b37-9955-08da15933022
X-MS-Exchange-SLBlob-MailProps: mBRmoEB1kyKiQNUZMWW+7W49gbZzib7CXtRL+itOROLLdvhsHwUxiSA0ZRTmhnWzxGmQYcU2r2AgxUiVWGsZDITs/HIPI9jmjtwtyfhBluo79HwFphtRKv4DsuXhit56GfNH9FgCJsFTDWaK5qs6Bxakx+BzWnBHj/tk25r01a/U8tRY4fYt/nwzfH7VCSdjeoSFziuACzRJ3bELJ4rRZgWqqv2W4G3M1V+0/EAEYqTABM5wLCBO6d5YiucVD9CYcT7N5ZIDR+yDtZrW4rx8vjBwcoLPt+PnS352ucpSqkePATY+F1r3ezOPhnHuJHQL3iuTEkP1mG3t9mmrlRj0SVX0OXGsm6YbHrzNB7a8MdiGAwjJYjsmwHhhTLhDAnags+45dJqpNX+AodE43wx5ayuirQGu3U7R/ifzkVeSDWp9GTRwctzcTbWsA54DyeWs61Dy7fneR+i2DilNfHibxqbUZpyUMw3RgMsGq07tEd64jLf7um+CDgZTewrC4znKD97RE7twGm5O9EhyJRbUmTYQMzJKc/NFPhjDy1pVSny0tBTjD+oIED/zRJ81uLq4p6bUSlip7L/tHBfcAiXOTXvJfrKSDwZw35Y/H/BkF4dpmpgvX7b+5jr64+ED/Hdp/AOPVmJvYTLtLvnGf6uQZumMSgllCDHoT6dZt0HcXsDWnB/OkWhJgxVon0u1ImsiO2eBEoGrP9eNgWNsX0WI37duj3NOrrpoYbLUXxonEhK0qWk3ErERqqVoqO3zrcxBmiHAHQs8wX4=
X-MS-TrafficTypeDiagnostic: SN6PR03MB3679:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yyi0LJTeAbznlib7i1r7Dk9NVymoO0Eu9+U+SQDKB6kFQ5WfAoeXdWp6wCefAZk4wFM7sMVoTuZ8BsGra66jCaJtlKhe3Nb0DCvrLKhKCfQL5bUIW8CnR+yVzRYIImO0olQhNugC3EnVMiClqeMO4lIagwK3zIG5jK+fDly2Qak03j9dbZP4N0rM3rucDMi4rI63FdX3atSx1bGNKU1LPsZWyJkO5ISYje/MzneAHduAPKjdoXIBxtYc5FMkR1n/znvvoMKI+vKaRRcP6pmIWZoSM0aK3O0LAqaKdYDFydjorpv6fycQ2XFiNDEgAK7rHc67ahCCuDcbSDKFpoqUHHrxkBh1k+4aPa+JscZlG6LwcHdhrgCKKn4fcqIR0zy7L/pH3eIUyHs/gEhPD+BVk2I5iYvkppAGHXuHE7Zq9Pw4HF0/Mz+QHhdrcHJFhxQBvkm67IshPM5q2UOj4feCKu/y/2JGPotSmRQX6of0uTn4tQ2jsPe90ukbDiwwQ7W/m8S+4XNCfdzHXlo/qVreQniXK2O2rFQnEU6o7Ghq9FewrhyyvIbgKdmESJONCyZ7DbP8eNgYU6FV4ShBh/1tgA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LrDERsdrQyN2qQSjjHgIYs7an+OF4NxdTFRwCLja4tVqeJ2u0r3BZIbhjvTj?=
 =?us-ascii?Q?eA0SQf8nkjTG6T5W+uomTXxmm7cpoN1BKnaSq8pd6GyLLt7WLOPw4VARSQFO?=
 =?us-ascii?Q?Mr/0efplwNpOBENDEkK+U6gW/VLOmWfMbtRbKFuQ5mizF4X9II0NGy6vcPKr?=
 =?us-ascii?Q?heFbmbYYV0i5xj6XJKOsGNXwxCq7et2OBqTuw1xm+eHcbfeoHmz1u6TvzwY1?=
 =?us-ascii?Q?NGMv+lJHiKsbSs4vlJssEVm9ZEirXOnuWjLRnddr/2+LHxmO3GhbBsJol5+O?=
 =?us-ascii?Q?sQqcJNo//sgU9VFis8TdSCUxe9XphxX6PtVBDBXkE7bvYiJLXlskd0DLo98v?=
 =?us-ascii?Q?/Qf9dM9rIZuaaj1PeZKsKZJb+lH/Ksvs+oeogeY3CnkHlRNOxNtXbbDUUlML?=
 =?us-ascii?Q?xBlPbcoV4oUY67ILAYaBtjFgmR2oRPwgo51L1qr8las5nW7OQNOsRfD/yUkq?=
 =?us-ascii?Q?JFybEacbDOAiB/lAeEKn2Ie+zbFWQjpjOpRi6D3uBcC2zNbJukYmY8OfPSDu?=
 =?us-ascii?Q?JXyoNrXZj0oc6PIRVtYWwf/8rg/yGFHLLHD0MiCWOnYEkpqjciWEqOiKPMYK?=
 =?us-ascii?Q?RVGP3yMSY8BpRrSs2xmBQ+U3C4+p1FoxRqbDZhTdCMaZQ5Bz2LfUNHjp+EUd?=
 =?us-ascii?Q?qMBH+U9u8ijgonRQeA3vz+rPV7Fq4K06BsYbD1eLHtln12Yi13tS6N0Dw8gG?=
 =?us-ascii?Q?bkxHPav2kLKn1LTB3is1ltQenJlNEPGxL5+swagxG8/MkYDgEWO67QMNhvJl?=
 =?us-ascii?Q?srLqTnKgV3g/YEfapR6bcABuYHGGLtbJUB5a6FoSMmnvwGfm7rtWg7GJIxU6?=
 =?us-ascii?Q?F7E4Tn/LMSD2IT5IGNXrUhuZFJiNm2kEzuGfp9EmKjqGWvafSbc+NrhpiCTG?=
 =?us-ascii?Q?4IbqIZlpvRikIRr8uOMNN68+QfbFWBITzh8LNRC+Ld5K4BPI4v5AZb1MERPx?=
 =?us-ascii?Q?35XWACFcoAsWNHkrDJXJqc1mRXJ74ketFYCZeWHiFVaR6evqH7UDV/G5dtTY?=
 =?us-ascii?Q?MNvEUVbiAGiErhsGAV8xkzsHvYCjGyi9FKS9rig2Ik7h6+Mj6AvG95RKobbr?=
 =?us-ascii?Q?g8GjS0o4r6vqQ5OuhFzhB2QmM8CDesnP8iZ1aQsV4W61h0Hs0szytAymnoVv?=
 =?us-ascii?Q?gMCrpZ6O6bODRmitC0JUhFh1j63pAUn9497NLnUSyOndyzsrTK1lwKlqIWt8?=
 =?us-ascii?Q?rkfW+l165c1+J2xncaokA10FRssr/3JZNVHA9gusGHGzTz8oqmvzbD71a+VW?=
 =?us-ascii?Q?ETRq5/BsBAK8KyBcJKZAXhHUqCrHP0yiTOu+bK97cDKMIJTJ7gYaOw8TqKy1?=
 =?us-ascii?Q?Vgj7KoQd8OnIz6/RuezjD6Pes6RRMbTM0E2r4cDk+uIRIAyvA9Q3imrJjQfr?=
 =?us-ascii?Q?AbNvPLjt4bgwVj1Y1hVxHVpgOSMaZsowrUyWA7S8Q3jTwjdurYbkm44QT64l?=
 =?us-ascii?Q?xbe6YHEMkFg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c342227d-f984-4b37-9955-08da15933022
X-MS-Exchange-CrossTenant-AuthSource: CO6PR03MB6241.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 16:58:34.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3679
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies the similar quirks used by previous generation devices
such as X1 tablet for X12 tablet, so that the trackpoint and buttons
can work.

This patch was applied and tested working on 5.17.1 . 

Signed-off-by: Tao Jin <tao-j@outlook.com>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 78bd3dd..aca7909 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -760,6 +760,7 @@
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
 #define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
+#define USB_DEVICE_ID_LENOVO_X12_TAB	0x60fe
 #define USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E	0x600e
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D	0x608d
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019	0x6019
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 99eabfb..0dece60 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2034,6 +2034,12 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X1_TAB3) },
 
+	/* Lenovo X12 TAB Gen 1 */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			   USB_VENDOR_ID_LENOVO,
+			   USB_DEVICE_ID_LENOVO_X12_TAB) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
-- 
2.35.1

