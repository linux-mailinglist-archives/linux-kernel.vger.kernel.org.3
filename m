Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAAB4D41F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiCJHg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiCJHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:36:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015EBC5DAD;
        Wed,  9 Mar 2022 23:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646897754; x=1678433754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hm7F1ycWimWoPgdgxQiSNpemLbbe1owf8sQ2j58BrTw=;
  b=jcpu2xkXFuJkmtha/t7WLlXcFel5OECcD1VIZJdY/yP+lgj3Z7b8F3jV
   qwnkxqSoB8PUNSpMPJ4cMRSQIJR9jZc0Qepb+K9jPdLlCl1hgViSQkn3V
   0PZIkL7Km63UT1cb3r/n5QcFIlrj3Jbu5YYux+atIo812qvEX+fXZMvZb
   ynZCRKROPvkk69ESBsAbR2QTvbDsIy3P9nEFpIBUYjNHTFXtl4R09FT7P
   5jNrX2lW91QRDl2pF63KSFyjrE+Fi32Lh/TLQaxrltwp38xq+h6TwdAco
   +DvKVItz2B8z/qyViph5qKwtDC5dmpJiEVU+e83UL4FqDEg8Y4dy6LhId
   g==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643698800"; 
   d="scan'208";a="156389569"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 00:35:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 00:35:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 10 Mar 2022 00:35:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kchBuPX6BEtNgAxp8aZ8nQoi+qQP/Kau/auIW4imNZlz+UlVbLIwijviF1HSnSGCJydPraHyod6jyyRoVbU9suGTuy7H4Z4BheMUXouUBbZMnVUlPSVr2ikGC+9QHHu0zU4+ORacPeZMOrVIkm02DVH608c0jiZpzxdPc3Eo22Zz6hFrmKQzt4rAYMAqc8JQlHtyc5vT2H4UfQTPQ0rSXkR9beNxq2P6NG/brS7M/acw8PcGXXC0My1baaCJ2AonnLI6MjJ8rUfKsPqhTxpTX9GUXOLjBf8FVo3Rp6yNYUb3vgKBw0bqkUGCJ+wj21tgQNWg6kH3R+Jl/YwW/CjPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm7F1ycWimWoPgdgxQiSNpemLbbe1owf8sQ2j58BrTw=;
 b=Fg3S/IEmj9e+mBgXin7nX5oyDyTo/DlL+ySOloULn6XY4v9ju4i6OlKAnZUjHSmPAaerCY8pEshhmWVEsBxS9ETJPN5kqDL9I4eBO/NZTHO+jsesVri4RA7UkI0e4GpqhtGBP52UKSa6F8tVosif6o647WHiQXRgyFuoZnPo2sGyKwZvAo6rJSKKh7TMdkCq/sdVZVrfkBHpB608vAiRYlHBB0mp5bBq/JGX+376AX+XrAI6orwYZY91NKgtDaMeIpbSnDkVnxo+8+t6vUugC4zjnjQCaFRvJ4C+qjKpyNH4Ap0xXtjCaCNkAZBwU8GX5gnwKpFapVgVHTUUS5TnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm7F1ycWimWoPgdgxQiSNpemLbbe1owf8sQ2j58BrTw=;
 b=mXR7SoxcRFtZKiS/MwOSARzw51un3MNSEZa9odeiLNl3Sebwgwa+L+ulG7wIzxt1/BqjEmzmSgQInc20GJ8j7sDA5iPLeunlMEgcfxwpn9rVKioBlUYLQ3fVxR2CC35kZl0X6u7NyU5XqqpZ2jr3lirDLgn+U2rKPR1MBnI+hB0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BN6PR11MB0003.namprd11.prod.outlook.com (2603:10b6:405:61::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27; Thu, 10 Mar
 2022 07:35:47 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220%6]) with mapi id 15.20.5038.029; Thu, 10 Mar 2022
 07:35:47 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@dabbelt.com>, <sboyd@kernel.org>, <zong.li@sifive.com>
CC:     <Lewis.Hanly@microchip.com>, <Daire.McNamara@microchip.com>,
        <Ivan.Griffin@microchip.com>, <atishp@rivosinc.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <krzysztof.kozlowski@canonical.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 00/11] Update the Icicle Kit device tree
Thread-Topic: [PATCH v7 00/11] Update the Icicle Kit device tree
Thread-Index: AQHYIaqp+W4iZBWiDES2wjPp8VvjWqyhqgcAgBathoCAAAkIAA==
Date:   Thu, 10 Mar 2022 07:35:47 +0000
Message-ID: <e9287c9b-6ac7-dcb3-3b03-98bc83bbf119@microchip.com>
References: <mhng-bb42ad9f-5772-4749-97e1-9f6c511654f6@palmer-mbp2014>
In-Reply-To: <mhng-bb42ad9f-5772-4749-97e1-9f6c511654f6@palmer-mbp2014>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31ff85a6-098a-4e90-0778-08da026897ec
x-ms-traffictypediagnostic: BN6PR11MB0003:EE_
x-microsoft-antispam-prvs: <BN6PR11MB00030940D2A45F45D4D53517980B9@BN6PR11MB0003.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gn4Tbn6XsaIU3x/YSVGzpstmdXzool6pjcwqBi4XtnLAB1vxRI4w33l1zZ0jr/otDAJCKW6hyy7gTu88S3FBI66eP4uIu66H0irhls+psUKz/NLZD5vzMQwCYWJ4hOy5F28bA2cqztm7efc+m+UfKiaDYfC1s8vOOveJM7OWgx/IU111Imt3VOhu/+F7ZgLs+Krf28p3FyYSLIB44q+nEys/72oq8y5e9tilutMitDCg2Dp46soW0B9rAtYjvrCDts43LwlbfGIZH65Jt4s3Mkzu1/1oVVYDmRqPbCvtf1e8i6be/l17FxgGs8Y3dz0HO/zR3usLEYXKUo3tco0zLHzi8sNQvEjQTBBykoe6MYTaBUt6KY7Oo7BnZrKxDriAx+KPuk9zW0T6dNCW9US/eTo86mPCYSu5W2sp9FL58DFWXVSRvFevtGqFSL2eT3A38Z6DBuiRduSvP8kV8VHMkvn6i4YfdnIhEm+CHs694bb7Np5N2SCjC9OKCxrR1bX4ttfJrAZt4MHAJ9A6GyBNXrJuh8+ljZtWLcgPfXVmQP+O6sE9Ax72VEtaV/btKLD2tHGYhzqC1B3Gq8RdwAbcR08A7QGPK6/B90ab0538C4F4RwkiB9wXTL8rhbgU59rMVV7RXzI0iPoMpXJZp3OtJ1mMxGLHMafINsD9z0ex+CuzZdyIWBHHT6RilXaQ5JpJ7lUgY4BydGSOBvVMTKS/XvBlcY7OLISM3wMV9TY95TPRxSb4JZahxWCkuCzHKJoDTKL4BX35++orJAXq0yWdngi+RaJpKlkIiC4bVp+dWjCYXH/oPCj1K+hfdNUptVxTs9Odckzb9gC/G5ymLQxX8Zf17lNTotg/rGDI2s5xz7iN1PjQI3QE53BwV/s6h2Phjo+gfpdCFz2sVGgkJPn6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(86362001)(508600001)(966005)(8936002)(6512007)(186003)(31696002)(2616005)(26005)(7416002)(83380400001)(5660300002)(2906002)(15650500001)(53546011)(6506007)(66446008)(31686004)(66556008)(91956017)(76116006)(66476007)(64756008)(8676002)(71200400001)(4326008)(122000001)(316002)(110136005)(36756003)(38100700002)(54906003)(66946007)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjBpdEJERWE2bTZZYXJaRmlUeVhpQ1pjeFBmQ2g4SmEvQVJ2MTRReVh4eHov?=
 =?utf-8?B?bExRMXJGNmNCazRMWWhNbWhNMzErUjB1Nm9rTWh1RXlKdi9PVnVJTW5HSG1I?=
 =?utf-8?B?OWRUSkdtUnhOQ3BSa3lJdTRxdGJvL3d5OWdwTTNmUm1pOXhXTTdQNW5xcG14?=
 =?utf-8?B?a0U5cEFubjJkZ0lRQTBNUUFmdGhWNXo4WHZMU0cvKzJXaWgwWVMyQkU2eEdv?=
 =?utf-8?B?TjY4Y3l6ZSthMHRsK01zcGFBblA4OElkN2hUUlU0WnN1eTFrek5XemFqQ28r?=
 =?utf-8?B?dUxYR3pHZEdHK2Y1WGMrQWdZSFYwYUxQVG1lY3RJQkpFVHRCL0VVWnlPK3RB?=
 =?utf-8?B?TzVvNDgxK3hRMzRWT20xSnA0cUlqNlhXNDc1UWs0L0pkU2xjQUlNWGZMOEp0?=
 =?utf-8?B?RU1rNlhVejlDWXJQVWI5SHdqUGhRb3pscWpjT0FSVWdIb0ZlWUhkN1JiVDhL?=
 =?utf-8?B?aElHNFk0UlkwZmk5aEU5Qzk0UmxULzhZWldUelkvc1h5anl0VjFKWHZNUXkw?=
 =?utf-8?B?anlHMHY4WHc1aEQ4RGpieWdVQ21sY0dNREsrdUFLcTVLakduWXV1VThhOENS?=
 =?utf-8?B?RkNWUTFNR2xFampIUEhzckJkVW51TisrUWpHenFyeEg0YjdMR0RrMFJQNDFT?=
 =?utf-8?B?dnlZcHRvUGM2Ykc2MEYzWEpOc2dvQWQ2MnZCbFBhc0JUZHhicktmb0NSTzlH?=
 =?utf-8?B?ZkN6OWRvRVl4SU5Yc2x0NSs2YXZla3lCUHBEdytCb0JJRHd6aG4wbElxVGl2?=
 =?utf-8?B?MFBKMUZtaHo4SGpvWE9mUXZpSXBxQUdEcVpDVXpqMUZ5b055Q3dQTzlrNFk3?=
 =?utf-8?B?YnY1MWF5UzJrTzcwczh2MkVmdWY0RW5BclJpeGtwMFBaa2J6MTJ6M2UzOGhN?=
 =?utf-8?B?TWFUN2hoVlFGTUluQ3VPLyt0TTF0a1NRTXpmcVd5dG1mTzJhMmFxalJpSDJi?=
 =?utf-8?B?NVVLc2ZwcGNjZ3Zkb0w0RjFtU2VvcXdFZUs1alNtUDR5enB1RUVVRmY3R2pC?=
 =?utf-8?B?aTZrMmhNdFp6eDQ2SytnN3IrVW50VnljajVqS1IrVG1uZWl3ZTIyaGN5L2Nr?=
 =?utf-8?B?TlRVMVUrVkVwc2JlUEhhMjZibkJOSCtYZUh2WlQ0emx6V0RKRWgvTy9ZYytR?=
 =?utf-8?B?T2RzYnZ4ajQ3a2FtVityanN1NThhZmIwa3pycTY0NTF2Zjl3N2xvQXFxdVpj?=
 =?utf-8?B?dTVlRkpua0VVemtEQXRDdEd0Ni9WdXVjc0pYSEJGa29yeXd0L2gvUFVpRzJo?=
 =?utf-8?B?SjlzdWxkdmlHUkZDbHEyZU9PQUtjVG4vcmFrVW9IZklYd0pDUWNEblBISWhH?=
 =?utf-8?B?N1dRbUFSMElQZU1RVkhIY1MyS1JSczdaS3B1Z2FtbE03RnprR3F3VzVYNUdp?=
 =?utf-8?B?RS9YVHJVUlRqQ2QvMkJiN3pZQ012UGlXRmRmbFhEWjhGeE1VeHlMU2RJOFhS?=
 =?utf-8?B?YnloU3B0SGpRTHdXbU5qR0pqVEozOGZoQTZ0S0pEcDBmdHdRb1NNQm4rRlRj?=
 =?utf-8?B?a01qcTgwaVdrZno2WXFUVk90R2F1enhVNDdWOUxxSjZ1RjMyc3dCZWxNUVor?=
 =?utf-8?B?azVmanlQc3BBSkVGNVBzcTdJZzBHenRUNGJ2U3pNOVl4SUNDLzE3VUFOdHEw?=
 =?utf-8?B?ZUxEd3JqZzhPWUpDTW90cHpROVhCbytsSHdNMTRuZTBzNXZiTFFDUms3UXdh?=
 =?utf-8?B?eFI4UlR5UEJRZUNyR3UvbXVwNkZEQ3JuYjVUdS9NaDdZZG9zR2svMUdCUWg2?=
 =?utf-8?B?UmZhZ0U0SzM1djVmU1k2cUFzQ1VvTUJVcmFvM29UTDdpVlc5WXQxTFd5TUwz?=
 =?utf-8?B?KzQybEVlSUtyemcwKzA3eG9sN0s4eUk1eFloZlZFSGd2UVRVaDZxZHpIMFZz?=
 =?utf-8?B?L3BRcndaNVM3TkZJUGZEa2hiK0V3WkRsWStlNE55U1FzejN2T29GNG9lczRJ?=
 =?utf-8?B?dy9rUForSVpMbGVUbzkyMm96L05JbmN5K1hXalE3em5GUWdyaHRleXhsYmh6?=
 =?utf-8?B?VzBwbnZKT3ZlQWVlR3FEQWcwcE1lckszY0NlU1pzNkZLL1dIc1VGcDBrVWdq?=
 =?utf-8?B?MFhKS0ZReEI2Zmx4emZtSUJHakQ1MGRsSUpEczlPcUsxWUNsUVF2WTlZU3VG?=
 =?utf-8?B?NTJlb3VnVTF6UWJpRXkrMzFtYlBxUWgyZmJMUXZ4dEo5ZkF0SlZUVFU5M0pD?=
 =?utf-8?B?blIwZlp4UCtOeWtyNW5IT0M0THRzTFF4ODhDZmpCcTlUNFo3THZjNU9uYVhY?=
 =?utf-8?B?bGIzSWJHNVRnQ0lReDJOYVBkS0R3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B1E4F24CECFF642B4DF895E216D5D9B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ff85a6-098a-4e90-0778-08da026897ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 07:35:47.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yz6lrIu7SqoZj6Ag77nTG83GhVBZ+FlFHtlzkmE5pBT8jWKyAgClLZzVnV5BysI9LW/jLTEgx8TST+hwaqCANoVm1/nh+LOpe3Ye2dWLiEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0003
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDMvMjAyMiAwNzowNywgUGFsbWVyIERhYmJlbHQgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCAyMyBGZWIgMjAyMiAxMjo0ODox
NiBQU1QgKC0wODAwKSwgbWFpbEBjb25jaHVvZC5pZSB3cm90ZToNCj4+IE9uIDE0LzAyLzIwMjIg
MTM6NTgsIGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+IEZyb206IENvbm9y
IERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4NCj4+PiBUaGlzIHNlcmll
cyB1cGRhdGVzIHRoZSBNaWNyb2NoaXAgSWNpY2xlIEtpdCBkZXZpY2UgdHJlZSBieSBhZGRpbmcg
YQ0KPj4+IGhvc3Qgb2YgcGVyaXBoZXJhbHMsIGFuZCBzb21lIHVwZGF0ZXMgdG8gdGhlIG1lbW9y
eSBtYXAuIEluIGFkZGl0aW9uLA0KPj4+IHRoZSBkZXZpY2UgdHJlZSBoYXMgYmVlbiBzcGxpdCBp
bnRvIGEgdGhpcmQgcGFydCwgd2hpY2ggY29udGFpbnMgInNvZnQiDQo+Pj4gcGVyaXBoZXJhbHMg
dGhhdCBhcmUgaW4gdGhlIGZwZ2EgZmFicmljLg0KPj4+DQo+Pj4gU2V2ZXJhbCBvZiB0aGUgZW50
cmllcyBhcmUgZm9yIHBlcmlwaGVyYWxzIHRoYXQgaGF2ZSBub3QgZ2V0IGhhZCB0aGVpcg0KPj4+
IGRyaXZlcnMgdXBzdHJlYW1lZCwgc28gaW4gdGhvc2UgY2FzZXMgdGhlIGR0IGJpbmRpbmdzIGFy
ZSBpbmNsdWRlZCB3aGVyZQ0KPj4+IGFwcHJvcHJpYXRlIGluIG9yZGVyIHRvIGF2b2lkIHRoZSBt
YW55ICJEVCBjb21wYXRpYmxlIHN0cmluZyA8eD4gYXBwZWFycw0KPj4+IHVuLWRvY3VtZW50ZWQi
IGVycm9ycy4NCj4+Pg0KPj4+IERlcGVuZHMgb24gbXBmcyBjbG9jayBkcml2ZXIgYmluZGluZyAo
b24gY2xrL25leHQpIHRvIHByb3ZpZGUNCj4+PiBkdC1iaW5kaW5ncy9jbG9jay9taWNyb2NoaXAs
bXBmcy1jbG9jay5oIGZvciB0aGUgZGV2aWNlIHRyZWUNCj4+PiBhbmQgb24gdGhlIG90aGVyIGNo
YW5nZXMgdG8gdGhlIGljaWNsZS9tcGZzIGRldmljZSB0cmVlIGZyb20gZ2VlcnQNCj4+PiB0aGF0
IGFyZSBhbHJlYWR5IGluIGxpbnV4L3Jpc2N2L2Zvci1uZXh0Lg0KPiANCj4gU28gdGhhdCdzIGNh
dXNpbmcgdGhpcyB0byBub3QgYnVpbGQsIGFzIEkgY2FuJ3QgYnVpbGQgd2l0aG91dCB0aGUNCj4g
aGVhZGVyLsKgIEkgd2VudCBhaGVhZCBhbmQgcHV0IHRoZXNlIG9uIHRvcCBvZiB0aGF0IHBhdGNo
LCByZXN1bHRpbmcgaW4NCj4gDQo+ICDCoMKgICogNDhlODY0MWMyYmYwIC0gKEhFQUQgLT4gcmlz
Y3YtbWljcm9jaGlwLCBwYWxtZXIvcmlzY3YtbWljcm9jaGlwKSBNQUlOVEFJTkVSUzogdXBkYXRl
IHJpc2N2L21pY3JvY2hpcCBlbnRyeSAoMiBtaW51dGVzIGFnbykgPENvbm9yIERvb2xleT4NCj4g
IMKgwqAgKiA1MjhhNWIxZjI1NTYgLSByaXNjdjogZHRzOiBtaWNyb2NoaXA6IGFkZCBuZXcgcGVy
aXBoZXJhbHMgdG8gaWNpY2xlIGtpdCBkZXZpY2UgdHJlZSAoMiBtaW51dGVzIGFnbykgPENvbm9y
IERvb2xleT4NCj4gIMKgwqAgKiA1YjI4ZGYzN2QzMTEgLSByaXNjdjogZHRzOiBtaWNyb2NoaXA6
IHVwZGF0ZSBwZXJpcGhlcmFscyBpbiBpY2ljbGUga2l0IGRldmljZSB0cmVlICgyIG1pbnV0ZXMg
YWdvKSA8Q29ub3IgRG9vbGV5Pg0KPiAgwqDCoCAqIGM1MDk0ZjM3MTAwOCAtIHJpc2N2OiBkdHM6
IG1pY3JvY2hpcDogcmVmYWN0b3IgaWNpY2xlIGtpdCBkZXZpY2UgdHJlZSAoMiBtaW51dGVzIGFn
bykgPENvbm9yIERvb2xleT4NCj4gIMKgwqAgKiA3MjU2MGM2NTU5YjggLSByaXNjdjogZHRzOiBt
aWNyb2NoaXA6IGFkZCBmcGdhIGZhYnJpYyBzZWN0aW9uIHRvIGljaWNsZSBraXQgKDIgbWludXRl
cyBhZ28pIDxDb25vciBEb29sZXk+DQo+ICDCoMKgICogNjU0NmY5MjA4NjhlIC0gcmlzY3Y6IGR0
czogbWljcm9jaGlwOiB1c2UgY2xrIGRlZmluZXMgZm9yIGljaWNsZSBraXQgKDIgbWludXRlcyBh
Z28pIDxDb25vciBEb29sZXk+DQo+ICDCoMKgICogZGY3N2Y3NzM1Nzg2IC0gZHQtYmluZGluZ3M6
IHB3bTogYWRkIG1pY3JvY2hpcCBjb3JlcHdtIGJpbmRpbmcgKDIgbWludXRlcyBhZ28pIDxDb25v
ciBEb29sZXk+DQo+ICDCoMKgICogNzM1ODA2ZDhhNjhlIC0gZHQtYmluZGluZ3M6IGdwaW86IGFk
ZCBiaW5kaW5ncyBmb3IgbWljcm9jaGlwIG1wZnMgZ3BpbyAoMiBtaW51dGVzIGFnbykgPENvbm9y
IERvb2xleT4NCj4gIMKgwqAgKiA0Y2JjYzBkN2IzOTcgLSBkdC1iaW5kaW5nczogcnRjOiBhZGQg
YmluZGluZ3MgZm9yIG1pY3JvY2hpcCBtcGZzIHJ0YyAoMiBtaW51dGVzIGFnbykgPENvbm9yIERv
b2xleT4NCj4gIMKgwqAgKiBiNDM1YTE3MjhjOWYgLSBkdC1iaW5kaW5nczogc29jL21pY3JvY2hp
cDogYWRkIGluZm8gYWJvdXQgc2VydmljZXMgdG8gbXBmcyBzeXNjdHJsICgyIG1pbnV0ZXMgYWdv
KSA8Q29ub3IgRG9vbGV5Pg0KPiAgwqDCoCAqIDIxMzU1NjIzNTUyNiAtIGR0LWJpbmRpbmdzOiBz
b2MvbWljcm9jaGlwOiB1cGRhdGUgc3lzY29udHJvbGxlciBjb21wYXRpYmxlcyAoMiBtaW51dGVz
IGFnbykgPENvbm9yIERvb2xleT4NCj4gIMKgwqAgKiAyMTQ1YmI2ODdlM2YgLSAoY2xrL2Nsay1t
aWNyb2NoaXApIGR0LWJpbmRpbmdzOiBjbGs6IG1pY3JvY2hpcDogQWRkIE1pY3JvY2hpcCBQb2xh
ckZpcmUgaG9zdCBiaW5kaW5nICg2IHdlZWtzIGFnbykgPERhaXJlIE1jTmFtYXJhPg0KPiAgwqDC
oCAqIGU3ODMzNjJlYjU0YyAtICh0YWc6IHY1LjE3LXJjMSkgTGludXggNS4xNy1yYzEgKDcgd2Vl
a3MgYWdvKSA8TGludXMgVG9ydmFsZHM+DQo+IA0KPiBzYm95ZDogSUlSQyBpdCdzIE9LIHRvIGNv
bnNpZGVyIGNsay1taWNyb2NoaXAgYXMgYSBzdGFibGUgYnJhbmNoP8KgIElmDQo+IG5vdCBJIGNh
biBqdXN0IHdhaXQgdW50aWwgeW91IHNlbmQgeW91ciBQUiB0byBMaW51cyBhbmQgc2VuZCB0aGlz
IGxhdGVyDQo+IGluIHRoZSBtZXJnZSB3aW5kb3csIG5vIGJpZyBkZWFsIG9uIG15IGVuZC4NCj4g
DQo+IEkndmUgcHV0IHRoaXMgb24gZm9yLW5leHQuwqAgSWYgdGhhdCdzIGEgcHJvYmxlbSBsZXQg
bWUga25vdyBhbmQgSSdsbA0KPiBkZWxheSBpdC4NCkdyZWF0LCB0aGFua3MhIFByb2JhYmx5IHdv
cnRoIG1lbnRpb25pbmcgdGhhdCBJJ3ZlIGRlbGV0ZWQgdGhlIGRtYSBub2RlDQp0aGF0IFpvbmcg
TGkgaXMgbW9kaWZ5aW5nIGluIGhpcyBwZG1hIHBhdGNoc2V0Lg0KDQo+IA0KPiBUaGFua3MhDQo+
IA0KPj4+DQo+Pj4gQWRkaXRpb25hbGx5LCB0aGUgaW50ZXJydXB0LWV4dGVuZGVkIHdhcm5pbmdz
IG9uIHRoZSBwbGljL2NsaW50IGFyZQ0KPj4+IGNsZWFyZWQgYnkgWzFdICYgWzJdLg0KPj4+DQo+
Pj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2L2NvdmVyLjE2Mzk3NDQ0
NjguZ2l0LmdlZXJ0QGxpbnV4LW02OGsub3JnLw0KPj4+IFsyXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1yaXNjdi9jb3Zlci4xNjM5NzQ0MTA2LmdpdC5nZWVydEBsaW51eC1tNjhrLm9y
Zy8NCj4+DQo+PiBIZXkgUGFsbWVyLA0KPj4NCj4+IGR0LWJpbmRpbmdzIHNob3VsZCBiZSBzZXQg
bm93LCBzbyBpZiB5b3UncmUgc3RpbGwgaGFwcHkgdG8gdGFrZSB0aGUNCj4+IHNlcmllcyB2aWEg
cmlzY3YsIHRoYXQnZCBiZSBncmVhdC4gaTJjLCBzcGkgJiB1c2IgcGF0Y2hlcyBlbmRlZCBnb2lu
Zw0KPj4gdmlhIHRoZSBzdWItc3lzdGVtIHRyZWVzIChhbmQgaGF2ZSBiZWVuIGRyb3BwZWQgZnJv
bSB0aGUgc2VyaWVzKSwgaW4NCj4+IGNhc2UgdGhvc2UgZ2VuZXJhdGUgd2FybmluZ3MgZm9yIHlv
dS4NCj4gDQo+IFNvbWV0aGluZyB3ZW50IG9mZiB0aGUgcmFpbHMgaW4gZW1haWwgbGFuZCBhbmQg
IzAgYW5kICMyIGRpZG4ndCBlbmQgdXANCj4gaW4gbXkgcGF0Y2ggcXVldWUgYnV0IHRoZSByZXN0
IGRpZC7CoCBMdWNraWx5IGVub3VnaCBtYWRlIGl0IHRocm91Z2ggdGhhdA0KPiBpdCBkaWRuJ3Qg
Z2V0IGxvc3QsIGFuZCBsb3JlJ3MgcHJldHR5IGdyZWF0IHNvIHRoaXMgc29ydCBvZiB0aGluZyBp
c24ndA0KPiB0aGF0IGJpZyBvZiBhIGRlYWwgdGhlc2UgZGF5cy7CoCBUaGF0IHNhaWQsIGVtYWls
IGlzIGEgYml0IG9mIGEgYmxhY2sgYm94DQo+IHNvIGZpZ3VyZWQgSSdkIGdpdmUgeW91IGEgaGVh
ZHMgdXAuDQoNCkh1aCwgaW50ZXJlc3RpbmcuIEkgZG8gY2hlY2sgYWZ0ZXIgc2VuZGluZyB0aGF0
IEkgY2FuIHNlZSB0aGUgbWFpbHMgaW4gbXkNCm90aGVyIGVtYWlsJ3MgaW5ib3ggJiB0aGV5J3Jl
IHRoZXJlLiBHdWVzcyBnb29kIHRoaW5nIHRoYXQgSSBzZW50IHRoZSBmb2xsb3cgdXAuDQpUaGFu
a3MsDQpDb25vci4NCg0KPiANCj4+DQo+PiBUaGFua3MsDQo+PiBDb25vci4NCj4+Pg0KPj4+IENo
YW5nZXMgZnJvbSB2NjoNCj4+PiAtIERyb3BwZWQgaTJjIHBhdGNoLCBhcyBpdHMgaW4gaTJjLW5l
eHQNCj4+PiAtIEFkZGVkIGFjayBvbiBncGlvLCByZXZpZXdlZC1ieSBvbiBydGMNCj4+PiAtIERy
b3BwZWQgY2hpbGQgbm9kZXMgZnJvbSBzeXNjdHJsIGJpbmRpbmcgZW50aXJlbHksIGFkZGVkIGEg
bGluayB0bw0KPj4+IMKgwqAgdGhlIG9ubGluZSBkb2N1bWVuYXRpb24gZm9yIHRoZSBzZXJ2aWNl
cyB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgY2FuDQo+Pj4gwqDCoCBwcm92aWRlDQo+Pj4gLSBEcm9w
cGVkIHRoZSAjcHdtLWNlbGxzIGFuZCByZXBsYWNlZCB3aXRoIGEgcmVmLCBhIGxhIEtyenlzenRv
ZidzDQo+Pj4gwqDCoCBzZXJpZXMNCj4+Pg0KPj4+IENoYW5nZXMgZnJvbSB2NToNCj4+PiAtIHJl
d29yZGVkIHRoZSBkZXNjcmlwdGlvbnMgaW4gdGhlIHB3bSBiaW5kaW5nIHRvIChob3BlZnVsbHkp
IGFkZA0KPj4+IMKgwqAgY2xhcml0eQ0KPj4+IC0gYWRkZWQgLW1hc2sgdG8gdGhlIGN1c3RvbSBw
cm9wZXJ0aWVzIGFuZCBtYWRlIHRoZW0gMzIgYml0DQo+Pj4gLSByZW5hbWVkIHRoZSBpMmMgYmlu
ZGluZyB0byBjb3JlaTJjLCBzaW5jZSBpdCBpcyBub3QgbXBmcyBzcGVjaWZpYw0KPj4+IC0gcmVt
b3ZlZCB0aGUgY2hpbGQgbm9kZXMgb2YgdGhlIHN5c3RlbSBjb250cm9sbGVyIGluIGV4YW1wbGUv
ZHRzICYNCj4+PiDCoMKgIHdpbGwgY3JlYXRlIHRoZW0gaW4gdGhlIGRyaXZlci4NCj4+PiDCoMKg
IEBSb2IsIEkgYXNzdW1lIGtlZXBpbmcgdGhlbSBkb2N1bWVudGVkIGlzIHRoZSBjb3JyZWN0IHRo
aW5nIHRvIGRvPw0KPj4+IC0gcmVtb3ZlZCB0aGUgZGVwZW5kYW5jeSBvbiB0aGUgY2xvY2sgYmlu
ZGluZyBmcm9tIHRoZSBleGFtcGxlcw0KPj4+IC0gcmVmb3JtYXR0ZWQgcnRjIGludGVycnVwdHMg
YXMgcGVyIFJvYidzIHN1Z2dlc3Rpb24NCj4+Pg0KPj4+IENoYW5nZXMgZnJvbSB2NDoNCj4+PiAt
IGRvbnQgaW5jbHVkZSBpY2ljbGVfa2l0X2RlZmNvbmZpZywgYWNjaWRlbnRhbGx5IGFkZGVkIGlu
IHYzDQo+Pj4gLSBkcm9wIHByZXNjYWxlciBmcm9tIG1wZnMtcnRjICYgY2FsY3VsYXRlIHRoZSB2
YWx1ZSBpbnN0ZWFkDQo+Pj4gLSB1c2UgY29yZWkyYyBhcyBhIGZhbGxiYWNrIGRldmljZSBmb3Ig
bXBmcy1pMmMNCj4+PiAtIGRyb3Agc3BpIGR0LWJpbmRpbmcgKG9uIHNwaS1uZXh0KQ0KPj4+IMKg
wqAgY29tbWl0IDJkYTE4NzMwNGU1NTZhYzU5Y2YyZGFjYjMyM2NjNzhkZWQ5ODgxNjkNCj4+PiAt
IGRyb3AgdXNiIGR0LWJpbmRpbmcgKG9uIHVzYi1uZXh0KQ0KPj4+DQo+Pj4gQ2hhbmdlcyBmcm9t
IHYzOg0KPj4+IC0gZHJvcCAibWFpbGJveDogY2hhbmdlIG1haWxib3gtbXBmcyBjb21wYXRpYmxl
IHN0cmluZyIsIGFscmVhZHkgdXBzdHJlYW06DQo+Pj4gwqDCoCBjb21taXQgZjEwYjFmYzAxNjFj
ZDk5ZSAoIm1haWxib3g6IGNoYW5nZSBtYWlsYm94LW1wZnMgY29tcGF0aWJsZSBzdHJpbmciKQ0K
Pj4+IC0gZml4IGNvcHkgcGFzdGUgZXJyb3IgaW4gbWljcm9jaGlwLG1wZnMtbWFpbGJveCBkdC1i
aW5kaW5nDQo+Pj4gLSByZW1vdmUgd2hpdGVzcGFjZSBpbiBzeXNjb250cm9sbGVyIGR0IGVudHJ5
DQo+Pj4NCj4+PiBDaGFuZ2VzIGZyb20gdjI6DQo+Pj4gLSBkcm9wcGVkIHBsaWMgaW50IGhlYWRl
ciAmIGNvcnJlc3BvbmRpbmcgZGVmaW5lcyBpbiBkdHN7LGl9DQo+Pj4gLSB1c2UgJHJlZiB0byBk
cm1vZGUgaW4gbXBmcy1tdXNiIGJpbmRpbmcNCj4+PiAtIHNwbGl0IGNoYW5nZXMgdG8gZHRzeyxp
fSBhZ2FpbjogZnVuY3Rpb25hbCBjaGFuZ2VzIHRvIGV4aXN0aW5nDQo+Pj4gwqDCoCBlbGVtZW50
cyBub3cgYXJlIGluIGEgbmV3IHBhdGNoDQo+Pj4gLSBkcm9wIG51bS1jcyBwcm9wZXJ0eSBpbiBt
cGZzLXNwaSBiaW5kaW5nDQo+Pj4gLSBkb250IG1ha2UgdGhlIHN5c3RlbSBjb250cm9sbGVyIGEg
c2ltcGxlLW1mZA0KPj4+IC0gbW92ZSB0aGUgc2VwYXJhdGUgYmluZGluZ3MgZm9yIHJuZy9nZW5l
cmljIHN5c3RlbSBzZXJ2aWNlcyBpbnRvIHRoZQ0KPj4+IMKgwqAgc3lzdGVtIGNvbnRyb2xsZXIg
YmluZGluZw0KPj4+IC0gYWRkZWQgYW4gaW5zdGFuY2UgY29yZWkyYyBhcyBpMmMyIGluIHRoZSBm
YWJyaWMgZHRzaQ0KPj4+IC0gYWRkIHZlcnNpb24gbnVtYmVyaW5nIHRvIGNvcmVwd20gYW5kIGNv
cmVpMmMgY29tcGF0IHN0cmluZyAoLXJ0bC12TikNCj4+Pg0KPj4+IENvbm9yIERvb2xleSAoMTEp
Og0KPj4+IMKgwqAgZHQtYmluZGluZ3M6IHNvYy9taWNyb2NoaXA6IHVwZGF0ZSBzeXNjb250cm9s
bGVyIGNvbXBhdGlibGVzDQo+Pj4gwqDCoCBkdC1iaW5kaW5nczogc29jL21pY3JvY2hpcDogYWRk
IGluZm8gYWJvdXQgc2VydmljZXMgdG8gbXBmcyBzeXNjdHJsDQo+Pj4gwqDCoCBkdC1iaW5kaW5n
czogcnRjOiBhZGQgYmluZGluZ3MgZm9yIG1pY3JvY2hpcCBtcGZzIHJ0Yw0KPj4+IMKgwqAgZHQt
YmluZGluZ3M6IGdwaW86IGFkZCBiaW5kaW5ncyBmb3IgbWljcm9jaGlwIG1wZnMgZ3Bpbw0KPj4+
IMKgwqAgZHQtYmluZGluZ3M6IHB3bTogYWRkIG1pY3JvY2hpcCBjb3JlcHdtIGJpbmRpbmcNCj4+
PiDCoMKgIHJpc2N2OiBkdHM6IG1pY3JvY2hpcDogdXNlIGNsayBkZWZpbmVzIGZvciBpY2ljbGUg
a2l0DQo+Pj4gwqDCoCByaXNjdjogZHRzOiBtaWNyb2NoaXA6IGFkZCBmcGdhIGZhYnJpYyBzZWN0
aW9uIHRvIGljaWNsZSBraXQNCj4+PiDCoMKgIHJpc2N2OiBkdHM6IG1pY3JvY2hpcDogcmVmYWN0
b3IgaWNpY2xlIGtpdCBkZXZpY2UgdHJlZQ0KPj4+IMKgwqAgcmlzY3Y6IGR0czogbWljcm9jaGlw
OiB1cGRhdGUgcGVyaXBoZXJhbHMgaW4gaWNpY2xlIGtpdCBkZXZpY2UgdHJlZQ0KPj4+IMKgwqAg
cmlzY3Y6IGR0czogbWljcm9jaGlwOiBhZGQgbmV3IHBlcmlwaGVyYWxzIHRvIGljaWNsZSBraXQg
ZGV2aWNlIHRyZWUNCj4+PiDCoMKgIE1BSU5UQUlORVJTOiB1cGRhdGUgcmlzY3YvbWljcm9jaGlw
IGVudHJ5DQo+Pj4NCj4+PiDCoCAuLi4vYmluZGluZ3MvZ3Bpby9taWNyb2NoaXAsbXBmcy1ncGlv
LnlhbWzCoMKgwqAgfMKgIDc5ICsrKysrKw0KPj4+IMKgIC4uLmlsYm94LnlhbWwgPT4gbWljcm9j
aGlwLG1wZnMtbWFpbGJveC55YW1sfSB8wqDCoCA2ICstDQo+Pj4gwqAgLi4uL2JpbmRpbmdzL3B3
bS9taWNyb2NoaXAsY29yZXB3bS55YW1swqDCoMKgwqDCoMKgIHzCoCA4MSArKysrKysNCj4+PiDC
oCAuLi4vYmluZGluZ3MvcnRjL21pY3JvY2hpcCxtZnBzLXJ0Yy55YW1swqDCoMKgwqDCoCB8wqAg
NTggKysrKw0KPj4+IMKgIC4uLi9taWNyb2NoaXAsbXBmcy1zeXMtY29udHJvbGxlci55YW1swqDC
oMKgwqDCoMKgwqAgfMKgIDQwICsrKw0KPj4+IMKgIC4uLmljcm9jaGlwLHBvbGFyZmlyZS1zb2Mt
c3lzLWNvbnRyb2xsZXIueWFtbCB8wqAgMzUgLS0tDQo+Pj4gwqAgTUFJTlRBSU5FUlPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAyICsNCj4+PiDCoCAuLi4vZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1m
YWJyaWMuZHRzacKgIHzCoCAyNSArKw0KPj4+IMKgIC4uLi9taWNyb2NoaXAvbWljcm9jaGlwLW1w
ZnMtaWNpY2xlLWtpdC5kdHPCoMKgIHwgMTE1ICsrKysrKy0tDQo+Pj4gwqAgLi4uL2Jvb3QvZHRz
L21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpwqDCoMKgIHwgMjU0ICsrKysrKysrKysrKysr
LS0tLQ0KPj4+IMKgIDEwIGZpbGVzIGNoYW5nZWQsIDU5MSBpbnNlcnRpb25zKCspLCAxMDQgZGVs
ZXRpb25zKC0pDQo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncGlvL21pY3JvY2hpcCxtcGZzLWdwaW8ueWFtbA0KPj4+IMKgIHJlbmFt
ZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC97bWljcm9jaGlwLHBv
bGFyZmlyZS1zb2MtbWFpbGJveC55YW1sID0+IG1pY3JvY2hpcCxtcGZzLW1haWxib3gueWFtbH0g
KDgyJSkNCj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3B3bS9taWNyb2NoaXAsY29yZXB3bS55YW1sDQo+Pj4gwqAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvbWljcm9jaGlwLG1m
cHMtcnRjLnlhbWwNCj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xs
ZXIueWFtbA0KPj4+IMKgIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc29jL21pY3JvY2hpcC9taWNyb2NoaXAscG9sYXJmaXJlLXNvYy1zeXMtY29u
dHJvbGxlci55YW1sDQo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9k
dHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWZhYnJpYy5kdHNpDQo+Pj4NCg0K
