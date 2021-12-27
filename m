Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2780647FAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhL0HtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:49:21 -0500
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:37505
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230400AbhL0HtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:49:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxMd74zYLjLQs1ulb2mq/c+TZP9X+rq+LoKA2xOCS8ukPPMgH3GVGKTNN0/59UR7A+Tmt6tLjR3HLfOXxn0o8ncTTiLMMeDDiZxnpEWolS3IYo9xP0iuYc0XcFSh1Vl1oCUWKiTA8LHkhj9tU73fNJVRjS27kattn3+5UWqQtfgxq4kwlOjwNcka6FkoMJYtgeS4BIHTLLTyX/UWn5JuO2pmDV+XCSsWtvrz2i8IxU32Wv2G85/8AdQqQXCb53UiKF2xSeFLgJcqugO5wWGtCO7vEX4FTgBebFEDox6SMEn5bFJrAC0Njgi9scJ72Bpms4EJ0SzQuJvzjdPn4yviFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J32djnAkcBaFnl1UrLcoFW6j140iw5HNKlNl98bbiWE=;
 b=Wt9vWwAfRhfVuZ/7fkZGmBQdQowtNFqnXmJti6SpX637ZIqiML8Ar7be6Vkh3bnPs5P64+97RoC5wXWkUYTfFk+mXPZ4ozJtToh1mFRO+4sINzbnmAH4JmIygxQbrAKZ57dCgHqpDjq2GRB2oKqfldOxgFSFUmwcwnNy2r5Bv3dQSBZjCADxmmozA8AOP+0f56FQZwF/lrupnhQfT01IZo2G8eF9t6ZG3ttC2Enl6+teF1PJ9BhLCzso7pbG2ACjTUaBM8REIthYyQqH+CKa1fyc7IPimyIAx8BUWxvv8Nb444sOMmOKFD3K/8TB3/0OH0MsvT0e9QVca4467/oecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J32djnAkcBaFnl1UrLcoFW6j140iw5HNKlNl98bbiWE=;
 b=XNkQ/OWQP8ELgm8CqyZArZdLLpeFEglkfX2Ptg20Nm1Nr51s9GQN8FE2TcTLAeYoWcEJqCJnKu74zs83Io5Fqv2iCH51+3qJKh9NRFPri/FAdBEQQG526nyPuFEurLGo9qA9T11Peojv1zA4WGYJ80VlzAgMqeJiTIsyUy13Pys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com (2603:10a6:803:dd::27)
 by VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 07:49:17 +0000
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748]) by VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:49:17 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/8] i3c: master: svc: some bug fixes and add runtime pm support
Date:   Mon, 27 Dec 2021 15:45:21 +0800
Message-Id: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To VI1PR04MB5631.eurprd04.prod.outlook.com
 (2603:10a6:803:dd::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 701085f0-ce3a-45d2-33d2-08d9c90d6230
X-MS-TrafficTypeDiagnostic: VI1PR04MB5629:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB562980B54ED718AB19198260F3429@VI1PR04MB5629.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97ckg7cJtC/JYgY3fVatmhBufpOCSBPh+6tYtrNqIs0n0y4OfBORjnkbYdEYdArBsWqYDH4eqpn5+YkhFCIG/ewE3TOeOWhhmFoKKz0RfZBMZTBgn1asIrOHgFmIbhYggXUmz3C4d7nZ0P1mXIfi+yTiaeC2v0P8YjI4mzWAP4wZ9H/NLAA9moCl757l3C7eZ5CUXea5NkzipCraET4WRpWAuclyiY9BDw0/VeoT+40moGM1Byvxek8YrCEpT5R6WkZ+Hm9PPz7V86SqLHD4pECMGoPggwymoKPEI1sFt7EDiBpVNtBCW8t9pcXXSI3aZMG7gYhXlmw3J5ZCWztC1Q4UX2p680lYgE89eSC5AUTtK3E7Sz5KvvDq0lPNRFt8HKoumVmbkCPKFNErtXuBSCQ1/Ll6bzKvfalmOsYuBsylohWu9EL21cCveaDk5JFHxVHb+zDRMk5dwvj6f9iFmFdRebJl8jXKno/ZyDY8GMuzOnKm3NdKpAkOGfTcU2p+4pitQeLr/5pm3GqT1d4U1IAmL18Rr1KJp/2fK6Kts4++xZcHYfr/9LMcJ7Qn4gzmjkOfcbFh8Fq+RwemMP3seg015n0cqb2IeGAnaY5XH+kXfddBK7eavonEWMg5NVPNNr+0omtTAIAxV9nT/aaTaSHxavaBC+Om3x9y6VyCSi11/PpQu27yM4NKAhhwgaV4Y7jXu1KlRSnz36mOzU4L/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5631.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(2906002)(6916009)(83380400001)(86362001)(36756003)(66556008)(6486002)(66476007)(66946007)(8936002)(52116002)(4326008)(38350700002)(38100700002)(2616005)(186003)(508600001)(6666004)(8676002)(6512007)(1076003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1Dt6LiweQ5mxJM4drIXsIlFglGoHKXe7jTKfV6B3PM9aun+Ff25Qr2PHrRg?=
 =?us-ascii?Q?jjB/wu4E28EIzryMtR3tJK0QX8gbScqFmt5lN3EtwMosiaz8SfutuuMZJ7wO?=
 =?us-ascii?Q?whkrr9UUfztLLLpDmTgBFbTe7yGrTiwZv7y5xwjtnBYsmiivru/e910TNmHs?=
 =?us-ascii?Q?y+K3OQUEIzL39453GBP1IXxo4K/Ir+fj8yeSCeBNmPoWDLna9do4cIU5RvlJ?=
 =?us-ascii?Q?uj741Sle8l4JHQ7EY9LpI7xK+848Q5kuu+DdeIiCTr/REvYQHUvXG5QR8xQF?=
 =?us-ascii?Q?5GshgKhQk2TkzcDgazQPTqPm+Po2C0leqeIHwnYDsuEdrDZa8qypMrnYtgnQ?=
 =?us-ascii?Q?rIBdX3sGDKBCbzm/hNknvwHhqtofExBdUzdJUyfFouc+M6+5VPkHPUeOgeDA?=
 =?us-ascii?Q?wnilDg6s2LFv7BMGlNaupQgHR6A4fQxndsYys2NG8bdrfXIjAoVtTqFSxCac?=
 =?us-ascii?Q?yP9lVQ7hIlkD3UFICy48J0S0WcoKHQV9FpS/mNURfvJtXucmBGPtenvsLxy5?=
 =?us-ascii?Q?V53Uxevok6vNndPLXk38/qD46z1N+s5xXeHLsTqCJh/v/XW/Vw86pwHW/hqz?=
 =?us-ascii?Q?JsK41u32pYf/V80qZCyaP5K+MVpZWSdMzOSuNQijrXW+e2s1Mgg2YPzRbQm3?=
 =?us-ascii?Q?pwpGOJRkXCqpTmu69gmJB5Cvwpoe5JH2nGqMBV3kx011nG1YDf5WR5oRg18e?=
 =?us-ascii?Q?eVESwTtBPAx4ehpMyGbrXdDv3idj8cYjs/yhrKCO1v+5n8XbH7o0Ds4xvIOy?=
 =?us-ascii?Q?/nzwl5nATjzdQtns4N9kZGfD7qe/tLVT111T3jVN56m5HOZqRCwaY6KCEu0w?=
 =?us-ascii?Q?upLwpbMPSasBA8QRAinkz78q427VWaVmPU0mhK4GzFPwEs98kdgn++6hL43C?=
 =?us-ascii?Q?p+ddC5CKhhwvda6O3SL7PY7lI6oPfYxqEb680nojhuKPSe9vxRNTyQSP7yYY?=
 =?us-ascii?Q?Lm73H+1b2X55iR8Z6HswGUTt9XZca/jFrTOrX2ZAAB6B+zSZ7WBFdo/DYH1O?=
 =?us-ascii?Q?gPxY7P9ieotuWJVR/KQ5FcnmHb9qI7AeUavOZ3eAG9s+tiSvnt9BGzXhkFVB?=
 =?us-ascii?Q?1qHD+M/DwJvZ8yPlxwqvCdFTnmPCsMZGFuHdMt/qg/QmzQSvA0oLthCL7z9b?=
 =?us-ascii?Q?a8EzVU6kkC09E45vBj2f29jHcPMK80SRJE73lr0HxYIFQMPqAP8EziG2MjZY?=
 =?us-ascii?Q?X1pfNFGSQaZ7GT3Z31t7M4z+ikBhjkpDoJ3IWMNagQ0wpcG5mxDeLGeb2gRD?=
 =?us-ascii?Q?KJXsFEw2CzzhSvS7uRp/fW9hTRQ2KwpHq/csUbNB3R+aSL4PIDtgE6mwtGih?=
 =?us-ascii?Q?LhAVEKLckzztlXheSW5LZisorSqLk3IcPdLqEwTeVRdOcnEHCdmOJFM8/CyB?=
 =?us-ascii?Q?Ny57X5NCi7MOa6EwLdLZpZc8kQka1gi7YaT16Cd75NXEfDN7CUS90PLyuJBp?=
 =?us-ascii?Q?WtYUhzuQLQ6KuaAfVz6xz0JzSKwboj4cnxyn+n4iDF7LUXiCXpDaBpe+DioJ?=
 =?us-ascii?Q?jkwzlCgwR/N86pVrZ1VOKetYtDFKtCWX27PuC/4pKeSvka+YncMRWhoagxe0?=
 =?us-ascii?Q?SzTMxwQJ62876gTJvc8/FNeCHyZSSvSkhOq9yHpEZzydpQK7qFezb+/p2vIz?=
 =?us-ascii?Q?n27sjZ1tsEDXbW+CJJTGw8E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701085f0-ce3a-45d2-33d2-08d9c90d6230
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5631.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:49:17.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H25xkZXxmWCk3ezfaV2/0sdLzNaWWi5Crwp9H5CGZ7GM7jicMgQWAPo25pLNukwSOkXJoBG+BjHtwRftEePW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5629
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Currently, only the fourth patch needs to be reviewed, and the rest have been
added with your review tag.

Thank you very much for your comments! :)

V5 changes:
 - i3c: master: svc: add support for slave to stop returning data
   - remove <%s> in logs
   - add some spaces
   - !SVC_I3C_MSTATUS_STATE(reg) -> SVC_I3C_MSTATUS_STATE_IDLE(reg)
 - i3c: master: svc: add runtime pm support
   - create svc_i3c_master_prepare_clks() and svc_i3c_master_unprepare_clks()

V4 changes:
 - New patches:
   - i3c: master: svc: separate err, fifo and disable interrupt of reset function
   - i3c: master: svc: add the missing module device table
   - i3c: master: svc: enable the interrupt in the enable ibi function
 - i3c: master: svc: add support for slave to stop returning data
   - Only use COMPLETE flag in the read function.
   - Add a reset before each transfer.
 - i3c: master: svc: add runtime pm support
    - error path emit_stop only used in svc_i3c_master_do_daa() for one time, so
      remove it. Or it needs another goto command at the end of the function to
      skip it and to go to rpm_out.

V3 changes:
 - i3c: master: svc: add runtime pm support:
   - restore the error path of probe function
   - enable runtime pm just before i3c module reset

V2 changes:
 - align the parameters of the function in the second patch
 - add a new patch to support runtime PM.

Clark Wang (8):
  i3c: master: svc: move module reset behind clk enable
  i3c: master: svc: fix atomic issue
  i3c: master: svc: separate err, fifo and disable interrupt of reset
    function
  i3c: master: svc: add support for slave to stop returning data
  i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
  i3c: master: svc: add runtime pm support
  i3c: master: svc: add the missing module device table
  i3c: master: svc: enable the interrupt in the enable ibi function

 drivers/i3c/master/svc-i3c-master.c | 341 ++++++++++++++++++++--------
 1 file changed, 250 insertions(+), 91 deletions(-)

-- 
2.25.1

