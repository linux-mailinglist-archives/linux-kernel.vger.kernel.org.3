Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B3D4CCFEE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiCDI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiCDI2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:28:03 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2058.outbound.protection.outlook.com [40.107.114.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB518BA5F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:27:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I12J6ahrUSoOFv+QDSnSPAKF0uErM1hkn3W6NtsavBQFH68L88k295FopDfVu6/SN7/qhRYIqn7CNwkBXpXb5pAQZw0SC5ITHJrPmli+dLZpr21rTJIskRbKvA5RPdjKNOskkG+sWc8/VvQCe2SYbg/bP2uZ15kuS/hibK19SPc8ApnfIF11Iz4t1X3tAV1eQbCuIwOajUeJTg50+74t6soym/DQNx3HmDkidTy9IXfevtMWBoCzz5236CVlXu/4vOTnx2nJ2buPDHXWpsl3EOlQt8P9Y8A1n6GDf4EmRuW5ilMRCTiYLPeXnoZ7l2e6VYq3007JIp5EV/js8RnofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNqBqJO/AI23E+HVgBMkcmmHHsFBox8j9f8Ws5NX0E0=;
 b=dVWvVHQ+dhAxVNeKILfhnWTv3l0xIfTxZMjD0+UJt4LD5S2R8s7mBtJz2mC+QcNC7mBc5xzPEXjBcQOHmBI0ZasgaTCRl7B5Dn1dTVLZTZOiZZ1uVpHFpyiEcijM2FVmfCiUskbyW5xQktXgd7vTxFbMIWBoYAWvBb3YLuEEVGxvsufhGgL5zV36Rb9liZ75ODjdEoN72Vq2qkZVXYpz6gJk1a0oc0OJyuBV/xYJIItHv49xtOD4gHftqPYZYw1VIjCC/Isit6KbVkjNY14+fUjlhSliPei07VMqhVQdYA1cQB/uRZI/cp2MVBfJzBW53ATh7gju/Pnn182AP2H8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNqBqJO/AI23E+HVgBMkcmmHHsFBox8j9f8Ws5NX0E0=;
 b=PwuO+74LycxSNE2+wAlGPoemMi+WcPGGuTCMUa9iVVV4VpxMVhOpG6JfYW2oGhjL54jmkY7aE2n39FSLMsDdswe7uFTKH/ztHw1W8qHWcWom4GXLsFm2y6XGDTW/FMK2RxUoXd98zPdP0tVlwYjsWIo0rRZTlfcyyGzvcLpuxG8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8311.jpnprd01.prod.outlook.com (2603:1096:400:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 08:27:14 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e%8]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 08:27:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm/memory-failure.c: fix wrong user reference report
Thread-Topic: [PATCH 2/4] mm/memory-failure.c: fix wrong user reference report
Thread-Index: AQHYLKwAiKH6A+1gAk6IfJHC4zccGqyu6fUA
Date:   Fri, 4 Mar 2022 08:27:14 +0000
Message-ID: <20220304082714.GB3778609@hori.linux.bs1.fc.nec.co.jp>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-3-linmiaohe@huawei.com>
In-Reply-To: <20220228140245.24552-3-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8036fc91-755a-4246-bae8-08d9fdb8c9ac
x-ms-traffictypediagnostic: TYCPR01MB8311:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8311927222EF6D4AF0CBFB4EE7059@TYCPR01MB8311.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjo8qJ0Hf3Aq0EhqmTh175yYnhxjQ2IXk75FG+E49EHhD8qQVA0CwAZxmgQhOlQTla2J3iUymiOVkKNhBEkqlO4ehrhSNxkzQpt/QXZxHPZp+KqSqpF7gpulorCxASjTK6LHgTqQb2wzXLc8ya2aLQWm3SWk9Zr2nYnlFNfAD0s/wFtwIiNk/EX/q+5sJwVLKBJ3bwaF5jv45A0X5680A2ZR1WdDMMMrKNH8yzLGg/lRBtIy+l/xVQX2iGqtAwcdZWmDFJwXTCAXbGSVr3FywcTYTWAYMB/9/ayKLvyAXucI09XF0A308TicQbgNjUtnix63lweBGkXp7R7SPjgkSSAldI9SrtwSfeGzyPUFGzbAPks2ejlCJEfbJQXoT1gDs+JGvxkvHqhU+2OnU4Sw1J/gZE/9TvR/vsr3ucsf+5ozylCzcNX19IITbs6Zpe30KinPyIRPhoLpGCskctNCu0iiGUlMNuhU/eOC5hQ/utO81jYYhfmhvssPXlVq2PLBMCKhIo7n9RtvRBytij/rzQ+gI5YR0xCWXdTvMLMkJug9pvXQfB7NUfQtMtINUlVVQDA10SFETGNFHqX+NUAU89HML/U8XkL3aH9nREm/rudYsaBEZGUFDiNqUaXrBozcaFqfGJNZKohZ2k19rnSlZFTr5VBV4ubzvUS6k0H7XrwWlSy+1uAY3HBvXzjvdZDgyqBtTWainTFQbFPd28pWXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(5660300002)(186003)(9686003)(71200400001)(6512007)(6506007)(55236004)(33656002)(85182001)(8676002)(86362001)(6486002)(83380400001)(8936002)(66446008)(54906003)(76116006)(66476007)(66556008)(38070700005)(316002)(6916009)(122000001)(38100700002)(64756008)(2906002)(508600001)(1076003)(66946007)(82960400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnRVY01FTmNVQlk3bFRCbGlsZlBBcngrOUkzODl2WGJFZ2M3SEFKRFdCVVl6?=
 =?utf-8?B?RDRQVkFqNUVrMzRac3g4cGtVMGpKUGo1dHNGa0RNak13SW5WQjlQcy9xSGVB?=
 =?utf-8?B?a3NhSGR5V2ZleDY4YTd2VFd3L1JabSs2SkF0UGhDSDh4ZHlyRytId1MrcXNa?=
 =?utf-8?B?QWNHclF3U2JYOFN5V1U1RGFxdGNnNXJiL2l2clFEN3Q0TGhyWEpWcGZ4UkV0?=
 =?utf-8?B?VWtPSCtzM0RMZ3dubWtPcDYzYTFmSlRPUXhCL2FwbTF0bkFwZ042cnBUd2py?=
 =?utf-8?B?Y05pcCtmV3Znb2JYaHduUStiMlBJczVYMUZHTUVjR2JLSUI0eDN0Vk5zWWJn?=
 =?utf-8?B?eEhnYWZSUUdlb1V6UnhwZXJTaGljdFFSWDNoaTdUSmtXSzBxRHBoZm9HV3kz?=
 =?utf-8?B?Z2QxRHlDWDFsTlVQM2p4cW9KTDRETHRLRXJuWkp6ZjJCYTY1Smc0OHdYbEtU?=
 =?utf-8?B?SE90ZlQrSCtQSzVaVUhLaHR1Nm40U1JhTHVTM3cwMGprb0xXZ3lXMWhBbnQx?=
 =?utf-8?B?eWYrQVU1V0VwZEl5eFVxS1V1OHJnWmZBYXB4TW1XNnNaL2NMZHkyUWFNRDZp?=
 =?utf-8?B?eWR0a0RtVjBWWi9waFNtTENRcXlDdGZHb0RpbVVsZjBXTGxTY21pWEx1SWpO?=
 =?utf-8?B?MVErdWJPRnVzV2JBZXo3TUMvSGt1MWtKTVZoT29QcFV1R0F6REg2Uk1TN2Qz?=
 =?utf-8?B?czlGZENSRHlFVGFaL1ZoSmVDQW03RGpCUkRQT3lpTmZXa0xCUzJuMG01WmZ1?=
 =?utf-8?B?dytpOTNnSGVTenpETUJsWDVkZVJ3NWo5MmJNU2VTNExUcDhoc0UzVUZiSXVR?=
 =?utf-8?B?ZEovVHJGckRQMHNJd2JMbnI2c2wzOEZabEErN0h0TWQzVXBoOSt1TUI4Zlo1?=
 =?utf-8?B?S2x3NlJkc3crLzZmMWdQMVI2OW8veVB4YllpZE5xZXBSVlNqTCtSeTJROGls?=
 =?utf-8?B?YXNaQkxyeVhic1RzeU5oYXJBUTRuZmFFV1JlMmQxc0w5TUhGK2p6L29LcWNQ?=
 =?utf-8?B?M3dJa0FxWmpaWUFZVWxUcHZETm51TGorUzREUVovNitKNStka2FpYzNNRDZs?=
 =?utf-8?B?VlY4NWxrNWNGLzBOYzdxbkl6QnlibzI0RDRTNDVBWk1TWmNBMEpwbGhOekJl?=
 =?utf-8?B?a01UOE1VVHdFZGdEM3RMZlQvckc4ZVJ2cmlyeUhKTjNvazQ3T0JjNS9aRkQy?=
 =?utf-8?B?dm9UOXNlY2d5RkgyTnR4enVVcmFjdkh5TDRvK29UZmNZanU5MktaSmMrOUIv?=
 =?utf-8?B?VFphY2lXSGxwMW84dUF3RlpGS1oxa3I2SUcwWXdYQVNUZWZVWXdsWGwzUEta?=
 =?utf-8?B?L096bUZSSm9TcDJXUmxLaG1HQ3V2M1RUMGZiSElQaU5VT240TmFKenJrN0k4?=
 =?utf-8?B?RFFRakFCUDZVTzFvaFVuL3hjMHlOaGl1L21NSlhVU2JzNEgycDlrb2xHQ0ht?=
 =?utf-8?B?d1RFMTcrQ2R2ZGpCVnpsNmo3bldwWER2OVRxeGxkenVFbWFVcEs5YnUxRFhI?=
 =?utf-8?B?V1ptYS9VV2M3QWYvbUlqN3prTkRYWDVtUGgxanV3U04yNTZjN3Zpc3J1N0hJ?=
 =?utf-8?B?L0lwdjlaU1QxUDR4dWtJbmRTLy9mVlNlUHJLRG85SkFqUzZxMTdEczhTb0Zz?=
 =?utf-8?B?U2xUNURGcGZYakdaTms5dUEycm5WajV0TVk2bzBsVS9sWTE5Y1p0YW1yM1VH?=
 =?utf-8?B?cERzUE5La3NqdU1LeElkSzFzSU5lM2VSU2ZhQXRQZGVvZm9qSmlKTk1Ld3k1?=
 =?utf-8?B?NlJvcElNT2RWQTRFRzYyQU9hcFo2N2xXYXY4SjdZOHNpZGRhYlY5UGk1SEpZ?=
 =?utf-8?B?ZncraG1XM3poSnE4ZlpOU2NVb0hBUTVqWmpGVEJ4aG5wN3JqK1pYcDZPdmIr?=
 =?utf-8?B?VDFqQXlpcXhDWUNGcFNMeUUzMFB0YU1wSU45RndzNzd5V1pvaWw0MDk2M3R2?=
 =?utf-8?B?alhna0ZPQzRHcWVnblZ6RC81dU5CcHplTGNIakFYcnRHTGl3QWVOOFJxUG1q?=
 =?utf-8?B?ejdpYXhPeUI5eUZaYUVCZnZCNGdRMTNWN1lqVGZVQ1pOYURXa2cvdmc0WjI1?=
 =?utf-8?B?RVRjdVhxUS8yRkc4VDVkVDU3em9PRFdCVk9VVU5LNjI5YVN3MzNMSVozNms0?=
 =?utf-8?B?bVdiYlJQcGpKRmltL1hjeXV0MWxQcmNUTmRGbEViTG85QnJIZC8wNE9aNWE4?=
 =?utf-8?Q?aAqmzxYG33Ba+YQQaQhz4CTCi3zTm5u4NpgIilAT2FUU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E84B7098065FCB4A8584B00277A14F18@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8036fc91-755a-4246-bae8-08d9fdb8c9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:27:14.7892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypBDkomKASYQacokJQmmWgcNUthn5bVBmhgW1VebvYp0zrT4RKCTQ0W3HlQXnhkL6QHa9drYzl3ypjI6IA/H5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMjgsIDIwMjIgYXQgMTA6MDI6NDNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlIGRpcnR5IHN3YXBjYWNoZSBwYWdlIGlzIHN0aWxsIHJlc2lkaW5nIGluIHRoZSBz
d2FwIGNhY2hlIGFmdGVyIGl0J3MNCj4gaHdwb2lzb25lZC4gU28gdGhlcmUgaXMgYWx3YXlzIG9u
ZSBleHRyYSByZWZjb3VudCBmb3Igc3dhcCBjYWNoZS4NCg0KVGhlIGRpZmYgc2VlbXMgZmluZSBh
dCBhIGdsYW5jZSwgYnV0IGxldCBtZSBoYXZlIGEgZmV3IHF1ZXN0aW9uIHRvDQp1bmRlcnN0YW5k
IHRoZSBpc3N1ZSBtb3JlLg0KDQotIElzIHRoZSBiZWhhdmlvciBkZXNjcmliZWQgYWJvdmUgdGhl
IGVmZmVjdCBvZiByZWNlbnQgY2hhbmdlIG9uIHNobWVtIHdoZXJlDQogIGRpcnR5IHBhZ2VjYWNo
ZSBpcyBwaW5uZWQgb24gaHdwb2lzb24gKGNvbW1pdCBhNzYwNTQyNjY2NjEgKCJtbTogc2htZW06
DQogIGRvbid0IHRydW5jYXRlIHBhZ2UgaWYgbWVtb3J5IGZhaWx1cmUgaGFwcGVucyIpLiBPciB0
aGUgb2xkZXIga2VybmVscw0KICBiZWhhdmUgYXMgdGhlIHNhbWU/DQoNCi0gSXMgdGhlIGJlaGF2
aW9yIHRydWUgZm9yIG5vcm1hbCBhbm9ueW1vdXMgcGFnZXMgKG5vdCBzaG1lbSBwYWdlcyk/DQoN
CkknbSB0cnlpbmcgdG8gdGVzdCBod3BvaXNvbiBoaXR0aW5nIHRoZSBkaXJ0eSBzd2FwY2FjaGUs
IGJ1dCBpdCBzZWVtcyB0aGF0DQppbiBteSB0ZXN0aW5nIG1lbW9yeV9mYWxpdXJlKCkgZmFpbHMg
d2l0aCAiaHdwb2lzb246IHVuaGFuZGxhYmxlIHBhZ2UiDQp3YXJuaW5nIGF0IGdldF9hbnlfcGFn
ZSgpLiAgU28gSSdtIHN0aWxsIG5vdCBzdXJlIHRoYXQgbWVfcGFnZWNhY2hlX2RpcnR5KCkNCmZp
eGVzIGFueSB2aXNpYmxlIHByb2JsZW0uDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4g
LS0tDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgNiArLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9t
ZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBpbmRleCAwZDdjNTgzNDBh
OTguLjVmOTUwMzU3MzI2MyAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiAr
KysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC05ODQsNyArOTg0LDYgQEAgc3RhdGljIGlu
dCBtZV9wYWdlY2FjaGVfZGlydHkoc3RydWN0IHBhZ2Vfc3RhdGUgKnBzLCBzdHJ1Y3QgcGFnZSAq
cCkNCj4gIHN0YXRpYyBpbnQgbWVfc3dhcGNhY2hlX2RpcnR5KHN0cnVjdCBwYWdlX3N0YXRlICpw
cywgc3RydWN0IHBhZ2UgKnApDQo+ICB7DQo+ICAJaW50IHJldDsNCj4gLQlib29sIGV4dHJhX3Bp
bnMgPSBmYWxzZTsNCj4gIA0KPiAgCUNsZWFyUGFnZURpcnR5KHApOw0KPiAgCS8qIFRyaWdnZXIg
RUlPIGluIHNobWVtOiAqLw0KPiBAQCAtOTkzLDEwICs5OTIsNyBAQCBzdGF0aWMgaW50IG1lX3N3
YXBjYWNoZV9kaXJ0eShzdHJ1Y3QgcGFnZV9zdGF0ZSAqcHMsIHN0cnVjdCBwYWdlICpwKQ0KPiAg
CXJldCA9IGRlbGV0ZV9mcm9tX2xydV9jYWNoZShwKSA/IE1GX0ZBSUxFRCA6IE1GX0RFTEFZRUQ7
DQo+ICAJdW5sb2NrX3BhZ2UocCk7DQo+ICANCj4gLQlpZiAocmV0ID09IE1GX0RFTEFZRUQpDQo+
IC0JCWV4dHJhX3BpbnMgPSB0cnVlOw0KPiAtDQo+IC0JaWYgKGhhc19leHRyYV9yZWZjb3VudChw
cywgcCwgZXh0cmFfcGlucykpDQo+ICsJaWYgKGhhc19leHRyYV9yZWZjb3VudChwcywgcCwgdHJ1
ZSkpDQo+ICAJCXJldCA9IE1GX0ZBSUxFRDsNCj4gIA0KPiAgCXJldHVybiByZXQ7DQo+IC0tIA0K
PiAyLjIzLjA=
