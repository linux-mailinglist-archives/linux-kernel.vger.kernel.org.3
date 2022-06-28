Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7A55D8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbiF1CdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244752AbiF1C14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:27:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF220F7E;
        Mon, 27 Jun 2022 19:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heLtzvA64s2XNzJn5IPSvLcdPMThlMtVlS22zqIUm9G31hS44oG+JxWs9o89yekDeNB5M4fiIyiVStHs7gcu1P4tSU6lvw9mWY+tUXed9koxJQcdvRvvp/aLbAfQQEJkFuuLGOkxNe7aPq7OLqFzMW75F0Z0ctgk+WN5g0t6DkPamB5e0DHyNXA1FcnDaIWTpYVeIM2OdL+xsPx6TYcoz1MOVyzHPO5UWzqIQZhtvGsKt8EXPQcqixe3nd213NLQ0vhmn+WcD1XXXvwcjdZ375xpBpKpmSqImHJGIc78XX/FafIp1VYKRpQyjX9MwYmBy3ueoKEL3GwKHGTDUffNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ylOJGmxPMKBV2LGnhtDIcd7TSjBpC6R6a7ZWC22HzY=;
 b=PyU+pFudOMKpEXGiG7D6aT4Gr4nvHIs9XyTAmiem5XyFpsbug/5cXYYA0QS9fjpBcYblj9AkiKKi9aJO3vzYxmDF+5CMtb4CQg4LVhkZf8pxvALTl72vfVKddqsHQoujwtO9ODCWchlXtJ4m13HtIsu5t6Whz3U+unEU/XIvgnLymp42bSYJy+ajlHDFBYKPRqmoK4+/0zBvWO0bPp0pb+mszlc/mO/p7SgmRnNpuyNwxL/FqcXEUk07m9XG/NQ/71QZWLrFLSRWUfPFoGX6uPUOc35cdUdMXJ99HA/Jje8MC8opZVs8F8PzYDg0Y7+Ja31Np06j0jNT2eaONuY7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ylOJGmxPMKBV2LGnhtDIcd7TSjBpC6R6a7ZWC22HzY=;
 b=MrUsfdqLpUL3B/BtEyj9mbwq0nPja5RDsFQx9AB/V4Bk9biPzcU9faRLQDjawP6grjx6i8F5gsrQUTm94efw77b95oQvuYKjvFvuHw1bU0ru7wMpDWpbvvxaUPLBo2BGb3+f1zQfawyGaQ217+B+e76KM+i/1DcntNF4J+ItrYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CH2PR04MB6933.namprd04.prod.outlook.com (2603:10b6:610:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 02:26:04 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 02:26:03 +0000
Date:   Tue, 28 Jun 2022 10:25:58 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v11 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220628022558.GA2182236@anxtwsw-Precision-3640-Tower>
References: <20220627044331.2180641-1-xji@analogixsemi.com>
 <20220627044331.2180641-3-xji@analogixsemi.com>
 <Yrmq8qMbTevl/aJR@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrmq8qMbTevl/aJR@kroah.com>
X-ClientProxiedBy: TYAPR01CA0198.jpnprd01.prod.outlook.com
 (2603:1096:404:29::18) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75da5253-e0ad-427d-953a-08da58ad8c69
X-MS-TrafficTypeDiagnostic: CH2PR04MB6933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwH45sfAfLlYBPKWqJ+13u8UJvGC80qOjYx4/nUjPr+9R1ceRahK0MJcm+j8E9rU9d9hAabEH9ZOrqrvTJ99gMm7lBkGd6/C21nGXmRuYbB3hqZoy0JGahBM896HGfqVNvYeSXNWcf++bwEPGz5ZVs/NEl6UQ9iyOn5qKw3jBlIOLrAiWukkmtLE07n6ouqXmUG6+2Q6VSO8m9Ce3tTSJfWeu6Kr0lPFxIyrnWp6CUrIQYfEvEvujYYMpPZEqvetT3jEJHT/Jfr2mUq29bq4vgrQOTeqakAH0FAriLWPt77LjAQRevkfVwqd3EZk2NZ3neZb6Ojg3Ra/n5iQ1/TO1xuhroGnZMFtjgHqEhCDQvtgrlgb5G13d+JKkLfuO3u3KICKcoPXcyeDbuHNP9gxWXd3+aygcyhvwv3+21QP8dyTW6ofW1e7+c25WlZcMpv6FTdfEfCmNesRFSCzFiPvx5Fc9nX6gGuh9T8rgx/iLRMzPlMCBUuMabybZHyzN9azrifWGjuZ8uIpoYU5z7jwUFtXpzvNduEkYGzyu/OslYR87zL4jie6e91VCfgjKvQf1wNdSg5h/TmBDpROiiErUFoXNaDgZeocOZMMJ46V2otVHHMsjtFb6y54CTN3dWfilRqHILXUTHaiSZsyDFG69tWvnPh6gsn84/wwX9mnueHfAL5HtiIJXobcduNvXVDZT1bGW4FOd92yc8S0tBieO1ogu2m9Twy8GiOwwh6pBKuDSWBkrN6+BuZ08ncVMh9Dsx4/MwIg9uQPw8xEVTemIccOGHNeKzGxBhzAYYkuKJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(39840400004)(136003)(396003)(366004)(8676002)(4326008)(6512007)(30864003)(6666004)(66476007)(9686003)(5660300002)(66946007)(66556008)(6486002)(83380400001)(33716001)(26005)(478600001)(55236004)(6506007)(2906002)(52116002)(6916009)(186003)(1076003)(38100700002)(316002)(8936002)(86362001)(41300700001)(38350700002)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6D/c2oYsStnefkhraVsELlCnPXdi989AC87VzQfT5HJKn8FRO5ACnzB54CJ?=
 =?us-ascii?Q?5zejeYSbP03GLCT8SEwFRBWDj7RQllkYy1dxFFyXQKddl3/OEs54hfTkj7yH?=
 =?us-ascii?Q?2SthnZH60NUnOUl1pUSMCxfHhZqtTA65qVr2COQ56pF7AggzT7m3OWjFJ6av?=
 =?us-ascii?Q?wzRyaUy05Rf9lrVstfuYmf63buiSTTS+Np1wDkiBtxTOuFfNbdDTgMIf3Wfd?=
 =?us-ascii?Q?TohC8rLNod3qfu7cBEsOy3xk20/pkShT+fiCVpedvh8gnjT5PgNFz0smbvMr?=
 =?us-ascii?Q?vMtUlpBi+6yPhVpoZ+8WwoI53xCYyAcGfeE3aZR5+hZtk7xsg3ZgHpmZ+JBp?=
 =?us-ascii?Q?rKu1gWqilEmZaNZLQwbCklmrReHT75NOxRSW6ji8nGm+nADc7qgE15r7wh8F?=
 =?us-ascii?Q?iBMfDWKqZxeNAKItegxIwe5Nj+zwoT0giYw2DzvsGbf4NKX9jG9J0QQqRe0f?=
 =?us-ascii?Q?H3nA4wQt/exFkWzVPKMnyxvmqzRFM9Dzc3RA7eWMqkIVSsiBLD/+bZXgyfwP?=
 =?us-ascii?Q?ausJFwSg5P3k5t+qlUr2+SQeD3WZCIq5IIWBhh15AwarEyZww5740D7hKW2C?=
 =?us-ascii?Q?iIPtRQiwvKv9+mSsHjYtw5enM6joyqFxHxeE9DaNOfmgWuC8d1DJf5QIKRYj?=
 =?us-ascii?Q?EFoqUKl0HYmKpV0k9XsgZOBQ47g3EusmfCtH14cCORZUc3QIcnsYdQ4WDW7a?=
 =?us-ascii?Q?RsmiOrlWLWufFqPF90xyAZ3UseW+xAPKh+WwhZAnpuNGxqrk+OxBfeos2Hre?=
 =?us-ascii?Q?FvbcNll5AdEafHenuXOM06O70UdR6cFF5hG/k7HcTOMqP9uy9x0zT3nJAggQ?=
 =?us-ascii?Q?owPcBPQBdStssmy2w1OJZjt/Z6kyG5A3cbsFOCOM+U8NXktKcGj7DR6gnxB8?=
 =?us-ascii?Q?RmJDBZ0dC2zXpHOgMrgkKLTp1UhSiaBGbcwd+zANY5DoYJtKEx2YSJlPR23F?=
 =?us-ascii?Q?ul4AtGaYeaQR/HNGm4Wcp5Z56yh6nbgME6nMThGU9XvHj45n4AucMH88CPpU?=
 =?us-ascii?Q?dT4BRMe7HXEtRDGvRtaMkozv3EElwMCOACeg1d20VlZdxKkP0VGZWUORtkfR?=
 =?us-ascii?Q?5Yq0l6fJdT8f/VD407FWAVw5zE7KvqPWao9KPU5FUqbBUH+YZCOHdqfVdz1p?=
 =?us-ascii?Q?MCS0Tm9szifAprk2ctw/6HiNAslg5FRsQC8AwfDkVh/q/1DMMt9fPEHnWojy?=
 =?us-ascii?Q?t4B5p3rt48oiEWWcwsr80VqW+jl+ALGV0ZhCiJdsscIL6F1FobB/CkQexxCy?=
 =?us-ascii?Q?/a8Km+WoH2OBI3qFfs6djCi3ctx+KS8Z+cJR4GSlMlI+g6fbDRZigPTFlN7Y?=
 =?us-ascii?Q?5Qh9TUetEj84cGT4V1bA2vxtk075b2BOkAmt5JqW6mYqluT00BqyuAPZqee5?=
 =?us-ascii?Q?ZHML+i8w32aXYGlZlm37mTk7IeLK5cVRj94umv86yBQGT4zYsr5lmYQprygg?=
 =?us-ascii?Q?jnVJ43W54hGgYZ+nO0aYa7z1+e+v3DIofKzBN555N0DIpFwotw4H2cLmC4XQ?=
 =?us-ascii?Q?0Ci4/6Rf/kPFn8CsQouPeiFgRiaoDZ1zzui3U8vqFHW7B8Dr4OHIIbpLPXPU?=
 =?us-ascii?Q?kiazr+JIINWf0h/SLNaZ84pUka9+go12FKXH+YKb?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75da5253-e0ad-427d-953a-08da58ad8c69
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 02:26:03.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6Ar7naexe3+gA7uJAX/p7uiZJNrNC4olB5zS0/PMu6XMlXDQjjlH+72UPg8JPzfOB5GLWgbkv8FdAYZ86iB1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6933
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg Kroah-Hartman, thanks for the review, I'll change it in the v12

Thanks,
Xin

On Mon, Jun 27, 2022 at 03:04:50PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 27, 2022 at 12:43:31PM +0800, Xin Ji wrote:
> > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > 
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
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
> >  drivers/usb/typec/anx7411.c | 1296 +++++++++++++++++++++++++++++++++++
> >  drivers/usb/typec/anx7411.h |  265 +++++++
> 
> Why do you need a .h file for a tiny .c file?  Please put them all
> together, that makes things easier to modify over time, and review
> today.
OK, I'll merge it into .c file.
> 
> >  4 files changed, 1573 insertions(+)
> >  create mode 100644 drivers/usb/typec/anx7411.c
> >  create mode 100644 drivers/usb/typec/anx7411.h
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
> > index 000000000000..3bf62cc26995
> > --- /dev/null
> > +++ b/drivers/usb/typec/anx7411.c
> > @@ -0,0 +1,1296 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
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
> > +#include "anx7411.h"
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
> > +}
> > +
> > +static int anx7411_detect_cc_orientation(struct anx7411_data *ctx)
> > +{
> > +	int ret;
> > +	int cc1_rd, cc2_rd;
> > +	int cc1_ra, cc2_ra;
> > +	int cc1_rp, cc2_rp;
> > +
> > +	ret = anx7411_reg_read(ctx->spi_client, CC_STATUS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->typec.cc_status = ret;
> > +
> > +	cc1_rd = ret & CC1_RD ? 1 : 0;
> > +	cc2_rd = ret & CC2_RD ? 1 : 0;
> > +	cc1_ra = ret & CC1_RA ? 1 : 0;
> > +	cc2_ra = ret & CC2_RA ? 1 : 0;
> > +	cc1_rp = CC1_RP(ret);
> > +	cc2_rp = CC2_RP(ret);
> > +
> > +	/* Debug cable, nothing to do */
> > +	if (cc1_rd && cc2_rd) {
> > +		ctx->typec.cc_orientation_valid = 0;
> > +		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_DEBUG);
> > +		return 0;
> > +	}
> > +
> > +	if (cc1_ra && cc2_ra) {
> > +		ctx->typec.cc_orientation_valid = 0;
> > +		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_AUDIO);
> > +		return 0;
> > +	}
> > +
> > +	ctx->typec.cc_orientation_valid = 1;
> > +
> > +	anx7411_register_partner(ctx, 1, TYPEC_ACCESSORY_NONE);
> > +
> > +	if (cc1_rd || cc1_rp) {
> > +		typec_set_orientation(ctx->typec.port, TYPEC_ORIENTATION_NORMAL);
> > +		ctx->typec.cc_connect = CC1_CONNECTED;
> > +	}
> > +
> > +	if (cc2_rd || cc2_rp) {
> > +		typec_set_orientation(ctx->typec.port, TYPEC_ORIENTATION_REVERSE);
> > +		ctx->typec.cc_connect = CC2_CONNECTED;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_set_mux(struct anx7411_data *ctx, int pin_assignment)
> > +{
> > +	int mode = TYPEC_STATE_SAFE;
> > +
> > +	switch (pin_assignment) {
> > +	case SELECT_PIN_ASSIGMENT_U:
> > +		/* default 4 line USB 3.1 */
> > +		mode = TYPEC_STATE_MODAL;
> > +		break;
> > +	case SELECT_PIN_ASSIGMENT_C:
> > +	case SELECT_PIN_ASSIGMENT_E:
> > +		/* 4 line DP */
> > +		mode = TYPEC_STATE_SAFE;
> > +		break;
> > +	case SELECT_PIN_ASSIGMENT_D:
> > +		/* 2 line DP, 2 line USB */
> > +		mode = TYPEC_MODE_USB3;
> > +		break;
> > +	default:
> > +		mode = TYPEC_STATE_SAFE;
> > +		break;
> > +	}
> > +
> > +	ctx->typec.pin_assignment = pin_assignment;
> > +
> > +	return typec_set_mode(ctx->typec.port, mode);
> > +}
> > +
> > +static void anx7411_set_usb_role(struct anx7411_data *ctx, enum usb_role role)
> > +{
> > +	if (!ctx->typec.role_sw)
> > +		return;
> > +
> > +	usb_role_switch_set_role(ctx->typec.role_sw, role);
> > +}
> > +
> > +static int anx7411_data_role_detect(struct anx7411_data *ctx)
> > +{
> > +	int ret;
> > +
> > +	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->typec.data_role = (ret & DATA_ROLE) ? TYPEC_HOST : TYPEC_DEVICE;
> > +	ctx->typec.vconn_role = (ret & VCONN_STATUS) ? TYPEC_SOURCE : TYPEC_SINK;
> > +
> > +	typec_set_data_role(ctx->typec.port, ctx->typec.data_role);
> > +	typec_set_vconn_role(ctx->typec.port, ctx->typec.vconn_role);
> > +
> > +	if (ctx->typec.data_role == TYPEC_HOST)
> > +		anx7411_set_usb_role(ctx, USB_ROLE_HOST);
> > +	else
> > +		anx7411_set_usb_role(ctx, USB_ROLE_DEVICE);
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_power_role_detect(struct anx7411_data *ctx)
> > +{
> > +	int ret;
> > +
> > +	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->typec.power_role = (ret & SINK_STATUS) ? TYPEC_SINK : TYPEC_SOURCE;
> > +
> > +	if (ctx->typec.power_role == TYPEC_SOURCE) {
> > +		ctx->typec.request_current = DEF_1_5A;
> > +		ctx->typec.request_voltage = DEF_5V;
> > +	}
> > +
> > +	typec_set_pwr_role(ctx->typec.port, ctx->typec.power_role);
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_cc_status_detect(struct anx7411_data *ctx)
> > +{
> > +	anx7411_detect_cc_orientation(ctx);
> > +	anx7411_detect_power_mode(ctx);
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_partner_unregister_altmode(struct anx7411_data *ctx)
> > +{
> > +	int i;
> > +
> > +	ctx->typec.dp_altmode_enter = 0;
> > +	ctx->typec.cust_altmode_enter = 0;
> > +
> > +	for (i = 0; i < MAX_ALTMODE; i++)
> > +		if (ctx->typec.amode[i]) {
> > +			typec_unregister_altmode(ctx->typec.amode[i]);
> > +			ctx->typec.amode[i] = NULL;
> > +		}
> > +
> > +	ctx->typec.pin_assignment = 0;
> > +	return 0;
> > +}
> > +
> > +static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
> > +					  int svid, int vdo)
> > +{
> > +	struct device *dev = &ctx->spi_client->dev;
> > +	struct typec_altmode_desc desc;
> > +	int i;
> > +
> > +	desc.svid = svid;
> > +	desc.vdo = vdo;
> > +
> > +	for (i = 0; i < MAX_ALTMODE; i++)
> > +		if (!ctx->typec.amode[i])
> > +			break;
> > +
> > +	desc.mode = i + 1; /* start with 1 */
> > +
> > +	if (i >= MAX_ALTMODE) {
> > +		dev_err(dev, "no altmode space for registering\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ctx->typec.amode[i] = typec_partner_register_altmode(ctx->typec.partner,
> > +							     &desc);
> > +	if (IS_ERR(ctx->typec.amode[i])) {
> > +		dev_err(dev, "failed to register altmode\n");
> > +		ctx->typec.amode[i] = NULL;
> > +		return PTR_ERR(ctx->typec.amode);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_unregister_partner(struct anx7411_data *ctx)
> > +{
> > +	if (ctx->typec.partner) {
> > +		typec_unregister_partner(ctx->typec.partner);
> > +		ctx->typec.partner = NULL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_update_altmode(struct anx7411_data *ctx, int svid)
> > +{
> > +	int i;
> > +
> > +	if (svid == DP_SVID)
> > +		ctx->typec.dp_altmode_enter = 1;
> > +	else
> > +		ctx->typec.cust_altmode_enter = 1;
> > +
> > +	for (i = 0; i < MAX_ALTMODE; i++) {
> > +		if (!ctx->typec.amode[i])
> > +			continue;
> > +
> > +		if (ctx->typec.amode[i]->svid == svid) {
> > +			typec_altmode_update_active(ctx->typec.amode[i], true);
> > +			typec_altmode_notify(ctx->typec.amode[i],
> > +					     ctx->typec.pin_assignment,
> > +					     &ctx->typec.data);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7411_register_altmode(struct anx7411_data *ctx,
> > +				    bool dp_altmode, u8 *buf)
> > +{
> > +	int ret;
> > +	int svid;
> > +	int mid;
> > +
> > +	if (!ctx->typec.partner)
> > +		return 0;
> > +
> > +	svid = DP_SVID;
> > +	if (dp_altmode) {
> > +		mid = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
> > +
> > +		return anx7411_typec_register_altmode(ctx, svid, mid);
> > +	}
> > +
> > +	svid = (buf[3] << 8) | buf[2];
> > +	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_ENTER_MODE))
> > +		return anx7411_update_altmode(ctx, svid);
> > +
> > +	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_DIS_MOD))
> > +		return 0;
> > +
> > +	mid = buf[4] | (buf[5] << 8) | (buf[6] << 16) | (buf[7] << 24);
> > +
> > +	ret = anx7411_typec_register_altmode(ctx, svid, mid);
> > +	if (ctx->typec.cust_altmode_enter)
> > +		ret |= anx7411_update_altmode(ctx, svid);
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7411_parse_cmd(struct anx7411_data *ctx, u8 type, u8 *buf, u8 len)
> > +{
> > +	struct device *dev = &ctx->spi_client->dev;
> > +	u8 cur_50ma, vol_100mv;
> > +
> > +	switch (type) {
> > +	case TYPE_SRC_CAP:
> > +		cur_50ma = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
> > +		vol_100mv = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
> > +
> > +		ctx->typec.request_voltage = vol_100mv * VOLTAGE_UNIT;
> > +		ctx->typec.request_current = cur_50ma * CURRENT_UNIT;
> > +
> > +		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
> > +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> > +		power_supply_changed(ctx->psy);
> > +		break;
> > +	case TYPE_SNK_CAP:
> > +		break;
> > +	case TYPE_SVID:
> > +		break;
> > +	case TYPE_SNK_IDENTITY:
> > +		break;
> > +	case TYPE_GET_DP_ALT_ENTER:
> > +		/* DP alt mode enter success */
> > +		if (buf[0])
> > +			anx7411_update_altmode(ctx, DP_SVID);
> > +		break;
> > +	case TYPE_DP_ALT_ENTER:
> > +		/* Update DP altmode */
> > +		anx7411_update_altmode(ctx, DP_SVID);
> > +		break;
> > +	case TYPE_OBJ_REQ:
> > +		anx7411_detect_power_mode(ctx);
> > +		break;
> > +	case TYPE_DP_CONFIGURE:
> > +		anx7411_set_mux(ctx, buf[1]);
> > +		break;
> > +	case TYPE_DP_DISCOVER_MODES_INFO:
> > +		/* Make sure discover modes valid */
> > +		if (buf[0] | buf[1])
> > +			/* Register DP Altmode */
> > +			anx7411_register_altmode(ctx, 1, buf);
> > +		break;
> > +	case TYPE_VDM:
> > +		/* Register other altmode */
> > +		anx7411_register_altmode(ctx, 0, buf);
> > +		break;
> > +	default:
> > +		dev_err(dev, "ignore message(0x%.02x).\n", type);
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static u8 checksum(struct device *dev, u8 *buf, u8 len)
> > +{
> > +	u8 ret = 0;
> > +	u8 i;
> > +
> > +	for (i = 0; i < len; i++)
> > +		ret += buf[i];
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7411_read_msg_ctrl_status(struct i2c_client *client)
> > +{
> > +	return anx7411_reg_read(client, CMD_SEND_BUF);
> > +}
> > +
> > +static int anx7411_wait_msg_empty(struct i2c_client *client)
> > +{
> > +	int val;
> > +
> > +	return readx_poll_timeout(anx7411_read_msg_ctrl_status,
> > +				  client, val, (val < 0) || (val == 0),
> > +				  2000, 2000 * 150);
> > +}
> > +
> > +static int anx7411_send_msg(struct anx7411_data *ctx, u8 type, u8 *buf, u8 size)
> > +{
> > +	struct device *dev = &ctx->spi_client->dev;
> > +	u8 msg[MSG_LEN];
> 
> Why is this on the stack?
I'll move it to private data struct.
> 
> > +	u8 crc;
> > +	int ret;
> > +
> > +	if (size)
> > +		memcpy(&msg[MSG_RAWDATA], buf, size);
> 
> Why not just use a real structure instead of random offsets into an
> array?
OK
> 
> > +	msg[MSG_TYPE] = type;
> > +	msg[MSG_HEADER] = size + 1;
> 
> Why +1?
1 byte size for msg[MSG_TYPE] byte.
> 
> > +
> > +	crc = checksum(dev, msg, size + HEADER_LEN);
> > +	msg[size + HEADER_LEN] = 0 - crc;
> 
> No error checking on the overflow of a message size?
No need check, we just implement 1 byte crc, overflow is OK.  > 
> > +
> > +	ret = anx7411_wait_msg_empty(ctx->spi_client);
> > +	if (ret)
> > +		return ret;
> > +
> > +	anx7411_reg_block_write(ctx->spi_client,
> > +				CMD_SEND_BUF + 1, size + HEADER_LEN,
> > +				&msg[MSG_TYPE]);
> 
> You can write data on this device that comes from the stack and not
> DMA-able memory?  Are you sure?
> 
> And no checking for any errors here at all?
Yes, this is just I2C data register write, not DMA operation.
> 
> > +	return anx7411_reg_write(ctx->spi_client, CMD_SEND_BUF,
> > +				 msg[MSG_HEADER]);
> 
> If this fails, what about the previous message that succeeded?  Should
> that be rolled back somehow?
If this fails, the message will be ignored by firmware.
> 
> > +}
> > +
> > +static int anx7411_process_cmd(struct anx7411_data *ctx)
> > +{
> > +	struct device *dev = &ctx->spi_client->dev;
> > +	u8 msg[MSG_LEN];
> 
> Again off of the stack and not the heap?  Are you sure that is ok?
OK, will change it.
> 
> > +	u8 len;
> > +	u8 crc;
> > +
> > +	/* Read message from firmware */
> > +	anx7411_reg_block_read(ctx->spi_client, CMD_RECV_BUF, MSG_LEN, msg);
> > +	anx7411_reg_write(ctx->spi_client, CMD_RECV_BUF, 0);
> 
> No error checking at all?
> 
> Same goes for all calls to these functions, you don't seem to ever check
> that anything went wrong.  You must have reliable hardware :)
OK, I'll check the return value.

Thanks,
Xin
> 
> thanks,
> 
> greg k-h
