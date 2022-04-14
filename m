Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C3500BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiDNLIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiDNLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:08:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02866CA61
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649934356; x=1681470356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KU2GCADAa1rDGsWpQ1JCeNusZxfsrL1tflmczEC/0pg=;
  b=zeoCkrQpUFFOmn3utWe2R9Qe9BKndwi7OItNqLF1yNDsiite5DXxiFTE
   oMA8z2NtSbzxhqzwObhzCQZk7PHl2vUOq+F3/lxc8THxvO9L2a4PMaQsp
   BI1YRx7lrIKzpZmjQvLt0mNKOoeclY2vCU2mER6DLJz61aQn5r57IwjMc
   nNIhsndfZtzAYrxvxZv+tx6Zz2fGJCvRQGIDYSQxU0cBrZ0rbf8P7VuQm
   4/nFC/NM0HHn2no0Ac/BQcZ0uzGpBt2Q5ZoCygy2I9T8nbBKqMbYNU2ss
   QPdmNmfo3Exz9EFf4ClcM96NjwE8PvUay1O+tAE4KcnhN3XLKbiA6+uZR
   w==;
X-IronPort-AV: E=Sophos;i="5.90,259,1643698800"; 
   d="scan'208";a="160518258"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2022 04:05:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Apr 2022 04:05:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 14 Apr 2022 04:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLRMoQLjx+m74F4YIjL1xEAITWIuQWxero+MasuO4cWQI6qJq1IcGyvUmt73XnJcNNawIGpOLqPjqDQGiLdlL5prkZZSoGeSDWyTknJdkwTEONvXrO4cExoh84+qfIxY0VmuduUyt6Y4kyUIMou3WjzSDnUFnUVGtR0BJ184UqXOOPyoe6cB76GqbsNDAd9FcJgJGjCo/fDjuOsPhQOwZaKX+wEWiKwRX7bujG79o+8M4kNB2lxCJlEntgWy34EvApZDZaiIl3gguNkXaKbEjbfarDaHKsiHnOqJzuZ1xiUuLqIXD2w5ujTz1Y4JGbwnCMjBcQIn78enUxk45DtImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU2GCADAa1rDGsWpQ1JCeNusZxfsrL1tflmczEC/0pg=;
 b=IvK3oKRJsQ4KXLyriOeWgRY3AYrH4Mw7X5QCqLcSG9GSNzkyCxKFs1BN+iRWSQ/e+NsU4aTJzKNxzwN2MkovwULoMK1304IKz+nhBSssrGisIZEQSeGRbCbUYQ/iiGBbyMHpmSgrbmWZYhpaj7x8A8C4qvvUFbf1R7XNuKeOx+OK8wPudASyX9TzmA3lPSKMN9itZsxqPJlZEfT5kMRemHgu/htDBWrYEIgERVvWmwi8BatN+rUztztJMsdbmowHEbUUA8Yyj2OfTv69XVDUro7CbEhA7oLHQhZL41onEM1e4LOJnCeb9OuQMw9P0GdgMUWM5MO7nHMrlwFBSLh4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU2GCADAa1rDGsWpQ1JCeNusZxfsrL1tflmczEC/0pg=;
 b=LxL2FfD94IzDxnnGGABUt3M7sm62/WY+nN9hbffLH+OFchiiPD8fdMFJaNbXspi636awKNNK41pc1I70UpTsotRnlj81BDU49Tl60mVORxP28ogPRG5kesKY6BC4WsOGUSIVqgDfbvXC72iOVFCuXgdGubsDUr8Y6ohfb5b7Tzg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 11:05:44 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a%5]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 11:05:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
Thread-Topic: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
Thread-Index: AQHYT+Gad2GQpwhg0EOQ+Omlnxp13A==
Date:   Thu, 14 Apr 2022 11:05:43 +0000
Message-ID: <97558244-9757-82fd-209e-99f7ad8587f3@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-2-tudor.ambarus@microchip.com>
 <63b485a1e48d3116f8f49cc427049f81@walle.cc>
 <78aa1754-2f04-9f0b-72ef-f06535a413b0@microchip.com>
 <9867708d5625e5bf8f5f50c72385efb6@walle.cc>
In-Reply-To: <9867708d5625e5bf8f5f50c72385efb6@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d6a3246-bda4-4569-0b5e-08da1e06b884
x-ms-traffictypediagnostic: SJ0PR11MB4960:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB49605182E0C64168949A031AF0EF9@SJ0PR11MB4960.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vkqPpkOviy1l2uJfq+h1VciXp9CP7tKzgFutzE75Mj0L6/UzRVGPz+YP8/t5bLaa39Xl11WJDOSHfE78lZR762IBMJ5UOBrF2qZfwcRR2vSXuv0ha0KAe6hAGHghNCh7FhovD29k1T3WwJ8MfZI+3inUu8ti78/rvJdIlJ2qr0WnP1NyipD9vnRzDfPRutHPib9uKufCRAo01ox3ee1FrwYmPK9IPq0MIuZByoU+66S2+nAR8H8+xKkc3tq208pXEcwEVFngQzBbmCZwEuSVsn0sNH2yEzWjFrt94kO3yvo5WEox4PKnhL6wTRzp1LyqO0h3e5KCZPexd5hg1QdBuR2a49sEiFQWrPsmY2lg7RWnWGKRoUzZZg1QSY6Vb91IkUoDIxnFYjiTdcMX+zi0b0j/sCcvu+v9EYQm7NZWnD4XeoVj6mUtw/sn4PNj1t2SKpFCuStQDWZSa5tfCI0s1+H5/bbnDrLufSXKbz302kTpeEJXzi/KsZBPId8eDKOK4tQiZ1T3XPYiw11N6ED/QBjfG6emiUOkW744enwmjUR5oQWovwIxnnJc3iXW86crLfgBN/1UJN55P+3vZP7jmqYTPG0kCJkck4EBXtp2Ypnf/vF1dxonX/BjhooYa9Fb37aCsulppTVEzhT+vxLfOC9ALrCnDdWM3ywcl5w7ykwy1ATIZlQmtnGVM1+e44AlQoCCCs+v42g5KSUdAaFhwb+B78efkgJ18AlDrnMOGDew4IL/NevFlvzRIUP1IpHxItfhesyXjMoqGBb5AUaR8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(66446008)(31686004)(66556008)(2616005)(64756008)(186003)(54906003)(6916009)(316002)(36756003)(6486002)(5660300002)(2906002)(83380400001)(91956017)(4326008)(66476007)(508600001)(107886003)(8676002)(66946007)(31696002)(26005)(76116006)(6506007)(6512007)(53546011)(38070700005)(71200400001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VitNdWxQOG12THkyMjNNbHN0Q3RrNnF2R3h0aTZHZnpSTnBUT3ZXYWpMdlJk?=
 =?utf-8?B?RFJCS1VWZlRuUTJCUmNxRkdFeFlyaVdldGVyR3RlQ2NWNEE3TysxUlhlMU5a?=
 =?utf-8?B?UnoveHdKeVpOdmxQZUg3cXUvUVk1Vk9WS2dEWUx2WklQYlpRNDczdU5Oc0RG?=
 =?utf-8?B?UThVWll1ZUJZb1ZVck4xMUdhNHhUU2UyVGNGaEt0eTVzV1pGUVZCTlBpTFNL?=
 =?utf-8?B?dldEdTZWWGVCUkgydmYwWWxwZG5kY09Ob3pjTmF1c0RqWmxNbldFZEhrU20w?=
 =?utf-8?B?ZzRnUjNaRlEvQ0Fpc05wcVJFYTdodTdBSG1kbmdpNkZxaEtCemRIb2ZkMnl3?=
 =?utf-8?B?VWhwMWVYTHhldGRrZWE5SVNUSVRXZkdxMHdlbEc4d3VrMnpMTXZlZDZlR0xm?=
 =?utf-8?B?MmJBYU50ZjJyZDN1RzhFQXJaL0tjeVB4QnM1c0gxZG9NTm96VERmMjJmdnVJ?=
 =?utf-8?B?NTFxcmZyYTBZYk5kMDRUZlh1WmhQNjV1dm56cVdPWlE1YzQrRC9KS0dWU2lF?=
 =?utf-8?B?ZXRBcnFqM1hGWTZaK2M4MFlyTjcyaFVzV0VRMEVpN04yZE1jekptWnlQajJL?=
 =?utf-8?B?NHJQNXBmZW5ERHFUbXhNUlVleXdPVkNESFo2ODJuWjBLWEFpaUVaQVJCSkhZ?=
 =?utf-8?B?WkJYWWdZYzBVWTVaQThuYTNPczNBcmszRXE0ZEYxZFA2WkNVeXZkdUN5dlo4?=
 =?utf-8?B?Z2FIb3gwZ0RtQldvWlJTZWJlR0x3T2ttdGlUZGVBWDB3djdaR2ZqWlNka0Js?=
 =?utf-8?B?WTVhZ0VMNVU4NVhmamoxa245SDExa1hPRGlhWDUvbHZUN2hMTGVwUnVVVE1N?=
 =?utf-8?B?N0pGdDdXQm1hczVKT2J0dlJuUjZlcFo0RU9wTWNpSk5UTDJCME1VUFdVdWdQ?=
 =?utf-8?B?UzRxV0JkdjJOdGRwV09PZStITHJrbmNYb1hxOXA3eUNBbnRtS043U1Y4MjBx?=
 =?utf-8?B?VlJkUnFsNUJkZzAzbkh0R1VDZEhoU1lTTkREY1pVdSt6M3RkTkV6WHJBVXZv?=
 =?utf-8?B?cGl5WERHQmpNT01YOWdGU2d1Z2xzZUJlKzNZd3hYaDVPaDlnVEJRUXhRaUw3?=
 =?utf-8?B?MndLUE5wazB1b3UvYzQxMmJtanVGSHVoVEJLSEtOa2xaMEhSZW9pM1dVR1ZD?=
 =?utf-8?B?SmNhVHRjd0pVdGVwNG5aN0ptdDNnb1duS1FZNkJ1TnNZWnl6WjA2SWxDUndL?=
 =?utf-8?B?aGZMVXY1d3k0WmxYMFZreXp2SjFmRnEvdHIrUkZQTXduZlU0Tm9wNkh3bXc4?=
 =?utf-8?B?YXZsamlUTmF6RTluczJsRTNGMXprUkdvWTBVRjd4Rm42eEp4TWljZ25sd1cz?=
 =?utf-8?B?V0N3U09pczJwbUZnUVh0ZXdDdWRxcSs0YXhQNkhWdFV5cjdZSmZMWUpCZWJU?=
 =?utf-8?B?RGo2Nmh5dkt3cGFoR3RqaGFMc0dyWjROb24wMkRuU3I5Uk1nSXdYek00VFRU?=
 =?utf-8?B?VUgyUzIwcm92Rm5nSEtXME42SStzdEhqdWpFbDZXS3kzZlBLQ3ROTGpGWlpn?=
 =?utf-8?B?UTcwVGoxV0hvZTBqQlpRMUFaczJ2L1hOK1ZNOVFhbWttNVUzM0tFRVAyRHIr?=
 =?utf-8?B?RnM2NVEybThRWVIrMG9Ib2ZyeFhoMjE1UFRJdy83dXBpb1RCbXBjVkZ3aC9U?=
 =?utf-8?B?TkVnN2pndWhIOEkxTTFONUlXdXI3SEtaRkhOTmx2WXBmV0NENjQ5eHpucFRF?=
 =?utf-8?B?VmFkZGprK2VMZGRZZjlUbDB2NXlhaXEwTU9kUTZhY0Jwd1JxdmR6aFVRdlNU?=
 =?utf-8?B?aVd5TnprMmQwYmFXa2F1ZXFJcWdKSEhpQURGcmwyYzFjaFBJVHpqVTlrZWk1?=
 =?utf-8?B?WDJIZCs5UzZnbUFJcmsyOUhqcFUwSVlkdzhuMEtNUGNFQzR4RVJnRzU5RGlQ?=
 =?utf-8?B?TkF0ZmdVSkRQaXNwMlh4cC96WmV6dWFESnVBMTVKRnNtUjJZeFdtNjZtcC9R?=
 =?utf-8?B?ZmtYT0ZEWjFtaXdpNG1vZm85WjMrNVFvUTdwWVRyWG5iUDM4dHRtT1JtMGp6?=
 =?utf-8?B?SjBOYXYzR1VKa1ZIVnZEOC9NRXhDVmdYbjNNek1PQXNML25iSXUvVnUrcHlN?=
 =?utf-8?B?UGdpVjdzRm9xenllaElPL1N5amVBeTBSY2M0bWNPRE1jd25sQjdISm9JclV6?=
 =?utf-8?B?aGxZYUV5LzN2dldXdEdnd0F2dnpyNzlFeXNGTE5UQnFhZzFSMldKUE5nVzV1?=
 =?utf-8?B?c1pLTjd2ODZTTU1aNXkxRCtNd3poTlh3dzQ0amZUa2NpNEtKdSttTG5OOE9L?=
 =?utf-8?B?TUlqOU8rSVJVdWlycDFvMTFUMXhsSFpCS01XTzV4SFRXdDVjUzU4MVV1MEV6?=
 =?utf-8?B?WFhKU0pMVnNJdUpVSGRNd1dLRHAxNFA2M0ZJYnRTZ3JBdUNXL1BJbGxqU3Fl?=
 =?utf-8?Q?hoG6L0rO4xLwI0XU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEF5919837328345A783AA3D55AA55FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6a3246-bda4-4569-0b5e-08da1e06b884
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 11:05:43.9707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWfdp9ZfyrnTDAEkS3DDohVpxvaDOTGl8MnLaJRiTmEUcwcbQwT3TWag1cSXQHTUey/gyNdzjW70p/+mgl5XIav9GCaT4OOfZ4LDG51T2U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNC8yMiAxMjo1MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9zZmRwLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYw0KPj4+PiBpbmRleCBhNTIx
MTU0M2QzMGQuLjJlNDBlYmEzNzQ0ZCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9zZmRwLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4+Pj4g
QEAgLTQwMSw2ICs0MDEsOTMgQEAgc3RhdGljIHZvaWQNCj4+Pj4gc3BpX25vcl9yZWdpb25zX3Nv
cnRfZXJhc2VfdHlwZXMoc3RydWN0IHNwaV9ub3JfZXJhc2VfbWFwICptYXApDQo+Pj4+IMKgwqDC
oMKgwqAgfQ0KPj4+PiDCoH0NCj4+Pj4NCj4+Pj4gKy8qKg0KPj4+PiArICogc3BhbnNpb25fc2V0
XzRieXRlX2FkZHJfbW9kZSgpIC0gU2V0IDQtYnl0ZSBhZGRyZXNzIG1vZGUgZm9yDQo+Pj4+IFNw
YW5zaW9uDQo+Pj4+ICsgKiBmbGFzaGVzLg0KPj4+PiArICogQG5vcjrCoMKgwqDCoCBwb2ludGVy
IHRvICdzdHJ1Y3Qgc3BpX25vcicuDQo+Pj4+ICsgKiBAZW5hYmxlOsKgIHRydWUgdG8gZW50ZXIg
dGhlIDQtYnl0ZSBhZGRyZXNzIG1vZGUsIGZhbHNlIHRvIGV4aXQNCj4+Pj4gdGhlDQo+Pj4+IDQt
Ynl0ZQ0KPj4+PiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyZXNzIG1vZGUuDQo+Pj4+ICsg
Kg0KPj4+PiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UuDQo+Pj4+
ICsgKi8NCj4+Pj4gK2ludCBzcGFuc2lvbl9zZXRfNGJ5dGVfYWRkcl9tb2RlKHN0cnVjdCBzcGlf
bm9yICpub3IsIGJvb2wgZW5hYmxlKQ0KPj4+DQo+Pj4gTWgsIHNvIG5vdyBzb21lIGNhbGxiYWNr
IGZ1bmN0aW9ucyBhcmUgaW4gdGhlIGNvcmUgbGlrZSB0aGUgcXVhZA0KPj4+IGVuYWJsZQ0KPj4+
IG1ldGhvZHMgYW5kIHNvbWUgYXJlIGluIHNmZHAuYy4gSSB0aGluayB0aGVyZSBzaG91bGQgYmUg
b25seSB0aGUNCj4+PiBwYXJzaW5nDQo+Pj4gaW4gc2ZkcC5jIGFuZCBhbGwgdGhlIGNhbGxiYWNr
IG1ldGhvZHMgc2hvdWxkIGJlIGluIGNvcmUuYzsgYXMgdGhleQ0KPj4+IGFyZQ0KPj4+IHBvdGVu
dGlhbGx5IHVzZWQgYnkgdGhlIHZlbmRvciBtb2R1bGVzLg0KPj4NCj4+IEFsbCBzZXRfNGJ5dGVf
YWRkcl9tb2RlIG1ldGhvZHMgYXJlIGRlZmluZWQgaW4gc2ZkcC5jIGFuZCBkZWNsYXJlZCBpbg0K
Pj4gc2ZkcC5oLg0KPj4gSSBrZXB0IHRoZSBtZXRob2RzIGRlZmluZWQgaW4gc2ZkcC5jIGJlY2F1
c2UgU0ZEUCBkZWZpbmVzIHRoZWlyDQo+PiBiZWhhdmlvci9ob3cNCj4+IHRoZXkgd29yay4gVmVu
ZG9ycyBhbHJlYWR5IGhhdmUgYWNjZXNzIHRvIGFsbCB0aGVzZSBtZXRob2RzIHdoZW4NCj4+IGlu
Y2x1ZGluZw0KPj4gY29yZS5oICh3aGljaCBpbmNsdWRlcyBzZmRwLmgpLiBObyBuZWVkIHRvIG1v
dmUgdGhlbSB0byBjb3JlLCBhcyB0aGV5DQo+PiBhcmUNCj4+IFNGRFAgc3BlY2lmaWMuDQo+IA0K
PiBUaGUgc2FtZSBpcyB0cnVlIGZvciB0aGUgcXVhZCBlbmFibGUgbWV0aG9kIGFuZCB0aGV5IHJl
c2lkZSBpbiBjb3JlLmMuDQo+IEFnYWluLCBJIHRoaW5rIHNmZHAuYyBzaG91bGQgYmUgYWJvdXQg
dGhlIHBhcnNpbmcsIG5vdCB0aGUgZmxhc2gNCj4gaGFuZGxpbmcNCj4gaXRzZWxmLiAoQW5kIHNm
ZHAuaCBzaG91bGQgYmUgdGhlIGVxdWl2YWxlbnQgdG8gdGhlIHNwZWMgaW4gdGVybXMgb2YNCj4g
Y29uc3RhbnRzKS4gSSBtZWFuIFNGRFAgd2lsbCBldmVudHVhbGx5IGNvdmVyIGV2ZXJ5dGhpbmcs
IHNvIHdpbGwgeW91DQo+IG1vdmUNCj4gYWxsIG1ldGhvZHMgb3ZlciB0byBzZmRwLmM/IEFsbCB0
aGVzZSBtZXRob2RzIGNhbiBiZSB1c2VkIHdpdGggZmxhc2hlcw0KPiB3aXRob3V0IFNGRFAuDQo+
IA0KPiBTRkRQIGp1c3QgY29sbGVjdHMgYWxsIHRoZSBkaWZmZXJlbnQgbWV0aG9kcyB1c2VkIGJ5
IGZsYXNoIG1hbnVmYWN0dXJlcnMNCj4gYW5kIHB1dCB0aGVtIGludG8gYSB0YWJsZS4gSSBkb24n
dCBzZWUgaG93IFNGRFAgaXMgYSBzcGVjIHdoZXJlIHRoZXkNCj4gc3BlY2lmeQ0KPiBhIHBhcmlj
dWxhciBtZXRob2QgYW5kIGFsbCB0aGUgZmxhc2ggbWFudWZhY3R1cmVyIHBpY2sgdGhhdCB1cC4g
SSB0aGluaw0KPiBpdA0KPiBpcyB0aGUgb3RoZXIgd2F5IGFyb3VuZCwgYSBmbGFzaCBtYW51ZmFj
dHVyZXIgZG9lcyBzb21ldGhpbmcNCj4gcHJvcHJpZXRhcnkgYW5kIHRoZW4gaXQgZXZlbnR1YWxs
eSBlbmRzIHVwIGluIHRoZSBTRkRQIHNwZWMuDQoNCkl0IGRvZXNuJ3QgbWF0dGVyIHdobyB3YXMg
Zmlyc3QgdG8gZGVmaW5lIHRoZSBtZXRob2QuIFdoYXQgbWF0dGVycyBpcyB0aGF0DQp0aGUgbWV0
aG9kIGlzIGJhY2tlZC11cCBieSBhIHN0YW5kYXJkLiBUaGUgSkVERUMgc3RhbmRhcmQgIlsuLl0g
cHJvdmlkZXMgYQ0KY29uc2lzdGVudCBtZXRob2Qgb2YgZGVzY3JpYmluZyB0aGUgZnVuY3Rpb25h
bCBhbmQgZmVhdHVyZSBjYXBhYmlsaXRpZXMgb2YNCnNlcmlhbCBmbGFzaCBkZXZpY2VzIFsuLi5d
Ii4NCg0KU28gaWYgdGhlIGZ1bmN0aW9uYWwgbWV0aG9kIGlzIGRlc2NyaWJlZCBieSB0aGUgc3Rh
bmRhcmQsIGxldCdzIHVzZSB0aGUNCiJzdGFuZGFyZCIgbWV0aG9kcywgYW5kIGtlZXAgdGhlbSBp
biB0aGUgc3RhbmRhcmQncyBjb2RlLg0KDQo+IA0KPj4+PiBAQCAtNjA2LDYgKzY5MywyNCBAQCBz
dGF0aWMgaW50IHNwaV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vcg0KPj4+PiAqbm9yLA0K
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+Pj4gwqDCoMKgwqDCoCB9
DQo+Pj4+DQo+Pj4+ICvCoMKgwqDCoCBzd2l0Y2ggKGJmcHQuZHdvcmRzW0JGUFRfRFdPUkQoMTYp
XSAmDQo+Pj4+IEJGUFRfRFdPUkQxNl80Ql9BRERSX01PREVfTUFTSykNCj4+Pj4gew0KPj4+DQo+
Pj4gSSB3YXMgd29uZGVyaW5nIHdoeSB0aGlzIGlzIGVuY29kZWQgYXMgc2luZ2xlIGJpdHMgYW5k
IG5vdCBhcyBhbg0KPj4+IGVudW1lcmF0aW9uLiBUbyBtZSBpdCBsb29rcyBsaWtlIGl0IGlzIGlu
dGVuZGVkIHRvIHN1cHBvcnQNCj4+DQo+PiBiZWNhdXNlIEkgcGFyc2UgMiBiaXRzIGFuZCBjaGVj
ayBpZiBib3RoIHRoZSBlbnRlciBhbmQgdGhlIGV4aXQgbWV0aG9kcw0KPj4gb2YNCj4+IHRoZSA0
YiBhZGRyIG1vZGUgYXJlIHNwZWNpZmllZC4NCj4gDQo+IE5vLCBJJ20gb25seSBzcGVha2luZyBv
ZiBlaXRoZXIgdGhlIGVudHJ5IG9yIHRoZSBleGl0IG1hc2suIFNlZQ0KPiBiZWxvdy4NCj4gDQo+
Pj4gZGlmZmVyZW50IG1ldGhvZHMgYXQgdGhlIHNhbWUgdGltZS4gVGh1cyBJIHRoaW5rIHRoZXJl
IG1pZ2h0IGJlDQo+Pj4gbXVsdGlwbGUgYml0cyBzZXQgaW4gZWFjaCBlbnRyeSBhbmQgZXhpdCBt
YXNrIGF0IG9uY2UuIFRoZSBzcGVjDQo+Pj4gbGlzdHMgYWxsIHRoZSBlbnRyaWVzIGFzIHhfeHh4
MSwgeF94eDF4LCAuLg0KPj4+DQo+Pj4+ICvCoMKgwqDCoCBjYXNlIEJGUFRfRFdPUkQxNl80Ql9B
RERSX01PREVfQlJXUjoNCj4+PiAuLiB0aGVuIHRoaXMgd2lsbCBvbmx5IG1hdGNoIGlmIGV4YWN0
bHkgdGhlc2UgdHdvIGJpdHMgYXJlIHNldC4NCj4+Pg0KPj4NCj4+IHRoZXNlIDIgYml0cyBhcmU6
DQo+PiBkcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaDojZGVmaW5lIEJGUFRfRFdPUkQxNl80Ql9B
RERSX01PREVfQlJXUg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4g
ZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmgtwqDCoMKgwqAgKEJGUFRfRFdPUkQxNl9FTjRCX0JS
V1IgfA0KPj4gQkZQVF9EV09SRDE2X0VYNEJfQlJXUikNCj4gDQo+IEkga25vdyB0aGlzIGFyZSB0
d28gYml0cywgYnV0IElNSE8gdGhlcmUgY2FuIGJlIG11bHRpcGxlIGJpdHMNCj4gc2V0IGluICpl
YWNoKiBvZiB0aGVzZSBtYXNrcy4gRWcuIHRoZSBlbnRlciBtYXNrIGNvdWxkIGJlDQo+IDBiMDAw
MTEgd2hpY2ggd291bGQgaW5kaWNhdGUgdGhhdCBib3RoIHRoZSBmaXJzdCBhbmQgdGhlIHNlY29u
ZA0KPiBlbnRlciBtZXRob2QgaXMgc3VwcG9ydGVkLg0KPiAoSSdkIGV4cGVjdCB0aGF0IHRoZSBl
eGl0IG1hc2sgd2lsbCB0aGVuIGJlIDBiMDAwMTEsIHRvbykuDQoNCkkgc2VlLiBJIGNhbid0IGNv
bnRyYWRpY3QgeW91IGhlcmUuIEhvdyBhYm91dDoNCg0KdTMyIGR3b3JkOw0KDQpkd29yZCA9IGJm
cHQuZHdvcmRzW0JGUFRfRFdPUkQoMTYpXSAmIEJGUFRfRFdPUkQxNl80Ql9BRERSX01PREVfTUFT
SzsNCmlmICgoZHdvcmQgJiBCRlBUX0RXT1JEMTZfNEJfQUREUl9NT0RFX0JSV1IpID09IEJGUFRf
RFdPUkQxNl80Ql9BRERSX01PREVfQlJXUikNCglwYXJhbXMtPnNldF80Ynl0ZV9hZGRyX21vZGUg
PSBzcGFuc2lvbl9zZXRfNGJ5dGVfYWRkcl9tb2RlOw0KZWxzZSBpZiAoKGR3b3JkICYgQkZQVF9E
V09SRDE2XzRCX0FERFJfTU9ERV9XUkVOX0VONEJfRVg0QikgPT0gQkZQVF9EV09SRDE2XzRCX0FE
RFJfTU9ERV9XUkVOX0VONEJfRVg0QikNCglwYXJhbXMtPnNldF80Ynl0ZV9hZGRyX21vZGUgPSBt
aWNyb25fc3Rfbm9yX3NldF80Ynl0ZV9hZGRyX21vZGU7DQouLi4NCmVsc2UNCglkZXZfZGJnKG5v
ci0+ZGV2LCAiQkZQVDogNC1CeXRlIEFkZHJlc3MgTW9kZSBtZXRob2QgaXMgbm90IHJlY29nbml6
ZWQgb3Igbm90IGltcGxlbWVudGVkXG4iKTsNCg0KVGhlIGZpcnN0IG1ldGhvZCBoaXQgd2lsbCBi
ZSB1c2VkLCByZWdhcmRsZXNzIG9mIGhvdyBtYW55IG1ldGhvZHMgYXJlIHN1cHBvcnRlZC4NCg0K
dGhhbmtzLA0KdGENCg==
