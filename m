Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE64FBCDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbiDKNQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbiDKNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:16:30 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2056.outbound.protection.outlook.com [40.107.114.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55525E0E2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJXSP1lddjzOeHsapJrJa6XPAEMc9TmmIqHS+aCPsT+pdPRzEWmK4yqEJr2kJD7oRakBwcb9vElc9rYx3SXZCREgMV1WHJkTV2LDUq3DQYamoOHNGhiXtYJy/cDnCaCV6hGL+chSrfUuTRjjCnHp/y9+7mrBYgd1QVw67asXEDGAPXpBA6RDZMM/mMZdLjfTfSH1iW7nBv/6G7b9Vaj4PeAdOhzJ4TOWgoSqRRi86unG1vRQd+z8vX7Ovr3761Yq3wF+bdlm7q59WVmZH+DMxMmQMyCY12CZd3F6rVn6DXo2sqZCbxtzkhOYMCnWR5w6YIj9ycMxc6c67vU70QkcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+CKBonQU7ILzjCNB44u9IpoL1UWOW9t2P8LUquCPvs=;
 b=eVpe9yG88IM/T5qCOo48E+vjYwcXKoqI8JQqRKZrvvcxMWMKsXc+HFcMrUcYQxIWkU42mV2nlsQ7QuA5MozB/SDYDK4HXte03wBbMKOZ/lwHFt2AunlaaqUCX0XDMC/AyjbHsJ+eRQRA23paHntbayuOEdZ8MdXf0nsVYVket4f3PCozA43q7WLQY/i1SgDSTyC+QnlJygqOcCjzbZ+lpx9eewiSeoShRQxCawBbqKC2JZ56VAef83CDnVR7IxheKUXDqjWWv59wYjMHbdEESHKPWutMpn3PoBpMi5g1RUbJq+YoRRE+T7sW2bcdGFaMGiRELObqL7SkLFTrxbleDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+CKBonQU7ILzjCNB44u9IpoL1UWOW9t2P8LUquCPvs=;
 b=kvxUSshvRoxQJa03bxGIVYR+9fUshK03+vRG0vaXSrxWcb8/oPhM3QncEwFpbjL6Oak6f5+kFqda8ZySUCsBBCpa+UEkNYOzpQQDN/fq+nPLw0rbWcrgfru/vTOVWgH4QpBeYMsDf5oRDno8MpBFwee2UY6Mx/vo6gbqo6WLm1g=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3846.jpnprd01.prod.outlook.com (2603:1096:604:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:14:13 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5144.028; Mon, 11 Apr 2022
 13:14:13 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm/memory-failure.c: minor cleanup for
 HWPoisonHandlable
Thread-Topic: [PATCH 2/3] mm/memory-failure.c: minor cleanup for
 HWPoisonHandlable
Thread-Index: AQHYSn/3SRsILIXWMkC4bqVkSAfi+azqtxOA
Date:   Mon, 11 Apr 2022 13:14:13 +0000
Message-ID: <20220411131413.GB3188122@hori.linux.bs1.fc.nec.co.jp>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-3-linmiaohe@huawei.com>
In-Reply-To: <20220407130352.15618-3-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aca5a023-5eb7-4014-9ce5-08da1bbd2c7d
x-ms-traffictypediagnostic: OSBPR01MB3846:EE_
x-microsoft-antispam-prvs: <OSBPR01MB38464484847226E0CD9B9AC6E7EA9@OSBPR01MB3846.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ec6b96el82ffdPhQLEhRxZhKmCBtmguQKgFECoY8cXaDNI5VhzbYoOAackP12zX6A9JkNPf43nnXQKWUMsrr4w7SMuDXPKd9xthrZcq7wc8QNYtngVgPGk4xcK0TOJkMRIAwzZo4y/+iEXSmJR2bs1xkOtkmb8V4OH873yAymBDrehFEdWB8iDCnpdo4gZ84ZS8QS+l76g2cNL4HDtq8bxekK0AD5VEOw4g6L5PVBhvkwCL0OPvC1O9FhUjtNUIBtdlm7mx+xOAbnjVU6Z4NNfCf+EBf5JhXsOMbiKVHMtIKZS6Z9TziiNJxOC8MO2g2klN+5yHAM3AUfj5j5lP4wVq3KKl31roO+E5xYxNfHNgIG3hOpCbW3dH3iPzrAqYyeDXl/wMdCv08fDqCXeUR0PynxXq17PfqVIucWGehcus4Aw0BL67PUZ5OECLkS1i6Wk9TyshCPluzb5t/PFig2eQeBVvNPCDipwKLFYOvAC2gl5W8x+eLMowVAR6/k3XEePQ11Y0BOOeOwGhkDZ8+DuBQkB4WHRqWQD8IjPLJuy/nBkBNXJT1BSuFdl8FYBJ7xMI/DKfsCYIjzMCTAahgG3juYCKtnm98EZ5q60QBM/F8OaJqszY0KSJmP3vkkDh2DyhWFRmFq8GKrJ0/nQ5hHC7abSYKV/qlJS8DMakQY5NVNGVny+eVym2HzVXRwiGFWVko6x/jJS6XVPMd/3KmaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(38070700005)(6486002)(316002)(33656002)(54906003)(76116006)(82960400001)(6916009)(38100700002)(5660300002)(8936002)(508600001)(186003)(26005)(9686003)(122000001)(66446008)(6512007)(64756008)(1076003)(85182001)(66476007)(66556008)(66946007)(86362001)(71200400001)(8676002)(55236004)(4326008)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0J2eStKRGI3aHU3bE4wQ0NIbk93QmxiRlRuREYzUzB6ZnJsNDVGbEZPTGZR?=
 =?utf-8?B?TC9kWFJQUFdOb0tOdmoweXJPOWkzOTdqWEtmeC9ZTUVBdWJwRGxyTUg1ZHZF?=
 =?utf-8?B?ZzQ1eXlRYlRVZHFMc1NESjFKUzgzVVh0eUU2R3dobFNJU2xoa0p6K1U0KzUx?=
 =?utf-8?B?WFA4b2g1R1NFZmg2TlViM2hMcm85Um9MZGM5V1hOcHNsNmhQMjl4cVFldks5?=
 =?utf-8?B?L1ExYVg2M2YzU1laRktaQU9lVE9SYUtEM3BrcWI4RzlneS80SEpCaGdaeVZH?=
 =?utf-8?B?NHJCdFZRUE9scU9jbkYwemFNeFJlTU9nN3VkcEV3b080UGtSc1VKZDBGNCtR?=
 =?utf-8?B?eDdYaHRXWXBxQ2JvTHFTVW51cUk5dTVuaHZmSVQxSHVJa1QrU016Z2plNTBn?=
 =?utf-8?B?WHFGTFR6cWdYQVFkdnYzRXZZT1VaUEJjMW9pRGtjeGoySFJnWnF1Um9lbnJM?=
 =?utf-8?B?WXl4WnkrQkkwVGlBenZCTmx3YWIrN3ZoMis4aXlBanNLZ0Q1UEVjekplQlJm?=
 =?utf-8?B?bjFSNUVaVXZMR2ZhdXZmZGIzOTVsTHZxaFI2b3VOL0d5Q1hPakdNS3VRZ0cv?=
 =?utf-8?B?S3hjK0NQTURGWEJQWFNIWnpTemRzTG5POWdvcndaemk1VW9hSUZLZDlsM2pD?=
 =?utf-8?B?ZTZYRi9Wazh6Q2FEQzVHZ3VSVTJmMFJSMmdsb0VEQUozVHp5b0lNN2pNNlJt?=
 =?utf-8?B?QTJMcHhhRGtPRWgyVytVSHo1VlJSMkYyRDlmNjVSU2gxRFRJU3hmYUNmWmpP?=
 =?utf-8?B?UFd3U3JQNVZJRHpTOE03K0tLc0NIcTA1S0tvTU9DOEp1OUM2cEVYR3RiKzFr?=
 =?utf-8?B?bmRCOXhNajMvOGxQblAzZ0FiL3VNUWZmUkZESXorc3R4RXVCTkp2RmROeHhP?=
 =?utf-8?B?czFOeGluU2xVaXNyd3pUWHh4UXdRNVBzbEZFVGlnQm1xTDBVRjJReVJQL2xG?=
 =?utf-8?B?YkZiRFJjaFZxb1dWLzBGK1RzNmNYcWR5ZE9yNFJ3WHdwSm1FMk9ZVk92bURV?=
 =?utf-8?B?VXJaWm9udWk0RHJVeGVhZElDclh1MzBKb3J5M3hvdUMwVG1xM2k0a1N3R2FM?=
 =?utf-8?B?djlzS09ySzBvTURpQThTVHFERDFWUHUyYXpKYjQ4Qzdqa3RtTDBnR0dCQ0ZD?=
 =?utf-8?B?c1lVRGVCRXpGUUE5TUwzc1l5MitpOXE0Rm5WOU8wL3pacXN6N2tTa3dMaWRX?=
 =?utf-8?B?ZERKUXBmTlU1Q05rYTBNZkVhTXh5cXB2ZVFGdTB6aUw4eDVMYmk2N01NTC96?=
 =?utf-8?B?Qm51VHJNaGpXOThEYk52b0E5bFdlZjdSYUhPTEdJL3BUVHhiTHpoVHZmNTJL?=
 =?utf-8?B?NGdGckYydXpaTDY1TGRFdEIxejJ6Rlg0V0ljejRoSlBvWEtUMk1pb3kyM1hN?=
 =?utf-8?B?L3JvNTBDdUNtV1R0a2UrUGZXYTdrQmphMmRJd3YvenNhQys3ZmcrUmdOT0xT?=
 =?utf-8?B?STdXQWZtaU1JQlhhTmxqYkduV29rL1BsQ0xCdGpMa2IrNlpPSGRydVdVV25X?=
 =?utf-8?B?RDIwaitsbTJwYThrT1N1OTFxUkVyWGpMZ05IR3BBOENkdUlwbWxmZy9EcE9r?=
 =?utf-8?B?eDR4NFJHNGQvdk92MUNvNFdBaTNvdWR2dXJhTnBITUtpMXlVQWs5NnoyeDVm?=
 =?utf-8?B?VUtqeVRkcVVzM2M2MGJSSzZ1SXdFUDVweWdnOGJyUFhUSVVEbTRmUDFkdVk1?=
 =?utf-8?B?S2hLcnlGTUY2TzVhV3VMeklwWDc3dnJuL2NNN2hwMElYZEZqSHdCZU9pbFZX?=
 =?utf-8?B?VFhKZEV5TCtYUllXNnkxeTJqakYrdWVtckFqZHBZZU9QTXdMVVdpeDBwR0JJ?=
 =?utf-8?B?bU91Z2Z2aElzR2ZSK2pZeEpaUXBwTWlmSWExTjcrNHpkcS9jNG1TeklXOFJE?=
 =?utf-8?B?c25SR3dkMHNhUXZsNkptNldNVjRIbUFHR3NFWStpclBXdFdEWkJ5SHI5L3d4?=
 =?utf-8?B?ZnpUVlkxbGdLR3l0dVQ2cjVjUHAvSnpxakVndGo0T3paaEVndkRzbjZtQ21r?=
 =?utf-8?B?MXowTVQ2Q0YraVcyblZWdjZ5eElVMXh0b0kxUkR3azZSZHRjcmJ5YUx5UGhH?=
 =?utf-8?B?TStTc3Y3d0I4NnpSVm1pODhKQlAxMW1heEJMa3ZCV2xPeVo3bmV2WVZra085?=
 =?utf-8?B?OFVQczcvVjk3QUVUVXZzUVJWOW00V21uRnRrMTJJZUdaUEJFclBDME9yZkg3?=
 =?utf-8?B?eTJ2bjRpYkVmM0xxZDhSK1ZqQVBWd0NoWUMzYjdhS2VxN3pTODhnaG4yZmNq?=
 =?utf-8?B?dmVGOG8vOVNxMnIyZlFZZzFSZ0NnSndoS29HSStUZDNucHZvS1lJRGZnbzhl?=
 =?utf-8?B?QS9WaytxOTNNTXJDUU5zVTV3MHRkbGlFSERtcVF4RUVhTEVGQzBHTFllZzlP?=
 =?utf-8?Q?bk0nqBDM78w9PwE4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F337B0DD82F2D468C305FCBFFB20A24@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca5a023-5eb7-4014-9ce5-08da1bbd2c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 13:14:13.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXUL+DSMcR45O6WFfvhy54KbergD6dVKowajKGBssfv+wqM9aWQEDWaPlzcfca3sVtn7MPFBihUFoF6pLTUxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMDcsIDIwMjIgYXQgMDk6MDM6NTFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlIGxvY2FsIHZhcmlhYmxlIG1vdmFibGUgY2FuIGJlIHJlbW92ZWQgYnkgcmV0dXJu
aW5nIHRydWUgZGlyZWN0bHkuIEFsc28NCj4gZml4IHR5cG8gJ21pcmdhdGUnLiBObyBmdW5jdGlv
bmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxp
bm1pYW9oZUBodWF3ZWkuY29tPg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5o
b3JpZ3VjaGlAbmVjLmNvbT4NCg0KPiAtLS0NCj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCA4ICsr
Ky0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFp
bHVyZS5jDQo+IGluZGV4IDJlOTczMDJkNjJlNC4uYmQ1NjNmNDc2MzBjIDEwMDY0NA0KPiAtLS0g
YS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAg
LTExODAsMTMgKzExODAsMTEgQEAgdm9pZCBDbGVhclBhZ2VIV1BvaXNvblRha2VuT2ZmKHN0cnVj
dCBwYWdlICpwYWdlKQ0KPiAgICovDQo+ICBzdGF0aWMgaW5saW5lIGJvb2wgSFdQb2lzb25IYW5k
bGFibGUoc3RydWN0IHBhZ2UgKnBhZ2UsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ICB7DQo+IC0J
Ym9vbCBtb3ZhYmxlID0gZmFsc2U7DQo+IC0NCj4gLQkvKiBTb2Z0IG9mZmxpbmUgY291bGQgbWly
Z2F0ZSBub24tTFJVIG1vdmFibGUgcGFnZXMgKi8NCj4gKwkvKiBTb2Z0IG9mZmxpbmUgY291bGQg
bWlncmF0ZSBub24tTFJVIG1vdmFibGUgcGFnZXMgKi8NCj4gIAlpZiAoKGZsYWdzICYgTUZfU09G
VF9PRkZMSU5FKSAmJiBfX1BhZ2VNb3ZhYmxlKHBhZ2UpKQ0KPiAtCQltb3ZhYmxlID0gdHJ1ZTsN
Cj4gKwkJcmV0dXJuIHRydWU7DQo+ICANCj4gLQlyZXR1cm4gbW92YWJsZSB8fCBQYWdlTFJVKHBh
Z2UpIHx8IGlzX2ZyZWVfYnVkZHlfcGFnZShwYWdlKTsNCj4gKwlyZXR1cm4gUGFnZUxSVShwYWdl
KSB8fCBpc19mcmVlX2J1ZGR5X3BhZ2UocGFnZSk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQg
X19nZXRfaHdwb2lzb25fcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgbG9uZyBmbGFn
cykNCj4gLS0gDQo+IDIuMjMuMA==
