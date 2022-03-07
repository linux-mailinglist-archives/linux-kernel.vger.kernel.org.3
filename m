Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674E4CF4BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiCGJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbiCGJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:20:48 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1551338;
        Mon,  7 Mar 2022 01:19:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHrOMiuuYTzoJJBADyFfZgepTu5LeDO3zP41JhU9Dy5d7IXoOnwL7gBXisShFfMachhXYrOZ8cMu2b/nfe64r1yAbmntSrg6EL7yKqBG09iSIiYksDGP+dmPSxL6rkkiZB1ry5p9IljzZC3r34tL12GhdZKJsEr+T2bMazSsnCIufpxQwysdFQbeXs+zB+4wbH4DC4/sTWI7ckqvbw7z1MT+o0urT7AXnSaGsYwBYO4M7y17qb/gjsEVdGlx3bW6BNLrsuZSoCWsC9FMSVQKnct2kX9qPswqup2AAXcrT0/XK1j6IeEZWmXt5LPeSChSlqHQyLqKqX4KCpKqZeblKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iez/ik0IZbj/jgzwGYVRSmtK4LfAEcgvGxtKV71MXQ=;
 b=YeKBT7qFzssi0Tqm83m3GajIVI3eVWPMNER42ghG+Dw05bGmkUBGHIreu5DNG27i6+67QUsdfA83aOuSrtT9VUJRAO2lhBx/TeRymFzKlRVWLcuxELjZ7H4cJhyALgmlEOGRuCGRgLFIpeyyd9FPSivKb1bUmh4U6I+W4YqbOCAwd/zaMC6tRENzCTvQqm+Kewe91NCpp26+gygacfNNJK12GkIGetM3xpBOF3B0gaDgOE8Cn/tAD7PSjVpKXk104i/dWF3Wl7pzC/JVr1ChQuZxPlxFTglUt3/fLwHKNB1u6W4lBZk7LTZnmBnwGo6mxeiaRraTp7jFbwyY6rZkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iez/ik0IZbj/jgzwGYVRSmtK4LfAEcgvGxtKV71MXQ=;
 b=ohsZ9OQZcoKOzmbRif9qt2hAgYI5uW0PA34JHKYGWAPotNXtSmnCWhniPU76caz+N5d7Q6muc6feNyEIx6WgF9RY4fgNLiTv1WVD0mgoRPwgyFl03quwUpZAfMN4ZlvOjQWFi+8Y9sf6UjQCMuGx4DkCtXA141tu+kb03JlikMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com (2603:1096:203:b1::19)
 by KL1PR03MB4646.apcprd03.prod.outlook.com (2603:1096:820:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Mon, 7 Mar
 2022 09:19:35 +0000
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e]) by HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e%3]) with mapi id 15.20.5061.017; Mon, 7 Mar 2022
 09:19:35 +0000
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        arnd@arndb.de, olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 0/3] Add initial support for MA35D1 SoC
Date:   Mon,  7 Mar 2022 17:19:20 +0800
Message-Id: <20220307091923.9909-1-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To HK0PR03MB4833.apcprd03.prod.outlook.com
 (2603:1096:203:b1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77a349c7-6a2f-45ed-7821-08da001b986d
X-MS-TrafficTypeDiagnostic: KL1PR03MB4646:EE_
X-Microsoft-Antispam-PRVS: <KL1PR03MB46461FD11C0BD692F61E94A19E089@KL1PR03MB4646.apcprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoCEnT58gPVVBxDEKgUcmmsuj8yMbCLt1kib2tz9YDJ77lUd7wkkqmZOn+e1g570N16zrZ1uRlgnMCseTQMbnKvEXPUTUeHQUhD/bgaoPmQimlaje1+0i7n+XTyhNBK68CLAVbYChfjhXUl27bCfT8oDGeKo985xkUI8gphgCRnNPuQnWtNxb5d7LKxPD9EK4OnW1o60PQSw9HN3GN/JLIMbxSWJ9pYpslR8aMtMmVyK2eCbLiRYnVP2Lqn6WtEvWp1/gD50eYiDua2CGMYO1oiKx9j3Rrq5gG5XK0HawA0bpYfnmM9S67U/odjA9FWlZwX9dcogZnsBZ/RXuFR9U0BDfGWLgyFLELY+puVJqoeP2jHai4Cgr/9hqDS0nUaAlExn1Rxv1PTYrD9rCZTg7H/SoJq8Id6dhw3HeuRHhXDvIT7D3hAupJj/Zc0p9YMS3Johxh0BSGhFAjxy9kzgA2bvS7V0WHeIOLSnLgWg06Ff8cRWi3iqrAjX08ShO7p7gZUbRPpWVV299shD+t3/MI3rU/Zu5CknbJDo1xlQwjToRlcVjbQw3KT2ZlmFuRv4mXFdbr+1/e9axfYq0CE5LKUuNDkvMjAgACAdDAmQuVw9t/9gZo1bM5rBQLuSWZjMv9Ipz3FViBJo7QUJ1kWXcWAD/nYPX7Pd/Uat2jxEv/ipuNjzKmQO7z/v6zodwUaBEP8/res/JS2Iom/f0MqNDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB4833.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(2616005)(1076003)(186003)(508600001)(5660300002)(8936002)(7416002)(2906002)(26005)(36756003)(6666004)(6512007)(6506007)(66556008)(66476007)(86362001)(8676002)(66946007)(4326008)(52116002)(107886003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xwQn7SozYuUOX1mglQ/vKU9ap7bT1Fg5OQPYKA/sNGSymKQ6LHmi2o/m+ieG?=
 =?us-ascii?Q?v+DXmQeQbXViYtBi38fsKrlOTutC+XeutaQ+hD+nyaXkr9HTisGvxKkx3+2x?=
 =?us-ascii?Q?wbu6gR5wsSWcPlQ1xEVGHBO68MoMqLv2lmIxsHW3gjAWGNiwRknbEeVkCOrB?=
 =?us-ascii?Q?Dc14CtAWTxfj5dJXXQ2EB3i5VFrENvskOW+On8LJWH6lvA0o5C/l5+Naf4Iw?=
 =?us-ascii?Q?m7633kCJ/vx/zW3RMClG0FAapU1oXrFVcIlttcDd3KMPO13oPDBtSJpnLJ+6?=
 =?us-ascii?Q?1OBrA3JwAVfpNE4ERmlFmq2WXEJrft0nXJonJUCDCAXISLnuy8VasHb21j4T?=
 =?us-ascii?Q?2RJgikxSanYfdWWi8JdLXTUNqgQK6c1bYzjVdHYmuIbe4pB/HwAqwCvewH/3?=
 =?us-ascii?Q?FR4MBGhotvVx1g733MRa5XbIR0kJwCJ5QwR8TFNqz/XcYv6KFLgGYprX5c0y?=
 =?us-ascii?Q?eUF5z6uM0YSu1XDOaTt+5R+WmnADERFvdrAPE7w+0J4IL37xpkKO8GuHU7Sq?=
 =?us-ascii?Q?fJsjlT7NwDMAHQS3kvJqP0VEOpacufeEhdtESB+PKio1kUPgISuVw4R8BWjK?=
 =?us-ascii?Q?i/WJi2XggQaKxJ/cEZVXFcR776MwafsvWIJiOfa8hqJU5J4iIDZVpWu1S5DU?=
 =?us-ascii?Q?2gbjzCCEU0RYbM6wi0LKSCwDmDz/ssRVH4jk5QxBt2jYAPRbR3htrccNA4J5?=
 =?us-ascii?Q?Nmxp/Eaju5u8kbEBG28qqWExQVnxM9K4YlaV8SZtfpmvMn8JupqV5OqdUDJS?=
 =?us-ascii?Q?1nE4Jg1HeCKOLmtYp3N9t7M/oIxiDZDYgu/GrvV9zWlvCyXxZcOZsvx0xAqq?=
 =?us-ascii?Q?oLgq0qEzuIu+NV5U6pkLOaH0EhSj0bB3sg3z0JBlurKbeJWUis1wb4l74ZdQ?=
 =?us-ascii?Q?jOjIx7eTihPfi7SSLe7cYPTTZpehW0ixr+531pmo96ngnvhvgM54JOMhZw7W?=
 =?us-ascii?Q?nhG0JK0p/YAuWLinuH4zltsYA63fQrynIqMMiympEWyDnNNwr93OiVZMh+Lo?=
 =?us-ascii?Q?Z0qWzLdbKbQgedd5qKF2T8DSEzZj2ImbD+ViKAhMUU6/vjw/OKyaGwsgMtW/?=
 =?us-ascii?Q?Mkk4k3kZbB9UpnBIcRycBA7X29X191vy5E8hKS2PO+XcluZ7qMFYfkyTVm1Q?=
 =?us-ascii?Q?krLTQFGcWL0GkgKxbK7adnm1FwXBThmVR3rJuH/0JKD0yrdbrV3Ay14gwA4p?=
 =?us-ascii?Q?tki+kwvArbo1hwYZXZvHY8PDA2tlnLFbuAffTAPiTwr9wWieS/7fSeYHecO1?=
 =?us-ascii?Q?ilfX06EDU/DrvnWeoIAl2IKIlJCCl6tK/U9HR7bQe+x5357dFuHa2B7LjCY3?=
 =?us-ascii?Q?SZHHbylWvxyWKmduEh6luGdoYD3OudqLIgHXaZ+u6LxhixS5n5uCGBG9IXnu?=
 =?us-ascii?Q?28hWqDfHO/QhB1ebUdrJ2UX0WvpNZonv/Qc2XgkSyq6ZQBvUo/eFMWldZi31?=
 =?us-ascii?Q?+Kl0sTt5XlIMH/loAOx7iRgPLBggvOQhLpN1DV8AD/xNmNAOM5c+fw=3D=3D?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a349c7-6a2f-45ed-7821-08da001b986d
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4833.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:19:34.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGkuhyX2Ng1B0r7ni1AvELgGq+YQwzY05R06+tDdEeS0bqpbrmtSAf+thZEnyXa66aOh0IwDjDiv/p0M1usmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB4646
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds initial support for Nuvoton MA35D1 SoC,
include initial dts and clock controller binding.

Jacky Huang (3):
  dt-bindings: clock: add binding for MA35D1 clock controller
  dt-bindings: clock: Document MA35D1 clock controller bindings
  arm64: dts: nuvoton: Add initial support for MA35D1

 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  66 +++++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts    |  23 ++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 106 +++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
 6 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-=
clk.yaml
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h

--
2.17.1

________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
