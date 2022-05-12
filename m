Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB04E525154
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355979AbiELPc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355676AbiELPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:32:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35622A2D3;
        Thu, 12 May 2022 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652369573; x=1683905573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XNttvMuXR+n39o5Zk5pqEds1sM6V09mf7W9yX8GxicY=;
  b=BL45Sh/J6LrVvdfSKsvgRT0Z6IlRE8dm2QRqhdzr+UBWwxakNM0Tqhf4
   6WD/cKXYbSl1fDig0pRiqssaMEyQbWpQCzdSsOx6b5N8dOUJA2GWqnrWf
   UGAU7jAGrUrgEc6eSfU5/BpGX67zB//jkQCK1wiYfy88tWhC75dIRq7sW
   VWOIQPiCvcizLsnNACkHRS5d8MxHwOxvfV3asqyF19Ar8J1NxjqP0yhPZ
   H9azST7tw2Oxo+2n6qRPWxX+4Iej3qsA3w/6dbHeyTKhUBR06lPLEWcgV
   CVhepIk/T2MWO6/0/pe68FDjisJ493z7mcr0lMNlcUykdSUvIMo/QcPiw
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="163417580"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2022 08:31:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 12 May 2022 08:31:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 12 May 2022 08:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2tvHzqe2SPyn0JGpwHLwOytbgNrCFYVj2q63HHNjNIGLfvnpuqVgrMll7dncpBO4Lu1gJEP28F8qmWQ7ddjIsWryh2143Gjs0l+pJDU54TJU4EGL8kafZ4cEwRvjth9rsStR/MH+ybOpi3LdLMhJyojH34NrOxnVvrYYv5mxieYMOVYJLK2VKY18SFUQsbksV5auirGW9S5DjiHgHrZovXMgi3zk/pV8td2nbeKpM11a8+a2JRY7B56zlnMlfg0Sd7XbQBRUwe95/GnGNzmYgseUhkvzy7kiMDCtJ/QvKbthjbftke0/CsR+cloLCxwZCy3mYCwty7f8tt3nc/Nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNttvMuXR+n39o5Zk5pqEds1sM6V09mf7W9yX8GxicY=;
 b=Q8mcN+L9Pdaocqb1m9sXqOPRJNm6iPubv9DA9InKrL/qvAb32pP7UMesHETu/0AzVITAkX1ggTcZ9rZ5Bah7cHVEbmVUlgAjoMSJAGvW6NIPDCi/uzSXV/t1JlhKqEcSzeq+bVy/NukIZyKOrNBra7VkEuugViAuaK31zYKSppBdV9XPqF/UKRAK542tPTKJcH52jYKz7TjCjtmGYC4WeSjj+ub1kAenRHd9qaVDBsxAI4dNgsBmvcNN9qB+pxzB0Jw1JOvT8tzQTiy3p/ykNb/EDi16uvKgr5+kBIq6yzE2Vu/zq5CJ+CwEF84Vfllam+ZBDaUzBw1hSTrzal9h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNttvMuXR+n39o5Zk5pqEds1sM6V09mf7W9yX8GxicY=;
 b=nuN3vmpItluGC/xBc5eerFGN3mGZoK37uIlLyGoqTxZYEVN8TsFY9aL3ValU0GMKbu0YGy77GbgpcMPPyNjCKxbg4DSt3+aNa/5CIhsNIz+bePysAnyQ638igTsaRdHJUf0fQSjWXFg24QcKqfWQMJdqwtqv+n+n2SFElgF0Uaw=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by BN6PR11MB1427.namprd11.prod.outlook.com (2603:10b6:405:8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 15:31:31 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 15:31:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Topic: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Index: AQHYZdBf287PvcEoQUmQslcb1o7LPQ==
Date:   Thu, 12 May 2022 15:31:31 +0000
Message-ID: <59b47f0b-6201-3814-e17f-1435ce5c2dad@microchip.com>
References: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
 <20220510094457.4070764-2-claudiu.beznea@microchip.com>
 <75ce6291-77c7-c932-e8bb-a8bbae02431d@linaro.org>
 <c840c598-0413-5f40-0807-e3c314531f0a@microchip.com>
 <b5c586de-a3ae-0774-e0bf-e21852b65fa9@linaro.org>
In-Reply-To: <b5c586de-a3ae-0774-e0bf-e21852b65fa9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbe84234-e7ff-4c06-e872-08da342c7d72
x-ms-traffictypediagnostic: BN6PR11MB1427:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1427E11C771D8D3A05AE342387CB9@BN6PR11MB1427.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yivKVFxPhmTHQnSPLD4srk2uTgqdSCZ9WCDkmNwS63Vu2J7gjnScL2Rrna/VLoFNvgfe+PCREwuz5sjs9P9A9yjzifEU8d68yuUFUAEd/WStJIL7+g8MdSsNsUiJXhVLIWP1hI9GaZ7tE8p0se5vbuyyxSMdtBcS1D9VbFDhzkIgbn1ft9T59wUOdHQruy/dJlmVP/7LRu0lm6Ofxc0phv+do0oQRSZEzEO0EOf+XnIQOQ5fydB2nk8UrT7UbsZkKjquv5D/iDi8/Wvqu112Ub3nHCeVyXf5TN+dxCpFw5iXiYd28ZRsp1MTbE5IoA3u0h782oHfDjN2f6lYTP2UpaJo3/zOth3oiSxyzxjqwEPR9JVQlDevRXyrkEx5V+hTNJSC0BuNQWM+8SfVOCSMasMLrJNXwoRNzGRtZRW0QUTCykvBH1kXeaJ82UNInSVQAoQHPMR+32G+8cG9klXmaSylv6h4W0w4CYrHBDs+OvDdo6KBiJZbKFIUCl2IVcvGAJRFauzmzxbAomZQwLWuV8Xxy6N1BFyy8FVDmSTMybMyIA8hn+Ce/iFQei7Hg43WD+5G5kSUoiZGG1j7uLnyhIBpbRo40sWjLrmvmxc4vYCUKTgv9/i3i7+1i/ZvowHV41Hne7wHiViMdNl1EK+R2H2grl6XNzfS1TJuieihPRW/15eKHR3w9n2jerkPoBXj7Mrrtur6XHnMDsFpQ3UpEgzgTFks/Uw5r6qDDTl58maq6AsXcpbKcJS0KLnAJPDsIsjCG7/tRl9ALkzWOxkB5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6512007)(508600001)(38070700005)(2906002)(38100700002)(122000001)(53546011)(31696002)(86362001)(6506007)(186003)(26005)(6486002)(71200400001)(5660300002)(66946007)(8936002)(76116006)(66446008)(66556008)(8676002)(64756008)(4326008)(66476007)(91956017)(31686004)(110136005)(54906003)(36756003)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUNHUGZWajRqbTc5eTI4UDJBWmg1TFRDc2QyNEQyekwxRlE4b2lpMmdwbFpk?=
 =?utf-8?B?RWdrSE1VQ2lMUUVkMnBwMDV2anZjV3lJcTBhVVVJSm5ZRkFRWlFUZmFZRElq?=
 =?utf-8?B?NE1XSHdNV1pjcFh0aUExT1o0NXJGMFJQSWdqWmYvRmk2UE8xcDFKNDRkcWl4?=
 =?utf-8?B?UmE0T2F5VnJKMm5QOWpKa0dFZFdRWU45T2kxSnpTZ08xRUtBSVl2L0tUeFNO?=
 =?utf-8?B?Ry9BZkRhRlk4cU1vamR0NVJSV0M1TkNHNjRzd0xRQVRBRHFBSnMzam9TVXB5?=
 =?utf-8?B?aHdZUjlWUE9DUjV0ajJ6Q0dYcGhyNUlBc3BIS2JEZ2ZvODdQNWZzdDNtQjFW?=
 =?utf-8?B?WXVsYnIxNE5UczVGelZBMmFtWUhSNUIzWUNFWWhwa1VhQy9zUWw4UWdDZ2Uy?=
 =?utf-8?B?bVh0Q1BqTTFuek5EMEdnSEtNYmQranhrcFNsRDBraStqRnh4ZFpFU2ZlWmlO?=
 =?utf-8?B?RVZRUFNzVkMrOUowK1NSSVdNejZpckc3dTUyVnNoYUdrYkU4amE0aVpvS0VB?=
 =?utf-8?B?WTQ1cTlWZmVFZlc1aXE1N1AvQzhxMkJmZUhmWEprRzdTaHkzS1JaaGFENTBl?=
 =?utf-8?B?QisrSHo1MTIvc3FHZ1Z1bzQwZEpEWVBMN3hMa0EwOTJuTEkxVHRsRHR2MnhH?=
 =?utf-8?B?SU1MaXU5Nkp3T0V5RGt4QXJOUVJuZkJkdFBaYkZrajZlbGZFME5IcGk0NEwz?=
 =?utf-8?B?Y1hzVlQzWlBMdFBKNllvV3piUGFMR2dlaGw2aHJKcE5MOEtZUTFGbTNzWVkr?=
 =?utf-8?B?WnhQN2RjWlBEMWdvakFVK2NyK213VVB1RkYwblYvRFphZTVLeWhBTzVlSU5Y?=
 =?utf-8?B?SGEwZE1WSGFLL3NZSGs3c2FLVkp5SVJuTGJmVExsc2JvLzd2alhoeUpiREF0?=
 =?utf-8?B?YkRpTFdaV0FVTFArVEtwOFpTcjJNSWlUUW5HMEJJQmlTSjBINmJzbGsvMlNB?=
 =?utf-8?B?R1paVUlrNHR5eVpQUzZjYkllYytWSk9iUlozVXdxWkhGeUNzbExLczdtNGZF?=
 =?utf-8?B?ZFBGY1hoQ0NZcUV1OTJwT05sNHNXclhzZ00yT0tGMTIvN1hXeEl3M2ROZjVh?=
 =?utf-8?B?a2RmSGZXL0pleFZzMi9zaDRsNThkZzA4ZEs1TGd2S1NGOFAwdDFSdVVCNlNr?=
 =?utf-8?B?aGNSWEdBd0VhUDRtTThGa0twcjBDMjZ2NUprZ1VOK0VpZC8xdTlQazI4MVRI?=
 =?utf-8?B?Sy8xMEFicXhiV050Tis2Qk05UUc0VEE0bG05UWVtUnVDbEpiSWZhalZKV2Q0?=
 =?utf-8?B?SFRKSnorc0Z3K3NyUGFZK3U1Y3h5Q3UrTTJjQkVxbU50VHdReHIvNlB1eGFB?=
 =?utf-8?B?UFNBRHJpRU4welRBNXBvKzdtMDFiSkhyQmloOE9WMUYzWHQxenNJYmxKREhm?=
 =?utf-8?B?dENLTitUVTJ0TXFEb0w5Qnc5Q3lwM1JzOFgzQU4xOFZ2blB6MzNBa3VKeC9v?=
 =?utf-8?B?YWxCNHZ0L0pvNk5jd3Iyd1h5ZHR6TGV0SElub1lqcXlXeEowdjE1MWdFUEVs?=
 =?utf-8?B?eDJaVmdRa05GdFVscHlycndndWw5Q29CZlZCdWl0RjN6UU1VTW9TNTZlZENj?=
 =?utf-8?B?ZzRTV05LdTNjN0piSE01Q21FVUYzVUV0RnZCUHBKa2Y5SlMwbGJLQTZXVGlL?=
 =?utf-8?B?SEdDUEU5TEd1M3dZd1J1ZTd4RmQwdjl2UjIyeGFXYjFYY2J6Z1BpRG5pWGV3?=
 =?utf-8?B?RGhYVnArbjBtYmxIQTVoMVJEZk1jWjg4Vzd1UWRMSlp1NTNVK2YzYU9uM0J6?=
 =?utf-8?B?M241dnFGU2ZhZk02aGdyZExGM3RiZnpiTFNMRmNFS1RrazZlc25HbnhMRCti?=
 =?utf-8?B?S1FaUXNidlUrYmkrNWd4YnBuZ3QvVm5xay9WYUFtWnZHN1ZXN0FqWVZycEtv?=
 =?utf-8?B?MVRqa0FZQ3ZVTVkrVG82N3ZlQ2JVek90TjhyTEJRbjNBbGRrZi9WdDFWbTlr?=
 =?utf-8?B?WkpBTnlveVhzSDJmWnZsaWJUK21renhtNklKSEdkaG9qOHEzV1p1bXZkN3Jp?=
 =?utf-8?B?RTg5ZERiU0x0dm91ZzNhQURPS0hQUy9kTFR5OGsrTndhTlNSa05ZSG9yNm5k?=
 =?utf-8?B?enBkRFQvV0hxUlJEQ1FpOGM2ZDhpekFXMXg4RG5SOHVhWW1hOTU5c1FVTTNp?=
 =?utf-8?B?S0tWazJDTGgzOWFKelh1RVdiRmVsUGdUUmhKSEV6MDdBWUVZc1pkNUl1a3BI?=
 =?utf-8?B?bUVCVnpuSU9BMDJlWUREKzh6SXo4VDJMK1BDYXQvR1ZVYlVxYTZselZMWEt4?=
 =?utf-8?B?VWFrMnRUc2FGTGhtUm1qVk00MFk2NTEwOXNKbWkzVEJyZVFmNUxpSDRxWlRv?=
 =?utf-8?B?N2Zra1VJS29IK0FRK2dqU015U3ZOdlpzMnh2dWZYSFVwdHc4NzgxNkxLYUtp?=
 =?utf-8?Q?wW2GgDC0UWMVKVNk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD9E35BA6811DF4A90619D77F395530B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe84234-e7ff-4c06-e872-08da342c7d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 15:31:31.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDaYnU6tkxmZdnzqNVfw9D366tpXurIsxODFdFc76j2DGuWy/KsT74rdotxtlcRSI2cVpPYXcpMP1w5yAq0aFEIcMLBtF+BaEtsrMDsmN00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1427
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDUuMjAyMiAxMDo1NCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMi8wNS8yMDIyIDA5OjE3LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+DQo+Pj4+ICsNCj4+Pj4gKyNp
Zm5kZWYgX0RUX0JJTkRJTkdTX05WTUVNX01JQ1JPQ0hJUF9PVFBDX0gNCj4+Pj4gKyNkZWZpbmUg
X0RUX0JJTkRJTkdTX05WTUVNX01JQ1JPQ0hJUF9PVFBDX0gNCj4+Pj4gKw0KPj4+PiArLyoNCj4+
Pj4gKyAqIE5lZWQgdG8gaGF2ZSBpdCBhcyBhIG11bHRpcGxlIG9mIDQgYXMgTlZNRU0gbWVtb3J5
IGlzIHJlZ2lzdGVyZWQgd2l0aA0KPj4+PiArICogc3RyaWRlID0gNC4NCj4+Pj4gKyAqLw0KPj4+
PiArI2RlZmluZSBPVFBfUEtUKGlkKSAgICAgICAgICAgICAgICAgICgoaWQpICogNCkNCj4+Pg0K
Pj4+IERvIEkgZ2V0IGl0IGNvcnJlY3RseSAtIHRoZSBvZmZzZXQgb3IgcmVnaXN0ZXIgYWRkcmVz
cyBpcyBub3cgcGFydCBvZiBhDQo+Pj4gYmluZGluZz8gWW91IHdyaXRlIGhlcmUgImlkIiwgaG93
ZXZlciB5b3UgdXNlIGl0IGFzIHBhcnQgb2YgInJlZyIsIHNvDQo+Pj4gaXQncyBjb25mdXNpbmcu
DQo+Pg0KPj4gSSBhZ3JlZSB0aGF0IHJlZyBzaG91bGQgZGVzY3JpYmUgdGhlIG9mZnNldCBpbiBP
VFAgbWVtb3J5IGFuZCBpdHMgdGhlDQo+PiBsZW5ndGggZm9yIGEgY2VsbC4NCj4+DQo+PiBIb3dl
dmVyIHRoaXMgT1RQIG1lbW9yeSBpcyBvcmdhbml6ZWQgaW50byBwYWNrZXRzICh0aGlzIGlzIGhv
dyBoYXJkd2FyZSBpcw0KPj4gZGVzaWduZWQpLCB0aGUgMXN0IG9uZSBiZWluZyB0aGUgYm9vdCBj
b25maWd1cmF0aW9uIHBhY2tldCwgdGhlIDJuZCBvbmUNCj4+IGJlaW5nIHRlbXBlcmF0dXJlIGNh
bGlicmF0aW9uIGRhdGEuIEF0IHRoZSBtb21lbnQgTWljcm9jaGlwIHByb3ZpZGVzIG9ubHkNCj4+
IHRoZXNlIDIgcGFja2V0cyBpbiBPVFAgbWVtb3J5LiBCb290IGNvbmZpZ3VyYXRpb24gcGFja2V0
IG1heSB2YXJ5IGluIGxlbmd0aA0KPj4gdGh1cyBpdCBtYXkgY2hhbmdlIHRoZSBvZmZzZXQgdGhl
IHRlbXBlcmF0dXJlIGNhbGlicmF0aW9uIHBhY2tldCByZXNpZGVzDQo+PiB0by4gSWYgdGhpcyBo
YXBwZW4gYW5kIHdlIHVzZSBvZmZzZXQgYmFzZWQgYWRkcmVzc2luZyBpbiBkZXZpY2UgdHJlZXMg
dGhlbg0KPj4gdGhlIHNvbHV0aW9uIHdpbGwgbm90IHdvcmsgYWxsIHRoZSB0aW1lLg0KPj4NCj4+
IE9UUCBoYXJkd2FyZSBpcyBkZXNpZ25lZCB0byB3b3JrIHdpdGggcGFja2V0cy4gRm9yIGEgcGFj
a2V0IGJlaW5nIGluIG1lbW9yeQ0KPj4gYXQgb2Zmc2V0IDB4MEUgYXMgZm9sbG93czoNCj4+DQo+
PiBvZmZzZXQgIE9UUCBNZW1vcnkgbGF5b3V0DQo+Pg0KPj4gICAgICAgICAgLiAgICAgICAgICAg
Lg0KPj4gICAgICAgICAgLiAgICAuLi4gICAgLg0KPj4gICAgICAgICAgLiAgICAgICAgICAgLg0K
Pj4gMHgwRSAgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgPC0tLSBwYWNrZXQgWA0KPj4gICAgICAg
ICAgfCBoZWFkZXIgIFggfA0KPj4gMHgxMiAgICAgKy0tLS0tLS0tLS0tKw0KPj4gICAgICAgICAg
fCBwYXlsb2FkIFggfA0KPj4gMHgxNiAgICAgfCAgICAgICAgICAgfA0KPj4gICAgICAgICAgfCAg
ICAgICAgICAgfA0KPj4gMHgxQSAgICAgfCAgICAgICAgICAgfA0KPj4gICAgICAgICAgKy0tLS0t
LS0tLS0tKw0KPj4gICAgICAgICAgLiAgICAgICAgICAgLg0KPj4gICAgICAgICAgLiAgICAuLi4g
ICAgLg0KPj4gICAgICAgICAgLiAgICAgICAgICAgLg0KPj4NCj4+IHJlcXVlc3RpbmcgZnJvbSBz
b2Z0d2FyZSBkYXRhIGF0IGFkZHJlc3MgMHgxNiAodGhyb3VnaCBPVFAgY29udHJvbA0KPj4gcmVn
aXN0ZXJzKSB3aWxsIHJldHVybiB0aGUgd2hvbGUgcGFja2V0IHN0YXJ0aW5nIGF0IG9mZnNldCAw
eDBFLiBTYW1lDQo+PiB0aGluZ3MgaGFwcGVucyB3aGVuIHJlcXVlc3RpbmcgZGF0YSBhdCBvZmZz
ZXQgMHgwRSwgMHgxMiwgMHgxQS4NCj4+DQo+PiBUaHVzLCBhcyB1bmRlcmx5aW5nIGhhcmR3YXJl
IHJldHVybnMgdG8gc29mdHdhcmUgY2h1bmtzIG9mIDQgYnl0ZXMgdGhvdWdoDQo+PiBkYXRhIHJl
Z2lzdGVycyB0aGUgZHJpdmVyIGhhcyBiZWVuIHJlZ2lzdGVyZWQgd2l0aCBzdHJpZGUgPSA0LiBU
aGUNCj4+IE9UUF9QS1QoKSBtYWNybyBleHBlY3RzIHBhY2tldCBpZGVudGlmaWVyIChzdGFydGlu
ZyBmcm9tIDApLCBtdWx0aXBsaWVzIGl0DQo+PiBieSA0IHRvIGJlIGFibGUgdG8gcGFzcyB0aGUg
TlZNRU0gc3Vic3lzdGVtIGFjY29yZGluZ2x5LCB0aGVuIHRoZSBkcml2ZXINCj4+IHdoaWNoIG1h
bmFnZXMgYSBsaXN0IG9mIHRoZSBhdmFpbGFibGUgcGFja2V0cyBkaXZpZGVzIHRoaXMgdmFsdWUg
YnkgNCBhbmQNCj4+IGdldHMgdGhlIHBhY2tldCBJRCBhbmQgdGhlIHByb3BlciBvZmZzZXQgaW4g
bWVtb3J5IGZvciB0aGUgcmVxdWVzdGVkIHBhY2tldCBJRC4NCj4+DQo+PiBUaGUgaW50ZW50aW9u
IHdhcyB0byBoYXZlIHRoZSBPVFBfUEtUKCkgbWFjcm8gaGVyZSB0byBiZSB1c2VkIGluIGRldmlj
ZQ0KPj4gdHJlZXMgZm9yIHNpbXBsZXIgd2F5IG9mIGRlc2NyaWJpbmcgZGlmZmVyZW50IGNlbGxz
IGluIHRoaXMgT1RQIG1lbW9yeS4NCj4+IEFsc28sIHVzaW5nIE9UUF9QS1QoKSBhYnN0cmFjdGlv
biBsb29rZWQgdG8gbWUgY2xvc2VyIHRvIHRoZSByZWFsaXR5DQo+PiAoYWx0aG91Z2ggdGhlIGNv
bXB1dGVkIHZhbHVlIGlzIG5vdCByZWZsZWN0aW5nIHRoaXMsIGl0IGlzIG9ubHkgYW4NCj4+IGFi
c3RyYWN0aW9uIHRvIGJlIGFibGUgdG8gcGFzcyB0aGUgTlZNRU0gc3Vic3lzdGVtKS4NCj4+DQo+
PiBXb3VsZCB5b3UgcHJlZmVyIHRvIGhhdmUgcmF3IHZhbHVlcyBpbnN0ZWFkIG9mIHVzaW5nIHRo
aXMgbWFjcm8/DQo+IA0KPiBNYWNybyBpcyBhIG5pY2UgaWRlYSBpZiBpdCBjYW4gYmUgc3RhYmxl
LiBJIHVuZGVyc3Rvb2QgdGhhdCBsZW5ndGggb2YNCj4gcGFja2V0cyBkZXBlbmRzIG9uIGhhcmR3
YXJlLCBzbyB0aGlzIHBhcnQgY291bGQgYmUgc3RhYmxlLiBCdXQgd2hhdA0KPiBhYm91dCBudW1i
ZXIgb2YgcGFja2V0cywgc28gdGhlIE9UUF9QS1RfU0FNQTdHNV9URU1QX0NBTElCX0xFTiBiZWxv
dz8NCg0KVGhlIE9UUF9QS1RfU0FNQTdHNV9URU1QX0NBTElCX0xFTiBoZXJlIGlzIHRoZSBsZW5n
dGggb2YgdGhlcm1hbA0KY2FsaWJyYXRpb24gcGFja2V0LiBUaGlzIGxlbmd0aCBpcyBmaXhlZCBh
bmQgd2lsbCBub3QgYmUgY2hhbmdlZC4NCg0KQWZ0ZXIgdGhlc2UgMiBwYWNrZXRzIChwcm92aWRl
ZCBieSBNaWNyb2NoaXApIHVzZXIgbWF5IGZ1cnRoZXIgZmxhc2ggYW55DQpudW1iZXIgb2YgcGFj
a2V0cyBhbmQgdXNlIHRoZW0gYXMgdGhleSB3aXNoLg0KDQpEcml2ZXIgaXMgaW4gY2hhcmdlIG9m
IHNjYW5uaW5nIHRoZSBOVk1FTSBmb3IgdGhlIGF2YWlsYWJsZSBwYWNrZXRzIGFuZA0KcHJlcGFy
ZSBhIGxpc3Qgd2l0aCB0aGVpciBJRHMgYW5kIHRoZWlyIHN0YXJ0aW5nIG9mZnNldHMgaW4gTlZN
RU0gbWVtb3J5DQpzdWNoIHRoYXQgd2hlbiBpdCByZWNlaXZlcyBhIHJlYWQgcmVxdWVzdCBpdCB3
aWxsIGJlIGFibGUgdG8gZGVjb2RlIHRoZQ0KcGFja2V0IG9mZnNldCBiYXNlZCBvbiBwYWNrZXQg
aWRlbnRpZmllci4NCg0KSW4gY2FzZSBkaWZmZXJlbnQgbnVtYmVyIG9mIHBhY2tldHMgYXJlIGF2
YWlsYWJsZSBpbiBOVk1FTSBmb3IgZGlmZmVyZW50DQpraW5kIG9mIHNldHVwcyAoYm9hcmRzKSB0
aGVzZSBjb3VsZCBhbHNvIGJlIHJlZmVyZW5jZWQgaW4gYm9hcmQgc3BlY2lmaWMgRFQNCnVzaW5n
IE9UUF9QS1QoKSBtYWNybyBhbmQgd2l0aCBwcm9wZXIgbGVuZ3RoICh3aGljaCB3aWxsIGRlcGVu
ZCBvbiB3aGF0DQp1c2VyIGZsYXNoZWQpLg0KDQo+IFlvdSB3cm90ZSAiQm9vdCBjb25maWd1cmF0
aW9uIHBhY2tldCBtYXkgdmFyeSBpbiBsZW5ndGgiLCBzbyBpdCBjb3VsZCBiZQ0KPiBjaGFuZ2Vk
IGJ5IE1pY3JvY2hpcD8NCg0KWWVzLCBiZXR3ZWVuIGNoaXAgcmV2aXNpb25zIGl0cyBsZW5ndGgg
Y291bGQgYmUgY2hhbmdlZC4NCg0KPiANCj4gT25jZSB0aGlzIHZhbHVlIGlzIHN0b3JlZCBpbiB0
aGUgYmluZGluZ3MsIGl0IGlzIG5vdCBzdXBwb3NlZCB0byBjaGFuZ2UuDQoNCkkgYWdyZWUhDQoN
Cj4gDQo+Pg0KPj4gQWRhcHRpbmcgdGhlIHN1YnN5c3RlbSBmb3IgdGhpcyBraW5kIG9mIGRldmlj
ZXMgaXMgYWxzbyBhbiBvcHRpb24gaWYNCj4+IFNyaW5pdmFzIHRoaW5rcyBsaWtlIHRoaXMuDQo+
Pg0KPj4+DQo+Pj4+ICsNCj4+Pj4gKy8qDQo+Pj4+ICsgKiBUZW1wZXJhdHVyZSBjYWxpYnJhdGlv
biBwYWNrZXQgbGVuZ3RoIGZvciBTQU1BN0c1OiAxIHdvcmRzIGhlYWRlciwNCj4+Pj4gKyAqIDE4
IHdvcmRzIHBheWxvYWQuDQo+Pj4+ICsgKi8NCj4+Pj4gKyNkZWZpbmUgT1RQX1BLVF9TQU1BN0c1
X1RFTVBfQ0FMSUJfTEVOICAgICAgICgxOSAqIDQpDQo+Pj4NCj4+PiBMZW5ndGggb2Ygc29tZSBt
ZW1vcnkgcmVnaW9uIGFsc28gZG9lcyBub3QgbG9vayBsaWtlIGpvYiBmb3IgYmluZGluZ3MuDQo+
Pg0KPj4gSSBhZGRlZCBpdCBoZXJlIHRvIGJlIGFibGUgdG8gaGF2ZSB0aGUgc2FtZSBtYWNybyBp
biBEVCBhbmQgY29uc3VtZXINCj4+IGRyaXZlcnMgdGFraW5nIGFzIGV4YW1wbGUgaWlvIGRyaXZl
cnMgdGhhdCB1c2VzIHRoaXMgYXBwcm9hY2ggdG8gZGVzY3JpYmUNCj4+IElJTyBjaGFubmVsIGlk
ZW50aWZpZXJzLiBJIGNhbiByZW1vdmUgaXQgYW5kIHVzZSBuZWNlc3NhcnkgbWFjcm9zIGluIHRo
ZQ0KPj4gY29uc3VtZXIgZHJpdmVycywgaWYgaXQncyBiZXR0ZXIgdGhpcyB3YXkuDQo+IA0KPiAN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
