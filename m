Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4775518A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiFTMR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiFTMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:17:25 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2162.outbound.protection.outlook.com [40.92.63.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ECC279;
        Mon, 20 Jun 2022 05:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVmq5+6aniqweuOy5q65tiT8S7NlvoVNkbuWVKKB2yLVc+Kyed8J8rZMFtAe3oLB4MK2fsxhU59Ds5izM8+Y/qpiS0OVBNUlZfeqoNiuSy34x9igl/p02S77/mME5C9h7G+KOo6txTt7i6EjSvqyyQiD3qVr5q3G5h4kT6L7axxVd2WU15ZnZJTaGLlsadGWndQIoQcX3WdXIJiMxR6k8FTidcPVkOuiFNJfguXJnYmHi+ghxpxuLRAr2nLMkwi9eAE/7lSA4zRu9KhmA/8SGYPr0DJY4jkJEZeIG/7wjL7bzE1MAUg4XFd8LJPLK67WKV9tzdL3UR/CL3tZxp03Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb5hl86nNl32BhatN9qcLKaPuf3LJgoWDGiKFCLCZSk=;
 b=eNxYtdZrj6zr+s5ixAmxdAnOgz7VMedk2qnVd1G26rR0AUGLu1tN/3CiqjPktVT1prB7ZiDVAdwuFOt0vnQPfKNy3VGF8bz+1zwtwN1QtEQ8FZbG039USpmViEQ/EJ6ro1wTfy3IbQjFt6T7THRPxxZAcQ1FZ6v5hHKWnxFb6qQwMOhBb2UyWbbwNKnL7QbtSVhDbx5g8KOfRjSDKBtt9cp+9JPYukA8Enx9sb4BZW4HofZMA/TW3WrAU72AJRtwoOUuoiWX87OdP4QMFzx6Rjakz7Rzrc+AWaJ+uyyXq6NisXX1CclR17JKBpNTG24oXYK1bwKAn9WGTqGd8nej+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb5hl86nNl32BhatN9qcLKaPuf3LJgoWDGiKFCLCZSk=;
 b=VEW/3sC+fJUwQAEYt8cVLjUhvD3+pKu6FwcvH5eaJvXoNMitkRXQwOX1FqeW4W2pTfF7BrND+RPtaf8zSAl51rDLGUOt5wh68tWmidM73DtvjRNwHBszTiMSZvz5GfbmpqMu+uYNxaCsE9N9H7A6ZPQkcXrLYLzM0uNpGtdzQJEqAb/TgY8TAAWQfz2DlG3nolyklvuHemdqprbVm+Qi+FW8bOf5XQsCIjEL6H4fkwt1ch6zGLZamXCdIl2TJDGhJtL9LpyGhwR79xT2TR4LTNoDz6BuX4RNubAMsmE8TbDtDvnhfwatmQivjvawuUZPDGPIQLKFK16Eak2IIOXNXA==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SY4P282MB0795.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 12:17:20 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 12:17:20 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yonglin Tan <yonglin.tan@outlook.com>
Subject: [PATCH] USB: serial: option: add Quectel EM05-G modem
Date:   Mon, 20 Jun 2022 20:16:53 +0800
Message-ID: <MEYP282MB23740858061FFA19E97E5C0FFDB09@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [F9SUNYf5bu4TMlto2ujTsmECwLaSxhIW]
X-ClientProxiedBy: TYXPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:403:a::21) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1655727413-3322-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a1fde60-d6b8-4db6-599c-08da52b6d315
X-MS-Exchange-SLBlob-MailProps: citmFLqyTFT1iUgGxM6bdkskiZ+QeoDmM+qUDtCfWGMC8ynKHUVelk932xPPmuDVyy9BQrFrW/uJWrfQDMoErZs9o6KGmV1fUhnMQd53Z0C4JtcinZRObh58si2zwkt0cnJVPN9A0CXyjjjP75dsMKDXWG3+d4SUW4EdU/GisPTebpElaOVvl3Lg8kYg9HxrXcXgUb02DZuL5zbSHuWcKrsKTdr5ss2P62NUxYEDNHi8o7UxMMKlaJQCjoQVPldCT0nhNrF+874AmArlgDRR6rFwEin5XIFKIVRskaEhVF+3FI6xONsPoTTuYz087zhNafgITZ+UWBkdK2mCAu1P2Qld6UcPiqUHBVvKV5K/605UylkYD4tW6dnFgpYh89pWpVd53Wb1SeqVZL1jcMEl9tlU7IKXYbTE0Ge5lcM6uITZqFxTKWgotTWq6IJC7B7vAO1gtznwwTFgzN6KTO++e9OahBOWdkWs0xb/NvtscLyneGaeTzMB78jhMONgj86wNj7NrO4mfFjrRYArfmbFBxRNXX6+Qfpk1f5IyF0siMon+SSgcNxXmkTsANCsxdffiZqaIYxVqpyDLpMLfYpx4ecMnBCkAZWDmjnvEAGojWHrEcSgU2xCzxiHM3fHMof2ZhierQtVhMxyrcWEoblgPLt2Jw12w/8oZAvq5RB+vauV1Mz1eeZSj/c8SIkA5Op45iX4+hyhA45AuG654FPt0vqAGLiamC1uFkfZFzGYVkOZ341YWgsfUtY/bHXH6H1p/+XqGK0kHpWla6gBCdodVQT6jIbX7lWJFRtfQnB7ujQ=
X-MS-TrafficTypeDiagnostic: SY4P282MB0795:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMWbr+9fJWw3v8gTgx5T0fuquDEKwM+h63upziDqGw+OIDCEscNWpPJi9qgjMelozu5PC8YbufouZRbx3+BqtCoiL1siLtGndavnAAJdjd8WqgqQb15yOvgq0W+0izpDWYxzm4aQ3X35SnI+t3DumZrlIlMYw5qnhFk9j6mOROtKMgk5FsScNGbjl8FTS/macx7HQEuo0p41OBv2sDTJhizVMptiwa0Ufj4SU9oCZ0QTQD5KKEDDAbk0FHd/zjal5ULijz1I8fi1Iq6zIFNF86YSSRRM+lIMW8rCdpcXMruFj2ar2YKjBk7Aqa49yeamuIjxzMXRJ9QVxXO/jOjpDqOolfly696nFfgy6lZE/CikwYO6A6mhDnKHShkXwhuQUMlvwPKNR178feLXFEQ3lU4GAsLjJAAJY2SrhQTGge8FdEasFTq58uR1N+FGQ2gVZCF4RbnbJyQOp3XPVGDJXUjf+lbAdrKFZ2zftAoNyoyEh7GOiRjZFgCr8wwdavV648zsadYmURP/PJfbtQVWBYe0In97Rxhx5+D+vDKe3OTlEQ0FA+AYFh/zX44pDgX0quG9bmmG68eU7YLlgomvvg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fIziFUsXMup7kLg7G2QeFDJY8sK4igVXEVLyIKSom9cupUxgA+M59v2TdaOO?=
 =?us-ascii?Q?RKXyvUd7/g4sIbdrojqyN1XOOfmoulDHOkUzZRFKLB5IPMrY4TXT8P3SAWvB?=
 =?us-ascii?Q?2X/IyZ+7gt0dBR+EoM0s1PVrZRWdxec2Dpdcl45jWmO97o1C8r6Mhb4vFpAi?=
 =?us-ascii?Q?553qt1s9dZD/h+H2C6I8BIqqkffjXoFXTe3q1OP0MlSn01uHXvRBJY/J2Hde?=
 =?us-ascii?Q?bEaa2rHm8cAbQ/ht4SQlStnToxyOO4LMKIUGX6ClJIz2a9DwErpJ1OlQL0Xo?=
 =?us-ascii?Q?6gZqt8dJDIjcvjhkRJKivx2IaXnvoiM26gJLC7FMDSFt48cBHLW0qioWWyWP?=
 =?us-ascii?Q?Vm/P5TJu6P3NBL08kk5+gMN14Vuf5YoUak/M/aypM99De287TO3xkHTd4uad?=
 =?us-ascii?Q?zoqSDQ+ZAWsMaQH+WzIxwodZTcn65+EyOkv7ReLXNDjGPqZKkLySme6j5E55?=
 =?us-ascii?Q?QT+La0U7oxzn6UBWsOqzJINLrTEiTWXC2rv3EZRtgE374BzOoSJVtEuHHKrs?=
 =?us-ascii?Q?lQdfZLsZXOnUBEY9+y6t/HpZy+X5QvipFWrhoc+X5pPepA3eL0zzb9WrNd6y?=
 =?us-ascii?Q?Eq6K1JidMaq14yWEpYtGh6sUZxmCA/hJHAeklwZXZO824XXWwIiJyV8pQ1hW?=
 =?us-ascii?Q?BR5KCMMePggsZ7SceEjRf7YWJXcJ2qn2AfC+Sn5GRvQVxDCPxeJVG7xEFh29?=
 =?us-ascii?Q?Pq2xIdHwM8F2BgitMIwaxIVfJL90dDr0dJ1nv4vpDEVLvqYxINuRdtQIdInf?=
 =?us-ascii?Q?zUu1MPpNGphOMaaxYVHiApunJdHcO23jEfYMb7mYkmMF9gNlbHYBiwsAUxsw?=
 =?us-ascii?Q?cb5Vj8fC+Pd9QWLjAkH0tspDlPln14WwGdLJBH41B8v6rqfS697xbX+RiWow?=
 =?us-ascii?Q?fiL/36S8jYwMfmhp7Jm2+J7eok3Ze96zWOPkzSp356J//CVZqejn7jfaDIAo?=
 =?us-ascii?Q?c2APoqHhHUeOVtlPedvXP4RuglBPcLMHnGl1NR0i+5BSWy2aYI9r+xMVqA8y?=
 =?us-ascii?Q?g+AYnp9tKpXhAmyNQxX9vI8/jUnZSD0o1Dzb8FQv+pa4nB4f5TtuM08tnFUF?=
 =?us-ascii?Q?Ol3PWcF2lKNpDdvyDK/r9RU8Hj6YqjNa/akrFXLOrBLZHAgE83kg6RpIeNCz?=
 =?us-ascii?Q?QW7RrotfcaIPDaZdxa7++CeKZ5zUk1DHmbDS/iZGcX0dMHPdGTZCTK4tKlQ/?=
 =?us-ascii?Q?YFKLJNs/YnFv0prkCW/hlQcpnjttUwupwFG5VC3GFSsBNUHmxmQAMufo/FaJ?=
 =?us-ascii?Q?JJLpsWY5+hJ8Rz22bW83tplr3T4EAjbGNhodwCQVIebkeiDSe7T+XcNm8OO7?=
 =?us-ascii?Q?gKRoYYaBeArbjpW1XcA84dloHJFe+GuVND8bbu/44yF1iOfRgI/sU9qtpChi?=
 =?us-ascii?Q?wZkPsjXfIBH66yCxb0nADH8KG/YEzuvOBeUFxiq8uBOylxy8iaps9oVCq9eI?=
 =?us-ascii?Q?iUk+2t9Ug0w=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1fde60-d6b8-4db6-599c-08da52b6d315
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 12:17:20.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB0795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device-id entry for the Quectel EM05-G module.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=030a Rev= 3.18
S:  Manufacturer=Quectel
S:  Product=Quectel EM05-G
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 => 100755 drivers/usb/serial/option.c

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
old mode 100644
new mode 100755
index ed1e50d..05fc322
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1147,6 +1147,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, 0x030a, 0xff),
+	  .driver_info = RSVD(6) | ZLP }, /* EM05-G */
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
-- 
2.7.4

