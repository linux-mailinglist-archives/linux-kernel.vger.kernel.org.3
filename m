Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B151F4B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiEIGkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiEIGaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:30:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D6ABF53;
        Sun,  8 May 2022 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652077587; x=1683613587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OHE/evdLLZc+kFicdSw2ftpQDLeSxtNAJHp6gRQC9EM=;
  b=UCg9TWGXCXNIrzkiwozENBpjj5tD7e/dVR7sy6fYHChK5aZApzZgA+Yw
   s3XGhif9ayg5QZryeJ4AuQgYELS0kTYODNPjb6/ENGK1LigPfCxNfa+A9
   DnRxKk59kFHHXlFn9kZpXbwtKNTpzJBB6ykwLnS4xD38SipgtNcIiGq7I
   Hjk4vxqS7yTRV9HQz64HK+HDGXO+9oUhXJqdRD7hmzrE8rMB6KPNigd1q
   wZ0WZC0qq4v48WjwM5ji2Hum4Xtujsbp+E5Ux77F2HQmfrcs+9QwA/fGS
   etyjlHyBzX+CsjxRNaAEF7SwV6yrNb21GHJT2A42jWvhp7qOC/NjiKJZE
   g==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="158245914"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2022 23:26:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 8 May 2022 23:26:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 8 May 2022 23:26:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S66cTnY8VvS2+BFoqPbf3VTjl4CjDEJ/PGd33Yig3fAIU6t8Juekv2jerPBWyipXnvPuz7F4Hm1aCMJtuELFyJXgbEphhdaq5hYsmVzAviMaqYkcW9HHIc1ogZk0tpwlLbh6DtippMIW1sZMRMTL8IXU/NOrJM0yMHtsHTQ6cqkpD7krC2OwaZsMJIShjyro2NbmsLtIMHLGE+FmI6cHLyihc9AMuRBwCB3tYBS+95GFQq97yYh/f7GPT7GekeyKnADFzku2QOPyeC3qiFuQkXcMF7sH9Cf6H6uHFV9Y3J2sjRlaTyp+RbYHycRHsmIq0PRKVLEIHLIu2dJvazVaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHE/evdLLZc+kFicdSw2ftpQDLeSxtNAJHp6gRQC9EM=;
 b=Ra8K8ATYMotjS2gRpk3VLdL8l0b4qj1vG6OsffW2En39HBoVxk+4uH+SOYGry/lPgYL/ADXODu+rBgM9WtBdk67fOUNcde7h7EyYjjmztxvNaMz9VJNJU5vX03ObTSecLwHpoVRS7t8Wi0doIG+a/YE2oAtIgxBcenHytOa9z8KQM3/kI4H6h6yLiPCyfoG8niLkmcIUqJAF+HM476FW+3GGglGsDU7cH33q8pVXzLDwl984jT/01izjNEXBDSa/+2wY7xBM/sIpTO8TqwlbsdAT1dUsnVCvE4UXZMqVjhK3xEzdc3cbPFBfTwK6juy0/v/shHS2IraWRPhFb9eYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHE/evdLLZc+kFicdSw2ftpQDLeSxtNAJHp6gRQC9EM=;
 b=frH63enoYIBMEndlzIdIA1g228oNy4KWAlYtNmw3wG9swjIfofFD87GWoZEn31nnG67Kszyas7rMZpqJdCiib8iwlE3lDKMtQrq+KhNWt62PpH0i2otpDqC59qxQkrPPy0YGbopLdQAH6k+31wV/Ob0CcMXMb1wq0GhsHp42uX0=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by DM6PR11MB4121.namprd11.prod.outlook.com (2603:10b6:5:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 06:26:21 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 06:26:21 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>, <Tudor.Ambarus@microchip.com>,
        <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCH v4 09/13] ARM: dts: lan966x: add MIIM nodes
Thread-Topic: [PATCH v4 09/13] ARM: dts: lan966x: add MIIM nodes
Thread-Index: AQHYY22zGPZgBE3A8EO536zaym/YSQ==
Date:   Mon, 9 May 2022 06:26:21 +0000
Message-ID: <aa914afd-8f09-63aa-bcf7-708490a28551@microchip.com>
References: <20220502224127.2604333-1-michael@walle.cc>
 <20220502224127.2604333-10-michael@walle.cc>
In-Reply-To: <20220502224127.2604333-10-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a62547-2649-46f7-4493-08da3184d598
x-ms-traffictypediagnostic: DM6PR11MB4121:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4121FC5AD519AD85F77AE30687C69@DM6PR11MB4121.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r16EWmFq+Z4IyxlKiBgncQrKKKZ1Mzm4bsp4WW06r621D26/UdAJLe+nhVP60jG2+pIkcsh693Fb4ufFQr+vUeuQRp7kmyOW7BYS/Fo9zwIsS2ua384CA98zSJAPuFXUHfSO2AY7LEdX7VM+1InqTwPX8virQ1y9GEP5P45DjNWrxjE5wm2wRUYYRS9XFndEbYdpuHeS+GFNlWEsmFB5GX99+AgMZTCzvKqyRnqraP9/FSDkJDI/JVpWc4MyPOaXewO2mM+ZCehkMJJ3ti7e6nQRNYau5BAs/5rgFXN+nTaGCzfYp0bV/4CYihxUDxs2EUhnhBpJs0T+fluHDRjR+upD2JTOP2TypTcIQhqFrr3lDnE4P6XnseKj0vdnOdBuru+TEyUi9DIWx3uPHvQvGlO87Uey0BRQREzdDItzL8Zyi4pOOm8zfAi733yrE98Unk7DJfNaHNg9mN51Vrju+YbQ3gvOHZJaqfV3DhYVHkime6oW0LItT9OmraI2W8yvEM/m452Sw/ZIAioY/1e8auDC9Cnkib7noKlr3WsAGfm0EIHz9Ze6kFiXhKPUP8u/p8agJsSsB702oLx7puad1QJbpZZ/QsFxAwX31TLsXM0MiArxzHz7s+kvSE1oug4CaJiDS9XEoCSF1a5pDdB9QTNkBcUrHIPgNJbI6syUQaueZ1nih170U3mF2b32hzpXa4YM3Do3U3Omr5UNb2p5LIzeeWEot9Mejdp0VRelG828cPTKFiUKsl2PdRtiVwf/4rGuIGQGwz7uE53NtJrEmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(7416002)(36756003)(2616005)(107886003)(5660300002)(110136005)(4326008)(6506007)(186003)(53546011)(26005)(31686004)(66446008)(66476007)(6636002)(66946007)(76116006)(8676002)(54906003)(64756008)(2906002)(66556008)(91956017)(38070700005)(71200400001)(122000001)(8936002)(83380400001)(6486002)(38100700002)(31696002)(86362001)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L21mYUZwVWpDZXNPekhaZlo5cjYyS2VYRjFzNnFvUHBGc2srVW5pV1hRUzRU?=
 =?utf-8?B?OVAyU0tacENNU2VTbWd3NGVMamgvdmEvelZnNFhwbEYwVWFRbENWRm13UjR3?=
 =?utf-8?B?Wm1zaUloMEwrRVQ4V3hsNGQ0L1ZLTDkzK3UyVFh3bnVyWmdBSEd5bStWMXRy?=
 =?utf-8?B?eldqN1J5U2hud1ZqVzJ1RnRBRnI4WlBtaDBsN3RKc1NrcWhTTlRkbGU0Z2J6?=
 =?utf-8?B?ZGw0cks3UE9LaXF3OGphbFhLVzdvdTNlZWVnSlE1SEpyaGsvN21Yei93akVC?=
 =?utf-8?B?Uk84ejliVUduUVBlN3FDWHlBbmJ3cFFrTXBrNFhnbUZGVnBCdWo3MS9iV2Zz?=
 =?utf-8?B?eUFmOTF5TWxkcmtiTUJSeTRIRmhKWFhHWGVqd1EvRERuUWdDcE0xYm9sbU9O?=
 =?utf-8?B?UUNHR2xoY2VGdWk0VFMvSXVVRzNjczFMTkowYTJEL2JGczRHQ1Z0bUVReElm?=
 =?utf-8?B?dmdzT2tHeDgvS2VtTVBxRHBoNGd2d1lETzRSMjg3UVQrdkx3Y1U2TnRZdG5Y?=
 =?utf-8?B?QXBXVlQzS3NUL3drbU9qUW9laXo3MERPV1IyNEFURDdWZzE5NldoaSsvNWx6?=
 =?utf-8?B?S3JweWlOcmdhbDU4QVpBMS96eEtkSTVjZVpKZHd3dFJEWUhNTzhSNUpoZUpB?=
 =?utf-8?B?OUFISmNZeW9wSzQybFlLa2w5N3NFcy9KdmYwYjU2UUxlcHZmYU5xSVJJRVJC?=
 =?utf-8?B?WDFHSVEzYmpwM2gxRnNjSzZuY2lFL2svazV3WFVIbktncXN0b2lYSFR6NzZN?=
 =?utf-8?B?d1VBN0pJSVFqdFhLTnA4c1hLWWN1eWNhbzU5YVlCRG5hQnNkWnVBT05HWERE?=
 =?utf-8?B?dW90eHptUDc2VENyc3pzTjV2MVpraE50ekRzakJScVNjc1l2dXkwWG5RMlRm?=
 =?utf-8?B?bWRYaWNVZ2NBSmZPTC91TFFWRGcxcldHQ3c1K1RURGFKZnh1OWhraEJNc3Fi?=
 =?utf-8?B?aU5NaG9Fd3BQc1FpeWkxT1lPOGx5Vk9rZmtXdTJMRDUwOUl1MnpNT1F4OEVS?=
 =?utf-8?B?WGJBbUlzK09ST3pCZWRxTjFid0NGNER3S3JTWEVQeURFcnNMN3dUMkZTWVpJ?=
 =?utf-8?B?Z2t0OWtwbVNEQUNkV3ZqSkpZYzg3OENUSmo5WGFObjlhRVo2TkxlWVdqd3ZZ?=
 =?utf-8?B?aW1YamFYU200N0FlckRKSFlZVlY2NGdvaklRcFVLVm9kdmo4dkpXdnlpZXNI?=
 =?utf-8?B?MWMvVFR0RGhlUjBJK3NrL0NPSVVoZ1JlUFF3NGR2R0VZQlBCZmtVOFZVeVJL?=
 =?utf-8?B?b1VTN2o2Zm1XeXdTU3BTVmJNaVZobkZQaHE4WE1vVURlN3QxRVVXeHhDQzFW?=
 =?utf-8?B?RFV1M0k0V1VHZFpVaFlhOEF2eVU2OE0zVkpTQWlVRnF0bmJXa1prMGloTTdV?=
 =?utf-8?B?bW9MTi8xOFFJdDhnd3VSM3pSYUtEbDYxOERLR3pKL1Rhc0ZhTHVzRFFRQmNo?=
 =?utf-8?B?Tm50SjhKV1ZSZWp2N2JUYmtQWkhEWmtxckdvbXA5SHBqVlRNUWhBS2crT2ZQ?=
 =?utf-8?B?SzlKQjNaR1IxZzgrU0pTTXczOXNYdm1qK1NBc2tsTjRRZUJIVjJxdENkRERw?=
 =?utf-8?B?Mndjd1RDTEhhTVgzTm0rNmxaVVJIY0FHM3E5NzRzRGlnQVNHWWEwaU1Mamll?=
 =?utf-8?B?S2tNYmdDVTdRbXpLS1V2T2szVi82OTdGYWFBTUg5NTFRbm9KazJJYWZYNi9p?=
 =?utf-8?B?aEZucDBuOXFOM1Foc0F5Q0NuK0FQbXRqNlNRV2JFNzR3LzM1eXQvQ3AzbGNm?=
 =?utf-8?B?bnhvV0V1eDduUEFBN0h2bWlsdGhRNDJmWGdwTlJienFRaU9wNVJFWjlMcEw0?=
 =?utf-8?B?UnRaNmljQUZkWjJ4N3ZWbm1YMy9LMVI2U09Cc0pmS1RKY0xpS1RubDh6KytX?=
 =?utf-8?B?eEFDSURuRzFPVGMwdFBkbkd5cXdhR2x6SjVIb0o2S3pOL1dzdlc0a0tYUk1R?=
 =?utf-8?B?cWtjOUptTnlPckFVVlduclljWnlqbUI3SXN3NytUazByaG5uTUs2anZsZDJP?=
 =?utf-8?B?M0Z3MzYyL05CMlZjWlBlaGh4a2FHcFV4V2paOG1Vb09jbitnUGVOQ283cURM?=
 =?utf-8?B?dWNNVm9vWTZYVHUwSXlvMUxFQndyV0Z3ZW9ydHBMK0pTc09nL0h3aHJaaUl4?=
 =?utf-8?B?cjU2alpYdTUzWStWdFAySmFIaXhGTTJHOXFQcitmb0tJTjRpeHJKSGZvYkNR?=
 =?utf-8?B?L1ZrcExCRmkranUzbHp3TUZnaW9Xek8vb2t3V0dyVnFBMEQ5Rmh4NUtPM290?=
 =?utf-8?B?UG9wR1crTGt3RDZib3VHRjhpVDFaRFF3ekFpRjRxTmNSOUpUaHU4WDJ1NlNh?=
 =?utf-8?B?cWN5Q0hsUjFScmdzWC9Db0NLRS9KY3JnenZoSzRwS2xZVU9XajRCN3JyQ2hk?=
 =?utf-8?Q?i3p26xQP6pJcatak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFEA7E6C19650B479184DEB2F3DC2E32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a62547-2649-46f7-4493-08da3184d598
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 06:26:21.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNgQWgVNfiTaw2FhKcHY/MjtvnwFvMnnTT7zjyZ/QM54ZiGoT2z57iNTicZrYYgrVa6ceuSKa1SPFGOexHsDuCTclX/w2ye41rMlA83cPMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4121
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAwMTo0MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIE1ESU8gY29udHJvbGxlciBub2Rl
cy4gVGhlIGludGVncmF0ZWQgUEhZcyBhcmUgY29ubmVjdGVkIHRvIHRoZQ0KPiBzZWNvbmQgY29u
dHJvbGxlci4gVGhpcyBjb250cm9sbGVyIGFsc28gdGFrZXMgY2FyZSBvZiB0aGUgcmVzZXRzIG9m
IHRoZQ0KPiBpbnRlZ3JhdGVkIFBIWXMsIHRodXMgaXQgaGFzIHR3byBtZW1vcnkgcmVnaW9ucy4g
VGhlIGZpcnN0IGNvbnRyb2xsZXINCj4gaXMgcm91dGVkIHRvIHRoZSBleHRlcm5hbCBNRElPL01E
QyBwaW5zLg0KPiANCj4gQnkgZGVmYXVsdCwgdGhleSBhcmUgZGlzYWJsZWQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KDQpSZXZpZXdlZC1i
eTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAt
LS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSB8IDMxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IGluZGV4IDY0MjkwZmI0MzkyNi4uMDQ0MjczNTkx
MGRhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IEBAIC00MTgsNiArNDE4LDM3IEBA
IGdwaW86IHBpbmN0cmxAZTIwMDQwNjQgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAjaW50
ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiAgICAgICAgICAgICAgICAgfTsNCj4gDQo+ICsgICAgICAg
ICAgICAgICBtZGlvMDogbWRpb0BlMjAwNDExOCB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjk2NngtbWlpbSI7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4
ZTIwMDQxMTggMHgyND47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmc3lz
X2Nsaz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICsgICAgICAgICAgICAgICB9Ow0KPiArDQo+ICsgICAgICAgICAgICAgICBtZGlvMTogbWRpb0Bl
MjAwNDEzYyB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9j
aGlwLGxhbjk2NngtbWlpbSI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNl
bGxzID0gPDE+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZTIwMDQxM2MgMHgyND4sDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweGUyMDEwMDIwIDB4ND47DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmc3lzX2Nsaz47DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcGh5MDogZXRoZXJuZXQtcGh5QDEgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwxPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1
cHRzID0gPEdJQ19TUEkgODEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgfTsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICBwaHkxOiBldGhlcm5l
dC1waHlAMiB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDI+Ow0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA4
MiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiAr
ICAgICAgICAgICAgICAgfTsNCj4gKw0KPiAgICAgICAgICAgICAgICAgc2dwaW86IGdwaW9AZTIw
MDQxOTAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hp
cCxzcGFyeDUtc2dwaW8iOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHhlMjAw
NDE5MCAweDExOD47DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
