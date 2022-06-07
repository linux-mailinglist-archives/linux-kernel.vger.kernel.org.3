Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817E1540FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354873AbiFGTNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352132AbiFGSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:25:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47DED7B5;
        Tue,  7 Jun 2022 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654624480; x=1686160480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2Jbx5k2EsS7zU15W8WJ1onmRwj96CrYYSklZv9nFIIA=;
  b=07Bt46it96S0tgMaesDQMxAZflaI4NVF2AgpqUdY4h2fV2EjmyHtoW90
   VgMEvRNEtjIhC6IhowTdec1hSsLWqDvg5KE0kBgVCsW8lnl3sP2z/YrqQ
   vNzsvDqx94AMzlobOKmIpwWpDw2KCmeq89iltD+wKQOiw0q5DSzSZktEU
   qGOCWgoeySFfNhonaEOtPxPH9/kAltMF1EjEiiOnJeclRX68J1Ns0hqTH
   i8uP53q7gdUusNkTMoB++19iZbwOoRBskttN6WxdGIOmEYfBSsZN7NBKg
   AsDpj7K7eAJmAJ+PUKg5HruaZRmQLZvhinRmQ/pmiGc4vVSajb1/RoIAB
   A==;
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="167470726"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 10:54:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 10:54:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 7 Jun 2022 10:54:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiWXUpbmJhsHDiOeSl69cxNNuJdH8J6mNLJIqrnrnf2/HDAkuQdw4V6CsDvl7l/jdatm59qJmdU7SEkEiMoDDZkIjGX/j6awLRWLeb0nvUq64qxsTlL01qlOaIDoNpHziRl27kbAlTvg1E34weR2KaabOeibs/bQL6+oiruqhMDl5cqFpQ1QrQwMyEZcIpCLIQVHOfOCQnk4+ZuB7fkE0A6QwKnRJ67ybW1o0qaXdEkN72RrlS/UNOoAmHnVlVUW6jdDVujqcxQOaCScT/QksDo+S2nXouy5vMrHrW+z9/tnm/TTcYpZkLAEoJ0o2QqEHxB53y9Bj4US1ET8b2Ib7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Jbx5k2EsS7zU15W8WJ1onmRwj96CrYYSklZv9nFIIA=;
 b=Om6sAwkiYmk8E59/NYVGERiVKfYGxUaG9Q+aFT6qBfkVSsenT2hsODZCJXKQeOhmPtNVJoFMFycVL+XwfSAhNOMk3qaxDARMIFwZDAqF2hRD2HA3gWiFFhJgQGMjM7exyR1WsYTEXV03RyoKhqqrsWWwR92+Y+9rO2vwnNEfn9LGnhJfzJK641fR2yIrYGBnkIpH43IxhdQgXPOv4pjKod47S016zK6vNHX6bPlf+GHrZaGyfJIJNhKewne/VRR/SO6/GhE1Dqe9KEFNqgmhGgLgaYzJKHVwKsoOHTmQDUGPzt+Qr5+itDJjoL3fTwoZSKyqcgZGu7f01EbssbTk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Jbx5k2EsS7zU15W8WJ1onmRwj96CrYYSklZv9nFIIA=;
 b=DhM92Exyx7wbN+d6SJiw94UUqRbVNg9xQjo+FCzY/paliPphaGupL7GWZzEjlmw+55KOP/BVLL6/E1kdFVsTIzolbRiEE2wYzdn1EobjEn1YKd1ohvfWK4roqkdd3ITM98sMad7oVUejC1DQOgQbHsEWM3swsjIIBjzrqp6IvBk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB4890.namprd11.prod.outlook.com (2603:10b6:806:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 17:54:17 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 17:54:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 0/2] Add support for Microchip's pwm fpga core
Thread-Topic: [PATCH 0/2] Add support for Microchip's pwm fpga core
Thread-Index: AQHYektC4gKRNSPydkWjg6j3RDqGCa1EOp4A
Date:   Tue, 7 Jun 2022 17:54:17 +0000
Message-ID: <e97c9ba7-25ef-3591-cf68-4d442dfad840@microchip.com>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
In-Reply-To: <20220607084551.2735922-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2add481-6ca7-4ef9-4c43-08da48aebe03
x-ms-traffictypediagnostic: SA2PR11MB4890:EE_
x-microsoft-antispam-prvs: <SA2PR11MB48906235B7CC74A0472630B398A59@SA2PR11MB4890.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnw0TPLWEQK5nQbmRLW8CBgQPvu6FHKWXngD9A9A6x0qJ0m8t+MRJqBxpeBG/9c8jiKtwr2Dejf77vYPxApdJK/tbBDGKXhJn/0jHnyCws0+mxjymNMFeFBrrOM9xtZSEs3KDlLQ7Ert58z0mh3WT+GQtwoflBWosn7j37NP0pN+/xfcBcTA9rC3ExgYhtyuSy0jCCLVZTtR6H4D6CA7AAC4Chg69elR9fkoV27/xgf5EvWrpSf2J7SowHXh8kA7OjM99cF9qcXp0G2ZdylASNLFJSQN5IJkBuPe1le8Ajt4R/OqNXBBveqNbJiLdvwDUxMjMdcMQQZe04eVPGsu7PVKnn8rBcShCX/gkW9O2Pi5IHrpofX6xtQoWW76tpxzy7q4H5GpXMjWEIn1i3gVfp2iurTy/cp+99RVj0iSK9Hiy/I0Ty9n6sjSd1p987ewbPx6ufivf53mxFjUQX91UyzLQ0BNnZifJJJPiXNoyg6YxiJ+XIpevsfR9mcsY2SUhFttlDPNTb1IJ1HrrlT+19S6+v67GzQfmgV/qxT6Z1Kk1tmbFkErXtJ+Z0xyviGm0aTwVM3Js/gbZLAmHteZpXISp8naAGfIvz3NF9szheLjatdv45D/dnpgZh4eNdldiORZ9drLhkvXiKACdpXLBBIUnuyRATef6zu2ExquqT0O8FD8W7fOZGKBwHEJ/lNpoRAjb7JFfCMY1QoYXkwxoA2VCLpva3NiWIDUT05WY/6xsDfDiGPSZj2tcyuuXlP4vj9fdNvy0b7gKfdbEq+BGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(91956017)(5660300002)(31686004)(4326008)(8676002)(76116006)(66946007)(66476007)(66446008)(66556008)(64756008)(4744005)(122000001)(6506007)(6486002)(26005)(110136005)(316002)(38070700005)(8936002)(53546011)(186003)(2906002)(508600001)(71200400001)(2616005)(36756003)(31696002)(6512007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEI2TlhIN2hLTHZIR3J5aEhxYXBDQW9vd1p6eTBCUUNKTWdQL3I4MStiUFNm?=
 =?utf-8?B?NW5zUUtnVlFLT2FPZmM3SXpLdzJtQnRaZjRabUcrMlNHa3JscW9iRkRFN0c1?=
 =?utf-8?B?VjlhaEpwNEhoeW1PS1Y3aXkwTGdybFpiVTdDSm5MTUI2bmJkKzAzeC9VU1pu?=
 =?utf-8?B?anRML08xS01ieE0vZjBqTEhxOGU2SUhiOUxlRE9nZzBJcEhnZGV0NEJPVjZu?=
 =?utf-8?B?amlBZi9oakU5akxOaFJudFU0dDR1T1VCTStuQWt5SVA0MXZpbERvM2RMNlox?=
 =?utf-8?B?SUJLL3FIcEtxVE9SWFlTRC93UlhJSmpCdUtJS0dhYjV5cjFQQmhmZDNOT3Fi?=
 =?utf-8?B?d2l3bzZNOHNOZXB6MU1KVWI3MTNCR1JYbSs2TzZpU2hZZTE4ZFRXaTNPNUpR?=
 =?utf-8?B?cDJmbVRyNjZ0Mm1wOFlaWnhIckJ0VVpzMlRCOW9RNThqeHlNWTR3WWUyZytu?=
 =?utf-8?B?bisxQUlBWVdqSnJKU252RFBpODZ4c2Nsc3NJK1Zld1NoYTJBWUVhVHJvUjYx?=
 =?utf-8?B?bXZVR2JrOXBPdDJ3c2c4RjJOUXRjbm83K25URk5ZOU01ZDQ5dmYxQXJrVU5C?=
 =?utf-8?B?cElnZloxTkN0SmZjVG1vZDd4d21FT1RuOFo1OVM2UVNNOG9FVTNwcldLY285?=
 =?utf-8?B?T3dFdFNmRUUrR3htYUJtUjZzekljcmpUWCtld3ZlU2tzYW90TlZuU0xUN1pk?=
 =?utf-8?B?V1EydzdZUG1EcVJ6NHF1cERkUmo5VWIxem5uUUZadkVscWVqbmNZUzhOdmxz?=
 =?utf-8?B?eVJKK1VmeEJESFJmTUhrTzVLRHBzd1FBYkcwcjd2TjlFR3VDbDlsK0U2bndu?=
 =?utf-8?B?MUhFZ0o2aGo0c1k5akFSVVlDbXVPbGNoNTVyR2NGejR3cEcwa1h6VWZLd3Zy?=
 =?utf-8?B?Vzc3R3YwQzZUMHE4endrQXZ5Y0NXM1lhS0F1dFRxSnhYQllBVTRxeUhYeGN4?=
 =?utf-8?B?NUYxQlZpY0Qxb3FFQ1U3N3pYclBYRUliWDRSK0Q3cTJWc1pjRDMvY1NnWVl3?=
 =?utf-8?B?VDN5SEtqNnBOZkxuTTlPSVZITTBpQlJINklSaG1jdjlSSzNzT2tRTkg5dE5l?=
 =?utf-8?B?eW43M1I0NitzRklFZ2V4MVNWRjUrdEwwSFhtNkMwYjlXOU93RVdjWjRFaEts?=
 =?utf-8?B?SlI1VWZLZ00vblBDRC82THhLRmFlampWU1FHWVBXZWIvRUZ2bVFIQXJXelcv?=
 =?utf-8?B?N01LcFI4aktVZnNKSnRBQWdIbFdDZUdZNXBBVVpkMldvL3FZUkQxanljeXlV?=
 =?utf-8?B?VFYydVBOYmxURGxqOXdiVzdyWllzNEFxUTVycFVJL0N0K1dVMFdUN29HOHU1?=
 =?utf-8?B?cERCdEgreWZBd3l4R2dnWXY3UGcvc2k4SWxJOGF1N0FzVS9SdGJOOUU0KzNq?=
 =?utf-8?B?Vndla1drYkdFMFlFb3l5VUVYV3FxcnJrQWQ1MHV0R0dwZWNQNGNYUzZnTGda?=
 =?utf-8?B?dTlidDVaKy8vaVlqY2NVZEo1UWFnSG1xRkltMlF6L3l4TkdpTE9BMWFYZWVU?=
 =?utf-8?B?em9QTVNSeWh1empRMDZwT1ZPc2x0cG9QRnpUWHd5K0p4L1c4Y2xLV2NCNmlK?=
 =?utf-8?B?cUc4MFdRTmhVa2ZpL1BZNkpDdnpyN0tJcm9pdGw1TW9oZ1d0SjhrSWowNkFk?=
 =?utf-8?B?MUVNZjh1bncwcE9xTXBnMW9pb21aanZoWWp5VnBlaFQrQ2JGNnVPbDRFQ2FS?=
 =?utf-8?B?aGVuQkhHbGR5OUsvWHVZN3VBaTBiZVZzSnlFcG9HZTNxY3N0TjFRVURmQy8x?=
 =?utf-8?B?eXRCYnNKME1zdzNHRmQ5YTBEZUp5Wk1RcExlNWhEblNlSHg5M3hNYWhUWWxV?=
 =?utf-8?B?K09pRmEyd05zWEYyekY0TEcwaWdBSU1NM3ZKbEtIUEg5ZHU0T0dQWXRXSW0w?=
 =?utf-8?B?emRXbkFacXBFd3Y0RXBYb3dERmNUZTZnOEZLMU5QZ1ViY1k1b3R3MDJsZUtD?=
 =?utf-8?B?eWVUZVUzUlFzZGo0c1c2YVVDR29mZVQwaEJJRjZXZHlmRk5LaXQzVktKSnBB?=
 =?utf-8?B?TFFRQVlOQ1Z0RHo4a0NyU0xobDZ4dGZkdmNjOVFGZXFiZURtYUwvTDFHeENB?=
 =?utf-8?B?VmgwVS82ci8wUTZVTnlCTlFySXpOaFhMeElHK0pTWXpTUDFtRHZHWS9DZ2VK?=
 =?utf-8?B?aXlCZkx4VThOU0RKOEgwMUVaZWtXZ1hlRTVuVkNFV0JLU2tYakgxMXdKMlFv?=
 =?utf-8?B?QzJ3aVUzeWRUL0NUN1A5V3VDQkV5dEZNWHNUMWtBNllvVW43WGJqdGtwNWFQ?=
 =?utf-8?B?SVRkRHQ5cmU5YUQxSDdlUHkrVmp4MTZrV1Jabk1rZ3BQTG90c0JnQ0h6OEtU?=
 =?utf-8?B?NzV3WHhaaGMydHRFRWM5Z3Nrc2FSZk5CZUZZWnYvdEduZXYvS0hxQ0Jndmo2?=
 =?utf-8?Q?KaARcekpIAoA+PYU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF181A82ED8A6F4B92F01CF21BB66439@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2add481-6ca7-4ef9-4c43-08da48aebe03
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 17:54:17.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPKyH/qxz/IPhHfDWbJ6Ks0514LWGczrh7C5g5VPiVgG1TqIadcJkUE4PUk2jVqB35oo3YDy1mRH0Pqp1BDN7ZijAtzug5iRai0EsHor5rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4890
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDYvMjAyMiAwOTo0NSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgYWxsLA0KPiBT
bWFsbCBzZXJpZXMgaGVyZSwgYWRkaW5nIGEgZHJpdmVyIGZvciB0aGUgInNvZnQiIHB3bSBJUCBj
b3JlDQo+IGZvciBtaWNyb2NoaXAgRlBHQXMuIFRoZSBiaW5kaW5nIGZvciB0aGVtIHdhcyBhbHJl
YWR5IGFkZGVkDQo+IGluIDUuMTguDQo+IFRoYW5rcywNCj4gQ29ub3IuDQoNCkkgcmVhbGlzZWQg
dGhhdCBJIGZvcmdvdCB0byBtZW50aW9uIHRoaXMgaXMgb25lIG9mDQp0aHJlZSBwYXRjaHNldHMg
SSBoYXZlIHNlbnQgdGhpcyBjeWNsZSB0aGF0IHRvdWNoZXMNCnRoaXMgTUFJTlRBSU5FUlMgZW50
cnkuIFRoZSBvdGhlcnMgYXJlIHRvIHRoZSBVU0IgYW5kDQpTUEkgdHJlZXMuIFRoZSBTUEkgb25l
IGlzIGFscmVhZHkgYXBwbGllZC4NCkkgd2lsbCBpbmNsdWRlIHRoaXMgaW4gdGhlIGNvdmVycyBm
b3IgZnV0dXJlIHJldmlzaW9ucw0KVGhhbmtzLA0KQ29ub3INCg0KPiANCj4gQ29ub3IgRG9vbGV5
ICgyKToNCj4gICBwd206IGFkZCBtaWNyb2NoaXAgc29mdCBpcCBjb3JlUFdNIGRyaXZlcg0KPiAg
IE1BSU5UQUlORVJTOiBhZGQgcHdtIHRvIFBvbGFyRmlyZSBTb0MgZW50cnkNCj4gDQo+ICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3B3bS9LY29u
ZmlnICAgICAgICAgICAgICB8ICAxMCArKw0KPiAgZHJpdmVycy9wd20vTWFrZWZpbGUgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9wd20vcHdtLW1pY3JvY2hpcC1jb3JlLmMgfCAyODkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMDEg
aW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcHdtL3B3bS1taWNy
b2NoaXAtY29yZS5jDQo+IA0KDQo=
