Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E5565792
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiGDNmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiGDNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:42:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4510B4;
        Mon,  4 Jul 2022 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656942168; x=1688478168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5a1qK9TDrzwpdsrpSCSuZM+Oop1ScI1zXPbYqCMbCb0=;
  b=hSIFHHtSjjL4chEFG2Qw9O56uR75g1nHgS8yhQikxNY3lrgri4pmL21N
   nzt2WopofSFJVQldHRep/wno9WvUX0dSFvnrXzgJGTe4ndCDcJki8TfzN
   Ed3hp/qkDmUFfsnhxsmkblICmkbuAAnPAQuFgdAiy5GnI5WmYvYPkX734
   z6v3cZUXrOpt4J8F6x8Z+huNjiCRcbgV9nbtkAh5izOALXh2pkjd+YJlr
   aiqTiaqpBM/34518ZqMNFiuoiTMaHKAYrNqlFqaYRRDHVUnwRy9Ns2Zvg
   Nn3Ikc91hlJSKFf5SDCrNQ1NZCGlElA0WpKWVQYrdgKphpNrNiqq1N5wh
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="102928403"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 06:42:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 06:42:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 06:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2PQREkVK6NGiTNS9hs20yTbzZFIvMolTfmb2IVrFeaxhTkX4itG6G7FBgJreYGc3rvGtedU9HH7XnzdHcvGEzaWkAwTMQAKqtsTHw0UD30nPzcBT3AT+Bh+C8Nfgg5eOyqSJMNWA1gpkQEsG67LlNF++5U52KHVLoDkxT+NSAOEDSZa/Q+uZ3M1yEOT55SMxstfoUNRlp0I/NBIMbcuin+3p2ibYZZBCm7fkUZg7NqQl8rzSS83rb9Z1CfSkqtLvpG7hWvQvXAMqf85H17mJ8g8tkaPbMQSsWAQ60u/gndUJsLZS7O3DcD8VM6I8aq023GWJ63moXG+DUc6AonRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a1qK9TDrzwpdsrpSCSuZM+Oop1ScI1zXPbYqCMbCb0=;
 b=Pc2y9v+XwIUenhlmBK1Xto5y3EDzs/IaMDMtlvbp7Bi7eNTASDckyOFfoZ5kxGg3ArIUk1MREwM4edTTVkmX396VD3mZmmJfNgq8RUSUyvNWQskzmH3s0VIlPNqvB0U+waTXWscwlNCUsm5gfLlw0JV9QvqMz0oVNOHn77AXlhvFfjvUrx9ItZ+iNoaOviZx7LttLf0XLU2pKeP9nqDh2GSzztlY9M3zQH8CKEZ228hiIB/koAuMmnw3L17HppuDKrP8+FAEl01Hlcn5ytMqTJila37OeJnxLKf+L72c0pEBFE5WTD4Qx1S1DiR3Pu6bhhm1WKyhCUmOj5a/EeCFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a1qK9TDrzwpdsrpSCSuZM+Oop1ScI1zXPbYqCMbCb0=;
 b=JpGnWTf3gznv9+YHT61+NGSydbWrNYGmn6/0s+aS5a4nrnKKUhLXkxACNnVdIw50PmVKXfeFjgFfeftWt4ws5tOefe6AvSz2FaLo6oJWFUTuCnOqBVKdKwjYFbyXSvlwDc8LNRX3V1YE3tVcQ24M3SEd4BC+OnOixE3hZfqQYCs=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SN6PR11MB3070.namprd11.prod.outlook.com (2603:10b6:805:d4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Mon, 4 Jul 2022 13:42:40 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:42:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Topic: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Index: AQHYj6lyQJ8vjFq+GEKvMgbTaAY2p61uOIeA
Date:   Mon, 4 Jul 2022 13:42:40 +0000
Message-ID: <cb7c3e0d-07c4-fab3-8e44-8716f8faf1bb@microchip.com>
References: <20220704083143.56150-1-sergiu.moga@microchip.com>
 <7fc3b50b-c9fc-b1b5-ba84-752b2e3da7d7@microchip.com>
In-Reply-To: <7fc3b50b-c9fc-b1b5-ba84-752b2e3da7d7@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b48f5b7-87dc-4d2b-4d5f-08da5dc310ae
x-ms-traffictypediagnostic: SN6PR11MB3070:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lca+RSpt4KavcjDXBbfo0nl/tq8gVSnvAaGqtPq6SknUHYpF0qbhUfnvy8G5G3iPWltLJ5RXy2xHvvDQzv5rWNvmw+05LuTKC+Hh7bZiawsPIiLNA0dQqNtFUScdW9ac8T0ATR2HTrLf+iw7TQ4AxOF2RNfYHFz5qoIJXlcf4CdYGKzqESRal+qnMFVuFGIqzJeWI+SGYC2sVWZ6lP4apwF5PQ0s3pN7rdon9SdU1M1WL1t2gtAf4Cc+lgh0M8AxasPytLIoj54kImHaumwrNjhWcuz6X817/nxTkJfqVSP6FDeiAQm4uR3dTnOIVDivXIk757ErWjHUBneHlAYDSLSc9rzvQ/785seTshDzn0rPcJm8xLY4VUrjJFMdFQen+O/6J2abL55yHpcggDmhfEU1u3iFyrRCuHzcV/g7/RXg4fbL/eFV8OIGZM7GhSkGzjr9JQBYJLZcYIO1IlTphHuaR651Ces2EedMHcu/2TTsBAJxS2WD9Wra2TkG4IPJeMef05kM1QSYaBZQkbRx/K3ay6EJUMspJzv0oNPoi04i5gZaUn4ai06q6Ebb9AVfm6Ltgr1SA9chvfgyJn85Zok9AwP5wtn5w1QyCm2pMQzkL2g0MmxC4n4ORKmIOO/e1/94nCQYLE+o3OfpcbQrQ6c4T984zf5DH5k59Ze/eEcBXgLM/O1IJcrCbMQ8J1bxZTIWsshimXQjEtdaUyNhiv5S/GZCCM1iHP1e0iTFwJQkIpxkgOVh8f6Bo+rwSYtVRF+QqYJG4mE8s1jxmMtaWaaRC43OxA6f8zIj7OCIrTb+PXk0IdMuIVCgc7smuJJPVD3VSjATLFGhSD2vEH0+9EKYNRfNif6C4tpCU6f9DgVJ+s28zj2EmMM+2vY7Qe4W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(376002)(366004)(38100700002)(2616005)(66946007)(4326008)(66476007)(64756008)(66446008)(66556008)(76116006)(8676002)(6486002)(122000001)(478600001)(38070700005)(6636002)(71200400001)(110136005)(91956017)(54906003)(6512007)(53546011)(26005)(316002)(83380400001)(86362001)(31696002)(186003)(8936002)(2906002)(4744005)(41300700001)(31686004)(36756003)(5660300002)(107886003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S290QjBGYVdUT1h1WkZnRWpUb29qbDJ2NHZBN20wemRpRWlVOSsrbE9pRlhr?=
 =?utf-8?B?MmNnNiszNFo0QXpNdWJHUUl4NlhiMm80am1IcjB3RnFXZkcrMHFZYkV1Qzls?=
 =?utf-8?B?b0ttR0EwSlFudFR3UWJHM1B5Ri9nNUxoVXN1bXl1cEVWa2xjSFV3Vi9FNitJ?=
 =?utf-8?B?NGdPRU9pRG5kMXFueEY0OTNBYnNLUGF0SXcrNkJuUnFWODFQYUo4Unhack1E?=
 =?utf-8?B?aU9WY3poSnRFTkxPYzBoa0VNQ0s5YnpqOUlVV3E4UHM3bWU0eGZsUzdGM1Jr?=
 =?utf-8?B?VnlWcWlYL2J1bzQ4eS95UkIwUVk1TnUySlhycjZOdVpEY21MWTkweFF1R2cx?=
 =?utf-8?B?aitJNmNpQkplR0pUb1liVVBvR01ndXdjMjE1TlN1aSthbFZKanRKVCtxNlVl?=
 =?utf-8?B?S1lyRFgrZmZ6Y3YvQSt6U3ovQnVhT1N4MHphQWFZRFdyUTRQOExJL2hvU2ZL?=
 =?utf-8?B?Vzh3bUxOK0FVRHNqUTRIOVk5QUw3WXZSMTZ3MFVEaExnRGVRTTlOUkVMM2JQ?=
 =?utf-8?B?cm1sTkhMeHpSQVdXMzBHNDJ2aU1odUdvOHVhYllkQVYwQXdJQTZMNmhzNW1v?=
 =?utf-8?B?bG9yWWUxanpuSW9zelZGNktnM3U4by96UkJGdEFsazJONDZLTUx4YXZWRktI?=
 =?utf-8?B?dTRqSWJNMDVEVWdlOXlHMDdIdW1nMWlwZGp6cFlSU0RodHZxL0I5eW5ZVjhw?=
 =?utf-8?B?cVlzc24yK042RUx0cHM3dmRwNmtNTmo2VHJEbFk1a2lhc1NVYUMybXlYbU52?=
 =?utf-8?B?RjZuaFN4SXMvSDFMSGhDSDdMWWxIZS9DbENwRERPYUY5ZHBob1JLU1RLRDJZ?=
 =?utf-8?B?eFAwV01RK2psWnV1Y2dpZExGWGtGZ3NTZFlTMzk5dTc2alVwOHpqZTBGWFh0?=
 =?utf-8?B?K1J6cmlValFZTFBVeEFwQk4rL3dDbDJZWkNBZkRkMjZHNUg2UTc4eVhIVXZI?=
 =?utf-8?B?T3JqVk5JLzJzK1JUTmdCbEhBcGoxc3NzTTBOaGI3Vm52ak1Ta3ZsbTFodGNC?=
 =?utf-8?B?VjAvUnVCTHlncmlkVi9nRUlHSVRkTzZWc3NSY2swU0JTcG0vL3NveWNucC96?=
 =?utf-8?B?REVPRnJmQXJLQzloazFEUzFiY2l2LytZR3JLenFBSmlHQ1NwcDVsVFp3MENh?=
 =?utf-8?B?d21nSGl0WjJESGhSb0VnZFdUN0k4dWJFZWZyRkxHUkJwaDdjNllxbU9mUjlo?=
 =?utf-8?B?N1dGZ3lyYmNpcE5UWkFLdDRTc3Q3OUFjR2V4MTFjdzRoamlYSkdjRG1HTUh0?=
 =?utf-8?B?ZmpjV21MTFpRRWhDaXlyUGJ6UFBKM0hyVVA4MmpZRVIyUzQ1MEtJYkJlMCs5?=
 =?utf-8?B?SGdVQ3FnckpDemJaZ2ltWk9STXFRbm40REVicnprVmZBNW4rY2djZUtVK01P?=
 =?utf-8?B?d2JLdG9QcldSU2I0MVIwNGtxM1FZK2hBNUtnU3FiOGhjNDBoREdsU2pxYjF6?=
 =?utf-8?B?cXo2OXFNalY3TEpIODhhK1huckRCdERJbG5GeDl1dnhKYS9Td3ZkVDhnNEZL?=
 =?utf-8?B?VytUVGxxRHU5U2JoTzdDbXdjajV5NVZibUZIMEs4L2RuVGlYYVB0eFU5MGdC?=
 =?utf-8?B?SjlUTGpOOS9LalNqN1MzU00wb2JyN01wWTVkZkFFQjFiNlJEdHdDZkpub0hl?=
 =?utf-8?B?YitaaFBPVWUzRXN5eXlpRzRIQVZrdFJmdlkwRitTbVNoUWdDV0tJOFppVUd0?=
 =?utf-8?B?R01CbUZzOUd4ZTdVdGJuQ1FDVzlZMWYvZlc3Zld5endUTkdtdFVNT0Y5Sytm?=
 =?utf-8?B?VHFta3hhYnExbGpxRzR3U0o4OEh6QWpyTytCcFpJU29jODEzUCtnT1ZLZEZB?=
 =?utf-8?B?TS9aM1ZaOWNEQlo0a1ZTbXNzakhKa0xDL0J6RFRLTDhWMmhKQ3JML1Rqbi9Q?=
 =?utf-8?B?dWtRcG5oQXk2TGlUME9hRmFQTjJIVG5JUURLbkpEbzhqUlRsbnZld2NzWFQ2?=
 =?utf-8?B?QUM1RmlVY2JLeVp1SGQrWnRlYjdVRHdQRVdVVTdydjhjRTdlaTZIY09RdGFN?=
 =?utf-8?B?S2ZYb1lqWXdsMVozTmllbzF1YnVObWZPdHZhM0dlYi9tRU9raXFuTTJDMjd3?=
 =?utf-8?B?OUlNVWZrSEwrcGtOUlFEMVhITVBEOWJFTGtsdDR6a1pERHhyTFRPdGxPdHls?=
 =?utf-8?B?ZHF5eVU0c05LalA4ZVRWajkvVHJtMEQ3V0Fob3p4WVNVTWRRaVptQ3lRRE12?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E005F0E1257C8B478AE54BFACE752B4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b48f5b7-87dc-4d2b-4d5f-08da5dc310ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:42:40.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cbkdg1gINPXyLXQY1OD8UAivugUp8S9lwKzEZQBGxkycPjHueYZks7H4ah5DANKfmaEpZ+Aryje1/I6rQg56Pg7DMvO9GbpGU1oA6DjaTUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3070
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy80LzIyIDE2OjI0LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBPbiA3LzQvMjIgMTE6MzEs
IFNlcmdpdSBNb2dhIHdyb3RlOg0KPj4gKyAgYXRtZWwsZmlmby1zaXplOg0KPj4gKyAgICAkcmVm
OiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4+ICsgICAgZGVzY3Jp
cHRpb246IHwNCj4+ICsgICAgICBNYXhpbXVtIG51bWJlciBvZiBkYXRhIHRoZSBSWCBhbmQgVFgg
RklGT3MgY2FuIHN0b3JlIGZvciBGSUZPDQo+PiArICAgICAgY2FwYWJsZSBTUEkgY29udHJvbGxl
cnMuDQo+PiArICAgIG1pbmltdW06IDE2DQo+PiArICAgIG1heGltdW06IDMyDQo+IA0KPiBTaG91
bGRuJ3Qgd2UgaGF2ZSBhbiBlbnVtIGluc3RlYWQgb2YgYSByYW5nZT8gQ2FuIHRoZSBGSUZPIHNp
emUgaGF2ZSBhIHZhbHVlIG9mIDI0Pw0KDQpJIGxvb2tlZCBpbnRvIHRoZSBkcml2ZXIsIHdoZW4g
bWF4IGlzIDMyLCBvbmUgY2FuIHNldCAyNCBmb3IgZXhhbXBsZS4NCkkgZXhwZWN0IGl0IHdpbGwg
d29yaywgYXMgdGhlIEZJRk8gY2FuIGhhbmRsZSBkYXRhIHRoYXQgaXMgbm90IG11bHRpcGxlIHdp
dGgNCnRoZSBGSUZPIHNpemUuDQoNCkJ1dCBJIGNhbid0IHRoaW5rIG9mIHJlYXNvbnMgd2h5IG9u
ZSB3b3VsZCB1c2UgYSBzbWFsbGVyIEZJRk8gc2l6ZSwgc28gSSBsZWFuDQp0b3dhcmRzIG1ha2lu
ZyB0aGlzIGFuIGVudW0gaW5zdGVhZCBvZiBhIHJhbmdlLg0KDQpDaGVlcnMsDQp0YQ0K
