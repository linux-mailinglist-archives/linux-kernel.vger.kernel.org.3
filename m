Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818B4EC590
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbiC3N10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiC3N1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:27:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FFB644CF;
        Wed, 30 Mar 2022 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648646739; x=1680182739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0l45PP3zuqHdq+t0iI8xxzRia2BfKOQTYJVuMYZcdCM=;
  b=ztvhBqyqWq28ErJRhxUbmtga1YzVfA60xZ1xDhevtuxG1WYMuo4UAsHt
   gMvaD1/ipQ+s7rCHHPqnTmBuMY7W8sT+SqqsyBDkAzDiozeQzf9i4QXCp
   KfucoLWH5lStE1xUeIX/sAa3fGGbUyonTeCH7oIa2kWqhNTcbJF1qavNO
   x/WsVi2TICjBVHLbBjGgMJkOm1v75MEHGVubHPjXWr52q00aHILR/5Mmh
   nw5SU1ahPA19Jju+UczgUB4FnZIqsBlr2CB0MsSsgmvN0Zqj/VhutDuxp
   L1IffcTOsTfytjvPbYzQXKA/Xkm4LFya9J+X2Khuhy+qd1NmXi/T4RMwh
   w==;
X-IronPort-AV: E=Sophos;i="5.90,222,1643698800"; 
   d="scan'208";a="167673403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2022 06:25:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 30 Mar 2022 06:25:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 30 Mar 2022 06:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDPGhGM9dpU0W2LiFdUTYlBzUR2YxEm9mGHNhgdd7A1Oqubi6FNhzCRiMAthYVTG+HxOfs5rrmgFBLsxUhsTmz4tbt9Ez0I9IxuFTGJSApPaDupAPFF3lgQzQuga7WdF6hs5MC63R286kpR+w3ZootToGTqFSWiJnxi8CUuoCbnzhk7W4//ld2UorPquwlNmjPsjPLixJgXgN6/abdP4Nd9Wxhfq+irXpmuStebmkyHt8EJmM9adIRE3/fwpSEDd0HFTYrHkgKn8r60uSl1e/omx1AOKRxv1fhHs8iYaVrTNHLZQ8YjursDH0vT27UQQxUEkU9ljfZUdd25Hk4J/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l45PP3zuqHdq+t0iI8xxzRia2BfKOQTYJVuMYZcdCM=;
 b=oGaxmoT47pSCCa2A3oJ9HyRKGrmo3TPtLzxzuV1mNyhsW0AZ1PtIN2TBRDyFL+DNtvT2Ima+TAgquMOofJjJqZMF7uZ/PtM4o0aEwXxnyU6hc8SA23s5IQIP/h9h97XKD+ne8iDhggQI4kNtdLjLz4ozl3zRzOnhQ8/yuWmiQyjx93aWskqWVDd0XZjqxJKQgVV8+143MVaQ7tWSJ0XHj6vgsH4kcXzUVyEGHHnu7EJneP24Yye3C6a/Ktla31H+OHVcWfS6YVaCp+FZVzDq5RrIiOu2Qop70BzEFL5TMpQxJp73A39l8fVAaL3uMKCOAU8DucNx+v7li8Y5coSYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l45PP3zuqHdq+t0iI8xxzRia2BfKOQTYJVuMYZcdCM=;
 b=s8l5KTcAH8/X5apzJH9S24YHzb6MJrGZyY50VpQRpBtkBxXojCeliT0CU1ZVGy/4oY3G4bNdcF4hYEGgsLUdzmSrcLcou5eK2Un4mxRGRAmKx9bhFMVN7wSUcXhM77MQQtCYmuDiG+fWxPXYirtmQD48rydn/r3AE+p/AFhk+B4=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by DM6PR11MB3881.namprd11.prod.outlook.com (2603:10b6:5:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 13:25:33 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5123.021; Wed, 30 Mar 2022
 13:25:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/7] ARM: dts: lan966x: add sgpio node
Thread-Topic: [PATCH v2 2/7] ARM: dts: lan966x: add sgpio node
Thread-Index: AQHYRDmi2LN2nQ/eDUOvziX2Jk4KxQ==
Date:   Wed, 30 Mar 2022 13:25:33 +0000
Message-ID: <2a0f635d-d217-4f3e-2d0f-4a73bbb18596@microchip.com>
References: <20220304153548.3364480-1-michael@walle.cc>
 <20220304153548.3364480-3-michael@walle.cc>
In-Reply-To: <20220304153548.3364480-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e99ffb7-37af-40fc-8074-08da1250c4c5
x-ms-traffictypediagnostic: DM6PR11MB3881:EE_
x-microsoft-antispam-prvs: <DM6PR11MB38816717EF0712519CC0016D871F9@DM6PR11MB3881.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMEaiQWQYiJPto/3Z63e2JNmAZzHbt4tGlXn4lMmqY/+loF/19SUiticjui8nba1F1lSTn+qtDB5HafukRGe0Z6DiRvUpx0+qo3P7iEEgyumMIzqL6hiMqFfu8gqIjY9Cuexao84PSi+KqZDqu6YfGRTrilLJWzLwnqdt+LcddR48YADUuNEW5/d6Etx0053n8ZC5x+4q+JHQ+d8dryTp4V23X2mfy3RPs53GYvsbIk0VXS0NXx90ben6wteuZKK6c5q/SAKKPjWS6FgOxVK34OUW0+nRQJS+Db19+qfKZE5suqrV6+1D16ZRjIH1pxxpfloMKBMpBDYqr++qY2F2elT8HUhCNIZc1uQmoR/UvBdLFYmYGGExLn6nAqaagBgf6swImW7hMFpR9NtXBKNS9Fcgx0BaoGybVCaE/BDdJSmK9AfLCoiVM97LRHPCb+L16pBZ1pJtUutujz64kC0934RT82JCYVW14HjmR9CQRCgeTND8RrYlJFH7BK2P3qxtyewJniV/pCaeVADbIjQnXwR37rYQMoWbP9vttv8XG//93F5gJ3SfuavY8wist4Tob4wr1H4wI3oEruHSZtW5Zmoqu6wpI3i76xKITLe83N90V8qoXb4YA8CZxjrJ1aLAlEn63A0DGFEdLntYEtTb+ljViteyW/jo9NDE8ox3mLJ19YGOL/MglYXTT3wkdziBxMDAVbwHGFCGs9LacwUQplIwFODoT4wZqbb/OwbnDbyvsrDrw/5E+8ZZX6OW/J80EbqCJy7VW3KjUDsV046gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(2616005)(186003)(26005)(122000001)(53546011)(7416002)(8936002)(2906002)(83380400001)(31686004)(5660300002)(36756003)(71200400001)(76116006)(66946007)(31696002)(508600001)(86362001)(8676002)(38070700005)(6486002)(64756008)(66556008)(4326008)(316002)(38100700002)(110136005)(54906003)(66476007)(66446008)(6636002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2wvaExkb3gyQnpzTlJZNytVOTdScWE5MG9NRUFmU2h5RjRqOUgwMjJMSmtV?=
 =?utf-8?B?ZjlUdmRDVmVsNzU5bXBjM3ZpQTFFZkszbklUSk15VUpQMVp2NU51M24xNDVI?=
 =?utf-8?B?dGdIOWxkWHVrUjI3dnlTc0phc1VWSlNIbEJkaEVuWVVFMGEzZDAwNmlYZFJi?=
 =?utf-8?B?QTQvT2E1MGhJQ1NnbXRydWdnMEJ3M3hVcmJOblBLdTRiWERuUTRoVzFZNEx3?=
 =?utf-8?B?dDlvS3lKSzZEaUdoY2oyb0kxNVcvZit1WTErNnBqaStaMWc0K1NEcGt5MVVj?=
 =?utf-8?B?NTN3RERzTXBYU1FYdXVmR0xkVUdjTVFQT0YyWUtaSHBsN01xT3Fvbml2WVk3?=
 =?utf-8?B?ZEcrSXFKNkRhK3MveDdqMUsrc2RSWk9rbHd5SVNBbk9VNjhacWxKOHpqbGpJ?=
 =?utf-8?B?QnIvY1BkdVBGSks2amIxNGhQTjlSS3oxQjdRdGJ4WkVuTWdrTEVjOHFFRjdJ?=
 =?utf-8?B?ejRURjgzaytPb1BKSWpiLzBSSG5nMkNiNU5FWlV0UzZVZTR0S3IvMnZQWWQ0?=
 =?utf-8?B?WVZ0Nm1SbEJUakZmTFBpSjd5RGd3RUh4MWQzRFFVUmQwK0NhNjJtZkQ4UmRm?=
 =?utf-8?B?UVZmUE92M0U2VWM1WFpHMTE1OFRCZlYyVG5WUk1KTTdKRWNaSkE2UkhtRVI2?=
 =?utf-8?B?RzNXMm5ZTDR1QTJTL3FFNkhmeTFaQVozL1BsQUhMamdqdENLVlkxQUI0Tldo?=
 =?utf-8?B?UklNQlFtelJ5VXp6dE1QNnNDYm4zdWc0Q0dac0s3UlFWTitNYWh6NUJ6OG9U?=
 =?utf-8?B?UHpxZVI2MW90QXdCa1MvL0wvdGVPMTFqLzlVK1RYMC9YSUlmNllxQnZCS0Fu?=
 =?utf-8?B?cEF1NUlmVkNkQ3IzaTVCMHovWWN2cldHcGY2b2RFSjUzMmt4bnhQbEZPQnpx?=
 =?utf-8?B?OC9zUnBzS2V1NEpHY3dTSWoyalRNb3lkOWFhWDZZLzBXZ2krUXZHaFFtQXJL?=
 =?utf-8?B?eXJZTUVBRnZxcGVUZGhTWjJLdm83NlNFcVlPbG1Ubyt6VlBmTTdEQ3phejRB?=
 =?utf-8?B?YVBKZFdhTkg2OXJuYU1EY1B5MGgrc3VPZGhDTElTMXZ3bTBqYml4bVd3c1Rk?=
 =?utf-8?B?R0RkNmhpZ0FyUTl6c2JzZlI5SGtCbUcweUc0anQybTZ6R3BhaHVhQTgwSWxm?=
 =?utf-8?B?aEdjaEZwL2pCVlFzZjlQeGZLNXdBc2VFOXNQcTVuM2JoNmlWeXcyam9PZEVj?=
 =?utf-8?B?ZUduOGRlU21YUjM4ODFnZFEzVXZObmF5QzRVcVByUU1DY2JxSjV1SkVSU1NW?=
 =?utf-8?B?NFNLYkhWOXVHUGNjTkEyV3lXNmd1eThQYW11cjZCeUhiN1NJTGJCUDlKczlP?=
 =?utf-8?B?dFZPa0IybjFwc0JJcmIzYS94NmRtd0liOUZHcytOUjRpaUpYdjZVbTJJZ3Bu?=
 =?utf-8?B?N2RKVyttbDM1LzFxNUpVcXBiTjlmMGVNUjdoT2NhTEpEd1BkaDJ0TDJXTHB5?=
 =?utf-8?B?OHBlVzlURXVKcTFFYjhBYlBzT2VGZTArK21ETDV4bDNnd1lQR1lYeS85SHhM?=
 =?utf-8?B?enFobG96ZEVOczlINnlwWXNSaU5xT2hNcGdwZjZ4V0RzT1RZc1d0OFBCdEVv?=
 =?utf-8?B?aUVrZkNpUnpLTW9qS0k5Q0ZGMDVSTTl1Zm83UUkzV012MWJ5VkpLRUtXeHVF?=
 =?utf-8?B?ZDJEUHU5RkUvamhucWhmY1B1enpHQWhSL05MUm9MNHJ4Q3JMM0Z3RmRWOTRD?=
 =?utf-8?B?OWp6TmFzNEFuc3I4M1lKUHd3anZMWFJSd25WWXRtT0d0RWNXZ2dTbUZTS0ZZ?=
 =?utf-8?B?aXhuTFVtcDlCQW1SOW1OaWdPcS96TmorcHhBRXpYTjdZR1RNUDFGNEZyeFIw?=
 =?utf-8?B?V1ZRUk85UllmZEl0aDZwbS8rWnp5TlIxQmdLVnVtWWExRkdvNC9lajFSZ1Bl?=
 =?utf-8?B?NTBWQUttai9KRTQwN1pubHYrNURQcmxEQVV2YWU5ZXRpN1F2SWRkUnIwR05o?=
 =?utf-8?B?STVCREtMNXdVTGxZNEUrYjdjZG4yYjdPOWN2WUdTVE1sNkttYTNSZjRDTXJN?=
 =?utf-8?B?Q3hjQnZUcWxza0xxQXZ5amszM2ZZMlk5R3ViRXlSZ0JMSXZ1QkpNdDltUFRI?=
 =?utf-8?B?VG0yek9SREJuNmpqU3UwSWZVeXdXMGZYTWw4MXBzY1ZFa1RtZURHcmY1OTZK?=
 =?utf-8?B?N2E4cjlOTGtrWTJVTSttbWtVZmRXQzNCVFVzR0dXa1NwVFZWeUErbk5WWFkz?=
 =?utf-8?B?Rk1KUHkwMzNnc1NDOUU1cktkWm50R3puZHBQSXZrbWdJdzRiVFFTakEydFNr?=
 =?utf-8?B?empkaFVuKzBtQ05zOVdrRnJOU1I4eHEzOUNUNmFGNVcxRUVTcVlwTk9zY2VJ?=
 =?utf-8?B?R0FRRTBmMlA3VjRvYVZhazk0NVprN09IOVMvRVFIaE5KSG5qSlNtUlFLZTNt?=
 =?utf-8?Q?6v09Sww2eAOaoeU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <013D3ADE7F805B44B56365010F2AB24F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e99ffb7-37af-40fc-8074-08da1250c4c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 13:25:33.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 287BzIVRibbA8r0n2QSAKYjzKts/SnTxYtmQ7KWvnwMePmHXxvDeIKq18mBeAmYnTi6ME5lRESvuLa4C4ZnAoY0J/8dsPYsvtuF9tKJ01sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3881
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAxNzozNSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIGRldmljZSB0cmVlIG5vZGUgZm9y
IHRoZSBTR1BJTyBJUCBibG9jayByZXVzZWQgZnJvbSB0aGUNCj4gU3BhclgtNS4gS2VlcCB0aGUg
bm9kZSBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBX
YWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290
L2R0cy9sYW45NjZ4LmR0c2kgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy9sYW45NjZ4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kN
Cj4gaW5kZXggNWU5Y2JjOGNkY2JjLi4zOWRmZGI4ZTI5ZWQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45
NjZ4LmR0c2kNCj4gQEAgLTIyMyw2ICsyMjMsMzIgQEAgZ3BpbzogcGluY3RybEBlMjAwNDA2NCB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47DQo+ICAg
ICAgICAgICAgICAgICB9Ow0KPiANCj4gKyAgICAgICAgICAgICAgIHNncGlvOiBncGlvQGUyMDA0
MTkwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAs
c3Bhcng1LXNncGlvIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZTIwMDQx
OTAgMHgxMTg+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JnN5c19jbGs+
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgc2dwaW9faW46IGdwaW9AMCB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc3Bhcng1LXNncGlvLWJhbmsiOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBncGlvLWNvbnRyb2xsZXI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgI2dwaW8tY2VsbHMgPSA8Mz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8Mz47DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgc2dwaW9fb3V0OiBncGlvQDEgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNwYXJ4NS1zZ3Bpby1iYW5rIjsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MT47DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ3Bpby1jb250cm9sbGVyOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICNncGlvLWNlbGxzID0gPDM+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0K
PiArICAgICAgICAgICAgICAgfTsNCj4gKw0KPiAgICAgICAgICAgICAgICAgZ2ljOiBpbnRlcnJ1
cHQtY29udHJvbGxlckBlOGMxMTAwMCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAiYXJtLGdpYy00MDAiLCAiYXJtLGNvcnRleC1hNy1naWMiOw0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDM+Ow0KPiAtLQ0KPiAyLjMwLjINCj4g
DQoNCg==
