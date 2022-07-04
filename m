Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABB564E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiGDHDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiGDHDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:03:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2046.outbound.protection.outlook.com [40.107.113.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA47667
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2M11Ih6UUiyeJmUOd73647tjFRdRnCHi0NykIfb92TJislEcEK/kwoxqTAH4ThB8OtZyIdk6aVXMjent4c3VbqbWyELA2UHl6SU7rNANHGiUsLW4j4xhndd3TZRyBLSxIq+0SBadZKGF+kL9wsRXJyRNqZ3V0bz8xxCxo1f8WCHJsOaWq+HgPl8Ffdwx/IueKOOYEHtp32hZpDtWauafUalNzJAKwjDAdVWwp4D2gRfSKan6WUR0e7UPZNwPPpQyCuGP9ZV2KraeftGsE1JLGN4+5Mj6I6vDety46lcAkODdiPmwr6rTlULE4CIU2V0TKHKl9TAoyGfWYg6oKKojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiaxBMDWdQ227gT/aBDLEAYaTCFoQx/ItCLq0uMT/vo=;
 b=T/BgMkDDsIY9lVHT/Fw5sp6jqJdqoJ8WaMQR/VGnoH1vgPHDznFXcnMo+Mk02w1lmUDaae2EhNtfRsNO7wuvTVqRFjCFmsJ7UXTzt6J7aIja/ch1VIvtZTe1cJhPhWVsOHt2XcNDzU20WONQtB/TI6mVTx/BHrKgow7xD6ahTnzlER0P9UH2GmjYCnf75HVrmTZ/AGz4070Ock5CmMBoWcGghGj4DOl57rWJffDFLw4IpUHlnYjTEoVWqZ7vVC/XDuOwVQbiFLScgJsg0KJAKuTu4czDJXoL4Dnu4c5c8YhbhijKJ7wRqU3oBIYKI594B7KQJL3GuVWO7OGkSQVwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiaxBMDWdQ227gT/aBDLEAYaTCFoQx/ItCLq0uMT/vo=;
 b=BpZkmHPIdxGzJg6DTdn3dN+CpjYWAqJhYxSL77y/zNEhOkhUVv4Ck2Mh1fSHXqLbkRc1nqTZun6PH+7cIG1o225uwnxnbJktXlPUUs6T+DYpCmYzxiHh6nSQimM5kz2u3in6i9SWB0CppEouUcBSEAfTUV8uyI4O8JknalX48RU=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB7238.jpnprd01.prod.outlook.com (2603:1096:604:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 07:03:29 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:03:29 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-unstable 244/249] mm/memory-failure.c:1679:59: error:
 'SUBPAGE_INDEX_HWPOISON' undeclared
Thread-Topic: [akpm-mm:mm-unstable 244/249] mm/memory-failure.c:1679:59:
 error: 'SUBPAGE_INDEX_HWPOISON' undeclared
Thread-Index: AQHYj22dRZB4e7lNz06w+YXNPTluXa1tyWqA
Date:   Mon, 4 Jul 2022 07:03:29 +0000
Message-ID: <20220704070317.GA2473612@hori.linux.bs1.fc.nec.co.jp>
References: <202207041434.cdFm3q6k-lkp@intel.com>
In-Reply-To: <202207041434.cdFm3q6k-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ba2d53d-87fc-48ea-48ad-08da5d8b4c7b
x-ms-traffictypediagnostic: OS3PR01MB7238:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eD+QmNVUO715/NAvd7IdSCchCVhH+GHultYhB9TxN/tIn3qeuxEoPixxoFeYwvOl9guSgtmrs/837930Ez+UfNF4re5Loc4+yGWkDbMOfMukCJPMIBF0BrcRlRDyQOaQqFogVBfobHajdYVU47zsTs/jLevp39i5JV9AAnJNO31vepTi5vDgn3pvWWVdAx5c6ExyXo0IYifUp1wjuFdR6I9i+dPdgaNvQdzGNSdmkS3C1LMGTzsvm1/oig2yc5DZDjNMw/twvlASm9plFlTIgOJHIHBnQzTDQyj+QboIk9jr76Cfw3fZfK+o/4PdgtZQItPlchaurB50ctaYuKgN7s09pkLEQrrgJGWEx1UFOiTLUgPzisj/v8YiU3w5HG7nbJ75EXM8LmIzltOTEscItWAOTVDgTU4ejZgNRzd4r+tCaGora7bx+nUe8qDq+qd27cBeK8tPfN/YLBdtOkjDxe+vutArEg4h6ZSt13qiA2bEkFdtrXQERdbyvGjGIqZhqN0GHEX1CuEmFycyT4NROx/bXyyFtgBvRTpopdhog1RoInIAc0d9b5v0VvcgURFwU21dPEY/77B7VLMFR9F75+5QI8XDVJKb/ggw7pNw5YCAI0DQFvDSCT7IwGeuVy+TK9nXMGHUFr6AwbDYAO3H9r1bgYTFUmK8rufrr/dIaH+OBYhAHGvIQfcf0Gpths9rQgyXes5TVnd3FS6BV6ZrRzDoM4bGmycb5GteyIMPf+egQ6e84c7tW1d7LVAfTj+0TL2ZJeRj+Ky6ZU1//NaL/o83TLAFePI1THOGFQf/VS+u6bs2K9Ila+U1ZsCbhNQcuVrQfU6kOKC3lBQvOMohlkSykjS9JXboHnTUV0yJThe6eJ68TnuBJrHEhAUDf938
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(85182001)(110136005)(316002)(38100700002)(966005)(6486002)(82960400001)(54906003)(38070700005)(76116006)(122000001)(4326008)(66476007)(66446008)(64756008)(66556008)(66946007)(8676002)(55236004)(71200400001)(26005)(6512007)(9686003)(41300700001)(6506007)(2906002)(186003)(8936002)(33656002)(86362001)(5660300002)(83380400001)(478600001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S21odXBOYjFtNGNwRjFyWG8ybUFubUZuR0ZCSkYzbWJXZGt4d1ZQaWxSbjhT?=
 =?utf-8?B?bmVaZ3p6L1NkcGczU05UZXY2MndwSTJvM21rcmlscFJ0VGhVVmQrUEFTTlha?=
 =?utf-8?B?LzZtQms1bFdOL0EveitQZmU3UVNRRm1NTklMck8zeDR4ZDBKTTNlUlZmODcv?=
 =?utf-8?B?ZDB5MnJ0cEhkN0lLeG1DVDFQUkZJU1M2cVQ3WTlvUnBGcTJJZ21Wb2pUSm5Z?=
 =?utf-8?B?bVU2MEFlOURvWlhQdUNUUUtyb2hVYVNjaUtYam5iRThjRmRzT281dnJRS1BV?=
 =?utf-8?B?bjBkU2JPUDlxSXI3RU52MlpNb201R1VpUXgzVzRmN3pwdmxoT3FId3RQdk93?=
 =?utf-8?B?cEhRT2RuakVtZExPNTBoV0pFZG90Rkk2UW81Y0xZMkxQdnJDcGcyVWNzWTBl?=
 =?utf-8?B?ZEIxT05yMUZKKzdOaGZyam1zbzJhQVJ6cGY3RU1uSTdCQWdXM1UyL1dBdEJB?=
 =?utf-8?B?L3dvT0hxeGxCN202NmhEU3RGMFF6QWZlNUxmQ3ZYREszVWFabWx0YmM3d2I0?=
 =?utf-8?B?MDlQZmM5cU9ZaTc3UHl0RGQ5SFROUFZ4U3dxeE5lR0VYSFNYSyt5QjFHNHhR?=
 =?utf-8?B?d0g0SXkxUnc1bi8zbXdHZTB5TTBKSHpkc2N3WjVoSVZwK05aNTJBcFB0b3NC?=
 =?utf-8?B?ZENYK01HOG16bEN0SWN0cS9KS25keGp1aUQya2FvN1lsNEpGV1BmYm9MMXJx?=
 =?utf-8?B?Q1F3UVhOUHRMRXlEUnV5VmtzL1V0cWZZLy9jQmNxcEN1QzVWRUo3aCtWVENa?=
 =?utf-8?B?b1QvMElGdG1FSUZnTkFEWmNTNFMwZ2FPZFdSZXphSlhmSDllbkx0UEJMaDR0?=
 =?utf-8?B?N0ZmR2RwYUk5dE5GdlBCNUpZUWU2dFRqdFNoSHp2SEoyYmVlMFBvUjlSeDhP?=
 =?utf-8?B?V1dpeDlsR2F4ekFiV254bExPNk9MejAzMDlmY0JXZ0pZK3Vkd1ZWY2pBMzVB?=
 =?utf-8?B?TDVXbUgzbzFoZkVRRm5scmF5MSt6QzRSczkxSVVMZGZPRWtnMHRraVVzbnZv?=
 =?utf-8?B?QlNGWnFUb3gzL3ZJT1RXaTd5dlN1M0t0TG5IQ2xHSUsvWW1oNGQrVGJVcisr?=
 =?utf-8?B?U2J5eUxZRHNwRUw2TldUSVRudzNLVW1yZk5sMjh5bGE4dGFFTFhXcnYvNFdm?=
 =?utf-8?B?TDJoOXJ4WFREWTdFWHowdk15RzUzTDFhdGlCa3lXK1E3KzdqelY3Szhob2Zx?=
 =?utf-8?B?dXJVMU52UUtCS3o5eXJOS3BRajB3bjVvWTR3Z3V0allscTJXSFRyODZmMEth?=
 =?utf-8?B?S3lIdXQwN3NHcGZOL2F3cHBHMEVzQ1IvbVFKd2xQVmpaRzNtbXJGSUEvOGNn?=
 =?utf-8?B?QklBeDFxRkFzeUdkRnZHV1paRzByUVpuZlVRWlBvYWtWd3hXMGp3cnhlWDly?=
 =?utf-8?B?ZSszQnJReFMvUkZ1UUg3UFhOZVljNVNXYjBpd3dQak03UDRLaFhscktYQW83?=
 =?utf-8?B?KzNBSm1KSlVDYkFrUS9RVzRPWnNXRW5UZ1EwNGdkOWVlb2huV0F3NG9NakNk?=
 =?utf-8?B?NGJZNnJNWE11VUo5NzQzRm1UVEdWT0owUzJHQ0JNY2xGNGlKd01RMGdGc0ZR?=
 =?utf-8?B?RFh5N2dlcFc3TEtFWURRMTVzZkNYbFR4eHFuUWdnQVRQd3g3L0J3bmwrcTFE?=
 =?utf-8?B?YkhpbHhhZm9nOFB3Z0wxYk1zTUFvU1lFbVYxM1VlQWxQLzlTMWVNNDgyNkdo?=
 =?utf-8?B?SWJrb0tYLzNWem1xS09vN1cxUWZzNHZoK2RZbDE2UzVJdm9pTGtBZVlNaUdB?=
 =?utf-8?B?S3BUT2s1OUZUeDJLMEUrSFFYNGVBOGdqNnBEMDdNY0xlYy9YaUdjU3lSWW9q?=
 =?utf-8?B?TFVOa2VFMDZPTXhXOVVTUnVadWpYM3phOXJJbnhSWEYzbC94U1ZDaEtyeWNY?=
 =?utf-8?B?TzU1aTVsQXNlU0ZvUHZjWEgzU1hlY2pJZVorczVHSVluWEk4NWpYUWZFSnBU?=
 =?utf-8?B?RFRJaU1FQTNrTEYvaTR2V0w2NG5MbG9ieWxBNWxTaDBqSGZvdEcyZUdLRnZ4?=
 =?utf-8?B?RnZQeEZHUUV6NE9KdEdsQXppZ1BqMEg5NXhYZXNHVzQ4c1AvRncyUVNlSGZG?=
 =?utf-8?B?c3lRakFzRWdPOTdFeFRkYVZIcng0UmE4bUdxaVNuaTV4N0NyRjJDaHBuZEZu?=
 =?utf-8?B?TVZ5Z2dCNmk5dS9Tb1JXblExL1BaQVVJeWpueU9GcmFzTjBWNllpVXNnNVlU?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <353A93A21A82CC4C9B1D633966008D9E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba2d53d-87fc-48ea-48ad-08da5d8b4c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:03:29.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3RbEIpn05mAfzIYfm5riPQy3tmsGACBbJaBIS4FNL+YWQSDS1SBEApY2Pjjz1pNO7GsvQq8jZ8AZIZeo/qORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMDQsIDIwMjIgYXQgMDI6MTY6MTVQTSArMDgwMCwga2VybmVsIHRlc3Qgcm9i
b3Qgd3JvdGU6DQo+IHRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvYWtwbS9tbS5naXQgbW0tdW5zdGFibGUNCj4gaGVhZDogICBjZTRkYzZiMDM3
OGVmMWJkMzA1YzM3Yzk0ZmI4YWFiZWU0YzViZTA0DQo+IGNvbW1pdDogNDM5MDZhMmI5NTUzZGY3
Nzk5ZGFlZDMwNDUyOWE2OTIwZTk3ZjllOCBbMjQ0LzI0OV0gbW0sIGh3cG9pc29uLCBodWdldGxi
OiBzdXBwb3J0IHNhdmluZyBtZWNoYW5pc20gb2YgcmF3IGVycm9yIHBhZ2VzDQo+IGNvbmZpZzog
cGFyaXNjLXJhbmRjb25maWctcjAxNC0yMDIyMDcwMyAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcv
MGRheS1jaS9hcmNoaXZlLzIwMjIwNzA0LzIwMjIwNzA0MTQzNC5jZEZtM3E2ay1sa3BAaW50ZWwu
Y29tL2NvbmZpZykNCj4gY29tcGlsZXI6IGhwcGEtbGludXgtZ2NjIChHQ0MpIDExLjMuMA0KPiBy
ZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOg0KPiAgICAgICAgIHdnZXQgaHR0cHM6Ly9y
YXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIvc2Jpbi9tYWtl
LmNyb3NzIC1PIH4vYmluL21ha2UuY3Jvc3MNCj4gICAgICAgICBjaG1vZCAreCB+L2Jpbi9tYWtl
LmNyb3NzDQo+ICAgICAgICAgIyBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9ha3BtL21tLmdpdC9jb21taXQvP2lkPTQzOTA2YTJiOTU1M2RmNzc5OWRhZWQz
MDQ1MjlhNjkyMGU5N2Y5ZTgNCj4gICAgICAgICBnaXQgcmVtb3RlIGFkZCBha3BtLW1tIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FrcG0vbW0uZ2l0DQo+
ICAgICAgICAgZ2l0IGZldGNoIC0tbm8tdGFncyBha3BtLW1tIG1tLXVuc3RhYmxlDQo+ICAgICAg
ICAgZ2l0IGNoZWNrb3V0IDQzOTA2YTJiOTU1M2RmNzc5OWRhZWQzMDQ1MjlhNjkyMGU5N2Y5ZTgN
Cj4gICAgICAgICAjIHNhdmUgdGhlIGNvbmZpZyBmaWxlDQo+ICAgICAgICAgbWtkaXIgYnVpbGRf
ZGlyICYmIGNwIGNvbmZpZyBidWlsZF9kaXIvLmNvbmZpZw0KPiAgICAgICAgIENPTVBJTEVSX0lO
U1RBTExfUEFUSD0kSE9NRS8wZGF5IENPTVBJTEVSPWdjYy0xMS4zLjAgbWFrZS5jcm9zcyBXPTEg
Tz1idWlsZF9kaXIgQVJDSD1wYXJpc2MgU0hFTEw9L2Jpbi9iYXNoDQo+IA0KPiBJZiB5b3UgZml4
IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIHdoZXJlIGFwcGxpY2FibGUNCj4g
UmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gQWxs
IGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiANCj4gICAgSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIGluY2x1ZGUvbGludXgvbW16b25lLmg6MjEsDQo+ICAgICAgICAgICAgICAgICAg
ICAgZnJvbSBpbmNsdWRlL2xpbnV4L2dmcC5oOjYsDQo+ICAgICAgICAgICAgICAgICAgICAgZnJv
bSBpbmNsdWRlL2xpbnV4L21tLmg6NywNCj4gICAgICAgICAgICAgICAgICAgICBmcm9tIG1tL21l
bW9yeS1mYWlsdXJlLmM6Mzc6DQo+ICAgIG1tL21lbW9yeS1mYWlsdXJlLmM6IEluIGZ1bmN0aW9u
ICdyYXdfaHdwX2xpc3RfaGVhZCc6DQo+ID4+IG1tL21lbW9yeS1mYWlsdXJlLmM6MTY3OTo1OTog
ZXJyb3I6ICdTVUJQQUdFX0lOREVYX0hXUE9JU09OJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4g
dGhpcyBmdW5jdGlvbikNCj4gICAgIDE2NzkgfCAgICAgICAgIHJldHVybiAoc3RydWN0IGxsaXN0
X2hlYWQgKikmcGFnZV9wcml2YXRlKGhwYWdlICsgU1VCUEFHRV9JTkRFWF9IV1BPSVNPTik7DQo+
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gICAgaW5jbHVkZS9saW51eC9t
bV90eXBlcy5oOjMzNDo0Mzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAncGFnZV9wcml2
YXRlJw0KPiAgICAgIDMzNCB8ICNkZWZpbmUgcGFnZV9wcml2YXRlKHBhZ2UpICAgICAgICAgICAg
ICAoKHBhZ2UpLT5wcml2YXRlKQ0KPiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn4NCj4gICAgbW0vbWVtb3J5LWZhaWx1cmUuYzoxNjc5OjU5
OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2Ug
Zm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbg0KPiAgICAgMTY3OSB8ICAgICAgICAgcmV0
dXJuIChzdHJ1Y3QgbGxpc3RfaGVhZCAqKSZwYWdlX3ByaXZhdGUoaHBhZ2UgKyBTVUJQQUdFX0lO
REVYX0hXUE9JU09OKTsNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAg
ICBpbmNsdWRlL2xpbnV4L21tX3R5cGVzLmg6MzM0OjQzOiBub3RlOiBpbiBkZWZpbml0aW9uIG9m
IG1hY3JvICdwYWdlX3ByaXZhdGUnDQo+ICAgICAgMzM0IHwgI2RlZmluZSBwYWdlX3ByaXZhdGUo
cGFnZSkgICAgICAgICAgICAgICgocGFnZSktPnByaXZhdGUpDQo+ICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fg0KPiAgICBtbS9tZW1vcnkt
ZmFpbHVyZS5jOjE2ODA6MTogZXJyb3I6IGNvbnRyb2wgcmVhY2hlcyBlbmQgb2Ygbm9uLXZvaWQg
ZnVuY3Rpb24gWy1XZXJyb3I9cmV0dXJuLXR5cGVdDQo+ICAgICAxNjgwIHwgfQ0KPiAgICAgICAg
ICB8IF4NCj4gICAgY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQoN
CkkgdGhpbmsgdGhhdCB0aGlzIHByb2JsZW0gd2FzIGFscmVhZHkgbWVudGlvbmVkIHByZXZpb3Vz
bHksIGJ1dCB0aGUgc2VwYXJhdGUNCmZpeCBzZWVtcyB0byBiZSBmYWxsZW4gb2ZmIHdoZW4gdXBk
YXRpbmcvcmViYXNpbmcgKHNvcnJ5IGFib3V0IHRoYXQpLiBUaGUNCmZvbGxvd2luZyBkaWZmIHNo
b3VsZCBmaXggdGhlIHByb2JsZW0uICBJIHRoaW5rIHRoYXQgdGhpcyBjYW4gYmUgZm9sZGVkIGlu
dG8NCnRoZSBwYXRjaCAibW0sIGh3cG9pc29uLCBodWdldGxiOiBzdXBwb3J0IHNhdmluZyBtZWNo
YW5pc20gb2YgcmF3IGVycm9yIHBhZ2VzIg0KKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1tLzIwMjIwNzA0MDEzMzEyLjI0MTU3MDAtNS1uYW95YS5ob3JpZ3VjaGlAbGludXguZGV2Lyku
DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KLS0tDQoNCmRpZmYgLS1naXQgYS9tbS9tZW1v
cnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KaW5kZXggYmEyNGI3MmI4NzY0Li5l
YWQ5ZDQzMTE0ZGMgMTAwNjQ0DQotLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQorKysgYi9tbS9t
ZW1vcnktZmFpbHVyZS5jDQpAQCAtMTY3MCw2ICsxNjcwLDcgQEAgaW50IG1mX2RheF9raWxsX3By
b2NzKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IGluZGV4LA0KIEVYUE9S
VF9TWU1CT0xfR1BMKG1mX2RheF9raWxsX3Byb2NzKTsNCiAjZW5kaWYgLyogQ09ORklHX0ZTX0RB
WCAqLw0KIA0KKyNpZmRlZiBDT05GSUdfSFVHRVRMQl9QQUdFDQogLyoNCiAgKiBTdHJ1Y3QgcmF3
X2h3cF9wYWdlIHJlcHJlc2VudHMgaW5mb3JtYXRpb24gYWJvdXQgInJhdyBlcnJvciBwYWdlIiwN
CiAgKiBjb25zdHJ1Y3Rpbmcgc2luZ2x5IGxpbmtlZCBsaXN0IG9yaWdpbmF0ZWQgZnJvbSAtPnBy
aXZhdGUgZmllbGQgb2YNCkBAIC0xODA0LDcgKzE4MDUsNiBAQCBpbnQgX19nZXRfaHVnZV9wYWdl
X2Zvcl9od3BvaXNvbih1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KIAlyZXR1cm4gcmV0
Ow0KIH0NCiANCi0jaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFHRQ0KIC8qDQogICogVGFraW5nIHJl
ZmNvdW50IG9mIGh1Z2V0bGIgcGFnZXMgbmVlZHMgZXh0cmEgY2FyZSBhYm91dCByYWNlIGNvbmRp
dGlvbnMNCiAgKiB3aXRoIGJhc2ljIG9wZXJhdGlvbnMgbGlrZSBodWdlcGFnZSBhbGxvY2F0aW9u
L2ZyZWUvZGVtb3Rpb24uDQpAQCAtMTg4NSw4ICsxODg1LDkgQEAgc3RhdGljIGlubGluZSBpbnQg
dHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncywg
aW50ICoNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX3Jhd19o
d3BfcGFnZXMoc3RydWN0IHBhZ2UgKmhwYWdlLCBib29sIG1vdmVfZmxhZykNCitzdGF0aWMgaW5s
aW5lIGxvbmcgZnJlZV9yYXdfaHdwX3BhZ2VzKHN0cnVjdCBwYWdlICpocGFnZSwgYm9vbCBtb3Zl
X2ZsYWcpDQogew0KKwlyZXR1cm4gMDsNCiB9DQogI2VuZGlmCS8qIENPTkZJR19IVUdFVExCX1BB
R0UgKi8NCiA=
