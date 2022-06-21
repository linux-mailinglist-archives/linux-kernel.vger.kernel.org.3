Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E843D553972
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiFUSQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFUSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:16:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60052.outbound.protection.outlook.com [40.107.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B127FC1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiqYH1eg7iqbA4f8owBk6WgMpsH+/R4BzUtmjki2gitrEMj7XfA8n9TIR5FFoCbrIFwPR5CZGWwG/5jPNweC2hb+tE9AH6NYkIcQ7A/kMK2emAmgy9zZwryCRwZagcaZQR1Upwnqq63hqsZeDSRWCKb5bZRbwIrAUWJvVD8/yRa+iUVeMY9K8dslZ7ZCcJdzje6dX+TjPvfoxB7g1X1209qdn0DNhUEKW9T1z5Uo2aX4gNvZzwX3bFzSAIumCXdN7IAdC9415Ju/tDwohhhMnLeMwfKBIDMLyAMCOSvqMumfcFELTh+rL5iBdhpzbxlKtfxP9hZg/8LVMCjk/jaKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFM+VO+CV5IxsSvpsl0ckeXb1xsoETdfC8GVx2GPWWI=;
 b=TbXoK4rAdLmpygNLPif/LDjN1rTDPc1TC740iUdbdoiwkM42MTf7BoNvhTUpAwLejhGds+sZrbt+miZ7+rrLolYVfsQiyDpuS/paPCHFzAFRSQT53RIxNRyW6gS5QaCAhYL3x6zPCM2nlpJ1XW0rKtNZt447lelH5zA1hKaEsUF3Hg1sxqrHrW8XQJq10JDhZUEwnGrJ1LjCt1FwSWmKsXYuxPftWLQVr66hbxi+ImQ7fh33uYP+DOhEQ0oLbLnHJXbtuii7zruECboVO0TG3ZKzvN0zURRtoYhNY9BeVAxI65C/rg5z5z0KcPKbVFio0neATBECs6ZeY/8gcEzumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFM+VO+CV5IxsSvpsl0ckeXb1xsoETdfC8GVx2GPWWI=;
 b=m6AzvY1VTQTh6F+nn5mU64NcYiErCqFCdaNk7S6kgtU5UAE1PCWOv97T6gL7Z6HGq5HI9haVMShHaGWmQR/lZU9zD3414iwYam3qnTDq1YQk+91eZ/bAiFYBqRLpn3lIXoVNpIn8qe5CGqE/aoa+2xDF3n5ylPk+jO7bEt2kVgc=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 18:16:50 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 18:16:50 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Topic: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Index: AQHYhKwihmmQwo9gZ0uCTra8XCwz/61YZSEAgAAK2aCAAAFvAIAABRJAgAAc5ICAAVTlsIAAFmQAgAAqm0A=
Date:   Tue, 21 Jun 2022 18:16:50 +0000
Message-ID: <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
 <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk>
 <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk>
In-Reply-To: <YrHkXH1M4NydBfQT@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea45e12-3c79-4347-3d0b-08da53b23668
x-ms-traffictypediagnostic: AM6PR04MB4293:EE_
x-microsoft-antispam-prvs: <AM6PR04MB42935EBEF3723F0B0C4A9AD880B39@AM6PR04MB4293.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9tQRt7ganjP2JFoRe+IyDvUMD6GPa2Aw8XYzC6YzUSRaiCL51YXCtdfUp+Z6nEStsbqtBl7rVsx9quSSPlFFmtQ2cqiCDyy1uKp5fDxBy6tb5oAVzvarKnGN9kpRTABBiF3V2FAB2SarAUGdUD4VUbPCBPWCygC6SoLP2Rh6xKgT+VAXk7O3XR6WKMWYxNKNbLoaUa3yv1iebf3hJsElgD1UprvU03qGoYBXnSeFXVYTjNOL/PbLdY8Y0/JuU4c34R1xb3sEPiwZPizaLN83yx6fij3KXaxN6D7vXGsbSFbGxg+a0H7V02DfcE76Ng1+y1G05I93Fk1oM7OiWgvdI5cUaCigYs0l/oWUNuHuKnfAAwH3c+W+bcQEyw+0r5vAPn+ufX0N5WW4l3Va4khKHPPy57TQRsU7NptOU6KufxswdUq9sdlvuM3Uls9Nt/yA/EZrAos5Z3iHjinq6rd22qcxT+PUxY3ldxjeGGzWi1GiEGizKt6uupcg+QWiMAGpoMpTH1EbKSQRbsBdfMNhcD6xANYSdI/20oVu2JdPzdFMN1E9Tcx9V7judx+gRQd6WN15nmmV39cEyCVaW/WyT2EbOl/dAJcZfViYf8BdMgi0eUY3UB/wtTMell4v+2CT9C42ckQK6zSC7V7CLKle7TsjmduBWgMB3ETXS2PnoSBbCKkO7mAoDJk2sKhgy6JpMxAyso7Z2JX74bpkR/xtmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(7696005)(6506007)(41300700001)(38100700002)(44832011)(26005)(9686003)(5660300002)(2906002)(55016003)(52536014)(8936002)(33656002)(6916009)(4326008)(8676002)(71200400001)(478600001)(86362001)(66476007)(54906003)(186003)(83380400001)(76116006)(66446008)(66556008)(66946007)(64756008)(122000001)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0RORTY4V3pQY1BlcUhoNGxoMkFVdWhWRVFLK3FUYUVIaWRuemxkbm0zdTZn?=
 =?utf-8?B?Nk9lYmIwTTFCSlB5a2x3N2g3bFl3V2Y5dUFHRjZtRUNxVThORGVUQlljRzVa?=
 =?utf-8?B?cHI4aUNFUlkzanlpekZyQ2JwcEljWGs1Zk1qUG1xbE85RlY1anVBR0ZwTkFW?=
 =?utf-8?B?QmZuTTcvR3ZqajNJYk1EMzlRZXhNUnpzbmhkL2UrTklHZWx3UWhXV0JPN0ww?=
 =?utf-8?B?TlBtOWlCL1cvV3drV2tqdE1QS040eVlmUnJqaC9HdlRXMDgxZkJlTDNwYVp1?=
 =?utf-8?B?VEU5QWNiY1dQemg1eTVaeUFRV2xLek54NHNkZHo0Zy9XRFJQT251SlFCcTVX?=
 =?utf-8?B?eFZZeTU5NEtZWWwwWVJSQXYrMWZMUHhrMG01N21xVkxoaHhvWDllQ0JDekNm?=
 =?utf-8?B?a0FjTTdXbHVGNkpNWHJVTHhMQUpBMTJOUytTSFlpL1U3U2pVU0xhN2dVd3NI?=
 =?utf-8?B?ZldRV1VPY0dWdzRJL2JTQVJjc3hYeXY4MGJjdi92M0Y2THVYcVg3RmFJMFQy?=
 =?utf-8?B?L2RTU1lQSEpQNm1NRmo4QlQ5cnU3YXRCYjRmQklNYjIrQ3hYSDVpaWdFUkRQ?=
 =?utf-8?B?TUNYeHVDVkdTQ2NsaHZVZUdOWmE3ajRTZHBzdTF0OUNCQ0oranplQmNwYVE3?=
 =?utf-8?B?amd3QUxpV2F5UTRtNlo5eXRwZjlQVnRrL3V1aGVNOGtlQWhucDZpY3dPSnFp?=
 =?utf-8?B?ZURWQUdhNy90eTR4SENhbjZFRFphT0VHbDNtdHA0dk9UZDdpenRWUmEzVXY4?=
 =?utf-8?B?bjQrdlJJOEd2c2xtVzM2RnM3Y0c3OEJ6Rkk0eXNaWTlnV1ZzazNRNmEvVjEx?=
 =?utf-8?B?OUVQV0ZINUlQZnFQSmRvd0h6YkovTUloY0VhbUtxaXlqR0NTK2Ixclc1QU02?=
 =?utf-8?B?SWlZSWNYWkcwVVMxVGM4Z1hxMEdqL0s4end0Qlc3MHoxRFhiVG14UWxObWxk?=
 =?utf-8?B?V0thd01hTzZEM05ZdW1mRzE1bkxLbG4zZldESUEzODZnQjZHREVjd3JoeDBJ?=
 =?utf-8?B?Ly9LVFNPZ1hBM05XQXNyOUY1MU1jY2lmZnhHSVA2MjN3dGlxSlRZSWJEV1V3?=
 =?utf-8?B?WU01NHJmZW1jb0J3dnhROU12Um1Xa2YwVTZvQnpRTFkzckhFRlNkNFduL0VB?=
 =?utf-8?B?d3dadVRyY2VDN1lxVDJKK2V2MStGRTZVMkNjQVdxRXJJWGJyeWgrbmRvVFhZ?=
 =?utf-8?B?SFNzdmxmODBEc0FzTVVBRkk2RGlUOG1sUlowTWxjV1RvL1lFeUoxeHBvekNn?=
 =?utf-8?B?NllKYldObU54cklOdkJDUXNQb01qRmZWOVlIZmNCUWdheUt5a3ZYdnRjSW53?=
 =?utf-8?B?cmNrcUw3SER0RzdnRFMrUXZlS3orWXU2cHV6K3JGSjJLWnE2ZUpNc043N2JX?=
 =?utf-8?B?SGNCdGQ2alAvVHNLWkxkZk1RTGN3VzRKSGh6YzdmWXBUNjhZYjZPY2hjOGRh?=
 =?utf-8?B?K1ZGMmxsbkUrVDBzcEhUNWErMk9tdFRLREduTGw3M085alZwdW56ZDJ5QjhX?=
 =?utf-8?B?dXU0VEprcFc3aVdQYVk3eFdYL1UwVEtnR2xPRGZLd0RwdFIvUTZ1ZkpTTnVp?=
 =?utf-8?B?Ny8wU3F6R2l5dXhrY2pqVGw5MlhORGRqWFYzeFk2WmQxcC8xNXphbVJkaE9r?=
 =?utf-8?B?Njh4Y0RrT0gwL3NnSDY3TXFaSTV2SnEyL3o5VVc4WGZGQTZva3c5Zm8vcGc5?=
 =?utf-8?B?V285MVZMRlJ4Y0U2K2VUTkFmN29UbDZEUjdJZkcyR05qTkNjMEUyU2dhdjYz?=
 =?utf-8?B?N1NWWUt0amcxNi9WWDVxR3ZVQThDQ3ozdUxESUJGS3dvS0R0UXpQZEtjQ2hP?=
 =?utf-8?B?NmE0VDNzdDhaK2RxbjBEdXR0NUxCME1PSmpPSnJ2SlZUM0NaV1h3Y2tKcmo0?=
 =?utf-8?B?UFlLYUl6WFNQVVllZmIzTTRKN0NreGdiRmE3bDV5c3liZzh0MktJaENOazM2?=
 =?utf-8?B?RmRmSm1YamFGUWNEQkRBQ2RpS0dUaWJUSVpWaEY2cXNXNjJLaUFzVTZqTjgx?=
 =?utf-8?B?ckVaWC9YYXJmU2l4SVlweFhjc2tMREwrNENUOXVXc29va1B1OC9ZbXVEak83?=
 =?utf-8?B?RXVkeXdrU2dUK2V2QVhtbjY4bmNsT29jSFNiSlhCdEx0SW93RVpUK1RtTmc3?=
 =?utf-8?B?MVJGcnRUaDdlTFcxZUNXamdDaWYzMU44Qms4eGQ5YTg4OWh6WHZJVTlXNCtQ?=
 =?utf-8?B?TFU5d1E1SkFJVUtoZUJjSUovVWJva1drUVRxRjlzL05acHlKaVY2NGlJREpH?=
 =?utf-8?B?OUVIbzhqTTl6WExvMjBvL05BVnJXdFc2RUk4NFozOFo4bnBZYk5PcUtNTTJZ?=
 =?utf-8?B?UHk4bVRZbUdiVXlLMWlBRWh0blZvWU1meElpSk9Xcnl1ODZ3aDhIZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea45e12-3c79-4347-3d0b-08da53b23668
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 18:16:50.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPuqn3ADpW5uVPdYKxbBl0+QiCvYyylmkfBSDTdsjgFM5lK7JJkaf++lBa3f1NzvxxZYzx2eFLNZKD9cwS42NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bmUgMjEsIDIwMjIgMTE6MzIgUE0NCj4gDQo+IE9uIFR1ZSwgSnVuIDIxLCAyMDIyIGF0IDAy
OjU2OjU4UE0gKzAwMDAsIEFpc2hlbmcgRG9uZyB3cm90ZToNCj4gDQo+ID4gPiBzbyBpZiB3ZSBj
YW4ndCBzYXRpc2Z5IHRoZSByZWFkIGZyb20gdGhlIGNhY2hlIHRoZW4gd2UnbGwgaGl0IHRoZQ0K
PiA+ID4gY2FjaGVfb25seSBjaGVjayBhbmQgcmV0dXJuIC1FQlVTWSBiZWZvcmUgd2Ugc3RhcnQg
dHJ5aW5nIHRvIGRvIGFueQ0KPiA+ID4gcGh5c2ljYWwgSS9PLiAgVGhlIGRlYnVnZnMgY29kZSB3
aWxsIGhhbmRsZSB0aGF0IGdyYWNlZnVsbHksDQo+ID4gPiBpbmRpY2F0aW5nIHRoYXQgaXQgY291
bGRuJ3QgZ2V0IGEgdmFsdWUgZm9yIHRoZSB2b2xhdGlsZSByZWdpc3RlciBieQ0KPiA+ID4gc2hv
d2luZyBhbGwgWHMgZm9yIHRoZSB2YWx1ZS4gIElmIG5vbmUgb2YgdGhlIHJlZ2lzdGVycyBhcmUg
Y2FjaGVkDQo+ID4gPiB0aGVuIHRoZSBmaWxlIHdvbid0IGJlIHRlcnJpYmx5IHVzZWZ1bCBidXQg
aXQgYXQgbGVhc3Qgc2hvdWxkbid0IGNhdXNlIGFueQ0KPiBlcnJvcnMgd2l0aCBhY2Nlc3Npbmcg
dGhlIGRldmljZSB3aGVuIGl0J3MgcG93ZXJlZCBkb3duLg0KPiANCj4gPiBUaGF0IG1lYW5zIHdl
IGhhdmUgdG8gdXNlIGNhY2hlX29ubHkgbW9kZSB0byB3b3JrYXJvdW5kIHRoZSBpc3N1ZSwgcmln
aHQ/DQo+ID4gSSBzYXcgdGhhdCBjYWNoZV9vbmx5IG1vZGUgaGFzIHRvIGJlIGV4cGxpY2F0ZWQg
ZW5hYmxlL2Rpc2FibGUgYnkNCj4gPiBkcml2ZXIsIGNvbW1vbmx5IHVzZWQgaW4gZGV2aWNlIHJw
bSBpbiBrZXJuZWwgcmlnaHQgbm93Lg0KPiANCj4gWWVzLg0KPiANCj4gPiBIb3dldmVyLCB0aGlu
Z3MgYXJlIGEgbGl0dGxlIGJpdCBjb21wbGljYXRlZCBvbiBpLk1YIHRoYXQgMSkgaW14DQo+ID4g
YmxrY3RsIG5lZWRzIGZvbGxvdyBzdHJpY3QgcmVnaXN0ZXJzIHIvdyBmbG93IGludGVybGVhdmVk
IHdpdGgNCj4gPiBoYW5kc2hha2VzIHdpdGggdXBzdHJlYW0gZ3BjIHBvd2VyIG9wZXJhdGlvbnMg
YW5kIGRlbGF5IG1heSBiZSBuZWVkZWQNCj4gPiBiZXR3ZWVuIHJlZ2lzdGVycyB3cml0aW5nDQo+
ID4gMikgYmxrY3RsIGl0c2VsZiBkb2VzIG5vdCBlbmFibGUgcnVudGltZSBwbSwgaXQgc2ltcGx5
IGNhbGwgcnBtIHRvDQo+ID4gcmVzdW1lIHVwc3RyZWFtIHBvd2VyIGRvbWFpbnMgZGV2aWNlcyBh
bmQgbmVjZXNzYXJ5IGNsb2NrcyBiZWZvcmUgci93DQo+IHJlZ2lzdGVycy4NCj4gDQo+IEknbSBu
b3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQgdGhlIGlzc3VlIGhlcmU/ICBJZiB0aGUgZHJpdmVy
IGNhbiBzYWZlbHkgbWFuYWdlDQo+IHRoZSBoYXJkd2FyZSBzdXJlbHkgaXQgY2FuIHNhZmVseSBt
YW5hZ2UgY2FjaGUgb25seSBtb2RlIHRvbz8gIElmIHRoZXJlIGFyZQ0KPiBkdXBsaWNhdGUgcmVz
dW1lcyB0aGVuIGNhY2hlIG9ubHkgZW5hYmxlL2Rpc2FibGUgaXMgYSBib29sZWFuIGZsYWcgcmF0
aGVyIHRoYW4NCj4gcmVmY291bnRlZCBzbyB0aGF0IHNob3VsZG4ndCBiZSBhIHByb2JsZW0uDQo+
IA0KDQpJIHN0aWxsIGNhbid0IHNlZSBhbiBlYXN5IGFuZCBzYWZlIHRvIHdheSB0byBkbyBpdC4N
CldoYXQgSSdtIHdvbmRlcmluZyBpcyB3aGV0aGVyIGl0J3Mgd29ydGggdG8gZG8gaXQgaWYgbmVl
ZCB0byBpbnRyb2R1Y2luZyBjb25zaWRlcmFibGUNCmNvbXBsZXhpdGllcyBpbiBkcml2ZXIgdG8g
b3ZlcmNvbWUgdGhpcyBpc3N1ZSBpZiBpdCBjYW4gYmUgc2ltcGx5IGRpc2FibGVkLg0KQW55d2F5
LCBJIHdpbGwgdHJ5IHRvIGludmVzdGlnYXRlIGl0Lg0KDQo+ID4gRnVydGhlcm1vcmUsIGN1cnJl
bnQgaW14IGJsa2N0bCBpcyBhIGNvbW1vbiBkcml2ZXIgdXNlZCBieSBtYW55IGRldmljZXMNCj4g
WzFdLg0KPiA+IEludHJvZHVjaW5nIHZvbGF0aWxlIHJlZ2lzdGVycyBhbmQgY2FjaGUgbWF5IGJs
b2F0IHRoZSBkcml2ZXIgYSBsb3QNCj4gdW5uZWNlc3NhcmlseS4NCj4gDQo+IFlvdSBkb24ndCBh
Y3R1YWxseSBuZWVkIHRvIGhhdmUgYSBjYWNoZSB0byB1c2UgY2FjaGUgb25seSBtb2RlLCBpZiB0
aGVyZSBhcmUNCj4gbm8gY2FjaGVkIHJlZ2lzdGVycyB0aGVuIHlvdSdsbCBqdXN0IGdldCAtRUJV
U1kgb24gYW55IGFjY2VzcyB0byB0aGUgcmVnaXN0ZXJzDQo+IGJ1dCB0aGF0J3MgaG9wZWZ1bGx5
IGZpbmUgc2luY2UgYXQgdGhlIG1pbnV0ZSB0aGluZ3Mgd2lsbCBqdXN0IGZhbGwgb3ZlciBhbnl3
YXkuDQo+IFlvdSBzaG91bGRuJ3QgZXZlbiBuZWVkIHRvIGZsYWcgcmVnaXN0ZXJzIGFzIHZvbGF0
aWxlIGlmIHRoZXJlJ3Mgbm8gY2FjaGUgc2luY2UgaXQncw0KPiBub3QgcmVhbGx5IHJlbGV2YW50
IHdpdGhvdXQgYSBjYWNoZS4NCj4gDQoNCkFmdGVyIGEgcXVpY2sgdHJ5IGluaXRpYWxseSwgSSBm
b3VuZCB0d28gaXNzdWVzOg0KMS4gVGhlcmUncyBhIHdhcm5pbmcgZHVtcCBpZiB1c2luZyBjYWNo
ZV9vbmx5IHdpdGhvdXQgY2FjaGUNCnZvaWQgcmVnY2FjaGVfY2FjaGVfb25seShzdHJ1Y3QgcmVn
bWFwICptYXAsIGJvb2wgZW5hYmxlKQ0Kew0KICAgICAgICBtYXAtPmxvY2sobWFwLT5sb2NrX2Fy
Zyk7DQogICAgICAgIFdBUk5fT04obWFwLT5jYWNoZV9ieXBhc3MgJiYgZW5hYmxlKTsNCiAgICAg
ICAgLi4uDQp9DQoyLiBJdCBzZWVtcyBfcmVnbWFwX3dyaXRlKCkgZGlkIG5vdCBoYW5kbGUgY2Fj
aGVfb25seSBjYXNlIHdlbGwgd2l0aG91dCBjYWNoZS4NCkl0IG1heSBzdGlsbCB3cml0ZXMgSFcg
ZXZlbiBmb3IgY2FjaGVfb25seSBtb2RlPw0KDQpJIGd1ZXNzIHdlIG1heSBuZWVkIGZpeCB0aG9z
ZSB0d28gaXNzdWVzIGZpcnN0IGJlZm9yZSB3ZSBjYW4gc2FmZWx5IHVzZSBpdD8NCg0KPiA+IFRo
ZSBzaW1wbGVzdCB3YXkgZm9yIGkuTVggY2FzZSBtYXkgYmUganVzdCBkaXNhYmxpbmcgZGVidWdm
cyBhcyBpdA0KPiA+IGNhbid0IHJlZmxlY3QgdGhlIGFjdHVhbGx5IEhXIHN0YXRlIHdpdGhvdXQg
cG93ZXIuIFNvIHdlIHdvdWxkIHdpc2ggdGhlDQo+IHJlZ21hcCBjb3JlIGNvdWxkIHByb3ZpZGUg
YW4gb3B0aW9uIHRvIHVzZXJzLg0KPiANCj4gVGhlIGdvYWwgaGVyZSBpcyB0byBkZXNjcmliZSB0
aGUgcmVnbWFwIGl0c2VsZiBzbyB0aGF0IHRoZXJlJ3MgbGVzcyBmcmFnaWxpdHkgYXMNCj4gdGhp
bmdzIGNoYW5nZSBhbmQgd2UgZG9uJ3QgbmVlZGxlc3NseSBkaXNhYmxlIGFueXRoaW5nIGVsc2Ug
dGhhdCBoYXBwZW5zIHRvDQo+IGJlIGFkZGVkIHRvIGRlYnVnZnMgaW4gdGhlIGZ1dHVyZSBkdWUg
dG8gaGF2aW5nIGFuIG92ZXJseSBnZW5lcmljIGZsYWcsIGFuZCB3ZQ0KPiBnZXQgdGhlIGFiaWxp
dHkgdG8gZGlyZWN0bHkgY2F0Y2ggYWNjZXNzIHRvIHRoZSBoYXJkd2FyZSB0aGF0IG1pc3NlcyBk
b2luZw0KPiBwb3dlciBtYW5hZ2VtZW50IHByb3Blcmx5IHdoaWxlIHdlJ3JlIGF0IGl0Lg0KPiAN
Cj4gV2UgYWxyZWFkeSBoYXZlIGEgd2F5IHRvIGRlc2NyaWJlIGl0IGJlaW5nIHVuc2FmZSB0byBh
Y2Nlc3MgdGhlIGhhcmR3YXJlLCB3ZQ0KPiBtYXkgYXMgd2VsbCB1c2UgaXQuDQo+IA0KPiA+IEFu
ZCBJIG5vdGljZWQgdGhhdCBzeXNjb24gWzJdIHNlZW1zIGhhdmUgdGhlIHNhbWUgaXNzdWUgc2lu
Y2UgdGhlIGZvbGxvd2luZw0KPiBjb21taXQ6DQo+IA0KPiA+IGNvbW1pdCA5Yjk0N2ExM2U3ZjYw
MTdmMTg0NzBmNjY1OTkyZGJhZTI2Nzg1MmIzDQo+ID4gQXV0aG9yOiBEYXZpZCBMZWNobmVyIDxk
YXZpZEBsZWNobm9sb2d5LmNvbT4NCj4gPiBEYXRlOiAgIE1vbiBGZWIgMTkgMTU6NDM6MDIgMjAx
OCAtMDYwMA0KPiANCj4gPiAgICAgcmVnbWFwOiB1c2UgZGVidWdmcyBldmVuIHdoZW4gbm8gZGV2
aWNlDQo+IA0KPiA+ICAgICBUaGlzIHJlZ2lzdGVycyByZWdtYXBzIHdpdGggZGVidWdmcyBldmVu
IHdoZW4gdGhleSBkbyBub3QgaGF2ZSBhbg0KPiA+ICAgICBhc3NvY2lhdGVkIGRldmljZS4gRm9y
IGV4YW1wbGUsIHRoaXMgaXMgY29tbW9uIGZvciBzeXNjb24gcmVnbWFwcy4NCj4gDQo+IFRoYXQn
cyBhIGRpZmZlcmVudCB0aGluZywgdGhhdCdzIGR1ZSB0byB1cyBuYW1pbmcgdGhlIGRpcmVjdG9y
eSBhZnRlciB0aGUgc3RydWN0DQo+IGRldmljZSBidXQgc3lzY29ucyBiZWluZyBjcmVhdGVkIGJl
Zm9yZSB3ZSBoYXZlIHRoYXQgc3RydWN0IGRldmljZSBhdmFpbGFibGUuDQoNClllcywgYnV0IHN5
c2NvbiBoYXMgdGhlIHNhbWUgaXNzdWUgdGhhdCB0aGUgc3lzdGVtIG1heSBoYW5nIGlmIGR1bXAg
cmVnaXN0ZXJzDQp0aHJvdWdoIGRlYnVnZnMgd2l0aG91dCBwb3dlciBvbi4NCkhvdyB3b3VsZCB5
b3Ugc3VnZ2VzdCBmb3IgdGhpcyBjYXNlIGFzIHN5c2NvbiBpcyBhbHNvIGEgY29tbW9uIGRyaXZl
cj8NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
