Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222765B21CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiIHPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIHPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:15:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29516804A1;
        Thu,  8 Sep 2022 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662650148; x=1694186148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6uMhA0RJzJ4YRHxTUvCSvfu10LMxrmslqxpjPQJ1DUM=;
  b=VNIoBpfoXpAVtwLYFhcqzlKACfWqFnIo2GewQni2tcdN6dlEoDqFafUA
   dZHhaxMfD34ygtd9LgeOuWtUmr9JdbyPMAKYNdlx3k+IWB/H2j0CiXT6h
   A8Zuh/1OKuUcjsxALf9eRLbcp3uODdjWA471QcL9ToWfA4SGHawzG+Qhc
   QfCj1ldpl8HlBTFnjF4k9MsSVFnKC777KF7iSKwj4IqBqgUkM9l3s6FEz
   3bQcOsT/9mtrVJnInI5yDcYFX0+jRJjTPSecJaM1Anp+WGwCbG3WtGFZC
   LtHatwsyW4O5N3tVzGxUxD4Ag5a8wDc//yJEszY1EWFyU6uPJDtwdqu1Z
   g==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="176240029"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 08:15:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 08:15:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 08:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSTYjw4tCrUS/m4uILqrnGGtrkFJzJs/d4m7MaEUmIAJmLfW4+VTiDplqZg4BmUMpHy/eYxL05CVEGsBh6bNxrqbvhaTpU7fmaB9lbcyVZsmtILnKGcW6Orktm5Bb1PNMDfJK+Q3VaygYOSUnb8Fho8TYpdfq2/fSeZUcOh/T8mkaonBhenj60Y0nlKWGNgDK1z0lmux/BoltqDdV3kNuwxhSCzhPftPHvRsMooF/V0IlRz1YwAR3hZPB1ugicy8/yeLbdMt82GTGKAu/XtSGKBPUnO8KPRAk5hWbOy8sB1r1Yv8yTSpZrD7ELBedTXe48r8kf+ND50Y/LggoEULsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uMhA0RJzJ4YRHxTUvCSvfu10LMxrmslqxpjPQJ1DUM=;
 b=HwwSgySEpkU/KQezixL2GIZoVTrhauNb01hHamzPtvRsuzpIVNhMAg37FwDlVmBmXQGma5QbA9mg0XT/h+dIANFOhiwEcQCVb0RDmfmWyXllUuknyjxt6kS711vdT11cUoLJEbJFtM8k/WN15sbR02w4alo1BFLFA0+POqFI9ZgelF+e9Y62c1rEV/HOdgTBu3EJdTj2OGMl7MdhVJj+Dleaqmf7QJ8TbQJbfiReNUs/2C2jO5McpvIfHt5qCExCUN/8PgrjYMeTGo124s2N9y4HpXAQXGX8Aotyd2FOWLsMQXZ8+tD+muJXKhN0Yaumj5RsfdgWzr2ZreJFhzOujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uMhA0RJzJ4YRHxTUvCSvfu10LMxrmslqxpjPQJ1DUM=;
 b=W1AZQbdJ/2impdZrg58poA3hgiL+bB1J9MJO4AX25uxirzcmKtOyWohGtj6aUdj3T/z0fpdhb+MdFVIo0ZzgJX4RzIKvp3PRspLsWkjgZkksacPXVUj/AArtyMs+lsknL4LSlWuM9jmzZ9veVIcS1AkXafxyYbCltOX9AkBu2cY=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 15:15:45 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 15:15:45 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <richard.genoud@gmail.com>,
        <radu_nicolae.pirea@upb.ro>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Topic: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Index: AQHYwfjCQbG755VmlEGUqK2TrhMH7a3VeaSAgAAuKIA=
Date:   Thu, 8 Sep 2022 15:15:44 +0000
Message-ID: <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
In-Reply-To: <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d82db1c-0e26-4022-069c-08da91ad0080
x-ms-traffictypediagnostic: CO1PR11MB4884:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nlL7kB0wwDMFsj452ou6AC92a48JkkoWBVeScOCzvnr7OunFLuyftkqsd6jbHeS3yJZCLRgQZvNEvID/rUqyjPo0ht5jY1NPnGmqxCEuUS6qSLKUy8TS5W5Ttt3sok6B/AGIkNbqEdyvFXeqWy9hHVYYFp5w9u8SKh/L2NucUlDYNeM84Y+G/8aFxkETiACD8zpjJFBWf7HlR630F2ddwif92aSNCebfHTQ78hwpGJyz2KWyQg2vwLqdQq1N8tS+p11ECQhy18geq5V6JdoBQDjRcH4WvfRuK+afYV0o78J841d0S7+j8TfOpqTcMW+Zp41VP8AeIT0rtGFe3FbKpXI98JHohBr/7lDeZSA8W/aFp9qJooW6fsQzaTRlDvWzsfqX7Ti70xRbCS+R4oq7hzAAiCvby6sGmUsMvC/+NFcvpjNCp7pvlQeR/ENLjfc+/5OeF1zj5uTzknXliLsSSdy9VUZZrXnlHHIDKhR3zLyioM5G1kv9MukBvHHu1h+9bbffKnmhvaOophNEV4K+8zStRxf1BwvyIhr6B5/AeC67JoFTi8Ged/oPC2osaAkHKJpmzkna6SybtpQ5jTRYUCNggNWo33yZI+IkD+VZH6W30J2cLCF+Ny03/VX6GB5RbI+j49bOL+GjDBR9bsRr8++FCQL4TmVOCDqwIDuyZJfya/hOtucTJhuYF7FnZMxk+kn/hOpbpcR1lLm0IwzhUe+x2bOUGEkQ1++Kor06gAMsuMNFvgC7DKH2dkrkW2+CXMUS5Mf8IwF5BpCY1+vLbweCblWdn06ARjjUZyJ4sP0WAQXGisYbtlC7b5EmMm/Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(376002)(346002)(86362001)(38100700002)(122000001)(83380400001)(186003)(2616005)(4326008)(7416002)(31686004)(5660300002)(316002)(54906003)(31696002)(6636002)(110136005)(66556008)(66946007)(8676002)(66476007)(66446008)(8936002)(91956017)(64756008)(2906002)(36756003)(76116006)(6486002)(38070700005)(71200400001)(53546011)(6512007)(6506007)(26005)(921005)(478600001)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnhZVlhpN0IxbGhnN0ZDZGxXNHYvRzQyMXVUdGV0dEdRMmV2VERma1dUWHFv?=
 =?utf-8?B?bFdFaW5lVWppY0x0TDFlU3J2SWZGSWVJL0xUbFN6UGZxYjZhNm5mVGlDdlB1?=
 =?utf-8?B?KzEwdTZndDcvU2pKMXNwZFh1MTc1eFRiZit5M2ZiZVpTYzNkLzlNWGN1b09m?=
 =?utf-8?B?QUpOdnluQ3NXcmp1MVNia1pwY2NFR2ZuSnl4ZjJla0k5WStRUlNCSFFzM25L?=
 =?utf-8?B?QXdtUXdWUHM3cDROeEsxUHhJQTQzZllweG5Hd09YTWl1c0RCd0t3UTRuTmZt?=
 =?utf-8?B?bllWQVI0bjMxRWtDbVQyRHYxVmJNVUx1WUhVTEUxNSsxbTNQRTNJamUwUG45?=
 =?utf-8?B?Z3dsMlNRdlpDckVENHZweDE0VVQ1MjgzQVZ0L2p3REtLQjU1THZTSDIyNlAy?=
 =?utf-8?B?bm55ZUVUWVZ6Q2krRVp2Mng3QS8zSnl5SzRaclVhSC84VFROQ2ozbzE1ekhs?=
 =?utf-8?B?UEdSb0lWWVhkYnNFWGl5ZlBBbU1zaTBWUDM3a0FWY3JPUWdOYXV0cmRZeUtB?=
 =?utf-8?B?clp0aTBUa3A5ZFYydXRua1JFZGFtRlZnU29zbVAvNTM2aUdjOVVrdENxeXJt?=
 =?utf-8?B?U3A5SExiY0VOcDBkNUprN1pyaGwyWWZJbHJCUURZVlRRczlERjNKWEZGVUtP?=
 =?utf-8?B?N0hnMi9QV0lrYkNiNC85dzROb09lTktzUmtIMUlvWTA3WG50RHQ0czBmT2ZS?=
 =?utf-8?B?M2tJRmxuZlhQbmh0RUhQY2NqV0JBWTlZNXQ1M3BoNVBrc1NTYXlZK1pqZTRp?=
 =?utf-8?B?ZUxmVWU4Y1NyMG1mUWczYld2Q2pJajg5R0hyMnNTSlpLdFJyUXpyVytlK1Bn?=
 =?utf-8?B?cFV5N052SDZGOWJtaytHWDRyREtaNUEyRUlQSmQ3V2dUVHRObGtwSWFJKzFs?=
 =?utf-8?B?Y1ByMEZIVmI2Z0lLaW1qUmdQMkoreVBuTE4zblpHTU1KR2tIUmxwb2Q0cW1k?=
 =?utf-8?B?NDhYYVFBNlFOcFpQQXNnZ3MzRDk1WWxWTnlZemcwbUs3MXc4L0xBd3MyYXA2?=
 =?utf-8?B?dmZOWTk5MFhyK1hnamNqMWtieEVvaFU4VDVoTG9iKytZU0V3U1ZFWFllSkNR?=
 =?utf-8?B?QWFrK09LQW1nb3BrNGhXWjZMQkVoTGxocmR3eVFLRUNQbTBVTEJ3a1MrWnZw?=
 =?utf-8?B?bS9Eby9uTlZSM1VHa1FXa2xCb3F5YVB4YTZBWllieEdJaWpadHJoU2ZqdWI5?=
 =?utf-8?B?ZFpBdFM0aFpIYmVtY0NtU0pyZ3hMT3FPRmFWV1UxcmVMT1g5T1VaY0lYcnBl?=
 =?utf-8?B?bUUrbGxxUjVQSG1manNxbWNycVpLdVQzMUVRR1lPLzl5d2VWSmo4TDZlYVVt?=
 =?utf-8?B?dHNzdG5hWnZ4VThqRzFGek9RUlNTSllYdllIQ2RIWTcxQUpmemhWUHFOdGR1?=
 =?utf-8?B?M1RlQlhRT3NSZTYyUVhPNzFoTVlVRTZORnBNcDZwR011NW9NZ2Y3V3N0MWph?=
 =?utf-8?B?RjFIdnhvVG1jUER0TVRKUHlVb1h1bzZ0VmNKb2Z1T3hUZ0hmL2JYRlBwditJ?=
 =?utf-8?B?endCWGVHNUQ2TEdmdld1UGV1bWR1SlRROTNHYlc5RFJUVlBLcjJQK2tmWndF?=
 =?utf-8?B?R1BOTzhKeitya2I3RGtNYXBnOGtOMy8rdHdJUm1TcTdub3BMSjdFdVA0aWdu?=
 =?utf-8?B?VTFsM0NZakt5MkZOMzZqQmpPZ3UydTBxK0Z4YUZMcytiTEVCelc4YUxPT2ND?=
 =?utf-8?B?ZmNMenNSTzNaQ2IzcEZycEFJZWNyYWNSYWdHYm56TGVCSWlPNXA2UHg0aSta?=
 =?utf-8?B?MEl5WU5DK2hkeUxNSzNCWFR6NllWd3V6aGtsN2dlNTBZdnNHYlkvRXRNYUQ3?=
 =?utf-8?B?V0doaDRtR3Q4WEpETTIzQ1JNZlpxaWc5L0VvSjF1RURKUEdqdS9DZzlMMmli?=
 =?utf-8?B?Y0wyVnhwK2FaaE1pT0t2SmdKTXhKMW5jaFNZNWI5L0c1Z2JSOWZ2bTFTSHAx?=
 =?utf-8?B?SktBblRPbXZ4cys4VVhoZzdHZkxpblRDa0tEVERiTnNTdk5IalVvWUpFU0dC?=
 =?utf-8?B?ZjQzY0FtenhQd29YRmF2SVNJRmZxTytlVG5EcUYyaFptUzlhSmdBNE1tKzlo?=
 =?utf-8?B?VHRzeGZhT25BVVU3NjBRM3BOTG5PVmlBWjYwSk1Kb0h4a0MvMmJYQ2pQNTdI?=
 =?utf-8?Q?jmTQ0zZr0wmmFN62+noupiKHk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8244CB6AD4D25F44948B04B3DBC57106@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d82db1c-0e26-4022-069c-08da91ad0080
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:15:44.9637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPoKets34cxrTvphzEzzp8z5dcwaXBizK6yuh9ngVVjgdb8wMD8Ox8IJTXPhPdSCbaHvCXEFlHo4gwaFOSA7KLYpMlusZk9gf6OtazPc3qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDkuMjAyMiAxNTozMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDYv
MDkvMjAyMiAxNTo1NSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBBZGQgdGhlIEFUOTFTQU05MjYw
IHNlcmlhbCBjb21wYXRpYmxlcyB0byB0aGUgbGlzdCBvZiBTQU05WDYwIGNvbXBhdGlibGVzDQo+
PiBpbiBvcmRlciB0byBoaWdobGlnaHQgdGhlIGluY3JlbWVudGFsIGNoYXJhY3RlcmlzdGljcyBv
ZiB0aGUgU0FNOVg2MA0KPj4gc2VyaWFsIElQLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdp
dSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+Pg0KPj4NCj4+IHYx
IC0+IHYyOg0KPj4gLSBOb3RoaW5nLCB0aGlzIHBhdGNoIHdhcyBub3QgaGVyZSBiZWZvcmUNCj4+
DQo+Pg0KPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2F0bWVs
LGF0OTEtdXNhcnQueWFtbCB8IDIgKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc2VyaWFsL2F0bWVsLGF0OTEtdXNhcnQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+PiBpbmRleCBiMjU1MzVi
N2E0ZDIuLjRkODAwMDY5NjNjNyAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2F0bWVsLGF0OTEtdXNhcnQueWFt
bA0KPj4gQEAgLTI2LDYgKzI2LDggQEAgcHJvcGVydGllczoNCj4+ICAgICAgICAgLSBpdGVtczoN
Cj4+ICAgICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDYwLWRiZ3UNCj4+ICAgICAg
ICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0DQo+PiArICAgICAgICAgIC0g
Y29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLWRiZ3UNCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRt
ZWwsYXQ5MXNhbTkyNjAtdXNhcnQNCj4gDQo+IFRoaXMgaXMgd2VpcmQuIFlvdSBzYXkgaW4gY29t
bWl0IG1zZyB0byAiaGlnaGxpZ2h0IHRoZSBpbmNyZW1lbnRhbA0KPiBjaGFyYWN0ZXJpc3RpY3Mi
IGJ1dCB5b3UgYmFzaWNhbGx5IGNoYW5nZSBoZXJlIGV4aXN0aW5nIGNvbXBhdGlibGVzLg0KDQoN
CkRvZXMgInNob3cgdGhhdCB0aGV5IGFyZSBpbmNyZW1lbnRhbCBJUCdzIiBzb3VuZCBiZXR0ZXIg
dGhlbj8NCg0KDQo+IFRoaXMgaXMgbm90IGVudW0sIGJ1dCBhIGxpc3QuDQo+IA0KDQoNCldoYXQg
ZG8geW91IG1lYW4gYnkgdGhpcz8gSSBrbm93IGl0IGlzIGEgbGlzdCwgSSBzcGVjaWZpZWQgc28g
aW4gdGhlIA0KY29tbWl0IG1lc3NhZ2UuDQoNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg0KDQpSZWdhcmRzLA0KCVNlcmdpdQ0K
