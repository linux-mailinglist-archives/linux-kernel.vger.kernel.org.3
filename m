Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2949348711A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbiAGDOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:14:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35506 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344803AbiAGDOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:14:18 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2072tD5N029123;
        Fri, 7 Jan 2022 03:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Uf7+b2CjRLyWuS8pHB8vTgemeldFIf6mKpeJoX0+kr8=;
 b=XDIaNU4bIbfjZglN5UY9qYShkRl+j2Y+ooDOSAIvWNNBBifKqRYMlGXntrqU1Mr+WsJi
 KCnLITnuDcdxPPmseuWV8l6Vp3UaAEQ5+z7ZKCWzJb9XndBtJSr0TOcw5lakAg+RJjY4
 txHurh+n5+Pkg4V3WTwCxqAEjmHafZbB3p6UN4m0GHhbfBxotFi5USKuBkmTytDaSqdI
 cdKCW/F3hD1SjA6IUGA6CiD8uAvLWEsw0bGMjYjkBoUeCo6dNBUbrhOVr7QaqzWXng5Y
 JYKAc/r+idGTDNT6uu1ld7W+tQHB1mRE82hk+tMgYNQ/qkiUVEBc17lUXJN9hfKqO8eT 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4va108h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 03:14:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20735Ocp030606;
        Fri, 7 Jan 2022 03:14:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3020.oracle.com with ESMTP id 3de4vmwwjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 03:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWxB9Qot6XaQIjsdc2SqiaJJnR+JZpcYRCkTI3TYpy2ICKwRB2wCdSyjBMj+itlEzwfcVK6uFNbxGKnFXaE5nABgtHRt0YmrVeiolJcb4+rpgpidJr2K9Ei+LlIIXRGapSG00hRQo76v+J2dcEP7nkqFOt6BtCZUYFb1iVZabWUAJHhkDFNdPPd3c9+tR5mBRt+hmBpNRkN+cCd/atXB1HqWN5+q0Pb5pzuTzPT3uCvF05eJqJC/OTlSJdac0WUY3zGDrnZ+8rGw0kGFmUAx4DR6YatFiuJxk7427cWB0fdM87o3QxDFXDYtQR7kfx3yQ2egK5gphRy3BhWvMZC6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uf7+b2CjRLyWuS8pHB8vTgemeldFIf6mKpeJoX0+kr8=;
 b=MhOFcCRR1gpWfgXBtKdkYtg4xQslHW2ZyT3zCSqDhQVC10hz2ekvhzZWe/MA20MugF5scZNfljiE1wFN7ZcKNTtr4QATMUYHStKkOhzaQEMCL5arJJxKVCBV8ugQm/ya6Jrto4QvHsAOw04XD41YujM/3QKMJ8QWKKXWjtg8K7lYhuJfGpj0d0to3Excx4dxbGzeD5jhb/Mbv1uG9CmnUJtCB4GSK0t4UwOnyw1E77roDa0+xYk215fzwfapsQGh14YptG/Gx2k0ajzYHdAw0ZN1IFwR1LcpzCcwdmP1xzemhTCjEn0AV+OYLu/3fGyFgXGu1EpFpA15rlE7BZoevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf7+b2CjRLyWuS8pHB8vTgemeldFIf6mKpeJoX0+kr8=;
 b=K/aPImi7YbtoUFYSmjHxQDw811HKKCKsaJdU1dIWCxDpNYWXD6pBreTPRuHQMZ85pOyaB+YncUqSAV0YQ31iiu7y4RieRpEE2omev8/40yioypfTo+eiY0w6YzyECjnueiJ4ssJNwL9kFzVsZKSi3VIYm61vcqjKR/BKp+CPENE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5017.namprd10.prod.outlook.com (2603:10b6:610:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 03:13:58 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 03:13:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: state of the nfsd tree
Thread-Topic: linux-next: state of the nfsd tree
Thread-Index: AQHYA3DMg5Vkarwfrke/OSz63eLMCaxW3REAgAAFRqw=
Date:   Fri, 7 Jan 2022 03:13:58 +0000
Message-ID: <8F605496-7EB6-42A5-8C44-0A541EB2E402@oracle.com>
References: <20220107134621.7814487b@canb.auug.org.au>
 <20220107025506.GA16601@fieldses.org>
In-Reply-To: <20220107025506.GA16601@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99f8038d-19f1-42f2-e5ec-08d9d18bbf38
x-ms-traffictypediagnostic: CH0PR10MB5017:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5017C2B52F0913F7F600A5FA934D9@CH0PR10MB5017.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0tUjszb7V2YSTzkb5LCCOQK7t6yMqyk8ZL39pLTnY2mV9d89no++xvOItEFhbSFRAx9ljSIx8WpQuYmd1/ClKcwGoS0zVUfAyqCNQXatUDv3utiNMnemmK7cMk8fMr91tNd9osUxuWxrTH2qD8L2ioiDbCIvFFHZbNx7ppBQ5X2FTRsUK+fPNvugLKG2rgYr5tODZhXMgIuy0++C7V/0NEQ/LYOQoU+3yLJKJ+Ey91Yp/YHX5jZH5emrrMhPKdky/EKBBZJZDGLBLPl6/aRmcLtrROjlJMyh4cbPD9ce3RNCWPmAp3Yx12VozBkBzfQVs1dDXxrUuCCSDoArE4QSRGoWY/HbLhi8rxG8raUEWRcLpY60N+8jujlcQ57XP7YUuz19q9BOdAP6LQeNmZlTimA8cgD4MCvi5yFVjPugzCLj3n+01oSEdna3fPETed2of691sWgrlxfQACzq7zsVv4vKdDi/pKsJZSxgFvfic7uN9+vRK/BDfW4l84VdWww1Z3LIg2Bh9K5ucd/SrK2W5A7IpiP7eed/mkBuv2BpfbgDAQzGNsUpH53+8AXHOsnbRCXc5n6vozur3qEa4xPvfB9tBSh6vy/wN5gl0Woq6dqsFDdl+rv/kTj5EzCAUphHPtvAmzqMFMl+hic7g3yUvQ+aHTrLb2K7oEoeV/QHFzVGFiBw9Rp6Lw7DmS0ef4aDSHREp/qK0qmJWonzNXQKMrJbE6K1/9N94kSlBgSQSCVOSqSQ7x5l6ZYvpnj4lRgB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66446008)(66476007)(4744005)(64756008)(66556008)(76116006)(4326008)(66946007)(38100700002)(122000001)(38070700005)(33656002)(5660300002)(316002)(36756003)(6506007)(83380400001)(26005)(54906003)(6916009)(8676002)(53546011)(8936002)(2906002)(6512007)(508600001)(2616005)(6486002)(186003)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czRjQWs2U0tLRkFvWjhockovTXI1V0JpQ0pGZlNTOFdVRXVlTzZTRzVtZTRT?=
 =?utf-8?B?Uis4Z1BSTzdLYVRZbG9KbVJ3dk4vQ0ZNTTRmaEV6ZlRYR21PcDl6TTZoK0cz?=
 =?utf-8?B?Ynl2M2ZMTkw2b0JPcGtTTTd6dFR0eGVkMWwvRWthSzF1bnFwL1lMZERBa3Zx?=
 =?utf-8?B?MlJURVYycVB5NEdSWU1hcUZwUDhPZUY5czlCY3dPc29KRVdvdkZLUTExK2c2?=
 =?utf-8?B?T1VlME5qSkw5Mm80VktaYVJVUmQ3YnFmalNvU0gxUzNacTVlN1R6K2R1ai9B?=
 =?utf-8?B?cXN3V3QwRk9HcGN1b29QQ3lpSE5nYlBJRk53QVRMaStjS1RocWJqRUJDQkV2?=
 =?utf-8?B?NENDbzFXMlQvWW1SL3BUTml3dG8xWnlINjNJQ3NUQ0F3eWNCd05MSEtYWjZD?=
 =?utf-8?B?a0l3VDFocGt3THlFYWk5dU80ZTZLTm4zS08rd2gyeXRrL1RMd3RnTzVhVFZW?=
 =?utf-8?B?cDBoV2NZRXFOL25LSUxFYjVEOXFhSDdaWkNnSk54ZEp2alFaWUU2NWgvVzVD?=
 =?utf-8?B?aHNXbGdYak9QNFZtV3hvdGIwOHZHNXlBbVBTam5FVHBOL0k3Y2RvSlh5QmRW?=
 =?utf-8?B?S2ZSOEFaUUgvc0NzdE53Q0pKbzdCek9KcDMvZHEwY0czUXc5NXlZMXdXMXR4?=
 =?utf-8?B?Q21ocnBHb0w3d2pHaXJTUE5vdjVwYnp3VEVlVFlTZEVjMElBYXVKTWZ3dUhY?=
 =?utf-8?B?RDNMSXFZWWRiU3ZGK25UNWExZHhMY0R4aVJKQWxoa1FrTzM5MWY5S0FLeXBU?=
 =?utf-8?B?SVhkZU5mQWw3TmN2ZTB6YjJIczZVUHdZdXl5SWpPS1Rtd2o3cDBzQm9WN2VK?=
 =?utf-8?B?bnRwWjBYU21sNDJnQ0FnYjdmZ05hZ2VldnJXK0hQY2hnOU53R2cwL2hYTmps?=
 =?utf-8?B?eUdDaW4vWk9WclBVV3hoS01lZ2xOWEpQdHNxR1pqVEtVVHJSMllRWGVGaE5a?=
 =?utf-8?B?V0NwYkROOGkrQVdYMEpLY2ZSOTROd2p3T0RrWUxYUm5tQjJJbjlnbWJpQWQy?=
 =?utf-8?B?WWs2c3BJb08zVXpkVzhBbnBFZXpsc3lWRmxmajRWMVk4MGd5bXZ6QmxXMFBh?=
 =?utf-8?B?eXVlMmtiYk5vTlFhaExVWEVQa1grWkVhMDJ4Vm9CMTZqOEU5eElZTWhhTkVq?=
 =?utf-8?B?ZUJJcXU3NTZ2UmZDb1Uyekwxdit1RjVrZWV1Szk2Y2htM1Ewc0k0Y01oUWRH?=
 =?utf-8?B?K1pxU3RVeVRzOElwUHpxZU5obk44bnd5TTR5dzBmZDA5V0pQdzJIY21YcTc3?=
 =?utf-8?B?ajZFZWtWTGd2TU9SYklOVXV4TkRaL1lqTGt2R3E4YXYwL1ZVZXd1Ry9rSXU2?=
 =?utf-8?B?cGRmSEZXZ294YklpdGRCaThoM3RmZTlMVzdGdzluTFA2M1RUNTZNTnYxZWw4?=
 =?utf-8?B?eERIWkgxTHVZWmRtaHl5NkJXY09KeFk3YWdhZ3VESmM4Z1AxTXJRNzlzOXNh?=
 =?utf-8?B?Rlh6SzIwQzBLV0VHcTZLRWxjYThWazEvZ21DeGE1ZVdHN3hqVm1iL0JJeWlx?=
 =?utf-8?B?Ly90eUJRUzJkak95VmFUVFNHaUhNb0xGSXo2ODdGTGF6MVJ2M1RQVEcydFV3?=
 =?utf-8?B?QmtYc3owREJ2UFVkVWdzemxLQnJpMmd4YTQ2UTdxRUJNSitTaTR1U1FTbDhB?=
 =?utf-8?B?NmpXWUpvbjZvRmxobDM3c1Y3VjE3Z05jdUtHYUZkczhTMHh5MXJobkNXM3lU?=
 =?utf-8?B?UHFLUm0zS3ZqOVo0ditpN3Y4K1UvSHI2RjNDbHhXUSt6STh3OUV2aW0xNFg5?=
 =?utf-8?B?U003Vkw2c0FQVDF5cm9nSy9EUDdVRzA5NzFvV2kwbVUxeXcvdTl0NE9yc3VB?=
 =?utf-8?B?dDJPTExpSmYyOUVra3NvZWJUM0F1cnBBbllTenRPeDRERnl3KzBuckJqa0lW?=
 =?utf-8?B?Mk4rVTdaN0hENG9IVGlVY3U1dE9yRTg1UE1xMUhIWUh2c1h5ZUhiTGtlR2JL?=
 =?utf-8?B?NXZ4T2VoTk9mR3p4VW5tTFRjcEUyMElzU3Q2VktiVytkbWdMUkdoWW96eUMr?=
 =?utf-8?B?V3U0dVhmbCtQd1BwNXh2K1pNZUdvZ2RhYmN3QkZWM3ltV0x4c2c1THp6Z0J5?=
 =?utf-8?B?cXNOODl4Y3MwNi9qNlRGSFo3dUpyckpQcTFaNlNlczY4QmZoaGVmTjNTVnI5?=
 =?utf-8?B?cTFEYXNVTU9lMTdRbG9xM2c3OC9yZ0dkS29sT1gwYW96MFpRM2h5NFJ4V3Rq?=
 =?utf-8?Q?jutyRXHTvKfxSpwlJc+1qjs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f8038d-19f1-42f2-e5ec-08d9d18bbf38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 03:13:58.7847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuBZbgmG/CYVCIe1FhWiOWwBdvKdXMxcAHw4L+MjYZlQ1x4QucGCXo/YrPVQLqi8qo30yD9GrV3D6pwamED+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5017
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=822 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070019
X-Proofpoint-ORIG-GUID: fbI650xIpxi5aX6kp3TJTAxrNCLGyCYE
X-Proofpoint-GUID: fbI650xIpxi5aX6kp3TJTAxrNCLGyCYE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEphbiA2LCAyMDIyLCBhdCA5OjU1IFBNLCBKLiBCcnVjZSBGaWVsZHMgPGJmaWVsZHNA
ZmllbGRzZXMub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIEZyaSwgSmFuIDA3LCAyMDIyIGF0IDAx
OjQ2OjIxUE0gKzExMDAsIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+PiBIaSBhbGwsDQo+PiAN
Cj4+IEkgbm90aWNlZCBjb21taXQNCj4+IA0KPj4gIGE3MWJhZWU5OTJjNiAoIk1BSU5UQUlORVJT
OiByZW1vdmUgYmZpZWxkcyIpDQo+PiANCj4+IGluIHRoZSBjZWwgdHJlZSBhbmQgd2FzIHNvbmRl
cmluZyBpZiBJIHNodWxkIHJlbW92ZSB0aGUgbmZzZCB0cmVlDQo+PiAoZ2l0Oi8vZ2l0LmxpbnV4
LW5mcy5vcmcvfmJmaWVsZHMvbGludXguZ2l0I25mc2QtbmV4dCkgZnJvbSBsaW51eC1uZXh0Lg0K
PiANCj4gU291bmRzIGxpa2UgYSBnb29kIGlkZWEgdG8gbWUuDQo+IA0KPj4gTWF5YmUgSSBzb3Vs
ZCByZW5hbWUgdGhlIGNlbCB0cmVlDQo+PiAoZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2NlbC9saW51eCNmb3ItbmV4dCkNCj4+IHRvIGJlIHRoZSBuZnNkIHRy
ZWVhcyB3ZWxsPw0KPiANCj4gUHJvYmFibHkgc28uDQoNCkJvdGggc291bmQgT0sgdG8gbWUgdG9v
Lg0KDQo=
