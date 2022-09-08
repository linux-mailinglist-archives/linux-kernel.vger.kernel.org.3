Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28235B14E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIHGpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiIHGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:45:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E2491E7;
        Wed,  7 Sep 2022 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619515; x=1694155515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k5nHV4wJVTMfvmZZ4toaFB5yMeg7uTyD5TSJ2Eh4WWY=;
  b=sqEd/tKoEiPN5UoZdRDXfYnIDXH2dijfmD2BQ/Sus8p9eIMS/INoeAig
   EMdRW10flwyNKlM2xSGTCz6lBnvxYD7rzflFg2z77Tkn+wfzjUmHydSEM
   ugcKE5c/tZ1nCmLZNqQ8sVfj+mxoF3/QkCmLhDpX6h6yV4LExEMaoOJvJ
   4q9Iaiq2jBOqvTqm4EJpk+dqeDOKqWrfpidhhwMlFljOZkFsUOM5IRjuA
   WW5ma3yCVxnG2f7M8NJbAwsdPeGu9PyDB4Bn1iBwxjIQxsN6yE6TT4Tdj
   YUe2hbtZaCYu7/2l3cMYCbbhb6Ghp4TpUVGjZUI74RTUHIjeoVaqxHHHB
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="179519055"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:45:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:45:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 23:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaZ1R5egh7ieei5PYXPL95KCEl2VZ71r6SJqiaVvlaWv5nlIs31HVrFwzxaVlQb6kVXGAL/cUwcs6PFRVr78khEWenDuIp+semGhXn3Zc9rENNYuIp2ixR8VVrsxgQG1UYSYd23Ce+k5PXuqMtX+DvjitORl2/1nMhAgWCJjHxtpcenXVlOaPmMvRxmRD0A0I9ndYOCcqzfjW/JgOF+yNVDe21Y7pCiJsV/6/8uyfnRRbw/sDqn6iWzj9d09BRAewVrfXUKWX9XJkDjEPX8Eoqy9GB0FofN0DKO5JE1R8b0djr5BfRmEjPSdEdKa/lqCQfVDM4wjbjHxsHuKrRXG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5nHV4wJVTMfvmZZ4toaFB5yMeg7uTyD5TSJ2Eh4WWY=;
 b=AlXs5jZOB2Jk7WK3EurekH/TqcP72GRGZ125J3gtcjrveV81x7xnvxmhtjxPo0Ys2XYF7B/bixwsS3xHoS8+bxl8y6DpF87E+A+CXgEy2/oYH7pFUmsPP908E8Z19CICZqXzi4DMhRdLpvlg6mlVZKoR0JNRa7jqATsMbJa7roxjK8jnlqTIPUOLvqxgnv7hab4buPbAEU4NXnUhxcpu8hxiyzbu70KN4l9cUwWMeDPR7oL6yNCfvZpSaEfLlioJ4p8hCSKVhSv1zrCm5lm7tbkBq9q54OrIblb0Ontv7yWGIRwbKI0oKbDu+XlyjLtPQiN8O4KDtSWDbKKRj8hSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5nHV4wJVTMfvmZZ4toaFB5yMeg7uTyD5TSJ2Eh4WWY=;
 b=RYkdqvKEZYOjGPpk5vdVBrSikZ5N76R22cClvFlN7/gpZxRucy3Mj2cjeHWTE5Ji90XaY4Qc7divQDMOvzjs31XryhH+ZCheiR7DGNkbl3oq9Igt7NhoG2lQOVBY9n8zlG3lvGBubLT85xOcGjCC0L9rGsBIJkFvuYRXmskuoVg=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:44:58 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:44:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 04/13] reset: add polarfire soc reset support
Thread-Topic: [PATCH v4 04/13] reset: add polarfire soc reset support
Thread-Index: AQHYw06Bq0bWR/4jpUiKQh8SMHzPyw==
Date:   Thu, 8 Sep 2022 06:44:56 +0000
Message-ID: <2005988c-56ac-fb9d-ef58-1b67e0c0fafe@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-4-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-4-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 112b4c9e-8dce-445e-9f24-08da9165a49f
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pGJnE1X5vfVU7X63IfDNn1fO9Mz6myoEkn0Gx53JDDN0VFrqXhLPfX6EFepJBhYDivfrajp+sgIZx1AM3oK6UqgWc1IvMRZIWtnhdgcjqsd5Ibu+qoS4MZZb7ol9FRyhEoWa0qZ2/imZ/PGcSoWmpZ2Er9Tv1IbOwA+5w+utKBhGaYxLeZvOAjzmJO7Bab4AC2i/q6pzVB9eUOjsQsJ2cuVI3zte3jn8lh6sacT1ThADgsADtQaNeAGQ81LhQW47jDLG/x7/g/S+BlFQOP8z5BNB4kYPmE2vMiFkFZXbr2HBywIGCEYCmKNP+j0Ar+BDUFpjDqnQT5BTXSHxSVT4baf0AUAyXduseME7HtUMIKoixTptINamxEjrqxC3Cz2cTCZasSD+VDkEfAMUnp3Hd6iW3pqFaqb/2CYnnAUJKm/1ivBhKhgqTQz4hzg6W/BSKfZiHLiCx5TYYTg4oRsW3BInpg2Y+AbOxXil05etmxLzxz2/p4ICLEAwcCnHQKYCdMvMdrwRyx5dHpPaUTslzsVmx3x9E63rEhmrzqNk4kIlB12/LgPk6121M8SK2laXlVWaFLnxzIqaw5emOp4dNSShzTg0bwcylfa9KDbZDrkRT8XI1Du/10YlgbyyEh3VxMDHfDJUSWuE76gQLlmt7PfEt0XgBsxzBIXLOPlFxpLHAkD1Su/Bvtl0iXpApDcFprac5lz2txbCKAQaQOg2y2vyNj80ftcK4NJm+jSG1b+R1+dUFvJCcTXxPr6ITLBCkZDLdMRA4de0vaFnPjqD4wA5eZcvpfiS6vM7oF9LqLlxrjQ9wg1k5O8FuO56XvRZ9mBufNqN2gN3TTkWrhdxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRlNndIMUczNVNRSm1FT2dnbWJqZ2NnTlEwRmNZak5IMFVNd1QyOTd5UHA4?=
 =?utf-8?B?Tmo0eHY4L3NQWDNkSDNIMUx5bmZabHRLVHVtaGk5aDY0MTVwdndtK3pIajZp?=
 =?utf-8?B?akVnaXp4cXlZRjhIVTNpTTV0T3dpc3F2TlAxY1hJbjdVRXM2eDl4bHoveXU4?=
 =?utf-8?B?SlhHaVBUOWZKQ2d6OEFjekVhb25CSEs0NmZIakJoM2xVUEdSb09PUndPanhm?=
 =?utf-8?B?QTZEU1J6U01MUVFDd3BHKzJna0NwOStBZXBYVUx2eXJ5Z1lGU1ZnejVuYmlJ?=
 =?utf-8?B?SzBhZDB2Ni9SeEkvbUFHbDNZM3FmQjhDcVIyUmtJNGs2c0NZRmZURW1TRFpY?=
 =?utf-8?B?YWZJcGlBWGtpamVjdVp2OE9teEZqem9hK2tPeWY5RXZRU1YvUzQzMVUya2V2?=
 =?utf-8?B?QVp4TVVydm55cVdUMmRzdjVIbnQ0VW9aUU1mc1hBSGl3RTc1aUxQMUk4MFhp?=
 =?utf-8?B?Z25vcEVsNnBCMmwvMEl4MnpCKzViTmFBUEl4YWN1ZElhQW5EM2pXcnVlSmM0?=
 =?utf-8?B?bCtjay9sOEpiMC9OblV3cnp6TW9EQnJvYWFhMzUxb3l4RC9vYlZqS04xS1ND?=
 =?utf-8?B?WFZ1SDk0V2JsVEF1a0d6Wm5kZ2F6QTR3WmY3OUszMkpjRlR3VmxESVhJRjNs?=
 =?utf-8?B?VGRNNWVmNlI4a1hRSVZPQkZyNTVzZkhFN1l2bnZpWDltYjVrbG5DYUJWS3R2?=
 =?utf-8?B?anNVQWp6U0R1TVdrT2ErYld2S3lObmRMZ0dwNktOZk5mRG1JTmJRQXBEQ0Iz?=
 =?utf-8?B?Vk5mK1NCdm51bEcwZFE1T1pxRjFFSUszSk12dlNqWVJCTDd1Wm91OXoyUnp0?=
 =?utf-8?B?VEh6cXhLaWpzaFVWVTN0YzJWZExjQ1orNVR0NjYvNU9vTTlGZGxOZ21ZVGlo?=
 =?utf-8?B?eGRHZ2RtS1NtMWROSE14WUZyV0gzcWdhR2hGbDdkTDUyWVdDVGFPNGZCSVNK?=
 =?utf-8?B?cFpLV1hzYVdoL2k3U01qSWZINTdaVnZGMVl5RitVRHBVanVBcUpzdHhCbzZI?=
 =?utf-8?B?WVlJNTJqK2hhUGwwU2tISzlRTDZIMUtHRytmd2EzU2hDOUw3cDVhY0d6MS9B?=
 =?utf-8?B?emZYRDg1Z0NVeTdGL1Y2S3cxTjJHMVVkdnQxUVY3M2k4cGFTbStBd1hWZzhC?=
 =?utf-8?B?T1p0QjhiaUFDakRkNjhwcmpyWWV1RlZ0OHpUbmpHaXh3RGFoL1ZWOEFXbnBM?=
 =?utf-8?B?dk1GVGNYUVBmYnhKVCtXMlYzZzNNTVpITjJuRDBoR3ZuVnoxc1pGNWxnN250?=
 =?utf-8?B?Y3BXNHFMUVdjOENNM2QvM1doOWIyQXIva09wUUttMnByTkhvZ1oxTXk4clVa?=
 =?utf-8?B?SWZTbVY0eWZzc0NYYnRyQWV3S0xPR0ZvbXA3b0FHNEE3TlBPTWdSOUZnUVVt?=
 =?utf-8?B?SHN1a2hXa2V6WHRtYlAxK0F2S1Q3L2VFTExkOVJuUnJUWmxubmVaMVBzd1BK?=
 =?utf-8?B?SnpuOFhQZEd6RWNrU1lIUldpVW5qWmVXYi9pYUVrU0xVWDlOMUFwNG1wU0s3?=
 =?utf-8?B?aWdMSTMwaGdORUlRVmFEMEpONTZ1bnIxNnNXbmlxYjRzRVZEWGJwSlJZZjA2?=
 =?utf-8?B?QnJTWGpPc1NQOE9CZytlYjR5NC8rLzN5ckxFblJteUkxOHhtUjNlZzg1RHl6?=
 =?utf-8?B?LzJPZ2x4eGE5enh0US9sVzZ1U2Fmc3hmRVFoTW94ZlVsRDJzV1NlQS9GZWwy?=
 =?utf-8?B?OEhXVGJSUW5QRi94dXg3UjJkQVFtdWtHWjE1Tm5BVUJTS1VadjltWFduU3hm?=
 =?utf-8?B?bmkwYUxrYlhLTFV6ajYyVUl2c2ZFdi9GRUJrbWJuSVAvazVzUC9saG15REdW?=
 =?utf-8?B?dkZmcXB0NW9DYXdTSjh0anBycTVWUHZzbkN6VmNIWFg2ekZ1dmdMRWhYclNx?=
 =?utf-8?B?dDF6a0JsVldIRTZDbXNqZ1kwRWtXWnlWY0lkb05JMGZSaUdxY1BTalZ5dlFm?=
 =?utf-8?B?SloyRldQMnBRUEl2SjczZ3hzZzJLd1laUVcvYjM1dUFpWm1MNTUxbzdIMkNH?=
 =?utf-8?B?Z2IzU3NMQTNTeURXKzJjd3pYeUZyTkJSTjFsUEliMm5NR2hzeFY4Rkx2eUxn?=
 =?utf-8?B?ZERGanZpMXo0ZGlPQ2JpWDE1bk9DUUFhUzRSUWE1WGF6QnUvQXFGZ2xycVNj?=
 =?utf-8?B?cXdqOFdTVXJKNHQrTUtiUStPR2VqL0I2TUJyTTJFeVNWV1REazhJZ242QjVQ?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E896461B0744694E8D21D2C664FC8EA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112b4c9e-8dce-445e-9f24-08da9165a49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:44:56.5526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXHZ6qAmndM5B1woVea/RrKyRcGPsXy+zxZk7IWu986MvBAyQs5xh0GGh011YL8VRst8M6wtTaNcMQMN4vnoTCj/8NH5zeL6KAYeake/wss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBBZGQgc3VwcG9ydCBm
b3IgdGhlIHJlc2V0cyBvbiBNaWNyb2NoaXAncyBQb2xhckZpcmUgU29DIChNUEZTKS4NCj4gUmVz
ZXQgY29udHJvbCBpcyBhIHNpbmdsZSByZWdpc3Rlciwgd2VkZ2VkIGluIGJldHdlZW4gcmVnaXN0
ZXJzIGZvcg0KPiBjbG9jayBjb250cm9sLiBUbyBmaXQgd2l0aCBleGlzdGVkIERUIGV0YywgdGhl
IHJlc2V0IGNvbnRyb2xsZXIgaXMNCj4gY3JlYXRlZCB1c2luZyB0aGUgYXV4IGRldmljZSBmcmFt
ZXdvcmsgJiBzZXQgdXAgaW4gdGhlIGNsb2NrIGRyaXZlci4NCj4gDQo+IFJldmlld2VkLWJ5OiBQ
aGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBBY2tlZC1ieTogUGhpbGlw
cCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gUmV2aWV3ZWQtYnk6IERhaXJlIE1j
TmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvcmVzZXQvS2NvbmZpZyAgICAgIHwgICA3ICsrDQo+ICBkcml2ZXJzL3Jlc2V0L01ha2VmaWxl
ICAgICB8ICAgMiArLQ0KPiAgZHJpdmVycy9yZXNldC9yZXNldC1tcGZzLmMgfCAxNTcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNjUg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvcmVzZXQvcmVzZXQtbXBmcy5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9L
Y29uZmlnIGIvZHJpdmVycy9yZXNldC9LY29uZmlnDQo+IGluZGV4IDgwNjc3M2U4ODgzMi4uODVm
N2FiZGUzNzY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L0tjb25maWcNCj4gKysrIGIv
ZHJpdmVycy9yZXNldC9LY29uZmlnDQo+IEBAIC0xNTIsNiArMTUyLDEzIEBAIGNvbmZpZyBSRVNF
VF9QSVNUQUNISU8NCj4gIAloZWxwDQo+ICAJICBUaGlzIGVuYWJsZXMgdGhlIHJlc2V0IGRyaXZl
ciBmb3IgSW1nVGVjIFBpc3RhY2hpbyBTb0NzLg0KPiAgDQo+ICtjb25maWcgUkVTRVRfUE9MQVJG
SVJFX1NPQw0KPiArCWJvb2wgIk1pY3JvY2hpcCBQb2xhckZpcmUgU29DIChNUEZTKSBSZXNldCBE
cml2ZXIiDQo+ICsJZGVwZW5kcyBvbiBBVVhJTElBUllfQlVTICYmIE1DSFBfQ0xLX01QRlMNCj4g
KwlkZWZhdWx0IE1DSFBfQ0xLX01QRlMNCj4gKwloZWxwDQo+ICsJICBUaGlzIGRyaXZlciBzdXBw
b3J0cyBwZXJpcGhlcmFsIHJlc2V0IGZvciB0aGUgTWljcm9jaGlwIFBvbGFyRmlyZSBTb0MNCj4g
Kw0KPiAgY29uZmlnIFJFU0VUX1FDT01fQU9TUw0KPiAgCXRyaXN0YXRlICJRY29tIEFPU1MgUmVz
ZXQgRHJpdmVyIg0KPiAgCWRlcGVuZHMgb24gQVJDSF9RQ09NIHx8IENPTVBJTEVfVEVTVA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9NYWtlZmlsZSBiL2RyaXZlcnMvcmVzZXQvTWFrZWZp
bGUNCj4gaW5kZXggY2Q1Y2Y4ZTdjNmE3Li4zZTdlNWZkNjMzYTggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcmVzZXQvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9yZXNldC9NYWtlZmlsZQ0KPiBA
QCAtMjIsNiArMjIsNyBAQCBvYmotJChDT05GSUdfUkVTRVRfTUVTT05fQVVESU9fQVJCKSArPSBy
ZXNldC1tZXNvbi1hdWRpby1hcmIubw0KPiAgb2JqLSQoQ09ORklHX1JFU0VUX05QQ00pICs9IHJl
c2V0LW5wY20ubw0KPiAgb2JqLSQoQ09ORklHX1JFU0VUX09YTkFTKSArPSByZXNldC1veG5hcy5v
DQo+ICBvYmotJChDT05GSUdfUkVTRVRfUElTVEFDSElPKSArPSByZXNldC1waXN0YWNoaW8ubw0K
PiArb2JqLSQoQ09ORklHX1JFU0VUX1BPTEFSRklSRV9TT0MpICs9IHJlc2V0LW1wZnMubw0KPiAg
b2JqLSQoQ09ORklHX1JFU0VUX1FDT01fQU9TUykgKz0gcmVzZXQtcWNvbS1hb3NzLm8NCj4gIG9i
ai0kKENPTkZJR19SRVNFVF9RQ09NX1BEQykgKz0gcmVzZXQtcWNvbS1wZGMubw0KPiAgb2JqLSQo
Q09ORklHX1JFU0VUX1JBU1BCRVJSWVBJKSArPSByZXNldC1yYXNwYmVycnlwaS5vDQo+IEBAIC00
MCw0ICs0MSwzIEBAIG9iai0kKENPTkZJR19SRVNFVF9VTklQSElFUikgKz0gcmVzZXQtdW5pcGhp
ZXIubw0KPiAgb2JqLSQoQ09ORklHX1JFU0VUX1VOSVBISUVSX0dMVUUpICs9IHJlc2V0LXVuaXBo
aWVyLWdsdWUubw0KPiAgb2JqLSQoQ09ORklHX1JFU0VUX1pZTlEpICs9IHJlc2V0LXp5bnEubw0K
PiAgb2JqLSQoQ09ORklHX0FSQ0hfWllOUU1QKSArPSByZXNldC16eW5xbXAubw0KPiAtDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LW1wZnMuYyBiL2RyaXZlcnMvcmVzZXQvcmVz
ZXQtbXBmcy5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4u
MTU4MGQxYjY4ZDYxDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNl
dC1tcGZzLmMNCj4gQEAgLTAsMCArMSwxNTcgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qDQo+ICsgKiBQb2xhckZpcmUgU29DIChNUEZTKSBQZXJp
cGhlcmFsIENsb2NrIFJlc2V0IENvbnRyb2xsZXINCj4gKyAqDQo+ICsgKiBBdXRob3I6IENvbm9y
IERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ICsgKiBDb3B5cmlnaHQgKGMp
IDIwMjIgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcy4NCj4g
KyAqDQo+ICsgKi8NCj4gKyNpbmNsdWRlIDxsaW51eC9hdXhpbGlhcnlfYnVzLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZXNl
dC1jb250cm9sbGVyLmg+DQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbWljcm9jaGlw
LG1wZnMtY2xvY2suaD4NCj4gKyNpbmNsdWRlIDxzb2MvbWljcm9jaGlwL21wZnMuaD4NCj4gKw0K
PiArLyoNCj4gKyAqIFRoZSBFTlZNIHJlc2V0IGlzIHRoZSBsb3dlc3QgYml0IGluIHRoZSByZWdp
c3RlciAmIEkgYW0gdXNpbmcgdGhlIENMS19GT08NCj4gKyAqIGRlZmluZXMgaW4gdGhlIGR0IHRv
IG1ha2UgdGhpbmdzIGVhc2llciB0byBjb25maWd1cmUgLSBzbyB0aGlzIGlzIGFjY291bnRpbmcN
Cj4gKyAqIGZvciB0aGUgb2Zmc2V0IG9mIDMgdGhlcmUuDQo+ICsgKi8NCj4gKyNkZWZpbmUgTVBG
U19QRVJJUEhfT0ZGU0VUCUNMS19FTlZNDQo+ICsjZGVmaW5lIE1QRlNfTlVNX1JFU0VUUwkJMzB1
DQo+ICsjZGVmaW5lIE1QRlNfU0xFRVBfTUlOX1VTCTEwMA0KPiArI2RlZmluZSBNUEZTX1NMRUVQ
X01BWF9VUwkyMDANCj4gKw0KPiArLyogYmxvY2sgY29uY3VycmVudCBhY2Nlc3MgdG8gdGhlIHNv
ZnQgcmVzZXQgcmVnaXN0ZXIgKi8NCj4gK3N0YXRpYyBERUZJTkVfU1BJTkxPQ0sobXBmc19yZXNl
dF9sb2NrKTsNCj4gKw0KPiArLyoNCj4gKyAqIFBlcmlwaGVyYWwgY2xvY2sgcmVzZXRzDQo+ICsg
Ki8NCj4gKw0KPiArc3RhdGljIGludCBtcGZzX2Fzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxl
cl9kZXYgKnJjZGV2LCB1bnNpZ25lZCBsb25nIGlkKQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+ICsJdTMyIHJlZzsNCj4gKw0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZtcGZzX3Jl
c2V0X2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXJlZyA9IG1wZnNfcmVzZXRfcmVhZChyY2Rldi0+
ZGV2KTsNCj4gKwlyZWcgfD0gQklUKGlkKTsNCj4gKwltcGZzX3Jlc2V0X3dyaXRlKHJjZGV2LT5k
ZXYsIHJlZyk7DQo+ICsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtcGZzX3Jlc2V0X2xv
Y2ssIGZsYWdzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50
IG1wZnNfZGVhc3NlcnQoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwgdW5zaWdu
ZWQgbG9uZyBpZCkNCj4gK3sNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArCXUzMiByZWcs
IHZhbDsNCg0KVXNpbmcgZWl0aGVyIHJlZyBvciB2YWwgaW4gdGhpcyBmdW5jdGlvbiBzaG91bGQg
YmUgZW5vdWdoLg0KDQpPdGhlciB0aGFuIHRoaXM6DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQoNCj4gKw0KPiArCXNwaW5f
bG9ja19pcnFzYXZlKCZtcGZzX3Jlc2V0X2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXJlZyA9IG1w
ZnNfcmVzZXRfcmVhZChyY2Rldi0+ZGV2KTsNCj4gKwl2YWwgPSByZWcgJiB+QklUKGlkKTsNCj4g
KwltcGZzX3Jlc2V0X3dyaXRlKHJjZGV2LT5kZXYsIHZhbCk7DQo+ICsNCj4gKwlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZtcGZzX3Jlc2V0X2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXJldHVybiAw
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG1wZnNfc3RhdHVzKHN0cnVjdCByZXNldF9jb250
cm9sbGVyX2RldiAqcmNkZXYsIHVuc2lnbmVkIGxvbmcgaWQpDQo+ICt7DQo+ICsJdTMyIHJlZyA9
IG1wZnNfcmVzZXRfcmVhZChyY2Rldi0+ZGV2KTsNCj4gKw0KPiArCS8qDQo+ICsJICogSXQgaXMg
c2FmZSB0byByZXR1cm4gaGVyZSBhcyBNUEZTX05VTV9SRVNFVFMgbWFrZXMgc3VyZSB0aGUgc2ln
biBiaXQNCj4gKwkgKiBpcyBuZXZlciBoaXQuDQo+ICsJICovDQo+ICsJcmV0dXJuIChyZWcgJiBC
SVQoaWQpKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtcGZzX3Jlc2V0KHN0cnVjdCByZXNl
dF9jb250cm9sbGVyX2RldiAqcmNkZXYsIHVuc2lnbmVkIGxvbmcgaWQpDQo+ICt7DQo+ICsJbXBm
c19hc3NlcnQocmNkZXYsIGlkKTsNCj4gKw0KPiArCXVzbGVlcF9yYW5nZShNUEZTX1NMRUVQX01J
Tl9VUywgTVBGU19TTEVFUF9NQVhfVVMpOw0KPiArDQo+ICsJbXBmc19kZWFzc2VydChyY2Rldiwg
aWQpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgcmVzZXRfY29udHJvbF9vcHMgbXBmc19yZXNldF9vcHMgPSB7DQo+ICsJLnJlc2V0ID0gbXBm
c19yZXNldCwNCj4gKwkuYXNzZXJ0ID0gbXBmc19hc3NlcnQsDQo+ICsJLmRlYXNzZXJ0ID0gbXBm
c19kZWFzc2VydCwNCj4gKwkuc3RhdHVzID0gbXBmc19zdGF0dXMsDQo+ICt9Ow0KPiArDQo+ICtz
dGF0aWMgaW50IG1wZnNfcmVzZXRfeGxhdGUoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpy
Y2RldiwNCj4gKwkJCSAgICBjb25zdCBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICpyZXNldF9zcGVj
KQ0KPiArew0KPiArCXVuc2lnbmVkIGludCBpbmRleCA9IHJlc2V0X3NwZWMtPmFyZ3NbMF07DQo+
ICsNCj4gKwkvKg0KPiArCSAqIENMS19SRVNFUlZFRCBkb2VzIG5vdCBtYXAgdG8gYSBjbG9jaywg
YnV0IGl0IGRvZXMgbWFwIHRvIGEgcmVzZXQsDQo+ICsJICogc28gaXQgaGFzIHRvIGJlIGFjY291
bnRlZCBmb3IgaGVyZS4gSXQgaXMgdGhlIHJlc2V0IGZvciB0aGUgZmFicmljLA0KPiArCSAqIHNv
IGlmIHRoaXMgcmVzZXQgZ2V0cyBjYWxsZWQgLSBkbyBub3QgcmVzZXQgaXQuDQo+ICsJICovDQo+
ICsJaWYgKGluZGV4ID09IENMS19SRVNFUlZFRCkgew0KPiArCQlkZXZfZXJyKHJjZGV2LT5kZXYs
ICJSZXNldHRpbmcgdGhlIGZhYnJpYyBpcyBub3Qgc3VwcG9ydGVkXG4iKTsNCj4gKwkJcmV0dXJu
IC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKGluZGV4IDwgTVBGU19QRVJJUEhfT0ZGU0VU
IHx8IGluZGV4ID49IChNUEZTX1BFUklQSF9PRkZTRVQgKyByY2Rldi0+bnJfcmVzZXRzKSkgew0K
PiArCQlkZXZfZXJyKHJjZGV2LT5kZXYsICJJbnZhbGlkIHJlc2V0IGluZGV4ICV1XG4iLCBpbmRl
eCk7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBpbmRleCAt
IE1QRlNfUEVSSVBIX09GRlNFVDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtcGZzX3Jlc2V0
X3Byb2JlKHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlICphZGV2LA0KPiArCQkJICAgIGNvbnN0IHN0
cnVjdCBhdXhpbGlhcnlfZGV2aWNlX2lkICppZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmYWRldi0+ZGV2Ow0KPiArCXN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXY7
DQo+ICsNCj4gKwlyY2RldiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcmNkZXYpLCBHRlBf
S0VSTkVMKTsNCj4gKwlpZiAoIXJjZGV2KQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiAr
CXJjZGV2LT5kZXYgPSBkZXY7DQo+ICsJcmNkZXYtPmRldi0+cGFyZW50ID0gZGV2LT5wYXJlbnQ7
DQo+ICsJcmNkZXYtPm9wcyA9ICZtcGZzX3Jlc2V0X29wczsNCj4gKwlyY2Rldi0+b2Zfbm9kZSA9
IGRldi0+cGFyZW50LT5vZl9ub2RlOw0KPiArCXJjZGV2LT5vZl9yZXNldF9uX2NlbGxzID0gMTsN
Cj4gKwlyY2Rldi0+b2ZfeGxhdGUgPSBtcGZzX3Jlc2V0X3hsYXRlOw0KPiArCXJjZGV2LT5ucl9y
ZXNldHMgPSBNUEZTX05VTV9SRVNFVFM7DQo+ICsNCj4gKwlyZXR1cm4gZGV2bV9yZXNldF9jb250
cm9sbGVyX3JlZ2lzdGVyKGRldiwgcmNkZXYpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGF1eGlsaWFyeV9kZXZpY2VfaWQgbXBmc19yZXNldF9pZHNbXSA9IHsNCj4gKwl7DQo+
ICsJCS5uYW1lID0gImNsa19tcGZzLnJlc2V0LW1wZnMiLA0KPiArCX0sDQo+ICsJeyB9DQo+ICt9
Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShhdXhpbGlhcnksIG1wZnNfcmVzZXRfaWRzKTsNCj4g
Kw0KPiArc3RhdGljIHN0cnVjdCBhdXhpbGlhcnlfZHJpdmVyIG1wZnNfcmVzZXRfZHJpdmVyID0g
ew0KPiArCS5wcm9iZQkJPSBtcGZzX3Jlc2V0X3Byb2JlLA0KPiArCS5pZF90YWJsZQk9IG1wZnNf
cmVzZXRfaWRzLA0KPiArfTsNCj4gKw0KPiArbW9kdWxlX2F1eGlsaWFyeV9kcml2ZXIobXBmc19y
ZXNldF9kcml2ZXIpOw0KPiArDQo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIk1pY3JvY2hpcCBQb2xh
ckZpcmUgU29DIFJlc2V0IERyaXZlciIpOw0KPiArTU9EVUxFX0FVVEhPUigiQ29ub3IgRG9vbGV5
IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4iKTsNCj4gK01PRFVMRV9MSUNFTlNFKCJHUEwi
KTsNCj4gK01PRFVMRV9JTVBPUlRfTlMoTUNIUF9DTEtfTVBGUyk7DQoNCg==
