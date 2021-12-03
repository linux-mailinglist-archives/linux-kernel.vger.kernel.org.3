Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA5A467172
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358483AbhLCFXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:23:38 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:16662
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350529AbhLCFXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:23:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7iZ3cDdYIgVKUBMQHsBWfwv6xe0A4gVfRKR4W0TX0EMPzFwsAHIEF0avaLTHVn5nFKLX84/Jj6EaL1jolc2exhLoWL78YNK+dWizdv70lP7GvMTXJYzmyEx1MHPXDMaYeK384iHKkqzO5qSJ4UpRjtonpIYrjUdJ6LOrlkRcJwLMqaGbtm6KKKpDG3fgLtwrHjAV0i92ygI/C4j0BFXqBVueajKt1DS8HVR63le8+LpPU1bIgRWT9yA536zH6P5ERGGZ8uSFyatzVFI1S31IIqVdTOfgmQtlvURDDeLQQQPxKpjbY/1HyXxlZwHLr9V6NEOZrRPfMRhLzY+vtLBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN8JFlpH7Z1mf5RSRGjVTYgf4mkcxPAimjQomGuVofo=;
 b=oMcPi5Hq+8DhLhp++nkVqyweUzPZorGI0gkNtsN3/2m0TUpfY43NNZUDLOpmUTrcJbLIaVN9P6KK3SeMZ7lYbBwB96MucJWetBVOz6Lq3M4vP7XUBumfvmg/rgop3IDxddMNFrLxSgpUwMgrCBrNZyk1DNxcxufadFSCpd8w2SQdtWeaZSQBYBiXZzJlCPVOHx5EJFNqTnwNKES0fuyNSBTWVfWbJ2NYFCzKJavasiSZ8drbcMkISMjaPQxDedGF/8eRltCsAI5y+ryWQj52YC4e+GrrvOx6qpJ/C3Am8SEuxPKlryEc75367Zf5mmBddL81k0jgGonnQnR4jrv/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN8JFlpH7Z1mf5RSRGjVTYgf4mkcxPAimjQomGuVofo=;
 b=QGPYOui2lt1L+yOqEm71OSSctLqVjzoGDsl9KiyS4RY5A1jhef2GsEn6clQeUGxsk9ovTgVCNCmoi7YiJbQda9tsJJL5xg+NIfVG9mLtQ0ErLf/t2M+S/uhEG3o19Y6QR45hxq3613T+XmNYOuGvgSU35QvWqLv0QjzIrROphfA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3480.eurprd04.prod.outlook.com (2603:10a6:209:e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 05:20:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 05:20:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v12 00/13] amphion video decoder/encoder driver
Thread-Topic: [EXT] Re: [PATCH v12 00/13] amphion video decoder/encoder driver
Thread-Index: AQHX1UX9FZgXdhHdu0aj4y6UzYn6WqwRlHeAgADanLCAAG2egIAA8C0ggACs9YCAAPadQIAK3EqAgAATR0A=
Date:   Fri, 3 Dec 2021 05:20:07 +0000
Message-ID: <AM6PR04MB6341500264AD986B2016FB45E76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1636445575.git.ming.qian@nxp.com>
         <9947131322e034bb6336802e5afb4b6132ca5071.camel@ndufresne.ca>
         <AM6PR04MB6341BF1FB2A839961DBADF4EE7619@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <9b7fd6802c89c5d3bb6a42b44f13a90f6c3caf22.camel@ndufresne.ca>
         <AM6PR04MB6341F599A97253C1BA812467E7629@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <0deb3fa15dd162d7c7b6dbe24821fdf9523dddd3.camel@ndufresne.ca>
         <DB8PR04MB6346B64E4129D81BA0CF0A1CE7639@DB8PR04MB6346.eurprd04.prod.outlook.com>
 <a77c2fca8bd1e95e1948d3fa98fe106c228221c7.camel@ndufresne.ca>
In-Reply-To: <a77c2fca8bd1e95e1948d3fa98fe106c228221c7.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 404b17c9-18bd-467b-3193-08d9b61c9252
x-ms-traffictypediagnostic: AM6PR0402MB3480:
x-microsoft-antispam-prvs: <AM6PR0402MB34809A8323C5E419A6CBB69EE76A9@AM6PR0402MB3480.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WdiKixsbO4pxAZ+DbGQ6ZLpsbrQNawlK3C6mdVGxrAxaYfbXA0Z2ld8FPi9l3LmCfF3I0rlHwLqcisi95l1UC3kMXekoA+D5Jh53LqPjthau8kAyKxAADSmQ+ANXdu+QPzYCrXwm30Zr873K6od7AwyTsBAiFJdi0IVkKM5pfTQpPs6n5xvoQnqGPwi2usGwg+Q1kCA+p2lXYBoQuAKWSj1MtoVjUms9R/h9dyiBeuTZZJESnIFnxsORQA2htw7LJEbG954QaUkuht+DjESUuTAcGiBFBXL7eVZSwvby/C2+iWjKQavewL6geQ0MsBYYUov9CsQSu6WrpbGsiZbHkV/BxldFZlR85yJtGPjBZa/6PW+fsHw3YwEc7xKVV6IRbuVqMIzVRHPUmySanin8u7ePrBy4melwHa0deExxVHN6NJSJ7ct9tTuxwxFasU2kAbVAZbpzJ+MZa7sYEkwHVom0fqk2QODatROz19hh2/UgOtqpuECMqBGd3/AQ9J3t3U/k7JxIhMWI0t7zlg5mfK13IO7ofMGH+ohwOvznWnobwdZF2U0/gAqddD4KQ5ABO3JBguZSNjPAzDdX1EmW1efDlKB/srCvOu+47hfzEUy3gMbrawNaQ03raO77aZKBNfVi7LcH1ongP2Qi484GYV764N+s1EXghNShIz5GlcuRYh+oUDXD4ZMZqOt7AWyS9wFWNQXa9RWRjIFBvHSEcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(7416002)(6506007)(26005)(53546011)(86362001)(508600001)(8936002)(38070700005)(2906002)(19627235002)(71200400001)(52536014)(76116006)(8676002)(66574015)(66556008)(7696005)(316002)(64756008)(66446008)(66946007)(33656002)(9686003)(44832011)(5660300002)(4326008)(110136005)(83380400001)(38100700002)(55016003)(186003)(122000001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZzWGY3TVN3ZXdKQjk4c2dIaVhib0luOEdsRkowWGtWYmpPVUZwYXI5cDRP?=
 =?utf-8?B?dkU3NS92NHJiRmRpN2JENGdjZmZWMldJdFJ2bkdKWDM0MWNMVVNtRXRkQVQy?=
 =?utf-8?B?RjgwVTVYNkMrWHJYQ1IzUlhScHpOdlIwc2lyc1BMK2RNQS9WRzFwRk1yWXRj?=
 =?utf-8?B?RmcxMk95U2pIT2Y1TmFHdmVQY3M1Rkxza1g2MlhrWklaSWYyWkRXaUxpR0dn?=
 =?utf-8?B?VnZSb1NrVGJkenZRMU5UajEwMFkxZ3hWOEVOejl3Ync5RHF2TVpEbW4rQjUv?=
 =?utf-8?B?cW1nNEpIR3lzL0VGM1RLektoV2xoRlFLRW0vTUZsTWY1MlprZzRLcjVIWkt6?=
 =?utf-8?B?d1RlcXlsNVc2Y2QxY2kzQnlTdWU0dzNOVkk0T2M1K1lIOVh6UjQ0YmFOY1FQ?=
 =?utf-8?B?NHZTN1g5SjR4MXV2SThDbTVSdjF3Uy9yM0hzaUVCcTYwcVFXMTFoZEtFbXdy?=
 =?utf-8?B?anFJamVKdWhEV2xGQU5uUU5acjBzT0V6RE9Cb3ZNN2N5N2V1L3c0QStFNlht?=
 =?utf-8?B?SWJwMkdzeHhXUzFHcC8wV09uUEJFN1RacnhnRlF0YUVZM2JzUUpnVml2WFc5?=
 =?utf-8?B?Unkrc0dIb1VlcFc0S3hXYnBtVE9vSmIydWo4VGp5Tmp1TzRNOEhvQk9tNW44?=
 =?utf-8?B?d1JzbmtuZU1OS1JEb2FoeWF3Vy9kY3ZjNnN4blZtblhqWmxiSzBJWWJLOFRv?=
 =?utf-8?B?U1ByM0YwNWpzbGZKdVNFUjVyTWtnZDA0ZmlKWmRMU2N0UjNFVzFtOFBpUDRH?=
 =?utf-8?B?TVE3Yk9mQXRxL0ZDSnA3TUJ4YjhoQ2hBTXRrVGJTRk5xalFVVGdCb0VXR0d4?=
 =?utf-8?B?WGQ0K1VmMm9RdXBva1M3Q1djMis1TjlNbkdid1IzNk0vWkE4MmtRcG53UWRy?=
 =?utf-8?B?MEN1d2ZOcGdNSHB4Qk5HdlBZak5rQWxycGt5K2RRMUl4eGRSVFhUbXJBb2h6?=
 =?utf-8?B?QjdXb3NIUmNzT3pJd28wV214Qkd5YVpBS0RURDhHTHA1bVVKWTNZOE1MUlph?=
 =?utf-8?B?bTlKcGI5MWZmTGRZQnM1RmEydUJvU3NGenlkNXYybmlKMmtTWlN0cGVvQ1ZT?=
 =?utf-8?B?RHc4aEZWWWRveisybW05L2dJa2NrUDk1ODQwL1JXNnpDc1ZNekJBODJWRjZ3?=
 =?utf-8?B?RnFFVG52SGtxdXBkeEdOV25LendVaUQ5clRRaTdqZDhzMmY5eitldmNuaDlw?=
 =?utf-8?B?NWhTSVdQc25TWjdQRGRNWkFXcU93eVduT1F1c2RrWFhaTEx2MmltZVhvTEFl?=
 =?utf-8?B?YnNmZStRNllPOEpqWmRML1cxTXVWM3QzTERyczNBWDRXOFlxbzZ1NWlNclQx?=
 =?utf-8?B?SnhkcWk0bnFQVUxuQ1FiMlZiNWlSNnE4WXlCemNDTDdsbDJudnVPekhON0RJ?=
 =?utf-8?B?V2tDMlBSMUNsNC9XNXhsRXBvV2hQNWl4RThyZ3Z4SlJmL0FpdWNyUHlIazI1?=
 =?utf-8?B?NEVzMWhPa2NHKzhOYlgvZkJUUmpQT1dKdjZzdkRHS3N4NThNR1oxVS9jR2t0?=
 =?utf-8?B?eVJSK01HQkNjemQ0N2FPRWFFRGtnN2N2UzFtT3B4b1JYRzlPbmlzY3QzbEhY?=
 =?utf-8?B?Vno5dXc2OHpaY3EwU2hwMU44MzBUeWFRS3R0TS9DYmM3MHJBZDdIeVRWa2ZP?=
 =?utf-8?B?YzNETW9iNnRGVGpHREV5UVNIRndlSzRBR0twZ2phY2dtSW5zT3hMWTNYWlRZ?=
 =?utf-8?B?NG1Cc0k1czllU28rK3Y0Y1ZPc1NUOW1GZVRKTXNoNDV6Qm5ZZjg1TzdkOGx3?=
 =?utf-8?B?Ni9DS0J4SUhXMmcwUFJHc2xuTjFpNHRQSTFGdGQ0b1NkdWtJL2h1aFFCWVRV?=
 =?utf-8?B?T3c0QTkyanp5ZWJ0a0F6M0RlVUYrUTdPUi9LZlVESFZNVlAxakdFeXE1NGJs?=
 =?utf-8?B?RjltNWIwM2dDRk1Wc0JVVlUzS29OY0c5UkpOakJKWnhJa0VQS01Sc2hod0w1?=
 =?utf-8?B?OWZsQSt0RC9KL2k4SUNVS0NBVDRFT2FmWmJYenhPZ3VPelpBL3M5cW9WYTRx?=
 =?utf-8?B?dHNjZVVFOHhVZmlJbkVKbm5YbmhWVUVmVHdrUU9wbmxUREdEQzlOWTU5Ujda?=
 =?utf-8?B?S1Zpcm05NGJLU0hDdGUyeXFzTG1PbmpmdU1NMXRubzl5R0p5bWhqUURUUGU2?=
 =?utf-8?B?U2tkR1pVM2tmNHA4WHJVa1JWdkhGbytEVnRFNWhueHNHYmI0eGd0TXJjQURJ?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404b17c9-18bd-467b-3193-08d9b61c9252
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 05:20:07.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0SwoJehnR2YrR7BYR1dSFBdsxfQMprOWYgP677z9rArLFpHvq49nSej0dcmKr9hZbmDNGyJkLHzE8MgAmmlgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3480
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIFtt
YWlsdG86bmljb2xhc0BuZHVmcmVzbmUuY2FdDQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMywg
MjAyMSAxMjoxMCBQTQ0KPiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVo
YWJAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlDQo+IENjOiBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT47DQo+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MTIg
MDAvMTNdIGFtcGhpb24gdmlkZW8gZGVjb2Rlci9lbmNvZGVyDQo+IGRyaXZlcg0KPiANCj4gQ2F1
dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBMZSB2ZW5kcmVkaSAyNiBub3ZlbWJyZSAyMDIxIMOgIDA2
OjMxICswMDAwLCBNaW5nIFFpYW4gYSDDqWNyaXQgOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+IEZyb206IE5pY29sYXMgRHVmcmVzbmUgW21haWx0bzpuaWNvbGFzQG5k
dWZyZXNuZS5jYV0NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyNSwgMjAyMSAxMToz
NiBQTQ0KPiA+ID4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hlaGFiQGtl
cm5lbC5vcmc7DQo+ID4gPiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7
IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gPiA+IENjOiBodmVya3VpbC1jaXNjb0B4czRhbGwu
bmw7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcgRG9uZw0KPiA+ID4gPGFpc2hl
bmcuZG9uZ0BueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiA+IFN1YmplY3Q6
IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxMiAwMC8xM10gYW1waGlvbiB2aWRlbw0KPiA+ID4gZGVj
b2Rlci9lbmNvZGVyIGRyaXZlcg0KPiA+ID4NCj4gPiA+IENhdXRpb246IEVYVCBFbWFpbA0KPiA+
ID4NCj4gPiA+IExlIGpldWRpIDI1IG5vdmVtYnJlIDIwMjEgw6AgMDU6MjUgKzAwMDAsIE1pbmcg
UWlhbiBhIMOpY3JpdCA6DQo+ID4gPiA+IEZvciB0ZXN0IFtKQ1QtVkMtSEVWQ19WMV0gKEdTdHJl
YW1lci1ILjI2NS1WNEwyLUdzdDEuMCkNCj4gPiA+ID4gVlBTU1BTUFBTX0FfTWFpbkNvbmNlcHRf
MSwgVGhlIHZwdSByZXBvcnQgYW4gdW5zdXBwb3J0ZWQgbWVzc2FnZQ0KPiA+ID4gPiB0bw0KPiA+
ID4gZHJpdmVyLCBzbyBkcml2ZXIgcmVwb3J0IHBvbGxlcnIgdG8gZ3N0cmVhbWVyLg0KPiA+ID4g
PiBCdXQgdGhpcyBzdHJlYW0gY2FuIGJlIGRlY29kZWQgdXNpbmcgdGhlIGFtcGhpb24gdnB1IHdo
ZW4gSSB0ZXN0DQo+ID4gPiA+IGl0IHVzaW5nIG91ciB1bml0IHRlc3QsIEkgY2hlY2tlZCB0aGUg
ZGlmZmVyZW5jZSwgdGhlcmUgYXJlIG1hbnkNCj4gPiA+ID4gdnBzLCBzcHMgYW5kIHBwcyBhdCB0
aGUgYmVnaW5uaW5nLCBnc3RyZWFtZXIgd2lsbCBza2lwIHRoZSBmaXJzdA0KPiA+ID4gPiB2cHUg
YW5kIHR3byBwcHMsIHRvdGFsbHkgc2tpcCA1NiBieXRlcy4gSXQgbGVkcyB0byB2cHUgY2FuJ3QN
Cj4gPiA+ID4gZGVjb2RlIEFuZCBvdXIgdW5pdCB0ZXN0IHdvbid0DQo+ID4gPiBza2lwIGFudGhp
bmcsIHNvIHRoZSB2cHUgY2FuIGRlY29kZSB0aGUgc3RyZWFtLg0KPiA+ID4NCj4gPiA+IFRoaXMg
c3BlY2lmaWMgdGVzdCB0cmlnZ2VycyBhIGJ1ZyBpbiBHU3RyZWFtZXIgSEVWQyBwYXJzZXIsIEkn
bQ0KPiA+ID4gYXdhcmUgb2YgdGhpcyBvbmUsIGFuZCBpdCBpcyBvbiBteSB0b2RvIHRvIGZpeCAo
anVzdCBub3QgYXMgdHJpdmlhbA0KPiA+ID4gYXMgaXQgbG9va3MgbGlrZSwgdGhlIFZDTCBuYWwg
ZGV0ZWN0aW9uIGNvZGUgd2FzIGltcGxlbWVudGVkIHdyb25nDQo+ID4gPiBhbmQgdGhhdCBlbmRl
ZCB1cCBsZWFraW5nIGludG8gdGhlIHJlc3Qgb2YgdGhlIGRlc2lnbikuIFRoaXMNCj4gPiA+IHNw
ZWNpZmljIHRlc3Qgd2lsbCBvZiBjb3Vyc2UgYmUgbWFya2VkIGFuZCBza2lwcGVkIGZvciBDSSB0
ZXN0IHRoYXQNCj4gPiA+IHVzZXMgR1N0cmVhbWVyLg0KPiA+ID4NCj4gPiA+IHJlZ2FyZHMsDQo+
ID4gPiBOaWNvbGFzDQo+ID4NCj4gPiBIaSBOaWNvbGFzLA0KPiA+DQo+ID4gICAgIEZvciB0aGUg
aDI2NCBkZWNvZGVyIHRlc3QsIElmIEkgdGVzdCB3aXRoIG91ciB1bml0IHRlc3QgdG9vbCwgdGhl
DQo+ID4gcmVzdWx0IGlzIDEyNC8xMzUgdGVzdHMgc3VjY2Vzc2Z1bGx5LCBCdXQgb25seSA3NS8x
MzUgdGVzdHMNCj4gPiBzdWNjZXNzZnVsbHkgd2hlbiB0ZXN0IHVzaW5nIGdzdHJlYW1lci4NCj4g
PiAgICAgVGhlcmUgYXJlIDQ5IHRlc3RzIHdpdGggZGlmZmVyZW50IHJlc3VsdHMsIGFuZCBhbGwg
b2YgdGhlIDQ5IHRlc3QNCj4gPiBzdHJlYW1zIGFyZSBpbnRlcmxhY2VkIHN0cmVhbS4NCj4gPiBU
aGUgYW1waGlvbiB2cHUgd2lsbCBvdXRwdXQgdGhlIGludGVybGFjZWQgZnJhbWUgZGlyZWN0bHks
IGl0IHdvbid0DQo+ID4gbWVyZ2UgdGhlIGludGVybGFjZWQgdHdvIHBhcnRzIGludG8gb25lIHBy
b2dyZXNzaXZlIGZyYW1lLg0KPiA+ICAgICAgQW5kIHRoZSBnc3RyZWFtZXIgdGlsZWQgdW5wYWNr
IGZ1bmN0aW9uKHVucGFja19OVjEyX1RJTEVEKSB3b24ndA0KPiA+IGhhbmRsZSB0aGUgaW50ZXJs
YWNlZCBjYXNlLCBzbyB0aGUgb3V0cHV0IGZyYW1lIGlzIGFibm9ybWFsLCBhbmQgbGVkIHRvIHRl
c3QNCj4gZmFpbC4NCj4gPiAgICAgIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGEgaGFyZHdhcmUgbGlt
aXRhdGlvbiBvZiB0aGUgYW1waGlvbiB2cHUuDQo+ID4gQW5kIG1heWJlDQo+IA0KPiBJZiB0aGlz
IGlzIHRoZSBjYXNlLCBpdCBuZWVkcyB0byBiZSBzaWduYWxlZCBhcyBBTFRFUk5BVEUgKGlmIHlv
dSBoYXZlIDEgdjRsMg0KPiBidWZmZXIgcGVyIGZpZWxkKSBvciBTRVEgaWYgdGhleSBhcmUgc3Rv
cmVkIGluIHRoZSBzYW1lIHY0bDJfYnVmZmVyIGJ1dCBvbiB0b3Agb2YNCj4gZWFjaCBvdGhlciBp
bnN0ZWFkIG9mIGludGVybGVhdmVkLg0KPiANCj4gU29tZSBiaXQgYWJvdXQgdGhpcyBtaWdodCBu
b3Qgd2UgYWxsIHdpcmVkIHByb3Blcmx5LCBJIGhhdmUgb25seSB0ZXN0ZWQNCj4gYWx0ZXJuYXRl
IGZpZWxkIGZvciBjYXB0dXJlIGRldmljZXMgKFhpbGlueCBaaW5xTVApLiBQbGVhc2UgY2hlY2sg
dGhlIHNpZ25hbGxpbmcNCj4gb2YgaW50ZXJsYWNlIGZpZWxkIGluIHlvdXIgZHJpdmVyLCBJJ2xs
IGNoZWNrIHRoZSBzdGF0ZSBvZiBHU3RyZWFtZXIgaW4gdGhpcyByZWdhcmQuDQoNCg0KVGhlIHR3
byBmaWVsZHMgYXJlIHN0b3JlZCBpbiB0aGUgc2FtZSB2NGwyX2J1ZmZlciwgSSdsbCBjaGFuZ2Ug
dGhlIGZpbGVkIHRvIFY0TDJfRklFTERfU0VRX1RCIGFuZCB0ZXN0IGl0IGFnYWluLg0KDQo+IA0K
PiA+IHRoZSBnc3RyZWFtZXIgdmlkZW9jb252ZXJ0IGNhbiBoYW5kbGUgaXQuDQo+ID4gVGhlIGlu
dGVybGFjZWQgbGlzdCBpcyBhcyBiZWxvdzoNCj4gPiBbSlZULUFWQ19WMV0gY2FiYWNfbW90X2Zs
ZDBfZnVsbA0KPiA+IFtKVlQtQVZDX1YxXSBjYWJhY19tb3RfbWJhZmYwX2Z1bGwNCj4gPiBbSlZU
LUFWQ19WMV0gY2FiYWNfbW90X3BpY2FmZjBfZnVsbA0KPiA+IFtKVlQtQVZDX1YxXSBDQUJSRUYz
X1NhbmRfRA0KPiA+IFtKVlQtQVZDX1YxXSBDQUZJMV9TVkFfQw0KPiA+IFtKVlQtQVZDX1YxXSBD
QU1BMV9Tb255X0MNCj4gPiBbSlZULUFWQ19WMV0gQ0FNQTFfVE9TSElCQV9CDQo+ID4gW0pWVC1B
VkNfVjFdIENBTUEzX1NhbmRfRQ0KPiA+IFtKVlQtQVZDX1YxXSBDQU1BQ0kzX1NvbnlfQw0KPiA+
IFtKVlQtQVZDX1YxXSBDQU1BTkwxX1RPU0hJQkFfQg0KPiA+IFtKVlQtQVZDX1YxXSBDQU1BTkwy
X1RPU0hJQkFfQg0KPiA+IFtKVlQtQVZDX1YxXSBDQU1BTkwzX1NhbmRfRQ0KPiA+IFtKVlQtQVZD
X1YxXSBDQU1BU0wzX1NvbnlfQg0KPiA+IFtKVlQtQVZDX1YxXSBDQU1QX01PVF9NQkFGRl9MMzAN
Cj4gPiBbSlZULUFWQ19WMV0gQ0FNUF9NT1RfTUJBRkZfTDMxDQo+ID4gW0pWVC1BVkNfVjFdIENB
TkxNQTJfU29ueV9DDQo+ID4gW0pWVC1BVkNfVjFdIENBTkxNQTNfU29ueV9DDQo+ID4gW0pWVC1B
VkNfVjFdIENBUEExX1RPU0hJQkFfQg0KPiA+IFtKVlQtQVZDX1YxXSBDQVBBTUEzX1NhbmRfRg0K
PiA+IFtKVlQtQVZDX1YxXSBjYXZsY19tb3RfZmxkMF9mdWxsX0INCj4gPiBbSlZULUFWQ19WMV0g
Y2F2bGNfbW90X21iYWZmMF9mdWxsX0INCj4gPiBbSlZULUFWQ19WMV0gY2F2bGNfbW90X3BpY2Fm
ZjBfZnVsbF9CDQo+ID4gW0pWVC1BVkNfVjFdIENWQ0FOTE1BMl9Tb255X0MNCj4gPiBbSlZULUFW
Q19WMV0gQ1ZGSTFfU29ueV9EDQo+ID4gW0pWVC1BVkNfVjFdIENWRkkxX1NWQV9DDQo+ID4gW0pW
VC1BVkNfVjFdIENWRkkyX1NvbnlfSA0KPiA+IFtKVlQtQVZDX1YxXSBDVkZJMl9TVkFfQw0KPiA+
IFtKVlQtQVZDX1YxXSBDVk1BMV9Tb255X0QNCj4gPiBbSlZULUFWQ19WMV0gQ1ZNQTFfVE9TSElC
QV9CDQo+ID4gW0pWVC1BVkNfVjFdIENWTUFOTDFfVE9TSElCQV9CDQo+ID4gW0pWVC1BVkNfVjFd
IENWTUFOTDJfVE9TSElCQV9CDQo+ID4gW0pWVC1BVkNfVjFdIENWTUFQQVFQM19Tb255X0UNCj4g
PiBbSlZULUFWQ19WMV0gQ1ZNQVFQMl9Tb255X0cNCj4gPiBbSlZULUFWQ19WMV0gQ1ZNQVFQM19T
b255X0QNCj4gPiBbSlZULUFWQ19WMV0gQ1ZNUF9NT1RfRkxEX0wzMF9CDQo+ID4gW0pWVC1BVkNf
VjFdIENWTVBfTU9UX0ZSTV9MMzFfQg0KPiA+IFtKVlQtQVZDX1YxXSBDVk5MRkkxX1NvbnlfQw0K
PiA+IFtKVlQtQVZDX1YxXSBDVk5MRkkyX1NvbnlfSA0KPiA+IFtKVlQtQVZDX1YxXSBDVlBBMV9U
T1NISUJBX0INCj4gPiBbSlZULUFWQ19WMV0gRkkxX1NvbnlfRQ0KPiA+IFtKVlQtQVZDX1YxXSBN
UjZfQlRfQg0KPiA+IFtKVlQtQVZDX1YxXSBNUjdfQlRfQg0KPiA+IFtKVlQtQVZDX1YxXSBNUjhf
QlRfQg0KPiA+IFtKVlQtQVZDX1YxXSBNUjlfQlRfQg0KPiA+IFtKVlQtQVZDX1YxXSBTaGFycF9N
UF9GaWVsZF8xX0INCj4gPiBbSlZULUFWQ19WMV0gU2hhcnBfTVBfRmllbGRfMl9CDQo+ID4gW0pW
VC1BVkNfVjFdIFNoYXJwX01QX0ZpZWxkXzNfQg0KPiA+IFtKVlQtQVZDX1YxXSBTaGFycF9NUF9Q
QUZGXzFyMg0KPiA+IFtKVlQtQVZDX1YxXSBTaGFycF9NUF9QQUZGXzJyDQo+ID4NCg0K
