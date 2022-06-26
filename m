Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2255B16C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 13:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiFZLKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 07:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiFZLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 07:10:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD5C14011;
        Sun, 26 Jun 2022 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656241808; x=1687777808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CqJf2Z01nbXRgpxlTU01p4HDiFum8ZZ6zkxPSndh89U=;
  b=uDfcSZzxlBbBSwfWO6hMv41N9EkfadcAFlf+D97HCrhoDGaqdtN4n09D
   7WMGU/S28V5/d6CqArcWFPB7eY5jZ3rn//rBrJpPAcIXjyewlDcKsXoSy
   SIF382ww+TLkrWYs4sP3nzvY1kJ9UlWQ/215qUacMbJqQLxneleSM57mw
   jq0rjTMIxOg5CEUnilQ0BKbGqZnzTMnVfYbNfW5QbpoPV3Wo3k2Pn9AqJ
   dh/byZiiAKdtnct2Hpf93/ZHBxuxVhrnZVoqvwbUiKrtRylReHHS34ibK
   xb6IGh0fSlyB9MnMCvNZjhPKaTtEa7A9fqObt+bYp/PiXbbZHjM5jwtZ0
   w==;
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="179544267"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2022 04:10:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 26 Jun 2022 04:10:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 26 Jun 2022 04:10:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksdMnQzZ2i1WwA2EW9sPZW/2QHGvXs3jxEl408TJzI4tFVe5bFkp8JVveArXCDZBbppRvnaomtnC9jMp9uINyM2SyyisB798+C4PFCogfflwaO6Fkl0yOu43CI5iBTr9Wdt6SczwOHsseHrLLceSbnr6Mp7i2hSjurb/U1zV5yH/zrHLUgi7LlhPtbniWf5NHGfURqzs5Wl4CLcQxYdUGtVNpT8YIZKirni+B7/Vd0QI3MDng5fJiOya+31N9clB79RIuXoe1VG9QylWu2CQSt932DNhANNNDc+HiDirRmVLRPfmvNU4ySvBODbuHklypn3/7FJCxwOWl06aiAYBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqJf2Z01nbXRgpxlTU01p4HDiFum8ZZ6zkxPSndh89U=;
 b=HaK4lIykXIZAdir1QAdkJ1/odQpB5Jc/jfSaLHA9RYYv5jt9oQnGckORpFeoQVXcX9hhRRi+SpjLDb5/iz01ADAsrw/f/aCSQSh9GCLkztEeHj95iUK+4fIBzTR/jeSpm2cGG1DQ8Jv6Lf57cqgvzsYGjuwoPyaeMHf/6mS3/Y4mUvhHnFljGLGZnVavIaPo/kh75kApuZV2PhmyaVGPW7xyxduX0uL6aNw3y5KWAWesYKB0VAFw97366Ae3UO/PP1C3iHPYmMtSeNf4GAcXXykKmEzwzFfXGBH2R5EBTPR/b4q9UUv0at56xhq0uSB3ZcOXOPo4jbmg9BuWneurjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqJf2Z01nbXRgpxlTU01p4HDiFum8ZZ6zkxPSndh89U=;
 b=O/yg0ACoHihsuua3WjOz+TXJ7YQPqMeb53OUsvD49Nr3Z1mWLKYADMn/EjwhCXKqk8lww8VjDBGJ47o126atzMGDWxPfkHuooUE03SZWkMYWMMlrD5m+WuM562AQfBSfubv2UGt1WHBPpdiOsbArd70B8ATBH5ROKFXFKTumbco=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3756.namprd11.prod.outlook.com (2603:10b6:5:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Sun, 26 Jun
 2022 11:10:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 11:10:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mchehab@kernel.org>, <linux-doc@vger.kernel.org>
CC:     <corbet@lwn.net>, <mchehab+huawei@kernel.org>,
        <dmitry.torokhov@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <support.opensource@diasemi.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 18/20] dt-bindings: mfd: update dlg,da9063.yaml
 reference
Thread-Topic: [PATCH v2 18/20] dt-bindings: mfd: update dlg,da9063.yaml
 reference
Thread-Index: AQHYiTzNapQAv3PM2U+ERVSvek7NS61hiBMA
Date:   Sun, 26 Jun 2022 11:10:01 +0000
Message-ID: <fdccc65d-ecfe-1332-97b8-ee7cb0430b69@microchip.com>
References: <cover.1656234456.git.mchehab@kernel.org>
 <da459164d166d994b06f9ce8bf3a2108ccd0abd5.1656234456.git.mchehab@kernel.org>
In-Reply-To: <da459164d166d994b06f9ce8bf3a2108ccd0abd5.1656234456.git.mchehab@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d1fe7ff-d1a0-4376-6d4c-08da57646a0a
x-ms-traffictypediagnostic: DM6PR11MB3756:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXpkAvJ6SmnM0T/E0y/t8y5iQJs45PFFqwgXLBEG2IvXBi0pem6cBgu6wOAZZkZMvBoNZ4VfKuGpEEfLZfoK0RAuKXxUqWN9ZaqUHBI1KujOZ/mmWsvAJNDVIIX8T/SO34pZHcz/46Kygx0cwVSsXUWMBiZph5KABVDlpsW/tTycX2jEtGsAdeTwTG56BQOdQ6p7SzOTxn7gBcLAKbZqsae6qgtb3Pu79+lXgNNJVLKF6+H7TpkoSBu8mvOrI7QM4bezX1z+I8ga0jYzl1JQJ4o2WNzBOH6ad4lFixNiuhu3xibiOX3jcUbCS1x1SO/2qKX0iCeHWXULYFZh23lIWsaWGBptndT7Bota1clqdHYe5AjYX6HQe5wczqTDN16Xg3F8ryZ0PJfeAZfNc9Km976F5gMJ861/IJPetnBHcYbv7NYBKLwnOZlTbGLxS6f1quKq9XgLv4cVWAtabubUac1MJb4jWrqJTcJIAvJ1GXgGG8j4gAuS3zWTzpklNro3YQ2kXR664/W7iOOKF4VE9oEzUrdKdsSjhhoMkaXrvD3vs8cQKifSAp07jhvpBDNHb1Ikbk74W4E2BIlze7l1U5+bqfkKB9j9cX3GrUxAPey0irdczqIjTmXzMLLdU8CP4uZkwEhRQ16gvme3egPSyIlJgR95d04JEY3zF6GaLGcWF1LxlC3TulAf8D9hSuappQYnvGKBg6ERnLuR9vAza/zlt5llNC00QZonW0popOtqsFfuHy1S4VU/xCwTyXSwvL2qFbmGeisNIdPcr+BNoU0uLrEdKjTxSov7Xfp5LOcKd30T5iIBpptLggdlaEJpOi0mS51ZK41bmyCzXrV3V8noc9+vc1+W0TBMwLyCfW4pt7j9bsdKiQbKwRtoI+HhYo77v5BxfR0Du35GqG+zPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(376002)(39850400004)(136003)(83380400001)(122000001)(31686004)(53546011)(15650500001)(6486002)(36756003)(7416002)(2906002)(186003)(86362001)(31696002)(26005)(5660300002)(8936002)(66556008)(66446008)(91956017)(64756008)(8676002)(76116006)(478600001)(4326008)(66476007)(66946007)(110136005)(54906003)(6506007)(38070700005)(41300700001)(6512007)(2616005)(966005)(71200400001)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXREbWpjaDFzRERWZXRLSVRQL0JDeWQxbWduRmxyejdFMStwaHhOM0RhQ1ZT?=
 =?utf-8?B?N040MFphWmR3WlE3S3hzM1h4Wld0NVVMWjlrSFRZcGJXai9aSzk4L1VseGEx?=
 =?utf-8?B?SHRsMWpXSE4yZlR4eS9uSTFDTHJyanhOTTB4VVVydnB0R1IvM212czdOUEZm?=
 =?utf-8?B?L2NXb3BDYjdpck9maVA0aTBKQ1dmTit6NmlsaVZLMW5RRTVQT25tTE5QTkdG?=
 =?utf-8?B?SjgzeFdtc0RHOWwvbm53TXJNSG9UQituR2RIYnBHN3EvTUdWdWRuNVM2NWcx?=
 =?utf-8?B?eVFFcmJLZUVKdEtsWDlGOWw1eW4rTE5nRFNlTmMzVEt5czhLNjRJbWJMYkZu?=
 =?utf-8?B?d2dZTnRXVlFCVnlUaWVHem5zRXhBMThsVXdwME4rK2tXNzRlQUh4emtpeVdh?=
 =?utf-8?B?VUo3eUJxV1c4RXQyUVVvNzFoUm9WcGFHd1ZUNDNkREs3SmUxa2E5SzhxdFFN?=
 =?utf-8?B?bFdCTXlWVXFiQjJpL2g4bSt3QVdFUFhjdkFpcENyWTN3NkhJTXZDUVRNc0Q1?=
 =?utf-8?B?YWhNQUJycUNWRWZwdWg2UGN1eGI4cVkvdFMzRXdabDBVMkpjb3I2UmVpUXlE?=
 =?utf-8?B?V3hHWm4yNWlEdHBxZ1N2T2NOWWw1VjVJZ1luWFFOeHFCOHV3NjdJMm4wZ3hJ?=
 =?utf-8?B?RGdodWloNkhsaGprS2Jlb2VSaUZENG5NbzVzNGt2MEVaNDNOTVpUZ0l3N1ly?=
 =?utf-8?B?WHNEdDQzNzdnMUFaN21abURlL0JMczVaTjNwNi85eWt0N3VZM05Ib0pnZW5a?=
 =?utf-8?B?VlN1MC9qSmZES3A0OWhMSXQ1Mk45eGJsY0w5MTdaNFFwM0ZiUm5XcnBMNkRB?=
 =?utf-8?B?YWtZRHdVT25EamR3a2g3RFE5TENPM0NYeEFmajQxK2tIS3RVVmNCNVRKaHVy?=
 =?utf-8?B?UlBSTDV2U21VSG1iNHlSVTcwTzB4VGR4enVXRWZFRHNhYzk3RkkwMXVVZi9G?=
 =?utf-8?B?MjJFQlR4dUYxRW9WRWNmUyt3VGVqLzdqNjZJZnYwWWZpMjFqY0Y0ZGloOTRX?=
 =?utf-8?B?d1ZyQUcvWlFuYTBYVTdIQ2hrWDFFUy9mSUlhWUdPV09zdVk3dTQ2WDNlQ0lW?=
 =?utf-8?B?M3dnSVFwT0hmUjFVclhXRysvUmFFYUplWmwwdkFMRVVlSmRvdHUyWFdXMnQ0?=
 =?utf-8?B?aFlySFJvNnZlTlJ5cGNqbHlLY0dXUlVmOEcxZzZsTVg4aVMrMWdKTi9ydklj?=
 =?utf-8?B?ejNZT3dUTGthL2hKZkVNSU40N1AyeDB5WXFCMjdmdWVtK1paM2pZdm55M1ln?=
 =?utf-8?B?RjZiMlhTOGI3VmUyaDRkLytLcE5YUlFmeVBWNDZHbzlNZjBkZ3kzN2kyZTNK?=
 =?utf-8?B?MGdJYjRxRTZtM2UyNWNwRDE0VzBGZXRYSDc1Vm0wMzBGdWd5c09IQnBWaURs?=
 =?utf-8?B?aENrR0x4d0ZCZWQyNFphME1BK2hhazJxOTJoT0NqeHJMb0lScDRrOGl3NTI3?=
 =?utf-8?B?dVowcE9ieGxGWlpMQ3FPTG9zM015a05ZSmYrQ0VNWjNWY3BaVFVYd3paUEFv?=
 =?utf-8?B?Sko3cmxzTDBqdi8rdDVlSUtuREw5Q0l1MTZXVW5vYW96VDMramt5bzZDd1dy?=
 =?utf-8?B?YncrZC9sMzQ2eDJTMzFWTmd4RlVoNWhHdkR4UERrMTIwMjdCNStRRmw0alNW?=
 =?utf-8?B?MEd4am9BVGtGUnB1OUNyNFFNaDB0WVJYWU5lQm43OUsveTJuTzRDOE5Gdjh2?=
 =?utf-8?B?bkJSa0M2a3FBbTQwUk5aR1ZTVFZibU05ekc2VkhMWWU0cXJKVURQcHB5Tk1R?=
 =?utf-8?B?azRvYnpwZWNab3FhQWZyNHErVkpPTnpxYW9RUmd2UFhSQm5ScWI4VWN6aUVl?=
 =?utf-8?B?a2VnVGF6YU9ySXVQU2FSMHZEWGtObDE5eENzUVJZVDNVTXR5bTEwQjR0Yjd3?=
 =?utf-8?B?cXVWRktoMTI2YTlEVHVvaDZueklOeVlweVcwcTdZZktCOE9PeDFCWW85MjBq?=
 =?utf-8?B?Y2ZMRnErSDhldWdoVUQ2bTllNDd0ZWxYVVpmWmNhZTRVdlFMNStxeGc1cEhn?=
 =?utf-8?B?RmlyV3IyQUMzOHh5QW82TDlSNWZFZlNNUXFXSkNMZk92akdrN0NxYXIrMFc0?=
 =?utf-8?B?L1d0S1l6S1dHUERCZERUaHZLbGlReEZQSGxYNkFOdVQ5T2QzRS9MNC9sTytk?=
 =?utf-8?Q?T5IZnPypobv7fyt2E0aK0uONR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8537FE35B299F4393CA4A3BB0FA54F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1fe7ff-d1a0-4376-6d4c-08da57646a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 11:10:01.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZTweec3fi7sljcRqnh4gHEjoDCL77j1kqn3xhW6Qc6TpnEM1qOSNNQrFzApd8K8UU995WHWFruVKA8Lb6tjcATKCSZjW414PwMLEkIcZ2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3756
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDYvMjAyMiAxMDoxMSwgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IENoYW5nZXNldCA0NDE2MTM2NjJk
YjcgKCJkdC1iaW5kaW5nczogbWZkOiBDb252ZXJ0IGRhOTA2MyB0byB5YW1sIikNCj4gcmVuYW1l
ZDogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9kYTkwNjMudHh0DQo+IHRv
OiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2RsZyxkYTkwNjMueWFtbC4N
Cj4gDQo+IFVwZGF0ZSBpdHMgY3Jvc3MtcmVmZXJlbmNlIGFjY29yZGluZ2x5Lg0KDQpIZXkgTWF1
cm8sDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCkFja2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+IA0KPiBGaXhlczogNDQxNjEzNjYyZGI3ICgiZHQt
YmluZGluZ3M6IG1mZDogQ29udmVydCBkYTkwNjMgdG8geWFtbCIpDQo+IFNpZ25lZC1vZmYtYnk6
IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gDQo+
IFRvIGF2b2lkIG1haWxib21iaW5nIG9uIGEgbGFyZ2UgbnVtYmVyIG9mIHBlb3BsZSwgb25seSBt
YWlsaW5nIGxpc3RzIHdlcmUgQy9DIG9uIHRoZSBjb3Zlci4NCj4gU2VlIFtQQVRDSCB2MiAwMC8y
MF0gYXQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNjU2MjM0NDU2LmdpdC5t
Y2hlaGFiQGtlcm5lbC5vcmcvDQo+IA0KPiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9pbnB1dC9kYTkwNjItb25rZXkudHh0IHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9kYTkwNjItb25rZXkudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2RhOTA2Mi1vbmtleS50eHQNCj4gaW5k
ZXggNWY5ZmJjNjhlNThhLi5lNWVlZjU5YTkzZGMgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9kYTkwNjItb25rZXkudHh0DQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9kYTkwNjItb25rZXkudHh0DQo+
IEBAIC0yLDcgKzIsNyBAQA0KPiANCj4gICBUaGlzIG1vZHVsZSBpcyBwYXJ0IG9mIHRoZSBEQTkw
NjEvREE5MDYyL0RBOTA2My4gRm9yIG1vcmUgZGV0YWlscyBhYm91dCBlbnRpcmUNCj4gICBEQTkw
NjIgYW5kIERBOTA2MSBjaGlwcyBzZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9kYTkwNjIudHh0DQo+IC1Gb3IgREE5MDYzIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL2RhOTA2My50eHQNCj4gK0ZvciBEQTkwNjMgc2VlIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvZGxnLGRhOTA2My55YW1sDQo+IA0KPiAgIFRoaXMg
bW9kdWxlIHByb3ZpZGVzIHRoZSBLRVlfUE9XRVIgZXZlbnQuDQo+IA0KPiAtLQ0KPiAyLjM2LjEN
Cj4gDQoNCg==
