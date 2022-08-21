Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA059B4D5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiHUPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiHUPHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:07:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A922252E;
        Sun, 21 Aug 2022 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661094457; x=1692630457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M+9UxttTe3icCSolFePGQBmy8y4eaWbpsd1GGLswWzs=;
  b=GH46v+NvRLUmAL4A8s/cdsX6hyfOMj3DKCrpdJ8GT6fbpdQYB9g9Yn6L
   qZ1t+zl7HMW1AHJXp9j1KRBxLGr6uB4coCQMK89+cX6nqJ6YVGAcqqVRO
   sBlZV9jiJAXgyLhVTAhRXsEQG8ELbS2ehJW15CzwjPIvjEc7uzCbQ6CIG
   IvQLWdUy6I4ewMpbPfFR4C6LyyFumwfzOB5gHyiQCW2GvP1OSJqGL5PCK
   ECb1sflShTsNLAyucH9hE3BAbk+38yf33ZuYTMGykNl4CCwAKkII25PEu
   1AKkurMKv+pKRnQQOywk3d24ATIQX2hpF7SId0MJP0y2y09t3XhIWD/wi
   A==;
X-IronPort-AV: E=Sophos;i="5.93,252,1654585200"; 
   d="scan'208";a="173415623"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2022 08:07:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 21 Aug 2022 08:07:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 21 Aug 2022 08:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvrTtS2TMIWu+Crq+zD7YQ89AObJITtjw8QTv85E93LQMgrP9DRfLuCmOFnn4lKYrV+xJYY2u7oibVnFnqw4h5xEy45/p/QgklolaJUfzJmjx0kXjrj/qY78raqaUf9Vw1xrJLNOKA2EDycGfEgYT5LT8kW8FIjzJAzJ58Qj/izkpgO2tzmFt8rOYpKA/SNUIHLfCAGUj4en7rQdeC8MphBTP1lnK68Ddfoct6qdqZaBYLZNgjTtaBrwr4fCVonFqwTDzzsdEFJDzJFXwugrrOzOznHpRHWnBVf3fhLKyVrDrjzwJxJtnZaa0gu/uVpwt4fKJoS9SgTS4CvqoWEdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+9UxttTe3icCSolFePGQBmy8y4eaWbpsd1GGLswWzs=;
 b=JsQ+haxnnf7Hn/BylyTDsM5NnDPrfr5FziGCni9MXDecD6C42ruE0hj9ZAZAyZPTawifYWo3jFHAR5CYnx1kTHzW5IW26HxZ1mIPC7wuS/3pgKUbUWn6Xh88VYNsNPCeCXlBX9gezFnqFJO7tA9SW2sF6RdnL0ZYiJ0v742EnqiPeMlw5NwGeDLNxlD8z7B11iM7TVebnNIHxDLuw2bqaWRckXuNVXklv6NYQOSrzEHYEOzFfC/F9TDu4XGaTJIaehKUsSwCq/vzKRDZ/fcWMBg1qttg+s3Tx3Ls/Cbh5S98e17miWRE/f+4kCdGHx8glM6nMN2Z5SxaTiVMCEoZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+9UxttTe3icCSolFePGQBmy8y4eaWbpsd1GGLswWzs=;
 b=eWWuroWNg03dR8THlseipTdH/qMEV7hpPl6TR8qGstaLa3FObltsEpMdRqceHm3Hqgf62hZqpsjIG+kPBF9Au3xt+ZxB+symgQrexTBZDf6qP06tCOYXDxjMYMa214/nPwPkw+qsMAjIo9cjmODvsxKa1KlZe9zf1nYB9OCwIpg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL1PR11MB5383.namprd11.prod.outlook.com (2603:10b6:208:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Sun, 21 Aug
 2022 15:07:31 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 15:07:30 +0000
From:   <Conor.Dooley@microchip.com>
To:     <wangjianli@cdjrlc.com>, <tsbogend@alpha.franken.de>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips/sgi-ip22: fix repeated words in comments
Thread-Topic: [PATCH] mips/sgi-ip22: fix repeated words in comments
Thread-Index: AQHYtW8yI6nqXyJcE0ycotjw9jbjUK25dJgA
Date:   Sun, 21 Aug 2022 15:07:30 +0000
Message-ID: <b2b39e6a-ca51-eb10-dbfc-b70b700d8237@microchip.com>
References: <20220821150246.51164-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220821150246.51164-1-wangjianli@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87fea1f0-bc44-41c8-23b7-08da8386de91
x-ms-traffictypediagnostic: BL1PR11MB5383:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVvNndx7COgObI/WoFuab4wtOQZ4olJO98Zn8TrcxAM4JSiTwbiyo0MTZ0d6CTEKioj+X5XZsaIWVLGtCF94CvLFUbn1yEd2hfbzArIo+yIBLxMod5e+9UTz2kR3CvRt3Kg/x7dMNrYq6zH3Vvu2k7tt7389o/FSyORCmXjdQFUUPordKvB921rUD80Fa7CdsI1AeUiIdh2H+mM99zGPo58tqameztnGeps8ZlQITbl9K0tUhrL9gjzHNrSTAk4giqhBTIFX1BzyGFF6KNMl5ZswGo4P/htQLVeOxw/5RyAiLBUYTQLZomFCDalTv10pcIIMpqj9jDl824hOEje4ZTYwl71trbCJSFmrSNXbRG0i0PFd9493IdeLkly0PNxSYm849MkQ4bhV+55drOxZM5E1VeB3FezfWueIxI0BnYmFaM7NO1k81UqUmSSgcPshz01FNjpoiM4/0DaYK2fu/hU9+QIOui8vdP7qmbxJoKoC1tTbvH413wls7cb+QHIsjf9TuY8VHGkt3EJejsJmL8+rTgg0V6GldNw5hiukoz8ptHXQ0eSiy3jmzBzFHFoUALsXCjmv/IDHmgR7J7cuqPHZFOZhvhxx2BBgYonK8QG4SE6d0AYuAWIebpFZXyOGfWeNVGmHCE7LR6C5j9gwuRCxCQRZpxpc0iC3IUOw2DyNnYF9FJlcX/Ze1VPzDkgJLrGgDXqWM79ohhdobOI3AwPBY1SF0UtgCOYMuGQQukodTsiIOimEF/USMCmJF/TgtE4tZ+RgPfvxEU+95RQhpK/4IfEa2qldVe0ss7N3StUTTwa3WY0fFp5YuPue9xwvTiflXj0xDJle8GwHi6e44w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(396003)(39860400002)(366004)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(66946007)(38100700002)(31696002)(31686004)(86362001)(110136005)(54906003)(91956017)(36756003)(38070700005)(122000001)(83380400001)(186003)(6512007)(26005)(41300700001)(6506007)(6486002)(478600001)(71200400001)(316002)(2906002)(2616005)(53546011)(4744005)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTA4RWg0T2FOMXpaL0tWbGtlWHJ1cnVJbkNhcDBtaWw4WGc1NDRrbUF6WE9Y?=
 =?utf-8?B?NzJ6N0t0c2ZrZ1htYlBoeGJIb0VWZUNCeExlaTJZc1RWT3FoNFppUVpTeldD?=
 =?utf-8?B?a0hyNjNsVlQ4c0hkM3RKdjJGcmV6czRqWHk0cTN1MmdiY3RxcTl1Q1AyMFZy?=
 =?utf-8?B?RWNsVm1VYVh0M3hCOUNKVi9kaGhLcDlJZWVnUXNkTHdDOUx4RXVIRGVIUTZE?=
 =?utf-8?B?RmZZeS9UYzNPcDFuOUxMYWlicmZNV29HdU9lclJ3dVZzT1ZDMXZYZHNlWEtj?=
 =?utf-8?B?QnVLRzJXYzMxQ283MnNYbHorcmh1amx3MXRLNW9PcXV3R24wb2JqbGZUMDFn?=
 =?utf-8?B?Y0NxcUtVaTBkazFDdFFNVC9xUm1oaXdCc1EyNVg1d3NLd2IwYjNwV3ZzZzVk?=
 =?utf-8?B?RWpka1FyVll3eFVTZTBrSVB5ZkhNWEFHOU1ES2Q5UEFpWjdsbXV2a2VQeGZP?=
 =?utf-8?B?bmdTODhhb0xtalBiV1RaeElRQmRzSGVvc1lsMXEzSUVIOXVtZWxBcnZWd2dD?=
 =?utf-8?B?eitOV0JFbTQ1UU4xb25QZlJIUEtCZTVyVTFvSUZqVjZDUHh0cTN0ajE3eUVZ?=
 =?utf-8?B?Y3hTV09iNVpWUWljTjI0SlZJUnZjWHB5QmlVaUZEZTN4Q1V2c2JxTHJXZk5q?=
 =?utf-8?B?eEJnMzRTUTNNb1YrajJqa1QwVkNGRG9ZN1BhUlBnaml2UnlYVjZTRTdLdEpp?=
 =?utf-8?B?N053QlVTeTdGVjNJUHJnc3g4c0F6VFJVRmM0TStSMXd4S0FlRlVhZUNGKzhN?=
 =?utf-8?B?Kzc1amRzc3pDQVdSdkR0bG5FdGk2RTJHL1hWK2QyVHZNSGxWd3pNaUlXZWVj?=
 =?utf-8?B?K0x5dGJuSlAxMFd6R2d0MDhSYU9aRERTWVdRc0s1aE5QNWlleGV3ZnJ1Njhv?=
 =?utf-8?B?VHVLUzUwZ3ZneEwxaGFuWnRpbU1rdXllUktXcFBFMk1OVk9zOWx0RHRxcmlw?=
 =?utf-8?B?R21hdnFzeTRCSHRadWRYM1VDMUdJVkJVeER2d3ZxVHZlUWJLb1hVVTVkMzRa?=
 =?utf-8?B?KzBmS2R2YjMveFRIRXNtZE1wNUtFWTM1MkJRU0RscHZVNTZWd3lncVpiNXlG?=
 =?utf-8?B?TkkzMjh0aTEzZXBKYlZWYmZ0Tysvck0vaU1kNjRPb1d1MkhyRkJUWjg1SXgy?=
 =?utf-8?B?eHhWWUF5aDR3NWYyNEsvWitBOEcrY1FETjd4a3B1bk9vY2YvTmlnUUh3d0x4?=
 =?utf-8?B?cXdSUE9HblVURVZQWCs3eDhrRG1pR0pRSGZqNzZtdXFDTGJqYkhMbEpualZs?=
 =?utf-8?B?Z2MxbmVmcmt1UEVNN2k0cW9DbllsdUV2TW0zL3dRUmZCYlY5NXBRdG9pQWpt?=
 =?utf-8?B?cGdiWkdjZGVVYzR2MVhpcnNCeEV4S2ZtT0FOa0VZSGtZQWkzbGlPYndzR09k?=
 =?utf-8?B?SjdnV3hrRnZ6STJMUDJhT1BXRnZWRi9RbldibTdOb1ZPaVdlRkdjQVNneEQy?=
 =?utf-8?B?Uy9IcUl5dlNQdWcrTElsNVRGaDhucko4eG9pZXZrZFVpaHYvWGM3b0FiQ1Ji?=
 =?utf-8?B?U1BZVi9PMUV0L3Z5TUtSRkU1YmhqeEVMSkhmbmtzZnRvK1NXUWYvdmFSNlIv?=
 =?utf-8?B?bWlEUUZPZXdYS0FaWXh2RXp3K1g5WnBZZHg5WXRwL1dBVnh5ZDdmRDdEMDNU?=
 =?utf-8?B?ZnBvQTI1Mlhpc2xuSmVkZkFvTUlDaWJhVFpiSWpuaFh2Z05VVzFSRHQrd3pK?=
 =?utf-8?B?SVp1b0JxWUpKUG9XMW5LbllwWTVkMkg5Yk9USWVDZWwyZ3FORXBINmJTeGtz?=
 =?utf-8?B?b3MxR2FlMjBWZldjcUJwTHdVM20wSk03T1Qrb1hwa2JDY1NRV1JCMXhDelZt?=
 =?utf-8?B?c1M1TzRMTk9NS1FhWklGUHNsR1R0d0VidEJ1N01sQTBzaENGenJOZmhCRzEw?=
 =?utf-8?B?NmpES1lsYVdGcWtEeXFWdHRxaUdwYytSU0xEc2FVV3JqWENyU2JHOElQU25C?=
 =?utf-8?B?Nm1ZcTkrUjZ5YVJTZjdhWXVnWWR6bzYyOS9pcVlscjJQbUtuVWJpSDZyUTla?=
 =?utf-8?B?Zm1uSmt6UzhOUjNVbjVlUGI1WmFnMGRDeldPUVc3SmJKQXUwWXRPMGpjK1BD?=
 =?utf-8?B?cy9GNWs2QndTL2ovZmV5WXBrVFFvbmU1TEd6ZHduZTUxY2tJTFg1UlMzeW9N?=
 =?utf-8?Q?e7izcZtbuOid8mQUmqEWV5C6G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B05F62DC2FE6E42889DC21541503F49@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fea1f0-bc44-41c8-23b7-08da8386de91
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 15:07:30.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKGSSmtFu1ozlGlb7h7T8X0xbbugbtXcpjPbXWJLerEt3e+vkTDq127GSb9cRS9LCX+d6ZddDJlQVd1b4KhJGoNa3in1VOsxtCLIaLmcA3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5383
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDIxLzA4LzIwMjIgMTY6MDIsIHdhbmdqaWFubGkgd3JvdGU6DQo+ICBEZWxldGUg
dGhlIHJlZHVuZGFudCB3b3JkICdpbicuDQoNClRoZSAiZHVwbGljYXRlZCIgd29yZCBoZXJlIGlz
ICJvZiIgbm90ICJpbiIuDQpIb3dldmVyLCBJIHdvdWxkIHN1c3BlY3QgdGhhdCB0aGUgc2Vjb25k
ICJvZiIgaGVyZSBpcyBhY3R1YWxseQ0KbWVhbnQgdG8gYmUgIm9wZW4gZmlybXdhcmUiIHNvIHRo
ZXJlIGlzIG5vIGR1cGxpY2F0aW9uIGhlcmUuDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogd2FuZ2ppYW5saSA8d2FuZ2ppYW5saUBjZGpybGMuY29tPg0KPiAtLS0NCj4g
IGFyY2gvbWlwcy9zZ2ktaXAyMi9pcDIyLWdpby5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9t
aXBzL3NnaS1pcDIyL2lwMjItZ2lvLmMgYi9hcmNoL21pcHMvc2dpLWlwMjIvaXAyMi1naW8uYw0K
PiBpbmRleCAzOGQxMmY0MTdlNDguLjAzZDk2NjM4Zjk1NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9t
aXBzL3NnaS1pcDIyL2lwMjItZ2lvLmMNCj4gKysrIGIvYXJjaC9taXBzL3NnaS1pcDIyL2lwMjIt
Z2lvLmMNCj4gQEAgLTQxLDcgKzQxLDcgQEAgc3RhdGljIHN0cnVjdCBkZXZpY2UgZ2lvX2J1cyA9
IHsNCj4gIC8qKg0KPiAgICogZ2lvX21hdGNoX2RldmljZSAtIFRlbGwgaWYgYW4gb2ZfZGV2aWNl
IHN0cnVjdHVyZSBoYXMgYSBtYXRjaGluZw0KPiAgICogZ2lvX21hdGNoIHN0cnVjdHVyZQ0KPiAt
ICogQGlkczogYXJyYXkgb2Ygb2YgZGV2aWNlIG1hdGNoIHN0cnVjdHVyZXMgdG8gc2VhcmNoIGlu
DQo+ICsgKiBAaWRzOiBhcnJheSBvZiBkZXZpY2UgbWF0Y2ggc3RydWN0dXJlcyB0byBzZWFyY2gg
aW4NCj4gICAqIEBkZXY6IHRoZSBvZiBkZXZpY2Ugc3RydWN0dXJlIHRvIG1hdGNoIGFnYWluc3QN
Cj4gICAqDQo+ICAgKiBVc2VkIGJ5IGEgZHJpdmVyIHRvIGNoZWNrIHdoZXRoZXIgYW4gb2ZfZGV2
aWNlIHByZXNlbnQgaW4gdGhlDQo=
