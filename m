Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E795750D032
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiDXH0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiDXH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:26:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2137.outbound.protection.outlook.com [40.107.212.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0823668E
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ouux28lX26amicJzAUCaKuKllA2vNVIotsyxP9OPW2m+Rxim2nH0b9VNn/HxviA9x55mONmFBIxFL14zFU2DC89PuxeEbFcWk9Hlv//lbT43ZU4G0d7vjBFJEyovIEAgHCvVC+03AFYfvteVf4LTzxXeO9aHWxFwtpjCw38Hjn/jTnuPy6KporgD5E3X+4WWrqTOJlrE6rASX6mn6BXWSqQW1v6KPl896cC3PEkEvg51AyIldDUGTAcNO8Zil3iFEdtSRbA1zh138J6BA+m5e79rWsAi8DWXIx1n4dfJKz/G8k2D3BW+XN6pCnFi8oUV3aVbS71QbWvNj7GDcIKQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf/XcownOYwfF8Vu0e7UWlZUAMEv5jxx9qXfAH3i+Qk=;
 b=dHYuhDHZL0O35vTtz5cY8MwHGxuPOoYQy+KdF4EZS7jtO7fHNdW3dYktsArKo7G1qn8YfVkHV2xW/ND7tQ4omJ9nwXSNU8f19Y+e747PHxFiubnGXhmkL9gyxfvNvc9l4NUTArVDHrWQu2slM1c3fLq3v8GetiJMdlfaOwbg/eQxdO+nPmFj7ENWmdDyQbIBVFvDJ7m43LUSnDpsFZCUq4l84qyFXH7ou3mWtqbV4sizaghCYiXlI141oRJME99fqyvGjGm7dWyi24AcmRgBJEi/fR2oofosU0hp0ySXSiHjbeI+KUelpv/Dy0UjbghJoOUOZX1/8XCQSZvisC0D9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf/XcownOYwfF8Vu0e7UWlZUAMEv5jxx9qXfAH3i+Qk=;
 b=WQteL/a7aLTg3M+Rx5/6btRo8/59XZZqHLRh5jMRHZxxE9cabryvAXh/vFfTXsg7qS92wJsDPnv0LjeEImAAeq27Nl3uofgf1m7dbNLHJHzfm4E3vCdu6Ee2a1SIji9c2T433+bKGD8zo04noJEFVb7g5AmoMntYQ9iH1wv+Ts4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SN4PR01MB7486.prod.exchangelabs.com (2603:10b6:806:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Sun, 24 Apr 2022 07:23:45 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::1c14:74a3:9d99:d21e]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::1c14:74a3:9d99:d21e%3]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 07:23:45 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, pasha.tatashin@soleen.com,
        pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Adam Li <adam.li@amperecomputing.com>
Subject: [PATCH v2] arm64: kexec: flush log to console in NMI context
Date:   Sun, 24 Apr 2022 15:19:52 +0000
Message-Id: <20220424151952.183208-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:610:e5::24) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4650d3-f583-4a04-4ba6-08da25c35d75
X-MS-TrafficTypeDiagnostic: SN4PR01MB7486:EE_
X-Microsoft-Antispam-PRVS: <SN4PR01MB7486E023A49013072592000FEDF99@SN4PR01MB7486.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHIHrC7qAjCHMmhhe+y4/KkLfXautHO4jwnaIsLV8UGER8s4UM0UdS2QQFE1XPJvDkI7TQIJddkjguocHdMi0dyeD2LpzGChOamwFhY2aMr22MJTuoQeT32PbgL2Ld2jytlh2ygULZZ7RHTES4n8CFP+R17Q5t5fYLxYADv7QiPsIJ0UDqbdyuGqySmK2gbnCTCJKR3/VmIn/kcs+w+C00Cvy34dmMs7RtHm9FnkIeCFjc1PnS3FHs0LtVpsmaKqAk13nO2ZF3NF/FGW7E5xKjW72r+y+tFnxYWFS3lEpxSRhB/acq56JtcbNaK2CUmvNXq0Xx17Wmmdv7bONoCa+bOdDPhipEHxePvIJoaBCPOmwH0pwXpqD6IOK5vNflbd9exodotqsvkDwVnpGbRx1EiHChNwnkN3uGAZenoDNUwFFjjiuTEQtJr0K+J+gvgcLi4Cx8Th/AUm5Xti2qfOMCHdA6uj0f2HwFyJiBv3irKVgg/mpt8p5kvU6zVAU557MA7isZU2DmurH5ALx1/rVhsY2CUVAyEjnP4Je9q64R47g/1g+nITsYyI98zySAhrpFkAAxZaXW2Y8jxTiMMH+ABvksgzhVbYfVctDZ6LEX1ZDVvF5GX+a/+rYTA6y8CoTQYTLpnr896GYr6puWm0yIJKGmLIL0utvjvJRPAqImPLbDuFxRrGLjVgD3C9wytuLpel1RW/2h+Hl6z8SAYdSQHvMKvUfmwBn+jMwvfLc7ZDahn8x3o1j1dMPYnsW96uv5tAH0vfqzfu2Y+3dXxtwS/i8a5uF/seUYBS7ES18Do=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(38350700002)(5660300002)(83380400001)(107886003)(38100700002)(316002)(4326008)(66946007)(66476007)(66556008)(8676002)(54906003)(6486002)(2616005)(186003)(1076003)(508600001)(86362001)(26005)(6506007)(52116002)(6666004)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qsotfIokCuVu0MjMoEgtFtHFcwRUw0ib6BXk3Zjqki5rRVVkVN8IYARmStYC?=
 =?us-ascii?Q?IORWp7L8u7yD9ANUsz6BUbW9poeFbhrcrkxEzRkIsxdYpym+teQKIgMTTLRX?=
 =?us-ascii?Q?8liEjLc41ZPr1JDkQ6QNxCcrrwj5KTsvSjNkzUxtMd7USKl8VWOJrmLrxYK2?=
 =?us-ascii?Q?35Gnk4biHAAALYYaG1SoYzgzLj7xjohqjfsEYSDBwGOORmmZm/Zh5T5j0EYw?=
 =?us-ascii?Q?4YARiB4U3RiBJWolRm8xlAn2LqnIGbf8/3ofSh1Vll7xSKuIcKMwMDY2eyFv?=
 =?us-ascii?Q?FnKjFvzbPYr+VL/YmVG5day6skMq+/0btRlFRijPIAs7qQp9S9yBY6h0jtZJ?=
 =?us-ascii?Q?NA50sJd9RrDxqlfhq21FlsEYlNwFBqWXvqKTT984F7fbpEakG+XDOERd1dZV?=
 =?us-ascii?Q?blucBR043Ygmecl/aoQ5Li0Lk0sJF3oBOaCMzK+ukFI6goei1rPFVCrlct+7?=
 =?us-ascii?Q?SoolT/Nm2EzQo2PFDxzYEws8a+E50YXrLVJHViZuOZYWluvN88hJH1jmtbXE?=
 =?us-ascii?Q?gasE/JiWs7Sqq6oBRuQklTW7eP3dG4gBlE1PVPZoOU71WlMp26hL+Lamr2LY?=
 =?us-ascii?Q?2MZbiEB/X9OGvTodxO2zPV7beHCaD3vmH30eansdnLcO4EX4v1GDH2AKlAsi?=
 =?us-ascii?Q?DoUD1Bi2rHx8piB0R3qX2ZVbwvwkWc2cYgfTr6aCyXJGJ7m7hQYZBcQ+YttI?=
 =?us-ascii?Q?DJ9VpCUpblxskvFqFGG1m7M9xdbFxfqv7sQyzaHM7vlIfcuqjKA3uBrWlg9s?=
 =?us-ascii?Q?+IsrmraeYAzto/RVIe6xwDbNpRec1+vrarTSzxUbkDutNXMFmlI3h2T3soZX?=
 =?us-ascii?Q?4FSH2jih6S9xSid1dkH0M+cxhZ5Re+aZL2QFsunPTO200Tbm73ncLf1KR16L?=
 =?us-ascii?Q?DrI4m66zhIgOC8SanWBDpI9ID0RdZfoS5SDH0WRIxRDcM6OegY5x28Uy0L6I?=
 =?us-ascii?Q?bkoxG8Hq1RDpp+WIZpKKjga6dYGRR3iPmqgzPvOS+XNuXtwSCcfW0sLI30H3?=
 =?us-ascii?Q?WZp3dCjPfbrUtVccjerE40rmCYXj6Fpw23JmlvBqacY5LNILoqA5ekfarjg7?=
 =?us-ascii?Q?ZigjrLHJAxuLUgxBwqVnVJveEI4jpI5tGvFnJ9hZc1zTE4oCZz2iIfu7Erx/?=
 =?us-ascii?Q?0Zn2nvpHWVMk5m2GyPGwtjfHzXGhFyQ0JykCdnXpZVMj2NMaDsMNI2R2VxTX?=
 =?us-ascii?Q?DGYSjYXT7L53AFS2hjGJyZ08At4fi4CGxWGwV7ahOsYdWCAsFRLPkQuhv4fK?=
 =?us-ascii?Q?8wJnBf9wyqKN0Eqh70kgsuoA/EAxRN5xxAIk1pRNNuNfz6vMj2SmhIUkedmX?=
 =?us-ascii?Q?YLKDWOAPQvGzzjkvc0p6C+C1SE7hybsKqHaaQ579TncAM7wmyt/fRwnBdnC0?=
 =?us-ascii?Q?IeTt69KM9xgPswvgOWMGR564U5lhT2i39y5O0Pf3Ifb6PMsRg/aLMIrhrnYo?=
 =?us-ascii?Q?vn+QdKMzPiSEJ5BVNwT/jqVDa1DLVJ4IqNM315URX3atA1D0XXFYtVrz3Be5?=
 =?us-ascii?Q?MDbgmhd1SYXazhAWggws622yvwbUsYzynznQPFP40z/ztqxc9CAUpDreneSe?=
 =?us-ascii?Q?NICISAY2XzjcGeuJEKTbvIo/s0hXTFKtEVB76TAsvmCVrpZt8yPBhz2EWcAy?=
 =?us-ascii?Q?r31CjHVn69MfbTlQRLxkrzGleWD4eNoMmeFxdKzASoXLu/KdtsjxtiQrHCRn?=
 =?us-ascii?Q?E+ap5zLPfRgF3DyJzSIRCCd15z/gWqY6TpvTPpWzJ2bfaBouiwNYIWJpTIiK?=
 =?us-ascii?Q?sp9KLRammYzmo67c6Nh1DD2W6LFcPjbFjFr0BzGUJx89tqm706dS?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4650d3-f583-4a04-4ba6-08da25c35d75
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 07:23:44.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw4DPiBTQriZtD+k8eW0InPrbgvQNvIilKu4+Gioqy7IZRhL7E3+pd9H/bsPnkP6EB5knlSQp0hO6X2hoR4hzipLX0Fd538fBPdN/AKsnoR86hofIFZiY8FlhcO3HrNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7486
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kdump is configured, nmi_panic() may run to machine_kexec().

In NMI context, the defer_console_output() defers the console
output by using wake_up_klogd to flush the printk ringbuffer
to console.

But in the machine_kexec, the system will reset, and there is
no chance for the wake_up_klogd to do its job. So we can _not_
see any log on the console since the nmi_panic
(nmi_panic() will disable the irq).

This patch fixes this issue by using console_flush_on_panic()
to flush to console.

After this patch, we can see all the log since the nmi_panic
in the panic console.

Tested-by: Adam Li <adam.li@amperecomputing.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2:
	update this patch since the printk system is changed.

	v1:https://lkml.iu.edu/hypermail/linux/kernel/2106.2/01703.html
---
 arch/arm64/kernel/machine_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index e16b248699d5..e961464a881e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -6,6 +6,7 @@
  * Copyright (C) Huawei Futurewei Technologies.
  */
 
+#include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -188,6 +189,8 @@ void machine_kexec(struct kimage *kimage)
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
 	pr_info("Bye!\n");
+	if (in_nmi())
+		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
 	local_daif_mask();
 
-- 
2.30.2

