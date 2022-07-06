Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464B5688EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiGFNEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiGFNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:04:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152331104;
        Wed,  6 Jul 2022 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657112680; x=1688648680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UF/aGV++TCQo7dszZsiJWLjQbEbO0c/Xutad3UoW4vY=;
  b=QIVfD7I6Q7VtPSMuQti8OdTxn9rohbP7E3gtqzr0zdl2C6aCgrspCKCg
   UEwJoyR3mqiymUqP/pTWVjhIrrhT0Pxw698kirjf6cUh3xWH237O6i2cg
   oj3Vxf9+pdBDOOpk4QtTC1AVDmaLkL3dIy0D6MSzoIaFgxX195FjOCykT
   h/+ZkiSwUPb6PqCII8hdQ5vQt42icY8DAbu/B+nlM1UpF7hULctoti9sD
   EYdetVboV2HWvDw5SBsNKxB6yu76C0owGStE39f97M/5Q7lgp9o/KyBwV
   rZymbAqhbcUoCLUt5LDduMD4gB2x5oqgBWxclVFSr/Io0Vmi6FU9Shrox
   g==;
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="171272253"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 06:04:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 06:04:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 06:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdhIcU4Mm9WCb+cpBkFKsXPz1VZwYBDfHpTjOBljzNhy8iif1QSixWE6MFPiFw5uNpLoKYLY7NDOLs77mNQ+VzPS5kEAwD5WV2OAAvw074NFis5yYJT17fcFSn4LXK7ykh1DtVyBbBmwhMeOJjGyAbgST/BEvjlfmYRVc0YmjLsSNkRa3CEHHRaFNiQwmutiLQoYi+cTRfvLRDLpJxs2zrq6txsmaVAClx8eZXiilhwXEBs44m5MY+/1BBK+kB/byYql0tYhvRhZxdB5moRGxEEa/N8MEWt9/qA95kz1fFLf7eqBABjxdluy3g3gT6xXd1L+sODCz6QtnMkXC/UA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF/aGV++TCQo7dszZsiJWLjQbEbO0c/Xutad3UoW4vY=;
 b=Q8Z6plUaX4M+80wxCQxS5IYDsODQH0SigngXaKdDR8LpBgTUtDgUz4/yqNGH943eJ9HgxKCrDsDvett+E/TsAy6AN51TXDpkweZQS9GoFWmAHcbZxKjT3UxoDOBvXOCF1mFmnrdN4DhR2tpiWPEcwxxw02xgp4j764X2RzrjpfIO7OwkeqDWSS39e6cRBqvHWScdW097kAcO5plCmk6KdzcThnsTRtuGhRxnzPIO6Y+hy2tnlUxspIYXqP8AMtq5OYVPsHe3bM+5d65tqkZ6y+rDWCO5W7+NQtHmFcWpgbkYSs9qvjxF1AbdPqESDluj65T0+84nddCZ1uM98Hilpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF/aGV++TCQo7dszZsiJWLjQbEbO0c/Xutad3UoW4vY=;
 b=lwuakXBdBuWfeH6zvrV6kqZm+xsT37xtS2uRW6lliZiV5OYIUhQ03OteL0zLJMkc1xJTZvfMUqxrTchlUmKr8LgE7TDvuK9y2ZDkZBmnUCC+nLvcGL5sx6aAk2Q9EADhCi3jh86SVrpQ2gFlYi3Rk1KOgsCZUBJBF1NgUcpYHaM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1876.namprd11.prod.outlook.com (2603:10b6:404:ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 13:04:24 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 13:04:24 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Daire.McNamara@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Brice.Goglin@inria.fr>
Subject: Re: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Topic: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Index: AQHYkKIdHc6oV2H//EKJV+LfcdW+Dq1wN82AgAAD8QCAACn8AIAArIoAgAA+T4A=
Date:   Wed, 6 Jul 2022 13:04:24 +0000
Message-ID: <bcc3fc6c-1ff8-3db6-5aa9-beed2d0ea41b@microchip.com>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
 <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
 <fb7be22c-cf19-0e06-f231-bb5b9167e179@microchip.com>
 <20220706092126.k6zaknwcwzyg22ak@bogus>
In-Reply-To: <20220706092126.k6zaknwcwzyg22ak@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d85c8ff9-b5e4-4e76-2408-08da5f500ccc
x-ms-traffictypediagnostic: BN6PR11MB1876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFMFj5RFOxfZ9Nwgzmu3hXr6tEiWLCyrw+OCpBgGjZXHPccJhgajLXhaeyR+mHl2p8fyxDWtFvI9QVJDz2qnI9OGUzEtTiiOGNPBOgJ/ujNodKua4fsETBzr+Ee7vxU/fmb2qqksp2VUQIW4nSNu85SVdHDSJyINhy8Rt/JKo/asBVmlx4wKPjRPiTBnBUSUHpzN6IGoOUu36hFMwOEfgXNFJmADP3jbEdsHbhl7CnFeLas1OidWSM4s6/3+33BS7XQClO3yCcQLok64b0oO72HjOdV+0WTpO/adGzyR3VqR4YaFwYMQnqijqi26ASi1P494a/a3G+E081qySK7cfssBN4gDL7xw1owQyuQEmnieA94a0g6sSqrd3cPuOlAh+oF6QLdvtzMn+sXc1cpz/DXtltQ3Utj6bB0OPlE135f1rWnVOzqlG2p6XBJ7k58DdE96ikfw//+UEPJFeAZS34Q/Pi6nfjE2VZ3sBCf5UiVGSRw5zv03Kisl7098HMNKEx9fgWy3Xm7CF4iO8jtHCUMsYp0Q4cd9wqMQN7qb0kSxRGs4iPDKqpSF2x+9/pErim0P2j1Zczwz21/IogLMRyIy8JAZyGD4tzUbv7DVIKdDwiUDpBmTX9JMZPfHIcJHmH9FdBz/RVry2ihLit+FegXYymRnrLFDGktyNYoOHg0xW7IkldL2WuN8Wpja3pL/qEsqocr9vOvC4pLmdZ7Ubh7vSOyFo1aLOCSrX0AuF5ToNtPKK4SEXwGaXmJMC3+vMpEo1R68yGB7k6hc2fKEyFPQlX1fq+HaflJa5+NgCWCD4vN9P1qk7+SnkVKJ1N+tiVTswXUlcsagJs9omAhzF1NpcEtiVhRVsUHsY82B5XjMoKfm8xkGc2VqleDATgDr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(366004)(396003)(136003)(6512007)(2616005)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8936002)(7416002)(4326008)(8676002)(91956017)(5660300002)(31696002)(36756003)(6916009)(41300700001)(86362001)(31686004)(6506007)(2906002)(6486002)(186003)(26005)(53546011)(478600001)(83380400001)(122000001)(38070700005)(316002)(54906003)(71200400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHNBRDlGVDFLYUtRSVlXRVBKMmRBbVREdGVYOEVMTFJucUJwRUQ2Y3Uwb3hr?=
 =?utf-8?B?eGdZcGVwenljaDNVN2hKQVlWSUo1UTJTdW9yTXhXY1puaVdxTjhydlF4QmhF?=
 =?utf-8?B?M2hrQzFVUC9HbC93Z21CVDdQeDZYWmFDRVJCU0hWL1h4dFpQRU9zK2pnME55?=
 =?utf-8?B?Wm5STW5pSld3NzA3MFN3ek04eWxVUUIycy94eWxlNElHYUJxNmliN2FKR0VR?=
 =?utf-8?B?RGRPbWVYZjVVb0dBbWd0b3dobWJYaW9WWHd2ODYyWWMybVFDUVF5NHdzeTh0?=
 =?utf-8?B?cnFNaFN1cUorNmQzcFM2cVBJYkFwOUF0T2kxMXNOckJRZm8yNzh2bkpXNTNR?=
 =?utf-8?B?WmJCZ1ZLdEFOc0hQcHJibkhmSXNEOEhoT0dtTHJMQ1FubzBkVVdkazhQaDFN?=
 =?utf-8?B?dXhBQVJKWit6dFJ1UEo0bmp6YVRpM1RyNFE4L2JUWEVGUS95cmdNWmdNaG13?=
 =?utf-8?B?ZDRvZlVQOEM2K0tSSU1wNFN1bkFYOUpZanc2LzFJcnRwU1ZUWFozUHFRQjNo?=
 =?utf-8?B?QlJ6Vy9ISjdKRE5kei9jV2JiV3J3Z09jTDloc0ZGYnlhdmRrR0hzZGRFSmVC?=
 =?utf-8?B?U1RYb3ZXNnNxdCsyeWRGclo2cWJ2TGp6d29GYmF0SVBZcG53STVaQ0swTE9N?=
 =?utf-8?B?ZlJqc0Y2WlljdHRzK0F6VFEvSVE2MEt0Q0NWaUZqQUdOSDVmT1l4TzhXSEhi?=
 =?utf-8?B?TkZrdjlGQk9ZaWV6OEdZVmdsY241RnNLL09Dc2YyR0tmV2Rad1FaZHhiMmJB?=
 =?utf-8?B?eGw3L0N5dW5FMXFrRllxMy9VYjZGVG0xNUZnY0dOU2dmckt6Q2lobWFoeG5X?=
 =?utf-8?B?U3cwanVZTkE1UHdLTlZTaldxUTNGM1doZnMwSmI2ZytPdmlZOFJDa0JPaFlr?=
 =?utf-8?B?eTh4KzdMd3VCNUs0ZXRoS05UWVgyd1hHVGc4VU5xL2poMy9YcitnSmpmYjA1?=
 =?utf-8?B?d0E3L2NTZWlVT2dkRi84M2lENlRvRXRpMitaQ3dqL2dZQ3VOT3QvaHhaQytP?=
 =?utf-8?B?clVYOHhQemFKWldnaG8xTStXanc1d1VCcU9icm1xWlJSbkcyekpNd0F2ck41?=
 =?utf-8?B?eHorRXZtbmtVTC9JVVdKQWdLbEZuSVRiemZKT1MvRW91cWlQWkI0VVJDSGNn?=
 =?utf-8?B?R204dlJ4Vm9DclFOYmZtSlRpbXdYb2pxUVV1ZGVKaUdWZXNJNTN1QURyL1k4?=
 =?utf-8?B?OGIxWElrYmdkUDRwcHdnVGQ5WERnSGNPQlArRWVDZVpodi9nOWxKQ0UybXdw?=
 =?utf-8?B?QytaZndPY2lYd2JraVBRdHJMS3BaR2RvUllVQ1lSU0NHbjBYeldzSnlzK3dC?=
 =?utf-8?B?UExlbXJMVzZ2YXVxZjdqb3lSa251VGRKR3p2ZEM0ZFdGcWNRQVZibW8wd2F6?=
 =?utf-8?B?LzlEWHV3OGlFQzhlZXF6czNqaGl2ZnU1cVp4dy92WUNvRXlmUXloMHk3cWd1?=
 =?utf-8?B?ZjZoYkpBc0pvYXZoYi9ieUhCZ1htUmVPbmZCb1J1MXpGd0hsaWJCd01ueXJi?=
 =?utf-8?B?a0d2UkpQMUZxczNBeHMrTlhxYTVDenpiUWRzVWFiOVcwM0l4M0swZldGZnhS?=
 =?utf-8?B?dWN6YUsyNWtwVldUUzdpMWUySWhLd1paTmw1bm5ZMUdQRVJrOW9lV3IvZTFH?=
 =?utf-8?B?cWhneS95WXlpdXR1clBpd1paUlJDS0xWLy9FbzNOcVlFUUkxSXA4V3YvZHBB?=
 =?utf-8?B?bTQ1VGNjbmNaaWp1eFYreTBUamRCNnlmVlJXZXl2Zy85MGZvbVdNVFo5bEtQ?=
 =?utf-8?B?OTE1NU1oM3BTazN5ZDgybE92WnltQis1NkphQ1d4OEFWZTRQN1pjZGFGN1RQ?=
 =?utf-8?B?enY3U2dpVzZLd0VRYjQ1L095SGt4ZzZrRURpaGwwUDNPWkhna1FDUnZnbUhp?=
 =?utf-8?B?OEpDSkNHcERtVTFkZjRXUVZUOHNJT3Q4NnE5QndiVThac0xuUCtkOUZsY1Q0?=
 =?utf-8?B?ZEpHZEVQdzJMbVZTbTVWNFZEQW9pekl3Qi9lS2c3UHVaaVFMNlNpZDNES0Jh?=
 =?utf-8?B?Vk1KeXNxQzlkNElDVUtVUDgrSnA2NFpLQTg0NjVySktwUWdYNTZaWHBXRVhV?=
 =?utf-8?B?U3ZycVh3MFk0TGVoYVluUFlRVE85UVoyQ3YzeVhZNWlXaVdUSHlPb2g3MnZC?=
 =?utf-8?Q?5m16GUmxeIioLP/sAcmoQkjV8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C390B3369C34A64DB7D3D76D230A3A50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85c8ff9-b5e4-4e76-2408-08da5f500ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 13:04:24.2761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKniBRUqipcOxvQ7HP/Cl7MjP3vY5byUcuC/zr+jksiPJ7FFWvTK9Sp9CT6OWleP6VFJYPINT1C9RgPlEKn/llMxsWyA85oUz4z9rHCzZrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1876
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDcvMjAyMiAxMDoyMSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgSnVsIDA1LCAyMDIyIGF0IDExOjAz
OjU0UE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+
PiBPbiAwNS8wNy8yMDIyIDIxOjMzLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4+Pg0KPj4+DQo+Pj4gT24gMDUvMDcvMjAyMiAyMToxOSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0K
Pj4+PiBPbiBUdWUsIEp1bCAwNSwgMjAyMiBhdCAwODowNDozMVBNICswMTAwLCBDb25vciBEb29s
ZXkgd3JvdGU6DQo+Pj4+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2No
aXAuY29tPg0KPj4+Pj4NCj4+Pj4+IEl0IHdhcyByZXBvcnRlZCB0byBtZSB0aGF0IHRoZSBIaXZl
IFVubWF0Y2hlZCBpbmNvcnJlY3RseSByZXBvcnRzDQo+Pj4+PiBpdHMgdG9wb2xvZ3kgdG8gaHds
b2MsIGJ1dCB0aGUgU3RhckZpdmUgVmlzaW9uRml2ZSBkaWQgaW4gWzBdICYNCj4+Pj4+IGEgc3Vi
c2VxdWVudCBvZmYtbGlzdCBlbWFpbCBmcm9tIEJyaWNlICh0aGUgaHdsb2MgbWFpbnRhaW5lciku
DQo+Pj4+PiBUaGlzIHR1cm5lZCBvdXQgbm90IHRvIGJlIGVudGlyZWx5IHRydWUsIHRoZSAvZG93
bnN0cmVhbS8gdmVyc2lvbg0KPj4+Pj4gb2YgdGhlIFZpc2lvbkZpdmUgZG9lcyB3b3JrIGNvcnJl
Y3RseSBidXQgbm90IHVwc3RyZWFtLCBhcyB0aGUNCj4+Pj4+IGRvd25zdHJlYW0gZGV2aWNldHJl
ZSBoYXMgYSBjcHUtbWFwIG5vZGUgdGhhdCB3YXMgYWRkZWQgcmVjZW50bHkuDQo+Pj4+Pg0KPj4+
Pj4gVGhpcyBzZXJpZXMgYWRkcyBhIGNwdS1tYXAgbm9kZSB0byBhbGwgdXBzdHJlYW0gZGV2aWNl
dHJlZXMsIHdoaWNoDQo+Pj4+PiBJIGhhdmUgdGVzdGVkIG9uIG1wZnMgJiBmdTU0MC4gVGhlIGZp
cnN0IHBhdGNoIGlzIGxpZnRlZCBkaXJlY3RseQ0KPj4+Pj4gZnJvbSB0aGUgZG93bnN0cmVhbSBT
dGFyRml2ZSBkZXZpY2V0cmVlLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gUmV2aWV3ZWQtYnk6IFN1ZGVl
cCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQo+Pj4+DQo+Pj4+IEkgd291bGQgcmVjb21t
ZW5kIHRvIGhhdmUgc2FuZSBkZWZhdWx0cyBpbiBjb3JlIHJpc2MtdiBjb2RlIGluIGNhc2Ugb2YN
Cj4+Pj4gYWJzZW5jZSBvZiAvY3B1LW1hcCBub2RlIGFzIGl0IGlzIG9wdGlvbmFsLiBUaGUgcmVh
c29uIEkgbWVudGlvbmVkIGlzIHRoYXQNCj4+Pj4gQ29ub3IgbWVudGlvbmVkIGhvdyB0aGUgZGVm
YXVsdCB2YWx1ZXMgaW4gYWJzZW5jZSBvZiB0aGUgbm9kZSBsb29rZWQgcXVpdGUNCj4+Pj4gd3Jv
bmcuIEkgZG9uJ3Qga25vdyBpZiBpdCBpcyBwb3NzaWJsZSBvbiBSSVNDLVYgYnV0IG9uIEFSTTY0
IHdlIGRvIGhhdmUNCj4+Pj4gZGVmYXVsdCB2YWx1ZXMgaWYgYXJjaF90b3BvbG9neSBmYWlscyB0
byBzZXQgYmFzZWQgb24gRFQvQUNQSS4NCj4+Pj4NCj4+Pg0KPj4+IFllYWggdGhlIGRlZmF1bHRz
IGFyZSBhbGwgLTEuIEknbGwgYWRkIHNvbWUgc2FuZSBkZWZhdWx0cyBmb3IgYSB2Mi4NCj4+PiBU
aGFua3MsDQo+Pj4gQ29ub3IuDQo+Pg0KPj4gSSBzaGFtZWxlc3NseSBzdG9sZSBmcm9tIGFybTY0
Li4uIFNlZW1zIHRvIHdvcmssIGJ1dCBoYXZlIGRvbmUgbWluaW1hbA0KPj4gdGVzdGluZyAob25s
eSBQb2xhckZpcmUgU29DKS4NCj4+DQo+PiBBdXRob3I6IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQo+PiBEYXRlOiAgIFdlZCBKdWwgNiAwMDowMDozNCAyMDIyICsw
MTAwDQo+Pg0KPj4gICAgICByaXNjdjogYXJjaC10b3BvbG9neTogYWRkIHNhbmUgZGVmYXVsdHMN
Cj4+DQo+PiAgICAgIFJJU0MtViBoYXMgbm8gc2FuZSBkZWZhdWx0cyB0byBmYWxsIGJhY2sgb24g
d2hlcmUgdGhlcmUgaXMgbm8gY3B1LW1hcA0KPj4gICAgICBpbiB0aGUgZGV2aWNldHJlZS4gQWRk
IHNhbmUgZGVmYXVsdHMgaW4gfnRoZSBleGFjdCBzYW1lIHdheSBhcyBBUk02NC4NCj4+DQo+PiAg
ICAgIFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5j
b20+DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdG9wb2xvZ3ku
aCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdG9wb2xvZ3kuaA0KPj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uNzFjODA3MTBmMDBlDQo+PiAtLS0gL2Rldi9u
dWxsDQo+PiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgNCj4+IEBAIC0w
LDAgKzEsMTMgQEANCj4+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5
ICovDQo+PiArLyoNCj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjIgTWljcm9jaGlwIFRlY2hub2xv
Z3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYg
X0FTTV9SSVNDVl9UT1BPTE9HWV9IDQo+PiArI2RlZmluZSBfQVNNX1JJU0NWX1RPUE9MT0dZX0gN
Cj4+ICsNCj4+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvdG9wb2xvZ3kuaD4NCj4+ICsNCj4+ICt2
b2lkIHN0b3JlX2NwdV90b3BvbG9neSh1bnNpZ25lZCBpbnQgY3B1aWQpOw0KPj4gKw0KPj4gKyNl
bmRpZiAvKiBfQVNNX1JJU0NWX1RPUE9MT0dZX0ggKi8NCj4+IFwgTm8gbmV3bGluZSBhdCBlbmQg
b2YgZmlsZQ0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlIGIvYXJj
aC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCj4+IGluZGV4IGM3MWQ2NTkxZDUzOS4uOTUxODg4MmJh
NmY5IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCj4+ICsrKyBi
L2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlDQo+PiBAQCAtNTAsNiArNTAsNyBAQCBvYmoteSAr
PSByaXNjdl9rc3ltcy5vDQo+PiAgIG9iai15ICArPSBzdGFja3RyYWNlLm8NCj4+ICAgb2JqLXkg
ICs9IGNhY2hlaW5mby5vDQo+PiAgIG9iai15ICArPSBwYXRjaC5vDQo+PiArb2JqLXkgICs9IHRv
cG9sb2d5Lm8NCj4+ICAgb2JqLXkgICs9IHByb2Jlcy8NCj4+ICAgb2JqLSQoQ09ORklHX01NVSkg
Kz0gdmRzby5vIHZkc28vDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3Nt
cGJvb3QuYyBiL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYw0KPj4gaW5kZXggZjFlNDk0OGE0
YjUyLi5kNTUxYzdmNDUyZDQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9zbXBi
b290LmMNCj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYw0KPj4gQEAgLTMyLDYg
KzMyLDcgQEANCj4+ICAgI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5oPg0KPj4gICAjaW5jbHVkZSA8
YXNtL3NiaS5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL3NtcC5oPg0KPj4gKyNpbmNsdWRlIDxhc20v
dG9wb2xvZ3kuaD4NCj4+DQo+PiAgICNpbmNsdWRlICJoZWFkLmgiDQo+Pg0KPj4gQEAgLTQwLDYg
KzQxLDggQEAgc3RhdGljIERFQ0xBUkVfQ09NUExFVElPTihjcHVfcnVubmluZyk7DQo+PiAgIHZv
aWQgX19pbml0IHNtcF9wcmVwYXJlX2Jvb3RfY3B1KHZvaWQpDQo+PiAgIHsNCj4+ICAgICAgICAg
IGluaXRfY3B1X3RvcG9sb2d5KCk7DQo+PiArDQo+PiArICAgICAgIHN0b3JlX2NwdV90b3BvbG9n
eShzbXBfcHJvY2Vzc29yX2lkKCkpOw0KPj4gICB9DQo+Pg0KPj4gICB2b2lkIF9faW5pdCBzbXBf
cHJlcGFyZV9jcHVzKHVuc2lnbmVkIGludCBtYXhfY3B1cykNCj4+IEBAIC0xNjEsNiArMTY0LDcg
QEAgYXNtbGlua2FnZSBfX3Zpc2libGUgdm9pZCBzbXBfY2FsbGluKHZvaWQpDQo+PiAgICAgICAg
ICBtbWdyYWIobW0pOw0KPj4gICAgICAgICAgY3VycmVudC0+YWN0aXZlX21tID0gbW07DQo+Pg0K
Pj4gKyAgICAgICBzdG9yZV9jcHVfdG9wb2xvZ3koY3Vycl9jcHVpZCk7DQo+PiAgICAgICAgICBu
b3RpZnlfY3B1X3N0YXJ0aW5nKGN1cnJfY3B1aWQpOw0KPj4gICAgICAgICAgbnVtYV9hZGRfY3B1
KGN1cnJfY3B1aWQpOw0KPj4gICAgICAgICAgdXBkYXRlX3NpYmxpbmdzX21hc2tzKGN1cnJfY3B1
aWQpOw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3RvcG9sb2d5LmMgYi9hcmNo
L3Jpc2N2L2tlcm5lbC90b3BvbG9neS5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi43OTliMzQyM2UwYmMNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBi
L2FyY2gvcmlzY3Yva2VybmVsL3RvcG9sb2d5LmMNCj4+IEBAIC0wLDAgKzEsMzAgQEANCj4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+PiArLyoNCj4+ICsgKiBC
YXNlZCBvbiB0aGUgYXJtNjQgdmVyc2lvbiwgd2hpY2ggd2FzIGluIHR1cm4gYmFzZWQgb24gYXJt
MzIsIHdoaWNoIHdhcw0KPj4gKyAqIHVsdGltYXRlbHkgYmFzZWQgb24gc2gncy4NCj4+ICsgKiBU
aGUgYXJtNjQgdmVyc2lvbiB3YXMgbGlzdGVkIGFzOg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAx
MSwyMDEzLDIwMTQgTGluYXJvIExpbWl0ZWQuDQo+PiArICoNCj4+ICsgKi8NCj4+ICsjaW5jbHVk
ZSA8bGludXgvYXJjaF90b3BvbG9neS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC90b3BvbG9neS5o
Pg0KPj4gKyNpbmNsdWRlIDxhc20vdG9wb2xvZ3kuaD4NCj4+ICsNCj4+ICt2b2lkIHN0b3JlX2Nw
dV90b3BvbG9neSh1bnNpZ25lZCBpbnQgY3B1aWQpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3Qg
Y3B1X3RvcG9sb2d5ICpjcHVpZF90b3BvID0gJmNwdV90b3BvbG9neVtjcHVpZF07DQo+PiArDQo+
PiArICAgICAgIGlmIChjcHVpZF90b3BvLT5wYWNrYWdlX2lkICE9IC0xKQ0KPj4gKyAgICAgICAg
ICAgICAgIGdvdG8gdG9wb2xvZ3lfcG9wdWxhdGVkOw0KPj4gKw0KPj4gKyAgICAgICBjcHVpZF90
b3BvLT50aHJlYWRfaWQgPSAtMTsNCj4+ICsgICAgICAgY3B1aWRfdG9wby0+Y29yZV9pZCA9IGNw
dWlkOw0KPj4gKyAgICAgICBjcHVpZF90b3BvLT5wYWNrYWdlX2lkID0gY3B1X3RvX25vZGUoY3B1
aWQpOw0KPj4gKw0KPj4gKyAgICAgICBwcl9pbmZvKCJDUFUldTogY2x1c3RlciAlZCBjb3JlICVk
IHRocmVhZCAlZFxuIiwNCj4+ICsgICAgICAgICAgICAgICAgY3B1aWQsIGNwdWlkX3RvcG8tPnBh
Y2thZ2VfaWQsIGNwdWlkX3RvcG8tPmNvcmVfaWQsDQo+PiArICAgICAgICAgICAgICAgIGNwdWlk
X3RvcG8tPnRocmVhZF9pZCk7DQo+PiArDQo+PiArdG9wb2xvZ3lfcG9wdWxhdGVkOg0KPj4gKyAg
ICAgICB1cGRhdGVfc2libGluZ3NfbWFza3MoY3B1aWQpOw0KPj4gK30NCj4+DQo+IA0KPiBMb29r
cyBnb29kLiBBZ2FpbiBwYWNrYWdlIGlkIGlzIG5vdCBjbHVzdGVyLiBUaGlzIGlzIHdoYXQgbXkg
c2VyaWVzIGlzDQo+IGFkZHJlc3NpbmcuIFNvIHVwZGF0ZSB0aGUgbG9nIGFzIFBhY2thZ2UgaW5z
dGVhZCBvZiBDbHVzdGVyIGFib3ZlLiBUaGUNCj4gY2x1c3RlciBpZCB3aWxsIGJlIC0xIHVubGVz
cyB5b3UgY2FuIGdldCB0aGF0IGZvciBEVC4NCj4NCg0KRllJIEkgdG9vayB0aGF0IGRpcmVjdGx5
IGZyb20gYXJtNjQ6DQphcmNoL2FybTY0L2tlcm5lbC90b3BvbG9neS5jOkw1NyAobmV4dC0yMDIy
MDcwNikNCg0KCXByX2RlYnVnKCJDUFUldTogY2x1c3RlciAlZCBjb3JlICVkIHRocmVhZCAlZCBt
cGlkciAlIzAxNmxseFxuIiwNCgkJIGNwdWlkLCBjcHVpZF90b3BvLT5wYWNrYWdlX2lkLCBjcHVp
ZF90b3BvLT5jb3JlX2lkLA0KCQkgY3B1aWRfdG9wby0+dGhyZWFkX2lkLCBtcGlkcik7DQoNCg==
