Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0674DD36A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiCRDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiCRDEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:04:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C3108C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APT6Wdn919/pRFlg0ZrFM3NvGsgvp1SpXz8cQ947cX0hNpTr4D+acDRkORFwL2PPu57Ecb3JpsT38oKMlh7bO/R/EdWjS2uT5/7Gp8/w608YVHhdeLIMmuabHNpu+tOVOsREL/u3UzZG3VScRrHlI6b+D1gADUFVybeKI+8/yiQ6+YIjJxw6sdhz4r6MReg/gOpY7BbHVDkka6NJV05YZ930XHkrZ2WBWfAW4Tnw565qoudg3KmtjlgOwLdLVh90gNz/NOo6rk0aog9eyPGYba9GY1smBUkCl2zAUD2is1yu9o2qTA5Ks/+nEh00RgRIg1Yt4TQccvFpuOnJhO+8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFHg9LPWjnAa35DW9F097MrDQIKOv/vw4qrxr9RW4GY=;
 b=HuJ4eA53C+D3D79MXtIjsNGr5rdUJ85iL/mDGIYJ/u9yL36uIjcXaQ3X+9risO0a9ORSzhYiSclethF5gSxS4o0AjK1D0/IgQmsRFeQXr2oK6uYnN1QKF5bUqahLr/BSrEKPyOQwEZ4d0tPr8veKqjizwG/ZRbrDVnePIRJFoPea6sQntgInvYtXm6+mmSqRUeRH6/Ow1NCME4LtjSqbnf9OnO7Afag0q9AODJAtE9O8YJ+JZnIR11/ahQh7S5u+2uuiOAQYEF8fHCGaDDO0vaj147Cfz/LoXrouhJaqs6QXZG1xKpl0ObRim+G0/yrfpAHASAM/iiS+mNfx1nrLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFHg9LPWjnAa35DW9F097MrDQIKOv/vw4qrxr9RW4GY=;
 b=K65T0NhGAP6RnTDgyP0FL+xsw9gJdb6FobWU2ZH9ic8LTIQtMkH4vtXwwJfHuWGBIRm47m5NMiHk6EHBPbqJJGaFmEO5bbfdJJwHTIeIUoIYiWBbFWy4QJKPGWsUsG6hwZkipjxYkV9xPAj9gJ5/a1eiqEppUKJK6ilocvrtcwY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL0PR05MB5059.namprd05.prod.outlook.com (2603:10b6:208:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Fri, 18 Mar
 2022 03:02:49 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b%7]) with mapi id 15.20.5102.007; Fri, 18 Mar 2022
 03:02:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
Thread-Topic: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
Thread-Index: AQHYOi5EArGolB6T3UOsBVoO+LEc5qzD7r8AgAACZwCAABbBAIAAPoMAgAABDQCAAAcogIAAJlAA
Date:   Fri, 18 Mar 2022 03:02:49 +0000
Message-ID: <DB87059A-66EC-43A6-82C5-2D890F7A02AF@vmware.com>
References: <20220317090415.GE735@xsang-OptiPlex-9020>
 <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
 <3B958B13-75F0-4B81-B8CF-99CD140436EB@vmware.com>
 <96f9b880-876f-bf4d-8eb0-9ae8bbc8df6d@intel.com>
 <DC37F01B-A80F-4839-B4FB-C21F64943E64@vmware.com>
 <dd8be93c-ded6-b962-50d4-96b1c3afb2b7@intel.com>
 <A185DAD5-3AA7-445B-B57D-AFAF6B55D144@vmware.com>
 <d4f62008-faa7-2931-5690-f29f9544b81b@intel.com>
In-Reply-To: <d4f62008-faa7-2931-5690-f29f9544b81b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dde576cf-02dd-4e83-ca17-08da088bc947
x-ms-traffictypediagnostic: BL0PR05MB5059:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BL0PR05MB5059E8D17D44F8FF355E4E64D0139@BL0PR05MB5059.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDR+aFiBDiZwv7MRLbx8xm9YRWZgr2ITBCxnZz9Z/NfUcHZyey964+VXkkERj8vHgf/omY6KboRjBWesCae8rK03wbqvtoZXE/SLpgydbeLcMFRoCudZbt6W2yvtbilZ4uO20i/+BXFzMAc0j1GJA3XTs0U7rbvRAKseq80CTNxmDPHO+J5UVTiWwNz5mHm+sD8KozCwsUc20XFmw96PtTnm1x2+ci8bZY4G/mJ/AJfpCT5VmDsdchDDHXG2VkWrBFFWX3sIocZ3AUn0qiMK2Mc5VQUlimqYQ1oR1uuaaMtrT5UfnlnkAQVPeV2OArRo3uclFkDAXn0iClgocsZOQAtrRfLnUqRIuRopBrRk/62eIfrRV2z8v2MPNRCINpXLwdmBDBdXD8aYY+2W6KBmYRd5KlN9sC+3keln3fTrX53v9M4cpKszVhZiXG3J9Aa3PedOUgVt1jC5+gVFbWE3Zx8nuSy34iQU9unCoFfwmHyaEJIvNBCXQ9gnMyOEdt3p7W9XbMwEufOKf12Wotjen7inqCH7BjoW0xI9Mt/K7VHOxYHIFTxOWrDQI7gj6cwoa1GZ+81JmvJD4PZZy7/rT8RdxEHyv5KKrm9aoaHNP8sK13jKTdsflOCAeWkhh8uq6iSi+0uxhwMkqahELKBD6Z6dW9Qm/BCegHGoVDHnYovOklSYBwEA2tGHfNZIkv9qaGsWOLBfnDZ9HMFwpXzAlXW8l0Z3w4H0pYTnEKzgHNWSM+BYus4YFu5dULiz3k1yhNN48nZIo1zhWyR0LAAmW6fum+AmCtj41QichzyBVfA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(33656002)(66446008)(66476007)(66946007)(5660300002)(76116006)(54906003)(66556008)(122000001)(38070700005)(6916009)(316002)(6506007)(6512007)(7416002)(8936002)(508600001)(38100700002)(2906002)(64756008)(71200400001)(36756003)(2616005)(6486002)(83380400001)(8676002)(86362001)(26005)(186003)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmFpclZaVmoyTzQ4Vlo1c2VPcFFNekxvS3pLcmMvc1JoaXVNM205aWJsTElq?=
 =?utf-8?B?TVlUTFBTbEhKbmM5K2R5L01vaFRZa1ZNU2swK0w1bGZsQWEvRmN3bU9QdGdT?=
 =?utf-8?B?SmtTR1MvSnJkSnBKSnFLc09xTmU3VHhRRkdnTHgxZEpuMkMrNG5lUXRmU2t1?=
 =?utf-8?B?ZWxrVVpaNEZDNTVmRGFKaEhjbUFwd0FWZXEwNXczQ052aGlKVTU3TDRoM3dX?=
 =?utf-8?B?S3dBTHhlZzdnRko3U3RNcmh5UmdMWVo3OW54TkJnZllzUnpCZWQzWDlqNFFP?=
 =?utf-8?B?NHFaRFNvMWZnSlZ4ZnJSaU92T0I3S2JBRlo5bXNXNlFXQWFVY1ZDa2hoR29O?=
 =?utf-8?B?T3pOS1dpdEJMOW9RekR6aE5LeFdJN0Izd0ZmQkU5SEtaYys3TUZQMFVSVFgv?=
 =?utf-8?B?Vng3bGxya2FFaFFrRTZWMjloUGpid0J2SXAyMGZOaU5oeVVMQVJzeWRuaXBO?=
 =?utf-8?B?NVBubVd3ZkJUNWtib1J6ZW4xZ2pOTTlyLzBnMWhkSDM5U3hycUVOdENYbWZR?=
 =?utf-8?B?TENWZDk4bk13SkozcDRiQmUxcEFac28rc0FJOStBMm9ObXdWdllZZzJpUElh?=
 =?utf-8?B?aXhoYkNjZUFPeExxN29Qc3BaWHJUYURxQ3R2ZHNGQ2Q4YnFzUk9OWWEyd2t2?=
 =?utf-8?B?cklseDVOUzlvSGhZa3hTcjRzUmxlbUtvckl0U054TVVTdFRSUHZ3ZUxMWGZI?=
 =?utf-8?B?SzBsMGlNQ1pyeElkc2NGWXZyOWpxaEgxNGxnaU1obDFwUVFoMTBNZTBxVmxQ?=
 =?utf-8?B?djc0ZnVZb2hTQlVmVVNObnliUFlQV1h5eVZSNXYyRUE5cnp0TmRPczlGZ0o3?=
 =?utf-8?B?dzB4UTh3OUdZcFlmSnVkaEFuV1VXd0thTXF1OFRoYWs3WnUxWHcveERKSWNs?=
 =?utf-8?B?dG9hN2p6STRlaklBajVjRzRjK0RoUzMxcTI2SUYwdzhwdkxPYk43YTl2RTRI?=
 =?utf-8?B?SHJzaTEwZW5FWU5iNlQ0OHpuUWVKM1NlTitSOHZBY0N6amNXUmFwQTFRTzdE?=
 =?utf-8?B?Z1dlRWtRLyt3aVlrVUpzMGo2a3hxZHhic0x3cGRJU3lkbk1LWVp2Y2g5dTRs?=
 =?utf-8?B?Q0Qrc2dycmNWNXFUU2F4dEx0eVFMTVZIdGlETU5mR1RtRWVXQjJuNlM1d1lh?=
 =?utf-8?B?RERHQU1QZVppVVpaMjkydnh0c2I5NWVkVXM1U1Z4NWVlbXVxZ2dGNGZZMHQz?=
 =?utf-8?B?NVZQbEFOUHVQMjBuZklQVUhPWlpRaGJqY1FqMUttc0dZSEZFZHpReTVBOUNa?=
 =?utf-8?B?Rnh4RDJPOHZPMkRRdjl4cDlnOU5xcE9ZNFVzdkFKQzBncE5ZT3lyZ0tNbVJZ?=
 =?utf-8?B?dTF2a0VQK2ZLMFhqR2pWb3FkRlNEUGxJVld2dE9GbFk4cnQyeEtxbjkwRkFD?=
 =?utf-8?B?L1lGblE2VmhpcUl1ZkFYajBuRGpLQ2xtYU1GU3lUbEZ3V09BRGsva3B1UG5y?=
 =?utf-8?B?KzluTmtvalc5UGEzd3FhdXI0QlJtZnpBK21CdEZxd0JjTjJZSlcxUG5YeWsy?=
 =?utf-8?B?RjV1V0UvWU91R2tLZVVmdmo0RENXNkIzL215cG9YWWZ2SkE1bVdrV1F5WkJv?=
 =?utf-8?B?ODY4ZlJMR2xRbklyUlJhbC9wYm5IWkJQcDgzaFptTHh0S3puYXhKUjlOTFBB?=
 =?utf-8?B?Z1E2NHZYNTNGdDlUaDN5TU04U3ZZRlJSY0Y2Z1Bnb24vUlJqaURKSkRxSW5P?=
 =?utf-8?B?di9SQTF2NmNxSXVLbXdpc2sxNHhqcEk1UTZZZktmNEJTMzlWQ3hRNWZzZUZ1?=
 =?utf-8?B?NEFYblEzbkh4cFRVdVROSjBmbi96Z1l4SW0xMDUvVEZETXpMbmozSGt1Rmxk?=
 =?utf-8?B?TnlIYTNxdjN2UDdOR3pzWTFCK2I0QXpVcC9DZkVpaG9VZWx6azcyL2tpa29v?=
 =?utf-8?B?OHF2bFA3aFRjSnl2RmUrRjhMQXhpMkNuOFhsT1k4QmpIVE5hRHluRGIvS3A0?=
 =?utf-8?Q?+qMCw8YOUtiwi7I1E6i4wzFMJ4MnBjMZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20EB2D24B824E148BD97D8C69322AFCB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde576cf-02dd-4e83-ca17-08da088bc947
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 03:02:49.5966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waVV2qzDwr2mes8pf9slk/5ZOafbrdLYLes5ezi1M1zBhn+3Estl5n2Cd5QbE6dl+AHh/oOqi3GQnUjsps9qDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5059
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDE3LCAyMDIyLCBhdCA1OjQ1IFBNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDMvMTcvMjIgMTc6MjAsIE5hZGF2IEFtaXQg
d3JvdGU6DQo+PiBJIGRvbuKAmXQgaGF2ZSBvdGhlciBkYXRhIHJpZ2h0IG5vdy4gTGV0IG1lIHJ1
biBzb21lIG1lYXN1cmVtZW50cyBsYXRlcg0KPj4gdG9uaWdodC4gSSB1bmRlcnN0YW5kIHlvdXIg
ZXhwbGFuYXRpb24sIGJ1dCBJIHN0aWxsIGRvIG5vdCBzZWUgaG93DQo+PiBtdWNoIOKAnGxhdGVy
4oCdIGNhbiB0aGUgbGF6eSBjaGVjayBiZSB0aGF0IGl0IHJlYWxseSBtYXR0ZXJzLiBKdXN0DQo+
PiBzdHJhbmdlLg0KPiANCj4gVGhlc2Ugd2lsbC1pdC1zY2FsZSB0ZXN0cyBhcmUgcmVhbGx5IGJy
dXRhbC4gIFRoZXkncmUgdXN1YWxseSBzaXR0aW5nIGluDQo+IHJlYWxseSB0aWdodCBrZXJuZWwg
ZW50cnkvZXhpdCBsb29wcy4gIEV2ZXJ5dGhpbmcgaXMgcG91bmRpbmcgb24ga2VybmVsDQo+IGxv
Y2tzIGFuZCBib3VuY2luZyBjYWNoZWxpbmVzIGFyb3VuZCBsaWtlIGNyYXp5LiAgSXQgbWlnaHQg
b25seSBiZSBhIGZldw0KPiB0aG91c2FuZCBjeWNsZXMgYmV0d2VlbiB0d28gc3VjY2Vzc2l2ZSBr
ZXJuZWwgZW50cmllcy4NCj4gDQo+IFRoaW5ncyBsaWtlIHRoZSBjYWxsX3NpbmdsZV9xdWV1ZSBj
YWNoZWxpbmUgaGF2ZSB0byBiZSBkcmFnZ2VkIGZyb20NCj4gb3RoZXIgQ1BVcyAqYW5kKiB0aGVy
ZSBhcmUgbG9ja3MgdGhhdCB5b3UgY2FuIHNwaW4gb24uICBXaGlsZSBhIHRocmVhZA0KPiBpcyBk
b2luZyBhbGwgdGhpcyBzcGlubmluZywgaXQgaXMgZm9yY2luZyBtb3JlIGFuZCBtb3JlIHRocmVh
ZHMgaW50byB0aGUNCj4gbGF6eSBUTEIgc3RhdGUuICBUaGUgbG9uZ2VyIHlvdSBzcGluLCB0aGUg
bW9yZSB0aHJlYWRzIGhhdmUgZW50ZXJlZCB0aGUNCj4ga2VybmVsLCBjb250ZW5kZWQgb24gdGhl
IG1tYXBfbG9jayBhbmQgZ29uZSBpZGxlLg0KPiANCj4gSXMgaXQgcmVhbGx5IHN1cnByaXNpbmcg
dGhhdCBhIGxvb3AgdGhhdCBjYW4gdGFrZSBodW5kcmVkcyBvZiBsb2NrcyBjYW4NCj4gdGFrZSBh
IGxvbmcgdGltZT8NCj4gDQo+ICAgICAgICAgICAgICAgIGZvcl9lYWNoX2NwdShjcHUsIGNmZC0+
Y3B1bWFzaykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgIGNzZF9sb2NrKGNzZCk7DQo+IAkJ
CS4uLg0KPiAJCX0NCg0KVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gSXQgdG9vayBtZSBz
b21lIHRpbWUgdG8gcmVoYXNoLiBZZXMsIG15IHBhdGNoDQpzaG91bGQgZ2V0IHJldmVydGVkLg0K
DQpTbyBJIHRoaW5rIEkgbm93IGdldCB3aGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dDogdGhpcyBs
b29wIGNhbiB0YWtlIGEgbG90DQpvZiB0aW1lLCB3aGljaCBiZWZvcmVoYW5kIEkgZGlkIG5vdCBz
ZWUuIEJ1dCBJIGFtIG5vdCBzdXJlIGl0IGlzIGV4YWN0bHkgYXMNCnlvdSBkZXNjcmliZSAodW5s
ZXNzIEkgYW0gbWlzc2luZyBzb21ldGhpbmcpLiBTbyBJIGd1ZXNzIHlvdSBhcmUgcmlnaHQsIGJ1
dCBJDQphbSBzaGFyaW5nIG15IHVuZGVyc3RhbmRpbmcuDQoNClNvIGxldOKAmXMgZ28gb3ZlciB3
aGF0IG92ZXJoZWFkcyBhcmUgaW5kdWNlZCAob3Igbm90KSBpbiB0aGUgbG9vcDoNCg0KKDEpIENv
bnRlbmRlZCBjc2RfbG9jaygpOiBjc2RfbG9jaygpIGlzIG5vdCBhIGNyb3NzLWNvcmUgbG9jay4g
SW4gdGhpcw0Kd29ya2xvYWQsIHdoaWNoIGRvZXMgbm90IHVzZSBhc3luY2hyb25vdXMgSVBJcywg
aXQgaXMgbm90IGNvbnRlbmRlZC4NCg0KKDIpIENhY2hlLW1pc3NlcyBvbiBjc2RfbG9jaygpLiBJ
IGFtIG5vdCBzdXJlIHRoaXMgcmVhbGx5IGluZHVjZXMgb3ZlcmhlYWRzIG9yDQphdCBsZWFzdCBo
YXMgdG8gaW5kdWNlIG92ZXJoZWFkLg0KDQpPbiBvbmUgaGFuZCwgYWx0aG91Z2ggdHdvIENTRHMg
Y2FuIHJlc2lkZSBpbiB0aGUgc2FtZSBjYWNoZWxpbmUsIHdlIHJ1bg0KY3NkX2xvY2tfd2FpdCgp
IGV2ZW50dWFsbHkgdG8gY2hlY2sgb3VyIHNtcC1jYWxsIHdhcyBzZXJ2ZWQuIFNvIHRoZSBjYWNo
ZWxpbmUNCm9mIHRoZSBDU0Qgc2hvdWxkIGV2ZW50dWFsbHkgYmUgcHJlc2VudCBpbiB0aGUgSVBJ
LWluaXRpYXRvcidzIGNhY2hlDQoocmVhZHkgZm9yIHRoZSBuZXh0IGludm9jYXRpb24pLiBPbiB0
aGUgb3RoZXIgaGFuZCwgYXMgdGhlcmUgaXMgbm8gd3JpdGUNCmFjY2VzcyBieSBjc2RfbG9ja193
YWl0KCksIHRoZW4gZHVlIHRvIE1FU0ksIHRoZSBDU0QgY2FjaGUtbGluZSBtaWdodCBzdGlsbA0K
YmUgc2hhcmVkLCBhbmQgd291bGQgcmVxdWlyZSBpbnZhbGlkYXRpb24gb24gdGhlIG5leHQgY3Nk
X2xvY2soKSBpbnZvY2F0aW9uLg0KDQpJIHdvdWxkIHByZXN1bWUgdGhhdCBhcyB0aGVyZSBhcmUg
bm8gZGF0YSBkZXBlbmRlbmNpZXMgdGhlIENQVSBjYW4gY29udGludWUNCnNwZWN1bGF0aXZlbHkg
Y29udGludWUgZXhlY3V0aW9uIHBhc3QgY3NkX2xvY2soKSBldmVuIGlmIHRoZXJlIGlzIGENCmNh
Y2hlLW1pc3MuIFNvIEkgZG9u4oCZdCBzZWUgaXQgcmVhbGx5IGluZHVpbmcgYW4gb3ZlcmhlYWQu
DQoNCigzKSBDYWNoZS1saW5lIG1pc3NlcyBvbiBsbGlzdF9hZGQoKS4gVGhpcyBtYWtlcyBwZXJm
ZWN0IHNlbnNlLCBhbmQgSSBkb27igJl0DQpzZWUgYSBlYXN5IHdheSBhcm91bmQsIGVzcGVjaWFs
bHkgdGhhdCBhcHBhcmVudGx5IG9uIHg4NiBGQUEgYW5kIENBUw0KbGF0ZW5jeSBpcyBzaW1pbGFy
Lg0KDQooNCkgY3B1X3RsYnN0YXRlX3NoYXJlZC5pc19sYXp5IC0gd2VsbCwgdGhpcyBpcyBvbmx5
IGFkZGVkIG9uY2UgeW91IHJldmVydCB0aGUNCnBhdGNoLg0KDQpPbmUgdGhpbmcgdG8gbm90ZSwg
YWx0aG91Z2ggSSBhbSBub3Qgc3VyZSBpdCBpcyByZWFsbHkgcmVsZXZhbnQgaGVyZQ0KKGJlY2F1
c2UgeW91ciBleHBsYW5hdGlvbiBvbiBjb3JlIHN0dWNrIG9uIG1tYXBfbG9jayBtYWtlcyBzZW5z
ZSksIGlzIHRoYXQNCnRoZXJlIGFyZSB0d28gcG9zc2libGUgcmVhc29ucyBmb3IgZmV3ZXIgSVBJ
czoNCg0KKGEpIFNraXBwaW5nIHNob290ZG93bnMgKGkuZS4sIHlvdSBmaW5kIHJlbW90ZSBDUFVz
IHRvIGJlIGxhenkpOyBhbmQNCihiKSBTYXZlIElQSXMgKGkuZS4gbGxpc3RfYWRkKCkgZmluZHMg
dGhhdCBhbm90aGVyIElQSSBpcyBhbHJlYWR5IHBlbmRpbmcpLg0KDQpJIGhhdmUgc29tZSB2YWd1
ZSBpZGVhcyBob3cgdG8gc2hvcnRlbiB0aGUgbG9vcCBpbg0Kc21wX2NhbGxfZnVuY3Rpb25fbWFu
eV9jb25kKCksIGJ1dCBJIGd1ZXNzIGZvciBub3cgcmV2ZXJ0IGlzIHRoZSB3YXkgdG8NCmdvLg0K
DQpUaGFua3MgZm9yIHlvdSBwYXRpZW5jZS4gWWVzLCByZXZlcnQu
