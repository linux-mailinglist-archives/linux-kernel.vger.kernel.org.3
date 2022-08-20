Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4559AF2D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbiHTR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbiHTR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:29:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C082317E36;
        Sat, 20 Aug 2022 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661016563; x=1692552563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qP7jq/67rc7T9cdP/AuZ7gdw5keN0vOM9VJ9QwIbGNs=;
  b=eeIZDOQIyaufCGuPyOo842ZWOLES6jW1fZZ1ZFw01eIGziaTOzsy/ICs
   4b+OMwzm/ZRTxOBvMOUAS9o0Dr5rdqeRI0StyvexALlymadtkqH9BMPPl
   fhIFzv1Q8Ad8jdHgo5cnynltxtUAqG0Z+iCTKYsbnjbw4OzU3y1hstoh0
   Qa+TuADAoqC6iM1Eo9jJ3Y7HIZqzKgc6eqB6xPxwNNj5oSC5S+qzVHLal
   QyKMXLD/iDxFhArb4NEQmimwWoxvWgReURKaPXtdp6cgrK6ChZdkEfd90
   Fn6hebAecN5ax0dK/GeCl2YCyvF0TmXz6jugfGTwg3Bny6jqmRLXGsnxo
   w==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="187345239"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 10:29:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 10:29:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sat, 20 Aug 2022 10:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3tOmWg5PJbEHJsob8E/oSGgRSqvZZT15L5uPSXl79BhknShScLi4wXrBva5Kj3AhQ9ZTn/2VqzpYW6RNmDJiow1/JVxxPmqV7wfiCPolDWCZLoDrGindO31oDE4NvdtQtq77xZRuyinw0POuI0uw8vjtxKGooPJFBzcPKqsH1dx4U3+QqmfLwFM5SpZI2sQgWqeyVzjVocLVkWYDXyqdbqRCMSlM95j166nDT870UXunJcV7fdI+RHu5IEHQyVT/0t0FtsG9LYOk5jfXZUjQTBTmCKpLqKZYiF9RewPPJ014TWRYOztXGRhtdKMEZe/03N1AyWcMQBC7UGHZDS+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP7jq/67rc7T9cdP/AuZ7gdw5keN0vOM9VJ9QwIbGNs=;
 b=nyOJLEJX191RVLXAUSYoQxnEeaf+Kv+wzp/fVPu3hIREETSsh7IhfX11pNuxGd5iE3AUT38vgrFXwnt5/z8LTdcEXDvqaz7b4Yu4iDAw64gt6xBuot9Z31+jrkgn+npmXD2pMIY5oc1t+v5bRewIHamPCoy5b0uPtUySA5FvmpqMaGmSNsSFAoyzMXo71ymd1iDQmRn+nf1Vc1ioZGNYYG4Yc994EsQxt3rTsXGp03abQOc+/0kWNqvkjSi8XFC+y5ggZ2iMiQYZcYkcqWSN7Qwadb6taFzXQwgghKPGGcs/SqEIKysrPaAEYWifQd6vycz8TsWeybuL0xWxoh/HTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP7jq/67rc7T9cdP/AuZ7gdw5keN0vOM9VJ9QwIbGNs=;
 b=cpXpOE6+Nkbsxu9Sz99g9B1gpwFREQJIZlpRfTIyS/EmL1OqKdAnAcOiAAgdJWKkvSfyPoQMii3DqLIBjhQYy9FOzz8mtnYK9UulcCFdIIjaHy7CVbBflTmfMljpHO17mSxeU4wGmCd6Dy1oc20rKNeZCV88yAaHQPKj4eOfaJw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB0035.namprd11.prod.outlook.com (2603:10b6:405:62::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Sat, 20 Aug
 2022 17:29:19 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Sat, 20 Aug 2022
 17:29:19 +0000
From:   <Conor.Dooley@microchip.com>
To:     <samuel@sholland.org>, <Conor.Dooley@microchip.com>,
        <andre.przywara@arm.com>
CC:     <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Thread-Topic: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Thread-Index: AQHYsGUwgMumzpPtekanQb2zMhKHQ62v8GmAgABAKYCAB+IqgIAAATuA
Date:   Sat, 20 Aug 2022 17:29:19 +0000
Message-ID: <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com>
 <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
In-Reply-To: <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c4cb57b-a45d-4854-a261-08da82d183c6
x-ms-traffictypediagnostic: BN6PR11MB0035:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsoDuihIJdEIbW3uQ4BG78DL3UctlDdaTIRrKqQJQp+DrmUss779euIXGhdXIIhJICCgjZFYOMZo6Xe/jDYd6aZRHp0KdQFFLoWlG/uWD5hG2GIU5LKB6oNJiLleN8lzdDYTx00T+274K64dlxWh5csZgFQ7YXh5ZIdGFlVL/cAKLDhxjDA8zRMU00LCRM3Do4AVkS+T09fVIUQCsdFuHZYbASctcb0L1TZUVcPqKE9MVD8eQSUsa66vy79jEwuzbkZhHPjovyjkd7/LcxC9ptOQNj1rvXOp4r50VuGmnTDI8HWnaTOvqdzLjiv7Pr0ukVdg6hbop9WoDF5IV7yJKcqf1h6FA1hctMrIFctg9SoofhInCsJ8P53P0SKDWN7Ya8+2VNgEswVKY9ZDgJv5T5vUAnNHBVlwMzOmsR1DEbBCOpZED/PqZ6X7cfnXIVYhpu07kZH4o2aRX+mYxZV+Hn+CyuQ11JnDWSW1LKeDUWdItYjCbU3YL2paZTtntrC9yYOgGvDoLzTFdS6ACi167uK0CKWFofv+8f5bmSv8XHydiiTiXbVsLyEVZcD+IiWiYLiEGw3dVec7lXvbAnl9K5DSFKjkQbSO2Gf/7lZI1XxSet2VzRfvPSdT+OQ/mK8JBtjEh1pZDaelub4c0wZd2elLUTo0Ux1jJQmGfwXtisv2XsKJWvNkVoLLZbLfae5zSZ5QpiEIa3k3VAQMFyiVaPMp3NyX+tyw0rB2Lb7uG58EtJdvYf/qHWeJwDzkogR2TMhklZ5nH0pVc5ppIe6W8p6HbMeX2MIIzuN85iJ1ELLF7hZ2Sl/L1OioYvr8mAtfgeGoh1X8Flx2cmrjBZumrcEpTjPSG40YCS5whzJYKmI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39850400004)(396003)(136003)(366004)(376002)(86362001)(31686004)(36756003)(2906002)(41300700001)(478600001)(76116006)(66476007)(66946007)(66446008)(4326008)(66556008)(8676002)(64756008)(91956017)(966005)(31696002)(71200400001)(6486002)(7416002)(54906003)(26005)(110136005)(53546011)(6512007)(6506007)(316002)(38070700005)(38100700002)(2616005)(186003)(8936002)(83380400001)(5660300002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzNLMFIxeXVldnhONHgyNFQvZm9NQzhYN3JVd045S2NlS29vS1p0ck15cUt3?=
 =?utf-8?B?eHFPMXRhK01SVFg5UXJucmh4ZkY3QTg5ZHg2cUJnLzIrRDZrSnhoMHBibFFh?=
 =?utf-8?B?ZFBsTDdJSytNenFGV2dOTFIycjBSU2gwdjBLTXpWUk56SUwxRTk1c1NkaFZR?=
 =?utf-8?B?LzRtTWNHY1gvUmVMSEZaU0Q4YWNrRDlXUDBJN0E0dmZOU0tDdXM0blVMVEUw?=
 =?utf-8?B?WUFWemlPMHM3OFhGOWtsZWdpOWZXa2FyTGlZbU1mSWlhNis2SWlVQVBiZEJy?=
 =?utf-8?B?TUl2UnVaVTZueC9DbWdvU0pEYjc3ZUFObXMrWjljWUd6aDBwMFRYNUlwSXpk?=
 =?utf-8?B?WDF2UGY1MVRQUzJoV0oza3hxR1FDRlI2N3R3dEttaVZLRWw5Q0FOdm5hMTNG?=
 =?utf-8?B?K0d4OWs3WGpzZTZiTTZsZnY2WkJxYnlsZjhSWHlNYWdTeWZVV0VrRmlKUjBI?=
 =?utf-8?B?SFVVUGIxV2EvVFAvUVUySUE1KzJaeGw1VTQyNkY3SGRsanpWNm43Rmo5djJp?=
 =?utf-8?B?RHJaNTFKRStQWTlzZDdxVG1veTFTS1BJZzVrMVFrbUhFeFRuWi9uaGczcDg3?=
 =?utf-8?B?cUxOVUVlbkE3cmtMOWFOalFVYlpINDU1WnBqeGxMM1hYOU1jUDRjSys1d0ov?=
 =?utf-8?B?V3p2ZVpZRjF1cUxMQ3djeXRQSzR1dWlXQVNpbUwwMkFnVzB3ZFE1M3FXSU12?=
 =?utf-8?B?WjNMWW9FbEdnVUkvT0xQeW5UTmRUZjZZdmdXcHg2akxRVXNJWFZ3YUowMDgy?=
 =?utf-8?B?dCt0V2dCbTErNkEzS09kcnFkVzloMHhnWktXSjlGZ0orQ2ppQUNTWUhUVng4?=
 =?utf-8?B?eHYvUWg5ZlBCWUM3bGp0SnNRT3QzWHZVU3VaelFWZmNaUWlGbkNZRVNWeVBI?=
 =?utf-8?B?dDhYWmdsRFZET3Z3MTNGMldmZklsY1d1ZC94aVh1OXpWaFd5RjhSR0dRK0Zt?=
 =?utf-8?B?Y2U5TUxrSWZ4dVBNTXFzdkJwR0cyNENxZU5yYU5lTlZlZTY5REZRY0N4ZFJn?=
 =?utf-8?B?YlI2VmV4T1hGSXhFVVRlb2wvZGZrSlBwVHhzSjdnUFpkM2szNFUrL1lqR0xL?=
 =?utf-8?B?WjJZSCszN1NpRGNYUkxWclZBOVQxd0NuZHl4SUVaVTUvWWFRejFxMTkyc0Vv?=
 =?utf-8?B?K2ZmVzhUOEs2NCs0U3NXdjd5YzZaWEhrelJnTW5NUDZxUTB0czYxSldYajhR?=
 =?utf-8?B?K3BFNHB0cE1FSmRCVVNGc2w0ODVZS2VuRXBSUTZCOVdKVGYrVEtXNDJUTTJz?=
 =?utf-8?B?clI0WmxvMFJvdUEwMW1XQmtwdktiT2xUN2hoVWdqVnA5QzAyRG5FREtOM1NM?=
 =?utf-8?B?N1FQdlZrZUFidzFVTXV4OEpTR0VUYWpzQWNRdHoxd3RLTzU0UU9VR0dzZHRQ?=
 =?utf-8?B?VnJldHRmUnNzZEtrL05xOFlOY3VSU2tpWm85SUIyYVlOZkRQNENzdXZ3YVJK?=
 =?utf-8?B?Z2VSRHdqcWRkQ1FwRmYrSjVtNk1XY002UlhoWUxXbzlOR0JKam5GNWdva2xp?=
 =?utf-8?B?OWlEd3YzSk9ZSDh2U1p0YTdkTzNaUEIvZHl2Vm1VdzFNcUJwRXFmdUtqRXNV?=
 =?utf-8?B?ckgzeTFEdU1yNy9rVWJpV3B5V3oyZFE4UXNrSDBiUS9XbFlQb2pkZWc4UjBk?=
 =?utf-8?B?Vy9qUVhJMUtZWXA4N1JITnVISXltSVEzSWtiTG90czVRQUhQSkJrQ01hR0dp?=
 =?utf-8?B?WVltVWx2TVJXRlBRVjJaaHVkTldSYUdDTkQ2KzJJZWZEL1Y3em9qWElMcEJM?=
 =?utf-8?B?NGxhS0tLRFBQVmJjNVo5amJsN2NWejZscHFSYlFrbFhOVmxwUmw1Q0NVNjN0?=
 =?utf-8?B?T0ZHVXhjR1I1MTJORmMzSEJYSHduVXQwM01UWmY2VHhqaVAwSldoMkxBWFQ4?=
 =?utf-8?B?L3E5YjBWNk1MZzlTMzloQmhOeXY0dmNQRTV6ZUZ5YW9kSzUvTUlzRTZKa2Zx?=
 =?utf-8?B?ejBBTDgyN041c212NTRGYzVkSEF6a2VwWnpCR0RxZ2dkc2l2NlozdEdLcEZx?=
 =?utf-8?B?QVlEd25qTHZFTXFNQWtScmMyQmJkZlgwQ0RXK0tEenZBcXJ0dFpJVU1ETG1q?=
 =?utf-8?B?VVI5RTM0WGZKT3NmYnBydU5pNWpqTFpOSEVzbTYxMmJJVmZlZkFjTFBwNnd6?=
 =?utf-8?Q?CrBmPkPhOLP0yFGObIU1mc23Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FF66E7B49D698429D5D6BE8D8445063@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4cb57b-a45d-4854-a261-08da82d183c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 17:29:19.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl0yH+zggfxf5uGbkXIRhOJvkhTflHdlGs2EVim/3w+S+EoBM+ChnAgFyX5adKcZ1xPqhLGZdhT6cPHbBL/88rmW+7pJUvAZZVRdDmx86AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0035
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDgvMjAyMiAxODoyNCwgU2FtdWVsIEhvbGxhbmQgd3JvdGU6DQo+IE9uIDgvMTUvMjIg
MTI6MDEgUE0sIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTUvMDgv
MjAyMiAxNDoxMSwgQW5kcmUgUHJ6eXdhcmEgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiBNb24sIDE1IEF1ZyAyMDIyIDAwOjA4OjA5IC0w
NTAwDQo+Pj4gU2FtdWVsIEhvbGxhbmQgPHNhbXVlbEBzaG9sbGFuZC5vcmc+IHdyb3RlOg0KPj4+
DQo+Pj4gSGksDQo+Pj4NCj4+PiB0aGFua3MgZm9yIGFsbCB0aGUgZWZmb3J0cyBpbiBnZXR0aW5n
IHRob3NlIFNvQyBwZXJpcGhlcmFscyBzdXBwb3J0ZWQhDQo+Pj4NCj4+Pj4gRDEgaXMgYSBTb0Mg
Y29udGFpbmluZyBhIHNpbmdsZS1jb3JlIFQtSEVBRCBYdWFudGllIEM5MDYgQ1BVLCBhcyB3ZWxs
IGFzDQo+Pj4+IG9uZSBIaUZpIDQgRFNQLiBUaGUgU29DIGlzIGJhc2VkIG9uIGEgZGVzaWduIHRo
YXQgYWRkaXRpb25hbGx5IGNvbnRhaW5lZA0KPj4+PiBhIHBhaXIgb2YgQ29ydGV4IEE3J3MuIEZv
ciB0aGF0IHJlYXNvbiwgc29tZSBwZXJpcGhlcmFscyBhcmUgZHVwbGljYXRlZC4NCj4+Pg0KPj4+
IFNvIGJlY2F1c2Ugb2YgdGhpcywgdGhlIEFsbHdpbm5lciBSNTI4IGFuZCBUMTEzIFNvQ3Mgd291
bGQgc2hhcmUgYWxtb3N0DQo+Pj4gZXZlcnl0aGluZyBpbiB0aGlzIGZpbGUuIFdvdWxkIGl0IGJl
IHVzZWZ1bCB0byBhbHJlYWR5IHNwbGl0IHRoaXMgRFQgdXA/DQo+Pj4gVG8gaGF2ZSBhIGJhc2Ug
LmR0c2ksIGJhc2ljYWxseSB0aGlzIGZpbGUgd2l0aG91dCAvY3B1cyBhbmQgL3NvYy9wbGljLA0K
Pj4+IHRoZW4gaGF2ZSBhIFJJU0MtViBzcGVjaWZpYyBmaWxlIHdpdGgganVzdCB0aG9zZSwgaW5j
bHVkaW5nIHRoZSBiYXNlPw0KPj4+IFRoZXJlIGlzIHByZWNlZGVuY2UgZm9yIHRoaXMgYWNyb3Nz
LWFyY2goLWRpcmVjdG9yaWVzKSBzaGFyaW5nIHdpdGggdGhlDQo+Pj4gUmFzcGJlcnJ5IFBpIGFu
ZCBBbGx3aW5uZXIgSDMvSDUgU29Dcy4NCj4+DQo+PiBGb3IgdGhvc2UgcGxheWluZyBhbG9uZyBh
dCBob21lLCBvbmUgZXhhbXBsZSBpcyB0aGUgYXJtNjQgYmFuYW5hcGkgbTINCj4+IGR0cyB3aGlj
aCBsb29rcyBsaWtlOg0KPj4+IC9kdHMtdjEvOw0KPj4+ICNpbmNsdWRlICJzdW41MGktaDUuZHRz
aSINCj4+PiAjaW5jbHVkZSAic3VuNTBpLWg1LWNwdS1vcHAuZHRzaSINCj4+PiAjaW5jbHVkZSA8
YXJtL3N1bnhpLWJhbmFuYXBpLW0yLXBsdXMtdjEuMi5kdHNpPg0KPj4+DQo+Pj4gLyB7DQo+Pj4g
CW1vZGVsID0gIkJhbmFuYSBQaSBCUEktTTItUGx1cyB2MS4yIEg1IjsNCj4+PiAJY29tcGF0aWJs
ZSA9ICJiYW5hbmFwaSxicGktbTItcGx1cy12MS4yIiwgImFsbHdpbm5lcixzdW41MGktaDUiOw0K
Pj4+IH07DQo+Pg0KPj4gSSB0aGluayB0aGlzIGlzIGEgcHJldHR5IGdvb2QgaWRlYSwgYW5kIHB1
dHRpbmcgaW4gdGhlIG1vZHVsYXJpdHkgdXANCj4+IGZyb250IHNlZW1zIGxvZ2ljYWwgdG8gbWUs
IHNvIHdoZW4gdGhlIGFybSBvbmUgZG9lcyBldmVudHVhbGx5IGdldA0KPj4gYWRkZWQgaXQgY2Fu
IGJlIGRvbmUgYnkgb25seSB0b3VjaGluZyBhIHNpbmdsZSBhcmNoLg0KPiANCj4gVGhpcyBpcyBu
b3QgZmVhc2libGUsIGR1ZSB0byB0aGUgZGlmZmVyZW50ICNpbnRlcnJ1cHQtY2VsbHMuIFNlZQ0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi9DQU11SE1kWEhTTWNyVk9IK3Zj
cmRSUkYraTJUa01jRmlzR3hITUJQVUVhOG5UTUZwendAbWFpbC5nbWFpbC5jb20vDQo+IA0KPiBF
dmVuIGlmIHdlIHNoYXJlIHNvbWUgZmlsZSBhY3Jvc3MgYXJjaGl0ZWN0dXJlcywgeW91IHN0aWxs
IGhhdmUgdG8gdXBkYXRlIGZpbGVzDQo+IGluIGJvdGggcGxhY2VzIHRvIGdldCB0aGUgaW50ZXJy
dXB0cyBwcm9wZXJ0aWVzIGNvcnJlY3QuDQo+IA0KPiBJIGdldCB0aGUgZGVzaXJlIHRvIGRlZHVw
bGljYXRlIHRoaW5ncywgYnV0IHdlIGFscmVhZHkgZGVhbCB3aXRoIHVwZGF0aW5nIHRoZQ0KPiBz
YW1lL3NpbWlsYXIgbm9kZXMgYWNyb3NzIHNldmVyYWwgU29Dcywgc28gdGhhdCBpcyBub3RoaW5n
IG5ldy4gSSB0aGluayBpdCB3b3VsZA0KPiBiZSBtb3JlIGNvbmZ1c2luZy9jb21wbGljYXRlZCB0
byBoYXZlIGFsbCBvZiB0aGUgaW50ZXJydXB0cyBwcm9wZXJ0aWVzDQo+IG92ZXJyaWRkZW4gaW4g
YSBzZXBhcmF0ZSBmaWxlLg0KDQpZZWFoLCBzaG91bGQgbWF5YmUgaGF2ZSBjaXJjbGVkIGJhY2sg
YWZ0ZXIgdGhhdCBjb252ZXJzYXRpb24sIHdvdWxkIGhhdmUgYmVlbg0KbmljZSBidXQgaWYgdGhl
IERUQyBjYW4ndCBkbyBpdCBuaWNlbHkgdGhlbiB3L2UuDQo=
