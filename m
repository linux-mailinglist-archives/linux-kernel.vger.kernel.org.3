Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8E55C9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbiF1GCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbiF1GCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:02:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2073.outbound.protection.outlook.com [40.107.113.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F182CC81
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US4/3ALE+GaxBKiUEG42EAkv1Lu/KngJPS/CejhpTCPAsiqre3qJGheTDLHLvYq49a+TdxnLY5s/kGRZJnkAG8e7mB8gZbMXvHR+i01qYdtllVfBY5rDXtpO5Y9ZkVNhSQ3oninFuWcew5kZLDTNm96ieV34gxIJS6Ok7G9nNqQBxR0u6ZuCAaXem95p1OzfGVz7WNnIWMLqbAqMX+TlV92UClxVhegU711rP7ZS2oXd4sV2H/TxnraMO7RUfMSx5sYzvUqkt4pHsQgWSXw46LJBMvK9VhgXg7y/A7uvo4ddCTs3jXQrAa32Qwl11bY+WGc8WT7bvDa/iwi4b63LHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lZ1p3sr/fWt0dZ6IEfElTkvxPtzVYPt6ynpBmpA5EQ=;
 b=QABEkrjJ1+14WOEUCvYSAjs2DGTBylXk9i8TOHL4rJiGcG9Dlhw0mu8M9liJPIgTbwZbmKEVKcR7s1ah6fkmQGKiEKP0po0SXFYFZkTXZhPyDpINuI06I8i965RArYHjBEF3/3JZKUqWtpjiiv2tMn9dmWgqME22IH4VX3QzSARvGgD238RjW6tw8jEJeEnEcoi8BHOrbO0ZdSkblW/FpxEuR7q8TvUdh1so7X2pb62c5vShsTmYaYDjuRZZkncQ62JySPyBOzZY5udHHfE5rPaFLvC8/lCWosSijz9kqe+k8lGIRLJP9iP44WYYUIy3/rcxSMo+TqgtiPIrQ8aYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lZ1p3sr/fWt0dZ6IEfElTkvxPtzVYPt6ynpBmpA5EQ=;
 b=eNY/yWkpxH9NrqJXfe9thHIyXLdFhaobQmwuBrgHDBbGnEghVg9SMxNRw/qqSsmej5REYl2Ipi/LcRiM8viZWG7Bo/rGSOhONw5AIcIRLK99MWmrujysRFuZJFLtfxY0I6yHeDWma5dNSgVvKwVi2e9nqspwlQPMjk9uaMxWVVo=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB5291.jpnprd01.prod.outlook.com (2603:1096:404:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 06:02:26 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 06:02:26 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] mm, hwpoison: make __page_handle_poison returns
 int
Thread-Topic: [PATCH v2 7/9] mm, hwpoison: make __page_handle_poison returns
 int
Thread-Index: AQHYh1xdL+6bOgbea0+h6tPs9sNjt61i+p6AgAFf3YA=
Date:   Tue, 28 Jun 2022 06:02:26 +0000
Message-ID: <20220628060209.GA2204868@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-8-naoya.horiguchi@linux.dev>
 <ecbcdd7e-b21f-315b-7eff-1eb692e320f7@huawei.com>
In-Reply-To: <ecbcdd7e-b21f-315b-7eff-1eb692e320f7@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae409257-4657-4aee-767d-08da58cbc6d6
x-ms-traffictypediagnostic: TY2PR01MB5291:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCYroKghYACwO/S2i5VvojZjs9Dp1q0juBHoUpBalSmuGT4r4MjOlsYdXZJWdecsu+S06q6lL6Lo6DW5D5QaDXjHoVf7QQNQqvwKvWMoGp3nvaChtnvVb8+sdHTVhCltgRHrq8BAhDdXBPna46O12S7LW/P9bLQ08Ejziz5bxei9svocaWv4rXpRjuBX7bwN3148XJ8+mIJWubjYEMOneMHLZE/a0/UIcUX2juP3CNgDQf4XZyHS0PgAWd7p/tJNxWpEHYYT6Z9rEvwbAqaAjRflyPOdEQ8eK5SHR3Vy3PmnzYiEEm7ZZ0PELBr6D4fatORA8g0e3kQs8sc2XuZcxLun4VbjTLJ0PT8tVN/h8OkkWu6mYNPY/MpBDrrxU7I3k536fCEwt5B6eEo0gJo9JbNZ0AnKLwubUg9deP4Fwl9h4BEtHmeSWcJj11Iq6dGLaBa864iep9EJmTYmA8od6ckrFVa6tFtJ5wexK8J5zZvaIC5EkzFywVo0QGTfjvjLZnLH1kV9Qokk1VGD8i6YeRWS4Je8+Huvp96l8sRdYfyxjlzqkrj2DdzxM+aH+UeiIJwXvsN+7l1b6iGU6r4yR5eR//+4UjDVH6cu5d4AgpPtzezmCJaO7WY44bqz6Kn/GMVIMMiEGL8raAlb7b18oZ+ogtoiNkfMi0bT1RFrbextlDLitHkG1UwYXKDt5ej0/anhMq3J/Tsyh+pUH6o6fWjzpXJ5W0dazf9SJPc3jRqdBjvs8jGFUDT0/hWD/EG36/XogLHX881u0QWXekfFCyD45IDRUtnIdMDHk9TgvBaPV0A7ON6iel1JNdI5fT15mTubagAEzcy7ODjmu8a+6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(186003)(41300700001)(26005)(55236004)(6916009)(38070700005)(53546011)(76116006)(54906003)(8676002)(6506007)(66946007)(83380400001)(6512007)(1076003)(9686003)(82960400001)(478600001)(38100700002)(5660300002)(85182001)(4744005)(33656002)(4326008)(86362001)(2906002)(7416002)(966005)(66476007)(122000001)(8936002)(316002)(71200400001)(66556008)(6486002)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFJ1cDNjbG5sTW9wSStkOU5WWTJGUUx2ZnEyU2VWeDVtcjNOdm9OUkNTWFRa?=
 =?utf-8?B?REorU0lyc2FrVUd4b0RZMjk5WU5aRzN1ZjkzOGpCcDJ0My9NbVE5MUNEZzYr?=
 =?utf-8?B?eUxnSzdYQVY1amQ1Z09rcUVvYUhJSGk1SzRYOG1lZ1JYS0pwWHdTb1BvM091?=
 =?utf-8?B?c2UyMDhiTzQ4L2ZKUHpyeTZKSHhUd1ZEbDZVdUlMQmF2ZkdUN3ZzaVViN1Vh?=
 =?utf-8?B?QlBNT1ZKNGVoSnl1NGNYZDI1Y09zK2RudGZrVmJ3T3dGbkxVRHluSzlrczl3?=
 =?utf-8?B?dXNhTFhkRTJlc0dveE1BNW5oRVJzeEozWC9CVURFS0ZTS0d5TXoxaDVIZjd3?=
 =?utf-8?B?T0JrQlZtcThvOEFqbGEvaW52MHo2YmxUUEtpMmVHUThubDJkYVJtN0VyMlQx?=
 =?utf-8?B?SEk3R1VteHN2OXJvSlJhYUpoZTFIZWpQOG9pc1dRc0RlNDA1NkVUeE1sQ2F6?=
 =?utf-8?B?LzQ5QXE3MGNMWDBBbkkvQTlLSitqelNCM0p0dXRCSndlWGZGS0VTeTZCMVJU?=
 =?utf-8?B?Nk9oOG9ET0oyWnlzbzYwaStDV25kei9ZT0k2S3lRM2tiU3BSemR3ZzZMNXRy?=
 =?utf-8?B?Z1RVWnpNTVE4WnpMbnRxQXplS3JSa0hDWW9pVXVkTnQ4bW1wdnlsK0tuY1hj?=
 =?utf-8?B?eW5JYzhwelFneWNUZUlVcElheDBrWW56aFplU2lJWGtid0I5Z1VDbnhVcnFi?=
 =?utf-8?B?dlhEUDlRM3k4dFYzbSsvOFVhRytBN1lUbnNnTG83VlpWdnFWdVFiYTBta0wr?=
 =?utf-8?B?UmtLdXpIdkxsSEx5UktsdzRRY0d5d2NaaVNYVzNtRGVHRHlVZ0l1emk2WHlZ?=
 =?utf-8?B?c3hrdmw2QTNVeW9ES2RpOGN6V2dlY1ExT2JMSGhucjArWmZKOVpyT1JuNnpO?=
 =?utf-8?B?MExGd1YzZkFrY1daa3RSek5zbVJyVDh2VkVzcG04aG9aeTludno1aXZSaHh1?=
 =?utf-8?B?VUZBYUZRekFseU9tVlA4QTk1TkJrRkg2QWRtR2lzMDJjL3I5WGtHZ2pQUlN0?=
 =?utf-8?B?SDJWVWdkRk4rQ3Z6MU9TeWdiSEZxdzdXMTZHUlFLdjVEOEpabW4zOG92d1FG?=
 =?utf-8?B?TzZoTDgrS29KUlgyS3VkaHZHeFhaTjJzWGlwekw5WW5nUWlHODJrK2FkZnF2?=
 =?utf-8?B?OWNzV1gzVnYrcHF4a3NTQjdMWWxXQXVmek1ydzJISXhqWTBKZUtjeHZFTFZO?=
 =?utf-8?B?TUVSNEZJSmhIRDVETmhmNndTS3dCNGQ2UXIvdXBUSW9Vc3RkMG9kQ0FwR3Jo?=
 =?utf-8?B?MVFUSkg0MVJ6RkswVWJIa00yQWlkZXZDelNBL1hpZUVoNHh3RVBobmlzMDBx?=
 =?utf-8?B?SlJWTHJlOHgvNkxtME5FZDdNYXUxNWNKNncwaHhCdldXVWZQWlA0Mk12TjFX?=
 =?utf-8?B?VnZ4NWsxenlsYmg4U0VNV3U2V0EzekFiekNYMUlrUENYZitSM2tqNHBSZzdh?=
 =?utf-8?B?U25ncjBDUWdpUWdjaTY5aE40NzNCL20ra1MwWkkrWno2dW5VK2d0TVNzeHE2?=
 =?utf-8?B?VHVUampaVmJLTEJPVTdVRnk0NWJ2OU44VDdoZmxwMDBCck5QSUNJcStHZDZX?=
 =?utf-8?B?T0w0SUxvRmQ2UFZmUjRwZ1NUY2kvMGVSY0lyMzVBMU4xb01tQ2cyQkNpd0FJ?=
 =?utf-8?B?U09EVnFYeHp3S2tLKzdTOUdQYUFtVk05bGpZMEw2SC9qTjRmWHJrTW54Y3FG?=
 =?utf-8?B?MmF4WlNNNFQveGtCc2JvcTNKMk8yVkRRMUF1QzhRZmlyaExya1FDaDhjam9x?=
 =?utf-8?B?bFlLZjdvblVrTGZ4Ykl2eTVhRzVKWWZDczZHU1hZUEFsbEJ2dkhQdDE1SXFQ?=
 =?utf-8?B?Qi9lS0hxaDVINDl6Tnd3UVc5Rm9QdmNGb1RIaHhVa1l6TjluQ0t2ZXhSYis3?=
 =?utf-8?B?K0pQd3ZXMXBhYWRHczVOeER0V3ZRT0JxVGxRa3FwWUxHY08yQSs3aFNWOXBk?=
 =?utf-8?B?OXprOUk1UEJxOWI5T3dBbXdGTlRva2RBMCtuOUxWbjh5aFpNbklIRjB3R1Jl?=
 =?utf-8?B?MEMwOHI2akJaSE9lbVNqWlBpVjg4VG1KWEllZ24zUGJSTm1yczZlY2dwdEE2?=
 =?utf-8?B?RFViV01XMllJUFBVUlVXb1B0ZjBEd2RwRUV0Ty8vczNiaWpIZnBoVStIUkd3?=
 =?utf-8?B?dXNkSDZQNnB3L0xUdCtvWTZiNWhuSzRTa3ZhTXptcmR1aWQzVmowT1hZU3Yr?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6501F10DF2AB194C85CC38C1157B9D0A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae409257-4657-4aee-767d-08da58cbc6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 06:02:26.3583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWrSECEN+FA/gq72cQjUU/RJjIBtoTxFW37b9j+/DhQBdmOMZWERfuCJn3ihMXcFHR+PhXJ7Dr/LkPCPQqMsXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdW4gMjcsIDIwMjIgYXQgMDU6MDI6NDdQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi82LzI0IDc6NTEsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9t
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IF9f
cGFnZV9oYW5kbGVfcG9pc29uKCkgcmV0dXJucyBib29sIHRoYXQgc2hvd3Mgd2hldGhlcg0KPiA+
IHRha2VfcGFnZV9vZmZfYnVkZHkoKSBoYXMgcGFzc2VkIG9yIG5vdCBub3cuICBCdXQgd2Ugd2ls
bCB3YW50IHRvDQo+ID4gZGlzdGluZ3Vpc2ggYW5vdGhlciBjYXNlIG9mICJkaXNzb2x2ZSBoYXMg
cGFzc2VkIGJ1dCB0YWtpbmcgb2ZmIGZhaWxlZCINCj4gPiBieSBpdHMgcmV0dXJuIHZhbHVlLiBT
byBjaGFuZ2UgdGhlIHR5cGUgb2YgdGhlIHJldHVybiB2YWx1ZS4NCj4gPiBObyBmdW5jdGlvbmFs
IGNoYW5nZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lh
LmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IC0tLQ0KLi4uDQo+ID4gQEAgLTE2OTgsOCArMTcwNCw3
IEBAIHN0YXRpYyBpbnQgdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9uZyBw
Zm4sIGludCBmbGFncywgaW50ICpodWdldGxiDQo+ID4gIAkgKi8NCj4gPiAgCWlmIChyZXMgPT0g
MCkgew0KPiA+ICAJCXVubG9ja19wYWdlKGhlYWQpOw0KPiA+IC0JCXJlcyA9IE1GX0ZBSUxFRDsN
Cj4gDQo+IEl0IHNlZW1zIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uIGluIFsxXSBpcyBtaXNzZWQu
IEJ1dCB0aGF0IGRvZXNuJ3QgbWF0dGVyIGFzIHBvaW50ZWQgb3V0IGJ5IFsxXS4gOikNCg0KU29y
cnkgZm9yIG1pc3NpbmcgdGhpcywgSSB1cGRhdGVkIHRoaXMgbGluZSB0byBiZSByZW1vdmVkIGlu
IHBhdGNoIDgvOS4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBo
dWF3ZWkuY29tPg0KDQpUaGFuayB5b3UuDQoNCi0gTmFveWEgSG9yaWd1Y2hpDQoNCj4gDQo+IFRo
YW5rcy4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjIvNi84LzEw
