Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDF5AD07A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiIEKqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiIEKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:45:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B0E4D247;
        Mon,  5 Sep 2022 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662374749; x=1693910749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GBTMtMEpCEXLPinN1RVWzttXeTO9Vziy1w8C/MAQqC0=;
  b=hIP6v6ZMhcWLOJXQmCoZc+lOYHXmrK5LNMTSFNzBHksx7xcNBfWiukOP
   r0LyrfljzyxHiH5Mz0z2fx3TxcI9Bn5ChON/PBtsCjHNgu8seAsZDhKk2
   sxcIOzVI3QxFR1ThfFwNmOgkBpJObvIPcxNuO/jtvHW3jt1XPau9At6pm
   cymn9LbFEHQb0s44WT4Yh00AQMDNPAY874rFeuul3VaJQyHyAlNNAxXdf
   6CrdIf6YKkCWX4eKM1cfCG9S/mYOKME4NsbyARLfyjHXuGxKWEnvv8tFG
   HZn8PMr/Ht+fHElrQF6T2YyhqNxFCCk70VcDQF/+x5B0cMdnAmH/x6e/O
   A==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="172405470"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 03:45:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 03:45:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 5 Sep 2022 03:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJGLPx4tMuGYU8i2XrLDqMz0wR1IsZyg30JWeaFQHSQntBVVniaP8auGZ+/oeDEomlTM/9E/OrDu03wIGxKH5wrIzZq+JUypYB87uWqBJogaYqk9Ty6vGlXNgyRpORftOSwJDAKLAI1zx3Qk4iZzVoewMz9Q/N5QMyGvUf67EdlfrG+/fjViGVHKLkzwx0VvxXNqKWZzO3kVrYKpdxCVtJnO9Z7O+gDGMk6RnH6mqxXIYgZiD6Eg6j5+KWnDeIT0c+jfTmZlT9kWgC+DEZ9Eg6uo60X/U04DNWjdojGO26VGni9xyhz2eIunwp6Y80+c/okP9yKtmcJLLjyh2T2edw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBTMtMEpCEXLPinN1RVWzttXeTO9Vziy1w8C/MAQqC0=;
 b=fBD/YKsXno9Z1U1MMXSqAdWScGZLAdcChqS6qsNYvhMrLRtzbeCDQZL66qB7hDuiIQ3SyoLq24SKsn6ivw+cpsZR0M5MiAGX1Nx3i4XsJUnwco+Ijiue/Weho36oHOOBVkHmN489YNcWE3uTX3GWbbtA/a8Q4/D69jo/ekYjzrnEZ45iiyspTUH4Ccj8PieLmfGT4bZIRS3NmUc+cs2p5d4wO37r2cccMuI02STs4W/FACQCgAnES1K2pfjpNxIvajM/wiX02SDM6UMAz1ohfyh2LyMAwNDW7ddP2LNB+wNiKmgEDy5olBxNcvFDuEv1L49pZQlaEDc1SrsEoLHvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBTMtMEpCEXLPinN1RVWzttXeTO9Vziy1w8C/MAQqC0=;
 b=lBvqxB5hJq22OSgDQuzH0p6W6pTwza+hNh6CGtRqGN12Ucnx7QcEiZuwZI+gZPkWcx33hsEzxOf3ueBzjg8cehtFln+c+hg481cEl6Aifx6Yh4zyKS1ZJsrJY1l5G2kXEaj/OW3ZH2DiHMkl61pDsMIXQpRl3ZaiKra3/xZ5X+Y=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by BN6PR11MB4052.namprd11.prod.outlook.com (2603:10b6:405:7a::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Mon, 5 Sep
 2022 10:45:38 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122%6]) with mapi id 15.20.5588.012; Mon, 5 Sep 2022
 10:45:38 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYsJ/Hf9/ChBUZqEipNmgMsTD4GK2601kAgAwjgYCAAiCKAIAHsJ8A
Date:   Mon, 5 Sep 2022 10:45:38 +0000
Message-ID: <23d74882a69b39025005495886faec3e5b129ba7.camel@microchip.com>
References: <20220815120834.1562544-1-lewis.hanly@microchip.com>
         <20220815120834.1562544-2-lewis.hanly@microchip.com>
         <CACRpkdbk_ZqYnDzXgmbnAxhs+mEe9f2X-y++9HDS-O=UO_tUmg@mail.gmail.com>
         <31d2bd0514652685cb87a7c9d17529b9064de2bf.camel@microchip.com>
         <CACRpkdZqvEvqjzTN3oQqrV_CNK+D2+c4FjLiC1_ZoKQ-rMMe5A@mail.gmail.com>
In-Reply-To: <CACRpkdZqvEvqjzTN3oQqrV_CNK+D2+c4FjLiC1_ZoKQ-rMMe5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 820f476b-0f26-4b20-91ce-08da8f2bc53a
x-ms-traffictypediagnostic: BN6PR11MB4052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09y2F7DD4XlrMz+YpScJNiWrU490BtppuGN0FcNNYhNBM7J9b016To2izdmG8nH8+kltbue+eM2NP03oE7N2co8dvjfdTe7hoSb7cH995ASKd084GrAaxnVBIq9iZYGxVkTEW/OMatjepLvL5+Gug8aMdc1+hGGi1/SK7XrJ8EeWef5bb9F//5RkUugQ90Satw2uNdu00Cs/+1jCGHSPEpKyRl7+qPyFYo3eWIgpnK0sPvImlnyIPPZqEj/OS7EfhZoVvrrpOLcSCRNByd/SVpvsyyxzQ1t7wmNjnABt/OeP4UhMM/aP6bGTxNTHLgtJMAz8ef4xyeVFBk6NZdbeoxbdJJiq78Oi/pU+L5BKUSPgdcbnhG//I3zOaSZmYoiY+fYWDkfASKFPeysHsFMC+pN40e9ujvb5xm+vwrwPyrWz55x/O0fZb7tSvvQyYm7bW30IH53pDaDzzMORUgTj2v0/xxU5kOIKLsvUnLGuBkpNSLEnLrVhUkvPEseulihT3XW2DJqA2kGHGv7D0m+e4Y3ldmjrhPns+J/25Oy3A2EjEpGFewouRI9wnpO6c5DrqM8JMDPo5Q+0MY5+EqK7edRoykg5x4RmLQNIm4GuffyWSnDdO9dUdjiGRFbfDr8rG9idID/JuqkOQMyMVskmy/lS970g1eX/kepWeDC080FrbVNNxYHaX+ZmzgQusfSIxaKzrhjz19EGvbcT0qGALl4Ss3OqYJSvDYJ2HZNPJEz6BLfTzeKiNgkh9+dPvmVGSsFaqniLvnhlzuA5k7tyOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(396003)(346002)(39860400002)(6486002)(478600001)(38070700005)(2906002)(2616005)(86362001)(8936002)(41300700001)(186003)(4744005)(4326008)(26005)(6512007)(6506007)(5660300002)(66556008)(36756003)(71200400001)(66446008)(38100700002)(66946007)(8676002)(54906003)(66476007)(64756008)(316002)(6916009)(76116006)(107886003)(91956017)(53546011)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTVVd2QrYUpLVVlqdnVnNU9FUlJCSDF6RDVWUkhpTXN0NXBPT3NvMHBxWnk2?=
 =?utf-8?B?MU9HcS9MS21zK0Rtbzhjb0p6dGpVc1JGakZlT3hZUENtNzhyaElWSVJyUnhW?=
 =?utf-8?B?MGZyd1p2OXJwdVlweVFwMlJkRHF0KzNHYWozQTJLWVcwRWlVd1lHWFJ1Z00z?=
 =?utf-8?B?ZmhXU29XcVhHYnFXS29zdzlvUkxjSjZ6bUFTVjNxcXhqRVQrSzllZURJV0tM?=
 =?utf-8?B?TEw1V1NWc3B5Y2RrUVh2SEVJcTJoQVlobzdIUzQzMFdWWS9GSDhrL1Zpemlk?=
 =?utf-8?B?WUpzU3MxMlEwa1pvRFBZRjN0NEZSUkhYNTZhZ3RUYStvMyt5U1dvdlRTZitQ?=
 =?utf-8?B?V2c1Uk9SL1E1cllpdlZyWWpMdGVkSWFkUTFVRHRjRWljU3dkcXpQOU9ZNHVX?=
 =?utf-8?B?Snd3RFRScWZoR1A5WVAwTC9UWUtoVDFoWVYvYnZtUDZHNWJyWDkyMSsxVDNu?=
 =?utf-8?B?UVZKSlBhWkNMYWNGOW1sM1RFaDU3OGdtODN2WXBUTGxhS1BmanpOcHRyc0Yw?=
 =?utf-8?B?TEJoZ2NteTZuVnQ1VUp1T3lmMERQU1pYR09ndjE2ZExiL1ZRblhrclUzTFFK?=
 =?utf-8?B?RGsrbmNFMWxML1dpdEVXdjJMWVpSOU1ZSjhCaW5pcUtFUTVuUGZEaHYwMStj?=
 =?utf-8?B?YzNLYkRHYStYcHkxMmh5aGJ5TXIwdFVmV0l6MnRWNlBNQmR0dy8wemhmSWR3?=
 =?utf-8?B?MEJhc0oySnFqeTZNbEtnRVV5L3JMbkFGZ1RZK1ZIRUFlRmU0M0NNaFNwSDRo?=
 =?utf-8?B?TDYwOUJiQUIwMG9vV0pKbjJGeTA2Q2dGcUNNT09PbUc1Vnloand2WHFuOHEv?=
 =?utf-8?B?WHU0SU01TksxYktDVGhaZEY0TUVKU0ZrdHoyejY1NGpzdCt6YnpvZHlKNnoz?=
 =?utf-8?B?MUU3dWM1TkZ1WDB2VEkzRXp1MGVFSW1IU1JBSHJNRlVITWEycEhwR1kva1Z4?=
 =?utf-8?B?T3lLSHhkK1hCcVdIc3drcVhHL0ZzcWcvQkp5RER3T081ejBpdjdwV0tiaDM4?=
 =?utf-8?B?VkZzMkhWdUNkRGEwU0pYeEJscFBUcm1SMUFTVlN3Mm9Wd0p1UGR3M0NDZ3pR?=
 =?utf-8?B?dGZFblEwRS9heEE0ejJ1SkRIcFNEd1BQTzFFbk1tN3BUcjFyYjVvMnhYN2VC?=
 =?utf-8?B?c0o2Y2NmVnF3dkhIRmF3RVpZY05VaWhXWWgrN0E5d01kYlBFell6WGdaLzZo?=
 =?utf-8?B?VFlDZHBxOS9hTFJDcE4zUlFzNnVub1JZK21DWnl0Vk1ackMzNlR5c01yN0Zl?=
 =?utf-8?B?M3lockordXFPTmVHQnFCM201TkNURzlHL2JQQWoyOHZxZkI4M2I4N2NVaHJ2?=
 =?utf-8?B?WmFyRklNb29YU1lxdHZyV1l3aHM3K0drRTcrRUJqeE9NcW9tcWJ2djJubnI3?=
 =?utf-8?B?N2V4Z1JBQWY5NzN0d3JkeFY4V29Rc3hWdjFZSGE0enhkMDJEc0Jyci9LZ2RF?=
 =?utf-8?B?NWNnRXlZVXJsWWV6WTNSYzZIVGg0Qk9mQldPTTZKNnM3SHdtSk4xTWZEZk9Q?=
 =?utf-8?B?Z3pNRmxBTUlwL3VCSngyQnAwR09rRnN3Z1U0Y0J6bDhDd1JBdFk4bGNSM1Vn?=
 =?utf-8?B?OUlMWWEvUjc0UUJpSmVacGk3S1I3blVRQ3lIUHF3VnNUUjZHeWdsSHFkZStV?=
 =?utf-8?B?MlBmN0YzalNWOWJzSHp5UFFwOS9NWWNUWldtRTBoSDdHcUJybXJPTFRNbWE0?=
 =?utf-8?B?cmgyMFBVYW9MdjhJek9ndWxlTXlQLy93WWR2bW5DeXcyRVFUU3VKSHdER1FX?=
 =?utf-8?B?Y0haWDlTb2RsZ0NkSW1UYm5KNTRVdjlWY0swb1oxOU9VQlFsTkk2dHhxZlAy?=
 =?utf-8?B?eWo0eWtCR0NUaFM5Qm1hQ3hwemdmbEpaODluT1BvN3UzOExYNGMrSnA1d2hk?=
 =?utf-8?B?OWpYaFhvSHNkS0dTbWNHaGwyOGR2eC9BeXErSndmZ2ZVK2NmYXNtQS9OMFBs?=
 =?utf-8?B?TTR6cnUwaXJMNHdwcFh3TmxmYmx5RzRWeHBZTnhNUXdMSnNteTAyenJyZTJp?=
 =?utf-8?B?dkp0bzgySmpJTnUvUWJmZEJDbG1LTnNCUmtNdTd6elk5L3BuQ3JoRDRXTzh5?=
 =?utf-8?B?UnFZKzVZa29Seng1dTMyelBYUVVsNnBhUVdoVTB4UlhOeVdJZzluMjR2L2lH?=
 =?utf-8?B?Uk90eTBxeUlqOERHekNnRWdZdy9FeEgxbGF4K0xhbW5GQ2FLemdIWXJ6OFJq?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A005B84615BB1545A49A0280494441BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820f476b-0f26-4b20-91ce-08da8f2bc53a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 10:45:38.1505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5L9vPEHkmWovcjiHqDTBAGO4nGkchvAKsZTNhQI9uKuVmEePNw6mFpFovInC+/gIgBk9jV9XYmbwj6vmChc7DNuqyRl/G9ilLzPYsfNnWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4052
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDE1OjE5ICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgQXVn
IDMwLCAyMDIyIGF0IDY6NTEgQU0gPExld2lzLkhhbmx5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0K
PiANCj4gPiBXZSBoYWQgbG9va2VkIGF0IHRoZSBicGdwaW9faW5pdCwgb3VyIGNvbnRyb2xsZXIg
aXMgbm90IGZ1bGx5DQo+ID4gbWVtb3J5DQo+ID4gbWFwcGVkIHRvIHN1cHBvcnQgdGhlIGJncGlv
X2luaXQoKSBhbmQgZ2V0IGFsbCByb3V0aW5lcyBmb3IgZnJlZS4NCj4gPiBXaGlsZSB3ZSBoYXZl
IGluL291dCBhbmQgaW50ciAoaW50ZXJydXB0IHN0YXRlKSAzMi1iaXQgcmVnaXN0ZXJzLA0KPiA+
IHdlDQo+ID4gd291bGQgbm90IGdldCBhcyBtdWNoIGZyZWUgYXMgb3RoZXIgZ2VuZXJpYyBtZW1v
cnkgbWFwcGVkDQo+ID4gY29udHJvbGxlcnMuDQo+IA0KPiBZb3UncmUgbm90IHJlYWxseSBzYXlp
bmcgd2hhdCB0aGUgcHJvYmxlbSBpcz8NCj4gDQo+IElzIGl0IHRoYXQgc29tZSByZWdpc3RlcnMg
YXJlIG5vdCBvbmUtYml0LWluZGV4ZWQgZnJvbSAwIHBlciBHUElPPw0KWWVzIHNvbWUgb2YgdGhl
IHJlZ2lzdGVycyBhcmUgbm90IG9uZS1iaXQtaW5kZXhlZCBwZXIgR1BJTyBhbmQgZm9yIHRoaXMN
CnJlYXNvbiB3ZSBoYWQgbm90IGltcGxlbWVudGVkIGJncGlvX2luaXQoKS4NCj4gDQo+IFlvdXJz
LA0KPiBMaW51cyBXYWxsZWlqDQo=
