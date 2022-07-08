Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646BC56BBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiGHOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiGHOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:34:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A15122B2E;
        Fri,  8 Jul 2022 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657290894; x=1688826894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nQ19Y/7GIfnksI8z0EoaQ61FZmDXQDIfSkGq9RKvCY8=;
  b=jdZmksgJCXeF9ebmawjLbElQ7vy9vAaFShP+B1GnIyTFlpFJNg5Q7Nys
   sEG5ctRIIXliK0fMLETIUXrqmjM9GXCANNu3kcWHpD4npmb5hRJG41Va3
   ZlAqj3+SUjPZDzoYkGfngrBQW2IfWCDRYUykSlWQFYT5UM5yD3EZ5KBWT
   v2xX4hnYLR6xmZQrbfzroNP/PDiKrUVFg43cIlKxKBUANjtA1lhmOvncz
   CTSs3+sEUmGfqYbdIJhaKKOnWKoWnHrBPWjGedeiQEw1eeZPNL5FUjGwN
   AYaXdFcLg6REbTwzm/WcQ+Lf9wMZiYca6jbPMDWbekJxwsl1fIRQ5caIC
   w==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="171341592"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 07:34:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 07:34:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 07:34:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnF5JrJoevtXF8xG1/eCLG5S+PKsE/Gb2HczUW8NUYh9HtJW+fxzDbOwk/xHpf6DxKiwKDHiK5aHiAzqJkn2PhFDA2I0zaGOyneiPuML/35YWY1D1gHJWrGeXOfNpNFWJ0GCSRnWKVY1M+HosQQwu8wRgOOKt4lqhojpOZaD8i45ipOEDzpxwzzq3OtTX4IcJELgi/FaQEacYIQPHBMfO7kiacZdmeHAsAuIqe3nACEAa/02siNkzxxcI1Kcuho2mOnuitvLoU+23DkPsXbM1lB23QLOiIOe2i/yphHddlil8wwhTwgIHHpuHx3t/QP3JUnYZHzdcQXHuUw8ewDrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ19Y/7GIfnksI8z0EoaQ61FZmDXQDIfSkGq9RKvCY8=;
 b=iw/10wiH/TR0N7ZjIwiy344Gox4gl+NYQrTExmhGA85tvUWkHXHHYlFk5CxBPlAvTIzHCZq69+989S8LRbzMFJOiiJ0M30J+Slowzqy14BQY/dIhWm9Q9wV1rpvYTgwe6F8xUN37iNSwIriQO1p92HNvDtG6zvN4gJvc4Fa13r0xZNDxDg91hw8+DeRWpyyKmGgUMBrlyKucCBKnj8rHa4ehxO71T5zw1+DYXw6RlZI5CaDjtjs6Ujnpjtfz7HbvyA46o3MOeADRA2Rt+zlyVxP8w3vLmBmExq3p/yweaJuPmuVBJwDR0lQI7Rc+458YWrrdyf56jll9d9nWgD42+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ19Y/7GIfnksI8z0EoaQ61FZmDXQDIfSkGq9RKvCY8=;
 b=jYSDTuWzmQR/yvbWT8A5R3irQGWeX8LlmkiElQArME+wdEFpH1/E6AYa9Uk88ifoqJoD0VlacX6ASWJYRsBX/W7H0QNZ/OwaeEGeKeiyidy8lxo8bqGyqZIsI8UO991Uk+vHHbbiP8Ee3JDfMnJbP5SCIKe3UTBD2/x6GWeVaLY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BY5PR11MB4257.namprd11.prod.outlook.com (2603:10b6:a03:1ca::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 14:34:40 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 14:34:40 +0000
From:   <Conor.Dooley@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <Daire.McNamara@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 2/4] riscv: dts: fix the icicle's #pwm-cells
Thread-Topic: [PATCH v4 2/4] riscv: dts: fix the icicle's #pwm-cells
Thread-Index: AQHYktdC2ekXz7/EpkS3MZQSBPwBfq10ig4A
Date:   Fri, 8 Jul 2022 14:34:40 +0000
Message-ID: <d611589b-a51f-6807-c3bf-5953e7ff2245@microchip.com>
References: <20220708142937.1120121-1-conor.dooley@microchip.com>
 <20220708142937.1120121-3-conor.dooley@microchip.com>
In-Reply-To: <20220708142937.1120121-3-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 746b3024-2b43-45b9-6a6d-08da60eefe16
x-ms-traffictypediagnostic: BY5PR11MB4257:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1kMy8xo/6QHdOPaM5bwjhQXsqNr993SDsWRWn2D9XMmUeZEBc/UwL603DsxNkpN4nuS3LMNulY2u2sKtiFI6ygvgHMFwjjDqrg3vCHtH5DVRWg13l4DMm8eaq2sw/nU06YXH9tPTANAJgR/twwXQdrva+zlaeB8TF24EqsE+7UQA4Bo4nKYJeruKTgSHk4ECzSduQt+TvUVrfdkO5MA6ApRKCpJo0vovD5R2i6ntFIchM2sRmscU59lFc0Mo5R34gi4aPw9OxtgDD4c40wlTM0cSaQqjdbO+GnoLZZszavL0YSYlqRGvZnug/IWTH4+zaKUjdAA5ZQpO4RPNT+3es9e1WvQn7wZrdl7Ppbf1IGjDYj19N+rTB9ylYaLB4tTP3mHiMJWjHQprxOwAloUjbIGlpvt3rbgMq2DTo8etxLTETmtcWsucfytQrrSoMSKTc0U84SLgrHdSAq2gqOlMrWA4ddecvhPQe1TSx6pZVAYeVEkQurLPakjZ1HtUhRd1KWcj+AylKUTA5G3Vza40fhqjM09SiOThzRh+mK1OP6saNB+EBihXt5T9cdOj/f6O4UyxIco3Xo03+cAupRYgTAoP6byFw3d+U196M7N6BYmvhOmt6wzAggA1FkjrsCFxlEc2GvUW4qELOl7pMi7zfNSrTd5NIfy7/yRTuKOFp57NYbHNwY65NMXZxWHWf4sSNeopWpj4IWmu7eJDLruVYrVoeId1o3ArUmwIoBmPl5xTY2vYaZquxdQWQtijrUmWCZTFmkjB9q2yXqBgBGWnJgsdXChGU3xATX+tGwGQ9vL3067zdG9KCfj90tVodrxuJO2e430vFwvTzgUkeuwmCJnQj/pc4Zmai0LlfJf7rB67d1yEs0feIA3x1WrAHmD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(396003)(346002)(39860400002)(38100700002)(31696002)(86362001)(8936002)(38070700005)(41300700001)(6486002)(5660300002)(2906002)(122000001)(478600001)(316002)(36756003)(76116006)(4326008)(66556008)(91956017)(66476007)(66946007)(66446008)(64756008)(8676002)(186003)(6512007)(83380400001)(110136005)(6506007)(53546011)(71200400001)(26005)(2616005)(31686004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXdqRUJjZWxRRWtHR3FLMGh1b1B3dFVUL09KSUx5a2ZlbnZVNzZZdWdkWmpw?=
 =?utf-8?B?SHdxdGZjNXp5RW04aUVnbDdqVTdFSXExK2gvYUpNSm1xWkF1LzFuenZ3UFor?=
 =?utf-8?B?VWZlc1lORHdtaEpPWXZPZXF3RUhvVkp6T2psL2RZU3Z4WXcvbEtrQUZRaStI?=
 =?utf-8?B?YnBJRys0M2xYYnBkZ0xkSTRncTRqUFpyZlFMYjRiSnZyVXdnaTdXbnJzVnN0?=
 =?utf-8?B?YU1maHVPWVpiTEF0NE0zeVhsQjNXU2MzeFdpdzFtb2FDcy9vM3l4VmdDVkpX?=
 =?utf-8?B?YU5Gc01aNXRvMDFKdmFoUnZwWHFXMXk3YmpXc1Z2cDRVRmlTZmdEQ3dnaVVW?=
 =?utf-8?B?c1kyamsxeDFkczF5T0xSYnFUemoyS29RREVEanJsOXdLOWk3RlRlelg3cFpN?=
 =?utf-8?B?OFJROGpYSi9GczBtVWhFQnZ4WDNuWitBODRKYVpaYnlhZjRJUzVqWkV0T1Vp?=
 =?utf-8?B?L215UVgyWDVWL3BZOE45allWcW1JWXBVNlBSemZRVmk0NmZtK3lGcjlrZVRw?=
 =?utf-8?B?L0dFcW90UkxaUGVuWjJWeDlka3FhWE1lVFNTbmhhdng1Tm9yNkJpYVdpbFNL?=
 =?utf-8?B?ZHJmYmR5OWdBSWw1U1RmNlFTTFI4YVEzOVV4YUdPTWh2RG5SOS8rMFArQzBI?=
 =?utf-8?B?NXZiUmIrNEtMSnZ6TVVMdUUyemNrKzJURzI0ZWtHa0FGRHNJSkFXYjJyUWtP?=
 =?utf-8?B?c3pWVnpJV2lTQmRReWpRaU9hc1pvS0xxempmYmJUS2RVamU4VmROMkdIZ0xK?=
 =?utf-8?B?TjdhQ1YyL3ZSbFZrWUc5UDRFdE1vRk4zMmZsMFJMdktmeEd3cFBEVGtRSzNk?=
 =?utf-8?B?WVhUVWNKWFltbEJWQ09yODFpME5JblZWRlYyR3JBYUo1ZVZIcnVDNko1UEJy?=
 =?utf-8?B?THBOdHExN0l5WnA5MG56UHdPMEdnaVAvdmR5UHhEOXM4cFRzUnhqM25PUEla?=
 =?utf-8?B?cmRSRmxFUDcwQnVud2xKYnN0SytSZHQvTHB1YWtaYXZka0RkeERybTFqQzFi?=
 =?utf-8?B?UnFXMTk3LzdwSXJPWjlZU0JDWC9CTlpHZ2RQUzdYWjFUY0o3b2FGakVqa0pj?=
 =?utf-8?B?SkdtV1FyWEIxTWNSM3VOMldXOGdkM3V1S0xhYTQ3R2xzSzh5eFVBMkVGbjl3?=
 =?utf-8?B?TGtYSXZpeGkvTmdLd3ZqU0lwUk1BMjB4RXFNMW1UK3JpNFFvZkQrOStkR2wz?=
 =?utf-8?B?SlZBbG4ybHBhWlZDK2QxMzQ0bUJVeUorYm4wbklUc2w5UFRPK3F5Q2F3YWMr?=
 =?utf-8?B?aWMvNmFKVTlDTGZlS2pUVUMyYThERnJpMWhOUG5yUUJGaGpwd3NhK0toYlcv?=
 =?utf-8?B?WUo5eHdBZldXQkt4WXF0NUFjUEdvWFRwVm9ib1VweE90VkcrZXVtWXNJOW1P?=
 =?utf-8?B?cVErTmtSeEdzcFdpS2ovM0VFRjF4TTdXRXdqeGZwM3RFa0tnMmg2c2RUQ1FW?=
 =?utf-8?B?aVRDUjlLTUtPc2pIMVhKeVNGWkxDNEJudjJrVXFFcTd6TjJPZUxFTkxaNnJj?=
 =?utf-8?B?RTFVaXFwRWgvTmpaUjl1T2EvdmtBMGdadnlSWFVuWUNobmoyKzBiS2NSZ1Ay?=
 =?utf-8?B?U3JOMm1XeUNiUHhxam1GWUMzZ0lyQWxsMENoanhmTzV0aVNiaXpvWmxUK1Rt?=
 =?utf-8?B?aWF1RVpoUzRua1BpLy9VOFhYRFFkek5BWVh4NUVpUlFZMVFYOFpFWk55cUFT?=
 =?utf-8?B?cWc4K0t3NTRLcVF4aUQyc2E5aDdiRDRyR0lhMTVyY0VsNnpnemV5bFFFeHdF?=
 =?utf-8?B?MzVlOTJXVXgrQmlzemFveW1HdWVpaW9oVTAxZ3p5ZjhFS1p5VklvSHdTSUc4?=
 =?utf-8?B?VE1sWTFjbHhqL2xvMllVNGFpdUlZVTRKR2NMVHNqTnltRDNWdGZlMnBrMXp4?=
 =?utf-8?B?c2lteVFEQm5pVXJ1MVlqQ0dTWmh3KzVRVHF3b090WXRBNUtLSG1VYzBxL1Va?=
 =?utf-8?B?eXN5S1duaGo3alREM01UQ3Q5TjRBdHhSMnZwZ09RenE1UVF0dWVoeFRvcC9o?=
 =?utf-8?B?MWhLRDRIdlM3KzQyWGl4SE5tL1h6OVhPV3hXSEJlcEpZZnRHV05UcVBvQ014?=
 =?utf-8?B?MDhGMUFkUGRSWmxGSkU4cmpIUis0MVNhYTllZ0VFeU50Q2F5eHVhL0xJMTNr?=
 =?utf-8?Q?iN3Aas4zpzE3Gm+DArdArAW0T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20ECB427E469A049B55D8CB1310430E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746b3024-2b43-45b9-6a6d-08da60eefe16
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 14:34:40.7243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCct0Jgq3nww7Jp0eOxQAUnTlAf47JuZtWL7WDlozdHfy/EwUseUvVDr3/KbTXm77O4WxTBt2lkl5qrkQRH5G/TpOXayA6qdS3BEWgR4HBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4257
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDcvMjAyMiAxNToyOSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBcI3B3bS1jZWxscyBm
b3IgdGhlIEljaWNsZSBraXQncyBmYWJyaWMgUFdNIHdhcyBpbmNvcnJlY3RseSBzZXQgdG8gMiAm
DQo+IGJsaW5kbHkgb3ZlcnJpZGRlbiBieSB0aGUgKG91dCBvZiB0cmVlKSBkcml2ZXIgYW55d2F5
LiBUaGUgY29yZSBjYW4NCj4gc3VwcG9ydCBpbnZlcnRlZCBvcGVyYXRpb24sIHNvIHVwZGF0ZSB0
aGUgZW50cnkgdG8gY29ycmVjdGx5IHJlcG9ydCBpdHMNCj4gY2FwYWJpbGl0aWVzLg0KPiANCj4g
Rml4ZXM6IDcyNTYwYzY1NTliOCAoInJpc2N2OiBkdHM6IG1pY3JvY2hpcDogYWRkIGZwZ2EgZmFi
cmljIHNlY3Rpb24gdG8gaWNpY2xlIGtpdCIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xl
eSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCkdhaCwgSSBtZXNzZWQgdGhpcyBwYXRj
aCB1cC4uLiBJJ2xsIHJlc2VuZC4NCg0KPiAtLS0NCj4gICAuLi4vZHRzL21pY3JvY2hpcC9tcGZz
LWljaWNsZS1raXQtZmFicmljLmR0c2kgfCAgIDIgKy0NCj4gICAuLi4vZHRzL21pY3JvY2hpcC9t
cGZzLXR5c29tLW0tZmFicmljLmR0c2kgICAgfCAgMTggKysNCj4gICAuLi4vcmlzY3YvYm9vdC9k
dHMvbWljcm9jaGlwL21wZnMtdHlzb20tbS5kdHMgfCAxODUgKysrKysrKysrKysrKysrKysrDQo+
ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLXR5
c29tLW0tZmFicmljLmR0c2kNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290
L2R0cy9taWNyb2NoaXAvbXBmcy10eXNvbS1tLmR0cw0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC1mYWJyaWMuZHRzaSBiL2Fy
Y2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC1mYWJyaWMuZHRzaQ0K
PiBpbmRleCAwZDI4ODU4YjgzZjIuLmUwOWExM2FlZjI2OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9y
aXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1pY2ljbGUta2l0LWZhYnJpYy5kdHNpDQo+ICsr
KyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC1mYWJyaWMu
ZHRzaQ0KPiBAQCAtOCw3ICs4LDcgQEAgY29yZV9wd20wOiBwd21ANDEwMDAwMDAgew0KPiAgIAkJ
Y29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsY29yZXB3bS1ydGwtdjQiOw0KPiAgIAkJcmVnID0gPDB4
MCAweDQxMDAwMDAwIDB4MCAweEYwPjsNCj4gICAJCW1pY3JvY2hpcCxzeW5jLXVwZGF0ZS1tYXNr
ID0gL2JpdHMvIDMyIDwwPjsNCj4gLQkJI3B3bS1jZWxscyA9IDwyPjsNCj4gKwkJI3B3bS1jZWxs
cyA9IDwzPjsNCj4gICAJCWNsb2NrcyA9IDwmZmFicmljX2NsazM+Ow0KPiAgIAkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gICAJfTsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
bWljcm9jaGlwL21wZnMtdHlzb20tbS1mYWJyaWMuZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMv
bWljcm9jaGlwL21wZnMtdHlzb20tbS1mYWJyaWMuZHRzaQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjk4ZjY0MmU4M2FkNA0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtdHlzb20tbS1mYWJyaWMu
ZHRzaQ0KPiBAQCAtMCwwICsxLDE4IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjAgT1IgTUlUKQ0KPiArLyogQ29weXJpZ2h0IChjKSAyMDIyIE1pY3JvY2hpcCBUZWNo
bm9sb2d5IEluYyAqLw0KPiArDQo+ICsvLyAjaW5jbHVkZSAiZHQtYmluZGluZ3MvbWFpbGJveC9t
aXYtaWhjLmgiDQo+ICsNCj4gKy8gew0KPiArCWZhYnJpY19jbGszOiBmYWJyaWMtY2xrMyB7DQo+
ICsJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiArCQkjY2xvY2stY2VsbHMgPSA8MD47
DQo+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDw2MjUwMDAwMD47DQo+ICsJfTsNCj4gKw0KPiArCWZh
YnJpY19jbGsxOiBmYWJyaWMtY2xrMSB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2si
Ow0KPiArCQkjY2xvY2stY2VsbHMgPSA8MD47DQo+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDwxMjUw
MDAwMDA+Ow0KPiArCX07DQo+ICt9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0
cy9taWNyb2NoaXAvbXBmcy10eXNvbS1tLmR0cyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9j
aGlwL21wZnMtdHlzb20tbS5kdHMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMDAwMDAwLi4wYjY2NGM1OTEyNTUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLXR5c29tLW0uZHRzDQo+IEBAIC0wLDAgKzEsMTg1
IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAq
IE9yaWdpbmFsIGFsbC1pbi1vbmUgZGV2aWNldHJlZToNCj4gKyAqIENvcHlyaWdodCAoQykgMjAy
MC0yMDIyIC0gQWxkZWMNCj4gKyAqIFJld3JpdHRlbiB0byB1c2UgaW5jbHVkZXM6DQo+ICsgKiBD
b3B5cmlnaHQgKEMpIDIwMjIgLSBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAu
Y29tPg0KPiArICovDQo+ICsNCj4gKy9kdHMtdjEvOw0KPiArDQo+ICsjaW5jbHVkZSAibXBmcy5k
dHNpIg0KPiArI2luY2x1ZGUgIm1wZnMtdHlzb20tbS1mYWJyaWMuZHRzaSINCj4gKw0KPiArLyog
Q2xvY2sgZnJlcXVlbmN5IChpbiBIeikgb2YgdGhlIHJ0Y2NsayAqLw0KPiArI2RlZmluZSBNVElN
RVJfRlJFUQkJMTAwMDAwMA0KPiArDQo+ICsvIHsNCj4gKwltb2RlbCA9ICJBbGRlYyBUeVNPTS1N
LU1QRlMyNTBUIjsNCj4gKwljb21wYXRpYmxlID0gImFsZGVjLHR5c29tLW0tbXBmczI1MHQiLCAi
bWljcm9jaGlwLG1wZnMiOw0KPiArDQo+ICsJYWxpYXNlcyB7DQo+ICsJCWV0aGVybmV0MCA9ICZt
YWMwOw0KPiArCQlldGhlcm5ldDEgPSAmbWFjMTsNCj4gKwkJc2VyaWFsMCA9ICZtbXVhcnQwOw0K
PiArCQlzZXJpYWwxID0gJm1tdWFydDE7DQo+ICsJCXNlcmlhbDIgPSAmbW11YXJ0MjsNCj4gKwkJ
c2VyaWFsMyA9ICZtbXVhcnQzOw0KPiArCQlzZXJpYWw0ID0gJm1tdWFydDQ7DQo+ICsJCWdwaW8w
ID0gJmdwaW8wOw0KPiArCQlncGlvMSA9ICZncGlvMjsNCj4gKwl9Ow0KPiArDQo+ICsJY2hvc2Vu
IHsNCj4gKwkJc3Rkb3V0LXBhdGggPSAic2VyaWFsMToxMTUyMDBuOCI7DQo+ICsJfTsNCj4gKw0K
PiArCWNwdXMgew0KPiArCQl0aW1lYmFzZS1mcmVxdWVuY3kgPSA8TVRJTUVSX0ZSRVE+Ow0KPiAr
CX07DQo+ICsNCj4gKwlkZHJjX2NhY2hlX2xvOiBtZW1vcnlAODAwMDAwMDAgew0KPiArCQlkZXZp
Y2VfdHlwZSA9ICJtZW1vcnkiOw0KPiArCQlyZWcgPSA8MHgwIDB4ODAwMDAwMDAgMHgwIDB4MmUw
MDAwMDA+Ow0KPiArCQlzdGF0dXMgPSAib2theSI7DQo+ICsJfTsNCj4gKw0KPiArCWRkcmNfY2Fj
aGVfaGk6IG1lbW9yeUAxMDAwMDAwMDAwIHsNCj4gKwkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsN
Cj4gKwkJcmVnID0gPDB4MTAgMHgwMDAwMDAwMCAweDAgMHg0MDAwMDAwMD47DQo+ICsJCXN0YXR1
cyA9ICJva2F5IjsNCj4gKwl9Ow0KPiArDQo+ICsJc29jIHsNCj4gKwl9Ow0KPiArDQo+ICsJbGVk
cyB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZ3Bpby1sZWRzIjsNCj4gKwkJc3RhdHVzID0gIm9rYXki
Ow0KPiArDQo+ICsJCWxlZDAgew0KPiArCQkJZ3Bpb3MgPSA8JmdwaW8xIDIzIDE+Ow0KPiArCQkJ
ZGVmYXVsdC1zdGF0ZSA9ICJvbiI7DQo+ICsJCQlsaW51eCxkZWZhdWx0LXRyaWdnZXIgPSAiaGVh
cnRiZWF0IjsNCj4gKwkJfTsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KPiArJmkyYzAgew0KPiArCXN0
YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZpMmMxIHsNCj4gKwlzdGF0dXMgPSAib2th
eSI7DQo+ICsJaW5hMjE5OiBpbmEyMTlANDUgew0KPiArCQlzdGF0dXMgPSAib2theSI7DQo+ICsJ
CWNvbXBhdGlibGUgPSAidGksaW5hMjE5IjsNCj4gKwkJcmVnID0gPDB4NDU+Ow0KPiArCQlzaHVu
dC1yZXNpc3RvciA9IDwweDdkMD47DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gKyZncGlvMSB7DQo+
ICsJaW50ZXJydXB0cyA9IDwyNyAyOCAyOSAzMCAzMSAzMiAzMyA0NyAzNSAzNiAzNyAzOCAzOSA0
MCA0MSA0MiA0MyA0NCA0NSA0NiAzNCA0OCA0OSA1MD47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0K
PiArfTsNCj4gKw0KPiArJm1hYzAgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gKwlwaHktbW9k
ZSA9ICJnbWlpIjsNCj4gKwlwaHktaGFuZGxlID0gPCZwaHkwPjsNCj4gKw0KPiArfTsNCj4gKw0K
PiArJm1hYzEgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gKwlwaHktbW9kZSA9ICJnbWlpIjsN
Cj4gKwlwaHktaGFuZGxlID0gPCZwaHkxPjsNCj4gKwlwaHkxOiBldGhlcm5ldC1waHlAMSB7DQo+
ICsJCXJlZyA9IDwxPjsNCj4gKwkJdGksZmlmby1kZXB0aCA9IDwweDAxPjsNCj4gKwl9Ow0KPiAr
CXBoeTA6IGV0aGVybmV0LXBoeUAwIHsNCj4gKwkJcmVnID0gPDA+Ow0KPiArCQl0aSxmaWZvLWRl
cHRoID0gPDB4MDE+Ow0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsmbWJveCB7DQo+ICsJc3RhdHVz
ID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJm1tYyB7DQo+ICsJbWF4LWZyZXF1ZW5jeSA9IDwy
MDAwMDAwMDA+Ow0KPiArCWNhcC1tbWMtaGlnaHNwZWVkOw0KPiArCWNhcC1zZC1oaWdoc3BlZWQ7
DQo+ICsJbm8tMS04LXY7DQo+ICsJZGlzYWJsZS13cDsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+
ICt9Ow0KPiArDQo+ICsmbW11YXJ0MSB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4g
Kw0KPiArJm1tdWFydDIgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZt
bXVhcnQzIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmbW11YXJ0NCB7
DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnJlZmNsayB7DQo+ICsJY2xv
Y2stZnJlcXVlbmN5ID0gPDEyNTAwMDAwMD47DQo+ICt9Ow0KPiArDQo+ICsmcnRjIHsNCj4gKwlz
dGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmc3BpMCB7DQo+ICsJc3RhdHVzID0gIm9r
YXkiOw0KPiArfTsNCj4gKw0KPiArJnNwaTEgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gKwlw
c2VGbGFzaEAwIHsNCj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCSNzaXplLWNlbGxz
ID0gPDE+Ow0KPiArCQljb21wYXRpYmxlID0gIm4yNXExMjhhMTEiLCAiamVkZWMsc3BpLW5vciI7
DQo+ICsJCXN0YXR1cyA9ICJva2F5IjsNCj4gKwkJcmVnID0gPDB4MD47DQo+ICsJCXNwaS1tYXgt
ZnJlcXVlbmN5ID0gPDEwMDAwMDAwPjsNCj4gKw0KPiArCQlwYXJ0aXRpb25AdGVzdC0wIHsgLyog
dGVzdCBwdXJwb3NlcyAqLw0KPiArCQkJbGFiZWwgPSAicXNwaS10ZXN0LTAiOw0KPiArCQkJcmVn
ID0gPDB4MDAwMDAwMDAgMHgwMDgwMDAwMD47DQo+ICsJCX07DQo+ICsJCXBhcnRpdGlvbkB0ZXN0
LTEgeyAvKiB0ZXN0IHB1cnBvc2VzICovDQo+ICsJCQlsYWJlbCA9ICJxc3BpLXRlc3QtMSI7DQo+
ICsJCQlyZWcgPSA8MHgwMDgwMDAwMCAweDAwODAwMDAwPjsNCj4gKwkJfTsNCj4gKwkJcGFydGl0
aW9uQHRlc3QtMiB7IC8qIHRlc3QgcHVycG9zZXMgKi8NCj4gKwkJCWxhYmVsID0gInFzcGktdGVz
dC0yIjsNCj4gKwkJCXJlZyA9IDwweDAxMDAwMDAwIDB4MDA4MDAwMDA+Ow0KPiArCQl9Ow0KPiAr
CQlwYXJ0aXRpb25AdGVzdC0zIHsgLyogdGVzdCBwdXJwb3NlcyAqLw0KPiArCQkJbGFiZWwgPSAi
cXNwaS10ZXN0LTMiOw0KPiArCQkJcmVnID0gPDB4MDE4MDAwMDAgMHgwMDgwMDAwMD47DQo+ICsJ
CX07DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gKyZzeXNjb250cm9sbGVyIHsNCj4gKwlzdGF0dXMg
PSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmdXNiIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+
ICsJZHJfbW9kZSA9ICJob3N0IjsNCj4gK307DQoNCg==
