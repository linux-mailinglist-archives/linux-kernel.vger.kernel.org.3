Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD755EA70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiF1Q7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiF1Q5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:57:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541123164;
        Tue, 28 Jun 2022 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656435455; x=1687971455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bvJ7Y3ow4Gx9lb++xzLk20mgecQHGkhA3xriHrzx5KY=;
  b=Qrh2Sz1iTOJ7w5Y7NqibEPnUvgsd1goTd1yOO7XMMtnW4oTfK2dxIl+3
   npEIWMnkaxol38TELBMnVrKVtp3TF1Gw4kL1S4NU97m0x7PgQjFSgOROY
   92fBIz8Q96MqA/mg1p9xS9LsJDrjSO5d7FhX9CrgsJ7peEU62WsGnZt+o
   f9duDHk14sxVGh5E/+FeIUlXDVQfRXjE4Bl03UsmmjhfEWqTEuEJGjsr1
   V2xm96+YpYbLfrqshS6ywMC9kvop5eN9P4KWJ0S/FH+e1fvGSdWsV4EX3
   nXsYp1dxAaxJqjj5yksnc78JcLUCKvjvb9mShlrTB6NyOJhoWuDqoXbUX
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="102134850"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 09:57:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 09:57:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 09:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is97fOubAObhiWUCD/VbYHrzOrhjEkN7DtQ8aXrRo9x8mybI4VYk0yDzg+LUDOoXAYwNTSIbZySrXPXGDFiqKtQmjTOd6I9yKRmR9Og+OwbdHHCivhhivw98dXGjA6inUs0qnb2ld5Pyosxxntc/YSe4Q7/jiJZduaChWCQFCTMYZTjxDL0sbekzIqzPmCmSTKty5iY8dM/m1It+Ilyf8nHb68zugdOd93kQmm/HnjmsnQabEjr4e10aDV3RR2M1h+4YI0dFweqzlsiwLXVI/bKmvhn3elLGU1zUZgA6y1zjndcX9cVj53HBxnoKPY9RQkD2wIXG1dM/DC8Qf1dRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvJ7Y3ow4Gx9lb++xzLk20mgecQHGkhA3xriHrzx5KY=;
 b=k7/L+N+YSbBf2iGIT4zfobRmup632GO/h3/7Fm1sSTwVPtREk2T6R4k/1T2JQLZRIWHyK/v80Om0d0Dw2IyNlGbrUvMdmlUw5b8UvSUbXCD49Ajpm9iw4bTglDbxeY/bHwtqcMFFw7nrDLM/4WXBRnDwJCIxq+L2k+tXPkTrFsnXRcY+gKhjbabAfTsom7p9qbpTJB7QYE0xHi4Od8CaOhsPSrxJg1LLSXzK3zS64CHRjgh/sA6KCk2CBUdFe8qQzIyQsHNv1xpkhIstTusst04Km9XRRyekCaIOkGJIZPCF+jM61zBMLyHUdSCs5ywHN3SoOa1bOQGQDp641S9csg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvJ7Y3ow4Gx9lb++xzLk20mgecQHGkhA3xriHrzx5KY=;
 b=CRYHpd4ZLlo/ZL7wVMSFqpmOWnCJekGIDBnDeMIHx3rQLjjhnKWjiDQ6wVYZRBwgNfj0HXQwD59nkZumnqdSQwbmFGm9gXUsTkWAx4fdAjEJ1qc2vgX7r+bAq0AJpi/cvSMqUfc00sQVdOU5DdT63RPUEliS3ggQAXlM6riWXT8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by IA1PR11MB6121.namprd11.prod.outlook.com (2603:10b6:208:3ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 16:57:31 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Tue, 28 Jun 2022
 16:57:31 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yangyingliang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <Conor.Dooley@microchip.com>,
        <Valentina.FernandezAlanis@microchip.com>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] usb: musb: mpfs: add missing
 clk_disable_unprepare() in mpfs_remove()
Thread-Topic: [PATCH -next] usb: musb: mpfs: add missing
 clk_disable_unprepare() in mpfs_remove()
Thread-Index: AQHYixAn7IoWZCCLEEO6e03VaGwuDg==
Date:   Tue, 28 Jun 2022 16:57:30 +0000
Message-ID: <1bdbd6a6-2bd1-cd03-b710-ced9f44cbaff@microchip.com>
References: <20220628140527.1404439-1-yangyingliang@huawei.com>
In-Reply-To: <20220628140527.1404439-1-yangyingliang@huawei.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a64d64bd-ccd4-44b2-e98e-08da59274a3d
x-ms-traffictypediagnostic: IA1PR11MB6121:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0j3mMof0tOKGShQsRFpbnhSzpJTru4r4cjx/WTSlcR8Wgyh606aq+FxXDuZZKcwKuq1LGs3792nrr7UAuhUg1B8zVE7qS6DEogS10oNZc+HHJ5cYX38EROl/X+b55wWES8ZhyOQ67Dsj0O7k0shcUhPTyblB6aqH+YT7G4X86/rBflPsjiUOW8qv0u28PtO+H8F7AHBZ26eWswQsFtlcjFphg3mz1Z7sf7g7fsnhfmt0r7rzmsKAivU69l+QgsfA6PJNqBZloH0k+1htly2YxkpoSjrfDyNPPTYHNSgxzpwfoI/vLlxquXAUBB4q4CqviUG8fO1/jobYgrMzommP1R3PANYwgp4Nb0urZJ11C+NUpR7NmixPMLG48j41uRNM52oTTWNsqji0Q/pmjYCNT5i5xKdLqbtCvbPZqdVMUjyGkVqFknzIN51xCtZqm6N1F4YkbU2Ui7u0kNNZMt+72fRfXKMhE8QnTl0lZHFE6kakNKLSaJZMqujNHdUx5H+9ggwXdDf+lGhqFTb5ODgZfvUXm3U9I52SiJJYKMmX7SS86qyo1uVHS9vAd83uPkuoOOTQ3zS+riDSZwO7qRcDDP42sznr4kpLHYHjOcnbVP9lS0TY3fYtU+pvELUWabuyl7FsmnBFX+FmFCqUfxr3U+OplxGxw1nGD5Yq/KfzTfMniG2WHV/j7yTeVzdZHMXGYEHSpwgjRUb+P7Bmqd9mTV1YY9oPDbPepfPKH2cPwNcIcdBXn0fMFOqTwM5Qv4QR6R4CXav/GeJHMMlgeq9ePtScFH7+QMWIMaBne505ZFmhkyzHf9Z8HWAQazLAXvmKdYkq9yL/QGD+KUGfZ6aP/HPc1nHEPpK4lJKbLh7KV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(39860400002)(346002)(2906002)(54906003)(86362001)(6506007)(31686004)(478600001)(6486002)(76116006)(4744005)(2616005)(6512007)(66556008)(91956017)(71200400001)(36756003)(5660300002)(66476007)(66946007)(110136005)(8676002)(4326008)(8936002)(53546011)(26005)(31696002)(186003)(316002)(122000001)(38070700005)(41300700001)(83380400001)(64756008)(38100700002)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhRSkdNNFJaMFIyTS9mTXpKVENSSE5ZUjVCaWpDVGlvRlgyVXRRL0xXZXVk?=
 =?utf-8?B?QmRYQm50WndMN3h0QjBjWEhXT1Rzc0JRTG43dno5NTZMN25ZSU1ORzN5ck1r?=
 =?utf-8?B?ZTlKUzBaZW5FcVpEK053VUFMeDd0VHJUSGVCVkpIYkU5NkEyZWZSdHNsYnBU?=
 =?utf-8?B?OUx6YzdDNjltWGYwTFQ0Wnl5aHJqUXZVNVgydHBCc2x5SjdEQnovak1RYWJt?=
 =?utf-8?B?bS9HVUJPYWlsUllCbDMvbDYzbmQ3VjJJdENTTi80dW96dkk2YkluZmJncHlN?=
 =?utf-8?B?TjhtT3l5dmo1RklVaGJjRm5Pc0RZRXlmQjlMM3NPVFhQcFZGZFNlR0NmTWJo?=
 =?utf-8?B?ci9mam9ibVBmQ1JlZTUzbEFlaEpYcVNRb3QwWHFWdkw1WGRiRDA5N2FjT0cv?=
 =?utf-8?B?SnNzWTVJa0dGdnJsRS95WElmWmgzcmlIYjFZMkU4UlZNR2dwVTVpZ2orTExV?=
 =?utf-8?B?MS9xTE1FWGx0ZnpsSzBPS1dTV2tLV00vVVdlUG5nMUJGdTUxakhHU0lUTUVY?=
 =?utf-8?B?ZE5VcDZJdVRKOVJ1NnQyM3JLeEREMWFMeVBIc3RMc0xpb2pCUEpQZEhGeE9r?=
 =?utf-8?B?YXE1VGZYZVUxZ2IwV281TEJsdzdDOXJ5akl4NXc2ZzBBSURUNkF4S2FwdmpK?=
 =?utf-8?B?ajdQekZ6N2IxcENBR0kzQkxPNVdJRVR4RjhRY2VQbHErNlpyelg4dTdMKysv?=
 =?utf-8?B?R1RJZW5GdWxHb1pnaU9rTXlVZVZTV2dRZHR5d25UVytOTUhPaE13NTZCbVM5?=
 =?utf-8?B?d0hGbUJZKzFvUnF0dHlLbVdjV1JtZmE0RHpDOEF0cklPM2xLM3FWYzM3Z1Z4?=
 =?utf-8?B?R0VqN24zK1Z4UEQ1Wm5tUWVZYTE0dTRTUHkxVnhOQnV0MTVSejIyVmxNQTVK?=
 =?utf-8?B?cnYzSlZIenE4SVlkRkI4dW85YUNreDdIVm1lUTRUcXpkbFJhTlFOWW9hOHhR?=
 =?utf-8?B?aEoyQ3pxUXdQRkIrcUE2RVJXbFZQcWJqS0JuVk5Hc0ViWTNxa3RFZmkvNnBT?=
 =?utf-8?B?YXBBekNRZ2QrNEl3UGNZQmJFaGpFK1BDakloTVRlTXVqMXV1OXBhSncxbEFW?=
 =?utf-8?B?YzVYbTRyV3lGK3FsbzhubkQ4bzR2K242RVlWMVBWZ0JpQVZLZnRJckNGbEJl?=
 =?utf-8?B?b0pLT2x5ek9SNlJ1Y013c1dSNGdMRVg2Z1NaallwUjNIMlJHcWwvVkl3WHg2?=
 =?utf-8?B?MyszSmEzWDZRY2xQVUFZS3dqK0I3UUlML252ZVIwOG1mQloxSE5zaHYxRkpT?=
 =?utf-8?B?bHFmZCtrVzd0cDVIQllaTllEUWs5Q01jcG9yRDhZSCtFaHBLdDl2QVFqS0s0?=
 =?utf-8?B?RE1MU1dhcHAwK1M2Z3lDQ0Nud1BsWEgxVERIK2R5Zld3VjM3dWtFQzFyUWtn?=
 =?utf-8?B?WG9mTWdYTWQzdkNmMmRpRFJVUVNrUlNqS2JWa1pGMWQ4WFBOZko1a1Q2Nysv?=
 =?utf-8?B?bWRQOTcvZFA3cFBLTE4xbUx1M0hqMi9oVkhBeHZLcE1qMmRIUGdoMFhGZTND?=
 =?utf-8?B?TVpYb0liSGhkRUVNYW1tNzBwQ2ZzZTRERXhHNW1SNHRYSSt2ZCtCblR0R283?=
 =?utf-8?B?bXpoYzJ2ajNTZ21LVWtjWlJMdmVhdmdnL25Pem1rcm5IeXpTMXV4SFI3OFVy?=
 =?utf-8?B?Qy9nYWlhNDhpY2lTNVlzRXdNUGpTWXBpa1VoY2VkZnpzYUFHcHBtUVN5WkNq?=
 =?utf-8?B?NUNvZFdzdmk4U3BibThTVkdIQ3cycGJyTklOOWJzK1RPSG83a2lha2ZOU0pt?=
 =?utf-8?B?MVVkUExOS09Sa1NlT0lUd1RFaWd4SC85a1Y3TlgrUHhHcjdOL1ZSYm55aUxq?=
 =?utf-8?B?dksxVndTWTB2Nm1lbWVPekppdGh3MkNEOHBqcUZxV2dGdmZ4QWhhT1NoaFVP?=
 =?utf-8?B?cElDWG9wdGYzczFaNUY1QlU0Y25NRUpzb0lSYjBLOXUvdDRTY1FDWWxYa0Za?=
 =?utf-8?B?MVJnMW9xUEM3a3YvOG5LSmlQWGNQV0RiUGZ5MjgzajY0OU9BM05Dbnljb3Nr?=
 =?utf-8?B?a2dFd0pCNksveVdOeFBFa3pXOXM4bjJzTkFPNTViSDNLVFNsalYrVWYycnd6?=
 =?utf-8?B?WmVNaXdJTnZKS0RTZy94T3g2YnZtNVRBeXY0V3BKQ3JKczNMOVlPSmpFM2p0?=
 =?utf-8?B?NDhDWW0xK2tKQmg1ZEV2S3A0ZDNtZVloT21CSmxqKzArY1dQTjZ2d3hQVkdR?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <106A3A444A00624D8C0C467A0194C418@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64d64bd-ccd4-44b2-e98e-08da59274a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 16:57:31.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5Qom+PrE3MQafmbcJSx5hhuvVdv9DDmCgsESxnxf95g/XpecUv0lu0nCoPqoDbo3/0HUjb253IFygLg85tUXbwam3dqRsYBMCJPVRWDWQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6121
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LzA2LzIwMjIgMTU6MDUsIFlhbmcgWWluZ2xpYW5nIHdyb3RlOg0KPiBjbG9jayBz
b3VyY2UgaXMgcHJlcGFyZWQgYW5kIGVuYWJsZWQgYnkgY2xrX3ByZXBhcmVfZW5hYmxlKCkNCj4g
aW4gcHJvYmUgZnVuY3Rpb24sIGJ1dCBubyBkaXNhYmxlIG9yIHVucHJlcGFyZSBpbiByZW1vdmUu
DQo+IA0KPiBGaXhlczogN2E5NmI2ZWE5MGE0ICgidXNiOiBtdXNiOiBBZGQgc3VwcG9ydCBmb3Ig
UG9sYXJGaXJlIFNvQydzIG11c2IgY29udHJvbGxlciIpDQo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJv
Ym90IDxodWxrY2lAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBZaW5nbGlhbmcg
PHlhbmd5aW5nbGlhbmdAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9tdXNiL21w
ZnMuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvbXVzYi9tcGZzLmMgYi9kcml2ZXJzL3VzYi9tdXNiL21wZnMu
Yw0KPiBpbmRleCBhNjljYTMzOGVhY2UuLmNlYTJlODEwODg2NyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvbXVzYi9tcGZzLmMNCj4gKysrIGIvZHJpdmVycy91c2IvbXVzYi9tcGZzLmMNCj4g
QEAgLTIzOSw2ICsyMzksNyBAQCBzdGF0aWMgaW50IG1wZnNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG1wZnNfZ2x1ZSAqZ2x1ZSA9IHBsYXRm
b3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiAgDQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGds
dWUtPmNsayk7DQo+ICAJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoZ2x1ZS0+bXVzYik7DQo+
ICAJdXNiX3BoeV9nZW5lcmljX3VucmVnaXN0ZXIocGRldik7DQo+ICANCg0KSSdsbCBmaWxlIHRo
aXMgb25lIHVuZGVyICJvYnZpb3VzbHkgY29ycmVjdCIuDQpSZXZpZXdlZC1ieTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NClRoYW5rcyENCg==
