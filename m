Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5449F605
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbiA1JKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:10:11 -0500
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:5920
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234281AbiA1JKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:10:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPmV3JlEUgpOPsYm+VblF5zB4O/0psqZOuP4AHNStU9aL9WQkk8a2d7NMDdsQIp+KBH314LnDrwcaKoRcSl2OxkVKL93OG/5Q9I3BT7InSPejppRyZyz7VoH/dOPa5EwLfrdCOywvN03QqgtL1WUazH2pIKm7m7pqZaZfVasWnnPhH2mWaWSa8Mrna9fuG843EQXWZGlSLsabkCEZS8A1/zOSUMfLQmW4pw5vtM10JdCQoroObLWvc1DXW9QUeO7UplADvILQJAfmLdgZeGy1J1lNNVykvAD93AcjUxpMcFWKvUxbWbI16Dc/xy/qv09o1w4FsXo2dw7z0GB8JL38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB0nQxy1R6X21k7NxUtn2dp60RZTs88uxLhvISkJCgM=;
 b=jggy7L8zyxjyInoW/EdaYo8b32LbbHdGolNORu5BDtoxSbMh9lshRiiAGM62l5YRESOZ5wP7dUeNCzRzhom5wI2WzgDe4es1QGypJJkluuODp39IWWhcrQsMCoLbcTI63fc6PdsTzOVijaVb1WSJefxTDYIeCjvEN4Xvaw4Nkpp9PQU9eUWtKmE5volJKmuEB50FFMP8/bhD7KYY9FZnJbAGJ9xJdf4zWzl8iLCTYJIeEMUYgK61Tou+qsiEeQwbg4SXGBKLZMV5cGmgKDPxqFd4tg3NDzto7RGSHDCxtWHDGZ6BgnXOMBjzotuPGhDcKbLboAXFjXMrT1qLlWl8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB0nQxy1R6X21k7NxUtn2dp60RZTs88uxLhvISkJCgM=;
 b=B4jjDcFk/f26gPR/kupCzaR1j3aFs/lNHPmIcNu0ithFKhfuHJb2IO2mwApg5tDkOyolXFn9Nnp6YuJ8uWTQyfWBdKpcpGPJqpOAFkw5+HGj0Mb5r1NvMbgsaQmQ3tvYAxo2Y47ANkaystC7OvZBrHuC7f/5UyOQdDzrFrBil+YUJB6pj+55aCJTyqlJB7iFdGU42PeVr1k4k51W6zBdZLE0oqdhfMIKI9W63IZfS7/AZj6+QqosL6aL1YaDzDMAurSyucCICBPvrUQDB67Iwtk24InlYuVmFtSZfX7VQvxV5N2jSg16JujK4AueKOohOTP1yJnZ+tz0p2tZeFG+hA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 09:10:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:10:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] block: fix boolreturn.cocci warning
Thread-Topic: [PATCH] block: fix boolreturn.cocci warning
Thread-Index: AQHYFABy9WvinVQI60OYkByTtGY3bKx4JbGA
Date:   Fri, 28 Jan 2022 09:10:09 +0000
Message-ID: <4c3e0a8f-5c53-6978-420c-cac0701fb0dc@nvidia.com>
References: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66bbd767-ff68-49c8-289f-08d9e23dfbf2
x-ms-traffictypediagnostic: DM4PR12MB5230:EE_
x-microsoft-antispam-prvs: <DM4PR12MB52300E876FE902CAAA24A5F2A3229@DM4PR12MB5230.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJ9GOhY2tVH8UNnKj31oVZ267OtGyc2gwH9pTRuIkhJlhtzptnxadWO3tCnbJ+nzH6kt/Pcd8xJuoO/389Ef0zmsxnNsJpT00ndVjQMYCPQn+COwD64XE2T9LrLjZqD1fu4mrlgNhBMLIPQJON/fAQZ45s+aGtdlXubyR75rA4lUOpPOa8QsyDPwe8sk0hHO7Xf2M78UrSp203KQ+XYTY6i2YIHeVwcvHG9DBTqpLLiCEHGPr/30QuKeS1Fk53AibpSSwjvav6RiCiNNP54kjjmUb8uoBteBVLxhq5spVqTmYrBgc1LhVyeY9GJGTwzFR5D5IW3FDu6+8xgooXadk9imnmHWfXWr0+N6zEtF8RJZUauyxZcXVWSLv0kFG6r+Kio6PGM1ZwMmmR04kE01NT4XoPhQEv3I5C/ow/pNmvzz3o31BXnaaXnlgVVPEt/wLy6+JYjriSG1uRbPne0sbwgB+A/wRliCnx/tQKU5iw7mTj7X2uU4O+urxXdX5pV9zG2T6WAYJDjU+EDMtei4e6o3vj4ih1vXwJPjxRCaIoz/jPD/mSgzNDtb2H+TAycx738/Xu83fq0Smccpq3P+g1a8tvs552kjMP86v8/PEPaMlPCsLSx9SOAZAT2dUpl1i2BASGCGfh94nPdLaF6CRPNFxTNM0rvYyWM/rklUdWw7ZaRdOQNxMd3eceFYPeuWZ2cXUOaF5QHcGzc0vF2iAdwSApokYS7NBXFtPCctF6EcHNcZXDORrhAGKq5Ms2iHW1UkDRbEu5Hq7jDSxKUvaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(64756008)(31686004)(8676002)(8936002)(4326008)(86362001)(66556008)(71200400001)(66446008)(66476007)(66946007)(6506007)(316002)(91956017)(5660300002)(36756003)(38070700005)(6486002)(508600001)(53546011)(31696002)(54906003)(110136005)(38100700002)(2906002)(6512007)(122000001)(83380400001)(2616005)(4744005)(26005)(186003)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJyTmtwMEx2MVFLZnE2cm9CTnlNVWhVblBqNjVYNUdFbjhGclptTnFoTUJJ?=
 =?utf-8?B?SHRkbHBMay9XUEZNbGZVTjJYYmx6bFBzUW9BeEhVb1Jrby96Z1dJVmtqTnow?=
 =?utf-8?B?eTVUZ0E4YURxSE5ueTlMYVdRek9WL0lGZTY0Vy9CeWlnMXlWVGkySkoxOWVo?=
 =?utf-8?B?MWRyak9qMndlaHUvTlhCTisxbDhxQ2pMTmxkV1lDVG5GeU4xVzRsRlZzMCtj?=
 =?utf-8?B?OVh5Nm9PUmsvVFlpQUF4R1E5Y3lpdjVGcGZKb0grQVdJS2VGYXg2eSsrODFw?=
 =?utf-8?B?QThjSmtVSCtnOW9mNWNaTk9KeVFJc2RCTzRXZEFBVjJ3YWJyVzNSSVdSaVFH?=
 =?utf-8?B?QU5lVnBYTEc2azhQZ0NvN1hEck4zUytVZGhnMWRzQXBWSjFNRlB4K0hLdWY3?=
 =?utf-8?B?ME1LbitxZnZrZ0tOaE5zNGhhSTlFN3ROVGJTcWdVZDJndFZpZGNNbWVGTUpI?=
 =?utf-8?B?aEVXMTlGbG96UGtZZ0hpbVhLRnVVdUxzVktSRTBXd2RMRDNBTnYvOGdqUG50?=
 =?utf-8?B?L0lyRmk3VXI5S0pQdS95aFVPQlNrQ1QwSTFHdVprQmozdGZTWmpiMDYwblRy?=
 =?utf-8?B?Q2x4bm1PTXFmQy9VMTMvTjFjN1dSQU5NM0w4YzU2OU9EWW9OY0FkUWtzckZz?=
 =?utf-8?B?TEhLczJDR0F5T1UraFN4aGdMK2QvUGZ2c2JZZGtwWk5Pc0lNS3Q5WDNucjg2?=
 =?utf-8?B?aDhrT29jVVc3Y0s3T1F4dmdPbDBveGs3OHpGYmw4bWkxTHBuYnpNSEErMlVG?=
 =?utf-8?B?bTZyUjEzS1NNYS80TFB0cCthd1NCT05GRGFTT1dDVWJNR3FuL01RODdoZDEw?=
 =?utf-8?B?bURLWFpNYjdTMkpuSlphVFFNTVFQNWd6TVBVak0ybWlpOHlVVDhqam9NeTNI?=
 =?utf-8?B?N0E4eHFLRTAxNFp3TGtyblJCZUhhSGpMMDg3MktZUUZybEp1QlNlQlIrT014?=
 =?utf-8?B?K1QrN09WYnBsa2p0UXhqZitEVHMvMzVWN29PVllibGlFWlNaU3JIYjI5eXZy?=
 =?utf-8?B?QVJnRWFXdGErYVp5bEdCdnFPVEZlNE9lTy9HZGQ2MEsvbkF4U0pyRithbGkx?=
 =?utf-8?B?M05KaHM0d0w3MWZpU2JBaVVZd0dCTVFvME9oY1J0NjVzNmc0bVh4bGFWdG8x?=
 =?utf-8?B?U1VsNTRIZHk1MmZEWXUxcTNpMElFVkRBK0NvTHA1NkpzUksxUFd6T1JScHJM?=
 =?utf-8?B?cldSM3p0WFJPeXZ3cFFEdjdZUURSTzdkYi9CQzJ0YmhiVENScVVRZjRkanJo?=
 =?utf-8?B?RHFNUHdDLzIvSkw1VUF5Y0ZpUHFYZnYxNm54Q1VDcndOZGN1NnBUeHFMMnZv?=
 =?utf-8?B?VGl4VnA1WGp3V3o5dkpRWDcrcUR0cDVaL2s2L0l4S0hrZGptQmdkcUtzWW9N?=
 =?utf-8?B?VGVpd2dXMm5nT3gxQzFhQ2dvQW51T2VzOURjVnk5RzVCN1cwWVhnSXlLZzJI?=
 =?utf-8?B?OFl0THN1ZXdYVFB2Q2NmUFlaS3dOSGppbDduUURURVcveFM0Ymx6OHNiT2Jr?=
 =?utf-8?B?RDhDVjN3NnArVXZlNnNTRWJwUmtxdDF0ai9KbmcxM0VpZnFvWHdnbGI0d2tC?=
 =?utf-8?B?U0pITFpmN0V2ZWFpM0l4S05KQnZja290NWtramkvdUpaWm13L0cwSmFRRXI2?=
 =?utf-8?B?ZldMZnVsSlRsMHRvSTVwVlhSRTBSVE1zV3doY1N2NnpCMFFsUlVLMTdTWXNH?=
 =?utf-8?B?MmFZN3ZoT3VwTnk2WVloeTlHb3d3QkxrNW5vNEE5ODFWZ0xUb1liRHhHQmNL?=
 =?utf-8?B?T2lHNEp6ZkZQa0I1YkxSQUhmMkRieWtRa0RxblF6R1ptV25KOWN1M1ZzSC9C?=
 =?utf-8?B?cGhJSUNYWFZoS3cvRTJCUnVkNnVINXU2QXBlZUdVVmNidmV4WTZlV0JCZ1V6?=
 =?utf-8?B?aTZEWXVPZnJ6ZFBReTNDM3ZML3hEWTJGOWhveFc5WjJXTzFhKzJwVmNVaS80?=
 =?utf-8?B?M3RGT1N5Y3BaTWpiRnBLaDNWMnVObWlYdU41a3BDN1piVmg5RFhZY1VnR0pv?=
 =?utf-8?B?Sld6YWhiekpZUWRTNFlnQmhXZEMwa3l2RXBVRzU3N0ZGMlJIZ3pnZ1kwNkdr?=
 =?utf-8?B?WU5NN0c3a0NZeUczeEpsVlBhckFzWEJ3Mmdwa1pNdzkzM1ZYVEZGQi90WXlp?=
 =?utf-8?B?a09GeFV6aFRtV05DYUdEdXFGd1JRNStYTHYvQWlkSTdrMklneHBaS3FiZjJo?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FAADBFA028A924ABE501C77F6853AA1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbd767-ff68-49c8-289f-08d9e23dfbf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:10:09.6844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NASVviNnZ3ynC9k1CsvL4Ticog2ULj8A68PKeDVIfXHsyN3UpDegoY3q3cRrO26jso+OIoCjWnppyTTjhMAyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNy8yMiA4OjM0IFBNLCBKaWFwZW5nIENob25nIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IFJl
dHVybiBzdGF0ZW1lbnRzIGluIGZ1bmN0aW9ucyByZXR1cm5pbmcgYm9vbCBzaG91bGQgdXNlIHRy
dWUvZmFsc2UNCj4gaW5zdGVhZCBvZiAxLzAuDQo+IA0KPiAuL2Jsb2NrL2Jpby5jOjEwODE6OS0x
MDogV0FSTklORzogcmV0dXJuIG9mIDAvMSBpbiBmdW5jdGlvbg0KPiAnYmlvX2FkZF9mb2xpbycg
d2l0aCByZXR1cm4gdHlwZSBib29sLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxh
YmFjaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmlhcGVuZyBDaG9uZyA8
amlhcGVuZy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQoNCkdvb2QgY2F0Y2gsIGxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQo=
