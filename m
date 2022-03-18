Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFB4DD98A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiCRMSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiCRMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:18:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F085F2103;
        Fri, 18 Mar 2022 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647605851; x=1679141851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L1XLpJiGUBu7WteYTTTz7uGru11LuwH4CWnyGRIPe58=;
  b=MLilF8Gcko7ooTm0suJ4UkKAEQ3fPJUkPlGiGwUL2j4ppZv2Zgo64MAH
   xYJp0Dm2Hrz9AmGMJ3Zak42zZheTanpxLCIiWlgDGbo3XttH/WEPUMWoM
   dqsx/m+m+5tCSRDQcYDZrbFTg1uZYVOk3W7aMzRkGayMSYoRqY99Nm8Rn
   7iptgnkTUAMev8WLDEQmcOTZ/S1hTTN14bAmn/yGVXkwcy2ag4gSSdiDe
   XTQpxDGlAIij7+FmB/6hVYZlmDNYmgkZ+mUfvxjEcEyyGuSetLyGOOZT+
   MIQln0bF+KtmBPPJNPn9B2rxE3LXED0Zwyi1PDLcrrnDf0YYtG/RVitP2
   g==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643698800"; 
   d="scan'208";a="156924677"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Mar 2022 05:17:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Mar 2022 05:17:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 18 Mar 2022 05:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkeO/CuVNV6wDCvzyG8W+hU8nZqAus9hf1gV3PmGcMVb1B+5YpUThAiJZ7sbPyGoMNvZ9+D7UYcyg7YDZN38CrWW+/WqnugqkohJ1tA7YxyGKfOkQ0MvPKjFjPiCEOUtenndEAlNfGvgGlTODbIwZn328HbHSyoyPvVgtC33Pubqw9peorVGRsxcINkjFQjFSRiLGroyGFFbhAoL47toPLMPOcieukAGQk3yxAdbC9818edo70x2o8711oElW4No3FJ/faWCsrubCaie62EVbaoiOnb512eb2d2R1dDA4JOQAyqNHhnVN7CP5ldTbHakciSajQImMCU6cl4zdOvzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1XLpJiGUBu7WteYTTTz7uGru11LuwH4CWnyGRIPe58=;
 b=L6qLFohBLXd7dIy/ErfqkyFtitw57vrdUZCrDd7nE6VlJnOiCSN65hWkiP7dZjHCI5tp90JGWBHTPMoegMoOGP8gPZwBZtCSKgDTBISwz8E+sjJjfffnY1LtovdrxrThyvAI0ip4dKCj+i9LMql9WLPL3mh4YUzizqfOgZH9X+b1lnY0zR9Q5Db9OlL9m4xYFq1e0wmxwM7P1SvjSZoPU/2sWAw20ZlNmyCLW4RUyTmox1i1Ymmxz/EMu4Ye35Ol8qKCgGH4NDP7BJopY24sJMDWyr0qrCh6f+jjJYmv97KmJuWmBcCV1CkOEtclzEiOhtBOd1tzpYQoeSk84wATKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1XLpJiGUBu7WteYTTTz7uGru11LuwH4CWnyGRIPe58=;
 b=lZH5kYQZzZX5zTw6uQL4wr66k39Y9LoTB1h62gdxDz//XwAVh2CxUIj1Ni/rjvi36SugJUKAm5WBJ3d805puV3Llc6QgQPD2h48WVpyvLkjg6RFDJRD/jXJQPhLfeYJwTYkvU25o/gTHlqfDGR3AodOEjaf3rbSmxiDF8tKSLDk=
Received: from PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22)
 by DM6PR11MB3564.namprd11.prod.outlook.com (2603:10b6:5:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 12:17:24 +0000
Received: from PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6922:3b5f:7242:3f52]) by PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6922:3b5f:7242:3f52%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 12:17:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>
CC:     <Nicolas.Ferre@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
Thread-Topic: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
Thread-Index: AQHYL6IUHEQBuBvGLkmRM0laLRQs8g==
Date:   Fri, 18 Mar 2022 12:17:24 +0000
Message-ID: <3e17aa8b-f6e5-e2c1-bd1d-8950d23c3e49@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-4-michael@walle.cc>
 <a33f0c73-df49-5a22-14b3-0059f7d6b827@microchip.com>
 <2e0aefc90a80bdf13df0e59857c52ca7@walle.cc>
 <bf005cd2-4c83-1552-8282-d229eacc51f3@microchip.com>
 <219ffd086373c453d5d0aad897cd2d41@walle.cc>
In-Reply-To: <219ffd086373c453d5d0aad897cd2d41@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d900d59-4a02-4418-3412-08da08d942a8
x-ms-traffictypediagnostic: DM6PR11MB3564:EE_
x-microsoft-antispam-prvs: <DM6PR11MB35647205A9A8BF434F2AEDFF87139@DM6PR11MB3564.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4nNh79507DuKECJfFMEeZC9OPkAiUohqhy//VsGdwV/ktA5EZzkTI+3tDyjcJe+NvmGD4GMDgxX0N1RinZj/ow8+BMM0zY/JSC4mVWEpHB5ZRvY8mo8nK14fXbfbhJnP0hI4j6tu7wo0+lU3Br87es9yUSEdqYISZgezW9Fes+TED5qHWz59GY7pLKNp5XSNckh+CSCmCsZ+e5v/AOjg85JIRUEKDlMxEudB8HgACgFY0z+ysAlQwnOxLqWMG7qZb61bQKsYh38Xr41ZbTznyGo6H3EJURH+7dozNNu/LxZPZBBMY4w0nyHe2zfBpYLyMR8dkKhjKWeMX3JW+mo8eKctQ6fr7p7f/LxMbSF1+lGj85SkH6gQiyfY5tldosWcACMal1RcpkVaTwufPNOJYEb53xFbbwTU0yQpr+nVCUNvNQvqNfIUYHna+kp8iMXNqKp89dKAdBzra3RcECpkQ0jyjR4FgpmtFqnUwT8hrUTx3A89bKK30byiIZ6k7H4QwCPvtWt/Z6pMZH/Cl+8ozOVQI2kD8XB5yOqEdL6iz6b3STDplGjcuKhBAv2LhPAOsxS7glSUsW0XlAfxpr1mtp5BXUcbauDGzbOMEVx3Vbxp4I4ZzZABlkAxCfazrZoGk82lNgx7atvVSKWm5t8+KGteAupBhWLDMs39ZZNv3muBe3fxfkYdkYoGnhEDXl/lYtW+bK0SL66QsC8+LjY/DMe/I73FjK4HMrAzlwCQRuMuGFv6Wx8ng0et9oMo7nUcNbBZYxcrRQgBNe2jjzxrmfSl9AdnkTNOTK6E7qUwTISfmdoeiRhngsj1nvnVyUd5xeBEnsJUnXXCX/7WDx9PgFNBZMS8z+Sd6OuNxo/h3YPAwtVL7Wf8QGQJm2+TDYmACMSsUJ0AF23VtHm/iyhqaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(966005)(8936002)(2906002)(71200400001)(76116006)(66946007)(64756008)(66556008)(31686004)(66446008)(66476007)(38070700005)(83380400001)(508600001)(36756003)(91956017)(4326008)(8676002)(38100700002)(54906003)(6636002)(316002)(122000001)(53546011)(5660300002)(31696002)(86362001)(7416002)(2616005)(186003)(110136005)(26005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2lIVENlcW9kQ2VFbHFSdFczUWVOeUlNTzFFQm5iS2phRGhxUnVnYUFXQjBr?=
 =?utf-8?B?TERlUFU1OVgwV1FaRkFZMGZvVUtlZ256dmFqNlJsSGJiNFZLN0llcHpSRFpw?=
 =?utf-8?B?d2hqK2lHL0lLNjM3ek5ZU2lGU3c1bnRqMm94SW1oZEtLM2ZTR29KQzlIVDFB?=
 =?utf-8?B?RU1sSjZla0pORFN4Tm1DL3dYUEMxMlhsSmRkOTdkMktubnIwaUlMNmxNRUl5?=
 =?utf-8?B?MUs2MnQ3MVpLUTg0ODg5V0VjTU9xcVZ6L3FQc215Z1o0eGx0Kzg4c3lrYzI1?=
 =?utf-8?B?TEVSeTcxRGFvaDNXbFFqNXA4TG5YTkpkVmc3L2NmaFNuQjNMTWttQnZxUTNu?=
 =?utf-8?B?K1pOc0Z5RnNFVzhJSXEyTkk3NW5iUHZuTnhucVlWdHJyTUNsYjJCVEJ5TWpG?=
 =?utf-8?B?NWFCTHhjL3BhQjBTZi9lVmd1a1FHNEdRbjg0SUpqdUd3bE5KMVovNnZxQ1lE?=
 =?utf-8?B?S2RFaXdSYzI0Tjk3REhUM1lCazh0NnpmUkxDVVVhOERob2F3MmZEZmhidXNk?=
 =?utf-8?B?S2k5QTdkdE8zQ281MGJVclZCUUxGTlp2cXRVYWNoYlBtS1BBRURhRldiam1U?=
 =?utf-8?B?LytUeWFFRjVPZnkzRmtjZGs3ZXpCR2NJRzFKYW1qeUNCREo5eVBrM0luL0VE?=
 =?utf-8?B?R2RYSXAyZUxRSi9DdXJOQUMyTVBJdWcwYlVNS21zQi9xYklKMXoxQitLRmpx?=
 =?utf-8?B?bWtKWTRTUFdIWEVCSDZFTUlYY0wwQjQrM3BJTTk2T080LzBKNTcrNGR6RnRy?=
 =?utf-8?B?b1VZejZEVmhQc1NkbnJjcXNmWXpnUlk1Rm0rb1hqV3BXWmF6ZUtTeXhZeEZE?=
 =?utf-8?B?cUhRZll6amF5bWlORVNvVHZpa1JCUEF1VXRKOW1EUDJYTEJ5NzVTSWxEQmxN?=
 =?utf-8?B?eUNEdGhHRC84di8rVDl5Y1NROWZ4NEdJWWUwZFpoVTA1V0dhZUJLdzFSTkg0?=
 =?utf-8?B?WXNWZkY4OEFnZG03VisvSThxZUFyYVR4bXFWcGhlWnRtQUdKTDFuSjhzQU9s?=
 =?utf-8?B?cm1kYmZQS0toMlR0cjYxMTN0SFNxYzF4NVNIRi95akhkMUt6M1o3Mlk2cktS?=
 =?utf-8?B?d2EzU3RsMnhMNmdYSGZJK3YwT1RLTFZ3aXJiZnJ4Sng4dDBvbHJVQ3QxZDVV?=
 =?utf-8?B?aHQySnFjWmVScmltc2QxYmFkODZjZzI0Y2FvWG55bXpQdkJZbkMzQTBSTDRC?=
 =?utf-8?B?SGUrdVJRaWJzVG9ST1NUbkVtbk1rc2Jibi9tWlJ3NUVqU21ldW1MMGQxN2ZJ?=
 =?utf-8?B?L280OFgzZmdqQlU2b05xMFpHQStIcnk4bUhGdlRLY2dtR2ZPYmRaV2g2c2Ru?=
 =?utf-8?B?bnNpdnBVemg4RVBJdmZDeHVPbDluUnRQMjBzaFJDNEpVT1J1SFdHY3BTL1lB?=
 =?utf-8?B?cTVuODRrdW9qdVUveGY4Nm95V1dUNHh6S2ZWVlIwUkFvclJaRWxucHZBYytC?=
 =?utf-8?B?UlNBU1lXUXhJTFFZVGhhSVZLZDYrUXpnVUVTVGwrVEVvelkzaXFKMTdBemRD?=
 =?utf-8?B?cGpnU0J2ejVBbTVKT3c1MkVRRjNaM3RCWWRicEdsb2VCQXBwODJOQW4xR2xt?=
 =?utf-8?B?RU5Ca2NKTUVVdklESG8xZENDKysweHgwcVo0YjNtQWUvSHJIenJiZ0lTMVZh?=
 =?utf-8?B?V2Z3ejhydWpBbldUSGRXbVZSSEJncVVmS0lmY3FVaHQxOGg3U3BYTmVUWTNO?=
 =?utf-8?B?ODRkU0xsWjJvY3hEaTVhVDRpN2lBREdaMUZCb29xTktrVjVSMkJsTXNydXRO?=
 =?utf-8?B?MWZXUW44M0swK2FZM1B4UG1NY0tnZGdDS1FRUHdMOUowK3E0UE9UVnA2dk04?=
 =?utf-8?B?YXBIRGRIdXROOUJNUTJOSmFoSkJ2eU1qb2syZTdYNE5xL1gzS1JMQTVvSTl5?=
 =?utf-8?B?YlhWci9YQ1RWTTdLeEFBZUhxUjhSMCtzcFNPVzVLS3dWc2VTT0NZUjlwKzha?=
 =?utf-8?B?ekRqc3ZOZzVyekN2M1VDOVdHbXB5OEdDTEJxVmo5SGlhV3JhNmxBWWR1bXgv?=
 =?utf-8?B?T0lIbWlCMTVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA4115A78220274096CE2D260B2DC81F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d900d59-4a02-4418-3412-08da08d942a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 12:17:24.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viX4QqoPnKKLxi0/9C08p3ZGyVwJ1zuUwLI0MXW3r2i+hqP4q0KlPGVdg2+O/8LIRyNoEmpnID3CqA4Vc9xADiEav9wxyKN6nJ5F8f5wBaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3564
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMiAxNDowNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAzLTA3IDEyOjUzLCBzY2hy
aWViIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb206DQo+PiBPbiAwNC4wMy4yMDIyIDEzOjAx
LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUNCj4+PiBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gdGhhbmtzIGZvciB0aGUgcXVp
Y2sgcmV2aWV3Lg0KPj4+DQo+Pj4gQW0gMjAyMi0wMy0wNCAwOTozMCwgc2NocmllYiBDbGF1ZGl1
LkJlem5lYUBtaWNyb2NoaXAuY29tOg0KPj4+PiBPbiAwMy4wMy4yMDIyIDE4OjAzLCBNaWNoYWVs
IFdhbGxlIHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cNCj4+Pj4+IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pj4+DQo+Pj4+PiBBZGQgYWxsIHRoZSB1c2FydCBub2RlcyBmb3IgdGhl
IGZsZXhjb20gYmxvY2suIFRoZXJlIHdhcyBhbHJlYWR5DQo+Pj4+PiBhbiB1c2FydCBub2RlIGZv
ciB0aGUgZmxleGNvbTMgYmxvY2suIEJ1dCBpdCBtaXNzZWQgdGhlIERNQQ0KPj4+Pj4gY2hhbm5l
bHMuDQo+Pj4+DQo+Pj4+IEFuZCBpdCB3b3VsZCBiZSBnb29kIHRvIGdvIHRob3VnaCBhIGRpZmZl
cmVudCBwYXRjaC4NCj4+Pg0KPj4+IHN1cmUNCj4+Pg0KPj4+Pj4gQWx0aG91Z2ggdGhlIERNQSBj
aGFubmVscyBhcmUgc3BlY2lmaWVkLCBETUEgaXMgbm90DQo+Pj4+PiBlbmFibGVkIGJ5IGRlZmF1
bHQgYmVjYXVzZSBicmVhayBkZXRlY3Rpb24gZG9lc24ndCB3b3JrIHdpdGggRE1BLg0KPj4+Pj4N
Cj4+Pj4+IEtlZXAgdGhlIG5vZGVzIGRpc2FibGVkIGJ5IGRlZmF1bHQuDQo+Pj4+Pg0KPj4+Pj4g
U2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4+Pj4+IC0t
LQ0KPj4+Pj4gwqBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kgfCA1NQ0KPj4+Pj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4gwqAxIGZpbGUgY2hhbmdlZCwg
NTUgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9sYW45NjZ4LmR0c2kNCj4+Pj4+IGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNp
DQo+Pj4+PiBpbmRleCBhN2Q0NmEyY2EwNTguLmJlYTY5YjZkMjc0OSAxMDA2NDQNCj4+Pj4+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPj4+Pj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+Pj4+PiBAQCAtOTIsNiArOTIsMTkgQEAgZmx4MDogZmxl
eGNvbUBlMDA0MDAwMCB7DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDE+Ow0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW5nZXMgPSA8MHgwIDB4ZTAwNDAwMDAgMHg4
MDA+Ow0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzYXJ0MDogc2VyaWFsQDIwMCB7DQo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbXBhdGlibGUgPQ0KPj4+Pj4gImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4+Pj4N
Cj4+Pj4gQXJlIHRoZSB1c2FydCBibG9ja3MgaW4gbGFuOTY2eCAxOjEgY29tcGF0aWJsZSB3aXRo
IHdoYXQgaXMgaXMNCj4+Pj4gc2FtOTI2MD8NCj4+Pj4gSW4NCj4+Pj4gY2FzZSBub3QgaXQgbWF5
IHdvcnRoIHRvIGhhdmUgYSBuZXcgY29tcGF0aWJsZSBoZXJlLCBmb3IgbGFuOTY2eCwNCj4+Pj4g
c3VjaA0KPj4+PiB0aGF0DQo+Pj4+IHdoZW4gbmV3IGZlYXR1cmVzIHdpbGwgYmUgaW1wbGVtZW50
ZWQgaW4gdXNhcnQgZHJpdmVyIGZvciBsYW45NjZ4IHRoZQ0KPj4+PiBvbGQNCj4+Pj4gRFQgKHRo
aXMgb25lKSB3aWxsIHdvcmsgd2l0aCB0aGUgbmV3IGtlcm5lbCBpbXBsZW1lbnRhdGlvbi4NCj4+
Pg0KPj4+IER1cmluZyBteSByZXZpZXcgb2YgdGhlIGluaXRhbCBkdHNpIHBhdGNoLCBJJ3ZlIGFz
a2VkIHRoZSBzYW1lDQo+Pj4gcXVlc3Rpb24NCj4+PiBbMV0NCj4+PiBhbmQgSSB3YXMgdG9sZCB0
aGV5IGFyZSB0aGUgc2FtZS4NCj4+Pg0KPj4+IEF0IGxlYXN0IHRoaXMgZXhhY3QgdXNhcnQgY29t
cGF0aWJsZSBpcyBhbHJlYWR5IGluIHRoaXMgZmlsZS4gSSB3YXMNCj4+PiB1bmRlcg0KPj4+IHRo
ZSBpbXByZXNzaW9uLCB0aGF0IHdhcyB0aGUgbGVhc3QgY29udHJvdmVyc2lhbCBjb21wYXRpYmxl
IDopDQo+Pg0KPj4gT0suDQo+Pg0KPj4+DQo+Pj4gQnV0IHlvdSdsbCBuZWVkIHRvIHRlbGwgbWUg
aWYgdGhleSBhcmUgdGhlIHNhbWUgb3Igbm90LCBJIGRvbid0IGhhdmUNCj4+PiBhbnkgY2x1ZSB3
aGF0IG1pY3JvY2hpcCBoYXMgcmV1c2VkLg0KPj4NCj4+IEZyb20gc29mdHdhcmUgcG9pbnQgb2Yg
dmlldyBjb21wYXJpbmcgcmVnaXN0ZXJzIHNob3VsZCBiZSBnb29kLCBhcyBmYXINCj4+IGFzIEkN
Cj4+IGNhbiB0ZWxsLiBBbGwgQVQ5MSBkYXRhc2hlZXQgc2hvdWxkIGJlIGF2YWlsYWJsZS4gSSB0
aG91Z2ggeW91IGhhdmUNCj4+IGNoZWNrZWQNCj4+IG9uZSBhZ2FpbnN0IExBTjk2Ni4gQXQgdGhl
IG1vbWVudCBJIGRvbid0IGhhdmUgYSBEUyBmb3IgTEFOOTY2LiBJJ2xsDQo+PiBmaW5kDQo+PiBv
bmUgYW5kIGhhdmUgYSBsb29rLg0KPiANCj4gU28gbXkgdHJhaW4gb2YgdGhvdWdodCB3YXMgbGlr
ZTogZXZlbiBpZiB0aGUgcmVnaXN0ZXJzIGFyZSB0aGUgc2FtZSBJDQo+IGNhbm5vdCBiZSBzdXJl
IHRoYXQgaXQgaXMgdGhlIGV4YWN0IHNhbWUgSVAgYW5kIHdpbGwgYmVoYXZlIHRoZSBzYW1lLg0K
PiBUaGVyZWZvcmUsIGl0IGlzIHNvbWV0aGluZyBvbmx5IG1pY3JvY2hpcCBjYW4gYW5zd2VyLg0K
PiANCj4gWW91IGNhbiBmaW5kIHRoZSByZWdpc3RlcnMgYXQNCj4gaHR0cHM6Ly9taWNyb2NoaXAt
dW5nLmdpdGh1Yi5pby9sYW45NjY4X3JlZ2luZm8vcmVnaW5mb19MQU45NjY4Lmh0bWwNCj4gDQo+
IEknbSBub3QgYXdhcmUgb2YgYW55ICJjbGFzc2ljIiBkYXRhc2hlZXQuDQoNCllvdSBjYW4gZmlu
ZCBhbGwgQVQ5MSBkYXRhc2hlZXQgb24gTWljcm9jaGlwIHdlYiBzaXRlIFsxXS4NCg0KU2ltcGxl
IHJlZ2lzdGVyIGNvbXBhcmlzb24gYi93IHJlZ2lzdGVyIG1hcHBpbmcgYXQgWzJdIGFuZCBTQU1B
NUQyDQpkYXRhc2hlZXQgWzNdICh3aGljaCB1c2VzIHRoZSBzYW1lIGNvbXBhdGlibGUpLCAgU0FN
OVg2MCBkYXRhc2hlZXQgWzNdIGFuZA0KU0FNQTdHNSBkYXRhc2hlZXQgKG5vdCBwdWJsaWMgYXQg
dGhlIG1vbWVudCkgYnJpbmdzIHVwIGEgZGlmZmVyZW5jZSBhdA0KcmVnaXN0ZXIgRkxFWF9VU19D
UiAoYml0cyAxNiwgMTcpIHdoaWNoIGFyZSBub3QgYXZhaWxhYmxlIG9uIFNBTUE1RDIsDQpTQU05
WDYwIG9yIFNBTUE3RzUuIFVubGVzcyB0aGlzIGlzIGEgbWlzdGFrZSBvbiBkb2N1bWVudGF0aW9u
IGF0IFsyXSBJIHNheQ0KaXQgbmVlZHMgYSBuZXcgY29tcGF0aWJsZS4NCg0KS2F2eWEsIGNvdWxk
IHlvdSBjb25maXJtIHRoaXM/DQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNClsxXSBo
dHRwczovL3d3dy5taWNyb2NoaXAuY29tLw0KWzJdIGh0dHBzOi8vbWljcm9jaGlwLXVuZy5naXRo
dWIuaW8vbGFuOTY2OF9yZWdpbmZvL3JlZ2luZm9fTEFOOTY2OC5odG1sDQpbM10gaHR0cDovL3d3
MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9kZXZpY2Vkb2MvZHM2MDAwMTQ3NmIucGRmI0cy
Mi4yMTkzMjc3DQpbNF0NCmh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURv
Y3VtZW50cy9kb2N1bWVudHMvTVBVMzIvUHJvZHVjdERvY3VtZW50cy9EYXRhU2hlZXRzL1NBTTlY
NjAtRGF0YS1TaGVldC1EUzYwMDAxNTc5RS5wZGYNCg0KPiANCj4gLW1pY2hhZWwNCg0K
