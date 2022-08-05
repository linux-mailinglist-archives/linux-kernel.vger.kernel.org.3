Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3868058AA81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiHEMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHEMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:08:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39792316A;
        Fri,  5 Aug 2022 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659701289; x=1691237289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cYwKBOETFoJN437q5gohsWcRwY+TZh49W9L7heWUxBg=;
  b=I5wP8toyOFfUr3StdOZGhMhM0MHaghPugDZ7fX2t5tyBKNRsToG3i1Nb
   Kw8OtSsmwiOT7X3bo8evOe1dKAMo8WmEuol/kyznOnPs0spAAwTQm18u3
   xo9i/YbjBacgMzudi+F+zhl5sN9JJcZjrl7bks4qykdTICzQ1pDhg7+mU
   E6N0/DwEqwbkPokIM4174S/f7Qtu55nlmbgtfmtUIjqGx1MMubg6mjEYc
   OmKdHRzhdNKDepXrKypiXYAwkMAgXhpmESms07LhKNIIGve3qgmWLF1oc
   udUwjmnu4qZzwIAdYfzwUOU7SzqFYzz3bzo/YQsni/d/W846JKVmQgk8l
   A==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="167986799"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 05:08:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 05:08:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 5 Aug 2022 05:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2M/MD8worqUzz6KL4XyMIXdU1txa5f0ObKZmZtl3nzHa1viptDKFZDtwdMxiD3ZyD4bKTW1tGTE9Sj2Jn2Y6pR2envnbLFKLe1L9HC0cX+1BqhNe71n2Aje655nrMvLcFNvnRXntGZ0OjIqya05bb4jFbSGwuwQa57YkNYszhyFh/rI+sZSkK7HQ6AjFiLk/LpbgkxiSV/I0zF/DK6lPeMn77AaGPQLKIK9lWGo2r2irSRr9vmf6GfnCONIto1A56+SFxvepik+HM0dxSPjRmOyhgfoDrXMytVCsIFYuF2O8itILtPkHgZ7zJ0s1sD/InROYWqL8wj1eCW7oEHU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYwKBOETFoJN437q5gohsWcRwY+TZh49W9L7heWUxBg=;
 b=lXuBm72iD/xOBdhrfrZbmUvvuhZ6lMn50EZlfmflqS3suKRoAQb8VEESZ/zLlM6F4mAiRTfgcOJfeu1uknl5e6hvWyplnCVUjABGKF2qvYPZGdX2yxr8Kw37Wc5i03x8IWSDu67WBzb51pp9Dn70YqRxm1ywXr27QrOjbgxQYrHQbXRR6xOQaGn/5JTSm0bnCEM1QWmR1ARvMWqc5eEeRHQvbUVLGi4VsPiA8vPzfLdG64jsb4wDLvi2Ts5UBvSzUZgLvkBxeoou6kOuJ+4xfasjgBYdRh4Aat8oUZdtz81W0WZgQBvbNdPZ8vSQqpONYPoM6iTwx1zVLxYtZUef3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYwKBOETFoJN437q5gohsWcRwY+TZh49W9L7heWUxBg=;
 b=D1njFNgBHUB7fKIzTpgfKSdCTeqDhTZsl6X+HB92m5NJOenFEsNMtUZ1CL49yC2jAU5m0pMzNK0nkuwGxK8RY56n+w6Di0zLwl0ZPwihD8AeiPNMBPQBagpxTLzw2Gu91biytxIE2hYAm1o4Ex8Y7KMr/HF8z6VQ6GsBLc7ARpY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3622.namprd11.prod.outlook.com (2603:10b6:a03:fe::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 12:07:58 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 12:07:57 +0000
From:   <Conor.Dooley@microchip.com>
To:     <broonie@kernel.org>, <Nagasuresh.Relli@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Thread-Topic: [PATCH v3 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Thread-Index: AQHYqIyVvKaNZK9YQE65LRGR8okG3K2gJYqAgAARiAA=
Date:   Fri, 5 Aug 2022 12:07:57 +0000
Message-ID: <4054682e-fc97-377f-9ebf-da99d2f3ec5c@microchip.com>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-5-nagasuresh.relli@microchip.com>
 <Yuz5jZlRLr3pBCcb@sirena.org.uk>
In-Reply-To: <Yuz5jZlRLr3pBCcb@sirena.org.uk>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d5045b-307c-440b-99d1-08da76db2272
x-ms-traffictypediagnostic: BYAPR11MB3622:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yx26Pv0lDPKhT8ZbV7VAxmnb1LnS28w49393fcivFsifpPwUYkKb3RvY65yjjkizp9UDf0DbWDU6+MdDUUZN0fRxJp7J8pXawaRPCr6mNAk3gZKReSardjZVIrV/TidoPjWbsOEcuFfBt/F8yI7/74A7/YuQyNMFpwtBK0mo6d5FsaNQhz5/EG8MUdRW9NTnu+VQXvGucEqRNM4/PozEKQ2GzoWMrVybcenFkEFWMx7MfsmFvXJQ8P+NmW3cEDHYIfMtb16HhXqQB0NluhkOWVC9HtMnb0bpoMxah/p90Wv+sASHMppLnS1GArmXY/S7bzIz38Sm5f25UOYIVUT8i/xbZq5h9N902EhnHwNnHFSyPNHFtYfO/w9SWJdcDMcgNMHeJwxX9sEwxlcX2dqIb7j0w8o/gmVqSqRZkcb9+TM3RRUTP+TV+VfhucoVHTwyNokWT7JxxHWziSWmbXD+34EEVaB+5+xR4LlH7IwgdQnlRy7ril1I4zHmSbOdbWfKSgbxmsp+HZSGwstGlAMAW2/2YhIZePjmj8Y6wJ/31X/XoeIBuaPKLfaTXkqWA2YHsp3K+53HDJApGsgqdLavPYIqwL0OHA7DySXKexqsFakbILIeDYYRG2AjKSXysxeS1GgcEOkFN15KQKUjWa0ZyT2h6RG6eTDlSirvVgsS9u+uhToHMMYOYNpcl5WUQOJLFfzH0lE8/jUz1E+suDq+MuSZcbKiYH6eOpqdR7/XwY2N2NUNGeTrVchpCdIkHf1fj4CGPAwoGu2mOuno3PQVJaMVH15A4/opUiQ6iim5ubrjh59uaSxd7rOhqKRJJ0KLGOyq7wZVXPFIr7Sy+ZlDKcRS4xhCt/Kd8aekm/XJHvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(346002)(396003)(66476007)(66556008)(66446008)(66946007)(64756008)(8676002)(5660300002)(76116006)(316002)(91956017)(8936002)(4326008)(4744005)(2906002)(6636002)(122000001)(38070700005)(36756003)(31696002)(86362001)(38100700002)(478600001)(6486002)(41300700001)(71200400001)(54906003)(110136005)(107886003)(53546011)(83380400001)(26005)(6506007)(6512007)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmZWblVBZVpybitYS2JkckFvT2NwTEhPWkVFczhXNnlqcmlUaE5tM01lN3F2?=
 =?utf-8?B?NUlzOXlHcnlVWVdkSHVyMnFCZmJvM0hFRUIrV0RhMVF5b0pNcFlpYVZ4NVpQ?=
 =?utf-8?B?VzhLc3MxM2tXZjNoUjFyNU9WU2pyMVBDOSs5TE5kK3h4ai84UmdhL3k3amdo?=
 =?utf-8?B?YmFyOVhkRUczWkNvNk11RCs3T2J5UEhkb09HQUgzMWJhTUVQOC9LZHNTcWtP?=
 =?utf-8?B?d3B0OEVoR1FZREsyZjAyRWl6dGlURFhBbG5Ic01kZGZ2ZVkydTlyOW56Y3c4?=
 =?utf-8?B?NnlPY3RmTFlsTmlJenFHKzlwbU5GUkMxeWEvaE9nMEY1bDVTUTRKZXhrZi94?=
 =?utf-8?B?WHRnN1pmODJlTmlsT1JTcVhVUHRtQ0dKL1krYXhoWkRQZlBVQVpFdlgzTGVK?=
 =?utf-8?B?SmJlUjFoWXI1NVpramdIMkNOOUpwNFJGNHY2S3QxSWl0NTdDRGRwakp2MURt?=
 =?utf-8?B?emlCUktUbC8vZHY4bFl3d0t3dmowYjNaeHRkRldqNVlLeHNBZmM5anc2SkRW?=
 =?utf-8?B?WmU2cm9zQ1JkbiszVVNYWlM2aGxhdm4vMk1RRTlyeE4xSXg2aG1jcVJtRTdN?=
 =?utf-8?B?Q1hwblUyVVJrOFdTSjg3SEN4aUpETFRqVGNVcDVjQWdLN2VGSkppcGlQR2tB?=
 =?utf-8?B?djZJdXNqLzRmejYwaHllZCtGREZBZG85Ylc5alJJdHVDbVAvOVhKeWFwekZ5?=
 =?utf-8?B?cE9QUStQdHVQOEM3QTdzN3JjanB1Tk8xdU1Va21wajhaV2cvbStnajRHbUth?=
 =?utf-8?B?UHZONjhFS3Z3eWxSTGVjTlVUUWpVbFBsNEtJQXpjKzhzSHlQZktiTFZmSm4y?=
 =?utf-8?B?STZ0VGNqTVZPQ3MxcGFMSXhZZzVCbHVNSmRSV0s0eDc0cnB1SGVKVW9NeWxv?=
 =?utf-8?B?T3N5SitsbUZiSWRLV3V2dEg5NGxUK0NwOG5uek9aQStkNW5JQjlob2lIOVky?=
 =?utf-8?B?MXRjKzRRZTNyREs2Wk1BSk5vb1pIVklGOFNvcmMwcDZSaWNmN0VoSW51UFNp?=
 =?utf-8?B?STM2bWRQcjJCY0ZMNHdHYjZkdEpzK2c3RFRBeGh2SGpIVjJ6RUQyckp4Wmxa?=
 =?utf-8?B?Y3E0c2dQY1BVbTh3K2t6YjR3enQ0UkpnUVhUSVN4UnRQb2oxcmF4c3VlWWJN?=
 =?utf-8?B?SWxRSmN0QS91WERQVzdBeHFTOEIvenA0bVFMUEpVeXNtRWZPemkwMUw3K2Z3?=
 =?utf-8?B?OW5jUmIrS3BZbUdpY1pLQWR3NEU1aU91WVVPeXIxM3JwZVdKRDR1Q1J5eExz?=
 =?utf-8?B?WFpxc251d3NYQXdqaGFkV2V2dGpRMklLcVlzeHQyVDhMNDMwMWZ2SmtCSGtZ?=
 =?utf-8?B?SnY0NkF5c1hIRjBqdFJGUDFSK0FaK2kyNm9jM0tsSGswY0wydlJtQm1mU2RB?=
 =?utf-8?B?c2RPdXZQcm96N3dwQW5VZ3pKVzJESFJiWWdZZWFZY3ZKbDEwUEhrQ1d4aUNj?=
 =?utf-8?B?ZjNaQUt1REpqdkt4QkpGWG5ha2ZqM2dQK2ZTS0R6L2tDZEhSL2xuL0loWTFu?=
 =?utf-8?B?dTRXdDZRY3JiRWNMdzFKSmNXTnN3aGh3emc2NnV3RnVjRU5ULzROR0dGV3RX?=
 =?utf-8?B?b3FkMnQyUFZrN0tVY0NOWEYzdkM0SkE5MzJONlhSQldhRUJkYjBGbXFub1ky?=
 =?utf-8?B?c2EvSFUvQm9maGxtbC9ULzlsL0RISWMzWWN5NituWjRFV3NiYWJSUHE5eUw3?=
 =?utf-8?B?c0FlaExGa01IRnNsM21lVC9Beit4cHBuRVRSQis3QVlkWmRSRHE3UHZtUndu?=
 =?utf-8?B?LzJYSmRzUHZaMWRuYy9PV01CVllOYnVyZnRzeStQbTArZUJmODVsVDZOTFNk?=
 =?utf-8?B?NGpCTDR1eG8zd2RITUdJSU5UUE42ZlV6V1gzbUlTclVCMmtEeTA0bGxjV1F3?=
 =?utf-8?B?TjNwYU44c2FIa1VMUy9ITFlpRE9lTnpRZFR0SmFRZnpESFdOR2JZWXJFczVi?=
 =?utf-8?B?Q01vSlpxYjBVMmYxN0x2UlI3MjYrZC9BbEIrbVVYUmdVQm9kVDVpWXJYRG1G?=
 =?utf-8?B?U1g2cDVmSlduK29Sd2dzazZabkZ3Rk1vM01Cb0RmUnF1K3lXWGdKeXhLSFR2?=
 =?utf-8?B?dUZIeUxUNG84YytNYnI3alk3Y1U1azBYWlFLS21wYnhMVmlzQ05RR2hud2tK?=
 =?utf-8?Q?I5KtpwsNVEYr0ndznBOQhTQwi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDE465F3FFF0D04BB376D51E12A2CCB9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d5045b-307c-440b-99d1-08da76db2272
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 12:07:57.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgaaVjjHJPFVFtz9W6t1lYVXTEHeZxzCxl6xqwn34P8ZnucO9IXjFWesOGtlRuPz3O7tMUmkAsm/YOJcEGAgbpkM8epkizp8EbNgp5g9C04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3622
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDgvMjAyMiAxMjowNSwgTWFyayBCcm93biB3cm90ZToNCj4gT24gRnJpLCBBdWcgMDUs
IDIwMjIgYXQgMTE6MDA6MTlBTSArMDUzMCwgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToN
Cj4+IEFkZCB0aGUgcXNwaSBkcml2ZXIgdG8gZXhpc3RpbmcgUG9sYXJmaXJlIFNvQyBlbnRyeS4N
Cj4gDQo+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4gQEAgLTE3MTQ2LDYgKzE3MTQ2LDcgQEAgUzoJ
U3VwcG9ydGVkDQo+PiAgIEY6CWFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwLw0KPj4gICBG
Oglkcml2ZXJzL21haWxib3gvbWFpbGJveC1tcGZzLmMNCj4+ICAgRjoJZHJpdmVycy9zb2MvbWlj
cm9jaGlwLw0KPj4gK0Y6CWRyaXZlcnMvc3BpL3NwaS1taWNyb2NoaXAtY29yZS1xc3BpLmMNCj4+
ICAgRjoJZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLmMNCj4+ICAgRjoJaW5jbHVkZS9z
b2MvbWljcm9jaGlwL21wZnMuaA0KPiANCj4gWW91IHNob3VsZCBhbHNvIGFkZCBhIHBhdHRlcm4g
Zm9yIHRoZSBEVCBiaW5kaW5nIGhlcmUuDQoNCkFsbCBvZiB0aGUgYmluZGluZ3MgZm9yIHRoZSBw
bGF0Zm9ybSBzaG91bGQgaGF2ZSBlbnRyaWVzIHRoZW4NCnJpZ2h0PyBJJ2xsIHNlbmQgYSBzZXBh
cmF0ZSBwYXRjaCBhZGRpbmcgYWxsIG9mIHRoZSBtaXNzaW5nDQpiaW5kaW5ncy4gSSBoYXZlIGEg
ZGVmZXJyZWQgY2hhbmdlIHRvIHRoZSBlbnRyeSB0aGF0IG5lZWRzIHRvDQpiZSBzZW50IHRvIEFy
bmQgYW55d2F5IHNvIEkgY2FuIHF1ZXVlIHRoZSB0d28gdG9nZXRoZXIuDQpOb3RoaW5nIHRvIGJl
IGdhaW5lZCBieSB3YWl0aW5nIHVudGlsIHRoaXMgZHJpdmVyIGxhbmRzIGluIDYuMSsNCnRvIGhh
dmUgTUFJTlRBSU5FUlMgY292ZXJhZ2Ugb2YgdGhlIGJpbmRpbmdzIDopDQoNClRoYW5rcywNCkNv
bm9yLg0K
