Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4C74F7990
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbiDGI0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiDGI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:26:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9A6D3BA;
        Thu,  7 Apr 2022 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649319862; x=1680855862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3QWBHvzLf62YeCPn7xVhBkocDxg2S7c5WEBaqx1kM64=;
  b=fSpJfmCW+JaxrnH+JJnCy0ZGdvgMIOJf+ZcqWaCptOOwqFcz/3XEQGVh
   aPGyV4Lg6KgfGtQK4LgePlmt9oIaQPt28YYT+Tn3DG40GpNF0uvZetRh9
   0lhyUz2ikb8/fNChUWOrpjP/Cc4A+PePmDIHhcJ/Vh5qWAq5dpkxeCm/A
   4vLN1jB6HpxB81cESD2J5KLS3Uowz3/W501L5xQLOmeqhmz5ZiXHWKMIe
   mR1vI8hA+SGRnB3HPdVXd41psvm8ft4xQRnwit77GKEmjk7zE+NQTab/5
   3v5NizLzj2eMfV5qUOpIycGfHwCCunnZQ3eq3NILWmCbDndRCCy0PJR6J
   A==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="154740648"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 01:24:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 01:24:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Apr 2022 01:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6ltwtP/qKV4eHhxfmY8kol5/415tCHr/nGhS3Lq10rRI6qtwo+UZBmlUd5WraxE5sm7B8VILMZX1fpt+0gyCTt3yYUF29C2qxSBIA1oPRV9h0mCi2Snr+s9+6A+4dzXAGdl7EuSICGya/pZPXUbwD5dPw+mva5P7g6DaFGDmModbzKK6pnMI01pypcrIzSpKPC+zx3EUPzcCvtgoUMHhOjuC5WgcpAfbvnn9yGGQNZWkNe2lYfFVVR4TbkbieALfkcjHMWbVaCXqUWLJi9LYUYUjArjiVYlVug53vnmRpN2JxW2e28SjyyXiqSp6WnSzPGhCO/VD269HGfjzri6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QWBHvzLf62YeCPn7xVhBkocDxg2S7c5WEBaqx1kM64=;
 b=X0cETLkrougFd9xweoK/eF98kd850oc6r0MMn3vsGfu0rh4qQmhlzeuiS66VQiac0haxkvlXfYVZgwbb2CqLi3NoUJOuL1oZS6TQILgb4Vx0m2ib4tX4jOoj9TbyISQqOLLToNW5VxrSg2KKRVXzC0QhaB9sxR17k4nb3bXEHrSKyGl/AhUW3ECw4kbuNr+Y5Qemz6wh0CNcboRd2ihYeLieTCXuVkokNyILQwN6PuXDSy1OmYLVu9PWK1NF1cg/tMA72GhEutAyN7G2clxdHL3EbjAjA2KmR8Wv4wnuRmwO57DXuw+7DXTtvd2gKHPzr3gT4jYMwqVwor6UqBQn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QWBHvzLf62YeCPn7xVhBkocDxg2S7c5WEBaqx1kM64=;
 b=CbI0v+qk0/ghW3lw5BtK2q9A9cL8F6nxoFP9Ysof2AkrDmMcQkbeOzgoIxIE+5YRGXq4F/23hBFZXyylbxEZb6HpHrr7SLCDyMLoLNc3mtCTWxtr7pqGHFeyN2SzgTQmjfo31rUGsFPknevbjLUA3SyAbVGWIK69p4OmbJU0Pw4=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BY5PR11MB4069.namprd11.prod.outlook.com (2603:10b6:a03:191::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 08:24:19 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 08:24:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <Nicolas.Ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Mihai.Sain@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the
 QSPI0's HSIO and PCB lines
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the
 QSPI0's HSIO and PCB lines
Thread-Index: AQHYSkhvqPPZ9iBRZEaUnnDvnC7rzQ==
Date:   Thu, 7 Apr 2022 08:24:18 +0000
Message-ID: <f14a0b1d-d144-edaf-93ee-5b5bea1ccc48@microchip.com>
References: <20220406130505.422042-1-tudor.ambarus@microchip.com>
 <8f778b95-d68e-6575-ff8b-f1dd8d4d8777@microchip.com>
 <515d14f2-1a3f-1bfe-93e7-2baafc45ce4f@microchip.com>
In-Reply-To: <515d14f2-1a3f-1bfe-93e7-2baafc45ce4f@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f69eb40f-fb4f-4862-acf8-08da187002f6
x-ms-traffictypediagnostic: BY5PR11MB4069:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4069DCDD50F741218200515387E69@BY5PR11MB4069.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLib6lKH+psO05QXCJ75amlQHLHnGMcg7nO609p87Y8pQHA82r2891n71VQajGkT5g/aPomNb8j6+aI5+DPEDlhuj7+hkL/SV5HvBoSg5Gfznm1bAr9JQbqd2laQLo9d0IAZPmuQLc5fP9zRJimF12aB8oCKLRMQtQs6VJw5cLJQ5tqPzODIwAewKW14kEcHet4aeSKPXQQniKLLLXbmDHo0Z2a034olbYJDDVJvsATLfvzYihazHvlrMuQgVZxqJYVD7X1T8Gu436nJrue+PuR/nqmo5XC8FnclJfDihL/tvhsMVpuFFzn2Y/MGT65ek5sXf3dzY2dsYHuniDYUJpxFb22DmcR0KFu11QMuHbhL41sr2zpxI70hv5eVfQNdLz/Y4kfK1HeaDZX668QddQXZcF3Y/SEav3EG95Bg8vwr+VI9DXw1yF3t/wg+G4tOvyGXJ9KHPpgICfz8hbOAvAvSVlZw/cDTiRGWkkwi+UXIMWG4pC3wky8gzdQxZIDUrjgZb4VKn0gQT0/ANgyAVTk3KqJ2gxnO3uIiKMX3v+h2XSQlWG+m21bjp8rhUd6gjh9ZZhIlPvrIh8N61ScSAKHH/8ZGo+8EPxQkB6GxrWpqKiYZ1FkTa0xWHWBOeajBUt5OTjaLGx5NeghDQGpugfgFSI6UXLe28NEcNGTdnCiCqSDX2923JlFSo+kF3zuaUS7i4lsWrzoRzL8vMi8z8Vx3Saw5KUzLaU0E2ZP9ff5zKASNvD6NWEJCOGO0Kt4X40uEvFYSURYxNU6gnEHVjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(36756003)(38100700002)(38070700005)(6506007)(122000001)(71200400001)(6512007)(53546011)(6486002)(54906003)(110136005)(508600001)(6636002)(31686004)(2906002)(107886003)(5660300002)(31696002)(2616005)(26005)(186003)(86362001)(8676002)(66946007)(8936002)(64756008)(66446008)(66476007)(66556008)(4326008)(83380400001)(76116006)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3RWak9TcW9VcWY0SldUTlhsdmpuUktVVUVmVlB2YmlZb2xFQUJ5M1RUSTgr?=
 =?utf-8?B?TWlSVGZLQlBFSTljSlNHL3RXRFBVS3kxZkV0OFY3cUJtM0pVL2FBemlGVmV6?=
 =?utf-8?B?S05LNE1zWW9NTTNmYkNUK1Bnc2FMK3FKcmE4RzRhUVorTXNRbm9rVkhpelA0?=
 =?utf-8?B?aU5vY2tGU2NTWTU2cUJTYkdhb0l3Z1hKRUk4ayt3TDFmQ3FXbVNjQ09jQ1Uy?=
 =?utf-8?B?cEYzOGh1eGZsMFcvOGV6QUh5ZXJzcE5KYzRkVXJ6TmI4VkdwTVZzeTQ2V0RC?=
 =?utf-8?B?ZTEzd2JEYTBpa0I0ZkFiWEJXdEkzdWo1T3Zwem9yaVl4TnJSNXFzSEVGdktI?=
 =?utf-8?B?eHltNXJFVGN1WStuZnFvQ25oN0JPL3VWUXFzMGU2bG5XWXdFSVpqRlhrVURL?=
 =?utf-8?B?a3B0cVdXd2xTNmkwZmF4WW1KdkFTU295aEMvZWxBWnlxV3E3cEpTQjY5K0NX?=
 =?utf-8?B?UFBTY2R4eU9wUHdXeVBGaHc4djMybTZ2YVlndW9EdmJ4allQRTJRVGRxUTNs?=
 =?utf-8?B?Slg4MHBmR0NlTkE4Z3QxN0dsQ3oydkd3Nk9jbndWWVA2R2paNVRodkYzQnhn?=
 =?utf-8?B?NUMxUTFvVlpVN0R0YjdsNnMzcFg2cUZOZ1FqMFV0bGgrK1MvU0FaZ1pRbmpa?=
 =?utf-8?B?Y3dyM0pxV1ZGOTc2Y3hiUWZPV0xJS00rU1ozUWQwaFJVNXhNZFp0bHErbFc2?=
 =?utf-8?B?YXFsZXJCVENINmFockxtYzlTc3dsWnZibXYveHJxbnN0SDY4UHVIRHB5TFN1?=
 =?utf-8?B?MGRsYjlabGFJTzhuVng2Qlh2SE1LbURHZTJnMWdrZnRMaWNybUR2ZVRVM2Uw?=
 =?utf-8?B?N3lHV1FPdi9sRU41d2k4V29xUnUwZ211Q1NCNkU1VVQwOUxTa0tlNXZMSjlp?=
 =?utf-8?B?RlZQaVZ3d1RheG1qNEM0Y3lrSFA4cmIxa0oyU0ZmU0xUWXN6QWVGRG16UC9T?=
 =?utf-8?B?WVNJQWRsL3N6aENTODhPSTJEWXU3bmJVeko0cXBLQ2hqcWtTajFoaWFYUjdn?=
 =?utf-8?B?aFdNVmtxYVhaQVdQblM4Z1lmVnZVY0FsZnNMRnk0SThhUzJIdkNWSEl0MVNI?=
 =?utf-8?B?a2MwRGFKbHFyS1JjclNydG1NdXM1aldzV25wOFB4dnZWbXJTQWpzdmNSaGJY?=
 =?utf-8?B?Mk5iZUl2WldsbGxKNXNHa3RYWkxkRUhsQ2F1NThSZTArUFRRT05oZzU1cUVi?=
 =?utf-8?B?VkRjTERDOEVyOVZNTzV4OFBKTnM1bmlpd040UlFReTYzL2FaOVA5UC8ySndi?=
 =?utf-8?B?M3p5SXpDVWpvME53bTlKbkVBTTlkTkpRcFFBWnpyRHpDZkJZTjRYVGhOK0RN?=
 =?utf-8?B?aUVibmp0bER5a3dlR050WGxrRytyUVVESUNVaGtITlpBczZsa3VmOVlyak9U?=
 =?utf-8?B?OVRzNU9rcXZpeHM4K1Z4S1JpWEs5VUI0L0pJTklDSzd0UTZhYkc1TUlXTmc4?=
 =?utf-8?B?MjJqaXg5TnZQcWhqMWFEVkJQSFBrMkRjZG5FV0RFN05TMUZIYXV0UFhrbjE5?=
 =?utf-8?B?eDVYMVJVbDNMNW5qWDVTc2NhcWg3bU1xQ1hnbnZZcUhmWFd1dk5mdGs2MjhM?=
 =?utf-8?B?VGF6NU1iQXNqMWxsS3RUbURnTkpXN3RsYk9laHNGV0oxdVA5LzNQQzk4K3dj?=
 =?utf-8?B?ZStlZ3VuZXk1bC9RTzExTUw0Zk9ZVWM0b2tNZzBKTTJ5Ukd3ZENMa3M3SkVx?=
 =?utf-8?B?VGxhb2FnbXNKZkw2SVFVeUV5cm9tVk9ObnJ3S2NLa0xQbWxPSVluY1hJcDNE?=
 =?utf-8?B?QUJFU21TbnI3dWNwc3hDbEtqSURQRVlHdXk3NVZ5TjBCNWpNN2dJRkJHbmVT?=
 =?utf-8?B?a2ZjTHB1MGZoM2p3U0VrUHB5Q20yZmlMcklBeG4wVWlWRCtTeWJPN25PekpB?=
 =?utf-8?B?azN4RkZlM250aFZ1aDU1MVBrNUs3NEpPempZNjRWbDRJYXRsMmFhbU9MamFH?=
 =?utf-8?B?QlNhcXkyVWRkV1psWGpIN0NWL1NiSlRXMWphZ2F4NjRoenNMakpXRFdGVkZt?=
 =?utf-8?B?TG42Y2k1MHVCejJDeFNzdzlTamN2a1BLby82dk1BbTZmcjJqV3J0UDlZMnFP?=
 =?utf-8?B?WHhObG5yRFowS1VuR0hTa1A3bHEyUExCOHVSbXhnd1lsaVFuZjcwTktXd1JW?=
 =?utf-8?B?cEpKZXNwZkQ1WDd6UUh6dEd0bVlEV3paVTVIUVZqK0owSmxLeC9MZE4rK2g1?=
 =?utf-8?B?cysxNXF0SXFrNTJYemhnZEEwQ2hxcWh2QVh4a0RPeTd1dnB1cHB2VklBQkIw?=
 =?utf-8?B?SVAyaFJOQzQ3RWhMTEZ1QkhzRllJQmlrSHVrZW1sY1ljYmdSNEZlVENPWWJu?=
 =?utf-8?B?M3N3QmN3dHRWOFBDRGVqbG9vcjlISFM2NVIwQThkL0xGYkFHanV3MzJUQXRL?=
 =?utf-8?Q?Z+sNvahxStSFxUIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63489E1E31C73945A2E352B7FF070083@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69eb40f-fb4f-4862-acf8-08da187002f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 08:24:19.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sws0Yz2q0WoruvMMg1jNUMRtsNTAIo9v3bo1AfOCcf4K8bfbWCT1w8s9+wHvkSyc79s3TXP2P35nXRE39jwY1rxubzgMzIuxcT+JGP34cSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4069
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDQuMjAyMiAxMDo1MSwgVHVkb3IgQW1iYXJ1cyAtIE0xODA2NCB3cm90ZToNCj4gT24g
NC83LzIyIDA5OjI2LCBDbGF1ZGl1IEJlem5lYSAtIE0xODA2MyB3cm90ZToNCj4+IEhpLCBUdWRv
ciwNCj4+DQo+PiBPbiAwNi4wNC4yMDIyIDE2OjA1LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4+
IFRoZSBpbXBlZGFuY2Ugb2YgdGhlIFFTUEkgUENCIGxpbmVzIG9uIHRoZSBzYW1hN2c1ZWsgaXMg
NTAgT2htcy4NCj4+PiBBbGlnbiB0aGUgb3V0cHV0IGltcGVkYW5jZSBvZiB0aGUgUVNQSTAgSFNJ
T3MgYnkgc2V0dGluZyBhIG1lZGl1bSBkcml2ZQ0KPj4+IHN0cmVuZ3RoIHdoaWNoIGNvcnJlc3Bv
bmRzIHRvIGFuIGltcGVkYW5jZSBvZiA1NiBPaG1zIHdoZW4gVkREIGlzIGluIHRoZQ0KPj4+IDMu
MFYgLSAzLjZWIHJhbmdlLiBUaGUgaGlnaCBkcml2ZSBzdHJlbmd0aCBzZXR0aW5nIGNvcnJlc3Bv
bmRzIHRvIGFuDQo+Pj4gb3V0cHV0IGltcGVkYW5jZSBvZiA0MiBPaG1zIG9uIHRoZSBRU1BJMCBI
U0lPcy4NCj4+Pg0KPj4+IFN1Z2dlc3RlZC1ieTogTWloYWkgU2FpbiA8bWloYWkuc2FpbkBtaWNy
b2NoaXAuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFy
dXNAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBJcyBpdCBuZWNlc3NhcnkgYSBmaXhlcyB0YWcgaGVy
ZT8NCj4+DQo+IA0KPiBJdCdzIG5vdCBhIGZpeCBwZXIgc2UsIGl0J3MganVzdCBhIGZpbmUgdHVu
aW5nIHRoYXQncyB3aHkgSSBjaG9zZSB0byBkb24ndCBhZGQNCj4gdGhlIGZpeGVzIHRhZy4gVGhl
IG1lbW9yeSB0aGF0IHdlIGhhdmUgcG9wdWxhdGVkIG9uIHNhbWE3ZzVlayB3b3JrcyBmaW5lIGV2
ZW4NCj4gd2l0aCBoaWdoIGRyaXZlIHN0cmVuZ3RoLCBidXQgaXQncyBiZXR0ZXIgdG8gYWRqdXN0
IGl0IGFuZCB1c2UgbWVkaXVtIGluc3RlYWQsDQo+IGluIGNhc2Ugc29tZSBvdGhlciBmbGFzaGVz
IHdpdGggaGlnaGVyIGZyZXF1ZW5jaWVzIGFyZSB0ZXN0ZWQuIElmIHlvdSB0aGluayBhDQo+IGZp
eGVzIHRhZyBpcyBuZWVkZWQsIGdpdmUgbWUgYSBzaWduIGFuZCBJJ2xsIHJlc3VibWl0Lg0KDQpJ
dHMgZ29vZCBmb3IgbWUgYXMgaXMuIEp1c3Qgd2FudGVkIHRvIGJlIHN1cmUgaXQgaGFzbid0IGJl
ZW4gZm9yZ290dGVuLg0KVGhhbmsgeW91IQ0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gDQo+Pg0KPj4+IC0tLQ0KPj4+ICBh
cmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdHMgfCAyICstDQo+Pj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2F0OTEtc2FtYTdnNWVrLmR0cw0KPj4+IGluZGV4IDA4Njg1YTEwZWRhMS4uOGY5NjQzMTcw
YmEzIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0
cw0KPj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cw0KPj4+IEBA
IC02NTUsNyArNjU1LDcgQEAgcGluY3RybF9xc3BpOiBxc3BpIHsNCj4+PiAgCQkJIDxQSU5fUEIy
MV9fUVNQSTBfSU5UPjsNCj4+PiAgCQliaWFzLWRpc2FibGU7DQo+Pj4gIAkJc2xldy1yYXRlID0g
PDA+Ow0KPj4+IC0JCWF0bWVsLGRyaXZlLXN0cmVuZ3RoID0gPEFUTUVMX1BJT19EUlZTVFJfSEk+
Ow0KPj4+ICsJCWF0bWVsLGRyaXZlLXN0cmVuZ3RoID0gPEFUTUVMX1BJT19EUlZTVFJfTUU+Ow0K
Pj4+ICAJfTsNCj4+PiAgDQo+Pj4gIAlwaW5jdHJsX3NkbW1jMF9kZWZhdWx0OiBzZG1tYzBfZGVm
YXVsdCB7DQo+Pg0KPiANCg0K
