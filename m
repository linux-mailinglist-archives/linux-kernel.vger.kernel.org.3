Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE89C4952BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377169AbiATQ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:56:44 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:53037 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377148AbiATQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:56:40 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20KBU4Pj019111;
        Thu, 20 Jan 2022 11:56:27 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2050.outbound.protection.outlook.com [104.47.60.50])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dpmt68nrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 11:56:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+aruC+X4Wz9ymD30O3eyU70OOnDxdXPvSgbiKygMka/pFM2H1hLtvr8trpqgas5pMcDu16Sf9hgxOAhRyupO7VyLUMlJGp248dOQN8YaIwrKB2YjJo6y0mll3b+P0GfgHes4/Oa5vePdfkTyohQKyvYve4cefZVU6cP14YRSjBdngSxeui0M6YuoSy9fpQR6WAh576mOXRlpU4RHpdGa1u3OtMNg6Yn+nbT2UAgxRQ37w3nyYav1nyWjPWZqngknQhZKJf/oGYfP8naxhjorpBiFYWrl+66f59Om+7RASosMOLI5jGl8Mvkvlbq3ed0GebyULtFgBviyu3dO+56JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnhZcEu+RsV1rlXNsZL24G4z0Rb5Zo9SlTdFAQWVvyE=;
 b=OzrvCfNYdUSAgn6S30/AR9fktyWbguV9gouQ7qm11xAAoyKC/P1OWRKIOkUwwxZKkg65slFF1/59Zc8kbeDY2+kCNQuOhQ20z2MQZRbDMJkLOfHC+6RDWwNy++4P4qsyv8leaNxblZ/t5rvR1e7xQES2rBMK3ihxxtoGLHYC5+cPezM20yY5d6prkEhhj6KVgoeBOoKFgtRksbTjvjg1k4vRZRyPTnRqZSjhhaxFCX/wplYHqpkj7LkIHM0ZNTrNDWVjWaOY9c6N22FJzkO4IPYMFHewYtxAc5ZRIwXybWn+3n8jY/dzoQrjDWvg36b/IItNPOJgy8chDKpLgalrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnhZcEu+RsV1rlXNsZL24G4z0Rb5Zo9SlTdFAQWVvyE=;
 b=WAcKzrbSG0QBY+23IJy9B4lora+ipB47XrerXqjAVeSA5YdpaCVlNwKsTLSARhLgRAdLwLtaGjJpet/oc8xQStk0c4KIlpDQtsHX/A7KysYNA9U8RNAvvEQPF5P3IgC0ZCvm84Sgyj08GmFZou7DVoOy5jEhYcVT0vINwrU/8nY=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQXPR0101MB1383.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 16:56:25 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 16:56:25 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 6/7] arm64: dts: zynqmp: Move USB clocks to dwc3 node
Thread-Topic: [PATCH v2 6/7] arm64: dts: zynqmp: Move USB clocks to dwc3 node
Thread-Index: AQHYDMsFXieQBjNxQke1s109DlGYs6xsI7uA
Date:   Thu, 20 Jan 2022 16:56:25 +0000
Message-ID: <dd0a14dadc15a242af160a127c1db4241b9526e7.camel@calian.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
         <20220119002438.106079-7-sean.anderson@seco.com>
In-Reply-To: <20220119002438.106079-7-sean.anderson@seco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96a3ae7a-7a89-4e58-be4b-08d9dc35cbac
x-ms-traffictypediagnostic: YQXPR0101MB1383:EE_
x-microsoft-antispam-prvs: <YQXPR0101MB13838FFF415DD73787B46A15EC5A9@YQXPR0101MB1383.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9O+w4wruKp6SloFZYp8aTRAgFeddcJ58kzhqdzrfOEjIXXqh+JxpLnZ/W8wP61D6yonCPwm40TUZOiC57t5QIYugkkSno4aBRZoRAJBYFkoSFvZu4ZGBYMJEuB+vzQQtyg1XIjkTT4XbtIQ7MaX70nvyZhdzSJ4pt5okqOMY9eK8Y7ZdWB2TACtGKFm777/U3Egk1OKUgSqkPyoQohDvzPBDBQddbJooNfK7KhdfUDIEH+bY0BahP3lllWPlAHsjUEot1+fTfUK+JJ6IdxV7fWLzlWKmj2bNZVtIDUz01dEl6b2d73qRXBteZh0pR8hmVs1yLJxpDtJ7Ne8IQz0CHhc49T9TgSe9FtakZyeniG2bHNmA6z/oyDp2nbaXenf+HbUMsrIxN+y8Wz3UYyDCxY3JndB1olizso1UEtQMdX0uUijOjl2wm0t4zMWz6HSHLXyKX/cCAhP5Uw7qPP+CT+l9yDfdi6AAQrtd6GbdOFpaxPeUPM71oAcWte5MVQUHBnwp15Mqfj/sQCVFZFgPOFTfSCDY3wzhZzftw3doAHiZY4R/hWKDpPtsdvd0MiaYkESHiEUjHizUI07xd/Lf3ct40gcZ/qdOuZZZeusfAQ5OPrNMLkxHVIGvlfUNEk8iRoYwYFGQBjZN8LvsSR5KMBPdss/YTgRpp2xy7jtzxvzmv1O/G4KzASQ1STaTZ9P7y1Ws/+vLz2tGIOaDnGsZxlhDLgzSlIaEDVR6lQY/qCA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(5660300002)(8676002)(66476007)(316002)(6506007)(83380400001)(66556008)(66446008)(186003)(110136005)(8936002)(2906002)(44832011)(86362001)(71200400001)(6486002)(54906003)(2616005)(91956017)(36756003)(26005)(6512007)(66946007)(508600001)(64756008)(122000001)(76116006)(4326008)(38070700005)(7416002)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0tUSWw5MGVsdTQ0cUxramVEU3h3RGhIektXQXJHY21yOURBSitBQXN4bmtV?=
 =?utf-8?B?ZnhUNC9rU0owOGdGUkFROTJJeUZCMW9WdW1mdHljRnlKWVdFditVbUc5cTVN?=
 =?utf-8?B?RnljUkZsQ2xaT1l5alBlNkRoY0JmYkhxZ3EvZUVIOXY1VUlPUmszUmQrV2tl?=
 =?utf-8?B?YmR5WVg3bHc4akFTdStVTDREV1RJMjNDdzFBSGZVWlljVyttK3R5YjZMWlZz?=
 =?utf-8?B?bVJRRXRGMXljbDNtUUJLL0FxU0hHQktGWVJiaHQ1a3ZmMG0yd0k0bDZ2SUNx?=
 =?utf-8?B?aW1UT1NpSGlQbmo0Ymo1T29GQ1lnS3lWMzlLUml4WTN5b2grVk5qdUl5blBN?=
 =?utf-8?B?MFF4QUZNWG84cFJZMkttc0ZqU0swZ2E3TXQ2SEljRnNJRzBFWXhQSzA1VERV?=
 =?utf-8?B?T1lxc0g4OXlsWHVZRVNoc3MvaGpxQS9kb3F3dkg5RXo0U1c0VXZtQ1doa2hB?=
 =?utf-8?B?bXFnTThQc3dpdXd1M0FRS010MVdKVzRNaUx4dExJTjRnWTBIRGUrRFIxUGpF?=
 =?utf-8?B?TDB3eG5UY3lYUXpLOVFYWEphRHZ4bW0vU2RBSTJXejQ5b0Izall3TlEwcGln?=
 =?utf-8?B?RTBIOGhvYWJad3dydmlIWUY0Z2hmc3FuaHg3Yk1tUXpMNzVpc3NZdHM5VjB5?=
 =?utf-8?B?VGdJb1BlMDlTUW4rYVdZcHJQazlXcC9xaWxSN2JlQWFxU21LT3o0aDNjVnQr?=
 =?utf-8?B?alVqTU9xeWE3eW5tQyt5aVBVeVRPaEprcGM3cGpsZFNRdXJ1Mlp6Ly9PY2Rr?=
 =?utf-8?B?SHJkQmkzMnl3REhlZjBpSkQ2L3JZK3ZFYXpPejRIY05UL3hSWFZrdXFOZEEy?=
 =?utf-8?B?cnpIajU0ZTlscThQZ2kwQUFFYVJJRWZRa1RJdzNNU21kUTdiR25ydU95Nm9I?=
 =?utf-8?B?Z1ZObG1Ia2RxOUM2Y1R5NTB5TExPUFZHdERxYlNZMmYvaGc5ZitrQkJhNlNR?=
 =?utf-8?B?eTY5Tll1d205M2NYelJKSDVtNWEwMXFUS2JXT2h0NzFKSnRRdzk1WEtLd1FH?=
 =?utf-8?B?NENTdmJLMkNvY0N5NGZjWHlaempQdkkwcThKRHdYQ3NNaGE3bFJLdFRWMzJR?=
 =?utf-8?B?VFd5SmxCTWpXbmsyTEVJY0NYdHJDcDdzVlV2ekFWZ0cxRUlKWHFPNld6WDhV?=
 =?utf-8?B?WWNYb3p0VUtGMkNDb240Y3hQdmFaNktWNnRNcnFIam1QL3FieVlMVDdEUzU1?=
 =?utf-8?B?NDFUTGhrTmJ1TkRhTE1penUyVllnekRjaFl3YnNrbDdiQlFSRm4vanVHRHlt?=
 =?utf-8?B?RGZ0QTRibTBDNWFISE0zckh3d0d4UXd0WHhTYnR5cDVkaytNNzJ0WHVNKzY5?=
 =?utf-8?B?K2NLODZFQzZna2s2Q0F6VXFSb0oweFd6MUdMMlhHcThMLytmdmtwWkJvcVVQ?=
 =?utf-8?B?QzNqT3dqeThOc01kZ3dOTGY5UjNtUzMwTm9wRzVraWFwTFlkRWZkTDBXdzZ3?=
 =?utf-8?B?UkZtTmVreXREUmhIb0dJYS9QNnROWjBtdC9oR2svb0hsYjJjNUZJNTBOd2JE?=
 =?utf-8?B?dmxEK0ZKbWJNNWFPZmh4cU5vZk1zN21RSDMvYjJhcmpjN3pLVVYwVTRMeC9p?=
 =?utf-8?B?YUJvNjFaQkpKYzhTR3pWaFJkV25MQjRtMS9ZUkdPcXU4QkU1SDM2dzBCOW1y?=
 =?utf-8?B?Z1QzOXVrR2VLNW1hWFlOTUZjVlBzT2dQa3VqeTl6YXJzZ2t3TW92TWJpK1dH?=
 =?utf-8?B?RW9keUtzVVBJdzRKZjFTdXNtS3pSSXFwcytwaWxkeFZ4dDZqVDZLc0xPc2xD?=
 =?utf-8?B?ZlIzeU82NG90MGdlOGxlK2E3c0FMRkJBY2tvbnFvNlRHWEMyaGRmazZZSWRh?=
 =?utf-8?B?bmpXU2dlSFZ6MWFraGVQZ3lrUk9MUEVpb2p6WWk1bEJmTURKL2tmSnNtelE1?=
 =?utf-8?B?MElSRHRzMEhlc3BaZHJNaWkxMXhvWnoxaGhCRFNPTDM0WEZubi9OczZYa2tn?=
 =?utf-8?B?eEI2UXMvV3FZRWlYd0crRSt6cjJmcG92V2h6dGxGaXVTQUhJVGVRdnpwTE1Z?=
 =?utf-8?B?Z2NPRTZTYkgwcllMVEZDR3MzRElmUzlZaHIzS2dJTExQRjlEM0hITzBtd1Z2?=
 =?utf-8?B?b0pMOEkvYTIvelJBcTJUdG02OGJYUWxXSXhlMUZwRE5RNGdyMmxtY3lLbnhI?=
 =?utf-8?B?eXRUenlpQjUvQUwxT1hldndPZm5lekJ6d2czN1ZSS2hSc3U0bXI5ZGlHV1hn?=
 =?utf-8?B?K3pEcGR6VTBjekNtYi83VXFGc1Zkd3ZSU255YWVGeVI1dnhPdU5sSHdhaXh4?=
 =?utf-8?Q?lDD9KLF1gOu0Q6D1BAFEtL4ItzO9HsLU7oCbJKhiYA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A525BCAD38959B46AB52A0D0B96CE6CA@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a3ae7a-7a89-4e58-be4b-08d9dc35cbac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 16:56:25.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYgKqrHv73WtoU3Jj+/dHctsjD5NNF9e3uKkEczPg8sNTGXYmpviC1AXEnRsDOEj8A/Ht5STCOv9TMlL6Jy7XDpwFGlPZoSPdvxwHIA8its=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1383
X-Proofpoint-GUID: xyPP-gbl59_KNI5gJHfSV6wIK7hi7KmE
X-Proofpoint-ORIG-GUID: xyPP-gbl59_KNI5gJHfSV6wIK7hi7KmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=853 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTE4IGF0IDE5OjI0IC0wNTAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0K
PiBUaGVzZSBjbG9ja3MgYXJlIG5vdCB1c2VkIGJ5IHRoZSBkd2MzLXhpbGlueCBkcml2ZXIgZXhj
ZXB0IHRvDQo+IGVuYWJsZS9kaXNhYmxlIHRoZW0uIE1vdmUgdGhlbSB0byB0aGUgZHdjMyBub2Rl
IHNvIGl0cyBkcml2ZXIgY2FuIHVzZQ0KPiB0aGVtIHRvIGNvbmZpZ3VyZSB0aGUgcmVmZXJlbmNl
IGNsb2NrIHBlcmlvZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQW5kZXJzb24gPHNlYW4u
YW5kZXJzb25Ac2Vjby5jb20+DQo+IC0tLQ0KPiANCj4gKG5vIGNoYW5nZXMgc2luY2UgdjEpDQo+
IA0KPiAgYXJjaC9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1wLWNsay1jY2YuZHRzaSB8IDQg
KystLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1wLmR0c2kgICAgICAgICB8
IDQgKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1w
LWNsay1jY2YuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC1jbGst
Y2NmLmR0c2kNCj4gaW5kZXggMWUwYjFiY2E3Yzk0Li44NDkzZGQ3ZDVmMWYgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC1jbGstY2NmLmR0c2kNCj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1wLWNsay1jY2YuZHRzaQ0KPiBAQCAt
MjIzLDExICsyMjMsMTEgQEAgJnVhcnQxIHsNCj4gIAljbG9ja3MgPSA8Jnp5bnFtcF9jbGsgVUFS
VDFfUkVGPiwgPCZ6eW5xbXBfY2xrIExQRF9MU0JVUz47DQo+ICB9Ow0KPiAgDQo+IC0mdXNiMCB7
DQo+ICsmZHdjM18wIHsNCj4gIAljbG9ja3MgPSA8Jnp5bnFtcF9jbGsgVVNCMF9CVVNfUkVGPiwg
PCZ6eW5xbXBfY2xrIFVTQjNfRFVBTF9SRUY+Ow0KPiAgfTsNCj4gIA0KPiAtJnVzYjEgew0KPiAr
JmR3YzNfMSB7DQo+ICAJY2xvY2tzID0gPCZ6eW5xbXBfY2xrIFVTQjFfQlVTX1JFRj4sIDwmenlu
cW1wX2NsayBVU0IzX0RVQUxfUkVGPjsNCj4gIH07DQo+ICANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0
cy94aWxpbngvenlucW1wLmR0c2kNCj4gaW5kZXggNzRlNjY0NDNlNGNlLi5iYTY4ZmI4NTI5ZWUg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC5kdHNpDQo+
ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC5kdHNpDQo+IEBAIC04MTEs
NyArODExLDYgQEAgdXNiMDogdXNiQGZmOWQwMDAwIHsNCj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+ICAJCQljb21wYXRpYmxlID0gInhsbngsenlucW1wLWR3YzMiOw0KPiAgCQkJcmVnID0g
PDB4MCAweGZmOWQwMDAwIDB4MCAweDEwMD47DQo+IC0JCQljbG9jay1uYW1lcyA9ICJidXNfY2xr
IiwgInJlZl9jbGsiOw0KPiAgCQkJcG93ZXItZG9tYWlucyA9IDwmenlucW1wX2Zpcm13YXJlIFBE
X1VTQl8wPjsNCj4gIAkJCXJlc2V0cyA9IDwmenlucW1wX3Jlc2V0IFpZTlFNUF9SRVNFVF9VU0Iw
X0NPUkVSRVNFVD4sDQo+ICAJCQkJIDwmenlucW1wX3Jlc2V0IFpZTlFNUF9SRVNFVF9VU0IwX0hJ
QkVSUkVTRVQ+LA0KPiBAQCAtODI1LDYgKzgyNCw3IEBAIGR3YzNfMDogdXNiQGZlMjAwMDAwIHsN
Cj4gIAkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiAgCQkJCWludGVycnVwdC1uYW1l
cyA9ICJkd2NfdXNiMyIsICJvdGciOw0KPiAgCQkJCWludGVycnVwdHMgPSA8MCA2NSA0PiwgPDAg
NjkgND47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAiYnVzX2Vhcmx5IiwgInJlZiI7DQo+ICAJCQkJ
I3N0cmVhbS1pZC1jZWxscyA9IDwxPjsNCj4gIAkJCQlpb21tdXMgPSA8JnNtbXUgMHg4NjA+Ow0K
PiAgCQkJCXNucHMscXVpcmstZnJhbWUtbGVuZ3RoLWFkanVzdG1lbnQgPSA8MHgyMD47DQo+IEBA
IC04MzgsNyArODM4LDYgQEAgdXNiMTogdXNiQGZmOWUwMDAwIHsNCj4gIAkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICAJCQljb21wYXRpYmxlID0gInhsbngsenlucW1wLWR3YzMiOw0KPiAgCQkJ
cmVnID0gPDB4MCAweGZmOWUwMDAwIDB4MCAweDEwMD47DQo+IC0JCQljbG9jay1uYW1lcyA9ICJi
dXNfY2xrIiwgInJlZl9jbGsiOw0KPiAgCQkJcG93ZXItZG9tYWlucyA9IDwmenlucW1wX2Zpcm13
YXJlIFBEX1VTQl8xPjsNCj4gIAkJCXJlc2V0cyA9IDwmenlucW1wX3Jlc2V0IFpZTlFNUF9SRVNF
VF9VU0IxX0NPUkVSRVNFVD4sDQo+ICAJCQkJIDwmenlucW1wX3Jlc2V0IFpZTlFNUF9SRVNFVF9V
U0IxX0hJQkVSUkVTRVQ+LA0KPiBAQCAtODUyLDYgKzg1MSw3IEBAIGR3YzNfMTogdXNiQGZlMzAw
MDAwIHsNCj4gIAkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiAgCQkJCWludGVycnVw
dC1uYW1lcyA9ICJkd2NfdXNiMyIsICJvdGciOw0KPiAgCQkJCWludGVycnVwdHMgPSA8MCA3MCA0
PiwgPDAgNzQgND47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAiYnVzX2Vhcmx5IiwgInJlZiI7DQo+
ICAJCQkJI3N0cmVhbS1pZC1jZWxscyA9IDwxPjsNCj4gIAkJCQlpb21tdXMgPSA8JnNtbXUgMHg4
NjE+Ow0KPiAgCQkJCXNucHMscXVpcmstZnJhbWUtbGVuZ3RoLWFkanVzdG1lbnQgPSA8MHgyMD47
DQoNClRlc3RlZCBhbmQgd29ya2luZyBvbiBaeW5xTVAuDQoNClJldmlld2VkLWJ5OiBSb2JlcnQg
SGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4NClRlc3RlZC1ieTogUm9iZXJ0IEhh
bmNvY2sgPHJvYmVydC5oYW5jb2NrQGNhbGlhbi5jb20+DQoNCg==
