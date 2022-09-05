Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327F5ACB43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiIEGoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiIEGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:43:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55D33348;
        Sun,  4 Sep 2022 23:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/IvuwXy87ZIRTu1tSby/NY4mJQykLYBT5HJKe3GkKSd1YZ4IO8spuwa9ugjOtEnZTPW51GV3SBXeWBnGPWUu1w31LEJAKNW6l4F29k1zyV8mnoe+m5ahSJr5Lc5JYtvHkMEcAfIbE21aFpayw3TvDase8/JBmtJgmMs79zeln2dSod9+QfAALBPEmR1/Og8XLiPjeuIc2hufG3sgdknzT0whyRPnVTdKXuuIiUkQz7gmEczDx4wIf6198Ww1748UF2UGX2Yzndh5bZLme1dYJYL+JLzvZMmrQMPuiL/VQfQS7McetesBxDWOOUYA+Iov84WFPfddyqTYZlcJcWjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0qNj8f1NkoJxqGG99BYRdosemHULDC+mopW2h6icEM=;
 b=iPaZZYeWo2a0ZlLVYAHWITERqJ0jBMtIgnjCxp97GABoOgZqKJycpK/PHiRoSungXKcwX66vHWM3SgrS62LrxjzW+FJvCrUbOkrz749cGARz4JgfX4acYtvXgfOzAUAIvWY4aF46/JQJ5ye5vJoRtLcUB8GRS1J9xiFSGoRq7jiYwtOVrF8YIk1CNlxoS8nyEBClihbtHb3Yo3RPz66xxDsQcL6SY3vANIwXb7OkUjG2d232FjfQJOMRLuaU2Of69N/uIQaoJotRZQVf1iK/2LQ+g2IBdhhNm63zr6uWmVcMwZG5aPZUo/NBcfaRXKorHlycA3+kePqsDQOTqtn6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0qNj8f1NkoJxqGG99BYRdosemHULDC+mopW2h6icEM=;
 b=PpT1ArpIuINRa7K6Su3Zd04+XioHxgP8ZpEMxc28onad9rpk9sWpIx2Aifmx/L4gGVed1VU2yG9t0BniAvK/K2NBq6iKTxs14ueJh8b8YW+sAWH01cvXHjAM8+3SaZO2LY4jnaKfiB+03C8P3vWLsN57FLvEdimZOUrY6yczjkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB8PR08MB5321.eurprd08.prod.outlook.com (2603:10a6:10:11c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 06:43:46 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::f1b2:3979:a31a:c30d]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::f1b2:3979:a31a:c30d%9]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 06:43:46 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 1/2] arm64: dts: rockchip: fix property for usb2 phy supply on rock-3a
Date:   Mon,  5 Sep 2022 08:43:34 +0200
Message-Id: <20220905064335.104650-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::11) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5df43fd5-02e9-4874-b150-08da8f09fb4f
X-MS-TrafficTypeDiagnostic: DB8PR08MB5321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWR8XaFzY8brkkrt6SDhZHHopc3eaXT++Tk/rAktAX5QHWeFkrIrMeRlDvp+yPmcsWBGIa1t74ukJ8uhnski/oWPg0uv53Ot4y3n2KBa3aCn0zJ9GOgYO7G9s7whViAUS0Hdu10Mh0LD6C31Yw6tlmwvvuF+S5PiSIeTQyxU6LCMyc+tY8AUtxBou0MsQylKqnWxJ+1qfd2MxAEaaiLikn1kHYiwWT5E4O5WtVML7+ORVTsjQu4oIvtAUcz4k/4xndwlf5Hh4Q0BRSf6/e3105i0kyIvb1fvGuVdjvujH3jX7Wu0RijGXUWYfFID/HMJV8L25Tr1kBROdp2XTWkN+qA88UIGk7/gVASpWcwFgVD1kgIUUKpwHKWjZAYicXQto3ZFVRLQAd0sda9rDP6OeqsyGwFqdZigtrRqJNXfZydexrWkMZWwhlunq4n20ceaJu55EXD6auxu3sQe4PI3Fmy7ECkRpDTFM63TkhrpXydbYpEbICe64xU1JQwjTtpmoNFUJv1+E5cxQyaf++RnK3OV0Vq9bGOyWQ0lCwDRhtAb1Z6++y6VPine0GOAkb9SJ4SwbymArYOHOP1VbPlL+/juoauclQHqM645G0b1E0xRQwRfAUXCfF6mxZr4ImRhEGsLEkHCKviA3u80nuZLmmsCMSjn/i81KnutXy/Fo3BNhjiCvQTaN9odGgkVwRmbjx16Ex/le4vAprTNaot2Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39830400003)(396003)(376002)(316002)(54906003)(66556008)(5660300002)(4744005)(44832011)(2906002)(8936002)(66946007)(66476007)(8676002)(36756003)(4326008)(478600001)(41300700001)(6486002)(6512007)(2616005)(186003)(1076003)(86362001)(6506007)(107886003)(83380400001)(38100700002)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYUC/8CXD7uAqmJvS3RpwG03I63XKVkw5AlG8y9KpwDhSs43YKvkSwtU8kwi?=
 =?us-ascii?Q?nzTYc9pECD0OZIZTujlK5OFwoBOBV/bzialUvp/hqXMxt+hFhjlV1+TD/7f1?=
 =?us-ascii?Q?b455IRsddv8V2HLQi9YXeIhizYv1AHUvrLObWG/lgJ2wTwa/cXy1SnSfqppP?=
 =?us-ascii?Q?4W8l9HbIWiw4GTS8+qIp8er7zJQDslk65eIjp76PL+axFwEsQeSGiphuWR0H?=
 =?us-ascii?Q?dsZ1bQ6d1hdQ2Afocd5KcZMTGIDzJOo5MPw26/c1xEQHRuzPNQ+OUCOh8wKS?=
 =?us-ascii?Q?4XlgVKEpkF4FAR/pG/Khn7oJLKIiZfmMHer8YXs8qR2P4ZuLvG0y2qphiqhG?=
 =?us-ascii?Q?2s6MompyXISKF66/6tZBqtEh5dT52mZMM+vvLD+qd05SGMVxc0XcSqQvrdpN?=
 =?us-ascii?Q?tj5B9efhnWEVpzc9ACL70SmX+Y3tsQYP/07EXH8hvy77+ZQY7YRuTyh59lmQ?=
 =?us-ascii?Q?PfKm7lVZjBLwXereC1njsLdLUHqDINyBrDSGRYMO2rj2vniyhaD3rF9ueCgz?=
 =?us-ascii?Q?ctQZcNJ9N/qyiOCPbr2DFvxqxvTZPkmJnNhfCQDSm7z/glohDzoVWEBAGYyK?=
 =?us-ascii?Q?8LcNIPYKP6YL1auvG/veZLNMGwQ7WCuNcXxzobj/RrUYNrUzX/Yvv/tsTksR?=
 =?us-ascii?Q?5R0aTu6jr72boRme0FGjWoC62nGYGh+9aJb6ODThrGbi2hhQ9KiFZSFd6Ml+?=
 =?us-ascii?Q?SGmCGrw7AVbQ7bb4W09DutkpRUeryyA016CeGgZKTyBOV8TdTSpX4uZa8VET?=
 =?us-ascii?Q?ONggQSIl/mEyoaOCKfnQ/xhAYW7s7GsCAPOdRYcCKrga7wZ+hvpWtd3YeLYp?=
 =?us-ascii?Q?nsSNZeiI7rmBHKPk4CZhAHXzZKWyWIg9qpG8qAW0kojSRmiXX4zaIJEwRSLb?=
 =?us-ascii?Q?MYym9heOcAF19BnlevsHhiEloiX/CL7PN23oqUuG0KAnSC1Eof7PGM2B6SXj?=
 =?us-ascii?Q?oEGOOEGC9cDYf6hiD4o3ysx9hVW/GObjC7FON6M6VdCFqdnGYyrf5wV15/ro?=
 =?us-ascii?Q?SpsjJLmR5X5jNaYC0UTDXwbi2FmSzmE0c8gtNDA3rsXfiaCLOb5V6ZZk9qzx?=
 =?us-ascii?Q?8Tl0F2QP9PZa9XE2ecAigrjdfEcxLWyDLJi90GxVLF3+wzhBUpWO261ndoLN?=
 =?us-ascii?Q?/hQFyzXH/pfPK4GIm4cgDwbaclC8R9U2jc37Wd3DjuaTzlJhY/rXLQa5MBjI?=
 =?us-ascii?Q?P2P/FRruvlqi1S5l0jB0yplDaHCtKaA61JnAGVh2Bgm6un+XIkZTcvFPTon2?=
 =?us-ascii?Q?hAFQ3yYlTehhguF2Gs/MdaFH4fhXXxFX64GTvpNAiXSlHFt/dsMX0wirSPzy?=
 =?us-ascii?Q?Ho7Jr+zEK0Z02GScGKXFPU2eRVx4jPlK/x7A8d9KKUnKtGgghR5z9GVUYB+b?=
 =?us-ascii?Q?p49GzM9tdOccV/5TOQGwcRD0urJ6qwZ7sDYXX4yGQrCT3F2Wjb3OMt4BWWld?=
 =?us-ascii?Q?16125Moj9k1fwSzFdwaR4lbxt5Py48YGOe9u6XMNfV6y4MlWMTHISFvqOPtO?=
 =?us-ascii?Q?ihOmIYi+1nAPlHTfS4n8iOJCG37FfHXx4eqRVaiJ1ecsMVUgmX/TiAbStjyI?=
 =?us-ascii?Q?HZy9TFyErCC5kkUWH3Pt3fkv5okRRbHEMY8aOgs9oMTPSjGBqZQ5Bqlm8jc7?=
 =?us-ascii?Q?csm+9TsLAHpRR9gRbRtGj7hjHQM1M2szPfR70iYtnMNp9zI/lmn03CyRaGKL?=
 =?us-ascii?Q?gvYr0g=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df43fd5-02e9-4874-b150-08da8f09fb4f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 06:43:46.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAAMNtVAehBY4LJYUVckHea4wZ6t8KAGqP4Qr9AZsIFcLgVQK+0wpa6RABu1yPmgzzqIxJG8tye/Fy8RPQP4pS8wIU19/WzG+/leXmrzJYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5321
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

Fixes: 254a1f6a29e7 ("arm64: dts: rockchip: add usb3 support to the radxa rock3 model a")
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index cd8cc0c3c68a..52a437f48301 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -637,7 +637,7 @@ &usb2phy0_host {
 };
 
 &usb2phy0_otg {
-	vbus-supply = <&vcc5v0_usb_otg>;
+	phy-supply = <&vcc5v0_usb_otg>;
 	status = "okay";
 };
 
-- 
2.30.2

