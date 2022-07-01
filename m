Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7643D5631CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiGAKpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiGAKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:45:45 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150047.outbound.protection.outlook.com [40.107.15.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3B74786;
        Fri,  1 Jul 2022 03:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk+B58NyQHwzE5Qn8UmKx++JmVEVFFDduc1nfECMDGldpiiguq6Tm6k90/t+l3SfoGigdaF7RF2tCVA7Qnko8sB2eivmNgUQvpNSLdCXTfxdumGog16BOS0+Q4sIpA69y6zHdYWZ5dpZ/ij7uwIM1DiAnX2eFB+d21V8xidYGxSrC9fMC+U+cb+llo8oXOTmxM6TAtOi6RFHhVEiGasSUmXoGoFToOIq8l/em1WlwFSIpZ7fX1ZJByGBS5epw0oaxeOmWWkguYpj2liyI/za8C2ctISx/9UKeDt1bwIJb699SvOHP1Lr+VwuDINkxcWozGjmNuCEaAiQ7E4dEP+naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mUwmIaSf5452WYxnGvJ9HEbWlI2cZBhQ3Ufk3OTzt4=;
 b=ZLzXsuVmI3qcmYCftg4bWw1+95FN+rxtCdR/haSWzfalGzzf8/lpTBMGUvzaOAacjodZ/MIvcC2SkerdriEj1Ku4p5e4X2IySS1VLKKxx52AXwehsyqNEDQy3VKRJEj5VrxL9JE/SOyn24ETzel90jR+vKa5nFsX53hE+7uBs7RY5d9Sa7QSU5XB6h9JTnVW9iqMZgaPg6PEF+lYzc9og7Y4u8b3IVq7lL9Uw8BPw4AmuGgKIkqFW7e/fRpOurX3XBx6ukuQugTyqoAmyTnT9EWXITH+XbvMa4cIY7ni6ESsA8Aff6U0p/hOB6m5j4QmDhNvDKCqdmTiPJCV5kCK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mUwmIaSf5452WYxnGvJ9HEbWlI2cZBhQ3Ufk3OTzt4=;
 b=dhV7s9BOKrgH3Zsfm2nTK4Ftw8vuT8Pt1surdNTeaf4TwtiD1R++dmZ/ip9adxgbGsnSehcaD64WsXe9HqjYxtu2xImjUXytwz83SmHIWfu+1UOydQHoqu23B/kCIadgJelBiEvLJwqlmGxC59oWAHG1xMkDou8wIZ4HakIIB6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4554.eurprd04.prod.outlook.com (2603:10a6:5:35::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:45:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:45:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Date:   Fri,  1 Jul 2022 18:47:19 +0800
Message-Id: <20220701104725.557314-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57a94bbd-e662-4b7d-a89b-08da5b4ed771
X-MS-TrafficTypeDiagnostic: DB7PR04MB4554:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRM0SgBd9GL69HYYY9Kl8Zqj3Cn/d8ZP/x6Ug9oHqiFaFu5a8wy+Z/2Vn3oG1GqL4+YddbKNa9zyFUlP3YpiRScf8mZgvBay01kjkowEFHgNxgH7QdSustDLibDW8lO87gvjhkrHyUsi6dptHnr3G7p9gbvSv8BRo+kkglFeZXrgdEEBa9RVd86Amqpzu6FVp4/CcY0cL5Ut4oF6LMweE1RAPrizJMMYhMHdtvYW0Oj8uwnRZPuhAK4OVbLGZxEBIoudngRZEdbz4HJNuWDT0aEh2pKgjo4Sn3lvPAXy/wAyCEeY4SE2DsCRzURMyt/Rg9fY3aaarxE7BbEXl8YQYFjxats+PyYNZKT4bVAxrQVuKr59ro3uyL02t5qizQKk1zFTL34lIy2L30EmK796DM9tK2d5sInud/hV5zEGu8I8q/Ic1Xrt+5jz28BQiGArGsmqDRza8ymxhVIpPS20qMpX/7qeIJVD0rjQTJ3vM2+jmmcsGbKh6kufORvu6AMfgnJMhThpbr1HCaT0btxmgsJJygK6wXJgVodF13Ejp48GG2YXirRW/woHbJYK46QAKeX7cR1zrYnMJR45KW+ax4oCXcw4Y9IUG3O0Yn95jVopDVjl/n7LFwOU9wlXFRJv8QK1z6XJ8Eu9hstUUD/+WLl+H4DSZDnEfzQU1v312VVfEmUxkqFKw0UVFtA2pC/tXS7wgLiZcou4OHhlNwZS9D8z0uBSMUtc52GwUe1u1fZuGvNFi5ut/WpFHRfoiYK6RHTMPAwbD7ZmsJ5Tj5wDAGGm7xdnmDUhd3zfXHbLp/rv3kEQzgHxZXK15ozDzakw5wYpsLnbvQsp4zsYAik/tLUiEo3uxivYo8tfUiiDkXMKCkmfGbEMBcvy2foUKAAzhfRGuCrYgcfQU4/4SVZCTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(2616005)(186003)(1076003)(38100700002)(6666004)(38350700002)(316002)(8676002)(4326008)(83380400001)(66476007)(26005)(66946007)(66556008)(6486002)(478600001)(7416002)(8936002)(5660300002)(52116002)(86362001)(966005)(6506007)(6512007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKX1CNnujnqiKtcuYoaalPoNVaEiBYJi734ArX3WruRsvId79Rwchap33QyR?=
 =?us-ascii?Q?E2v+yl0ImCpSZfeOj6qMpSufNptX0QesXbnaBNYw8DsOFxC8Zrvl0M91VDmv?=
 =?us-ascii?Q?4FzyjsnZkvlBcMWU9CjL6qD9awyV4L2bwFCdg/A/yidge3Wr08W0onDfK0Ik?=
 =?us-ascii?Q?FVoh865JqlF83pW2hcRJ/VJ5bNGQmQXmB78UsnoS82bVBU53XW/eU9lj6R5Q?=
 =?us-ascii?Q?7J8ZYN72JzQc8A5d/6xDj/9AiP/vzw7wIATKgejwUq99vLz9Px9Trhk5YeGL?=
 =?us-ascii?Q?UblntQfAI/J3kka2q5EYqYYmA26+G3BUGQjk5bmWf8SVFc15PLBlGsk737bV?=
 =?us-ascii?Q?vzEZthzoadlJh2PGFYZNJBQMkqg0TXXSAroTqsxUazgHJTbmPSl0j0JG9VaC?=
 =?us-ascii?Q?fB2cwIERvmjJTcTobMari7ymtL37wQo3FPL0heJzpvOsYfS/xgLqPhJ4UCMF?=
 =?us-ascii?Q?bF4Rh41gWUstzsEjptVAd2x6Aq9JLd1n/VbHeXe+MzHfKCazS96aEZqRG/Rq?=
 =?us-ascii?Q?DXwcT4nDwMBzGI8iKfa9GgJisygm4CDHQHcYGFxEoZbg8mbN2hBEzTzZg9BR?=
 =?us-ascii?Q?RVpdrER/4aPSpYdZ0ZLl9ko1qmin+W6YCsh0wchmVTakLgNcYhzykydLJSR/?=
 =?us-ascii?Q?OWnifPzXkK+08Kc2NWApoMTdE9fg8q4rE/JBUKAYMFofb+CDKi4sCXJQilWC?=
 =?us-ascii?Q?9aieoT5xY7bBr7epfTGqWs7Uep+y2yx6Hf6p0BjXHCYoO5Scwc+W57QrhAi9?=
 =?us-ascii?Q?w2KMn5CCFKc7W5860U1quK6wkcDf034HIGqIsNAs9v3i4UP8OvuI0lzyOyeg?=
 =?us-ascii?Q?t1km3rMv/gkkA8Ci06/kAj7fmCyXluu7U57JLjJtsFsL8XpsW4RTWQKZzrRS?=
 =?us-ascii?Q?6IMsueOKW5toNog3rdxyJCwsJSLxSw9j06BKbDrQuI5VvtV1eoRRbJc43QC+?=
 =?us-ascii?Q?Eoq1xUHSo+EV193w7q5Q+Tr8ZVvBUm1rZPHaTOcwlGNxHkRhQFtNvqHeUxaK?=
 =?us-ascii?Q?ALFScbzqGg16S1ABi0in7OAbUAFMt/Kwq7KVufKGjMSqLPt4iHg3QqcJfWiV?=
 =?us-ascii?Q?d60CwagePcac8mPTy0Io6jhwnVlybVsyWLo0zkRR0rKR3sHN0MMsdWMGPUKx?=
 =?us-ascii?Q?oKzfliSMgmKWMQzjCWDGuMhnd4IwrkMQP19BZKIxqxPtsMF1rgGHp2QlEdED?=
 =?us-ascii?Q?+SzxAba6yepceNlodP8/Di5T4zej7uY65F4yxDA7fNeIMlmGNYU+AiJnZHaf?=
 =?us-ascii?Q?rrdPtQPPUPgFzouVaEvkj2FDl1l9xc7TVDDScy24ixrNNx3K2UBIUk94FyGg?=
 =?us-ascii?Q?//83nDHtGNJr1FAW5U3bkcXNGkpk/cIfXJ2KqqkYNBRmKADnf9ru/Y+epFoS?=
 =?us-ascii?Q?o7sz2YbCccmm4CEzkKWfeOlbX8S9DGCEHNqHc3yzQQo+UAg36qzTmVt1HYl5?=
 =?us-ascii?Q?BDV4I3MyZMGK6Kwjl0VKjScNdevuwybmwK7XfgaTbGgtV5cCxChtJVguUv8P?=
 =?us-ascii?Q?Fj9M7AyW9lQK4EtqQtpxXCfjSe3NJC4So9qSqvC0J+YAYx0SkW/RQYpRo9tf?=
 =?us-ascii?Q?/FRzkmiL9GxXs7sdnPdwzjw7ocroaNNztJgvbFZA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a94bbd-e662-4b7d-a89b-08da5b4ed771
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 10:45:41.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMMKkLQqNepYgJ0kNnnLVpHoxC+rPIDywEYH3WSAPIvjfAdsQZCflTUT9YzX5PwOJoP0NKtLqsKrJwUZMzVG6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4554
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Add R-b from DT maintainer
 Fix probe failure and driver remove path in patch 3, 4
 Add comments about i.MX8QM entries filter in patch 5

V3:
 Drop the dependency in V2.
 Tested on i.MX8QM/8MM
 Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer
 Drop 'reg' property Per remoteproc maintainer
 Drop mcore self recovery, until we land in common framework support.
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220517064937.4033441-1-peng.fan@oss.nxp.com/

V2:
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220309102118.8131-1-peng.fan@oss.nxp.com/
 Depends on https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Tested on i.MX8QXP/QM/8MP
 Addressed Mathieu's comments
 Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
 Move V1 patch 4/9 out to https://patchwork.kernel.org/project/linux-remoteproc/patch/20220308065754.3355-1-peng.fan@oss.nxp.com/
 Update commit log
 Drop magic number to get entry address from device tree in patch 4/6

The V1 patchset:
https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-4-peng.fan@oss.nxp.com/

Peng Fan (6):
  dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
  dt-bindings: remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: support attaching to i.MX8QXP M4
  remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
  remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: request mbox channel later

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 ++
 drivers/remoteproc/imx_rproc.c                | 261 +++++++++++++++++-
 2 files changed, 270 insertions(+), 7 deletions(-)

-- 
2.25.1

