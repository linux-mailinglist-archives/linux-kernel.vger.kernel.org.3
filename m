Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1484CD301
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiCDLHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiCDLHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:07:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F11B0BCB;
        Fri,  4 Mar 2022 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646392012; x=1677928012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ocgyWaHX+yQpuAXRBy+brWqE3j/9e/ybC99EkW3mnr0=;
  b=qWaKIdG/BB9NnhrAwf/dZuQCSOUxlDlCSp59CX+LErM6a3sG15YJv3EZ
   78ihP2FB92twiGbUFNiCrJ77s797adGdvLkHnJej4TWd1FSCNbyRDOL2Y
   xkRzLRFrwOzWVWeaZFKOSv8l+oF1/s52zXtrJ9VAVik/GJH0ZhQDSxBI5
   SYkYmQLtcpaHTfWXeSI+TWEbuhyp+AIvZmE8zYV4aMS7hUnKXVmA5nmt6
   0lHfMrJo37X5+xi1qEyrchX0dnwulCT2DP/IsbYQstKKN/6yl0QVYegKB
   XLFRQjP0VYXojovdI8wxwL2Q/wTbku5pNUuHAZOiX+Vm7drE22eekDcs9
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="87822988"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 04:06:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 04:06:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 04:06:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgbB/Qlvghtt9MC4DNdZYMhxFS13C1noFNDyUcKTHG7sQ3bCOFMs7keWbvTD0x5t44TJC5vyhFqlW72E0WKUeEEZdFHdryQUl3yF9LzeNG/1Yf844CS0ha6pLtAQNetCfy3DlsvjsEnghWACv/xaqzH30s3xXY8Ooihom2u2G1kNiFv+zYEw5VZ1eordv3l3gOX+WD0OVh85JaEHXFHz4RQaKXVz6wFi5e63N8zR8C2K+cGUdtQob1xKG0Ec6ob5+YmUU8vpUjrjRZvvxSd78vJwx7v+toGRCCz8fNgIzrPE9UFPfJtxPpJZGML23qXjT10AAXPocY+1XvV5XItBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocgyWaHX+yQpuAXRBy+brWqE3j/9e/ybC99EkW3mnr0=;
 b=lTcm0IquacKolrTIZfRa/c31NLsus85lkIuOkYDlMBxRRSPfreCqbFHLhSuSg2j8nzmUfTxVDwoxxLBSlYrsD4NeHnwAxdLtE5p675we0mYlamfY7Ms2+WI2hD1UVUhCio9TpreL1tqa2j2KoOVYxnyrMNw+eN5N0vfR3gLHyyWFOEg0IuqybeXIrhlN5z17DyERcNtzcNtXpbiRE1SMMQntCdYyKEjY1JbYHOA981Hcie2xEDrnS8R7z7V47vA2ZY3xFODFa6tJCQr4xatWKg3cT6pwJFX1YBzZQB7NSmE19Jju5qhz/HoEAD6VWd9ozMw8mG8UL+/yaFadz0WAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocgyWaHX+yQpuAXRBy+brWqE3j/9e/ybC99EkW3mnr0=;
 b=up8WAs9Hj4UGHxDZZRtrs/PbE6c3dqehEJCYjHJf8Ef3sDujlvGlwKrr6+tdP2IKhFXJdeNgCNjbWQROr5on6iNVLLGdWgnDVopOHFapTDKk9zJ++1wwYMVrpKA3pjXdo5Qg8p2Fh5naWfci+ihla8WGl34w+BAoU6Eh2zLaV4A=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 11:06:39 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 11:06:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] ARM: dts: at91: Add the required `atmel,
 rtt-rtc-time-reg` property
Thread-Topic: [PATCH v2 2/5] ARM: dts: at91: Add the required `atmel,
 rtt-rtc-time-reg` property
Thread-Index: AQHYL7fssZpfY38WA0uPyxVUYS0IIw==
Date:   Fri, 4 Mar 2022 11:06:39 +0000
Message-ID: <c79fbb1e-80f7-b1d5-d403-40054cbd36b4@microchip.com>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
 <20220303140626.38129-3-sergiu.moga@microchip.com>
In-Reply-To: <20220303140626.38129-3-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b100b87d-e173-47ef-bc0f-08d9fdcf0edc
x-ms-traffictypediagnostic: MN0PR11MB5962:EE_
x-microsoft-antispam-prvs: <MN0PR11MB5962D415E7885D187E7F44B0F0059@MN0PR11MB5962.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vh2wXutxWHwdgvq2xjf1I0+otTIOGinsjY5kjrMVGkt4fpUOdvEc6LpW883XVdOWrd5GgKy/sEDzuaeAOwn16c4m+AceYfF1MjczTUHVwk3aoLPfoOhUWBEw/6joTlu6iblsKGYaVyhy2UlFf7AKGAGW3wgo1DZVyYGR+k/FQIODm0l6mF0zqQWQYnhBD/fSgNGUwmOMiIfe41XLCSofBtyBoJ6Lsn9r3ArI+nporapfIqyv4kUxU7XR762Sv/OwFJyLamSsKomfUrNt6gPk2/YRoB644G97ya8yhMkzXyhEsxS0Bj7wCGVXNGyVgxvlOB0znqgwdsl8zFORpw/jTu/DWn7o/m6f+/EDxVsc/1ApY/jHPOzLAkKrrtNL9lDptJ/Ojx15R55R4hex9FgzYa6rzCEqWjCiAwrQ1jDneBjMrLdMjEpk/6/Ct1xCsqUHk1KWwWScl1tmbiS0daHm9Z5v5cFHUu/xq6ojp+mWLFkpv+59cPoAUywkPml1g5ehURUuTcwDW8b5XVq0YQZDNxS06vS4fbgWrYEosameDxt2BJlvLMux0CO7C6EojoG6PWv65ibrglfeole32i9rU70TWysob9d1DaYW5F/ulzD8bgpCaifQcSI59EMnjfPXNfUU4TI5O3+4AWVRkAA9vMxArHL3EaJU7ZWHP7gmqf4N6wIcxqM/QvgyCOrZn6Zh9coVzGxaNq2VLslnQWRdum98x18J0XbACYRXv/MUcgx3jX04lMs112kc4R/My0GV12ub3b5tf4DsrhA3Kx5Cm/j42RqjngcQIMvpwdodHFc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(31696002)(8936002)(38070700005)(5660300002)(38100700002)(4744005)(26005)(186003)(2616005)(6636002)(122000001)(110136005)(54906003)(6506007)(508600001)(6512007)(71200400001)(53546011)(6486002)(36756003)(91956017)(66476007)(66556008)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(31686004)(316002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjdMRE5NRlgyRTJEaE1pdkpXYmdvN0RVTGtBbWJsZTVVc21zbFByWSt3alBn?=
 =?utf-8?B?VHFsYk5Na3RFSnNocnNOZzI5akV1b2QrQVhCT0tGK3dEVlhCT0xmaEIweVVD?=
 =?utf-8?B?R2V5M0hxWHdmMEtGY0pid0lKelNSU09ST1ZkZ01jbGNYbmp0eW9SamJxM3Y2?=
 =?utf-8?B?TFAyR2U3Q2VlKzBzdHFncmI0cTJjUW1FYzc1dXkvcGlhSENMRXBSSGw3V3kz?=
 =?utf-8?B?eDhwK3BmREhScnVCcDVqTEhaYThVYnRteVZ2ZU1MVFNCZVZSQzRQNTJCeWdh?=
 =?utf-8?B?VmxRcXU1ZW1PemtmNTI4S3ZqeHEzK25aeE5Cd1p0R1V3SVkvMmZGVkZFUkJZ?=
 =?utf-8?B?aXZuS20zNUVuR1ZmWGNKb0tKWjRLUHo1eUhVY3hmK0RqQjZVME8vY3Vxc3lU?=
 =?utf-8?B?dEZpQ3R1K0NNb0dOMDVNYUdveWJKSFdaTGJ6b1hjVzZQdFBsYlJnbFFpUnJl?=
 =?utf-8?B?VjNZeERPajY0SmpxbnBRV0pxUGxLOVVkS1Y3WDFBeUpLQkV0SjVscHZISFNY?=
 =?utf-8?B?enFBUWxKLzg3Yk56eXRpdlNLSUhZR2VCVjVRcUx0a3hYRWs0VVpXNUlHN2Q3?=
 =?utf-8?B?ZjFrMUFsNkpBTmsyVWZTUngzYzVXWGNPREkwK1B3bGtLOVpKUDVEd2RpWjND?=
 =?utf-8?B?YXg5TzJzaDhQem41WUxlUHJPdXJHZlp2aFo1a3J6QVlHZWxxeVNkNEhEQkxV?=
 =?utf-8?B?OFZ6YmlqWkpvWnBNaWVBMFE1cnZLMDZRMWRUN25CTG42U3h6dGJ0SlRxZklK?=
 =?utf-8?B?L1ZRc28wVVU2OUJRZjd0SkZSMzJvTm8vNWVKcllwZldQOFc0TzQ3RnhXY0xT?=
 =?utf-8?B?VFViUllTRHpJendxbnJCN1FXQWE4SW5SOHRJOUZyVEY3eU9BOUN5M1FSUVpa?=
 =?utf-8?B?dmFtMDl2aTlOVk9NWU91anU2THgvVzNJOGR4anlva1lwN25MQm80ZklENDUw?=
 =?utf-8?B?UVAvR3V3WlFqUWtpV2txTXRtcDBNZFAvZzNrOWEvVTJTZmJnb0pqMGxaNXZB?=
 =?utf-8?B?bnpZNDE4aEF5MHduakdESUVRUXlBQk0vWkNUYlhQQUJpK0o4UFlmc2pCOGY3?=
 =?utf-8?B?Z3RJUER2dmZBdUMrYll1S1JRZG5DbW8za0l4RCtNVXN2WFVvRDhpM0l4SXRS?=
 =?utf-8?B?N0NUaERyK1BNUXdINk1XbDd6SDFRbXNnYm0yaTh0RTJkYTY0QTVTWWZONG4y?=
 =?utf-8?B?YXZZdEx5TllaeUN1bkR6c1NFRGN2WUlyRFJERHozN3FiVUp6ei83NTVRM3Zs?=
 =?utf-8?B?aVU5aVRncjlsZjJjU04wakdMSjhCbU1BSTdscUxzV1Z0WDNyOXRaQkZITmcw?=
 =?utf-8?B?TDdHajNhY3FMdzRKZ3U2RmJFZUdwalc2cmtOdXRoVGlzMW50cFZaSkNqbkFv?=
 =?utf-8?B?MHRQZVZZQnNHdmxGSXRVbFNWWjNqREJwWTBLN0Z6TE1QSXYwWGY4NmxhMUcr?=
 =?utf-8?B?NFhKRDBia3lNazdDWlVRUzJBNDFLYmdlVm5nWUE2RCs4dmUwWUtSd1pBS1hm?=
 =?utf-8?B?MnZnU3FGZm5DWlVZL1F5ZXNvcU5RL0k2RnZaNTFZNTFoWUxyU296T2M1TWYx?=
 =?utf-8?B?RXV3U0s3VkZJYWo5N016TTBKV2xKbWFaOGt2ZzBrbDl0VTZLbUpTVm9zeW54?=
 =?utf-8?B?N2Z4MWlKWndlaHlGekQ3Zmg0YWd2d28wallpcVZvekM4bTRHbFFrSFhndytq?=
 =?utf-8?B?eWx6SnBWVlZITzdvb0gxL1NrejRmem9BVEc3YXdYZ1h1RkFrV1FHa0tyZkZF?=
 =?utf-8?B?M2lvQk9KaExOdGs0UEZvOHNNZ2MrUVVtK1VBQ1dOUnZpQ0VTNmw5ZTFXUlp3?=
 =?utf-8?B?OS9TZWYvbGo5akVxMkVxeE5PTGRlMzVETXJieTFkMDc4NXF5bG5ZTldJMUVw?=
 =?utf-8?B?L20yUSt2TTBTakJSSmxuRHRmQlplaXpkUnl2Q3UvbFVDUGREQ0ZHTThFY0VS?=
 =?utf-8?B?SUcxMHBoQ29GOTZ1S3JQOE1pQVgxTEJWbWZqT21zUG9sZTJ3ckxTUjZXNWZV?=
 =?utf-8?B?cjJmQ0wvcys5MTFEc0hBbDhxdk4zMWVZQ0FNR3JkZGROeFdmb1M0M2hoQjYy?=
 =?utf-8?B?Z0w3STJGbEo1OWZBNGk5NHVWb3ZuNVZtUUdzbHNwNVd1cGtTckQwY1Fmd3Y1?=
 =?utf-8?B?dnRxRURYRDJ0TGIrUU1EUGdpYUdnYXh5WUJQUlRUS0tuSEYwQm5wZ2ZiQkVD?=
 =?utf-8?B?YkpWZ3N6Ym5sMWZlUEVXQlBiaElPOFU1VW1CcVFWUmRsWlVkUW9tMy93bXo5?=
 =?utf-8?B?dEFLazYwNHByQkVBcU5ldGdiR1B3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A64DB48A4301442AA4209BB1995774A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b100b87d-e173-47ef-bc0f-08d9fdcf0edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 11:06:39.8103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfX9RmE3fysiDNWIxGfVJ60+wY7FpbqRkZSnMz7ENzn9+gN21Qff/zQc4dz5uABDwo2gdUxNlfQpnPWsfUoSOubIR2QhCK0ImWGjKquhrVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zLzIyIDE2OjA2LCBTZXJnaXUgTW9nYSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIHJlcXVpcmVkIGBhdG1lbCxydHQtcnRjLXRp
bWUtcmVnYCBwcm9wZXJ0eSB0byB0aGUgYHJ0dGAgbm9kZXMNCj4gb2YgdGhlIFJUVCBJUHMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9jaGlwLmNv
bT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2MS5kdHNpIHwgMSArDQo+
ICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2My5kdHNpIHwgMiArKw0KPiAgYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MXNhbTlybC5kdHNpICB8IDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCg0KTm93IHdpdGggQWxleGFuZHJlJ3MgZmVlZGJhY2sgZnJvbSBwYXRjaCAx
LzUsIHlvdSBzaG91bGQgcHJvYmFibHkgbW92ZSB0aGUNCmF0bWVsLHJ0dC1ydGMtdGltZS1yZWcg
cHJvcCB0byBlYWNoIG9mIHRoZSBib2FyZCBmaWxlcyB0aGF0IHVzZXMgdGhlc2UgU29Dcy4NCg0K
Y2hlZXJzLA0KdGENCg==
