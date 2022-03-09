Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8117F4D365C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiCIQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiCIQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:34 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61A199D78;
        Wed,  9 Mar 2022 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646843159; x=1647447959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pgR6IvHXT4uYc9H+N8AmC2ZkG8YDhXOEnFgY0TpU0IE=;
  b=sdK/3hAgLvR6AYBqyF7woRBgGqwhhQFEhkCqnkgBR9GZSQne6cpxH1Xb
   /Y07nqzP54TjKCWEHa6TanCvq0pKd9DvC/KWB0iyqaGC2GLtwD8eMolg6
   hNW9wg+1Pr/NL/uGJ+/sO69heLTabFH50wSkdBlZfxoQkvdonjE2H+f64
   s=;
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFLcqT0/CnVr7JBktfdFblaiMybM/Eqq47Ck1f/u0eWnRuPxt0Df8UqIHMEuWTLXUSwoepzqwjNqVGPi5iPW+yYDS5EhtegiI2okecXeDZuYYxix15MW4cv6ftK/SgEa1iNtXrJKMhgaRo4vymLHAi4YUJ18sb7xbYFx++zWddycudONlCh2JqK6LmMMXIELEoZWwPX8FQv2HvBBL2rcGV9hI2tY1MlZDsAXiZM78XUtaTWjPu330MDMVA1lSCgkdPP8wADohy9Gz2LFKw9jeUBxMPq56m5fNtPtBtq58Fk/z2jUVogX13SVTZw1WaCTfl4e+FCG+PYl1hnhzLOAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgR6IvHXT4uYc9H+N8AmC2ZkG8YDhXOEnFgY0TpU0IE=;
 b=cmVwqQlc52NQH1LrzIROjH2yRUTxzfsQQ9GfjJD4z37HDF3aE43kfIp4E2Bw9ga6CsiR5fenOfcA+XoDa1VHXcNdM1CUEZ+hqYgVzSLkmEFC2DBkJp6Shl7UuML7Q8x9YNAzReHnQMTm4Egika8CXN0wlYf4k6o2k1wnK2M0mnsx4VpVIC+kcRqcLQ0+k2U+pbochphwIh+5LvHxz0j/6Tubi5/vYVExnmCjGg04b1zXRrdzd+YrnZPDvdj86r+KlpjHhvXI4kp7NeUwa7zSLHMGTFM6RmAKsZkDoGFEKB/s0uAo71C8BDZSxF/7wLUIO/78NqziFdLORBQ1/ekQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SN6PR02MB4736.namprd02.prod.outlook.com (2603:10b6:805:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 16:25:22 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 16:25:22 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "rampraka@codeaurora.org" <rampraka@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [PATCH V1] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Topic: [PATCH V1] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Index: AQHYLTlhZk9WmiFVZkCBJEL+rKkKnayr+6qAgAtOaLA=
Date:   Wed, 9 Mar 2022 16:25:22 +0000
Message-ID: <SJ0PR02MB844937D690DF8CE1347FE6FBCD0A9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646117728-28085-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <CAPDyKFpmR35dZj5VGPdKOp58VanUL7it3buN9yAvF+ObiSb32A@mail.gmail.com>
In-Reply-To: <CAPDyKFpmR35dZj5VGPdKOp58VanUL7it3buN9yAvF+ObiSb32A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75f0900f-a617-4062-1fe1-08da01e968af
x-ms-traffictypediagnostic: SN6PR02MB4736:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB47366340D4514C6055DE6815B10A9@SN6PR02MB4736.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2/RqfAtP5xtl7jCFufVVYEndHardOi4WfrsyzcT8PeY7tvTq1eowgtla3B+BXWn4ALJKSGJu6PsrwdJ9CA+uV3QX6vlZ3VVC9cGeF1GFIZrTD27OYDeVggJ7ImZIBGrdtQM2O8mCywd0ipNbe9mFNzfoBDE1VZmkQD6mPIgWBya04qGLUmgczA5VjaxLXvVcO07h7QvY1+HK56riCrAeT4p0Ic93kDTQlMyXBhZqjRJJGcodmvOGoeoq7XiIEpr31Xc3Alsy/7SBVGkemRFsPJfjfe4ACphiN98FYFRhJekjzTeCtWf2+YX9Fj9TrSus+9Mk9JKeWlqv2WNbAUwZtVVrU7NKtQs2CEGATmekjoJh28im1HHcxEmnlOzWxRyy2OBl9XcijueFZNzEVEpiHpD6/Hf9R/mzsAZsMU8i9stnuarBXO5U8n+Exyoc+6H66CYEVIqZNKsHMPk5kTGH95TTtWQAUKIYMubexpYg5/Uf+XXyHQ8u0TagZDwkHCEY+LGmeCKEYTA+DnGxmeaSrRR6Lbu3ZyTVY2m6STwiMWfiVeg3o/DyaCO1lEqLVypwYCjzpQdblgRBITHZ190WJdlNEsG2v37jSXPIvjX9eR6mw164RPd8mFYVm/8rStoOqXnhoit9TtF8AIvn9uPleFRY0X4QW9E+KQqv1XKmMWNJHxWzAg4HalbKqmES5/RjhQqeMw+0cnGSPCgkakpkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(76116006)(2906002)(38100700002)(4326008)(5660300002)(52536014)(86362001)(8676002)(38070700005)(7696005)(8936002)(66446008)(83380400001)(66946007)(66556008)(66476007)(33656002)(9686003)(7416002)(6506007)(186003)(110136005)(71200400001)(508600001)(53546011)(54906003)(122000001)(316002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1BKcmhPbW5tdWxlaDk2VTR6dzRUaC9YS3lmTFZaN293TGhVamcwcExrb3FC?=
 =?utf-8?B?U0UwY1JjLzhJRy8xUXV4ZWtaR2JYdUlscUhnc3N0NENWUDlRMUhKbjV4ZS9Y?=
 =?utf-8?B?K2d5WmluaWlTMk5xdmVBalpXTHJNak8vY3ZmditaN2hsKzlhNjREdUlpalBS?=
 =?utf-8?B?LytqeTFMYjFpWVJuN2ZlN0VPY1RMSVVnbGFENjBZUEtkQkg3Rm9QZ1E0MWxh?=
 =?utf-8?B?N3cwRVNxZ0xuWkFObUNyTDc0QURzNWlTWDgxUTFFekZXZHMwSVl6UHJoRS9v?=
 =?utf-8?B?SE91ZnlSYXk4QW1IeWRBbFFYcSt3TUtrWDhPd2loM2lBY0l3Q0VHOWJUY2cw?=
 =?utf-8?B?YXViZEhMZEtMbzgyWWIxNWF5UHB4OXBaN1puSFZkRHo5QWpOWXJsQVRtN1lY?=
 =?utf-8?B?c0tNUXpyU3ZGRitsU1dTK0VHNmFQWmNVTkhUTUFILzcrY3FzNGxjRitKV2Mx?=
 =?utf-8?B?NzhIZC9TMHJUNnZXY1lKaEh5Q0RPanhuL0UvVzJJZXp2OWQzTlY5am5WTTBL?=
 =?utf-8?B?U1RIZmZSTTVsOGtjV3BUelRQdnZxVGg1MXJZOS8wUW56MXJSbHR4MzNQSVlh?=
 =?utf-8?B?a0luUmFydS93L0NUdWF3a3Q4S3lWWU1ZUXlWdGlyWExxWFl2dWtWMWkyL3U3?=
 =?utf-8?B?UnFKUHVzSUU5UVdDbWpjbHdpM0RVUlk5dmp3RjMvVW8zakw2WWNMclF5Risz?=
 =?utf-8?B?OExnYk1LN3NLN2puYzBsb3ZPU3RxUm96OHE0SnBhVkVwdlVBL2RSMmZJc296?=
 =?utf-8?B?WGs2VnVyeWxhaFpoMTBody83Y0tRcHQvdzNLTG5CS0tCRld6eXZKNFA2THlz?=
 =?utf-8?B?NGNvZFJLNnhBS1dFeG9RQWRIRmxmYXVmTlFuM0R0aWZjQ1BFbjJwWER1ZkZ3?=
 =?utf-8?B?cENZZUl6b0kvRDFsNTNFbVJoZVBoYzJycWpDQ01VOU4rTHN0MVY1dHFxMEY4?=
 =?utf-8?B?Y0hmY2gvSXpKbWFxMnQvSlZJMUF1aXVGL3MvZ1QxYi91RHNibVBEeTk4Mkpn?=
 =?utf-8?B?NXRNRmZ5bkpYY3AvbEtEc2xMWFA0d0h0ZUFZR0lLYUNvYlZML2lPL1cvODRM?=
 =?utf-8?B?TkhTSE5USC96TWlIK0lLMDRuTlBFVTdxcUt3eEVGN2FiT2R3N3RsUGJ2OGtE?=
 =?utf-8?B?SjVPMjhqMDE1ak55dVNtRzBnaUJReW1FME5KaVltMG9nUkNjM25KVmZ0eXhl?=
 =?utf-8?B?UHpIVDVkZkIxWVBnL0VxNVoybE9PZTNJc1B6Znc0bjJ6TFlteXlEZ1d6bGZo?=
 =?utf-8?B?TW1ZbCt6NG9GYmFZV2hqbW5KQ0hrQnVmQmxlQjE5bGszK2hlcUZpMU1hQTFh?=
 =?utf-8?B?M01NU0F4dWdPYTM2RWtLN0RDU1RoMjcxdjcwUGZneWNzbmJtajUzMm1Pd0Fn?=
 =?utf-8?B?MEkrZEJNY05WbXdhdENrd1habi90TGV6Q1IydjJXS1pCL0xVK1huOEsyNnVm?=
 =?utf-8?B?ak9GZkgzSVB6Yldpd1dVNGR5eW4rMnhrSkxPbkZvSnFNbVpkVHVCMlRWZjhH?=
 =?utf-8?B?OVdTNFNWUm9keVJNSTVzMkt3eDhCTC94djcxdTNGTlE5NmU3NWR6bVBZYjRQ?=
 =?utf-8?B?ck1jUEZydTRCV25NZFhUNCtGZGIxYjRZeHV5Q1BtU09DN1hubEdOUVE5RE5F?=
 =?utf-8?B?ZWxURkNhQU9ML3NZU3EyMWM0aU5LY2FDbzNQUnRtL3EzcEVVOWpTNm9yeEdG?=
 =?utf-8?B?SlZOcC8yVW9xMEFrL0RKaGJ2WExUak9NMmFpLzk4WDlNNHQ0N0V0d0NVa0xN?=
 =?utf-8?B?ZWxPMlhjL0VITFkwSyt4MW1QN0xWdWNoZzl4VFNzZjVCUFo3bVVFV2R2b2Jn?=
 =?utf-8?B?VTNDQXVycVRVUVNFcjhjRFRqU05wWTIxNDRtZFpJeEZoaTZ0aWZ2R0NOSjRE?=
 =?utf-8?B?OEZVcjlzckRKcThlQlEvcW1DLythSTlPYmxjZ0lMQ2hEdHJEMm5PV0o2akZL?=
 =?utf-8?B?cVh1cFRuVkZodmZqVkdrMFlzN2lQSDhxcnRpemUvSTBMTHd2dmhUT0dhQ3k0?=
 =?utf-8?B?NjRXR1pxcU14bmgyUlZvNDJMUG9FbkFtdk95L3BzV0ZKUllhNlRPYnhjaE5v?=
 =?utf-8?B?K2ozVnFJMVBhUG4yR1gyRitaUUNnOEg4dWlYa2ZKQVVSS3ZwdlVlZDJVMTdi?=
 =?utf-8?B?S09oTmZwUkVVb3BLUkx1MmQ5Y2lFaUpnMFBpSU9NWk9PeFVrVUNjU3VoNWNN?=
 =?utf-8?B?NnJDV1p5Y3pGT2dwQ1M1ZGNzWDM0a1dtbkNESExvWHpCWlYwcHZFWDNsbWpE?=
 =?utf-8?B?dm1BZFRDWGVkNUNrSi8rZzVTeVJ1YlVwRzFYV3B2OFVKWDAyakNDWkNjbWti?=
 =?utf-8?B?TVl0SUMzcTIyY0s0TkhMQ0NGMDY4RmFlV2liUXk1M0t4dVVmWVU4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f0900f-a617-4062-1fe1-08da01e968af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 16:25:22.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qhMYdZL3pcc3wSYT9tRBWljyelRsz6Z3x+eXbxxdY+AjanPC6L/IGX2cNIlswt1ueEigbZah/Pa8nqZKtdzRHIMddfC8nZSL7aKftwWCEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4736
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlubGluZSBj
b21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBX
ZWRuZXNkYXksIE1hcmNoIDIsIDIwMjIgNToxNiBQTQ0KPiBUbzogU2FqaWRhIEJoYW51IChUZW1w
KSAoUVVJQykgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5jb20+DQo+IENjOiBhZHJpYW4uaHVudGVy
QGludGVsLmNvbTsgYXN1dG9zaGRAY29kZWF1cm9yYS5vcmc7DQo+IHN0dW1tYWxhQGNvZGVhdXJv
cmEub3JnOyBzYXlhbGlsQGNvZGVhdXJvcmEub3JnOyBjYW5nQGNvZGVhdXJvcmEub3JnOw0KPiBy
YW1wcmFrYUBjb2RlYXVyb3JhLm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjFdIG1tYzogc2RoY2ktbXNtOiBSZXNldCBHQ0NfU0RD
Q19CQ1IgcmVnaXN0ZXIgZm9yDQo+IFNESEMNCj4gDQo+IE9uIFR1ZSwgMSBNYXIgMjAyMiBhdCAw
Nzo1NSwgU2hhaWsgU2FqaWRhIEJoYW51DQo+IDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFJlc2V0IEdDQ19TRENDX0JDUiByZWdpc3RlciBiZWZvcmUgZXZlcnkg
ZnJlc2ggaW5pdGlsYXphdGlvbi4gVGhpcw0KPiA+IHdpbGwgcmVzZXQgd2hvbGUgU0RIQy1tc20g
Y29udHJvbGxlciwgY2xlYXJzIHRoZSBwcmV2aW91cyBwb3dlcg0KPiA+IGNvbnRyb2wgc3RhdGVz
IGFuZCBhdm9pZHMsIHNvZnR3YXJlIHJlc2V0IHRpbWVvdXQgaXNzdWVzIGFzIGJlbG93Lg0KPiA+
DQo+ID4gWyA1LjQ1ODA2MV1bIFQyNjJdIG1tYzE6IFJlc2V0IDB4MSBuZXZlciBjb21wbGV0ZWQu
DQo+ID4gWyA1LjQ2MjQ1NF1bIFQyNjJdIG1tYzE6IHNkaGNpOiA9PT09PT09PT09PT0gU0RIQ0kg
UkVHSVNURVIgRFVNUA0KPiA+ID09PT09PT09PT09IFsgNS40NjkwNjVdWyBUMjYyXSBtbWMxOiBz
ZGhjaTogU3lzIGFkZHI6IDB4MDAwMDAwMDAgfA0KPiA+IFZlcnNpb246DQo+ID4gMHgwMDAwNzIw
Mg0KPiA+IFsgNS40NzU2ODhdWyBUMjYyXSBtbWMxOiBzZGhjaTogQmxrIHNpemU6IDB4MDAwMDAw
MDAgfCBCbGsgY250Og0KPiA+IDB4MDAwMDAwMDANCj4gPiBbIDUuNDgyMzE1XVsgVDI2Ml0gbW1j
MTogc2RoY2k6IEFyZ3VtZW50OiAweDAwMDAwMDAwIHwgVHJuIG1vZGU6DQo+ID4gMHgwMDAwMDAw
MA0KPiA+IFsgNS40ODg5MjddWyBUMjYyXSBtbWMxOiBzZGhjaTogUHJlc2VudDogMHgwMWY4MDBm
MCB8IEhvc3QgY3RsOg0KPiA+IDB4MDAwMDAwMDANCj4gPiBbIDUuNDk1NTM5XVsgVDI2Ml0gbW1j
MTogc2RoY2k6IFBvd2VyOiAweDAwMDAwMDAwIHwgQmxrIGdhcDoNCj4gPiAweDAwMDAwMDAwIFsg
NS41MDIxNjJdWyBUMjYyXSBtbWMxOiBzZGhjaTogV2FrZS11cDogMHgwMDAwMDAwMCB8DQo+ID4g
Q2xvY2s6IDB4MDAwMDAwMDMgWyA1LjUwODc2OF1bIFQyNjJdIG1tYzE6IHNkaGNpOiBUaW1lb3V0
OiAweDAwMDAwMDAwIHwNCj4gSW50IHN0YXQ6DQo+ID4gMHgwMDAwMDAwMA0KPiA+IFsgNS41MTUz
ODFdWyBUMjYyXSBtbWMxOiBzZGhjaTogSW50IGVuYWI6IDB4MDAwMDAwMDAgfCBTaWcgZW5hYjoN
Cj4gPiAweDAwMDAwMDAwDQo+ID4gWyA1LjUyMTk5Nl1bIFQyNjJdIG1tYzE6IHNkaGNpOiBBQ21k
IHN0YXQ6IDB4MDAwMDAwMDAgfCBTbG90IGludDoNCj4gPiAweDAwMDAwMDAwDQo+ID4gWyA1LjUy
ODYwN11bIFQyNjJdIG1tYzE6IHNkaGNpOiBDYXBzOiAweDM2MmRjOGIyIHwgQ2Fwc18xOiAweDAw
MDA4MDhmDQo+ID4gWyA1LjUzNTIyN11bIFQyNjJdIG1tYzE6IHNkaGNpOiBDbWQ6IDB4MDAwMDAw
MDAgfCBNYXggY3VycjogMHgwMDAwMDAwMA0KPiA+IFsgNS41NDE4NDFdWyBUMjYyXSBtbWMxOiBz
ZGhjaTogUmVzcFswXTogMHgwMDAwMDAwMCB8IFJlc3BbMV06DQo+ID4gMHgwMDAwMDAwMA0KPiA+
IFsgNS41NDg0NTRdWyBUMjYyXSBtbWMxOiBzZGhjaTogUmVzcFsyXTogMHgwMDAwMDAwMCB8IFJl
c3BbM106DQo+ID4gMHgwMDAwMDAwMA0KPiA+IFsgNS41NTUwNzldWyBUMjYyXSBtbWMxOiBzZGhj
aTogSG9zdCBjdGwyOiAweDAwMDAwMDAwIFsgNS41NTk2NTFdWw0KPiA+IFQyNjJdIG1tYzE6IHNk
aGNpX21zbTogLS0tLS0tLS0tLS0gVkVORE9SIFJFR0lTVEVSDQo+ID4gRFVNUC0tLS0tLS0tLS0t
DQo+ID4gWyA1LjU2NjYyMV1bIFQyNjJdIG1tYzE6IHNkaGNpX21zbTogRExMIHN0czogMHgwMDAw
MDAwMCB8IERMTCBjZmc6DQo+ID4gMHg2MDAwNjQyYyB8DQo+ID4gRExMIGNmZzI6IDB4MDAyMGEw
MDANCj4gPiBbIDUuNTc1NDY1XVsgVDI2Ml0gbW1jMTogc2RoY2lfbXNtOiBETEwgY2ZnMzogMHgw
MDAwMDAwMCB8IERMTCB1c3IgY3RsOg0KPiA+IDB4MDAwMTA4MDAgfCBERFIgY2ZnOiAweDgwMDQw
ODczDQo+ID4gWyA1LjU4NDY1OF1bIFQyNjJdIG1tYzE6IHNkaGNpX21zbTogVm5kciBmdW5jOiAw
eDAwMDE4YTljIHwgVm5kciBmdW5jMiA6DQo+ID4gMHhmODgyMThhOCBWbmRyIGZ1bmMzOiAweDAy
NjI2MDQwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNf
Y19zYmhhbnVAcXVpY2luYy5jb20+DQo+IA0KPiBJZiB0aGlzIGlzIHRoaXMgYSByZWdyZXNzaW9u
LCB0aGVuIHBsZWFzZSB0cnkgdG8gYWRkIGEgZml4ZXMgdGFnIHRvby4NCj4gDQpZZXMsIHdlIGhh
dmUgYnVnYW5pemVyIGZvciB0aGlzLCB3aWxsIGFkZCBpbiBuZXh0IHBhdGNoc2V0Lg0KPiBJIGFz
c3VtZSB3ZSBzaG91bGQgdGFnIHRoaXMgZm9yIHN0YWJsZSBrZXJuZWxzPw0KPiANCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1tc20uYyB8IDQ4DQo+ID4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ4
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW1zbS5jDQo+ID4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW1zbS5jIGluZGV4IDUwYzcx
ZTAuLmYxMGIzYzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1tc20u
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktbXNtLmMNCj4gPiBAQCAtMTcsNiAr
MTcsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+ICAjaW5j
bHVkZQ0KPiA+IDxsaW51eC9pbnRlcmNvbm5lY3QuaD4gICNpbmNsdWRlIDxsaW51eC9waW5jdHJs
L2NvbnN1bWVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiA+DQo+ID4gICNp
bmNsdWRlICJzZGhjaS1wbHRmbS5oIg0KPiA+ICAjaW5jbHVkZSAiY3FoY2kuaCINCj4gPiBAQCAt
Mjg0LDYgKzI4NSw3IEBAIHN0cnVjdCBzZGhjaV9tc21faG9zdCB7DQo+ID4gICAgICAgICBib29s
IHVzZXNfdGFzc2FkYXJfZGxsOw0KPiA+ICAgICAgICAgdTMyIGRsbF9jb25maWc7DQo+ID4gICAg
ICAgICB1MzIgZGRyX2NvbmZpZzsNCj4gPiArICAgICAgIHN0cnVjdCByZXNldF9jb250cm9sICpj
b3JlX3Jlc2V0Ow0KPiA+ICAgICAgICAgYm9vbCB2cW1tY19lbmFibGVkOw0KPiA+ICB9Ow0KPiA+
DQo+ID4gQEAgLTI0ODIsNiArMjQ4NCw0NSBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gc2RoY2lf
bXNtX2dldF9vZl9wcm9wZXJ0eShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICAg
ICAgICAgb2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInFjb20sZGxsLWNvbmZpZyIsDQo+ID4g
Jm1zbV9ob3N0LT5kbGxfY29uZmlnKTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IHNkaGNpX21z
bV9nY2NfcmVzZXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiArICAgICAgICAg
ICAgICBzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkgew0KPiA+ICsgICAgICAgc3RydWN0IHNkaGNp
X3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPiA+ICsgICAgICAg
c3RydWN0IHNkaGNpX21zbV9ob3N0ICptc21faG9zdCA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1f
aG9zdCk7DQo+ID4gKyAgICAgICBpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgICBtc21f
aG9zdC0+Y29yZV9yZXNldCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXQoJnBkZXYtPmRldiwNCj4g
ImNvcmVfcmVzZXQiKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIobXNtX2hvc3QtPmNvcmVfcmVz
ZXQpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIobXNtX2hvc3QtPmNvcmVf
cmVzZXQpOw0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJjb3JlX3Jl
c2V0IHVuYXZhaWxhYmxlICglZClcbiIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgIG1zbV9o
b3N0LT5jb3JlX3Jlc2V0ID0gTlVMTDsNCj4gDQo+IExvb2tzIGxpa2Ugd2Ugc2hvdWxkIHVzZSBk
ZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZSgpDQo+IGluc3RlYWQuDQpT
dXJlIEkgd2lsbCBpbmNvcnBvcmF0ZSB0aGUgY2hhbmdlcyBpbiBuZXh0IHBhdGNoIHNldC4NCj4g
DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBpZiAobXNtX2hvc3QtPmNvcmVfcmVzZXQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgcmV0ID0gcmVzZXRfY29udHJvbF9hc3NlcnQobXNtX2hvc3Qt
PmNvcmVfcmVzZXQpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiY29yZV9yZXNldCBhc3NlcnQg
ZmFpbGVkICglZClcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAg
ICAgICAgICAgICAgKiBUaGUgaGFyZHdhcmUgcmVxdWlyZW1lbnQgZm9yIGRlbGF5IGJldHdlZW4g
YXNzZXJ0L2RlYXNzZXJ0DQo+ID4gKyAgICAgICAgICAgICAgICAqIGlzIGF0IGxlYXN0IDMtNCBz
bGVlcCBjbG9jayAoMzIuN0tIeikgY3ljbGVzLCB3aGljaCBjb21lcyB0bw0KPiA+ICsgICAgICAg
ICAgICAgICAgKiB+MTI1dXMgKDQvMzI3NjgpLiBUbyBiZSBvbiB0aGUgc2FmZSBzaWRlIGFkZCAy
MDB1cyBkZWxheS4NCj4gPiArICAgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAg
IHVzbGVlcF9yYW5nZSgyMDAsIDIxMCk7DQo+IA0KPiBJc24ndCB0aGlzIHN1cHBvc2VkIHRvIGJl
IHRha2VuIGNhcmUgb2YgYnkgdGhlIHJlc2V0IGRyaXZlcj8NCj4gDQo+IE9yIGlzIHRoaXMgbW9y
ZSBhbiBtbWMgY29udHJvbGxlciBzcGVjaWZpYyB0aGluZz8gSW4gdGhhdCBjYXNlLCBjb3VsZCB0
aGlzIGRlbGF5DQo+IHZhcnksIGRlcGVuZGluZyBvbiB0aGUgdmFyaWFudCBvZiB0aGUgY29udHJv
bGxlcj8NClllcywgaXQgaXMgc3BlY2lmaWMgdG8gUUNPTSBTREhDIGNvbnRyb2xsZXIuDQo+IA0K
PiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydCht
c21faG9zdC0+Y29yZV9yZXNldCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJjb3JlX3Jlc2V0
IGRlYXNzZXJ0IGZhaWxlZCAoJWQpXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z290byBvdXQ7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgdXNs
ZWVwX3JhbmdlKDIwMCwgMjEwKTsNCj4gDQo+IERpdHRvPw0KU2FtZSBhcyBhYm92ZQ0KPiANCj4g
PiArICAgICAgIH0NCj4gPiArDQo+ID4gK291dDoNCj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+
ID4gK30NCj4gPg0KPiA+ICBzdGF0aWMgaW50IHNkaGNpX21zbV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KSAgeyBAQA0KPiA+IC0yNTI5LDYgKzI1NzAsMTMgQEAgc3RhdGljIGlu
dCBzZGhjaV9tc21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiA+ICpwZGV2KQ0KPiA+
DQo+ID4gICAgICAgICBtc21faG9zdC0+c2F2ZWRfdHVuaW5nX3BoYXNlID0gSU5WQUxJRF9UVU5J
TkdfUEhBU0U7DQo+ID4NCj4gPiArICAgICAgIHJldCA9IHNkaGNpX21zbV9nY2NfcmVzZXQocGRl
diwgaG9zdCk7DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRl
dl9lcnIoJnBkZXYtPmRldiwgImNvcmVfcmVzZXQgYXNzZXJ0L2RlYXNzZXJ0IGZhaWxlZCAoJWQp
XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQpOw0K
PiA+ICsgICAgICAgICAgICAgICBnb3RvIHBsdGZtX2ZyZWU7DQo+ID4gKyAgICAgICB9DQo+ID4g
Kw0KPiA+ICAgICAgICAgLyogU2V0dXAgU0RDQyBidXMgdm90ZXIgY2xvY2suICovDQo+ID4gICAg
ICAgICBtc21faG9zdC0+YnVzX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiYnVzIik7
DQo+ID4gICAgICAgICBpZiAoIUlTX0VSUihtc21faG9zdC0+YnVzX2NsaykpIHsNCj4gDQo+IEtp
bmQgcmVnYXJkcw0KPiBVZmZlDQo=
