Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE458956F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbiHDAqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiHDAqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:46:02 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2068.outbound.protection.outlook.com [40.107.114.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C960D5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvof3v+SC329lhE4RS6rJkDNb4BR+unvz3/LCVicQMtVnubxJHB42t/JMxHY8f9S5e8SFfKPJAWuX1ptRYWIlm2EfnHUY2riEuAnZulIrQw/mn6fy+IdXhHU/x5p8R8IiRWri1STItpPxLQGGx7hiSBuecdWXykfz6p3v2/Gaqtxh4xS13sofnFAU009Vjk0kpD0zztEiJ/dH58792pIc/ASk/rGb+uV37/vxN5RTB2v4csSIXlJ6wPYO1EUtzVQshkJGvfJVYFpO9wLxR9gLhZOyLvWwtQpSke1a9n2vue1bcmpdEIAvQ2tR+uGESWWs5ZegaMdJkm4JVJMEmBhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8dpgxdL9UdQU7hVJPoQIntM/4R2UMcQm3oaxiAOqLI=;
 b=PGfEJ1Ox2WiOYp6hXB9Srfo2QVG0BvhQBnTN6qnJ+fkd8735FRv9OHMh4MZi9v9M+QURGQJf2cEeO0aP4bxYqEbfv7xVKQO5R45LKQ6P8+ek0BK4eyU9tYYypcD4Fm4Xgpw27TFqBvye2TeqV7HbrW1E7BPnSEfVYMFFTZZ8vzjpT33fRyIzxIrvCIwEEXYIrOMBNmG1B8tzyHLlv/u+V7fHmcfn2BOM1mtr+0lvpKeoBPMeCzWTW6tfihf0CPKcciwscnXk1fZomenfzj93HbBBtKrPVM0dYCUACi5HJ1mLKjaUqed3nFIyfeRsV6EXrJbUtlUzUwy281tLQUoKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8dpgxdL9UdQU7hVJPoQIntM/4R2UMcQm3oaxiAOqLI=;
 b=cFp8YkFd/f2vlezT96WlesvmrOgL5k/Ge3Cv8XnwNGs242elCxURpDDWr+Eqiy1XwOCZqCVCWlEPb3ucKcv/+Kt/x2EfYBCU4qlgW1h3HrRJhXlVaSs+z/FpwCo1tuPZ7pgiySd9m3XM4S2vv5Of4Ely240GDtJcl5DqejiTiR8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB4018.jpnprd01.prod.outlook.com (2603:1096:604:31::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 4 Aug
 2022 00:45:56 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8541:c36f:a141:ddba]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8541:c36f:a141:ddba%8]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 00:45:56 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memory-failure: cleanup try_to_split_thp_page()
Thread-Topic: [PATCH] mm: memory-failure: cleanup try_to_split_thp_page()
Thread-Index: AQHYphUb80dhoRKVUEaemS08peYHT62d6u4A
Date:   Thu, 4 Aug 2022 00:45:56 +0000
Message-ID: <20220804004552.GA3631345@hori.linux.bs1.fc.nec.co.jp>
References: <e699cd23-3eeb-7920-accd-b30622efa551@huawei.com>
 <20220802021256.162269-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220802021256.162269-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 185a7ed2-5592-4e8b-805e-08da75b2b171
x-ms-traffictypediagnostic: OSAPR01MB4018:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DuX1QuqfHGgURioarTS1zx2ZObpXJ1aY94rWNhipvEnSxwRqExsnvsgiAyvqE7ozXk0/uSDniNtBAULJvUy/tOVkh5cDo055VU/M9SyywyGaXrfICSM6XgKZfcTf/yMZ1HyXynmPYp0QVEFgEeFtY891gQzhrtEPtErXP8S6Gv4Z3DqJ087xIk62vWAXwcASjD8uMpX4erkIttabyEeuzqEves7Jg13MFdessTEHbxQ406YsQCRYrQfAYb3aeLDgKaV9Mu/dtRLnWcbsn5hUPKA8QjkACIFVtodDg7MHfaDQWYYhEbPE8PHbBlIxQvIC7a332/cGm93+cEiDEna7ABidiew2PjtQjYGm0oOeDFnnlo8XtFiG0T8gWY/WdOi4LmbR9t2tXd/fiTm3uGZ12pFv10C253zUU7FV84CQCmDHVl+mnN++4sSmutjn2JolEZB3ylahrVVGIkXg4i3WsYcOneEPNtD2EPRIgV4wxFpDqp7qYWfrpbYyKvMfIy6Gxai8WixHGdqJbQgXLcaYdRtxXdLRoVWbcnic9cwOy/mkcd9mcyFd61ZP4sjWNa2sexqxNV0LqYO5LCkBvhf3wyy2ikcLusqMtinktyWFamZ8ImPcc73McDJ0/LqzdPjqExIXKJiKxWjZy1zbPJwx4nOUfv/dnjAfy7JkaXfajT3yINn2CwqlNLZVVxlY4xM7uis/NqTanP/Cg0HIyRYUJmN+pWywFexxYDPCtt5dFEoxOITSMBxHHdhSkslMilWFPN+E19XIyL+XSI5Mr2WUWNcTs2rwCZ1PE7x9DO5RRiQTClE9JxS1y/LJVZbKqxFpe72BrwEocwIRZlf8/jhEbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(6512007)(4326008)(66476007)(64756008)(66446008)(86362001)(66556008)(71200400001)(8676002)(9686003)(5660300002)(38070700005)(1076003)(6486002)(478600001)(66946007)(76116006)(6506007)(82960400001)(55236004)(186003)(85182001)(54906003)(966005)(316002)(83380400001)(122000001)(38100700002)(26005)(8936002)(33656002)(41300700001)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFhtUVlwRE9DMVRNWkZ1YzFoaEpHQ01NcVRiRDM5ME9Od0dENm1CMHdyRk9T?=
 =?utf-8?B?OUN3Zmo3S0xPcTIzU0pCME9hM2pWQndGRTAxQzVkM2QrZ1o5WUlDUzBLRVlO?=
 =?utf-8?B?YndKTnlycUI4bnowdG16TUQzU1FRMGdNdzlyOXBmQ3BZalRacW1vU1dsTEtl?=
 =?utf-8?B?bDZuZXpZUDlCTE44WktwNkp0WERqT3I2RVd4QWNQU1ZFSXJBVjVIQ1RKVW81?=
 =?utf-8?B?dWlDN2d2OW5ncndIcmQzTlVBYUlGYkVLK0I3dEVXd3lIQW04aTZUaWpWbkpO?=
 =?utf-8?B?OEY2NytIUmdpMDA1T3NWaTdQQytWeFJLdlNPc2I5U3RnODNCenZ4RTFmQzdT?=
 =?utf-8?B?L1k3WDJvdXlKd2hZeVBwbUlXZmJRY0JSWkJVcklraExob3RYZHFnVmlTc3Uv?=
 =?utf-8?B?NCswd1NMNkZiVlREcmdhZmxpN284Qk1VUEt0M0FuTUp1S3pZT29tR2ZwaXpN?=
 =?utf-8?B?a3ZydDBJQmRKaGtDcENSSUpFSnhaWXp3b1Mxc2pjZkxsa2lyWDBEckFBTXJ2?=
 =?utf-8?B?dGRHNzdYSmtFMUdVdGJoTWRTaFhKWHhlclpXQTgvbVlOOEZ0N29OOTJyNWdX?=
 =?utf-8?B?SUlESTRPNkFLWURtYStETWU5bkdpd3h5S1RKbkt5YnFWTGxTbkdDNW1pV1Z4?=
 =?utf-8?B?cmI5NzdsS0Q3YjRjelBobmdjZ2UxSE9Da0EwSjliRHpGWlRGS2VPU2MyMjJ5?=
 =?utf-8?B?dElTYVkweDNqOVR3TlUzazNTWEhpNGVhajloQlNhRDRtNGRvRlZvbHJnTlhn?=
 =?utf-8?B?TFZ0dDZjNm9BMmltaHBXVGpvWDdGRmVqQ2UzeTYxMk9haDBDV282RWV4UjhG?=
 =?utf-8?B?L0xOZldmZUNQMUlpV3d3Y09XclA1VGJIdjV2d1JSUm1FWUFDT1FsOTAzVHp1?=
 =?utf-8?B?VTFrVEdRc04rL2hLVERQRnhPdm5aMGFrTWVuUGZCQ1Q5U3JFNnVGMWFjQW1H?=
 =?utf-8?B?VXUvTU5TU25CMHcxdXoxS0U3WGhhQjRHUHJKYjZmb3RuSkJHM3FMaTR5SlRR?=
 =?utf-8?B?M2RqWTJ1VjQyZUlNeFlHM05DNFBqN3liS3Y5WHdFSGZ2ZTNqMHFhTklaUWpM?=
 =?utf-8?B?a3RwcWlYR205SlZmS29uQ1NBUE80YTdYZE1uemVKdHB5N3FTZ2Juc2xwUlli?=
 =?utf-8?B?SjdYYVpaRTVEWmpjWHdlVURnVjQ2eHljZjlyZTZSNlgwRDlsYVUrMld4L1FD?=
 =?utf-8?B?UG1hOUtpRTYzSmNLZlpiQlZ5TEo5WjBqOFdQVFB1aEk1ZzlwanN0YkJwbUFm?=
 =?utf-8?B?QWNnL1Y2eVE1cGIreVVyRGoxVkUxUW5uUmRDTVFEYVQ4VmNHOVBvMDRmQ1hl?=
 =?utf-8?B?WlBBSTBsNHFsdEZhTTBPeDc3WFlSbGVGUFAzTm1xTzF3WEdkb1pIZXgweDNo?=
 =?utf-8?B?MUx2QmZMK203Q0dmSDVWK2dQdmJCNHdDT0dCcEZORGJaQUUvRldVekt1Tjcw?=
 =?utf-8?B?VkZ5TFJGb2pMTGgwdTh5YXJ0VVlzcmsrQ3EyV3BwZUV0dmRiNkNnL0Q1RlYz?=
 =?utf-8?B?YzVqUHozRGJmb0RPNlk2aXh3Q3IrWVo2eHZVTkhQak1vUU10MkZQVkVXeE50?=
 =?utf-8?B?OEUrSkM5NTBORU0rQ0FXbzJnOUhIc2xjdGhFVUdDYm5aYXBOblB6ajEySkI5?=
 =?utf-8?B?QXBxRjM2aU1Qd3VkNUtEQWNQQ2tnSVdxY1BxY0pRM0tjZlQ2Ni9GUXZHbGJx?=
 =?utf-8?B?SWpTdW9XZGtNK1hSeTJiUGtqODVDeFhIYzgvWkhiK1c3TERPS25nemtkS04v?=
 =?utf-8?B?OFRIb3AyNTRtbWozQ1VZUGlXM2djRFJCaWVuVkhXRVpZTE0xTVpMRG9Zbyt3?=
 =?utf-8?B?MkV1T2lVTWZxWkExOHBVWG9SWkhsclVocDRiM0oycW9sN1d1dWR3OFlJeXY5?=
 =?utf-8?B?NXdNNzBvcFFtUWhPY3lkRE0raGJWbW9sM3JOUmRNdFdyY0xsOVFZcmU3R3J1?=
 =?utf-8?B?aDNydzZXclNDZVlmV1ZoUUhIRGxLSDJPZVg3cWRMckk5Wldhd2wwWkdoeS9T?=
 =?utf-8?B?WlcxOUVtU1dobzREeHZpd1NuMkNKUjhaN056dlFKOUpWQlkvUmpUc0cyb05P?=
 =?utf-8?B?aXZLY00vK3RjRzRCZWRlUmlRMVJwM3BCSnBheWtsQmNibmQrMCs0MU9aeHFh?=
 =?utf-8?B?UW1pRTFwUUUwWkFnZTlJMTlUdURBMm9GY3NqcWhZYnBXSzB5KzkvdGlVMkNk?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <444A4A6C72F529439ABE2C9FA22BC3BE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185a7ed2-5592-4e8b-805e-08da75b2b171
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 00:45:56.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbixUIToffSxC0/35ncqOWc4nI7kizI4hy7WoiJGei2iA+Np1e5l7OWh/VwP1gekImkeZlvDHFSiQRfPoR2Org==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDIsIDIwMjIgYXQgMTA6MTI6NTZBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFNpbmNlIGNvbW1pdCA1ZDFmZDVkYzg3N2IgKCJtbSxod3BvaXNvbjogaW50cm9kdWNl
IE1GX01TR19VTlNQTElUX1RIUCIpLA0KPiB0aGUgYWN0aW9uX3Jlc3VsdCgpIGNhbGxlZCB0byBz
aG93IG1lbW9yeSBlcnJvciBldmVudCBpbiBtZW1vcnlfZmFpbHVyZSgpLA0KPiBzbyB0aGUgcHJf
aW5mbygpIGluIHRyeV90b19zcGxpdF90aHBfcGFnZSgpIGlzIG9ubHkgbmVlZGVkIGluDQo+IHNv
ZnRfb2ZmbGluZV9pbl91c2VfcGFnZSgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VmZW5nIFdh
bmcgPHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPg0KDQpUaGFua3MsIGxvb2tzIGdvb2QgdG8g
bWUuICBQcm9iYWJseSB0aGlzIHBhdGNoIG1heSBjb21lIGJlZm9yZQ0KIm1tOiBtZW1vcnktZmFp
bHVyZTogY29udmVydCB0byBwcl9mbXQoKSIgdG8gYmUgYSBjbGVhbnVwLg0KDQpBbmQgcmVjZW50
bHkgYW5vdGhlciBwYXRjaCBbMV0gaXMgdHJ5aW5nIHRvIGNoYW5nZSB0aGUgc2FtZSBmdW5jdGlv
biwgc28gd2UNCm1pZ2h0IG5lZWQgdG8gcmVzb2x2ZSB0aGUgY29uZmxpY3Qgd2l0aCBpdC4gIEkg
ZXhwZWN0IGl0J3Mgbm90IHNvIGhhcmQsIGJ1dA0KSSB0aGluayB5b3VyIHNlcmllcyBoYWQgYmV0
dGVyIGNvbWUgYWZ0ZXIgWzFdIGJlY2F1c2UgWzFdIGlzIGEgYnVnIGZpeCBhbmQNCm1pZ2h0IGJl
IGJhY2twb3J0ZWQgdG8gc3RhYmxlLTUuMTkuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1tbS8yMDIyMDgwMzAyNTI0My4xNTU3OTgtMS1mZW5nd2VpLnlpbkBpbnRlbC5jb20v
VC8jdQ0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0KPiAtLS0NCj4gIG1tL21lbW9yeS1m
YWlsdXJlLmMgfCAyMyArKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21t
L21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IGYwZTE5NjFk
NDQ4Mi4uNTk2MzNhNjE3YTBhIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+
ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTE1MjQsMjAgKzE1MjQsMTggQEAgc3Rh
dGljIGludCBpZGVudGlmeV9wYWdlX3N0YXRlKHVuc2lnbmVkIGxvbmcgcGZuLCBzdHJ1Y3QgcGFn
ZSAqcCwNCj4gIAlyZXR1cm4gcGFnZV9hY3Rpb24ocHMsIHAsIHBmbik7DQo+ICB9DQo+ICANCj4g
LXN0YXRpYyBpbnQgdHJ5X3RvX3NwbGl0X3RocF9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBjb25z
dCBjaGFyICptc2cpDQo+ICtzdGF0aWMgaW50IHRyeV90b19zcGxpdF90aHBfcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSkNCj4gIHsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICAJbG9ja19wYWdlKHBhZ2Up
Ow0KPiAtCWlmICh1bmxpa2VseShzcGxpdF9odWdlX3BhZ2UocGFnZSkpKSB7DQo+IC0JCXVuc2ln
bmVkIGxvbmcgcGZuID0gcGFnZV90b19wZm4ocGFnZSk7DQo+ICsJcmV0ID0gc3BsaXRfaHVnZV9w
YWdlKHBhZ2UpOw0KPiArCXVubG9ja19wYWdlKHBhZ2UpOw0KPiAgDQo+IC0JCXVubG9ja19wYWdl
KHBhZ2UpOw0KPiAtCQlwcl9pbmZvKCIlczogJSNseDogdGhwIHNwbGl0IGZhaWxlZFxuIiwgbXNn
LCBwZm4pOw0KPiArCWlmICh1bmxpa2VseShyZXQpKQ0KPiAgCQlwdXRfcGFnZShwYWdlKTsNCj4g
LQkJcmV0dXJuIC1FQlVTWTsNCj4gLQl9DQo+IC0JdW5sb2NrX3BhZ2UocGFnZSk7DQo+ICANCj4g
LQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCB1
bm1hcF9hbmRfa2lsbChzdHJ1Y3QgbGlzdF9oZWFkICp0b19raWxsLCB1bnNpZ25lZCBsb25nIHBm
biwNCj4gQEAgLTIwNzksNyArMjA3Nyw3IEBAIGludCBtZW1vcnlfZmFpbHVyZSh1bnNpZ25lZCBs
b25nIHBmbiwgaW50IGZsYWdzKQ0KPiAgCQkgKiBwYWdlIGlzIGEgdmFsaWQgaGFuZGxhYmxlIHBh
Z2UuDQo+ICAJCSAqLw0KPiAgCQlTZXRQYWdlSGFzSFdQb2lzb25lZChocGFnZSk7DQo+IC0JCWlm
ICh0cnlfdG9fc3BsaXRfdGhwX3BhZ2UocCwgIk1lbW9yeSBGYWlsdXJlIikgPCAwKSB7DQo+ICsJ
CWlmICh0cnlfdG9fc3BsaXRfdGhwX3BhZ2UocCkgPCAwKSB7DQo+ICAJCQlhY3Rpb25fcmVzdWx0
KHBmbiwgTUZfTVNHX1VOU1BMSVRfVEhQLCBNRl9JR05PUkVEKTsNCj4gIAkJCXJlcyA9IC1FQlVT
WTsNCj4gIAkJCWdvdG8gdW5sb2NrX211dGV4Ow0KPiBAQCAtMjUwMyw4ICsyNTAxLDExIEBAIHN0
YXRpYyBpbnQgc29mdF9vZmZsaW5lX2luX3VzZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiAg
CXN0cnVjdCBwYWdlICpocGFnZSA9IGNvbXBvdW5kX2hlYWQocGFnZSk7DQo+ICANCj4gIAlpZiAo
IVBhZ2VIdWdlKHBhZ2UpICYmIFBhZ2VUcmFuc0h1Z2UoaHBhZ2UpKQ0KPiAtCQlpZiAodHJ5X3Rv
X3NwbGl0X3RocF9wYWdlKHBhZ2UsICJzb2Z0IG9mZmxpbmUiKSA8IDApDQo+ICsJCWlmICh0cnlf
dG9fc3BsaXRfdGhwX3BhZ2UocGFnZSkgPCAwKSB7DQo+ICsJCQlwcl9pbmZvKCJzb2Z0IG9mZmxp
bmU6ICUjbHg6IHRocCBzcGxpdCBmYWlsZWRcbiIsDQo+ICsJCQkJcGFnZV90b19wZm4ocGFnZSkp
Ow0KPiAgCQkJcmV0dXJuIC1FQlVTWTsNCj4gKwkJfQ0KPiAgCXJldHVybiBfX3NvZnRfb2ZmbGlu
ZV9wYWdlKHBhZ2UpOw0KPiAgfQ0KPiAgDQo+IC0tIA0KPiAyLjM1LjM=
