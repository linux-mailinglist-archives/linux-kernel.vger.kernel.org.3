Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05315941A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbiHOVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348058AbiHOVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:08:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400533C8E6;
        Mon, 15 Aug 2022 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660591093; x=1692127093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i0ShkLF21DIcqqDdcVS41PcFQXJg2uYwwwEm1MAu708=;
  b=O2xLOLfoczIAl3QCZikhxKN8Pt9BcPW6unmAknH9KjUAG8oh/el8+EnL
   uz2Ae4SEHydI/7qUmrURCKtHPbvb8nV5ft9tIWiexSGtd//muhNso9cSJ
   gUEvAXyw/gAL0qQTksobUKzyfru7Qs5HIGYpgGgbJW9x93EwcPGmZUjHf
   K6I8eASHafp3bocMbENTN7Dkr8BsPEtIbEKX6MQJ5I/4AjlP5IDr8Alre
   oQnef1w/gA8XO/lvCKEN5YmuoomYDzNzfcjgnPVKigV3VD+PCFOMj+iq8
   fLUcLD0o3WZ16FrdUluYPfEClD1Gho6IuC1xni8c/huCN9Kwg2cmhTTL4
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="109127605"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 12:18:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 12:18:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 12:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5xMfNy7OdjP9OAPf67QYVWfF7oOTenvAVdivnx4RDJKwIr7Edtad0MMWrwm9ElooiNxrtaY8TAFfHTZLwRG+53aFFZurLBhzlEpLP303giursrjRY+MC18e0XGep17VBiuleRRApehUfAw0mFx/8oBMMNJQzFSLL8EETeF8VLORnY+kzRKfdBVW3vvvW8zDlOWdaAEU2vQWBRhEYPV6Z/f6dERJLhwx8g+XRgvBS61fzCNlYjLV6Mp9apkWrJEXGibxOUjoVcGVHN7QuRM+fppzjbApg1QJ2jRBItpqGnWL0su3yVwPWJWOxOzKFNo3WU9AoU2NkJa2+SD7OYbr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0ShkLF21DIcqqDdcVS41PcFQXJg2uYwwwEm1MAu708=;
 b=EJWgGZihPcT5M+o+pr/4D49Nh19eqDPgLLw3jirh0ffsDEwQKXvtB+m21rUJXkHH1+0dabfCRC+csDoRGMiS0GGH8K1izk1hu6vm4FmFSdse/UlJPiT0zZ6XbT1merLe1JJ/HNCZ4GuwGeZ6aXh1yhvDEkXF8HHJeGNgg7ju4uEiX195aV28RBBleOwApxbO1v4zqhc0ld9aDwBAj3YWkVZZWhQKcf7dBDU7iTJoSXkkwAnmKwdD9DRwdKYonTEWXDyLAWV7WCDHqvRrIQFqJiXviM2Y55wRuDSedzVAbCYKqVUJTxsz5fIr8OI2QIDTEcwUM0FfHiBqdvIga0sYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0ShkLF21DIcqqDdcVS41PcFQXJg2uYwwwEm1MAu708=;
 b=likrkXFcaG141x7PqEBHd1ntALlXCy5t6Eu06s6v6UO+RH+RWeLyhYFlvFt2SFhxPwQxApRH+gS2BB6r2FBNNzultKKM44HcHotawN5bi3SZz0mR4fO5LLDayKixivo433BbywmtbzYdf8eQf33JzdZ0Rlk7XwJZC3XTPVjYABM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB2776.namprd11.prod.outlook.com (2603:10b6:a02:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 19:18:02 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 19:18:02 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jrtc27@jrtc27.com>, <palmer@dabbelt.com>, <robh@kernel.org>
CC:     <tglx@linutronix.de>, <maz@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <daniel.lezcano@linaro.org>,
        <anup@brainfault.org>, <guoren@kernel.org>,
        <sagar.kadam@sifive.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <qemu-riscv@nongnu.org>
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Topic: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Index: AQHYqOiQvE59vmIAhkiZ1sZQKraNy62li3AAgAAHfICAAQ/4AIAAST8AgAl5hIA=
Date:   Mon, 15 Aug 2022 19:18:02 +0000
Message-ID: <1d94e18d-7f51-0619-95a9-6ca5fa7d9671@microchip.com>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
 <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
 <20220809141436.GA1706120-robh@kernel.org>
 <61829ccd-20d7-e2f0-0a6b-bcd0e076b9ea@microchip.com>
In-Reply-To: <61829ccd-20d7-e2f0-0a6b-bcd0e076b9ea@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d90a9d9-1621-4f1e-390f-08da7ef2df90
x-ms-traffictypediagnostic: BYAPR11MB2776:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +8IObIxz8P9AssK6juy2tmTa8vn5qfUM4415G4tEWbGpYxN/K6HWnW2m/89y2EGH6T68fFVSaLj+jIhoCifmTrxJi5/ASRvb0LLtsgwhcU3tzML3aCw94Kk6edRufm0u53xPvCUY9YPgkM9/YyZfCQtTuoBur/ftI4eL6miaxbuAxxVU+6WheEjnTK/U2cqMWFYbBzEYGA1HBdjOcbxo1K+JICd8ZOZ8o8n51CUXXp571q/qkd6PEB/LOT73qA8M18xQfBva1amtxvDHaEAzadRPo/YKTiFS6bKTh+0kRSEmG1EbUpgm+OZyp1b83vS5PKwxbPa91817JUyXECytECzOhRhJHAKOM97VBYT3hhNhbLPyQiulMREm2yBVXnvznCewW2B8lnKcp8rbYxHboLeZgUopJmfgkYbD97+mgNwSxXQL7ySBX5J3Flu2wxmND00QSzuqnEeteZ5KyqJbHADeY+tbGlGsA27X0urHdlCgfkkjndZqSMo0e3WNKMPZBXPGoBGAfyuQCPcNYWwqQYSUWOlo4zRIHc27BTUHenqeHbK8lwPkeypFNRC9jXw/DNm6rkdY5CwXZwc+/59VD6Wtbua+pYTncFAtdYJjE72QgBlWdWB1SiCalXC/C3omhTPVU9R304gDYAydoaEtb623AcFKlJ43fkzUPB9Sh0K3PlX7txgCVJ7TLwDEZQl2I2eP0PvD3W/B8UbzhYjKvxwvB89zNhv5YzRwih7e+EfXYIxvQN9rjAcH0amcc/SiQM1cqXOsnlbgVLNaZuGsep31tu7LXNEqIt26DilZNIJday+MycijLuJbCfy68aLADVHrQ4e0cTy139jkQi5t09tVxNc9K6eRcxu/kXBP2OBOZ/u6oPuIiTAcqAvxsRqoj90lptO/M+kzh+bBUgGlyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(366004)(396003)(346002)(83380400001)(8676002)(6506007)(31686004)(478600001)(26005)(186003)(76116006)(41300700001)(6512007)(53546011)(66446008)(316002)(2616005)(54906003)(110136005)(36756003)(8936002)(4326008)(91956017)(6486002)(66476007)(66556008)(66946007)(64756008)(7416002)(15650500001)(2906002)(38070700005)(5660300002)(71200400001)(122000001)(86362001)(31696002)(38100700002)(43740500002)(45980500001)(569394003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGtxdDZBWHFhTmQxRHpSRmJOTDExU0hsUFE1c2h3R0x5SUVEbTcyaEp3VFRr?=
 =?utf-8?B?Ym4vYy83cHZZMkZuWEJtalFnK0UrZVlERmZ0QlVubFFmTzQrY25XRm9Cb3Ur?=
 =?utf-8?B?TTlRUGFuTzVpVnkraGpYcitHQ1NSTDFlRDB1bHdVZU1wTGhtNFpxaXY0bDNE?=
 =?utf-8?B?ZTJpTHRUbGpheVBsWG5seG9pTXFqYnRULzU2dE9vN2FFemprU2I0QTlKQ0lG?=
 =?utf-8?B?N0dveG5MbkVZRVZXRlFleGpMSjFkbk5LOTh0RFdjNzUzUUp3VnNqcFAvUDYy?=
 =?utf-8?B?OGdJbGhVMzZzajh1bC9aMlBoMEhQVDVhOXpPN0ltL2NCalVuZkF1MWZrVnRW?=
 =?utf-8?B?SDY2R0oySHc0clJQOVZ1ZU1yWHdNOXpqbEFmdlFJWk5QOGpjWkRML05TWGll?=
 =?utf-8?B?L3Z1VWkyUWwxaER0TnlXSVlweE9KTjVJcEJiUFdZVm1yQkVjWmI2NGpKc1RV?=
 =?utf-8?B?MzhhdmlWNVNIZ0J5ZkNGVXUrL1U4OUt6SE95Sml1TGxBNjdRLzl0TDhWUFZh?=
 =?utf-8?B?TEIrVDNEaHYzaXpnTi9IQnNydnJzU0FINmVQd0tLa0tmMGlKZkpwVGFpelZ2?=
 =?utf-8?B?Z09kQk04MGhkY2JPQnhTSFhBQTF3b3hjVWJ5QW96MVpCRHdlWVdGM0VVYy9j?=
 =?utf-8?B?Q3VacHRuenN6eFFLSFgxYmU5UjhEQWN4aHVsMWhmMlRkWWZpMUx1dWROVlNs?=
 =?utf-8?B?K1NmcGxLL2VBcWpDb2M2amhDVGpkVGRRci9odlBDN3hkV0NmZ2ZVRnJRVjJW?=
 =?utf-8?B?aUI1UVcra3VGWHNaVGxXc3FmSHBueEJhSGtidzl3OGZrU0tJamcrbDlkYkdI?=
 =?utf-8?B?emgxaWZZYktwN3dXZ05DdVEyb29mM3FJWUt4QTVTMWNtV0VmRUZSazhhWE5L?=
 =?utf-8?B?Ykx3blRCZUhmWXNsN0JPR0p4NVY1OXpwSVFUaFE2OWVpOWFNR29TT05yTDA3?=
 =?utf-8?B?VDFkZ29SVVUxZ2FxamtIM1ZKdXc4SFVkLzFmSGdVWkZFYmw0Yk94cHR5UFZh?=
 =?utf-8?B?eUdlUDhCRnpUWTJkdTJBUE9CcVlmUXFMU1o3QXErQlR6M2VsV01tdDQrRVhx?=
 =?utf-8?B?YU5BN1JrQVUrRXgzSFdSSmFNZWNXVEwwbnNGenYrU0FkUDh5UnNjUHRxclM0?=
 =?utf-8?B?SUdSR0JKSkFtZFg4U0JTT2cwY1YxM3hod08yeXZaMnpBeUs1RHR1K0pJcG9B?=
 =?utf-8?B?dUN6YncrcTI2MFR4MW0yVmVoclpUVno5a2k5WHpMalhvZnJSQS9VWlpYenpu?=
 =?utf-8?B?c015Z3lOS1Yyc2JnNTk0eWdLaFNORkJCYVRFcWRPQ2l1c1A2c2ZVMHplQUdV?=
 =?utf-8?B?OEZhZFI5cFZBUmR1MkVuRWlieGFvQ2RDM3ZKUTQ2RWJVM0puMWRsNVFDRWdH?=
 =?utf-8?B?YU5OSVE1RmtzbUN5WTB4emkxY3pCcFZ1REpVSldsbnFOaWlTSVNVV1J3bE1w?=
 =?utf-8?B?NkMwUSswL2FlaWZZVWZaN3U0SmRnWmRhdUhpa3YxL3Q0ejN1aFRKeW5wZUtj?=
 =?utf-8?B?bjVMZmlmdWtCVXdWeGNBbHhtOGZJcWsxZmNneFJjSVdLbXBDRWpxY0F5dDN5?=
 =?utf-8?B?L21TWmg5NkZqQUJDUkVkc0I4VkxhYXRJVWR1bDlweFVlUnhUeWtoVnVPbjR6?=
 =?utf-8?B?SzRyYjljVitKS3VheDdvTXl1bklsSkxpQytIa2VYZTRFaGJYREVPVDZyRExV?=
 =?utf-8?B?ZHlTbWhRd2FPUzNUdGNpNG1BcWh0dnNtMXNMZnNQSmphc2JucDRMeXdnMmdQ?=
 =?utf-8?B?K2VzZ1lwVXYrY0dKUDBKazhIaFpjckRXNStJU1Q1R0xqYzlpWGVqVkRVY1h4?=
 =?utf-8?B?aDJCeDMweVRhamFaYlBQWUFlUTZUVDZGWmdaSlJjMmFGNm1DOTNMRjI0cjhV?=
 =?utf-8?B?eE1kd1hwZ1lXdXdkemhoR0ZZdVRWTnNtaHdvYVRVNVgvNkF0ZVNlRFpCZG40?=
 =?utf-8?B?YzhOdDhRTHJUcngyZ09Tc09US1Uvam5GQldOK1pBTVRGSUZONEcxUExOc0JX?=
 =?utf-8?B?c0lqRHovaEY4TDFMOXNuK3FyUEY5a3B2b0ZtZFBBTjFtelo1QU52YlgrQ1NZ?=
 =?utf-8?B?NUkrRlRhRUEwaXJBcnpFOHFMR3ZkQlRyWnpQOTFIZVFMY0NNY0VIWG5pOVBN?=
 =?utf-8?Q?pBn0Ka5l1/HS8j61eY1xsgeVi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C98D34A3D5B2F4286FF86715EF42976@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d90a9d9-1621-4f1e-390f-08da7ef2df90
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 19:18:02.3990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuEibU7DO8FBjs6URKrvsr7N+1cUxkhBV691CRM/c9gLoosjg47u8wyqS6zTqamJ7jjgtXMSs5Fk2Tq/0Yb9+Gq0DJhyiDpWvi0TEvdF/ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2776
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW55IHRha2VycyBvbiB0cmFzaGluZyBteSByZWdleD8gT3RoZXJ3aXNlIEknbGwganVzdCBzdWJt
aXQNCmEgdjIgd2l0aCB0aGUgcmVnZXggYW5kIGl0IGNhbiBiZSBzaGF0IG9uIHRoZXJlIGluc3Rl
YWQgOikNCg0KT24gMDkvMDgvMjAyMiAxOTozNiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiAw
OS8wOC8yMDIyIDE1OjE0LCBSb2IgSGVycmluZyB3cm90ZToNCj4+IE9uIE1vbiwgQXVnIDA4LCAy
MDIyIGF0IDEwOjAxOjExUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4+IE9uIDA4LzA4LzIwMjIgMjI6MzQsIEplc3NpY2EgQ2xhcmtlIHdyb3RlOg0KPj4+PiBP
biBGcmksIEF1ZyAwNSwgMjAyMiBhdCAwNToyODo0MlBNICswMTAwLCBDb25vciBEb29sZXkgd3Jv
dGU6DQo+Pj4+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29t
Pg0KPj4+Pj4gVGhlIGZpbmFsIHBhdGNoIGFkZHMgc29tZSBuZXcgSVNBIHN0cmluZ3MNCj4+Pj4+
IHdoaWNoIG5lZWRzIHNjcnVpdGlueSBmcm9tIHNvbWVvbmUgd2l0aCBtb3JlIGtub3dsZWRnZSBh
Ym91dCB3aGF0IElTQQ0KPj4+Pj4gZXh0ZW5zaW9uIHN0cmluZ3Mgc2hvdWxkIGJlIHJlcG9ydGVk
IGluIGEgZHQgdGhhbiBJIGhhdmUuDQo+Pj4+DQo+Pj4+IExpc3RpbmcgZXZlcnkgcG9zc2libGUg
SVNBIHN0cmluZyBzdXBwb3J0ZWQgYnkgdGhlIExpbnV4IGtlcm5lbCByZWFsbHkNCj4+Pj4gaXMg
bm90IGdvaW5nIHRvIHNjYWxlLi4uDQo+Pg0KPj4gSG93IGRvZXMgdGhlIGtlcm5lbCBzY2FsZT8g
KE5vIG5lZWQgdG8gYW5zd2VyKQ0KPj4NCj4+PiBZZWFoLCB0b3RhbGx5IGNvcnJlY3QgdGhlcmUu
IENhc2UgZm9yIGFkZGluZyBhIHJlZ2V4IEkgc3VwcG9zZSwgYnV0IEkNCj4+PiBhbSBub3Qgc3Vy
ZSBob3cgdG8gZ28gYWJvdXQgaGFuZGxpbmcgdGhlIG11bHRpLWxldHRlciBleHRlbnNpb25zIG9y
DQo+Pj4gaWYgcGFyc2luZyB0aGVtIGlzIHJlcXVpcmVkIGZyb20gYSBiaW5kaW5nIGNvbXBsaWFu
Y2UgcG9pbnQgb2Ygdmlldy4NCj4+PiBIb3BpbmcgZm9yIHNvbWUgaW5wdXQgZnJvbSBQYWxtZXIg
cmVhbGx5Lg0KPj4NCj4+IFllYWgsIGxvb2tzIGxpa2UgYSByZWdleCBwYXR0ZXJuIGlzIG5lZWRl
ZC4NCj4gDQo+IEkgc3RhcnRlZCBwb3R0ZXJpbmcgYXdheSBhdCB0aGlzIGJ1dCBJIGhhdmUgYXJy
aXZlZCBhdDoNCj4gcnY2NGltYWY/ZD9jP2g/KF96W2ltYWZkcWNidmtoXShbYS16XSkqKSokDQo+
IA0KPiBJIHN1c3BlY3QgdGhhdCBiZWZvcmUgImg/IiB0aGVyZSBzaG91bGQgYmUgbW9yZSBzaW5n
bGUgbGV0dGVyDQo+IGV4dGVuc2lvbnMgYWRkZWQgZm9yIGNvbXBsZXRlbmVzcyBzYWtlLiBTbyB0
aGVuIGl0J2QgYmxvYXQgb3V0IHRvOg0KPiBydjY0aW1hZj9kP3E/Yz9iP3Y/az9oPyhfeltpbWFm
ZHFjYnZraF0oW2Etel0pKikqJA0KPiANCj4gSSBjaGVja2VkIGEgY291cGxlIGRpZmZlcmVudCAi
YmFkIiBpc2Egc3RyaW5ncyBhZ2FpbnN0IGl0IGFuZA0KPiBub3RoaW5nIHdlbnQgdXAgaW4gZmxh
bWVzIGJ1dCBteSByZWdleCBza2lsbHMgYXJlIGZhciBmcm9tIGdyZWF0DQo+IHNvIEknbSBzdXJl
IHRoZXJlJ3MgYmV0dGVyIHdheXMgdG8gcmVwcmVzZW50IHRoaXMuDQo+IA0KPiBBbnl3YXlzLCB0
aGlzIHBhdHRlcm4gaXMgYmFzZWQgb24gbXkgdW5kZXJzdGFuZGluZyB0aGF0Og0KPiAtIHRoZSBz
aW5nbGUgbGV0dGVyIG9yZGVyIGlzIGZpeGVkICYgd2UgZG9uJ3QgY2FyZSBhYm91dCB0aGluZ3Mg
dGhhdA0KPiAgIGNhbid0IGV2ZW4gZG8gImltYSINCj4gLSB0aGUgbXVsdGkgbGV0dGVyIGV4dGVu
c2lvbnMgYXJlIGFsbCBpbiBhICJfejxmb28+IiBmb3JtYXQgd2hlcmUgdGhlDQo+ICAgZmlyc3Qg
bGV0dGVyIG9mIDxmb28+IGlzIGEgdmFsaWQgc2luZ2xlIGxldHRlciBleHRlbnNpb24NCj4gLSB3
ZSBkb24ndCBjYXJlIGFib3V0IHRoZSBlIGV4dGVuc2lvbiBmcm9tIGFuIE9TIFBvViAodGhpcyBj
b3VsZCBiZSBhDQo+ICAgdmVyeSBmbGF3ZWQgdGFrZS4uLikNCj4gLSBhZnRlciB0aGUgZmlyc3Qg
dHdvIGNoYXJzLCB0aGUgZXh0ZW5zaW9uIG5hbWUgY291bGQgYmUgYW4gZW5nbGlzaA0KPiAgIHdv
cmQgKGlmZW5jZWkgYW55b25lPykgc28gaXQncyBub3Qgd29ydGggcmVzdHJpY3RpbmcgdGhlIGNo
YXJzZXQNCj4gLSB0aGF0IGF0dGVtcHRpbmcgdG8gdmFsaWRhdGUgdGhlIGNvbnRlbnRzIG9mIHRo
ZSBtdWx0aWxldHRlciBleHRlbnNpb25zDQo+ICAgd2l0aCBkdC12YWxpZGF0ZSBiZXlvbmQgdGhl
IGZvcm1hdHRpbmcgaXMgYSBmdXRpbGUsIG1hc3NpdmVseSB2ZXJib3NlDQo+ICAgb3IgdW53aWVs
ZHkgZXhlcmNpc2UgYXQgYmVzdA0KPiANCj4gU29tZSBvciBhbGwgb2YgdGhvc2UgYXNzdW1wdGlv
bnMgY291bGQgYmUgdmVyeSB2ZXJ5IHdyb25nIHNvIGlmIHtzb21lb25lLA0KPiBhbnlvbmV9IHdh
bnRzIHRvIGNvcnJlY3QgbWUgLSBmZWVsICoqKm1vcmUqKiogdGhhbiBmcmVlLi4gDQo+IA0KPiBU
aGFua3MsDQo+IENvbm9yLg0KPiANCj4gcGF0Y2ggd291bGQgdGhlbiBsb29rIGxpa2U6DQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L2Nw
dXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlh
bWwNCj4gaW5kZXggZDYzMmFjNzY1MzJlLi4xZTU0ZTc3NDYxOTAgMTAwNjQ0DQo+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlhbWwNCj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L2NwdXMueWFtbA0KPiBAQCAt
NzQsOSArNzQsNyBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgaW5zZW5zaXRpdmUsIGxldHRlcnMg
aW4gdGhlIHJpc2N2LGlzYSBzdHJpbmcgbXVzdCBiZSBhbGwNCj4gICAgICAgIGxvd2VyY2FzZSB0
byBzaW1wbGlmeSBwYXJzaW5nLg0KPiAgICAgICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy9zdHJpbmciDQo+IC0gICAgZW51bToNCj4gLSAgICAgIC0gcnY2NGltYWMNCj4g
LSAgICAgIC0gcnY2NGltYWZkYw0KPiArICAgIHBhdHRlcm46IHJ2NjRpbWFmP2Q/cT9jP2I/dj9r
P2g/KF96W2ltYWZkcWNidmtoXShbYS16XSkqKSokDQo+ICANCj4gICAgIyBSSVNDLVYgcmVxdWly
ZXMgJ3RpbWViYXNlLWZyZXF1ZW5jeScgaW4gL2NwdXMsIHNvIGRpc2FsbG93IGl0IGhlcmUNCj4g
ICAgdGltZWJhc2UtZnJlcXVlbmN5OiBmYWxzZQ0KDQo=
