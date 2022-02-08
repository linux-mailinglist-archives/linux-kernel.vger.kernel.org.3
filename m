Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC20C4ACE6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbiBHBwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbiBHBwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:52:32 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ADFC0076EF;
        Mon,  7 Feb 2022 17:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWjXANsFTE7jjgGtdvOpC3Sf6zp7G57c0uGflLsP/oTeEBOUB0igf2F79ls621Rbskcy1IITDrnsOXmh+x1EFx5xF1+oF7bxgg91k0UV0Q89N4GIIje8hhoEn99StspFjvnsGAaGJKAObjhM8htwSECg97Z9+n5JI+F0nXI0v+qx8M0y7uaOaZKfJ3T4atXNYSAtbxwdrOiuWABqbFvJ/iwj3HKi57tH9dGqHHvT7tbVAWKGrUdwZHPl5t6peJyrSieW8RDvoj0c75dQfk+ldaJS02tpVQE0y6tfcLF6S5e2RPs5hcy16Jb9LACPlR2Kbw5DXpPEtpm3LC2QEmNH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tzq1IFgoNNy97kxVPNGDAOVyvRgm6BXm27T9vaUm5o=;
 b=mbcn21l6nfcYrq2LJsOAyLuCgQgPXT/oL7GHrk+1G/Q9AKVClP+UR9Q1j8hCVcQR1XpPoNTKaOJ2wxlWKLh4JJHTDdaPHGDPskP7nKtxLypH/vnKVTqOSn++hn/F+EcyDJMAtBbIzxzK1PDFpMP5mUfLzJEOCVNwFxaCMJuH2F1RL+4GNjiscxsG2vgeJHc4H0xDGp4gQItqY99XRGN+d9tqr8g9Iy1VVnra5/MpnUSo1GxPymlUCwdtfJgssTiPRW54mHR4xkTbqvu2qrlAh5dcNrJBIb7biQ3Ia/3XL6V8uVL4RoeUdPARxep8Onc4Nm0iabzSSbw5TGNrOcazlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tzq1IFgoNNy97kxVPNGDAOVyvRgm6BXm27T9vaUm5o=;
 b=HFW6T0ncl2z5frXdVs/c3Yroyi35jVLJRiQaiv8IdQukJxsBSQceJXUwVxeNkDqFjAHLi3J6ZMhJ4UqOVbWQCoLbzX3gJeQeFz0nyjPenUPBmKfp6T+bh85zO7W3yKYnFNMIM/STEw3tnMXXViXozHLZv2KL84TsoKQzgRbDPik=
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM9PR04MB8985.eurprd04.prod.outlook.com (2603:10a6:20b:408::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 01:50:00 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::800d:a31e:1d6:9be9]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::800d:a31e:1d6:9be9%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 01:50:00 +0000
From:   Jerry Huang <jerry.huang@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>
CC:     Alison Wang <alison.wang@nxp.com>
Subject: RE: [PATCH 2/2] ARM: dts: Add initial LS1021A IoT board dts support
Thread-Topic: [PATCH 2/2] ARM: dts: Add initial LS1021A IoT board dts support
Thread-Index: AQHX5/PGpdRxxsxj90OHJKNOkid8L6yJTGWg
Date:   Tue, 8 Feb 2022 01:49:59 +0000
Message-ID: <VE1PR04MB6477BB08C1AF9F1E5A0B0C1BFE2D9@VE1PR04MB6477.eurprd04.prod.outlook.com>
References: <20211203031332.902485-1-jerry.huang@nxp.com>
 <20211203031332.902485-2-jerry.huang@nxp.com>
In-Reply-To: <20211203031332.902485-2-jerry.huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 315d54e1-f2d5-4393-e040-08d9eaa55122
x-ms-traffictypediagnostic: AM9PR04MB8985:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM9PR04MB89859CC9B28F51B28510236DFE2D9@AM9PR04MB8985.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QaWSuaFaV9A0COkmXfnHvCO3/PYsO9Wx2euwWr12EnlGdIr/3+xcJj+3MHuMExEHWNqW2iRaFxslV6tR0HqTimPmioiIqSgO2lJHVJX05qKBPceGNwLKoMps/guu8VcWpL5qF4q3eafO67j0JhKH5xBggdJmRq1irqecAhRbSGMH9jLmMJnj+GUwVFqz+uIrBEnSDTGXdeEZcOWefjyUXvveR2W7ytjvrof1WHdZYB6i80jI1LBUAIv/HJs8pVX/uhksLHtSPi3P9u04G3AUoBGVq6IiZUuL2pGktByOdflBT/OszHzC5dIXdORPfD3sLfh90LTSQ5YloIONsYf8AITbh+rkQoCvJIIi8Uz8RCpOL1yDdMSXl3FlUNB6aLIXoXqpikktIFn2KWB1THrGeoXwt6QOTmDvRRBsFTmGB1TGztjppdYAgcurbKBxpSpHyULbms3Ry1T1mNr79a+OqYIgCAz3uhi+9GOkCUEcmcdfRVwjir4hhYWOTNUsPe7WbmbgbLB5VLtI+NsEqWhVcxJPxs8nKugTrOo48mGrijiBK3Bz2k1mlF5Dw+WhVpCmmscZlex4Duz3clzUF+NVCmz5N7hKIbQuD6GulPxYyczaYr2g6q0DuETE8S8fGBhE0kwKgK2dP4rNrTA11fdDFdIaAEtXaGU2/eBLFGTzlKNkMwgYh84WWydhcJ7JvDdIOqahdb/RQWyjvCT2ZrkBip2h9OOiOWSB4ZS55S9Iv6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(316002)(52536014)(33656002)(9686003)(86362001)(64756008)(53546011)(66446008)(66476007)(66556008)(66946007)(7696005)(76116006)(110136005)(6506007)(4326008)(44832011)(8936002)(122000001)(71200400001)(8676002)(38070700005)(921005)(508600001)(26005)(38100700002)(5660300002)(7416002)(55016003)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VUMyVVlneHNlNklHTVN4ZmVzUndRNC9HYWdrcS9VUmQ3cWVZOFFvWDNHcUJm?=
 =?gb2312?B?Qk1yNmt4ejc1RVpqMzloSDdMM3BRUTcwY09hUm9uamNoYW5qSm5XMHFCempq?=
 =?gb2312?B?Qm4zbDcrdXMyRnBWNkExZ24wSHB0cE5RWnV0WWtEc25kOVlubENSRmxkRTZi?=
 =?gb2312?B?dEk2MTNmRTBFTEZWSmZvV2FQdXZRN1NQRGMvYUlCYXF6cTRCcEx1dUtZRnM3?=
 =?gb2312?B?YktmQi8xNWhoUlplVE83VFNFQ3Y1NklqSXNEZCtkWm4rWnd6dWpEWVpubERV?=
 =?gb2312?B?QTkzZzE2NFFVYkdJNDRFd1BGam9xREV0NXpmOXNWRGxuelRTU2lXZHN0V3FT?=
 =?gb2312?B?QVNRdVQ1b0JHek5ZUWJkdWVKMUYxUUhmbXpNemJRbksxdFhwNEFQVEVrM25C?=
 =?gb2312?B?Wmx1SE45eEJKYjQ2YXlORG1OUDV4T3BGdWhiNTQ2Z1lHTlAvbHRmZXA4L1Uy?=
 =?gb2312?B?YjdGeDVvUktwUHBKSTlvUFVJYUpPU3V1UVYzVmpHNVJwOGM4NVZRMzI5TkxD?=
 =?gb2312?B?WUtla2ZCYjJsdTZzWWxaMjJJUWhJTDdnOHpubE9CcXJ6bkxZc2ZBNFlRS2F4?=
 =?gb2312?B?THhiMFZVOEhEbUsrY09XYkYvRElDb05US05iVGYwaEJYUXJFTS91dHdEWkdl?=
 =?gb2312?B?bE9qaVNXVk1hckZyaWkwVkN4bW9JVXgxekdDcmxwU3hObDA4OXZyWmhXSlZP?=
 =?gb2312?B?dzNwMTcyR0h3YVAxc1c1T1dsUkQ2YUNtUzJ4Rk9GbG9TWUthTEpNMmR5U1Yv?=
 =?gb2312?B?dHFaS2V5SHBmQy9qcVpwRTJwVGZhRmJxVFJrd2Jnd3VDYm8zZE8rTWY3SDJ5?=
 =?gb2312?B?YXlrSHA0b3ZKOE5kSUNsZXhFZW5ldVhPaXZ5SGg0OUtnMjRkSkMrckU0TWtB?=
 =?gb2312?B?ZGh5ZDZNMENpZ1BFQkllRnpEMzd5T3dLTHpQOWxVWlZuMGtxNWVRUkdYRmdS?=
 =?gb2312?B?VFFuSm1vcWNyTVd4TUU3cWhsUVRGTm04M3VpNHhMK0ZrbVJLdUgxclNROWhR?=
 =?gb2312?B?ai9KKzk1eHB4dk83alNibmJHaGdsdDJyMkVmWitJZ2xsMVZjK1lScDZjQzVj?=
 =?gb2312?B?ckdDRk1SbVRxcC9XMFNEWUpnRThKb29lR0tYLzBFR1FqKy9nYVVxejBWOEdq?=
 =?gb2312?B?Q2J3aDZsb2wzWEtxdjROdGpkQysrQ0lTR2pLdHFWcVNrNHlvU1M3NERGVjVv?=
 =?gb2312?B?Z0hCNytmWE9jU1ZjcmV3MEhjeGxVaUZES3hEU2NMRnduc1ZxRWMva1V2WFhm?=
 =?gb2312?B?cWRYemQ1RmRyK1FqRjMyUmlvWnNRVzV5UElTOGxEcjRXSVpHbkpIK3J0dDdC?=
 =?gb2312?B?QWVaTVg0bXR6YUQ2OVU3MkQrOS9vVmh5Z3JFNEhNS05USWY4UmJlWng4OXJp?=
 =?gb2312?B?R2plWnRwM0phMzcrcnV0bGQ5VHZSU0VKcXJTT3JuL3BaS0RoemplQ1l2c3Bm?=
 =?gb2312?B?THV6NC9KVFFDVXcrQmR1QXVNcWlHcHhTeGF1V1JDcHBLVWZnT0NJcXFDNWpC?=
 =?gb2312?B?UnZTc0xnVkQrZDRLMTJ2bWlHTzA2VVNYYVhUZlNNNEhuRDJ2WE5sSVpuSlJo?=
 =?gb2312?B?Zkg4MkJ6djYreGF6ZTZMQm1jRnZNZjRBakdyYlQ3S1kvNTRON3BDdGJPdStt?=
 =?gb2312?B?SmVwT2tWbW5KWUpZV3BxbzYxVGpmWVl1MUh2ZitEcjdBc3JJa01SeXNQampr?=
 =?gb2312?B?eHJpdUhyb3BpTGwzNkVnL3hDOXBNemlrWTluUnJvQTdsNy9BUkpjOGJ6UUZv?=
 =?gb2312?B?M0w5R3dQMzJpcWtJSjVSRnAxSEkvZm5WY3JNWncwaXZZUmpPNHpER2l5Q1U5?=
 =?gb2312?B?L2kyRm5HdzZDVVdFUm45MU41d1RuU2pycTlwNHJHVzZndlRrT29yNzdIaUNO?=
 =?gb2312?B?MEVnRTNES052TkVndTRnV05LZy9lQ3N0bU9VVGgwVjBVUk5QZ3RoUWEzK0hX?=
 =?gb2312?B?NWJ2QkNJVVVvU0VqKzY0S1NsWm5jY3NMck96dDl5ZEZ5U3lJejVETFo3WVhm?=
 =?gb2312?B?M0hqY0FTRGtUZGl3ZHhTeXpFY05scXJodlp4N2xaRjZpNmJNVmp5ZE1saE5a?=
 =?gb2312?B?RlRxMmNyU2VTRkhhZjlCZG52NUozVjFTZ0s5eE0zSS96VmtPOERFckprVUNJ?=
 =?gb2312?B?Nzl0dWsxN09qZlMycHc4UlZqK1NKT2xlUTFPSTQ2R0laeHJkdEdCV3BRb2xT?=
 =?gb2312?B?aFE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315d54e1-f2d5-4393-e040-08d9eaa55122
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 01:49:59.8567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irh0m+R3WMDQqydt2O8tfj6TDLuZUPMmS2S/fLJx/KAgNsjVUozsj2D9VTk9N4QfeVDac+BdiUliM4r4aI/wYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW55IGNvbW1lbnQgZm9yIHRoaXMgcGF0Y2g/DQoNCg0KQmVzdCBSZWdhcmRzDQpKZXJyeSBIdWFu
Zw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVycnkgSHVhbmcgPGplcnJ5
Lmh1YW5nQG54cC5jb20+IA0KU2VudDogMjAyMcTqMTLUwjPI1SAxMToxNA0KVG86IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgYXJuZEBh
cm5kYi5kZTsgb2xvZkBsaXhvbS5uZXQ7IHNvY0BrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IGtyenlzenRvZi5rb3psb3dza2lAY2Fu
b25pY2FsLmNvbTsgbGludXhAcmVtcGVsLXByaXZhdC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyB0
aGFydmV5QGdhdGV3b3Jrcy5jb207IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRv
cmFkZXguY29tPjsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207IGRldkBseW54ZXllLmRlOyBj
bmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tOyBzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJv
cmEuY29tDQpDYzogSmVycnkgSHVhbmcgPGplcnJ5Lmh1YW5nQG54cC5jb20+OyBBbGlzb24gV2Fu
ZyA8YWxpc29uLndhbmdAbnhwLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAyLzJdIEFSTTogZHRzOiBB
ZGQgaW5pdGlhbCBMUzEwMjFBIElvVCBib2FyZCBkdHMgc3VwcG9ydA0KDQpUaGUgTFMxMDIxQS1J
b1QgZ2F0ZXdheSByZWZlcmVuY2UgZGVzaWduIGlzIGEgcHVycG9zZS1idWlsdCwgc21hbGwgZm9v
dHByaW50IGhhcmR3YXJlIHBsYXRmb3JtIGVxdWlwcGVkIHdpdGggYSB3aWRlIGFycmF5IG9mIGJv
dGggaGlnaC1zcGVlZCBjb25uZWN0aXZpdHkgYW5kIGxvdyBzcGVlZCBzZXJpYWwgaW50ZXJmYWNl
cy4NCg0KQ0M6IExpIFlhbmcgPGxlb3lhbmcubGlAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IENo
YW5nbWluZyBIdWFuZyA8amVycnkuaHVhbmdAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFsaXNv
biBXYW5nIDxhbGlzb24ud2FuZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvTWFr
ZWZpbGUgICAgICAgIHwgICAzICstDQogYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS1pb3QuZHRz
IHwgMjQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwg
MjUwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybS9ib290L2R0cy9sczEwMjFhLWlvdC5kdHMNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgaW5kZXggMGRlNjRm
MjM3Y2Q4Li44NTM0ZjZmOTRiYzMgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9NYWtl
ZmlsZQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCkBAIC03MjcsNyArNzI3LDgg
QEAgZHRiLSQoQ09ORklHX1NPQ19MUzEwMjFBKSArPSBcDQogCWxzMTAyMWEtbW94YS11Yy04NDEw
YS5kdGIgXA0KIAlsczEwMjFhLXFkcy5kdGIgXA0KIAlsczEwMjFhLXRzbi5kdGIgXA0KLQlsczEw
MjFhLXR3ci5kdGINCisJbHMxMDIxYS10d3IuZHRiIFwNCisJbHMxMDIxYS1pb3QuZHRiDQogZHRi
LSQoQ09ORklHX1NPQ19WRjYxMCkgKz0gXA0KIAl2ZjUwMC1jb2xpYnJpLWV2YWwtdjMuZHRiIFwN
CiAJdmY2MTAtYms0LmR0YiBcDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIx
YS1pb3QuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS1pb3QuZHRzDQpuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi40N2FkNzE4ZGM1NDINCi0tLSAvZGV2L251
bGwNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEtaW90LmR0cw0KQEAgLTAsMCArMSwy
NDggQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKy8qDQorICogQ29w
eXJpZ2h0IDIwMjEgTlhQDQorICoNCisgKi8NCisNCisvZHRzLXYxLzsNCisjaW5jbHVkZSAibHMx
MDIxYS5kdHNpIg0KKw0KKy8gew0KKwltb2RlbCA9ICJMUzEwMjFBLUlPVCBCb2FyZCI7DQorCWNv
bXBhdGlibGUgPSAiZnNsLGxzMTAyMWEtaW90IiwgImZzbCxsczEwMjFhIjsNCisNCisJc3lzX21j
bGs6IGNsb2NrLW1jbGsgew0KKwkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQorCQkjY2xv
Y2stY2VsbHMgPSA8MD47DQorCQljbG9jay1mcmVxdWVuY3kgPSA8MjQ1NzYwMDA+Ow0KKwl9Ow0K
Kw0KKwlyZWd1bGF0b3JzIHsNCisJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQorCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCisJCSNzaXplLWNlbGxzID0gPDA+Ow0KKw0KKwkJcmVnXzNwM3Y6
IHJlZ3VsYXRvckAwIHsNCisJCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQorCQkJ
cmVnID0gPDA+Ow0KKwkJCXJlZ3VsYXRvci1uYW1lID0gIjNQM1YiOw0KKwkJCXJlZ3VsYXRvci1t
aW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0g
PDMzMDAwMDA+Ow0KKwkJCXJlZ3VsYXRvci1hbHdheXMtb247DQorCQl9Ow0KKw0KKwkJcmVnXzJw
NXY6IHJlZ3VsYXRvckAxIHsNCisJCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQor
CQkJcmVnID0gPDE+Ow0KKwkJCXJlZ3VsYXRvci1uYW1lID0gIjJQNVYiOw0KKwkJCXJlZ3VsYXRv
ci1taW4tbWljcm92b2x0ID0gPDI1MDAwMDA+Ow0KKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0
ID0gPDI1MDAwMDA+Ow0KKwkJCXJlZ3VsYXRvci1hbHdheXMtb247DQorCQl9Ow0KKwl9Ow0KKw0K
Kwlzb3VuZCB7DQorCQljb21wYXRpYmxlID0gInNpbXBsZS1hdWRpby1jYXJkIjsNCisJCXNpbXBs
ZS1hdWRpby1jYXJkLGZvcm1hdCA9ICJpMnMiOw0KKwkJc2ltcGxlLWF1ZGlvLWNhcmQsd2lkZ2V0
cyA9DQorCQkJIk1pY3JvcGhvbmUiLCAiTWljcm9waG9uZSBKYWNrIiwNCisJCQkiSGVhZHBob25l
IiwgIkhlYWRwaG9uZSBKYWNrIiwNCisJCQkiU3BlYWtlciIsICJTcGVha2VyIEV4dCIsDQorCQkJ
IkxpbmUiLCAiTGluZSBJbiBKYWNrIjsNCisJCXNpbXBsZS1hdWRpby1jYXJkLHJvdXRpbmcgPQ0K
KwkJCSJNSUNfSU4iLCAiTWljcm9waG9uZSBKYWNrIiwNCisJCQkiTWljcm9waG9uZSBKYWNrIiwg
Ik1pYyBCaWFzIiwNCisJCQkiTElORV9JTiIsICJMaW5lIEluIEphY2siLA0KKwkJCSJIZWFkcGhv
bmUgSmFjayIsICJIUF9PVVQiLA0KKwkJCSJTcGVha2VyIEV4dCIsICJMSU5FX09VVCI7DQorDQor
CQlzaW1wbGUtYXVkaW8tY2FyZCxjcHUgew0KKwkJCXNvdW5kLWRhaSA9IDwmc2FpMj47DQorCQkJ
ZnJhbWUtbWFzdGVyOw0KKwkJCWJpdGNsb2NrLW1hc3RlcjsNCisJCX07DQorDQorCQlzaW1wbGUt
YXVkaW8tY2FyZCxjb2RlYyB7DQorCQkJc291bmQtZGFpID0gPCZjb2RlYz47DQorCQkJZnJhbWUt
bWFzdGVyOw0KKwkJCWJpdGNsb2NrLW1hc3RlcjsNCisJCX07DQorCX07DQorfTsNCisNCismZW5l
dDAgew0KKwl0YmktaGFuZGxlID0gPCZ0YmkxPjsNCisJcGh5LWhhbmRsZSA9IDwmcGh5MT47DQor
CXBoeS1jb25uZWN0aW9uLXR5cGUgPSAic2dtaWkiOw0KKwlzdGF0dXMgPSAib2theSI7DQorfTsN
CisNCismZW5ldDEgew0KKwl0YmktaGFuZGxlID0gPCZ0YmkxPjsNCisJcGh5LWhhbmRsZSA9IDwm
cGh5Mz47DQorCXBoeS1jb25uZWN0aW9uLXR5cGUgPSAic2dtaWkiOw0KKwlzdGF0dXMgPSAib2th
eSI7DQorfTsNCisNCismZW5ldDIgew0KKwlmaXhlZC1saW5rID0gPDAgMSAxMDAwIDAgMD47DQor
CXBoeS1jb25uZWN0aW9uLXR5cGUgPSAicmdtaWktaWQiOw0KKwlzdGF0dXMgPSAib2theSI7DQor
fTsNCisNCismY2FuMHsNCisJc3RhdHVzID0gImRpc2FibGVkIjsNCit9Ow0KKw0KKyZjYW4xew0K
KwlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KK307DQorDQorJmNhbjJ7DQorCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQorfTsNCisNCismY2FuM3sNCisJc3RhdHVzID0gIm9rYXkiOw0KK307DQorDQorJmVz
ZGhjew0KKwlzdGF0dXMgPSAib2theSI7DQorfTsNCisNCismaTJjMCB7DQorCXN0YXR1cyA9ICJv
a2F5IjsNCisNCisJbWF4MTIzOUAzNSB7DQorCQljb21wYXRpYmxlID0gIm1heGltLG1heDEyMzki
Ow0KKwkJcmVnID0gPDB4MzU+Ow0KKwkJI2lvLWNoYW5uZWwtY2VsbHMgPSA8MT47DQorCX07DQor
DQorCWNvZGVjOiBzZ3RsNTAwMEAyYSB7DQorCQkjc291bmQtZGFpLWNlbGxzPTwweDA+Ow0KKwkJ
Y29tcGF0aWJsZSA9ICJmc2wsc2d0bDUwMDAiOw0KKwkJcmVnID0gPDB4MmE+Ow0KKwkJVkREQS1z
dXBwbHkgPSA8JnJlZ18zcDN2PjsNCisJCVZERElPLXN1cHBseSA9IDwmcmVnXzJwNXY+Ow0KKwkJ
Y2xvY2tzID0gPCZzeXNfbWNsayAxPjsNCisJfTsNCisNCisJcGNhOTU1NTogcGNhOTU1NUAyMyB7
DQorCQljb21wYXRpYmxlID0gIm54cCxwY2E5NTU1IjsNCisJCWdwaW8tY29udHJvbGxlcjsNCisJ
CSNncGlvLWNlbGxzID0gPDI+Ow0KKwkJaW50ZXJydXB0LWNvbnRyb2xsZXI7DQorCQkjaW50ZXJy
dXB0LWNlbGxzID0gPDI+Ow0KKwkJcmVnID0gPDB4MjM+Ow0KKwl9Ow0KKw0KKwlpbmEyMjBANDQg
ew0KKwkJY29tcGF0aWJsZSA9ICJ0aSxpbmEyMjAiOw0KKwkJcmVnID0gPDB4NDQ+Ow0KKwkJc2h1
bnQtcmVzaXN0b3IgPSA8MTAwMD47DQorCX07DQorDQorCWluYTIyMEA0NSB7DQorCQljb21wYXRp
YmxlID0gInRpLGluYTIyMCI7DQorCQlyZWcgPSA8MHg0NT47DQorCQlzaHVudC1yZXNpc3RvciA9
IDwxMDAwPjsNCisJfTsNCisNCisJbG03NWJANDggew0KKwkJY29tcGF0aWJsZSA9ICJuYXRpb25h
bCxsbTc1YiI7DQorCQlyZWcgPSA8MHg0OD47DQorCX07DQorDQorCWFkdDc0NjFhQDRjIHsNCisJ
CWNvbXBhdGlibGUgPSAiYWR0NzQ2MWEiOw0KKwkJcmVnID0gPDB4NGM+Ow0KKwl9Ow0KK307DQor
DQorJmkyYzEgew0KKwlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KK307DQorDQorJmlmYyB7DQorCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQorfTsNCisNCismbHB1YXJ0MCB7DQorCXN0YXR1cyA9ICJva2F5
IjsNCit9Ow0KKw0KKyZtZGlvMCB7DQorCXBoeTA6IGV0aGVybmV0LXBoeUAwIHsNCisJCXJlZyA9
IDwweDA+Ow0KKwl9Ow0KKw0KKwlwaHkxOiBldGhlcm5ldC1waHlAMSB7DQorCQlyZWcgPSA8MHgx
PjsNCisJfTsNCisNCisJcGh5MjogZXRoZXJuZXQtcGh5QDIgew0KKwkJcmVnID0gPDB4Mj47DQor
CX07DQorDQorCXBoeTM6IGV0aGVybmV0LXBoeUAzIHsNCisJCXJlZyA9IDwweDM+Ow0KKwl9Ow0K
Kw0KKwl0YmkxOiB0YmktcGh5QDFmIHsNCisJCXJlZyA9IDwweDFmPjsNCisJCWRldmljZV90eXBl
ID0gInRiaS1waHkiOw0KKwl9Ow0KK307DQorDQorJnFzcGkgew0KKwludW0tY3MgPSA8Mj47DQor
CXN0YXR1cyA9ICJva2F5IjsNCisNCisJcWZsYXNoMDogczI1ZmwxMjhzQDAgew0KKwkJY29tcGF0
aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJI3Np
emUtY2VsbHMgPSA8MT47DQorCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQorCQly
ZWcgPSA8MD47DQorCX07DQorfTsNCisNCismc2FpMiB7DQorCXN0YXR1cyA9ICJva2F5IjsNCit9
Ow0KKw0KKyZ1YXJ0MCB7DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KKyZ1YXJ0MSB7DQor
CXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KKyZkY3Ugew0KKwlkaXNwbGF5ID0gPCZkaXNwbGF5
PjsNCisJc3RhdHVzID0gIm9rYXkiOw0KKw0KKwlkaXNwbGF5OiBkaXNwbGF5QDAgew0KKwkJYml0
cy1wZXItcGl4ZWwgPSA8MjQ+Ow0KKw0KKwkJZGlzcGxheS10aW1pbmdzIHsNCisJCQluYXRpdmUt
bW9kZSA9IDwmdGltaW5nMD47DQorDQorCQkJdGltaW5nMDogbW9kZTAgew0KKwkJCQljbG9jay1m
cmVxdWVuY3kgPSA8MjUwMDAwMDA+Ow0KKwkJCQloYWN0aXZlID0gPDY0MD47DQorCQkJCXZhY3Rp
dmUgPSA8NDgwPjsNCisJCQkJaGJhY2stcG9yY2ggPSA8ODA+Ow0KKwkJCQloZnJvbnQtcG9yY2gg
PSA8ODA+Ow0KKwkJCQl2YmFjay1wb3JjaCA9IDwxNj47DQorCQkJCXZmcm9udC1wb3JjaCA9IDwx
Nj47DQorCQkJCWhzeW5jLWxlbiA9IDwxMj47DQorCQkJCXZzeW5jLWxlbiA9IDwyPjsNCisJCQkJ
aHN5bmMtYWN0aXZlID0gPDE+Ow0KKwkJCQl2c3luYy1hY3RpdmUgPSA8MT47DQorCQkJfTsNCisJ
CX07DQorCX07DQorfTsNCi0tDQoyLjI1LjENCg0K
