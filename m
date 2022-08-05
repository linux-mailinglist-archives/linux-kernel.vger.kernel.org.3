Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC1358A893
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiHEJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiHEJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:15:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376774DE5;
        Fri,  5 Aug 2022 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659690901; x=1691226901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rAOx5z/5UWUUcNHdoz7gpy3K0SyrPk6UNL08pd6XLLU=;
  b=xCmjlY56jwqDVOiFCzPMJHi2q3r0pbdZslU5QqjmAtml2ceo4yaY2DjP
   CJRrW+x/tZnj6Y76dMgcziBkU6WlPS5Dj4przk5mnWevTVSrFjnISnZ2a
   Ly0KPavOzkUg2ESGaSfDyS1kqE4iN4cMaWCFtRxK1el7nMy+cruii6qru
   mWPadThCFIJbfpMb0uorTrTSilVcvs1JAvblthYNlHGVzUKOdautNgTQI
   bYrfpPXF7KGl0+YjnxuRQT3Ac51RgapPGnrigRZ4b4ttKxXdkoDbN4EhT
   nDswrm6PYKkboC5nHJ7shIs5k1YfmaGbeJ6w+d3YVooPN9kVKCbd4podk
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="185243576"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 02:15:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 02:15:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 02:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gATKRFjjLDIHf4rqcvGFw4P2kiupq4hwx8KXHqdBxeIxNW2C7MX31XZLrMapeOMW0DZZaNZDfy0ZI6kx4RMxBIA8APLurc24El8xQYk5LEatxzwC3VYxZ8Fg5rx+u8OBDVcxsi+R229R0OrRNv8Hf8ulovvTgwyrABD7M6mYUnwqATlPCZA4fUQRwG0rf1FgSyR9zExCPCPQU1ny8fsp2hyHV2gf/PuEgqegeRticJdBhiob11vnK8JRXmeUXdP1v18ZYx0KVHvva2UaJHigkAmLxrNIazxRZ3igHj0vT3hzrBPtN4PxkfMVxuIKmTpY3M5qzS3CBxE/yaCeZqbuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAOx5z/5UWUUcNHdoz7gpy3K0SyrPk6UNL08pd6XLLU=;
 b=SkkGxs/SlOjTitqdtsEsrahWSFAYuqbF4WAXlyWLikI1/hAhu1YC6N7y60ZaLdand8qBfluMk5tUxZ+O/8JLP1moWctWemmGTpacT4gwPhK3JcZRuIFnc9uVXlhPUYGudqU7zpqGpB5WSCsoHcv1PM6F6wbAi7NfBkdJvvr66Vuyd96/n32ISbIKYk/6hLTfXncZQKvSr1Q5B3higJT0y34zEMBW/pKYHuDCoI8JTKaxATvB0YeXpLp10uNPS+8w9Ih680cos72FvSCGshO6BWzeJszYYIFEj7mumOP4qFqFiOBNycmiqkflBvy5eu3gAoNCqej9wNRHf2GIG78KAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAOx5z/5UWUUcNHdoz7gpy3K0SyrPk6UNL08pd6XLLU=;
 b=YnnhABD3knnR59hAUsb6yYiL1cnGWq8y1cdNEbIHm1dl4S0YUtPVibg52yv3r6IJy8DuDSdc6nr8LiGr9duzxVKVNOHkreHUoDY8YQR/MLSiqmxEydjpA4odmKj7EDVPlRQsEsHsbuP2ttFMjltCwStjZxcWczTC4fHlN1NdLBQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 09:14:55 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 09:14:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nagasuresh.Relli@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v3 0/4] Add support for Microchip QSPI controller
Thread-Topic: [PATCH v3 0/4] Add support for Microchip QSPI controller
Thread-Index: AQHYqIyWvJiWafjpwk217SfDhgNlRq2gBroA
Date:   Fri, 5 Aug 2022 09:14:55 +0000
Message-ID: <dc4059db-ab72-905e-0f04-1c86cbd3d49a@microchip.com>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
In-Reply-To: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25f343f7-27cd-47a0-d663-08da76c2f638
x-ms-traffictypediagnostic: DM6PR11MB3146:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79LiMjpHA/4+X3/IilrnoyUjRWKlPmx5+HhveX3Uuxs6UI3tK8jVkHgj/O2m+j911bWao+9qmuf6OlI4H1Nrdupu4Bo1kKd/C51Eb9I+E1VbxwaAZ6xmAEMr1IxbyoVzfsurQiH1yBNwZckGWRqiyR8o9jJVJESvoipE00pKjy2NnxdMc5wlvalxnXAQq0FpwcwQUAZoiJkzOY3RFwJV9/AF420+u2DinROAmQ7qOWIYs7I0uxq7FuboV6k6470hAGqMeZiRsHigM5oPaXxQOl6TB60LyODl39xKaSzonBIKaZJKfyD08tZlvg5Fa4/4tMxGvxtemZqof0YelZO6AJAjR80kzSGLH20gARjP8F4Qy4tdkK/aU2NMQyWoVHJGPxX+kUFq5qWq+1ya5R9BOkS7zGiu6I1UOKZH3c+qIQCCJHw7MVoqRxpzJrnKs0GrbUmaWM0E/rCTcp9ZzrVZ1JP7wuPuN4lvl+Br1smDKEbZRRC8RXHoYJOgmVevhY7TyCn6+/wMgr6oBSXui8Qcqw0fajjmWQcnTzNyO7qhWLIOVB8pc7ZNjzbYgMMzUzVRFRXmr0WEzfFb97QsnTkHNmzCVTA+t6sz8HOX7VBsefG3btEjTL2+YS3ta1q82IymEAI1ujdWYcNtx6J7I83RKdB2hl72Xe//gCvret7OqW4m5DaozhIcWBPS3d2A3kwXHDeF1v8fTb3uoM+jOhisECdOgRMCz0FI46wl2GRxsI4im8M3PMYkhNV4lH/BXwIIcrI9JkXJwviWq0kNLddc/d/E2jXw+kNWa9aBFXkfkrvP+bpZl8Dsxkkm8GDSkwrkCFOZ2jzhx6OzBrEGb/K7qbnDOGnwM4l5zdi/JkUkKmLFjJ6Euwu76OKwY3FslJ6Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(346002)(396003)(366004)(107886003)(6486002)(478600001)(186003)(54906003)(83380400001)(38070700005)(76116006)(8676002)(38100700002)(122000001)(66476007)(41300700001)(66946007)(53546011)(64756008)(6506007)(66556008)(66446008)(86362001)(5660300002)(4326008)(110136005)(91956017)(26005)(71200400001)(8936002)(2906002)(2616005)(6512007)(31696002)(31686004)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2VDaFl1UmZUK2p5UlpPTFF4M2Z3b256WXAvV0pHQW92NThoQ0xDL0dOQllI?=
 =?utf-8?B?Q3cvYTFObDk1RThxaGtSTXVZOXc0cXR3bENVTjc1d01rNUpGZWxYaDVtVHQy?=
 =?utf-8?B?Sm9lVkN1cmhBQ1hCNjRXYWloZDdRcGZlK0VPQXRnbkhZcERxckJDajJubGxZ?=
 =?utf-8?B?amh2Y3FZQWxVanFIZ0d1ZHJPU0FlQVNMaFovMEdjdC9HQmlGMnBpSm4vNGFB?=
 =?utf-8?B?TUtxVkYrV2xzVko4UUhObkJMZlc4Z0F0SVRtazUrcGZsM3Fmc2FxcXVoY3BK?=
 =?utf-8?B?QjJReG82TmY2WmNuMlFWdHJzcmk0ZGJCd2N2Q1NoeHdmam9adDMrT1RZUEQ2?=
 =?utf-8?B?OUN6SHBZR0ppVWFjNEVENzc2bjNGdFBwZFRweGVSeVNZOUpIRWZHOXhJUWhB?=
 =?utf-8?B?WlJTS05ZVUtHVUhOY251M041QVBKVDUycDN2MnZkbDFnblBQc2lISGlVc1Fv?=
 =?utf-8?B?UTZodFEralJ3MERSZFdQTzlSYjhEMzRyOGwwUE9QZW5ycnppektjM3I2cUUx?=
 =?utf-8?B?K1N2U1lLTWM5Z0djcWNoRWVMRmRpbHY2cWtEOEd6dTJ0a2lBU2poTklMM2pp?=
 =?utf-8?B?YVg0UVBDRWkwdVJEL1p2bExPSEdRN3ozdWNsRWhYV3BXcmxBYkNXRFpIMzYx?=
 =?utf-8?B?UXdpWlY1NkJUcGIzbVNyQzU5NDJPWHluZXM1eDA3aDZFUXBJL1N1NVNna3dp?=
 =?utf-8?B?TXpsaWFERXN6Tm54QVBZbGg0cStETTdSRDlUTWhUbjljeFdtVTJvMWQwbUJn?=
 =?utf-8?B?bEl2L0hJUHpBd2EraG1rZ3NPSWxDeHVoZ1ZLemRoeVMxRlFkUjhocnRRRGMx?=
 =?utf-8?B?ZWtLOFF6QXdQeHNsZHFCbDN4cUl0TmVCOG5nUWY3ZFc0Nll3SlZHSkR0aXRi?=
 =?utf-8?B?djU4TU0rUnZIeFk1dUlHN3VHVGNzYmlvM2Q5UldMRDZpZmprc1BWNzEzVDdv?=
 =?utf-8?B?cFUvNXhYcnhFcEhKekxoSURxRSswNFFkL2kxenVQeFhURisxZzNueXlTbGdZ?=
 =?utf-8?B?YnA1YTBrSDUycGJHWU83SjN2aGhGZXBJeVRlT3gvZG1nQWdhT0wydlFUZW5l?=
 =?utf-8?B?K3NQTzk2aHBFUXZrYUZ3dXRBOHY4WXdocndXVGVoMmh1dk1yV01aYmdvdnBi?=
 =?utf-8?B?OHROalF5L0pOS0t5eUQ3a0ZBY0tqWVExeHdIRSs1dzM3VnE3OEFxcFFzSzRD?=
 =?utf-8?B?TUkwNUI4K1MreTdiTG5hOUE4ajIwdFk1VStQY1gxRGRRb09TeUluMDNVZmJ2?=
 =?utf-8?B?Yi9QazNIdHUwRzNESTVMQXA5NFVBVGR2bi9tL0Q3STJDOFlGZE1Zd283VXkz?=
 =?utf-8?B?MEc4TjNNRU5kTlI0eUN3cmhQTFNpM3daMzFrVjFtL0VuWnNhRjRFdE91dkdX?=
 =?utf-8?B?YkVlYmtldmE3NkVXK0NSMVJiTkVXa3o4QUJ3dmpqaEJXKy9CUjZYSUhPdGY4?=
 =?utf-8?B?ODNQYlBxeStqWGFmNGxzNkVIOEdjK0JJVldkaEdVTG1nQ09CanFWOVJPZ0RZ?=
 =?utf-8?B?ekVvWHlaQktwNnUwZDJoanBzR001TXJEQm9GbGMrSE1uRDZSRkJWSXU0ZVNV?=
 =?utf-8?B?eHAzeHYrbFZWREg2NFprUlZMeXZWWGczamo0Umk1djRsdWJaSFB2U1YwYjZU?=
 =?utf-8?B?Vi9WbGJMRXJQR0VQS0hOV1hJeHIyeXJoRzV6NUhGek44V3o5UkZLLzRwOEtp?=
 =?utf-8?B?cFd3TG5nOHFxUFBxSkYxcnRIMm1QY3UvV1owUHFCVW9LY2VJK0JyRjVGR25Q?=
 =?utf-8?B?WWI5UTBhc0luRGJucWVJTTQ2QWY1TDR2a1J1YlMxU2dKOGNpMmgzVWdUR2VP?=
 =?utf-8?B?UEhZbHNXbWt5cjdKNW9HeGNlRzVDWE5kbS9tZFZkT21YUDlFcGFGZDBzN21E?=
 =?utf-8?B?VU5WaEI1eHdUbWRhZVBTWUVKd0RHKzA5WjBKKzBMamFQT0dkL3BGV3Brb3Y1?=
 =?utf-8?B?Q3JHd2RLYlQ3YXlVdjFDeTJlaWVJT2c3Zis0YzVoZ2JwQmxJWXlGdFNoZG5Y?=
 =?utf-8?B?QjZZWWE2RUlGQi9CZktxeWhIUlE1eHl6UjZVTmxpdTBRbkhoKzJieitFMzBp?=
 =?utf-8?B?SlRCMitURm1JUndvVWZReUpvakdWUkpkQWI0a2lmaCtqeXpoVllEQXhPTXpI?=
 =?utf-8?Q?43r/RPxyumUNV+JJhfxbH1uJw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0490F5FF9696794590085A3DA2E150D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f343f7-27cd-47a0-d663-08da76c2f638
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 09:14:55.2843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMv+bEflHQIW3DuCHLwxCHd3/thKJYVCPL1FP03G/mp/qyvEzxC+qMi65LSxxfHpvOONWjSlxTVzFsz6l9F46L4zt7jRY3IUMbkNucQ+Xd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3146
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDgvMjAyMiAwNjozMCwgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToNCj4gVGhp
cyBwYXRjaCBlbmFibGVzIHRoZSBNaWNyb2NoaXAncyBGUEdBIFFTUEkgYW5kIFBvbGFyZmlyZSBT
b0MgUVNQSQ0KPiBjb250cm9sbGVyIHN1cHBvcnQuDQo+IA0KPiBUZXN0ZWQgc3BpLW5hbmQgKFcy
NU4wMUdWKSBhbmQgc3BpLW5vciAoTVQyNVFMMjU2QSkgb24gTWljcm9jaGlwJ3MNCj4gSUNJQ0xF
IGtpdC4gdGVzdGVkIHVzaW5nIGJvdGggRlBHQSBRU1BJIGFuZCBQb2xhcmZpZSBTb0MgUVNQSS4N
Cg0KUGVuZGluZyBLcnp5c3p0b2YncyByZXF1ZXN0cyBldGM6DQpSZXZpZXdlZC1ieTogQ29ub3Ig
RG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KQFZhbGVudGluYSBjb3VsZCB5
b3UgdGVzdCB0aGlzIHZlcnNpb24gcGxlYXNlPw0KDQpUaGFua3MsDQpDb25vci4NCj4gDQo+IGNo
YW5nZXMgaW4gdjMNCj4gLS0tLS0tLS0tLS0tDQo+IDEuIEFkZGVkIGRldl9lcnJfcHJvYmUoKSBh
dCBwbGFjZXMgbGlrZSBwcm9iZSBmYWlsdXJlcw0KPiAyLiBTcGxpdCB0aGUgZHQtYmluZGluZ3Mg
b25lIGZvciBhZGRpbmcgY29yZXFzcGkgY29tcGF0aWJsZQ0KPiAgICAgYW5kIG90aGVyIG9uZSB0
byBhZGQgY29yZXFzcGkgYXMgZmFsbGJhY2sgdG8gbXBmcy1xc3BpLg0KPiANCj4gY2hhbmdlcyBp
biB2Mg0KPiAtLS0tLS0tLS0tLS0NCj4gMS4gUmVwbGFjZWQgc3BpX2FsbG9jX21hc3RlcigpIHdp
dGggZGV2bV9zcGlfYWxsb2NfbWFzdGVyKCkNCj4gMi4gVXNlZCBkZXZfZXJyX3Byb2JlKCkgd2hl
biBkZXZtX3NwaV9hbGxvY19tYXN0ZXIoKSBmYWlscy4NCj4gMy4gQWRkZWQgc2hhcmVkIElSUSBm
bGFnIGluIHRoZSBpbnRlcnJ1cHQgcmVnaXN0cmF0aW9uLg0KPiA0LiBVcGRhdGVkIHRoZSBkdF9i
aW5kaW5ncyBzbyB0aGF0IHRoZXJlIGlzIGEgZGlmZmVyZW50aWF0aW9uDQo+ICAgICBiZXR3ZWVu
IEZQR0EgUVNQSSBJUCBjb3JlIGFuZCBoYXJkIFFTUEkgSVAgY29yZS4NCj4gDQo+IE5hZ2EgU3Vy
ZXNoa3VtYXIgUmVsbGkgKDQpOg0KPiAgICBzcGk6IGR0LWJpbmRpbmc6IGRvY3VtZW50IG1pY3Jv
Y2hpcCBjb3JlUVNQSQ0KPiAgICBzcGk6IGR0LWJpbmRpbmc6IGFkZCBjb3JlcXNwaSBhcyBhIGZh
bGxiYWNrIGZvciBtcGZzLXFzcGkNCj4gICAgc3BpOiBtaWNyb2NoaXAtY29yZS1xc3BpOiBBZGQg
c3VwcG9ydCBmb3IgbWljcm9jaGlwIGZwZ2EgcXNwaQ0KPiAgICAgIGNvbnRyb2xsZXJzDQo+ICAg
IE1BSU5UQUlORVJTOiBhZGQgcXNwaSB0byBQb2xhcmZpcmUgU29DIGVudHJ5DQo+IA0KPiAgIC4u
Li9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwgICAgICB8ICAxNSArLQ0KPiAg
IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+
ICAgZHJpdmVycy9zcGkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsN
Cj4gICBkcml2ZXJzL3NwaS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
Kw0KPiAgIGRyaXZlcnMvc3BpL3NwaS1taWNyb2NoaXAtY29yZS1xc3BpLmMgICAgICAgICB8IDYw
MSArKysrKysrKysrKysrKysrKysNCj4gICA1IGZpbGVzIGNoYW5nZWQsIDYyMyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NwaS9z
cGktbWljcm9jaGlwLWNvcmUtcXNwaS5jDQo+IA0KDQo=
