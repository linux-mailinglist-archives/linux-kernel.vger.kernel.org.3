Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D757B39B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiGTJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiGTJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:15:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC03248C5;
        Wed, 20 Jul 2022 02:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2iyRqdkOt1MXMUFaQ7EbiIRYAlaIAtO9RUWrFPNQH4cKIDT/Tw8L65Wy3K6kjzKmn9alzSyrtFA1SBXjqt+483JKxzrmb8kIxFKjFfFZmQLSRmVVUtZS0abZ8fvOKiYFLdKezS+jSEnQbv+UPV031Iu1A7AJpKoldhDeNPpyFlHdwlnXLZ7ITfGj/Or+9PV5HHnctDyKnLUoxhHuovBLT5vQXEO02nAe9RNmnosHO9xSl0s329XsmAF1v9z6cRLKADZhRQMlrJ6jFSjNy1HW/NGt4RwYvv0ays+ESAK1yG0zwR4n6MNAZ1IFBiu+zwBYjEAUcHtW9Br6bHwl5ga/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+tqHFRRP3IVbRGQKL6edwQ85Cwzl7hAcTvgWALhoM8=;
 b=fNB9tAaEofBmxgpW/Mi/7p8Y+ASJI3RRABXK+MxXG8CPHwZ1qydNecNhzA0hmpuaBz0fvbtZSbPScNV5+7Fb0j/cY1MIKtJ64q+5jyqQeGxaMMuB/UPcVY60QuBYFip7UALDywmPImqBsfj53EmYNOHcj9eY+vTOWHxWi3jrSn7MuZTVFqXy54Fdt7nsDGEjBlUqEYwMiqfYLeMu7gBSgFvBnyJjfrNN79l/BDFWwBOthLlNTa++5Pz26yNFei1c2CdgKzhU3Nm0yMODj8wnT+I/n0W6Can4kTXbDmR2pcHf2qdNlWFcIeSLVM5KE5qYyLi9vZfu9sLIs5MXB5fv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+tqHFRRP3IVbRGQKL6edwQ85Cwzl7hAcTvgWALhoM8=;
 b=PXvY2cYzGZxEaS3GcevkJuTCo9sF+N3Ih0PdyRpb19gWcZ2Pv1sN5LGClxqn6p8tckBk00n2CtdqzdG2NZeEe4q0Hn3lXnWkMNh8P5vefhGxeq6++V4WCcaAVYCK6nyKInT8n75ZOivA9+hLmr8sDZGl5HrkusmC+WgvzrgNNyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VI1PR08MB3934.eurprd08.prod.outlook.com
 (2603:10a6:803:df::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 09:15:45 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 09:15:45 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH 1/3] dt-bindings: phy: add compatible for rk356x to rockchip-inno-csi-dphy
Date:   Wed, 20 Jul 2022 11:15:25 +0200
Message-Id: <20220720091527.1270365-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
References: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0129.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::8) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc7cc7a-f974-4dca-6e3c-08da6a306d40
X-MS-TrafficTypeDiagnostic: VI1PR08MB3934:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35fEbRuoCusxlo59hOOiY0j9WYCSvK+YX3kt4TFlMOKm/zU6IGI5cbx6KrhYXoqsna71v/gHYHMU2Ejp2HvfCxhBA3upWGqfDUEYe7SWz8X5j+pdN0CpmFHwKdtYTVM+kgO1Yq4AOGo6V/6LHGsbkeCZ3ufHAYR1A5C8TByDJDrf+pU+2MdQgUq1Wrk1nXY3nfQKIx+bDvQTuBw/jjDiRqjTNb+h+4XBm+MM+6qvjsXG3jNNkZnMVWJsKmJ5hQ8CBmO5fuX90UfKpEW+pfhsmW8jGBfljUeyNjRvMm5ukMoV2BbUmPkr9zycL+SzRdYKI/t5vbu7RJDjKVzPsrnQo14DiwQqgONweOTAi9C6FXP8FBX0huvapzuTXGP9AYbcpHO9HVNWbe9lBsaMa6E8nEVGyOqrcD4esgblDSCRPlUxE4IhJs+cXiTU1B6CmPRXuv9SGzC257CBDP8jVwiAT9rdT8ILLRYyRmOYZvz8NetCrvTn0ebI67Gu8RtvFiBQ17V7YP+Ip6zWik2zHxhry9UgkFpnuOCFo/UAh7uEs8kMBAEjlqJrfzRycU0JUnSTOQLYoVIkXzWk1FpStm0XmoZ12syEmdGYGOgfcB8cGmdh8m58nlIh4hjoE46H+xLa4UOYhjlxn+PZJ0IXI7DeefQ2FfSrqK17NclIMgn70A8Vk6PfljV2n7SkGn31O+equVyxoSZKV+kPYDQJ5YSMaHxPlIkIeeLYfnAmXqUJghO21rQKkoZEJw1sAJgtNUeO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39840400004)(396003)(376002)(366004)(136003)(38100700002)(52116002)(41300700001)(6506007)(6666004)(8936002)(7416002)(5660300002)(6486002)(2616005)(478600001)(4744005)(1076003)(66476007)(8676002)(66946007)(66556008)(6512007)(54906003)(316002)(4326008)(2906002)(186003)(44832011)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S5RRUhlF28pDxaJfVwDH+okLl4Ni1j6H78xVtlZ8n8qzqSsAs0ORZyRzKeaq?=
 =?us-ascii?Q?ck/0gl9ZzpHjk7gMR+CcEmYddAUlgaAhX6OPcAt/tEXSwwZ1F51xDsZ8iz2Q?=
 =?us-ascii?Q?GLNbfJNsXv7z4ma33dsD08GGGiIF3fGYo4mvHdedAexmIsLbAUzp83hXT26n?=
 =?us-ascii?Q?sRPXQ0XaXlMace6A2M29aaUZeg7qIQtP4ro5hY5/J/CW7+4h368ewsWIFC/s?=
 =?us-ascii?Q?x6nwdRBsJb+ectCbWV/Z5OH9415n71WtUKJYNmQ7G3b8XvByjRyED+LSVMnz?=
 =?us-ascii?Q?hv2qwjljIeLiHL7k8qx+blGDS+HKtmp95puNJNlfqhxQXEhawhPxAnAPShC3?=
 =?us-ascii?Q?i6i8Y27lcrnN3jpY/fidXZp+bEYHG7rkOJZwxj+lLiX/TSq8iN66JMGKQH3p?=
 =?us-ascii?Q?+drY1aJu/wdh0lkEIK91BEMlC7pmEbRG98B1KCY5+Zbf4zRAYhmqiW2k6LxA?=
 =?us-ascii?Q?QcT3UrpihuJPktvkpfAhLsBHnI/UxFZqB0KV/dcxDs17sv/4txr3bR0AYhOy?=
 =?us-ascii?Q?GoGKQHs67jyInfkph2YTDc3Gq3GgK8HEylZ9pkaTP4RVWZ94eBUfMHRSRRLI?=
 =?us-ascii?Q?bDb7iI1aJRpqku5uBLv+4rhRX97WgtwAs86U2XfZwoDMORBjPHgIKCcDIApr?=
 =?us-ascii?Q?xm6qIOvc+0KPLhV0Qv2DJVgfJToFxSbdkmxZ23P5p+mmxAXr3LvhzQ4RhABe?=
 =?us-ascii?Q?eVAqT85SJDsqZw+ZIWyGgAliO25mwFNDmOUnpsD+DPBcOjBXpir0E/U3sYb8?=
 =?us-ascii?Q?SFQ4N0Z4cKr5p+OfooEzXCWEaBhAwyy1wNsaqdN2oCHS5e+hy+CWa1iM6fZ7?=
 =?us-ascii?Q?flDl5CrbwA8QyEs2utHi3zXZWlOslf4cEmApY8LoBNaFY1tWM8E0J5cj0W2E?=
 =?us-ascii?Q?AeisHIguJl5VTsTZU8OjFWhjTQ9MArHKcSYn7k+wGFste1r7H4A+AazPUJ9p?=
 =?us-ascii?Q?LdBWAdd1DCCJufScmLuMiYMtITRgWQSXScBhyGB8YvUlsXz+TOr/HjOeaP3m?=
 =?us-ascii?Q?yvnPL0xv+daInzpFFfktwFdLZvwa/vi4tMo3GfxH6Yp4a85twjpfxdP73GAm?=
 =?us-ascii?Q?xzBwx84iJI9XjJOqJ/8XvaNnnfYDLUkMEqGXfIdKb2aRwA8UYs5o2gisW27v?=
 =?us-ascii?Q?BxbBOQa6+Pcn2ww2PQtXmCl1tHfzftTSrmN/Q8+wutwQ1A6Jo53S/283LLET?=
 =?us-ascii?Q?il6/5HT1EGMGIHt/zCK2eBQZOxLZYsNzTCOptZveUfbybVrO87X2l38mjSo+?=
 =?us-ascii?Q?h0azD4xDX61k0V2A92X9MP3GSAbJTVMY91hSm+Lba0XpFrUuzno0kA43Ov4t?=
 =?us-ascii?Q?O0pJMWQ2uhfO7qGZ6Yo0HFY1TBajCRrBWbWHY0xFUO4qT6eOq2X2lkX0Blvx?=
 =?us-ascii?Q?BBuUtoG0WcH8sDgCqZ6RWOFdmVl+ZOyPi4D0P4tBCdoYFDLL8F/3TNRKUbHj?=
 =?us-ascii?Q?p6EcL/LtR7LtoxSB8qmoab7d5gv7oHLndg0c6xme8iDKZSpo2UpuR5vsdyz2?=
 =?us-ascii?Q?BHafFwSEicotGKNk5Q7RA9fZTyDIj0KPXX5Ucfxqmexi5oCE4Yb/VPPRlHXG?=
 =?us-ascii?Q?aGE3+So8X2A5zKoc1exUaxdcpX7S6fkPbTFwn0MVVf43XbplicEWG5XqQcko?=
 =?us-ascii?Q?L0h0csL6QyhDqitB8P/1x7ihld8sQWSC2n3wMl1CzrhmRmc3hOhYm+8Od8VY?=
 =?us-ascii?Q?kjX1sg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc7cc7a-f974-4dca-6e3c-08da6a306d40
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:15:45.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/bDlsoFoO8iJDP3MvWTw+DvkKuh102y4x16AuYF9P3ocR+33Q0I7IHvHgzoDD1E6oz3W741pNH29+7SkFDlNIuF5fHzCdOWnKMGaQSIvfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the Innosilicon MIPI CSI DPHY is compatible with the variant
in the Rockchip RK356x SoCs. Add the compatible string to the binding.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
index bb4a2e4b8ab0..810537a0f7dd 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk1808-csi-dphy
       - rockchip,rk3326-csi-dphy
       - rockchip,rk3368-csi-dphy
+      - rockchip,rk3568-csi-dphy
 
   reg:
     maxItems: 1
-- 
2.30.2

