Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CD5711FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiGLFvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:51:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2123.outbound.protection.outlook.com [40.107.96.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E58CC9B;
        Mon, 11 Jul 2022 22:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwzMwVxBfVm3Z49PUJOsplYxE7G67IvOrW3swkTBgudsDbuqYkgvRBs/+dc3Wvg47TcJx9n4aYrRbZk3Co0FazCj2jdzeRke+jdm0CiiHZ6IyrQMc/4F2x8lPHu6+LVW/ZPABdEnrPPwhbkwNmt7n7OVVwUS4i0T/KZCaSnTtMrqdGPkVdNU8fCenedTXLS+AYIb1Lmy7XJZWolybYnGOAR8pileirVFzq3m5cp8d6F+t/CsTuPfAtNmN9kZfTusZnLxnmPwEZlU2PLLN6enKAZ+uYjjwVxiVqyrbtdCe27oYd/tD1lFwAe4PAyB2WgCKSVvwevn1lnUzHGCQG8azA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiCsZQZ8lyI2wwec976Dj0LRBDUM+Hsiecd96Wk/OYw=;
 b=n4g99JLYad1GAC3kyvj17qTA6ZL7FZnOEId0n3XMMwd0gfaJFhvE8t2qhITLui4JsrE9H5Mi9m2IGHWJ1Pn7VheYwQTZjvCUgna/EjTOA/lONB8I2vFFySgzPqlxZ3J0nJUyNk7jUE6npZVQhju94xpxpqd06uUQxkPDTn13TIA++RtcdcWR8YIY9qF3e0uqiNkRbYYnNnIERGdi8vfYezKnwC2S0yFKKw8HDzfqIMQ6jD70JPz9r0n/RzqEpdbkOZ1dDzaqgYpELadTPZSIAv/tJMmlPilnbnr/NCHGzsYbxy3mxbId+4yPV95rc1oOojWcZVa+HUfHE/3r/CHHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiCsZQZ8lyI2wwec976Dj0LRBDUM+Hsiecd96Wk/OYw=;
 b=kDBMrNjZsJXWWS2ZNdLbKiupH2ZC82MMl3fBXSu6kS4WqSNM7ieSOfmabLzO0CQYjAvc0f7+W4GuWLtogSgkLXXlOiaoHTE/EapD9eb9iMCbi6odVUiF6nWW7361abSByjO2+xcQM4StdEDxCndgTUZaB/sDz/tLkW/sYvBkvOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB5509.namprd04.prod.outlook.com (2603:10b6:a03:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 05:51:37 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 05:51:36 +0000
Date:   Tue, 12 Jul 2022 13:51:28 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v14 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220712055128.GA2782742@anxtwsw-Precision-3640-Tower>
References: <20220706083433.2415524-1-xji@analogixsemi.com>
 <20220706083433.2415524-3-xji@analogixsemi.com>
 <YsgotvSDWY78lYG6@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsgotvSDWY78lYG6@kroah.com>
X-ClientProxiedBy: TYAPR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::34) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6de19eb-15fe-4928-0eb5-08da63ca9516
X-MS-TrafficTypeDiagnostic: BYAPR04MB5509:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAZRwC9WwbBZPJTMEt9XYc/zlIx51VF7pxvYhs6IhVZZANAtpXhlJuB4MR8cXTZJRR4o2MV4bkW7QwBlA+wpJhMNDuxhO94Tv2XRYWdI1sEtQDoBSr/hfpSeqVGBv3IdmGSXWUUcEsM3gMvkRLBKi6omzpc3Y+Pv/2nl70/+a/p1X5bJDFOiEGxY4hGQkbsMs00FMyIHAEnPY81CCpGvlhNdN4CYJHN14/4aDbRQsHmZYy8IL+KBt4IaMNMX8cwaINAbWPNhmyabsbnOumIe/o04cdFYwmYNojP8knMTAiyIAqs5jdfSRs3BkAVNgPo+W5jSXQEYquVqcbymD0AhjOuemPttGCM4+IYytuu+dsFyNK8m9g9SQamui03yD+hweTcE5RlTRcxnsAGHC9K2C0anyZWAYRVzPL4UZUQkVmHCOy6Vxduh4uJaOhrbN+PwfrIJ+V5mn6DKzX/aPAXMg4fzaqs62K10v/akeccxE2bfdDv1cAAJvWy0p6XPdlB51rx05ZR+Q9skNFbK6Dgi/RVGpOU8DVyqIHkuvyl6IpDF512qQ+FWiJ+dC27tPLP3Od8M+/8Z3804K4rW1GepJJ6MNr9RH5EUJorzxTXpVj0UHUAwACV34cDI/A65mjjc6Ww+6QLJh3ojV7Jp65Rt9MSxWmolrjCSzYJTlteE6ttlAYLN6Nn52bsbramE2I4KI8d6fcVZzmY6w/sRTpAmRaydX4bT5ohoJQQy9WpZEL2OrBpz+UjSfnABCPcYVxgknq3qlMiHb025n/mJrBTAkA2YqbTeIxZlTFkzSffJ7f3oLsNGn69QhyHxx2tmj9if
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(346002)(366004)(136003)(39850400004)(6512007)(55236004)(9686003)(26005)(52116002)(478600001)(8936002)(1076003)(6506007)(33656002)(30864003)(6666004)(2906002)(41300700001)(5660300002)(38350700002)(6486002)(8676002)(6916009)(316002)(33716001)(66556008)(4326008)(186003)(83380400001)(86362001)(38100700002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9MYmaDBjZB9+hNQOUC/3eUus9Szz4ntg8FII95/E5nE9n7iWA2r8G/lRyrH?=
 =?us-ascii?Q?YGUDswqtSzIlwTh/GIlQftJkObXtNbVjjamXybPKgkiiE8fh38p55mUQjZI/?=
 =?us-ascii?Q?mgbuPX/XWykCqAHlVHbGXsK9RT6oRaWIxkXg+lJM+XmnzRxvGZaO3yVfuY5i?=
 =?us-ascii?Q?g4cUDnBdOfCMeXtGXKHjsd4OqwRNGabeJoNPyggqjELlGyfyElrJFdcBF35S?=
 =?us-ascii?Q?MyHYGUTj53Ep7BwcKxeGM9DH0HCzQHAAaWnWn06B7O1i1qCiBKcMXkjFYPlV?=
 =?us-ascii?Q?ERJzymMDDLqUelivKol6Bc/RH3hqgj3cmZaHinjwvwcv+u9ooEtePPuu1Cj2?=
 =?us-ascii?Q?ZeoKPLV5J9e+/NgbX0lbjYNLEqDn6QvtdD96KUm0WOjcNq9R8vb+giZ5XrVq?=
 =?us-ascii?Q?lVk5RKvaY1A4d2Cd5zV91X3or58BWdcLmCUpJs9gKnXnqwJUfdyUvShOEiPY?=
 =?us-ascii?Q?Yfsuei4rJD+a9fh2XK2bYmforALF4jM6wM2vT/M4Cwe/i9fbgnhPYkMDrlyH?=
 =?us-ascii?Q?bXpXoNe/6kaNQqtLsnuFrhMSLObeMYdL+5CT38bJ9MAoPncaB2GdvLqW1Yeh?=
 =?us-ascii?Q?ESX9vdBb7/AZDWvQKzvAkDQ8J3HKBfeDEospZXzR3mnz1fZZ7Mt7XUAzczsw?=
 =?us-ascii?Q?Tx1g5WQa+VkunXy8kVbcw0wWbzPXiralYbJSu+WYZoMSpS316DMte2enMYWu?=
 =?us-ascii?Q?7RySGKlKXhfV+5tskNPsuYJnBKZ0aS2XFWc9VnOcr+qaAomSxrJrWK8twYVD?=
 =?us-ascii?Q?qvy9NXk2oYakakKIMFEbCmaM6ZWQTrClEnJXG0+uoqZnawdbDukCadOAspRq?=
 =?us-ascii?Q?QN4Ow+oYrssWffP7+cSHQJFMxjoEfsJu9bHKPPPLv4QL1bZdx2zUyhD5Qw4J?=
 =?us-ascii?Q?8cPV5MS7w0R9pxv32AEo3tz9/ipsbxjx48x/OyY9YCzqZQCebkwj5OFmTH/l?=
 =?us-ascii?Q?jzJWcDSrGnhtMSezjD2A1YCToVE0m2g0TKlxVH/bMtpd2wsdtE0Rb/QDOIe1?=
 =?us-ascii?Q?uQJv03sYzCfpPPORVL1WHHlwkQs3POB9BZtBC+lqgTdHLrK0meDBIbZoXezD?=
 =?us-ascii?Q?fqlmBQflCY5rVLjdi7CAhIFyM8JbENPKMU9Y6oO0xG2b32Qhfp3VbTi7IT1B?=
 =?us-ascii?Q?7y94eIQHRfbKqlKT5k/iDJcl9Ufp00pNtKHvqQJ9HDFvjqxEwkv/CdBLnEQR?=
 =?us-ascii?Q?mBz5FxR0BMVL5X5yAWMz/jN/MbGeKXBvt163Qp4L6KiWDtmq3vS8uA9/wQdC?=
 =?us-ascii?Q?EWGf1kk3uGALDU6PJpq2/rjWsWiv7gkVl/S/pN/uflRtvO3L8Hvivw9JMWbb?=
 =?us-ascii?Q?CQeemJHXEDiHeCGYzMfib7LcIukUX5ilixDO3AxYI93fJtp0UxFbp38RcT3g?=
 =?us-ascii?Q?qSOmmf0eI1E52qoD1Z2iY5KHpOlB8AT4PvwbNdiQKLeiKWe/hNTcalJlM1DS?=
 =?us-ascii?Q?Y98ZfM/Wsk3YCc7xkyf9lLlaFNHWH4R0CXc0JyWZcxtzAcstL21YkjF8Cxvh?=
 =?us-ascii?Q?sBximHIqerBPygJ0stI9bLWu4VrkrzmB2b8R9mWCbCy719TOpcS7Md1naEtR?=
 =?us-ascii?Q?6TG+qxLj78C8xJkv4Py4WGTwQcCEwj+D2o4G0H+Z?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6de19eb-15fe-4928-0eb5-08da63ca9516
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 05:51:36.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8VmQXz7jgtw1yKODKWnDy6mIqFj4Tv3zeRna76pZuD6niHpQPY0f/7NFOuRrUvAZOPNfIO07UrH6VetZZIc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 02:53:10PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 06, 2022 at 04:34:33PM +0800, Xin Ji wrote:
> > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > 
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> > V12 -> V13 :
> >     1. Add driver description
> >     2. Checking return value for each i2c operation
> > V11 -> V12 : Remove all define in anx7411.h to anx7411.c
> > V10 -> V11 : Fix Heikki's comment, code clean up
> > V9  -> V10 : Rebase on the latest code
> > V6  -> V7  : Fix Heikki's comment
> >     Rebase on Greg's latest usb-next branch
> >     Move tcpci.h to include/linux/usb/
> >     Remove double definition
> > V5  -> V6  : Fix Heikki's comment
> > V4  -> V5  : Fix Greg h-k comment, remove DEBUG define
> > V3  -> V4  : Fix compiling waring
> > V2  -> V3  : Add changelog history
> > V1  -> V2  : Fix compiling warning issue
> > 
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/usb/typec/Kconfig   |   11 +
> >  drivers/usb/typec/Makefile  |    1 +
> >  drivers/usb/typec/anx7411.c | 1586 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 1598 insertions(+)
> >  create mode 100644 drivers/usb/typec/anx7411.c
> > 
> > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > index ba24847fb245..5defdfead653 100644
> > --- a/drivers/usb/typec/Kconfig
> > +++ b/drivers/usb/typec/Kconfig
> > @@ -52,6 +52,17 @@ source "drivers/usb/typec/ucsi/Kconfig"
> >  
> >  source "drivers/usb/typec/tipd/Kconfig"
> >  
> > +config TYPEC_ANX7411
> > +	tristate "Analogix ANX7411 Type-C DRP Port controller driver"
> > +	depends on I2C
> > +	depends on USB_ROLE_SWITCH
> > +	help
> > +	  Say Y or M here if your system has Analogix ANX7411 Type-C DRP Port
> > +	  controller driver.
> > +
> > +	  If you choose to build this driver as a dynamically linked module, the
> > +	  module will be called anx7411.ko.
> > +
> >  config TYPEC_RT1719
> >  	tristate "Richtek RT1719 Sink Only Type-C controller driver"
> >  	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> > index 2f174cd3e5df..dac5c11a3234 100644
> > --- a/drivers/usb/typec/Makefile
> > +++ b/drivers/usb/typec/Makefile
> > @@ -6,6 +6,7 @@ obj-$(CONFIG_TYPEC)		+= altmodes/
> >  obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
> >  obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
> >  obj-$(CONFIG_TYPEC_TPS6598X)	+= tipd/
> > +obj-$(CONFIG_TYPEC_ANX7411)	+= anx7411.o
> >  obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
> >  obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
> >  obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
> > diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> > new file mode 100644
> > index 000000000000..a958822b8a66
> > --- /dev/null
> > +++ b/drivers/usb/typec/anx7411.c
> > @@ -0,0 +1,1586 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Driver for Analogix ANX7411 USB Type-C and PD controller
> > + *
> > + * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
> > + *
> > + */
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/usb/pd.h>
> > +#include <linux/usb/role.h>
> > +#include <linux/usb/tcpci.h>
> > +#include <linux/usb/typec.h>
> > +#include <linux/usb/typec_dp.h>
> > +#include <linux/usb/typec_mux.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/power_supply.h>
> > +
> > +#define TCPC_ADDRESS1		0x58
> > +#define TCPC_ADDRESS2		0x56
> > +#define TCPC_ADDRESS3		0x54
> > +#define TCPC_ADDRESS4		0x52
> > +#define SPI_ADDRESS1		0x7e
> > +#define SPI_ADDRESS2		0x6e
> > +#define SPI_ADDRESS3		0x64
> > +#define SPI_ADDRESS4		0x62
> > +
> > +struct anx7411_i2c_select {
> > +	u8 tcpc_address;
> > +	u8 spi_address;
> > +};
> > +
> > +#define VID_ANALOGIX		0x1F29
> > +#define PID_ANALOGIX		0x7411
> > +
> > +/* TCPC register define */
> > +
> > +#define ANALOG_CTRL_10		0xAA
> > +
> > +#define STATUS_LEN		2
> > +#define ALERT_0			0xCB
> > +#define RECEIVED_MSG		BIT(7)
> > +#define SOFTWARE_INT		BIT(6)
> > +#define MSG_LEN			32
> > +#define HEADER_LEN		2
> > +#define MSG_HEADER		0x00
> > +#define MSG_TYPE		0x01
> > +#define MSG_RAWDATA		0x02
> > +#define MSG_LEN_MASK		0x1F
> > +
> > +#define ALERT_1			0xCC
> > +#define INTP_POW_ON		BIT(7)
> > +#define INTP_POW_OFF		BIT(6)
> > +
> > +#define VBUS_THRESHOLD_H	0xDD
> > +#define VBUS_THRESHOLD_L	0xDE
> > +
> > +#define FW_CTRL_0		0xF0
> > +#define UNSTRUCT_VDM_EN		BIT(0)
> > +#define DELAY_200MS		BIT(1)
> > +#define VSAFE0			0
> > +#define VSAFE1			BIT(2)
> > +#define VSAFE2			BIT(3)
> > +#define VSAFE3			(BIT(2) | BIT(3))
> > +#define FRS_EN			BIT(7)
> > +
> > +#define FW_PARAM		0xF1
> > +#define DONGLE_IOP		BIT(0)
> > +
> > +#define FW_CTRL_2		0xF7
> > +#define SINK_CTRL_DIS_FLAG	BIT(5)
> > +
> > +/* SPI register define */
> > +#define OCM_CTRL_0		0x6E
> > +#define OCM_RESET		BIT(6)
> > +
> > +#define MAX_VOLTAGE		0xAC
> > +#define MAX_POWER		0xAD
> > +#define MIN_POWER		0xAE
> > +
> > +#define REQUEST_VOLTAGE		0xAF
> > +#define VOLTAGE_UNIT		100 /* mV per unit */
> > +
> > +#define REQUEST_CURRENT		0xB1
> > +#define CURRENT_UNIT		50 /* mA per unit */
> > +
> > +#define CMD_SEND_BUF		0xC0
> > +#define CMD_RECV_BUF		0xE0
> > +
> > +#define REQ_VOL_20V_IN_100MV	0xC8
> > +#define REQ_CUR_2_25A_IN_50MA	0x2D
> > +#define REQ_CUR_3_25A_IN_50MA	0x41
> > +
> > +#define DEF_5V			5000
> > +#define DEF_1_5A		1500
> > +
> > +#define LOBYTE(w)		((u8)(w) & 0xFF)
> > +#define HIBYTE(w)		((u8)(((u16)(w) >> 8) & 0xFF))
> > +
> > +enum anx7411_typec_message_type {
> > +	TYPE_SRC_CAP = 0x00,
> > +	TYPE_SNK_CAP = 0x01,
> > +	TYPE_SNK_IDENTITY = 0x02,
> > +	TYPE_SVID = 0x03,
> > +	TYPE_SET_SNK_DP_CAP = 0x08,
> > +	TYPE_PSWAP_REQ = 0x10,
> > +	TYPE_DSWAP_REQ = 0x11,
> > +	TYPE_VDM = 0x14,
> > +	TYPE_OBJ_REQ = 0x16,
> > +	TYPE_DP_ALT_ENTER = 0x19,
> > +	TYPE_DP_DISCOVER_MODES_INFO = 0x27,
> > +	TYPE_GET_DP_CONFIG = 0x29,
> > +	TYPE_DP_CONFIGURE = 0x2A,
> > +	TYPE_GET_DP_DISCOVER_MODES_INFO = 0x2E,
> > +	TYPE_GET_DP_ALT_ENTER = 0x2F,
> > +};
> > +
> > +#define FW_CTRL_1		0xB2
> > +#define AUTO_PD_EN		BIT(1)
> > +#define TRYSRC_EN		BIT(2)
> > +#define TRYSNK_EN		BIT(3)
> > +#define FORCE_SEND_RDO		BIT(6)
> > +
> > +#define FW_VER			0xB4
> > +#define FW_SUBVER		0xB5
> > +
> > +#define INT_MASK		0xB6
> > +#define INT_STS			0xB7
> > +#define OCM_BOOT_UP		BIT(0)
> > +#define OC_OV_EVENT		BIT(1)
> > +#define VCONN_CHANGE		BIT(2)
> > +#define VBUS_CHANGE		BIT(3)
> > +#define CC_STATUS_CHANGE	BIT(4)
> > +#define DATA_ROLE_CHANGE	BIT(5)
> > +#define PR_CONSUMER_GOT_POWER	BIT(6)
> > +#define HPD_STATUS_CHANGE	BIT(7)
> > +
> > +#define SYSTEM_STSTUS		0xB8
> > +/* 0: SINK off; 1: SINK on */
> > +#define SINK_STATUS		BIT(1)
> > +/* 0: VCONN off; 1: VCONN on*/
> > +#define VCONN_STATUS		BIT(2)
> > +/* 0: vbus off; 1: vbus on*/
> > +#define VBUS_STATUS		BIT(3)
> > +/* 1: host; 0:device*/
> > +#define DATA_ROLE		BIT(5)
> > +/* 0: Chunking; 1: Unchunked*/
> > +#define SUPPORT_UNCHUNKING	BIT(6)
> > +/* 0: HPD low; 1: HPD high*/
> > +#define HPD_STATUS		BIT(7)
> > +
> > +#define DATA_DFP		1
> > +#define DATA_UFP		2
> > +#define POWER_SOURCE		1
> > +#define POWER_SINK		2
> > +
> > +#define CC_STATUS		0xB9
> > +#define CC1_RD			BIT(0)
> > +#define CC2_RD			BIT(4)
> > +#define CC1_RA			BIT(1)
> > +#define CC2_RA			BIT(5)
> > +#define CC1_RD			BIT(0)
> > +#define CC1_RP(cc)		(((cc) >> 2) & 0x03)
> > +#define CC2_RP(cc)		(((cc) >> 6) & 0x03)
> > +
> > +#define PD_REV_INIT		0xBA
> > +
> > +#define PD_EXT_MSG_CTRL		0xBB
> > +#define SRC_CAP_EXT_REPLY	BIT(0)
> > +#define MANUFACTURER_INFO_REPLY	BIT(1)
> > +#define BATTERY_STS_REPLY	BIT(2)
> > +#define BATTERY_CAP_REPLY	BIT(3)
> > +#define ALERT_REPLY		BIT(4)
> > +#define STATUS_REPLY		BIT(5)
> > +#define PPS_STATUS_REPLY	BIT(6)
> > +#define SNK_CAP_EXT_REPLY	BIT(7)
> > +
> > +#define NO_CONNECT		0x00
> > +#define USB3_1_CONNECTED	0x01
> > +#define DP_ALT_4LANES		0x02
> > +#define USB3_1_DP_2LANES	0x03
> > +#define CC1_CONNECTED		0x01
> > +#define CC2_CONNECTED		0x02
> > +#define SELECT_PIN_ASSIGMENT_C	0x04
> > +#define SELECT_PIN_ASSIGMENT_D	0x08
> > +#define SELECT_PIN_ASSIGMENT_E	0x10
> > +#define SELECT_PIN_ASSIGMENT_U	0x00
> > +#define REDRIVER_ADDRESS	0x20
> > +#define REDRIVER_OFFSET		0x00
> > +
> > +#define DP_SVID			0xFF01
> > +#define VDM_ACK			0x40
> > +#define VDM_CMD_RES		0x00
> > +#define VDM_CMD_DIS_ID		0x01
> > +#define VDM_CMD_DIS_SVID	0x02
> > +#define VDM_CMD_DIS_MOD		0x03
> > +#define VDM_CMD_ENTER_MODE	0x04
> > +#define VDM_CMD_EXIT_MODE	0x05
> > +#define VDM_CMD_ATTENTION	0x06
> > +#define VDM_CMD_GET_STS		0x10
> > +#define VDM_CMD_AND_ACK_MASK	0x5F
> > +
> > +#define MAX_ALTMODE		2
> > +
> > +#define HAS_SOURCE_CAP		BIT(0)
> > +#define HAS_SINK_CAP		BIT(1)
> > +#define HAS_SINK_WATT		BIT(2)
> > +
> > +enum anx7411_psy_state {
> > +	/* copy from drivers/usb/typec/tcpm */
> > +	ANX7411_PSY_OFFLINE = 0,
> > +	ANX7411_PSY_FIXED_ONLINE,
> > +
> > +	/* private */
> > +	/* PD keep in, but disconnct power to bq25700,
> > +	 * this state can be active when higher capacity adapter plug in,
> > +	 * and change to ONLINE state when higher capacity adapter plug out
> > +	 */
> > +	ANX7411_PSY_HANG = 0xff,
> > +};
> > +
> > +struct typec_params {
> > +	int request_current; /* ma */
> > +	int request_voltage; /* mv */
> > +	int cc_connect;
> > +	int cc_orientation_valid;
> > +	int cc_status;
> > +	int data_role;
> > +	int power_role;
> > +	int vconn_role;
> > +	int dp_altmode_enter;
> > +	int cust_altmode_enter;
> > +	struct usb_role_switch *role_sw;
> > +	struct typec_port *port;
> > +	struct typec_partner *partner;
> > +	struct typec_mux_dev *typec_mux;
> > +	struct typec_switch_dev *typec_switch;
> > +	struct typec_altmode *amode[MAX_ALTMODE];
> > +	struct typec_altmode *port_amode[MAX_ALTMODE];
> > +	struct typec_displayport_data data;
> > +	int pin_assignment;
> > +	struct typec_capability caps;
> > +	u32 src_pdo[PDO_MAX_OBJECTS];
> > +	u32 sink_pdo[PDO_MAX_OBJECTS];
> > +	u8 caps_flags;
> > +	u8 src_pdo_nr;
> > +	u8 sink_pdo_nr;
> > +	u8 sink_watt;
> > +	u8 sink_voltage;
> > +};
> > +
> > +#define MAX_BUF_LEN	30
> > +struct fw_msg {
> > +	u8 msg_len;
> > +	u8 msg_type;
> > +	u8 buf[MAX_BUF_LEN];
> > +} __packed;
> > +
> > +struct anx7411_data {
> > +	int fw_version;
> > +	int fw_subversion;
> > +	struct i2c_client *tcpc_client;
> > +	struct i2c_client *spi_client;
> > +	struct fw_msg send_msg;
> > +	struct fw_msg recv_msg;
> > +	struct gpio_desc *intp_gpiod;
> > +	struct fwnode_handle *connector_fwnode;
> > +	struct typec_params typec;
> > +	int intp_irq;
> > +	struct work_struct work;
> > +	struct workqueue_struct *workqueue;
> > +	/* Lock for interrupt work queue */
> > +	struct mutex lock;
> > +
> > +	enum anx7411_psy_state psy_online;
> > +	enum power_supply_usb_type usb_type;
> > +	struct power_supply *psy;
> > +	struct power_supply_desc psy_desc;
> > +	struct device *dev;
> > +};
> > +
> > +static u8 snk_identity[] = {
> > +	LOBYTE(VID_ANALOGIX), HIBYTE(VID_ANALOGIX), 0x00, 0x82, /* snk_id_hdr */
> > +	0x00, 0x00, 0x00, 0x00,                                 /* snk_cert */
> > +	0x00, 0x00, LOBYTE(PID_ANALOGIX), HIBYTE(PID_ANALOGIX), /* 5snk_ama */
> > +};
> > +
> > +static u8 dp_caps[4] = {0xC6, 0x00, 0x00, 0x00};
> > +
> > +static int anx7411_reg_read(struct i2c_client *client,
> > +			    u8 reg_addr)
> > +{
> > +	return i2c_smbus_read_byte_data(client, reg_addr);
> > +}
> > +
> > +static int anx7411_reg_block_read(struct i2c_client *client,
> > +				  u8 reg_addr, u8 len, u8 *buf)
> > +{
> > +	return i2c_smbus_read_i2c_block_data(client, reg_addr, len, buf);
> > +}
> > +
> > +static int anx7411_reg_write(struct i2c_client *client,
> > +			     u8 reg_addr, u8 reg_val)
> > +{
> > +	return i2c_smbus_write_byte_data(client, reg_addr, reg_val);
> > +}
> > +
> > +static int anx7411_reg_block_write(struct i2c_client *client,
> > +				   u8 reg_addr, u8 len, u8 *buf)
> > +{
> > +	return i2c_smbus_write_i2c_block_data(client, reg_addr, len, buf);
> > +}
> > +
> > +static struct anx7411_i2c_select anx7411_i2c_addr[] = {
> > +	{TCPC_ADDRESS1, SPI_ADDRESS1},
> > +	{TCPC_ADDRESS2, SPI_ADDRESS2},
> > +	{TCPC_ADDRESS3, SPI_ADDRESS3},
> > +	{TCPC_ADDRESS4, SPI_ADDRESS4},
> > +};
> > +
> > +static int anx7411_detect_power_mode(struct anx7411_data *ctx)
> > +{
> > +	int ret;
> > +	int mode;
> > +
> > +	ret = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->typec.request_current = ret * CURRENT_UNIT; /* 50ma per unit */
> > +
> > +	ret = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->typec.request_voltage = ret * VOLTAGE_UNIT; /* 100mv per unit */
> > +
> > +	if (ctx->psy_online == ANX7411_PSY_OFFLINE) {
> > +		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
> > +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> > +		power_supply_changed(ctx->psy);
> > +	}
> > +
> > +	if (!ctx->typec.cc_orientation_valid)
> > +		return 0;
> > +
> > +	if (ctx->typec.cc_connect == CC1_CONNECTED)
> > +		mode = CC1_RP(ctx->typec.cc_status);
> > +	else
> > +		mode = CC2_RP(ctx->typec.cc_status);
> > +	if (mode) {
> > +		typec_set_pwr_opmode(ctx->typec.port, mode - 1);
> > +		return 0;
> > +	}
> > +
> > +	typec_set_pwr_opmode(ctx->typec.port, TYPEC_PWR_MODE_PD);
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_register_partner(struct anx7411_data *ctx,
> > +				    int pd, int accessory)
> > +{
> > +	struct typec_partner_desc desc;
> > +
> > +	if (ctx->typec.partner)
> > +		return 0;
> > +
> > +	desc.usb_pd = pd;
> > +	desc.accessory = accessory;
> > +	desc.identity = NULL;
> > +	ctx->typec.partner = typec_register_partner(ctx->typec.port, &desc);
> > +	if (IS_ERR(ctx->typec.partner)) {
> > +		ctx->typec.partner = NULL;
> > +		return PTR_ERR(ctx->typec.partner);
> > +	}
> > +
> > +	return 0;
> 
> This function can return an error, yet you never check it at all when
> you call it.  Why?  Don't just throw away errors, they mean something.
> 
> thanks,
> 
> greg k-h
Hi greg k-h, I'll add checking code for this function and others.
Thanks,
Xin
