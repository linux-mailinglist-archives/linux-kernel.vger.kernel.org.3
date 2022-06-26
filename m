Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9955B415
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiFZU4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiFZU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:56:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDA22DF3;
        Sun, 26 Jun 2022 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656276969; x=1687812969;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=24EM5/QQASX2tkebaifTNE0LLLNMFAUIty0PXyNXwSI=;
  b=X2amYMXqtiSqRRlWm72dxQB7HpFPjwTRN38O80+ue+VJQLxPD+Bupma8
   8D1R+vwgVXRoTKNWj4lO+gcfTFU1e5kcfa2d8sLM6wu2uDrWk/lUNPOxe
   RaOtnfeb1TSHoGfEIsmAbaNAl97hJ5QC4Za27LF9IbvUI0XQ0lvzGZaHA
   JyiOHZRlYo2MuxETDPonxnIykWr0bG01R6PpVBIVQ64Lw0H090n2NnbPy
   xHDfn0SPCp5sNwzZBDNl/yPH4ZPJjGuLK7DggPM1DkuOfrIM5S97Rx1DT
   WnsTRldVfNoOxDSSK3e2PH6z0Awsu9iSnklKRqSvMBJW08o//kekLT9a3
   g==;
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="101799283"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2022 13:56:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 26 Jun 2022 13:56:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 26 Jun 2022 13:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsVRXB9+LyWFzseUW27ptxXYu2wSscaKczMFbg5GDMVUBDpwoE2+UR2chtqbWN9tMBz5OVcXKiUHmXEa7hrcq2yJTcVsf43DB/3VrHGPD5MjHslKJJrWgYxh0krlFB9fhWnlU6LyT0g3Mbn3McojnqvJ0ppCFkGskfn6bqOR9wlfjnKc4LlAk0OumnglLtmLrgLW1Ri68q4S/0xO24hQlVwauwz/ZliAUCBvscKTW5+rCfFJKC8padFv+Pb7jxnRkjgItsF2dqp5wv6e9fxn5jdE0c/i8Klc8nHdHBDA5gt5rGLIx7qoeSHIq+pq8/iZpoqYRmSMz6JrkpyzFM1REw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24EM5/QQASX2tkebaifTNE0LLLNMFAUIty0PXyNXwSI=;
 b=MW7cJxR6/xq32oYNRbOF6U5eQzXWtSm9Pal61rDV+C6h06h6mQ5XuMw8dFraViSCdhjZSVfvU1FE+MNQAegKmfseegSxxprzg0mLAINYArD7mi+JWhojo+AmuYrUnKByoFpU5YU4kDKaUoGeHvFBNdPSMXFMMF/y9dXafER/I43+CEoMC4wuDXbuZwJAl2jVdE5LJDMmsXN8tfNPxS0d/P90QECoq5VzsyMkrlDnHrQrEWbXQGJjRJ9RHV/VDE9kPv+JbFDRvvJamASM2KuUhlOjHzvQjO0SBeA8BOS7VpkN+AFPMy7qf99eHKHEz6uAfOEKKNt3hLQJxe1PoH3YKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24EM5/QQASX2tkebaifTNE0LLLNMFAUIty0PXyNXwSI=;
 b=dNKCIhb6QYExlGBbLz93OL8dIR2KbqYn5Q9l7TZKHfQD5aSEW0oX+v8bdqglINxy7zx5d4BH0Cp43vjcQui38duweWYvNtUPXPuAulEYeiz6ZXsXFTyS79H/cglDhf/U3KYeqy0Av3QJZkH+O5t0gzC0II6tFjTjDWaRhjP/VoA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Sun, 26 Jun
 2022 20:56:00 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 20:56:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: align gpio-key node names with dtschema
Thread-Topic: [PATCH] riscv: dts: align gpio-key node names with dtschema
Thread-Index: AQHYh+0TSEsUfCu3dUCW8EahvV7Amq1iLm0A
Date:   Sun, 26 Jun 2022 20:56:00 +0000
Message-ID: <daf4a88e-ea33-be74-7e0a-b2ff20ea734f@microchip.com>
References: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ffa3a80-7c82-4f65-261b-08da57b6469a
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+XjyCBAQKIr0B0nk++klTblKs8nLd4JWKiN8FkM9++Wl86/9qaRYs40BNQ3HsJt5RKoRF81BhtGx1yDPbL9flUx+v0BEacAJcIRbQjqYbZoNpnjeISw3uHvbn3atUuCJQQHp3NZgy2wDZONKhlmXcXpNYjddpWyRSf4yONUqLgKuXtHOhAxENg8fedR/3mI4zzjPJdbBummyKZqL7zi4fNv4XAGSQcy7lE3L/f+HdQHTUt3Yw8L0g6FrogoJU5945tdIGaO460XnOdw5rOW/+FCXJRz9Xgcwso+bQJ6ersVU8PZ1AwFjP37stlTwBs5XuzRLLdupCAbD8ClWqeiTVAq3snozACgnKUdJq7LwE5jgRdyQAUAvXs5t0GGVOJlyjGt0PP6PLcvw+qXRpjxJS4npWwuCplBetphzSEQak+E1Slb2S/nY0MBSBIGrh6P7fAZzoPnndb2WaYmznntlzq3tHnVeDc4edCoVmNB7ZpsrdAQ5Ke7qZxL78cPKp4xMpIFS1EPgusHCe3KxoRPxnOy8QJ9ouh0jpvmcr6mfgIeVTLPsJ+3P2PrDs4lHtMmCg7CPdTmT6XQIQlsuujyq4QEBYXlBBMOPKDG2Jd9K1wf8BBW4hMtq84/Ungki6PxwVzfrftFK+G7Xz8F4Tcf/L8UPeaFIC/4JHJUJhHiLILgLp0evtADvVEu3bZ/HoZz4EdLCwn094D2deUHFl8rEm/Kqe79EWwFvKDfIQSLG9IZKwX5vmL7z+l2ULJuwOEtoxXYuplBtMdCURyH4t2S4aJvf1OM4FDatlxa8ZU6NmQ9126/jVVbz3POLH+ampNLSM0QaoIXZ+6TVzLuKiR+OM4+PQQrec8f8RZlfP2e7iMC1gneqa0yg5kjGZYU0TczgbwPF6jqfc38rlzw7xOrZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39850400004)(346002)(136003)(376002)(38070700005)(8936002)(5660300002)(53546011)(26005)(83380400001)(6506007)(6512007)(2906002)(91956017)(41300700001)(66556008)(8676002)(66446008)(76116006)(64756008)(66476007)(66946007)(31696002)(86362001)(6486002)(31686004)(38100700002)(2616005)(966005)(36756003)(71200400001)(122000001)(316002)(110136005)(186003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amFBenc2NnVuME9mWDhsMkZOblV4cUJZZERyUWVaZk1hZG0wblZtYkFrb1cr?=
 =?utf-8?B?dXhFcVRLRXB6YkREb2tBQnhOUWs3emplbnhVMzN3SmdlZnVrdFpNQUl0UTFs?=
 =?utf-8?B?MjRJZ1Q4endla2VoSE8yWW8rWDBoMEwzNnBvNTZueFkwdlgvV0J2NHlySThW?=
 =?utf-8?B?WjJrbmpOZ2IvYXFuT1gyNjdCMndET0FtSlNKQU94SjZLUFlreUV4Mnp5UktG?=
 =?utf-8?B?bGpURXMxaEM3WDI2ZVo2ZkhiVlQ5V0syald0SUpBaFI4NjVOKy8wY1JRSEw5?=
 =?utf-8?B?TlFYenJJaFhBdHFnb3RKbjlTazZjQzJuaUJnalhwL2pIK0tmRHFzMUdDUHRZ?=
 =?utf-8?B?T0xnUC9FbE5hcXEyN3pJUGtOMkxhMC95VDR0R1FkcGdZL3p2RVNkdnQrQ0kz?=
 =?utf-8?B?eUtNU2ZLK3JLaXJrazJ0N091enZEL0ZOaTdOcnBPS24wenpPYXdsb3BoSUZt?=
 =?utf-8?B?ZlZDN2VHSGNKS2lJWldEOWM2eDVId1pXL1VQVEZLeGovSzdSV2JnT1ZVbFB1?=
 =?utf-8?B?M0h4RmhzdXdVYU0zUjlUZStHTy8rNzliejBvVE5jTEJHZjY3NmNVdDgxZlVZ?=
 =?utf-8?B?NXl4eU5sUFpkUzRqZ0F4RHFuendEY0d3dmpUWlVtS2xPU0pkVXV6RzJVOFNO?=
 =?utf-8?B?NTNtMmt5NW5yTEQraGRiRTRRbnlRZ2lrTXpjWGxoVFJVTWpUY2JMZFFmSk45?=
 =?utf-8?B?aGEwNzJKR2lDK0JHSVJLakhQOFF3Sy9KSGoxYnZKY01SRjllQXZvWEY3dDQ2?=
 =?utf-8?B?ZmorWCt0Q0RjZTFtQUNCUHE0d3Vub3lNbUdsVEY3NDNHcWxEZlhHbkVFU3ds?=
 =?utf-8?B?eGpHNUVCbTE2MUtXeDRqUWVFaWl4Z3Z6a2ZJdE4zTVZMTFVoRVFTQ29zczBO?=
 =?utf-8?B?K25rZlIwUlJhZEU1OWg5UDRNUk1rdHQvNVkzK0xUMG9sTFlydVNaRHlEUmVu?=
 =?utf-8?B?Z1VCTWdMY0orL0xJMG91L0I4LzkvVWtrbDhKMDd5SzUzOHhYemc3THE4alh4?=
 =?utf-8?B?bFYzOXJJSmczdHNQUG05OVdIMllvQmJZWDNkeUR5d1p4R0JTVWV0YnZqcnFw?=
 =?utf-8?B?UFVtSXVZRjJ1R2k2Mjg3WUg5LzlVejRNcE9qWkR2MVlSVFhia1BNZE9mYjdj?=
 =?utf-8?B?dzh1bHJnSEJleG1CemJKaWNrY09tQ1FOWTltRlVUQUcvSDVWbmpYZUs1NzE4?=
 =?utf-8?B?bFQ4cW53RUlhaU04MHNncDdqcHJwMzQwUDFEWTRnTE9xeWRWb2Rid0xzdzY3?=
 =?utf-8?B?NkdtMThDTTZKTzBaWUl3UE84Sm1WaUFBdTlLZytYRXdOQndMNmFyZnlTL25O?=
 =?utf-8?B?aU5zdy8waUNEVGZHeUo3eUliYlZaYzZQcTduWkVnakEweC9GNjFyWDFzb2pU?=
 =?utf-8?B?ekQrbmgvRFg4K2Q4SDhTbkk3emwwUnpGNXh6ZndxclBRVDBWVDE4ZjVpZmdq?=
 =?utf-8?B?SnlaWGo1KzFwc1ZweUdYaEp6RVA5OFNrSGtlaDU5c2RKS2dsdzJSbGlwNGhI?=
 =?utf-8?B?eC9reFM0TkUvd2RQdHE1cGd1SUxzcmZTVzhURkFwcEZMUVlTSnlSRmw0V3dm?=
 =?utf-8?B?YmJrSHRTaVYxdHhBajBVS3lJRWl4ay8vajZEa3NoWjR0dFA0elZyb1VRRTRV?=
 =?utf-8?B?aERtb1lyTGpOOTRLU0tiUlIxVmtNSE1md2l4ZW8yS1llOUNBcXEyanRGRFhE?=
 =?utf-8?B?N1NmOEUrWVZ1S1pnOURVTzBsSG9UNWJFRnk2RUJJUUxwWkFZbk9JSW1qamU5?=
 =?utf-8?B?WElTVWFCUFlqSmdxS3IvUnNjbzBzRGdhUkpTb2k5enRieDlVQVB3UlUvT09s?=
 =?utf-8?B?RVJqRy93bVcwaFB5V0RkNDlsUWdQM2tVSndWaGgybmxHcWFEVWtua2pBWE5w?=
 =?utf-8?B?cE45UExrZzV2WDBzS0NiNDBpeWFiekRBY1JXby9YMzVjZzlpYU1CL1k0dnVM?=
 =?utf-8?B?T29ua3cwcnRURFZiM2ptMVBvaWtHbE9tNjZXWlJXTUtpdm9nNHNETmE4SE1Z?=
 =?utf-8?B?SlluKzhhaGU5dE5nTFZPdFJxQlBCWlVyd1FhWUVjNEhGcy8wdVRmcUZ4dk82?=
 =?utf-8?B?dGNER3d6dW4vaU9UTkF4TCtvU3N4dnNWeWZYck1GRWVVeWw3eTFCNUVqdW5H?=
 =?utf-8?Q?E7HimxDkyPjRxk9+Ya73CxtnJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CD79D64034B4B428C0577BE24689EB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffa3a80-7c82-4f65-261b-08da57b6469a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 20:56:00.5893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgjYhSMJcHyvoXqqYaKgJg3O9vHykxrdG7/kd/npxy9iLqgYukrEohMY2YzG2oDmmXE80v08H+dvr1MDAKJ2oWeKEVE50Pacmya3W0IVuwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI0LzA2LzIwMjIgMTg6MDgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFRo
ZSBub2RlIG5hbWVzIHNob3VsZCBiZSBnZW5lcmljIGFuZCBEVCBzY2hlbWEgZXhwZWN0cyBjZXJ0
YWluIHBhdHRlcm4NCj4gKGUuZy4gd2l0aCBrZXkvYnV0dG9uL3N3aXRjaCkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+DQoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2No
aXAuY29tPg0KDQpBcmUgeW91IHBsYW5uaW5nIHRvIGNoYW5nZSB0aGVtIGFsbCAmIHRoZW4gY2hh
bmdlIHRoZSBwYXR0ZXJuDQpwcm9wZXJ0eSB0byBjb21wbGFpbiBpZiAia2V5IiBpcyBtaXNzaW5n
Pw0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IC0tLQ0KPiANCj4gU2VlOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMjA2MTYwMDUyMjQuMTgzOTEtMS1rcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmcvDQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4vY2FuYWFu
X2tkMjMzLmR0cyAgICAgfCAyICstDQo+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9zaXBl
ZWRfbWFpeF9iaXQuZHRzICB8IDIgKy0NCj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3Np
cGVlZF9tYWl4X2RvY2suZHRzIHwgMiArLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4v
c2lwZWVkX21haXhfZ28uZHRzICAgfCA2ICsrKy0tLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9j
YW5hYW4vc2lwZWVkX21haXhkdWluby5kdHMgfCAyICstDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL2NhbmFhbi9jYW5hYW5fa2QyMzMuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0
cy9jYW5hYW4vY2FuYWFuX2tkMjMzLmR0cw0KPiBpbmRleCAwMzliOTJhYmYwNDYuLmY3MjU0MGJk
MTRhMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4vY2FuYWFuX2tk
MjMzLmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9jYW5hYW5fa2QyMzMu
ZHRzDQo+IEBAIC0zNSw3ICszNSw3IEBAIGxlZDEgew0KPiAgCWdwaW8ta2V5cyB7DQo+ICAJCWNv
bXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4gIA0KPiAtCQlrZXkwIHsNCj4gKwkJa2V5IHsNCj4g
IAkJCWxhYmVsID0gIktFWTAiOw0KPiAgCQkJbGludXgsY29kZSA9IDxCVE5fMD47DQo+ICAJCQln
cGlvcyA9IDwmZ3BpbzAgMTAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4X2JpdC5kdHMgYi9hcmNoL3Jpc2N2L2Jv
b3QvZHRzL2NhbmFhbi9zaXBlZWRfbWFpeF9iaXQuZHRzDQo+IGluZGV4IGI5ZTMwZGYxMjdmZS4u
OGFiZGJlMjZhMWQwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9z
aXBlZWRfbWFpeF9iaXQuZHRzDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3Np
cGVlZF9tYWl4X2JpdC5kdHMNCj4gQEAgLTQ3LDcgKzQ3LDcgQEAgbGVkMiB7DQo+ICAJZ3Bpby1r
ZXlzIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJncGlvLWtleXMiOw0KPiAgDQo+IC0JCWJvb3Qgew0K
PiArCQlrZXktYm9vdCB7DQo+ICAJCQlsYWJlbCA9ICJCT09UIjsNCj4gIAkJCWxpbnV4LGNvZGUg
PSA8QlROXzA+Ow0KPiAgCQkJZ3Bpb3MgPSA8JmdwaW8wIDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4X2RvY2su
ZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4vc2lwZWVkX21haXhfZG9jay5kdHMNCj4g
aW5kZXggOGQyMzQwMWIwYmJiLi4zYzZkZjFlY2Y3NmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4X2RvY2suZHRzDQo+ICsrKyBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4X2RvY2suZHRzDQo+IEBAIC01Miw3ICs1Miw3
IEBAIGxlZDIgew0KPiAgCWdwaW8ta2V5cyB7DQo+ICAJCWNvbXBhdGlibGUgPSAiZ3Bpby1rZXlz
IjsNCj4gIA0KPiAtCQlib290IHsNCj4gKwkJa2V5LWJvb3Qgew0KPiAgCQkJbGFiZWwgPSAiQk9P
VCI7DQo+ICAJCQlsaW51eCxjb2RlID0gPEJUTl8wPjsNCj4gIAkJCWdwaW9zID0gPCZncGlvMCAw
IEdQSU9fQUNUSVZFX0xPVz47DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2Nh
bmFhbi9zaXBlZWRfbWFpeF9nby5kdHMgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9zaXBl
ZWRfbWFpeF9nby5kdHMNCj4gaW5kZXggMjRmZDgzYjQzZDlkLi4wM2M5ODQzZDUwM2UgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4X2dvLmR0cw0K
PiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9zaXBlZWRfbWFpeF9nby5kdHMNCj4g
QEAgLTQ2LDE5ICs0NiwxOSBAQCBsZWQyIHsNCj4gIAlncGlvLWtleXMgew0KPiAgCQljb21wYXRp
YmxlID0gImdwaW8ta2V5cyI7DQo+ICANCj4gLQkJdXAgew0KPiArCQlrZXktdXAgew0KPiAgCQkJ
bGFiZWwgPSAiVVAiOw0KPiAgCQkJbGludXgsY29kZSA9IDxCVE5fMT47DQo+ICAJCQlncGlvcyA9
IDwmZ3BpbzFfMCA3IEdQSU9fQUNUSVZFX0xPVz47DQo+ICAJCX07DQo+ICANCj4gLQkJcHJlc3Mg
ew0KPiArCQlrZXktcHJlc3Mgew0KPiAgCQkJbGFiZWwgPSAiUFJFU1MiOw0KPiAgCQkJbGludXgs
Y29kZSA9IDxCVE5fMD47DQo+ICAJCQlncGlvcyA9IDwmZ3BpbzAgMCBHUElPX0FDVElWRV9MT1c+
Ow0KPiAgCQl9Ow0KPiAgDQo+IC0JCWRvd24gew0KPiArCQlrZXktZG93biB7DQo+ICAJCQlsYWJl
bCA9ICJET1dOIjsNCj4gIAkJCWxpbnV4LGNvZGUgPSA8QlROXzI+Ow0KPiAgCQkJZ3Bpb3MgPSA8
JmdwaW8wIDEgR1BJT19BQ1RJVkVfTE9XPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9v
dC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4ZHVpbm8uZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9j
YW5hYW4vc2lwZWVkX21haXhkdWluby5kdHMNCj4gaW5kZXggMjUzNDFmMzgyOTJhLi43MTY0YWQw
NjMxNzggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9t
YWl4ZHVpbm8uZHRzDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9t
YWl4ZHVpbm8uZHRzDQo+IEBAIC0yMyw3ICsyMyw3IEBAIGNob3NlbiB7DQo+ICAJZ3Bpby1rZXlz
IHsNCj4gIAkJY29tcGF0aWJsZSA9ICJncGlvLWtleXMiOw0KPiAgDQo+IC0JCWJvb3Qgew0KPiAr
CQlrZXktYm9vdCB7DQo+ICAJCQlsYWJlbCA9ICJCT09UIjsNCj4gIAkJCWxpbnV4LGNvZGUgPSA8
QlROXzA+Ow0KPiAgCQkJZ3Bpb3MgPSA8JmdwaW8wIDAgR1BJT19BQ1RJVkVfTE9XPjsNCg==
