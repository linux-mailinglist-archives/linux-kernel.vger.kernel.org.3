Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E84968D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiAVAke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:40:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44554 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbiAVAkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:40:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LKHGrn025695;
        Sat, 22 Jan 2022 00:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aokXGo5XnZ2IYk6UBlJxCmww8UVcYQowTFzliQa2Olc=;
 b=VuROfE827RQZ7UVl0gKpKfAGjUFy3XjwRWaG/9FSi3dSVDiCotV1aykIPoKFK6y8+Mp+
 aUN+7EcDovBacFtr6LwCNUwVDF90Xz1TlE3msJv9tKye/mW2TrF8V9W5mxlwl1XM76JL
 rUu6nY8sD/NHlTBD2YSvklR1avOFk4irf2widPB5qX+p8d6NiU/BSu8T5nbXyl6FC8ud
 22qMvlXR+08qee+lHUh6DRTGJrQZcZRLN+VlFgdcWjqTWhghURmM4VnH755mAxKtrTf3
 gQqZJxM1GUTqNKZg7cjGQYKwZWdCRGwxT+dGiUG11KHsqoq3ghZpufO8oCKb4fJi/rJx ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhyc31wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 00:40:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20M0Z5qM026376;
        Sat, 22 Jan 2022 00:40:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3030.oracle.com with ESMTP id 3dqj06rjb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 00:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl2s/osWrUgWrye66VI2Wnf5jBHTQJ7tqQoTHwcR4GK9rRmJZcfyJe8/nLk9XrJpiaIprMFb0deT9NWCmNhQ5GXS5CxGBCkpvDj1RPl00Hhzlq071qC9j7juLLLaQOfBxEmQWOOkatuWyyQIVY6C78orddELztRIhgU97KhoTDe17lq2DCynRb5kQqQmNE6B0VvkAJzBt3dCHiWhWbs0/f9dDOxs/oTeAy6hUsRiMrmcsyr+eJQAF4bXGSYdMNLq3L1On162CJcqa+AQGpYPZFA9OU3XurREDXlK5X9EukthEfccNjVtdOnz5Fdd00n4fmWtQ2//Df8WjAJV02RPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aokXGo5XnZ2IYk6UBlJxCmww8UVcYQowTFzliQa2Olc=;
 b=cSQuyyh6JbDKf+IIyjqn95jz51y7izF/Qo6DiWSzpOnXbQTYslulopEgPpGeZzTZhUUTShhwTCi+422sVL3Fvtx567HhKXteP4MyFkdZ623UMzT0gElKkqy4RbzOmD+Fg2GeKabaSpO+CBdPUP1DiVBUxRLsrpUQWrQemfNKN9GhWnhXyfnIF1iqBVqzivFjSv8E1G5DDp1q53k1ZT4lLzRZ1fd3n6FWQ+MIx6/f8O+NKSGGMVttQMcLxSlhgDVs9W6Aq6JGXq8gdXLKyOWdSRys785pmt1PExYgITAJK529/Dw6uySVAF2PGJU85lqta+zHZV1sLrfinM71ltLmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aokXGo5XnZ2IYk6UBlJxCmww8UVcYQowTFzliQa2Olc=;
 b=pG8bSTMJQ5K2DGb8sngVErMONKoutMvdTWSxzOAzi5r8bukW5w4tGmO3Ty0lqzPH/aYJLsla3xD2AgRD4YF6y8IsFjp8D5NCzxgSZdeJikxFObqCubj73+niru1q2JdQID4l09/qIDZlP8k+Y7fvloxHCKtx73hR+kgDaaUo84I=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MN2PR10MB3774.namprd10.prod.outlook.com (2603:10b6:208:1bb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 00:40:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 00:40:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "bp@alien8.de >> Borislav Petkov" <bp@alien8.de>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Phantom PMEM poison issue
Thread-Topic: Phantom PMEM poison issue
Thread-Index: AQHYDydWdWgzCdPlXk6vesHxVkUTIKxuMvGA
Date:   Sat, 22 Jan 2022 00:40:18 +0000
Message-ID: <0aab10e0-6f1d-d67b-8aef-7e3d18e26544@oracle.com>
References: <1737f707-7743-4898-37d4-03098d7aaa57@oracle.com>
In-Reply-To: <1737f707-7743-4898-37d4-03098d7aaa57@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a3d6d4-5450-4b3d-3a7a-08d9dd3fc389
x-ms-traffictypediagnostic: MN2PR10MB3774:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3774D7501C781FCB12396ECEF35C9@MN2PR10MB3774.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fB1cTH2bXUjhZ/hWIkl9A6r+Jhu4An6xd338UeR/Yp6bf/xHdQ2XkJN0xzda3H0uoDiQGZSUd7KF9VbPIRQiWi7912pS7/c+P5HL3Uws2UxAuoq7krsZEdcVbxxkSkEmZb1O67+gOzvgWGxtHnjsbJMWxwB7usvzvfigrQJsYrKHcXoHExlDXT81bodOSQk1Dtura/xaFAyq05n17wBQQA5tLcwqijU7uV2a2b7McJKu6ULVfPggWx3tgChrTWtI/oG85WhkkUT94lJZiSuYVzZrp9iazLHwu5hPadNFboY/qxv2CyFfhYIX4cA+6UhDAGmV/LJdYTRYbVBW6lYSVHB9BB+m50EtjcInOG/4niJq8fU9me0lBWpLFKb7s7q78k2mwZieHJJEMQ54ZiVH8PRIek2YL7FZzcDMRfuZF4SzjRqjo8s63+5OCGz9WH1v+QOrnFfDzgPa2sGrg/K0CaEVrhenwng7V3cr73aASIa353MndW4NohyRc5cNTRCLx0eZaO2rO9mDlU83/f2AkHv2LJ3NJejMt8vqOZh1Nq6tyUv6DXavRLpywRgqUa0aZxf7XaQUgttPXTcQjKEaeqxfRhcU/USZ+w3lJ9fQ3CqZ92nygbcBcsxImP+GPJ56SDCkIw811zqieh3WD77PWyYvjLzL+xe2/z2sHt1ILLlnadU6UUyq7gOlZhVgVsWw681PKacLBPZLDUS1DF+h17Ew7DrDB9QMMV5NbqluicEJdOjMXVHQaVCoMI3vY5NsPDxlgdV2/U19N+QNVJGMHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(76116006)(66556008)(64756008)(66946007)(53546011)(66446008)(83380400001)(66476007)(122000001)(5660300002)(31696002)(3480700007)(38070700005)(44832011)(54906003)(110136005)(2616005)(6512007)(71200400001)(26005)(186003)(36756003)(19627235002)(8936002)(8676002)(31686004)(38100700002)(86362001)(4326008)(316002)(6506007)(2906002)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0MrWWMyZHdpTGY0Q3NRTjhaaHFWUXVsbnViT0dqQVZUUDQvZ09nc2F1OWFv?=
 =?utf-8?B?OVVtOUlITkVoTVV6YjJSZWRLTU9mZ1Z6dUhOY2p4VDgyNW42SzVJdXJNc0NG?=
 =?utf-8?B?eDdGSmdOWklQNVZSWWlUUGtpM3hWTkx2alVuV2Y0OSs3bytNZERuYi91Z2gw?=
 =?utf-8?B?OW1DUmtocGxhU0kvOFNjT21CRE5jQ2RVbTdlUkhINWpwSkxRTjhFNnozV2l6?=
 =?utf-8?B?NTBITEtwekRLSitoZ2xiMlp6bHIyQ1ZCaENRN0ZBZlhLKy9LZGh6eG8vZGM0?=
 =?utf-8?B?V1hxRU0xdHY3VGRyYXZaSGRtOHZ3R3Y2VWUxQ3FuL1dpOFI0U3VWZHpyYXJE?=
 =?utf-8?B?ZmdrZWZoanB3ZXBFaXhZRk01bjhidG5wNDJaVGFWZHFqaUkwZkpXQSt4YjIx?=
 =?utf-8?B?ZGs4NlBxVVZ2VXFnTFpVaGtVL0JyZFp6VGRwL290YlNGa1lyOTNPck96ZTdG?=
 =?utf-8?B?VTJROUJBaVZXbXVvUkJDdlk3elpHeDVOTlNLdWVKbjkvc2FmdWxUYlRnRzhC?=
 =?utf-8?B?Ulg3NEgxMm55UmNrQWtEb1ZYMlUvVnhBU0lyeEVYZkd6UnVmWHk4Mmw1WDhm?=
 =?utf-8?B?U1lKUno4U21tazdNQ3NNamMzdkNKbW1laVJQenVZWWFxTVFBRDFqNENWK0lV?=
 =?utf-8?B?bjNBc3N4WUxjMkg3ZHN2UlUyc1IwNDB6RVJyQm1TMzRPWUdaOWpSQS9EOGtt?=
 =?utf-8?B?QzlHRWtZYmVaOW5qTHdCUnEvZzFMS2Vzc29JYjRkb3Bkd0tzS2NnNGQySjJR?=
 =?utf-8?B?MjJ5Z0pXRmRrRTZkZXViVWZJRlBBczRmZXdhMy9KK1doQm12NlorT0NYZFlO?=
 =?utf-8?B?a29JclRSS1NMSFJzcEpqQnhXT1J3NXlOS1ZlS1B3d3hkTDhndnI2aFoyVFc4?=
 =?utf-8?B?NHcySzlycHU4bnRNdmNQanRxSS9BRDVTODBEbG5kR0xVTUVqTVFKVmFwQkc5?=
 =?utf-8?B?cDR4U3I1dTg0SGJjbXQ4QkdYNzFlZXNjOXZHTU5BaWhhSHlmVENaL1JuTC82?=
 =?utf-8?B?SUpQVGVWNTVaOUkxVEMydmE5My9kaW9CbER0ZzlxM3dSWExsM3U4ejhqY2lV?=
 =?utf-8?B?TXdyWm5vSDRITW1wZHlWYmhwTnNQQ3Zycy9Uem8zMHVpVmd2cEtwWVc4VUtO?=
 =?utf-8?B?VHlNL01VNVVkZTZLbUovOXJTY3BVMEErT0F1eDNOaXJxa1owWjY3ZkR1ZnZ3?=
 =?utf-8?B?Z00vM05vYmV2YjJqaWR1TXJOcEpiSEt5UE90YVVLb1BXUG8zMlUrMXZuK3B6?=
 =?utf-8?B?M0s3VGI3dG42YTdvaU4wcmNkY0M0REUwcVZxZGJIaSswYnYwbGR1NWF5YmFI?=
 =?utf-8?B?SlRkdkFLTVpDbHVPdHdnRkVNZ0ZYY0o5NktqZmlRdnp1czJnaWZHRzFDSVNj?=
 =?utf-8?B?T3lwQjJzdlJwUEphZVBGSFJ2NTFuNWJ1S3pVVnYzKy8yU1lka202dU9PR0tL?=
 =?utf-8?B?TTVId2xXcVF5QUowWGlvTDNrY1FqbUJwY0RxWXdOMktWM1UzTTJBY1JHV2tn?=
 =?utf-8?B?UDJacW10RkZIWW9QSnB6QUNkdE1MbTM2cktBbldYbk11SnE0bFk3ZnJtN2tU?=
 =?utf-8?B?cm04aUNHOWM3TDRVS05DRDVJNWlES1hDZjVLMHU2a0NVTE9HUkFva3l5SXdR?=
 =?utf-8?B?cVJDZUxZOVlzNHZQMVUwalFsKzFIcm9Tb1A4WTNDQmd5OENSeTFONkV1WjIv?=
 =?utf-8?B?Uy9CbSthZFFjMFN0ODdhZ0RnOXFVTm1IdDJQYnVHd3ZPOUhuaWVwYUNlNVJv?=
 =?utf-8?B?RkVYRnZkTDRKRSt0T2tENWhKVFVwMUM3Vnp2NGQyaWZROG9SSG1pL0JLem1Y?=
 =?utf-8?B?T0M5cTYxQ0FSQVlFUi9FemtCempMK3hZY1Y4eHJzZHFoL0cvNUpjbzVob3B4?=
 =?utf-8?B?WWdLMHdmb3BCZTNvQkFqb3lPQjRFOVhkR1lnNVlLempTT3JUZm4vWXZ3TXo5?=
 =?utf-8?B?Nk1vUm80TGZESTlDMVpKa1lIelhGQkxONHRRbVFkNWhqU1Z2bzJkOXA1bjFO?=
 =?utf-8?B?bHFLZGJoN0ZFOG5OOWxlY20xbEtvT1VOaEFob3dPVURseWtwMFk1c01wV21h?=
 =?utf-8?B?UFdiZ1liV0Z0L3g3YTNlbmh2S1lNOFVZQ0c1cThoYmhaRzNRSElPamZleTQx?=
 =?utf-8?B?Y0ZPRytwNnRMcmJlWm56c2Y3K2lLd1d0dm13dzRGS0ZKMjJJUjlDTWV3RjZB?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAB78A140419674284B50FB9B328FAF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a3d6d4-5450-4b3d-3a7a-08d9dd3fc389
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 00:40:18.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9F6kf/K3rP7295kKvY5W9W3rj51m8rUKK53rE4cKRze5WDHdx2E61mHmyUQb+TQHrUHwFXFk/rJsvgPYjkO/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201220001
X-Proofpoint-ORIG-GUID: CqheHtaZWfqKR89NacjVczhm4N7IYAz0
X-Proofpoint-GUID: CqheHtaZWfqKR89NacjVczhm4N7IYAz0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMS8yMDIyIDQ6MzEgUE0sIEphbmUgQ2h1IHdyb3RlOg0KPiBPbiBiYXJlbWV0YWwgSW50
ZWwgcGxhdGZvcm0gd2l0aCBEQ1BNRU0gaW5zdGFsbGVkIGFuZCBjb25maWd1cmVkIHRvDQo+IHBy
b3Zpc2lvbiBkYXhmcywgc2F5IGEgcG9pc29uIHdhcyBjb25zdW1lZCBieSBhIGxvYWQgZnJvbSBh
IHVzZXIgdGhyZWFkLA0KPiBhbmQgdGhlbiBkYXhmcyB0YWtlcyBhY3Rpb24gYW5kIGNsZWFycyB0
aGUgcG9pc29uLCBjb25maXJtZWQgYnkgIm5kY3RsDQo+IC1OTSIuDQo+IA0KPiBOb3csIGRlcGVu
ZHMgb24gdGhlIGx1Y2ssIGFmdGVyIHNvbWV0aW1lKGZyb20gYSBmZXcgc2Vjb25kcyB0byA1KyBo
b3VycykNCj4gdGhlIGdob3N0IG9mIHRoZSBwcmV2aW91cyBwb2lzb24gd2lsbCBzdXJmYWNlLCBh
bmQgaXQgdGFrZXMNCj4gdW5sb2FkL3JlbG9hZCB0aGUgbGlibnZkaW1tIGRyaXZlcnMgaW4gb3Jk
ZXIgdG8gZHJpdmUgdGhlIHBoYW50b20gcG9pc29uDQo+IGF3YXksIGNvbmZpcm1lZCBieSBBUlMu
DQo+IA0KPiBUdXJucyBvdXQsIHRoZSBpc3N1ZSBpcyBxdWl0ZSByZXByb2R1Y2libGUgd2l0aCB0
aGUgbGF0ZXN0IHN0YWJsZSBMaW51eC4NCj4gDQo+IEhlcmUgaXMgdGhlIHJlbGV2YW50IGNvbnNv
bGUgbWVzc2FnZSBhZnRlciBpbmplY3RlZCA4IHBvaXNvbnMgaW4gb25lDQo+IHBhZ2UgdmlhDQo+
ICAgICAjIG5kY3RsIGluamVjdC1lcnJvciBuYW1lc3BhY2UwLjAgLW4gMiAtQiA4MjEwDQoNClRo
ZXJlIGlzIGEgY3V0LW4tcGFzdGUgZXJyb3IsIHRoZSBhYm92ZSBsaW5lIHNob3VsZCBiZQ0KICAg
IiMgbmRjdGwgaW5qZWN0LWVycm9yIG5hbWVzcGFjZTAuMCAtbiA4IC1CIDgyMTAiDQoNCi1qYW5l
DQoNCj4gdGhlbiwgY2xlYXJlZCB0aGVtIGFsbCwgYW5kIHdhaXQgZm9yIDUrIGhvdXJzLCBub3Rp
Y2UgdGhlIHRpbWUgc3RhbXAuDQo+IEJUVywgdGhlIHN5c3RlbSBpcyBpZGxlIG90aGVyd2lzZS4N
Cj4gDQo+IFsgMjQzOS43NDIyOTZdIG1jZTogVW5jb3JyZWN0ZWQgaGFyZHdhcmUgbWVtb3J5IGVy
cm9yIGluIHVzZXItYWNjZXNzIGF0DQo+IDE4NTA2MDI0MDANCj4gWyAyNDM5Ljc0MjQyMF0gTWVt
b3J5IGZhaWx1cmU6IDB4MTg1MDYwMjogU2VuZGluZyBTSUdCVVMgdG8NCj4gZnNkYXhfcG9pc29u
X3YxOjg0NTcgZHVlIHRvIGhhcmR3YXJlIG1lbW9yeSBjb3JydXB0aW9uDQo+IFsgMjQzOS43NjE4
NjZdIE1lbW9yeSBmYWlsdXJlOiAweDE4NTA2MDI6IHJlY292ZXJ5IGFjdGlvbiBmb3IgZGF4IHBh
Z2U6DQo+IFJlY292ZXJlZA0KPiBbIDI0MzkuNzY5OTQ5XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06
IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZA0KPiAtMTg1MDYwMzAwMCB1bmNhY2hlZC1taW51
czwtPndyaXRlLWJhY2sNCj4gWyAyNDM5Ljc2OTk4NF0geDg2L1BBVDogbWVtdHlwZV9yZXNlcnZl
IGZhaWxlZCBbbWVtDQo+IDB4MTg1MDYwMjAwMC0weDE4NTA2MDJmZmZdLCB0cmFjayB1bmNhY2hl
ZC1taW51cywgcmVxIHVuY2FjaGVkLW1pbnVzDQo+IFsgMjQzOS43Njk5ODVdIENvdWxkIG5vdCBp
bnZhbGlkYXRlIHBmbj0weDE4NTA2MDIgZnJvbSAxOjEgbWFwDQo+IFsgMjQ0MC44NTYzNTFdIHg4
Ni9QQVQ6IGZzZGF4X3BvaXNvbl92MTo4NDU3IGZyZWVpbmcgaW52YWxpZCBtZW10eXBlDQo+IFtt
ZW0gMHgxODUwNjAyMDAwLTB4MTg1MDYwMmZmZl0NCj4gDQo+IEF0IHRoaXMgcG9pbnQsDQo+ICMg
bmRjdGwgbGlzdCAtTk11IC1yIDANCj4gew0KPiAgICAgImRldiI6Im5hbWVzcGFjZTAuMCIsDQo+
ICAgICAibW9kZSI6ImZzZGF4IiwNCj4gICAgICJtYXAiOiJkZXYiLA0KPiAgICAgInNpemUiOiIx
NS43NSBHaUIgKDE2LjkxIEdCKSIsDQo+ICAgICAidXVpZCI6IjJjY2M1NDBhLTNjN2ItNGI5MS1i
ODdiLTllODk3YWQwYjliYiIsDQo+ICAgICAic2VjdG9yX3NpemUiOjQwOTYsDQo+ICAgICAiYWxp
Z24iOjIwOTcxNTIsDQo+ICAgICAiYmxvY2tkZXYiOiJwbWVtMCINCj4gfQ0KPiANCj4gWzIxMzUx
Ljk5MjI5Nl0gezJ9W0hhcmR3YXJlIEVycm9yXTogSGFyZHdhcmUgZXJyb3IgZnJvbSBBUEVJIEdl
bmVyaWMNCj4gSGFyZHdhcmUgRXJyb3IgU291cmNlOiAxDQo+IFsyMTM1Mi4wMDE1MjhdIHsyfVtI
YXJkd2FyZSBFcnJvcl06IGV2ZW50IHNldmVyaXR5OiByZWNvdmVyYWJsZQ0KPiBbMjEzNTIuMDA3
ODM4XSB7Mn1bSGFyZHdhcmUgRXJyb3JdOiAgRXJyb3IgMCwgdHlwZTogcmVjb3ZlcmFibGUNCj4g
WzIxMzUyLjAxNDE1Nl0gezJ9W0hhcmR3YXJlIEVycm9yXTogICBzZWN0aW9uX3R5cGU6IG1lbW9y
eSBlcnJvcg0KPiBbMjEzNTIuMDIwNTcyXSB7Mn1bSGFyZHdhcmUgRXJyb3JdOiAgIHBoeXNpY2Fs
X2FkZHJlc3M6IDB4MDAwMDAwMTg1MDYwMzIwMA0KPiBbMjEzNTIuMDI3OTU4XSB7Mn1bSGFyZHdh
cmUgRXJyb3JdOiAgIHBoeXNpY2FsX2FkZHJlc3NfbWFzazoNCj4gMHhmZmZmZmZmZmZmZmZmZjAw
DQo+IFsyMTM1Mi4wMzU4MjddIHsyfVtIYXJkd2FyZSBFcnJvcl06ICAgbm9kZTogMCBtb2R1bGU6
IDENCj4gWzIxMzUyLjA0MTQ2Nl0gezJ9W0hhcmR3YXJlIEVycm9yXTogICBESU1NIGxvY2F0aW9u
OiAvU1lTL01CL1AwIEQ2DQo+IFsyMTM1Mi4wNDgyNzddIE1lbW9yeSBmYWlsdXJlOiAweDE4NTA2
MDM6IHJlY292ZXJ5IGFjdGlvbiBmb3IgZGF4IHBhZ2U6DQo+IFJlY292ZXJlZA0KPiBbMjEzNTIu
MDU2MzQ2XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dl
ZA0KPiBbMjEzNTIuMDU2ODkwXSBFREFDIHNreCBNQzA6IEhBTkRMSU5HIE1DRSBNRU1PUlkgRVJS
T1INCj4gWzIxMzUyLjA1Njg5Ml0gRURBQyBza3ggTUMwOiBDUFUgMDogTWFjaGluZSBDaGVjayBF
dmVudDogMHgwIEJhbmsgMjU1Og0KPiAweGJjMDAwMDAwMDAwMDAwOWYNCj4gWzIxMzUyLjA1Njg5
NF0gRURBQyBza3ggTUMwOiBUU0MgMHgwDQo+IFsyMTM1Mi4wNTY4OTVdIEVEQUMgc2t4IE1DMDog
QUREUiAweDE4NTA2MDMyMDANCj4gWzIxMzUyLjA1Njg5N10gRURBQyBza3ggTUMwOiBNSVNDIDB4
OGMNCj4gWzIxMzUyLjA1Njg5OF0gRURBQyBza3ggTUMwOiBQUk9DRVNTT1IgMDoweDUwNjU2IFRJ
TUUgMTY0Mjc1ODI0MyBTT0NLRVQNCj4gMCBBUElDIDB4MA0KPiBbMjEzNTIuMDU2OTA5XSBFREFD
IE1DMDogMSBVRSBtZW1vcnkgcmVhZCBlcnJvciBvbg0KPiBDUFVfU3JjSUQjMF9NQyMwX0NoYW4j
MF9ESU1NIzEgKGNoYW5uZWw6MCBzbG90OjEgcGFnZToweDE4NTA2MDMNCj4gb2Zmc2V0OjB4MjAw
IGdyYWluOjMyIC0gIGVycl9jb2RlOjB4MDAwMDoweDAwOWYgWy4uXQ0KPiANCj4gQW5kIG5vdywN
Cj4gDQo+ICMgbmRjdGwgbGlzdCAtTk11IC1yIDANCj4gew0KPiAgICAgImRldiI6Im5hbWVzcGFj
ZTAuMCIsDQo+ICAgICAibW9kZSI6ImZzZGF4IiwNCj4gICAgICJtYXAiOiJkZXYiLA0KPiAgICAg
InNpemUiOiIxNS43NSBHaUIgKDE2LjkxIEdCKSIsDQo+ICAgICAidXVpZCI6IjJjY2M1NDBhLTNj
N2ItNGI5MS1iODdiLTllODk3YWQwYjliYiIsDQo+ICAgICAic2VjdG9yX3NpemUiOjQwOTYsDQo+
ICAgICAiYWxpZ24iOjIwOTcxNTIsDQo+ICAgICAiYmxvY2tkZXYiOiJwbWVtMCIsDQo+ICAgICAi
YmFkYmxvY2tfY291bnQiOjEsDQo+ICAgICAiYmFkYmxvY2tzIjpbDQo+ICAgICAgIHsNCj4gICAg
ICAgICAib2Zmc2V0Ijo4MjE3LA0KPiAgICAgICAgICJsZW5ndGgiOjEsDQo+ICAgICAgICAgImRp
bW1zIjpbDQo+ICAgICAgICAgICAibm1lbTAiDQo+ICAgICAgICAgXQ0KPiAgICAgICB9DQo+ICAg
ICBdDQo+IH0NCj4gDQo+IEFjY29yZGluZyB0byBteSBsaW1pdGVkIHJlc2VhcmNoLCB3aGVuIGdo
ZXNfcHJvY19pbl9pcnEoKSBpcyBmaXJlZCB0bw0KPiByZXBvcnQgYSBkZWxheWVkIFVFIGFuZCBp
dCBjYWxscyBtZW1vcnlfZmFpbHVyZSgpIHRvIHRha2UgdGhlIHBhZ2Ugb3V0DQo+IGFuZCBjYXVz
ZXMgZHJpdmVyIHRvIHJlY29yZCBhIGJhZGJsb2NrIHJlY29yZCwgYW5kIHRoYXQncyBob3cgdGhl
DQo+IHBoYW50b20gcG9pc29uIGFwcGVhcmVkLg0KPiANCj4gTm90ZSwgMSBwaGFudG9tIHBvaXNv
biBmb3IgOCBpbmplY3RlZCBwb2lzb25zLCBzbywgbm90IGFuIGFjY3VyYXRlDQo+IHBoYW50b20g
cmVwcmVzZW50YXRpb24uDQo+IA0KPiBCdXQgdGhhdCBhc2lkZSwgaXQgc2VlbXMgdGhhdCB0aGUg
R0hFUyBtZWNoYW5pc20gYW5kIHRoZSBzeW5jaHJvbm91cyBNQ0UNCj4gaGFuZGxpbmcgaXMgdG90
YWxseSBhdCBvZGRzIHdpdGggZWFjaCBvdGhlciwgYW5kIHRoYXQgY2Fubm90IGJlIGNvcnJlY3Qu
DQo+IA0KPiBXaGF0IGlzIHRoZSByaWdodCB0aGluZyB0byBkbyB0byBmaXggdGhlIGlzc3VlPyBT
aG91bGQgbWVtb3J5X2ZhaWx1cmUNCj4gaGFuZGxlciBzZWNvbmQtZ3Vlc3MgdGhlIEdIRVMgcmVw
b3J0PyAgU2hvdWxkIHRoZSBzeW5jaHJvbm91cyBNQ0UNCj4gaGFuZGxpbmcgbWVjaGFuaXNtIG1h
bmFnZSB0byB0ZWxsIHRoZSBmaXJtd2FyZSB0aGF0IHNvLWFuZC1zbyBtZW1vcnkgVUUNCj4gaGFz
IGJlZW4gY2xlYXJlZCBhbmQgaGVuY2UgY2xlYXIgdGhlIHJlY29yZCBpbiBmaXJtd2FyZT8gIE90
aGVyIGlkZWFzPw0KPiANCj4gDQo+IFRoYW5rcyENCj4gLWphbmUNCg0K
