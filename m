Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB344A3247
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 23:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353590AbiA2WEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 17:04:08 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:8775 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353381AbiA2WC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 17:02:58 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20TM0NuV027396;
        Sat, 29 Jan 2022 17:02:43 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2059.outbound.protection.outlook.com [104.47.61.59])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dw3c7g4jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jan 2022 17:02:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBLMCnokmDFpYUMEAmDdXauT+lphWu8UyPxZ5tXvn/glP/5d7W/bLfJk1D4adqH+zRrAanHSGKVNbGu7vmPTzwTCZBnxywSy7HVYy782mJDDO07ZM2rLVD9Gsjku14M4qzSCCFMo7htrTvF1cuXjqESeb1JykMkdOeUw01rKPHxAjx7ak/VkQIUC45SkXvJ9ExccKixQPyztwnxVHvbLm1ibuHDQwHj1wtH74cw8KoWDgpIHwf0a4ur59o1ROMhS5oPSAd2awBc+g2AQ2+BupeKRR9z8FvZ4VNCWMee5L9NhUvxxytq96xgCI91hBuMZWn8Kq1GuaAfOYlEBOt0O5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDTp3n+hEpORRcllD0KQAdGB06J6rDdQbBA4UzsI7qQ=;
 b=Zr5RUvlZ51sCLQ2Ktx5vucBHKJKWZ+qR/E6HOVatOk1chETfSVZgDg7eKIk10U9GXBYMNyDKnnNt1OEBVdWU6xxsVoJA1VddIgNNPkW2d0NuiD+Sm/g8LIY2LFNXbFRu7FL6FGLqp8uGPshJn1GCBzoGEdgAUsi7d798jAnmfP75CbViqkCI16ltDR0wkTZ6fbD1b655ompQq+QbhBiYvZaV4u0Vi1Cgo4th57KoAOhd48tXvVsVO9IjexbFi14ykiqsbGdhsyH4wxS2nQwxlCsSLrvLPiqHyFIt8gQd2XaV1c/z5eggrxD5+bj1vKXatH8KwzjmxGjtVdnZq3goqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDTp3n+hEpORRcllD0KQAdGB06J6rDdQbBA4UzsI7qQ=;
 b=pS4rE4CHBGGVqFYP7HTOcet0I2yAZcnKCutLiC0agbhCtDCHxQc7XlG4dyQKGz3y1bdvCSNp1nwmZMMy05sBK74fI6Cl+rG/bDcnNr/y+omB4gxyKXepadOvaxCrKgXS7YitFk8InPxOhJCoBGKU4a2hBgKVUyiBjBSy/fl1z7A=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQBPR0101MB4650.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 22:02:41 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230%5]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 22:02:41 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "giometti@enneenne.com" <giometti@enneenne.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rasm@fe.up.pt" <rasm@fe.up.pt>,
        "jamesnuss@nanometrics.ca" <jamesnuss@nanometrics.ca>
Subject: Re: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
Thread-Topic: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
Thread-Index: AQHYB/aUXMbW1PjF3k+egd8Abg1LR6xf4N0AgAC7WYCAGgu6AA==
Date:   Sat, 29 Jan 2022 22:02:41 +0000
Message-ID: <f74e32552955b2293d814cfd14729ab190d8ddbe.camel@calian.com>
References: <20220112205214.2060954-1-robert.hancock@calian.com>
         <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
         <d21aeae0-f75d-f8b9-032a-f4751696d467@enneenne.com>
In-Reply-To: <d21aeae0-f75d-f8b9-032a-f4751696d467@enneenne.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddaa96c9-c134-4d53-4ac8-08d9e37311ea
x-ms-traffictypediagnostic: YQBPR0101MB4650:EE_
x-microsoft-antispam-prvs: <YQBPR0101MB465078D37D68919DA40197C2EC239@YQBPR0101MB4650.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUU/lPegDNc8HZDctzdfyyQDgHdxD4pFWYjWPludujFJw8kFQdY1edcI6wFNaVNA48DWdTM5+/EDsVeVZ9AhbSIFc45ccotQxi32rm9wwRemnD7AaRf9orw713wBGR1vuE/TbRs4RMBnYcRVj1geYLkjLFIab47VT8wOkjndlF/GbqA1QDNnPXNgPICT3HGHr3Y3AZtg8YJBVsXiXifpQrTiMsgaGHkmvKc6EwLtIcinB+tFnMDONp2SLCjfp2tGzxK8CZJDSxtqiPmwoVmv+jy+oMXj8T+p3dnJdu21nEEeIljEvljMV19L2WCUNWchGJM2f3fQHWiCiqlXoafJORme/JSKVzwgX+hZlZMEE1XpN6VCiF0orsHXG0BzKAwuzXU56UyMVnnZYDxUzdrZuAbNxNFe70OaQKtWxYzI21Q+aVporD1HwaQJYdCgjA3NsyG7ALCQUqr6RVDGWSA3bWx+eVmoI1r5DOZlFmbkYxYdj82PlkebXy3C7mYbdd2eJlHUj0BLlddlVGYyJgjG4D/9tTeq8UgDbELV9WAXciE0hVlq5Shj22KezKlOYjxvHkLCtD8goVFfJHmlySG9gGSpCzFdrIhjyMZ6gZsbgvK2caoaURJ0kmUhUICyGwwOzN+0ZbM8O5xOPCVbyk/RSYEm22fNa3HGQGRfAFJvkidFQ8Vr1JM1eReKFMm4sugOTT6zZq7d5SoDlyxe0WMv+WzGcntsyQrctKmIcfX99uX2Lgdoj1vqSdiRqpWCAjPHaiXMtGMmfxnhSoqJsOm8NAJVzSb51lJ8vbEoJ/kipPdFuw6+yS3Dxmo23yvKnFEfSWXb5c1uw3+sZWEA9kY8kKYiQArMmTVAs8fYEZ6U9m0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(15974865002)(110136005)(6512007)(2906002)(86362001)(6486002)(508600001)(4326008)(122000001)(53546011)(91956017)(38100700002)(316002)(76116006)(26005)(6506007)(8936002)(186003)(44832011)(5660300002)(71200400001)(66446008)(66946007)(66556008)(66476007)(8676002)(64756008)(83380400001)(2616005)(36756003)(38070700005)(99106002)(18886075002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnlVNEFTWDFwd2NIS0w1SnlTL3FqWll5TWszckdBczFnUjg2QmdCcWFnQWJX?=
 =?utf-8?B?ZFl1YUE3emhaSXBJM2VqTG80NnJVQnN5WEpPODlicVl0MFUyV0EwbE1RUnRK?=
 =?utf-8?B?RSswT1p3MWZLMStXVnFVVk9ZemJnem1SNGczRjJZYXd1UHFrUWhjQkw2ekdC?=
 =?utf-8?B?eUpzWXVGa2hsMFlucWFBbkJxb2FJUEZvS1UxKzQ5bzMyTFpjc01hdXdOcXNi?=
 =?utf-8?B?dGJmRm5NWVBWWWVvbHhoVG1XS2dvNmp1Zi9hQUFSaHRkdnlBM2JibTV2UzU2?=
 =?utf-8?B?c3JMUjFYaGkrV1pqUmlGV3JyS3NIT3pLb01PeTArc2h6V1RleTBoSWl0U1dF?=
 =?utf-8?B?TUtIdlJaT0kyNTVyNnRXSGZOaU5KeE16V2JSdlpsQ0FzTFlNdzBWaUl5UzJI?=
 =?utf-8?B?QlpkZEt1ZnVDNHVrWmtzek1oZmlWOHhSS2lVUFltaStzaHV2Q2xONHp0Z1hS?=
 =?utf-8?B?RnYwOW9KZk1oVFppdmR3RGFRQlJIMUM3SmlPMWRBT0krOTBKQ2xEeVFrV0Zl?=
 =?utf-8?B?M1g0QXBOc0hnOVdaNDJab04zR2VzUUM5MGVCVmU0UGZ4NXJJaUxsUlVBQzhi?=
 =?utf-8?B?eDIydHNjc2xzSFNDVXdvUWpPbGZSTEZEeWt6bUFKL2lKaXBwMWRxRUFDN2xx?=
 =?utf-8?B?L1lqeU40SWRKMHk5M0E2U1Y0U2YvR3d0ODh5cnpmR2dSYTB0cVhPS3Q1Q1Jw?=
 =?utf-8?B?TjBaSll3L2o5N3I4MlBFMU1sd0Nyblg5ZzBGMXJqZFFteWM1TUM4MS9WbVlC?=
 =?utf-8?B?a0t2aU9OT1J2NU03N1dENlM2OTRJdkZoNFl3aDNyYytYQ2dGU3k2bzFoa1R0?=
 =?utf-8?B?WWpWWjIvMC8xdkZPcDRHYWswMDhXUXlJQUNjbVhZQm8yeW9mSEpUdmI0aFJ3?=
 =?utf-8?B?ZDc1TncvSkN6eStsTzVhempBRW9ON1hYZDBjWDB5eTFza28xY0NBSFRZaXh1?=
 =?utf-8?B?YUszYkRka2pzL0ZtaXA1dWF2RjV5NkJXZ2tyeXhSbXN0QSsrWEtINE1VVkc2?=
 =?utf-8?B?SEMwSXhtUGJlSkFPTmZiR1RoS01udnRXd1JwcDV2dVMxZmdpQ2dUU0tnMFM5?=
 =?utf-8?B?L2JaSWZPeHlZOUhibVhTb1I2ZXd4dG1JZ0pVUHBseHV5R2NsMUt5TnBUa2pL?=
 =?utf-8?B?WkF5VjltUzNvUlVXT0lrMWUvVndZdUlTdWcxOVA5U013aEIwbXM2c2FvblBB?=
 =?utf-8?B?NHE3VFhrUjhZOGJyOUIwbXRLMEZ6R0IwUXNmTzdtNm80QWU5OWtaK1J4SGVm?=
 =?utf-8?B?cC9KVzhNaXpaS1JYMW16WXNRWVFRalBYVVdzYVNmWTZUQUliSEl3bTdYR0hD?=
 =?utf-8?B?c0E1bDFVaDAwRjc0eXVwQkNIVzV5eGk1QnhCUDFDTWtZa3NuM1RoSW9oM3NN?=
 =?utf-8?B?MWlZOE5DZEdzWnR0YXMwK3Yyek1rM0ZYNUFjV09QdmtpQXFSak54RzVkWldG?=
 =?utf-8?B?TVVoRnVHQWRIdmdWenFnQ1Qwb2VsdUttbHZKN0Nta04wNDFiVTNIQUxrODE1?=
 =?utf-8?B?VEdwU09LT0YybkE4VWlnN2tXUG0xNUo1ci9zZ3NqVGtiRmw1bjV1ZjNUOWp5?=
 =?utf-8?B?NjhTd0RpYWNnMmVicjQ3WnFtTkNSc3RzMVRsdWtza2hzbjYxMVNaOU1FSlVQ?=
 =?utf-8?B?cGlMcWtwajZwdzFSVHdBRVRDZUJmcml5VVRJTzZ3NkdkcDlrUkV1OXNsK3hN?=
 =?utf-8?B?UFc5Zi9qUlVtc3FDL050YkZOOWxmcFUyZlo3SlN6eXVrL2hMODlodzRtUU1a?=
 =?utf-8?B?OVEveFZJU2ZvRm8vaURON3dPM3NENjMrWU43Zk56TmdIcUtqbHk5bG1rVk1a?=
 =?utf-8?B?dEQyR0g2VDVFQmFtNWtFYnJGTzc4amVoWVFzMThQSFUvRWZONXNRMkMvcEl1?=
 =?utf-8?B?MTNzVDllRWdjRGtlaVdhakJwTXc2cG1jaFNIb1A1cDUyZUhiTjdYd1FQbVUz?=
 =?utf-8?B?aHkzQ2h4REl4Ry9YZ2tTWDZtR3pRendHa2VEOUh4d0NWbExWeXVYbFJYSkVH?=
 =?utf-8?B?REN3ejJXYUF3WWJVSHdEbnhMRDZTVzdoVmZrVFJYbm5zMVpPdjJCMm5ZSERa?=
 =?utf-8?B?RkhMbFNPOExoS2VQQjFvMFRsY3BWNU1JSms4R3NRR3IwQVAxTHRGU0REM0RF?=
 =?utf-8?B?Zmc2dmF6U0I4c003MFlHUmFla3Q0OHRUYzF3bCtaNm9ldUNjTDZ4RHAxMEIx?=
 =?utf-8?B?SzBpYzgxOWRJcFl1UzhUcXdhUmJkY2RVL1FoQmFoU3lLd3FHdWF3a3VzZnJl?=
 =?utf-8?Q?2K3eGqcU9u+szAiEg5BazC5yZvUxn+lkgBpfCVxhG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E0AAF6E0677C44CB7075E3E346850FD@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaa96c9-c134-4d53-4ac8-08d9e37311ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 22:02:41.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiRD6GOM1U6R/w1iLMfb1hDG4e5kqVAjg5c2mSGwrUcSqBLYLf7BDO8ywCz7ACLlJlxEkHheNXOUwQ5LTHmd7W2Mq00qj6fF4HX1QlZh56M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB4650
X-Proofpoint-ORIG-GUID: gXCk_GdfaM0z7hOzvXfxTb4u7DPUcGzM
X-Proofpoint-GUID: gXCk_GdfaM0z7hOzvXfxTb4u7DPUcGzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-29_12,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201290146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTEzIGF0IDA5OjE3ICswMTAwLCBSb2RvbGZvIEdpb21ldHRpIHdyb3Rl
Og0KPiBPbiAxMi8wMS8yMiAyMjowNywgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+IE9uIFdl
ZCwgSmFuIDEyLCAyMDIyIGF0IDAyOjUyOjE0UE0gLTA2MDAsIFJvYmVydCBIYW5jb2NrIHdyb3Rl
Og0KPiA+ID4gSWYgdGhlIHBwcy1ncGlvIGRyaXZlciB3YXMgcHJvYmVkIHByaW9yIHRvIHRoZSBH
UElPIGRldmljZSBpdCB1c2VzLCB0aGUNCj4gPiA+IGRldm1fZ3Bpb2RfZ2V0IGNhbGwgcmV0dXJu
ZWQgYW4gLUVQUk9CRV9ERUZFUiBlcnJvciwgYnV0IHBwc19ncGlvX3Byb2JlDQo+ID4gPiByZXBs
YWNlZCB0aGF0IGVycm9yIGNvZGUgd2l0aCAtRUlOVkFMLCBjYXVzaW5nIHRoZSBwcHMtZ3BpbyBw
cm9iZSB0bw0KPiA+ID4gZmFpbCBhbmQgbm90IGJlIHJldHJpZWQgbGF0ZXIuIFByb3BhZ2F0ZSB0
aGUgZXJyb3IgcmV0dXJuIHZhbHVlIHNvIHRoYXQNCj4gPiA+IGRlZmVycmVkIHByb2JlIHdvcmtz
IHByb3Blcmx5Lg0KPiA+IA0KPiA+IEZXSVcsDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNo
ZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiANCj4gQWNrZWQtYnk6
IFJvZG9sZm8gR2lvbWV0dGkgPGdpb21ldHRpQGVubmVlbm5lLmNvbT4NCg0KSXQncyBub3QgZW50
aXJlbHkgY2xlYXIgdG8gbWUgd2hhdCB0cmVlIFBQUyBwYXRjaGVzIGFyZSBzdXBwb3NlZCB0byBn
byB0aHJvdWdoLg0KU2VlbXMgbGlrZSBzb21lIHJlY2VudCBvbmVzIGhhdmUgZ29uZSB0aHJvdWdo
IGNoYXItbWlzYz8gTm90IHN1cmUgaWYgc29tZW9uZQ0KaGFzIHRoaXMgaW4gdGhlaXIgcXVldWU/
DQoNCj4gPiA+IEZpeGVzOiAxNjE1MjA0NTFkZmEgKHBwczogbmV3IGNsaWVudCBkcml2ZXIgdXNp
bmcgR1BJTykNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBIYW5jb2NrIDxyb2JlcnQuaGFu
Y29ja0BjYWxpYW4uY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9wcHMvY2xpZW50cy9w
cHMtZ3Bpby5jIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wcHMvY2xp
ZW50cy9wcHMtZ3Bpby5jIGIvZHJpdmVycy9wcHMvY2xpZW50cy9wcHMtDQo+ID4gPiBncGlvLmMN
Cj4gPiA+IGluZGV4IDM1Nzk5ZTY0MDFjOS4uMmY0YjExYjRkZmNkIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9wcHMvY2xpZW50cy9wcHMtZ3Bpby5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Bw
cy9jbGllbnRzL3Bwcy1ncGlvLmMNCj4gPiA+IEBAIC0xNjksNyArMTY5LDcgQEAgc3RhdGljIGlu
dCBwcHNfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gPiAqcGRldikNCj4g
PiA+ICAJLyogR1BJTyBzZXR1cCAqLw0KPiA+ID4gIAlyZXQgPSBwcHNfZ3Bpb19zZXR1cChkZXYp
Ow0KPiA+ID4gIAlpZiAocmV0KQ0KPiA+ID4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArCQly
ZXR1cm4gcmV0Ow0KPiA+ID4gIA0KPiA+ID4gIAkvKiBJUlEgc2V0dXAgKi8NCj4gPiA+ICAJcmV0
ID0gZ3Bpb2RfdG9faXJxKGRhdGEtPmdwaW9fcGluKTsNCj4gPiA+IC0tIA0KPiA+ID4gMi4zMS4x
DQo+ID4gPiANCj4gDQo+IA0KLS0gDQpSb2JlcnQgSGFuY29jaw0KU2VuaW9yIEhhcmR3YXJlIERl
c2lnbmVyLCBDYWxpYW4gQWR2YW5jZWQgVGVjaG5vbG9naWVzDQp3d3cuY2FsaWFuLmNvbQ0K
