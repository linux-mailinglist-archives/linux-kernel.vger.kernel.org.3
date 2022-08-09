Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4B58E1BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiHIVVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiHIVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:21:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474F61D7C;
        Tue,  9 Aug 2022 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660080068; x=1691616068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O+xH6XF+8EN5diJ43qBm2zryexmSiicR9pAbu/84JCA=;
  b=GyF+xnJHO++z/SlikM29T8et3S6rFk2X4lqeWb3BUr9LbHnXg0WHX3vI
   9j7rGA5swVr/K8lrHlHWvjXCufI0RS1mGhbFPLhCurDHkzpSUpj1wlJ1l
   oSjfU+v7npS42WVjkKzzFLPHHCkcYDdYrucwsM9TdS3+LDr1trTXdsVUR
   PmfmMPOyS9P3luwvY2hDkLO5d9Y/PylUGwqdmIi5anudaK5RZneC6qIBH
   17FF+aaw1MAetQ4WYRgu1FksD/i/9uMTO7LPVhm/GnbXpL61jrwqjDvbl
   4GjyeykHqugvVyJcEX8SifMy1tsQYWERHHOJGGLcqAfeG1eR9aBw2DVB3
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="108302870"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:21:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 9 Aug 2022 14:21:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATcqET1IY7fJsvk5BXc4T0tIP0AWv2iMcp+kwDd8buOdwg5oZFNsMM2qMFOhAHQ8UX8Eeoxx2vDePTcvcCL9/x84VQBAEaPzumXKPluHPHn6vsATJB04yVLoBXWMZThVpuxy9ao40LLPLnGXwg9AnaqM+CrxtJsIcxGHmVrruwn19aCPWbIEfOoHbxFnd3iuA7ErWtj5UKlS4YE9uk+w0mWSJj6VlZSmHVWarV/Y+hxmoeWapi7CMjx7sScq5Yg0VSmgOZAKyGBl7W3ksdrVYEInSImUslgQ155t2qWcKHLnaqYgHp/hvrQlbxIR32lVvLcgWE/EKltsMej7oEhkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+xH6XF+8EN5diJ43qBm2zryexmSiicR9pAbu/84JCA=;
 b=QnzUxrzSEK6uRu43QAyprXC79QEOunWxKibwVT9Cx/r6jD2InYd0fRplx89agcjO+43N7LpPuMiGZ7dO7H+y/QjLGVkFoyU3eT7PtoEa48dAjGq5sX2pkRZc1u+lq5X+uZsaD7gLZxBvQ62vcVggJ9OROPN/DXLYWvqhlwA+T4t3J+h5M1GzfP7tUIkeI3eQ5Fmwz99XQ4B3RjFZ6emv0acPi3TFQOSnrxPEwYQIQUvI9kleQVX2oXg5dD6OgDQTTJq7krSioKaI1Xh/pPGenVG3CrnOZmLVX54fD1FkWIwm9uiMDQZzW6La6JzuQ/mc2kloJCUjXr39aExHYk3Bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+xH6XF+8EN5diJ43qBm2zryexmSiicR9pAbu/84JCA=;
 b=bOxcyMS+aITZzdQMWhzaJyaHeR7RniwvPFv9esx6SPy834nnmJd5ubsr71WUDaFcp0IdL5rFKqvFIsPGYGMqkzGzoigIUAcYG3zBAo5noXvoEF/DoMYW9t/IOYXcG9bm7w6CJmf2h6PHkVWG3wsm9MxaweO4CoTNRfhOqRo81bQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:20:59 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:20:59 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
        <mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>,
        <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <corbet@lwn.net>, <Conor.Dooley@microchip.com>
CC:     <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
        <heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
        <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V5 6/6] RISC-V: Fixup schedule out issue in
 machine_crash_shutdown()
Thread-Topic: [PATCH V5 6/6] RISC-V: Fixup schedule out issue in
 machine_crash_shutdown()
Thread-Index: AQHYpmoLA+DDZV95YE2FObVUx/d5BK2nHwKA
Date:   Tue, 9 Aug 2022 21:20:59 +0000
Message-ID: <7b8d02c1-c631-0e0b-4c78-6370ab288995@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-7-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-7-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0b16186-03db-453e-0783-08da7a4d0e41
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRcSzs7b9aGc6cyy3lGzYrELANUVDSjZFZSy2pRh1NTI+kTinE0XEDYbnHwggIVSERy2sOSGzho6CIcg8NjrL8cvAfq5Ul3bBPdD9rRTuwhX0YGerW/3BEol4pyxyNB28nHHR07AawavMgK0Sb7M8/N0I/whGidVQNgh0RMNPqb1FCwb2zv0YHf6SE9XeztRU0wO9wLvPm550uu/MQFrgOq5vXzJdso7g3io1r0cDZzvz6HMTPL+91u/vF2BFO8a7pQZ73JqzWvWy9oIErot0Du3e8ndJJz5O5iWH7Y1ByDAW1FqFDjDIfO4cIH7UVTo7096NNhYtGn1CjPcT0viyPzLMBfo/htMkPn8fh4Gd6XhOwMss4CH0wlfouAwy57PlJE5cQu+xj4CfSl33MLUjRUpfopd5Cybm85ppxVTJVJvn97fk+qUKeEUuOIoFhKNBmwZ3+9M7PnSDidTCSiHURharUmAdbqIbE1/lR3ymCZRr8E3H7ES8v7fIdbqs5GAfOrvGs1CKiw/YU6De/ZrQYIQsvuhMJWwh6UNs0Yn37DtvjzuePgB8r/M8gRunyBbpjVPtW8kRWcWwz6Fnd0bdmv/FGZu/m+D61GIWdRRU7gp39VCu5+BU/HjvzgI/6j6oCcBceVNWZ0wr4OzhlbtPWCA4wIMMk+CR501hJ0C3Ul/oL1X0SZqKmH1n+4ICe9hUnMPmspJ0K7saxtB0vRnGiREg7nAQ2gbt0eeWFVrYypYj3IcuaFZUN2sQ0/iEtE5XZ6jOz9DhuFoHJS90PLj3LIhuJiugNhH7CjQdvqGQq9hOWQmc/Hd744FcpBVjZwlzU4zQH2NroX+omrt2cCP3aJRavgrTr3SsdHa7nOtQamrLFF37IzciwXtoBUwAk1KLyEHXANSqswh2z7I/oiyFAjwbqT472tFoGIpwljBagWdCAtGzu3DZzzOjdfCqMAE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(83380400001)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1VNMjZSQkNNaEhMbDRDWENGNCtHaW1pRnBOOVlpTEQxaVBGR1RKVlZwcUQx?=
 =?utf-8?B?bnpZY0ExajhKRHQ5QWZjZ0J0b3NCVm1JYllXazRjcXdzWWdmQVB3a2I4d0VH?=
 =?utf-8?B?M3YxSmtVQkZkRXZTVlNxQ0Y1bmdiSjNyYldQb0Vta2diOCtFVWtIa0J3Z3RJ?=
 =?utf-8?B?QVV6TWFDdWZObGp3eEM2YmNkNGhGdGdabzhBclBYUXhIV1lubWs5b1lWdzJW?=
 =?utf-8?B?ZFI5VzZoYk1TeWRtSy9MRnMvdm5wL1BvU01tK1RSM2xUY3VuQ2xFTURnUHpM?=
 =?utf-8?B?SHBjT2FxQjEvZWo5TnNuUkVySGk0K3dybVlZYy9XTEZyWEFKYnlVSUlYWmNr?=
 =?utf-8?B?ekhHNlZORS96eDRnbzBkeHV3c0c5ZmRtK3hUVVhYeFJRMDFLUW1XcEo2RjFX?=
 =?utf-8?B?bmtqVGIrYnVxZHZYU244cGtBWEVWWjIxUVMrNFdtNE0vRXhxTUxHYmhwSkhX?=
 =?utf-8?B?Y1Z1RWJjbU44ZU0yL3orSEppWmNKbHk2M2VmNE9kdnFsVUhONGNNb1lRbklE?=
 =?utf-8?B?aS9JL0FEMTZJbXJGYmxWRHNmcUpQamdBMUZsdk5wZGdnZE9PaTVQY011NlJQ?=
 =?utf-8?B?MHk2ZWZ1T2RpUCt3UlFsbllua1dod2dUTkpYUVc1ZGpWenNZYkhkUjBCa3Rt?=
 =?utf-8?B?czdWTmJrTDU0VVZJSHJrWll1S21TRnhGRkNUYVpoYSs3Q29zbHl5bzFzVk9m?=
 =?utf-8?B?akM0d0lHZmpaRnVkMGV1b3VqZEFTS3pPVnRmcHhpLy80M3VKZ1NyZXRSNWVK?=
 =?utf-8?B?RmhuN2UyZzFOeEFvcFA1cEVKRzlzVnNuVjB4aE1kUEM1M0ZMWXRBMy9vcVZo?=
 =?utf-8?B?bFdmS05vaW9pdzF5QktGT0Urb1ZaSmd4UVJZcjhvYkhCNGV0KzdOU25YbWxC?=
 =?utf-8?B?TDE3K2lFQmJ0TVdDZGpvNTU2dXIrdWVHMjNCUStudE5EZ0cwZ3M5MFJwZmxI?=
 =?utf-8?B?M2doNHRVSzVyMnUwbUphU2M3bXZuVTF5ZE00U2Y4Y1NDelFSYkRVQ1V5bDhj?=
 =?utf-8?B?SU1xSFEvRnp0ZW92MGM5RGZFNFV3bVhmRHMzOVB3c3hWWVFWOHExeHRIcitk?=
 =?utf-8?B?UVNUNkQzY04vNE9NaHcyRUN0d2FnY1JhNzBpcXVqSWxXalFnNElHNVJoWjdt?=
 =?utf-8?B?VXRVc3JqNWNjVzVnb2QxMXJCSmtINFh1ZjhDNEdWNTlnbjUvSlFUdG5sL2lm?=
 =?utf-8?B?aTFraGUzT2t4YVkxN3JtNmx6cStqQm9POHdab3dCWHlQdG9TR3VUcDdsRGdG?=
 =?utf-8?B?Ykl4YTBYOUhJbzhPUmxPc0VuVi94N1dabGVVQnJoVHc3U0E2ckhZU1IrdnJF?=
 =?utf-8?B?ekhmdGsycGNQVlZZMnJQV3Y2aXo3RzNpTnNmRnR6NjU3QmNlYTRBamMvdXAy?=
 =?utf-8?B?MmhieU5QVUlWU1hIa3BuOXBWQWhjVU0xVDl0YXFGbDBrVWhpQXRmNUhtaVcv?=
 =?utf-8?B?YmE1NGtSd05hYWM4NXVILytFQmNrTkVPbldQOGZOeFVENFEvT2pudHJVVEdW?=
 =?utf-8?B?dUNZOFQ3R0JnajFrRmpCU1h3NjNHN2ZJTEJUTjQ1VWNNWVFHOEZYd3F6eVBq?=
 =?utf-8?B?anljNnQrUGxvUlhOcXNyL0hRTkFNdElQOWo5QTUwL0pqUXBKK0ZxRnhkRVYw?=
 =?utf-8?B?Y1Z1WjVYVXFiTWNrVENYcVlqZDJSRkF5T3NHYWxLczZYV3c5bWR2NVA0OEFZ?=
 =?utf-8?B?ZFEzS3lTRXk4azJya21YS3gwMHJnalUxWnZLcVhsNUZsS3JlVmcvcXJqdFBp?=
 =?utf-8?B?MVI0WmM2NzlUTE8vMDE0UDgxVUxZZHpoRCt6ejZ4aGllWXR2enB6dThIM1cy?=
 =?utf-8?B?NXU3bC80SG9TbWdNSW0yaFJuQXhFdEtxVGRtdDlpR2dibVUzeS85U015QXZ5?=
 =?utf-8?B?bU1sRGNCWE9hakt5by9CWHFpaTZGR0N3QnhxbnZxRkFuOC9QVDJGMWo4TTFT?=
 =?utf-8?B?cGtKblZ4VGtVb0JLMGZWQTFRcCtmMDd4UWFNbHVWakdqcHVaTXkxYW4ramI1?=
 =?utf-8?B?R3JSSHlWamx4bHo1NFVtYjhBOERhTHZrSWNoMWMwemVEMDF2YkxNcm9FVEI1?=
 =?utf-8?B?bjRlYUx2WUNHeGxvcTdtNVpqT1MzbXJSTEdqVUc2S1dGQk1JRFBGWWhYdmFJ?=
 =?utf-8?Q?o+wmX8KA70kVlPJFwH9DNDz2I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D914B8D0CAEB74AACB681A639D9E035@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b16186-03db-453e-0783-08da7a4d0e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:20:59.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3k34a6Q1qabsMgXvebkTwd+++D0LDAELnPkmo5ykOtGsHkQKbtO3LgWIX//4Tp81qAIVOAGsGYHBSN2SJNv+wSZlOSLJYHjZZySJSXbGSG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDgvMjAyMiAxMzoxOCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gRml4dXAgc2NoZWR1
bGUgb3V0IGlzc3VlIGluIG1hY2hpbmVfY3Jhc2hfc2h1dGRvd24oKSwgd2hpY2ggaXMgdHJpZ2dl
cmVkDQo+IGJ5IFJDVSBTdGFsbC4NCj4gDQo+IFsyMjQ1MjEuODc3MjY4XSByY3U6IElORk86IHJj
dV9wcmVlbXB0IGRldGVjdGVkIHN0YWxscyBvbiBDUFVzL3Rhc2tzOg0KPiBbMjI0NTIxLjg4MzQ3
MV0gcmN1OiAJMC0uLi4wOiAoMyBHUHMgYmVoaW5kKSBpZGxlPWNmYS8wLzB4MSBzb2Z0aXJxPTM5
Njg3OTMvMzk2ODc5MyBmcXM9MjQ5NQ0KPiBbMjI0NTIxLjg5MTc0Ml0gCShkZXRlY3RlZCBieSAy
LCB0PTUyNTUgamlmZmllcywgZz02MDg1NTU5MywgcT0zMjgpDQo+IFsyMjQ1MjEuODk3NzU0XSBU
YXNrIGR1bXAgZm9yIENQVSAwOg0KPiBbMjI0NTIxLjkwMTA3NF0gdGFzazpzd2FwcGVyLzAgICAg
ICAgc3RhdGU6UiAgcnVubmluZyB0YXNrICAgICBzdGFjazogICAgMCBwaWQ6ICAgIDAgcHBpZDog
ICAgIDAgZmxhZ3M6MHgwMDAwMDAwOA0KPiBbMjI0NTIxLjkxMTA5MF0gQ2FsbCBUcmFjZToNCj4g
WzIyNDUyMS45MTM2MzhdIFs8ZmZmZmZmZTAwMGM0MzJkZT5dIF9fc2NoZWR1bGUrMHgyMDgvMHg1
ZWENCj4gWzIyNDUyMS45MTg5NTddIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBSQ1UgU3Rh
bGwNCj4gWzIyNDUyMS45MjM3NzNdIGJhZDogc2NoZWR1bGluZyBmcm9tIHRoZSBpZGxlIHRocmVh
ZCENCj4gWzIyNDUyMS45Mjg1NzFdIENQVTogMiBQSUQ6IDAgQ29tbTogc3dhcHBlci8yIEtkdW1w
OiBsb2FkZWQgVGFpbnRlZDogRyAgICAgICAgICAgTyAgICAgIDUuMTAuMTEzLXlvY3RvLXN0YW5k
YXJkICMxDQo+IFsyMjQ1MjEuOTM4NjU4XSBDYWxsIFRyYWNlOg0KPiBbMjI0NTIxLjk0MTIwMF0g
WzxmZmZmZmZlMDAwMjAzOTVjPl0gd2Fsa19zdGFja2ZyYW1lKzB4MC8weGFhDQo+IFsyMjQ1MjEu
OTQ2Njg5XSBbPGZmZmZmZmUwMDBjMzRmOGU+XSBzaG93X3N0YWNrKzB4MzIvMHgzZQ0KPiBbMjI0
NTIxLjk1MTgzMF0gWzxmZmZmZmZlMDAwYzM5MDIwPl0gZHVtcF9zdGFja19sdmwrMHg3ZS8weGEy
DQo+IFsyMjQ1MjEuOTU3MzE3XSBbPGZmZmZmZmUwMDBjMzkwNTg+XSBkdW1wX3N0YWNrKzB4MTQv
MHgxYw0KPiBbMjI0NTIxLjk2MjQ1OV0gWzxmZmZmZmZlMDAwMjQzODg0Pl0gZGVxdWV1ZV90YXNr
X2lkbGUrMHgyYy8weDQwDQo+IFsyMjQ1MjEuOTY4MjA3XSBbPGZmZmZmZmUwMDBjNDM0ZjQ+XSBf
X3NjaGVkdWxlKzB4NDFlLzB4NWVhDQo+IFsyMjQ1MjEuOTczNTIwXSBbPGZmZmZmZmUwMDBjNDM4
MjY+XSBzY2hlZHVsZSsweDM0LzB4ZTQNCj4gWzIyNDUyMS45Nzg0ODddIFs8ZmZmZmZmZTAwMGM0
NmNhZT5dIHNjaGVkdWxlX3RpbWVvdXQrMHhjNi8weDE3MA0KPiBbMjI0NTIxLjk4NDIzNF0gWzxm
ZmZmZmZlMDAwYzQ0OTFlPl0gd2FpdF9mb3JfY29tcGxldGlvbisweDk4LzB4ZjINCj4gWzIyNDUy
MS45OTAxNTddIFs8ZmZmZmZmZTAwMDI2ZDllMj5dIF9fd2FpdF9yY3VfZ3ArMHgxNDgvMHgxNGEN
Cj4gWzIyNDUyMS45OTU3MzNdIFs8ZmZmZmZmZTAwMDI3NjFjND5dIHN5bmNocm9uaXplX3JjdSsw
eDVjLzB4NjYNCj4gWzIyNDUyMi4wMDEzMDddIFs8ZmZmZmZmZTAwMDI2ZjFhNj5dIHJjdV9zeW5j
X2VudGVyKzB4NTQvMHhlNg0KPiBbMjI0NTIyLjAwNjc5NV0gWzxmZmZmZmZlMDAwMjVhNDM2Pl0g
cGVyY3B1X2Rvd25fd3JpdGUrMHgzMi8weDExYw0KPiBbMjI0NTIyLjAxMjYyOV0gWzxmZmZmZmZl
MDAwYzQyNjZhPl0gX2NwdV9kb3duKzB4OTIvMHgyMWENCj4gWzIyNDUyMi4wMTc3NzFdIFs8ZmZm
ZmZmZTAwMDIxOWEwYT5dIHNtcF9zaHV0ZG93bl9ub25ib290X2NwdXMrMHg5MC8weDExOA0KPiBb
MjI0NTIyLjAyNDI5OV0gWzxmZmZmZmZlMDAwMjA3MDFlPl0gbWFjaGluZV9jcmFzaF9zaHV0ZG93
bisweDMwLzB4NGENCj4gWzIyNDUyMi4wMzA0ODNdIFs8ZmZmZmZmZTAwMDI5YTNmOD5dIF9fY3Jh
c2hfa2V4ZWMrMHg2Mi8weGE2DQo+IFsyMjQ1MjIuMDM1ODg0XSBbPGZmZmZmZmUwMDBjMzUxNWU+
XSBwYW5pYysweGZhLzB4MmI2DQo+IFsyMjQ1MjIuMDQwNjc4XSBbPGZmZmZmZmUwMDAyNzcyYmU+
XSByY3Vfc2NoZWRfY2xvY2tfaXJxKzB4YzI2LzB4Y2I4DQo+IFsyMjQ1MjIuMDQ2Nzc0XSBbPGZm
ZmZmZmUwMDAyN2ZjN2E+XSB1cGRhdGVfcHJvY2Vzc190aW1lcysweDYyLzB4OGENCj4gWzIyNDUy
Mi4wNTI3ODVdIFs8ZmZmZmZmZTAwMDI4ZDUyMj5dIHRpY2tfc2NoZWRfdGltZXIrMHg5ZS8weDEw
Mg0KPiBbMjI0NTIyLjA1ODUzM10gWzxmZmZmZmZlMDAwMjgwYzNhPl0gX19ocnRpbWVyX3J1bl9x
dWV1ZXMrMHgxNmEvMHgzMTgNCj4gWzIyNDUyMi4wNjQ3MTZdIFs8ZmZmZmZmZTAwMDI4MTJlYz5d
IGhydGltZXJfaW50ZXJydXB0KzB4ZDQvMHgyMjgNCj4gWzIyNDUyMi4wNzA1NTFdIFs8ZmZmZmZm
ZTAwMDlhNjliNj5dIHJpc2N2X3RpbWVyX2ludGVycnVwdCsweDNjLzB4NDgNCj4gWzIyNDUyMi4w
NzY2NDZdIFs8ZmZmZmZmZTAwMDI2OGY4Yz5dIGhhbmRsZV9wZXJjcHVfZGV2aWRfaXJxKzB4YjAv
MHgyNGMNCj4gWzIyNDUyMi4wODMwMDRdIFs8ZmZmZmZmZTAwMDI2NDI4ZT5dIF9faGFuZGxlX2Rv
bWFpbl9pcnErMHhhOC8weDEyMg0KPiBbMjI0NTIyLjA4OTAxNF0gWzxmZmZmZmZlMDAwNjJmOTU0
Pl0gcmlzY3ZfaW50Y19pcnErMHgzOC8weDYwDQo+IFsyMjQ1MjIuMDk0NTAxXSBbPGZmZmZmZmUw
MDAyMDFiZDQ+XSByZXRfZnJvbV9leGNlcHRpb24rMHgwLzB4Yw0KPiBbMjI0NTIyLjEwMDE2MV0g
WzxmZmZmZmZlMDAwYzQyMTQ2Pl0gcmN1X2Vxc19lbnRlci5jb25zdHByb3AuMCsweDhjLzB4YjgN
Cj4gDQo+IFdpdGggdGhlIHBhdGNoLCBpdCBjYW4gZW50ZXIgY3Jhc2ggc3lzdGVtIHdoZW4gUkNV
IFN0YWxsIG9jY3VyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRp
bmcudGlhbkBsaW51eC5hbGliYWJhLmNvbT4NCg0KSG1tLCBpcyB0aGVyZSBhIEZpeGVzOiB0YWcg
Zm9yIHRoaXMgcGF0Y2g/IExvb2tzIGxpa2UgYSBmaXggdG8gbWUuDQpDb3VsZCB5b3UgYWxzbyBt
b3ZlIGl0IHRvIHRoZSBzdGFydCBvZiB0aGUgcGF0Y2hzZXQ/DQoNClRoYW5rcywNCkNvbm9yLg0K
DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvbWFjaGluZV9rZXhlYy5jIHwgMjYgKysrKysr
KysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL21h
Y2hpbmVfa2V4ZWMuYyBiL2FyY2gvcmlzY3Yva2VybmVsL21hY2hpbmVfa2V4ZWMuYw0KPiBpbmRl
eCA4NmQxYjVmOWRmYjUuLmVlNzllNjgzOWI4NiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9r
ZXJuZWwvbWFjaGluZV9rZXhlYy5jDQo+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL21hY2hpbmVf
a2V4ZWMuYw0KPiBAQCAtMTM4LDE5ICsxMzgsMzcgQEAgdm9pZCBtYWNoaW5lX3NodXRkb3duKHZv
aWQpDQo+ICAjZW5kaWYNCj4gIH0NCj4gIA0KPiArLyogT3ZlcnJpZGUgdGhlIHdlYWsgZnVuY3Rp
b24gaW4ga2VybmVsL3BhbmljLmMgKi8NCj4gK3ZvaWQgY3Jhc2hfc21wX3NlbmRfc3RvcCh2b2lk
KQ0KPiArew0KPiArCXN0YXRpYyBpbnQgY3B1c19zdG9wcGVkOw0KPiArDQo+ICsJLyoNCj4gKwkg
KiBUaGlzIGZ1bmN0aW9uIGNhbiBiZSBjYWxsZWQgdHdpY2UgaW4gcGFuaWMgcGF0aCwgYnV0IG9i
dmlvdXNseQ0KPiArCSAqIHdlIGV4ZWN1dGUgdGhpcyBvbmx5IG9uY2UuDQo+ICsJICovDQo+ICsJ
aWYgKGNwdXNfc3RvcHBlZCkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJc21wX3NlbmRfc3RvcCgp
Ow0KPiArCWNwdXNfc3RvcHBlZCA9IDE7DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBtYWNoaW5l
X2NyYXNoX3NodXRkb3duIC0gUHJlcGFyZSB0byBrZXhlYyBhZnRlciBhIGtlcm5lbCBjcmFzaA0K
PiAgICoNCj4gICAqIFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIGJ5IGNyYXNoX2tleGVjIGp1c3Qg
YmVmb3JlIG1hY2hpbmVfa2V4ZWMNCj4gLSAqIGJlbG93IGFuZCBpdHMgZ29hbCBpcyBzaW1pbGFy
IHRvIG1hY2hpbmVfc2h1dGRvd24sIGJ1dCBpbiBjYXNlIG9mDQo+IC0gKiBhIGtlcm5lbCBjcmFz
aC4gU2luY2Ugd2UgZG9uJ3QgaGFuZGxlIHN1Y2ggY2FzZXMgeWV0LCB0aGlzIGZ1bmN0aW9uDQo+
IC0gKiBpcyBlbXB0eS4NCj4gKyAqIGFuZCBpdHMgZ29hbCBpcyB0byBzaHV0ZG93biBub24tY3Jh
c2hpbmcgY3B1cyBhbmQgc2F2ZSByZWdpc3RlcnMuDQo+ICAgKi8NCj4gIHZvaWQNCj4gIG1hY2hp
bmVfY3Jhc2hfc2h1dGRvd24oc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ICB7DQo+ICsJbG9jYWxf
aXJxX2Rpc2FibGUoKTsNCj4gKw0KPiArCS8qIHNodXRkb3duIG5vbi1jcmFzaGluZyBjcHVzICov
DQo+ICsJY3Jhc2hfc21wX3NlbmRfc3RvcCgpOw0KPiArDQo+ICAJY3Jhc2hfc2F2ZV9jcHUocmVn
cywgc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCj4gLQltYWNoaW5lX3NodXRkb3duKCk7DQo+ICAJcHJf
aW5mbygiU3RhcnRpbmcgY3Jhc2hkdW1wIGtlcm5lbC4uLlxuIik7DQo+ICB9DQo+ICANCg==
