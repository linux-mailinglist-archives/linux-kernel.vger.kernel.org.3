Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422B756401E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiGBMsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:48:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18DD117;
        Sat,  2 Jul 2022 05:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrsEeYZNRX7eXwXXlra98mjfRfPhTOiEwrhFIJoa6naB13GI5yAjgyH5Kpg+Cu6w96ZTT0zUwfGl7iKAcw7F0VPvZPRveCmYfI0KQlSBJbCESgKe4DAT7uYiui8CsPNKsb7xyrhFNl9n92lo/+ycd4S/Eh2A94spXB8Fs9r94rjKPeBkEZaNZFdnqN6+OS8BONtwUwncH8KKBWm2HiiEZPvX8K7MEzt+dpDc+K0eZRIm7H6Lzn7LtJ2IRgisJf4XYSXigBSaNrKL4Ll+oWzRU835CBG3HlQJY+HQKs0ybCqQFuK/K2OhfR0A9rJWlcgSdKDkD8urinNMsPM/syt+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPhW1scvt51ZVDx8ZJvnTCG8Ub4fGbIVZCfxXC/pqJA=;
 b=fkr6yMCMxTKgpiBL1pnhisfDf1XsisxQC7nIeeiftPE1W2B1cCpK51PAt1UzXx0BEVQL4rQ2lTYCFpj2VMFTdDkYO2ggD8PuLZTNqoWzTxTUzdOYquIJ/ZDvV4OqQ8ajSafwdSK7FiRBqeRi8Ln4zZIEhi4EMINX7XtiCFsOlVbvkg+VVZgUOuwHNRVAlQMiXaCxOpPU0FM/614BShmU497a07kzKkNWZwFdbz+RB56xAU5uWJJg2DNbi5Xq90rfj6Ze7+GIyRTRwnEQrEp+xL425aBbyPvqYZUEA7yKyG/CV7oz49gbBsa/XwZDb9iG92ztMNeqtVxG6pMu7gXQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPhW1scvt51ZVDx8ZJvnTCG8Ub4fGbIVZCfxXC/pqJA=;
 b=XYDDPQq0wDishWUr68W1yykZfztWLJjPTIAdRJCNiFiANyc1Xh59buISBq1G9BkTLVpLFgKIauT9HNJ5W3ypyb/1AJU1/bRww0ck4Xb2kLB2mjzW+PbT/mDxOQb7yn3Dyn+KbKmpiqNWhApzFrqQZ3R4AaD5LJNrbIza9ufp0io=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8421.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sat, 2 Jul
 2022 12:48:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Sat, 2 Jul 2022
 12:48:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>
Subject: RE: [PATCH V2 7/9] interconnect: imx: set of_node for interconnect
 provider
Thread-Topic: [PATCH V2 7/9] interconnect: imx: set of_node for interconnect
 provider
Thread-Index: AQHYgVM5xH0gY+zZSkukD1OS8ObcfK1mkakAgASOCEA=
Date:   Sat, 2 Jul 2022 12:48:45 +0000
Message-ID: <DU0PR04MB9417B73F60FE49C361E898F788BC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
         <20220616073320.2203000-8-peng.fan@oss.nxp.com>
 <3c773637f626877832041d3065f387261ba70816.camel@pengutronix.de>
In-Reply-To: <3c773637f626877832041d3065f387261ba70816.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b4f7fb0-afac-4ff9-a903-08da5c2933dd
x-ms-traffictypediagnostic: AM9PR04MB8421:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mnOol+sz6DXmpeyfJkpsn3FzjktbLD4FvfXem0QQaMiWYiP4pfbx33Xq/5Em8XYEVifIiMG/Zl5WoZpQbXlKiK9RSZYjNu6inchu/XBvt3S4y5AfT8VsYSReDO+pSR9bfiQbA/JU9aCoXWR0/JS/sa8oocJNnMRyW2WgCaK/R5qUX1nloMcoIa89h6t6eLdZt0Lj8/d2+T54Llx5tvGwhJQKzfMOPckzI6XUwMynpp+Cr4H7eDmbNRjHEOjDA/QaMoAJ0bbOrtHG+Tza1uhSX6+ZdB0mXhqRmc8tApsDD54kj3iFNdUdhYXw3rEuB3h9ZMPDnEf3DJsYXoftA2KM4VyOO/S979DJWgLaidn2DXippGesjUb3SVanerL0CR+oyR1Eu2xT6GMiMR/FuvoIhQ6PMXGQpJpx+t2L6X0W0PWBeBO9laJ0pPUEa5tL/MgHT8rsCHlI+ezM9kb5ovF+gPBa9Si86gxp9DTI1QaoZgEV5fFUzvxD2/uWdsGOK1hGCD3wznBNNZ/C3BaQAn8BwIZOWctnwI3SaBnYbgvN2EQU1eVtHmKUDRKRoCVbkKk2r2nmd1iRhR5L+lIqpbbsWlLAQyYaCsm12JmJmAC5D1338uryPovwAdFGg0GWWBcaM4ZAyrx9yBq9NPCUqL2Azkm1sIth3/oghD89jCaW6kk6RMRa8YrH6KtS4XEB0RmPm61vVViPQjWbGLzOKvVh9slBGa5pYaWR1fc0mU4ZB/eu2Fi9nxv1hD9jZd1ltEP6e4EgQOBzt0/6Ic7BIA5k3zNcpwaZ34MdwB0KqEp6Nvx1IP6K4DlRcr2dm4qSgAWWcGjNfqIFe/uQypBei+DLCWa4JFLX2b6fDzz619exUeqqcvsB4KeVRc3OpP7ujD5U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(4326008)(316002)(8676002)(64756008)(76116006)(66446008)(66476007)(66556008)(66946007)(478600001)(41300700001)(54906003)(110136005)(71200400001)(6506007)(966005)(55016003)(52536014)(8936002)(2906002)(5660300002)(7416002)(44832011)(7696005)(38100700002)(33656002)(86362001)(921005)(122000001)(38070700005)(186003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDdlZndpOWFjUENsdDJUSytOWUJPUkJMMGFuTHVpOGJIamJYWEhaVDFEZXF6?=
 =?utf-8?B?ZytSWGxXZ0pma2RSeVpjZnNNYkRnL2RoSWJRR3R6MEVpN2d2dFIybVREemtH?=
 =?utf-8?B?SmcrMTQwTmxUMnJvWVRsdDF3YU4wSWovYjNETkl0d3E5NjhxKy9McVpuaVc4?=
 =?utf-8?B?MFN1N0wyV3BtSS90MncxZW9ZUEljU1hoQ0VLQ0UxQTRCdGFIR0hnb1JZMHpu?=
 =?utf-8?B?RURsRmVJNzBBcmpxdEMvR3Z3QjhYWWx4bDBOYjlBQmNWTUp2SURmM0p3OUw5?=
 =?utf-8?B?UkdiVC9lN3pPMnFRcHlNLzhFN2ZKU0NIUXk5dEVDKzRyblNuSUVpL0JZYmR6?=
 =?utf-8?B?bEpUaXVhSHZ2b2YvcXVPYmZtRGtrbzlBdVlSRGZnY0RXYWVnS2NrM2IwcTM3?=
 =?utf-8?B?RXFCMzJUV3lFdFcydi9LamI3cW5SdWl0SlpJSGFzUHBIdXFINE5zaGd2Sjhx?=
 =?utf-8?B?WDlBM3pkWWNnTmpMMkpPTERlSkZ4QXRIUkdZaWVmTVF5VTlWN3JwY0xkb1NW?=
 =?utf-8?B?NWM3YXpPTVJNaWk2c3hENHV6MHVSSWk4YW0rRm0wQ0JQVnE4ZGNkT2htNDE5?=
 =?utf-8?B?SmdidmFnTHp3UElyVSt2eFZuS3d1SDFmSUhpYjlJd0FlTGwyUGs4VFlvSjk2?=
 =?utf-8?B?d1dndmdGVEx4cWd2VEJrOHpxeVZpbUk4YnovUUFlMlhDblF0NmxmamhzQ1lC?=
 =?utf-8?B?Ulc4b3hyUGhlL1R2WHZuMkprRTBVUWJKRm84ZjlyUE5mWUd3dFFXK1YxNG1j?=
 =?utf-8?B?WGV6SEYxcGxPNUlRTUdoTHlOaWtYdUpOTmtsTmVpTHFoLzZvdU5WaThQVmRP?=
 =?utf-8?B?WmJuWEVIOGE5QU1YU3pOSTI5MEE5dStQZWVmN1duSlNQR0hqYmtYcytoemlD?=
 =?utf-8?B?YU5YMm1hbDZEZkZDeUcxc2h5TW52YlkwV3B5Z1k2UTdDRGRnclhvU0ViZFZq?=
 =?utf-8?B?QTh2eWh6SDRmNlZzUjR4U0ZuYlA4VkhCVlZYUHlWR0NmNS84ZkZTb3lhRzgz?=
 =?utf-8?B?S2JlOEZCRDFMYXhKZGlGdmFlQUhMN3RBSUdPOE8zNzA1eTROeldRUC9nS3Jz?=
 =?utf-8?B?a2JucmFOREhVdXo0TXBYWHNrRGlmWElleFg2VnlSdUtXNThDNDJ6WWxYVThj?=
 =?utf-8?B?ajlkcTMyWEptT1hKdmFXM1lnODE4U1cxSnErNkhDQWxQTWNSRnUzOS82bzdK?=
 =?utf-8?B?aEhZZ2orY1hPQTNkNWpCUDdHZm8xUExhaGNTdkIva2R3OHVxN0RDbVlKejVL?=
 =?utf-8?B?TWc0VGpHSzdiY0dhdCtXOURpMkNqTGhQTzhJcGVsZHloZ0l4YWtTS2J2WUZI?=
 =?utf-8?B?UUVpbnlMWkNZUWtWakM2cTZUYy95eWtiREFoNHVybHdNMVI3K01lS2cvMVZB?=
 =?utf-8?B?OHBBOHl2QkJPUFVxeGhyTHFaZklldE0vWDJkaGJGV3NjaDROeDVTRmErUVg5?=
 =?utf-8?B?R29HbStrbUEvZzMxeGdmRGtCUEtyMnRCSkJkTkttWWQ4bElnMDd4czdCcnZ4?=
 =?utf-8?B?N2Y5Z09iTklkbEVlN3RWYW42RVcvMk5iRnh5cS9KSTdGTUpqSDB5K2xveVlO?=
 =?utf-8?B?N1lPTEtreWpVVlRuVFJCclV2OGtXZGdzRWZJc0p4OGdNWW56TDRObUh4WmZ6?=
 =?utf-8?B?L3o0ZkpTZXNnT3ovRzFBK1FrTERBWExNOUV4UFg1dFcvcWJwR0lVenhLYzZC?=
 =?utf-8?B?YTNMaXdZMWFmVEJnbkZqREtTU2I4eHJUZ1dOaENHNUpOUlh1SUxzQ1M0aU1R?=
 =?utf-8?B?dk9oblZvQVJuYVNVWnJCMllXcm9BQ3dPcm9DV1hoYTQwQlJpbUdCZ3NldUpH?=
 =?utf-8?B?Y2dKRVRqL3ZTd05jVFpUU01mL1lRT295STNPMWZxQklTaXF2WkQrV0J1RE5X?=
 =?utf-8?B?bXd0NGpWdldobnRLRUp5M3diSk5mZmNNWENFQUY3d25pWktKK054QXJlbXdh?=
 =?utf-8?B?Um1rWjZzZTJKSnNHbFp4VE00d0UyQlJ1RExyOGJGMFVHejM1RzBlTG1CblJB?=
 =?utf-8?B?Y1oveG0rWGp1YzZyM3lMS1ViMGZwNFM1YkpvRytBZjU4MmV1NitDV0xPTm14?=
 =?utf-8?B?NnRja3o3a29LV0wxVWJHcGZxWnFZcDhIMWh6VHNYSVlIb3lmdm8wcmhFOEhK?=
 =?utf-8?Q?2Zzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f7fb0-afac-4ff9-a903-08da5c2933dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2022 12:48:45.9445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFY/gRR5GcYJIVTThcrN5E6lqYwpWUmp3RDB9y+Qz1RiF91BBKTikj3kWyNug1x7wbyYLY46VFyvouv4rutzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDcvOV0gaW50ZXJjb25uZWN0OiBpbXg6IHNldCBvZl9u
b2RlIGZvciBpbnRlcmNvbm5lY3QNCj4gcHJvdmlkZXINCj4gDQo+IEFtIERvbm5lcnN0YWcsIGRl
bSAxNi4wNi4yMDIyIHVtIDE1OjMzICswODAwIHNjaHJpZWIgUGVuZyBGYW4gKE9TUyk6DQo+ID4g
RnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBUaGUgcHJvdmlkZXIg
ZGV2aWNlIGlzIGNyZWF0ZWQgdXNpbmcgcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX2RhdGEgaW4N
Cj4gPiBpbXgtYnVzIGRyaXZlciwgd2hpY2ggbm90IGhhcyBvZl9ub2RlLiBXaXRoIG9mX25vZGUg
c2V0LCBpdCB3aWxsIGJlDQo+ID4gZWFzeSB0byBzdXBwb3J0IFFvUyBzZXR0aW5ncy4NCj4gPg0K
PiBUaGF0J3MgYSBiaXQgZGFuZ2Vyb3VzLCBhcyBzaGFyaW5nIGEgb2Zfbm9kZSBiZXR3ZWVuIHR3
byBkZXZpY2VzIGNhbiBsZWFkDQo+IHRvIHNvbWUgcmVmZXJlbmNlIGNvdW50aW5nIGlzc3VlcyBJ
SVJDLCBidXQgdGhlbiBJIGFsc28gZG9uJ3Qgc2VlIGEgZ29vZCB3YXkNCj4gdG8gZG8gdGhpcyBh
bnkgZGlmZmVyZW50bHkuDQoNCkkganVzdCByZWNhbGxlZCB0aGVyZSBpcyBhIHNpbWlsYXIgdXNh
Z2UgaW4gdXNiIGNvZGUsIEkgbm90IHJlbWVtYmVyIHRoZSBleGFjdA0KZmlsZS4NCg0KSSB0aG91
Z2h0IG5vdCB0byBsZXQgaW14LWJ1cy5jIHRvIHJlZ2lzdGVyIHRoZSBkZXZpY2UsIGJ1dCBJIHdh
bm5hIHRvIGRvIGFsbA0KdGhlc2Ugc3R1ZmYgc3RlcCBieSBzdGVwLiBUaGUgbmV4dCBzdGVwIGlz
IHRvIHBpY2sgQWJlbCdzDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVs
LzIwMjIwMTA2MTY0MTUwLjM0NzQwNDgtMS0NCmFiZWwudmVzYUBueHAuY29tLw0KDQpBYmVsIHRv
bGQgbWUgaGUgd2FzIHRyeWluZyB0byBkZWNvdXBsZSBpbXgtYnVzIHdpdGggaWNjLg0KDQpUaGFu
a3MsDQpQZW5nLg0KDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2ludGVyY29ubmVjdC9pbXgvaW14LmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14
L2lteC5jDQo+ID4gYi9kcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14LmMgaW5kZXggMWYxNmVl
ZGVhMjFjLi43ODU1N2ZlNmRhMmMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2ludGVy
Y29ubmVjdC9pbXgvaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14
LmMNCj4gPiBAQCAtMjY0LDYgKzI2NCw3IEBAIGludCBpbXhfaWNjX3JlZ2lzdGVyKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gIAlwcm92aWRlci0+eGxhdGUgPSBvZl9pY2NfeGxh
dGVfb25lY2VsbDsNCj4gPiAgCXByb3ZpZGVyLT5kYXRhID0gZGF0YTsNCj4gPiAgCXByb3ZpZGVy
LT5kZXYgPSBkZXYtPnBhcmVudDsNCj4gPiArCXByb3ZpZGVyLT5kZXYtPm9mX25vZGUgPSBkZXYt
PnBhcmVudC0+b2Zfbm9kZTsNCj4gPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGlteF9w
cm92aWRlcik7DQo+ID4NCj4gPiAgCXJldCA9IGljY19wcm92aWRlcl9hZGQocHJvdmlkZXIpOw0K
PiANCg0K
