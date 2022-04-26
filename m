Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B140650F24B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbiDZH1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245251AbiDZH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:27:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA56AFAC3;
        Tue, 26 Apr 2022 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650957861; x=1682493861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hDbmmwZJNMiVp904yfq8CgVyXP9tH3whkIKI1il7Pfo=;
  b=z6541CMjgbHHKwfU9SIyuvgzKN3MpWwP+IZRRjDPeVWnAtg/r7SgXqbA
   gd/7qBayxA3Zmo2JmL0aCkRHBYHY1tVXXEvvYx5JST0nlvbKskOtQevhc
   QIHftUF/o7H1HTtjQJPGr9uCEyJP2dBSt/GaGcxc/8/lbM9vDYPb0iZnO
   nmV110E/adat3fUPySwTFvmiCjSBo/qcG3jTiktvQjGfDmR6EdbfoX51x
   LPGxtOwapaIacRoeylBWQjT2UHKNeSknz9rSX9wT9mSOwUZd93XomkpxJ
   rYIvaovT/4dyCokmrTWjQoX5D6F95WSP2bLXg1Q5cqCmUbDjMbETDqgLA
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643698800"; 
   d="scan'208";a="93552648"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Apr 2022 00:24:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Apr 2022 00:24:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 26 Apr 2022 00:24:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNVoCSzeVMRqxe3HZmYcDurgoGnTkgfrMWBgwEErquKi+r48FnjshkQ2k4JxbdMLW6vSg3nC7PwbDf8jNi1SshhXDpN3UW1CSDtDL7bBjI7SWscNfXmBk2U7ah5YzlWc1zhWkll4ibrGpNHKDvL9UPF4zfqNHu10SRUZ5tA8ng0YfeZfk9iwsZa9wopYieH211avkj8COX+3xMu/1I7xlaXjCub0EhDiMeXGjqqkkga+MSgOmuu0SuHSeJjuPh5XR8zCJRWxuPCyrkObBAJMtBr7XfASdyeEREtaAc2jLGZW06JouSMfcebnUbjoQPBNkZ/Zd+T5wRrkD5pcmK6dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDbmmwZJNMiVp904yfq8CgVyXP9tH3whkIKI1il7Pfo=;
 b=MjBPUPRmgGjGM6Ftv9Cu3xIM8FQdXRunFYr8WwonIk29STNPHGGggkT8cf7D1zvIIvacFMMgTujZ4V2UMZTh4da0pUK+6gghur3IZN6d9UdKk8ve4Z9FuvUjF6SfMmDaBolGWmHBBg0Pq23b739xDTZeM2tUDsPkKp8E9QapryMNZwU13RUu4jD81zLIWnGD3ptih/MkE6LJAPQWHkXWcDDLtV1Ee4Mj41SBd/IbppgUHxJiqlA66XjI/gyksNMwGZBOZVwWfKv8H1goOLCWExODs1Ee0zlFUSba+Bwir9h6koAM8N4xfbtRVCn/p0zT57y0FRyMS2eZjWd5txOAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDbmmwZJNMiVp904yfq8CgVyXP9tH3whkIKI1il7Pfo=;
 b=o1WPJ3grP23R1GRY2XaFq+a/EBWKHpi6+hpk0rAb4vc29NMoFwT9GHxSt5K40kUhgc/OhH5mIvXLATTMISN1K9tnBoR8tLvmTzVJlw4H5bul0KyUL0bg696nwuu7ZS8R+2jzjzO6B7tALFuCEqJluBgzOJKjvh4bErwe/OxzsRc=
Received: from MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11)
 by CY4PR11MB1638.namprd11.prod.outlook.com (2603:10b6:910:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 07:24:15 +0000
Received: from MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::3c24:30c4:ee81:9f1c]) by MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::3c24:30c4:ee81:9f1c%2]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:24:15 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] clk: at91: generated: consider range when calculating
 best rate
Thread-Topic: [PATCH] clk: at91: generated: consider range when calculating
 best rate
Thread-Index: AQHYTwYLocsblKFTaE2b4sfTx9QXEKz7LfQAgAaxRIA=
Date:   Tue, 26 Apr 2022 07:24:15 +0000
Message-ID: <e18eb810-e437-6a19-26ec-1f0daedaaf5f@microchip.com>
References: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
 <20220422011216.A4A23C385A5@smtp.kernel.org>
In-Reply-To: <20220422011216.A4A23C385A5@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0f35aa1-27ab-4f57-3895-08da2755c4fa
x-ms-traffictypediagnostic: CY4PR11MB1638:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1638510B38DC2FF6DB7E596AE7FB9@CY4PR11MB1638.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oI4HP+E1jZqvtdJbIv1afhf6gXZSQjgtmKSGShSidiUG2mQ4Acx48cE/eyW9RKZIEz/Q3ghqV1q5RSbmexAeAqRB56lV/yS3FrF92bz+QUK3f+Aj//HFxHhXxI0beBfNtcM7bSFMebKQoRTQehqszG0ZKCoZZes+rFEGmA/6OYNye31B19soOgJkLX8pUF2fZrQ1YHlQgfH6M3XZSVqL+k8T6cPeAveU5h3+o/rPA+C7i0L/v9bJLCvNfp0VMf1zGxj955HjTb08H5iUqxMZuMXW56Vw5VFK7089Txv7JwGdo1eNXQ18APEDawWY73986RFy4alnQ0B28hO7XiQaPozmRYCG07XnYTdT7VG4WW0y9NlAH/5o2R86kamRcFck62Oe8iO2JYwamLPd65H0Tpoc4Ci3fdS+zcuZAkmCdzzJJJVHa8XL3sF5X9tFMN3Ifiz42lGId07cJSKFH7p08E/rWlB8ZndkmETbgf3opzR0v2O1h1Kde1EB25/CN0X91E41GT8Hw4qodNGIcupYrXit8/TmYuOB8Rn6WKgayCGpG8jNfs5DOncr9mu8iBWn79UyV5BHutSVaMqcemNlYC9DRv9GDBt8LnxS5FODvVfqkBaz9c6l13YUsKS+f+uTqgISGKexhAl4DSqn64/g9mlbY4bdlnN88CvDebtN6STfScrQ4mlnze9g9fnmXLwE8Bkd4e2AZM+Rd9+BLUgskSlqtT89hyR1ScOwxognZmMCE90iyTfSczjX+VeZpQjYmdEFMXlvWzNCfkOwLaDww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5936.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(91956017)(2906002)(110136005)(2616005)(71200400001)(53546011)(6506007)(64756008)(66946007)(76116006)(5660300002)(8676002)(66446008)(4326008)(316002)(8936002)(36756003)(31686004)(66476007)(66556008)(6486002)(107886003)(54906003)(6512007)(38070700005)(38100700002)(122000001)(83380400001)(31696002)(508600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXdnNlgzalpxemJpaXY1ZDdDekFLamxYYzRIdkIrcFE2c0YybmpZaTJheVhp?=
 =?utf-8?B?OGZ6RDE2ODZNUlh4RkQ2SEJUZXJ4V3VBUmo0TlhDN3VLK3QwOTgvblNobDZQ?=
 =?utf-8?B?Vjc0cGFKT1A5MU1INVVrWHFlbWp2RUx3V1VBbDFQLzg5Tno5ZGR5ajVwOUVU?=
 =?utf-8?B?dWlHQXlJelc2NjlqSlc4aUlWY1o0RDV3dnRjaUF4YmVWNEU0S3YrMVRsZDVV?=
 =?utf-8?B?a0p6SjZGK1M0Wk1pajBqSVVJaklPamloNFdwYmhuSkNDOW83dWhRalJ3eVlp?=
 =?utf-8?B?a0NvQ0lxY1c2MDUzVndyMHJTM3Vsb05IcmhiR0hHeC81OHpSU0RqTlRUVUd4?=
 =?utf-8?B?empLWVRmQjhoNFBYRks2YlAra3dNRk9mYUNHYWRzcWk0STdRSVUwY3UraTEv?=
 =?utf-8?B?R3I1V3djL3J3UURpQ1NhTTZFRHJOMGxPQ3BucG5IR2FCMGdIbHBiQ2dMNFdJ?=
 =?utf-8?B?UEwxd0ZocGpPSHdtT25ZUlZyek5WRTVBQmZmSzQydFNjRW5rdTdRVFBnUHQ2?=
 =?utf-8?B?QUhwMlg2bnlPQlZHVmlRTUhRemJyMlNyQkhxWDZ5d21ncS9oL0pqeHJ3aXdl?=
 =?utf-8?B?RUladElQdUVoWjlXMUg4a3pNcUlESis0ejRBT2lEalFuWmQxYjk3NnBDanM4?=
 =?utf-8?B?TG9yUVVZc25zOVJGK3dQcVF4QVlJRzZ0MXYreXplSWJJaVhma0JTclBZYUxG?=
 =?utf-8?B?bGw2T1dQeDlFcDZYS2FXeXRLVnBnZTNQSUxXenMvYjN1SXM0VlZ2ZGRwcFJx?=
 =?utf-8?B?bVA1RTVUbFhGYU5VRENtaEI0SkRUdTlPd2Q3aXZoYThBd2cwVzk4aWwrYWJE?=
 =?utf-8?B?aHFoMWZhRkx0aUkxTVN5Q0J6NHZRanpkdjlGV3c3RUlPc3pqMWU5YTlBQWVI?=
 =?utf-8?B?akRRU1FLbDFaZXNsaVY1cE02eHhSYmpYWFZWSTJiS09PbmViajBJaFdHTU1k?=
 =?utf-8?B?N2FhaHJndnRUc0krTHFBYlNSaEIrMWZBQ3cyWHlxU09NaW53QzN0MFZ4cXRD?=
 =?utf-8?B?bURUWWhxWWNSTmpMRXRNZTAwY0tRMXNmN2tLQzF5SHFBN3R0czFXQmt2Qzh0?=
 =?utf-8?B?LzdDV2Y1ZGRnZWtyODIwT3Z4Z0ViN3pJYjFUdmxURVZpVjJtMzFOV25jZE9V?=
 =?utf-8?B?YXh0a1VsQVJScG1zbFlmd1UvRk5EK2YyU00rVTIzYUlHeVJlRzZTVTBiNTd1?=
 =?utf-8?B?NFI4aTcvMjhGbEhGMHdmamlraVlQQ0xVbHd5endsazQ0Q1QwdW5lZzRIUlNx?=
 =?utf-8?B?ZjExUDlMb0Q1ZSthT0hXQ1BCdkxsb2hHcUpkQjFRV0I4SWlqSjY3N054a01o?=
 =?utf-8?B?Q214UkVtVXJYenF6b0djdlJwN0VLYWJ2V2xjb3RxeEpJRDBRZjZPREtkeTdC?=
 =?utf-8?B?dEt1dXozM3RBQldhWkNacklYaXZCM0FyK0ZleEk2Q1JDSDB5UVg1aHBFZlZR?=
 =?utf-8?B?ZmlTL1MvVTZxUDlKWVVKUExNS2ZhbFVuS3JkZkg0Q2IxWEhTQVZRWVEraFc0?=
 =?utf-8?B?bVIzYWh6YnZjejcwOUtyMENBeVk0QlFUZjlEVXZSQnlKN2hkTjFlalQ1QUo3?=
 =?utf-8?B?Qm9keGRoN2JuNFhaTFl4ZndsTFNqZGRhMmowQm5zS0xWdFAybEo2MUlUdnps?=
 =?utf-8?B?dWVjeEJsL2tZdDlYNEVuYi9iVzRJRmVxTUVFYmMyZkZOcHRYWUdHZy8rNnpO?=
 =?utf-8?B?clByK3pWalQ2czQ1Mm9VRjI1RmVPRmpuSEZzV0h6RnNzNlVhcEYvTzUwRURH?=
 =?utf-8?B?QkoyVWFlM1UvSkNCUW9QdFV0VHNWYmR1dUtiYk1xSVFCblV0aGlRdS9ydDRH?=
 =?utf-8?B?NTJ3clBEMTNCWWlCRVhiSWNwOEI2Y0dHUUlVTVB5VFhEYW1JeWhqa1dET0E2?=
 =?utf-8?B?djFWZWVSVUNRMFE2ajdVU3d4Ykkrc3l0cjJPekJ3WTBEK0RQMm54OGoxb3ph?=
 =?utf-8?B?cTdkWm0zUnRWb0tNTTFieHdhZjJwdXZnM0FBNENaSDVUSEdhUElwazdaM0Rk?=
 =?utf-8?B?UHlYYjZOZWRic1lycVpBTDFTZlV6TXhrUUVQeDB5M1RCZEl2dnBGbnYzc3Bn?=
 =?utf-8?B?dXRINWVHTXdHMVdTRXQrMS9tUjAvRE80YTRBTEZKejFvTmhBTWoyVE13U0xJ?=
 =?utf-8?B?MCtnbHhIajJQa2xGaVMrNG5oNCs3MUphQTlKWnRFc2Fjdmhpem1nUG9SR1Nx?=
 =?utf-8?B?Njg4RDVKYjgzZHgrbjkyNW1OUjFPZHNDaWdsVlNQdVkzdFg0YzA3dHB6dkUv?=
 =?utf-8?B?b0l3WEtaRVY2ckhSbC96bE9CZ05WcDVRVHVEekhEQjBqZldSdm0xakpFNTRU?=
 =?utf-8?B?TTlpUXk2WEgwR2x2aTQxOXY0VUNaRVJRcnRFY2xVeEJxNDltSnZPQkhEV2sx?=
 =?utf-8?Q?Gb8bTFZj299CBcZj2IXj3buyw5hN+mI0RkeP/oqIfSs5P?=
x-ms-exchange-antispam-messagedata-1: NcC0slxevPi5Sy0oCrjjSC/Ojr0ScTeY7cQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98F889AD7963D7478B7A4C97E1214F87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5936.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f35aa1-27ab-4f57-3895-08da2755c4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:24:15.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqGdJAm3vZGlmMTOzsj8qEcDQOUgKLTtrqbKMNZD9HqTR9SQZ9hZ2IuKXyPZiI6kgsVVl97+6dQuhq+zOnunENHRNKZk5U3r85+VK8XeIL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1638
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDQuMjAyMiAwNDoxMiwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiBRdW90aW5nIENvZHJp
biBDaXVib3Rhcml1ICgyMDIyLTA0LTEzIDAwOjEzOjE4KQ0KPj4gY2xrX2dlbmVyYXRlZF9iZXN0
X2RpZmYoKSBoZWxwcyBpbiBmaW5kaW5nIHRoZSBwYXJlbnQgYW5kIHRoZSBkaXZpc29yIHRvDQo+
PiBjb21wdXRlIGEgcmF0ZSBjbG9zZXN0IHRvIHRoZSByZXF1aXJlZCBvbmUuIEhvd2V2ZXIsIGl0
IGRvZXNuJ3QgdGFrZSBpbnRvDQo+PiBhY2NvdW50IHRoZSByZXF1ZXN0J3MgcmFuZ2UgZm9yIHRo
ZSBuZXcgcmF0ZS4gTWFrZSBzdXJlIHRoZSBuZXcgcmF0ZQ0KPj4gaXMgd2l0aGluIHRoZSByZXF1
aXJlZCByYW5nZS4NCj4+DQo+PiBGaXhlczogOGE4ZjRiZjBjNDgwICgiY2xrOiBhdDkxOiBjbGst
Z2VuZXJhdGVkOiBjcmVhdGUgZnVuY3Rpb24gdG8gZmluZCBiZXN0X2RpZmYiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogQ29kcmluIENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3JvY2hpcC5j
b20+DQo+PiAtLS0NCj4gDQo+IElzIHRoaXMgZml4aW5nIGFueXRoaW5nIHJlYWwgb3IgaXQncyBq
dXN0IGEgdGhpbmcgdGhhdCB5b3Ugbm90aWNlZCBhbmQNCj4gc2VudCBhIHBhdGNoIHRvIGZpeD8N
Cg0KSXQgZml4ZXMgdGhlIGNsa19zZXRfbWluL21heF9yYXRlKCkgY2FsbHMgdG8gYSBnZW5lcmF0
ZWQgY2xvY2suIERvIHlvdSANCndhbnQgbWUgdG8gYWRkIHRoaXMgZmFjdCBpbiB0aGUgY29tbWl0
IGRlc2NyaXB0aW9uPw0KDQo+IA0KPj4gICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1nZW5lcmF0ZWQu
YyB8IDQgKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jIGIvZHJpdmVycy9j
bGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMNCj4+IGluZGV4IDIzY2M4Mjk3ZWM0Yy4uZDQyOWJhNTJh
NzE5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMNCj4+
ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jDQo+PiBAQCAtMTE3LDYgKzEx
NywxMCBAQCBzdGF0aWMgdm9pZCBjbGtfZ2VuZXJhdGVkX2Jlc3RfZGlmZihzdHJ1Y3QgY2xrX3Jh
dGVfcmVxdWVzdCAqcmVxLA0KPj4gICAgICAgICAgICAgICAgICB0bXBfcmF0ZSA9IHBhcmVudF9y
YXRlOw0KPj4gICAgICAgICAgZWxzZQ0KPj4gICAgICAgICAgICAgICAgICB0bXBfcmF0ZSA9IHBh
cmVudF9yYXRlIC8gZGl2Ow0KPj4gKw0KPj4gKyAgICAgICBpZiAodG1wX3JhdGUgPCByZXEtPm1p
bl9yYXRlIHx8IHRtcF9yYXRlID4gcmVxLT5tYXhfcmF0ZSkNCj4+ICsgICAgICAgICAgICAgICBy
ZXR1cm47DQo+PiArDQo+PiAgICAgICAgICB0bXBfZGlmZiA9IGFicyhyZXEtPnJhdGUgLSB0bXBf
cmF0ZSk7DQo+Pg0KPj4gICAgICAgICAgaWYgKCpiZXN0X2RpZmYgPCAwIHx8ICpiZXN0X2RpZmYg
Pj0gdG1wX2RpZmYpIHsNCg0K
