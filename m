Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6958E849
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiHJHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiHJHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:55:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338B71710
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660118144; x=1691654144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Ete+A4Uo3DDru+XEV5+p88EZqE64a+ko6TYtjL5wW4=;
  b=G7vXKCkmwLs/wD2qJvqbB2IDk0LdnrMtWfrYSS0MAeLLBpcMRqMO+bY0
   tjNJSaxbG4fRtgZg+H5CQEe2igfJXhF9UHmmA1EImHx6BFaIAztNFvpwR
   RPETmJz8oJRFZGodPldaV8zdET6TRNkzjRM6zhbjZDWrOTrM6ODPO096O
   Oyj7Tb+QtirWvb+TVToHaLmIapp9deuKs64OEBavRNBVRXxQ9yPW0XhgX
   99gImgRLMcFT/ALWrW1YWTG3wvb9XvgeENMYMuBxmAQ8J36swy6wFd27W
   1b4k8V8549EU2HqdwyAogpDK2ui/qSTuvfmZdWxrtbHO88MYwZIzheERt
   w==;
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="175794513"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2022 00:55:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 10 Aug 2022 00:55:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 10 Aug 2022 00:55:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjqM/w8X6OIzfeUZRJnoV79jSnY7NeTc6rEquSERUeiOAV6SNbIomLQX3gQkslF4fxvXXmaLrqNkO2911tHnwAzDZ+zh/i31dwtVYJuWOtz6uJqoqzal/6vgZ2b9XouDye8zH8C5lJwhVlLG3/Iu4OL6ZFs4wboWfj5qkq50y7dgYdPvmlSV4oBbEdz4IEEciV45UYUXe6Z2/s31WR4foeLPT8LXYAnIoEi9KC0qazCOn6PHR9NkSHxdofvRt2935Bm0NOaRLG/O+Gx1MV+kfDmAMto87/+mQjO6eVDrgV6CdupGEiF3AtgNXT4WMSaZIADfHbF5vDWNIqAO/AmS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ete+A4Uo3DDru+XEV5+p88EZqE64a+ko6TYtjL5wW4=;
 b=UXDlMcJuQfP7Zo4/15MB2jEDzxF5ZLFSBuy+ZtcWMw3iTS6Z1Rkv9iu3y62sIZEZebg3PluP/uqugS04oOqXa8h0cZQVesDgsWTl9rLR2sWmPhL8A5p2z4Xto+fwYmtyfWXdm3J62/MYBLhP+TpZU+UyaOfyqhusokALeA6q5md1mntnCpdIE/zKvTr5KCiTOtsWzvBTinSNfc2MAtGDz/33r5Ybsi5Qgj1LdfnH46QjMtyCtwmYtL87TN+AsHd7/ZtALCGIeXcQeRmGAXjLggOVuSDAsfz2sj6yQ1IhOFQn/yEUsElkpRmKnGLrDwTvVy/yqhmYkXaM75oZY1lNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ete+A4Uo3DDru+XEV5+p88EZqE64a+ko6TYtjL5wW4=;
 b=EgsfR4Yi7UdN2M/I3qeJOKQkrawbH2JnSPkkIQaWsuO70DQFgr+wEcatFhCWf9gm+Hj8STzXowNzrfFNGbpjG0bvQz2OvIYs8zl4vcuzEhK70Xd18NLh6NF7+CIm3MC7Sf5y0t8rWyVYWQIPcjhmRZtni0od+vZ2Y8gWImsVybI=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Wed, 10 Aug 2022 07:55:39 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1cf7:6d4b:5e26:3f56]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1cf7:6d4b:5e26:3f56%8]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 07:55:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sudip.mukherjee@sifive.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <greentime.hu@sifive.com>, <jude.onyenegecha@sifive.com>,
        <william.salmon@sifive.com>, <adnan.chowdhury@sifive.com>,
        <ben.dooks@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: issi: is25wp256: Init flash based on
 SFDP
Thread-Topic: [PATCH v2 1/3] mtd: spi-nor: issi: is25wp256: Init flash based
 on SFDP
Thread-Index: AQHYrI6UxPDo6RxI3UKhgSYQjCexQQ==
Date:   Wed, 10 Aug 2022 07:55:39 +0000
Message-ID: <2a50d782-ff21-91af-8488-503168e29867@microchip.com>
References: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
 <20220809201428.118523-2-sudip.mukherjee@sifive.com>
In-Reply-To: <20220809201428.118523-2-sudip.mukherjee@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 622b137e-bc6b-4204-4833-08da7aa5b75a
x-ms-traffictypediagnostic: PH0PR11MB4998:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6EnYL4E2eFq7/CGpJs9aVHVD6ZIEmvSrhHjX+5e4rzbOcppE2e/ScfAJhVsO+Ibp4nyKfVJwgvAkU5UH/M8jAXWN1FTqiS7bhGB6jeVcsab1kq7eUw4rY6ZWaaEN/4WGjnGSn3qCf0DTOL15QrzQrz8lL7/VTgi+n5EwbWmvB8WKNPjSqs1q1/MVGu8ayIgCiKtR8djLbntw+xGQ3mCOGHti9Now8zkiF2qAS+biYALB0/Ql2nHNHcBUZkvBX72IF4IPExhWhoIPk9kMvNAuyZhq2pC/dMWy+ScoeYTnb5gAx0oN/CcposIOOIgLlv5SDsh48/tLj8GgTp85n0V/IRdDYpVO7ftsfl6/PJIP6TstZcncVBEvpmZ2a9Ocg3ljwuc+ZhYpwfOYtVMMvww3pJGeGQG8m9iB5tj4H+D5/UiqgaEvtzKdqzZ4WYcLXPhjJpQzpljfpogut52eMDWkF4Wod6Jw5bfR1xMPLoRiLeAOSv59+ClmjjzPmV35yLeGdyEQ/qlGY/q3O8qQHY69WgGr8t+J9kLuLtUMi7cGIKrkEULdgXjN1HfVvon6/6pYv9wYnI+HvpWnASvPvnE9cnsHlTkCa6QPFAhX+m8ku56EpRPWNWbS3OA582mAQyQ6Q88+gb6UDXIlXGCnDMD5H+thVeQuEgWn/dUw641LuTiY+OWbGd7GZvy8Vwv7VAXok42ANw8dYrqPc8shcBIeQHoeu4U/w1BvfcZ6GaXKydnAEpySdZKnFjqEwXiceRz2k6joC3beIYBh908yxvw8Btv5MkQqs8RVwF4tDZHuMzbHSk2B26bBjQwL6Q/IuWyyPq0LXaJs72fpJcNYSYP5yUgf19nElAA++lca82GZe62/uRgiZgby1p+XpL+4rBj9PX2hjKJOF0bZxbuWASVMAB3YkmMcl17uY0Eh92F+zQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(376002)(366004)(39860400002)(186003)(122000001)(41300700001)(71200400001)(8936002)(5660300002)(31686004)(2616005)(83380400001)(2906002)(38070700005)(91956017)(66446008)(66556008)(53546011)(66946007)(64756008)(66476007)(38100700002)(36756003)(7416002)(26005)(54906003)(478600001)(86362001)(31696002)(6486002)(4326008)(316002)(76116006)(8676002)(110136005)(6506007)(6512007)(43740500002)(45980500001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU5vZ2ZTM3FkMFgvcmdHZGxaczNYSVJtdzFEeUk2QlM4a1BMenNJaStRR0Rp?=
 =?utf-8?B?OHRVTWcvMG95VjQ4QW95MTlsamQybGlqNllkWXB1UEt3a1NOc0lXV3FPNGVm?=
 =?utf-8?B?dzNHUTJOVmE3d0RJN1RFTkpsTFNnT0NSUFRITWtHWlBwTkRHNzl5TU80M2dH?=
 =?utf-8?B?aE4rZ2RRYStPNGdGZFNhZWRIUVFjVTI5RGpXMjBCM3U5QmhuUGxBRVAycndW?=
 =?utf-8?B?TENaMGdpTHRLN0dJNGIzY3RENEhpL2FHNFUzajRqWExJdCtkVHc2NTIrWlIw?=
 =?utf-8?B?VU5VQ1lZblJIZHhtaHJXbDlidFJzNWluWTNVN2FUemNqbFVzZGlYcGZNZ2sw?=
 =?utf-8?B?MmVBWmNMTUxyYU5yWlNhUzFXUEFSbk9BNFdnV1FDKzFQU3B5a2JGRlJaUmZr?=
 =?utf-8?B?QUpJaWRKVzY1UFp5RTVBT2ZrMENMUENKcUNrcmNWQ0N4VkgzeWFnZWhPQ251?=
 =?utf-8?B?VllWYkZFQjhuenVjclRjVURHQ2lPWnZPUFhaMWxhRUhrSlprOG02S0lnUnI3?=
 =?utf-8?B?dVVEYWRpaXREVmhsR0ZZRnQyZGt4c2dJbEZhR2JGdUhCd1VoT3JnL2d4TWFP?=
 =?utf-8?B?aGxiMzc1NU9LMTd6dTEwOVVEY3pGSmMvaUtXWEM4WVNTWENvdE9jQ0dQT2xq?=
 =?utf-8?B?SE9JNFE3OXNZcWRQVzNHTzdkS2k0a2tRQnVGZzRaTUh1NWdRdU83cEFNdFcz?=
 =?utf-8?B?VkJ2NTNPQ0ZkRjNvUVBaTmJLTDRzSERValhZeGkxUTNYVWVzd1hiNFZlZGl0?=
 =?utf-8?B?MzVqUk15ajRyVmM2RkhqQlBBcmhwRDB4ZU95eGt1dUlMbkNOQUNJOXdDRmh3?=
 =?utf-8?B?ODM2SW4ycWRYdm0xOTBjcGVTMjhXUUh1UVFyeXlHRzgwUVA3eWViYVlBNy9w?=
 =?utf-8?B?dTlaRUQxc0grYlBUTFJmYjZVL2U3b3FnRG1Xam5ZdmxBU3pnckcyZStjeFVq?=
 =?utf-8?B?bmNVNXZVeS9ZQ2NJbXEzVitlWG83VjlTM0pZM3JEUmpOcTFkWjZ0S3A0Ym9T?=
 =?utf-8?B?VGhYbjFNQWl4WU1uajlvRGdUNXBSUTg1MWJ2WWdJK3FyeEJ5Mmd5S2tHZUlB?=
 =?utf-8?B?azZjUncwajdIRVEybUMyT3JaVW9LY0Nod2tabVNPbHdBUm5wckpZMi91cXZy?=
 =?utf-8?B?cWJYTzJkNnZVbWRiY21pWjBPT2hWckk1RDNvdEltVlFvMkJGOHBYaHFhYW9H?=
 =?utf-8?B?VmFYMi9jQWVQbXNkdGxsaXg5M0k4UWF2eTA5cUpZV1hhNEQ2MVo5dXVGMmFN?=
 =?utf-8?B?aitUeG1VZ2ppc0dNRGR6K0d4OGsxRWtOWDZqVUtzbGRzQkV2YmpwY1MreGtu?=
 =?utf-8?B?aVlEcHVHckFkVnUvUU1TMGR4SytSNFM0OFcrT3RnYU9mZnlhZFdGYVRGT2dG?=
 =?utf-8?B?TWdXVkt5aFlHYUxxSEg2MDVNeXdvVW9KNGNLSUhaT2RZeDBCcUdQM3dHSXFP?=
 =?utf-8?B?SzFtRlJ3T1JXeEpPS3FLUEZWOXMzY2xMNmdWMHMrUVZMb25RZkJsYi9VZDNR?=
 =?utf-8?B?cmMrQjRLTC9QRC9sU2gyVSs0ZE45TWs3dnBjcTJYN1VtSWVjc1NEem9tNXJa?=
 =?utf-8?B?MXpQbGJIam0zZlhvdUZuU251K3ZRbzBkRERlRzNJRkxxNVdLOVJIWlQvdXZk?=
 =?utf-8?B?Sm50TzhXZzdTL3lJZGdydWRxbG5UWjYySzdGOHBjV2ZRamdCeW9qaDNCYzNE?=
 =?utf-8?B?bVlxM2tWRzM2bFpQZXBCMGRObVN0RGlEVmorTm5Za1ljM3Bmd0hlMUhZampa?=
 =?utf-8?B?RDZKelhsc1Bya0dlc0R2ME1ZdmVtMWY1N0FHRzE1L1ZFUUxWYXJjeFhRRitK?=
 =?utf-8?B?TlNjcHd4V3lnVjk5b1NUaEVnaXJTUDRnWHdEMHVVZ2kxRXZ1d3krTlVHNEtM?=
 =?utf-8?B?VnE3T2lMV1NyWEkyLzI4SGNJdFlmMTlpY0JjeS8yaXdpZ0FuYldST3R3K0lD?=
 =?utf-8?B?YUN0SFplbnIwTWZ3VjBHb2NFK0Z4ZWlJWEZWK0lGV3VxQmdZWWhlQ0pqRlpm?=
 =?utf-8?B?cE14WEFPa0oydy9GMWJGTkJlSUQrT2pZdHhHNXhON0RCQzJTMVdCSEZGVklF?=
 =?utf-8?B?Wmp1ektOckF2c3F4NWhycnU5Y1RLM00zOHllcWVLU2E0STJ2OENFTVB3OVdL?=
 =?utf-8?B?bnQzTWV1d0FXZFFyaXlLOURNcTJ4eU9HYTVsY3Bhc2lKM2tCTmRkclBWM0pD?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <029933D82E907D4791CBD074C5C34DF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622b137e-bc6b-4204-4833-08da7aa5b75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 07:55:39.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZbX/0TM4RQT4gHXdD3CHSqjqI4fCDyNncGgMg7rq43PvlIJn4PUeaMnpD81I6CWWmWd4GzM5K4d6BbGTCUR4cbnNEHIPi77udOGU8iTFwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC85LzIyIDIzOjE0LCBTdWRpcCBNdWtoZXJqZWUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIGRhdGFzaGVldCBvZiBpczI1d3AyNTYgc2F5
cyBpdCBzdXBwb3J0cyBTRkRQLiBHZXQgcmlkIG9mIHRoZSBzdGF0aWMNCj4gaW5pdGlhbGl6YXRp
b24gb2YgdGhlIGZsYXNoIHBhcmFtZXRlcnMgYW5kIGluaXQgdGhlbSB3aGVuIHBhcnNpbmcgU0ZE
UC4NCj4gDQo+IFRlc3Rpbmcgc2hvd2VkIHRoZSBmbGFzaCB1c2luZyBTUElOT1JfT1BfUkVBRF8x
XzFfNF80QiAweDZjLA0KPiBTUElOT1JfT1BfUFBfNEIgMHgxMiBhbmQgU1BJTk9SX09QX0JFXzRL
XzRCIDB4MjEgYmVmb3JlIGVuYWJsaW5nIFNGRFAuDQo+IEFmdGVyIHRoaXMgcGF0Y2gsIGl0IHBh
cnNlcyB0aGUgU0ZEUCBpbmZvcm1hdGlvbiBhbmQgc3RpbGwgdXNlcyB0aGUNCj4gc2FtZSBvcGNv
ZGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3VkaXAgTXVraGVyamVlIDxzdWRpcC5tdWtoZXJq
ZWVAc2lmaXZlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2lzc2kuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvaXNzaS5jIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9pc3NpLmMNCj4gaW5kZXggODlhNjZhMTlkNzU0Li44YjQ4NDU5YjUwNTQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvaXNzaS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvaXNzaS5jDQo+IEBAIC03MSw3ICs3MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
Zmxhc2hfaW5mbyBpc3NpX25vcl9wYXJ0c1tdID0gew0KPiAgICAgICAgIHsgImlzMjV3cDEyOCIs
ICBJTkZPKDB4OWQ3MDE4LCAwLCA2NCAqIDEwMjQsIDI1NikNCj4gICAgICAgICAgICAgICAgIE5P
X1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JF
QUQpIH0sDQo+ICAgICAgICAgeyAiaXMyNXdwMjU2IiwgSU5GTygweDlkNzAxOSwgMCwgNjQgKiAx
MDI0LCA1MTIpDQo+IC0gICAgICAgICAgICAgICBOT19TRkRQX0ZMQUdTKFNFQ1RfNEsgfCBTUElf
Tk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKQ0KPiArICAgICAgICAgICAgICAgUEFS
U0VfU0ZEUA0KPiAgICAgICAgICAgICAgICAgRklYVVBfRkxBR1MoU1BJX05PUl80Ql9PUENPREVT
KQ0KPiAgICAgICAgICAgICAgICAgLmZpeHVwcyA9ICZpczI1bHAyNTZfZml4dXBzIH0sDQo+IA0K
PiAtLQ0KPiAyLjMwLjINCj4gDQoNCkxvb2tzIGdvb2QgdG8gbWUuDQpXaGVuIHN1Ym1pdHRpbmcg
Zmxhc2ggdXBkYXRlcyBvciBuZXcgZmxhc2ggYWRkaXRpb25zLCB3ZSByZXF1aXJlIGNvbnRyaWJ1
dG9ycw0KdG8gZG8gYSBsaXR0bGUgdGVzdCB1c2luZyBtdGQtdXRpbHMgYW5kIHRvIGR1bXAgdGhl
IFNQSSBOT1Igc3lzZnMgZW50cmllcy4NCldvdWxkIHlvdSBwbGVhc2UgZG8gdGhhdD8NCg0KSGVy
ZSdzIHRoZSBzaW1wbGUgdGVzdDoNCg0KUnVuIHRoZSB0ZXN0X3FzcGkuc2ggc2NyaXB0OiANCiMh
L2Jpbi9zaCANCg0KZGQgaWY9L2Rldi91cmFuZG9tIG9mPS4vcXNwaV90ZXN0IGJzPTFNIGNvdW50
PTYgDQptdGRfZGVidWcgd3JpdGUgL2Rldi9tdGQ1IDAgNjI5MTQ1NiBxc3BpX3Rlc3QgDQptdGRf
ZGVidWcgZXJhc2UgL2Rldi9tdGQ1IDAgNjI5MTQ1NiANCm10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRk
NSAwIDYyOTE0NTYgcXNwaV9yZWFkIA0KaGV4ZHVtcCBxc3BpX3JlYWQgDQptdGRfZGVidWcgd3Jp
dGUgL2Rldi9tdGQ1IDAgNjI5MTQ1NiBxc3BpX3Rlc3QgDQptdGRfZGVidWcgcmVhZCAvZGV2L210
ZDUgMCA2MjkxNDU2IHFzcGlfcmVhZCANCnNoYTFzdW0gcXNwaV90ZXN0IHFzcGlfcmVhZCANCg0K
VGhlIHR3byBTSEEtMSBzdW1zIG11c3QgYmUgdGhlIHNhbWUgdG8gcGFzcyB0aGlzIHRlc3QuIA0K
DQpIZXJlJ3MgYW4gZXhhbXBsZSBvbiBob3cgdG8gZHVtcHMgdGhlIHN5c2ZzIGVudHJpZXM6DQp6
eW5xPiBjYXQgL3N5cy9idXMvc3BpL2RldmljZXMvc3BpMC4wL3NwaS1ub3IvcGFydG5hbWUNCnMy
NWhsMDJndA0KenlucT4gY2F0IC9zeXMvYnVzL3NwaS9kZXZpY2VzL3NwaTAuMC9zcGktbm9yL2pl
ZGVjX2lkDQozNDJhMWMwZjAwOTANCnp5bnE+IGNhdCAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkw
LjAvc3BpLW5vci9tYW51ZmFjdHVyZXINCnNwYW5zaW9uDQp6eW5xPiB4eGQgLXAgL3N5cy9idXMv
c3BpL2RldmljZXMvc3BpMC4wL3NwaS1ub3Ivc2ZkcA0KNTM0NjQ0NTAwODAxMDRmZjAwMDgwMTE0
MDAwMTAwZmY4NDAwMDEwMjUwMDEwMGZmODEwMDAxMThlMDAxDQowMGZmODcwMDAxMWM1ODAxMDBm
Zjg4MDAwMTA2YzgwMTAwZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmYNCmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZg0KZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmDQpmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmYN
CmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZg0KZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmDQpmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmYNCmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZTcyMGZhZmZm
ZmZmZmY3ZjQ4ZWIwODZiMDBmZg0KODhiYmZlZmZmZmZmZmZmZjAwZmZmZmZmNDhlYjBjMjAwMGZm
MDBmZjEyZDgyM2ZhZmY4YjgyZTdmZmVjDQplYzAzMWM2MDhhODU3YTc1Zjc2NjgwNWM4Y2Q2ZGRm
ZmY5MzhjMGExMDAwMDAwMDAwMDAwYmMwMDAwMDANCjAwMDBmN2Y1ZmZmZjdiOTIwZmZlMjFmZmZm
ZGMwMDAwODAwMDAwMDAwMDAwYzBmZmMzZmJjOGZmZTNmYg0KMDA2NTAwOTAwNjY1MDBiMTAwNjUw
MDk2MDA2NTAwOTU3MTY1MDNkMDcxNjUwM2QwMDAwMDAwMDBiMDJlDQowMDAwODhhNDg5YWE3MTY1
MDM5NjcxNjUwMzk2MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDANCjAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDcxNjUwNWQ1NzE2NQ0KMDVkNTAw
MDBhMDE1MDAwMDgwMDgwMDAwMDAwODAwMDA4MDEwMDAwMDAwMTAwMDAwODAxODAwMDAwMDE4DQpm
YzY1ZmYwODA0MDA4MDAwZmM2NWZmMDQwMjAwODAwMGZjNjVmZjA4MDQwMDgwMDhmZDY1ZmYwNDAy
MDANCjgwMDhmZTAyMDJmZmYxZmYwMTAwZjhmZjAxMDBmOGZmZmIwZmZlMDkwMmZmZjhmZmZiMGZm
OGZmMDEwMA0KZjFmZjAxMDBmZTAxMDRmZmYxZmYwMTAwZjhmZjAxMDBmOGZmZjcwZmY4ZmYwMTAw
ZjFmZjAxMDBmZjBhDQowMGZmZjhmZmZmMGYNCnp5bnE+IG1kNXN1bSAvc3lzL2J1cy9zcGkvZGV2
aWNlcy9zcGkwLjAvc3BpLW5vci9zZmRwDQo4NmFlZjI1NGJjZmRmNzYzYmRiOTJlNGMzMTY2NzI0
MiAgL3N5cy9idXMvc3BpL2RldmljZXMvc3BpMC4wL3NwaS1ub3Ivc2ZkcA0KDQpUaGFua3MhDQoN
Cg0KLS0gDQpDaGVlcnMsDQp0YQ0K
