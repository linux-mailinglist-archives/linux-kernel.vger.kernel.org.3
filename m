Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A958D4BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbiHIHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiHIHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:39:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E21EED3;
        Tue,  9 Aug 2022 00:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3DxAasQ62DPGZst2I8aNAwP7Q5+X85/BnNdwBaLWDzXd6KBwF5vKoBQ9G7wu+e1wXu+W/G+dfDBTs3yXkFsKzlotuXI4G2zADrjCyMfVMWWBbi4+vQAHD2ebgIFd07+YSuen3OBGjwOT6bzmbzTrCbX9aWPHBx9KLkOmnRk8sJdve6HuCTFNQ43iJDn1x3FreAtfBXSm0Ys0IcN3XudjjV6CGlDZlB+PZehpp/N75G11Zs3oBGlJJocyBSeiA7wxloBR0NfM5egz0kd8ms7Pf2DlTeLnDcvqa8+SdJdSBAcOmWXKimQ5qm3HdrTBWEoVnkaBl7VMopUNom3qMkdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13tGQFBx/3O5QY0uAl5j7BxJ95tefchnWfH/bPnhNXE=;
 b=IoRnWypIP/cU2OLWq23ryS7uTWpqApVi8wupxCQV7RTi6zM53fMjO4tLR3R6cFWe+evsfqUT8qoMx/Xsb/X/IQlJEyNepXgXxlyLwrO1JG7c+h7ArDQF1iktVYFoPLlZZqhNFQu3Z6l4rrn565M7Fy1lAC7Jdrsbh9msckA8ZoH8vxya+zz2kv8yNkh4CmlUK2x9RO4yMEnTc510MWt+7fHqwqhtrvgFea3SrfUOd1+lJfGttpaSNzE40DGrTl9SjPbc7DIPB9gvKRfPGMnYxwCWNQGJ0ft5wff5sIqE/s3DN36dOSRaeLskzt/g179NO7jYOaqMbbxmwqJvZuZoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13tGQFBx/3O5QY0uAl5j7BxJ95tefchnWfH/bPnhNXE=;
 b=fSBbQKcyUuwF1rtnbVxCRBfVxjU9fMCeXJdi0V4nb/zwCgVxZIwzEQUpgWSzdZYVQpK6jZcMHHEXz8veFi+ZcAqGLEp1g5s2+CsHI5ZVtvjVt/+jSU3BW4RWRdbqHF8lIiuUhzwCg2Lv/KfJLADw5AP4hoTdKeYtS0DfeKnFn8OA2sHzCJT/FHl3viWmVNSMAxFId6Mtt3tBWzpnQbNIS9vemmFBEj8lr5yj8O6TPeAGCRqMaMZyFYE6im34uQi3kXDsyDRarEueglYs5ePlx2eNwpp9EEPyRjCMG75fVHo4jjGdo+l0zlr1PF4WnxJ6+FeRr9VC+dsAE/735hup8w==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY2PR06MB2656.apcprd06.prod.outlook.com (2603:1096:404:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 07:39:10 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::b8c1:eb0c:b3f3:57bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::b8c1:eb0c:b3f3:57bf%5]) with mapi id 15.20.5504.017; Tue, 9 Aug 2022
 07:39:10 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     liulongfang <liulongfang@huawei.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v8 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v8 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYoOO/FCxUF/WBPkOhfzWPTKR/E62kYikAgABsQICAACmXAIABSEOg
Date:   Tue, 9 Aug 2022 07:39:10 +0000
Message-ID: <HK0PR06MB320261A52E2B8B9151ADDE4D80629@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220726113448.2964968-1-neal_liu@aspeedtech.com>
 <20220726113448.2964968-2-neal_liu@aspeedtech.com>
 <5ca081b1-9a96-5b58-7a27-75c94af119d2@huawei.com>
 <HK0PR06MB32026709F521B1D2F6A1B95C80639@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <256d64d6-0a27-7714-60ac-580b371c2502@huawei.com>
In-Reply-To: <256d64d6-0a27-7714-60ac-580b371c2502@huawei.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e65c7eab-e9d9-433f-db04-08da79da3f89
x-ms-traffictypediagnostic: TY2PR06MB2656:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0/P0+IDg8zpQHg1W9b5I/5L7B+x1vc+YexDXNuVV7z3h4kfF0CLRGJHE49ujImqH8Xu40CzCwNV5gyoEzfrakS+RTlY3IlqJueABQjylC0ksiZ3zjDszFQpCEphlWuC4R0mnUvcuKkMbd9UZwi3cAlwushKXaSSN1MhOnKXP3kL7kWM4hWOkdX4OHcJCasdlqphxRVmIIpve0ydvg3M9R5zPIcIpoC6psbnfmZID/GUsRRMpp3dzP8EO5MzepPdxAlI4TuJoa8/SPQax81Dnsi3ZjJRkFB/1/dPvtSkmP4hUQrsbjCnLt8MmdIrI7eXQxp8cp4ryqjX78HSl7SfTHDG6jnw48f6vahi3Zk6mwuJguZLVTR+IG4uLJdE0ymp3WrYXuznydxeqvreDsPEpnXN0iFEFHhoWiMOjrxsokU4hnte8VtYi01L2E/W0kJhcwOySEtHyusVIxK4iXL01OVq4EIo5uU0myvwgCSMXnsn0dL9MvdkIV3Op+a7l+VUyBQxU8m90rqyzBwlkmTDdIQn1O8cqcTjf9JZHrSgajxzgyjtbwlMXsImhWw8y1IUe+ruG1c6XUHULxVm423W70xj/Y07MUj6SveWNqJIy7i6+BIHV+WuG4esPGMxILn1rgIIENhd9H2bigqCjUjWv0ka6BE2RGbox43B1xr2jVpduahBS0cLdxFH7rL0knRH7evGBeQ7yyICdyLc6qhNgkoRp0uOs3H2TR+sKP8mDh9M8WF79NGlELuY36kKlYpMMW3mZPQiOwS4KP4LYyasPUP+mtu7hSjyyITTPE46msl9Nhu9Asnyjx0FQO2uQsRT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(39850400004)(396003)(136003)(4326008)(5660300002)(7416002)(478600001)(30864003)(8676002)(107886003)(33656002)(52536014)(8936002)(86362001)(66476007)(7696005)(66446008)(66556008)(26005)(41300700001)(6506007)(9686003)(76116006)(71200400001)(2906002)(53546011)(64756008)(66946007)(122000001)(55016003)(921005)(110136005)(38100700002)(186003)(38070700005)(6636002)(316002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k8FdBbm0qbdieTBVaFCw5QGCqmnpRBEGurWzuIHnxcvRA+R+ri5/RECXJrK0?=
 =?us-ascii?Q?RebD7aS30pquciKk0+0W8+1BgASJrBbzr3IaheoNrV5K4Uo31tWnZAbFkWj2?=
 =?us-ascii?Q?51jJIrcmSu5+CFSo/E8pd5DqwBQYSfRIzTYM5G7yr7lRL/e48Kde0ukDmJNU?=
 =?us-ascii?Q?IJXgsW3MMI/4qousfDQR9Cl/rF5wYnRBQUUJB2vTelgDAdrv8CmUTiBFwl0Z?=
 =?us-ascii?Q?zkD6NX4aU6BH18lzJ6M9bpUnr+R8Ubm3negbsSCXAImmCR/495fLoSWcphLG?=
 =?us-ascii?Q?xyD6aoB5CGRWGt7b7dKg/fqLvhyE0MhoVwUQ7GYgIeCgJMm4aj+AO9dvwE7Y?=
 =?us-ascii?Q?5Yt6crfO6yAE5/eC0mJq2M9nG7qSVIen+QFN00e+OZt93witNDS3UCdO7DjB?=
 =?us-ascii?Q?Mn3MAUwvaIAJPgK20P03aahOrvrs0KjRy8wMlREcqeHIdofZ4EzLfziTApXh?=
 =?us-ascii?Q?fmmTkb5SLypTZ1SWMTw/0rK4eDeiwQ/oSP7wAzdczC1bxFhpJ8oogdrZlhSj?=
 =?us-ascii?Q?w8qLUK5f6VKo81Au/rY5VxbB1+VzvPMMJLflTI9PM8kw23wspQu1Pxau8gcg?=
 =?us-ascii?Q?gWNo2nTpuqtzqXqDkFeuQChSOuC2OnWf3cxzqZ7MXN7iN0VqcVhSXYjMfgoJ?=
 =?us-ascii?Q?5SvDfHg2zpm7ll4nF9KvcZbDaKDM6BwZ5seO20EaYQSx4AN4/MaeO1/c1nMv?=
 =?us-ascii?Q?iEUyFW1vq/IqMfKRhSKFihrMlH6j9yavNQLwFzmq6TYnIQX9yQ9BIMKimpnr?=
 =?us-ascii?Q?fcSy8sB5zfxpT1HJG4xZk0EyiDUYkTfOipDggxPFLH4GL1WYOHqOGwyuNv+U?=
 =?us-ascii?Q?zcb030pAx6vB0Nss5G6dK9tN7m43bnX/HNocpEbC5207ZE7m/4q+eRFqYUzn?=
 =?us-ascii?Q?vHjSfMqZ3IHI/lLTeEHsRYlxUTt/8k+YMUnlg9cIyt2moQmKB//BJGySAEjj?=
 =?us-ascii?Q?onr8T4XXHOKwbk5mnZjcU0Byef5DrwRJkgxNmmTfg5ntHuVYbMpW7Csjl4KF?=
 =?us-ascii?Q?57A+me+i2TCjlkASGNtgBlISr+EJ6ZtWxITdjNB8yGyIA6t9ZMEsbpIXmbJN?=
 =?us-ascii?Q?XO0u6KlmaDH9JWcE7diUWFR7fSlevDBBsjoQqeB/ktdmlG2sZkKb70oHo9S6?=
 =?us-ascii?Q?W8ebrycBEevvkUUWYRww7hHu5ahW4RGBXXZwWzhKo5tukBwySNnhHCb4zhEt?=
 =?us-ascii?Q?/mHH/LC+JjUI/Ggqu0eQm1ADcxOjC7Q/gvlznODyj3qDSUqz78toXjqHeiou?=
 =?us-ascii?Q?hc3GvwjB3YsO5nMoGhHyT8Q9r2cDqQzh2uxjUQCjAChJNu84TitD3jAXFhn/?=
 =?us-ascii?Q?sGQYvYVL8aq/A6Ln/uYj4OLnYael/ybXWIqndnItbImUkAsv0x7nR3EzTt/t?=
 =?us-ascii?Q?j2NydhjrTloM1wVCmCjrKv5d42NF1xPK2VVWQQOO0St7rb4Uon1pjFCWoAyS?=
 =?us-ascii?Q?ItCiUNDnxDeWQORTXu8c+6m5uLbWQZVtVO5lGDYTtDHuFWQx8PklcBVBE7eq?=
 =?us-ascii?Q?0RdS3/dyaVPL/llfoGRX2lJcDobre+KTNTlWKNGDcig3AdCvlyDiXtcERHTS?=
 =?us-ascii?Q?fNV6mJX+Ns/DQ2FxrfTuMfRZRu2+XggDNZcRGKoR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65c7eab-e9d9-433f-db04-08da79da3f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 07:39:10.2020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4agYvYHlGs+q0XDLMPvG8L/FFyDZJG2SMYc0s8nU9KwDOfGB+z8IiOq3PnLkp+mV6TxLM3HR+bjh6VIK0COww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> On 2022/7/26 19:34, Neal Liu wrote:
> >>> Hash and Crypto Engine (HACE) is designed to accelerate the
> >>> throughput of hash data digest, encryption, and decryption.
> >>>
> >>> Basically, HACE can be divided into two independently engines
> >>> - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> >>> engine driver for hash accelerator.
> >>>
> >>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> >>> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> >>> ---
> >>>  MAINTAINERS                              |    7 +
> >>>  drivers/crypto/Kconfig                   |    1 +
> >>>  drivers/crypto/Makefile                  |    1 +
> >>>  drivers/crypto/aspeed/Kconfig            |   32 +
> >>>  drivers/crypto/aspeed/Makefile           |    6 +
> >>>  drivers/crypto/aspeed/aspeed-hace-hash.c | 1389
> >> ++++++++++++++++++++++
> >>>  drivers/crypto/aspeed/aspeed-hace.c      |  213 ++++
> >>>  drivers/crypto/aspeed/aspeed-hace.h      |  186 +++
> >>>  8 files changed, 1835 insertions(+)  create mode 100644
> >>> drivers/crypto/aspeed/Kconfig  create mode 100644
> >>> drivers/crypto/aspeed/Makefile  create mode 100644
> >>> drivers/crypto/aspeed/aspeed-hace-hash.c
> >>>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
> >>>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS index
> >>> f55aea311af5..23a0215b7e42 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -3140,6 +3140,13 @@ S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
> >>>  F:	drivers/media/platform/aspeed/
> >>>
> >>> +ASPEED CRYPTO DRIVER
> >>> +M:	Neal Liu <neal_liu@aspeedtech.com>
> >>> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> >>> +S:	Maintained
> >>> +F:
> >> 	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
> >>> +F:	drivers/crypto/aspeed/
> >>> +
> >>>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> >>>  M:	Corentin Chary <corentin.chary@gmail.com>
> >>>  L:	acpi4asus-user@lists.sourceforge.net
> >>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig index
> >>> ee99c02c84e8..b9f5ee126881 100644
> >>> --- a/drivers/crypto/Kconfig
> >>> +++ b/drivers/crypto/Kconfig
> >>> @@ -933,5 +933,6 @@ config CRYPTO_DEV_SA2UL
> >>>  	  acceleration for cryptographic algorithms on these devices.
> >>>
> >>>  source "drivers/crypto/keembay/Kconfig"
> >>> +source "drivers/crypto/aspeed/Kconfig"
> >>>
> >>>  endif # CRYPTO_HW
> >>> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile index
> >>> f81703a86b98..116de173a66c 100644
> >>> --- a/drivers/crypto/Makefile
> >>> +++ b/drivers/crypto/Makefile
> >>> @@ -1,5 +1,6 @@
> >>>  # SPDX-License-Identifier: GPL-2.0
> >>>  obj-$(CONFIG_CRYPTO_DEV_ALLWINNER) +=3D allwinner/
> >>> +obj-$(CONFIG_CRYPTO_DEV_ASPEED) +=3D aspeed/
> >>>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) +=3D atmel-aes.o
> >>>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) +=3D atmel-sha.o
> >>>  obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) +=3D atmel-tdes.o diff --git
> >>> a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig new
> >>> file mode 100644 index 000000000000..059e627efef8
> >>> --- /dev/null
> >>> +++ b/drivers/crypto/aspeed/Kconfig
> >>> @@ -0,0 +1,32 @@
> >>> +config CRYPTO_DEV_ASPEED
> >>> +	tristate "Support for Aspeed cryptographic engine driver"
> >>> +	depends on ARCH_ASPEED
> >>> +	help
> >>> +	  Hash and Crypto Engine (HACE) is designed to accelerate the
> >>> +	  throughput of hash data digest, encryption and decryption.
> >>> +
> >>> +	  Select y here to have support for the cryptographic driver
> >>> +	  available on Aspeed SoC.
> >>> +
> >>> +config CRYPTO_DEV_ASPEED_HACE_HASH
> >>> +	bool "Enable Aspeed Hash & Crypto Engine (HACE) hash"
> >>> +	depends on CRYPTO_DEV_ASPEED
> >>> +	select CRYPTO_ENGINE
> >>> +	select CRYPTO_SHA1
> >>> +	select CRYPTO_SHA256
> >>> +	select CRYPTO_SHA512
> >>> +	select CRYPTO_HMAC
> >>> +	help
> >>> +	  Select here to enable Aspeed Hash & Crypto Engine (HACE)
> >>> +	  hash driver.
> >>> +	  Supports multiple message digest standards, including
> >>> +	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
> >>> +
> >>> +config CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
> >>> +	bool "Enable HACE hash debug messages"
> >>> +	depends on CRYPTO_DEV_ASPEED_HACE_HASH
> >>> +	help
> >>> +	  Print HACE hash debugging messages if you use this option
> >>> +	  to ask for those messages.
> >>> +	  Avoid enabling this option for production build to
> >>> +	  minimize driver timing.
> >>> diff --git a/drivers/crypto/aspeed/Makefile
> >> b/drivers/crypto/aspeed/Makefile
> >>> new file mode 100644
> >>> index 000000000000..8bc8d4fed5a9
> >>> --- /dev/null
> >>> +++ b/drivers/crypto/aspeed/Makefile
> >>> @@ -0,0 +1,6 @@
> >>> +obj-$(CONFIG_CRYPTO_DEV_ASPEED) +=3D aspeed_crypto.o
> >>> +aspeed_crypto-objs :=3D aspeed-hace.o \
> >>> +		      $(hace-hash-y)
> >>> +
> >>> +obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) +=3D
> aspeed-hace-hash.o
> >>> +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=3D
> >> aspeed-hace-hash.o
> >>> diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c
> >> b/drivers/crypto/aspeed/aspeed-hace-hash.c
> >>> new file mode 100644
> >>> index 000000000000..63a8ad694996
> >>> --- /dev/null
> >>> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> >>> @@ -0,0 +1,1389 @@

[...]

> >>> +static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev
> >> *hace_dev)
> >>> +{
> >>> +	struct aspeed_engine_hash *hash_engine =3D
> &hace_dev->hash_engine;
> >>> +	struct ahash_request *req =3D hash_engine->req;
> >>> +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> >>> +	struct aspeed_sg_list *src_list;
> >>> +	struct scatterlist *s;
> >>> +	int length, remain, sg_len, i;
> >>> +	int rc =3D 0;
> >>> +
> >>> +	remain =3D (rctx->total + rctx->bufcnt) % rctx->block_size;
> >>> +	length =3D rctx->total + rctx->bufcnt - remain;
> >>> +
> >>> +	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> >>> +		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
> >>> +		  "length", length, "remain", remain);
> >>> +
> >>> +	sg_len =3D dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> >>> +			    DMA_TO_DEVICE);
> >>> +	if (!sg_len) {
> >>> +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> >>> +		rc =3D -ENOMEM;
> >>> +		goto end;
> >>> +	}
> >>> +
> >>> +	src_list =3D (struct aspeed_sg_list *)hash_engine->ahash_src_addr;
> >>> +	rctx->digest_dma_addr =3D dma_map_single(hace_dev->dev,
> rctx->digest,
> >>> +					       SHA512_DIGEST_SIZE,
> >>> +					       DMA_BIDIRECTIONAL);
> >>> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> >>> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> >>> +		rc =3D -ENOMEM;
> >>> +		goto free_src_sg;
> >>> +	}
> >>> +
> >>> +	if (rctx->bufcnt !=3D 0) {
> >>> +		rctx->buffer_dma_addr =3D dma_map_single(hace_dev->dev,
> >>> +						       rctx->buffer,
> >>> +						       rctx->block_size * 2,
> >>> +						       DMA_TO_DEVICE);
> >>> +		if (dma_mapping_error(hace_dev->dev,
> rctx->buffer_dma_addr)) {
> >>> +			dev_warn(hace_dev->dev, "dma_map() rctx buffer
> error\n");
> >>> +			rc =3D -ENOMEM;
> >>> +			goto free_rctx_digest;
> >>> +		}
> >>> +
> >>> +		src_list[0].phy_addr =3D rctx->buffer_dma_addr;
> >>> +		src_list[0].len =3D rctx->bufcnt;
> >>> +		length -=3D src_list[0].len;
> >>> +
> >>> +		/* Last sg list */
> >>> +		if (length =3D=3D 0)
> >>> +			src_list[0].len |=3D HASH_SG_LAST_LIST;
> >>> +
> >>> +		src_list[0].phy_addr =3D cpu_to_le32(src_list[0].phy_addr);
> >>> +		src_list[0].len =3D cpu_to_le32(src_list[0].len);
> >>> +		src_list++;
> >>> +	}
> >>> +
> >>> +	if (length !=3D 0) {
> >>> +		for_each_sg(rctx->src_sg, s, sg_len, i) {
> >>> +			src_list[i].phy_addr =3D sg_dma_address(s);
> >>> +
> >>> +			if (length > sg_dma_len(s)) {
> >>> +				src_list[i].len =3D sg_dma_len(s);
> >>> +				length -=3D sg_dma_len(s);
> >>> +
> >>> +			} else {
> >>> +				/* Last sg list */
> >>> +				src_list[i].len =3D length;
> >>> +				src_list[i].len |=3D HASH_SG_LAST_LIST;
> >>> +				length =3D 0;
> >>> +			}
> >>> +
> >>> +			src_list[i].phy_addr =3D cpu_to_le32(src_list[i].phy_addr);
> >>> +			src_list[i].len =3D cpu_to_le32(src_list[i].len);
> >>> +		}
> >>> +	}
> >>> +
> >>> +	if (length !=3D 0) {
> >>> +		rc =3D -EINVAL;
> >>> +		goto free_rctx_buffer;
> >>> +	}
> >>> +
> >>> +	rctx->offset =3D rctx->total - remain;
> >>> +	hash_engine->src_length =3D rctx->total + rctx->bufcnt - remain;
> >>> +	hash_engine->src_dma =3D hash_engine->ahash_src_dma_addr;
> >>> +	hash_engine->digest_dma =3D rctx->digest_dma_addr;
> >>> +
> >>> +	goto end;
> >> Exiting via "goto xx" is not recommended in normal code logic (this
> >> requires two jumps), exiting via "return 0" is more efficient.
> >> This code method has many times in your entire driver, it is
> >> recommended to modify it.
> >
> > If not exiting via "goto xx", how to release related resources without =
any
> problem?
> > Is there any proper way to do this?
> maybe I didn't describe it clearly enough.
> "in normal code logic"  means rc=3D0
> In this scenario (rc=3D0), "goto xx" is no longer required, it can be rep=
laced with
> "return 0"

Okay, I got your point. In this case, "goto end" is no longer required of c=
ourse.
I would send next patch with this fixed included.

> >
> >>> +
> >>> +free_rctx_buffer:
> >>> +	if (rctx->bufcnt !=3D 0)
> >>> +		dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> >>> +				 rctx->block_size * 2, DMA_TO_DEVICE);
> >>> +free_rctx_digest:
> >>> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> >>> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> >>> +free_src_sg:
> >>> +	dma_unmap_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> >>> +		     DMA_TO_DEVICE);
> >>> +end:
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int aspeed_ahash_complete(struct aspeed_hace_dev *hace_dev)
> >>> +{
> >>> +	struct aspeed_engine_hash *hash_engine =3D
> &hace_dev->hash_engine;
> >>> +	struct ahash_request *req =3D hash_engine->req;
> >>> +
> >>> +	AHASH_DBG(hace_dev, "\n");
> >>> +
> >>> +	hash_engine->flags &=3D ~CRYPTO_FLAGS_BUSY;
> >>> +
> >>> +	crypto_finalize_hash_request(hace_dev->crypt_engine_hash, req, 0);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +/*
> >>> + * Copy digest to the corresponding request result.
> >>> + * This function will be called at final() stage.
> >>> + */
> >>> +static int aspeed_ahash_transfer(struct aspeed_hace_dev *hace_dev)
> >>> +{
> >>> +	struct aspeed_engine_hash *hash_engine =3D
> &hace_dev->hash_engine;
> >>> +	struct ahash_request *req =3D hash_engine->req;
> >>> +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> >>> +
> >>> +	AHASH_DBG(hace_dev, "\n");
> >>> +
> >>> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> >>> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> >>> +
> >>> +	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> >>> +			 rctx->block_size * 2, DMA_TO_DEVICE);
> >>> +
> >>> +	memcpy(req->result, rctx->digest, rctx->digsize);
> >>> +
> >>> +	return aspeed_ahash_complete(hace_dev); }
> >>> +
> >>> +/*
> >>> + * Trigger hardware engines to do the math.
> >>> + */
> >>> +static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev
> *hace_dev,
> >>> +				     aspeed_hace_fn_t resume)
> >>> +{
> >>> +	struct aspeed_engine_hash *hash_engine =3D
> &hace_dev->hash_engine;
> >>> +	struct ahash_request *req =3D hash_engine->req;
> >>> +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> >>> +
> >>> +	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x,
> >> length:0x%x\n",
> >>> +		  hash_engine->src_dma, hash_engine->digest_dma,
> >>> +		  hash_engine->src_length);
> >>> +
> >>> +	rctx->cmd |=3D HASH_CMD_INT_ENABLE;
> >>> +	hash_engine->resume =3D resume;
> >>> +
> >>> +	ast_hace_write(hace_dev, hash_engine->src_dma,
> >> ASPEED_HACE_HASH_SRC);
> >>> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> >>> +		       ASPEED_HACE_HASH_DIGEST_BUFF);
> >>> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> >>> +		       ASPEED_HACE_HASH_KEY_BUFF);
> >>> +	ast_hace_write(hace_dev, hash_engine->src_length,
> >>> +		       ASPEED_HACE_HASH_DATA_LEN);
> >>> +
> >>> +	/* Memory barrier to ensure all data setup before engine starts */
> >>> +	mb();
> >>> +
> >>> +	ast_hace_write(hace_dev, rctx->cmd, ASPEED_HACE_HASH_CMD);
> >> A hardware service sending requires 5 hardware commands to complete.
> >> In a multi-concurrency scenario, how to ensure the order of commands?
> >> (If two processes send hardware task at the same time, How to ensure
> >> that the hardware recognizes which task the current command belongs
> >> to?)
> >
> > Linux crypto engine would guarantee that only one request at each time =
to
> be dequeued from engine queue to process.
> > And there has lock mechanism inside Linux crypto engine to prevent the
> scenario you mentioned.
> > So only 1 aspeed_hace_ahash_trigger() hardware service would go through
> at a time.
> >
> > [...]
> > .
> >
> You may not understand what I mean, the command flow in a normal scenario=
:
> request_A: Acmd1-->Acmd2-->Acmd3-->Acmd4-->Acmd5
> request_B: Bcmd1-->Bcmd2-->Bcmd3-->Bcmd4-->Bcmd5
> In a multi-process concurrent scenario, multiple crypto engines can be en=
abled,
> and each crypto engine sends a request. If multiple requests here enter
> aspeed_hace_ahash_trigger() at the same time, the command flow will be
> intertwined like this:
> request_A, request_B:
> Acmd1-->Bcmd1-->Acmd2-->Acmd3-->Bcmd2-->Acmd4-->Bcmd3-->Bcmd4-->A
> cmd5-->Bcmd5
>=20
> In this command flow, how does your hardware identify whether these
> commands belong to request_A or request_B?
> Thanks.
> Longfang.

For my understanding, all requests will transfer into engine queue through =
crypto_transfer_hash_request_to_engine().
In your example, request_A & request_B would also enqueue into the engine q=
ueue, and pump out 1 request which might be FIFO to handle it.
crypto_pump_requests() will dequeue only 1 request at a time and to prepare=
_request() & do_one_request() if it's registered.
And aspeed_hace_ahash_trigger() is inside do_one_request(), so that means n=
o other requests would come in during aspeed_hace_ahash_trigger() whole pro=
cess.
The command flow intertwined
Acmd1-->Bcmd1-->Acmd2-->Acmd3-->Bcmd2-->Acmd4-->Bcmd3-->Bcmd4-->Acmd5-->Bcm=
d5 would not exist in any scenario.
Correct me if I'm misunderstanding, Thanks.

