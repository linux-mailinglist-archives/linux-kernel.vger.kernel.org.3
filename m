Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93A53F69C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiFGGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiFGGzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:55:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5BB8BFA;
        Mon,  6 Jun 2022 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654584937; x=1686120937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ry7ia8R3TY7QKX2rWw/fqUr4JJZov9lPSAiZ/KL5EBw=;
  b=p1+8FRpts5xGQ1kjbdyROFV/RGxZcPuyWQUZF8hsTjNJuqfCjpYe9NGf
   6nC6rw7nmnA3syMqBYosTvCpUEY/5u07XJ+mJGTDWsXJrAeSIcqzrSXra
   ikzINmvhXEySbEVCZFbW9Tg/fSMrTRErcodsQmx9PYsqKynjOG2+sUT1y
   T2TvQBLQauYGpF0OGFb5djHUpwV0Rx1ZBz0uBtPogJXSAix2bT2WBuYvb
   p4jQyn+UsNCQ0k7iFU7O85BY3ZgnIgujolJ7xlykOLemMWMVJFi+PfMB1
   3yngsVaBKxCb4rvjQvy+aGCdgmSxJEUIi447AnZW9QjLf1hPpHLu3h6cN
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="176818747"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 23:55:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 23:55:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 6 Jun 2022 23:55:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdL4i5QqyXGBPTa5E3sYIhSqfvCbZI1ReICSqsb/vStY1mEvopo8NAKSDOi13xUVZp33soqiwEDxjZAgB7Hd2j8Kr2XFFdJR4RLOlPZlH8GeKgfWIlNE84OhxoTpzIdTjmO+7YYQSovZJhb8SusF1sAajMjmafT4sJyR4QMzK50oa+JS0WfYJCXgKQWOZxuJkz7KLVYIcY67amur0BDJ+T/6+ZstD211TD9oltLB/PPO7emYrbelDDg57xyPkmgZXa5sAegXByHx3OFdzD3RAZolTMPNUmjNa3s99ZKfTTB4U7FMCMl7Sd2JSZq0QZgPDMhpDvXAE8i2arUoo9Txkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry7ia8R3TY7QKX2rWw/fqUr4JJZov9lPSAiZ/KL5EBw=;
 b=A3KvIrV9HiBTRErH2NlUYxnQrlIszaFgN0srw8cuXVNesSbTK0lWFa3EdVACr+94Z8ta7/GJN48rVs0axizNlU3uJXqTMzs+eaU2vOJYny+ODdTx1D2ewQ/ws9WcdPtktYozJc7JjgZu36B/tBIDiE/fdvPcLcNBdr/E1EKnuuaxu5jWdT0BegqUo71QiHKofotBLN7rd/7cBprmi/QSYAGTvhLf4emZOcwl/sk4l7feRPpGUl+5naS6NxB7EIkoqTIb2vXJ71LZpkj6CFp6izrNf4Tz1cxU1DddnHzTTm/BWjIo2mXWlNFxLnpfZWdz/AFvTQ7NQ1JOtCpPpHVz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry7ia8R3TY7QKX2rWw/fqUr4JJZov9lPSAiZ/KL5EBw=;
 b=tJF67HDN267odI3pXRFgtl2TqQ35YuxaRI6wMiwA0hATdnRLhE1evZYXDineTHbJIS6IWKxZee0w7/tFovDpFfU89f1RwrVz/TpW1JgQeahOaEHuowoCY0qKd4ucQSuXtBtTASg6ytxXST1g9MaaaJcqToHLSEZYxpTfVqDuz58=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by DM6PR11MB3868.namprd11.prod.outlook.com (2603:10b6:5:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 06:55:30 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 06:55:30 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYd0Qh7YtNtR/jxE2kV4m9yLBHUK1CXHeAgAAEzDCAASao0A==
Date:   Tue, 7 Jun 2022 06:55:30 +0000
Message-ID: <CO1PR11MB4865DEDC51BE3AAE0F8C6FDC92A59@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-2-kavyasree.kotagiri@microchip.com>
 <ba24037d-8c31-ea35-6fc9-ed8a61118848@linaro.org>
 <CO1PR11MB4865475C31FACD142BB9752592A29@CO1PR11MB4865.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB4865475C31FACD142BB9752592A29@CO1PR11MB4865.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ce7aa98-1f9a-4373-105f-08da4852b5fe
x-ms-traffictypediagnostic: DM6PR11MB3868:EE_
x-microsoft-antispam-prvs: <DM6PR11MB38681AE52F7FF166F068BF2692A59@DM6PR11MB3868.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeJQB8MK7peImloj0TpKEWvwFpJ1jFvh8JpIMwQ4ql8kWEFHnNX4ayIaqAhmi+CykuJGpcBxFz5MI8XeSoGhYyuXE+1UcbSzc1H65bPjZX4GoXYolZs0fD2yRE/jY6u0uPll0mOAVhCAcrpVC3NJrt9kkf/6FcP7PoyetFLGkBITAHBMaL+Rs+VQFwrWpOOb7Jlb8LPuxr1le2NaF/fOShoeMkqwKeMQf+Y4zKH9mktgNM9NCes0vyBMXchZm1Q76++sWT2YRnv0I/TxGJcHHhZW54yM7glMYUBZ19OZb3P0z6Vx3K7AvZz0/UQLSAjFUVFL6MYBOyUuqv0cTSX6lkhQqBjhb2yTYAW4kB/u0eyU9Fi9mMerSg1ZR+Uz58yXZeSbPaRhagi+cXzcVTT6gvWIsdT4AH9+rgWUyojezYCcl1+C9LjvO7aviB+n6dfdo4Lc06nOxfJQ8r/CX2YrgtCaDsgfFaYPH9u4b8WeQEeQoYTZhxUpx+1j7apjn1IRVKV/HE1asmYGYQJw5cITe0+OasUJxEogllEMIs3eBUWKcQ0UKJQLkz09Qi59nBKMlY0w3y3wsXiyY8EveGlkk0+cTzQ6znnJ+VzX2u43h0UFMUDY/I4GPDfNHi1lgb/OnINvi/m233Dr0RTay9XTxCc4XwLgQ1HBDN8q9q0daJgyPjCBgE9hh10iqpSuaXt4/lvUECfe/TB9sf+QWshXUxhPeaFA2Yxla4oIAqvM2/pjbyldnu6WrA6yr+PHj6X0CVm43xmFAFjn29ugYhhpuAIiKqdHWmI59CHIKPNEKJnI1hPSgHauOJCMHC0NGJ4Mhk90SUNRIi/zw0WXkh4kmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(33656002)(38100700002)(86362001)(38070700005)(122000001)(508600001)(5660300002)(2906002)(966005)(52536014)(316002)(76116006)(71200400001)(64756008)(66476007)(4326008)(8676002)(66446008)(66556008)(66946007)(83380400001)(55016003)(186003)(107886003)(6506007)(7696005)(26005)(9686003)(8936002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z04xS25BaEtpc2xCVmRXaGpjL0tGT3FhTnpLbENqcGkxYkNCSTNLejhCODlt?=
 =?utf-8?B?UVNqUjRUSG1OZmpTZVZqUktqMmYxaktENVhhNkhNaHQ5alRtMFRaR0EvdXJj?=
 =?utf-8?B?UWtEM29uWU4zR1kyNXB4bFJKVWIyRm5sTlBENDNqb2xQNFErdXFjZ0h5QzZS?=
 =?utf-8?B?UU9RbXRsYVJmSmNUYUtxSmZXVlBXcFBPOEdaNGlrTlM2V1BOUUc4eDZtTFhE?=
 =?utf-8?B?aXJJaDJwRWVtelZ5WStobmk5dXExWWpiTVhlVm9EeUlDT0VPVlhKcFE4NUx0?=
 =?utf-8?B?UjRQaXQxcnpUZGxrdVo2NGgvTlE0MmI5TllPVDJBY0k5NzBxdUltdjVUTndw?=
 =?utf-8?B?UnlhUTRWVHA0VStkSHFqSXpzcWdEaHp4SHRWVVpkOGZqalZsQ1lTRUdVMnQx?=
 =?utf-8?B?SmZEYjdKTWkvQ3NHZjV2U3pzVHZ2T2tBWUdCQU83Ky9HNm0wcDBoaGkzZk5O?=
 =?utf-8?B?cUdNWEwxM2dQSkx4Y1dOWmtTUmhvZ2N1d3ZtZ25idlFxeWl3b0FLWS9obklx?=
 =?utf-8?B?bnFqUURiWXdpY0pPR3gvQWw5YWxucGpaUjNtWkVGTXJqcGZMU3l2RmZTbGN2?=
 =?utf-8?B?dFNKN3BwVDR0aENuVDJ2cWZOY0IyVUdmS0ZZVGM4V29hK285bmxsN283TUU1?=
 =?utf-8?B?VUVrK3lGTDErQWxadjJkTEVHZnJlbHl4UTRhNVNhQmJBbnBSdThtaTFxRzF2?=
 =?utf-8?B?a0k5V1pUd2NZakFxZVVQMFVOYURvY2RzbkJ3KzF2b1pYUjZhbEFERWozZFZD?=
 =?utf-8?B?TUtiZWQ5Y3AwWk9rMGtjVlFKMGdqTnUrUmtuRUZuTmc3Vm1HVGFQcjJ1K1ZQ?=
 =?utf-8?B?V2ExZE9ncTAzcTNueVJoZ3B3c0ZRQmFUdHIzSklocExKREg4VndvQVRIeGU0?=
 =?utf-8?B?RllsWXVkQmEwdkJCb2QyRGk0blMxb0dtdm1QMXVOWms2WWVtemp5WDJjNldY?=
 =?utf-8?B?eEZ0Vit5UUc0a0IxbVJzaDZRbnh4OXJlblc3S09Lalpjc3NvdUo2Z0xjcXlW?=
 =?utf-8?B?Q0taNGlPZW9oQlc3cEhCL2tZQVQvTmk5WjFkYmlIVndtZldXeWdENUtUZFVi?=
 =?utf-8?B?RmJ2bDkwOGxQakJocmlBVldRWW9VSmtUd3lRSFEwUjFuNGFMQmFhNG5ESEVU?=
 =?utf-8?B?WDc5SDJmM2JQNWUxU241dEJPZmgrS2NDYy94c0RFRjFKTm9MR01ZN1p5Titv?=
 =?utf-8?B?WXlPa0o5TnEvV1hHbjBSWjRqcTd3UTFDZ1hRUjAzUU4zN3hJMU9EZnpvWVEz?=
 =?utf-8?B?N0VaczNLMFlTZjlJalUwMEd3OVVlMHZkU2xGVFF5Sm9ZaUtNY3Q4UWJJRXdt?=
 =?utf-8?B?N2lIcVY5bnJtNDF4SXk2ald3Ulc3ZUVqK0ZFOTBrbE5GOVUrNzFyUHVyQVRz?=
 =?utf-8?B?WEhzMU05MTB4RmdodjZYUVdlVGJraEI0UTV4Unk5SWVyS3pLUnBRd1RESTVo?=
 =?utf-8?B?YjRod3hWV2xLSTIzSThjRzcrOVd5THJUZEl5WkFqLzYzRXJIQW90R0ZxS3J2?=
 =?utf-8?B?ZlpFdGNjaG9DbEpYU1VmQy9RSHlTSVp0bGJaSSt3NEZGalFLcDhLaW5sZ3ZV?=
 =?utf-8?B?WU5Ka3RTZW5KaWNNQ29Qd3F4bXdxdmZIWXdxN2oyZWRFUEpteFNYckVFc2h5?=
 =?utf-8?B?c1p0cFlVallrd0xLeWNlUjRET3FNZUNqM3JKQm9YdUVrc0ZuNVlOSXFTd3pu?=
 =?utf-8?B?eFlBOTdvcnNHU1ZQREFMa25UVVV6NHp6a1Y1eWkwL0VvN1RsV09EV1Iwa0RD?=
 =?utf-8?B?UmlpdmxIS1FHS3huMVJwTENkZkczblc5QnA1TG9DcHNkd2hNY0hOM0lKNDJw?=
 =?utf-8?B?R0dJT1N6VWM2VklXS2duNGh4WkJkUlpNbHBBZW1nWlR1aDEya3IxZ3AreWZM?=
 =?utf-8?B?ZGwyVG05dzlleWFKanhQSngzbndXQlo4Sk9yaFpkZXUwR3lRUEhmTlR4UXlL?=
 =?utf-8?B?MFFDakY3aUI5N3p4U3c5bnh5NjVHNGdzWGRaSTYxbk0rY1I5WjNHekpWalVL?=
 =?utf-8?B?T25KcFJWem11M0xiU0JpNXlWQWZuby9ONkZ1T2hVMVpMYUI1ZXpkM0VIZHVI?=
 =?utf-8?B?c2FzblVJTGN4MWpuR24vQ0w1VEo0Z0xydThpUVU0RThiNEVrMnQrVWpWQ0cv?=
 =?utf-8?B?STB4NHdZVml2WHdKeHg1MFFVeXNtRGZuWS9hRFpYa29NU3Arekl0TkZJcnd6?=
 =?utf-8?B?RW9FNmdOTWdYcTQrb1JXMWY0bmJtbG9Vd21QVmJMMkx2QzNqalJnaWJPVEl5?=
 =?utf-8?B?VHltci9FdzhqWTdmMXR6ZHZsc25uVGNNUkNHTEYzY2FqUVA5TmxaOXZxMVpa?=
 =?utf-8?B?Z3pPZndLT253RTJXaVVXbDFUNXc4bFhnMDJmT05mb1FWU0NzdTNHUFdwZWoy?=
 =?utf-8?Q?rhGfnU2fOPEXrCjI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce7aa98-1f9a-4373-105f-08da4852b5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 06:55:30.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpx0DkDqwvUbeNxLpQVMV/iR3CSm2+HSRXSegR0M1BI1z2fWlHNhIS2AFcww0WwuvfOwXZtPSvLSr+ZWSNuFhgn2Pos8Og8X8mVK6AwI1Cz0r1lXSlaia0RQn07v4o9B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3868
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gQ29udmVydCB0aGUgQXRtZWwgZmxleGNvbSBkZXZpY2UgdHJlZSBiaW5kaW5ncyB0byBq
c29uIHNjaGVtYS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdp
cmkgPGthdnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAg
Li4uL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwgICAgICAgICAgIHwgOTcgKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1m
bGV4Y29tLnR4dCB8IDYzIC0tLS0tLS0tLS0tLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOTcg
aW5zZXJ0aW9ucygrKSwgNjMgZGVsZXRpb25zKC0pDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29t
LnlhbWwNCj4gPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hdG1lbC0NCj4gPiBmbGV4Y29tLnR4dA0KPiA+ID4NCj4gPiA+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhj
b20ueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1l
bCxmbGV4Y29tLnlhbWwNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjIyMWJkODQwYjQ5ZQ0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlh
bWwNCj4gPiA+IEBAIC0wLDAgKzEsOTcgQEANCj4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiA+ICslWUFNTCAxLjINCj4g
PiA+ICstLS0NCj4gPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21mZC9h
dG1lbCxmbGV4Y29tLnlhbWwjDQo+ID4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gPiArDQo+ID4gPiArdGl0bGU6IERldmljZSB0
cmVlIGJpbmRpbmdzIGZvciBBdG1lbCBGbGV4Y29tIChGbGV4aWJsZSBTZXJpYWwNCj4gPiBDb21t
dW5pY2F0aW9uIFVuaXQpDQo+ID4NCj4gPiBUaGVyZSB3YXMgYSB2MiBvZiB0aGUgc2FtZSBwYXRj
aCB0byB3aGljaCBhbHJlYWR5IGNvbW1lbnRlZC4gTm93IHlvdQ0KPiA+IHNlbmQgdGhlIHNhbWUg
cGF0Y2gsIHdpdGhvdXQgY29tbWVudHMgYXBwbGllZCBhcyB2MS4gVGhpcyBkb2VzIG5vdCBtYWtl
DQo+ID4gYW55IHNlbnNlLg0KPiA+DQo+ID4gUGxlYXNlIHZlcnNpb24geW91ciBwYXRjaGVzIGNv
cnJlY3RseSBhbmQgZG8gbm90IGlnbm9yZSByZWNlaXZlZCBmZWVkYmFjay4NCj4gPg0KPiANCj4g
SGksDQo+IA0KPiBGWUksIGxhbjk2NnggZmxleGNvbSBjaGlwLXNlbGVjdCBkcml2ZXIgc3VwcG9y
dCBpcyBtb3ZlZCB0byBhdG1lbC1mbGV4Y29tLmMNCj4gcmF0aGVyIHRoYW4NCj4gaW1wbGVtZW50
aW5nIGEgbmV3IG11eCBkcml2ZXIuIFNvLCBJIHNlbnQgbmV3IHZlcnNpb24gbm93IHdpdGggZHJp
dmVyDQo+IGNoYW5nZXMgaW4gZHJpdmVzL21mZC9hdG1lbC1mbGV4Y29tLmMNCj4gSSBvbmNlIGFn
YWluIGdvbmUgdGhyb3VnaCB5b3VyIHYyIGNvbW1lbnRzLiBJIG1pc3NlZCB0aGlzIGNvbW1lbnQN
Cj4gInMvRGV2aWNlIHRyZWUgYmluZGluZ3MvLyIuDQo+IEV4Y2VwdCB0aGF0IEkgYWRkcmVzc2Vk
IHJlbWFpbmluZyBhbGwgb3RoZXIgY29tbWVudHMgZm9yIGR0LWJpbmRpbmdzDQo+IHBhdGNoZXMu
DQo+ID4NCkhpLA0KDQpQbGVhc2UgbGV0IG1lIGtub3cgd2hhdCB5b3UgbWVhbiBieSAiIHMvRGV2
aWNlIHRyZWUgYmluZGluZ3MvLyIgY29tbWVudD8NCg0KVGhhbmtzLA0KS2F2eWENCj4gPiBCZXN0
IHJlZ2FyZHMsDQo+ID4gS3J6eXN6dG9mDQo=
