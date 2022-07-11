Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAE56D7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGKITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiGKITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:19:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C919A1D0E5;
        Mon, 11 Jul 2022 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657527557; x=1689063557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vDCPwm3VpBbAUsMv+dTIyfT8YrFE+Fz45+7kFMloeD4=;
  b=zuoPWiYtpe7a+25ZOTFUdkx/IL9WNhK/uJGH4abudAKEbZkwTpaEKOsb
   1xIDhTUX06VZa6+PXI9z10xZCaIpM/cWnB4t5OaIn3pjO3rmtk6H5loXF
   XR853vh3EpaFFkPuhhQhVcUYneXIV5Bn2fV3Smu4Rlwb4yXr6s5sDubH1
   6Z6b7NE8Pw/ksA/E95458xnxWKenM9fmxNKGF8PmluqGP7pWUNe51OIVV
   +d0ve6z1XLjvJVBEWVfsnMRK+Ywzy3hyKmg2y130Y1zbEWFPdz8sEfcC/
   o0fVCTAvaOGHHxVRlod1c3ceuCa391cb+eFhNrnT7J7zwMnhCSYXpFkzC
   w==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="181576137"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 01:19:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 01:19:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 01:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIdiALSvbsinzaDNS+KCbGepEdvcZj9wFmRq/AGz0qloyNJwCDtIXmFUVcYWpBp/PsDASrxSlDZiiKlj2/oQyMHmKdX29ma5Wh8V9hcXcEKfbv3HqBhJYBIyzriyfMEtY67vItpSA/SCYktTJuTYOdrdvN0ar+Sn0LfBxA3YK2SstVHs3lw8eNhLUE4bCedsaLPSa98mMZoezxoff6rgqjbb3LPExKF1Y4ZE9q9D8mSp0fOIMjYiH1hy5qL2JEOujflpQkO0a0A2Z+iIMFL0vHXbHoaCWSCBrCJ5o18nlbkJUR4hhJNrhMf2Btv2363mdj+nvL4JVlMFhFNrGxP7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDCPwm3VpBbAUsMv+dTIyfT8YrFE+Fz45+7kFMloeD4=;
 b=SjGXvs9NAK+iQL9o7Ie7pcPSOSLmwz9SXYSIMrCoUofIB3CNfcn5cNFtBUw/kbVOSGJChWViFg9Fp5BHziQ4zMvR5rE1qysy6raLJUGpvCScHtM//72BhveWZvg2MbrQx1Lbgh/B419GdOPMfHtGC1xNtkl3I6mINhK3qijBRbwlg+gOQ+DuH6yU2LoxOZU3GZp2a3FMguNIrQW9gDAATrRQL0JreXBMh74r3hFJgPGUdKIv5764mM38paKz6Ica75P89JBwuGgDSunUBWY2io/haYUFYO/HcsfIb4Wwei9yFCYvv5Qg0e8/KnMx8WqgR2x0OKNHDryT21k34110EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDCPwm3VpBbAUsMv+dTIyfT8YrFE+Fz45+7kFMloeD4=;
 b=CbYbYcWrb5NehwDmiE5jk5FkMccITFBRZD+uu0n8feeM4UpmGGDyaxizPWUbpcvcR5PtywVnje81MPyT7pEmuCdminURx+pIKFQPAa2WG86u7hrV9oVJh1MKbY/wrtbPg6FeuaXZGHPwUAU1cIrVkT8eBljzGPsauRKEKDp90qc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 08:19:14 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 08:19:14 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sfr@canb.auug.org.au>, <alexandre.belloni@bootlin.com>,
        <olof@lixom.net>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <Conor.Dooley@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rtc tree with the arm-soc-fixes
 tree
Thread-Topic: linux-next: manual merge of the rtc tree with the arm-soc-fixes
 tree
Thread-Index: AQHYlP5vLzYNa9Ivo0e/cMva30pjB614092A
Date:   Mon, 11 Jul 2022 08:19:14 +0000
Message-ID: <44a3b35c-5677-7107-ae5a-50bbbc815cda@microchip.com>
References: <20220711181424.70195b52@canb.auug.org.au>
In-Reply-To: <20220711181424.70195b52@canb.auug.org.au>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8023e092-c102-4b9d-5447-08da63160aa0
x-ms-traffictypediagnostic: DM4PR11MB5358:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5u0xC0jWxH2q29sTtcAnz2IHItvKPoTyFLIq4dGwZ7bXaDXij8VcSv6RHjmv+wSXLvYggPKZFHhn0lm4dARQAhj6ffLB7xjIy3PHx4DAkMLFF3BL/+Tvq8TymhhBsGpMYDauhvg/1z3j95YTxlpwYZiFP18OXk30pTqFjZuCLo3EEhTgWmzRv0STi8+kw7WxIim7W+5X4dNxnTvzOPs1qQjlO+gMvrmiqGQAmuEarWXkr3zdVCm6D6v98Uy0kKSJHyZ+DIqkRGb+iAKkStMnqIfLuQ5pDuYeYWLXqZwvvgRm/g32/xmvvta32qhFrzF42flmESsGhzG/r+3mKLM3w/wnUVeRYgsyeCrmUhkVCOeEn8BBoi/bK4eOCffJ8z6XjJOvK6wXwyCbeobXamRP9Fy7r3mQUg2t1d+qRx4pQ5ChxtgY78NWC+WQ6gah//yevlYU5tpSbvNyZVwjP3taVVdDEzjdrnl4cQST7ckKz/4i4Z9vaETZIY1+AFrmpydywDwiIFOmfYvgYV+XoZCuLL2OaIaV3BEoFtNoQh3LVIbmZChJfLMJ/y1KUvofX70WgSmnBrPy0gxQWA3slFmxSjlGI8euNu/sIU66hHMBzZKVL452dbZsEou39yM1T0ayi3g0FrdBSbLAP9ie8UWxYXvtd1GRyQyay5ZTzlKIjXeblvbfH3u7yQ5CmAmROrmwRCMTtB0N27vIgD5Fm6T0e8QDXuaxbRHEx6Q2AQNBF0zq1uGIt55i89YnKzvnEF4Z2sx/Ev9520bUeIOky+T+tP0qBLT3H/3pwY28O4odYdciJK4b1vFf6U8pR76yaVLJQwJUdie0klSCFZBmehllubqw3mD94flWVMGowGx63epnM7X170E2uw8axkHgdAu4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(366004)(376002)(136003)(4326008)(66476007)(76116006)(53546011)(66446008)(66556008)(64756008)(66946007)(91956017)(8676002)(26005)(31696002)(478600001)(6512007)(8936002)(86362001)(5660300002)(2616005)(71200400001)(41300700001)(122000001)(110136005)(54906003)(38100700002)(38070700005)(316002)(6486002)(2906002)(31686004)(36756003)(83380400001)(4744005)(6506007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWRNVDlob1RZZURRR0tmTUh1d1gyWEdVM09aSzZYQzNLNk5yMVhzTnJ1SFYy?=
 =?utf-8?B?REdwZERZbWowVFRDUEwzL1QvQ2llZ3ovL0t5ZEZIdFA4VXh0bUU2Z1VYaG53?=
 =?utf-8?B?dFMrNE9YVXhMR2lQNk40cWpVM1hRZmQ0dXU4b1hrRTc5ZjMyYU1qK1lkMFJQ?=
 =?utf-8?B?bXFaRTY1ZGoraGRZVmNVdHZYS1Q3RFN1MGdJQlpMaFZpN2RCYTEyRVpjeDFV?=
 =?utf-8?B?WldIM1ZtbEw2aEtmS3ZjTDhDY20xNnkvSHhKSXc2U3gyTXJPWlNOY0YrWHdV?=
 =?utf-8?B?WmlkTWQ2a0dTYWlRTXk5ejA0RklvbG1WOC9nMXJ2RVI2NDZOQmtTamRGeE5o?=
 =?utf-8?B?ZWMzQUIyZzFJMG5mRFo5ZnBnZmVzbkY2Y0IwNm9tWjdSZVVUSHBnazZnVTNL?=
 =?utf-8?B?bFNUMVkrRWZ5Tk01RlFVbUE1Q05hR0ozcGdSNCtTRC9IT1VicXZnQ3Z3eU5k?=
 =?utf-8?B?aXh0ZXdsajBrNFpuT21zZW5xZkw3U2hmdXNacnRuZVhKQjlMVlJCTHVIbDA5?=
 =?utf-8?B?M3YxdGNidEtZUEEyNkM5dm5JSVk1Uy8venIzNFZieWdvYU5SUHN2ZlBTU2RL?=
 =?utf-8?B?RTBNQ1BJSTFSdG1WaHBTWjVvL0R4V1IyYUZpWVJLejRmN01HSDBhWisvWVc0?=
 =?utf-8?B?bDBMWTc5QndZb2pCK01CcytCdnlMbVM0L3BJamlPL3F5cGwxWVhIclVPa21h?=
 =?utf-8?B?ZGJLandHZVZBOG9OU3YzWmZSR0JueU8zbS9WZ0h5VEtVeTVIQjNiWFFkSVVz?=
 =?utf-8?B?c3FRU294dGxWQVBLWTJzYTR6Y0lGQjlDdnRERFhJQktiam96WFZjM0wvZVZV?=
 =?utf-8?B?dEpkMndhanhETXFxTmJmMURTclR3aHVMak11dWJZem93elB4OWNPOUEwOTNZ?=
 =?utf-8?B?OVNZandMUG8vaEg3MHBUUVNmZjZyZmJ1c1JoZU01UThBc1FWUGtzT2xlNG04?=
 =?utf-8?B?YkE4ODhTOU8ybk41VitURXR3MFl6cCs2TE9iZXpQUzdRbmNjd0pVMW1MSmRS?=
 =?utf-8?B?K3A2SFErMlVQYmQwQ01YWER2ZFVxNHQ3OWdRNThMS3hZUU1WR2Z5MUxLcHor?=
 =?utf-8?B?NkxMbDlwcW5aWFdZQ1Ayc2MyaXYycXQrd09GdFM2aGVjWEhGOGxsSUh6TENz?=
 =?utf-8?B?MWp0SCt2aEFwckdQS04veW1zVnB4OFphT1AvLzAySEQzNFJuWmpPUGwxdnRF?=
 =?utf-8?B?aUcxL3VSaFNsYnBUZzVOKzVGa2xzaHVncExPQy9GS3l0TEVuYmZza2VhNHN3?=
 =?utf-8?B?SlJHRDFVZHFMR1N3SktMcWZhQ2k5ODJTNXc3cFE0cTlGZVlOQ0Y4V080S3By?=
 =?utf-8?B?VytWMjNaeXlNaWx0OHJNQUE5N3JOY3ZscHNZOU9PYWF4ZmV3bElZZzQzQzRv?=
 =?utf-8?B?M0gzenRqTlMrUHh5dEt1aFZXODZiZG1QaXdjMnF5cmc4Z2JTRGhEeUp3OUFZ?=
 =?utf-8?B?TkZhLzYzb0I3YllEWU9mbnR4VWdWNThvek5UT0h0YXlMUjN0dWNDSHE2RWc0?=
 =?utf-8?B?OS9qa2Z1Tmw3czdWRFZDeXpCVDVGUDZ1dHNsZFVoZjR3SE1kcGxXVVg5Mlg1?=
 =?utf-8?B?ekNrOG9CRElnSm5oaWFZNXFqVFNMMnUvaWtMWS94Z3ZkRC9NYSt0WnVQeDJu?=
 =?utf-8?B?dzhBb3E1eFNVZ3dOQWRUQndRRkt3U3pRQ1VzUEEzMGRXVEhmNWlMWnkwNHla?=
 =?utf-8?B?NkRGMEE5djhhS0JZRzBPenhQS2ozZVdMSjJsMWViUFQrdTB3cUN0cmgrek52?=
 =?utf-8?B?ejlwWmdPNWdQeisyRnRzTGhGYTgva00zLzBYVUpUeFJuLytnRndZL1NYUlNR?=
 =?utf-8?B?MVFOdVJ4Z28yZFVmMnNYTFhEK0RJVUplVVJzbGl3aVYzMkR2aXo0c2RHRFda?=
 =?utf-8?B?b0liK2F5UnJHSHJaQlBKL3FreHFjRWZ0eUtEaStGanE5engwZmorMVBpeEFr?=
 =?utf-8?B?OUJ3aVhJbWZRUnZsSEZMV0phV05XaXNRZkd6amN1bG5qWmJCY00ya1dKUXcr?=
 =?utf-8?B?WlhuU0hJbnhRVGJjVlM0ekpKTFNQU0ppMDM3TkhaRm1mUzNRdERCZWhFVzB5?=
 =?utf-8?B?bUxNR3daNlduKzlRS0ExRnBCa2VjYlA1R1VFbFJDN20xRHhTa2ZCeFlHMzl1?=
 =?utf-8?Q?i4SpQiF6gsYESy89LMGaOi+2A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C866254F3C9D0419BC13E2241E0897D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8023e092-c102-4b9d-5447-08da63160aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 08:19:14.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfGvZ4RnHrANdmNqQSSlMf5rzUINvpf5UqGgDDptcfy7GVvwvnEnSMWQivAf+EI4cVXA5/De8/x4rz5SxDYKUV46gEY3UG/gyhnqppYkga8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5358
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDcvMjAyMiAwOToxNCwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToNCj4gSGkgYWxsLA0K
PiANCj4gVG9kYXkncyBsaW51eC1uZXh0IG1lcmdlIG9mIHRoZSBydGMgdHJlZSBnb3QgYSBjb25m
bGljdCBpbjoNCj4gDQo+ICAgIE1BSU5UQUlORVJTDQo+IA0KPiBiZXR3ZWVuIGNvbW1pdDoNCj4g
DQo+ICAgIDIwNThkYzgzMWZmOCAoIk1BSU5UQUlORVJTOiBhZGQgcG9sYXJmaXJlIHJuZywgcGNp
IGFuZCBjbG9jayBkcml2ZXJzIikNCj4gDQo+IGZyb20gdGhlIGFybS1zb2MtZml4ZXMgdHJlZSBh
bmQgY29tbWl0Og0KPiANCj4gICAgMWJkYjA4YzE4MGU4ICgiTUFJTlRBSU5FUlM6IGFkZCBQb2xh
ckZpcmUgU29DJ3MgUlRDIikNCj4gDQo+IGZyb20gdGhlIHJ0YyB0cmVlLg0KPiANCj4gSSBmaXhl
ZCBpdCB1cCAoc2VlIGJlbG93KSBhbmQgY2FuIGNhcnJ5IHRoZSBmaXggYXMgbmVjZXNzYXJ5LiBU
aGlzDQo+IGlzIG5vdyBmaXhlZCBhcyBmYXIgYXMgbGludXgtbmV4dCBpcyBjb25jZXJuZWQsIGJ1
dCBhbnkgbm9uIHRyaXZpYWwNCj4gY29uZmxpY3RzIHNob3VsZCBiZSBtZW50aW9uZWQgdG8geW91
ciB1cHN0cmVhbSBtYWludGFpbmVyIHdoZW4geW91ciB0cmVlDQo+IGlzIHN1Ym1pdHRlZCBmb3Ig
bWVyZ2luZy4gIFlvdSBtYXkgYWxzbyB3YW50IHRvIGNvbnNpZGVyIGNvb3BlcmF0aW5nDQo+IHdp
dGggdGhlIG1haW50YWluZXIgb2YgdGhlIGNvbmZsaWN0aW5nIHRyZWUgdG8gbWluaW1pc2UgYW55
IHBhcnRpY3VsYXJseQ0KPiBjb21wbGV4IGNvbmZsaWN0cy4NCg0KTEdUTSBTdGVwaGVuLCB0aGFu
a3MuDQo=
