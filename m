Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42208566570
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiGEIvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiGEIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:51:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F5DF3F;
        Tue,  5 Jul 2022 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657011108; x=1688547108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yqu/sHaz+AgFdkrrC2awMuLDwJZjPyiJg1qoGvOZYgA=;
  b=Cb93tNQUgHb3wIoC+K7f1lB+0o4h1oNAqg4BvlPjAiBS9XO91i6+YU86
   EbonjCKuL2vEpgvsBADWs6uvSIn1VGbcUlCnMQlTn5DVkmLO9JjINUib5
   CzBZ/5tASFz9X6M/72xjjVAnyYev8sKH5SrSIlOeiTf0WnbF1kgNkskAe
   hKnLhJ5XVoiycEWDVJwITJEfH8PpLtPVSPZHHQsuEz1137eTTGHvkvkFD
   1UfHF9D7UeZ61DiWfzyr8V1aH8A9qz1SweQaQhLB2rmOVavVA/CR86cTZ
   OeidqOoCNwOBulSLqGVYwumSsMYuvqjPmMct0PmY7qCa1dRtLZ0w8mMLQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="166388297"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 01:51:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 01:51:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 5 Jul 2022 01:51:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR7k0oepKRGTHktAbN/mLKUNEshbTagntEWKsqRUSdFvsT1O2hfEwvRiruTky3NJ4j9gtxMF9bQ7sMjMhG4DDwlfhpgF10Zl4R7abHGnfOPnv5d+9vLlbc8aPeu5qsGIB72kwfCPTYzbSoVO1Kykfqe/gjjgC8xuSO4L0lDfs4xMFnbP7ArcbLYXZGGiGhJbEzN2b99aJ+m/nthhn6MsaArZhdf55ptDRVGtwhi/29Pdj6+1UHjNKgbWAdpUW+ira/k2BdQNxnhMX0w5Fd9UOq/oFaZmr2SKnvPHVJZWKP8v5Cm7Lswp0xLdgkMlTNHjahTQ3Irpg23Z6jRGB4I2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqu/sHaz+AgFdkrrC2awMuLDwJZjPyiJg1qoGvOZYgA=;
 b=GqUzuu1+IoLpT7ur9X4m4dx5Tp1J/tVfoWLv0aGbpdCRf5J/gM0sD736ZwbdOfPdq1K8aVjgYUqTm6ddo1LenVgD+5xbbHI/WwwLntTCXVj2Ow6hUeRcmNxcvDNWwooZiwuqLocHk5FSS8VIgen3aBPuIB81CxQYQiK1e8einzGC2u9zkrvXMRofs9/UPd2rtw8s+Kjnhjz5m5ihvLPBTDvB2g7Nkvc6iUSCbjy9E+GvSaH6WSq0MAKVepMVcTPHbVGoXbeKWsQOqv0QdvuO0ePzYJi1BDVgW5SWthJ5fHQzaDeNDYEyy70nXYWKJU5WW1WF0gObkOSdujaYgNfOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqu/sHaz+AgFdkrrC2awMuLDwJZjPyiJg1qoGvOZYgA=;
 b=UYTNTDBz/ux+SAZCc88nSzdf2L4NW5qURKmLHmScjLnxxll2J0LToIw6LEQqGG1bUkxT3yYwXU5ZoAGmoeLuuCmT5um57K6LFch81NBjQlFQIK6RCPvxR1anLFZIRmHUXmScGt8RzbFK8j8n0NZ21xEaf8H+2JxIrjpxRYFlsHc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 08:51:46 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 08:51:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Horatiu.Vultur@microchip.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 1/3] clk: lan966x: Fix the lan966x clock gate register
 address
Thread-Topic: [PATCH v5 1/3] clk: lan966x: Fix the lan966x clock gate register
 address
Thread-Index: AQHYkEx0aaaMTZ8DMk+oPIscnf6ZMg==
Date:   Tue, 5 Jul 2022 08:51:46 +0000
Message-ID: <c33e0cc5-54f7-9052-efb6-36a9d7169bd4@microchip.com>
References: <20220704102845.168438-1-herve.codina@bootlin.com>
 <20220704102845.168438-2-herve.codina@bootlin.com>
In-Reply-To: <20220704102845.168438-2-herve.codina@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a191385f-dcd0-4335-277e-08da5e639773
x-ms-traffictypediagnostic: BN9PR11MB5323:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtqABHnXXC0O8j1NkhZEmO81Oq9G57kg+hSvXAq0mwGCxMk3NqAJM6YR+6Gu1GCjVwq5Xywp6b04Eg05C+n3Fzv0M9w20a3Hy/WpyyG5JD7qazji7R17+hoQGEu0FwOi6AnIql8pdKHK0PZRlIeZAliOzB+XsAjolkE7SG9c0p5LrHYtOVGGA5jOXlZqYYdrQ4M7FTI3zxrM+Q0lt/D5Cidngwjo1epR9I1d5KWZ2n7iPWUf+ZO3A7KD4+CsgYJHyx0HBeCnx4QeByZ9L88Vawmed9FVujnnv2rfeIfj15KOp5rTSjMWmVvt/6nS+iHDbz0trzCRHcN2hAUiWXms3Bb0PHIeCke7vdPnzYqqfp//I/d7e8so3cn7DP5uB+XyxAEq5L56BSHn0/5hKChf9BpySlOnPYoOg91s/if0qLmEv1Vz8oCWw8tvmIH83jo6rcFmrf9ynCGMIbf7QuOa+9dA8Gx6fR+oXZSSqxc3HyZXBDVfQ9WTWfk2JxekccOu7wbwFZLtMKH2F674Bd0pW5+qMfskvYcxyjh1PsnXwhdOq6STGznc3GAMpuLxEadk3DuyYidNR138ffnJpsXBrLeJ+gmEnfDH+xtZK4Brw9UppiGvoialeVVkbdzKrRbKWU3ATBgFFVuqzZklvay+cDLLgwYDY82tEgNnXRiFGM29t18Mm1iTfjqmW5necB/whqSaZOnP1VV7ZB+1eB5awBhy0qpAbO45ey8zFXWq8CnbyqUaHeR/6UqQZ4qYnVJLaXnn+j3disJk1hCxWCNNQJGXP7NpXAbAZ8+ul3Fu2BbLI/+I4PkQjeiV+GdXe8U+Cu5sqiUPq9/ZevL471dDgHJ7Z7ne5WOxiozsfKQKfiBB6hPsaYSe2D4t1q9CI/Y+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(8936002)(31696002)(38100700002)(6486002)(86362001)(478600001)(122000001)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(6512007)(66476007)(66556008)(5660300002)(2616005)(71200400001)(91956017)(26005)(186003)(7416002)(53546011)(36756003)(316002)(6636002)(31686004)(54906003)(2906002)(41300700001)(6506007)(83380400001)(110136005)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGdVdTVjNXlHWUlKK0RHRlEwd2JGZVRjT0tZVkduVjN5dEYrWTJTbDBHYkVt?=
 =?utf-8?B?aXVvVWp1V2pHclhnWXpja3c2UWpJZElXVU9aZXdQZCtOQUd1Z1hzZW5GMjNq?=
 =?utf-8?B?NmU2bmZZVndNTGMxMTRNVFpISGl6TGk1KzVIbkg2RTkySmUrNUdoanBvY09R?=
 =?utf-8?B?Wk5ZY3JwWTdUczk2TXZSODhwaXdodkNuY2VjWithN3EyMzBJK0hYMHBDME5z?=
 =?utf-8?B?YlZGODdEdy9kaVR5THBOVlpDVjhhSXpBcG5vWGxTY1I5YkdhKzJ3dHZTZ3Qz?=
 =?utf-8?B?SUxTc0JoWXczWE4rOHFZSlRORDRZZklybDByZE1MUFdGRWZtcUtNZmIzZkd6?=
 =?utf-8?B?dUFKV3dUN3dMSVladEtpNTQxYXRQWGFKR3V2WUs4V01JdjJXWCt3NHBLQlEz?=
 =?utf-8?B?RnVpY0swS0RKZnJ3RWxTK21aMThJQy9xVlp5YnpZOEhIQm4xdEQ0dmlHYnJ5?=
 =?utf-8?B?MnM0SSt6UVdVQTdMNmliMExyYm9jMlJXa096REtad0duV25BZS9odlNWM21W?=
 =?utf-8?B?SG9zSEZ3WUtQWnNwL1B0bk5YU2w0SzN3b1Vmd0c5WHc0T1ZuYjg4WUc3SFN2?=
 =?utf-8?B?SmFPSGhUZmRaQTZpdFo2TVJNR3lwSnhqMmMycnNRaDQwTUM4alFzbG9NUW5T?=
 =?utf-8?B?V3cvZWNpQ1FubGZmbld4dXFXTzlIa2JEQXNQT0wveUZrS2RyK0s3WTAwUFl6?=
 =?utf-8?B?bDdLZVo5S1U1emhKS0YySFY3N3hGdk9zQ3hJYmd6TUV4aGI0cVUxUCtGYUNZ?=
 =?utf-8?B?eFVydnhGU1NrY1N3WFczaHBsUmd5YU9kU2FaRXhVTW1seEg3UFhUVlBqZGRj?=
 =?utf-8?B?eE1zdklLaGR1RnYwbmQ3Nk9DemhGNmxKMGZ1N1h0d1JwT3JVYW1rM3ZXdnA4?=
 =?utf-8?B?M0N1SHp2YjZOeEVqSG1YbkY0NFBJZWFjM3VlYlFXa05LR0lHc0FqUjEwdXRN?=
 =?utf-8?B?R2NVRWloYytDT1krSGFvQzlZT3V4N2plWVhubjF1cUkrb3hLUjNCdlI5K2Za?=
 =?utf-8?B?UkpFVGt2dm1EaThWYlhLMFdCcWlJeXZaSytqRlRKT1VKL0xIWGVTd2EzSGRU?=
 =?utf-8?B?aFY5S3dqbFFGYUlCTENOMExxRi84aERmV05VK3N3eVBrVEU3WGVHOFp1SHc3?=
 =?utf-8?B?REt5ZEtDWnFHc3BSVGhJeDgyckhKcE5lVUh6Mm1tRlMrWk9jSUgvM1hwTlJ5?=
 =?utf-8?B?cUNQQ1NTSU9jd3QrekRLUlIxMDZBMkM0c3lKT2hmUTE2WDkyeURJeDcwTmhI?=
 =?utf-8?B?MVpMNU1YUGpNQkVXWEJDYWs5c1F4RGw5azMxWGgrcFcwTm1ydjJDL2wzanRp?=
 =?utf-8?B?RmQ0U29BWHUyUnVJOTB1VXBJWmFRM3ZnMHRtUnBzeXJjUWNjTEd0RDNsVnI0?=
 =?utf-8?B?K1I1L0VxcjhFUk9ZcU9UMmV5MStaOVNIMkxYVmZMNzBVS1d2TGJ0SlFocFQ4?=
 =?utf-8?B?elhjbWozQndFTFo2TCsydVB2Y0RKQVhjcnY2OFNML0Q5eHpzL1F3c1BWS2Zp?=
 =?utf-8?B?THpQRVNkVnNRVGVONUtKdmduMy8ycTdiSGY1cG9tY3VMQiszT09rMC9EWjB6?=
 =?utf-8?B?aTQ3Qnppc3dVTmczNGRTaFBTNmdRaXl1eUFWTm00dXRlM0FwdnAwQjlGMmto?=
 =?utf-8?B?TWhka3BNbjRKTUZ5ak1LaW5PNktSa2l1OTc4aTZEN3BGOGp0VmlHME40NHJ3?=
 =?utf-8?B?bG9PMXUwdVQrdWJ4Mk1PaWlQRk5vYmZHVzAzcTBuNTVvV29pdjdIVllKbTJ4?=
 =?utf-8?B?OUUyWWxtUVBXbkNmUGZnNTFiVVZUVGFiRjZMRnRhcmRRRmU4SGtHRUNpYlpY?=
 =?utf-8?B?eWt1ZWZadEh4eExvQzdPYnNIazBaVDFBRm15Mk43SEUzUCtGaDl1amxZN25O?=
 =?utf-8?B?SnBKZko4Z253U3IyWTg2aHR4OU44TmV1ZVF2UVkwL1JmWVRyVitJdVVUbWlM?=
 =?utf-8?B?d0JBZldrUXNDck5JeGxuMEpVSU5qcmJiOCtwWHN0LzBmM0ZPSm5XUjgyRmtx?=
 =?utf-8?B?YXJBdTBjM1dVTUVYK3lzMGpaQXJ6NGtiVWtsMUp2QXJjM2libTRJWkswVC9h?=
 =?utf-8?B?VVVDYnlnVXdlckFjV3lwS0I2aU5wQnBpTVVLV2N1b3Jhd0lGSGl4bWV5Tkdw?=
 =?utf-8?B?OE9MVForMlRWOGNpS1B3aC9FU2U2T2VrWStIdnNkQjdpWmVhcWp0YU51KzZY?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18E4E01502B7AC4DAEEB63ED488473F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a191385f-dcd0-4335-277e-08da5e639773
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 08:51:46.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+8CZzmQUgOPuACU0DqJ/L+EMzZnDbj7hp/H/4xPgEx6MNLkmSd5K2gxrEYnEZyfE6oMi0rxif9DNTulpYrlrUNgSa0ITKpiPIAGHbkx6XU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAxMzoyOCwgSGVydmUgQ29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSByZWdpc3RlciBhZGRyZXNzIHVzZWQgZm9y
IHRoZSBjbG9jayBnYXRlIHJlZ2lzdGVyIGlzIHRoZSBiYXNlDQo+IHJlZ2lzdGVyIGFkZHJlc3Mg
Y29taW5nIGZyb20gZmlyc3QgcmVnIG1hcCAoaWUuIHRoZSBnZW5lcmljDQo+IGNsb2NrIHJlZ2lz
dGVycykgaW5zdGVhZCBvZiB0aGUgc2Vjb25kIHJlZyBtYXAgZGVmaW5pbmcgdGhlIGNsb2NrDQo+
IGdhdGUgcmVnaXN0ZXIuDQo+IA0KPiBVc2UgdGhlIGNvcnJlY3QgY2xvY2sgZ2F0ZSByZWdpc3Rl
ciBhZGRyZXNzLg0KPiANCj4gRml4ZXM6IDVhZDU5MTVkZWEwMCAoImNsazogbGFuOTY2eDogRXh0
ZW5kIGxhbjk2NnggY2xvY2sgZHJpdmVyIGZvciBjbG9jayBnYXRpbmcgc3VwcG9ydCIpDQo+IFNp
Z25lZC1vZmYtYnk6IEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5hQGJvb3RsaW4uY29tPg0KDQpS
ZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL2Nsay1sYW45NjZ4LmMgfCAyICstDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9jbGstbGFuOTY2eC5jIGIvZHJpdmVycy9jbGsvY2xrLWxhbjk2Nngu
Yw0KPiBpbmRleCBkMTUzNWFjMTNlODkuLjgxY2I5MDk1NWQ2OCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9jbGsvY2xrLWxhbjk2NnguYw0KPiArKysgYi9kcml2ZXJzL2Nsay9jbGstbGFuOTY2eC5j
DQo+IEBAIC0yMTMsNyArMjEzLDcgQEAgc3RhdGljIGludCBsYW45NjZ4X2dhdGVfY2xrX3JlZ2lz
dGVyKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gDQo+ICAgICAgICAgICAgICAgICBod19kYXRhLT5o
d3NbaV0gPQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZtX2Nsa19od19yZWdpc3Rlcl9n
YXRlKGRldiwgY2xrX2dhdGVfZGVzY1tpZHhdLm5hbWUsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImxhbjk2NngiLCAwLCBiYXNlLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJsYW45NjZ4Iiwg
MCwgZ2F0ZV9iYXNlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNsa19nYXRlX2Rlc2NbaWR4XS5iaXRfaWR4LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsICZjbGtfZ2F0ZV9sb2NrKTsNCj4g
DQo+IC0tDQo+IDIuMzUuMw0KPiANCg0K
