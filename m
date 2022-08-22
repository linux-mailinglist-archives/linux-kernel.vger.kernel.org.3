Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862CA59B9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiHVGoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHVGoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:06 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B3183BF;
        Sun, 21 Aug 2022 23:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRhBusfEiWHZk56T3WVnVvmEj/g2XDFx/hhoDfUoD98KYRcMZnGOvzVFk9EIBaSI/G9E+KkT6feOYTTRtqnhCPXUbjS/4nTaVOqkGbgsz8C3bQJ7XqZr812Sz/BRtTjeN6wyHYAbRD7EWFAjEkFGBf4juPBgHpLPr2+pxWc+oJmUPkLSBN+SDRr7BfPtX4D7pnAxxC1ngkvBh3Ht7dvG5iKQHR6JnRk1ulvYktD62GpFjtyaVRmS0D+wshCtkzZVA5Evi9m02IVbCZcpot24Q2/vijlfJ57qVJiivTRf38reOuXEY5N2z1qgSxUkG0x1aZQ/t9vun/Lhx4W0Go9aWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjs2rcz2qXYZKa+02cvj9bp6YIyk0vC9APxn8N1gtsk=;
 b=AhNQaXQBWUir7yhbKCkDoFfEJYj5o9bfRCojJE4JpjxHwUsUg2LST3U8t6btpM5yGegANrSBG+kgZLfcm8CDgaVJVrkmD2oJsZ7q413Qlp7w91DLISlbmp7CzE8QGnsx2A/iLo1TBXF3JMcerFYe3ZVCowwfqvIbr4B8Dq8bo5v/gdWzCo9ZMQ2mE+vMIw143YCIqg9OO85WWFdGOi1Mw0g1AJfdsDFjvurupz8ELrRtZJHW44KMMZqU4gewTjBbWVU1pRpKsZEjO2SDh7d4piGZo3+r9waJa3i8cPfMZLc6RY2qOSjA9sVitJYVZC4MJx62o4LtydW7pZA/fnLydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fjs2rcz2qXYZKa+02cvj9bp6YIyk0vC9APxn8N1gtsk=;
 b=O3BF41lKlVpravkoDMNeEOhPqOk9x9asH/2MXoNmwAeIzWQOX53Oxusyl8SNnWSKa+PBBO/YOoYn/rxgtH8C6+z7AzRrLi3AZ06qQoelNfzPDsRkhIeiaaLQQZM7CR9yo53FhuVnIZh3++mMUGTpnnx4+qwINWSgYROmyHbjJWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu blk ctrl
Date:   Mon, 22 Aug 2022 14:45:28 +0800
Message-Id: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02f7b91b-560e-4ae7-4f00-08da8409b32a
X-MS-TrafficTypeDiagnostic: PAXPR04MB8476:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYLhGMSoBzxtq6PlrAJY38mE13F2m2vWv3F6VIWVQzSlbXaRkjy7/+odk00O/h0ua00ScvIeQe6OQU0eBkAIDMVYiwmkj60ClzDY2ocf+O7SSlIxz4Xx79EPvHsdfejsBuBzrYMgvzLf5LO7pQTS87xNKXvNZAdKd90Ttbi1J/09MF2mNt+4vylWQhI7r7usRrj3Uya8vGC3S5CGQs1eR+CHSPa///dHcVa/+LZoJnoX/MpgD9ekqAAJyOhwdwQfS7WgvnuIHqQ2L+UBDzrXHPyXv7jg5aNgvF//S96nCzdBXdKeYtNX+pXgqy1PHKWnbSuPEyl761D8QlSnHXbiTwjKJM0yoqx77sKMKRZoAverjMXYIX0JAyIyaKjZ/H9XIG4oNYRtaV2VGOnAjHLkSYHQJy32iaRnE+J8xKG0nokHlFPpgno6ND5g6W/JMbeFcqeF42eRsic2TzK1+HXsLT8+vL1KN0zqGbOer3bidJNKLpOQ0BgIkXjJqqPLXGzFv2RcIpqXoxdwrENFmpMkEsD8G0bckmRNA6hi4wH49WrWaZXfKuLg0+tQ5DW2PqTeBfVsnAJIAypHVo7csk1zmPECela3Da21/JFIImsueZ7qYcJymZ08vJ1cKzlI4dy3XeZahaWzcFINHSnXHFTh2r5wglaTDdg26f+QzSrV772x8Drct0z/CvecFosSqvLmz0WKQOwaesVmy2McjKQqp+3DzUHW4CrBm3M8Fav2HazVLNjKdkGZJ7hvK+UP0WFfnsJFEEhnveDwySTl5x/SWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(38350700002)(38100700002)(8936002)(186003)(1076003)(6512007)(26005)(52116002)(6666004)(41300700001)(6506007)(6486002)(478600001)(7416002)(316002)(2906002)(83380400001)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWT9CoBewVYo1y2YlLRKjUDvhH2CqbFFYkIy8lxQMaCMvkeqSKYl6WAYm8Hj?=
 =?us-ascii?Q?faU1QRDRuHamYWxVLl1ad1lxdnDRjCjd/VDk0cySn5/fpvmoETlNXq02ZmPb?=
 =?us-ascii?Q?ZYElLZWkb3Sge3rFaco8enJh+6j+b14CU6wrRHd60Fu2+FQZM1OU2oYrIgph?=
 =?us-ascii?Q?8AC6GuMWFTD5HbOnlNiw01mDpbGneLIE4H5PQODXxXRd94AxSIMUNVMJ0DvY?=
 =?us-ascii?Q?XqFevFHAXfH60rwiRWhkW2imZNPdXcYi11oa640DfptcHD0t2q2cy0Bfaoa0?=
 =?us-ascii?Q?jULhKhKDcDBv7Fr/AHwi5z+jJBmcBYPPAA3JNXd3VFSJ3z5dhVQkNgzMxq4R?=
 =?us-ascii?Q?mQO7IzNgO/yl0uW6Ny2PdulZfIEySQkp2PG0OhhfmJjWOSWwDyNOTpPzm4+t?=
 =?us-ascii?Q?FHkEdnd0D6TEYaeL4+jHbYTXzo89bEZGGT1vbTyVHLUELZQs3zdAVZNpcIMh?=
 =?us-ascii?Q?0Kl0lCRcg3GQvRdskBZ3Fu4MEQFZWrgzXGR1m3DMcx0RR6mu9HPmrLBzEnxU?=
 =?us-ascii?Q?eSNdeCn8GdYGRXK4FC+97B00RwX5jDGBO+YJdBNdqBmRACFFijA4/bbe7lGo?=
 =?us-ascii?Q?5IHOMIakcuNEZdVLwQQDDPWqWRBhsjFJwHeYb6CVNCHB4GuLRJ1h9LCSmKJi?=
 =?us-ascii?Q?Ph2nZBmSex6hR2vRjWNsCMoNbB4B8DgrNZB0AQ+zha54lEysdFpPSZgfHbEl?=
 =?us-ascii?Q?/ZG7VNs2vCfuaaeW4ko7115gwgeHISEItjpQhywhqQQ9XDE3uZaghtIC4LN5?=
 =?us-ascii?Q?Z3iwq+TLfEfVxalZHePpoI/fNYepz88M5S5dLPlj+yF8AMb0Ngo6OoBK26m7?=
 =?us-ascii?Q?/RvZ9D2yWVCwDy4D2EJvinLvkFB1GrSRjjJiZ/HGkq5WN339WtnhvA3p983T?=
 =?us-ascii?Q?UIswkg0pxiJX4YDcTXjO6ec2s+ht9CvFnYI3n+47qEKhyUwrIcONzEiEUoKq?=
 =?us-ascii?Q?7RbEo5HL1poHRkhhYA1rud7LQCKMUwI5dPxcZw5mrO1p8j56FOZCVY6Pfbo/?=
 =?us-ascii?Q?bazpJlbImj6sJK5qd4pAWwzXIvO1lbJ6iS0jxpUt3xuxGISyqz99t7uvcqzh?=
 =?us-ascii?Q?IjxfM2GIFa9ESZPPAnruiwlYGKiGz4VV5vCKAyFDVNN8xdKJoNHTxYYkFNtV?=
 =?us-ascii?Q?6BCT2ruLBisDWHA2skXMx6HhnuQEOASUZPOnCJeu5byCyiFe61hc2M4Oj7o1?=
 =?us-ascii?Q?UGIvVVLxc2UbQFaFo/RBJ9CqVX9LR9DMaddm7xYTjysn3CBXqVh5IbB2Ykwq?=
 =?us-ascii?Q?/jrPOIhnyCN3/1AhYpnAycxo3Kff5TUB/Z6v5FKuC7qnMfYHBK79BTtocZC/?=
 =?us-ascii?Q?xK3EH68Nd6Uhns5tkWoBQg2dDxxT2f4TOyr+6gItxkP6KAhpc3bDDk5MrO3G?=
 =?us-ascii?Q?Exch/vQg+UCk8dyQeR/sy4ULHghF9nBqxfmEDy0/VkXTN+szTc7NSvlWokKt?=
 =?us-ascii?Q?NbWP46o3C63OibG6ArBtL5b0yXFr2XVWsrJPHWYltLUOg7znhb1lK2IgNw4G?=
 =?us-ascii?Q?XU4wptaxnxy3xT1mpAwpeenWPzNjO5KXJui0YxKcRO3HgvoZDP140Mp+g1DV?=
 =?us-ascii?Q?epbYzmDlmHdhC66skR5a94sRvE3DZP8rCXyQ2t7z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f7b91b-560e-4ae7-4f00-08da8409b32a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:02.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIiwNUtvKYtT7mKzCfGK8P2vk+PBvp0xj/+QCHpFhQXqtmmcDfsa4+9yzCZKfRzfkU+6l2AzSZuNfmmjxbB/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Add R-b for dt-bindings
 Tune order of vpu blk ctrl node per unit address
 Update commit log of patch 5.
   - Per HRV, this should be detailed explained in HDMI HRV driver, so here
   I only say HRV_MWR(HDMI RX Video Memory Write Master for RX validation).

V4:
 Add R-b for patch 2
 Add a new patch 3 to introduce interconnect property for i.MX8MM VPU blk ctrl,
 same to other properties, i.MX8MM/P could use their own names in patch 4

V3:
 Per DT maitainer, add a new patch to clean up minItems, see patch 2

V2:
 - Add A-b from DT maintainer for patch 1
 - Per DT maintainer, I added description for items. To
 make it consistent, I also added description to i.MX8MM.
 - Per Adam, change VPU H1/h1 to VC8000E/vc8000e in the patchset.

This patchset is to add more blk ctrl support for i.MX8MP
 - Add HDMI HDCP/HRV BLK CTRL support
 - Add VPU BLK CTRL support
 - Add PGC VPU node which supplies power domain for VPU BLK

Peng Fan (8):
  dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
  dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu blk
    ctrl
  dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
  soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
  soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
  arm64: dts: imx8mp: add vpu pgc nodes
  arm64: dts: imx8mp: add VPU blk ctrl node

 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 110 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  44 +++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              |  43 +++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             |  30 +++++
 include/dt-bindings/power/imx8mp-power.h      |   6 +
 5 files changed, 222 insertions(+), 11 deletions(-)

-- 
2.37.1

