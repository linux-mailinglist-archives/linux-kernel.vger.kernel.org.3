Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0485A77E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiHaHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiHaHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:44:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A1BD2B3;
        Wed, 31 Aug 2022 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661931826; x=1693467826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=chqUd0W1kBlvF4lDsH4zv833gSBFSI1irNB3VKvLxCc=;
  b=vXjwsQGrEb8ribyjCyH1u3jeml8GX88LH1dgds7SdKk8Z6wENsHRJcv5
   PyJ8BjUjQm+xMLvvgkF/rJVcjaMX47M2s/tza92deLhPqoKgdPlqBA3Cu
   HMd8aH9jiPfMAkcsByCm6EbCdp/iq2UWQ9+IWO0Jgq7x0/boDVt6kracj
   kNJy+OEmWGUAqKbJq9xoAyFfsxfnmsjnTkP8C50qdtVWdTwVBE0FGLJ+9
   IcpNxm6JxlxMWe3WrKXLgtwJjfPgAdaxMImKnFDoSsLHncxAlziqdkq6d
   lFi4RAYpOp6FoejHPT9tFteN9+onwrBsBg1qLCOQGrACuFvkgHdwyh3hd
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="178573098"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 00:43:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 00:43:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 00:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sjrnhc8UR+gnriZpz72yt3BN7FfHwpKY5wsqeXTvvx+cM0PjSlVMu5TVhzG7sbLyUSrUK/U0G0sUsSMtVvuUN24L3YaZxjS9s1DnxdBOG6PMmOW3qoNy0Zvr7AH9FxjnNT5d4v2FLSh/qn2e9tescJG/5Brfk8bJ05ICBG3+BpGulP81i8jftswifu7OuDNuZ++ddXkeTLu9UY8lcxxLicku+Ep7VwPLMvIBpif2sUt8JvUUEN+Qx9zOuzfEofUI0u/BwIxkIYIMYFA2ohl7KaVxCizILcnezhd/5cabi5t9ugl2zaWOoJjowHBVoeyk6hPwDIwdCvTASyNeQawWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chqUd0W1kBlvF4lDsH4zv833gSBFSI1irNB3VKvLxCc=;
 b=Y3pbVSPJvzrm58Cysg8YsTAd1qkzyKb1kMLMrNOt7heeVc12G1ajulfVWsBSTE7FjQr/grEerFqWAqn/IQL7dn/CxAYtjbi5QQe/8NQm9zcKZlGzOxXP+uy40+QTwLA68L69EFwWcI9tJsppfWeGTcbB+mbPMU59ZrvNuWFB4SrvZmsuen9uGUqxvPz5KG4a8pBScNNsFH6qLrU6281AayFLaHAToK6DlFrf4tEcnqPOkxMzdECzwQA0kN2fbLjlLu9VstfX8FtmOm6IFXdYM8MeN2t/7+GfUZ1hde9f2xcY/y9Q6jstLc72VJCF0imFpHGA7d/Tj9AlNGj0miaMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chqUd0W1kBlvF4lDsH4zv833gSBFSI1irNB3VKvLxCc=;
 b=n/cmTaPi2xcGoxQapQp9Mo0aL84m6rBbIz8nnkFnOQDzm66gA1Gd5qzWHvF+WU7FIFs3XZSKfRCmKlZBnLyjJDvi31rZPiuTFYGz1lPaJKa2WKh6fAZ1m7Rqdswy0vixu/V+ZHOZCEroWb9yIU9CzdCHQQWzNRGUEIN3gdwGzJA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:43:44 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%10]) with mapi id 15.20.5566.021; Wed, 31 Aug
 2022 07:43:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v4] ARM: dts: lan966x: add support for pcb8290
Thread-Topic: [PATCH v4] ARM: dts: lan966x: add support for pcb8290
Thread-Index: AQHYvQ1lPYZUnh19fkeBQgC3hhwrZA==
Date:   Wed, 31 Aug 2022 07:43:43 +0000
Message-ID: <efba702f-cc2b-c1d2-2d77-e9945d7de23d@microchip.com>
References: <20220825065135.1075049-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220825065135.1075049-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c43e07d9-e827-48f3-16ce-08da8b2487bd
x-ms-traffictypediagnostic: DM4PR11MB6189:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNqhE5bj3I0PBHg/JXcdxyqtxRCTWpvWWB4tnMWB9NOomJ1lW3q4bQ70Wlfpw5o7SZYC7Y5ctiqXvBPJbFlhdsz6JMEGEczr4XWI0bAhidqbr9XKuwiasLv3/Ci1XdlZ4m++OTm+E50WLjErA9Q7q8Wzu/yMt118PJxWBKj3WN+MjyYeH3L2hN1abRvrHiB4fBMHfx0dicCPKL1TyEOoVvfj/NBV57Y2FRAI7P+hEyQ0qDE0xFufTsjV0tAqHMeiTnyHmasPOb5CnVgcoOEUFaiOmL3YEUlmrwGqDGxGzxSaZ9cZii/MKg+J17ui/RNFu6EuUAU4LRMXsmZCJqQWvaHJ3rTuK/+s4PLlNW0nzqhx7+b9o4ecg+JnTAe9K/FXhwzeXfIuL1ID0HnlR1TkcaxrRtj/buyIqkmznaCJ9gmouTe10VoUK7EJHEGdvFSxYlAa6cPqQpy1dW7f9tIIV5//qE5NkTj7fB4vkGC0MPMI7Ra5nnAuY9Yc6lSdQlNAkVBsx2RrxfmviaaEnNOPr+pZu1oSNTiMWS1VS6rxCIL1oJG8988SC6RMW+8R1HawVURDsWz62CXhG+eQHOUtZpxgzqus7ZvbyIM9EYVRQ2Aw85Iux7KLgug483ZavQtDegmyjFONa4NcqzO07oyTQcHaskcuHyyRQqs0C2ZyqeVjyF8ybTqvLtjbB2queu7JzI7oQtPxlbgIPwWlxVv4XE0x7OynhlVxQFyDAsvxCZJO4Lz5GAEz1t/Wfz81LutIH3njZG0K8toN0tqz7BDxtwzqCPoEwfvW5jsbnD9sEUqsCwv67GPLdMl8xfZRHlK4Otzi4fRZEDkT/8TG0RnDLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(396003)(366004)(376002)(26005)(2906002)(6512007)(53546011)(6506007)(83380400001)(66946007)(186003)(66556008)(2616005)(31686004)(91956017)(66476007)(76116006)(4326008)(64756008)(478600001)(66446008)(38070700005)(110136005)(8676002)(6486002)(316002)(71200400001)(54906003)(38100700002)(41300700001)(36756003)(8936002)(122000001)(31696002)(5660300002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2NLWXJ5a3BmN1pYSXdqc1hwRk94TVRveDF1THBqT3BqVkhBdERRY2g0ZEhv?=
 =?utf-8?B?R3pNaVJqQlExU1FsYnV4MWVqVExydzFwVTFHblZHR0puTGxBTHo3U2czNlhO?=
 =?utf-8?B?NGcxbTN0Z212amd0bEk5Rm1GNEJTbHNmT1JaSGcrM2Y5TjlRRFh4MzYvR1pP?=
 =?utf-8?B?UGxmanBoY0tPWGpiTGg1YWZUMzhWK2tjVDRvVGhuV3VFamZKNXFnaTNMZ3o0?=
 =?utf-8?B?cnB3WFVla09tUFRRMnBzWmkzajFQQUNlRWowR0tUUnc5QkNXeFYwQXBuNVRG?=
 =?utf-8?B?eE1tMjVmQ2lUSjA2NURlWW1BblFoQXZXUTdGVlU4cGZWcnBTc096Y2hWem8z?=
 =?utf-8?B?N0Q2OEhjOERXcDhmRldQZy9JSXptWFZFZXlIZWJWbWZ6Zm5vNEcra1BXVHd1?=
 =?utf-8?B?YXliMHl3ZVRMMmF2TUpuVlBPa29BaGtkRThmQWlGdEI1clRleUJ4MlI4QWJD?=
 =?utf-8?B?OE9OZEhJZGZBUjQ5YitRSHpEZUVNRHpwaCtERXA0NjRLTXN4TzJ3K3EwLzUx?=
 =?utf-8?B?TEVyYXJCc3IzZ0plVEI0b2dSVTJkVXpGazIxdHRWY093c0J2WEpTdUdlSGpS?=
 =?utf-8?B?UXBBTlZ2SzRxS2xXbGErdDNVUmN5U2w1NlovOWlBZklBcEUwRXdvMkc2YkpB?=
 =?utf-8?B?Z1lObUNvTC95MDZheUZhSkVXOTM0a0VQdGRxNmM0ZFU2OFpsZDk3SCtUbzBT?=
 =?utf-8?B?VHVndVFlemxGUmJnTS9LZUlZbkVwTzlWbjlLcktqT1FBSUNLMDl5N2JZUTBF?=
 =?utf-8?B?cm1tVmtpaEhmU29icHRSNk9BLytscExDM1VqUXdMZlM2UVM1SEZkc09Bc1dY?=
 =?utf-8?B?MWxZZGM4Y2ZhQllmM2FLQWg0Yk9oYWUvYVNZRitxdmFFQzBQYjFGZllBeG5q?=
 =?utf-8?B?Y0tWakJ5Q2JOY2xScTA0dmx0UVJRVXBaZXF3YmtSN3lSQmdHUGp5Q0dXemRX?=
 =?utf-8?B?UVUwL1JPK3ZtaEQ0bG9sOG54c2xVdWxVbXNvZ2dBNkY4YVdyc2tSbytaVWRl?=
 =?utf-8?B?WGlkUGlhSGV4VDkva0VtZTNiRFpIZTdUM0dzNm9sSGlaRkZTa3FZT1hOZFFU?=
 =?utf-8?B?ai9lZ3hBcnV3N3Yrb25CNDdxT3cxVFRKenIyL2IxcjZJelVYR0p1eDhETENr?=
 =?utf-8?B?a3JIdC9FZlk0Q08vRmZkcVpNSjlUSUxzZVYwNmV1RzJDZWtMWFZaRTFzMS9B?=
 =?utf-8?B?bmt5aGJjNXFhQnpJb0EwNXZVd1R0aU5PSEVLWC9GRWo5SXczU2g3RGRsK3Fm?=
 =?utf-8?B?bitRRVFpTjZsdkxZM1JJcm5nMldYWS9yU09FUzNpVmlBdGpsb2F2K0V5RVB6?=
 =?utf-8?B?c2pMODNWd0ltamRZRitMN1VZTlBaeXR4SE16VkVkSWFNdGFQQkFkdHVVOXpC?=
 =?utf-8?B?cWo3OFIxNEt5bENDa1UvdUtUckVZaWtua0lnT1ZONWRsYmd4RWwwamI1Z0tl?=
 =?utf-8?B?aFZMc0JjOFl4SElrT09HOVFqR09hS0JpU1Uzcjduc29RTmI3ZDFzRE54Mlh5?=
 =?utf-8?B?WlNLZmlMNjJiSGxrTlB4bGhCWnd5ZVQ0ZUpDc0FrUHVHL2x3SDZOamFrU1ZU?=
 =?utf-8?B?SzJOZExnN2V5NGFaeHg0OU0wYXN6NGZKaE9USEV2V3B4ZzlQYVRBei9Cb0pM?=
 =?utf-8?B?c0NZZGVUSkJ5VTYzMGloVW9RajcwVWVtZ1FHcWI4QTN2UE9Mem40WkZvRW9k?=
 =?utf-8?B?QmdjYXRTSFhzdVpNTFpTYU9oSDFlbzNPT25vUENvd2I1cTM4c0pnNUFCZkhX?=
 =?utf-8?B?Z25KUit3dUh4WjYrSDJlUEJ2Q21lb1JyZEpVTkErMmJsVG5SaHE1TGVhUzNL?=
 =?utf-8?B?d3BKTEhmZ2FnQ0Z6SVMwU09zRlpPNERHN3Y4dlNJMWJlRjVlOHBPOC9HUFlH?=
 =?utf-8?B?cW96ZThXdk5jSUFvTzJhYTV1akt5SkJ0di93azFYcis4MjdEalo0b21SR1Fn?=
 =?utf-8?B?UVZ6b3g2dXBlYlM0SHlCY20zSVBkNjdHSG1zN29XbTU2Wnk2bkVZaWJkWHFr?=
 =?utf-8?B?N0N0d0ladkpTS0VFZzhFQUlqckxnakJ1bVBTYUJPaW1LcDBTdlh6QW95Njl5?=
 =?utf-8?B?ZkF3NXVhb2hCcEtWcFA4U0NUMFFvcWNHd2dZVG43V1pRT1RjSVV2cTZ2cnVS?=
 =?utf-8?B?UkVVRHI0OWd2c05ObTdvTVg3MTFGZS9ybWFZYUJHTkhkYmprcW02RktiYkkr?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79DA161E1F9E9D4C850692B6C71242AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43e07d9-e827-48f3-16ce-08da8b2487bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 07:43:43.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBK+tv5v5YaQmEVuWn+diPSiufQKk8emppDIjI29xxcu4rs1kLClxS/Vz/1xHCNaM5Yh3qEAZDQd/VQ6eEg42szP0bAH4Cg5HCZ1OlRpqnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMDguMjAyMiAwOTo1MSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBiYXNpYyBz
dXBwb3J0IGZvciBwY2I4MjkwLiBJdCBoYXMgMiBsYW44ODE0IHBoeXMoZWFjaCBwaHkgaXMgYQ0K
PiBxdWFkLXBvcnQpIG9uIHRoZSBleHRlcm5hbCBNRElPIGJ1cyBhbmQgbm8gU0ZQIHBvcnRzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1pY3Jv
Y2hpcC5jb20+DQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiB2My0+
djQ6DQo+IC0gYWRkIG1pc3NpbmcgQ29weXJpZ2h0IHRvIGR0cyBmaWxlDQo+IA0KPiB2Mi0+djM6
DQo+IC0gdXBkYXRlIGNvbWEtbW9kZS1ncGlvcywgc2V0IHRoZW0gdG8gT1BFTl9EUkFJTg0KPiAN
Cj4gdjEtPnYyOg0KPiAtIGFkZCBjb21tZW50cyBmb3IgcHBzX291dF9waW5zIGFuZCBwdHBfZXh0
X3BpbnMgcGlucw0KPiAtIGZpeCBjb21taXQgbWVzc2FnZS4NCj4gLS0tDQo+ICBhcmNoL2FybS9i
b290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgIHwgICAxICsNCj4gIGFyY2gvYXJtL2Jvb3QvZHRz
L2xhbjk2NngtcGNiODI5MC5kdHMgfCAxNzUgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMTc2IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTAuZHRzDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmls
ZQ0KPiBpbmRleCAwNWQ4YWVmNmU1ZDIuLjU5NWU4NzA3NTBjZCAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZp
bGUNCj4gQEAgLTc4OCw2ICs3ODgsNyBAQCBkdGItJChDT05GSUdfU09DX0lNWFJUKSArPSBcDQo+
ICBkdGItJChDT05GSUdfU09DX0xBTjk2NikgKz0gXA0KPiAgCWxhbjk2Nngta29udHJvbi1rc3dp
dGNoLWQxMC1tbXQtNmctMmdzLmR0YiBcDQo+ICAJbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEw
LW1tdC04Zy5kdGIgXA0KPiArCWxhbjk2NngtcGNiODI5MC5kdGIgXA0KPiAgCWxhbjk2NngtcGNi
ODI5MS5kdGIgXA0KPiAgCWxhbjk2NngtcGNiODMwOS5kdGINCj4gIGR0Yi0kKENPTkZJR19TT0Nf
TFMxMDIxQSkgKz0gXA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1w
Y2I4MjkwLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MC5kdHMNCj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yZTA5MTE4MGE2NGMNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTAu
ZHRzDQo+IEBAIC0wLDAgKzEsMTc1IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjArIE9SIE1JVCkNCj4gKy8qDQo+ICsgKiBsYW45NjZ4LXBjYjgyOTAuZHRzIC0gRGV2
aWNlIFRyZWUgZmlsZSBmb3IgTEFOOTY2WC1QQ0I4MjkwIGJvYXJkDQo+ICsgKg0KPiArICogQ29w
eXJpZ2h0IChDKSAyMDIyIE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYy4gYW5kIGl0cyBzdWJzaWRp
YXJpZXMNCj4gKyAqDQo+ICsgKiBBdXRob3I6IEhvcmF0aXUgVnVsdHVyIDxob3JhdGl1LnZ1bHR1
ckBtaWNyb2NoaXAuY29tPg0KPiArICovDQo+ICsvZHRzLXYxLzsNCj4gKyNpbmNsdWRlICJsYW45
NjZ4LmR0c2kiDQo+ICsjaW5jbHVkZSAiZHQtYmluZGluZ3MvcGh5L3BoeS1sYW45NjZ4LXNlcmRl
cy5oIg0KPiArDQo+ICsvIHsNCj4gKwltb2RlbCA9ICJNaWNyb2NoaXAgRVZCIExBTjk2NjgiOw0K
PiArCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjk2NjgtcGNiODI5MCIsICJtaWNyb2NoaXAs
bGFuOTY2OCIsICJtaWNyb2NoaXAsbGFuOTY2IjsNCj4gKw0KPiArCWdwaW8tcmVzdGFydCB7DQo+
ICsJCWNvbXBhdGlibGUgPSAiZ3Bpby1yZXN0YXJ0IjsNCj4gKwkJZ3Bpb3MgPSA8JmdwaW8gNTYg
R1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJcHJpb3JpdHkgPSA8MjAwPjsNCj4gKwl9Ow0KPiArfTsN
Cj4gKw0KPiArJmdwaW8gew0KPiArCW1paW1fYV9waW5zOiBtZGlvLXBpbnMgew0KPiArCQkvKiBN
REMsIE1ESU8gKi8NCj4gKwkJcGlucyA9ICAiR1BJT18yOCIsICJHUElPXzI5IjsNCj4gKwkJZnVu
Y3Rpb24gPSAibWlpbV9hIjsNCj4gKwl9Ow0KPiArDQo+ICsJcHBzX291dF9waW5zOiBwcHMtb3V0
LXBpbnMgew0KPiArCQkvKiAxcHBzIG91dHB1dCAqLw0KPiArCQlwaW5zID0gIkdQSU9fMzgiOw0K
PiArCQlmdW5jdGlvbiA9ICJwdHBzeW5jXzMiOw0KPiArCX07DQo+ICsNCj4gKwlwdHBfZXh0X3Bp
bnM6IHB0cC1leHQtcGlucyB7DQo+ICsJCS8qIDFwcHMgaW5wdXQgKi8NCj4gKwkJcGlucyA9ICJH
UElPXzM1IjsNCj4gKwkJZnVuY3Rpb24gPSAicHRwc3luY18wIjsNCj4gKwl9Ow0KPiArDQo+ICsJ
dWRjX3BpbnM6IHVjZC1waW5zIHsNCj4gKwkJLyogVkJVU19ERVQgQiAqLw0KPiArCQlwaW5zID0g
IkdQSU9fOCI7DQo+ICsJCWZ1bmN0aW9uID0gInVzYl9zbGF2ZV9iIjsNCj4gKwl9Ow0KPiArfTsN
Cj4gKw0KPiArJm1kaW8wIHsNCj4gKwlwaW5jdHJsLTAgPSA8Jm1paW1fYV9waW5zPjsNCj4gKwlw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gKw0KPiAr
CWV4dF9waHkwOiBldGhlcm5ldC1waHlANyB7DQo+ICsJCXJlZyA9IDw3PjsNCj4gKwkJY29tYS1t
b2RlLWdwaW9zID0gPCZncGlvIDYwIEdQSU9fT1BFTl9EUkFJTj47DQo+ICsJfTsNCj4gKw0KPiAr
CWV4dF9waHkxOiBldGhlcm5ldC1waHlAOCB7DQo+ICsJCXJlZyA9IDw4PjsNCj4gKwkJY29tYS1t
b2RlLWdwaW9zID0gPCZncGlvIDYwIEdQSU9fT1BFTl9EUkFJTj47DQo+ICsJfTsNCj4gKw0KPiAr
CWV4dF9waHkyOiBldGhlcm5ldC1waHlAOSB7DQo+ICsJCXJlZyA9IDw5PjsNCj4gKwkJY29tYS1t
b2RlLWdwaW9zID0gPCZncGlvIDYwIEdQSU9fT1BFTl9EUkFJTj47DQo+ICsJfTsNCj4gKw0KPiAr
CWV4dF9waHkzOiBldGhlcm5ldC1waHlAMTAgew0KPiArCQlyZWcgPSA8MTA+Ow0KPiArCQljb21h
LW1vZGUtZ3Bpb3MgPSA8JmdwaW8gNjAgR1BJT19PUEVOX0RSQUlOPjsNCj4gKwl9Ow0KPiArDQo+
ICsJZXh0X3BoeTQ6IGV0aGVybmV0LXBoeUAxNSB7DQo+ICsJCXJlZyA9IDwxNT47DQo+ICsJCWNv
bWEtbW9kZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX09QRU5fRFJBSU4+Ow0KPiArCX07DQo+ICsN
Cj4gKwlleHRfcGh5NTogZXRoZXJuZXQtcGh5QDE2IHsNCj4gKwkJcmVnID0gPDE2PjsNCj4gKwkJ
Y29tYS1tb2RlLWdwaW9zID0gPCZncGlvIDYwIEdQSU9fT1BFTl9EUkFJTj47DQo+ICsJfTsNCj4g
Kw0KPiArCWV4dF9waHk2OiBldGhlcm5ldC1waHlAMTcgew0KPiArCQlyZWcgPSA8MTc+Ow0KPiAr
CQljb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8gNjAgR1BJT19PUEVOX0RSQUlOPjsNCj4gKwl9Ow0K
PiArDQo+ICsJZXh0X3BoeTc6IGV0aGVybmV0LXBoeUAxOCB7DQo+ICsJCXJlZyA9IDwxOD47DQo+
ICsJCWNvbWEtbW9kZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX09QRU5fRFJBSU4+Ow0KPiArCX07
DQo+ICt9Ow0KPiArDQo+ICsmcG9ydDAgew0KPiArCXJlZyA9IDwyPjsNCj4gKwlwaHktaGFuZGxl
ID0gPCZleHRfcGh5Mj47DQo+ICsJcGh5LW1vZGUgPSAicXNnbWlpIjsNCj4gKwlwaHlzID0gPCZz
ZXJkZXMgMCBTRVJERVM2RygxKT47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0K
PiArJnBvcnQxIHsNCj4gKwlyZWcgPSA8Mz47DQo+ICsJcGh5LWhhbmRsZSA9IDwmZXh0X3BoeTM+
Ow0KPiArCXBoeS1tb2RlID0gInFzZ21paSI7DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDEgU0VSREVT
NkcoMSk+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZwb3J0MiB7DQo+
ICsJcmVnID0gPDA+Ow0KPiArCXBoeS1oYW5kbGUgPSA8JmV4dF9waHkwPjsNCj4gKwlwaHktbW9k
ZSA9ICJxc2dtaWkiOw0KPiArCXBoeXMgPSA8JnNlcmRlcyAyIFNFUkRFUzZHKDEpPjsNCj4gKwlz
dGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmcG9ydDMgew0KPiArCXJlZyA9IDwxPjsN
Cj4gKwlwaHktaGFuZGxlID0gPCZleHRfcGh5MT47DQo+ICsJcGh5LW1vZGUgPSAicXNnbWlpIjsN
Cj4gKwlwaHlzID0gPCZzZXJkZXMgMyBTRVJERVM2RygxKT47DQo+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPiArfTsNCj4gKw0KPiArJnBvcnQ0IHsNCj4gKwlyZWcgPSA8Nj47DQo+ICsJcGh5LWhhbmRs
ZSA9IDwmZXh0X3BoeTY+Ow0KPiArCXBoeS1tb2RlID0gInFzZ21paSI7DQo+ICsJcGh5cyA9IDwm
c2VyZGVzIDQgU0VSREVTNkcoMik+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsN
Cj4gKyZwb3J0NSB7DQo+ICsJcmVnID0gPDc+Ow0KPiArCXBoeS1oYW5kbGUgPSA8JmV4dF9waHk3
PjsNCj4gKwlwaHktbW9kZSA9ICJxc2dtaWkiOw0KPiArCXBoeXMgPSA8JnNlcmRlcyA1IFNFUkRF
UzZHKDIpPjsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmcG9ydDYgew0K
PiArCXJlZyA9IDw0PjsNCj4gKwlwaHktaGFuZGxlID0gPCZleHRfcGh5ND47DQo+ICsJcGh5LW1v
ZGUgPSAicXNnbWlpIjsNCj4gKwlwaHlzID0gPCZzZXJkZXMgNiBTRVJERVM2RygyKT47DQo+ICsJ
c3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBvcnQ3IHsNCj4gKwlyZWcgPSA8NT47
DQo+ICsJcGh5LWhhbmRsZSA9IDwmZXh0X3BoeTU+Ow0KPiArCXBoeS1tb2RlID0gInFzZ21paSI7
DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDcgU0VSREVTNkcoMik+Ow0KPiArCXN0YXR1cyA9ICJva2F5
IjsNCj4gK307DQo+ICsNCj4gKyZzZXJkZXMgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307
DQo+ICsNCj4gKyZzd2l0Y2ggew0KPiArCXBpbmN0cmwtMCA9IDwmcHBzX291dF9waW5zPiwgPCZw
dHBfZXh0X3BpbnM+Ow0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJc3RhdHVz
ID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnVkYyB7DQo+ICsJcGluY3RybC0wID0gPCZ1ZGNf
cGlucz47DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlhdG1lbCx2YnVzLWdw
aW8gPSA8JmdwaW8gOCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+
ICt9Ow0KDQo=
