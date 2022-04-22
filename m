Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E150B7BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389681AbiDVM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445713AbiDVM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:59:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217B57155;
        Fri, 22 Apr 2022 05:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwfwKgpAoflphA9iNFIFoVG85W3UGdZGMWu91GazDPfwafrTYroTPGuYYYGkaNcK/9MQKgZ9R6GsIfKe8rFwspCgIbxpTo2LiCeFsVlX5QXha2czSaSX4SuDUjdQzkb2crjvN0Urs6C+vPHklB6TLAGBB8D5WdBnmPltQjwa9FWOYgOHgMhYnpRGk3WDkwsT+5d6UE7XQerd0I0S36kFvR9/xCpm4y7wvOjUh3fKfK2DBQcqRcDZ4XlxeEoaWfjK1sVULUNDOKZuW8oQwfsXxq92OTTICjbKkRLEkGTnzjcQ03eCNgYbJcknpmIT6JEn6FLEoGJWDfa8rwdRwG+54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEbTlEHBco6bM/sBsZPaWqmbm2GFOUKzhkIYsZxfAx4=;
 b=WnWBQHZFq3Fe5MTTD7mMOMvWTKAxHrohAwL5/03X/YY5coJIjWAk6XfNRBX52IObqO1xzXnodrH1bRaiK4YQDvd4+4IELHZyoCknru1Ykm3rLMix4k4v1+yl9HOvF4j8nzkCfnEp0kjLCN2gD4IpBFPweXPq3+UNbNb/QrCSFcbV+q0J0WTZm4uXR0kig4bKm/NEJiEfpwze7EK1w9YOIK6omAQ89hHFG++A479N6jSaOI3d2QmYOjl2StuyDvR+NMYadnMUf9J36Kt/2BOR2DIxErcM1O6ypBWc8eLmW9/9PYca5yuQIyfGo87t7jnBu1F3znt7pHS66Wf9Ej7IZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEbTlEHBco6bM/sBsZPaWqmbm2GFOUKzhkIYsZxfAx4=;
 b=iqUWhsh05mrT/jj40pykx+R8EjiAMNp2IACY96RrC5HwepOajmWKtNCSfwI124cZTkWUxfxaLkqun8HI9PTuAh8DcOgqrWAR5oSpKwxFbsjVv+nvS8a6hcgFvGAOiLsrboVbLk1NZrHn4A4aSM0rQseucj5upXhM9H6/48Ds1M8=
Received: from SA1PR02MB8560.namprd02.prod.outlook.com (2603:10b6:806:1fb::24)
 by BYAPR02MB5862.namprd02.prod.outlook.com (2603:10b6:a03:11b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 12:56:52 +0000
Received: from SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::f8bc:753c:d997:24de]) by SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::f8bc:753c:d997:24de%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 12:56:52 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: RE: [PATCH] gpio: xilinx: Trivial patch
Thread-Topic: [PATCH] gpio: xilinx: Trivial patch
Thread-Index: AQHYJ+5SXJDI9ULDFk2U38/oBwuucqz8Ps4A
Date:   Fri, 22 Apr 2022 12:56:52 +0000
Message-ID: <SA1PR02MB856096D050BE00410EA3A0E2C7F79@SA1PR02MB8560.namprd02.prod.outlook.com>
References: <20220222131548.17513-1-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20220222131548.17513-1-shubhrajyoti.datta@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38bc9999-d29d-44b4-2502-08da245f92b6
x-ms-traffictypediagnostic: BYAPR02MB5862:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5862F9015863D7CDD3F78AA4C7F79@BYAPR02MB5862.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78qrvI5UTgx0mq7QFpC3mcXKhy5mWXOTSkVHNMfRzwzATcgO5mX+5XkZvA5v8OtWx2sSfXmoOmfJf1lLR8YBLTEEWO/5GJbNYBd6RMJ2ZrmLsIZs7iuXrEO94ZT/UZ7xuYjyejaAHCKLWfCZP0vlxxJ4sCFtp9AzjDAiOlyx3FhmTfWrBxsWUUjSPCNAOGeCt0kvUek13XVYXmbmJ7+q++w9Dv7/j+YmTuMq1+WjTaP0ZN1ama/MdJTIM9nh6OfBJDF5iOOC1AuJf+/lf2fMjzEI1XVK2bRLiQOC7hzSUAs89D2K8G+MOqWwh4VX3+Q5iIsKnqcvQVn8XkFPFBQ963kTv2DbzKmo4jPl8svth59pODxG8C6hjAeAdPs9II2fz6UsleYP6M5EMS/QP1emsGs+V8og2HdS/LWPTdQcS1xYpvLi/Yw4v6cMtWEK6uKbSSagMWTla1R73gsXmyFy+jw0AJMB+ThSv+Ow9f9/FNotiqKA7iMFzkZPsVpalMY/dTHohSn0puHpJfT/Nh/L6gMGcuBNwuMU9shagA7GarH40ZtF4eh+eHKT/v3iw4uFGhWfxXj+3ckNp9jZhlXRAPuVDkIjrkNHreBGyv1UJURcYSm1qQjxhaLsOlaftRDqtENrtl4ss90BA372vV563PqaTUfsRf2jL+p+oLQ/4wUCIsPM5u+rMXlX2/y1df16vFZdvbFm031r3OqFMJ7VlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8560.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38070700005)(55016003)(38100700002)(508600001)(122000001)(52536014)(71200400001)(8936002)(83380400001)(107886003)(54906003)(86362001)(26005)(2906002)(33656002)(5660300002)(6506007)(9686003)(53546011)(8676002)(316002)(66556008)(66946007)(76116006)(66476007)(66446008)(64756008)(110136005)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9GT/aKIcfu8/vNu67Z47Gv6CGG9M8ErxoDQEyhmDh7lNijrtZnP7dwNLAL2?=
 =?us-ascii?Q?9/7kxxwytSqi7PqkeBJz9lpQA0wQqdqk3+9AoAzCNsWxd7GMFWGGHsaQ2pgG?=
 =?us-ascii?Q?Rt1FaTMAwHlyPOWCr7yjONexsiZHSjK3naAYBOdXYXN/KnAuchPiEiSay022?=
 =?us-ascii?Q?Oj3JNfDFW9ojr0fA6WP2zg9efQVE68ZT5VzqFaeISisBidiwN5H4ofNtEfWL?=
 =?us-ascii?Q?xwMkbOPWswrBKU4+4WTOjdDg5e0+XJOwJhNCMLuqj7LEi9+315BjgxfPHCbO?=
 =?us-ascii?Q?vuLbobfU8QFwayaJVGonTnhrHqUXJlxNNCdy5VahoFzCj83IQf5gqlCgk7SH?=
 =?us-ascii?Q?7w/ea20S0iEDOhZlBC6XVoCSSY7MYIUK2+uZn2NNM90C/Lz272Y/JAqiwTkz?=
 =?us-ascii?Q?J8g9zpgIFoVJ+DAjv4NeBh/y+/A+kfGOCMshWd7Vog5k/W6km+sJQa7DkCzt?=
 =?us-ascii?Q?6nCw1qTooY2k0PKde+eAI+gkVrFvIs19irJncmyMGTQ8c4NTBlyH6W53G5gf?=
 =?us-ascii?Q?WScQoWeSwh7xsBrUJ7E2ayp2en+J5I+w8o2x0VieDfWEsKC3FrcT4j9sR88t?=
 =?us-ascii?Q?9FVu2ttUAN+xiRKe4/l7CHPKIzBMpDQGTXbN13LidGEisgKVLzVm8KfG7kHf?=
 =?us-ascii?Q?5FTPB9u51lUuPh5Va57GqExQWkIrv8HEYngqCF5DmbT8+dRZ7Ez7LV/onp4C?=
 =?us-ascii?Q?uw7Gcmr6hivGLGBFdoRISwEK2uxrA1Jl0G0D2YrREoHX4b2NAc4a05kYHMyf?=
 =?us-ascii?Q?QcNcQo8bHpDzcUssuV9zXoZ2JWUr4Mx/fx/spJW+1dmosSDkyxmR4O0OtWAE?=
 =?us-ascii?Q?Ri1l7+czHjuQ1M430lxGLMjvB8zayi+mHiNJ64wGhmE1VAcRKKU/ao6C+FLy?=
 =?us-ascii?Q?+UVGp69/pMiNxo1/eeO4pL89rNioZD1oj9mMsEuCb/ViAslial+KJg8RNDWA?=
 =?us-ascii?Q?AQiKxQAG7fJoOsTNsX5/wZrxNcI95NIXc2TbSp/3qmhCpWL3ovgL7MDElBnG?=
 =?us-ascii?Q?Hc1segpeiR5IEJb4GYtzHMof3pQ4dmfBPh3NWzWotk/eGr9WyldJ0k1QVJwd?=
 =?us-ascii?Q?61mU+qETK4YY3pJ+c6yPEkIsHHCSkZyUjWYcJzfdMxbZTHd3YTZnkRZYyWvR?=
 =?us-ascii?Q?+b6tOcSLJzS6YMDzY+dL5Kh0EwlMbGtynHALtiprlggB3ABEG0K/JYoMum+d?=
 =?us-ascii?Q?+ISy97yihgjbdjz/lMLQSTANG+dDdyn5YsitzAkv7qiNQRSpcMjYHTBPgs4g?=
 =?us-ascii?Q?mKCaASTJv1eqmEAWdL+IAy75/N0tX9kAPPqBLB96I4F5uo/fxrAk9OKhInCi?=
 =?us-ascii?Q?M4eqCBMJ2kbWWkrByvuD4GHWBSNw7zTc5dXr540lsa/x9KkjWhjrRkxkdRxQ?=
 =?us-ascii?Q?laVd5F5Cft1UnQXblUWaM/PPARmyzNLBrwWPbfHQpVc/3wvspeSjpvgPxJ5V?=
 =?us-ascii?Q?8AbXzklite1xloAZou+ruCaaZG4wjoHhsZtDZis3Cc4QkTNwmm7ev+s9ZPRh?=
 =?us-ascii?Q?H4UsTrHbPvPbWO7M2L0vrMy2dXZoj31Maj0e6yX+NeRzWxL27DpQN6s26iqE?=
 =?us-ascii?Q?Wmsr1IiCuxuB+W7XrNdDAmbbEHInFMNAlG7Kjqt70heiU0mcmjkC5IxJiDnc?=
 =?us-ascii?Q?7KbX/xjJrkhOkQoPU0l5VFI8NiLaprEhYRUM9RuDv1TXkN+pr0ID2Mqe+0h2?=
 =?us-ascii?Q?/pYT+7pZUOduVKeBTGZ+zFUQCYuOYHz5xsdtKBkH3L3+VSnxH3nn6eU1HTrI?=
 =?us-ascii?Q?aEKpyjXPQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8560.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bc9999-d29d-44b4-2502-08da245f92b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 12:56:52.7781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96vXn7MPt4bVKln2y+aXsUcaRF5NDbN4PyVXcMWGImNvVsnCEIYlTyMtpbGJOcH47CEZvH9QPZjYSzXcTJF8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5862
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Sent: Tuesday, February 22, 2022 6:46 PM
> To: linux-gpio@vger.kernel.org
> Cc: git <git@xilinx.com>; Michal Simek <michals@xilinx.com>; linux-
> kernel@vger.kernel.org; Shubhrajyoti Datta <shubhraj@xilinx.com>
> Subject: [PATCH] gpio: xilinx: Trivial patch

Minor nit - Better to say about the change instead of "trivial patch".
gpio: xilinx: add missing blank line after declarations

>=20
> Add a missing blank line. No functional changes.
>=20
> WARNING: Missing a blank line after declarations
> 128: FILE: drivers/gpio/gpio-xilinx.c:120:
> +       void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, b=
it / 32);
> +       xgpio_set_value32(a, bit, xgpio_readreg(addr));
>=20
> WARNING: Missing a blank line after declarations
> 136: FILE: drivers/gpio/gpio-xilinx.c:126:
> +       void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, b=
it / 32);
> +       xgpio_writereg(addr, xgpio_get_value32(a, bit));
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Thanks!
> ---
>  drivers/gpio/gpio-xilinx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c inde=
x
> b6d3a57e27ed..7f129e7eae78 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -117,12 +117,14 @@ static inline int xgpio_regoffset(struct xgpio_inst=
ance
> *chip, int ch)  static void xgpio_read_ch(struct xgpio_instance *chip, in=
t reg,
> int bit, unsigned long *a)  {
>  	void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, bit /
> 32);
> +
>  	xgpio_set_value32(a, bit, xgpio_readreg(addr));  }
>=20
>  static void xgpio_write_ch(struct xgpio_instance *chip, int reg, int bit=
,
> unsigned long *a)  {
>  	void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, bit /
> 32);
> +
>  	xgpio_writereg(addr, xgpio_get_value32(a, bit));  }
>=20
> --
> 2.17.1

