Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5225792ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiGSGAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiGSGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:00:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE3139BAB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658210450; x=1689746450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gb4NMjYMHjOiF1KLyf2XtQT1dht/xadQ0X4G2uES+9E=;
  b=XrHvAfLZ3TpoCKnpYfCi2tzSfiJb53ifWRva81+tY97gqAbg8UDYpybJ
   CZSc+iCrCqr0YgBoy0cpIAtlBZMCoudgVnGj5KFzLOVRlLAYnsmF4niG9
   Np/iiAPcV7quZ/6euDyQEhms+7TfqUU/XBzNYoSa61wkoxACdzshhS/mh
   5hk+GIO8+4CNeWlI+TJ+LksUQiKEj8TMjIvTOjmei3dP2XX0jKEfrBRpf
   2sJiboq/MyvbXlzFpjRRLPYLXhAqgmOXXjmoSz4AgR/05X574uXiFzqaP
   sZZwzfFQTVP01KCFCZSjvg21wA1dNVuUbAZDEVh+MnrNyPzEz5uC3Sg5K
   g==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="172880588"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 23:00:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 23:00:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 18 Jul 2022 23:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6DKiIOk9IDy5gZYS3s+gxaCR6fzFtCDXe8JQ7yP66LlTW1BLjLlM84itUvpkICJbQzysPYeYve9qb2jziseZOW5ZUSvaX2FR8Hn20VD/lyjhy5BmnvKkzIqcbp2JDktDu05J/oghc627TcEM5rxJJavb88U9maW9YgvKE4LVZ+mmX8rRTOkSt893CMEK+IxBbkFUu1vjpxin/KdlkSCMzBggM5UsIDEcqtGFGiUclbjTOF1pAWrpjwLRmpdyk+r4Q5FBE+QHVzWokFWGbE8vB4lxjXqg7DN0SRf2UEKkHEip5kjVMY4MHtWrmW3g3YbMZe+VBWAVzBLEImUprU8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb4NMjYMHjOiF1KLyf2XtQT1dht/xadQ0X4G2uES+9E=;
 b=M9ddT+gMkJ6ByfPIRkTVp6x8yysKYrZdPkkFEcNgtp5bUmNgcp6tyZv9Cl3JKGVTfVPkqnb4g+vNjLPkXDJOQRXOaYOnJUDXsWea/r/wOTY3basTWivniy4jt+KuTUQkIbPFflBcqHPcA2CX03JBuIgT54wAWjb/aM16sr0yNIaZomsWVc1Q/cln26/kw4G9gSlfS18OcZkO6Y/Tkl+Hm1W5SKrXZtmz68hP9WBo0GHnUfcZO7G5vWznYChycuTdMkdkwvPZdSN9lPPgjywljis9q36Zy8SGzCkzWPQBuBNGYIPbXVt7yPyPFZJSluGy37kSGh+LiynkaWQWnt1Pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb4NMjYMHjOiF1KLyf2XtQT1dht/xadQ0X4G2uES+9E=;
 b=JaQoln2Cgm8BlXN7rrHuuM72JFLtPvLZ/baaSHVH7/n8ukuvNlhAT5wN5qVGFGuBZC+qTsrh5E6QfXWdo09gmn28xhUjmj2yN4pQ/GCyBjU1qPXapuLoEoEJ1WS3o6BvylSnhuPhTwFFDFFOASTvC/JsDrRLvNk8/HjX9Hzq+Mw=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB2921.namprd11.prod.outlook.com (2603:10b6:5:70::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Tue, 19 Jul 2022 06:00:43 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 06:00:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <quic_c_sbhanu@quicinc.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
Thread-Topic: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
Thread-Index: AQHYlcsGaT91mZeLa0CO/P6y+1cRGg==
Date:   Tue, 19 Jul 2022 06:00:43 +0000
Message-ID: <3e018ae9-66b0-0699-1121-e55c88f37570@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-3-michael@walle.cc>
 <735a88af-c4f1-a6b3-3f85-ea532b3f39c7@microchip.com>
 <305d3c9cf8a2362ad23a87f6ea92c6b4@walle.cc>
In-Reply-To: <305d3c9cf8a2362ad23a87f6ea92c6b4@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcb6d466-b45f-4ce3-9e0a-08da694c03f3
x-ms-traffictypediagnostic: DM6PR11MB2921:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQn9+aQwaZj0btxKaJii0rh7KrJSWYJiafV/3M4H0JDkX6igr04fg+lMZuNbsUasgFYAcbkY/ZNTqWIK/5Y6UJUleNgjQH1V2yytQC+LeWUdULo/GkVCJzM3IedW/dviKpYW26k+Yx5o2f22QoxcGeN73O9CM943GuDQOoRn6iBka3iXUqVAVB8z06HNN8d8v3gABmKli71pxhTB2xVu+m53eQ0k3jsNcynCoHaBruTYT6smAxOLKlAAY9zF7ALik66kTBx5jnOei4Mx2p1QJNO/VzADRI58WZdoKs3vNJUaLSWC9QNBRabls7gtlS0zK99AGzNhmgwMgC/11TwxiEzu99L/Lkzvk+1SxJWs4NniBr77soJYMSL8fD9SLXCBHtgX1LrPgQpEscFRsQ9oF0GzYHb2tH0bAa6JLTv8orVU6eWXPOjEA4n/zB2F5W1EY+C1XnKRctvBTCSgSRU9nzrRG1ae99qJFhiOfMAkTD+1BasDSnbfZBdAsXYQKZjFs2ggcraiWRn/QmH31PXwvYaex7HckKvVhrDYPz4gytn3+xN9096T71BzaUb1QGKc5kZ1cFUiXV58fa6S5SKWvVnLAe0DC3yiI1OLZUuI1nG2Phc03V36EnkVDJb0xkP92BFvTRE2IgEjYHlUIYgZJOoL52gMC5h2evVHxK95rai+zdhTYatDs27GrJh4BwxttP303OQv9Lwcb1Z2XJglALVryyiofxXvGP3YNsNqILHsdPmp+p0GSd5PKg9Qn5f+jCXYin+NGosWV7z4sNp6dCWcupEHiMsNkfPTxue0ZC1pzulwQNyH6ucWFcnkAjC3lATuYFE1TK3NDRif+qyr7nIYxIkhkEF4qQGjMzEVQIpL5/GLfNEX0JC6kQfTdAJHM526vTI9UhWENhPU51AERw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(41300700001)(71200400001)(31696002)(86362001)(186003)(2616005)(38070700005)(6486002)(6506007)(53546011)(122000001)(478600001)(38100700002)(26005)(6512007)(8936002)(5660300002)(4744005)(91956017)(31686004)(76116006)(36756003)(2906002)(66946007)(8676002)(64756008)(66476007)(6916009)(316002)(54906003)(66446008)(4326008)(66556008)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akdTbGZXVUkra3VpdXo0ZjZWTXc0MGptZUxFdWM2Mmt5ZkNoMVJjUDdtTWtr?=
 =?utf-8?B?ak5jNXpHWnZJbEF2RUZqL0ZXT3c0bmx1RnpkdVltcGFoRHFrejdTd0Q2R2F0?=
 =?utf-8?B?Q2RRdXRwTi9XSDM5eU9DRHE3UEtOam9HLzd5dVlPU3k5aHFxSHFVMStBcmNn?=
 =?utf-8?B?dUZMeVRReVljNVBkRmROK0dzc0ZLZEVvK0JTdktiTzNQUVU0VTU3T1ZKQS9h?=
 =?utf-8?B?ai9nMHRFNGlNUzZDdW93alRBTThhdUw5MXVLTk00Q2VVNCtKcDFwM2xtVGJx?=
 =?utf-8?B?cUthUTY0d25Fa3Z1dDdERFc4TWRJRVVXdE82RzM0RlRFSGRkQW9BUlN4VzJ0?=
 =?utf-8?B?MTl5dklNa3JpT2dVcmNHd0duRituYkhIdTNieTZrdzM2Mkp4WmJOWHUrOGpx?=
 =?utf-8?B?V0RqMTdhNEI1OSt0SnJGVjRLazhZTXFiS284K0tGK2laeS84V1JUN2kvVWhL?=
 =?utf-8?B?M2d5cC9MMitPeTh1aXdyWWJxaU1zeEozem9jeHd2bWtDejVRQlUvMDRSMkJt?=
 =?utf-8?B?L0xnMEhVMjdXa2paR0NFc3MxakRXTVZHbmxhVFFvbXB1K1JERVRrSzd5NG5L?=
 =?utf-8?B?ZjEyMWY0NGs5V2RjZWxpY2ErMTFLbzR6ZDFvcHBxbmYrR0o4YWkrZUplV1Uz?=
 =?utf-8?B?aS9yeEh6ZmxRWXV0OGxWdGI3VkRPT0hCM3VMWVVUMm94Y244bnFaN1VMMVJX?=
 =?utf-8?B?YXhCdWdjQ1RKU3ZVazRtZ2Z3ajJLSkdGMm1VS0FhQ1R0M1Z6YjBZRTJWcXgx?=
 =?utf-8?B?djBZbU45VDdqd1R6eE1qVWpiOUQrOFVMOHZzYlhNUW93c2NLM2JqSUd6MHhW?=
 =?utf-8?B?S0VZODdQYXFXOXR3S2JMTXp2OUtheTJ1ODBqZzdsZUJwVjM5TTYvc1ZHTTdK?=
 =?utf-8?B?QW1sNCtWNS9ueEpCemdybVZiYWY3ZlBTL1hLeTZzM2ZKY2Jwa1ZBMGNkdWJm?=
 =?utf-8?B?ckYvL242THMwRHhRd2dsSjJUSGVVanJPMlhUQVJmSVRtVjBTRU1BMjZKenpC?=
 =?utf-8?B?TkJhUUZKMm1xQSsvK2FSckxpVk1xd1AwZkFDUUJJck9nQlE1KzZ4dk5OZXdl?=
 =?utf-8?B?ZkNrZ2NHL0ZKWVo1WUxoUDZaVWN4MjlkZjJMcis1MFpQMTFJTlA1ZTFMajVz?=
 =?utf-8?B?bUNUbXdqdUlWdlkrZ1JIdWNmbXR1SWhMNk5mampFZ1l4R1VUSExnVkFXaE84?=
 =?utf-8?B?anFWRTM1MlUrdHRXeVAvbm0xMFNWU1NpdXZFdisvM2lVVUVlNnp0UUR3UTdP?=
 =?utf-8?B?SERDRmFDKzZRNkNTNmtvaXB4OFlKSE9IclRiZC9UeTVaTW9mSXRjeWFuVG02?=
 =?utf-8?B?QWE5MGpCQ053b3R3SHpJRW5GeHN0TnRyaFRwV3RoU2d1UXo3ejhkY0UyUnov?=
 =?utf-8?B?TWVuOG92b05yNjhMUlI0bm14QTVuQ1R1SkNjYXM3bzU0anVPd0d3NFRqTzJz?=
 =?utf-8?B?dDRlcUxZTnNad0hrYTBtWG5tQ3NGRDM1ZWhBcGVENkJMdXNWMmZtMGVZQzB4?=
 =?utf-8?B?MC95ck5CVXAwK3dManRxa0JIbUsxUmpld3JzL2trRHVrMFlvb2lRblJlOUtO?=
 =?utf-8?B?T0d1RHU0cDg1Tk16TzJSdzdibk5jcmJHdG5iNDVtQnR0a2RneGQrMktrb25T?=
 =?utf-8?B?aEQxSWtRNUpvNGZUTFBhZFBUZ3hCY3FSbnJVb2lZSlQ1NndHRnZ0YkxRZWJj?=
 =?utf-8?B?ZVNkSndNd3dOM3RnSGlSaEc4U2p2V2VSempOcFRMVVRRUjRwWEtJZGdUdk05?=
 =?utf-8?B?RGxKM09wQTVYNkI1eXdvazlkM0xKbUtxb2hEb0JnZXBRczMwWXZmU3QxY2VT?=
 =?utf-8?B?TjZMblppR0I3WmRCeEtMV2FPOHoweTRvRFJvOVNuekZUTjFjVWEyeEFTanE0?=
 =?utf-8?B?Sy85USsrYmsrZnRTMkhNMUVWS0REY2FzSHM5Sks3NmcwQXAyUmUwSWxBVWlP?=
 =?utf-8?B?K3VyKzNPM05DQmpqaW8vaWpzYmZUa3NoWjg2Z2VJMU9jRjlkeEpDUytoMmJk?=
 =?utf-8?B?RG5CMXJKczB3VVpLaXBZQ0dlUTYxWUU5cXdObUl5ZjNocnAxQm12eE9UWG05?=
 =?utf-8?B?djJZVlNkQVozR2VIWUdxdllldTAydmcydUZtU1crMjVTTXZ1Z1dHS2JYUDFP?=
 =?utf-8?B?UnJ4R3pkbHNHUDNKK0RUTVdqRnlSNGNUTTlFczUzTmNURFFOTEk5bnBnOUZw?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D57208124098B64CBD693FBA822312F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb6d466-b45f-4ce3-9e0a-08da694c03f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 06:00:43.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f997W00WxorLnxg8U8d3X/QNT/TOwGGsAWycTlAANRag1/UB4fm5Lcgqi1BOH9x/FlSb7J1YD9v2tjAE4aNgzOdfubGdUZ1SeSKiGIL5UKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2921
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOC8yMiAxMDoyNSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA3LTEyIDEwOjQwLCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IFNoYWlrLCBjYW4gd2UgaGF2ZSB5b3VyIFRl
c3RlZC1ieSB0YWcgb24gdGhpcz8NCj4gDQo+IFNpZ2guIEhpcyBlbWFpbCBhZGRyZXNzIGJvdW5j
ZXMgd2l0aCAiVGhlIGVtYWlsIGFkZHJlc3MgeW91DQo+IGVudGVyZWQgY291bGRuJ3QgYmUgZm91
bmQuIiBTbyBkb24ndCBleHBlY3QgYSBUZXN0ZWQtYnk6IGhlcmUuDQo+IA0KDQpXb3VsZCB5b3Ug
ZHJvcCB0aGlzIGFuZCBwaWNrIHRoZSBvdGhlciBwYXRjaGVzIHRoYXQgdXNlIHlvdXIgU05PUl9J
RDMNCmFuZCBzdWJtaXQgdGhlbSBhbGwgaW4gYSBzaW5nbGUgcGF0Y2ggc2V0Pw0K
