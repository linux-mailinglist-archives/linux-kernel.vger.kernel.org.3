Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B576590C67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiHLHVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLHVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:21:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64DE81B25
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660288906; x=1691824906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S5MbwxrmCIkNHSkeCgtZDMKmf5CSJGPbu367LP4e13s=;
  b=zjDBld2aQUPNiuy4yIj+YrSNQiI0E1BunVDa0Op1QeRf/yFn+sRLJDky
   dP71rWR/gDmHYrAju+QEiBQ52rojTPa+N8IFDO1SkY3tm1FoC93oJRSNI
   FciEyXYTGOD9JuUW5Zx1A25ktYBWAfgckv1kQ9Ym7GAXps/6694oxBQWu
   wql0lMJ3nInTNFbyay8/kMm2a1Dd3jAyEQaEJVsNfEzjBkVSEScTilNF/
   C+2uh9RpS44zjdvmfBwghkgLjt2vW+wpDrapt16q1xtpIdrfLHCJDEnAi
   pyECj6dYDZ0VgYpbYRCMsbDyXdidP5waBnfYWI3u99TvbRDN1Y0MFjWD0
   g==;
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="168986806"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 00:21:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 00:21:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 00:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyLH/exBOrqIJvZA/A4PwUt5ts3Ml8xBdUIV0JGB0q+iEmZAy1Tf2DEtU26Ez5vy3CaJWwNoT3VeinvOY1HdW2jF6Al0jLw0/o6CJiCCc0bHc8+izA4U3X7uttaduP4Aek05QrFY0T1RHA7YMZ5HqMvGXjOIFee0lcbXFIaIldIhbGs+dRHnLhxQZVIHLF5cxSzK6lLtRxYjLsTHJBVW5YzqTmjVu2Gyq3DtrcGJzRN1PCzIO51C7TlOS4ALmZ7ywUp0VlNgusM3AHjf//uGtQidSEqlWp2gDN6VyXeoHz9TddahX8vRVt6cvfR0o4f4i5gN16aa9nv2E7FGo5DFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5MbwxrmCIkNHSkeCgtZDMKmf5CSJGPbu367LP4e13s=;
 b=jWaq27E318sNHlvsyNu7HSlZYoj8PPKakJdLQaWp6kzCtMFjBGbLxm5y4qJWMqLxXQ6xFD4PlOyz5U6qY938EMn31QG8IZijRioSKhJ+PHpiDvz8ipqdgfA7v/42J5wYhPyBQ7xw3h1CiREKRZYri9Squrl3IJkReYBZJB46PiX4JLUNhWhJTxOK84q4y9/tZWHXvoloL5A2o5+PBfZ3zdRURBgAT4Ny3F6BkhTRwq3kPzR//LBfhO5DW1n1Q8IensLzmwve2naKEszu7nYka00RzEAYoNLFreBKEE4ZVwqhOYgKJbtR/Pi2lb/tBVPQncWti3SffEFk9pazfeF1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5MbwxrmCIkNHSkeCgtZDMKmf5CSJGPbu367LP4e13s=;
 b=C1BB6dy8s4pw3j2ey4u8G/+egX+cLbR+dLvjp6db3zS9VZTewiCBTx8Nhn5uT1etbeTA4omYzJ4uK+4JCwuqSFTz1PHvZQNrehOWL7rr7HYL8Q1V0hLTsb81Ce7wBmOpst8RGboy0LYt3V1MgBXUHDw7w4Ai/dKnk6wMsLakEzU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 07:21:40 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:21:40 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@dabbelt.com>, <daolu@rivosinc.com>
CC:     <linux-kernel@vger.kernel.org>, <heiko@sntech.de>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <guoren@kernel.org>, <jszhang@kernel.org>, <rdunlap@infradead.org>,
        <niklas.cassel@wdc.com>, <panqinglin2020@iscas.ac.cn>,
        <alexandre.ghiti@canonical.com>, <robh@kernel.org>,
        <research_trasio@irq.a4lg.com>, <yury.norov@gmail.com>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
Thread-Topic: [PATCH v4] arch/riscv: add Zihintpause support
Thread-Index: AQHYhOesbS0PbUe670SvwueJS2HLKa2qISUAgAEGogCAAAarAA==
Date:   Fri, 12 Aug 2022 07:21:40 +0000
Message-ID: <310f0509-91c3-6ef2-8895-d1a87125f064@microchip.com>
References: <mhng-381981dd-6fb1-48bc-bdd7-5b613160ef0f@palmer-mbp2014>
 <6d678e5c-dd16-aa54-d244-0cd09717476f@microchip.com>
In-Reply-To: <6d678e5c-dd16-aa54-d244-0cd09717476f@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 635d7b37-1f11-417f-7f17-08da7c334cd7
x-ms-traffictypediagnostic: SJ0PR11MB4862:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvkPA+ZQQKpMcHCZd6sCABjzyX60+sh8ctiYt/dLZHULl3tZbCmNO9A2Syk6j+n/R1dxHNgoivL1ea9/pqoXwM7LWmXdYaxen3x7/ZJHjjf7eRoU+PZf2WhYFER4ZSNkmxLbAtU8FW7HrWh+EYcrL3RpIb4IyyXP8AMCj2Hu9vGp3xp3w6ptkIrVQnN73uehEvAOh/3bR8tZEvy+3APiuK0Xw2+3C1olr4LJtZC3Nbj68m/W4doonWuVQ/SnUfZQTFsKaoUSmx7cVcwv/NkcHj6zITrrH2a7E5/+A15vb30nFdBCV3rwy9eicaNG559Svep4kb4yP2OiqJRqViORDi9emeyuvNV9RsPgrt/2eWo0ZSrafS4D2AR/eSpue+37rqgdbVMnqChcy81gF//y7ipfXHw/3WO7KC+ec5mLg+6pSzWiYEy55puEjLrktebcwDyZy9lGxbpkDeHyEeA6bM0sSwTC7LnNDK/TloW7gQdmu9SGwYMX+iN1IN76NM8TDVU0VUQMQvqxONAUkQLhPh1wx+B5opRtrXYlGZuaHXiE2+TjT/AwgQqocfLgJBAWm/ldZGwcGkgla89aRD2j8tWe1emNse04TAyw0E/GmYd8JUjVb9VFV7jFZmDOHqqeOJFrXA47dkbG49s/RFhmOU9JwA80ysyV0QLUl390+XQCzqWYnru6JRPdi0S5MuGdbgy80nWx7F+jae1eDhhUWelPMqNecicsG7tnAPpG3pxAPOQsA02fF2YID+XF+E74U3mvNieZHOnCWeA4gzNYf9YnuO3yp+EBZQQ2y4YtOl41BREeN9P+OchtYOCgAdAu14wqu5vWHrt4/OlRKxoIPMJmYvlfClUGZShkDmNqUM6Y+MpP4gwG2tZV5Bfi8nVL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(396003)(376002)(39860400002)(4326008)(38100700002)(8676002)(6486002)(122000001)(66476007)(2616005)(186003)(64756008)(66556008)(66446008)(91956017)(66946007)(76116006)(41300700001)(6506007)(2906002)(8936002)(7416002)(478600001)(5660300002)(31696002)(53546011)(86362001)(6512007)(26005)(316002)(38070700005)(36756003)(110136005)(54906003)(83380400001)(71200400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFd0WFRERjE1U2RDUTdCQlhoam8yWGQyWXl5ZStuNHNvWWx1NGJCeVlqSUY2?=
 =?utf-8?B?dlRtbW5vK3R4UnZFY25ucTlmUVAyTXpPYUhuNXlHRTdWNERJRG5UbUtBVFJD?=
 =?utf-8?B?Ujc4eFZZM3ZHK3FhallqMzNNc2t5NEY3N0VNaXBhbDJ6MXVaa0U0QlBIbnJF?=
 =?utf-8?B?elNoSkZZaERGMHJNKzVNYU42bys4b1hzT3B5Q2ZwZlNjZldtTTVRdktaS1ZQ?=
 =?utf-8?B?UmQxR2dQZno4WXAzS2pncVFGQU1hRTNlZllVcEsxNUFXTWphcEkrcFNIOGh1?=
 =?utf-8?B?VXF6S2thL1Y1MmFYRE1ZVXdidUxmY0d3VWNaMkdRMHFBS1pTeVAyTmVXRHIy?=
 =?utf-8?B?aUpmSEJBd2cyQng1WkhuSjBsQzVGaVJjRzBROTlaU0xNZk9jazFWUVJvRXlx?=
 =?utf-8?B?dGI0cG92VS81bEM0MmE4M0trZ2ZKb2VqT0N6SDRYYzhEeE9LTDFqTkg4dHlY?=
 =?utf-8?B?UzQxRDZLQnRBZkJCZmJGa282ei80NUVudzRUSWMvWTdyNVhRUmI2UW9lZ3l3?=
 =?utf-8?B?R1FBTkZGV2JucHpDR1NpYm0wNEVtNjFFR3BGeW5aTmZHYnRZMHBxZzgwUTc2?=
 =?utf-8?B?QkNpcitPQW1SUGU1elcxaEtDSjB4bFNpZGFXSTUvYzZpMlEvZG9IMElGRzht?=
 =?utf-8?B?OHFvcGwrYnBKYkxxbkg1VDd4TWYrSTFWdTZTVjVtdEN3T1hFZmJyVVVXRDNz?=
 =?utf-8?B?WkkzajhFdUFxYUFBZlRyQXNWcXZjQk1jMm5EbXhLYTErN0FLKzQwenVMZXZz?=
 =?utf-8?B?L3NZSkZ3djl1RUxIZ21haTQ0L2FaYXhDTG8rekgvTytmOVhUaERVdzl6b2ZF?=
 =?utf-8?B?N0FiYmx4Zm5ZVzlYdzUrdkVLZ0xibDU1VlVZTm1PRjVLSTIrZ0VsYS96dm85?=
 =?utf-8?B?QVJJMkNNaUpqZDFYclhpNDJQV1BrK0NZTHVwZGJoZElycTA2RGxTdHFwY0g3?=
 =?utf-8?B?cXZRWjlsYUU1c2JuTkQ5aEZlVDh6eHpsa25rKzZuTVk1N1huVTVxLzhaNDJM?=
 =?utf-8?B?KzVFeFVmVlg0dkdJeTJLcm5weXBpczNPQnFCMGMwWDR2b0lLTGF3OTNpLzFa?=
 =?utf-8?B?eVpPT2ZUYUMyV20zUlRTVFdKRDYrSkRvUk1KVWRNNVJlM3BrTWgzcGhJdGY4?=
 =?utf-8?B?UkVCQ1A4ZEFSQzFFNXRhaHBDb0tJMmlHNE1mOFdtTGxRUXN6RGtneEI2blE4?=
 =?utf-8?B?L2ppSWxmV0c4K3RQVXloZHlwL1VFNVF2dXJIVzBIRXlQY3F3YkxyczhyVTVq?=
 =?utf-8?B?WTU3eTd4WlJjM2hVYVdkNUQ3Y1VPL1VGZDBUSndVZ1ltTnFvcThCUzFCNTdS?=
 =?utf-8?B?WHlBMjdPOEFXdGF3OE1kS3dIcEdLSmhRNmErODAwTmtraDhsMGQvNGhSQ3k5?=
 =?utf-8?B?RjhKMlNCdG9sVmhTd1FiM25aVzVOUTFlL214Z1Q3Y3Qvc0xHQlFRckYxT0V3?=
 =?utf-8?B?VHMvZ3c1aXIxbjZpNnM0WGdKc0UwOUpXU1lUai9DQTlRUFlEL2MyZHB0b3Uz?=
 =?utf-8?B?TDJOY3dhYm1ibU5XRHpYdEwvendCOG9jSWFZMXJrVzVJWUQ3TUhhN0NqaFNQ?=
 =?utf-8?B?Y2dTRXlpNFVmUnhURTF2T3g1WDJscjVGWlg2am8xN00ycWs3alhTUmFvMjBn?=
 =?utf-8?B?VzU2WnVDS2hMakszSmdHYWNtMi9BcUFkNDBFSGQxZFhoU2NpSDBMcC8wTXEv?=
 =?utf-8?B?ZnFVSHZtV3FXc2lrODR2K1NYenQwUWNaWHBnYnN1ZG1pRlMxTVRseEZKWk5W?=
 =?utf-8?B?RTh4bkxYOFk2aC8yT1ZFbENUQXFkOXE5c1FsZi9OaHJ5OE5ZSzVHazhGQkhI?=
 =?utf-8?B?WTkyaUZrY1RPWE1zcVdDMVo0V1h4T3dyMExuY3FXNmFaQ2FYc0lBVUtXYjhG?=
 =?utf-8?B?Mzd6MGVnY29qMUI4ak5TL2EwOTJJbCtOOW9yd0FSc0FiM1FYM1B3YlpLeVds?=
 =?utf-8?B?MUw2dy95RkN1OXZURHhaQ3BGdDQwNWEva1c0SXIxcnpMeFhLYk1UeG9RNUtC?=
 =?utf-8?B?SnVDUEdqeGJVZkpGSTBlMlNaZnpqOCs3V2EyOXVkSE8vNk1nbUZUME1yMWxK?=
 =?utf-8?B?YlpnUlZvclliSEhNWEN4UlRxeDhxMXVZZ09tMlhTS2tGWEczRXdiWEJ4cFV6?=
 =?utf-8?Q?d9i78oUEweg6oShA/rf40nJ12?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5FFF82C56A5544D8C644FB4781D8191@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635d7b37-1f11-417f-7f17-08da7c334cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 07:21:40.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8PnxePZlboI20d6xUa4TI2U3xumxLcMy0F7P2+WjRSEK6LWvcDG0VykAImH9NWdop8fuDrqlbpvGn+/9Q+hyFbhJLZ9/sDMqF4lf1VJyIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDgvMjAyMiAwNzo1NywgQ29ub3IgRG9vbGV5IC0gTTUyNjkxIHdyb3RlOg0KPiBPbiAx
MS8wOC8yMDIyIDE2OjE3LCBQYWxtZXIgRGFiYmVsdCB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4NCj4+IE9uIE1vbiwgMjAgSnVuIDIwMjIgMTM6MTU6MjUg
UERUICgtMDcwMCksIGRhb2x1QHJpdm9zaW5jLmNvbSB3cm90ZToNCj4+PiBJbXBsZW1lbnQgc3Vw
cG9ydCBmb3IgdGhlIFppSGludFBhdXNlIGV4dGVuc2lvbi4NCj4+Pg0KPj4+IFRoZSBQQVVTRSBp
bnN0cnVjdGlvbiBpcyBhIEhJTlQgdGhhdCBpbmRpY2F0ZXMgdGhlIGN1cnJlbnQgaGFydOKAmXMg
cmF0ZQ0KPj4+IG9mIGluc3RydWN0aW9uIHJldGlyZW1lbnQgc2hvdWxkIGJlIHRlbXBvcmFyaWx5
IHJlZHVjZWQgb3IgcGF1c2VkLg0KPj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IEhlaWtvIFN0dWVibmVy
IDxoZWlrb0BzbnRlY2guZGU+DQo+Pj4gVGVzdGVkLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29A
c250ZWNoLmRlPg0KPj4+IFNpZ25lZC1vZmYtYnk6IERhbyBMdSA8ZGFvbHVAcml2b3NpbmMuY29t
Pg0KPj4+IC0tLQ0KPj4+DQo+Pj4gdjEgLT4gdjI6DQo+Pj4gwqBSZW1vdmUgdGhlIHVzYWdlIG9m
IHN0YXRpYyBicmFuY2gsIHVzZSBQQVVTRSBpZiB0b29sY2hhaW4gc3VwcG9ydHMgaXQNCj4+PiB2
MiAtPiB2MzoNCj4+PiDCoEFkZGVkIHRoZSBzdGF0aWMgYnJhbmNoIGJhY2ssIGNwdV9yZWxheCgp
IGJlaGF2aW9yIGlzIGtlcHQgdGhlIHNhbWUgZm9yDQo+Pj4gc3lzdGVtcyB0aGF0IGRvIG5vdCBz
dXBwb3J0IFppSGludFBhdXNlDQo+Pj4gdjMgLT4gdjQ6DQo+Pj4gwqBBZG9wdGVkIHRoZSBuZXds
eSBhZGRlZCB1bmlmaWVkIHN0YXRpYyBrZXlzIGZvciBleHRlbnNpb25zDQo+Pj4gLS0tDQo+Pj4g
wqBhcmNoL3Jpc2N2L01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgNCArKysrDQo+Pj4gwqBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2h3Y2FwLmjCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDUgKysrKysNCj4+PiDCoGFyY2gvcmlzY3YvaW5jbHVkZS9hc20v
dmRzby9wcm9jZXNzb3IuaCB8IDIxICsrKysrKysrKysrKysrKysrKy0tLQ0KPj4+IMKgYXJjaC9y
aXNjdi9rZXJuZWwvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSAr
DQo+Pj4gwqBhcmNoL3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmPCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDEgKw0KPj4+IMKgNSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvTWFrZWZpbGUgYi9hcmNo
L3Jpc2N2L01ha2VmaWxlDQo+Pj4gaW5kZXggMzRjZjhhNTk4NjE3Li42ZGRhY2M2ZjQ0YjkgMTAw
NjQ0DQo+Pj4gLS0tIGEvYXJjaC9yaXNjdi9NYWtlZmlsZQ0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yv
TWFrZWZpbGUNCj4+PiBAQCAtNTYsNiArNTYsMTAgQEAgcmlzY3YtbWFyY2gtJChDT05GSUdfUklT
Q1ZfSVNBX0MpwqAgOj0gJChyaXNjdi1tYXJjaC15KWMNCj4+PiDCoHRvb2xjaGFpbi1uZWVkLXpp
Y3NyLXppZmVuY2VpIDo9ICQoY2FsbCBjYy1vcHRpb24teW4sIC1tYXJjaD0kKHJpc2N2LW1hcmNo
LXkpX3ppY3NyX3ppZmVuY2VpKQ0KPj4+IMKgcmlzY3YtbWFyY2gtJCh0b29sY2hhaW4tbmVlZC16
aWNzci16aWZlbmNlaSkgOj0gJChyaXNjdi1tYXJjaC15KV96aWNzcl96aWZlbmNlaQ0KPj4+DQo+
Pj4gKyMgQ2hlY2sgaWYgdGhlIHRvb2xjaGFpbiBzdXBwb3J0cyBaaWhpbnRwYXVzZSBleHRlbnNp
b24NCj4+PiArdG9vbGNoYWluLXN1cHBvcnRzLXppaGludHBhdXNlIDo9ICQoY2FsbCBjYy1vcHRp
b24teW4sIC1tYXJjaD0kKHJpc2N2LW1hcmNoLXkpX3ppaGludHBhdXNlKQ0KPj4+ICtyaXNjdi1t
YXJjaC0kKHRvb2xjaGFpbi1zdXBwb3J0cy16aWhpbnRwYXVzZSkgOj0gJChyaXNjdi1tYXJjaC15
KV96aWhpbnRwYXVzZQ0KPj4+ICsNCj4+PiDCoEtCVUlMRF9DRkxBR1MgKz0gLW1hcmNoPSQoc3Vi
c3QgZmQsLCQocmlzY3YtbWFyY2gteSkpDQo+Pj4gwqBLQlVJTERfQUZMQUdTICs9IC1tYXJjaD0k
KHJpc2N2LW1hcmNoLXkpDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9od2NhcC5oIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9od2NhcC5oDQo+Pj4gaW5kZXgg
ZTQ4ZWViZGQyNjMxLi5kYzQ3MDE5YTBiMzggMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9yaXNjdi9p
bmNsdWRlL2FzbS9od2NhcC5oDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9od2Nh
cC5oDQo+Pj4gQEAgLTgsNiArOCw3IEBADQo+Pj4gwqAjaWZuZGVmIF9BU01fUklTQ1ZfSFdDQVBf
SA0KPj4+IMKgI2RlZmluZSBfQVNNX1JJU0NWX0hXQ0FQX0gNCj4+Pg0KPj4+ICsjaW5jbHVkZSA8
YXNtL2Vycm5vLmg+DQo+Pj4gwqAjaW5jbHVkZSA8bGludXgvYml0cy5oPg0KPj4+IMKgI2luY2x1
ZGUgPHVhcGkvYXNtL2h3Y2FwLmg+DQo+Pj4NCj4+PiBAQCAtNTQsNiArNTUsNyBAQCBleHRlcm4g
dW5zaWduZWQgbG9uZyBlbGZfaHdjYXA7DQo+Pj4gwqBlbnVtIHJpc2N2X2lzYV9leHRfaWQgew0K
Pj4+IMKgwqDCoMKgwqAgUklTQ1ZfSVNBX0VYVF9TU0NPRlBNRiA9IFJJU0NWX0lTQV9FWFRfQkFT
RSwNCj4+PiDCoMKgwqDCoMKgIFJJU0NWX0lTQV9FWFRfU1ZQQk1ULA0KPj4+ICvCoMKgwqDCoCBS
SVNDVl9JU0FfRVhUX1pJSElOVFBBVVNFLA0KPj4+IMKgwqDCoMKgwqAgUklTQ1ZfSVNBX0VYVF9J
RF9NQVggPSBSSVNDVl9JU0FfRVhUX01BWCwNCj4+PiDCoH07DQo+Pj4NCj4+PiBAQCAtNjQsNiAr
NjYsNyBAQCBlbnVtIHJpc2N2X2lzYV9leHRfaWQgew0KPj4+IMKgICovDQo+Pj4gwqBlbnVtIHJp
c2N2X2lzYV9leHRfa2V5IHsNCj4+PiDCoMKgwqDCoMKgIFJJU0NWX0lTQV9FWFRfS0VZX0ZQVSzC
oMKgwqDCoMKgwqDCoMKgwqAgLyogRm9yICdGJyBhbmQgJ0QnICovDQo+Pj4gK8KgwqDCoMKgIFJJ
U0NWX0lTQV9FWFRfS0VZX1pJSElOVFBBVVNFLA0KPj4+IMKgwqDCoMKgwqAgUklTQ1ZfSVNBX0VY
VF9LRVlfTUFYLA0KPj4+IMKgfTsNCj4+Pg0KPj4+IEBAIC04Myw2ICs4Niw4IEBAIHN0YXRpYyBf
X2Fsd2F5c19pbmxpbmUgaW50IHJpc2N2X2lzYV9leHQya2V5KGludCBudW0pDQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0lTQV9FWFRfS0VZX0ZQVTsNCj4+PiDC
oMKgwqDCoMKgIGNhc2UgUklTQ1ZfSVNBX0VYVF9kOg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiBSSVNDVl9JU0FfRVhUX0tFWV9GUFU7DQo+Pj4gK8KgwqDCoMKgIGNhc2Ug
UklTQ1ZfSVNBX0VYVF9aSUhJTlRQQVVTRToNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBSSVNDVl9JU0FfRVhUX0tFWV9aSUhJTlRQQVVTRTsNCj4+PiDCoMKgwqDCoMKgIGRl
ZmF1bHQ6DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+
Pj4gwqDCoMKgwqDCoCB9DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20v
dmRzby9wcm9jZXNzb3IuaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3Iu
aA0KPj4+IGluZGV4IDEzNDM4OGNiYWFhMS4uMWU0ZjhiNGFlZjc5IDEwMDY0NA0KPj4+IC0tLSBh
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3IuaA0KPj4+ICsrKyBiL2FyY2gv
cmlzY3YvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3IuaA0KPj4+IEBAIC00LDE1ICs0LDMwIEBA
DQo+Pj4NCj4+PiDCoCNpZm5kZWYgX19BU1NFTUJMWV9fDQo+Pj4NCj4+PiArI2luY2x1ZGUgPGxp
bnV4L2p1bXBfbGFiZWwuaD4NCj4+PiDCoCNpbmNsdWRlIDxhc20vYmFycmllci5oPg0KPj4+ICsj
aW5jbHVkZSA8YXNtL2h3Y2FwLmg+DQo+Pj4NCj4+PiDCoHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVf
cmVsYXgodm9pZCkNCj4+PiDCoHsNCj4+PiArwqDCoMKgwqAgaWYgKCFzdGF0aWNfYnJhbmNoX2xp
a2VseSgmcmlzY3ZfaXNhX2V4dF9rZXlzW1JJU0NWX0lTQV9FWFRfS0VZX1pJSElOVFBBVVNFXSkp
IHsNCj4+PiDCoCNpZmRlZiBfX3Jpc2N2X211bGRpdg0KPj4+IC3CoMKgwqDCoCBpbnQgZHVtbXk7
DQo+Pj4gLcKgwqDCoMKgIC8qIEluIGxpZXUgb2YgYSBoYWx0IGluc3RydWN0aW9uLCBpbmR1Y2Ug
YSBsb25nLWxhdGVuY3kgc3RhbGwuICovDQo+Pj4gLcKgwqDCoMKgIF9fYXNtX18gX192b2xhdGls
ZV9fICgiZGl2ICUwLCAlMCwgemVybyIgOiAiPXIiIChkdW1teSkpOw0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW50IGR1bW15Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogSW4gbGlldSBvZiBhIGhhbHQgaW5zdHJ1Y3Rpb24sIGluZHVjZSBhIGxvbmctbGF0ZW5jeSBz
dGFsbC4gKi8NCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fYXNtX18gX192b2xhdGls
ZV9fICgiZGl2ICUwLCAlMCwgemVybyIgOiAiPXIiIChkdW1teSkpOw0KPj4+IMKgI2VuZGlmDQo+
Pj4gK8KgwqDCoMKgIH0gZWxzZSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0K
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFJlZHVjZSBpbnN0cnVjdGlvbiByZXRp
cmVtZW50Lg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoaXMgYXNzdW1lcyB0
aGUgUEMgY2hhbmdlcy4NCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+PiAr
I2lmZGVmIF9fcmlzY3ZfemloaW50cGF1c2UNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IF9fYXNtX18gX192b2xhdGlsZV9fICgicGF1c2UiKTsNCj4+PiArI2Vsc2UNCj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIEVuY29kaW5nIG9mIHRoZSBwYXVzZSBpbnN0cnVjdGlvbiAq
Lw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19hc21fXyBfX3ZvbGF0aWxlX18gKCIu
NGJ5dGUgMHgxMDAwMDBGIik7DQo+Pj4gKyNlbmRpZg0KPj4+ICvCoMKgwqDCoCB9DQo+Pj4gwqDC
oMKgwqDCoCBiYXJyaWVyKCk7DQo+Pj4gwqB9DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9y
aXNjdi9rZXJuZWwvY3B1LmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcHUuYw0KPj4+IGluZGV4IGZi
YTllOWY0NmE4Yy4uYTEyM2U5MmIxNGRkIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3Yva2Vy
bmVsL2NwdS5jDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMNCj4+PiBAQCAtODks
NiArODksNyBAQCBpbnQgcmlzY3Zfb2ZfcGFyZW50X2hhcnRpZChzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUpDQo+Pj4gwqBzdGF0aWMgc3RydWN0IHJpc2N2X2lzYV9leHRfZGF0YSBpc2FfZXh0X2Fy
cltdID0gew0KPj4+IMKgwqDCoMKgwqAgX19SSVNDVl9JU0FfRVhUX0RBVEEoc3Njb2ZwbWYsIFJJ
U0NWX0lTQV9FWFRfU1NDT0ZQTUYpLA0KPj4+IMKgwqDCoMKgwqAgX19SSVNDVl9JU0FfRVhUX0RB
VEEoc3ZwYm10LCBSSVNDVl9JU0FfRVhUX1NWUEJNVCksDQo+Pj4gK8KgwqDCoMKgIF9fUklTQ1Zf
SVNBX0VYVF9EQVRBKHppaGludHBhdXNlLCBSSVNDVl9JU0FfRVhUX1pJSElOVFBBVVNFKSwNCj4+
PiDCoMKgwqDCoMKgIF9fUklTQ1ZfSVNBX0VYVF9EQVRBKCIiLCBSSVNDVl9JU0FfRVhUX01BWCks
DQo+Pj4gwqB9Ow0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZl
YXR1cmUuYyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPj4+IGluZGV4IDFiM2Vj
NDRlMjVmNS4uNzA4ZGYyYzBiYzM0IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVs
L2NwdWZlYXR1cmUuYw0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0K
Pj4+IEBAIC0xOTgsNiArMTk4LDcgQEAgdm9pZCBfX2luaXQgcmlzY3ZfZmlsbF9od2NhcCh2b2lk
KQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ug
ew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgU0VUX0lTQV9FWFRfTUFQKCJzc2NvZnBtZiIsIFJJU0NWX0lTQV9FWFRfU1NDT0ZQ
TUYpOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgU0VUX0lTQV9FWFRfTUFQKCJzdnBibXQiLCBSSVNDVl9JU0FfRVhUX1NWUEJN
VCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFNFVF9JU0FfRVhUX01BUCgiemloaW50cGF1c2UiLCBSSVNDVl9JU0FfRVhUX1pJ
SElOVFBBVVNFKTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQ0KPj4+IMKgI3VuZGVmIFNFVF9JU0FfRVhUX01BUA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0NCj4+DQo+PiBUaGFua3MsIHRoaXMgaXMgb24gZm9yLW5leHQuwqAgSXQgbmVl
ZHMgYSBzcGFyc2UgcGF0Y2gsIHdoaWNoIEkgcHV0IGluIGFzIGEgbGluay4NCj4gDQo+IFRoaXMg
YnJlYWtzIHRoZSBDPTEgYnVpbGQgZm9yIGFsbCB0b29sY2hhaW5zLCBub3QganVzdCBuZXcgb25l
cyBhcyB5b3VyIHNwYXJzZQ0KPiBwYXRjaCBzdWdnZXN0cy4gSSBhbW4ndCAxMDAlIHdoYXQgbXkg
Q0kgaXMgcnVubmluZywgYnV0IEkgcmVwbGljYXRlZCB0aGlzIG9uDQo+IG15IG93biBtYWNoaW5l
IHdpdGg6DQoNCkFyZ2gsIEkgd2VudCBwb2tpbmcgYXJvdW5kIGFuZCBteSB0b29sY2hhaW4ncyBi
aW51dGlscyBldGMgaXMgbmV3ZXIgdGhhbiBJIHRob3VnaHQuDQpHb29kIGZvciBwZW9wbGUgc2Vh
cmNoaW5nIG9uIGxvcmUgSSBzdXBwb3NlLi4uDQpTb3JyeSENCkNvbm9yLg0KDQo+IA0KPiBzcGFy
c2UgLS12ZXJzaW9uDQo+IDAuNi40IChVYnVudHU6IDAuNi40LTIpDQo+IA0KPiAtLS04PC0tLQ0K
PiAgwqAgWUFDQ8KgwqDCoCBzY3JpcHRzL2R0Yy9kdGMtcGFyc2VyLnRhYi5bY2hdDQo+ICDCoCBI
T1NUQ0PCoCBzY3JpcHRzL2R0Yy9saWJmZHQvZmR0Lm8NCj4gIMKgIEhPU1RDQ8KgIHNjcmlwdHMv
ZHRjL2xpYmZkdC9mZHRfcm8ubw0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9kdGMvbGliZmR0L2Zk
dF93aXAubw0KPiAgwqAgVVBEwqDCoMKgwqAgaW5jbHVkZS9nZW5lcmF0ZWQvdWFwaS9saW51eC92
ZXJzaW9uLmgNCj4gIMKgIEhPU1RDQ8KgIHNjcmlwdHMvZHRjL2xpYmZkdC9mZHRfc3cubw0KPiAg
wqAgVVBEwqDCoMKgwqAgaW5jbHVkZS9jb25maWcva2VybmVsLnJlbGVhc2UNCj4gIMKgIEhPU1RD
Q8KgIHNjcmlwdHMvZHRjL2xpYmZkdC9mZHRfcncubw0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9k
dGMvbGliZmR0L2ZkdF9zdHJlcnJvci5vDQo+ICDCoCBIT1NUQ0PCoCBzY3JpcHRzL2R0Yy9saWJm
ZHQvZmR0X2VtcHR5X3RyZWUubw0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9kdGMvbGliZmR0L2Zk
dF9hZGRyZXNzZXMubw0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9kdGMvbGliZmR0L2ZkdF9vdmVy
bGF5Lm8NCj4gIMKgIEhPU1RDQ8KgIHNjcmlwdHMvZHRjL2ZkdG92ZXJsYXkubw0KPiAgwqAgSE9T
VENDwqAgc2NyaXB0cy9kdGMvZHRjLWxleGVyLmxleC5vDQo+ICDCoCBIT1NUQ0PCoCBzY3JpcHRz
L2R0Yy9kdGMtcGFyc2VyLnRhYi5vDQo+ICDCoCBVUETCoMKgwqDCoCBpbmNsdWRlL2dlbmVyYXRl
ZC91dHNyZWxlYXNlLmgNCj4gIMKgIEhPU1RMRMKgIHNjcmlwdHMvZHRjL2ZkdG92ZXJsYXkNCj4g
IMKgIEhPU1RMRMKgIHNjcmlwdHMvZHRjL2R0Yw0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9rYWxs
c3ltcw0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9zb3J0dGFibGUNCj4gIMKgIEhPU1RDQ8KgIHNj
cmlwdHMvYXNuMV9jb21waWxlcg0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9zZWxpbnV4L2dlbmhl
YWRlcnMvZ2VuaGVhZGVycw0KPiAgwqAgSE9TVENDwqAgc2NyaXB0cy9zZWxpbnV4L21kcC9tZHAN
Cj4gIMKgIENDwqDCoMKgwqDCoCBzY3JpcHRzL21vZC9lbXB0eS5vDQo+ICDCoCBIT1NUQ0PCoCBz
Y3JpcHRzL21vZC9ta19lbGZjb25maWcNCj4gIMKgIENDwqDCoMKgwqDCoCBzY3JpcHRzL21vZC9k
ZXZpY2V0YWJsZS1vZmZzZXRzLnMNCj4gIMKgIENIRUNLwqDCoCAuLi9zY3JpcHRzL21vZC9lbXB0
eS5jDQo+IGludmFsaWQgYXJndW1lbnQgdG8gJy1tYXJjaCc6ICdfemloaW50cGF1c2UnDQo+IA0K
PiBtYWtlWzJdOiAqKiogWy4uL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjUwOiBzY3JpcHRzL21v
ZC9lbXB0eS5vXSBFcnJvciAxDQo+IG1ha2VbMl06ICoqKiBEZWxldGluZyBmaWxlICdzY3JpcHRz
L21vZC9lbXB0eS5vJw0KPiBtYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLg0KPiBtYWtlWzFdOiAqKiogWy9tbnQvYXV0b21hdGlvbi9jb3JwL3dvcmtzcGFjZS91eC10
ZXN0X3Vwc3RyZWFtLW5leHQtZGV2ZWxvcC1jZEAyL2xpbnV4L01ha2VmaWxlOjEyODc6IHByZXBh
cmUwXSBFcnJvciAyDQo+IG1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcvbW50L2F1dG9tYXRp
b24vY29ycC93b3Jrc3BhY2UvdXgtdGVzdF91cHN0cmVhbS1uZXh0LWRldmVsb3AtY2RAMi9saW51
eC9idWlsZGRpcicNCj4gbWFrZTogKioqIFtNYWtlZmlsZToyMzE6IF9fc3ViLW1ha2VdIEVycm9y
IDINCg0K
