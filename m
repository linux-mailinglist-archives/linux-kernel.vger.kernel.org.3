Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4334952B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377154AbiATQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:56:05 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:43688 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347547AbiATQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:56:04 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20KCf04G006546;
        Thu, 20 Jan 2022 11:55:47 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2050.outbound.protection.outlook.com [104.47.60.50])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dprrpgn8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 11:55:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6k+ibn/Q8QcXV25CqXkQGxfVUZPv5nneTMA1/zqoqEYoIHROfBQwhZpTSMmDwDEPErbacNWQISIZmWBddyz7Aqb8hFL+bIIKftrFQqtQpeuS8Bs47j2i4oPyD/saB7rOmE5yHy5hby+sXm8mWIpubEaLf8lXxqA2iekmNRXEPsMD+pLRUFiY143M7SO7Sel+d+reB6ra+s0Rgr0LOjYFeacIGWCBauVvwBSlKk3yrqqpvfPJM0iuKY1ODjXttYyCw8Zgv1CFn9pTTLU1sdYB/n4Ios8WRrgPSDuL9Js+9iJksj8bkUEf5XF2qqM1rm5CjypP48Nx26mQSAQ2xFQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGHfYlPJkx1BCIb3Ayiz++v3uAbDybgqxLNLXmfmnDA=;
 b=g5PNjjkqzJEaxzWVz0lQTSDdC2S2GfgQ5PAllgR5I0kWed1narst1QXCLsyZ1ATXueSsh72u80uS6jxuFd5InjqQSl0FPw7Y20X/2Xo4KP2sY9vETgKxB+cWn1xs/ZzxOiyZCoBlcE0MhJ7Y6BzRcT1JPGaeEEYL9Utg7HUfKCm+4kMuXOQDEc0Ynfxvl2otdOrSAUM2HE0vLn5f8OmPgPCZI+gKgejXGawokAlaEO9HEB0XAWdi0nZderz+V7hvoAneewwG3fvfeNQEkPc8uKWKoUGQ7X52AzMBcP7ZFUs5ObDid5gI0MphvKFxURCoDEjLLusCAHlm9YYNRFgDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGHfYlPJkx1BCIb3Ayiz++v3uAbDybgqxLNLXmfmnDA=;
 b=3Ucw4V2VcERgswo4rc1kJ8+ZsBVb03rqpJ3zl7NPRqiAhp7H0vFbLFnSyftVXpHsm7Uw4+PvmT7oh7pvC3fk6W6NQjAEEelgDnDz9h3xigQ6VtXWewYEcGgT3m1bbFaK7yV9k8DxjjnUzecgSzs3/U6n0/uGTXloo2kCkUc4zRQ=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YTXPR0101MB0832.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 16:55:45 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 16:55:45 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Topic: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Index: AQHYDMsBLd2u76Ose0K6QE7kxiOepqxsI4oA
Date:   Thu, 20 Jan 2022 16:55:45 +0000
Message-ID: <412ed2f2e301165e850a0ebec127c4231a3e24bf.camel@calian.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
         <20220119002438.106079-5-sean.anderson@seco.com>
In-Reply-To: <20220119002438.106079-5-sean.anderson@seco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77a2cfc3-c23f-4e2f-9976-08d9dc35b398
x-ms-traffictypediagnostic: YTXPR0101MB0832:EE_
x-microsoft-antispam-prvs: <YTXPR0101MB0832827D28CC765DEF975F48EC5A9@YTXPR0101MB0832.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ct0O7HpukAIYTgMOLkFFSuoGxtPp3ALG7nM4/F1CY0BW3yGb/jGowDwLtU1UFSKsqVtkFA93ayZUSvR0wl57HKdYwbmszhvWjYKPUcqZVCfgsUybZSj5dl29vbTwT0TSVVPSAyk6KB9bTaQ7QLr4xBzwLJ3kRkU4X25/DmmE0K8eIio3XPk3NshWw/zAICbiMs4witvEBN+FUbyO//L6vKTBTEyzWy7Y6DYncjPy4sBzyBsHwM6NQpCscn6GgKnvnETXz8IIeeiQsoWhl5B4UCfe64TyxVK37ZYKAO5FadxWJiVOlAx/UiVyvnQfIATi6i2CT4A3rDJbMRj3mxY58SmpBGwpySrRsNj7YX5UJalfiMR0kQSKpiu62jNVYTcWNkytb67lEgrBe0EejuJHBzvp/BvLP3mA15Hinr0qK0hRgVZWL7yNTCCwg1hJ1n8YiyKgweU4LhQ6sA2XexqF4oizB79wiWuqKc21kKZRCvqa1oL5Nb7l4eLEIpiEQ7gwbTuvwQcarQq0boyO5UspGChGVm6k09lx903Q97tN/ztBFXHMdat/h75jZ7i9LoicTvEctrUCNuKzabIFByHHwKpt7xh3nKGy1XCfeBpvVtzwO+tjN8dAsneFbcR6gOr7u+XmMegtKLal4dkwTA/ahzNdioz+t55Hta47hbVpW8M4ynagNgR+Nm0NBjULElHJVmMn75LJD2Z+yHVjcA34bEC2tIrKsjQZ3sLtT+7F61o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(36756003)(76116006)(86362001)(6506007)(54906003)(110136005)(316002)(6512007)(8676002)(508600001)(91956017)(71200400001)(6486002)(4326008)(38070700005)(8936002)(83380400001)(186003)(66476007)(66556008)(64756008)(66446008)(2616005)(5660300002)(44832011)(122000001)(38100700002)(2906002)(66946007)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkJZOGV3anZXaE1Za0xEdlR0ZE00TlMvb0lzU1FORGpqS3RjWWJlMWNNazhu?=
 =?utf-8?B?aVM3UXVxb3h6TnQzQ3lKQkw5aUU1L24vWjQ0RGgyZDlBWnRSOFdEM3pXWlp2?=
 =?utf-8?B?aGNHOEtyTGxpR2lBVHkxTmtYYzVZbWJuNjY3bDlta29BVjA2aFdxc2g2bTBG?=
 =?utf-8?B?dFNZMFNqRVlFa0F5Sm9rVnpUb0xEK3BjMGVsNjNFQzltNC9sc2lHUjNnNzRQ?=
 =?utf-8?B?Q08wY3hTcU5BeTlBcTR4RFBvcVR4VjlDckJaLzhMbW5McWh4QUhPbHMyeWlK?=
 =?utf-8?B?SFd6OUh3ajZVeFlEcXZ2ODROWEpVa2N5QThmYTFrMGt2cmM2aVMxUXg5UWVU?=
 =?utf-8?B?R3NJazZBMG1MZlNWY21tekMzSnZGR0hVaS9FZGNBaDV6dkFGVGUwaGQrUnpS?=
 =?utf-8?B?aUFOWkJuWEJ2R2VkTEZkWUdFR0hQRzF0cmxxWks1S1ZtOUVRajEzbDlmaW9L?=
 =?utf-8?B?UkRiTVRoSFpVaCttNXY0M2o1Q1ErMjdXQ1JSN3N1UUs2cUQ1OTdiYjgxYitU?=
 =?utf-8?B?Rkk3MjdRM2twOGVIWG5KRlBKNU1CQW9HTmVsR0hWZ1hYR2dFSUEwb2NiV2dz?=
 =?utf-8?B?RVJ5RU1zUkxTN0o3UW9TRDcxUk9zdFkrMk9qdXhzMVNuMFlmcHhVWmhiN1lX?=
 =?utf-8?B?aEM4YStCaG9aWW9FWW5PSkE4NmtNY3V2STlIVnp4MHd5SkJpckUyYkdtbHJq?=
 =?utf-8?B?U2xvWUZvZGJyQ2J1ZW9lWUp5cnpSbTZZSndzQTErSVA5MmZZR3JObXcyQnho?=
 =?utf-8?B?TGZuZHAyRVRqbmNXaHlUWlhKTTBXOFRZUEVKZnFLRXBuMnl3R2RrRGlJZm9P?=
 =?utf-8?B?SmRqSnVQa0NZY0p1YmZBQURRTDQvSUtvNGc3bkpGcTVpMFZsS0g3UStWWDRE?=
 =?utf-8?B?eFpnbU9ObjY2QjNJYks0aVZMR3E1S0hDajZsTjVxbW8rS0xCU3VUekFScFFI?=
 =?utf-8?B?N1pic2lHUWJiT0g2ajhOdElEM3EzNVI0WlNQYi9wbG9rbHdFeVRQeVdwWGND?=
 =?utf-8?B?djVEZHo3cnl1LzBPQTRWUjBMaW44RjUzTVRxTGh1ZmJwZTZ4TjREc1hIckFO?=
 =?utf-8?B?ME55Y2cxUjlsK1hCZ3cwZEl0anhtMjk4VGs2dC9qMFVSc0JwNFNnMEVGWGNo?=
 =?utf-8?B?ZTRPUjRMbE5GVjQrbk9RakJoSVlidVRBY2o0MllTei9SNkxyT3lnV2VUbWxP?=
 =?utf-8?B?OFNrZVoxdWJtWUFvSWpYNkhOai9vOXRkL1IwcVovblViaDMxbXBRR3dWZ3BT?=
 =?utf-8?B?UFMwUnViZVNJM1p5anJ5ZWJ2U21ybGdjdlJXMG1DMUx0MFMrNy9rd0tBYlVq?=
 =?utf-8?B?T3h0aytkeGxtVk9OUHlWNEMwUXAydVo0cVdKcTMyZnZZOGJyTDVVMGh6andu?=
 =?utf-8?B?REJxZFR2Q21xMGZwUTZER2oxUDU0SGtab1BTcVNCT2lRNmdOc3BqSnJEeVR1?=
 =?utf-8?B?YlEzY0dlcTZqNlg5QWhDbzlWUkFlL1lRQlRpTUtGckZPZGNVVm5uK05oSFdw?=
 =?utf-8?B?UnVwYzJhTEkrWGhWb1pCbmcyT0tzNWVPcWo2UlIyejA0M3F2OThLeVdZNGpo?=
 =?utf-8?B?ZjJHVHJGbGFEckNZNTVrSlM5VVpmeFFjTkRzWUdqWmovb2NCRW4ray9YSEov?=
 =?utf-8?B?anJFZ0p4eG9LUWNUcmg5MlNUSWl5K0p3VzNKWFBYV0FCZEdvK29WL3YzRVM0?=
 =?utf-8?B?MzRaT2grWENETmZYYVZZdEllUG11Wm1sVzVQOEdQVzRuMVhOOFlwNFlXVm5r?=
 =?utf-8?B?eDMwdVU3N0RhQmc4cDYwdFozaUZVc0E0WVBuaU5rUThrT0FUenRaeFBIR3By?=
 =?utf-8?B?VUV4TjQ2RW0rM3dsaHVqMVJoN3N0M2o0a01oUHdNT1lWRU1HeE5IdTZ6b3dx?=
 =?utf-8?B?eTNSWnlydlhFcUp5dXZOakl4Q0xNN3ZFdVZhZzlONTF3T1VlRExZWjNTVkt3?=
 =?utf-8?B?b3g3UGMrSW5tS3FudkVFWDFFVEhDL3cwN3N5eEdibTk0aktaaUJlbVVObDJF?=
 =?utf-8?B?WDVtVUlLZENZUnBsOXBVQWJhMkNmQjBSVEVXTTZWTEZDbjhQY1ROUWM1Zkk0?=
 =?utf-8?B?ZFJUR2JTcFN3dmdPcFFVVG5SdmtKaE4vNTRRYWZEdFpVYkRLcnQ4NDN1MU5V?=
 =?utf-8?B?NFQzYVNySDgyeXRuSHFzM1Y4NWlTbGVtRjZGWEVJRlJpV3RtNFdNVDA1WmNr?=
 =?utf-8?B?TitrNDRrNzExdERHTVdGT1FTYk93VXlEdDFDc0MrUmRtS3V5a2Z6L0FJenNN?=
 =?utf-8?Q?irHqp/mxlVQFGeBBEomkmnmJfVMgfPkALjBp8bdYm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9F90AF19929B741954BB17811AF32B7@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a2cfc3-c23f-4e2f-9976-08d9dc35b398
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 16:55:45.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftchwgck754N0uJHeRgbxX/plWnUm/3YT6R7ZTuqUMKFmysiC0eMQimkw/kXDfbYpl+PjSdo1PDo0d1vDTodQR5PnsotO0kOkmyVfWmLRnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0832
X-Proofpoint-ORIG-GUID: rjDTkHACsQHgfEYiqV3oPktxKay4H63_
X-Proofpoint-GUID: rjDTkHACsQHgfEYiqV3oPktxKay4H63_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTE4IGF0IDE5OjI0IC0wNTAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0K
PiBHVUNUTC5SRUZDTEtQRVIgY2FuIG9ubHkgYWNjb3VudCBmb3IgY2xvY2sgZnJlcXVlbmNpZXMg
d2l0aCBpbnRlZ2VyDQo+IHBlcmlvZHMuIFRvIGFkZHJlc3MgdGhpcywgcHJvZ3JhbSBSRUZDTEtf
RkxBREogd2l0aCB0aGUgcmVsYXRpdmUgZXJyb3INCj4gY2F1c2VkIGJ5IHBlcmlvZCB0cnVuY2F0
aW9uLiBUaGUgZm9ybXVsYSBnaXZlbiBpbiB0aGUgcmVnaXN0ZXIgcmVmZXJlbmNlDQo+IGhhcyBi
ZWVuIHJlYXJyYW5nZWQgdG8gYWxsb3cgY2FsY3VsYXRpb24gYmFzZWQgb24gcmF0ZSAoaW5zdGVh
ZCBvZg0KPiBwZXJpb2QpLCBhbmQgdG8gYWxsb3cgZm9yIGZpeGVkLXBvaW50IGFyaXRobWV0aWMu
DQo+IA0KPiBBZGRpdGlvbmFsbHksIGNhbGN1bGF0ZSBhIHZhbHVlIGZvciAyNDBNSFpERUNSLiBU
aGlzIGNvbmZpZ3VyZXMgYQ0KPiBzaW11bGF0ZWQgMjQwTWh6IGNsb2NrIHVzaW5nIGEgY291bnRl
ciB3aXRoIG9uZSBmcmFjdGlvbmFsIGJpdCAoUExTMSkuDQo+IA0KPiBUaGlzIHJlZ2lzdGVyIGlz
IHByb2dyYW1tZWQgb25seSBmb3IgdmVyc2lvbnMgPj0gMi41MGEsIHNpbmNlIHRoaXMgaXMNCj4g
dGhlIGNoZWNrIGFsc28gdXNlZCBieSBjb21taXQgZGIyYmU0ZTllMzBjICgidXNiOiBkd2MzOiBB
ZGQgZnJhbWUgbGVuZ3RoDQo+IGFkanVzdG1lbnQgcXVpcmsiKS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFNlYW4gQW5kZXJzb24gPHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+DQo+IC0tLQ0KPiANCj4g
Q2hhbmdlcyBpbiB2MjoNCj4gLSBBbHNvIHByb2dyYW0gR0ZMQURKLjI0ME1IWkRFQ1INCj4gLSBE
b24ndCBwcm9ncmFtIEdGTEFESiBpZiB0aGUgdmVyc2lvbiBpcyA8IDIuNTBhDQo+IA0KPiAgZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICAzICsrKw0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
aW5kZXggNTIxNGRhY2VkYTg2Li44ODNlMTE5Mzc3ZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0z
NDgsNyArMzQ4LDcgQEAgc3RhdGljIHZvaWQgZHdjM19mcmFtZV9sZW5ndGhfYWRqdXN0bWVudChz
dHJ1Y3QgZHdjMw0KPiAqZHdjKQ0KPiAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xrX3BlcmlvZChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCXUzMiByZWc7DQo+IC0JdW5zaWduZWQgbG9uZyBy
YXRlLCBwZXJpb2Q7DQo+ICsJdW5zaWduZWQgbG9uZyBkZWNyLCBmbGFkaiwgcmF0ZSwgcGVyaW9k
Ow0KPiAgDQo+ICAJaWYgKGR3Yy0+cmVmX2Nsaykgew0KPiAgCQlyYXRlID0gY2xrX2dldF9yYXRl
KGR3Yy0+cmVmX2Nsayk7DQo+IEBAIC0zNTcsNiArMzU3LDcgQEAgc3RhdGljIHZvaWQgZHdjM19y
ZWZfY2xrX3BlcmlvZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQlwZXJpb2QgPSBOU0VDX1BFUl9T
RUMgLyByYXRlOw0KPiAgCX0gZWxzZSBpZiAoZHdjLT5yZWZfY2xrX3Blcikgew0KPiAgCQlwZXJp
b2QgPSBkd2MtPnJlZl9jbGtfcGVyOw0KPiArCQlyYXRlID0gTlNFQ19QRVJfU0VDIC8gcGVyaW9k
Ow0KPiAgCX0gZWxzZSB7DQo+ICAJCXJldHVybjsNCj4gIAl9DQo+IEBAIC0zNjUsOSArMzY2LDQx
IEBAIHN0YXRpYyB2b2lkIGR3YzNfcmVmX2Nsa19wZXJpb2Qoc3RydWN0IGR3YzMgKmR3YykNCj4g
IAlyZWcgJj0gfkRXQzNfR1VDVExfUkVGQ0xLUEVSX01BU0s7DQo+ICAJcmVnIHw9ICBGSUVMRF9Q
UkVQKERXQzNfR1VDVExfUkVGQ0xLUEVSX01BU0ssIHBlcmlvZCk7DQo+ICAJZHdjM193cml0ZWwo
ZHdjLT5yZWdzLCBEV0MzX0dVQ1RMLCByZWcpOw0KPiArDQo+ICsJaWYgKERXQzNfVkVSX0lTX1BS
SU9SKERXQzMsIDI1MEEpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBj
YWxjdWxhdGlvbiBiZWxvdyBpcw0KPiArCSAqDQo+ICsJICogMTI1MDAwICogKE5TRUNfUEVSX1NF
QyAvIChyYXRlICogcGVyaW9kKSAtIDEpDQo+ICsJICoNCj4gKwkgKiBidXQgcmVhcnJhbmdlZCBm
b3IgZml4ZWQtcG9pbnQgYXJpdGhtZXRpYy4NCj4gKwkgKg0KPiArCSAqIE5vdGUgdGhhdCByYXRl
ICogcGVyaW9kIH49IE5TRUNfUEVSX1NFQ09ORCwgbWludXMgdGhlIG51bWJlciBvZg0KPiArCSAq
IG5hbm9zZWNvbmRzIG9mIGVycm9yIGNhdXNlZCBieSB0aGUgdHJ1bmNhdGlvbiB3aGljaCBoYXBw
ZW5lZCBkdXJpbmcNCj4gKwkgKiB0aGUgZGl2aXNpb24gd2hlbiBjYWxjdWxhdGluZyByYXRlIG9y
IHBlcmlvZCAod2hpY2hldmVyIG9uZSB3YXMNCj4gKwkgKiBkZXJpdmVkIGZyb20gdGhlIG90aGVy
KS4gV2UgZmlyc3QgY2FsY3VsYXRlIHRoZSByZWxhdGl2ZSBlcnJvciwgdGhlbg0KPiArCSAqIHNj
YWxlIGl0IHRvIHVuaXRzIG9mIDAuMDglLg0KPiArCSAqLw0KPiArCWZsYWRqID0gZGl2NjRfdTY0
KDEyNTAwMFVMTCAqIE5TRUNfUEVSX1NFQywgKHU2NClyYXRlICogcGVyaW9kKTsNCj4gKwlmbGFk
aiAtPSAxMjUwMDA7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBkb2N1bWVudGVkIDI0ME1IeiBj
b25zdGFudCBpcyBzY2FsZWQgYnkgMiB0byBnZXQgUExTMSBhcyB3ZWxsLg0KPiArCSAqLw0KPiAr
CWRlY3IgPSA0ODAwMDAwMDAgLyByYXRlOw0KPiArDQo+ICsJcmVnID0gZHdjM19yZWFkbChkd2Mt
PnJlZ3MsIERXQzNfR0ZMQURKKTsNCj4gKwlyZWcgJj0gfkRXQzNfR0ZMQURKX1JFRkNMS19GTEFE
Sl9NQVNLDQo+ICsJICAgICYgIH5EV0MzX0dGTEFESl8yNDBNSFpERUNSDQo+ICsJICAgICYgIH5E
V0MzX0dGTEFESl8yNDBNSFpERUNSX1BMUzE7DQo+ICsJcmVnIHw9IEZJRUxEX1BSRVAoRFdDM19H
RkxBREpfUkVGQ0xLX0ZMQURKX01BU0ssIGZsYWRqKQ0KPiArCSAgICB8ICBGSUVMRF9QUkVQKERX
QzNfR0ZMQURKXzI0ME1IWkRFQ1IsIGRlY3IgPj4gMSkNCj4gKwkgICAgfCAgRklFTERfUFJFUChE
V0MzX0dGTEFESl8yNDBNSFpERUNSX1BMUzEsIGRlY3IgJiAxKTsNCj4gKwlkd2MzX3dyaXRlbChk
d2MtPnJlZ3MsIERXQzNfR0ZMQURKLCByZWcpOw0KPiAgfQ0KPiAgDQo+IC0NCj4gIC8qKg0KPiAg
ICogZHdjM19mcmVlX29uZV9ldmVudF9idWZmZXIgLSBGcmVlcyBvbmUgZXZlbnQgYnVmZmVyDQo+
ICAgKiBAZHdjOiBQb2ludGVyIHRvIG91ciBjb250cm9sbGVyIGNvbnRleHQgc3RydWN0dXJlDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+IGluZGV4IDQ1Y2ZhN2Q5ZjI3YS4uZWI5YzFlZmNlZDA1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aA0KPiBAQCAtMzg4LDYgKzM4OCw5IEBADQo+ICAvKiBHbG9iYWwgRnJhbWUgTGVuZ3RoIEFkanVz
dG1lbnQgUmVnaXN0ZXIgKi8NCj4gICNkZWZpbmUgRFdDM19HRkxBREpfMzBNSFpfU0RCTkRfU0VM
CQlCSVQoNykNCj4gICNkZWZpbmUgRFdDM19HRkxBREpfMzBNSFpfTUFTSwkJCTB4M2YNCj4gKyNk
ZWZpbmUgRFdDM19HRkxBREpfUkVGQ0xLX0ZMQURKX01BU0sJCUdFTk1BU0soMjEsIDgpDQo+ICsj
ZGVmaW5lIERXQzNfR0ZMQURKXzI0ME1IWkRFQ1IJCQlHRU5NQVNLKDMwLCAyNCkNCj4gKyNkZWZp
bmUgRFdDM19HRkxBREpfMjQwTUhaREVDUl9QTFMxCQlCSVQoMzEpDQo+ICANCj4gIC8qIEdsb2Jh
bCBVc2VyIENvbnRyb2wgUmVnaXN0ZXIqLw0KPiAgI2RlZmluZSBEV0MzX0dVQ1RMX1JFRkNMS1BF
Ul9NQVNLCQkweGZmYzAwMDAwDQoNCkxvb2tzIGdvb2QgaGVyZSBvbiBhIFp5bnFNUCBib2FyZC4g
R0ZMQURKX1JFRkNMS19GTEFESiBlbmRzIHVwIGJlaW5nIHNldCB0byAxDQpub3cgaW5zdGVhZCBv
ZiAwLCBzaW5jZSB0aGUgY2xvY2sgcmF0ZSBpcyBhY3R1YWxseSAxOTk5OTgwMCBIeiByYXRoZXIg
dGhhbiAyMA0KTUh6LiBCdXQgdGhhdCBzaG91bGQgYmUgY29ycmVjdCwgYW5kIFVTQiBzdGlsbCBz
ZWVtcyB0byB3b3JrIGZpbmUuDQoNClJldmlld2VkLWJ5OiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0
LmhhbmNvY2tAY2FsaWFuLmNvbT4NClRlc3RlZC1ieTogUm9iZXJ0IEhhbmNvY2sgPHJvYmVydC5o
YW5jb2NrQGNhbGlhbi5jb20+DQoNCg==
