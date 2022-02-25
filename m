Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B284C46AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiBYNh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiBYNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:37:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F85EBF2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645796211; x=1677332211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7V3ggF1yBSXwMiX4Q/wRXsifU8BBIRHjqwi4cg3s8cI=;
  b=rOZlZ1nuevZ4BrxCvfVxHeIu86/p7I5R/01mD4k1VfQOma0Wab00sywB
   h7h+XPLfJB1lLdcuRfTxHxAy/jYQBOUvQBGzxXM4Nt6hGQFobI27Mw2Ya
   ykbtGruBPrTyJmzCjjIKHCAkikpcb77qoloGj1IsxE6EIWxShrWtAOt4a
   tR6m8vk+KiIeQ6vmovYOGOf0wai07gm3Vnctr98Q8IzdIH72CLoOKpQux
   1L6MeMqY9sGrEeJ9sklMpMGtocYQOb1lEhZAT/KMinu96qV1MECZ+qt5X
   dZizqOrQny1cSwSHaqDTe5D6Lg5zwWAZPInPQSZEq2CGSRIh9RTIzyKKO
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="154414921"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 06:36:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 06:36:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 06:36:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEyT7/QtwsFh9TSjbcJa0PA4lcpfvEsVj5j9xuPqM9lmBUj1L23rq19ulRQXgmE+C+RamEb0Fc4Ycekbm2ksRf7pHVY20Yk31pCq4pORg2TosCGdi7EKPCmYWFaJrPnIWFvf9mlEaKMuyI2ALwzs4ZfdnGXiWcIEoi+5N6nX/vB9ByP+LaeysagnYIeRk+jyA2T9dHwXbz2ZmVZaLhQ6OoEAzFP2ZpfiRmnpiG9II8T78A8QOkh0mRCUbsaGycLPyp+yONgd3X1+lsdoOPNGXf8g8VeUTw0bJHu0zgYQ1lqDZUTC0hvhyNPnn5/qe+p8Pt+cqlMyY5XOQNwA2pHxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V3ggF1yBSXwMiX4Q/wRXsifU8BBIRHjqwi4cg3s8cI=;
 b=RFeGrFWqo0Pex+NqrTmLta0LZIDlNPHEb0oqz5qLv8dvGXbjbTWoOi+Ym4zAE4kqO+TKMnAJNCuBc+6cLi17UI3igz4jRi52BMA1LyeqnHt0fj2aIbIGd+YOQ02vETznCTZXynf8sH78PHZAr3Q+YgGB8jlMIZ6tqQqfUNQJxIAoe5/GITdbOBnqNcmGRKf6foNS7vJwrCpqbNkqu6jG/dOqQu5O8kBB9JXnKR/HLM670O+9Rf2LwxerOMqqIBdQTCfzoNQqS6RlAEnx6k9tATPWAP9eTJbduyHK74KeXQsR2HWtG6HlriJHK4oy3r8Tm1F+RdnIz/d3B/83UIGa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V3ggF1yBSXwMiX4Q/wRXsifU8BBIRHjqwi4cg3s8cI=;
 b=BezevGkEG6Vp7O2+KgFEP93dPVEWJh7rypujNGEaWDvRPm/htUJfPz0tYwvKDo9XymuhYzMCW3thoIA5VPJmlLNekF5bhUtO1/Q1ox9a69n/IXoKeErif4HiMAAC20Du1MCP0b+5OmGJllbuU4LMKH97GmHea1lEwUw7NvSahck=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 13:36:48 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 13:36:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 11/32] mtd: spi-nor: micron-st: unify function names
Thread-Topic: [PATCH v5 11/32] mtd: spi-nor: micron-st: unify function names
Thread-Index: AQHYKkx/rOWxu2o8UkShyaiFUyzsraykROAA
Date:   Fri, 25 Feb 2022 13:36:48 +0000
Message-ID: <5becc6cf-5931-5206-70d3-a643245de4b3@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-12-michael@walle.cc>
 <5c2ba6a0-a06b-d4dd-d503-1ddfa76f9be4@microchip.com>
In-Reply-To: <5c2ba6a0-a06b-d4dd-d503-1ddfa76f9be4@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ddad2a-d71f-45c7-fe0f-08d9f863df99
x-ms-traffictypediagnostic: PH0PR11MB4822:EE_
x-microsoft-antispam-prvs: <PH0PR11MB482287A3125B97D4D27FBAD7F03E9@PH0PR11MB4822.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNAso4zPKm6rsrV1zpeG4WXvtqQTPyCRQ89ZGq/d9de01vjA9T6WRnWPNKuc2pIafe95asHosd35CeXDwAzUX0Vuy15M6SfFlE6RiWlY6Udqc2Ok/L6sQQN5hY8gszOwApTbrEldYZ00dZ/nUE8doqtGX0/FYK53aUJ3oBBUNWFVyyNltqZY+m2F8peIOBvRELC2gDsOlwcMhl3dOcnNqVSD5IlvPzfI+FYgp2H5P9cCZR9Lfx6Eskm3jM0E5RQZHI7TquL6hGfNzajRBYT75E42tKKEkmCAEuNqHCCHBhfA7vupFZYFvkubdszqz6RkFfOiR1GY9dxMbp6kSmfD1QcFqfPg2mPtzMVpwdPIr7i2+hENynG6+vTF1++snG/Z1wmHi07MutA7ZIxoOjmoSKNOAsf45V+MLyPS3CWWshO8LWAEB5SbqF1prww2N+0lLNV/RBWlQLbIAX3ohibrbDgSmiMujkarIr/Y4OnpG4E/46xwIdj8NAK4hrrs4sjLXX1Yl2rTZJ+nU1gFOYPSYz+hspdMWPG/II/5XUrSx5tklifcSxC5l3dzkSw/5qzmsT8PLI+iM+PYzfq6CsfQgee1qqfEiKWS9b6ofS7RemIQU3pEFNjeCSA9asjBFDmXPW9tz1XUCK0ttWmarLrEMuLjvnZNgdU4fnNo8dndBZHv7E0RkI14lehZD3HqcEjyKGUNMvjjD2jrZHPd+DumHf09rHsTlHaIad1WGE4j6zwtuHnXWN0KGFGrPOVEXG2aGj6aebzsHyTvxctKerRVNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(54906003)(110136005)(31686004)(316002)(6486002)(38070700005)(26005)(31696002)(86362001)(36756003)(8676002)(6512007)(91956017)(66946007)(4326008)(71200400001)(53546011)(76116006)(64756008)(83380400001)(66556008)(122000001)(2906002)(66476007)(66446008)(6506007)(38100700002)(508600001)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3d1Qk03aU1FNWFnTkJmTi81RWhiRXUyYUZZRVd2OWJuU1NKeWo3OWk4ZXpw?=
 =?utf-8?B?RWhKUjNMZEZZZlNYVktkVThHek1EOUFPeUFKTlc0Y2JMNHJnS243dzJ4WWhP?=
 =?utf-8?B?WEduUTFNYXJNMk9yOG9lOWU5ODlqOEZOU00vTm5wbDNMZS9CVFZsQ3NacE45?=
 =?utf-8?B?Uy9ydDdkb2NnclluMVhnMktUWjM0NXBibHkwT2tMMGxJMXVLRmVMSkswZHVz?=
 =?utf-8?B?V1Rka3krU3EvMDd2VVJCZjBmVXgvc0UzcGFSeHdvVFlUT2owZHZiYjAzNTdo?=
 =?utf-8?B?ZDFkVFFDWTkzV3FqT3VIa2svdHlHTmx6KzNkK2xGQXJkMkxVTXczdmJMcDQ4?=
 =?utf-8?B?Mm1xOTNxUHZrMHFjL2xGR0kzZVhURjYxMnYxY0VTWHQ5VGdKYXhENVlCR0p6?=
 =?utf-8?B?ZVpZYzllRnRpN2xFWFdWbzhaZzRtTElmWjVpeFE3UFhvOGo3enhLNFNlT1F3?=
 =?utf-8?B?cDV5dEhFRzhxbithaFNQR2NzcFV4VjZwVWpqKzR4TWlJenZsd2l4eXpYbFlq?=
 =?utf-8?B?QkFPaEcvZG5pYXV6cC90TVVwaGRsUDA5UXFHRzZnbjFLdVl1RnRuTU5DbnJa?=
 =?utf-8?B?c3JLZlUxUklMNk1rN0hsa1llbjcrQmxDblAvemtZL3RCSU1makNTRGNkeDZR?=
 =?utf-8?B?SlhIWDZzRDk4WnlhUlhwYS9IZ3g1T3ZkOUsxd3BHR2ViL01QYkZ6b0VLME92?=
 =?utf-8?B?ZklraEhQbVdhMUVZdXpiN29DRVd2Y29aQWZ0RnJvUHJHZFFQMUxySXdyQitk?=
 =?utf-8?B?aFNub0ZFeEY2MXlQRmVTZERFMmszWk14UEdFb3FKcnliVUpTaFdrRzUzdWZu?=
 =?utf-8?B?djdnU1VpUm1CK1ZOTnh0cjFTQ1BwVWMwNnNKSEJpNnA0TENRZGN1TG1PZVNX?=
 =?utf-8?B?dHV1QjUrV2VqcXJDRWRaZUxTa2tvMllIYW9BT2dZMitpSmw0c1NWcDZYMmZi?=
 =?utf-8?B?ejd3cjY3bGtDdkhYODNsNCt4NUNzRENNaG01YVN2dTdrdmYzUDdtcm85NFVw?=
 =?utf-8?B?cE9xVkY2ZEduTGcxam0wUTFFL3JBY1ZkRjZQdFR1NUVPMmptME00N1prU25i?=
 =?utf-8?B?aTAxTFlPZk5MR2hSVmRrcndlM0ltTHg1STMxU01VMjZmeVBWSUp4L3RsWGNm?=
 =?utf-8?B?ZVlmditQUmJHMFZTUWU3N2VSLy9tRWFZcEJPZWdTSXdBSWhVK21tYzhNTXMv?=
 =?utf-8?B?VmxFSTl3N25UditFQVNwRG9vUGh5TzZKTGIxQWxwZmtPSERoWEpESVBUbk1p?=
 =?utf-8?B?MEErYUdRWktKektCb0xBMlgrTmFoK21XeU56SklPbVYzMU03eEF0ZU5tWTBX?=
 =?utf-8?B?UEJnbUxDdzZMcjAvSmhSOVJtK2RHWTF3UVdYRVpZNVY0anlVbzIrZmEzNDlE?=
 =?utf-8?B?b212aUdQbkxVZkdXNjhwSS95MUxCSFVicWwwTkh3RUJtSGcwd0lQOFl6NHdm?=
 =?utf-8?B?OVpIYldhTzRrZUUreXVpallwZ1BWUnBaVS8wN2hZOENWVFFISThNL3Yxem54?=
 =?utf-8?B?ZmtURnZwK2lJeEE2ZFYyaTdPZjQwenAxRWtobmFsbXpyQVZtT3h6OE5GVWNt?=
 =?utf-8?B?c3pDOXBSOHBoL3B0ME41VXFhM2FESmNTOXpJU0h5ckd5UVd2c1lTUDNyQkU5?=
 =?utf-8?B?MWRBZ3JEMllmK2oxemUvQnFIOGZnTDdtQThocG9CeU53MEJUN0hBVVRtaGlm?=
 =?utf-8?B?Y1FjcitxRWhTRlJhS0tZZEU1T21kY09hV2NTQ3hJSjFqbEk1aXJqYmR2aHhI?=
 =?utf-8?B?MlhxN0xBTDI1Ukc2QytsdVNma0FneGpNcndvOVp1cFVZWmtEeEFudVVQenFK?=
 =?utf-8?B?QW1lNllpQ2RqajBYQ2k3ZEtkQzhuaGJ0TUs5MHJXZitRMmtBNHY4cEcvM1M5?=
 =?utf-8?B?SXJ6aXYvTnljYTZjVmpjdThOa3pLTDdlaThUUW96NDJka0Jua1lZSGVObSts?=
 =?utf-8?B?QTVWempkaGxEN0FhYW5NWkpsV21uUkdoeW5zVFhYeDl2ZXh1VVphRVJOUHIv?=
 =?utf-8?B?VmIwbzZ1MWs1UzBqbkpBM0xOT3AxSXk3VXpOZkZkVG1pVDROM3ZMVm1icXRH?=
 =?utf-8?B?alNvMkFQOFRxT0J3N2M2L3ZtdEJUWmxSOVJVNDh0TzBmOWcyTllvYXkzbzhr?=
 =?utf-8?B?dW4zRGxjclpvWUI2aHkrMDNxSzVLajJHT3g4U2NPYXVYQ1ptdTI3ZkhveVRW?=
 =?utf-8?B?a0I0ZjY1UWVDVWdmbmVzUGZYT1RSaUQ0Q0VuWitQeW5QemdMN2RlNFlybkxN?=
 =?utf-8?B?ZGtpTDF1VjRCeVNRNjhOYWYwVmVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C54C662CB94745BD3C6D6039AFAE18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ddad2a-d71f-45c7-fe0f-08d9f863df99
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 13:36:48.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xE0szrfjo2rMgAonAHSCdYHff5XOjo8jbDFdVUoaZ0Eml0o3eCrnIX+yFpUQJklzbwelgTm/PFzjlGivyUnrv3qu8vUQPuxklJng+lxerpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yNS8yMiAxNTozNSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gT24gMi8yMy8yMiAxNTo0
MywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPj4NCj4+IFRvIGF2b2lkIG5hbWUgY2xhc2hlcyB1bmlmeSBhbGwgdGhlIGZ1bmN0aW9u
IGFuZCBzdGF0aWMgb2JqZWN0IG5hbWVzIGFuZA0KPj4gdXNlIG9uZSBvZiB0aGUgZm9sbG93aW5n
IHByZWZpeGVzIHdoaWNoIHNob3VsZCBiZSBzdWZmaWNpZW50bHkgdW5pcXVlOg0KPj4gIC0gPHZl
bmRvcj5fbm9yXw0KPj4gIC0gPGZsYXNoX2ZhbWlseT5fbm9yXw0KPj4gIC0gPGZsYXNoX3BhcnQ+
Xw0KPj4NCj4+IFRoZXJlIGFyZSBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4+IEFja2VkLWJ5OiBQ
cmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9z
cGktbm9yL21pY3Jvbi1zdC5jIHwgMzQgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPj4gaW5kZXggYmI5NWIxYWFiZjc0Li43YTY4
ZjJhZDNlYTEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5j
DQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+PiBAQCAtMTcsNyAr
MTcsNyBAQA0KPj4gICNkZWZpbmUgU1BJTk9SX01UX09DVF9EVFIgICAgICAweGU3ICAgIC8qIEVu
YWJsZSBPY3RhbCBEVFIuICovDQo+PiAgI2RlZmluZSBTUElOT1JfTVRfRVhTUEkgICAgICAgICAg
ICAgICAgMHhmZiAgICAvKiBFbmFibGUgRXh0ZW5kZWQgU1BJIChkZWZhdWx0KSAqLw0KPj4NCj4+
IC1zdGF0aWMgaW50IHNwaV9ub3JfbWljcm9uX29jdGFsX2R0cl9lbmFibGUoc3RydWN0IHNwaV9u
b3IgKm5vciwgYm9vbCBlbmFibGUpDQo+PiArc3RhdGljIGludCBtaWNyb25fc3Rfbm9yX29jdGFs
X2R0cl9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+PiAgew0KPj4g
ICAgICAgICBzdHJ1Y3Qgc3BpX21lbV9vcCBvcDsNCj4+ICAgICAgICAgdTggKmJ1ZiA9IG5vci0+
Ym91bmNlYnVmOw0KPj4gQEAgLTEwMiw3ICsxMDIsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3JfbWlj
cm9uX29jdGFsX2R0cl9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+
Pg0KPj4gIHN0YXRpYyB2b2lkIG10MzV4dTUxMmFiYV9kZWZhdWx0X2luaXQoc3RydWN0IHNwaV9u
b3IgKm5vcikNCj4+ICB7DQo+PiAtICAgICAgIG5vci0+cGFyYW1zLT5vY3RhbF9kdHJfZW5hYmxl
ID0gc3BpX25vcl9taWNyb25fb2N0YWxfZHRyX2VuYWJsZTsNCj4+ICsgICAgICAgbm9yLT5wYXJh
bXMtPm9jdGFsX2R0cl9lbmFibGUgPSBtaWNyb25fc3Rfbm9yX29jdGFsX2R0cl9lbmFibGU7DQo+
PiAgfQ0KPj4NCj4+ICBzdGF0aWMgdm9pZCBtdDM1eHU1MTJhYmFfcG9zdF9zZmRwX2ZpeHVwKHN0
cnVjdCBzcGlfbm9yICpub3IpDQo+PiBAQCAtMTMwLDcgKzEzMCw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgc3BpX25vcl9maXh1cHMgbXQzNXh1NTEyYWJhX2ZpeHVwcyA9IHsNCj4+ICAgICAgICAg
LnBvc3Rfc2ZkcCA9IG10MzV4dTUxMmFiYV9wb3N0X3NmZHBfZml4dXAsDQo+PiAgfTsNCj4+DQo+
PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIG1pY3Jvbl9wYXJ0c1tdID0gew0KPj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBtaWNyb25fbm9yX3BhcnRzW10gPSB7DQo+
PiAgICAgICAgIHsgIm10MzV4dTUxMmFiYSIsIElORk8oMHgyYzViMWEsIDAsIDEyOCAqIDEwMjQs
IDUxMikNCj4+ICAgICAgICAgICAgICAgICBGTEFHUyhVU0VfRlNSKQ0KPj4gICAgICAgICAgICAg
ICAgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfT0NUQUxfUkVBRCB8DQo+PiBAQCAt
MTQzLDcgKzE0Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBtaWNyb25fcGFy
dHNbXSA9IHsNCj4+ICAgICAgICAgICAgICAgICBGSVhVUF9GTEFHUyhTUElfTk9SXzRCX09QQ09E
RVMpIH0sDQo+PiAgfTsNCj4+DQo+PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHN0
X3BhcnRzW10gPSB7DQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHN0X25vcl9w
YXJ0c1tdID0gew0KPj4gICAgICAgICB7ICJuMjVxMDE2YSIsICAgIElORk8oMHgyMGJiMTUsIDAs
IDY0ICogMTAyNCwgICAzMikNCj4+ICAgICAgICAgICAgICAgICBOT19TRkRQX0ZMQUdTKFNFQ1Rf
NEsgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4+ICAgICAgICAgeyAibjI1cTAzMiIsICAgICBJ
TkZPKDB4MjBiYTE2LCAwLCA2NCAqIDEwMjQsICAgNjQpDQo+PiBAQCAtMjUwLDE1ICsyNTAsMTUg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHN0X3BhcnRzW10gPSB7DQo+PiAgfTsN
Cj4+DQo+PiAgLyoqDQo+PiAtICogc3RfbWljcm9uX3NldF80Ynl0ZV9hZGRyX21vZGUoKSAtIFNl
dCA0LWJ5dGUgYWRkcmVzcyBtb2RlIGZvciBTVCBhbmQgTWljcm9uDQo+PiAtICogZmxhc2hlcy4N
Cj4+ICsgKiBtaWNyb25fc3Rfbm9yX3NldF80Ynl0ZV9hZGRyX21vZGUoKSAtIFNldCA0LWJ5dGUg
YWRkcmVzcyBtb2RlIGZvciBTVCBhbmQNCj4+ICsgKiBNaWNyb24gZmxhc2hlcy4NCj4+ICAgKiBA
bm9yOiAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicuDQo+PiAgICogQGVuYWJsZTog
ICAgdHJ1ZSB0byBlbnRlciB0aGUgNC1ieXRlIGFkZHJlc3MgbW9kZSwgZmFsc2UgdG8gZXhpdCB0
aGUgNC1ieXRlDQo+PiAgICogICAgICAgICAgICAgYWRkcmVzcyBtb2RlLg0KPj4gICAqDQo+PiAg
ICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UuDQo+PiAgICovDQo+PiAt
c3RhdGljIGludCBzdF9taWNyb25fc2V0XzRieXRlX2FkZHJfbW9kZShzdHJ1Y3Qgc3BpX25vciAq
bm9yLCBib29sIGVuYWJsZSkNCj4+ICtzdGF0aWMgaW50IG1pY3Jvbl9zdF9ub3Jfc2V0XzRieXRl
X2FkZHJfbW9kZShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBib29sIGVuYWJsZSkNCj4+ICB7DQo+PiAg
ICAgICAgIGludCByZXQ7DQo+Pg0KPj4gQEAgLTI3MywyOCArMjczLDI4IEBAIHN0YXRpYyBpbnQg
c3RfbWljcm9uX3NldF80Ynl0ZV9hZGRyX21vZGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBl
bmFibGUpDQo+PiAgICAgICAgIHJldHVybiBzcGlfbm9yX3dyaXRlX2Rpc2FibGUobm9yKTsNCj4+
ICB9DQo+Pg0KPj4gLXN0YXRpYyB2b2lkIG1pY3Jvbl9zdF9kZWZhdWx0X2luaXQoc3RydWN0IHNw
aV9ub3IgKm5vcikNCj4+ICtzdGF0aWMgdm9pZCBtaWNyb25fc3Rfbm9yX2RlZmF1bHRfaW5pdChz
dHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gIHsNCj4+ICAgICAgICAgbm9yLT5mbGFncyB8PSBTTk9S
X0ZfSEFTX0xPQ0s7DQo+PiAgICAgICAgIG5vci0+ZmxhZ3MgJj0gflNOT1JfRl9IQVNfMTZCSVRf
U1I7DQo+PiAgICAgICAgIG5vci0+cGFyYW1zLT5xdWFkX2VuYWJsZSA9IE5VTEw7DQo+PiAtICAg
ICAgIG5vci0+cGFyYW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2RlID0gc3RfbWljcm9uX3NldF80Ynl0
ZV9hZGRyX21vZGU7DQo+PiArICAgICAgIG5vci0+cGFyYW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2Rl
ID0gbWljcm9uX3N0X25vcl9zZXRfNGJ5dGVfYWRkcl9tb2RlOw0KPj4gIH0NCj4+DQo+PiAtc3Rh
dGljIGNvbnN0IHN0cnVjdCBzcGlfbm9yX2ZpeHVwcyBtaWNyb25fc3RfZml4dXBzID0gew0KPj4g
LSAgICAgICAuZGVmYXVsdF9pbml0ID0gbWljcm9uX3N0X2RlZmF1bHRfaW5pdCwNCj4+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IHNwaV9ub3JfZml4dXBzIG1pY3Jvbl9zdF9ub3JfZml4dXBzID0gew0K
Pj4gKyAgICAgICAuZGVmYXVsdF9pbml0ID0gbWljcm9uX3N0X25vcl9kZWZhdWx0X2luaXQsDQo+
PiAgfTsNCj4+DQo+PiAgY29uc3Qgc3RydWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyIHNwaV9ub3Jf
bWljcm9uID0gew0KPj4gICAgICAgICAubmFtZSA9ICJtaWNyb24iLA0KPj4gLSAgICAgICAucGFy
dHMgPSBtaWNyb25fcGFydHMsDQo+PiAtICAgICAgIC5ucGFydHMgPSBBUlJBWV9TSVpFKG1pY3Jv
bl9wYXJ0cyksDQo+PiAtICAgICAgIC5maXh1cHMgPSAmbWljcm9uX3N0X2ZpeHVwcywNCj4+ICsg
ICAgICAgLnBhcnRzID0gbWljcm9uX25vcl9wYXJ0cywNCj4+ICsgICAgICAgLm5wYXJ0cyA9IEFS
UkFZX1NJWkUobWljcm9uX25vcl9wYXJ0cyksDQo+PiArICAgICAgIC5maXh1cHMgPSAmbWljcm9u
X3N0X25vcl9maXh1cHMsDQo+PiAgfTsNCj4+DQo+PiAgY29uc3Qgc3RydWN0IHNwaV9ub3JfbWFu
dWZhY3R1cmVyIHNwaV9ub3Jfc3QgPSB7DQo+PiAgICAgICAgIC5uYW1lID0gInN0IiwNCj4+IC0g
ICAgICAgLnBhcnRzID0gc3RfcGFydHMsDQo+PiAtICAgICAgIC5ucGFydHMgPSBBUlJBWV9TSVpF
KHN0X3BhcnRzKSwNCj4+IC0gICAgICAgLmZpeHVwcyA9ICZtaWNyb25fc3RfZml4dXBzLA0KPj4g
KyAgICAgICAucGFydHMgPSBzdF9ub3JfcGFydHMsDQo+IA0KPiB5b3UgaGF2ZSBzdF9ub3IgaGVy
ZQ0KPiANCj4+ICsgICAgICAgLm5wYXJ0cyA9IEFSUkFZX1NJWkUoc3Rfbm9yX3BhcnRzKSwNCj4+
ICsgICAgICAgLmZpeHVwcyA9ICZtaWNyb25fc3Rfbm9yX2ZpeHVwcywNCj4gDQo+IGFuZCBoZXJl
IG1pY3Jvbl9zdCwgaXQgY29uZnVzZXMgbWUuDQoNCk9oLCBpdCdzIGJlY2F1c2UgbWljcm9uX3N0
X25vcl9maXh1cHMgaXMgdXNlZCBieSBib3RoIG1pY3JvbiBhbmQgc3QNCnBhcnRzLiBMZXQgbWUg
cmV2aXNpdC4NCg0KPiANCj4gQW55IGlkZWEgd2hlbiBzaG91bGQgd2UgdXNlIGp1c3Qgc3QsIG9y
IGp1c3QgbWljcm9uIG9yIG1pY3Jvbl9zdD8NCj4gDQoNCg0KDQo=
