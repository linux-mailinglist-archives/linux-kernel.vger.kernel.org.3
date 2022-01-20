Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6E4952A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377139AbiATQyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:54:10 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:53183 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377103AbiATQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:54:03 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20KBm6XF009919;
        Thu, 20 Jan 2022 11:53:46 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2054.outbound.protection.outlook.com [104.47.61.54])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dpmt68nns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 11:53:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmpwmXBb1edABuJ5rvAdju5FcJW8Kuzl545Ej7YoMC81amJC/Ad8Y/ghxyST0BLb5YpQBsReu/SP9DFIu0P5S1r99M3+JOJn2YOJYQqIxbGQsACcc8DJB7W4P94e59nTlq+d13xxhznozG7x1DyFvrzb4ZN2DUvcpiT46ViGKAec3RpzCPSpZlf+u6cLFykYlTROmoQOgVcSgIJPadE1WdGTwc0vZPGJ57bYBfeFE5HDgnBH6dDaKZ1XMyP3vkpYgOktknlkEABbNDkP5j8HZcgQx7LxbNfwQcBsUTCxn22nhxkprgNO5kZaJWY6y8xxqKtYxONn0uGFTpxvzZ9RWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csx7twV20JsPVhz8pdKFiICvwrrdxEJDz3MOrycvqWA=;
 b=byiansmTUmcuS8UzBZOhDT2nrLeAeBkNsvmgjVGKqcrdOFdHxQG8RTxVgP+fBdpEr/wkY6NZWk5NbYWcPhDaB93sc8A6p4TX1Be0A99xk49U1Dcg9alrFfbI+cKajI/JKK0Xe7Lk1ZINrosT0FkeZLOmzNH7rpXghYC+CNCC9CWvZhBq7cn86Geyuxf/53PVamxQb0b0YNc9L/JMQD4AT1J9FdiK/Oj9kDcury7alEOHGwQneUDafaQjJPSNVXZaNhLJ00bHYOmqRalUuhP4tpG1u4FVQhv0Ip+m9fMnyXnRoW5cf/aWC/udlCE5HeCbTMUqQqXTGNgBpKhuK54wRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csx7twV20JsPVhz8pdKFiICvwrrdxEJDz3MOrycvqWA=;
 b=phhaKQQsD/Nn+V1zmmfv6qogrC9x+P6MBAl176bM6Pivyvx4MnXpma7fAO+vlM+/UQ+vv1Mh53Ssxii5rqO8d9S/5KoTWefbIOkRL+0K/9yhCOswcwxVvKk1IDQNbYxV3XtUqHHq6D6nIUdUsZw6O7AuSyl+5v3kZ3+ycMfXVdk=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQXPR01MB5705.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 16:53:44 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 16:53:44 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
Subject: Re: [PATCH v2 3/7] usb: dwc3: Calculate REFCLKPER based on reference
 clock
Thread-Topic: [PATCH v2 3/7] usb: dwc3: Calculate REFCLKPER based on reference
 clock
Thread-Index: AQHYDMsA+kITVWE64kukzklaZJaBGqxsIvqA
Date:   Thu, 20 Jan 2022 16:53:44 +0000
Message-ID: <17e8db4e5ebfdf0e8a5698471dc8418d54229e70.camel@calian.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
         <20220119002438.106079-4-sean.anderson@seco.com>
In-Reply-To: <20220119002438.106079-4-sean.anderson@seco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77e0915f-ffba-45f7-0062-08d9dc356b61
x-ms-traffictypediagnostic: YQXPR01MB5705:EE_
x-microsoft-antispam-prvs: <YQXPR01MB57051EBDDC6E73185FD2179EEC5A9@YQXPR01MB5705.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwcGG7eytSngTc+rlCdbnj20bdwweVBYnKUXBGfVVv2GROk2+N/QI5OUW4qnS8QJ+lmiFhZ5toOpvNEkcDuc4r+ogXMJ/2Gt5dGu4/7NVjAgfvT1CGhZykBVxgrwNzyGiJsnrfodQ1g/ojWMSWj/hnkfGt3f89FzahSInWwWoCgn1dElrLHGaaTOkOHqb4gKaE9b1IWt7gs+IdFL542HBwE2de1iD32L5ArrCSZaffCF/Vca3G0OIvlxFLUf1SRGYEkIzVuYXXPiz4FSUlMJ1yAaIVcGgMJUyVjaX7qk19OHhXJGpogB/EQapFJA+FjHMICDrkm4nPTlfwZUlCeaaX9rVBfTVdnvzAvGOUy5Lh+2OURz+beq9JXRHpIdPv8c569pQPcNBqKh4PiHdJNambtM0xxfmY9JlpPr4fKsS/NQqmwh0sYEUZYCFR/ZSyoPsQdXxSvL/WLeERR/izdTnrioWBUPToIyg6uRx3ArlGGAG+EoN/Sc3Bq8NPPGqgc9/LvGflAweAK5JqDicISBEEd5m/EU8GrWqnTzm2QxRt2XcHTrLqLBeaGCFMxQ8e5RC3QOgox0736sf5K1OHi3gQh2ACbzwASWLJsXqWnCbglql8PifennChGiKHwB5SRxdVTpMLbcZLKz0wpQMCt3DOIkQ+dOfpDYDSzMJkSRYOFcQAr7QDpBW24XnEw0lI1ReCXw1u/h1Xm9BFE3m74HUNz8akR31mrXTBR6LOMURWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(26005)(66446008)(38070700005)(66946007)(83380400001)(2616005)(91956017)(8936002)(76116006)(6506007)(5660300002)(110136005)(64756008)(66556008)(6486002)(36756003)(86362001)(186003)(4326008)(71200400001)(2906002)(8676002)(6512007)(508600001)(38100700002)(316002)(66476007)(122000001)(54906003)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVFEMHdkeFQ4OVM2cFFHeFUwdmp0ZWdTYUtxbVdRK1JuQ20wUHZZbmVTQzli?=
 =?utf-8?B?MWQzMS9VcHVrVjhMK0xSeFZ2ZkJKeGNHcjhxNTJ5Yzd5NDhIY0xJeFNGMm0w?=
 =?utf-8?B?eHIrTlFGYVVWaUZKZFFkcFN6cHYxZDZhbTBnNkhaYy9xN3hlUXlZVWNCdEIz?=
 =?utf-8?B?WlBFSFZIcVVCVlNmd28rbXF5M3ZiaWRXS0pMOWpOSEl0V0hVckE1Vngwczdo?=
 =?utf-8?B?bDE4SndCaDJGakdCcWZtMzBqZ3JOSE5mNXhjdEJHSHh2dDVSNDBiaE1PejMr?=
 =?utf-8?B?SGVhMzNqb0hRWDJiM1JjVmZpakJzRTRVSlpmOE5xbUdpakE3UnArUWlGM2x5?=
 =?utf-8?B?T0dxV1kwM0liN0RmTnBuQTNKRjdIODl1U0FUOXpqSWMvU2tMSFVDbjBvdEk3?=
 =?utf-8?B?UmlpaGMyQ3RXdGZvdWdLZCtUdmh6WnBsREpwcFNvMWxQNnpzYjVoSC9JdjB1?=
 =?utf-8?B?VHNsZTZVNkQ0c0xsS3doK2tvM1lVclMrVHZYRUM5dmtRbXV4WUhucDBTN29U?=
 =?utf-8?B?dUxhN1dXUU0vTFUzSFU2Sng1VWNoVTBiVi9CM0xvNkxac2NZbzVXdUdwRXpP?=
 =?utf-8?B?Y0swa29JMGd3K3E2TDU3aUdNVjB0VnQrMlJtMXkvNzNyd3J2QS9wSHVRdlMv?=
 =?utf-8?B?SndIcndWU2taRHQ5RW5zQ2xHOEsvMVN2dVFoWHc0VXlGcXJPSWs2N0tMbkpv?=
 =?utf-8?B?TjBXMUlId0dpellZblFCcEEzaGNwMVRPYTJEV2d2NHlhdjlmU3JjeGdwZ3dq?=
 =?utf-8?B?dmZlcnlFVTI4MXVQTGhkSnMwR1lDSWFUL3ZQRjR6TXBhL2plcENOVmhJRW9K?=
 =?utf-8?B?dG1GN3BRdHQvcUZFSDl1QTZmRSsvQUJxYXhaSUw0ZlQ2MTJCdGIrK2xRb2Z4?=
 =?utf-8?B?SUJublRlZlp6OVlpL0FEUWRCYy9xY21qWnNmdEpKdVJJb1c3OXpnYk1LK1lF?=
 =?utf-8?B?aG9OR1BUVnh1Y0cxWXlZMUdzOHJVdUdxc1JWenlUODRVb2NjbFVjZFNtZmd5?=
 =?utf-8?B?MXd3YVNFQ2pwZVc2UitjdW1iaVdvNnpZS2xEazFnOU5qTTFEdzVQK3BXaFdX?=
 =?utf-8?B?cUtOUzBFZDY3dVBrRHpGdGlQbjAzb0ZVTVF6V1JTblVmTkJwWGVJRlJkL21N?=
 =?utf-8?B?cjgzUHN4d1lDandURnFhZ1lvcUFISkwreG5jL0dLOWx4dERpZDU5c1g1ckZO?=
 =?utf-8?B?UGVZeWNtdlBNb1V3NDF2d3J4eElOOFk0RW81SnpnS1FmY2tTejQ1TGUyMC8y?=
 =?utf-8?B?Ti9NblJXWjdXRmpFSDY0QVhUNS9STnpzUWMyT2hBdENiYWplL1B0Z1AvalJK?=
 =?utf-8?B?ZHZZM1l3SjVXVzdxbElDY2dDWDNzUTRvaVpIVGFHR1NLVlNYN2hjcVhtNEFJ?=
 =?utf-8?B?VFpWa25PVWYvU1NEb3BPeEtXMkhWK282NzRucWVTb094TUhEU1lCZzlnN3da?=
 =?utf-8?B?TzN5MFM4eFpiU04zQXg4b1NuYnl1b2JFS3c0VmJTUnR3SXc5SGFFQk1YM056?=
 =?utf-8?B?bmgyYzF6RGtBUXgvUExMbDcyQzFkNnFhd2JIZDNvZStjN2RVcFRSVzB3Rk0z?=
 =?utf-8?B?OE5kd3ZxclhWVkQyZTBxSmlwUlN6M1dCYU1yWVhiTzUrOGhFNVM2Tml5U05i?=
 =?utf-8?B?d2U2UGc3QklXLzdFK0UwUy83clM3Q1U5V2ZIb1RyNFBFbTU4ajNIZVFuRWox?=
 =?utf-8?B?MXBLWEdETjJ1cHhyVXRIVzFlY0x2L0dQcHU3cFdEeXQ4MGtPL094R1NBT2F4?=
 =?utf-8?B?d3BqZ2ZHd0pNbXBnRnUydjdCN2FoVHNwMHpZRitoOUNlMHN0QnpJWUc5Mzhj?=
 =?utf-8?B?eGE1Q2dnbmtBejBsNk5CbndZalNPUENMUk5HdHF1VHFpNlJzSWNzYW01UE4r?=
 =?utf-8?B?WjdURFZMdkxEMHdiUXpkd1B4WHNCR0UvcHN1OXR6dCtuU3p2YjRjd0VXcExr?=
 =?utf-8?B?dGxaTEJPbFJqV1IvTnBaRUlCVzlsQjFldW9vV2M4U1RsVHZETmUrdUY1eHlD?=
 =?utf-8?B?UXBpOWpvLzk3YWhQZisyQmhBOWNKSzNsZkJ6S0kxVGZXV0pUMmNCamU2OWRl?=
 =?utf-8?B?K0FvbVRsV2VPSE1GMjljcTZGZk1sWXBnSDFDZk1aUmV6bmpvQ0txTHhEcC9E?=
 =?utf-8?B?UGVqeDhHdTZrLzAwcDBXby9yRHJ6WjNLNDZkaWVCbzVoU1NCTHRCVlNzWElo?=
 =?utf-8?B?cGtTcVRkWFFLL0o4VnBDK1JTZ1cwWlBkQkc5ekExcEIxWG5xd0dHNXRMSUlQ?=
 =?utf-8?Q?mHeufY6Ngo54lmTXGZExHVhzLJDM1EoCM5HfQTjJi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91791ED0BED65D43AF3BBA1C1F014D5A@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e0915f-ffba-45f7-0062-08d9dc356b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 16:53:44.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hlULZFNgLEiXaun46o2phHeCMet0IaYo5rgtf9b777/GyWj3BfDOtTOq1hQfXR5s1bFyAZM95nRrVK0IRkM57k63mVlyEFe+mW7OfJzquQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5705
X-Proofpoint-GUID: d9iNHPUUqnGWdLbC3CkWSMyJzAYePiPk
X-Proofpoint-ORIG-GUID: d9iNHPUUqnGWdLbC3CkWSMyJzAYePiPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTE4IGF0IDE5OjI0IC0wNTAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0K
PiBJbnN0ZWFkIG9mIHVzaW5nIGEgc3BlY2lhbCBwcm9wZXJ0eSB0byBkZXRlcm1pbmUgdGhlIHJl
ZmVyZW5jZSBjbG9jaw0KPiBwZXJpb2QsIHVzZSB0aGUgcmF0ZSBvZiB0aGUgcmVmZXJlbmNlIGNs
b2NrLiBXaGVuIHdlIGhhdmUgYSBsZWdhY3kNCj4gc25wcyxyZWYtY2xvY2stcGVyaW9kLW5zIHBy
b3BlcnR5IGFuZCBubyByZWZlcmVuY2UgY2xvY2ssIHVzZSBpdA0KPiBpbnN0ZWFkLiBGcmFjdGlv
bmFsIGNsb2NrcyBhcmUgbm90IGN1cnJlbnRseSBzdXBwb3J0ZWQsIGFuZCB3aWxsIGJlDQo+IGRl
YWx0IHdpdGggaW4gdGhlIG5leHQgY29tbWl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBB
bmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBzZWNvLmNvbT4NCj4gLS0tDQo+IA0KPiAobm8gY2hhbmdl
cyBzaW5jZSB2MSkNCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDEzICsrKysrKysr
KysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggNjk5YWI5YWJkYzQ3Li41MjE0ZGFjZWRhODYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+IEBAIC0zNDgsMTMgKzM0OCwyMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2ZyYW1l
X2xlbmd0aF9hZGp1c3RtZW50KHN0cnVjdCBkd2MzDQo+ICpkd2MpDQo+ICBzdGF0aWMgdm9pZCBk
d2MzX3JlZl9jbGtfcGVyaW9kKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJdTMyIHJlZzsN
Cj4gKwl1bnNpZ25lZCBsb25nIHJhdGUsIHBlcmlvZDsNCj4gIA0KPiAtCWlmIChkd2MtPnJlZl9j
bGtfcGVyID09IDApDQo+ICsJaWYgKGR3Yy0+cmVmX2Nsaykgew0KPiArCQlyYXRlID0gY2xrX2dl
dF9yYXRlKGR3Yy0+cmVmX2Nsayk7DQo+ICsJCWlmICghcmF0ZSkNCj4gKwkJCXJldHVybjsNCj4g
KwkJcGVyaW9kID0gTlNFQ19QRVJfU0VDIC8gcmF0ZTsNCj4gKwl9IGVsc2UgaWYgKGR3Yy0+cmVm
X2Nsa19wZXIpIHsNCj4gKwkJcGVyaW9kID0gZHdjLT5yZWZfY2xrX3BlcjsNCj4gKwl9IGVsc2Ug
ew0KPiAgCQlyZXR1cm47DQo+ICsJfQ0KPiAgDQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJl
Z3MsIERXQzNfR1VDVEwpOw0KPiAgCXJlZyAmPSB+RFdDM19HVUNUTF9SRUZDTEtQRVJfTUFTSzsN
Cj4gLQlyZWcgfD0gIEZJRUxEX1BSRVAoRFdDM19HVUNUTF9SRUZDTEtQRVJfTUFTSywgZHdjLT5y
ZWZfY2xrX3Blcik7DQo+ICsJcmVnIHw9ICBGSUVMRF9QUkVQKERXQzNfR1VDVExfUkVGQ0xLUEVS
X01BU0ssIHBlcmlvZCk7DQo+ICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVQ1RMLCBy
ZWcpOw0KPiAgfQ0KPiAgDQoNCkxvb2tzIGdvb2QgaGVyZSBvbiBhIFp5bnFNUCBib2FyZC4NCg0K
UmV2aWV3ZWQtYnk6IFJvYmVydCBIYW5jb2NrIDxyb2JlcnQuaGFuY29ja0BjYWxpYW4uY29tPg0K
VGVzdGVkLWJ5OiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4NCg==
