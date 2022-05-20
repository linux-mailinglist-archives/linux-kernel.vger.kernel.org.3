Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B152E706
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346838AbiETIOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiETIO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:14:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2045.outbound.protection.outlook.com [40.92.107.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0105A179;
        Fri, 20 May 2022 01:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btiJqRxJPUflSUgRz1y8JLB/JatOKdC9KK1LD96tk6+ov1nNDjtVzCZjd4Tz2nlHXV1xnpjav9okQxFdPZtzTxiQzhOab6M2gpjZ26DdUk1Nb4ztgfcXZjsIgdzsMzfh6P3RVNYdT+nRH5OsB7p0N2t7DxdBTlnJVjzAJhV+Ui7IenxQX1KIOjcZKp+np9Ei/VI5Af1XARhvSEYHnFHbwwlo/F0Eb9Katej279dHyymZoXzGOSb81MKokx3BNtvxDhnzJX3a2sNC/vWN3rhE9E5n5htMbHY90sPv+0fTuvX6d51I6/DSCiXabDbPRzND5g62pnGrFDN/7hipu28ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3FQz0N1lLDeDSHea9jTgV7cSBjWlBPTsACYgBxyyMQ=;
 b=YHpf03Gt2W3iaHhsoW+y3QptosdrUgMsYrKAz7yoIxNj9keku/GsgZa4OFIMLU+GQ8Iio8CKqVMX+7ITajRfruE6yjVT0qLdAX9SjZVEIwzf+PaNxYGTqxdp70Mqb77INPUPEMaGJ5LlqeWjUsG6dKNd6Pv1SStNft3hq+7lgDXhI2NBPbcQebIrj9QIcwLWOLiZysBh6J7LWxseZgLaPFoFNGkQfARiLzmCSkETyaECbHwC0M70MzK0ggiPpCvLVu2loCpmgOOcC8grKeOa8oDgvGhLmhg+Gtu6HEsV8VKwl8CmI5+MMzxTnHYgqA8f5k5me1LrobIsr1htMGZnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3FQz0N1lLDeDSHea9jTgV7cSBjWlBPTsACYgBxyyMQ=;
 b=qRXdlkcLD4l+fMagt1fJgQBj7LzCYAvEcZNghdY1V3AFD3j/uWP8I3K+jPLSXgJJG60ZQGb4V53+/3lbJeC+GlUqu925BY/qBaD/a5R+jDo8fqks7XxkxJFvWxcpvYdYGU5MoBtmzGSnk/M7pD4uAiAdS2+yjsforQamsqkx4jKB0jUbZHcJhT8rnytxgiCeC2fFo1ik/5hUwWE5Tk1h5GEAbzTBUevWXmW3IDCDTQqwyFG28yosEyeVhRV/dfTozXMM77tOm3YXeARy+HW5Dm+mgfKAly7GLm1tmzjFZucywLI744AyVanGy66qHULPg3LeWtQBmBmRq8ko9VgN7w==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SL2PR01MB2891.apcprd01.prod.exchangelabs.com
 (2603:1096:100:4e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:14:24 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:14:24 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] usb: dwc3: Fix multiple checkpatch warnings and typos
Date:   Fri, 20 May 2022 13:43:38 +0530
Message-ID: <HK0PR01MB28010DE795B6733D3DDF6EECF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [blfQCaGozJ0HDhOk7LPB/DFmOY+N4NJFwPjfApNAifY7TK6U+I9EuVFQkfndCNuA]
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520081341.16768-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22513a00-132b-4867-69fb-08da3a38bfed
X-MS-TrafficTypeDiagnostic: SL2PR01MB2891:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WGsI459yREiyPcXmxvn2HVAcDk88f0WpozlzqP85yC4euD51AQDCsFsnMWf4ZB0W30sbi3F3rgSVaIIrxJYt9+YjxyUMgQt6KPy3/jQTFB4FK0KKrKJ5U2Aspg8e7XVVZI/g39VqDPZyKsWukWofiU2T0A2dS/nWypGemWLS4A3Ox/X82nKXjhDSlt3hFpL6SJ0o3gq3N2xICWzwGLLNCy2gY6KK6ZkegYjkW0Qk2vsFcVaOhaMC+3cBcKbt1ti7Gm9CWK5hynSQNcZA8CA4X8ZY+f+3K+9gmD20DywCKlgreNzcMBpInhoU/zgUksmwijLlN8u8wGd7t/0X5p8UR7of90EnfQrdsZrtgnZECkZb/nZKvwrvQVpPqeRTo3L6yI7keGZkBspIqYjREurt3MeTm9TBWmQr4UWgI64O95U4G6+lfd6NgcKCkZqdyzovOP1xQCyGto/9Jtr0I6gj9BljSU8lCQW9KgBo7HB9D3nXkGTlsRR1OIgdvUhFhRM1cpWgXn/LfIiSdPr4LcTtjRgRjyCysIVL6uBlove+bqjgiRd0tMpDO5Goh2nMF0Df0tUlrwrCMZILEVHoHWJeQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qflCnJZRTkjD8g7FOgyOIeJqOjQchQQdqXVF26HWm1z8NWeBlV5ZkKrZx9r5?=
 =?us-ascii?Q?a3I0e7Ine609faBDIQthLfv2AQ6WDAw5Q0hICyvkQi4zLVUaO+Y2ElKIfL0Y?=
 =?us-ascii?Q?oA9P5cgHqf2mW7M3SRxI7VCX3seMukjjTp23n9c/d1Tm6pWO0Le/oE4e6fV5?=
 =?us-ascii?Q?eTAI0QlWsk+GFkmT83LnTlrs/EtmPqDaLfEfRPWIuWF+zWlLwBes5wv+T6Og?=
 =?us-ascii?Q?isVf+HcaiiKWL74eZXEupY012btD4PnUiNhAzI1g3oGvz1BAOOJlDHco3LvY?=
 =?us-ascii?Q?SWVVjc4vz/mpvJI+sDOpf47L3TS1DikYb9Dq80PbuCL8RZtCXXB+uKxx2KBy?=
 =?us-ascii?Q?+wz1bt1J9M74gPj9+0kx/M2N650lUclyV8W/r3Itk5RTTQYz5qnBvPaqVC5O?=
 =?us-ascii?Q?QhNwmhrE/dHLahlmSNQ6XU8Bechwo2ETIgOiAE12sCIn75mckWxBGsaJkQe4?=
 =?us-ascii?Q?odo4Y5uX1Pwj6wSIiHm3fZpBHRQj6Dt45448IrBEPhif6S7iyb237/Oqgm1Z?=
 =?us-ascii?Q?34CvDDstddcsq771xGXOfgc+2mrkvtgYu6cVbDLTIBiX/3uVTPdNsKTfYlb8?=
 =?us-ascii?Q?CBZ+2BYmi5rZUgdkIkGXDfHNeXfxZIDO4et1lhJIKwrjFO84zLUN8kx81vtw?=
 =?us-ascii?Q?vR3JYQA+iW+QZEoS+Dku7sZJ+MjYUil7cDK2VBIOx+E9V7M3tcGpX2GDVuwK?=
 =?us-ascii?Q?BxVdXM4UeOrLVpt3RmxaNLyLn+3JeXrfmDUvQY7v8g+tV+yh+AUO/1I3HyUy?=
 =?us-ascii?Q?eddtRWeqrpssZmLT0TIQpLi+R5l3u4oZ6BQBkq7Nf9XwXoDnYZgAtnYvHKWs?=
 =?us-ascii?Q?4g6+r+q0haI3kmjJxR6ibyVIT9hDTBNDdnHUXM1xI1vyJT51wIdH4tGL9uKI?=
 =?us-ascii?Q?FIFdAa2W7xT41XZ9XK7VLd+yGglIuorNy077lcDIFVqL5oZrla1SliSL6dwV?=
 =?us-ascii?Q?r74hW7xZTShDXJ0/fAU3OVuuHrRjbusdEy+hIOY21Rr3y34b6V7/QklhnZ9p?=
 =?us-ascii?Q?9AaNaDMP972hwEk4bVcTFMaNqVDYPCWzAwioKfaERXWWtgjnNCIXuqCF5vOI?=
 =?us-ascii?Q?uUJ9TlGdXSSmcejIK08pJrGJ6EHFLJo8MRBV9b/IV5/t8ksafXY1ENVBtWun?=
 =?us-ascii?Q?dWhtdvD1tfETP9lvMSxOweGj1QQ1F0AcNKxxh/DJU4DuY4d4u0legTCvwWm9?=
 =?us-ascii?Q?ClnkcCgWqO49E7aItsV6JQSGQA4d9qEql5g8CajGl3NX0n7pJ3RWjtJ0invH?=
 =?us-ascii?Q?ka/TODAmQfpRUrTU3PcfxEvXRCt8Kp4qROxrZ/iX6EKThCreYUAyXD4a2NT9?=
 =?us-ascii?Q?+2wGsSsUGYgFp85MBU3u9jDJMrbPzratB9d/VeLeqS/4Jbl+lVhOokabBExR?=
 =?us-ascii?Q?mhf/j/tgBq+G7UH7tXd32VClN2jhjotuqSzaQWVCzsvYtfa4c549NkAypw0s?=
 =?us-ascii?Q?gHABJ6I8wp5846PKqqvZzlvD5NFPffKOk472tcExJXyEFCFaDeW6fl5X1XeA?=
 =?us-ascii?Q?ZbxpjLnfQEq0W6CvNZTAG7DYKqVWpBYLO9Da?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22513a00-132b-4867-69fb-08da3a38bfed
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:14:24.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR01MB2891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes 3 checkpatch warnings and 2 typos in the dwc3 driver. All
of these changes are minor fixes.

Patch 1 fixes a bare use of 'unsigned' checkpatch warning.
Patch 2 fixes a repeated word checkpatch warning.
Patch 3 fixes 2 typos in Kconfig.

Kushagra Verma (3):
  usb: dwc3: Fix bare use of unsigned checkpatch warning
  usb: dwc3: Fix a repeated word checkpatch warning
  usb: dwc3: Fix typos in Kconfig

 drivers/usb/dwc3/Kconfig | 4 ++--
 drivers/usb/dwc3/core.c  | 4 ++--
 drivers/usb/dwc3/ep0.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.36.1

