Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9162952DD29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244189AbiESSwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244108AbiESSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744A5C771;
        Thu, 19 May 2022 11:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9mnTtDuf0kX0ZsGqIdzO9muwWmnRxUfivla6Tc8cSeVzO2GiwIeGPuZK8a7c/xDY/O+eb20fflSMnm0kB096kfXvMHNxH4ggmNHazj+QCAYN3c7pJoadA5bt/7dSsxCfWK+ELlcOHEmTDbTfRuJGnG3l0cPmHBRQhMLJDMWC0cDtAYROq3vd07oi8VZEp/yX1m59n92kwnm0S8fXbcW2jAhYvXsewIN20j/CyweCb19QTMlieMXpEtEsDj9ldhA87ZeAAD7BURDnYfZ+bPuU07fD4K19+jYWmH3hTR6HJA6w8iyoNacH1ZKCXEGnE2WQquTlR8PEJkL8XXjwkhZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqYJuPuxhZFRgN72gPNdJ6Q8iVgBtpzNH9qxe3xIh6Y=;
 b=ZqHGUgQl3bkakwPyDhcD/uDnL4ZE98RSYQ37HPJz/hRVYaCUJYQc9JQFK5bNuKvo7Wf9j0De6p73BLIq8H9svfieboHoWNMx1KEqP8K2YOLCaBDCJKomHWh8DyRR/RC3tCLQjeFVFVEUCsbvXOTjcKsgnxdeKkQtQ9m5UlehYR4XkFH/vEjk8dVqvyLST3sALYuMpufnXTdKZ2h5t1I0gUk0M1iwIxgfWdEESEpCTLBdNgjBkhftuXJGUK6d/FnQOBzzQsv6O30VT8B6+RNDciMuV2+h6JIOWMO+rTQXuIMiqv14MN6pfB/v6Jr27xVT+sC75TG+cRcfBD7lBEMZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqYJuPuxhZFRgN72gPNdJ6Q8iVgBtpzNH9qxe3xIh6Y=;
 b=kNhDt9zwqltWvWdCh0AmOIwC1fGuGW//Wu6bgtRe74ViAL4Ik2il+dgAkXLjiBYFgYtdL70UnR9ooVN43GuBmthvjInJW+8nW9BR9/M5xyrqa2cQ+k7lzjgtzPMGPEJQLzhtMmnAH9ujLMpL02/+mYUEuDCgJrs9A9GKQbypz9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:46 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:46 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 05/12] irqchip: mips-gic: Setup defaults in each cluster
Date:   Thu, 19 May 2022 20:51:18 +0200
Message-Id: <20220519185125.11686-6-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c65e295b-1195-463c-5035-08da39c89f46
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546761F073EE35E4C4C5734EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQtirqfuSiq8w/+0ANfPw+wPu9sAMGt/qOUinItSTAmXlzHyTpqu54E1eWPtyW8kpxZgtlzkPev2WtGloZwpvrkU9D2eSJialL+RvDMyeYeuReDs61GHIeYlZgASlPOKeKckvWLcTaqeq3r8O2vmEodpSSwWweXRBw4Hvpy84g5SjacBJuE/YbjaQ+4gHAJf88pYeFxuYuCtRGLjUGnjctCJmhvMRKmhQaSrUgTMqd4yCuxmAfDuM6mr2vVSufyXFamrtzKtXxnjSblP4kqOq5uq953ss9NLjga0K/ZW9yA+brPR2OY9rU6jh0XPPVAz+yI2N6VhocsBMjgZpYgI4+1LsK65iZkHO8+2OzCF0ZrEFMffR6Pzzeatdg7gRzBNv5aK651FIJ3y5YXu5b8GvEfFhg2m7YTKyInLWz6SKEgq3pQQAxi+FB+EsgCRSjbnuWzt05GAIWfuoPrWJNECLhRQdFLmgJXXa7xvSNtxcnAMM/i5yzMvSk1kQBFvu8EDSjNLRyHgSxw+CX9lEllo8bRmYx/RX4GBugMtBHIP32Kx0xxxjRu7TRQQAUi/qatMFxH90LyUmlLxds+JYkHwFnQVUmk+X7t+j+edhWmRw1gUBrix8Snv2ldDkuO5ioVE9R+eYtiTnmHBqn74iSwIOREc/gl6BtFSeMDB0U1XuKQO/i44DNT9OAvC+9kXPfd6Vp9XThOAP+BWqnUf3P7iYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Ow/Ntl0caJaV8sfnsaEJ+0za6cwBH6MaTXzx6z5RTLpXMbnZH11KT1djxyF?=
 =?us-ascii?Q?HmfiXrai2ZMyUjPU1aKdimWDkggMBtueIRFzmfXZA8sD2AHj9ITuaceNHpDG?=
 =?us-ascii?Q?tAXCT/pMLg/+qYypvrf3aNpFXPFAQpZsDtQaEREmVaCUuDNaUo3r/LHk8JNd?=
 =?us-ascii?Q?rsfbk88PDHKT6+RXcSoJs6k9IxfuR9zVzVjVmX89O+LgC+bQU+3tZG1gwu/U?=
 =?us-ascii?Q?RZYETdItZqjDXpRKGKNPOWRFSMkNKj7xR0N2PPhGdVP/9APVPEsoLTetPJdC?=
 =?us-ascii?Q?2kV5i7yJeZ06Q7j1WzROoDhazZYEB/aYIBkowJ/H+fDtqCslyw1NwyMucvrt?=
 =?us-ascii?Q?E874or34HNwtzlHQnrVz44t/xt5iNJqhtgySye6jm7hPnqGDqIzVMYgxWYIh?=
 =?us-ascii?Q?sQPvS1eTWLLbRHx5axukq5myOACZMZ18nGpjxl/SGZ1bruhB8AGgpqalGbFp?=
 =?us-ascii?Q?QSnG+pufQWhvXxJFt2hlRUGbjYytSm2juYmQ2UcaRYij+iLh0uyKovD72i5K?=
 =?us-ascii?Q?PpGKc7C+hkZrsbYyRQrhDSNvZsY23pVJz1wfsnPvzTi5t05DnTt1RVMgAybY?=
 =?us-ascii?Q?wSb65gEGiUm8DYFVud88k5pXnlc7MLsul9MZTnoRVjBSQuUGbBBvAnumJEe8?=
 =?us-ascii?Q?aNi0suyeE0Erlu+8W0YmbvEX/BNo8zLGHuIMo7QIsdLmaOx3jOCRIiLEurRo?=
 =?us-ascii?Q?fCWeJ1xpTwT5d//vHQXn/cOVFN6rBSrhtxjn/EDlKlbK7sjhp5WYJ95TJqq9?=
 =?us-ascii?Q?lop1TfZyjRrCPibmql1PcvmUwrkXCWsJFhZPwDsDmAxA+nbc0b8dQuzKye3l?=
 =?us-ascii?Q?+oontPUOLUN0qYKgv8uZxJTqzEAaOW5UXteBLkAOqKmxpMir7jlv+/8XyrjX?=
 =?us-ascii?Q?iNRYUs3dXMocU398w8lptNp1dt5CYXBZoi2oxGlj8csWamNWF+3ARNA6/Gli?=
 =?us-ascii?Q?uzScmcrSl61e2klDhY+uHr6ygIauRSY9y5kIrRsAchek8ryKbwRN8K+sPFG1?=
 =?us-ascii?Q?0wxQhiKymrBI6fiIdS9xDKQFMLwQKCUQUJylh0on0cL68fZHiYT82kA8/WNd?=
 =?us-ascii?Q?P37fam1R7qjgfrIKEMG1JpzkMZ5Hy4CakAzrOaBz83zpEY3MWSX2HH3f+e8l?=
 =?us-ascii?Q?wNZI6QX/P0EQJ2Q2CzUumoUMC7Q6VQ14PQbMgahccRbuU9RbaSFIiRbX8Ex8?=
 =?us-ascii?Q?EXzmxMKVKkUEh7Ns4A8zvvIUkMBTIr+xENLKNY1J1cGTGhmvXgqiqztAuGri?=
 =?us-ascii?Q?uil2MyKm93GMMcE5F/SaqqB9YlAsxOleUvieVhB2SiPUg+cuCAjyuQ9kC7T6?=
 =?us-ascii?Q?DD8WuTmetfY1/Im+Jjy/lcy5DsZ48IaGoUEIiqbhwBO1cd3fCxWT3Lm6ALrq?=
 =?us-ascii?Q?EZq4+Ck5RDeWURJ8BsQcFnA/TzKC2SsQNvElbN6utCxGfClhTIZOCKeJQJO/?=
 =?us-ascii?Q?E2nt46iFVTMsPyrC3xcFidM58f0f70oewKoXOSTw9TeBkGSxBy/aAuVVAlWH?=
 =?us-ascii?Q?sQrTdA1C7SgWwA/cQHTGAcl419hw0MMDvIxPjjGuqrpiSS/TRpfb2zW4Kto8?=
 =?us-ascii?Q?E/9XdlgiwQEdVVPveAzLvF/3bTClpgQFn3P85fdp1AqA0w1RjlkOglJbj8WK?=
 =?us-ascii?Q?mH0lf59hFKMPtRGDae4bRT0KA1/Bzpuid61/An26n9LWJFN6+mZgMd8tyreJ?=
 =?us-ascii?Q?TsneOxW8ukefuRXhiBErpX1nBpTSn4uz7UkymuZG5OV+JzzYTVpIxKDAiGdi?=
 =?us-ascii?Q?KbBkCP7/JQvcX/tZFjeQQFis2szwNcA=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65e295b-1195-463c-5035-08da39c89f46
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:45.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjZB8G8ag82PYgiSDa+PZ6F2TVUEDQNxiSOSj56ngsVFEyO79fzLD9LN8REuKpM2qPJ9Z0G+NxxBg9XEysXLcOmo0P7LnKeldnQWj4DLu4k=
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

From: Chao-ying Fu <cfu@wavecomp.com>

In multi-cluster MIPS I6500 systems we have a GIC per cluster. The
default shared interrupt setup that we configure in gic_of_init() will
only apply to the GIC in the cluster containing the boot CPU, leaving
the GICs of other clusters unconfigured. Similarly configure other
clusters here.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 89a3c6d04e09..f692392666a2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -741,7 +741,7 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis;
+	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis, cl, nclusters;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
@@ -860,11 +860,30 @@ static int __init gic_of_init(struct device_node *node,
 
 	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
-	/* Setup defaults */
-	for (i = 0; i < gic_shared_intrs; i++) {
-		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
-		change_gic_trig(i, GIC_TRIG_LEVEL);
-		write_gic_rmask(i);
+	/*
+	 * Initialise each cluster's GIC shared registers to sane default
+	 * values.
+	 * Otherwise, the IPI set up will be erased if we move code
+	 * to gic_cpu_startup for each cpu.
+	 */
+	nclusters = mips_cps_numclusters();
+	for (cl = 0; cl < nclusters; cl++) {
+		if (cl == cpu_cluster(&current_cpu_data)) {
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_trig(i, GIC_TRIG_LEVEL);
+				write_gic_rmask(i);
+			}
+		} else {
+			mips_cm_lock_other(cl, 0, 0,
+					   CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_redir_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_redir_trig(i, GIC_TRIG_LEVEL);
+				write_gic_redir_rmask(i);
+			}
+			mips_cm_unlock_other();
+		}
 	}
 
 	return cpuhp_setup_state(CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-- 
2.17.1

