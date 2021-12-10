Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02146F9C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhLJEPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:15:42 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:12488 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229605AbhLJEPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:15:41 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BA4AWS7006204;
        Fri, 10 Dec 2021 04:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=JNCUajttUsUluyeOQq2q0XwPDVY3LCtuyRkVl3s98EU=;
 b=XarA2NUlmJFSK2pLI9ZeU/fHhwhYQvu9TZl5pRi8vDmvkCdlv7t2BPiGf3MHar6mAkq3
 DS4GDcJt9METlIkl7UpKybOu10+QdPlHWg2S/0mfZBOMw2psiLZaQYdDvf6YFGrg3mKc
 iCEP10oa8pNBJne5gK4Avg0G008lCsj3/6tqqUh2K5MFzUqSUH9lyOsJXab54a63qQvs
 3tfrF1OZ848osivtMCsEjshWHnaWeYY3/cnKT/366HMhxfS8J+7Jfn6ShzAIzFJcZoQ8
 dxqRpx8iolIQrkzGNajr1Pjux50foUFvf9c0a22sY09UnsGi2QNuNCYbaKha6RMjsrXo GQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cukc3ru1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 04:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enieh7cUr/h651ZpJduRX2GlViaVLQ1vhdSJU7eq+fj+icHPf4aOlaxJsrYKFdqiVWI3Q/MxeEW+Q+QMpB3bJ5UiIJeQFgpUD3RBEwUFsTbGq9Rz/1v0WZgrQvsYsz/Yj0ScbLuzDKF/jJGwBGWLKM4GK1mjCQ5hNdBTx6lLp0FpXvuENzLK0YSmav56TbFtQ26HgfF5yQ0Ys9SthHJTbQbd94tGHPSIFB2eIdwaYJqkADDhZuvhCVaFCe7B/xHkWHPf4UWiN7uqNQphUUHcwjAy90cJoOBAsRfJ/LJ2VygMB2bQdQaSlP8e3j4BPDCIaXmUAGzGgIZ1ElX1KBe2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNCUajttUsUluyeOQq2q0XwPDVY3LCtuyRkVl3s98EU=;
 b=nL5nPQK2M74ayEEvVDUgc0z/D7Vv4XDSZNluTY4fkSPUWyXtO/eLoNrv7vFhFNRhhmIUiQCoerer2VZOKWC8SBFkvZYi3zkFUDC5tUxMCG6Ff7exUW73McV+WnTuvDWBGpizX1ol+Lt9OLPGI6Tw698mCFIo5r6Jf+chruw5TNDP4wSGIUBAAf2so5yZO1VdvR73qhUNlUdhZ3Ie6vkBmgkY4Wmf325xho6mPwPEhSHmLe6dxTL+koiUBDWvt5X1XEBpbRMQR4dGIbcefwzGI96tVBth1r6vm/v/nC+0jI+7oqpCL8musyONlmXktbNuXnCieOxUJz8e5vHPLQtXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 04:12:01 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 04:12:01 +0000
From:   "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Thread-Topic: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Thread-Index: AQHX6pmcxPkY0584KkqiNfQmECIDV6wqDhAAgAEQimA=
Date:   Fri, 10 Dec 2021 04:12:01 +0000
Message-ID: <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
In-Reply-To: <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74e234a5-4ebf-4984-8d5d-08d9bb93379b
x-ms-traffictypediagnostic: PH7PR11MB5942:EE_
x-microsoft-antispam-prvs: <PH7PR11MB5942101697BE0F4464CB898895719@PH7PR11MB5942.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQkYVJR6KMlmquQb7qRwkfhCbz+MSfuwABgnuNwlf0biLehm1aFzCVbDRaG+qqNGbw9Lbe32pOnkhP+HBq4r6zgTKYfYKUP4oOtjDQHOKxwcc6SGVMWVlhcZOjFZCQCaEtJYRwyHxPOdwx+rNcR7HcE74ip8ChfLBi3BHNX1yYEKRNR/TulxqrFaT6mOa6gcm2oQUbXoDSl7mYCj+6ewGoRAHu6mJMjQIqdegnfVeBeuv7NMwH0k88bX4VNTxTGQyyPf7jd88xCBhPJZ52/MKCzOVq5qffO/48YFCoXp1MXVvsOIdjSRHyjrNRCHmtRKdcHugiSe7dnLXIUrR4QO91kqDUtLAOWHcseFspwF6qpXF3nd9dF1eOKgGspc/r6DCfei7RU7TiBxA8Wtya4lXqKRZ5NEb9P/xyyu+tHU8PayKEaDZzz12eCc2Tt0Vcnws4vCasSOyw5eP3jZm3uXHW+bjp2IRyZD9PASWz5dSB2sKCyfMIQ/oWkWkA90wcREjEmYwEiOrKKNgBCvmEHuLV/CwiboW3Z2RkBZqRegzIg/RfqlbPGNVbdWFEQxOd+7qwxGpyg6UIwfUKXh6nOFW4S6T7GWhZEemb867+0A7ONisQd8/s5mAs/Rw4n244hv/O790YV+tjSiiwHJuhr8QMgc82vKKgmJwnVo3NbrDROinc4zCvumyh65CsiJ2apfYefwOzXtZaSp82BPd9JWnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(9686003)(6916009)(54906003)(66946007)(8936002)(186003)(2906002)(55016003)(71200400001)(76116006)(86362001)(33656002)(38070700005)(66476007)(64756008)(66446008)(66556008)(7696005)(316002)(122000001)(4326008)(38100700002)(5660300002)(8676002)(53546011)(6506007)(52536014)(83380400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dktjdjN0dXA4NXJ3aVlFRFdMQmVsNi8rY1F1Y3BEOTRuY0lJTVhqWWNRR3FM?=
 =?utf-8?B?Q0RCaXpNL0tmQkFjb3FlSitUa2JvbkxxaUNoWWt1SGprWTAwdnZGYXZTSXdC?=
 =?utf-8?B?N3piZEpSZzVMVXorVmNmbllscFlBRzd5UmpwRmVvNHRQMHB6MFZDSWt3azcx?=
 =?utf-8?B?OE5aNklRbW5WOGcwYVlJdDFNYmpUMFVUbXhIK0JvY3IyVll1M3dlL0pHZnhp?=
 =?utf-8?B?alhnN1kvZ1pxZ2gvOEVmSEc1ZEVkdVVJYzZjbnRTQ2hXMUFXQVM5aCtxVHRj?=
 =?utf-8?B?TzJNTTliZGxCcXUzOVNZMlVDeG4rU3hZY1V3QkdMK2lORzhnVUY5RS9mcU9I?=
 =?utf-8?B?ako2UzI3NHNHblMrUHQ5NHBuL1FYVjFJMmFKdURwVng5dmJ3RzhISVhnQVVt?=
 =?utf-8?B?Z29FMmtsTm1IWFZhQzlvYVhjeXZzai9MSkhjM3ppMGhRZHRyNWtXWnFPbkhq?=
 =?utf-8?B?a2M2QnphNmJXVmFBY2RYbDJ0OHBPeWowUUcyelFDUDdGeFVObDRqelhSTjg1?=
 =?utf-8?B?cGRncVZZVGIzcW9LdURUcHpmSktsVHVTK09vOTlzeks2dlVjbTYyVTNUYnZo?=
 =?utf-8?B?NjlPSzRrcGhDWThLQWRySWZ3U2FEaTdUSVM0VnRzWmNQcEc2U3liY0FySGdO?=
 =?utf-8?B?UmNDMEhFclhTek4wT3ozcVRpV3JYVjNxMVRjckFBenIrRTNtV29rM3Ruazdj?=
 =?utf-8?B?ZDFJWDBaOE9XaFViMWZSTXlhUytHb0JHckNGN1lIZktjU2FPNUNIVVVIYm8r?=
 =?utf-8?B?d0JjY0xrM1FRQ2Fuc1QwcTMyTldOTzdaemg1dk1zQnY2OFFkYXpjdlJRRlRR?=
 =?utf-8?B?VWh5LzBpSTlPWUlCMHAyTVZMSWU0RGk1VVg4UnBKWDdObzRySlpzWnhPWGNP?=
 =?utf-8?B?R0pIOWMrVTgwb2g0dXdGRCtUcGJYL1RoTTJLQXFMTG1iL21YZG9iVWZFZy9n?=
 =?utf-8?B?anhHNXQxVCt5V2FabXI3dVBPdnMzN1IzNG9kMGkrQTIybzVIMzVsVmdRSWxi?=
 =?utf-8?B?TndseWNsYmJlSnJFa1B4ZlpDZ2VnRFNBRERhYlNUek92REtHVEF4ZTlTSk1j?=
 =?utf-8?B?SFRKSjRpRGRRQmswZ0pXYldma2YwKy9tUmRYdzZpSlFjdVkzVFVVa2NQbTEx?=
 =?utf-8?B?UXB2TE0wWWtaSzNpZXl3ck1LVFhoUnRGelRGWUhHemp0b0pzVi9ZVkRpcjNK?=
 =?utf-8?B?TWtaaHZQbVJ5R2pJTVd6TFhNbUU1aEJPQUorMlpMTEIyMWpCMjd3VFZUNU8w?=
 =?utf-8?B?YnJ5UHhjS3hPdVJRNmF0NkJueHdBN3JaQ2MrUVkxK3dtczkxWjdSbG5FRmpJ?=
 =?utf-8?B?OGxOazEyL21tdHRJS1duQXhzTG5VaUcwaklCaytSWEN6Z3lybHRrdVVuYnJS?=
 =?utf-8?B?Wkk0dWFlU1RQb2xsSjFFWWRUTVFKQzJPS21mU1ZLQ00wNkh0NC96NW8rRndK?=
 =?utf-8?B?MjFVSzluOGZJUzh6ek1LYVBqVDMrQytPeEV5WWhsL1lCeFNQZWx6L2R5UHpH?=
 =?utf-8?B?ajVZb2RPdVdPbFJmdzNJNHJDaGpBRmZHK21RYmJkZHlobWwyUUlRTmZTb2cr?=
 =?utf-8?B?YmJUa3JuMWdpUU9YQXI1VzdqKzJnSkRDUTVENkxMdWFieXpadkJSMVcveldB?=
 =?utf-8?B?VDJGNUIrYmsxS1BONmIvZ3UyQ0lQSENEL0JybU5sd2ZuNUxJV0dWOGNGRlVz?=
 =?utf-8?B?Q3hPcVlIczlHcU1hT3N3eTdZQWNqV1hCTGR6V3BMcVpLTmxGM2hTUlZvcWli?=
 =?utf-8?B?UHQ0U0g5WmhtOVkvakQrb3dYVERzbm9NSlRnUDB5eURqLzFPMStUcnFGM2g1?=
 =?utf-8?B?Myt5cEg1dXM5UmF2MEdVak1KTEIvQ3FTR3BnaU43Q2hrb3BjUGVRUmtiQWFH?=
 =?utf-8?B?dHRKVk1qeUJXczNQb2ppTFVRc0RUQ3ZBZG5UbUp6QVpFOWpScDE5UjNjVkVt?=
 =?utf-8?B?WVlCUDVHeCtmaHAyLzE4aVZTYnlrUkNtSzI3Zm9vcnRhaFc2U2VzblBtaVcv?=
 =?utf-8?B?UFB0YUM2Uis5LzlMUHpoa3A0WWozTXYrK3lVQzVCemlsa2FMSXF3dzNEaysr?=
 =?utf-8?B?VFNyTHU4UlljSzZtM293OEN5M0NsTldjWTAwRWVERy9lcTBSZGp5a1czbE1H?=
 =?utf-8?B?akJKS3pFVmJVb3lBdEEvMllOSHVzbHhkdGkwQUs4UjdKUFlWWWNseVFWK1gw?=
 =?utf-8?B?TDYxUGk4dFdPUDNTbkRrNGJDRVZKVFRZN214NVlVNDhHODA2UDRXYUQ0Wkgr?=
 =?utf-8?B?OExHUjhvaTFsNEdPcjVyQzNRa1VnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e234a5-4ebf-4984-8d5d-08d9bb93379b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 04:12:01.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHuxstW7On5y7ifNcMFWh7zgx3XrVvjIKTyW9NzmkXIuUmqfNE+gSjHXFR9t017U7bvjhcM4ooIqZDMiyS8rGtmHZ2BEmBk3Lywqd36XZmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-Proofpoint-ORIG-GUID: fC3O-1GNEijF90oyRDmxAr4amw6uvUz9
X-Proofpoint-GUID: fC3O-1GNEijF90oyRDmxAr4amw6uvUz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_01,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTdW1pdCBHYXJnIDxzdW1pdC5n
YXJnQGxpbmFyby5vcmc+IA0KU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDksIDIwMjEgNzo0MSBQ
TQ0KVG86IFdhbmcsIFhpYW9sZWkgPFhpYW9sZWkuV2FuZ0B3aW5kcml2ZXIuY29tPg0KQ2M6IGpl
bnMud2lrbGFuZGVyQGxpbmFyby5vcmc7IG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBvcHRl
ZTogU3VwcHJlc3MgZmFsc2UgcG9zaXRpdmUga21lbWxlYWsgcmVwb3J0IGluIG9wdGVlX2hhbmRs
ZV9ycGMoKQ0KDQpbUGxlYXNlIG5vdGU6IFRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhURVJOQUwg
ZS1tYWlsIGFkZHJlc3NdDQoNCk9uIE1vbiwgNiBEZWMgMjAyMSBhdCAxNzozNSwgWGlhb2xlaSBX
YW5nIDx4aWFvbGVpLndhbmdAd2luZHJpdmVyLmNvbT4gd3JvdGU6DQo+DQo+IFdlIG9ic2VydmVk
IHRoZSBmb2xsb3dpbmcga21lbWxlYWsgcmVwb3J0Og0KPiB1bnJlZmVyZW5jZWQgb2JqZWN0IDB4
ZmZmZjAwMDAwNzkwNDUwMCAoc2l6ZSAxMjgpOg0KPiAgIGNvbW0gInN3YXBwZXIvMCIsIHBpZCAx
LCBqaWZmaWVzIDQyOTQ4OTI2NzEgKGFnZSA0NC4wMzZzKQ0KPiAgIGhleCBkdW1wIChmaXJzdCAz
MiBieXRlcyk6DQo+ICAgICAwMCA0NyA5MCAwNyAwMCAwMCBmZiBmZiA2MCAwMCBjMCBmZiAwMCAw
MCAwMCAwMCAgLkcuLi4uLi5gLi4uLi4uLg0KPiAgICAgNjAgMDAgODAgMTMgMDAgODAgZmYgZmYg
YTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIGAuLi4uLi4uLi4uLi4uLi4NCj4gICBiYWNrdHJhY2U6
DQo+ICAgICBbPDAwMDAwMDAwNGMxMmIxYzc+XSBrbWVtX2NhY2hlX2FsbG9jKzB4MWFjLzB4MmY0
DQo+ICAgICBbPDAwMDAwMDAwNWQyM2ViNGY+XSB0ZWVfc2htX2FsbG9jKzB4NzgvMHgyMzANCj4g
ICAgIFs8MDAwMDAwMDA3OTRkZDIyYz5dIG9wdGVlX2hhbmRsZV9ycGMrMHg2MC8weDZmMA0KPiAg
ICAgWzwwMDAwMDAwMGQ5ZjdjNTJkPl0gb3B0ZWVfZG9fY2FsbF93aXRoX2FyZysweDE3Yy8weDFk
Yw0KPiAgICAgWzwwMDAwMDAwMGMzNTg4NGRhPl0gb3B0ZWVfb3Blbl9zZXNzaW9uKzB4MTI4LzB4
MWVjDQo+ICAgICBbPDAwMDAwMDAwMTc0OGYyZmY+XSB0ZWVfY2xpZW50X29wZW5fc2Vzc2lvbisw
eDI4LzB4NDANCj4gICAgIFs8MDAwMDAwMDBhZWNiNTM4OT5dIG9wdGVlX2VudW1lcmF0ZV9kZXZp
Y2VzKzB4ODQvMHgyYTANCj4gICAgIFs8MDAwMDAwMDAzZGYxOGJmMT5dIG9wdGVlX3Byb2JlKzB4
Njc0LzB4NmNjDQo+ICAgICBbPDAwMDAwMDAwM2E0YTUzNGE+XSBwbGF0Zm9ybV9kcnZfcHJvYmUr
MHg1NC8weGIwDQo+ICAgICBbPDAwMDAwMDAwMGM1MWNlN2Q+XSByZWFsbHlfcHJvYmUrMHhlNC8w
eDRkMA0KPiAgICAgWzwwMDAwMDAwMDJmMDRjODY1Pl0gZHJpdmVyX3Byb2JlX2RldmljZSsweDU4
LzB4YzANCj4gICAgIFs8MDAwMDAwMDBiNDg1Mzk3ZD5dIGRldmljZV9kcml2ZXJfYXR0YWNoKzB4
YzAvMHhkMA0KPiAgICAgWzwwMDAwMDAwMGM4MzVmMGRmPl0gX19kcml2ZXJfYXR0YWNoKzB4ODQv
MHgxMjQNCj4gICAgIFs8MDAwMDAwMDA4ZTVhNDI5Yz5dIGJ1c19mb3JfZWFjaF9kZXYrMHg3MC8w
eGMwDQo+ICAgICBbPDAwMDAwMDAwMTczNWU4YTg+XSBkcml2ZXJfYXR0YWNoKzB4MjQvMHgzMA0K
PiAgICAgWzwwMDAwMDAwMDZkOTRiMDRmPl0gYnVzX2FkZF9kcml2ZXIrMHgxMDQvMHgxZWMNCj4N
Cj4gVGhpcyBpcyBub3QgYSBtZW1vcnkgbGVhayBiZWNhdXNlIHdlIHBhc3MgdGhlIHNoYXJlIG1l
bW9yeSBwb2ludGVyIHRvIA0KPiBzZWN1cmUgd29ybGQgYW5kIHdvdWxkIGdldCBpdCBmcm9tIHNl
Y3VyZSB3b3JsZCBiZWZvcmUgcmVsZWFzaW5nIGl0Lg0KDQo+IEhvdyBhYm91dCBpZiBpdCdzIGFj
dHVhbGx5IGEgbWVtb3J5IGxlYWsgY2F1c2VkIGJ5IHRoZSBzZWN1cmUgd29ybGQ/DQo+IEFuIGV4
YW1wbGUgYmVpbmcgc2VjdXJlIHdvcmxkIGp1c3QgYWxsb2NhdGVzIGtlcm5lbCBtZW1vcnkgdmlh
IE9QVEVFX1NNQ19SUENfRlVOQ19BTExPQyBhbmQgZG9lc24ndCBmcmVlIGl0IHZpYSBPUFRFRV9T
TUNfUlBDX0ZVTkNfRlJFRS4NCg0KPiBJTU8sIHdlIG5lZWQgdG8gY3Jvc3MtY2hlY2sgb3B0ZWUt
b3MgaWYgaXQncyByZXNwb25zaWJsZSBmb3IgbGVha2luZyBrZXJuZWwgbWVtb3J5Lg0KDQpIaSBz
dW1pdCwNCg0KWW91IG1lYW4gd2UgbmVlZCB0byBjaGVjayB3aGV0aGVyIHRoZXJlIGlzIGEgcmVh
bCBtZW1sZWFrLA0KSWYgYmVpbmcgc2VjdXJlIHdvcmxkIGp1c3QgYWxsb2NhdGUga2VybmVsIG1l
bW9yeSB2aWEgT1BURUVfU01DX1BSQ19GVU5DX0FMTE9DIGFuZCB1bnRpbCB0aGUgZW5kLCB0aGVy
ZSBpcyBubyBmcmVlDQpJdCB2aWEgT1BURUVfU01DX1BSQ19GVU5DX0ZSRUUsIHRoZW4gd2Ugc2hv
dWxkIGp1ZGdlIGl0IGFzIGEgbWVtb3J5IGxlYWssIHdvIG5lZWQgdG8ganVkZ2Ugd2hldGhlciBp
dCBpcyBjYXVzZWQgYnkgc2VjdXJlIG9zPw0KDQpUaGFua3MNClhpYW9sZWkNCg0KDQo+IC1TdW1p
dA0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFhpYW9sZWkgV2FuZyA8eGlhb2xlaS53YW5nQHdpbmRy
aXZlci5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jIHwgMiArKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jIGIvZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jIA0K
PiBpbmRleCA2MTk2ZDdjMzg4OGYuLmNmMmUzMjkzNTY3ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy90ZWUvb3B0ZWUvc21jX2FiaS5jDQo+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3NtY19hYmku
Yw0KPiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgI2luY2x1ZGUgIm9wdGVlX3ByaXZhdGUuaCINCj4g
ICNpbmNsdWRlICJvcHRlZV9zbWMuaCINCj4gICNpbmNsdWRlICJvcHRlZV9ycGNfY21kLmgiDQo+
ICsjaW5jbHVkZSA8bGludXgva21lbWxlYWsuaD4NCj4gICNkZWZpbmUgQ1JFQVRFX1RSQUNFX1BP
SU5UUw0KPiAgI2luY2x1ZGUgIm9wdGVlX3RyYWNlLmgiDQo+DQo+IEBAIC03ODMsNiArNzg0LDcg
QEAgc3RhdGljIHZvaWQgb3B0ZWVfaGFuZGxlX3JwYyhzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW0tPmE0ID0gMDsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcGFyYW0tPmE1ID0gMDsNCj4gICAgICAgICAgICAgICAgIH0NCj4gKyAgICAg
ICAgICAgICAgIGttZW1sZWFrX25vdF9sZWFrKHNobSk7DQo+ICAgICAgICAgICAgICAgICBicmVh
azsNCj4gICAgICAgICBjYXNlIE9QVEVFX1NNQ19SUENfRlVOQ19GUkVFOg0KPiAgICAgICAgICAg
ICAgICAgc2htID0gcmVnX3BhaXJfdG9fcHRyKHBhcmFtLT5hMSwgcGFyYW0tPmEyKTsNCj4gLS0N
Cj4gMi4yNS4xDQo+DQo=
