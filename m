Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690DB57635C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiGOOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiGOOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:05:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2143DD8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657893907; x=1689429907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VgZl5Y7cUr+dVBQGs0Sko18IYj6xZMhWYA8TWgn2Tlw=;
  b=qW7TkZoRe37n6wFxWXKyvMrxExA+W0trgi0VLnBPmNACf64Wjfy40Gxw
   NqxiNqUrtPYcWYBhV074eomP5d1bhAxpbKEfjPRi6tOKiQe5gh0Gy+Xql
   ukon7pVAIJgenr6HSbhr2VrkriNWNeYttLUTfUNl/KjLcjm+2/RdtOnlm
   ZUfPF7WhvV1rGZpKICDx8d5bZDPIlA5TNNiSvZ7NQIJcQ2lnYw5kE3l/X
   YqiPVChHIZb9SrXmYVqz7vpJBDKkWtcS9iI2yghcHpTdUwQMpHddnB6Ic
   CPRJyUr4r5ZQY+yTr8SU2RWgbVxB1KWWGVtVZRiWyJ/YwWsdqCWbq3Nkl
   A==;
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="104643837"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 07:04:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 07:04:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 07:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjHQUJqshShWyfdxUEqOrRJlaBoU1qi5sVQm1H29UabA/CZeOWh85EF2AuKTAkpjkVqm1SYPWAXugjpJpfMXHV3E27Ffwp5GyfOYSneHMMjRMtXOUkWhlBzp0gHpw+F7Ssn/FoGoQiZdU0Fy9/idpKXbNNOooH1zSfH+ym/tZxspJSboJTRtZIAqoE5ImdZc/ndQD5HwTYfAEi27Wpw8i+6qww3lzrCMWuhXns7R81ElZkQAQSVEDvN4ppAHgf5GPIbGMm2hqVRCcpt5/KWR5BDlrXbcuymWM/a0HEj2wlwREGoXHQoDL0ApuhgemsT7o0oZlvNjAUzdkGXKERsDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgZl5Y7cUr+dVBQGs0Sko18IYj6xZMhWYA8TWgn2Tlw=;
 b=J9F4u8OXzbjmCOF1Y28T7XS8moR5rojg0J5rV+K/kTLZ6FtXsb/UhBrsOSd9Ow/wWKaqs/A1ZZTZ8GHlif8mjCbvHOklMWO1A8t6wGFABLRz9bJsOPoHSggP4YC5ktnATmZF11Slfy5mVSwF8mVrUDu0WX3WXYzlEK7r3L03t0+ascwGarqewDrhFE7SEXvLyxnCU4T0mRL6Vr0YMTfeZOGct0GjjJ228lz6Aw+kmBxkmPPuY6X7GHILnzBbaZJBiFO5L8mIahy05RyfWgd/6F3v9OH74AQpRybzsreQ1+RAv1DC/0YUVWSysSnnPhqHoRYMtPbyV9PX0QqhkyGMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgZl5Y7cUr+dVBQGs0Sko18IYj6xZMhWYA8TWgn2Tlw=;
 b=ENsO2NSoBusEdAHi98mytzKaBWWyaefnQXPJzSdJw41Y6nXhOsnUX7nuVbQLKl6lAE/+cdWA5XcHFdrmdzsl+XoUxDwWyW6p8m3hOKnZ6wK4tUv3ni2S21xn9NkB+QEOEEtwKOHaVOH8kOrBj4UE5p0j+ru+wMC2O0rmZWzBQY0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 14:04:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 14:04:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Topic: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Index: AQHYlr1LjktvAhTwm0O5ibr9nGIi2q19638AgAAMFQCAAAdOgIAACUEAgAAC4oCAAR0zgIAAAWOAgABQoQA=
Date:   Fri, 15 Jul 2022 14:04:41 +0000
Message-ID: <343b8031-f2d7-0d53-6967-d2e5925703cf@microchip.com>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <0abd0acf-70a1-d546-a517-19efe60042d1@microchip.com>
 <20220714150100.aqvmdgjkymc2dr5t@bogus>
 <f9b13298-5a0b-34ee-44b9-90168205cc59@microchip.com>
 <20220714160016.honjpzg35ccq4fto@bogus>
 <50b3316b-aed0-2ef1-a7ff-69aa3991d7e4@microchip.com>
 <20220715091121.mvwsopbh52c3zztc@bogus>
 <8146f6e0-0682-4876-95d0-01e99141330d@microchip.com>
In-Reply-To: <8146f6e0-0682-4876-95d0-01e99141330d@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e1a0ab6-3be1-4fc1-58ed-08da666af65a
x-ms-traffictypediagnostic: SJ1PR11MB6275:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xG180yTi9BhBuHR+HY2Zk/7AaJAJHpVCXNLHHr9x+Ooh4e3JJfS1kWfn624kU+sKIIfay/uoFt2HuO16+WO3I+/E3vJHYPxvxCLwRxU8aT037JsKxLMXmEXuiQuopmeGxzfyopmlTOFmVv04ZyU7Y/NG6ttamgGDcvzAMnZXPi2GGDRe/kRbwphU0F0WA/PPdqiogNZ0TMhPphlKSboi8DCugO3R4OMSFJYWnL2OBzJIIDsWmAbmQlVmb19Ms4GNt3Nj0VKy40SPMl/gC+VIDism4N5vviOGU3Du8I+K79UFZjr3iaeuUuYGAcrhEzeSpOckyY2uz4Y/r9Zf1j6mNK3cutl4PwxGtmbiVMfDQYI6rcyon7SW8hTjb/vhOTTctZqAcXplKdGxpAHYqGancvoS1zCRB99t1gwQ8vqV0RzR+2/CtMSEZTRKjWWTsB05n5NZmLXH8rQZJjsShMjsK/2EH4l7hnnCtRLO78Dl9jbxNrY/BZMOphfkdZ5oqFPm8fgoPx0hkI4BINkqjejEi+F67PqVqGE4xmBVqXBTCiQ4g8NL7m2r18wfBVwWPONpvU4cZ7UNRnGodYsHF2Ru5CKAI3C42yu516HwNILxwSZbap5yao8cWACnoRDHPluxJeRz2t+yb+2++T2ZerX55b94GCjTFvJz4PaUTHuGLvdI5jUvSqbnqUyG0Pg3dhijNHNbb2BZF26hf8Z3xWa42Hukty5hvjwtHVfY/rusgmt3u+orFxkc8tnxu6HESulGqpUgJ3pOAhvX/FxxJuRDlU1tgvjPuQ0F8n+guDF2QoRDO4WJC0L6sIQdMujCBg1pMjUZUzvR9YWppIOkuTOeT60SYPq8mLrKGuXKNazV4KcoO+bJz+TlHCydFX9ZFSGf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(376002)(396003)(26005)(2616005)(6512007)(6486002)(71200400001)(8676002)(41300700001)(2906002)(31696002)(86362001)(66476007)(122000001)(5660300002)(53546011)(6506007)(478600001)(54906003)(4744005)(6916009)(38070700005)(316002)(4326008)(91956017)(66946007)(31686004)(8936002)(36756003)(83380400001)(38100700002)(76116006)(66446008)(66556008)(186003)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anhFYTluclJPMWU0WlE0N0c1d04rd01OWElKc2pqTktPV3dqMSt1YkJ1VVNo?=
 =?utf-8?B?L21Kd3ZBMnR6Q1ZFemd4cm9FSDEybDFWNlVCWVJ5ODU2c2txTExpSmsyd0JB?=
 =?utf-8?B?cnJCSlpLNS9OUGdVc2JMMGRtcXpnTHk4UWVGQ3phTTBTQlRDSXVYTmxnMWpP?=
 =?utf-8?B?SmQrRlh6ZjRLSisyMkdOSkxTMFlHcjFmVVNOQ2gvU3UweG1ldDZxRGIyc2U1?=
 =?utf-8?B?a3l4VnNRNTMwemhEUTBwZ0J2by9xcFNKWWFCdTl1Qy91cU1DckVyU0dRRXl0?=
 =?utf-8?B?eFJsTHhCNTRHQ0t3ZmtJdEVELzlxTjJBYXZScVQ1WlR0ZTBDcDhmNUw5SnF5?=
 =?utf-8?B?T2syYzFPRnBNdFpOSTF1dkpVd3VnSU1RUzFIYVIrQlhKdHp3d1RjcEVRNVBO?=
 =?utf-8?B?aWI1TldOV3JFdEV5Y2dRbFVHV2NINmUyN3ppaXRndk1ERDhzR0tmVDFaSVZ3?=
 =?utf-8?B?WVM3ZC9ZTW5EdUxQYkVWd09CNlhVT2RmdzBoekRxYVVRamNsYVVLZ0JUOUZx?=
 =?utf-8?B?dDB5blE3NGt3V2tNOE01RVQ0R2VsRnQyL3pweVhvZWdjR2plNUtyWENGKzNL?=
 =?utf-8?B?OWNXRHZDQXg3SlRQRE1xSXZ0VG13QlZFVHFrV2JGcmZLa1kyYXhZN1ZHcWph?=
 =?utf-8?B?YXY1VHRabXpoSlJLbExseTFKa2NsRG9FQWNhTi9jMGJnMnJNMlVQRGVCdC9t?=
 =?utf-8?B?QzV2bGJjOTNWUWVPbXVRVENvaHdEdFgzOW9tcHo5dTBNZXpPMDI0RVVoM3lK?=
 =?utf-8?B?YXpqamVNYUlnaWptYThDbzRwQ0tJRGhTTjV2Zm1KVGMzRVVVaGQ1VWZxY1c0?=
 =?utf-8?B?d1oxQXVWRHBqSW9IUlZIQk5DRyswQnFRdkRPYjIwVnR0RmREWDNKQkRWSEc5?=
 =?utf-8?B?V2xqRm5pc0o5WEJMVEtYcE1EM0pydkd5bXpSNE5HYXVuVmN4SjAraUxxbVR0?=
 =?utf-8?B?TUI1cStwNkNMeklQUFFpSmpiNXdJV0ZaYTlTS3Q4MjBmUGlPWHFsZFFOTHdl?=
 =?utf-8?B?YUUwQ1RZU29BMXZDNDRJQXpHT2xKTk02bDh6ZmRnWGcyZk5YdU84MCt4bHNy?=
 =?utf-8?B?SzZRSytmeE1XU3cyWlFIa1JhYWI2YlUwKzFwK1E4djVwclM2allIbFhhc1Y1?=
 =?utf-8?B?TytSMGE3dytkdnNZWC9kQnlhWFcvNzVsaUFIZW5DK3BUY2ZTYXRMTUJ5alYr?=
 =?utf-8?B?NTA0RGZsYjJJM1E2M0grV0o4Zjk1Uzl1bVNVa2tkRE8zY1g3L3oyUm9ROW90?=
 =?utf-8?B?T1pjQTZra21SSjYzZzE0eWJZdEduK0ZURU0zUDFsN0ZtYUhkNjl0ODlOaGs2?=
 =?utf-8?B?Qnl3QWRIcm5rbjBHZmM4aXpodStUZzd2NkpWTXVDZGdWR0tEUG5HOEtXcWZ2?=
 =?utf-8?B?TytLekt3VisxMTRiUFdnSTd3M3ZCb0h4TWlaN095S1dnYjRlVm9kcTdXS29r?=
 =?utf-8?B?UGxDZHVtNmlqb3oreWt0V3B4U1JiMWRzWVdjRkdyQ2Q3KzZpazc2OVlRemlC?=
 =?utf-8?B?U2QwNVRXTlZHZTFBN0oremxPbStqTnM2ekxHQlZkeU9zaFoxVnNoNzZCa3dr?=
 =?utf-8?B?QUZ4aVl4Tm0xQkJVTWFLOGViKzYzelM2a3BtR2pFSnZoRWwxeHFiM0JTdlEw?=
 =?utf-8?B?RlNSd003UUhaa2duaWxEelJGVjhOYi82T08vZzlJNk5PM2RoOEJ2U1NYNG1G?=
 =?utf-8?B?WGlKV05EUEU5bVhTL3VjS2ZYMEZpMGV6Wkt1TmcyRTJYN3VvTC9GNDFyaWdY?=
 =?utf-8?B?bk56aEE1VVhIcHdNMnRQSWgyc1NSSmxSMUtvMTFrdy9VSkFQTlNLSWpCQXNn?=
 =?utf-8?B?Qm5SUitLZS9SbmgrdkRWaDRJbW55MzJER1YxV3FzN0ZYZndBclJTeFF5MXVj?=
 =?utf-8?B?a0R1bWZVV3hEN0NoUmc2WXdmaEpNM1ZOMkxpSThFMVVROUVPOGhSTE5iclBG?=
 =?utf-8?B?KzNKSjRlaG0wYjY3UnBQaFZ1RUs4OEFZdEZDNlVtWUF6VFdadERxRHFzcFRP?=
 =?utf-8?B?aWF3ejlzYmlQUzV5Umd4UXRhRW5rVVJuTkFMN1B3dUJIL3M2RUNmWTlVTkcw?=
 =?utf-8?B?d1VpeFRjNldMRkE1ZU51WlROVFliNnZkK1ZtQnp4Ynk0S3JPNXhFajJwSGsz?=
 =?utf-8?Q?JlmWmtiYXgy6Jc3fpC+XeK80q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64F765DEB321CD428EE5357BE7CD0343@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1a0ab6-3be1-4fc1-58ed-08da666af65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 14:04:41.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuODSdNBd5aErnWPmvRUsDmW7cmrRjAeJpCIg2INjL1t5YFWGk3I0nlgpTCmJ+a9Hzk0lqde4TIyFwsAm2pu1KJPfJcpBXpW3ruR7oC2a10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAxMDoxNiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiAxNS8wNy8yMDIy
IDEwOjExLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4+DQo+PiBPbiBUaHUsIEp1bCAxNCwgMjAyMiBhdCAwNDoxMDozNlBNICswMDAw
LCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+PiBXaXRoIHRoZSBHRlBfQVRP
TUlDLCBiZWhhdmlvdXIgaXMgdGhlIHNhbWUgYXMgYmVmb3JlIGZvciBtZS4NCj4+Pg0KPj4NCj4+
IFNvIHlvdSBzdGlsbCBnZXQgLUVOT01FTSBmYWlsdXJlIG9uIHlvdXIgcGxhdGZvcm0uIEl0IGlz
IGZpbmUsIGp1c3QgdGhhdA0KPj4gSSBhbSBiaXQgY3VyaW91cyB0byBrbm93IHdoeSBhcyBpdCBz
dWNjZWVkcyBhdCBkZXZpY2VfaW5pdGNhbGwgbGF0ZXIuDQo+PiBJIHdhcyBob3BpbmcgdGhpcyBt
aWdodCBmaXggeW91ciBtZW1vcnkgYWxsb2NhdGlvbiBmYWlsdXJlLg0KPiANCj4gQ29ycmVjdC4g
DQoNCkkgdGFrZSB0aGF0IGJhY2suIE9uIHRvZGF5J3MgbmV4dCB3aXRoIHBhdGNoIDIgYXBwbGll
ZCwgSSBkb24ndCBzZWUgYQ0KcHJvYmxlbSB3aXRoIG5vIG1lbW9yeSwgc28gdGhpcyBkb2VzIGFw
cGVhciB0byBoYXZlIHNvcnRlZCB0aGUgbWVtb3J5DQphbGxvY2F0aW9uIGZhaWx1cmUuIFNvcnJ5
IGZvciBtaXNsZWFkaW5nIHlvdSAmIHRoYW5rcyENCg0KV2l0aCBteSBwYXRjaGVzIGZvciBzdG9y
ZV9jcHVfdG9wb2xvZ3kgb24gUklTQy1WIEkgZG8gc2VlIGl0IHRob3VnaCwNCndoZW4gY2FsbGVk
IG9uIHRoZSBib290IGNwdS4gSSBtdXN0IGhhdmUgbWl4ZWQgdXAgd2hpY2ggSSBoYWQgdGVzdGVk
Lg0KSSBoYXZlIGEgZml4IGZvciB0aGF0IHRob3VnaCAmIHdpbGwgdXBkYXRlIG15IHBhdGNoZXMg
bGF0ZXIuDQoNClRoYW5rcyAmIGFwb2xvZ2llcyENCkNvbm9yLg0KDQo=
