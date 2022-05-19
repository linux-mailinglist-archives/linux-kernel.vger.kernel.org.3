Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980552DD30
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiESSxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbiESSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:52:06 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FD5EDFE;
        Thu, 19 May 2022 11:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYfW7UCZdbt+fL/OtvnKphOn0+eIb/6rxshvWJaZXERMovTlkobLmqUl7Jvtgwv/fwA2jN4VV1WW7ISVB0utvqmCz6KtdjQqoYiHEmG/BO9SBuV5UE8CPG7tMjiN9DqLHKteqH9aQj4mNuwQely6cd6e1zU9sVUX9IJ7S+3NeOrwyEFwCY93FCL6aGMW4YskOp8voQdD0xJtNkPB1QFGCjMaT6gVMIH0RH63gPKWcNA4CjlbP+yolZdPID4QUCVfL5Jb7tzxuNnw8vM+caoweG06PrDrDtPmcZVrh6oihESbuDtClW88jQ1rwn4KRN0FdJ6Bd8ABdr99bahAZs71Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sIk5q85yQq2uTKia1ZwCqDKBQq6HgVhif9Iv7bGGBY=;
 b=jdy2Jy2AeelxK0s7aftA2jTkc4v2OynLF98wS3ZUKrYXs/HRsQg6ocjwx6XQtu9htP8BACYTJGQWAzQBCQHBeVeuLMluerLt06c3FMBCmKfa9HrVv/UBygChpTBUKQHclqZoJkLGkEHyXnvSxkeZBz7c1uKkzI4pmW/KH/Jdvv+g9kLtjhyuhunzZY6SWBepRAJjXh9x/JDb1878KGN9eI6A7CtckmFimfoYw+Al4Q+GLs5u8pFIOicg3f+bA0SI1gqrLgrpYp3VMpIhIFr+8LtqGRkmgMR6PU0RV3ipgiLnBpTgRCbo+cl7lcnk5e3xwt4HykTnk8r3qCFxdh9rCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sIk5q85yQq2uTKia1ZwCqDKBQq6HgVhif9Iv7bGGBY=;
 b=OMaLtagwaXQxC5m6f74rDUcbokP5BvEzDAajlGO3eGzk/VzQEkSu7jr4mFnLeyd6dnYDZEi9TsvqB3SG5Hgpm6SPWnE3lmA4hOdMdCpDpH1UtK1LA+19ixelkoRgaIZGHkDgTIOTLkxToXKeuIgSBEX6WoIOpLWJVNbbbgwfeP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:49 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:49 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao-ying Fu <cfu@wavecomp.com>
Subject: [PATCH 11/12] MIPS: Report cluster in /proc/cpuinfo
Date:   Thu, 19 May 2022 20:51:24 +0200
Message-Id: <20220519185125.11686-12-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dfc7e15-7b79-499a-e963-08da39c8a0ca
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB25467CB9A1278D2BFB7DD4C2EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p54xtRdY0xXKlAukpW26qwlPaA8RxoiVV3bWxK8Y+qU3HauZerAiqUx8jvgTL9kK1XiQBRKTP08YtPwP6gOr9MNL5PAg/GNnpkhyaIuwYzWsEScNdmSQulYZjOwstkpYl8SDhGNpIJFuPh1UvCrDtEaYH/TrVAu7jagozQs41xIycC9lDqrf0zeZpyTsZcS0euvp3Ygr6hMc4xHbFMyV7PNrOcesr/4IREkNJEMsAnbAW4G1gHeaMC8NwTjCdJzDtFlDApf4zwWoSCq0eeqrlBDxKVax0C5dfWrb7VLF4d/8f49rpFw0TwhMSn0hp4C2V3xCaqxKHBKKrulRQQQi1tp2Ti0N1R9uAPb+b+3PNL4ZFvz1R+VtE2l7uH4MYIel0XFVryH0tSGv51LyCrzRZRbXKU8V/B8Z9tSFG60aNMjbtZRsQeuT6mxMMFvereQ3H8N7X1m3Hfs9Ww0Vm71adTYUtwHAdBkTvWmighORaPXM/Q8S4PujHlOq2/6K2SghthJvec/coKnfiLjojWRIb3rRcloN58ZhvUkRJkJa8pu3KRXxXrHQjlkduOhfXbnc6g+sr6fbiceXRxiiBggEI7vUKmCMFEQhtKF/qgDISzL8FLUDx0DPFDmSPHOR/83DmD0RLgbVKo8qUyylTdLl+3tkpfm1b8GWAVNKl/JWIYMhMcDLxfr3E8W7KGhia0wqqeikP9QV6cBefl0f5Dx2sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(4744005)(8676002)(38350700002)(4326008)(8936002)(66946007)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/L+kARcVJ2+GfMTM81nLVbrcOgm2BRvsIEb2igmx367A5gmieTyz3dLD5ijm?=
 =?us-ascii?Q?QNFHRB0MwQLWdYoJy6fFUiQCTmxxK1UmiDh63co87MieyB1GweiIuH7ezbel?=
 =?us-ascii?Q?hJI1F+yp3lFyvFQiUD7BWc/mc8vwa7kTRYc5O+yFyjSaUhNOyqIRCzvkIlOw?=
 =?us-ascii?Q?sahmE0J5CLDTtr5ZJTfsF5j5nJpiSSxT1q32cgCSCN+7cih7M0E8toBV5DlL?=
 =?us-ascii?Q?/ch8PyLQ+IuUUwTti2siB9ROyRxvpsej/5sx6wEdIFMjAhhJ1bAfuCa8/XuI?=
 =?us-ascii?Q?6scOQtYanr8bTOfLGWqv1n/O9d0L5vx46+gzRdDpaYm5eeT8QDiqzYUrjjBF?=
 =?us-ascii?Q?EKNjxpGEDM/UM3taEuo08WngqYG6f4vYh9/i/6OruWNGYjcJ+n0/ajxn3JsM?=
 =?us-ascii?Q?GHOAeMLpTwRTe/R6xVP4+37Or5TSuJmGl9i1qmVEmW7AMwpSz0GfnTYSDXZt?=
 =?us-ascii?Q?HsdCrO2zeHa6rqWddcv+PNkZFDg+86XtO0Ybuwf8S6x8PjNcyTjc3AORYnlp?=
 =?us-ascii?Q?G2ZJlYZ3H/euQsbnB3jq5Hhm7WzL07nQOcbuOJCD0ykAtbD7PyJZ2975S/UO?=
 =?us-ascii?Q?K9ori+25IzOOsXs96dhiD+p97PlOEor12DRBVA1qbfTamouPrfeXpnSpZmk5?=
 =?us-ascii?Q?3S5BAQrVIx/AWuMR2JHRufDX+UHx0X1HmobaryRndDB9UdNoBfiWaH40Bok5?=
 =?us-ascii?Q?3E8TxdTKqZBt7Xi3E0M0EH5DGs5KkMFBmd7vjNzw6uuOwh5G4UtXJkfUi0/L?=
 =?us-ascii?Q?iTuTUOKG6fw3Ln/0z69gk2OhnQgZBI3TfqRjec8r6upaVD4TR6ADk0SxTeC0?=
 =?us-ascii?Q?1DJZ4hzm7iT6q3taDS8PFvmcd80AWtaGe2LZl74WjggYrzLjvbus1PuFTj0J?=
 =?us-ascii?Q?eDesqfKjCK7T9Tnsrs8EW2rLFMM2fThY0AImnK1ZG6J1NtreBykiSy2ybKwX?=
 =?us-ascii?Q?X5U0F/lfIShFSD2/MDBHbZz9zh+YpQICLLVysPNWMK/uAaAf8gvAzfgPuBQ4?=
 =?us-ascii?Q?yRaBVLuRYFJrprDKl67BaNlpit1Z9SnmVBmX1W3iTJ7mgx0+APL45jlXuenH?=
 =?us-ascii?Q?xMKRX19V8bqSqLPIX9Os73xnz0IITCTRsq1+Ae/mT3FOhyYd/ONWZ2ePwSQx?=
 =?us-ascii?Q?AobSw7WMcDcm1j89RiIQG3pk8Z+Xg4grJI+e/IEmO+sm8g7w3rGpNoJRQ/pR?=
 =?us-ascii?Q?fjOq+kTfnBR9Y5Hf9XOvHqYkRz0AWXjYzg5qBhKy1zt1iDytRxPJTEsfnUNT?=
 =?us-ascii?Q?OnpRYK9TSsIA5X2VsBTNkalP3Pu+/Z9oH4FfmKynlABectyupZVBtqWx4ppq?=
 =?us-ascii?Q?sHUCPB/EW8+PnXZ8MYlTNlcAAafDfe29DWoskENKPVHY295qD+X7mHH6688O?=
 =?us-ascii?Q?gKAEjDcJ4GvgtvftbuDX5XXb8LH/yzu88WL3/5+WGBuaRbeCAFOjP3STEyaS?=
 =?us-ascii?Q?bnSSe2jIQ4uBKhNdWbt5f0b6E2XTFZrI3Le4e/VIOMetoh5Ah0is2+BQDYqj?=
 =?us-ascii?Q?8LPavGjyhbbojsoFNlzHjU3GtoeQxTMvdWieWOZqfznAfNc3UiCtkL3yF+pn?=
 =?us-ascii?Q?5alkJfzChikKBsjhnlJHCn5HmFwsxyBhiKSH7E3MmH5bR83mzm5CNjGVwlsf?=
 =?us-ascii?Q?d6eQha5wogmPvb8m/h3c0bOA0j36uw+2Thu3M+TI2fArEZO5JC/GymcUWZ5Q?=
 =?us-ascii?Q?vfwUTvPcvTGtzg4Wq/XKM5RLXiezm9edC28J3kmSJ84ydu5yBK7hg032XtdY?=
 =?us-ascii?Q?OMcfX4JHakR3MOyjdjBxifsJ4qYvguvBNsYbW3CiZmr7LizBCrVx?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfc7e15-7b79-499a-e963-08da39c8a0ca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:48.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzN2LFE1zuBTHUOra/DhrntNuGopN4xyg/rC/Xv2o0tcYHevHrq4akH7Qxc3gE7GTQ9NXWPoyiKCrfpgSBzE8Rtc3G1TKE1weDMDYybzTDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0301MB2546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

When >= CM3.5 output cluster number.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index bb43bf850314..a66e7705315d 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -12,6 +12,7 @@
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
 #include <asm/idle.h>
+#include <asm/mips-cps.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
 #include <asm/prom.h>
@@ -282,6 +283,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "kscratch registers\t: %d\n",
 		      hweight8(cpu_data[n].kscratch_mask));
 	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
+	if (mips_cm_revision() >= CM_REV_CM3_5)
+		seq_printf(m, "cluster\t\t\t: %d\n", cpu_cluster(&cpu_data[n]));
 	seq_printf(m, "core\t\t\t: %d\n", cpu_core(&cpu_data[n]));
 
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
-- 
2.17.1

