Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74424A766F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbiBBREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:04:37 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:39803 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbiBBRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:04:29 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212BcsQK017138;
        Wed, 2 Feb 2022 12:04:15 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2053.outbound.protection.outlook.com [104.47.61.53])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dxpx912bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 12:04:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja0HlgCDqBCXI+jlIzYKbjb9P9YEs4ILNXmw7pAqqVXKuGmuMaQNPvpnJaPZHAknkEx4R9/DLPc76vlqH64m8mdtNpIJg8PuL1ENnpszLtL9VRqH/n5HN8dTHFGQlvJbOvmosUImfSeu7WaHHk9eBEEcv+R528pCuq463Q92nGoj4AUptEzqw0PIw2hjRMlJn0mz214tjX0g9QlbOiw86WMLu0IDebvkHgabwXh2JNLLnnWc5qHBU/Fn7xoqVBVpHWvoCD2pzg74FHuVQ6RwZhoZUhtF8VBSAEyM0NC/NE9Go8G1PGqJI0vx7P1rPuQReNTp+CCeKSznzM/c89Ab2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xx8ztWGA+nmD4dY+KVPJkxispZz0+3gbvJqsRsDmHA=;
 b=YcZt0UwAisGuqZkYJf8wOMhhMiRReRdP6druAk8uc1ezbQNwxOb1FQDcA5cGcECmS/ccPeoMOAxro5JRh6b/xFM3qjqj5qalWzQHddgzfwoYVryxvNfi7rn72iOYjcgzqO9yJ8TmBMdKkgDuxTSG16G6BUWLhG2bkaGHh73irBzCNBZ08KiJx2HlX+n6gfsLaJ0Vkx+V+m8TK98dRzKTO46TkYoOR4PH5eiCKOEvsrTGzQkaBXyhBebCQHrzhYC7O/zBhQDLNLiFhXjax7UtbIooMVFJjQwv5zeV+EYLpgbXCa4pmTR2hus6Env0sTciy/9jQcp7h75tk8V6VwFkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xx8ztWGA+nmD4dY+KVPJkxispZz0+3gbvJqsRsDmHA=;
 b=h/ef52PfCIEqZFwcQcMQ0jQtkp6V8+MFijKH6PKdle0Fs8fqfb6cz4SuaGtWx6xo7A90y6wHs9NzhkRSTAR0iBNuvZaBlNFA2AETT/TLDOsf9v72NCZL21vkn9gt09i28z6NrHgP4gL9WzzXIBV6SEnsq/UloEqIOnL+Uau8ZCY=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT3PR01MB6180.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:04:14 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230%5]) with mapi id 15.20.4930.020; Wed, 2 Feb 2022
 17:04:14 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "giometti@enneenne.com" <giometti@enneenne.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rasm@fe.up.pt" <rasm@fe.up.pt>,
        "jamesnuss@nanometrics.ca" <jamesnuss@nanometrics.ca>
Subject: Re: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
Thread-Topic: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
Thread-Index: AQHYB/aUXMbW1PjF3k+egd8Abg1LR6xf4N0AgAC7WYCAGgu6AIAAwYSAgAU0bIA=
Date:   Wed, 2 Feb 2022 17:04:13 +0000
Message-ID: <72a4b544d8ed7dc6ff809f21752dd56889185f65.camel@calian.com>
References: <20220112205214.2060954-1-robert.hancock@calian.com>
         <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
         <d21aeae0-f75d-f8b9-032a-f4751696d467@enneenne.com>
         <f74e32552955b2293d814cfd14729ab190d8ddbe.camel@calian.com>
         <5178d655-a9f0-0a0e-866c-b85b7eda69f3@enneenne.com>
In-Reply-To: <5178d655-a9f0-0a0e-866c-b85b7eda69f3@enneenne.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12da7b2d-5053-4f30-2020-08d9e66e0a1d
x-ms-traffictypediagnostic: YT3PR01MB6180:EE_
x-microsoft-antispam-prvs: <YT3PR01MB6180C2DE7EC9464CF828041DEC279@YT3PR01MB6180.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgUhzXgH3ryNgJqry7XaQhCZYU2P6/89b2eVar5JgdHBgbgvDGS6sKSdjXkwmqjnR/Buc3i1YSTqk3GCMLcb/OaDNqCnffyLkFSOV+lud5RoSao7PUigAOVrt7bkREPW+f0rUhc60lNcbYE3uWJfBJIqf3ngAXN6VyI2Qrs2VkQSsnaBGxYNafNC9gWmf3QL5gMflKXFnp5zBgVNpzR+jkBvvV/LpVf/KfFt+xpL4FWiiQ4LzufZ99KVTMZVcllXz06EDOvXcRl/QvdIEQF5yjVBr/RXkppFtxtJNpD0hfq8j7VZOwUYqAzzrbFYhjBs3vkJyliOujwElUmeVh6uowh907UfeP8lL8Vjs7dxEXDCiHhT3TCCht4l26b4iAK7wCrMY9XoxJwE61kuve819a4KMPgejAv8ngWGEFgPtOCGoW+U/CUmY4d7RkTgpENK3qWgKNr13qG2lboFcSvjR/7RGryzgXGwKXtdblnyMz7miHL7pTpCWefuNff2BbKJWwTjbB2E4rxQDjH5hfiK1n6Uqv+kYIjqdVaoHfL4cUxTeQkS4FDG8SnqAyc65wa+pP67EvY7WOmA4ujQlMAN/5MWdLN2tHk8uz9HvST5J3t6tOpKhZRw/981gtxUu7wxlmOIc3J3sfekChbJ+mPUyob03Ms55rUmkOV48DvzgPR7VuyHosfghJB9FUCXe4rBCqtbnG7yZ5YEw1Xh88cGjLOPOi520X5DJoLDvq8akTcnGY68PfVsgY6aoT+KFCIjIp3XSjnrXfldMYCE+ZBtudMfwMcaPRHjAMDfC8KhsRPbpJWk+ASb0FL9P1xMOUAXByvAYoyGEbzNY1zMacnNLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(71200400001)(38070700005)(54906003)(4326008)(6916009)(508600001)(15974865002)(86362001)(15188155005)(6486002)(53546011)(966005)(6506007)(6512007)(76116006)(38100700002)(91956017)(2616005)(64756008)(66946007)(66556008)(66476007)(66446008)(316002)(8936002)(44832011)(83380400001)(16799955002)(122000001)(36756003)(5660300002)(26005)(186003)(2906002)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anQ5WURHcHRmeEFLSWVWVnplVTZQbmFucVYxdXpMTEk3VitoN3M2bk80Z20z?=
 =?utf-8?B?bGxXM3BuZEhRbStwMy9qR0lFemlCVFdNSGtNYlZUMjUrS1l6VW8xWmZFOEtC?=
 =?utf-8?B?NHorTzlnQm9yb3VLTm9IZnRMRVRMWmhJV1BIRnNHK3BodEc2QzZjYjJpQXA0?=
 =?utf-8?B?RDJhcmdkeVcwUU1tOWltNGpydUNTMzlScUYrWVJEQmtuVkZrd1E3NWVnai96?=
 =?utf-8?B?Z0NQd2tkVFl4dElTRWQ1enRkQzFqeXhjajljUlczdjZLMnJJWFhsQmkvSzBo?=
 =?utf-8?B?WGkwR2JENXJ5ZDh2TGdsZTl1ZDdwZlNYV2ZaYjg3Vy9FVkFLTFVIM0tHVXVl?=
 =?utf-8?B?L1psN2kzZHRrQ2dmSjZQOVVnc0Z3UzgwZUlxTzlaRWs1UDhram1NWmtpU2dR?=
 =?utf-8?B?Wk85TXlsMEFkNHkwK2VtcTBlWks2M1BNUy9sMXZYUDN6RjdXbnl1TWp2QlA0?=
 =?utf-8?B?a1VxYlZXUzhPYmhxL25WOHAzbEhDZHZMMnB3WE0zTDREbDlFWHEybTlKcGc4?=
 =?utf-8?B?QWxLNFRBWDR6YVIwR0RNbUZHZ3cwRlpTY05kY2FROFU4Z05ycndCblNQMTE1?=
 =?utf-8?B?eDlsNkMyRzRNZEI5THdqK2FXc1lHTTROd3orbnkreDVqZHBxK3VGRWltOGgy?=
 =?utf-8?B?K2d2VVUzTktscm5VZ2pTVERHUDV4RE9kczN2OVc0aDNZRmVyV3A3ZGFWVW9a?=
 =?utf-8?B?dElSOGVtUHU1b0xCZEo0ck9SL1ZkQW02QVdnRjRSdVROL0lQVFZGdzJOWUt2?=
 =?utf-8?B?QVNzbXdIN2RUcGdTamRSTS9JSFhzSDdrZm5yd0F3Z01UMkZvYkpmUEJJOFJy?=
 =?utf-8?B?a3RLVVFlcGNXQ3JZdDg5SUVQelJzS2VMWk5rKzJTTTgwak1IaUhVYitiZmRF?=
 =?utf-8?B?ZXBuaXhaY1dVL1lGdjJnaDM5UW1YRUZRQkRYYlhvUXpSWGthaXNIVXU4RVdw?=
 =?utf-8?B?WWV0RGhMZmkyTzVQWkh0enRLZ0RYSzBIbmt6LzdqRGx5d1h1M0VaSXNuWm93?=
 =?utf-8?B?dG5VOG9mL29KeEQ3ZGFkekh4b2ltU3N6Z1VBZmRiTVdKNCtuWGNMdFBxS0xL?=
 =?utf-8?B?OWpDSEt1R1RjWEdoS3dDV1pXb0Y4cCtFeEVWdGw2VkU5d3oyQ3E5MXlHRHJ5?=
 =?utf-8?B?TVlWODJmL3phSnJoYXJTQW1DNlVROHJnbVNsQTB4QWUySi9mZDZnNm1TU2p3?=
 =?utf-8?B?ZW9naDZ2dUs2TktnWkpiWkVRQjBGV25IM3QrMW9KVWEwMmtOamtnSlhzUmJ0?=
 =?utf-8?B?TzlsdGI3b1JVWHZCNjRmMCtIQ1d1WWdJaVFIUjJ4d1BrTTRrWVg1L1hHU2tK?=
 =?utf-8?B?STNHK3diVW1nTkJWdllDQmxJUC9IbFFUNmNhczd4Y0lBODV4TXBtUzhJY0ZL?=
 =?utf-8?B?T0xQK0Vad1ltTUdzZlg5Z0NYa0JiY2d3QjJPTCs4REF1ZGhLeVovOWxLVU0x?=
 =?utf-8?B?MkhYdGdJVnZxakV5djVxR05OVVFXd1VnK2U5UURhbzZoQTk2cURwSlJTcWFE?=
 =?utf-8?B?YU1Ma1dRczJtNkFhWXFWVy9FbU0xNHhXcjVkcDRKK0ZvUVJ2dStzWENPY0ZQ?=
 =?utf-8?B?YlYxRXZSMEpyTitHR2ZMVTlUT0Z5d2NXZldNNERrTU5wbWYrMmlCczBhcCsv?=
 =?utf-8?B?dU1mZkRKWnlhN05pM3U3QWxWRTlCL1pYS2JnVzBjdDN3SzNZZTdJSW1JRHl1?=
 =?utf-8?B?ZjJXNk9LOHpEV2VFYVJNRWRwUm5MMHZObFRZaXFxcGV2WnFBd3BXbGs5ait2?=
 =?utf-8?B?Vyt0dWtib052ZTU1eTJRVHNDNUlJM1lZR2hGY3EzUERWdFhIVm5WZDFxQ1hr?=
 =?utf-8?B?VFgyWEt2dHN4alU5Z0hWNFpOUGVWb08vaXB4TEQvKzhBbXhxM2ZNU3RFVER1?=
 =?utf-8?B?Q1g4RStXdnlnc1BNYmJSZXArb0NuWmFoeTRITkZLam5FeWhESFBKbjhJQ2hZ?=
 =?utf-8?B?MFAwK2c3bllWUlJ3eG5NcXI0c2hKRHJZTjg5TGV0Y1ZKRW9kL295SGlBeU4y?=
 =?utf-8?B?Ris1SUVvREJtSDVZR1Exa05xWmt1RjRXL2RIWVdtV3hyT29OTFg0VkU3YlR6?=
 =?utf-8?B?RStRREJ3SjdwRWt1ZGhQSVpMZEhaLzI4c2xtOGRZZUJpK0d6N0QyUC8rWlV5?=
 =?utf-8?B?My9vK0lnRlFUUU9VU1YvZE5GNkgxYkFWTEdZM3JRSSt2OHNQaXFybGVYQ0Jv?=
 =?utf-8?B?ekVXYlZLRjVXcXBXSm1DN1Awb3Foc0hJTzN1UkN1Ukg1NWdlWFJ5NjBWWnFE?=
 =?utf-8?Q?mHKDi5oTqUfSAtJZZrdFi0Z2g+53LmQwpYD/iceSJY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9513E4E27D5F6B41B12824CE2AAC4D68@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da7b2d-5053-4f30-2020-08d9e66e0a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 17:04:13.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/CguJhh3Jh/aApYoTVWbNx9ex693gbCpXG00Ys7RltmRk4An67XRF3nCRIzw9nSvHD2+4QzA7lVd3iM5DmsLa0ry/s5Jl9YgfXNHObYTks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6180
X-Proofpoint-GUID: 4ABR5Ff0Jl1wFIlBH50FuK9O7Oq6j-UU
X-Proofpoint-ORIG-GUID: 4ABR5Ff0Jl1wFIlBH50FuK9O7Oq6j-UU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_08,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202020095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTAxLTMwIGF0IDEwOjM1ICswMTAwLCBSb2RvbGZvIEdpb21ldHRpIHdyb3Rl
Og0KPiBPbiAyOS8wMS8yMiAyMzowMiwgUm9iZXJ0IEhhbmNvY2sgd3JvdGU6DQo+ID4gT24gVGh1
LCAyMDIyLTAxLTEzIGF0IDA5OjE3ICswMTAwLCBSb2RvbGZvIEdpb21ldHRpIHdyb3RlOg0KPiA+
ID4gT24gMTIvMDEvMjIgMjI6MDcsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+ID4gT24g
V2VkLCBKYW4gMTIsIDIwMjIgYXQgMDI6NTI6MTRQTSAtMDYwMCwgUm9iZXJ0IEhhbmNvY2sgd3Jv
dGU6DQo+ID4gPiA+ID4gSWYgdGhlIHBwcy1ncGlvIGRyaXZlciB3YXMgcHJvYmVkIHByaW9yIHRv
IHRoZSBHUElPIGRldmljZSBpdCB1c2VzLA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IGRldm1f
Z3Bpb2RfZ2V0IGNhbGwgcmV0dXJuZWQgYW4gLUVQUk9CRV9ERUZFUiBlcnJvciwgYnV0DQo+ID4g
PiA+ID4gcHBzX2dwaW9fcHJvYmUNCj4gPiA+ID4gPiByZXBsYWNlZCB0aGF0IGVycm9yIGNvZGUg
d2l0aCAtRUlOVkFMLCBjYXVzaW5nIHRoZSBwcHMtZ3BpbyBwcm9iZSB0bw0KPiA+ID4gPiA+IGZh
aWwgYW5kIG5vdCBiZSByZXRyaWVkIGxhdGVyLiBQcm9wYWdhdGUgdGhlIGVycm9yIHJldHVybiB2
YWx1ZSBzbw0KPiA+ID4gPiA+IHRoYXQNCj4gPiA+ID4gPiBkZWZlcnJlZCBwcm9iZSB3b3JrcyBw
cm9wZXJseS4NCj4gPiA+ID4gDQo+ID4gPiA+IEZXSVcsDQo+ID4gPiA+IFJldmlld2VkLWJ5OiBB
bmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+
IA0KPiA+ID4gQWNrZWQtYnk6IFJvZG9sZm8gR2lvbWV0dGkgPGdpb21ldHRpQGVubmVlbm5lLmNv
bT4NCj4gPiANCj4gPiBJdCdzIG5vdCBlbnRpcmVseSBjbGVhciB0byBtZSB3aGF0IHRyZWUgUFBT
IHBhdGNoZXMgYXJlIHN1cHBvc2VkIHRvIGdvDQo+ID4gdGhyb3VnaC4NCj4gPiBTZWVtcyBsaWtl
IHNvbWUgcmVjZW50IG9uZXMgaGF2ZSBnb25lIHRocm91Z2ggY2hhci1taXNjPyBOb3Qgc3VyZSBp
Zg0KPiA+IHNvbWVvbmUNCj4gPiBoYXMgdGhpcyBpbiB0aGVpciBxdWV1ZT8NCj4gDQo+IExpbnV4
UFBTIGhhcyBubyBpdHMgb3duIHRyZWUuIEFsbCByZWxhdGVkIHBhdGNoZXMgdXN1YWxseSBhcmUg
c2VudCB0byBtZSB0bw0KPiBiZQ0KPiBhY2tlZCBhbmQgdG8gR3JlZyBLcm9haC1IYXJ0bWFuIGZv
ciBpbmNsdXNpb24uDQo+IA0KPiBDaWFvLA0KPiANCj4gUm9kb2xmbw0KPiANCg0KSXQgbG9va3Mg
bGlrZSBzb21lIE1BSU5UQUlORVJTIGxpbmtzIHNob3VsZCBtYXliZSBiZSB1cGRhdGVkIGZvciBQ
UFMgLSB0aGUNCnJlZmVyZW5jZWQgcGFnZSBhdCBodHRwOi8vd2lraS5lbm5lZW5uZS5jb20vaW5k
ZXgucGhwL0xpbnV4UFBTX3N1cHBvcnQgc2VlbXMgdG8NCmJlIGRlYWQuIFRoZXJlIGlzIGh0dHA6
Ly9saW51eHBwcy5vcmcvZG9rdS5waHAgd2hpY2ggcG9pbnRzIHRvIGEgbmV3IG1haWxpbmcNCmxp
c3QgbG9jYXRpb24gYXMgd2VsbCwgYnV0IHRoYXQgc2VlbXMgdG8gaGF2ZSB2ZXJ5IGxpdHRsZSBh
Y3Rpdml0eS4NCg0KR3JlZywgY2FuIHlvdSBwaWNrIHRoaXMgcGF0Y2ggKCBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAyMi8xLzEyLzg3OSApIHVwPw0KDQotLSANClJvYmVydCBIYW5jb2NrDQpTZW5p
b3IgSGFyZHdhcmUgRGVzaWduZXIsIENhbGlhbiBBZHZhbmNlZCBUZWNobm9sb2dpZXMNCnd3dy5j
YWxpYW4uY29tDQo=
