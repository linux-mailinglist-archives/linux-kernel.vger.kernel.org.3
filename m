Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D824C46A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbiBYNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiBYNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:35:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A8C1DB3CC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645796113; x=1677332113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hBZaWVlfL8vnJAup42vuxZndGzmnXYoJlPHFqst47/I=;
  b=KCsAq9Jm+jkmSvkXVvud8OOAMlNUwyIlqP4lAvQPfaEoTjYKOT2LvwVw
   4f1BCCqVnDTwQc+/RDRjndnuXH0wGVX5TzKQdIeeIpTp/KPoSI2pTB9kQ
   pQWT75ZGS1KYbiYZxWehW6Joby2OvVH36Glhp2BcT897uRllD6vkdbUKO
   Dta/6ddvvabXjGP283b5Fjv+ZC05kmENywhSH8npdQa79xm9z4I0Aj5fW
   bzm8fqC/ZcgSdFVbRwOyklijn2wDBa5VAVpnYe7CKbz9OsrD+a549nji2
   ESJ15dX+DiKwgtd4fIi3kGN2eHHMdaOY1z+Lz+kUudYP5vGJL5XEtIcQX
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="163648923"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 06:35:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 06:35:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 06:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKq65q8pKRI91QW7u6gNJYcwjrhJFKihiJ6Ip8Awz3ieEiMUr8XHF+kMXcFB0IEhRzmKUQWp/w4S93TOGIU44cG+H44RzVGh1pbOALdnDx5IFjKuNXr4YxTnhGItZvXgpLNJ0SWtX/4VGfeKgXO1eM3gFlqZZmPTmnkIMgQNqxUSGc8Ex/UQw3r/4UGzo/ykKXZIuOiW9KwXcDilcCTxv9swIFsMMS/B3XoEd0Pt10xyz3/HnH2oP5eBX16nQlWvBmn5nULwJGUuOWYVFUkiBn11pcRXSOtk8CFf1uCFnSF5D9tdTZoeMR170kf0TUZX1nYPk+N1bTeRzctSlx8Wdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBZaWVlfL8vnJAup42vuxZndGzmnXYoJlPHFqst47/I=;
 b=llte74OHAEh+5zHPwFxig6fvMMakJhXimx+SgeA0iSBefZJcgJC/8+fomRsULnSEj/BDkBUqlTZL9yi8ian7XlB4XSxK83P7xO68W5fmwfMWySF7fU1fWdMmIwuesv6X4rhUith7iy1EGNmbN8DUhHPdvuLLUzY+lvpuvgNRpqEQ7nZscQ3RijPJChfWNcBoXIzybwaEMyPDG6JPYldD8lmt3uappLAho4lqT9dCjZo+y7Gen9EGWnFmTVtS/QLFIvwyHVQLR+Nk8YhzmoA3+oxSMs23zuHQxR2oLrdswLFhzzfpc3h4fkvmIrqyrmffaM91yfNPGiROZuKay1YHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBZaWVlfL8vnJAup42vuxZndGzmnXYoJlPHFqst47/I=;
 b=cdmcjMZKqJ/bz0pTDLiOWewIjb1pChxOyWrt6s35rYyyuWGGcLXoAasE2mIN5YgC1YW3dNs66JstxugIfiPm6SuwlCgU44xSvFYHUxE+VW7/nIk2YxWevGMBCPxcXsgZ7vWYXa2IRxWqJigKEqbhrGyA3tll4X2VhlUwpXvpepo=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 13:35:06 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 13:35:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 11/32] mtd: spi-nor: micron-st: unify function names
Thread-Topic: [PATCH v5 11/32] mtd: spi-nor: micron-st: unify function names
Thread-Index: AQHYKkx/rOWxu2o8UkShyaiFUyzsrQ==
Date:   Fri, 25 Feb 2022 13:35:05 +0000
Message-ID: <5c2ba6a0-a06b-d4dd-d503-1ddfa76f9be4@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-12-michael@walle.cc>
In-Reply-To: <20220223134358.1914798-12-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11da84f0-fb6f-459f-4597-08d9f863a272
x-ms-traffictypediagnostic: PH0PR11MB4822:EE_
x-microsoft-antispam-prvs: <PH0PR11MB4822EBF49DE3CE9CACD3D103F03E9@PH0PR11MB4822.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLKhbJ2Xh+o9FBT/rjKo1NDpgrNiq0uJsFr7k137315cw6UaATrDOMlfEjNquixDMvTjB7oWdNAVBHUrLG+7dWzEmCzTpyqEsLr4AmLCWwmfbEq4B8RH/w1gPNKpAYEsGKD5p87SZRjNJPwOWk2kYRN5X/CZ4mHtu3PgJrRE+DIHmU4q1cWbaR4+mhTkgG7GyT83lYTbJKxn3kLpWnAZPmSQQdi/BO9yQ/QfiMyWIW5uu6tIA8cB4gvkWXQmVg3FYRabYdZIG6qyC/bmQDeS0ewqQ+ImMJvndHMelGWh2kL8BCZ/O6SdxhEWZDRxigKC8nGEDHIu/QBp+WB262I5Lyt05FPksH1v2STdswRzt+XciQQcKQnpaFiPRuK+xgHPNdWLjWcVFdOxqXtjSs3EcccfMvCq8roppOYe5/ncHFQmPkN4eQH15x8pMvih668H5k+wy5OjQYM3u8x0EBR5b2MSQkGVlDRxQbgcnKCokgU/O1prFg2ok2USA2N7sHqzKArGSa3Sms76D7VPZsm7ja9gycVZfK+3jcO3tiEhAMAGJkkjIfQvQshlpGoftqOPH8JHxJ/JdUuSzx5Zya2AM0340pNdE1qlR+WsfeXo6QUD0rtj/0I2scKyT4qD0epUDmOpDfAe1UsITcHiMsdyXNPFXJ5UvdMeCjczZ2keujwo3n4xRU8Omtv2Q4wJ12yCzhRDad69/nhizfVfMhQbgrG9AHVEXEDuan8GTT6hpNS/J4oHK4e9E1gWZs92AFcTpVxNDQuVQgqUt2ou6kGOTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(54906003)(110136005)(31686004)(316002)(6486002)(38070700005)(26005)(31696002)(86362001)(36756003)(8676002)(6512007)(91956017)(66946007)(4326008)(71200400001)(53546011)(76116006)(64756008)(83380400001)(66556008)(122000001)(2906002)(66476007)(66446008)(6506007)(38100700002)(508600001)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZ5MUhXZ0x2NHhsejdZNlhPbW5HY0pHTkUzbFVpRUloVEhOejlZczFqbjJz?=
 =?utf-8?B?VUFOWlp2U3VMZEVudW5TcTRhYmtNSG1pTUpJOXZEbVZXSk9qMGpxWmhqcWhm?=
 =?utf-8?B?MzgyVlN4VVAyaDV2eVBZSkUyUmlXbzl1WE9JTzV5REpYalRnQ0pFMVFHYTlq?=
 =?utf-8?B?dTYxTkhkdktQUmdUbXZXZ3lic291ZjBIKytzS1U1VTl0YXo5MEZ6NUd2cUd6?=
 =?utf-8?B?T1lhaExabU9ENnZQTGlEU2NnbTdEL2g1VmJpVGhhemFTQzBGc21iREVPU25E?=
 =?utf-8?B?S0JvdWFoT3dEUHBlWElSMEU0WkM2Y0tNMW5RbUhPL0YwTkptYkFlQ3h3OHJk?=
 =?utf-8?B?SGJhV1lreHpVaVIxZysrZHpCaFBnVlBwNXVMelZkUVkzUzhZRWNjYWZDcWhE?=
 =?utf-8?B?WmZwekFhOXAwQ2E0QzgvVFlXZjlLbUtFWjcrbmE2ZzQ4TTdBd2NXZmVjSFV5?=
 =?utf-8?B?Z3JMS2ZuTVRzZmVoMitySUxBeVMrbEx1akNGWk4zZWNsTWNDaUZMSDBmd3Vp?=
 =?utf-8?B?L1FFK3dzdUlhazVJNjVCd0JjT1gvakV3RVB4UHF6TGJnNEdoSklnUEJKdkgx?=
 =?utf-8?B?T20vQ2dVWDZBcE9PQnFReFEwenl5WURvOXdFdzgvaHc4NDFwY0xaakRWQ2xi?=
 =?utf-8?B?bXdjTFp1MXpJWGlFMGZWb2FCcm1qM2k3Z2xNS05NQWpMb3NNY2E5aGRqU3lP?=
 =?utf-8?B?cEV6a1UyMGg0akp2SkJlb2FobGwwL1E2SjNJb0FpeDVYRWR5NVd4S3NuUlFh?=
 =?utf-8?B?ZkVOWFZvTEYveUwraGZlY29JYWFIT3orT2VwMGVHVU1kRGRFM2lHL2pZM0Fw?=
 =?utf-8?B?Z3lWYWlsdTlzQlhmVEdJQzdhV2tzdzNjUDAya1hVS3p1dHhGc084NEkyRWJm?=
 =?utf-8?B?dXIxb1VKMkE5bzhCaXhTSksvRnZ2bDJmL1JzbmtXR3lSMk1MZ2pNWHo0eDUr?=
 =?utf-8?B?S1R5OG1ud1RrcDJ3bUlFNEJqSnFsTUx2SHoxMVYyZDh6Z3g0YjlKSlBpd0Qw?=
 =?utf-8?B?dEwyeVdwTSt6RUJsa0l3K3ovTHJzbFJzbmFoanhOeEE5UnNJNWh4TVM5akxt?=
 =?utf-8?B?aEVJc3g2WDNESFpoMWluK1ZiZHhjRUxZbUYxY2RqUlZZME9JUEcrcWkwT2I5?=
 =?utf-8?B?eUFESklIUVJnencrUENCaXZnbG8yQ0ZNNWJkVSt5eFNhZURsMXRPWlZzY0pM?=
 =?utf-8?B?NThmTXIrbXY5aEZvSUFjK3pIRzBjWithYVh1NEFwSHg1VkhRWVVIbkREL0cx?=
 =?utf-8?B?MHV1QXdJSE5JVGxZendpRVFJR3J4TEQ5Yys0TFkvTHJscWdrRUY0c1BMN1RM?=
 =?utf-8?B?TWF0ODRGNUgySzh5ZmhweEdCWkM1eVJiL01ERUZtYjZXaFNDK3pyVkVtSDRW?=
 =?utf-8?B?MWtwN0ttTkhmZHpZRWlqTmF6eGJEUWRGZWFWOGpveGRqMXg2bGN2L01zdHJm?=
 =?utf-8?B?NVJNZGVrQzhBbG5vWUVNeVlhdWJOMWgrZXZRZ3BUUnNsb3VQcm5vWDY2bE12?=
 =?utf-8?B?UC82NlE3MER3MG1LcjNFUmhMS1gvZlZBRFZZV2Q3MzhEM2MyUC9tOWRYOGNK?=
 =?utf-8?B?b001eWZzZy80cEQvczFaOWpCc2tXU3dkTFJobU1UdS9abXlpV2RjeFZnUkVP?=
 =?utf-8?B?WTNzM25kSHZWQ3drMUh1QnpqdFg4TFJ4WHU0ci9XamV0QzZHSGdhcGhMZ1RT?=
 =?utf-8?B?TFM1eTR6NkZobGl4L1RCYkM5TUkyQU1OZ1pGWEJDZGFkNnBYQjZBQko4bkxk?=
 =?utf-8?B?bS9XNGh5RzNwMnRSbUwzYnFDcWRmR1FscEJWVUlIMnBlQUZtMm10ditYV0ox?=
 =?utf-8?B?NWkwVEdpcVJtL3ErQlVyNzgxRmwzdUIwTUpDb01IeHJITk9qOEZBbWNTd2x5?=
 =?utf-8?B?VC8xRHVRKzMvN295QktRSW5NV2t3WWFrbXdDbFJIMWtZV2E3ZFRXZWZBajV6?=
 =?utf-8?B?Zk53ZzFJNGhIMlMxd3dKb2IxTEMzempUUW0wYlZIa08vZjZQT1VpMGlHMHI5?=
 =?utf-8?B?QVQvRXRzWnlsOHdwZDlvMTN6WFR0eXFaa2pwMDFFandpRFM1a3RXZDR3cWgx?=
 =?utf-8?B?VnY2NzVYbDFaSEhzYUxsT0x6RDJCV0dVSXpLTStLcVZGNjJmdUFIaGNrbWo2?=
 =?utf-8?B?NkF4djI3bzFSRXcvSzRsSWRPdGd5bEdNaFNENWFheDRuQjdUMFJ2NVVTQzBl?=
 =?utf-8?B?eUwvVTEvSTljMmlMd1dlZ0RZU1lZb1NWemdWeUN4dVA3QXRDcFdOanBtZGFT?=
 =?utf-8?B?elp2Uyt2VEt0UXV3RzlzendRL0RBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F661B0AB01A7943B5E1B254492899E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11da84f0-fb6f-459f-4597-08d9f863a272
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 13:35:05.9377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hnz4NWWvjIJ5CW+q4jfmWwJECNFRjYuMgZ5NFcrmhd6tQH0NQq+kXd1NwPo8kToOswBeVA9eVpJ9wRSWjMs8FzHBjg5D7ZMybFovjny9qoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMy8yMiAxNTo0MywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUbyBhdm9pZCBuYW1lIGNsYXNoZXMgdW5pZnkgYWxs
IHRoZSBmdW5jdGlvbiBhbmQgc3RhdGljIG9iamVjdCBuYW1lcyBhbmQNCj4gdXNlIG9uZSBvZiB0
aGUgZm9sbG93aW5nIHByZWZpeGVzIHdoaWNoIHNob3VsZCBiZSBzdWZmaWNpZW50bHkgdW5pcXVl
Og0KPiAgLSA8dmVuZG9yPl9ub3JfDQo+ICAtIDxmbGFzaF9mYW1pbHk+X25vcl8NCj4gIC0gPGZs
YXNoX3BhcnQ+Xw0KPiANCj4gVGhlcmUgYXJlIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IEFja2Vk
LWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9taWNyb24tc3QuYyB8IDM0ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMgYi9k
cml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+IGluZGV4IGJiOTViMWFhYmY3NC4uN2E2
OGYyYWQzZWExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5j
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4gQEAgLTE3LDcgKzE3
LDcgQEANCj4gICNkZWZpbmUgU1BJTk9SX01UX09DVF9EVFIgICAgICAweGU3ICAgIC8qIEVuYWJs
ZSBPY3RhbCBEVFIuICovDQo+ICAjZGVmaW5lIFNQSU5PUl9NVF9FWFNQSSAgICAgICAgICAgICAg
ICAweGZmICAgIC8qIEVuYWJsZSBFeHRlbmRlZCBTUEkgKGRlZmF1bHQpICovDQo+IA0KPiAtc3Rh
dGljIGludCBzcGlfbm9yX21pY3Jvbl9vY3RhbF9kdHJfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpu
b3IsIGJvb2wgZW5hYmxlKQ0KPiArc3RhdGljIGludCBtaWNyb25fc3Rfbm9yX29jdGFsX2R0cl9l
bmFibGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+ICB7DQo+ICAgICAgICAg
c3RydWN0IHNwaV9tZW1fb3Agb3A7DQo+ICAgICAgICAgdTggKmJ1ZiA9IG5vci0+Ym91bmNlYnVm
Ow0KPiBAQCAtMTAyLDcgKzEwMiw3IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9taWNyb25fb2N0YWxf
ZHRyX2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBib29sIGVuYWJsZSkNCj4gDQo+ICBzdGF0
aWMgdm9pZCBtdDM1eHU1MTJhYmFfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+
ICB7DQo+IC0gICAgICAgbm9yLT5wYXJhbXMtPm9jdGFsX2R0cl9lbmFibGUgPSBzcGlfbm9yX21p
Y3Jvbl9vY3RhbF9kdHJfZW5hYmxlOw0KPiArICAgICAgIG5vci0+cGFyYW1zLT5vY3RhbF9kdHJf
ZW5hYmxlID0gbWljcm9uX3N0X25vcl9vY3RhbF9kdHJfZW5hYmxlOw0KPiAgfQ0KPiANCj4gIHN0
YXRpYyB2b2lkIG10MzV4dTUxMmFiYV9wb3N0X3NmZHBfZml4dXAoc3RydWN0IHNwaV9ub3IgKm5v
cikNCj4gQEAgLTEzMCw3ICsxMzAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9ub3JfZml4
dXBzIG10MzV4dTUxMmFiYV9maXh1cHMgPSB7DQo+ICAgICAgICAgLnBvc3Rfc2ZkcCA9IG10MzV4
dTUxMmFiYV9wb3N0X3NmZHBfZml4dXAsDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyBjb25zdCBzdHJ1
Y3QgZmxhc2hfaW5mbyBtaWNyb25fcGFydHNbXSA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
Zmxhc2hfaW5mbyBtaWNyb25fbm9yX3BhcnRzW10gPSB7DQo+ICAgICAgICAgeyAibXQzNXh1NTEy
YWJhIiwgSU5GTygweDJjNWIxYSwgMCwgMTI4ICogMTAyNCwgNTEyKQ0KPiAgICAgICAgICAgICAg
ICAgRkxBR1MoVVNFX0ZTUikNCj4gICAgICAgICAgICAgICAgIE5PX1NGRFBfRkxBR1MoU0VDVF80
SyB8IFNQSV9OT1JfT0NUQUxfUkVBRCB8DQo+IEBAIC0xNDMsNyArMTQzLDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBmbGFzaF9pbmZvIG1pY3Jvbl9wYXJ0c1tdID0gew0KPiAgICAgICAgICAgICAg
ICAgRklYVVBfRkxBR1MoU1BJX05PUl80Ql9PUENPREVTKSB9LA0KPiAgfTsNCj4gDQo+IC1zdGF0
aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3RfcGFydHNbXSA9IHsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgZmxhc2hfaW5mbyBzdF9ub3JfcGFydHNbXSA9IHsNCj4gICAgICAgICB7ICJuMjVx
MDE2YSIsICAgIElORk8oMHgyMGJiMTUsIDAsIDY0ICogMTAyNCwgICAzMikNCj4gICAgICAgICAg
ICAgICAgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiAg
ICAgICAgIHsgIm4yNXEwMzIiLCAgICAgSU5GTygweDIwYmExNiwgMCwgNjQgKiAxMDI0LCAgIDY0
KQ0KPiBAQCAtMjUwLDE1ICsyNTAsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZv
IHN0X3BhcnRzW10gPSB7DQo+ICB9Ow0KPiANCj4gIC8qKg0KPiAtICogc3RfbWljcm9uX3NldF80
Ynl0ZV9hZGRyX21vZGUoKSAtIFNldCA0LWJ5dGUgYWRkcmVzcyBtb2RlIGZvciBTVCBhbmQgTWlj
cm9uDQo+IC0gKiBmbGFzaGVzLg0KPiArICogbWljcm9uX3N0X25vcl9zZXRfNGJ5dGVfYWRkcl9t
b2RlKCkgLSBTZXQgNC1ieXRlIGFkZHJlc3MgbW9kZSBmb3IgU1QgYW5kDQo+ICsgKiBNaWNyb24g
Zmxhc2hlcy4NCj4gICAqIEBub3I6ICAgICAgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9yJy4N
Cj4gICAqIEBlbmFibGU6ICAgIHRydWUgdG8gZW50ZXIgdGhlIDQtYnl0ZSBhZGRyZXNzIG1vZGUs
IGZhbHNlIHRvIGV4aXQgdGhlIDQtYnl0ZQ0KPiAgICogICAgICAgICAgICAgYWRkcmVzcyBtb2Rl
Lg0KPiAgICoNCj4gICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAtZXJybm8gb3RoZXJ3aXNlLg0K
PiAgICovDQo+IC1zdGF0aWMgaW50IHN0X21pY3Jvbl9zZXRfNGJ5dGVfYWRkcl9tb2RlKHN0cnVj
dCBzcGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKQ0KPiArc3RhdGljIGludCBtaWNyb25fc3Rfbm9y
X3NldF80Ynl0ZV9hZGRyX21vZGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+
ICB7DQo+ICAgICAgICAgaW50IHJldDsNCj4gDQo+IEBAIC0yNzMsMjggKzI3MywyOCBAQCBzdGF0
aWMgaW50IHN0X21pY3Jvbl9zZXRfNGJ5dGVfYWRkcl9tb2RlKHN0cnVjdCBzcGlfbm9yICpub3Is
IGJvb2wgZW5hYmxlKQ0KPiAgICAgICAgIHJldHVybiBzcGlfbm9yX3dyaXRlX2Rpc2FibGUobm9y
KTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgdm9pZCBtaWNyb25fc3RfZGVmYXVsdF9pbml0KHN0cnVj
dCBzcGlfbm9yICpub3IpDQo+ICtzdGF0aWMgdm9pZCBtaWNyb25fc3Rfbm9yX2RlZmF1bHRfaW5p
dChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgew0KPiAgICAgICAgIG5vci0+ZmxhZ3MgfD0gU05P
Ul9GX0hBU19MT0NLOw0KPiAgICAgICAgIG5vci0+ZmxhZ3MgJj0gflNOT1JfRl9IQVNfMTZCSVRf
U1I7DQo+ICAgICAgICAgbm9yLT5wYXJhbXMtPnF1YWRfZW5hYmxlID0gTlVMTDsNCj4gLSAgICAg
ICBub3ItPnBhcmFtcy0+c2V0XzRieXRlX2FkZHJfbW9kZSA9IHN0X21pY3Jvbl9zZXRfNGJ5dGVf
YWRkcl9tb2RlOw0KPiArICAgICAgIG5vci0+cGFyYW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2RlID0g
bWljcm9uX3N0X25vcl9zZXRfNGJ5dGVfYWRkcl9tb2RlOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgbWljcm9uX3N0X2ZpeHVwcyA9IHsNCj4gLSAgICAg
ICAuZGVmYXVsdF9pbml0ID0gbWljcm9uX3N0X2RlZmF1bHRfaW5pdCwNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgbWljcm9uX3N0X25vcl9maXh1cHMgPSB7DQo+ICsgICAg
ICAgLmRlZmF1bHRfaW5pdCA9IG1pY3Jvbl9zdF9ub3JfZGVmYXVsdF9pbml0LA0KPiAgfTsNCj4g
DQo+ICBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9tYW51ZmFjdHVyZXIgc3BpX25vcl9taWNyb24gPSB7
DQo+ICAgICAgICAgLm5hbWUgPSAibWljcm9uIiwNCj4gLSAgICAgICAucGFydHMgPSBtaWNyb25f
cGFydHMsDQo+IC0gICAgICAgLm5wYXJ0cyA9IEFSUkFZX1NJWkUobWljcm9uX3BhcnRzKSwNCj4g
LSAgICAgICAuZml4dXBzID0gJm1pY3Jvbl9zdF9maXh1cHMsDQo+ICsgICAgICAgLnBhcnRzID0g
bWljcm9uX25vcl9wYXJ0cywNCj4gKyAgICAgICAubnBhcnRzID0gQVJSQVlfU0laRShtaWNyb25f
bm9yX3BhcnRzKSwNCj4gKyAgICAgICAuZml4dXBzID0gJm1pY3Jvbl9zdF9ub3JfZml4dXBzLA0K
PiAgfTsNCj4gDQo+ICBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9tYW51ZmFjdHVyZXIgc3BpX25vcl9z
dCA9IHsNCj4gICAgICAgICAubmFtZSA9ICJzdCIsDQo+IC0gICAgICAgLnBhcnRzID0gc3RfcGFy
dHMsDQo+IC0gICAgICAgLm5wYXJ0cyA9IEFSUkFZX1NJWkUoc3RfcGFydHMpLA0KPiAtICAgICAg
IC5maXh1cHMgPSAmbWljcm9uX3N0X2ZpeHVwcywNCj4gKyAgICAgICAucGFydHMgPSBzdF9ub3Jf
cGFydHMsDQoNCnlvdSBoYXZlIHN0X25vciBoZXJlDQoNCj4gKyAgICAgICAubnBhcnRzID0gQVJS
QVlfU0laRShzdF9ub3JfcGFydHMpLA0KPiArICAgICAgIC5maXh1cHMgPSAmbWljcm9uX3N0X25v
cl9maXh1cHMsDQoNCmFuZCBoZXJlIG1pY3Jvbl9zdCwgaXQgY29uZnVzZXMgbWUuDQoNCkFueSBp
ZGVhIHdoZW4gc2hvdWxkIHdlIHVzZSBqdXN0IHN0LCBvciBqdXN0IG1pY3JvbiBvciBtaWNyb25f
c3Q/DQoNCkNoZWVycywNCnRhDQoNCg==
