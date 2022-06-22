Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85923554C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357956AbiFVOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiFVOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:08:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B108E289AE;
        Wed, 22 Jun 2022 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655906901; x=1687442901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qgEk1/mn6Vz888dnsT1O2CpL2r9zeaEglZu9Ib/7f+4=;
  b=tz58hISBLyA867pjeD2fjyerYWKeNam0KnScVrOQMga1m7sUSpYIEihO
   b9y9GZcm1D3U8/2rHZST2idSc9AgFpzuW2p9mGmusSTb5hAx2t0X8hjN3
   LiU/rCGCsg/H36Vc5ljtGi0c5X5mwJvl1rY9mIbKSQGm0uRI6XDmYxe6q
   tPOQ3jY4vbKkqKzOA1AVmVTWf0hHyCgOFBZFZmHXVynHC4hmZ5pARIaUp
   6pyD03TgHamr6mYAcl+15sax+uYttpT/vgz4RViEwAYRMiirz02d5oJz/
   HL24alo7odlxknRn7N5n7evRjr2YKuBgi1oM9jqEgA+0dAQePCz3RrCIl
   g==;
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="179055222"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2022 07:08:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Jun 2022 07:08:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 22 Jun 2022 07:08:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU+mA7i2aALraxRPgN74JWilP7Ao/KertM0SsPAqnfH5dBwyvY6Cdg1sOmt4Gk0VbRgRSXWTCL6ATvgSvz3JoPC/1x+NPzRJOrX0AJs8x8/12HgODO8HnyqGgVUrOSdN8QzKmHjzHR14zy6jZZ0w5jMBlZRWgwYCyB1NnBXaI5zoj6UzAa9yNrhDrM78ddL3uyjOYXTfjrY8csy04bWwSCKRe1v2g4e3vSxZlKErKpjFvbKR6KhrIIxyUe5ZTaptKIFkyTsKPgLSMaLlQRXxOGo460gkHR3cZGQJrpYnxHBFKWSMSncHG2yIgkz+oQbCI0EFvQSxXxTIe30AP8fzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgEk1/mn6Vz888dnsT1O2CpL2r9zeaEglZu9Ib/7f+4=;
 b=oIRSPKBikCJBtuv8aQVbuIOdmZpQJx5lOW03hZanl/P7GjhVUgE+81cjPNl37WoocEVUuTqRbVoFMwN3ECTxXqCX5QlRgJ/iNGKyI3styNEazAGrNJBUZD+W83MTdy3+7zH/cmj6yRpVwQ1HzUn1pkouYGs0wszIny6EJuuH4BrC9/in0+IpRi8sqqlBV6VP5CeU7fxdC25LTN68w4SNXhf1F7L2J0dN5BYwD6iMysDSlFwOZ9gJ3isyVgiqrTR9w9FKiw43GVwxhkcltpJNHcb1xXSX/7d2zWZcGF6oS22auY/57NLsXBTB5U4vKbnA6NfZw1oL28VWI5xLUDpORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgEk1/mn6Vz888dnsT1O2CpL2r9zeaEglZu9Ib/7f+4=;
 b=cKSHnnyqmM6IEQGV307jdbIYvoCVty4yPH758eFdRUfPNRHn53CDDLvOC19jNyCdhm32MnZHyc9kt+p4DJNgU15i72zvgwoNMXFSMUVXMXEuTy/eF/BDNH3FLfpd1UOoiVKxHDOuUIVCkeE5Ej7qQXYAt0DT/HifZ7K3Hy8/Zqw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB3632.namprd11.prod.outlook.com (2603:10b6:208:ec::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 14:08:14 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 14:08:14 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jiangjian@cdjrlc.com>, <rth@twiddle.net>,
        <ink@jurassic.park.msu.ru>, <mattst88@gmail.com>
CC:     <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alpha: irq_i8259: drop unexpected word 'and' in the
 comments
Thread-Topic: [PATCH] alpha: irq_i8259: drop unexpected word 'and' in the
 comments
Thread-Index: AQHYhkGDRQeTk/Acs0eam/iQP1DkSg==
Date:   Wed, 22 Jun 2022 14:08:14 +0000
Message-ID: <7ae0e6b2-39e8-2453-b154-6c02734028b6@microchip.com>
References: <20220622140201.5458-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220622140201.5458-1-jiangjian@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dae85351-8040-4517-2411-08da5458a5ea
x-ms-traffictypediagnostic: MN2PR11MB3632:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3632369BA7F6E5C863EAB19898B29@MN2PR11MB3632.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jvFCcZzS9oi9InIafpZR6xVrCMpJtPJuUV3m3wjZZfa11vENyf3Lsqks6pdWId6meHd5pWmvHD6V5sDowuo8Jof7R5E9t2AJjQWitd2PKLnjfmGqub2VuWtxuKulIfLOLPs5q9HWCKtAH8S6qV57j1N0+v+3YSvrXiMuCMOWnWcQGXsQ0MepBAy3aBReDypwJo0zCXRlsl3se3oNyssuIDYQg0lL6HKVGdOjTwXp/F4kymQFaAn1A7NMWCdnQro01ATeuQbr31+UkVBg/em5Zt5u4pjcewC45J0I6SBPoeh4LHVfotlffWfDK2jsJqF5qHz6i3h0zHuauFaBAniX4QzIJtNOacXqitfJzSo5q1ZjaodCPewBBnim3DWyhJNl61bOHI75uKHDxjUyEFtrQpFUdYk9Rcgp0zVqmr84Rw16gngHwhqrFKaW9U+oqHwhAacdsR8wqPThhf2ASGW7BezfoT/+nPqrC28KfnKnRFtde9LoLKtmsLWgH/ej5aSloFRGiwgzIy4K8ZAlnM8VkjY29KU0PwYv+tIFXSB23CYaLkbtt+PSRk24MwgWjK17wLKYYrnTdkFlSduDQr3seigXqlos6aOtni8lFRksOK4Tg3RI86rjNXSLuxXLvePh0bqyCPoleG6ifPigrJBsQUaKtzqrVQqJewzdhaCDPMpmF8hKAiY3wxPpgL0GBpMvSDCAkHysT9AU/FzH8xk26EhwOhYkhEkZuuSc0nR0fvJ1hHFY98XvHqBkAXa82xwTkTR3Hh5YrfIaE1itvWq75KjecDxEsEK6czpxQhkPS081bn4/rr9iS9bekLCIuDNa9SNdjA1as0XFaQ5PwJiXvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(136003)(39860400002)(346002)(366004)(38100700002)(122000001)(86362001)(31686004)(2906002)(83380400001)(6512007)(38070700005)(2616005)(31696002)(53546011)(6506007)(41300700001)(186003)(71200400001)(26005)(91956017)(64756008)(66476007)(478600001)(66556008)(316002)(8676002)(66446008)(66946007)(8936002)(76116006)(110136005)(5660300002)(36756003)(4326008)(6486002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnRoVkR3WjlFMm12NWVkYTR3bUNET2F4S29vMWs0MVl5SFdqMFdCdWZkM0lZ?=
 =?utf-8?B?cCsvcm12OE9qbGJJY2hIYktSUndxU2FDK0FxdHZIc2JsWG5RSUI4M3ozNjZh?=
 =?utf-8?B?NFp0alRFc29peVlpMHNTMGhQUDNxN1NCQTZ1bXdvdXY3a3ZFQ25kMGRWV24y?=
 =?utf-8?B?dGh0L1RmMDlwRnNiUzcrWFVFZUw0Y2VwOW5iejhTcW1weDhHVVhuOVpPeE0x?=
 =?utf-8?B?TjBiNisySnVkbFNDSVhDdFZkSTByOU9vcHlnL1NjbUlqWWlHUTB6RUdHYXg4?=
 =?utf-8?B?ektNbzlIenJKdUNzMGhOb0t3aTN5ZjR2YmlQL0g2VDA0bmQrRHVDeUVDK1hV?=
 =?utf-8?B?Q25jUitXa2ZhL1U3bDV2M0RzNllpZ3lLSURmejU2bkQxZ2U0czhDeGdFUWdH?=
 =?utf-8?B?YitVMEN6VjJoaXkyc3lYaFF5Tlk5WFd6bW55TmpZL09sTnVvdU5heUx4UGJC?=
 =?utf-8?B?V3VwUGhjSk56TlJNM3pSdkNuWnZBVUkxR1FUeEMvR0JZQWkxbzM0NGpqY3RV?=
 =?utf-8?B?ZHJpZXdxOUc4emJWazJkSnNZL211UUk2dXh2cVBSTnJ4dWFTR05YQjlIcUZD?=
 =?utf-8?B?OEpaQ0JCRmlyVG0yci9hSjlDQTBqSVY3Zk44S0hBeUZpekJWaC8raHFGVjdU?=
 =?utf-8?B?N1pkRkIwK3pOZ2ljbWZUcjduYXd5cFZJWWlVWHJrR3RPTmZKZ04yRVNVU2I2?=
 =?utf-8?B?M05SVmtCcXdUc3FWeVBITnY2ODJ3OTRyaWVhWThpdWl2QUlYNExpU0pzTlFm?=
 =?utf-8?B?NENNZXNad3N5b0JkODlzbHYrUm5VYkIyc3dBTWRTZVZKckJ1OGpiU3EyTHRD?=
 =?utf-8?B?VjBmMmFkV2dFVTN6dGhaaGh0YUhwZVhsOFpoa3BZdWR2QXU4Q3Z3b0NuQmpi?=
 =?utf-8?B?amp2NUkrTEt0OTF1Ynhzd3hJSDlONG9vb0FpK3ErV3JzaFdxZFd5UmliVUND?=
 =?utf-8?B?WUJVTDdWazRiWmFzMGxHVXhDOFNYSVVnUnRaazlhMEZVSk5Pbzl6UVY0LzN3?=
 =?utf-8?B?R213SVVZaFZSUkRyaWFhY3Bzc3dFMmpydDlVN2RvMHdBVnl0Nlhvckt0R210?=
 =?utf-8?B?TldMR0dwV3ozYllCU2x6eUtQMFNMc2JhZnZZTU5jLzNsMFllSFhQQXYxZmtQ?=
 =?utf-8?B?eE1OaTFsdlk4QWFBNjFiZWRGeWtvaUFLYm5XUVhaelo2bUVzc05GZ1ljNjc0?=
 =?utf-8?B?Qjg5bnVXQU1aOUxwWGRBVi9POEZvMStUVng5L3c0RElibjVwY04waTFlUi9G?=
 =?utf-8?B?L1hmc05iajVxREVJc3VZbzV2Zi9lUExXVkNNZm95M1BMcW91NW96eFBXb0gy?=
 =?utf-8?B?RkhwSElSY0JHTysrSE1mdE83ajY0dmhSTFppMU83emtOOGI5TkZBOTR0T21h?=
 =?utf-8?B?eHRtSklGbEZUczQ1YytMYWZJSURtK1laeG1KZGErdjNHV283OGEvQ0w3aWhx?=
 =?utf-8?B?eU5KWS9TYm5oc0JvbVUrTnJUWE00dk1uTVdqL0FORE1KTGIyNGZJVEhDd1Fh?=
 =?utf-8?B?VGdlLzdrc2oyaVQzNEQ1dmZvTmNTTWZST1p1RWVJVnVsYzl0dzhRWW43blgx?=
 =?utf-8?B?TTdQeGJma1JuMHh1dnlkdDRTSXNsRktKWlo1UlUxVGEvb1J0c2JRd0g4ckNN?=
 =?utf-8?B?c3RtV0ZKUWZlOWYwYitOZFRXUUptem9DbEJwTnJNUnhyNXN3YzVvYVgzZDRp?=
 =?utf-8?B?V3dyOEhXeTNHS0srZFl6OGFxM3BTZHN0bjE5NHBPclg5cVdpeDFoaE5Ga0VL?=
 =?utf-8?B?cWcvelJNbDVJMTl4eWIrdnFoRVBUQklsS1FEYkhSekM5aDNxem9hY2h1OG9l?=
 =?utf-8?B?SVovSkhLdCsxS3E4ajlGZXJpMHNMVCtBZGlMSmpRVWJ1SCs1bTNwSWNiU25S?=
 =?utf-8?B?bVgzL3NQdXA0TWZza1FYZjJDdGRvcnVicEw5SUpSMm5TblhYZ0lYVXF1Y1pS?=
 =?utf-8?B?VHZPdzFUZ3ZvQjhlNzJFYmZNOXVtZmFyd3JvMElZYkhhbHRRcitwdnNHc1Va?=
 =?utf-8?B?UHdjbXpETUlKK0IwZmxKc2szNXVkWExwcmZCVDBWdTUrS0gvYlk1UTU3OWNC?=
 =?utf-8?B?NkV0MEMrK3RnTHFRQWZkVjliRWhRR1dKQjByS0N6RFBxaFNqZ2dJTGZoWkRV?=
 =?utf-8?Q?QEheayVg0CJ6a6K/snBUYQq8l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA3D3A717EB2E54688795E6326F1D82E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae85351-8040-4517-2411-08da5458a5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 14:08:14.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IjWj8DkywC7Euvo8huLp9gs63rWp2iNOziLpvgVygVWTmIaQ/bqwgQpfjPsvjSyOIwCic5iFkzTQr8d1LLTZW02GjCk/iRC+UX/QW/WNzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3632
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMi8wNi8yMDIyIDE1OjAyLCBKaWFuZyBKaWFuIHdyb3RlOg0KPiB0aGVyZSBpcyBhbiB1
bmV4cGVjdGVkIHdvcmQgJ2FuZCcgaW4gdGhlIGNvbW1lbnRzIHRoYXQgbmVlZCB0byBiZSBkcm9w
cGVkDQo+IA0KPiBmaWxlOiBhcmNoL2FscGhhL2tlcm5lbC9pcnFfaTgyNTkuYw0KPiBsaW5lOiAx
NTANCj4gDQo+ICogIFRoZXJlZm9yZSwgcmVhZCB0aGUgbWFzayByZWdpc3RlciBhbmQgYW5kIG91
dCB0aG9zZSBsaW5lcw0KPiANCj4gY2hhbmdlZCB0bzoNCj4gDQo+ICogIFRoZXJlZm9yZSwgcmVh
ZCB0aGUgbWFzayByZWdpc3RlciBhbmQgYW5kIG91dCB0aG9zZSBsaW5lcw0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSmlhbmcgSmlhbiA8amlhbmdqaWFuQGNkanJsYy5jb20+DQo+IC0tLQ0KPiAgIGFy
Y2gvYWxwaGEva2VybmVsL2lycV9pODI1OS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYWxw
aGEva2VybmVsL2lycV9pODI1OS5jIGIvYXJjaC9hbHBoYS9rZXJuZWwvaXJxX2k4MjU5LmMNCj4g
aW5kZXggMWRjZjBkOTAzOGZkLi5kYjU3NGRjZDY2NzUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYWxw
aGEva2VybmVsL2lycV9pODI1OS5jDQo+ICsrKyBiL2FyY2gvYWxwaGEva2VybmVsL2lycV9pODI1
OS5jDQo+IEBAIC0xNDcsNyArMTQ3LDcgQEAgaXNhX25vX2lhY2tfc2NfZGV2aWNlX2ludGVycnVw
dCh1bnNpZ25lZCBsb25nIHZlY3RvcikNCj4gICAJICovDQo+ICAgCS8qDQo+ICAgCSAqICBUaGUg
Zmlyc3QgcmVhZCBvZiBnaXZlcyB5b3UgKmFsbCogaW50ZXJydXB0aW5nIGxpbmVzLg0KPiAtCSAq
ICBUaGVyZWZvcmUsIHJlYWQgdGhlIG1hc2sgcmVnaXN0ZXIgYW5kIGFuZCBvdXQgdGhvc2UgbGlu
ZXMNCj4gKwkgKiAgVGhlcmVmb3JlLCByZWFkIHRoZSBtYXNrIHJlZ2lzdGVyIGFuZCBvdXQgdGhv
c2UgbGluZXMNCg0KVGhpcyBkb2VzIG5vdCBsb29rIGxpa2UgYSB0eXBvPyBTdXJlbHkgdGhlIHNl
Y29uZCBhbmQgbWVhbnMgdGhlDQpvcGVyYXRvcj8gTWF5YmUgaXQgY291bGQgYmUgcmV3b3JkZWQg
Zm9yIG1vcmUgY2xhcml0eSB0byBzb21ldGhpbmcNCmxpa2UgImFuZCBtYXNrIG91dCIsIGJ1dCB0
aGUgaW5pdGlhbCBtZWFuaW5nIGxvb2tzIHNhbmUNCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gICAJ
ICogIG5vdCBlbmFibGVkLiAgTm90ZSB0aGF0IHNvbWUgZG9jdW1lbnRhdGlvbiBoYXMgMjEgYW5k
IGExDQo+ICAgCSAqICB3cml0ZSBvbmx5LiAgVGhpcyBpcyBub3QgdHJ1ZS4NCj4gICAJICovDQo=
