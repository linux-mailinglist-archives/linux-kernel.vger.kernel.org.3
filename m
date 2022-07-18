Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C3578801
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiGRRC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiGRRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:02:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D322A409
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658163744; x=1689699744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=THBLx/sNvC3WNSdwgIBX42PA3igsavB96VhXXe8FnVw=;
  b=JtxiVWs4ve7FbkqbPDhNTQAhmbQQUHWZhcqq3qTtONXmKhUL6FaRYQZv
   ia/cB7AVqqgvHHbxZ2/HW6cq2BJNQ0Gp9oFNbufutRSLhPII5mKEYLc8Z
   BpFIb+BcLQ9L6Xnw5FoFt8Antjj4nFTET44l28tSw3W6ae03LKXR8CoGG
   VFMon8rydrGXC8IWhXfkcJasDEYsDbQktYZD+FBLTx4+IAH52FkD5BGck
   svx+j1llkqEIEXEG46JP/ZVgKw+riOVyyB70PZR+ZQUC4yK1YpACR3rc8
   cuDxKGTsuOQdhSjO+3aIkleY0iVVmMu6ZtDWyb7ZHZQmk4gQexRTq8If+
   w==;
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="104979021"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 10:02:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 10:02:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 10:02:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri7LqszW0gY4htrbjvaJt38TDJfDocECnnwhW0S2YlGpmUiLWJhdZeZsw/CBi3wvG8teC3yRCA0jkjzW+JyXC0D0lgKAr3grrFcGPRcBOa/GB92KiH4oFcO3s8/HwXUlw+b4mdHDy6eIrLkTN3JKbSYcNwioksev/C5i8sZf8zVYwffbSyIXJOPJPd0rQAjeZqPfc8aPzQt2AlcSHgCSvOtGMWjA23/kz1no5wADE2xFjMHzHDNtZovXOx6nFjbLY/lzOe075/DdO7spAeufa7I/VCi+CsLb8jzvRxNyNCT1R0/QdExpeJbq40EdWE8JSdQ9vJJNBOQZNRTkDxLbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THBLx/sNvC3WNSdwgIBX42PA3igsavB96VhXXe8FnVw=;
 b=mD6kXMf9v26K7UWFIS6wQalOWhkeGsC/B9t4Rz3BDdhhbrRWfZ83EaluEjjmofT9NNfzyfxCp2nT6zpHv1w5AAu/JqRYLrd1DxGVOIBr4hpg7Em8Mihcr3Q0IH/PzEM0DrSlU7q6OHroBJQBEr/xnN6w8Mf8KRcT9zKf8VM3sSdkUVfwMak/eHFUSw8lnuHaM4EnNG1gbDwVht5J5fl6g7ngBNeUoUOtRqbETtmrPytetO65UgOyk/4lgIrVN6wN7hugcPlJYQg96odn4C4e7o7vuGuGVyWxGd+3YTmTBHSwUHlYwlLMVrg9yfXEV6vAWK7oPEo7k8PTBTvfV8iqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THBLx/sNvC3WNSdwgIBX42PA3igsavB96VhXXe8FnVw=;
 b=loBddJsdlvDqhnJsG8XhKWW1IeT1a4x9xKHa8ur5CXsuu9RzUR2JYZK3dpjv4gs+OvwloL1stPyNqHwNP64x6V1VQgFJoMwlt2BRN7GxNZ4pj20DIoKaBwSz4XXjuVRXjBDcdQDAvI4tyAVfeHLzljIF4MKfZjVd8PedL2hGoLM=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Mon, 18 Jul
 2022 17:02:18 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 17:02:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sudip.mukherjee@sifive.com>, <p.yadav@ti.com>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <greentime.hu@sifive.com>, <jude.onyenegecha@sifive.com>,
        <william.salmon@sifive.com>, <adnan.chowdhury@sifive.com>,
        <ben.dooks@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Topic: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Index: AQHYmsgjen1JGDoDVkiRJKdzpaguzQ==
Date:   Mon, 18 Jul 2022 17:02:17 +0000
Message-ID: <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-3-sudip.mukherjee@sifive.com>
In-Reply-To: <20220712163823.428126-3-sudip.mukherjee@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb8e12a4-fdae-4ff9-e84e-08da68df4581
x-ms-traffictypediagnostic: SJ0PR11MB5053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPoDQdel0Ba6s1L6/ZoXjhTJPjC0klm5DdHxcBHNG3sJNYzKCQmxRfj7RG69NykgvwyU7ZiRHZw2tDMBznGTVNUJxaoTamY9JwCxoLbwFqzFrfrkoX87yqKjEQgSq2Jrvp3duSQhgEtXIKMHNVpMmWYlEZ+cJ06QXMY2cyShi0EHUN6tJfgu45y9tVHtpXJdgoYllw8ZvscnAPUPWLiQ9mwoCsUahIhAiFJrePY2J/zYabWZ+FMZI955Dd1akTe7z7G8T8wA67aFvC+7mSQBSWVV0II/9W9NrD3SfEG8/RREPe+GOrgIFqUvRo06Flzow2S3yJBzB9/rvKRNoOQyIgkmiGinZa6w0F6KXs0VC93Jc3s0wDjtuOYgMNOJyq7NpbPF+qA43Hk8/L5fzuF2GtOlpf8kIhaMvQTvNFzxncNVLzNwpBEsghKHwgjEB/8Tu+DX++t7XFsSJKE24Kaf8mLHLB1Zyl2RuW6r+jrUUdZwM5IqVct6gkR4A6WMRjbsP9WSY8cW5HcZDKo8McoH0b+3/pzpZBbMRxk5YihM7NA0saWIyBQvIohQt6KJfEZz7jSSg/RUSMqZMH2IxG23Jsj+lwH2vgEj83JL4aQEfXhiHx4+bctsBwFW0SS690zwLTk9MVppAyTWCIUzWraYRBdl7zmpHjo9VOyfXgemcfgMiGoz7SkiwaRE/XiIvAY8LabPZ+RpjEyCnjEevoa6UqOIMMRk9PNITyNmqUYY9+Nr2iI7RiZe9TYOv8T1oTNCwoKuhU9IgHcpkLhDfLsLrZbfHFgQdcUafW2E5DHHiWTj/w7cA4mzKWP9y4iis4+A7Kj3+zleHbfZUBsxVB1vbydqeM8T+ObeyQQwCAEWzHMdhLRpukK4FQBcxZaQZ7UN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(8936002)(66556008)(76116006)(7416002)(4326008)(66946007)(5660300002)(8676002)(64756008)(66446008)(66476007)(54906003)(2906002)(26005)(86362001)(31696002)(122000001)(38070700005)(71200400001)(83380400001)(966005)(478600001)(6486002)(186003)(91956017)(316002)(31686004)(53546011)(41300700001)(2616005)(6506007)(38100700002)(110136005)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUM0N1dCMWQvdDE3Q3h5KzZHcVp0N3Ixd0NWT3p3Zk1kQXVCTDJRbjczbURq?=
 =?utf-8?B?NnJDbXNCOHR4V3Q2cWV3U2hKdXRMcUd1Q3I0VEV4OFozdWc2S0FjL09FcEJo?=
 =?utf-8?B?WG9ucDBaWEtOSGlQU3IvSGFsaHhlcU9POHFhU3h5THpSUVNsMWRTb1NNQUp4?=
 =?utf-8?B?U2hJaENnRVAwK2RXSWZ1VWhzZjJFZGZpZmlocXFMa3VsaDNtMjArVHg1TVVv?=
 =?utf-8?B?VDZCSWMxWDBHRFY2eTBCN0dSbDhhNmttU2grQjNuRFZKaURjRGxZSmdRZFZy?=
 =?utf-8?B?VWV2U2F3NHpoZ3RNaWEwZmpNOWNNRklYMnV2bVVwa3V2MUJvTjJ5RUlKa0pQ?=
 =?utf-8?B?TlpQd2ZaK0xrVGdEUTRrcDNnSmtFa29QVG5LZ3QyeS9xR1NoU21aQm5xT1Zj?=
 =?utf-8?B?QmV0cWh0NXBUaUJJdHVJbmxQd3hCL2JQYSt2TkhlOGNQdEJWNjg2RG1oclZk?=
 =?utf-8?B?bEo2V2hRd0ZvUjdWbUJFcEZDTHJRaUVsNU14MlNLUmdVK2U1WUx1R1JCRHg0?=
 =?utf-8?B?ZG56dHltQXVoRHlIN3Y0UlY0SlZvSEppVzY2UnlhSjJxZ2RrYzRienRLV2sv?=
 =?utf-8?B?NzZwLzJBM0JxOXVuUUtKaVh0N1lMcmFrS2s2R0oxamI0NUFIa0I3TlZDVjRp?=
 =?utf-8?B?MnJodEErbnRvb1dDYlJ0TmFBSHB2dEdoRUhFem5SdkY5dEJGc0J4SmFzOUpK?=
 =?utf-8?B?b1lDaXVDVjNTQVRhQUdWc1drd296VmpoNVNjTGpsejhYeWpMRGhsZktGank4?=
 =?utf-8?B?a2JNUlZ0bFhoTU96YWhUelNwMldDbk9ucUlmNENGcHF4dTRxWmU2eGxqdFpY?=
 =?utf-8?B?bmlzZG9zTW81ZGUrYWZkN3hkNGd5QzcraGtqakc0RkVrd0NDKzBNVGJlQzVx?=
 =?utf-8?B?TWRDS1FWWWs0dVhOLzhSb1kzRW1yVkd0VERUaUNnWFJIaGs1RlhiTWVRazBC?=
 =?utf-8?B?d2E2RkRva1ozTjNVTVMzOUhEc0VFLzNuU1lJbkEwQTdaMktsTXlxYjROdWcx?=
 =?utf-8?B?ZjRHTkF3K1plUitaU1JybHByNXZlVkZnQU96VnBYTWFrcDZkdUwyOE41VmJK?=
 =?utf-8?B?blg3WVVKVFg1Z0hKb2pFWDVKcEE3R29pQm5XNHZZSkhIWHdjcG1jR2c3cFoy?=
 =?utf-8?B?ZjhBOVIrdnFCdDAwMXJ0Z2ZmWjZ2bVlBUEFxN2FaR1JGdGhwdGVGNHV3Y0Ra?=
 =?utf-8?B?V29oMVZhc2FQSm4rbkZ6N0h0OUZXaTFYa0gwZlRWQ1o5b000dUJQNzdJUVNJ?=
 =?utf-8?B?T280K0ZsZGtYVWtycXZINHpnaElhckpmbGdEc2pvUnMzRDhFQUlYQjVkNlQv?=
 =?utf-8?B?NmVjSVhIb0NmbG4rSGJtUHFkQXhhQ3NyZjFZZXovK0dRRE9qWG1IT2xTUzZa?=
 =?utf-8?B?ZzlnUjdkSmgrbDRjTll6bWgvTjFoMjBscjdCa2lnMHEvek9wdHRmam9HUWhW?=
 =?utf-8?B?SkJUL255d0hvekdpUDFmVlFaWElSeHExYlZubUtzWUFYcGRtYnVkN1pnMVI1?=
 =?utf-8?B?MUUyUUxySklVK1d3MHl6VXlFcmtjUnNDOXRqZEJIS2RLdUFHLzZqMGdnTVhh?=
 =?utf-8?B?U1VKVjNmRklJb3lhT3JDUUFnb3ZtbGdpbTlrOC9BQ3F2ZllUK0pQQ2xLbU9N?=
 =?utf-8?B?ZlRHTlJwc2djL3VVblVxZzVYT1lnMjFWWkZmMUl6dVJsTkYvMnpjY2VMcURM?=
 =?utf-8?B?Y09OL2w0K1JLQW94U3dMUmVxYVBwOUxHWDdvcHVoaWtLcU1Rejd4NFhpSzF5?=
 =?utf-8?B?RUVKOGdJclJYakVEeGcvOTA3R2NGbXMzZkJOTks2UTZZdlZFaHIybCtUdXYv?=
 =?utf-8?B?Vk1wZjhKelJMejJPdlRsU0RpcjlPL0lyT2lOL3d2M2JEcCs2aWVsVkUvcHVE?=
 =?utf-8?B?U3lodk5JMjlRZFRJZ2lrSE90czdkQkxNMG1lUFROTWovVUdiL3BtNmtjamZ5?=
 =?utf-8?B?UnhpU2wwVUZ0Y0RPQlpuVzVnaXRyQVZzNXlUK0ZRVVJsMEU2YnpTUFR6R2tV?=
 =?utf-8?B?em1ySGFLYVpUZGRNR0QyZ2lKdm5qV1MzWGdBdlRCL0xiVlhGamMyQmhqT1l1?=
 =?utf-8?B?aHJuQlprVmFzVlBMb2VVRkNQck5FQzVqQ1pUS2I4UmZadkxmc2g5WkpjY0tB?=
 =?utf-8?B?YUNvVTVkWE8rd2ppL0VMeDVKenpEZ2lRbFVNTWdYWXZzM3BjVm1renhWZVpK?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAD883B69ABC2E41B30CCD33B2551F80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8e12a4-fdae-4ff9-e84e-08da68df4581
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 17:02:17.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggzvT9QtgOdfyKrtTRs19LesuLuWLwigvKn+c9vF5UsBWRuCaywAnLw6No5ehPsLbogGuCtZMfKoHBfGQhjbfb6iMUGx/VLkBwAn/FIgMN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMi8yMiAxOTozOCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIHN1ZGlwLm11a2hlcmplZUBzaWZpdmUuY29tLiBMZWFybiB3aHkg
dGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gU29tZSBmbGFzaCBjaGlwcyB3aGljaCBkb2VzIG5vdCBoYXZlIGEgU0ZEUCB0YWJsZSBjYW4g
c3VwcG9ydCBRdWFkDQo+IElucHV0IFBhZ2UgUHJvZ3JhbS4gRW5hYmxlIGl0IGluIGh3Y2FwcyBp
ZiBkZWZpbmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3VkaXAgTXVraGVyamVlIDxzdWRpcC5t
dWtoZXJqZWVAc2lmaXZlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUu
YyB8IDUgKysrKysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIHwgMiArKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4
IGU1Zjc2OTFjNWJkNDAuLmUyOTlmYzhmZGQzZDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IEBA
IC0yMzc1LDYgKzIzNzUsMTEgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9ub19zZmRwX2luaXRfcGFy
YW1zKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICAgICAgICAgICAgICAgICBzcGlfbm9yX3NldF9w
cF9zZXR0aW5ncygmcGFyYW1zLT5wYWdlX3Byb2dyYW1zW1NOT1JfQ01EX1BQXzhfOF84X0RUUl0s
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElOT1JfT1BfUFAs
IFNOT1JfUFJPVE9fOF84XzhfRFRSKTsNCj4gICAgICAgICB9DQo+ICsgICAgICAgaWYgKG5vX3Nm
ZHBfZmxhZ3MgJiBTUElfTk9SX1FVQURfUFApIHsNCj4gKyAgICAgICAgICAgICAgIHBhcmFtcy0+
aHdjYXBzLm1hc2sgfD0gU05PUl9IV0NBUFNfUFBfMV8xXzQ7DQo+ICsgICAgICAgICAgICAgICBz
cGlfbm9yX3NldF9wcF9zZXR0aW5ncygmcGFyYW1zLT5wYWdlX3Byb2dyYW1zW1NOT1JfQ01EX1BQ
XzFfMV80XSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSU5P
Ul9PUF9QUF8xXzFfNCwgU05PUl9QUk9UT18xXzFfNCk7DQo+ICsgICAgICAgfQ0KPiANCj4gICAg
ICAgICAvKg0KPiAgICAgICAgICAqIFNlY3RvciBFcmFzZSBzZXR0aW5ncy4gU29ydCBFcmFzZSBU
eXBlcyBpbiBhc2NlbmRpbmcgb3JkZXIsIHdpdGggdGhlDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IGluZGV4
IDU4ZmJlZGM5NDA4MGYuLmRkZTYzNmJkYjFhN2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IEBA
IC00NjIsNiArNDYyLDcgQEAgc3RydWN0IHNwaV9ub3JfZml4dXBzIHsNCj4gICAqICAgU1BJX05P
Ul9PQ1RBTF9SRUFEOiAgICAgIGZsYXNoIHN1cHBvcnRzIE9jdGFsIFJlYWQuDQo+ICAgKiAgIFNQ
SV9OT1JfT0NUQUxfRFRSX1JFQUQ6ICBmbGFzaCBzdXBwb3J0cyBvY3RhbCBEVFIgUmVhZC4NCj4g
ICAqICAgU1BJX05PUl9PQ1RBTF9EVFJfUFA6ICAgIGZsYXNoIHN1cHBvcnRzIE9jdGFsIERUUiBQ
YWdlIFByb2dyYW0uDQo+ICsgKiAgIFNQSV9OT1JfUVVBRF9QUDogICAgICAgICBmbGFzaCBzdXBw
b3J0cyBRdWFkIElucHV0IFBhZ2UgUHJvZ3JhbS4NCg0KWW91IGRvbid0IG5lZWQgdGhpcyBmbGFn
IGlmIHlvdXIgZmxhc2ggc3VwcG9ydHMgdGhlIDQtYnl0ZSBBZGRyZXNzDQpJbnN0cnVjdGlvbiBU
YWJsZS4gRG9lcyB5b3UgZmxhc2ggc3VwcG9ydCBpdD8gQ2FuIHlvdSBkdW1wIGFsbCB0aGUNClNG
RFAgdGFibGVzLCBwbGVhc2U/DQoNClRoYW5rcywNCnRhDQo+ICAgKg0KPiAgICogQGZpeHVwX2Zs
YWdzOiAgICBmbGFncyB0aGF0IGluZGljYXRlIHN1cHBvcnQgdGhhdCBjYW4gYmUgZGlzY292ZXJl
ZCB2aWEgU0ZEUA0KPiAgICogICAgICAgICAgICAgICAgICBpZGVhbGx5LCBidXQgY2FuIG5vdCBi
ZSBkaXNjb3ZlcmVkIGZvciB0aGlzIHBhcnRpY3VsYXIgZmxhc2gNCj4gQEAgLTUwOSw2ICs1MTAs
NyBAQCBzdHJ1Y3QgZmxhc2hfaW5mbyB7DQo+ICAjZGVmaW5lIFNQSV9OT1JfT0NUQUxfUkVBRCAg
ICAgICAgICAgICBCSVQoNSkNCj4gICNkZWZpbmUgU1BJX05PUl9PQ1RBTF9EVFJfUkVBRCAgICAg
ICAgIEJJVCg2KQ0KPiAgI2RlZmluZSBTUElfTk9SX09DVEFMX0RUUl9QUCAgICAgICAgICAgQklU
KDcpDQo+ICsjZGVmaW5lIFNQSV9OT1JfUVVBRF9QUCAgICAgICAgICAgICAgICAgICAgICAgIEJJ
VCg4KQ0KPiANCj4gICAgICAgICB1OCBmaXh1cF9mbGFnczsNCj4gICNkZWZpbmUgU1BJX05PUl80
Ql9PUENPREVTICAgICAgICAgICAgIEJJVCgwKQ0KPiAtLQ0KPiAyLjMwLjINCj4gDQoNCg==
