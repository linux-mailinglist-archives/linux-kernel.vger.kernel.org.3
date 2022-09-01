Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAE5A9CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiIAQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiIAQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:11:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7EF6CF75
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662048682; x=1693584682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4EgDmm1jXKZzL7ZJfvkYO4i+WPfLk5iW7qCKq9aT9TU=;
  b=YPosvZUojKGDvB6pIbGBMgLo2inQoxqGAdKJugt/kPgMbYd/QrN4mWZ1
   efyKHQAJ4k782bVUVvQuwNLcQKwoZPTTy40d5m7pVsHrZAZW01l/1LL0/
   4EY97UJhxiG0H5tqSKprt8ybzGJ9j+l0B92kWQ5+b0/vyWdI8Jd0r9mtf
   h4elgEgnLdcRhlOMMHbA4v9kWRLVEnSZ8v9MOkoGSSDhvoYv3Kwx0eP+I
   dM1DO8qZBS2lXHpc/lQ5cDzYYIPj3zkeUPXbjGQmT0O61RYRdNhP/dFxm
   BBGwzmYyJ2ebJmbtAPIRynuspTEfn5JY1ab+vjdYEjlAQxPcm7TBoBD0L
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="175225495"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 09:11:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 09:11:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 09:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF9/NX57krG5o8p3zT6LvW3gkkE0gGj1P+aw+cLSjUhR7tMAOcuq4b0iiBdWTCVRkVJjL8lFGexUj7q4d4wpqNGeRtbq+eVTgii7at74ibETApzaeaZbh5jSN3dJOwscR1s2HeIq7cmReN0QSSAgh049D0c02seLSBOmmJBnXJIgYXlrQHP8zJC043zrI0ZN8penYtkLNGihwzZEO3e/+18amqM4vMJUqsYnAHDFmrPVnvdWOkmPCZXzqPem60T8bb4txRYIDSV9K0FP1Boz7Zq6ae1CEOKQJy7aPuL9YjFZtr/6p+LcNhvjpLA+W5NOQE8bdW1x55wIZMXUuNmL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EgDmm1jXKZzL7ZJfvkYO4i+WPfLk5iW7qCKq9aT9TU=;
 b=GZvC9WqpAkJiu8wA1gEc56tVfyR+kNVqFce1KEw7/gBZupqF3UbFU9DxHlxMwJZe2QlXG4rjZ2s8lBsecc8MGvNzfjfA7zwcnzy6ioyiaBQp16VzPhSDSm/zyfXuZ51JYuZrpGr7NiI23OCba7NSXAxjlpvQxYLfD0xPW2wH7+3wnUXf5+polAa9S0WH9eb1eTM4TXY232C2dlarl8QYU14ey2+k307Bo7p8/Qjt1VJxmA7IxD8SW1pYH7C8F531XlxxL0RH0UeFWjQTnzj/j7Wj1bBHdqALxpMP9ZgSUaAB7sDcZt97qFlRvr7NwR5qb4xUXtomWqWItSilKg8C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EgDmm1jXKZzL7ZJfvkYO4i+WPfLk5iW7qCKq9aT9TU=;
 b=tHfBNekV7tVr5K1SBghuXlLMeBcxV+oul9AyAu2fSs1M+r6xiELtGmJG8j1nPPVxpfDS3yzarOSnUDKggFGCovwZKkdBDWCwUnwlcXre677B7bxkQBfay0SzSzvcMTdoPyEIa0x6X20xf9gKPzSp6+nxTpv5KZ20T1C+l8iZGP4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 16:11:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 16:11:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <apatel@ventanamicro.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
CC:     <atishp@atishpatra.org>, <heiko@sntech.de>, <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mchitale@ventanamicro.com>
Subject: Re: [PATCH v2 4/4] RISC-V: Enable PMEM drivers
Thread-Topic: [PATCH v2 4/4] RISC-V: Enable PMEM drivers
Thread-Index: AQHYvCvFXf3JzmFWskiKNXd5rl43na3Kwo4A
Date:   Thu, 1 Sep 2022 16:11:10 +0000
Message-ID: <4b087162-61f1-f19e-be99-728f3798b9d5@microchip.com>
References: <20220830044642.566769-1-apatel@ventanamicro.com>
 <20220830044642.566769-5-apatel@ventanamicro.com>
In-Reply-To: <20220830044642.566769-5-apatel@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 748d8649-08c2-4d3a-cab2-08da8c3495fd
x-ms-traffictypediagnostic: CY8PR11MB7241:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfIZVz+zkAnV5KHIFE4o31ZGS0SLSdWwo/MezjHtKcnbveGydI3FJ9FVlFPQkKTSH7V3BWoXZxiomHjfSkLNn/Wlu+N/FBL87MiTrdqnYyaIJiNDKp38/Kl/2DkEp6CgcSBk13iOZtVTthEogIGJv5DKi7Vf47pKd8SbtkffRbeWn4BuRFXMEdCTfcPMdzvdqDtyiVqsixEMmhvI0cZYLIhKMnBJ3GkaqIn5npQUiKqHDCyoBN0x4d8QuSujHPk944gDsNvToriEWGSZhIjidYq1Eq/iQLCnD5PY1a/z+64nt6gypNYlFQnLMj33UcwgCGE/AzLBkTo4l4vKz2s66kxpkRu5TeV5VuaFXIiLJvlBAMr3TjMewIa5opGF2Gdn9W5yOMerYter1CGZFqFWUgfsBIAVz00D67WBfSiQ2HI+uPvaGTTaaItIljSdlEiIx+plirzAAt3jcC8y7S6AafN0gMhgahWD0QcvEyKTvXNr95Rxtrv4gz8sGLHmEju0z8ZdqlJLtucMqaFMVNvUWRdkZ/YQfnXhl815itm7H2wwDXiKa4TT8/mDUOHtDfu0B7txL9mESi7SLmIV40IgnCrYyaCtolWCD0YsEHX6XQSjqQNasdahkLq7PX29BW5C2aELNgE4js9/u7yXXwzN2MLHwvEfyobeulVmATxpdL1rYOZ+GDFf1zEaSRc/+Gr/OHw/EDWR9KLm2LXaXOjQgN+ecQlIPH3haI+cZRkhRwC1NhytoKD5llREhT0PsOgmxiNI4It23iEhZRxa7K2N6cYmaLryylzQ4q0z1HoL0Bu21sHDVSxwdojQn/i1TXASMRxdea2urwSLz6gGjh+tYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(366004)(136003)(5660300002)(478600001)(122000001)(66446008)(8936002)(83380400001)(31686004)(36756003)(38070700005)(316002)(6512007)(6486002)(26005)(71200400001)(53546011)(2616005)(76116006)(91956017)(6506007)(66476007)(66946007)(66556008)(2906002)(8676002)(4326008)(186003)(31696002)(110136005)(86362001)(38100700002)(41300700001)(64756008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N01QWExnWFVPMkF2M2JRRVozQWVjc2Z3ODgwMUdZaENxTVV6cUtCdFp0bFFz?=
 =?utf-8?B?R2VuQjIzeFZTZExkL1BqZFZydzVpRVJFSVlsV1ZGdG52Tm43ckUzQzd2ZHIy?=
 =?utf-8?B?SXNRUSt1cmJSblNjSFVkMi9jblFiWFYrZnQyd3NRQzRQOUtDQWtNVERkaU5m?=
 =?utf-8?B?NTU1Qlc3cC9zQ0tRSnVpSUFkaXZpT21OWllrNmVNdjdzenFNNmpyQ2VWRStU?=
 =?utf-8?B?a1djY3BkbDJSb1REU1Jrd3NJeFVJWlFQNHpDSzE4b3JOUWpDUzR2ZmIzNzhB?=
 =?utf-8?B?TWFXUEZHUlBKVjQzR2dmcEZ3NjZVSzNzOVFwVGtWK3ROWmkzU0RncGN2T3JO?=
 =?utf-8?B?aW9LaEw5cEtuSlFKZ1hJTVh6NWlpQ1FvTzVBNG5HZXp3eXh1M0VzNTlnc0Jt?=
 =?utf-8?B?KzFUQStqQ1VTdUl2WTNtSlZIV1MzbmlYRjRjU0NMeG02YitrQnQxdnhlTXgw?=
 =?utf-8?B?VXhUYWV1TmhOZXpLSld0b0lMMFBMYUtFYVFxOWNtTDlDQUFuSC9oQ0I5a2Rr?=
 =?utf-8?B?cGVhdEZzZ3FxbitrWlg0OVJ2bnFpZ2w5MFZFYVJmZWc4R0wzaDRLNDBqMHp0?=
 =?utf-8?B?czc3NDhXamlZWk1WQ1RJWkE2OTZIdXFFdlREc0NSU1JFWjBOTkNDajM4S24v?=
 =?utf-8?B?WTFtNUtxTUhSNjA4eUpaazVqUlVId0pqcUpxalBvUDVLYXExVEEzeEljRy9q?=
 =?utf-8?B?dFl0NEx3UGxrb1Z6RW9wdGwvK1ZGTWRhaW81MkFaeFJVRW8xejhLalZaa1Ar?=
 =?utf-8?B?S29OdzJvaTlablFxTFdaZTVmOHdVRFVwd3o4NUNDMWM1QU9jOVBhTjJWVGRi?=
 =?utf-8?B?aXpJNFRXSGpuUWJySDR3WWZGUnhOOXlKMjlkWExCZ1dDeWZJZDFIYW5MVm5X?=
 =?utf-8?B?ZmFPOFgrQ1g3aytDMXdmL3UzVDl1MCtxckxaYnhpSGdkeUwwQmxzUE95dlV4?=
 =?utf-8?B?RmhpdkxsdFpHc25SY1NTcnZsZ3dVRGJiNW9aRVdUVnJXOGxId3JtZU9ZaEV6?=
 =?utf-8?B?U2VDZ2Jsa2trTjB2dnhjVG5NQ3VmVHZFTWhIUU5VMFZIUXRjZ2w5T0hmeDRD?=
 =?utf-8?B?RHk3RU9hbjZsR2R1OTd0SFQzM1pBelY0UzVqNVI0bDM0WTJYSmNUcnBkUmNU?=
 =?utf-8?B?Q01xN0QrRFVYSFZ0MU5OV1VRM1Vja0piUnVkdjBkdFI2V1g2TnowZXZlcG0v?=
 =?utf-8?B?TGcvUncyQTk1MVBtTXByb2c2N2tUSll6d0t4S1l3QlVMamhFVUFMclhWV1I4?=
 =?utf-8?B?d0VTYncrQnVmeGVMazVOWUFLcWV2Q2NNWkp6S1pjOEtuby81N3pNZTM0U3Z6?=
 =?utf-8?B?SUM4UTVzZHc2RmRJOVQwZjMzYkd6UHBKTXFEQ0VySUFWYnFTWkdoNHVCa0tt?=
 =?utf-8?B?dXhSOVkva0JYQWMrbnZHQWlZaDRnQ1lnV1Zqb0I5THZSNzJWR3lBVWhGVmxT?=
 =?utf-8?B?TFhqbkdMZjNnS0FvNjhyQUV3VG9VNGlVQ2IxcEc2UHV0REY4VDJ2cGtvKzNL?=
 =?utf-8?B?SjMzOFB6OEIrZCtVMmRHOXE0eVpQcnNtZW4xSUVIVFRiZkg4UWduVEVtYXRX?=
 =?utf-8?B?eHFOeW1zbXJITE9pem50bkUvL2JQM1FnbzhQdmRVaDlmUnVhRDB1MEY0VEZu?=
 =?utf-8?B?U2xNdGwzeFRzWVBpdkdEdmhsbHNFM2p6NmRla1A5M1FRSWZJZGQ3OG5qWFQ3?=
 =?utf-8?B?NlQxMW1zclVVZXdPOTQzblgyWU00S0VLRkhJaWswNzUwak0yNjRZM3Zqc0My?=
 =?utf-8?B?SURYWDdyMHp1T1hBSk0xNmxCL0dDdkpyUVhnRG8rOXplRlF3MXFDVE4vM2NF?=
 =?utf-8?B?enNoSGVXVE1nQ0EzWWQ1ZmpZVUlxcmNueHUwcm1LYVk1R1pYeFhFbU1aSm5Y?=
 =?utf-8?B?bUFiTXY0eXhheFVzcWViWFgxUm1oUmFuTEh4aW10UlZwWGtCWEZnSDhSbmc2?=
 =?utf-8?B?V3Bta0JIVFBYSXZRbk9rSk9FOUZpNDkwQU9nbE9KUnpIbDBwK1FUbmpGK2Zy?=
 =?utf-8?B?YngzMW1GQW5IL29UcSswOHIrSCtqOVU0L2h1WGtwUHJDYTBzZnF5YUpDUURJ?=
 =?utf-8?B?Qit1ZDJYOXlDZSt6TG5LalhFekU0NU4yZ1Q2aVlTSUxEVGp0MHA4b0Y1NlNO?=
 =?utf-8?B?amo0NFVWT0QvbllHcFFXSXZXN1pHUjF4SS9mcmZDOVdDenRpSlZqaHhNaENu?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28023CFB54B09F4BA6CCEDE9BA003AC8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748d8649-08c2-4d3a-cab2-08da8c3495fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 16:11:10.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqEAPCXbMkWV4NlITnLyN/BbPF/HirVLMgvnxFVuXoTVGsxbhTGBxeKgCSCSVocAdQQiaB8X0LLO4HLv7ttlIXCmXNF7tnhKK9HvyMU3tHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAwNTo0NiwgQW51cCBQYXRlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBXZSBub3cgaGF2ZSBQTUVNIGFyY2ggc3VwcG9ydCBh
dmFpbGFibGUgaW4gUklTQy1WIGtlcm5lbCBzbyBsZXQgdXMNCj4gZW5hYmxlIHJlbGV2YW50IGRy
aXZlcnMgaW4gZGVmY29uZmlnLg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBNYXl1cmVzaCBDaGl0
YWxlIDxtY2hpdGFsZUB2ZW50YW5hbWljcm8uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXl1cmVz
aCBDaGl0YWxlIDxtY2hpdGFsZUB2ZW50YW5hbWljcm8uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBB
bnVwIFBhdGVsIDxhcGF0ZWxAdmVudGFuYW1pY3JvLmNvbT4NCg0KQnVuY2ggb2YgbmV3IGJ1aWxk
IHRpbWUgd2FybmluZ3MgcmVsYXRlZCB0byBwbWVtIHcvIHRoaXMgcGF0Y2gNCmJ1dCB0aGV5IGFs
bCBzZWVtIHRvIGJlIHByb2JsZW1zIGluIHRoZSBudmRpbW0gY29yZSBjb2RlIHRoYXQndmUNCmp1
c3QgYmVlbiBleHBvc2VkIGhlcmUuLi4NCg0KSGVyZSdzIGFub3RoZXIgbmFtZSB0byBhZGQgdG8g
eW91ciBzaW5nbGUtbGluZSBkZWZjb25maWcgY2hhbmdlOg0KUmV2aWV3ZWQtYnk6IENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBhcmNoL3Jpc2N2
L2NvbmZpZ3MvZGVmY29uZmlnIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJj
aC9yaXNjdi9jb25maWdzL2RlZmNvbmZpZw0KPiBpbmRleCBhZWQzMzJhOWQ0ZWEuLjAxMGI2NzNl
YmQxMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9jb25maWdzL2RlZmNvbmZpZw0KPiArKysg
Yi9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+IEBAIC0xNTksNiArMTU5LDcgQEAgQ09O
RklHX1ZJUlRJT19NTUlPPXkNCj4gIENPTkZJR19SUE1TR19DSEFSPXkNCj4gIENPTkZJR19SUE1T
R19DVFJMPXkNCj4gIENPTkZJR19SUE1TR19WSVJUSU89eQ0KPiArQ09ORklHX0xJQk5WRElNTT15
DQo+ICBDT05GSUdfRVhUNF9GUz15DQo+ICBDT05GSUdfRVhUNF9GU19QT1NJWF9BQ0w9eQ0KPiAg
Q09ORklHX0VYVDRfRlNfU0VDVVJJVFk9eQ0KPiAtLQ0KPiAyLjM0LjENCj4gDQoNCg==
