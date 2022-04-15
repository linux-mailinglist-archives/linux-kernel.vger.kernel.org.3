Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272FD5020CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349008AbiDOC7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiDOC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:59:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B1EB18B6;
        Thu, 14 Apr 2022 19:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbwlRSRJmhZm73mCfd0cD9LgEiP3M6KYsATSsPLYX7V7tsJM1hZFHwjrwZh0A0onVoetALS0IkpoW7zF6rhiF+tUuVn6GBGtoWP0C28VNYZEeZhJDlsJ6ZqV+nlSdzYx4qRPAhWZ5DcvIhF+OyCFuf2VyMSSxt0S31w0L6Jn/vP0D+KN1HL7nUEm5QTpT6fCPB7CfYPeCuUIN/ZwG7ch/FuvCR+V+Vriu2+94hINRMp9tHVxzUmttdViCZlDLjGE+uP3fIepw121HvhLsNVPUi7BA29TDtZw1JjWRt0lx4+NN34c8L0yUKZPS1TXRjhjQBXNq+UBj5+bgG/EDBRJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihiURGwiw2sax1zrl8u0rLtR+PFsndv08LJdk5kLK10=;
 b=NMMU9voJe6KUfcF0QAoRPztE6ujvKuZ8JUlb1ZNsogDApdcmbSASSOBOFis0EMpwNSTozQ1BOzWA10Rpi/ClNAPXdKJ7OLsY/4tKkhWnCWy/MGGujtEi3j7TRUf5FksyV+8mxQirZYoFJoSDvgibko8jWvGpezmavWbOXZ6xBHC9Z1nKj8S0I9H6msNDarviUX7tvTfXdU2u/IdEFOD5LNq1EQ+km1K7Z8yV4dxTaaVO2RP3IJ9DkUy5YZT97qgE+aQWd5MSqw/jd+1bbSr++qTLECVns6xF8y2cl9jZbFNgQIvrcOoruWYB+MEDsQuazVhZHdd9aHsYCTXZ7sz++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihiURGwiw2sax1zrl8u0rLtR+PFsndv08LJdk5kLK10=;
 b=eC3ivhHR4CAs/qM99H77mRUiKCuKDHRvL86D8pBm0P7/6zswgbVTFlCQitepWnmnSzodYb+y3UFox9/ulZ/PcHkU6267Q9dNhNlNDj6KTk9M/bIxY6DOGt+fWcaHFEBogruwF51bshrzID8IthYNhQM8nOfuvJOCKrLZTLOuhKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by DB3PR0402MB3770.eurprd04.prod.outlook.com (2603:10a6:8:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Fri, 15 Apr
 2022 02:56:40 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 02:56:40 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        festevam@gmail.com, marcel.ziswiler@toradex.com,
        l.stach@pengutronix.de, tharvey@gateworks.com,
        alexander.stein@ew.tq-group.com, ariel.dalessandro@collabora.com,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2 v3] dt-bindings: arm: fsl: add ls1021a-iot board
Date:   Fri, 15 Apr 2022 10:55:59 +0800
Message-Id: <20220415025600.2019912-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::23) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fe5d74-5a43-4d9e-dfcc-08da1e8b906a
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3770:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3770AB4F4B7D8C3DB8629353FEEE9@DB3PR0402MB3770.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuTNPirkraFFip4V3TITH+csc34ccFStbClzi8HFBELY31dOjQ5TVjV3VTqCETWX3WYFokIcsPWjE0WBbzSULMHghG6qKFGBETxc20OtJ5X8pqN4jgyhjzKNgaDst+HdC1zH7lX/av2JRixiB8qWBOhgV5AwR0IxywHPeFq764s+DRWldwOVd2Owwc4D1Hox3YCUPXdUN8DVczFbXFaNsJecatHpxBslAAeBFqwaPW5Gi+Ih4L9vEguM4QJm2gSdajR6SPB7J6p4+HYUbH28Q5SkGp5wrr9EwnZVt0eGp6JrbbrJpApFug4AucjC9kcDYBBjmUk+ZnYxU0LGIte82I7ykOF7DNISFR9k9KqAQ+Z466IDeaWyOGR3GpfeWFkErO2gXWOHxoROY8JEpVMHrmLUmNnXNNpMOFcBhdbMC77TSpgwvhstuaaZk/4/8a4ztWsXZ1Iisv8yY3JOMMEp788s4qFo8noPGo7Rd4oaXKy2S3habsy9dKUyjHAfmDBmdJ1SI1V3AgR/EJ31D5IadVsgUeTCg4tWKy+z9NkEgF1d4kkGsxC56dAgMZvffJTZ5Jwq2JEs2CpabzP6FN309KnANay9KCE/BO35V0KBcglgXAxx1mkfXhJ7kwm8hZfqasFGpgmsNvZxGO1itDXrDvsQQfdQSEGr9C1FnwH/jQKmm12tVHiobl5o1Vsp0cfhB69HTqlEfxm34p/uecNBkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(36756003)(6486002)(52116002)(5660300002)(66946007)(921005)(6666004)(2616005)(186003)(1076003)(83380400001)(66556008)(316002)(508600001)(54906003)(26005)(2906002)(6506007)(66476007)(6512007)(4326008)(38350700002)(38100700002)(86362001)(7416002)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U27gjZmkpcUV0NamOIbdX5HpYZ3GysUqWcaNOsqlRkYi4OoR//tJ+tNb4SSC?=
 =?us-ascii?Q?1giYh6O2a/zko10UHv+SV/ryhX0xzZgKowxeKQDZMyCJxkG16r/we5o0NFV6?=
 =?us-ascii?Q?UhU1dOapDr04vfngOFExIXkS4H0d53dHBQKtoSF7qeTib1p2aL8e1HHN7xN/?=
 =?us-ascii?Q?PNXGj+FyhWEmhTFt0DSwXGpPWeyD0wYgxd5768ZPPN0wwiqTOVSk85JYdtgs?=
 =?us-ascii?Q?4sH0EcboR1d8hO79UXmk3XgBvrX+UxUgTfjnvPohKms6eyykEwOSfooFJ7+E?=
 =?us-ascii?Q?1AYGcqb56zp+GyvyxNzipJpdsEEnd7As9+vBQZVwtqKFDLczHkO9gmxsAQWp?=
 =?us-ascii?Q?h8vZlzdXsLgP5jOANEXts9ow6VFIPQWrr69WcHCb5wfov6QOSFW412wBm0y6?=
 =?us-ascii?Q?6w8VjlzOOnBgDnphtd45+nUsUQSOdS0fR7FmFYxqDW8ahhQ5Zk28slZhtqC7?=
 =?us-ascii?Q?aY3CDT3G5PpSGzGJQK/0ESAS/A5wVL9I5Btt5waNMu3+JsLfvYT4Ac9bOT/G?=
 =?us-ascii?Q?2deDmL4y/orsCLf6DQsJ9xbAkva+JFeBO3hVYYuXAwFw2mjJOvYZs0MDINKk?=
 =?us-ascii?Q?eQ2+VZvVzhsXiQdtHFkBibOSsgxusIBNC7mS36VIm4l4RbMd6+kjgU0Z5ZqX?=
 =?us-ascii?Q?76NR5DJMri5SPQx0FCnc2pFgRnbx6j4/kUIo/C/VS52TUKfWrLEeiHxvUe1I?=
 =?us-ascii?Q?d+6DETL+Lxf/2bdOJRbBVxnnrs4LzOp8tgxj09zx8wgF0BTdoGF9GMyEkDuJ?=
 =?us-ascii?Q?IBj8uQoep3wNted0ge2QuxyWAhz1CcivXeH3fMnmRM1Tu98QzOQ9ef1fJ2Ke?=
 =?us-ascii?Q?+uhby6qwsm6NBEwwYjToqfjBb98li1DyZupQMgSD7A1HL497fjnRVfAByE/N?=
 =?us-ascii?Q?4tqJHtuE5s06NZGR8mlMoLe+qqhrKlgKcHYQt968h8osSGdl3gcqMokGvKck?=
 =?us-ascii?Q?oafHFYlbObGCcdKUegNNiY6AqWDvuJ/LX5cjypaS2dE6v1Ovf4YFB8exX0dU?=
 =?us-ascii?Q?x75+i5OTmtT/mZ5nD9FiDwPoVcxeqnsMXa/ofATsVZAoWyTBgNdBXbbaLEj8?=
 =?us-ascii?Q?r+dU64H7ASQ5eAJVx4nUB5lqhbNLo7/ixg4LmwlxLp9lM+Lzn6AaDlQUAQUy?=
 =?us-ascii?Q?yslK1wLiNjSPvk+G76hlLJvOa76ZiRLkiJrYTMt1y/6BjtYX39Wsv1Uttyb0?=
 =?us-ascii?Q?sEXiKCAXTjJMtb9FSvYhT2qlQDPNT/AmSyNAE9L82pLwC1SX4W8kHEgXTHS2?=
 =?us-ascii?Q?EsCexR0CTVyNrrJ6cFQe2Je+Unk0wmAHwxKzy/M9AuqC6kZWoFESDu+htfdw?=
 =?us-ascii?Q?S3ydbjU1xK416Lbx6rgfvfttCccJEt2stIUQEIAloVslkfPuaVo7rw8V9k5V?=
 =?us-ascii?Q?jOhH65vfC5S+Qz8n4ZuE7RYbvMBRd2R008Wvn0a+CMUCOcC9jigZovhBNxqI?=
 =?us-ascii?Q?ZrfKi5P0t4Z++QEukphmaTcJtqRF2teQMqWO2ixAa4EcPqDiRQdVWd8sPnj7?=
 =?us-ascii?Q?3ysMaU7cN62fRHrlmVJx8BGEeOF7vLvPi45RI56b75h1kS8WOB4AiMExu3BL?=
 =?us-ascii?Q?bMbJouLDU53dqgGsEw6RbJuj+6PnYSgD72s+yw4U5yRLY5eN4F4hmbUJxAUQ?=
 =?us-ascii?Q?TVwKbU4ycKrOWRJgisfaY1EY3Ta/vG9eaJ7xVlXYt0E8nO6gFtoeSj9CSVJi?=
 =?us-ascii?Q?jo8tBzJjusYb2JeBAgkdjrX3BySdT2H+y8Z94e/FcFKVtGHf+a3EmLTyPBqD?=
 =?us-ascii?Q?DpXgFPpSlA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fe5d74-5a43-4d9e-dfcc-08da1e8b906a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 02:56:40.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWaG2nhIICaqBktSQkdQSz8eNfdlpjHcHoqXS9M/SwL3MixQMHYe+CsWZ6bxURP/zQqVE+kuZ1qs5UzX04nJrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board ls1021a-iot in the binding docuemnt.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in v2:
  - adjust the location in the alphabetic order

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..242dd99c272c 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -999,6 +999,7 @@ properties:
       - description: LS1021A based Boards
         items:
           - enum:
+              - fsl,ls1021a-iot
               - fsl,ls1021a-moxa-uc-8410a
               - fsl,ls1021a-qds
               - fsl,ls1021a-tsn
-- 
2.25.1

