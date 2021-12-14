Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0B473D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhLNHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:24:23 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:52801
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231464AbhLNHXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:23:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=galMajMxoWQimj2HxRXU+7pvlf9ULWxXRE6WJNCehSXVW7ydE3QuvXXHdhTpPIRM/xlFZ8Wln3VNxJqHq1Kyq3JYifTS5V9VjFhp7rAJxn2ejtqzTfU3NoRuiTOlaU4lJt5nqaleUfuc2YYZfv8HEMqPCQeARo3xGpnoboPGFOJtUkFKBVomNVfGlapgOzQTYISFrMDXxswyK+TlsEfaGWtA9Kxzbo+O/TmhYDl4+j7BWRifuZCyITcEfAkwfJJXEsy6rgCEPRbtM7oANYoe0pweNBoSLreMAPi0J/M3bJlibKDsf/LFSSZWX6otH4SEMPOB0uUVoAzOrv5HPTC6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhqMFbYEff3fMbCFJwfk/nSAmaNTE/Qql9j9JWCzNjU=;
 b=HGFSNr7EbbH6SHD/RxTLh3+lKatkZPPA1ciDQxHafcY6DGPU6UfE6QBbQW6MtrBfzan40eWlk3Abh/QrOCU6b80C1u41a6mwZOCAzFPRtqFRULrqTcYwaIHOvY4Ltrkey17Pp8clBgaJlgYlK3idJyhj2wthccnGs6pr+wj24vYyF/pl+4uU74DhFWsxH+3IpU5dOizEYFblroEAKT8s0sZRz6xTiIoEtXzUyxgX7pbxwbutfvn7H4OsUVlvMKWZ5xzTFG/xazQwYxxSzYrj/k/B6NLjskQm3MSbqMn6IiHCP/ofTR+hGT1d+w8MlbNnqzVKs7YSZPPhQz4fr8afww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhqMFbYEff3fMbCFJwfk/nSAmaNTE/Qql9j9JWCzNjU=;
 b=gzbot+it2ldmEFu1U/9RrcUUak4l68kdPJQtChFk/n3/9tZg1COuIdB2D7Y2GHAbQI3mbOR62c82SAdg2J5TsJRm9ch4uy+jczBqN6yP2atf8TCrHebyql6CVZPB318J2PiLMvlkELpM0zw/nBpw0llBk1MN9ChOf1fEgaiwqLt3viAY9fLgIMYtNwl5z4n2HOgB3H/EP3Kv7kJRoeDjylG3wN+h7EHI025AHhXcgaExBF1RT7MTBdxizKhkOfVbmyGN/hsF/9zax9DEahg0QiWpnm82jNAY8Wu4z+v0X8CRzk1hui+QPdTXC2kVR/5KdhzFNehhBQvgJb+C+Lb5aA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1326.namprd12.prod.outlook.com (2603:10b6:300:10::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Tue, 14 Dec
 2021 07:23:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:23:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Thread-Topic: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Thread-Index: AQHX69QZLuJDiNiHDUudpz9uyNdwZawqxxaAgAANoQCAAHWzgIAAtPSAgAEit4CABFZogIAAJu8A
Date:   Tue, 14 Dec 2021 07:23:50 +0000
Message-ID: <47a32b46-2c9b-2f27-4100-af69b34f2df5@nvidia.com>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain> <YbL2uUqV0GWFOitE@kroah.com>
 <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org> <YbSCYyAv1SmYy7mz@kroah.com>
 <a4b285ba-4a46-c94b-444e-d3c4f42c42c5@acm.org>
In-Reply-To: <a4b285ba-4a46-c94b-444e-d3c4f42c42c5@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8633da7f-9c51-42d7-8b06-08d9bed2ad12
x-ms-traffictypediagnostic: MWHPR12MB1326:EE_
x-microsoft-antispam-prvs: <MWHPR12MB13265A6854959F31B9EB45F1A3759@MWHPR12MB1326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfSu+uO3UI/B9gaGaKUIGeEQpHA2IsWB35q+nekDEcDZE1ZryWXCSDQcERucsxhqUZJB5Cl17mRSHEdI8Lofy1HwrwcMlLpR5xWiANe0FLXKuDGWejHeBxnHabYYYND8rm1iOmZ8u0kN2jVtnfZ6OTROqOIlAV/3Vznf2QlgGQDYMSkQcAJRq8jV9irZLBiwCs9Dcb2FqmkVJYLQQ6ULtLVcGVl//03/c00YAF8MogCnLGnPnfakQY6O7RU6sKiF7Epx0HiHGViegTwkeP3YwHkd7CSDginSC3Q3IAKhGXJhQ5kze/Sr/7A/9yNr8logXlkIZ7YGJl1NRPLR1Cg5+0z4BZ/bLvHMJWmqO3mlGcuNMEuonlHlwSYU12SyxCf5cwofMxdyAGR3a1Vv0TI6h09BJV0sQat0V7Xqg7jXQh7ECJgPxyHdf24h0e6T3GNl0A0Eq/JlmkicfMui9di+bpV/5yQ6IvvpNOY4HZQi7cYhVX/XdB/NwOS3Y5cySXfQQrHxYMkl4v05/14LusLD2JZubulY4g9bRP5ihTzeGkybVaX+IfO8pM2riBpUK0aYEWFZIEsAmY3AiMa46ndvz+ue8JwpTwYbzooe068S+H76WTUZISKDOc54FsDfHoW0nH0Vs9Y3Fb2G4HtCGeO8n7nQZPxgyBgJZZBRj2KYjvrJJz4F9ZG3Pip9AcQmm/On2SJzTWyvbgxgCM2HQQkvFCtx0Iiod6YKAkqbxyXqtqQBRZr1jgJo0I8fYhFTqJY5Tf4a2ucWw22254Jj4p40HtF46+sNGkqChQYn8wFpaKJGQ5RVBgapMTNKcRIeLg5mGPMBALg6p/vcovKovviUbRUmNmVqV89leDAPUZPvDuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(38070700005)(966005)(83380400001)(4326008)(4744005)(316002)(31686004)(8936002)(5660300002)(8676002)(66946007)(186003)(6506007)(53546011)(36756003)(122000001)(38100700002)(2616005)(91956017)(66476007)(66556008)(64756008)(6486002)(31696002)(2906002)(76116006)(110136005)(86362001)(66446008)(71200400001)(54906003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckRqRHdHOW4ycW85MlNrOFUzV0p0Y084SHJBNjRwVWxNRmdmMzJUVkRpU1hV?=
 =?utf-8?B?OVBFZklnM2xreHh4S2ZSQU4wRDYveGl1dmhTQjZjaUE3NDJjT2kyMlBoU0d1?=
 =?utf-8?B?SEJCLytlSG9tL2NsdWtRZ2pXSnpzNnBBNDdsSGliZ3BWbjRiNS9GWElCc1Zv?=
 =?utf-8?B?K0RENFdwNzliTHdydWg1UEhQZFpQaFROem1McGtBelhrVi9YU3UxU3NxUE9p?=
 =?utf-8?B?cFlSWUg2aU4zdk9vR1JSWG1WazNoKzd6VXVKTjVqUkptVnExT3hValVWbkIr?=
 =?utf-8?B?Y1NrRmVDSjh6K2JJYWtkbmdjSGVkbEYybzJPMmlrMTZNQlUrSjJBemxaSGxq?=
 =?utf-8?B?dVE5bEFSWTFGVHV1TnptWnJielBLMEZ6aHdMSEp1bEZNc0t2aGs2ejJOSklp?=
 =?utf-8?B?UHN4cXJQcHdOdUFEUU9hb005NmgwSklsWjlveFY3YkRQbU5FeGZSRzRVQyt0?=
 =?utf-8?B?clpOVi9XRkFNb2VXNm5rWXJ1ZkRWT280VzFaK3p4clNYTnhvZGVIZ2JaM2FQ?=
 =?utf-8?B?WURKQTJHajc4a1FZWHhyRVpTdkp3b3o3ZkdSdUlBeXJpMDdFUEVDN0MrWldG?=
 =?utf-8?B?Ulg2T0cyR1U0Q0hrUFIyUlc1dDBrdUMxcThjK3ZWT1NIV3F3ODZ3Sm9PYThJ?=
 =?utf-8?B?QXB2c2x1UWxHMDVCbVVYdUlrOTdxQUhrQWc5clVyUkI5U21oN0pId0Y1TFpS?=
 =?utf-8?B?eE9hQjBHRjlQNWVXNFFuRVlwNnhuUlBGM0F1WGdYODc2cXNBNmNaK25BOTJW?=
 =?utf-8?B?dHQrcnd5czUzRGtpd0UybUNWQmYzMVBtbHlyZ1hEYnBWcmpMclpjVk9tcXUx?=
 =?utf-8?B?Ujh6eklWTWorMTFlaHVDcDBHMzFIVHlqdFRTYlN6Ky9OdDNMem5VdmYrd0pT?=
 =?utf-8?B?TFg3Q2tvbkNIbmpJdlpWT3pXZzh3ZUpwOUJoRk9ONjk4VVA2RnVzeVQxcXVo?=
 =?utf-8?B?MmkvTHVhL3J1NnBuamV5ZktzcTJjY2owbVhqVkxFMldJRW5VYzY1V2pobS8y?=
 =?utf-8?B?T2E4Si9OSmF2elVRNVhuWGRablF6S3VlbUI0Z3RuQzZRZ3hPcDFRWUt0TnI1?=
 =?utf-8?B?WG5ISlRwN0wwRldua0FYQ2dhSVhUSmJLRzg4V1hYUlBaT2N2V2NhY0I1V2Nx?=
 =?utf-8?B?dzhmZTRNbnprTEZXM2s4Ym5RYlVNNGNmd2dOSVpObmFwbWxUMWZUWGpFdWRv?=
 =?utf-8?B?NnAvTW1wcmlIbisrTnZ2ZzBPZjIwT3pXS0FsV2FGWmlPbzBHcHoyRVNvdVFn?=
 =?utf-8?B?WTB1WWN2MFhSRkgzR1FNOTRmR3BwdEVBMXBLeHVGazJuenNIbkVtbWo2dXQr?=
 =?utf-8?B?OXZTTENKcDJIbXhnZzIxT20rYm56MzJySWl2ZlFpVVNEYW9ESklpSFdkZHM0?=
 =?utf-8?B?NEduVjNMVWlRZDhXRGpsays3NXNrZ1RnUDNJc2l4MXNSNnI4bTVLUHUzOHdu?=
 =?utf-8?B?T05CSzdvVy9UNlhxQUlnRERreHpiZy9FbzVsWFJ6ZnpSUUVlTXJpU3lkNnly?=
 =?utf-8?B?VXEvcE5tQi9YU2RHbDlFKzZ5N2JBdTcwUDhvaU1BMHRvckNoQkpZUkRqTDZ4?=
 =?utf-8?B?VE15dzAxMGk0OVpzWWFiS3N3RkZjbFRIaWUxNVdXUHVnb3BUTENzM2VuUi9y?=
 =?utf-8?B?c1lCeGxDeEZMTVduMFk3Q0dkMzlTM01nSTZ6aHkxTUluVjEzZ1ZzUnpIZjhH?=
 =?utf-8?B?VUpudW1JeVgrMWZjUVEwTi9GZDZCL0ZrUG9tTUNoOVk5ZWZiL21ISENjNU5y?=
 =?utf-8?B?bkl3NTdETzkxajhxUjMvZVVzUmRYcEwwU3psa3dFWklPU0JlLzBsdkN3TXRs?=
 =?utf-8?B?blZIZHBjZnlHWTJVVUZSQXVna3p0YmpzQTRLaHpuZlQ0RkxHc1dUWDVHTnNy?=
 =?utf-8?B?RkJKaGg4NnU0d3RUTUZVMmJUWDlHTTRYWitKd1lOdE1PWUJ4aFR5aVlCbjZ6?=
 =?utf-8?B?WVA2VmtLcFVUaElpUXU3bFdnRFUvcHdpNTR2ckszd1QyUTRjM3k4R1dzOEZk?=
 =?utf-8?B?STN2RCtGQkFSOWsxenA0UHBZN0xYcS9ZbDFXM2xzbzRMZ3FKRVo0cjg1MURO?=
 =?utf-8?B?OTEyZzRXUlJubGx5S01lWUYwRmVnc0JjclpreVQzZytMRFJUWk43bTZUd1J4?=
 =?utf-8?B?QlVRT0dGOUhFajBIWjRURjV4UTVrcmswTGhTcmcySUJYQWt3QjhvY1liSWtZ?=
 =?utf-8?Q?lSJInUVMOtnGZ9iH3a7lCyKk4DNXeHoDzqa75kT6wgc3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3F374B2C142A7429B434657921E74E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8633da7f-9c51-42d7-8b06-08d9bed2ad12
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:23:50.4819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Csb9K2l++0h63aJKuQZMSVOHWBZkbcJ10Ng+th/D9eydtQVVprEF/jQU5QLUp7u+0LqdxPEeTegT1CNtYq9KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1326
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTMvMjEgOTowNCBQTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IE9uIDEyLzExLzIxIDAyOjUwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+PiBPbiBGcmks
IERlYyAxMCwgMjAyMSBhdCAwOToyOTo0MUFNIC0wODAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+Pj4gKGIpIE5vIG90aGVyIGJsb2NrIGxheWVyIHN5c2ZzIGF0dHJpYnV0ZSBmb2xsb3dzIHRo
aXMgZW5jb2Rpbmcgc2NoZW1lLg0KPj4NCj4+IFRoZW4gZm9sbG93IHdoYXQgdGhleSBkby7CoCBE
byB0aGV5IGhhdmUgbXVsdGlwbGUgdmFsdWVzIGluIGEgc2luZ2xlDQo+PiBmaWxlP8KgIElmIHNv
LCB0aGV5IGFyZSBicm9rZW4gYW5kIHdlIHNob3VsZCBjaGFuZ2UgdGhhdC4NCj4gDQo+IEhpIEdy
ZWcsDQo+IA0KPiBUaGUgb25seSBvdGhlciBibG9jayBsYXllciBzeXNmcyBhdHRyaWJ1dGUgSSBr
bm93IG9mIHRoYXQgcmVwb3J0cw0KPiBtdWx0aXBsZSB2YWx1ZXMgaXMgdGhlIHF1ZXVlL3NjaGVk
dWxlciBhdHRyaWJ1dGUuIEhlcmUgaXMgYW4gZXhhbXBsZSBvZg0KPiB0aGUgb3V0cHV0IHRoYXQg
Y2FuIGJlIHByb2R1Y2VkIGJ5IHJlYWRpbmcgdGhhdCBhdHRyaWJ1dGU6DQo+IA0KPiAjIGNhdCAv
c3lzL2Jsb2NrL3NkYS9xdWV1ZS9zY2hlZHVsZXINCj4gW21xLWRlYWRsaW5lXSBreWJlciBiZnEg
bm9uZQ0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0IGNoYW5naW5nIHRoZSBiZWhhdmlvciBvZiB0
aGF0IGF0dHJpYnV0ZSBpcyBhbiBvcHRpb24NCj4gYmVjYXVzZSB0aGF0IHdvdWxkIGJyZWFrIGV4
aXN0aW5nIHVzZXIgc3BhY2Ugc29mdHdhcmUsIGUuZy4gdGhlDQo+IGh0dHBzOi8vZ2l0aHViLmNv
bS9vc2FuZG92L2Jsa3Rlc3RzLyB0ZXN0IHN1aXRlLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQmFy
dC4NCg0KSWYgcG9zc2libGUgcGxlYXNlIGF2b2lkIGNoYW5naW5nIHRoZXNlIHZhbHVlcy4NCg0K
DQo=
