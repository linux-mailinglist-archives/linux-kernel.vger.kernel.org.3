Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39958FD21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiHKNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiHKNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:13:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C426D565;
        Thu, 11 Aug 2022 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660223612; x=1691759612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KuSYKBYFNsbsWZvdnLIqkQDX+RvlLX6gIK1Z5XnggLU=;
  b=b3zTxZeE0RH2o399h9AHM5dETiLU67LN18pWxMS6InXe3wUEeUiLMU8S
   L3LqmO+3PD1QJbMlzgAa9xAu/r4OkPvDHTDoplw2zUc4PdiI9hTMcRfYw
   vKl/aY05EuX1lADhHnKbZZjKWfRYiUbk5u+tLFnzPeEK/fCAKvt314ZTN
   k28LL1o7e6ZONWNyDmLYwGGolBlxA1TkDwb4WedxVL4uX5IfAU2NV8Rw9
   pc43BM1rLzRxuC4VVXzNHOD0YZRqNVQPaNkV0jCVJh4LPMm6cuHFTbcz7
   OcOq0SzWlLM7EqO04bNnaD6/yKy+19G+C164bVtnExTdVHGC5WxLzGQlt
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="108609813"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Aug 2022 06:13:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 11 Aug 2022 06:13:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 06:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4zA9NTNS6aroQsVJHBn7aaIAikAjPzz700Mzfqsp2L/gevIdkJjSaWDstqpk6BoKfpwzG6fKb5Wt8BX2D4U/q2IBy4PmiORDbjU+JxsFi9UaVMdeb1kstTVqF8OL5mSOEnP08HEkQxD9sUdWBq23VmIY8fbyjRLSRGyxvFfFxaidANDcDNV42ecWKucefzkb9HoiJ7TGcU8BOrWxSF4lAmUGUCq3QjMVgVnmySwtYRC3h9Ql1kYYNEH40YaSvmIsqd1MN2ZkV2w/eNapjO+QtfW2HaRJ/CrJZiYgolsYMUdQ0ogvrBzua1PgdEO+gr+15ZKXwzc/VDeh/oUBAnbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuSYKBYFNsbsWZvdnLIqkQDX+RvlLX6gIK1Z5XnggLU=;
 b=lZVhHGo4U5b2WR4lrowoofZsQDfmoAnf5VpkWJK/lXcp0nr+sKL4+3Q1sfiv0zOa5KcE5DRGCTNe3hcHn1n56u+erS48AU0iBKeLx9bm8KbvCvMoEddCa75RTwNVBkwFexdlHVOhx7tMGwm8idv1OlkZRanh8CW3cyVnTjHLihqBQxsvSv6ZWRCYQKA+/aidzcId1mQjofzqERK7Oxel3riDKL0DDbwaLlCzqOLuUGwCPRIkaWE6eNtz2GqCtmCo8g5V3/yHQtl/sSRNddV+rHVIBcCZPYRwD/oFKOF6nmnWVgAFmoJcKU4dOj0IAEiknzb3YaWwR8PRoY9Ue16kGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuSYKBYFNsbsWZvdnLIqkQDX+RvlLX6gIK1Z5XnggLU=;
 b=CvVfov4JsvGVcnB8bxee47x03NdadOrkt3eVQOGbx1GN7wa7DNIHEwRCjXISjoKlIX6XY6dum5vWjl8tSxIr3bM61lprSEMusBtXPb8LrsjPL1PzANqMUsSJJLI2L6nmwsoMO9SdP/UEXvbXOlLlDdvnjY6mmJsZadKs84Dp9+w=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH0PR11MB5428.namprd11.prod.outlook.com (2603:10b6:610:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 13:13:24 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 13:13:24 +0000
From:   <Conor.Dooley@microchip.com>
To:     <nathan@kernel.org>
CC:     <ndesaulniers@google.com>, <llvm@lists.linux.dev>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <Daire.McNamara@microchip.com>,
        <palmer@dabbelt.com>
Subject: Re: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Topic: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Index: AQHYj5/vIrxOVV1EL0SoHOsgiQHkyK2nacwAgAFM1ACAAAaZgIAAA0QAgAADOwCAASU6AA==
Date:   Thu, 11 Aug 2022 13:13:24 +0000
Message-ID: <d38d8b9c-45da-c464-264c-bebd084bdb17@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
 <bd14f1a2-750d-2511-df0a-85a9f5925f84@microchip.com>
 <YvP/bjh+wXihlrdG@dev-arch.thelio-3990X>
 <fc470bf4-33bb-d67b-3860-3ac775982f27@microchip.com>
 <YvQHtGObJwyBKGCQ@dev-arch.thelio-3990X>
 <3d2c56fa-8245-4992-2074-cd39677c2b3f@microchip.com>
In-Reply-To: <3d2c56fa-8245-4992-2074-cd39677c2b3f@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89b372d7-d0af-46b6-970d-08da7b9b4597
x-ms-traffictypediagnostic: CH0PR11MB5428:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YW3ywF3eAR9V6/ZbtgpgpsfNHJwSn467WjDvl0M4cAnEcgKMHHTOlntPGe8BOyzTppqVJSQ1oX1zcipxPh0IvwISzhJ9p0MfjF7it6b3HbYBLBCuJgdJuk/cxUrYHvMAWKNKmUqGe3HgNUV6Q8rto+HpB4X9MhEoHWeak8DT/WNg9cB6vqwI1zElQVskpp6pZaNH+xr9gVDxRk9IVhCPGbYnxd9JWstqdAEVkQb99c4RMYoUNYYXZTOFJxBdszvCTsxo6e6d0Y9WWcBVeSDpPldOM6O/HUij5awtQmeFUBClSiPs108ze2RAJeTfS/e2wl6+KjNymrOuSSWVBXxFn3/xdpCpdf4w756leKWz7cjG+51iC8SWOc6sxlELKc25r76gRKfuic2Y0aJIMEiAdNor27RsqurPB5gsbTe5bird5gk2NUxMuU7sBnraBKV8CFnM0BkzJFy3WbTFZIwszBeMHCFZYfVmv6KLHKfc6+sFyoPZ4WfYbsCX3gAezd4xdXk0nQX+ghCZMWSqYSIGjnAvRv3CQw9cFQXCAFKQyJTg/X4DImuar89nLL0FtalOuQmzBx3f0OGZ6B991Hlt5R/shAKyDbTn5caU9sc+wZEN0L8GCys0uty4A56nh7KwAn1gNu1buJ2QHTJ9dc33iaRTKFPQQgv5Gzqg/qCekH0sK6gxyDv6sIstEne9hv6z0BcJP9HZfQV+iKBA16z6sYqmb1CrtCuZPAxYud7JiGUSxZhkei/hVzseRXikvVOHCOQyiBYJX0S0vNY+9ICqq7YcxiMywYVt8QNNlQmOmmPIhhJOTHSZb2YvMwp0/p017McgRj/gTNQLx32qbDygW5LYyfSjZQ1JlTpNQo6mQrz7V1wpKH/LIYbawwFukzrr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(396003)(39860400002)(376002)(5660300002)(8936002)(31686004)(6486002)(316002)(66476007)(478600001)(91956017)(54906003)(76116006)(66446008)(66946007)(64756008)(66556008)(6916009)(36756003)(41300700001)(8676002)(4326008)(71200400001)(26005)(83380400001)(38100700002)(6506007)(53546011)(38070700005)(186003)(2616005)(2906002)(7416002)(31696002)(6512007)(86362001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWRVR3lRUmhGTXo4Yk94TTVGM21pSTRxQis2QkhmZWJURWpvZ3kxeHZvNXpJ?=
 =?utf-8?B?VUJsTUlxZjVvZFlEUG1VUlVwRTVrZ3RocFRyZTlCR3ZQWXhKNzhTTm5JUEJQ?=
 =?utf-8?B?NnRLdW5raDdsN3pSZVdwMmFIUnVVRHhMOTZPelpTQS81c2c2cldFRzk3bFIr?=
 =?utf-8?B?L256ZlBOQTVKMXAvWGM1RDZVRk8wcnhraUhlRHFQTFdxeFRkMjVTWnBvWTd3?=
 =?utf-8?B?M3R6c3g2SHJaSUljYUcwb0QraVFJWklQd3YyUWVGV1hEOVdleHIzNERPWHVp?=
 =?utf-8?B?dkN6YW1vQzJIUXRhK3k3QzdLQTA2dmYxN3pxNDFoUjk2SjViZGNBZGk1SEQ4?=
 =?utf-8?B?NUU3VHNEWnZ2Si9GZzN4Q1RaZ25LcWhtR0U0TWpNazI3Q2YzNkhDOWFDcXgw?=
 =?utf-8?B?Wng5ZGFtMnU4VGpmcUFQWnBUMHVpNytHZEZHeGRVL2ZNN2JvaCsxYStVTXlC?=
 =?utf-8?B?LzdldHc3dFRoSVhTQStnK3BtYmpPMkJ2bkxEWXkwTVZJblFic29zZWp2eXNo?=
 =?utf-8?B?VmIwZVhzS0JnS3YvY0JMeUlmQWVIVWpiWUhzdnVJTWpkV28zVHhneU1icWhB?=
 =?utf-8?B?dk1IV0dKbEF0cDZYejRDbUlUTnA4cGhhRSsrME04SnBGNU9xNkFsQkx0eDFu?=
 =?utf-8?B?aVdHZld3QmNPb3I2NFl0M3VuUUZDQ21oRmhNeDhxamV2QWYyVERQS3QwYlhQ?=
 =?utf-8?B?Y0YwbWNqdkRBSmcvMk9TSGNzWVJMSzAvL1FwVHJFbDB1YnYrTklEMFBPZmxM?=
 =?utf-8?B?YkxnUGduVWx1QS91UTVkNWlHc1RrRENSdjRFemg3YXcvTndNR3JMSitzaHVz?=
 =?utf-8?B?OUFMY0hyYkRmZkxraEtpeG9RSUdLellPUWdoMVphb1d1eE9xRjFrWE9UR1gw?=
 =?utf-8?B?d3dXTFBWSTlQaC94Z1hwNFQvdVhvT3V5aFRyTmZoTkFlVFdFcHBRbnB2MGEv?=
 =?utf-8?B?RUxUTUZ4eGt1UXE5d1JMZW54R1RXRHR4UXhlTS83STA1dHg3MmpBZllCb29y?=
 =?utf-8?B?Y0szbU0zdWRYM2lUNElaeFRUYXZNT3FFYUFCcXBYWnY1ekZWRmV4QXRSMUhp?=
 =?utf-8?B?S3UyUXBJZEZqUGNLTVFwM0RwK1pMRkhMdU5SMmYrK3c4Y1FoQnJoNmNlQno5?=
 =?utf-8?B?a1NaNlVkMTY2WGZKc0NRR1BmU0FFcWVaai9qMmoxTVZhdlAvQW5EdTVUazhB?=
 =?utf-8?B?RE5HbFBtL1BGSVpRNVJMc2NEbWFQdG1YSDdnNlZQeDVNYkdPQk5jU3VHUnpj?=
 =?utf-8?B?U3RrMkVoZ2xNSlJCRG1CTHlLdGR4R0tEWFVOaEZoZnV3WDlFczlpUkJQYlpK?=
 =?utf-8?B?ZStMbldteGM3U0pQMFVqMWZ0b0NOQjRtOWkxVXFnb1VkanU1d2xCS284bVJp?=
 =?utf-8?B?VlcwamkrcFpSV3lsdXhzRUMxVkJuZ0lySE1EM3p3c3RaUnNrMDhRMHR4bGhj?=
 =?utf-8?B?M1pmMVZTWVpTejF3c1RFM2w3TVQzKytMbWcxZ3ZmS1NWV3QvZWMzc1o4WHdv?=
 =?utf-8?B?SmdibHF0NEZ6MGQzRGI1bi8vK2VXZmxhWkdoRmcrcUl2NTZvTGVCN3FwTU54?=
 =?utf-8?B?U0w5L1pNYkFzQy9xMHhtK2h1VkxlSkZpcmhLWStEQXpLYUMrOWRIUHRjQk1u?=
 =?utf-8?B?eWpIcjFpNDhveHpRNXhUejUyNWZ4RktHV0x4VG1PeHJ3TC9RZHVkdTZuS0J3?=
 =?utf-8?B?NDNhOU1LdGI5YUlaNG1yNmVRU0V4ZzRnQklpQStNSFhEYkZXUUZXTVhadUlU?=
 =?utf-8?B?VGV1VFRXdGxJbXRLcU45Y09Nc0k5ZVdFRUdUVFJ0dG9Dd3NpSXQ2ZmR1WHBQ?=
 =?utf-8?B?RDJJc0JXMkJnK1UrMXkzOWZxb2hXeGoyR2t6M0hJREVwa1c3ODdzY09ucnRk?=
 =?utf-8?B?MCtFQWIwN2hURHlEVThYbDFBekhLN2wraXgxY3Y4T05Kc0ZnWlp2a0FxeGhN?=
 =?utf-8?B?U2dVU2ZoUU9hWUZnYmc1d3RqRHp3VkZpYlFtbTN5NkMwWWNTQUY3VnppREZK?=
 =?utf-8?B?UkFPZnpJTDFBVVlsWUVGUkVTZkhwRXhLRE80dzdDOVlJODU2QklOaUpldm5i?=
 =?utf-8?B?SlZUUjZFOUIxTllXUk85MkNwbEYyYm9QYWR6QVdObnJ3d3FqdGVyV0p2eEFn?=
 =?utf-8?Q?fE3ufMB/aoLwhDSwMz0jN8Kl7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D272C5509564A48AA84DCFD0F5FEB85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b372d7-d0af-46b6-970d-08da7b9b4597
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 13:13:24.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IebY5omkvkinl/upvjh3wJnX+KyYPFjd9/1n/eR/AlXgE3skwM/+3260oSummnIkW72Z1r2hqX+uJyi7BGd5bxLe6c3orRZd8DWOVpzL9DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5428
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IE5hdGhhbiwNCg0KT24gMTAvMDgvMjAyMiAyMDo0MywgQ29ub3IgRG9vbGV5IC0gTTUyNjkx
IHdyb3RlOg0KPiBPbiAxMC8wOC8yMDIyIDIwOjMyLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToN
Cj4+IE9uIFdlZCwgQXVnIDEwLCAyMDIyIGF0IDA3OjIwOjI0UE0gKzAwMDAsIENvbm9yLkRvb2xl
eUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+IE9uIDEwLzA4LzIwMjIgMTk6NTYsIE5hdGhhbiBD
aGFuY2VsbG9yIHdyb3RlOg0KPj4+PiBIaSBDb25vciwNCj4+Pj4NCj4+Pj4gT24gVHVlLCBBdWcg
MDksIDIwMjIgYXQgMTE6MDU6MzJQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+Pj4+PiArQ0MgY2xhbmcgcGVvcGxlIDopDQo+Pj4+Pg0KPj4+Pj4gR290IGFuIG9k
ZCBvbmUgaGVyZSBhbmQgd291bGQgYXBwcmVjaWF0ZSBzb21lIHBvaW50ZXJzIGZvciB3aGVyZSB0
bw0KPj4+Pj4gbG9vay4gVGhpcyBjb2RlIHdoZW4gYnVpbHQgd2l0aCBnY2MgYm9vdHMgZmluZSwg
Zm9yIGV4YW1wbGUgd2l0aDoNCj4+Pj4+IHJpc2N2NjQtdW5rbm93bi1saW51eC1nbnUtZ2NjIChn
NTk2NGI1Y2Q3MjcpIDExLjEuMA0KPj4+Pj4gVGhlIHNhbWUgY29kZSBidXQgYnVpbGQgd2l0aCBj
bGFuZyBidWlsZCBpdCBmYWlscyB0byBib290IGJ1dCBwcmlvciB0bw0KPj4+Pj4gdGhhdCBhcHBs
eWluZyB0aGlzIHBhdGNoc2V0IGl0IGJvb3RzIGZpbmUuIFNwZWNpZmljYWxseSBpdCBpcyB0aGUg
cGF0Y2gNCj4+Pj4+ICJjbGs6IG1pY3JvY2hpcDogbXBmczogbW92ZSBpZCAmIG9mZnNldCBvdXQg
b2YgY2xvY2sgc3RydWN0cyINCj4+Pj4+DQo+Pj4+PiBJIGFwcGxpZWQgdGhpcyBwYXRjaHNldCBv
biB0b3Agb2YgdG9uaWdodCdzIG1hc3RlciAoMTUyMDVjMjgyOWNhKSBidXQNCj4+Pj4+IEkndmUg
YmVlbiBzZWVpbmcgdGhlIHNhbWUgcHJvYmxlbSBmb3IgYSBmZXcgd2Vla3Mgb24gLW5leHQgdG9v
LiBJIHRyaWVkDQo+Pj4+PiB0aGUgZm9sbG93aW5nIDIgdmVyc2lvbnMgb2YgY2xhbmcvbGx2bToN
Cj4+Pj4+IENsYW5nQnVpbHRMaW51eCBjbGFuZyB2ZXJzaW9uIDE1LjAuMCAoNWIwNzg4ZmVmODZl
ZDcwMDhhMTFmNmVlMTliOWQ4NmQ0MmI2ZmNmYSksIExMRCAxNS4wLjANCj4+Pj4+IENsYW5nQnVp
bHRMaW51eCBjbGFuZyB2ZXJzaW9uIDE1LjAuMCAoYmFiOGFmOGVhMDYyZjYzMzJiNWM1ZDEzYWU2
ODhiYjg5MDBmMjQ0YSksIExMRCAxNS4wLjANCj4+Pj4NCj4+Pj4gR29vZCB0byBrbm93IHRoYXQg
aXQgcmVwcm9kdWNlcyB3aXRoIGZhaXJseSByZWNlbnQgdmVyc2lvbnMgb2YgTExWTSA6KQ0KPj4+
Pg0KPj4+Pj4gSXQncyBwcm9iYWJseSBzb21ldGhpbmcgc2lsbHkgdGhhdCBJJ3ZlIG92ZXJsb29r
ZWQgYnV0IEkgYW0gbm90IGF1DQo+Pj4+PiBmYWl0IHdpdGggdGhlc2Ugc29ydCBvZiB0aGluZ3Mg
dW5mb3J0dW5hdGVseSwgYnV0IGhleSAtIGF0IGxlYXN0IEknbGwNCj4+Pj4+IGxlYXJuIHNvbWV0
aGluZyB0aGVuLg0KPj4+Pg0KPj4+PiBJIHRvb2sgYSBxdWljayBnbGFuY2UgYXQgdGhlIHBhdGNo
IHlvdSBtZW50aW9uZWQgYWJvdmUgYW5kIEkgZG9uJ3QNCj4+Pj4gaW1tZWRpYXRlbHkgc2VlIGFu
eXRoaW5nIGFzIHByb2JsZW1hdGljLi4uDQo+Pj4NCj4+PiBZZWFoLCBJIGNvdWxkbid0IHNlZSBh
bnkgbG93IGhhbmdpbmcgZnJ1aXQgZWl0aGVyLg0KPj4+DQo+Pj4+IEkgd2FzIGdvaW5nIHRvIHNl
ZSBpZiBJIGNvdWxkDQo+Pj4+IHJlcHJvZHVjZSB0aGlzIGxvY2FsbHkgaW4gUUVNVSBzaW5jZSBJ
IGRvIHNlZSB0aGVyZSBpcyBhIG1hY2hpbmUNCj4+Pj4gJ21pY3JvY2hpcC1pY2ljbGUta2l0JyBi
dXQgSSBhbSBub3QgaGF2aW5nIG11Y2ggc3VjY2VzcyBnZXR0aW5nIHRoZQ0KPj4+PiBtYWNoaW5l
IHBhc3QgU0JJLiBEb2VzIHRoaXMgcmVwcm9kdWNlIGluIFFFTVUgb3IgYXJlIHlvdSB3b3JraW5n
IHdpdGgNCj4+Pj4gdGhlIHJlYWwgaGFyZHdhcmU/IElmIFFFTVUsIGRvIHlvdSBoYXBwZW4gdG8g
aGF2ZSBhIHdvcmtpbmcgaW52b2NhdGlvbg0KPj4+PiBoYW5keT8NCj4+Pg0KPj4+IFllYWguLi4g
U28gdGhlcmUgd2FzIGEgUUVNVSBpbmNhbnRhdGlvbiB0aGF0IHdvcmtlZCBhdCBzb21lIHBvaW50
IGluDQo+Pj4gdGhlIHBhc3QgKGllIHdoZW4gc29tZW9uZSB3cm90ZSB0aGUgUUVNVSBwb3J0KSBi
dXQgbW9zdCBwZXJpcGhlcmFscw0KPj4+IGFyZSBub3QgaW1wbGVtZW50ZWQgYW5kIGN1cnJlbnQg
dmVyc2lvbnMgb2Ygb3VyIG9wZW5TQkkgaW1wbGVtZW50YXRpb24NCj4+PiByZXF1aXJlcyBtb3Jl
IHRoYW4gb25lIG9mIHRoZSB1bmltcGxlbWVudGVkIHBlcmlwaGVyYWxzLiBJIHdhcyB0cnlpbmcg
dG8NCj4+PiBnZXQgaXQgd29ya2luZyBsYXRlbHkgaW4gdGhlIGV2ZW5pbmdzIGJhc2VkIG9uIHNv
bWUgcGF0Y2hlcyB0aGF0IHdlcmUgYQ0KPj4+IHllYXIgb2xkIGJ1dCBubyBqb3kgOi8NCj4+DQo+
PiBIZWgsIEkgZ3Vlc3MgdGhhdCB3b3VsZCBleHBsYWluIHdoeSBpdCB3YXNuJ3Qgd29ya2luZyBm
b3IgbWUgOikNCj4+DQo+Pj4gSSdtIHJ1bm5pbmcgb24gdGhlIHJlYWwgaGFyZHdhcmUsIEknbGwg
Z2l2ZSB0aGUgb2xkZXIgY29tYm8gb2YgcWVtdQ0KPj4+ICJiaW9zIiBldGMgYSBnbyBhZ2FpbiBv
dmVyIHRoZSB3ZWVrZW5kICYgdHJ5IHRvIGdldCBpdCB3b3JraW5nLiBJbiB0aGUNCj4+PiBtZWFu
dGltZSwgYW55IHN1Z2dlc3Rpb25zPw0KPj4NCj4+IEFyZSB5b3UgYnVpbGRpbmcgd2l0aCAnTExW
TT0xJyBvciBqdXN0ICdDQz1jbGFuZyc/IElmICdMTFZNPTEnLCBJIHdvdWxkDQo+PiB0cnkgYnJl
YWtpbmcgaXQgYXBhcnQgaW50byB0aGUgaW5kaXZpZHVhbCBvcHRpb25zIChMRD1sZC5sbGQsDQo+
PiBPQkpDT1BZPWxsdm0tb2JqY29weSkgYW5kIHNlZSBpZiBkcm9wcGluZyBvbmUgb2YgdGhvc2Ug
bWFrZXMgYQ0KPj4gZGlmZmVyZW5jZS4gV2UgaGF2ZSBoYWQgc3VidGxlIGRpZmZlcmVuY2VzIGJl
dHdlZW4gdGhlIEdOVSBhbmQgTExWTQ0KPj4gdG9vbHMgYmVmb3JlIGFuZCBpdCBpcyBtdWNoIGVh
c2llciB0byBsb29rIGludG8gdGhhdCBkaWZmZXJlbmNlIGlmIHdlDQo+PiBrbm93IGl0IGhhcHBl
bnMgaW4gb25seSBvbmUgdG9vbC4NCj4gDQo+IExMVk09MS4NCj4gDQo+Pg0KPj4gT3RoZXJ3aXNl
LCBJIGFtIG5vdCBzdXJlIEkgaGF2ZSBhbnkgaW1tZWRpYXRlIGlkZWFzIG90aGVyIHRoYW4gbG9v
a2luZw0KPj4gYXQgdGhlIGRpc2Fzc2VtYmx5IGFuZCB0cnlpbmcgdG8gc2VlIGlmIHNvbWV0aGlu
ZyBpcyBnb2luZyB3cm9uZy4gSXMNCj4+IHRoZSBvYmplY3QgZmlsZSBiZWluZyBtb2RpZmllZCBp
biBhbnkgb3RoZXIgd2F5IChJIGRvbid0IHRoaW5rIHRoZXJlIGlzDQo+PiBzb21ldGhpbmcgbGlr
ZSBvYmp0b29sIGZvciBSSVNDLVYgYnV0IEkgY291bGQgYmUgd3JvbmcpPw0KPiANCj4gSSdsbCBn
aXZlIHRoZSBvcHRpb25zIGEgZ28gc28sIEknbGwgTFlLIGhvdyBJIGdldCBvbi4NCg0KU28gSSBt
YW5hZ2VkIHRvIHdyYW5nbGUgUUVNVSBpbnRvIHJlcHJvLWluZy4gYm9vdGluZyB3aXRoIGJvb3Rs
b2FkZXJzDQpldGMgaXNuJ3QgZ29pbmcgdG8gd29yayAobm9yIHdpbGwgdGhlIGNvbmZpZyB3aXRo
IGdjYyBhY3R1YWxseSBib290DQpwcm9wZXJseSkgYnV0IGl0IGdldHMgZmFyIGVub3VnaCB0byBy
ZXByb2R1Y2UgdGhlIHByb2JsZW0uDQpZb3UndmUgZ290IHRvIGp1bXAgcmlnaHQgdG8gdGhlIGtl
cm5lbCBmb3Igd2hpY2ggdGhlIG1hZ2ljIGluY2FudGF0aW9uDQppczoNCg0KJChRRU1VKS9xZW11
LXN5c3RlbS1yaXNjdjY0IC1NIG1pY3JvY2hpcC1pY2ljbGUta2l0IFwNCgktbSAyRyAtc21wIDUg
XA0KCS1rZXJuZWwgJCh3cmtkaXIpL3ZtbGludXguYmluIFwNCgktZHRiICQod3JrZGlyKS9yaXNj
dnBjLmR0YiBcDQoJLWRpc3BsYXkgbm9uZSAtc2VyaWFsIG51bGwgXA0KCS1zZXJpYWwgc3RkaW8N
Cg0KKHNlcmlhbDAgaXMgZGlzYWJsZWQgaW4gdGhlIGR0KQ0KDQpXaXRoIGdjYyB0aGVyZSdsbCBi
ZSBhIGJ1bmNoIG9mIHdhcm5pbmdzIGxpa2U6DQpjbGtfYWhiOiBaZXJvIGRpdmlzb3IgYW5kIENM
S19ESVZJREVSX0FMTE9XX1pFUk8gbm90IHNldA0KVGhhdCdzICJmaW5lIiwgbm90IHN1cmUgaWYg
aXQncyB0aGUgbGFjayBvZiBib290bG9hZGVycyBvciB0aGUNCmVtdWxhdGlvbiBidXQgMCBpc24n
dCBhIHZhbHVlIHRoZSBoYXJkd2FyZSB3aWxsIHNlZS4gV2l0aCB0aGUgZGVmY29uZmlnDQpJIHBy
b3ZpZGVkIGl0J2xsIGZhaWwgdG8gYm9vdCBmYWlybHkgbGF0ZSBvbiBiZWNhdXNlIG9mIG1pc3Np
bmcgbXVzYg0KZW11bGF0aW9uLg0KDQpEb2Vzbid0IHJlYWxseSBtYXR0ZXIgc2luY2UgdGhhdHMg
bG9uZyBlbm91Z2ggdG8gZ2V0IHBhc3QgdGhlIHN3aXRjaA0Kb3V0IG9mIGVhcmx5Y29uIHdoaWNo
IGlzIHdoZXJlIHRoZSBjbGFuZyBidWlsdCBrZXJuZWwgZGllcy4NCg0KRGlkbid0IGdldCBhIGNo
YW5jZSB0byBsb29rIGF0IGRpc2Fzc2VtYmx5IGV0YyB0b2RheSwgYnV0IGFzIEkgc2FpZA0KbGFz
dCBuaWdodCBpdCByZXByb2R1Y2VzIHdpdGggR05VIGJpbnV0aWxzLg0KDQpUaGFua3MsDQpDb25v
ci4NCg0KT24gYW5vdGhlciBub3RlLCBicm91Z2h0IHVwIG91ciBRRU1VIHBvcnQncyBzdGF0ZSB0
b2RheSBzbyBmaXhpbmcNCml0IGlzIG5vdyBvbiB0aGUgZ29vZCBvbGUsIGV2ZXIgZXhwYW5kaW5n
IHRvZG8gbGlzdCA6KQ0K
