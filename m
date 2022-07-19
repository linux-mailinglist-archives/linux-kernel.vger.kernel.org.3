Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B461E57953E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiGSIbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:31:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD2D17AB5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658219474; x=1689755474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YEeGhJ4Ar3JckREYTAzD9X0CEV5tXMIWtk40CHBIGH4=;
  b=2GyebRVgulzxbZZG8X4Xlw2pLij80RP17gRR2fCaTDghuVjhzpWP2hFa
   OHJkBI8iHIrORAvpZ+Nv6Q9WImSGRGTApEu6PYwsItHGfVBFehmzebfg3
   dZ9tugeIqul5rn8N2sz4JX8QCbHNMS23EBhn489oImfuor8+SPkdEayLA
   dJuwvmI7/aR8TK827BxwLh/F4DIiHinlTg/wPwgjobyPGnkRImfJMwp/p
   qykXRJxw2obkI9ZVXHT7mcKQr8cNdvYFktFE8H3fVOYeNmGOeLDfETrTz
   gScVHRUKj7D1CMvIfpT9XTl72hGOoivIWusx2OzMhOdrGZiYKBTaJbqLl
   w==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="168468098"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 01:31:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 01:31:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 01:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeoudeg0+yiDj/zvoNGGI5qyMKPgwBtWuAc+G0Vfs2NqLrXgn76fuFaKNtPyKG9v0qHFC46gcnWh4+4xcDrgynV+QFCACv/sqAjwzlA4HDpHTiwvy5WkCeGIMHfjhkiauMLIPsQiv3GVUT1lnVJ9I55TCE3e2jZaGFWdQoFpyhlrNlNvAPrtpDA6l2Ko276KfQQJS7KABeInsgqWc6CXuGiT9+HK1iNnaJXPYhsPw5Vy4L+aeigRJkZ79yazUmhSrAcdZtoMxVwGDc5F5M3S0Hb8lnwp91CuKwBSpU7YhWtWzpcmM523sYbPCcBG2CqY6YoyVD7qt+o9YnENR8T2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEeGhJ4Ar3JckREYTAzD9X0CEV5tXMIWtk40CHBIGH4=;
 b=jgIwIDxK7grKVLwYbQ0GoOz/7XHWT9ugWuLB+EJyKTTrxbKKCJCI/IaODgo5Db1v+z0gGneKR0icZFqaIDCh9s5hSabuIB3zdws87LSxpOACh5FphuXrQ9LyqJC6WCxG77Y9SONcNNfRIA3CH/P7CBWF/NSdWqiX3p3bLi340MZrbxDb4F9fFQzUyBnJlE8VaaueIZ93A3J7Oyfeh0ZRCSUqiclBB0tVg/tWKF4zwOeyPVnoxTFvmCB4qZmF+wfiKUvrOgp6hi6rE68twFtFBWXq1CeE9X3gEmhHRI+ByU71K4uIenKSOjV2A033JjBncgaQ+FMzfRN2Nkx1qyBPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEeGhJ4Ar3JckREYTAzD9X0CEV5tXMIWtk40CHBIGH4=;
 b=jTtK64LsVCR9BS4DbdyW2P+gF0yhsajGveUyi0d6OkK1h+e4W+dowP10afNmCNYXFYzMqyHvM/rEniccfOz5vs1muHdo8Se1HHgDb/3KluV6aaLlQaXRyIEh8mbo5qEKr/FUeEY3CQdsqtu/9b+M5WlmosCPWyfXWAhpHkcmFIg=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 BL0PR11MB3347.namprd11.prod.outlook.com (2603:10b6:208:2f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Tue, 19 Jul 2022 08:30:58 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 08:30:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Topic: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Index: AQHYmzRwuAFPdIe45ECo1RhI0CKwAw==
Date:   Tue, 19 Jul 2022 08:30:58 +0000
Message-ID: <3095ef77-a90b-4d10-4891-a4309e3900d9@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
 <02125e047cfbf347d81811224be3141e@walle.cc>
 <7365146d-b001-2a14-014d-62a6b19f4381@microchip.com>
 <1a1b1bf3f8ea7a27afb6e85e0ecabbbc@walle.cc>
In-Reply-To: <1a1b1bf3f8ea7a27afb6e85e0ecabbbc@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16d60915-a9ae-4bf0-af4a-08da69610188
x-ms-traffictypediagnostic: BL0PR11MB3347:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LeoA9GvoOAAAfTb3eJzVTkQkf2MLXzERb4et2t1BLKimx0lVpgXxrheBRloYO1Y8sE69jHMbpqtKapD6Zl2pEFypTQv3GKyZG/QsNe6fRzTCivLEpIZV5Z7WSbFub/ecsMI0HafL3+AOWAshCn4TgISQUwDxAYUbbYX3jeQeF1IK2bH/v9jOWGivrsm+sFUyLFG5eeL8vPvuyKonXcQWbLXSFOeDeHkz7W/gz9D453ZjzNaeGXeiClrhGC3teYNk+B3tWkGZGMG3OYlYXT8LqxZJnfca9CUVX37CY7Z62Oic6qkkkxo9t1NynC5EqaW9ZWkiL0mNlH6jVB5rsmfDYdTc/9G3aNtVBwkPolA23yR+YlOOvYTa2a0md4/t4s3BvIFDjmgr8gcON4Y9Lkq71RdjYhAIhS5JZFzI0UrXZRuDizCXb5dtUrt+l+dgOOEqWhV+7kKhIoVUhBmqo/hkVQoKL4NH95rbJBbSP5ZJzZcAzvg2URDiHFbwMkGfFXllydBuTDP0i4hQF4KBxiXRoNdvTEuETPaBQD6Kp8E/KX4yTlcNufKZwjOWqqu4Uk2msWxy+bB7tsdbqzAGsMjJx0cpBndoiw7SBO4eTY3BXx9YSuWuo8uQK2tLpJ8sB+LTDzaNphHwgQTVBhtolf7xeQeVSgTm/Kg6lzmpCo+R1BqFCInif4VAvY4LcGXbFWyTU02ZwObg18f7be+POmJl5VXosxVExdI4PAWcrYg5jkSQ7fpMn96FJb+Sbhoq/2NbNWjNskZqEOTGItAnpIzRDJFaw8EUvspwyQp82a3/C77VvjxAatR4l25QO1FptQosuDmwH9UYBEBi2jM/tnC9gAN8qnt6EJ13Ut1ufBXRv6bifDG3QtnfPgElsDo/7DZDeDlcBSUaAKdjYFM4cNmZLMLnYgYeKTdewG5bneE2WG56OoafgwKuG/fJwx+Q54d/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(136003)(396003)(122000001)(316002)(6916009)(66446008)(8676002)(66946007)(71200400001)(66556008)(91956017)(4326008)(38070700005)(54906003)(31686004)(64756008)(38100700002)(36756003)(76116006)(186003)(2906002)(41300700001)(26005)(478600001)(83380400001)(66476007)(6512007)(31696002)(5660300002)(2616005)(8936002)(966005)(6486002)(86362001)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3V4RHlSZDNockVEdGtPemsvc0ZrVmo5Zi9aMHZqT3I1QnlHVDNnK3Fac1dS?=
 =?utf-8?B?S1R5ZlRSZEV3SFVFdk9VTGduODdIM3FRZlN5aVIxMGN4dDJ3N1dTMGowOHo3?=
 =?utf-8?B?bU42QXN1dm41L0xqdEMxMjg5TU1LQm1KTFh2aC9mZ05QV0Zld3g3aE9XMEI2?=
 =?utf-8?B?a3NCdCsyTDY4RnVRTDZWZFZBK0JBeTRBczh4Zk5UR3ZlVG4zbFlNcGtFZGll?=
 =?utf-8?B?N2V3VHpMM0tzM0d5V2h2YlNuU21iMmZxNGxPSU5DOURhYmNHU29DWm0zbUI3?=
 =?utf-8?B?R1VKc2NrMVRjdmlvYjZNdnZ5ZmpNdU9PZ3ZwakJta2tISGhJUVZpY29Vc21W?=
 =?utf-8?B?Mmc3bW5XMHZJR09tcVdvZEQ0L3VWKzFBTzlQRXJabWpaWi80cVIrbC8zdmZU?=
 =?utf-8?B?VkRwaFhxNU1sRlZDNnBmby9KUTlLclVkY3BZcUtGSThKQTJHZFR4anVjNllJ?=
 =?utf-8?B?M1ZNMi9OTWp2b1hNdW5Qa1RlR3F3RmFpZ0x2YytKa3Mza2dCRFBveS9xY2Rv?=
 =?utf-8?B?U0pSTzAyK1B2OEhoOW05bUxiUEpWdldwVzBUa2pwUnNMcTJvWGplSVl4Z1ZC?=
 =?utf-8?B?MUZZamxOVDlkNG12LzAzb1NGYzBHTVlXeWFvYWJjd2xCbWhqYzBCTVRKdyt1?=
 =?utf-8?B?ZGgxNHdEWldkWEFCSmE3d1JVdU1Qc3VoOXV6NHhxc3Q0UTdkclJFZTN4djBq?=
 =?utf-8?B?QXdJNUVvcW96bDdxQlBSelRVSGw1VHNlV25laXhZMkFJckVDdjNjRjhWR2N5?=
 =?utf-8?B?eDhvd0FpMkdQS1JsOUY3Z29kY0FiUEhzaDZjdmhxays2RHFrc1U1UVRaL25Z?=
 =?utf-8?B?L3oyTzR5bWRrRytSL2hjVHFCYWxGT1NxZ3pzYjNzaENBNGsvWVNOQjFxSUJK?=
 =?utf-8?B?ejNTQWd0ZW03SFNkVisvZUU2TGJ4VmVWaGh6V1hQakowTjlqR3JhSFFJTEI1?=
 =?utf-8?B?QUpFY3BXOTFsT0h5U0w0ZzVGczgvMXljMUZUQVowY0lGbjdERWVzOXk2Wmlh?=
 =?utf-8?B?V1FocFF4N05BOThWL0pjamFkZ3U3UDFlOWdobytXYW43NE5RcllQN2UzMjM1?=
 =?utf-8?B?eTVReHo1VGNoYkRWcHR0Rk9zUXF1QzFJOHRKSEg0cGxjRTZzVzN6V2d1VEYv?=
 =?utf-8?B?RmFnWFE2QnhTUzRIVS9xODdPY3c0Q2MwcWhrSDFySGpmMTlJaHBuZks1OURU?=
 =?utf-8?B?WGxLajRDeFFRVVNldjF0a3EvNGNHTWVTejFNVVZ6U2xETWZxbTd6UzNLZk1Y?=
 =?utf-8?B?UmttZURWeVRpRVBYMURaa3RBd0pTMjU1OEs4OUJsZFVkS2JZMUxSMFNFQ3po?=
 =?utf-8?B?ZDJGWHdodXMrRlZFTmQxSXZpalFubEFkcTZ6WmdJMHRkYnpJNWo2SHBJeEla?=
 =?utf-8?B?aUF1c3F1bTJiQ3l3UzNySE1XN2I3SEFKOEdFSW55R0t4ZzZOMW1zOVBYd2N5?=
 =?utf-8?B?cGhZQlp5bFdJS1duSnI1OUdCQldEZ2FRTk1OcTUwQnJncGpiaXhMcnkyb2hG?=
 =?utf-8?B?K00rRzhqVGRHWFRQaldSY0dsdWpTakt6QjZMVlkrcEZ4c2RpZEZnMWdoa05F?=
 =?utf-8?B?T2hyeWRFdWdadWsvR0lscWJ6QUNqd2kydGUxbVB6ODFYVWIyc2lKUVluSndM?=
 =?utf-8?B?WVJxU2srUUJ4b3UvUnY1bSszZ1FRcE1hV0kwYWtKeVl1RGxjbXptY0VEekRv?=
 =?utf-8?B?UFBtclNPZXRVeEVtZHRJaE5VTzlnZ244TFVKYXIvLzdncFJnSVhLaEVCbm9H?=
 =?utf-8?B?U2VsWlVES1JaT2hmY2p2dG5CWm0zSHhJZjZhZlh1Q3lHRk1PVzhhOEUxdXFr?=
 =?utf-8?B?cXR5bjBnU3VOSCtGOHc5WDUza1lVOEJ3NmtEK21JbHdVWnkzL3N1QXZHZGVO?=
 =?utf-8?B?WHRKQ1FDb3dLZGVjTHJPTXd5a051dzVPK3NZQjByc3JCVkdUK1F0clBnREVy?=
 =?utf-8?B?S09iV3p1V1VWVGNGZE1TKzZCRGlrWVdUSUNrTmVDSjgzYlZpem5BdVZkcnE5?=
 =?utf-8?B?QXFjL0lCZENwSFdkWWsyYktKbWc3aytWNUlkTXVWaUh6NFlVOXJQVEJKRVVT?=
 =?utf-8?B?VnJMemdKbUU1N1VZalRNR2dKTW85ZURqcUFpUGFNaFB0NU1sZ1BNbUpKKzBi?=
 =?utf-8?B?OGlFSk1ORERVQnptdGNzRy9ENWpJbmlaQzkyYjBDNzRQZ3NnUWp0N2xVSGpu?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDDC9894609DBD44AA1563118EEFBE94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d60915-a9ae-4bf0-af4a-08da69610188
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 08:30:58.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTLmZMQhCdnATnCzIJ7cNUr7yC4C38/SrHza6ky9ldXSIHzOtMGRegYdkMtCfieQDVLUZIaDV7sunu/GZLO2PoaVbos6AyjBytxbMtMFw0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3347
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMiAxMDo1NywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA3LTE5IDA5OjMzLCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDcvMTkvMjIgMTA6MDcsIE1pY2hhZWwg
V2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IEFtIDIwMjItMDctMTkgMDc6NTcsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tOg0KPj4+PiBPbiA1LzEwLzIyIDE3OjAyLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0K
Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cNCj4+Pj4+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+
Pj4+DQo+Pj4+PiBVcCB1bnRpbCBub3csIGZsYXNoZXMgd2VyZSBkZWZpbmVkIGJ5IHNwZWNpZnlp
bmcgdGhlIEpFREVDIElELCB0aGUNCj4+Pj4+IHNlY3RvciBzaXplIGFuZCB0aGUgbnVtYmVyIG9m
IHNlY3RvcnMuIFRoaXMgY2FuIGJlIHJlYWQgYnkgcGFyc2luZw0KPj4+Pj4gdGhlDQo+Pj4+PiBT
RkRQLCB3ZSBkb24ndCBoYXZlIHRvIHNwZWNpZnkgaXQuIFRodXMgcHJvdmlkZSBhIG5ldyBtYWNy
bw0KPj4+Pj4gU05PUl9JRDMoKQ0KPj4+Pj4gd2hpY2gganVzdCB0YWtlcyB0aGUgSkVERUMgSUQg
YW5kIGltcGxpY2l0bHkgc2V0IC5wYXJzZV9zZmRwID0gdHJ1ZS4NCj4+Pj4+IEFsbA0KPj4+Pj4g
bmV3IGZsYXNoZXMgd2hpY2ggaGF2ZSBTRkRQIHNob3VsZCB1c2UgdGhpcyBtYWNyby4NCj4+Pj4N
Cj4+Pj4gSSBsaWtlIHRoZSBpZGVhLCBidXQgeW91IG5lZWQgdG8gcmVmaW5lIGl0IGEgYml0Lg0K
Pj4+PiBZb3VyIGFzc3VtcHRpb25zIGFyZSB0cnVlIG9ubHkgZm9yIGZsYXNoZXMgdGhhdCBhcmUg
Y29tcGxpYW50IHdpdGgNCj4+Pj4gU0ZEUA0KPj4+PiByZXZCIG9yDQo+Pj4+IGxhdGVyIGJlY2F1
c2UgcGFyYW1zLT5wYWdlX3NpemUgaXMgaW5pdGlhbGl6ZWQgYnkgcXVlcnlpbmcgQkZQVCBEV09S
RA0KPj4+PiAxMS4gSSB0aGluayBpdCB3b3VsZCBiZSBnb29kIHRvIHNwZWNpZnkgdGhpcyBpbiB0
aGUgY29tbWVudCBzZWN0aW9uLg0KPj4+DQo+Pj4gU3VyZS4NCj4+Pg0KPj4+PiBBbHNvLCBJIHRo
aW5rIHlvdSBpbnRyb2R1Y2UNCj4+Pj4gYSBidWcgaW4gc3BpX25vcl9zZWxlY3RfZXJhc2UoKSB3
aGVuDQo+Pj4+IENPTkZJR19NVERfU1BJX05PUl9VU0VfNEtfU0VDVE9SUw0KPj4+PiBpcyBub3QN
Cj4+Pj4gc2VsZWN0ZWQuIHdhbnRlZF9zaXplIHdpbGwgYmUgemVybywgd2lsbCB5b3Ugc2VsZWN0
IGFuIGludmFsaWQgZXJhc2UNCj4+Pj4gdHlwZT8NCj4+Pg0KPj4+IFlvdSBtZWFuIHRvIHNxdWVl
emUgWzFdIGludG8gdGhpcyBvbmU/IElmIHNvLCBzdXJlLg0KPj4+DQo+Pj4gLW1pY2hhZWwNCj4+
Pg0KPj4+IFsxXQ0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW10ZC8yMDIyMDcx
NjAwMDY0My4zNTQxODM5LTEtcXVpY19qYWVoeW9vQHF1aWNpbmMuY29tLw0KPj4NCj4+IE5vLCB0
aGVzZSBhcmUgb3J0aG9nb25hbC4gSWYgeW91IGtlZXAgd2FudGVkX3NpemUgdG8gemVybywgdGhl
bg0KPj4gc3BpX25vcl9zZWxlY3RfdW5pZm9ybV9lcmFzZSgpIHdpbGwgcmV0dXJuIE5VTEwsIGRv
ZXNuJ3QgaXQ/DQo+IA0KPiBObywgaGF2ZSBhIGxvb2sgYXQgdGhlIHNlY29uZCBjb25kaXRpb24N
Cj4gDQo+IGlmICghZXJhc2UgJiYgdGVzdGVkX2VyYXNlLT5zaXplKQ0KPiDCoCBlcmFzZSA9IC4u
DQo+IA0KPiBTbyBpdCB3aWxsIHJldHVybiB0aGUgZmlyc3Qgbm9uLWVtcHR5IHNsb3QuIFRodXMg
aXQgd2lsbA0KPiBvbmx5IHJldHVybiBOVUxMIGlmIGFsbCB0aGUgc2xvdHMgYXJlIGVtcHR5IChn
aXZlbiB0aGUNCj4gZml4IGlzIGluY2x1ZGVkKS4NCj4gDQo+IEFjdHVhbGx5LCBJJ2QgaGF2ZSBl
eHBlY3RlZCB0aGF0IHRvIG1hc2sgb3V0IGFuIGVyYXNlDQo+IHR5cGUsIHlvdSBjbGVhciB0aGUg
Y29ycmVzcG9uZGluZyBiaXQgaW4gdW5pZm9ybV9lcmFzZV90eXBlLA0KPiBpbiB3aGljaCBjYXNl
IHRoZSBmb3IgbG9vcCBpbiBzcGlfbm9yX3NlbGVjdF91bmlmb3JtX2VyYXNlKCkNCj4gd291bGQg
aGF2ZSBqdXN0IHdvcmtlZC4gQnV0IGFwcGFyZW50bHkgdGhlcmUgYXJlIHR3byBkaWZmZXJudA0K
PiBtZWNoYW5pc20gaGVyZSB0byBtYXJrIGFuIGVudHJ5IGFzIHVudXNlZCwgZWl0aGVyIHRoZSBz
aXplDQo+IGlzIHplcm8gb3IgdGhlIGJpdCBpcyBub3Qgc2V0LiBCdXQgdGhhdCBpcyBhIHRvcGlj
IGZvciBhbm90aGVyDQo+IHBhdGNoLg0KDQoNClJpZ2h0LCBJIHJlbWVtYmVyIEkgbGVhbmVkIHRv
d2FyZHMgdXNpbmcganVzdCB0aGUgZXJhc2UgbWFzayB0byBtYXNrDQpvdXQgYW4gZXJhc2UsIGJ1
dCBJIGhhdmUgdG8gcmVhc3Nlc3MgdGhpcy4gSGVyZSdzIGEgcGF0Y2ggdGhhdCBpcw0KcmVsYXRl
ZCBhbmQgSSBsZWZ0IGJlaGluZDoNCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC9saW51eC1tdGQvcGF0Y2gvMjAyMTExMTkwODE0MTIuMjk3MzItMS1hbGV4YW5kZXIuc3ZlcmRs
aW5Abm9raWEuY29tLw0KDQo+IA0KDQpzb21ldGhpbmcgZWxzZSB0aGF0IGxvb2tzIHdyb25nOg0K
ZHJpdmVycy9tdGQvc3BpLW5vci9zd3AuYzogICAgICAgICAgICAgIHJldHVybiBub3ItPmluZm8t
PnNlY3Rvcl9zaXplIDw8DQpkcml2ZXJzL210ZC9zcGktbm9yL3N3cC5jOiAgICAgICAgICAgICAg
cmV0dXJuIG5vci0+aW5mby0+c2VjdG9yX3NpemU7DQoNCkhvdyBkbyB3ZSBwcm9ncmVzcyBvbiB0
aGlzPyBJIGxpa2UgdGhlIFNOT1JfSUQzIGlkZWEsIGJ1dCBJIHRoaW5rIGl0DQpzaG91bGQgaGF2
ZSBhIGRpZmZlcmVudCBmb3JtLiBEbyB5b3Ugd2FudCB0byBzcGVuZCBtb3JlIHRpbWUgb24gdGhp
cw0Kb3IgZG8geW91IHRoaW5rIEkgc2hvdWxkIGludmVzdCBtb3JlIHRpbWUgb24gdGhpcz8NCg0K
DQo+IC1taWNoYWVsDQo+IA0KPj4gTWF5YmUgdG8gYWRhcHQgdGhlIGNvZGUgdG8gc29tZXRoaW5n
IGxpa2UNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiBpbmRleCAyMWNlZmUyODY0YmEuLmRkNmNkODUyZDFl
ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiArKysgYi9k
cml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gQEAgLTIxNDgsNyArMjE0OCw3IEBAIHN0YXRp
YyBpbnQgc3BpX25vcl9zZWxlY3RfZXJhc2Uoc3RydWN0IHNwaV9ub3INCj4+ICpub3IpDQo+PiDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc3BpX25vcl9lcmFzZV9tYXAgKm1hcCA9ICZub3ItPnBhcmFt
cy0+ZXJhc2VfbWFwOw0KPj4gwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHNwaV9ub3JfZXJh
c2VfdHlwZSAqZXJhc2UgPSBOVUxMOw0KPj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG10ZF9pbmZv
ICptdGQgPSAmbm9yLT5tdGQ7DQo+PiAtwqDCoMKgwqDCoMKgIHUzMiB3YW50ZWRfc2l6ZSA9IG5v
ci0+aW5mby0+c2VjdG9yX3NpemU7DQo+PiArwqDCoMKgwqDCoMKgIHUzMiB3YW50ZWRfc2l6ZSA9
IG5vci0+cGFyYW1zLT5zZWN0b3Jfc2l6ZTsNCj4+DQo+PiBhbmQgZmlsbCBub3ItPnBhcmFtcy0+
c2VjdG9yX3NpemUgZXZlbiB3aGVuIG5vIFNGRFANCj4+DQo+PiBBbHNvLCBwYXJhbXMtPnNpemUg
PSAodTY0KWluZm8tPnNlY3Rvcl9zaXplICogaW5mby0+bl9zZWN0b3JzOyBmcm9tDQo+PiBzcGlf
bm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoKSBiZWNvbWVzIHN1cGVyZmx1b3VzLiBJIHdvdWxkIGNo
ZWNrDQo+PiB0aGUgZmllbGRzIHRoYXQgSSBkb24ndCBpbml0aWFsaXplIGluIGZsYXNoX2luZm8g
d2l0aCBTTk9SX0lEMw0KPj4gYW5kIGNoZWNrIGhvdyBJIGNhbiBtaXRpZ2F0ZSB0aGVpciBhYnNl
bmNlIHRocm91Z2hvdXQgdGhlIGNvZGUuDQoNCg==
