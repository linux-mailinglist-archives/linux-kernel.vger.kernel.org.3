Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6E4D30F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiCIOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiCIOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:23:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61A4A8898
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646835754; x=1678371754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r825u2ZG00Fgko3fkPsZfam/eBrK1IKbU1887kKwzEc=;
  b=DtO4ANzC75UPZAJjQAHQKy5u0udFODWy11RLfg6MFefXZP8pcYIm5O5g
   roMv3XT0eXL3R1Ya3EcrkNh+si+KUD/JDkTAJ2rHyt1WdQWvMV0CoB0w/
   Rbe2/3Osef2ioGPkFD37iMAMScGRAI8TLuublVVUhUhASW5trrWiB0XIw
   CPmfvaRO51SdrzFvB8WVCiWmuYjf0qjvs1NzJY97AcFVNIJ8dXWOydv/u
   UxfMuTBptmWaJXTNo/XBHImDJceIM/3qv6ZI5WuHnlRfj4NYSSxo3pBvW
   dfO5ohrd2fbne3WHV/jUM93LKycJY6Con/JNuh12uplR7tXya9hmQylS8
   A==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="155810523"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:22:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:22:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Mar 2022 07:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8G0DL3Cqvaj6TYtNIpXIbl/Fh7reG6phCdMCTJIo70Oo0WPr4aumSQ09k5irLsi5SPDWMFTbLC489/R86m+/NB9+YGpz9ORNK8vYmmtlCPwuyEIh7NMDvpso89K1r2QSyPp1Kvt+kv8SVYrjrt3OjZ9NlGMwGMkSuwdwiu1bYU0Qq9tjm75Kq3PYDGi5DS1Fk2tdjbf7Ng/7b5tsMIbx3QYGHkN8SPmIFM2QX0K/9z2RVVInO8+SiV8oMThBc7MqjqHvZeHDXVQp7NguSQohoh6T2rbErTWWP+BK2TRvawLngF72Kg4EisWyZ7AEulMAx+UKyvzfe/NaZfPbXRA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r825u2ZG00Fgko3fkPsZfam/eBrK1IKbU1887kKwzEc=;
 b=m/vcqFX5QpEaFJr3QoUiCUCnRyoSpZWBLKcvSHMAQptb5GS3O+1dasmtvwqj7IX0x4eoeX4zG7YHcvxQ2evBTEuzB/fWwmxAG40LypQLChSTymau4b2Bdjie9mWqGl7jSgmfEnASKHCGVl8rDfl5+4T3xQPb7GTt0inPVq2g1wevvf6gFlfDb3h8A8Eo88WJSp4EsZ4psXwOHuadNataAcK9Xhdu7FrI335cKVEC/lLXmfeRuRDYA8NgsaQsrJ06Z6iOw9yBUGuN++foikcpTnuhQTC7qC9tapVJcdb66eX5sbPc7Cg6VO+VDtTu70RGNm4vApQ+7f6d17oaC/nUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r825u2ZG00Fgko3fkPsZfam/eBrK1IKbU1887kKwzEc=;
 b=EYcag+8bDzFBAtvWe3OVHFEkUs/7Vd8TSpIR8+nGug/3OJcZl2Qy8q3sMrK8ZMWIDt1C/WQK8fmlBgSn9rqPXvagNlrPjmdQjGaNk0tyo2cCyjrp7DPQ+llhc2DQwS8Sej7HEqvXZbwAhc+mUA2tcD6wvGtUiT20YQl7787B72Y=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3326.namprd11.prod.outlook.com (2603:10b6:805:bc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 14:22:21 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 14:22:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mtd: spi-nor Favor the BFPT-parsed Quad Enable method
Thread-Topic: [PATCH 4/5] mtd: spi-nor Favor the BFPT-parsed Quad Enable
 method
Thread-Index: AQHYM8EWAn3gxKvr+EemEbZ2d5NDSg==
Date:   Wed, 9 Mar 2022 14:22:21 +0000
Message-ID: <7fcecd56-494d-a0d2-2cca-989d13cebae6@microchip.com>
References: <20220309141702.173879-1-tudor.ambarus@microchip.com>
 <20220309141702.173879-5-tudor.ambarus@microchip.com>
In-Reply-To: <20220309141702.173879-5-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aed52629-fc5d-4bab-7a69-08da01d83978
x-ms-traffictypediagnostic: SN6PR11MB3326:EE_
x-microsoft-antispam-prvs: <SN6PR11MB33268F3F73DB49FBDE9FFAE2F00A9@SN6PR11MB3326.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDWohFp2l7Hc1hRvvPM5RvTCL9Luu3y/VXu/2q4BA/+wjV8SgrE0X9p1WpY7NOervB8DpEW20HCeaNiixO408Uu0skoX2zPxM3SsVkzh0raDscrXy6rEgUgl2ZmCMJ+S5EVtqL242oQ0hKn/KF6KXvnYNKCYXKpkeeqlNFw6LnyKWjtpsEjCp4Ne/hZTeSp2pmP3teVugBxgftixcKE+q1/XgkmGn5lvqdPfrgdxizmeifdXYNNHIc6GX+ooQQLKrMWe5xRM1ZM0S9MGlUyEPwaJVy99SgWGUhRePOld48xxO7kSKzrWFX/53NbR74cseR9C7CjfEaTLbanb7qWi0g2bUcF8dhufWMaBWkjNSTjj08T/eK3kUGG93LeI59B8ctGPiarKY9L3N20YYjyTh2+6xILQXk6hQnGJk/LYRtON+hdUV++9st3BigughkSqun2e7aNrCmZeeWpUWDUnRBuHFJ4eIW0yAWwktpyt9aGPceNqmpIFWajg6rY3+penICtMRdRO7h3QfMvhqLCVhC1Yol+/hUpR/U2nSxYUqmcZTj/yLZLSV3whXkUGuiTTj9LyPykjSuhcUhLok0MD/496gs3/6d3tdPN7zH6ZJyzBmovivfN6gao/2hIdpM08lRoajTznKtLo7duKYf41o6By/Thu57KENlrV3/1XGgxSSeCN545KJXjXp5Sz3uQf0nTgrU2Og6UrJd4N5VoZbcGAfYLWn2Jl/c6IRDl0ZX88xXduzvkSWkNil0kVwftm7XAuC0R2JkRiZDbLPqhLTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(186003)(26005)(2906002)(53546011)(71200400001)(76116006)(91956017)(66946007)(6512007)(8936002)(5660300002)(31696002)(86362001)(316002)(6506007)(31686004)(6486002)(122000001)(38100700002)(2616005)(54906003)(110136005)(38070700005)(66556008)(8676002)(64756008)(66446008)(66476007)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWxvOW04azhSVzZqTldwY3EwTUtOSlU5N0NhaHBzWHJLTk56c0lYMnhFOGIr?=
 =?utf-8?B?ZXMxSWtRNW1IRVpCQ3p6bWtPUE5PdGNDNGQzS1hXZm5PU3ZYVjB0dHZjN1d0?=
 =?utf-8?B?WkppSlpUQVgxQTc3dUtoT1I5QlR1dEYxUEUyNVRJMUJHMHhkVkNVS0cwK2VD?=
 =?utf-8?B?N3hDMUhQamtPVzh3V0ZoN2dhQ3NEdHBUcjdiSnlBak5ES2pCbHY3OWF6R2N3?=
 =?utf-8?B?NDQ0MTBmT2JjM1NucVh0SmNUQ1UvazJLbGtSbnMvMlRGeWxKRGdvbFBUbk1a?=
 =?utf-8?B?UFJaT1d3YUZWTzZJVFh3dGtkYUVJUXYzRThmMEtrWDR1RjRSNmZHbm9VU1Y2?=
 =?utf-8?B?ZjhqM2lESG9pTHMyYzc1OUJIeTVORjRmaVpPbG9EcVY5ajBLSjRCdnVSTi9L?=
 =?utf-8?B?MFExUEp2TVBubHVkTG9UUTB3T1BmdkYwMmxmS2hWcjFnWm5TQUZCNUtoc1VM?=
 =?utf-8?B?cVhrU0ZIbFpub29lamdjNlFzTnQ2cXVwa1ZlWmZIOHlGU2hObnZXZ25rN1hz?=
 =?utf-8?B?aUpoZnAwTDNjRW44TFg1c1pHSjM2eVpnOGwyYXYvU0ZNKzlEajB2bEQvaElQ?=
 =?utf-8?B?Q1N0VEI1OGt6dDRrdnd3TENqRnNET2l1M3Q0V0h2UWlMdU1CbmJMMVhkOVFX?=
 =?utf-8?B?QlI0S3JVazdhckRXbFVUcGlEQXBFY295S050bkRkNkFhMG9mYlcrSDY5QVNW?=
 =?utf-8?B?S09yU1F1T0JPY014UlgwM2xheVVFQnk3OGt5NVY5cXhjRDYrSHpTQ0loS1Fh?=
 =?utf-8?B?blJ2Uk96eEFRdHhCQytLbDQyRXZrOGVjYmlDV2tuSzU0UEZDR0JHb1pqME95?=
 =?utf-8?B?a2JlYVJ0cExDbS9iQTNLdnoybnZHclhMejlyZzhuNmZQNG5aV210OFh6bGMw?=
 =?utf-8?B?OXd6VGZ5WTFqUVJoREg1eUhEalVoTklTUXZGaG9ueU10MWVXK29vcjBNRlFy?=
 =?utf-8?B?dFBEYlNISW1melY2ekJtZWtuQWQ0RnI5a2lJRGpaV0RDV3dnbzRoQ2dldHB4?=
 =?utf-8?B?a2pZM25VeElMVlZsb2FTU2JGZE1ZUXFzNC9jRWRLTTFTSWEvSHlWaXY4U0ZJ?=
 =?utf-8?B?UlhJSktYNUNqVTdWTnc1MTNiNG9lMVRtZktkM1JFc1VxM3RIb21aQW8wWUpT?=
 =?utf-8?B?S1U3L3RTY3FDajJDRDZVbXZkVG1KVzVIRGR1Y3pIdGZ3NTdKSEpBMnFOcTVi?=
 =?utf-8?B?RlFwM1RHdVFKaVk0b1Rlc0pKRy9vZ0kvS1ZMN1hOenR5ZVduR3BrS01pOUpN?=
 =?utf-8?B?MVFvTEtwMVg0NHp0ejhKWC9wdC9nMkJvbTBLNTRpSk92dmxaWjFtaFVTT0cy?=
 =?utf-8?B?SmhRejhCemVYY1VibVF0WnpYT3lTMklmNnBzWkJPQVJOZFdLcFZoTXNCVGdj?=
 =?utf-8?B?U01JMG5XaHM5Y3dvU21MOTJIMFlibWpDajl2M0E1aTNjS0kxWVNnL3o0SE5l?=
 =?utf-8?B?eld4dGgxbUVIcUJMN1VJZGpMMjdpYkxibEdzOVZOaGZXdWtreUtLeTFNekZX?=
 =?utf-8?B?eHlqWEc3ZFRNOGRkbDBJdWlxS21oaG1oR3d3TEVpZGlmSEV0emxvdVFVY0Q2?=
 =?utf-8?B?QmZaWjd0dng2Slplb1c1RHV0ZVlzZEsyc21GTitUczdTaTdPZUNTNTNLekFD?=
 =?utf-8?B?SzV1QnBjTGFER2JWWE1ISXByUDBNdWF0bjRIUXg3cXo1akhzVElkVFdPNjMr?=
 =?utf-8?B?N3dyUVJZZW04N21oQ3NFaE1YSEpLU2orc3hHUW9BRE1PQ2N2aXRHb1VTdEdL?=
 =?utf-8?B?b05NdnFDaHA5VjJzYURXWE93N1ZEN1VQTGwyVWcrSXFRbUI4czBQUFBqUHNL?=
 =?utf-8?B?LzczeHpIQzcvcjRsTThRdFhhdGdSSXZLQit2SEpwOU9pWVZRVEQrWU04elEz?=
 =?utf-8?B?RnFvUlhIRFV1VEVxdzN4MTBZVzZyYVRyVk5GZkhQb3lNUHJadS9LVUcwdXBD?=
 =?utf-8?B?dmNYVmdJNnhnalQ5emtSS1N6aDgzajZ5NE1tNlIreHl2emZBek5MVDNMamIr?=
 =?utf-8?B?QWRnUlJrNjZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D5B9E34A30C9A46BB5E7FE24085D37D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed52629-fc5d-4bab-7a69-08da01d83978
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 14:22:21.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCHPrCy6AQ12X7Wi+q3Cnh62mWke7qyfgfmFltT/z06EDPH9EgSPvB4T5L/tMlcinwtNDZwr5hw8JAi5HlSpRBHtS22C4ez7saBS5IWQfLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3326
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy85LzIyIDE2OjE3LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBKRVNEMjE2IFNGRFAgZGVm
aW5lcyBpbiB0aGUgQkZQVCBzdGFuZGFyZCBtZXRob2RzIHRvIGVuYWJsZSBRdWFkIE1vZGUuIFRo
ZQ0KPiBmbGFzaCBwYXJhbWV0ZXJzIGFuZCBzZXR0aW5ncyB0aGF0IGFyZSByZXRyaWV2ZWQgZnJv
bSBTRkRQIGhhdmUgaGlnaGVyDQo+IHByZWNlZGVuY2UgdGhhbiB0aGUgc3RhdGljIGluaXRpYWxp
emVkIG9uZXMsIGJlY2F1c2UgdGhleSBzaG91bGQgYmUgbW9yZQ0KPiBhY2N1cmF0ZSBhbmQgbGVz
cyBlcnJvciBwcm9uZSB0aGFuIHRob3NlIGluaXRpYWxpemVkIHN0YXRpY2FsbHkuIEZhdm9yIHRo
ZQ0KPiBCRlBULXBhcnNlZCBRdWFkIEVuYWJsZSBtZXRob2QgYW5kIHVzZSB0aGUgZ2VuZXJpYyBj
b3JlIG1ldGhvZHMgd2hlcmUNCj4gcG9zc2libGUuDQo+IFRoaXMgcGF0Y2ggbWF5IGludHJvZHVj
ZSByZWdyZXNzaW9ucyBpbiBjYXNlIEJGUFQgY29udGFpbnMgd3JvbmcgZGF0YS4gVGhlDQo+IGZp
eCBpcyB0byBpbnRyb2R1Y2UgYSBwb3N0X2JmcHQoKSBmaXh1cCBob29rIGFuZCB1cGRhdGUgdGhl
IHdyb25nIEJGUFQNCj4gZGF0YS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMg
PHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYyAgICAgfCAgNSArKystLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9pc3NpLmMg
ICAgIHwgIDQgKystLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jIHwgMTQgKysr
KysrLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCA1ZGU0NmE3ODZjYzUuLjlhNTI5
OWE3YjIxMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysr
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTI0MjcsOSArMjQyNywxMSBAQCBz
dGF0aWMgdm9pZCBzcGlfbm9yX2xhdGVfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikN
Cj4gIAlpZiAobm9yLT5pbmZvLT5maXh1cHMgJiYgbm9yLT5pbmZvLT5maXh1cHMtPmxhdGVfaW5p
dCkNCj4gIAkJbm9yLT5pbmZvLT5maXh1cHMtPmxhdGVfaW5pdChub3IpOw0KPiAgDQo+IC0JLyog
RGVmYXVsdCBtZXRob2Qga2VwdCBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4gKi8NCj4gKwkv
KiBEZWZhdWx0IG1ldGhvZHMga2VwdCBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4gKi8NCj4g
IAlpZiAoIXBhcmFtcy0+c2V0XzRieXRlX2FkZHJfbW9kZSkNCj4gIAkJcGFyYW1zLT5zZXRfNGJ5
dGVfYWRkcl9tb2RlID0gc3BpX25vcl9zZXRfNGJ5dGVfYWRkcl9tb2RlX2Jyd3I7DQo+ICsJaWYg
KCFwYXJhbXMtPnF1YWRfZW5hYmxlKQ0KPiArCQlwYXJhbXMtPnF1YWRfZW5hYmxlID0gc3BpX25v
cl9zcjJfYml0MV9xdWFkX2VuYWJsZTsNCj4gIA0KDQpvb3BzLCB0aGlzIHdpbGwgYnJlYWsgbWlj
cm9uLXN0IHNpbmNlIHRoZXkgZXhwbGljaXRseSBjbGVhciB0aGUgcXVhZF9lbmFibGUNCm1ldGhv
ZC4gTGV0IG1lIHJlc3BpbiB0aGlzIHBhdGNoLg0K
