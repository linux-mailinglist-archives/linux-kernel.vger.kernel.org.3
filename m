Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD188551F90
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiFTO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243444AbiFTO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:58:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45571E3D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655734932; x=1687270932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DLYU3obuw2FzjjH17NUxRUoMUaCXSbi6YD3GQAGoHgY=;
  b=bJ4WLhW7Mdido7J3wl3Nzis9pvdexJWydi/KTnXGHPamEBxDUYdVMSzJ
   g1yEDuD1e1S4a/rAbnpIBCGWqJh/lcovRMEWQEtNGUYhC97tpnLm4/j2g
   lzFSe+J5NQvUJrfkQvZM8Naol/3vdFGWKwNO/dMA7NtW8jA3omLjJ3EP3
   pE06W03KPielc1+Vz15L5YLE896D7h/t4nAr24S7zZB+HUkqM8/f8zKYL
   Jm1p+u5A0u6MgjK32pzCZy7VHlReybliikFaNFPA3yXqplCxbk/2GQl8A
   LNfIvYgzjmRDPv3n57dyOfJ1zza5p2dOkubFILPn5uKS5J6qzzr/G+bR7
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="164179403"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 07:22:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 07:22:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 20 Jun 2022 07:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZz4tSej81j4d3ly2ygR+Hgep1h2a1IBNwZOiT0zb1FJy8uESDSbLHmDaa74HgREB+5hsMM4mKCMKieNBDQE8TnDJK+q6X6kC7YSX0GyXQXziYIurB9r9qhAigt4nfB5uV2dKFzvNuyQ5BDOxEvPegdXyCauDu0gBcuO2Z/jXbXDO0ozpXcxetKAVgY+dH/jLLMDUZT+4KSUCgr5szQfUqgIDTfZCLNhVXTYJGPWWDSfuksJpdVmnXlmd5Atl7Fue7NKeEt5zRoFPdALszb3dsDTbtWsI7JbjVc4OHZGPRwYKLuIjyBx5TAyHJ3DEhexbXldMBfZjzdoxbOmwjpnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLYU3obuw2FzjjH17NUxRUoMUaCXSbi6YD3GQAGoHgY=;
 b=PdEXiL17zG7xU4m9eTeNIZxzADfxBkkZ7ZZ4dwsNr+Tl6isoysTymqQuqfVecdRmDt1VCs7H97vLLRiFXRGDc4FU+RNv5zv3ujDzfVuE9QGsN3R9SdNUeCVjh894haObUo91OLiEWJhzDcvZEUPZU5shha2w0D2ATSefDhJQyMSjJ5/mnlQ8iyBKtVftzg5J0Mqxevm9yJHNMcfB8ddXcmrjiiceTapDk7YtAXb/OVK0rcIUovACpFbXEaXzO+Iq4N08GsTfcNd6PCIAh6zw80faTMjy2RdjsZCAW3u2u/GTX82+DzpvixNEL9gn/WaVEgntgyi9lDVGPnHNVQoB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLYU3obuw2FzjjH17NUxRUoMUaCXSbi6YD3GQAGoHgY=;
 b=Hd3Zb6ijeJHtc4z6J69kd4hShtjYAEdV4oIqYeZ3+ZoHIRnvieVkzrfDWg6WedRzBa9BPVZNj205QSz1wokr9J5oyFnzumurGWeo/zhN6pDGDp+1WW1fXOsWsy/5dVpR64Jlqw/4IL3iJPeSYbVf41Tn0EhAu3ZdRfEe553QMjw=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CH0PR11MB5753.namprd11.prod.outlook.com (2603:10b6:610:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 14:22:03 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5353.014; Mon, 20 Jun 2022
 14:22:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <regressions@leemhuis.info>, <peda@axentia.se>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSf61ZAsYA
Date:   Mon, 20 Jun 2022 14:22:02 +0000
Message-ID: <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
In-Reply-To: <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd7d99db-91d5-494e-cbbe-08da52c83efe
x-ms-traffictypediagnostic: CH0PR11MB5753:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5753343FFCB94198BBDB07A7F0B09@CH0PR11MB5753.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWYILedbYUqJctohu32H9yzErP68vUh4HMyUReVQB6o6Mo4fPZAW6FJ/ObFwUGZgiyhk4rbcTY1dDfASMyZlcXgzGxOawiykVe+HUAVcMv9CN38UKEc7A/CTifs4u+1krxhPmoJkuhJ/YjYYsosk5+36+Tj2I080Yf5imyiI1qvaiE5qPDNolFcKFD7PXmLW+IVy0N9zt6HAejHBFYNEU4+LG87h/P25lmiw86Uh+qDSt9miCMY/q7hxZFt7AkyAerTpOtkxq0702EoYIciTuzBNuYGjrszfafbzb6Qv765rI/LEkuU61hfTYDsFRr4xSxHG8a7BKojUQ79cvndTLGoM+73LIGKdgiDS27YkLgbgldiC9UCT72HFO/ixJx25mfvVM5FV0zVSmw5anFsv0mxZI4ValFfz3zTzk1cG+44wf3aMLunRd5Zwqb2vKNWWtUtodBaMH5s1iWxqtUdwNWmkpouGmAziQ/iCFD5wlKGJp0DNCslqjPmKbqLC02z6x1F5HHzmjDinmCZutdKsKQoMEhYm2wFMxocnCaRtQpUsu0TQpJiy4EEYAaUkNBK1ijr22bCAzQOHKeSpVGcgO9yKF6AkD9pyl1/KKhZZCSqFnGUEjD4YALx30LuJuoc3111nlxquA2YHp/EW39mEVAV6db2LO0DF1eXK/08CivzZLsvXbRy7cRtMWvVu9hbh+oTkBr8Enqw5L8kdbF/u/k9N5S1BaV09xovAg7j5gk7lQWRVnh+IKA6LO1UMUcuX37p6q3M+royqJJwxoD0z6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(136003)(346002)(376002)(38100700002)(6506007)(4326008)(8676002)(6512007)(31686004)(26005)(478600001)(110136005)(8936002)(2906002)(31696002)(86362001)(66556008)(76116006)(6486002)(38070700005)(4744005)(186003)(71200400001)(66476007)(36756003)(91956017)(64756008)(66946007)(316002)(122000001)(66446008)(54906003)(41300700001)(2616005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z24yWUhHSkxicTNOOERKUCtlSDN2NE91czM1eDFQclJwbkl3ZTRDdWpKU1dC?=
 =?utf-8?B?Q1IzeTZ2Z3B5UU5YdXpYamFWMEg0cTIxbXRUWnJSVlJPWEVLN1dQdGx4M3lJ?=
 =?utf-8?B?MS9xUmFxOHRvcUFtRjJxb0FPcHRQVkpTbGxoRjczOWlTeDA3V0daUnJidnIx?=
 =?utf-8?B?NEFvL25zaUxLVkV4eDR6Wm9rRUFBWjhJSW8wY0lkUzJ6QTdMUUp0L1JCUnl0?=
 =?utf-8?B?T1YwSkxtMHVoYzF3VEdzcXk5UTlnTUhGbzlVemhSR2hJQlNTR0xIQTBiNGlB?=
 =?utf-8?B?SEVJd3UxQTU2VmdaSk1TWVA3WXIwVW9hNmlIb0tESUZhN3dpNktTL0JJQWg1?=
 =?utf-8?B?YlNvdXZNeTVJMmZuQTA3TFlvMGlzREFTRUVIY2JWMVR4WmUxeTZVdWZXYVht?=
 =?utf-8?B?dytoOW8rVW5Ta2FxTnpSUlVMQ21GeGhFTEJ1VldZM2NGZVNKb1MrQ2hITlps?=
 =?utf-8?B?VEJsaklxS2Y5NnI3YnFVSmJHYzZoY1pmZTMwbjdPVlF2VWxUVEJ2eUpORXJK?=
 =?utf-8?B?WHNGRUVmaVhqajZ1TENYNUpTa2l0TmRwOVdZaHk5VmI5SmtGZnJlY2EwT1Rz?=
 =?utf-8?B?YnE0TVFtSTRuRXNLREVUT0hwN3cwSno4bithS2drRk1QclpoMnZub2VzcG43?=
 =?utf-8?B?Z1VaU3NSTzlIM3pGVUdRdENhNlk4eFE3T0pzWVJsMnpaMnJJbXdxRXBrNk8w?=
 =?utf-8?B?UzVWalZkdmpVUEsyb05CQk9FMUlwWlBwc0Q5Y2t3WmJMQkIyYlpqZHRuY0Rp?=
 =?utf-8?B?YjkzRTg1WndKUVRxd09rNmNoWW5DS3ZJaXc1YWpFcUErUW1qUjR3R0NwWXZ3?=
 =?utf-8?B?NENCdmhSaUdHWXNxaUR1MjVsWU50SkJIaWRKQ0JoUE9OU1RaZkJ3dExnMHo0?=
 =?utf-8?B?dm5iVTJ3WVFueVFKb2RlTmV2NVg3cWNRQTYyWHZGdXhITXJrbE9MRHkwL1k0?=
 =?utf-8?B?Ry9mbFRlRUtUSC9GUkd6YkY1eU5pZmplOW9RbWV1bW5ZeG5PNW0vN09lS2Iy?=
 =?utf-8?B?d2xwYmJKSFJzRW03QTlsZDRTWXNCVm1TM0RtdThHelY0S2UybHRLZWlOWVBS?=
 =?utf-8?B?QVhLN1RUZVpDSFZEcm53TytmOTBvVWxka2toeWhjYTZhNnBJR3F0RVRXYWZI?=
 =?utf-8?B?MWF3RERYdWV5dnNjWXF0VVRqYndsa2IweFdIOUxsbWVibmVMMmwydjJENUtu?=
 =?utf-8?B?OGJuZzVQMEJudjZJTkdlNGZVS0dTTitqNVpzTjYwbUo0TUVRd1dMQ0RJM0xF?=
 =?utf-8?B?aXBpSGtUTGJCWkJzVzNBYjlKQktRT3E2Y2xXTmMrd25KUk10MmR6TGZPdzBJ?=
 =?utf-8?B?YUZyQTRPcmgxcWJhSEdXdnJhTmlQTGt1VDBvakFodmE2MHVETkdIckk3NnZt?=
 =?utf-8?B?Q2NFLzlQVkVrVVZ1N1c2Tm52TE52WXRwcjdacjZLTEdsRVBNMUF2MlM0N0RG?=
 =?utf-8?B?MVZLRGJUUFQwRnh6UGtRUzRJanF0T2hkMmw2dkZlV3dSMUtLWHlqaEx5aVBn?=
 =?utf-8?B?WWtjaGt6OTlqVllhSVpHTGlIWlVBQ3hMa2N3d0hDZm1URnREQzl3V05VUnBm?=
 =?utf-8?B?cmtENlhqMWdmeDN0L1ZmMmxldmdJTzNKZDFKalpqZEJxdVFVN3g5dnpXV3Mw?=
 =?utf-8?B?cGcrSGpmMUppbG94N1ZPUjhiZ01tZC9GcU8yWFBXS1Q0TFdRdWVGL040eHJs?=
 =?utf-8?B?WDVTQnltK3oyTkFQMFREbHR5b3ByaGU3Z1U2bzNuZytma3M1amFkMnEzUnMz?=
 =?utf-8?B?NmxLVGpTRkREdWphUG9pWHdkNkRmMVhTdDNSZklQeXZaS240WnFlTXdKWXJV?=
 =?utf-8?B?eUxoTENaVWNOYXR1VHVWZHJoTHgzMkI5MGhRckdpSWhXS3RyM0M4MFBXSGdH?=
 =?utf-8?B?TTl1U3hGK0FwSlE1bDIxcTRUUzZtcjBOaHV0ZDlReHYyeUc0QWZRMTdqLzZn?=
 =?utf-8?B?OG9PeTZYWjZCd2ppOFJUYTZLTk5qdjMyUS9sZzU3UTBtTmkwck1tWnl3dGEv?=
 =?utf-8?B?bnoxMnhTR1BVdmJyUVhhaUhTbmxrM0xaTFZOMk9QdVRPWHBTRGJhTU9pcCty?=
 =?utf-8?B?QXB4aWN5YmtqQVZzOG1SVUdyd3JrNnFUYnZjUW9UOEF5SXBVa0ZBL2NOVVVq?=
 =?utf-8?B?aVowZmJmb2ROUWk2dVhETkJZVmQ5NW55b25peFZabDlhdTcwd3JOWHRPSDhD?=
 =?utf-8?B?c0p2M0wxSHZBcExVVVRRZnBPT0JxMVJrNi9ZekI1N1VleVhUM1FiTWx2aHFM?=
 =?utf-8?B?VzhmSmc4NjVZanNFd2FDOXdHNDdOeVBQaDdsQmNoN3hCN2hDMVo5clpCWTVU?=
 =?utf-8?B?aGRmeVZWdmN4YVBGdFNUdzdrSGJWWlcrajhEd3BINGVyb3dSVE1rTGVnZ3V0?=
 =?utf-8?Q?EBqBvndy3CKtun0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <766671662D6FED419C94A99172DAF937@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7d99db-91d5-494e-cbbe-08da52c83efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:22:02.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMH4bWpMH6g5eX5YjZEHURyTKwxbV7CGr1LzyXyum5hl+QyFB0lj/k5wVgCyYbSYDv62f3io68Ocnqaae2KQpoSnQr6WGMPbzFiao1ExFMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5753
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBnaXRAZ2l0aHViLmNvbTphbWJhcnVzL2xpbnV4LTBkYXkuZ2l0LCBicmFuY2ggZG1h
LXJlZ3Jlc3Npb24taGRtYWMtdjUuMTgtcmM3LTR0aC1hdHRlbXB0DQo+IA0KDQpIaSwgUGV0ZXIs
DQoNCkkndmUganVzdCBmb3JjZWQgcHVzaGVkIG9uIHRoaXMgYnJhbmNoLCBJIGhhZCBhIHR5cG8g
c29tZXdoZXJlIGFuZCB3aXRoIHRoYXQgZml4ZWQgSSBjb3VsZA0Kbm8gbG9uZ2VyIHJlcHJvZHVj
ZSB0aGUgYnVnLiBUZXN0ZWQgZm9yIH4yMCBtaW51dGVzLiBXb3VsZCB5b3UgcGxlYXNlIHRlc3Qg
bGFzdCAzIHBhdGNoZXMNCmFuZCB0ZWxsIG1lIGlmIHlvdSBjYW4gc3RpbGwgcmVwcm9kdWNlIHRo
ZSBidWc/DQoNClRoYW5rcywNCnRhDQo=
