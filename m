Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C25562B1C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiGAFyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiGAFyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:54:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B846B274
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNZeh4KLYc7aRKEcCvO7yuDMpcUVjUxbYrjKc0mjGbgJJw4BrpWskZsS5rrwb0sLU63Y6C+/DP94IEeGalUoIy2DbNEGyKFggGfDO0Slgrj1tcl3uoUQv62S+OdEeYKCqsgkRNlvEuSqSwCFD23MlIwcgI/d0SWZnAzG5bnYjTv3+s2rZw0AueL2DXW3y+dpbtXl4VYxiLz+8ROpQsN4wtmtrVOn2WGGJnyxmkSJ0dWzAtivA47/uWd2G2FpNntKxrYApwgmid9gdoH3p0/5rcSyz4K8geb1z7TSO+cnaDe+CUs/WmoINdZvo3o6QyOOPlWqyyClNhbflVweTAVmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evZ3Y2ChWaQor0baUEkIxyawa6Wmrp+4+iWtpiffs64=;
 b=kL4nyBVlVA3cd46eyBGrTpGrItFfCNGDyojwGR3YZOayT/yNc0XkHtOKMhjKZetOca0/YjsgYhexpjX4YxQXlYCn5jVO54pP0u38gla5M97RzXFYjAkDwbw1vb07aMvRZ89QO+JjSKKnA1CUrmgUNXVgV7p7UUczNA7G/cIlKtaZJP8lXTNv7k6GNQ1cd7uy3n7uFC5Wb9H+u3gX9Pk3rrKavuIsIsDYOfZIh6VfYe7r+m4hRzIQZrX03AFL/KN1xHntD26r1hnJ9XhUnFtbt2mQfFlyH+c60rRUqDHCxfaePpY31Qhpp2rs+dUIzV4ebrPRLdN/3ol+H/3kmSWkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evZ3Y2ChWaQor0baUEkIxyawa6Wmrp+4+iWtpiffs64=;
 b=SN2Ou3tAtWF/ncL3yMTk1CwvsE+u7sHLZiizPs9A3lHGVEzfzvxCZIADmNKdMJ+LdV/2shNEf2/CvujY7HyEq7r+rsy94pgBaA5aejSGiA6xCmpi78CfQtnA8G/nfWOyMH5yKLqEMtrOAN/SfHSBipLTfIZdAGrpQ4dyuYOyjvg=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DS0PR05MB9151.namprd05.prod.outlook.com (2603:10b6:8:c5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.11; Fri, 1 Jul 2022 05:54:41 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5395.012; Fri, 1 Jul 2022
 05:54:41 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     James Houghton <jthoughton@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Thread-Topic: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Thread-Index: AQHYimT61BRthM8NmkW237FWHUoNOq1j8HoAgARn9YCAALDjgA==
Date:   Fri, 1 Jul 2022 05:54:41 +0000
Message-ID: <B0C76FB1-E726-4A5D-8A62-43FCCA6E04C2@vmware.com>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <YrYCeYy0rjfGhT/W@casper.infradead.org>
 <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
 <YrnvORvPKbzgxLCu@work-vm>
 <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
 <0125BDEB-0848-41DF-A9D4-CDCAC2893972@vmware.com>
 <Yr33v+ag6Bv6wExa@xz-m1.local>
In-Reply-To: <Yr33v+ag6Bv6wExa@xz-m1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d835b607-621f-4158-0856-08da5b2630ec
x-ms-traffictypediagnostic: DS0PR05MB9151:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YqB+wysQGKaen1QBZwRxPfSl2JPabZt7UQGISqMb6qkZtLeP1mAoCo39SEtahfPNpDW7GW8aoRd01LYhmF/sPocdABwPEUZcG5VMl6Gk9SXPsuS2COL3rc8Xde3OQzYUUfQNWLbmgHdObUD8YQ4LVkKKT3s4uxUopLH4XtVm6IIFxUwTqPysh1nDgLU5f0S6iAEu0/eKrwe1Ko4Q5pg3hDfA2LgAKYqyHNRk+o+9HyeJrDIu+mJNejyg6IigQFPSYnVutYPfLosyPX+Q5D4waSpsygGNoLu4ND7WxqPCsKYJ9GwOWOq+cVhZoRZDFIShadIcwUYOByiPsS1xmIGZO91kf23oQlalSZPUbTpHpTvRpCkEuNT6tHXHSyU6GFq5Sec7CagPm+peMjtfLvoR3/MPX5OGa0iqZ/nVUuxskxPjKYPo4Jzgr11qL+zjj8YuZ/D3xPP6s26rRsVazlyPOF5z/m7FDLEKonUR/oZInO96IpWzM9oSi2HPQ61BeaAMrFC7+eW4xCreojr9JPQrLPwnIK4hQJlKAZCqVOc1C+LJ1YXr63qyFGtrFYIVper0Mlw+avhrG4DCVFfxLI5yX85uVtwIQZwhuXg+SnowJPj9XSzv45SOBeSJKetW40rik1ZrYL133CMU1UxUSb2ajVVlv1yo247lnj2rVzyH5EJvEje13dcjzyBkBuKcxxnRIembj+puCHYpPtsnKXKUBgQwo/929JWuiq3m4QbA8D4UarBi7ilXokWYrA53BA8MCUHb3p4+htH3DD1VH1DPOQ6vzurTxaiT1AaxJWf6pg4TADrdTgCYDiRy9EdDMuXN1Oo5HTdOOgGUwV1Bb1mMk7PMz89PLdgrQtQHNxzYkBr6QiBKHTk98o77S8Eis1q+LhaEqoweSGBcScULQ6K9VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(38100700002)(7416002)(316002)(5660300002)(53546011)(54906003)(6486002)(4744005)(76116006)(8676002)(4326008)(64756008)(38070700005)(66476007)(66556008)(26005)(66946007)(66446008)(6512007)(6506007)(2906002)(6916009)(8936002)(186003)(122000001)(478600001)(71200400001)(41300700001)(33656002)(2616005)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWwrSDRNTlRtemIzRkU3cXVtRk1ockFhQWtpM0NqYW1zZHV4bTM3dE5FOGxQ?=
 =?utf-8?B?Y3VtcDU3bVVwOGlQR3VOZTY0VXpETWNBQklLdHNveDFTZG1XeWtQSHlUMjc2?=
 =?utf-8?B?MFJRNXBvT3Y3UTVhZHNPcU5LZDd4SVcraFI0cWhMMDJZZWNDWGlMTHJ4VkE5?=
 =?utf-8?B?Um1RaERoaGtQM2lyTGFpNWZaeE8vZE5Mdk1yRUVpL3U4eDdSWGtPRnM1WUJj?=
 =?utf-8?B?SUNSUXpISFNIZXRXYUErZjlEZlpRdVZQQXl1VHJXN2xxUm94Q0phaEFyNWRm?=
 =?utf-8?B?UE8vU2tuUHBXTThVaXRoR2FpTVl1SUU1SXV4TDdCUTVncm9yQ3pOc1F1OW1Z?=
 =?utf-8?B?Sk9qN2FjZDliaDhtOERleC8yaVFiZVlidEpEblJ4czlkcCswRlhmUjRORE9R?=
 =?utf-8?B?U0J4cjhyUXB1K0tUYWNXZ1NwbmozNmpIR1psZTExNEFsVmloOHRSWmZKbkhZ?=
 =?utf-8?B?Zk41RHhRSGFKSTB6Sms1QWlmRHJ6cTdTSHZoejgzMkJuU3lMMEpCS0U2ZjRz?=
 =?utf-8?B?b0E4amRyOUFGMGtsKzVBS1VxSjJZdE01Y2FyUHE1VDV6UFNLektLREFNeUp6?=
 =?utf-8?B?RmJwYlFWMnB1aGtmSVRBbjUzelpwZkxITGJNZjNPVVFLblhrVWRRdlpnUWE5?=
 =?utf-8?B?ekI2VjJNQ1RRaGJiaklsbXFsU2F3cGUvTVE1eUpnSkFCa283M0MwQWVCOWpC?=
 =?utf-8?B?Q1lZL1ZDK3FBUmJtRXo1UUE3cUlzSVF1dUYyajAyUjhmWE1nSzRZUmFhTHEr?=
 =?utf-8?B?bUZaYk5wTEVHOE5xcnI2aVZLUllEZ3dpbk4yY2xJb1Y3QUo3SmRhdnBuQlFO?=
 =?utf-8?B?c3RDSUJMSFdOTFpvVUwrZXQvd2ZlamxUWndFUmtsQ0lrWGF0T2Vtem8xSldY?=
 =?utf-8?B?b1hJUjh0SGpoeEJDZ1pDTDBlSzVrVTBGeXZhRGdXanpXdzBVT3NwL2ZCZDAy?=
 =?utf-8?B?K0ZDR3NRWTdXVE8zMG56WWVOcmRzOU9Mc0lPcGNacktLNWtOWVlSWTJmNnd5?=
 =?utf-8?B?WFBOdWdoVjdUbGdoOWw2Slo4NUhib3ozUm5wTzh3L2Q0NkFkR2ZMTmEwUms3?=
 =?utf-8?B?Z2dHWi9UQlBnYkF0SmdRc3ViUnhpRGtmWUE1OUhPS24rSlg1U0VhdkhzWFdy?=
 =?utf-8?B?RFZNQUh2L0pZY3lRN0FyVHBXVk5pL0pla2l4N1NFd1FsMDBhSmQ5dDA4QzF3?=
 =?utf-8?B?cnJkQlNkc1RrY1QxNGtoYnlmT2ZMZUVFZjJvQXVuZWp6RlE0OEFmeUV0RjFJ?=
 =?utf-8?B?VnRLWE8rcWpGb1A4cVQweWkxcFFsVHZBMTZwUDhTWHhwV0xBL01WVmZIdmNS?=
 =?utf-8?B?OE04UmR0b1JMUXdrWWxIWEF5V1Z6eUY1ZUkxUFFaR042cXlqcU1hcjFDVG16?=
 =?utf-8?B?dGRDL0lveWpzcGpqMFQzSDYvOUFoNXRmK3lBTXg1ck1oWVpKcW9yaHB5K21Y?=
 =?utf-8?B?OTEya3czMEZkTGc0N1pxNU9KeEhaQUk0aXJSWDA4WE9oVmcrSllPaUlUU0sr?=
 =?utf-8?B?dTlBb2FYblRmcTNDNTk3ekdGMnA3Z2VJUE1GZVV6WGlkUmpnZERuYmRyVFFT?=
 =?utf-8?B?VFQ4K0Z5SnR3OFYyZy9SWEtzbE5YNjgzZ25XaU9iYmRlcEVxWmxYUEdOVi80?=
 =?utf-8?B?SS82NmlCOXBIWUtJMWd0ZXgvQXZYMXJ4eWJXRC9kYUd0Ykp3NWNWcVZBUml5?=
 =?utf-8?B?NGlkTEh0eTU4WEM4dnJaMU5JNEpyYVRXcVNWSUxFdG5nT254MjQyUVZ5NzlD?=
 =?utf-8?B?WEI3YzZZd2VZMnJVbytmUjBvQzFNc0FZNTdVYWZybGJkL3EwKzZOeXdGc0dH?=
 =?utf-8?B?NFdwbVBQbk9laDZIQ1dOUHRhV0xhREpLUk83N3FrZUJBWUhhQlJTODltbmZD?=
 =?utf-8?B?cmttQmZqajdnYklhaGlZMERTMDRLUWFVMTQwUGNXK1d2K1Jlbmk1bzlHOCt1?=
 =?utf-8?B?TWVxc2NEVEM5Wm8vbmo3SkUrdVVYSnZlVWVvNGdUY2NpWGhJUkhxNGkzRTRr?=
 =?utf-8?B?R0FJYTBtQW81cmVGNDA4dHJuMEpSNWtWMU9IOUR4YTZ0dzIrOXBjVUR3SGx6?=
 =?utf-8?B?QnpteFNyQnhKcnNyV2swLzlFbnh3dXRYSW1LNW1WWlhHUHdEQ2tEOHg4dm11?=
 =?utf-8?Q?M/VojKspOtDeAi2QCni7Wj9jV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7259DA77C829846A89CE63D636BBDF6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d835b607-621f-4158-0856-08da5b2630ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 05:54:41.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bR3fL/jGTyKLJD3I3J6wSV5FhDHQ9/F5fnm5/qLDgOR7xrI0QwDs8HZzFq5LeIozTnW+JTqmMiu+6XJbZ505Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9151
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVuIDMwLCAyMDIyLCBhdCAxMjoyMSBQTSwgUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29t
PiB3cm90ZToNCg0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIFR1ZSwgSnVuIDI4LCAy
MDIyIGF0IDEyOjA0OjI4QU0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gWzFdIGNvbW1p
dCA4MjRkZGM2MDFhZGMgKCJ1c2VyZmF1bHRmZDogcHJvdmlkZSB1bm1hc2tlZCBhZGRyZXNzIG9u
IHBhZ2UtZmF1bHQiKQ0KPj4gDQo+PiBJbmRlZWQgdGhpcyBjaGFuZ2Ugb2YgYmVoYXZpb3IgKG5v
dCBhbGlnbmluZyB0byBodWdlLXBhZ2VzIHdoZW4gZmxhZ3MgaXMNCj4+IG5vdCBzZXQpIHdhcyB1
bmludGVudGlvbmFsLiBJZiB5b3Ugd2FudCB0byBmaXggaXQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBz
bw0KPj4gaXQgd291bGQgYmUgYmFja3BvcnRlZCwgdGhhdCBtYXkgYmUgYSBnb29kIGlkZWEuDQo+
IA0KPiBUaGUgZml4IHNlZW1zIHRvIGJlIHN0cmFpZ2h0Zm9yd2FyZCwgdGhvdWdoLiAgTmFkYXYs
IHdhbm5hIHBvc3QgYSBwYXRjaA0KPiB5b3Vyc2VsZj8NCg0KWWVzLCBldmVuIEkgY2FuIGRvIGl0
IDopDQoNCkp1c3QgYnVzeSByaWdodCBub3csIHNvIEnigJlsbCB0cnkgdG8gZG8gaXQgb3ZlciB0
aGUgd2Vla2VuZC4=
