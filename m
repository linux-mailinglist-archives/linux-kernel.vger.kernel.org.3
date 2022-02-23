Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08C24C112A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiBWLU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiBWLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:20:52 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30079.outbound.protection.outlook.com [40.107.3.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79918F62C;
        Wed, 23 Feb 2022 03:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsgjwJW70aJ2I6TWHL6Ln9u6MwRA2GK4f7/iVe6akWAfSkhz6FScXPZVT3l8oOi4rMkBwPd+dNTnN3IU8f6KjD8iIdtCsAiHfDYhXFdkQMwm273jRHxnaLKPR1V4ts6pJc1yw1ughzNNFDt91u70XOWrjKwLYfKf47rghGOzLr44zJbTjoiSLcTSDxKUxbFnUyv+wGk+4zthRQE7k3caUcGKqi0r4gOfbheQedDTB8id+dGRKrN72kyvbfJDI6p+g0ZoCVtCkKAnu07M8AsUCgK+3lMbVG/vetGq16c4FY1aXYLUiIPMNPRi+l+MYIg8t7teUl5ScPDCYooGGsoRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KjwKtmoK86wHhk1IlyOesOntQTAdFYrECkwZ+Z6ULo=;
 b=ikR9F5//VGGiN+08gmV2amgnF8wj5PFVc/2STMtsFdqZmperKJAfLPOOM1Fgy4UoD7/5pT6JRKNPi//8fzH5igrXNPHKsASPPHr2yGZIdHwXghAVSr/ikVb3pJqX8e8b+wP0IoBoi/UtLplGA7wdVO63CHHkmlxa4Y7bcuRsbuh+/G4CshxmRNQp6tW3NioyuROBju18s1Fk8fiTNFErQlg8swEEtTJYpR4wTcr20L/Pcn7d6M+qXEjVQcFzl6zHnxu4QL4jSdnKRH9zeHnz1JKdalE9LA/1AsYjtn6rxjXccpwbsOiZuuP7p6cQwiad3qxWQM22mZJl1JymOCqBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KjwKtmoK86wHhk1IlyOesOntQTAdFYrECkwZ+Z6ULo=;
 b=dkxVAFFZJPldTabRNXJMG/M4EeInRPmA50J+apob+5LA6gNEtyVvKmLdqF3+v2FdEw/SXSkcz/kqYfHA/36FjMf+9SAj3B6rJCIsLk0ve2b+4m/774v4qjBACIiohqvzw5YFGuJfDanAkQDQd48agYyyMUL/2PpjKYy7BLF9eA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by HE1PR0801MB1819.eurprd08.prod.outlook.com (2603:10a6:3:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19; Wed, 23 Feb
 2022 11:20:19 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:20:19 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH] arm64: dts: rockchip: set vdd_gpu regulator on rk3568-evb1-v10 to always on
Date:   Wed, 23 Feb 2022 12:20:08 +0100
Message-Id: <20220223112008.1316132-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0092.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::7) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f909c656-9b32-4fa0-f627-08d9f6be7984
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1819:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1819539C2429A264CEFADE3AF23C9@HE1PR0801MB1819.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEF1OBtddT549FpLu/dLQhjXlA4bqIf6B2xdpkorKbRzhjr0eF6L8+IlzltXsbdOSMuHWi0fOuHAHqzveipEl38k6LK6NKSE+dsqoHYjC+I8cj9I24L71+ZvmyM6xthmF41fhSqGaswbtqdBIJllS3b4nK4i74SoX2qD1UMSG1nX9J6Wff0mYynVA6PL2m8J8F7dnoZG0xe/VT+eP498tV2f2I/4xcoB5VCSSZqY1kR1O3WGh06c4xMOvOUNfMnKiapNKbLEjdrjBhIHVO2AbQrTvGgUO7DMxXhJCqNwk4O5Ar8wa9KWOSBBxIQUqnrsr1nuI84xEjktU3c9va1ZdwcyWTPihb22ZNXjd448Y/fTBOzt0CmA76y8VrZJX+H8GnwlPCx5FWYVwWVABmsEMcqQCMFMnmnuWTznK+cCr7ArzTiLxHpHuqIORXLeTogyLui4wcIpieMsCJiwHLWMDIndL9z2RW5B9fEkdpRbPMhhg1Z3h79yvGDBgkKM2mRjh21QHr9nAUO6QEkZr1DZTRe2e1hQf4iiX5yLTbw7PqnsQrP2Dzsmpv33ij+K2K/ZZ5u8IklSBgEuu7lxmHYBUd7q0+6DZD18TjZV10IMSINALa/QJohIkYVomCSTw2fm2lM33eRiZRnhkOQFND4RY6qN5omKLVabz2hHqwbQ/DuWzUNXw1vuFnMEUjhvJ3FzBqzz6l9JdtpoJMFHqZyOFb2a3TcqEThQD9mIdhkHRWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(366004)(396003)(376002)(39850400004)(346002)(36756003)(6666004)(2616005)(6486002)(52116002)(966005)(508600001)(6512007)(2906002)(6506007)(38100700002)(8676002)(66946007)(54906003)(186003)(4326008)(66476007)(66556008)(1076003)(5660300002)(316002)(44832011)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wEmNL8ThBYubYBnXRqAtmWHpilTGq3oMplwnqKPt0IivErteV8N+rqhx++H/?=
 =?us-ascii?Q?o+zK1/WNQolB0bsDY/OF767UvX6KIFkcuDmKLzH1KcBIIrGTOObeex4cT5Bo?=
 =?us-ascii?Q?sisY1fc8qV2K6l5qShc34d7HqsXE/B9lNvkYtVdujkWlpt65qbp+XrTc7vUy?=
 =?us-ascii?Q?KKeFzkWTJe0eGQY5s/HEhlJvVeuTCu8NAgpxvMs8fQOBOwp4YxKNchrBUBpP?=
 =?us-ascii?Q?qD5BebP8eBV4e8kT0SRf+A7I93reExK4isUbP3ZoDRkpDN9H9Pa0xKPIl+F2?=
 =?us-ascii?Q?j17w442FI8PIA6CFSr2u/5zHyvNKVxeHstxeaQ9BUY9fPARF848Zei7ecq0j?=
 =?us-ascii?Q?keB4I/aP0L5UV9blIdq+JTwMZZD4r5O+G/p08ICrznLRgbQJ9Caxp8kYgZGJ?=
 =?us-ascii?Q?OLVl/pAdo7HnAQaRi/2g+4ZOm7qIODjEqbwlH1k2wdKyLLz8tIN4tG/E25qF?=
 =?us-ascii?Q?vC3ZK9V4AsKQbTTvBUy5V69sE1y5Cw1YwtUdCE+xns3gLogsAPPQC5G6+f1+?=
 =?us-ascii?Q?y2Uaanx9E3V/BrziZ88ZyPrIR+a18drjlPi6xTwIaH9ksrML63aIbv880R08?=
 =?us-ascii?Q?gIP73W6kxlUbsyuuAnIaAcsvn9IbWE6VVXh64CmbZcvgNcXdJzlB0uaIsfwg?=
 =?us-ascii?Q?M8I+CTI4W8r2Ny3vQebwKrYiZJGPqpZ2HaGnGWShPyZacf5M/2uB/d7ixKAT?=
 =?us-ascii?Q?ZNWGjE4XjZoH3Brk1XyJUWco/n5NGa2b+dpS9v97vT8B+5YUlDdBmeMnjMiL?=
 =?us-ascii?Q?KparxTQB4dB/wNu32QlSsmXnNx9mcw0da9SfO/wg0111gfhSkSQmIaSR9N2l?=
 =?us-ascii?Q?FI7ai9uRZyQeV5yrl9+wlKLPBg6xDD78AsXdRfcdPlpF2daEygx97JWxzJk6?=
 =?us-ascii?Q?Tq271Dv/ZaTvCoUmzm9fIGdPUgRTcQh5YF5QBEJ0LrSDLJdQi4gY2hIGXmSm?=
 =?us-ascii?Q?sxISbK1pj1OnEZbXu1OWZmBoc67U6giT924G9LcZHBiumAaRrjvJovjUgRAP?=
 =?us-ascii?Q?q2prmewQ5w0X1tlS3dtkY3bic30YCycvSE5Qrr3pzZR9o4z4l9GMUo4VJPdP?=
 =?us-ascii?Q?psHONHULm6b/i2UGi/jaKQo8d8SHIc1SSevqqQyzewTq3NZJ6C/Jlfntd1ko?=
 =?us-ascii?Q?i1ZycuNlWb0p3243lutjlVwb/WnLu2qj/mmXnWPb1gf7By39mcXfhYZt1GGQ?=
 =?us-ascii?Q?WjEIy8DcQNFtUbPL/Uxp5h109E1RWT7N2RoH6edq4kq2FW7GZO/Qu5vhUUmR?=
 =?us-ascii?Q?56gLMLwX00Lxi7XvIEKZX5R+UDZNsBv0hHcZfnEkMBRqHKrtwrrm8TUpJ8Zs?=
 =?us-ascii?Q?0NxqLTbhOy95aYahylXqSDiAzpPepZzJEu/CG6T6EhmFh9bfKIyXKOP0K36Y?=
 =?us-ascii?Q?AFVMLQnpDLwAZ9aLcvon36RPqhNnKx+z2649WHYhcg7Owujbm51iEi1vkGBN?=
 =?us-ascii?Q?qImGK1eJD5qg1YRen6l/Mmo3hD/UTQt3OF5S7Kh9tUwFKWuPcny8I7eok3J4?=
 =?us-ascii?Q?2aK2OUH0aibh+D1ybJeYihy5YitelUBds+8mG+rc2e1zVDpuocIF1wP73RcP?=
 =?us-ascii?Q?6C7SxorJ46l9EsKtYSpgGOKiIjMToXOdNalRhTeLp3cN6t9jCmBrspLS09eX?=
 =?us-ascii?Q?coINS1+vq1xHAX1gbau/uA92xrmEJf7E/7TZOTQBJNmjRDgqORBPApEKfLmf?=
 =?us-ascii?Q?lZu+PWV2dv0Mus/Z3wIPJHLwuGAyXbbMH7DdjLyzldrY1+MbHVTEHG/dQUef?=
 =?us-ascii?Q?aFxJHk9kve8Dpgdvy30RevIkz9q3kP0=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f909c656-9b32-4fa0-f627-08d9f6be7984
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:20:19.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7AFwzl3aT7KKuP2yzOYkpgBjUb/xkYWgnDZF0M+dE8o4k/ob3qr0uwIpgXN44nDi+H0ypIoYbS76pqGfgmcoo6CRcIuN2lLxhQIxqklbJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in [0], the Rockchip power domain driver does not consider
the external supplies (such as VDD_GPU on the RK3568 EVB1). In the scope of
this discussion it has been pointed out that turning this voltage on/off
on the fly is not explicitly supported. This patch follows the other RK356x
boards by example and sets the vdd_gpu regulator to always on.

[0] https://lore.kernel.org/linux-rockchip/20211217130919.3035788-1-s.hauer@pengutronix.de/

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index f3d0bc259166..bb7177ff92ac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -219,6 +219,7 @@ regulator-state-mem {
 
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
+				regulator-always-on;
 				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
-- 
2.30.2

