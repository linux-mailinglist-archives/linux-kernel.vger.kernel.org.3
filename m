Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19634FED93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiDMDbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiDMDbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:31:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D03EA8E;
        Tue, 12 Apr 2022 20:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4DjD/1b++kcGp5gEjrAs2UqFwrb98A2U3jkvXY3c9px8v2zF1u+i50JrqGdRyFuBQClZCbiRnhfGLYd5N87ekzi/QZo8XZMHX7p2mNfUJIA44+bBXdx0XOiU1O0ftEb84Bn01fbRA/34BiD663z/Q2oc27xPtsem96RmllGiC3OlgKyzAqkO57+LBvmM2heADzB7dU3idjG1VQgMApntngYz/RLaqHrpF0NVltXc4jnSxToyCA/aeKq6w9ovWCf9AGjYEUXLXjAR0B00WdHaBvfj34RNG0ewqYCdMHAem+eXAgq/EeRjAeQy8Wmseq8lgfYiBAfx1gfnrwLBlfySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSKjvn/lnn8ce+NBoENX5OfBmJhLqYPdcJx5Klg2ygQ=;
 b=M+5e0u+muYKfUUiWKb/Kpf9ZlLqazR73dTeBN8cbBRev7h++cfiNRwulUHCnLJwwpbdlhFfadA31bCKMSldaiKdiP288fAC0KbdiuX3AJzfGI20JVtSUU4UuPCGuyFVGkED7sQ1DqUd+IBDmTmyH2MNeluCdRAA+zbKC8vxWqvMer/SwDn3xnCr3hMTDYodzOHaAdbl/+iu1/fspmdQA5OZUTqb80X9KqcoQX1trCOPdxCygsFW1Q6RxCeYLW7tKwhegm9lp7NYHQc5olEj/P+2id+/jMqD4BHDb1Ul7GrjhBPYgVvW0Q4XrDWhZ5M+bvQeIiozsmk8TnW6EIpOWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSKjvn/lnn8ce+NBoENX5OfBmJhLqYPdcJx5Klg2ygQ=;
 b=EvwvkbCW43aq1PtQX7qTfA8PMNyxRMo4G98GyZFuktmQ8OBnVi7kl3fCqgqUGxPhG4YeIE1lsdwuXeip8jvBZl9IcnYcJUhTYa9Bg7CYxys6jJYGQw9hem4nNxSQvgpZBMifO238khGNnIc74yoI7Loj+EYnc922RKkHQ3a9c5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7483.eurprd04.prod.outlook.com (2603:10a6:102:86::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 03:28:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 03:28:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH V2 2/2] remoteproc: imx_dsp_rproc: use common rproc_elf_load_segments
Date:   Wed, 13 Apr 2022 11:30:38 +0800
Message-Id: <20220413033038.1715945-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413033038.1715945-1-peng.fan@oss.nxp.com>
References: <20220413033038.1715945-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a365f4-b509-4bd4-5613-08da1cfdbf4c
X-MS-TrafficTypeDiagnostic: PR3PR04MB7483:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB74838FB92F028E6AC4AE0331C9EC9@PR3PR04MB7483.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwwhKC6Ao5P2qmJxka1WC+XqbCulG+izmjz3fwclqgujid65vGBnw7+XQVlUS5XgkpAtZASNHFRHW1veSV7dzUf6Sg+U3DdFiY5lSRUoSnDT6nQ4zE5yV2g1+rYObWbBMAubU5a2k4JhORKgYof87NHVEFdnDEcDLu/iESjQHnCh/34SPOqrLBn2lQy3j4LdeanZ3yrloRyQJW4mdRXblO4ag1kMsKnfMmblw0i/HDXkSC0nv/b1Qm5irDmmBRzrMDhOEqWya18Z+0SxUbBa14dSwdWIPtd6q1VQ81sVknVOBivrPTNeOKo5Pv4gnVQgrF+D7PKDkFpdQ1r3bjoFneEyW1hPZoE8iXtAlqbw/uzScuwGuzrnzINN5SmjFsAKbytCfnN7tZSs/5PRZFZpPcPqGsmtBmxtSOtfcJcS5BXxKdg4i0qirmy6yy8byXyw3j629iDgNhqVxA/AUiCrh1ljsw3V+pBj880WU1F6AmoHJ4b+dbKs2Bf0lC7xwnERlEgpMBv7vz1Jm+RB1ObO1kTHy9pK99YcO6QCRlNDRvUz2eNsa5blOnKO3xPhcTVBIZbUPJ+tYRpyacks9iwiXmQcZrkuKIw3zestdSePXt5FQ8qdPWnJCZFVueZJkbHWGAQ98URqtPjYzMuvU6A1D//H2gKbQuf2nNC0dlp3yBNw5PWlCmaiY3APrqiQkCwFdHZhxq7YfJb7zHI6uWwYqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(508600001)(52116002)(316002)(1076003)(186003)(2616005)(6506007)(83380400001)(38350700002)(86362001)(38100700002)(26005)(4326008)(66476007)(66556008)(6512007)(2906002)(6486002)(54906003)(8676002)(5660300002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?78cYIKx7TzMPZMraWwGH2B75wS0LmLmBdJhzVcwpk0ZnCAoYbO2MCvnM7oh/?=
 =?us-ascii?Q?qfWPvQ9ERL0j6Liqp3LHEBloglFQ3BKhhzmf3raaEh0gCM6LNOyaP1bQok28?=
 =?us-ascii?Q?uMecPaglJMVmAHQo4UqShvKxpwFcK9osVY6b7ypIv0X/7k93CQIYBcKNIepx?=
 =?us-ascii?Q?4hPNrp8QkfoumzDjsmLYtCRBB9E0kCQDwS4xiVcnMqyGSiy4m5Vq4GxDZevh?=
 =?us-ascii?Q?mv8aOJEl6az+gNI1CWdSupPwaI+3d9G2edKhCPvnbRcblenKXTMNk2jKYxf7?=
 =?us-ascii?Q?45rKsy7lL/OP/kMD1dThjKcs2CXdQQVYGkPQoJVBpaTq4wPC1Ro08aJb1w5a?=
 =?us-ascii?Q?hka9xRl1ZpaP6Hv8qVmBXVObjg51Q2xX9MxR8JPOLWJIc/rwDQ7mKIshf2aS?=
 =?us-ascii?Q?EdbvYPnxBcHLP/AJyjyVtvWhDz5/Z/z2/nhfpo6Qhxki1SY/lQOpW+dmXpEz?=
 =?us-ascii?Q?L8FRJAmYwHKVeFUj4dlrv/imD16HqLw62z3KhuUU1CEHFiT/yd5A0cAJxSDH?=
 =?us-ascii?Q?YF5I/SVbiv0zZwCP547VvcbKwc7ZTOiEthD07/q7CUZnvxr4k+kpm0tFbmFj?=
 =?us-ascii?Q?OhF4HR7dYucICkSHOLTgHC+vm/p9EMzOt80xOz7EwXWxFXYVEyvRR+dNEGm2?=
 =?us-ascii?Q?4+vaM9bZPBp7ogHeta5Fcq2mZDtyIjPkyaxUK9CK4Zlvt/coz5fLtUgS4uVY?=
 =?us-ascii?Q?10z50W+JMS9RbsI5lh80/IevS2yEQnts3AK+pkskt+bu0z727bVPMoj7/ZdS?=
 =?us-ascii?Q?QTekXFdjmJIuFta1AuJ8eyjqVzj8kINUFLTTdfLwH5f6GjO7qI+22NWm6llE?=
 =?us-ascii?Q?V6WnPycSfEAIhEB/b2i3HcIWS/domhEL9AXIldo6Sdmp99GLs6MD/f1h9K4J?=
 =?us-ascii?Q?edOjw/V6NBmOYRUd5CgyjEDBWy2pA2UASHZPQ+Tvnl7YFwjz9nf/PJjb8slo?=
 =?us-ascii?Q?bbiRuB3mTqrlX0uvD8PeXpREWa+pIdXGTNr9V0hF/PBd494+ywG2ojea27Hh?=
 =?us-ascii?Q?w8JRko0iunVmg4TRngm7UxYXsTYV5tF8OCDS/EV9UDkQ/eRgZostfMQRGPEd?=
 =?us-ascii?Q?dL+GMgmcuF4SxvIeoVn0pijq4v1FV4H8MUCnNA7ZRdrOaKbey3Eh5yM4/Mqw?=
 =?us-ascii?Q?EeI0T6mQQPAgGsBRVsr/9qrPFWB9BE6ihZrT11lZkkvmM37AMzBOYzzNNNx+?=
 =?us-ascii?Q?7jYF987fk+9PSkfB0BaCXOMhO/NZrhmPPQbWPCQkuY6VpX55AVrUSU45Razm?=
 =?us-ascii?Q?vEJjdwfaYSdFSId4ot5yPtdEUTITT2SgUsCIhM2WXTXiujCvDeg6ru9zmwqT?=
 =?us-ascii?Q?t9yeFvHc10dQ9Jh4ICkh8tHo/HZvnMYcRp77IHrKEv+aEENXwvHovHxuyeHo?=
 =?us-ascii?Q?a1tZjJ5O1bROCJIm0EA1Qwl7LAD23aZWrhZwi/Muuzh44aDTy1CB8FaUCWwy?=
 =?us-ascii?Q?cEMA21QOiJm8gkryRRHpPnCQLLviAn48lxYkemAwXYm8yj1AlA3FoDub+JXU?=
 =?us-ascii?Q?ZzPkem3Wd+VIuobxVwMlKg4N4q7Gcrf2W4J27AeZWC8lOsohcSDHwSZSXD/T?=
 =?us-ascii?Q?iM47IcD5O/O51KgjXNph0liKtOtgRH28pnHXEb5Yi32BhGvghrcHPhT9nKXP?=
 =?us-ascii?Q?a73LCaEX5YkMI+lohr6b8HJCOXmi5Zz2GOHVGjFueiA11wAmE00A/5hdpXHO?=
 =?us-ascii?Q?DQVeffYsaIj1wjaA2lKKN/na65CpOE7csCFz7YxIhlbUBUi3Mpow8PyTLo+G?=
 =?us-ascii?Q?kwpXQxHuEA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a365f4-b509-4bd4-5613-08da1cfdbf4c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 03:28:59.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0OOosCHyHb1rtyuJNnwXzNxFgQaxj+D7WVdWiW/nTGXRVecHgPDgkz03Z3IaMGpGOiRmrLithbg9Fb7o5Sevg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7483
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

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

