Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59B52DD28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiESSwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbiESSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455245C65C;
        Thu, 19 May 2022 11:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhj042NoiXi16DSkEDTjTxZN47CoYKL27jhSjg94O5RnnTQWP2aA3cN8L/+ejKoqbeaOF0e6gT6tB2Ek+2rzur8DDJaz8h0QzLw/rlHxtjxL9CWVUIeQAwBar3ut0CGdO2CaD3nRIy04rT/u+ke7U4fzPPu7mBCtpjJ+tDfYARfJYCX+ynIevwj6LT1vJOAEFim7klv1I7+hBRf8zVL4hUoKVtIr2/CTc5jT3lKr0ohap6aVB5x2bbDfCUYUipK715cnHSYdOViQnIakzDC+qJaFlGVjKHULB/RJN/mnu3+qVOgxH7SEG0gLedDscK0GHWtqFADaFrqpLtgC//hLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpnygunjLPTgcdD+PZHB/hkRd2TOXdJDEF/tGnRmUrU=;
 b=Wf3/qc1IdW+M0brGBVN7+DfETeRgiob2a2L83xsekVdYa7ua37IFOmj4YG77TlnqeTIFaJuw105T8+qS7WFXttyHZgVyXGNv9H5tk8qw3lg+rDbOFximxeowX3DXwQohPyNxGPqny7VT3OZG6rdWPelpAmt9hxUoSIHjMwF2QtXeWsqoLFPiyw+g7o8qV5oPCRrMEC4HK/WIvWYVhGX3fT7MUtXdKmbzJEAa1PWREyRSI6ppJEUe3M5nYr9XLQxSSQw5Yzc+IDWKvPAUv6Ku/uncJIDp6VrB6EjqODMLH+UF2H0Gd9lklB/d8zjOqaRCyL1HcRx5x8hmJSVStpXXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpnygunjLPTgcdD+PZHB/hkRd2TOXdJDEF/tGnRmUrU=;
 b=swOe0pfy+4xXjHtSOqWGAGKQUksSlfvWSS4Uft+w9rWqCtDrtT3Lpd69FQBTMtweL/uKdIC5klT4Oxpnim+E4kgcGtME9Zxj1u3CH9derO9FAM06AaXkfy+T1IJCgDuwfR7QHivKEjqQNYYKK2wZ13234dpHhZrRq6TIW/W8SGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:45 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:45 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chao-ying Fu <cfu@wavecomp.com>
Subject: [PATCH 03/12] irqchip: mips-gic: Introduce gic_with_each_online_cpu()
Date:   Thu, 19 May 2022 20:51:16 +0200
Message-Id: <20220519185125.11686-4-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c10b9c3a-7dc7-4848-6c45-08da39c89ebe
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB25465183D4F95E3724EFFD41EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxMB5jxQN8oatimfeuNxpNN2HTPY57HU7kqeWKJSVo0xepiSq9sAcPVFLk7rf4sn+NyLGB4UGMleyXhYMcGEDfP87HHNZjypQnqDt0FnH8j751uFkiaAg5NWVN6uf+p8qmUCxDxP32H1sSgz7FTZKw8GGCZ+lHUvIvRD2f6tm4q3iXp2DdWk6lg5D4BYhTjWyZMEWgEFizjMhjbB5uEHwO8jWwyeHcKdE1hsCwSME6FNiqSNvXf6Bt07np74GdWdJYY/PIzueo0/9aWR4KPMz8q7OjidAwqosPj/9SFxqXH9/1W+hlVjlgWN92Ou+llpmD4FCMKIolQyppGSgvp8IXHqBHCATln6INPnREvZmAcyyZBJUB++T2d6rW2uWWXndy9+sMZr+6S8PkOcx/f11h4TrTrv6w9dav+QK4BsIYkjt8etTVz7OLauzcXnpMkTuwVLvEEnbb6VFvM1YuHoug7z/iXR7RMeclX8FpYrQpWtYegccz14qYCmlodW/a8ah6FdpVmf6unsyDt4owfJ61yTxoO6fbGlI4ynFjAq7LKoY2RqAxKHcVjQ0XC/pL4EPpF5cwDKJWWS3fA9asQi08yQ811Li3G4QTaX2fKDtmzuimwFlWbq1dQ1HOzLL0aCbktD/9XhYQiOLYE4KDI8x6jEZEli7XfBgUYrQ0Yycu4s6hR9mHHSFS5aogR1jae72Bk/Hy3fqgzLMTs4kHk+ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2FlK2znprpCLrlS6K1Aw+1JTeqy0gc6jOdHQlFJafvkGEsbKERX0M4Gbk61?=
 =?us-ascii?Q?FMBIA8N2fmDgnaTnmJX/BGyRZ6gFYvcs6ISkZRZgqc4CPsuJxChNGN/74EFm?=
 =?us-ascii?Q?fR78gbcCeQUO8p3AOnLnGZBIJOEcRQfnlqp59H98+oY6Gq5ve77/NPrnO6H2?=
 =?us-ascii?Q?t2hzK2BUwkyWH0iO1a7ytB+JieD84GEpTShy35Md9dGodJqI5P9sOdyV4huu?=
 =?us-ascii?Q?ZBFsK2RiGWMFOtcbmNvQ2esZ9oKboGs84zqDVvqLFFMwD+EXT7D2SQacvqSh?=
 =?us-ascii?Q?JL0flg1mVmEywENpIsuUmLlgvKfYvO9IkS5mFhOdiKr1HFlqBYY37stoehRI?=
 =?us-ascii?Q?kP1100cXAb3xBtdCvSqrcceATC6t3+XIrVf0EVwWL5KGj8Jr6n1Y3zNfeueu?=
 =?us-ascii?Q?5a16WLwpdG9BMcA6ybWLSVQ6q/8chZdYqHr+LihYAExLthVcDEkpnwbiA9sP?=
 =?us-ascii?Q?x/S0fDFwYHlEKfevUdsNMQvaGkVT/RNJf0zFbRjdEcUDvdzSQROiezvNggm5?=
 =?us-ascii?Q?ICde068TJuleGe470YQjn0vn5hNu+BwDk22ZCQ5mRD3k26SZFaAcPkG6RnNm?=
 =?us-ascii?Q?90zZdDbTS+TrYyt7XaCtY0/Z6+A8uapYZtVT0/HhczMCtEdfQPDyFKVl8ldb?=
 =?us-ascii?Q?CYgUZxnWSThd/NP9Rmd6S9n8BfiqEZwv9k8SeOnJL58RxCv5FMv4bsoTX1+P?=
 =?us-ascii?Q?5beMbdNLus5r9mHtTkqdzNp43utZjSuifP/yJbKctV3aVJ70N0dLA8a6nW9N?=
 =?us-ascii?Q?grzbJU7BUJmxo/ZPI0Xh6jAnbXXVRag4fyZfz8yA1sZp7nZQ9Z+3RSYVaFB9?=
 =?us-ascii?Q?J+Ah/1iigjaZbYcxoIuy91+D+u2CwcUMA/XRZ9B4tvopXTBK8WabZoW+kAIS?=
 =?us-ascii?Q?uBGM+4xOOyFZZsRU2gZeVSWgamkg7CefZRovywnmOva7Zllz+91TE9QxKwZk?=
 =?us-ascii?Q?Wr+jJicMsm5TM5VkE62+WQmYuQG9A6n1Tgw5n4Uy4woGSba6ZZL1uXxRIIta?=
 =?us-ascii?Q?4ooHdbzo1pJVS9GpNH+QzR0TBDPLrhRwi+8Ei9e5y13Wv2njpKOW0rG0CW5W?=
 =?us-ascii?Q?PePjgClSdekAOfm6qIAV78NcPPRkTKZbUxngjG8POoWdjVVlxTXUe5pMZAa1?=
 =?us-ascii?Q?rtg4HKOPWa5XTDnydMn1KEZfDJbfaHdLUe1DcKqx3vmB5YqYm3UfPfaW5Oxc?=
 =?us-ascii?Q?HppOSVGkYXY85dxGXGMZ5ya//DkfroUnFagzW1j13N3CwJ6cq7DUtjLmShiG?=
 =?us-ascii?Q?JgE8mYKzfbJgMxvxGlKuKqkUrJBoa2frV4hzfaGEs1yyXHE1/k7AnEHOmyZf?=
 =?us-ascii?Q?JODpMB8kiWUIz2DtuHXE7AUV3zt8DdEheKxuok5UEKaE3HxxKTBMGuTgSpYi?=
 =?us-ascii?Q?GOGQICqnJAH9PukTHzVRWQS/i/XqfIdssPl/mQLNoVog+RGTmh107wMnD2aS?=
 =?us-ascii?Q?qzd1xHhdDezJ4XuDfi4sULS+se6uT6DUGhOYeBjgWUeV4SJvVkveUsvxepZl?=
 =?us-ascii?Q?BhljCiv6sXoVZXqKATbd0PASbF9PXdYGnsm2GZJVBSGonMFmTmcD1XO/zJNv?=
 =?us-ascii?Q?nwgCTFbz22TdRG/C5OGJB7UjTBXjcgduA8Z1SXhpOGn1UDOG0x8nPOZt7i9P?=
 =?us-ascii?Q?PpG7W6Xf3ZBoADWbkqvRXthHgO3c/OuCFHv253S/8i6HszeF8U/FUSbtVw84?=
 =?us-ascii?Q?89DKkCjZytBzo83xKU41X2diqx4E3E1Pqr89W2taN3G43wjCQBdNYtIoJTRq?=
 =?us-ascii?Q?NrVYY7SXv840EuBMXhqFBHgtCreIoA4=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b9c3a-7dc7-4848-6c45-08da39c89ebe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:44.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpi0vRL+tttoGcXbSi5nKgTdih/yAwz2jqUt2dEbU0ISYohkQdWAXnsUMezmTK97d3aRDzW6L2WJcrpPWan8r4fbVUkFfG+j+oZa+f86pAc=
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

A few pieces of code in the MIPS GIC driver operate on the GIC local
register block for each online CPU, accessing each via the GIC's
other/redirect register block. This patch abstracts the process of
iterating over online CPUs & configuring the other/redirect region to
access their registers through a new gic_with_each_online_cpu() macro.

This simplifies users of the new macro slightly, and more importantly
prepares us for handling multi-cluster systems where the register
configuration will be done via the CM's GCR_CL_REDIRECT register. By
abstracting all other/redirect block configuration through this macro,
and the __gic_with_next_online_cpu() function which backs it, users will
trivially gain support for multi-cluster when it is implemented in
__gic_with_next_online_cpu().

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36267dd..4872bebe24cf 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -65,6 +65,45 @@ static struct gic_all_vpes_chip_data {
 	bool	mask;
 } gic_all_vpes_chip_data[GIC_NUM_LOCAL_INTRS];
 
+static int __gic_with_next_online_cpu(int prev)
+{
+	unsigned int cpu;
+
+	/* Discover the next online CPU */
+	cpu = cpumask_next(prev, cpu_online_mask);
+
+	/* If there isn't one, we're done */
+	if (cpu >= nr_cpu_ids)
+		return cpu;
+
+	/*
+	 * Lock access to the next CPU's GIC local register block.
+	 *
+	 * In the single cluster case we simply set GIC_VL_OTHER. The caller
+	 * holds gic_lock so nothing can clobber the value we write.
+	 */
+	write_gic_vl_other(mips_cm_vp_id(cpu));
+
+	return cpu;
+}
+
+/**
+ * gic_with_each_online_cpu() - Iterate over online CPUs, access local registers
+ * @cpu: An integer variable to hold the current CPU number
+ *
+ * Iterate over online CPUs & configure the other/redirect register region to
+ * access each CPUs GIC local register block, which can be accessed from the
+ * loop body using read_gic_vo_*() or write_gic_vo_*() accessor functions or
+ * their derivatives.
+ *
+ * The caller must hold gic_lock throughout the loop, such that GIC_VL_OTHER
+ * cannot be clobbered.
+ */
+#define gic_with_each_online_cpu(cpu)			\
+	for ((cpu) = __gic_with_next_online_cpu(-1);	\
+	     (cpu) = __gic_with_next_online_cpu(cpu),	\
+	     (cpu) < nr_cpu_ids;)
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -357,10 +396,8 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	cd->mask = false;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	gic_with_each_online_cpu(cpu)
 		write_gic_vo_rmask(BIT(intr));
-	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
 
@@ -375,10 +412,8 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	cd->mask = true;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	gic_with_each_online_cpu(cpu)
 		write_gic_vo_smask(BIT(intr));
-	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
 
@@ -532,10 +567,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		return -EPERM;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	gic_with_each_online_cpu(cpu)
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
-	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
-- 
2.17.1

