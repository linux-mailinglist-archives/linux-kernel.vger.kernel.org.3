Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0415B041D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIGMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIGMkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:40:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8914B6543;
        Wed,  7 Sep 2022 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662554427; x=1694090427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JqJjvV1v27f95rMgERLdEHBL7wFNbR0DdMeOK1ZDIvw=;
  b=LlzRSoje5jutxDs4dL0jeTHt1fRnBuOi+AaWmoK3UnSW0j/6jW3WwkqE
   DMGk+Ge4n/6ocbWx4pmSBrr71q9mQpSmqcPlaQCh/f3faQpJ1QrxPsurZ
   enWRZQ/HLo42qyYUPZDLdDoaa7RKB1ZYBoH02ZZWToWagQS5IylNZcQqr
   1jE+9U1nt2yZDYqFzeve9sP/kqnAwmTXbiWn9b8laD9SDCxbSAaA+zLMi
   ZqoRSrOJmU9ICIW6hInR/6lSi1RknMGA7KcYXE6vEwIb55damSZO013ZA
   Aq1RHYTSM57fJ6JKnKfc8O7OayM1NrYzPbmtPtSDBF03hMvqrW5tRpPew
   g==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="179389173"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 05:40:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 05:40:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 05:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9HCsMHMuKz/2p+UfmbNIZieA003qH3umA+MxxwDDNYq5574AiWU9FPSUJdANENecBYUs315wHBijyZRNeUuIAPplOz5DBgIpxLAfAuKNPWiAJpq1+/Y93f0rGi2p6SbSvtJlS1zj/cRBF/UNCgKlX32+el3/ahasCuLTF/5BehQr2h0i1f8HoUl/2rQgn7Oggyr+np9fgHYCNZq14VuRLVzihKN2pGxXBJR6ii39da8XVnpZDFfXv5DO9FBKD567H9ZLWRbGEG/CH/Nu+DSuKEbD5aBUMInUZMOyNbnxxzfw4qBS+XoHL4hEEmaxJFhMOEebjDC9b+e35AZ4quqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp1N1jI92b/aV88DKCSyZL6fHYwZZ4weHfzQRxyPqFc=;
 b=PxkuV7JXtFWMH53Ue0sN+AYUV4R2V0melc5RkpgTdF7LpnBgmef0dmd7G7vPggZcg9D91hz1dz9437b/JXGLWaXb5ifpcIpjaDnCkBVtwslp6YmDNG49pJ//lb1nacYTzSlReGCOKanhujwQwUNdiW8XQ6Kq5OES/TPg9J4uiRwBTGaxqoRwArkHRodu2xFm5Yqaf3P1SG4nOtWKUy7HFrRVFwmjTonjjAU17GVThqWyH0hNQKa0+/2zVVI5QK/OqKJeJTIIN7utR9M8cfcedjVGhg9utQzOWGd6na/DAoTyx1d6SaSPw6mL992PQ7Lm1C8z+fNhWwBThApY+y72hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp1N1jI92b/aV88DKCSyZL6fHYwZZ4weHfzQRxyPqFc=;
 b=genh5I09YalLgLxBReUmyW0E0bYggExh/FdeUEe29XN4ymUjwvxguGq2mhAof/Khqd3vEt0Q3wwYwL5IBpTy4Y4t8sHsyARvDve9KXqck/GjGzjmYOvsnHjoV3yHYY+fbrS/sTQP+6BAywy8j8hgac8ym86hMgxnP3bpDGgxCnI=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BYAPR11MB2967.namprd11.prod.outlook.com (2603:10b6:a03:8a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 7 Sep
 2022 12:40:11 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 12:40:11 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <arnd@arndb.de>, <sudipm.mukherjee@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>
Subject: RE: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume
 handlers.")
Thread-Topic: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume
 handlers.")
Thread-Index: AQHYwfw9eg54+szR4EyIZ0UVDHtDVK3SpJgAgABA5ICAAMHWgIAANtKw
Date:   Wed, 7 Sep 2022 12:40:11 +0000
Message-ID: <BN8PR11MB366846DC380A755B64E870ADE9419@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <YxdX2l88PSFGe1r4@debian> <YxeAOgEoUffHudv/@kroah.com>
 <CADVatmNSGSZZNXF7k7YmMqfcoOAiM6JhEfksjoVqoBOLUXfbPQ@mail.gmail.com>
 <77b0aa7b-3183-4a05-85ff-b278aa7f8f11@www.fastmail.com>
In-Reply-To: <77b0aa7b-3183-4a05-85ff-b278aa7f8f11@www.fastmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BYAPR11MB2967:EE_
x-ms-office365-filtering-correlation-id: 4f72fc62-0dbf-4a5f-87c4-08da90ce1abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QysKo1Ev7pKqmpClmGQSOxPubsvWOMIL15s63BP5+ILBiIkQ8rrMN1a3tcWk+AJvJDdb4qPu/YjXnvkQPGfaf7uHzBl3I9plVG9R1HF0rMXehV29tymFTXcqo03XZ6DublR9Cn3tMNXquJa3E6onb3fu2wg8hkpx5/bHE29P83yGW72ECX95sI0LMG3mdEHeBy6bh2vPgyGZBg3MyKGPZyDLgJ2U29qDaqWAr8TARopR+qpejYR46oKUf7e12Kq86cx/QVbVPg4ZsnzM8AcxfqBIT08xWOuDFthMkrUzLLOxJ3t8IAtwMZWXLS3cr8C04byXOhKjr1eDJoPYVqHn7J42oeH/IHDN3TvI20tPtEE6ICGCkpHfXQ3JKpozPlI+XzR/H0KURnI9mCcyFX4PVIXAlBj68ncI6UV4a/v61JRmc2JUMUHph9wrGHDsaZqwkSj+/wQkQedd1IK1h2hDpeq/fLznxLQcRlS1nBITu1cGDP7GauiHTwkAtb5sBNVoVp2Eb4FwQ3QunEirLol2bZH3FMvT/HxIIY9xh9I/edLejSKp+kPM9aoEV5CMA9EaE/peyTUUnoczKS6oZag5/9SlZ+rNAkRci0lKHWP8FaY//XTJJjKmS7qBq6SrSkcWStZLtfcNxgFuaGX3l7gaEnP8o5EWYSKT3qn1IOlIN92Y5X5r6aa7am16bkvFBABaE63X4d78njZsyKyBLwmn7AjqwRkQZAig4Xg3SfR0fCr8B0bSYGb1m4hKG96MA31iwiSGHyCMsIY7vqXKDqG5Dw0cF1AoDOWUj4qp6ELjAtbwNfm4LyIPoc9FggWw855HaMBDY+C8L57Zrq/osLcWZCHl/4wX5gmGOPZsqlzVrl0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(39860400002)(396003)(376002)(33656002)(38100700002)(4326008)(53546011)(9686003)(7696005)(122000001)(6506007)(26005)(66556008)(64756008)(8676002)(55016003)(66446008)(66476007)(66946007)(52536014)(76116006)(5660300002)(8936002)(2906002)(86362001)(15650500001)(110136005)(54906003)(316002)(478600001)(71200400001)(41300700001)(38070700005)(83380400001)(186003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WaBe8k2hMmQ1QRFzPBzIwJbKAFgi/bhZUVpIw6x/vZBNmNbBsfUEPQcwFtI?=
 =?us-ascii?Q?LbmFfIMaQQnGfLiaYczqgKn22EPC+GZ/qE154F51JGV3ifNd+hGIsu67Aahg?=
 =?us-ascii?Q?LNUfqC+JqiEsraJaemkBRFijKMN/vZCxvJK9zrAYHaQX3U+ipyZwYVMRxboJ?=
 =?us-ascii?Q?KI4zV3/Q1OTlXHx3/7Q0W0QqqBRHuPnFZ+ZbMgd9g7vrmynl0PsGK9McauYf?=
 =?us-ascii?Q?fbizWi+bJ7FnCDvseNUnYrAuGMgrfWr4d968CIZ8KoxCQXKs8tbD32/3ZR+w?=
 =?us-ascii?Q?pxIbLlBqFMgESK5qMO0xflYhtNh9MKKJje58CDtBqLrVjS0ZkseTBkAL6/h2?=
 =?us-ascii?Q?kdBmiANDp43UYRMZQkzVoL3nYAFLF4kC91sdjJsVU+IH6YsE1Awjv2QVpNUq?=
 =?us-ascii?Q?Qo46kNlmyXy/w13V8RXPc8MTXWMXLPOC5bQ2/NPycAUbsX8uaA9CsNMLXH87?=
 =?us-ascii?Q?CYMgf1YeVQ6F0gL6Dpayt6lxVlI8v/hFauwGxTw25qQmSsvD8khcGB8nUUCu?=
 =?us-ascii?Q?N7DlhKT5MHmm/ElSCgT1dICJLtvvvG9XNU+tkl770U6qprMyvCaYPpZ+/qc2?=
 =?us-ascii?Q?D1XMPIiEnp8bY0RuaHb/tm0EEVH/2FeBADZJIa/rWM7D2Bt0D4D4JHLg64/7?=
 =?us-ascii?Q?Jk2LJ1U3NCdyjsrhfz+hNE2lomED+qWSYjxCjPZMboGWKRYKCu5hrVOdKMTd?=
 =?us-ascii?Q?v99+Xh1zyYuQ0X5zYw+Z4QuawFJ4sU30D6Df9L8fW0R/86yaKZF4ht5uev33?=
 =?us-ascii?Q?JdON2GQ3iVhVHenGLaO8+wf8zi8k1CjM280f23yWf50Laq5f2ADgWW4wv295?=
 =?us-ascii?Q?H+fi177m9r63Xynxv8P6S4Uw1L6AILMkL3TLc/gQ85G7sJzu+suq8N9zqkR7?=
 =?us-ascii?Q?M5DUqmDwYs/AKJtJi+N7v/eWOk2xMYnkZBMluRzqiDE95rvSlliosZB7/p7w?=
 =?us-ascii?Q?O9yl+kcJs+yn/Q3kg16YIZyETmGAWBQmdxriTm96I5HgEPsYILpgFlES1EKr?=
 =?us-ascii?Q?FWDh/LYWFfRl9mF1IBilsk2Rw3Poc5nMXC/rlR39q9YC+xNWX+I1J9BfZ53t?=
 =?us-ascii?Q?k1UhQ/WQcsV4LY5D5GSd4NlggVUVRqHZRDmxnRju7aJMTsFT5sQJ+KQnsqwt?=
 =?us-ascii?Q?lxzfuFd5OejbqxXwscR+7HoOq7albidlTtVFoEjiLhch3UMSLbyJqT0zPrvK?=
 =?us-ascii?Q?XSDnlU2iuzBjUmiqE9vV2VlLWr17K7gAIHTkr8xJBVgmXNOn97LAp5YVoNla?=
 =?us-ascii?Q?mRQoYCI2cYktKllCPgrLiimnMPP9oyHMyDLXf2NGZHoT6I9/vtPW4rEKCObr?=
 =?us-ascii?Q?rLbTrDm3tQvwSjMQ7yE5946nN/WsvYlL226sQtvuXM6v0dWNnDURqT6sbsyC?=
 =?us-ascii?Q?nhk1Io5OiBzgl9rpx9s/WzzAgZH7qW3YIgwovvSMpPZMrgFCKYIemBpA+2IP?=
 =?us-ascii?Q?/dcGkKx3MIEClwIef0hMHgi2iLfz6LlfYVVPB0/jcD1tTizqHdZOIgUmLzzu?=
 =?us-ascii?Q?EnNnIGE6UMlWUTnbaaHq3hLi6vu6H0VZmpgu1CjXkQmzj5x3i7vqdTc2QApj?=
 =?us-ascii?Q?v9r/9meYtEKxTGSFMxchjNbOtQuobiKQ8SKQRSgREVypLKuQ4NauJs+aJeP+?=
 =?us-ascii?Q?zJl3ty8EHeBWEFX7n+jd3EQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f72fc62-0dbf-4a5f-87c4-08da90ce1abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 12:40:11.2325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZ00/hfF1/KxbXOxEOm5j7Gn+PgaObh4yHVxH3+H/wrF9KCjh3MZKzYlkiwcdN4gWCN84FKX2vB09ER77jV8oqU1siSLJOTfVA+gHWfAdi8b1ZlNspwomWe7+/j4Nu6N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2967
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, September 7, 2022 2:12 PM
> To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>
> Cc: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; open list:GPIO SUBSYSTEM
> <linux-gpio@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>=
;
> linux-next <linux-next@vger.kernel.org>
> Subject: Re: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
> microchip: pci1xxxx: Add power management functions - suspend & resume
> handlers.")
>=20
>=20
> On Tue, Sep 6, 2022, at 11:07 PM, Sudip Mukherjee wrote:
> > On Tue, Sep 6, 2022 at 6:15 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >> On Tue, Sep 06, 2022 at 03:23:22PM +0100, Sudip Mukherjee (Codethink)
> wrote:
> >> >
> >> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error:
> 'pci1xxxx_gpio_resume' defined but not used [-Werror=3Dunused-function]
> >> >   311 | static int pci1xxxx_gpio_resume(struct device *dev)
> >> >       |            ^~~~~~~~~~~~~~~~~~~~
> >> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error:
> 'pci1xxxx_gpio_suspend' defined but not used [-Werror=3Dunused-function]
> >> >   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
> >> >       |            ^~~~~~~~~~~~~~~~~~~~~
> >> >
> >> >
> >> > git bisect pointed to 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add
> power management functions - suspend & resume handlers.").
> >> >
> >
> > Looking at other drivers which uses SIMPLE_DEV_PM_OPS, I think
> > pci1xxxx_gpio_suspend() and pci1xxxx_gpio_resume() needs to be under
> > "#ifdef CONFIG_PM_SLEEP".
Thank you Sudip ! I will review this.
>=20
> That would work, but a better fix is to use DEFINE_SIMPLE_DEV_PM_OPS()
> in place of the deprecated SIMPLE_DEV_PM_OPS().
Thank you Arnd ! I will review this.


