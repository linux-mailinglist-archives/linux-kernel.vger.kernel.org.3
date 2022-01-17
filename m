Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8550D490826
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiAQMFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:05:22 -0500
Received: from mail-gv0che01on2126.outbound.protection.outlook.com ([40.107.23.126]:2208
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239522AbiAQMFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:05:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izPFYe6aKVbmNiynn2ausAco6EI5XzJa8PR1DhL7WLDaz+6YErVOV6U620SQemRedxufeDzOh6rvlJ7EoIuDOuNzQmGdPwDwzC823ji9J/7qYdQkDMoL8Po2rL1YIbeHL7DFcvw2Gr2hCWBEIvRnMhPNMFOKrgxhocDimbCuRvdv2mt4g4KgPaAt1Pa/fOdsxzuhEcR+7y6YEtJAPJ6CTfp+IXJgZfo5Y43nkz0yw2/AnY838mYD1AAJQnTj9lpLHaW/Opjo1Idok9GGfxDmYHbAulb3Z4ZifE+HaIH8E+b+aLIIEQ/tzB7FvSt8vxm49gVc+pzJhjaV/60W31DTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+oh5uUJnSzq1Y9MNJwT6GtdmWh9G0kyaEZraD7yVUg=;
 b=daCHD1X//Cn1wcUqVS5x0FAKGgZ1SkHFi6eOkv9cNgGHimnxE9mgWBj+BP6ZcfqXKJHbV/brIDD4LtqykNeAo4xWhuGcp2zxZsQRhRryBhu7ZAooNW1kHNLtWo+p/t+qqXbC0dGFZGHYN0TC2fO+WMn5QQWkYcGBSTRmiIFHDKzpfx7yDvT2/Z5gIseYYowQT1sx4fhT2ZvGzNtJsYEOtelZ/6AWhDDk/phsHDiIQD07WcjWqwCM3jNVQqZPOXV0rd4jK7hEGnXB9XcFrDFCaelmX5QhMo60EbnWehY/N2vlu3xWuXW+AwG4+/jIi3y4rjtwvngTdU/7ZQmRBrN6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+oh5uUJnSzq1Y9MNJwT6GtdmWh9G0kyaEZraD7yVUg=;
 b=LecgZ67cdki09UmkUWSAPMDM7CT6Iw8SKr5KURdwxYLTW4B2NTY5urnP1w6SVSDeTcb0HC7b73q2a4P+LxOMv3EzfkiHyadpMSPAmfWSyI8FdqxJI6ZWtuT2L1jOVR3/M4Y6x2pqtnyooXAKF3HH1W57CHi62wh2XZ7zVtS8/q0=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0621.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:40::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 12:05:18 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee%8]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 12:05:18 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>
CC:     "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH v2 05/11] arm64: defconfig: rebuild default configuration
Thread-Topic: [PATCH v2 05/11] arm64: defconfig: rebuild default configuration
Thread-Index: AQHYCVE9pwqeJh1r00qcEEQBSlToLKxkUKsAgALRroA=
Date:   Mon, 17 Jan 2022 12:05:18 +0000
Message-ID: <a5cfdd2ea149490abeb481c7a85d59019ea3c620.camel@toradex.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
         <20220114141507.395271-6-marcel@ziswiler.com>
         <060a9f66-fc00-2247-46f2-1c700d0e9bf3@canonical.com>
In-Reply-To: <060a9f66-fc00-2247-46f2-1c700d0e9bf3@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d98966ff-3a70-45c7-05e6-08d9d9b1a0e8
x-ms-traffictypediagnostic: GV0P278MB0621:EE_
x-microsoft-antispam-prvs: <GV0P278MB06212BFC2C49BB6DA3542AD7FB579@GV0P278MB0621.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFE29MNxB3kFHBYKuA6XQaHq2uRg3bbPAh7QdHsgkmfORzQ5r7xec9pcUG3dCySH3/TYKRxACXglbMXg0sIUNWbF3syFH+6KJ/neUxuUSz3OF8HDesadcCIHINkYhqTwocY/0uIyxUJhLp8rnwg+JEZuiuC1sr6s3Qi77HaM/whR6ohreOvjct0BQJCHLoIUeTYVu0iRc6L8YSnA+lSV8UNnWcGoCYyOpfheSJoYoBYkZs+m2fDjsfTib8oOau6m8afarUiDWp0qYXamflWh9e91LjO2cb9ZCC33Lw+SrfuwDU68slR/KQiIdybG1zBc+mxNEGhNZljpVOiSQoycQA8uUv+MrUrsRWTuUJdCU52ut1WWSJnxO4dEaTrGntUxWZNpkS1efM6cDCKgKItYKN1c0PnlFxulDoVC1tuIu/xjMQH8p1g0kVR27GfP3Xx9OTLoqqdDZ1ciwavNqUQc6mH5rzzo+AxB0o9785RnuwOfg61K3nFzp6Im0sb7bun2a+MeCAFpB0Fkkh27bP0P3WfiQhbszCMO5G8INcHxJ95rz+3KasTo4UGzNjoXhVMXhgsFZ12D+rEefO4XXu6xCgn05TwjSMPIXbjLuQRom8fyFBY3e2spQWiRSgdexf5KJ0QL68eyJIlCDl5KVyH4TLNhAxYnWqm3wIDS8WkzgSnZlQEAMrEtCLoUXDzRlt9IDkhMBMuPZIgoq92eCPQMlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39850400004)(396003)(66946007)(66446008)(64756008)(36756003)(76116006)(66476007)(6486002)(66556008)(83380400001)(26005)(86362001)(8676002)(38100700002)(122000001)(6506007)(53546011)(316002)(54906003)(38070700005)(4326008)(8936002)(110136005)(2616005)(186003)(6512007)(5660300002)(508600001)(7416002)(2906002)(44832011)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnVwMUY0eldnRnhjSVppbTJNVHQ4aTlSdzdQUTBSQ3RZa3gxZUNNQUtjaW5i?=
 =?utf-8?B?RFJ4TmtiWFVUUS9aU1dBd2FnRjNFd1BqWEVpRGY0SE02TU9DdUZiUU1Qc1pw?=
 =?utf-8?B?Q0VtY2xkYzFCVy9VcTJiejYrbjl1RkN3UTNLeG9sdExnNVJpaDl2R1YzeXJT?=
 =?utf-8?B?eFlKWThRdm9FSVNtalh6Z3Q3aTJhbUQwcTJ6K3BXUHRMamV4NGljNkg2R0lh?=
 =?utf-8?B?VktHdHZ4NWpUeTFiMDJDd25iTWZ3bEpPN1V6STAwZkRWSFdwUDUwem5xN3Za?=
 =?utf-8?B?dGdkQW5UOVBDK1o0WWhyOEVhN1JoZWxuamdLTUxXNlJqQ09Nakd0emdIZDIz?=
 =?utf-8?B?c25Xd3BtTlc0RVBMb215c0Z3alBYYUlSbjBjQmVnR2kzTGtGRnNhNVQ0Q2dq?=
 =?utf-8?B?eEdSOGd3N3A4Sm51QWlhR2ZFMk5seWNUU2FiQnVrb255YW8rcnFLb2xSZUp6?=
 =?utf-8?B?anJxZ1JRaFJBSGVLQUF2R2hudnQzeTZvdGlXczdpdUY0Yk9jalpHTHE4dkF5?=
 =?utf-8?B?S1BjN2kvcjB5U0lZTkRUV1VGazlkRFo5Sjc4U1ZxMnRsTGh3U25nNHNxWmhH?=
 =?utf-8?B?K0xwb0xzUEhha1MwUWdkbEQ1dVpIZkpIYkxEbG92V0dtNFloQTQzcFVLVmhl?=
 =?utf-8?B?Ykk5UFV5bXV5Rm9LWkovSUx4ZjVUNXlwYzJmbTUzcUlXcjJRZUdWUWZJNUcr?=
 =?utf-8?B?V1EyelFYWVZ0OWRoMjFWeVJRZ1MyZDlzemplZExJMzZPSnVHekc3aVF0TGZL?=
 =?utf-8?B?Ukd3dEVmb05sWFhVZTZ4RTVORStqbXlqeEtpUHFtdkM3cWFwb3FHYlBLMk5B?=
 =?utf-8?B?aHQwTURISWtuMnNrejZOWFFieXExUU5vTkdCVUNUM05zd29Fb2IyRnBiSXY4?=
 =?utf-8?B?cnZYTjJiYk5BS2NHa1BSWVBmZ0UzWjZnWFdDYkZXbVF6ZUIrZkdaV25PZm40?=
 =?utf-8?B?cEdMeWhNdllKTlBUd29IaFVubjRYN01mUm4xenhxNk41NCtFcTA4RHZjdUM4?=
 =?utf-8?B?VXNTa2d3K240cWxOd09kSmRBbHZLUTZ4MDhILzlQQnZBM0ZielVhcVE0ZnhX?=
 =?utf-8?B?Mi9DODRhWGJsODFIdUR5VjhxM1hIU3pTMG83bUNkTzJESUpkaEZKS0xVSngz?=
 =?utf-8?B?MjNCcjdUOTREazdyVHpoZmViTlRUemhibWtoQzlhZ1luY3UzQm1ja2ZXUC9G?=
 =?utf-8?B?Y0U2ZFc5cHNiOU5jYytPd1J5dFl4SUVja2J2cTJXaEZERmExbmhKd0lGMFNk?=
 =?utf-8?B?dGVqcUMyVFdpdGs1N2p4VXBIUFF1QXltcDBMWmU3dnhPOWs0MFVYRVJnNGZN?=
 =?utf-8?B?dXZIV1Y1RXdkeFVHTmpvT0ZZcE9GVm9KcVJ5WG9BdnpXZzNZUlJZL2MxUDRF?=
 =?utf-8?B?aDFCK21DN25BamdrQkpLLzlDS1Z2OWQxdGEwY1dhSStYUUZiaXJ2M1JxSitu?=
 =?utf-8?B?R1BneWNkVlE4alR4Q1MraTVOcnljSy9zSWZHMXB4MXFMTXJHMjFhc3hWckZD?=
 =?utf-8?B?OG9Ld1lXY3FlOWt5OW1OWGlNaHhoRnFvNjVTaGtBWlJmZHJpR0hTTXUwYUJV?=
 =?utf-8?B?N3dXbUpwdVIyODNjWVlaY3hJZ3RNVE1RcFByMWphc1Rnd0wxTEZHd0J4Wmxy?=
 =?utf-8?B?blBROVl0TzhnOURYd01mVTgyamdlUnp1Y3JScWpUZzJDT3YvdU9mRlVhNThw?=
 =?utf-8?B?YktENXQrbndEZTh2SVl2Z0VBMlE2N2ovSDZteVZNaDNMY3VJRDNvWnNjUm44?=
 =?utf-8?B?ak5iSWJ0Z2Fnc3VRNEhOeVJVT05mcXhTSkc5ZjFNTTZqbE9ScUtKQlN2bGtj?=
 =?utf-8?B?WG4vOVBsdG56WW1ZdE5uSnNYbUlBM3hWUzBsVWZ6UWRQVC9RVE40TEZHK1hF?=
 =?utf-8?B?WGdQYjVNUXBqSGJzYlhkRW9MZE1kd0ZPTkpDRHU3VHQza1hUWkRnWHNqNkJF?=
 =?utf-8?B?TXp2bEFyZmxFeTYwTGErWmVQSXdnSm1DWDlUL2VEZmZyQ2tyN210ZUs1M1JE?=
 =?utf-8?B?TVdObWJ6NkVPOGhpaEdaVmZlN0VCNThBQWsxeHlwVzN1bUlGRXcxOGZMZjBy?=
 =?utf-8?B?NHZBZFNyU0NmbDAzZTRabm1GTVdkdTZUSU5yQy9JRlRDZ0tvQ1JiVVM1RUh6?=
 =?utf-8?B?VmJyVDJIcHFXV1h3c2hBVkhERUM4WG5JbUtjY0FjZ3JBZ1RyQW5Wb0lDUGY5?=
 =?utf-8?B?WFVpTDg2SXkvcmZSdDB0d2crS1E4SVA3M1lJVVdxWUxoa1VVQUxmM3JJWFVD?=
 =?utf-8?Q?+hG+B3SxAjyKylT0FK/gCoZvmgCrjCo3onmhm4wqrw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88ED8C341347814F997362B9E51CADFC@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d98966ff-3a70-45c7-05e6-08d9d9b1a0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 12:05:18.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPeCTbj/5e6gn54ciuWssYaGDdJf/2j0taxPdXIpnqW47vG5gPEn0SiZPizAZivk9HKehmF2qgkc+Jn8mIXG6veTJQB9+cktWxIn+185LfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0621
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTAxLTE1IGF0IDE4OjAyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNC8wMS8yMDIyIDE1OjE1LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gUnVuICJtYWtlIGRlZmNvbmZpZzsgbWFrZSBzYXZlZGVmY29uZmlnIiB0byByZWJ1aWxk
IGRlZmNvbmZpZy4NCj4gPiANCj4gPiBUaGlzIHJlLW9yZGVyZWQgdGhlIGZvbGxvd2luZyBjb25m
aWd1cmF0aW9uIG9wdGlvbnM6DQo+ID4gDQo+ID4gQ09ORklHX0JQRl9KSVQ9eQ0KPiA+IENPTkZJ
R19BUk1fU0NNSV9QUk9UT0NPTD15DQo+ID4gQ09ORklHX0FSTV9TQ1BJX1BST1RPQ09MPXkNCj4g
PiBDT05GSUdfUkFTUEJFUlJZUElfRklSTVdBUkU9eQ0KPiA+IENPTkZJR19JTlRFTF9TVFJBVElY
MTBfU0VSVklDRT15DQo+ID4gQ09ORklHX0lOVEVMX1NUUkFUSVgxMF9SU1U9bQ0KPiA+IENPTkZJ
R19FRklfQ0FQU1VMRV9MT0FERVI9eQ0KPiA+IENPTkZJR19JTVhfU0NVPXkNCj4gPiBDT05GSUdf
SU1YX1NDVV9QRD15DQo+ID4gQ09ORklHX0NBTl9GTEVYQ0FOPW0NCj4gPiBDT05GSUdfUENJRV9M
QVlFUlNDQVBFX0dFTjQ9eQ0KPiA+IENPTkZJR19NVEtfREVWQVBDPW0NCj4gPiBDT05GSUdfU1BJ
X0NBREVOQ0VfUVVBRFNQST15DQo+ID4gQ09ORklHX01ESU9fQlVTX01VWF9NTUlPUkVHPXkNCj4g
PiBDT05GSUdfTURJT19CVVNfTVVYX01VTFRJUExFWEVSPXkNCj4gPiBDT05GSUdfTUVTT05fR1hM
X1BIWT1tDQo+ID4gQ09ORklHX1FDT01fQ1BSPXkNCj4gPiBDT05GSUdfUk9DS0NISVBfSU9ET01B
SU49eQ0KPiA+IENPTkZJR19TRU5TT1JTX0FSTV9TQ01JPXkNCj4gPiBDT05GSUdfUU9SSVFfVEhF
Uk1BTD1tDQo+ID4gQ09ORklHX1NVTjhJX1RIRVJNQUw9eQ0KPiA+IENPTkZJR19URUdSQV9CUE1Q
X1RIRVJNQUw9bQ0KPiA+IENPTkZJR19BUk1fU01DX1dBVENIRE9HPXkNCj4gPiBDT05GSUdfVklE
RU9fUUNPTV9DQU1TUz1tDQo+ID4gQ09ORklHX0RSTV9QQU5FTF9CT0VfVFYxMDFXVU1fTkw2PW0N
Cj4gPiBDT05GSUdfRFJNX05XTF9NSVBJX0RTST1tDQo+ID4gQ09ORklHX0RSTV9MT05USVVNX0xU
OTYxMVVYQz1tDQo+ID4gQ09ORklHX1NORF9TT0NfSU1YX0FVRE1JWD1tDQo+ID4gQ09ORklHX1RZ
UEVDX0hEM1NTMzIyMD1tDQo+ID4gQ09ORklHX0NPTU1PTl9DTEtfU0NNST15DQo+ID4gQ09ORklH
X0lQUV9HQ0NfODA3ND15DQo+ID4gQ09ORklHX1NNX0RJU1BDQ184MjUwPXkNCj4gPiBDT05GSUdf
UUNPTV9XQ05TU19DVFJMPW0NCj4gPiBDT05GSUdfQVJDSF9SOEE3NzRBMT15DQo+ID4gQ09ORklH
X0FSQ0hfUjhBNzc0QjE9eQ0KPiA+IENPTkZJR19BUkNIX1I4QTc3NEMwPXkNCj4gPiBDT05GSUdf
QVJDSF9SOEE3NzRFMT15DQo+ID4gQ09ORklHX0FSQ0hfUjhBNzc5OTU9eQ0KPiA+IENPTkZJR19B
UkNIX1I4QTc3OTkwPXkNCj4gPiBDT05GSUdfQVJDSF9SOEE3Nzk2NT15DQo+ID4gQ09ORklHX0FS
Q0hfUjhBNzc5NzA9eQ0KPiA+IENPTkZJR19ISVNJX1BNVT15DQo+ID4gQ09ORklHX1FDT01fUUZQ
Uk9NPXkNCj4gPiBDT05GSUdfTVVYX01NSU89eQ0KPiANCj4gVGhhbmtzIGZvciB0aGUgY2hhbmdl
cy4NCj4gVGhlIGJlc3Qgd291bGQgYmUgdG8gaGF2ZSBhIHNlcGFyYXRlIHBhdGNoIG9ubHkgZm9y
IHJlLW9yZGVyaW5nLg0KDQpZZXMsIGZyb20gYSByZXZpZXcgcGVyc3BlY3RpdmUgdGhhdCBtYWtl
cyBzZW5zZS4gV2lsbCBkbyBzbyBpbiB2My4NCg0KPiA+IEFuZCBkcm9wcGVkIHRoZSBmb2xsb3dp
bmcgY29uZmlndXJhdGlvbiBvcHRpb25zIHdoaWNoIGFyZSBub3dhZGF5J3MNCj4gPiBhbHJlYWR5
IGVuYWJsZWQgKHJlc3AuIGRpc2FibGVkKSBieSBkZWZhdWx0Og0KPiA+IA0KPiA+IENPTkZJR19N
RU1DR19TV0FQPXkNCj4gPiBDT05GSUdfU0VDQ09NUD15DQo+IA0KPiBJcyBpdD8gSSB0cmllZCBu
b3cgb24gbmV4dC0yMDIyMDExNCBhbmQgaXQgaXMgc3RpbGwgdXNlci1zZWxlY3RhYmxlIGFuZA0K
PiBub3QgY2hvc2VuIGJ5IGFueXRoaW5nLg0KDQpIbSwgc3RyYW5nZS4gSSBndWVzcywgaXQgaXMg
ZHVlIHRvIHRoaXMgd2hvbGUgcGF0Y2ggc2VyaWVzLCBnaXZlbiBpdHMgaS5NWCBtYWluIGZvY3Vz
LCBiZWluZyBiYXNlZCBvbiBTaGF3bidzDQpmb3ItbmV4dCBicmFuY2guIE1heWJlIGZvciBzdWNo
IGRlZmNvbmZpZyBjaGFuZ2VzIGl0IHdvdWxkIGJlIGJldHRlciB0byBiYXNlIHRoZW0gb24gc29t
ZXRoaW5nIGVsc2U/IE5vdCBzdXJlLA0Kd2hvIHdpbGwgdWx0aW1hdGVseSBwdWxsIHN1Y2ggY2hh
bmdlcy4gQW55IHN1Z2dlc3Rpb24/DQoNCj4gPiBDT05GSUdfQ1BVX0ZSRVFfR09WX1NDSEVEVVRJ
TD15DQo+ID4gQ09ORklHX1FDT01fU0NNPXkNCj4gPiAjIENPTkZJR19CVF9IUyBpcyBub3Qgc2V0
DQo+ID4gQ09ORklHX0ZTTF9NQ19CVVM9eQ0KPiA+IENPTkZJR19NRURJQV9DT05UUk9MTEVSPXkN
Cj4gPiBDT05GSUdfVklERU9fVjRMMl9TVUJERVZfQVBJPXkNCj4gPiBDT05GSUdfU05EX1NPQ19G
U0xfU0FJPW0NCj4gPiBDT05GSUdfVVNCX0NPTk5fR1BJTz1tDQo+ID4gQ09ORklHX1VTQl9YSENJ
X1BDST1tDQo+ID4gQ09ORklHX01GRF9DUk9TX0VDX0RFVj15DQo+ID4gQ09ORklHX0NPTU1PTl9D
TEtfWllOUU1QPXkNCj4gPiBDT05GSUdfU0RNX0dDQ184NDU9eQ0KPiA+IENPTkZJR19TTV9HQ0Nf
ODE1MD15DQo+ID4gQ09ORklHX1NNX0dDQ184MjUwPXkNCj4gPiBDT05GSUdfU0xJTUJVUz1tDQo+
ID4gQ09ORklHX0lOVEVSQ09OTkVDVD15DQo+ID4gQ09ORklHX0NPTkZJR0ZTX0ZTPXkNCj4gDQo+
IEFsbCB0aHJlZSBhYm92ZSBhcmUgc3RpbGwgdXNlci1zZWxlY3RhYmxlLCBzbyBwbGVhc2UgbGVh
dmUgdGhlbS4gSXQgaXMNCj4gcmVkdW5kYW50LCBidXQgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRo
YXQgc29tZXRoaW5nIHNlbGVjdGluZyBhDQo+IHVzZXItdmlzaWJsZSBzeW1ib2wgd2lsbCBzdG9w
IHNlbGVjdGluZyBpdC4gSU9XLCB1c2VyLXZpc2libGUgc3ltYm9scw0KPiBzaG91bGQgYmUgc3Rp
bGwgY2hvc2VuIGJ5IGRlZmNvbmZpZ3MgaWYgdGhleSByZWFsbHkgd2FudCB0aGVtLg0KDQpXZWxs
LCBidXQgZXZlbiBpZiB0aGV5IGFyZSBhbHJlYWR5IGVuYWJsZWQgYW55d2F5PyBXaGF0IGlzIHRo
ZSBwb2ludCBvZiBzYXZlZGVmY29uZmlnIHRoZW4gcmVzcC4geW91IGFyZSBzYXlpbmcNCnRoYXQg
dGhlIGNvbW1pdGVkIGRlZmNvbmZpZ3Mgc2hvdWxkIG5vdCBiZSBnZW5lcmF0ZWQgdXNpbmcgc2F2
ZWRlZmNvbmZpZz8gVGhhdCBzb3VuZHMgcmF0aGVyIGNvbmZ1c2luZyB0byBtZS4NCg0KPiBTZWUg
Zm9yIGV4YW1wbGUgY29tbWl0IGEyMzE1ZDNhZWE1OSAoIkFSTTogZXh5bm9zX2RlZmNvbmZpZzog
UmVzdG9yZQ0KPiBkZWJ1Z2ZzIHN1cHBvcnQiKSBmb3IgcmF0aW9uYWxlIHdoeSB3ZSBuZWVkIHRv
IGtlZXAgdGhlbS4NCg0KT2theSwgSSBzZWUgd2hhdCB5b3UgbWVhbiBhcyBpbiByZWxhdGlvbiB0
byBhYm92ZSBtZW50aW9uZWQgY29tbWl0IGJ1dCB0aGVuIGFueSBjaGFuZ2UgdG8gS2NvbmZpZyBk
ZXBlbmRlbmNpZXMNCmNhbiB1bHRpbWF0ZWx5IGNoYW5nZSB0aGUgYmVoYXZpb3VyIG9mIHByZXZp
b3VzIGNvbmZpZ3MgdW5sZXNzIHRoZXkgYXJlIGNvbXBsZXRlIG9uZXMgKG9yIHdlcmUganVzdCBs
dWNreSB0bw0KaW5jbHVkZSB3aGF0ZXZlciBzdHVmZiB0aGF0IGNoYW5nZWQpLiBCdXQgaG93IHNo
b3VsZCBvbmUgbm93IGtub3cgd2hpY2ggb2YgdGhlbSB6aWxsaW9ucyBvZiB1c2VyLXNlbGVjdGFi
bGUNCm9wdGlvbnMgc2hvdWxkIGJlIGFkZGVkIHRvIHN1Y2ggIm1vcmUgcm9idXN0IiBkZWZjb25m
aWdzPw0KDQpJIHN1Z2dlc3QgYSBiZXR0ZXIgYXBwcm9hY2ggbWlnaHQgYmUgdG8gaGF2ZSBzb21l
IENJIHdoaWNoIHZhbGlkYXRlcyBkZWZjb25maWcgY2hhbmdlcy4gVGhhdCB3YXkgb25lIGNvdWxk
DQplYXNpbHkgdHJhY2sgc3R1ZmYgZGlzYXBwZWFyaW5nIGFuZCBjb3VsZCBhdCB0aGF0IHBvaW50
IGV4cGxpY2l0bHkgZW5hYmxlIGl0IGFnYWluLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==
