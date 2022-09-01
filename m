Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B415A9966
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiIANtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiIANth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:49:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FBB38;
        Thu,  1 Sep 2022 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662040177; x=1693576177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P2uT9spu8EQMy6VexmEA1kR/YqNQ78HtzHJi1E29My8=;
  b=gO1IpWl1aN1KkjiZmIa7dPCHIsEd0FCPG9GHhzEMiWwS13dgNuZOGu4O
   WzNrjJntJAym0xc4fg0aSfGqXTkghWt7lJCHdjg6E6idKW5KzheP35kdA
   nAg5lCD1anB6MsTGi20BZ3KAWPrissuqASnBO+QDIly/EArYoQeyorMbZ
   ptE2KZKSKC825iBIT0eeA3GdBJpWxv9Q9Nc6+eJkwa5aBmPoBCwJiAsMw
   KAFT4sljTwv4IWuzDK1sWnhnSGm0Up17Q+LbH0GKHFtb3FObmCNx72Pbt
   NReoBUtyNc2Tal3pOYWj3fc9Qff7IgN5YwFwuK+PdabmbY+9rPdPHAQjg
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="171972754"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 06:49:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 06:49:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 06:49:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVrp7Ujq1vDXUuhQ0VBZ4CI0IOWSW7pG1UWxdCmmxcw9tsQzLv3w4yqfoNX9rsRVd/dLyEEduMdz01fVCjeb734Mxl9AE2JZQPw74/Qzkw/OOyvgnEPLDHtvqzOEix7GzMD3lHEQdBbn3QWSQiGugxYJW5uT3jvqtrKtaVFiyzFFC01WIWFCS/D4MxkQz/E87P9AuVrwauNof+HGYhgIK98nqRNxFiwHgLm4LGhz68rkRjeg9jLEKYfCHPTA167dv77fCcby+HT+nPiW+3AHEk51fMX47Nt/1BtEXG03F2D99F3hlEJfzzyBTHSzZeBbtWlC/E5QyB3ZO3ViflbypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2uT9spu8EQMy6VexmEA1kR/YqNQ78HtzHJi1E29My8=;
 b=Cb73X9akVyJnoQkkRgz7iyzYM3vVDbRW+IAI1058Gq3V+USK4W6QWbFUud1/Bs5kpun0i7+Bc7i8iM51dOAkUl6tsF59MIbqJ6QCXXyD77yC7htDebmc+hrUvKawT67E2DX+cjRsHOngR+yWie/RahdxjRWPy/daH0tfMEf37pwaCVWZ/UNaZQc4iO4X+UTG6WJVw5wglWp1nX9jJ6zIh9lxxO94khuzv6eOfWK272DqR1kG9Y+bAeuO18hm6LssJavbnORdZbWf/NHlRIBEW8uZukueUzBR5B3jg1c/JebvalSkQSIobD51rqRakvalxNGd9OSZIsIhD5eH+88DRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2uT9spu8EQMy6VexmEA1kR/YqNQ78HtzHJi1E29My8=;
 b=hHxRJ8b/eF9ixS2Ry2iQgn/nSpHtbkGWEXCBn88DqhKSUfUdVdTgLDNRP3KDPFo01jKGkrPKQGbtdJM/33PCIHvlAlGmJnWRKrOMo4ZnBzCSxhUEk6Pjuw9Glkgyk/i3/CI0AzK+gVX4ecXr9eEeH6ngzXHeXI+FYJdb65MtYiE=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 13:49:26 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f%7]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 13:49:26 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <andy.shevchenko@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's quad-uart driver.
Thread-Topic: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's quad-uart driver.
Thread-Index: AQHYvKqy1aZL4V02wEeXUUfPvF3Js63KmQcw
Date:   Thu, 1 Sep 2022 13:49:26 +0000
Message-ID: <BN8PR11MB3668B198D4BB4E86FC3519C0E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
 <CAHp75Vc=D4GVmQ+ohk21iXPGvXMex3WLcRGtquy57D-e4fx-7Q@mail.gmail.com>
In-Reply-To: <CAHp75Vc=D4GVmQ+ohk21iXPGvXMex3WLcRGtquy57D-e4fx-7Q@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fd0ad57-1ba4-41ec-6a1b-08da8c20c8b9
x-ms-traffictypediagnostic: SA0PR11MB4589:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPxloXi0Z40OdZtyIV9KdGCfCp5MmAr+aY8cQHTwgfR7yrX2Q2a02dekns6alVkbb11s1aRxb6kbcBrEVw58LxOeBkkvKgBqCFXQAVgsjd087Byw1p33IP5LxDjPMR2+tE+Cu3u8XsltcpqO7qRmMCd2hXaUttFVRINdI7a78S632I+lyp3wt/3ON/s3nNgOeX6Yc6bZaVm+53Zj1oe5MqQF2yIm2YNgKCYa9em9tKNK+whx26VIoir6QJiRdY370nodH0SxbhLIZiFCBntHPREO0z9GwB6XE3nskaDWcU6PtBjtcqvb1wfrjxthp5rW/wiFmZPOwcItcEjTlfTQcD0DAgjlHq43U9uv95XNqiYjarWsE4sRw+6UR3Qwuw1lXZIThHHObP+1fJVZCiO+udCopC+76ANAxvWgcTmOanfpv2m5WGSIM687cIz/gG+YA96DK9pICIGP26xFRJ5TD2BPChwfJJOVg20HJjRiA2lR3VEKysb/X9bR749MQvs7TD+N9ACHaryCKvJavZWzBrfELje39e4HNPVurU2ggebzSfRnBDva6qLsTK6oRc0F0fcOR0v/L4iFDAPRbtNLEuO1W9hUl6kRPd+PiKIcfqIC35OBdlvrZEbAJAXD0ehSua7Z0IzEmFBUGY4YeNy+PNecPZu6pn8oN04Ur/VaMRTEzY3L2id7aU/R65E7qsEo5Pcv6FB9dlLJCnSv8ZCAj1OsoKKO7esA5/4QCK8Oy1r94opdUJfdOUC940tA2s6STkYToogRDUDioRHKbnAGAWxFNqRsbG11MFgeYIIP/W6y4bPm88YEYOYFiUjdBt7vdTRmYCQH39LRoUI8/I9Qgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39860400002)(54906003)(66556008)(76116006)(64756008)(66476007)(66446008)(8676002)(66946007)(4326008)(478600001)(55016003)(71200400001)(316002)(6916009)(52536014)(8936002)(5660300002)(2906002)(7416002)(38100700002)(122000001)(33656002)(86362001)(38070700005)(41300700001)(7696005)(66574015)(186003)(6506007)(53546011)(107886003)(9686003)(26005)(83380400001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2w3NWIydmJvWm5GSUlSNlFmVDNJZXhSeDBzSDQ1Q1k2NksyYTdtOEY5QUxY?=
 =?utf-8?B?Tk1WT3h4QVIyem51a1UrVjlreGdlUzBQOFpPRFo1a2RXY204eTZzT1BPamhS?=
 =?utf-8?B?QW1tbHpHWldrVG1vWUFxSXBFRVNORXl5WWUvT3ZVNnVINzcvM00xVE1YUTdT?=
 =?utf-8?B?aGt0Z2VTRFZQMGVIY1FHZmJtaVVFV0QrT012UE9MM055dUtwVnhoQnFzNlAw?=
 =?utf-8?B?b1djeGt0b0ZFaGZyTnVyVnpqa0x2dFlpUzV0ZktDRGZiZTNjaURrY29vZGN3?=
 =?utf-8?B?TVVHa3ZzREpWNkI4czFiNVNOSnBITVpUY3AzdmRRb1VtSWUxR3UwMUkzblNE?=
 =?utf-8?B?RVhGcjBuY20wa080d0pSNnFMZ2tldUVMRFJWRnBNUVJxRlpXYVc2MVNPMGpm?=
 =?utf-8?B?NmIzMkVtKy96WTFDbm5uUUFwendjUm1aTVo5RzhEa2dXS3NyYU5uemJXcEoy?=
 =?utf-8?B?TDhHdGhGZVhvYllmYnlLTGFSTzduSlNxTUZaQUE4dHp2SFpaUWNyYWZsWTI1?=
 =?utf-8?B?bnpBb3RJVkZIemVnOTBwazFvN0tMYVRRcFZsVkRZbWhRVTVOL2RtYVNYLzE5?=
 =?utf-8?B?MDMzWXRXQTNGMUpGSnNDUk1SZi9qSSt5SEU0R2lkM3hEUTNxdnlWUE1Ucm9x?=
 =?utf-8?B?dzRtWUZyTUNlQUpCMElYd2Fpa2l6UUZ5YUZVVUVpWHIvMkl3c2pPOGJzQm9m?=
 =?utf-8?B?aHpyS0h1Y3pSNEMrV0V3SVd0OUs3SHU1NzZ1cmdXQ2hFTTZwNkQ5Rm5mRC82?=
 =?utf-8?B?ZjFibnFrTUMwNTFGUWVTL1VVU3Rmdm55YnAyb0R4UHZhU1F4dklhejA1VlEv?=
 =?utf-8?B?cU9YcnAzWjByQjk0bjZzdFIwMHk0dnhpYjRxdkZDLzBPeCtvZmczcy9aNGl6?=
 =?utf-8?B?MFpOUWpKV1ZKdEx0UzR4TlROZEpTUk5VOURGMmZaTHJtMUZYbE9wTFNicHph?=
 =?utf-8?B?VThzUG5oYjJYS3l5VzdWSGIzR0x6QWx5bU5uUGtTcWJqSlpDYVl0ak84QUs3?=
 =?utf-8?B?SmZTVGxjSFZxd3dhQjNNbTBqRCtFbnQzQnBoZTMxMjNnTjA1UEVPakNubnRl?=
 =?utf-8?B?ZTM3eWhpZnErU1Y3aFRwbEZQQkVTVyt4VnBTYm5peWQwSEFXQzJOQmdYZEV5?=
 =?utf-8?B?d3czQXkyWi9Sb1lXWE9iR2p5ZjZPczc5aUhLTzFkSTJFdkJiRkhqcTJJdGpC?=
 =?utf-8?B?bGxkb1dmSHRSMDMxa210OTNxVFRRemhzT21Ya3NMM2JmamU2aTJrL29rY2F4?=
 =?utf-8?B?b2txbVBZTDNlRVZIWGRkVlFhWnltWEttUlFEaWJEc3NBMS9TczZ1ellUZW9t?=
 =?utf-8?B?VzFOV0g0TysyN25RTWoxTFhGQUJJa0hrRm9vdXhzTjBrdFVZZUREM0FjRVdT?=
 =?utf-8?B?Zk1nY2hhN0ZTbG1CVnVuSHNSWlk0bHRZTGR0dFNqbkdSNGVieHBCc3pOZzB1?=
 =?utf-8?B?WUJNc3FrblllWnhKQ2lhVWNaRDM5cnpGQkU0bFlkTFk2QnFLaHFyT0x4TjFY?=
 =?utf-8?B?ck5vYjREN3JVcGk3aS92WWJCTG1PUS9UZ3ZXa0tGY0QyUG9EVDMvTzBYdU5l?=
 =?utf-8?B?cVMxdk1kMFErNmZqckloMERwWTRDbUJad0o3d05Qbkx6UGpiTE5aRkdyajJo?=
 =?utf-8?B?NE1vUjkyeXdpRHVxc2tkc3A4M2hDS0gyL0VvMlRwYW10QVljMExLbUQxQ251?=
 =?utf-8?B?UXRKc0dGU0NpVU5KZmhRbk5jdTBaRUpicUUyMFB4T3dwWTFjN3lnNnZmNnNU?=
 =?utf-8?B?dDBTVk5VRitpbEhxMEs5djZRMHNHOUE1eThKQStLQ2F2dDdxMktvcm1IU0ZD?=
 =?utf-8?B?cGtNSnhWaTlBcGUrTHdvK0tNd05oWDJaMnorWklhemROaFlRa1Y4NkJtK1hu?=
 =?utf-8?B?eEJ0QUhIWVExcm10Q0cyaE56RUJKMjJzTkJPWVhYSXJKaUUxRU8yTUV6b2ov?=
 =?utf-8?B?YnlSenZCOXZ1TnlVV2Mvd3U2OW1xRTliZXFvY2hkdzloU2loNzU0Ynp3SzIx?=
 =?utf-8?B?SHJBcDdVdGtqWXEwdWNhcEpwNUZORHdUR0E1WjVxd0pSbVQvUm1qWE50WG1a?=
 =?utf-8?B?aU9pUTRGMWdFTFJaTml6RWNQN05wREZ4WlVuVWdvZUlLbi9rVTZtbWZTZkxi?=
 =?utf-8?B?UnpQT1RvYWxYeDh0UkxUNkhSK3VtcDNlUmJlL1RVbkhQZ0QrNm5qTHBQTnFR?=
 =?utf-8?Q?A5xIO0u9cvb65x2F2mM+C+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd0ad57-1ba4-41ec-6a1b-08da8c20c8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 13:49:26.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXCFkdot+aQHkmVzV6F6c/7Tvu8b0SaUEEHclDD+9fsnyactIOK6Z1yhibd1m/GKq4MoT5vcpyaBDxbLnujTJ/AFGcBPeBJ/h3nEhZ0GQnbmR75FHsI+80c+wfK1yXOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMxLCAy
MDIyIDE6MjYgQU0NCj4gVG86IEt1bWFyYXZlbCBUaGlhZ2FyYWphbiAtIEkyMTQxNyA8S3VtYXJh
dmVsLlRoaWFnYXJhamFuQG1pY3JvY2hpcC5jb20+DQo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieQ0KPiA8amlyaXNsYWJ5QGtl
cm5lbC5vcmc+OyBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+
OyBVd2UNCj4gS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPjsg
Sm9oYW4gSG92b2xkDQo+IDxqb2hhbkBrZXJuZWwub3JnPjsgV2FuZGVyIExhaXJzb24gQ29zdGEg
PHdhbmRlckByZWRoYXQuY29tPjsgRXJpYw0KPiBUcmVtYmxheSA8ZXRyZW1ibGF5QGRpc3RlY2gt
Y29udHJvbHMuY29tPjsgTWFjaWVqIFcuIFJvenlja2kNCj4gPG1hY3JvQG9yY2FtLm1lLnVrPjsg
R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47DQo+IEplcmVteSBL
ZXJyIDxqa0BvemxhYnMub3JnPjsgUGhpbCBFZHdvcnRoeSA8cGhpbC5lZHdvcnRoeUByZW5lc2Fz
LmNvbT47DQo+IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPjsgTGludXggS2VybmVsIE1h
aWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6
U0VSSUFMIERSSVZFUlMgPGxpbnV4LQ0KPiBzZXJpYWxAdmdlci5rZXJuZWwub3JnPjsgVU5HTGlu
dXhEcml2ZXINCj4gPFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgdHR5LW5leHQgMi8yXSA4MjUwOiBtaWNyb2NoaXA6IHBjaTF4eHh4OiBBZGQg
cG93ZXINCj4gbWFuYWdlbWVudCBmdW5jdGlvbnMgdG8gcGNpMXh4eHgncyBxdWFkLXVhcnQgZHJp
dmVyLg0KPiANCj4gDQo+IE9uIFR1ZSwgQXVnIDMwLCAyMDIyIGF0IDk6MDEgUE0gS3VtYXJhdmVs
IFRoaWFnYXJhamFuDQo+IDxrdW1hcmF2ZWwudGhpYWdhcmFqYW5AbWljcm9jaGlwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBwY2kxeHh4eCdzIHF1YWQtdWFydCBmdW5jdGlvbiBoYXMgdGhlIGNhcGFi
aWxpdHkgdG8gd2FrZSB1cCB0aGUgaG9zdA0KPiA+IGZyb20gc3VzcGVuZCBzdGF0ZS4gRW5hYmxl
IHdha2V1cCBiZWZvcmUgZW50ZXJpbmcgaW50byBzdXNwZW5kIGFuZA0KPiA+IGRpc2FibGUgd2Fr
ZXVwIHVwb24gcmVzdW1lLg0KPiANCj4gb24gcmVzdW1lDQpPay4gSSB3aWxsIG1vZGlmeSB0aGlz
Lg0KDQo+IA0KPiAuLi4NCj4gDQo+IEZpcnN0IG9mIGFsbCwgd2UgaGF2ZSBwbV9wdHIoKSBhbmQg
cG1fc2xlZXBfcHRyKCkgd2l0aCBjb3JyZXNwb25kaW5nIG90aGVyDQo+IG1hY3JvcyBpbiBwbS5o
LiBVc2UgdGhlbS4NCj4gU2Vjb25kLCBpZiB5b3UgbmVlZCB0byBkdXBsaWNhdGUgYSBsb3Qgb2Yg
Y29kZSBmcm9tIDgyNTBfcGNpLCBzcGxpdCB0aGF0IGNvZGUNCj4gdG8gODI1MF9wY2lsaWIuYyBh
bmQgdXNlIGl0IGluIHRoZSBkcml2ZXIuDQpPay4gSSB3aWxsIHJldmlldyBhbmQgZ2V0IGJhY2sg
dG8geW91Lg0KDQpUaGFuayBZb3UuDQoNClJlZ2FyZHMsDQpLdW1hcmF2ZWwNCg==
