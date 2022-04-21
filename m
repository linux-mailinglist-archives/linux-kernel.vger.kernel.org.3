Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04240509C24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352065AbiDUJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiDUJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:14:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512AC15FC6;
        Thu, 21 Apr 2022 02:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB3Og4/W0nwERZ1J8f+mnUCAVokuvJ32jpWXpLVBtr9zeP4wEoROHOjWGAkBQ0xcymCV61JcHyrkUo6GOwJKbIHO0lLlucqJSCe0XvUO77zWXZ32HkHtyhWh4/0TsWKc6FcqyhWJerO6EACU/jAbQRSAMxZyKxg1XvGF+fNI7hTlBDJvpF+ZIcupz1SUIlYyu6WnDsnI6VNpT5Fj1pqLKI4lmgRWx/5XACr68QqEYEZvBOdKBKnwtgJQftnnxwcPR0mH1DujjTw8//b+vIP1JYFEIlY4S+9Efc7WzU95YGnXwDj6SKOwsFT6PwXMhdcfMrr/KIkqSkBiwJgNfjSY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggjtQewWH66MmnSvemgnoBg+EoBk0bPJpIUwSFjOrsM=;
 b=S0Bzg8F1x+7MhLlzTq6HeR9wEvEj5APKyy7Xzb7rugWaYl7+q3l//lcVKBP4uiX5OpnRQ7XVJUf8a7aRZ1SsdTv2zTSuQ9AMZCHqEb0vfadAsl9dO1WrVrtBUJ12d/KeXMt+KNpAMPObaPiKB79M3miu8W0uaAPQu+aw89tgtb7tvmvZgH8IIWjfJ724vp2QI8FGV0K1/qbUpYJQBH/BRq/rbtVhFrQGd5ryA3gNAXbUoJ01PbKJPYeLGSjooL9gC8XaKMVUx2RfeZmjVW9spZCd05pP8VOK8fEKfD9Cv+93PWqr0NPtJfArlTt+G3tv71zEIn0/VfNj53oQv7kmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggjtQewWH66MmnSvemgnoBg+EoBk0bPJpIUwSFjOrsM=;
 b=eVANr5NwnGxt3BHg6YdIRWKOCeYXmhIRgwU76KXr7ypDKpxl3xiMb70OTFEUei7huRrDNzqPZnntV+uZTvYTRYlegUGchjI73bUMbsj9Zm1Qzw4/0aAt2LRb1FP3AhMdvaiVn0Lq6mUXQUshayKRGO/mi1F0FOy6bETsWHjTEpk=
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM6PR0402MB3718.eurprd04.prod.outlook.com (2603:10a6:209:19::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 09:11:59 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 09:11:59 +0000
From:   Jerry Huang <jerry.huang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Topic: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Index: AQHYVIiygEZn3a5TtE+wxprjnFe3kqz4tPoAgAFfCfA=
Date:   Thu, 21 Apr 2022 09:11:59 +0000
Message-ID: <VE1PR04MB6477553510B6EB35D7C22C13FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
References: <20220420073146.38086-1-jerry.huang@nxp.com>
 <d74f62d7-7aea-b31f-1c2f-540c54df289c@linaro.org>
In-Reply-To: <d74f62d7-7aea-b31f-1c2f-540c54df289c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d85005df-7fa0-4f03-2742-08da2376fdae
x-ms-traffictypediagnostic: AM6PR0402MB3718:EE_
x-microsoft-antispam-prvs: <AM6PR0402MB3718213565A8BEF09510602FFEF49@AM6PR0402MB3718.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZaHfBY9G3ddQPJSIHXtERzsvGx0+sHP2gEaMltyWujmj0OnRPf1oj/Ff1D9/Yj5NNWaOUzDo4DupJRPIknP9yt5TL5ujywWPmgQkSBmLMGxLfimYSDCXlrEy6gK4tKKEe2lZLmcq5u0lIdorrkBzSSFA0PG3P6QxTepxi1FUDr1rQE32EhJ/9ltAQaj9vMGxgvlPKm6jw/Q3Yl3eOlbmYV73ZgqPCI4qsz4oDIIYDLtBnEejVSB8+zChjIPmfwzUz+AfYSn7IP//qO1xtvgpOHpOa1VeS8JBYkBCac8r55vGpmSSWWVTOZ7SDs1DpguKeTrTj5U3pQ78dmh0Bq9/2zA4TVgLWc6GhwVLvDDFfhnEUAbxNqd1bs0pw5Xs1Yy69IytogePp/OcM54F4zTb0kwMQLFC8Patwqi+P78Qc2DXT1fBAPknFzItsWFzw+p9Npg+viJUlxjVoqS3Up/oewBPQBdV7hZGu+ehQ/7n7Xe/t1RjdEI+1FN6cV0wZUQLRdh10qCq3dYQALvNYyR5PcFGhcW20LdB6tjuc847SHae0vEnu5TUcdpjMsB+fyAo9XXIrpxDg1TkLiSFHpyzPKFfe5CEfM1/ql9lpzl5B1WdZnCiYKT1orCMXpvyvgvv1cKBT6+XZat548/rMdQHhYm1QI/VT8e9OJDj49GCInIu21VkGYtFS5GXarQxZ7BYF5Z98OQS8cYOMaPr75H7xCUKsdQtNntQjGezkJEwOTBltO3NN1yzLfevEPb7zO9q1FvCN5wqeUMF4sZtWgtxP04WvpmeH4OUdIt/dOlRBU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(53546011)(45080400002)(6506007)(52536014)(44832011)(2906002)(38070700005)(64756008)(316002)(76116006)(8676002)(66946007)(66446008)(66556008)(66476007)(110136005)(71200400001)(26005)(38100700002)(9686003)(186003)(921005)(8936002)(55016003)(5660300002)(86362001)(508600001)(83380400001)(966005)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NFhLaDQwRDlUbEg3RnNoOVVBY2lrTncyanBDenhiNytFRlBNYU53MVBSMkll?=
 =?gb2312?B?SzMzcjhodlNHUkpWbWNPSXlqendOMjM1TFVVYzQzWndRZHJXM241MS9kVU5D?=
 =?gb2312?B?ZVVER294d25uTUl0Yi8waHhrNkRSSkVvcXRjZkQwb2Y5UXNDUFZSNzJpRzcx?=
 =?gb2312?B?S0lydkJxMmdOUTlCbUZmK29XRXBmYkdvUklxTitaM0JZWGFqdS9ZTEw0eERF?=
 =?gb2312?B?NXZHUUhzL0ZhNXZ6NSttVFIzaVZxUkZxbjBCbmJxNE5lYTR0c3VhSjJFTWMv?=
 =?gb2312?B?M0JDekxxeU8vNnhXUGIrd1Fzam83Q2lJVGZXNDhSaUNoaUlnTUt1ZmlYM2Za?=
 =?gb2312?B?emJYRmZRVGk0MkMrYXVaZFNaS0o2L3VCcHI2Z0hpbTNCb3BBUlM2R3EwMlE1?=
 =?gb2312?B?cTdoQUo1eHNJZ1pYUndCQmdxWVNMOFZYZHpqN3R0TVhuTkgzYnpWOUlLVVB2?=
 =?gb2312?B?T3FxRzNVVEFNcktyYWh6MW4yZng0T2NTazkrMmNuUnI2RmdGdnFSZ2FmOFJI?=
 =?gb2312?B?c0N2SUQ2SlRvYlE1YlZZMU9KRDFXTTFjYVdnSTF3MnhrZXpTWmR6c25uS0VN?=
 =?gb2312?B?R2ljR2VPUEFOZEErWnFVdzcxRUdqc3JBclNYZHZqWndjNlFwUktMbG03SGhU?=
 =?gb2312?B?L295S3MvRDJzdmpJUi9oanhsU2Nhd0EvZkdZMC9iWTBvbnRlVm00ZXp0VmNI?=
 =?gb2312?B?MHZWK2N3NUwwZGllSEFtMzljWVUzeFV1cThySmNSQy8rMjRFUEs4d3MvNE1X?=
 =?gb2312?B?alhGRHN0Z1A5NmFyYTZZWkdzRGxMT2dyOHQ5TGRBWFcyemlIdkYrdmVKZHZX?=
 =?gb2312?B?bXdPSm1aUzI5RnNjSU82N2NCYitldEFqekxmSW1CQVdrcEcwa1lqWFNCK0Nq?=
 =?gb2312?B?bm5iS1F1RkJFcTJrZ0RDbnJ5MjVEVjE4eEM0SnQyU0FDeFVRV1UvcFdwNXFP?=
 =?gb2312?B?VHpxTm5ySWJXZEI4VFVRNGZ0VmkyUGY4ZE1qaUt2bHR0blB4RW1yOWMzYmh4?=
 =?gb2312?B?azM2TnZRTHkzYUo3Tm9qYnZyUFhDekRjc0dWSi9UM0xzSFJKb1NtVlVpYlNE?=
 =?gb2312?B?dXZyK1FHcllxSE51SGNoTG9GRUdkTUZhWVAxMGNtbzYwdHEwc3pIWllWdmxB?=
 =?gb2312?B?Vmsvcm1GRnZELzhWRTZJU21CZEpWbkN0Q0dlc2thNlJYMS9BQml0dnVzZ2Ev?=
 =?gb2312?B?TUxUamI3cTlaS1RHdzRMTVdpTXVidUNKZkpCUzZuN0R5d09OWGFQQjlQM21B?=
 =?gb2312?B?YXFKekJIRWdybkVlRVFEd3V3Y0NOLzQ0TnVZYk9uTU1tSWl5eWtON3E5Zkli?=
 =?gb2312?B?OEpjdTZTZHBoSGZIK3lqQkI2ei9udDNZUW1ZNnJpb0tibDJYYytFNnNibXJV?=
 =?gb2312?B?ajZrYStYcGR6SkpyejF1QWJQVWVxblRyZmovdWJxWnQ0emF4Y2ZjTWhMRy9X?=
 =?gb2312?B?UUY0Z1VzdTRUdUdLTnNtVmVvU0w4STZ0elAwMDRwTlZBNDRoT2VwRVlkV1do?=
 =?gb2312?B?YzUrZUZOazVMbk8zTnFCSmNrak1KNkJQUUhaTVJmZTU0aGUyNVYrTDJuSjZw?=
 =?gb2312?B?QUtjejg3T2w4VytsTm1uWWFtWlBkMHVlSDZFd2xnQUJNMElUTk56U1VXbGNM?=
 =?gb2312?B?UDNoR1dHbG9KRC9jQXAzUVRXMUlwbE5CQ2syM3JPdmxlMmZZeWZyd2RmMG11?=
 =?gb2312?B?ZmZ1TGs1TkFuNTVoSzNvbHptNW10UHRPelFvc0Q3U2VxYnFZNWorSHhWbk4v?=
 =?gb2312?B?RnlqTGQ3aXltWkZGdk9uNUNBNmxNNi9WUkJiOEhXQmJnTE9ScmY5QXNZNzFl?=
 =?gb2312?B?Q1hoSjRlUG9FeTJwcTdKbkl3bDNpS0g0b1JZR1dPcTNzTDVtc0x5Y0dvY0xP?=
 =?gb2312?B?b3dKUXhlM0Z2c2owaWFjTkhpbHRGUy9KeVh5em1nZlBhK25xS2ViM09Banhi?=
 =?gb2312?B?QnBjWElKSEtQd09pTVc0Zis1aFlJSEQ4UUI5UFkvMG9UZkRDcFVCVHNkS3kx?=
 =?gb2312?B?NVVWVmNCeFZReHdvdDhBcHNrTWU2N2k4WXoyWit5b2x0M3oyR1RQaDFYbVhV?=
 =?gb2312?B?SXQ2eVdOZW1TZWlReUgyU0t1Q1R0M1hIelBHemZ3dGx2dTF3S295cGxYVkk1?=
 =?gb2312?B?NVhjdnBNd1ZzRlB5Y1huRTdtN2RhMlNEQkZyZFcrK2RkNE00eDNRUVZKYVZU?=
 =?gb2312?B?TzlyZEp6Y28zckEzSWQrallMWUxoZmlMK083MklibFpkamdId0Q0Rnp5bXZh?=
 =?gb2312?B?M3A5d0pRY29aUGxWK0k5aUUrNUF0dXVDWmVHRWtaS3FpT1g2UlRFRGJzb2F2?=
 =?gb2312?B?QUQ2ZXJuOVBWbG9FOVRmUlBjNjZhYzVsc0NkeTVhT2gzWU9BS29uUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85005df-7fa0-4f03-2742-08da2376fdae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 09:11:59.5352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tk/SvYGf2+ma+b9AjMIAS0qf0D9QGxqBuCfzdqw9Xhg/KuZJASS/FCyTxHRadb16VliUInhDyDL5F/CsuZ6b9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KQmVzdCBSZWdhcmRzDQpKZXJyeSBIdWFuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPiANClNlbnQ6IDIwMjLE6jTUwjIwyNUgMjA6MDYNClRvOiBKZXJyeSBIdWFuZyA8amVy
cnkuaHVhbmdAbnhwLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCAxLzIgdjRdIGR0LWJpbmRpbmdzOiBkc3BpOiBhZGRlZCBmb3Igc2VtdGVjaCBzeDEz
MDENCg0KQ2F1dGlvbjogRVhUIEVtYWlsDQoNCk9uIDIwLzA0LzIwMjIgMDk6MzEsIENoYW5nbWlu
ZyBIdWFuZyB3cm90ZToNCj4gQWRkIERUIEJpbmRpbmcgZG9jIGZvciBzZW10ZWNoIHN4MTMwMQ0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFuZ21pbmcgSHVhbmcgPGplcnJ5Lmh1YW5nQG54cC5jb20+
DQo+IC0tLQ0KPiBjaGFuZ2VzIGluIHY0Og0KPiAgIC0gcmVuYW1lIGV4YW1wbGUgbm9kZSwgYWRq
dXN0IGRlc2NyaXB0aW9uIGNoYW5nZXMgaW4gdjM6DQo+ICAgLSBhZGQgdGhlIGR0LWJpbmRpbmdz
DQo+DQo+ICAuLi4vYmluZGluZ3Mvc3BpL3NlbXRlY2gsc3gxMzAxLnlhbWwgICAgICAgICAgfCA0
NSArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygr
KQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc3BpL3NlbXRlY2gsc3gxMzAxLnlhbWwNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc2VtdGVjaCxzeDEzMDEueWFtbCANCj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NlbXRlY2gsc3gxMzAxLnlhbWwN
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi40MjBmZThkMjNh
MWUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc3BpL3NlbXRlY2gsc3gxMzAxLnlhbWwNCj4gQEAgLTAsMCArMSw0NSBAQA0KPiArIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4g
KyRpZDogDQo+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gK2NldHJlZS5vcmclMkZzY2hlbWFzJTJGc3BpJTJG
c2VtdGVjaCUyQ3N4MTMwMS55YW1sJTIzJmFtcDtkYXRhPTA1JTdDMA0KPiArMSU3Q2plcnJ5Lmh1
YW5nJTQwbnhwLmNvbSU3QzVmZTQwZjEyMjYzNDQzOTA4MTBjMDhkYTIyYzYyOWNjJTdDNjg2ZWEx
DQo+ICtkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3ODYwNTMxNzQ0NzIy
MzUyJTdDVW5rbm93biU3Q1QNCj4gK1dGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQw0KPiArSTZNbjAlM0QlN0MzMDAwJTdD
JTdDJTdDJmFtcDtzZGF0YT0yMnc3MXlhRUU5UWRSTmRJemFOcjVOY2ZHYlRWYmgwbE5CDQo+ICti
dGNoMW40ZTQlM0QmYW1wO3Jlc2VydmVkPTANCj4gKyRzY2hlbWE6IA0KPiAraHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZp
DQo+ICtjZXRyZWUub3JnJTJGbWV0YS1zY2hlbWFzJTJGY29yZS55YW1sJTIzJmFtcDtkYXRhPTA1
JTdDMDElN0NqZXJyeS5odWENCj4gK25nJTQwbnhwLmNvbSU3QzVmZTQwZjEyMjYzNDQzOTA4MTBj
MDhkYTIyYzYyOWNjJTdDNjg2ZWExZDNiYzJiNGM2ZmE5Mg0KPiArY2Q5OWM1YzMwMTYzNSU3QzAl
N0MwJTdDNjM3ODYwNTMxNzQ0NzIyMzUyJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5DQo+ICtK
V0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMzANCj4gKzAwJTdDJTdDJTdDJmFtcDtzZGF0YT0zWHBHUjRjbExremRLRGglMkZp
MjZpNExRdXVBWUo3RTklMkZ2MzRsS243JTJGYQ0KPiArNG8lM0QmYW1wO3Jlc2VydmVkPTANCj4g
Kw0KPiArdGl0bGU6IFNlbXRlY2ggc3gxMzAxIFNQSSBjb250cm9sbGVyIGJpbmRpbmdzDQoNClRo
aXMgaXMgc3RpbGwgd3JvbmcuDQoNClBsZWFzZSBhbHNvIGFuc3dlciBNaWNoYWVsJ3MgY29tbWVu
dHMuDQoNCltKZXJyeSBIdWFuZ10gSSBkb3VibGUgY2hlY2tlZCB0aGUgTWlrcm9CdXMgZGV2aWNl
cywgd2UgdXNlZCB0d28gTWlrY3JvQnVzIGRldmljZXM6DQpCTEUgUCBjbGljazogaHR0cHM6Ly93
d3cubWlrcm9lLmNvbS9ibGUtcC1jbGljaw0KQkVFIGNsaWNrOiBodHRwczovL3d3dy5taWtyb2Uu
Y29tL2JlZS1jbGljayANCkJvdGggb2YgdGhlbSBhcmUgU1BJIGludGVyZmFjZSBjb25uZWN0IHRv
IGxzMTAyOGFyZGIgdGhyb3VnaCBNaUtjcm9CdXMgaW50ZXJmYWNlLg0KU28gdGhlIG5hbWUgInNl
bXRlY2ggc3gxMzAxIiBpcyBub3QgY29ycmVjdCBmb3IgdGhpcyBub2RlLg0KDQpIb3cgYWJvdXQg
Im1pa3JvZSwgc3BpLWRldiIgb3IgYW55IHN1Z2dlc3Rpb24gYWJvdXQgaXQ/DQoNCg0KQmVzdCBy
ZWdhcmRzLA0KS3J6eXN6dG9mDQo=
