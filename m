Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4268E4E4CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242015AbiCWGtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242019AbiCWGth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:49:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A95FFA;
        Tue, 22 Mar 2022 23:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE4Y0gcofvtb9RfCMEakJAMwQgNsDNFYqcd2CEcAOa+e5SL7DEZxG8txFwcenKsPpLUr21ZELRDFP2iG0Xyd+qU0MjMaXYUbc9p0LYR7Sh9I4BTqufaWcaz39X63GYOivVzRvHgyW1VQCXOP7cnqjJrIPlICc8XIMTGQiOSPy1ygimvkuugyJrx6jg9x7AFAWdzW0PaRK8fGWmHnJs3akA3ztI3GQUm9DztxJaZ3ZU4hJI11NGgfhouO+NcjYlN7jWIWMATqLCrFd5N5Elr7yZsWdf6r8UknyhoKe/GsKDbDAEj4CK/ZDABb9nTI5tJ/csVZgVrVaPDC65o2jxKZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1JA1+8/9D85zjml537ojpP92Fwv/dEYg8OU/ucMc94=;
 b=Gv54Ru+sxCMKjkouAxGK7+AYil4a9FkDu2EX9JeEGE7IEBvaFSRrlrVoBX6YTntD4wOMD68qAuIN0F1QCXF4n5bDiNYSy35O35yOXiDvHZUePAWf4izBAngeDch7EnSaddcNWrrsLsy8yida00CHtnCesi+vkIkPblAyoZ86NvghFlREShQKzTO+0YxkYNIUFe/Pux6B1h/tW1pY6r5ph+ul66cNr0Wn4Y6zKWTPyPF6ZyquB8MG3fUiohaUBr3vREcDVRgS9tIf0yBTBR61IvmRXTi9meTZkN2mV+A65z+DmuhAj3QyY8BMNFjWF5KrwElXMogfLes/XGyAMybhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1JA1+8/9D85zjml537ojpP92Fwv/dEYg8OU/ucMc94=;
 b=S/WG6o7OxG/EvjE/A0DCuGmEfHZTVcM3c/PDUAV5tYWhFFjvbXB6DBMFe5qNADFInWlXaz5oX0BVw9zULfNxnuTZeCPA1f9RV5wEJbGLIAzX1m2nuiFATp2rk+XyCUrIehplk0dJ5HpV460R0AyQJll2WMS5c4REjq27vZGWHLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7379.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 06:48:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 06:48:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, shengjiu.wang@nxp.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] remoteproc: imx_dsp_rproc: use common rproc_elf_load_segments
Date:   Wed, 23 Mar 2022 14:49:44 +0800
Message-Id: <20220323064944.1351923-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
References: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d155f3e5-b41e-47f3-f4b1-08da0c99132b
X-MS-TrafficTypeDiagnostic: AM8PR04MB7379:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7379ABD75E86D9527D6C897DC9189@AM8PR04MB7379.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RtDW0XDobzFZ1LFvlESuUbLdf4PqJdmc1V2t3DbWwmzGTYqiupYzhfx3quFkOQ6aOqEzTvwj+ShPzfe5YAuxltOMnCeBj8+em6zR6jTeVukPqHMlviCvy0peU2F1Zroz5jm8lqkLbyMACSIwNKuu5yozaU5Tx0p5a4oI+PcMtARdsWzGIxI5/p+OnWQQ7KeRS08g5vrVHJJdutUGgaarwB/WHPnZkS17P01vBpq7Qz3N0XSkrtqP0F4o1AiWZtTCMM8ZV35tIqhyEkCKyAgu1krrnLHhfXk0Di+XZZ//hA3G1n/60+vqGe3RBUrEyS5WsxqTgs16t3FqbrPw+wyhe6aS0AnBB4E6ajZPUo1N+ul30HhaRlVmdKwgGDs7MxSZdaH5awjTnrbjtBcXWlGGV+kKkgRgX1pkSnM5lcFRx0PdHpbasG9w7XbAEwYDcer3YSG2B6xnEJK/EKqWVGAEH3BkhpxWCEuso/0o8tpvd0/L2ZBuMPW/20ZHgtO4IUuoIHRUbgbdZxm5KrGM1rqLBP6s5LDq8ieQsqbKT87nRZ9EzihCEvMneEFLhRMX2p/2O+2uK/cYk2EZCDUmmxgXiy1ViZ2VSdBj52hEG4roFX9bhsTpZVhZfucEthuGb5oqdPw4X0qbNnkPN0iIMmqmyZjyU6nChnZBivEA6m+HpzSys0QHl3Sf4Sa5CKwWbmA5pZ8fcxbLEVi/3W3Ht21Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(52116002)(6506007)(4326008)(8676002)(66476007)(186003)(26005)(66556008)(2616005)(8936002)(6512007)(5660300002)(1076003)(38350700002)(66946007)(38100700002)(83380400001)(86362001)(6486002)(508600001)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ROl3HTJkEk27Ymi8CvprzJ/51d6ybv/VRB5ZU/7tJiCIpCbM3ecaHKxOfZ8?=
 =?us-ascii?Q?BnkiW6sHDsnFdlXxXw8JZ6vEDpU7dSeE0pMiftkgoZTF6zYYBFDzVI7XD2Tc?=
 =?us-ascii?Q?R0rk8hfbbnezCCzKhXGcobVagu+l53gBUos6E1lGfNm6EKme2mqvgI3Sie0A?=
 =?us-ascii?Q?AC7ydOC9bjD33zSL1J/Dk7xHUF/xSLtTMCiCrI4zlLYxLBWjwik/q2ufgGd7?=
 =?us-ascii?Q?QCr5lfStThvfDujeHIL69Y6IC+mDRH86Odmi+9iNux4M7r2g7C5D/1ug6Kw+?=
 =?us-ascii?Q?ILOWeuR2A20FQwQ8E38xWlMpuGUy+eYtFD+rimIsyf2Bp1bFDuGgDJucsdW+?=
 =?us-ascii?Q?29q5mcFTA8rO1RniVTWDoQqozIdo5bEHJ2J+F7qs6bLHLlYVnttqDXIJBvgK?=
 =?us-ascii?Q?jqZi+5VM2rRL9qqwfO33P3H/a3BvmVnPOp77rjIOQfv3RKqjLcUjjHZmY+G7?=
 =?us-ascii?Q?cuoue4JJFWjqvfh+OvFLrwO+a7LgiEECGdHriTVtxrjh3EdNu6rvFjdg14kq?=
 =?us-ascii?Q?suIi0l1Trd9hRwC5E03e66iVoQ6rR2pcorW/gBdVVwQ6rxE+4vOOwuHppI4F?=
 =?us-ascii?Q?xVkDIzEM9vB7xY4mYtyDF0GOuXDR4ytWqmIAOrCiG+k0N0+WL9rGk5fzIU1L?=
 =?us-ascii?Q?BMMYN4E0vmybmsRuBCmAW8gqwAWFZs9SbuxWyGdnFYwcleVF/nV5hpysVClh?=
 =?us-ascii?Q?Ncm39PvAvbwlrnuDHVePfXAC0J1JRYfsz8ke99KQswhgNpAA+u9hRHVZ5GKC?=
 =?us-ascii?Q?NPB2862AtVNgdCOo/WjNHOpV6nSeJEOHX0trRLZibYITzqKoljLiVOmDBubr?=
 =?us-ascii?Q?Ue4HmLJnsNg2FsH0TIhlm5pprQbxgEdfEROeJiQnRy2kuS9Qn5LcqT7rcen3?=
 =?us-ascii?Q?eNCEaAAxmMsGJL3b07Mrk8l0vctp6eK9o275FraIWhnzR961FcYX12EeShWF?=
 =?us-ascii?Q?ftYbw5PimnfYdtwdpUhL4l4ORFTwn/kujJgvuNw0ceUtcTE16FDno6ZawLXK?=
 =?us-ascii?Q?6VW5py2jDxN1eGiNsUjtHVCOXpkjckmkubm1wW6xXF6gcPrOEKHQuGpowJTy?=
 =?us-ascii?Q?5HBwJPfvMLSULcWqwDEfSXj4ohLffHoNoisOoNmkpfJCrk8rA7/5bJQzvR2o?=
 =?us-ascii?Q?AnE/euJhgYvMiH1Kwa+emJAhAEE6VvvcYdM1aDqYzT/cJMzh0yoZSwO/Cc0h?=
 =?us-ascii?Q?FZ03cDlWY5/mJ/iOV1sK92BAKRbaRXqfUWThXrzcUa5OaqMEmZgbRNM9l2K4?=
 =?us-ascii?Q?nmY0emuHvXGyzHaOy52Gf5g/9epCjDwyw7HMfRqw24oR0SqRYjp96csZhcQi?=
 =?us-ascii?Q?G2hHc8BtpX8hNk99wdLjPSwCKyWjk+P8rL3mGFa8qLkp20Nd6GJhWqyCpjol?=
 =?us-ascii?Q?Lm7utyT9X4hoImKc+gKfMBOSTLWD7LmhjOVHELJxHdprFfenoYtOImrYRnTG?=
 =?us-ascii?Q?ylBrMd/X17RR2qwnTcW25qEQcYihR8O1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d155f3e5-b41e-47f3-f4b1-08da0c99132b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 06:48:02.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wExV1tHL/0sDvambabGyDs19UOzcrM1vUCWGSbZP5gLz1kvWvyqRoibATsZNgruISwFMjowx0BDrQDu/6KTK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7379
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

remoteproc elf loader supports the specific case that segments
have PT_LOAD and memsz/filesz set to zero, so no duplicate
code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 95 +-----------------------------
 1 file changed, 1 insertion(+), 94 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 2abee78df96e..eee3c44c2146 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -649,99 +649,6 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
 	return 0;
 }
 
-/**
- * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
- * @rproc: remote processor which will be booted using these fw segments
- * @fw: the ELF firmware image
- *
- * This function specially checks if memsz is zero or not, otherwise it
- * is mostly same as rproc_elf_load_segments().
- */
-static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc,
-					   const struct firmware *fw)
-{
-	struct device *dev = &rproc->dev;
-	u8 class = fw_elf_get_class(fw);
-	u32 elf_phdr_get_size = elf_size_of_phdr(class);
-	const u8 *elf_data = fw->data;
-	const void *ehdr, *phdr;
-	int i, ret = 0;
-	u16 phnum;
-
-	ehdr = elf_data;
-	phnum = elf_hdr_get_e_phnum(class, ehdr);
-	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
-
-	/* go through the available ELF segments */
-	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
-		u64 da = elf_phdr_get_p_paddr(class, phdr);
-		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
-		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
-		u64 offset = elf_phdr_get_p_offset(class, phdr);
-		u32 type = elf_phdr_get_p_type(class, phdr);
-		void *ptr;
-
-		/*
-		 *  There is a case that with PT_LOAD type, the
-		 *  filesz = memsz = 0. If memsz = 0, rproc_da_to_va
-		 *  should return NULL ptr, then error is returned.
-		 *  So this case should be skipped from the loop.
-		 *  Add !memsz checking here.
-		 */
-		if (type != PT_LOAD || !memsz)
-			continue;
-
-		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
-			type, da, memsz, filesz);
-
-		if (filesz > memsz) {
-			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
-				filesz, memsz);
-			ret = -EINVAL;
-			break;
-		}
-
-		if (offset + filesz > fw->size) {
-			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
-				offset + filesz, fw->size);
-			ret = -EINVAL;
-			break;
-		}
-
-		if (!rproc_u64_fit_in_size_t(memsz)) {
-			dev_err(dev, "size (%llx) does not fit in size_t type\n",
-				memsz);
-			ret = -EOVERFLOW;
-			break;
-		}
-
-		/* grab the kernel address for this device address */
-		ptr = rproc_da_to_va(rproc, da, memsz, NULL);
-		if (!ptr) {
-			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
-				memsz);
-			ret = -EINVAL;
-			break;
-		}
-
-		/* put the segment where the remote processor expects it */
-		if (filesz)
-			memcpy(ptr, elf_data + offset, filesz);
-
-		/*
-		 * Zero out remaining memory for this segment.
-		 *
-		 * This isn't strictly required since dma_alloc_coherent already
-		 * did this for us. albeit harmless, we may consider removing
-		 * this.
-		 */
-		if (memsz > filesz)
-			memset(ptr + filesz, 0, memsz - filesz);
-	}
-
-	return ret;
-}
-
 /* Prepare function for rproc_ops */
 static int imx_dsp_rproc_prepare(struct rproc *rproc)
 {
@@ -808,7 +715,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.start		= imx_dsp_rproc_start,
 	.stop		= imx_dsp_rproc_stop,
 	.kick		= imx_dsp_rproc_kick,
-	.load		= imx_dsp_rproc_elf_load_segments,
+	.load		= rproc_elf_load_segments,
 	.parse_fw	= rproc_elf_load_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
-- 
2.25.1

