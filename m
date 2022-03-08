Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225EF4D10C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbiCHHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiCHHOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:14:50 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2119.outbound.protection.outlook.com [40.107.212.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF053BBEC;
        Mon,  7 Mar 2022 23:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijL6ZamU16+jWFg5aXbaZ+VkTDqejso51mTJ6K8BzDy5M0KpqZZnyNUrwH6xATvDQGtwtSfL39aq2tREa77J6rZMyGPjbo3dStEiSpBt9AE8pKlFvcVvTOj6WR08deGYfIFrmi6hf8xhqiWrWpnvqDHs1jM6mrc/bhMxWneQYk6jnatdHzoKL78LYimcnJCk9/hOICOyZJKHwSAw9NAtUP37opyAzi1isYgdSy3uny11ZUIe+brQopf57kVAAWFXKguds5rc2WjaW91uxs8UvoY7rqiHP1E+UDp9unYBBpbJmOrRVtW/CQxIGfJHvghLvw1FrUllqJeq1mkA9rS/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vln16qI7356tCIsA9z8/KiHjSPrysaustFoG2sKsug=;
 b=Cv7r6vdkrI/gfablrn0d0OAeeFIV3T4MrNtLC3LqjCyG4ghvkGpedijKax+HB9zSh4mle0FcHy2JseUfj89noGpgIV3cQTFa6NtAvTL1xylvHUbj1UPsu64XL3JVXP8PP0YkNlXSKOeMrlFsOMyLrwRlQdqHst6rV5hBdlO1IPWI147mVt8VrEfYwRPWMC4CunfwAfISt1AdR0jEB6JuSOeMQAq1HEtDzzfrkkqw4T9t+a+HdR79ENc+hPq8UtvEXbVQKNueWUxWCu1ZKSl1hCSERMubtdLX9T7xuZiTbUfSwOzS4UnlV+0QFR4DU3s/lrX0KwgcO/8KqGFcQALxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vln16qI7356tCIsA9z8/KiHjSPrysaustFoG2sKsug=;
 b=x6TOU9cBxL1WeK71nT725cmz+WhesHj7N3SRZmXQQAC+PPPp3oPcEp/zcMjHoi/Ua90P5ztq/fWaQZ+2qBD6I/001BEEwqzjzAOwHnliAHiInQ9jP6giUAzAWUhE5C2qiUXpExJk+qoNqzNjP26vYHIxxA7VmoQOywlfXQxohYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB7106.namprd04.prod.outlook.com (2603:10b6:a03:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 07:13:50 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:13:50 +0000
Date:   Tue, 8 Mar 2022 15:13:44 +0800
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
Message-ID: <20220308071344.GA1137047@anxtwsw-Precision-3640-Tower>
References: <20220307090929.701137-1-xji@analogixsemi.com>
 <4252cd9d-a761-e064-58cf-eebc3b9d0bb7@roeck-us.net>
 <20220308022638.GA964343@anxtwsw-Precision-3640-Tower>
 <142b1c42-a8d5-3885-0af0-e07c9d4dd887@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142b1c42-a8d5-3885-0af0-e07c9d4dd887@roeck-us.net>
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27499fc7-b42a-43d7-d956-08da00d331fa
X-MS-TrafficTypeDiagnostic: BY5PR04MB7106:EE_
X-Microsoft-Antispam-PRVS: <BY5PR04MB7106C7ED295B9C9BDC30DCDAC7099@BY5PR04MB7106.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ojLx6apHlcTH45/lPHgPlKrYO64/OL268t8AAwD7VmJo7LdzMtF2GzNFWRPpUuUdKQ1i+kBLhRo3qPXA0dgePtdK3JmrlI22HvUkeJdHxccn7T3O5zK1b9bEXZKaLrPbfxmi7aP/94WVI+S1MGx+ynqzjRm8oK8wJAqNzY7HgoSnSU3njLDL+OFLkETUFBhBxBMuh+heSSq5R8CKrgYcU9TnDbm9GJXafXR/FGY+FaMuE88Yx6HBOi+WRT4PbZ1ll+mCOx++FjyHPKyjVra3dZkxQfjhlJ6J1Sye1YUivht7duCDJEBPrBqrXgARkzLGKhA2KeNEt+SpAtl6pXloHYqJbu5mp3dQfESEmZqy5OVCJPA3ErjmL1nxQFfH62mU5DXj+xkqXGtuFTh5k7V0MTNbir1D5VzNkJMHowGgY2RVvE2uHsX8q/9HmSr0sJHoIdwrPTfTFsqDDqcP1ZcoCExaw2McxRCp/7/gJNBYV0ab0dRjvU4hQfBCsNTmGkVLpIsSkahr03/H/O4yWT5moDWZnyXphwMafmZY7P/n4NX8FA3GQaykCH77ej2yKa+eNdu+tKFRQwrrHbWyZWN4wcmHnAvqMmxuU9FpdDHx4+wTwO67vK3B5CKMoqBdV2phuQfX6lhNacb2uj0WfbmjGebHJZpHmTScIA1QMN/H+fzxQ+P3KOU+52l7U9INTscG2Qk5X5TVhYDzxJk+uDx8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(2906002)(33716001)(9686003)(54906003)(6512007)(498600001)(6486002)(6916009)(6506007)(53546011)(33656002)(5660300002)(6666004)(52116002)(55236004)(86362001)(38100700002)(38350700002)(1076003)(26005)(186003)(4326008)(8676002)(66556008)(66476007)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HQM9feB0xrElfAq80hq+E+cuIqg5CpHCZcf8ojs9Qdz3Qk3M0uDMD7DchwP1?=
 =?us-ascii?Q?FJlgq77D0TAaPFrRgQ4BSptSVXMpJI6pf4lYwY4Xb/Z7qSXjJyE3o/51+WRZ?=
 =?us-ascii?Q?xrFSL2Ryq3gvZN+vTQXbZmrC/Rx2Y5GjMT06Gy06Zo/xfwCnaN6PCtfrhnBi?=
 =?us-ascii?Q?vv3758v50OE/hWnWy5b8Kwz5qKpBJjoo/9hB4O9hlDy7/i/ohJK5FNBm5Bju?=
 =?us-ascii?Q?XKQkmnp0kSjtoA3Lf1F4/3FbTLnKmgXySI7DkMqtvzlybR6sDc7km7Cp82uQ?=
 =?us-ascii?Q?Ui8QMKY3xJgV5oLCI7vI4D3lXjGV+eK7tfLwMFTc1l6nAcrCP+b+0sFnGOZM?=
 =?us-ascii?Q?gjEPpeXKd3PeMy/X0q29Q1SI9cJxC1xEhbXDICnaEbLy3J6xoyEgCYuzr56s?=
 =?us-ascii?Q?Rj5yyHquGweeMRlWzJeEIKaNfY1dyUbHubRgYrm9O0x9TdfrCxCfQv3Qw86G?=
 =?us-ascii?Q?tGBBunvVdv8VsKJRcF1AEC/E+HtdJa6FwR3FJ2Tm0A4qDpFF6+QXeng8icgv?=
 =?us-ascii?Q?k6lDqpu8u5v2zd17cuqGYQLJ5+FnzU/n397D7pzLsEFEyD9t9V21ibmnlIjA?=
 =?us-ascii?Q?9fxKorsbJeo7UEsdpQHHMSPpMI6y58RcoJl8HlytJeH8i95knQL51qQnVWei?=
 =?us-ascii?Q?G9jl41T9bVcfGti6Ly8EXGlt9aN2np1friSJPnqLFKs7bfb4DWxtFqn9DkCn?=
 =?us-ascii?Q?0UMNsdhhl86Hxz8MvyZU05gKo7e3AtTlWIl3wEzZeY8vGyyqIagtjUUXnBOZ?=
 =?us-ascii?Q?loHWH+Sii+j5k7UskaWw4Ll/ziIWgiCXjnC7gyaQQzDsO5mm5oyafCgk2jKX?=
 =?us-ascii?Q?jdsCm0XMdTcTTv3l5VGANBWiZxEAVv9HkHDRQqGCUHDbHXgwzqOw7634EvqW?=
 =?us-ascii?Q?EsomNaJG/KKG1pxURF6yIWCmcFdTOnIg6ulXF8AXAZ8K6ExcntBz/IkdSJ2Y?=
 =?us-ascii?Q?G0k2Bggll9Js6f40bh8+pUEe3aiH8vkne0LgZoyxdqLlhquNYiGcqUqzT1tI?=
 =?us-ascii?Q?lccnR9ssuSI8CuPsiz5qkatx1m9iWTjnLxa/II8LRBZJqR5n3WY+n+NHxiEe?=
 =?us-ascii?Q?oVyqNU6toSY4jc1GYOIie32Fm8rMcr0s9ocMALYe2omD+aOo1QpCIRXvwG0v?=
 =?us-ascii?Q?1hdNjz/QEA0jIWR1Jo4JphFp2EyP9ujbLU0A/SdVDs5NAbu76zgwI6+ppJ0M?=
 =?us-ascii?Q?1ARXQkN5UBUGqC32meeHdS/HDjt1+Mm62lFP2BQWdO0XGBg18Rzc71FzyK6c?=
 =?us-ascii?Q?0s/TEnfML44lG4FB9Q4uStd2q2zRvNZAZL0OFzXWPmrNPKSDrLOrxogOhxzR?=
 =?us-ascii?Q?35u7e4Uoq4tTjgA1/qqDtfUiei171PpLY03M7tXc6Wsmgppac6JAAGPJFSEK?=
 =?us-ascii?Q?hzNQfdjDdUkijiyPkqdMLkZydNngnC85Rmjf0rXIqqoEyFQRqwf36/ZKRFdK?=
 =?us-ascii?Q?akid1tvTECJngR7xx3o8yCfgE6V2JzirkrM7tL8R7YMOhSv0bYfhUBp3j9iA?=
 =?us-ascii?Q?w1QP4GT50e/jYkBt5C776LypB6A8NUPsGec6Z84DmdJX79p92VQjgKmTa/mK?=
 =?us-ascii?Q?rYIQppNzaqAAC8D2foRjCAoaCt0+CH+AmT58xjGL9lgn2hIBiN+Stj+86SMA?=
 =?us-ascii?Q?JWwH/mzn8UMS6JOFhaHtrFk=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27499fc7-b42a-43d7-d956-08da00d331fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 07:13:50.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgzGknJK5Yyu+MCweq3s2vRtqdQUcMjkvQDhE1EMpn0PRj7hOZKCN9a1nZld5Z7qXSOP8Kvamw/ZGQh9+Mo0oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7106
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:06:38PM -0800, Guenter Roeck wrote:
> On 3/7/22 18:26, Xin Ji wrote:
> > On Mon, Mar 07, 2022 at 06:49:03AM -0800, Guenter Roeck wrote:
> > > On 3/7/22 01:09, Xin Ji wrote:
> > > > Move tcpci.h as a global file, better for other USB Type-C driver
> > > > access.
> > > > 
> > > 
> > > The idea was to have tcpci compliant drivers in the tcpm/ subdirectory.
> > > If I recall correctly, the reason for having this driver elsewhere is
> > > that it doesn't support tcpm. That should be explained here.
> > > "better for other USB Type-C driver" is not a reason for moving
> > > a header file.
> > > 
> > > > Fix compiling error after moving tcpci.h to include/linux/usb/.
> > > > 
> > > I don't think this should be part of the commit description.
> > > 
> > > Guenter
> > 
> > Hi Guenter, OK, got it, this patch is recommended by Heikki, as our
> > driver will refer some TCPCI registers, he prefer to move tcpci.h in to
> > global directory.
> > 
> 
> The patch itself is fine. My concern is the description which, in my opinion,
> does not adequately explain the reason for the patch.
> 
> Also, "Fix compiling error after moving tcpci.h to include/linux/usb/"
> sounds like a change log, which should not be part of the description either.
> 
> Guenter

Hi Guenter, sorry for misunderstand, I'll change the commit message in
the next serial.

Thanks,
Xin
> 
> > Hi Heikki, please help to give your opinion, thanks!
> > 
> > Thanks,
> > Xin
> > > 
> > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > ---
> > > >    drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
> > > >    drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
> > > >    drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
> > > >    drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
> > > >    {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
> > > >    5 files changed, 5 insertions(+), 7 deletions(-)
> > > >    rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> > > > 
> > > > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> > > > index e07d26a3cd8e..9c907296596f 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpci.c
> > > > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > > > @@ -13,11 +13,10 @@
> > > >    #include <linux/property.h>
> > > >    #include <linux/regmap.h>
> > > >    #include <linux/usb/pd.h>
> > > > +#include <linux/usb/tcpci.h>
> > > >    #include <linux/usb/tcpm.h>
> > > >    #include <linux/usb/typec.h>
> > > > -#include "tcpci.h"
> > > > -
> > > >    #define	PD_RETRY_COUNT_DEFAULT			3
> > > >    #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
> > > >    #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
> > > > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > > > index df2505570f07..4b6705f3d7b7 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> > > > +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > > > @@ -11,11 +11,10 @@
> > > >    #include <linux/module.h>
> > > >    #include <linux/regmap.h>
> > > >    #include <linux/usb/pd.h>
> > > > +#include <linux/usb/tcpci.h>
> > > >    #include <linux/usb/tcpm.h>
> > > >    #include <linux/usb/typec.h>
> > > > -#include "tcpci.h"
> > > > -
> > > >    #define PD_ACTIVITY_TIMEOUT_MS				10000
> > > >    #define TCPC_VENDOR_ALERT				0x80
> > > > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > > index f1bd9e09bc87..9e0338bce7ef 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > > @@ -11,10 +11,9 @@
> > > >    #include <linux/of.h>
> > > >    #include <linux/platform_device.h>
> > > >    #include <linux/regmap.h>
> > > > +#include <linux/usb/tcpci.h>
> > > >    #include <linux/usb/tcpm.h>
> > > > -#include "tcpci.h"
> > > > -
> > > >    #define MT6360_REG_VCONNCTRL1	0x8C
> > > >    #define MT6360_REG_MODECTRL2	0x8F
> > > >    #define MT6360_REG_SWRESET	0xA0
> > > > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > > index b56a0880a044..3291ca4948da 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > > @@ -10,9 +10,9 @@
> > > >    #include <linux/i2c.h>
> > > >    #include <linux/interrupt.h>
> > > >    #include <linux/gpio/consumer.h>
> > > > +#include <linux/usb/tcpci.h>
> > > >    #include <linux/usb/tcpm.h>
> > > >    #include <linux/regmap.h>
> > > > -#include "tcpci.h"
> > > >    #define RT1711H_VID		0x29CF
> > > >    #define RT1711H_PID		0x1711
> > > > diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
> > > > similarity index 99%
> > > > rename from drivers/usb/typec/tcpm/tcpci.h
> > > > rename to include/linux/usb/tcpci.h
> > > > index b2edd45f13c6..20c0bedb8ec8 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpci.h
> > > > +++ b/include/linux/usb/tcpci.h
> > > > @@ -9,6 +9,7 @@
> > > >    #define __LINUX_USB_TCPCI_H
> > > >    #include <linux/usb/typec.h>
> > > > +#include <linux/usb/tcpm.h>
> > > >    #define TCPC_VENDOR_ID			0x0
> > > >    #define TCPC_PRODUCT_ID			0x2
