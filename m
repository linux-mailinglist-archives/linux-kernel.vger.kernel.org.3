Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6208D48F3BF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiAOBEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:04:54 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:53851 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbiAOBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:04:54 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20F0gHo6027204;
        Fri, 14 Jan 2022 20:04:38 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2059.outbound.protection.outlook.com [104.47.60.59])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dkb510aae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 20:04:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkrnxD/vVJ8uOYNPpVUVZqyOqctLmWXC00HktVPbtmSVBOis5nL/lbzJkxNUV20ImTiVKDm/ookiqRT/8vMa7uoSysWUZZ7QluqfAOwHegtbtpK5aPwjbIBqhpQ6QAAD68W8MaFScgulmk7/RabHA2Iy9Z0aCLzkK8eXpJat1zKpjyrNPNIAbxrKqssVUXx8dCZwLCOzsOHygt9LcREVYwM8kqCydl37x6f8iF3rQwxljDD+tu++rFwLJ1XXdp94FkU15WPa0hiWcOUxZWwP0EiBQvS46YYkMXktpAooZWq3MO9ekLCFwgBC1CGmVeuhrs40CZiJjEvZGMf6/bDNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f8p52HmSTLGkylyXEPATtNhSBlvlZ47Z0gugzUygd0=;
 b=VkKKBvnv7zHvRfnswNy0ddnkx5g2fNS41+y8DBi+a4WfPpUTCvQrnHr9qINiA7vM9wB8VRmj5wVB19imh85DPIaXePrrVg0VVAOsXDy9c7ezqvK+Hfarja7p5Eg3NBSp74DBaDJn0geTItnsDmMnBzzOfKePcgFZgQrny/D/f4kCeZU65yTYDgxA+h8VTLnfgmp6aRy2LQhG+qpcHneiscuAnCEJJWp0sBqJRTydQRRZv2or3//Ffimju1VF4gkdFdWzEJFSnl/qZiNBu1Bd2vczE7RhdMBxlYjVO9UAIck3SUIcEA7TGVaSE0QDc+35/Cz7jhT5ye+JHO69KTP1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f8p52HmSTLGkylyXEPATtNhSBlvlZ47Z0gugzUygd0=;
 b=slWZUQUOZ4AQn9M7px4uTGJSoJ/Dld0Yvepj1BzW2kaYUUWMVdxn5PpLebmCBsn2xo4r90LfUH70tqtCZ7t+JVqHt5e/JIC6JpIUM+MqnPz2H3SnSEPrJY5sLO4QKX77vITq4jmVrSKt761y40yM8ZAAtVXrGDZnXbhyeZQkeq0=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YTBPR01MB2413.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:23::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sat, 15 Jan
 2022 01:04:36 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 01:04:36 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
Subject: Re: [PATCH 2/6] usb: dwc3: Get clocks individually
Thread-Topic: [PATCH 2/6] usb: dwc3: Get clocks individually
Thread-Index: AQHYCZ/51ULp2A+cK0awdGV6N1scf6xjRHiA
Date:   Sat, 15 Jan 2022 01:04:36 +0000
Message-ID: <1c242d0114554b72f8f0b1f6507973a0dea50b3d.camel@calian.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
         <20220114233904.907918-3-sean.anderson@seco.com>
In-Reply-To: <20220114233904.907918-3-sean.anderson@seco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73de943b-1a6e-47af-599c-08d9d7c2ffa5
x-ms-traffictypediagnostic: YTBPR01MB2413:EE_
x-microsoft-antispam-prvs: <YTBPR01MB2413C9B03859BFA88415095EEC559@YTBPR01MB2413.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOFIcFsOBLfG73o3naZakmrDxm6lxvtTvTt6J8nrvdVMuSFyx9zC6aiGt1JRVZSIawjHIFRhEbYZf5R0iisHSW4L9Jo4BkbBOmU0bxuc0BGnTIjdEeiAEFFFOc6nT4wGMwAml7UBBMd/E2kRtTspqbfALAiWS95fWAOpfwVXgXM6I2bqWGR6VC0ZK+HTZT0ZQPKV3n6bsY4zAvOWmEyRnFC9XWwPhPoMxv2qHMo3OAMnDpYEW/J/mhepIPIkbvhPFG4X6FOiRuAvpOSlkFO0d/CAP6WoOQ2C79eJ3MXAqb3P/ze3XQOKPsTWTfxQ8kIgwKBu5qESEvq9WN+Vg6W8Na94I9hfV94SdJTFg9lVJ0mESoytbUvE4hKu6EGvigdETMSwlBFrWLRMKptagiQp99vhhnPiVHZfXi4FQQqRtLOwLxDR9Ii8YOFBziOgfvrOv5QjGRcGPibODT5hvI5dGYeFTc2N+0TO1t5o8riQEq38HNTIdFmK5UG9Bvc36Cg+iC/6PG5C2cArZq+SW0p5GcT1Rr9awPWc1ibLHDZNwS1XyQSbCvv19CF55g6CrGghdXMB6OFwoSw5rYMj7aibA64mOINjXI/TJV/SeVuZneobeiMVIZ6TjfoOmiy9DpP51D6pSwonH75uKLH4vRjc20N9viUjgLVUQuRANSeq018Twy+uVSsor3nhOlLmxExNOgKdFm2j7qpsFtM76M1sA2oct4b/fJNNO3yl8KvH3xAHE3iHoXX3P3Ruul9cTX7b28ppwuB3DaVrhbCntwt4e4yVRjVU5L3nEkmJwL/Lhpfv1gjKIFvXuLfVjJXeePtsxY7ij9JmzdW7gvUmNk6ynA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(6512007)(316002)(83380400001)(15974865002)(66476007)(36756003)(508600001)(44832011)(186003)(5660300002)(66446008)(64756008)(86362001)(66946007)(91956017)(4326008)(76116006)(2906002)(38070700005)(6486002)(2616005)(6506007)(8676002)(66556008)(71200400001)(122000001)(38100700002)(54906003)(8936002)(26005)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFRURkZMSUtkQ0xnbTdMTkhJcWlML3ZIQ2NUcisyMnlXUDRBOEJybDh0YStP?=
 =?utf-8?B?YitzdmJFeDNzZG1CczFTQU9lNFAwY1ByZWxpb25zN2J6MFYvVHVESmE1VDFM?=
 =?utf-8?B?cXNMVnNxMXFmNmJjeks5b1JRZ2ljbVZHQUYzN1M0ZHhRK3orbUNVc3JTSWxi?=
 =?utf-8?B?VXQvRGpJVHRVTncvNlFwcCtlQk1mYkg5cmRnMldzTW41VWwxUkpMNUpSSEJI?=
 =?utf-8?B?cjhYY2xPck1acmJkYUFobjk2U0lPaVdMZ3I5OFlhck1yQTc2Y3RwcmI4Wito?=
 =?utf-8?B?UWFibFYxMStZY29XNU1YYW50QmpCWmJjNjhRdGZZTEUxUThqSm5XSW1hM2F3?=
 =?utf-8?B?M2pDYXdPdy9RZTFoakN3a0s1NUNXUWlKbnlIVExBZ3VXWCtxT2FMUDkvbzBy?=
 =?utf-8?B?cG9tN3E5VldrWjd6dDIxTHczRGwza2dDSjlnZ0pnT1hKRjJRY3NjaGVTdFJq?=
 =?utf-8?B?K3NGV3FmdUZpcDJkRHQ3UnV5UHVHWHJHMHZneE0zdDVpZnVHdUEvcGJyQ2dz?=
 =?utf-8?B?SmROMnkyVW9POHFpb3pRMi9icms2YUs0eWt5RGJRUm9WOGtPUVg0azNCaW1r?=
 =?utf-8?B?TWNKakhZQmt6d3JpOHRUckQxdnA5djZKRUxaZHphOWNab3NxZDRJQXhmelNz?=
 =?utf-8?B?Mk4yRlFyM3F2YzJOVHJzcURRSzBxOU1MenhBS24zeVdEZkNxU0hpWlF2V0F1?=
 =?utf-8?B?Wkg0L0YyMVhDOTBXZStYMHg1VVpGa1psTXVCa0dsU0t1NHlOaVk3dU1oVER0?=
 =?utf-8?B?djVLWTJ4OFFhVm9wTmMrWHR4N2hsaEtPRFNYNUZCWjZueE5NVFZqdWllME4w?=
 =?utf-8?B?a042TU42akFiYy9Bak9JYzBoNEx2Z3VZTkxtQXp5NmVEZ3Z2dDc5UGRoWmI4?=
 =?utf-8?B?anlxTWZPcnh1RGx6ZWxQNFp3TENRc3FraXBiRTFrZTZ4V1lVRGJ2NDd6cDR3?=
 =?utf-8?B?VnZCR2c0WVdNYzlmOUFyTmVjSHZRRUNpeWJRRTFydUhFNEcyNTdjbDhJakV4?=
 =?utf-8?B?ZFVNUWw0cE1RZkNMc09IaDVub1BOWVljUm5sME1rZytZU2l1bXFYZFVFMkVU?=
 =?utf-8?B?M25QdGNmNWhlTnNsVHpncUk5ZVpqdk1tZGxhSFJESTZXYUtIMmNhN3REUklo?=
 =?utf-8?B?SVlQTlBJU0c2UGQvVjVrNStVWmp5Um92SXBiUWkyOU9jRnhXT1pWRThVcVJv?=
 =?utf-8?B?WkczSHp6RHZsZ01rUmxGMkpDM2Q4Qk1ZaWdhb1ErZndnZGUySVpMYU5Ga3BU?=
 =?utf-8?B?WVErcXZmTFFLcERpaDY0OXZHTmVrbXBrS2o3Zi9EVGFKUHEyZE95Vkx4YWJU?=
 =?utf-8?B?MTQ5aDdVUXVtWXByc2l2NkNnM2dDR054WDFPL0J2cUIwaFQ0bk0vejdHWmJi?=
 =?utf-8?B?dTNmSldIS1k1MnYwZFJxTjdGdGpLUjNreFpSc0FBd2ZMaGQzM0xDc28vb0ts?=
 =?utf-8?B?RnZhL0tlSkozNnFROEhMS0J5THIzWWQwNEVpSEZ5RUF6RTR5NTVUdjR2UDRF?=
 =?utf-8?B?eUE5Z2R3VFpGcUp1Qk8yWWpObEp4dHV1Z1lRTlVjVHZBTStWUGs3YU40VlRj?=
 =?utf-8?B?SklMU3loNFovUnh4QnZLaGJLeXlWY0NmV2N4WEVnN1hGYjdidzlsc3dlVit2?=
 =?utf-8?B?SE5YK0Z1NW1XK0tCRlpwV1hNcUpYdTVweXphc1Y1Vzd0QTNwYnhySFplQktO?=
 =?utf-8?B?UTZmQWp3cFVGZmZWR0JWaVNuREZKRHZwTUlyZDR0K3RnSGhYOXY2akJLNWFX?=
 =?utf-8?B?dWFvSGhrZlU3eXU4VHc4NGc3eVBCMGlYQi9GQnhnc0tzYlV6V2F2QTVlM3o4?=
 =?utf-8?B?aDJLYjlFL1pUT25IaC9yNnltTUg2dDFyTXVUUzJjckNRRkRqRHdvd1d5aDlo?=
 =?utf-8?B?bGtuTDFiTVgwdklkeUJ1Y1BKVHdMeE9VVzRNcDcrdUUrUzgxUnc3TWFDTmFa?=
 =?utf-8?B?OHlmajB2YUpQL29MZWZkcVNZMDZiTjZDRUw3bzhiaXB3Qmp0ZmhXa05Gb0Ex?=
 =?utf-8?B?dFZnNG9KYmpyUS8xMGFNSnRiWE5lSXZBVENVZXRWSHdFVHNRZjRacEIxSjdw?=
 =?utf-8?B?RUJncXNNeU5tL01UeUtNOXRBeGswT1ZnMVJjaWRaN3VCZE95amZlUzRFTFBp?=
 =?utf-8?B?R3huR2RndHlUUk9mck1rZ20yaXNHZERqbUs0elRtTGpISVRsNHBKTFMyZUxO?=
 =?utf-8?B?dVlpWlpJVkVEWVZHazFPRmQ5S3gwRGNlR2NrSHpmbkJoY1RXQ3ZYZWk4REpI?=
 =?utf-8?Q?qSx0UeLq9plNy5lu2CKRl1p+4zKshF/fUQkmpgeBGY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0950E81F83627E478AC85470D7D23393@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 73de943b-1a6e-47af-599c-08d9d7c2ffa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 01:04:36.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SSqzMLxSVOStcWTGqrEwB9UpQwCB29SdjwRivJGLxMzlNOy9DjvP7EQsMldLCSeAKiYH5MaylzI3K/jwue0+wluC1EhZlKP/Is4pZfUvoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2413
X-Proofpoint-GUID: IWqsgTQCkqFvM4WeLt7ZUk33b3LDHaZ0
X-Proofpoint-ORIG-GUID: IWqsgTQCkqFvM4WeLt7ZUk33b3LDHaZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTAxLTE0IGF0IDE4OjM5IC0wNTAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0K
PiBJbnN0ZWFkIG9mIGdyYWJiaW5nIGFsbCBjbG9ja3MgaW4gYnVsaywgZ3JhYiB0aGVtIGluZGl2
aWR1YWxseS4gVGhpcyB3aWxsDQo+IGFsbG93IHVzIHRvIGdldCB0aGUgZnJlcXVlbmN5IG9yIG90
aGVyd2lzZSBkZWFsIHdpdGggZGlzY3JldGUgY2xvY2tzLiBUaGlzDQo+IG1heSBicmVhayBzb21l
IHBsYXRmb3JtcyBpZiB0aGV5IHVzZSBhIGNsb2NrIHdoaWNoIGRvZXNuJ3QgdXNlIG9uZSBvZiB0
aGUNCj4gZG9jdW1lbnRlZCBuYW1lcy4NCg0KQW5vdGhlciBhcHByb2FjaCB3b3VsZCBiZSB0byBr
ZWVwIHRoZSBidWxrIGdldCBhbmQgcHJlcGFyZV9lbmFibGUgYW5kIGp1c3QNCnNlYXJjaCB0aHJv
dWdoIHRoZSBjbG9ja3MgaW4gdGhlIGJ1bGsgZGF0YSB0byBmaW5kIHRoZSAicmVmIiBjbG9jaywg
aS5lLg0Kc29tZXRoaW5nIGxpa2U6DQoNCgkJZm9yIChpID0gMDsgaSA8IGR3Yy0+bnVtX2Nsa3M7
ICsraSkNCgkJCWlmICghc3RyY21wKCJyZWYiLCBkd2MtPmNsa3NbaV0uaWQpKSB7DQoJCQkJcmVm
X2Nsa19yYXRlID0gY2xrX2dldF9yYXRlKGR3Yy0+Y2xrc1tpXS5jbGspOw0KCQkJCWJyZWFrOw0K
CQkJfQ0KDQpUaGF0J3MgcHJvYmFibHkgc2ltcGxlciB0aGFuIGFsbCB0aGUgZXh0cmEgY29tcGxl
eGl0eSB0byBnZXQgZWFjaCBvZiB0aGUgY2xvY2tzDQppbmRpdmlkdWFsbHkgYW5kIHJlbGVhc2Ug
dGhlbSBpbiB0aGUgcmlnaHQgb3JkZXIuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQW5k
ZXJzb24gPHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+DQo+IC0tLQ0KPiANCj4gIGRyaXZlcnMvdXNi
L2R3YzMvY29yZS5jIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDUgKystLQ0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCA1MyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGlu
ZGV4IGY0YzA5OTUxYjUxNy4uNjk5YWI5YWJkYzQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtNzQ1
LDYgKzc0NSwzOCBAQCBzdGF0aWMgaW50IGR3YzNfcGh5X3NldHVwKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19jbGtfZW5hYmxl
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IGNs
a19wcmVwYXJlX2VuYWJsZShkd2MtPmJ1c19jbGspOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVy
biByZXQ7DQo+ICsNCj4gKwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZHdjLT5yZWZfY2xrKTsN
Cj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGRpc2FibGVfYnVzX2NsazsNCj4gKw0KPiArCXJldCA9
IGNsa19wcmVwYXJlX2VuYWJsZShkd2MtPnN1c3BfY2xrKTsNCj4gKwlpZiAocmV0KQ0KPiArCQln
b3RvIGRpc2FibGVfcmVmX2NsazsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArDQo+ICtkaXNhYmxl
X3JlZl9jbGs6DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGR3Yy0+cmVmX2Nsayk7DQo+ICtk
aXNhYmxlX2J1c19jbGs6DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGR3Yy0+YnVzX2Nsayk7
DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgZHdjM19jbGtfZGlz
YWJsZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShk
d2MtPnN1c3BfY2xrKTsNCj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5yZWZfY2xrKTsN
Cj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5idXNfY2xrKTsNCj4gK30NCj4gKw0KPiAg
c3RhdGljIHZvaWQgZHdjM19jb3JlX2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAlk
d2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cChkd2MpOw0KPiBAQCAtNzU4LDcgKzc5MCw3IEBAIHN0
YXRpYyB2b2lkIGR3YzNfY29yZV9leGl0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJdXNiX3BoeV9z
ZXRfc3VzcGVuZChkd2MtPnVzYjNfcGh5LCAxKTsNCj4gIAlwaHlfcG93ZXJfb2ZmKGR3Yy0+dXNi
Ml9nZW5lcmljX3BoeSk7DQo+ICAJcGh5X3Bvd2VyX29mZihkd2MtPnVzYjNfZ2VuZXJpY19waHkp
Ow0KPiAtCWNsa19idWxrX2Rpc2FibGVfdW5wcmVwYXJlKGR3Yy0+bnVtX2Nsa3MsIGR3Yy0+Y2xr
cyk7DQo+ICsJZHdjM19jbGtfZGlzYWJsZShkd2MpOw0KPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0
KGR3Yy0+cmVzZXQpOw0KPiAgfQ0KPiAgDQo+IEBAIC0xNjA1LDI1ICsxNjM3LDMxIEBAIHN0YXRp
YyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlyZXR1
cm4gUFRSX0VSUihkd2MtPnJlc2V0KTsNCj4gIA0KPiAgCWlmIChkZXYtPm9mX25vZGUpIHsNCj4g
LQkJcmV0ID0gZGV2bV9jbGtfYnVsa19nZXRfYWxsKGRldiwgJmR3Yy0+Y2xrcyk7DQo+IC0JCWlm
IChyZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4gLQkJCXJldHVybiByZXQ7DQo+ICAJCS8qDQo+ICAJ
CSAqIENsb2NrcyBhcmUgb3B0aW9uYWwsIGJ1dCBuZXcgRFQgcGxhdGZvcm1zIHNob3VsZCBzdXBw
b3J0IGFsbA0KPiAgCQkgKiBjbG9ja3MgYXMgcmVxdWlyZWQgYnkgdGhlIERULWJpbmRpbmcuDQo+
ICAJCSAqLw0KPiAtCQlpZiAocmV0IDwgMCkNCj4gLQkJCWR3Yy0+bnVtX2Nsa3MgPSAwOw0KPiAt
CQllbHNlDQo+IC0JCQlkd2MtPm51bV9jbGtzID0gcmV0Ow0KPiArCQlkd2MtPmJ1c19jbGsgPSBk
ZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAiYnVzX2Vhcmx5Iik7DQo+ICsJCWlmIChJU19FUlIo
ZHdjLT5idXNfY2xrKSkNCj4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihk
d2MtPmJ1c19jbGspLA0KPiArCQkJCQkgICAgICJjb3VsZCBub3QgZ2V0IGJ1cyBjbG9ja1xuIik7
DQo+ICANCj4gKwkJZHdjLT5yZWZfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRldiwgInJl
ZiIpOw0KPiArCQlpZiAoSVNfRVJSKGR3Yy0+cmVmX2NsaykpDQo+ICsJCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIFBUUl9FUlIoZHdjLT5yZWZfY2xrKSwNCj4gKwkJCQkJICAgICAiY291bGQg
bm90IGdldCByZWYgY2xvY2tcbiIpOw0KPiArDQo+ICsJCWR3Yy0+c3VzcF9jbGsgPSBkZXZtX2Ns
a19nZXRfb3B0aW9uYWwoZGV2LCAic3VzcGVuZCIpOw0KPiArCQlpZiAoSVNfRVJSKGR3Yy0+c3Vz
cF9jbGspKQ0KPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+c3Vz
cF9jbGspLA0KPiArCQkJCQkgICAgICJjb3VsZCBub3QgZ2V0IHN1c3BlbmQgY2xvY2tcbiIpOw0K
PiAgCX0NCj4gIA0KPiAgCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoZHdjLT5yZXNldCk7
DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCXJldCA9IGNsa19idWxr
X3ByZXBhcmVfZW5hYmxlKGR3Yy0+bnVtX2Nsa3MsIGR3Yy0+Y2xrcyk7DQo+ICsJcmV0ID0gZHdj
M19jbGtfZW5hYmxlKGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBhc3NlcnRfcmVzZXQ7
DQo+ICANCj4gQEAgLTE3MTEsNyArMTc0OSw3IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+
ZGV2KTsNCj4gIA0KPiAgZGlzYWJsZV9jbGtzOg0KPiAtCWNsa19idWxrX2Rpc2FibGVfdW5wcmVw
YXJlKGR3Yy0+bnVtX2Nsa3MsIGR3Yy0+Y2xrcyk7DQo+ICsJZHdjM19jbGtfZGlzYWJsZShkd2Mp
Ow0KPiAgYXNzZXJ0X3Jlc2V0Og0KPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGR3Yy0+cmVzZXQp
Ow0KPiAgDQo+IEBAIC0xNzU1LDcgKzE3OTMsNyBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0
X2Zvcl9yZXN1bWUoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4g
cmV0Ow0KPiAgDQo+IC0JcmV0ID0gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoZHdjLT5udW1fY2xr
cywgZHdjLT5jbGtzKTsNCj4gKwlyZXQgPSBkd2MzX2Nsa19lbmFibGUoZHdjKTsNCj4gIAlpZiAo
cmV0KQ0KPiAgCQlnb3RvIGFzc2VydF9yZXNldDsNCj4gIA0KPiBAQCAtMTc2Niw3ICsxODA0LDcg
QEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gIGRpc2FibGVfY2xrczoNCj4gLQljbGtfYnVsa19kaXNh
YmxlX3VucHJlcGFyZShkd2MtPm51bV9jbGtzLCBkd2MtPmNsa3MpOw0KPiArCWR3YzNfY2xrX2Rp
c2FibGUoZHdjKTsNCj4gIGFzc2VydF9yZXNldDoNCj4gIAlyZXNldF9jb250cm9sX2Fzc2VydChk
d2MtPnJlc2V0KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlMWNjM2Y3Mzk4ZmIuLjMyZGZjZjNh
ODNkNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTExMzQsOCArMTEzNCw5IEBAIHN0cnVjdCBkd2Mz
IHsNCj4gIAlzdHJ1Y3QgdXNiX2dhZGdldAkqZ2FkZ2V0Ow0KPiAgCXN0cnVjdCB1c2JfZ2FkZ2V0
X2RyaXZlciAqZ2FkZ2V0X2RyaXZlcjsNCj4gIA0KPiAtCXN0cnVjdCBjbGtfYnVsa19kYXRhCSpj
bGtzOw0KPiAtCWludAkJCW51bV9jbGtzOw0KPiArCXN0cnVjdCBjbGsJCSpidXNfY2xrOw0KPiAr
CXN0cnVjdCBjbGsJCSpyZWZfY2xrOw0KPiArCXN0cnVjdCBjbGsJCSpzdXNwX2NsazsNCj4gIA0K
PiAgCXN0cnVjdCByZXNldF9jb250cm9sCSpyZXNldDsNCj4gIA0KLS0gDQpSb2JlcnQgSGFuY29j
aw0KU2VuaW9yIEhhcmR3YXJlIERlc2lnbmVyLCBDYWxpYW4gQWR2YW5jZWQgVGVjaG5vbG9naWVz
DQp3d3cuY2FsaWFuLmNvbQ0K
