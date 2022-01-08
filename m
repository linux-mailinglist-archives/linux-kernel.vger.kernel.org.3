Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3CD4885FD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiAHUsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:48:11 -0500
Received: from mail-db8eur05on2124.outbound.protection.outlook.com ([40.107.20.124]:1633
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232838AbiAHUsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:48:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh0EGhC6b49gea+57GZymtBH8SoIhn5utqQv3M/kNTNGsJ8b1+FlAdxvRO65XkeiorrVNqDljj3qiqi7Jj/Rjvr3FjHFuFZ5qSbREO17eNvC56tOx7WAMkYremXU0kYp/u419k5JmSdkU/0eoHqb4TKPozBTFoylMYlhFptG8iy2vNzAzTkmV1R0X19kzgHR3TwAkEBHp5HbB7EezxiuLklEjo9mocoH+u/+nticymgFJVLUHn/Ir/Fq5JXgcZnHJHhnWdYaNh9maFRnJa0ZI5jBU0ynxE2Bnfm8S6tt6lnQkKpsTKab1z2JzJd1Mx1mMONGQGNb0DUhXitjkdKH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qlkw7xq7FN8aZFiPXwN2F9WZxHtD3vlK4CXvNHRRBg=;
 b=Qj25K/NK6SxDlY0LkViu+HMDR84FuG1V3L8Xd9WSQ4YTTIkri37Pb20seE7JWYv1u1ltonrzPecTVwL0vpNQEaiRw9ZTYgBihdMIY93W5y2hhhlma2iucbvJr/U9a5G8LjOqHKEXduu57ZQ9PHi/1eTgotW0F2xI3RFTZ5CsDhsaqOS8yaCJj54JdHVpZAHGzOHm6qrrvHwTMMgl1vqEcrq1QOgoTEIL/o7AvGmgdaonQvedEXz/P+SUZKTCfvUSvcN9RyL5Xsx784qEG6OPRFve2s3bcmZlOnfTbzGOTwQdKzw0rPhYYAjr7g8u12Nte6kM6/VfUSTTCUhT+CMNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Qlkw7xq7FN8aZFiPXwN2F9WZxHtD3vlK4CXvNHRRBg=;
 b=ntQhcZJ0jEYtMo7UG9Y4z/dyBtqnsVGfIuQnO9hC+SlVzAkcwb1zUDV8j7/OQK24gPEEGwlFNHECBnne5OjdGD4CLX+BRuio4iMGXMlpB36o3aRYjbNAAOWmzxjQv3IetRUj5IjB/7sBpejewNmk1aizTa9UD/Lz/262L6+ofKw=
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com (2603:10a6:20b:37::25)
 by AS8PR06MB8149.eurprd06.prod.outlook.com (2603:10a6:20b:3d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Sat, 8 Jan
 2022 20:48:03 +0000
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::8cee:862c:c31b:fa97]) by AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::8cee:862c:c31b:fa97%6]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 20:48:03 +0000
From:   ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "alice.guo@nxp.com" <alice.guo@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "marex@denx.de" <marex@denx.de>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: RE: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam
 jr
Thread-Topic: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam
 jr
Thread-Index: AQHX676SBO3pDQeWRkCE6ZrH5/CEf6xWCQMAgAAYObCAAV4TAIAAB1fggAAc0QCAAicakA==
Date:   Sat, 8 Jan 2022 20:48:03 +0000
Message-ID: <AM6PR06MB4691D4FCA4D82284E70A9F53A64E9@AM6PR06MB4691.eurprd06.prod.outlook.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
         <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
         <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
         <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
         <AM6PR06MB46919E01996D1F1DE326306DA64D9@AM6PR06MB4691.eurprd06.prod.outlook.com>
 <b5e37dc573f9cefc83f73f1113a632a29ba9a833.camel@pengutronix.de>
In-Reply-To: <b5e37dc573f9cefc83f73f1113a632a29ba9a833.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35d85a73-3045-467c-6867-08d9d2e82a7b
x-ms-traffictypediagnostic: AS8PR06MB8149:EE_
x-microsoft-antispam-prvs: <AS8PR06MB814961D22D4CC6F05D222D1AA64E9@AS8PR06MB8149.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdQOH5RDSMronN9Vd1ELxzKI85i1kbdM83/ttrDuiVU9RHGudP/abJEf4yNRE2UVi5LEDdNQaQyyN4H+P2WNC9xI7UqBZMR4xlQC0eNR4iNIGeMiOLIcIex4Hmgz07f69z9h49/WF9VtppFF/m/bbYZrzBqWYI0enNvcmpI5xwuW/BWupDKeCHgmzOyVNAA2r07svoH5BG4b2Zitjhl68qImbzkDoIV8nAd52dibkbAbiU/O5Iof3teCBm2SO2m9ucA0izpZ1vyxz7qMWVGsez+MGRxDGwOtya2YCM0h/41RRJ4fBlMlrpUm915WUrZS9B8q7KIikMzygaIYyUGxbF0CXeTN7VNvTbAtFzLnDyDqLQa1+78GGF+WofMlk0qOOHBEoRydg9MwLinoRAtry6ICnNEV3rIQil4GoOZhgckA4rhYRnq0rewojLSz54M7XeY69GuHlVh2NZEqEkT/iK5mAVL6ISmyH2dft714Wsfx28qsDr9CqlJpu0CpFDMMAc6FUYf1na3sKCvAFFWxE9nLTumSInt+Hv608adzpEpWyjZu7ZlZ+vMYoc0IuUHvJvXvMn6sD53b1CdwBMeF1WfG631IL7/+LxdrMT12iNRzcWxJNmCcWNcQt4g1t80cxxlkYhUuuOMOP7rQnDu7HaXS8l+5xI1UmXnOKvAOAT3VucGNg98f0RFdyEC/AQtkeFbbQlhuOQ9uq37FasoctfJk4pTxnXIzFToax6jWJGxX/jyzKCnzsAivJqZHkoMMk6MnrIcHeGcZC1AGTaX/UgbBQph6GsnWJMp0h3mMdd3ZUOL94aq1SzXGxrGlW3TV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4691.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(66476007)(966005)(7696005)(26005)(33656002)(186003)(8936002)(7406005)(54906003)(110136005)(316002)(38100700002)(86362001)(83380400001)(55016003)(4326008)(5660300002)(508600001)(9686003)(66446008)(52536014)(2906002)(6506007)(71200400001)(66946007)(66556008)(76116006)(7416002)(38070700005)(8676002)(64756008)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0RoejBoTXM2R09wdnM3UWxNYXQ2UE54MTJrWDhqUWIvUzhUZDBBNGwyT1Rr?=
 =?utf-8?B?a2xVUmw2UXpKVndTRlJTWE4rc3dVdDAvU0hOWm0zS25VWjc5UklNOWlLcVhz?=
 =?utf-8?B?TnZxam5ESi95cFR2d1dta2ZqeE02YzNOWEhLL3ppV1JNWDhLQS9zMHpoVTFj?=
 =?utf-8?B?Q0lpazUrQWhDUFhxRnhvQVJtZmFWeGFRSWx2d0xDS2VVOFdQM3dDREFGVjlT?=
 =?utf-8?B?d2RlaUpoMzh1KzlCZjg1TG1TT3V5N21KaHpMVGRYdXRWUzUrSW8veWkvUEV3?=
 =?utf-8?B?U3E2NURyWkFxRkZhKzZyRVlqUmUxVW1rVzR0SjJLWkhvR1dsRzM4dzg1d29n?=
 =?utf-8?B?TGVUSTJYRzYrazVPKzUwZ25EYUVLYkhNR1NUOU84UVBGSmxlM2ZZSXNVT1JR?=
 =?utf-8?B?MDdsUXRpSDJkZ1ZMc3I4UEZsTHZjc1I0K1dwNlAwYzFKYXR6U2Q3NnlCYis0?=
 =?utf-8?B?RDdONFhSZmp4VUhWbDhEbm9zTkJuUWdZd2MzWDhnNEVqTUNJOUEyM1VKSTh5?=
 =?utf-8?B?SThXTFpZSGVxdllkd1hVS2g2NEE1ZWt5a2pPM0ZZdUhJc3hUL3J5UHg5Ri9G?=
 =?utf-8?B?aXFDbngwVFFtSVh5bXgrdGo1L2Y1Y3lVdWRNZ1pqK25EWkNoLzVJZkIrWWMw?=
 =?utf-8?B?Uzh0UzNxQndxUm5iajRNUm1Mc2VEWEdzMURpbXV5NFN1ZTk5eWdnZ09uRCs2?=
 =?utf-8?B?NUdTMmhKaHBsalIyQSs4V2NvOXNBbWNhZWN1NitocGU0MmRaVEdtdkpKMDhK?=
 =?utf-8?B?Vkg1QnJ3cXI1ZG1rcHJTckloOGFEa3ZpeEc4OEh1VExVQk56TVpjWGZVdG8y?=
 =?utf-8?B?cGRURnRSQnNaU0N0bjFGYnEzSVY0UU1hTWcxcmVRcmI3TXh0cFZuRU1QTUd4?=
 =?utf-8?B?M0FmWUJ1V2ZUeDlncGtwb0t6NXNFTzRwMVYwbTVwaXNEVkJoNEtJRmxlWDRY?=
 =?utf-8?B?L21RaUNHVTByT3dINDZYQm55SFM0NnJMdlpQSVY4Sjk5bFV3c3EzTDFVZWZJ?=
 =?utf-8?B?QzhmSnBPeU5FM1JrUU52S2NRbFZCL1hkUzUyRTZ3ZkZocTIxbTZPN1dqWFpq?=
 =?utf-8?B?S2VvNDVOYmRJYXYrYVhFYnhzZDZSdjA0SlBRekJaZEY2WmZDZlhCUUVscXY2?=
 =?utf-8?B?V2N3S2R4K21HWjZJUEYzd1J0UDFYc1p4QXZFYi9zZ2tUdzl1TGJtVHBBWlp3?=
 =?utf-8?B?dUhRdGUxNUFnRXluL0JIdmR2dE5UT1VRZ002V2VoMXl0eGJiSUhRd3RhcGR3?=
 =?utf-8?B?NzZwbk1XSmlJUm0xTFZtclRMb0tVeVplN0lPcTFQdURQcXlNZHVXd1hUaFE1?=
 =?utf-8?B?R0QwTGJYRWdzR1JNdXFONE9wVmtYUTdqOVdDRXpPRytXU2I5NmhzZ1N5cmlK?=
 =?utf-8?B?YXBFVThuVWQ3aUdNYUx1ZkphWmdIcHF1K0ZiMmRKaEFhczBOaVh0d04xdy9R?=
 =?utf-8?B?UTNDaTZ3ekxtL1FqeHlEM1c0N2lXSCtmajhLRHdnOGJkOHdkTjdYblpqSU5y?=
 =?utf-8?B?aEV2ME1wREZhSUQrOWdncUVZTUZaNnMwUW1pc2ZmSldoWWttbGxOQ2prbTB0?=
 =?utf-8?B?eXo1cC9OVitUT05uOWdVa3F0RjFIR2hTYXNweDZrcDRHb1YyTWtXQ05XNjNx?=
 =?utf-8?B?MVZtaHN4Q3NmbmlLUW9ORzFJUzFseXhVeDJlR0xpK3Z6RmluREo4UXdubUsx?=
 =?utf-8?B?N3FJT3MrMlkvWkkxbjlHT2tkbzF4ajJjUm5OQ2F2UkZkSlhseFQzYk9ueGJS?=
 =?utf-8?B?U3hONEp0Z3hvOUVTNWovYzY1UTJ2dDQ3Z0pXc3hoS2dHdlYvMW85Q2dXbmln?=
 =?utf-8?B?THJMbVNaQ3NUcno3OG82aUJxNTJKc1FPL2Z4b1lwdWMwd0tScW1uR09GR0pL?=
 =?utf-8?B?K1N4NGg0Z3hzSXdkejJaR2EyMDVMbXZzd0NhV2RwcitZNEFNVGNyaWxlS1A3?=
 =?utf-8?B?OHN5WUpPTkFXOFFRbFFrRlF4aVNTbDNRRW83WGlQekdiSEYzOC9UazVobFQy?=
 =?utf-8?B?dytOaWUyNzJVRlNtSlpEM3JucWd5ZGErVVdhKzlTbHlLSDkvTjdkR1BzUlFv?=
 =?utf-8?B?WElPRkVhSzRQREhhQ3ZFa2tHeHFZYTJVRnpVVDJYUTcwelNXeGlCcTExZ2xG?=
 =?utf-8?B?NHpmM1AxdUpxSFRYTXRlRHVXNGgrR29zenpaU3RKWE9OdUQ5RGFsc3ljTlhZ?=
 =?utf-8?B?TElwcWNxS2lNdHU4YnFIR0pXRDZCVEw3c0M3ekdVbjQ3MXRtU1VGTHhGbzdO?=
 =?utf-8?B?em1zZ2NYcU5UTXFoVyt1UjlSZDZub2xET0htZFBQbkp6RDJZTlBGajFGM2gx?=
 =?utf-8?Q?gOTsg6wuDx+Tq6AfpX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4691.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d85a73-3045-467c-6867-08d9d2e82a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2022 20:48:03.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkDzPeH32kUuf01wJWXTn4aVcmQE62ZJUocUz+9GbKmNQYk3VHjiCsIaYWdpZzJxo+jcTamo68vOvcQb2r+JD5fXuui3dlCCPAt3n4coS5ecwxNlvkMoVLwQ2hm/pPaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUm91dmVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJv
dXZlbiBDemVyd2luc2tpIDxyLmN6ZXJ3aW5za2lAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IEZy
aWRheSwgSmFudWFyeSA3LCAyMDIyIDEyOjU2IFBNDQoNCltzbmlwXQ0KDQo+IA0KPiBZZXMsIHVw
c3RyZWFtIFRGLUEgZG9lcyBub3QgaW1wbGVtZW50IHRoZSBOWFAgc3BlY2lmaWMgU0lQcyB0bw0K
PiBjb21tdW5pY2F0ZSB3aXRoIHRoZSBST00gY29kZSB0byBkbyBmdXJ0aGVyIGltYWdlIGF1dGhl
bnRpY2F0aW9uLg0KPiBUaGF0cyBhbHNvIHRoZSByZWFzb24gd2h5IGFsbCBKUnMgYXJlIHJlbGVh
c2VkIHRvIG5vcm1hbCB3b3JsZCwgdGhlcmUNCj4gaXMgbm8gcG9zc2libGUgSEFCIHVzZSBhZnRl
ciBURi1BIGhhcyBzdGFydGVkLg0KPiANCj4gPiBJJ3ZlIGJlZW4gZm9sbG93aW5nIHRoZSBidWls
ZCBkb2N1bWVudGF0aW9uIGluIFUtQm9vdCwgd2hlcmUgdGhlIGRvd25zdHJlYW0NCj4gPiBURi1B
IGlzIGxpc3RlZCBhcyBidWlsZCBwcmVxdWlzaXRlcyBbMl0gd2l0aG91dCBhbnkgbWVudGlvbmlu
ZyBvZiB1cHN0cmVhbSwNCj4gPiBoZW5jZSBJIHJlY2VpdmVkIGEgcmVhZG91dCB0aGF0IG1hdGNo
ZWQgdGhlIEJvb3RST00gIjEtdG8tMSIuDQo+IA0KPiBZZXMsIHNpbmNlIHRoZSBkb3duc3RyZWFt
IFRGLUEgaXMgcmVxdWlyZWQgdG8gYXV0aGVudGljYXRlIGZ1cnRoZXINCj4gaW1hZ2VzLg0KPiAN
Cj4gQXNpZGUgZnJvbSB0aGlzIHRoZSBib290cm9tIEhBQiBpbnRlcmZhY2Ugb24gaS5NWDhNUSB3
YXMgYnJva2VuIGluDQo+IGludGVyZXN0aW5nIHdheXMsIEkgaGFkIHRvIGltcGxlbWVudCBwYXJz
aW5nIG9mIHRoZSBIQUIgc3RhdHVzIFNSQU0NCj4gYXJlYSBieSBoYW5kIHdpdGhpbiBiYXJlYm94
Lg0KPiANCj4gPiBJIGJlbGlldmUgdGhhdCBpZiB0aGUgaW5mb3JtYXRpb24gZnJvbSBOWFAgcmVn
YXJkaW5nIEpSMCByZXNlcnZhdGlvbiBmb3INCj4gPiBIQUIgaXMgY29ycmVjdCAoYW5kIEkgaGF2
ZSBubyByZWFzb25zIHRvIGRvdWJ0IGl0KSwgdGhlbiB1cHN0cmVhbSBURi1BDQo+ID4gc2hvdWxk
IGJlIGFkYXB0ZWQgaW4gb3JkZXIgZm9yIEhBQiBmZWF0dXJlIHRvIHdvcmssIGFuZCBpbiB0aGF0
IGNhc2UgdGhpcw0KPiA+IHBhdGNoIGJyaW5ncyBjb3JyZWN0IEhXIHN0YXRlIGRlc2NyaXB0aW9u
IGFzIHNlZWluZyBmcm9tIExpbnV4Lg0KPiANCj4gSlIwIGZvciBIQUIgaW4gUy1Xb3JsZCBtYWtl
cyBzZW5zZSB0byBtZSwgb3RoZXJ3aXNlIHRoZSBib290cm9tIHdpbGwNCj4gcHJvYmFibHkgcmVm
dXNlIHRvIHdvcmsgd2l0aCB0aGUgSlIuDQo+IA0KPiA+IEFuZCBpbiBjb250cmFyeSwgaWYgdGhl
IHVwc3RyZWFtIFRGLUEgaXMgbm90IGFkanVzdGVkIHRvIGluY2x1ZGUgSEFCDQo+ID4gc3VwcG9y
dCAtIHRoZW4gYXBwbHlpbmcgdGhpcyBwYXRjaCB3b3VsZCBlZmZlY3RpdmVseSBqdXN0ICJyZW1v
dmUiIG9uZQ0KPiA+IEpSIGRldmljZSwgc3RpbGwga2VlcGluZyAyIGFkZGl0aW9uYWwgYXZhaWxh
YmxlIG5vZGVzIGZvciBIVyBjcnlwdG8NCj4gPiBvcGVyYXRpb25zIGluIEtlcm5lbCwgd2l0aCBh
ZGRlZCBiZW5lZml0IHRoYXQgYm90aCB1cHN0cmVhbSBhbmQNCj4gPiBkb3duc3RyZWFtIFRGLUEg
Y2FuIGJlIHVzZWQgZHVyaW5nIHRoZSBib290IHdpdGhvdXQgc2VlaW5nIGlzc3VlcyBsYXRlcg0K
PiA+IGluIHRoZSBLZXJuZWwuDQo+IA0KPiBFdmVuIHdpdGggdGhlIGRvd25zdHJlYW0gVEYtQSB0
aGVyZSBpcyBubyByZWFzb24gdG8ga2VlcCBKUjAgYXNpZ25lZCB0bw0KPiB0aGUgc2VjdXJlIHdv
cmxkLCB1bmxlc3MgeW91IGFyZSBydW5uaW5nIE9QLVRFRS4gSlIwIGFzc2lnbmVtZW50IGZvcg0K
PiBIQUIgc2hvdWxkbid0IGJlIHJlcXVpcmVkIGFmdGVyIHRoZSBib290bG9hZGVyIGhhcyBydW4s
IHVubGVzcyB5b3Ugd2FudA0KPiB0byBIQUIgYXV0aGVudGljYXRlIGltYWdlcyBmcm9tIGEgcnVu
bmluZyBMaW51eCBrZXJuZWwuDQoNClRoZW4gdGhpcyBwcm9iYWJseSBzaG91bGQgYmUgY29tbXVu
aWNhdGVkIGluIFUtQm9vdCBhcyB0aGVyZSBpcyBhDQpwYXRjaHNldCBwcm9wb3NlZCBpbiBVLUJv
b3QsIGFuZCBvbmUgb2YgdGhlIHBhdGNoZXMgaW4gdGhhdCBzZXJpZXMgWzFdDQpkaXNhYmxlZCBK
UjAgYXMgd2VsbC4gT25jZSBtZXJnZWQgLSB0aGUgSlIwIGlzIG5vdCBnb2luZyB0byBiZSBhdmFp
bGFibGUNCmZvciBMaW51eCwgcmVnYXJkbGVzcyBvZiB0aGUgZmFjdCB0aGF0IFRGLUEgd291bGQg
c2V0IERJRHMgdG8gMHgxLg0KDQo+IA0KPiBUaGUgcmVhc29uIE5YUCBoYXJkY29kZXMgdGhlIGNv
bmZpZ3VyYXRpb24gZG93bnN0cmVhbSBpcyBvZiBjb3Vyc2UgdG8NCj4gc3VwcG9ydCBIQUIgJiBP
UC1URUUsIGJ1dCB0aGlzIGlzIHN0aWxsIG5vdCBhIHJlYXNvbiB0byBoYXJkY29kZSB0aGlzDQo+
IGFzc2lnbmVtZW50IGludG8gdGhlIGtlcm5lbCBkZXZpY2UgdHJlZS4gVGhleSBwcm9iYWJseSBh
bHNvIGhhcmRjb2RlIGl0DQo+IGluIHRoZWlyIGRvd25zdHJlYW0ga2VybmVsIHZlcnNpb25zLg0K
DQpBY3R1YWxseSwgSSd2ZSBjaGVja2VkIHRoZSBkb3duc3RyZWFtIE5YUCBLZXJuZWwgdmVyc2lv
biwgYW5kIG5vbmUgb2YNCnRoZSBKb2IgUmluZyBub2RlcyAoaW5jbHVkaW5nIEpSMCkgYXJlIGRp
c2FibGVkIHRoZXJlLg0KDQo+IA0KPiBJIGNhbiB1bmRlcnN0YW5kIHRoYXQgaXQgc2VlbXMgZWFz
aWVyIHRvIGhhcmRjb2RlIHRoaXMgaW4gdGhlIGtlcm5lbCwNCj4gYnV0IGFzIEkgc2FpZCBiZWZv
cmUsIGlmIHlvdSBhcmUgcnVubmluZyBPUC1URUUgeW91IG5lZWQgdG8gYWRqdXN0IHRoZQ0KPiBE
VCBhbnl3YXkgc2luY2Ugbm9kZXMgbmVlZCB0byBiZSBhZGRlZCBhbmQgeW91IG1pZ2h0IGFzIHdl
bGwgYWRqdXN0IHRoZQ0KPiBqb2JyaW5nIGNvbmZpZ3VyYXRpb24gdGhhbi4NCg0KTXkgZmlyc3Qg
dmVyc2lvbiBvZiB0aGlzIHBhdGNoIGhhcyBiZWVuIHRhcmdldGluZyBkeW5hbWljIHJlZ2lzdGVy
DQpyZWFkb3V0IHRvIGNoZWNrIGlmIERJRCBpcyBzZXQgZm9yIGVpdGhlciBTIG9yIE5TIFdvcmxk
cywgYnV0IHRoYXQgd2FzDQpyZWplY3RlZCBkdWUgdG8gdW5yZWxpYWJsZSByZWFkb3V0IGluIEhX
LiBIZW5jZSB0aGlzIGF0dGVtcHQgdG8NCnN0YXRpY2FsbHkgZGlzYWJsZSBub2RlIHdhcyBtYWRl
Lg0KDQpQbGVhc2Ugbm90ZSwgdGhhdCB0aGVyZSBhcmUgY29tYmluYXRpb25zIG91dCB0aGVyZSB3
aGljaCBkbyBoYXZlIEhBQiwNClRGLUEgYnV0IG5vIE9QLVRFRS4gSW4gdGhhdCBjYXNlIHBhdGNo
aW5nIERUIGlzIG5vdCBhbiBvcHRpb24sIGFuZA0Kd291bGQgY2F1c2UgdGhlIHByb2JpbmcgZXJy
b3IgYXQgYm9vdC4NCg0KRnJhbmtseSBzcGVha2luZywgSSdtIG5vdCBzdXJlIGhvdyB0byBwcm9j
ZWVkIHdpdGggdGhpcyBmdXJ0aGVyLi4uDQoNCkNsZWFybHksIHRoZXJlIGlzIGFuIGlzc3VlIHRo
YXQgSlIgZGV2aWNlcyBhcmUgbm90IGF2YWlsYWJsZSBpbiBjZXJ0YWluDQpjb21iaW5hdGlvbiBv
ZiBTVyBlbnRpdGllcyB0aGF0IGFyZSBzZXR0aW5nIGRpZmZlcmVudCBwZXJtaXNzaW9ucyBvbiBK
UjoNCnVwc3RyZWFtIFRGLUEgZG9lcyBub3QgZG8gYW55IHJlc2VydmF0aW9uIGJ1dCBkb2VzIG5v
dCBzdXBwb3J0IEhBQiAoYW5kDQp0aGlzIGlzIGFsaWduZWQgd2l0aCBjdXJyZW50IERUIG5vZGVz
IGRlc2NyaXB0aW9uKTsgZG93bnN0cmVhbSBURi1BIGRvZXMNCnBlcmZvcm0gcmVzZXJ2YXRpb24g
YW5kIHN1cHBvcnQgSEFCLCBidXQgZG9lcyBub3QgcmVsZWFzZSBKUjAgdG8gTlMtV29ybGQNCmNh
dXNpbmcgZXJyb3Igb24gdGhlIGJvb3QgYXQgSlIgcHJvYmluZy4gU2luY2UgdGhvc2UgMiBjb21i
aW5hdGlvbnMgYXJlDQpvcnRob2dvbmFsIC0gdGhlIG9ubHkgc29sdXRpb24gdGhhdCBJIHNlZSAo
aW5jbHVkaW5nIHRoZSBwYXRjaCBwcm9wb3NlZA0KaW4gVS1Cb290IE1MKSBpcyB0byByZXNlcnZl
IHRoZSBKUjAgZm9yIGFsbCBjb21iaW5hdGlvbnMsIGxvb3NpbmcgaXQgaW4NCkxpbnV4IGJ1dCBj
b3ZlcmluZyBib3RoIFRGLUEgKEhBQiBhbmQgbm9uLUhBQikgYXQgdGhlIHNhbWUgdGltZS4NCg0K
SWYgeW91IGhhdmUgYW55IG90aGVyIHN1Z2dlc3Rpb25zIGhlcmUgLSBJJ20gZnVsbHkgb3BlbmVk
IHRvIHJlY2VpdmUgdGhvc2UhDQoNCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gUm91dmVuDQo+IA0K
PiANCg0KUmVnYXJkcywNCkFuZHJleQ0KDQpMaW5rOiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3UtYm9vdC8yMDIxMTIwNzA3NDEyOS4xMDk1NS0zLWdhdXJhdi5qYWluQG54cC5jb20vDQo=
