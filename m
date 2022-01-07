Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65514875CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiAGKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:40:23 -0500
Received: from mail-db8eur05on2125.outbound.protection.outlook.com ([40.107.20.125]:9440
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236660AbiAGKkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:40:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfOb4q4x/se2kqZnuSQtvg9BfIuhUo1f0A2qfBFdM5SzJSxrURr6RBPyghoJDCTyEk7GNCUWCaPjItlnSu7vS2HWH/iwT47qjznSfHCPfewo6WEAw92aM+F9JyMKPvVN7v/isyev7VGvToqhZqLdRfU6arZoXjQCHCVTaY0dcwL4RnLXRmwsG4bSy4Lmk2A0cgxaTB4UU44aY9oEo8c/TStjCWgezXpLqwOxUzgFSBP62LBnsTAtcjHzRINpuBcBneuyGKOHeG9euPAPobrS1YxEF80vsGr0iny5flOWtF5rEFeAacCOzcIqV7U6/2KhVMCv9WokKLqWTVu/kNafdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNyWTVWeP1Ngn4LRElwX+cWt5o0/DcRDdujpylFaAg8=;
 b=QxKA8u//lQTIdfuUuoEMci/ZFCAxEfS+3yNlq1+v1RJuSajrCjfHDxH7W4FYFEs7yjoyHYsojrukuPyv0AN2ZtRHqRhVGrSwlZ4o5oFiLH5XAFqCblPwu3AtMIpFf/MjW9VHxSyiNP1NR2walQrg7zV35FkUj5iHuLQnHisy4LjhHnCBJ98a5W1AsiBA9vwGcfzmiPpGhQGLN9oXvoCRkhikz68HS14jlUZXbVOTW/1Kb0ut9zGtc29zWxAQvU+899IMOl77Kw6h0F86O+LyEx31fd1np4j3AD4pHIz1HZUpOtRb/pf9QSxCaHzfC41xFoHNZtBRH0WI1EPGhrGwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNyWTVWeP1Ngn4LRElwX+cWt5o0/DcRDdujpylFaAg8=;
 b=Ptktssb4Nig57Hhb7bgIDMXs9kOoYB9ihmOvOEZFfqTqREk/ZjG8myVApCwTlO+wlh23JwKwh5qcR21M05fZYCgKMcDvdekS/WoF2dgyD5z8bpy3f/dedzwab9PLSXjo6ZzOpzEGvQEUzh5zsC26L8a+/Icx+yPicgZrH5cHhaQ=
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com (2603:10a6:20b:37::25)
 by AM6PR06MB4998.eurprd06.prod.outlook.com (2603:10a6:20b:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 10:40:18 +0000
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::8cee:862c:c31b:fa97]) by AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::8cee:862c:c31b:fa97%6]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 10:40:16 +0000
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
Thread-Index: AQHX676SBO3pDQeWRkCE6ZrH5/CEf6xWCQMAgAAYObCAAV4TAIAAB1fg
Date:   Fri, 7 Jan 2022 10:40:16 +0000
Message-ID: <AM6PR06MB46919E01996D1F1DE326306DA64D9@AM6PR06MB4691.eurprd06.prod.outlook.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
         <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
         <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
 <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
In-Reply-To: <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 107d48a1-3dfa-4045-1ddb-08d9d1ca1822
x-ms-traffictypediagnostic: AM6PR06MB4998:EE_
x-microsoft-antispam-prvs: <AM6PR06MB499817573D37223B1F76FA06A64D9@AM6PR06MB4998.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:313;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GRGBxXV+IEKWYQhWvS/HmyACrEG13JlPbjt818ONKlrBoCYMg6zdIq0JOU0lizZhxipZjsn7zSJX1R07viFrua/6OER3PEpzRpkRcBjMR+KxuE+16iPDrpItPF0t40Iy+nMRN9+0P4K9gPGU6k7+3x9KzhnfcKuemg4JlMDfrWQNhjaBC6mQ7bX1ipS2Ghgq8voHzm2Zlh2Rxp2rel25SE8s4U+h6UN/GuOtO9PQu8gUEIyrnOaqjwJV5NFKCno4xkxqdX1esioQtAc80r26Pa7o0WsjqPeqvtZOZGEAhjNUni3wo/RW2JPxdGRJb1KAafrhdwablHnDN2kamsH3JgbI6xnhsu7iyGK4RkELLQFOq92VXDz0TOT/Yb8v/6iu3/nzfoT54/bCwrbxcHMZEOj1BtDrWNeRasXVfYpd6ot2hU1NO7Pihq7fXLrG+l+IQdDEPgprS97gaAzvBHVK4/DvScM6lbjuz6tb3eqNFhcGWm0bu46bFPHcCZ393JQ9PnB4/zwOSj1kM89acoeYZ+s/0wBLOCdZXzXSm/cCiwD7HiTS4gNJVJFBQofB07UXMGyVLfIPZQ+dr2ZzxH3uAqMTBufpMrnamw7pQdV9j9w0X2yaL9VG0rotYWp4AaDpkcmwyzIvuDxYCSKbb0ThvkV5xLuLo9QkUAOrPXtT/LcOPEi27UztWchWekbcxrVUpIsj+EbHnv+KtisMLXydERwFtQ+8lFu3BA3uCz18nvOa3uvuMnKIdT+ORvuF+oBOqYx0PmbtU/mQ0bEWQ00yhpOJxnkgA5ztjJUbuZOocQghOnwP6xIF7gcp+UIzdbKv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4691.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(2906002)(26005)(186003)(76116006)(86362001)(53546011)(45080400002)(9686003)(52536014)(966005)(4326008)(508600001)(54906003)(110136005)(55016003)(33656002)(64756008)(66446008)(66476007)(66556008)(8676002)(38100700002)(7416002)(7406005)(122000001)(7696005)(316002)(38070700005)(5660300002)(83380400001)(8936002)(6506007)(66946007)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVFoUm1Tbi9zNkpzbGl6bWRPOGRJbm9NMVFIV1RPc1IvWFZKcEpoZ1FyTVVW?=
 =?utf-8?B?UXNTYWJLMzFjN3RJRFBnamkrVFdySmpWZG9UOGdFRTZOZjVTbkNmSXBwdVhi?=
 =?utf-8?B?U3JaWjdlemFrZUR0NEhhQ2d2clRveTB4U05EbzdRaVlYaGtOV2hrK0RWay9n?=
 =?utf-8?B?WllJcW4zZm1tRjNkYysvTnFTV000RzdUdW5yUTVTcXlsNkRNTEZNK3dUVzU5?=
 =?utf-8?B?MlNyTDdwd2Rtanc1MktVWERpcnF3L1RLWHhzWWZSQVJod2hyVFBVa3ljNlFk?=
 =?utf-8?B?UnFkMkhGcDlHaHREL1FRZ0oxQVFHMVFsWGtRREVWYkpyM3JFTndLTzQxdlhU?=
 =?utf-8?B?K1ZBRDBQYlFMN3ZmclZORWVya0dqWk4wU3o3VzNFQ3Q2TFNYV2ZiZ0NSeDhi?=
 =?utf-8?B?bVJqanRWanBoYnhNUmtRYW52NlVVbjd1dEpJOWE3aGdoYlFQUFJGY3lRS2Jw?=
 =?utf-8?B?d2lHRFcvNXdUWmdxU3h5Q0pHUUNEakpjMnZrTVFCQXNUT3U5NmpySkw2ZlBp?=
 =?utf-8?B?b2VNd1pTa0QxZ2QxQXhKS0ZZVUpBSXNYNEZNalpYZG9iQjdpbHRsd3ErTTBP?=
 =?utf-8?B?OVI0OUY1STJ2QllVaDcxMjhVSUFianB5b0c3Mi8yOXEyUm9BVlZhUGFiYUtq?=
 =?utf-8?B?YTZJaFJFWkJ6NFFKMkFpOHlSOXJoajJEZGJsdVl4VHFKL0hDcHlFRzBiUWF0?=
 =?utf-8?B?bk9kNklBZkFOY2lFYko0VFB1eFhGNE84aTFsY2Eyb3g4WFRTOU5GUTBUV25T?=
 =?utf-8?B?RnVGVnUxTVFyUk1MWmZ5VUhsOHRqdFVkKzlZcHowWXhwL3BhSVFuTzlyUmRI?=
 =?utf-8?B?N05VclQ4dzMrL2U4T2dpK0Z4SjJYa1JCMHFncFhmeUhLRFFoUkZMdlNKdS9i?=
 =?utf-8?B?K1ZYSERsWGZXdVU5Y3VuSnA3NGdwYmlBbE81aVROTm5Dem5LL1luakhXRDYw?=
 =?utf-8?B?bzA3VUl3alNtSDA3Qk9wdTJlS3NsbEsrWDhNMEplSy9PSmY3dHF0SDJWL1p5?=
 =?utf-8?B?SWZrMEJkMkxDL0RvdHZxRkNlQXlaaXRrWUpXMWo3NUM5OUE2QndYNjY2SGFk?=
 =?utf-8?B?V3FmcUdkTUZHajdseFJabzZsTjJ5QnBMd1VTRllPY1ByWmJtWThrOGt4RHQy?=
 =?utf-8?B?QkNjMjdXRW8xdC9rdC81Lzh6L1l3cWxtSDM5MFR1c0VqZnMzMUcwL3ZTQ1Ra?=
 =?utf-8?B?Y053Y0RacnByNzVWNWVqcVdERVpyQzMvVEE4bllQazNHREpvdkNkMnhiVzRh?=
 =?utf-8?B?dXNZYk1EZ2R5RStuQlNhaGYwdHhINUFDdDgxTnh4NjVvZjM5aDg5Qm05czJN?=
 =?utf-8?B?RlI5akRJQ0Jyc2czaFZ0SUJmdk1GQUpjZm9LZ0lpK1h3anliVnJqN2JES2hi?=
 =?utf-8?B?UENDaiszdVgvSTZibjk1MzhDemxEU2dXeitvbjdRMVE4RVBpL2FIWU9DdnNB?=
 =?utf-8?B?VEpSWWtFbExJemdmaDZEVVgxak53dUd1ditMQXNRZzVCRXhIZ3NqV0xRZFhJ?=
 =?utf-8?B?ZWp0Z0JKRWtySU9MUit5UE5lMXFqVU9kNXBtYXFZVUNBR3hVQ01OcEVDczVt?=
 =?utf-8?B?ZGxNTXJnc1p0MmV2WVNyQmovOW8vemt2d2YwbzJlTHpBWUdVQ3UyNVVjU201?=
 =?utf-8?B?VDdYSm5ZYmtlQnBRMmd6bHZJeGFoeUZZYkh3Y0EzM0xVbjNxbEY3dVdvNzlI?=
 =?utf-8?B?NmRDWHNpbFN5Z2MyR2FscTdGNEpUMFp6ZlczWlBQYndkbWJ4aEVUMnlsWTda?=
 =?utf-8?B?RVFUbXowd01nRXJVaCtDeDhidDk3Z2hsOU1zdTliNENrTzVld3lqcExQZG9v?=
 =?utf-8?B?YkxscFhYUDB4V0F1b2YxYXJvcEhOU040NFhXUXk0MUZidnJBcGttRlN4VEtn?=
 =?utf-8?B?UTRWMHhpNG9kTEhrZjlmeGdxVWQzUDRCSitLcGJPTmI1M1drNmJmdThTTlQr?=
 =?utf-8?B?RklPSXlwN0JRM3J1cFZwSUlDblU5ZVJnWDduYmljS2VLbENiZ0V3cklqU3Zn?=
 =?utf-8?B?OGhaRE1sSHFON3ZTYWUzR0F3bExXYUpRWnVlQzFTaVVudStVcE1CVUpvcVFE?=
 =?utf-8?B?TG5Ua21neGEwd2dZOGNoRElLSFFBZy9QcEttVkxGRUdmcGVrY2JPVGhvOG9Q?=
 =?utf-8?B?cFEzQXBIcUNvUTQ4a2FaMndrY0dkODQ2UGZrTURhRm9ZYVQ4NGlvVVZna3lI?=
 =?utf-8?B?KzRaWkhtb0RTQTNGalRXK2p3MEc4OUYyQytKOFRURWZ1NVRwTTRMT0ZOWi84?=
 =?utf-8?B?L0RZM0VIN3JOY24wYVFQd2lZVDFPcnFlTm05VFpvaFBkRTJKWG56MTljZXJN?=
 =?utf-8?Q?YV0Fi1eBNDy1ZXO9jJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4691.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107d48a1-3dfa-4045-1ddb-08d9d1ca1822
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 10:40:16.6144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h76SwCxTxV+YU2gLV7uZF8lfwvInG6FZxBSURh0rr7dwm2UXwChcWKbwSo7vHJpwRbomTNtbyqQtj+BTm1FDHNfTRDIB5RecLDASG4WfiWxkCvwGPP/YqumVZfnQStvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUm91dmVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJv
dXZlbiBDemVyd2luc2tpIDxyLmN6ZXJ3aW5za2lAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IEZy
aWRheSwgSmFudWFyeSA3LCAyMDIyIDEwOjQ2IEFNDQo+IFRvOiBaSElaSElLSU4gQW5kcmV5IDxh
bmRyZXkuemhpemhpa2luQGxlaWNhLWdlb3N5c3RlbXMuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHBlbmcuZmFuQG54cC5jb207IHBpbmcuYmFpQG54cC5jb207
IGFsaWNlLmd1b0BueHAuY29tOyBhZ3hAc2lneGNwdS5vcmc7DQo+IGtyemtAa2VybmVsLm9yZzsg
bGVvbmFyZC5jcmVzdGV6QG54cC5jb207IGZlc3RldmFtQGdtYWlsLmNvbTsgbWFyZXhAZGVueC5k
ZTsNCj4gaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1OyBob3JpYS5nZWFudGFAbnhwLmNvbTsg
ZGFuaWVsLmJhbHV0YUBueHAuY29tOw0KPiBmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU7IGxp
bnV4LWlteEBueHAuY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gaG9uZ3hpbmcu
emh1QG54cC5jb207IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IHBhbmthai5ndXB0YUBueHAuY29t
Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tOyBtYXJ0
aW5rQHBvc3Rlby5kZTsNCj4gYWZvcmQxNzNAZ21haWwuY29tOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBzaGVuZ2pp
dS53YW5nQG54cC5jb207IHFpYW5ncWluZy56aGFuZ0BueHAuY29tOw0KPiBtaWNoYWVsQHdhbGxl
LmNjOyBvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZzsgbGludXgtY3J5cHRvQHZnZXIu
a2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBqdW4ubGlA
bnhwLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gYXJtNjQ6IGR0czogaW14OG06
IGRlZmluZSBwcm9wZXIgc3RhdHVzIGZvciBjYWFtIGpyDQo+IA0KPiANCj4gT24gVGh1LCAyMDIy
LTAxLTA2IGF0IDE0OjA4ICswMDAwLCBaSElaSElLSU4gQW5kcmV5IHdyb3RlOg0KPiA+IEhlbGxv
IFJvdXZlbiwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IFJvdXZlbiBDemVyd2luc2tpIDxyLmN6ZXJ3aW5za2lAcGVuZ3V0cm9uaXguZGU+DQo+ID4g
PiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA2LCAyMDIyIDEyOjI3IFBNDQo+ID4gPiBUbzogWkhJ
WkhJS0lOIEFuZHJleSA8YW5kcmV5LnpoaXpoaWtpbkBsZWljYS1nZW9zeXN0ZW1zLmNvbT47IGxp
bnV4LQ0KPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQ2M6IHBlbmcuZmFuQG54
cC5jb207IHBpbmcuYmFpQG54cC5jb207IGFsaWNlLmd1b0BueHAuY29tOyBhZ3hAc2lneGNwdS5v
cmc7DQo+ID4gPiBmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU7IGxlb25hcmQuY3Jlc3RlekBu
eHAuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBtYXJleEBkZW54LmRlOyBoZXJiZXJ0
QGdvbmRvci5hcGFuYS5vcmcuYXU7IGhvcmlhLmdlYW50YUBueHAuY29tOw0KPiA+ID4gYWZvcmQx
NzNAZ21haWwuY29tOyBrcnprQGtlcm5lbC5vcmc7IGxpbnV4LWlteEBueHAuY29tOw0KPiA+ID4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGhvbmd4aW5nLnpodUBueHAuY29tOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gcGFua2FqLmd1cHRhQG54cC5jb207IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgdGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb207DQo+ID4gPiBtYXJ0aW5rQHBvc3Rl
by5kZTsgZGFuaWVsLmJhbHV0YUBueHAuY29tOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiA+ID4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHNoZW5naml1
LndhbmdAbnhwLmNvbTsgcWlhbmdxaW5nLnpoYW5nQG54cC5jb207DQo+ID4gPiBtaWNoYWVsQHdh
bGxlLmNjOyBvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZzsgbGludXgtDQo+IGNyeXB0
b0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGp1bi5saUBu
eHAuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiA+
ID4gbC5zdGFjaEBwZW5ndXRyb25peC5kZQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAy
LzJdIGFybTY0OiBkdHM6IGlteDhtOiBkZWZpbmUgcHJvcGVyIHN0YXR1cyBmb3IgY2FhbQ0KPiBq
cg0KPiA+ID4NCj4gPiA+IEhpIEFuZHJleSwNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIDIwMjEtMTIt
MDggYXQgMDA6MDIgKzAxMDAsIEFuZHJleSBaaGl6aGlraW4gd3JvdGU6DQo+ID4gPiA+IENBQU0g
SlIgbm9kZXMgYXJlIGNvbmZpZ3VyZWQgYnkgQm9vdFJPTSBhbmQgYXJlIHVzZWQgYnkgdmFyaW91
cyBzb2Z0d2FyZQ0KPiA+ID4gPiBlbnRpdGllcyBkdXJpbmcgdGhlIGJvb3QgcHJvY2VzcyBiZWZv
cmUgdGhleSByZWFjaCB0aGUgS2VybmVsLg0KPiA+ID4gPg0KPiA+ID4gPiBEZWZhdWx0IEJvb3RS
T00gY29uZmlndXJhdGlvbiBoYXZlIEpSMCBhbmQgSlIxIHJlc2VydmVkIGZvciBTLW9ubHkNCj4g
PiA+ID4gYWNjZXNzLCB3aGlsZSBKUjIgaXMgZ2VuZXJhbGx5IGF2YWlsYWJsZSBmb3IgYm90aCBT
IGFuZCBOUyBhY2Nlc3MuIEhBQg0KPiA+ID4gPiBmZWF0dXJlIG9mIGkuTVg4TSBmYW1pbHkgZG9l
cyByZXF1aXJlIHRoYXQgSlIwIGlzIHJlc2VydmVkIGV4Y2x1c2l2ZWx5DQo+ID4gPiA+IGluIFMt
b25seSB3b3JsZCwgd2hpbGUgSlIxIGFuZCBKUjIgYXJlIGJvdGggcmVsZWFzZWQgdG8gTlMtV29y
bGQuIE9QLVRFRQ0KPiA+ID4gPiBjYW4gbGF0ZXIgcmVjbGFpbSB0aGUgSlIyIHZpYSBkdF9lbmFi
bGVfc2VjdXJlX3N0YXR1cygpIGNhbGwsIGFuZCBtb2RpZnkNCj4gPiA+ID4gdGhlIERJRCB0byBo
b2xkIGl0IGluIFMtV29ybGQgb25seS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGFib3ZlIHNldHVw
IGhhcyBiZWVuIGRpc2NvdmVyZWQgZHVyaW5nIHJldmlldyBvZiBDQUFNIHBhdGNoc2V0DQo+ID4g
PiA+IHByZXNlbnRlZCB0byBVLUJvb3QgaW50ZWdyYXRpb24gWzFdLCBhbmQgZG9lcyBub3QgY29y
cmVzcG9uZCB0byB0aGUNCj4gPiA+ID4gc3RhdHVzIG9uIGpyIG5vZGVzIGluIEZEVC4NCj4gPiA+
ID4NCj4gPiA+ID4gVGhpcyBtaXNzaW5nIHN0YXR1cyBzZXR0aW5ncyBsZWFkcyB0byB0aGUgZm9s
bG93aW5nIGVycm9yIG1lc3NhZ2UgZHVyaW5nDQo+ID4gPiA+IGpyIG5vZGUgcHJvYmluZzoNCj4g
PiA+ID4gWyAgICAxLjUwOTg5NF0gY2FhbSAzMDkwMDAwMC5jcnlwdG86IGpvYiByaW5ncyA9IDMs
IHFpID0gMA0KPiA+ID4gPiBbICAgIDEuNTI1MjAxXSBjYWFtX2pyIDMwOTAxMDAwLmpyOiBmYWls
ZWQgdG8gZmx1c2ggam9iIHJpbmcgMA0KPiA+ID4gPiBbICAgIDEuNTI1MjE0XSBjYWFtX2pyOiBw
cm9iZSBvZiAzMDkwMTAwMC5qciBmYWlsZWQgd2l0aCBlcnJvciAtNQ0KPiA+ID4gPg0KPiA+ID4g
PiBKUiByZWdpc3RlciByZWFkb3V0IGFmdGVyIEJvb3RST00gZXhlY3V0aW9uIHNob3dzIHRoZSBm
b2xsb3dpbmcgdmFsdWVzOg0KPiA+ID4gPiBKUjBESURfTVMgPSAweDgwMTENCj4gPiA+ID4gSlIx
RElEX01TID0gMHg4MDExDQo+ID4gPiA+IEpSMkRJRF9NUyA9IDB4MA0KPiA+ID4gPg0KPiA+ID4g
PiBUaGlzIHNob3dzIHRoYXQgSlIwIGFuZCBKUjEgaGF2ZSBUWl9PV04gYml0IHNldCwgd2hpY2gg
bWFya3MgdGhlbSB0byBiZQ0KPiA+ID4gPiByZXNlcnZlZCBmb3IgUy1Xb3JsZCwgd2hpbGUgSlIy
IHJlbWFpbnMgYWNjZXNzaWJsZSBmcm9tIE5TLVdvcmxkLg0KPiA+ID4gPg0KPiA+ID4gPiBQcm92
aWRlIHRoZSBjb3JyZWN0IHN0YXR1cyBmb3IgSlIgbm9kZXMgaW4gaW14OG0gZGVyaXZhdGl2ZXMs
IHdoaWNoIGhhdmUNCj4gPiA+ID4gYSBmb2xsb3dpbmcgbWVhbmluZzoNCj4gPiA+ID4gLSBKUjA6
IFMtb25seQ0KPiA+ID4gPiAtIEpSMTogdmlzaWJsZSBpbiBib3RoDQo+ID4gPiA+IC0gSlIyOiBO
Uy1vbmx5DQo+ID4gPiA+DQo+ID4gPiA+IE5vdGUsIHRoYXQgSlIyIGlzIGluaXRpYWxseSBtYXJr
ZWQgdG8gYmUgTlMtb25seSB3aGljaCBkb2VzIGNvcnJlc3BvbmQNCj4gPiA+ID4gdG8gRElEIHJl
YWRvdXQgd2hlbiBPUC1URUUgaXMgbm90IHByZXNlbnQuIE9uY2UgcHJlc2VudCwgT1AtVEVFIHdp
bGwNCj4gPiA+ID4gcmVjbGFpbSB0aGUgSlIyIGFuZCBzZXQgYm90aCAic3RhdHVzIiBhbmQgInNl
Y3VyZS1zdGF0dXMiIHRvIGNsYWltIEpSMg0KPiA+ID4gPiBmb3IgUy1vbmx5IGFjY2Vzcy4NCj4g
PiA+DQo+ID4gPiBXaGlsZSBJIGNhbiB1bmRlcnN0YW5kIHRoYXQgeW91IHdhbnQgdG8gZml4IHlv
dXIgdXNlIGNhc2UgZm9yIHdoZW4gSEFCDQo+ID4gPiBpcyBlbmFibGVkLCBub3RlIHRoYXQgdGhp
cyBpcyBkaXNhYmxpbmcgSlIwIGluIHRoZSBub25lLUhBQiBjYXNlIGFzDQo+ID4gPiB3ZWxsLg0K
PiA+DQo+ID4gVGhpcyBpcyBub3QgdG90YWxseSBjb3JyZWN0LCBhcyB0aGlzIHBhdGNoIGRvZXMg
YWRkcmVzcyB0aGUgcmVzZXJ2YXRpb24gb2YNCj4gPiBKUjAgYnkgQm9vdFJPTSBpbiBib3RoIEhB
QiBhbmQgbm9uLUhBQiBjb25maWd1cmF0aW9ucy4gTXkgY3VycmVudCBzZXR1cCBkb2VzDQo+ID4g
bm90IGluY2x1ZGUgSEFCIGZ1bmN0aW9uYWxpdHkgZW5hYmxlZCwgYW5kIEkgc3RpbGwgZG8gb2Jz
ZXJ2ZSBib290IGVycm9ycw0KPiA+IHRoYXQgYXJlIGxpc3RlZCBpbiBjb21taXQgbWVzc2FnZS4g
VGhpcyBpcyBkdWUgdG8gdGhlIGZhY3QgdGhhdCB0aGUgQm9vdFJPTQ0KPiA+IGRvZXMgbm90IHJl
bGVhc2UgSlIwIHRvIE5TLVdvcmxkIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBIQUIgaXMgZW5hYmxl
ZCBvciBub3QuDQo+ID4gVGhpcyBoYXMgYmVlbiBkaXNjdXNzZWQgaW4gdGhlIFUtQm9vdCB0aHJl
YWQgSSBwcm92aWRlZCB0aGUgbGluayBpbiB0aGUgcGF0Y2guDQo+ID4NCj4gPiBUaGlzIHBhdGNo
IGRvZXMgcmF0aGVyIGJyaW5nIHRoZSBjb3JyZWN0IEhXIG1vZHVsZSBkZXNjcmlwdGlvbiBhcyBz
ZWVpbmcNCj4gPiBmcm9tIExpbnV4Lg0KPiANCj4gSSB0b29rIGEgbG9vayBpbnRvIGkuTVg4TVEs
IHRoZSBib290cm9tIGluZGVlZCBzZXRzIDB4ODAxMSBmb3IgSlIwICYNCj4gSlIxOg0KPiBKUjA6
MDAwMDAwMDAwMDAwODAxMQ0KPiBKUjE6MDAwMDAwMDAwMDAwODAxMQ0KPiBKUjI6MDAwMDAwMDAw
MDAwMDAwMA0KPiBURi1BDQo+ID5DQUFNDQo+IEpSMDowMDAwMDAwMDAwMDAwMDAxDQo+IEpSMTow
MDAwMDAwMDAwMDAwMDAxDQo+IEpSMjowMDAwMDAwMDAwMDAwMDAxDQo+IA0KPiBIb3dldmVyIGF0
IGxlYXN0IHRoZSB1cHN0cmVhbSBURi1BIHJlY29uZmlndXJlcyB0aGUgRElEcyB0byAxIGZvciBh
bGwNCj4gaS5NWDhNKiBkZXJpdmF0ZXMuICBTbyB3aGlsZSBpdCBpcyB0ZWNobmljYWxseSBjb3Jy
ZWN0IHRvIGNoYW5nZSB0aGUgRFQNCj4gdmFsdWVzIGFzIHlvdSBkZXNjcmliZSwgdGhlIGRvd25z
dHJlYW0gVEYtQSBhbmQgdXBzdHJlYW0gVEYtQSBzZWVtIHRvDQo+IGRpZmZlciBpbiB0aGVpciBj
b25maWd1cmF0aW9uLiBJIGFsc28gdGhpbmsgaXQncyBhIGJhZCBtb3ZlIHRvIGhhcmRjb2RlDQo+
IHRoZSBKUiBjb25maWd1cmF0aW9uIHRvIHRoZSBib290IFJPTSBjb25maWcsIHNpbmNlIEFGQUlL
IGkuTVg4TSogY2FuDQo+IG5vdCBiZSBydW4gd2l0aG91dCBURi1BLiBBbmQgSU1PIHRoZSB1cHN0
cmVhbSBrZXJuZWwgc2hvdWxkIGZvbGxvdyB3aGF0DQo+IHRoZSB1cHN0cmVhbSBURi1BIGRvZXMg
aW4gdGhpcyBjYXNlLg0KDQpUaGlzIGlzIGluZGVlZCBhbiBpbnRlcmVzdGluZyBwaWVjZSBvZiBp
bmZvcm1hdGlvbiwgdGhhbmtzIGEgbG90IQ0KDQpGcm9tIHdoYXQgSSB1bmRlcnN0b29kIGluIHBy
ZXZpb3VzIGRpc2N1c3Npb25zIGZvciB0aGlzIHNlcmllcyBoZXJlIGluDQp0aGUgS2VybmVsLCBh
bmQgb24gVS1Cb290IE1MOiBKUjAgaXMgcmVxdWlyZWQgdG8gYmUgaGVsZCByZXNlcnZlZCBpbg0K
Uy1Xb3JsZCBmb3IgSEFCIHRvIG9wZXJhdGUsIGFuZCB0aGlzIGlzIGNsZWFybHkgY29tbXVuaWNh
dGVkIGJ5IE5YUCBpbiBbMV0uDQpJZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIHRoZW4g
dXBzdHJlYW0gVEYtQSBlaXRoZXIgZG9lcyBub3Qgc3VwcG9ydA0Kb3IgYnJlYWtzIHRoZSBIQUIg
ZmVhdHVyZS4NCg0KSSd2ZSBiZWVuIGZvbGxvd2luZyB0aGUgYnVpbGQgZG9jdW1lbnRhdGlvbiBp
biBVLUJvb3QsIHdoZXJlIHRoZSBkb3duc3RyZWFtDQpURi1BIGlzIGxpc3RlZCBhcyBidWlsZCBw
cmVxdWlzaXRlcyBbMl0gd2l0aG91dCBhbnkgbWVudGlvbmluZyBvZiB1cHN0cmVhbSwNCmhlbmNl
IEkgcmVjZWl2ZWQgYSByZWFkb3V0IHRoYXQgbWF0Y2hlZCB0aGUgQm9vdFJPTSAiMS10by0xIi4N
Cg0KSSBiZWxpZXZlIHRoYXQgaWYgdGhlIGluZm9ybWF0aW9uIGZyb20gTlhQIHJlZ2FyZGluZyBK
UjAgcmVzZXJ2YXRpb24gZm9yDQpIQUIgaXMgY29ycmVjdCAoYW5kIEkgaGF2ZSBubyByZWFzb25z
IHRvIGRvdWJ0IGl0KSwgdGhlbiB1cHN0cmVhbSBURi1BDQpzaG91bGQgYmUgYWRhcHRlZCBpbiBv
cmRlciBmb3IgSEFCIGZlYXR1cmUgdG8gd29yaywgYW5kIGluIHRoYXQgY2FzZSB0aGlzDQpwYXRj
aCBicmluZ3MgY29ycmVjdCBIVyBzdGF0ZSBkZXNjcmlwdGlvbiBhcyBzZWVpbmcgZnJvbSBMaW51
eC4NCg0KQW5kIGluIGNvbnRyYXJ5LCBpZiB0aGUgdXBzdHJlYW0gVEYtQSBpcyBub3QgYWRqdXN0
ZWQgdG8gaW5jbHVkZSBIQUINCnN1cHBvcnQgLSB0aGVuIGFwcGx5aW5nIHRoaXMgcGF0Y2ggd291
bGQgZWZmZWN0aXZlbHkganVzdCAicmVtb3ZlIiBvbmUNCkpSIGRldmljZSwgc3RpbGwga2VlcGlu
ZyAyIGFkZGl0aW9uYWwgYXZhaWxhYmxlIG5vZGVzIGZvciBIVyBjcnlwdG8NCm9wZXJhdGlvbnMg
aW4gS2VybmVsLCB3aXRoIGFkZGVkIGJlbmVmaXQgdGhhdCBib3RoIHVwc3RyZWFtIGFuZA0KZG93
bnN0cmVhbSBURi1BIGNhbiBiZSB1c2VkIGR1cmluZyB0aGUgYm9vdCB3aXRob3V0IHNlZWluZyBp
c3N1ZXMgbGF0ZXINCmluIHRoZSBLZXJuZWwuDQoNCj4gDQo+ID4NCj4gPiA+IElNTyB0aGlzIHNo
b3VsZCBiZSBoYW5kbGVkIGNvcnJlY3RseSBieSB0aGUgYm9vdGxvYWRlciBhbmQvb3IgT1AtDQo+
ID4gPiBURUUuIFRoZSBkZWZhdWx0IHVwc3RyZWFtIGNvbmZpZ3VyYXRpb24gZm9yIE9QLVRFRSBp
cyB0byBub3QgdXNlIHRoZQ0KPiA+ID4gQ0FBTSBhdCBydW50aW1lIGFzIHdlbGwsIHNpbmNlIGxp
bnV4IHJ1bnRpbWUgUE0gZGlzYWJsZW1lbnQgb2YgdGhlIENBQU0NCj4gPiA+IHdpbGwgbG9jayB1
cCBPUC1URUUgd2hlbiBpdCB0cmllcyB0byBhY2Nlc3MgdGhlIENBQU0uDQo+ID4NCj4gPiBJZiBi
eSBoYW5kbGluZyB5b3UgbWVhbiByZWxlYXNpbmcgSlIwIHJlc2VydmF0aW9uIC0gdGhlbiB5ZXMs
IGl0IHNob3VsZCBiZQ0KPiA+IGRvbmUgYnkgZWl0aGVyIFNQTCBvciBURi1BIGFzIHRoZXkgZG8g
cnVuIGluIFMgV29ybGQuIEluIHN1Y2ggYSBjYXNlLCBEVEINCj4gPiBiaW5kaW5ncyBuZWVkIHRv
IGJlIGFkYXB0ZWQgZnVydGhlciBhY2NvcmRpbmcgdG8gdGhlIG5ldyBzdGF0ZS4gVW50aWwgdGhp
cw0KPiA+IGRvbmUgLSB0aGlzIHBhdGNoIGRvZXMgcHJvdmlkZSBhIGNvcnJlY3Qgc3RhdGUgb2Yg
SFcgdG8gdGhlIEtlcm5lbC4NCj4gDQo+IFVwc3RyZWFtIFRGLUEgc2ltcGx5IHJlbGVhc2VzIGFs
bCBKUnMgdG8gdGhlIG5vcm1hbCB3b3JsZCwgbWF0Y2hpbmcgdGhlDQo+IGN1cnJlbnQgRFRCIGRl
c2NyaXB0aW9uLg0KPiANCj4gS2luZCBSZWdhcmRzLA0KPiBSb3V2ZW4gQ3plcndpbnNraQ0KPiAN
Cj4gDQpbc25pcF0NCg0KUmVnYXJkcywNCkFuZHJleQ0KDQpMaW5rOiBbMV06IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3UtYm9vdC9WSTFQUjA0TUI1MzQyQzhDNkU2NTFFQzJDQzQ0NzdFQjVFNzlB
OUBWSTFQUjA0TUI1MzQyLmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20vDQpMaW5rOiBbMl06IGh0
dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L3UtYm9vdC8tL2Jsb2IvbWFzdGVyL2RvYy9ib2Fy
ZC9ueHAvaW14OG1tX2V2ay5yc3QNCg==
