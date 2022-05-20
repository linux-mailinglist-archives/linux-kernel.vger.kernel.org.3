Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1549F52E464
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 07:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbiETFgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiETFgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 01:36:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE8F427E2;
        Thu, 19 May 2022 22:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqoetcDrqaA8DcOCobYBjMFRzUwfzJorYaRzNR0BjpareTEHTq+qERx1w0By1/ickzhoBLEazY0+vxrllHGpCyMrfqCtHj/Td7keHPpEjx1WpDm3nQmBpKJQ52QruGhPajQCWttyds/VW9j22ng1yUIprs9NELuENvVMhAzjSZM2OHF9iU1HEL9m6p2EuFXtHQFXRw3IEfGxCvgA7yisNjPaJMCMdHBFlfg0IVKeAOmZhKWAwmhZfyLRYPQvcF+qWg4OPhDduy69cHp+CeCfvotZg/FEQqGhFWoMmwj1ambFIceElU3MMHG/JqhN0roN0X0a9iUFPdCUCdIJW6r2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7xve3vwPG+RJ2LaVQo0BDoiUS9js2ylHo9V6y7E66g=;
 b=HO4a4MhVG76kBImM4rTzfNbCs5f9AUVAHQLGI6MgKBskmzEltFUEraM1b/yyzSzHBzudflDRpLwOtqvS4P2H28sqQU5F+ooLZnOwPbqzBQ9/z0qmZprdXB6uKIwQTpueg4ZU/TqmszB/qCBbU5qbg27W8lRSjn8F3/7Ayl/vtl/VDqiLdMntnKHJ77w9G21MOvwO4/N+wNxoW/HAoih3Dpzuczz27YRC5erXcVyd04aJ7u1do63XcHkK/3cOpy9ZhGhqDSTRIzBRYVVCfdH2lyg6NQulcFW7WHigsgmiPyeJw6vwkGo6zaZcBYWmz05Ja0mwxx/OFz6rKJZUYkn6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7xve3vwPG+RJ2LaVQo0BDoiUS9js2ylHo9V6y7E66g=;
 b=EQlcBdtVL5/iDTFpxsF/DdjZsYAn6cLSG+UYNZuPsz1vFIKMbdBtRgJhRgRxQBsyOwOo1rzUIsuHaMOp2vr7qO7G03td20/CYQd8dBi84BV/aIy0M9C7GH14I8EOG3RcEa4waFTJsxOBlIZf3SZWqf1LMYH88evxycS73H6xo3OJSMZIRvwL7zWc1OSkzgcwsd7Z0YqZALcjIkyBZ4xeB0CgUOAnCgD5tQgKD7ksDV2JM7LJiIJhfqEPhsBJRYssvKaZ10AeU0qsVkZUmmboeZeQNocRcpct970sWuoR1fCQZYos3xdMhDJpQKfSl7Db09zIWfWoehzqPHyJXfZdRw==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 PU1PR06MB2102.apcprd06.prod.outlook.com (2603:1096:803:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.16; Fri, 20 May 2022 05:36:34 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::c5c2:d3e1:f0af:4a19]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::c5c2:d3e1:f0af:4a19%3]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 05:36:34 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Thread-Topic: [PATCH v5 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Thread-Index: AdhsCy3aguiSF6kNReuM+C+wxWgLLQ==
Date:   Fri, 20 May 2022 05:36:34 +0000
Message-ID: <SG2PR06MB23150BC7CBC564E04385C6D8E6D39@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 718c41b0-9cda-4b5f-7a89-08da3a22b37e
x-ms-traffictypediagnostic: PU1PR06MB2102:EE_
x-microsoft-antispam-prvs: <PU1PR06MB21021284524DDD5A4144C47BE6D39@PU1PR06MB2102.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4uTO9a+/2ljWX/+lIRPQaNKp5k68IpTnTJnnvPbX+7v+JFlcl3DJd019Jtc/A7XUmQzU9WQRRYU+lsHv1tNK4s6ag8RlemHB2Y+zmvkol5C/AWztqYeG7wqVLTLaRoEOpblPm7Gj8uCjLf41sz+MoAQaPnSmR8gTsm7oPXs424KxXW069lp0or1q09hueJWx+xgn8PGtduvs1VOjxMzLegaNL3wKk9g3eEA01PV6sCxzyO7pVOeW4PQVl+aE+WaoYhnyN1j3x7L7NUTGpiW9KhAS0MhiHDuIY514BwNEN2eZuzcjBxFZx1ADBwkWOErmbmVhi0TTKe/h+Ifu9hdOFkYEXVn1IXBtZcbunROY5941cxcE2v48HiqB8jenfI+YOHb8nY7XVUK8pmAWOSf0LCVFfzqIQzOyxDRikall8iuIjwVu0rEoS0IAaigWrV15fu4mpwFH0PNDRg3COJEEwZWGscEFW1CAol29IRssdABjnNboEsDccof3WSdvoc+gZqq2H3HsJ1oAD84696ycnILKmDppX/NlnS7+c3WDNsQJzbLmV0JInYXGjHwbZpydGpSd3Qz11UkLSu0G/wpF/ASnwKo/Ts1v7p/uo1SujypN2lmcjOPwUSDv6BbXvPirIZJPCJft2YOILC24Xo6Iop2wocCpXTUkiMg1Gv4Uyz4mXk6emmva6tPB5cKgKFl+kblrqUGipHc46DIfwFD+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(136003)(39850400004)(366004)(396003)(7696005)(76116006)(186003)(66556008)(26005)(83380400001)(9686003)(4744005)(71200400001)(38100700002)(66446008)(6506007)(316002)(107886003)(41300700001)(122000001)(8936002)(508600001)(4326008)(5660300002)(110136005)(55016003)(38070700005)(33656002)(2906002)(66476007)(66946007)(52536014)(64756008)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N4TBLceLkwC/y5w21ANqsmoN5bcCp54uOXoAjgDxG2hUy/MAxkv+J2L7ltwu?=
 =?us-ascii?Q?T600Kl812gz41M5z6g/eEZRtlTkDlnQAiME+ax8w+ueiqJH1r7nxxiI66EG2?=
 =?us-ascii?Q?HOFf/KbEBut3PQCrq7vlnDtOVaMDCwMiJ5TE/ec+t7kbJ1P2yuSJfL7yAVvs?=
 =?us-ascii?Q?s69OhG+M8srr6C4QFs6OJxRmko7yrw+OzVPmMRMzKEGr+255+LSK/Y0fqqMz?=
 =?us-ascii?Q?HOFuNafeOsrxYeWZap4Hc3CoRZtwVmzuNY8pk77hitQn+QdeamIEswjyH+zL?=
 =?us-ascii?Q?aZKRPQ6Rb7DQap3o7C/nQ6ni2AdjfQ4S8E5qAai6p7D0uC/TmMrswNQ8yGhk?=
 =?us-ascii?Q?mRCBQ9F79lgiMP5vOnk4R7dottBcfLte3GSDJYjJMmpreALhRtDCNgd6Vjib?=
 =?us-ascii?Q?g2dxq9myyH28QsWFFqB/V3wQR/zF4dz3Q/gqBzSJ8ffOtvSi/s51a+1VIbXT?=
 =?us-ascii?Q?PU9vgVQ7dVM8jdkQSxors6fyJTeL2JPaEbrJ834sNTgkEsTQKe+DJUGdMqwY?=
 =?us-ascii?Q?EC0zAfCa8nWCvJ/snA6vD5PAaJZh98xpZcXFAewi58vPdprCOkwwgaEdaRmW?=
 =?us-ascii?Q?+P0yA0ZmSoSf2WOjpgmLFqxYmuZfrf9Xk+EcAlMUp3NNe8PcBMlzx8k44Wf3?=
 =?us-ascii?Q?mArSFWC2JQPb2bUwH0TdkpZcSj3LaybTmgHUsoOABYLMBYecSCYUsKeNBSWf?=
 =?us-ascii?Q?dxSTrQskWFRjRThw/Nc21FIi2NVjHF8dMPbJZD/fnJsOO6OHNvoN8WJcUhlF?=
 =?us-ascii?Q?cA7TtEZHOgg0fTxvGvlBem440p1f490IU/hfz/ri5kHKjRidhmwVrP6BEqIG?=
 =?us-ascii?Q?jwNoQI47ZhKb+c3F89ap1JMGfselI1Hv+6H7d1+7/03Ei/in7PuAUV7tC9dj?=
 =?us-ascii?Q?5OTxemRzs9J3190CLNOMmJYI4z+k/pldmSUgv2g1aX5mmaP7sQFJ6P3JdACB?=
 =?us-ascii?Q?DH4zavY2pBwzhMTmzlZYaoshLzvp2WslZxIO61rsYgH5BM46W2Z37JdibRnS?=
 =?us-ascii?Q?L9CtOXOAZRI8E8g4m+4eBeEMeCujOvvW2twQ78IXHx6Fe+7ClyF915mFrlje?=
 =?us-ascii?Q?xHqBpENA4L7vrOUStRUr9TgWWkf3cqiEahWu/w9JubcZcYIgkXHf/9l2+g3U?=
 =?us-ascii?Q?+tArT56egFVvnwYKHOU4O6cC6oiUfJClsJSyITlu0ymrtMFxDaT3j91tH8KQ?=
 =?us-ascii?Q?P5vNxDHuGrWVhbMEUn6xOzG73r/nKgw70m7aY0A9rueKMJvmD+mjeR/caNVO?=
 =?us-ascii?Q?2Re9ZZlJn4EwU/f8kl7lSzISDzQ1YYHDnrOx8cyiue4cosmyOR652EHK2KRs?=
 =?us-ascii?Q?wojj/FGNDTrxVNjlIvXkdCUhcJ7Z55U+22mIwhcJyRaBysis9K5TjtCFvSPt?=
 =?us-ascii?Q?yJTVzEOjJve2Fp7b5ajzRM7+nEnTGyhvKzOPddqrWjv5ekOpd9+qeSM5wuq2?=
 =?us-ascii?Q?YsA3PulyKN+bgklNgpYPYN9J5t93lTd9/VRgCpQkwdjz79iYAlFbXHXLI+k9?=
 =?us-ascii?Q?AHKl5Xy9M8/IjGexfIjzJ1eunjbV9dG74JUsIHflgitcqf0NpcT/R5pab3uo?=
 =?us-ascii?Q?0w6QX6gfhcxdaROX7peMaIvCrWrlMv9IuhZYUy7/0G2omSuEItKV9wtjV4Xs?=
 =?us-ascii?Q?DfR5k6IcjGLOBPrf/uNRlohhfr34ooz8K9SBa9PcKX9wz4S/9rpV2d33Xl5Y?=
 =?us-ascii?Q?CuyR7IDtv9oRx4w+UUghpgQpRnCiqXPoXfOZmEFtUCP4Q6N/XSsgjNZdr6W3?=
 =?us-ascii?Q?jXI1bVSSe+5ldaxbXox/ocNC2Pzi/tY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718c41b0-9cda-4b5f-7a89-08da3a22b37e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 05:36:34.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAvb/UI1vlXoEHOE8VDIuX1/ZQcEJyuGpwlvyplKH6Y0aQYsTbo8G0Fr6ybo+A7fB2+N3iM0acGqD3tDjfvyPRylsiZCZ/KBblAUdUhGuD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Disable EHCI0
2. Enable Aspeed vHub for HID emulation
3. Remove duplicated EHCI1

Tested with AST2600
Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/a=
speed-ast2600-evb.dts
index 1db7aa0beea9..4452b6953c23 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -321,11 +321,7 @@ &sdhci1 {
 	clk-phase-sd-hs =3D <7>, <200>;
 };
=20
-&ehci0 {
-	status =3D "okay";
-};
-
-&ehci1 {
+&vhub {
 	status =3D "okay";
 };
=20
--=20
2.25.1

