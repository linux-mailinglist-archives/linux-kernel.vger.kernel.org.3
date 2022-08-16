Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD92595567
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiHPIfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiHPIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:34:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C454650;
        Mon, 15 Aug 2022 23:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660631939; x=1692167939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cmtpWEkehJZpTpbsPqY37BQ+pGwsgpQGc0ZzvqBeVRw=;
  b=0zb8HbnGx2BtmzpZQflAhUwVCLW9G39zPRZL/yCgqZLIdkhoXifaXvuZ
   ACYdfC4zA4OFBQ6VdzIODvcQVO1mgM+N/RamnPt2XBCVAu2yUzDYcwqpi
   ZFBlh6gtrzxKEzHFdyHejN2PFnY9e/TFwmAqStajMribKN3lIJoSYZx2m
   n00f2ba4vd9jmsWW1uHO8whxxmxuYRcDm7XCtYajxxgyeYSrEz6qExJcx
   AGBZaJnx/YJNLkGs7Q/bfKXkVDy3pvGlBqCrzrfkb1tE6AW11ARXgD2Ud
   XjnbwVs9Xyt7ox7+uCTC8LyBELSZ4w9xcZVZlqduhEU136shF3OqVWd2R
   g==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="176531215"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 23:38:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 23:38:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 15 Aug 2022 23:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJt9h/9JPV5FHkGuvco59V74yQUe87R/khd3yhp2pnaq6fJswIS4oFC1SYpgTYd8VPmTA0QOe/XxWmDCEyKNXo4WFPpEcigIe36qDsr4/elU+Olodr2Nm5Hk74eGIvqoLaqJ87yvGjHKu2X/URCNNTJ6A7/YSZ0DkFb9xsGCEOqLZbNMkhnYtzWx9buZuVkM05Ou/qM7d+ceupjmYu6E9njqoanEZ3/G5X7C11iB8ueK7e6yGd5gcgaUcNIAmY+hCb9KdJNYihTB3n3piIbhTS16TYyOt85DqQe8lzKHy4MoIs3MS40sxaNpChbfYK0baLum3KmC5tPIbq4vtFTKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmtpWEkehJZpTpbsPqY37BQ+pGwsgpQGc0ZzvqBeVRw=;
 b=JW12ZygcbX0rFnZe/GjXqTyK4rw08x85qCvlAbt4uJ2NLtoZDb2hznKAOmNH85LowjIEsCOBekJbTErn0WPhqGpcjr3L0cGpZeAMAOnCPNtBEu4nfTPOJdyDuS6wjLJXf1vUe4OU3dpeqh6rwmXeUfg+TOmdIGKd4YpR0oY3CCiA47MVUPn4oj4P+nQ+EQZtkPM2v6IQt30YEht0Jv0gcWNiguFyBxxH5+meRjf+cLRVoxR9JRvmrcqOY0A9QXzVnpONfhPdP+iNDhF+nJx1qi2inwnXMWdz8XLCcwCp8XLe7+hhs9KTp7vLH7CboHsAHcaBf2V8MuSMEE9Bx+wTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmtpWEkehJZpTpbsPqY37BQ+pGwsgpQGc0ZzvqBeVRw=;
 b=NfwsRkjAOpzzAIf65ZdOG9vJtC+8X233afSRFLaaFJpGvgskVQAP97DhgcKAzvWjSJGtMHggCVTkYKQ3MQ26AK0/lxhaEUoXiWxnKZJV/ksMsW0FoLhK3G9O1QBZ9jiqMVh73MoakX1pq59KESVp7K/zp8xsiuteKSnnTdoExzQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1243.namprd11.prod.outlook.com (2603:10b6:3:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Tue, 16 Aug 2022 06:38:55 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 06:38:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <samuel@sholland.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Topic: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Index: AQHYsGUX6yPEPkvFO0eCq9swdC/Ww62vig+AgACpiACAAJ8rgIAAQhUA
Date:   Tue, 16 Aug 2022 06:38:54 +0000
Message-ID: <42417044-8635-8dc9-9e25-be79d9d6f099@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <50dc816c-3129-f5aa-9777-99c6f0fa58f1@microchip.com>
 <6b8cd27d-5671-7bcb-549d-e903cf019fe3@microchip.com>
 <6d54da3f-d4fc-7c40-38d6-4f02c7346458@sholland.org>
In-Reply-To: <6d54da3f-d4fc-7c40-38d6-4f02c7346458@sholland.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 568c6301-c7e2-45db-4b35-08da7f51fd53
x-ms-traffictypediagnostic: DM5PR11MB1243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?dVVCRyt4WFM3cDRQT0F2cmpCZ3hTeS96YVM1Smxkd3Z3Z1FlTENZZUJnQStR?=
 =?utf-8?B?RUYreEZhdmRob2p5L0tGS3VuTEhNUGtaSjNncU5URTlWRVlwcDZ4MlZ2cWRh?=
 =?utf-8?B?QXBmZHdxOVkzYTZZbG9jNkIwaTRtM1RFTnRxNlVzWCtpdzdiTXlLVlNnQzFs?=
 =?utf-8?B?OFN2NWlveFl4cUZ5YkNrTzBzdHlYc1Y5blUzZEphbTBNODhTQWx1ajRvblBF?=
 =?utf-8?B?MEQrMUdZekt6NmFvYld2WkJGTVptaXc1ODlyVkxUVW52bVl5OXBUUWU0em1z?=
 =?utf-8?B?a2ZOWjZzaU94WmQ4eGJFY1haMERFSlJVUWNWd2Zkb1VsZkMxcHZSVTlnWHdP?=
 =?utf-8?B?MjhJVGpqOTI2Z3RudFFPaDViSHVNUHV5dTRYVWpaeXZNOGJYd3V2MTFiSUVs?=
 =?utf-8?B?eHpUOVFvTThxUDdFdGQwM2dEdEdaTVozOGgwdXhMQWtwZEtrbUNOTUIzVDFt?=
 =?utf-8?B?OW9tWWRTVEFMSVZGV1oza3huazRmKzVIZFBFYzFHZHZaQXNsQlFYMXpTb3hD?=
 =?utf-8?B?eVVLRnc3T202N2dIWHBEbzZRdUNXWFpicVlmNlBVT0pHWXAydzNRSVJiYmFQ?=
 =?utf-8?B?Y0VpNlJRVGlzalpieFNPZ2t3SldjUlp0ZjZtb2s2dFdpMENqUEJBa2ozbTNW?=
 =?utf-8?B?VHBwQVFwN0hLbklYMjNXL3NEcEp0aUVNcWN1OVA3SjNJSVJ1dnJtVkdKYVlX?=
 =?utf-8?B?bEZveTdKV0NuaHZzQXY3MHIxcEMyZ3ZsVk1ZdEtBSmRaZWVSVXZTSWJqQ2lF?=
 =?utf-8?B?QXpSSkNUV1hWanpCSHdhVnFJMExlcWpoUHpQZEU0aThnZGxWbTYwNXgyS2JG?=
 =?utf-8?B?eTlFWmN6TWdoR0dtZXFlMXQxdnNqTkZCUmo2UnVHcFhxb25ydC9tTDVzT0g0?=
 =?utf-8?B?Z1lGRGl3c3ZYT05zS3hWRmZyQXJmbWhjNGVRWlZFQ25QOFY1d2cvTGk2bHZw?=
 =?utf-8?B?aHRBV0cxNDRKRXZ6bmlvUUprS0crNU05MXBnaEtlMXV3NWE5UFY1L2xKeW9E?=
 =?utf-8?B?NjA4dGx3YkdpVUlPbkFKSEt5OS9KRVhONWl6bG9aYlVUOW1LZitKTHZDWmln?=
 =?utf-8?B?N0I5Y1RTTGl3cXQzQVpBajV3cUQvM21yRWt3NWdSbFVKdCtDTEFqdWtoeTZY?=
 =?utf-8?B?S084MUVSajExbm5qM3hJTzA5OUh0eXFHS2d3SzhiS0R3NWNKRDc0bFEvZi9K?=
 =?utf-8?B?VVF0dUdqTnRYbzczNGN5ZU1oS29qbUZBVzhRUWxPdjNsZmhqbmtYWG0zTE14?=
 =?utf-8?B?UjV1a2hIK1hQcm84Y1VwQ1N3KzFycVBGdCt0V25XQyt5NkUvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(136003)(39860400002)(26005)(316002)(8676002)(6506007)(36756003)(110136005)(921005)(38070700005)(53546011)(7416002)(83380400001)(6512007)(478600001)(31686004)(186003)(41300700001)(2616005)(122000001)(966005)(64756008)(86362001)(2906002)(6486002)(31696002)(4326008)(76116006)(5660300002)(91956017)(66476007)(66556008)(71200400001)(66446008)(8936002)(38100700002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFJyQm5vK0lVYWNFTTFVK1VBMkVxZHlYRnh2b2hNTG0rR2V2aEU5a1ZYQXBT?=
 =?utf-8?B?N2FhZ3k0TmVMVkJVTU9GK2JNL2NGd1BsdWh5d2dhdHEwWnI2d2Y4Ukp4NzdG?=
 =?utf-8?B?MzlYSU5YNXRvci9TMEQxdGN4VU1xcGYyblBKVWJSbk1xdjM5ZnhpQjMxU0hC?=
 =?utf-8?B?by8yVGpUUWZERWxYZ3g3dmxpWnBIZHZ3WDFwbS9UWnh6NFdjdjNlUFdLQmla?=
 =?utf-8?B?OTk0RHloU3ZKU3lGQ1BpNHJFWjRmZjFnaGFtUHpkdys3YlhkcHdiMmc0VHBt?=
 =?utf-8?B?WXlDT1R3bFFvd0FZa3U3UC9lMG5Zb3hXZTh6TE9leHJwSDVhdmlrMFhYQnI1?=
 =?utf-8?B?cXlMUnh4WUxYNXNERCs1Rkpxb0pwUURmaHRvRDNRZWlFNk1OeE1XL2RVY2Rj?=
 =?utf-8?B?VUNyODRCQlg2YW1qYTdUcHJGcHp2UHNNQitRa3EyTW8wZjZVenhGU1IrQUtQ?=
 =?utf-8?B?clNYWVkvU0JsUDJXMTZVRXJ0dFZ2QWFwUWdwK1E0bWFiYlVibEFGcEllVmtH?=
 =?utf-8?B?emZuRmRaOUhoSlp6OEoxS3V6TG5WUWx2V0dqQWRmSHBuSkI2SG5lVXBNbWZF?=
 =?utf-8?B?Wk9RUFBCTnc2c2FWalBTT1BFMEl3WnZWNG9KUUlmWUpvMVdXUWJhbXN4ZTQr?=
 =?utf-8?B?Rk5ZdVNnS0NDUmEwNUlobzBoUG1PL01QQnZTd0tqdFVSOHVFVHNoOGZ4Yklq?=
 =?utf-8?B?QmFWYWlHN0R6ZDluZEtGRGtHcDJTcmhEV0NhMHRWa3Y5SHVBS0tPdzJBTVJZ?=
 =?utf-8?B?ejF5NXV1enAzZGJSWWJtcDJWMGRJVEJJVzNkZURPZUdDcnhjVHVMdW8wcFU1?=
 =?utf-8?B?SjJ1dnpuYjdtTk5EZ2dTV1krbkxwVWd4MWpHUWhzNXorRU02ODBEUldkeGV2?=
 =?utf-8?B?NmJYOHJ6TDJ2T0x2d0Njam85SHViYmxKRXM0SWNXS0Z1aTU2RTNDMHZvNmF1?=
 =?utf-8?B?eGN5c014UCtGZXBucVhJWU1yeFVoTlJGVUNvOTRmTklaOEM2WWxFYnl5TmNY?=
 =?utf-8?B?R21OMnROamNsSnowZG9qYjI2MkNPdkFnY1JESDhMSmdFcElSR1pwSGJoekhh?=
 =?utf-8?B?SUJXRWhDcTQ5OHEyVTFoSWRUU2JlekI2c2RjK3VFeWZYMHVEU3JZTTNINlJz?=
 =?utf-8?B?aHY5S2VoemNZM21US25xWXNOc3BtcFhUcXJjNTJQN0t4aUVvNHpVNU9HY3pP?=
 =?utf-8?B?d3R5ZHIyb0xtcjVtTjlKK3V3V2FxZUNKYzNLOFVXa1g3aVE3QnRLNXJ0ODBR?=
 =?utf-8?B?UStGWHlIekxlU3JBTVdUTDN6NG5mVDFQMnZqNTg5clYxNXU5czcrci9pbW1Y?=
 =?utf-8?B?U3h1ZUNJVURNZU5SZCs1amFoMGQvZlpEa0U0aFl4RlJhU2tkODUrRGFUWmx4?=
 =?utf-8?B?WUJ5YnoxZUtKeFRKcHFCb2hLR2d4QmI5dG5aNlBGOEZYWGlFSVh0Vmw0dmxL?=
 =?utf-8?B?eFhZeGhUQ2l5MkFPTjJ0eVY0QzAxL2hRWUFuL3R5d1QrMXVQZXRYQndyemc4?=
 =?utf-8?B?QzlqTmpPUDNrUDAxQ0U5WTdoaEJwNE13OVgzbXNMVXpYb1k4V0VGd3FxcUMw?=
 =?utf-8?B?R1d4eC9BQWM1QklzMEVoeXR3UWNXc1VvOG5VT0NuMU9nSEcySDc0b1BERVJ1?=
 =?utf-8?B?c2daeDlzOFlaaXgyb2g1WldZaWpWdzhOc2x4RXNPQ3ZvL3pxVHBaVFQ2Tmx2?=
 =?utf-8?B?Y3p4UTRKdlp3Q2ZpQ2dHWWFHMjNQbVB5NHBJalgvWVowVG5pSnV6bDNhaWNu?=
 =?utf-8?B?UmJVWHFjUi9TYnp4ZnJEQ3hrTkNoLzJ1ZlhLVUYvTGtQSGhtMGxTM2ZlL0Vm?=
 =?utf-8?B?VDVRNHluQ1FWUHAyZmR0NmxIMXdvMSsweXMwT2JiM0pPZ3FoTm1hZWRNQlBV?=
 =?utf-8?B?bHUzOGlwVUtUeVcvUGdBSi8rL0xzTDl0R3RGS0IvaDdiem9ndDZISHZDWThI?=
 =?utf-8?B?KzU1d1huZHVEbTJ5SFg0UXAvYmczRHdpeVMzcEkrb1ZLVVVQaGIwYjhGQ2Fo?=
 =?utf-8?B?N3c1Vk5vZ3FhZU9WM0t3Y1BXSEU1OWxXMFVMZWhOSkdrQTgvcmV0K1FUVWJT?=
 =?utf-8?B?c1BRd0dwbWhWSmI3VmIweVNqcXNsNm1ObkdGRmZodVBtTHliSFFSOU40cnd0?=
 =?utf-8?Q?E7hv6qL9eUIA6M8hkUlIqdC3R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67608BE79EC2F74F91150D2221699AE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568c6301-c7e2-45db-4b35-08da7f51fd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 06:38:54.5362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wASk5bVkTwwTVlMuCyuCVhTAEr8w99/vDguadPamPk9w8H2K/ifTS19gLRKflsRuyCUptlk2Ea8yZBJXiBQ+ZoTCh+9oGuzib1V1+tZvAhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1243
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDgvMjAyMiAwMzo0MiwgU2FtdWVsIEhvbGxhbmQgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gOC8xNS8yMiAxMjoxMiBQTSwgQ29ub3Iu
RG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAxNS8wOC8yMDIyIDA4OjA1LCBDb25v
ciBEb29sZXkgd3JvdGU6DQo+Pj4gSGV5IFNhbXVlbCwNCj4+PiBBcG9sb2dpZXMgZm9yIHRoZSBs
YXN0IGVtYWlsLCB0aGUgZmlyc3QgNSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzDQo+Pj4gZGlkbid0
IGNvcnJlY3RseSBsYW5kIGluIG15IGluYm94IGFuZCBJIHNraW1tZWQgJiByZXBsaWVkIHRvIHRo
ZQ0KPj4+IHdyb25nIGNvdmVyIGxldHRlci4uLiBJIGJsYW1lIGl0IGJlaW5nIHByZSA4IEFNIDsp
DQo+Pj4NCj4+PiBPbiAxNS8wOC8yMDIyIDA2OjA4LCBTYW11ZWwgSG9sbGFuZCB3cm90ZToNCj4+
Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+Pj4+IFRoaXMgc2Vy
aWVzIGFkZHMgdGhlIEtjb25maWcvZGVmY29uZmlnIHBsdW1iaW5nIGFuZCBkZXZpY2V0cmVlcyBm
b3IgYQ0KPj4+PiByYW5nZSBvZiBBbGx3aW5uZXIgRDEtYmFzZWQgYm9hcmRzLiBNYW55IGZlYXR1
cmVzIGFyZSBhbHJlYWR5IGVuYWJsZWQsDQo+Pj4+IGluY2x1ZGluZyBVU0IsIEV0aGVybmV0LCBh
bmQgV2lGaS4NCj4+Pj4NCj4+Pj4gVGhlIFNvQyBkZXZpY2V0cmVlIHVzZXMgYmluZGluZ3MgZnJv
bSB0aGUgZm9sbG93aW5nIHNlcmllcyB3aGljaCBoYXZlDQo+Pj4+IG5vdCB5ZXQgYmVlbiBtZXJn
ZWQ6DQo+Pj4+IC0gU1JBTSBjb250cm9sbGVyOg0KPj4+PiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDIyMDgxNTA0MTI0OC41MzI2OC0xLXNhbXVlbEBzaG9sbGFuZC5vcmcvDQo+
Pj4+IC0gTlZNRU0gY2VsbCBiaXRzIHByb3BlcnR5IGNoYW5nZToNCj4+Pj4gICAgIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA4MTQxNzM2NTYuMTE4NTYtMS1zYW11ZWxAc2hvbGxh
bmQub3JnLw0KPj4+PiAtIEluLXBhY2thZ2UgTERPIHJlZ3VsYXRvcnM6DQo+Pj4+ICAgICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIwODE1MDQzNDM2LjIwMTcwLTEtc2FtdWVsQHNo
b2xsYW5kLm9yZy8NCj4+Pj4NCj4+Pj4gQWxsIHRocmVlIG9mIHRoZXNlIGFyZSByZXF1aXJlZCB0
byBzZXQgdGhlIGNvcnJlY3QgSS9PIGRvbWFpbiB2b2x0YWdlcw0KPj4+PiBpbiB0aGUgcGluIGNv
bnRyb2xsZXIsIHdoaWNoIEkgd291bGQgY29uc2lkZXIgaW1wb3J0YW50IHRvIGhhdmUgaW4gdGhl
DQo+Pj4+IGluaXRpYWwgdmVyc2lvbiBvZiB0aGUgZGV2aWNldHJlZS4NCj4+Pj4NCj4+Pj4gVGhl
IFNvQyBkZXZpY2V0cmVlIGRvZXMgY29udGFpbiBvbmUgc21hbGwgaGFjayB0byBhdm9pZCBhIGRl
cGVuZGVuY3kgb24NCj4+Pj4gdGhlIGF1ZGlvIGNvZGVjIGJpbmRpbmcsIHNpbmNlIHRoYXQgaXMg
bm90IHJlYWR5IHlldDogdGhlIGNvZGVjIG5vZGUNCj4+Pj4gdXNlcyBhIGJhcmUgInNpbXBsZS1t
ZmQiLCAic3lzY29uIiBjb21wYXRpYmxlLg0KPj4+DQo+Pj4NCj4+PiBJIHRyaWVkIHRoaXMgc2Vy
aWVzIG9uIHRvcCBvZiBib3RoIDYuMC1yYzEgJiBuZXh0LCBidXQgSSBzYXcgYSBzaGVkDQo+Pj4g
bG9hZCBvZiBlcnJvcnMgZnJvbSBkdGJzX2NoZWNrLiBJJ2xsIHRha2UgYSBsb29rIGF0IHRoZSBy
ZXN0IG9mIHRoZQ0KPj4+IHNlcmllcyBsYXRlciBvbiwgYnV0IGp1c3QgRllJLiBUaGlzIHRpbWUg
SSBkaWQgYXQgbGVhc3QgcmVhZCB0aGUNCj4+PiByaWdodCBjb3ZlciBsZXR0ZXIgYW5kIGFjdHVh
bGx5IGFwcGxpZWQgeW91ciBkZXBlbmRlbnQgc2VyaWVzLi4NCj4+PiAvZmFjZXBhbG0NCj4+Pg0K
Pj4+IEkgaGF2ZSBiZWVuIHRyeWluZyB0byBnZXQgcmlzY3YgZG93biB0byAwIHdhcm5pbmdzIGFu
ZCB3b3VsZCBub3QgYmUNCj4+PiBpbiBmYXZvdXIgb2YgYWNjZXB0aW5nIHBhdGNoZXMgdGhhdCBn
byBpbiB0aGUgb3RoZXIgZGlyZWN0aW9uLg0KPj4+IChUaGlzIHBhdGNoc2V0IGN1cnJlbnRseSBw
cm9kdWNlcyBhYm91dCA0NyBuZXcgd2FybmluZ3MpDQo+IA0KPiBPbmx5IDQgdW5pcXVlIG9uZXMg
OikNCj4gDQo+IFRoYW5rcyBmb3IgY2hlY2tpbmcgdGhpcy4gSSBoYWQgZG9uZSBhIGNvdXBsZSBv
ZiBwYXNzZXMgY2xlYW5pbmcgdGhpbmdzIHVwLiBUaGUNCj4gcmVtYWluaW5nIHdhcm5pbmdzIGFy
ZSB0aGUgb25lcyBJIHdhcyB1bnN1cmUgaG93IHRvIGZpeC4NCj4gDQo+PiBGV0lXIHRoaXMgaXMg
d2hhdCBJIHNlZSwgTE1LIGlmIEkgYW0gbWlzc2luZyBzb21ldGhpbmcuDQo+PiBhbGx3aW5uZXIv
c3VuMjBpLWQxLWxpY2hlZS1ydi5kdGI6IGkyY0AyNTAyMDAwOiBVbmV2YWx1YXRlZCBwcm9wZXJ0
aWVzIGFyZSBub3QgYWxsb3dlZCAoJ2RtYS1uYW1lcycsICdkbWFzJyB3ZXJlIHVuZXhwZWN0ZWQp
DQo+IA0KPiBUaGlzIG9uZSBpcyBuZXcgd2l0aCBkdC1zY2hlbWEgMjAyMi4wOC4xIChJIHdhcyBw
cmV2aW91c2x5IG9uIGQxZjMxMDJlIGxvY2FsbHkpLg0KPiBJJ20gbm90IHN1cmUgaWYgaXQgaXMg
YSBidWcgaW4gdGhlIGJpbmRpbmcgb3IgaW4gdGhlIGR0LXNjaGVtYSB0b29sLiBUaGUNCj4gd2Fy
bmluZ3MgZ28gYXdheSBpZiBJIGRvOg0KDQpZdXAsIHRoZXJlIHdlcmUgc29tZSBjaGFuZ2VzIHRv
IGhhbmRsaW5nIG9mIHVuZXZhbHVhdGVkUHJvcGVydGllcw0KYmV0d2VlbiAuMDcgJiAuMDgNCj4g
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvbWFydmVsbCxt
djY0eHh4LWkyYy55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pMmMvbWFydmVsbCxtdjY0eHh4LWkyYy55YW1sDQo+IEBAIC03Miw2ICs3Miw3IEBAIHJlcXVp
cmVkOg0KPiAgICAgLSBpbnRlcnJ1cHRzDQo+IA0KPiAgIGFsbE9mOg0KPiArICAtICRyZWY6IC9z
Y2hlbWFzL2RtYS9kbWEueWFtbCMNCj4gICAgIC0gJHJlZjogL3NjaGVtYXMvaTJjL2kyYy1jb250
cm9sbGVyLnlhbWwjDQo+ICAgICAtIGlmOg0KPiAgICAgICAgIHByb3BlcnRpZXM6DQo+IA0KPiBC
dXQgSSB3b3VsZG4ndCBleHBlY3QgdGhpcyB0byBiZSBuZWNlc3NhcnksIHNpbmNlIGRtYS55YW1s
IGhhcyAic2VsZWN0OiB0cnVlIi4NCj4gQ29tcGFyZSB0aGUgdGhpcyB3aXRoIHRoZSBVQVJUcy4g
TmVpdGhlciBzZXJpYWwvc25wcy1kdy1hcGItdWFydC55YW1sIG5vcg0KPiBzZXJpYWwvc2VyaWFs
LnlhbWwgcmVmZXJlbmNlcyBhbnkgRE1BIHByb3BlcnRpZXMsIHlldCB0aGVyZSBpcyBubyB3YXJu
aW5nIGZvciB0aG9zZS4NCj4gDQo+PiBhbGx3aW5uZXIvc3VuMjBpLWQxLWNsb2Nrd29ya3BpLXYz
LjE0LmR0YjogcG1pY0AzNDogY29tcGF0aWJsZTogJ29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQs
IG9uZSBtdXN0IGJlIGZpeGVkOg0KPj4gYWxsd2lubmVyL3N1bjIwaS1kMS1kZXZ0ZXJtLXYzLjE0
LmR0YjogcG1pY0AzNDogY29tcGF0aWJsZTogJ29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9u
ZSBtdXN0IGJlIGZpeGVkOg0KPiANCj4gVGhlIG5ldyBjb21wYXRpYmxlIGlzIGluIGxpbnV4LW5l
eHQuIEkgY2FuIGFkZCBpdCB0byB0aGUgY292ZXIgbGV0dGVyIGZvciB2MjoNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtZGV2aWNldHJlZS8yMDIyMDgxMDAxMzQzMC4yNzA2MS0xLXNh
bXVlbEBzaG9sbGFuZC5vcmcvDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbGVlL21mZC9jLzk3
ZWNkYTBmNjE1ZQ0KDQpQbGVhc2UgZG8gOikNCg0KPiANCj4+IGFsbHdpbm5lci9zdW4yMGktZDEt
bGljaGVlLXJ2LmR0YjogZXRoZXJuZXRANDUwMDAwMDogVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBh
cmUgbm90IGFsbG93ZWQgKCdtZGlvJywgJ3Jlc2V0LW5hbWVzJywgJ3Jlc2V0cycgd2VyZSB1bmV4
cGVjdGVkKQ0KPiANCj4gVGhpcyBzaG93ZWQgdXAgd2l0aCBhIGR0LXNjaGVtYSB1cGRhdGUgaW4g
dGhlIGxhc3QgeWVhciBvciBzby4gVGhpcyBtYXkgYmUgYSBidWcNCj4gaW4gdGhlIGJpbmRpbmc/
IGFsbHdpbm5lcixzdW44aS1hODN0LWVtYWMueWFtbCBwaWNrcyB1cCB0aGVzZSB0aHJlZSBwcm9w
ZXJ0aWVzDQo+IGZyb20gc25wcyxkd21hYy55YW1sLCBidXQgZG9lcyBub3QgaGF2ZSB0aGVtIGlu
IGl0cyBvd24gInByb3BlcnRpZXMiIGJsb2NrLg0KPiAocmVzZXRzIGFuZCByZXNldC1uYW1lcyBh
cmUgZXZlbiBpbiAicmVxdWlyZWQiISkNCj4gDQo+PiBhbGx3aW5uZXIvc3VuMjBpLWQxLWxpY2hl
ZS1ydi04Ni1wYW5lbC03MjBwLmR0YjogZXRoZXJuZXRANDUwMDAwMDogVW5ldmFsdWF0ZWQgcHJv
cGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdwaHktc3VwcGx5JyB3YXMgdW5leHBlY3RlZCkNCj4+
IGFsbHdpbm5lci9zdW4yMGktZDEtZG9uZ3NoYW4tbmV6aGEtc3R1LmR0YjogZXRoZXJuZXRANDUw
MDAwMDogVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdwaHktc3VwcGx5
JyB3YXMgdW5leHBlY3RlZCkNCj4gDQo+IEkgdGhpbmsgdGhpcyBvbmUgaXMganVzdCBmbGF0IG91
dCBtaXNzaW5nIGZyb20gdGhlIGJpbmRpbmcuIEl0IGlzIHByZXNlbnQgaW4gdGhlDQo+IG90aGVy
IHR3byBBbGx3aW5uZXIgRXRoZXJuZXQgTUFDIGJpbmRpbmdzLCBidXQgbm90IHRoaXMgb25lLg0K
DQpDb29sLiBNYXliZSBSb2IgT3IgS3J6eXN6dG9mIGNhbiBzaGVkIHNvbWUgbGlnaHQgb24gdGhl
IG90aGVycy4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCg==
