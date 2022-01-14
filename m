Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0748E3C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiANFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:34:44 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:22296 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbiANFem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:34:42 -0500
X-Greylist: delayed 1705 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jan 2022 00:34:42 EST
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20E4s8De031733;
        Fri, 14 Jan 2022 00:06:09 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2058.outbound.protection.outlook.com [104.47.61.58])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dj0fchapb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 00:06:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4mY9bMShwbtnZo2MC+pGcIFX25w2J48lE2VYpC6WfIJshKLTP0Vc68rvVDeZ1lhTc4M7AzUnQ/2pXXCKBFVvgpLU93OByDrf1kTX0y6y1HGXiTdOezrA0suxA0qGzyKfrwnjHkgY5eb8YrQaOSvzGAHe+7ws+Xx9UezJEPYMGcId2mz4IHdIN8CgSz7xhe7FlEH2ll904YN+F7/vPJL2Ll3IdCSkiSpbrj6gzTpVH8QVN1akizUngNICsveM8skVCE/V41pVPBW6TKnita3TPthsyoMP3O6JaBbgjTBNvTd/sg4wWqtj3A+eMVPNFDtttdKtMbC+wf48GHQuxyDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qVQqeHs7jW6SY+9/SySbnblJw0Blo3WooKKUHf3jqM=;
 b=ObAFTzl4nDd7Mmulsml6A5Fkvwl4jXkh2nTciZAKh23BAoqSCN2UUINYSpN64lzpO+yVIIBu7ynHi9jxHCF4Bww2b6rGutyasRjN/VYUe3pcE0/QvJ65/D2dYQGX3W8lflvuei7A/qbAcU1RarO5TP3FuFtRZgyA3eHCL4o96hzfa2QDR5VfpfNb4DVGMZ49kWNC+2cNouhavuzEbln4wSpgYj+TdMwN1bMNB36l7DOrXngX7+vg88ZmTUVTVffdSEbLf2S0wsGdoqZc0dQxmEk2G89gTJ09an99Ji7sq/18UX9iZ9E5Kcom9/wff8Ufg9ROM2pqz5ZjsPeVEXFHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qVQqeHs7jW6SY+9/SySbnblJw0Blo3WooKKUHf3jqM=;
 b=xmb26Bo57coC4EEhfkxZSC3m3MIyrniVrxhNORSQe8Cjk/C06x4rSMtfNWx8aF1MIbb+1Lr9bfHFUektRhmiztfBTI+Usk7BgFMdQgoj1nHThgV5MaI2w6sixLLZf8AIWAz9FJR0nWlK3kdIZRYbauIuo1FMP9zxGCT5kUpNWRA=
Received: from YT2PR01MB6270.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::14)
 by YTBPR01MB2336.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 05:06:07 +0000
Received: from YT2PR01MB6270.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d51:8098:30cc:5bb6]) by YT2PR01MB6270.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d51:8098:30cc:5bb6%3]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 05:06:07 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "wangqing@vivo.com" <wangqing@vivo.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>
Subject: Re: [PATCH RESEND] clk-si5341: replace snprintf in show functions
 with sysfs_emit
Thread-Topic: [PATCH RESEND] clk-si5341: replace snprintf in show functions
 with sysfs_emit
Thread-Index: AQHYCPC5RluPoWDcUUy1ahA91HU1A6xh9v0A
Date:   Fri, 14 Jan 2022 05:06:07 +0000
Message-ID: <293f7b407680eca0d2c1e14779bc24842537cdcc.camel@calian.com>
References: <1634280331-4150-1-git-send-email-wangqing@vivo.com>
         <20220114024453.D9F28C36AE3@smtp.kernel.org>
In-Reply-To: <20220114024453.D9F28C36AE3@smtp.kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c6086f9-ecd3-48f9-587c-08d9d71b928b
x-ms-traffictypediagnostic: YTBPR01MB2336:EE_
x-microsoft-antispam-prvs: <YTBPR01MB23362CD894B7067F1C06DDAEEC549@YTBPR01MB2336.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hgBHjtTJY3QLbS8uMt3we0gmjf0QkYbFUpyPZGxq/0YN0IYxQ080/z4YCiWG/OJZKUa5/OgEd+MbeQfCfc88bKU7V8Z6Ox8ngEs+VhIC/2i0NDpi8ZUBnj+Tm78IWySWL+oY9bCoLYkTGKEgw8O+zqJJuos8SgVNoLc4gNyx8z+nTmip4nGgy0icWTkbquyl3061tclU2gqnrqt5rdBBh4v2nYSFE2NKw6cdnn8GitNPN52szql0HjOdhfqdaZo98DamAywqBEQ9xE306FTMv9rxuCKA2iWy0wkbm/4nCigUJZl78Mmmcdp/w9ohgtq0Iq6jr/fjVpSitgLqzfuyU1sX1BLq8iOb5yuqa5TZ5t5NfR5QF/KAgqnesTuo4ASMG9TIqr1X2PAQDeDnaAhnySBwi7ldrBReqO2Rf9CVDnEmKLaPkNaBIwqmhesLTTYlw9nazaV815ESxzcIdLQ/cIxxAUegn1qRhOpfBPMuJOcwXTDAmzbMG9s1xX5heSDUrbWSVGIkPW8hO9LgmEYxx06ReG/lUY1ZceoSjhhwQcNrzlSEWZD+RqMgXfu4qJU3H/BKxkKSYa8NvhGQKj5DIeN132P9GXgJveoC1nNcV6oY7fxQrBVJdEP2IB0m92Tpth7nBrj1p9KQ8xRb2RoGcyuQxOQ64rO/twZRWJQdBjkdJUoLwuLklsCVAOQK3pY/FY/LHELrDTf+Oa7NWczDgRJHwJBOOn0AR4ELujNjW9UqT8xXIpi+B6a2qDZ8ILaPmyyM3z2xx2FTUiaz+ieRBu3igqhClBonIpwnZPD4UbmffJziYaITcB5+WmPcTrrviygC+EXDghaoyBThJWTwHw8r3MmSUkOnttLHJFzG6to=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB6270.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(4326008)(2616005)(8936002)(64756008)(186003)(66556008)(83380400001)(86362001)(66946007)(8676002)(66446008)(91956017)(66476007)(76116006)(38100700002)(26005)(36756003)(44832011)(110136005)(38070700005)(71200400001)(5660300002)(6486002)(508600001)(15974865002)(4001150100001)(316002)(6506007)(2906002)(6512007)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXMxSUNVSTZ2ZTdicUF1QmlqWUtvSHFNRjdMVzdGNnFFWS9tYkNmT3YvZTl2?=
 =?utf-8?B?R1k4bk5iUkhidE5jMmNQWUdSOThUbE9scm05ajdGekJZYmorbjF0VGhzV3FW?=
 =?utf-8?B?ODlXSE5kVWk3SmRKMkxYb3MwMmV2QlhQdXpGQ094R0hRYUhDalR4dTI3SVRF?=
 =?utf-8?B?NUhnOUtmeTNTTlZjT3lVK282NjFia2dBU09Nbng4Skxzbmlid1NERVBkcmVq?=
 =?utf-8?B?MHNLa1IycVZIUEhTUFAyZ09oNFgwUE8rWEI4UXZ3QlFMb2d1Q1FUQTNlb0sw?=
 =?utf-8?B?Y3VrUmVocTZvT3VVQStIQjhQZEhpRkF2RnJYV2I1N09NYUtuQytwZzIyeUUz?=
 =?utf-8?B?Wi9GZkx3Y0lDZno1dDhacTl3a3JUNGZDNFFYSEl4ZXUwYTR3VkVYZkY5QWJ2?=
 =?utf-8?B?SVJRQ3czNVNOSUtia0Vld2k0c294NzZDY2pvWDdxZmo3M2FOU2xPY0xGRG9R?=
 =?utf-8?B?NVBuQnUyOGxiRXhyczlFSG96Szlhc244NFRGMUloR2tWQ29GTVd5V3RHTzZX?=
 =?utf-8?B?T2ZlcTl5c1FDa09reTgyK0ttTnByOHBYcWR4a3JVa1N5eWtKQzZOQXlpelFV?=
 =?utf-8?B?dEdIUE5KTlMxbjY4a0ZWdTBJaXE5TDZOa1FvUGFOM2FjbFA0L1YyKzZwcFN2?=
 =?utf-8?B?YkpxU0tkSENtenBPVVNDdG5DcHA0NGJUMTJuU0xhb0IydGdVM2M1dWtSQmFV?=
 =?utf-8?B?T0NPVFNlK1dFTFNpcHBMVEViSHVodlpaVXRTM1B1NEFrRWEzcFRoMUVIVEtw?=
 =?utf-8?B?VVhOSGF5MEVma09BMk1UT1MzUVUrUFJHbEN6S0Vld1VEL2QrY1NRQ3AzVHVT?=
 =?utf-8?B?eWJtQ1pyQjFVc1VOdXorOWRmTjJjVGpNNXBwdHM4UjhVVVB3ZEVmcFkrbEc3?=
 =?utf-8?B?MHRNbzZGT21pcWwrR0I2VTZkaTNPVXQvckwyZDZZQmJYVFhLajRmb1dYZUY3?=
 =?utf-8?B?OFlZZVZhTHgxd3p2MVBzSGpTbnJMVWpvWHFaWVoraEhteFRvVjdpczh1Ym9F?=
 =?utf-8?B?Q1BoUWgvZHJhZHpoa1ZPZzF3dHZjbmJRQTZQRURXUURobWhYNUJQckYzeElh?=
 =?utf-8?B?WXNFUlM5bEZRa1oyNng5TWlnV3ErZFAxUDdPOUlrZTNESXBzQmtmb1cra1gz?=
 =?utf-8?B?c2R2ZUZSQ0xGNE1zYU40SjZ3WWZRYS81NnBBd29tMndmaXBwM0tGdXFFS2Zx?=
 =?utf-8?B?eG84UTZ6eWU5TzE4QTBEbG15amhmamZqWWRHYy8rWWFkMTZZUnFoRVlaTEFq?=
 =?utf-8?B?Slo2TWJ6SERHaE8vWHlsaisyQUVCSjkxUWFhYTNGRllucStvdkxKZUtpSGNO?=
 =?utf-8?B?TDJMREZyYkRrUDAzN1FIbHlucUF5T3FJOXFIczl3WHpvbjlWbExwY3ZMMmd3?=
 =?utf-8?B?UG8vcGJhVngveEh4WHA3am1NMkplT3l4aE1La2dKZW5iTVJROTNiZ3ZnS0Mz?=
 =?utf-8?B?Q3lSaWtaY2c0UTBVU2R1dWZ3WHAyRnY5LzZWTVh2bnBDY21FM1p6QUN3QkFL?=
 =?utf-8?B?WVFqQzlXNllrWG9qLzZ5VnRkL1A3ZGZoR0FjVzhFRjZrOTlOaExTQStEVHdN?=
 =?utf-8?B?WFIzcWt3U0J4RUVMNTJQZFpUS0dNTE5VdXdJS1pTeDVXK0JlWHpkTEdhSDV2?=
 =?utf-8?B?bjlDb01Ydm9TNEx0UlQxemw1R24rRWpscWljK2RnMHdBNWVFSGNaRmk1Rit0?=
 =?utf-8?B?VW03eHFRRlhENTcrbkU5NFNMTjdSQWNBeEtqSDNhT09hSTluTjN0dkNGVzVi?=
 =?utf-8?B?SlRMRC9HWEpja3NaMkR5MnVKNmQ2WkEyd2xYTmhQRzlwMHcycE9Ib3V0bkZK?=
 =?utf-8?B?YkpvVGkvSmt4V2wwRENDY3RCbEFOQ2dDdE11K2ZFQko3QTk4RWsyNTl3czR3?=
 =?utf-8?B?N3NvVmlsMHV0UHVJSDBDTllCbU0xUDZvRlJFM3h6Ny9wem8rZEx0N3l3bXNI?=
 =?utf-8?B?NDlLNkR0WnR5KzZtK2FpMTJ6bHg1RHRib1JuR2dPd1htdTJtYkMzMXZablcv?=
 =?utf-8?B?TXZsdHZkcVREZmEyeDc1WS82OFE3bmNpY29RVGgvZFJtMC9vcFgrcExXOWoy?=
 =?utf-8?B?WEx0V3JZeWwrT1pSOUJhdS83VDJHTHFnU1QwY1RIdExqVFRNWmFlRmMrZjZa?=
 =?utf-8?B?Zkh5RmxLRm14empmaXVSWE1VeU9Dci9HL0ZnMDBUVmJLc0xuWTVCa1Awck1q?=
 =?utf-8?B?RThLY0hGL3I1N0Jid2hZd1FtNTVjNytiaGIyLythWGxScGIzeUxDWDU5UEVk?=
 =?utf-8?Q?QOCJKHK2hb3XnmbXsGRgtt/mH0WItgYGtrP2kCCznM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9CCB12D6BD2684687A9286E72E184CA@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB6270.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6086f9-ecd3-48f9-587c-08d9d71b928b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 05:06:07.1393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MVUbiftCK9AGM324ASzEbGEpWjQZhpVuhfzl7jpumHZ1AYR8hhLf971+TwGKkCq2QtXvbmArUFXQd9Zh3JiD6/1sUKaJh5bYHADerNiLzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2336
X-Proofpoint-GUID: V9AtB-aMxLl16HQFG-lx2pFXsg90_bxu
X-Proofpoint-ORIG-GUID: V9AtB-aMxLl16HQFG-lx2pFXsg90_bxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_01,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTEzIGF0IDE4OjQ0IC0wODAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
ICtSb2JlcnQNCj4gDQo+IFF1b3RpbmcgUWluZyBXYW5nICgyMDIxLTEwLTE0IDIzOjQ1OjI4KQ0K
PiA+IGNvY2NpY2hlY2sgY29tcGxhaW5zIGFib3V0IHRoZSB1c2Ugb2Ygc25wcmludGYoKSBpbiBz
eXNmcyBzaG93IGZ1bmN0aW9ucy4NCj4gPiANCj4gPiBGaXggdGhlIGZvbGxvd2luZyBjb2NjaWNo
ZWNrIHdhcm5pbmc6DQo+ID4gZHJpdmVycy9jbGsvY2xrLXNpNTM0MS5jOjE0NzE6IFdBUk5JTkc6
IHVzZSBzY25wcmludGYgb3Igc3ByaW50Zi4NCj4gPiBkcml2ZXJzL2Nsay9jbGstc2k1MzQxLmM6
MTQ4NjogV0FSTklORzogdXNlIHNjbnByaW50ZiBvciBzcHJpbnRmLg0KPiA+IGRyaXZlcnMvY2xr
L2Nsay1zaTUzNDEuYzoxNTAxOiBXQVJOSU5HOiB1c2Ugc2NucHJpbnRmIG9yIHNwcmludGYuDQo+
ID4gZHJpdmVycy9jbGsvY2xrLXNpNTM0MS5jOjE1MTY6IFdBUk5JTkc6IHVzZSBzY25wcmludGYg
b3Igc3ByaW50Zi4NCj4gPiANCj4gPiBVc2Ugc3lzZnNfZW1pdCBpbnN0ZWFkIG9mIHNjbnByaW50
ZiBvciBzcHJpbnRmIG1ha2VzIG1vcmUgc2Vuc2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
UWluZyBXYW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsv
Y2xrLXNpNTM0MS5jIHwgOCArKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9jbGstc2k1MzQxLmMgYi9kcml2ZXJzL2Nsay9jbGstc2k1MzQxLmMNCj4gPiBpbmRleCA1N2Fl
MTgzLi41ZDYyZGRiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1zaTUzNDEuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1zaTUzNDEuYw0KPiA+IEBAIC0xNDY4LDcgKzE0Njgs
NyBAQCBzdGF0aWMgc3NpemVfdCBpbnB1dF9wcmVzZW50X3Nob3coc3RydWN0IGRldmljZSAqZGV2
LA0KPiA+ICAgICAgICAgaWYgKHJlcyA8IDApDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBy
ZXM7DQo+ID4gICAgICAgICByZXMgPSAhKHN0YXR1cyAmIFNJNTM0MV9TVEFUVVNfTE9TUkVGKTsN
Cj4gPiAtICAgICAgIHJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVkXG4iLCByZXMp
Ow0KPiA+ICsgICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJWRcbiIsIHJlcyk7DQo+ID4g
IH0NCj4gPiAgc3RhdGljIERFVklDRV9BVFRSX1JPKGlucHV0X3ByZXNlbnQpOw0KPiA+ICANCj4g
PiBAQCAtMTQ4Myw3ICsxNDgzLDcgQEAgc3RhdGljIHNzaXplX3QgaW5wdXRfcHJlc2VudF9zdGlj
a3lfc2hvdyhzdHJ1Y3QNCj4gPiBkZXZpY2UgKmRldiwNCj4gPiAgICAgICAgIGlmIChyZXMgPCAw
KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmVzOw0KPiA+ICAgICAgICAgcmVzID0gIShz
dGF0dXMgJiBTSTUzNDFfU1RBVFVTX0xPU1JFRik7DQo+ID4gLSAgICAgICByZXR1cm4gc25wcmlu
dGYoYnVmLCBQQUdFX1NJWkUsICIlZFxuIiwgcmVzKTsNCj4gPiArICAgICAgIHJldHVybiBzeXNm
c19lbWl0KGJ1ZiwgIiVkXG4iLCByZXMpOw0KPiA+ICB9DQo+ID4gIHN0YXRpYyBERVZJQ0VfQVRU
Ul9STyhpbnB1dF9wcmVzZW50X3N0aWNreSk7DQo+ID4gIA0KPiA+IEBAIC0xNDk4LDcgKzE0OTgs
NyBAQCBzdGF0aWMgc3NpemVfdCBwbGxfbG9ja2VkX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0K
PiA+ICAgICAgICAgaWYgKHJlcyA8IDApDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXM7
DQo+ID4gICAgICAgICByZXMgPSAhKHN0YXR1cyAmIFNJNTM0MV9TVEFUVVNfTE9MKTsNCj4gPiAt
ICAgICAgIHJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVkXG4iLCByZXMpOw0KPiA+
ICsgICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJWRcbiIsIHJlcyk7DQo+ID4gIH0NCj4g
PiAgc3RhdGljIERFVklDRV9BVFRSX1JPKHBsbF9sb2NrZWQpOw0KPiA+ICANCj4gPiBAQCAtMTUx
Myw3ICsxNTEzLDcgQEAgc3RhdGljIHNzaXplX3QgcGxsX2xvY2tlZF9zdGlja3lfc2hvdyhzdHJ1
Y3QgZGV2aWNlDQo+ID4gKmRldiwNCj4gPiAgICAgICAgIGlmIChyZXMgPCAwKQ0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gcmVzOw0KPiA+ICAgICAgICAgcmVzID0gIShzdGF0dXMgJiBTSTUz
NDFfU1RBVFVTX0xPTCk7DQo+ID4gLSAgICAgICByZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJ
WkUsICIlZFxuIiwgcmVzKTsNCj4gPiArICAgICAgIHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVk
XG4iLCByZXMpOw0KPiA+ICB9DQo+ID4gIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhwbGxfbG9ja2Vk
X3N0aWNreSk7DQoNCkxvb2tzIGdvb2QgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBSb2JlcnQgSGFu
Y29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4NCg0KPiA+ICANCj4gPiAtLSANCj4gPiAy
LjcuNA0KPiA+IA0KLS0gDQpSb2JlcnQgSGFuY29jaw0KU2VuaW9yIEhhcmR3YXJlIERlc2lnbmVy
LCBDYWxpYW4gQWR2YW5jZWQgVGVjaG5vbG9naWVzDQp3d3cuY2FsaWFuLmNvbQ0K
