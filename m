Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55A74FB4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiDKHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245409AbiDKHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:31:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D4BF51
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649662152; x=1681198152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EAHUYmasKONgASPAdCuuk9HglTm/zmEr+zPN2FNrPX0=;
  b=zH+vpVYBIqghRaXJ88NlkUGMHpmCG1VpeObysPl+AidyANGRbY6drudu
   eUliB/C0jOkvaE4S/3zo4a2vGf2E/xdnKB4Ql7Fi4ONZ+QS7s16Z1O+gW
   IjOTZdySVPZwVuiVm/ctAY0mqzgl4uQlK2r2JpDjnHvYxmAwcy8ISJRln
   RI8Mi1wrToPJEOaERKF4MF8SWdC9o8R8weK7NhGRJku5vfaiLl9xgPh5W
   x0SUv0HyhFus8aSc9BdCSxFz/iFVjX5K2HHOQ6YW0cUbkDvFbqB944HIL
   so/i5rw5KQDGSLpL3SgYK07h5dXAyCTQw9JRaSq1kVu8OL9GR82DQQnBk
   g==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="159614222"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 00:29:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 00:29:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Apr 2022 00:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/p/ON5xYQL2RbEEPRSBK51YC1kDVAyCceTtu8Lm/ebK24ZepBQiK3NlmdXK9ZcHocgQp2VTk7kKPARJAQjgmYC63yk+eTHGtPhoSRe7h1n/rV82UJktsc3GORwSBmlz/1YPe/gqkVOm8bjkKZ8M9gm8rCfBlFMAvCh/9xteuCqW6/hYi/pG7ffs8kuKK4ONWT1zecfQVd0ykZaTDUAtGYsQT7sgTBZNGX3Mz0yHxIY1BeKo6AVH6WTb7Flz56jq9iNuUnKLV/+vppM0V00wMdBlYTzlnSuRXgSmtqMjNRb1ouy3LCTROynA+B6CLwJXMLbFKe80XVI8Yp+P/dUMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAHUYmasKONgASPAdCuuk9HglTm/zmEr+zPN2FNrPX0=;
 b=jpBAf4BIRrQ+0Qs0n+1j4sUsS6k+pIE7NbCWK8ZJjJPs1yBK16zZN/2jsKWJrd05ARrVDFfuNYueHN1LsjRDXLVIRr5OnJLMQUZl4k/WQxNZR5jirsfdezdSrgbEBog91ooe8fpT5U+KcgizmgTMoQZ0mOyokj+iYlaCVrfppLEMWN8WLg9KXSKALUr8lbS74rjy7RaVtUVema/aB4lz7KlFF2kxb7eA77U4cOSt1FLwzaKVmnQZtdcFmxv11eQZJWJQhY3smxGlpUeo/HRrFNGtHUPdcP8guHt8KWVmxofgd20xUjvTDLYRNWH6ZHwTgHUDyEIw0wfT068vwczWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAHUYmasKONgASPAdCuuk9HglTm/zmEr+zPN2FNrPX0=;
 b=lwFNHA9lYAQX3btfnRJRCS2l3zdISanSrqyDya+fMu10aJHiBPMnLadXhui8UV3hngf1vRaRB/myNNpm2odHoh35HApDOJ1Mt9x47A8DdCJJZ9ZMmONDcLGdFUBtA0AIM4z0XTW6d1LAeG7cSwJtQhTxz9BnmDRC+/I22mZ6tl0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL1PR11MB5253.namprd11.prod.outlook.com (2603:10b6:208:310::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:29:00 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a%5]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 07:29:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 6/8] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Topic: [PATCH v2 6/8] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Index: AQHYTXXPP+gcsTgSmEelpS0kVpg8Pw==
Date:   Mon, 11 Apr 2022 07:29:00 +0000
Message-ID: <c4dacc1b-d7c5-91d4-8162-2ef4db03f285@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-7-tudor.ambarus@microchip.com>
 <f3dcb594fbf512faa33361b8bfc7b98f@walle.cc>
In-Reply-To: <f3dcb594fbf512faa33361b8bfc7b98f@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cac4695-4b60-45c1-5861-08da1b8cf292
x-ms-traffictypediagnostic: BL1PR11MB5253:EE_
x-microsoft-antispam-prvs: <BL1PR11MB52536A9BAA48608C3738DCA4F0EA9@BL1PR11MB5253.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EsW4MGcReU32o3iwkYkeruqJq4nL93mAo17FDntv1WCEViSuJyfPmuLVvr16dKYa4oTx73RM3F8oJ/SRjtndTQemIh8FnZYLMmDOfR4rqN8d7bVQTdEj6kT3w0VX4GZvKaOibCKmi4+794IwlRn5EpP4vlKb7rNg0PJPgs8DcObjSVvMFs+jMRMxyszRCVQ3/uZ7s2iud8kLq8SsXlfPbCcBuBnfXyVvLB/bGCAqCMRk9PpoOAZSAh78HIKrvdY3PwnLIZog+qblq2rIOuJ9KCjIrmeaw5Xj8JPdnf0GYzWshhWgmHIOPuSqwFteJmVdpvkgRM1VTvgMJ9U5a+ERMuySi+Az133tT34hF9QQ3m6uhEMvTtXqXrstqHpzzytUZSnOk9mElulyU3JutSSGeJookdzXFOIJkEaSuqOD9EwKqUZrBXjMXO551+e+5VhyJnjrKNkCncWDN9HB89w0icrVofEYKIazTSz4BqdNPELBDMSiLPtvadHPTobLxg7hmIbo7GTmhTvce5XfyApO/C2iWNXfz0n7RlKS55AOlkjCKV7x4B1+bRoJIRdlZRC/1xvuMzByPRq9Nta8V4NGeSLv8pLqgwKdq08rEeMmg6AJ1haFxcCxqCwh6Ob/DMlQumEtQUdVFxVTLj+gfXkrHFIsQzURNskJsWBc2VX/aTCNtW2aT5rMLP1O6bPuan2kY+PGWc6jKGll67M1ltdL4qAxkspx8y4XrLOe916JNXAN5miKzTqENe9IocekQ35KJTSaQY/9Lyhobc6xXXBBHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6512007)(6486002)(8936002)(6506007)(4326008)(2616005)(186003)(31696002)(53546011)(86362001)(26005)(5660300002)(83380400001)(38070700005)(38100700002)(31686004)(122000001)(8676002)(36756003)(54906003)(66946007)(66556008)(66476007)(6916009)(66446008)(508600001)(316002)(91956017)(76116006)(64756008)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlB2QTRUSUtRa0hlSzRMbjJhV0xFK0t2cGs1VWhmaHRkbkVrVmY4RnA5Kzdr?=
 =?utf-8?B?TUlQczRyVkpxSHh2VytML3dTVWpDZHNhcmJKT3JTVjFIUEh4K2JZKzhrOUVV?=
 =?utf-8?B?UW5CUGFYWUhmUkxUbHlZR1JUMUVFRUJWSE1WWU94OFRiVlF0aDRzeUdQWS8y?=
 =?utf-8?B?eVpucGF4Q0JCckNTV08vUnhuOW1HcEFmR0FlMnBUM3huT2dLSG5zbGFWcFNK?=
 =?utf-8?B?R3NuWGxZRzdYV0Z5cGVTcEFlVmZJRW1zQkxYY1luOFJnbGl2dHNKTHhQSUF5?=
 =?utf-8?B?d2kySTFPS2k5V2FOVEQyQnRYcDdrY1FCNVdLcHY5M0lzQjRyUjQ5ZVNncyt2?=
 =?utf-8?B?bUdQK1BrUTA1ZDc4SkNaUWE2NUZpa0pmQ25aWHJUYUlnRHpHNW9ZNXgwalQr?=
 =?utf-8?B?MUlyUFVhV05raWcrTytRcUFacTl6NnFlWDZOdDR5bUh3YkdURDFWeE9MSE9a?=
 =?utf-8?B?QUYvbGlNZ1grSkZNOEthSmpsVWFQaUFHVytaNGNBRCtFY0lyeWFWMUROekRx?=
 =?utf-8?B?MmFFeGdVOERuQmdXMm9qT2cxRy8vcTh1bVo0N0x1S0p3SE5sQnR6bzN0VWxD?=
 =?utf-8?B?aks2cWt4UkowSzBvMnltVkx1SzVnTU5jYXQwdWtld1ZwRVBhOEw3NStyZG90?=
 =?utf-8?B?K0Fyam1nMzdIMnJBdmtFaTZ0ZkM1TnlEY1czbjM5Nm5PdnF5dE81RG4zQ2lV?=
 =?utf-8?B?WE85V1FLY2JnNlhKL20rN3VzY0NkdVlieERuendvcURGYXpMMndnSnZYYXNZ?=
 =?utf-8?B?bDNHd2p6N3A5Z0pqOXR0a04xUHpRc0VrdjJvNU1scDFTbVBzdU1VV2NkRkZo?=
 =?utf-8?B?WUdicDlLMXRUb2tLV0dSL2kvOTZwSkFwSXlCNFF4S2xCTVZpQ0xpZWtsczdv?=
 =?utf-8?B?NHp4MUk4M3lIY2I0T0tpUlNCL00zVCtIVWh4YlFCUEJTMElrNmVheFA2WmhN?=
 =?utf-8?B?RGU5NUN5ZFMraHpYQXV2SGxaU3JXQWY4VXVUdFA4MmtEMUduNkVUZnI2aTNZ?=
 =?utf-8?B?eTlEb1VjMG9jNndwNFhDZHJicEtTNWZVY3NCZlF6b0ZTY1pubTA3WEpGY1kr?=
 =?utf-8?B?UnpLd0xXS3Zyck93anNSK01XMjNTN21ZMDNQWm1LYmhja0d4UHRBMExsRVhs?=
 =?utf-8?B?RlFncXBnMm1NU3lwWHVWSVFSVE1RWmZTc0FDLzF6YllzMmVqbFM2SU5NeXdQ?=
 =?utf-8?B?YWdFZUNHby9YLzJobG0yKzNrbEtWY3ZudHRoQ3ZPYkQrMFBHTGJQR2ZBNkcw?=
 =?utf-8?B?V2wvK2hmMGthUTJkRnlEUUhjYVp3TkhBNnhRcFoyb2tNenpIeURCUVE3YW84?=
 =?utf-8?B?RmNsbmJZV2tUSEpjRzNEc3JZZzE2S3V1MXg3eU00NVJqcElUVHgvNmkwUHNI?=
 =?utf-8?B?dUhHTndxendCSE1xbEVoS2RNNXY2UjBpS25rYXBQU2xCL0V2RUdaRzVlbHQz?=
 =?utf-8?B?RVBGY2lFZDBaVjJ3VzZ0Znhnd3Y1MWxLalc2RVlHYTc3OTVQdUY1ZHNiZFZB?=
 =?utf-8?B?WTgzQVo3WXhHRGYwTFIwOXdCSlkwY0xUakRsWjZseGYzSDRSOXhmcjluMlo2?=
 =?utf-8?B?Vy8zMCtSWExXLzRJdTQvZVExZU4wWkxqTk1qdVFZcU9JbHU0M0ZKOXlIbHpR?=
 =?utf-8?B?Y3lrV0FNSWRXTmppUTFHRjN5L0h6UWFod2VQeUpIWkpQZ2UyQWo2WkFKalZV?=
 =?utf-8?B?N0kxUWVvTDB4cU9JblhjMFdMRnlFSkV1RDdmQ0VKZFhLVUpDWlVzdkppZ1VN?=
 =?utf-8?B?c0YyWndNNFp1cWJNbzR2VzZqYloxc0ltU2Y4NWdXdVViL0xqck5sWU94VWlH?=
 =?utf-8?B?TVJuUU9WaE13dkRiY3d3d1lrbzRWUmNHR0dEUGJnaWtYSlFqa1Q0TVZPY3Uv?=
 =?utf-8?B?T0lvSlQ4T0c5NTd4RXc4aEtRSTJnaXNYM2Z4QzFDSCs3SEVqSTYrSDUzd2l5?=
 =?utf-8?B?SjFMTnVnSlBQVUltSEtDN3JrczJ3UzZMSnpNc0FubFVUUzRlajc5ZUhBRTlw?=
 =?utf-8?B?U0YvV0d3QmxhYno2N2lVaVNIMitnY1I4bGk1VUVWV0QzZy9mSEhZNFNFd2RS?=
 =?utf-8?B?VnpSTVpPb2pGSk1YN25wMFQ1RFBTRVRnVGhnM01BVmYwcTF2Q0VtNmQ4dGs2?=
 =?utf-8?B?RkFuTDhsWEtsanRRaHFzRjFROFd4aDVxbkNoakJ6b29FV2ZDY1FuanZ3bXhG?=
 =?utf-8?B?VHhGbHdra3d0amhVVnVRbWZlZTZVcDRkR1I1SDdsWExUY2lucDdWaUNyeXhj?=
 =?utf-8?B?czNlMEU5RzdoZHVQTm9qR2s3M3N3ZlhGNTdFaG9uZldOcHo0dmhmT0pMNk1s?=
 =?utf-8?B?TWtEZDBWSTNTdkdESmdMQWlJYkxkeVIrS0M4SmlDSStMY2k1RnBEUEpBd2RH?=
 =?utf-8?Q?8TUu6dEhBTgHGD+Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64140DA8EFF3444386A9458D7C319E91@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cac4695-4b60-45c1-5861-08da1b8cf292
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 07:29:00.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBYYlRL6xMfhsUVkoMNtLKCqwsQCQF9kxoGZVzsg7uKRCJOfFo2/4QXKAIhNxQdXS/xjHYdJzkq1blo/xo89rlcbYicIB5ql1qt5leSLAgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5253
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMi8yMiAwMToxMywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gQW0gMjAyMi0wMi0yOCAx
MjoxNywgc2NocmllYiBUdWRvciBBbWJhcnVzOg0KPj4gVGhlcmUgYXJlIG1hbnVmYWN0dXJlcnMg
dGhhdCB1c2UgcmVnaXN0ZXJzIGluZGV4ZWQgYnkgYWRkcmVzcy4gU29tZSBvZg0KPj4gdGhlbSBz
dXBwb3J0ICJyZWFkL3dyaXRlIGFueSByZWdpc3RlciIgb3Bjb2Rlcy4gUHJvdmlkZSBjb3JlIG1l
dGhvZHMgdGhhdA0KPj4gY2FuIGJlIHVzZWQgYnkgYWxsIG1hbnVmYWN0dXJlcnMuIFNQSSBOT1Ig
Y29udHJvbGxlciBvcHMgYXJlIGludGVudGlvbmFsbHkNCj4+IG5vdCBzdXBwb3J0ZWQgYXMgd2Ug
aW50ZW5kIHRvIG1vdmUgYWxsIHRoZSBTUEkgTk9SIGNvbnRyb2xsZXIgZHJpdmVycw0KPj4gdW5k
ZXIgdGhlIFNQSSBzdWJzeXN0ZW0uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1
cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4gVGVzdGVkLWJ5OiBUYWthaGlybyBL
dXdhbm8gPFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb20+DQo+PiBSZXZpZXdlZC1ieTogUHJh
dHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPj4gLS0tDQo+PiDCoGRyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggfMKgIDQgKysrKw0KPj4gwqAyIGZpbGVz
IGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gaW5kZXgg
MjgxZTNkMjVmNzRjLi5mMWFhMWUyZWE3YzkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IEBA
IC0zMDcsNiArMzA3LDQ3IEBAIHNzaXplX3Qgc3BpX25vcl93cml0ZV9kYXRhKHN0cnVjdCBzcGlf
bm9yICpub3IsDQo+PiBsb2ZmX3QgdG8sIHNpemVfdCBsZW4sDQo+PiDCoMKgwqDCoCByZXR1cm4g
bm9yLT5jb250cm9sbGVyX29wcy0+d3JpdGUobm9yLCB0bywgbGVuLCBidWYpOw0KPj4gwqB9DQo+
Pg0KPj4gKy8qKg0KPj4gKyAqIHNwaV9ub3JfcmVhZF9yZWcoKSAtIHJlYWQgcmVnaXN0ZXIgdG8g
Zmxhc2ggbWVtb3J5DQo+PiArICogQG5vcjrCoMKgwqDCoMKgwqDCoCBwb2ludGVyIHRvICdzdHJ1
Y3Qgc3BpX25vcicuDQo+PiArICogQG9wOsKgwqDCoMKgwqDCoMKgIFNQSSBtZW1vcnkgb3BlcmF0
aW9uLiBvcC0+ZGF0YS5idWYgbXVzdCBiZSBETUEtYWJsZS4NCj4+ICsgKiBAcHJvdG86wqDCoMKg
IFNQSSBwcm90b2NvbCB0byB1c2UgZm9yIHRoZSByZWdpc3RlciBvcGVyYXRpb24uDQo+PiArICoN
Cj4+ICsgKiBSZXR1cm46IHplcm8gb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZQ0KPj4gKyAq
Lw0KPj4gK2ludCBzcGlfbm9yX3JlYWRfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHN0cnVjdCBz
cGlfbWVtX29wICpvcCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBzcGlfbm9y
X3Byb3RvY29sIHByb3RvKQ0KPj4gK3sNCj4+ICvCoMKgwqAgaWYgKCFub3ItPnNwaW1lbSkNCj4+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7DQo+PiArDQo+PiArwqDCoMKgIHNw
aV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgb3AsIHByb3RvKTsNCj4+ICvCoMKgwqAgcmV0dXJu
IHNwaV9ub3Jfc3BpbWVtX2V4ZWNfb3Aobm9yLCBvcCk7DQo+PiArfQ0KPj4gKw0KPj4gKy8qKg0K
Pj4gKyAqIHNwaV9ub3Jfd3JpdGVfcmVnKCkgLSB3cml0ZSByZWdpc3RlciB0byBmbGFzaCBtZW1v
cnkNCj4+ICsgKiBAbm9yOsKgwqDCoMKgwqDCoMKgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9y
Jw0KPj4gKyAqIEBvcDrCoMKgwqDCoMKgwqDCoCBTUEkgbWVtb3J5IG9wZXJhdGlvbi4gb3AtPmRh
dGEuYnVmIG11c3QgYmUgRE1BLWFibGUuDQo+PiArICogQHByb3RvOsKgwqDCoCBTUEkgcHJvdG9j
b2wgdG8gdXNlIGZvciB0aGUgcmVnaXN0ZXIgb3BlcmF0aW9uLg0KPj4gKyAqDQo+PiArICogUmV0
dXJuOiB6ZXJvIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+ICsgKi8NCj4+ICtpbnQg
c3BpX25vcl93cml0ZV9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwgc3RydWN0IHNwaV9tZW1fb3Ag
Km9wLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gc3BpX25vcl9wcm90b2Nv
bCBwcm90bykNCj4+ICt7DQo+PiArwqDCoMKgIGludCByZXQ7DQo+PiArDQo+PiArwqDCoMKgIGlm
ICghbm9yLT5zcGltZW0pDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0K
Pj4gKw0KPj4gK8KgwqDCoCByZXQgPSBzcGlfbm9yX3dyaXRlX2VuYWJsZShub3IpOw0KPj4gK8Kg
wqDCoCBpZiAocmV0KQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiArwqDCoMKg
IHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgb3AsIHByb3RvKTsNCj4+ICvCoMKgwqAgcmV0
dXJuIHNwaV9ub3Jfc3BpbWVtX2V4ZWNfb3Aobm9yLCBvcCk7DQo+PiArfQ0KPj4gKw0KPj4gwqAv
KioNCj4+IMKgICogc3BpX25vcl93cml0ZV9lbmFibGUoKSAtIFNldCB3cml0ZSBlbmFibGUgbGF0
Y2ggd2l0aCBXcml0ZSBFbmFibGUgY29tbWFuZC4NCj4+IMKgICogQG5vcjrCoMKgwqAgcG9pbnRl
ciB0byAnc3RydWN0IHNwaV9ub3InLg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1u
b3IvY29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4+IGluZGV4IGY5NTIwNjFk
NWMyNC4uN2M3MDQ0NzU5NDZkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmgNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+PiBAQCAtNTU0LDYg
KzU1NCwxMCBAQCBzc2l6ZV90IHNwaV9ub3JfcmVhZF9kYXRhKHN0cnVjdCBzcGlfbm9yICpub3Is
DQo+PiBsb2ZmX3QgZnJvbSwgc2l6ZV90IGxlbiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdTggKmJ1Zik7DQo+PiDCoHNzaXplX3Qgc3BpX25vcl93cml0ZV9kYXRhKHN0cnVjdCBz
cGlfbm9yICpub3IsIGxvZmZfdCB0bywgc2l6ZV90IGxlbiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjb25zdCB1OCAqYnVmKTsNCj4+ICtpbnQgc3BpX25vcl9yZWFkX3JlZyhz
dHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVudW0gc3BpX25vcl9wcm90b2NvbCBwcm90byk7DQo+PiAraW50IHNw
aV9ub3Jfd3JpdGVfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHN0cnVjdCBzcGlfbWVtX29wICpv
cCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIHNwaV9ub3JfcHJvdG9jb2wg
cHJvdG8pOw0KPiANCj4gVGhlc2UgbG9vayByYXRoZXIgb2RkLiBJJ2QgZXhwZWN0IHRvIHNlZSBh
biBhZGRyZXNzIGFuZCBzdWNoIGZvcg0KPiBzdWNoIGEgInJhbmRvbSByZWdpc3RlciByZWFkL3dy
aXRlIi4gTG9va3MgbGlrZSB0aGVzZSBmdW5jdGlvbnMNCg0KVGhlcmUgYXJlIGF0IGxlYXN0IDYg
ZnVuY3Rpb24gcGFyYW1ldGVycyBpZiB3ZSB3YW50IHRvIGV4cGxpY2l0bHkgcGFzcyBmdW5jdGlv
bg0KYXJndW1lbnRzOiBwb2ludGVyIHRvIG5vciwgb3Bjb2RlLCBhZGRyLm5ieXRlcywgYWRkciwg
YnVmLm5ieXRlcywgYnVmLiBOb3QgdG8NCm1lbnRpb24gbmR1bW15IGZvciByZWFkcy4gQSBiaXQg
dG9vIG11Y2ggZm9yIG1lLCBzbyBJIHByZWZlcnJlZCBwYXNzaW5nIHNwaV9tZW1fb3ANCmRpcmVj
dGx5Lg0KDQo+IGRvbid0IGRvIG11Y2ggZXhjZXB0IGNhbGxpbmcgc3BpX25vcl9zcGltZW1fc2V0
dXBfb3AoKSBhbmQNCj4gZXhlY19vcCgpIGFuZCBkb24ndCBoYXZlIGFueXRoaW5nIHRvIGRvIHdp
dGggcmVnaXN0ZXIgYWNjZXNzDQo+IChleGNlcHQgbWF5YmUgZm9yIHRoZSB3cml0ZSBlbmFibGUp
LiBDYW4ndCB3ZSBoYXZlIGEgYml0IG1vcmUNCj4gc29waGlzdGljYXRlZCBpbnRlcmZhY2UgaW4g
dGhlIGNvcmU/IFNvbWV0aGluZyB0aGF0IGNhbGxzIGludG8NCj4gdGhlIGZsYXNoIGRyaXZlciB0
byBhc3NlbWJsZSB0aGUgc3BpX21lbV9vcCBhdXRvbWF0aWNhbGx5PyBBc3N1bWluZw0KDQpMb29r
cyBsaWtzIHNvbWUgcGluZy1wb25nLCBwYXNzaW5nIHNwaV9tZW1fb3AgZGlyZWN0bHkgaXMgc3Ry
YWlnaHQgZm9yd2FyZA0KYW5kIGNhbiBhZGRyZXNzIGFsbCBtYW51ZmFjdHVyZXIgdmFyaWV0aWVz
Lg0KDQpTbyBJIHByZWZlciBrZWVwaW5nIHRoZXNlIGdlbmVyaWMgbWV0aG9kcywgaXQgd2lsbCBy
ZWR1Y2UgY29kZSBkdXBsaWNhdGlvbi4NCg0KVGhhbmtzLA0KdGENCg==
