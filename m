Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD05A7681
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiHaG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiHaG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:26:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1EA3D5C;
        Tue, 30 Aug 2022 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661927158; x=1693463158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PJLes5l5X1KmkxoX10x25RbYUumaXGjmZQA/ay0Lclo=;
  b=zWY8DRu1CUGpjhqfjorrVyBEYvCmEorK7B3l80Jl0n6cpUcYTES1eH/P
   MW7r300DhAQBrSOpYjWrBv0zr++n5yb5Wp7v2DofBAAJA7qOrqVtb4EGz
   3Cis9UfOF2JFbGadNws5Js7ZhFvUGrdZfjCZLfvaW2Qm+iPnEEXzYWOzn
   bqzkkNRNjY1kzTR97ZbPmUYR8k5Jt8j1Br81NicPRzr2VU0OvvSAm2Ges
   ob0K9RxHsluaYna4TD6VJmCZYS+gjD6mtW+KYmGJvjqfe/2CCmLUkjKVN
   efB8i1HOghbSZfbbAXIxPWyL1rAemC2Fzva7oJ+BivCAb25CHch6dbwPL
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="178427504"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 23:25:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 23:25:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 23:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsNAv/EYbcxXiQz5bXsWo2JO+T3jSypAqQwj0zRAn3nnnmgHr2jDmhTBpnVEniJlJ0lukUFTmEMkSutCiB9vUV2UKgLeI6g0YHyGgXHk2Dgi24bjwyxPO8bJ74VZ98f3OfxuSTQ6BMtD4QSmHKVuCmZu4mifyQm+S4Sgrv/l/hRITSTd4SO+yhM88Tp3KPlkAHuv8T1YbVPJD6m9NR5pzaraaaAAVzDsdkr5H80iUb/wvU6bOGbAKgaDzqMV/FgaVAV5yK6c89X/7oDyv12VzfBBJd0vhAn7ouZS6QOOIjNFiZ2HDaPpuQRolyrC3vll/wOgE9smYA6VgrrxxbCkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJLes5l5X1KmkxoX10x25RbYUumaXGjmZQA/ay0Lclo=;
 b=a8zorfWCt4pyme+9WOfap45Fp27kOmIO7YEwtu/CY2QXgfWQGjj1+wThbIvJW3WS+/3uH7Ib7j1SD4D8lTWEKqjQ/hmvvQchQ29xMWzU+KcM7z+uAaP+6VzvktFqQDpCi3YyCHEQik8DTQlG7tDWd/z5bFoMHKADs0q19iDtnQq/M4bjXSVMGhkJZa65saKkHGUHVmgEuImIekKw++dCqjjsPkozyFi7AR/TfD2ZakM3V9Vw5dPdMl5rDy5tZZ26Rh/1HOq/+aBYI9DiYYF3+JfiDGjrae/20x7MfCKss6iw6swuxvZ2XY3iHxyKlmT4os183Ou3dg/yUL4UhwFpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJLes5l5X1KmkxoX10x25RbYUumaXGjmZQA/ay0Lclo=;
 b=ZHbDRb/J/6Nn/dKCzrR/IINXOS520NNX/MjH9O9zwVxqk8IUDYLlvLKO1DZujq2yZNM44Rvd3ferpk50cS4k4VmtjG43cWhaDTulQvZt8BFAGA/oKIT9mdMWPA475ZUus+sgffqTYxAgtRyKkiqrsi4JXisx8lTmVDGRe9Ud0s0=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 06:25:48 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::b5a8:a5c9:beb5:70b0]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::b5a8:a5c9:beb5:70b0%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 06:25:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zongbox@gmail.com>
CC:     <ben.dooks@codethink.co.uk>, <ben.dooks@sifive.com>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <greentime.hu@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for l3
 cache
Thread-Topic: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for
 l3 cache
Thread-Index: AQHYvG9DsO2L31s8JEW+tF32qWQ5gq3HZuqAgAAAiQCAAA5EgIAAMmEAgAAFYYCAAMutAIAAEuuA
Date:   Wed, 31 Aug 2022 06:25:48 +0000
Message-ID: <0deb3350-5a4a-8850-7dc1-e7e5b7e9bfdd@microchip.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830125133.1698781-1-ben.dooks@sifive.com>
 <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com>
 <6b6837c1-5a2c-567b-ba64-72a1dca38807@sifive.com>
 <8422fb34-fc05-eddd-0eaa-3e713896d05d@microchip.com>
 <c2f86a2a-a30e-5fac-de6c-6a28edc5bcee@codethink.co.uk>
 <6d58cdeb-044d-b83f-79a2-fb9b86491c8b@microchip.com>
 <CA+ZOyah1Dwf1L9Mn50+v5tLToyktmmASeA5CutW5uwNybDG_Ow@mail.gmail.com>
In-Reply-To: <CA+ZOyah1Dwf1L9Mn50+v5tLToyktmmASeA5CutW5uwNybDG_Ow@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4c2cb91-8bd3-4dc3-fcf7-08da8b19a4f9
x-ms-traffictypediagnostic: PH0PR11MB5032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hA/t48QxQRgl6IqYeeYhDO+uXxE23hOyAqN5KxDLhQ1jjBaXcYtUWHQZ+IUxWTAoPLnnBCO6k9nVXM9aJpyaroUMEJgNeS30yZZyX3J2MirjRcZ3RDjyISru/zc8TByGq8blJmSQzTcF7v4S9nD197E3i9RklC8ds7bJ3/E7L+JT1c091gyFndAv02KT5FmkqgEuzHcWH9USBkq8sZr1vRt71WrQDIwLIOwjBt+IDl4muw4RlCGLE/O8Ayq17v/Gj36KuSOOh5QwW3hmPhloFYkfKDpB8Sq+ua/KmK9mrUOWPKDgSGzelrTzuQ80Dh+LHaabUxbWNkIfulgigZoo2vyuGFRQ2ce4LrUjplIgKB583du5tPmalDrwpUNVb5zZp3taG6/rADENGtjr5dZJ5yv8S/XiJdPr0aiZfiwpMozrxpzaY/pato0DIwdALjhJKUdBi9++fkVAOczRWmkLmL6dxYuukariBlqTpFS1ya4niA/5TmRNf+G5a89gFhtyZBCqUHNNWbm6KELdhFT+AzWEYlGTzlSYuCGKC6mPfH1E6jjN3OmjP+G434Q+Rij+/qBV4Bw4heX0vdIx9hPoxnTPhY7Ehj26LU8dzXqhq1OtvQAhEmkolVNkQERbjF3V6nOhlOfyuusa0rb5OAaWCLdHo7e3fLwz6JyxTgdSSQXDz3V1RR74a5J7CxARV/U3qAedN3uwWVKe+4ShvXCJwrrO14Khv5mWPONm+8tMXpp05ac76zt17kXsZgyHg76pmF8AKDYvVaHCVVczgmkcSYFPv7Bc88/jlL/BN1Mka1QaaU1/e92q330RZ3rYDqP+aU7nDNuH4U05fxZeTsDZZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(346002)(136003)(2906002)(26005)(53546011)(122000001)(6506007)(38100700002)(2616005)(186003)(83380400001)(6512007)(6916009)(54906003)(66556008)(316002)(66446008)(64756008)(66946007)(66476007)(966005)(8676002)(76116006)(4326008)(6486002)(31696002)(91956017)(31686004)(71200400001)(41300700001)(7416002)(38070700005)(36756003)(86362001)(8936002)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1hnMll0UHgvSW5xMVhiaDB6VUV4NkI5SU1MUm1KRXQzdVZjSDFDbUhuMFdN?=
 =?utf-8?B?OVhicWNvSUg3U2NoMkVOTGIxMGE1VERxSDRjdk1KU3dRUGNiM1YrUnJjcEd5?=
 =?utf-8?B?NldZcVpkWXhUK1JtU3Q2R29FQlNlMGVBUHNvREgwK1lHL0svMExhaUJSRkNW?=
 =?utf-8?B?TkNUZ29XejBTbzU1UUJiZ0Z3ZHdOR1ZwdjQ3aHZZVEhtUkJjRTc4eHZjMS81?=
 =?utf-8?B?NCtUT05Hbjh4NldudEoxNnUyTjE1ZVUyQzVXQ0ZGVWsrQ0xoQ2tBZ1lINE1D?=
 =?utf-8?B?SFBpMEZzWnFBUzN1WDZLWCt2VGdvbWw5eGRMV3NBTmVVTEt3T3pyNXc3YXZX?=
 =?utf-8?B?b1VFUHJ3YTNlYU9sYzZrdzNHUTY0cjBsU1ovaHZrUnJoSE1vSnF6WkVsL241?=
 =?utf-8?B?NlcweU1rRHY1Y25mVHVQMTlNU01jMVM4bXNoVDVLeTliYmt1NUt6YlBaSlZJ?=
 =?utf-8?B?YjdhTVUwWjFhcUIvd1Q1SHl0ZTR0NGZxckN4eHBwK1hRVWpycHExcGxXeXJE?=
 =?utf-8?B?cE41Sy83QW9xWHB2QVFQVTBud2RsVWpwZTNnbXhJQkhrQURqWE5vb2NFTDBs?=
 =?utf-8?B?WnFid3Zham1HeHZWMy8wV3hZQTBLSVR4MTB6MHVuNmxkZm53VlZQMk1WR0Vu?=
 =?utf-8?B?RW4vNGwwc3M3U21ZRXp4L2MrWDNVZUtUV3plV2didE50L21GcjZBQWR0emtr?=
 =?utf-8?B?aW5weTVaZ1V6dVQ5YkhKMXZzR015RDVCS0tEL3pMZzdVd0wrZ0FCTmgxcERB?=
 =?utf-8?B?R01OZWhwbFVIZGczcEx0WmZ2YWhBZ29tc0pQYjlyOXFZbWttNUhabmUvTmxr?=
 =?utf-8?B?QlBqU0d6M1ovRTJWV1VKTEthbDNMS2YrTElhZmRoUThJZmNRUlBtdG1iRTJK?=
 =?utf-8?B?dzVJazE1Uk1yTm5xVnRMOE1IV3AwN2FHRStvdTJuRWF5L0ZzQlZIVkZDd1ZR?=
 =?utf-8?B?TDZWZjkyeGZUZFN3ZCt4czlnemNQNHU0YVRoV1JUQW5JMzJ2dTZKclJIek1S?=
 =?utf-8?B?RFowT2JvbitybDR6OWRWNkd5SmhVUXh1T0FLaG5JUlZMUC9BYWd5aDVGMHFv?=
 =?utf-8?B?SU9ITjdWQ2loTFdOR1VMQzgycW85ZFNDQm5xOTFqMGJOQ0V1b1I2cUczRUQy?=
 =?utf-8?B?dUsyNE0vT3RZSzBERTJsM20zQ0pXcXlkRDQyRjRxZURlK2x5QXU1MWt6c2Vi?=
 =?utf-8?B?V3RZUE9pWUZOVTRuOXNzZmlhendQMHlkTFZzelVZdFBzcklwZm50MnlXMSts?=
 =?utf-8?B?Q1d6OG9VYnh5ZHREQnRsYzd4akxER0dNZFdZbTdPZkorekN2OUxoU1Uzb0w3?=
 =?utf-8?B?TENKWHJiV1JGTWZScmFRTDRvR2E1bW15SGJsTDFYNUQ4K3ptYWxReDhIaU1t?=
 =?utf-8?B?ZnROZlFJUDZwL3hBbndoaldHdmR4SjFkUTJ3aTBiUklLbUZpeEM2aWdRY0ZJ?=
 =?utf-8?B?VEJWbUZKNlg4cmNjNjkxYlZxem1uTWNoNHY3T1Nyb1NCR3JLT3Z1UVpiNEJK?=
 =?utf-8?B?b2dIVDVpWWVYOWdiYzBqZEd5TkdlWkhueUtaK0hnUC9hdDBSb2tXVUYzQ2NO?=
 =?utf-8?B?N0Z4QmRCaWpEOFk0VXZpbW10N0ZJY0h0eW9HMVRBRGlaVHpYbndUdURxMXNm?=
 =?utf-8?B?TkxseVFxc3JKZkxGMStOdUpDYXV4MXV3emJCcFBabUNUNXYzVEN4b0pWQTFN?=
 =?utf-8?B?VEs4UXFjUnRHNjgrMWp1Z2RTRFRpcElkTkdMYndPZmo1KythS25tOEEvYVdR?=
 =?utf-8?B?aDNEVFVjZStwMHZvVjZsME5DSWcrcDdEVzJMRzhYcFV0cVVrbk9Ca3IvQVh5?=
 =?utf-8?B?OWFzRldnQU56c3EvSmxTTWhvSUtvTUxPSGdBQXdEaEFUbFRSbmo5OXRMMmF6?=
 =?utf-8?B?ZzJGeEVJT0o5VWhDdnZaL0pHT2tJbG5pTFlyaVM4UzNXTEVtRThSYmRSMktO?=
 =?utf-8?B?V1hYYm5ORTc4eHlRYVMrMXR0U1FET2RIYXdTcldpa1ZXbnBKQk9xMlNZaTBQ?=
 =?utf-8?B?YWcyM05wVzQ3RGdxRS9yRk9KWEs1UzFmN3oyVUxmT1Y3dXJXVyt5MG42MVJ5?=
 =?utf-8?B?cFFmQTdIUzFUMjF1YmhlT3hsTDZ5Y2c0VWdJc3VwRFUrNmx2dFp3V0o1WHRF?=
 =?utf-8?Q?Uk9L7r4wb52u9PgRxx5TUapOH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEB46BC3AAF1FF49A53D83E8FB5AB145@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c2cb91-8bd3-4dc3-fcf7-08da8b19a4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 06:25:48.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBEv5rMEo6ndsg7q8sHci+/alVqVdSRE1EkOoidjWjy8ygSjd7EkLuVp0vT2X1l5+mi2bU5olLKqYLeyc4GnpUmGKyLAxgvwa7KkK787o88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEvMDgvMjAyMiAwNjoxNywgWm9uZyBMaSB3cm90ZToNCj4gW1NvbWUgcGVvcGxlIHdobyBy
ZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gem9uZ2JveEBn
bWFpbC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9M
ZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IOaWvCAy
MDIy5bm0OOaciDMx5pelIOmAseS4iSDlh4zmmagxOjA55a+r6YGT77yaDQo+PiBUaGF0IHdvdWxk
IGtlZXAgdGhlIGVuZm9yY2VtZW50IGZvciBleGlzdGluZyBjYWNoZXMgYW5kIGFsbG93IHlvdQ0K
Pj4gdGhlIGZyZWVkb21lIHRvIGRvIHcvZSB5b3Ugd2FudCBmb3IgdGhlIGNjYWNoZTAgY29tcGF0
aWJsZS4NCj4gDQo+IFRoYW5rcyB5b3UgYWxsIGZvciBicmluZyBtZSBoZXJlLCAgd2UgYWN0dWFs
bHkgaGF2ZSBzb21lIGNvcmUgc2VyaWVzDQo+IHdpdGggNDA5NiBjYWNoZSBzZXQgaW4gY2NhY2hl
LCBzaG91bGQgd2UgbmVlZCB0byBleHRlbmQgdGhlIGNhY2hlIHNldA0KPiBhcyBmb2xsb3c/IG9y
IHdlIG9ubHkgbmVlZCB0byBmb2N1cyBvbiB0aGUgRFRTIHdoaWNoIGlzIGFscmVhZHkgaW4NCj4g
bWFpbmxpbmUuDQo+IA0KPiBjYWNoZS1zZXRzOg0KPiAtICAgIGVudW06IFsxMDI0LCAyMDQ4XQ0K
PiArICAgZW51bTogWzEwMjQsIDIwNDgsIDQwOTZdDQoNClVudGlsIGEgdXNlciBzaG93cyB1cCwg
SSB0aGluayB3ZSBhcmUgYmV0dGVyIG9mZiBub3QgYWRkaW5nIDQwOTYuDQoNCj4+PiBEbyB3ZSBu
ZWVkIHNvbWVvbmUgdG8gdGFrZSBjaGFyZ2Ugb2YgdGhpcyBzZXJpZXM/DQo+Pj4NCj4+DQo+PiBD
YW4gSSB2b2x1bnRlZXIgWm9uZz8gKHNpbmNlIGFsbCBidXQgdHdvIG9mIHRoZSBwYXRjaGVzIGFy
ZSB0aGVpcnMpDQo+Pg0KPiANCj4gSXQgaXMgb2sgdG8gbWUsIGJ1dCBJJ20gc3RpbGwgcmVmaW5p
bmcgdGhlIHBhdGNoc2V0IGZvciBWMiwgYW5kIEknbQ0KPiBub3Qgc3VyZSBpZiB3ZSB3aWxsIG5l
ZWQgdGhlIFYzLiBEbyB5b3UgcHJlZmVyIHRvIHRha2UgVjIgcGF0Y2ggc2V0DQo+IGZpcnN0IGFu
ZCByZXBsYWNlIHRoZSBkdC1iaW5kaW5nIHBhdGNoPw0KDQpJZiB5b3UgY291bGQgaW5jb3Jwb3Jh
dGUgaXQgZm9yIHYyIGl0IHdvdWxkIG1ha2UgcmV2aWV3aW5nIGVhc2llcg0KSSB0aGluay4NCg0K
VGhhbmtzLA0KQ29ub3IuDQo=
