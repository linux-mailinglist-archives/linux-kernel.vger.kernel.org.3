Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE8598C13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345172AbiHRSyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243002AbiHRSyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:54:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B40543D0;
        Thu, 18 Aug 2022 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660848839; x=1692384839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OeUDz9edzBcL7fKWe9M7sJBhEEnmtUowNh9E3Gvi8Ok=;
  b=mW3heZkLiBw11bKs4IgM3P+Ro1j2uE8AAKZ6NCL20CP0riUK9j1jBraX
   Av265Nvco6lN6qPr8D7wyfwTJdivQ6raHgGC3EIgXpuEclAbQjwOxyOty
   EZsJ1W31oFof9B4hMVIFNuFmsGjQ5skEsJ94a/3g4Qcfv0uNBEBFqPmkm
   Zs3aZ/rGbUvfbcQplElHUyBQReNQvG2njq5X43wJU4ZSFMMCHPTRqERGs
   Yq9zSRFD/FymPb6K2dmosYZ5JSjvT1QZdjBJsyLU+JQdi2/69gXv7Pv6U
   icDpsQz27rdI8lpWiYwwASQrFp1TbrSmSY3y7PfZmi7w7z11n4QN9VlMe
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="187085436"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2022 11:53:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 18 Aug 2022 11:53:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 18 Aug 2022 11:53:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti7+FUWNHPe4OpNcHNUuh8+MXpOFiqoqD5TLV707oz5or9HlK8eTRCbo4nK5P6VrIaYJZSE6LC6IIrrnPczixCRgrUA6QaZn7WG7o3xaniJopa/jaI+XLzXlI/Fraasw8izSW7qzCEuEyInwcF5j3I5d5TMXd/X3gSGt6U7M2FqvDAsbWddwelbBlFqHTn/0f/heF1ILj8IPIHth5Ozm42XM/LHSHNmhrXQXYY+1E1CxPe8qf6Lnqjjs+JpnA9GR0efP+1UBUNufBmOlgmemuOhsV4m1DTdT8m3JZlZXvYiHT9MA3h3iwhXulFDBfcv2o8Vj00AgleiUtiNnZ994TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeUDz9edzBcL7fKWe9M7sJBhEEnmtUowNh9E3Gvi8Ok=;
 b=c1DbrXPWD4u8tNKbv9+7n5tj/dTT4ziUcdTSsFey0CXeqoEa3Lf6mL03NG5PutLTTbJ1CnxnTit//iPHOe4fuuzd7Yd3W7jIzy+7n5Yi0S27DgwQF4ckdstlg8SIRdqUyzQZgZMZMV5s3MwsZqAo+a/cBIrT/RaHQqGeB7/b2ilpeneaQ0hDAk7+NWvljUgatrzrBAT2zrgmERzCSTB83BwPGpWWxLW7EVZ9Xai6gEz3++iiXC2aSsRF4jsHvHgU1U6euSx/mg1ei16v2Fg9+2496+EC0ooCNN7bjGJot6NeM8kNn4rs+Tan0tM1bKF/uBy5ROq3DL7eFe6WCaCHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeUDz9edzBcL7fKWe9M7sJBhEEnmtUowNh9E3Gvi8Ok=;
 b=EIGALEI0c5o950kXuVxIk7W4FhTzBV3PdtGKDDaLnE/2wqk0m54QIBBtB6Xj4DZtk8X7bVtXU8SVYrkD9pgOg1pQFwDh+HeezU+NJ121FRUSxw77bJHTNuOmMyuo20kZmLfDSZlc+MFNdMII7dClJxj0BvFJyGnoAxwdKFWtaRM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3366.namprd11.prod.outlook.com (2603:10b6:a03:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 18:53:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 18:53:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <geert@linux-m68k.org>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <samuel@sholland.org>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Topic: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Index: AQHYsLoPyzdSi5rmak2RSuYw1tRBkK20yXuAgAAzIACAAAmoAA==
Date:   Thu, 18 Aug 2022 18:53:53 +0000
Message-ID: <eeadea8e-a6bc-0965-1246-82b0042838e4@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW29Q40hypWZ05KRj5cc=DY8XjnDwOPVw3kJPNUrnL0fA@mail.gmail.com>
 <CA+V-a8sVpEx==R6QXF8qxhVSsv2mVnZ_R3N2wTt+JPcQWNqCWQ@mail.gmail.com>
In-Reply-To: <CA+V-a8sVpEx==R6QXF8qxhVSsv2mVnZ_R3N2wTt+JPcQWNqCWQ@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff6b589c-a45b-438e-a11e-08da814afeeb
x-ms-traffictypediagnostic: BYAPR11MB3366:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38Y1fhaLreptEVHdnVjjwLiti2Y/7jApmIYo1F6dQ3t2DHYwG5Mafuvw2InK1s+a2rPjxbANcI2bBbIy0ITRCWpgbOCF7V48P5w2WLnswEXptzHpyonPnqyAwbCsN7klq/J/PO8cnzxf9gW0C1BIe2OHSkaKdgEZN282AaypPcp+w7/KI7heJsdxEfL9Hj9a/Eve0u4rPx7Qw2dIO9kuQBX7Egwd80UJOENa0LyQ6ln3o6AOe+vtbWooeUK9J7Nb5pGAy063yTS0RRv0yyuW0Qw6joo2T6t3CxRLE3IT0isSOV/Ey3IGDf4zUjBTLy6GMpmQ78a/OqztD5ZjcAd+iVeZ5YkzRknSKnG53H+cWXZawjKmCuXMA+A52yeunJTTlEmZoyDpBqrEk+kbiq9ldXKGVG0984fzX9vEboM6yb3/6fO7WWzExsRSbP9fTTIPZrv2dDWoRmZFnxFsgTAvAL24To6UvA02JLHHorO8MHEYhN4K9cYnsICoLBppUJYH+JPGc6sOu+EXemLRQfrowvJSpMtpH6a11QO/SZIYo+g+iNksaKEDjXFYJ+lAGffcKY0YkVGS/m+fIGGYgL/B1IHtpZGoYs0vIY2O3VrWLYtsseDzcufr5WWt8OA130na0GQlScE4Y09HKUNk54jPKmBU8X/IDd/wKoNCPr+N1KQOIE32H7nJM62PASpjhPaZeMlT1vLPniMxfgsnbRJoJGS3cUGlnnDaEI3KbY5ItCe5xfMEjMB/lXJ1EwxEk+8AI7w+nbzcib5HjJaf1Q9O90a01KXuNu0iw8Cmy2iU8lGptumwA47xfNkZgTn0s63i2dR/F0/Dn6SHY9FBPnkIEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(39860400002)(396003)(36756003)(38100700002)(31696002)(2906002)(86362001)(316002)(122000001)(71200400001)(110136005)(31686004)(54906003)(26005)(4326008)(186003)(66946007)(5660300002)(8676002)(6486002)(53546011)(6506007)(76116006)(66556008)(2616005)(66476007)(66446008)(64756008)(83380400001)(38070700005)(478600001)(6512007)(8936002)(41300700001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFhOcFVIQTZUanRyVy9Ga0JwTkRidmhUZy8zU3dINXFHbFR2SHJNMUdQRGlJ?=
 =?utf-8?B?ZUxnTFJJRVVQZ1NEeHJ0MmVaSmxmRDhmb24wQXBKWlBwVDN3UWhyMCs0ZEZs?=
 =?utf-8?B?NmVHSHJvc05tR2dkcUxZUk9XY003Wkk4NjFsZHFtTDc1d3BFeDJxRDN2Z0Jj?=
 =?utf-8?B?aHFvY1JFeFNKOFJnVGlEcFoxZ2JnMnZNcXcxRkliRk1vU2NkZlZWWjVLU1dt?=
 =?utf-8?B?VVRFYWdNempxQUNZUnZadEpUdWtWdER1SEJtSHJsOFYxUTZES3cyaTBtVXBL?=
 =?utf-8?B?UUJoUlJWVnN3N3VUVTFPVnlOYitveWZhTEFCaXY3aG5SK2hPR0h6dkFrVFhI?=
 =?utf-8?B?VjZIaEFJQTVORTVublM5azBqVXZLOHFhZmh5a3NQZTUrZVdlaGovRFFyUjBq?=
 =?utf-8?B?UHBvNEQrbytDZzhmbE5icXJ3Mlh3ZXdxekJsU1ZNRFlWbDBTMEZTTGw4b1NM?=
 =?utf-8?B?QzJvUmloa3Q1RUtXMk9qVjVkNWlSSG5sMjlodnUyaDB3bDFiNG02U2tUTmdC?=
 =?utf-8?B?SklxcFhrRFUyUzFUUklnaGVFUjhlamxHM3JOOS9DM2RlY0VCS2liRWpheVJ5?=
 =?utf-8?B?bGVuTWVHNkc5VXdtYnl4cExWa0I5UmtKVWp2bjNyb2hYeEx6bUpQbDEvT2N5?=
 =?utf-8?B?ajBZVklITzNDZTZVN0t6dEd6M1E1R0FjNTRwNGxKWmNuYURWaCtkTU9hQnZm?=
 =?utf-8?B?SnBEcnpEVC8rS3o1ZHNiQ08zVEZ4ZkxiR1MxSzhtWDRTWmhOMXYrUzBuUGFH?=
 =?utf-8?B?cGdDLzZuQmFUZitFcWJQV2JSZFVrNmRiY3BLVTJTR2tSSHdHNndVNjJLZFFw?=
 =?utf-8?B?Sys4VzlpNmZQZUpld0VmTzZYMEJXYzA5MW1KMXBPb0oyczkzTTNCbTlGODRJ?=
 =?utf-8?B?T0FnTUdHeHE2R05zNEVNdm9adDVLbm0xaXFDK0psSWJPd0lHS0krTDhCZGUx?=
 =?utf-8?B?RXY5SWdGSTJ2Y2xnSUpCTVpRY2pLMk01OGlkY1o2bEJoWkNJamFGbEYzNWFl?=
 =?utf-8?B?T1B2RE1YUndFS1dkdGRjSVRWYytXQUhjQnMwMW9OcVNqcWIydXFwZ2Q4QTlD?=
 =?utf-8?B?dVZWVHhZSk5hTEptZk5adXplc1RhQUQ0ckdma3ArWmpMQTNIL3hrOTBlWnhI?=
 =?utf-8?B?RWxXYVZvQlY0OHlMZEJPTVBueTM5RWVuS1hxcitDaXc5U3NmSlY5Zmlucks3?=
 =?utf-8?B?UldBQysxQmp5K0tHVnFtL3hXNFhlVU13c1dESUo2c1FDRjE1YzZESTJSTU9u?=
 =?utf-8?B?OW5jeXIvbWVoL2pMYVA2OVk2SHNBU2xzNUUwRUNsWHpaSTFCRWFPbUF4SXNa?=
 =?utf-8?B?L0VCNmtCZkR6cHowV05FR0l2S3BuOFZkSTFFRkdKYVhhQUh5T0ZKK3BTdFJG?=
 =?utf-8?B?UGY3d0I1Wmo2NzZEbHJ5aWRIcGxFTzlDNjAveDRTVzEwYXJsSFpERUNVMFJa?=
 =?utf-8?B?alVpZ1FSYkFWUmdZc1VHWWZCVndBWDM3dmsxdWRNTGZ5NFlZdndiNm9rZlFM?=
 =?utf-8?B?aml4VmltZVpMTXZCRFpTWW56bkVTWTBicnVsZ1hFeXg2aWtRTVlwcGtjbUxr?=
 =?utf-8?B?QjhremRrZzBDOWd3YzdaVFA4U0VSRUFIaXllS294L1I2cy9kQjg3Z2h5a1Za?=
 =?utf-8?B?WDg0LzVvTFJwa0tNZ29FWVdNWjlQSDdZMXFhR1hKNUw0NFZlSEJNanNsNXBI?=
 =?utf-8?B?RXhETmU1dDRNaDdFbnN0cEpVbVdraVFKeVNISFcvMVZRd3ZKUEk5YUtRNXN6?=
 =?utf-8?B?YXJGWlhEU09HbnpHakxTaVM2dnF3OFBjMzlDdnNGdDFzb3llZm94OFNOQ1dI?=
 =?utf-8?B?TzIvZ1Y0Mk4vSEt5SWdGVGlzUHA4M2hnS2ZtaDA4Vi9jTmZaaDhSTStyMExp?=
 =?utf-8?B?YkJZQmMzcmx6L1pqVStUeFk4RS95RHppMHV6a1FXZlN5cXQ2Wm9LMlhsSEpy?=
 =?utf-8?B?K0lrVVJEU29QaG5ldUF1TnVtUFp4K2V1Z2pNaUwxYXY5TUpBdHJDc1UwZnJL?=
 =?utf-8?B?bzNLN3lVQXVFRkk5VkkxYkE4dndiYm9MTno0RHVCUnI4N0JNNzhsZEVjcHJa?=
 =?utf-8?B?Sm0ydGtTTWFjekhhbXdGOGtPZzFoOTNXRmplS0J3VXdtOERscWNmaTFVVEVV?=
 =?utf-8?Q?Zqhx60mQHmp6KjJHcfYdyO78g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE4C53B4C3535245816FA855FADC116F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6b589c-a45b-438e-a11e-08da814afeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 18:53:53.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYQQ2dwZUqmWhYvILV240Mu8UJ9zvr1lA9YxA3MxA2BmxB5GN+fqjHQ5EFlkg/I32C9MM1tCjN3L+zusnS7+vu74G0PTDs89dHl1ehbHrPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3366
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDgvMjAyMiAxOToxOSwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgR2VlcnQsDQo+IA0KPiBUaGFuayB5b3Ug
Zm9yIHRoZSByZXZpZXcuDQo+IA0KPiBPbiBUaHUsIEF1ZyAxOCwgMjAyMiBhdCA0OjE2IFBNIEdl
ZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+IHdyb3RlOg0KPj4NCj4+IEhp
IFByYWJoYWthciwNCj4+DQo+PiBPbiBNb24sIEF1ZyAxNSwgMjAyMiBhdCA1OjE2IFBNIExhZCBQ
cmFiaGFrYXINCj4+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+IHdy
b3RlOg0KPj4+IEludHJvZHVjZSBTT0NfUkVORVNBU19SWkZJVkUgY29uZmlnIG9wdGlvbiB0byBl
bmFibGUgUmVuZXNhcyBSWi9GaXZlDQo+Pj4gKFI5QTA3RzA0MykgU29DLCBhbG9uZyBzaWRlIGFs
c28gYWRkIEFSQ0hfUkVORVNBUyBjb25maWcgb3B0aW9uIGFzIG1vc3QNCj4+PiBvZiB0aGUgUmVu
ZXNhcyBkcml2ZXJzIGRlcGVuZCBvbiB0aGlzIGNvbmZpZyBvcHRpb24uDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVu
ZXNhcy5jb20+DQo+Pg0KPj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPj4NCj4+IFRoZSB0ZWNo
bmljYWwgcGFydCBMR1RNLCBzbw0KPj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8
Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+Pg0KPj4+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZp
Zy5zb2NzDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MNCj4+PiBAQCAtODAsNCAr
ODAsMTggQEAgY29uZmlnIFNPQ19DQU5BQU5fSzIxMF9EVEJfU09VUkNFDQo+Pj4NCj4+PiAgZW5k
aWYgIyBTT0NfQ0FOQUFODQo+Pj4NCj4+PiArY29uZmlnIEFSQ0hfUkVORVNBUw0KPj4NCj4+IFdl
IGRlZmluaXRlbHkgd2FudCBBUkNIX1JFTkVTQVMsIGFzIGl0IHNlcnZlcyBhcyBhIGdhdGVrZWVw
ZXIgZm9yDQo+PiBLY29uZmlnIG9wdGlvbnMgZm9yIElQIGNvcmVzIGZvdW5kIG9uIFJlbmVzYXMg
QVJNIGFuZCBSSVNDLVYgU29Dcy4NCj4+DQo+IEFncmVlZCwgb3IgZWxzZSB3ZSB3aWxsIGVuZCB1
cCB0b3VjaGluZyB0b28gbWFueSBLY29uZmlnIGZpbGVzLg0KPiANCj4+PiArICAgICAgIGJvb2wN
Cj4+PiArICAgICAgIHNlbGVjdCBHUElPTElCDQo+Pj4gKyAgICAgICBzZWxlY3QgUElOQ1RSTA0K
Pj4+ICsgICAgICAgc2VsZWN0IFNPQ19CVVMNCj4+PiArDQo+Pj4gK2NvbmZpZyBTT0NfUkVORVNB
U19SWkZJVkUNCj4+DQo+PiBEbyB3ZSBuZWVkIHRoaXMgc3ltYm9sPyBZb3UgY291bGQgYXMgd2Vs
bCBtYWtlIEFSQ0hfUkVORVNBUyBhYm92ZQ0KPj4gdmlzaWJsZSwgYW5kIGRlZmVyIHRoZSBhY3R1
YWwgU29DIHNlbGVjdGlvbiB0byBBUkNIX1I5QTA3RzA0MyBpbg0KPj4gZHJpdmVycy9zb2MvcmVu
ZXNhcy9LY29uZmlnWzFdLg0KPj4NCj4gSSB0aGluayB3ZSBjb3VsZCBkcm9wIGl0IGFuZCBqdXN0
IGRlZmVyIHRoZSBhY3R1YWwgU29DIHNlbGVjdGlvbiB0bw0KPiBBUkNIX1I5QTA3RzA0MyBhcyB5
b3Ugc2FpZC4NCj4gDQo+PiBJIGRvbid0IGtub3cgd2hhdCBpcyB0aGUgcG9saWN5IG9uIFJJU0Mt
Vi4gQVJNNjQgaGFzIGEgInNpbmdsZS1zeW1ib2wNCj4+IGluIGFyY2gvYXJtNjQvS2NvbmZpZy5w
bGF0Zm9ybXMiLXBvbGljeSwgc28gd2UgaGFuZGxlIFNvQyBzZWxlY3Rpb24NCj4+IGluIGRyaXZl
cnMvc29jL3JlbmVzYXMvS2NvbmZpZywgYW5kIHRoYXQgaXMgZmluZSwgYXMgaXQgYXZvaWRzIG1l
cmdlDQo+PiBjb25mbGljdHMuDQo+Pg0KPiBBZ3JlZWQuDQo+IA0KPiBAQ29ub3IgLSBEb2VzIHRo
ZSBhYm92ZSBzb3VuZCBPSz8NCg0KSXQncyBub3QgbXkgZGVjaXNpb24gdG8gYmUgaG9uZXN0IC0g
UGFsbWVyJ3MgdGhlIGJvc3MgOikNCg0KSSB3b3VsZCByYXRoZXIgaGF2ZSBhIHNpbmdsZSBzeW1i
b2wgJiBhIHNpbmdsZSBhcHByb2FjaCBzbyB0aGF0IHdlIGFyZQ0KYWxsIGRvaW5nIHRoZSBzYW1l
IHRoaW5nIGhlcmUuIEFzIG9mIG5vdywgd2UgaGF2ZSBhbGwgYmFzaWNhbGx5IGRvbmUNCmRpZmZl
cmVudCB0aGluZ3MgZm9yIGVhY2ggU09DIHRoYXQgd2FzIGFkZGVkIC0gdGhlcmUncyBTT0NfU0lG
SVZFICYNClNPQ19NSUNST0NISVBfUE9MQVJGSVJFIHdoaWNoIGFyZSBvYnZpb3VzbHkgbm90IGRv
aW5nIHRoZSBzYW1lIHRoaW5nDQpmb3Igc3RhcnRlcnMgJiB0aGVuIGhvdyB0aGUgc3ltYm9sIGlz
IHVzZWQ6IHNlbGVjdHMgdnMgZGVwZW5kcyArIGRlZmF1bHQNCmFsbCB2YXJpZXMgYmV0d2VlbiB0
aGUgc3ltYm9scy4NCg0KSSB0cmllZCB0byBtYWtlIHNvbWUgY2hhbmdlcyB0byB0aGUgUG9sYXJG
aXJlIG9uZSBhIGZldyBtb250aHMgYWdvIHRvDQphZGQgc29tZSBwZXJpcGhlcmFscyBidXQgUGFs
bWVyIHdhcyBub3QgdG9vIGtlZW4gb24gdGhlIGNoYW5nZXMuIFdlIGhhZA0KYSBjb252ZXJzYXRp
b24gb24gSVJDLCB0aGUgdXBzaG90IG9mIHdoaWNoIHdhcyBkZWNpZGluZyB0byB0YWxrIGFib3V0
IGl0DQphdCBQbHVtYmVycyAod2hpY2ggaXMgaW4gMyB3ZWVrcykgYXMgbm9uZSBvZiB0aGVtIGZv
bGxvdyBoaXMgb3JpZ2luYWwNCmludGVudDoNCjxxdW90ZT4NCnRoZSBvcmlnaW5hbCBpZGVhIGJl
aGluZCBLY29uZmlnLnNvY3Mgd2FzIHRvIHByb3ZpZGUgYW4gZWFzeSBwbGFjZSBmb3INCnVzZXJz
IHRvIHNheSAiSSB3YW50IGFsbCB0aGUgc3VwcG9ydCBmb3IgU09DIFgiLCBhbmQgdGhlbiBqdXN0
IGhhdmUgb25lDQpLY29uZmlnIHRvIHR1cm4gdGhhdCBvbg0KPFxxdW90ZT4NCg0KSW4gdGhlb3J5
LCB0aGF0J3MgbG92ZWx5IGJ1dCBub3QgcmVhbGx5IG1haW50YWluYWJsZSAmIG5vbmUgb2YgdXMg
d2VyZQ0KZG9pbmcgaXQgYW55d2F5LiBIb3BlZnVsbHkgd2UgY2FuIGNvbWUgdXAgd2l0aCBhIHBs
YW4gYXQgUGx1bWJlcnMgLSBzbw0KZmVlbCBmcmVlIHRvIGNoaW1lIGluIChvciBtYXliZSBpdCBn
ZXRzIHNvcnRlZCBvdXQgaGVyZSBhbmQgSSBkb24ndA0KaGF2ZSB0byBkbyBhbnkgcHVibGljIHNw
ZWFraW5nIPCfmI0pLg0KDQpJIGxpa2UgR2VlcnQncyBzdWdnZXN0aW9uLCBJIGFtIGxlYW5pbmcg
dG93YXJkcyBtb3ZpbmcgZXZlcnlvbmUgdG8gdXNlDQpBUkNIX0ZPTyBhcyBpdHMgbW9yZSBnZW5l
cmljICYgcGVvcGxlIHRoYXQgYXJlbid0IHN0YXJ0aW5nIHdpdGggUklTQy1WDQphcmUgYWxyZWFk
eSBsaWtlbHkgdG8gYmUgdXNpbmcgaXQuIEl0J3MgdGhlIHNhbWUgd2l0aCB0aGUgZDEgc3R1ZmYs
IHdoeQ0KYWRkIGFuIGV4dHJhIHN5bWJvbCBhbmQgbGF5ZXIgb2YgaW5kaXJlY3Rpb24gd2h5IHRo
ZXJlJ3MgYSBwZXJmZWN0bHkNCmdvb2QgQVJDSF9TVU5YSSBldmVyeXdoZXJlIHRoYXQgY2FuIGJl
IHJldXNlZC4NCg0KQnV0IGFzIEkgc2FpZCwgbm90IG15IGRlY2lzaW9uIHRvIG1ha2UgJiBJIGNl
cnRhaW5seSBkb24ndCB3YW50IHRvIGJlDQpzdGFuZGluZyBpbiB0aGUgd2F5IChhbHRob3VnaCBJ
J2Qgc2F5IHRoaXMgaXMgdW5saWtlbHkgdG8gYmUgYXBwbGllZA0KYmVmb3JlIExQQyBnaXZlbiBy
ZWNlbnQgYXBwbGljYXRpb24gdGltZWxpbmVzKS4NCg0KSG9wZSB0aGF0IGhlbHBzPyBPciBhdCBs
ZWFzdCBleHBsYWlucyBhIGJpdCBvZiB3aGVyZSBJIGFtIGNvbWluZyBmcm9tLi4NCkNvbm9yLg0K
