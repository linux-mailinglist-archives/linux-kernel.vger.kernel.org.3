Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77197538713
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiE3SJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbiE3SJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:09:53 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20053.outbound.protection.outlook.com [40.107.2.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845B8A054;
        Mon, 30 May 2022 11:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE1JDGoyA+R81ZqSrYz6TXGukYWviSjwUI80g7cPh4VXRJOyny1MxEED6ON5dY+yyDCDQRCsL4DdVK9N/oVyxlQREQnJVRQ4yHH3nw/aABOQtkafUdgCxiQ+v8q4mfB0dCteIPxdTr8BcGZm8qnJaXkn1wD9cFJiHr7yUxPvKJwFpaJgSq0Exde1dzX3i3DYXaLPmItEE9UFwtxqyuEv7O9UmP8OroXHiMu3k5mzbNAxNqTImNU4HmHnRB58YFoodJDRNO0exCvAuff/ay8z/GPVMdIEYGW/ZqKer6Lc908ATgSI0eXdHq0squ1JgVdLteJC6zCAJd/uke8md1BFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRrljajkmCpyW1/NHWx4lNkd+GqOd7VoemtMfuUIMUk=;
 b=WReDSNgJP5L1UCcBYFmL2b3wE8dKMMY2gMoY/RJJMXE1XVQOk9fBin9fhmtZMD90OK9udmYqinshQMf4Fjegbfh0kEJP4chXNqaNN0yZfxsXptJysNhYIr+HGIq/gTLUG7BB1QW6tUj4U5E6Lecy7GwcufkbVPnqfJi4nip8mtaU/WGBVKB/rbt72rV2RZEDe2RpBk7D0/RkaQCNbsi2qLh2z2nH6seC2BJbzFvRvJwJ2Lw3MTRC2XYzAVbgwmHYstA3RfKOk5rJCjGsu8LCCQHJliiD6twMIdIZoPcGVluEw2L6MK2stuwkOzFVXRdKQhe/B+/Cd3neUsTEEJbaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRrljajkmCpyW1/NHWx4lNkd+GqOd7VoemtMfuUIMUk=;
 b=Wpd4ug1LR4zzzwnog8dcdH/eiFbUIoEGVfKvAM7n9i4aqVzPO8RBwT2t1Vk4ybUBJsc28AViBpByoreSsyBE69v6EYVv+SiWlP7lhdVnkVvK0tO6BbUoJ6eM2A/RP3QLnCJ9097HVXIiymDZ0I+iI2U2cK5GB0WiFZpGoXXdfK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by VI1PR04MB4462.eurprd04.prod.outlook.com (2603:10a6:803:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 18:09:49 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d%9]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 18:09:48 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     horia.geanta@nxp.com, gaurav.jain@nxp.com, pankaj.gupta@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        silvano.dininno@nxp.com, V.Sethi@nxp.com
Subject: [PATCH 0/3] add entropy delay device tree property                       
Date:   Mon, 30 May 2022 23:39:21 +0530
Message-Id: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d532b9-ae5d-4bc5-d6d0-08da4267952e
X-MS-TrafficTypeDiagnostic: VI1PR04MB4462:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB44627D1AA4FBC9FA1F474806F3DD9@VI1PR04MB4462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7AzUVTkGj3YVe2Tuman87b5NLOiNZ2Prfvjve9Nv55A977RKSIURF9W6O5s8duB0pKhUK9Bb9YkyiEIJzITQYYBR+XDij4Kbgkdzx9ENYTj/K6LRpljm0rDW/gEsNnvvVlQoAeY+cWfy87DmtWB5WMf+vekNPBz96qZ7LekfUk5nw2s9jmHxrQWTAowdTJ1La8vh+sVuiI1QTrmHex+ZmVB/yLyKL0mdkCNhDWF6ImlEHLMDqjIMvYtIOMKKLE6evWFOflTTIjPczEcb2z7R+UNoV1DQbbiqe/iJvzujhYoBAPf9OGia0yMJCez25syKMDYIc/vSuLIbxqaJ9fyONYDNxaV0rPheCdqJUohsauN/nx2aK3osMOaVqXvisDGeDzKB4M6EtoXqWydDCojRq9dmDAJk3FilC8sdG6rsKHUwt9xveUE6C3p3o0GutsRkqdVJl0/+SDIw3L/ZFNkRAY0LrJbuzVz4mRPcYiBPM0pMWVgF9QS7wCpxt7Rm9KV1LlsbZs+cvNzxQqHaFpN1oq5CA9GDOj0BVvF/RwOVJyHzJlcJ0grCF7QRLuLplo/8DJrlVcYefFlK5qFwJ4Baj0f3ON5ydsnRJsyzQIriibtqTmyVHD/Q1EMGQg+YhCEQdoMQiLW2m7ZqQNTVpg48AdEYgGF2AwMwLHiPn25AYAX0qNIe/KPFJgBAf/gjfB+Mfzp4rvrh1U5eeVF4jzKJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38350700002)(8936002)(36756003)(6486002)(508600001)(44832011)(86362001)(4744005)(5660300002)(38100700002)(4326008)(66946007)(66556008)(66476007)(8676002)(6512007)(26005)(6506007)(6666004)(52116002)(2906002)(55236004)(186003)(2616005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LsSroSnJA51P1IhpmchJVStukHkF1RR5fzzTi/Kfurv4+A/sJy6KvSDaepIX?=
 =?us-ascii?Q?rnHgAUibgLaC5Nue4YrqyigryX2p5+f8oBioQdOnZAZ/6IEQXpmDcLd5wi/k?=
 =?us-ascii?Q?4tLoJPE1gM/AEFMouVRh0tcQj9TPur9hWzeChJiqOchRxLBuWhN3XPbLb0MB?=
 =?us-ascii?Q?k3LC7OjX8DpHpOOzByinE2Qa2qGQrAIvN/atwsERl2ef3qszZFpSWyJvg2Xx?=
 =?us-ascii?Q?nW9AaZvW+b7EOWetfDXjO8NH3a1LlL9AK7vZnaNYNiqFL2CA/unMY5FFcqsh?=
 =?us-ascii?Q?2pGBEThwSDv6WSaM5XSURqLj+cV5vmZxytmAOZ6oqsDl03yb8O+6Cc7SnR6P?=
 =?us-ascii?Q?BoWehguJ4PN03rnYIxhS/1ZoEdCYmwbt29OU4zZ4URLc2HoSxDr1bTHpOqC2?=
 =?us-ascii?Q?XebM6SIHFItPDqz2U03pXts1OfHHYju0nYPb5Q2s8Xg7/ebAcCTYl0KYWgPV?=
 =?us-ascii?Q?ogFSvvfTC696j0Cg2kzjX56tI9CSzvFvYhr50OOFJ3qrDFuMF0GRuc9NJwye?=
 =?us-ascii?Q?aF+Qf8EtFEfnyMLzJSqibD/wodpON5+ditBA/ZNopHxoNz10WYdI3IpGOyJ9?=
 =?us-ascii?Q?27LVuUgweFb7CuMkWH0kNIPz0/kOb0i7iT4KF5z2niUDKkt+3zRQcOAD+l4r?=
 =?us-ascii?Q?vmwnH8IfOkr8mKR9CnjPddZLXEkV+i5oRJEAhVb4CeTvMNiGlQNiiOb0rJfW?=
 =?us-ascii?Q?rqnHhlTjIMWwU1BZ7TuXFAPoSZM3U1QA6AXV9XKdeUDAT+dyHTFbDI57Ynof?=
 =?us-ascii?Q?MYna5KvenhD8n/27E7V1cCwL8d62fx7b17Ki63Iu5JotL54X2Bd0wyfw04Kp?=
 =?us-ascii?Q?jjlS+goRdAGuvDGJWDzI+Ykm6bo+U6h5ljQvXemNXnA1uszQsDGyoK5IrNEU?=
 =?us-ascii?Q?oqq9jQKCSoCxAsBpxmQfPOD8EiJNfkpu6x86hqnvP7BqiRdLEY9WAqCNTO1U?=
 =?us-ascii?Q?3L+9Pg0ZN7erFE/BU0y8+ZlQTvUoSyYDE7p4v0Dn67Yybwli2A73TXKqK/p1?=
 =?us-ascii?Q?aoK8wVGsyjQzwDzU89pQ0YUafDh1425qeQm04+o7Tjk4RAnzcvor6v58x8mW?=
 =?us-ascii?Q?OcGPQVYH3eeBBKe2nkLbOwK7TTH+MhRB45W453eGHZf+eLSIiWhMpj90RA5w?=
 =?us-ascii?Q?qqVctpqjf3PR5Oujz4o101rjg3W2U7cX7yPtjtRuRU8ijMs571AyXCsBxv4P?=
 =?us-ascii?Q?UV9Kwh0KhvHbKju0I1+LerixoU1su0W33P9btCKyenTWs7kL0xWsVHkRyQ3Q?=
 =?us-ascii?Q?pL2gWXK3MK03ARzsyl/ZdFKp1tV5LU0PQI1b4Avqq+j+UirT8Y5lewJQnLQ+?=
 =?us-ascii?Q?CjNXJIC9ysl7cdQbHRpLnuiSQjWgHmpxAFojFv+fZtwVvXEIt0A/ghoEXadY?=
 =?us-ascii?Q?mmSghoViBmB14sh7fQw6UPP8ITl8XuJY7i1WZoTdTvr3TdfpPrc9p4nxuP27?=
 =?us-ascii?Q?Crn3Ywxj2DoReeZiQ/uGZN+4G+6uzmkX/iLw5ktR841xCwtEDSGIJhGFOsO7?=
 =?us-ascii?Q?PMzvcRu4OWuOt7LYHoj6FWFGI/kmdrOQ8ESVYPhl5MnPPTBPt2269TrXiFiA?=
 =?us-ascii?Q?ThhCSQSF5S59vCil0pRJQo4Ot2gq3CA5qnPacc7ktLDs4S7Jhk6v51WAoQ1N?=
 =?us-ascii?Q?TEBNeWzznpbrvox2KOZWZy1MZjRHLSSr+aWtajYYTeaZadqfmA48PVYoTAqC?=
 =?us-ascii?Q?fDuZvYjdNU5EQ014N2yjNWdddZKwbEcZhgVQZqbBRzaoJ/IO6jlMmpoB27hv?=
 =?us-ascii?Q?7F1c9gqp/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d532b9-ae5d-4bc5-d6d0-08da4267952e
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 18:09:48.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZt2CBqkJ23zY6riq87IwDbVjLjsqkpwyVq5+wkNIzbGe2igEDZAhZDms7LNRrnw/TsnejyaJWTsVz4la46g7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entropy delay device tree property,TRNG self test are run to determine         
the correct entropy delay.                                                         
Firmware test is executed with different voltage and temperature to                
identify the worst case value for entropy delay on imx6sx platform, after          
adding a margin value(1000),entropy delay should be at least 12000.                
- Add dt-bindings                                                                  
- updated imx6sx device tree                                                       
- modify caam driver to read the property

Vabhav Sharma (3):
  dt-bindings: crypto: fsl: add entropy delay property
  arm: dts: imx6sx: Add entropy delay property
  crypto: caam: read entropy delay from device tree

 .../devicetree/bindings/crypto/fsl-sec4.txt      |  6 ++++++
 arch/arm/boot/dts/imx6sx.dtsi                    |  1 +
 drivers/crypto/caam/ctrl.c                       | 16 ++++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.25.1

