Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF695581452
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiGZNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGZNk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:40:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE113E1D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658842826; x=1690378826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sp8dpkX/ceoIuBF5XkPeRBbsavimQOnDPRziMgUfexw=;
  b=DmLYfmbQnUuZgLG6rGHhrNVaaUsBjj+hWL3URdSoLjkNxpTNmYi98l45
   zmaZ8w4QzWCoFRmrnnZOLxG4FdN+MIsSl67Z7IxNBFnHI8gjkCuQA3wmB
   5gbLe752MPOhaS/H9sWxSaGD4twYbESA3FttbFppuwTKjmzmizWmyL4LQ
   kSd4Dma89Tv0fa1Qhmjhg9QuzzO1Z0QsEXl6ZuoegAdD6Imz3Gu3om9ui
   HP8TsGiR0lU0Pk6fa+OTHkJGIwc9E19rhykYOXI+av5UbzA3o9B8jgTmz
   K5WMWA1hP7oZNGz8o95vQbwC4MixW+AW1bJeBCPeBCXZay2gsiwz5lA0n
   w==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="183796283"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 06:40:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 06:40:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Jul 2022 06:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWQtD8hyriyKJD2On/02KZ55vyrVAgE66V66Gq3c9tYb1aFwNOns0pkwI/7vJQcDDXNUX5LVp6bb4ac8AcGI8Wf8QjL9Ondi6QlDWGxltg1KshjZtxdYNQJ4Cn0bnnLc7VqeEI8CjOAXZoagIWU5SnH82xhbw3y+TUBO/u9DoQCuIN59DpwkwHBBWzrdLjk5HJgf14KHFskwuxGGYt33gwfE3oos1DN94+oxdzRu6nJVJ9yyU9MNeyWRMKcLMJ1gUzUardLPJdO8JK0xmMsu/yTnNo5prbINrYQdBYdDSGN1F/wD+OBsAw6iKZcFdZL6Fn5wmckPJudWFRYdy9e81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp8dpkX/ceoIuBF5XkPeRBbsavimQOnDPRziMgUfexw=;
 b=CR0y8qhSShVYQneLWo4Syr5TI/RQEwL037lV+PYSEySQLxly+l3y53JJVVGB+24Qfh6FIBJocFzOd0MNnb8yi6l/r6N0IY1Sg+cIkcQWK3JE/j0DMsMecBA/5o1cgncuf8LdQ1mC0pxdKadGPpWRdzIkw37+pu2ObzOQuSpmZkGn3v3wG36TIbGoqxV2dAl/6WDInNYLTk/O1okkNp4J7la60CoFP3bVKZlgPbWdS41qutqflwcl34OuJru/FAiLe3txE28ghnbsMv0PwkYZJqTNAJxumwu1TAZJ5vFyEh0IdNuL+OIXSaXqQ9i3xxjSWsMFD7HAfu91MMF6BwQ7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp8dpkX/ceoIuBF5XkPeRBbsavimQOnDPRziMgUfexw=;
 b=d6RwEtsCbgK7apjpxnW1qoE16QTD6DePzEj/WAOY/6xl+YgLZd+15FG/KfP1vFSp8XPBt8Z1iQG5yprFnxMSX8u6EzRjrPEXnynOt4XwMBG7ZDWkkni0efw+D/C+jcmyMzG0FHTx5s77LM5UFRvQXjNjmZrkWzfHgPGi0HxGj7U=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 13:40:18 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 13:40:18 +0000
From:   <Conor.Dooley@microchip.com>
To:     <anup@brainfault.org>, <palmer@dabbelt.com>
CC:     <apatel@ventanamicro.com>, <arnd@arndb.de>,
        <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>,
        <heinrich.schuchardt@canonical.com>, <atishp@atishpatra.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Thread-Topic: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Thread-Index: AQHYhJz75cmfv8WW10Se/zFPHweEZ62QxGmAgAAc2IA=
Date:   Tue, 26 Jul 2022 13:40:18 +0000
Message-ID: <659c6aa4-1100-0945-4965-3e106dfd490f@microchip.com>
References: <20220620115549.1529597-1-apatel@ventanamicro.com>
 <CAAhSdy0mHbxQ3QVP9j1==oTG75Z9_T2bDSif-UGKppG+-hoJng@mail.gmail.com>
In-Reply-To: <CAAhSdy0mHbxQ3QVP9j1==oTG75Z9_T2bDSif-UGKppG+-hoJng@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 080bbd4c-c38b-4eca-042e-08da6f0c60e0
x-ms-traffictypediagnostic: MN0PR11MB6230:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnLNPrh5abzvNMARW+IdwyYvDdcARS4BoTICeZVdJEXwvP0T2YGTGphJRWwyHNS5R1wXqbQ8MmmIr2jZVB/8ifGiVHvSjxUiwvPanx9D8yW0I1wDWEIvhtQ/MLK+NqE9mNeyrOtRsiMhp3vUoXflaonpKDogYuPPXeOgKIv4vuy28+c056049pHmJZRpLlfbQfmkyfiI4hEv2xfiWe8ITSBVvnvl8p06jR3wvoseuxmYCZtmOzPSDwgb4bB5fpcEvgmFl4YFcKBiigZaT9QRezKPTBLvRcljUsyjm30TFi8aJeKECXJiGM9bcjYhDYGUI9151zWcLisnH4dFQTW2cCfc1GZrYh3k5oy814MAJ2zPcEPQ7uy+8I7LUBXGIAaXz4Ae+io8xiTVhlUhcBwz7WrNQnboERvdN4kRDaMn2915PCGFSrFpipByZnWF2Fr8o4yGl3B2blnvTH+G1wbGQyY9gXW79Jrzm7rqAmdUlLADxDV2wzi7GeWg02GScccXJhXCIXL9i349oWF0/4L4RhqE3xPyb0xiLAEHkU2f1VqwtvaGsa1rjiU+35zFUsHzWinDOFEG+s6X7opXkpqrVrRd+40kfFOUwEgk55JCwipeb96muNbPD3ajmXE8a8GIZGAPQNGA8WKPxDgUD2+oXYd2ijo1pFZSiLJiZpxVwLmye7FlFJ/fNNajIuNhxkXUG6JLSNPM+R8EXHXr/f59hoSkzSEXGD86cluvEQu3hxIcgX1Aj+SH6UjpsJF/hNdGmTBU8gYicyLDocltZrUfxL9uYC2WmaMry1gkkhOi580z7gAJsiYAGVE45DpT41I/nHf0MPZMbgYa5KXgKg36svpYOfBw7JW0JH+F92ywXD2S/9PAqmNM71sEpwhcysYs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(38100700002)(54906003)(186003)(53546011)(36756003)(38070700005)(110136005)(86362001)(316002)(122000001)(26005)(31686004)(2616005)(5660300002)(76116006)(64756008)(4326008)(66446008)(478600001)(66476007)(66946007)(8936002)(8676002)(6512007)(6486002)(6506007)(2906002)(41300700001)(4744005)(91956017)(31696002)(71200400001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0l6Tmt6MzlSZGl4VE1TZ3VvK2NZQ1BHcTU2WlFuaVhOVlpOVUxEbEQ2L1hZ?=
 =?utf-8?B?VFJTdzkzUXVaVFFLejI1TWZIYzIvVi9OcTRYbXhROS96TUVnbVhFdU9UWGNv?=
 =?utf-8?B?bEhQdXNnd0xrVVl1MVlXZUwyZUlnQ3cyODk1RStFUWJaN015aGgxcC9vdXZD?=
 =?utf-8?B?cWZHSGRQcG0vejdYTjIwNmc0SVN1NElNWFpIaEc5Q0E0TzU3dDNRMFhKUFF4?=
 =?utf-8?B?S2NlMWk1UjJ5R3dRTU53R0U4VHZET2E1RXE2dkFxNTJjVlAyQTE3M3I0S0Ix?=
 =?utf-8?B?VTA4dVRsUFJJd0plUG9QcWdvMG8wRU5BU2E2Y1R5ZmdiK01rREkyQmFHZ0R4?=
 =?utf-8?B?VnpyNytZcTFvR2l0L1VHMVlscHBlWXVmZ3JqRFRVSzRNaUdQYXAwYU5WZDNL?=
 =?utf-8?B?bG1zcDFCZkFLSkN3WWdIYms2a1lNcGp1WmFXc1VTRHJRT0U1Z3E5YlM3MTB6?=
 =?utf-8?B?NnFYc0FYUjdJMkhYNHVMUy9IYmZQa2lMSjBTemVIcjRwSWp2RW5DbHQwN3RV?=
 =?utf-8?B?bzZCN3piMGRWcW84SFNZVVl4MEFVclNEVjB1VUd3Q3hQc2l1MTJDY3g4Mmhn?=
 =?utf-8?B?SC8waWR1Myt2RkgyWVZtSnVrWUN2RE9rb1cxQWNnSFI1YmFkWTdsRkZpanVL?=
 =?utf-8?B?eFAwQmlrMnpNdkxCUzZCT05rY3htMm9JVEdnRXpCemo4K0c2Uloxd2VSQmJ0?=
 =?utf-8?B?RnBRbFhaNnE5YlJ5RFEzbkRubmRSRUptY2o1QXlqbDIxT1crUG1aMGROWFlV?=
 =?utf-8?B?Sllzb1BZMWJ2dFdCYXJ1VXUzVnZkZU5abUtxamcxS2tUdDB2QWk1U3JMRXpP?=
 =?utf-8?B?V2NwVCtGODJGUnQyZDF6TDQrWnZyVXh4M1RucVV4bkkrZDh2MXR0ZmhTRTBH?=
 =?utf-8?B?RDhua2dJYS9NN0x0UUkyalE4R0JOWjcyem5FRlFlaTdYc2VzNjY5eFJtY2t0?=
 =?utf-8?B?Mm5kKzlqN2I5NTIvSVB1VHUra3g1WEUydzF6UlBsMGpURVozZ0pPVzBQTkJj?=
 =?utf-8?B?aEJEQnFMYW03WmM1UWs3WEF2SFQ1M2RmdEJpLzQ3c3Nxdi9OOFhDM0pLTWVX?=
 =?utf-8?B?elRoenJ6VXIxdXB0Q05ZQUpjcm1vY2JFLzNLUlVIZ2tFcGxIbGZ5SDRIb2Zr?=
 =?utf-8?B?K3NRWG9xM2J6UUxWYVRyQmU5OWVkWFhIeXRZcmU3eEdKUmJTa3VQTXVZaWQx?=
 =?utf-8?B?ZElScTJydzdSV3ZLRk00VXZBREVrRHlmR2JQZGpkK2lyWTVGMEc3V05YNUQ5?=
 =?utf-8?B?VGtsVVZEbmprNE1XLzFoUWEzc2ZQOGVUbUo3R0p6a3VWcE1PNk1Uak1GU1Ir?=
 =?utf-8?B?R0gxcnVqejVzZEVzdmo0aHNKalFtWnVnMVRha3R2ZkJlMnBhNVB2NVZmVUUy?=
 =?utf-8?B?a0ZmN1J4Q085c1I1WlFEeU5pZHBiK2IyTklhazRycWg4ZlRqWXVBc3hzVjhC?=
 =?utf-8?B?cHdEMitRZHV3WFFiMDhPRkJVQ1dFODdPWTU0NHU3cU40Umh6aUJ1N1BLdVAx?=
 =?utf-8?B?UW9vamtKYzEyQUcvak53Q1RoQThtUlFwS3RGVTVsSjFYYVRuTHBjWGdsSm1W?=
 =?utf-8?B?Rk5YdWp0ZUF1UzFZcDZrRzRpbkhWa1YrM09SMnRKWEExdkFRU3lLUlNQZW5q?=
 =?utf-8?B?MVhpZ1B2Rm5QMFdkMUtkbWNkZ09kMElObkNkOHdsUWVtN1hYT1A3Q0RDcEtv?=
 =?utf-8?B?NzBpZHAxOU8zZnY2b1V2aFEvMkF2NWlOY25lYWxoeEpWSVhyN2pZR0o5TTcr?=
 =?utf-8?B?UkM5ak9IYnkxZFRTcFlaZGgrZ2VBQ2ZhT2IyUitKditrakk4enN2YkgzNzJz?=
 =?utf-8?B?YnYxS24xR2VxMGkxd1g5SFVvSS9BR0Mvc2Y2dzVLTW51bnJDWC9jN29Qb0ZD?=
 =?utf-8?B?eDhHdHhRNU96ajRETDRYNGJxVVlKaEZVT2o5bEdFOGpRWDBtNldoUWNSMjdh?=
 =?utf-8?B?OWpzbjluODBRdlgrMlllNTByZG5UYThVaTF6NHg2TVVHMXpPbzlLTkY3RWZo?=
 =?utf-8?B?MXlLUDVrNmdxMVBDSnIxN0lab3JlNlA4eE5xSW15TTlGRm1haGtZMVk5Y3VJ?=
 =?utf-8?B?bndORXhYTnVEcnAvTnRXSFlZZ1lsRW9wUzV4ajIrMUNpVkp2QkpXS0YvN0ZD?=
 =?utf-8?B?Q2UxUjE2WHBKeC9GWVdzbmlkQmE3d2lpdXJtYjNxUW1nT3ljSG5QY2MyNWhE?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E4F02006848434DA7621F57B608EC87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080bbd4c-c38b-4eca-042e-08da6f0c60e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 13:40:18.1462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3o+w4n6Hn0DjZMKR/rLEBH+wLrEauXqJLZ74E5uE0FjxZpXwq0XSMlDCsO3oZxu8GtJm/1PQcb76HRVyiXROu1cZ+eo0If8ESGATY5qjOFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEFudXAsDQoNCk9uIDI2LzA3LzIwMjIgMTI6NTcsIEFudXAgUGF0ZWwgd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgUGFsbWVyLA0KPiANCj4g
T24gTW9uLCBKdW4gMjAsIDIwMjIgYXQgNToyNiBQTSBBbnVwIFBhdGVsIDxhcGF0ZWxAdmVudGFu
YW1pY3JvLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSWRlbnRpZnlpbmcgdGhlIHVuZGVybHlpbmcgUklT
Qy1WIGltcGxlbWVudGF0aW9uIGNhbiBiZSBpbXBvcnRhbnQNCj4+IGZvciBzb21lIG9mIHRoZSB1
c2VyIHNwYWNlIGFwcGxpY2F0aW9ucy4gRm9yIGV4YW1wbGUsIHRoZSBwZXJmIHRvb2wNCj4+IHVz
ZXMgYXJjaCBzcGVjaWZpYyBDUFUgaW1wbGVtZW50YXRpb24gaWQgKGkuZS4gQ1BVSUQpIHRvIHNl
bGVjdCBhDQo+PiBKU09OIGZpbGUgZGVzY3JpYmluZyBjdXN0b20gcGVyZiBldmVudHMgb24gYSBD
UFUuDQo+Pg0KPj4gQ3VycmVudGx5LCB0aGVyZSBpcyBubyB3YXkgdG8gaWRlbnRpZnkgUklTQy1W
IGltcGxlbWVudGF0aW9uIHNvIHdlDQo+PiBhZGQgbXZlbmRvcmlkLCBtYXJjaGlkLCBhbmQgbWlt
cGlkIHRvIC9wcm9jL2NwdWluZm8gb3V0cHV0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFudXAg
UGF0ZWwgPGFwYXRlbEB2ZW50YW5hbWljcm8uY29tPg0KPiANCj4gQ2FuIHRoaXMgcGF0Y2ggYmUg
Y29uc2lkZXJlZCBmb3IgNS4yMCA/DQoNCmlpcmMgSSBtZW50aW9uZWQgdGhlIGNvbnNpc3RlbmN5
IG9mIHVzaW5nIGRlZmluZWQoKSBmb3INCkNPTkZJR19SSVNDVl9TQkkgdmVyc3VzIElTX0VOQUJM
RUQoKSBlbHNld2hlcmUgaW4gYXJjaC9yaXNjdi8NCmJ1dCBJIGRvbid0IHJlY2FsbCBhIHJlc3Bv
bnNlLg0KDQpUaGFua3MsDQpDb25vci4NCg==
