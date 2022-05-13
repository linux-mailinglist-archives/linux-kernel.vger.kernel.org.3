Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36AC525BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377637AbiEMHAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377621AbiEMHAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:00:44 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2178.outbound.protection.outlook.com [40.92.63.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977222613;
        Fri, 13 May 2022 00:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I665GQwJDvaKHqVYjYo4BJEKUhd0I/9g+VxKVRm8bG4vvIgMet9P3A/KyBJDq/CjbQNwW3XWY/0hTEgOMMYGUpwNJ43456LavHJQ7p/lICfXYhSWixES6mR95hUbLPbQZnYLbqp9tYLaYP+oXSIsDGasy4SKIXZ4hmDMomGmuLocdF51NPC88TuYMJO6eHla1t3S5oonaK1699qJeGY/5ZKMDbr3YjpjoAy8Ct4xcgkV/p+eS0mTcsHt1qIChajP9lq8KQeoqAqFWnGiwrwWohqfEFN/gz6ngIQ/Nc1kHnyldoERRcTmSNf5i2mU6i+Jp5FkNt0r5L762ifrk9TOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUCQVmJpUePNb0KEQZ8VuPr/KhXgvsKZkIwkGKl2uTo=;
 b=Cipl0/hQx0K516imNFAv2tP9Plz4BRrljIPBdzXGX+PFSS/mLjbv5uSdEV4ctV56US9LcBF83xKoNH78M+5vNlweMNqyOoOh+UbqJL1MCwrDPcZo/l3DwhmZ08cb1pdMzDJ+5T+YElToN9EOJjcADOp2HTxrq9VZcQ55e9Zo597Gg59LW67LaL9mtl0XcVqjTG9DbeWkFtfseBqjMJfKotNgFOnvZmOo1fSKFw+cjDQrsxi8CUOuf/e0zyLXSIm32SSujA1stPDSmE4POhRmrqxpVmJ7tuOhHWTSCxLXWYYdInEXMmRfJYk3FiQEdVaU+vyLya/NT8LNJOpdDoPg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUCQVmJpUePNb0KEQZ8VuPr/KhXgvsKZkIwkGKl2uTo=;
 b=pLkfPs0kmET86q0Odnpq3s4A69zPLvtsOpLT02tGXgk7o776c4w9IbGd8ec7MUOjh6uK+J1s5wUMZAWFe7cq7ko2vZSvR3HuVQ5hG4cNfztl7OgICaBnAKVVmc8ELB8+bYRZtTU2mzYNvgxFcE3hXS4i8wDnqXwJRikTJOwGIZkhUSSWU+fWahul3d2NgzLBC9YkYR/M5Wz+y/g4q2sxI9soOLrN+aM6BEg1MN/gUoZ1hz4yVDFfxDFCp+1aPGW5O8qPWACqVCIljS5ydPRcx4gNxHAvslg54MJU0/IsNWkYcPKvakxbQa66Pwxmj+KqR5c/osDbHHx5eWn7x3WGiA==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SY7P282MB3836.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 07:00:36 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 07:00:36 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com,
        gregkh@linuxfoundation.org, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ylintan <yonglin.tan@outlook.com>
Subject: [PATCH]     bus: mhi: host: Add support for Quectel EM120 FCCL project.
Date:   Fri, 13 May 2022 15:00:25 +0800
Message-ID: <MEYP282MB23742A3646D681AF27BED85EFDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [LapoVmlh3NyOfQNPb2aKKeKZvNGDhG6l]
X-ClientProxiedBy: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1652425225-19461-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c524c59-d938-4c42-ba48-08da34ae47a4
X-MS-Exchange-SLBlob-MailProps: q+fD6XS3/UK9L7TuN7urXflCoxF44vp+mgWmKm8GeXXZb0oEhWY5o4sDySjMDGeHMVjFcKC87l1F5wTQTdFi5tDx8dqXmTmOSRdIVSPsE8UIHAgxwzVmgdGuNI25sxJE6Jwit3adr9Ap0/jHEKoQUnpgT4kkSBcYXwB9spprbUyw5Sxk5NYZzdKAbGTSBl15B5cF9kvgm2bBNfTnd6dLNNDV+xS3oAi0JCoOsED4OQaDBm1EdWcPynMkLW3eaS09pQ8+nz8zXmefqStIHC7o4zDrW8wdKx6LAfb7BU7tnjm9k54OIv1Leadk+9Y5qOWFph8Dm/hcHKYkRFrGWEuDhf/kF9ATEw57MWrG8/X4oBjA1amfF7mqi2RubqHQk97ULrCHtbtc5rvOU2QUC9ef4O4bcFTML9fbu/GUu219wMpdnycTTXcZVBCWKhuLCtsrv0lN7j8ift0R8cikpRxjDgs9preW4mwzy0hqoJ0fECiZmdzd4HYYZ2XP4HA19j1vRG++/U+wBgpp27Re7kpWUz1ZLYlHaS4peOqT/2boOCI0qsketMjl6iNLGxBC6Id9VEco2EHdR/ZWsvFEoTZGsNwWMVlwFrdH0jJ4BzM1RPWDEwgbvFxT2e33XO0aFs7R6Q9c7A+vVFl3353JRERqm5Hjbyw4eKAvY3CJ0lmV7UiVrbR7+5KiZZIWA9uJNN6XZIg8BbghiNsEbNra+nI04A==
X-MS-TrafficTypeDiagnostic: SY7P282MB3836:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0qskfP8rTPLV8PRW1pYEv0nspE7L74CVOSxuFZWrNWlHHhJNnFRLxgjNB1fdj/3q08OtNoaXLc8BnBV8r6psMGSLozKP43dMPrQknTHKbjJdWWUj+uMvQMzXnjSNkGgX06Q7QoFNU5KIue/CeuO1OinuDmpzfOzWs5n2xHqikLYhOx1foz+hVmk3v+ruvqKtZxKGdulrcZhjr9hxAHPn6HKIFnbugZL4LbFvAvG67BF5PuabhrsSw0dOmIh0cPN+xFkVqj8HLncTJ0n9VutaOiVYQyRMLjVByf+rQH5Y1X2+rWg9S7GQKWgYACGNjdJNaad44DypEObkMCzO/Sw43e153IVKMGo4FOxJc2dkAWtDyjRX4KrJ1v3pm4aAP6J+Ay5sPGMdAJNIUdBGN6IK1ys8yhEBP4Cn5Il9iwP7Edv8Y37ZWnSSkIAYDGJZnQ2s+8ZTaytY8VoriU+5BE6bG0ddZLMXB8Oc5dxS9BMzXkcF5Zqdhrnk83iXgLf9yTHoOjszBwdMQ6eiPD98ZczBJlJj7heK75+c4x2ns/aqBL6/a6QJYbFTJ5u102Rx8441QyAJybOstwN3W7Oh/OvTg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NCgRr/ctDdWrmszo6Ndqo012TdaiyPQpAg1L0ZUH3MRdyChUkxCYGTR8x1tk?=
 =?us-ascii?Q?mfYJULs4OIbbwnaBuhwTEwrz5R/VeyuYr7NeX4cHwdt0e10wmnajGYa9MzHq?=
 =?us-ascii?Q?5DYVBU3y1MmERQO0z2JvJpnNfThhkTqylAZBy2W+ju+DFlm1rtTFXIbsD2NS?=
 =?us-ascii?Q?Ni/qZsPqGiPGWxGXmfPT22xivjFXwXlElomDeqEPBe0D1MDqaTepNBMep23Y?=
 =?us-ascii?Q?EwZsnrsofwD16ppn9GLCuAR2KRsr/wkxOqiiNPG7rYYdHWDQf4m2pDlEoWyV?=
 =?us-ascii?Q?9cMEJjwVueg1X9Q/rPQQ50o74RjwfR3UcBQ7aG+2kK3Vw+uZqc3cQ92VKjsP?=
 =?us-ascii?Q?pZ+y8QdraskCYMyhBdwks+ykP5P9fZ0D8G2osN+fy4jURCwhsfqqE28dsP5Z?=
 =?us-ascii?Q?/FQDh83yQ2Zo0GA4gdu5aVeeoFZw3t3b57zsgeXpewXO6+G0ckM6WRnAYV3N?=
 =?us-ascii?Q?r5V4v9dzIZy8OGSnZN04oOSiu2Sy11SDCz+5kfjqLR+G7xuZOYV1MO0KGWaO?=
 =?us-ascii?Q?/fb7MOffqtgmj6K7qqJGRRJSPbGLjZu5TUzFJC0IAEAyQSQNDsyNNsW7hSbi?=
 =?us-ascii?Q?qSrCi6TZKtekJR1u0+8Ab5zkNjkO9c2I+TewXbVDV2khiZFv0DLx1C+mNqoA?=
 =?us-ascii?Q?gIr5fe9n3tTTVA7ys/xZI6pK3TDTBXeRcfzlzxeTr/PoMF9qCEEkSN1U1sdI?=
 =?us-ascii?Q?6gPg9boQyrN28mEF2PS73ttB318ekSmSmrn2AwK7L+ErycbeFA7O0MJZjljz?=
 =?us-ascii?Q?6NegfPAphiBziXG95OvQLdmjcTNFURqtnlQhkT3UWrgL/GhsYRfCBeCBXnsN?=
 =?us-ascii?Q?QxduHK2zLAHvFUdWnMkmiIQ0TPaVnaayc9MGh57dmeT8+IHNeOl1p1Aqzbzd?=
 =?us-ascii?Q?ti5uMPEhAduH7N5SZxH+cpb7xs6W11VaAWws1sG8/v+2J1UOWi/rlZcyFozW?=
 =?us-ascii?Q?FbXzSBLpb3yBJtuIVwf+u26c6523I8xbQig4F1VG0fimvPDC/taxQjoVEjq6?=
 =?us-ascii?Q?tuOl5OvZPhX0IUtCJAWP+TJvcue/B1p9YHpdFs0hUH7lyTB+RCs6jYQOsJP5?=
 =?us-ascii?Q?lkDrLXD8hSQkz0l2XObHR41VaY7NlZ9aAzGDRuxxRUtqKOuAlUyW5xE4Y1MF?=
 =?us-ascii?Q?2snPMUsUNnuMnlPmxhwb8z4zlwiA/vx8jlj1QDSaaKgN2KDttPXLFQGR7TEk?=
 =?us-ascii?Q?W4JUO9e/DPJGLL49uFqlvTBbd6Rb3aNHJd3DKAIzEa64vv0iNLhYeH3RHu4C?=
 =?us-ascii?Q?wbTBRJuPWWCoTWDmyMsCXim5Ym89JdtQGKuupTEKOF8BvjVIiefXvzfwQuDH?=
 =?us-ascii?Q?GLN03EB6Ea3vCTdM3dYbsTN0ehW9tbsS5XwB/5SrvQtJbOmTulu6VGsEwG3+?=
 =?us-ascii?Q?ApU4UI+JzLjcT1TNhFxvY7pcELRMdvhdVa1hEMNVqTsZiwBT2QgvwHOvBIUx?=
 =?us-ascii?Q?MBVocEsDBqI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c524c59-d938-4c42-ba48-08da34ae47a4
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 07:00:36.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ylintan <yonglin.tan@outlook.com>

    This patch add VendorID/DeviceID definitions for EM120 FCCL project.
    It has the same configration as Quectel EM160R-GL and EM120R-GL.

    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
    Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 8416267..0a6469c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
+	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
+		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-- 
2.7.4

