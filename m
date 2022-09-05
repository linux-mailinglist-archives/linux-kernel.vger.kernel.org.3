Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D105AC8F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiIEDEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiIEDEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:04:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C1B24
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV99N9E23s/yt2OI6cc45LRigymJKILIxtwLdxHNyg1TDkCIrYd/ZoUd9rghQPm3um+PSEZ2tIvHmsm86GDkOc4ZYAvKPocMwNjdhpzngiOenP8qOFWpbumxKGKL8BYfetXjY9wKHFJIUFW7L6sgZttzmOArZMtuVrgUjTj/A20U8kNi9+5oFflrjjAf6rPi/XJJ0bdEpCrG/m/kIIGgDeWmGjWBv4cO+87f7xxoGrG87vyUhrP7WKmLUdTVgLX3339sAt7TmKnaATHtrvan/g7ZM3fLejjIUo/gD1r2HaQmncu5G27GmBl/20HFZGUQMrKxarM7jIpEFAeCcr+m2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HWiL5DczXZUHu45xpcq0wX/ICebUI0+q2wIOGtTkxs=;
 b=BYc9Pf2ebM/sBnhuUVcWG1iVmFNYBaV7ywFjKty7EftR6sUbFQVBkJRkNLbzYjZuC8mPwM9Yvf+inckhIwSzWoZltilsmFR7ZvuUaIhzgnUQX/FOfijwEJsLDaqkPYcdDlsyzstgG8ABpieNley2y+Y3uGkTpKUdroB15ezqfZeNkp78okxkYj+ARHMC6BQX/5UqV9DSbelO9dJJg5lmKwrkeCUxtNJh0Ubu68uWik316rVXnGO4HTg+x+wRPhlQZxQdxJtoA8FL82210VFF7kpb3R2rtVZ8myCmq9mNf/unMJQ6+8BArTlm0LebESLT/KYjgA4b3y3zWkvalqiY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HWiL5DczXZUHu45xpcq0wX/ICebUI0+q2wIOGtTkxs=;
 b=icKfQQyGfScgVfEWBKitWeN09+p8ezbF0LLLiAJNYDRfd0OxiCj+4Qcjs8gI1U180GAdGVT3lNyWmMjTE3ZGOrucZ89d6zSBYYdHpXVcpoTgfLxc7/VIpqLl5X2ea7gtHiJrj5i5ljldiyrHOihvVQHrkr6fb2/7OCWStXbYCe4+2IFHknLmM6SZ+3MyyYRQRH2gmrurQDkFdnaghvN9ecJfyDH8d9v55tIQbMIqApCxsi0qO9na7W3WRtnaVjQwj2Skvc2DCFLEdTgkDJpmpGxHC0bwQKn4NK9LcuNgAlRyhANfiAhBj/vmBTowaWCBVXBPE0ppWArvHo5OQGZTPw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by KL1PR0601MB3876.apcprd06.prod.outlook.com (2603:1096:820:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 03:04:19 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42%5]) with mapi id 15.20.5588.016; Mon, 5 Sep 2022
 03:04:19 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [ammarfaizi2-block:herbert/cryptodev-2.6/master 73/76]
 drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: warning: format '%x' expects
 argument of type 'unsigned int', but argument 7 has type 'size_t' {aka 'long
 unsigned int'}
Thread-Topic: [ammarfaizi2-block:herbert/cryptodev-2.6/master 73/76]
 drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: warning: format '%x' expects
 argument of type 'unsigned int', but argument 7 has type 'size_t' {aka 'long
 unsigned int'}
Thread-Index: AQHYvuppsqBiabapX0CfUFm5eQGeA63QKkhw
Date:   Mon, 5 Sep 2022 03:04:18 +0000
Message-ID: <HK0PR06MB3202DA604E2FD79066C9E8CB807F9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <202209030047.Srfy7dOC-lkp@intel.com>
In-Reply-To: <202209030047.Srfy7dOC-lkp@intel.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d28cd50-a76f-4bec-0dac-08da8eeb531f
x-ms-traffictypediagnostic: KL1PR0601MB3876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgVwSo++2n5sM5ktnsMlLGUej1000/Tff6JhG5VG7oMvrsDSaMZ78ChokCMDeByE8TuXMvf09Ov9TovJgkGiVk2SWnUcVYkHcVKSl80fWjgX4VarnZWvYdiS5kvLJBNK9FcMp45qJlPq7rLQ+DIZvZj4Mw8sIUBIYvwAxl1aucBjZ2fEELMWdneoHOQZR4ZpdGXrvIECa/NVA6AHf7u2epI2eJ8LeLn5RZSayU/q4j+8yx0rA3+HTBCVCAn6BawTQwU4MiP3bVtmO4rdhbDWifAvwCV/sNM+8oT5/x/gTlIQ/Gt2Ps7tsVz/YgGtP7WjV/I03bKpEI0jxNPhcQZyuztLBtNgIC3ip2XLopSVgESHOdagMJLaLtF6VvTad5caYO29vyP/csuIWKSMFAfByjcaQeIbpPVz8BcRoRp9B4QydlVMXUOjWSErE1x1N07XEtGH6M7h1C1HJCUJk3Iyu+j8AQKE3ptXNADXUdjAFngfZK98OR4KskMNyIwAJIibJHCYoDDljidwxqQkVv4+nZhxIFgF4BWxERWzeXWisMmOWtzFPFKpid/M8vfAKYdlPGf4pQw8+1E31jApok7/jympht8Sbk1zcb4wKKzWCDxnquPxLe5Xyn84wAhx1Sen5cGv128qoHA9tKBPrMVP4mOXk9mzrE/VGQoONdZaVetLi3NQihdzkpuKufsk6agQ/eWZXrgbIvush+6MaLXvPJYHQXoGGozl5mPSyhMl6YUH6OT79LAXj1Q+UInppm9aDRu09iA1J6lri8uEfrgCiPuchPAqwI5Qr/uf5bdItTYeG47WziLWRAiEsbfQmMoJ2DHXmcrJBQAHq820tCJoLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39840400004)(396003)(136003)(376002)(5660300002)(30864003)(8936002)(38070700005)(6506007)(7696005)(38100700002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(122000001)(8676002)(316002)(83380400001)(55016003)(110136005)(33656002)(54906003)(26005)(52536014)(53546011)(966005)(2906002)(478600001)(86362001)(186003)(9686003)(41300700001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BeRb9DL5Z0LR8tjcYV6prpaFbiV23scjnHS1IGjfYo2UcLJT/qR546K7/ee6?=
 =?us-ascii?Q?xM66OKSXbYEG8kchK+XPls5PSF4bL0lKPcBxidVsgv9Qw3nRDy9OdUQWlYlG?=
 =?us-ascii?Q?OtGk6M+xw1hDqDCPEhXxY8Kyd/4Mx1mD/gtndg75SUQcDR7bxzfOTBd+XwPS?=
 =?us-ascii?Q?qn4CwxBm2ilFJJEFuIwuZ3HQxVCVqLw9wTiwbQ1OpSGbEYBC/bEgid0Llxrd?=
 =?us-ascii?Q?myWi+ujRkxAHnCs9cThd/nwqT7M2jJeYEXhY0kMUTLHUUyrpYt9ISTDNprJQ?=
 =?us-ascii?Q?Nn/3Qlg1517NG47irMRnGYW3ihql9+iWHBPGeg294lT9Mv09S6gecYfZLaPq?=
 =?us-ascii?Q?s3LFKn/n8fdwLJ0AISIlai8KgAjndYWEwnIULnSVrEbvHsqzhT6mb3renxbl?=
 =?us-ascii?Q?osAqf7B8W0aehEfnEMMx2qlBuzuW39aeAUfECgIxPEOv3dmrR7+FD/EeApZq?=
 =?us-ascii?Q?VQfz7t6K+NDU2w8jzbODFB4tY2WPLI82kpJS237LXOuv+pWLIO703SOHckKC?=
 =?us-ascii?Q?ks2zzEx/e5mdbfN5p0QXFjYN/RU/4+aoNXyR+XKVx4DNlo8+IfhCwYM7sYee?=
 =?us-ascii?Q?GIqALWutx4ApoH9bHbzhE37dKbTYULwLBfBMVS/akFFh6eKnXNEkUJB5srr6?=
 =?us-ascii?Q?gfjOEEhJlaXu/BPqkLC/QULU595GPcQVFISu0010oaaMEHUOw+O+S4XX1FH+?=
 =?us-ascii?Q?lzpc1ZKW4sEOfMiiG0SobTh2VTkR7lPcjGywJFMle3ZHmKTpgL0j6aHOCjeC?=
 =?us-ascii?Q?OAlOfshslVgepr60M06vp6UlEOiHyP1hJFYsVlEYv0Ed08s176twDztu9kbZ?=
 =?us-ascii?Q?5HLJv8XMKTT6Syl1CJ28NXRMCrO8o/HototJv5xoV48Re0q1zMLW80UXH5Ck?=
 =?us-ascii?Q?r2/T2zaxirknqZ+6Wvnm74HkKsKoa6csbBl1PZe0uadEGoMVwqpRbR8p7MKs?=
 =?us-ascii?Q?AKi1nOtVbAHI969W8sYLRb8RAXpuw0A6FRThoT+e00PygS9DsQSU1PiaDTKy?=
 =?us-ascii?Q?OBWtjvFJtv7OQVjdnJ0351IV9deIrT19LK9KE0XY2Hi333tPpS0zJUv3HcH5?=
 =?us-ascii?Q?hQMFAp6nFWoqxFznUEgluRqwh7jljva/XSJspzBavORg0mOICrz2+D839YSG?=
 =?us-ascii?Q?rTliJtylscP9ZGBpg/1t5hbUVyC8OjZgKN5+pFDeNVWc4+RPHxPvcfdqk8SV?=
 =?us-ascii?Q?tf8rv+otqxERGdAMfo+6M3GoWN+N5jUNPTszVVZtLLtM1Bwyluq71fkFcfnF?=
 =?us-ascii?Q?kktMCauBE9Wnt6mV0OBPa7o8A1rb5As+0cQFw0Vemo+bczR+1ZLS05fSZBGH?=
 =?us-ascii?Q?R7aFcpD0qFNWyzT82Y5xdE/SnTIpO2A7qHHFdZnRpLARHk/GZLNvHlGXq+06?=
 =?us-ascii?Q?xw+yYYS+/bPFHUM0Tv1mqU/yr4/WZvLDjY6NXc++Yx0fSdjGA2Yvn/bqsA+h?=
 =?us-ascii?Q?1Sqr0mcp9dv3Lz0Ecn6IESi0aiAG7a+vyUBq0PcbrA6A5cU/xQ0K0q5XEmpp?=
 =?us-ascii?Q?I4Q/okdHoPYlsE49lrG/fdyt2nBKSKOlyx9HvX+snMUHcy+0w1VGoak9N8El?=
 =?us-ascii?Q?4qXK0ctuhvoKvA4liNbWLXfFtOiyhsCuh06qS/ve?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d28cd50-a76f-4bec-0dac-08da8eeb531f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 03:04:18.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79XGna0qMQKMBvrNJuujHXLUhuYAYcSXuapNPZFobVFVoqX5W0fnSE3HFkSZ/IYVGAK6CnjS1GvjUZCBOKNzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Saturday, September 3, 2022 12:38 AM
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: kbuild-all@lists.01.org; Ammar Faizi <ammarfaizi2@gnuweeb.org>;
> GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>;
> linux-kernel@vger.kernel.org; Neal Liu <neal_liu@aspeedtech.com>
> Subject: [ammarfaizi2-block:herbert/cryptodev-2.6/master 73/76]
> drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: warning: format '%x'
> expects argument of type 'unsigned int', but argument 7 has type 'size_t'=
 {aka
> 'long unsigned int'}
>=20
> Hi Herbert,
>=20
> FYI, the error/warning was bisected to this commit, please ignore it if i=
t's
> irrelevant.

I'll send patch to fix this build warning, thanks.

>=20
> tree:   https://github.com/ammarfaizi2/linux-block
> herbert/cryptodev-2.6/master
> head:   fa2bf6e35091e66fc83af1aebea06a78a5a2fde4
> commit: 31b39755e32568b43c80814c5e13d7b1ab796d73 [73/76] crypto:
> aspeed - Enable compile testing
> config: ia64-allyesconfig
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross =
-O
> ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://github.com/ammarfaizi2/linux-block/commit/31b39755e32568b43c80
> 814c5e13d7b1ab796d73
>         git remote add ammarfaizi2-block
> https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block herbert/cryptodev-2.6/maste=
r
>         git checkout 31b39755e32568b43c80814c5e13d7b1ab796d73
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0
> make.cross W=3D1 O=3Dbuild_dir ARCH=3Dia64 SHELL=3D/bin/bash
> drivers/crypto/aspeed/
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from include/linux/device.h:15,
>                     from include/linux/dma-mapping.h:7,
>                     from drivers/crypto/aspeed/aspeed-hace.h:9,
>                     from drivers/crypto/aspeed/aspeed-hace-hash.c:6:
>    drivers/crypto/aspeed/aspeed-hace-hash.c: In function
> 'aspeed_ahash_dma_prepare_sg':
> >> drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: warning: format '%x'
> expects argument of type 'unsigned int', but argument 7 has type 'size_t'=
 {aka
> 'long unsigned int'} [-Wformat=3D]
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |                            ^~~~~~~
>    include/linux/dev_printk.h:110:30: note: in definition of macro
> 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);
> \
>          |                              ^~~
>    include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fm=
t'
>      150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev,
> dev_fmt(fmt), ##__VA_ARGS__)
>          |
> ^~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of
> macro 'dev_info'
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |         ^~~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:188:9: note: in expansion of
> macro 'AHASH_DBG'
>      188 |         AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x,
> %s:0x%x\n",
>          |         ^~~~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c: In function
> 'aspeed_hace_ahash_trigger':
> >> drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: warning: format '%x'
> expects argument of type 'unsigned int', but argument 4 has type
> 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=3D]
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |                            ^~~~~~~
>    include/linux/dev_printk.h:110:30: note: in definition of macro
> 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);
> \
>          |                              ^~~
>    include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fm=
t'
>      150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev,
> dev_fmt(fmt), ##__VA_ARGS__)
>          |
> ^~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of
> macro 'dev_info'
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |         ^~~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:327:9: note: in expansion of
> macro 'AHASH_DBG'
>      327 |         AHASH_DBG(hace_dev, "src_dma:0x%x,
> digest_dma:0x%x, length:0x%x\n",
>          |         ^~~~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: warning: format '%x'
> expects argument of type 'unsigned int', but argument 5 has type
> 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=3D]
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |                            ^~~~~~~
>    include/linux/dev_printk.h:110:30: note: in definition of macro
> 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);
> \
>          |                              ^~~
>    include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fm=
t'
>      150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev,
> dev_fmt(fmt), ##__VA_ARGS__)
>          |
> ^~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of
> macro 'dev_info'
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |         ^~~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:327:9: note: in expansion of
> macro 'AHASH_DBG'
>      327 |         AHASH_DBG(hace_dev, "src_dma:0x%x,
> digest_dma:0x%x, length:0x%x\n",
>          |         ^~~~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: warning: format '%x'
> expects argument of type 'unsigned int', but argument 6 has type 'size_t'=
 {aka
> 'long unsigned int'} [-Wformat=3D]
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |                            ^~~~~~~
>    include/linux/dev_printk.h:110:30: note: in definition of macro
> 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);
> \
>          |                              ^~~
>    include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fm=
t'
>      150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev,
> dev_fmt(fmt), ##__VA_ARGS__)
>          |
> ^~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of
> macro 'dev_info'
>       10 |         dev_info((h)->dev, "%s() " fmt, __func__,
> ##__VA_ARGS__)
>          |         ^~~~~~~~
>    drivers/crypto/aspeed/aspeed-hace-hash.c:327:9: note: in expansion of
> macro 'AHASH_DBG'
>      327 |         AHASH_DBG(hace_dev, "src_dma:0x%x,
> digest_dma:0x%x, length:0x%x\n",
>          |         ^~~~~~~~~
>    {standard input}: Assembler messages:
>    {standard input}:489: Error: Register number out of range 0..3
>    {standard input}:489: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:484: Warning: This is the location of the conflicting=
 usage
>    {standard input}:490: Error: Register number out of range 0..3
>    {standard input}:490: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:484: Warning: This is the location of the conflicting=
 usage
>    {standard input}:490: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:489: Warning: This is the location of the conflicting=
 usage
>    {standard input}:493: Error: Register number out of range 0..3
>    {standard input}:494: Error: Register number out of range 0..3
>    {standard input}:494: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:493: Warning: This is the location of the conflicting=
 usage
>    {standard input}:2109: Error: Register number out of range 0..0
>    {standard input}:2110: Error: Register number out of range 0..0
>    {standard input}:2110: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2109: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2111: Error: Register number out of range 0..0
>    {standard input}:2111: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2109: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2111: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2110: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2113: Error: Register number out of range 0..0
>    {standard input}:2113: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2109: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2113: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2110: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2113: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2111: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2114: Error: Register number out of range 0..0
>    {standard input}:2114: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2109: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2114: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2110: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2114: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2111: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2114: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2113: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2115: Error: Register number out of range 0..0
>    {standard input}:2115: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2109: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2115: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2110: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2115: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2111: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2115: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2113: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2115: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
>    {standard input}:2114: Warning: This is the location of the conflictin=
g usage
>    {standard input}:2119: Error: Register number out of range 0..0
>    {standard input}:3353: Error: Register number out of range 0..4
>    {standard input}:3354: Error: Register number out of range 0..4
>    {standard input}:3354: Warning: Use of 'mov' violates WAW dependency
> 'GR%, % in 1 - 127' (impliedf), specific resource number is 45
>    {standard input}:3354: Warning: Only the first path encountering the
> conflict is reported
>    {standard input}:3353: Warning: This is the location of the conflictin=
g usage
>    {standard input}:3358: Error: Register number out of range 0..4
>=20
>=20
> vim +10 drivers/crypto/aspeed/aspeed-hace-hash.c
>=20
> 108713a713c7e4 Neal Liu 2022-08-18   7
> 108713a713c7e4 Neal Liu 2022-08-18   8  #ifdef
> CONFIG_CRYPTO_DEV_ASPEED_DEBUG
> 108713a713c7e4 Neal Liu 2022-08-18   9  #define AHASH_DBG(h, fmt, ...)
> 	\
> 108713a713c7e4 Neal Liu 2022-08-18 @10  	dev_info((h)->dev, "%s() " fmt,
> __func__, ##__VA_ARGS__)
> 108713a713c7e4 Neal Liu 2022-08-18  11  #else
> 108713a713c7e4 Neal Liu 2022-08-18  12  #define AHASH_DBG(h, fmt, ...)
> 	\
> 108713a713c7e4 Neal Liu 2022-08-18  13  	dev_dbg((h)->dev, "%s() " fmt,
> __func__, ##__VA_ARGS__)
> 108713a713c7e4 Neal Liu 2022-08-18  14  #endif
> 108713a713c7e4 Neal Liu 2022-08-18  15
>=20
> :::::: The code at line 10 was first introduced by commit
> :::::: 108713a713c7e4b7d07e6cd9b808503d5bb7089b crypto: aspeed - Add
> HACE hash driver
>=20
> :::::: TO: Neal Liu <neal_liu@aspeedtech.com>
> :::::: CC: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
