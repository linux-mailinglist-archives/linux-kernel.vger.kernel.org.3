Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0709E4CFF2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbiCGMxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiCGMxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:53:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A650E14
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646657571; x=1678193571;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mvzrwB/XSImGMTjzUWiiTDg5Wq92MazFYdVhuNKqGj4=;
  b=XCO96cPBmzUe/JWlz6jQ5ln9V79+5QF8BRc390zlCjSCd3b6dT8IreRh
   fiRBpDAmJo+3r0Fqs0DthvMX22MZspSz9F8350+Nj5gsAaZi0vglnMJX5
   XWSM8bcVNa+tQJi7oJW8+RPZ6/VQ4B97T2+V/vSp84xA08wj8IZhlwL/C
   tguKSvtlmmP9RGxGLVoYEz0YBWs+1rVmbQiEfc1T3bEodFS4twiSCAwp3
   tgimASJOWfGtW6BQKreOmNKHCwGElDQaIPgJVhjDoTqLjd7euF2/H4JFR
   M5k3p9T3q+7Z8uGQE8aj5Ic37c1QybksUE9a4LgC3mduvmgXaz6IOzc5V
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155491135"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 05:52:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 05:52:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 05:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+HaU7+wAtHu/kL921Ge5exk9BwTPji+k07WOvgVAIJep4fYh4emvo6+eD9DRZZOW/KXbeHTKGqnBpoRS/5o01Oum9EJxcPSI15LB8qvWhKLYjTLqPWRzKZu2VxHVxiYSk4EwaeVA2Q52diNN5OsPLLOYC+nCKVKtIcY1B/PSmCzIQo/QeMqP41b4JHPnykFp6yKNGrlRGuqEDZWDjKXjevMuKJxQTgwBrLocpaAFCL940S9ZW4qo0DCvjD7es2B7/klUtBMAaOVFk1cS3De1JslLkL/wobNX45xN+f2xHMVPFRKCCjsfp12OaSbmKVc2SrpuyJ34Q5MtjIujVR8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvzrwB/XSImGMTjzUWiiTDg5Wq92MazFYdVhuNKqGj4=;
 b=Av9QgdFW1EXbkKYcKH5uk10oYMQQVLqDILD6n0Pb1vh+uOmndOjf4FV4tfXkbUeTm/+YzC1AoqAA0KRKAvVMB8miOiTRbsi3M9yjpjevvokPAI9pXa23GKgTkXtOD58vc6/mDTRmtQdYKXRMhb5peX8TAB6btQGXuhHEqGPjDVGtBVugepWZP3VboZ6oUxLaxK5EJ5Jqghf4tCot/m0iK/jAG9F/7UCNKmBQQ39lVDloecdPxgQANBktBCfWr0iQIfuDlwOsgm4nVpvk+jpHDjv3cPWYSFGiHLlwZplGokRmZzwYXAZXKCPhENiNmdb/nlRAeDUs+BzIv6wtNgKo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvzrwB/XSImGMTjzUWiiTDg5Wq92MazFYdVhuNKqGj4=;
 b=LYOHTCotUOEVbCc7iFO5A70AmAtQXjCM/Grjqu/NChqgWcewofEb1phXsu8xJS8fnDHYFh0wfxEER6ZX58kPIExFfXCzhG54GCaZfUQsAdGcXjnvgyuj/I+48WPmoGdeHt5gz7u3qMrS58h5SdGQhullwIAS6YhndkBLkSwT2Xg=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 BN7PR11MB2643.namprd11.prod.outlook.com (2603:10b6:406:b2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Mon, 7 Mar 2022 12:52:44 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 12:52:44 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <linmq006@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <voice.shen@atmel.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: atmel: Add missing of_node_put() in
 at91sam9g20ek_audio_probe
Thread-Topic: [PATCH] ASoC: atmel: Add missing of_node_put() in
 at91sam9g20ek_audio_probe
Thread-Index: AQHYMiFGnHDr8jokZE+KSzG/KZeztayz4DcA
Date:   Mon, 7 Mar 2022 12:52:44 +0000
Message-ID: <97283dd6-bdb3-6222-ee39-5c1b57b9e548@microchip.com>
References: <20220307124539.1743-1-linmq006@gmail.com>
In-Reply-To: <20220307124539.1743-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72205af9-ee8f-4d69-6a10-08da00395fa2
x-ms-traffictypediagnostic: BN7PR11MB2643:EE_
x-microsoft-antispam-prvs: <BN7PR11MB2643F1A034B7F558B875CBBCE7089@BN7PR11MB2643.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYWN+/0e6VsacuiELxseB1xFtyBaO3jf4HOMJup2xqynQYFT05tqL9x9hBxR1dsu7lUl27ik7GthcXr2E5logdLUp+DcROtdLnqbcdUT82HWCO6zKwyYg9Pjpw+HxDgDPQl5lVjYrf1LNJQkk/QPRoHuGFT1vjXaifVC+SDidlv5qdRzMUFxloOuON/H/CybzyJI4exEKW7oJoE8gtYkKx8egqC9R9mDt1wVXCZ/qtfmdFdwA5PEFxIdduhM+EA87EB17xvO93FGzvVutVP8o8zj7DhmqrMITX6yc3zKe8rUiar+DUJNH1olMz+/HMtkzV4fOLrXBrZLqbUnk+9HtoQHO5sHyS1k6mf+l3ScZRbKpLeHtZw+rbFF+oochUbC8LbokNfpkhw+VlOTDwBgUEoupSmzhghtSKPZOTFuundfkoRr19qUOTMDXy4F28TA6evUjLG4EhkKx98FIuuwzdcO6VTpGZsBaTHRBbCa0rC1bq5H0J0QjkP5MILUbrtYAXnab4a3MkeB+Kv+nLB6qxeLn0VKv3+sAVYzCJ59gLEGz4oCNtyaQ5ZGdsadrq4SHqeKs3jH/xupyvdm7ITowdSSG8oF8n/NvFdWAxa0t/b8MYQq5qa5EzAD1VhRbXjHlY8obg3KWEb6KHRyIRefqLTDyvR1R9HPSPNr7G+5NqUD+bstB3xRs38ZDkPDNlte9eIv5iN9ekJAjJPWcFmhOkqcGgLprXK8TOcCwhamcVxUmcFhfvAdnNd6tPj4er75H4VxrbmPFuUgNiTkxW7JgI9ajzDd+aCLioQe5k7n738=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(86362001)(38100700002)(38070700005)(921005)(122000001)(316002)(91956017)(6486002)(110136005)(5660300002)(4744005)(7416002)(8936002)(64756008)(66446008)(66476007)(76116006)(66556008)(66946007)(8676002)(2906002)(6512007)(6506007)(508600001)(71200400001)(2616005)(186003)(26005)(53546011)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW94WnJnZCs0R3VHM0lkTTIveEJlTFZ3SHk4d21EeURnTldzTEdCdmp0eHl4?=
 =?utf-8?B?UlZJVHRaQS9BMGdBSGRyb05UQk1BVUhHYUtyd1AyMWN5RG95UGhCNVNEaFlF?=
 =?utf-8?B?c3hPeGFSRlBkcC92MTE2ZDV3empBV1hpdE5qdUJXVWdoVEFtdE9VY2RlMkt1?=
 =?utf-8?B?QTZ4cGlBazdtWkZHb3hIOUJraUJ1Y2RhQUlIUkR4V1dpRWZ6cm5ManZXMGVD?=
 =?utf-8?B?ZkJPcFRBSTR3QzRjdkJOdUxjVHVPRVRFaC90SkN0VXBTT2hOMC9nVVFWNXJG?=
 =?utf-8?B?aHU2OWRjY3JBNnorWkhCbU9kUmlXVWgrRjg1UjRvd240NXN6Y1hkbWk4aC9k?=
 =?utf-8?B?b3JaQlVuR0J6RStTcGtPTXYrUlAraUJlUlAvWFRGVFh4RUd5ZGtZVENDbG9Y?=
 =?utf-8?B?SStrSTZwb21kQ0dZbTZXY3ZuVklXNGUxRnRzbWlmYUJoRFZTN1pGbGllU0VT?=
 =?utf-8?B?YUh3eERiTnBEMWNwRmVETGpVWWhPcUVENzdickdBcUhqYjVoeXdxZkJBNng2?=
 =?utf-8?B?QUFWUXRUK3F6U1dCUnBHaTBqRkdLUnpxcm1qV1lMNW03SldPNXdVMFphSGts?=
 =?utf-8?B?cDBNc25DbWs1WHpGbm1PNFlVWW5wR0g5RHlKY1NpakYrZ1lCMzFtUTVveExB?=
 =?utf-8?B?Z2l6SnpwYTdjTFV1RTJ2TFVlcXRQWVFYdk5XWEhoN1cvZG04Nld5c0NsM3R1?=
 =?utf-8?B?b0FFRDhUbEZRdGpQUUtnUDE1R1VBUEFCSkRYNUJGNHRpdVFrNC9Rc2xkbFF5?=
 =?utf-8?B?K0ZMaUtGM3ZSVFFabThxclBMVlNTeXZ1UmtlV0RsYVRvdmlTT09HZ1lDaFhm?=
 =?utf-8?B?SzFOQWsrRGxqdkJOREFWYzBZVkpqRGI1UnNlQ1duaFU2Wk5JRytQRk1tTHNP?=
 =?utf-8?B?RlBZMVBhSFZhUlo4REpham5iQXdWZmdiUkk0S3dyREdwNE9LRTMwd3hybFBr?=
 =?utf-8?B?Y2lRSHZZbE1BVnA3STA4cU9BRkxBUDBFbHZCMVdEZXdsMzV5ZHFpNVJnWXN0?=
 =?utf-8?B?U2ZKcmhoWDhLY3lGSnk1QVJ5WENTVEhIS3ZRbUM0WTRKTklIZ1FwZUJ0UGJ1?=
 =?utf-8?B?dllLZ0NVYWlNS2RYSlFjM3dKeHgrNHJLazE1UG56YWxlczlnVXliUVRhZzBv?=
 =?utf-8?B?R0E4SkgrcU9STHlENVU4cnhRYVR0RWlNWGxhNzQwdmQ1dTJhWHlHZXdHMGlz?=
 =?utf-8?B?ZndsZzBOL0Z2MHRJMmxuZmZtdkVZZDZMNW1mbjE2ZlBMWVVlajJwMFE3clRl?=
 =?utf-8?B?MSs3b0dNQ1VKQmRuNE1ERmdRQXFSZkVKazE2VE5ndkVKc3ppQWlJQlVCa2Jn?=
 =?utf-8?B?Z2VjSmNJNmFnMVVUM2xXaEVlb2J3UHozSHo5OVhJMHk4RzJxdnVkR1R3bXdv?=
 =?utf-8?B?S0N1cjZ6L2xVZmUrRjlDWXZteSsyNTlnMHhFclRjeHdjdzdqUm1OQ2J0bFBE?=
 =?utf-8?B?TTl2ekU4QjBoaCtQK1NTVk81cU9hYWgxdHkyblBNalVOT2VSNkRXQjN5cFBk?=
 =?utf-8?B?cHViOVNWZzNIbTl6QndZM0NzQ1licjV1Wm13N2pwd2Ywa2tqMU84UGJSQ0Nz?=
 =?utf-8?B?TGtYZVZZYlB4MjhvSGpzQ01PMUcyemVTMm1TdEQwNE5Zd0FsMWY5cW9wOW43?=
 =?utf-8?B?eVNJakJzNUM1V0FwSDZYSlQ0WHc0R3lGZ1Rxc0Q1bG9IQllSVy9GVEpvcng1?=
 =?utf-8?B?bmF5RWNhVEZjTmRHVktCSlFMTUVUbGpEZkVHVjZLaFhBSWVOTmg4Uml6Qi9K?=
 =?utf-8?B?M0loOFFmd3hJSWQ5YVY1WWw2ZUNNTlVTeUhzc3BNbUFJeURZK1BYOGluU052?=
 =?utf-8?B?T3BwcEFIY2xnUXU2WUFhTHRLclhPZE5oVVhKelMybkJhbUN5MVRTZ3FhRzJO?=
 =?utf-8?B?cm1ia2tzb3dxQ1JUNEQ3dEtEQmZWb1VZKzBLREhsQzdJdkhZeG5FUFdjYlFl?=
 =?utf-8?B?bGxLU0ZOWld1eGNjRWFKdlBOSk5iaGpjOFpYZS8wOTJ5Zmd4NGw2TG9XeHYx?=
 =?utf-8?B?cE1PNlMvOFRPTEtsZnAvN0lhZXBscVpjVW1LNGkxQ1hYbFp0U3N0VEZ3RWJw?=
 =?utf-8?B?U2RXdGpiWGFrNERkTnlTYnplUnpYSEVIV1RoUXlxU0FzT0Y4ck1wUS8rSjNt?=
 =?utf-8?B?Q2JFdm1ReCtoREVKNDBXNzM5SEt2VHZub3pXMXBCK0Z0MzRYczRFQjVKWFJ5?=
 =?utf-8?B?NTRESGpkVGNpa3QvZEJVQVRnOTVRYWtneUw1VWM2NzV4V0VaODcrL3hMZ0tp?=
 =?utf-8?B?WmQ4SGtPQ3FzS2RhL2swc1RwMzRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AFFBED602520645B1A98A1ECB22AB8A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72205af9-ee8f-4d69-6a10-08da00395fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 12:52:44.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5IJ2oC7Ijz3KMJ2ukTl0aZFeHC8w/TmFe1/dexHrJ0i8CojWEa9EDOYUxlrOf6Revzd7P6eSiHp8V/e3Z6kPYIoPenDDcaG0yo6VpP0yZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2643
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMiAxNDo0NSwgTWlhb3FpYW4gTGluIHdyb3RlOg0KPiBUaGlzIG5vZGUgcG9p
bnRlciBpcyByZXR1cm5lZCBieSBvZl9wYXJzZV9waGFuZGxlKCkgd2l0aCByZWZjb3VudA0KPiBp
bmNyZW1lbnRlZCBpbiB0aGlzIGZ1bmN0aW9uLg0KPiBDYWxsaW5nIG9mX25vZGVfcHV0KCkgdG8g
YXZvaWQgdGhlIHJlZmNvdW50IGxlYWsuDQo+IA0KPiBGaXhlczogNTMxZjY3ZTQxZGNkICgiQVNv
QzogYXQ5MXNhbTlnMjBlay13bTg3MzE6IGNvbnZlcnQgdG8gZHQgc3VwcG9ydCIpDQo+IFNpZ25l
ZC1vZmYtYnk6IE1pYW9xaWFuIExpbiA8bGlubXEwMDZAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogQ29kcmluIENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3JvY2hpcC5jb20+DQoN
ClRoYW5rcyENCg==
