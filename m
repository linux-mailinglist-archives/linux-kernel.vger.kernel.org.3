Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090A51FAA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiEILA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiEILAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:00:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D849223846;
        Mon,  9 May 2022 03:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obZvC5nMBTWMZqPBXi4sfkErodpzVIk/AEio/5+qRYcGBlfTz0rcQsDus/gyCQTbr0QaKO8ZXj5UE6stsF6hWZkHbPG0FNwwKn+yXmshsRkh15CVkq6Fp4F1Pj/Vjn2cM2Gcqz5SyCeHK5ujetssr9k6u79yW+GciPFkfayOLdG5aK9gANx3I4YQg1AQ/7MsJM6370Lz1r5iR+H2GH7N/FJqkDToFlwLBkBVpflfdPF3P13+CQ5fvdYp8WjONpP6GoOVgP62TXunlieODCYqsxoaOrrgy5g3i3/Sr6MiaXouEhHC9qzxZwY+OIhobpiynQV4Kg3GMewGG5p16Gi2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw5pgEQKA58XJQYy+GbiOq8o7OMCge2JNbp9kMWfdko=;
 b=cSblZjl2f9eNPdVucdyxWAsdyTG01Bz2r658MlBEEYfqBA5lxgqbplPfRLlt387iwq8mHsyg4SW0fUt0E9tN6cfIAWP2yHb/hn3XpsJbuae7Yq+yuVgNKf+0zGSAJInJ+8jZp3FymNDtidNhxXZ5uat+k8Na3+QYRa33dyxeUhVf+hQZ5Au+//ilyKqalyBX4sFp3GKyGlVyLXguhnkgBAvpblcAitOWKpKZNLXgb5DEoGm8Yg/7ra69vHPan3gzn+ApTuAQSic/7j+PC1AhxV36/DitIj+3e0alCZKOOzZVLhmpUFdGd75TBzYG6+gH+6wZUMvK3ENr9UekckN0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw5pgEQKA58XJQYy+GbiOq8o7OMCge2JNbp9kMWfdko=;
 b=TDdVoqHgIp1dXzFN11NvtluX1jpdDgDkNQJGBplG2x3Y7ER3FPj7hN1+sONpfK+WKR9yLc1NEuq7HOF3GO7us5WrQC8SwLUuQTUEnny62dG2MjyPGMse0tg91dQsM5XVMTRH8tzixaX0Xai2s99mPlD9IP/tgkkO0uFGp79mgM4=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by AM0PR04MB6849.eurprd04.prod.outlook.com (2603:10a6:208:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 10:56:20 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:56:20 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH V4 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Thread-Topic: [PATCH V4 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Thread-Index: AQHYY3Y9QVWIL6yCQk2dFYRSCUn0B60WX9DQ
Date:   Mon, 9 May 2022 10:56:20 +0000
Message-ID: <DB9PR04MB8477105168D158D1EE66F80180C69@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
 <20220509072911.3268668-2-peng.fan@oss.nxp.com>
In-Reply-To: <20220509072911.3268668-2-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7de9445-37fb-494b-fd2e-08da31aa8cda
x-ms-traffictypediagnostic: AM0PR04MB6849:EE_
x-microsoft-antispam-prvs: <AM0PR04MB684935A491D775583B3774BF80C69@AM0PR04MB6849.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g36yh95k6GDpPxd34m2603MG/SPffd/vfEaly2Dl7MnweeE9uHFJBPje4yx9Ypawsucd+XRsV3KX3yzLyvilYtO3nqkXX35iMJJEM/rC1/hQpC8cYpRc3Plp2DwDHcJrwi7xqMFGTMnkq/Vd7T8CHLSLPXMaGP7QjV5LAZGX5RkWjjhC+xL1KNS6UQ9MtRHdRba5QRZZxaYq7njpo9rYBtlxFc0dZ4Vfy7HyXtbpMqMkD2OIN6irc5ITu5Vi3VfAVJLoaTyBI5BS9DHkNS124zwyuMIWAEtxHwA22cppQjHEhchrQYS29HxXSUCtTo91x54ITNUgCITk/UbgQBWloHznvfqgIGwWdPRhDF8c1eC9G0QNFW53l/JTjtALgBJWn/gdMHFjBUqYz+BfpCHI1wiW3VyHovagqi6pv7NzpHvqJG0ax0gdLOWM9+QikJfdN/OvM5o8sccN3UkViDivNYf4Vg9zTiyGg75CFOhYzT4J5zjYDVeKPCG5NZ4/ahzFnYaXkAJ80rhSvkc9mKG1gsT0diyPIFKWEaYkFncbkK6+TSgPAVwpsJ1//nuXI6KvzhIM/FSxihrra9IpQrjatsTSyuQ5V/YeEVwRPUnUFlParzgJUe4M0VHmHauP++JnY38Gv7o5N/7TcibY3gzlH70MtMEbQsiti3Y0vkNbuumGW90VwDwl5IWsretyLPT8mgMUtkJy+F74m5Bdb9pGlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(55016003)(7416002)(44832011)(33656002)(52536014)(5660300002)(66476007)(64756008)(8676002)(66946007)(66556008)(66446008)(4326008)(76116006)(558084003)(54906003)(38070700005)(38100700002)(86362001)(186003)(110136005)(9686003)(26005)(6506007)(7696005)(122000001)(316002)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1NhbS9XeExoVzNXdXlnSENHdWJ1SVJVS2VRcXA0THFkQmFqcXFHOStSNy93?=
 =?utf-8?B?azY2MGpwZ0FDY1JSamZINW1aZjBXZDlvWGFmc3ZrNzdWVmVqc21WYWRWRlZi?=
 =?utf-8?B?akN3NUhUZVk0OWwrVEFrSExTeGFsSlFmV1ZOTXlCc0pDUk1OUEpkclp4N1RU?=
 =?utf-8?B?NEVqVFNSaUMyVGJBU293aXU5V1NpME1pcUd6RlpHaEFWUm9Pd0VocjlmWGtV?=
 =?utf-8?B?SGFwTEtzZDd1dERXeUNtMGljQWV1TzJVbzNKbG1JRlBxWHBHTXdrSEFVcncw?=
 =?utf-8?B?TjhSMlduWXpGSDhuMldZRG10REZZNnRpMjlrV1NGSTNkUmZlSGx0RVFGUVB3?=
 =?utf-8?B?aWphN3RvUmtZTmJKTERXY1RLcTlVZUdhaG1PdXdEaFRTN2dWSTR5d3pqdXFr?=
 =?utf-8?B?a0h4SGs1T0ZpdzRqSVV6b0FVV2pXZXVMc1pWcWZ4SXBGa3puMUs1NjRpN3Ax?=
 =?utf-8?B?NEw1aWFVUnhrWmRqMCtUc1FhOWNYREZ4cHJTa2xuZHB3eiswdk5Kc25pVXlr?=
 =?utf-8?B?UWFSb2YyMUxCTmxna3RrUGtWdnRTNmZxSUo0WUxHelBFNnM0d1RXS2FSNGx0?=
 =?utf-8?B?eUVSTFhrdkZmbUVFYnpzYU9hK1F5MmNTWW95OXhnMGs3aE1OZ3I4L0YweWM0?=
 =?utf-8?B?dGdsT1NxcUNwQnRzRFQxYUVEeGVNWWZDaUxFR1lCNS9ETG0yN043bDliZ2FL?=
 =?utf-8?B?YWc4QWN5aUZKT0R3Y1VRR2NHL29kZzV3ZEF1MWtLRmYybmF4MlBGZWZUSW5p?=
 =?utf-8?B?bVYwcDB2TjB1SUc3MjY4ZzByNWo0Rmtyb3ZsdjRIMlViSDFaZmMzTnl3VjAw?=
 =?utf-8?B?RmJTY0pMYTJDK1NTT0lnR1ZLK1NveExIdGoyZS84V3d1TEhrOEpTY1puS1Vk?=
 =?utf-8?B?VGg5V1lMQzc1bFdzcE1SeXNpLy9jbDBkOEJiS1MrdzcvZFpZUlo3K2NFOHVJ?=
 =?utf-8?B?cGdSTVZLWEVZTWRHVFJPM1FITFhYY3J6OHI0dkRsUGFWQjNHeG9zL0gzSS9k?=
 =?utf-8?B?ODdwT0hVSGtZZFkrKzFYQ1ljODhFcGs2TWtsd1lYVEVsTkQzRFI4SmVrNTY5?=
 =?utf-8?B?NDFnR3JuYzB2bFFwV2xaZ2IvRjZibCtKRXFNQmt3Smp3UzhTZ0F4Y3k3SFp5?=
 =?utf-8?B?aVZGcjR1WkM3djV2a1JWY1NuY3E0ai9ETlNtbkNLOHZSMHF5U0lzeUwwVUli?=
 =?utf-8?B?WUFrQnV0TzJEK2wwVlJqR0tBS2xYT25kMW16eTREcHB0M2R2MW56Sm1GTm1J?=
 =?utf-8?B?SlZQeDNPZThRRzc0NXU4MFdJQ2dDSTVhOXQ1d1lHWTlmTmVjN0Q3UFBtampo?=
 =?utf-8?B?OUxPRm1mNDRCTHdaRkZOKzdOMkNtSW5iUHc3OHBWelByd1k2NDZFcFR0Ykov?=
 =?utf-8?B?VmRwdU1ZWUxYRE9jZHc3NVY2TUNibm9udXhPQ2Rra1l6R21UOFdOYlZXc0Jn?=
 =?utf-8?B?V0VEdVVVNWtUbXdoQ2FONFh1UGFZSVQ3eGlaVndScmIrU3k0YnJFUUJTV1hU?=
 =?utf-8?B?TVlSTmJ4ck9VdUs5SWpmRk90ZDZMVzVZRzc3QzFWT0xUZE54Qko2UFQ2TGxB?=
 =?utf-8?B?eTE3VTZWcytOSlUxbmJYaUlOblNzYjNKNy9zMkNiTHF3OHRFS3Y1SVdjYTJJ?=
 =?utf-8?B?TGVKVldDNHlxaEJ4ajcvd2grNWFZNklGRWNGb0xEZzRKNGtmdVlQT21ISTY4?=
 =?utf-8?B?dkR4emt3VU0vLzUva29mdGlJR0xLZkEweUtTYkZqcndVakVGcTBjMHhJVTlM?=
 =?utf-8?B?SC9wTmE1eVNheEtZQjNSd1cxUXczcW1Ob0hPV2p3N3pSNDFjcHpaWFMyNUlO?=
 =?utf-8?B?aUxmcThobWZFOTdlYmwzTXZ0L1lZMzc3NTM5VEc1cjVUZ2VLbDM1bkJKdDAz?=
 =?utf-8?B?NU9uUDdlZUQwdkFRcEg2bis1ZVppa1JwU1V5WmhXQkhYLzhPKzVyUHJ6Ry9u?=
 =?utf-8?B?OTArclhFU0JBZXQ1ejdndGRmd2x1QnljZjlFVnFjdzVYdHk0WDZCeVN6M3FB?=
 =?utf-8?B?dmpWRlc2RVg1bVZSSis4a2NybE1ad1NrSXcrTHFZaU91bHh4SDNlYjlUdWwx?=
 =?utf-8?B?UUZrejVtcDZ2eEh3U0RMNGdpcFdzdlJKNVltV2o1MkV6NG4rdGorTWVTK2Fp?=
 =?utf-8?B?cmVyd0ZXYmljVXhFQ3FZSlM4dE1mMVBoejl5MDVKVXg2RVNCcnBORkZSK1p1?=
 =?utf-8?B?bEdLK2VBRXlicUd4eFIxYXh2RXJ3dTlnOFcxZTZSNzhGaUxKVndoL0tzTlpX?=
 =?utf-8?B?OFg5Y05JRHNUNTgvd25wdnduNllqMSsyZlhZMTJqNWk3VUJ6M20zcnFIZVNi?=
 =?utf-8?B?azlndVhsb25WS0tNMTBGVEVYekgvQW5IK1RoazByQ21taExGazBWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7de9445-37fb-494b-fd2e-08da31aa8cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:56:20.3241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afEyEa/u2zqukv8Rc+BCOThhgJXqLZVT7JfJ+L1ZwXzKNoLmy8I4kGpuL7eGbBlMmm6xrMtXHupziHxZ7BvBQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgTWF5IDksIDIwMjIgMzoyOSBQTQ0KPiANCj4gQWRkIHRoZSBib2FyZCBpbXg5My0xMXgx
MS1ldmsgaW4gdGhlIGJpbmRpbmcgZG9jdWVtbnQuDQo+IA0KPiBBY2tlZC1ieTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2Zm
LWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlz
aGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
