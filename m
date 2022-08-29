Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F45A5322
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiH2R2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiH2R1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:27:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25992F4C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661794073; x=1693330073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w7L6jYey9pe0Tnv9QAKp2d9ZC3gi8hqfxQN91PAiCd4=;
  b=LAugAjSYAdPE0TiLsNgshgJBATiq5rDIYjbR7Wipc0g3mZXF6h5yn75j
   S0U6vKlv1yQ2p/Yh6P9rZLen4rJ22NHXa6Q1KS6iTayIytIgEFhf87bxs
   ItNfYGN8QI6GNWjGPAK8s5fooo+BHOyDcVZnKdGoqlLeD5e/3IhxEcoYB
   zTvGVheLfyK4RriLg5jWH0EAtq1s0JqL/PCSTyR8nB63QjpHa6MVRT8kJ
   UVcJ1qK9018QVl4jxa53AoP74Kw1ogoTynNaZGZ4ZjP8U+3ZoXB3gRVZq
   9oZcAsr6leoMLYIqcmE6Hzn72W24QWSxmQG80i3xqfl4fqc5lAedXbHzX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="171454599"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 10:27:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 10:27:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 29 Aug 2022 10:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOXae9K6Jm/ea/ahX1Fm38aqq5qNH3YwHErN6bHr+Nw1lPbFHKxfCMAqwSoB60OSgPiJxky43ACArGnhmOiiLnXvgHSGuIAMZhrhdVNs0JfuIH8u2r3Fxru84MmJxB4XivMbXKh7nmuBwQ/UlyJNQfT5lxK5XPpMwDHmzqzPLVuhstSR/u1/CunQIqaSL1FnqwfFSeVb8qKQKafGscjukU6UEVKaCfyZfyz33N+TidWEJu4EVxk28Vu0uL2fmux4+s1lej/QGXuuL68lZb7/Jb17dU9RsIz1z1/V0e/VonczCiPY7iNEmCZ+eA5WKYIJpYHD9U5Gl3VOs9kI5snn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7L6jYey9pe0Tnv9QAKp2d9ZC3gi8hqfxQN91PAiCd4=;
 b=MN9nmrjFfSo089oF7L216+svwkXPnzAykF+uHhMSLJ/PeMiXvaaEpkPK1Vo599o7Je3kvmoUdVdkHSdjOo0Uo0Wu+P+o1RheJorygfVqJ90w1VwTHiC6akRAEQcAY/vjTb9mC+1YwRJzbhrL76syD0cx0F/VeTo0xj48JVrUpYXrs2wbiy/UNouTZ+Ld+LPIiCsZ3UGHSwDT8fgmFJg0XCZixaWfbT2B5vA+sbpq5UOgC2qjTxbQkBpmhx4m5jhapYTZ/myld4dqUlY67PaSsaHMvGt+XpoKS2+S/xthil/541hlGYsL6NbclrQywNSzKNYi5I/6aTRPSxZrAt6oPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7L6jYey9pe0Tnv9QAKp2d9ZC3gi8hqfxQN91PAiCd4=;
 b=MiAteAY16JMASNbkycgduoafKMN8M2TMffEeq+uYFjPKjRrGrkQhWSolKZjM206VEgwvr8UBd5Cdl7TvxYDfLcGlIivjwsbwpmeVts6uLz2BoBmCodLEoIHLEHR98n7jpug0rrR2SPrYptvvIoS8YQkdFaq47vZ50vWhOccepso=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1889.namprd11.prod.outlook.com (2603:10b6:404:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 17:27:48 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:27:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jszhang@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Topic: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Index: AQHYufzf4JJbBuNch02tBI9sTRPCrK3DP5sAgAKut4CAADcFAA==
Date:   Mon, 29 Aug 2022 17:27:48 +0000
Message-ID: <4037b310-47c4-ca30-d4b6-a284e87da437@microchip.com>
References: <20220827095815.698-1-jszhang@kernel.org>
 <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
 <YwzI7VmfFnOvYWgf@xhacker>
In-Reply-To: <YwzI7VmfFnOvYWgf@xhacker>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e1be365-7380-4aaf-3d96-08da89e3cb2a
x-ms-traffictypediagnostic: BN6PR11MB1889:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvNDcsJE/UijG5JGJcJUHcTAYY+yfiW52Pvxj54kVYLb/TCl2uCEGJmp07JXqujI1bLkvoJU90TRR3HkayT2sKWofrkQeWDFUsYEiL7C49oBcPeKrY+Lr4537i/lAuv3jXRToAAoDcJpIG/kbaJ/OOz0SNnlGZnFD/jMsXNSJ70Jh3CtxkUvwevB6m4YE8hQnDoXCrqCxOvulxqE8jUwe6hohBwwRYlXy2aRoR2yb169HBg7WLYLRSb/t+lhasqYBsJPSu7/BbweHkZbvf6pKNi4HFhLjJ3NLDKaWkKeaBy6GdkmY0jgVsgmJnr+Cv+1wMLon3Zu5m8xf9yK6p5rcHT9khOaGGxArDPYWUFILudGANRI/KxdAfL4qToaoOOiJA5xmn/bKaKaVfLTJLAVbyhwrMxb1eyn5+aG3UsmOcEc+IafZ/PEu/KCIgBi53FhRj4gXDYS9DnGUXfcSOeQViP/OnlicJEyNM2u5+ZKCX37FTe9u/EOthpd75EKMOriovOS4/e2WCBdhTRzkVN7f/xkZsidvUx/qYO+tUdC3vqvJdzzQcqsiKA3mEYokwrFAiOvHlOaY21Xnbu08heRvGYRiA9jDHtd2tPxgUTJKhFFxukg+/KuLtRAsPhPqDOyU24RgbwVmPo0sQNaANTUBmM7hO3oxnLnTjoye/bskWq+N2VSzMqR16vZrrgWT5ecBJY3OJNOz/JKkeZncutY/wDnrl35HxodnrA5TmE/FeU8/ICdx4VXcmLk8pwbHNeUmx5KNhhk+cB6dEaVKwMtGFfBbFTZ9hdWGeMyFUoHKXfNaWr+4nMd39rPl2XOAS1AvDJh6Mc8hJTduvTkZeZSqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(376002)(39860400002)(366004)(26005)(71200400001)(41300700001)(6512007)(6506007)(66946007)(91956017)(316002)(6916009)(54906003)(66556008)(66446008)(4326008)(66476007)(5660300002)(8676002)(64756008)(76116006)(6486002)(38070700005)(36756003)(86362001)(31686004)(31696002)(8936002)(53546011)(2906002)(478600001)(122000001)(2616005)(38100700002)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0NhVUQ1SVc1eVNiWnNmV04zTklJSFNXMExTZ0ZObEN1d1I2eURCVGVETVZI?=
 =?utf-8?B?ZllPeGg3YUVVYUpKT1NmeUk3dXdXRjJEcFBONm5KQlp4WlpEb3dnWHo1aVVI?=
 =?utf-8?B?dXMyVEoxSEF6T3RYU3JJRnJteGlTVlpZUEVGMlZOMmhORTRLR1BrZHp0ZnZa?=
 =?utf-8?B?NE51anI4L2swQ2lTYUtUSTB5Y1lyRDNKNE1INFlBK1poaldhU1ZFUnZRWHdX?=
 =?utf-8?B?Q1NzcW9kaDQ1VjFtczl4Q0w4MGF3alhyZzcrRkRyd2wwRHVrcmMwa2JnaFow?=
 =?utf-8?B?em5kNXRVU0pzUXJ0bXVpVTM5VmZ4U3NVRG0xNzkzVmc1eVN0dUNNdFNFNFQv?=
 =?utf-8?B?Tk81Z3NHU2VnRitWOUdrOG5TaVFia05VVXFjbFoxckVoS2JMRzFjVzNiNjFL?=
 =?utf-8?B?YmRGQ1R6ZVlyN1A5amh0Qk5jeE0yN0tnbTFsaHBoNzNPb0E1UmNMS1ZWTFU0?=
 =?utf-8?B?RUxFT3lwWFRBeFlQNVI1N2x1bmpFM1lLanh2eHdxRzBFcUIrOEdoRWdQdFFD?=
 =?utf-8?B?czltVVBUVTlPMjFOeVhSekJTMmxKTGhxeUQvc1ljRWRmbHFJOGJkVFdEQkh3?=
 =?utf-8?B?WHREbFdJSjJVZnZaSklSOGN6SW1nV3FDSC9QZXdsZDVQVlZJSGpxRys3WmVt?=
 =?utf-8?B?UHJDbzNURFo1SFF2UWZxcXc2WDBSU2FQSm1yNmRZYnVQaHlsZUVkOHpYVVpM?=
 =?utf-8?B?U09DMG9MN3lRRjUvUFE3dXgyV1EwNWJ4Q1diQXNoSmZSWTgvTERPQ1dSd2tv?=
 =?utf-8?B?VXBSWXl4VWJ3NnoxcGs2UnJFSFJ4dm5yTjd0QWE2QVpRR0dLWGdjQnhOR1RF?=
 =?utf-8?B?N0RLZ3ZZZzdERnMwN2c4YUM4c011VFAxbGtoTm96bzhwSVltM1J0TCtYRXdp?=
 =?utf-8?B?Q09mcS9YVlpPRWdXd1FWT3BGK2psSS9wODV0SW5rcXlIaGlZNkZTblBZMFFr?=
 =?utf-8?B?eFZWR2hNT3ZzT0N3NjAyWDEzMGFqbnV1cDhOVVlUTXhlM1orSnhyd1g5eFNT?=
 =?utf-8?B?dUpDTEdkZ2N0eUlxbmpGZW9OMXY0WlUvYktjWmNabm5CS0xudjBPNTJFU3hj?=
 =?utf-8?B?ME5pZHVKL3d3ZUFNdnVlaEpIU2N5UktWb21EZitHL3NtbVZqS1pOa3pGSnVU?=
 =?utf-8?B?UUJFMHRVenhNWWJ0aVhTckoweFBaSnBOdkgrTllvdGN0WFU5MlNhNWQ1bFlk?=
 =?utf-8?B?TXNodHV6QlAvNC9zVGJQMHVFMVRRRUFoaXlpcUpnOHo1c2ZpU3RBVTFYYXNI?=
 =?utf-8?B?Y1lWT1kzYXlnMWxoUENWTDZ5T2gwdzRJbmpKR3BON1NYVC9KVGNJVXdOVisv?=
 =?utf-8?B?WG1hV0tvWjNKekRMdzc0eStNOVZTMVowNU9yVktZQ29XdHpqMUtYNVhlVTFY?=
 =?utf-8?B?WVFzWThrMHI0eTJzLzlPMWRWRFZWMFliT0pHMU8xdnQwV1V1ZTFJK3Babk1x?=
 =?utf-8?B?UjlBRWEwellUWGdtZnFoZUJEWnNnaTRONmVqcCtNQ0lvRURyR3FKSi9pOE5M?=
 =?utf-8?B?b1NZSXZ3SW5pNnBZNEdEWXJ3NXJUb0Q5cms1MGVVUDVITm52TEFyMXBZQVhJ?=
 =?utf-8?B?Z0J1d01GM0xvUS8vT1NMTW15cGgrakszN1lnV0VEeVJWM3R5dUhWaHUyWElT?=
 =?utf-8?B?NW0zYnNmQ0grZUVXUVVRR1krMCs4Vmo0dWFveFVQcTBkNHF3L1oxb3VUQlVC?=
 =?utf-8?B?SkZwQ3ZMODkxRnpiLzV6Vjd1MnEzYml3MnlHeWxocUtsUnhpalc1dGRYdHJQ?=
 =?utf-8?B?S25pQXlManNMa016ZWhJWk5jaU9Fb1R2Ykd6OGtZTEpVa1ZFYkpTdGw5UEVW?=
 =?utf-8?B?QUdpUWE4OWFtZnZQR016aWZOY3BnN0lEUG15cGJRT3JRYjl1eVFiZVRWVFR0?=
 =?utf-8?B?VUxBc0plT0xlVmh1cEFOTjBSSGZFVDU0RFVTeWNVT3MzR2llMndOL0tsYVB2?=
 =?utf-8?B?RHZub1BDN1pGYVo4NWx0c1h6L2VuTmhCNHdRcndMZVNBMTI4R282ZHAxV0s0?=
 =?utf-8?B?dXZRWjBmdDEvamRhdUYxaktHaTRQSWZxU2V1M3BhcnRBOW9vODFDNEVSdElT?=
 =?utf-8?B?OG0zTVpvYTA5VTN6b2JYT1hKZzA1UW93NEdyYXhiOG01eTljYVl4bVBIenN2?=
 =?utf-8?B?ZnBtYXZlOVRXUUtnT2IybkZYMDgzN0JIdjlIMzdtaGRXbUFRRk5jKzRlOUlE?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3201983CDC12C46B6396CF67BC63AA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1be365-7380-4aaf-3d96-08da89e3cb2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 17:27:48.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6m6lrQG9GfZ/fhnBg8ZJUy0lQBJNJYRrmOM83VKmN/jtgb7V2CrOPsPb9AaR/h14nkhf8UMcvQA+JiwGpHu4hOufhavCa/uSSfro7lpqmoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1889
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDgvMjAyMiAxNToxMCwgSmlzaGVuZyBaaGFuZyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBTYXQsIEF1ZyAyNywgMjAyMiBhdCAwOTox
MzowM1BNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhleSBK
aXNoZW5nLA0KPiANCj4gSGkgQ29ub3IsDQo+IA0KPj4gT24gMjcvMDgvMjAyMiAxMDo1OCwgSmlz
aGVuZyBaaGFuZyB3cm90ZToNCj4+PiBJIGhhdmUgYSBTaXBlZWQgTGljaGVlIFJWIGRvY2sgYm9h
cmQgd2hpY2ggb25seSBoYXMgNTEyTUIgRERSLCBzbw0KPj4+IG1lbW9yeSBvcHRpbWl6YXRpb25z
IHN1Y2ggYXMgc3dhcCBvbiB6cmFtIGFyZSBoZWxwZnVsLiBBcyBpcyBzZWVuDQo+Pj4gaW4gY29t
bWl0IGQwNjM3YzUwNWY4YSAoImFybTY0OiBlbmFibGUgVEhQX1NXQVAgZm9yIGFybTY0IikgYW5k
DQo+Pj4gY29tbWl0IGJkNGM4MmMyMmMzNjdlICgibW0sIFRIUCwgc3dhcDogZGVsYXkgc3BsaXR0
aW5nIFRIUCBhZnRlcg0KPj4+IHN3YXBwZWQgb3V0IiksIFRIUF9TV0FQIGNhbiBpbXByb3ZlIHRo
ZSBzd2FwIHRocm91Z2hwdXQgc2lnbmlmaWNhbnRseS4NCj4+Pg0KPj4+IEVuYWJsZSBUSFBfU1dB
UCBmb3IgUlY2NCwgdGVzdGluZyB0aGUgbWljcm8tYmVuY2htYXJrIHdoaWNoIGlzDQo+Pj4gaW50
cm9kdWNlZCBieSBjb21taXQgZDA2MzdjNTA1ZjhhICgiYXJtNjQ6IGVuYWJsZSBUSFBfU1dBUCBm
b3IgYXJtNjQiKQ0KPj4+IHNob3dzIGJlbG93IG51bWJlcnMgb24gdGhlIExpY2hlZSBSViBkb2Nr
IGJvYXJkOg0KPj4+DQo+Pj4gdGhwIHN3cCB0aHJvdWdocHV0IHcvbyBwYXRjaDogNjY5MDggYnl0
ZXMvbXMgKG1lYW4gb2YgMTAgdGVzdHMpDQo+Pj4gdGhwIHN3cCB0aHJvdWdocHV0IHcvIHBhdGNo
OiAzMjI2MzggYnl0ZXMvbXMgKG1lYW4gb2YgMTAgdGVzdHMpDQo+Pg0KPj4gSSBrbm93IHRoZSBv
cmlnaW5hbCBjb21taXQgbWVzc2FnZSBjb250YWlucyB0aGlzLCBidXQgaXQncyBhIGxpdHRsZQ0K
Pj4gb2RkLiBJZiB0aGUgcGF0Y2ggL2VuYWJsZXMvIFRIUCB0aGVuIGhvdyB3b3VsZCB0aGVyZSBi
ZSBUSFAgc3dhcA0KPj4gcHJpb3IgdG8gdGhlIHBhdGNoPw0KPiANCj4gaG1tLCBpdCdzIHN3YXAg
SSdsbCBzZW5kIGEgdjMgdG8gY29ycmVjdCB0aGUgZGVzY3JpcHRpb24uDQo+IA0KPj4NCj4+Pg0K
Pj4+IEltcHJvdmVkIGJ5IDM4MiUhDQo+Pg0KPj4gSSBjb3VsZCBub3QgcmVwbGljYXRlIHRoZSBh
ZnRlciBudW1iZXJzIG9uIG15IG5lemhhLCBzbyBJIHN1c3BlY3QNCj4+IEkgYW0gbWlzc2luZyBz
b21ldGhpbmcgaW4gbXkgY29uZmlnL3NldHVwLiB6c3dhcCBpcyBlbmFibGVkIGFuZCBpcw0KPiAN
Cj4gc3dhcCBvbiB6cmFtIHJhdGhlciB0aGFuIHpzd2FwIDspDQoNCkkgdGhpbmsgSSB0cmllZCBh
Ym91dCAzMCBkaWZmZXJlbnQgY29uZmlnIHZhcmlhdGlvbnMsIGluaXRpYWxseSBub3QNCnVzaW5n
IHpzd2FwIGFuZCBsYXRlciB1c2luZyBpdC4NCk15IHpyYW1jdGwgbG9va3MgbGlrZSBzbyAoYWx0
aG91Z2ggSSBkaWQgdHJ5IHpzdGQgdG9vKSBhZnRlciBydW5uaW5nDQp0aGUgZGVtbyBhcHBsaWNh
dGlvbiBmcm9tIHRoYXQgY29tbWl0Og0KDQpOQU1FICAgICAgIEFMR09SSVRITSBESVNLU0laRSBE
QVRBIENPTVBSIFRPVEFMIFNUUkVBTVMgTU9VTlRQT0lOVA0KL2Rldi96cmFtMCBsem8tcmxlICAg
ICAgIDI0MU0gIDIyTSAgOC40TSAgOS4xTSAgICAgICAxIFtTV0FQXQ0KDQpJIGFtIHVzaW5nIHRo
ZSBkZWZhdWx0IHJpc2N2IGRlZmNvbmZpZyArIHRoZSBmb2xsb3dpbmc6DQpDT05GSUdfWlJBTT15
DQpDT05GSUdfQ1JZUFRPX0RFRkxBVEU9eQ0KQ09ORklHX0NSWVBUT19MWk89eQ0KQ09ORklHX0NS
WVBUT19aU1REPXkNCkNPTkZJR19aUkFNX01FTU9SWV9UUkFDS0lORz15DQpDT05GSUdfVFJBTlNQ
QVJFTlRfSFVHRVBBR0U9eQ0KQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFX01BRFZJU0U9eQ0K
Q09ORklHX1RIUF9TV0FQPXkNCg0KQW0gSSBqdXN0IG1pc3Npbmcgc29tZXRoaW5nIG9idmlvdXMg
aGVyZT8NClNvcnJ5LA0KQ29ub3IuDQo=
