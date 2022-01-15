Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95448F3F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiAOBJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:09:28 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:41795 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231777AbiAOBJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:09:27 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20F0T3Q0010938;
        Fri, 14 Jan 2022 20:09:19 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2051.outbound.protection.outlook.com [104.47.60.51])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dkb510abv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 20:09:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN6+t+qZE5Q1+zXRoWpydJDf81iu2o6ZRI6+gP2z/VRaQbgnEPgXBChUHpza1zkJ6BK4+mPO1mfDWukhUbI/hKuKhI9HJgugNUU1y6UqxB+xtDN4pSOgVAINRzJ5nHu019s4XTL8+0yY2qwdNQubrRuujc1r0IsXZfBrHM4Pr7+otft09qf9PfrxdWtZVt1O+t9qzL899dHj9Q8NP0I9JYR0LOEfe9BcJhlKrxgk3gRSW3/RRO0dKycYAAOPWeb3T1K/wOwZTa79gVszaSGm3lLwrk6IqqV9XkUaw52Av2nPghgERovxyFQUs4jxrb9nOVgelg24iDkzazmUb8ZBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUbGY39yR9ofIIku04XQYyHRMRY4hZ5VD+3UuihUemQ=;
 b=C1SIGBxFpT9st7P038eWrfm2TvAaJYQlh/KNKAFKYlGRYH3XHu1oy2pVfWI5k5knsofXn+YfYZhmrm8k+RwH9i+PHdzQ80DHCOa3Mga+zTg7ipfJR0HCOyDQFFsvhxEKnHbH3gQFfqMlaR/xgOAPZfgXbn6eUSxxKr8/BdejDTsFMWLqhzGI9iKo8uRGOzMR2B+PAYW/nGeWFFHZ1Kf9r8hrNvGMOkvfZnPIJngQ9JcJcKBW4rlV5gjXhdbPmkU2cnKdBXswcVc1BmDvwf53qd3tCU6n2m67vKyMCl+BRNxQpV8sLLJEbDqlAdu5WKY0y4ptpufbd2QAH4lLgG7cQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUbGY39yR9ofIIku04XQYyHRMRY4hZ5VD+3UuihUemQ=;
 b=ZiefQMboX3yZhfQjWkMAwyBh6fwBfb5tNWQwKHosGktkE00og5qA5zEBiG8JyGioqk5LuUI5Ol7ce+3Kl9JMK358tvrM+x5DCNnSluMKEZcfcQdyV9MQdaI1bwX3nZ9FkQPnTXxm6F/qvFvcjvENqVZTjwhj/ZyeV/ZDrLOhDaU=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT2PR01MB9461.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sat, 15 Jan
 2022 01:09:17 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 01:09:17 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
Subject: Re: [PATCH 4/6] usb: dwc3: Handle fractional reference clocks
Thread-Topic: [PATCH 4/6] usb: dwc3: Handle fractional reference clocks
Thread-Index: AQHYCaAADT3q1Q/zfkaOiZfSiKeZ/axjRccA
Date:   Sat, 15 Jan 2022 01:09:17 +0000
Message-ID: <6124a999dedcfaaac45efe58ffd3ba52dd3b6b82.camel@calian.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
         <20220114233904.907918-5-sean.anderson@seco.com>
In-Reply-To: <20220114233904.907918-5-sean.anderson@seco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c52a540b-c8b1-4ee3-d488-08d9d7c3a718
x-ms-traffictypediagnostic: YT2PR01MB9461:EE_
x-microsoft-antispam-prvs: <YT2PR01MB9461B9B1ECF1EF35872FA025EC559@YT2PR01MB9461.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9deOb6VKkvVaDy2knSvI5uHeIKw7El3ynEZGJcgCt9PsXP2ph+qX2aTfr6GSZ9AmJPnrjEk7nSc+DGT65ntOHgCM0w7iIxCvYvQqLq4NMaHaJSq5O5TA1T8N8Jn67bAdhz3u7dT1C7dFiU0kOI94Q0MO87fIAhVYYdAl0YOMcGtZVhObChsG1yF/ECtPAwgih/0GZU8wECsYpwfMSmilm2Zsb4N01IgFHF+VbTtc2byg1NWEniHjfZHeJ/Z0vAh80VfeSmICidzJ9Yr+DLEGnTAt998nD5IZSPOFskFWo0qHAU0qInJz6bdZJ2gnycbDUVqlmMBLnGjl3LWhayHS+Ds6YU4Ci74A8D9EelEUe5E7kIg19eflmloeoKmXDPi19k8EQOGG9z4wPTaQfovPiVrMH5tLzVBmkDCgrs5NKxw6rtg1kwoCVVUXe6GSjRxUrYFsirsmAPkFf4wpmsypACHMVTtyxHiJtWYxpS1GXUJnrMqV9Jk1lXP1GxHbSZRK2SnTpT39RskMJVOhocV7vpoVRI6N1jSnqr9Ovb9zzeZNugOtPoQuAkj/k6vnJQbWzOSs7TT+0XJCF/5gH7oXmcDYQnQ3fwNKuq9ehfeibBGz81GXAWmB19OJ6Zp08891a4VqEJZTv199sBNoBA0qEeJjhG9EGBCsAouYBOgSb9clWO8Tfurm/BdQwzpU5rUnUbQQFINycKC1gOtOZbNVEnaf2lmO7lC3+ZbERBVaZjFGqLSAHtUu4SJiptrUQVoLeJCEDmzRjq7PGQZkR6XSUnzXANfP3NCXeYVJRGlkEJ2PnkDJYcO8EaDXu4fc7lkSJSnJOucUO400siVi0VamWTXZk/tUyAzksczXJA8/oVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(71200400001)(6512007)(186003)(122000001)(6486002)(36756003)(83380400001)(86362001)(2906002)(5660300002)(2616005)(44832011)(38070700005)(6506007)(26005)(76116006)(91956017)(508600001)(66946007)(110136005)(54906003)(316002)(66446008)(66556008)(66476007)(64756008)(4326008)(15974865002)(8936002)(8676002)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnZFUTNQWS92Q2hFejRDOVFoam1rajByVGdDS2JDMy9FWUprNFkwTEw1eVJU?=
 =?utf-8?B?Mk0wd0ZWWjZQRW1lRDc4K0lJKzhFZjJBSTA3cldZOHp4SzBPVUwwaytLYmhJ?=
 =?utf-8?B?cGpzZkVWano4WWlFeE5zUG5mRDJJUk1aMTFXVjhNRWtFQjZGc2hzak90Q0lr?=
 =?utf-8?B?WE5pdlJBR1hzT3g3NlVuMlVNelVYdXdJR0ZpU1YySTZYSExwMlZLak9oME5o?=
 =?utf-8?B?dFhDQmk5bDJKSzNQcWhWbkVHUXlBTS9JWHNiemJMKyszbHMvdmNEMS9zTldq?=
 =?utf-8?B?TVovODUxZkttOVBpVDFaR0E1YXBIWklPRUYxOTdsVzFtVGpuRmJsTnJvN2RY?=
 =?utf-8?B?dDF3alJLSEZ5MVJSOWtneVhQTzVtN0YyVzRpajhhTFFpdzlWRG9CNGlzcEpM?=
 =?utf-8?B?dHlXOHU3bi9FL0xOZU9xZHY2TlN3M250blBhU2NUN1IzeldqNis1L1cvQVdr?=
 =?utf-8?B?ZkFEb1BKZkduL1o0eGVaaWpneTBPZ0tyeEVpd3R1ajQzeTRIaWh4Y3NibWdD?=
 =?utf-8?B?OWpVSmZYOWhXVDVESWx5NGMyUlhoTk9GYTdOQStpZDRtU2FObWpVbXVNQmN2?=
 =?utf-8?B?TGV3U1puVGlaSUUyYW40ZjA2cEk2MWF4di9hVCsxaTUzNUttS1lPWEJqbnRI?=
 =?utf-8?B?NDNFS3h2WmYyU3dNVUFFT3BrZEdSdDJKa2p0YlNmNXA1cGJjMnYvSi9taE1C?=
 =?utf-8?B?cVEvTjVHUW9nMG5CeDhobmNFNGNVbTBwNXpMYmxtWllrVlY2amh5Mi84ZnBQ?=
 =?utf-8?B?clFWOXY0U3p2bVhJV2ZTb3NsbFF6cC9IRThhT1lKODdLcTFyV2srTU1ob0wx?=
 =?utf-8?B?OUUyYnV2VjhXbU5ERjFuN1ZYVVk1T0t0QXkwUzYxeDVCMnZ2bnp3NDF1Vjh6?=
 =?utf-8?B?Y3JGVlk5cCtoQVZzSk9UcHVRMTRqSytuZmozMmo4ci8yLzRXTS9uWjhRTTZo?=
 =?utf-8?B?d0MyL21UZjlvdlhlbTFRRmtzRzdzZTZSSDZUdWkrdXFBUFNjc3hlV2dFQXg0?=
 =?utf-8?B?Mm1GUENTK1BMb3JxSDRrS2F0RmJvUkJFek5zbmRuZXNXd3psWHV2Z0cyTUJP?=
 =?utf-8?B?THhRV2hoWDlvYlpxYjVNTXFkdTJJa2UyVGxuWTdXbzRwcWdpdlZuYUJyU3dR?=
 =?utf-8?B?QXVJUVNZYUFzNmVIZ0RGUjB1dzE1SUZJaHhNbTkyRTBNWXM1eE1nZ3NmZWJI?=
 =?utf-8?B?c3Y4dXdCcCtlWk40NXY5akZwVVMvWlZvSFFRWmxDMUpGOWhCakhEYTFrRWVE?=
 =?utf-8?B?MUM2VlZmSzFOK0R0OE1sajR4OTRENENOTitSOTh5QlFXK1ExRU8xV0FuQmUr?=
 =?utf-8?B?VzVHQVZaeFV6WkE3Y0FudTZLb09UajZodWNYNHdCK1BoVTVZdUdlb3pZRzFL?=
 =?utf-8?B?RWpRNWJKK0tSVk1iZ3hTRW12NHhib0ZyUzV3NG5vTzdJcDdpYTJDeFFQUmlj?=
 =?utf-8?B?c2RrYm5zWEFVdG1XMW02OXJ4N3VLTXRBUUJwdms0S3JLQ0dWYTY0QWRLMWwv?=
 =?utf-8?B?SVQ5U21pb1A2cTdzRHk3cXdZVUtucTh4SFBKcUxxSjJDeGExWUZ4K0IySENy?=
 =?utf-8?B?Z1pocnYrTUgxUGdQS1FqamdmeWQvSnUxTWJjRjNNR1JEQSswWFRleVQ0Ry9u?=
 =?utf-8?B?dEVzTGRtQys0VUoydWN5WmYyREZGTjR6Y1RaSXpySnZ2VW50UmdiWE5NMTEx?=
 =?utf-8?B?NHhJK0xjbHFlZld2WW9tQkdyaE4wR0dDbTJxMXd1bDYwa0dxeVA1K1R4Rklp?=
 =?utf-8?B?NGE0NUhOS0xlTUxUTk92SWpoUmZOTkZxR2lFUlUyY2RQNW03bTZpUGZBWEFz?=
 =?utf-8?B?N2tVcW5GYWdtQk9CTmVNZUwyUm9YOWNXTW9ja2M3NkNvT1JHdTFlM05hYml4?=
 =?utf-8?B?aGxLSDl3ZWdDUE03VzlvNkNtYUNIYUwvbjZWOUt6VVJlSXROalJTb1pDSFBR?=
 =?utf-8?B?Y0hWTFB3MjE4LzVBcGE1a0l6MTJ0M083NlZnc2VBdkk1UzJFWlYybWRpTmx3?=
 =?utf-8?B?QkYyRDhEeDZQc25XWGV3K1J2VFVPOGxNaFJ1WWpBU1lyWDdwTUxoazR2RUZJ?=
 =?utf-8?B?dHBpditUNTlBRU1lemJEU1pSMU5KekplUC9BM2M4OXNnMGE2aGVSVEtFdUdq?=
 =?utf-8?B?cDdSaldiSkdCd2ZEa3JiTFVMRTh1bWVUUk80TTlWcnZ5cEJzMUhxMVM2TExK?=
 =?utf-8?B?NmgvSm9pWEJBbGhtMVdQNTVnNW82MERVZ0o3bHAwSDVuK2RZS0E1b1B4ZmlV?=
 =?utf-8?Q?OczlFDoPAMTCZqBZqQ5UqaUgBm7SBBvOp2ajbDkCSE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A08C19DECA67441B47355524B42EF5B@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c52a540b-c8b1-4ee3-d488-08d9d7c3a718
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 01:09:17.1184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8bwCzyeFL9Av+g8HIK9kJmCUMI/zPs2aj+7jzvIQYf6mA49B5oqxzu5WMoRrDPaqDB3bjpEhOSP0A4z/ldFC7WvT9xc4v2OVcCR325r2WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9461
X-Proofpoint-GUID: tm2Tar1RL-ZmYIfmc_YRtt4vt4t-ttR3
X-Proofpoint-ORIG-GUID: tm2Tar1RL-ZmYIfmc_YRtt4vt4t-ttR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxlogscore=961
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTAxLTE0IGF0IDE4OjM5IC0wNTAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0K
PiBHVUNUTC5SRUZDTEtQRVIgY2FuIG9ubHkgYWNjb3VudCBmb3IgY2xvY2sgZnJlcXVlbmNpZXMg
d2l0aCBpbnRlZ2VyDQo+IHBlcmlvZHMuIFRvIGFkZHJlc3MgdGhpcywgcHJvZ3JhbSBSRUZDTEtf
RkxBREogd2l0aCB0aGUgcmVsYXRpdmUgZXJyb3INCj4gY2F1c2VkIGJ5IHBlcmlvZCB0cnVuY2F0
aW9uLiBUaGUgZm9ybXVsYSBnaXZlbiBpbiB0aGUgcmVnaXN0ZXIgcmVmZXJlbmNlDQo+IGhhcyBi
ZWVuIHJlYXJyYW5nZWQgdG8gYWxsb3cgY2FsY3VsYXRpb24gYmFzZWQgb24gcmF0ZSAoaW5zdGVh
ZCBvZg0KPiBwZXJpb2QpLCBhbmQgdG8gYWxsb3cgZm9yIGZpeGVkLXBvaW50IGFyaXRobWV0aWMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQHNlY28u
Y29tPg0KPiAtLS0NCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDI1ICsrKysrKysr
KysrKysrKysrKysrKysrLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDEgKw0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gaW5kZXggNTIxNGRhY2VkYTg2Li40OGJiM2U0MmNkZDAgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IEBAIC0zNDgsNyArMzQ4LDcgQEAgc3RhdGljIHZvaWQgZHdjM19mcmFtZV9sZW5ndGhfYWRq
dXN0bWVudChzdHJ1Y3QgZHdjMw0KPiAqZHdjKQ0KPiAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xr
X3BlcmlvZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCXUzMiByZWc7DQo+IC0JdW5zaWdu
ZWQgbG9uZyByYXRlLCBwZXJpb2Q7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFkaiwgcmF0ZSwgcGVy
aW9kOw0KPiAgDQo+ICAJaWYgKGR3Yy0+cmVmX2Nsaykgew0KPiAgCQlyYXRlID0gY2xrX2dldF9y
YXRlKGR3Yy0+cmVmX2Nsayk7DQo+IEBAIC0zNTcsMTYgKzM1NywzNyBAQCBzdGF0aWMgdm9pZCBk
d2MzX3JlZl9jbGtfcGVyaW9kKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCXBlcmlvZCA9IE5TRUNf
UEVSX1NFQyAvIHJhdGU7DQo+ICAJfSBlbHNlIGlmIChkd2MtPnJlZl9jbGtfcGVyKSB7DQo+ICAJ
CXBlcmlvZCA9IGR3Yy0+cmVmX2Nsa19wZXI7DQo+ICsJCXJhdGUgPSBOU0VDX1BFUl9TRUMgLyBw
ZXJpb2Q7DQo+ICAJfSBlbHNlIHsNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gIA0KPiArCS8qDQo+
ICsJICogVGhlIGNhbGN1bGF0aW9uIGJlbG93IGlzDQo+ICsJICoNCj4gKwkgKiAxMjUwMDAgKiAo
TlNFQ19QRVJfU0VDIC8gKHJhdGUgKiBwZXJpb2QpIC0gMSkNCj4gKwkgKg0KPiArCSAqIGJ1dCBy
ZWFycmFuZ2VkIGZvciBmaXhlZC1wb2ludCBhcml0aG1ldGljLg0KPiArCSAqDQo+ICsJICogTm90
ZSB0aGF0IHJhdGUgKiBwZXJpb2Qgfj0gTlNFQ19QRVJfU0VDT05ELCBtaW51cyB0aGUgbnVtYmVy
IG9mDQo+ICsJICogbmFub3NlY29uZHMgb2YgZXJyb3IgY2F1c2VkIGJ5IHRoZSB0cnVuY2F0aW9u
IHdoaWNoIGhhcHBlbmVkIGR1cmluZw0KPiArCSAqIHRoZSBkaXZpc2lvbiB3aGVuIGNhbGN1bGF0
aW5nIHJhdGUgb3IgcGVyaW9kICh3aGljaGV2ZXIgb25lIHdhcw0KPiArCSAqIGRlcml2ZWQgZnJv
bSB0aGUgb3RoZXIpLiBXZSBmaXJzdCBjYWxjdWxhdGUgdGhlIHJlbGF0aXZlIGVycm9yLCB0aGVu
DQo+ICsJICogc2NhbGUgaXQgdG8gdW5pdHMgb2YgMC4wOCUuDQo+ICsJICovDQo+ICsJZmxhZGog
PSBkaXY2NF91NjQoMTI1MDAwVUxMICogTlNFQ19QRVJfU0VDLCAodTY0KXJhdGUgKiBwZXJpb2Qp
Ow0KPiArCWZsYWRqIC09IDEyNTAwMDsNCj4gKw0KPiAgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5y
ZWdzLCBEV0MzX0dVQ1RMKTsNCj4gIAlyZWcgJj0gfkRXQzNfR1VDVExfUkVGQ0xLUEVSX01BU0s7
DQo+ICAJcmVnIHw9ICBGSUVMRF9QUkVQKERXQzNfR1VDVExfUkVGQ0xLUEVSX01BU0ssIHBlcmlv
ZCk7DQo+ICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVQ1RMLCByZWcpOw0KPiAtfQ0K
PiAgDQo+IA0KDQpkd2MzX2ZyYW1lX2xlbmd0aF9hZGp1c3RtZW50IHdoaWNoIGFsc28gd3JpdGVz
IHRvIHRoZSBEV0MzX0dGTEFESiByZWdpc3RlciBoYXMNCmEgY29uZGl0aW9uYWwgdG8gc2tpcCBp
dCBpZiBEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAyNTBBKSwgbm90IHN1cmUgaWYgaXQncw0KbmVl
ZGVkIGZvciB0aGlzIGZpZWxkIG9yIG5vdD8NCg0KPiArCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5y
ZWdzLCBEV0MzX0dGTEFESik7DQo+ICsJcmVnICY9IH5EV0MzX0dGTEFESl9SRUZDTEtfRkxBREpf
TUFTSzsNCj4gKwlyZWcgfD0gRklFTERfUFJFUChEV0MzX0dGTEFESl9SRUZDTEtfRkxBREpfTUFT
SywgZmxhZGopOw0KPiArCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRkxBREosIHJlZyk7
DQo+ICt9DQo+ICANCj4gIC8qKg0KPiAgICogZHdjM19mcmVlX29uZV9ldmVudF9idWZmZXIgLSBG
cmVlcyBvbmUgZXZlbnQgYnVmZmVyDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IDMyZGZjZjNhODNkNS4uNTBj
MDk0YWYxMzFkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMzg4LDYgKzM4OCw3IEBADQo+ICAvKiBH
bG9iYWwgRnJhbWUgTGVuZ3RoIEFkanVzdG1lbnQgUmVnaXN0ZXIgKi8NCj4gICNkZWZpbmUgRFdD
M19HRkxBREpfMzBNSFpfU0RCTkRfU0VMCQlCSVQoNykNCj4gICNkZWZpbmUgRFdDM19HRkxBREpf
MzBNSFpfTUFTSwkJCTB4M2YNCj4gKyNkZWZpbmUgRFdDM19HRkxBREpfUkVGQ0xLX0ZMQURKX01B
U0sJCUdFTk1BU0soMjEsIDgpDQo+ICANCj4gIC8qIEdsb2JhbCBVc2VyIENvbnRyb2wgUmVnaXN0
ZXIqLw0KPiAgI2RlZmluZSBEV0MzX0dVQ1RMX1JFRkNMS1BFUl9NQVNLCQkweGZmYzAwMDAwDQot
LSANClJvYmVydCBIYW5jb2NrDQpTZW5pb3IgSGFyZHdhcmUgRGVzaWduZXIsIENhbGlhbiBBZHZh
bmNlZCBUZWNobm9sb2dpZXMNCnd3dy5jYWxpYW4uY29tDQo=
