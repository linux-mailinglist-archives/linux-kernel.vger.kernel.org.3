Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B274952A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377133AbiATQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:53:01 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:33350 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377127AbiATQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:52:59 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20KBU4PE019111;
        Thu, 20 Jan 2022 11:52:47 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2059.outbound.protection.outlook.com [104.47.60.59])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dpmt68nn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 11:52:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUdCUB76QhKaFKxfcPMY6xv5p10VNKNhFLxmRnwRkYmJKDT2KmNXD1ad1wiP70Y50KGhVaqb8KNWjDbcudmn2WnpSy2QbkNPV4fKKrxufju9HvGYSx29/6F2glUOtBMgMZOOK2snluoBHfFAuoXV+w2gmw39MNcFMVN4IfFFOLExda1ZGYKKNfB4qTHFYsfPtxOrUmPUnncCfA4DvMTcpDrTD9H1zuD0D47EuFiUAH9gS2NE3MjuF9o80vqLEdkcKBsjBkOSHeWaxh/zB8U/9Z+OvREReyfLuDVgmky2N8ckxCKjhDx5s3uIcvH3oAvm/yMXYx/+b55rfWD29n+7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IowDOViUodIRTnyV2TA6SDCNHujf0yjX/u2veCCW6eI=;
 b=oLLfXPdbzJOURTb3XHKB7euUV1XzozYxGMHep7Zz2c0hSOgjPu3fQXZZT8J0kIIloSMAzcbgjq0OTqIH2S8CtCN4n51M/Rxn5li1uHZcsIps8pfJ+GEbIZF8lrfMbywgHY7xS6x0MjyGy0/9V05tNjrxR28iP1x/3riVowNDEOsv8COwtfVePdjXFAQyz/mDXU2XWpdvcXaDHDDqAMsAK+QyQQLcSUZEfE1N6q39lOIFN8sGyTbJe85E+Blk3HZLL5Iwtu8sEuALr00BOgeVQyVmKFKF2QXk3YTTQeHsh0JPxK3IAsMgK7fpjl4X423MYskgqJz7ckukVGdsy791gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IowDOViUodIRTnyV2TA6SDCNHujf0yjX/u2veCCW6eI=;
 b=roLKKIe5L4/ZpyNPiaN5Hjq2cNIiU1qCsyLP+BgAsFzaX5g/78cXJXZgwe63qn0+am8jM96AyHcS7MmVP9SZmWVeuUfSEALdVmK1bvq/VYZbuP+IiCir9vrBm1tlA4inZ8qW/F879LP3vRD5pdewGVrsIjAcLwGehyJ9CNvhg1w=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT1PR01MB9081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 16:52:45 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 16:52:45 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
Subject: Re: [PATCH v2 2/7] usb: dwc3: Get clocks individually
Thread-Topic: [PATCH v2 2/7] usb: dwc3: Get clocks individually
Thread-Index: AQHYDMsA7zI1uFaUwECjMXu/uzy+FaxsIrQA
Date:   Thu, 20 Jan 2022 16:52:45 +0000
Message-ID: <17b0b0d3dd313cd5707ff43313f9c57bae6d5b73.camel@calian.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
         <20220119002438.106079-3-sean.anderson@seco.com>
In-Reply-To: <20220119002438.106079-3-sean.anderson@seco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 730dbd9d-7c7f-4c79-95f0-08d9dc354828
x-ms-traffictypediagnostic: YT1PR01MB9081:EE_
x-microsoft-antispam-prvs: <YT1PR01MB9081B8B6BF1BF43C069B5436EC5A9@YT1PR01MB9081.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBQlbtF1b51w9Cl7AdL1Udw9YKJOFTxvZLW1ZJQM+zjtideVrnoo8Pe6E3/3KvIPHZv6Bpzg4yvu5iX7ky0yE06cMM9nDWRTQK7fhm+/02GcP7Q0qM+1PA4rGOTJIZacghf2gYyONZ9wHbLcB8DnGJiAmMGsdUa1W0ZZTETmwgeul2nbczEC8lBwskanVJzDg5sFUbXHgixQ8oVOXGlxCBdPuxsf/Xq0/ISEu9ciCa9tG7CvHsKX5JdXNMyRmJxtDvSe7/g+kJRbXNJqxiYWyYCSJZx3YnV8TRsBV2bKBm4YSi74Ddhfn3XKNm1QC9WQitmGEXhFlOrmZIO3fE9+/3VErv5ytEDiGoj+CzWTNoWN2qwenr5u+WgulPUweRzBPKCSS3cLbktTgk+OYk9WjiBUdF5VZDSm5dAi+5ObSZsf7+nRxVB8Qu6+5LRtPMhj2j+e3sq0MU6TV1/X1BseW9KxhWyxxlxpBUYK9u43EK9DoJI5Fu4uRIFT+G6TtgVil+HiPcoOYWx6nFVPN5WMJ510/TFqNOKP6n9upUW2sU8UGMbQFR9biByUf9uUQeMpFIheOxkU4DAX8RFlEMqKf6kbn5g2nfJQtvcWZCnL/vS2U1vHpJY8Px+VI8v8H4Nmrq5tTZuf+jUVvk3Q06mXaC5YFXg0OO9W0Az0Qjn+olBEQaqEOwP1K4hJzjHCKnn2nEnFuhReTqrho2w6/49EyY6FPqiWP47T7sXGi6gAoJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(66446008)(8676002)(8936002)(5660300002)(36756003)(26005)(66556008)(64756008)(66476007)(4326008)(91956017)(508600001)(76116006)(6486002)(6506007)(44832011)(66946007)(6512007)(83380400001)(2906002)(54906003)(110136005)(86362001)(2616005)(38070700005)(186003)(316002)(122000001)(38100700002)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUtheDdhZFp5ejVMZFFad2ovajNHRlpkUDJJUVVCdHpZSC9LL1dLMkJmWFNW?=
 =?utf-8?B?VGUrcG9wM1pmS0ZvZGVxQnlOczIxa1grNTVncGM0R1ZrTHB3NlpsTldYWThL?=
 =?utf-8?B?ZXFoMkRDSGgwRUh3ZGJHd01jUXh4eUNlVmRnVnoxSEtHSzVMeU51ZEFUajhE?=
 =?utf-8?B?aVA1NThIcnhUaVBhdkdQcis2TFU2S0FQMi85K21BNFNxSStVQURnbmU4Z1Mr?=
 =?utf-8?B?MTV5c2hrM3J2SlJOM1BVU1hFTFVXZ05ObmJ0ajA5ci9mS3ZRVEswRTdmU2xp?=
 =?utf-8?B?TzFlT3VKZjZ1N2JVVWNQOWg0SkNBMXAxNUhwQTAyUHZEUFF3amhGRFA1SnBR?=
 =?utf-8?B?KzYyV25iM0JGUlJhVDBRdXE4bHpQNFZXMU5RUjdnVTR1cUVHOU10OFFlQ3dM?=
 =?utf-8?B?SktFczVNNHBsWXF5N091S1g4ekpLSXJkUGQwMmx4RDZyQXMwSlFXeVA4bmkw?=
 =?utf-8?B?VXFWM2ZQNm9CNG1qVTN1SWZoTGJIakxnSFRMYlFYa05INUdXUFAzcHNpU3lw?=
 =?utf-8?B?clZady9PRnM0UnF2TWdMbXNiRDk4NTExZENHc2VDSVY0ZGxwL29FMkZhaFdE?=
 =?utf-8?B?NSswVkZGYm4zVUxwRk1wUzlOK3pKRzgzcFNvRUNnekpueDFUY3FCZi9leGll?=
 =?utf-8?B?L2Y4dzMzVVpWZTYxemxKQml3aTRqRVpJYVZSQUVZYy9rZitYQ2ljd2xRYmZQ?=
 =?utf-8?B?Wk11NUhYQUp2TDlUV2FNUFlZUjVhRDh3eEU3WktIMFltVEtnUUZPZ25TSXZo?=
 =?utf-8?B?UEpwN3RJUVhaa1FXbG0rd2ZpVzVQQjZIb205L1IyN000cm5iM1VPa0s3UTdZ?=
 =?utf-8?B?eFJDa2VWN2dCU001c2JZR3BqT1pBbmlSTW9TQWZRNjVpT2VYa2V1Ukp0bVlL?=
 =?utf-8?B?WFZDMzhpa2J2c0FjSlNnRmVWbTVPODVYV1FvQ0VLWjRnT09adzYzeVkyOGpN?=
 =?utf-8?B?bVptVy9wVTRJblhxNEt3bHhpMEhWZnphMlBoelN3enVEdWpuSWh4QmFLdkZI?=
 =?utf-8?B?cTlNbUZHcjZYYmkzWVdkSzZoSlpYWDZIcklGT29BWWx1YnRCQVFZUDRML0dk?=
 =?utf-8?B?ZGwyNGh5VmphQTF6WjRYL05PRDJpWDVEZ0labWhzK1R1Z05JdUpPcStKN0Yz?=
 =?utf-8?B?aGpiUmV4M1pkL0ZUdFlNRWtxSllSMjJZSjRoRmUzRXlBclhsYU1lRGRqZUR6?=
 =?utf-8?B?SjdDZHl1cTd3d3grMi9YYUlpSHBJaVh4MG1ZVnFIdkMyYlNnaFp5eVdValVY?=
 =?utf-8?B?TmRqOHhYa01Pd2U3OUNmaFBjZkd3Y2FkZnBpRDdod2U4YjNmMW1RV1hMdzEy?=
 =?utf-8?B?SzdHcllZUTNvTFpsOE9qdERLLzY2TUoxRkFIckJHUDUwR2V3czVaMm1uemV0?=
 =?utf-8?B?TElWK05TdC9FOVVvank3VWpIM250Q2hYNlpKTzhkeVNKQkhMOU9qUVhEaGky?=
 =?utf-8?B?djhXbGord2JKRjRGR1dMbnEvcUFpcG93OHRGTnJRQ2dJc2lWOWpISkpiSHpT?=
 =?utf-8?B?SFArNHhWdCs5Z2RYZnRSSlRTNXpmM0IxZDRxc1ZGbi9aU2hBY1hUK1V4MFRx?=
 =?utf-8?B?QVM0UU1KWGpPM3cvMEpsYjQ5UjVGZ0FJWE1ZNklGdHNQSzNzQVdTd2pFWnI1?=
 =?utf-8?B?ZWxMTTN6Q3ZOK3c4eFVOWnY3b3lhTks2bFdrbnNsbHpXN3QyTjR5STVDS1lF?=
 =?utf-8?B?d1JaZXlQOGJzRE1CZ1ZQMi8wUyt0M3V3RVFlN1dzak9kYUM4ZDF6KzVaSHN4?=
 =?utf-8?B?cHQxNmk0Y3Yza1d1TmE0Wk9uYkZuOW43L0l4UUdPa0h6WlUzaUpqN0lnaEZo?=
 =?utf-8?B?TkpCTVFCL0Z2c2s5WjNpZ0lJaGoyQklpdzFuaXFLRStXVTlkQ2MzMmVQZThH?=
 =?utf-8?B?VDZpNGZaQ1FBcUo0UC9Sb0NrNWlBT0JZL0NZZjVYeHlHdzA0OTVwcko1SWk5?=
 =?utf-8?B?Q3lsRThqWFdkSDhDNjNVT0pBcHZjOHprcmtPSjZUZTBwMlREV3VHd3hsalNm?=
 =?utf-8?B?V3Q0MHJzOERWM2txWjZraWpTcUxZYUNrL1R2OHV1STE0TXlpMThIT09rUnp0?=
 =?utf-8?B?YmIvVkRoNmRrQnFDTmc3Q2w4MnJsTTE1S2RNZDVkekNueU4ySnRkMGxNZ2tX?=
 =?utf-8?B?U3B0SFhZM3dITHJvZWRYVldZTjdiN0FVVFp4QmdxN3M5eDZCNGpWQW9PUGxn?=
 =?utf-8?B?TzQ5WnZscmhDRTdZeTFnbkUwQUhlZkJHcWNpMVJUelkxOHAyQnQ2dmN2Z3FZ?=
 =?utf-8?Q?4XXbVg8QeI8KC5YnU15eoBonwcW7bUOGTSxa6kcaWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8FA168DD51ED849A5BC94FDC9B72442@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 730dbd9d-7c7f-4c79-95f0-08d9dc354828
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 16:52:45.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWKAyqmamt30JeNszgcu4suefv5GKmY5UwIvaodB3SSD3s0PBfpF1nrDL4UYv723bC6lCYvZTkSXBcvw1fbmaYv7m6O5lbw17N7yXtOm9rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9081
X-Proofpoint-GUID: bq-AflLI_PfH0FuSRGSuY9heGrf_weML
X-Proofpoint-ORIG-GUID: bq-AflLI_PfH0FuSRGSuY9heGrf_weML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=840 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTE4IGF0IDE5OjI0IC0wNTAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0K
PiBJbnN0ZWFkIG9mIGdyYWJiaW5nIGFsbCBjbG9ja3MgaW4gYnVsaywgZ3JhYiB0aGVtIGluZGl2
aWR1YWxseS4gVGhpcyB3aWxsDQo+IGFsbG93IHVzIHRvIGdldCB0aGUgZnJlcXVlbmN5IG9yIG90
aGVyd2lzZSBkZWFsIHdpdGggZGlzY3JldGUgY2xvY2tzLiBUaGlzDQo+IG1heSBicmVhayBzb21l
IHBsYXRmb3JtcyBpZiB0aGV5IHVzZSBhIGNsb2NrIHdoaWNoIGRvZXNuJ3QgdXNlIG9uZSBvZiB0
aGUNCj4gZG9jdW1lbnRlZCBuYW1lcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQW5kZXJz
b24gPHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBEb2N1bWVudCBjbG9jayBtZW1iZXJzDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggfCAxMCArKysrLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDU2
IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggZjRj
MDk5NTFiNTE3Li42OTlhYjlhYmRjNDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC03NDUsNiArNzQ1
LDM4IEBAIHN0YXRpYyBpbnQgZHdjM19waHlfc2V0dXAoc3RydWN0IGR3YzMgKmR3YykNCj4gIAly
ZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBkd2MzX2Nsa19lbmFibGUoc3RydWN0
IGR3YzMgKmR3YykNCj4gK3sNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gY2xrX3ByZXBh
cmVfZW5hYmxlKGR3Yy0+YnVzX2Nsayk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gKw0KPiArCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShkd2MtPnJlZl9jbGspOw0KPiArCWlm
IChyZXQpDQo+ICsJCWdvdG8gZGlzYWJsZV9idXNfY2xrOw0KPiArDQo+ICsJcmV0ID0gY2xrX3By
ZXBhcmVfZW5hYmxlKGR3Yy0+c3VzcF9jbGspOw0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZGlz
YWJsZV9yZWZfY2xrOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICsNCj4gK2Rpc2FibGVfcmVmX2Ns
azoNCj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5yZWZfY2xrKTsNCj4gK2Rpc2FibGVf
YnVzX2NsazoNCj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5idXNfY2xrKTsNCj4gKwly
ZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2Nsa19kaXNhYmxlKHN0
cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGR3Yy0+c3Vz
cF9jbGspOw0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShkd2MtPnJlZl9jbGspOw0KPiArCWNs
a19kaXNhYmxlX3VucHJlcGFyZShkd2MtPmJ1c19jbGspOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMg
dm9pZCBkd2MzX2NvcmVfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCWR3YzNfZXZl
bnRfYnVmZmVyc19jbGVhbnVwKGR3Yyk7DQo+IEBAIC03NTgsNyArNzkwLDcgQEAgc3RhdGljIHZv
aWQgZHdjM19jb3JlX2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAl1c2JfcGh5X3NldF9zdXNw
ZW5kKGR3Yy0+dXNiM19waHksIDEpOw0KPiAgCXBoeV9wb3dlcl9vZmYoZHdjLT51c2IyX2dlbmVy
aWNfcGh5KTsNCj4gIAlwaHlfcG93ZXJfb2ZmKGR3Yy0+dXNiM19nZW5lcmljX3BoeSk7DQo+IC0J
Y2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5udW1fY2xrcywgZHdjLT5jbGtzKTsNCj4g
Kwlkd2MzX2Nsa19kaXNhYmxlKGR3Yyk7DQo+ICAJcmVzZXRfY29udHJvbF9hc3NlcnQoZHdjLT5y
ZXNldCk7DQo+ICB9DQo+ICANCj4gQEAgLTE2MDUsMjUgKzE2MzcsMzEgQEAgc3RhdGljIGludCBk
d2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCXJldHVybiBQVFJf
RVJSKGR3Yy0+cmVzZXQpOw0KPiAgDQo+ICAJaWYgKGRldi0+b2Zfbm9kZSkgew0KPiAtCQlyZXQg
PSBkZXZtX2Nsa19idWxrX2dldF9hbGwoZGV2LCAmZHdjLT5jbGtzKTsNCj4gLQkJaWYgKHJldCA9
PSAtRVBST0JFX0RFRkVSKQ0KPiAtCQkJcmV0dXJuIHJldDsNCj4gIAkJLyoNCj4gIAkJICogQ2xv
Y2tzIGFyZSBvcHRpb25hbCwgYnV0IG5ldyBEVCBwbGF0Zm9ybXMgc2hvdWxkIHN1cHBvcnQgYWxs
DQo+ICAJCSAqIGNsb2NrcyBhcyByZXF1aXJlZCBieSB0aGUgRFQtYmluZGluZy4NCj4gIAkJICov
DQo+IC0JCWlmIChyZXQgPCAwKQ0KPiAtCQkJZHdjLT5udW1fY2xrcyA9IDA7DQo+IC0JCWVsc2UN
Cj4gLQkJCWR3Yy0+bnVtX2Nsa3MgPSByZXQ7DQo+ICsJCWR3Yy0+YnVzX2NsayA9IGRldm1fY2xr
X2dldF9vcHRpb25hbChkZXYsICJidXNfZWFybHkiKTsNCj4gKwkJaWYgKElTX0VSUihkd2MtPmJ1
c19jbGspKQ0KPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+YnVz
X2NsayksDQo+ICsJCQkJCSAgICAgImNvdWxkIG5vdCBnZXQgYnVzIGNsb2NrXG4iKTsNCj4gIA0K
PiArCQlkd2MtPnJlZl9jbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAicmVmIik7DQo+
ICsJCWlmIChJU19FUlIoZHdjLT5yZWZfY2xrKSkNCj4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgUFRSX0VSUihkd2MtPnJlZl9jbGspLA0KPiArCQkJCQkgICAgICJjb3VsZCBub3QgZ2V0
IHJlZiBjbG9ja1xuIik7DQo+ICsNCj4gKwkJZHdjLT5zdXNwX2NsayA9IGRldm1fY2xrX2dldF9v
cHRpb25hbChkZXYsICJzdXNwZW5kIik7DQo+ICsJCWlmIChJU19FUlIoZHdjLT5zdXNwX2Nsaykp
DQo+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoZHdjLT5zdXNwX2Nsayks
DQo+ICsJCQkJCSAgICAgImNvdWxkIG5vdCBnZXQgc3VzcGVuZCBjbG9ja1xuIik7DQo+ICAJfQ0K
PiAgDQo+ICAJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChkd2MtPnJlc2V0KTsNCj4gIAlp
ZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JcmV0ID0gY2xrX2J1bGtfcHJlcGFy
ZV9lbmFibGUoZHdjLT5udW1fY2xrcywgZHdjLT5jbGtzKTsNCj4gKwlyZXQgPSBkd2MzX2Nsa19l
bmFibGUoZHdjKTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGFzc2VydF9yZXNldDsNCj4gIA0K
PiBAQCAtMTcxMSw3ICsxNzQ5LDcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0K
PiAgDQo+ICBkaXNhYmxlX2Nsa3M6DQo+IC0JY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUoZHdj
LT5udW1fY2xrcywgZHdjLT5jbGtzKTsNCj4gKwlkd2MzX2Nsa19kaXNhYmxlKGR3Yyk7DQo+ICBh
c3NlcnRfcmVzZXQ6DQo+ICAJcmVzZXRfY29udHJvbF9hc3NlcnQoZHdjLT5yZXNldCk7DQo+ICAN
Cj4gQEAgLTE3NTUsNyArMTc5Myw3IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXRfZm9yX3Jl
c3VtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+
ICANCj4gLQlyZXQgPSBjbGtfYnVsa19wcmVwYXJlX2VuYWJsZShkd2MtPm51bV9jbGtzLCBkd2Mt
PmNsa3MpOw0KPiArCXJldCA9IGR3YzNfY2xrX2VuYWJsZShkd2MpOw0KPiAgCWlmIChyZXQpDQo+
ICAJCWdvdG8gYXNzZXJ0X3Jlc2V0Ow0KPiAgDQo+IEBAIC0xNzY2LDcgKzE4MDQsNyBAQCBzdGF0
aWMgaW50IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoc3RydWN0IGR3YzMgKmR3YykNCj4gIAly
ZXR1cm4gMDsNCj4gIA0KPiAgZGlzYWJsZV9jbGtzOg0KPiAtCWNsa19idWxrX2Rpc2FibGVfdW5w
cmVwYXJlKGR3Yy0+bnVtX2Nsa3MsIGR3Yy0+Y2xrcyk7DQo+ICsJZHdjM19jbGtfZGlzYWJsZShk
d2MpOw0KPiAgYXNzZXJ0X3Jlc2V0Og0KPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGR3Yy0+cmVz
ZXQpOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IGUxY2MzZjczOThmYi4uNDVjZmE3ZDlmMjdhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuaA0KPiBAQCAtOTc4LDggKzk3OCw5IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hw
YWRfYXJyYXkgew0KPiAgICogQGVwczogZW5kcG9pbnQgYXJyYXkNCj4gICAqIEBnYWRnZXQ6IGRl
dmljZSBzaWRlIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBwZXJpcGhlcmFsIGNvbnRyb2xsZXINCj4g
ICAqIEBnYWRnZXRfZHJpdmVyOiBwb2ludGVyIHRvIHRoZSBnYWRnZXQgZHJpdmVyDQo+IC0gKiBA
Y2xrczogYXJyYXkgb2YgY2xvY2tzDQo+IC0gKiBAbnVtX2Nsa3M6IG51bWJlciBvZiBjbG9ja3MN
Cj4gKyAqIEBidXNfY2xrOiBjbG9jayBmb3IgYWNjZXNzaW5nIHRoZSByZWdpc3RlcnMNCj4gKyAq
IEByZWZfY2xrOiByZWZlcmVuY2UgY2xvY2sNCj4gKyAqIEBzdXNwX2NsazogY2xvY2sgdXNlZCB3
aGVuIHRoZSBTUyBwaHkgaXMgaW4gbG93IHBvd2VyIChTMykgc3RhdGUNCj4gICAqIEByZXNldDog
cmVzZXQgY29udHJvbA0KPiAgICogQHJlZ3M6IGJhc2UgYWRkcmVzcyBmb3Igb3VyIHJlZ2lzdGVy
cw0KPiAgICogQHJlZ3Nfc2l6ZTogYWRkcmVzcyBzcGFjZSBzaXplDQo+IEBAIC0xMTM0LDggKzEx
MzUsOSBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJc3RydWN0IHVzYl9nYWRnZXQJKmdhZGdldDsNCj4g
IAlzdHJ1Y3QgdXNiX2dhZGdldF9kcml2ZXIgKmdhZGdldF9kcml2ZXI7DQo+ICANCj4gLQlzdHJ1
Y3QgY2xrX2J1bGtfZGF0YQkqY2xrczsNCj4gLQlpbnQJCQludW1fY2xrczsNCj4gKwlzdHJ1Y3Qg
Y2xrCQkqYnVzX2NsazsNCj4gKwlzdHJ1Y3QgY2xrCQkqcmVmX2NsazsNCj4gKwlzdHJ1Y3QgY2xr
CQkqc3VzcF9jbGs7DQo+ICANCj4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbAkqcmVzZXQ7DQo+ICAN
Cg0KUmV2aWV3ZWQtYnk6IFJvYmVydCBIYW5jb2NrIDxyb2JlcnQuaGFuY29ja0BjYWxpYW4uY29t
Pg0KDQo=
