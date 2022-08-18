Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862FD598B31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiHRS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbiHRS2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:28:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2098.outbound.protection.outlook.com [40.92.41.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01C32D8B;
        Thu, 18 Aug 2022 11:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCfPaMHP130j5G09A54Krsea4P6kvh22hscrcWq9Z7U4ABhMWZmph3WKOvR8ykkkPefSfzdidwSdCDDDiw5uU7S8QIdj6+UyAhHM+U+BsznpftE+u+QHGP+aUZNtwsbirla+NtHL017KWq0uGSuFrNewxCl+ZBahhaujuSsd8EMPfIn67Xn0O0trWNO4EvV1YYqvZJflbkn3IudsWUr0AsyxBsC8EJXaK6jZYO4p5SzQdq0vOsSdOJ0wPccl3rwSJq39sPVxdbrnge/AmbtBHSNZQayAhl5htf3VS77NdWoM0HjR40Sebdpnzc351bCkJ6LP6CnUXXlRcyg/WqH8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xawoA86fzsEa+JCL6nr0tDPbuzJ2lvUjgLexXhPA0is=;
 b=lockPdETq3OYKVIBhjDuq6Hk+ydea894YnvW7xCPbchmTseoZy2sbWwwwwRg0Ag7c7DKORfc7VdRjTYZjWlnVrAHwWvpucVh8jVGsMu869ZcBvS5lMEzxBunkoq5Hck2AP6pTqR4kuAcsjst7XFRt8MVx34Iw9xMDQvg2A/P5R/JcLZax6yhW/pkoWiF03qOs9uwQ6VF7xijpl2dSa2vYE+GewY09NJ/jLPU51DzJUa7O+EcuKHcFx1W0mLyQRIOOd4QOydC1P/Y9J3uNrXHsanrMbzZW2dCEAW+qQqKFQGhQ6nrJTQAuddczNDlgxdUohawF5WQXj3njoXihdtrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xawoA86fzsEa+JCL6nr0tDPbuzJ2lvUjgLexXhPA0is=;
 b=OHAddYOsbygptEvoQWVFsoX1WNDZ+D1qk/BmndNi7X88YOBxg38HK8618swgAOh2vP1xaRmUgButREd2W9ZzgPG001IDzwfB0Qr5VRNZwZ4DBtgbpnmXPPXEJer4aZb4JryNpTPAJMqC0kaesmKLAmhMO/rAeKmbtWtf9fMGqYqQEb7jDxfw/RiLQubPi3vCDg8Q66jpFQAt0fyN7SlkMhymrFV5sKQhRHiiykR5LhApEqRo2d/yAYE9oDxKIw0FM6BdWfaJeOIxdtQ/D3uEhKDxgkV7H9khzXiAMARozcCSqfqYT6ZhZm/CvLl6vLpxEKC9BeTJHlxNpF4nve7P2g==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by CO6PR06MB7345.namprd06.prod.outlook.com (2603:10b6:303:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 18:28:45 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e%4]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 18:28:45 +0000
Date:   Thu, 18 Aug 2022 13:28:39 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/4] iio/adc-joystick: buffer data parsing fixes
Message-ID: <SN6PR06MB534245440C9A0EA1E0C11B12A56D9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817105643.95710-1-contact@artur-rojek.eu>
X-TMN:  [Eec70N9eyO5HUp37L5lEvH7rR60u+0Sa]
X-ClientProxiedBy: SN1PR12CA0079.namprd12.prod.outlook.com
 (2603:10b6:802:21::14) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220818182839.GA24350@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73229ce6-6db3-43ac-59ca-08da81477bd2
X-MS-TrafficTypeDiagnostic: CO6PR06MB7345:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zedhfNtkqGAHPYRGu+4CX1twqJd7h8frTfLmaXMH2dMbUsTUQPdlOylU02860W0CvosjPRp40abKNfUGCzwIt8SdY7jwgem4qFBZXfGTI8mJMtwaToiJskx/KT6EDoLaY12GA6ji3QoSNWEgOYxb/DEpqCwdJG2AVrYqE21CbjR/fpUMZSNN/A1iAVd7qzfrLGSvcEwnmt3eHUTaoYK5aNxSP9kGGRp1aWamgqlVuAQlfxYOl32ALkF1+obDZF5F2e/wBxN/bNdEEAkxIDdFCulNed49jzPRv1KYDlxbWcC/zRlE0wnR/PdF5lY2qfvN9jVPQZkQuxDvfVr2cZj0IAl5tdS3WqDTjnEECn0dSti+6Ij/L92m7N4bnp9hH4fk6tDrYTKJZjVjtuA+7PRHycht7HA2jSqgioraWOy5Z7pU/SxBwFCoOlcXZOUBiaRb1ZZFhKxrb9eD6nvrAPScE2c1CiHAj4XD7WzYBMPLSfyCj/NxkDpJdanU4DVjh5c17JQDrt7cpdCMZikwN2e597USBU3te21ftLZs4poboyDGTXGM5sKDIqzYDaFwzTfIwZE/yqgzVNeIBcxL69f15+iLP2H8yLJtJ9WAFjBIKGwQEoA5ajyCyM4faVt+k3a/UeKRfpywsKjuH5wIqU0sJQO1+PNrTRnS3/9Bwr8sNaWdXtfRKygBcoVfHkOclOaf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24wnFuafXrkPMzlMMnc1H8Gy9i8KfSjjfdk3x1T7h6L63PHZjbHjrNIg5fsd?=
 =?us-ascii?Q?rodWFsTICodkZPaXFYCizAE4zFxWKp8pGFdokErQleknPui4OUCqOwYaZWti?=
 =?us-ascii?Q?JH3fMvTsrcy4JtlBd+zpz+SKD0vqI/fqiAa2AOaJb9yRtxb3MbQcu32Nipc9?=
 =?us-ascii?Q?zlHG45BnP5SVUFprrqPFlUBjk0Ew5LZbpEwTCPyJpkeV0MfQJQT8MLxKTI17?=
 =?us-ascii?Q?rQWVf+rJ1+KgwYWXwGm88k5YbajOSRWWLD+nzbB3NzVW2iuaWKvmKFdGu9Cb?=
 =?us-ascii?Q?nQEs0ITLAkh19YfDNdiHetWdeQToADB5wpJ3qZgT/ljKAmMQgq+dCxJs8eza?=
 =?us-ascii?Q?01HhHS6nQ9JBKRji//Rld9mJ1x8p3rl9ao5dKDU7J3nVxvB4BUAHVgnEPPPI?=
 =?us-ascii?Q?gDLDakIA/HIPS5irV9zL6OPXc9tc9/MGVyii2gj/xEJk/xGT1FkxbRCAgZMh?=
 =?us-ascii?Q?LuXcuzqEZ8/1LjP7eobXDEvT2MxlcprRoJ2hWcD/sPY61d9Uhi4e86Y6k/Bv?=
 =?us-ascii?Q?m1PVn+HT8PQE6AXHyLr+1C0goAGi7BzG+0aana3eJkzDsbAskrokpYxzZucR?=
 =?us-ascii?Q?8s3Ps/kavaraFK4Rc2qXoXIjGvWr4TRNnUgC2qXFDUGuINbbbUeoA9w+eFmB?=
 =?us-ascii?Q?PzckaBwAd0ca9JGlMwSN+/2bFGzG6pgIdGkJDF5tOF+MCcf4240Gt6UErIAv?=
 =?us-ascii?Q?MBPm6aw8loWOn/rfnu8+qbtVoLllPEEPiVnJzuTebXgXJYWZTPiEaZGu1QQh?=
 =?us-ascii?Q?bo4Mrj/vrqWpY66AkBWk+n8mlqG+kcsm7tWtXvw4oxsp3fZ6GoYbCdNgXUq3?=
 =?us-ascii?Q?FnZrMHkXE0FurN5gajyHux0PFe7xgWkhlSd3UMpgWY29541BJEzm1HjEUYLV?=
 =?us-ascii?Q?kEH0e3ZtE1H/0kpaOxh+c30P0483QqWJJLiG3q9ZjaS6ruVzjrmjol0Cf4hX?=
 =?us-ascii?Q?12ADjomRzmE6iIVHwHReExlmVzsZS3c2SZxBlTVmG6XSXokQzOlhx5CpsOnv?=
 =?us-ascii?Q?in/z5HVBz0LdbAu6i/J1JlJgjBsXVBIRH4pZCV2zoawJfxSF56hFOJS8ZKes?=
 =?us-ascii?Q?wzf5eyb0LI8tQS3drNE7sLgp6AjWxyq0UeEw1jgS1QF9rWdWFxnvChNDiyy9?=
 =?us-ascii?Q?o958v2xS39A3nWLAmLyPw9vKDnVdcWqLxHTWJK0NXGDe+Wa/wCG33IIlTaGh?=
 =?us-ascii?Q?XZLzRstEA49Q88JY9SVBqVxRczdN7tH8D8jszvgYPlqh9/+Pn14qQjfBMYgI?=
 =?us-ascii?Q?7srO7GYyFuSy2xNwkGsEIiwl8WTfbiwgHJKxtLh8nA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 73229ce6-6db3-43ac-59ca-08da81477bd2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 18:28:45.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR06MB7345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:56:39PM +0200, Artur Rojek wrote:
> Hi all,
> 
> this patch set fixes the way channel data is being parsed in the
> adc-joystick driver. To achieve that, it also introduces helpers in the
> IIO subsystem. As a side effect of those changes, a bug in ingenic-adc
> has been exposed, which this patch set promptly rectifies.
> 
> Tested on GCW Zero (by me) and on Anbernic RG350 (by Paul).
> 
> Chris:
> As you have originally reported the issue, would you be able to test
> the above changes on your setup (Odroid Go Advance, was it)?

I can confirm this fixes the issue I experienced, I can see both
channels of the joystick now when using an hrtimer as a trigger.

This patch also does not interfere with the polling work in progress,
as that still works as expected too (polling work is still desired
though).

Thank you.

> 
> Artur Rojek (4):
>   iio/adc: ingenic: fix channel offsets in buffer
>   iio: add iio_channel_cb_get_iio_buffer helper
>   iio: add helper function for reading channel offset in buffer
>   input: joystick: Fix buffer data parsing
> 
>  drivers/iio/adc/ingenic-adc.c               |  7 +++---
>  drivers/iio/buffer/industrialio-buffer-cb.c |  7 ++++++
>  drivers/iio/industrialio-buffer.c           | 28 +++++++++++++++++++++
>  drivers/input/joystick/adc-joystick.c       | 26 ++++++++++++-------
>  include/linux/iio/buffer.h                  |  4 +++
>  include/linux/iio/consumer.h                | 12 +++++++++
>  6 files changed, 71 insertions(+), 13 deletions(-)
> 
> -- 
> 2.37.2
> 
