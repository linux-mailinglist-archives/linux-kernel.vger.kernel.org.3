Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163535A9C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiIAQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiIAQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:07:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F591D1C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662048449; x=1693584449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cooSGfe0usPEWbZoHgQ5Hu1tIVpKbppCNEDuc6vJVQY=;
  b=pFOOiTUsHZpVuE/NUJIlEuQQ2sRNPa2mRnLRk9A0ItmgUH0M4WosPa0H
   k3skh4u8e5BNTrK+kXh0eijq54hP5ZvYMtbeR/dfUE6MgoVlSnSjBxOv6
   k4R963MIPlidRVa3Ps/C9qHVz0y2vyzcxihmN5I7VLRbz9DH6gaHRQ4Gg
   vMAcspQOzkFgeYBclO2c5CSsEtQU9VDRCxJiw4kLM80g/DwLzNHUkyko6
   Gj2IfXFssE8U+wTEOK8FMq59i0ZTO8zFayUaqjzSrTxV9DnYZZPV+2rz9
   a1T+YJOuNLwqDl/KC0CslAyM/nrpNgLcD78Ivx7FVQ7Es/AbY1ysA6P4f
   A==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="189031284"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 09:07:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 09:07:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 09:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy+7UAchCqAQb9vNsE7L+IctzAuUwXD49IL8m2Gf/sr97d98ksmAOFqT2HcBxiufgdBY5JZzDsZWl1ESza/bG/6VKKyPujj3Q/Cvcmd5L96yemhvjpz/Q7I16cwvZtoJWIk2FfMGmmTScWx+URCcJaDPR+WP+1oguApRVT41gV+QkMVvc8ShN+l8RO6B+J9947DVemm5uQCPRlcCEeyc4aEgX2zpHD48XRwyHLBzwIGcL4rz4TyuvRHg3qHL7jeYtWc6DQXGMygvw3hy91387zn5IIR9J69sznu9FjzaVQiQ15fOQKERL1C3XElCD9VhoB27KJTyl6SXK0IoNpVpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cooSGfe0usPEWbZoHgQ5Hu1tIVpKbppCNEDuc6vJVQY=;
 b=nn0qpT7dy691mcra6PX1L9bBxuig9ITZl6xxWkYVScxpV8DXu1ixPzY7cL63WwU5N6Q+QFrlv6semBBT0K14HQdy4wFvkyit5qJuC0IwsROa9Di3gSBclfmlNelPxkt1gMIEzLaUnoewQLYa46Ad1e7txOJAFY3f/fOHx+xeDdB+H1Ay3hXk5S6bMAuKidwz0XTd9K7S2wPkh+4CDUArRSkVvL8HLchul+BTCUZrzWoQYtA56Va56s+XscUTpCSCezEe0xPVHEv27xKVLwAIRN1tRzrYGAKO3Jqzxmi4H1d5viSyRiyNgikkxdIKuQA6KM9Bt2KoiFZmrys0uaVq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cooSGfe0usPEWbZoHgQ5Hu1tIVpKbppCNEDuc6vJVQY=;
 b=JoizYsquhUZWCEion38Ra76RMe7VH4fOgaaXsgTyGIAMeAY4/Xe6D+3lgd04A1YNbxBfVs1k1vsErHuJQN2JTzKUE41YTHFmIy11T04hp7F5ZYGQdZzFc246QQdGQE3GB1/Ublq+CdUp4jCHoAXOSbMspZnlP319mWKx2b8jw3g=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 16:07:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 16:07:21 +0000
From:   <Conor.Dooley@microchip.com>
To:     <apatel@ventanamicro.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
CC:     <atishp@atishpatra.org>, <heiko@sntech.de>, <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mchitale@ventanamicro.com>
Subject: Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
Thread-Topic: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
Thread-Index: AQHYvCu1UPk03OM4rUyI2zo2sTDn563KwX2A
Date:   Thu, 1 Sep 2022 16:07:21 +0000
Message-ID: <04b2941a-a8c9-76e8-3189-76c51b811174@microchip.com>
References: <20220830044642.566769-1-apatel@ventanamicro.com>
 <20220830044642.566769-2-apatel@ventanamicro.com>
In-Reply-To: <20220830044642.566769-2-apatel@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b48c6a2c-dce3-4e63-ee48-08da8c340d7d
x-ms-traffictypediagnostic: BY5PR11MB4024:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0d9DUm0l9Sjbezv/TxzCaiR/rhZvvgH/JSwZc3vZFcDQUgiXNbZvo0Pn+jB2u4A5F6wxAAnnoma/xRQJIfe6Uwa6FKZ1qviRDgSPYICiOBCaHKP8aRGACBDV8IUGyEt1ogzkWvpn37eme//lngyHh0bg2r+RH3eviJNvQP0c2IiBSrRus4n3xz/9ZIxCfieRICG6NwUJ3WeaVNGemD0wz3lActWmeQxxkWEZm54pWBD3SK8igtxzk4RQ4ThlSXSLssX+X23U04T+E4sqEeYerNhK6dnJkd/GCNDZ4mgDQz/ehrzQdJf7eQ9O/4SYiq9xxrXV8ND5hYqmb7Cb0M7wvIZn1fLsj6q5otBQlc9y6EZE01KbYOrSqkVt+DlUV6nvmtEGWRFVdQQM0uiPGWu34lUMGfwgkcYLnebzqaPJI/q2bihX+IN5dYJjW3zuA7oPuAAeBkkU8HKn/5hgq/fxh/w/vtfR/xqfDx3h9IVZXIwYFxbJf2pSvvfJiY5nb5EU1XVpQK+0k1GvhflTFD02DMdDQchlfyfYp30JP9v/FOMOI7NFglPyCXTSX06PVwjZxTTUhJMuJZZHW/AWpnSL08pqUnLLd38qpQSXBpvLV8exj/sCzMtW1f0R0twOrefsU0fOZNY+8kCnd7u4R4QOF0W/f2MBTU2hbtmEE9xvsE3jiBlkQN6nMJHuiiZ8x0Y6nvkimi+mPrJYe8IlAZeBsrTF+cvLTLMtcBcJsX7nG4G1ANP6X97xwgVR01BYvKej5/c64wpEgozNJr1a8wocDHrm9k8iLsN/8rBUCfbhhf8rN2XF52DrxjKlVa0nGVuhQCnbfEnCFci7jjZcRmWynIm7uzmyQviDVC4Fm2ZLmMU8iVIAuGNNpsqb4pcWtH2q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(6512007)(41300700001)(478600001)(110136005)(54906003)(31696002)(26005)(6486002)(316002)(5660300002)(86362001)(66446008)(8936002)(38070700005)(8676002)(4326008)(76116006)(91956017)(66946007)(64756008)(66556008)(53546011)(186003)(66476007)(6506007)(38100700002)(36756003)(122000001)(71200400001)(2906002)(2616005)(31686004)(17423001)(156123004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG1YN2ovSXZRSWc2L3BZRDFhS3ZGSmE3eUZ5alZFTUx4ZndDSUZQYTc2azdI?=
 =?utf-8?B?QVJFRjJkV1MvbFdaS21MdDhhTXBaOHNaaWtseGI0OWJLa2N4OTJKbHBOTmNQ?=
 =?utf-8?B?bzQxdnVKdE94SlpKamFZTmxWOGdnRzllQ2pKKzF0eGhHNUxIUTVNOW9KdHNw?=
 =?utf-8?B?cGpycmxuZ3d3L1p2N1hRZTdxdE1MTk9yQmtWejN3eXJzSURWcHRENWFZS2FI?=
 =?utf-8?B?QUNYdC9oYlF1UXprRk5KQU9NaElDTndzckE1Wk5WRkdIa0tiTG5QUXVQdVcx?=
 =?utf-8?B?Nm1zSUVEWlRWNFpTeExqREtkWUJ1djh6eDBIZGVTa0MzQkJ5Ly9odTEvSDVv?=
 =?utf-8?B?YStIVkcxbzhZM21YZW0wQ3NMNmgzVDNXR21lVk5tVitoVEQ4VWxRWmFGUXBn?=
 =?utf-8?B?TTJDTDBIckpycjN2alV0VWVQY010Vzd2dG5IM3djM2cvQWRRYnliRi9jOGFz?=
 =?utf-8?B?Q2JXWVpVQ21EK2ZJMWY3bm9aQko1UHQ5ZXJnUE1xYXJLLytOMDBGQlFwcS9x?=
 =?utf-8?B?ZDIyVkMxRFVEVjNaZ3ptV3FCVUJUYU9qY1BUQ3hEN2tvYWwrVFlZSENKaDBQ?=
 =?utf-8?B?UkROM2ZjandmM3QyM0FaaTlIZVNPUTVraytGVnZEdDMrUHJ3Rk1YRzZyYTZv?=
 =?utf-8?B?YzArNWsyOU5aUXNNR2k0TDFjcUl1RmJWTk56RVNDUVdubG04RklQc2NZajE0?=
 =?utf-8?B?bUNGT2VTRVVJTEdhMWV0aG5GZFNid2xmS3c2di9oZm10VXVSQlhDVGVmSWhJ?=
 =?utf-8?B?bkZRTVkxZ0NXMG9xWHdhckhqbVBxczA4N2hZMS9BZUQxeTZ1bFNBaEdxMkZy?=
 =?utf-8?B?ZWdzMGMrREhsOElWZXFDazh5VGxINGRzcWJTT3Z0UDFDSUhjZWVBaTJuYWpC?=
 =?utf-8?B?UXlYbXdWYmQ4NkhmNERjUndrWkt3WjJkRnNOd0FOUEFIRWQ3cHlPQm02YXZs?=
 =?utf-8?B?NWlmY1o2bmFxbVhLQWUyTVZrbmVWVEVOeTBTWCtvVy90VGorYytnajdtTkRl?=
 =?utf-8?B?V3NNS3IrdkhTNTlqZlQ0UlE1Zjd2MEdOZ3JVMVhPWm5Xc1lNZStvZkthWGRC?=
 =?utf-8?B?ekxSS2JjSk1vQlE0OW0zL2dMZGdoRElFa29XUDJNSHkxSFc0OFg2RjQ0cXdr?=
 =?utf-8?B?WXg2amhHbDIweStNcGRGbEhMakZOemZqMCtFV3R0ZXRBV2gxcG11UWNRUkN5?=
 =?utf-8?B?ME1aVDdyaS8xakRFRUNVbTYwZ2hmbTIwTjkybG9tSG1KS0hCNDFzd2tjQmhL?=
 =?utf-8?B?dEJ1MjNhTzN5VWdWUnpHTDAxQkxSOXNGN3FQeUQ2ZVJEelpzckxLVWQvV0V0?=
 =?utf-8?B?SnMwbUs4cDN6VVVZVDlmbDlJZzFiT0U5TmlaYUZNYWlVU01iQ2ZpTndscWUz?=
 =?utf-8?B?Zy9KelJsWmczNFNBRUxDaStYWkNpYWVFdUZiYUMrYVdQc1lVY3FFY2EwQUh3?=
 =?utf-8?B?ZkwzekE5TlNCZWVRT0VFZHJwb2VqZStWN2Y2dlZuNjB5MlRXdVovbWZYN0gv?=
 =?utf-8?B?R0EzckVxY0cxaWxqZXVBRWkyNTYzNHZFLzRNSkNhbDdpeGJxNHdzVUFlRFJR?=
 =?utf-8?B?R0RWRzhFNnBnbWVJRDJjeTBSK0d5YmpwTmljN0J2eGw2ZVd2MTVSWHNjTkJk?=
 =?utf-8?B?VkFORDdPMTdWcDRIYndWRVYzL0NieDR1QXpIQTNjNDhlMGxSTzdvN212SDcr?=
 =?utf-8?B?VFpmRStHbVRKMGR4SzUrc3JBNldqaUlHM2MrR3RMbW5qcjlna25uMmhtYm13?=
 =?utf-8?B?N0pDRjFhMUhGWityWmZvbUtUTCtGdXliU0pkcW5NbGFCR2hPMURibEIzTENv?=
 =?utf-8?B?emozeG1WbUhhNFkyckw2aUpuWlROL0dVd05yOWt4VXRzam1yN3A2OTRCSWJ0?=
 =?utf-8?B?a1o1NFBWejgvYldoU3A2RlVEQWhKMlRRSzFMdXYrb1g0MzA1emkyYmxmek1t?=
 =?utf-8?B?QlFoYVR1NnRFVHNqN0lzSTVlUHJSR3JIaWRmb1RKTjJ1MHl0TUF1Ung2Tzdu?=
 =?utf-8?B?ZTRkaFEydHpZbW5zUVV6bFRTaE5oeEs5bVVsZk85cG1NZk1Reng1c0E0RjZq?=
 =?utf-8?B?UDJOSm9VTzFnSU1tWkNaVU1WZ2pzT2xnNDlzbmhaam1GV2ZMRXFObTE1WlFt?=
 =?utf-8?B?b3ZTcnFac0RXTzFhRkpkUUhxV0NmZThpRFQ2QVh1MXkvMnZCRGpGK3VxUlMv?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9EED7077B554E4AAD5AFAEBA5B59DBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48c6a2c-dce3-4e63-ee48-08da8c340d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 16:07:21.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+hTrGHHa9d5GgkTNdbSdgnUc0kIzdZSoKYKH7t95CN4wwrozJpSBMLA5Z1zUcPnTol2s+41JZWt9E6gbrTKfiEhoIYQhPPFJX8e28SowMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4024
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAwNTo0NiwgQW51cCBQYXRlbCB3cm90ZToNCj4gQ3VycmVudGx5LCBhbGwg
Zmxhdm9ycyBvZiBpb3JlbWFwX3h5eigpIGZ1bmN0aW9uIG1hcHMgdG8gdGhlIGdlbmVyaWMNCj4g
aW9yZW1hcCgpIHdoaWNoIG1lYW5zIGFueSBpb3JlbWFwX3h5eigpIGNhbGwgd2lsbCBhbHdheXMg
bWFwIHRoZQ0KPiB0YXJnZXQgbWVtb3J5IGFzIElPIHVzaW5nIF9QQUdFX0lPUkVNQVAgcGFnZSBh
dHRyaWJ1dGVzLiBUaGlzIGJyZWFrcw0KPiBpb3JlbWFwX2NhY2hlKCkgYW5kIGlvcmVtYXBfd2Mo
KSBvbiBzeXN0ZW1zIHdpdGggU3ZwYm10IGJlY2F1c2UgbWVtb3J5DQo+IHJlbWFwcGVkIHVzaW5n
IGlvcmVtYXBfY2FjaGUoKSBhbmQgaW9yZW1hcF93YygpIHdpbGwgdXNlIF9QQUdFX0lPUkVNQVAN
Cj4gcGFnZSBhdHRyaWJ1dGVzLg0KPiANCj4gVG8gYWRkcmVzcyBhYm92ZSAoanVzdCBsaWtlIG90
aGVyIGFyY2hpdGVjdHVyZXMpLCB3ZSBpbXBsZW1lbnQgUklTQy1WDQo+IHNwZWNpZmljIGlvcmVt
YXBfY2FjaGUoKSBhbmQgaW9yZW1hcF93YygpIHdoaWNoIG1hcHMgbWVtb3J5IHVzaW5nIHBhZ2UN
Cj4gYXR0cmlidXRlcyBhcyBkZWZpbmVkIGJ5IHRoZSBTdnBibXQgc3BlY2lmaWNhdGlvbi4NCj4g
DQo+IEZpeGVzOiBmZjY4OWZkMjFjYjEgKCJyaXNjdjogYWRkIFJJU0MtViBTdnBibXQgZXh0ZW5z
aW9uIHN1cHBvcnQiKQ0KPiBDby1kZXZlbG9wZWQtYnk6IE1heXVyZXNoIENoaXRhbGUgPG1jaGl0
YWxlQHZlbnRhbmFtaWNyby5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1heXVyZXNoIENoaXRhbGUg
PG1jaGl0YWxlQHZlbnRhbmFtaWNyby5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwg
PGFwYXRlbEB2ZW50YW5hbWljcm8uY29tPg0KDQpTZWVtcyBzYW5lIHRvIG1lIHRvbyA6KQ0KUmV2
aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4g
LS0tDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2lvLmggICAgICB8IDEwICsrKysrKysrKysN
Cj4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0YWJsZS5oIHwgIDIgKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vaW8uaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW8uaA0KPiBpbmRleCA2
OTYwNWE0NzQyNzAuLjA3YWM2Mzk5OTU3NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNs
dWRlL2FzbS9pby5oDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW8uaA0KPiBAQCAt
MTMzLDYgKzEzMywxNiBAQCBfX2lvX3dyaXRlc19vdXRzKG91dHMsIHU2NCwgcSwgX19pb19wYnIo
KSwgX19pb19wYXcoKSkNCj4gICNkZWZpbmUgb3V0c3EoYWRkciwgYnVmZmVyLCBjb3VudCkgX19v
dXRzcSgodm9pZCBfX2lvbWVtICopYWRkciwgYnVmZmVyLCBjb3VudCkNCj4gICNlbmRpZg0KPiAg
DQo+ICsjaWZkZWYgQ09ORklHX01NVQ0KPiArI2RlZmluZSBpb3JlbWFwX3djKGFkZHIsIHNpemUp
CQlcDQo+ICsJaW9yZW1hcF9wcm90KChhZGRyKSwgKHNpemUpLCBfUEFHRV9JT1JFTUFQX1dDKQ0K
PiArI2VuZGlmDQo+ICsNCj4gICNpbmNsdWRlIDxhc20tZ2VuZXJpYy9pby5oPg0KPiAgDQo+ICsj
aWZkZWYgQ09ORklHX01NVQ0KPiArI2RlZmluZSBpb3JlbWFwX2NhY2hlKGFkZHIsIHNpemUpCVwN
Cj4gKwlpb3JlbWFwX3Byb3QoKGFkZHIpLCAoc2l6ZSksIF9QQUdFX0tFUk5FTCkNCj4gKyNlbmRp
Zg0KPiArDQo+ICAjZW5kaWYgLyogX0FTTV9SSVNDVl9JT19IICovDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20v
cGd0YWJsZS5oDQo+IGluZGV4IDdlYzkzNjkxMGE5Ni4uMzQ2YjdjMWEzZWViIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiArKysgYi9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiBAQCAtMTgyLDYgKzE4Miw4IEBAIGV4dGVybiBzdHJ1
Y3QgcHRfYWxsb2Nfb3BzIHB0X29wcyBfX2luaXRkYXRhOw0KPiAgI2RlZmluZSBQQUdFX1RBQkxF
CQlfX3BncHJvdChfUEFHRV9UQUJMRSkNCj4gIA0KPiAgI2RlZmluZSBfUEFHRV9JT1JFTUFQCSgo
X1BBR0VfS0VSTkVMICYgfl9QQUdFX01UTUFTSykgfCBfUEFHRV9JTykNCj4gKyNkZWZpbmUgX1BB
R0VfSU9SRU1BUF9XQwkoKF9QQUdFX0tFUk5FTCAmIH5fUEFHRV9NVE1BU0spIHwgXA0KPiArCQkJ
CSBfUEFHRV9OT0NBQ0hFKQ0KPiAgI2RlZmluZSBQQUdFX0tFUk5FTF9JTwkJX19wZ3Byb3QoX1BB
R0VfSU9SRU1BUCkNCj4gIA0KPiAgZXh0ZXJuIHBnZF90IHN3YXBwZXJfcGdfZGlyW107DQo=
