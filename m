Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6939C5B1D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiIHMcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiIHMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:32:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50B11C15E;
        Thu,  8 Sep 2022 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662640328; x=1694176328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ytTDIxP40pCZjiEBBGvUDB5Rzv6N4GGgzFrFli5m7Y4=;
  b=t93eBN9FPbddasAKCC9/SRd5CjxjkfuMJPQ23Fzmu9k5IKvTAGsfHyBe
   kAaQS9mjN5JPG4VIdnA8AFXVFbcBY8IuXI5VivK6+sYAD+g4wciWeAqkD
   hsine+GCFqrzzGL+J6zPYM91cI7ffWK7nOmPglIZWJ4gp7PIT19yRDWLg
   lBW7Gifi86NSCXEgQFf/QW9FeQ4qLYE9VOoyO/OKDXJatiAP2LXM30uOR
   VSOtloKLTY0Z/WfBoMo5uczPJkcjGJlog1vweJBzWBppv+p5EZHv9AXMp
   VxOp4LdGWGw8hG74VfUjm3DhrTuzfqimmaZRn+OMz0YvRteoRTZ0rPvgc
   g==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="189959122"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 05:32:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 05:32:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 05:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCaVbVwV2GFyM7V74Vfx7u8Xi7WJe3VOcHCwcDH+zXm6wLtT7i+zyn6gFuGiyLar9thtenq4MbcD9oDYs/fCH+EPllifw5aanNyqmRPq2Dpt/wvHgjMIe/VT7fIAOkGNgPyiQWDqpiduVwsvKkwBFVXLKmHezWW5sRqlPaILSoJivTUY78xJSTAt43CtpjPK0W0wFKuQQcKdMxOssw4wHV8S+aQ1TyzlD8Qki19fxopHW07kwPHs2JEo1Ty9p6vNqHIm4o5iPsDVFayI0Eqi7LJfuleIGGOKtpvTDIl58PtxS7i0e3dWb3AKZREQFM+7E/Sdhl2eKU2vXB7bJP+QFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytTDIxP40pCZjiEBBGvUDB5Rzv6N4GGgzFrFli5m7Y4=;
 b=of51W4Huj7T2B9vZInNXyDRT79KBQ4KYBlXHdGGtVtFIrHwGcXpxnRewtmwP3w1jY4DcKfJkWW9yZKAt8ozmzqU+Ee6ClXwotIcNC8CosPX8W6U0PXBFfYoEu7WJnCfPzUxkqt7DjuEVOVvZztAMAppKIVWfQZ8legoH9nbefsHno8iWX1am1MPmPMeI/MgSJE/WOjymJ97nOv5cr3LVgnpyuBFIBHAhqggBtynkDvBzN3E4K1gZHrEvfit+3i7wDMXOPIyXNP+3yXWnrxwORAxpOq31Gq5LktQu/LE0wlV8/hZwtzysKdZUE1CLQR+NzNtXMNQQ4DH+9ngffNLU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytTDIxP40pCZjiEBBGvUDB5Rzv6N4GGgzFrFli5m7Y4=;
 b=gyljb8wgwthyw8498fg9ssVAjIYLhTzozsbzhLYRZTHWFMF2OhbTHSlQbpGfXu6eJbINvYwsslHI/3qYp3AkPVrZezoVdPVRvhH0Y9b+qx9t1ZBfzpZJ5SK+UJY6sUTphebJl+JPtaxT6p7kgANN0h+R1WCkTseFDGaJmyf0Or0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3656.namprd11.prod.outlook.com (2603:10b6:a03:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 12:32:03 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 12:32:03 +0000
From:   <Conor.Dooley@microchip.com>
To:     <wangjianli@cdjrlc.com>, <oliver@neukum.org>, <aliakc@web.de>,
        <lenehan@twibble.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <dc395x@twibble.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/scsi: fix repeated words in comments
Thread-Topic: [PATCH] drivers/scsi: fix repeated words in comments
Thread-Index: AQHYw34rhgJ7NJLpDU6QNGpnVJatnq3Vdu2A
Date:   Thu, 8 Sep 2022 12:32:03 +0000
Message-ID: <2d715e75-f145-4ba2-a951-912eedc317d0@microchip.com>
References: <20220908122418.11728-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220908122418.11728-1-wangjianli@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|BYAPR11MB3656:EE_
x-ms-office365-filtering-correlation-id: 0a9f0901-2575-4f2a-b629-08da91962256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKsiApcpvoGbMlWLBPxTEqMVNF0Ui2lv40yifT4IiCAdYDyWuukQ0AJC5RTsgpXmrL65hAKAsKysCnsgthVdN42X04s7mHxTsQ9QDIJx0nwM2r2i4/Loz2V5vDIGtx5kkksx6ehYuXVdEJwNZG6jYhpZS3CHImtbMuSKhwwlRnoL/5D3hukU3ZSn+7kSNKshLvm6NINBWAbGkCAcsOhGOE0hHVllr3BDnzumA1OJfyIjuq30kq12SGeeCU5rlZ641K+qBYaVmZiiGfL2VWZuUHCmUyTd4QZE3OdCTwxahrIeMPYOYkWDMgTGBgc4W6P2MVZad2pfSgcV6i7UL7pjoCdywOxGkoKgB41wBw9xrYKtI+I4idq0m3gPw9P3oyiTHD9E+nLCkDLKDHwMmt0/arD9X5Hm0UDleVHc/hSjpuPlp651ajO1yo3gOvYjsoIo0+LXuiXv+blRdaARJjMLLiQcCBuZbITrZiT36MTZgYCZARSs5/cy+o85jPHojYq3z9kmRIuIkvvc/UbGyo/Go2SErZNjj9SCNDJ3r39Bb/qHFfpY7kJy6sfOo4hylaSAdqXtlah8A9f4kh7ijRGiOGaf89TUGVJT4N12FHQmNR+KHAPdEqNyEr6U3x4P/tQlT5sdaX0stjEQnxzNhzlCbVr/JJzxotr/cdDdM5SmDWLMN6h84gtZ5XkUJ0Y/jNSXx7jMrMD/nM3Sg+CkIPLsfP73gP4YPjy8zjERNvNXlk5Fd5aKd9yKOMFkb3kOVwVbDfIFzxgxIwlZIbENfqyqtZhJtjmc2PrUG/DhQr6AN4uKM7s4/MHOHWtXxwp+q81pbs02tcqUCJlC8vrpO1CCfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(186003)(122000001)(478600001)(38100700002)(53546011)(2616005)(6506007)(83380400001)(26005)(71200400001)(6512007)(66476007)(41300700001)(76116006)(5660300002)(8936002)(66446008)(66946007)(86362001)(91956017)(2906002)(66556008)(31686004)(6486002)(64756008)(8676002)(36756003)(4326008)(31696002)(38070700005)(54906003)(316002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1F4NTUvUW9BQzlRdnViV1NDdWtFek4vWnVaQ0ttWWVLLzBoUkZydWxsU0Ra?=
 =?utf-8?B?YmdkYU1ZdTZ2dkpKV3RKYnFCZDlJd0ZTZ3ZndUpwTkdKQllJUWYxQTZ0a0dm?=
 =?utf-8?B?Y3c5VEVrNDZINVNHUlk1M2ZJY29obnlNY0ZLQlMwbDE0TVpjMVdUK1hSS29r?=
 =?utf-8?B?R3cxdHY3ekZmTHR3bXV2THdUSThmMFp2M2IvWCtGVHA3VjVVdHNnd0VVVG1B?=
 =?utf-8?B?cElOQnhoZXJtWXNBQ0EralltbHdGaGt6bndkQ2I2WktobVBPVll0dHUyL2R5?=
 =?utf-8?B?ZWJBWXA1WGJld1FGbnJmdGxKT3lUQk9JQ0ZSb2RNRUZ5ak10YlBKVEdIalRs?=
 =?utf-8?B?akpyNml0NnVTNkxYY0FieEg3a3UrTTVrTTcvV0o3cEIrSFFrWHR1aSt2c084?=
 =?utf-8?B?VGJxSTZ6aGJOcDcvdkl4YmZ4L25nRjFlK1dzSmN3Z3lxWVdodzJzQXgrRWxY?=
 =?utf-8?B?OHFtaXYzcVUrRnBGSU1XNHA0MGhGT21tVE1TYlZVNnYraG1MbTBpRzVzYzBU?=
 =?utf-8?B?aWpzcjhHcWtoVHJtY1BadzRBbllDdUNqWWFhWGFLZXFhektWMVpLNm41RzJL?=
 =?utf-8?B?UnZmYlFLb1lLWkFDUU41TnJuVDc4THlwMGZ0QVdHRy9MMjNXWVNaend4SHR5?=
 =?utf-8?B?ai93OVZscXAwaWVpbFA2emc3aklZZW5hR2tDblpORXhaSG4xUjV0YVJsMkV2?=
 =?utf-8?B?V0NJcGREYWVLVFl1NEh3cE56ZDlpOWhIdURqTzd6cDRMYjh2OXRMYnRBZ0dw?=
 =?utf-8?B?Nm5qTXNuc1NXN3p1T2RTNWJIRWdjUlBndjdEeGtOWDNESmszWmxncVI3NnE1?=
 =?utf-8?B?YlJtWXdzK1VPcHAyTStCTHdvT3hIWWUwdWtYWEk2YmxkWHRaL0pRcHRUbVFB?=
 =?utf-8?B?S1B2ODRPL2NDVUFFUGQ1ci9rR1NTUTVGZzZ1cnovU09QSmNjRHcvRFQyREVp?=
 =?utf-8?B?VERuT3JQZXdpdGtqT0lUbm5BZXVGMk5lVW1KRG9rUHVDdEM5dHFXYVpMZi94?=
 =?utf-8?B?TzRla1M0NGxwZzBiSlBCY242Sk1PWGpvUUhVU2lCNFlzTjM2UmU3R1lvMU82?=
 =?utf-8?B?bEtlTFBDNWY2T3lyOFVpd3ZxYmJHdEdCLzc3ejhkWWJXMWRudkJyTEtRbEZz?=
 =?utf-8?B?SFNFMi9HQTlZZG9GcSttMityVlovVEh6U09VT3paVmpXMzI4VmdnZzZrb3Bi?=
 =?utf-8?B?WmgwemlZZThYakZMUURvVWNiS2lYMDMrWWpEeWxEaXdEa2hlcXBwWG1RU29V?=
 =?utf-8?B?YVVUd0dJVEd4N1VBUEQ2b0RVenVOb0k2SDl5TFhiL3NveHVESXM0NW5RZlVo?=
 =?utf-8?B?V3pYbzlnTi9HUmlzWUtHVWZRZWErUVh4OHlsZlBmSXVrZ0N4cUMwSkhLZmlL?=
 =?utf-8?B?VCtTN212QnlZUzFNdngyTXNYM3k1djJ4YzNxai8wRHNZcDFJL1c4LzZ6QmRQ?=
 =?utf-8?B?U2ZvbGxJWkIxVHl6ZXBRRkxPRkZZVFNGbjJrY1JxcnQ4YW0zb3krR28wVU9X?=
 =?utf-8?B?bFJ5ZFl5dkpTRE1YMXdTaFJkakNjNGt4clNydG9BelJRWXRmVzNFaFJsSlJk?=
 =?utf-8?B?UUxBUlFxUTZOazNPSXNVSHE4YnV4OGRUdy8vWU9CK0ZHUEQ2c1VFMWZ4aTJY?=
 =?utf-8?B?NHFFSTE5Y1l3cnhSejcrUFQ0UlZxUWNtVlV2NEJkSDJxT1ZyaHFoakc2V0Jv?=
 =?utf-8?B?eUtVaWJTR2hCTUpOa3VaWURZQkwzeWZVUzlkTVcvaGEwdkN5N3kvcnVBcFE5?=
 =?utf-8?B?aGJjOEE4bkpUT0ZEalE1b0Q3QmhvS1QxUUxxY0pGZTRGT24zRlZ5Q1l3OFRG?=
 =?utf-8?B?bXNldHEvYmwzSkNha3l3aHFuRGtidzB3b3lXMW9CeHcyT3paTUZwYlNhS1NZ?=
 =?utf-8?B?R0hvUFM5Nk0yMWV2aGtyb2lnVWwvd1J3Q0s3Mk1UYmJVM0Y3OUZzWWlhVzl1?=
 =?utf-8?B?ejJkSjFqek9wZGVyYk15WFN0a2tsYWZXdldvWTJobHdoS2hLZnVZUG1QMjQy?=
 =?utf-8?B?cUhrUHpoVXBrY2gvV0tyendtdUczbTc3MXhXUlVxRU85SXZmekYxMms3a2VR?=
 =?utf-8?B?Y2JBcmpjVGZsZTFSVm80N05tbUNPblQ1UTR2RmF0Q1djZ216UG56Y0ZyTEc2?=
 =?utf-8?Q?dpmrlIh3rR4ecNK9yqP2NIz80?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8100939CB77DD54E9A85711AAC416B89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9f0901-2575-4f2a-b629-08da91962256
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 12:32:03.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMiRobT3IzatNFKcBog65xjr3pyEv2m/t+dftfLAMfrPq/eB2DM+rQw1GRxE+0yWryuINI1hAcKBmMOFKvPdcOkPfzeHS3It2mTM/93c98A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3656
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAxMzoyNCwgd2FuZ2ppYW5saSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEZWxldGUgdGhlIHJlZHVuZGFudCB3b3JkICdpbicu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB3YW5namlhbmxpIDx3YW5namlhbmxpQGNkanJsYy5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvc2NzaS9kYzM5NXguYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvZGMzOTV4LmMgYi9kcml2ZXJzL3Njc2kvZGMzOTV4LmMNCj4gaW5kZXggNjcw
YTgzNmE2YmExLi5hZWE4MjAwN2RkNjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS9kYzM5
NXguYw0KPiArKysgYi9kcml2ZXJzL3Njc2kvZGMzOTV4LmMNCj4gQEAgLTQyMjYsNyArNDIyNiw3
IEBAIHN0YXRpYyB2b2lkIGFkYXB0ZXJfaW5pdF9wYXJhbXMoc3RydWN0IEFkYXB0ZXJDdGxCbGsg
KmFjYikNCj4gICAgKiB2YWx1ZXMgdGhhdCB3ZSBoYXZlIGFscmVhZHkgc3RvcmVkIGluIHRoZSBh
ZGFwdGVyIGluc3RhbmNlLiBUaGVyZSdzDQo+ICAgICogc29tZSBtZW50aW9uIHRoYXQgYSBsb3Qg
b2YgdGhlc2UgYXJlIGRlcHJlY2F0ZWQsIHNvIHdlIHdvbid0IHVzZQ0KPiAgICAqIHRoZW0gKHdl
J2xsIHVzZSB0aGUgb25lcyBpbiB0aGUgYWRhcHRlciBpbnN0YW5jZSkgYnV0IHdlJ2xsIGZpbGwN
Cj4gLSAqIHRoZW0gaW4gaW4gY2FzZSBzb21ldGhpbmcgZWxzZSBuZWVkcyB0aGVtLg0KPiArICog
dGhlbSBpbiBjYXNlIHNvbWV0aGluZyBlbHNlIG5lZWRzIHRoZW0uDQoNCkhleSB3YW5namlhbmxp
LA0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KDQpUaGlzIGlzIG5vdCBhIHR5cG8sIGlzIGl0PyBX
aXRoIHlvdXIgImZpeCIsIGl0IGRvZXMgbm90IG1ha2Ugc2Vuc2UNCmFueW1vcmUuIElmIHlvdSBh
cmUgcnVubmluZyBhIHRvb2wsIHlvdSBzaG91bGQgcHJvYmFibHkgdmFsaWRhdGUNCnRoZSBvdXRw
dXRzIGJlZm9yZSBzZW5kaW5nIHBhdGNoZXMuDQpUaGFua3MsDQpDb25vci4NCg0KPiAgICAqDQo+
ICAgICogVGhlIGVlcHJvbSBzdHJ1Y3R1cmUsIGlycSBhbmQgaW8gcG9ydHMgaW4gdGhlIGFkYXB0
ZXIgbmVlZCB0byBoYXZlDQo+ICAgICogYmVlbiBzZXQgYmVmb3JlIGNhbGxpbmcgdGhpcyBmdW5j
dGlvbi4NCj4gLS0NCj4gMi4zNi4xDQo+IA0KDQo=
