Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1644F1E9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382334AbiDDVvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379834AbiDDSOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:14:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2127.outbound.protection.outlook.com [40.107.113.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E4F3EA8F;
        Mon,  4 Apr 2022 11:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMdr7BMvEv/4hcFYWkpjrekF9KLTfaLZOFkvBtF6uPDz48u2P8KZ0oG0EMTsjDIfydzVkXD9S1xXlrYTLfvK0e+mNpcYXYIkeaN1oT9oKBsIsFlJyKu2V12Act/kKLaN84l0nYNgCYad8R+P2nWKoCmojIkh1N8srUZtIfHTL1TTwLKweJ9jBb2gtQTasKFzWCHVDXlmxgAJXVRwPwY0/UEiHOEkltX6fqATJ1L2vqST4i5C3UsiVr16rFvfUpKBUBds5yG1akZGKEj4fPnWSIu6LztRLAHA+qVpDJgYQSzyzd7PJnX/IQ1JRIe+0lESQTi5RIgE0NtcbEoSK/lSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIMt5qdMyJ87InQgXWgbuwsg5dUM5SgsrTPyXhDQQUg=;
 b=QerDW9mkhJARxPDhibHL1CLvFh9uC578/ePw+GksTlY+tx8nVF6d5F1bAm0TLYi90R0cpXELBVhPVS8xs5MJeBT899AISPs8gA4vDQ7ZreA1y+b7fzW11GI1BZQssn+sjqkBua1vdylIaopAKrulPKX280R/Cn/KyALH9ha2+0X4dfG3gA0y3OligNXgUa2ojaAWIy+MKPeJXoQ6qcZ2S3PeJw3unYCZJS9myhFWkPIFpSExXne9ZRD87n7x9GzqJExUVVZk4nedl8sNfv9M02Fsu8+5adOb3s2dOrcxh4zPmouOjFTRi0fCUc3FQAaWKKj2t4ts/dtLDKpiBhKpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIMt5qdMyJ87InQgXWgbuwsg5dUM5SgsrTPyXhDQQUg=;
 b=UA4uUKoMLRbcs5omR/Wia3juke6udLcLpSrmN68liYm0q1ZLZwIWkITpHlXo7wy+EPS/Rz28iQtg6hhkSOkToBu2GSeO7EG+Itde3kcHdlBwyyiPMNh5VGXWm5OQBsvGpprnmANY6HnUGWQGKH+0nNprXwU4n70cY7jyFFlZKcg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB2510.jpnprd01.prod.outlook.com (2603:1096:404:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:12:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::7ccd:4eb0:e2ae:fca8]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::7ccd:4eb0:e2ae:fca8%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:12:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
 returning directly
Thread-Topic: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
 returning directly
Thread-Index: AQHYSEjXOMLpIeOQFkaJsJDtWSjZC6zgCvxggAACXgCAAABMoA==
Date:   Mon, 4 Apr 2022 18:12:45 +0000
Message-ID: <OS0PR01MB5922C35E8C5259C3DA2A951A86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922182F6302386EFF2ED66B86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8tdkw8-dUfrFG9kZizok8OQdcGHitAdb4E2tsBW3Xrh-g@mail.gmail.com>
In-Reply-To: <CA+V-a8tdkw8-dUfrFG9kZizok8OQdcGHitAdb4E2tsBW3Xrh-g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f455d2ae-5872-4ada-a4dc-08da1666b82d
x-ms-traffictypediagnostic: TYAPR01MB2510:EE_
x-microsoft-antispam-prvs: <TYAPR01MB25107925AA35309E6E089C1C86E59@TYAPR01MB2510.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7J8dHcZHhRA1604Bp/88imez1DKDadygXWaWMbDctuyx68uNOKmQd/sru84fKfmzFGU/myLVIYT+0NZ6CnHWsWpqmLhA/pc5ajst437fh2vzDZJgGc87H4hdPjMTFo8nIxUzBVgDDU4wJTSuHbgvT/b2FRE0QVkDHgTJcUGz+NNLgcs5v6emof8k/M5OeCSEAimlGZpC1YPl/6bt/LgJGFLBCYJI5OFHA4ThJk80SfiljU8CmQhBlmMmxObrLndYC/eeEyjK432i7R6dq7IZNg5v2wS+DOXisEBUvXF8oO8G7cGYpJboNOyh54ERf1/T7bl049tiT8yafAlL2AvKt672kBo0Mj2UlWwUeitcnG325Xvuib+/xVhRXuHrcwtt0CRQE3yudBRZW16iR3+Q3zeB4yP4A93QTGpULOZ1rPsg4Ov59YYXCbj9xLGzaBXWYzWYUsberxgyvBP01oScuwZRmJIx2DZmuhSQeWYIIUxdjd9qmwiG0QRzgEcuZHwUcsa3X3zjwa3R16xcf8OQ1KkKszPHyzlIFfmqigS7uzozdG+wEv/h1RtiI7txe7qcRsVZwjlCetf4aMXynEsJOuEWX2kNiYPbcfYZeb9mMHyveL5JRay5UHFFvZGVVUEcJ580MNy7B0SS9qQaUh8eSlbU8rXq6bidoand9g1MB7a8KrNuCePnd+qA2BnS+revOEsOv8aNNzdtDSzTWyOzew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(508600001)(5660300002)(55016003)(33656002)(8936002)(26005)(186003)(38070700005)(83380400001)(8676002)(66476007)(76116006)(66946007)(66556008)(86362001)(110136005)(54906003)(52536014)(4326008)(64756008)(66446008)(316002)(7696005)(53546011)(6506007)(71200400001)(122000001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0piRE9TWXhqVUZyZkZ5ZXF3YXk5RU84NXJXMitxbVRocmF1WC9QV3p4Qytn?=
 =?utf-8?B?QUdYZGRKU1B3MVVMTzhtNHVNZGhnaVZsUUUyVy9tcmZ1M1duWFpHV3h1bXpi?=
 =?utf-8?B?cWJmQ29EV0NKMGxRei9xSGJDQzdkWlJkTk9uODBjMzFnSy92NXV6OU8rS0hE?=
 =?utf-8?B?TGRQeW9ITHNLYWR0VXdIa3pjMzdNVTJ6Y1VsSDdvOTlsZ1FtbEl1SUpvQUJt?=
 =?utf-8?B?WlFsTEtnMFN1a2U3QVd3TlVMY1hsLzNhdE9GZEhEL1lHWmRCY1VuT1BVbzNP?=
 =?utf-8?B?Zy9CU1VEZUZ4L1Q2Z2RSYXhWZ295Nm1sUXB6bmVndE5Sd2d6bXBKbUZHZmVT?=
 =?utf-8?B?N2psNnEvUVora2MzWGJOdVg2d1prWmdRcXBEcEhnVkI3ejVJQlVwbm5hYUtE?=
 =?utf-8?B?d3p2UHVHTlRqRSsxWEhSQy9FUW5qeE1ReTJaTjBmYkcvNnJ1VkZKZVpNbFl1?=
 =?utf-8?B?TDAvN3Y3L1FqVSsvV2szNDZlbVVtVXB0b1M0S3IwSWgxd3BaVlAxQjVrUEdu?=
 =?utf-8?B?MzArcXpjaVFreXBtQ3V4QkIyb2xxMTliUXkrMTFNWUtzbkpoRExWMG5sdTJN?=
 =?utf-8?B?eDgxY05VTTVkNEdoMUxCZ015UlR4N2c5VFdTbVpIN08zVTJLNDZtUUtncGJ2?=
 =?utf-8?B?b3FSMk4rZmdZK1ZFSlRvcDJRVDhnTFlzd3dGSk5pVkZYRkdVVkdTcDJpUFFh?=
 =?utf-8?B?c2Z4aFQ2czg5dzdTNTBmUzBQV3RQRHpjWkdBYTRteEkvMk1aMWhmekNERjVi?=
 =?utf-8?B?Zkk1VGJycWhsMFAzTEl3RENsbDJKY25KYnp6YWg5MnZQS0xCRGRLV0lqcWtx?=
 =?utf-8?B?SXRTK0xVd0F3VmszNkl5UGtyZE40eXhxK3pQUDk4dVc1T3NDaG1KL2RKdTFQ?=
 =?utf-8?B?c0JtcW5ZUWlWTkR1VFN2VkJIbWl5b1Y3UFEzc0xYR0luMVFlYUdkVWJxRnlx?=
 =?utf-8?B?eTY2TXBuaGdXV05QNkkrcld0MzJhU1YxcFhZeTBvMnVNK1NZZEcxeWpQOTdL?=
 =?utf-8?B?cFlEeGdKMFArNCs1eXhXNmRlVm9SV1R3cDQyK1Q5S2FTdzgrTEh6OW9RLzdU?=
 =?utf-8?B?aEhaMUoxSitxYXpoK0lmcTFWOVUxblA3Nzk0OUQ3YXJ6K2NUMCtRbUdBTXNv?=
 =?utf-8?B?ZmNvV2ZIeXViM3AvZ2FTVUduMFNyeEROUVU1U2duN1lsdHk5Z1gzWmhGU0Mz?=
 =?utf-8?B?WU00ZzlvU2ZFM2l2cmJRY0dzdWNaMUE5TVdrQnYzTlZRc3lFeVQ2YTZEU1Rr?=
 =?utf-8?B?WCs0RFF4UXYyTGVYLzdnM1lWNGZ1b2lsWUVjTE9XQ2NwR05KQTI2RzhURnFj?=
 =?utf-8?B?a05vWXVTVXNxR240dFExc3N6N3dwVUdFdk5kR1orTHZIMmlqaG5pYzF1RFVK?=
 =?utf-8?B?MWdTam5leUx2QUhJaDQrL21zLzl3dzdkNjVkUkhOdXRacms3dGRJL29SYXEw?=
 =?utf-8?B?NXYwcjNqL0FVK2pML3hheFQ0SFovYkZNRE9rSmVXV0FOWDdoREM1c2dMWWVY?=
 =?utf-8?B?YzkydWZJNG05enFrSWJhejFvbnVZa0ZQK1R0NHc1a1dqcE5XS3AvVDZKRm45?=
 =?utf-8?B?YVF4dXRZbnd0RFpiem5aN05HdVJ4UFYzV0dRTUhTVnhVdmtCaXU5Y05uRk85?=
 =?utf-8?B?WGJFb0xmWW5LVmt5VXprY3l6aUZZQ1lLTE5LZyttZndLQ28vR044YklCdmVC?=
 =?utf-8?B?bzhGUjdWTkl5MjAxNzE3MTJPK0FMZ1Q2cHVwRTM0Zk51UHl6Nms5cHRVcStk?=
 =?utf-8?B?MU9lZHU2ZnRHUDF1MWhQRUFGTVhOZTBhRnE3R21SNGgybG1mOXJpcFZYUE5T?=
 =?utf-8?B?U2RjOGgyNWNrS3UreHBFYUFLeEZrVGF5Rk8yejR2Qm9HM255OVJON2IzSThm?=
 =?utf-8?B?Z0pjUmIyT2Q5TW9POVZIMFZmRzcwYzhDclY5cGlsVncyL0RJZS8zNy9VWVdS?=
 =?utf-8?B?UGpLeW0vaCt1ZmpFUHBOZzc3U1kxMFdzdU9HeVdIOGNzbit0K0ZSbXhleFZ6?=
 =?utf-8?B?Y3NpWDNSU2I1WXhjU3lHUEpjTFZycjcrZ3kxcm1vZjJRaW9zV2NTUWhYakJ4?=
 =?utf-8?B?VW0yTnUvV0VYeFR0N0kxM3ZZRkRFRzBmdjhBM1dBeVR1RnU1WDNORzJtUWlj?=
 =?utf-8?B?a1JDNjV2L0lxOW9sRkc0VHRpc3hIcmFUcnorUGtzSklFaWJZNGlJSS9uRW1l?=
 =?utf-8?B?a2QxQzQwQmVMeEhURk4zZzZUdVNDSGlSZEhSa1BvdHRIVzZOK245dGJ1SVZl?=
 =?utf-8?B?clRibEk3Z25OUlovWHYwekxhRHpDM2RkYXpSNnM1OWNRaER4dFNDQlJQZDVN?=
 =?utf-8?B?UGk1KzViUk90VDlCM05IOUpxMUhPaE5mNng0TVUrN0V5UHNzeDJickhpb2NS?=
 =?utf-8?Q?r+S+Z7zuaRZPW6xQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f455d2ae-5872-4ada-a4dc-08da1666b82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 18:12:45.8195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +W+z/ZS28iQmyp8U7TpafOdwNr+N5BtGtsHLTkX3sVbW6yaCUX24UDDOXfgCI/HLgFN7/tI7VBtqVRqFpviOPlfSH+z4aFEAfQy8T7uBvxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2510
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhrYXIsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIG1tYzogcmVuZXNhc19z
ZGhpOiBKdW1wIHRvIGVycm9yIHBhdGggaW5zdGVhZCBvZg0KPiByZXR1cm5pbmcgZGlyZWN0bHkN
Cj4gDQo+IEhpIEJpanUsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQo+IA0KPiBP
biBNb24sIEFwciA0LCAyMDIyIGF0IDc6MDIgUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpIFByYWJoYWthciBhbmQgUGF2ZWwsDQo+
ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaC4NCj4gPg0KPiA+ID4gU3ViamVjdDogW1BBVENI
IDEvMl0gbW1jOiByZW5lc2FzX3NkaGk6IEp1bXAgdG8gZXJyb3IgcGF0aCBpbnN0ZWFkDQo+ID4g
PiBvZiByZXR1cm5pbmcgZGlyZWN0bHkNCj4gPiA+DQo+ID4gPiBKdW1wIHRvIGVycm9yIHBhdGgg
ImVkaXNjbGsiIGluc3RlYWQgb2YgcmV0dXJuaW5nIGRpcmVjdGx5IGluIGNhc2UNCj4gPiA+IG9m
DQo+ID4gPiBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZSgpIGZhaWx1
cmUuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IGI0ZDg2ZjM3ZWFjYjcgKCJtbWM6IHJlbmVzYXNfc2Ro
aTogZG8gaGFyZCByZXNldCBpZg0KPiA+ID4gcG9zc2libGUiKQ0KPiA+ID4gUmVwb3J0ZWQtYnk6
IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExhZCBQ
cmFiaGFrYXINCj4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMg
fCA2ICsrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvcmVu
ZXNhc19zZGhpX2NvcmUuYw0KPiA+ID4gYi9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9j
b3JlLmMNCj4gPiA+IGluZGV4IDI3OTdhOWMwZjE3ZC4uY2RkYjAxODVmNWZiIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9yZW5lc2FzX3NkaGlfY29yZS5jDQo+ID4gPiArKysg
Yi9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMNCj4gPiA+IEBAIC0xMDMzLDgg
KzEwMzMsMTAgQEAgaW50IHJlbmVzYXNfc2RoaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ID4gPiAqcGRldiwNCj4gPiA+ICAgICAgICAgICAgICAgZ290byBlZnJlZTsNCj4gPiA+DQo+
ID4gPiAgICAgICBwcml2LT5yc3RjID0NCj4gPiA+IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0
aW9uYWxfZXhjbHVzaXZlKCZwZGV2LT5kZXYsDQo+ID4gPiBOVUxMKTsNCj4gPiA+IC0gICAgIGlm
IChJU19FUlIocHJpdi0+cnN0YykpDQo+ID4gPiAtICAgICAgICAgICAgIHJldHVybiBQVFJfRVJS
KHByaXYtPnJzdGMpOw0KPiA+ID4gKyAgICAgaWYgKElTX0VSUihwcml2LT5yc3RjKSkgew0KPiA+
ID4gKyAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKHByaXYtPnJzdGMpOw0KPiA+ID4gKyAgICAg
ICAgICAgICBnb3RvIGVkaXNjbGs7DQo+ID4gPiArICAgICB9DQo+ID4NCj4gPiBXaHkgY2FuJ3Qg
ZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUgdG8gYmUgbW92ZWQgdXAN
Cj4gYmVmb3JlIGRldm1fY2xrX2dldD8NCj4gPg0KPiBJbiB0aGF0IGNhc2Ugd2Ugd2lsbCBoYXZl
IHRvIGp1bXAgdG8gdGhlICJlZnJlZSIgbGFiZWwgT3IgaWYgeW91IGRvbid0DQo+IHdhbnQgZ290
byBhdCBhbGwgdGhpcyBjYW4gYmUgbW92ZWQgdG8gdGhlIHZlcnkgYmVnaW5uaW5nIG9mIHRoZSBw
cm9iZS4NCg0KSSBndWVzcyBpdCBoYXMgdG8gbW92ZSB1cCwgZmlyc3QgZ2V0IHJlc2V0IGhhbmRs
ZSBhbmQgY2xvY2sgaGFuZGxlIGFuZCByZXR1cm4gZXJyb3INCmRpcmVjdGx5IGluIGNhc2Ugb2Yg
ZXJyb3IsIFRoZW4gZG8gY2xrL3Jlc2V0IG9wcy4gDQoNCj4gDQo+IFdvbGZyYW0sIHdoYXQgaXMg
eW91ciBwcmVmZXJlbmNlIG9uIHRoZSBhYm92ZT8NCj4gDQo+IENoZWVycywNCj4gUHJhYmhha2Fy
DQo=
