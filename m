Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0C580F29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbiGZIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:36:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21363A9;
        Tue, 26 Jul 2022 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658824588; x=1690360588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uuhffvcpLAkA4fNDaLkh/hxuiRvjAwirOT66zqtO4k8=;
  b=G9G5j1ThaAiXgMzQ6qlG3dCYqYgNMuF/vqvcxpIHtVaGPkpwbV87TLSe
   ULoJhrRn1VdRL48dtse7dlFnuaV976jueIPyjG8EaJPObYPdXSJGcyTye
   X9iRhR7MmLt9f85zOSARU11zSsUtuLAtP2pIqvXS/rhB/fcQfvXBu5wUJ
   +mf4j1WENnV9IG07L+Q5RcaoWEWr+jI6tPPp2N563G6ngra6ZAql160tW
   vMRbkRnLqDun2GiFMEoHknQRLwo28ZdRdNBvfA6q837eWOI0eja6Rrn/m
   oPtfQ6UHG9cveD6Z5uPIO4PQbhmqULtaqurYX2E4TpOVLmsfF9VDulfIY
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="106139690"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 01:36:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 01:36:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Jul 2022 01:36:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMrsNMs30yR0IMhgXzAaJZIVXYxO6mLIyTQpI5eECJCFiqZws9l+ImMBVOE/QFnB1Sh1uuuefIzV+zkawTM19YFBQzSML3KMKOwXO3X9VmGBeyp5JLDWc2/hp1DuD5/oP7AIt19hVN0K5m4SlkjzK/zUU8sLxs+AeyOFKv1V3rOr8FTjIIsSHA197knXwpL2muEsgUpBmTzVXs/51++eifPQDSllBdAWDms3/+LWOVottC7FtLP68I8paMSdJUQL4EINQA2rSjWqwmMQpYiTmsx1GVwMJTCgzUlEjXDt1ep38IZEeZsoSqN5/3vMhgPLJ/bPBRgB68T78WmkEmseTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuhffvcpLAkA4fNDaLkh/hxuiRvjAwirOT66zqtO4k8=;
 b=HdZUXKvNCjUaTnGoyQGBALUwmxvh7ZSZCT31Xrim1Aa/LoMuHlFumdXHpB1fa9mJBBXHQsDk6w5u04p/VnPesCIqGLQoIj4rjUG9x5pdKCEPyZlmEVXKRWa1o9V9xF9CNNIwcuE2UHaOzZAFWJvimlTHm9JzacJQ8d20frmIhHbh6OL3K8u7ZDCaOitr1Bp0wM9FtOKnwIjw69cije/xjLIwnVcLIxdslXZumdpzQdUhjGVoXLQbBZfwMM0KnlxJLj/obrym7MdYx9BSAfMY4P4F9bKCuEk9fj3aADEzruuZxSK8ZlJhPMbtZjhhhDSif8pFENhdhkx4ig5vPH/TKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuhffvcpLAkA4fNDaLkh/hxuiRvjAwirOT66zqtO4k8=;
 b=K+znKEonNx60I/32UTO/2FYgbWgiPH/+teSXOQ0QCqfWj5ZbxZ7VZgl3WXVJBjiCmTz8Uwp8OV+bpcagubD9mxT8TBC3NrBVMvw+TNwgFGQ3pKmStjdveVthCX+5MWKCGuA943E19cXDXltB5DCLbPWEicFLUebsRdrvwk0zIc0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 26 Jul
 2022 08:36:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 08:36:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: lan966x: add support for pcb8309
Thread-Topic: [PATCH v2 2/2] ARM: dts: lan966x: add support for pcb8309
Thread-Index: AQHYoMrE0FszQiA/OEWyh+jAaUdqiQ==
Date:   Tue, 26 Jul 2022 08:36:15 +0000
Message-ID: <fb09de47-2fb0-e84f-5520-aa6bc684f657@microchip.com>
References: <20220722131836.2377720-1-horatiu.vultur@microchip.com>
 <20220722131836.2377720-3-horatiu.vultur@microchip.com>
In-Reply-To: <20220722131836.2377720-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2965f7b-478a-4912-949d-08da6ee1e74a
x-ms-traffictypediagnostic: LV2PR11MB5999:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mX/lqIeOuxPZO5tU1y94UaTBptDCeuE4045th0l9ZlFQ2igtgrS8byw7diGF/EAuHTtgUItMx7NUHWxx5Uf2wLkleLcbprYuZpO3ZGn5UE847cGq84TSI0g+sOIgh5EHoWaqvNluQIi5yL35hSKUDiNiOjX7YsaWbpCs7uPKQgcllW4aDgTMzkKzTxM7yZOsIgQP7WECmuHA/kYbC+jpYoSeejOKL76zcuSRtMXfWvTPpXo4vgBg+o3l/qgJr+sQ6XD1+WUwshv3SwVPSciMgvopjOaziMpWnJJmhOTWGUbzAGOnRsXYTdNCCVDAhIVmqKPFhFGNGUT87uZ/832WKNZ9jKXfCq+hNyvssiZ+q7D5mq+DJ6EdPej1rCpK5QpeP5oZDMVGd/wIlOvEb0gJ4PlonxIcaAQuQdRngmuJtlpjV5loG2Mj5Vyg9G1pPx4oOF4FizyU4zL2TN1azyj45v1KqAY3M5mttyz/siFxj3ScS3ZlwawxY/g30QxCLvjYXZFAN2XGqgurRl2KFluGCrOpT6Wv3XHQS0VmXa7UMrUmc6L/8n/JUdTwQ4HzAmO6pdMtjb9dfmT95bB4FS2MGu2Gh4XMmz0lBzjQzRrCkbjLmdUQgzFjIUk1BfWQVuty1Juko9pVPtV4Qdqq77hGWtS8qm8oQaWMHacfLjhRFtx4WjAfgb382rt8RrMQljB7K68oQ9xys5VqPe5bFH+NJs78nBSQI139BU2v60BXvfMCGu0wApB1C3/nV5CwYa7m7ii0Tujalq/GL37kxGtioZsSsafdc6gSA86yUuPtXtTVL+J8OofEK8GDdsbxnpd98xjqGW2Srjcrcu/MuArayD18sh2VWhfNPV5wUE89JqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(346002)(396003)(39860400002)(31696002)(2616005)(7416002)(38070700005)(5660300002)(122000001)(6512007)(66476007)(316002)(186003)(83380400001)(6506007)(110136005)(26005)(54906003)(31686004)(53546011)(66446008)(36756003)(91956017)(76116006)(66556008)(4326008)(2906002)(86362001)(6486002)(478600001)(38100700002)(41300700001)(8936002)(71200400001)(64756008)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnRkVDRHc3pyWVhOdk03OXhxL1BNYzhIUzRxTnZIM3NBL0ZGRXlxdFAwdGE4?=
 =?utf-8?B?eThSQkx3dFVSMUhGK081V0I2bzFLdzlGbkJyeEtWWUNJejN6cEF0MVhNa0d5?=
 =?utf-8?B?bVlOR24vV3JySTIvUnZOK0NiY3FmQ0lmVCtic09ES0FCMVBCYUk1Wm9FQUtZ?=
 =?utf-8?B?ZjR5K05UUEFqZ3g4MkdpWnNUMXFYSHFweDl6VDhrY3J4UDVkb3d5NEI1SzVL?=
 =?utf-8?B?endUaWFzbG1CQURDS0p4MTNDNkxxeHg5S1I1R04rNVRYZXM1ZnZiRFZOZDMv?=
 =?utf-8?B?M0RHV1NZelpnVHAzMTNwSU9zUG1ORDV2TzFJQ0ZUdjVBQk1kY2pSOUlSbUQz?=
 =?utf-8?B?TWNFSUhuRERWT01IaitiYXYrN3cvYXN2ZEx4RGR0dkhrLzZrZDRhZlYrK0Qx?=
 =?utf-8?B?MXROaDdkdlJvelJycC93OXBFS1JzdmJLMXFyNGdaNnpwSjdpV0FrTkZmYUJM?=
 =?utf-8?B?R1Q4NW1zZFJpZEc4VUR2Y3F4TzNnSmZPN2Irc08yNHBycHFDcHcwZEZYWEpE?=
 =?utf-8?B?L1UwNUt6OXdINkVFOEluOGZWQW1SaURkWVhCUXBUVkpYZU9WWUgwN210WndZ?=
 =?utf-8?B?alB5RUxHRXR4dGJwRThNZDNyQUU2R0NqVFRmQkttenNuT0t4cVhYa0RpTGlX?=
 =?utf-8?B?S3FJYStwT24wUE9xV2ZwWXBNak94RGhJNWJBamhVdkJoSnBpb0NaZDd3VWJJ?=
 =?utf-8?B?R2NOSkRJdTF5ZUN3U0lBOTd3YlA0QzUrVEt3d1BhQm1lM295c3NQVnNlRzFt?=
 =?utf-8?B?WGtmWVpsbFlNWGxIemZUVUNzZTFPNzFxdlBmY1F1aXgvU0UvUCtveWMzTnND?=
 =?utf-8?B?YzdrUW5sdzFZSVd4bEVReWJqV01vRzZuMWNnTkwzSjRzamhOMFFEWTN0cEdn?=
 =?utf-8?B?LzZqTThCemo3WThwUHhFTmw2OXZQQXpOUkljVHNEczRPMnlhL3N4QnVuMHVC?=
 =?utf-8?B?TXpFU2R0ZUR3LzRlMXJCeEhQK3lXdVNLNEFVREYvcVlqenB1SitldTV6VVFq?=
 =?utf-8?B?czhPZVhDVFdONGRiVGd1OC8zbXBnNEJVYjJNb1RJRWk1TDE3dUNVajkzUmJO?=
 =?utf-8?B?dVBpSXJHRHA0NmVHektLaXdYb1Q3cklpTGE0NG05emN6RW9QajZhY29VK1Zi?=
 =?utf-8?B?SGVJTUdWa2pGbmY4SnhpMHZMRkpMSGhkMU1Rb2t0WHR4OEo3bHlMbXo2NXU1?=
 =?utf-8?B?MG1aWEt3cHUyMzBWeFpibGZTb2RTS1ZaVm03UHBaY3JpQ3VRVytYcjVJNlh5?=
 =?utf-8?B?QVVrR1BnOTJkRE5yeDdPTm9UbnhkWExjK3Fac3VPYjhscXlMc3hFVzJmTEE2?=
 =?utf-8?B?K0w1OFFSQTVoNjMrZHRwTURkSHU0M2E5SHRrdS85MXF3bXFkQmMwdnhCSHhj?=
 =?utf-8?B?QlozM1NYRjc1MDBFYjBGWTBzQ2dmbk9KajRubUdnajdSNGt5Z0s3eW5kUTZ0?=
 =?utf-8?B?bDJDemZuYUJjN1FEVkhkUUJnODFhcUJSMnhxdk1COWRQMFlyY2c1V29Pdzhx?=
 =?utf-8?B?bmhyLzZwRXpKS3Z4dGtFNXd5aGY3NExmQm01QmNJQVlwNG1DYy9LdnhTREFt?=
 =?utf-8?B?TVNReG0wTTRMeDhVMENKMU4xK0QwM0Y1cFN1bURkK2lQV3BTd0NHejVlcHpZ?=
 =?utf-8?B?ZjljelNNdzJqTEZiOW43OXdubklGTUVMZFBWR1FhTjJPeE4wckNxYVJhS2ln?=
 =?utf-8?B?b2ZJa0R1aG13cjlzNUxRMGFaTkpDYTRjaDE4Z2xLd1ZFbmNtQ1BnMlJKMEM3?=
 =?utf-8?B?Mm9PZnUrS05zU2I4aUJJOWg1Vkt3aVJZWmZTYXJFTTEzTmFHeXZ6dHRFenVu?=
 =?utf-8?B?c2taRGc1ZC9PbVY2cmhsWVJJSGdjUkY3VnNHVjg0UmdSdGFKajlqUHBGTlRm?=
 =?utf-8?B?QTg1STY4U0VxVUdJbUhFbTBINElTNFRTZWh1YnNTUUhKbVBJb3VlOEwvZmZL?=
 =?utf-8?B?NlpJdnorNnJiVlpJckMyQ0Jxc2lYY0xVbzN3M3NvSG5aeTNYRGx2NmNvMTl0?=
 =?utf-8?B?U0F3QzNVeDNHbDZxcXFhVGZlMmM3TjREZ0ROWXpRbzEzME1pU0dJRHpjaHZ3?=
 =?utf-8?B?RlZTcXFIQ0lOOWRFMlNPWTU4Q21BRURtUkMvUUJLNHlEU2JWamd6TnBkbGlS?=
 =?utf-8?B?MlF3MWpJN1VDSWJ1RTlrM09HUmR5UmJvUjdVclVPcU03WnpRSjEvTnFpTXVW?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BED91B3A21B38043BE94747D26C565B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2965f7b-478a-4912-949d-08da6ee1e74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 08:36:15.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJ+uOWYx5aFGx9eUZox4+Fpg0yNUQqcHTFMufj06KNAPdWz0WkTBOOGmgv8wbd7/a1WqTbI54YHP3jwEMhrK36lAKk5gKyWiuygn5geF0zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDcuMjAyMiAxNjoxOCwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBiYXNpYyBz
dXBwb3J0IGZvciBwY2I4MzA5LiBJdCBpcyBzaW1pbGFyIHdpdGggcGNiODI5MSB3aXRoIG9uZSBi
aWcNCj4gZGlmZmVyZW5jZSB0aGF0IGlzIGhhdmluZyAyIFNGUCBjYWdlcy4gVGhlcmVmb3JlIGl0
IGhhcyA0IG5ldHdvcmsgcG9ydHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhdGl1IFZ1bHR1
ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCg0KQXBwbGllZCB0byBhdDkxLWR0LCB0
aGFua3MhDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAg
IHwgICAzICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgzMDkuZHRzIHwgMTg0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE4NiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC1wY2I4MzA5LmR0cw0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gaW5kZXgg
MTg0ODk5ODA4ZWU3Li42YTYxNjZlM2E0MDUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+IEBAIC03
NzIsNyArNzcyLDggQEAgZHRiLSQoQ09ORklHX1NPQ19JTVhSVCkgKz0gXA0KPiAgZHRiLSQoQ09O
RklHX1NPQ19MQU45NjYpICs9IFwNCj4gIAlsYW45NjZ4LXBjYjgyOTEuZHRiIFwNCj4gIAlsYW45
NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LTZnLTJncy5kdGIgXA0KPiAtCWxhbjk2Nngta29u
dHJvbi1rc3dpdGNoLWQxMC1tbXQtOGcuZHRiDQo+ICsJbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gt
ZDEwLW1tdC04Zy5kdGIgXA0KPiArCWxhbjk2NngtcGNiODMwOS5kdGINCj4gIGR0Yi0kKENPTkZJ
R19TT0NfTFMxMDIxQSkgKz0gXA0KPiAgCWxzMTAyMWEtaW90LmR0YiBcDQo+ICAJbHMxMDIxYS1t
b3hhLXVjLTg0MTBhLmR0YiBcDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45
NjZ4LXBjYjgzMDkuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MzA5LmR0cw0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjA1Y2UyN2VkNTY0
OA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNi
ODMwOS5kdHMNCj4gQEAgLTAsMCArMSwxODQgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMCsgT1IgTUlUKQ0KPiArLyoNCj4gKyAqIGxhbjk2NnhfcGNiODMwOS5kdHMg
LSBEZXZpY2UgVHJlZSBmaWxlIGZvciBQQ0I4MzA5DQo+ICsgKi8NCj4gKy9kdHMtdjEvOw0KPiAr
I2luY2x1ZGUgImxhbjk2NnguZHRzaSINCj4gKyNpbmNsdWRlICJkdC1iaW5kaW5ncy9waHkvcGh5
LWxhbjk2Nngtc2VyZGVzLmgiDQo+ICsNCj4gKy8gew0KPiArCW1vZGVsID0gIk1pY3JvY2hpcCBF
VkIgLSBMQU45NjYyIjsNCj4gKwljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxsYW45NjYyLXBjYjgz
MDkiLCAibWljcm9jaGlwLGxhbjk2NjIiLCAibWljcm9jaGlwLGxhbjk2NiI7DQo+ICsNCj4gKwlh
bGlhc2VzIHsNCj4gKwkJc2VyaWFsMCA9ICZ1c2FydDM7DQo+ICsJCWkyYzEwMiA9ICZpMmMxMDI7
DQo+ICsJCWkyYzEwMyA9ICZpMmMxMDM7DQo+ICsJfTsNCj4gKw0KPiArCWNob3NlbiB7DQo+ICsJ
CXN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgiOw0KPiArCX07DQo+ICsNCj4gKwlncGlv
LXJlc3RhcnQgew0KPiArCQljb21wYXRpYmxlID0gImdwaW8tcmVzdGFydCI7DQo+ICsJCWdwaW9z
ID0gPCZncGlvIDU2IEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJCXByaW9yaXR5ID0gPDIwMD47DQo+
ICsJfTsNCj4gKw0KPiArCWkyYy1tdXggew0KPiArCQljb21wYXRpYmxlID0gImkyYy1tdXgiOw0K
PiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJ
CW11eC1jb250cm9scyA9IDwmbXV4PjsNCj4gKwkJaTJjLXBhcmVudCA9IDwmaTJjND47DQo+ICsN
Cj4gKwkJaTJjMTAyOiBpMmMtc2ZwQDEgew0KPiArCQkJcmVnID0gPDE+Ow0KPiArCQl9Ow0KPiAr
DQo+ICsJCWkyYzEwMzogaTJjLXNmcEAyIHsNCj4gKwkJCXJlZyA9IDwyPjsNCj4gKwkJfTsNCj4g
Kwl9Ow0KPiArDQo+ICsJbXV4OiBtdXgtY29udHJvbGxlciB7DQo+ICsJCWNvbXBhdGlibGUgPSAi
Z3Bpby1tdXgiOw0KPiArCQkjbXV4LWNvbnRyb2wtY2VsbHMgPSA8MD47DQo+ICsNCj4gKwkJbXV4
LWdwaW9zID0gPCZzZ3Bpb19vdXQgMTEgMCBHUElPX0FDVElWRV9ISUdIPiwgLyogcDExYjAgKi8N
Cj4gKwkJCSAgICA8JnNncGlvX291dCAxMSAxIEdQSU9fQUNUSVZFX0hJR0g+OyAvKiBwMTFiMSAq
Lw0KPiArCX07DQo+ICsNCj4gKwlzZnAyOiBzZnAyIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJzZmYs
c2ZwIjsNCj4gKwkJaTJjLWJ1cyA9IDwmaTJjMTAyPjsNCj4gKwkJdHgtZGlzYWJsZS1ncGlvcyA9
IDwmc2dwaW9fb3V0IDEwIDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJbG9zLWdwaW9zID0gPCZz
Z3Bpb19pbiAgMiAwIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArCQltb2QtZGVmMC1ncGlvcyA9IDwm
c2dwaW9faW4gIDIgMSBHUElPX0FDVElWRV9MT1c+Ow0KPiArCQl0eC1mYXVsdC1ncGlvcyA9IDwm
c2dwaW9faW4gIDEgMCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9Ow0KPiArDQo+ICsJc2ZwMzog
c2ZwMyB7DQo+ICsJCWNvbXBhdGlibGUgPSAic2ZmLHNmcCI7DQo+ICsJCWkyYy1idXMgPSA8Jmky
YzEwMz47DQo+ICsJCXR4LWRpc2FibGUtZ3Bpb3MgPSA8JnNncGlvX291dCAxMCAxIEdQSU9fQUNU
SVZFX0xPVz47DQo+ICsJCWxvcy1ncGlvcyA9IDwmc2dwaW9faW4gIDMgMCBHUElPX0FDVElWRV9I
SUdIPjsNCj4gKwkJbW9kLWRlZjAtZ3Bpb3MgPSA8JnNncGlvX2luICAzIDEgR1BJT19BQ1RJVkVf
TE9XPjsNCj4gKwkJdHgtZmF1bHQtZ3Bpb3MgPSA8JnNncGlvX2luICAxIDEgR1BJT19BQ1RJVkVf
SElHSD47DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gKyZmbHgzIHsNCj4gKwlhdG1lbCxmbGV4Y29t
LW1vZGUgPSA8QVRNRUxfRkxFWENPTV9NT0RFX1VTQVJUPjsNCj4gKwlzdGF0dXMgPSAib2theSI7
DQo+ICsNCj4gKwl1c2FydDM6IHNlcmlhbEAyMDAgew0KPiArCQlwaW5jdHJsLTAgPSA8JmZjM19i
X3BpbnM+Ow0KPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCQlzdGF0dXMgPSAi
b2theSI7DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gKyZmbHg0IHsNCj4gKwlhdG1lbCxmbGV4Y29t
LW1vZGUgPSA8QVRNRUxfRkxFWENPTV9NT0RFX1RXST47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0K
PiArDQo+ICsJaTJjNDogaTJjQDYwMCB7DQo+ICsJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNh
bTl4NjAtaTJjIjsNCj4gKwkJcmVnID0gPDB4NjAwIDB4MjAwPjsNCj4gKwkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDUyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQljbG9ja3MgPSA8Jm5pY19j
bGs+Ow0KPiArCQlwaW5jdHJsLTAgPSA8JmZjNF9iX3BpbnM+Ow0KPiArCQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiArCQlpMmMtYW5hbG9nLWZpbHRlcjsNCj4gKwkJaTJjLWRpZ2l0YWwt
ZmlsdGVyOw0KPiArCQlpMmMtZGlnaXRhbC1maWx0ZXItd2lkdGgtbnMgPSA8MzU+Ow0KPiArCQlp
MmMtc2RhLWhvbGQtdGltZS1ucyA9IDwxNTAwPjsNCj4gKwkJc3RhdHVzID0gIm9rYXkiOw0KPiAr
CX07DQo+ICt9Ow0KPiArDQo+ICsmZ3BpbyB7DQo+ICsJZmMzX2JfcGluczogZmMzLWItcGlucyB7
DQo+ICsJCS8qIFJYRCwgVFhEICovDQo+ICsJCXBpbnMgPSAiR1BJT181MiIsICJHUElPXzUzIjsN
Cj4gKwkJZnVuY3Rpb24gPSAiZmMzX2IiOw0KPiArCX07DQo+ICsNCj4gKwlmYzRfYl9waW5zOiBm
YzQtYi1waW5zIHsNCj4gKwkJLyogU0NMLCBTREEgKi8NCj4gKwkJcGlucyA9ICJHUElPXzU3Iiwg
IkdQSU9fNTgiOw0KPiArCQlmdW5jdGlvbiA9ICJmYzRfYiI7DQo+ICsJfTsNCj4gKw0KPiArCXNn
cGlvX2FfcGluczogc2dwaW8tYS1waW5zIHsNCj4gKwkJLyogU0NLLCBEMCwgRDEsIExEICovDQo+
ICsJCXBpbnMgPSAiR1BJT18zMiIsICJHUElPXzMzIiwgIkdQSU9fMzQiLCAiR1BJT18zNSI7DQo+
ICsJCWZ1bmN0aW9uID0gInNncGlvX2EiOw0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsmbWRpbzEg
ew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZwaHkwIHsNCj4gKwlzdGF0
dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmcGh5MSB7DQo+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPiArfTsNCj4gKw0KPiArJnBvcnQwIHsNCj4gKwlwaHktaGFuZGxlID0gPCZwaHkwPjsNCj4g
KwlwaHktbW9kZSA9ICJnbWlpIjsNCj4gKwlwaHlzID0gPCZzZXJkZXMgMCBDVSgwKT47DQo+ICsJ
c3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBvcnQxIHsNCj4gKwlwaHktaGFuZGxl
ID0gPCZwaHkxPjsNCj4gKwlwaHktbW9kZSA9ICJnbWlpIjsNCj4gKwlwaHlzID0gPCZzZXJkZXMg
MSBDVSgxKT47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBvcnQyIHsN
Cj4gKwlzZnAgPSA8JnNmcDI+Ow0KPiArCW1hbmFnZWQgPSAiaW4tYmFuZC1zdGF0dXMiOw0KPiAr
CXBoeS1tb2RlID0gInNnbWlpIjsNCj4gKwlwaHlzID0gPCZzZXJkZXMgMiBTRVJERVM2RygwKT47
DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBvcnQzIHsNCj4gKwlzZnAg
PSA8JnNmcDM+Ow0KPiArCW1hbmFnZWQgPSAiaW4tYmFuZC1zdGF0dXMiOw0KPiArCXBoeS1tb2Rl
ID0gInNnbWlpIjsNCj4gKwlwaHlzID0gPCZzZXJkZXMgMyBTRVJERVM2RygxKT47DQo+ICsJc3Rh
dHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnNlcmRlcyB7DQo+ICsJc3RhdHVzID0gIm9r
YXkiOw0KPiArfTsNCj4gKw0KPiArJnNncGlvIHsNCj4gKwlwaW5jdHJsLTAgPSA8JnNncGlvX2Ff
cGlucz47DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwltaWNyb2NoaXAsc2dw
aW8tcG9ydC1yYW5nZXMgPSA8MCAzPiwgPDggMTE+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4g
Kw0KPiArCWdwaW9AMCB7DQo+ICsJCW5ncGlvcyA9IDw2ND47DQo+ICsJfTsNCj4gKwlncGlvQDEg
ew0KPiArCQluZ3Bpb3MgPSA8NjQ+Ow0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsmc3dpdGNoIHsN
Cj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KDQo=
