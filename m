Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F96F5ACB40
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiIEGoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiIEGnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:43:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150058.outbound.protection.outlook.com [40.107.15.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D04033348;
        Sun,  4 Sep 2022 23:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daincA22ytZLO9mmbSYbqnWGBJWoqC53UxrVOLDMwGsxPSTRxSBdTirZdpK6R+huay30PghvMxOHpTd8uyYkikAtnKVcqhgow195KCG8IF58a2AhkiL8kCA7smw/Qddp+fXQ/IoJFhLhVKCFNFFhGSGNrebaWJBzum2o6RWISsqS+IRorEbSwnc4rVFU9N63LoZq1BnZYUmVOYjAOWCTXHndLOEKG82GBdb7fO254ID4w9abDiij8rJ7OUJMkFXhFMaXGSbjA//BNhRKNzNWT+J1qPeFyxGXnDYXql0/IodIONaUwe44Y+u+TawrqT3diAhu8LRMdWW4XCWqXzvuwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iG4/6iogEdo2FmtMhdmfxUynAS2x86NGHP6OfhyaXdA=;
 b=dQCSRYE4+mfVMBp1UHslbOpihcksMQGkaZao2SS4pyViq3yij2Edz95QIhCfqH6i1Dgs0Pr9t33BQhv1xg4RFtDwWcEbgDGe2XKvvVgfH5ET/Zxwp6zB0AlAx09tjwDGcxvb4QWoIMHTFwdc926kgv7RMfDDR6+UOPIDyc76lBlveizRPNvzpbebuOw+lY3HL7kf4QVzazToYBKStnbB3rNjzxJ52YU8dXmJWO+VnxA05YVz2F6YcZYSSu2cZ6zY1hsFJAXs0iHiegqSjP8pmvUJJms8wmcTmABiWytoB16oFur9PnTZGLvn7+1HfzT1+f1MZwy0ybUwyWsTXuuz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG4/6iogEdo2FmtMhdmfxUynAS2x86NGHP6OfhyaXdA=;
 b=fU6QQRrroDR33VWMUWamhA0pPyYNn9FCKEpHt9IRxYCNo02ABW3HnJwh+cLxOUeKGJeGdF2rZJNknAexNSrtz8w5tuq9tFROKYv/Hj9ceXxjY+ajBGVwU7TPrf9am74U4yf7sKXUory6sIffCqPPU74HfIVPVLZ8Fjz80BabBao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB8009.eurprd08.prod.outlook.com (2603:10a6:150:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Mon, 5 Sep
 2022 06:43:48 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::f1b2:3979:a31a:c30d]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::f1b2:3979:a31a:c30d%9]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 06:43:48 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 2/2] arm64: dts: rockchip: fix property for usb2 phy supply on rk3568-evb1-v10
Date:   Mon,  5 Sep 2022 08:43:35 +0200
Message-Id: <20220905064335.104650-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220905064335.104650-1-michael.riesch@wolfvision.net>
References: <20220905064335.104650-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::11) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a5e81f-dedf-4526-a170-08da8f09fc9d
X-MS-TrafficTypeDiagnostic: GV1PR08MB8009:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nX4THaHOY1EXYTZPlrf28aY/fTLV0ndsCOAqj0sOfY1fvwihsGd/Q5KUd5TzmHfanlsPYVqLGhPGXE17Z7VKnaLo3FSRlBvxo7iH0EAmS4lkbpR6jzLxjUsdnBC57+eBMwOMn5GPaDpFF/3Jg8UYJAJzTLzsT88Ez7U2uO8YiGqFsDZCoBtlVvMoKfR78r6SySD0+GxVPiJUJwslGnopccWfZIcR5csWHYe0zZBUCQJG7D6wRqLsr0jJxDWofFUEBEMD1jgt1BQ6QKdPCvEaYA6+wf/VRvcHPydVWRL2ueidlnYxRXjKRS+Zoa+DqCjTmdV9sD3BKdpzo9hXMyy2HSx87a5zkxbJxiDPBx4EZ9znYpPFTgJTAe4tYCqrM+AKrzy6kbVv0wOdxT5PVP2ZH5JyeDDbESflFTc9rnJNH8PdEdXy8x1ohWtRQ/nci9TAql3n2Ak0jPI3NeoVrnqETw3R0lLl1ouDKawsyI+9ft8ThYDDImX7xu+SAgpnBKInH3DFJ9bBVbKO3iWRkmF3nClg6IxQ9xtxFzVsTTicoiBcZs5tLSjB8A4BEnNVq0eWKAzfkJNIL5AmHxeBXioPX4a4YQW0fR5AAzAfUtbGf6lLaBEMXO6zKoT6GSIRR0ZX/FiX/2pQK4TCgc0OiwkxPaaYUcjEa/u+ycRRDGMARvTkujw/tzktkFztRuxKpH0gL8wMgae+/IrymJgnW2zXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39840400004)(136003)(376002)(366004)(86362001)(5660300002)(2906002)(38100700002)(8936002)(4744005)(6486002)(2616005)(478600001)(54906003)(4326008)(66946007)(8676002)(44832011)(66556008)(66476007)(83380400001)(1076003)(186003)(316002)(6506007)(52116002)(107886003)(41300700001)(6666004)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqMoqdWRWQzm+GbST8RM5PRJQTo7a8FGQOXXRr2HVe2AQTOKkthCLvYa/Cux?=
 =?us-ascii?Q?NEuH4TK/HG85Yrmp8Y+Pz4DHpYMsPLjHYjSEcPOcoHTedM2mNc437B7evJmy?=
 =?us-ascii?Q?0oJnX5NzN+AV+mkxbjvVDaTnHsR3V4wn5vz2jkg3JtEsdj9eNnKFj9V5hSPU?=
 =?us-ascii?Q?39pmwK0AJ1JnL0EC0v1SZ59tQEppkht+cbro8ft0Q/x/64Ldu3DbKTBEkm4N?=
 =?us-ascii?Q?XwYGDRn8HpZeCDCbaycLFAwpYgU42jcNbawzpAYE8SGrknF/0qo6XylteRb2?=
 =?us-ascii?Q?eXY1hKnUtlvkuwaq/TeajQ6IN4yNW1BG/mD2H2fO+4sxTgl0UgfG3GcV9UFe?=
 =?us-ascii?Q?8+NjiN5wk7786MPCWZVNS//dm4xfFqIM3czYHmz6gXKsEXK4nSZwbfx/fXU/?=
 =?us-ascii?Q?S8tREaOlE+XBZoJEonzR2YV/zYC+nmUYO7fuV64SQ6hgMy/eaeVaPPtZVK64?=
 =?us-ascii?Q?MyUzGAfETb9bSCp6hzpl+M+XCQ52faIZuFnUK0aqJQNXdFH9LC4QomVpZXJR?=
 =?us-ascii?Q?vcwx/CDmYZvGGfy6ew9it9Tvvsr91Iy815TJtRLGEWYFABtJl6OAdxcF/9A+?=
 =?us-ascii?Q?7A2GYQ2/7ry2a8xlJAJPuLwGD79MNkcCh48iJOYSZcAcN8vikKsm5C6TLfFv?=
 =?us-ascii?Q?vk9CiaULeZsEYNF3KTngAPku51r8rZKQ4osJVUdyx+NiaY0b21PO2U47ZSql?=
 =?us-ascii?Q?2oeK+8lntp3D4rP52nTmI+u7MBRtZrP9ile3+4XiCzo+qXheGfSCrVPul+cw?=
 =?us-ascii?Q?xjtNki94M1IQYpj+g2S9s8ZVTUzJHjbEE0qQJ965QAYICLZHiN1wvqWy2sbK?=
 =?us-ascii?Q?mIDL1cLehXjjZK1G7yH4vqDbya0tNKx32GXVoGKYDgV2kPJ4vVAGy4Aq5ACI?=
 =?us-ascii?Q?DJGxVzwwf9Qv8c38wOScCBloH/NZ36GUOU4rtnBnWzLGIOe9ZctGTLR4Y3Xf?=
 =?us-ascii?Q?GO3ywzJJLTSxoMYNCX5JbDatEmS+XPE/yjq2CIOIDBK52SBOmsLXCiTQ6iKP?=
 =?us-ascii?Q?3HFHGr33Yh4Ne/111bjZtMMg+rhnhmNLBU0JS29EAiGtWvC0wF2zma7DlbrU?=
 =?us-ascii?Q?AygNTw7iOVvOe5Nw+VSGvqIGgwzbudFA9NpxWle4S2qw7Kwz6Juqw1eJMRrz?=
 =?us-ascii?Q?4vdFd+iGlWiAqduKcpo/nJlxe9YI/xjajN4oEn/z22CdIA/33wsD6zkUv8wS?=
 =?us-ascii?Q?DktzH9F/C+AAy22SNOJqDBjuX1TWAZ8WMOhYEvodW25a1sWuqGGFfgRDJMV4?=
 =?us-ascii?Q?6wz2d7/xfhoTFcekph74gHLAtKxWoHREbguIKsAhoAQfhNtE5oL7r/gqKVK1?=
 =?us-ascii?Q?9B3Cd0rW86JV5mGrBGJvvnQzB5C8AAlMSDM4/dxB2yLOnxop++TB4iyFOis1?=
 =?us-ascii?Q?hBNF77LJWhs/2a25BFcJmBowE5Lqqe14VyzOfxiJ0VPKq0Dj0ME6VxwD1F3O?=
 =?us-ascii?Q?A7eMNrVXHUXOzsck9glKjf3zK2+HsvhRe/kMGu6d0bq+h9ytES84RUcDj/Ku?=
 =?us-ascii?Q?S9xXXFcK3w08fBSkV5wx69ROZjr5iyauGPDuL9Zi9fKrGHQWl3O/izL22Nfk?=
 =?us-ascii?Q?IV948xZU5has7gCqLXzBIJ81OJPrYUDJNRX7ZwGZB5oNXsq+B7r/Y8tFKpFH?=
 =?us-ascii?Q?GqXZkvdv6dxvwqjOsCUHtjzEVVQwOUJa+8BIsaSrT9JekXAkmjX6ZDUyQ3ac?=
 =?us-ascii?Q?4HgsC5Zt9yLAvXsVL/6NABHrvVk=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a5e81f-dedf-4526-a170-08da8f09fc9d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 06:43:48.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj7G06tvZiBU7XON9c7N0QVD4HUKULcaGEL3ADtmApfMhoVE2o8iJfn1RfDyEbVhipBRMFKXFq2TuxCfdLe4Up1HNBvZgL5/6HQK/khFPKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property "vbus-supply" was copied from the vendor kernel but is not
available in mainstream. Use correct property "phy-supply".

Fixes: d6cfb110b0fd ("arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10")
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 6ff89ff95ad1..674792567fa6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -656,7 +656,7 @@ &usb2phy0_host {
 };
 
 &usb2phy0_otg {
-	vbus-supply = <&vcc5v0_usb_otg>;
+	phy-supply = <&vcc5v0_usb_otg>;
 	status = "okay";
 };
 
-- 
2.30.2

