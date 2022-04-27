Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9126A51255D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiD0WlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiD0WlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:41:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2043.outbound.protection.outlook.com [40.107.114.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B1290
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuFClHzVmVzPiwBccfn0BBxMq+TsiH7jFmnH4I6tFrjsTbEAexpyeuWogM1+FLzsTllp153iPAP6krTBoI4zzkpBZzKG/UV2s3iGTDndXDb/S8X3oDJckd4c1uHXknFtj9ebglzo5vL7cqwvRWsnHZMjdcz+9YYfTIDLy5Allrbc+cpqEG9ztjocftAyhG85jub2gnccOWnEsj9fzptgnkQGbGQY/W3KDb4JiExMgsDMBw7hodYW2ohzSJs57EsYES7bRabep40Nbz2o8XQAOamfi+96zVKkVjBk0istYccygS4K92NLSDENi0gjein7d84wd7PT2PMPY6WvQn8jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pYgMcpTvqBo0LIURlradzd/lpfAXcukoYT3/i4ARuo=;
 b=buzcGv7Y6uncbp0zTpR2jQW+uN8bcJX+ssnn+DNPnrJc3CmMsu3ESJ464KsPDKiY5OwHypXhNZSc8hvpy001UXmlcPA3lfC3jnjWJwaLke8BWDPrm44FeMerfLw9x775qUxN+KXVrmfAWmDJOPF6nspFc3ogwZorz/DgQwGmX9Xzu8ujALhmBVpbyEENDd42IEaPQfDBl/5iTDkGjVs7U4TVEDkw+EDq0wcKVlnec8iri278ZpkG6piOol3ykxJZmMl8DfyjQmL7Nj794zRsIc5q6rynBef3n1IR60i4YK1BQZzbzvSW2j6qUos9eFlF3QmeA77gxbf6lUqY7zj8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pYgMcpTvqBo0LIURlradzd/lpfAXcukoYT3/i4ARuo=;
 b=epEQ1wLIm0LK3Izm+5hwWvP4EDABs5B3v7TdX+rggtFdaaaHnkzGVQbTEMUQIe3JreEUOVqwwLHnl3WdZNp5+3RlpvShl79+Cs7OARss3gXdYTVjXaQ6QOj61INTcS132dNB1J8yS41Yg9Ei/L3TOGpVYH4xfNi/wAxwCfWA5V4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB7552.jpnprd01.prod.outlook.com (2603:1096:604:14e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Wed, 27 Apr
 2022 22:37:52 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 22:37:52 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in
 get_any_page()
Thread-Topic: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in
 get_any_page()
Thread-Index: AQHYWfhJZ7elbxssz0qw1aFWQG9rC60EIlGAgAA4mYA=
Date:   Wed, 27 Apr 2022 22:37:52 +0000
Message-ID: <20220427223751.GA3935899@hori.linux.bs1.fc.nec.co.jp>
References: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
 <20220427121517.a9515a17697424604f8fbcf0@linux-foundation.org>
In-Reply-To: <20220427121517.a9515a17697424604f8fbcf0@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad66b26e-d8ec-41c7-2e41-08da289e90c5
x-ms-traffictypediagnostic: OS3PR01MB7552:EE_
x-microsoft-antispam-prvs: <OS3PR01MB7552C036327C091C3768F4ACE7FA9@OS3PR01MB7552.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MICtGVZ8wgDBUl1g9kemQdZLwypVFU77FV/mx356GkOp/ZLp75dqyrXkSHCwxYRYKNDiRFTL0/LqN9bVSqW7HKfZAJyE5CuDinv3mKaUeklcdJ88IbbTc0lxIv1cKbQpWghU4GN/wU1QVwp4r8dbuZW9gdh5zwoG4bG4frfbgmrpW1iOqG1z5JCw0xbt2ngNlQY1YLU0Qgo+wrLZEDi5LtGQGhiQsjFLto6jLXBoHxOz0P6rxiP0aSH2VqqaUI3cAG+1HZq/OvirEtotwWxQZXmh437FJK5y/uBAyEXEzPyZ8W9BmqHO4KH+UbKgHaVyuiOBnuobdnR7R5WJ/hrmodIGnbjnkmKIcrCTQFk9+iFRePkE8YYNMxhmdWqivN4Dd3quNYiWRfPZuuSIEXWacKCXKGznVnDuHHaw5xVFOuy0xJ+zZPRc+HX02SadMz2IER1WWlwPnNFhtFH1F/GvGUXI3hiY+okJHiU08UW1+Y4goAYMHDaHprwnn6fJnvbj3LYbTsn/bV63XKErVAQam6dQlxJ1UVtnhz72i12VXMIxVLz/fzWUMTXQLLYcUTdgW+g46dwEZUw/Yt13ZfSgTCrVCGpxMzxt6k0aXwZ8RHz7jVEHnyR6gqgzSX1GLwFew6FoyGQ/0pmDmDzmOHFbwov4EFvcq0Mvyu76fD9RLUAiA5Fm/JpmQemTfDM0zZJCyShEw18F6nPmooTJfO7Dqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(71200400001)(54906003)(508600001)(6916009)(316002)(38070700005)(122000001)(38100700002)(82960400001)(186003)(4744005)(1076003)(2906002)(7416002)(8936002)(5660300002)(55236004)(6512007)(6506007)(26005)(8676002)(66446008)(66556008)(66476007)(64756008)(33656002)(9686003)(86362001)(66946007)(4326008)(76116006)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi8xcFpFWWtxUE9TYVc2dVJLRmZPQnFNcFp4YVBLSCt5eEZydmM3WlFVcm5r?=
 =?utf-8?B?dWhXWkIyYWczMXF5R2VXVUtBM1RqVVFETHRWdC9NQm9nUnFnSWlyUnhGYlM1?=
 =?utf-8?B?V3NCb3cycXVrOENaMFROTUk5cVBya3lVQnpVOWdta014V2FPeDY1SjVLYm0y?=
 =?utf-8?B?SE0rVEg0ZTlndFF4cnptaXlVZTVPTXpYN3ZRZlloU1dpK2pmTWx2TFVPNkxW?=
 =?utf-8?B?WDB1aXNUdGNGbTZSRCsxTUZiOEVoanFxdityUE1Md0M1WmpRaGFreTJqUGhH?=
 =?utf-8?B?VEZHdlBMTElRZ3dxcGRTaFMwbDJtWmhES1gwbGxFQzhzWVg4NkN0VDQ2OVhP?=
 =?utf-8?B?S3hIKzRZOG42WmlHUWYwdUVoTGZoYmtIalR4Y2JkYlhTRXBBbytBOXhQZGZR?=
 =?utf-8?B?REVrazZqRmczekMxYldiMXRQNUVFaUpza252QzZBMEpEYXpxdDhTayt4OTZv?=
 =?utf-8?B?RnB3ZmJ2TVVwNjU5dCtoVE5QZmQ0OUhTNlRQQjBqU1NWRTNjaVFIcVoyOHNS?=
 =?utf-8?B?ZmNPMXJWeUs1OXRyYy93N3lwbG9zbWpzZHN0SGZXZmE3cHdER292QWZLYndP?=
 =?utf-8?B?VDJ2d1pjQndXMDI3blJmOURRN0xEQU5JK2RYY0xua05UTm0xbzV5OFUyR29p?=
 =?utf-8?B?ZTlWZmxOcVNxb001cm94SGk1MFoxUzhOMm1WOStSRytZSGt2OFU0cVBaNXU1?=
 =?utf-8?B?SktSTlBrUDlGbEE0ODBVRnZabmRyMGJiWXhnTVJSUlowaVJKYUVFOTYvYlNC?=
 =?utf-8?B?SWNydUI5YXFhWURod0d2cDVRNnRmSmJZS2tyVFNTOGlCdFB0N1VBZEtvVHN0?=
 =?utf-8?B?akRsTHcwbmdYV1YzSzQwOC9HY1ZqTEdSYnJSM1BRbzVlby9mcnR1TnlRWXpR?=
 =?utf-8?B?Yy9nT01VNlBURjhCZXlZT0lWZXUvMEtLd0xrdUZUQm5CMGg5M01hTGl5M0lE?=
 =?utf-8?B?eHljcVNOQ1B3VDd0RzNvbmUweDVPUW5ueUx6aTZPQkY2cm9YSUgzWjJPV3JF?=
 =?utf-8?B?ZzRMS2ZWaE14ZUNTSDRHZWlkdkVydTBub0RvanBuTU9sdlY0T2gwTXNobXlO?=
 =?utf-8?B?bGw1TkhSRnkzQVJoVjFMdTU2bnFqMlFxSUZBV3VFbW1XcUFxdGE2V3FkVlRm?=
 =?utf-8?B?d3Y3UzJjQVhXMHlLNFZZTW1hejh1dm8veUhUU1p5dHRBYmhmOGllV2ZETTE0?=
 =?utf-8?B?cWROcFBUMm9Ea1JwampDMEUyaitSclJ5SWl5SGVxNWpsdFpCajhRN3VLZFly?=
 =?utf-8?B?TEVyc0hIOU81c1BzUTE3WlIram5lRkVST2toYUZqZDVEdUplL2d2bGxTaGpY?=
 =?utf-8?B?NlZpbG45cnYvM0txSncwOFJ6L3JobFIrVXRzMVVkYWVFdVN0Ly8rRmYzT2Z4?=
 =?utf-8?B?Y0NsWUE3cG9LN05Vd0FDV1R1V0xwVDFsS0pnM1pUQ2g5Q1QwWktFTmt1d3lU?=
 =?utf-8?B?bkhTKzJyeExNdXdGRElIZmZaQXVPcFJDWjNIaWY1M1h4RkFRWEl5ZzB6MGIy?=
 =?utf-8?B?dVc3Z0JjeDlIYUlOTVg1Uy9hY0Q3NXkwNkoyQW9KTUdNYzRwQjhwaVIzbnBT?=
 =?utf-8?B?dFZYQzNTN2h1YUZSQ24zS1NFOWcwQlBqSnRFc1dNRVZLRHdIdkt3UDFTa3dJ?=
 =?utf-8?B?TitkMmZ5SlQreTVManRPY3FkTzBaRmVLWkdEU0VjSENEWTdyUTBxWUhpV1hX?=
 =?utf-8?B?SG5JU0VIQU03bEFEeHg4bCtPcHdiOG83N0U4ZEZZQnBjMEZEVUVhWVpBazVX?=
 =?utf-8?B?YUgzeVoraGZRenBDWi9ib1VTT3F3TU42TmEraXlPRHNVMDg1Ujhyd01iQjd1?=
 =?utf-8?B?UUh3a25sN2JQd2ZFZ0ZabE9KUXVneTgvMnJ1YytMVmRpamJiSmRTTWZQcVZM?=
 =?utf-8?B?OHpFQjdXVEpDTE9BSzZ0c2tuWVlUazM1YkYwT1kvQzE5RmFEbUVMMzMwUHJU?=
 =?utf-8?B?bHdPK2FhS0VRY1hNdmE2NmVPUENpL2M2WmdDU2l2OXgrNXNnV1V6VXR0dEJC?=
 =?utf-8?B?UEVmWUJMcEZqQ1BtTjlWaHRPYnkvQktrTGMzRjlUWGlEa3hLT0t5NVJEcTd6?=
 =?utf-8?B?V2Rydm51aFA0YWIvMFpOT0VUYU9UUEtLR00yZHV3eW15eUEwamtjVUw2S055?=
 =?utf-8?B?c2hSVjJDa1hzOHhVQ0FDRTFMRHZGS2pSUEVJcmJpWmdGWExRdTl3Zm1hLzVY?=
 =?utf-8?B?bzFYRVVBTlhSMFFEWHBOUnpqeWl2bldONzJYbk1Neks5Z3JEeHNsOWFsMWhR?=
 =?utf-8?B?azcwN1pFcmVEMkFUQVhTUWM0emRLNFRuUERESGc3ZWgrbW5YVGlVSkc4dlc4?=
 =?utf-8?B?cHF5ekFzWnd0cU9Uc0k1RWhCclFTTk9oNXA3ZitUT0pPeW94UWh0QW1Kc2RN?=
 =?utf-8?Q?q05BMt0B4+ev7UqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF13B02B1897E4889364B9ABF1AE3AF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad66b26e-d8ec-41c7-2e41-08da289e90c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 22:37:52.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlZwRIE8jSeOreh5GI/b9fgKBFPAgg3hUhi5V0/DUYvCszNmkz1h7pFcp4QZyzxiu+2vr1kFR7SqPTXK/4uxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMTI6MTU6MTdQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToNCj4gT24gV2VkLCAyNyBBcHIgMjAyMiAxNDozMjoyMCArMDkwMCBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBsaW51eC5kZXY+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBOYW95
YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IFRoZSBmb2xs
b3dpbmcgVk1fQlVHX09OX0ZPTElPKCkgaXMgdHJpZ2dlcmVkIHdoZW4gbWVtb3J5IGVycm9yIGV2
ZW50DQo+ID4gaGFwcGVucyBvbiB0aGUgKHRocC9mb2xpbykgcGFnZXMgd2hpY2ggYXJlIGFib3V0
IHRvIGJlIGZyZWVkOg0KPiA+IA0KPiA+IC4uLg0KPiA+DQo+ID4gRml4ZXM6IDc0ZThlZTQ3MDhh
OCAoIm1tOiBUdXJuIGhlYWRfY29tcG91bmRfbWFwY291bnQoKSBpbnRvIGZvbGlvX2VudGlyZV9t
YXBjb3VudCgpIikNCj4gDQo+IEkgYWRkZWQgY2M6c3RhYmxlIHRvIHRoaXMsIE9LPw0KDQpZZXMs
IHRoYXQncyBmaW5lLiAgNzRlOGVlNDcwOGE4IGlzIG5ldywgYW5kIG9ubHkgdjUuMTcueiBpcyB0
aGUgdGFyZ2V0IHRyZWUuDQpUaGFuayB5b3UuDQoNCi0gTmFveWEgSG9yaWd1Y2hp
