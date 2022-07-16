Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF42C57727D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiGPXiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPXiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:38:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D517A84;
        Sat, 16 Jul 2022 16:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbBxcYQzO2QKs8QiYRFNfZSkEulKmF7sE70/bzn0lIYUOkzQFT1tqJE8HEMmnugdUy1UN8EtpQGtFAf4YJcl2xF5lnsAx3055scCU9E3Q7aXYj6SwQwG5qJ6mXaa3z/dJFmdwUe5IsEhDkN5/y29/GovRuq7Pm7MsOIrqx5E5PfMmdJgYhp+koQsDmV1GOZRMcU8akhVbYlOnXCMUA1c/tej3oErMOSfe/gl4Y96yGEvl2WyR4++PqvD6oR9GOnXNETzPAFWc320ZAfpwPBbR1DCDpNs7TskY9CWMDtplU/m9ihdV8B/mYJRCxXCkFoEfpAAwEVzh3Bz2i1shX0/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyjhvi+1H1ZG5HEKMR+R9h9UwavLrDiadjEq6I0zte0=;
 b=dzImiEoOwgTa/Et5mB3thE1gfGwL001sdkXbUg84k7yehpnRwmT8U36QSVy0rhwUHdZqwiPrYjtMBISvHWSJhHaZ1kNqHDfa8AnbuN2emOCFyoL5Eqt1hr433z30VUNb6c21aADHaQw7YZy2F2w9OGLMNAX7qv1Nj6Ij6Ti3ZwUBxt8yBDL5VgY+Nax250Z5fGSoxDu5tZPPaK3bfkPazhzqNtuWwxv/rZKLN+sS0rEG99QKdHbp5ShBk1D/CRBONYw+Ij2wEEs5mRmxovtBcP0G1T51a2Atx+BzeGTOC3OT2rV4EMjFTFirF5l802euHHKuSNdU4SlHmhjTzJCXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyjhvi+1H1ZG5HEKMR+R9h9UwavLrDiadjEq6I0zte0=;
 b=YPxzQOfCHTCeNGiaNiIdL/VL9QYm+Thnl7jStD2fL4hZsm2WGdtk1cFh6+dHnG4CsZUEz6mJJGJWYUl/LEXeQrKxDuaM8ctESdNDBwC3n7yNtKQSKIMEJkA3kPLrCUMT/sMxvhm9Xo2xY5rTbUUXRho7m2WfaB1CLHAr+Z8w//U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB3997.eurprd04.prod.outlook.com (2603:10a6:803:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sat, 16 Jul
 2022 23:38:11 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 23:38:11 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 0/2] Fix kernel splats on boot with armada-37xx irqchip driver
Date:   Sun, 17 Jul 2022 02:37:43 +0300
Message-Id: <20220716233745.1704677-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::13) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e3dff34-f06f-4724-1eee-08da67843ea3
X-MS-TrafficTypeDiagnostic: VI1PR04MB3997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9z1ajNtiPDvlAMrctntNNIS0QmU39psXzQh2/YiRzWMPvapaTgZX+77L85eJuB+TCRIyCaHLb/36DCbQSELr7tZkCreyfT30kUxoaoqSwuasfln3jKlqw7ZAzdP7o3qxDzW/Bv0APA1PTohJnJ8LdPcwkAtN6lQQzFPptZCqepMNRKVyE/IweZaiXs7kOk+1V8JM+B/6rhTApkvA7F3GF82NA8rHr8+Xv8BW7sOtsEeRmmC8o6I4upLmcxgi46YBB2zRYxQnkppDwH+ID9vXXDSOw2T0e3JKI0hk3ZWlq/buujJQnGhc6njizZXE5yISidsXMQ9l+oq3TWje5H2ZSwa8Oiyuo4doFNUKcZ+KV5QZvME2REzQDzHDr+dsSh41fD6JrLxRGC10BQAcM+ZrxNdafEVXeWccu2HzJDaRP4bBot+ZHzqr1QajfkSURVEKpUbMs1FM+mSpR6cVXjxYfq4+b/NlNd0s6LVmDaFkQCyJkp2DJurXrM57z0JIv//yCkYw/wLuoigsIiMI2YgPouthrecp9+ZXbOzPC3EMN7x1W1M+5d7VXkXNd4o7EjWWhn2vI5W0h5dZNon9O2GYGFwRzaBZV73I5qRulYcBw/A4439WCemtPbbZdbmMVBHsvo876Fj4MGOSjCzvuRI4S3T+H2Yx/29d6yrvXwvndku0ezFDK5bdrhXdTJK1RnDjToILOeztsh4b8/S14Vu3/vSKOhH8TJAuSEb64zo2D5zfpl0NPOyL4qJH+PwedhW/2KQDkvNzihdrB4GxxMpvrgebykxsSxTlLdFU2nSGHVNaZCRyhUt79hRQlDYGDfKLhjnjlmbXPtythXLbwughw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(5660300002)(8936002)(86362001)(2906002)(44832011)(4744005)(6916009)(54906003)(4326008)(36756003)(316002)(8676002)(66476007)(66946007)(66556008)(6512007)(26005)(2616005)(52116002)(6506007)(478600001)(6666004)(6486002)(966005)(41300700001)(186003)(1076003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGjMTXyKHQn+/I1KIJmSJz0O1EhEDwd/Cdc9ASZ0R4ExXOsUBuA0EBBtfsRW?=
 =?us-ascii?Q?jjKFTCP/hmwA4D4pB/iZe+luiuxBp7f9DbhA3fKdB+UgnvGMMV8+fO1tUbeD?=
 =?us-ascii?Q?F4FKW4/Ekb8Am8xDMJOnsSTfQh2Y1sW3pNGmhhqF60DRVHk6roTN1jRqODy6?=
 =?us-ascii?Q?Wj4cJMPQA7FDw9yHgtZyiqVCMpDVSCB9++P+rzArCB1ZGdr6cvJcpg5cn/uq?=
 =?us-ascii?Q?2o2Drd/vYWppmOQRq0ogqqzzglG+rCd/vRQBmXtKSOaVLKjYBoaoTF5hGM5X?=
 =?us-ascii?Q?fnXWckpXbOsmVQYzGPBf303pKkaQQuj/8Q/2qIxToauEdIwgf2J0Rq6gvRHh?=
 =?us-ascii?Q?LW+Jnrx24SVXZWHIJeder1p8lQ9a7SEU8fJZFO6wfjqvQD27wMh7m9POx3rR?=
 =?us-ascii?Q?nAr7FYF6zYq0THLQraMUTMHtSA2ceD7Za7YE6VB1dvwvlAwEYV80sxpXu8qq?=
 =?us-ascii?Q?Xrwzv7LnjRiPyQZSyJ4P59xAlWjrtpB4QGZT0jVjL/N9YFoECCSwKe0iDenu?=
 =?us-ascii?Q?ufg/gsDZ/+Fr19emcyVNmZSoxCWcKStYOo4MFcx/RsLUPD7DjyEheVmXH55R?=
 =?us-ascii?Q?FG8Q8fAzGDzKhobF6I5NEx1ufxQfKAt5Txy+Pfc4fN5x9ISgAC/HwNRGEXSD?=
 =?us-ascii?Q?6RBFLlyBena0qgD7gvYjDw9FYpOLZAEKlK3CJPk/tep+IarLZkkUAymVQHa/?=
 =?us-ascii?Q?6vxAKRidTh6xGpThq+A87Y8Bo2O91R+q1Y2AzQ0Eh0AYjSworZtzUue4LMAw?=
 =?us-ascii?Q?Xn3vItLpbwqptBrqN/1OWxDTOasASwMO3dlGdL/FJqeH69JJ2t7jHH9PFDRl?=
 =?us-ascii?Q?7B5HE7KSvELfn0gwVe9pV9sdH37cAQ5gPpPYyJOrnmZpRBclJ2hp/wXkAK1P?=
 =?us-ascii?Q?k43h2dRpWEi+swMkIXoXc/y9FndPfb3n19fIsM2Aq99FYuY05lbzUoRFzBa/?=
 =?us-ascii?Q?GIWmRY3/zVdvkzqU8gsLwuxdSQ8TmVgxbVQVeUby0g5hHhptw8hPR8VltlYi?=
 =?us-ascii?Q?dZCYYE8c7PCs/fJtssDE7kFzhO5QHzOAf3HAN0i2Z7v/nRfoKiAMVclFTFOU?=
 =?us-ascii?Q?5vTuAHHMOepne9HfPfZ3CG9IWYk4+DPWNbYJF5GVBzzHArsENmgtDVcGCPqm?=
 =?us-ascii?Q?HGDcyjL0ejc1cnqZR2+pbgYepRpEaGs29mPJlF9PsGwT8DCzFaMjFny/rIdA?=
 =?us-ascii?Q?Ezd/gXN/Q2WcNnfVHeuCUel/8eRajMvh7swaMmrob6rsQPhnKHHDAGWSFa/g?=
 =?us-ascii?Q?gl9MEKgkdjgmGEE4ceDS8IZaVtJCUAkgLQuKWgi+WuAijneawgfPcdTJW5Wv?=
 =?us-ascii?Q?vjA0lEKefuKhgKmGZcZXJKZq539yt3+vPHW0TxsC8Q00yrAMDSEZw4Rl4GLE?=
 =?us-ascii?Q?uHn6CjqpgttJENFPExnrihykqrzMXwkdJ9dbr2y2I8ONm6NuF1WixidOZHnS?=
 =?us-ascii?Q?JtQPlgYRgYxYfNcozQ56TpiWLqYBDEon1Pz2gnfvtz9l3e2zlpFZrMr1qns5?=
 =?us-ascii?Q?JFvUos3q2N2gZsF2zPcXTZoMSPswnHRRCRgqSylVZCESeCOA8VmRROWFo96C?=
 =?us-ascii?Q?GFHzh7Ntqt8WZ0IK6FPWfbvl4WQR0/Y/ENVV56S2Yek5fNJrX3IRWck7fhDJ?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3dff34-f06f-4724-1eee-08da67843ea3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 23:38:11.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jxivxZaAFdVfiHW2LInuLuqZXKbnD/lv+4VWD3ytPtp2hJ35GDkynMNxgC4Q0x+bvd3F8QrrquH5gDpRgV9/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to these splats on boot, lockdep disables itself on Armada 37xx and
we fail to see further useful information about real deadlocks.

For those in doubt, the approach to use raw spinlocks for irqchip
drivers has been previously discussed here and doesn't seem too
controversial.
https://lore.kernel.org/lkml/20210825205041.927788-1-vladimir.oltean@nxp.com/

Tested on the Turris MOX board.

Vladimir Oltean (2):
  pinctrl: armada-37xx: make irq_lock a raw spinlock to avoid invalid
    wait context
  pinctrl: armada-37xx: use raw spinlocks for regmap to avoid invalid
    wait context

 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 65 +++++++++++++--------
 1 file changed, 40 insertions(+), 25 deletions(-)

-- 
2.34.1

