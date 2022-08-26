Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2924F5A2F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbiHZSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345339AbiHZSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:52:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E4E589B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661539733; x=1693075733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h9AW0N6cGmj60f83RcUV+kjTEb1MOh7DBMn6c5lIYfw=;
  b=F6LtGuwKAntrdRNUHr018ygc8QJ6Ab++KO0RoLIWo5h57K8Qlk8KIPos
   /MXi2ixYA1AwaIFR5NyHgmwZbbqFr9zGV957FhlH9R4RH6HyV9ZtSLl5l
   2EJOvDhew0BYvQCpipOUqO2tSeyxIt3Eztk/wIv+XCNxaAe9Ar9rh5d/F
   wvxaQKZcEQQLMrcnc9r4xmXFI3HbAYv6ZnW98ZpPDLwQVDnsRreqyYVHO
   RIuR8yQDvD1VGTO/ASzOsY8yk9ESId5nEqkzyHE0nuRvVc4BWgJKMhTxf
   E0gHzrmDfQvEu1C2eLc+3Cz89OCP3KkUWzxEG/mOhm4CSOXu8u0Jwg0d2
   g==;
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="177922036"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 11:48:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 11:48:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 11:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEqfMt+eoXr2A8wwDv3FYwTnyuIRMgXw88OGpUTFxuUGPI9OxzFPxUq4fQT8cM22VgENZL7HY70cC0nRV18P21n2sgiJZvcdspeWYeDsXFotf7NspTqBUv3JGA/eTPB5T8xOdH00Coyhk1r0O7J/iS/Qfix0WrXXfsD31y6qtPbKOKzNSqIggGOTFNlazQbEHYRhswaUtr8dEPLx9syclUDnRmC1FFUT0ZfywUifPeBxwLyeJDurc/xDOdDGqtZWlHSMJcgWA7AUDGneH6w2Bc53QXpGb0ROeUYf6bGYQ0Kw4If/3phCintdREN1l0/YW+OA3iT/pLn0gVCyduRPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9AW0N6cGmj60f83RcUV+kjTEb1MOh7DBMn6c5lIYfw=;
 b=BggWf5wDO0CQtwkTIdT6ditdkfdtpWLfLbUtW4YZhkuudNzOjXHrRYau/+ixcm5p5nEahoZi3niM1OyvVVKwCiHypt5OcV3uXobN9fOQi0SpxVr2DEtDPWyawNMUPk591xPMtIjUMRKxBn0vFcokL780tCXKMnoINsgI4IGogWfiXQbnEbyC0ICzzUbDXq5pmDmqXa34MQn0r4ZQsZK65kbAgIkbbJKAAx8FhUNbIjZK13Qw9ZVDRi1YT2XMFgUvxy75pzVAxoe0XTLPfgLHGB/m5mjHGIn+Hp1H/MXHwjllg+j1dgMxZFavYBGTN7pUtteEPo/qHpK2Xwp83q2fbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9AW0N6cGmj60f83RcUV+kjTEb1MOh7DBMn6c5lIYfw=;
 b=OWIbsHu8xba1l7jc6/3FfDHl7dHReydpo3lgq+fY+Iwc9+1/bcYZIJRU4mKRM6+pesx7I/ze/3D0Ys1WNRaTFaoM8bxfEVu9JxsUEMfnglL++3cbXxJU/U1lCZXoGJf+WcXhhKw/cjf5mkiDHmfriBfd/YhMOG/kQL189FejEOo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:48:42 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:48:42 +0000
From:   <Conor.Dooley@microchip.com>
To:     <apatel@ventanamicro.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <tglx@linutronix.de>, <maz@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <atishp@atishpatra.org>, <Alistair.Francis@wdc.com>,
        <anup@brainfault.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/7] RISC-V: Treat IPIs as normal Linux IRQs
Thread-Topic: [PATCH v8 4/7] RISC-V: Treat IPIs as normal Linux IRQs
Thread-Index: AQHYtGH8EQj33i+To06esLFkfCu/9a3BkCeA
Date:   Fri, 26 Aug 2022 18:48:42 +0000
Message-ID: <8f4ae429-0f12-2096-c07b-fe43b3abb4fe@microchip.com>
References: <20220820065446.389788-1-apatel@ventanamicro.com>
 <20220820065446.389788-5-apatel@ventanamicro.com>
In-Reply-To: <20220820065446.389788-5-apatel@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c469f96-e039-4fe8-7fce-08da879398fe
x-ms-traffictypediagnostic: PH0PR11MB4967:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12JS7UdHv0tploP1UQjkLLr/Ghsx4HkxhE0Lj9JUV0f6kaiINg6mS7A+YF0QC2/S9RFMEUjR/VaTds9WvNEeGgDeX7GqAw4TRzGE1hLQIvSJiOkeJTViWgbOF/4L0kRdX+tjTkpC7OVepPEvVA2iHS2v+jYAeI2730FgI8gvAn0Q/0wbdzQhlj48dyzfsiZMB/14vqBM2yhKsIGb3QwID9A4P+6h/FdvqZwssMxgLLa2gKV68c+OiuxafgJiNyedMngHTrAj4Nl/xmGgnfHIFljAbrbsqXJ6ieJ0aIpzjgQSnkfL1yQZgcPwSv9W3COpXmLRmLqQsMne3uaIXMvyDwX6MjL3oZR/lh0jBMoPctON8cWHMxBdpTZF3/jHlcpI2rCNKCYwJwL1lBZsffWQpv6WVs+/i9+XAFuw5O+I0XvYdKxAy68lPMGrfjoQbPkNvWKY66eDIkFkQgTB9Y+s4BHliA1+oHAPFNQjKPC/WiUyYmozUgCewaoDr/lynPBPRn9rW0d/mQDGzDBTExNTVFDUnTxiYKFcrEkmBt0AVFJQZ8Os8ZpSKkL1+YVsIpmmBMFHLrHCeAYaPt+l2RfxUyuRUurSBnMSV0DY/zl+bL0D2K6rwytXCTRkxP7+q55HGl5g3geN5IYLRKKqNMTIwNxBKcXU7GvwCc/xLHSkaSlO3xgVUiI8WB1Y6QM8+Ot+ZhFrZPRd+hpRFt39HSWXpqcXveRRowh54DRb7zFCjNgyN4rWop1mpEWIXPAXeilvyH8n6M8OtsRcRWjNrWLRmeZJG8HqC2WYM22labQu4rckPWcoVPhrRDKgNDLGlWVUH/zsaAWBPlbVuf/FHxJ2/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(376002)(396003)(186003)(83380400001)(5660300002)(2616005)(7416002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(41300700001)(2906002)(6506007)(31686004)(36756003)(8936002)(6486002)(26005)(71200400001)(53546011)(478600001)(6512007)(38070700005)(86362001)(31696002)(91956017)(316002)(54906003)(122000001)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjlISXIreDlWb3h4Rnc2NGhlRk5icU1EdGYwd1AydWdwRk1aeWtHSGdBUGdY?=
 =?utf-8?B?MTdBMTdtMlNYc2xqNnNPQ0NoR1Q0QnRPTFBoeVBaRWo5Q3VrR2JUY1RpaGNt?=
 =?utf-8?B?ZHpqajlkTHY0OWJBcVJiUmVwcjQ2OXhnUW9nTCswVDlwTWh6RnE3ZS9yYzkr?=
 =?utf-8?B?VHpGY0JMNVAyQ2hkWHRlWmx6dFN3RG53dTdobnpIaW9ENWF6MmxRcks0Ti9X?=
 =?utf-8?B?cmZmOWVNM2llREFudHFXQS9naDNNemJHM3IwNllmZVhsQ1VmeHVxUmJqK204?=
 =?utf-8?B?QkxZeHlvLzNIS01GakF6N2NmVHFYYkNJNnlCNGsraGhWUGFZMVdwMktodDlJ?=
 =?utf-8?B?MWdLVDl2UzBzVkFwRVo4bG9ldFZkTFVYbTRQTHJYQnV2TUFmYzdGbWVTazg4?=
 =?utf-8?B?NlZlT2k0QndabE9DY1U0ZGQ1dkEwY3FFTUdrOE13ZmlEeFFjQ1owbjhYWkZQ?=
 =?utf-8?B?a2daSG42SzRqSCt5M0tKc0E5Z05mZ3RnUVlzMThGL29xTHp1NHNjWG90THFL?=
 =?utf-8?B?VGVBbVZ4c2RoSE5XcHFOazRPditNSU5FK3dOZ2RXUGxIdGRCT0V6R3lkRjZO?=
 =?utf-8?B?Y2RJanQrZXM3SmpTVnNESXpvRitQaGtFeE9WVUpxZWgzU1V2L05oc1RtQnc5?=
 =?utf-8?B?cTBZTHhKMUpmaUhlYmR5MUVmeEthYU82TUJZWWpOdEZ1QlhjTGhlc3JOSE0z?=
 =?utf-8?B?eHk4a2FreS9RU3p4ckNpNTkrelArTkI0cEIxbmhrcFU0M2NOMDVvcVdWQ1BJ?=
 =?utf-8?B?ZHBlNHIxN1ZiUGxlejdjVC9pb2ZZY1AweGpzdEEzaWUzc3U3VGlyMFVpMFZC?=
 =?utf-8?B?S3Vod3pVdG5XSTZsaWZPeFY1MVVFZzdFb2FUeVhqL2h1OE9IaFgxN3pyY284?=
 =?utf-8?B?NUZhbjRNMkk2MzhTcUU0cXJhendpMG1YN1FON253S2UvMXFJUVU2T1FhKzBH?=
 =?utf-8?B?SHYwTnpXVm5DQkVsRnB0RTQ1SXlZUERuSFRqRVVqVERpNkpnTEVQYS9VM3RY?=
 =?utf-8?B?ZDBuYmVBOXRXOEZIMDUyRjhZYkFuNm1PZ2c0dWtaRFdUQ0M0eCsyTUI2amNK?=
 =?utf-8?B?dXJZenhjUWxyWTVJZGNDWlBRNS85OFlUMmp3c1N0aHpIMlU1SWpoMHFZdjZx?=
 =?utf-8?B?ZUxVSWxTcERUWElaRjNnQVVMNlRvWEV5ZHRIYzlqazQwMVArYlNKTFdYSVg1?=
 =?utf-8?B?ZnVPdmFMOXQyZ2w5aEhyWVJoekROa2I0cHl2eXY3SXREMWNUZlh0bXBzUXU2?=
 =?utf-8?B?aUR4T3dDVGh3K3VQZkZIbUlNRGVnWENpbVFoR2Y1cW1PUjdmR2tSUEh2R3RL?=
 =?utf-8?B?M1AwbzFpSjJVNnB4Z1MyeTJycUYrMEFqSjMvWWxPdnFuZ2p0YUJHN0xCRDI0?=
 =?utf-8?B?MzR0VldqejY1TlQ5TXhPckk4UFNVL1Vwdng0cnc5Q1k2UmZoaW1Ya0t5UlB5?=
 =?utf-8?B?QkZpcVJlZmsvaCtUYWxXeHAwTHVibGg1RWorY3BwTm50VzlRdUNvWDdBY3VL?=
 =?utf-8?B?QzUwRjBCbExob2JsdE9UTE1IWTVjeCs1NWM5VVVSSVdiTUFBUldDUExscFB1?=
 =?utf-8?B?WjgwaXNsOUdwalpRZjhramI2a0tDTVRvVHEwWm1LUml2T0hjN21EaGxtZnNH?=
 =?utf-8?B?WTRGYmN3bmZENFJDb0dIbFhYSDl1NVVDd2tCL1pIQThTZm9WRzFQaVdLMVdU?=
 =?utf-8?B?MEtZR3FEWW5DYlFBS2NMWG9tMDZseTBZemxKTlBjRTZzaVY2bGV6TVh5ZFFu?=
 =?utf-8?B?QWVuOTVDNUN1Z1hnTHRPV0dicS9iazNRZGdiOFljajcva2gwN3ZheGZHVE03?=
 =?utf-8?B?RThRaVE1bjYwTW81Qm9kQkRjM0hPcS9BcXdDTmVaZTJKbGIxVGltY1I0TU41?=
 =?utf-8?B?bUIzL3JyZlJ5Z2NHNnFCNDZ2dHI3SEkwbEhhUnFFYkZURjV2TktLdnRRZ1Fz?=
 =?utf-8?B?WnF3S0k5Wk0raDZFKzBlV213WFZPb2FtY3lLUmR2OGJVZTkvQTAwUWxqbm9w?=
 =?utf-8?B?am9RbGJCdXN1QjJhdm9hUlhBM0poRFhRZ3BKRW4yeFNMQ01XU3JFbVZvd1NP?=
 =?utf-8?B?WngrM0lzZXZJZ2MyV1AyYlhoc21NV0FrWUkrY1o4NXVjbUFxeFJEdnBoSXU0?=
 =?utf-8?B?VFRPRjlSamdBM3pTSndMN3JWZDFPZ1lNK1ozYjFod0lQdWxIY0JDNzN1ZG1h?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AB64CF8C21A5144B3909DC3B704C675@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c469f96-e039-4fe8-7fce-08da879398fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 18:48:42.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nT0TzQEuAUYlb0iQv9yFOMYGKME4mqEdbI+xp4jxBrbepYX+aSiw6DjATz9sNjM1a4D91eZauU3OTYDmJFXdcxeUwKx3tjRRYFF1YmQQVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDgvMjAyMiAwNzo1NCwgQW51cCBQYXRlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDdXJyZW50bHksIHRoZSBSSVNDLVYga2VybmVsIHBy
b3ZpZGVzIGFyY2ggc3BlY2lmaWMgaG9va3MgKGkuZS4NCj4gc3RydWN0IHJpc2N2X2lwaV9vcHMp
IHRvIHJlZ2lzdGVyIElQSSBoYW5kbGluZyBtZXRob2RzLiBUaGUgc3RhdHMNCj4gZ2F0aGVyaW5n
IG9mIElQSXMgaXMgYWxzbyBhcmNoIHNwZWNpZmljIGluIHRoZSBSSVNDLVYga2VybmVsLg0KPiAN
Cj4gT3RoZXIgYXJjaGl0ZWN0dXJlcyAoc3VjaCBhcyBBUk0sIEFSTTY0LCBhbmQgTUlQUykgaGF2
ZSBtb3ZlZCBhd2F5DQo+IGZyb20gY3VzdG9tIGFyY2ggc3BlY2lmaWMgSVBJIGhhbmRsaW5nIG1l
dGhvZHMuIEN1cnJlbnRseSwgdGhlc2UNCj4gYXJjaGl0ZWN0dXJlcyBoYXZlIExpbnV4IGlycWNo
aXAgZHJpdmVycyBwcm92aWRpbmcgYSByYW5nZSBvZiBMaW51eA0KPiBJUlEgbnVtYmVycyB0byBi
ZSB1c2VkIGFzIElQSXMgYW5kIElQSSB0cmlnZ2VyaW5nIGlzIGRvbmUgdXNpbmcNCj4gZ2VuZXJp
YyBJUEkgQVBJcy4gVGhpcyBhcHByb2FjaCBhbGxvd3MgYXJjaGl0ZWN0dXJlcyB0byB0cmVhdCBJ
UElzDQo+IGFzIG5vcm1hbCBMaW51eCBJUlFzIGFuZCBJUEkgc3RhdHMgZ2F0aGVyaW5nIGlzIGRv
bmUgYnkgdGhlIGdlbmVyaWMNCj4gTGludXggSVJRIHN1YnN5c3RlbS4NCj4gDQo+IFdlIGV4dGVu
ZCB0aGUgUklTQy1WIElQSSBoYW5kbGluZyBhcy1wZXIgYWJvdmUgYXBwcm9hY2ggc28gdGhhdCBh
cmNoDQo+IHNwZWNpZmljIElQSSBoYW5kbGluZyBtZXRob2RzIChzdHJ1Y3QgcmlzY3ZfaXBpX29w
cykgY2FuIGJlIHJlbW92ZWQNCj4gYW5kIHRoZSBJUEkgaGFuZGxpbmcgaXMgZG9uZSB0aHJvdWdo
IHRoZSBMaW51eCBJUlEgc3Vic3lzdGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW51cCBQYXRl
bCA8YXBhdGVsQHZlbnRhbmFtaWNyby5jb20+DQoNCj4gK3ZvaWQgcmlzY3ZfaXBpX3NldF92aXJx
X3JhbmdlKGludCB2aXJxLCBpbnQgbnIpDQo+ICt7DQo+ICsgICAgICAgaW50IGksIGVycjsNCj4g
DQo+IC0gICAgICAgICAgICAgICBpZiAob3BzICYgKDEgPDwgSVBJX0lSUV9XT1JLKSkgew0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICBzdGF0c1tJUElfSVJRX1dPUktdKys7DQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIGlycV93b3JrX3J1bigpOw0KPiAtICAgICAgICAgICAgICAgfQ0KPiAr
ICAgICAgIGlmIChXQVJOX09OKGlwaV92aXJxX2Jhc2UpKQ0KPiArICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiANCj4gLSNpZmRlZiBDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UU19CUk9BRENBU1QN
Cj4gLSAgICAgICAgICAgICAgIGlmIChvcHMgJiAoMSA8PCBJUElfVElNRVIpKSB7DQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHN0YXRzW0lQSV9USU1FUl0rKzsNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgdGlja19yZWNlaXZlX2Jyb2FkY2FzdCgpOw0KPiAtICAgICAgICAgICAgICAgfQ0K
PiAtI2VuZGlmDQo+IC0gICAgICAgICAgICAgICBCVUdfT04oKG9wcyA+PiBJUElfTUFYKSAhPSAw
KTsNCj4gKyAgICAgICBXQVJOX09OKG5yIDwgSVBJX01BWCk7DQo+ICsgICAgICAgbnJfaXBpID0g
bWluKG5yLCBJUElfTUFYKTsNCj4gKyAgICAgICBpcGlfdmlycV9iYXNlID0gdmlycTsNCj4gKw0K
PiArICAgICAgIC8qIFJlcXVlc3QgSVBJcyAqLw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBu
cl9pcGk7IGkrKykgew0KPiArICAgICAgICAgICAgICAgZXJyID0gcmVxdWVzdF9wZXJjcHVfaXJx
KGlwaV92aXJxX2Jhc2UgKyBpLCBoYW5kbGVfSVBJLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJJUEkiLCAmaXBpX3ZpcnFfYmFzZSk7DQoNCkZXSVcsID9zcGFy
c2U/IGRvZXMgbm90IGxpa2UgdGhpczoNCmFyY2gvcmlzY3Yva2VybmVsL3NtcC5jOjE2Mzo1MDog
d2FybmluZzogaW5jb3JyZWN0IHR5cGUgaW4gYXJndW1lbnQgNCAoZGlmZmVyZW50IGFkZHJlc3Mg
c3BhY2VzKQ0KYXJjaC9yaXNjdi9rZXJuZWwvc21wLmM6MTYzOjUwOiAgICBleHBlY3RlZCB2b2lk
IFtub2RlcmVmXSBfX3BlcmNwdSAqcGVyY3B1X2Rldl9pZA0KYXJjaC9yaXNjdi9rZXJuZWwvc21w
LmM6MTYzOjUwOiAgICBnb3QgaW50ICoNCg0KPiArICAgICAgICAgICAgICAgV0FSTl9PTihlcnIp
Ow0KPiANCj4gLSAgICAgICAgICAgICAgIC8qIE9yZGVyIGRhdGEgYWNjZXNzIGFuZCBiaXQgdGVz
dGluZy4gKi8NCj4gLSAgICAgICAgICAgICAgIG1iKCk7DQo+ICsgICAgICAgICAgICAgICBpcGlf
ZGVzY1tpXSA9IGlycV90b19kZXNjKGlwaV92aXJxX2Jhc2UgKyBpKTsNCj4gKyAgICAgICAgICAg
ICAgIGlycV9zZXRfc3RhdHVzX2ZsYWdzKGlwaV92aXJxX2Jhc2UgKyBpLCBJUlFfSElEREVOKTsN
Cj4gICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAvKiBFbmFibGVkIElQSXMgZm9yIGJvb3QgQ1BV
IGltbWVkaWF0ZWx5ICovDQo+ICsgICAgICAgcmlzY3ZfaXBpX2VuYWJsZSgpOw0KPiAgfQ0K
