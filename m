Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DBF56C974
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 14:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiGIM7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 08:59:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E314021
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657371543; x=1688907543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E8WwRYPdXfHqdC+LuZ6MoW8oBA2uQ7qOozR6ggl55yA=;
  b=nm6E5JK2MLEqsuK/39auk9m0a1+TzlNq3JbWto1paKl7OrFI8S8YogkK
   AK9EuwgF6Pgv2Q4eDqilfRiPTNyTHHH0Vz7siggPmpG/+D1s7WBGw3S5L
   n0a/tnT+93Baa1edsm62FUeMV0Y0dHj6TmCyMuLz4LBFE5QSW07zUym2b
   pL1uyxCYJFISb7UkWj/CljMIkTWQmBlE97Jn7GQZ+GJFQM/fliwtFj9zx
   Xfur5sIM+jI4rJADBTP/FHwxrUV/KpIniEkRN4G2o+gWSYzRUCqJxJA3l
   Uj0eKWGH8V+4iggDjxyOL+EVSLzywzbds+GTSB8uWfFD4fu/5dhH733fN
   g==;
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="171441529"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2022 05:59:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 9 Jul 2022 05:58:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sat, 9 Jul 2022 05:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3n5J7ZLwel+UzVaiIoyVq3SU/QqSMeyP51fhMSMNodtOmkBNcwTM44CT1MszYNl3duietwjAKa7zFchbILMTZx/xv10BHY5+XKdligyQAGIiiKhfZ62aoDbADxPP/hlRDXl3Gc5UlG5zlrJZekxR9nBm6kYEyAyVKXMAbInzaSlZa1LtfDxiEZF52AEqtsEHs1vhGJnNFNQFN52snykqjTHhBGpAa5xoklVJ6uq0blZG+jpNdMqOzNxPVYxJQlCDEuPvGJ51Qigf5H7yL+cfalQ1+0E5SC1dJ/2fA43xUZO6AIeyv6kx/3Zz1lpH8dR0RazR/73LG21w4Triizaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8WwRYPdXfHqdC+LuZ6MoW8oBA2uQ7qOozR6ggl55yA=;
 b=BYGkPFhmkCQAmyEi/665pSqzN1iP9yvlpygawaudrKS9JM7GrHC8uRDP0in+VPgv5ILhPhFFuFJQRY9wGzOkbdgs9NPQpD02ublVL/e5KLqwlxV94v/7MJXyI6ANJlUL41BpeiAny2Gi7bvybXgLTd+LkrabI8rvZwUmlp6Tzhz6Hcv/4jHhwhORUMR+oTUBTfNEBSiJZmFdkJE7yD7kkWYdkiiqR0X8ztRjkXfDmkUqQV2A6qTjyMEZYe1n4JyMjt5oyb07CVB2LRvHVVrWe/r+efcq/eaO1e98ctNdC+Wa84351qOjI9xkUatWWRaN2ClAT5L6C9XGpwNJPp6Y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8WwRYPdXfHqdC+LuZ6MoW8oBA2uQ7qOozR6ggl55yA=;
 b=hmUHekKs8MAxtqnp6kdP7vdwJYCxYQEgM5jfwcOLDX/r2eQWFl+Ox6cFuhAajLrkwp4JMPDWFU9l3MZpKQh1JmbhCQhHroNr2r4Ch0HgoJ5lFzBGqwAKDM9UdL4GNj28jhnd1FlivOzwb+X/9YZY7hjwInSOHWUFnjd51FHJnck=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 12:58:58 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 12:58:58 +0000
From:   <Conor.Dooley@microchip.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Topic: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Index: AQHYkwoSKn1B1/DCVEW+Ox2TaLu0fa108T4AgAEP+oA=
Date:   Sat, 9 Jul 2022 12:58:57 +0000
Message-ID: <efa89122-b428-7691-49d3-f5867206f05a@microchip.com>
References: <20220708203342.256459-1-mail@conchuod.ie>
 <20220708203342.256459-2-mail@conchuod.ie>
 <fb8534d9-baaa-2643-5119-602dfa5de758@microchip.com>
In-Reply-To: <fb8534d9-baaa-2643-5119-602dfa5de758@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1c99354-f38e-4856-0b26-08da61aac992
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?NWs0T1I2clk0RGcwRlJuenF2em8xTEU0OVRTNkVZS1N3N0xjWW5jaVp2dE41?=
 =?utf-8?B?Z1BiTkFLdUFkNGxMTmIveExtQjAzVnJmUDdrNEJ0dEVzeE5Ra1FCV2dRbmlE?=
 =?utf-8?B?SGJabHdIRXVaRVdDa0haSDM0MEJOS0x3Uk1POVpOcENZMlpWNDhsc0loTEJ1?=
 =?utf-8?B?amNVdzU5R3UwMFlOKzlkOWFFNGtVTUdlZERCWVpSS2hPL1lZZDFxUmkrR3pp?=
 =?utf-8?B?bGE1a2ZMVDB3Z29RSmFHeFNCV1lQc3NpRnRFektuOFkweXlmSjZ2R1Q4eFR5?=
 =?utf-8?B?eWxwanR4TkxTeWFrY0FseXlvRStoQ1Axcm1rdlk5UnE3eXRMOGZjMUdXendC?=
 =?utf-8?B?bVRaemR2cDg5ZU0wZ1pNRFhmT0h1Y2ErYUpNTGNlL0ZRMFlsWEFPL1FCVldw?=
 =?utf-8?B?RlpvOXlVcjBuN3g5VzBXTmNPL3pUWDBkTXdUMTB2eEZyTEt6RGhBWk9QWFFr?=
 =?utf-8?B?T3ArdU9lNHNkalZWVjQ4bkxYNWFDcTdPK2J1ZVUyVlJMTEFIVnoxRndjL0JE?=
 =?utf-8?B?V2JUTy96THF0d1lERVUwU1JZbE9sZVBqRU5DTlRFTmlrZFlRek5Zai9jOURX?=
 =?utf-8?B?czBvZlRZdUhac1lnczJ5aHZSUXBjR3BCWmxVSXl5VnJ6L3JqV1Ava0h1TFFQ?=
 =?utf-8?B?OENvYVpadzZwZ3hsaFEwdmZVNTl0QjdERmI1Ym5HL3RkYXFvZi9wTmRCQ25N?=
 =?utf-8?B?cEJKWlVyell5NHk0UmVHamJYRzNUTEFLUGhId1YzQnZ5TTJLM3hYNWI4Y2dR?=
 =?utf-8?B?L0huNjE0QVA1N2VjdXV0YXhDQk9rRWdUUEN1eVBqdjM2WVZvU0krejVnWnJn?=
 =?utf-8?B?RTJ6bkcxaElQeUZPQkJVVlYrQkVVczZaTWMzRVVaZEFZNGZNN1U1bzBlNWND?=
 =?utf-8?B?cnZzMmd0SXdzOUFZSTNUNEp6bGc5YmZhZmxLdkg2dU1uWWdkelRmdXl6RFBC?=
 =?utf-8?B?YmJtYVBxQmtUZE1QMkdSdXVHcmNIU0tEZmVObU04MjZkOWpleTBXOU55d3BW?=
 =?utf-8?B?K1M2VUhGeVpITE9PdmZFRFhEMmxUYmd2ZlZXSUYydDArczhKcTdDa3RoOE9l?=
 =?utf-8?B?TTI0ZldGWTdPendNUVFMN2NtclBHazZialduVFUwMUVBUVViMS9reWkzbkFX?=
 =?utf-8?B?K1pZMXpDMWVzbkJUcGc5SFlWdEV0RDhLOTNhY2QxWUJDa08reVUwenJmeWtw?=
 =?utf-8?B?cjJrenNjWkV3WTFBNGpWMFo0SFlkK1paWUhxejlFK2Z6aUs0YU0rYmt2VCtu?=
 =?utf-8?B?UU9CUlpjclRzZExabWpLRnBUYWFjZFpCQnhxNFVkOVY3THhNQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(136003)(39860400002)(346002)(71200400001)(2616005)(38070700005)(66556008)(110136005)(921005)(8676002)(38100700002)(122000001)(54906003)(31686004)(316002)(36756003)(64756008)(66946007)(91956017)(186003)(4326008)(83380400001)(66476007)(76116006)(6486002)(8936002)(2906002)(5660300002)(86362001)(26005)(966005)(6512007)(478600001)(31696002)(66446008)(7416002)(53546011)(6506007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmRTZkhtYmhzTVpkL2ZzblB2Vmg5RXRuZ2pWc3BXT3ozUVZ1R1k2bHQ5TG9S?=
 =?utf-8?B?L0w2R2dZd2tuQmNxaGVmeHhjckhFbjFMK05aNUYwN3ppT1dqQTFqbmJiaTI1?=
 =?utf-8?B?NXcxMUdNSEhXdkdhVVdqdGJJNDM5eDc3ZUgwYUpoL3JLR3l3bWhiU1ppUmFs?=
 =?utf-8?B?Z21aUzlJekZ2MmI5b0txUkQ2bnBSZnl0ZndhTFNJeUNPRHQ2RTUyVC9EY25t?=
 =?utf-8?B?cVRWMlNGOGRPVjUwL0xNMEV6RzBHOFV0dVVxcHJhbXRWQk91Nkd4R21qSGpT?=
 =?utf-8?B?Y1VjdWtWb1o1RXFRdzJEemc3dFVnMTVVajJ4eFZoTHU0QWhYQlJMQ2JpL2NU?=
 =?utf-8?B?dnJsZ25KeGNqSUxJSzBsWTlUajdEaGdvRU1lSjcvbm1VV25MM0ZMamcrUFNu?=
 =?utf-8?B?UGc5TUt0Q2NlRjlweWJSL2Z6R1hnY29CRzRKVXd3N2FDU1lFVG0vaytsUG0x?=
 =?utf-8?B?TDB6R0YxUnM5d3h3WjdNTE1ONXFrMTRIc3d3WnFXZ1dTWlZiVVNKUHdCT0Fj?=
 =?utf-8?B?aW94UlFFc2VJL2hhVUV1bE9STkFYSDVmdHh2TEc1WEs1WnpGWE1jZFA3WnlF?=
 =?utf-8?B?OU1mQkI4aHk0ZExvRzc4M3ZremcyTm83NnJJQ1VvMmxoRlMwNWRVOGlONWtK?=
 =?utf-8?B?Q0tETkpXeDFLOG1YaFZtRnR0bkJkSFA4VXNSQmszN3RPZVo1Z29HMWFlYUh3?=
 =?utf-8?B?YXZmQS93djc4c1Y4SW1TeTNBaS9kV1lRTlkxQmxOUGRGbTNPWG1DL2tuNmV5?=
 =?utf-8?B?d084MWRqVHVVelp1R05haTA1QVR1OE1td0FDRGZEM1JCSFpIK0NyMmxDb0Zp?=
 =?utf-8?B?VjNhMzlGUndWMG9pK3pSNG1JalcyMDBXVUtWZFRRSEJ0cXlQdnBURjg2NTlQ?=
 =?utf-8?B?cEEzMkZQSWdRR0g4OVI3SkdWdFpmZFV5U1llUDZIclhXU2cvRjhzRXM1dXVp?=
 =?utf-8?B?ekl1UUsxVEppSEovcmxUNnowSW9oRE16RDk0endTV2Y1Zmg2M0tXbFA1V056?=
 =?utf-8?B?ejBCd0l6ZjEwL1RxQlFBT2ZqYTFwUkRaNWloTE90WGtpSWdnMUYrUWhSYlcv?=
 =?utf-8?B?ODlZcG8zRFhOTGxNSzZFc1AxRnN0YjBPU21acUw4VnBiZENEalZJRjRiVERZ?=
 =?utf-8?B?UEZjb3Z6bWYzaHNvaUdUbjMySkRQVjYyWGYzSmZyMUNvZ1pkMmR2UlJxbllP?=
 =?utf-8?B?Q0YwTFlEUk4xS3cyY1hPZytiS0g4WEJqUlVxQlkrL3ZZa3ZwWDBra2x0K05w?=
 =?utf-8?B?MXRtRHVUTXpSV0k0dUlVcm9wb3Urb2Jhclp3aitGbkZXajQvQ0dPcVVrMnM3?=
 =?utf-8?B?RDhDdTh6WW5PSk9vUmZCTVFDSm9icHNMem51SjMyV1F0aENPSFZWRk9vZ2M3?=
 =?utf-8?B?a09JU3NiSWdVRG4zNFdsYWU1WjBaaEtNZ0J5TFA0bFBLeDduN05rZ2w1Umk4?=
 =?utf-8?B?UVcvSmxhbHYrVjFxdzh1ZzBGN2pXTlRRL3pRN0JYQ0hXRmZ4djRoWUNLeXIw?=
 =?utf-8?B?TzZzVTRWKzNYTER2S2R2b0NPbHRMaEN5aTlzYWpLejlidmFPZ3FpWG9RdC9l?=
 =?utf-8?B?eTV1Z3FWRWpIR20yT3dLT0NqQVh1SlErM0ZBMGxvSjJPaFlBd1MxeG5QaS96?=
 =?utf-8?B?aVBVc1pTZVV4SFJNUStnWlNtUVhOcmFxV0Rna0FmRlB0SUdMSWlRTGduSzlE?=
 =?utf-8?B?YmJTTiswZkI5M3VmbUs5aU9nV0I5ZjVuSWlIMkZiTjZ0L2hHUmo5cjVpVWJM?=
 =?utf-8?B?aHErVWlNcUpMdFhxU0xld1V3WG5SRVFpcmx1Wm92VHNYU0hUK0kwOTFSWnJv?=
 =?utf-8?B?VjRkdDEzc1krNXRnaHRIdGxZd05xenJ5NGF0ZEVVM2pIc3lCSnc2dmd4ZFFZ?=
 =?utf-8?B?UzFOaFQ4TmRYOEhETzA2ekFpdXBiMllTU2JsYnZDOUxwOWlIRHdiRno5OXIr?=
 =?utf-8?B?cVlXYnBqMVZxME1CUHNXREVNMVdQMWRScjAwYU1Mb0hieWhramhCSCtZb2wy?=
 =?utf-8?B?Q0xiNmJ0OTVDbHZKR3pwanZTVWZDRmJObzRPSi9sbGk4OTBNTmFtNjh3ZXlW?=
 =?utf-8?B?WGlNV1FtbHlmakpqcEZVQnloZ09ONjZlWGFCcnQ3MmpqcENObGZtcDZwdHlJ?=
 =?utf-8?Q?Lcr65ke0jM8zXM352jPCM+PzX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C70C4228004EAB40935745A31AA5E231@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c99354-f38e-4856-0b26-08da61aac992
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 12:58:58.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Sr6jY9X/XqJO6CbS30phTBMKzI2aY66gqPfwjv6jWNZvBKgtnpp808PS2HCiQrDWi7EGWRMo75DJkT/qhNa3IGxqLSeV7sjO2gTXFmbddE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K0NDIFJ1c3NlbCwgQXJuZA0KDQpPbiAwOC8wNy8yMDIyIDIxOjQ1LCBDb25vciBEb29sZXkgLSBN
NTI2OTEgd3JvdGU6DQo+IE9uIDA4LzA3LzIwMjIgMjE6MzMsIENvbm9yIERvb2xleSB3cm90ZToN
Cj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pg0K
Pj4gYXJtNjQncyBtZXRob2Qgb2YgZGVmaW5pbmcgYSBkZWZhdWx0IGNwdSB0b3BvbG9neSByZXF1
aXJlcyBvbmx5IG1pbmltYWwNCj4+IGNoYW5nZXMgdG8gYXBwbHkgdG8gUklTQy1WIGFsc28uIFRo
ZSBjdXJyZW50IGFybTY0IGltcGxlbWVudGF0aW9uIGV4aXRzDQo+PiBlYXJseSBpbiBhIHVuaXBy
b2Nlc3NvciBjb25maWd1cmF0aW9uIGJ5IHJlYWRpbmcgTVBJRFIgJiBjbGFpbWluZyB0aGF0DQo+
PiB1bmlwcm9jZXNzb3IgY2FuIHJlbHkgb24gdGhlIGRlZmF1bHQgdmFsdWVzLg0KPj4NCj4+IFRo
aXMgaXMgYXBwZWFycyB0byBiZSBhIGhhbmdvdmVyIGZyb20gcHJpb3IgdG8gJzMxMDJiYzBlNmFj
NyAoImFybTY0Og0KPj4gdG9wb2xvZ3k6IFN0b3AgdXNpbmcgTVBJRFIgZm9yIHRvcG9sb2d5IGlu
Zm9ybWF0aW9uIiknLCBiZWNhdXNlIHRoZQ0KPj4gY3VycmVudCBjb2RlIGp1c3QgYXNzaWducyBk
ZWZhdWx0IHZhbHVlcyBmb3IgbXVsdGlwcm9jZXNzb3Igc3lzdGVtcy4NCj4+DQo+PiBXaXRoIHRo
ZSBNUElEUiByZWZlcmVuY2VzIHJlbW92ZWQsIHN0b3JlX2NwdV90b3BvbGd5KCkgY2FuIGJlIG1v
dmVkIHRvDQo+PiB0aGUgY29tbW9uIGFyY2hfdG9wb2xvZ3kgY29kZS4NCj4+DQo+PiBDQzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KLS0tODwtLS0NCj4+ICAjaWZkZWYgQ09O
RklHX0FDUEkNCj4+ICBzdGF0aWMgYm9vbCBfX2luaXQgYWNwaV9jcHVfaXNfdGhyZWFkZWQoaW50
IGNwdSkNCj4+ICB7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3ku
YyBiL2RyaXZlcnMvYmFzZS9hcmNoX3RvcG9sb2d5LmMNCj4+IGluZGV4IDQ0MWUxNGFjMzNhNC4u
MDdlODRjNmFjNWMyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3ku
Yw0KPj4gKysrIGIvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYw0KPj4gQEAgLTc2NSw2ICs3
NjUsMjUgQEAgdm9pZCB1cGRhdGVfc2libGluZ3NfbWFza3ModW5zaWduZWQgaW50IGNwdWlkKQ0K
Pj4gIAl9DQo+PiAgfQ0KPj4gIA0KPj4gK3ZvaWQgX193ZWFrIHN0b3JlX2NwdV90b3BvbG9neSh1
bnNpZ25lZCBpbnQgY3B1aWQpDQo+IA0KPiBBaGggY3JhcCwgSSBmb3Jnb3QgdG8gcmVtb3ZlIHRo
ZSBfX3dlYWsuDQo+IEkgd29uJ3QgaW1tZWRpYXRlbHkgcmVzcGluIHNpbmNlIGl0IGlzIG1pbm9y
LiBJJ3ZlIHB1c2hlZCBpdCAod2l0aG91dA0KPiB0aGUgX193ZWFrKSB0byBodHRwczovL2dpdC5r
ZXJuZWwub3JnL2Nvbm9yL2gvYXJjaC10b3BvIHNvIGl0J2xsIGdldA0KPiB0aGUgbGtwIGNvdmVy
YWdlLg0KDQpBbmQgYnVpbGQgZmFpbHVyZSBmb3IgYXJtMzI6DQoNCj4gdHJlZS9icmFuY2g6IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Nvbm9yL2xpbnV4
LmdpdCBhcmNoLXRvcG8NCj4gYnJhbmNoIEhFQUQ6IGRmMzc5YzRiMTJmNmIyMmZiOGMwN2MyYmUx
NmZkODIxYTRmY2JmYzUgIHJpc2N2OiB0b3BvbG9neTogZml4IGRlZmF1bHQgdG9wb2xvZ3kgcmVw
b3J0aW5nDQo+IA0KPiBFcnJvci9XYXJuaW5nOiAocmVjZW50bHkgZGlzY292ZXJlZCBhbmQgbWF5
IGhhdmUgYmVlbiBmaXhlZCkNCj4gDQo+IGFyY2hfdG9wb2xvZ3kuYzooLnRleHQrMHhiYWMpOiBt
dWx0aXBsZSBkZWZpbml0aW9uIG9mIGBzdG9yZV9jcHVfdG9wb2xvZ3knOyBhcmNoL2FybS9rZXJu
ZWwvdG9wb2xvZ3kubzp0b3BvbG9neS5jOigudGV4dCsweDApOiBmaXJzdCBkZWZpbmVkIGhlcmUN
Cj4gDQo+IEVycm9yL1dhcm5pbmcgaWRzIGdyb3VwZWQgYnkga2NvbmZpZ3M6DQo+IA0KPiBnY2Nf
cmVjZW50X2Vycm9ycw0KPiBgLS0gYXJtLWRlZmNvbmZpZw0KPiAgICAgYC0tIG11bHRpcGxlLWRl
ZmluaXRpb24tb2Ytc3RvcmVfY3B1X3RvcG9sb2d5LWFyY2gtYXJtLWtlcm5lbC10b3BvbG9neS5v
OnRvcG9sb2d5LmM6KC50ZXh0KTpmaXJzdC1kZWZpbmVkLWhlcmUNCj4gDQo+IGVsYXBzZWQgdGlt
ZTogNzIxbQ0KDQpMb29raW5nIGF0IHRoZSBhcm0zMiBpbXBsZW1lbnRhdGlvbiAtIGl0IGFwcGVh
cnMgdG8gYmUgbW9zdGx5IHRoZSBzb3J0IG9mIE1QSURSDQpzdHVmZiB0aGF0IHdhcyByZW1vdmVk
IGZyb20gdGhlIGFybTY0IGltcGxlbWVudGF0aW9uIGluIDMxMDJiYzBlNmFjNyAoImFybTY0Og0K
dG9wb2xvZ3k6IFN0b3AgdXNpbmcgTVBJRFIgZm9yIHRvcG9sb2d5IGluZm9ybWF0aW9uIikuIENv
dWxkIGFybTMyIGJlbmVmaXQgZnJvbQ0KdGhlIHNhbWUgc2hhcmVkIGltcGxlbWVuYXRpb24gdG9v
LCBvciBpcyB1c2FnZSBvZiBNUElEUiBvbmx5IGludmFsaWQgZm9yIGFybTY0Pw0KDQpUaGUgb3Ro
ZXIgZGlmZmVyZW5jZSBpcyBhIGNhbGwgdG8gdXBkYXRlX2NwdV9jYXBhY2l0eSgpIGluIHRoZSBh
cm0zMg0KaW1wbGVtZW50YXRpb24uIENvdWxkIHRoYXQgYmUgbW92ZWQgdG8gc21wX3N0b3JlX2Nw
dV9pbmZvKCkgd2hpY2ggaXMgdGhlIG9ubHkNCmNhbGxzaXRlIG9mIHN0b3JlX2NwdV90b3BvbG9n
eSgpPw0KDQpFaXRoZXIgd2F5LCB3aWxsIHJlc3BpbiBhIHYzIHRoYXQgZG9lc24ndCBicmVhayB0
aGUgYXJtMzIgYnVpbGQgd2hlbg0KQ09ORklHX0dFTkVSSUNfQVJDSF9UT1BPTE9HWSBpcyBlbmFi
bGVkIDopDQoNClRoYW5rcywNCkNvbm9yLg0KDQoNCg0K
