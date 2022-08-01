Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A90586748
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiHAKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiHAKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:17:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D22656;
        Mon,  1 Aug 2022 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659349040; x=1690885040;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dBvQHQQVagosCrP64HDlUps/oxyVur39KiRLzu7IMgg=;
  b=drucS3WFDifJav6c4yqSpzQdCA9g0bFUK+FLx6ey17M2RDvAgk4pHj0V
   Vu47knW1orhUkJhYmMEhDjeDqrJbudUL5i6BuRWXSIBQItLjq99yUmL49
   c3EO+1G8IQiJS6+ybSQWGPmFR4e20OkRxDVQnxLR+c8WvTqZg8zOLHDGS
   LG0T1oxDJR8JmXQ9YlSBvTwy0/ammifCzBq8vYj3mpcLUIwwFjdFcwZqJ
   sVPpzmVObSI9XHYkjmXY1YpsTqEcTHfSR/zp+ExxorRQoEo/DsG5Xeizb
   gLn83hB5XyMwrtQizA0e2Nb9Wfk2vbzpxJhhtIY5drgPSnLv/zsp5dzx7
   g==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="170373820"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 03:17:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 03:17:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 03:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpJcHJJKyxhe0DEmlvSa2nwaqiPxoxyBJX3icoXpij5z6HvRgWu008/0oPYdElR2t3r4lGo9OmgIMlWjUL3KnQjmm7qXt54u4a1v/Z5NMpfdexAC3TCWVsBjxa82JCcFk6psg8W9YZ4Ip5XCNlsq7xEMzZlFBwVaPNjzf03Gvne8bngwE4DKjDR6M/kYJw0zXn09UvJ8ieCdlBCdabp0Q6NXOBIVSDMi73EFFwC8RxL0ZeRnbDgXrEt1wo9B9ZsOX/SHHP4dcAECQOBQ7CL+WhQ2KjmVCKqoxtj/sKFYF9u3s+RRTId4WauDFPSGMY53FVxjeJyi7LCX/CDpaVr+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBvQHQQVagosCrP64HDlUps/oxyVur39KiRLzu7IMgg=;
 b=SNgybgKJUG9Hj/JZb6VT5f6UtFyruWazWn7pOnEwpBynS4yLz9H6XV0+K1YmcxfMwq9E4d9iXSC3i3BL4V/0Pdg1qYrBeSRY+puIYBYLyT+cIE9GOGFRZ2w0CMpF1eHQgmaQe7jnwrqzF/exoI8JBkNc2Bw3CFWDbwKrOGnfem19pRDb/pklgrmybffEz/sDgpQNLwKvJB60dkqUe8/Vh/8jeJbGXgQXKsZNfkEviWd8d30fYLaGW914cIj0eT0euUaRLEonwGbBBbtXA+uMw5WrQ/y3S+NCqhzn4ZW0bSfumrWiN8te0SeKOoHqj4IrSE8bXSTCdMuT8/57C9SYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBvQHQQVagosCrP64HDlUps/oxyVur39KiRLzu7IMgg=;
 b=D1XDigzCyhogFRFJGhCCAIqi2tLQPMsR6eOu3l5LhvQU1/SlFhZQuvliFG9JEz5kAhMdd6WV2MUruJlG+gJTEwy1J+Z5Vvv8wCG/kmniJKPISNWQDesoryryaCuV4ohWxfm+bp2OM18ikxxkVQnZCVd6umX5/juFlEN5Pw87r0I=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 10:17:13 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:17:13 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nagasuresh.Relli@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Thread-Topic: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Thread-Index: AQHYpYstbY78zesAJEuPevcBeLOUjq2Z1KQA
Date:   Mon, 1 Aug 2022 10:17:12 +0000
Message-ID: <a431ac00-ee65-df7a-674c-27f13fc7be82@microchip.com>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
In-Reply-To: <20220801094255.664548-2-nagasuresh.relli@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb3acf42-d214-402f-3fe3-08da73a7006b
x-ms-traffictypediagnostic: DM4PR11MB6358:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fDyzGKkcFoIzO/rJ+Otjhw6ztoelRBr4tkeODvY+KUO2Wwu/LPngBW7+uwOvaBC9UrHvnbvEJItnFSG6WEytwWsnlsh0r2TjlEvxXx0KnaODme6dkNy7dfdVtyyfv+0/u8Wmx0nNCtGMWY4cSR980zVg0iKoLaCsTRMokSMKWFR6tg1w0zWEyB41fnqZlocoeBi41PKJYI8QOI9LG//DSFmmimgrdMDWkia+h6/54sq/eTGiXuPCD0frMHH80O5Rw6SpqPQooncbybGoM07rUsJV8+i2Xaz3x1XG4HVnmz17xqyW8Z9xDCQR8DhqQTxz9k22qwhiVZY2jJ/rpvf9LyE3fYV/lGmMU9Q5aUbf3SsDFqpWEoNE/V7YjlE0N2wlT3BXy9Xcf0wrTctgCvEByYgE3D837hidG1vOnub4AZAVUkHpIP5jgCm8rEQHPbDmbzZ/RI2H+iU4XuJYp7cF3rAAIBLh5toyk9+kHffXXtgnh99R68AUYNqY4BcQ+IyEq5gJNvOmxjfOh8LfvIc1DqyLp4kRMQefbR81hEK9Euqn0KcP6rSpwBuu06Kz7KBvmHa+EmRWzvLyIlqqveXNoLSQ6p07098Lg2AWN7kwH/6lrr5C6XQrQhusPRTe+zm4AKA7NSQLX+dwx2CA4kJsJmZeqZnrwEoFFRpouH+v+AWoMiYiqcA7vFsA7L1neyy/2GFOCtwnliDrqjYon07DoWH9apGtRcRQKAc+ZEyZhQuyLqKBIvVlqaINMH2edpvVhx+i7wFl6Twso+/qAegJNjmz6va4kSU7w5bC69h+4FPqoO3kJGFbA/GCz0a8pUTwGsgp1mx47gFNeHAyrER2Uca4ByGIgbhPnv5FmcQ4+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(396003)(346002)(136003)(39860400002)(2616005)(186003)(2906002)(41300700001)(6506007)(6512007)(26005)(31696002)(38100700002)(38070700005)(53546011)(66946007)(86362001)(6486002)(83380400001)(122000001)(316002)(4326008)(8676002)(71200400001)(31686004)(76116006)(110136005)(66556008)(66476007)(66446008)(64756008)(54906003)(91956017)(36756003)(478600001)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXhnbEgyMkx2czdxcGJmcEZDYWE1bXo4MGFZb251Y1NleHkyL3RLa3liVW1x?=
 =?utf-8?B?UnBoaU9SVXBYaFFURkhnMmxMMUtycFgxMy9GeGxJamNXdkw3dXVsejM4bFg5?=
 =?utf-8?B?azZHMzR1cHNNODB2K1phZVRSNldzM0RrQWlhdVhISlRONGg1K01CcnNiVlZr?=
 =?utf-8?B?ZEQ1WjZ4ZHJpQy82cnd2bzMvL3VwdVd6bEh1MnZqaXdKd1NMWTZtRmVCRFpZ?=
 =?utf-8?B?MkJKY1R0QUNJT3FFZEM2SllvWEo2MGZSdDBBYTRaSHVJNWxUTWFLenJvQWtH?=
 =?utf-8?B?cUhyRUtudkZrV2NFQTNIM1hNQWRucWlJVzN1ZmQ1VFRxbWNLOGVGTW1FcGl1?=
 =?utf-8?B?ZHlCaHJMVHg2bkk3VmV1Z1ZSTHdqUnZUZi9rZnAzOG1zVGxLUmlNdjFDbVZr?=
 =?utf-8?B?SXpLZEhWSlZUT3pRTitEMkE0QVZHOFZzSTRuNkt4alY0b2RYOERjMC96TTJD?=
 =?utf-8?B?U2tPcHFHU1ZTQTB3M1hYMGZDYWdXWmEzRmo0WkVveFhodzlvLzZ3QnpMVFh6?=
 =?utf-8?B?STVzVmNHOVUxaFRiT3dVYTArTmRSa0FKVWhlYnJOUzNzRk5GenV1Z3R0ZWwy?=
 =?utf-8?B?TDdBVFlXeE1UVk80UGxrZVpsbEp2TGw3QUZXZmFEWnBrWE5BY2NHRy9nd0x3?=
 =?utf-8?B?b0tTQ1IxQS9UVTBKR05QREhjWkxGRUgyYjNrS2dSYS9tcGVKemh1NVhSSXZo?=
 =?utf-8?B?akdHMGlURjR2VmlhKzNreDVEZEx3RURVS3lDT0w3RHA0b2I2OWJ0Ri9XZlJ0?=
 =?utf-8?B?SWNHY1RPMXp1cFNKWHlLZ080YTBFWmRNZXJLOElCTEo4dVFGSGpHc2tNT2do?=
 =?utf-8?B?U0toQklwVVNDak43Njl2M3NtanpHTWxPaEx4MUlKZDRMU1J3ekRtRGsydm1D?=
 =?utf-8?B?N29xUkdzMXhlUmdYZWdOK095NnJ0Z1MvZCtYZEJicVd1R0RrRDJOeFQyQlBF?=
 =?utf-8?B?KzlwaGpuNXRleFVSYU9CVk0weWVFb3NlaW9tWGcwQWJUamFqMHFoaUhETlZU?=
 =?utf-8?B?MDVGUmJWWVpCemM2aUVOckxwWXF5T0U2SHJ1QjczNHl6Vk1vT2VBaEJ5WDdN?=
 =?utf-8?B?d0FCN3NTQVVNdmhCSW4rVXNWb0M1bmh5MmRsYmJwdjFLZTUrWmlFUlA0Q3Za?=
 =?utf-8?B?WGZkYTJYN3pBM293V0ZWbDR6MWkyUHpkVE9KczB0SmoxUXNpUEQycGhETk05?=
 =?utf-8?B?YmxkRGdESlVQa1h0TnhGS01HdS9UTzVZU0lTY0N4cTNENWJBelpYUHlJSXl2?=
 =?utf-8?B?d21GenJoZWxQQkFJRGg2S1ZvVUtlTDdxQkhvdEdydFBWL1hZK0ZTK2lpMG9H?=
 =?utf-8?B?d3AzY1FHOGFvTGovZk5iVDdtUVRLVWxpWFM1eUM2bnlsekV5YlFlSitIeUVE?=
 =?utf-8?B?N0VYR2w0YmtJc2VTLy9sM2ZYMVVDNXk3SllodlZOUi95RmlodzVoQ010ckEv?=
 =?utf-8?B?d1JOdzlEeEVTZGU1aCs0cTFvcm81Yy9iYnIrM0VIQnI3VlRWa2owTUdsWFZZ?=
 =?utf-8?B?amtuUUFneXJCbHZyV0lucUtPZHFwNFNidUZKSTc5aDUvWWVpd0lUeS93ZHN6?=
 =?utf-8?B?bi9ra09Wb2NZQmhKQkZpSlVDTzlzYWNLWFNqYXZ6NHNmSzlPdlE5b0J5eERh?=
 =?utf-8?B?aEo0WGFvWFJ3TnFjM0owUi9TdGUxSWxudHJSQkdxbUlSNDVjU29IZFF2UzVF?=
 =?utf-8?B?MGp5SHd0V3NHN0hyd0tDL1FWL2VnSG8rSEIyNktJeXNmSnFDWFVubjJaeVpt?=
 =?utf-8?B?bE5Fa1hwdUNOYi9XMnlFUlEyVDYvMmhEbmZhZVIwY05ObGpiSlR5WDMrbGwz?=
 =?utf-8?B?eEVidWpvOFNTWXVyOUNKem1kL1psMlJiQ3dPKzNQT0prYUozQ0haZ29PdU4y?=
 =?utf-8?B?RzFibHBOUUFLUjFncU5zR3hwYkd0bFYvVXZEaEpzTGZQb2diS1FCVmxFSzZL?=
 =?utf-8?B?a2xNSDFZZmQ5QUNFNzJzd29YWnlmd3BvZHIrdEhNOWpFeXdJM2JKZHNvQUho?=
 =?utf-8?B?cVp0WFdzS1hMZHFwUVFMQ3luejNkOWRPYTdYWUZsQXgrNmtxMTEzbFhqOWd5?=
 =?utf-8?B?bFlRSFVzVDNCTFppajdlUkt0NHdpU05zYU1oUkEvbUpZaktvZFVBZG41RVRk?=
 =?utf-8?Q?Ne0l1PzZm2RY5b7l4YNpi0zL/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69101B030C2E9647A2ECA8A1080EB62E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3acf42-d214-402f-3fe3-08da73a7006b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 10:17:12.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pPotk8vKBQwHimETpNvnzvRp4iSvmn7a2ow5hwo9PZ46EjhXA4Mo+Yp1dLdNTdtbgi6+hNvO6YGM53uBj15LJLii8BC3vjq7rzq0QqGY5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFN1cmVzaCwNCg0KT24gMDEvMDgvMjAyMiAxMDo0MiwgTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSB3cm90ZToNCj4gQWRkIGNvbXBhdGlibGUgc3RyaW5nIGZvciBNaWNyb2NoaXAgQ29yZVFTUEkg
Y29udHJvbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkg
PG5hZ2FzdXJlc2gucmVsbGlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwgICAgfCAxMCArKysrKysrLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWlj
cm9jaGlwLG1wZnMtc3BpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c3BpL21pY3JvY2hpcCxtcGZzLXNwaS55YW1sDQo+IGluZGV4IDczMjZjMGEyOGQxNi4uYjY1ZjRl
MDcwNzk2IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c3BpL21pY3JvY2hpcCxtcGZzLXNwaS55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwNCj4gQEAgLTE0LDkgKzE0
LDEzIEBAIGFsbE9mOg0KPiAgDQo+ICBwcm9wZXJ0aWVzOg0KPiAgICBjb21wYXRpYmxlOg0KPiAt
ICAgIGVudW06DQo+IC0gICAgICAtIG1pY3JvY2hpcCxtcGZzLXNwaQ0KPiAtICAgICAgLSBtaWNy
b2NoaXAsbXBmcy1xc3BpDQo+ICsgICAgb25lT2Y6DQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBN
aWNyb2NoaXAncyBQb2xhcmZpcmUgU29DIFNQSSBjb250cm9sbGVyLg0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeDQooVGhpcyBpcyBhIGNhcGl0YWwgRiBidHcpDQoN
Cj4gKyAgICAgICAgY29uc3Q6IG1pY3JvY2hpcCxtcGZzLXNwaQ0KPiArICAgICAgLSBkZXNjcmlw
dGlvbjogTWljcm9jaGlwJ3MgUG9sYXJmaXJlIFNvQyBRU1BJIGNvbnRyb2xsZXIuDQo+ICsgICAg
ICAgIGNvbnN0OiBtaWNyb2NoaXAsbXBmcy1xc3BpDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBN
aWNyb2NoaXAncyBGUEdBIFFTUEkgY29udHJvbGxlci4NCj4gKyAgICAgICAgY29uc3Q6IG1pY3Jv
Y2hpcCxjb3JlcXNwaS1ydGwtdjINCg0KSSBhbSBub3Qgc3VyZSB0aGF0IHRoaXMgaXMgdGhlIGNv
cnJlY3QgImhpZXJhcmNoeSIuIGNvcmVRU1BJIGhhcyBhDQpzdWJzZXQgb2YgdGhlIHJlZ2lzdGVy
cyBvZiB0aGUgImhhcmQiIFFTUEkgJiB0aGUgc2FtZSBkcml2ZXIgd29ya3MNCmZvciBib3RoIGF0
IHRoZSBtb21lbnQuIFRoZSAiaGFyZCIgUVNQSSBpcyBiYXNlZCBvbiB0aGUgRlBHQSBjb3JlLA0K
c28gSSB0aGluayB0aGlzIHNob3VsZCBiZSBjaGFuZ2VkIHRvIHNvbWV0aGluZyBsaWtlIHRoZSBm
b2xsb3dpbmc6DQoNCnByb3BlcnRpZXM6DQogIGNvbXBhdGlibGU6DQogICAgb25lT2Y6DQogICAg
ICAtIGRlc2NyaXB0aW9uOiBNaWNyb2NoaXAncyBQb2xhckZpcmUgU29DIFFTUEkgY29udHJvbGxl
cg0KICAgICAgICBpdGVtczoNCiAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbXBmcy1xc3Bp
DQogICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGNvcmVxc3BpLXJ0bC12Mg0KICAgICAgLSBk
ZXNjcmlwdGlvbjogTWljcm9jaGlwJ3MgZmFicmljIGJhc2VkIFFTUEkgSVAgY29yZQ0KICAgICAg
ICBjb25zdDogbWljcm9jaGlwLGNvcmVxc3BpLXJ0bC12Mg0KICAgICAgLSBkZXNjcmlwdGlvbjog
TWljcm9jaGlwJ3MgUG9sYXJGaXJlIFNvQyBTUEkgY29udHJvbGxlcg0KICAgICAgICBjb25zdDog
bWljcm9jaGlwLG1wZnMtc3BpDQoNClVucmVsYXRlZCB0byB0aGlzIHBhdGNoLCBidXQgYQ0KDQpk
aWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KaW5kZXggZjQyMDJhMTlmYWEx
Li44ODdiZmVlNWM3YWYgMTAwNjQ0DQotLS0gYS9NQUlOVEFJTkVSUw0KKysrIGIvTUFJTlRBSU5F
UlMNCkBAIC0xNzUyNiw2ICsxNzUyNiw3IEBAIEY6ICAgICAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCiBGOiAgICAgZHJpdmVycy9ydGMvcnRjLW1wZnMuYw0K
IEY6ICAgICBkcml2ZXJzL3NvYy9taWNyb2NoaXAvDQogRjogICAgIGRyaXZlcnMvc3BpL3NwaS1t
aWNyb2NoaXAtY29yZS5jDQorRjogICAgIGRyaXZlcnMvc3BpL3NwaS1taWNyb2NoaXAtY29yZS1x
c3BpLmMNCiBGOiAgICAgZHJpdmVycy91c2IvbXVzYi9tcGZzLmMNCiBGOiAgICAgaW5jbHVkZS9z
b2MvbWljcm9jaGlwL21wZnMuaA0KDQpXb3VsZCBiZSBuaWNlIHRvby4NCg0KVGhhbmtzLA0KQ29u
b3IuDQo=
