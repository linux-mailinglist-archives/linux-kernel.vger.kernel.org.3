Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18354D0DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbiCHC1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiCHC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:27:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2111.outbound.protection.outlook.com [40.107.243.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6834662;
        Mon,  7 Mar 2022 18:26:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyq76JhD3FbRdozEszk0DBFKNHVselIz+fFyVhftbjPn8Ua1LOMz/NK7hJG4+f5XmX1L8O4CknX7fFSYmp2q2p9qM04UGKK2ZeSFwGiM9lWoJDqnoikcjK0gxZmS05yvI5bOn7fv72dKavtz8l/OT11yu1UUWuPAYVj6pDKyTfHiH2YDci/juKeE/gmbZ6KhxagOLGhCPzhMyg/TgV3BGQkM7+5WfZocZx9BuSE/P5FMU0KC/xaPcHFYoyBMHgVhVygM9OvpuTNT2CbSs2shxlS+hjlVBrcs4VQbGITXPQcCU8QxA7kePWrNGCSx52ZcgnbMD+6Bu8jFmF679F5wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxBExJ/Iqd4wyH4lYm97eDvVbSFCai5mKbK/4JuBqzg=;
 b=B2/pQ36tODrzM2lB6N6ufvqCdDiwEfZ1oTDGAVffv8LSkx3X/vyx69t/cZzoCsUa8z8VdBMOVeOSOyx0Uq0ocqCU/TaDjl2vuFlxr7EitRlJMVA7pmqqM7xL9G+j78/TxJOY7kERd+sfEc9WpNkd/Yy2SOKzgplKhaO3CLIkhZQQ6dOXZBTPqyGNZJRw+ey/aJFGmkGTESVuBTydMWav8p1hUzDuOPejJwR4G4NRn8qSaQMIV/1RN8nQNcTx6to4OuPUTutVXnw93x6hvNvpxM+veKhHXwIkq3+WsNvjL8v1yPCVJRmkNxFHFKO02EwF8dqDyd6TfI3DosJoTKjCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxBExJ/Iqd4wyH4lYm97eDvVbSFCai5mKbK/4JuBqzg=;
 b=fZ3+H87JHtvwz6JmfAbfDZwdBeXAUG4CFEqeIwv9RtH+ZS4APjKA+APtwV6twUAqLgWIdg2V/wicR4xx/TdQjMYNj8KP4gBn0WqetuQjv8w6ABHir1idUcuPHrdo/Z0EHZ5IB+Qna3Ugyw3AKZGhZKd4TzfR+xqHaUygEHcJGqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SN4PR0401MB3551.namprd04.prod.outlook.com (2603:10b6:803:45::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.25; Tue, 8 Mar
 2022 02:26:44 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 02:26:43 +0000
Date:   Tue, 8 Mar 2022 10:26:38 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/ directory
Message-ID: <20220308022638.GA964343@anxtwsw-Precision-3640-Tower>
References: <20220307090929.701137-1-xji@analogixsemi.com>
 <4252cd9d-a761-e064-58cf-eebc3b9d0bb7@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4252cd9d-a761-e064-58cf-eebc3b9d0bb7@roeck-us.net>
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1c30c0-8f1d-4cb1-3629-08da00ab15f4
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3551:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3551D83B19FF1596197BA2C3C7099@SN4PR0401MB3551.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WK2+ew0DMthmJY7xduNQN2ypuYy6VGrCeM5+2tm3BcZZ71XBt21zly2OhvCxYFMI9WUGeEJGu5FaaDh0XFNKAFKE8XSSRRowoit+XZBYZQ+gU8xNiMdHShTYXaR9D9bTq0PVcrM8Wg6g2MOyIVx9X1cu5G9cd8FfvPpZCbMoYaryVhj/biKJzHOt6OIRYI83T0kUG10If8Hz59lXPYVn6w2BMa4/xchZ2nEGeXili1Ycwl07I9jaO6BueTKoBk4fCMNQ/4sG+Lukt1AAYFslkGwaQjSQZh6Tik1XvmNge61aAR6tCHEE3HjTZleKpNOSq7bB0iDt13F3sUaRK4QqRkc7Zqz9jDC9MK1HhODm9ZdOkfGMmrzwKh6cfyr2CLF9uVewQNXpvduQnC86LxuW03WzGv5cooje5U7aDcAm7aflf6P3gza0ORyhWKnn8fyJdyvoCS886dPDTp5vUm845A1ht9KSL6wUiqEJ4ZMSytrkZC7KbuvA19ZwPdUTQxCcQH6LSqMcKuWXVSqYYIiSFMl3JrlWP+f6jjwsYDiSAk7KhtCVHLZuyV0+7D1pKeJYtK31sEr569OgWJDXRwTfFiWtANLYC6R5bigJbNqdbVl7/ETOF3lq3Zs/vKiT+K50JhX6tvZL7tYprzQnImgTVDotFFsXCwYcWVabslBy+B9uMHaPRd67Z9MYi7L5nHRkGJ2NnALXkWIeF70SvugDOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6512007)(38350700002)(83380400001)(1076003)(186003)(86362001)(26005)(38100700002)(8936002)(6916009)(66476007)(54906003)(33656002)(4326008)(8676002)(66556008)(66946007)(6666004)(498600001)(53546011)(6506007)(55236004)(52116002)(2906002)(6486002)(5660300002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0JNWVcG3YHIWZ+ozR/dZZQmA7aqzA1AhhKQKJFf5xb4cx0TcyKrkdiTy5wU?=
 =?us-ascii?Q?WPs6aF3dMU9yQSyEEqNcQDUsZNGBCLj9omM+BfNdHWoUxFAUSWkK5k3WKq2s?=
 =?us-ascii?Q?fENrYlJm5lsJhWnxHDzwNCJG6GS+9rgPY0RounuOVNXXzf//Zc90kfWDZ5jU?=
 =?us-ascii?Q?Rq0GJdm4Msabw3WtLepN8G5OHcqjRwbGU7H0Ov1n6pJlqHZ9tdsenjDhD5Tb?=
 =?us-ascii?Q?EQiTpCvTBsHpU3qGDXyEUMR14gz6E9NsfhYY46Tt7FEBJb7a2EEmZxt8g1em?=
 =?us-ascii?Q?YggfP3Zh3bOyPjePGqrE+dcRqBbv7+6CEEugBd3ObrYZbJc+7k3+mM2EvrW6?=
 =?us-ascii?Q?yRzMdzLrMXTS5DlBypIyoMBOwb8rEo1tvVn33k41JgdFlN2Hzl11HyyUoJFM?=
 =?us-ascii?Q?KgvbLMspsVDyEzaIPBnioIp49dxaP23IbbNH1Wc2uda1E5U6VTMU16HsFc8Y?=
 =?us-ascii?Q?NkD7XULG7oWgzLZGGniyrfoN+sp72NtxRp+Q+mM0ljnFm6e9HdE1rSBCBy4o?=
 =?us-ascii?Q?Ow/0S6knZzoBFNGQro1corfClbbf/H7OLk4iDg9jP76OaMPQwP0lalLA69XR?=
 =?us-ascii?Q?pzoPgkHZWSf5SeZxw/SDF8YWNvXWizNSsS+e0awGQEgYJrDNuAy+Wm5FOayq?=
 =?us-ascii?Q?+uksxenoEfraqd3LH6yi2NUwYv8ChIQ8i+g6kC8anxRjbC5sp/uT99TopDfb?=
 =?us-ascii?Q?apmc+F2fHLTq+oia8gapPUCwVwiLG2oBiDVUTpwgnRhAqqan/AhgExMV96Yf?=
 =?us-ascii?Q?vCaL+pZLycyabdpITNCGYY5IvgeipGoB98WA/u1PDARDVvGB8zMkmnhCpKFX?=
 =?us-ascii?Q?nPU5zywW9hiWkSWFfySyYPa7tD64ipy5m7FIW0emrwRx3Dnr8Z6IseClDUqA?=
 =?us-ascii?Q?uR8B5E5FVdpDyC7F6DtCvkasRlz2yKruM36T27hFx5h44OEQSzC8vrI9uhGc?=
 =?us-ascii?Q?9Up0/8UVEQeR6usjJy6aunmhs+4/2li0J7n61YFbi8su5g/qs8FfYqgWkl98?=
 =?us-ascii?Q?eJ8RvOTjdLDwX5Yy+V2G3duU9xUFrcZKN7umTznVu6rpVTPzLU0o3VyZiv4H?=
 =?us-ascii?Q?YAO0ouZ/QSL2B94cPUOc/JyjPuIju5tBBkKOgM1H5dlF05MVsBkFVjyTQefU?=
 =?us-ascii?Q?koglmBn4SXuq0LmygRhSt7EkscyeS1jlNjrudXsnIdhoXp8eosByflwBDhQf?=
 =?us-ascii?Q?1Jo1GRvNmfa4lRH90HP8fMhn0KCFzwbUk6ZGo9L2nGl+muZ/E++ex0zmHw8L?=
 =?us-ascii?Q?rocHC/KWty/2FMaChvicL4LHmWtOhlOjkiJPwEtWMNVnQCBjZ9ZcEawMc5om?=
 =?us-ascii?Q?aMcutnmzWzptmZsLaRX5EEKxuYZnYYdGGdh8UApF/wI07uSnPJlLhwepgFFV?=
 =?us-ascii?Q?FJqShSj9SDFKakRZ9LN6mYmlbdyCpHlyRr5hvGwW+SvKdT/HGlOItw89TBt1?=
 =?us-ascii?Q?xhPRmvG6W+la3SCXZmIfAirg4MyZ1ES31sVww1XYEto1j4jYygrAhId8/TvY?=
 =?us-ascii?Q?DjudBsCWTGiUebKdLxnFvhAKD3+GxqGLW8FowoseQa4UYZUV1aZYmVETgrVT?=
 =?us-ascii?Q?IR+N5+RnEQJFMnw5quu/tq+2U7hFEcQC57bswQp6tkbCk79JUs6TqItCs9wq?=
 =?us-ascii?Q?LeMQaB3+LQTGJBZT0xADJa0=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1c30c0-8f1d-4cb1-3629-08da00ab15f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 02:26:43.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqmVQY1IZotZlcmS1bHJc+8cCfRrzKKiHzua84eQPnYUjUBmYt2RfNdv/UU0ye1QeEHxGWDoPq34vKBPSNP/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:49:03AM -0800, Guenter Roeck wrote:
> On 3/7/22 01:09, Xin Ji wrote:
> > Move tcpci.h as a global file, better for other USB Type-C driver
> > access.
> > 
> 
> The idea was to have tcpci compliant drivers in the tcpm/ subdirectory.
> If I recall correctly, the reason for having this driver elsewhere is
> that it doesn't support tcpm. That should be explained here.
> "better for other USB Type-C driver" is not a reason for moving
> a header file.
> 
> > Fix compiling error after moving tcpci.h to include/linux/usb/.
> > 
> I don't think this should be part of the commit description.
> 
> Guenter

Hi Guenter, OK, got it, this patch is recommended by Heikki, as our
driver will refer some TCPCI registers, he prefer to move tcpci.h in to
global directory.

Hi Heikki, please help to give your opinion, thanks!

Thanks,
Xin
> 
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >   drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
> >   drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
> >   drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
> >   drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
> >   {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
> >   5 files changed, 5 insertions(+), 7 deletions(-)
> >   rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> > index e07d26a3cd8e..9c907296596f 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.c
> > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > @@ -13,11 +13,10 @@
> >   #include <linux/property.h>
> >   #include <linux/regmap.h>
> >   #include <linux/usb/pd.h>
> > +#include <linux/usb/tcpci.h>
> >   #include <linux/usb/tcpm.h>
> >   #include <linux/usb/typec.h>
> > -#include "tcpci.h"
> > -
> >   #define	PD_RETRY_COUNT_DEFAULT			3
> >   #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
> >   #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
> > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > index df2505570f07..4b6705f3d7b7 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > @@ -11,11 +11,10 @@
> >   #include <linux/module.h>
> >   #include <linux/regmap.h>
> >   #include <linux/usb/pd.h>
> > +#include <linux/usb/tcpci.h>
> >   #include <linux/usb/tcpm.h>
> >   #include <linux/usb/typec.h>
> > -#include "tcpci.h"
> > -
> >   #define PD_ACTIVITY_TIMEOUT_MS				10000
> >   #define TCPC_VENDOR_ALERT				0x80
> > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > index f1bd9e09bc87..9e0338bce7ef 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > @@ -11,10 +11,9 @@
> >   #include <linux/of.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/regmap.h>
> > +#include <linux/usb/tcpci.h>
> >   #include <linux/usb/tcpm.h>
> > -#include "tcpci.h"
> > -
> >   #define MT6360_REG_VCONNCTRL1	0x8C
> >   #define MT6360_REG_MODECTRL2	0x8F
> >   #define MT6360_REG_SWRESET	0xA0
> > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > index b56a0880a044..3291ca4948da 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > @@ -10,9 +10,9 @@
> >   #include <linux/i2c.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/gpio/consumer.h>
> > +#include <linux/usb/tcpci.h>
> >   #include <linux/usb/tcpm.h>
> >   #include <linux/regmap.h>
> > -#include "tcpci.h"
> >   #define RT1711H_VID		0x29CF
> >   #define RT1711H_PID		0x1711
> > diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
> > similarity index 99%
> > rename from drivers/usb/typec/tcpm/tcpci.h
> > rename to include/linux/usb/tcpci.h
> > index b2edd45f13c6..20c0bedb8ec8 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.h
> > +++ b/include/linux/usb/tcpci.h
> > @@ -9,6 +9,7 @@
> >   #define __LINUX_USB_TCPCI_H
> >   #include <linux/usb/typec.h>
> > +#include <linux/usb/tcpm.h>
> >   #define TCPC_VENDOR_ID			0x0
> >   #define TCPC_PRODUCT_ID			0x2
