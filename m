Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF94D00B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbiCGOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbiCGOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:06:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE48CDA6;
        Mon,  7 Mar 2022 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646661961; x=1678197961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LsJqG7LVUP2OhAxvDceLSY1kKkM2cR6rwXBi7N8CUAM=;
  b=Uo5twHuYwI5eX/v8v415jQs0Oy3wY6ZyyHW9BVePRPOWvh2Lu3vFJGAz
   d3LwZb0WBvGBCitWQxo5/EdGabti1CFKVcS7sl8P0ul7JimdHj+Om/xQx
   nYTNYQAg6AAfbfQTDXCL9b24d98fMLFb8Sh3HCm+SkIx2ey6D9k17ZUOB
   +DRbGqiHnNri6SWpTtFiRq0U66NOcuuKxbmrDYZwQaiT3paRo92OBbYuw
   jVtDH99jaoyLsa5Nj9nrSfgUkGNc3EPI4DYtl0SjssEgHNVojZIGaipcq
   LxguRVSjF41/3lgLEAwT3OxPPs2v6AOKb0TQ8tp+yb10ZhxuMWDkZTqRU
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155499446"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 07:06:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 07:05:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 07:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmU36VbQ+pJudiX8oV6YxwYKu+sylN5DOljwQ9gg8r6H3t24xfUQ9HVCIRTwqC+cPNFfDKDRWSquCubmXh0a/c+TNCtxn2K4/5JfdfeY+LazOTOagAnpR2mY2Bhgzc3w0E8V3hAYH0ud57/+LqJLL7UUlb3AycBNFF2T9KZEv9VEfUDnRh4lwXSM/c0l84rLsyX33M8fx1jWFQY+wd6nJR0yvlDfSEGzac5twZqy64oA37VkWZX+LpvmiULIVCf0Bck+7a7w4AZFOR8wB75rcNmAWTmHUb7ukDvJ5QrNhbi30zrWD/JY+yU3k3pzz6Llw3VNVIZLJYKwSED0bE4i8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsJqG7LVUP2OhAxvDceLSY1kKkM2cR6rwXBi7N8CUAM=;
 b=XK0aHpYeuL3QU0mrx/OGQrpy54D92Gv75FTlqoWWOsRe8zkvCYxOKKk7kLXLdhpDPYxC6KbcPlFFkVVwV+pxG6KV3mN+JxjcwD+7ZclyvMOoLGGoCGCieFHRILOhPEZegjWPGSy/FomERcDl2OGPKmLT024iSLBKY5lTT9TxSxoCp5L2FOQ/gx/qIjb2MuNH+++1ifJH3y3RKOQAhmZr0kFVWL4aG8Ob8p2/Bhkhk4uZbUoVLLN7m3SfCnFLA3pcqQEEWdOaXnMDD//r6JEoLmmfinQk72f3nHZX8/8Y9u3lFZvs7c98an6VzPLP0XwYJfCKQA+AtMZLplC9U6zqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsJqG7LVUP2OhAxvDceLSY1kKkM2cR6rwXBi7N8CUAM=;
 b=ijqd6uBbV1b/NzDN2SMrmKdfzqFQKIgViWr16uysWHKbiFg2W08Eo5sYYYDXDrk4mBHwAMy/CT8DEzrsj6pqd0ycCNVK2Vq0rR3g8jTmWPxl6cD72ILuE9dU2f8HUii94vI8S8c42nwIT1h1yqS2DJ1oasIew/U4fPq9xfKFJf4=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 14:05:53 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:05:53 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>,
        <Claudiu.Beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Thread-Topic: [PATCH 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Thread-Index: AQHYMiPpgEnaRFKyykKQdgKqznHe26yz6JyAgAAMBAA=
Date:   Mon, 7 Mar 2022 14:05:53 +0000
Message-ID: <f4d97269-c2c0-fb61-08e3-3b3396db5b1c@microchip.com>
References: <20220307130307.106102-1-sergiu.moga@microchip.com>
 <20220307130307.106102-2-sergiu.moga@microchip.com>
 <9e565eba-7678-1399-3cae-5335dc026e2c@canonical.com>
In-Reply-To: <9e565eba-7678-1399-3cae-5335dc026e2c@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea89431f-193a-4dc1-b822-08da004397d2
x-ms-traffictypediagnostic: SA1PR11MB5801:EE_
x-microsoft-antispam-prvs: <SA1PR11MB580190CC78B8934D2CA4F649E8089@SA1PR11MB5801.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /tnaAD7u82sdddOG+I5IpvyUXH3wZXLFhyOW4fj4n/jLsZjDkioOaXVUFq08Kj8PIflBf/e+GayH3PBEO97Ro2JlCb7ZRTRohMBT2DiM+u/qGZ/I5fcUsV1/lzIi3HDCqk310mpoACn1atcSr+RTuy2FRlCIu/84iyYuzdJ+XIgDVRJBIpIMOK9BlqznXDSfKOwIYjjDbuDGWu9jQcn0UtaSebqr9LJQ2tOZRHId1bYo9EuOmIzsUK90wy1HolwUwiifbtgbgL5OLqSj4SHP08DOY1Z/xAlGIkPx8J2fRkilqDb1S6sz5VJh9ykNN3SVrEgqlLvMUJFElOa065lQEuB9X8Beii9LYuCgNOqj3gsi2+nWKaFKWiqc8kQ/B+MZoUzEYJzYn2MKtj4QMfC8aloeWeBeTMsX9SQZoO9yIAjY5E9TOFwkF4ZP4r1ldSSTJ8Ye2ixpzTareVZasf52Q6RRE+k30349v+IwNFInbl0EtogSwpUaXB2/BTs23kAKge/V0rCnkIXwWal11huTWobvoiFoMndsbVso8Z9t0Rf4xvyI5zXKKxPtJojiDAQ70xi4EmcM99Fqe3wihehi7RYa1FLEd5iuImdl4uLWVmTB3X5XDFl9GoHqDFJTe0qFSdsHOt32zNt17njo70S5Ds8K9jVac7KPgZ1NvnLxES4048zXAOkpihO1KZORJkP6Hclm0X7MY5+UTQ0Fh0C6PXjpz2Me92BTPq2n2y0gzl8+JWuhjJuuzZ6KuN92LK2tGu9WJbTv6Siu0W79iro/BHYEnjbuu8cKWthMklAi6AXS4qEO7c3WqXdZEGzubL8HdIFt5Op5el+4edcfSbguUE4GLrvGzIW8nzn2zbxxResBLK7xTER5O3Zylvh94Hly
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(7416002)(53546011)(6506007)(31696002)(38070700005)(8936002)(86362001)(76116006)(91956017)(8676002)(66446008)(66946007)(66556008)(66476007)(508600001)(122000001)(2616005)(6486002)(966005)(83380400001)(64756008)(71200400001)(54906003)(6512007)(110136005)(31686004)(316002)(36756003)(38100700002)(186003)(26005)(5660300002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGlqLzY5c3dMbHRnd05tSkJpT2RXL3NWd0FNL25MMFVHYmdyc3ZZRTkvenVM?=
 =?utf-8?B?OFNTdW82TFVHbFQySjFxTnVhRllibGZqeklPK0NkSVZoajFJV1h6QWFmeU1t?=
 =?utf-8?B?QnhKekpHRzR5cTNuNUZxMnZVdGQ3Y1JaUGtYcGc1Y3F2bzBsa1B0QTdud2Rv?=
 =?utf-8?B?WHdNZmFKWUZ1WGFFem9RTEF4UHlvaGFnKzFwc2RzOUZlVnRPUW9CU0FPVXNm?=
 =?utf-8?B?SHIrR29kZ1l3OFcvTFRES2tBdFR0K0Zza3FKaWEzc1NZMzRzaUw2R0tQSG4r?=
 =?utf-8?B?eXhPU1BYMmI3T0JXbWQvcHROMWNmZldEakdsMHZoSmdFSG5Pay9SU1crRzdw?=
 =?utf-8?B?K0xRaUswMmFadkVHYkhseWEwOUtjUXdUU1J2cUs5K1hWbTFMOTMwNVpxNklQ?=
 =?utf-8?B?a2J6anh2Qm1zZE1jaVQ0c2d4TGlyTFJHOXJxaGxIcXhOcndxMXZFNVhHcUUr?=
 =?utf-8?B?bGlUUUxxcE9qUS9BRWJZNDdLb1h0MEdydFpRSkdHdFhXUVplQ3dlQlB3bHBP?=
 =?utf-8?B?NHIyZTNGVkRCVFpSODZhNEpNSGp6MUhqK2tNVjFnVWJaWGVrbWp3SnJPMGRY?=
 =?utf-8?B?RU50WEFKTEJtd1dYU2V4djJPSTBIbHRFR1EyZjBLYTR6S2hmQ2lwQ25STHZW?=
 =?utf-8?B?M05Qa0xrWnNiYUE2UytOQndQZm5UR3NPd1E5TzAwalFzTjR4a3M5cU1ucHh0?=
 =?utf-8?B?QkdLODZpYVZGbk5nSWI5MmxKZ0ZUQlRjc0NscHc4c1Awek5RU0EzZ0pOK3Nr?=
 =?utf-8?B?WTkyNTFEM21SK0ZUT1NwNEpMRFd6UEFGempzNHk0WnoyUGQ2eFA2ZkFFYjBm?=
 =?utf-8?B?VUpJL05wZ3JkOTN2NTdLWXpvV1lKdFRCVnNnMnBBcHdOQ2hoUmpmREZOeSs5?=
 =?utf-8?B?OTJzaU0yRHFic3NydVNaenFEbS9NMUNtUHR6dmYwRDF0b2FLRThxaXUyVERM?=
 =?utf-8?B?N3huRUdsbDR5UG90ejVXdFBTT0Z0ZUlYdDFOcUxLcGNhZ3dXc1RONFRRSkRm?=
 =?utf-8?B?WXBCdmkzTkVHYWd3c0tUSm5kME1RZFZHM25EZkxRYXdiem9aS2IweTQ1Zjhp?=
 =?utf-8?B?WWdZbUVZTDBKclVwd2hQcjlLZy9sbTIwc0gyei9BZmV3SGhxeStjV2p1TWZn?=
 =?utf-8?B?Uy8rTmpIc21UV0kzMnk0bGZHM0VreHlvb1Y2bzcxV1ZvcDlDdlBHZERUV29S?=
 =?utf-8?B?ZzBxSXBkSXhxTmdKWFVvdyt5aDJZK1VDZm0wSWRvRmlQNHVNNjdaOTY3S2ZZ?=
 =?utf-8?B?dDNWVU1ZckdEbzdnTUh1dFI5bHM5SG9nckNhY1l2bG1HZXlEN3A5ZzgvOHVJ?=
 =?utf-8?B?eDNMdi9rOHpYSnVGeGJBT045dlFGT29BUVVaNmJDWkxhQUlqZ1RucUNwOEl3?=
 =?utf-8?B?UlJ1U056SlNMOVZqeE5raitGQlNUSEdnYnlSSVV3ZmVRalJpcnFFODZoWnpX?=
 =?utf-8?B?STdieExJcmlvbm8xY0I4YjJISkVJL3hzSnc0eHhIWW8yQ3JUc2pMTk1CTTNH?=
 =?utf-8?B?Q0YrcVNLZzdOS0U0YkZvSVo4cnlnMi9MbTRQNUdTWUwzTGE1YWIzbXZmQVB6?=
 =?utf-8?B?d2tDRFNMekRCMjJacGhBMGpTQmJpaXR2ckxsQzV5UFR3RkdZZHVUTCt0ZWlS?=
 =?utf-8?B?Wm5EbUM0aEpENDRzT1dnQzJoeWJ1N09DMXd2VFp3QmZvOCticmdrcFY1Nkg4?=
 =?utf-8?B?dStmbngxMFhGVW9zSitWOHRKTWNMQlFmK29PbjBHazlGbXJxeWtzVDIwUm1Q?=
 =?utf-8?B?TzlUbjhtUnR0OHY2L2w2MTRSTmQzbDZqVG9yYXErRGlhdTNMelR6czgyVkxl?=
 =?utf-8?B?RStJaFduZlM3YnlvSjNLUzZBNFRwRXMxcTJrY3Y1bmNnZU1pKzJEbmpMSjJz?=
 =?utf-8?B?YmtoaDI1S3g2d1ZNTHRwZ2I5YTYreklmK1RPcW1sZkVGMkVJV0F2TGxVSzlJ?=
 =?utf-8?B?eFFnSXE3S0NJajFFK0EvQjNoaEVmeXhVTlU5eTZaQnJJMnNpLzRBVEhFdGNQ?=
 =?utf-8?B?YThHakZoS3ozT1g0UzR5RzYvdzJwSlFVY3JRSnNvcnVtZUYxVG1nSERveFZm?=
 =?utf-8?B?eXNXMUpYWFE5bk1od3NOTnpOZlI1cEVCbnNVR1FuK2pmcUw1TzJRMThXb2Vp?=
 =?utf-8?B?WnJKcyt4ZnhpOTd1ZWVhZ2luOVNRU1NRTWtEc2RzaVdXc3NVbU5ScklZOXpP?=
 =?utf-8?B?UnJPRmtMZXg4djEvdVRscVk0SzZ5Mk8zbjIvOVA0Z3dKT0tmRno2S0Zrak9J?=
 =?utf-8?B?SVlnK3V5WjAyYkJkaHUzNThzU3pRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22E259C94BA52646A7A8A73AC7D1E362@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea89431f-193a-4dc1-b822-08da004397d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 14:05:53.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfSzXlzZ/3bdcuGcCHh3GvNCAmztBOIvQNUan8n5o0lqImKfzEZ4HgzxD9ZROHuZdzNrWsNYAcDeG/4TkYhzIBgG783hzdxT1Mz6kBT4JUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMiAxNToyMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDcv
MDMvMjAyMiAxNDowMywgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252ZXJ0IFBXTSBiaW5kaW5n
IGZvciBBdG1lbC9NaWNyb2NoaXAgU29DcyB0byBEZXZpY2UgVHJlZSBTY2hlbWENCj4+IGZvcm1h
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9j
aGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXRtZWwt
cHdtLnR4dCAgICAgfCAzNSAtLS0tLS0tLS0tLQ0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9wd20vYXRtZWwtcHdtLnlhbWwgICAgfCA2MiArKysrKysrKysrKysrKysrKysrDQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQo+PiAgIGRl
bGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2F0
bWVsLXB3bS50eHQNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wd20vYXRtZWwtcHdtLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hdG1lbC1wd20udHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hdG1lbC1wd20udHh0DQo+PiBkZWxldGVk
IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IGZiYjUzMjViZTFmMC4uMDAwMDAwMDAwMDAwDQo+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2F0bWVsLXB3bS50
eHQNCj4gSSB3b3VsZCBwcmVmZXIgZm9yIG5ldyBmaWxlcyB0byBzd2l0Y2ggdG8gY29tbW9uIERU
IGNvbnZlcnNpb246DQo+IHZlbmRvcixuYW1lLnlhbWwNCj4NCj4gWW91IGhhdmUgdGhlcmUgYW5v
dGhlciBQV00gYmluZGluZ3MgZm9yIEF0bWVsLCBzbyB0aGUgbmFtZSBzaG91bGQgbm90IGJlDQo+
IGp1c3QgInB3bSIgYnV0IHNvbWV0aGluZyBtb3JlIHNwZWNpZmljLCBtYXliZSAiYXQ5MXNhbS1w
d20iPw0KPg0KPg0KVW5kZXJzdG9vZCwgeWVzLCBpdCBkb2VzIG1ha2UgbW9yZSBzZW5zZSBsaWtl
IHRoaXMuIFRoYW5rIHlvdSBmb3IgdGhlIA0Kc3VnZ2VzdGlvbiwgSSB3aWxsIHJlbmFtZSB0aGUg
ZmlsZSB0byBgYXRtZWwsYXQ5MXNhbS1wd20ueWFtbGAuDQoNCj4+ICsrKyAvZGV2L251bGwNCj4+
IEBAIC0xLDM1ICswLDAgQEANCj4+IC1BdG1lbCBQV00gY29udHJvbGxlcg0KPj4gLQ0KPj4gLVJl
cXVpcmVkIHByb3BlcnRpZXM6DQo+PiAtICAtIGNvbXBhdGlibGU6IHNob3VsZCBiZSBvbmUgb2Y6
DQo+PiAtICAgIC0gImF0bWVsLGF0OTFzYW05cmwtcHdtIg0KPj4gLSAgICAtICJhdG1lbCxzYW1h
NWQzLXB3bSINCj4+IC0gICAgLSAiYXRtZWwsc2FtYTVkMi1wd20iDQo+PiAtICAgIC0gIm1pY3Jv
Y2hpcCxzYW05eDYwLXB3bSINCj4+IC0gIC0gcmVnOiBwaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5k
IGxlbmd0aCBvZiB0aGUgY29udHJvbGxlcidzIHJlZ2lzdGVycw0KPj4gLSAgLSAjcHdtLWNlbGxz
OiBTaG91bGQgYmUgMy4gU2VlIHB3bS55YW1sIGluIHRoaXMgZGlyZWN0b3J5IGZvciBhDQo+PiAt
ICAgIGRlc2NyaXB0aW9uIG9mIHRoZSBjZWxscyBmb3JtYXQuDQo+PiAtDQo+PiAtRXhhbXBsZToN
Cj4+IC0NCj4+IC0gICAgIHB3bTA6IHB3bUBmODAzNDAwMCB7DQo+PiAtICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTlybC1wd20iOw0KPj4gLSAgICAgICAgICAgICByZWcg
PSA8MHhmODAzNDAwMCAweDQwMD47DQo+PiAtICAgICAgICAgICAgICNwd20tY2VsbHMgPSA8Mz47
DQo+PiAtICAgICB9Ow0KPj4gLQ0KPj4gLSAgICAgcHdtbGVkcyB7DQo+PiAtICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAicHdtLWxlZHMiOw0KPj4gLQ0KPj4gLSAgICAgICAgICAgICBkMSB7DQo+
PiAtICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAiZDEiOw0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgIHB3bXMgPSA8JnB3bTAgMyA1MDAwIDA+DQo+PiAtICAgICAgICAgICAgICAgICAgICAg
bWF4LWJyaWdodG5lc3MgPSA8MjU1PjsNCj4+IC0gICAgICAgICAgICAgfTsNCj4+IC0NCj4+IC0g
ICAgICAgICAgICAgZDIgew0KPj4gLSAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0gImQyIjsN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICBwd21zID0gPCZwd20wIDEgNTAwMCAxPg0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgIG1heC1icmlnaHRuZXNzID0gPDI1NT47DQo+PiAtICAgICAgICAg
ICAgIH07DQo+PiAtICAgICB9Ow0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wd20vYXRtZWwtcHdtLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL2F0bWVsLXB3bS55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mNTM3OGEyMjI2YmQNCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXRtZWwtcHdtLnlh
bWwNCj4+IEBAIC0wLDAgKzEsNjIgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICsjIENvcHlyaWdodCAoQykgMjAyMiBN
aWNyb2NoaXAgVGVjaG5vbG9neSwgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyVZQU1M
IDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcHdt
L2F0bWVsLXB3bS55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBBdG1lbCBQV00gY29udHJvbGxl
cg0KPiB0aXRsZTogQXRtZWwvTWljcm9jaGlwIFBXTSBjb250cm9sbGVyDQo+DQo+PiArDQo+PiAr
bWFpbnRhaW5lcnM6DQo+PiArICAtIENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNy
b2NoaXAuY29tPg0KPj4gKw0KPiBhbGxPZiBpbmNsdWRpbmcgcHdtLnlhbWwNCj4NCk5vdGVkLg0K
DQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+PiAr
ICAgICAgLSBhdG1lbCxhdDkxc2FtOXJsLXB3bQ0KPj4gKyAgICAgIC0gYXRtZWwsc2FtYTVkMy1w
d20NCj4+ICsgICAgICAtIGF0bWVsLHNhbWE1ZDItcHdtDQo+PiArICAgICAgLSBtaWNyb2NoaXAs
c2FtOXg2MC1wd20NCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+
ICsgICAgICBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxl
cidzDQo+PiArICAgICAgcmVnaXN0ZXJzDQo+IFNraXAgZGVzY3JpcHRpb24sIGl0J3Mgb2J2aW91
cy4NCj4NCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgICIjcHdtLWNlbGxzIjoNCj4+
ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBTaG91bGQgYmUgMy4gU2VlIHB3bS55YW1s
IGluIHRoaXMgZGlyZWN0b3J5IGZvciBhDQo+PiArICAgICAgZGVzY3JpcHRpb24gb2YgdGhlIGNl
bGxzIGZvcm1hdC4NCj4gU2tpcCBkZXNjcmlwdGlvbiwgaXQncyBvYnZpb3VzLg0KPg0KPj4gKyAg
ICBjb25zdDogMw0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiAr
ICAtIHJlZw0KPj4gKyAgLSAiI3B3bS1jZWxscyINCj4gU2tpcCBwd20tY2VsbHMsIHJlcXVpcmVk
IGJ5IHB3bS55YW1sLg0KPg0KVW5kZXJzdG9vZCwgd2lsbCByZW1vdmUgaXQgaW4gdGhlIG5leHQg
dmVyc2lvbiBhbG9uZyB3aXRoIHRoZSB1bm5lY2Vzc2FyeSBkZXNjcmlwdGlvbnMuDQoNCj4+ICsN
Cj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4g
KyAgLSB8DQo+PiArICAgICAgICBwd20wOiBwd21AZjgwMzQwMDAgew0KPj4gKyAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05cmwtcHdtIjsNCj4+ICsgICAgICAgICAg
ICAgICAgcmVnID0gPDB4ZjgwMzQwMDAgMHg0MDA+Ow0KPj4gKyAgICAgICAgICAgICAgICAjcHdt
LWNlbGxzID0gPDM+Ow0KPj4gKyAgICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICAgIHB3bWxlZHMg
ew0KPiBTa2lwIHRoaXMgbm9kZS4gTm8gYWN0dWFsIGJlbmVmaXQuIEFsbCBjbGllbnRzIGFyZSB0
aGUgc2FtZS4NCj4NClVuZGVyc3Rvb2QuIEkgd2lsbCBpbmNsdWRlIGBwd20wYCBvbmx5Lg0KDQo+
PiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicHdtLWxlZHMiOw0KPj4gKw0KPj4gKyAg
ICAgICAgICAgICAgICBsZWQtMSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgbGFiZWwg
PSAibGVkLTEiOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHB3bXMgPSA8JnB3bTAgMyA1
MDAwIDA+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIG1heC1icmlnaHRuZXNzID0gPDI1
NT47DQo+PiArICAgICAgICAgICAgICAgIH07DQo+PiArDQo+PiArICAgICAgICAgICAgICAgIGxl
ZC0yIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJsZWQtMiI7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgcHdtcyA9IDwmcHdtMCAxIDUwMDAgMT47DQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgbWF4LWJyaWdodG5lc3MgPSA8MjU1PjsNCj4+ICsgICAgICAg
ICAgICAgICAgfTsNCj4+ICsgICAgICAgIH07DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQoNClRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbGVkIGZlZWRiYWNrLg0KDQpTZXJnaXUNCg0K
