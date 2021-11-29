Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47B461F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379165AbhK2SyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:54:00 -0500
Received: from mail-mw2nam08on2074.outbound.protection.outlook.com ([40.107.101.74]:15488
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234687AbhK2Sv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:51:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8oDx6qwiwj0l6eDCWGGvkJklp8Rj4+xmGB2en+uSLHT3NxrpCfBuKPzb32HYjl1pfH3fmAXOXxFiCn+pt1jA20WGhppq//lvoFvvQQ4hgq/9XVqy/SsADh24QlpJuWkQUutlvrVNAqksI5R6478O95pPyAx5wrAqjZ1N43KvbSC3PzhoHwbGE7LJRvE2baX70LnLuP62F2xfCvd2hKHv/hexpY2sIMEZpZOEcIwXA5csql5zKoYxrFjANo53Zkf6X9gNeujzIPM797mRqhpdCthoMpMtpw6Q490vSK1yWqJNJJXeOwmixiEm1tiKP29ZuuvtvZi3kS8ollFdm57zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB8UzfcNHhRY3XeB5SlQ+1rJeqy//ehRmUXSRZXHbUc=;
 b=ejAPXxRj5E+tiIwVPh3W9tjYd00zp7qGIgVYHWQ7ZZMhYQKo1Z0l78/YirpTnoihZmJgjfekk3OkQ6K2o8XtzpGLjMx5xAOqM6mCiVXMig1H/EojaEAZr+RP05LNuYsnwiqmsWYWBTB9f/RHreureHCCjclf2RK+YA97OMsgCJP/I1REYi33OpCwA3d31ILPcmy8fpJzmI9n7+PY+Rm+lbgoIWm7992xKgGGQpC7j2rHbRqsZtnJ6sFzDLepy2GnwJcID7J8e7gcd6QwjVFthI8jIZOYjC2kJW/Mp3FqUayXrLNjQtSLZCcrIGeiJ4ZpRRHIKRGh0wbHNiJMnWVl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB8UzfcNHhRY3XeB5SlQ+1rJeqy//ehRmUXSRZXHbUc=;
 b=JXg8hSziQSW3GVMQ4AgmyAWm6n3yh5zGsHayOB80xM1wu7nSjPyETdPnprzgRJYf+zdiBu3SQxU08s3z58Hrblykb+dGaO59vlh3RX+wofPP+clFcyb2USi9G4j7BDPsaDhLDZJ08uortqJzr+X2vZ26F4eUEJPQHRhbWqIRTH1lqvXhsCKF71xQ+sUx9pDFLSzakljhuDpRD5yFMJbw7ml/EhDV4CbALd+3DKr/+uYUamBdKs+ppifdTshPGAv0Gu11C4yjYy9YNHtx4xA14VBoDA60hLDopovi+NBw667Mo9UqL2tn4o61NYBHXUCaygHnf0W9WMqKxyJ3nEWWbw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 18:48:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:48:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
CC:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
Thread-Topic: [PATCH] nvme: duplicate NQNs check if devices needed
Thread-Index: AQHX5RMoQCXygWKbykCBO2GVgstv1Kwas7MAgAAllwA=
Date:   Mon, 29 Nov 2021 18:48:38 +0000
Message-ID: <f7dedda8-a739-0af7-95c7-5e4c1f574ff7@nvidia.com>
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
 <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbd32905-777f-4225-d62f-08d9b368db56
x-ms-traffictypediagnostic: MWHPR1201MB0160:
x-microsoft-antispam-prvs: <MWHPR1201MB01602D3FA6C10CC54AE53FB0A3669@MWHPR1201MB0160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oj8EI5TmTwoklGkAJf9ZfiGlrMdR53ypguPD2c2KuSMKt0mmCLN2BkUxV2/ubyfZX46v9hPCVhgvS4qO10EKFTtVjdRNNpsKDfvllXbuAldH2PboLVvTXtYZVLJuceY5NR31tpcw97WLy1L1lpHyBkkTKKQ52erhUvte2RMx9dRUk128k8ZhpwGajgYHZVZSQ+hT6Hy5QSzVzbLpA/vMt89JPzo1nsQ5guhMdoh1ph1DRDUrr/B26PpTtvIfYBKa+aSlRbjhd+Yse+FhWQC6N4IEdqTeyjlAnbJJ2dY6lSfJSwVfhfFQ/IMPf8ERXosRhOZKSaziDpNQZWzWZ4WA0wHq0z9JrhB+EgPEzsH0ZXA33jiB/C0O/gp8d7Nccr70UZJFbwkug5Nv1XIccYRntjDCpme+tZ644n2oPWQZxkX594HCSqCFAlaYSrnB62jwYLfBJOON4tf9V3WZDxmVBaJNb1AMPnWQ7fvJkbqdzhKb/mNTCzyBTFfAxGjCyKbQxOGc2RqaB6a4ZYaHng+M/Syj6mMx/fB4I0MvU2mJrrMG5BDp0MpFgE75EZwKIUJLR13Q4tclXwHW7g0E9124fqHpS8M2Q9DlY+vOVaAxHeahMjUD/sWGzUqYjgsy7JQCwqJAhs/pDjNHohRmm+tkvkNeiHZWOKkoGCCEjWfiJezbdkXEljovl/FM/CpvqMjRoAJAogHutk67sM3jmIcIonHcNPTHQI8c7u7MGHx1W6l/6vjU5KUa7xwJxBcV+tJUHfIaSW18TSWr9SmUYMG2LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(31696002)(71200400001)(2906002)(31686004)(4744005)(6512007)(8676002)(76116006)(83380400001)(5660300002)(6916009)(316002)(54906003)(186003)(86362001)(64756008)(53546011)(38100700002)(6506007)(66556008)(8936002)(2616005)(4326008)(66446008)(122000001)(66476007)(38070700005)(6486002)(66946007)(91956017)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ly9VVW1FRkF5YUlBaXBpRjN5Y0U2bHRPUS8zaUVlZnFwdGdrQ3NMT1p5a2kr?=
 =?utf-8?B?cHJPZEFHRlE3aWJrbGNEaVBiK1hZL1Noc0VtOXRsdXJ6UHVBcjJ3bWErblJT?=
 =?utf-8?B?VWFOSjhxakJuU3pweXgvK0JDVldVV25mbTN4SllEOG83Z1dlajl2eFZpYTQ3?=
 =?utf-8?B?cnpSbkFKM3A3TXM1dE04dEpBMXZCd2VZd2FMMUtmTk5ubENCQXZqZGdHQTRY?=
 =?utf-8?B?RzZUemVBb1htWjAyTlZKbFpvc0VQNzUzNGhsOFVjb21STTRTT1BhZlM3bmg3?=
 =?utf-8?B?d2l1QlNtVmlKc1IrVXJiUFlCdXRMdCtla3pkcCt6Wjcyc1JseFEzZHlVaEwr?=
 =?utf-8?B?anVReU1oRzE3Z3NrN09aZ1I0K2tYUlRiWDRueWdIKzhIWFF4bXhRa21HeW1O?=
 =?utf-8?B?T0hlSlNHMFV2Y0h5NUNTQ25YUzR2aFNwRnU1R0xWbVRad1Y0dVVEY3hacVo3?=
 =?utf-8?B?YVVxNXRPbGdYcWlyTzRWUFlUbW9BcXdRQjRFTldGcCsyektJNkVzVkVRMjVG?=
 =?utf-8?B?aE5mY2NwVm05YXd5YTBpRmpRNXIrNk9IQVk1UmFlSTJUaG9uNHVGcXFBZDN5?=
 =?utf-8?B?L3E5NXg1c2QvOTBDbEt6K2VNRWw3VmhqaTlveExjakQ3V2dEQi9NWTZ1RnRQ?=
 =?utf-8?B?R1lTVk4weS9SaFNDK25DSXU4em94dDhvOUhZYnluL2t5WHhNV0VnSms4UGdO?=
 =?utf-8?B?UnR4V1lBVFREOHJLYXhnQ2IyMUJwelZsSHdxOGhnbUdzU1ZuK000eTZWR0pZ?=
 =?utf-8?B?a0htZ3F4d0ZRS0oyaDR4V0NWNmtJZUk5V1BCUG1NMjYyQ0JsSmdHNEtJbXhy?=
 =?utf-8?B?alRRMFdUK1pvTzRDajRXWlBsODRZNUllVkNDckFFZWowOThtdEtjS1RreWc2?=
 =?utf-8?B?QytsWFRTdWtJSDE2U3hNUklaYXJCSG1MenpyVEV6eUxLZnR1MGVVcEhZOFc1?=
 =?utf-8?B?ZjRTNFE3S0hYMGlPWjJrZVNnZWVPbVVFWTh1aU1sUnFxbFkwRjJKRXZEQ1JD?=
 =?utf-8?B?M2N5M3U5OTMvZWQ3eVJjMmJyamZpa25NS1R1Wng0N3VONzVYcW92ZVBYYXlV?=
 =?utf-8?B?SFVFSm1RWis4M3BxbktrKytTWFVSZEhiRkw1eU83YXhvSGN0eGU4L0F1MkFo?=
 =?utf-8?B?djdzZ2UzSlRPNy95SGxQaE5KN0tmbzlBdzRPVGM0ZlZIQUJZbDhFYktDWSsx?=
 =?utf-8?B?Y2VMMEZ3UEtURFZkMGIwKzc1S2FoUTZzeitCM3pCN1JiWDlJWkZob0x0M29B?=
 =?utf-8?B?bXdZVm1JUTltSGw5TlhQQUtjZjdsSEc2b2hTMVltOTVtbHVqUDRtNUV1Y0Vw?=
 =?utf-8?B?cVRHZ29vMDZPWUliREVMMUVqM3FqLzhvNHJsV2tmelhvMUhSOHV3Um5RR0VC?=
 =?utf-8?B?ZWpwTHZIY2NlWWpUU2xyQ0VYN3MreGdzbk5hVkRvT0pYbDlFWHg4ZmQ0RDRj?=
 =?utf-8?B?NGE2WHlRemQrUTJoaldzVjFvVG1UUjltQmFndS8rQmdNQUVVOU1IbTlZeGpV?=
 =?utf-8?B?ajhQWVNNRGJzQ0ZJOWdVdFBBdG1GUUZhcFRXN3pFUCtla1h4YlpBRGtFdStY?=
 =?utf-8?B?SXVsSGV4ajcyMUpyTkZuZGRTWml2bTFXREtMVXFmVGRtaEpYQ2VTMHdaQWls?=
 =?utf-8?B?djVFY0FoY0FKOHJXSGE0RytIT0tBaXRydUttWGU5NEF0Nis2VFpBMG9JRkJY?=
 =?utf-8?B?eGVmTVdxUlJ5eFhPbXpSaGNTcXNGdzZXWEFQbHJLanByRWxvVnpKTUFvZk1I?=
 =?utf-8?B?bGFkOUJYL3JHQlg0RUUrWURiSjQ0S3lFNEJBRXVNYmRLV2xoUENROGJVTmhW?=
 =?utf-8?B?Ujc3eHlBelIyUDY1RmJlUkVCOFlYbyticmFyVzNyak1PSEpVL0x0bkpLeXl6?=
 =?utf-8?B?cUNkL24rNzg2bmw5VFBEK25NaE45NFVvNjh3U0JWVjVVSWgwN0dGNG5aUnAz?=
 =?utf-8?B?QVJTc0VmWDJBamhMa25GNWlaVUJWUDk0eENjK0ptV0FOaVQwVmp5N09obUh1?=
 =?utf-8?B?MUhVSGVuZ3RSOEdTQzNxZndod0xxMlRIWVFkZ2tIaTQ0VXJuVUlsNDFNenNW?=
 =?utf-8?B?QitCdkZLNnd3WEtSQWZVSjZTR05FL2VuZGEzUFVOSkF5V0ZITGpDc2xXN3Rl?=
 =?utf-8?B?WUQrc3lPZTZoZC9wdldGMHQ1VURQRXZOR1N5Y215bCsxK2U1NTJNTk1sUEFB?=
 =?utf-8?Q?J0zWJSLO/svlWQytQLVI/THuTom0R1UZUYoOeJyItmfA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <553AF3085AE9A54A858CE115C2FEDC5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd32905-777f-4225-d62f-08d9b368db56
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 18:48:38.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMJ57pawZDkEkrCSEMe96sJ8711zY94rAauW4wV7R9jBYQ88o2afLOWY4MdyPnPzgONe7htvou58UZJumMWk0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGlndWFuZywNCg0KT24gMTEvMjkvMjEgODozNCBBTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9u
IE1vbiwgTm92IDI5LCAyMDIxIGF0IDA3OjE4OjU0UE0gKzA4MDAsIExpZ3VhbmcgWmhhbmcgd3Jv
dGU6DQo+PiBAQCAtMjU4Nyw2ICsyNTg3LDkgQEAgc3RhdGljIHN0cnVjdCBudm1lX3N1YnN5c3Rl
bSAqX19udm1lX2ZpbmRfZ2V0X3N1YnN5c3RlbShjb25zdCBjaGFyICpzdWJzeXNucW4pDQo+PiAg
IA0KPj4gICAJbG9ja2RlcF9hc3NlcnRfaGVsZCgmbnZtZV9zdWJzeXN0ZW1zX2xvY2spOw0KPj4g
ICANCj4+ICsJaWYgKHN0cm5jbXAoc3Vic3lzbnFuLCAibnFuLiIsIDQpKQ0KPj4gKwkJcmV0dXJu
IE5VTEw7DQo+IA0KPiBUaGlzIHNlZW1zIGxpa2UgYW4gYXJiaXRyYXJ5IHdheSB0byBkZWNpZGUg
bm90IHRvIGNoZWNrIGZvciBkdXBsaWNhdGVzLg0KPiBTaG91bGRuJ3Qgd2UganVzdCBhZGQgdGhl
IE5WTUVfUVVJUktfSUdOT1JFX0RFVl9TVUJOUU4gcXVpcmsgZm9yIHRoZQ0KPiBicm9rZW4gY29u
dHJvbGxlcnM/DQo+IA0KDQpQbGVhc2UgYWRkIHQgaGUgcXVpcmsgZm9yIGEgc3BlY2lmaWMgY29u
dHJvbGxlcihzKSBhcyBtZW50aW9uZWQNCmJ5IEtlaXRoLg0KDQotY2sNCg==
