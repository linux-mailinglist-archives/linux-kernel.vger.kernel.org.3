Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C7598090
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbiHRJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiHRJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:09:08 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120042.outbound.protection.outlook.com [40.107.12.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A214DB43;
        Thu, 18 Aug 2022 02:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L90ljrAENMLJC1nnDJrkekDWqY2FI8E+zCzr15qyGAjo0PILBIM16pb4yVgsol2yolKNikdQ7uUlcGbBWF3p8am+usqPR7647vCTHKozXK08SA4UmbppgBbsgkm3jvmv1N3qnRsMLBkYRXucqWB0aKpF72erLqedhQeAeslSTmgpg5WalF0YjqCt6q2bB6TGrqM4slVWW4jYDyCHwGY1R7Qii5MIQikHM6fD8jzonl7iPcyYxD+MIUYl6I/HaH6qHzZG61exHBiOyTgYT3yIyhDJveDAIM7YPDlVBpOGJjA0H9YX7qMlkp9UuJ24iaXaisiRykRzgo/BL9oAavRX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoygRBD6HDaDY7dKIPLJ+xk4B6mhy3oF71gaDcRfQ2g=;
 b=FT4SiKPhbwfs/1E8e2z4f+8rwIPwCpPt8usBE3mka4ckadMnN2PLD0xx+j4+30GNTHo+O3PIrJKE7jRIntFO9zXkOavs1G9Lg33ErNuTDiR2Dkxl3shgDQuX4qWyG7YwUHXNXezMhafOgmTyw8UG9vvHsnIixmwcG7tPPoPwMyi7TxmiOI9iWUcvtB1ts3EOw1/TbpHaLEe3yGBiRqwCaXK0pRpztCJ7S3DFPzCszdeUKEufhsBJWqeBkSd3qfiqLEPnNC7sLuFhkoW9DsY0QlKmnrm3YmIldV3Efyf5lAUb4b+Wefsy2vMf7TKt/hWcxycOytpUDfNcmyW2bKkQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoygRBD6HDaDY7dKIPLJ+xk4B6mhy3oF71gaDcRfQ2g=;
 b=mCRXbsBdNo5iOnJ3Wlf45RCoZncnleIc/wleZ6vUuP4RFvZYHQabmJveHiF1xNRyxQVrMIvBllK8vM7JkeycKsk0Qg2rweecvidhxLvtBoHbJJ7J0KTdWPOp1Yf43oZR6x7jbzWDSY6Mzph3RP3b+uBFUzyvL5iP+c96QZtWZ7L1IQjhox+QpzaOa4QJuFq+zYrk1ZvzNPI8kNF35hr8fWM37Z1WzEWgbFH7jwFXCuZ7YOpQb7bzqWXl1u0dB2p/J9+yX98tyONmZS3sbT7H11wbQiEut2AQnct/l+Z3tHYVVef49crn76XHN14j9ZzNgZHP0TdZOwDWKBh+lni/sw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3515.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 09:09:04 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 09:09:03 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alexey Klimov <aklimov@redhat.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "klimov.linux@gmail.com" <klimov.linux@gmail.com>
Subject: Re: [PATCH REVIEW 2/2] watchdog: add wd_data->lock mutex locking to
 watchdog_open()
Thread-Topic: [PATCH REVIEW 2/2] watchdog: add wd_data->lock mutex locking to
 watchdog_open()
Thread-Index: AQHYsqcosxo7pLiUwk6SnVDazTlLka20XwOA
Date:   Thu, 18 Aug 2022 09:09:03 +0000
Message-ID: <368f894f-e433-6a9b-31c6-35dfa2842576@csgroup.eu>
References: <20220818020624.2386475-1-aklimov@redhat.com>
 <20220818020624.2386475-2-aklimov@redhat.com>
In-Reply-To: <20220818020624.2386475-2-aklimov@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cef33e4b-3848-418b-f7e8-08da80f94c26
x-ms-traffictypediagnostic: PR0P264MB3515:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FbcxivOIuJLb8RyrWVYfyYFXaJMCw3QB0rEQXBujRRc+Y3RpXS3MFQzfbu9WZjkd3EHufBOg9mXVEmPFdUY0X65poS8xbcOXY/fjDpP6EH+qFnWSKUJod0vVgep7mLHZWwPmazCrB+egCgajEBvIghMftqVIde6JnjdrDoUn5zn+XKypUv3tYfiRKVqMTTarDMxQJTBD1Lkwtvz+Z78UtNw6s2MRi7VUeoGVOm+p/Gw5acRKEwOIFZPkmXWySLS604tUc9E5eFsK+yi8+VKpewQ0vEi9PTMPx+klU4Av6VhoU/yfJby8KD6d03vkL8Ywmpik9kP6cPKEaQX84UwqSv9y/rp3VY+mKRzw8w7c9EklWmaT5o8dvWWbgEEIvPHkYN9eMFRwcRx6Ka+fnkyZ7BuPQ8jbZbQ6MpC/wb9LkQVjgtemIzTt7SbVhFhzsWQMFuhlhy56H31hGbDkNx0zzGOP04qijk5Gd8oJhfpWPAQ3efO+ZmusP7iR8PRYcNKEs5Ch0QbQdyo6rGDTi4S7gAQCPFsFaXkxcZHNvZouLxRV0Oyu/dv9prcro788w3++TL87YhFLLAAfHh7vwcd2Xwd1Hn76PN4atEto0tq/IiJZI91/UePq02Jn4TIwbVY3C74jp2tVgm6uMblwD/VZkTqNPX3JPWFtQxo+ZsL0synwgKJ9xPsZcLX1gJv0G+iI8DctpJtdQ89CljCFB39KVQh1LDdHg/tkKLQzThvUbHSFOC2WOgeWMAL5myPMYm81TKG/cLRowJ51xJFzehBvz/pzE3F6knJzKtNoye436odJ9XGs/ts/3LhNqABjD95UTmLJPw4tvoyHcIEFhm6lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39850400004)(376002)(136003)(478600001)(2906002)(41300700001)(76116006)(91956017)(44832011)(66946007)(4326008)(8676002)(66446008)(66556008)(66476007)(64756008)(966005)(31696002)(6486002)(316002)(31686004)(36756003)(71200400001)(26005)(6512007)(110136005)(54906003)(6506007)(38070700005)(38100700002)(2616005)(86362001)(83380400001)(5660300002)(8936002)(122000001)(66574015)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU1CRW0rKzE3VEp6R0htRG9wTkx4dlVzaE85UCs4a1ZrdC93SXZZa0k3R2xw?=
 =?utf-8?B?Wng5NkFOV0pwckVYRlFRMjhDMkRha3FjSkNYNGZkNHdDZk12cnVkbkxHWlZw?=
 =?utf-8?B?N1dzNTBYdnBkOW5EbjNXMnpsd0piRlNrTHpENTRQdWlnbXh2QitEUXU5bWg5?=
 =?utf-8?B?c0tiMFlqa1kzY2hLRVZMYmU3NnM0S3hLeHRnTk00Vmkvdzk5TlR2VWhGRHpL?=
 =?utf-8?B?RUhZWWxLZnBXeGtwWVVvTnVWMUxhazVNL2tRMjRmSCtPMkZONDk0ZmpjUHpy?=
 =?utf-8?B?emVBdzFsR2Zta3EvbHpyRnJzYW9WSkRyYld0ZytJblo0c0w3YzJaZG9sNEZB?=
 =?utf-8?B?UXYyYThvWi9tdDFuaFR2dmFtenZ6NWc4VjR1MVdsZjE2K0g1VlltYUEwWkU5?=
 =?utf-8?B?b29PTHJQTzNWU1lWd01oaGhVMGtSN2cvelJnTnJTdnk3V3NyWDB4S2grV2g1?=
 =?utf-8?B?V1VsYm5GU0ZZQnYwcDVCTGZRdFI1ankwcEhGTWhYNjhWeUVKdmtJY1p2U3dF?=
 =?utf-8?B?TjRKL1lteGF5RU5pOXhGWEk4VStqemNTUGNtc1JkZGpDOWpHM0lZZm1VbFRG?=
 =?utf-8?B?U0lKTWpjbVlObkRabWtZR2hTNDkvWnUwSzJHOTRmR3luQU9pYmErblg1RkV3?=
 =?utf-8?B?L3hkQTl1Z2g4SVdzWXRJMnpOdUZNLzlobTY3bW5MYUgzN2pkNWdLaUVyZUVm?=
 =?utf-8?B?VFpNWG40ZWRWTldQYVYyRlU2SUd0dlV0UmVrWXRRRUVDSEh6c3N2dkJRWUdH?=
 =?utf-8?B?YndmY0tnN0xnNUVoclp5MGp5ZmNFMTAvbzRFSDFkM1pmZVNVVlgvS0xVS3hq?=
 =?utf-8?B?Qis5WjltTGw1d0MvSi9CSFZCdFFyaUxrS050aHNuVXpZTDgvVnpMM2x5TDZN?=
 =?utf-8?B?S3RJYU5qMjJxNENNWDU4SXQ5aHlRcEtCYnR4bDFSNzRZK2pJRExZL0hMR0tD?=
 =?utf-8?B?RDUzdjRCVTMxaUh6eUN2UldTTUNIYWoweXVNazYxeDRRMk9XOWE5ZnlXMmRx?=
 =?utf-8?B?Q1dGcUN2dS9oWDJ2SFBuSzJSaVF2THdoMFFqbllaR3dUb0xNMTIwNjc0aWdV?=
 =?utf-8?B?NWJWZ0VZSWpZanduZWd4and6WmxsUWU2NlVIZmRzemZ2Q2V5Q1dpR044NzNX?=
 =?utf-8?B?bFNFWTZwV3haWjdOdHpFVUFjWkRhd3dxbmc2djJEL3ErVW54a01QWXhhbjQ3?=
 =?utf-8?B?bDZ6ZFJSK0tqREpyNmNMZGNRcHlLUjJIbTJWUzE5MnN1b1czeHVSdHNuUlVu?=
 =?utf-8?B?dTk5SXpVaVY5TGJubzRINjQwMlBicXlwM0tEcGtiSTA1anhPaFFiZ0hTTDN6?=
 =?utf-8?B?ZDAyRGR2aTBFTWc4ZTNud2RGSlh5K3R3bU8yV001bmlWY2sydFZIR0tCc2NU?=
 =?utf-8?B?QThvSkV1THJTdHNXcWxydG9ndTh2dGk4YzJiZXFVRXVQcENmNjU0TFRaT01l?=
 =?utf-8?B?OGUzQm40UDlzbHYwNlpoaHpzUlh1cWVUS3dPaS9FckU5bGxNcDh1dVVSdzdX?=
 =?utf-8?B?TFpCS29FWWZrano2YTN1RW9HT1YzV01WOGlWKzJ0bE5zejU0bWdQZWhoT1hC?=
 =?utf-8?B?UkpGUllVdXVMc1o0QUcyaXlzdE5KTzdYYnBQd2dIblpMRC9qc2xmd0ZjMllL?=
 =?utf-8?B?dDBmNVBIVmRuUkxTZGhNQ3c0NVZ1ZCsxWlkvNEJLYnNtTm9EODZIMDBoTUVy?=
 =?utf-8?B?WHp4b3IzTGZHUlFNcGpjKzRWTVdXOERCNDU5dmtPeXpiNE9wcmhmdDZXU3dQ?=
 =?utf-8?B?d0lDS1B5eWd1VzM2OHV0ZFV3bVdzMnQva0orTlV4aHhhVXJaUkVUVE9pUHY3?=
 =?utf-8?B?RWd4a1hYNTBRUjJ0Mkhqc2MzSTNxYmRJRVRaNmh1NGdFQksvSVFwdVBHb1Zh?=
 =?utf-8?B?WmFPZktQRm5mMlAvanJqa1FPcU5scDU3TERpT044cHdSTW1FM0pYdlBWampt?=
 =?utf-8?B?NHZYaXJoUGY3U0xQVHpPODJOQk4xdzhmSDUvZkY3bDNkOHNuMXRhZkhYU2FR?=
 =?utf-8?B?U1BEM3ZxcXdlRXM1TUtWSWRHbThUUTFMMzVkRlQyN1NWSllWQ1FNWTVUN1JW?=
 =?utf-8?B?d0NuSjZRQ0l0TUhTR0xTaEtzMkIydHRLY050MGNPeWNNbytzR2Z6M0tCb0Mz?=
 =?utf-8?B?TXR5dWkvZ1oyRTduakF5T3lPQ0plRGUyajRMSGhQbWZrNmRVcTdlNXlrd2J1?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49E1B98C218A144E82042FD3A2562BAB@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cef33e4b-3848-418b-f7e8-08da80f94c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 09:09:03.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBF92Jm0NXzwmTUV+cHYhOk5XOM4it+PZS4WHSG3gxfcqzEPoVRQVaxL/9PSCaExjwmRdnj8HfFZ2xKwBaAMiSN6pfB14fY4YyMS+bVKGds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3515
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE4LzA4LzIwMjIgw6AgMDQ6MDYsIEFsZXhleSBLbGltb3YgYSDDqWNyaXTCoDoNCj4g
W1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgYWtsaW1vdkByZWRo
YXQuY29tLiBEw6ljb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFudCDDoCBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gd2F0Y2hkb2df
b3BlbigpIGRvZXMgbm90IGhhdmUgd2RfZGF0YS0+bG9jayBsb2NrcyBhdCBhbGwgdW5saWtlDQo+
IHRoZSB3YXRjaGRvZ19yZWxlYXNlKCkgZm9yIGluc3RhbmNlLiBBbHNvIHdhdGNoZG9nX29wZW4o
KSBjYWxscw0KPiB3YXRjaGRvZ19zdGFydCgpIHRoYXQgc2hvdWxkIGJlIGNhbGxlZCB3aXRoIHdk
X2RhdGEtPmxvY2sgYWNxdWlyZWQuDQo+IFRoZSBtdXRleCBsb2NrIHNob3VsZCBiZSBhY3F1aXJl
ZCBpbiB0aGUgYmVnaW5uaW5nIG9mIHRoZSBmdW5jdGlvbg0KPiBhZnRlciBnZXR0aW5nIHN0cnVj
dCB3YXRjaGRvZ19jb3JlX2RhdGEgd2RfZGF0YSBwb2ludGVyIHRvIGRlYWwgd2l0aA0KPiBkaWZm
ZXJlbnQgc3RhdHVzIGZpZWxkcyBhbmQgYmUgYWJsZSB0byBjYWxsIHdhdGNoZG9nX3N0YXJ0KCk7
IGFuZA0KPiByZWxlYXNlZCBvbiBleGl0IGFuZCBvbiBkaWZmZXJlbnQgZXJyb3IgcGF0aHMuDQoN
CldoeSBkbyB5b3UgbmVlZCB0aGUgbXV0ZXggZm9yIHRoZSBvcGVuID8NCg0Kb3BlbiBpcyBwcm90
ZWN0ZWQgdmlhIGF0b21pYyBvcGVyYXRpb24gdGVzdF9hbmRfc2V0X2JpdCgpLCBzbyB3aGF0ID8N
Cg0KSWYgdGhlIG11dGV4IGlzIGhvbGQgd2hpbGUgY2FsbGluZyBvcGVuLCBpdCBtZWFucyB0aGF0
IHRoZSBkZXZpY2UgaXMgDQphbHJlYWR5IG9wZW4gc28gdGVzdF9hbmRfc2V0X2JpdCB3aWxsIGZh
aWwuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBLbGltb3YgPGFrbGltb3ZAcmVkaGF0
LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy93YXRjaGRvZy93YXRjaGRvZ19kZXYuYyB8IDEyICsr
KysrKystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy93YXRjaGRvZ19kZXYu
YyBiL2RyaXZlcnMvd2F0Y2hkb2cvd2F0Y2hkb2dfZGV2LmMNCj4gaW5kZXggODA0MjM2YTA5NGY2
Li5kMDdhODY0MDM2ZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvd2F0Y2hkb2df
ZGV2LmMNCj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy93YXRjaGRvZ19kZXYuYw0KPiBAQCAtODM2
LDcgKzgzNiw3IEBAIHN0YXRpYyBpbnQgd2F0Y2hkb2dfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBzdHJ1Y3QgZmlsZSAqZmlsZSkNCj4gICAgICAgICAgc3RydWN0IHdhdGNoZG9nX2NvcmVfZGF0
YSAqd2RfZGF0YTsNCj4gICAgICAgICAgc3RydWN0IHdhdGNoZG9nX2RldmljZSAqd2RkOw0KPiAg
ICAgICAgICBib29sIGh3X3J1bm5pbmc7DQo+IC0gICAgICAgaW50IGVycjsNCj4gKyAgICAgICBp
bnQgZXJyID0gLUVCVVNZOw0KPiANCj4gICAgICAgICAgLyogR2V0IHRoZSBjb3JyZXNwb25kaW5n
IHdhdGNoZG9nIGRldmljZSAqLw0KPiAgICAgICAgICBpZiAoaW1ham9yKGlub2RlKSA9PSBNSVND
X01BSk9SKQ0KPiBAQCAtODQ1LDkgKzg0NSwxMCBAQCBzdGF0aWMgaW50IHdhdGNoZG9nX29wZW4o
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpDQo+ICAgICAgICAgICAgICAg
ICAgd2RfZGF0YSA9IGNvbnRhaW5lcl9vZihpbm9kZS0+aV9jZGV2LCBzdHJ1Y3Qgd2F0Y2hkb2df
Y29yZV9kYXRhLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2Rl
dik7DQo+IA0KPiArICAgICAgIG11dGV4X2xvY2soJndkX2RhdGEtPmxvY2spOw0KPiAgICAgICAg
ICAvKiB0aGUgd2F0Y2hkb2cgaXMgc2luZ2xlIG9wZW4hICovDQo+ICAgICAgICAgIGlmICh0ZXN0
X2FuZF9zZXRfYml0KF9XRE9HX0RFVl9PUEVOLCAmd2RfZGF0YS0+c3RhdHVzKSkNCj4gLSAgICAg
ICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+ICsgICAgICAgICAgICAgICBnb3RvIG91dF91bmxv
Y2s7DQo+IA0KPiAgICAgICAgICB3ZGQgPSB3ZF9kYXRhLT53ZGQ7DQo+IA0KPiBAQCAtODU2LDEw
ICs4NTcsOCBAQCBzdGF0aWMgaW50IHdhdGNoZG9nX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwg
c3RydWN0IGZpbGUgKmZpbGUpDQo+ICAgICAgICAgICAqIHRvIGJlIHVubG9hZGVkLg0KPiAgICAg
ICAgICAgKi8NCj4gICAgICAgICAgaHdfcnVubmluZyA9IHdhdGNoZG9nX2h3X3J1bm5pbmcod2Rk
KTsNCj4gLSAgICAgICBpZiAoIWh3X3J1bm5pbmcgJiYgIXRyeV9tb2R1bGVfZ2V0KHdkZC0+b3Bz
LT5vd25lcikpIHsNCj4gLSAgICAgICAgICAgICAgIGVyciA9IC1FQlVTWTsNCj4gKyAgICAgICBp
ZiAoIWh3X3J1bm5pbmcgJiYgIXRyeV9tb2R1bGVfZ2V0KHdkZC0+b3BzLT5vd25lcikpDQo+ICAg
ICAgICAgICAgICAgICAgZ290byBvdXRfY2xlYXI7DQo+IC0gICAgICAgfQ0KPiANCj4gICAgICAg
ICAgZXJyID0gd2F0Y2hkb2dfc3RhcnQod2RkKTsNCj4gICAgICAgICAgaWYgKGVyciA8IDApDQo+
IEBAIC04NzgsNiArODc3LDcgQEAgc3RhdGljIGludCB3YXRjaGRvZ19vcGVuKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiAgICAgICAgICAgKiBhcHBsaWVkLg0KPiAg
ICAgICAgICAgKi8NCj4gICAgICAgICAgd2RfZGF0YS0+b3Blbl9kZWFkbGluZSA9IEtUSU1FX01B
WDsNCj4gKyAgICAgICBtdXRleF91bmxvY2soJndkX2RhdGEtPmxvY2spOw0KPiANCj4gICAgICAg
ICAgLyogZGV2L3dhdGNoZG9nIGlzIGEgdmlydHVhbCAoYW5kIHRodXMgbm9uLXNlZWthYmxlKSBm
aWxlc3lzdGVtICovDQo+ICAgICAgICAgIHJldHVybiBzdHJlYW1fb3Blbihpbm9kZSwgZmlsZSk7
DQo+IEBAIC04ODYsNiArODg2LDggQEAgc3RhdGljIGludCB3YXRjaGRvZ19vcGVuKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiAgICAgICAgICBtb2R1bGVfcHV0KHdk
X2RhdGEtPndkZC0+b3BzLT5vd25lcik7DQo+ICAgb3V0X2NsZWFyOg0KPiAgICAgICAgICBjbGVh
cl9iaXQoX1dET0dfREVWX09QRU4sICZ3ZF9kYXRhLT5zdGF0dXMpOw0KPiArb3V0X3VubG9jazoN
Cj4gKyAgICAgICBtdXRleF91bmxvY2soJndkX2RhdGEtPmxvY2spOw0KPiAgICAgICAgICByZXR1
cm4gZXJyOw0KPiAgIH0NCj4gDQo+IC0tDQo+IDIuMzcuMg0KPiA=
