Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E2553233
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350462AbiFUMiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350258AbiFUMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:38:09 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2177.outbound.protection.outlook.com [40.92.63.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC107641;
        Tue, 21 Jun 2022 05:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbmapFYyJcsLyqLC0Y4BOB/Nb4np06NdyZrlg4QKgjgxXIEfwHg3aJAzb2RNVh3ljsCnmxcdch8Fle3HL8IIBV971uPZ04dK896i8Y0TEuwCI9uVO4gK5AvBlDN5qDetP7X0lDI0Umrub+73k+q+iXpBeANOjcasycsnzi5CTo/XrgCyAu6Faqf1MD4JFMmf5Ulrn/GbIKDTPHsY+8JBUP7IECTXe1QmY2yLTLYZwJsfNv7om8Tzi6qvWkNPDY3g3xScXOMJbAj7yL9bWSdsztKjcbWi6QO8bqvJXgKMSOvPFKqxGz5J0zEDdeBPUW/aFGfaPhTl9bGY8eurW1lDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uv+lBjPsj/JJ6IwOMUZCDnY3bh33Xs6DHnTB3OU7SQ=;
 b=HbS2MHAYnOFV/Rr8CG7EyLGzIB0nh47IMku092beJhWKHXroMc8FremE3rt3CQiv2xLKw3t7AnlGCqQm44UfGFh461fqKG/B6COGkkE9WdYcNrDx8mxQEGbicnwY6dCFa7bQkN+7dfN07dzPcfih7u0FFcjoVNgjMKFfc39eJ6nuZNKejqX89KQPEb8vAGAfvgPN+AEy7lT1XcSheBzn0ouGYUcB80mBDNCV7O8emw1Xg6/aUguOPLs0qMdKh7qu6DEE/USaKmH1BW5CjIMtAWQK0uzJyv5lNXftubvIOTWHjKC2r0d/Lbkqh1F2LOlA/jlWk99C5qp2NmO4/t316A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uv+lBjPsj/JJ6IwOMUZCDnY3bh33Xs6DHnTB3OU7SQ=;
 b=PmqXvvvjcUzSS5yGsBuNSmSWqF5mC+MGDzPdjvnFYKiPCehd0a57qZN+yjSzm6EsKd7ikiw5FGPy95FDLBuwEPPocDxs2bdjwgYvImU24V0WDLyrYwr/NeKBb0pW/ujxGX3uAcezO/8ycZZPMC3UqBx4ZE/HbKBs/nABlT5curm3cpOFisP3V2K3BtFH3RubVGOHAPbXS5m5GkeGPqxJr5LVuXlQ0tMYNa+HwPV24QxiasPh920jhfFS2pMUDp1XMWqlNuW9sQL0KzvHrfv5NnLq0VqYKnQCJw0mGj90ZcIvUuEFubdk4z1JWayBkVxHE+hwiJ/G3PkqvzgoToVAcQ==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SY4P282MB1481.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ca::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Tue, 21 Jun 2022 12:38:03 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 12:38:03 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yonglin Tan <yonglin.tan@outlook.com>
Subject: [PATCH v4] USB: serial: option: add Quectel EM05-G modem
Date:   Tue, 21 Jun 2022 20:37:53 +0800
Message-ID: <MEYP282MB23748DE15DA9B962E7A2E7A7FDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [qPLJLnSsIAHAJVZjD3vUMOtc0KOqrapo]
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1655815073-5304-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a46f5ea0-9685-48eb-e76e-08da5382e273
X-MS-Exchange-SLBlob-MailProps: +LiGfBxqLEuS9uuI2GdeKiPvDPsQm0ajlm8rBrIwAVnaMFJk/dLvnF4VLTuoYT/O8kmXHOojzREJW2/yHEzAEQmC1ME8UnzYrsO3hFK9ipglSZ68FVCUu2m7dEBIO4z/LanqcxRJt2OWLKWSLwR8zP6vS4gB/rE4fPKbvrC506u1tkEzienk7cwiRT2wc6Jyir2sSE3ikvqV46JIYEVXlPH4PMM2wvUBqPlFFNpNA4X41/ogKSGZwCA81rXQM9mb/UDAk3pSskj0xTSMsOy9WSed96H6G/4xofMD5Bvj1gqX3l+0eirGBLsbZVmvAaVBigagIoDRDfI2zhCCaFlr7wxxdt0u0uHsL2JadPGz0QA7WxDRZcqbiQlUVAbpLTr61SDwqss6IS0PnctzTo9awqeVGsH0EnlxgXCDceRqw8AEvU5zvD+GsfUQItAkjf1HHQhlvNEzy7WnMvhBrzTZ+PH7wuZDEpQHr/crX41piP7/rdDyLuZpUesjgJtDTGhWv6KiJptEo0efjxqwpwUmCtgNfQ1A1f3APGFwfvO4qsJjumpmj09fx9WY2/ks+WfNuMf/skXrPi6RsuRUTIuGsRRT8VOMuob7NubXpIBqu/nciA1jm7Q70sqpaBebUbLOHzr0MGwDG2xqC2UwTSUlzzqVisCY7mnEyJFa5J+vgNxbMJznULuy6HjtdnogqQo48UIg03x7Ly2MzQABfOMK3y64m2MWXYDerkrF0RPf46u9k97aWssTC0+Gs1omIWPOyzf6LMu9vGPwp5WV9Epfq5EbyhMSUJgk
X-MS-TrafficTypeDiagnostic: SY4P282MB1481:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37AyLOdu7SzUMSet50XItCg4kWg91HM6zKgx7ESBN94UA6xswZ6Ux2JMFGDJ2TYaSwFkJQNp+w1mbiTMQmRaryyrlxk54t4/BQFzbPnIHB48XXBuGtZtdItRrMKD5Jcjp3Yg3ZCKBaqZwRUC7C1ExLXFimjubVqczjdd7XmQLxRdfN12uDZmHsahrBpU+hdgFKjk5g3zhMvP2apSQlhXp5/HKmQLgh+r3Kl9gom2svyXNiAbFSOSFkY+oT4bQFckP0PxBfYzA+hotthP+jvJKPjQQ7BsaJxfHkrG2em8FtRkz4ZFqaZUEuzZ8IeeC4R2a45wGpCflqkLonlULV1CJqk6sqIJZtdIieMkYsboJzn+KWSEiS4xe7DxWzrcRP4ZDWiribKoAksztQPnM8WI/iENka9x350D98I2vXnjSH4OnCKlsKlLdeqgRFgmIpr+ut8UX4z09T7L1by7IjG1yeGKHP3IM/pCDcYzdwT7xW65EiIGhGRpLzEhZ3LiQCFUzNUOZsAJ7PBLPqGm2rk1GNbXx95O4IYpVaJt8ikzIr/U9oBd6ySb23kj1VPLydSlkouOrYnHWzwVIECI70vmrw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HeZT/U64Itv2RU6F/830eanG0+LUOlOhxW4e/NLZBOr2kN94nd9IcEJgWhnz?=
 =?us-ascii?Q?ok/cC+BxzaxokQ4dZrIohuAqRm9fwbL/3zSuY74XX7qQZCqW369/TTXKl9/3?=
 =?us-ascii?Q?3YtZU3pMO3lq0stPeX+J6djBk8+ZYN8guiKc9adkb6Jup3n4GmooV856G17z?=
 =?us-ascii?Q?ATHLoM6Ufjz2g6AnsHnoWbI0BRd54/Y/3dYGAUIUL3ckDEiZYGiawSdZ69LS?=
 =?us-ascii?Q?HOVMy9kehARgvR9odHvx4tT4YYpWtyfbD1BUO3Uk9/B+rlOKffaJOkFVrcV7?=
 =?us-ascii?Q?WUP/MBF0rngZ+ELT31R6zVH6sy3x955LQZyQ7KBSbSe9NP1blcwyZf0WjmU4?=
 =?us-ascii?Q?Q+3gptc1HCLgfzDJxeRLiIXhorNmGndk/4LDQdXRDpILy7ZaxChIDhfbu31A?=
 =?us-ascii?Q?9njbIiiXeSBieAnQzGQJnugAV/0+ItIxnYfhtjkhPWFdCL3l1yLn6OIB/EG6?=
 =?us-ascii?Q?oCDCgbMDB3MCpnuOAtDD2a/VUgXSvIIzlYIbBt3EVDiCSIBjfY/M4IYsHEp4?=
 =?us-ascii?Q?nonJYPa3A1GliKSg9FTSI82c5JHyTsanJTq/SmKkgAUI7BWtBakfEmBGD0iZ?=
 =?us-ascii?Q?eK0qeSWRWa5og2Wbpue/wkYrFzxm5EIuVQdZ+p2C5c+2WfztVDWVg0F7nGcL?=
 =?us-ascii?Q?zGEdGdOGaBDCQydU+t9WQuaV4RNE/3RBT5W7aqta3SxOqfWaKKwJ2z/DbkuR?=
 =?us-ascii?Q?8HYAQYuetHYWGcmKeoHYSgsSc6cpmDpgzoy9HKHUWTxR1OTtzY1GUgKcgBx7?=
 =?us-ascii?Q?7g47Cic+kl24U+nGXjGslcya9tJexL9mkk0Kjkt5uL/wrSr+1a3sjNO/i9HN?=
 =?us-ascii?Q?7hNW/fTOUPBm+dqPAnQbMnjYPCm3Os/HL7eW5pkKIjFWlXq9TpwEEg6cH4BJ?=
 =?us-ascii?Q?9ad58vOFstrWbk7s4Nv/KTI324z4L3P0qiiiuieH7XQuPBpcV0ANErPouZ01?=
 =?us-ascii?Q?4aABLG4fv0Rp2EGVwuL1n/Lu87YyvDQ5202TfIXTmij2oO6ekT7XP6Wa14c7?=
 =?us-ascii?Q?C7TExJ4FAFibNGRuHP2ARNGjNzQNy337D+L+7yCUCwODn/c42o1eUP5gFpfn?=
 =?us-ascii?Q?LEHVYr4bttFFJjrRTGh+tqcKuqr1YBx2DF/hZfCQG22yBLaD99xwlDAkV+DN?=
 =?us-ascii?Q?+Iz4uROcQwa2d5X6Ou6M029d7U+fWGOKE3krPUp7CXU2jUoSMHW3WIgtkINH?=
 =?us-ascii?Q?zOHSnmjo54JzOONTPsLCAgi+ch82EkGhw8jO/BcQ8IeNvLbZvlK/QcieNep2?=
 =?us-ascii?Q?0oiaPZs6VPPpg5LIxRreFAS3QOE7iKTr7NbytyRMiK694M9M/gPRYhr5gkks?=
 =?us-ascii?Q?dUiGAeAIlMex1iC0zomYzYiR52GQyAzQm739IlV/xVEKKCwRN/CCIfd4w5RS?=
 =?us-ascii?Q?rqfgKuTIvkXZMKubIfuM2M5bAGK+G5r/1BFLgRm6H6W0ImEM+Tx14ZGOQbSS?=
 =?us-ascii?Q?Bd9gYS4GZ6U=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46f5ea0-9685-48eb-e76e-08da5382e273
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 12:38:03.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EM05-G modem has 2 USB configurations that are configurable via the AT
command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
the following interfaces, respectively:

"RMNET"	: AT + DIAG + NMEA + Modem + QMI
"MBIM"	: MBIM + AT + DIAG + NMEA + Modem

The detailed description of the USB configuration for each mode as follows:

RMNET Mode
--------------
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=030a Rev= 3.18
S:  Manufacturer=Quectel
S:  Product=Quectel EM05-G
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
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
I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

MBIM Mode
--------------
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
V2:
  1. Add the description of the usb interface configurations.
  2. Add QMI Interface description.

V3:
  1. Move the entry to where the other Quectel entries with numerical PIDs are.
  2. Define the macro and remove the comment.
V4:
  1. Remove a blank space at the end of the new entry.
  2. Change the permission bit of the source file.

 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index ed1e50d..2ad732a 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -252,6 +252,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
 #define QUECTEL_PRODUCT_EP06			0x0306
+#define QUECTEL_PRODUCT_EM05G			0x030a
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
@@ -1134,6 +1135,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0xff),
+	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0, 0) },
-- 
2.7.4

