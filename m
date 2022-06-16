Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FC54D6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbiFPBRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349320AbiFPBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:17:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC44F464;
        Wed, 15 Jun 2022 18:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPOQCKIkxMKdQZEUv+IU8wrrK4z0qa2gf+U/GWZqb+zwQ9iWENveBQUxnIaBq2mTwqZQMqfZlmunU3zil6Eb4sDDYlDAMhRPGDdQT6MldvG4DJcgT+cK5s/tCrx7UwGryBJ4ruTuZ8RpGpt3bSrzAAkr9tIgBOzi77JcRJLGClNDs0/fGmQOrntipvq5Hlm68FJX6GKj7rw2yefUIg56HKbF+K4lvIGwdCQawg1VOEzAq2gdONFAgJiVeRr/WfrKifMmUuF3r1lQChxl4S2kPfsR7yq3Q7y9qBn5AezxK3V/OQN8g5Hn0mxSNZmILPUp88V2ZRYwOm7Ph/cQFnHVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ef8zPmJLS6z47GZMPpgaxyOba4r6Z2E4bCExiDwtCA=;
 b=OzQXuN8Q1qMUCghferkYXnRIZMIo65B8NN4p5qgUclELhoj1hLYNymgV5ONQ97tQyh19fx2apXRH8y7XUY1uCPx3sHPv050/z/2074q4TfWEG2uMaPJzdjZ2wEwUP9Yxu44gZxwGS2Bgv5iNj65D/fLQQncflghtBo5MX0ZsEHsky/x3+aPIh6UUKN5kRFkkN/9Sd2b6ay1BAqdwZnc7CX5SPicZV6HFLDsjxxKUuHp2vKusNnJZd8AuAxkn8kAOvcmT8BmU37so20EhiSKKAG3f13xoDRCiBH45AP4wgjiOncc4BPbuZ0XrcIY549IqAucKwkAFgYgioxeA+qv1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ef8zPmJLS6z47GZMPpgaxyOba4r6Z2E4bCExiDwtCA=;
 b=mtsMMkKzPbPBy6EeLatRraU6Ce5ZB1DvAu+XzMa4ruuJfNyr6T0skupVoSr31dHYOWxzBZXTNzaxE583lNroDhfo3dhn81ap7fWD7pTxSHMQyTSpAMs918Bwnr1TYE0AbHmwl5SjV94NeA2AiPjkXrAe9V2/l3OvSu7HcKjFsnmynQX7XvbcCMZ9AAp/OZToaFIcF/9IKyIxDDtBHVTRKvFV8EWSIwrliecoAWB5e4DPInJt3vZm+rRwOrNsdweysy56bLu1S4psR2bg7+fE0yN/7s0cK/h3fO4A/OAjOCy8wXo49SoOce+oRFx1OHLabqqAFWQGjiNyyPw8h6c65Q==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYZPR06MB4511.apcprd06.prod.outlook.com (2603:1096:400:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 01:16:56 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 01:16:55 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Repair file entry in ASPEED USB UDC DRIVER
Thread-Topic: [PATCH] MAINTAINERS: Repair file entry in ASPEED USB UDC DRIVER
Thread-Index: AQHYgPBgwNpldfk97k2qy8dp1n25lq1RO3Fg
Date:   Thu, 16 Jun 2022 01:16:55 +0000
Message-ID: <HK0PR06MB3202DE01EB506DC97EBBD60E80AC9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220615194409.11875-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220615194409.11875-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcfa84af-bc07-4440-aee8-08da4f35e734
x-ms-traffictypediagnostic: TYZPR06MB4511:EE_
x-microsoft-antispam-prvs: <TYZPR06MB451162A7D0D100BB5BB5ADD280AC9@TYZPR06MB4511.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rxw+k72nnFKkSD6Yve37dgaQAvLuqBEaCI9oaKDAdSOKTxOVkPJKcvZIQOEMjIRGR9dlw2uSRQKzuEmvvnVRo0wIMoFYq/lrxsoFFazXVGdaoL3FAQA3a2SbmdPAzi0+L1bsYqhXkFzA4B5uCFWPoodjDqhMuNSdZCG8RAeNgLkIrW3xqNZhEnn+V9euXzpInWt+L0ShrpOqtsilCN3s47OQ1lkTNXzV5vT9HqlmycbLgRugkQZE8AUTRmczKBXb3AJpU7HZUzyTy7bIC/n13f+7xxJ+QlwrOvwjXr7MiO4Li9u1vlyNsNgi0BpSVuHAwJlSaAK7hzA+qOwkRDzBADNao2B5Sv8/poTSIWT5KluVJH1QlGkP5M4ZWEMLo0rD+ECLAqxywcyajEXDoRDkKQn2aY+i1LQi57euzT1vKq/sIK2Fin1eOKDcVFLUy9rbp8v9kRbJTWhFn7gSra31wCJk/zQBD4hSBbuePL+xduiwHWFBlukqge4hxe535ccTLMx/bR4s4ZHkpnmtQ8dCZqsTCLLHdcqJOzgJ3XPH4rClrNokxypA72MeJK/G9lVpDV+ZdAOdpFPMqyYMf5ypXoeGbl6ocTVHcOz8DJEaFwilkdMFMvTGtfM2M8aF6OB7Ui3tQRCDuTKg3WqHxryQATwNAmigpsoaPk3LMh0yCQqTdj7rTLvjCadiuwLg+lGoBLyyYaG5YMb0l3BTkaryA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39840400004)(346002)(110136005)(2906002)(55016003)(316002)(4326008)(6506007)(76116006)(33656002)(86362001)(26005)(54906003)(71200400001)(9686003)(7696005)(508600001)(41300700001)(83380400001)(38100700002)(64756008)(38070700005)(122000001)(186003)(8936002)(8676002)(66446008)(66946007)(66476007)(66556008)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mebm6Lm95ZJE3GrEwTLnkjH9E4uAmdlW3FATth5AviQC26lWkVv8+0nG6LEW?=
 =?us-ascii?Q?BX2erlGJouQaelpKh7/kJCpDPHeSLbFnFKxmPbWgmXmdy+4+1jwzeCr0DOLc?=
 =?us-ascii?Q?1sAHctuwR/swo+VYlc6bSK9BXCgsAj4g3xX1CKdHTIcKs5wrDPnW1LhQLImt?=
 =?us-ascii?Q?ltHd5jmZ7UL2AYFcuUYM0hiOehLEoYgrioBI2wryeyYOS3UMgX4F/pSgf5T2?=
 =?us-ascii?Q?MJvEOmnw2wTCvPi+Gg5NfffMA4KHSacyBTR5VmEtbbZrMuhoJawlLs4qF6yT?=
 =?us-ascii?Q?cWbzWFgHwOfIZFYIiyH/K9avfJsgbcFDjNAsmxzcghcLSX+7/a4JwguJ0Oq/?=
 =?us-ascii?Q?LRAqoMcS8Rm4AuX1osSpgmyNZV1Yry2SIBql5wEShI//2vvis8o9MtnpynaF?=
 =?us-ascii?Q?mFTdP9yQVZzVhc8Y985pe284cl1yucgeQ1MyGDJL22RIOcidR1K1r5rrC7ax?=
 =?us-ascii?Q?z7htIACNvTVwDS0mU7nQ4Vp5zAI7q7juGLrlKY+zHfmcNimLU8zCGnFsz0dh?=
 =?us-ascii?Q?fnVHoDSFsAJ5TVNgpLRKWtT9zeYdA2orlsczIVUa7r6/SG6W9ANl3JU/9CJ5?=
 =?us-ascii?Q?HREp/Zdy/6uF9ZAYzZpjkg1W9287PP1X7U8zaMWaBV27J1A7OUj+kz0YS5fx?=
 =?us-ascii?Q?TZJ9fe68RDDvDnoPROkdl6Xhyg9CAVuxU5xLA9oFka6q2tjRO15aQW4qrPNB?=
 =?us-ascii?Q?McM3iDIkQFbcXJNNmlhTdcDdLbK5crp7gcc3cq4CH0Z/UIpDZgluRfSFEFBq?=
 =?us-ascii?Q?opxyC2d9gAUyEt3VuZYCP5d6ylVndX/K57y3YteHFQCh54+kFUctpEhrZQkF?=
 =?us-ascii?Q?68R7It9JZm+o0ASmlN+Nq9O6lu3HvWH2Le9yV5hXpXF0vGS9gSRT4cVYQdIj?=
 =?us-ascii?Q?WQTlz1pDTn9sWLZAuvbgaOWE4xV8JkkEPYmC20HuIP5SDTtWaLjjg3agrLje?=
 =?us-ascii?Q?X62nzZ6aq3kyVxd1N0Us8QWDnr4YYPufQ8OLGXJE1D60C7yoLEnqxyfLqx9S?=
 =?us-ascii?Q?CD7i/AUjLpaN0SRdh/S1WeM/DsDv/N+sE6jYWQIHHMjN2SHT1xwg4oRtxKj8?=
 =?us-ascii?Q?5P0yI1+TjHE8IwPJTXRnOt93lbWF+QW0NY+NGZz/Yb613xeR6Su7Bxp563iW?=
 =?us-ascii?Q?e5xA8e0WAcHHeGyuHSlsYdntyV/NJVw8ebO5FbkQkR7qWjAjxtIHBaGRtYPm?=
 =?us-ascii?Q?a/lwk1JnBTJt2zMZJx5C/y/5M5ahGE4LucrPb87KRK7+IKK2UtHEZQVzttcf?=
 =?us-ascii?Q?rWuvwZMA2PwD+0S6uRz+vg5Z4wmPkOx62EGjuR3g81EsKLh51lcI67DoSVxv?=
 =?us-ascii?Q?9ngi+ZBTSGXIUQTMKxZ9J4OvyJ2wAWKfFnUz5gFpfNfcDkDHJa0uCx2qBhAw?=
 =?us-ascii?Q?tRgmXClzXP0C6vaKtDrWqKIeCaXkgPDwy6kkotjd7N6Es+9I12XEk5Of1HxN?=
 =?us-ascii?Q?ncSyi0bwN1lnNiDenX/XaM0wcnaoqDdGvRllNWx+Z9gKpg2YhUC4BzZvqbRr?=
 =?us-ascii?Q?cfEXPZXbwCu/z1nlfr6df+GyRMgunyWkl6GDYgAbv30KlpA+Aek3eN9pdB2R?=
 =?us-ascii?Q?qCqMbDzG1ta1lJSRPzKKgqi0nC0Gsg/cv1SRTNbDyG/h36J33eQbsxs4zjby?=
 =?us-ascii?Q?4MClJQ2Xr+4D/J/fioJEwSUS8vrFoMffT8XVvEhU8YL1ny9kwZnRxT4gGMt+?=
 =?us-ascii?Q?0sI4kL7SyHM9ucuB0RnoTknL68Jy+RGrrYqxjPMNwYiBNrFze2S4SqWYYSZc?=
 =?us-ascii?Q?cMS+A/9RPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfa84af-bc07-4440-aee8-08da4f35e734
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 01:16:55.6728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5t9tAPO3+K9kXnAL9rz3976HBbewoKs7ZQCclWL366CVsY5B2QoiEcYtFL/KLYKooRUsSMeTsvMZBM7a/lUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Commit 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver") adds
> the section ASPEED USB UDC DRIVER with a file entry to aspeed,udc.yaml, b=
ut
> then, commit 0dde9a46a2cf ("dt-bindings: usb: add documentation for aspee=
d
> udc") actually adds a device tree binding aspeed,ast2600-udc.yaml.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>=20
> Repair the reference to the actually added file in ASPEED USB UDC DRIVER.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for the fix.

Acked-by: Neal Liu <neal_liu@aspeedtech.com>

> ---
> Neal, please ack.
> Greg, please pick this minor non-urgent clean-up patch in your usb-next t=
ree.
>=20
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9c3576b082f..8830d1adb23b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3144,7 +3144,7 @@ ASPEED USB UDC DRIVER
>  M:	Neal Liu <neal_liu@aspeedtech.com>
>  L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/usb/aspeed,udc.yaml
> +F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
>  F:	drivers/usb/gadget/udc/aspeed_udc.c
>=20
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> --
> 2.17.1

