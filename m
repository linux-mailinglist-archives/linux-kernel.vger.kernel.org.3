Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3048DE1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiAMTbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:31:09 -0500
Received: from mail-dm3nam07on2047.outbound.protection.outlook.com ([40.107.95.47]:35216
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231237AbiAMTbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:31:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCipy2cVm++q9IbRz0U7Q5TojrWB4YpprkxmYR5bvnyd8por/0sEczdjX8VXYMhrbZcCdHjfN3Kj33IaIpE4//tXsaRncJV6KPSFToh1dIBp0kWMOH9bsSxdiTwt3/p/+sJ8CWo62/TergQ6Za0CeSZ5wrcW542UDnxV9jnUhBUee7LjFeDQjCMvRrgh1vxHblPfm7396WMwfo6MTAA9cShppuxMdP4Gu1JF9YVpJyhP0QkIGXe4s46fjE9DQL2VWVSKzSKp7rQhtERPD26lgyU/cL5MNmWz4DNJq94CWPPOSGyH5nFGGqP4/ekspRCJDlICkoPfFMufBeXuuAnhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZInvT3T2VG7obMXDcYonG4zskdsODt0Vn6+3xVSgbg=;
 b=oThnfgYlD3sA9vI/l2067XKlOzg1JW67BI0Y0NlC3uzK98VloRF0znFUKd6sPJlzmzkMlswgKyMDG0twb8ZoJms0lMl6HPn0mBNqdAa1cB2ogfps7kwuPwKd1pxY6Aps0rWPUVniMQs4v0hyBeSQ23pPV2KMfq7UJ6q2G8e54IUYEUi1eT/F/V+iPy0DkRV7v7xdlpWUDvkX3oAbUfhZh70HrHwKSm2JEiaRTgV4yAlF3bVCIRHWihbW1Xmwl7KW3ZxN4MNy/1SqSnDSlc/7lPO7zB2dQums5V9V8MTxEnPNRfefSat64rkdr1ssdli6jbJ8rfMx1bNzSh6Sd6zcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZInvT3T2VG7obMXDcYonG4zskdsODt0Vn6+3xVSgbg=;
 b=FAEs9cUgx163mPzsO3GC5lx/RkRUyWer1J/kFZJbCokDPkwOk3dlxBt25usl9Kc73NVBVWyFBpV7eyfCKg+iRO/0qjRNe+j7iGBG3jJdrLW/3EE/JHnmWAp79yThknNROD5uIilskKvQHDXTZHgB29wql0LQTgTmpswJUnu3iByCAmWui8q0x2QFBKJEQfg5VIAkRd4cRYFPT/RNmYJpcp8wDX0d3t75MRjs4NpQHangzsrfGZYtkI0oX1pR7XUgEBlKPh+DdVXtcGlDyRJUaeb68y1NHSmfGXJHbD8KH3Kfu4CiDNXquW0vfGxtUndZQ5FkSDEivzc5XjZfVmwsqA==
Received: from BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 by DM5PR12MB1499.namprd12.prod.outlook.com (2603:10b6:4:8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Thu, 13 Jan 2022 19:31:06 +0000
Received: from BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::35a1:8b68:d0f7:7496]) by BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::35a1:8b68:d0f7:7496%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 19:31:06 +0000
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [GIT pull] irq/core for v5.17-rc1
Thread-Topic: [GIT pull] irq/core for v5.17-rc1
Thread-Index: AQHYCJ9AzonJzIc80k6Mu0LEzduHc6xhVveA
Date:   Thu, 13 Jan 2022 19:31:06 +0000
Message-ID: <dc342ecda69fab39d754c0ba71ae1ca472320611.camel@nvidia.com>
References: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
         <CAHk-=whvPxG2Sje_OBSeDODiD68ke+ta118xeYskNxkv-kAtyA@mail.gmail.com>
In-Reply-To: <CAHk-=whvPxG2Sje_OBSeDODiD68ke+ta118xeYskNxkv-kAtyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2 (3.42.2-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d64f40be-a8d9-44e3-f3f7-08d9d6cb3e4f
x-ms-traffictypediagnostic: DM5PR12MB1499:EE_
x-microsoft-antispam-prvs: <DM5PR12MB149916AFE5554CED5DC1E4CDB3539@DM5PR12MB1499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkIGHMS+uVvV7VTpbrhDcNf7v90KnwtYKRV+Eyu6yR7ocZlNVYaLKoRfkKeXypjj1j7YUCiiuo1VoWAyPmw2IuZ3sGg8L84T9ISN276HKJVgvosBfSo8vFJNpvTwdhodJ5hWPSuHOVE95NndOP8iNsfUT4+iPYSyfeekrKdvKnaVGlYyHmybVZOvnczQt6rdDcMN8eBVFwuR+86/mwz6Ot36Yi/yDpDif+gGXiYCa85L2XVqgCeCjQcZspbhKZBLBpnDXR6vjxtt4071XQ1HblYP8lPLfKoXI+RN9Wg0roV3ZnyDGZI0NBlYrkn6SBd+R3RFzTn8FtjhBoYr/MTT+83xX4AG8bBB1OnRfr42OLpRMSEMt5lpGr4Bb6Tmq/n5hpqFOaIaDppxO7N1qIWHwFCQ3oDAjSkSX1nzKqFBWGpAM3NjkmSK8bnDpfUqjXjI5oAK6UQRNyKpJRTXtbBuvAtJmrDUcP7K7o9AUMVXvtmUfXKsGgJFNu52haft8f9c3S5GAIhwoeJBqnOurK7mnjOR4kQ5x6N9Eu1sk/Zj8DmVi7gkMtzcT6uJ6H+csO8zrPpxFVx+P3MCxJFf1l2HvP0QdJo08jtQmn33ozpG/wMSao6AjR7/3wANdNPf3DcTqFSsoUAuY6mmU1k54zOFTltSL/mji45WIr0GgXf2fIG+X4LYEHwnOOSpQ9/Ucz38PhvudHMT2OWRW4JWk418/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4209.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66556008)(86362001)(316002)(64756008)(66946007)(6506007)(66476007)(53546011)(71200400001)(66446008)(26005)(186003)(38100700002)(36756003)(4326008)(122000001)(6486002)(8676002)(8936002)(38070700005)(2616005)(110136005)(508600001)(4744005)(83380400001)(54906003)(6512007)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzBJUEFtdWxhUUI5S3EzUzBhWGdPKzBlaDRxUFpFTUlWMjdGYWczcU0xMzdV?=
 =?utf-8?B?SXN2c2t6N0ord2NzbkJHbkdOcFl1YjZVb2FGTGV3RitQcWlQL1ppaTZhM2F0?=
 =?utf-8?B?bzBKWmlKOXZyNkliYmxja1BKTGswRDBqZTdiWUNoZ21lbWxRYjVqV0xZMVlJ?=
 =?utf-8?B?YkNiUWdBVVloNDFJTnlPUS9GWGtHNGFmakVJZGh4QXA4dVZkNG5IejhGQXRK?=
 =?utf-8?B?dmxMbm5mTjlqTWpTU1RTTXh2bjhRd0d2aXZIZUJ4N2lZWjdOYzNuNVd5Ymth?=
 =?utf-8?B?bUhhbERGdTU0TVZvUTZOcXlBMXhIZ0loQ1FSalJaRFZFRk1yYVpjQ1VNYmFT?=
 =?utf-8?B?VExCVEFYcnZ3SDFxRnVFZllpdkFCNENldVZxVXdodjZDM0ptZnp6TXJOK2Yr?=
 =?utf-8?B?eEg4T0pVOU5IQXBFVDMydDRDc0ZhazdWbUIvL1d0bThuZlV6RWxpRnd6bTUx?=
 =?utf-8?B?M0I2TVNiODRXNlAxZDNjNGJGNzV1c25VdDdyL3FVK0VEL0pzNEZXaEk3bjlV?=
 =?utf-8?B?UnFWeGhORmxTY21lTk0yK1Z4SS9ObzFwT1diSHRlM3pYOW9RNGZHQ2k0cmJT?=
 =?utf-8?B?ODk3UGJ5TmxtUHBIZnV6WTJ3TTdOcVRzZXRESUJ0dDZUS2pXOXJ4MEZMcnJs?=
 =?utf-8?B?ZXkrSXJvam4xNlZaQ21QWm8wWE5lVGkxVy8weUY4MFgxc2FVdjVlMG8zUmM3?=
 =?utf-8?B?ZTZMSTdzaUt0S2p6T3IvMjdnak9DMTdNYUdnaTZYSW5PZWNvT25jQ1loRHVa?=
 =?utf-8?B?Umt5Nm9KdEtlTENLdWRzZHMreERUeHF0VkpRTTdYa1FMOG1rdTdJTWZKQXI4?=
 =?utf-8?B?amFGbGtNbnlNS2ZONXBzSlkvQ3l2UEVQaU1zd04zV1FpNHhuQXZ2WnNBYjUw?=
 =?utf-8?B?RTdDVEd1ZXhPcnhiRmVhZ3R3YkhhNXRjMWRpOGNIRXNOWG1PeWpFUHlUZ1dZ?=
 =?utf-8?B?K3ltazVSbUNGQ0VMMDBMeVVacitOQjkrZnAxemJXV2s5WVZJNkcxUXZoT091?=
 =?utf-8?B?b1EwS1QySnpnWkRJQmVTS3ZQQmJMdTBsUlFXWVhYM1dDZjR2ZnArMlFTREVW?=
 =?utf-8?B?ZnUzYzcyOXhTbEJBcVlLVXg2YzZCa0xNWE1DVnZKZnNnbXY0SjJ2bFRDMENu?=
 =?utf-8?B?V3B4blZmdmRTVW5PazBkM0xVamI1MHdkRnhHTnJYcXhlejZhQ016ZUpSRGsv?=
 =?utf-8?B?ZjJFcTdRMWEyWTlFOVg4WDRIM0NGNHd2KzROOFA3T1BOaE5kb0xKRklwNkl6?=
 =?utf-8?B?L0J1Z1AyOUVFdXRnWU14UU1kYjlGNVRBc1VxZmc1Zi9ZZDk0VkdycFlXQWNW?=
 =?utf-8?B?RXdRb1V3cUlSWm4vYWNEeUZ5ZmN0M1NpWGlYbDYwdEtna0tGMGNBMEFlWnlP?=
 =?utf-8?B?Vm1CVWUrSzlTYWdSVUZ2WCtQcGVtOFp5Q1ZFOCtud05jYy9wMkhkOTZ5c095?=
 =?utf-8?B?U2x1c3R3ZThvZEowN3ZZblZVRlZ3UG1CNDBZVVM5dDZNYjJkbVVmWnVlR2Ja?=
 =?utf-8?B?RU04Q2YyamJsbWptRlVZSXh1cGlkdm5HNjBpaGtQRFZ0TE5BVUxvVmZHQnJD?=
 =?utf-8?B?Z2puT2tKbThQa244K3VRTmVUTC85UTkvRkZNRTlobUJGdDlJbSs1N2dqNjNM?=
 =?utf-8?B?YWdOYWZSdjM3NzlXUkVzeXFyK09qK3JHem9kS0NMWWc3VzJYcFIyalZJSmha?=
 =?utf-8?B?UGhzalJvckVKa1VxUFp3S1A1LzZocVRKSUlJTWEvTUR2V041MHcvWFdtcHJE?=
 =?utf-8?B?NmhPRFA3WFBvQy9mMkEyZFR2Uk5zRUVRanlKL0RXMXEwNEFvVTY4NEhsOWNX?=
 =?utf-8?B?dGpmdHI2aWhiZHlmOVZPV1FwYnczeCtObGlZdWJtbHpTN2lIaGlXTWdXS2ht?=
 =?utf-8?B?Ny9QTFhYZkhVeWFCdzZHVDlUemZsZUpHR3ppek9tZTNwTVpsWFI5bGFlNmt0?=
 =?utf-8?B?R3F4N0V4R3gralo2Qy9NR0NSQjNQTHA1dVQ0ZlRXemhYckN2VHM5VDRJVXQx?=
 =?utf-8?B?dHdheE9na3JTUWJPdy9Hak1xWDc2NDhOaFk0dDQ0MmdwZFBnVkdFaE5TQWcz?=
 =?utf-8?B?U0YwaUV6UVF3MkRhcWtiOEZBK2ZBYTc3K2RMK29HNU5rMmt0LzNMSVVsZDh0?=
 =?utf-8?B?RkpRc3hVVmVDMEw0SGFTRzZpK2R1WDJvOGtMV2dOUk5CTk1ubUxpMmVkZmdI?=
 =?utf-8?Q?x+dS9eRWD0Bgn19Uwr2pan0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F238672D7F1CD846BDFD24BEA26CBC06@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4209.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64f40be-a8d9-44e3-f3f7-08d9d6cb3e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 19:31:06.0987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbQsWUtcdJgAo0mmhz2Yht8QUYxB8yFsYdycQlWI4YYVVySPVHBiMI4YDEGPcxISkOkj3bi4xz9neLyeoHMgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTEzIGF0IDA5OjAxIC0wODAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gVGh1LCBKYW4gMTMsIDIwMjIgYXQgMjoxMyBBTSBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gwqDCoCBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgaXJxLQ0KPiA+IGNvcmUt
MjAyMi0wMS0xMw0KPiANCj4gSG1tLg0KPiANCj4gSSBnb3QgYSBjb25mbGljdCBpbiB0aGUgbWx4
IGRyaXZlci4gSXQgbG9va2VkIHRyaXZpYWwsIGJ1dCBqdXN0IHRvDQo+IG1ha2Ugc3VyZSBJIGNv
bXBhcmVkIGFnYWluc3QgdGhlIHJlc29sdXRpb24gaW4gbGludXgtbmV4dC4NCj4gDQo+IE15IGNv
bmZsaWN0IHJlc29sdXRpb24gaXMgZGlmZmVyZW50LCB0aG91Z2gsIGFuZCBJIHRoaW5rIG1pbmUg
aXMgdGhlDQo+IGNvcnJlY3Qgb25lIChhbHRob3VnaCBtYXliZSB0aGV5IGVuZCB1cCBib3RoIGJl
aW5nIGZpbmUpLg0KPiANCj4gQnV0IEknbSBqdXN0IGFib3V0IHRvIGxlYXZlIGZvciB0cmF2ZWws
IGFuZCBtYXliZSBJJ20gd3JvbmcsIHNvIEkNCj4ganVzdA0KPiB3YW50ZWQgdG8gcGVvcGxlIHRv
IHZlcmlmeS4uLg0KDQpCb3RoIHdpbGwgZW5kIHVwIHRoZSBzYW1lIHNpbmNlIG1hc2sgaXMgTlVM
TC4NCkJvbiBWb3lhZ2UhDQoNCj4gDQo+IEl0J3MNCj4gDQo+IMKgwqAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL3BjaV9pcnEuYw0KPiANCj4gYW5kIGluIHBhcnRpY3Vs
YXIgdGhlICdlcnJfeGEnIHJlbGVhc2UgcGFydCBvZiBtbHg1X2lycV9hbGxvYygpIC0gSQ0KPiBt
YWRlIGl0IHVzZSBpcnFfdXBkYXRlX2FmZmluaXR5X2hpbnQoKSB0byBtYXRjaCB0aGUgaXJxX3Jl
bGVhc2UoKQ0KPiBwYXRocy4NCj4gDQoNCkFncmVlZCwgY29kZSBzeW1tZXRyeSBpcyBhbiBpbXBv
cnRhbnQgc3RhbmRhcmQgaW4gbWx4NSAhIFRoYW5rcyEuDQoNCg==
