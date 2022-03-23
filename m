Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5774E4DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiCWIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242464AbiCWIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:07:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EE070F7D;
        Wed, 23 Mar 2022 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648022787; x=1679558787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r+09uykzwMX3G7/WP/ZDWCuvDQuKAg1GSwar751SuVo=;
  b=vmFa8iPk4/OC6nNlMKVJkA1NWn+pRYmkwjmtlE7/jdTB+BSuPFJB7tDd
   hMl9MoJa+sfol44COGwJQN1mzLxwWLdQwT9wRMOEg24PJNSpZCTWd8mLu
   P/viAmDv8TuV5n19JBFzN5Qbjg2taD8Fz/SdCrLthfQsAa1fZ1drBERi1
   8jqCUZybsv0HqWkeJYEWyFku9sg0YjLbzIWX/bgVvHzPi6CbvEzy6R9+F
   cwG8pQNusSBiolTp0mARXqvPy3fCaZv6ogPWlvFwNK41vWpAkqBniMLVT
   8ZaDRNUyNj0ylPpmd4A255dBQvuxNMTX3Ox1vOpl5hQoyQcXkWPmhtw87
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643698800"; 
   d="scan'208";a="152945714"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2022 01:06:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Mar 2022 01:06:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 23 Mar 2022 01:06:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9Q0n3MOjVpoZOsEHpIaeS0377hC2YyvDvehMOZlovgeK3811pwhYlv0Wm/Pniirse8DantS5dQUNsOdtizjHz/7+3ZH3Yjqyg80sgl8plbTMoOFctCAnPhlHEXG4a+ivi84iOuweGVBsxKRhsti1NmDp7yfA5JZGpCehSi2ffn/7ot98wlafCGSn9qGZSzndiA3EgVLmfiEUR7gW027akaREpSB83LVGkPkKaZfozDBxIX0usjXe9bghSqCKRnknSx3zzxvBzGom0RfsQiPsunHRDfZa4quOpoHorZKw7DQ3I8CF9ZUH/sAF8nDWxK9iDhuujJLhqP6u7DYG6iECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+09uykzwMX3G7/WP/ZDWCuvDQuKAg1GSwar751SuVo=;
 b=UmKkQyRecEl1cAdI+WiIb3kB0cNWD4k8zby97ONMXjdy4c5cirt3icUuZIlyc6QqMIwreuaQ5DTMyNYdwNyen/Uz9mlVrmXSFf27yZU/0DHyBW88NKJ5eby7n3dEWW8XhuNubSCBKikWWkS21zKKnGBb9UN0IPuwaXajGbcg1EK9uZAmlblzqz1/tsVYksZUS/tqtccJ8dmO1MRDPtgdGaJD6xy7q6LLtts+mXIagL5iC72d8tD5ot9VL5YgEaDN20q/kdxg7WQzdGsz/MTA11tw/yLei3++9lNf38zo4f4UPUWTOHkYTAz0D+1MBI/rsYXzzijdPcSo1FY6GOiDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+09uykzwMX3G7/WP/ZDWCuvDQuKAg1GSwar751SuVo=;
 b=DTybrN5btyzrlxfNvt+Xyiks1G1TQPD3PV5vPZTdntPh3hRIrlys3nqukriXCRkkt8Ztz3lw7pJZM32C72/k8WJ588d8c9DhLLU9d7MW6JYlWdHkGj4mJinHuBaXyRqwopNRXvs2M081vVRriXk91pyrBAeR2Nb/P9PA8OAuPEg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB3757.namprd11.prod.outlook.com (2603:10b6:208:f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 08:06:24 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551%4]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 08:06:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <michael@walle.cc>,
        <Kavyasree.Kotagiri@microchip.com>, <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 6/6] ARM: dts: lan966x: add basic Kontron KSwitch D10
 support
Thread-Topic: [PATCH v1 6/6] ARM: dts: lan966x: add basic Kontron KSwitch D10
 support
Thread-Index: AQHYPozj9axCR/ukCEiowjqRfDL6gg==
Date:   Wed, 23 Mar 2022 08:06:24 +0000
Message-ID: <c9e1b743-70da-d78f-b813-4cf2a987b3b0@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-7-michael@walle.cc>
 <b4aca5f1-38c0-8197-6914-0a39b7755180@microchip.com>
In-Reply-To: <b4aca5f1-38c0-8197-6914-0a39b7755180@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bcb05eb-50b1-4952-483a-08da0ca40680
x-ms-traffictypediagnostic: MN2PR11MB3757:EE_
x-microsoft-antispam-prvs: <MN2PR11MB37575B08C087E13E556328A1F0189@MN2PR11MB3757.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4ewxNmfGmbTh8Bn9qvIuVx6AQEUH0Y40y1GKsC5KSo3f2GeB+UTWYLfmpp4C9WIjKvNlQw49YAIHGdc6RTMWtr5RcABYUqzL7b1ZxOwdi4q1mZf8yOiFCaAFp4vleDmA144yHoFO/Ucp7Fk3xhcLAqIsundfv9TuuoVI25tuFmyuJMbhbEQMAxCKU07wZ+PkQTadLndyqxdMFbFaVJROW/bNvoiczxC1cmfCCPO0jUO7fybO9UCD+YTE28U7DPPKHlLSFQ7xgMOpnOQQfgrWYqnEdTpP+8PID7OniO2swbzSkBCO+NShNJ1X32wydo0CA7xPYLWwai5sZptdJlLoZeXp/NJuykMlfXnAI35yeWnGybN/UAxezOq1l/4q6/tXj2eKoGeh5hCymf5Ar2JxZlWUT8tyLi6KLD1MkBaiXSf1hg8FrzjKGuFahAam1a5UxmMX7EHIkB+e8qDecR0C1LI70rEYlZDsA4iS/DMc/h+lwPxuYKZA5MgmNAEWU0VDZy2S2ueJCUoZnFh4LHOGP+QCwi5t6LanfUualGMGg7VqRoSMONGopDx+bu73EvlZkhvOZFQILD2lJ2vvsVajPzF8QIzUIMbMdJRTGInlUDyKhr585n9IoiroX70v+QM1RZiqIJZx1EGHVXbrh0vgdiVMlBz0130knZD1Dh/GgAiwiWfoKm7R3LcTYDXgSLXukQCljQBkfi+3r0XRyWkIXsSA7XGXVlNQmeI3yFkDJv6wIJhjpt2x2qekqzVAk+LHOBPuPuMVcAF+V11/J/ptQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4744005)(86362001)(508600001)(26005)(6486002)(66476007)(2616005)(186003)(64756008)(6506007)(7416002)(66556008)(91956017)(83380400001)(110136005)(2906002)(36756003)(8936002)(38070700005)(31686004)(71200400001)(6636002)(54906003)(53546011)(31696002)(66446008)(6512007)(66946007)(8676002)(76116006)(4326008)(122000001)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnA3b3NIdG9SU1Z2VzdsNkorOVcxc21sdnhucWx3aVlCMUs0cjBlR1A3NkNv?=
 =?utf-8?B?L01uWXZlNS81Nkd5NDBheHBHZUZMWTRLYUdKTGc0ckQzZlM3QUxMOGs2a3cv?=
 =?utf-8?B?V3lidkR6NkZiUjVrZFIremJhZHhZaXB0Q2NteFlkeS9OM1hnQW9JckQzUjM0?=
 =?utf-8?B?bnZZOS9vU3ZMSmtmRVcyZHBoaHVHZStUZXRSSmxTWVgvK3lPbkc5TW91WGpu?=
 =?utf-8?B?cGVuei9VeDByWGdSZHBhZXlMaTdYWkVJQ2xXM1M0bkFaanBCNVpnNVg1aHFS?=
 =?utf-8?B?ZUxxanRiUER0ZDRNWjJ3K3VMY2hLdUdmN0UrVTYraE1aNGwwUVNoS21mczU3?=
 =?utf-8?B?ZG9taXRRZU5aLzN5TVc2c3VPWXpPbXpJL0l6bkpmbll5VHZvWmYrMXpERG11?=
 =?utf-8?B?WDdPaGFaQ28yN3BUSExyQkpiT3NqNUhMWVdCcWliTThUUldNa2JDR0w1cnNh?=
 =?utf-8?B?ZnVCSzlNai9pSGY0dUxuSDVBOUZGWnBnMVZqQlVPRUd3VkloZldYamhzK01L?=
 =?utf-8?B?N1ZPSHNkSm05TGp0aWRwVSt5WmlJRjc3cFlTbjdlQUhtUVlXVEtlTHhIM1p1?=
 =?utf-8?B?L1FrbHhOamIxQUg0N1Q0RDFFMHJOVnNmNDI4eG9DL24rQU1hQ243OHlvT1VX?=
 =?utf-8?B?OWxjdkJIdGttaHladURES0Q5RW9qdHc2ZGY0cFpaSUUvV3dhVzBPdUlWWG8v?=
 =?utf-8?B?VXQzTjN2RWpnNlZjNy9EOUovelZNYXNCTTZQQ0tZUlRwUkF5LzBWWGloenV3?=
 =?utf-8?B?N2h0bUlEYXp1UHpGQzcwNVlTZngzU1FxSkZuWmtTRzVjRVNubWdPaEQ3WUx4?=
 =?utf-8?B?UnE1eERldjNxL1FMa04rbWdGOXl1OEdQd2FZd2twRFZxS0NXTEFYRXU0Mk9h?=
 =?utf-8?B?NEQ2UzVIOUJOZURKeDY0ZzJ4RVNYUzl1YjFialh3ZlNGZGJsRzFYZXE5L3BR?=
 =?utf-8?B?eU5RNmVyZjlaMjFhM3IyaVVEMmx2a1VCT2hNRkFXUWsxaEJMYmF4UDcyVlZY?=
 =?utf-8?B?bUZWcG5lVHhIQjdtYWV5VTRsbFpBQWYrOEJVeWNDLzEyeURSamNzbXJ6N0Nj?=
 =?utf-8?B?NEJlbkxIbUN4UTJ2YmlCVTdOQ1FnZGlxU2pWL0p1MWhhNlZQOSszUVphT1Jt?=
 =?utf-8?B?aG54NWRmM0xCWHZocTJHdDNwNnNnTmlKTnJJTmtCKzFJQVM5b1JRU1VoczZR?=
 =?utf-8?B?dncxQkVBUFlIM3RaUkVoYzZ2STBPamxWSkNJdTBjUGFtZkg1ZTExN09qLzlG?=
 =?utf-8?B?MVVLRVZoUEY2aHlIMHVXUVJ5OXhGOVJXVzJxN3hQVjdldkloVTZFOGo5cWdo?=
 =?utf-8?B?MTJnUC9Tell3WmptWkNuL08zU1Q5QVF1aVBQZElqR0xaN3hZN1owMzdZbmxF?=
 =?utf-8?B?UHRtSUpFQzB4a2VxVlNwSWN0d0YyMHFxMDZCUVBvSjV5aXNDOGIycUZWdTZx?=
 =?utf-8?B?V1krUy9IZCt0ZmdjLzN5NDF4U0JFVXZuZm9yYjVQUllPaWMvcGRzVUdHeWsx?=
 =?utf-8?B?MlRwVHZ5UVlITkRMZDFod29ma0xUTGI1VE1xbThLbjZpZjFRUUExaFZad1dR?=
 =?utf-8?B?QXlpcXNSRzc3OWk1N0E1S1BnUmpNN2JGUlNxRWZMU0VjM3JEVjVkckt4Wmd0?=
 =?utf-8?B?cjM5OTB6SjdrYlhnZmpMa2ZoRXZKeFVNOWxheE56dFZUQVZxYjNFS0xwblpt?=
 =?utf-8?B?WllVL2x6eEI2a0ExSW9YQTVXbWlKSmNwYUVzSE00UGJwQ1FWS0M4d1ZZaUhz?=
 =?utf-8?B?SXJyN2k0UHVhNGdwUUY5eFdJNmsxWEdYb2pqZDBIVy9GcnI4M1BXMHR2VlR2?=
 =?utf-8?B?WDdUK1ZkRFYxKzVyZ0EvNC9kTDFrYUdzYzR2aExDbUJBS3VDVEgzS2ZCdXZ2?=
 =?utf-8?B?NklrZVp6aFlYcExkUTBSSUQvM3Z1RE5IbTZlYStUWktSSVFIdFFtQmcvZzlN?=
 =?utf-8?B?cG14TFk2QWMrSkVYS252Q255N0hGeUhpZ1JmZFRNSUdtVGZFTC9sTXBwRU1p?=
 =?utf-8?B?RG1sNnZTWEJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47333A7DD74AF147AA8E2C6FF7E3277D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcb05eb-50b1-4952-483a-08da0ca40680
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 08:06:24.8805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSN86nthnNIrPhTCiLZi1YrVw6mSuKk2u9rrpodTJLTV+EdaJUfLn824yeqbpu2FOkxv0GndXtYz6N0d9hZfN6acSTw8KVsrP/I6+gmR74o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3757
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzIyIDEwOjMxLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4g
KyZmbHg0IHsNCj4+ICsgICAgICAgYXRtZWwsZmxleGNvbS1tb2RlID0gPEFUTUVMX0ZMRVhDT01f
TU9ERV9UV0k+Ow0KPj4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4gQWx0aG91
Z2ggdGhlcmUgaXMgMToxIG1hcHBpbmcgYi93IGlkcyBvZiBmbGV4Y29tcyBhbmQgdGhlIGVtYmVk
ZGVkIGJsb2Nrcw0KPiAoZmx4WCBoYXMgdXNhcnRYLCBpMmNYLCBzcGlYKSBhbmQgdGhlcmUgaXMg
bm90aGluZyB3cm9uZyB3aXRoIHRoZSBhcHByb2FjaA0KPiBoZXJlIEkgZm91bmQgYSBiaXQgaGFy
ZCB0byBmb2xsb3cgaWYgdGhlIGNvcnJlc3BvbmRlbnQgZW1iZWRkZWQgYmxvY2sNCj4gKGkyYywg
c3BpLCB1c2FydCkgaXMgZW5hYmxlZCBvciBub3QuDQo+IA0KDQorMQ0K
