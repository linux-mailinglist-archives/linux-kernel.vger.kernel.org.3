Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6882C549972
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbiFMRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiFMQ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:59:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D52F014;
        Mon, 13 Jun 2022 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655121340; x=1686657340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UL9ntpPu71RaLTzHdtJy2ANuygBOKtHlJhXbmsszwv4=;
  b=ZqcnzPcS4VnYTWghJeF4Pfk/bH7UM8ecjmJoADKTmOaN1eOAcqDjvgxf
   y7c/aU/ucElsui/p8SBtPGGEOnkvkJQtCht+QhKI2tMU60mntZqEmiD3Q
   V5Kxpf53p4V6eKza22alErAs4XVtuhRFW3SYGQu6QAyxNpMMYnnROKGXK
   yqRcGMtchdrAr+ROgnvW2Vy3RIGjow5XcITClCGIaUb1Zl9EeooZdbhGv
   krRld6t9hn2Nu8n2HY93ARtq47JQ/6fV8qIX6NqSynUu+m01SINQ5SBkw
   JkkN6IvyLK8Flu2+4Uffsq1UhoUCaJVTTIx5uQqSAWFgN8RA8TR6kxYah
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="168175461"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2022 04:55:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Jun 2022 04:55:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 13 Jun 2022 04:55:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIxevwGbBWX/dRim5TjMznbLfz+1/10R9P+VGko0ZDySOY5cxaE8uYnpZrtUzo/Y3T5E23zX6eqBRHFJAwEKgSGp/QRgSStz0SFKRO/z+K8kqIhO0F2Ei4qBV1vUvQJQg16zxHg+6UF2snCFFK22v3GvHunpQ0fif9RgQg7icQMpIesGqEenGj+fprNIiHEgfuPR/rEL7pZpmZ0uOxwZEdtKRh/clg6+wojVONSNDgT2FjSI/F8/66XJ42Tq9Q9wOCmV0UcQRwEiltcoHP1PKArvFsg0VosInlq4UqG0CEAS9gNJr773InflOHwOaQwMzOKKMslv+r/+1h0ZXZAslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL9ntpPu71RaLTzHdtJy2ANuygBOKtHlJhXbmsszwv4=;
 b=EJaxMUHs+AV4b1IT3EN7HHtwEIM2+mCj0t61BMloKUHcvG9cwS9I90KUegLhgvtpdJbCSUTmp14bXedQMH6Glq5V61X00iHvkT1vzCC/pQh6/B6OCrkPeKAWdmzfxbXE+qTWgKnAYvVWB3Eaiq7SL5OvWjrMNgldJ0pqR6KpynqWxlnxVVqCvbnzZYtMxwNeCj8pQuBjfas3dQ64GpBNfiQNYf5Py79hP53+fAyuJCO6Yz6kdXH+N74jD7pfROF9GQg7StDeCfYSBqvkFo9sIzfNUuX6ysK1Lv0D69O44WKP9m6O0oD3/C9H3bH9+eZLnyGBrUaJW3Znsw0pI+xTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL9ntpPu71RaLTzHdtJy2ANuygBOKtHlJhXbmsszwv4=;
 b=CpuT0udUSBSWSCjDpOD5Po9+yYDrYG+jPrdcsjOog3NevCiCVVVVyDRFVoKjy1hup9Ny7Q8iS337E76o38sxSOZeJtO46fNgQQU6lkZIyJLE9wfJJjTGmqZgIxZIGGGtVpF2oRJ43uVfnLDbtQqfHpsz7u8dW3yXMgumFkpARVU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 11:55:35 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 11:55:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <b-liu@ti.com>, <gregkh@linuxfoundation.org>
CC:     <Daire.McNamara@microchip.com>,
        <Valentina.FernandezAlanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <ben.dooks@codethink.co.uk>,
        <heinrich.schuchardt@canonical.com>, <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Topic: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Index: AQHYfxuMNjzv9qrP8E6NLA6/7ruhLa1NOlaA
Date:   Mon, 13 Jun 2022 11:55:35 +0000
Message-ID: <158d3032-ed10-3774-531e-1d650b16eede@microchip.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
In-Reply-To: <20220613114642.1615292-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7525506-d2bf-4fb9-30c3-08da4d33a046
x-ms-traffictypediagnostic: SJ0PR11MB5152:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB51524074E6865E192BEF564898AB9@SJ0PR11MB5152.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdoHCNkgSfF+uFeXNSb1nbrMttgSwAgkXctEhcTtHxlAbuF7J5sDpxorjeYhMpDY83e801n/Y4ruPeh1dbgMX+RPpgsTkmZuefb9vx8Vo0gmgmvdYSbuwDINe7AxPcmP0EqjrHvvckp+uzb9kXnZz8jyaNKNiW529BVn3lYyvxCffiikBYMen9mlTNdwkKZmXbO/ZSgwb2kB6zFda03cjNQGgfL9Xh9Gojd2VKmKAc98TANy+AFzLr6mWjyyOW48SWK0+NrUs/lY+T6fMpCCcN/1UZFOZqeA2zc+JVMWrXzLfEewNv9PkrG+qMi+9/pCCuMWZskqJDV5pJNcNQNmi9NxuNaY9JTCVkKU8/nH50RSv5m2r4Vs/2mpJoW+oSElK39kZD+YEcmSTeCQGB7371Y+WmDe4vWfQXfq4iu9AGHvLRukfmvV13gWhUxUrIw4WADTR2OPwMmv5IE6rt+rz1eqVORJ1oAoCY/FakD3qjuKFcH5RYYPRNeCjn3dGvsKibBvW9AZKdimGcAhyzIS3q/Sb0XxDBihBA3/TbLU3ks45lW3ossC1bWTvgrEpEJaR9LIoFy9SSZyBE35tPcPuZfF8INUmZrnIKothXwJKlawQv/mK0tTO4cFyi1yiHqORzmry5VbXFy3H6QcLyfpCooV4LUOUFFoK4MZUXS8RbLeBJ5XgNIw15yC+VwjDNMkY0TX+o9AoDs7a8py8DwA5Y7Nz1zuslr1h4wNT2+PIiCPzoKDEEgBc51Wean1VZGMkUV4Ut/VZNsTfd5ShuUIyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38070700005)(122000001)(91956017)(6486002)(71200400001)(66556008)(64756008)(508600001)(8676002)(66446008)(76116006)(4326008)(86362001)(8936002)(66946007)(66476007)(31696002)(2616005)(110136005)(54906003)(38100700002)(107886003)(53546011)(186003)(6506007)(316002)(26005)(83380400001)(6512007)(5660300002)(31686004)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUIzUXFRMmQ3Z0wvZmpNZlEvS0llWmtDOUpKK0tQYVdzOE1XZFh6Q2FLQUp5?=
 =?utf-8?B?bjI2VndwWit6VTJOOWVHZTh1TG1nVC9vQkFiYk1EMDdJTkkybUpOSEFyS1FB?=
 =?utf-8?B?QVFiei9seXNINkhQeTk0aDZkMXN4NUc5R1VsNVFNUnJ3MEJHR2RheEJNRHhI?=
 =?utf-8?B?M1pybFJsNnRQWXBDNHVESWhFV0cySDJPRlBCN2NqVGVNTHZITExCZXlLWDkv?=
 =?utf-8?B?Z3F1RnNscWRyc2RIY2dldldiQm1DT1dXbXRZNWtncUJHcXRXNkZISXpEZk5Y?=
 =?utf-8?B?ejQ5VkRTbHErem1RK1NrVWVoSi9Ka1ZZMDlSajZ0MGd1WXRWMGEycE15RHJy?=
 =?utf-8?B?SmpBNHQ1ZW1oelhvQmIyZ2IvdXBrcXA4OExPd0dJbmFieXRueWJnLzJzUVND?=
 =?utf-8?B?QTYrNzgrVHRKRkwrTVdxSnBwNmphZTU1djF4TFB4TzN0WHZsY0ZqWGRJcWpx?=
 =?utf-8?B?akxQRVIxUldBM0tNZ1AyVkR5eWh5bTQrbFlvUUtES0FaVTZHazNXOEg4bDRp?=
 =?utf-8?B?MmJ4cDZGSEQ3MkpQMlcxb3paa0hVQ0M3UE5JTTMrK2xGdlp2MlNFMVBwU0dE?=
 =?utf-8?B?Vk1aT0NwTHBJcE5ER3o2eG5ROGVxQlUwQWxiZHNSd1FTS25vTC9TTEViS2FS?=
 =?utf-8?B?SVZWVmw5amJCdmswSS8ra0xQQTd4ZlhNcVc3SGliK3FCblB5ZTJhL1F3NkFv?=
 =?utf-8?B?RisvRzRhYTQvbVFnM0Vhdm02WlpHNzEzcTF2MHE2dFdYY3hGdnk3Ynh4Y1Ni?=
 =?utf-8?B?Y3U5QmhDNVdEeFR0U3B6Rmo5TUd6bG9GZStGMmFMNmd2MUNtaEdCdDdBUlk3?=
 =?utf-8?B?bmwyT2IvUkdITHAwUnp5OVQ3bGNWVWxkMU5neGNqMy81K0ZwTUtzb2VZMGFD?=
 =?utf-8?B?YWsxMkhJeDl1ck5LWjV2b2J1MWVsWUNJek1Dc2hIU0dmVzJEemVocmkyQWVq?=
 =?utf-8?B?Sjd2ajQ4VWRpaGttN3kwdnRSSk9iMlYrNytYMW93Vml2dll5azdoRUJQc3N5?=
 =?utf-8?B?b3dJNmpmQ3V5TDJEMC82T2tka25QSC9JTHRIWUZBL2dWVFdvYVJkZHFmQldG?=
 =?utf-8?B?UDAyczZ4Ny9MOFRxbWtNaysyQk9acHFadHlVdHlFbU5JeWlTMWhydUl0REMy?=
 =?utf-8?B?d2p4b0hYaFRZQUNPNUxFcGx5YkRCYU5wNTlVNlUxMkE5TytSVWNKN3d5N3d2?=
 =?utf-8?B?NUZGM1NSYUJmM3JCYzMwN09VWnEvZWUxblBoMlZFcjQ3U0tMSDVxMlJibUJO?=
 =?utf-8?B?S3Vsc2lCczRXSG9pL3V4QWowRm9oYlVVdERnOHlkOUZvc2ZML1oweFBCend0?=
 =?utf-8?B?bk9rZzZRWTk0ZUo0WDQ3K1AweWNXSytOQVJrTWdhLy9nb2MvY0hWL2dPMlpo?=
 =?utf-8?B?S3p4K2VZeURKc3R5Q0lYYUYrNFdKejR3Zzh2c3gvd0VwQWQweWpzWlo2STZh?=
 =?utf-8?B?QzdJUndPZWpxZ2hSM1g5Q3VXWFUzY2VnQTMvVzdyMXZNeVA0UWFoOG81M0cw?=
 =?utf-8?B?MThrbUxhbEk3Tllsd2pDcXd0VE5GbS9JckRHb012SHdXbVdKeEtSQzJMYjNR?=
 =?utf-8?B?eDJlWjg3VkJGY2VrSHZDYjZqQWNrd25FRFgzdzRxcStEeUdWZXB6aGhXUTNI?=
 =?utf-8?B?MWYwQndOYzU5SHpZQXBNTllMSEJSajhyd1kwNnFHUGtOUDNyOWhEd3RlUmhC?=
 =?utf-8?B?UVlCM3Mza1hia1Z0eXBtSHlvam9SNEN4ckpEVko1a05HbExGOUp2YWZhd3lQ?=
 =?utf-8?B?QzFMNml1SEtnNlJncjY1dVhqRlcxTnpUejY5Nm0vcEl6ZVJ2UFA2WVRWUGNC?=
 =?utf-8?B?QXI3aTBMS0xVdHVTZndydkwrUTBpVXpHS0luRE1iZitsSFE0WXNjVnJwZzl0?=
 =?utf-8?B?TDk1WUtrT0pxVjJ6aTRMQmNpVlFKczNmZUtvdGs1SDFZdDJOMVdSYnpHc0Jp?=
 =?utf-8?B?NjRRZzhWUk13QUNZUElheTAyMkR0VTl0a3gxMmFpV1dac1ZBRVVEOGRpblJW?=
 =?utf-8?B?cHJMYm9vbjdlRnBlNGRlNHkwdjQvMCs2Y1BTampFdUM2cDVXVW5TZHNBaDlN?=
 =?utf-8?B?QWZ3S2hMQnZ1cUlrdTdncUhVRVZ3eDdXM1dyRkJYb2QwbHRSeTdydWpRaTFL?=
 =?utf-8?B?ek55RFNtSTJGOHA5NXBHNHNrMkl6eHFwblJPcFpwaWJCZkZLc0JHc0Z0amtt?=
 =?utf-8?B?U3hCbzliZEc3SXJMMDAxdGFpRzdYQkNBWXhKakFYemZRU0FzT2xIajdlRThV?=
 =?utf-8?B?RE05K2szazkxOFM5ampPcG1ZN0Yzb3h0citxY1EvWk1YUVVKSHM4MEs0U0hF?=
 =?utf-8?B?dnpLdXhTeWU1NWdJblArSUw5T05hbmFKb1A2em1aVkp4SXFQZlNWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7650A5590ECDCF45BBA56563903EBCA0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7525506-d2bf-4fb9-30c3-08da4d33a046
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 11:55:35.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaCdyswF5suqR/r19YNKX51eZgEe5nVNzSbUcqZli8AqQpwisGkVnqxH/+u5jMhrQbfL3mZywa27TddKQMN1E3XB63OQe8XuBswgN+XsdXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMy8wNi8yMDIyIDEyOjQ2LCBDb25vciBEb29sZXkgd3JvdGU6DQo+IEhleSBCaW4sIEdy
ZWcsDQo+IFNob3J0IHNlcmllcyBoZXJlIGFkZGluZyBzdXBwb3J0IGZvciBVU0Igb24gTWljcm9j
aGlwIFBvbGFyRmlyZSBTb0MgRlBHQXMuDQo+IFRoZSBrY29uZmlnIGRlcGVuZGVuY3kgZm9yIElO
VkVOVFJBX0RNQSBoYXMgYmVjb21lIGEgYml0IG9mIGEgbW91dGhmdWwsDQo+IGlzIHRoZXJlIGEg
YmV0dGVyIHdheSBvZiBkZWFsaW5nIHdpdGggdGhhdD8NCj4gVGhhbmtzLA0KPiBDb25vci4NCg0K
QWgsIGRhbW4gLSBmb3Jnb3QgdG8gbWVudGlvbiB0aGUgMyBzZXRzIG9mIGNoYW5nZXMgdG8gdGhl
IE1BSU5UQUlORVJTIGVudHJ5DQphZ2Fpbi4gVGhlcmUncyBhIGNoYW5nZSBhbHJlYWR5IGluIHNw
aS1uZXh0ICYgYW5vdGhlciBjaGFuZ2UgaW4gbXkgcGF0Y2hzZXQNCnNlbnQgZm9yIHB3bS4NCg0K
PiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBEcm9wIHVubmVlZGVkIHJlc291cmNlIGNvcHlp
bmcgYXMgcGVyIFJvYidzIGNoYW5nZXMgdG8gdGhlIG90aGVyIGRyaXZlcnMNCj4gLSBEcm9wIHRo
ZSBkdHMgcGF0Y2gNCj4gDQo+IENvbm9yIERvb2xleSAoMik6DQo+ICAgIHVzYjogbXVzYjogQWRk
IHN1cHBvcnQgZm9yIFBvbGFyRmlyZSBTb0MncyBtdXNiIGNvbnRyb2xsZXINCj4gICAgTUFJTlRB
SU5FUlM6IGFkZCBtdXNiIHRvIFBvbGFyRmlyZSBTb0MgZW50cnkNCj4gDQo+ICAgTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgZHJpdmVycy91c2IvbXVzYi9LY29uZmlnICB8
ICAxMyArLQ0KPiAgIGRyaXZlcnMvdXNiL211c2IvTWFrZWZpbGUgfCAgIDEgKw0KPiAgIGRyaXZl
cnMvdXNiL211c2IvbXBmcy5jICAgfCAyNjUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDI3OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL211c2IvbXBmcy5jDQo+
IA0KPiANCj4gYmFzZS1jb21taXQ6IGYyOTA2YWE4NjMzODFhZmIwMDE1YTllYjdmZWZhZDg4NWQ0
ZTVhNTYNCg==
