Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B95780DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiGRLes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGRLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:34:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3DEE0D;
        Mon, 18 Jul 2022 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658144080; x=1689680080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AFb12P2aRm0WbwxwIAUDwyoKvzL9ZP3zR8TJEaBJFM8=;
  b=EEzWu5ovSMoTe/J+kccIgD6xVT9eYk3zikb6zKUqKZAAEpJTYQRkMLQm
   xBcv9+pCcTEsSZz4xKB9Uo7vQ/y9XS8VN0YE6b6VOgam2movkVJ2g5De7
   kQrxynOfwcjTGsXdmg2GXae7s4xP2u3+IqnepkOyj/tv9cvsnv/EC7Aiw
   S0uwsjkOsH6zjhSjy/nlTS5+kMjSjroJSJBCm7iiSWEdA2/3HxXXuP19+
   n9j6dMcY8L+55A2T6FZGTC9CUKKoOIxaYHpSdlRU0+r2rswFS8C70AnHG
   l/5p6NdPHf48zuc/AsZ3DsYuObxEn5me/++2OhTMBo2o1IbY5BZBCmRLI
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="165191799"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 04:34:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 04:34:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 04:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRsBHOvMKyZdbxGELjdjOM0VmSyUYorh6dK3jZs9A4FwaUPgRfSqEiMNTs2oHxfFEvuudk1e0jBzjZIbOmvKWJXpCQ2KrGMyiKLyGiOaNrXxfVuAASAtAbl3FpAtaw4ZJz8F14l4tOicDXSkRSh0bS23Q+K5vSyPwqaIbu3zbhxV+DAwaWkaktomtdY1kot7P7cieq4k71G5yFetUxEKo03vu+qgfV5YCPwyRLgoff2YQ0LzpGnlhLZStLK5ygDfViu4b/wWI2zdRUJ2GXGQYVPgum/fn8NuTiKSmvzPCsVpv9oPrpJeJUFkIZDrvqS9qq+oh3N0TMUhqOxWQhUFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFb12P2aRm0WbwxwIAUDwyoKvzL9ZP3zR8TJEaBJFM8=;
 b=aQZIkLuBfQlTPGhhDMo1X6WoH7zQnxfwv1HbHMC8DjQeujgl9zgvFeDvjzzCv2rV72OCFBVxzcV6cHEX0Pqm2Tn3ouQCbgcIWjNWJkbF/OKDJCnlGMJIXsphoQa+52wPwxkM9M/LfECwrUcjAkqyJvaTeVPURx9UpNEWNdlIK3f4wpYT/tFEdec7Mt80Huib2l10ITOPNlpld+KEpDa9npfCH8drcEekVbcq8F1Cj8bQ7DwT8n8ncRSdquVKoUzX6LiM2chA/iI8tX1lHxjPv8x/8b4x6DoiaBpUE4JN5kPb5UElXHWgdzs0JapsjdGEPJbWZeSWcstnojqDvyeVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFb12P2aRm0WbwxwIAUDwyoKvzL9ZP3zR8TJEaBJFM8=;
 b=BWmgNaEGoGGXflrnriSxC4EaGF+TrI/FYNAdftkCyCEviDyDLJ6JSJnTj9w9V6SaTcJGDffrSgdkBC+oNFx0oj+QwjIkkNPR+Fj/ShGgaz/vIEOBqB1zm59jdGODXrQtTo4QOzSE7TOk7gH2o09Wsz874D91oF2tVdJQjwutatE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2235.namprd11.prod.outlook.com (2603:10b6:4:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:34:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:34:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <p.zabel@pengutronix.de>
CC:     <paul.walmsley@sifive.com>, <Daire.McNamara@microchip.com>,
        <sboyd@kernel.org>, <aou@eecs.berkeley.edu>, <robh+dt@kernel.org>,
        <palmer@dabbelt.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 03/12] reset: add polarfire soc reset support
Thread-Topic: [PATCH v2 03/12] reset: add polarfire soc reset support
Thread-Index: AQHYj5/vPcB4mHXnY0e1IrfO0oJ0YK2EFXqA
Date:   Mon, 18 Jul 2022 11:34:22 +0000
Message-ID: <22d3a11b-a603-8406-77ec-51ec038560fc@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
 <20220704121558.2088698-4-conor.dooley@microchip.com>
In-Reply-To: <20220704121558.2088698-4-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d93aaf-d27f-41a5-8830-08da68b1761b
x-ms-traffictypediagnostic: DM5PR1101MB2235:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCUamAv5CpKzADuJDoVKe3qDNsttiuxet+9U7c1ukQywANP7N9Cys92s/Uc6ELyuyVUGrxtiDdEPpzeICg+6bH+tQpifEhrxOPK0x5F+NJ0ddIHyIRQLTpljr02A+CtgR8zACx1tT3T7Vytulg1q7a7Xh7pJ5ViJkZidPYDx5WdXf1z1djj2fvJP+bhwcge3Z3AJYq7kbznjoxJRSgvH1j6QMzj4sUjH+7aVFWpLjZ6cURl+2L8gcmLjluhT+wag0uy7amS0in7k5no5nVRicN4caCDIcQYml55f5mGObfUMstsJdJjkHfy5cmrKWQxzlR0Lzh+nlsO3uLEzhpBpNWQiNnGi+Hd4uWn9vcxH3j7xkvRW46yxc3ZY6BE4kfem17ML4rOR2UYZDrWk+RI7qfC8EzFz7AB/wd4a69rU655ZTNg5juaoMJMvSJLRliqQyUJGlU3Ee8i6bomJmKcAXxBdVtCBXu0tkJMTlvP+0cOtPxBAtKpO52FUFJ67TwzWFWVQx8S5YF7z+PEujmd0J537MJ4Ki+DgeGSsvUwc4ZggcGqayxUxOF75ncAn/AXTC+DbxDsmL+/1ghCmj+XyyOEskQhMqxw/2bP/wxI/idd67WUraYnVefPu3bK5oZo3PRGCr+x7Sx+/nnr/bBIkkYoWQ4LhDv4u/SO1ae+oMSAVUbFGai3d6xF6gCmGRRKUtkv+GWgq5c2KPWB7RZ0wi/PC9nqWlaml72bk5XK0XjEx+W6ccSId3NMyB3yOl6gsagsNMRzVdNSgsjBhHjBqDuMgeDDkMr2EqIcdEj2rk/kT1gJj4hgU8mxVSLUKONve4C8Ja+vUS4FovqXraXmNW5ObaRPNdZvg1xZF3dp1WUxDEUBWDymwSXCOm+JuTrIc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(366004)(39860400002)(376002)(83380400001)(2616005)(186003)(38100700002)(6486002)(122000001)(478600001)(6512007)(66946007)(26005)(6506007)(71200400001)(41300700001)(38070700005)(91956017)(53546011)(8936002)(7416002)(2906002)(31686004)(64756008)(5660300002)(36756003)(8676002)(316002)(86362001)(54906003)(31696002)(66476007)(6916009)(66556008)(66446008)(76116006)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjM0dFNNMUFUVmtTZU41T2cvM0VTQWlFb3ZhUDB0TVVKeVpjcFp0RERvekhT?=
 =?utf-8?B?ZnFCSHhWWGE5NUtybXRCa0tuVzBCWXd2UXlIQ2RFMk9rMEdVZ1Q4dzAwdlZu?=
 =?utf-8?B?ZW03eGVhSHV2b3dkQmdON25Ec3F2WEtoODg1bUIwOUtIWHVXZEpWY1luVk9P?=
 =?utf-8?B?bU5wZGp5N0ZSSngxNEhKeUw0YVJZNXVSeFZYL1dkVjk3R3NOdmZOVTAxZmpD?=
 =?utf-8?B?cVF2SjIza3JNYjlqbHB1K2RPSmpMdXRHclB3TGdNMkRHc252WURYbG14MGsx?=
 =?utf-8?B?Y0tJOUVEVE1mVzdYamFqUzF2SXFBM3FiMXM0UzR2bS9hS0Z0V2h6bFJXNjMx?=
 =?utf-8?B?RjBUV25rVk9sSWxPZ0V6aXFlSUo1NnhlOEExOVUxTWtZVDhCV3FGV0NNVWox?=
 =?utf-8?B?V0c1ZW1YWldYbmFDKzlHN0YrV1VZdndKY3VxVGM2ZFFha3Jpbk5CUGgyVzdQ?=
 =?utf-8?B?K1U3aVJCdGlMNzJVSVplV1VpSTJhcVVFRjdSSVFJbzdERW4vaDNTYTRWaVE0?=
 =?utf-8?B?UlJqMXFKbG9xcDdpVHBxUTFLazU0L2hlRzIyeEZPQ1RSYlBXQ2R0RHFDcXBW?=
 =?utf-8?B?NGY0cU84a252VXFPQzZlbDF1dmkveG5IcTBDYTNoSGtIUlRmS3lZd3krZ0Vp?=
 =?utf-8?B?OUI0WXZDeHFZWUd2a1dqQmhSNlNwemw2K0pHZjcwYnVxOGZrU1hXS3lNazJW?=
 =?utf-8?B?SzlXeExPOEpTRmhESjJGL1ZKZlkrS1dMOWxKTDhSSGM4bWI1T2k4OU1IQnFQ?=
 =?utf-8?B?VWU5aFdScGJwa1VGWlN0L1ZKbng4K0k1d2IyeXVuVFJFeHNaS2VuNE9kcElS?=
 =?utf-8?B?enFsaXQ0eWNZYUFQb2trQ0NocjVZSGNxbXA4aDZON1A3djFuZWNMdjRWazho?=
 =?utf-8?B?Wng0aThSOWpPcHE0Z3hsZHAvUHUxRDB4VCthZzVPQWxaZ0dCTmpVZFVzYkRZ?=
 =?utf-8?B?dlhDcWVucTN6cFI0c0ZLRnBCQkFxRDNxbGtCcG5PcHRKeXdUenM4SEhmSmhP?=
 =?utf-8?B?YUV3OHJVV016emI2N0tVaWRwWXV6SlBrcUJqUUNlNXZ0SGpQVVZxSi9pTUZX?=
 =?utf-8?B?Zk5GY2ZTQ0RycGZDQ0VXZ0ZENkJDVjVyaWVGT1hqNWZKUjl5VmRvbjFueC90?=
 =?utf-8?B?ZHRzTzdOY3NNL28xbElnQm1zRTk0ZVk0YzVMZHdhVjllcFg4ZjRvM3M3MnRH?=
 =?utf-8?B?ZjN5d2lnTEtiRkpOckZPR1lGT3B1NEY1aUVkNXhtLzB0TFVyWGpIZ3IwUjhZ?=
 =?utf-8?B?N3JOZXNMays0c1BhaVBDOU50cjRjMnFHZ012UXRlWlpQQnBFUlIvbnZLQTFj?=
 =?utf-8?B?Z0xjTEN4bjZRTzFET1Zac3l2SFlySzA5QzR5Y1l1eC9TdWFvWno2VWxJcmhX?=
 =?utf-8?B?WkdWY0NWTEcvNmQxZjF5ZURBdzMxNzhqakZqWGxmcGo5TXdVTStrQ3RibEZ3?=
 =?utf-8?B?WDY1cmNqTUJWUVlqSmZQWkk3NVlIRzd6RDhaK1lFYVdMRHA2NWdyWWhwZ2pS?=
 =?utf-8?B?SVAzbVRJTVdnV1VPN1pFS1grL1N2NG53QU14RzFraGcvbGFsM0FPaHk3dVhD?=
 =?utf-8?B?TWg4ZFRyNnFKR2NmbzU0Q1BZY1krMkdMV3RBWWFHdWYzWXFWdUEzWHUxWjc4?=
 =?utf-8?B?aWl5MmpQMHh1RHZNc3VmL1dZQkpsaUo0YkFzMUhTZFY3MElzblpRZmthNHo0?=
 =?utf-8?B?RUVwUDRDbmhDVjRCRk9yN0o0eU5raC9qRlo4UVJIYWZOd1I1b2pOZ2UyQWYx?=
 =?utf-8?B?RXdCYXEyekV2cmNoVjBmL29samlRbjFGUDZsMzVrdGI1QStsajAvUFlyblFI?=
 =?utf-8?B?Uk55OGl1STNXRG5ObGl4NGU0TVFoZlpxc05YQUNoWWhDRGR4eUptWWVuSkV6?=
 =?utf-8?B?cWM4ZDdyM3JQekN4bHZ1TUVvai9ySThiWnNJT0pPQWZvVGlUV2lFWWVGa1Ro?=
 =?utf-8?B?dUdFVjJoMWFNU3RVeEdKVXJWU1Z1Slh5ZEpyOGtmU0VUQnZMbUdjQU1iM3VF?=
 =?utf-8?B?ZzRIb1NmNTRHRTFZSkRNTXA2emE5RlFBZ2JQeHpZUDdaVTVMTUZzN3J5OXJB?=
 =?utf-8?B?N0dyeWpnYWdzdkpKMHRwOHh5by9IbHNvZFFEenFCVFQrZ1lTdkhzT0FsQk9h?=
 =?utf-8?Q?kVv1Opsw4oIu22uYcSPZR8Fzm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B49983C680133644A1B8E1E49DD0F0FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d93aaf-d27f-41a5-8830-08da68b1761b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 11:34:22.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1GikhTXbe7N95yBsyT/HlVVzUFCrP43T4QnADOuLY/ILeDPZPDCll4yRcsDqzTxGoub6q8GJpEIh58EWvrkx7lc++v3D+z/94q+O0e7ow0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2235
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDcvMjAyMiAxMzoxNSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBBZGQgc3VwcG9ydCBm
b3IgdGhlIHJlc2V0cyBvbiBNaWNyb2NoaXAncyBQb2xhckZpcmUgU29DIChNUEZTKS4NCj4gUmVz
ZXQgY29udHJvbCBpcyBhIHNpbmdsZSByZWdpc3Rlciwgd2VkZ2VkIGluIGJldHdlZW4gcmVnaXN0
ZXJzIGZvcg0KPiBjbG9jayBjb250cm9sLiBUbyBmaXQgd2l0aCBleGlzdGVkIERUIGV0YywgdGhl
IHJlc2V0IGNvbnRyb2xsZXIgaXMNCj4gY3JlYXRlZCB1c2luZyB0aGUgYXV4IGRldmljZSBmcmFt
ZXdvcmsgJiBzZXQgdXAgaW4gdGhlIGNsb2NrIGRyaXZlci4NCg0KSGV5IFBoaWxpcHAsDQpJIHJl
c29sdmVkIHlvdXIgY29tbWVudHMgb24gVjEuIERvIHlvdSBoYXZlIGFueSByZW1haW5pbmcgY29u
Y2VybnM/DQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9yZXNl
dC9LY29uZmlnICAgICAgfCAgIDcgKysNCj4gICBkcml2ZXJzL3Jlc2V0L01ha2VmaWxlICAgICB8
ICAgMiArLQ0KPiAgIGRyaXZlcnMvcmVzZXQvcmVzZXQtbXBmcy5jIHwgMTU3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE2NSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cmVzZXQvcmVzZXQtbXBmcy5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9LY29u
ZmlnIGIvZHJpdmVycy9yZXNldC9LY29uZmlnDQo+IGluZGV4IDkzYzhkMDdlZTMyOC4uZWRmZGM3
YjJiYzVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L0tjb25maWcNCj4gKysrIGIvZHJp
dmVycy9yZXNldC9LY29uZmlnDQo+IEBAIC0xMjIsNiArMTIyLDEzIEBAIGNvbmZpZyBSRVNFVF9N
Q0hQX1NQQVJYNQ0KPiAgIAloZWxwDQo+ICAgCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgc3dpdGNo
IGNvcmUgcmVzZXQgZm9yIHRoZSBNaWNyb2NoaXAgU3Bhcng1IFNvQy4NCj4gICANCj4gK2NvbmZp
ZyBSRVNFVF9QT0xBUkZJUkVfU09DDQo+ICsJYm9vbCAiTWljcm9jaGlwIFBvbGFyRmlyZSBTb0Mg
KE1QRlMpIFJlc2V0IERyaXZlciINCj4gKwlkZXBlbmRzIG9uIEFVWElMSUFSWV9CVVMgJiYgTUNI
UF9DTEtfTVBGUw0KPiArCWRlZmF1bHQgTUNIUF9DTEtfTVBGUw0KPiArCWhlbHANCj4gKwkgIFRo
aXMgZHJpdmVyIHN1cHBvcnRzIHBlcmlwaGVyYWwgcmVzZXQgZm9yIHRoZSBNaWNyb2NoaXAgUG9s
YXJGaXJlIFNvQw0KPiArDQo+ICAgY29uZmlnIFJFU0VUX01FU09ODQo+ICAgCXRyaXN0YXRlICJN
ZXNvbiBSZXNldCBEcml2ZXIiDQo+ICAgCWRlcGVuZHMgb24gQVJDSF9NRVNPTiB8fCBDT01QSUxF
X1RFU1QNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvTWFrZWZpbGUgYi9kcml2ZXJzL3Jl
c2V0L01ha2VmaWxlDQo+IGluZGV4IGE4MGE5YzQwMDhhNy4uNWZhYzNhNzUzODU4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3Jlc2V0L01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvcmVzZXQvTWFr
ZWZpbGUNCj4gQEAgLTE3LDYgKzE3LDcgQEAgb2JqLSQoQ09ORklHX1JFU0VUX0syMTApICs9IHJl
c2V0LWsyMTAubw0KPiAgIG9iai0kKENPTkZJR19SRVNFVF9MQU5USVEpICs9IHJlc2V0LWxhbnRp
cS5vDQo+ICAgb2JqLSQoQ09ORklHX1JFU0VUX0xQQzE4WFgpICs9IHJlc2V0LWxwYzE4eHgubw0K
PiAgIG9iai0kKENPTkZJR19SRVNFVF9NQ0hQX1NQQVJYNSkgKz0gcmVzZXQtbWljcm9jaGlwLXNw
YXJ4NS5vDQo+ICtvYmotJChDT05GSUdfUkVTRVRfUE9MQVJGSVJFX1NPQykgKz0gcmVzZXQtbXBm
cy5vDQo+ICAgb2JqLSQoQ09ORklHX1JFU0VUX01FU09OKSArPSByZXNldC1tZXNvbi5vDQo+ICAg
b2JqLSQoQ09ORklHX1JFU0VUX01FU09OX0FVRElPX0FSQikgKz0gcmVzZXQtbWVzb24tYXVkaW8t
YXJiLm8NCj4gICBvYmotJChDT05GSUdfUkVTRVRfTlBDTSkgKz0gcmVzZXQtbnBjbS5vDQo+IEBA
IC0zOCw0ICszOSwzIEBAIG9iai0kKENPTkZJR19SRVNFVF9VTklQSElFUikgKz0gcmVzZXQtdW5p
cGhpZXIubw0KPiAgIG9iai0kKENPTkZJR19SRVNFVF9VTklQSElFUl9HTFVFKSArPSByZXNldC11
bmlwaGllci1nbHVlLm8NCj4gICBvYmotJChDT05GSUdfUkVTRVRfWllOUSkgKz0gcmVzZXQtenlu
cS5vDQo+ICAgb2JqLSQoQ09ORklHX0FSQ0hfWllOUU1QKSArPSByZXNldC16eW5xbXAubw0KPiAt
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LW1wZnMuYyBiL2RyaXZlcnMvcmVz
ZXQvcmVzZXQtbXBmcy5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uMTU4MGQxYjY4ZDYxDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9yZXNl
dC9yZXNldC1tcGZzLmMNCj4gQEAgLTAsMCArMSwxNTcgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qDQo+ICsgKiBQb2xhckZpcmUgU29DIChNUEZT
KSBQZXJpcGhlcmFsIENsb2NrIFJlc2V0IENvbnRyb2xsZXINCj4gKyAqDQo+ICsgKiBBdXRob3I6
IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ICsgKiBDb3B5cmln
aHQgKGMpIDIwMjIgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmll
cy4NCj4gKyAqDQo+ICsgKi8NCj4gKyNpbmNsdWRlIDxsaW51eC9hdXhpbGlhcnlfYnVzLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9yZXNldC1jb250cm9sbGVyLmg+DQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbWlj
cm9jaGlwLG1wZnMtY2xvY2suaD4NCj4gKyNpbmNsdWRlIDxzb2MvbWljcm9jaGlwL21wZnMuaD4N
Cj4gKw0KPiArLyoNCj4gKyAqIFRoZSBFTlZNIHJlc2V0IGlzIHRoZSBsb3dlc3QgYml0IGluIHRo
ZSByZWdpc3RlciAmIEkgYW0gdXNpbmcgdGhlIENMS19GT08NCj4gKyAqIGRlZmluZXMgaW4gdGhl
IGR0IHRvIG1ha2UgdGhpbmdzIGVhc2llciB0byBjb25maWd1cmUgLSBzbyB0aGlzIGlzIGFjY291
bnRpbmcNCj4gKyAqIGZvciB0aGUgb2Zmc2V0IG9mIDMgdGhlcmUuDQo+ICsgKi8NCj4gKyNkZWZp
bmUgTVBGU19QRVJJUEhfT0ZGU0VUCUNMS19FTlZNDQo+ICsjZGVmaW5lIE1QRlNfTlVNX1JFU0VU
UwkJMzB1DQo+ICsjZGVmaW5lIE1QRlNfU0xFRVBfTUlOX1VTCTEwMA0KPiArI2RlZmluZSBNUEZT
X1NMRUVQX01BWF9VUwkyMDANCj4gKw0KPiArLyogYmxvY2sgY29uY3VycmVudCBhY2Nlc3MgdG8g
dGhlIHNvZnQgcmVzZXQgcmVnaXN0ZXIgKi8NCj4gK3N0YXRpYyBERUZJTkVfU1BJTkxPQ0sobXBm
c19yZXNldF9sb2NrKTsNCj4gKw0KPiArLyoNCj4gKyAqIFBlcmlwaGVyYWwgY2xvY2sgcmVzZXRz
DQo+ICsgKi8NCj4gKw0KPiArc3RhdGljIGludCBtcGZzX2Fzc2VydChzdHJ1Y3QgcmVzZXRfY29u
dHJvbGxlcl9kZXYgKnJjZGV2LCB1bnNpZ25lZCBsb25nIGlkKQ0KPiArew0KPiArCXVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQo+ICsJdTMyIHJlZzsNCj4gKw0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZt
cGZzX3Jlc2V0X2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXJlZyA9IG1wZnNfcmVzZXRfcmVhZChy
Y2Rldi0+ZGV2KTsNCj4gKwlyZWcgfD0gQklUKGlkKTsNCj4gKwltcGZzX3Jlc2V0X3dyaXRlKHJj
ZGV2LT5kZXYsIHJlZyk7DQo+ICsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtcGZzX3Jl
c2V0X2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgaW50IG1wZnNfZGVhc3NlcnQoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2Rldiwg
dW5zaWduZWQgbG9uZyBpZCkNCj4gK3sNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArCXUz
MiByZWcsIHZhbDsNCj4gKw0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZtcGZzX3Jlc2V0X2xvY2ss
IGZsYWdzKTsNCj4gKw0KPiArCXJlZyA9IG1wZnNfcmVzZXRfcmVhZChyY2Rldi0+ZGV2KTsNCj4g
Kwl2YWwgPSByZWcgJiB+QklUKGlkKTsNCj4gKwltcGZzX3Jlc2V0X3dyaXRlKHJjZGV2LT5kZXYs
IHZhbCk7DQo+ICsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtcGZzX3Jlc2V0X2xvY2ss
IGZsYWdzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG1w
ZnNfc3RhdHVzKHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsIHVuc2lnbmVkIGxv
bmcgaWQpDQo+ICt7DQo+ICsJdTMyIHJlZyA9IG1wZnNfcmVzZXRfcmVhZChyY2Rldi0+ZGV2KTsN
Cj4gKw0KPiArCS8qDQo+ICsJICogSXQgaXMgc2FmZSB0byByZXR1cm4gaGVyZSBhcyBNUEZTX05V
TV9SRVNFVFMgbWFrZXMgc3VyZSB0aGUgc2lnbiBiaXQNCj4gKwkgKiBpcyBuZXZlciBoaXQuDQo+
ICsJICovDQo+ICsJcmV0dXJuIChyZWcgJiBCSVQoaWQpKTsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGludCBtcGZzX3Jlc2V0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsIHVuc2ln
bmVkIGxvbmcgaWQpDQo+ICt7DQo+ICsJbXBmc19hc3NlcnQocmNkZXYsIGlkKTsNCj4gKw0KPiAr
CXVzbGVlcF9yYW5nZShNUEZTX1NMRUVQX01JTl9VUywgTVBGU19TTEVFUF9NQVhfVVMpOw0KPiAr
DQo+ICsJbXBmc19kZWFzc2VydChyY2RldiwgaWQpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVzZXRfY29udHJvbF9vcHMgbXBmc19yZXNl
dF9vcHMgPSB7DQo+ICsJLnJlc2V0ID0gbXBmc19yZXNldCwNCj4gKwkuYXNzZXJ0ID0gbXBmc19h
c3NlcnQsDQo+ICsJLmRlYXNzZXJ0ID0gbXBmc19kZWFzc2VydCwNCj4gKwkuc3RhdHVzID0gbXBm
c19zdGF0dXMsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IG1wZnNfcmVzZXRfeGxhdGUoc3Ry
dWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gKwkJCSAgICBjb25zdCBzdHJ1Y3Qg
b2ZfcGhhbmRsZV9hcmdzICpyZXNldF9zcGVjKQ0KPiArew0KPiArCXVuc2lnbmVkIGludCBpbmRl
eCA9IHJlc2V0X3NwZWMtPmFyZ3NbMF07DQo+ICsNCj4gKwkvKg0KPiArCSAqIENMS19SRVNFUlZF
RCBkb2VzIG5vdCBtYXAgdG8gYSBjbG9jaywgYnV0IGl0IGRvZXMgbWFwIHRvIGEgcmVzZXQsDQo+
ICsJICogc28gaXQgaGFzIHRvIGJlIGFjY291bnRlZCBmb3IgaGVyZS4gSXQgaXMgdGhlIHJlc2V0
IGZvciB0aGUgZmFicmljLA0KPiArCSAqIHNvIGlmIHRoaXMgcmVzZXQgZ2V0cyBjYWxsZWQgLSBk
byBub3QgcmVzZXQgaXQuDQo+ICsJICovDQo+ICsJaWYgKGluZGV4ID09IENMS19SRVNFUlZFRCkg
ew0KPiArCQlkZXZfZXJyKHJjZGV2LT5kZXYsICJSZXNldHRpbmcgdGhlIGZhYnJpYyBpcyBub3Qg
c3VwcG9ydGVkXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJaWYg
KGluZGV4IDwgTVBGU19QRVJJUEhfT0ZGU0VUIHx8IGluZGV4ID49IChNUEZTX1BFUklQSF9PRkZT
RVQgKyByY2Rldi0+bnJfcmVzZXRzKSkgew0KPiArCQlkZXZfZXJyKHJjZGV2LT5kZXYsICJJbnZh
bGlkIHJlc2V0IGluZGV4ICV1XG4iLCBpbmRleCk7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiAr
CX0NCj4gKw0KPiArCXJldHVybiBpbmRleCAtIE1QRlNfUEVSSVBIX09GRlNFVDsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGludCBtcGZzX3Jlc2V0X3Byb2JlKHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNl
ICphZGV2LA0KPiArCQkJICAgIGNvbnN0IHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlX2lkICppZCkN
Cj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmYWRldi0+ZGV2Ow0KPiArCXN0cnVjdCBy
ZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXY7DQo+ICsNCj4gKwlyY2RldiA9IGRldm1fa3phbGxv
YyhkZXYsIHNpemVvZigqcmNkZXYpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXJjZGV2KQ0KPiAr
CQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCXJjZGV2LT5kZXYgPSBkZXY7DQo+ICsJcmNkZXYt
PmRldi0+cGFyZW50ID0gZGV2LT5wYXJlbnQ7DQo+ICsJcmNkZXYtPm9wcyA9ICZtcGZzX3Jlc2V0
X29wczsNCj4gKwlyY2Rldi0+b2Zfbm9kZSA9IGRldi0+cGFyZW50LT5vZl9ub2RlOw0KPiArCXJj
ZGV2LT5vZl9yZXNldF9uX2NlbGxzID0gMTsNCj4gKwlyY2Rldi0+b2ZfeGxhdGUgPSBtcGZzX3Jl
c2V0X3hsYXRlOw0KPiArCXJjZGV2LT5ucl9yZXNldHMgPSBNUEZTX05VTV9SRVNFVFM7DQo+ICsN
Cj4gKwlyZXR1cm4gZGV2bV9yZXNldF9jb250cm9sbGVyX3JlZ2lzdGVyKGRldiwgcmNkZXYpOw0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF1eGlsaWFyeV9kZXZpY2VfaWQgbXBm
c19yZXNldF9pZHNbXSA9IHsNCj4gKwl7DQo+ICsJCS5uYW1lID0gImNsa19tcGZzLnJlc2V0LW1w
ZnMiLA0KPiArCX0sDQo+ICsJeyB9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShhdXhp
bGlhcnksIG1wZnNfcmVzZXRfaWRzKTsNCj4gKw0KPiArc3RhdGljIHN0cnVjdCBhdXhpbGlhcnlf
ZHJpdmVyIG1wZnNfcmVzZXRfZHJpdmVyID0gew0KPiArCS5wcm9iZQkJPSBtcGZzX3Jlc2V0X3By
b2JlLA0KPiArCS5pZF90YWJsZQk9IG1wZnNfcmVzZXRfaWRzLA0KPiArfTsNCj4gKw0KPiArbW9k
dWxlX2F1eGlsaWFyeV9kcml2ZXIobXBmc19yZXNldF9kcml2ZXIpOw0KPiArDQo+ICtNT0RVTEVf
REVTQ1JJUFRJT04oIk1pY3JvY2hpcCBQb2xhckZpcmUgU29DIFJlc2V0IERyaXZlciIpOw0KPiAr
TU9EVUxFX0FVVEhPUigiQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4i
KTsNCj4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gK01PRFVMRV9JTVBPUlRfTlMoTUNIUF9D
TEtfTVBGUyk7DQoNCg==
