Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324934E4CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiCWGt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCWGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:49:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2A70CF0;
        Tue, 22 Mar 2022 23:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijXXV0yTsTOjdSFFAcxHnknuwAMNbEAh0AXE9Vkb6aZyRO7ZlvoSuTqr00GtXUb7MRuItRT3jX8aZJbro5Sxlfjg1m3EMqQ1T11IYfe8/hizSQOVSQE/KrfC3X+TlrQh9il4N+q0kgDyptcsb+I+yykbMqtu+Tv3aJbNf4l8ZNs4nxnP7+DW4iy6Uw4DszCGHaZG+Qp+j2fWx4Ltx2QxAwm8xlXMAOA2grg+D161bUCTogvlAjtuSUWkzAhgiooBfEzm41y1lqLfHXHL7MAZkzndy00X/MB5FR6kAAGeQCBGcfZy0pcbDPqW/9T8yIWBDdaIUqA1+63RZS5eho+q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jB7wwFKP9zkSqWwps9bRMBD6xSLIva1rZJvKeDVjJw=;
 b=V0ombIWhgvzKEV+Teh9D6J/Ku/uJ+2kfTXinTzzNTmAigJknNkJfD+QMQOwohErfIQ5PV7zMKzJaQGSxZ/YBLlZkfCsFUX7yGzoogXdMYEbB2kBJkSYSGuI457rB0bJse1v8lZb0Cj9JzDyQiM1OpZXGwCnkJalsklFNSE+ahOYpYgUuZzYMhp3gu/8nD305pHapbe5N92dVIa/0WQ2oAoeCQObFR7jYgd9ue6YB62VGY6KAJETKMWQRa7vl/znSh/YsZ2gQOi3GUkWE0kUbJyhtTe2DYpHVVfEXnwtSi3gt+A5O2b7xGrkoK4MNvv1TrcJwSiwfNAswi7OZl5zMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jB7wwFKP9zkSqWwps9bRMBD6xSLIva1rZJvKeDVjJw=;
 b=R//IQOTdO54w961h016YSPPJF3j+R/Wgg7ot86lvsLZ/Y7afHdwtVcHgUPDN9BPhv988tRiKvEnIFbbTqvy3KOf5ancXxebz83jkEuf1eLKjjiqZvsb4zHNr4T3TY98JgvO33te9VAE+k9/dnMgZJHwZtF31Ik/644g03L4EjE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7379.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 06:47:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 06:47:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, shengjiu.wang@nxp.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] remoteproc: elf: ignore PT_LOAD type segment with memsz as 0
Date:   Wed, 23 Mar 2022 14:49:42 +0800
Message-Id: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b445bfa-baf3-4cda-285f-08da0c990d5d
X-MS-TrafficTypeDiagnostic: AM8PR04MB7379:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB73795C2F2B482D0F4D93C536C9189@AM8PR04MB7379.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zarDmfX8I+5jOHdTzi4LjuwQII6ppQQ8xYF19yP9mBVmzUl+8S8E3eDo/9+qsfDFIQA0SpS8Yl7c5UDc0lk1LkYP6iWHSesfAPJ37fOrgS4C+D5hPHKibY8yQKUe5ZBoMjXFw9+iXMrVtDS8+dt7DwJe4ZrhO9S77dvZH27fyPMfYYY4ydSfRmD2/oZ0qzUrzE0andbE/tMd06D+L5Wi/Cp4cu2eyMAer0JmI83g2nJ1EyOvP7LAnawt/VAo4zBvAPomdU5M1awTAbTCCUJB2hf4ZRxJlbC5ZM/a43FUhnX5qbvY3a02y7e9vEVeisjh/2/k2wlWRo3CamBbzBRDgs/m8/ZxrG7imWpA861mKLXGvVaS481dh6qgWjYXQMXp+JBBR17Wl4c6XOBR6xQMQx30ZpTFk2B5zLBKlQHACs9VpjhY9utYBrIdrIyC0pZe7i9iCjoVNqbhElemKMzuYcENYvLotlndQjpETMWZd0w+wSde/o4txyAcvRj5A/zIrMJov8rlntrb5xq8CTLHkO/LPZKH9QQKHCn1knX6ioVzTLnxkInL8bomkN/LfN2K64TvMCqGfH7joeNgIozZwJkx2LFwgHn7kjs0GKtGWs7Tc3QF2KS4GPukaKqTFZXeq7LUx2+4gm9G/e1dlQ6fk2I9VER0n7Vg3BguC6+49AR4Pkrj3Sd8eSDJOp1pCmxpP3+YcdIc/Af8mfKkuMFt+4N3EB5yC6/dtBvLvwhLO9WFJecCWw9+d7lAdEU+Ydv4ulLnpQLkHcT9xEhYn4bkCU5NvWnzr9efW5gR/uDsK00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(52116002)(6506007)(4326008)(8676002)(66476007)(4744005)(186003)(26005)(66556008)(2616005)(8936002)(6512007)(5660300002)(1076003)(38350700002)(66946007)(38100700002)(83380400001)(86362001)(6486002)(508600001)(966005)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GCY3PiYLBxfZIFcWbZPn6vs3Y8o3RHfFdZIKEUaKmANlxd9YX6NsU+9fD5Be?=
 =?us-ascii?Q?uIjCQYCZvlsFtqIef+P5686VlndrEfb+BcSiKnj/oFXSj3jZYOM9vFuGywRf?=
 =?us-ascii?Q?xKnixyOBYkzr5y8bPhIqKWM5YbkwGYPDKpDHmAy3CwvJnCeaTbtLl0NjKkHj?=
 =?us-ascii?Q?XEdgIlXlqqFBkS/5L1bunkBdH3v7cE8oHhzLR0h5ENN31uFLDQGRVrs5xv9I?=
 =?us-ascii?Q?j5xnpYy3iVn4tOjCOFxIl8vuRQZnS+bZq359w47Se5WaGAvVCtSPMmj+gbrA?=
 =?us-ascii?Q?pun7pJ2Z3iUSwG8ML01RKK0HNQDH+OEwa7uLPo82+LmnZAoxBNYbUJdpcT4E?=
 =?us-ascii?Q?BDTpKiqA6F2aw35CjbZ/ct3KyyycoDB5dPa+ucgVlifzk1WQ5Zz9AQwQ0Mic?=
 =?us-ascii?Q?f/FRiVlydFF4B8WCeipS15Dd6pDU8QQbNVPcDNfvqtKmUjsk3f7au0DnG7ej?=
 =?us-ascii?Q?W4JHE9cN8795g5Uujqj5xNS0y6gsz95qAJJ14mERC+ywcEwbms/uhC+TRZYm?=
 =?us-ascii?Q?3d+GCiCG5QPVD9/bZg95tLJt0IZBvR3242hTcDCc6DmWEQgV1tEbyGyBA8Tl?=
 =?us-ascii?Q?Zr5r6O/d8UoTLrxHrO+ZU3no06E/kLfzisadBJt/qyEJzua9DezGZA9kgrfE?=
 =?us-ascii?Q?AoOj61PoFTg8MiIwsfzfEwnQL4hj07R50wEQn1XbTL/qyfpKJMPSfbTsV3Kj?=
 =?us-ascii?Q?rUvuP4mgACCkRmTk9/Y0rfvMzqaS6d3tXui17aZG4Cp2Pe/B/Ul9WvYXAORz?=
 =?us-ascii?Q?/DjAtM8T2uohhIvn6FbRt2yEu27nMG+uVl9jvqlJ8CCYaKH/NNChfNXzCQTW?=
 =?us-ascii?Q?8TUTr2TjJQN3mQV2ivrKcgwxvOEeQVqIO1wGpmpTlRVuXk0qtJ9DXbQ3Uz/5?=
 =?us-ascii?Q?+x5xCliUKXJzI0/FEyGfupRbG+1vho/7Hg3Js6kUX+RpuyztgJJmi1iJtMW8?=
 =?us-ascii?Q?XhKZfuqVrxaK7QBZVWsomObcMz2/3Nqmb+wHq5X5rc+VqRfpkhOxlHsbfVox?=
 =?us-ascii?Q?E+dZNqbB6SdqumcPkMz3wrfFqxxETnkoV2KyniSIonDU1XubNRi6ejcBDC5W?=
 =?us-ascii?Q?VuVbvH2Io4ZKug7iHAdZrmWv7PqzuCMnrL1SDCcLvJNmID1HVNTNJwKsQ8N/?=
 =?us-ascii?Q?ubDNuh3sb3aDmCnzXMTqI1RThN4gwHy1fNds+9GOIVFsL17JvnKiNNBPhOTa?=
 =?us-ascii?Q?5ZwmQUE9rCP9ExojGBofvG5HTNTPMbhTX98o8P5cPSjrvbVSqKgaDUygWMQA?=
 =?us-ascii?Q?6i8FIOVM3uHvyKGBqCtv0rRX2/QC+7X9O5+bIm1cnRAolfPTcZ/XBTjT6UDB?=
 =?us-ascii?Q?VUfCvrooLWrsJwD5Gro6h/sqGPA72lOL9XukhAsHYiZNHTXSmJNq5qJnbJ+8?=
 =?us-ascii?Q?0t0RjY9sEcx8FkaL0GjyxPlKEI19zhTvHyq/qk+4Ok8WJvnkbrytFuQdLPAO?=
 =?us-ascii?Q?i8h2gJjDW5NshBnPDXPH5qtLVa6nKVvy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b445bfa-baf3-4cda-285f-08da0c990d5d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 06:47:52.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLXtVebtAMiL8BwTuQt2vkVVF/QQwLO5BHSTigHbHNFupsJqvEtB8pGzxioO7pQcPEAjY3LKSjA4VyaoBQN5+w==
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

i.MX DSP firmware has segments with PT_LOAD and memsz/filesz as zero.
It is valid case the memsz set to zero according to elf spec:
https://refspecs.linuxbase.org/elf/elf.pdf page 40

So we could let remoteproc elf loader handle this case, then no
duplicate code in imx dsp rproc driver

Tested i.MX8MP DSP and M7 remoteproc

Peng Fan (2):
  remoteproc: elf_loader: skip segment with memsz as zero
  remoteproc: imx_dsp_rproc: use common rproc_elf_load_segments

 drivers/remoteproc/imx_dsp_rproc.c         | 95 +---------------------
 drivers/remoteproc/remoteproc_elf_loader.c |  9 +-
 2 files changed, 9 insertions(+), 95 deletions(-)

-- 
2.25.1

