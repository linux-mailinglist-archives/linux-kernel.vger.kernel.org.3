Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A459F8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHXLql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiHXLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:46:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB86857E3;
        Wed, 24 Aug 2022 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661341598; x=1692877598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w6dtblSFOJxRhMRE0kfwmVnOZ+hfaZB+aSn/305qGWI=;
  b=jy+9QQZvA/5SU+MC5EUHsciT9adofwZ+ahXnVDQ3XrDXdOmgLtdP5xGz
   vK27YRyLWuNnt8w39Eu25PdZ5JSJAHj5eVtrK3mW8xKR7MphbFND3pshs
   f9UIf3DbFgE7j8k+HJTFRYkPEoAkZen/dXcy6/Xx2YgmSCmZ3INagxqKZ
   +n4tuTm642M9RfLX/wBY0U2UfrCRvPGt27u+m89tVQLyZ38LC2NsPVjq/
   396f1AJoumtQfaE2znv+2kRz6RyEEk5smFS6fNi3G3GLJ+WOXB0RKTcCC
   kVT+cUqvKLQTc49WNRFkWllPSyHFrfgJnesr7aTQnqgQRnkqiBoDbhBz/
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="177548530"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 04:46:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 04:46:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 04:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F17vYnAuDYOo/VfDnGd8N1+f5nQoW+bDTkyHF5CvYgk7FnPl6E+XLZSrYXhoYTj2Bzq48pLdn2kwQWK+Ipo8jb4l7h0tcd12ZAAoxUZ+A4sLulfDkG7s2BnMbr+MERHlnSuHIYbrouV2IWXLlMj8e+GBtL4h6Nx0vaNCfU746mg4cHkyhUyohOAnszUjWCZwMxWkTZz/xtHEK71O8cUHuSYGXi8xa0LINT2TWK0a/4NuPssV+VQsfkiRZv0Cha0WEwPAnBMMypYYcYo5ld3DAwjXIknZzcPY++iMKJ4+8bZtud4AAiZS5luRJ7DCQfZ58snieOjbRS/Ss+8RTgVI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6dtblSFOJxRhMRE0kfwmVnOZ+hfaZB+aSn/305qGWI=;
 b=O3UdhF3UxGQ3Emitr0yhu0FLM5Nav1eM7D3A7sShs8cw8kgV8NndYMCzMmlVQBJeot6wqMBoAr3sudthyRMzxZB+YZ6+QrDw+mH444PmaxOjVT0DPqxVa7kn7kY7YFJAiTfS8y3aMpP91oTOpXKtT4Y5iasyWv9abftA4/HXnzfiLaxEnJ9chfEGBR8eXFilcWHfIcGFU3+ERxSbO9HjaQq0WR5WAIssEZKHMQ62I1dCSByUQ3h7tthrE0ygC6xeISsEf9xN077Mw82C6gJez0qybZjVd5WHzAZbCIMGoN/PT1QPwZbAlY8WpxQIzkSBjtWzFyicueSu6Cfj52yK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6dtblSFOJxRhMRE0kfwmVnOZ+hfaZB+aSn/305qGWI=;
 b=KTZkhrXJHOG/+zWyR+ZDGFcnYHMHGrRAytfCc4WgInrrOuItLzS+bgsKuQ0biJqxXg+Xt1rwE7mnnCRrad/gng6oSw4HZ1lQ10U3p+P6bVhhcfA9TiNyCMrmPALROaCP56cOEfvAom2njhgYcr8NgxPJuAemaXow8dYuDPGKPn4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Wed, 24 Aug
 2022 11:46:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 11:46:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <Daire.McNamara@microchip.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Topic: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Index: AQHYt5IndXqzWMJbz0OfuNYZ1M2LkK290O0AgAAYywCAAAVhgA==
Date:   Wed, 24 Aug 2022 11:46:34 +0000
Message-ID: <3513eb2e-5e18-152f-6111-f4606a73bc2f@microchip.com>
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
 <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
 <c74a42f7-7d9a-6b52-85b2-d87dacd91be6@wanadoo.fr>
In-Reply-To: <c74a42f7-7d9a-6b52-85b2-d87dacd91be6@wanadoo.fr>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 447dffc9-e655-461e-2935-08da85c64b83
x-ms-traffictypediagnostic: SJ0PR11MB5816:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8k0JBU2GQNM1fNY8BP7Ff4cabdEbp/om1Mtvsrj7fzzepN+WwGeE7XmW/UKkDMPm+GK7jz0tRplj/Jja7lzFXJsaW/NDT4OjOpPvigR885trfj7ZuBc31QNRGV1SZN5kLV5VDFKwfX2YjFGO3IPBcup+JQgVRGg/Mo7Gz+w2QYgO5rsZXGJkgMnWz2qMPa9KG8Q3yNpkydxe9Hu8RaQtJUWm3VM4t/C49N5ALxlj07jVkPLDFnNL9ey1Wzs1fjBcQFHDoYCPbKwUNamvOykr2mCuiNIEydCZsSSj84jx65XIOwVHbwx2VShUf9lbJt0ppFg4vR7i92183Lxn41jpVg4vvzm81JS+i58hwFz36vWm0psrNvHG4N3RWm+lldTQsAqurw/T9C+orWinaeP/bHGWS8HYVcbKHVGZ+FLF85Vyc9taZsxUiU1ngikmXWmSyN74l2JEHdGavitECkH0UXJDTekwJOazj9Farm0ZCTS+mQkOYrvxGKHGxmSic2mm+tYDoOcPymG6bgIAAFIoy9HBdU9OcwR0i4L3EwojSTvpZMSKneZ5RvEgUvsl+ugVws5bBJj2OwVqd3e5kmZxJqWMAhohU6ZNzeFfxt8ImpYeiVkUmsGf/z/PGmRdNacJpkvsvr49UDDjNnRlLkSfXOI8G750Zz9+Vjq0uV6TXaHM1A50+dnUD729jr705SAVpKgg++zn8UKxXvCxdJLR0Rm5gAi/93IiijcEkHEixsHgCadyyBeZbkDTuqPSM05EGdZYsQ6+qBFhBaG8B1u4RovT3fV6bmrjKO0zVLpfM5X+4yxEI7+Hz34J86NJ6g5323jZXwQc3zSS+oL2ztyJRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(346002)(366004)(83380400001)(36756003)(8936002)(54906003)(110136005)(122000001)(71200400001)(316002)(38100700002)(31686004)(38070700005)(66476007)(66446008)(76116006)(66574015)(6486002)(91956017)(8676002)(6506007)(66946007)(64756008)(4326008)(186003)(53546011)(66556008)(478600001)(5660300002)(31696002)(2906002)(41300700001)(6512007)(86362001)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmR5VU1FYnQ1WkRlTE5YQmhuVm8rSVFqQ1FuNkVQaGVHNlZWUmJLcmRrMUxG?=
 =?utf-8?B?b0Z3RDlBR1ExbUNNSFFaRXNTOXJUOEFKQThlTnUxZk1UL2pyMTRXQkJNRGhF?=
 =?utf-8?B?dkdHQzVjVlNRSEhsVklMbVdCSHpKTDhnNlhMWG1LS3FRYnl6am1yT1k4YzZa?=
 =?utf-8?B?U0pSSTJUYmVGQUd3RVlTRVU5TGZHdmFOUEMwV2YxU3J4cWFrSmYzRmpWMHZ4?=
 =?utf-8?B?dHNYMFhkRE9oOVBoTXpPZHRXcm5DRWFWZWM4d3V3ZkJJZVpxRktJbVhvR1Rr?=
 =?utf-8?B?amtPOVc0U0ZNSmRpcHNsazArQWhzUVZObzUxMEVGVjVTaVgycUNXcjBBcDNt?=
 =?utf-8?B?eGgrTFN0YlRvditkaWo2WWdQQmFvZ0w4OXlObDhURVVaR09uaVUzQUdUcEpY?=
 =?utf-8?B?Qng3WUpxV3dsejZSZWR6UFBDODB4MTF1TU9kN1FJc3JDb3N4dWxZc0YyblpE?=
 =?utf-8?B?SSsvcW1DLzEzeTJMOHhSZEtZWDJFOFBpSXgwdWdVVXRxemZFVjJDU0s0Z295?=
 =?utf-8?B?OENkNTBpNnJmdXg4ajAyNnREeHljeUt0NFN4T2wyS0ppOUNIZHd4M2VkOG1p?=
 =?utf-8?B?cXU4UXJHODc2TS9adENNYU5YdWpGMCtQckY2SVlVU29ocTh1SHpMWWJqdTVV?=
 =?utf-8?B?TTVDU1ArS0VZN2NRTm9HbE1OK3BZSmkyaEsvN3F1QmJiYUJlR2NxMGxxa2pH?=
 =?utf-8?B?SWpLWHVsalVJektqd2xXdXlOUnZ4SVpvLy82andoeXlXMlBKMlFKazVvNlFP?=
 =?utf-8?B?UlpHc0pDZThoUE1zRkhtVzNmbHQxeVprOG5rUE56WXU2d3F6K1pFSUhaVXor?=
 =?utf-8?B?ak85TnBNZkRjdjFhaC9QYkZ5MlM1TkxNaVlyZTg3WWpjZFRhbkFSeFZJVmJS?=
 =?utf-8?B?RWNIU1lBWEQwdnlaalBNQnFnTXRaSmkwbGxkV2pWd0oxNGN1SGF0UVpzdjZm?=
 =?utf-8?B?bTcrbGhCTnZWRjVpLzNFMDJXb0srdmpZMkhQLzVOd2pRTnhMOTVEZHRDOCs0?=
 =?utf-8?B?QnpDbjdub1pzZFpKQ0VLSnl0cGhWbWVTMkRUWVJEdUFlU3RKMk9raWx3U1FM?=
 =?utf-8?B?SVN5Z1ZWNktVRjNIMk1mQjhRVWlUbWtEaVpqd2tlblQzM2ZCMXRSVlRPeTYr?=
 =?utf-8?B?RjBDTUtCYkFrVHA0ckxBVlU5OE5kSnoybXNGWWpqdkVCZW9qWDA4QndEVEZW?=
 =?utf-8?B?bnRiY1psYjhKMVB4TVJDYW0xOTFIaERLLy9EM0p2SVd6Y29ZNGJFcFArTHZF?=
 =?utf-8?B?REpqamtVUjdPNUUrZjNTc3BBWmdjTDhDbkhmVlZqNnl3Q21aVGYrMHBzb2hj?=
 =?utf-8?B?T2Z4MUNUbnFxS29qTUozdGJhLzB1UzN5dEhoRWNoemV4V25BdUNrQTlCWnhW?=
 =?utf-8?B?d09DSmYxSytPRFBYSmhMdm5XcSt6c29mTDVQd01aeGxuM0M0Z1J4dDBleWtp?=
 =?utf-8?B?bTErbHZYZjJzOFJsdXZyWmtaa3lBblR1N2xJOWxqL2hoQjM4WVhFZEtWNklE?=
 =?utf-8?B?c1BxYm1rVkVyYUt6K253VU9QNDNFREJyOUUyemZrdGJqOWpTak5JQ08zNGhH?=
 =?utf-8?B?NzVFelE0MEZ0bFMzeXYxUzM2VTRHNGNkWWN2ZTdIR2tabTNYR21kVGszT25r?=
 =?utf-8?B?YkxFcGUrc3REWjN4SklncWpRWmxFL0JoTFRPdkZkdm00OXkvRmZMMHRHWWVh?=
 =?utf-8?B?ZUduQmllcTdMQUdUcFkzY1I2d3F2QkRjSHErcStEanEwdnE2cUpHaFBBQWFN?=
 =?utf-8?B?bGdURGt1M2s5aGlaTk5yNXB3NGM2eGRBNndJM2w0NnJqbGl4QkRuOVRMaCtN?=
 =?utf-8?B?emNQMnpwT0hmRDcvWE9wSmZDQll4YlowU04zckRoNkk2OVBQMVdDdXVXbnFP?=
 =?utf-8?B?SEZmbFNxaHljdGZMYXFIcFB0c21HL0RsYklQVThsM3hRaEIzNytnSkc0bDAy?=
 =?utf-8?B?V2tNdVA4cEF2UDluSlFQbVJULzRWZlVoZENrZnFOSm9DaHhLOEh4K01CRUwv?=
 =?utf-8?B?VEd6YzlSMVFxd1o4RXZib1dvR3FLbFBsYlVIa1AyaXpoZ1ZjWXVpaW8yT0tX?=
 =?utf-8?B?Y2ZzYTNJMVF5MUJvQm9qaTkyUHI5SGREV3Q4ZXdERkxYVFo1Z1NOeU0rZFgw?=
 =?utf-8?Q?e2HkKHJHOOwQx7C5PmjT8PTdc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2A9FE199BBC7346AE6E47646CE7983C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447dffc9-e655-461e-2935-08da85c64b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 11:46:34.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCHAQoeUwgbhCeQD0DJNh+9XAiVXCORbnJaI94F3vUEyuPihV0FlAn4uOgXvFrgNo/G1i9jfxqZx3PyCDPsY8fuY5qO9DJm57aBpgQdKQOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDgvMjAyMiAxMjoyNywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IExlIDI0LzA4LzIwMjIgw6AgMTE6NTgs
IENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIGEgw6ljcml0IDoNCj4+IEhleSBDaHJpc3RvcGUs
DQo+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+Pg0KPj4gT24gMjQvMDgvMjAyMiAwOToxOCwg
Q2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4+DQo+Pj4gVGhlIGRldm1fY2xrX2dldF9lbmFibGVkKCkgaGVscGVyOg0KPj4+
IMKgwqDCoMKgIC0gY2FsbHMgZGV2bV9jbGtfZ2V0KCkNCj4+PiDCoMKgwqDCoCAtIGNhbGxzIGNs
a19wcmVwYXJlX2VuYWJsZSgpIGFuZCByZWdpc3RlcnMgd2hhdCBpcyBuZWVkZWQgaW4gb3JkZXIg
dG8NCj4+PiDCoMKgwqDCoMKgwqAgY2FsbCBjbGtfZGlzYWJsZV91bnByZXBhcmUoKSB3aGVuIG5l
ZWRlZCwgYXMgYSBtYW5hZ2VkIHJlc291cmNlLg0KPj4+DQo+Pj4gVGhpcyBzaW1wbGlmaWVzIHRo
ZSBjb2RlLCB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aHMgYW5kIGF2b2lkIHRoZSBuZWVkIG9mDQo+
Pj4gYSBkZWRpY2F0ZWQgZnVuY3Rpb24gdXNlZCB3aXRoIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNl
dCgpLg0KPj4+DQo+Pj4gVGhhdCBzYWlkLCBtcGZzX3J0Y19pbml0X2NsaygpIGlzIHRoZSBzYW1l
IGFzIGRldm1fY2xrX2dldF9lbmFibGVkKCksIHNvDQo+Pj4gdXNlIHRoaXMgZnVuY3Rpb24gZGly
ZWN0bHkgaW5zdGVhZC4NCj4+DQo+PiBGaXJzdGx5LCBJIHRoaW5rIHNvbWV0aGluZyBpcyBtaXNz
aW5nIGZyb20gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBoZXJlLg0KPj4gZGV2bV9jbGtfZ2V0X2Vu
YWJsZWQoKSBpcyBub3QganVzdCBhIGJsYW5rZXQgInVzZSB0aGlzIGluc3RlYWQgb2YgZ2V0KCks
DQo+PiBwcmVwYXJlX2VuYWJsZSgpIiAmIGlzIG9ubHkgaW50ZW5kZWQgZm9yIGNhc2VzIHdoZXJl
IHRoZSBjbG9jayB3b3VsZA0KPj4gYmUga2VwdCBwcmVwYXJlZCBvciBlbmFibGVkIGZvciB0aGUg
d2hvbGUgbGlmZXRpbWUgb2YgdGhlIGRyaXZlci4gSSB0aGluaw0KPj4gaXQgaXMgd29ydGggcG9p
bnRpbmcgdGhhdCBvdXQgdG8gaGVscCBwZW9wbGUgd2hvIGRvIG5vdCBrZWVwIHVwIHdpdGgNCj4+
IGV2ZXJ5IGhlbHBlciB0aGF0IGlzIGFkZGVkLg0KPiANCj4gT2ssIEknbGwgdXBkYXRlIG15IGNv
bW1pdCBsb2cgZm9yIG90aGVyIHNpbWlsYXIgcGF0Y2hlcyBvciBzaG91bGQgYSB2Mg0KPiBiZSBu
ZWVkZWQuDQo+IA0KPj4NCj4+IEkgaGFkIGEgYml0IG9mIGEgbG9vayB0aHJvdWdoIHRoZSBkb2N1
bWVudGF0aW9uIHRvIHNlZSBpZiB0aGUgYmxvY2sgd291bGQNCj4+IGtlZXAgdHJhY2sgb2YgdGlt
ZSB3aXRob3V0IHRoZSBBSEIgY2xvY2sgZW5hYmxlZCwgYnV0IGl0IGRvZXMgbm90IHNlZW0gdG8u
DQo+PiBUaGVyZSBpcyBubyByZWFzb24gdG8gdHVybiBvZmYgdGhlIGNsb2NrIGhlcmUgKGluIGZh
Y3QgaXQgd291bGQgc2VlbQ0KPj4gY291bnRlciBwcm9kdWN0aXZlIHRvIGRpc2FibGUgaXQuLikg
c28gaXQgbG9va3MgbGlrZSB0aGUgc2hvZSBmaXRzIGluIHRoYXQNCj4+IHJlZ2FyZC4NCj4+DQo+
PiBIb3dldmVyLi4uDQo+Pg0KDQo+Pj4gLcKgwqDCoMKgwqDCoCBkZXZtX2FkZF9hY3Rpb25fb3Jf
cmVzZXQoZGV2LCAodm9pZCAoKikgKHZvaWQgKikpY2xrX2Rpc2FibGVfdW5wcmVwYXJlLCBjbGsp
Ow0KPj4NCj4+IC4uLiB0aGlzIGJpdCBoZXJlIGNvbmNlcm5zIG1lIGEgbGl0dGxlLiBJIGRvbid0
IHRoaW5rIHdlIHNob3VsZCBiZQ0KPj4gcmVnaXN0ZXJpbmcgYSBjYWxsYmFjayBoZXJlIGF0IGFs
bCAtIGlmIHdlIHBvd2VyIGRvd24gTGludXggdGhpcyBpcw0KPj4gZ29pbmcgdG8gZW5kIHVwIHN0
b3BwaW5nIHRoZSBSVEMgaXNuJ3QgaXQ/DQo+Pg0KPj4gSSB0aGluayB0aGlzIGlzIGxlZnQgb3Zl
ciBmcm9tIHRoZSB2MSBkcml2ZXIgc3VibWlzc2lvbiB0aGF0IHJlc2V0DQo+PiB0aGUgYmxvY2sg
ZHVyaW5nIHByb2JlICYgc2hvdWxkIGJlIHJlbW92ZWQuDQo+IA0KPiBNeSBwb2ludCBpcyBvbmx5
IHRoYXQgd2hhdCBpcyBkb25lIG11c3QgYmUgdW5kb25lIGF0IHNvbWUgcG9pbnQuDQo+IA0KPiBX
aGF0IGlmIGFuIGVycm9yIG9jY3VycyBpbiB0aGUgcHJvYmUgYWZ0ZXIgdGhlIGNsa19nZXQoInJ0
YyIpPw0KPiBJcyB0aGVyZSBhbnkgcG9pbnQga2VlcGluZyBpdCBwcmVwYXJlZCBhbmQgZW5hYmxl
ZD8NCj4gDQo+IA0KPiBUaGVyZSBpcyBhIC5yZW1vdmUgZnVuY3Rpb24gaW4gdGhpcyBkcml2ZXIs
IHNvLCBpdCBsb29rcyB0aGF0IGl0IGlzDQo+IGV4cGVjdGVkIHRoYXQgaXQgY2FuIGJlIHVubG9h
ZGVkLg0KPiANCj4gU28gdW5kb2luZyB0aGlzIGNsayBvcGVyYXRpb25zIHZpYSBhIG1hbmFnZWQg
cmVzb3VyY2UgbG9va3MgdGhlIGNvcnJlY3QNCj4gdGhpbmcgdG8gZG8uDQo+IA0KPiBKdXN0IG15
IDJjLCB5b3UgbXVzdCBrbm93IHRoaXMgZHJpdmVyIGFuZCB0aGUgZXhwZWN0ZWQgYmVoYXZpb3Ig
YmV0dGVyDQo+IHRoYW4gbWUuDQo+DQoNCkkgYW0gZG9pbmcgc29tZSBtb3JlIHRlc3Rpbmcgcm4s
IGJlZm9yZSByZXBseWluZyB0byBBbGV4YW5kcmUgLSBJIGd1ZXNzDQpJIGFtIGp1c3Qgd29uZGVy
aW5nIGlmIGFjdHVhbGx5IGRpc2FibGluZyB0aGUgY2xvY2sgcHJpb3IgdG8gdG8gcmVtb3ZpbmcN
CnRoZSBkcml2ZXIgbWFrZXMgYW55IHNlbnNlLiBNYXliZSB0aGUgbG9jayBqdXN0IG5lZWRzIHRv
IGJlIGV4cGxpY2l0bHkNCm1hcmtlZCBhcyBjcml0aWNhbCwgaW4gd2hpY2ggY2FzZSB0aGlzIHBh
dGNoIG1ha2VzIGNvbXBsZXRlIHNlbnNlIHRvIG1lLg0KDQpUaGFua3MsDQpDb25vci4NCg0K
