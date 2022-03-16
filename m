Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E544DAEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355244AbiCPLKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348000AbiCPLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:10:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96B63BE5;
        Wed, 16 Mar 2022 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647428949; x=1678964949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OckjGETlhOSbb0E2pY5UlRCCzQHpE5mg7nFW7goimo8=;
  b=DfTrhd1Tf9bxMV/zPY2C2jqi7cl2RpF7IQFPSasoAH8jMy6uwNa33dsH
   sxphdrc3FcGoNR0+0/glNa8iGwejIfdr03h9iDf28WTM6YkmJjWHqdlgh
   PJOYKIHc0T8aoM/NHJQ7EknC4k6WAZAGPuUZ47vWcHcejLywG5wOv8FeU
   Xi/VYUM5u32AnSscU0QzgYXUduPCqGBwGlmoO/wk9hxQ60IKDxydF2f7i
   DUo9NCgK4OzCd2wB0oEAp41rsqr3NjGmmfanNU1GOcf1YmFTglUg5bsaT
   kIom9kLA5g+voFAeB6/IwPPrPwb2TEvPx+ewDOiyDVPuL5l9BbBNC7imO
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="195501197"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 19:09:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LofltOSb+PwTGS0I28aMbtQBJMl+o8UOxAFduy8SB8rBAjAuuFxCRK45MPt6m3LsVlCdxmHiXmurJadQQYdyC8V4oCTPX93uN9GIjgfyqIzlG4arPoBU6rwwrhJEl9ip4Zz0gxDK+f9lb6RytMpcEoelmQnhmBC5C+qqNkJRS5G7cqE32kmXTVoP2WwEWwAgnx9kObfq1xpkbgXp4tQSPN7/Exd4cr1S6xVw13M2nGEAlrUmjzqroAkwtX3zqH2lG2RVJQx0xSA5hid00reKr1KNWiscv7LWBMd6N8sJGfnvWeriF4/lU5nsnrd3ZSKx40KVthplyjE1tEhsmVuPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OckjGETlhOSbb0E2pY5UlRCCzQHpE5mg7nFW7goimo8=;
 b=RvOreWadcP4I+gYFRzJMHeWDKWI2aeIimhyq+A9L5PBJHjHjZNiOSXoFGexvOOVIRn2EhJp1g4foH8Rj8GEHxTpKiyO1j+QDOsGQDYUadJkjtmzXqoFkyMURISveCX3pBotJr/Afrb4jyo+J+uw01dy0bDGvXUKIc8KMHmw5c7nAOkoxhOvB2dOi6GXoW0MCeM5ty7umwF7/mGKeOTJbgxUomQGx57CK2c/RN6AyHZ+U4NjQ4D8Qn3ag2NK9P+STmvdy3AimVTQPZ/yzpu7gLg7vq37NZwDdNL+00loqd69j5/1Icrscl1CRekHApk4P73rixD4oADrHsRRTT1KNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OckjGETlhOSbb0E2pY5UlRCCzQHpE5mg7nFW7goimo8=;
 b=vo1zId9wob4mI5RCHUfsO94E9zfRBZEp9nnzAAxcAElm/dXiQWsY1a4TXNTVDY35/RRgSp3yMQ38UEfIsXjg6MqTV68dy81TeVhCslkzEW3RdMz+sO3ZGx2S96FW5hVwmgyq4EZsOf0e15kDmi1kBR9f6T2Nxg8kD1Uvh/ONaZI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR04MB0742.namprd04.prod.outlook.com (2603:10b6:903:e2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Wed, 16 Mar 2022 11:09:07 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%4]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 11:09:07 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Michael Wu <michael@allwinnertech.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
Subject: RE: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Topic: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Index: AQHYNcu0Jgralp1XlUCNRLBRM2Fhq6y+dQaAgAAo/4CAAARTcIADKbGAgAAUWcA=
Date:   Wed, 16 Mar 2022 11:09:07 +0000
Message-ID: <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com>
In-Reply-To: <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ccf1962-c093-4102-bc4f-08da073d639b
x-ms-traffictypediagnostic: CY4PR04MB0742:EE_
x-microsoft-antispam-prvs: <CY4PR04MB07426C133C3507CBCA076F4BFC119@CY4PR04MB0742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NmgXXPwyEWStAerGgkmlIvDyOfBku7v8pAQpRzr5h7a3Z8En39YUtINRdI2FNBMkhstmNmIRs9wlgQ3MecVvEUxMX/FM3RoKOVZXuA9K0ZCxMe0DvT5e/2Gxf72e3LgUsGw4yyjmJJcnziTz9JEdCTWIlIEwmSOVgWyFDdbTBQEAYJOeRie2M3Mys71AW1deHTTNr+jL7X1crN9HfQB/O5UXrNWe1ehbJgK2qSjKAjVHCHr7W06eApVL8UonbCQUytnya+Z/YRP5up+M6B+wqwmL+bEQZZnE5wyg9tvUWPU+/Gla0VhTe1IkErR1ebpjynM4H3pAnXGCA92YJMbuD1rhCIEXuCgg+IZj6NFY8sMHl4s5oW0VXO3OMzSX1mZoJU1CvX5pIWpxoe5iIJVvR8E+SkAUFqoFuTSI3eEkMnpfwzcksOpErclz4DTyJ+6cRE0hNtlLuXPwdIZO98aEN3+vMGqsKAhmFFHq/MDJ4Qz0q733OT/uKC85EhlOIRM90iic+kyH+ZNcTnMiB3PlSlX8OObP+GhgQWEocN/07yoSdosTkc+H10axPQ0FYRpIKicfjvL5RcrG3DQH6vyWHhso3k3HNyuWt4MA/6n1tuh2e3hwkedC/KcKFvIgvtCQgc0G4dOhbzk3TbCbZNexDSDre7iQg9VAc25BYRWaMgTcVjXOXeWTuV8nDg/BNC30EL0FaLs3z7ecDzZK37nNJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(9686003)(7696005)(186003)(26005)(83380400001)(71200400001)(6506007)(2906002)(52536014)(316002)(86362001)(122000001)(66446008)(8936002)(8676002)(38070700005)(76116006)(4326008)(64756008)(508600001)(5660300002)(33656002)(38100700002)(82960400001)(110136005)(55016003)(66946007)(54906003)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXUxd3pGUFBiRVBsc0ZkN1VZUm11SWxjdHJEdTR6eE1JT25CZ1ZjOXF6aTlv?=
 =?utf-8?B?MC9pdUdVQzRTN1gwL1hZV29FZjVZamZjZ2JyU2toRzFKc21yVjErYkF2Qlp3?=
 =?utf-8?B?QjFRbmVBeHVabEpObUk1M2NZWDVCUC91NFkrYU9Uem9qR0h2RnVNV1VMbDVW?=
 =?utf-8?B?SzY2cHQxUG5GR3N6RWIzcnBvTm52YUZJOGhDam1OZ2VQWXV2cStBTG5yQlBF?=
 =?utf-8?B?WGU3eDBWYmt4RWVOdnhxNVVrVmIwZTY1NGIwb1M4NkRwbWRUVkl6clc0R2xJ?=
 =?utf-8?B?am9ISVMrNnQralZzYnVvTXBtZUJOTFRYenZGUlA5VmZJOXlZbUI0b1NRbmpP?=
 =?utf-8?B?V2E2eWxmOUpkYXZjdGl6RmZWcXRuMkw5S00rZUh2d3B1WjhJSVhJOHdRSmNM?=
 =?utf-8?B?NmFveUQ0ZWlHSFpuMmtmOTBLQnRqVUI4c0JrMmVKMFh6cXh4Tm9UdlFiVEw5?=
 =?utf-8?B?SFVwUzBoZG5xeHpEUi9mREdMaENFSThmc1M3MzMvSWJrTEZBQW1TUWhPVFJI?=
 =?utf-8?B?cDZXYm1adndKZGcxNDFtRHQ0YVBNS2l6OHFnWU1DV0tFTmx5MCs3b2JMbnRK?=
 =?utf-8?B?SHZqaEdGR1NDL0RhVnp0ZkpYTzI0Q0ZUVVJvNDUwUXd0dFZpM0RyZ1VzWG5K?=
 =?utf-8?B?WkVad09HTmdBcUxOaU1DeTA3bGNJTDgva1IrMjNLdjZOVEVwUExMRGlWTkV1?=
 =?utf-8?B?M0JCbWJDMnY1bnAwQ1ZCN2RiOVJEUnh5eDJoaFdxb25yS05EOE5aaGg3cDhH?=
 =?utf-8?B?ekp3WVVRUXJpakxxRkl3TjlvdHJvck00amVSbDJrUXd1MkZoZlZxL0w2MDNo?=
 =?utf-8?B?Zmt0bDdlaTZRcTFlUGhoRENXc2xBd21vN3RnSElpbjl5Q2NZRWZEekpJanZ3?=
 =?utf-8?B?enoybGp6RVRyZ3czeDM5dkV5bzhCNUk0YXU1UmNSQWJxblJaWlhQQVpWRE5z?=
 =?utf-8?B?dXJsNWpQMDg1RCtGeUEraEQrQ1FyN3ZVMTh2QkU3NHZZTjdLMndGbjh2YVVZ?=
 =?utf-8?B?VXc0cW1aTzVpYTgxOTZZUWZQbkphNjBQb1hjUUlSbWIxLzhtdTVSSE8rRFJ6?=
 =?utf-8?B?alc2a0FFTDFTc2M1dTNnRHB5RENyN2huVFBWNEdLaU05VFVQOEQwRkNnLysy?=
 =?utf-8?B?aWc1TFZPUjlVZFhDNkZMejhMVHR0MVRkQWNFNU81dGpqc3FDYVJNSlVwNzZo?=
 =?utf-8?B?bUJMSTZNWUYyVWtjdkVvSnhIbGI4dWM1aXRIQ2RmTHBtY05IU3BCV0FBYW1O?=
 =?utf-8?B?YU5OMkdFQjgyZ1ROVCtETkp0YnhGMXlxdDhZV1NaVWNmTndOTTd2R2NIbDNU?=
 =?utf-8?B?TGNhSi9UYTNZWUpIL21OM3gremJuWm9iYmV1OXJJMnBNbGZ1NnRXbUJ4NUI5?=
 =?utf-8?B?Wi9VQzdEdC9welc5NFdXVkVsWis1N2JodTJYRkpEdkRHOHdwaDlyOVBpdkx6?=
 =?utf-8?B?NVY5NmUvcHFVdjkwUFpaSytzdlB4MkJqQmxxT1dCWUd5M3VkQzRhOGpkbjZ3?=
 =?utf-8?B?dWtSU3VMRXpEa1gyVis3cmVVeTcyNmU4MTkweU5DUHc3Yk1BcGNES3JpOWlj?=
 =?utf-8?B?Ti9QQUtCOUpWc3lTZloxSDJTOFdFMHYraWc3dHZiSEMzaUJVN0pUNWMxZlpN?=
 =?utf-8?B?ZGd3cmFHT2lsbWhBbjM5NG0wbjhHMFFoWWE5dFFkWmt4M1pSMGdMSnNMdDhM?=
 =?utf-8?B?WThPZUNGV1k0R0J1Z0pLaHNxblYzVTMxZXNZRlcreFlBcVhCZ01LT211SEIw?=
 =?utf-8?B?c3pNWGNZTlVUckxNS2tvK05OZG5oSXlWdHJDbXBYUi9rbTgxam5uNFV3TVUx?=
 =?utf-8?B?eFdpSHhPellGbWVsaDBldTdlMURFSnB6TXNDQWNkd01jOG9TTTVEcDdlZFRX?=
 =?utf-8?B?Z1BVeEd1QWtwR3BDRlRraDlnNHc5SXU0TjV1cVBNSGIyeWI1R21OM3I1M2xS?=
 =?utf-8?Q?F/16oLIg6uKM/4lnfpUCooi4oJordlpD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccf1962-c093-4102-bc4f-08da073d639b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 11:09:07.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxb3QkCna5nQzZ2mi5k0PVPZ2UBAW9u9HtY+OkZUhHpFIA+7R3RgSsn+dbjYJZB3hj6siJL8enfUwx2qc+TkNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0742
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBBdnJpbCAmIEFkcmlhbiwNCj4gVGhhbmtzIGZvciB5b3VyIGVmZm9ydHMuIENvdWxkIHdl
IGhhdmUgYW4gYWdyZWVtZW50IG5vdyAtLQ0KPiANCj4gMS4gZW5hYmxpbmctY2FjaGUgYW5kIGNt
ZDIzL3JlbGlhYmxlLXdyaXRlIHNob3VsZCBiZSBpbmRlcGVuZGVudDsNCj4gDQo+IEhlcmUncyB3
aGF0IEkgZm91bmQgaW4gdGhlIHNwZWMgSkVTRDg0LUI1MToNCj4gID4gNi42LjMxIENhY2hlDQo+
ICA+IENhY2hpbmcgb2YgZGF0YSBzaGFsbCBhcHBseSBvbmx5IGZvciB0aGUgc2luZ2xlIGJsb2Nr
DQo+ICA+IHJlYWQvd3JpdGUoQ01EMTcvMjQpLCBwcmUtZGVmaW5lZCBtdWx0aXBsZSBibG9jaw0K
PiAgPiByZWFkL3dyaXRlKENNRDIzK0NNRDE4LzI1KSBhbmQgb3BlbiBlbmRlZCBtdWx0aXBsZSBi
bG9jaw0KPiAgPiByZWFkL3dyaXRlKENNRDE4LzI1K0NNRDEyKSBjb21tYW5kcyBhbmQgZXhjbHVk
ZXMgYW55IG90aGVyIGFjY2Vzcw0KPiAgPiBlLmcuLCB0byB0aGUgcmVnaXN0ZXIgc3BhY2UoZS5n
LiwgQ01ENikuDQo+IFdoaWNoIG1lYW5zIHdpdGggQ01EMTgvMjUrQ01EMTIgKHdpdGhvdXQgdXNp
bmcgQ01EMjMpLCB0aGUgY2FjaGUgY2FuDQo+IGFsc28gYmUgZW5hYmxlZC4gTWF5YmUgdGhpcyBj
b3VsZCBiZSBhbiBldmlkZW5jZSBvZiB0aGUgaW5kZXBlbmRlbmNlDQo+IGJldHdlZW4gZW5hYmxp
bmctY2FjaGUgYW5kIGNtZDIzL3JlbGlhYmxlLXdyaXRlPw0KQWNrZWQtYnk6IEF2cmkgQWx0bWFu
IDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IDIuIFdlIGRv
bid0IGNvbnNpZGVyIHN1cHBvcnRpbmcgU0QgaW4gdGhpcyBjaGFuZ2UuDQo+IA0KPiAgPiBPbiAx
NC8wMy8yMDIyIDE5OjEwLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gID4+IEhlcmUgaXMgd2hhdCBv
dXIgU0Qgc3lzdGVtIGd1eXMgd3JvdGU6DQo+ICA+PiAiIEluIFNEIHdlIGRvbuKAmXQgc3VwcG9y
dCByZWxpYWJsZSB3cml0ZSBhbmQgdGhpcyBlTU1DIGRyaXZlciBtYXkgbm90DQo+ICA+PiAgICBi
ZSB1dGlsaXppbmcgdGhlIGNhY2hlIGZlYXR1cmUgd2UgYWRkZWQgaW4gU0Q1LjAuDQo+ICA+PiAg
IFRoZSBtZXRob2Qgb2YgY2FjaGUgZmx1c2ggaXMgZGlmZmVyZW50IGJldHdlZW4gU0QgYW5kIGVN
TUMuIg0KPiAgPj4NCj4gID4+IFNvIGFkZGluZyBTRCBzZWVtcyB0byBiZSBvdXQgb2Ygc2NvcGUg
b2YgdGhpcyBjaGFuZ2UuDQo+IA0KPiBJcyB0aGVyZSBhbnl0aGluZyBlbHNlIEkgY2FuIGRvIGFi
b3V0IHRoaXMgcGF0Y2g/IFRoYW5rcyBhZ2Fpbi4NCj4gDQo+IC0tDQo+IEJlc3QgUmVnYXJkcywN
Cj4gTWljaGFlbCBXdQ0K
