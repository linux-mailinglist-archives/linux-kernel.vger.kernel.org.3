Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7D4FB6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiDKJLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbiDKJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:11:28 -0400
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40086.outbound.protection.outlook.com [40.107.4.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CE18E2F;
        Mon, 11 Apr 2022 02:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM8NOgCNWMXnI/6Ecjo3M7NJ/ay74gdYChYVxnA9bb71yffXdEaqf5WcqUwanVvB8AZH1KLSQ17EiLlFwzGs9lFXEgEHLmL1IFB1DXg2n6NyoR6hcbexGth6psGRweIbJKrctXnFCai4GVlH7njCAysVW+QnCH115W6LtS3sJn3KrWqsP5j1zOtDYKcclHAXeST89h1YSka06Gs9kBe2zbBQKIkF9kD0GIbNAf0G5Ot45Wgr5x+TtAkEcl08rnPIqVIce0nJ5pg8/sKC+3xEC1h12jHPyPrH0i75LiwkdvgDkGEUCF4YMPQ7wbwJiyH4uPQ5ZQUUx8of5uDZKTFudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUADi41ZDTfh5duwPWmsT84Sa7Jpb5TIYLdvBZLnSlI=;
 b=N9Yi0cKXTtIzHq34k7LD7JUb7/awcl/WNWt6p9XK9BpxG3vVHUYvxSdHUZoD99+DXX37trtXWbNbdnv3UP1BdHdyswf3Xuj9BQk52KHPafOfkce8dDgTfSgFvc2sSS+crViw+k34EYwg4MDlZUDUphUTYpyvzUUH7AOAQGV0lz3U8n+fCkKIoMMWmyTRrtjer32QE6PDVXQv/2ybRJxT8ZbAaNPejYLPpF1XsJym0Xe7Q6zhHB6KNBTHWQO6wkNx15zRbfK6iL7iDIjZ3VUxtJk0Zua8StfL9iHRAiocwqdpJxmZuup4AkAq8j00mTxYgnw9qaqHhhqLsEIRay63tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUADi41ZDTfh5duwPWmsT84Sa7Jpb5TIYLdvBZLnSlI=;
 b=dCtbLnYeRPLUolXuG2NDwKFW2Xz4qvWW94/2mClutJffTt00eQKCmmfS4hJoo/QKgkepNaf/XEDcYYe/owf17kSzESHpWoORdzt1ZMRE2tX6l1xAPWkDV1H+v7B9F0W8EFqOwyRoFUqeJx1FcmnlHYZlkY/TkOwXKwmuYCFyj7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 09:09:11 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 09:09:11 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        festevam@gmail.com, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, linux@rempel-privat.de,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2 v2] dt-bindings: arm: fsl: add ls1021a-iot board
Date:   Mon, 11 Apr 2022 17:08:27 +0800
Message-Id: <20220411090828.1965450-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0023.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::28) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 486c4716-bafe-4d45-d232-08da1b9af0ce
X-MS-TrafficTypeDiagnostic: AM7PR04MB6951:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM7PR04MB695150F3D13F4DE8B9554709FEEA9@AM7PR04MB6951.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9roE/a404wa0idH0rTePNs36imbkXKMLwm89d4k0OJh5Se+Upc3ijmMlqMLoe7Ve7fKYxcCIHx/tClmjz/Pn5hQXbnKE8UTEz5h4uYmm1xJeeqGmTLQErgKnLl8/YkiTWrWbqfA/7SkmMZDnBexkZbrCkJ2XloLPwZG9eePAA+KMO63x4YnpqtEtn8EYDHzZ8q+y//wksc77q6W/08mJ3IO/mmWq6CtnRif/b9fEJgRxRzVE9MzADRDQHCVKdWZpudpq4mGQjCEkIUqylyAFAqG63jGrlJ5WS//cqbGj5FAKnxM9LwE6Dtl4DTNM1XZqZ5EuHO22NQXz06pOeEqy7ybthBEqQOVs5ilX8XaM1+mAiiJcbpXtClBEQwvWomBnV4+VvRj/PU45uRZcbbS+NdczDjRWwyZYDjWYqIIMFuN6WTthdFzjEWw4GsseWSD59x9LdmgF9ZZbAR8MUb2BwYIH3WPZ/CnwMgG2zsggVFqb26my/svt186jwL2cng+uHwRWnxBgA78yTO9lVdhaMNiGP9eJZdVb3c04FoN82OwNFL3wpAaZ3Kww4cOVMV2MHabOi1VkD6+itFFAJEGeRJn4ULH2kpm/cyuWaIvcFJ0Yq57ZQUQlRxVWN3n0hpQABlOVTZ9PGgG0Ah9VLvciGc/FCkauZKWHQl0F0Uv/hHS42n1UmgM3utc3Mt3RlBmeP1unCCbZa9NK16RXtHCcNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(7416002)(2616005)(1076003)(508600001)(186003)(26005)(4744005)(38100700002)(921005)(2906002)(38350700002)(86362001)(66476007)(66556008)(8936002)(316002)(6486002)(66946007)(8676002)(52116002)(6666004)(4326008)(6512007)(6506007)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDRnqfMp13RgJ1pnsD5D8vgEPndnxHqrtO0XsSj4mVIbMhcG9WaJG4SZMthO?=
 =?us-ascii?Q?FKHXJhB8ZQgMj8Ua9ClhUaTmh7G/h9u+4zhVQkmc38O044sycwh/EL/OxlQh?=
 =?us-ascii?Q?mFoKEn3Z288FrKZAP3a7X0W+WId02UTdK5ehgEzV3FX+Q7feFwiA+9vYeqdg?=
 =?us-ascii?Q?i+VgiJIA03CbCD8QJl5TBG9cvhuRgLUq/GHquwj2Kr1B60C0KsD57SAgkhfa?=
 =?us-ascii?Q?qhEIujD+C0Y5qcRzYJR1LU1Y1+FpnuCdvQXBPa7oMR17cO0YSvz8BVkoTJja?=
 =?us-ascii?Q?q+feSzWeoNUsVO2BdKoFFzPFOv2uTzRbuO2C9fi5dxS5CRrpRXAUTBuKOJRt?=
 =?us-ascii?Q?/UOaE9+GTWY8kj2+Qt9NoSlPBakOo1ACnHrZPhGbVQTxC5JEkjgwvkHcERpf?=
 =?us-ascii?Q?mGbSAn7wyiHzhUficEUiFIMbx66B/uXc2VyZz7QKvcmrUXtRyl/JMNoA/m6o?=
 =?us-ascii?Q?Aa2Gu9taFJmBQLPZTf7dEt0ct5jvZrwPPNVhWNJx5Ils7zQ4eHsOvZYrJrs8?=
 =?us-ascii?Q?g07VapO6RxWrfpY149tJwSlDyzz+DJM9HyKp3xLdaaIODk1a0d1JerKz6nFi?=
 =?us-ascii?Q?geuevw9PzrPEljxL63jx67nxW8HtqxhAS9SR4bNJKuGAoAmrRXXaR070x1wU?=
 =?us-ascii?Q?AAbzC1G4tJvKDezFrylVRl5iFgz0bpVRvRjOhnFEUmwOyhpoLF0ms14/g9CZ?=
 =?us-ascii?Q?omWlyvMKlNWkkE4qCLkiPMPBZxXRLTQPvx4F6HT6w7NQEI7eDH4Axdm4F/s1?=
 =?us-ascii?Q?pKptC46CovgYvJvDBDIrEjhej0en5fOivG2vLjL167x8ij0DDc9S0r4PMkGN?=
 =?us-ascii?Q?cjRAjmkB1BQFHpjCtYPKz9IXdPeI4tUIB9as24H1/oZPvAv3qXriLMW1NweD?=
 =?us-ascii?Q?QqDP6fv4EfBvAKbccxtZtmbuf0YAKHMnAbmPHWbTjypI9yA9hNf1/ErMrMYV?=
 =?us-ascii?Q?qGWc0UCOdj5u0/+x7RJ+tX2eLabWyPUX8NJ1iGu5lHcSQkksYE6IUQhnrZdc?=
 =?us-ascii?Q?XQJN84zjQvi80uRF/LB0xwr2h3B2pV1/p1OSayxWHkPCSHgWAbHdW2mzrmV0?=
 =?us-ascii?Q?FGlGHSO9ijonIxBnoyb8GEfGNrQ7sDoIYl9WWw1UNFsG7BAINPQGKEMtNYgs?=
 =?us-ascii?Q?vA4Ypj4vABdx9LyampVecMBb1ZrFmrFI/kYy6hsMDpFRo1/LSKLwR4d6ohbZ?=
 =?us-ascii?Q?qqGfG/hL2DevxYvJIy8wmkz4dT/s4fdckz8zGrpP1xQ5+ftUHH/XnNqz+Y/X?=
 =?us-ascii?Q?IawJVH7BJ0uUD+vE15Ds0O/FitIXEuhdZEVcEMYkuEw7oA/EDEPaNCpaWuYz?=
 =?us-ascii?Q?2BB0TWg96GlGhaZgc9QjQ79bBC2wbvM28K0GgjClrgVcmEaxu2qSk3ao5j5K?=
 =?us-ascii?Q?rAIox4EcN0x2qP4fUay7Ogq8a/vtcU4IAj8LuN3VLfAI5OIy1Vhbxdkm7DZa?=
 =?us-ascii?Q?wTJwfAo9SRYPPh28IRSGAGqEEMbuetYKwowzCDyMJLjR6DkiXdK4dLVWc/Bt?=
 =?us-ascii?Q?8AHvJP+GAn7WCIfZFm49Asbn1nU2KBaLei+GoF603rVdZb6Aic8HG9IKMH3k?=
 =?us-ascii?Q?zgeZGmuHRB9IJtGDPBosOeMV+y6yQFTJ0nl8GjtWTWr0LV/jLFw00kcWqenQ?=
 =?us-ascii?Q?KkpBFA0unr0O5FIBqs7+G/PZ43N/OjV4q16yce+0+NqQS/SU6RJXr+DVr4pP?=
 =?us-ascii?Q?gnH0t+C06vh9Y3E/0MMZyDeBWxSJUGO8UHQnnR51ECLd6zVBB6S3zvQzMtWG?=
 =?us-ascii?Q?S/iiGVHl6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486c4716-bafe-4d45-d232-08da1b9af0ce
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 09:09:10.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzWCuWzCiLJs45Q/Wbbn25hl6HtE0DJYq8RDYfbrdBW+9JCVqMZJ5tbyERwCkLWsHeINifOHlYTcxZrD5EF8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951
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

