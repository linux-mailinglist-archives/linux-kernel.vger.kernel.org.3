Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4FF59B30A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiHUKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHUKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:04:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A35A1B8;
        Sun, 21 Aug 2022 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661076286; x=1692612286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=km9x0hGRpw+4KWRO+iMrbssIAJHb3Fk6qZCrl4woZ7Y=;
  b=NSWTBIrwIAwjKncUsHIvz6TcS0FcMtnxmS0bH44kQpow54R643TwmFHc
   WdHb53rfIHhv5L8zETULLgDJP69U1JuisVMMK4tZvCB2U0YmZP3x35fQu
   ezzEQu7hD/JvprwRWLGfmGQHVzmVzkgPIb1qWJIgZqFHnM54TLWcWDZx4
   F5bmSRTIQguR2B30aOvxEebgFqabGRE+N42DCZqAgYvbY/2Xn+wsFulZE
   M2WFEeD2XrtyeEu2cuSPnQT+31I0FDH9aq1wmEB2Bk8bqsPwjNRE5ARjx
   PZjXexqd4Xx9+VVaMJ4k/MWc0Yj5Nb96XIwb3Bd9bPWdIqS8wzHYzlcJc
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,252,1654585200"; 
   d="scan'208";a="170210804"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2022 03:04:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 21 Aug 2022 03:04:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 21 Aug 2022 03:04:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBniM1Zx7IVf7Ppmi8lYODDS0sr+fKH+GVU4NtUSM0EKTGmjBXftsVOJR5kvJgAPsJ06GWgY7bC89sHcvxu6xjYC7VyHrY+e+WJAgFIjNp9fkOwYwg4p6gt+cv95ZlH/XF9ZIkt0yiR6kWe0GyBNASUOGE4GrB/M1pt8+/9JWAcTEYDNcS81WlGGcoVEPGcfHNfbsoFECvni7IRJofWG8q2A5eLyEEKiFzuBSit0uxTcSqj9LQff9/N8FHCwbZuBgGDWnqc9XpGjft/IWha17j6CGQ2w30Sk9nTrkwGnZQT5NTESSvoHNTr7Z4RxIiaQ5VIsvy3D9seeKDwEMsSAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km9x0hGRpw+4KWRO+iMrbssIAJHb3Fk6qZCrl4woZ7Y=;
 b=dK58UTv/+7dsUEy1JzELnI5OjptslLRdRVUitB2mSEHLpi1rivuKCP9wCpWsCQHVIr8yc/f6UBKT30/veb1cl8blb5KSPZePFhF4l4pQhVAM4HIuGOoNfbGvchcw8B2/Nioo6SQbZWJV7hmZYkioK7w6NZKtQRkLMPjHWjQ1YyRMgR6HjMaIGygtnAvUy63fguzB8la4m83M7HtINEQpF3yD1tHlgGude8qaM880Ym28/j31gH4LQoBXD6m8K2IAlupGnF3Q2G4KbD21q7Cf3wp40MAMxf2viMLtUj7H38paYMiHUmbAHpXttiNAVSnP+0zLGM+yV28aGcZKrquAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km9x0hGRpw+4KWRO+iMrbssIAJHb3Fk6qZCrl4woZ7Y=;
 b=MmFt8zTBV+JytHsF0diYPqdyjHBX76tqBDXq0hblwrfYMAPxccG0QtkjlbvD0ghrJ0xYfZPzVb5yYBaVNFenKAjK6Y9Bk+64qMkRJZfM4C1cV4/9XwWiwsxh7iBhDCXEhO+URbYNrb3wTZh4DUmj9qwZCRDYsJxHJGH5Y0z+0Lg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3049.namprd11.prod.outlook.com (2603:10b6:5:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Sun, 21 Aug
 2022 10:04:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 10:04:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <uwu@icenowy.me>, <samuel@sholland.org>, <andre.przywara@arm.com>
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
Thread-Index: AQHYsGUwgMumzpPtekanQb2zMhKHQ62v8GmAgABAKYCAB+IqgIAAATuAgADecICAADeqgA==
Date:   Sun, 21 Aug 2022 10:04:41 +0000
Message-ID: <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com>
 <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
 <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
In-Reply-To: <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15b117fa-f158-417b-fb80-08da835c90ae
x-ms-traffictypediagnostic: DM6PR11MB3049:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5G8lmjUEmjHwzhSD61aaHeN9f2Nu5DvFE2JKCqNyL3JEeb6OZc1Y124R3sywHYoW9N5hgKwI/tcoG+r86ya1412iY45iglcKnpTOf8LScNoIedsulNLFjx57HSJJkex8XkewCxK5crMjsLbQuyqDK0teHQWZE9/ZGZzi1OyzMFbPjVjbo7svi652hPzTpvtNAcDdSi0ytcl1H5r8Ki1TFW70h3Y34xGs5elrRwMieA181Sjr/6AGJgJy738vydc5Ixpw7mu2nt2J1/Ya/pOXm+RCsdB5+hHoZCrMXSR8ZUmLOigym2Fmqyrt2ZJ34THbAHzUXuxlhGfXGo8VKwJUiD3n756p/Ha3nyFSDAqykTArtuMs3b8XJ1NvF+8UgtMwzYjjLHLGRErbi4Gboo/qay21VC9/CgaiPnYQMGG7k9WjCliw+lUjx5VKuOkJDEFqrOFrwt5bqSHofB3c2CIAT+7b+QJgKrQVe2WCxrOTSZX4Mtsq7SAN5u/F/PSHzHXqJXxrMiVdAsIa2RJRx7hQdu+gF27GdmIBVH8sy2Ms1pNDHZRis8HbHwyxP3wtS04a0ngnmz1mFnVBQh879UbzptcUSEM2f1VWoBZd5h6y/mnMIDj3Zu0LGR5qyr/6aE80p1SR3WunMTH1V5A4BfW+8k8KXluUrMeavvBFN/hOPGbk4xa8aVdALqb1EpFwRmPmRHmKlF3mbYecobLp7tZnRo/6IfhXKTR8OAZLqsGoLiKQOn7evV3wyGumTx/hQO+vGXfLPUN5GWXpGG7b42Ey+6z8bXFP3zOI/DjNknfqwJqeFp0KywTGLGHbse8h4HzDLHH/fYljnmnrGelTG1DicYX+I+6Qk4yWeNwT1/xoEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39850400004)(376002)(396003)(366004)(5660300002)(186003)(4326008)(2906002)(66446008)(91956017)(66946007)(64756008)(76116006)(66476007)(86362001)(8676002)(41300700001)(71200400001)(66556008)(7416002)(6512007)(6486002)(6506007)(478600001)(966005)(2616005)(31696002)(53546011)(26005)(8936002)(54906003)(122000001)(31686004)(38070700005)(36756003)(110136005)(83380400001)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlVPNUdFbWR4OHRDL1BVdnA3bXZESVBvRTRxeTdJY1kxVGNiUi9mVXpNRmhY?=
 =?utf-8?B?WnVCZ1RTK2JURHRlZTIzL1E5M0RsY2ZOcElRU0daUy9zWlIxWVU1TWJrRDdK?=
 =?utf-8?B?enp1V1lEVWxkVnlaMmFsNDZsTXArZ1h6ZEM5OGdBSm8vVG5FaGhQUnFaNU1K?=
 =?utf-8?B?RnBnN3VBb0IzSm9NWjZFT0wvd0o3NFFvdEhTVEZ4MzZBcCtmN2dCN1ZXTm9B?=
 =?utf-8?B?aW1XMXplU212dWZDVnIyckczSjVYQ0pYQnNFWE1IeUxBS0hIMjYrZWdrMjlw?=
 =?utf-8?B?OWt4RnVraG9kdjJGdTcrL09BYU1BQkNEVXRVYzRSMXBMWHh1d3N6TzhhbXdr?=
 =?utf-8?B?ME5qSmFiVVFETEpEZHJRLzBleU9xRnNvYUJCZlFRdmtVUEI0bkNFOVFoTjd0?=
 =?utf-8?B?cGFRNVc4c0N6cGhwWGdHZTBWa1JTb01hekZqc1J6N3VPMlU0YmNBT0FiZ0gz?=
 =?utf-8?B?UnNYL3dySEl3TVZhQ0R5Zzh5NDhHOW1KalBsVjRLYzk3Z2xKWXVmR1J4UWlh?=
 =?utf-8?B?SUk0VnU2Yy9Uc283NzVTdVFCMGFBTVY5bVA0cFBtK2dhays2RStzVTFXZ20y?=
 =?utf-8?B?S2N4Y1hSNGtGdjluUC9PR1JuTWhkbWljU2J5SFdDbG5IeTJCT1JuU1pnbWNK?=
 =?utf-8?B?djV3VEZXUGFMeWxGZG8vc2pYVlFmcFovQTRaWnNFZ01zQ3R1eEFkN1d5WWlN?=
 =?utf-8?B?MWJVekRzVzhEckIybng4SEZDcldyMkpVeC9DdSt3ME8rbDRRd2laRThoQTFx?=
 =?utf-8?B?Qngrbldtd3FKZnRLUUlDaUovaXUvMUw5UngwRlJrd1QxZlp2NEl2MFlCWmhp?=
 =?utf-8?B?OGFQcXRKWGtFMGdQSUxJbEw0ejRxRjdTOTA1NjQxQVlhWnpZd2JTeHJ3dC9z?=
 =?utf-8?B?eW5oekdjMi92dUdtOCtJMGhmVGxtWHY5SGFzYzVhajBIUGFGKzBSbXFDTUhF?=
 =?utf-8?B?SS9PQUhTRVg2b3dWcWo2dXorcGhzRVpQRGNCMjdSY25TMmJJQWF5VVNtVHll?=
 =?utf-8?B?Y21uSWhXbEdWQjRmQmNiNzR6ZmlORU0ySFJ6UWNlV3A0VHRzbW9kOWlEWDN1?=
 =?utf-8?B?TEFDNm52UjVkTHVlMUdDUXEyV0UwVE51SDlUZW1sbGxoeGlZVEVXTW55OUI1?=
 =?utf-8?B?dVN5STVwREVhRVNmbE5tU3FxeWtTMlFyWUNvendYVloyYnhIaUpmSjZ5OXE4?=
 =?utf-8?B?QTJJUy9nTUhaYmxseGFOTnFXK3NSUVlrZDVHNHVSaUNLRGpXclhKTzd2azMz?=
 =?utf-8?B?UnVaZUE4NjVOMjdIQzBTL2ZLQlRnbmhhcUZrUjNYT2VyV0o1dC9PbEhKZk5Q?=
 =?utf-8?B?QUJhY3pDVExabEJFK3c3VkcyNFY2UGVqM2pyS095YnJlaVJnRWUybTNGRnpD?=
 =?utf-8?B?WmpSSzRXR1MwbUhrRWZWcFp4NHBnUzZ2UHlXY1hvM1FzZXpoSVRPZm9SamhL?=
 =?utf-8?B?d3dSTUtVa2duMmNjMGdOSzIyMTFGTWxqQ1Z0MWhabVBQQlBJdVBBalczWFVL?=
 =?utf-8?B?RkVTcURnYVZJVk9yZWNxTWFjZ3FxaU4wYys5NEEzaFN2V2NXMTlNc2cycE05?=
 =?utf-8?B?T2ltcG5TRjFvVzkrMktaZGlDSlZlalNOZTJXSjBNeVRqdUc0WWZVaFJYVkRl?=
 =?utf-8?B?QlNwZlBhVmYxUlphNGhmTkE5YVlZU2lLRzJ4T3E1N0RiOU5tTEtwODhYVHBU?=
 =?utf-8?B?c2JkTlNockkzaDUvbjJvUjAvcnk4YWJ4YTNJcWFYYktQWE9rbWVsbkZCSWFi?=
 =?utf-8?B?M0YrdHk1SDhYL3RRS21KdlArSmZhaWhEUUFQbkdIZnJIL1JPQ1dUczJrWDZQ?=
 =?utf-8?B?ME51Uzl2NVJoQXRHVk0xV0tvVFpkeHJVM204ZE9xZkFpM3IrNGgweUhVVm9I?=
 =?utf-8?B?elZZb1ZzOGFNcVB4MUt5OFNjQWVjQmJwb1M1QWFEWktTODRNWXB3TWZ5WEtU?=
 =?utf-8?B?cHVsSWNUalVXdnZmMWJXc3lJek4yQVVtYmswZ1RCMFZwUlRNL3NodzBnemFq?=
 =?utf-8?B?aWYvNFprRitDWXZqbFA5SG9IRjcycTB6VzlZaEdKRzFmSVZMa2dWay9wemcy?=
 =?utf-8?B?aFBaRTNYaWlSaURoNzdqQWtOcDlaUjZVRmY3dFJySHRONXE4Q2dTTEVrWmFZ?=
 =?utf-8?Q?xzFkY227Ac+Sni7uulopS2Vii?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFE97ED9A53DE14EB55933E0BE745546@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b117fa-f158-417b-fb80-08da835c90ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 10:04:41.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgPL+hVjFqeLF6QeSDdycfeotVBmi3SEFGQogf1wTSNSr3bJ1pJj7JnPgl0OjMAI/b03R6iV6LlOxrsWuOClcPVKx2aLZzLPKXmErUM/LAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3049
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEvMDgvMjAyMiAwNzo0NSwgSWNlbm93eSBaaGVuZyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiDlnKggMjAyMi0wOC0yMOaYn+acn+WFreeahCAx
NzoyOSArMDAwMO+8jENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29t5YaZ6YGT77yaDQo+PiBPbiAy
MC8wOC8yMDIyIDE4OjI0LCBTYW11ZWwgSG9sbGFuZCB3cm90ZToNCj4+PiBPbiA4LzE1LzIyIDEy
OjAxIFBNLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gT24gMTUvMDgv
MjAyMiAxNDoxMSwgQW5kcmUgUHJ6eXdhcmEgd3JvdGU6DQo+Pj4+PiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzDQo+Pj4+PiB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pg0KPj4+Pj4gT24gTW9uLCAxNSBBdWcgMjAy
MiAwMDowODowOSAtMDUwMA0KPj4+Pj4gU2FtdWVsIEhvbGxhbmQgPHNhbXVlbEBzaG9sbGFuZC5v
cmc+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IEhpLA0KPj4+Pj4NCj4+Pj4+IHRoYW5rcyBmb3IgYWxs
IHRoZSBlZmZvcnRzIGluIGdldHRpbmcgdGhvc2UgU29DIHBlcmlwaGVyYWxzDQo+Pj4+PiBzdXBw
b3J0ZWQhDQo+Pj4+Pg0KPj4+Pj4+IEQxIGlzIGEgU29DIGNvbnRhaW5pbmcgYSBzaW5nbGUtY29y
ZSBULUhFQUQgWHVhbnRpZSBDOTA2IENQVSwNCj4+Pj4+PiBhcyB3ZWxsIGFzDQo+Pj4+Pj4gb25l
IEhpRmkgNCBEU1AuIFRoZSBTb0MgaXMgYmFzZWQgb24gYSBkZXNpZ24gdGhhdA0KPj4+Pj4+IGFk
ZGl0aW9uYWxseSBjb250YWluZWQNCj4+Pj4+PiBhIHBhaXIgb2YgQ29ydGV4IEE3J3MuIEZvciB0
aGF0IHJlYXNvbiwgc29tZSBwZXJpcGhlcmFscyBhcmUNCj4+Pj4+PiBkdXBsaWNhdGVkLg0KPj4+
Pj4NCj4+Pj4+IFNvIGJlY2F1c2Ugb2YgdGhpcywgdGhlIEFsbHdpbm5lciBSNTI4IGFuZCBUMTEz
IFNvQ3Mgd291bGQNCj4+Pj4+IHNoYXJlIGFsbW9zdA0KPj4+Pj4gZXZlcnl0aGluZyBpbiB0aGlz
IGZpbGUuIFdvdWxkIGl0IGJlIHVzZWZ1bCB0byBhbHJlYWR5IHNwbGl0DQo+Pj4+PiB0aGlzIERU
IHVwPw0KPj4+Pj4gVG8gaGF2ZSBhIGJhc2UgLmR0c2ksIGJhc2ljYWxseSB0aGlzIGZpbGUgd2l0
aG91dCAvY3B1cyBhbmQNCj4+Pj4+IC9zb2MvcGxpYywNCj4+Pj4+IHRoZW4gaGF2ZSBhIFJJU0Mt
ViBzcGVjaWZpYyBmaWxlIHdpdGgganVzdCB0aG9zZSwgaW5jbHVkaW5nIHRoZQ0KPj4+Pj4gYmFz
ZT8NCj4+Pj4+IFRoZXJlIGlzIHByZWNlZGVuY2UgZm9yIHRoaXMgYWNyb3NzLWFyY2goLWRpcmVj
dG9yaWVzKSBzaGFyaW5nDQo+Pj4+PiB3aXRoIHRoZQ0KPj4+Pj4gUmFzcGJlcnJ5IFBpIGFuZCBB
bGx3aW5uZXIgSDMvSDUgU29Dcy4NCj4+Pj4NCj4+Pj4gRm9yIHRob3NlIHBsYXlpbmcgYWxvbmcg
YXQgaG9tZSwgb25lIGV4YW1wbGUgaXMgdGhlIGFybTY0DQo+Pj4+IGJhbmFuYXBpIG0yDQo+Pj4+
IGR0cyB3aGljaCBsb29rcyBsaWtlOg0KPj4+Pj4gL2R0cy12MS87DQo+Pj4+PiAjaW5jbHVkZSAi
c3VuNTBpLWg1LmR0c2kiDQo+Pj4+PiAjaW5jbHVkZSAic3VuNTBpLWg1LWNwdS1vcHAuZHRzaSIN
Cj4+Pj4+ICNpbmNsdWRlIDxhcm0vc3VueGktYmFuYW5hcGktbTItcGx1cy12MS4yLmR0c2k+DQo+
Pj4+Pg0KPj4+Pj4gLyB7DQo+Pj4+PiAgICAgICAgIG1vZGVsID0gIkJhbmFuYSBQaSBCUEktTTIt
UGx1cyB2MS4yIEg1IjsNCj4+Pj4+ICAgICAgICAgY29tcGF0aWJsZSA9ICJiYW5hbmFwaSxicGkt
bTItcGx1cy12MS4yIiwNCj4+Pj4+ICJhbGx3aW5uZXIsc3VuNTBpLWg1IjsNCj4+Pj4+IH07DQo+
Pj4+DQo+Pj4+IEkgdGhpbmsgdGhpcyBpcyBhIHByZXR0eSBnb29kIGlkZWEsIGFuZCBwdXR0aW5n
IGluIHRoZSBtb2R1bGFyaXR5DQo+Pj4+IHVwDQo+Pj4+IGZyb250IHNlZW1zIGxvZ2ljYWwgdG8g
bWUsIHNvIHdoZW4gdGhlIGFybSBvbmUgZG9lcyBldmVudHVhbGx5DQo+Pj4+IGdldA0KPj4+PiBh
ZGRlZCBpdCBjYW4gYmUgZG9uZSBieSBvbmx5IHRvdWNoaW5nIGEgc2luZ2xlIGFyY2guDQo+Pj4N
Cj4+PiBUaGlzIGlzIG5vdCBmZWFzaWJsZSwgZHVlIHRvIHRoZSBkaWZmZXJlbnQgI2ludGVycnVw
dC1jZWxscy4gU2VlDQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvQ0FN
dUhNZFhIU01jclZPSCt2Y3JkUlJGK2kyVGtNY0Zpc0d4SE1CUFVFYThuVE1GcHp3QG1haWwuZ21h
aWwuY29tLw0KPj4+DQo+Pj4gRXZlbiBpZiB3ZSBzaGFyZSBzb21lIGZpbGUgYWNyb3NzIGFyY2hp
dGVjdHVyZXMsIHlvdSBzdGlsbCBoYXZlIHRvDQo+Pj4gdXBkYXRlIGZpbGVzDQo+Pj4gaW4gYm90
aCBwbGFjZXMgdG8gZ2V0IHRoZSBpbnRlcnJ1cHRzIHByb3BlcnRpZXMgY29ycmVjdC4NCj4+Pg0K
Pj4+IEkgZ2V0IHRoZSBkZXNpcmUgdG8gZGVkdXBsaWNhdGUgdGhpbmdzLCBidXQgd2UgYWxyZWFk
eSBkZWFsIHdpdGgNCj4+PiB1cGRhdGluZyB0aGUNCj4+PiBzYW1lL3NpbWlsYXIgbm9kZXMgYWNy
b3NzIHNldmVyYWwgU29Dcywgc28gdGhhdCBpcyBub3RoaW5nIG5ldy4gSQ0KPj4+IHRoaW5rIGl0
IHdvdWxkDQo+Pj4gYmUgbW9yZSBjb25mdXNpbmcvY29tcGxpY2F0ZWQgdG8gaGF2ZSBhbGwgb2Yg
dGhlIGludGVycnVwdHMNCj4+PiBwcm9wZXJ0aWVzDQo+Pj4gb3ZlcnJpZGRlbiBpbiBhIHNlcGFy
YXRlIGZpbGUuDQo+Pg0KPj4gWWVhaCwgc2hvdWxkIG1heWJlIGhhdmUgY2lyY2xlZCBiYWNrIGFm
dGVyIHRoYXQgY29udmVyc2F0aW9uLCB3b3VsZA0KPj4gaGF2ZSBiZWVuDQo+PiBuaWNlIGJ1dCBp
ZiB0aGUgRFRDIGNhbid0IGRvIGl0IG5pY2VseSB0aGVuIHcvZS4NCj4gDQo+IFdlbGwsIG1heWJl
IHdlIGNhbiBvdmVydXNlIHRoZSBmYWNpbGl0eSBvZiBDIHByZXByb2Nlc3Nvcj8NCj4gDQo+IGUu
Zy4NCj4gDQo+IGBgYA0KPiAvLyBGb3IgQVJNDQo+ICNkZWZpbmUgU09DX1BFUklQSEVSQUxfSVJR
KG4pIEdJQ19TUEkgbg0KPiAvLyBGb3IgUklTQy1WDQo+ICNkZWZpbmUgU09DX1BFUklQSEVSQUxf
SVJRKG4pIG4NCj4gYGBgDQo+IA0KDQpHZWVydCBwb2ludGVkIG91dCB0aGF0IHRoaXMgaXMgbm90
IHBvc3NpYmxlIChhdCBsZWFzdCBvbiB0aGUgUmVuZXNhcw0Kc3R1ZmYpIGJlY2F1c2UgdGhlIEdJ
QyBpbnRlcnJ1cHQgbnVtYmVycyBhcmUgbm90IHRoZSBzYW1lIGFzIHRoZQ0KUExJQydzICYgdGhl
IERUQyBpcyBub3QgYWJsZSB0byBoYW5kbGUgdGhlIGFkZGl0aW9uOg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtcmlzY3YvQ0FNdUhNZFhIU01jclZPSCt2Y3JkUlJGK2kyVGtNY0Zpc0d4
SE1CUFVFYThuVE1GcHp3QG1haWwuZ21haWwuY29tLw0KDQpUaGFua3MsDQpDb25vci4NCg0K
