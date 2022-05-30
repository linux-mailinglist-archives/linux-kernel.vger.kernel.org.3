Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2DD537435
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 07:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiE3FCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiE3FCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:02:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2044.outbound.protection.outlook.com [40.107.113.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BCE5253D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjHwM7EU2WWkXMKEwBoM58AVSIhwdjMilqe1uZZ5usJoO0iRT7Yv7YAYH0Rmb6Xve/qfq00hJA1abpIezs5+KTd/GtyaI7WIQfQ2vIyGm/Ja0Bixjdaktkayqi6CDMZHnPF3HdOZ2e7nQjzo8KEy32lFngiw0p2aSBmVccuZjJCn/vmMVBlRid5agZCG+iBo4d2LEgcvwOFyC/NlXatQHe3Ila1dNIs0VSqRvFSM7esRmYJwEhfWn6DMQ95oUcm3yc+9FBGo62U7XIDvTmSlcZiJp9T/kouDz7DXS2/inpBCOz1ohIYZyMzTTdps67jiHWxznUMeikrHMTSSsc/hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVfjx70DI6t9zCVp+AkPlGb1ofwToCtbtv1BHHHV+/Q=;
 b=dw3xHkP5jjaPGtnXIIwWYMDjLqxqP20L8z5nLrH+iK/90CVnrrgz15CTbnUfRvt2KcPVRTIejf7wywboMcPAbG+kVhObElkRR1fVTwoO7TZoJ60AZKpNwILao77zw9aa6K+B61LVWil0HmEVuBlyZIFNg/e9wMTG9WYEsjuiMK28QCqF3nIvMtW1hYBXHSX/GG9GbX1cKuBrIHS+gtxpzIfzQVt5S28D30KAZ3o4CnRZHcSkLHIHqq/xtOSiKxkBnk1WcegxnaWBxPuD91wW7E00DwW/2LSnBPwSWjHvJMAw9OlvMGOlBiyefLQVOAe54aLz3bvv9CHuBWsoW1AHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVfjx70DI6t9zCVp+AkPlGb1ofwToCtbtv1BHHHV+/Q=;
 b=QKxSHOvXebsEOqGir3AG2QSJG5uSroLm/7R8OdPh+Z3big38wSHxhn7EvGtI+c7GLCY3f/g1ar6BIE01El4QNRLhjuCt8X4GdGn7LYq2AH7KqK8yzVaMEQ6wcnc4y20honLTLN02mRtsfYp3AZnQcCypXODE1AQiBawT3fN1XCg=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB2792.jpnprd01.prod.outlook.com (2603:1096:604:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 05:02:34 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 05:02:34 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/3] mm/memory-failure.c: support reset PTE during
 unpoison
Thread-Topic: [PATCH 2/3] mm/memory-failure.c: support reset PTE during
 unpoison
Thread-Index: AQHYbBjOFGEjkVGR6kqO3uw8Y4wxja027MAA
Date:   Mon, 30 May 2022 05:02:34 +0000
Message-ID: <20220530050234.GA1036127@hori.linux.bs1.fc.nec.co.jp>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-3-pizhenwei@bytedance.com>
In-Reply-To: <20220520070648.1794132-3-pizhenwei@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 084b17fc-f82b-44ce-9507-08da41f99c0e
x-ms-traffictypediagnostic: OSBPR01MB2792:EE_
x-microsoft-antispam-prvs: <OSBPR01MB27928A876808B814CE5019E8E7DD9@OSBPR01MB2792.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/iuwh8JMZjmbyo4isQTtNEDdqKSRBfU9fGdSHbJtLGg8tvLDW5S8PAm9rKo/hOu22iFPdtJPywzWUnr03wIpAwlU+/AVacJuIU7MuNiNThbJtr6tR94CFz2xUZ28KWkloV3hr8KmpgXCDDgjsb9igmzKUPg2Hu6LPeZE+8YVHLqSz1Pg6+bXlxb1lDr8B0OwVGM7Y1klo+yrgVt9mLjq+GHvh132hyKrwboEe0E5GXphlvwk/tsQ2U94cSqHjyI7mpBwQ3L2LY6LSVs9NWGayUusdEcrMVpqJroLT8zsHR1Yc8c4Bd3OV5QSAa+26Qix0mHnn69q9XGGgGW/UGdGYuPbYe/JdxbRH+gRQ5BNcAbF4/DscZp8kYNtkOLr0qMBVUD77Zj9nf/5jnMeuj2g+shj4f5VfoIGOzHPxTIpQtanWgKoPYmutOTQ1nGyxkV3xNVgI+kccX8JjV6MFRx5a6LFFBnU1ceM9JbvWXkI4ILUMNCAsrMnKSvWNU69lp6l4I45txULl2vAv8eY4YYQ9THhzHP97Cwy/nCiedgRayc24f0YYfAOQuBrEin40pEEnJBc/4naB5hgnBHSa2fMZ8tYrkGIJjcVDJVoPruH1XDGaAqAchEQVxAXB8OE86k6N7iQW4AhOmpgoOP2KzlxASvmwRKrxjbRPy19u5vZkZX9iftMPY03V6yTc17gkzWdg+g0/B562o0GTjL4GMuPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(83380400001)(6916009)(54906003)(6506007)(55236004)(8936002)(33656002)(5660300002)(38100700002)(66946007)(86362001)(26005)(66556008)(66476007)(186003)(64756008)(6486002)(7416002)(76116006)(8676002)(6512007)(66446008)(9686003)(85182001)(38070700005)(1076003)(4326008)(71200400001)(2906002)(122000001)(82960400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHVGWDAzVkJVWDFNeDl3cFVWbkY2QVVEcFYzSXJjcnQ4MVM1Wlc5azlmVW0x?=
 =?utf-8?B?NStlcTk2MnVOWGFxNTJMZmIvVlg2bENwUEhTdkdXWWozTDZ6RnA5akJRVlE3?=
 =?utf-8?B?Mk0vQzBYMnM4Y090VzJNeHlZTWVQNmIwT1N4RkdnZzVGam1EeGhTeDlaVFpJ?=
 =?utf-8?B?THFmRzMyaWdLYjlCZDBaVWpsOEJWYkRIVUFYbzdkeFZ4dWZlSWszN0t1SitH?=
 =?utf-8?B?eDhUUWtwaDBneWZ3a2ZxZitpRXBsQmhiRDcxdXA5YTNub0lhbDN3RnR1RW82?=
 =?utf-8?B?R05RR3VBM2FCQlNLOG5sR1FNY3lrVTRhVEZRWWlPc1QrcnFjQWhlekxVTFdl?=
 =?utf-8?B?Z054S1R5SHd1QjBGeHZCNXphdi9QRkZua2ZiWks1ZzQxMlFRbVpSajBqdWZm?=
 =?utf-8?B?MWQ1QjYrUkU3Z1JnSDd2SmhZbTdxT0pmOXIvR1FUL3hXZUd5M3JONVBFYUsr?=
 =?utf-8?B?OWtuZ3p3M0dGY2xHa0dvcDJIOUdzR2h2TzNWMHM1OWRYSVNLL0RpZEhtSC83?=
 =?utf-8?B?RVoyS1l6RmI4Sm1uc0puZFpjQ2Nta1RWMkpPWmk4dENxRktWcDJ1aEtaUS8v?=
 =?utf-8?B?KzdzNlNXbmhXYmRkRXBLditFY2dmb2pwYU9YUzMxc01wVlQvRXZydGxHOGJW?=
 =?utf-8?B?Y1ZiRGkzNnQvWVA0UTE0ZFZMTEtZcGhaakk4aXFOQ3hDMHNaRDFaU2pxK0lC?=
 =?utf-8?B?TWVhZkNYeWxvYlVYNU5rWHJEU1hXbVIvRmhpcEZlc3llMGJqcmdpMDE3cmpW?=
 =?utf-8?B?OUMraENoajFkL3RqaHZ2UGs5ZFRDYzdwYjhvR2IxVWx5OXVIKzJoWDVTU2Jw?=
 =?utf-8?B?UW1YQ1p3bjJycTZWTnRYNnNLMzhtdkJBTW1Gdmo3R0U5ZE9Pb3FiTGFBZ1NY?=
 =?utf-8?B?VmgyV2VVVzhZU3JQblRXMWZyU2U3emkxdnh5UVdBeFNGZHdFNk5ib25ZbStY?=
 =?utf-8?B?TDlVZlhoK0NaWU5oUFZPL3EyKzhwMTRKaHdhR2d4aFkzRWxVWUZZcWd1bGMz?=
 =?utf-8?B?ZEJyTk1Rc2VBS3dVMitITHhRWHRPdk15eU8vWmF3N2liSm85RkRYdmZxZ1dy?=
 =?utf-8?B?UXcxeGlJZWZ5UGJZTTZGMXU4RW9CRU10NWsrQXJLTzNnRWVWMHQ3UGhCVDVB?=
 =?utf-8?B?SFpPM1dkWU5nR1JaMEN0Ni9UNGJ5RkZBOG5GK2tQWkNKUk1YdENMVkpsWTdr?=
 =?utf-8?B?N0E4RmxwSDVSWnh4bFNRWXFDYWw2a3NnTmhBK0ZabzErMEhwUUdmY3RPMHli?=
 =?utf-8?B?d0ZsbDFIOWJyYWlTd3NoRll5K0c0YzBFb05zN0QxSGFiVzVYL1N5UTlPU1lC?=
 =?utf-8?B?eFZ5TzAyUEtQdUtTaUwwTHhaQ3R0SVhTQ2txa0poRm55NVh3bGxqbklraUp1?=
 =?utf-8?B?dVF4OHlhemhuLzFmMmxjWk5PYkQvdFRseDJ2ZnBkSVJCU2g0bkRqdWFXQXkr?=
 =?utf-8?B?c2VjWFFKM2hJTUZ1Zmhvc042dFNRdURiR2Z6Wjlnb0dBUUNVN2l6T3NuSXdS?=
 =?utf-8?B?TFpZNUJEZmNYaVViUldmL3ZESnNqSC9JK3hOQjNRS0tJRmh3VUFqdXZ2bm9I?=
 =?utf-8?B?S21hbXk5NWFqTFEzVmRQYjNFcjNoZitpNlZaRENLRS9adis1YXB1UVVKOUlW?=
 =?utf-8?B?S3pJd3BWejRVbHBSd05POFVCMCt4eU5SRUQwUzRERGVuZTZsU2o5S21VTnRw?=
 =?utf-8?B?a01ydlNveGloalVmcVcxK21xdzRPZklML0x1bWQzc1h2R2tLeUExUk1KT0ZG?=
 =?utf-8?B?WmVTTG0yMTFvbzQ3bXpMcUliMmVEVHUzeUFmckRTa2p2TWZ3aUYyc0x0d2tn?=
 =?utf-8?B?OFhwWmtHbVFPSFp2cjdmbGNhNCtoLzFLc0U5Ni9rdWpiYXM3SkhiSnVTckV0?=
 =?utf-8?B?RlYwM0ttekxWOHJGU2hZdjh2cnlkNm1OQVF1UG9IWUVYQTk3RFBBL1BDUDFq?=
 =?utf-8?B?aERicmtabSs0YjVxMjNlYmY5eWtBeUNwYnFsM0FuY2FyRUJTdGRlZndGWHRo?=
 =?utf-8?B?enRxZ2pCc1d4RlJ0N295OHVBTEJmUXRZTkljbjZqekYxL3JOZHFkcFdXMHE4?=
 =?utf-8?B?ckJuTmdZc3IyUk42MUJSNnpVb29wQno2VWN5SktSOVdxeERkY3dnMnQyOG5B?=
 =?utf-8?B?NHhaTC81SDJQaFpJZVRWazV3bFJrNDlSZC92M0o0cldVYVlta0VnYUZ0WCtu?=
 =?utf-8?B?cm1jMWI5UXMwWUFNbmlsdlpNTnMxZjl5SDdwSFIyVWlnU2R3dnlQRGNKUTdH?=
 =?utf-8?B?amF0aHpkekEwTlBjMWNoOWxGNjNUZ1dhSjRqRnpTVGVSQ3BDamk1eGV1bVN1?=
 =?utf-8?B?WHpkbXowUXlNSkZ3RXZGUnNCNHh0QkNZb3A3U2JvckJxZU1BUWRHOWsza01V?=
 =?utf-8?Q?WMpUve6xL4tCGO0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAE1B251FF19814EA5C08270417E7298@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084b17fc-f82b-44ce-9507-08da41f99c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 05:02:34.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/PDABFTqvDYSCXpM02ZCWOn/DWQMUcOCucAimEN7viyXeXGcBwNq84lTYk4zxdHnBg+yuRbkyscIqgIR2UPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMjAsIDIwMjIgYXQgMDM6MDY6NDdQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gT3JpZ2lhbmxseSwgdW5wb2lzb25fbWVtb3J5KCkgaXMgb25seSB1c2VkIGJ5IGh3cG9p
c29uLWluamVjdCwgYW5kDQo+IHVucG9pc29ucyBhIHBhZ2Ugd2hpY2ggaXMgcG9pc29uZWQgYnkg
aHdwb2lzb24taW5qZWN0IHRvby4gVGhlIGtlcm5lbCBQVEUNCj4gZW50cnkgaGFzIG5vIGNoYW5n
ZSBkdXJpbmcgc29mdHdhcmUgcG9pc29uL3VucG9pc29uLg0KPiANCj4gT24gYSB2aXJ0dWFsaXph
dGlvbiBwbGF0Zm9ybSwgaXQncyBwb3NzaWJsZSB0byBmaXggaGFyZHdhcmUgY29ycnVwdGVkIHBh
Z2UNCj4gYnkgaHlwZXJ2aXNvciwgdHlwaWNhbGx5IHRoZSBoeXBlcnZpc29yIHJlbWFwcyB0aGUg
ZXJyb3IgSFZBKGhvc3QgdmlydHVhbA0KPiBhZGRyZXNzKS4gU28gYWRkIGEgbmV3IHBhcmFtZXRl
ciAnY29uc3QgY2hhciAqcmVhc29uJyB0byBzaG93IHRoZSByZWFzb24NCj4gY2FsbGVkIGJ5Lg0K
PiANCj4gT25jZSB0aGUgY29ycnVwdGVkIHBhZ2UgZ2V0cyBmaXhlZCwgdGhlIGd1ZXN0IGtlcm5l
bCBuZWVkcyBwdXQgcGFnZSB0bw0KPiBidWRkeS4gUmV1c2UgdGhlIHBhZ2UgYW5kIGhpdCB0aGUg
Zm9sbG93aW5nIGlzc3VlKEludGVsIFBsYXRpbnVtIDgyNjApOg0KPiAgQlVHOiB1bmFibGUgdG8g
aGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJlc3M6IGZmZmY4ODgwNjE2NDYwMDANCj4gICNQRjog
c3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4gICNQRjogZXJyb3JfY29k
ZSgweDAwMDIpIC0gbm90LXByZXNlbnQgcGFnZQ0KPiAgUEdEIDJjMDEwNjcgUDREIDJjMDEwNjcg
UFVEIDYxYWFhMDYzIFBNRCAxMDA4OWIwNjMgUFRFIDgwMGZmZmZmOWU5YjkwNjINCj4gIE9vcHM6
IDAwMDIgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KPiAgQ1BVOiAyIFBJRDogMzExMDYgQ29tbTog
c3RyZXNzIEtkdW1wOiBsb2FkZWQgVGFpbnRlZDogRyAgIE0gICAgICAgT0UgICAgIDUuMTguMC1y
YzYuYm0uMS1hbWQ2NCAjNg0KPiAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0
MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEuMTYuMC0wLWdkMjM5NTUyY2U3MjItcHJlYnVp
bHQucWVtdS5vcmcgMDQvMDEvMjAxNA0KPiAgUklQOiAwMDEwOmNsZWFyX3BhZ2VfZXJtcysweDcv
MHgxMA0KPiANCj4gVGhlIGtlcm5lbCBQVEUgZW50cnkgb2YgdGhlIGZpeGVkIHBhZ2UgaXMgc3Rp
bGwgdW5jb3JyZWN0ZWQsIGtlcm5lbCBoaXRzDQo+IHBhZ2UgZmF1bHQgZHVyaW5nIHByZXBfbmV3
X3BhZ2UuIFNvIGFkZCAnYm9vbCByZXNldF9rcHRlJyB0byBnZXQgYSBjaGFuZ2UNCj4gdG8gZml4
IHRoZSBQVEUgZW50cnkgaWYgdGhlIHBhZ2UgaXMgZml4ZWQgYnkgaHlwZXJ2aXNvci4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPg0KPiAt
LS0NCj4gIGluY2x1ZGUvbGludXgvbW0uaCAgIHwgIDIgKy0NCj4gIG1tL2h3cG9pc29uLWluamVj
dC5jIHwgIDIgKy0NCj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgIHwgMjYgKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRl
L2xpbnV4L21tLmgNCj4gaW5kZXggNjY1ODczYzI3ODhjLi43YmEyMTBlODY0MDEgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvbW0uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4g
QEAgLTMxOTEsNyArMzE5MSw3IEBAIGVudW0gbWZfZmxhZ3Mgew0KPiAgZXh0ZXJuIGludCBtZW1v
cnlfZmFpbHVyZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsNCj4gIGV4dGVybiB2b2lk
IG1lbW9yeV9mYWlsdXJlX3F1ZXVlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpOw0KPiAg
ZXh0ZXJuIHZvaWQgbWVtb3J5X2ZhaWx1cmVfcXVldWVfa2ljayhpbnQgY3B1KTsNCj4gLWV4dGVy
biBpbnQgdW5wb2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuKTsNCj4gK2V4dGVybiBpbnQg
dW5wb2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuLCBib29sIHJlc2V0X2twdGUsIGNvbnN0
IGNoYXIgKnJlYXNvbik7DQo+ICBleHRlcm4gaW50IHN5c2N0bF9tZW1vcnlfZmFpbHVyZV9lYXJs
eV9raWxsOw0KPiAgZXh0ZXJuIGludCBzeXNjdGxfbWVtb3J5X2ZhaWx1cmVfcmVjb3Zlcnk7DQo+
ICBleHRlcm4gdm9pZCBzaGFrZV9wYWdlKHN0cnVjdCBwYWdlICpwKTsNCj4gZGlmZiAtLWdpdCBh
L21tL2h3cG9pc29uLWluamVjdC5jIGIvbW0vaHdwb2lzb24taW5qZWN0LmMNCj4gaW5kZXggNWMw
Y2RkZDgxNTA1Li4wZGQxN2JhOThhZGUgMTAwNjQ0DQo+IC0tLSBhL21tL2h3cG9pc29uLWluamVj
dC5jDQo+ICsrKyBiL21tL2h3cG9pc29uLWluamVjdC5jDQo+IEBAIC01Nyw3ICs1Nyw3IEBAIHN0
YXRpYyBpbnQgaHdwb2lzb25fdW5wb2lzb24odm9pZCAqZGF0YSwgdTY0IHZhbCkNCj4gIAlpZiAo
IWNhcGFibGUoQ0FQX1NZU19BRE1JTikpDQo+ICAJCXJldHVybiAtRVBFUk07DQo+ICANCj4gLQly
ZXR1cm4gdW5wb2lzb25fbWVtb3J5KHZhbCk7DQo+ICsJcmV0dXJuIHVucG9pc29uX21lbW9yeSh2
YWwsIGZhbHNlLCAiaHdwb2lzb24taW5qZWN0Iik7DQo+ICB9DQo+ICANCj4gIERFRklORV9ERUJV
R0ZTX0FUVFJJQlVURShod3BvaXNvbl9mb3BzLCBOVUxMLCBod3BvaXNvbl9pbmplY3QsICIlbGxp
XG4iKTsNCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFp
bHVyZS5jDQo+IGluZGV4IDk1YzIxOGJiMGEzNy4uYTQ2ZGUzYmUxZGQ3IDEwMDY0NA0KPiAtLS0g
YS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAg
LTIxMzIsMjEgKzIxMzIsMjYgQEAgY29yZV9pbml0Y2FsbChtZW1vcnlfZmFpbHVyZV9pbml0KTsN
Cj4gIC8qKg0KPiAgICogdW5wb2lzb25fbWVtb3J5IC0gVW5wb2lzb24gYSBwcmV2aW91c2x5IHBv
aXNvbmVkIHBhZ2UNCj4gICAqIEBwZm46IFBhZ2UgbnVtYmVyIG9mIHRoZSB0byBiZSB1bnBvaXNv
bmVkIHBhZ2UNCj4gKyAqIEByZXNldF9rcHRlOiBSZXNldCB0aGUgUFRFIGVudHJ5IGZvciBrbWFw
DQo+ICsgKiBAcmVhc29uOiBUaGUgY2FsbGVycyB0ZWxscyB3aHkgdW5wb2lzb25pbmcgdGhlIHBh
Z2UNCj4gICAqDQo+IC0gKiBTb2Z0d2FyZS11bnBvaXNvbiBhIHBhZ2UgdGhhdCBoYXMgYmVlbiBw
b2lzb25lZCBieQ0KPiAtICogbWVtb3J5X2ZhaWx1cmUoKSBlYXJsaWVyLg0KPiArICogVW5wb2lz
b24gYSBwYWdlIHRoYXQgaGFzIGJlZW4gcG9pc29uZWQgYnkgbWVtb3J5X2ZhaWx1cmUoKSBlYXJs
aWVyLg0KPiAgICoNCj4gLSAqIFRoaXMgaXMgb25seSBkb25lIG9uIHRoZSBzb2Z0d2FyZS1sZXZl
bCwgc28gaXQgb25seSB3b3Jrcw0KPiAtICogZm9yIGxpbnV4IGluamVjdGVkIGZhaWx1cmVzLCBu
b3QgcmVhbCBoYXJkd2FyZSBmYWlsdXJlcw0KPiArICogRm9yIGxpbnV4IGluamVjdGVkIGZhaWx1
cmVzLCB0aGVyZSBpcyBubyBuZWVkIHRvIHJlc2V0IFBURSBlbnRyeS4NCj4gKyAqIEl0J3MgcG9z
c2libGUgdG8gZml4IGhhcmR3YXJlIG1lbW9yeSBmYWlsdXJlIG9uIGEgdmlydHVhbGl6YXRpb24g
cGxhdGZvcm0sDQo+ICsgKiBvbmNlIGh5cGVydmlzb3IgZml4ZXMgdGhlIGZhaWx1cmUsIGd1ZXN0
IG5lZWRzIHB1dCBwYWdlIGJhY2sgdG8gYnVkZHkgYW5kDQo+ICsgKiByZXNldCB0aGUgUFRFIGVu
dHJ5IGluIGtlcm5lbC4NCj4gICAqDQo+ICAgKiBSZXR1cm5zIDAgZm9yIHN1Y2Nlc3MsIG90aGVy
d2lzZSAtZXJybm8uDQo+ICAgKi8NCj4gLWludCB1bnBvaXNvbl9tZW1vcnkodW5zaWduZWQgbG9u
ZyBwZm4pDQo+ICtpbnQgdW5wb2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuLCBib29sIHJl
c2V0X2twdGUsIGNvbnN0IGNoYXIgKnJlYXNvbikNCj4gIHsNCj4gIAlzdHJ1Y3QgcGFnZSAqcGFn
ZTsNCj4gIAlzdHJ1Y3QgcGFnZSAqcDsNCj4gIAlpbnQgcmV0ID0gLUVCVVNZOw0KPiAgCWludCBm
cmVlaXQgPSAwOw0KPiArCXB0ZV90ICprcHRlOw0KPiArCXVuc2lnbmVkIGxvbmcgYWRkcjsNCg0K
VGhlc2UgdmFyaWFibGVzIGFyZSB1c2VkIG9ubHkgaW4gImlmIChyZXNldF9rcHRlKSIgYmxvY2ss
IHNvIHlvdSBjYW4NCm1vdmUgdGhlIGRlZmluaXRpb25zIGluIGl0Lg0KDQo+ICAJc3RhdGljIERF
RklORV9SQVRFTElNSVRfU1RBVEUodW5wb2lzb25fcnMsIERFRkFVTFRfUkFURUxJTUlUX0lOVEVS
VkFMLA0KPiAgCQkJCQlERUZBVUxUX1JBVEVMSU1JVF9CVVJTVCk7DQo+ICANCj4gQEAgLTIyMDgs
OCArMjIxMywxNSBAQCBpbnQgdW5wb2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuKQ0KPiAg
CW11dGV4X3VubG9jaygmbWZfbXV0ZXgpOw0KPiAgCWlmICghcmV0IHx8IGZyZWVpdCkgew0KPiAg
CQludW1fcG9pc29uZWRfcGFnZXNfZGVjKCk7DQo+IC0JCXVucG9pc29uX3ByX2luZm8oIlVucG9p
c29uOiBTb2Z0d2FyZS11bnBvaXNvbmVkIHBhZ2UgJSNseFxuIiwNCj4gLQkJCQkgcGFnZV90b19w
Zm4ocCksICZ1bnBvaXNvbl9ycyk7DQo+ICsJCXByX2luZm8oIlVucG9pc29uOiBVbnBvaXNvbmVk
IHBhZ2UgJSNseCBieSAlc1xuIiwNCj4gKwkJCQkgcGFnZV90b19wZm4ocCksIHJlYXNvbik7DQoN
CkRvIHlvdSBuZWVkIHVuZG9pbmcgcmF0ZSBsaW1pdGluZyBoZXJlPyAgSW4gdGhlIG9yaWdpbmFs
IHVucG9pc29uJ3MgdXNhZ2UsDQphdm9pZGluZyBmbG9vZCBvZiAiVW5wb2lzb246IFNvZnR3YXJl
LXVucG9pc29uZWQgcGFnZSIgbWVzc2FnZXMgaXMgaGVscGZ1bC4NCg0KQW5kIHVucG9pc29uIHNl
ZW1zIHRvIGJlIGNhbGxlZCBmcm9tIHZpcnRpby1iYWxsb29uIG11bHRpcGxlIHRpbWVzIHdoZW4N
CnRoZSBiYWNrZW5kIGlzIDJNQiBodWdlcGFnZXMuICBJZiBpdCdzIHJpZ2h0LCBwcmludGluZyBv
dXQgNTEyIGxpbmVzIG9mDQoiVW5wb2lzb246IFVucG9pc29uZWQgcGFnZSAweFhYWCBieSB2aXJ0
aW8tYmFsbG9vbiIgbWVzc2FnZXMgbWlnaHQgbm90IGJlDQpzbyBoZWxwZnVsPw0KDQpUaGFua3Ms
DQpOYW95YSBIb3JpZ3VjaGkNCg0KPiArCQlpZiAocmVzZXRfa3B0ZSkgew0KPiArCQkJcHJlZW1w
dF9kaXNhYmxlKCk7DQo+ICsJCQlhZGRyID0gKHVuc2lnbmVkIGxvbmcpcGFnZV90b192aXJ0KHAp
Ow0KPiArCQkJa3B0ZSA9IHZpcnRfdG9fa3B0ZShhZGRyKTsNCj4gKwkJCXNldF9wdGVfYXQoJmlu
aXRfbW0sIGFkZHIsIGtwdGUsIHBmbl9wdGUocGZuLCBQQUdFX0tFUk5FTCkpOw0KPiArCQkJcHJl
ZW1wdF9lbmFibGUoKTsNCj4gKwkJfQ0KPiAgCX0NCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAt
LSANCj4gMi4yMC4x
