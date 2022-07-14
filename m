Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02442574547
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiGNGvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGNGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:51:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D2248F8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657781471; x=1689317471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nyJdC4P7/7S0uh8IsvWvseqAhyu2bLzqPx2JqtEfPaI=;
  b=Fs491bHY78h9lbailFe45L2sLAr6GaurDu1bViDBYodSoKyrh642n8iA
   0U6KTf9ICOBJtrFQcbkOVY1dtZdlSq/FzAk/Pw9eFA/Q+kDHcskbTUgbd
   v4+MTTkUnQyJrxSQjmTTB76FjuV2wW3QvcNd4z+VQXYyBM4Hr1Hpbi5EX
   v1AYPmFYB4tH/pTvwym+acplJtuRH14LE90e8T0Y+JIiUvuSM1ncPbeva
   oDjgooZBDgV5FGlXKwwKiPz7p5dlv7cVVBf7/4mwuGgSQjGQaukelwllc
   rBQSCnX3ErXx5VtneeR3ZzrMadBiVBb6GqlgDn0La8hFk2g7+aIx43oIx
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="182102202"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 23:51:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 23:51:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 23:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQN7C7K/mpkl+/ewcTxlNa1S7SC/OtYGRJEwce6VYzn0+hMehgvtd5GVOIfMat23RvQzGHQYiJuOonHgZTdXFkdZwFxk5VrdQWQIOkKBN87qnKqnmzwr9+aC7XEfoA2AJlaQE/KWzPLp1CZgh9IbmJCvqKkXrcpzE7gAcJuYNAraIcOjPeS7pXuJHKkQRy05nVpyEfuuv6b9a0u+Hb1aF5PomR1qG29JZk8OT9n7aBf1LEZC9rP7Be5RDtgJsF/85yulkkpliB0q/wyFJt/51L7Kai9E03kflC1K7F96b9Rz8DT0SvUBDDsbumpkhSqvpAUguuRDDb17YoSnUPJwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyJdC4P7/7S0uh8IsvWvseqAhyu2bLzqPx2JqtEfPaI=;
 b=IJfWJteQrE1tjds4focr96NcNao0XRHNd5iAKuB8ZcX2VtAfemnpT4yVZvbBsshZL8QR+YxiaEoiF3Qod89fSTrdaryIrlEpEMEYYeQ2EQtaGYqneq86iMwf4GR8Zzt/6nHobJfZ7dHSlRlZad9ejstgLXU8PrEYAJf/ZrbJkmad5iuoQ3WLSwMv1eWvbjpAumaUaYVPBQcXianpLZnaOObk8BL69C41He0GhsnRHRY2y/pkIAor+Lfeu0hS71/7JuA0MWJRtmKwEfJCKOKV5ILQ1pygfFmjVKfEYwUJY0MeHvu7FnK7xK3O8pLGXje5qCkM7hxe5yAEn4jrx7bJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyJdC4P7/7S0uh8IsvWvseqAhyu2bLzqPx2JqtEfPaI=;
 b=fvCFnFQngK1lyLiL70Z4rM3198A3h5sYTT09uf5Q/x7sKhRSr3lRRhCumqyE8AIaGNU0LCCIqh1WvBNXTwvozbJAVPEfLsrLE5u4HbaOS6QtZ9vX8vIU0wQ1LlL1WItFR108Z3KIQKxSp/MKBfVDTOC8DwU9AIS5R6xHTlkHAE8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 06:51:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 06:51:09 +0000
From:   <Conor.Dooley@microchip.com>
To:     <huqi@loongson.cn>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
        <oleg@redhat.com>
CC:     <lixu@loongson.cn>, <loongarch@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] LoongArch: Fix missing fcsr in ptrace's fpr_set
Thread-Topic: [PATCH] LoongArch: Fix missing fcsr in ptrace's fpr_set
Thread-Index: AQHYl04ZW6ytVi5wO0KLhD8n0nhCfQ==
Date:   Thu, 14 Jul 2022 06:51:09 +0000
Message-ID: <6bc55cd5-bb6e-8d4a-79ec-4555c0b7765b@microchip.com>
References: <20220714062550.4934-1-huqi@loongson.cn>
In-Reply-To: <20220714062550.4934-1-huqi@loongson.cn>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 721e7253-166f-4ca8-ac72-08da65653bed
x-ms-traffictypediagnostic: SA0PR11MB4560:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+G7QpA5uBS+NLoA4VF01O2N6RmNnPKSmJdfF8lzkweca42NClTsGQRle1PjJdl3BjJTdz9HymoIGgGRP9fYPYErodFzMznHqLp+rLXjKSeb5DlPmUEYUzaY2T2OdDas/RKagOCEWoCbrizcNuP/5P5x1UEuiyR8ruFx6M84DvUpnYon8RpxthqacpelpqP5HOHdQY0sG80Gvs0uJRIOHG1hg5smO1f0GIC3Ci9BdlP3dcDapvbEV2/SjojeWgRGTfIJzlT0uX0dyAShE2RSpLmpa6Ve1BjSborQukiYR5oas2gX70LRO4SuQ1FYo6bHraR1aYkDGb9i29hNH+k4AM4vQd4+sMZrMw7WGo2KDiJtZFxZN7hl53DdNipGkPxO45KvsFFdyGkmi2BApXTFIakQMmKYTxtnmGFQRba4ADeUFvL5GjTmjer0pNmkB9nflTF3Pubd0YpPol/ALThBYSBLu41dIiK2slc6YKaY82rOziKEdM4fX04dcCSnyTKuYdI7SgvycRXcogcYX0BED65k/OYgDrxJYHChcgoxnEYraa5lAgA0x13fVZ6zc67VmUZT8L45ce98YVjZXAbwdcPYQ410fvquWJJETU7q0nAXN+pdj4w+fxbMpIpzxrLoCcjhLSmu+le4YpGZcz9Bt6fNhwtYKXmQHqefKT9FTHwb1HUepZlHFk7Nfr8pLPAv6NhCVXQCFzkz3TwSQGZAu+PIT+0oihlMy98LudFQTV0GGqCADM34R9dYsbYUX7Mn9V5CwVCP4gHOc7+ohGZDFJqoLx2OE87M8qqIATnr1dPkPQY1ZGRgwcb/Mgdig6fFIbR8INfC9Xz5gLdpEQVL9pjlceDEGUqqRPEuPvGtaByyNcHnpaWdbkiiwV9fIn9x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(136003)(396003)(39860400002)(66476007)(64756008)(53546011)(6512007)(6506007)(54906003)(86362001)(66946007)(76116006)(26005)(5660300002)(41300700001)(66446008)(110136005)(66556008)(478600001)(6486002)(91956017)(71200400001)(122000001)(316002)(38100700002)(36756003)(38070700005)(31696002)(83380400001)(2616005)(8676002)(31686004)(8936002)(2906002)(186003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0VNNkM5WkNlTmpmaTVYdHhEeUN5VDFxL2h6ZmViMFRKMnlJMkdkOUJCTkY2?=
 =?utf-8?B?T0pNZ3dHZGtXKzRLaDJuQUZxRmVZRWRjdndwVm02OVhBdERIWU1LbGI3eTZP?=
 =?utf-8?B?dk9yT1dnRnA0K1BRYzJPZkZKcmxVd2tzMjR6VEFPZ3dCRm5JY0xVeDh4VW1m?=
 =?utf-8?B?My9EcmZKOEFqRTZjYnBuTUowTmFyS3ZxOElPdWo3ZlFPYllEZ1UyT0owWnY3?=
 =?utf-8?B?WlFpcTNZOFVqWmsrUllsTldZVG1jMmMwKzlkYUorTTVSWjU0WExPQUxxZXF6?=
 =?utf-8?B?SnBHMm1PNkhFQUlLWlFPNmpTNlQrejVrTXRUb2NsNWxESElyLzYzUUY5eUto?=
 =?utf-8?B?K1E4QTY0cm9hZm12VG9YTHQ2TG4rbTFTNHdRcG9kVndHcVd0eU9SSTlOM1VD?=
 =?utf-8?B?Ylc0UU05cmF0VVI0Z3FiZ1hJV2FhQ2JsVy9IOTQ3dDZjT3U1U3QvR3dFZWN0?=
 =?utf-8?B?MDB3dnB6a1NKWEZJZ3NWNERGK1RuaUlUOXlvN1lNcCs0VStxVkFUQ0ZZYzB4?=
 =?utf-8?B?djlpallQQ0Z2dVF4d2MxdnVDR1NzcDduNitMTFI4TTNzR0Q0UldpejZ0Y1hR?=
 =?utf-8?B?TnlQN08vMnpUUmh0eXJETkhjL0dYVTcydEVreGNsQWJ5ODdjR1lwUVlzSytO?=
 =?utf-8?B?YytmWXdOVHhqa3BudUx3bm1DdXN6TUFVWXhiNlpwaXJLdDVzSWFCK2JFMnJt?=
 =?utf-8?B?bjBPbzlSeVkzTFdlWjRUNjNGVjlQZkVoNW5saVlVUDladWpZalJKdVR1Szlt?=
 =?utf-8?B?TVdnbUFtY0V0YTdEQVdaYllveTEyTFFVb1V4MStMeEFNSFpGK1BETlg0VjBQ?=
 =?utf-8?B?TExXdWdBZkRWcGRkK212YWdyV2VNTHMyekd3M29SVU54K2grZFh4Q3RkT0NM?=
 =?utf-8?B?eFJBTE5uNDVYQVE1MVVBR2xycjNnMWhwVnpvRmtQNTVwQjRSNGlGT3dVMkM3?=
 =?utf-8?B?a0doWWhZWkVraWphTEhiT0FKbWh5bVJRcjlXS3VqMlA3bzlPUGp2SWdTeW5D?=
 =?utf-8?B?c2d6MnlsZnN1KzRGL0ZLSUtwQlRpQ3JnVHhpTkFSMjVzdTQ2TTNaZGJ4TnBN?=
 =?utf-8?B?ZUFtLzNHWG5FMERDalNvSWZNbmRYdnpTUTFFajlrb2RwNlZRK0s4QUs4MGE0?=
 =?utf-8?B?NkhaMm5Oc2FmSHZKbnFPeGViOStKM1hFSkJ1Si9LYTBZaXRDOHV2aGs5Qlhn?=
 =?utf-8?B?WXlSa1FIZkdNTmREWkpMMnU1RElxbC9IZ05MWEc4MWlLRVMzRU5vM0lMbVBV?=
 =?utf-8?B?bWlaaGozMzA3cGhTSS84ckYyRnlQbUh0dlZqd3RVU0t1ZVpSNTNhUUxodXpW?=
 =?utf-8?B?bjRiZG5qZVpkWEVOQWhqcmwrTnE4NjN0Qm9LV0pIQlczQUJib3hrU1YyVVcy?=
 =?utf-8?B?KytSeVBxaWhjUVNBa3ZRZ2lQRHFwanlWdEFLZEhNdTR4Nm9pckg3dHhkQitZ?=
 =?utf-8?B?N2FtaDZ4T05mdjUwekg0ZWlEK2taS1VQNUxLWnZ3a29QanFMUTJDcXE3RUtI?=
 =?utf-8?B?SlFNUTJMV3VoWkt0ejVnZjVBUUMyR0lMMVVTNXFCRSsxTnpvbWRkRUw4N3Bz?=
 =?utf-8?B?MHY5OXBKZ241T250Yjd5eWQxQTFYdlZrR0hsa2pYT2dBRkwrZUZyQzNWRGRQ?=
 =?utf-8?B?cG8zZ2x3LzZqNUJmMUJYbXVSekd6aVloQU5kblNlNUdtQ25oWXo3ODg0U2dM?=
 =?utf-8?B?UGlrYTlrVkk4YldTbVRhYmZRdDIvcFV5Y01WaDVwQ2hqYUtKd2VQTDBlSHdO?=
 =?utf-8?B?OVM4TGRkb3R6NjhvSGRTQ3NtSy9GR2xLc2lZOWtQWjRJQ3pBUVQ1UFVSOHFN?=
 =?utf-8?B?cDNsWE1pNWFsUzgyRmMrT2Fidkp4UU8zTUxNQ3htZGlGRFBVUVpyaXdKeWxw?=
 =?utf-8?B?OEhSTFBwd2NnVlJReUliYng2QnZCbUdiTVJCakY4RldpcGVYN1dPMTBYcC8z?=
 =?utf-8?B?WFg4SlI1VloyVWVWTGswYzBFNm1paUx1elpNOExpbXJGbXNyY1BSOG83OGk2?=
 =?utf-8?B?NjhremEyMnFCdkpSV0NVYThvVkRMMGdmYnM3akVOSDh2b0l3eG9BWTc1SnNJ?=
 =?utf-8?B?azMvdi94TFRJUjZic05nMVA2ejBCMmRGeCtaeTExa1FpU0hOZU90QXYzM1JY?=
 =?utf-8?Q?apt/nURSfOuo/s3NfWckcJB1z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8607988B9A012648BEAC32AD9DFC8B35@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721e7253-166f-4ca8-ac72-08da65653bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 06:51:09.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjAhJAAJnIjVuY35jAjVZR3TQ8mvYC74K+IBsYddmvIGetUmvb15sqqJ0y6EZj6kTiMbkxFHUHJRici4V5KCAiYLzXMk7+QLh3iKbrab2aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDcvMjAyMiAwNzoyNSwgUWkgSHUgd3JvdGU6DQo+IEluIGZpbGUgcHRyYWNlLmMsIGZ1
bmN0aW9uIGZwcl9zZXQgZG9lcyBub3QgY29weSBmY3NyIGRhdGEgZnJvbSB1YnVmDQo+IHRvIGti
dWYuIFRoYXQncyB0aGUgcmVhc29uIHdoeSBmY3NyIGNhbm5vdCBiZSBtb2RpZmllZCBieSBwdHJh
Y2UuDQo+IA0KPiBUaGlzIHBhdGNoIGZpeHMgdGhpcyBwcm9ibGVtIGFuZCBhbGxvd3MgdXNlcnMg
dXNpbmcgcHRyYWNlIHRvIG1vZGlmeQ0KPiB0aGUgZmNzci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFFpIEh1IDxodXFpQGxvb25nc29uLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBYdSBMaSA8bGl4dUBs
b29uZ3Nvbi5jbj4NCg0KSGV5IFFpIEh1LA0KDQpXaHkgZG9lcyB0aGlzIGhhdmUgWHUgTGkncyBT
b0IgaWYgdGhleSdyZSBuZWl0aGVyIHRoZSBhdXRob3Igbm9yIGxpc3RlZA0KYXMgYSBDby1kZXZl
bG9wZWQtYnk6Pw0KDQpBcyBzdWJtaXR0ZXIsIHlvdXIgU29CIHNob3VsZCBiZSBsYXN0IGFueXdh
eS4NClRoYW5rcywNCkNvbm9yLg0KDQo+IC0tLQ0KPiAgIGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9w
dHJhY2UuYyB8IDEyICsrKysrKystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gv
a2VybmVsL3B0cmFjZS5jIGIvYXJjaC9sb29uZ2FyY2gva2VybmVsL3B0cmFjZS5jDQo+IGluZGV4
IGU2YWI4Nzk0OGUxZC4uZGMyYjgyZWE4OTRjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2xvb25nYXJj
aC9rZXJuZWwvcHRyYWNlLmMNCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gva2VybmVsL3B0cmFjZS5j
DQo+IEBAIC0xOTMsNyArMTkzLDcgQEAgc3RhdGljIGludCBmcHJfc2V0KHN0cnVjdCB0YXNrX3N0
cnVjdCAqdGFyZ2V0LA0KPiAgIAkJICAgY29uc3Qgdm9pZCAqa2J1ZiwgY29uc3Qgdm9pZCBfX3Vz
ZXIgKnVidWYpDQo+ICAgew0KPiAgIAljb25zdCBpbnQgZmNjX3N0YXJ0ID0gTlVNX0ZQVV9SRUdT
ICogc2l6ZW9mKGVsZl9mcHJlZ190KTsNCj4gLQljb25zdCBpbnQgZmNjX2VuZCA9IGZjY19zdGFy
dCArIHNpemVvZih1NjQpOw0KPiArCWNvbnN0IGludCBmY3NyX3N0YXJ0ID0gZmNjX3N0YXJ0ICsg
c2l6ZW9mKHU2NCk7DQo+ICAgCWludCBlcnI7DQo+ICAgDQo+ICAgCUJVR19PTihjb3VudCAlIHNp
emVvZihlbGZfZnByZWdfdCkpOw0KPiBAQCAtMjA5LDEwICsyMDksMTIgQEAgc3RhdGljIGludCBm
cHJfc2V0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFyZ2V0LA0KPiAgIAlpZiAoZXJyKQ0KPiAgIAkJ
cmV0dXJuIGVycjsNCj4gICANCj4gLQlpZiAoY291bnQgPiAwKQ0KPiAtCQllcnIgfD0gdXNlcl9y
ZWdzZXRfY29weWluKCZwb3MsICZjb3VudCwgJmtidWYsICZ1YnVmLA0KPiAtCQkJCQkgICZ0YXJn
ZXQtPnRocmVhZC5mcHUuZmNjLA0KPiAtCQkJCQkgIGZjY19zdGFydCwgZmNjX2VuZCk7DQo+ICsJ
ZXJyIHw9IHVzZXJfcmVnc2V0X2NvcHlpbigmcG9zLCAmY291bnQsICZrYnVmLCAmdWJ1ZiwNCj4g
KwkJCQkgICZ0YXJnZXQtPnRocmVhZC5mcHUuZmNjLCBmY2Nfc3RhcnQsDQo+ICsJCQkJICBmY2Nf
c3RhcnQgKyBzaXplb2YodTY0KSk7DQo+ICsJZXJyIHw9IHVzZXJfcmVnc2V0X2NvcHlpbigmcG9z
LCAmY291bnQsICZrYnVmLCAmdWJ1ZiwNCj4gKwkJCQkgICZ0YXJnZXQtPnRocmVhZC5mcHUuZmNz
ciwgZmNzcl9zdGFydCwNCj4gKwkJCQkgIGZjc3Jfc3RhcnQgKyBzaXplb2YodTMyKSk7DQo+ICAg
DQo+ICAgCXJldHVybiBlcnI7DQo+ICAgfQ0K
