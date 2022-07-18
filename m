Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC3577B22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiGRGhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiGRGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:36:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102FD165A0;
        Sun, 17 Jul 2022 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658126218; x=1689662218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ixcLgb2kWjYLGBD2Yi1DKSHXr4B76kOGVe8Xn8UEZ0s=;
  b=C7OQcqoYCOJ07u8p9B4XVIa6AL5syKYCpdyJwh4brH2XIlZoGrDEj/dI
   oC1saFSVa6pv5bsW2qKFDgPXB2bIDkblazrfUN9DkgTGrgn48gHgjbOd/
   ahanDSo4eMqaWyeWoxcd2DhDf2t9Yv1yUbN5FIfMcEW8y9Z9TT3Gwc1Nu
   UJkPCML0nkDlywhpC8L8hQ42LcviQ8328ue4QmlJOLvKS5TCPIrrqSfDu
   32OGVnkTvk0YVyS4K6m+/ikE6Pnelsny16RX9hIJkfrhNGmLiBcOuVRtO
   Sd+ypaCCv9IAdLnA7UVFwtUNmmBJxUfcBbVglgSLmr3hDSrzPxU4dWgHy
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="104883301"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2022 23:36:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 17 Jul 2022 23:36:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 17 Jul 2022 23:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaU9DFkqPso5kPQp79Otw9vhjvHx2ymQVY1vT+4mEu1eO/mFrOq+6Iuuzqq+WGogavE4ks6QvgKEiSy4FpsWvpWYAnK6beN87BwDQ7/Rb2Vqv04jnvHHyXnu9Sz69UVQQgCfiE4jeoPk0k7LME+WkkA56eT/CtNLfJEGHIYD5Q8VGGw3ddu5PIXqg2AtrnjGPBweNznY/9EUUeHaiE6kat27lgO803bMqvaF3mNeiRPgQCnyzwYQia5En1dNGia+Mgn8iNKh40cpD5IjjWmY/57OtBF437WRWWr2OeO/OM0yaPlQa5zWV6NsKFa45QFvQgRqPag0dx8bONH8+wOl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixcLgb2kWjYLGBD2Yi1DKSHXr4B76kOGVe8Xn8UEZ0s=;
 b=Abp3j99OVB5ILoC8W9qkjei6OeIC3dpKG+76DS7WaKljnjdLuWwK613zsqns0JCKKJRbremj6x2NE0XOe7Ks9x6x4wB1kahTaTcjvostKAExjteTNQYUSlixmM9Vd/LRpGE9Uw1EIdaGyY4h/DjozS4/sPhd8uvzojZNTJdfARG/of68VA1CFFy7wRep6A6ROlosWlc7xQ8f+Exm234IbFGmKCwGGGT1HvrR+e1byl+oPSNaBtvDYlYiSqF+Wu/P0O615Ih8EhVEUHS7PL6dmy4zPYI3haGB23Y/slknslrL2MXiWnVh4m6Q2Pwscww+hBJeDr6mIwRHnCfYVe5gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixcLgb2kWjYLGBD2Yi1DKSHXr4B76kOGVe8Xn8UEZ0s=;
 b=mciH0Yw3Og+em8KhCpixQbO+1o4EdRvqn/QzibdlUmPqauOsEDajcbjgQyfCKlcBHkxa3tl9LRMhGzO4cBmSNg6J7dP4q5cI8VN4iDLr6vNMXN/L7of9fP4z+1HHTJKxfYzzZoN5vY+sMhx9KGt45A+oUQPi2GWczQrOQTqtkn8=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Mon, 18 Jul
 2022 06:36:48 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 06:36:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: lan966x: fix sys_clk frequency
Thread-Topic: [PATCH] ARM: dts: lan966x: fix sys_clk frequency
Thread-Index: AQHYmnDB7CoBmwwi4kOIGwjBgzJFCA==
Date:   Mon, 18 Jul 2022 06:36:48 +0000
Message-ID: <69fdf542-e7ca-ffd1-3f73-ea8dca887a46@microchip.com>
References: <20220326194028.2945985-1-michael@walle.cc>
 <3e860b122533f488c053abe0f3ff03eb@walle.cc>
 <1d2cbab375b50c0be31780f2d8d7a088@walle.cc>
 <ad62beb5a2c8582014a3b4172d55bf64@walle.cc>
In-Reply-To: <ad62beb5a2c8582014a3b4172d55bf64@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97d008a1-5c4d-41cf-046b-08da6887e3f7
x-ms-traffictypediagnostic: MN2PR11MB4696:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ydxfsb1Hki91PelX/TbPH7/W5XDlgeyWrbrU1pJRdaUs0XNsPPyrkUya17yUZPKBfMJxU9riaN6S5HsBnT5Wyt/jjK7HGLniVqhSvtq4ZIZ9i+4nfCF407io6laz5LQRVEWyXBZmp85ipDWit0KOHCcjfU9ipuXv2XmJo5ko2yeunlqWtn/3OjIwCn3LBa+OOf37oDXw40O4WkYv8zCPEDPgvtPU4YhnA1OF12IWk6qBLO5Xa4g5WsbBohyCEd0ppadPt63ezqNrLjmOYKaKh/z99JJ46O9ReqWUcRYY25GbfOupvma0eA7NXsXESW3DWXilQ9As7Igut1fyPQYMQRhj2fBIIUX9Vj0jTgSI+RlkHCRpuarilpr1TttXjXBBKnxH8Qltf4/PH66dSHPRSDRYGcMJHzAN2WDXEFJDnuSNCOXd5vnvHRtkL3tK19BO6qw3g36i6uilItR4dfW8iiGCXHxJRr5Hezy9EhmZH/SwGaHdE3tfMvUKlS+BZbfSk10FOUD9jnTfZuY+ni7q2J49gtDqaYeH0IvgTebIeCd27oq/V7aZpeTUPsKMw7q0qjMMHqsiYQwGOAzpvtFK2eHpaI2g8nqga9NehRc6gNwgHkG03p+o3htlw9i3JJb+V10Ni8dE0w3ffmvaCitVTqZeLnl8spMwd48dTVKkA90S9MPce0py0gXECWz7Q1ufKddHjDVnrpiftd4BR/5HBaUUyiPJsaCfue95kV6qvYmEbSIwqrmtc0lqPdQL4wom/tfGmBnMn7qxXoXlqQfvlhsGc0BnQobkvnl7XQqYgG4HEXZBWZiyiIUkQOAZILMvQ+i+v6Vf9K/nPXhn5PldJjeLZQZT/kkcCrohnEopPTaxD4Wtd+ingTRKVyuETZ+K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(39860400002)(396003)(38100700002)(66476007)(83380400001)(66556008)(186003)(316002)(4326008)(66946007)(64756008)(76116006)(8676002)(66446008)(71200400001)(54906003)(110136005)(6636002)(31686004)(36756003)(91956017)(6512007)(31696002)(478600001)(6486002)(53546011)(6506007)(86362001)(26005)(122000001)(41300700001)(2906002)(2616005)(38070700005)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUxEVkZEN0hFaGZUemhDSWlPWDMxajdQcjBVTmRJYm13eEthNlVrK3FQVnFX?=
 =?utf-8?B?ZDJVSnVxNUoxc3dNS0pEc0xwRVl3bmIyNXI5WlFzdzhINzIwYkFVRkdLcEh0?=
 =?utf-8?B?allGVGcyOHBEMGNKNHhuRXJScVpFWGpoNmw1QTdJdklqVmNXRDlRa3I5SXJU?=
 =?utf-8?B?ZHc5Ymtpb0NUV08zR0VVUDhKOVFLSUxHV2poZTNWdi9Ddno4RFBCRUZsdDQ4?=
 =?utf-8?B?cXBkYU9vSDY3TXFUUnFXcTJvc1pXOGw2RHF2TE5HVk93NFZ5M1ROWlVsenhn?=
 =?utf-8?B?ZHJmaE55cXU4L21nOHRHMjFpdjB1TThvcVdmRTZlMGJPdDloUUEyeEgyb3Ni?=
 =?utf-8?B?Wi8zek5pUzgxTGQ1ajgyTndZZExWWGFldDNjdzJjOHhrZWtFd09ZVEVSaUli?=
 =?utf-8?B?cGhMY1QycG1LWUZaRjBQOTZPZzRTVm54ZXM5RDJncFErQ1JJV2lDczdaQ1NL?=
 =?utf-8?B?MzNKTnFQSk9hMFlCajJkMzE2cnc5ZXR3ZTMxL21qWWl1L3lWeFNETytZRURQ?=
 =?utf-8?B?dmtvODFncE5mUGd4QVJhVVFmdHlibXhHZE1URXVPRS9ZVkRXcGxCY1NadmRH?=
 =?utf-8?B?Nmx3M2pKR2tPdzFFS2JjYlZ2YjBFOE9hWVNqeXMyY09NTFh3cm9nQnI1VXJJ?=
 =?utf-8?B?UmM3amZsQ1dhcjFvQ25YRysvNER1U2FGb05nQTNLVXR3M3U2MHlybGJqVGxx?=
 =?utf-8?B?ZDhnMllPL0xMVWRoWStpcDFHNjhRamhYT0JsMTlJZTFibTJ5WUNleEdZM2s3?=
 =?utf-8?B?aFZGbE1tWWlubkJGTmlaY29SL2VKLzR2N3VvaVZwOE9jVktDdm5WRk45eUx6?=
 =?utf-8?B?LzV1UkkzYnBtWW1LckhvT0prSVplY01GcndxTU9PeU9DbXFQOGdGVllFYVlH?=
 =?utf-8?B?MjkzUWtSWUl3SVJuL0pjRlExTFpLTVdnWUJVSlhWTjBlVmE1TzdSQldFL1JL?=
 =?utf-8?B?Y1k5YkhMdmQrN3UxRmFlZ3ZvdUZTSmhNaTJ1a2lLcmVJTHdqMzg4a3MzbmV0?=
 =?utf-8?B?eHBMaVhwbHhjdHNOUDdOV0h0aExPRFA1Q2xtOU5XbURpb0NnNTNVRlZXRkU2?=
 =?utf-8?B?MDB5QUh6REhKMWlUTVVyK1liVnhJRWYwdGk0MU5Qa3haRzNYODV6M3h0OHgv?=
 =?utf-8?B?UHBTT3JrZStacVJOaG5nSE4rSFkyajhUdWtPa2p0ZTFYOTY4RkNRQW9NbVVE?=
 =?utf-8?B?WldyVnNPa3pZNTYvY1BtbHgzK05kUm9kUEVydUVUZVBVRm5ZV2d4WFJnb1ZT?=
 =?utf-8?B?ZXIzOFF0SCtyQWpGUTlyK2FUQWY1RWxxUVRGc245a3NLNEFzTEZvUzNvK0ZP?=
 =?utf-8?B?dTkwSUo5QS9hNU9tQjVBVk9LNkRrSzAvME5yblVzY2VCYmM1K3NSQ251TGVn?=
 =?utf-8?B?RVBsZDh0RnVVRThFT0NMNDVTRnFFdElzMzdmRmZDVHBMRzF1QTI2RU10dGdQ?=
 =?utf-8?B?VDN1RThtU1JWZkVYN3dMTUZMRzZvWmJpWG5HaUROWEtESFJ5c0ttUWtOcEsx?=
 =?utf-8?B?UldUWk1lSW5oeTczZm1pckcwNDY2NUFCZks1aU9mNWd5NUJPU0ZxQ29uckRi?=
 =?utf-8?B?QzZSUUdEeDFobkt3MmJpVVRiOGkvSHU3RFJNZmhiUm9GM0FZa0Ryc3pWNXQ5?=
 =?utf-8?B?SXB1bi9SOTJ5SndTRlRLRkF5L0ZlZDczaGFXRDdvNDhiUkFVeUJJZHI2Mjhp?=
 =?utf-8?B?MW9IV1ptSFEzbGVadE9pQXhwWVRNbEwybTBya0xwQlFEQWNQTGd1dUg2RFFw?=
 =?utf-8?B?UDNxL2FHVmpoY3JlSnUvL3JjWnJhdG9odEVUT2hmK1puYUF3R1NSQlJ6UkNi?=
 =?utf-8?B?UE1OWWFJZDExd0FUYXcyTnRSRGdpcTFudzRVWTFicEFEWDBDTW1QWjhnbzRD?=
 =?utf-8?B?dGFGVHU1RkdJeUV3V0NoUlkrTHpoN3F0M1ZKWUJRckZMYWRlSnhKbnkveE56?=
 =?utf-8?B?V1ZaOGpmS3orL2t4QU4rdUFZTk1YVlZjem1tRkJVUExZcEpTdnNJM2ttSnV0?=
 =?utf-8?B?dlJ3Q0VrZ3Fwb1QyMkR0TjFuMkg2RERFWEZvUkxybmVGN3orclNOcEVoeTM3?=
 =?utf-8?B?QU03VzdxekZQV0tTRWpqVlRWMDZjUkZHN0d0YW1JYXRiaTBaODltNW5JMU1Z?=
 =?utf-8?B?VEdJcVdDRHNjbHA3Nms4MDQ0R0ZFTWJmeGZaSHZZMW5vV0FKamg1UHh1NFky?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB28805E8498FF4880AB40AB667C456A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d008a1-5c4d-41cf-046b-08da6887e3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 06:36:48.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+iasN81O0WM2xHriCrB6YQ+7P1csf6rMMjkem//TmZF6PIkYpZfLS8Jh/jFqtXQ1hQqDj0Q53JAL35G+quOdt5dP/+c3ZHvhy4DY/B+AmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDcuMjAyMiAyMTo0MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBbKyBDbGF1ZGl1IGFzIGhlIHNlZW1zIHRv
IHBpY2sgcGF0Y2hlcyBmb3IgYXQ5MSwgdG9vXQ0KPiANCj4gQW0gMjAyMi0wNi0yMiAxMzo1MSwg
c2NocmllYiBNaWNoYWVsIFdhbGxlOg0KPj4gQW0gMjAyMi0wNC0yOCAxMDo0OSwgc2NocmllYiBN
aWNoYWVsIFdhbGxlOg0KPj4+IEFtIDIwMjItMDMtMjYgMjA6NDAsIHNjaHJpZWIgTWljaGFlbCBX
YWxsZToNCj4+Pj4gVGhlIHN5c19jbGsgZnJlcXVlbmN5IGlzIDE2NS42MjVNSHouIFRoZSByZWdp
c3RlciByZWZlcmVuY2Ugb2YgdGhlDQo+Pj4+IEdlbmVyaWMgQ2xvY2sgY29udHJvbGxlciBsaXN0
cyB0aGUgQ1BVIGNsb2NrIGFzIDYwME1IeiwgdGhlIEREUiBjbG9jaw0KPj4+PiBhcw0KPj4+PiAz
MDBNSHogYW5kIHRoZSBTWVMgY2xvY2sgYXMgMTYyLjVNSHouIFRoaXMgaXMgd3JvbmcuIEl0IHdh
cyBmaXJzdA0KPj4+PiBub3RpY2VkIGR1cmluZyB0aGUgZmFuIGRyaXZlciBkZXZlbG9wbWVudCBh
bmQgaXQgd2FzIG1lYXN1cmVkIGFuZA0KPj4+PiB2ZXJpZmllZCB2aWEgdGhlIENMS19NT04gb3V0
cHV0IG9mIHRoZSBTb0Mgd2hpY2ggY2FuIGJlIGNvbmZpZ3VyZWQgdG8NCj4+Pj4gb3V0cHV0IHN5
c19jbGsvNjQuDQo+Pj4+DQo+Pj4+IFRoZSBjb3JlIFBMTCBzZXR0aW5ncyAod2hpY2ggZHJpdmVz
IHRoZSBTWVMgY2xvY2spIHNlZW1zIHRvIGJlIGFzDQo+Pj4+IGZvbGxvd3M6DQo+Pj4+IMKgIERJ
VkYgPSA1Mg0KPj4+PiDCoCBESVZRID0gMw0KPj4+PiDCoCBESVZSID0gMQ0KPj4+Pg0KPj4+PiBX
aXRoIGEgcmVmZXJuY2UgY2xvY2sgb2YgMjVNSHosIHRoaXMgbWVhbnMgd2UgaGF2ZSBhIHBvc3Qg
ZGl2aWRlcg0KPj4+PiBjbG9jaw0KPj4+PiDCoCBGcGZkID0gRnJlZiAvIChESVZSICsgMSkgPSAy
NU1IeiAvICgxICsgMSkgPSAxMi41TUh6DQo+Pj4+DQo+Pj4+IFRoZSByZXN1bHRpbmcgVkNPIGZy
ZXF1ZW5jeSBpcyB0aGVuDQo+Pj4+IMKgIEZ2Y28gPSBGcGZkICogKERJVkYgKyAxKSAqIDIgPSAx
Mi41TUh6ICogKDUyICsgMSkgKiAyID0gMTMyNU1Ieg0KPj4+Pg0KPj4+PiBBbmQgdGhlIG91dHB1
dCBmcmVxdWVuY3kgaXMNCj4+Pj4gwqAgRm91dCA9IEZ2Y28gLyAyXkRJVlEgPSAxMzI1TUh6IC8g
Ml4zID0gMTY1LjYyNU1oeg0KPj4+Pg0KPj4+PiBUaGlzIGFsbCBhZGRzIHVwIHRvIHRoZSBjb25z
dHJhaW5zIG9mIHRoZSBQTEw6DQo+Pj4+IMKgwqDCoCAxME1IeiA8PSBGcGZkIDw9IDIwME1Ieg0K
Pj4+PiDCoMKgwqAgMjBNSHogPD0gRm91dCA8PSAxMDAwTUh6DQo+Pj4+IMKgIDEwMDBNSHogPD0g
RnZjbyA8PSAyMDAwTUh6DQo+Pj4+DQo+Pj4+IEZpeGVzOiAyOTBkZWFhMTBjNTAgKCJBUk06IGR0
czogYWRkIERUIGZvciBsYW45NjYgU29DIGFuZCAyLXBvcnQNCj4+Pj4gYm9hcmQgcGNiODI5MSIp
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQoN
CkFwcGxpZWQgdG8gYXQ5MS1maXhlcywgdGhhbmtzIQ0KDQo+Pj4NCj4+PiBQaW5nIDopDQo+Pj4N
Cj4+PiBCdHcuIHRoaXMgaXMgYWxzbyB0cnVlIGZvciB0aGUgbmV3IEIwIHNpbGljb24uIEkganVz
dCB2ZXJpZmllZCBpdA0KPj4+IHdpdGggdGhlIENMS19NT04gb3V0cHV0Lg0KPj4NCj4+IFBpbmcg
IzIuDQo+Pg0KPj4gQ291bGQgdGhpcyBwbGVhc2UgYmUgcGlja2VkIHVwIGJlY2F1c2UgbW9zdCBk
cml2ZXJzIHVzZSB0aGlzIHByb3BlcnR5DQo+PiB0byBjYWxjdWxhdGUgb3V0cHV0IGZyZXF1ZW5j
aWVzIGFuZCBzbyBvbiwgZS5nLiB0aGUgUFdNIGRyaXZlci4NCj4gDQo+IFBpbmcgIzMuIE5vdyBp
dCBldmVuIGdvdCBhIFJldmlld2VkLWJ5Lg0KPiANCj4gLW1pY2hhZWwNCg0K
