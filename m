Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE31511491
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiD0JlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiD0Jkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:40:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071E32B267;
        Wed, 27 Apr 2022 02:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZcJsUERAKHPDZFupkXimEfEofco2KWlilunz7Chc23cVWjSA5hxDZEVVDWhDFBymy48sXQ0HBH7dsc19blBEw+z/dh+GTDCJBmMDE/PTno6002QqeCyhGlWS48Jz9xbBbKQ6347YZ0ILbnn2Q2QYp/o/lyxPXKHND+5m4umcTZV0OtAJLxH9IVXxZIYch4jS3NLzk3uMOvqrsxzMmuF3aibqt0gXxfyV9nsRFSOgJgRc6anVHWw3Dcja9VbY8omkx1Eonx74BHi4JhTg5/Jf6kkKExI4qXJ6F8+zmycAluCxrlkOS/CdTccrr8XpkXCu9ScY1pU4LJazTRYWqYFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mMne6Pj/ghhM4d5g5rYgzmS36UzERUDo0EnUWmzRxM=;
 b=WXP3zGZ6AJRe46bGZF60/usYufICifoQT7+rVtYyTBDbVoNiknGR6PFr3M1LvI6fsSTrMmWgmHCVzeP58fggRF+pahM7xdVNLwV/7ZGQ5CztsDowDLUVdg6lwcrJd/7uktgKZkrMjMu9bfeQ3UDjI2GYUjsW+jvJHMkIYQtabAjjdP1oGXVYpJn029brVdTG6I/BTNykE79sNe8gQMt57d9SwRwAxLxB8n8mxI/CORkAo84VnmFMBTa3+870IBLOKJhPpXFN5GIZYoMT1F0xuG2fZ5pwYnyfDNK61rNIVu+F8NX7t5fw/AhUzhATL00U8jccV8gKQFWJgZ5w6svDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mMne6Pj/ghhM4d5g5rYgzmS36UzERUDo0EnUWmzRxM=;
 b=HAhERMuyDNRcLF8FJoY+KVtIlbztYCUvPMn6gsr7x6lTl58Ig6fjZcu8vYJxdWn7GDBazaeJLIX0oTfwUlbTejgRVjbGGbLqTduPOtLJ0MGWPRVYvk/aEqxSEV0ypIrW1qBSaASRb+NK8WUO+FWI2oUBF3p5r/fejoHE+PirJxY=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB5365.eurprd04.prod.outlook.com (2603:10a6:20b:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 09:31:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390%6]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 09:31:29 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: ensure the buffer count is not
 less than min_buffer
Thread-Topic: [EXT] Re: [PATCH] media: amphion: ensure the buffer count is not
 less than min_buffer
Thread-Index: AQHYPcbr3LBobsXolEi0GfOdZM0tnK0DhyYAgAAE+pCAAAg8gIAAIe5Q
Date:   Wed, 27 Apr 2022 09:31:29 +0000
Message-ID: <AM6PR04MB6341A433AC17C5A6C773245FE7FA9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220322082859.9834-1-ming.qian@nxp.com>
 <3cdf47f5-ad38-44ca-1720-d70a96432045@xs4all.nl>
 <AM6PR04MB6341DAEF2FCC3CB48A7F7E19E7FA9@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <ecd9f658-09f2-783e-8cc0-34d4b0a8ed26@xs4all.nl>
In-Reply-To: <ecd9f658-09f2-783e-8cc0-34d4b0a8ed26@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e004ba4-c58c-4db6-00ae-08da2830b5c1
x-ms-traffictypediagnostic: AM6PR04MB5365:EE_
x-microsoft-antispam-prvs: <AM6PR04MB536585A12CE754BE83F12E66E7FA9@AM6PR04MB5365.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhPWDTwW8Hfq3mrZ0qkyzAAfQ15UwYS0GoOGAjONatb2k0eG0fLdqllcn6fY/E67ROxwf9maT98XbCocTXagWVQSvhJ9S2lg3rNgphRauUMTndNaGiatfGK7gd8ehMNj+z4dBmEtBc/YZySXSpjzTMT8gqPE7gMKWshCnKRlyxPtmpOVXhBQsBgKrY7se/TfOHHlL+INal/nsA728c2pjRed6ucxsAmTh7FEdZPJC8Kc7k9/JiBRAOY4VVFt1GABhrqUnlysVp+Zglot3RoqUIXtU9DnbN4gu5LN3ELTTBpbFotSbi85xSnprSrAF4Hcdb+N8p1SRDEjB0GfwDdpOhhflMvSQqDc4L+hqGfETsVRvSt9fzrdQ9/yC8hFkiT9Vedpto1nqDGfcH0MdI8zNTJqYZuk46miPrGy8NzTsQ1SgJXon8dMM5NZ77OgowHExZ3UTeV6/cpn4iACWcExZVf/W7mvoYGmpDXRQaIGTJJ5lpvx01Ly2ki1LZ4SLyz3Ync4zpRP5ndHbBFcowtRsxJ1oAsu2iUCOIImO8zyajQa3TRP+oa2JRKw9AzH0dEyZo82fVxLQCm55IjX5f887OfJp32Ob/mSequ3N4HyxrT5taWnTvXEGC+jfzDRDRIkgyHPsFLAycx36P09pg+UrHmc//+zDAxMDc08n+4NIqz/S9MLLjch6Ml009FKl1m3cFWBin1pxcBs1VEVX1QKog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(55016003)(508600001)(316002)(33656002)(5660300002)(8936002)(8676002)(64756008)(7416002)(76116006)(54906003)(110136005)(186003)(66476007)(66556008)(86362001)(38100700002)(38070700005)(66446008)(4326008)(9686003)(71200400001)(2906002)(122000001)(83380400001)(52536014)(7696005)(26005)(44832011)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eks4VjZXZ2h0QmlpU3lZTEJsNGdHSmVtMElUQ0NwMkNkVXB3S0pvM1JxWGZ0?=
 =?utf-8?B?TTFHRldBZTNvaCtaQnU0emFXcnhwYm1uUk9hblJaTEdZamJ6dThSTk1ZR285?=
 =?utf-8?B?dEFMKzhUR0V6TnJzT2V2b0pCbnIrVHA1OXY0V29Cd1AwekFEOFpSOHRlSy9X?=
 =?utf-8?B?bFRvYWhoWlVEdVBaTlZETFNNUkM5WStLYXBRTkFRanVUSVMwb0xTbVYxRnJ3?=
 =?utf-8?B?VFVsL1Z0RmFDSWVPSXU3bVVtK3ZNdGV2V3o3bWFYMnRvbys1aWN0OFRoRFpE?=
 =?utf-8?B?K0RTUGppcnJFdzdPdmVCOGhPZE9TTDhyOU5EWTVGWmxGbUdOclJqK0RTaEhm?=
 =?utf-8?B?cUtkN09uNlcxaVBnVHkvMEkyVjloWWpxcEhENktJK3h4clR2OEJIbWdFYWVB?=
 =?utf-8?B?czEzd0hWTXIzbTgrVG1Dc0YvaHo1b1IyTEUzR0tDbHNjZ0xST1BURUZXOXlK?=
 =?utf-8?B?ZzJRbDFZcDRpQW41cnRCU0J0Qk8rUGJkSzYwejZOR1BJckVURjhtSTYrcXdL?=
 =?utf-8?B?bU03M1k4RDZlTU1SbTVQdmhxRjY2ZGRYWkRRRkg3Q2RCVWN5MVlIc2NQNGFj?=
 =?utf-8?B?aDUrUVpOMThDd29RenR5aUo3QnBDMWxzNU53ODYxem1oUXA2T1NabktxdUtG?=
 =?utf-8?B?TDRkZ29Xbk96ZGtqRDZRempRRUZJQVJPcVlrbHJ4Z09FK1hmQnpiSzFwcy9x?=
 =?utf-8?B?REVyenlMU0ZBZ2FRS0tOQ09ocksrWndQZkNmYkxZOUVITThxUGM1OVpUUVRn?=
 =?utf-8?B?TGtFQ2FpT2pqdWhleTVaMk15L0sxWEpjRUFZc3VQMTdhOXVCVWNxMXkrY0ZR?=
 =?utf-8?B?Ty9xallXc0VpQUpwNmN5VTNPYkJiNkhhZ2EwcjRZOHcrTzE3SzBCK295azNN?=
 =?utf-8?B?SkhlL25YcWt1MTB3ZnZ5c1ZvVC92ZEJ3MkxTalRtSWY5ZHUxQUhUYVRkc25P?=
 =?utf-8?B?Z2g2Mi83WWJsTEhtNG5idnBNVGpsaEVRb1k2VEMvODhvNFBrTVZkVkltS1NW?=
 =?utf-8?B?K25yUkVqOGZvVHRQdlJYUldqU2NQOWpXNG1PM2ZPTTVQT0Ryb2gyb0ZvZHM4?=
 =?utf-8?B?dGRXUzZqMkN5enpZM1dxRFJPUk5TK3haVHoyVm5XSlZKc05SQW1OVlFxbmRF?=
 =?utf-8?B?Q1NueHgvaWxoZ2lOajA0c0xqNDBNZjJ5dnMyNXlFMWNBM0NYczhhdVkwaVAv?=
 =?utf-8?B?MWlqM04yZUY3cHA0TXFQb1BqNGgzYzRRRC8xT2tnd0xvRUNXa2JmU1VTK2hB?=
 =?utf-8?B?VW9MNjFiMDd5UmhEWWc1MWtscWFRNVlYN2VpRFZYRGVhbHhjMTRHbkhTUG90?=
 =?utf-8?B?d1hRTklDcFlSdlFjbkw0S1orOGJIRDM5ejdXcDBjQitvVW1tU1RnVjliMW9W?=
 =?utf-8?B?QWNFM21kdjhvWHd6eTJQb3dKYmc1UWpiVzJOK2xZWTNwNEdUZGVKSGxhV0VQ?=
 =?utf-8?B?UjRtR204VkZSdmhEOWFKVzJFU3pwVlVvaVJMVWZTditRRXAwdG0xdXpHdTNW?=
 =?utf-8?B?WXJYWldXMDdLWDdLeitBbUxZenhCSlNtdXIvbURpMHAwU2lnNzJpaFFaWWNz?=
 =?utf-8?B?ZmoxdU9SL045WkorZlpZSGIrWWc5NnNWajVMdlA1VEMwYk4xSmp5NkZpRjVC?=
 =?utf-8?B?UmY2RUJjL1l0NXVEdW85WjdqR2o1S200Vjc1dDVpTnc0Z2xLb25EcmxhVldR?=
 =?utf-8?B?L1l0dTRKakhUSWNPY2tJTWNxU3lFbjY0c09RTXkyd09RL2ptZGpGM3Y4Q0ZO?=
 =?utf-8?B?ZjFwc1MvU2s5Y2h5dkw0M2VLdkY0ZUo1VzBzTDc5UFRFS1doM2ZZRHVmWXRE?=
 =?utf-8?B?Y0pBaEUvbWlLeURCaGVtRWQ4NDhTOUxIUXlWaFFCRm5WUkdHazFWdHk2dmxM?=
 =?utf-8?B?dEtBbzZwdUNScTlYREJjNHlYZDRqVzg1b2NSRTNZMmpDb0MxY0VXUTZpNjkw?=
 =?utf-8?B?VE1iWnRZWUg4SzJ6dVhXTXV4Rys5Z0ZNTktuTDRrbE5MRm1ZSjZ5SmhMZHNw?=
 =?utf-8?B?eUhLOFBkemFnSXZNN1YxOGlJdjNuSlJGcGpnV29yelUwOUx4bW0yeEdGdHRp?=
 =?utf-8?B?MWhOMk5DSG1zcWh5U2c3VkRsQXU3K1BBMmJ3dHp1eTNKVG90YTNnNGlWc3lL?=
 =?utf-8?B?UUtWVWNnRG1TT3ZtNUYrOEtmakdFWm9MUm9iYUNTNElvRlpiQXhkWEt6T2NY?=
 =?utf-8?B?SDlUMGJsaHBEMWlDWFl1WU1VWmN6cHVyaTZVME13b3BxMHFDMFNYcHV2WlBU?=
 =?utf-8?B?TWcvZTQzL2t4VVA0ckVkOXFhT1RXN3ZIZUdZbzdQM1E5RzdDT2tjczV6Tld6?=
 =?utf-8?B?Nno2OStCNy9JRDJBeVVXRG9VQy9LdFh4MVNCZ3VYdnZONEdUaVZHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e004ba4-c58c-4db6-00ae-08da2830b5c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 09:31:29.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fADtXhBmDtt+ntgVez57qZO3+iTRyV8mPyvvWFGY95nuGMbjc4xuDMdypHUM5/dvZ6Ucwc4S1H7bv3J8RCkAVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5365
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBIYW5zIFZlcmt1aWwgW21haWx0bzpodmVya3VpbC1jaXNjb0B4czRhbGwubmxdDQo+
IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjcsIDIwMjIgMzoyNSBQTQ0KPiBUbzogTWluZyBRaWFu
IDxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZw0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54
cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IGFtcGhpb246IGVuc3VyZSB0aGUgYnVm
ZmVyIGNvdW50IGlzIG5vdA0KPiBsZXNzIHRoYW4gbWluX2J1ZmZlcg0KPiANCj4gQ2F1dGlvbjog
RVhUIEVtYWlsDQo+IA0KPiBPbiAyNy8wNC8yMDIyIDA5OjAxLCBNaW5nIFFpYW4gd3JvdGU6DQo+
ID4+IEZyb206IEhhbnMgVmVya3VpbCBbbWFpbHRvOmh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubF0N
Cj4gPj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyNywgMjAyMiAyOjM4IFBNDQo+ID4+IFRvOiBN
aW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPiA+PiBz
aGF3bmd1b0BrZXJuZWwub3JnDQo+ID4+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7DQo+ID4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21h
aWwuY29tOyBkbC1saW51eC1pbXgNCj4gPj4gPGxpbnV4LWlteEBueHAuY29tPjsgQWlzaGVuZyBE
b25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+ID4+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIG1l
ZGlhOiBhbXBoaW9uOiBlbnN1cmUgdGhlIGJ1ZmZlciBjb3VudCBpcw0KPiA+PiBub3QgbGVzcyB0
aGFuIG1pbl9idWZmZXINCj4gPj4NCj4gPj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+ID4+DQo+ID4+
IEhpIE1pbmcgUWlhbiwNCj4gPj4NCj4gPj4gT24gMjIvMDMvMjAyMiAwOToyOCwgTWluZyBRaWFu
IHdyb3RlOg0KPiA+Pj4gdGhlIG91dHB1dCBidWZmZXIgY291bnQgc2hvdWxkID49IG1pbl9idWZm
ZXJfb3V0IHRoZSBjYXB0dXJlIGJ1ZmZlcg0KPiA+Pj4gY291bnQgc2hvdWxkID49IG1pbl9idWZm
ZXJfY2FwDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5A
bnhwLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlv
bi92cHVfdjRsMi5jIHwgNCArKysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2Ft
cGhpb24vdnB1X3Y0bDIuYw0KPiA+Pj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24v
dnB1X3Y0bDIuYw0KPiA+Pj4gaW5kZXggY2JmMzMxNTYwNWE5Li43MmEwNTQ0ZjRkYTMgMTAwNjQ0
DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3Y0bDIuYw0K
PiA+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV92NGwyLmMNCj4g
Pj4+IEBAIC0zNTUsNiArMzU1LDEwIEBAIHN0YXRpYyBpbnQgdnB1X3ZiMl9xdWV1ZV9zZXR1cChz
dHJ1Y3QNCj4gdmIyX3F1ZXVlDQo+ID4+ICp2cSwNCj4gPj4+ICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+ID4+PiAgICAgICB9DQo+ID4+Pg0KPiA+Pj4gKyAgICAgaWYgKFY0TDJfVFlQRV9JU19P
VVRQVVQodnEtPnR5cGUpKQ0KPiA+Pj4gKyAgICAgICAgICAgICAqYnVmX2NvdW50ID0gbWF4X3Qo
dW5zaWduZWQgaW50LCAqYnVmX2NvdW50LA0KPiA+PiBpbnN0LT5taW5fYnVmZmVyX291dCk7DQo+
ID4+PiArICAgICBlbHNlDQo+ID4+PiArICAgICAgICAgICAgICpidWZfY291bnQgPSBtYXhfdCh1
bnNpZ25lZCBpbnQsICpidWZfY291bnQsDQo+ID4+PiArIGluc3QtPm1pbl9idWZmZXJfY2FwKTsN
Cj4gPj4NCj4gPj4gSSBub3RpY2VkIHRoYXQgbWluX2J1ZmZlcl9vdXQvY2FwIGlzIHNldCB0byAy
LCBidXQgbWluX2J1ZmZlcnNfbmVlZGVkDQo+ID4+IGlzIHNldCB0byAxLiBXb3VsZG4ndCBpdCBt
YWtlIG1vcmUgc2Vuc2UgdG8gc2V0IG1pbl9idWZmZXJzX25lZWRlZCB0bw0KPiA+PiAyIGFzIHdl
bGw/DQo+ID4+DQo+ID4+IElmIHlvdSBkbyB0aGF0LCB0aGVuIHRoZSB2YjIgY29yZSB3aWxsIGFs
cmVhZHkgdGFrZSBjYXJlIG9mIGVuc3VyaW5nDQo+ID4+IHRoYXQgdGhlIGJ1Zl9jb3VudCBpcyBh
ZGp1c3RlZC4NCj4gPj4NCj4gPj4gSWYgeW91ICpkbyogaGF2ZSB0byBkbyB0aGlzIG1hbnVhbGx5
LCB0aGVuIHlvdSBuZWVkIHRvIHBsYWNlIHRoZQ0KPiA+PiB3aG9sZSBpZi1lbHNlIHVuZGVyICdp
ZiAoISpudW1fcGxhbmVzKSB7Jywgb3RoZXJ3aXNlIGl0IHdpbGwgbWVzcyB1cA0KPiA+PiB0aGUg
VklESU9DX0NSRUFURV9CVUZTIGlvY3RsLiBTZWUgdGhlIHF1ZXVlX3NldHVwIGluDQo+ID4+IGlu
Y2x1ZGUvbWVkaWEvdmlkZW9idWYyLWNvcmUuaCBkb2N1bWVudGF0aW9uIGZvciB0aGUgc29yZGlk
IGRldGFpbHMuDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+DQo+ID4+ICAgICAgICAgSGFucw0K
PiA+Pg0KPiA+DQo+ID4gSGkgSGFucywNCj4gPiAgICAgSSB3YW50IHRvIG1ha2UgdGhlIHZwdSBz
dGFydCB3aGVuIDEgZnJhbWVzIGlzIHF1ZXVlZCwgc28gSSBzZXQgdGhlDQo+IG1pbl9idWZmZXJz
X25lZWRlZCB0byAxLg0KPiA+IEFuZCB0aGUgbWluX2J1ZmZlcl9jYXAgbWF5IGJlIGNoYW5nZWQg
d2hlbiBhIHNvdXJjZSBjaGFuZ2UgZXZlbnQgaXMNCj4gdHJpZ2dlcmVkLiBTbyBpbiBtb3N0IGNh
c2UsIGl0IHdpbGwgYmUgbGFyZ2VyIHRoYW4gMi4NCj4gDQo+IEFoLCBJIG9ubHkgZ3JlcHBlZCBm
b3IgbWluX2J1ZmZlcl9vdXQsIG5vdCBfY2FwLCBzbyBJIG1pc3NlZCB0aGF0IHRoYXQgb25lIGlz
bid0DQo+IGNvbnN0YW50Lg0KPiANCj4gPiAgICAgSSdsbCBtYWtlIGEgdjIgcGF0Y2ggdGhhdCBw
bGFjZSB0aGUgd2hvbGUgaWYtZWxzZSB1bmRlciAnaWYgKCEqbnVtX3BsYW5lcykNCj4geycNCj4N
CkhpIEhhbnMsDQogICAgSSBzZW5kIGEgdjIgcGF0Y2guIA0KCUJ1dCBJIHRoaW5rIHRoZSB2MSBp
cyBPSywgYXMgdGhlIGZ1bGwgY29kZSBoYXMgYWxyZWFkeSBndWFyYW50ZWVkIHRoZSBjb25kaXRp
b24gYCBpZiAoISpudW1fcGxhbmVzKWAsDQoNCglpZiAoKnBsYW5lX2NvdW50KSB7DQoJCS4uLiAu
Li4NCgkJcmV0dXJuIDA7DQogICAgfQ0KIAlpZiAoVjRMMl9UWVBFX0lTX09VVFBVVCh2cS0+dHlw
ZSkpDQoJCSpidWZfY291bnQgPSBtYXhfdCh1bnNpZ25lZCBpbnQsICpidWZfY291bnQsIGluc3Qt
Pm1pbl9idWZmZXJfb3V0KTsNCgllbHNlDQoJCSpidWZfY291bnQgPSBtYXhfdCh1bnNpZ25lZCBp
bnQsICpidWZfY291bnQsIGluc3QtPm1pbl9idWZmZXJfY2FwKTsNCg0KTWluZw0KDQo+IEdyZWF0
LCB0aGFuayB5b3UhDQo+IA0KPiAgICAgICAgIEhhbnMNCj4gDQo+ID4gICAgIFRoYW5rcyBmb3Ig
eW91ciByZW1pbmRlcg0KPiA+DQo+ID4gTWluZw0KPiA+DQo+ID4+PiAgICAgICAqcGxhbmVfY291
bnQgPSBjdXJfZm10LT5udW1fcGxhbmVzOw0KPiA+Pj4gICAgICAgZm9yIChpID0gMDsgaSA8IGN1
cl9mbXQtPm51bV9wbGFuZXM7IGkrKykNCj4gPj4+ICAgICAgICAgICAgICAgcHNpemVbaV0gPSBj
dXJfZm10LT5zaXplaW1hZ2VbaV07DQo+ID4NCg0K
