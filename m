Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7495B14E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIHGoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIHGou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:44:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75415FF2;
        Wed,  7 Sep 2022 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619487; x=1694155487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JuwKKWo5c5Od4+7TLzGL5DblM7IitMaPtwqsDX/e86U=;
  b=POkg9+i1IZ93ZXXm0sC8QUSIF7k5qvumRKEc91ETpXhEaTC5g2tjUBMV
   Y2ZwE87vxO8h/uclllyiY+PX5LMcTkgaJpeYb2YUrGxa7ULviFkZMnlzN
   /DuIXWsoEq5FOpK2XQeTKLba7+csxfgIURWChNUO8upkAZSiE76HFHCc0
   dBx+WOd+Si8l/C/Nie6nedJUYmv1024vNEFjIOlVPeHlbWSDYR6DWcfW+
   soQxoY2j42hA1V30aFRy6M0MHx/goxAy5LYxr7vTIhBvditqPViitvsH6
   L4SYB/1Sh4rn55URcOA1yaZ3Qkevaz7NBzn5RZvptd7UtqBSIj90Fmngn
   g==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="189923923"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:44:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:44:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 23:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9NNKITzAlH2xJD6ofJ9UonLc0tCE/M1wwO392mWSn6UkrYX0aH12E0jUcx/Vw5r4nLx2ZfV5XRxkYseo8sF76hp3ZF2lv/bOPZqVCrj7YMJLUL55tBr/EkL4ffta0KRqzFRc6It5uP6tNLY8kR9Z9v2EED/Z5yy0ZUAxxibqSeKth7hMqj/7aGVkyuQR7qQfzEvAKP8VrQvR9XhrLUa8HHxuMVXZH7jUSy/ywYc+XDpeF1+6I06zHbQMIv3tOE4zEonRmF/VeJdS2sJoiAqf1Fqt7McXWcJUXMSgMWD8TUO6vESdHZL2hgTo/TreYNRPzxQXxi9EIFp3D6MJe9r7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuwKKWo5c5Od4+7TLzGL5DblM7IitMaPtwqsDX/e86U=;
 b=HwaO6QE1vzszcaRVSQV2Sbk5Uch7ra9/T/yZSWCcg2XLoI0BKFzKOCPNTnfgzuR5pSBO6dqtuZGdIaQMxAB+4B38eep9Z49SjeZIZCyVQZGZxS+WxAALo0RXOcpVOUPMG77WW58KvWu6R5ChBaOS+/iO4bqVhojB7LlAlDWbMr3bT2VZ0u2FkW5sty/ilQvPKSyW7NqYYaWxZVpZb9Oj6yynNQEGxKF2+WhggUOlUQ/csK98lKf6wQHj5wIZDnnNfH7pWPNDYX4YDyVWgV6b2Jnp+QiHCt/NUNxKHVevPScOlG+vmN/Mnur2HESeBEu9RhPAnNEB5WSfXzbDj3zY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuwKKWo5c5Od4+7TLzGL5DblM7IitMaPtwqsDX/e86U=;
 b=vv0pTLFhMA0jfzG0rwT4qzzK1W0rMeD3DzLT75uXGqB5W4TUoAW4nlD6PZebanQBhC57TTa3NJE+XjBCsNxdR8Bmx0+OyOunVaSYNkhkYkW8xbOR0SQzCXymiwO9ZvcFQu/L5tcU5wQBWBnoe7givzedq/6OPc/bGhfcgA6L5rQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:44:31 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:44:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <nathan@kernel.org>
Subject: Re: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Topic: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Index: AQHYw05y4MB4vKigokCPWQLu42HTIQ==
Date:   Thu, 8 Sep 2022 06:44:31 +0000
Message-ID: <119b58b7-7757-7f76-1472-8047961c9dd1@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-1-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-1-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 201f44d1-29d4-45fd-243f-08da9165959a
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7HV5HwB38bWjWEsfYs6x8TyzPEVZuR2j+ttrEBiRr4QdunYEBiZxDnfMYjCaWoKBPDcjyDbfPYzdvNRpLhj8eFwP+g/NH/BS2A8eo8R5iSQZEqkj7c6+5nIOdEBkHj0A34A3lEp2hcJYyMgPJzruXB6131HkHOUlwZ5V3zuzemDs+ccqiTFgWzk7a6F2csmqRTFrQCms5IrYO6p/MDzP8WnVPOmm9c2ua8yTC2v15pAuQ2oyVydMDfWJD9x9hoWqo0UASbahiunqH1eVWA0QtaT0CZARFvK85t/PvLhTpmI5GzzkLiENZ3OL9EsKbfWugcFaZYpLEiDbRuart6I+ps6KG30MBDIEEE4Bwo1CUEI/8B+D/FV0vTMNDuffiyW4dJRdJOPmCNI/4SWEVjjxjUOO1MwlFD+Chiox+h8i2UmAOtsZbDKlHIvbgHmoj0NY8ZkZjsHRcjwYeDEjFwzeuUcRY+f9/NPXVGeTLz9uJ/pJaWZn8tdofzm1yHj9+Fpw4t7SZDBGzg9vqfGAsPCixqq6hzLDL2svBwOsA+DAULHm9exzVENduV+GHz0Ikn6izDtjnzkCfpTSG4wbDiPFujMM2YwruUpgcRKf3uOs85WskfyhOo+ht3INKJqKqbTHZDYhmCtl2ZvGGRSSVYcMK7mAItA6B4typZKk/cDlhTI0qKTAc2ladv8byANDupBoc7gymlZ3h+m7cL6p904jeXiJ94O3XoxcMvM8VZv2DAOy7kWpaYP0WRTUjMjOWwifXBAHrB7HYyuH+D/ohVKrrM4+tNL3COiYWUDZQskh1pZSxXcJJal7cGDUy51AfK+IfXNeUgkuofZUFlNuOzbFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(45080400002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjNvTGF6cHF2NTM5T2ErRE9Ldkp4VmpxTTZXd3E3dG5GTG5WWVJuNTEwc05k?=
 =?utf-8?B?VVlQR2pBeGRLZGxFNENjcUhEdHgvT0VVNzJ0amtxN1g5ZStSTnhVUENnZEp3?=
 =?utf-8?B?K2hVTmE5dW8rYWUvOFAzdFFKaGNpMUFyTDNNMXFvdDF6elZub1ZLMDZ3L0pQ?=
 =?utf-8?B?cm5IaUYvUWt0MnJ4eDVUOFBsR3FxQ2NRNGR4eHRzK1VzMWQwK2xrYWJCanNt?=
 =?utf-8?B?WWF5MTUzVjg0TkJJWFBjcEVwcHd0S3Irbk5TV0ZXZWFYcjRxOW90OFFJTGRY?=
 =?utf-8?B?SkxQS0ZWTEQ2bDcxbktlMmwyVEpFQXhQVXppb0lsbFY2M3BxcXhoY1ZYeTBl?=
 =?utf-8?B?Tk9HOWM1UThuL1BZL1BGRnlha1liK2hpWVhBRURpNDVmaGxTOTMwN3hPYUlk?=
 =?utf-8?B?Uk9iRW91QnlGRDFTLzhZY3hhbGhVK3V5U2NBd2N4aWdUTTQ5aDhDTElpemgv?=
 =?utf-8?B?cjREbVpIMDVaeFJmME1yN1dETGk2TkZIWVJaZDBvTi84YXlGVjVFMmlERE5k?=
 =?utf-8?B?VEZOOU5HUlZVOTVuM093QXVrRXFJWjVJMVRiL2MxZHQrb2IzSXE1eS9hZ1d2?=
 =?utf-8?B?WHhReFFjQ0U5RnJHcnlEQmRjVlFvRUJOeEpaRFJ2RVNjUE1DSGNreXdhbUhs?=
 =?utf-8?B?djRYOGllRkhvVndmNStOMUlxbUl1RU1MVzVZK2tGZkFmeGxjM2NsVjRELzFm?=
 =?utf-8?B?d1R3MU04OFlRQXNpN3RuMDBBeStNWFZvbXYrMmRqZWlEbFljSytRZVF6aEk4?=
 =?utf-8?B?RFRzN2Vld3krVHFFdVozRUVpaHFTZEhvNDh4UmRyNjRjdGlXVi9jc2J6Q0NY?=
 =?utf-8?B?NjNiZUFoSUNIbDV3U2g0ajN6eWZBeUtHQkNpZ2EvM3UwSlN0WHIva0VUTmdw?=
 =?utf-8?B?Q09WdFV1QU8wbUR4dkZpejdxL2FKTVc1UmMwcmdkN255bVlUNlB6YmZIVmhk?=
 =?utf-8?B?eXEraTBuenZMbWJmbXlzVGVMRWxXYmxCWlVwY1pvTzVjMzhKYnlZZUpJLzdW?=
 =?utf-8?B?S2NIS1IzSCs5NzVac1hVMkRKZmxVdGZVNEhLb254SkhScXZFYlEzVWR3aERF?=
 =?utf-8?B?WVZ4dDdkSWYxYTZIMnlFdTlJdnNTZHV1S3hLaDVhMHRoQys0WjRVN1ZBZ2d1?=
 =?utf-8?B?MmUwOGJOM2t0SCtvQmNUZmtrVDJNSnNmaDkrY0dxMnlGdUdTVUVrMmtOUlFB?=
 =?utf-8?B?UHY3ckFveXFvVHNmQ09XTzhMd0VoUUdVZGlQUldIM0xQTU1QWHFsMitSbHUx?=
 =?utf-8?B?eDJxeEhBSkZuNTRIbTF6ZlV3bTk5ZTFRWkFxT2VVbHRWeitPb2dBeGNwS3l1?=
 =?utf-8?B?TEVsY1gzTmR4cWNlT00vUG95LzRDaTRQcGFIMFJGdGpQclRoUWdNTVV4UWNv?=
 =?utf-8?B?eksrZTUxRE83SlJpMEtLOXMvVm9zV0NoY3NTQUpHcjhtZnVweWdOemxPQ3M4?=
 =?utf-8?B?RGVUeUxYc1N1YUdWN1M5WUhyZExXTjFGdmg1cnlCTFhZZ3EyUFZ2Y3pJTlQw?=
 =?utf-8?B?aGhuOExRS1VUTWR1OUg3WVdZZExDS2ZsaWFIYWVCSDVma3B2bjJPRFNHSDhn?=
 =?utf-8?B?ajhGUG9pWVhpUXhiMm1QemVBb2hEZE1yeklOd2JETmtYcWlGMTcwSlh5OXNU?=
 =?utf-8?B?OEVhUnBiN2xpUmh2aWd5dG9CVXNBbTlRK2FhaEkvMnVEM0NnWFBLVFM2ZlJK?=
 =?utf-8?B?M2ZXRU1uZkNHZ2F2ZXRmZUxjZHh0c05QTWYvSlV6M1N0b3MwT2IwaFhVWitH?=
 =?utf-8?B?NmNIamhQNU5yS01RY3JVdXc4anExK1dUdkNhNlVqZ3k1VVBhL0tRM1c4N3NV?=
 =?utf-8?B?eVJ1QU40UjBmV3E0Y2hrQjNCNm5ZbnZPOTRtbng0RkRZTG9DUDdUUFI2Q3By?=
 =?utf-8?B?eGRDQmNyTkVCWlJwWnVtSm5tNmNXakRtdmE5cDJVcWVMeXhOVmxqckUwWCt2?=
 =?utf-8?B?VTk5TWZZYUFtUGVMRldGdmRVZXpKZUhrWDJ3NGhxdGx2eVFEUDNtNkpXRmVr?=
 =?utf-8?B?bEVjSzd3RWtlbXkvdDhSRXZDMGpTWWtGeFFmQ0pUclBhWXpOZng2anRSaHpi?=
 =?utf-8?B?bi9SdEoxYmpEbjdlZDlhdDFNdy9SbCt5M2JSWmJxSUw5TlJrbU9zbzBkMGln?=
 =?utf-8?B?RXJ6Y2pSbkNoT3gvV1ZWY0c1RmsxR2dGV05HYUx3MzNJdGczWCt4VkxweFpY?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <948FF9BAFF5554458405DD155A8510E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f44d1-29d4-45fd-243f-08da9165959a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:44:31.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0dzsmd8W50pK6x5h3lJiDZQtJ6WdylCfnl2INS4Ro7kdPj7ZwcsY+PgeRAVhM1p/q6PYqZngjRA69pk0hsPQaOnbEpxJozbMyBuYnwQC8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBVbm5vdGljZWQgaW4g
Y3VycmVudCBjb2RlLCB0aGVyZSBpcyBhbiBhcnJheSBib3VuZHMgdmlvbGF0aW9uIHByZXNlbnQN
Cj4gZHVyaW5nIGNsb2NrIHJlZ2lzdHJhdGlvbi4gVGhpcyBzZWVtcyB0byBmYWlsIGdyYWNlZnVs
bHkgaW4gdjYuMC1yYzEsDQo+IGFuZCBsaWZlIGNhcnJ5cyBvbi4gV2hpbGUgY29udmVydGluZyB0
aGUgZHJpdmVyIHRvIHVzZSBzdGFuZGFyZCBjbG9jaw0KPiBzdHJ1Y3RzL29wcywga2VybmVsIHBh
bmljcyB3ZXJlIHNlZW4gZHVyaW5nIGJvb3Qgd2hlbiBidWlsdCB3aXRoIGNsYW5nOg0KPiANCj4g
WyAgICAwLjU4MTc1NF0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMGIxDQo+IFsgICAgMC41OTE1
MjBdIE9vcHMgWyMxXQ0KPiBbICAgIDAuNTk0MDQ1XSBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gWyAg
ICAwLjU5NzQzNV0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNi4w
LjAtcmMxLTAwMDExLWc4ZTE0NTljZjRlY2EgIzENCj4gWyAgICAwLjYwNjE4OF0gSGFyZHdhcmUg
bmFtZTogTWljcm9jaGlwIFBvbGFyRmlyZS1Tb0MgSWNpY2xlIEtpdCAoRFQpDQo+IFsgICAgMC42
MTMwMTJdIGVwYyA6IF9fY2xrX3JlZ2lzdGVyKzB4NGE2LzB4ODVjDQo+IFsgICAgMC42MTc3NTld
ICByYSA6IF9fY2xrX3JlZ2lzdGVyKzB4NDllLzB4ODVjDQo+IFsgICAgMC42MjI0ODldIGVwYyA6
IGZmZmZmZmZmODAzZmFmN2MgcmEgOiBmZmZmZmZmZjgwM2ZhZjc0IHNwIDogZmZmZmZmYzgwNDAw
YjcyMA0KPiBbICAgIDAuNjMwNDY2XSAgZ3AgOiBmZmZmZmZmZjgxMGU5M2Y4IHRwIDogZmZmZmZm
ZTc3ZmU2MDAwMCB0MCA6IGZmZmZmZmU3N2ZmYjM4MDANCj4gWyAgICAwLjYzODQ0M10gIHQxIDog
MDAwMDAwMDAwMDAwMDAwYSB0MiA6IGZmZmZmZmZmZmZmZmZmZmYgczAgOiBmZmZmZmZjODA0MDBi
N2MwDQo+IFsgICAgMC42NDY0MjBdICBzMSA6IDAwMDAwMDAwMDAwMDAwMDEgYTAgOiAwMDAwMDAw
MDAwMDAwMDAxIGExIDogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAgIDAuNjU0Mzk2XSAgYTIgOiAw
MDAwMDAwMDAwMDAwMDAxIGEzIDogMDAwMDAwMDAwMDAwMDAwMCBhNCA6IDAwMDAwMDAwMDAwMDAw
MDANCj4gWyAgICAwLjY2MjM3M10gIGE1IDogZmZmZmZmZmY4MDNhNTgxMCBhNiA6IDAwMDAwMDAy
MDAwMDAwMjIgYTcgOiAwMDAwMDAwMDAwMDAwMDA2DQo+IFsgICAgMC42NzAzNTBdICBzMiA6IGZm
ZmZmZmZmODEwOTlkNDggczMgOiBmZmZmZmZmZjgwZDZlMjhlIHM0IDogMDAwMDAwMDAwMDAwMDAy
OA0KPiBbICAgIDAuNjc4MzI3XSAgczUgOiBmZmZmZmZmZjgxMGVkM2M4IHM2IDogZmZmZmZmZmY4
MTBlZDNkMCBzNyA6IGZmZmZmZmU3N2ZmYmMxMDANCj4gWyAgICAwLjY4NjMwNF0gIHM4IDogZmZm
ZmZmZTc3ZmZiMTU0MCBzOSA6IGZmZmZmZmU3N2ZmYjE1NDAgczEwOiAwMDAwMDAwMDAwMDAwMDA4
DQo+IFsgICAgMC42OTQyODFdICBzMTE6IDAwMDAwMDAwMDAwMDAwMDAgdDMgOiAwMDAwMDAwMDAw
MDAwMGM2IHQ0IDogMDAwMDAwMDAwMDAwMDAwNw0KPiBbICAgIDAuNzAyMjU4XSAgdDUgOiBmZmZm
ZmZmZjgxMGM3OGMwIHQ2IDogZmZmZmZmZTc3ZmY4OGNkMA0KPiBbICAgIDAuNzA4MTI1XSBzdGF0
dXM6IDAwMDAwMDAyMDAwMDAxMjAgYmFkYWRkcjogMDAwMDAwMDAwMDAwMDBiMSBjYXVzZTogMDAw
MDAwMDAwMDAwMDAwZA0KPiBbICAgIDAuNzE2ODY5XSBbPGZmZmZmZmZmODAzZmI4OTI+XSBkZXZt
X2Nsa19od19yZWdpc3RlcisweDYyLzB4YWENCj4gWyAgICAwLjcyMzQyMF0gWzxmZmZmZmZmZjgw
NDAzNDEyPl0gbXBmc19jbGtfcHJvYmUrMHgxZTAvMHgyNDQNCj4gDQo+IEl0IGZhaWxzIG9uICJj
bGtfcGVyaXBoX3RpbWVyIiAtIHdoaWNoIHVzZXMgYSBkaWZmZXJlbnQgcGFyZW50LCB0aGF0IGl0
DQo+IHRyaWVzIHRvIGZpbmQgdXNpbmcgdGhlIG1hY3JvOg0KPiBcI2RlZmluZSBQQVJFTlRfQ0xL
KFBBUkVOVCkgKCZtcGZzX2NmZ19jbGtzW0NMS18jI1BBUkVOVF0uY2ZnLmh3KQ0KPiANCj4gSWYg
cGFyZW50IGlzIFJUQ1JFRiwgc28gdGhlIG1hY3JvIGJlY29tZXM6ICZtcGZzX2NmZ19jbGtzWzMz
XS5jZmcuaHcNCj4gd2hpY2ggaXMgd2VsbCBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgYXJyYXkuIEFt
YXppbmdseSwgYnVpbGRzIHdpdGggR0NDDQo+IDExLjEgc2VlIG5vIHByb2JsZW0gaGVyZSwgYm9v
dGluZyBjb3JyZWN0bHkgYW5kIGhvb2tpbmcgdGhlIHBhcmVudCB1cA0KPiBldGMuIEJ1aWxkcyB3
aXRoIGNsYW5nLTE1IGRvIG5vdCwgd2l0aCB0aGUgYWJvdmUgcGFuaWMuDQo+IA0KPiBEcm9wIHRo
ZSBtYWNybyBmb3IgdGhlIFJUQ1JFRiBhbmQgdXNlIHRoZSBhcnJheSBkaXJlY3RseSB0byBhdm9p
ZCB0aGUNCj4gcGFuaWMsIHVzaW5nIGEgbmV3bHkgYWRkZWQgZGVmaW5lIHRoYXQgYnJpbmdzIHRo
ZSBpbmRleCBpbnRvIHRoZSB2YWxpZA0KPiByYW5nZS4NCj4gDQo+IEZpeGVzOiAxYzZhN2VhMzJi
OGMgKCJjbGs6IG1pY3JvY2hpcDogbXBmczogYWRkIFJUQ1JFRiBjbG9jayBjb250cm9sIikNCj4g
Q0M6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1i
eTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9j
bGstbXBmcy5jDQo+IGluZGV4IDA3MGMzYjg5NjU1OS4uOWU0MWYwN2IzZmE2IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYw0KPiArKysgYi9kcml2ZXJzL2Ns
ay9taWNyb2NoaXAvY2xrLW1wZnMuYw0KPiBAQCAtMjcsNiArMjcsOCBAQA0KPiAgI2RlZmluZSBN
U1NQTExfUE9TVERJVl9XSURUSAkweDA3dQ0KPiAgI2RlZmluZSBNU1NQTExfRklYRURfRElWCTR1
DQo+ICANCj4gKyNkZWZpbmUgUlRDUkVGX09GRlNFVAkJKENMS19SVENSRUYgLSBDTEtfRU5WTSkN
Cj4gKw0KPiAgc3RydWN0IG1wZnNfY2xvY2tfZGF0YSB7DQo+ICAJdm9pZCBfX2lvbWVtICpiYXNl
Ow0KPiAgCXZvaWQgX19pb21lbSAqbXNzcGxsX2Jhc2U7DQo+IEBAIC0zODEsNyArMzgzLDggQEAg
c3RhdGljIHN0cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayBtcGZzX3BlcmlwaF9jbGtzW10gPSB7
DQo+ICAJQ0xLX1BFUklQSChDTEtfTUFDMCwgImNsa19wZXJpcGhfbWFjMCIsIFBBUkVOVF9DTEso
QUhCKSwgMSwgMCksDQo+ICAJQ0xLX1BFUklQSChDTEtfTUFDMSwgImNsa19wZXJpcGhfbWFjMSIs
IFBBUkVOVF9DTEsoQUhCKSwgMiwgMCksDQo+ICAJQ0xLX1BFUklQSChDTEtfTU1DLCAiY2xrX3Bl
cmlwaF9tbWMiLCBQQVJFTlRfQ0xLKEFIQiksIDMsIDApLA0KPiAtCUNMS19QRVJJUEgoQ0xLX1RJ
TUVSLCAiY2xrX3BlcmlwaF90aW1lciIsIFBBUkVOVF9DTEsoUlRDUkVGKSwgNCwgMCksDQo+ICsJ
Q0xLX1BFUklQSChDTEtfVElNRVIsICJjbGtfcGVyaXBoX3RpbWVyIiwNCj4gKwkJICAgJm1wZnNf
Y2ZnX2Nsa3NbQ0xLX1JUQ1JFRiAtIFJUQ1JFRl9PRkZTRVRdLmh3LCA0LCAwKSwNCg0KQSBwZXJz
b25hbCB0YXN0ZTogYXMgY2xrIElEcyBhbmQgY2xrIGluZGV4ZXMgaW4gbXBmc19jZmdfY2xrc1td
IGFycmF5IGFyZQ0KZGlmZmVyZW50IHRoaW5nIChJRCBmb3IgY2xrX3BlcmlwaF90aW1lciBpcyBh
bHJlYWR5IGRpZmZlcmVudCkgYW5kIHRoZQ0KQ0xLX1JUQ1JFRiAtIFJUQ1JFRl9PRkZTRVQgaGVy
ZSBpcyBpbiB0aGUgZW5kIENMS19FTlZNID0gMyBtYXliZSBlYXNpZXIgdG8NCmZvbGxvdyB0aGUg
Y29kZSB3b3VsZCBiZSB0byBhZGQgbmV3IG1hY3JvcyBsaWtlOg0KDQojZGVmaW5lIENMS19DUFVf
T0ZGIDANCiNkZWZpbmUgQ0xLX0FYSV9PRkYgMQ0KI2RlZmluZSBDTEtfQUhCX09GRiAyDQojZGVm
aW5lIENMS19SVENSRUZfT0ZGIDMNCg0KYW5kIGNoYW5nZSB0aGUgQ0xLX1BBUkVOVCgpIG1hY3Jv
IHNvbWV0aGluZyBhcyBmb2xsb3dzOg0KDQojZGVmaW5lIFBBUkVOVF9DTEsoUEFSRU5UKSAoJm1w
ZnNfY2ZnX2Nsa3NbQ0xLXyMjUEFSRU5UIyNfT0ZGXS5odykNCg0KPiAgCUNMS19QRVJJUEgoQ0xL
X01NVUFSVDAsICJjbGtfcGVyaXBoX21tdWFydDAiLCBQQVJFTlRfQ0xLKEFIQiksIDUsIENMS19J
U19DUklUSUNBTCksDQo+ICAJQ0xLX1BFUklQSChDTEtfTU1VQVJUMSwgImNsa19wZXJpcGhfbW11
YXJ0MSIsIFBBUkVOVF9DTEsoQUhCKSwgNiwgMCksDQo+ICAJQ0xLX1BFUklQSChDTEtfTU1VQVJU
MiwgImNsa19wZXJpcGhfbW11YXJ0MiIsIFBBUkVOVF9DTEsoQUhCKSwgNywgMCksDQoNCg==
