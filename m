Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE95AD402
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiIENfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIENeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:34:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DEC1403B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+qakEZrFF14H3/gBA85VFKv5mQbwOXC72xlT/Ahr8RUf0NJSW0rzW3ytu4MJW0px/PY0brYfH9YBIlAGg5P7BWZ8uQMomS0m6jb8AXE4SPB5att9KKk0FkdvnqMO12okRKJipU6oVsiMm7eDL7kmd4pWVbUlcP3+DYz9tRBr21y71CDZfHNnYplLURbv47UGT69pq92kIfMOalUMUNJ5QZmjk3/G5Ti5hisIosVdiSZMXne2rAKtf4lkQLjtXURi4txObTEX91wAjTuSsaZ+SuNjJtkY5Wfx9MUwW/EoB/cdn5cjvoo6HHDLGj3XMWUOP76ovJdi7vsXeFrwdZr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCssSUe6dhxjhUcSJEQkYkqaKfP+0IaIM6k08ekogHs=;
 b=BksO3EmkBuQX5WQ7KhDv4mpVe6WZyaBjoP8W/39bCiax+QYZvXBxs8BsDQ2F4k9/hRUJfK+n5keEbzbyeKj+xhkKv611trap5dasTSdSFlqXm/lOvTkQvEl51zqKJqdZwO0m3y5XF1pbZgcUWzzX/d01xAVGguyPZj6PNzrnR3XCy4yfJzJKUq8VwfPcf5Ys18YpjKnbQEsjNEN1NiQG5kdQ1DnrVc/besGmXDA1pI553tVyQ9k/9F6triM5fUrviQCf+C3syjvfhGlBQvRJbxI3ino+OGECKVxyLTBNEQNUrLBXcrpbHqjBjA5anaHnvA9LY33AgRJQWbRQeKRJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCssSUe6dhxjhUcSJEQkYkqaKfP+0IaIM6k08ekogHs=;
 b=DnDn9klL49CSoeabpj0p+fYeVpvoAl58MnFQdz3Ji+Il2RjNoJHklvg968uTqJTrZ2vJXhRDNava3iddy+RfouT1Tq/Z6HtCWP+7EWG2fvDVlJjNM6WJVEnPW+wfwGC1EOBeXSVDvvfRwdjxsLtGBLZznorJycSxbDpuwjy5nzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:34:45 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:34:45 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
Date:   Mon,  5 Sep 2022 20:06:23 +0530
Message-Id: <20220905143631.2832-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40b9e2c5-2709-44f0-8a37-08da8f436593
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqHNEGb/DZ5oKpkZ/vL4xlQWSaTXjR1T/549Ws8z7B3kEySxPR90I0QCKKwHbDPQbvE5MxpJ5oqwrUAXdtTPGtvVNiDlbH2pcvdKMU82vPG8sosgxV5waVsk8Pg9VnblRZqTZ3iZ5Tw/gF52CB/V7+T9+qQ0CRSxKTpgl1ZWcmpq4wtS0M+rdQsOA8vblhfWyjegJ+RczkB8N38J7dJokA9NkpICn2kjZYXYC+ntDuq+H03pIaMMQt89WJhg58Ckgpo0tA8LvrA0QiBDgyEBhcJNpQd09Zdz4glIxhEn+ann+2CVRUfySq0LkEdS6Rai/ol7WdDRCDh6+BckU3aVcTB1VIpe11JtnsL/OLNfO+tpfoDX9PqDJXbBVAhRcYuoltO5Z4Fo82dW2LmsjHD2iRglJVJcZjKr7F4+8ljZll/oxdS/sLTt+Na4eUNsVTZrxX3BuLm79dRemWTUIDmpZkyMqO76nK6lH/60pxbM288u4puUa/f0RlyHooCqNbgaYLBqtGKvgrXz0QraLM5RrUzmlUmmlPqHLx4qEE6E/oWkTEIrCjsNUJDUijvZxWxNdFz0IOBU/eWS1ds6HXmvt+i6hEwE7T1IM/+WaXb8YpW5C/zxHluHMJ0lwX7xXmcnIfTTXZHUWgYPrwZNquoFF8wtdv9C12dO8GNfcWzLsDOA0sPdbqeOE2trG+GvGhlpq0MU0EeldTOZgRbxp7F5currhaK6ZkcfHRxykGO/eoAA3g2ptf3ylr1HqLKPQvkKXP4cJNGegyvZ9g+WxrZeO5wq/HpOtVhUFKJ1UPPZdQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F93FGUQtoOmBhkhd/ronwrm7SZGCvHBWEzdTbGJMFKs7NS8k4xqdQx2F11A0?=
 =?us-ascii?Q?6/vTUQR3QIQSYjsOuvfCpn3Kv+P86H/9a94WNYF8vUZJuXqR3olCZMk7f2rJ?=
 =?us-ascii?Q?aVhdWK1zgvxU0PVccAcpqVC9QjXKOs4GuVO9CM/Atp3PBUGfOTu2v3RD9ASY?=
 =?us-ascii?Q?1h0s3hbnmVvauENfRNTJwxWoIZ1h1AXqzcne4HmD0GKsf1MS70/3TywxX2Rk?=
 =?us-ascii?Q?SUQLK+fdAPOOoaqd1Xx/7rWFSkwU/HnMBUricmM8XR0c0xxjqWtihTbCjhAr?=
 =?us-ascii?Q?YeZCXf4yiWsa37yZPd+U+ca0pGM/3cfUZILSADjifAA6n7kQNZWjHfRxlqE8?=
 =?us-ascii?Q?gMqZB4TUcXVoNmM9XuCCLfTZ1d5r47DJt9kh1LYSXWmtvHSZO7VISYRiRPSI?=
 =?us-ascii?Q?yOHnf48xEYf8IUIa+kd69enDsNWgoWNz60w+MF6OomjeTWL/N2tnNvR5OJBY?=
 =?us-ascii?Q?+qvAx+1deLYKMUoGeoJy8zWAKHSHLC6baWVM6rtoEW8fUHlUiHSfX5/P6UBX?=
 =?us-ascii?Q?VsQczEAlh5zFWuDMBEHlcj+u0rXr3wf6hX1dbuGABHi+Qku8YIpeJ4q8xrBG?=
 =?us-ascii?Q?gURAuzr1Tge3abka29miYQ/cDhkQ5GnWYeeGxWcpn4sY2vySmP9Dugk8gxIk?=
 =?us-ascii?Q?ThbLgRtDpyIPDevB4e2HOLosAvkvV0ts5/Rvj/aQo14bdz2tDfs+OoYxPRQC?=
 =?us-ascii?Q?eSGS4LswjtqsOGt39jcKLgoZlemubMUcCytMsNfnFQmQJryLe0BS3Fu0phD9?=
 =?us-ascii?Q?/EpJU4zxKmlT0vszIMjtpoNAM0UEEMJIi5vwnLsVJhywF3HFLscpdfwudG2/?=
 =?us-ascii?Q?MsLbwzqxnH2h0Ip5tcsziMjHbg130fyhRzM8cOwFmDNX8E7oAcxiSoH4qYGT?=
 =?us-ascii?Q?3OMg6PjHfa+xI1Mg6aTIgCNLyU72DTc7IJ1HUsqoh4jePmT0kx+ObYVSAX9r?=
 =?us-ascii?Q?U9NbvOU7zDytv8HDXfL6b16CU0q0GawWFiLScb9dd/QkjliyL+AWZOWnlQqu?=
 =?us-ascii?Q?CjWLEZXiCSxy2q1ZnbfBsKPOFo+03MMIyEBTs5qyN8MbyR1W/vSkNln18HMx?=
 =?us-ascii?Q?Wnpvpchn8QaNRGIbanoMDqZtvVG/AO8nJPXuAxDLK4Y1lyL0GwAf2hdtYLel?=
 =?us-ascii?Q?VXdBMLZ06oyZg/URe+yn7MvspgoL6B++Hl/qpLErcAkOeq0AFudNj4Wv3a3t?=
 =?us-ascii?Q?sINKyI3YKoHzgQ9osZ2QLEFwWnLYVMxnl7sDvK9f3joChkC/0DzoV5l0zHpn?=
 =?us-ascii?Q?1rTyXEaPMWZnkPYPDrbisampTl9nh99UNsMoLDLbKxRBx+vxCbBd2zw8Md1f?=
 =?us-ascii?Q?wqRYHpRS0APu845lVXyyXlxeMPtvDQgi3lORRXJhP3Idfo+Odkh3CRm5pF9x?=
 =?us-ascii?Q?iiBYiYxf2c7BWN9R+QNS2fN/h1zr3pakfT3DB77sZFL6FcBYQRwnEmJQ1+8Q?=
 =?us-ascii?Q?Q1VA1I5YAQOx2JEVW5LReIPAlV8DFCkyO2mvpl1f7dhvXcmd17pCrXSWMI25?=
 =?us-ascii?Q?WnkHh+kltVPACD8hPmFesoN71J0jPEn9V0e/nvfApGyzgDC/CxkDZ+e4eAt6?=
 =?us-ascii?Q?2J+pEIpTjREqIPXyhYgQOlwJNgzzwWF3ddidnYZj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b9e2c5-2709-44f0-8a37-08da8f436593
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:34:45.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgL9QgmUlAKduT6DiLUzYuDhIgLsET7r98DTigPBHpsD51RoBdwhIfdhF0PubaTa1eE6OW2QwxwvQ7Cs1AFLsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware Bound key(HBK), is never acessible as plain key outside of the
hardware boundary. Thus, it is un-usable, even if somehow fetched
from kernel memory. It ensures run-time security.

This patchset adds generic support for classing the Hardware Bound Key,
based on:

- Newly added flag-'is_hbk', added to the tfm.

  Consumer of the kernel crypto api, after allocating
  the transformation, sets this flag based on the basis
  of the type of key consumer has.

- This helps to influence the core processing logic
  for the encapsulated algorithm.

- This flag is set by the consumer after allocating
  the tfm and before calling the function crypto_xxx_setkey().

First implementation is based on CAAM.

NXP built CAAM IP is the Cryptographic Acceleration and Assurance Module.
This is contain by the i.MX and QorIQ SoCs by NXP.

CAAM is a suitable backend (source) for kernel trusted keys.
This backend source can be used for run-time security as well
by generating the hardware bound key.

Along with plain key, the CAAM generates black key. A black key is an
encrypted key, which can only be decrypted inside CAAM. Hence, CAAM's
black key can only be used by CAAM. Thus it is declared as a hardware bound key.

Pankaj Gupta (8):
  keys-trusted: new cmd line option added
  hw-bound-key: flag-is_hbk added to the tfm
  sk_cipher: checking for hw bound operation
  keys-trusted: re-factored caam based trusted key
  caam blob-gen: moving blob_priv to caam_drv_private
  KEYS: trusted: caam based black key
  caam alg: symmetric key ciphers are updated
  dm-crypt: consumer-app setting the flag-is_hbk

 crypto/skcipher.c                         |   3 +-
 drivers/crypto/caam/blob_gen.c            | 242 ++++++++++++++++++++--
 drivers/crypto/caam/caamalg.c             |  37 +++-
 drivers/crypto/caam/caamalg_desc.c        |   8 +-
 drivers/crypto/caam/desc.h                |   8 +-
 drivers/crypto/caam/desc_constr.h         |   6 +-
 drivers/crypto/caam/intern.h              |   6 +-
 drivers/md/dm-crypt.c                     |   6 +-
 include/keys/trusted-type.h               |   2 +
 include/linux/crypto.h                    |   2 +
 include/soc/fsl/caam-blob.h               |  44 ++--
 security/keys/trusted-keys/trusted_caam.c |   6 +
 security/keys/trusted-keys/trusted_core.c |  14 ++
 13 files changed, 333 insertions(+), 51 deletions(-)

-- 
2.17.1

