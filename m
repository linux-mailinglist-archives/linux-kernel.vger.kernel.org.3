Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFC51A462
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352627AbiEDPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiEDPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:49:18 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694281F60C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnuXPF1W8NKGXOO6p7GeMWOjlFHpGY7lDYySwr2fjI3YiXCEG8NtMpUJxLCqesmyB2sGxKJwAsCprxltZ0AZMfFNzAr++Q9mnlSwX7F/EUNF5u+VF+ZrW6Z3zzwbmKsw9YiWCTqmF7u9tIjvJNAYAmr1JoRhuViqnQKEr9cscOzo9jyMHPoAAu2bZniX3sv55aOrcUs/KD4M8UarC4TlBZQ9Z0ZIsZT/Q+g3SPL03xTSg/IiugIhViy/BFJfxTV2J/R3TT+cBY0fp6wBgEkx+YkkhIjJoMYtzzp+4kz0uGLRyGufPKG4FChdBZ91utK96VUFD4QhvPuh2G3XCDLnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLkPDUClaKpJzSc60ZL8ITK97TaWSvfaVBs/IZgKGSY=;
 b=Od5ZA3/axCCtxb2A0roB68YlCjZ0p8+Q7PPkJb0dfIX2ZhDwwD29IKSWvt50RXiwiUt+5czZ+ZJ3K/WJKkniRyeqdU0NsGBUVgR4WBHdOB/vwdLtltRW09pJ5lpXkJO1q35amScEQaHDoatFLNUX0ABClrdrHDskCT/AFTtMgg3nqjHxmrqw+F2YZ4Qurb48glwjdAChw2WQ7b7AzfQZk+GGj2mCkp2XPVu+Sklc6+yDcs+g/02LqFfp3BEIDYxWcX3ojeCV4+8jOvtMkImSyrl92QqCG1OJxthny2uN6ThfDWWE1OJlfbJfA/u/Dqve6kKrrroPcxWT3f1HTV3mAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLkPDUClaKpJzSc60ZL8ITK97TaWSvfaVBs/IZgKGSY=;
 b=ir2uZxddqucsGLk2i6dsfVjEiE8JFudZ+f7mgQDuWEKtU5iWrtdhviI/LhjTXuVqBquBOJV1HU32fGPnrs6Jwg2dbVTcMs0jRYQtydFlVrqkPHs/456gEPlApVEMNOGfck/1PzG//S7sFIU848SmIfcb8UkVJQsBLQkMvpPeeis=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.7; Wed, 4 May
 2022 15:45:35 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%5]) with mapi id 15.20.5250.008; Wed, 4 May 2022
 15:45:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Alexander Graf <graf@amazon.com>, jason <jason@zx2c4.com>,
        Lennart Poettering <mzxreary@0pointer.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: RE: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Thread-Topic: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Thread-Index: AQHYXi3dQ9AcbI4b40+Xh1Ja5LmjAq0LuWoAgAAI8oCAAAr5gIAAFGeAgAAIdgCAAvPCAA==
Date:   Wed, 4 May 2022 15:45:35 +0000
Message-ID: <PH0PR21MB3025C4FF4AD6ABBB51E8A521D7C39@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com> <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com> <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
 <480469e6-0eb0-8d76-0b8d-111579e73701@amazon.com>
In-Reply-To: <480469e6-0eb0-8d76-0b8d-111579e73701@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=73df148f-36a5-40a2-9683-2f9bacf0019b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-04T15:39:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0c0092e-b51e-4be1-6859-08da2de5210b
x-ms-traffictypediagnostic: MW2PR2101MB1050:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10509DCFC004869C50A5F936D7C39@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wTW9Aizd53YfY23Bav473WM04FG+x9tQ0Td4UvXz/wpEPVYJl+gbXlVPHrJNnCMwfav7PwAs2+d7b3dTzLrj24ATqSzNGvF0e8di3IVmZr7089eTK3dbXEp5mkkiDi3Pq/hloanlWZez0JNhjsNiCdaA+DEaBzCRlQ/nm+idzbXXT1WBXY9Qr0+E5RZbRXIyXqVWoHwUf6JJ/FlD0j7p+x0VbajTPHPHoIQRxHT0gBKbC+6Cc75Jas39f2/jJ1JQYdF28jRkrdvlx8lrTu6I53GSLvtMG+bOIs+M/HTLa6mEcomGTEtWevcu0/GH9etIGrrejy1FhhrZrgScX0pgjeb/Un4xnThmdTduKME8S4jhJM0IoZfzcqaI6hn8NHFq0WegEk5lWBK94LVU55rPl3Owv7tLWY8NG0IWuzcRUe0u69danJHntWMkS22nBQiLmGC1FE68fyqgyv3Glk6HRS+uMlJv/ql+gXgEkilvWwgKv/YPFJWx509poNc9sDU4dyKqmygRzULFtwpvRoWFXiYyFu268gwbN+JyBJDWxttbBDpVzmzhpH2qaI5wOu1AXsplYYuaXhrCsMOyEaRyp/mbncFkwEHjf+7CmKEUHmmhHhd81XIU4ScV2ayoPwRDH4Q0kfnfcYIPhvcyP7S/uoU+g4J3QhoWRdl6Al6U9fXq1t9isvWzDvf5WIYI05BP/l7fzAAUs/hxl4C44abvXCbNYNXzcixFWWvDrWYtaMow4d+v94clUMCVBfwsStQf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(9686003)(7416002)(38070700005)(38100700002)(316002)(7696005)(53546011)(54906003)(86362001)(83380400001)(110136005)(8936002)(2906002)(52536014)(122000001)(508600001)(33656002)(26005)(5660300002)(82950400001)(10290500003)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(186003)(82960400001)(8990500004)(55016003)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czRWWndtVWdYenZZU2NINGRoQTA1QmlWRW1Pdi9GT1RRWVJSb01FT3BoeUly?=
 =?utf-8?B?bEpTTHBHY2gwYy9CM3JEYjQ0UUtHV3pRN1Zxd3NyaVA2OTN2NFRxeVM2Z3Jn?=
 =?utf-8?B?V0tqMFdMa2NHZS95VnJRVnRoK3hHOE9NWjNJbmZlMUlIK2tCN01xWkZtTkpM?=
 =?utf-8?B?aWx1aWhtVFFKait0eG1XT1RONTBVcThGcWVkc3UrczBPeitYOW1jREFoa3I4?=
 =?utf-8?B?NDdYMFYrQ0xvM1dyNzdWNC9qNEJtbnd5Q3Y5Sjlya2pZaWlhL3hJZVhqZXJ4?=
 =?utf-8?B?a1UrMnlvUUtoV3RIb1A1Zi9vTysrQkZUdmdPV2RXV3dxY1pBK0o3SjFZeFpk?=
 =?utf-8?B?VVo5TUlkNVhTczNDUEQ5ZWRCUDZLRnNFa2Q0dEcvekdpVWMzVjB0bHNha0lo?=
 =?utf-8?B?R09uNkFTZENBaTBKYm44QWdxam84cXhyQXJrM3lSZUZRVFZ3SWg5bVFsajBR?=
 =?utf-8?B?NTQrZ3J4UVFEQ3lsS1phWFU1bXdCQmZHQWRYaTdyYmxOWkErNFNEYUYvQ1pG?=
 =?utf-8?B?anVaQ1NkTXBxK1NNYkJhZUNMQ3oyb1ZSQ1V1alM5bXd1R3p5ejNBNFBXRkEy?=
 =?utf-8?B?U2tDNkpFNEVzUEpCMW9acHkxZU1pRDF5eWV4eWkybHJJWW8rRWttYVJIdjZt?=
 =?utf-8?B?bi95SDZpZ0xrYnEwSVdSRFdVQ2ZSUkk4TCswSkl4UUV3VHMrNENoTzg2S0ds?=
 =?utf-8?B?YXIxZFQ3MWYreTF2N3B5NnpVNWdVa3pRTHFWS0ZocG5SSFF0NzhPYmp0MHJs?=
 =?utf-8?B?YTBMSlBNT01MZUkrVjcrZ3JKZXlhK0x4WTNZWHlTNGFsOHNMQWZQUGljbnYz?=
 =?utf-8?B?b3dDMWgrNHBRRW5UaGZrU3ladS81aHVkeHFaWHc0czNwekFsbVNPcXk1cVJK?=
 =?utf-8?B?SHBtYkpBSEg4MTlsOGt4U3VzaCtuNUtlSUZDMklJM3hSajB4U3RuNFA5YUtV?=
 =?utf-8?B?REhsR0xJOTU0Q2Z3SXNkOFlFcW02RFROMHE3bEgrWUV4VC8raEVjV2V2WmFG?=
 =?utf-8?B?YVhBNUp3c1VMbDNxUVVpR3ZHb1NqclFRTEx1N1JYWmNQK1ZFY2ovZFRZZzdy?=
 =?utf-8?B?dmE3WnY2TmpESWYraEJIN0Q3N3J4UDY4V3lWbElMd1hyVkQ1R2psclE1T3B0?=
 =?utf-8?B?VFB5N2UwWnNWcU40WGh4RkZzZUV6U1VJL2ZUZmR2a21EbmV5ek9VV1d0MzZG?=
 =?utf-8?B?TEpIZ0FZMklVb1V3UXN6WUk2V3VxckdvN3hQUGwxNVF3VVFpa1ZqQmlDNERs?=
 =?utf-8?B?K3VUOGZpU1cxUytMek9SRjVERXArbWY5Z0pBWWNxN0hpalJBVnUwNjhyUCty?=
 =?utf-8?B?bEVVWkFKRHdxSzVQUElqdzdqaWc4TGdPVEFHL2pQeHdWVGdXUnNkUkJUd1hE?=
 =?utf-8?B?SGcrYnVkYnV6SEJPd09qMmhoVzI4UXlrcXpOc2t0QnA2aUR2eXEyY0M5a0Vl?=
 =?utf-8?B?YVU3MVk4TzhhOEhpVFppcU1Gay82NTI1aXFHajVJL0ZKUTI1bENJSGxEZWlB?=
 =?utf-8?B?c3NaeVB6SXBuM2FURUtrZFY1WVU5b2JKMzRWdWJlVlkvL0taZFJpVUp3QThv?=
 =?utf-8?B?ckRyaGFGZ0hsc3FjTTBvZlViWUJDclM0MUYwS1pCYitEYmVYdnI5elYwSXdY?=
 =?utf-8?B?MWNqd0Z6Nkpva1k0YzhHSUtjWG54akJBVnh2dXhsT3lGWTNWaXNnUEk4eURj?=
 =?utf-8?B?VzBYVlFnK0k5M0NBL292aHNMcloxYWI1K004bFRYZ1ZMY0pFNzRuUXl2YzVo?=
 =?utf-8?B?Qk5rSlc5MkQ3QSs1MitHSXlNeFM0bk1BblV4amMxVzNjOFR1SXljL1pYRlR6?=
 =?utf-8?B?SjU4Z1gzb2lVM2lSYjd5UndWbFJRby9UVitmUWY4clJRdm1LN1RkWkQxajdz?=
 =?utf-8?B?SXlhTWIxcmZhK1M1SHB2c01lUFVpQWs2aWlqU3d5UjJyMkZibDNKcG81dGk1?=
 =?utf-8?B?RXpsWkZCY2tiQ0RhN09FSmJiNEZialNPbzg0Vnc4RWNLcmhSVmppZDZ3ajRP?=
 =?utf-8?B?dW1ZTlN1U3JpRnNRbVFFWVdEVGw2MHBVbEpPREdBQzRvb2tUTlVFUThVT3hE?=
 =?utf-8?B?MVkvK1gzR0xlaXdGT0c4N2FyUGE5eFE3eHF6OTVCVWYyUFpnY21FemVNMTFi?=
 =?utf-8?B?cUdtVTl4RzJIMDlPdVdOZklYc0dJNTg3K0kzNVNYdk1PUXlEUjNMNEF6Z2FG?=
 =?utf-8?B?aWphc2c4TkFQaEgzQnNxN3lKSnVlYVEwSVFIT1ZQUms1NHpxWHV6YWFQeG1l?=
 =?utf-8?B?azRrNHd0clVrajhaUFkxU1JHOXhzcEJVWWVudWdKOHUwM2tIK3pzYnQ0eFMz?=
 =?utf-8?B?bnk1NEhOeW91T0ovNE1SSGMvY29jb2QzeWZGY0hlaGo5WnlucGJ5b2pSM05p?=
 =?utf-8?Q?BHJ4vpGo4Rq6K7Uk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c0092e-b51e-4be1-6859-08da2de5210b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 15:45:35.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xp4D3DNaPV0KiRRCF6zFgBBfEPjBXz1RUGv2B6X8elTjCvrbihaWdl/faWjYM80NSWD/K014UaPM35qtj+t+c/WLPcf7coglCQdM5sTJEYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4gU2VudDogTW9uZGF5LCBNYXkg
MiwgMjAyMiAxMTozNSBBTQ0KPiANCj4gT24gMDIuMDUuMjIgMjA6MDQsIEphc29uIEEuIERvbmVu
ZmVsZCB3cm90ZToNCj4gPiBIZXkgTGVubmFydCwNCj4gPg0KPiA+IE9uIE1vbiwgTWF5IDAyLCAy
MDIyIGF0IDA2OjUxOjE5UE0gKzAyMDAsIExlbm5hcnQgUG9ldHRlcmluZyB3cm90ZToNCj4gPj4g
T24gTW8sIDAyLjA1LjIyIDE4OjEyLCBKYXNvbiBBLiBEb25lbmZlbGQgKEphc29uQHp4MmM0LmNv
bSkgd3JvdGU6DQo+ID4+DQo+ID4+Pj4+IEluIG9yZGVyIHRvIGluZm9ybSB1c2Vyc3BhY2Ugb2Yg
dmlydHVhbCBtYWNoaW5lIGZvcmtzLCB0aGlzIGNvbW1pdCBhZGRzDQo+ID4+Pj4+IGEgImZvcmtf
ZXZlbnQiIHN5c2N0bCwgd2hpY2ggZG9lcyBub3QgcmV0dXJuIGFueSBkYXRhLCBidXQgYWxsb3dz
DQo+ID4+Pj4+IHVzZXJzcGFjZSBwcm9jZXNzZXMgdG8gcG9sbCgpIG9uIGl0IGZvciBub3RpZmlj
YXRpb24gb2YgVk0gZm9ya3MuDQo+ID4+Pj4+DQo+ID4+Pj4+IEl0IGF2b2lkcyBleHBvc2luZyB0
aGUgYWN0dWFsIHZtZ2VuaWQgZnJvbSB0aGUgaHlwZXJ2aXNvciB0byB1c2Vyc3BhY2UsDQo+ID4+
Pj4+IGluIGNhc2UgdGhlcmUgaXMgYW55IHJhbmRvbW5lc3MgdmFsdWUgaW4ga2VlcGluZyBpdCBz
ZWNyZXQuIFJhdGhlciwNCj4gPj4+Pj4gdXNlcnNwYWNlIGlzIGV4cGVjdGVkIHRvIHNpbXBseSB1
c2UgZ2V0cmFuZG9tKCkgaWYgaXQgd2FudHMgYSBmcmVzaA0KPiA+Pj4+PiB2YWx1ZS4NCj4gPj4+
PiBXb3VsZG4ndCBpdCBtYWtlIHNlbnNlIHRvIGV4cG9zZSBhIG1vbm90b25pYyA2NGJpdCBjb3Vu
dGVyIG9mIGRldGVjdGVkDQo+ID4+Pj4gVk0gZm9ya3Mgc2luY2UgYm9vdCB0aHJvdWdoIHJlYWQo
KT8gSXQgbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8ga25vdw0KPiA+Pj4+IGZvciB1c2Vyc3BhY2Ug
aG93IG1hbnkgZm9ya3MgaXQgbWlzc2VkIHRoZSBmb3JrIGV2ZW50cyBmb3IuIE1vcmVvdmVyIGl0
DQo+ID4+Pj4gbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8gdXNlcnNwYWNlIHRvIGtub3cgaWYgYW55
IGZvcmsgaGFwcGVuZWQgc28gZmFyDQo+ID4+Pj4gKmF0KiAqYWxsKiwgYnkgY2hlY2tpbmcgaWYg
dGhlIGNvdW50ZXIgaXMgbm9uLXplcm8uDQo+ID4+PiAiTWlnaHQgYmUgaW50ZXJlc3RpbmciIGlz
IGRpZmZlcmVudCBmcm9tICJkZWZpbml0ZWx5IHVzZWZ1bCIuIEknbSBub3QNCj4gPj4+IGdvaW5n
IHRvIGFkZCB0aGlzIHdpdGhvdXQgYSBjbGVhciB1c2UgY2FzZS4gVGhpcyBmZWF0dXJlIGlzIHBy
ZXR0eQ0KPiA+Pj4gbmFycm93bHkgc2NvcGVkIGluIGl0cyBvYmplY3RpdmVzIHJpZ2h0IG5vdywg
YW5kIEkgaW50ZW5kIHRvIGtlZXAgaXQNCj4gPj4+IHRoYXQgd2F5IGlmIHBvc3NpYmxlLg0KPiA+
PiBTdXJlLCB3aGF0ZXZlci4gSSBtZWFuLCBpZiB5b3UgdGhpbmsgaXQncyBwcmVmZXJhYmxlIHRv
IGhhdmUgMyBBUEkNCj4gPj4gYWJzdHJhY3Rpb25zIGZvciB0aGUgc2FtZSBjb25jZXB0IGVhY2gg
Zm9yIGl0J3Mgc3BlY2lhbCB1c2VjYXNlLCB0aGVuDQo+ID4+IHRoYXQncyBjZXJ0YWlubHkgb25l
IHdheSB0byBkbyB0aGluZ3MuIEkgcGVyc29uYWxseSB3b3VsZCB0cnkgdG8NCj4gPj4gZmlndXJl
IG91dCBhIG1vZGljdW0gb2YgZ2VuZXJhbGl6YXRpb24gZm9yIHRoaW5ncyBsaWtlIHRoaXMuIEJ1
dCBtYXliZQ0KPiA+PiB0aGF0JyBqdXN0IG1l4oCmDQo+ID4+DQo+ID4+IEkgY2FuIGp1c3QgdGVs
bCB5b3UsIHRoYXQgaW4gc3lzdGVtZCB3ZSdkIGhhdmUgYSB1c2VjYXNlIGZvciBjb25zdW1pbmcN
Cj4gPj4gc3VjaCBhIGdlbmVyYXRpb24gY291bnRlcjogd2UgdHJ5IHRvIHByb3ZpZGUgc3RhYmxl
IE1BQyBhZGRyZXNzZXMgZm9yDQo+ID4+IHN5bnRoZXRpYyBuZXR3b3JrIGludGVyZmFjZXMgbWFu
YWdlZCBieSBuZXR3b3JrZCwgc28gd2UgaGFzaCB0aGVtIGZyb20NCj4gPj4gL2V0Yy9tYWNoaW5l
LWlkLCBidXQgb3RvaCBwZW9wbGUgYWxzbyB3YW50IHRoZW0gdG8gY2hhbmdlIHdoZW4gdGhleQ0K
PiA+PiBjbG9uZSB0aGVpciBWTXMuIFdlIGNvdWxkIHZlcnkgbmljZWx5IHNvbHZlIHRoaXMgaWYg
d2UgaGFkIGENCj4gPj4gZ2VuZXJhdGlvbiBjb3VudGVyIGVhc2lseSBhY2Nlc3NpYmxlIGZyb20g
dXNlcnNwYWNlLCB0aGF0IHN0YXJ0cyBhdCAwDQo+ID4+IGluaXRpYWxseS4gQmVjYXVzZSB0aGVu
IHdlIGNhbiBoYXNoIGFzIHdlIGFsd2F5cyBkaWQgd2hlbiB0aGUgY291bnRlcg0KPiA+PiBpcyB6
ZXJvLCBidXQgb3RoZXJ3aXNlIHVzZSBzb21ldGhpbmcgZWxzZSwgcG9zc2libHkgaGFzaGVkIGZy
b20gdGhlDQo+ID4+IGdlbmVyYXRpb24gY291bnRlci4NCj4gPiBUaGlzIGRvZXNuJ3Qgd29yaywg
YmVjYXVzZSB5b3UgY291bGQgaGF2ZSBtZW1vcnktQSBzcGxpdCBpbnRvIG1lbW9yeS1BLjENCj4g
PiBhbmQgbWVtb3J5LUEuMiwgYW5kIGJvdGggQS4yIGFuZCBBLjEgd291bGQgKytjb3VudGVyLCBh
bmQgd2luZCB1cCB3aXRoDQo+ID4gdGhlIHNhbWUgbmV3IHZhbHVlICIyIi4gVGhlIHNvbHV0aW9u
IGlzIHRvIGluc3RlYWQgaGF2ZSB0aGUgaHlwZXJ2aXNvcg0KPiA+IHBhc3MgYSB1bmlxdWUgdmFs
dWUgYW5kIGEgY291bnRlci4gV2UgY3VycmVudGx5IGhhdmUgYSAxNiBieXRlIHVuaXF1ZQ0KPiA+
IHZhbHVlIGZyb20gdGhlIGh5cGVydmlzb3IsIHdoaWNoIEknbSBrZWVwaW5nIGFzIGEga2VybmVs
IHNwYWNlIHNlY3JldA0KPiA+IGZvciB0aGUgUk5HOyB3ZSdyZSB3YWl0aW5nIG9uIGEgd29yZC1z
aXplZCBtb25vdG9uaWMgY291bnRlciBpbnRlcmZhY2UNCj4gPiBmcm9tIGh5cGVydmlzb3JzIGlu
IHRoZSBmdXR1cmUuIFdoZW4gd2UgaGF2ZSB0aGUgbGF0dGVyLCB0aGVuIHdlIGNhbg0KPiA+IHN0
YXJ0IHRhbGtpbmcgYWJvdXQgbW1hcGFibGUgdGhpbmdzLiBZb3VyIHVzZSBjYXNlIHdvdWxkIHBy
b2JhYmx5IGJlDQo+ID4gc2VydmVkIGJ5IGV4cG9zaW5nIHRoYXQgMTYtYnl0ZSB1bmlxdWUgdmFs
dWUgKGhhc2hlZCB3aXRoIHNvbWUgY29uc3RhbnQNCj4gPiBmb3Igc2FmZXR5IEkgc3VwcG9zZSks
IGJ1dCBJJ20gaGVzaXRhbnQgdG8gc3RhcnQgZ29pbmcgZG93biB0aGF0IHJvdXRlDQo+ID4gYWxs
IGF0IG9uY2UsIGVzcGVjaWFsbHkgaWYgd2UncmUgdG8gaGF2ZSBhIG1vcmUgdXNlZnVsIGNvdW50
ZXIgaW4gdGhlDQo+ID4gZnV0dXJlLg0KPiANCj4gDQo+IE1pY2hhZWwsIHNpbmNlIHdlIGFscmVh
ZHkgY2hhbmdlZCB0aGUgQ0lEIGluIHRoZSBzcGVjLCBjYW4gd2UgYWRkIGENCj4gcHJvcGVydHkg
dG8gdGhlIGRldmljZSB0aGF0IGluZGljYXRlcyB0aGUgZmlyc3QgNCBieXRlcyBvZiB0aGUgVVVJ
RCB3aWxsDQo+IGFsd2F5cyBiZSBkaWZmZXJlbnQgYmV0d2VlbiBwYXJlbnQgYW5kIGNoaWxkPw0K
PiANCj4gVGhhdCBzaG91bGQgZ2l2ZSB1cyB0aGUgYWJpbGl0eSB0byBtbWFwIHRoZSB2bWdlbmlk
IGRpcmVjdGx5IHRvIHVzZXINCj4gc3BhY2UgYW5kIGFjdCBiYXNlZCBvbiBhIHNpbXBsZSB1MzIg
Y29tcGFyZSBmb3IgY2xvbmUgbm90aWZpY2F0aW9uLCBubz8NCj4gDQoNCkknbSBub3QgaWdub3Jp
bmcgdGhpcyByZXF1ZXN0LCBidXQgbXkgaW50ZXJwcmV0YXRpb24gb2YgdGhlIHN1YnNlcXVlbnQN
CmRpc2N1c3Npb24gaXMgdGhhdCBpdCdzIHByb2JhYmx5IG5vdCB0aGUgcGF0aCB0aGF0IHdlIHdh
bnQgdG8gZ28gZG93bg0KYW55d2F5LiAgSXMgdGhhdCBhIGNvcnJlY3QgaW50ZXJwcmV0YXRpb24/
DQoNCkFsc28sIHRoZSBjaGFuY2VzIG9mIGdldHRpbmcgdGhlIFdpbmRvd3MgdGVhbSB0byBmb2N1
cyBvbiBhIHJldmlzaW9uDQp0byB0aGUgc3BlYyBhcmUgbm90IGhpZ2gsIGVzcGVjaWFsbHkgYSBy
ZXZpc2lvbiB0aGF0IGhhcyBuZXcgc2VtYW50aWNzLiA6LSgNCkdldHRpbmcgdGhlIG5ldyBDSUQg
YWRkZWQgd2FzIGEgcmVsYXRpdmVseSBsb3cgYmFyLCB0aG91Z2ggSSdtIHN0aWxsIHRyeWluZw0K
dG8gZ2V0IHRoZSBwdWJsaWNseSBhdmFpbGFibGUgdmVyc2lvbiBvZiB0aGUgc3BlYyB1cGRhdGVk
IHRvIGluY2x1ZGUgdGhlDQpuZXcgQ0lELg0KDQpNaWNoYWVsDQo=
