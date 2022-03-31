Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAC4ED5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiCaIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiCaIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:40:09 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE91F89F7;
        Thu, 31 Mar 2022 01:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv7Qi8QpLVAvLP8CjitXTZkVpy019cq/B07me6FUO6fNYUD218QJ4YsrJ0cHYDQJNjk9p4Jk3GAhS7nr21REEEpkQWnwv8OU3AK85v03K19bu8NtIIAbmo4Mu6P4zDOalKmOsa4dUXIa4EQkHvmdu5SaB7hUMMzjX8C3qvbCde60cD603uqTA9rlM3SlbF1ZLyfpv5JaQG3d9WFNDnyzPLWwh649NL0r24tr4EO6RNgCFQALwiHW8075pn6knQBhvdNpFSqopii5a/rahEL++6SAa+LSQk51M81y06liVbZjJucC1D516DLwfD+h3SApn2hy3KvYrXlo9RoBt7os/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jGjjxN6iyR0D9aECQFEf0+5N4VRIwyYCXpci6IEzSI=;
 b=QjQEzGvUn5VR46zocsBihcZgFelDkr5iNlQvf86B2v9Zgz3xvM0oe9ax6XjKplMlcVRxfKxQ3YkPLecn2l2vv3U+39KwcUIJc6WcKP1epToAi3kMBk/WHgLnil8jPvVoefPVb/WyQzO3ucmaQQt0h1MBNu9l+XyFAyjM3JdXbG3odgbiCmziIc9La1chdIS/QnH8I/6KN2qWzhajELK9u8AjOu+9fYcum3DrAqAYv1ewwNUhkFU7pnKnaxA5R9f84O20fTs/wyOvKHMOCMqE7USlfitU3jMt8od46dlxGm9XL/5YNzr1ffg2BuDkjpgmSIPqSYrzFSB1E4bj/ZmY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jGjjxN6iyR0D9aECQFEf0+5N4VRIwyYCXpci6IEzSI=;
 b=i1RUjKGOhB/pOJFJFs3J6AfcJ44imRJKUT7FJUz9u1BJdrNz8p7QD8ptnoWjoHhc8nWKZKxKIv+qLLi1Sj+4p5QVwPEczbuGMGVVVNBfY0sbkV/rQUjzk8ucTbyK0ViK7x6iCNrS5Dw0Pq2uTvjzgXgWWC53cX8yChABR94DXaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB3611.eurprd04.prod.outlook.com (2603:10a6:7:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 08:38:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 08:38:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] remoteproc: imx_rproc: Ignore create mem entry for resource table
Date:   Thu, 31 Mar 2022 16:40:07 +0800
Message-Id: <20220331084007.2323377-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29a813b-e00e-4613-cdf6-08da12f1cd3e
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3611:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3611C650188C9BFE3CAA3F4BC9E19@HE1PR0402MB3611.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9mzf/shOt5WPKL4Jh56R4jhpLmZzaeqXTLMwzMkLfPCmQqNX8dTStideOG0+jYIdKnc1u22IudY0GaUm97CgihQAnnEQqDAg+5wDNW1KkP85I4B5UfYWMYKxanllnsXeBJfbgVhWLqOv6UsSANL/tLxBNYZVi0Va41y9WHYp3jJoevTl31BArQMGDZi2cJxLg1uGEhV4+IQqSn0Em4tb7PzwsYPAxav64xBfwqybON0LRvp1rVE3BcUMYDr+11VgqtblfxyZFx8YQQjm9EiHtQTS/+Wx1GfYaCFeILbJHhyc+Ne/QdcueoL5g/f2C/HWJWA5rgg6beRkX2uLa2VxRqRRBALZFcCU1VfOSmw+J31VMxYVsLp6+TLPUffbYLRPhMdAwjkPCR8lWvcqatuapm72KrPuFoArR9U7GPSqnkZ9wH1EMLWSFIojETEKnFCDh625g9O28PYch20HmBk2NooQdLVc/5nYOZoD6R73hbwbec2tO3iYxIitI9CSb4gHf2nWk4O4HkJP8099nTyzp3zPNqmu+zIStMfkscQXMPJj6Wg3cuf+jQcKVKjOnYV2O0sbggjQIN4OxEzi0iEbu2rpB4L0BV5eHfhnC/s3zElEmIieN5frx9Q2k64Q7ImN1h/lbz1eFANevVj+cQC8pCPy61nr26W2mPKn+f8j+i8sDtnXukgTUO8wdOpdXKmm6sKyeY3sbFqS8vZL8GTiVaLjCIiwMfocGWN6xhiXClSclX/iDCVWPjbJbVoTCTw4wEnZpByqVHYseVkxFk5leAgvzU1Nfi9faqgdzOyqEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2616005)(8936002)(966005)(6512007)(52116002)(508600001)(38350700002)(6666004)(2906002)(6506007)(86362001)(6486002)(5660300002)(8676002)(26005)(1076003)(186003)(316002)(83380400001)(66946007)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ExQ1w9OtlXeFbLmKj87Tzd6opQp3JGaSGE6Ya+rKa2qdyztLID/3NDqp/f7k?=
 =?us-ascii?Q?bECpFoAJ83AqFM4yhPdppmfMj0VBIESMhazq4+gH0VtCmQ/UAcklturCiN/E?=
 =?us-ascii?Q?Vb+bbJNcuTL/1uDXcXzqNOtvPKnSBYS/FSVi37VXkakqBPvVs1gIqtPBtyLo?=
 =?us-ascii?Q?duxm/R5wbiyCurdmUZjTk/eXBDXIjDZ7AY60EBJXo8TU6y5h4Ux0+LJryn3f?=
 =?us-ascii?Q?MKtpNtIiIeLGfgdDoHgzuQFEsChPBfFtoGk16U7Mght/IgPK8n3yXfC8uuHd?=
 =?us-ascii?Q?0xhGP3F8N/CSX5a0BbmhkX+pqOnqJ8x9RtmzHUI0BYcaj8Fyeh8xN9IDc4tS?=
 =?us-ascii?Q?Ouo3TxyeLqTRI6AhXUELBokQnz5FFWhcoI8wAfhkKSwAMK67kkorYRL5RuY+?=
 =?us-ascii?Q?59Nd3gYqc/T4K+/KzMikDGFcMGL3bvK3SvFHH8QHuE61OQ54wedluof6e96M?=
 =?us-ascii?Q?VeAF0Drr+sdOt59zg+8qjzcdIkAkMTg7lDpYlaTOwtQYs4RJMaDsIR1OrudW?=
 =?us-ascii?Q?H7bExKTHQhUhzMf/NilKekjQLwa8vKZhQF/Du8K3ZBVQrluDnKH42+iDYErI?=
 =?us-ascii?Q?aF1l1svwdsTz2zDAZHQT95BeoPMnHUXehYlQe+guaQQQFhE+Sl1gJoiPd5N3?=
 =?us-ascii?Q?ANT4x0a8G1jQCOxaMXmAkiNdOTxdxmpVJbyyElRLcRjqLTgXHyclxXtNKwZR?=
 =?us-ascii?Q?H5Odp5DB3DZmt7D0x3BndiK/8913v9A/FcXf6B2UEylJmgnhcJa0d6S5I3N1?=
 =?us-ascii?Q?kJ2vvpm/EaTCME8M3BWLTf8+atP+S5k9BiddzFaCfcaDkXUv1NoHOKgfz6bd?=
 =?us-ascii?Q?x7oWExnEHUZj08YQegZSYh4ptuVmrm398RBd3MMAq8fg7A2KpL/0Vry3HsSP?=
 =?us-ascii?Q?P9WJFW8JCnE+sZOuGRM6IoeGgv+f777tCh/I2lWO4O7OasKK6FmihYSUzfmc?=
 =?us-ascii?Q?ujCMhPXSX4xSnMhzuo9TJQeoeYPuzVDUcd7XxGCCzDHAuu3w+Sh4TaOTkfTp?=
 =?us-ascii?Q?jbGziZeLbmCqTHn+SnV5wijwbfnFqIEYs7WrhPtekEuM2cJOb6dIIwJuav26?=
 =?us-ascii?Q?6TmkPXfOKPEacjv0LcEPNdJ0j4qRda2tD/eumeSdpCXkakR+EuDSio/4809U?=
 =?us-ascii?Q?fTZYOZp6T5s6psdvJOsOBHxfi4iN4F6pVAQgxAz43st6r8QJuI8lxrdL82+e?=
 =?us-ascii?Q?/SRLuR7zyp7zjssPvyoMcUptcMk/3+YDixmVx3/y4c44Awpg5UOY//B58Gvk?=
 =?us-ascii?Q?VXa1NMt48yuGxKCv9SIbc1Il+vqmv1Mpdb6auNztc8nkItIR0AXYSP3IB3lR?=
 =?us-ascii?Q?wryQRyW1Di57/WRfhgtQcV6n+gPdrSrKP+KIvOZGZJSwNDXlzAok5xH/ouxx?=
 =?us-ascii?Q?pORVp1HzrDwLNyHX29D4V71BnctN646lP/uX7ha6FWbi40BERwOSPtZyIXbh?=
 =?us-ascii?Q?G7vlUcRkiEcAXBmVGv7HYdVKye10mSby+FM9GCEVQW3Fo2Q7xoYVttkKs6+p?=
 =?us-ascii?Q?wHFVoruDO/dXpgf6SeBRga14pjvkJXjeMbnvPXkScPFrRzkanJdap2Ks5Frm?=
 =?us-ascii?Q?4sEYC86tGfjF9jqiSOlEM/mj/ssWJvDZ6OeVdg2QQ9Vtg00K1uOlZx1FDq9k?=
 =?us-ascii?Q?VYkNPrb2g0MBwgviy/oEUlScmMGC5DFh8veUj2aBIKaSLqrcnxzPOGA9jIIn?=
 =?us-ascii?Q?ymidI7Ghd5oyEEKMO00v8XukGb7wWu598OdG1kjNg+W+hBP4Se4MI34ef8I6?=
 =?us-ascii?Q?v0uGB2kmeA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29a813b-e00e-4613-cdf6-08da12f1cd3e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:38:16.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9KC1QoNp7/StAV8fN7moYypMMmM51JrQ/xB+fUU8/7iHph8g3yzQ7IYc54QqMdmApC0KjWMGgUWtax5P4utBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3611
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Resource table is used by Linux to get information pubished by
remote processor. It should be not be used for memory allocation, so
not create rproc mem entry.

Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Update commit log
 Update Fixes tag

V2:
 Add Fixes tag
 Separate the patch from https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-7-peng.fan@oss.nxp.com/
 Address typo

 drivers/remoteproc/imx_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7a096f1891e6..f2bfc9077c19 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
 		if (!strcmp(it.node->name, "vdev0buffer"))
 			continue;
 
+		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
+			continue;
+
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
 			dev_err(priv->dev, "unable to acquire memory-region\n");
-- 
2.25.1

