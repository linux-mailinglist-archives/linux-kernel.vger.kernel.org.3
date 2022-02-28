Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E4A4C61BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiB1DSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiB1DSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:18:46 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300095.outbound.protection.outlook.com [40.107.130.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3262C107;
        Sun, 27 Feb 2022 19:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9l02d7FKLE1+ZYoovvCLgr59ZOkhkEl6K3ujn9ySzPFupPxiWYGjkDM+bfMFnIcStHT3EX964Z+esfXZw3Jiv9mDuFHF/Ifh0/WCTlxVKQKAWYGnvAgXWvckfiXkkE7o0npyegDvKYhsrIskQqXPbM05WW1w/XT5HZMHPXMSrkiQ9ojAyANo+mVslqEdrwovT4AUY9PxfZUm09o/924Szl/rncR5MMFa9OPFPQWM4aGG00Za68oK4SjGvvqPC3L2DjO/s8b24HW32nq98vVl6b32m6TFgFQBbo1GNzw0AO0CjL/uq22O4N9DAj7N1RNiyQnwDv1wdysN8to1sQX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpqtCruvwxiE+pHD7DHqMHh3tVZqN7tyXreNG9q7zh4=;
 b=J5p/SLP1v7AzFjg5Uuni9jBHG9hhS9XzKgcg/9YH0HaNToKx1NUe0RKkcybu7X6IXF39fe2aOBLamSY3jqWr5pHrn44XOE57mmZoY47rqcEBv7fojcgV9Lnb+zIppG72XwCXN/kwabQQiqgpUNFvjTKPbltbj9AYDQf7xHnD61zmLazQEU0XCgyCKPQFPptkSOqZ5kfdTR8LNxjTQvIml5DyVt/f5Z4UPGul1fsJCc1H/yB3Mpl93tjssGGgGx2Z7etbaFpfVZ0LP4XaLd+Ou/rE9F9O64oPotPc/2HIhg64cTYXEpDbbBW0fPJdUe14Zm8ufp/SD9HAzm/qm9pYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpqtCruvwxiE+pHD7DHqMHh3tVZqN7tyXreNG9q7zh4=;
 b=Q0TYkKBg+oNJJ6AROtsOhD0B24IM+nvO5/uJV3/cxYmAzLBBc4r2C2nGf5GgDpz0p6KHpnitvxcjtSbZB3qN7FSD+VcA3mupVhPRTg26gmH6Z6Zz5LaQP3K1gfHjS7vxCYyTbnO7Kz3qGpYCYoaT4pFmT9orMt4e1ykP5Xfd0eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB4689.apcprd06.prod.outlook.com (2603:1096:400:125::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Mon, 28 Feb 2022 03:18:05 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:18:05 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>, Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com
Subject: [PATCH] docs: fix 'make htmldocs' warning in perf
Date:   Mon, 28 Feb 2022 11:16:56 +0800
Message-Id: <20220228031700.1669086-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd44b03e-d545-4545-7add-08d9fa68ef38
X-MS-TrafficTypeDiagnostic: TYZPR06MB4689:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB46890C4BE9C1CE02FF2B86D8AB019@TYZPR06MB4689.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0nPMij2V71A/6g+mTxZTbAYtLFzYE2BxbkSmpSPAKOO81Pf2U2PXLD9dCQUCGmnsWMKfpQyOFkG9aP1aAw83RDFEXOxh+/k9+PlaIIFScNbqhzUhb/vLdRdD8/rtkNFt3FNBIu5eJMsC3JRH9TZB7VCZ2499hkWVs/21e9ZLfEfLgEkdUFEKtS8lJkk7HN//CcSSSBitgNEVTklZP9vQFllkI1dgKK8eKdk8mDSEaQfQbMQX7L1jiHTyJxrzjqEa6JEhRznXCvp/8BKMkLO8nE4kxQWbXbzPEeuxcX2wBRw9zubAOCoZ9ARv5hwcqPYmhEc369neuxn8oLVnd67HdCrc9h4oQB5hU9rAJ32N8cjRdEQBvDs6267I3hasvE/ctephmx8hmTWGVlRlyATmKFVfz+tfl7xO4JxSEgCLKkx0gNQMOAyoypEfx9DmqQcsupOuCfJBSXrI+u12x0OpguxC33gGfj5iQcsrb9IEJo/kyaqbqWOJWe+m3ro9xW0Tu4v0C6UolxBLYz0BvOlHDCcUdad15OEXG/Gd3regp/q9IM9CNOYvHpJ9EOwaw5RfmTcMFh6v1qY+56tPOsr6XOYJ9MVolysb+py2a0N60ih7G0hszu90K0hSJhoL7OPMbM7dNPAuxypB6X5bFON9k7oI4nTg0uUedRYi/X6ttl6kx79q2Ca/hS9B9okprG+wf/OrruVuHBUvUOk+3GZuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(110136005)(66476007)(66946007)(316002)(8676002)(86362001)(4744005)(2906002)(5660300002)(38100700002)(38350700002)(8936002)(2616005)(26005)(186003)(1076003)(508600001)(6486002)(6506007)(6512007)(52116002)(6666004)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5FrLRe8Vj9r00DVIjdy7wgfmCmKD37XHJKtfbYxkQHjXPeIVqJlYIoGyPZBU?=
 =?us-ascii?Q?Zp6/I2ZUlVutpta3y4tsjabH/Vc6nq3vqGU2XG2DiF3to6bVbdVT7hfU1T4R?=
 =?us-ascii?Q?HaBxxsu+3gZg7MbzpbvCF4ao+7uVKLTIFWlgv96VQOAooGqfJDnIjQuWFcBa?=
 =?us-ascii?Q?+5P0Tuzyd9B1vxViQcI7NATgSV95A5cEjI3pjlpxQu71wyn4UIKeNf+mFWuw?=
 =?us-ascii?Q?ahT92OBb4OmvT5mvvx2ChR2oWtk164WdyTAeLx/wrJtS6xL71p0xBkAL8LyR?=
 =?us-ascii?Q?39DyVA/wawK1JzendBSxMQrUX6eYgGvrSvZj/w2FS4n+yvAgP2qjdNfzX22F?=
 =?us-ascii?Q?+NzosLE14V4MjIvmXT0RlEChpz+4pOVu/1HUEpvY2sBoUDvtbpYtyppJVXiP?=
 =?us-ascii?Q?1Qa8GaVTLCmUy66cf+OrTtHRQ8DCfJkbYKQlxpGIDdFmFsNxRoDAxI9a9MrP?=
 =?us-ascii?Q?TZV4qO3SpFYEuha22WG5G53DFK+PBbQReViW1ANk/mcRsh8/shalAK9Q+3J3?=
 =?us-ascii?Q?xbcX+A5qdjBvyWhTp4grFrnwFTw/e+TQfdk9u2GwH63sGTFtDs10xMblemSh?=
 =?us-ascii?Q?p8SB8AqHsSO/pu3RLQbUAc+oyFE5bbejA4oJnfvW6WyqRtqIUGuehjvhl5rC?=
 =?us-ascii?Q?sl3vqe4/XkyfV7lo+meEbEGtkFctmeKPCjFZLGv4un/hrXMuDjGX4meNbN/v?=
 =?us-ascii?Q?GKGW95tIhjd50fOica4G388A0wUYOa/aQeR5bGzJ77aCIQf1Q8lX31Ns5o21?=
 =?us-ascii?Q?Vk1ra54mKyJzs5WIDu9+EXu+WC+qUygO0akR9DhmJho9fb2JC9qORSU1ZLSW?=
 =?us-ascii?Q?6Cp546AghQE2yaZK2giYgdVLjGL3BapScPWZMf0c/PL35x8SYlSu9E0Jty2w?=
 =?us-ascii?Q?BZU3HkpkVLM2KYFKsCETyrUk57Wn3hMRwRC4EUd96nVo6xTDSDAcWPo6XZ23?=
 =?us-ascii?Q?fPnEhNOIoRRfU4/BmHv/+VNBTUwttOG+ppmSoFn1xlea0mNhcTOlow/dNpl1?=
 =?us-ascii?Q?hiIMvmlRXAY2Q3zgJwDaaEuLai0TXitEbeGneZDQr2sDiDqPIpjahQCdnJqG?=
 =?us-ascii?Q?pAVFw5tN4Ly2N0BdaIC1/nXX3e5VdXHweVs/fSfLz3strC3xl1gsjDZ41ICX?=
 =?us-ascii?Q?zZhuZefNcG4PRtfpZm9H+G8WBJf8AFwQk5chnjEQ6l5cPXk4Gj8QRDakdhZA?=
 =?us-ascii?Q?ZUBON2TF9Q0EAUzxnbHZ0FutA/OLEOc0c7cMwhAH0DHbTOUPr4pP8mWdayNT?=
 =?us-ascii?Q?pj9xDfywVq78g+5ZKSQpRwbRlA+8dVX0Tn5vtu7fxwVwxuPzJ+x2v0wOlMOV?=
 =?us-ascii?Q?i2197qxmhpCILTqvVK0A4cawFwESEj91Ex5lVYOKrC1JqabX87m4TjPZpvfo?=
 =?us-ascii?Q?T/8H/Ccr1SKT69E6fMNAaFRfEL4hP05I+U+tlvgrMxZ0Gw+pX/VPu4pC/z5E?=
 =?us-ascii?Q?nJWHm46hCkr/ejBcAmcQQsLIQNBQ9vMBGqUtxiu6tLNkzbU8mkYFv7HJFucm?=
 =?us-ascii?Q?zI6DOnL9dlhoiNYnEYZGRNTkdL0uK59e9LYp1R03/+qSjU9+RXbpRAr/FQi6?=
 =?us-ascii?Q?HMcAkoeScdQ+RXVz+37r8iA0258N57m3Xvd/vZe0FG41XwooNaO08Khx66Q4?=
 =?us-ascii?Q?Y71X5KGcmiN4oQIXlSPhdp8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd44b03e-d545-4545-7add-08d9fa68ef38
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:18:04.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSBVP/8QLlT89/V3WZWdgs2IsD6PkoKzw3kF+MOHmwImM+YNYioezDi5m9UZbyKAu/oumMWNeLrv9639Xrfxig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4689
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following 'make htmldocs' warnings:
./Documentation/admin-guide/perf/hisi-pcie-pmu.rst: WARNING:
document isn't included in any toctree

Fixes: c8602008e247 ("docs: perf: Add description for HiSilicon PCIe PMU driver")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/admin-guide/perf/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 5a8f2529a033..69b23f087c05 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -8,6 +8,7 @@ Performance monitor support
    :maxdepth: 1
 
    hisi-pmu
+   hisi-pcie-pmu
    imx-ddr
    qcom_l2_pmu
    qcom_l3_pmu
-- 
2.35.1

