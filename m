Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA949315B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbiARXWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:22:19 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:39821 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350052AbiARXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:22:13 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20ILtlZg003890;
        Tue, 18 Jan 2022 18:21:57 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2059.outbound.protection.outlook.com [104.47.61.59])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dnapfs4be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 18:21:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR/fRjRC8zjOhEBujs2Dn4Qc5H2wfUDwJkkJ0KGIIkGRQRNt1/cK4gtVa+cw29YAF7DXUugD2e1HjLH/nxjmujZhsc0V7wgFmR+h/B+2pk9vPGKHFqPk01EUUj6axqUGfGllGac34v6fZarKkN2PLjFiBWwxIIGW7wbEAj5bj+I2Xt8wkT4ale/4lQJezcDNAHv/NAlBu7fXAKNeif0bHWkFMRgALdjqr0jZWGXgHkw4KPtSKTXAXual2nsHSKV1G6B+UzwQJTD0j5MGiygQXFnkgHBamy9tWeBwAyHov3gp3nqmCpXyfJdRolKp6ceiW1ZViHfhrGRo/38WPwo0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLrcf+CxzNqXgEYDYPTwx+SHKEtwZq30NkUktC91zH8=;
 b=TFxcfqMtYQpOH0y2/fD6Ff9ll2OoVLhZ6ffa5W6bOCpyCn+v08ErHMBf33r4zb8VHkPcSePGMvVVHCNOc+uBvYGaSet4YSxyNHrPpCcrxhBcUs6t8C4R2grZ61QkP27G5oRl09LzdyrLqgufMwJSCMEywwldoWAVQYbRH7ZBeXwG+WxqBRk37G8PG+RpdOfwFTGfMhv48jLHUUyDo20NXLaT9IIGEhWnbYQK9OVE296MRXovqWdxueIf00sTXykh9g3lpA97BQDEDg0SW57gFtU9vFS02cyuuFWgrC2G9WzJTk1lNrDk2mCqhGmthzIwrZVn102WYEQq4BveSnVELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLrcf+CxzNqXgEYDYPTwx+SHKEtwZq30NkUktC91zH8=;
 b=nEBvAXjyO89XuIke5aMAkyAYhrzcHcibdizoOEcHLjpPVkKPEIwk7Eg7qn88x6FvVRnT48W1P1ctcZUitLVgyrbi24mVPlLJayIZp7gE8AG8duDR4VyIO55PNv0uj70uqncl0jpysWTBhPJeZnlQ1ZWZO9oxRXY01PTQauvrwLc=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQBPR0101MB9856.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 23:21:55 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 23:21:55 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "agross@kernel.org" <agross@kernel.org>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
Thread-Topic: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Index: AQHYCZ/4XkJytJwIJEir+k8QaI40kqxnCOeAgAIr+YCAAAIGAIAAAgEAgAAQWgCAAAMdAIAAJL0A
Date:   Tue, 18 Jan 2022 23:21:55 +0000
Message-ID: <8e8094f148920388b81a2a58bd7cd85cd4316d92.camel@calian.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
         <87iluifxy1.fsf@tarshish>
         <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
         <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
         <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
         <0aaeb0e3-1e10-df41-0b61-c10249ea5faa@seco.com>
         <9b4f6122-a044-fac6-c5ba-e786cb1fc584@synopsys.com>
In-Reply-To: <9b4f6122-a044-fac6-c5ba-e786cb1fc584@synopsys.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46101120-ec49-4e38-9942-08d9dad950f9
x-ms-traffictypediagnostic: YQBPR0101MB9856:EE_
x-microsoft-antispam-prvs: <YQBPR0101MB9856C35E34804DBC5E7E80B6EC589@YQBPR0101MB9856.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBGA6cWHTV1iDQ+UWoReBbQssYKP32AbBPpMK9ZUWclT6WUy1UpJIR0x6Z92+qKi9m7RO7qXX6LMvfOevC3EPZSLLp6hLG2QTA0pIdMLGsvS7QCVf6mEiyrbA8MZ3tGEBQQVABRTvsEUZCztu9ZJTC7ChoNkDRSeMN3kfR1VStmJZZ/E2zAzLs4F81IIO34cg5B6LAsVBDqTEQp4TH+VXRoJ8gtCCZuTwSYHlyHFQWgclnwdbbKDrt6aoG/+w0FuDwzVJ136cZFn763OzbeCuwZIloB8oxKKOH/DVQ7P8RUeBxDsXuusAJ9N7y9zPjUGxu89A7UKyYk7F63NsOilpFeGhQmV2UOaGlfcbR2hPBAj0pVG6iNhgzQtGrHi2J5Nd29PRuHfFdIs5tQcWJVy4o+lOn+XrWextLvnjgAm7O8hm/h9yUmJnUh7BLEvHctHq539LJ/TaukTcGHE+A6gApe6cc3cl9PRbVotwN2cWtOzmFfT3UDwIFGhb4p1119PT37zGdHPHoxkdzKikFTZ0b9lmrto6RjxRqEkVN82zAfszZVSOom5y14qM+uYc22ptrW7hsJ2ciDPU+bnUgjn4evAQwyQW4bR91yDuB6OCh2PLt8V33JB86jIr4YzkmHbAiPgekq/5AE3UAcBt8rEDLV19f0gqSAc5DWEGvh2jePhjX83m6HeQwvdlhMjOUUArJ02+xaQGnjbyO0KRDj7VqTMw0hwn1qp1RWPEwejA+/zuB6I8vr6BGkTPFXG9zO1xphjdUspW1bFmCbceC2TizitF6xIZ1aBe4OJwpWoelOK/0vG+tcI5UI4fvQfvSuf8fmtlpQFVB7TENjir6Ik0A5Lvp1faxffEYW3LBTbxb0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(15974865002)(6486002)(2906002)(44832011)(36756003)(26005)(2616005)(86362001)(110136005)(5660300002)(122000001)(38070700005)(316002)(8676002)(966005)(38100700002)(8936002)(71200400001)(66556008)(6512007)(6506007)(76116006)(508600001)(66446008)(64756008)(186003)(4326008)(91956017)(83380400001)(53546011)(54906003)(66946007)(7416002)(66476007)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGRZdWl6V2oweHBLeU1DSmZHdVFtNE80V0hJSXhkTjd5R1NFZEJXMVl6d2NQ?=
 =?utf-8?B?K1d4UStxZitmbWx1bHp6RnhhK1l1K3pLSW5NSUxpaktUU0w2dVJ4WlZUdlU5?=
 =?utf-8?B?a2orL1FXbk9SU3cxUTl1eTNnZW16bUE0dmF6ekYyZzFYYjExWDArUVlpUDlQ?=
 =?utf-8?B?aU41VlRhL3E5cTJRZHlGOTdkMUR5Y2lVQUpzSjJBV20wRHVPZXE2bEtmUWVo?=
 =?utf-8?B?dUhLc3l2K01TbG5YV1dwRS9kdXpzc0VqWUNnbnAxU2toRGh6TW5jMVc2ZkRV?=
 =?utf-8?B?RFBRNXRoQ0g0YlU4TGp4ckhaK1JPVnhlSnJINm5nUi8zeGVtclVhV25yRzR5?=
 =?utf-8?B?M3ZNYVEvaUxJdHdhSG1uQW1iRCtIZVZNZkpVRE9GNUkvanV6ZzFjajZWOXg3?=
 =?utf-8?B?ZGNsVnd5MGdDU2F6V0lqdG1HNG5RK3dNamR0azFDZnkxSXNoRVNsQmVPandU?=
 =?utf-8?B?bkUvS01VaHNWUFF6YW15cGgwRWpxTEJTRVpEd25uVS8wek54R2hnb3o4ZE1U?=
 =?utf-8?B?R0VzRU9MdDhVcDZia3ZVSFBFcFVBS0JOdHFtbjM5ZDNIUjYrQTJveExzeUZW?=
 =?utf-8?B?cFRxWXZlei91TzJ0Q0g3K1o5aW5ycVZWT25GTnNWZ1p5ZVh1TDBoZkd3NXNX?=
 =?utf-8?B?QkRYbjBoUnEreGl5TEtPRzRsc2UzUzg5dnlxY1g4NGlaQlQ3SDAyVXo2UG1Z?=
 =?utf-8?B?SjdwMnQzZ3lXTGNoSTUzVk1EcDUvZm9zcmcwcGY3OEJwYWJkbWFOdTNoZ0ZG?=
 =?utf-8?B?bU9zT0s3MExRK3gzSDhXUk9TNWY4M2FkVHhKWFNzb1ZUTDNGNXU1d3BsdzJB?=
 =?utf-8?B?aEs5WGFTR3dNVndWWGo5VFlRZjQvZ1p0dmFaaUp0MUlzRzFqNFE4cWQ5SWVY?=
 =?utf-8?B?YVVsOXR5QkJOQWJOWEhYMkxMN3ZPZUFWUFlUMWE0ZjRoQnEzbzUzQ24wbEhi?=
 =?utf-8?B?d0FrbEM2M3ZOMGJRS2V1YWRubk9qeWYvWVZNakZqTDN4bnpES0dBbG1RTzlq?=
 =?utf-8?B?REpuemJhYmpORy9ueW04d0lOUEFlSVplRWdVcENBKzg0Q1Uwbk1ud0JqeVFi?=
 =?utf-8?B?Y1ZLQUpFbkFocEdDVGVWZnRxVTJXVWpuYmhIcXJXL1BDdmk0Q3hrSzhvU2lm?=
 =?utf-8?B?SXZtcTVNUk9OYzlpUGxnUzEvcFYwTXc0VlRQdzBJdkJhMVZ6OElHa1M1T3px?=
 =?utf-8?B?ZkhwUGE3ZWdOZDJMZUkxcWpsc21VRHFhckN2ek5BQjN1cmswbVRmQzA1S0pF?=
 =?utf-8?B?ekdBS3ZsV2d2bHNmbkJwdU9GWUoxdjlocldpVjRqbGZtK3ZMRWxrdkNENzBy?=
 =?utf-8?B?VUxjZ2xXSytuNGxMRUF2b2JFZnNiRG41SjhhR0VndDA4cDJSQzdhT01sbkth?=
 =?utf-8?B?Tk5yRG9jUkFveE9hcUtxUnpPMXo5cnZEQmIzaGtuV3R1Wi8xdTFVck5yRE9n?=
 =?utf-8?B?cjBKOFdnclE2SlcwQm1ZWVo0dnY2eHdWdEhJUit6aVVPUXZrS1RGcnZ0dGVz?=
 =?utf-8?B?V2NOWjR0blFCRWtnTVRaMnN4elRUS2xpaTByQkUwd1RYQlNDaHpJcWswUE1q?=
 =?utf-8?B?NTdVU0NpZTJCVTNxanRRSXZIeWxkU1BYWlFTN3dYSll0Y3M0S0NMV3g1VnBp?=
 =?utf-8?B?cTBMZ1lpRFNpeGZad3FWZjdxR0d3WkxscTJTa0xVektQV005aDg1YW9rSlQy?=
 =?utf-8?B?VDFJWDlIRS8rSUlKRXd3WXE3UmVuUFYwQmgrY1RPK29ZSzJMRTJRWTJzWGRm?=
 =?utf-8?B?aWJ4dWMvMUpiVWc4RCtiaUFZN1JtZ2ZuYWZBTkhxcWFLQ211REFneDNnWXdO?=
 =?utf-8?B?RWFpRkkzc0VBVm82amdpYkhweDhsSWtRWkNFNHhUNlpobjVqa0IyL0N0WE5O?=
 =?utf-8?B?Z0FMT1g1cWpPNWttRVdhaUpMU1JXY0J0b09mRHRKU0xTd2NIcTA0TEdjcTEw?=
 =?utf-8?B?OVdtMEl0Ly9LTUpRb2dDNFVEbE1qNmp2eVdMclNUMkZWbDNwZ1VmTmhPb3dL?=
 =?utf-8?B?S0VGd2hmcTJiV1pXRUNpOU5LQ09IcWZpTUJwUUVNd0hzS0FPUzR3WWhObzU4?=
 =?utf-8?B?TnFaaG1USmY4WkMwTUhzc1doZWRRRFN4U3lsT2JkV1JLYWtqYUFheVRpVTZJ?=
 =?utf-8?B?ZVRPblgzaldwNmRDejNiN0FMbVJBM2VLckVvYjlBSDM3VHFjNFVLb1R4Qm5G?=
 =?utf-8?B?dzRxRWx0YWozSFl0Qk9SalhabTdrZkd1dENDOGJSU0xzV2VKWFFzbi9ONmF3?=
 =?utf-8?Q?OQkTkAbNaOm7l+hI0pNB5ndEWl9JmC9fOMvD+duCkk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4D1CCDB02340D4A981BA3DE77FE6B49@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46101120-ec49-4e38-9942-08d9dad950f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 23:21:55.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Obolm7HyPOXUG2nSvF/3L8gCZ/GqMsgACDSgs3jFNfa/73cCKA+yfH3JZZO2NGG/wVr6lLW6QqRGxAuNxAnPX8MA2LMxPEQW9gDpwHdTIXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9856
X-Proofpoint-GUID: S4NnnvdJZVMprEidch-y5y0bUdPyP1He
X-Proofpoint-ORIG-GUID: S4NnnvdJZVMprEidch-y5y0bUdPyP1He
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTE4IGF0IDIxOjEwICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
IEhpIFNlYW4sDQo+IA0KPiBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPiA+IEhpIFRoaW5oLA0KPiA+
IA0KPiA+IE9uIDEvMTgvMjIgMzowMCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gU2Vh
biBBbmRlcnNvbiB3cm90ZToNCj4gPiA+ID4gSGkgVGhpbmgsDQo+ID4gPiA+IA0KPiA+ID4gPiBP
biAxLzE4LzIyIDI6NDYgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiBIaSBTZWFu
LA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJhcnVjaCBTaWFjaCB3cm90ZToNCj4gPiA+ID4gPiA+
IEhpIFNlYW4sIFRoaW5oLA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPbiBGcmksIEphbiAx
NCAyMDIyLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGEgcmV3
b3JrIG9mIHBhdGNoZXMgMy01IG9mIFsxXS4gSXQgYXR0ZW1wdHMgdG8gY29ycmVjdGx5DQo+ID4g
PiA+ID4gPiA+IHByb2dyYW0NCj4gPiA+ID4gPiA+ID4gUkVGQ0xLUEVSIGFuZCBSRUZDTEtfRkxB
REogYmFzZWQgb24gdGhlIHJlZmVyZW5jZSBjbG9jaw0KPiA+ID4gPiA+ID4gPiBmcmVxdWVuY3ku
DQo+ID4gPiA+ID4gPiA+IFNpbmNlDQo+ID4gPiA+ID4gPiA+IHdlIG5vIGxvbmdlciBuZWVkIGEg
c3BlY2lhbCBwcm9wZXJ0eSBkdXBsaWNhdGluZyB0aGlzDQo+ID4gPiA+ID4gPiA+IGNvbmZpZ3Vy
YXRpb24sDQo+ID4gPiA+ID4gPiA+IHNucHMscmVmLWNsb2NrLXBlcmlvZC1ucyBpcyBkZXByZWNh
dGVkLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gUGxlYXNlIHRlc3QgdGhpcyEgUGF0
Y2hlcyAzLzQgaW4gdGhpcyBzZXJpZXMgaGF2ZSB0aGUgZWZmZWN0IG9mDQo+ID4gPiA+ID4gPiA+
IHByb2dyYW1taW5nIFJFRkNMS1BFUiBhbmQgUkVGQ0xLX0ZMQURKIG9uIGJvYXJkcyB3aGljaCBh
bHJlYWR5DQo+ID4gPiA+ID4gPiA+IGNvbmZpZ3VyZQ0KPiA+ID4gPiA+ID4gPiB0aGUgInJlZiIg
Y2xvY2suIEkgaGF2ZSBidWlsZCB0ZXN0ZWQsIGJ1dCBub3QgbXVjaCBlbHNlLg0KPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gWzFdDQo+ID4gPiA+ID4gPiA+IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMjAxMTQwNDQy
MzAuMjY3NzI4My0xLXJvYmVydC5oYW5jb2NrQGNhbGlhbi5jb20vX187ISFBNEYyUjlHX3BnIU0z
ekt4RFpDOWFfZXRxelhvN0dTRU1USFJXZmMxd1JfODR3d000LWZTaGlBMzVDc0djeGNURWZmSFBi
cHJiZEM0ZDJSJA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IFRoaW5oLCB5b3Ugc3VnZ2VzdGVkIHRoZSBkZWRpY2F0ZWQgRFQgcHJvcGVy
dHkgZm9yIHRoZSByZWZlcmVuY2UNCj4gPiA+ID4gPiA+IGNsb2NrOg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvZDVhY2IxOTItODBiOS0zNmY3LTQzZjUtODFmMjFjNGU2
YmEwQHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdfcGchTTN6S3hEWkM5YV9ldHF6WG83R1NFTVRI
UldmYzF3Ul84NHd3TTQtZlNoaUEzNUNzR2N4Y1RFZmZIUGJwcmJwT0ZtdlgkDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBDYW4geW91IGNvbW1l
bnQgb24gdGhpcyBzZXJpZXM/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBV
bmxlc3MgdGhlcmUncyBhIGdvb2Qgd2F5IHRvIHBhc3MgdGhpcyBpbmZvcm1hdGlvbiBmb3IgUENJ
IGRldmljZXMsDQo+ID4gPiA+ID4gbXkNCj4gPiA+ID4gPiBvcGluaW9uIGhhc24ndCBjaGFuZ2Vk
LiAoQnR3LCBJIGRvbid0IHRoaW5rIGNyZWF0aW5nIGEgZHVtbXkgY2xvY2sNCj4gPiA+ID4gPiBw
cm92aWRlciBhbmQgaXRzIGR1bW15IG9wcyBpcyBhIGdvb2Qgc29sdXRpb24gYXMgc2VlbXMgdG8g
Y29tcGxpY2F0ZQ0KPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IGJsb2F0IHRoZSBQQ0kgZ2x1ZSBk
cml2ZXJzKS4NCj4gPiA+ID4gDQo+ID4gPiA+IENhbiB5b3UgZXhwbGFpbiB5b3VyIHNpdHVhdGlv
biBhIGJpdCBtb3JlPyBJJ20gbm90IHN1cmUgaG93IHlvdSBjYW4NCj4gPiA+ID4gYWNjZXNzIGEg
ZGV2aWNlIHRyZWUgcHJvcGVydHkgYnV0IG5vdCBhZGQgYSBmaXhlZC1yYXRlIGNsb2NrLg0KPiA+
ID4gPiANCj4gPiA+ID4gLS1TZWFuDQo+ID4gPiANCj4gPiA+IEN1cnJlbnRseSBmb3IgZHdjMyBw
Y2kgZGV2aWNlcywgd2UgaGF2ZSBnbHVlIGRyaXZlcnMgdGhhdCBjcmVhdGUgYQ0KPiA+ID4gcGxh
dGZvcm1fZGV2aWNlIHdpdGggc3BlY2lmaWMgcHJvcGVydGllcyB0byBwYXNzIHRvIHRoZSBkd2Mz
IGNvcmUNCj4gPiA+IGRyaXZlci4gV2l0aG91dCBhIHJlZiBjbG9jayBwcm9wZXJ0eSwgd2Ugd291
bGQgbmVlZCBhbm90aGVyIHdheSB0byBwYXNzDQo+ID4gPiB0aGlzIGluZm9ybWF0aW9uIHRvIHRo
ZSBjb3JlIGRyaXZlciBvciBhbm90aGVyIHdheSBmb3IgdGhlIGR3YzMgY29yZQ0KPiA+ID4gZHJp
dmVyIHRvIGNoZWNrIGZvciBzcGVjaWZpYyBwY2kgZGV2aWNlJ3MgcHJvcGVydGllcyBhbmQgcXVp
cmtzLg0KPiA+IA0KPiA+IFRoZSBwcmltYXJ5IHByb2JsZW0gd2l0aCB0aGUgZXhpc3RpbmcgYmlu
ZGluZyBpcyB0aGF0IGl0IGRvZXMgbm90DQo+ID4gY29udGFpbiBlbm91Z2ggaW5mb3JtYXRpb24g
dG8gY2FsY3VsYXRlIHRoZSBmcmFjdGlvbmFsIHBlcmlvZC4gV2l0aCB0aGUNCj4gPiBmcmVxdWVu
Y3ksIHdlIGNhbiBjYWxjdWxhdGUgdGhlIGNvcnJlY3QgdmFsdWVzIGZvciB0aGUgcmVnaXN0ZXJz
IHdpdGhvdXQNCj4gPiBuZWVkaW5nIGFuIGFkZGl0aW9uYWwgYmluZGluZy4gU28gd2UgbmVlZCB0
byB0cmFuc2l0aW9uIHRvIHNvbWUga2luZCBvZg0KPiA+IGZyZXF1ZW5jeS1iYXNlZCBzeXN0ZW0u
IFNvIHBlcmhhcHMgd2Ugc2hvdWxkIGFkZCBhICJyZWYtY2xvY2stZnJlcXVlbmN5Ig0KPiA+IHBy
b3BlcnR5IGFuZCB1c2UgdGhhdCBhcyBhIGRlZmF1bHQgZm9yIHdoZW4gdGhlIGNsb2NrIGlzIG1p
c3NpbmcuDQo+ID4gDQo+IA0KPiBOb3Qgc3VyZSBhYm91dCBvdGhlcnMsIGJ1dCB0aGF0J3MgZmlu
ZSB3aXRoIG1lLiBUaGUgb3RoZXIgc29sdXRpb24gaXMgdG8NCj4gcmV3b3JrIHRoZSBkd2MzIGRy
aXZlcnMgYXMgUm9iZXJ0IG5vdGVkLCBidXQgdGhhdCByZXF1aXJlcyBzb21lIHdvcmsuDQo+IA0K
DQpTZWVtcyByZWFzb25hYmxlIGVub3VnaCBmb3IgYSBzaG9ydC10ZXJtIGZpeCBhbnl3YXkuDQoN
Cj4gVGhhbmtzLA0KPiBUaGluaA0KPiANCi0tIA0KUm9iZXJ0IEhhbmNvY2sNClNlbmlvciBIYXJk
d2FyZSBEZXNpZ25lciwgQ2FsaWFuIEFkdmFuY2VkIFRlY2hub2xvZ2llcw0Kd3d3LmNhbGlhbi5j
b20NCg==
