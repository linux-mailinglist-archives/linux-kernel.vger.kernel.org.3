Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D17567A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiGEXEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGEXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:04:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115B51BEA0;
        Tue,  5 Jul 2022 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657062239; x=1688598239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zAFE2DzldKBlWExVsxwRszugcD9FQZUM+qcLnLP9/wo=;
  b=xaqSEVa2HdQlVsjOWAaM/Vzq2rv31pnffJVIesTMv/c/e7xj3AkUBdWF
   r7kIho4kVg5iM5xyFpGkyljL51qtRWjJXHhWUGK5tkIpBnVqkW9gldeXx
   MeKTZWMbUlp2ESpL2hvAu3g1DWLc739nesYli7To7S/oSvvlz6sycheZo
   F07WNMhhctaZV+pW8lKOwttSZ+O/1fznxEGu00V8QLT0bEjw+wOI+DHkz
   f/QEjIjzHQakurXjygxFpCILsZZsCGhd954whJztuPFAc0Wbzdiwc0UvW
   ZlZeZ1hnCKzP5ntYr/7mQOAniiBe0zP6ETZb61KjM3E6BUmPeplceH44P
   w==;
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="171164697"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 16:03:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 16:03:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 16:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSBimzsqxR3dt91I8cC5GZVc/at0b0nowiWETKkdZl7meIRVM+GOF2+9CrMeHQgUMnm8jn9hqn03nCRjvj3YuwEIzfUb5r/fcMfcxvU9PO2Q1fEuoKIyTXcQGxiAHf908fWMQalbTjt7sZRHyNno1nG3gkKf+3SCj1Y5fcIBJnk7oHAC1FgHiKeqQdi3HGP7zwY9GCpUP5cT8Ta03B/5A8JoCAzET2ubw6bcX24cC82HnABNWI0J9bNkgDxwINkMeb/jU4Y0LGYb24LxAlvmZ542lP8186rUNy0OQ9MnkHp0y2WUM1OT9+Q6uzCQq0Z7e3366ZVhN3XCy2vxGeXf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAFE2DzldKBlWExVsxwRszugcD9FQZUM+qcLnLP9/wo=;
 b=QG6FAqVKZ9cFx727W6j7ZezDK2JtSnS97qoaaiJPJt3366/D4sU0IIAuU44ufIpp3DwHByjgARKVeu2jkYFZRmM+PctNutxCfgcK6GOjNJJgvECI5dbN5sICVXjOEkb+WYCImqI/B98IkFNMs5cmrCmkpj7DkZgGApOmdJrHUrzZ7I9mCPzodbx92ZwqCD4mE6qY5BS1SgUNfD7jakyhl0Jd7Jvam9toIiQTYBn9dTt0ktIzlAeEIs0pVsQUjSL7nlU3WV0GbEyC8/H+GJd7hpYCiTN/x2iMs0evFQEDcVQqq63zEzkx9GQvOP94BFpE7o0uxmB1oz9gWemNVrmakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAFE2DzldKBlWExVsxwRszugcD9FQZUM+qcLnLP9/wo=;
 b=I5xF7yKYEgBP5Ssqmh/ZyAFhm5/oQn7Z1wfIsOhYsL07/2WXES1xJ9jUaO2uEJ88y9YNIPEX5pLCDPeE5HQaRZ4sPH/PGYi868AD1ncwlWnP9yKUBnrqjpf0aWwXPrX9ZrNTPWo3vwdBVqOSWJiHzRhioxmBe/5X6mIgJnMBy8I=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by DM6PR11MB3355.namprd11.prod.outlook.com (2603:10b6:5:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 23:03:55 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 23:03:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Conor.Dooley@microchip.com>, <sudeep.holla@arm.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Daire.McNamara@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Brice.Goglin@inria.fr>
Subject: Re: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Topic: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Index: AQHYkKIdHc6oV2H//EKJV+LfcdW+Dq1wN82AgAAD8QCAACn8AA==
Date:   Tue, 5 Jul 2022 23:03:54 +0000
Message-ID: <fb7be22c-cf19-0e06-f231-bb5b9167e179@microchip.com>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
 <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
In-Reply-To: <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff204438-897e-40bd-7540-08da5edaa283
x-ms-traffictypediagnostic: DM6PR11MB3355:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d70Ab61YhAllyKyKwiVDtfHCvxuN+6yxyuIzJFwBN18JvidCIOREO65I+h3+bEKcaT+Gqe+HEoiuWYK8+/EXYo4M/XZAuZ6QPg9f9FFJxWbZ4HBDEuNH4oOMoTbsOleDQ5DTmDtrQO2vOqk6Q1nE+cDY/7LSfeeOH6UU6Z1Ztxjl1rs5sAygWfkm8P4dSH9oQm8jrvUeQBbEJxZJ9vZ8Ti18QsTo6RJWeyMglfvbaxGUwej7tGB7lGlFr7lW6qYkBkoFJPKFR9BxEO9GDPOb6cd+M3uIadOOPdriN4Wa/oNtxpTwSRGep2NyUguMP57pPPJWJqVAXn9xnTYxMtkCIcrtU21zNbnsdJ256ax9+bafprf2QskrHaLoewxWXW3WeJTOPRfvHw08uJZmrbV54hBk8vZab+KmZ+m3+X1Vcw9VEq6DyrC7B07zX7x7Uipfyrbo2P3lZOp4V0eczLnuTWpbVfNOM3xkg72UO30ZpbnLKjT2r5W22dPY5dn0IN9G6pKUHmx3N5yCpLnwUdQ4s42z2tYtoAOpDEa4cT5iEafCqLkTV43pg1pFRvZQG1glrEnpyHaa4U1w3JtM5iRVCqRtG5k2oIk5moavSenWwFJu+/+xHGidO61+OAaTxd1kF4atBHefGSBjAd9HsyWmwSp6sFMihhAcmX64urrrFnKAPVdHh4tePxTAp82XIH2FJGSOBRRaDQ10YmNqAwsAM+eqcnjq505PZ57Wh4REOQyc85PlrWkCx7BzppLeTwg5j7TBYlQhWIHpLpKN5eNf/7Dyef/dM6f8eaGmKDaJ6n8TC9HV+tqKQ6OiZFIMHVBjfbzbdMIZDU1ap2MNkgYAYccbKq8Uheg1cFDxZYR1EsvuYP+/nCebiAAfQDM7I6Zm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(346002)(376002)(366004)(91956017)(38100700002)(66946007)(8676002)(4326008)(76116006)(66556008)(66476007)(66446008)(64756008)(6506007)(5660300002)(7416002)(2906002)(86362001)(31696002)(38070700005)(122000001)(53546011)(8936002)(2616005)(6486002)(478600001)(41300700001)(71200400001)(83380400001)(110136005)(54906003)(316002)(186003)(6512007)(26005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2ozQnlSWGhvTjBVb2Ftb1FuaFd5cFQ2YzhaQ1NPODhOM1ZvMnZrTFJPdkFE?=
 =?utf-8?B?NlptQlRQeGxwVHlWN0Y3OEFyUk9YNTFvaC9BMXhhbzFtcDQrR2RKei9OMXly?=
 =?utf-8?B?U2lpNWthY3RSczlCZzI4NGRwZWhBYStzeEwxRmhpNkE3Ukg0VFpTUEdGeG14?=
 =?utf-8?B?V1BlSUgvYks4VEtkS3d3Ym1IWXdHUXpzUFl6MWM1K3czalorcG9vU0Vnc2JS?=
 =?utf-8?B?aERucDRiVGxGV1hOdWlLSk4yaHY4OVBIdVRZL3BEalRoZkxubGVSYkZ6bjVY?=
 =?utf-8?B?clN1QjBZdlN4UnZwakduRjc3b2UzQ3ZqdTdZZGg4UWJZcUYySUtlay92Z3Fv?=
 =?utf-8?B?VVVqMVJ5SHlXcEkyelBpd1g1eWdXUXF2WGgxYWtEZXlad2tmSFoxMlltOEo3?=
 =?utf-8?B?TjM4VUc0SGpENUh0NTN2Qk5BbDJOYjlLSG9BSWhvRUVIbXhUR283cmdIOTQw?=
 =?utf-8?B?WFMyYVZsSzZCdFJlODVBcGpVZ3Z2Y1ZrUmVad1J3YlRpWWU1ZEZlb09pVk9E?=
 =?utf-8?B?d3licnNMVHdmUk1yMnZsSVg3ek5QMzlqb3RVa0RoMVFUNzFNZ1N4WkswZHN4?=
 =?utf-8?B?YmFVVHp3UWdhbUsyUE5hMVp3Y3ljOElkc3dGM2x0OVVQdWxwdmZVNjJZTVBB?=
 =?utf-8?B?bVBPbWFaOGl3R21FN2hRaTZRajJPZEMwNTBRUzIvMlhNZytEbkQrTmtaTGdX?=
 =?utf-8?B?bFZyUGRLL0piS0p5bGFOLzIzbG5YcEc4Z1k3QVFLcnB2ejBNTEQ2Wmx1c1BC?=
 =?utf-8?B?OU9PTnFCN25UM3VqL3pvL2tPcld6YTJ3WEt0WS91TUFwTGc3aTBxVmRmM1pL?=
 =?utf-8?B?VzVsdFcySWcrTjI0K1dLVVJHSjlHaG1OTzlpeUZBaU9TWHBoeEJ2WE8vZHkz?=
 =?utf-8?B?L2wxWU1saWQ1T1dNYzRVRzQ0Yk9DYnJGVlQzb1F3QVJzVzhzQ1VIUFRXcHFK?=
 =?utf-8?B?dTljb0dWSnZHSmFpVlBxb1VORlM3dnlGcmZRT3BjUWJoQkVma25SejZRUXBH?=
 =?utf-8?B?cHoydWZneHdGdmFsVmFZclQreitWTHZ5cCszTW53aG9UTHJvSERaR2xBeUJ0?=
 =?utf-8?B?Y3lSdm83R2Ria3JnOVpXZkFuVTdjQ09wQ3BGOVp0R0s5MHZiSzRRbG5DMTZG?=
 =?utf-8?B?YlVJOHdrUVJ3OXh6ck1RMGZOeCt3UUhLeTFWc2xySWR2ajk0ako1allwaUhJ?=
 =?utf-8?B?c2pDd2xyM2tCUmpGVzRxRnNZV3gzVCt2WEhTdTRWcjdxYlFvM0pZS1JoK0I0?=
 =?utf-8?B?ampuTzJKRFB5ZXlRLzV1Q1RzdEg1YlI2WjN4eGE4dHplNGRiOVA0L25GWmxC?=
 =?utf-8?B?cE1VZDY3NFZyU0tIRlJNUFVGVUw4NUpuU1E5amtlT2VDdzhDZ3JnSE1CUGow?=
 =?utf-8?B?U01nL3NYZERVeXBpUzFJUENvQkF0K3Q4QWNVd0FEVW55aU4zYW56MzVpMHZn?=
 =?utf-8?B?TzUzVGJXNlBQR3RCbllVZ3licDZTQXFIdG5VQlRSMmV4eHloUEQzR1ZSRHdK?=
 =?utf-8?B?YTNTbkpNYncxbWtBYThkcUZXdklkd29RdHJhV3FRdXhMb2ZNVmlLK2hxMU4z?=
 =?utf-8?B?WG12NEUyVVlUQ0FkbnQ5cWV3OE0rM1pzOXdHN2xnUjRNZUNrd3oxcC95TGFh?=
 =?utf-8?B?aE0xOXNzVFV2ZXFGLzV1WERtRlJqOVhNTmtWWXA2U3REZ3lPUGhYNVhKcjZr?=
 =?utf-8?B?bXhRK2Y1U2M0Y1A0d0cwSjZ6VHNzYXJpNWlmUzZFN2d2aTFCQTZyUlAwVUJN?=
 =?utf-8?B?SXRSNDFJM0EvQnkxU0lYN0d5azlFV24xdXdGSm9DdGRTSXUwZzdKcytuWTZC?=
 =?utf-8?B?WUVpWlltcEVnSTNlL2JWVHNEZWp4SFM0Y3NFNXZieVRBK001QXZRaXZTZ2F6?=
 =?utf-8?B?WHByRTJKdFRnQThuQ3RCZmRSSW1kQVpDNENpTVc3YkxRK1hOV1h1QnJpMk04?=
 =?utf-8?B?TVlDN1l6ZlEybityL1FYWHhwS0lqYXhxR1MxMXlES2JQdGlGajQySTVYbDJX?=
 =?utf-8?B?Q2VBai9SWVY4THBCRTl5NlMvZ3Q3VTh3KzdKWWZxVC9ySWtmb3Z4RDQxWXBy?=
 =?utf-8?B?NTJjeDEraGtzQkhvRnpZRHE5SmFGdDE2QXFVR1VIOElhQ2NuOFY2Yi9USjRF?=
 =?utf-8?B?UlJLcERjQkxpNXpNelR1ekpndXA4L2VNZ1QreGtvZVZtN1lOZWx4SDdtYTlB?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA865314538D5345990FF92ECCFB9DFE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff204438-897e-40bd-7540-08da5edaa283
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 23:03:54.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYpfU4+DtbKzi0lycmdjTbCrnef3J+efXFWk001+xspP+NRKgSL0L2Rz5vebg/kN7GuutH7nDr1q2Gbov1VF2bdZJ1KL/RwJ81wsr2rndbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3355
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzA3LzIwMjIgMjE6MzMsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDA1LzA3LzIwMjIgMjE6MTksIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+
IE9uIFR1ZSwgSnVsIDA1LCAyMDIyIGF0IDA4OjA0OjMxUE0gKzAxMDAsIENvbm9yIERvb2xleSB3
cm90ZToNCj4+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29t
Pg0KPj4+DQo+Pj4gSXQgd2FzIHJlcG9ydGVkIHRvIG1lIHRoYXQgdGhlIEhpdmUgVW5tYXRjaGVk
IGluY29ycmVjdGx5IHJlcG9ydHMNCj4+PiBpdHMgdG9wb2xvZ3kgdG8gaHdsb2MsIGJ1dCB0aGUg
U3RhckZpdmUgVmlzaW9uRml2ZSBkaWQgaW4gWzBdICYNCj4+PiBhIHN1YnNlcXVlbnQgb2ZmLWxp
c3QgZW1haWwgZnJvbSBCcmljZSAodGhlIGh3bG9jIG1haW50YWluZXIpLg0KPj4+IFRoaXMgdHVy
bmVkIG91dCBub3QgdG8gYmUgZW50aXJlbHkgdHJ1ZSwgdGhlIC9kb3duc3RyZWFtLyB2ZXJzaW9u
DQo+Pj4gb2YgdGhlIFZpc2lvbkZpdmUgZG9lcyB3b3JrIGNvcnJlY3RseSBidXQgbm90IHVwc3Ry
ZWFtLCBhcyB0aGUNCj4+PiBkb3duc3RyZWFtIGRldmljZXRyZWUgaGFzIGEgY3B1LW1hcCBub2Rl
IHRoYXQgd2FzIGFkZGVkIHJlY2VudGx5Lg0KPj4+DQo+Pj4gVGhpcyBzZXJpZXMgYWRkcyBhIGNw
dS1tYXAgbm9kZSB0byBhbGwgdXBzdHJlYW0gZGV2aWNldHJlZXMsIHdoaWNoDQo+Pj4gSSBoYXZl
IHRlc3RlZCBvbiBtcGZzICYgZnU1NDAuIFRoZSBmaXJzdCBwYXRjaCBpcyBsaWZ0ZWQgZGlyZWN0
bHkNCj4+PiBmcm9tIHRoZSBkb3duc3RyZWFtIFN0YXJGaXZlIGRldmljZXRyZWUuDQo+Pj4NCj4+
DQo+PiBSZXZpZXdlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4+
DQo+PiBJIHdvdWxkIHJlY29tbWVuZCB0byBoYXZlIHNhbmUgZGVmYXVsdHMgaW4gY29yZSByaXNj
LXYgY29kZSBpbiBjYXNlIG9mDQo+PiBhYnNlbmNlIG9mIC9jcHUtbWFwIG5vZGUgYXMgaXQgaXMg
b3B0aW9uYWwuIFRoZSByZWFzb24gSSBtZW50aW9uZWQgaXMgdGhhdA0KPj4gQ29ub3IgbWVudGlv
bmVkIGhvdyB0aGUgZGVmYXVsdCB2YWx1ZXMgaW4gYWJzZW5jZSBvZiB0aGUgbm9kZSBsb29rZWQg
cXVpdGUNCj4+IHdyb25nLiBJIGRvbid0IGtub3cgaWYgaXQgaXMgcG9zc2libGUgb24gUklTQy1W
IGJ1dCBvbiBBUk02NCB3ZSBkbyBoYXZlDQo+PiBkZWZhdWx0IHZhbHVlcyBpZiBhcmNoX3RvcG9s
b2d5IGZhaWxzIHRvIHNldCBiYXNlZCBvbiBEVC9BQ1BJLg0KPj4NCj4gDQo+IFllYWggdGhlIGRl
ZmF1bHRzIGFyZSBhbGwgLTEuIEknbGwgYWRkIHNvbWUgc2FuZSBkZWZhdWx0cyBmb3IgYSB2Mi4N
Cj4gVGhhbmtzLA0KPiBDb25vci4NCg0KSSBzaGFtZWxlc3NseSBzdG9sZSBmcm9tIGFybTY0Li4u
IFNlZW1zIHRvIHdvcmssIGJ1dCBoYXZlIGRvbmUgbWluaW1hbA0KdGVzdGluZyAob25seSBQb2xh
ckZpcmUgU29DKS4NCg0KQXV0aG9yOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2No
aXAuY29tPg0KRGF0ZTogICBXZWQgSnVsIDYgMDA6MDA6MzQgMjAyMiArMDEwMA0KDQogICAgcmlz
Y3Y6IGFyY2gtdG9wb2xvZ3k6IGFkZCBzYW5lIGRlZmF1bHRzDQogICAgDQogICAgUklTQy1WIGhh
cyBubyBzYW5lIGRlZmF1bHRzIHRvIGZhbGwgYmFjayBvbiB3aGVyZSB0aGVyZSBpcyBubyBjcHUt
bWFwDQogICAgaW4gdGhlIGRldmljZXRyZWUuIEFkZCBzYW5lIGRlZmF1bHRzIGluIH50aGUgZXhh
Y3Qgc2FtZSB3YXkgYXMgQVJNNjQuDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KZGlmZiAtLWdpdCBhL2FyY2gvcmlz
Y3YvaW5jbHVkZS9hc20vdG9wb2xvZ3kuaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdG9wb2xv
Z3kuaA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uNzFjODA3MTBm
MDBlDQotLS0gL2Rldi9udWxsDQorKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RvcG9sb2d5
LmgNCkBAIC0wLDAgKzEsMTMgQEANCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vbmx5ICovDQorLyoNCisgKiBDb3B5cmlnaHQgKGMpIDIwMjIgTWljcm9jaGlwIFRlY2hub2xv
Z3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KKyAqLw0KKw0KKyNpZm5kZWYgX0FTTV9SSVND
Vl9UT1BPTE9HWV9IDQorI2RlZmluZSBfQVNNX1JJU0NWX1RPUE9MT0dZX0gNCisNCisjaW5jbHVk
ZSA8YXNtLWdlbmVyaWMvdG9wb2xvZ3kuaD4NCisNCit2b2lkIHN0b3JlX2NwdV90b3BvbG9neSh1
bnNpZ25lZCBpbnQgY3B1aWQpOw0KKw0KKyNlbmRpZiAvKiBfQVNNX1JJU0NWX1RPUE9MT0dZX0gg
Ki8NClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
a2VybmVsL01ha2VmaWxlIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCmluZGV4IGM3MWQ2
NTkxZDUzOS4uOTUxODg4MmJhNmY5IDEwMDY0NA0KLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFr
ZWZpbGUNCisrKyBiL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlDQpAQCAtNTAsNiArNTAsNyBA
QCBvYmoteSArPSByaXNjdl9rc3ltcy5vDQogb2JqLXkgICs9IHN0YWNrdHJhY2Uubw0KIG9iai15
ICArPSBjYWNoZWluZm8ubw0KIG9iai15ICArPSBwYXRjaC5vDQorb2JqLXkgICs9IHRvcG9sb2d5
Lm8NCiBvYmoteSAgKz0gcHJvYmVzLw0KIG9iai0kKENPTkZJR19NTVUpICs9IHZkc28ubyB2ZHNv
Lw0KIA0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYyBiL2FyY2gvcmlz
Y3Yva2VybmVsL3NtcGJvb3QuYw0KaW5kZXggZjFlNDk0OGE0YjUyLi5kNTUxYzdmNDUyZDQgMTAw
NjQ0DQotLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9zbXBib290LmMNCisrKyBiL2FyY2gvcmlzY3Yv
a2VybmVsL3NtcGJvb3QuYw0KQEAgLTMyLDYgKzMyLDcgQEANCiAjaW5jbHVkZSA8YXNtL3NlY3Rp
b25zLmg+DQogI2luY2x1ZGUgPGFzbS9zYmkuaD4NCiAjaW5jbHVkZSA8YXNtL3NtcC5oPg0KKyNp
bmNsdWRlIDxhc20vdG9wb2xvZ3kuaD4NCiANCiAjaW5jbHVkZSAiaGVhZC5oIg0KIA0KQEAgLTQw
LDYgKzQxLDggQEAgc3RhdGljIERFQ0xBUkVfQ09NUExFVElPTihjcHVfcnVubmluZyk7DQogdm9p
ZCBfX2luaXQgc21wX3ByZXBhcmVfYm9vdF9jcHUodm9pZCkNCiB7DQogICAgICAgIGluaXRfY3B1
X3RvcG9sb2d5KCk7DQorDQorICAgICAgIHN0b3JlX2NwdV90b3BvbG9neShzbXBfcHJvY2Vzc29y
X2lkKCkpOw0KIH0NCiANCiB2b2lkIF9faW5pdCBzbXBfcHJlcGFyZV9jcHVzKHVuc2lnbmVkIGlu
dCBtYXhfY3B1cykNCkBAIC0xNjEsNiArMTY0LDcgQEAgYXNtbGlua2FnZSBfX3Zpc2libGUgdm9p
ZCBzbXBfY2FsbGluKHZvaWQpDQogICAgICAgIG1tZ3JhYihtbSk7DQogICAgICAgIGN1cnJlbnQt
PmFjdGl2ZV9tbSA9IG1tOw0KIA0KKyAgICAgICBzdG9yZV9jcHVfdG9wb2xvZ3koY3Vycl9jcHVp
ZCk7DQogICAgICAgIG5vdGlmeV9jcHVfc3RhcnRpbmcoY3Vycl9jcHVpZCk7DQogICAgICAgIG51
bWFfYWRkX2NwdShjdXJyX2NwdWlkKTsNCiAgICAgICAgdXBkYXRlX3NpYmxpbmdzX21hc2tzKGN1
cnJfY3B1aWQpOw0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3RvcG9sb2d5LmMgYi9h
cmNoL3Jpc2N2L2tlcm5lbC90b3BvbG9neS5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXgg
MDAwMDAwMDAwMDAwLi43OTliMzQyM2UwYmMNCi0tLSAvZGV2L251bGwNCisrKyBiL2FyY2gvcmlz
Y3Yva2VybmVsL3RvcG9sb2d5LmMNCkBAIC0wLDAgKzEsMzAgQEANCisvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQorLyoNCisgKiBCYXNlZCBvbiB0aGUgYXJtNjQgdmVy
c2lvbiwgd2hpY2ggd2FzIGluIHR1cm4gYmFzZWQgb24gYXJtMzIsIHdoaWNoIHdhcw0KKyAqIHVs
dGltYXRlbHkgYmFzZWQgb24gc2gncy4NCisgKiBUaGUgYXJtNjQgdmVyc2lvbiB3YXMgbGlzdGVk
IGFzOg0KKyAqIENvcHlyaWdodCAoQykgMjAxMSwyMDEzLDIwMTQgTGluYXJvIExpbWl0ZWQuDQor
ICoNCisgKi8NCisjaW5jbHVkZSA8bGludXgvYXJjaF90b3BvbG9neS5oPg0KKyNpbmNsdWRlIDxs
aW51eC90b3BvbG9neS5oPg0KKyNpbmNsdWRlIDxhc20vdG9wb2xvZ3kuaD4NCisNCit2b2lkIHN0
b3JlX2NwdV90b3BvbG9neSh1bnNpZ25lZCBpbnQgY3B1aWQpDQorew0KKyAgICAgICBzdHJ1Y3Qg
Y3B1X3RvcG9sb2d5ICpjcHVpZF90b3BvID0gJmNwdV90b3BvbG9neVtjcHVpZF07DQorDQorICAg
ICAgIGlmIChjcHVpZF90b3BvLT5wYWNrYWdlX2lkICE9IC0xKQ0KKyAgICAgICAgICAgICAgIGdv
dG8gdG9wb2xvZ3lfcG9wdWxhdGVkOw0KKw0KKyAgICAgICBjcHVpZF90b3BvLT50aHJlYWRfaWQg
PSAtMTsNCisgICAgICAgY3B1aWRfdG9wby0+Y29yZV9pZCA9IGNwdWlkOw0KKyAgICAgICBjcHVp
ZF90b3BvLT5wYWNrYWdlX2lkID0gY3B1X3RvX25vZGUoY3B1aWQpOw0KKw0KKyAgICAgICBwcl9p
bmZvKCJDUFUldTogY2x1c3RlciAlZCBjb3JlICVkIHRocmVhZCAlZFxuIiwNCisgICAgICAgICAg
ICAgICAgY3B1aWQsIGNwdWlkX3RvcG8tPnBhY2thZ2VfaWQsIGNwdWlkX3RvcG8tPmNvcmVfaWQs
DQorICAgICAgICAgICAgICAgIGNwdWlkX3RvcG8tPnRocmVhZF9pZCk7DQorDQordG9wb2xvZ3lf
cG9wdWxhdGVkOg0KKyAgICAgICB1cGRhdGVfc2libGluZ3NfbWFza3MoY3B1aWQpOw0KK30NCg0K
