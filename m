Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996C58E1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiHIVUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHIVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:20:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9BF6716C;
        Tue,  9 Aug 2022 14:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660080011; x=1691616011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xs5LLABiMPknJgvmfmmvNbDrRSlykV/Vn2aHbO0dpr8=;
  b=v6Y0a0EmY76nsNbObb+y3ovC5EN648G98Z0YMDnY1035LvICheixNNXY
   lm4PpZjSVnETBFNKP3yE7VYIcfx6syhIUgtEa1esF2LNVrrj713U7sdHS
   opGtV3h1fc2teM/Day6TZSwoE+MByZ96MS5WQERLcXzSls1ahq91dWhkp
   t8QUqzxlpmOp+4GE3/FUb+jppB/S7sq7hMzvN0OZYNT+IEFvHEf75koaK
   skV0vtEzSEXQlDWhEpRyms6j5FLL3YKFhXQ8zqlhiMWv/wd2/qeyut4wL
   06NsgjvpUTw+72ZZzESomYV2fZrEFVSIAYl6Z8xYBHUt6WG3dadu4E8QU
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="168558816"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:20:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:20:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 9 Aug 2022 14:20:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9Nr/MRC8TzhGlJP8gGE2SFJxMtx9pSnafLgqtyBAq3MvV4xaLMwhAyIcynN/ekq09Pub2ioWbBIVkEffa7lM+DwrFQOVUtXdRXnP/VCJNandMZjIeCdXeksrpCZ6TVnGcGh6t6BE1FmEwIfBEZAdBuiYEIJugcCI92CEPxsrmBH3PaBxw78+rcOx5P8v3c23HqqqPEELio3PIcjwIvQykFMQDtjEyCqqw+j2+XaDbUnRtJ6VgrjWmV2JEhHGsRUNwZrIfRxK7vBEktaA0KIcjGdqc/+XwCaUp7cqw6HzAzoQvNCHz/0oIeRdgXUZnlNMiAVL5tn6oACbRnsdpotkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs5LLABiMPknJgvmfmmvNbDrRSlykV/Vn2aHbO0dpr8=;
 b=ikGLChOKA/4Yj8KgWEIaejeKj9p1TQYjc1ShXU6sYrUq06X+1wRQiUkuCGaCAIpEZc7TfCGhq4GEqqe8GhAkBdqAIq1DHjtMYUpgXGA0ckEoDsCr2IIeSY7FEmCUaMo2gpBoqD63HCkIWL/sosAXnWZWU8Dzh1nZRvfPzsebM7+jVXm22/8dSS/eu6WdI2SE0OJPiaYQxIQxTbGDDPb6AfTNOEzJ7yoWvsjWkOtlUcn5Hikbo6donPSnu2OTVqWzA3dkoJlqHdMmulDHAhF4DKjkcSbzlJtMk3Ut1np1HMlLbWoZAomTPCB/VCAZqD9PwMBSQn8NULMmhy0JKSgFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs5LLABiMPknJgvmfmmvNbDrRSlykV/Vn2aHbO0dpr8=;
 b=rjJ8Ypioj9AI/sc11pRtK5nGe63d7D//DHz3+xwa3BVW2qkEqmdx/ML90Jvk2cAOFcql2cX8rBxLX2boy+dzOiTLpQ6ADBJJg6MQHdEjDl2StwF9f3hjqP0QrvM3TgJKq+UaCon7YLOY5xv0zoBeLpGt7LErutQNmCCzBjwD61Y=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:20:02 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:20:02 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
        <mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>,
        <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <corbet@lwn.net>, <Conor.Dooley@microchip.com>
CC:     <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
        <heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
        <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
Thread-Topic: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
Thread-Index: AQHYpmob+r60mFZFRUieSoZOQlwVh62nHr2A
Date:   Tue, 9 Aug 2022 21:20:01 +0000
Message-ID: <cf03285d-62e7-c70a-4197-8519fe9effe0@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9ab9596-0666-41aa-92f9-08da7a4cebdc
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BV09anptC14g6GKo7ZcnLwaet7Oz1+AFBWKBBszFoxqhLb92/V0L1qA0LIURClKuvmANYN9V62apGjuYxiqCabYfI0jGulRNfQ2m9gd73CVjDmHrVaDK/i4Y5KWuFvxAIIAWwXDBk4tDX2GRwmdXm2/C7INojBohHlhPL6iMCN6YsIcqCYMX/ou1XJ4FPOc76X0g8SHlslYGiRIDh7r+8HsEXUgLTuevwQa5FROG+sO9BCT6MbTDB+BRRrm3rgPafmjui6nX7xDs/ne/V7XzedQL3g0wSm5GwDnDfkv12OMlGMLug4VL8fP2hEP5GCNle1yz5lgmkqvqBpOttzLwWDruTIqBdRTZphtaRe6t4luI2fVSmWDtcW0P4FIRVL0aDPlcfuNvlDHyON1Xmr6gzqr8SVz2aa1xhHdzpyNTaE/iXhtwOWTXzd+nFO2UacbM9n25e1/Sb/3GaMKXSppRdWcFmS0ZPq97MKVhAQwchhkIKR4Eu3eYH6cxAfs8l+v+tPJxAezKbzP9+Orq3okWFdD2S/4IXRI0yl4YQvAM2O1I2Wb/5rtoSceplP1DryoDmUeRE8ZZnlyoyTaNo2R1wlPJhOzOu1ABJdGs0d85Tiki77QiWn4+XZ5WusQgWxzSpt747eUKVX5zwhqSgCOs6DqPfUmeJYR1AeRCopl/uqssstWx3TfkhlTgugLntNDYIrjU0lr0qa85T6KygS5Y4cCZswJnqNbFUxYJvtuZPFU1OEmciWQsyxpk5S3vncoH1KOfea8eP5iMhkh70QEfeN1pl+DF4CbyivKfAqEKpWsAez2msUVa23FqxikodB0ToD7gOlHCLkVlieUdGO6iUEVM2Cg1YDGzCK530GbwJJvQlTdP25QHB1KzZJJoarh37dKKyTCvL+FUWas368A91QOOlju6xrf2Mf9m10sVT7Sj6W4AxGSv4rb0OeKwicqe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(83380400001)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjZZbVBiQzdMbUdTNlRsajRCb3JlckxpL052UCtkcjRRQ2lTdm1hQWVyS0xz?=
 =?utf-8?B?LzFIeWU1eXV5RGpya2xVSE9SNlpha2l4TEJRTTVLTzMxU2RGaC9vbE1iQk1I?=
 =?utf-8?B?MjV5dDQ0QVFiNkVaN1hJZng0Q2hGTDBmVldsQ0FQOHFaZllKaDJ2aWdiWllu?=
 =?utf-8?B?d1k2OFlYckdyVWtnT1BsZ2h5dDAvakxRenBTdjBzMG5hdnJRdW1zOWdWNllh?=
 =?utf-8?B?dmNlL0VIVjQvK0JaVGhHUEMwczlmY283ZGZNU0luaWNVVWErY1BuLy9yeG5R?=
 =?utf-8?B?Ti84QU1sM2JoMmhNNHZXdCtUSHRwYjdSYkkySmZMeDRHRWRKemdHUU9SZ01E?=
 =?utf-8?B?SDFZM2lGaUVyb1hEKzZTZ05oUElRRVQ4Skg1YTNZdmdKRFZDU0xBSUdSQWlV?=
 =?utf-8?B?VVd5SUcwaTJlUTBKSi8vN0hnMWFpSzZ1cEFYT01YRU5NZmNTM29MejVPbkZk?=
 =?utf-8?B?empMSXNtYTl6L0dvUkFrV1F4aVlBYmgyTEV6ZzBWa0lJMThpSlB0anJpeWh5?=
 =?utf-8?B?WGlNUllnSTdUZFNtVXhhdmtaV1BndExPS0JXemNORUUvN0NYZzkvdk5JMytt?=
 =?utf-8?B?SGZnNUtNQkJqbjdwaUpKNXlyd0ZFNlJjRnVOUFdUTnJKbmhDbmxjM0laQWFF?=
 =?utf-8?B?MkZhZTBFMFdmem54R0xSamIzWDZ6WnJsZHRIajRsYXlLcGdLTzNNemJsQ0M4?=
 =?utf-8?B?b3ZhcXJnZHQwZ2Q5b3RBRlVVZUxRSVgzL01SUkZZeCtkUnRJZjBsV2pkUEVj?=
 =?utf-8?B?V2RWd3pMVHNDbFhmS0tvSEI3OXpacGEyUzgveFpWeG9HQ3M5bTBTakNQR3hJ?=
 =?utf-8?B?L2xLSjFldHVOUkl3K0tpZmo5b1VCUnBEVDAyYkZlbllPTGFVK2tOc1E0aHVh?=
 =?utf-8?B?NlowbGlwdDlxZDByOUo1Z2dDQ1RmRFdaRXp4VFBlc2toQUtCS2pYc0hVaDlR?=
 =?utf-8?B?YVgwRVZGN3FHNDdOTmZnZGFudkh6T2tsaG9CR3oxTkNIL0laSTBLRmtmSlhZ?=
 =?utf-8?B?RTdhdnMzUkhld0ZHMFpIR1hPQlN2Z3dTZG9YSDZVdGdmaC9CSDlTYTJMcWh3?=
 =?utf-8?B?dUdWSHNlZm1EbXYvZW5yTWo4UFl5VmpJY0VPYjBwSE82ay9zQytjV3N1VU9w?=
 =?utf-8?B?SWRNSUtUMXk3anRXYmxOanRBRXNaSEZ0NmIwMHMybitXb1BIR1dLOVE0K3Nn?=
 =?utf-8?B?OTFiUW1ERnAvS29aMTRxejlmNXMyOHNUVHBUYSt1NHU1RG1JQVBaY1lIZ3o5?=
 =?utf-8?B?NDFpbmRsMk96RldyZGozL3JCZFc2d1prU0lPQ2NyMXdGc0JwdGh2MWJVVDR3?=
 =?utf-8?B?eUdJa3RqMy9rRUVpUlRqUFdxbnNTbEdUTFFKclJia1I1dkpDanZOd29pRGhl?=
 =?utf-8?B?Y0Q4UmNDMkRyZFA3UUZsb0xrelQyTk5vaXdhaU05ME9OU2lZNCtWcmNMWU50?=
 =?utf-8?B?UmZsZytJT0pkR0pPR3RGSnlMQ05uKzNaMDIzdXk4WFg4akk3b1c4c1ZjYTRZ?=
 =?utf-8?B?cEhsMUExaUNnNW4zNEx3TGRFalUyK1k2azludW9ydmpPa2ljSXh3WjdmaHhK?=
 =?utf-8?B?VkRLeENCTFdta3VHTjFiQmQ0THhRWXc1a3Y0Qk11MU9GWXZSaDZPSk8xN0Rp?=
 =?utf-8?B?R2QwRERraEZBcjZlR1M3SDdoQnRRbi9VT0w2NEdXeHl5K1gzUjhXSTRDYWtl?=
 =?utf-8?B?MUxaNnZWM3I1czZkYkxJMytMck1PR0hBVkxneDdGeGRoSDFtNkNYdVJJR0VW?=
 =?utf-8?B?YlpyU3plYlVxUEJTVkNGV2xZakloVWl3ZlBKdUlldlpKckhYTFRxTUtBZGFD?=
 =?utf-8?B?dUQ1VkJsYkh0QXNHUnh4VUluOU54QmRnQ0U2eHl4aWtYOXp2dTZGcWdMVWJE?=
 =?utf-8?B?b0E3N05SSXR5VHhSdkYrMExyeDU1OGMvYUUxcVplMzQrNVNZTm9qemkyQk5Z?=
 =?utf-8?B?L3UwTWJMcWY1bXh5OXZzQnp6bSt4MEhROGM2MWF5Q0lrVW5DOG5jYUtkdlVX?=
 =?utf-8?B?UU80RU15bGg1ZnloQ0g5L0lVcWR0MXlSLzV2TGtmb2xZRkp5WlltSkZyWXNL?=
 =?utf-8?B?TXV0QWpxcm9JSTEyOVdWZ2pxRW43TjJaZExvL2wvMTM4M1pZb0Q1QnhXU3Ry?=
 =?utf-8?Q?JMdtztwi6PtKbq4eSDjzIw46Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCA8CB052876BC43B814F9F96900E86E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ab9596-0666-41aa-92f9-08da7a4cebdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:20:01.9238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JV4Q2pTJIHE3hAskksix8JiVpo1dljutXHDmpWjW/uqbspChtDvH3SNS1ZfLjM8oUzgNWsnO5jPo6+7/mwAbnukafzOPP5Prx4lgd9afLYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDgvMjAyMiAxMzoxOCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gcmlzY3Y6IGNyYXNo
X2NvcmU6IEV4cG9ydCBrZXJuZWwgdm0gbGF5b3V0LCBwaHlzX3JhbV9iYXNlDQoNCkNhbiB5b3Ug
cGxlYXNlIGp1c3QgdXNlIFJJU0MtVjogZm9yIHRoZSB3aG9sZSBzZXJpZXMsIG15IE9DRA0KaGF0
ZXMgdGhlIG1peCBoYWhhLg0KDQo+IFRoZXNlIGluZm9zIGFyZSBuZWVkZWQgYnkgdGhlIGtkdW1w
IGNyYXNoIHRvb2wuIFNpbmNlIHRoZXNlIHZhbHVlcyBjaGFuZ2UNCj4gZnJvbSB0aW1lIHRvIHRp
bWUsIGl0IGlzIHByZWZlcmFibGUgdG8gZXhwb3J0IHRoZW0gdmlhIHZtY29yZWluZm8gdGhhbiB0
bw0KPiBjaGFuZ2UgdGhlIGNyYXNoJ3MgY29kZSBmcmVxdWVudGx5Lg0KDQpUaGlzIGNvbW1pdCBk
ZXNjcmlwdGlvbiBkb2Vzbid0IHNlZW0gdG8gbWF0Y2ggdGhlIHBhdGNoZXMgYXQgYWxsLg0KSSBk
b24ndCBzZWUgYW55IGV4cG9ydGluZyBoYXBwZW5pbmcgaGVyZSBhdCBhbGwgLSB0aGlzIGlzIGRv
Y3VtZW50aW5nDQp0aGUgZXhwb3J0LiBNYXliZSBJIGFtIGp1c3QgbWlzdW5kZXJzdGFuZGluZywg
YnV0IHRoaXMgY29tbWl0IG1lc3NhZ2UNCmp1c3QgZG9lc24ndCBzZWVtIHRvIG1hdGNoIHRoZSBj
aGFuZ2UuIFNlY29uZGx5LCBzaG91bGQgdGhlIHN1YmplY3Qgbm90DQpiZSBzb21ldGhpbmcgbGlr
ZSAiZG9jczogYWRtaW4tZ3VpZGU6IGFkZCByaXNjdiBjcmFzaCBrZXJuZWwgeWFkYSB5YWRhIj8N
Ck1heWJlIHRoZSBjdXJyZW50IHN1YmplY3QgbGltZSB0aGF0IGV4cGxhaW5zIHRoZSBsYWNrIG9m
IGEgcmV2aWV3IGZyb20NCnRoZSBkb2NzIG1haW50YWluZXI/DQoNClRoYW5rcywNCkNvbm9yLg0K
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4
LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gIC4uLi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZv
LnJzdCAgICAgICAgICB8IDMxICsrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUv
a2R1bXAvdm1jb3JlaW5mby5yc3QNCj4gaW5kZXggODQxOTAxOWI2YTg4Li42Yjc2Mjg0YTUwM2Mg
MTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5m
by5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZv
LnJzdA0KPiBAQCAtNTk1LDMgKzU5NSwzNCBAQCBYMlRMQg0KPiAgLS0tLS0NCj4gIA0KPiAgSW5k
aWNhdGVzIHdoZXRoZXIgdGhlIGNyYXNoZWQga2VybmVsIGVuYWJsZWQgU0ggZXh0ZW5kZWQgbW9k
ZS4NCj4gKw0KPiArUklTQ1Y2NA0KPiArPT09PT09PQ0KPiArDQo+ICtWQV9CSVRTDQo+ICstLS0t
LS0tDQo+ICsNCj4gK1RoZSBtYXhpbXVtIG51bWJlciBvZiBiaXRzIGZvciB2aXJ0dWFsIGFkZHJl
c3Nlcy4gVXNlZCB0byBjb21wdXRlIHRoZQ0KPiArdmlydHVhbCBtZW1vcnkgcmFuZ2VzLg0KPiAr
DQo+ICtQQUdFX09GRlNFVA0KPiArLS0tLS0tLS0tLS0NCj4gKw0KPiArSW5kaWNhdGVzIHRoZSB2
aXJ0dWFsIGtlcm5lbCBzdGFydCBhZGRyZXNzIG9mIGRpcmVjdC1tYXBwZWQgUkFNIHJlZ2lvbi4N
Cj4gKw0KPiArcGh5c19yYW1fYmFzZQ0KPiArLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICtJbmRpY2F0
ZXMgdGhlIHN0YXJ0IHBoeXNpY2FsIFJBTSBhZGRyZXNzLg0KPiArDQo+ICtNT0RVTEVTX1ZBRERS
fE1PRFVMRVNfRU5EfFZNQUxMT0NfU1RBUlR8Vk1BTExPQ19FTkR8Vk1FTU1BUF9TVEFSVHxWTUVN
TUFQX0VORA0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gK0tBU0FOX1NIQURPV19TVEFSVHxL
QVNBTl9TSEFET1dfRU5EfEtFUk5FTF9MSU5LX0FERFJ8QUREUkVTU19TUEFDRV9FTkQNCj4gKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gKw0KPiArVXNlZCB0byBnZXQgdGhlIGNvcnJlY3QgcmFuZ2VzOg0KPiAr
CU1PRFVMRVNfVkFERFIgfiBNT0RVTEVTX0VORCA6IEtlcm5lbCBtb2R1bGUgc3BhY2UuDQo+ICsJ
Vk1BTExPQ19TVEFSVCB+IFZNQUxMT0NfRU5EIDogdm1hbGxvYygpIC8gaW9yZW1hcCgpIHNwYWNl
Lg0KPiArCVZNRU1NQVBfU1RBUlQgfiBWTUVNTUFQX0VORCA6IHZtZW1tYXAgcmVnaW9uLCB1c2Vk
IGZvciBzdHJ1Y3QgcGFnZSBhcnJheS4NCj4gKwlLQVNBTl9TSEFET1dfU1RBUlQgfiBLQVNBTl9T
SEFET1dfRU5EIDoga2FzYW4gc2hhZG93IHNwYWNlLg0KPiArCUtFUk5FTF9MSU5LX0FERFIgfiBB
RERSRVNTX1NQQUNFX0VORCA6IEtlcm5lbCBsaW5rIGFuZCBCUEYgc3BhY2UuDQo=
