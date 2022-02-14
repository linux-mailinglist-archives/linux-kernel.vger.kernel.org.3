Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04A4B54D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355874AbiBNPcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:32:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiBNPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:32:07 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90075.outbound.protection.outlook.com [40.107.9.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD0C47567
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9V1FYkG2n58z+x2lDjIVdcJHyMNrJXs6WoE75r6IoHBAuJAN1XWoH93kMLDqc9yeGKnPA1rPjDjVrARpuVWrIRPq2mifA7BJv4YHywJAwBMqwIxeRm8eZykab+HGacG7RFaXTp5cJXvyZM++yXG4/U/kUkxUy5A3/BJMwygLHWsLnjmlJ7Chh/VcyWiEP8F8DQ7eNQ0rbDXMAL4JPFGoU+HaxQhexn1Yg7vjdqwhIrnWKX/xLkZTJE1hl37C901wM4U+4PP1xJUXswxz2rTX5JJpTnxtkFGlAIemLF4IcZE+8hzQf1+MknMn3nRJPy4dAJXjo2s4hwj5rzxQsbX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJrhfaKF5CMe/0NanwWPYTCKsHVGucr30sP+EFFL5o0=;
 b=JWXMJLZtO3/8425TpvKs8RU2VTeRog72gQgArpbo1VKOO5z5bUuZm6S327D8/bNjJ7ZHdBwlL2XHkq8oDzu0HAgB6pbiQgkevEk/17OUn9Rc5h6BQ737Gj/zCgkZBBnFzzZlKFEehHOFSoD9tsjCCjzgGPBWcLC3l6crLESo/Xxk4kbjup18Y48wPLkpjZkZyQLlor1FgjcKOApwnz7+iJvs4v7vZ0Dr/j9HQOxAa4I0vTGpou5U6+TXa7czkpfoZRMpeFfJNLQt22QIfAohFdw/WlX+96+C3r+IJDass1Mq16cjtO1l2UQRXx5z1qbMRXE/IJGdVB//uJvnF2tVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1633.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:12::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 15:31:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 15:31:56 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Anshuman Khandual' <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v6] mm: Uninline copy_overflow()
Thread-Topic: [PATCH v6] mm: Uninline copy_overflow()
Thread-Index: AQHYIWvihpEL6XdIL0a0KjA537qokqySzsCAgAAbLgCAAB6+AIAACuYAgAAQD4CAAAN2AIAABg+A
Date:   Mon, 14 Feb 2022 15:31:56 +0000
Message-ID: <3fb6ecb8-5c40-7ff4-4a55-7ea5ffad9962@csgroup.eu>
References: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
 <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
 <1157d90c7335458cab4ef471c63a1d52@AcuMS.aculab.com>
 <3b8270fa-b89b-30c6-c1b8-285645215276@csgroup.eu>
 <f487114af1444881b495e0002de491b2@AcuMS.aculab.com>
 <ae9c5df2-0096-fec6-4416-cbbcc99f33ce@csgroup.eu>
 <05aa3859a0a24a0bb5e3c0affe1eb8b2@AcuMS.aculab.com>
In-Reply-To: <05aa3859a0a24a0bb5e3c0affe1eb8b2@AcuMS.aculab.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d8ab38c-829e-4f2c-9719-08d9efcf2272
x-ms-traffictypediagnostic: MR1P264MB1633:EE_
x-microsoft-antispam-prvs: <MR1P264MB163333330178A1CA84EE3008ED339@MR1P264MB1633.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24qbkOyslPgFJK9SkzQVNuiNC96uyXkDr36yRHTu5UBQF7IP0jA4HYwrFX9DFKji1CUFcfn9q0EjafH9YeBt18uKXcFJMpN31QxvvpBPS7cEvaQwSZSMHMt+D36i0NlHZdTyhTEcI9Rv1XN6hZ56B4YbCivSmJGOglviASDdC+1L8rwW2xHM2sgFnSD/0CBacEPJd3O+MYYAikLJq+g+ZyatBrItxekJxvrj84hwYP+w8EuHMVtioPSByrXXhTrXhJWMriJRYi9mreQh9/O8I6La9lB2N77oC9qkbEvtSEGrzbmquZBO6pNnClWWjQf8VPBMLC5gyE2cq65ei8SX19b6veikEuEZqRkSD+rbrZsx8aJO+9D/72mFnjI76UvFzuKO9PaNyQccY3hmzxQqwlKlNrZZMYxWykXkd8w0IpizplS72MglOjjgFShrO01SrlHOWCvJhLTR+wQgvjhy3CgOCopnWtEnXqFoXLNuVFcsZtE6WXM48ibtDW2xgBYC97C5kr5+wdLXrhZZ5B/WSDblT9oYLijWSKznQoHrHjFhB8g8RtNc1ZxDSWDA1drNNC/4Wx7/lI+C0sWQrcS56sCV0u2v1CmCVPcspUAjRfpngeggaWo0MvY3flKd1xrpfUJBWnfWuw3gGChcjXeIVzejYSei+qlbVJ48O3uCmpgn9Ibe9iq9Xm5CSbAKV90dC+c0HWwWnt/HJxb4CEYK6T41lzFm5q8geCUtEU5AFzEXEy6iXYiP8GTRX49XmbxAwEhvMouzokJz5lZu0c9ieA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(66946007)(4326008)(8676002)(76116006)(31686004)(66446008)(66476007)(66556008)(8936002)(64756008)(6506007)(71200400001)(66574015)(508600001)(316002)(38100700002)(5660300002)(44832011)(54906003)(110136005)(36756003)(31696002)(6486002)(86362001)(26005)(122000001)(6512007)(186003)(2616005)(83380400001)(38070700005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0dGSkRqT2VWNGNmWkluRDFKdWE1KzFyNHR2cGs1WnFGRGRneDV6ZHdVaEJM?=
 =?utf-8?B?alBoaDZCM2JENnpBMWVDSGRjNW9RcDVQUjdzUWE0Q0Z0dE1PTElETDQ5Y01D?=
 =?utf-8?B?dStFTlZTVWM4TDZEdFN1ZitsRnhkdThodTVGMW4zZS9PdEE3YVQ2WGNSWTRY?=
 =?utf-8?B?dUxhSFdEY3BCL3preUJJd1dGTkRzRmJPR25NK29XK09zbUlibk15TnNVSEFU?=
 =?utf-8?B?ak9aS3g3MTBhYkxhOVZwRFZsNldFdDdpNTdRMTFKZ2tnSExTNVhmTzU2RVlS?=
 =?utf-8?B?ZXlvMitKYkRRV2tNa3hnOUVJK0RwSThBZVY5MklLMlZPQUJIU0tkQXpYNXR0?=
 =?utf-8?B?L2x2aGZBZVBmK3RVR0VLcEdkQWowOUtrS3FGR2Fmdk5sdVdQdUhIdzJXUERi?=
 =?utf-8?B?aFd3dk1KK01KR3lHUU9BaHduMmc4RkFCZ2poaDNINVBxVzV4WmNqdlRxTytR?=
 =?utf-8?B?Zy9SWnBCcEZGZ1lzcUJoMTZJZFI0dFNxcEdFemF5TXoxVmJUK0dnc0FENzds?=
 =?utf-8?B?aW9mSWR0U1dWSFI4MlI4TjZpWUtlNWhZSEhJOGtYL0Nlc1hrM1UrWHBDUDJx?=
 =?utf-8?B?U0c0L3k1eXJ4YTIrSmFTSEJYNFhOVGsyTDdKaFlmOG82MTBGL0ZWU1hpVk1t?=
 =?utf-8?B?Z3E4THVIS0puaS8vK1BENngrRGcwbzlGK09vc05OL1pwd1Q2bUhncFJLVnZR?=
 =?utf-8?B?SENlWCtvVUFtY3o0OHRWSGtOanU3LzFEU3VVeTIrbDkyYzFDVW5yVk1TTkFH?=
 =?utf-8?B?disvRFI5R2k5eGxDVTZ6OU1SNkhsaHovam51cDlXVDdKUElXQ2k1bzFlVDRa?=
 =?utf-8?B?eFh3WXdkdGc2VTQyZlorb0RaZm0vakl5UlFGOENRcTJSeW43UFM3ajhtNDB0?=
 =?utf-8?B?TzBmUFoxN1RUYXhEUEVGT24yRktEb1BPa2VuaG5BaVhQQi9DMUM5ZjVYYTM5?=
 =?utf-8?B?b05CbWtIbGoxRnFhK1ozV2Y2bVhTaVR5anhybndvUmxtcmxnRk5ZMzFXZ0FF?=
 =?utf-8?B?VnptY1ZseTdGVnRuS2VqdWZUR0xGLzVPQ2h6NlVLNm5vd09yYlZQNndjQ3dr?=
 =?utf-8?B?Ry9KaFVpU1I4NXM0bU43Yk1pWTRuQnlZTEs5WUlHcVZIRVptQ0xjRmMybC9R?=
 =?utf-8?B?N2txQWM2aW5NcXVXZmJaNkdYc2tZb2VyY1JIVnUzWDNSWDBVZ3h2NUppbm4y?=
 =?utf-8?B?Vy9ES1dxMkVpdGYwZFFPZ0QzeWpJeDBUYitpak5FZVhDdlBUNWpsemt3OGlC?=
 =?utf-8?B?SEJRZHFZbTVZS1RyWlptdXRxeVBxUVBadWhlUGtzK0RiMUtRMFRqQ2FWYVhY?=
 =?utf-8?B?QzRYcEFvM2FCZzJNcEQvSnM4enFaWHV6czRlTkRpdmR6QUlDb2FPL1JUallj?=
 =?utf-8?B?T2Y5RFZYektLUWFBcXVDVjJZMUs2aDA4Qk52cVVES2UvMXgxc1BuNVJYYUd4?=
 =?utf-8?B?R05EWXRZRlZZekNSWURxUXFQNEJtZDN0czJ2WkdycVhReWVTR2o1S2laRlF1?=
 =?utf-8?B?WWZjMWVHT20yQlVPVk4wdkRMVUJqTHBvU1U2Q0pLVUI3a2FQS3BhTE0rVHAw?=
 =?utf-8?B?RU1YeXBNZ0VqWFZ2ekhjczNEME5JalY4bEk4V3RINXl4TjVZdUhOeXFCNW1H?=
 =?utf-8?B?Sm5DbzhoaEZxM0Z2TmZHN3hMOEhPY2xOWWw5dGlhZG8rMGgwNkp3YnRDUS93?=
 =?utf-8?B?VHdtSUhaVU1jQkd2R1RVZTVSUzFoT1MrQ2p2bU9SMWhFUDYxMVZ4VW5zZSsz?=
 =?utf-8?B?eXB2YkNIVWU4N2F1K3R2RExVOWVFSmU2Nm1WUEZaeWlWMUJUNEg1dzVlZDJ6?=
 =?utf-8?B?M2NUSXFrcTB0UHZkdWF6MWM2YkhiUlUvUkVWRmJQcEkwdTFQdTdKYU9rMzU0?=
 =?utf-8?B?VENOeDk3ekhZQ1FDZHZJaUY1Qit0QTNqQUdhV1BBMDYxSlU5bWxEVlYzRlA3?=
 =?utf-8?B?eHFSbDFzSlJ3OE9TYnBrdnBMdGJsNlhoQjZzUlkvMThLY0lFYTFUVjVVOWlZ?=
 =?utf-8?B?VzBVS25zVUp4VittdHJmYkNYVUMrWnZkbi9VdkpsVysweFRjeXpxSlZIWjY5?=
 =?utf-8?B?MGkzN3N5M0pTUHE2SnVwTlFKSjVDVXpSTGVCK3BSWkM3Qk96TGc1aEJYKzFY?=
 =?utf-8?B?d2NTQ2QrNEd3ZWZibGswYXF2d3dwRld5KzVCa00xY1VMM1VlVElrYTUzanZB?=
 =?utf-8?B?djVXa0tGeDJJMkwzd1laV2RuL0xoeG9hSDVaKzlOajI3VUYvWGRoUTdDbVNl?=
 =?utf-8?Q?KFi4zFswvlXYTbR4Da7WedjO/vg5C0WGIgoAwjCFZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55F19D6347042D42B0E936C35A02D486@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8ab38c-829e-4f2c-9719-08d9efcf2272
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 15:31:56.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjlDy4W2M29u23giW/Em+/rxSq9RP+7SSGix6/mRXIC4kNkYFJ03ijj1VCkcfw6sc7JQ+AvmwQ/GW5egMhf9u8ebaSnWBJ1FONexriqEtVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1633
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE0LzAyLzIwMjIgw6AgMTY6MTAsIERhdmlkIExhaWdodCBhIMOpY3JpdMKgOg0KPiBG
cm9tOiBDaHJpc3RvcGhlIExlcm95DQo+PiBTZW50OiAxNCBGZWJydWFyeSAyMDIyIDE0OjU4DQo+
IC4uLg0KPj4+IEkgbWFrZSB0aGF0IDMgZXh0cmEgaW5zdHJ1Y3Rpb25zLg0KPj4+IFR3byBhcmUg
bmVlZGVkIHRvIGxvYWQgdGhlIGZvcm1hdCBzdHJpbmcuDQo+Pj4gTm90IHN1cmUgd2h5IHRoZSB0
aGlyZCBnZXRzIGFkZGVkLg0KPj4NCj4+IFRoaXJkIGluc3RydWN0aW9uIGlzICd0d3VpJywgdG8g
J3RyYXAnIGFuZCBnZXQgdGhlIHdhcm5pbmcgb29wcy4NCj4gDQo+IEkgd29uZGVyZWQgd2hhdCB0
aGF0IGRpZCA6LSkNCj4gQWx0aG91Z2ggeW91IHJlYWxseSB3YW50IHRoZSAtLSBjdXQgaGVyZSAt
LSB0byBjb250YWluIHRoZSBwcl93YXJuKCkuDQo+IERvZXNuJ3QgV0FSTigpIGRvIHRoYXQgZm9y
IHlvdT8NCg0KSSByZW1lbWJlciBzb21lIGRpc2N1c3Npb24gYWJvdXQgdGhhdCBpbiB0aGUgcGFz
dC4gV2lsbCBkaWcgaW50byBpdCANCnRvbW9ycm93Lg0KDQo+IA0KPiBJIHdhcyBsb29raW5nIGF0
IHRoYXQgbGFzdCB3ZWVrIGJlY2F1c2UgdGhlICdzY2hlZHVsaW5nIHdoaWxlIGF0b21pYycNCj4g
dHJhY2UgaXMgIkJVRzogeHh4eCIgYnV0IGRvZXNuJ3QgaGF2ZSB0aGUgJy0tLSBjdXQgaGVyZSAt
LSIgbWFya2VyLg0KPiANCj4+PiBOb3QgcmVhbGx5IHNpZ25pZmljYW50IGluIHRoZSAxMi0xNSB0
aGUgZXJyb3IgY2FsbCBhY3R1YWxseSB0YWtlcy4NCj4+PiBBbHRob3VnaCBhIGxvdCBvZiB0aG9z
ZSBhcmUganVzdCBnZW5lcmF0aW5nIHRoZSBzdGFjayBmcmFtZQ0KPj4+IGluIG9yZGVyIHRvIGNh
bGwgdGhlIGVycm9yIGZ1bmN0aW9uIC0gYW5kIHdvdWxkbid0IGJlIHRoZXJlIGluDQo+Pj4gYSBs
ZXNzIHRyaXZpYWwgZXhhbXBsZS4NCj4+DQo+Pg0KPj4gWWVzLCBhZnRlciBsb29raW5nIG9uY2Ug
bW9yZSwgbWF5YmUgbWFraW5nIGl0IF9fYWx3YXlzX2lubGluZSB3b3VsZCBiZQ0KPj4gZW5vdWdo
Lg0KPj4NCj4+IFRoZSBzdGFydGluZyBwb2ludCB3YXMgdGhhdCBJIGdvdCBhbG1vc3QgNTAgdGlt
ZXMgY29weV9vdmVyZmxvdygpIGluIG15DQo+PiB2bWxpbnV4LCBlYWNoIGhhdmluZyBpdHMgb3du
IGZvcm1hdCBzdHJpbmcgYXMgd2VsbC4NCj4gDQo+IERpZG4ndCB0aGUgbGlua2VyIG1lcmdlIHRo
ZSBmb3JtYXQgc3RyaW5ncz8NCj4gVGhleSBvdWdodCB0byBlbmQgdXAgaW4gc3RyZGF0YS5yby4x
IChvciB3aGF0ZXZlciBpdCBpcyBjYWxsZWQpDQo+IGFuZCB0aGUgbGlua2VyIG1lcmdlIHRoZSBy
ZWZlcmVuY2VzLg0KPiANCj4+IFNvIG15IHBhdGNoIHJlZHVjZWQgdm1saW51eCBzaXplIGJ5IDM5
MDggYnl0ZXMuDQo+Pg0KPj4gQnV0IHdpdGggX19hbHdheXNfaW5saW5lIEkgZ2V0IGEgcmVkdWN0
aW9uIGJ5IDM1NjAgd2hpY2ggaXMgYWxtb3N0IHRoZSBzYW1lLg0KPj4NCj4+IFNvIGlmIHlvdSBw
cmVmZXIsIEkgY2FuIGp1c3QgbWFrZSBjb3B5X292ZXJmbG93KCkgX19hbHdheXNfaW5saW5lIGFu
ZCB2b2lsYS4NCj4gDQo+IEkgc3VzcGVjdCAjZGVmaW5lIF9faW5saW5lIF9fYWx3YXlzX2lubGlu
ZSBpcyB0aGUgd2F5IHRvIGdvLg0KDQpUaGF0IHdhcyB0aGUgY2FzZSB1bnRpbCA4ODliM2MxMjQ1
ZGUgKCJjb21waWxlcjogcmVtb3ZlIA0KQ09ORklHX09QVElNSVpFX0lOTElOSU5HIGVudGlyZWx5
IikNCg0KDQo+IFByb2JhYmxlIGFsb25nIHdpdGggLVdpbmxpbmUuDQo+IA0KPiBUaGUga2VybmVs
IHNob3VsZG4ndCBoYXZlIGlubGluZSBzcHJpbmtsZWQgd2hlcmUgaXQgaXNuJ3QgbmVlZGVkLg0K
PiANCj4+PiBNb3JlIGludGVyZXN0aW5nIHdvdWxkIGJlIGNoYW5naW5nIGNvcHlfb3ZlcmZsb3co
KSB0byByZXR1cm4gdGhlIHNpemUuDQo+Pj4gU28gY29weV90b191c2VyKCkgYmVjb21lczoNCj4+
Pg0KPj4+IAlpZiAoc2l6ZV92YWxpZCgpKQ0KPj4+IAkJcmV0dXJuIF9jb3B5X3RvX3VzZXIoKTsN
Cj4+PiAJcmV0dXJuIGNvcHlfb3ZlcmZsb3coKQ0KPj4NCj4+IFllcyB0aGF0J3Mgc29tZXRoaW5n
IHRvIHRyeSwgYWxsdGhvdWdoIGl0IG1lYW5zIGNoYW5naW5nIGFsbCBjYWxsZXJzIG9mDQo+PiBj
aGVja19jb3B5X3NpemUoKS4NCj4gDQo+IFlvdSBjb3VsZCB1c2UgYSBkaWZmZXJlbnRseSBuYW1l
ZCBmdW5jdGlvbiBzbyB0aGV5IGNhbiBiZSBjaGFuZ2VkIGluIHN0YWdlcy4NCj4gDQo+IAlEYXZp
ZA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNCj4gUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcyk=
