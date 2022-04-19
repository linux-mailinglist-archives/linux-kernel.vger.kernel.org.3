Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7645066DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349978AbiDSI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349964AbiDSI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:26:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38053388C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyZuOjuggCrCjWvCMZc6WXSoopW7Lv2CW/sJpCkdYqw+VH3u8US/Jh4K9/ZfUhg7brzwtmB/8MGfXb2M4mmFn4Bn4H1+eABlP/WONF7wGiHEgYoOEPrd3UWenMaiUdtRDWfA0cfz57xX/O8ULDcdXGaSwKbOjvSvCQqjIT7wSo81olG1+vyQb+fto5RMyG1DoLXE/xTYZZ525o4gsHNaNcsvh4ifcsRvgDaemiddWdRJZg2ft3N6qAr49mw7DzF6M9AWK2hf6AGc/qtRoHYIPkVD9BAD66CXT52c7hVisBcDqP9PXTQ6Ikq36gmB8zSaOTtiYX2qEmbNniYmCK1PAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFKFabHwTuA6Q9I7sz9RSxFl6qvqPXuiB1UNJm9H1Bw=;
 b=TDKUR2pxeZc7RMuiGPe61enmWhaN6hwf3M332nwGIyUmAj73PXMSzKtQT4odisAx4JbnmtqMc35/OEhHNYuAecPzN0GUNdlnK+MQyG53TwUiPUkoFDla4W0M7RZVlS3PRrHCrBYgU4V7O7kvVi+FAMr13rG6vD4KNvr1wtWhZpuVyxB4SjQnxJs+jCoOnMsKhZlvcnU6lTu3MReamFXk6hbBPELyuv+0r/TpL5kIbfrzP9yc/ubzmjQkEKlR5yPgPVMjS7NFUEkyq8IU1UgbSGxH3vObAqcM6yEgbPG+wSs5/FjSpzWh+TW1jIoFOilZCwrMSLcsujKtfbRyQAfJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFKFabHwTuA6Q9I7sz9RSxFl6qvqPXuiB1UNJm9H1Bw=;
 b=YmLkLVr4awD27l7Tx4hL1t/7TaL+k7QV/yPVQkDXHqUrrqlCGfRmraSNIQny20FJDRzAlp9GjEUL+HLIRYssm3we9+hYl+wP+0a5HNppfEYQIuVuo5eNdHOCs1JpQ4p0C2pSmAX4CgnGgtLy3+F1G2f8H8veUvRykBUt4VKXCEY=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by AM0PR04MB5490.eurprd04.prod.outlook.com (2603:10a6:208:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 08:23:33 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:23:33 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] extcon: ptn5150: add usb role class support
Thread-Topic: [PATCH] extcon: ptn5150: add usb role class support
Thread-Index: AQHYSZwctDdaLIQeZ06BuvStsTM0tqziq1kAgAAXF/CAFC5VkIAAAhOAgAAAcZA=
Date:   Tue, 19 Apr 2022 08:23:33 +0000
Message-ID: <VI1PR04MB43330369E23F47E26248853989F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
 <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
In-Reply-To: <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e15bb5df-68e4-45c6-7aef-08da21dde48e
x-ms-traffictypediagnostic: AM0PR04MB5490:EE_
x-microsoft-antispam-prvs: <AM0PR04MB5490FB37EF84E5FC9097CD0189F29@AM0PR04MB5490.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DhGYON/3KS1xxWiXe4I0nLKVdUwitjVkPfAq3WldGAqJRF0sm+ZjZWd081e+KJBnFHwD81S3o9E7IbjnqFwT92ogxzPmz6zaVsT5fwUdLb31yklsTWA2rBrUrpyg23AjQ4qcK3ISzQmQnqfu9WHeLqGiAPdcZ+t87zYKHEaYhb09GORbwh15ju/fwlbrreQWK/j0IzwuchlvYsjdMaW39r/qfZQAxVUpUUSN8SAmZUUdGyzZbbAxmwMOHYSo/fpOlkWtPhnh8h6+GT/cG+yhA/hLDsNjU7k/JRTuoK9k7C3crraEyZqDqUhfKCXgPRL372egnfOIhgIsaP1f+nAisMd+21+fw0OJ4LGeuqyLTJk1iEGhDubJE6kjniADkIwwXPF7XQPOz2traAgkoZAw6OogwU3Fkmr91fNw8YiRjl/Bb4ogqDUIzHtx9fh2ZErxfMGqJPmC+3Hwn4B54eyujkwwYjL94OPLX20LAPLyVmdBWDW9Ou37gBAwN/KOC9SXqorQZ0i39nv0Sb1/3k2JIOZYbMPgPIyKCVpTvqviAVjkoIKX96KGG7BuSnEFBiAO4PCQxHnGTIl0jWrWklNs5zL+fInR4Php7ydSMNi41Hju7B+47+YdFlAudajvhq2aiLdLGrH06g0ei55zRlNEg6MNwVDSYylxDJq3YPfgbuCvizM9SZmTK0EBMUgjaXpfNWCx05JLkgb3p8loGLoCMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(8676002)(6506007)(83380400001)(53546011)(66556008)(66446008)(8936002)(4326008)(64756008)(33656002)(55016003)(2906002)(86362001)(76116006)(66946007)(38100700002)(52536014)(38070700005)(5660300002)(44832011)(122000001)(9686003)(7696005)(508600001)(54906003)(26005)(71200400001)(6916009)(186003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2FTcjNOYkhwaGt1UzllNU9xV1dlVkoxREgxU094M0RuRGFMTTJ1OVpYREUv?=
 =?utf-8?B?S1NoZnhTS0twQW11V2JGK01jbG9nMHFXam92YlpkNDVSU20vV1ZDUFFmMDMy?=
 =?utf-8?B?K2tsWmVDVGNSRjUxL2FSRXo1S29nQ25RUE5ZR2h3NDRTUDlpdWxWUFBGYk1m?=
 =?utf-8?B?aVBwTTIvV1BWdGhLZTB5anJoRkk2VmpyZENNbVh1Mm1KZzZqK29OOU82dXZ2?=
 =?utf-8?B?dnlBd25MR0s1SmNhbkg4d3h0b0tka1VmQTU1aXp1VE4zT0tvMllYQ1lneUY1?=
 =?utf-8?B?NmFxNDJrOTBjblFOd3ZkRjFXRHp6Y08xQkExcGhqakQwZWVWeW9VS0RoWW8y?=
 =?utf-8?B?NEJCNjFZbktxZ2dHWm00QVBGek9VMXlWR3JlZjhBRWRvUHBrZVF2ako1eEll?=
 =?utf-8?B?ejh5ZFM2TENSZUhkS214a1dZLzBjQjRGWUNTRmFiTFlhTzRyS2FZL0F5ekRw?=
 =?utf-8?B?SFFwUm9sbnNwbmU0MXZjOU0ybFpBamlMT09aWCtFQllTelhnejBDbEpaSmZZ?=
 =?utf-8?B?L0dXTUtiU2pSN2JiZ2l3QVN4TWNTQ1hDK2sreTBYdlVUWHBnWUVobjFkaWk1?=
 =?utf-8?B?Z1I1SEZ1dWJsak54Y2tKMjhjeC9xM3hLS1VENnhlZjlFcE85cFZqL3JPS1E0?=
 =?utf-8?B?ZFQxZ1JlT0dBdUJvUk13Ums4ZmVPZHdqc3hqd1JjMDhGcytiZHo2aHBhSTc0?=
 =?utf-8?B?dHNtaGJ1ektrelFhZ0F1bnlLdWdZQmhCbk9JNS95T2pTZWIvQnRmTXM1RWpa?=
 =?utf-8?B?aTh2VEkzVm16MTlFeWFRdi9SYTI3ZXEyejJRUEM5VnFYWW0wRjlkK3AxM05Y?=
 =?utf-8?B?ZXZwY3dUb2thNnNWbnMvZWxhT2wvdjE3enlFd0FWMVZaeXNheTJWZmltdkhM?=
 =?utf-8?B?ZFZGWGRlcnJHU2RrTFFsT3lsUmdYYWhGMFc1WE4yMlBRbUU3a040Yk9rUmxN?=
 =?utf-8?B?dWxXa3crVk0yYW5wclBhSVE5cVZoS1oweWpuOGRUbCtuZElEODFmSGpTWHF2?=
 =?utf-8?B?ZHpUc0NWQTBwem1vbkZpYytjWi9odGtkQ09aQklNK1ZmektXREdkRFlKdU43?=
 =?utf-8?B?Zm1pRzJrOFJsZk9pbTBZdmxKL2dRRnhXR2tBOFZQcnBEaWZOTTVjbkJyei8r?=
 =?utf-8?B?NzJRR2VBcVV0Qk9jT3lWWG1wWUxVVUREejNpTVJjbTg5Q2xRU1Bjdjl2WWJj?=
 =?utf-8?B?ZTNoQjN6dW05YzlhdTZUM2I3RVJ5WHF4Z0xBOStpeThhRlR1UWpWRWFvS09T?=
 =?utf-8?B?MXg3cmVxaktLRHBkNXAwY2FIUDdFUnJLUElKR2VIMjdERUJDTHh1R3BTWUM4?=
 =?utf-8?B?M01sRWM0YnZoQzhHY1FtUkVsZHA5OXFRZmw4ZWZDcW04Sk9ESC8zbDVRRTNX?=
 =?utf-8?B?bEFUZmg1Mm5iUVFWb3ZCM3I2d01hNzhFVnFPMm55N1JVaSs4bzRTa3c5Ykx5?=
 =?utf-8?B?Qis3MHN1UXZZdjZNMUJLelhDdCtmZ3NqZkZPbklrR0xPNDA0T3ByZ1FzR3Y2?=
 =?utf-8?B?UFA0SFVqSStiMThHM3Y4QTV0TWpaWHJESHRMOXc0ODBGWlhIcVZ6SFFCWjJ4?=
 =?utf-8?B?T3g5c1BRcGNTdmxseTlKNFp3QmtvcnBwSksra2VreFhkQXB6QzBlWVMwVlVL?=
 =?utf-8?B?MDJaeU40aXJDblpsMTBTT0tuRVBJVkhNaUlVemlmbGdFbHR6Q1ZzcnpWZWlR?=
 =?utf-8?B?Z0RyZ1Q0YUUzWVcvelhnZjVpMFFlYjI4TWRrT3pXREoyN2lzeVRCY0NLNGZO?=
 =?utf-8?B?TmwwNTNMVW1tclkvZWlEQ0Y1S0oyQXZHMjVwYVZiUnRxeFVxZjRHY0lIaFRF?=
 =?utf-8?B?RWhyQ1VwQ1lEZkQzemdMN2FXMTUvcEtQMm90Q1UxQVlOdUV5QlRuWGwyeE9N?=
 =?utf-8?B?N1VQUXNaUGJpbmtZaEVUQ2s4YWgvOGhSRVlTc3YwT3dYTFVRTlY2MUhkVVZw?=
 =?utf-8?B?WlFqWi9sRGk2UklONHBBbmVRTkV0Yy94MzUyUkFSZGJ6RVV6YVYzd1BEMll2?=
 =?utf-8?B?RTk2MHVyL3NIcm1GRHhqNXVjaHlSZ3p3eldBU2wrQm5zbWt6OFcxSEhORGtD?=
 =?utf-8?B?Z0JBeWd4dFVEdVdIK1F2VGJQTFFBWlhFMnFzWlhPKzdiaG00NEV1SVFaemhv?=
 =?utf-8?B?eHhBa1ZLSXdrNHNzWGdDMjVJbWpqZ3lWR0tUY2pyK3lPMUpYODc1MHphUXN4?=
 =?utf-8?B?SkhjbUMxMlRIQ0lnaFN1V3drRUQyRHE2RzBZRGM0d3krZFN2Q2k2OXdHWkh6?=
 =?utf-8?B?eE4xbG5hQ25wVzdDWk12d0hxdmk4NXdlNGRqWjZ4S3plTkVtbVJEblZIS3RO?=
 =?utf-8?Q?qlJeaKer6lT8VrCBPB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15bb5df-68e4-45c6-7aef-08da21dde48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:23:33.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DoOaggBdrg5EVHM/GaO/2Nrg5nKwQtWqTahjyXJmHaB/TypVTLVtHUZh4KBwNH+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCAxOSwgMjAyMiAzOjU3IFBNDQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPg0KPiBD
YzogbXl1bmdqb28uaGFtQHNhbXN1bmcuY29tOyBjdzAwLmNob2lAc2Ftc3VuZy5jb207DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsg
WHUgWWFuZw0KPiA8eHUueWFuZ18yQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGV4
dGNvbjogcHRuNTE1MDogYWRkIHVzYiByb2xlIGNsYXNzIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwg
MTkgQXByIDIwMjIgYXQgMDk6NTMsIEp1biBMaSA8anVuLmxpQG54cC5jb20+IHdyb3RlOg0KPiA+
ID4gPiA+IEBAIC0xMzIsNiArMTMyLDcgQEAgY29uZmlnIEVYVENPTl9QVE41MTUwDQo+ID4gPiA+
ID4gICB0cmlzdGF0ZSAiTlhQIFBUTjUxNTAgQ0MgTE9HSUMgVVNCIEVYVENPTiBzdXBwb3J0Ig0K
PiA+ID4gPiA+ICAgZGVwZW5kcyBvbiBJMkMgJiYgKEdQSU9MSUIgfHwgQ09NUElMRV9URVNUKQ0K
PiA+ID4gPiA+ICAgc2VsZWN0IFJFR01BUF9JMkMNCj4gPiA+ID4gPiArIHNlbGVjdCBVU0JfUk9M
RV9TV0lUQ0gNCj4gPiA+ID4NCj4gPiA+ID4gWW91IGRvIG5vdCBuZWVkIHRvIHNlbGVjdCBpdC4g
RHJpdmVyIHdpbGwgd29yayB3aXRob3V0IHJvbGUNCj4gPiA+ID4gc3dpdGNoLCB3b24ndCBpdD8g
SWYgaXQgd29ya3MsIHRoZW4gcHJvYmFibHkgaXQgc2hvdWxkIGJlIGp1c3QgaW1wbHkuDQo+ID4g
Pg0KPiA+ID4gT2theSwgdXNiIHJvbGUgY2xhc3MgcHJvdmlkZXIgc2hvdWxkIGVuYWJsZSB0aGlz
IGZvciBtZSwgd2lsbCBkcm9wIGl0Lg0KPiA+DQo+ID4gQSBzZWNvbmQgY2hlY2sgb24gdGhpcyBh
bmQgSSB0aGluayBJIHN0aWxsIG5lZWQgdGhpcywgdGhlcmUgbWF5YmUgc29tZQ0KPiA+IHVzYiBj
b250cm9sbGVyIGRyaXZlciB3aXRob3V0IHVzYiByb2xlIHN3aXRjaA0KPiA+ICsgcHRuNTE1MCB2
aWEgZXh0Y29uLCBzbyBubyBuZWVkIFVTQl9ST0xFX1NXSVRDSCwgSSBuZWVkDQo+ID4gc2VsZWN0
IGl0IHRvIGF2b2lkIGJ1aWxkIGJyZWFrLg0KPiANCj4gV2hhdCBidWlsZCBwcm9ibGVtIGV4YWN0
bHk/IEFyZW4ndCB0aGVyZSBzdHVicyBmb3IgIVVTQl9ST0xFX1NXSVRDSCBjYXNlPw0KDQpNb3N0
bHkgY2FzZXMgVVNCX1JPTEVfU1dJVENIIGlzIGVuYWJsZWQsIGJ1dCBJIGNhbm5vdCAxMDAlIGVu
c3VyZQ0KdGhhdCwgYXQgbGVhc3QgSSBjYW4gdmlhIG1ha2UgbWVudWNvbmZpZyBjaGFuZ2UgYnkg
cmVtb3Zpbmcgc29tZQ0KY29udHJvbGxlcnMgZHJpdmVycyB0byBjcmVhdGUgYSBjb25maWcgdG8g
Z2VuZXJhdGUgYSBidWlsZCBicmVhazoNCg0KL29wdC9mc2wtaW14LWludGVybmFsLXh3YXlsYW5k
LzUuMTUtaG9uaXN0ZXIvc3lzcm9vdHMveDg2XzY0LXBva3lzZGstbGludXgvdXNyL2Jpbi9hYXJj
aDY0LXBva3ktbGludXgvYWFyY2g2NC1wb2t5LWxpbnV4LWxkOiBkcml2ZXJzL2V4dGNvbi9leHRj
b24tcHRuNTE1MC5vOiBpbiBmdW5jdGlvbiBgcHRuNTE1MF93b3JrX3N5bmNfYW5kX3B1dCc6DQpl
eHRjb24tcHRuNTE1MC5jOigudGV4dCsweDIwKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdXNi
X3JvbGVfc3dpdGNoX3B1dCcNCi9vcHQvZnNsLWlteC1pbnRlcm5hbC14d2F5bGFuZC81LjE1LWhv
bmlzdGVyL3N5c3Jvb3RzL3g4Nl82NC1wb2t5c2RrLWxpbnV4L3Vzci9iaW4vYWFyY2g2NC1wb2t5
LWxpbnV4L2FhcmNoNjQtcG9reS1saW51eC1sZDogZHJpdmVycy9leHRjb24vZXh0Y29uLXB0bjUx
NTAubzogaW4gZnVuY3Rpb24gYHB0bjUxNTBfY2hlY2tfc3RhdGUnOg0KZXh0Y29uLXB0bjUxNTAu
YzooLnRleHQrMHhjOCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHVzYl9yb2xlX3N3aXRjaF9z
ZXRfcm9sZScNCi9vcHQvZnNsLWlteC1pbnRlcm5hbC14d2F5bGFuZC81LjE1LWhvbmlzdGVyL3N5
c3Jvb3RzL3g4Nl82NC1wb2t5c2RrLWxpbnV4L3Vzci9iaW4vYWFyY2g2NC1wb2t5LWxpbnV4L2Fh
cmNoNjQtcG9reS1saW51eC1sZDogZXh0Y29uLXB0bjUxNTAuYzooLnRleHQrMHgxMzgpOiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGB1c2Jfcm9sZV9zd2l0Y2hfc2V0X3JvbGUnDQovb3B0L2ZzbC1p
bXgtaW50ZXJuYWwteHdheWxhbmQvNS4xNS1ob25pc3Rlci9zeXNyb290cy94ODZfNjQtcG9reXNk
ay1saW51eC91c3IvYmluL2FhcmNoNjQtcG9reS1saW51eC9hYXJjaDY0LXBva3ktbGludXgtbGQ6
IGV4dGNvbi1wdG41MTUwLmM6KC50ZXh0KzB4MTRjKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
dXNiX3JvbGVfc3RyaW5nJw0KL29wdC9mc2wtaW14LWludGVybmFsLXh3YXlsYW5kLzUuMTUtaG9u
aXN0ZXIvc3lzcm9vdHMveDg2XzY0LXBva3lzZGstbGludXgvdXNyL2Jpbi9hYXJjaDY0LXBva3kt
bGludXgvYWFyY2g2NC1wb2t5LWxpbnV4LWxkOiBkcml2ZXJzL2V4dGNvbi9leHRjb24tcHRuNTE1
MC5vOiBpbiBmdW5jdGlvbiBgcHRuNTE1MF9pcnFfd29yayc6DQpleHRjb24tcHRuNTE1MC5jOigu
dGV4dCsweDI5MCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHVzYl9yb2xlX3N3aXRjaF9zZXRf
cm9sZScNCi9vcHQvZnNsLWlteC1pbnRlcm5hbC14d2F5bGFuZC81LjE1LWhvbmlzdGVyL3N5c3Jv
b3RzL3g4Nl82NC1wb2t5c2RrLWxpbnV4L3Vzci9iaW4vYWFyY2g2NC1wb2t5LWxpbnV4L2FhcmNo
NjQtcG9reS1saW51eC1sZDogZHJpdmVycy9leHRjb24vZXh0Y29uLXB0bjUxNTAubzogaW4gZnVu
Y3Rpb24gYHB0bjUxNTBfaTJjX3Byb2JlJzoNCmV4dGNvbi1wdG41MTUwLmM6KC50ZXh0KzB4NGY0
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdXNiX3JvbGVfc3dpdGNoX2dldCcNCi9vcHQvZnNs
LWlteC1pbnRlcm5hbC14d2F5bGFuZC81LjE1LWhvbmlzdGVyL3N5c3Jvb3RzL3g4Nl82NC1wb2t5
c2RrLWxpbnV4L3Vzci9iaW4vYWFyY2g2NC1wb2t5LWxpbnV4L2FhcmNoNjQtcG9reS1saW51eC1s
ZDogZXh0Y29uLXB0bjUxNTAuYzooLnRleHQrMHg1MzApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
IGB1c2Jfcm9sZV9zd2l0Y2hfcHV0Jw0KbWFrZTogKioqIFtNYWtlZmlsZToxMjQ3OiB2bWxpbnV4
XSBFcnJvciAxDQoNCnRoYW5rcw0KTGkgSnVuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo=
