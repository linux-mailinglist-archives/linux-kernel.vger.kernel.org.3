Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AEF560D20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiF2XZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2XZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:25:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8224F2D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656545149; x=1688081149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=naf/+Kmt0gUjTTRa802VBbpU/wfxiUqJYCVgQWIEr7E=;
  b=JJM7lwp1vSszeMN+DyQUGn2y0q5RzfpMkcmPMzll3aYcHD/ufmBSy8se
   iNykjzNo6NegEvn8nUTQbTmFyvPZKNW6TpAIJrvKHxjfvQJjAg84Emu3v
   iIKNEQYAhy7IlI3tjUpEhn3+SAtDW5/rG8r7CoA83E3KPbYvfFAyC03jL
   5CAtuVONF+F3Xf8CDX1AX1Yl7221ZJ2QKkU8UJON7IesdIOmRTzQYAVGT
   M4TGROYsMbIA0UsOXWYYX+9dTTT35Yfzj4/uVCyzjaojzAkWMcrM4YlFW
   olycfe+Q+dWrgqQxlAa5zFr/Pk80OopkAjuVSxHgTWMvjkz0Y6cyFfbr7
   g==;
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="170445040"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 16:25:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 16:25:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 16:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaEVyp3gqjKOmNnW0PKbT3jgRIQyVGWUOIyM45k9FaO5Gl9B8JZrDR2L3RE1AL9po5KBV3OKJmj4mOQtzJv3R9ASq0VDbZ/p1b7q+y5AVD/HrXjwcvDP7fCgXMY3Rya2uZ5Z+dDLdkXKBzdQAoKw+lJDBu+1SenmJa3DsXj0zfqGgvsJGiFQZLpwDC3ga2Ni/+5YNzrLsZrLqIJHjtV37aH5C5MP//PgxDrLw2h3/P76fWN71/yJMSP7sHo1oudNVJakDBz/qewX2mQOVfH/EBUPo3/jygEOgI61k4UGKqGfOLzll/O5ibP3Cxf32UD5/DN7doEMxrMAfi8ekgvvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naf/+Kmt0gUjTTRa802VBbpU/wfxiUqJYCVgQWIEr7E=;
 b=S2rdD6oEBeYYQzu8K/AH94uJLfFNk/28KEwa7709DuZSwgBusCupF3Xx64CFKjkep54jTvmJlf4SXpRHhgl3Yh50Snf/dfMo5SXqY+r2ExSAsZ3JaRnz7WcDRC79Negjo7vBpGE1a04WcWw6ejPXEo1juoOmwzrgvSLRvIzhljLnPyXQLmTklFjVo6PqCW9plde6jSv5tE+O+BIWvvI92yYAlh/v+JLADQK3/W9JCyZpTUQFJusbQCWmeiINbQmNA9fhF8qh/N6Lds2sWSC+jVSINAZ+BoI43KOshrNGPXUNarDWbbLc3iUdwaHSDKfouGvFSlT1cXO5ISaxuVNszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naf/+Kmt0gUjTTRa802VBbpU/wfxiUqJYCVgQWIEr7E=;
 b=bDvP3qjX43ldigedIWPagJ+nmwK0hX6awGxs2muOJJPV9k2WETM+lq+Va+a99/cXArqxr+5fxwqwyk4CzgOQCHRXx/8/G58xRKVJ/29dRDzsVIf6rgXsBGMUC34qternMiHGKv7Xt8HytdHXY0uShG56Fed7IyXiqtgr8i0kwdk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB2054.namprd11.prod.outlook.com (2603:10b6:903:2d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 23:25:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 23:25:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAargIAAEAyAgAAEPgCAAAqJAIAAMFoA
Date:   Wed, 29 Jun 2022 23:25:41 +0000
Message-ID: <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
 <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
In-Reply-To: <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2926f185-e748-48b9-b198-08da5a26aeb0
x-ms-traffictypediagnostic: CY4PR11MB2054:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DzAKBPLLCDKr+aLvSvoAwz3zUI6JGh49vpm4lcFQ5kcZAI2UFNkkoz6aALhDnGfrx52MMPiMUNAxnkwXitFis4C7PnIV9EqMdyXpNxRTXaaYuw/rZmQjMMXTEtXI8mMaVlaHdU/mQLDbf72+ggBJx8MVlaUpexm4D10u+zt7NoraLra8yw+yxmaoO7DfiAJj2OpPqYm+27q+OOUpPPpRA4adqUKmsZmxCn5EWcpA3zgA7TOFIhF1LqrvC4Ng+erPL9akEsBqoTeeSOx4S7VTQFuF5qRj4FpbHdlypl/OZJSucfFqwoX/FnQ8DHXlKNXA2Pqf+JMQ7X+mkTVSIktQr8+jLI50vE1NSp2S9ADX95GirbJ7AYVXsJHPa/sxGHMvUAU3oTTy4yd5uDQojs69EfDyx8YirPj4f+KpLs9KgDqa8i2q0l+vHdxrHUgShb9W2WaSBtjoWMXczK5ZYN1OH/GVuYBpz8TOj4iUYZFOKo9QQT40InB8sLx70PBYPnBWAqFjHcuoAhmlXNM2iCY8Khoq3VOrX7cNIrk3MV9fjo0M6vPZrj2XYCO3bg0Uea0uo/PaeAOhNDG3q1/ZYe4Kno4VnRrJU4BexJjY2Wtx1MftfsUOjBqoLB82ZLN8EdoehT/pfYnLEURYN9NKNwLEEQ5h1QFDO856PBr1nCFuf6ath6oCxZzqZZChSA/ZBQul/OtO4RoitnDF+epmW6y4RQE4i1c/qKcidyBdB3h3lWpfCSC1gvs9nBPVuLKpGN951QS4iRl0LnktJMkFL80n3GJbJbrWl3MD20TSS/aOr/ZWUBqwnzY4EdZc30QUGMSvGicsoykBpA8o9WDn+eNYiwDXGscohcPbH0/N9AF5aLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(39860400002)(366004)(396003)(2906002)(54906003)(316002)(71200400001)(6916009)(31686004)(122000001)(478600001)(36756003)(2616005)(38100700002)(186003)(7416002)(91956017)(66556008)(6486002)(5660300002)(8936002)(66476007)(107886003)(86362001)(53546011)(38070700005)(8676002)(64756008)(66446008)(66946007)(83380400001)(6512007)(26005)(41300700001)(6506007)(4326008)(31696002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkxFeFUwdk5sMkVHU1FOeGg4cHhuczFQTEdtV2FGY3NnVTU4K2g5V1loUjR3?=
 =?utf-8?B?WGdka3hWK0MwNVZBampJekdUbjFIL1J0dVN1QjRUTUxVRUhaZFora0QwcS9l?=
 =?utf-8?B?ZFFFSTQ5QmZSNWIzb0tBNEp2LzNXK3QrMWpxMGdXTDE4amh5ZWpIcG1oczVH?=
 =?utf-8?B?Z1Rxc3hYU3BBNXFFOVplaWltT3piSXRvYnVxSjE3OXN6bmc0aHRtR3dvQzBy?=
 =?utf-8?B?K296QXVaam5mVEZWeE1FTUZxb016VVlxZ3gzaERIQk11RGQzYkhxM1lXUVBo?=
 =?utf-8?B?Umk1YktVWDlubEpPZWtwRjhnUGVaUDgydWpXV1NVKzhnTWhBMms1YnZOODFJ?=
 =?utf-8?B?V3ZSWS9NcnVzN2JpYjZPZGhjV1l1Vno0KzFkU2I5d01tSGgrNm1vcjltU0tl?=
 =?utf-8?B?dU5UempTZ1pUUTdkUFlka3cxWVJmVndBcGFXV29PdXYyc0h2OHIycFZQOHYz?=
 =?utf-8?B?RVdYSks5SktJUnVhQWdBOUh5VFlKTUpkUG83Tm5QTFhkaG95RGJySlJrVVdV?=
 =?utf-8?B?SzBmOUZ0Z1BtYUh0TFFWSmlRRTVZR1NHUk1nVFFTOVp6Q1FXaTZBb1dldlZt?=
 =?utf-8?B?NjBjNUxDc1ZWM3VIaTZ1UzBqdkcwakh1SVBQdm9BQ3RNWVVuNGNrRzVSTlYx?=
 =?utf-8?B?MXVVVDJQL3JQd0ExbVpmSE5FOGRGREQwZ2tsbEl4Yjk2NHhvT0F0ekEwR1l6?=
 =?utf-8?B?R1JhaTR2NjY2MldoMXF1TXVzS2xMem93RTBaSHpROUpGWHYyNTNPUHpBeVhu?=
 =?utf-8?B?QzlJVW5RQ2Q5MWlsak16R1Z3WjR3Q2NPMDdoZW5KY1kwWDd6alovdzFYTC9s?=
 =?utf-8?B?NWRDbzQrclRsUDdlcXFWVml2MUpEYmpZRDNSd2dwUlNOYnNEd1RaT2tYQTFw?=
 =?utf-8?B?d1Y1MlBCQUUwUUsxaFpSK2w0S3NBaTBkSzl1N0xSWElmS0o2eWhkY3dqUjB5?=
 =?utf-8?B?b1RPQkgySEU4YVptWHE0L1pIbDgySzNueVJwa3l4aDF4RXl6YVFRaGNRVVpX?=
 =?utf-8?B?QWkrc25wc1hrcGhIdUNnZ3o4VFlnVjRjZTRIYm5ub2NEV0U2TUhNNEhDaXFG?=
 =?utf-8?B?V2hUaytjZ29xYWh3YTMvbmZBQjNvRUpPZkRCQzNCOWpVb3REQXhJUHZibmVw?=
 =?utf-8?B?eXdLTUNtSmRnWGZWNTR1bUpSUjF2YzFSWDhLOU1adWJrd01HTEJRaU8wcDJ0?=
 =?utf-8?B?ZlV3SW84RTFjNjVwMWFIN0FkZWoxWkc4WmkrM1NXWjdNTm82Zkd5VjZPa29n?=
 =?utf-8?B?VStmMmRYUzdDQVgrdVhSSmFFZlpXQUxzbE4xdzd6MFJTcm1YQ2wvZDZiUzIz?=
 =?utf-8?B?eXVpbnZ1aHpGdDF3WnhXZzdJcTZ6T0VCTjZpL0NybG40STJZWVQxd0hoc21s?=
 =?utf-8?B?ZC9aY1U3ZDQzZ1g0eUtOS3BrRjl1cllod2YrVzRFMTF2RmEvQWszK3pSUTBV?=
 =?utf-8?B?S3VFOVRRTENka2VnYThUZmFnSzBHWHpLeGlBUGxReU9zcGZpRnVRN0JHSUZX?=
 =?utf-8?B?UFdPZDYzdGlib1lscDZ6M0hvMUpXOVNVQTlDSHNqM1QwSE5oUjhuSzZXU0d4?=
 =?utf-8?B?NEI2a29CUDNUSHkySm1CczhSUS80SHhGVHNJZncyQ0xXSzlSRXh3Yll1amlw?=
 =?utf-8?B?S2QzTnA5VS9HTGYwWG5LSWtUWXNnR0lCdyt5N1oxeXJNM0lwM01DNUdLcUtv?=
 =?utf-8?B?WkRRVjZXSk5sZU5lQVNqZ3FIS1hQTEtPdXRZcVZNNi9Qdms4eXNXYW04NWVB?=
 =?utf-8?B?SEdMV0d6Z2VYdG9HenprTFBSdlpoV3VUdkJqYzBlekliNGVHaDZxV3owL0F3?=
 =?utf-8?B?Q1pMNENUaURuT3cvMmFkdWxvSjkxaGVndksvUWEvZ0RFS1dyZUo3dld5Qnpi?=
 =?utf-8?B?U2FQYXhlakFoU25DbU9sSERhMmY0RXFDTXVnczlhTFpmSEdwbTlkNkZhWHVl?=
 =?utf-8?B?ZGFzdmJaMnNUZytza1VRMUdrSGxLcFZFc0pOSUo0UkJ5WVd0THAzNmR2aW9n?=
 =?utf-8?B?aFd5TFF6dXZsUnNHUWFwcDFHczRTM2xhVTlsQzEzc25WRE1vYW84OExwYkZH?=
 =?utf-8?B?anhUNGhFQ3VyeEx4ckk0YlY5aHZ3VFNEUFVteVVEMW9ZSXR6T0VmcHJRSTJW?=
 =?utf-8?B?MWcwcFNZUDUrU2pEaWhqTVUxQm51MFJBTVhGWUsxaEc0OUVGekpaNDlpTEFK?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2EFEC3CC58D184682B7DE6B762A0B99@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2926f185-e748-48b9-b198-08da5a26aeb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 23:25:41.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1GF/u7dlmeoQeT4wGlfTLxwrRmzgugA0c0bWr6+iA5P+E5K5wV5aqUsHiLJZYXGEeYMdRm2YfltUhFag92fIgeIr0SFcNm4Kya1mDyjumI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2054
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDYvMjAyMiAyMTozMiwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjkvMDYvMjAyMiAy
MDo1NCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pg0KPj4gT24gV2VkLCBKdW4gMjksIDIwMjIgYXQgMDc6Mzk6NDNQTSArMDAwMCwg
Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4gT24gMjkvMDYvMjAyMiAxOTo0
MiwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUNCj4+Pj4NCj4+Pj4gT24gV2VkLCBKdW4gMjksIDIwMjIgYXQgMDY6MTg6MjVQTSArMDAw
MCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4gTm8sIG5v
IGl0IGRvZXNuJ3QuIE5vdCBzdXJlIHdoYXQgSSB3YXMgdGhpbmtpbmcgdGhlcmUuDQo+Pj4+PiBQ
cm9iIHRlc3RlZCB0aGF0IG9uIHRoZSB0aGUgbGFzdCBjb21taXQgdGhhdCBiaXNlY3QgdGVzdGVk
DQo+Pj4+PiByYXRoZXIgdGhhbiB0aGUgb25lIGl0IHBvaW50ZWQgb3V0IHRoZSBwcm9ibGVtIHdh
cyB3aXRoLg0KPj4+Pj4NCj4+Pj4+IEVpdGhlciB3YXksIGJvb3QgaXMgYnJva2VuIGluIC1uZXh0
Lg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gQ2FuIHlvdSBjaGVjayBpZiB0aGUgYmVsb3cgZml4ZXMgdGhl
IGlzc3VlPw0KPj4+DQo+Pj4gVW5mb3J0dW5hdGVseSwgbm8gam95Lg0KPj4+IEFwcGxpZWQgdG8g
YSBIRUFEIG9mIDNiMjNiYjI1NzNlNiAoImFyY2hfdG9wb2xvZ3k6IFVzZSB0aGUNCj4+PiBsYXN0
IGxldmVsIGNhY2hlIGluZm9ybWF0aW9uIGZyb20gdGhlIGNhY2hlaW5mbyIpLg0KPj4NCj4+IFRo
YXQncyBiYWQuIERvZXMgdGhlIHN5c3RlbSBib290IHdpdGgNCj4+IENvbW1pdCAyZjdiNzU3ZWI2
OWQgKCJhcmNoX3RvcG9sb2d5OiBBZGQgc3VwcG9ydCB0byBwYXJzZSBhbmQgZGV0ZWN0IGNhY2hl
DQo+PiBhdHRyaWJ1dGVzIikgPw0KPiANCj4gSXQgZG9lcy4NCg0KRldJVyBib290IGxvZyBvZiB0
aGUgZmFpbHVyZToNCg0KWyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA1LjE5LjAtcmM0LTAw
MDA5LWczYjIzYmIyNTczZTYtZGlydHkgKGNvbm9yQCkgKHJpc2N2NjQtdW5rbm93bi1saW51eC1n
bnUtZ2NjIChnNTk2NGI1Y2Q3MjcpIDExLjEuMCwgR05VIGxkIChHTlUgQmludXRpbHMpIDIuMzcp
ICMxIFNNUCBUaHUgSnVuIDMwIDAwOjIyOjQyIElTVCAyMDIyDQpbICAgIDAuMDAwMDAwXSBPRjog
ZmR0OiBJZ25vcmluZyBtZW1vcnkgcmFuZ2UgMHg4MDAwMDAwMCAtIDB4ODAyMDAwMDANClsgICAg
MC4wMDAwMDBdIE1hY2hpbmUgbW9kZWw6IE1pY3JvY2hpcCBQb2xhckZpcmUtU29DIEljaWNsZSBL
aXQNClsgICAgMC4wMDAwMDBdIGVhcmx5Y29uOiBuczE2NTUwYTAgYXQgTU1JTzMyIDB4MDAwMDAw
MDAyMDEwMDAwMCAob3B0aW9ucyAnMTE1MjAwbjgnKQ0KWyAgICAwLjAwMDAwMF0gcHJpbnRrOiBi
b290Y29uc29sZSBbbnMxNjU1MGEwXSBlbmFibGVkDQpbICAgIDAuMDAwMDAwXSBwcmludGs6IGRl
YnVnOiBza2lwIGJvb3QgY29uc29sZSBkZS1yZWdpc3RyYXRpb24uDQpbICAgIDAuMDAwMDAwXSBl
Zmk6IFVFRkkgbm90IGZvdW5kLg0KWyAgICAwLjAwMDAwMF0gWm9uZSByYW5nZXM6DQpbICAgIDAu
MDAwMDAwXSAgIERNQTMyICAgIFttZW0gMHgwMDAwMDAwMDgwMjAwMDAwLTB4MDAwMDAwMDBmZmZm
ZmZmZl0NClsgICAgMC4wMDAwMDBdICAgTm9ybWFsICAgW21lbSAweDAwMDAwMDAxMDAwMDAwMDAt
MHgwMDAwMDAxMDNmZmZmZmZmXQ0KWyAgICAwLjAwMDAwMF0gTW92YWJsZSB6b25lIHN0YXJ0IGZv
ciBlYWNoIG5vZGUNClsgICAgMC4wMDAwMDBdIEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcw0KWyAg
ICAwLjAwMDAwMF0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwODAyMDAwMDAtMHgwMDAwMDAw
MGFkZmZmZmZmXQ0KWyAgICAwLjAwMDAwMF0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDEwMDAw
MDAwMDAtMHgwMDAwMDAxMDNmZmZmZmZmXQ0KWyAgICAwLjAwMDAwMF0gSW5pdG1lbSBzZXR1cCBu
b2RlIDAgW21lbSAweDAwMDAwMDAwODAyMDAwMDAtMHgwMDAwMDAxMDNmZmZmZmZmXQ0KWyAgICAw
LjAwMDAwMF0gT24gbm9kZSAwLCB6b25lIE5vcm1hbDogMTYwNjQ1MTIgcGFnZXMgaW4gdW5hdmFp
bGFibGUgcmFuZ2VzDQpbICAgIDAuMDAwMDAwXSBTQkkgc3BlY2lmaWNhdGlvbiB2MC4zIGRldGVj
dGVkDQpbICAgIDAuMDAwMDAwXSBTQkkgaW1wbGVtZW50YXRpb24gSUQ9MHgxIFZlcnNpb249MHg5
DQpbICAgIDAuMDAwMDAwXSBTQkkgVElNRSBleHRlbnNpb24gZGV0ZWN0ZWQNClsgICAgMC4wMDAw
MDBdIFNCSSBJUEkgZXh0ZW5zaW9uIGRldGVjdGVkDQpbICAgIDAuMDAwMDAwXSBTQkkgUkZFTkNF
IGV4dGVuc2lvbiBkZXRlY3RlZA0KWyAgICAwLjAwMDAwMF0gU0JJIEhTTSBleHRlbnNpb24gZGV0
ZWN0ZWQNClsgICAgMC4wMDAwMDBdIENQVSB3aXRoIGhhcnRpZD0wIGlzIG5vdCBhdmFpbGFibGUN
ClsgICAgMC4wMDAwMDBdIENQVSB3aXRoIGhhcnRpZD0wIGlzIG5vdCBhdmFpbGFibGUNClsgICAg
MC4wMDAwMDBdIHJpc2N2OiBiYXNlIElTQSBleHRlbnNpb25zIGFjZGZpbQ0KWyAgICAwLjAwMDAw
MF0gcmlzY3Y6IEVMRiBjYXBhYmlsaXRpZXMgYWNkZmltDQpbICAgIDAuMDAwMDAwXSBwZXJjcHU6
IEVtYmVkZGVkIDE4IHBhZ2VzL2NwdSBzMzQxMDQgcjgxOTIgZDMxNDMyIHU3MzcyOA0KWyAgICAw
LjAwMDAwMF0gQnVpbHQgMSB6b25lbGlzdHMsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwg
cGFnZXM6IDIyNDI2Mw0KWyAgICAwLjAwMDAwMF0gS2VybmVsIGNvbW1hbmQgbGluZTogZWFybHlj
b24ga2VlcF9ib290Y29uDQpbICAgIDAuMDAwMDAwXSBEZW50cnkgY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAxMzEwNzIgKG9yZGVyOiA4LCAxMDQ4NTc2IGJ5dGVzLCBsaW5lYXIpDQpbICAgIDAu
MDAwMDAwXSBJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNywg
NTI0Mjg4IGJ5dGVzLCBsaW5lYXIpDQpbICAgIDAuMDAwMDAwXSBtZW0gYXV0by1pbml0OiBzdGFj
azpvZmYsIGhlYXAgYWxsb2M6b2ZmLCBoZWFwIGZyZWU6b2ZmDQpbICAgIDAuMDAwMDAwXSBzb2Z0
d2FyZSBJTyBUTEI6IG1hcHBlZCBbbWVtIDB4MDAwMDAwMDBhYTAwMDAwMC0weDAwMDAwMDAwYWUw
MDAwMDBdICg2NE1CKQ0KWyAgICAwLjAwMDAwMF0gVmlydHVhbCBrZXJuZWwgbWVtb3J5IGxheW91
dDoNClsgICAgMC4wMDAwMDBdICAgICAgIGZpeG1hcCA6IDB4ZmZmZmZmYzZmZWUwMDAwMCAtIDB4
ZmZmZmZmYzZmZjAwMDAwMCAgICgyMDQ4IGtCKQ0KWyAgICAwLjAwMDAwMF0gICAgICAgcGNpIGlv
IDogMHhmZmZmZmZjNmZmMDAwMDAwIC0gMHhmZmZmZmZjNzAwMDAwMDAwICAgKCAgMTYgTUIpDQpb
ICAgIDAuMDAwMDAwXSAgICAgIHZtZW1tYXAgOiAweGZmZmZmZmM3MDAwMDAwMDAgLSAweGZmZmZm
ZmM4MDAwMDAwMDAgICAoNDA5NiBNQikNClsgICAgMC4wMDAwMDBdICAgICAgdm1hbGxvYyA6IDB4
ZmZmZmZmYzgwMDAwMDAwMCAtIDB4ZmZmZmZmZDgwMDAwMDAwMCAgICggIDY0IEdCKQ0KWyAgICAw
LjAwMDAwMF0gICAgICAgbG93bWVtIDogMHhmZmZmZmZkODAwMDAwMDAwIC0gMHhmZmZmZmZlN2Jm
ZTAwMDAwICAgKCAgNjIgR0IpDQpbICAgIDAuMDAwMDAwXSAgICAgICBrZXJuZWwgOiAweGZmZmZm
ZmZmODAwMDAwMDAgLSAweGZmZmZmZmZmZmZmZmZmZmYgICAoMjA0NyBNQikNClsgICAgMC4wMDAw
MDBdIE1lbW9yeTogODA3NzQ4Sy8xODAwMTkySyBhdmFpbGFibGUgKDY1MjNLIGtlcm5lbCBjb2Rl
LCA0ODU3SyByd2RhdGEsIDIwNDhLIHJvZGF0YSwgMjE3MUsgaW5pdCwgMzk2SyBic3MsIDk5MjQ0
NEsgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNlcnZlZCkNClsgICAgMC4wMDAwMDBdIFNMVUI6IEhXYWxp
Z249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBDUFVzPTQsIE5vZGVzPTENClsgICAgMC4w
MDAwMDBdIHJjdTogSGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4NClsgICAgMC4wMDAw
MDBdIHJjdTogICAgIFJDVSByZXN0cmljdGluZyBDUFVzIGZyb20gTlJfQ1BVUz04IHRvIG5yX2Nw
dV9pZHM9NC4NClsgICAgMC4wMDAwMDBdIHJjdTogICAgIFJDVSBkZWJ1ZyBleHRlbmRlZCBRUyBl
bnRyeS9leGl0Lg0KWyAgICAwLjAwMDAwMF0gIFRyYWNpbmcgdmFyaWFudCBvZiBUYXNrcyBSQ1Ug
ZW5hYmxlZC4NClsgICAgMC4wMDAwMDBdIHJjdTogUkNVIGNhbGN1bGF0ZWQgdmFsdWUgb2Ygc2No
ZWR1bGVyLWVubGlzdG1lbnQgZGVsYXkgaXMgMjUgamlmZmllcy4NClsgICAgMC4wMDAwMDBdIHJj
dTogQWRqdXN0aW5nIGdlb21ldHJ5IGZvciByY3VfZmFub3V0X2xlYWY9MTYsIG5yX2NwdV9pZHM9
NA0KWyAgICAwLjAwMDAwMF0gTlJfSVJRUzogNjQsIG5yX2lycXM6IDY0LCBwcmVhbGxvY2F0ZWQg
aXJxczogMA0KWyAgICAwLjAwMDAwMF0gQ1BVIHdpdGggaGFydGlkPTAgaXMgbm90IGF2YWlsYWJs
ZQ0KWyAgICAwLjAwMDAwMF0gcmlzY3YtaW50YzogdW5hYmxlIHRvIGZpbmQgaGFydCBpZCBmb3Ig
L2NwdXMvY3B1QDAvaW50ZXJydXB0LWNvbnRyb2xsZXINClsgICAgMC4wMDAwMDBdIHJpc2N2LWlu
dGM6IDY0IGxvY2FsIGludGVycnVwdHMgbWFwcGVkDQpbICAgIDAuMDAwMDAwXSBwbGljOiBpbnRl
cnJ1cHQtY29udHJvbGxlckBjMDAwMDAwOiBtYXBwZWQgMTg2IGludGVycnVwdHMgd2l0aCA0IGhh
bmRsZXJzIGZvciA5IGNvbnRleHRzLg0KWyAgICAwLjAwMDAwMF0gcmN1OiBzcmN1X2luaXQ6IFNl
dHRpbmcgc3JjdV9zdHJ1Y3Qgc2l6ZXMgYmFzZWQgb24gY29udGVudGlvbi4NClsgICAgMC4wMDAw
MDBdIHJpc2N2X3RpbWVyX2luaXRfZHQ6IFJlZ2lzdGVyaW5nIGNsb2Nrc291cmNlIGNwdWlkIFsw
XSBoYXJ0aWQgWzRdDQpbICAgIDAuMDAwMDAwXSBjbG9ja3NvdXJjZTogcmlzY3ZfY2xvY2tzb3Vy
Y2U6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVzOiAweDFkODU0ZGY0MCwgbWF4
X2lkbGVfbnM6IDM1MjYzNjE2MTY5NjAgbnMNClsgICAgMC4wMDAwMDNdIHNjaGVkX2Nsb2NrOiA2
NCBiaXRzIGF0IDEwMDBrSHosIHJlc29sdXRpb24gMTAwMG5zLCB3cmFwcyBldmVyeSAyMTk5MDIz
MjU1NTAwbnMNClsgICAgMC4wMDk2MzldIENvbnNvbGU6IGNvbG91ciBkdW1teSBkZXZpY2UgODB4
MjUNClsgICAgMC4wMTQ1ODNdIHByaW50azogY29uc29sZSBbdHR5MF0gZW5hYmxlZA0KWyAgICAw
LjAxOTIyMF0gQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tpcHBlZCksIHZhbHVlIGNhbGN1bGF0
ZWQgdXNpbmcgdGltZXIgZnJlcXVlbmN5Li4gMi4wMCBCb2dvTUlQUyAobHBqPTQwMDApDQpbICAg
IDAuMDMwMzc3XSBwaWRfbWF4OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDENClsgICAgMC4w
MzU5MDVdIE1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDIsIDE2
Mzg0IGJ5dGVzLCBsaW5lYXIpDQpbICAgIDAuMDQ0MTY5XSBNb3VudHBvaW50LWNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDIsIDE2Mzg0IGJ5dGVzLCBsaW5lYXIpDQpbICAg
IDAuMDU3MDE4XSBjYmxpc3RfaW5pdF9nZW5lcmljOiBTZXR0aW5nIGFkanVzdGFibGUgbnVtYmVy
IG9mIGNhbGxiYWNrIHF1ZXVlcy4NClsgICAgMC4wNjUwMzFdIGNibGlzdF9pbml0X2dlbmVyaWM6
IFNldHRpbmcgc2hpZnQgdG8gMiBhbmQgbGltIHRvIDEuDQpbICAgIDAuMDcyMDY4XSByaXNjdjog
RUxGIGNvbXBhdCBtb2RlIGZhaWxlZA0KWyAgICAwLjA3MjA4NF0gQVNJRCBhbGxvY2F0b3IgZGlz
YWJsZWQgKDAgYml0cykNClsgICAgMC4wODE1NThdIHJjdTogSGllcmFyY2hpY2FsIFNSQ1UgaW1w
bGVtZW50YXRpb24uDQpbICAgIDAuMDg3NDgyXSBFRkkgc2VydmljZXMgd2lsbCBub3QgYmUgYXZh
aWxhYmxlLg0KWyAgICAwLjA5MzgxNl0gc21wOiBCcmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAu
Li4NCg0K
