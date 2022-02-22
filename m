Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB54BF3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiBVIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiBVIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:30:28 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288F157226;
        Tue, 22 Feb 2022 00:30:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8wNau4aEF0ED/kD+xbgPtMxfUtpykrpZ0uXvp9mOGNyMt4YdI+4kS3IIUigjkjMXDpbUQ9ZgNFOhhGEZRzqsnvWThgsWqVGGsOO0mcNfB6uRjnHHbljM0idSjXGRSOzsSyncFVPnyVLSD3+nhq3fmLAN7P6akFntvETCVLKv9r2OC9nrRymCHvkjf+Qkrkp2RBggaBBH/YuPGl3swWJlmuEIi9oKNG0GavRfoHsJA6r3/XViB1DwP78WykxdCudXo2Vl/KonqQPQu+xQqmYCwxSmnpRol2jotmnW00uiOfAQlk+bg1vCgUEOKvwoI2aS1sksF/7QFNfyteXXc2Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIY7yTdwUpNyKE4iWESatjCc6A/KAMvK/J3M7C7VAQY=;
 b=odLXEdWfPPxepwcA+rjuKIgJXHSXOcd1NoVlGG1tBe2FLdSDH80GxeoVlR+fgN5u1UfRMyCDiz6QjzlkKWmb7T03qsHJIitI42lx1o9D8xME6aAUtup0v0YzxgaqauomXYIhEZy1lZv7t1bDC1HxtvGgN3GsMHSxOIr432yHo/PY3LBe9BU8uXptP00IQ0Zjcp3TJk0wHtjJbDiwe/lbOvNcfglDZNzxLPtnXMjbJFOuB14awxiJIR1QZ/Pr3a+mqw+Q4vh5A7GZWIBDs5dpqVbn3ple1B3wPdXbi2VW4dAYb+b//H7RO1zpgcOCNk8YMMA8d596Pdo+1uPXdfYeDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIY7yTdwUpNyKE4iWESatjCc6A/KAMvK/J3M7C7VAQY=;
 b=vymqFuVeOlrtZGcG+/knCDSFOrR7oOQtpl9AgJJD0HXan2iBdW4W07VUl9HOKz9PmqLW9vKJdvaQwbGMa75a2GRrib9kiC9FG8rEyCnbu+26DkrTcZ1/4rYaidxuOzOV/Aq1+qoXbFxGdrfKNS0FF/yDFoyYfBINxmaspMf4LqE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB2111.jpnprd01.prod.outlook.com (2603:1096:404:5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 08:30:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:29:59 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: RE: [PATCH] soc: renesas: Kconfig: Explicitly select PM and
 PM_GENERIC_DOMAINS configs
Thread-Topic: [PATCH] soc: renesas: Kconfig: Explicitly select PM and
 PM_GENERIC_DOMAINS configs
Thread-Index: AQHYJ3HzWLEfL548/kuugXabOnUd/ayfOQqAgAAEkaA=
Date:   Tue, 22 Feb 2022 08:29:59 +0000
Message-ID: <OS0PR01MB59226DF1128AE3BBAEA2E96E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220221222450.5393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVb38_nhxVqUdtedyP0wMWmgkC-4K+OgbY0bOO8Hw4w4Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVb38_nhxVqUdtedyP0wMWmgkC-4K+OgbY0bOO8Hw4w4Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32670b86-67bf-4867-fe63-08d9f5dd83c4
x-ms-traffictypediagnostic: TYAPR01MB2111:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2111B3AA90EA024A7769CC7A863B9@TYAPR01MB2111.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKjB6WpvhgCj7rhW1f1oAsS4HaYopj1vmQZDN1O7gtzZVvgoJNnoqHWMqMWhpr5CT7FJIwj+ggxUEWHTGkd7TJhoKuw8I+KKToyZZp7/BfpEk/1t7V2aNnH1Hvg9mB1QNgMixon8XAeUcMeXwKQCDS5Bd0liXYw4dWR+lfHc19gd8JxFDaJZAFvyLofuHw2+z5+ngjfFoJ9RRpsZfGBcw+5/BJ26a4uMVZ0oAI/U5+wqjxD3kYYmdYWNTBOPs8IE4IXibOl/m8TLSbe3ECnRDxRTldTDsAR3Yo28Vf4kv3vs9Eru/SjUS8bEX1GFy9zhorq7R0GrqvYr0zBmP2FGQTpjZHcREPgTOw49y8FVkZZqS4mXKk5UnH0ou4zi7N3CF8mucQKM0gEwk6kI/3yZht25DMIK5Dl8hRsrUefbBbtW2Ff5cwnq5yxhCye+p5i0Tb5ZtrPQ7pO1kKeCtJDhqKRn3jBCvAixjwQvWv9bQF6Ull8usa8y4Ipft0I8sRECvdTyFnkqQbesG3wAhLCCb+SeIhE74shIjBKezN5WG3a8on9GEj+44wpE5xbMO7EfYQlHS3FyYjns7a7jg21B6E/qO56mSA59iitzVFhmkcbTN7upXBl0+2U9MsoVCm7dAay2mc1Wy6K4bXpLf44O3Nracw3xyfyJKZZj0wWBtHWV3FNo2xIThdnp/L34dxdpRtyCaaK3aPSoX8MOHvrUZ1Lhy+2Cgnnv/qIhPmqqyqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(508600001)(4326008)(55016003)(8676002)(66946007)(86362001)(53546011)(66476007)(66446008)(4744005)(64756008)(9686003)(76116006)(2906002)(7696005)(6506007)(38100700002)(71200400001)(66556008)(5660300002)(33656002)(8936002)(52536014)(38070700005)(54906003)(316002)(186003)(26005)(110136005)(6636002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVlmdy85WmdGQ0ZKeWNqbHMwN0ZGc3VnYzhiSHZvNGR4enVCTFFEVjYrS0hJ?=
 =?utf-8?B?UWdZUmk3eGVVaFBTV2R5NS8ra2NtRWh4SlFzUERLZk53ZmU1WjQ0eWdJMXZJ?=
 =?utf-8?B?NUhUNnBGQVRtRWxGdFVpSEVBVXJaVHJUNkNkdkhEb2JBSG9HMUlyZSs5SEhx?=
 =?utf-8?B?Ny8rVkpWc3pmZW9IQ3phWXNoaFNPaERyNDliTUcxN3BDemtzdlBLTElyN0hs?=
 =?utf-8?B?RnRoV2o1NGhLK1NtWEY0TEVCSElESGpSQ2RJV2lOUU5UcnpxajVFZHh6czNr?=
 =?utf-8?B?Mm9kWG1tTmRwUkt4S28xc1IyOHhIMm5jL3YwTS9kSTZtVXRPUjZjdEl2alZF?=
 =?utf-8?B?eWZTTE1RSWQzL29yRjVMa1BtbWF0UHlRNjVOMXBRNEpTbnA3QkZpQnVFR3Zn?=
 =?utf-8?B?NFpqZG1makl3QUoyWXdHU2RoVnVBUEhaR052V09JR2ZvbUM1VHp6cTU5Skxs?=
 =?utf-8?B?ZGVLRmM4dVZBUlFMWmtHdkE0YlBTU0M5Mzlmc1VVbWthZ3RGTkZuc0Ryd1Rx?=
 =?utf-8?B?RzYwTDFOUG4zckJjTTRES1gweVFJTGZNR0hSRWdIcGYya0FVa2lMOGhUNm5k?=
 =?utf-8?B?ckQwR2lpYW90SW1vQi9xOVdUUVE0L3cyU0l5ZVJHOUxXcEROYTQrRUZmVXhI?=
 =?utf-8?B?ajJHWGZ6emlsZUQ2bGpNUmp3UjJuLzlBeVo4MlVSalNSa0p2RXd1N2J6WWRy?=
 =?utf-8?B?Y1krWjNwckFsUThsU3VwdW44cTJLdGYwZG15d1RpcTMvcXJNOEcxT3Y3bXdK?=
 =?utf-8?B?eU1qNGdGOFdLdkU1RXF2K2dmOWd2U3dmM3RxRVVHc1dwWXVOU3d6V0xTS2Vy?=
 =?utf-8?B?SzVMWXo4Q2dDWmFXQThBOGQ1ZlJ4aVE2Z1d2ZnlKR2JzakhodUYveHIzM3A1?=
 =?utf-8?B?Y3ZxMHJHTG1vOG10Q1RUbVluMWk5b0pHdDAwRXc5R1Nuc0FmOE5TcWVqUk11?=
 =?utf-8?B?TjVZYnVndWozU2VmRVhtMnN1SnJNTG5jRUw1YUF0TWNWcnRmbEFGd3VOVjVh?=
 =?utf-8?B?STVEWjFWVHg0clVPdDZkVm5FSzJLNW1VYXRWa0pIYVc5bGxyKyt0bFYxSWFB?=
 =?utf-8?B?RVdxNDA2R1pid2lMTFNXcXh2bUFCb1N4cDM2bk1Xd3ZPYndXeGRPbmc1eEg2?=
 =?utf-8?B?ODFPQmRITWlsL0c4Sm1NTjZES2VBVXRhaWFucHZtNjZ6NDVJc0RJZkxTOGxy?=
 =?utf-8?B?VlI3V3FiK0J4SWdpeFlUZm80VG5CSkFlMmZHQnNOUm1JQTdXVllFM1dGVVZi?=
 =?utf-8?B?empTSFhTeVhlcFNQRnVIS1U5T3huYVBDUi9pT1ZhT0taTFRIMFRtRWJUYUVC?=
 =?utf-8?B?MXhrOEV1OVRmblAwazg0VS81cXlCcVpHSWJUZjdVWmY4ZzZOaCtycWF4MnBq?=
 =?utf-8?B?ZTFmUWppUmNnUUZxVUxBR1FkNHZHWWp0Y25YcW82YkNqMEdjSSt2cFRJRGtM?=
 =?utf-8?B?R21EZmlPQmRMbkR0Q0h6b0lERGtrWDMrQ3B4dkJYakU3eWd0REpGL1VEQ1Jp?=
 =?utf-8?B?bGc5akYvcEtQWkRlUXU2UG9hbXdKNGJsS0FKL0lhMWR3REwycGk5OE1IQ3c2?=
 =?utf-8?B?MnNLSVJIbEJYRjhYUUFySzZoSURJRkRmZFF4bUpsVHkwcERBblNIeU1zMEE3?=
 =?utf-8?B?d29ERjFxeEVGZmlpTTFQTEFmSHhFTVZQZFdQaEtzbm5tVE52bmxleGR6TldH?=
 =?utf-8?B?VnI2bVR6RGlKcVpiVm5kZnBSZ2hKdXFYODViTFNpb2FUZWxrU2dPaWRXZzFm?=
 =?utf-8?B?Z290d1JmN0l1Yi85ZjhDSm9mUlkzNmZzVldJbmo3SUJJQzNXaUVVYTZIdnZP?=
 =?utf-8?B?TUZjbm03bmlpVDdhMHZILytvQUVVanc2S3VRL2JYbGZCMzZJTjNMNFNYVXNE?=
 =?utf-8?B?SzQwV1AzWnhIVDYyd1FYMERmbkNDNG5vWmJWZEo0b1VSZlpPemkwOVBJU1cw?=
 =?utf-8?B?cHhkYnE0dFBxeXZ5Q0xXc0pNQ0RiU0xtdXVGUU9lckZ2L0g2YXE4UnphOVdE?=
 =?utf-8?B?azZlMndiU0c0cXBLQWMwSzZPaEZqNkV2b2FLenRlTjNpNXkzSE5kckF1YnQr?=
 =?utf-8?B?blpOZUFHUWl1UDR4R0hKcFR5QlNQZ2V6YUY2ODltZ1YrNEt5SHR1Zk9qQkc5?=
 =?utf-8?B?VnpBeVdha0FkT3I2aEdXWFVyendnZml1YXZDdFFUNHR2Q0ZOc2svbzFWdkhX?=
 =?utf-8?B?aUFITldyVEFmd3BmOTNyZnZBVWZKNi9tamtnQmNYcUZYRXVIQ0ZvYkd5bkZW?=
 =?utf-8?B?eDVqb3paN0lvRkRlL3R2R2F3YzdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32670b86-67bf-4867-fe63-08d9f5dd83c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 08:29:59.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hk0TZPtCqe4aeq4QsOKp3UrKZc+k6b8bw6IjK9h2Ni8Fkau6BjmquqyTm4qNapKEQ1oaaDjG66/CCXCHrz86eQDLmWVOl5T4Hq111Q4uUv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb2M6IHJlbmVzYXM6IEtjb25maWc6IEV4cGxpY2l0bHkg
c2VsZWN0IFBNIGFuZA0KPiBQTV9HRU5FUklDX0RPTUFJTlMgY29uZmlncw0KPiANCj4gT24gTW9u
LCBGZWIgMjEsIDIwMjIgYXQgMTE6MjUgUE0gTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFk
ZXYtDQo+IGxhZC5yakBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gRXhwbGljaXRseSBzZWxl
Y3QgUE0gYW5kIFBNX0dFTkVSSUNfRE9NQUlOUyBjb25maWdzIGZvciBBUkNIX1I5QTA3RzA0NA0K
PiA+IGFuZCBBUkNIX1I5QTA3RzA0NSBjb25maWdzLiBQTSBhbmQgUE1fR0VORVJJQ19ET01BSU5T
IGNvbmZpZ3MgYXJlDQoNClR5cG8gQVJDSF9SOUEwN0cwNTQgY29uZmlncw0KDQpDaGVlcnMsDQpC
aWp1DQoNCj4gPiByZXF1aXJlZCBmb3IgUlove0cyTCxWMkx9IFNvQyB3aXRob3V0IHRoZXNlIGNv
bmZpZ3MgdGhlIFNNQVJDIEVWSydzDQo+ID4gd29uJ3QgYm9vdC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2Fz
LmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVz
YXNAZ2xpZGVyLmJlPiBpLmUuIHdpbGwgcXVldWUNCj4gaW4gcmVuZXNhcy1kZXZlbCBmb3IgdjUu
MTguDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4g
SW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBt
eXNlbGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkg
anVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
