Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CF4B210A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348343AbiBKJIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:08:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiBKJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:08:16 -0500
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2120.outbound.protection.outlook.com [40.107.24.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41CB53;
        Fri, 11 Feb 2022 01:08:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et26xpEAEyC3fY3hw9yRjWbL/k8xs8c0dnNrbPbxs6gX2cnx6bwvXj72XJ3sFRO7AuakIlBlWnxwMBGrq33NkDdEJlM78tAju7vq+qzZYpygzGwB/NBoXpqrwhejhYJItx3a3oOpCA5JtaH9NJe+2FJQzN7Cfh7320UZYZAbf1ZErIsGL8p2u7kENXlGfpkT57+qsZ5Qxu/bTYCFHonPkNIFuk+y9uYy+uGlduQm5NK5whxO22J6BDsxiXisR8ubBjdlZ67ZqRhzKNCE5x05+JsgOu/v9HOY0hci/3grakKRxUhDeoJza/Im8HHGUsVAV/aOeXmuOLjBWHSkV+bSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+q2y6y+vZ6z4ZLssZAGsh//RJ4PKsIpusS5brBFHbs=;
 b=UuOMAuTrCVmfgBF6xBN/CBFgJMadBVs3ufqPNlXY0hubSOOPF9KvuDuTCrEq9OLbIy2wzpXlNOeNDcai3IS+LZrzrdWEWydSnO9Tg6DC92Yfw62TBSN2y1k06rNu3Cq7N/x/67Fb69BI48kr1EVfQOEMTTlNR/MsQUbFEc4JC22sdU48A/kabej1L3SQktWvDhoJu4UxJb4PqbZshYDiyMRrKyT2CjK6NHodKt0LzU782WBzbrdV5Bkb3R+LIrKcE3+fZA6RvaZGW6cGnnFvY8znFo0MSCaxs6WqTwg/CUcPF28Y9mq+mmQ37Zm/whTK8oVMXU8PrgjTYBeKOfs61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+q2y6y+vZ6z4ZLssZAGsh//RJ4PKsIpusS5brBFHbs=;
 b=js2nTa2gUXixuKKFRKrn8GgCALsXXUH83Js/uxbBOiscqRVnGWaJacOKxUp0WUiSq9UBvRfTYScLm6txgpd6zy8IXwPK4+pjTcmhOOVHZVO7byAf39ONghBeA+nHLBUHne6zby0Kl1ef3j2Or5hCI0p8yGyiReqKXzaqfBuIGhM=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0272.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Fri, 11 Feb 2022 09:08:12 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fd38:a4c:c1e:4fe6]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fd38:a4c:c1e:4fe6%7]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 09:08:12 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "clin@suse.com" <clin@suse.com>,
        "ariel.dalessandro@collabora.com" <ariel.dalessandro@collabora.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "alexandru.marginean@nxp.com" <alexandru.marginean@nxp.com>
Subject: Re: [PATCH v3 12/12] arm64: dts: freescale: add initial support for
 verdin imx8m mini
Thread-Topic: [PATCH v3 12/12] arm64: dts: freescale: add initial support for
 verdin imx8m mini
Thread-Index: AQHYFGBuYPjChd0xT0qJ2iCOxFJ/g6yOHPgAgAAIEIA=
Date:   Fri, 11 Feb 2022 09:08:12 +0000
Message-ID: <47fa53abeda5f83e910d04b2ce5cacdac49b5ea2.camel@toradex.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
         <20220128160100.1228537-13-marcel@ziswiler.com>
         <20220211083916.GP4909@dragon>
In-Reply-To: <20220211083916.GP4909@dragon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a49e42f8-1e73-49a0-317d-08d9ed3e07cb
x-ms-traffictypediagnostic: ZRAP278MB0272:EE_
x-microsoft-antispam-prvs: <ZRAP278MB0272E542BD015823AE99D13DFB309@ZRAP278MB0272.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+JkH9dv2iUlgHdqYA1KAkgC/GvYtRLdRaGNO45lTUUOo75llpaa2LXNQbEKgSVc7ycWZj28AGr98XmuEX2oh69vRqRcvtFjH7vAaB1HGoi1EqmgBXkxVxh+sKUFUKVE0tza/NcG7isEEmBEZ31JoxwRnoe9Fmknu/XhU23EyWiIPriIJnKl0WenHtStxgufScQHDQiVBME21JFm7yAOABROHFhg4IK0q6v9a8YEEliyK9tw7A4ZXqEZpxSZubRwPs6xaVveBv9RkRjMRotj5spEMf/YdZOGLAulh89zXuN62S1NpWhN2pXBuLa+LBgoViKpvGwxKBYrfz0Ac8duFB2TAcicmMD5wTPUFK/bl1EotvNEK3cOrZZYEDKIw0UOof54Gzu69+rzI39s7QYGXSRzr3+tS5d4dNmgNQiX29rh6GTIbwUNrUjJHuOOku/Dj2FQYBudHkK+yhaynhFhmTCnVVGiyl5dRuP5GPTd/lyzzFVMNqx7ASqqqj3OoCoQm2FTySpgvtuSTGHMIHsL9DXA/TJ8qIvs1vXJWQDIfPK+lzSThIAA9NCTSTAeP8pNU6XQ9kMzKRMlAXHxAor2U9KFk4hBByGYdkw7Ig0jAmAYfeV9dRVPxXUaz7b/LR3ByKkHmalRyxcE9tlkrAyLjj5gSwj0nCczYAm89yP+ESfXb1MVin+OQETeVxkTwHBsAY8Lsv2b8nPtwP/IMpyBBkJ2/iFUPHxs/eCLZglMXfM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(66556008)(64756008)(4326008)(66946007)(6512007)(8676002)(66476007)(66446008)(76116006)(508600001)(8936002)(2616005)(71200400001)(186003)(86362001)(2906002)(83380400001)(26005)(5660300002)(7416002)(6506007)(38070700005)(122000001)(38100700002)(4744005)(6486002)(316002)(36756003)(44832011)(54906003)(6916009)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjF0V1kvYWhzc3IzS1Y0L1FxblNjcE1zSSswTDQ1TTVhcWhsaVUxQldKbnh0?=
 =?utf-8?B?ZjY4dWYrK0NadmZETzA0UVkrU2JkYmhocERnak5sV1pqZ0hzcExSK29TejBW?=
 =?utf-8?B?SlJYQnV1aDRMNlVoSUdsUTBtSWljUTNtNlI4NWUwdjRXYWM5MDlMZHhFL3hp?=
 =?utf-8?B?di9BUzVHV3Ruczcxay9wdkVXZjg0UW16VHVNS1BWcVdOcVRBKy9sQkxsM3pZ?=
 =?utf-8?B?Y2Q4UHdPN2lpZmQ3SlRheG9obkI2aXZkK0h4M0k1RVdTVSsyT3VTM3huNWMz?=
 =?utf-8?B?dEttQjc4SzRlOGk3SmcwMEJvOWRiVENlWlJ5ZU5oQ3AyRlZ2Q2d6KzV4RTlW?=
 =?utf-8?B?eEU3S25EY3VGTXo2MElBOWtIY0VZTEllUVdTL1FubU8yQmx5Q3E5elVSQTlt?=
 =?utf-8?B?cjlJak1wNlArQXZmbGFTL3h5bFk1V1hJOFBJeXNZYnBVVjdibmtKL1VoUjNT?=
 =?utf-8?B?aElkQTRnYkxMTHdDZThiU29hbHowRko0bTJxZjdnMnZ1bFZzazJ1K2hhamIr?=
 =?utf-8?B?MnBCWVc5Ull5cmxOSlZTU09iUUNLWjltVmF6a0hxa0N0QVc0VmFWMktCYXNU?=
 =?utf-8?B?aXRwcG5aT1dpL3Y5Rlk5ZlFna2ZnSHZkRGY2TUNVaVZjS05veXlZQ2lBdzVj?=
 =?utf-8?B?TExmYU5DWXlaUVRaTUZaTTY5VFV3UWx0NXdSenNmQ2grajh4anBDUWQzUFZh?=
 =?utf-8?B?WVlDMVdjeVRBWG9LREVGWndwM1FmVnEyU2VOYjdzenBaUVdSZmpVZ1ZyTGd5?=
 =?utf-8?B?aHdkdHJRM2pkV1VGbDQzV0hLR0VibjhEbTBoQ0o4Y3VSM2NuSGlJekpRNGVP?=
 =?utf-8?B?aXZnb1psUXR0MjZmY0JEbU5lZXdZbXprY3VlN1pSSVcrSzFOeU9Ddm9yYXda?=
 =?utf-8?B?Zk8rc0FMMWtlYlRLN1Q3ZCtDVC9XRmRBbGNieTdFUS9zQVFYNXB6cXdlOXho?=
 =?utf-8?B?dXlHb2NSalo4R3VaQ0d1UXdNK3VWbHk1K1Y2Nko5TVd0UzNPcXBhNkpCRDNh?=
 =?utf-8?B?NGhvbTA3YzNESkhxem0ycTlwS2lLaWY5VVd4dEZxcTRxcXZPcXZzNUVIVjVD?=
 =?utf-8?B?ZXl3TnRscTM3Zk1qRURRODcrRDdsZC9WYUhOclVpNCtiYlBqQW1vcXA5alA4?=
 =?utf-8?B?OHh6aVNBMEdrMmQvUGl3YkZLZFUxdmtmSU5uTlV4dDVuUzFmdis3NHhJcys1?=
 =?utf-8?B?eVlQTzBWUFh4dlpDcVdWTnJ4M2hIdWdYd25QbTBXUEhXRzVZNDFQNTFGVW1H?=
 =?utf-8?B?c1Zkc0xwTjNkWkZ6UkJOb0UxNVNqT1FPQjd0ell4VmdNU0JnTnYrSm1lMUZw?=
 =?utf-8?B?Rk1rUVZvM0FJSFVlN1llTHNxc1M3QitMZVpjQUpkaThMN1ROY25iUENlVHZU?=
 =?utf-8?B?SXlIeW1EYlUrMk5VQkxrd0F1WEYrMnNWOGVQRFVkT3NTM3RBQnNPQjNhT2ds?=
 =?utf-8?B?MFhaV2tzbkhRK1hKTTBVZWJ3QW9wMGhIVkJTbzRwZDArRUV2bnVMUjdwUm5G?=
 =?utf-8?B?R25CTU9hbkJnL2VWc3pLT2xnbDhBbm96QTVwSVUzWXNCa3kzZmhUWXViQTR2?=
 =?utf-8?B?UEpWM2g4UHVpRTZHMi9kdkJlcytRdkx0aWwveGpKaThoYVRObzVxMW1aamZN?=
 =?utf-8?B?MnBBTlQ3aTRDcDNMQTdtcTFiUjVsM1BlaXJjaGhzWFJZekw3L1QyWnBGbFk3?=
 =?utf-8?B?cGhsaTI4YXVxQ1lOTkkxTTZSaW5vY0JDRWlqUTE0ZlJKK05vUTAvMXFIcHBR?=
 =?utf-8?B?VHpzYkF1bGZSRHAwSzd0WUxrYkxyNWk4eVo4QnBYQXB6SU9aejlyOXhGZzhE?=
 =?utf-8?B?OWNHcGJpTkxCMmhIdFkyRjR6dWFEVVU3VEFjRGVnMHNJU3pDMytXZVdOQ2Fv?=
 =?utf-8?B?eFRTSGFZeW4vVmthVmpUZDB6U09QOW9OdFhzMzNXMHFJN0VhKytYbzVJL2Vw?=
 =?utf-8?B?OWxZTkhEQUt1T2wvZmtrUEE4RnZRcFdJQWQ1eVNkcDVhVWIxeXhMYXh3ZzFt?=
 =?utf-8?B?NW5FWGxHUU4xUUdFbFFTSXEyZlkrNmZzRnBIa2E3UDdHWFI3NkZwMmIwNGk3?=
 =?utf-8?B?c1ZPTTd2cjBmTXNQVzhhMkpxaHFQdERucTYyeFA0eC8rMDhCM1QrcVRmdlE1?=
 =?utf-8?B?c1ZvaTgxTWNncjVYTlRmMzVUV0hQck9ZZ3UvRm03bGg4VC84WnZiNDkvSWMz?=
 =?utf-8?B?M2xpOWpPWXFNb0swUENmaHZ4bUhFVUZ0WjdKb1czdFR0ZzZZdXZCWk9ZQXV3?=
 =?utf-8?Q?ubUw+4W6DqvLJ6P9rjSvVeGIM2+Bpv554ZcxBAqIXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD71DA886BAA240B182A70060DBFAC2@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a49e42f8-1e73-49a0-317d-08d9ed3e07cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 09:08:12.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHoP0OdIHy0pj1yuDksD8HGFAve3lO2g2wRBvrUXvl2xExN2ngtwJDt79MpN6mO7gjpIbF9Nijz7OzdiV/KcB9VsasS4iAsla4qwxf51ntY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24KClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmV2aWV3LgoKT24gRnJpLCAy
MDIyLTAyLTExIGF0IDE2OjM5ICswODAwLCBTaGF3biBHdW8gd3JvdGU6CgoKW3NuaXBdCgo+ID4g
K8KgwqDCoMKgwqDCoMKgcmVzZXJ2ZWQtbWVtb3J5IHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxscyA9IDwyPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwyPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByYW5nZXM7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LyogVXNlIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbiBzZXR0aW5ncyBpbnN0ZWFkICovCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgL2RlbGV0ZS1ub2RlLyBsaW51eCxjbWE7Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcnBtc2dfcmVzZXJ2ZWQ6IHJw
bXNnQGI4MDAwMDAwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbm8tbWFwOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZWcgPSA8MCAweGI4MDAwMDAwIDAgMHg0MDAwMDA+Owo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gCj4gTm90IHN1cmUgdGhpcyBpcyBhIGJvYXJkIGxl
dmVsIGNvbmZpZ3VyYXRpb24uCgpZZXMsIHJlbWVtYmVyLCBGYWJpbyBtZW50aW9uZWQgdGhpcyBh
bHJlYWR5IGFuZCBJIGZpeGVkIGl0IGluIGEgdjUgd2hpY2ggSSBhbHJlYWR5IHBvc3RlZCBXZWRu
ZXNkYXkuCgpMZXQgbWUgaW5jb3Jwb3JhdGUgYWxsIG90aGVyIHZhbHVhYmxlIGZlZWRiYWNrIGFu
ZCBwb3N0IGEgdjYgc2hvcnRseS4gVGhhbmtzIQoKW3NuaXBdCgpDaGVlcnMKCk1hcmNlbAo=
