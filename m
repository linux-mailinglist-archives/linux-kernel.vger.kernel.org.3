Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F377349BB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiAYSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:21:11 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:42272 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiAYSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1643134795; x=1643739595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mlBRX8gig+fZP4qnjnWq8pRV/m/xy+RYhzYbp/8rybo=;
  b=O1OiBAfYT5VE63oxewqh5HqO4yJOQ52JUj7wU0fUp1h2xktF464SA2yt
   dbs0JiwsQhbRvnbfDIjU9z6pbBPTUHbxSJUTLCGnjfM9G0QGVlumK/rOD
   5gZyZ6fyGlpvaUmWlbAfR0OAKkx4LuQfJFtYELyU83x30YpLLtMYrJ9QC
   w=;
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 18:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzyDY/Wlow7CSZRLDi88lCxYFM8+ZUAT+79kRzwTSwNiOlO+o3d/2yi48XvnU91MljPBvufdjOtcQBB3O119ypbsiDEU2BxnuUMuGRRPA+SQEbj7mfmwjx1eYwo+1HrkAzYGMkBh4CVr87P3VHW4ulVrohUhjXs/HsXSIa1kjDap3H9jN4Kzmru1WRWyEF5BVte8WxzKK4pZQDYWTQNX/8Kor6DzstA1fa81ACMyR5YDbwAB4NL2dnkEP2zDC0/Su4Xc/McWuRT1wPfRrEEYD73R+5GMfEdO8zNeAJGm1aASOonZtEhVn41C/+7Quzl6BaP04mMGpFplEKK7IBkM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlBRX8gig+fZP4qnjnWq8pRV/m/xy+RYhzYbp/8rybo=;
 b=ROm4uSqIa7VJ4tIQoc7nIFg1M8OmSIELeeEG9NHWgRZ0fwb730U8PLMssMjNFozWRmBZHfI/a0GV6Z5tuYQ5S6llSnhBdvxubk6sr3xQBBERExSKzOT9sl/78e0Z62cp4jPhVAtlFHLp+f3NJ9wr9HZ55g2/+qLLWCnrzmmpzqlDT5rheRoyzfSDyU7LPCMYxl2OUpTv6MWFq2Lbf2Ekky4DegjP5hlXJh5KUU0XNUnSJUk7LDJzxcJyyk+NhfgsBWUwyhh/ZyUD6eBRHRXMPL5CxV+eZn6hPZOOQI3f/4MYy9zMoNSudIi5rOULZ2r7IXEJkbUTsY39Ub8BqOpaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SN6PR02MB5341.namprd02.prod.outlook.com (2603:10b6:805:67::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Tue, 25 Jan
 2022 18:19:51 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%5]) with mapi id 15.20.4909.010; Tue, 25 Jan 2022
 18:19:51 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: RE: [PATCH V3 2/4] mmc: debugfs: Add debug fs entry for mmc driver
Thread-Topic: [PATCH V3 2/4] mmc: debugfs: Add debug fs entry for mmc driver
Thread-Index: AQHYDiL49/onWZ/6IUSIvLAP4a9bYKxtD5yAgAcEYcA=
Date:   Tue, 25 Jan 2022 18:19:50 +0000
Message-ID: <SJ0PR02MB84494706E4515CFBEDB55898CD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-3-git-send-email-quic_c_sbhanu@quicinc.com>
 <0886f705-562f-6c8d-f396-60c2244b6375@intel.com>
In-Reply-To: <0886f705-562f-6c8d-f396-60c2244b6375@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 826fbc5b-2dbb-48d2-5f87-08d9e02f471e
x-ms-traffictypediagnostic: SN6PR02MB5341:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB5341F57E8DA94BF5B86D4E26B15F9@SN6PR02MB5341.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4/tcAWT0nWulkUufqXuKTpJ2tUlS5S4CjzP0sdT2PvWfn6FZ7JxhQhQwljePE95hPPxEOqznSRiOQi7I3fIpQ/3Zypod4Hon/CrNxo/B6ZmrwPWuz14hTXyG3Sa6pI8hLC/NgoMy1xbcmU/wzOrlihdaSSMZBgDBxqafY9tkX1GExRfDxU8KrE6NIdHC35CHKVKuS6Lu4EyOG8yXPKzYjx9Yjj0W9xZ4HhLdhzr5uO3i99saNglo/W2UoB2O22fmx1Jl+ePaU75z8ovQUx0ykKq+7u6YNKVW/1kbcSej40oG1quy+MMB46jBHtIVBFRZWOMb+tc3xkRlwQXTRgbRUQltb60L3uvHA8quWT8LrO9LPybD0fobMEDsZlzY3d4kNQCO09IUSRoohHsZ26BGDUmhPFGIyIuDDiYjDsg2etTiOXUz4Ycw5Fdx+P7KS918dByHRLXhg07Ch+ADD81Bvgy+OzFGOpWsrVIMKvmWhOXzZEJzXIvV2Mi5fmEMeon5ig7tXWAOIiVS7/hHuu7cA6ASVTxM7JvOYrg0KA2Dy7p7enaGaYqS3KHV0iS2nYycRYSejYIY0dgG5idyblpcP24fCMuJASdmmMxBJWeB3DwtMQ7QPOXGtCdGv6V9MzS+Z1CoqN/H02yw7erviPrgVicyuMj0gamqv3EweTwGsgJ/4PhDdjyGfmxCjHHaIBROo24NkOwo3XyP5caJuEjOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(76116006)(316002)(83380400001)(7696005)(4326008)(55016003)(64756008)(66476007)(9686003)(26005)(66446008)(66556008)(8936002)(5660300002)(66946007)(53546011)(54906003)(508600001)(38070700005)(186003)(2906002)(86362001)(52536014)(7416002)(8676002)(71200400001)(110136005)(38100700002)(6506007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjlWUUpjQ3MxQVZUTStYVW9hQkpaQ05Mc1E0MWtJa2s2ZzhhVVRGdUtNWHZw?=
 =?utf-8?B?T2x4UTROOGZUdzV6Nmo1U0tJNkx3Qjc0bzRBZWJKZmh3ZDJzN3lkc2pwQ3lh?=
 =?utf-8?B?M0Y0MC9XT2IxTnNJT1ZNSnUxc2lXSGsrQzlmMjBvdUhaS29KekZpcmwvS0FM?=
 =?utf-8?B?M3NMZXliVlh0c3VqSkhVQlloMm8rVmtzM0VRNjJOODNZL2kzMkZvU1dhNFcv?=
 =?utf-8?B?Q3hOU29ET0s1SllJZUdOMm4yS2hoN25TbmNqV3lBaldsRmJreURhdk82dnBU?=
 =?utf-8?B?dHRHVFh5VTdwaFN5bXhGTzYrdmQ2ejZEaFNDZHVJOXFRVE9TSDhjOWpKUEpa?=
 =?utf-8?B?YWt3V3FqUTNIOGhQYS9WZVRTQi84dGI3eWJFdnBWNng1NHdEdmNrNlpBYmFD?=
 =?utf-8?B?ZXBScmNxUloyUUdrYVUrbXZ3Nkl0aUdKTjhRUDc2MHhnME9jRlZKV3BXdjNQ?=
 =?utf-8?B?SXpzTDUrTjlFd29TbVNzNXZVNDhVVnVrT05JcTFoaXptMTg3blZEbmMvVDZl?=
 =?utf-8?B?Sk9yM3d0Sm9KVFRBcXl4cFhUMnl4MDNQN0Z4encveDcwK0Q1NGxsRm9wa0Vu?=
 =?utf-8?B?cGVxVU90dXNiRkNna2FQYnJWVXlValc1d09ZRlFzeERkaUZnNVJvN2w1a1Q0?=
 =?utf-8?B?NElja0dOVEFicDhNSzgwSllSRXRJbWF1ZmlMV0tZaDRkd3lKTjFZMnVwc2dK?=
 =?utf-8?B?bldrWEwvU2Nud0tXUnZ3K1FlVFo3cEVkR0JoZjJTTDNLeVcwTDNCcWhJMkVw?=
 =?utf-8?B?QUhNUy94d21hOER6b09SVXllbFV0bXpDdVBJT0oyUVBmSGR0N1pWN0xURHdJ?=
 =?utf-8?B?bWxDMk80Tkd3RTRSd0Zad1hjbEM4ZGFKV0YrdW53V0xxMVNodklDcWdsK0xy?=
 =?utf-8?B?SzRZVVFlR0kzMlJEeWFnR2t0eGE0UjRKaVhZR01VR2FYa2dIWTJML3d5SU5o?=
 =?utf-8?B?U0wvcnVEQWNnRUwrMHlvajNhSE9sbzQvUCtxcTJiNjFvS2VsQXluVHYyd1N2?=
 =?utf-8?B?QStkTFM2TDgwdlJPQVNGSW9XQkhxaWMrZXhjL3pJTHlUZGNXQ3lidXpXSmRP?=
 =?utf-8?B?ZkhTUzBrMmhhZ3JBY0xXRU5GS1VibDU2UkJxTnFiT1dDVG9KcVVQUjVkcFVp?=
 =?utf-8?B?RzNoNmhMQmF2RHhKMXNxUzRlRURpd0RnTVFDRFpsSnd6bVB4VW9nbVhtb3Ri?=
 =?utf-8?B?RG1JZmw2cWwxa0lMSFR1QUtKTVZXUlhtSVloZzd3Z3ZGK2dTY3hnUUpvUzB5?=
 =?utf-8?B?cHJMUmRUZ09ROEZZZTUvTEZVbWdZc2cvSnZ4QVRBZXlacUhlazZ1Ris1V0Y3?=
 =?utf-8?B?V2w2dm5QdE9qSHBQSVZxbWlHOW5jOUlFR3FUMkxkOVp6MzcvS2hxMTFIZXBR?=
 =?utf-8?B?ditHeXcrWFdFbjdMc2daQUQ0UTdSQTdBNS9mNUY1RGVtWURndVE3OENHU2pO?=
 =?utf-8?B?WlNOT1g0WmlJL1psWERPYWk4Vi91RUF2Mjk2Q2NmWmx6YkhxVGE5UmoxYjVX?=
 =?utf-8?B?eFlWWEx0dWNFR1c4U3BTeVh4cW1DTDhhMXJsMHZIZm9sdXBzME9ob3paVlBW?=
 =?utf-8?B?UU5WY3g1SjlYSlZKMjM0bVBOY25BYXJLdUNpWmZUSjNCNy9lVmI0aTVaSTVH?=
 =?utf-8?B?SEg3VTF0THltZFZTSUJQZERIQ21MdTBDVm5DWmt5NmxsWVROZ2NVblJyVnRj?=
 =?utf-8?B?SlZiOU01WlBnZFRQbXgvVjJxSEo5SUdveCtoWHQ1VEdVSmxTK2pSalFsdlpr?=
 =?utf-8?B?WFh4NW1vVkcxM0wxdUE1OENZaWJmeXdNbzJta3Q4aFJUbVkxUXVPN2FyQjYv?=
 =?utf-8?B?MjZuNW1RbUY2ZGhVYVJwVGlGZndqU2tvSHNvdUtkNU9kdTFZQjFOMkp2dGRp?=
 =?utf-8?B?MFE5OGcvNGRWUlA5YTFiWmlGeUY3Z0luN2ZETW5KenlSN3BWNGR6NTg4QlVi?=
 =?utf-8?B?MkR5ajNJWFFobVpNb1orNDNZWFBSMlJxRytxbHJUVkI0U3d1MEMrT0pGRlNV?=
 =?utf-8?B?S0JNY0lnODg5c3hIV2xEUFBBL3pZQkpuRk5EVmFRd0IvRTJlWTRTSTltd2ZQ?=
 =?utf-8?B?MnI3bHYzSkNLdTlvNUI4Yk5NL3NEUDJ0YUVvcVJ3YURCZGxkYUlQT1AzbnpM?=
 =?utf-8?B?cEI3VWNFSWJoL29HRlBOS3NTSFlPMXhKZmVNb0VaTVdQbXdTQW1IOGJjWjM5?=
 =?utf-8?B?MXRRQmFwUGNaWkxQcWUxV0RUTU1YMjBoSU1WcDhiQ216QTNRS0drdEV0VXlF?=
 =?utf-8?B?eExQUVNEcEVaMGloVm9MV2JBT1Z3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826fbc5b-2dbb-48d2-5f87-08d9e02f471e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 18:19:50.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6axNeJkvmmWY3qRSph9IAaP5RqXPGeb+TdVkOlOSyIA7xoabr3hfDngiFzak9oVCKcptltiWkUNVMLBlKWM1HSOhehw/fnaJ3ajmzQBHxkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5341
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlubGluZSBj
b21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4gDQpTZW50OiBG
cmlkYXksIEphbnVhcnkgMjEsIDIwMjIgMTI6NDAgUE0NClRvOiBTYWppZGEgQmhhbnUgKFRlbXAp
IChRVUlDKSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT47IEFzdXRvc2ggRGFzIChRVUlDKSA8
cXVpY19hc3V0b3NoZEBxdWljaW5jLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGFncm9z
c0BrZXJuZWwub3JnOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCkNjOiBzdHVtbWFsYUBjb2RlYXVyb3JhLm9yZzsgdmJhZGlnYW5AY29k
ZWF1cm9yYS5vcmc7IFJhbSBQcmFrYXNoIEd1cHRhIChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWlj
aW5jLmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChRVUlDKSA8cXVpY19wcmFnYWxsYUBxdWlj
aW5jLmNvbT47IHNhcnRnYXJnQGNvZGVhdXJvcmEub3JnOyBuaXRpcmF3YUBjb2RlYXVyb3JhLm9y
Zzsgc2F5YWxpbEBjb2RlYXVyb3JhLm9yZzsgTGlhbmdsaWFuZyBMdSA8bHVsaWFuZ0Bjb2RlYXVy
b3JhLm9yZz47IEJhbyBEIC4gTmd1eWVuIDxuZ3V5ZW5iQGNvZGVhdXJvcmEub3JnPg0KU3ViamVj
dDogUmU6IFtQQVRDSCBWMyAyLzRdIG1tYzogZGVidWdmczogQWRkIGRlYnVnIGZzIGVudHJ5IGZv
ciBtbWMgZHJpdmVyDQoNCk9uIDIwLzAxLzIwMjIgMTk6MjYsIFNoYWlrIFNhamlkYSBCaGFudSB3
cm90ZToNCj4gQWRkIGRlYnVnIGZzIGVudHJ5IHRvIHF1ZXJ5IGVNTUMgYW5kIFNEIGNhcmQgZXJy
b3JzIHN0YXRpc3RpY3MNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoYWlrIFNhamlkYSBCaGFudSA8
cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGlhbmdsaWFuZyBM
dSA8bHVsaWFuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU2F5YWxpIExva2hh
bmRlIDxzYXlhbGlsQGNvZGVhdXJvcmEub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYW8gRC4gTmd1
eWVuIDxuZ3V5ZW5iQGNvZGVhdXJvcmEub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2NvcmUv
ZGVidWdmcy5jIHwgODEgDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Rl
YnVnZnMuYyANCj4gaW5kZXggM2ZkYmM4MC4uZjRjYjU5NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tbWMvY29yZS9kZWJ1Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMN
Cj4gQEAgLTIyMyw2ICsyMjMsODIgQEAgc3RhdGljIGludCBtbWNfY2xvY2tfb3B0X3NldCh2b2lk
ICpkYXRhLCB1NjQgdmFsKSAgDQo+IERFRklORV9ERUJVR0ZTX0FUVFJJQlVURShtbWNfY2xvY2tf
Zm9wcywgbW1jX2Nsb2NrX29wdF9nZXQsIG1tY19jbG9ja19vcHRfc2V0LA0KPiAgCSIlbGx1XG4i
KTsNCj4gIA0KPiArc3RhdGljIGludCBtbWNfZXJyX3N0YXRlX2dldCh2b2lkICpkYXRhLCB1NjQg
KnZhbCkgew0KPiArCXN0cnVjdCBtbWNfaG9zdCAqaG9zdCA9IGRhdGE7DQo+ICsNCj4gKwlpZiAo
IWhvc3QpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJKnZhbCA9IGhvc3QtPmVycl9z
dGF0ZSA/IDEgOiAwOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK0RFRklORV9T
SU1QTEVfQVRUUklCVVRFKG1tY19lcnJfc3RhdGUsIG1tY19lcnJfc3RhdGVfZ2V0LCBOVUxMLCAN
Cj4gKyIlbGx1XG4iKTsNCj4gKw0KPiArc3RhdGljIGludCBtbWNfZXJyX3N0YXRzX3Nob3coc3Ry
dWN0IHNlcV9maWxlICpmaWxlLCB2b2lkICpkYXRhKSB7DQo+ICsJc3RydWN0IG1tY19ob3N0ICpo
b3N0ID0gKHN0cnVjdCBtbWNfaG9zdCAqKWZpbGUtPnByaXZhdGU7DQo+ICsJY29uc3QgY2hhciAq
ZGVzY1tNTUNfRVJSX01BWF0gPSB7DQo+ICsJCVtNTUNfRVJSX0NNRF9USU1FT1VUXSA9ICJDb21t
YW5kIFRpbWVvdXQgT2NjdXJyZWQiLA0KPiArCQlbTU1DX0VSUl9DTURfQ1JDXSA9ICJDb21tYW5k
IENSQyBFcnJvcnMgT2NjdXJyZWQiLA0KPiArCQlbTU1DX0VSUl9EQVRfVElNRU9VVF0gPSAiRGF0
YSBUaW1lb3V0IE9jY3VycmVkIiwNCj4gKwkJW01NQ19FUlJfREFUX0NSQ10gPSAiRGF0YSBDUkMg
RXJyb3JzIE9jY3VycmVkIiwNCj4gKwkJW01NQ19FUlJfQVVUT19DTURdID0gIkF1dG8tQ21kIEVy
cm9yIE9jY3VycmVkIiwNCj4gKwkJW01NQ19FUlJfQURNQV0gPSAiQURNQSBFcnJvciBPY2N1cnJl
ZCIsDQo+ICsJCVtNTUNfRVJSX1RVTklOR10gPSAiVHVuaW5nIEVycm9yIE9jY3VycmVkIiwNCj4g
KwkJW01NQ19FUlJfQ01EUV9SRURdID0gIkNNRFEgUkVEIEVycm9ycyIsDQo+ICsJCVtNTUNfRVJS
X0NNRFFfR0NFXSA9ICJDTURRIEdDRSBFcnJvcnMiLA0KPiArCQlbTU1DX0VSUl9DTURRX0lDQ0Vd
ID0gIkNNRFEgSUNDRSBFcnJvcnMiLA0KPiArCQlbTU1DX0VSUl9SRVFfVElNRU9VVF0gPSAiUmVx
dWVzdCBUaW1lZG91dCIsDQo+ICsJCVtNTUNfRVJSX0NNRFFfUkVRX1RJTUVPVVRdID0gIkNNRFEg
UmVxdWVzdCBUaW1lZG91dCIsDQo+ICsJCVtNTUNfRVJSX0lDRV9DRkddID0gIklDRSBDb25maWcg
RXJyb3JzIiwNCj4gKwl9Ow0KPiArCWludCBpOw0KPiArDQo+ICsJaWYgKCFob3N0KQ0KPiArCQly
ZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCWlmICghaG9zdC0+ZXJyX3N0YXRzX2VuYWJsZWQpIHsN
Cj4gKwkJc2VxX3ByaW50ZihmaWxlLCAiTm90IHN1cHBvcnRlZCBieSBkcml2ZXJcbiIpOw0KPiAr
CQlyZXR1cm4gMDsNCj4gKwl9DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgTU1DX0VSUl9NQVg7
IGkrKykgew0KPiArCQlpZiAoZGVzY1tpXSkNCj4gKwkJCXNlcV9wcmludGYoZmlsZSwgIiMgJXM6
XHQgJWRcbiIsDQo+ICsJCQkJCWRlc2NbaV0sIGhvc3QtPmVycl9zdGF0c1tpXSk7DQo+ICsJfQ0K
PiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbW1jX2Vycl9zdGF0
c19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKSANCj4gK3sNCj4g
KwlyZXR1cm4gc2luZ2xlX29wZW4oZmlsZSwgbW1jX2Vycl9zdGF0c19zaG93LCBpbm9kZS0+aV9w
cml2YXRlKTsgfQ0KPiArDQo+ICtzdGF0aWMgc3NpemVfdCBtbWNfZXJyX3N0YXRzX3dyaXRlKHN0
cnVjdCBmaWxlICpmaWxwLCBjb25zdCBjaGFyIF9fdXNlciAqdWJ1ZiwNCj4gKwkJCQkgICBzaXpl
X3QgY250LCBsb2ZmX3QgKnBwb3MpDQo+ICt7DQo+ICsJc3RydWN0IG1tY19ob3N0ICpob3N0ID0g
ZmlscC0+Zl9tYXBwaW5nLT5ob3N0LT5pX3ByaXZhdGU7DQo+ICsNCj4gKwlpZiAoIWhvc3QpDQo+
ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJcHJfZGVidWcoIiVzOiBSZXNldHRpbmcgTU1D
IGVycm9yIHN0YXRpc3RpY3NcbiIsIF9fZnVuY19fKTsNCj4gKwltZW1zZXQoaG9zdC0+ZXJyX3N0
YXRzLCAwLCBzaXplb2YoaG9zdC0+ZXJyX3N0YXRzKSk7DQo+ICsNCj4gKwlyZXR1cm4gY250Ow0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBtbWNfZXJy
X3N0YXRzX2ZvcHMgPSB7DQo+ICsJLm9wZW4JPSBtbWNfZXJyX3N0YXRzX29wZW4sDQo+ICsJLnJl
YWQJPSBzZXFfcmVhZCwNCj4gKwkud3JpdGUJPSBtbWNfZXJyX3N0YXRzX3dyaXRlLA0KPiArfTsN
Cj4gKw0KPiAgdm9pZCBtbWNfYWRkX2hvc3RfZGVidWdmcyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3Qp
ICB7DQo+ICAJc3RydWN0IGRlbnRyeSAqcm9vdDsNCj4gQEAgLTIzNiw2ICszMTIsMTEgQEAgdm9p
ZCBtbWNfYWRkX2hvc3RfZGVidWdmcyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+ICAJZGVidWdm
c19jcmVhdGVfZmlsZV91bnNhZmUoImNsb2NrIiwgU19JUlVTUiB8IFNfSVdVU1IsIHJvb3QsIGhv
c3QsDQo+ICAJCQkJICAgJm1tY19jbG9ja19mb3BzKTsNCj4gIA0KPiArCWRlYnVnZnNfY3JlYXRl
X2ZpbGUoImVycl9zdGF0ZSIsIDA2MDAsIHJvb3QsIGhvc3QsDQo+ICsJCSZtbWNfZXJyX3N0YXRl
KTsNCg0KUGxlYXNlLCBsZXQncyBkcm9wIGVycl9zdGF0ZSBmb3Igbm93DQoNCj4+Pj4+IGZpcnN0
IHdlIGNhbiBjaGVjayB0aGlzIHJpZ2h0LCAgaWYgaXQgaXMgc2V0IHRoZW4gd2UgY2FuIGdvIGFu
ZCBjaGVjayBlcnJfc3RhdHNbXSB0byBrbm93IG1vcmUgb24gdHlwZSBvZiBlcnJvciAoZGF0YSAv
Y21kIHRpbWVvdXQgb3IgQ1JDIGVycm9ycyBldGMuKS4NClBsZWFzZSBsZXQgbWUga25vdyB5b3Vy
IG9waW5pb24gb24gdGhpcy4oIFNhbWUgYXMgcGF0Y2ggc2V0IChWMyAxLzQpLg0KDQo+ICsJZGVi
dWdmc19jcmVhdGVfZmlsZSgiZXJyX3N0YXRzIiwgMDYwMCwgcm9vdCwgaG9zdCwNCj4gKwkJJm1t
Y19lcnJfc3RhdHNfZm9wcyk7DQo+ICsNCj4gICNpZmRlZiBDT05GSUdfRkFJTF9NTUNfUkVRVUVT
VA0KPiAgCWlmIChmYWlsX3JlcXVlc3QpDQo+ICAJCXNldHVwX2ZhdWx0X2F0dHIoJmZhaWxfZGVm
YXVsdF9hdHRyLCBmYWlsX3JlcXVlc3QpOw0KPiANCg0K
