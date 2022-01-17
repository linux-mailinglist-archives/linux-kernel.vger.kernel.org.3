Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C07491276
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 00:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiAQXuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 18:50:12 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:7633 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235399AbiAQXuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 18:50:11 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20HFo8Z9023812;
        Mon, 17 Jan 2022 18:49:37 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2053.outbound.protection.outlook.com [104.47.61.53])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dnbdu08kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 18:49:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd5payprWw28QhGaCUTKc+2SHZHJ0LOPYombrWDg9KSTYkyvhcDBrUOEz6jfp3wRyGhAul1DFvK+a7iFsMEWbkzipSNuMuhkYtGjh3hemG7GLTcT8qzsJJvH5563O/iX5XYVxoyv4z1/welkedxy6kEBfKHTP1HY4191HETZsQI/EvgvwwzMkQEBtfcPLM+lCsg9vfA+5Uwifc7oyP1XtMx147+714j9UcgvoaxUmVi82VDMwQkCYtVxjPXGeaAv5zBxGomjQR0H2Desk2IdcZGPtbZJkubISAUKZngHUZ3Ak/Pu0Ar8TsqJdxQUPc3MClRN7y2kHI809ci20lE98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+djVHPAY35GZf2cTDm0y4pGKWxWUHJGRNzPqigtw/PQ=;
 b=MGQEkldkDvCo2kquGOCl6tSlJMJAfaxqGM7wdq2ooLt8xGZsLuj6levjGZ0zgiLhUeiO7H3v10UBIBptaz9nitiAba9mAP6Iu36pirmQ6RxTH9PV/uRvVqDTE+SCNj3wYCo8ud2wKFLBkDT/9nC3f/JMXlQyWFZ8m9Rn6tOAPmvPqeb1MDDMgj2ESYaoshXVWH3llvg8EL6vO/3XljXe3sGN8p3w8926O3MT+STkb7NMFmVHPATXTqaywRTDMIWSMbtWIVFf7ObgWqxwofA7EugtMTU9BHG7hyEv0LuhfY/0tRvedJq79PfGkTrEDDOhoC3rhCGXilbbbp+BidgEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+djVHPAY35GZf2cTDm0y4pGKWxWUHJGRNzPqigtw/PQ=;
 b=3uyOgOEEsoU6JG4Rn3s3K34c/zmSI+3EIyWywWBoCp55eChUc48rLU6p7537EXEbZ4/HjQbqL6gDMkTOkS1HEPIMKDVv//1OSiJNTgoqBEi5movx1WWgzIFZ7zZGxNwd89pxkzlrzxAg0NVPKkni3kkIzy4FlgTALRN7KnA/388=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT2PR01MB4830.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:46::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 23:49:36 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 23:49:35 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "lijun.kernel@gmail.com" <lijun.kernel@gmail.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "agross@kernel.org" <agross@kernel.org>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
Thread-Topic: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Index: AQHYCZ/4XkJytJwIJEir+k8QaI40kqxnKKeAgAC93IA=
Date:   Mon, 17 Jan 2022 23:49:35 +0000
Message-ID: <79d6057a70dae09bcc30a35f608f51c5a768d097.camel@calian.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
         <CAKgpwJUMXk--4EaYOxAAtLJT85mDHRHMihr6n7y1HECN+gmBBw@mail.gmail.com>
In-Reply-To: <CAKgpwJUMXk--4EaYOxAAtLJT85mDHRHMihr6n7y1HECN+gmBBw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f814cae6-1243-491b-8abc-08d9da140470
x-ms-traffictypediagnostic: YT2PR01MB4830:EE_
x-microsoft-antispam-prvs: <YT2PR01MB4830572DFCED668B00335994EC579@YT2PR01MB4830.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6sPPTgyVzdSM4LlE7LB9zgF19+6yzHG+hhFgvQsdEnWrrx0IIvnhnbRQOM5kDKPxcIe+0wP548nwabOjs7zlwu+nDJZqp0MvqXiHfJl6ScV5pK9ewl+eLnFC4NiTV1uED//TaKz5mVsJFduPEEF7LlDbm/V9TO2gT/11CyqJ6AXljsHl1mZcI1E29mPZtuFsvdluROaFS7/g0ASZCCYr76skpqiYFpK4ZK8jbCD805aeQYYHB4Xs/F3fAFmQnsZLqYh0bQn0aMkI4nM1dLFkWKuMzIVakE9vHRxNox7usr+D2CGB5JwGJgOlCxJ4Q8UZ9TasCk3YeMZhZF7f18L+VgpxvaQmTcJYzlE30XlsARgMP1Mh4TxER9mspUMnaZrt0PL2aIiEs1/x72uHLtVOHE8PGbfSa2QanUp+4z18uwCIKcJt94YUBDkmLuq+LbziR30zWgs99bW/sJ1P93eBTwBdsanLm02Rh6KVg3NlSOMCQMbM5UXpWspd+U0WC8XT/saZjn3euZw/mDerTHa8VTI1sSqbCNypu00aCj/6JXWFqCvcE67C17JFi+x7PW0246icx++rBlEAAUBk9bJk5tQPtleW3MFZnypWURT2uXIEcp9PnC7yU/dudw/q/7V7ivIdTHvBQaP5Z5WQ+B0SYssdIM37ue6IXNY0QnP3j3AlUt0o8iVTZbjL2PnpfMn+9DgZnQXeTPQ5JmNWA6dQHxuGC6Za3xTZ5xR+2JUJCjt8pl72mIZX0BvA0Tsu7QG12Zon/0CEvkmXvy3yHB2JyLjg7sDULfFpPKmzpj+p9dFeG1OTgSkflNQqYMF2Ix8Ydjowr5yZWm1vSpZDLD0sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(6506007)(2616005)(8676002)(66556008)(5660300002)(66946007)(66446008)(64756008)(66476007)(7416002)(91956017)(76116006)(86362001)(4326008)(71200400001)(54906003)(15974865002)(508600001)(36756003)(44832011)(122000001)(110136005)(6512007)(316002)(2906002)(38100700002)(38070700005)(83380400001)(6486002)(8936002)(966005)(186003)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVI0N1JOckhkYWtTY0d1Y1FIajdjS3pycDhwUWw1WW1wdTI2aVBSemhMZmdP?=
 =?utf-8?B?Y0EyU2dwMk5uNStnT0NENkszK0l1clFRbzVubEF6TmZjRklSODFzVFpOYitP?=
 =?utf-8?B?RnVtS29rYitKNGNhV1RjMzZSODhiZVE2dTJoUHppeG1qV2loWk1qY3hSUUNF?=
 =?utf-8?B?eE5ldHY5bFRCUmFPNTJTaU9sMU5ZYjRISDJZMFB2OTB3aEFwbk9YcXg2aWcw?=
 =?utf-8?B?d2ZkMjEwaUpJaTFpelRyUHViYUx4c1pxZ1ZvdVZFcHowMWJRdDUwR2JQeklC?=
 =?utf-8?B?UkU1SzNVKzF0S1FTb202cjg3WUw3WDFWQ3QwZVMwNFJPQTFLZ0MzeExoWnpW?=
 =?utf-8?B?bW9OcEZFWkZMT1NMVncwL1V0N1cyMW1YYWs0TWZhaWxHNnNIUFBleTRpS3gz?=
 =?utf-8?B?ckcrV2IzU0l5MnN3Mm5hRGU5Z2t2WHhmWkw1Mko1ZVZtR2JTd3lmZzZvV2xq?=
 =?utf-8?B?anZoVUxjNjA3dndIWC82SnlyMG9XVWcrVCtJajVsbGtLZWJieldCeVBXQ3hQ?=
 =?utf-8?B?WFdqZ2p4b1djYm1TcXI2c3lmNGNZVWpsMjJrRTZBbHlKRHpNTjdhSjJCcCt5?=
 =?utf-8?B?RWRNUmM5QkJFaFVhbi9vcUluTGRNKy9wVXA4c0Mrc1Z0T2NQODArMmU2R2Qy?=
 =?utf-8?B?MkNURXh1TWJId0g2TllJZWlxWVlKQWhxR3FtOW1jNlYwRUVSNXpYcG9mdTlj?=
 =?utf-8?B?cWVRTkFVSFRHVEVVcXZBN1lDK1pacmV4NkJKakZ5ZytvR1RMUmZEMGZ4MlRV?=
 =?utf-8?B?NklSb3FWd2VyM2tOOHBhZnNZbDk0RVpveU9ZSUFjY2JLMXNQZGQ0UmJWZkJl?=
 =?utf-8?B?QzdLb01CRmhFdS85QVBEWnVjdnJ0WEFISStuVDhpU0x1YkZGZUo1cGFYM25S?=
 =?utf-8?B?UmhVcFU3eDNha0l6SyswSkR6dzdtMWcyVFZOWjBXb2VkdzZmWEs5V3FwSmNn?=
 =?utf-8?B?ZURRMkdzYTkzaThXcXF4NFFlNzB6SWlLaEd5R3oyUzl1d0xyZ3BMVkxLV1JH?=
 =?utf-8?B?Y0QvRjliYjdrenBWaURldXlqTGwvSktLT1UyNGxlNU1IeTdFZ3dSLzRzcUVD?=
 =?utf-8?B?clRuVVowOWJDQ1JYSEY4bFVaeGlyZjBCWXh3bjMrbHMrb0VBVUtRNis4Y0NX?=
 =?utf-8?B?VHE0RXBMTXVlVVRsNUd0NGxlZ1V2bUt3WWcrYndDcnBMVzc0QjJDR3dWSHZL?=
 =?utf-8?B?N2xOR2RUU1FaTFlwbVdpaUVZaFhTZG1XaWZab3FGRUxSQWp6UEdHWkxmdXlw?=
 =?utf-8?B?STZaMVg4SVZXb2ExSzBwT2pjSVBEZmM2eDZqSUdBeDJyM1R6OEZWL1VRQnVh?=
 =?utf-8?B?dEwzK1lEazZ0eEViRmxVZldoV29EUnJhWEZGYWlIWEVUeGExWXVlOTFRQnN6?=
 =?utf-8?B?VXJRRkI5NU5SNkgwSVJWME1aYUZHQi9ERHFGUmNKM0pZUys2SlB2ZWw1YWZi?=
 =?utf-8?B?Wk1CRTdESGZyNzdJMHV2RU16S29DeU5HT1ZPWDdLQU1ieEZzVU9pdTVhVnZx?=
 =?utf-8?B?STBORjROUnpOazY1Sk9UVXZEVVlxcndMTjd5RUhIaXpYcFRqMkRQR1NsY3Jx?=
 =?utf-8?B?eFZYdU4xSTJVcGJ4eXhiQUhiTTdLUldnSHNYVEFIbkVEY1h0R0hldVNIbE1t?=
 =?utf-8?B?dGU3a015ZXVVUVJ3UUt3c3JNaUszbkZQUEV2RFNjMjdMTGIrbjdVUmNDSzcz?=
 =?utf-8?B?aDM0cVhRaWFoRVJYcFp6ZWhnMjRmeXYwR2g5Z215cXVtRERVbXIvVGxSKytt?=
 =?utf-8?B?VE5Oa0NNT0F0NWRqZ2I0U0lpQm9IVGpTamFuSzFGazQ5RElkeStJcVY3MTR2?=
 =?utf-8?B?Z2ZUa1had0xvZHQ1SG9pZVZITkdQd3E2VzliaUttaUZVa1ZFdkMvaExjT2VQ?=
 =?utf-8?B?Y0ZHQzBqMWtQZnZ6T3NNeUQ0RUdXNkIvSmZUeFdYTUNsMWtaWUdOcXNjOG9X?=
 =?utf-8?B?RFRBZlYrMHBaQ0J1dm82LzhQdEIrUnF0b3R2M2E4NExmRklpWVpGYXBhZlYv?=
 =?utf-8?B?ampGcDlpeXcwK1BOR0Fwd05Ua0d6QS9qcTdVWHVpVENHRXVBT2RiNXNZR0JI?=
 =?utf-8?B?dk9uRCtvbXRnUmpXN0lQMDVjaExyZm9YWC9zcjRvZ1BrV24vWlFXVnhtNGtQ?=
 =?utf-8?B?SlBiZ2VyakpGRjVFVEpvYkpJWDYrTDc4d1kvQitMNSsxalVOU2c4LzlUcVM5?=
 =?utf-8?B?RFl3QW1xQ2lsYXRDelE2QW43ZHNZb3JtT2ZOOTJnOEt4T1Yrd0hCNklqMm9j?=
 =?utf-8?Q?qYPrsd0lAxtUBJGioInhNaTYUCd9wQ2sLsukyzCpac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71A51FFE2CD7284F89F22DD32A007340@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f814cae6-1243-491b-8abc-08d9da140470
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 23:49:35.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6Z2FhuwrMgn3sdmRAreVAqEMARbiP1RN/+Atw/SJhpU/2dbv8F0nq6mCXQRNCEo34qEp7kNPc0NnrMusfXUD2+btyFBCSPj5fno1XDqHis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB4830
X-Proofpoint-ORIG-GUID: 9ecFqvADNIidfzDdvV47VgXHNFKtQmCF
X-Proofpoint-GUID: 9ecFqvADNIidfzDdvV47VgXHNFKtQmCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTE3IGF0IDIwOjMwICswODAwLCBKdW4gTGkgd3JvdGU6DQo+IFNlYW4g
QW5kZXJzb24gPHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+IOS6jjIwMjLlubQx5pyIMTXml6Xlkajl
ha0gMTA6MTHlhpnpgZPvvJoNCj4gPiBUaGlzIGlzIGEgcmV3b3JrIG9mIHBhdGNoZXMgMy01IG9m
IFsxXS4gSXQgYXR0ZW1wdHMgdG8gY29ycmVjdGx5IHByb2dyYW0NCj4gPiBSRUZDTEtQRVIgYW5k
IFJFRkNMS19GTEFESiBiYXNlZCBvbiB0aGUgcmVmZXJlbmNlIGNsb2NrIGZyZXF1ZW5jeS4gU2lu
Y2UNCj4gPiB3ZSBubyBsb25nZXIgbmVlZCBhIHNwZWNpYWwgcHJvcGVydHkgZHVwbGljYXRpbmcg
dGhpcyBjb25maWd1cmF0aW9uLA0KPiA+IHNucHMscmVmLWNsb2NrLXBlcmlvZC1ucyBpcyBkZXBy
ZWNhdGVkLg0KPiA+IA0KPiA+IFBsZWFzZSB0ZXN0IHRoaXMhIFBhdGNoZXMgMy80IGluIHRoaXMg
c2VyaWVzIGhhdmUgdGhlIGVmZmVjdCBvZg0KPiA+IHByb2dyYW1taW5nIFJFRkNMS1BFUiBhbmQg
UkVGQ0xLX0ZMQURKIG9uIGJvYXJkcyB3aGljaCBhbHJlYWR5IGNvbmZpZ3VyZQ0KPiA+IHRoZSAi
cmVmIiBjbG9jay4gSSBoYXZlIGJ1aWxkIHRlc3RlZCwgYnV0IG5vdCBtdWNoIGVsc2UuDQo+IA0K
PiBEV0MzIGRhdGFib29rIHN0YXRlcyBhICpjb25kaXRpb24qIGZvciBwcm9ncmFtIHRob3NlIHNl
dHRpbmdzOg0KPiANCj4gVGhpcyBmaWVsZCBtdXN0IGJlIHByb2dyYW1tZWQgdG8gYSBub24temVy
byB2YWx1ZSBvbmx5IGlmDQo+IEdGTEFESl9SRUZDTEtfTFBNX1NFTCBpcyBzZXQgdG8gJzEnIG9y
IEdDVEwuU09GSVRQU1lOQyBpcyBzZXQgdG8gJzEnLg0KPiBUaGUgdmFsdWUgaXMgZGVyaXZlZCBh
cyBmb2xsb3dzOg0KPiBGTEFESl9SRUZfQ0xLX0ZMQURKPSgoMTI1MDAwL3JlZl9jbGtfcGVyaW9k
X2ludGVnZXIpLSgxMjUwMDAvcmVmX2Nsa19wZXJpb2QpKQ0KPiAqIHJlZl9jbGtfcGVyaW9kIHdo
ZXJlDQo+IOKWoCB0aGUgcmVmX2Nsa19wZXJpb2RfaW50ZWdlciBpcyB0aGUgaW50ZWdlciB2YWx1
ZSBvZiB0aGUgcmVmX2Nsaw0KPiBwZXJpb2QgZ290IGJ5IHRydW5jYXRpbmcgdGhlIGRlY2ltYWwg
KGZyYWN0aW9uYWwpIHZhbHVlIHRoYXQgaXMNCj4gcHJvZ3JhbW1lZCBpbiB0aGUgR1VDVEwuUkVG
X0NMS19QRVJJT0QgZmllbGQuDQo+IOKWoCB0aGUgcmVmX2Nsa19wZXJpb2QgaXMgdGhlIHJlZl9j
bGsgcGVyaW9kIGluY2x1ZGluZyB0aGUgZnJhY3Rpb25hbCB2YWx1ZS4NCj4gDQo+IFNvIHlvdSBt
YXkgbmVlZCBhIGNvbmRpdGlvbiBjaGVjaywgd2l0aCB0aGF0LCBvbmx5IHJlcXVpcmVkIHVzZXJz
DQo+IGFyZSBlZmZlY3RlZCBldmVuIHdpdGggInJlZiIgY2xvY2sgc3BlY2lmaWVkLg0KPiANCg0K
VGhlIFhpbGlueCByZWdpc3RlciBkb2N1bWVudGF0aW9uIGZvciB0aGlzIHJlZ2lzdGVyIGluIHRo
ZSBEV0MzIGNvcmUgKCANCmh0dHBzOi8vd3d3LnhpbGlueC5jb20vaHRtbF9kb2NzL3JlZ2lzdGVy
cy91ZzEwODcvdXNiM194aGNpX19fZ2ZsYWRqLmh0bWwgKSBoYXMNCnRoZSBzYW1lIGRlc2NyaXB0
aW9uLCBidXQgaXQgaXMgcmF0aGVyIGNvbmZ1c2luZ2x5IHdvcmRlZC4gSSBzdXNwZWN0IHdoYXQg
dGhleQ0KcmVhbGx5IG1lYW4gaXMgdGhhdCAidGhpcyBmaWVsZCBvbmx5IG5lZWRzIHRvIGJlIHBy
b2dyYW1tZWQgaWYNCkdGTEFESl9SRUZDTEtfTFBNX1NFTCBpcyBzZXQgdG8gJzEnIG9yIEdDVEwu
U09GSVRQU1lOQyBpcyBzZXQgdG8gJzEnIiwgbm90DQoidGhpcyBmaWVsZCBzaG91bGQgb25seSBi
ZSBwcm9ncmFtbWVkIGlmIEdGTEFESl9SRUZDTEtfTFBNX1NFTCBpcyBzZXQgdG8gJzEnIG9yDQpH
Q1RMLlNPRklUUFNZTkMgaXMgc2V0IHRvICcxJyIuIEknbSBub3Qgc3VyZSBpZiBzb21lb25lIGNh
biBjb25maXJtIHRoYXQNCmludGVycHJldGF0aW9uIGlzIGNvcnJlY3Q/DQoNCkhvd2V2ZXIsIGxv
b2tpbmcgYXQgdGhhdCBkZXNjcmlwdGlvbiBhIGJpdCBmdXJ0aGVyLCBpdCBsb29rcyBsaWtlIHRo
ZXJlIGFyZQ0Kc29tZSBvdGhlciBmaWVsZHMgaW4gdGhhdCByZWdpc3RlciB3aGljaCBhcmUgZGVw
ZW5kZW50IG9uIHRoZSByZWZlcmVuY2UgY2xvY2s6DQpHRkxBREpfUkVGQ0xLXzI0ME1IWl9ERUNS
IChiaXRzIDMwOjI0KSBhbmQgR0ZMQURKX1JFRkNMS18yNDBNSFpERUNSX1BMUzEgKGJpdA0KMzEp
LiBJdCBsb29rcyBsaWtlIHRoZSBYaWxpbnggYm9hcmQgSSBhbSB1c2luZyBoYXMgdGhvc2Ugc2V0
IHByb3Blcmx5LCBpLmUuIHRvDQoxMiBhbmQgMCByZXNwZWN0aXZlbHkgKEknbSBndWVzc2luZyBi
eSBoYXJkd2FyZSBkZWZhdWx0LCBzaW5jZSBJIGRvbid0IHNlZQ0KYW55dGhpbmcgaW4gdGhlIEZT
QkwgcHN1X2luaXQgY29kZSBzZXR0aW5nIHRob3NlKSwgYnV0IGl0IHdvdWxkbid0IGh1cnQgdG8N
CmVuc3VyZSB0aG9zZSBmaWVsZHMgYXJlIGFsc28gc2V0IGNvcnJlY3RseS4NCg0KPiBMaSBKdW4N
Cj4gDQo+ID4gWzFdIA0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMjAxMTQwNDQyMzAuMjY3NzI4My0xLXJvYmVydC5o
YW5jb2NrQGNhbGlhbi5jb20vX187ISFJT0dvczBrITM4N0RtUGVsT0lBNVo2WlNmelNGMnNwV1B1
M2xBUmxya2RtSVJHY1B3bFdEWkdEUXpkbEVkRUtCdzFSV0c4YVJDMzgkDQo+ID4gIA0KPiA+IA0K
PiA+IA0KPiA+IFNlYW4gQW5kZXJzb24gKDYpOg0KPiA+ICAgZHQtYmluZGluZ3M6IHVzYjogZHdj
MzogRGVwcmVjYXRlIHNucHMscmVmLWNsb2NrLXBlcmlvZC1ucw0KPiA+ICAgdXNiOiBkd2MzOiBH
ZXQgY2xvY2tzIGluZGl2aWR1YWxseQ0KPiA+ICAgdXNiOiBkd2MzOiBDYWxjdWxhdGUgUkVGQ0xL
UEVSIGJhc2VkIG9uIHJlZmVyZW5jZSBjbG9jaw0KPiA+ICAgdXNiOiBkd2MzOiBIYW5kbGUgZnJh
Y3Rpb25hbCByZWZlcmVuY2UgY2xvY2tzDQo+ID4gICBhcm02NDogZHRzOiB6eW5xbXA6IE1vdmUg
VVNCIGNsb2NrcyB0byBkd2MzIG5vZGUNCj4gPiAgIGFybTY0OiBkdHM6IGlwcTYwMTg6IFVzZSBy
ZWZlcmVuY2UgY2xvY2sgdG8gc2V0IGR3YzMgcGVyaW9kDQo+ID4gDQo+ID4gIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCAgICB8ICA3ICstDQo+ID4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvcWNvbS9pcHE2MDE4LmR0c2kgICAgICAgICB8ICAzICstDQo+ID4gIC4uLi9h
cm02NC9ib290L2R0cy94aWxpbngvenlucW1wLWNsay1jY2YuZHRzaSB8ICA0ICstDQo+ID4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC5kdHNpICAgICAgICB8ICA0ICstDQo+ID4g
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICB8IDk4ICsrKysr
KysrKysrKysrKystLS0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggICAgICAgICAgICAg
ICAgICAgICAgIHwgIDYgKy0NCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCsp
LCAyNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+IA0KLS0gDQpS
b2JlcnQgSGFuY29jaw0KU2VuaW9yIEhhcmR3YXJlIERlc2lnbmVyLCBDYWxpYW4gQWR2YW5jZWQg
VGVjaG5vbG9naWVzDQp3d3cuY2FsaWFuLmNvbQ0K
