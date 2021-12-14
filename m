Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE904739B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhLNAnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:43:35 -0500
Received: from mail-dm6nam08lp2044.outbound.protection.outlook.com ([104.47.73.44]:20239
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233802AbhLNAne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:43:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci5NbB4zwaCXF9hi6xEbOynQlarxo4PO1hGYo2PRS+rnxuH6F7+yHtmx+aLmYmWjC89L4fxmwXVapOJ3tc35mUOvBeuo0TjurGNVOOalZEehecGRmCQtQK88dH+w9sJzQcHbI+3AWNXxVeUUC18YnCwZ5vHkKbC4MRwxoqSQncgMSVynU1WAaCt0Myrd1Zloc74YdD/GRS/VFshZXqSW5cbJUvphL66pbbLWiFbhE2Eo/JgiRXNBiEvvswhhh+wo068f+eD+EmYqTvjkXoptaq/AW+BVfxtN9BTgF3Qc5UEAhgQvQwrxQ7Alu+TTfFWgBFNQDu6e6/LA+n0qOtp0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uABErC4HXs+33tggESVbDAz2UZBQ8zALdrQN4ClpxII=;
 b=MsgL37ihlxEFpiiBTQ7WXL+TMLNrjlaacbufMAZ67WHVQjo2qGgwEi2yFyQC448IfUJSnrdjHEOfSws+Q+H7PvsiBPOxjryTeMnvRMtwqrZwyKb7o5XTMfpNz9AL6TYKTekxWWJ2SRLrLqH6UqjpSbpclfdvAJ7b8CJ/lzGvOwzTvgDdbC7U5+KrfUitoFe3LVO97LPgtT4DjXIj9ZKKiC9vZ8tD2digHJPmeGVovpn+zppYtaozimixoKyFWdaRd8RPmFUKbqNMSktyUu3HaxPT5GLAIvbdHw0NN/Zp3AAv/vdJHPLCaQuBhiEM4wPVXurDZszIeSYsZtxc+m2lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uABErC4HXs+33tggESVbDAz2UZBQ8zALdrQN4ClpxII=;
 b=Po9kJwYPhyDSNce9IzUhyr/j3iDy2/sMQsmrdUfCInNOPv1aF8uM84/wnc7BGYmMpbam/7s1lJPH4sMvkpsSrua5833UhDc64N025DM8N4Mb0C8lFkgscIGWhNXdsBX3zqlGjGFFmnx+REHQE7N4z5netv+8J5evtXImMNF1ij0=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BY5PR21MB1507.namprd21.prod.outlook.com (2603:10b6:a03:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.0; Tue, 14 Dec
 2021 00:43:30 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Tue, 14 Dec 2021
 00:43:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Random high CPU utilization in blk-mq with the none scheduler
Thread-Topic: Random high CPU utilization in blk-mq with the none scheduler
Thread-Index: AdftWjJCThl7/4e5TledNcioslhEuwA0I/TAAAIttYAAAhJ/YAAAZxqAAABQgvAAB2fUwAAPiK6AAAmHiRAAZDAcAAAMK9PQ
Date:   Tue, 14 Dec 2021 00:43:30 +0000
Message-ID: <BYAPR21MB1270FCF502C458139F89AF7CBF759@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <c5c8f95e-f430-6655-bab5-d2a2948ab81d@kernel.dk>
 <BYAPR21MB127011609EBF6567126EBF83BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270B53CFDDFD52AD942B3AEBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b4350274-7219-1d1f-7a39-3f445c081fd1@kernel.dk>
 <BYAPR21MB1270C642C3200EC4E65C586EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <bb696622-38ee-c582-ce70-5bfa632f8989@kernel.dk>
In-Reply-To: <bb696622-38ee-c582-ce70-5bfa632f8989@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f669c99e-cae9-4fc2-8d7b-3983807292e6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-14T00:31:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfc45dd9-365c-4d84-823a-08d9be9abff3
x-ms-traffictypediagnostic: BY5PR21MB1507:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB15077334E5A9374E1B41EE78BF759@BY5PR21MB1507.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPtYm5+Z+Cq/B+AM3avVDYm2vuxWxCbUOmPu140ZkRcjCDmgp6SfmXxG1keIwq3MosWkuX5eJ4WaskCf3wv0WZFiQ5jVwsQv4Y4I1DY/xAA6vJOS7VN9n2nJaAZAyYzPpt1LgufB80b7KiGt2cn7bxkmATR8GvTASTu7w3rZ1SMfaAgOuW2qOcOLamZROD0kE2qF/hzU0S7ADtAAyZGZVUP3UZQC+NsnChp5yJ2afExsE0SnvLw/5bpVL2tCPgKilEZPNehj8jX9AGL4YqaOaGukEtwPRXGWq7q58SYJekfJFNElZ9RS5YeD+yjQcf5HVvdfQBn3qgYiUwpyVz8L0LkwyJGx9Yu7WSn1vWTpaxmhWeVUripZhZRv9fz6/vRFItlWVierHJGxhsJy8PrxBKB2C+sIpb9jokB7ajFyAUTqFcWPpF1CmVI/RIdOhuJOVDxSyxx2s7xVb5RYGda/C/65EF6lSsFHs0qRTa56CxE0j6E5N0jQXZU9+anFmdIt04Giw0hP97HjAzVoccUF0K4BbUK+JxnTlBtaqirT9pd864W6DqddmilH62zgzCJwYoKKlrgE1WY/k0iUX40ALzedubwdnIrtTfGrUfk3LBvAAZw946HxshfFJhcQPRPQJQLNMWyAI4gs27Nz5zzIsKDXEAOFVk3AG4sZ7ZaVN7sBcYWTECQ5WV6Jl8QTqEBF+K0g2HrK8uj+LAaWMFB72GLllHK2UDwNAwCJTlZXVlpJ47szCcas8ex8ZlsXGugbGJlb4y3xug47/T9A45KUjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82950400001)(82960400001)(33656002)(5660300002)(66556008)(9686003)(8990500004)(38100700002)(66476007)(71200400001)(4326008)(508600001)(52536014)(316002)(122000001)(66446008)(7696005)(64756008)(55016003)(110136005)(10290500003)(26005)(186003)(86362001)(38070700005)(6506007)(8936002)(66946007)(8676002)(54906003)(76116006)(83380400001)(2906002)(491001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG03RjFCaDI2eEFnYUkxWXFqcjBGT3ZPMVVMMFVLTmRsMXFOQ1k3clh6eVl5?=
 =?utf-8?B?TlNiV3BUZm1hTk42bWpaL3lnY2Vrc3l4Q2lVS0QrUHBVMlpTNTRXRXM1M0tW?=
 =?utf-8?B?WElzZllBMlRDVmR4bDF2VDIwaGNLU0pMTWlOZUJBRTJvWVh1czlqbExQenM2?=
 =?utf-8?B?Zkd2L3dRVUgxUVl5ZDJPb1JRNXpiYTY3MmxLYVNkcVdEdDg4K25ydFo4OU1L?=
 =?utf-8?B?N1B3OEY5L2lqdzIzajM4UmI3NjJCOFYzZEx1ZXNmdHhta3MwVzlrQm90SWhQ?=
 =?utf-8?B?VEE1bVRoOGJJckN5SjhxZnBRam1aOE9VTitpMGFLbTNlYTloODErMDJFL3Zk?=
 =?utf-8?B?Wk5pdndNTjdBN0pRZ2JIZjV0UlQzSDUzdFVQbEJGRHhiWUROWnVhQ2RjN1p5?=
 =?utf-8?B?eWtyVXNUM05SNWltNUMzcEpXeTJ1cklHZmJ2WTJKcGdKekVtc2xybVlmNTJz?=
 =?utf-8?B?Rm1KdFZFMDFIWitZSFlpd3djQThaM2VWWVVTc1hPakZRb09ENmtSR3Q3RmZv?=
 =?utf-8?B?cWl3YlZqSml5YlE3ejZHMGN4ZytYZnlSR1R4c2JoS3VONll6WEljcDZ2UnQw?=
 =?utf-8?B?S25WUm90azgrZFhWd0RwekNaZW5KendFSHJEcnhpTTZMVG9lRVVTRnJnZ2Nh?=
 =?utf-8?B?VGJsQnVjQ2w5b1JGSHdBU2pSbFdyWVpBL2V0MGgzM09YUmNSSWVCWm9zWlI3?=
 =?utf-8?B?SnVhMVJ0TGVkdzgvWEtnaW5qdktKTFhHOHYzVllYdFdXUWx0aEVtZFR4RHJp?=
 =?utf-8?B?U2M0WDc5cURwL1ljMm52UnU4Qnh6d280dnpOMDRFb0FrejBxOW5HbFJ0Q3Nz?=
 =?utf-8?B?NzJqV0QvZmFROTk1eDZFSVVSSnVXOGFabUcxaloxbTI0Qko5Q09OREVNMW0r?=
 =?utf-8?B?d2tNUHNvSWJXd3ArMmNuVEZoSUpOMWpHOW1OQzlJY3dlSEF3MkoxbTUwMzZM?=
 =?utf-8?B?K1YrUzNuKzJFSC9pMUNHUEJTclZPWTJpVXJnY1VtbFpiQjBxNUF6QUNrNXhJ?=
 =?utf-8?B?ZE9MMVRXa1BibjU5Wk0yVzNFMDVqU2lMZHFVbmh4QmExOTlDWHdGdUNkTGps?=
 =?utf-8?B?ZEVIc2VLblpDaTNwb280NUY5QU56eldqd3Y5cVVRN29DS2xKUXBhWHpGSHRt?=
 =?utf-8?B?dDFqYTJjckFhYks0ekdiczdUSlFxVFU2eWkxT1BxZmxZTkIwSnVMOGhPd3hD?=
 =?utf-8?B?TzMrN2pKUnhMRGtJZyt3MG5hUkFjS1c2SlJ4OGZwUEZ6b2hkSDE2SjdjWTFO?=
 =?utf-8?B?cktGQzFUaEZZTTJOdFhhWXUwY3JXRXB3a1REQ1dZSEt4am9aRHV3ZTc0Qk42?=
 =?utf-8?B?bVpCbmY5U2VFSTNrdWh1cTl1dk8zSGpoVEVvdDgyT1VERHRRVHNWYlAvUmVQ?=
 =?utf-8?B?Q2J4eTFadDdVYW92OUk3QlgxVjh4T1k3R1Fnc0owcDdxcWdCVnlOaWp0NnZl?=
 =?utf-8?B?SEdScWJ4TThRTUJEa0VtNUF5ZHdGT3cvQnJaOFQ1TzFmczFhc2Y5d3M3dGcv?=
 =?utf-8?B?Zll5UDJkd2pwVkloRzJRWmxHUElpWmtydHRYVVVmOG00Y2tpWjRiWUtnR2E1?=
 =?utf-8?B?WCtTODBqWHZDY1BuSzYweW1nZ2ZWL2E1YU1MUkwwRm9mbnBWRCtXMm9ZTEpa?=
 =?utf-8?B?NjVOY0JJOWt6SzRDa3pzT3hvc1diR0JwUWphdGpwa0QremVzRW56QkhER0pp?=
 =?utf-8?B?YlZ4ZldocENnbjdOR1h5YnVDeEYzVDhleUpZLzZobFQ4bzZvZ09PZDhmcTBt?=
 =?utf-8?B?OURqdkt2amVuR1k3dm5NQkxFWTBTZmJSem82VlBmbHFQY3FGTkFrYXNRVDAr?=
 =?utf-8?B?MDJwUjlxWllza1labzhzOUJ2T1Y4cDN2aG05SEtMcm9SaDdCVkxZRkRPczFY?=
 =?utf-8?B?NVNZNHpoZHcxT1B4djM4UXdvR252Y2ptYWJEZWhteFViMktPUVZhZEI0bFNz?=
 =?utf-8?B?YS9kMTZGK2UxS3gvZGUvV25lbGo3UEJrRHU3c1FXVWZVeEFWV2RxaDkrR3NW?=
 =?utf-8?B?OWZTdUU4TnFyQ2VZdVl1YUVmTWFRWGZZTkxqWjVYTHUxdHRhcWJVTW9MZ2k3?=
 =?utf-8?B?QWRoL0xCY2piT01pQkxCeXMzdkoyUnQwNnRDQ1N5cG5PT1RoY1U5NGpNaDFB?=
 =?utf-8?B?MFdJcFNKdStQRnRoNHlHaVY1RUJiOSs0T2FuQzgyQ0svREh3elBXcGN3YVZk?=
 =?utf-8?Q?9eehS8XTagVuZP2J9yRBgtY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc45dd9-365c-4d84-823a-08d9be9abff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 00:43:30.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/qgVjJ+4tXHs3Q4Ix3GooFyonG+LymjWZqhrN5XVTuIovurH7mbstQEJyU/UpW8tAtrDtIbJmrgZlVW3n8LQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1507
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiBTZW50OiBNb25kYXksIERlY2Vt
YmVyIDEzLCAyMDIxIDEwOjQzIEFNDQo+IA0KPiBJIHdvbmRlciBpZiB0aGlzIHdpbGwgaGVscCwg
U0NTSSBhcnRpZmFjdCBtYWtpbmcgdXMgaGl0IHRoZQ0KPiBtb2QgZGVsYXllZCB3b3JrIHBhdGgg
YWxsIHRoZSB0aW1lLiANCg0KWWVzLCBJIHRoaW5rIHRoaXMgaXMgd2hhdCdzIGhhcHBlbmluZyBo
ZXJlLg0KDQo+IE1pZ2h0IGJlIGEgcmFjZSBpbiB0aGVyZSwgYnV0IHNob3VsZCBiZSBmaW5lIGZv
ciB0ZXN0aW5nLg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstY29yZS5jIGIvYmxv
Y2svYmxrLWNvcmUuYw0KPiBpbmRleCA0ZDhmNWZlOTE1ODguLmNiMmY0ZDYwNGJhZCAxMDA2NDQN
Cj4gLS0tIGEvYmxvY2svYmxrLWNvcmUuYw0KPiArKysgYi9ibG9jay9ibGstY29yZS5jDQo+IEBA
IC0xNjI1LDcgKzE2MjUsOSBAQCBFWFBPUlRfU1lNQk9MKGtibG9ja2Rfc2NoZWR1bGVfd29yayk7
DQo+ICBpbnQga2Jsb2NrZF9tb2RfZGVsYXllZF93b3JrX29uKGludCBjcHUsIHN0cnVjdCBkZWxh
eWVkX3dvcmsgKmR3b3JrLA0KPiAgCQkJCXVuc2lnbmVkIGxvbmcgZGVsYXkpDQo+ICB7DQo+IC0J
cmV0dXJuIG1vZF9kZWxheWVkX3dvcmtfb24oY3B1LCBrYmxvY2tkX3dvcmtxdWV1ZSwgZHdvcmss
IGRlbGF5KTsNCj4gKwlpZiAoIXdvcmtfcGVuZGluZygmZHdvcmstPndvcmspKQ0KPiArCQlyZXR1
cm4gbW9kX2RlbGF5ZWRfd29ya19vbihjcHUsIGtibG9ja2Rfd29ya3F1ZXVlLCBkd29yaywNCj4g
ZGVsYXkpOw0KPiArCXJldHVybiB0cnVlOw0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChrYmxvY2tk
X21vZF9kZWxheWVkX3dvcmtfb24pOw0KPiAtLQ0KPiBKZW5zIEF4Ym9lDQoNClRoYW5rcyB2ZXJ5
IG11Y2ghIFRoaXMgcGF0aCB3b3JrcyENCg0KSW4gdGhlIHRlc3QsICJ2NS4xNi1yYzQgKyByZXZl
cnRpbmcgZGM1ZmMzNjFkODkxIA0KKCJibG9jazogYXR0ZW1wdCBkaXJlY3QgaXNzdWUgb2YgcGx1
ZyBsaXN0IikgKyB0aGlzIHBhdGNoIiBzaG93cyBhIGdvb2QgSS9PDQpwZXJmb3JtYW5jZSB0aGF0
J3MgYWJvdXQgdGhlIHNhbWUgYXMgdjUuMTYtcmM0Lg0KDQpJIHN1cHBvc2UgInY1LjE2LXJjNCAr
IHRoaXMgcGF0Y2giIHdvdWxkIHNob3cgYSBzbGlnaHRseSBldmVuIGJldHRlcg0KcGVyZm9ybWFu
Y2UuDQoNCkl0IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjYW4gY29tbWl0IHRoaXMgc21hbGwgcGF0
Y2ggc28gdGhhdCBpdCBjYW4gYmUNCmJhY2twb3J0ZWQgdG8gb2xkIHN0YWJsZSBrZXJuZWxzLg0K
DQpUaGFua3MsDQpEZXh1YW4NCg==
