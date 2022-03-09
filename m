Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DB4D26FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiCICLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiCICK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:10:57 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7EB15A03;
        Tue,  8 Mar 2022 18:09:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiKDboI1IE/t2Tc6O7E/l9iQJJx9rxEelvOA+ovTDO7cYjkCJ+1xfzs0Ijg5Eu5bnjbGJ9EDBi4k+wlfEKLzI6ZNwtuqMG7UJI/ZkT4GSIk6716r1gu5Aviy1lTlYx2tkvDsaT2jXb0KAkLZ6JMRX+hzGsIH97EMHfcFRRQemz64VOb41bqjMYlkckPH/WJ3Ke2RDn4RuLwGmvQ+lwyHcSEUGbnw3Kahf4G+DhJT8TRHOQVkS8TMP4orp7aJsHybwiNRO18gHQRD4vyF/8i1pZfiiJlk0OuxlHW1MNnjfSNU4gm26o2zm++WbusrIXD1kbLbx4yKRjoilVpH7mUtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eteWAvycmXpyij3gbw+29byEw0P5jDvzQvvQI5Z5358=;
 b=WyKvd88MX0lvmEN+7Qu1sPFCFJNANVTStYUu3DONV0nzfmAAmFo7ZgRqh5HJh+nyJDbArawH+SF6bOinTBWlBIz3pgjoLbRqbPr5zB1ibhc0cyn7093xxbS0RcJVt8AFbLBYN86IQ2xrF5k1M2nREtcjcQLOA9jzCwRYBM/riy1cM5q5DouowFo9cvrKC9rHAedqsHZHsqWxgjgasXXl7d14aVKScen8hY93QSjF7I6fPEAtKW3/VfSdQmONfH8tZPb3WHHT6m4dJNUFTDE2nb4jTpnDLaaMnmDtN0b652aLyhlIjm0yG4ws1xgP/0mnrGjw6r58iSP1q8j8+XBgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eteWAvycmXpyij3gbw+29byEw0P5jDvzQvvQI5Z5358=;
 b=EPVAhFuW306dSJyDezojdiuFxbi7jf/NZ6dqEVcmNte1OummMjPxuKBbMZTUekIWNEVrdIfavmlDGfIMV6jMZ6hg4IcYdHmd6l18S6KPbeTwqTL+bJEynPZjvNtE6SaYAATf/L5BORtTcAqDzK7XxxIDr8iH2Ek8Z629qsFOmKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN7PR04MB5362.namprd04.prod.outlook.com (2603:10b6:408:a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 02:09:57 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 02:09:57 +0000
Date:   Wed, 9 Mar 2022 10:09:49 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/ directory
Message-ID: <20220309020949.GA1219327@anxtwsw-Precision-3640-Tower>
References: <20220308073431.1217890-1-xji@analogixsemi.com>
 <YicrpWig4kwdh2lg@kuha.fi.intel.com>
 <0fa1e65c-949f-f492-f769-b1f5ed3b181d@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa1e65c-949f-f492-f769-b1f5ed3b181d@roeck-us.net>
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ce7a2d-b297-4522-fe82-08da0171e86d
X-MS-TrafficTypeDiagnostic: BN7PR04MB5362:EE_
X-Microsoft-Antispam-PRVS: <BN7PR04MB536275D71E1DA53183E2B3D9C70A9@BN7PR04MB5362.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZfy6o54SOFhKAQTOj/TM00z1Gh9IoXLaZGVBiW3kcRdnPl1XJvpgXjXxFWOdGZgpooU9zAN3LC7HFedjO1pE0G77Ktv9vojNUnRjVsiEROoW+uZYn8RYpgKh+DKhsTo2cAfIMz3EyJUt4ecwzEKJWj2XUjcxIyO5VP33+btQKW+0sXCQiRP/vAtxAl/7buIKT3hos6Hb68x9Frltz1Ydpbhb/kSNeFj33wV0b9zc77fvR3Jo33WFXkLZmHY3Bp0128Z9l6FF2+mn0IzpeoA8zN8c69IGdZFn/1M6ZifnEPDLN/Z2WvekpwKp2H8x0iY1Wfb/B0WYjjm2USdhVyPNlV3ALq9ucoCK2zh60TYIM1QQ3a3LeNyiOnLr5ZebsTjkjrar3/td6uApdXvu3O3g5TrUg/VYrN2pNJ/iqtyfPxR+7vgXFVbgNyVzWuyySH7mjAwxJHlqlYg3YEaPZ3A+dBaK+rPMVab7rQFdehqNqAJiO5dN4rsiTThFqcRASWNku8IYGxGulrgLpZh20xd8Utq1iFgoJQMbyc4Vi6/iXgbzhR/Ax35/hq1vY/lgEf5ZOOol9Ly4n9iCXfNo4bUlbWIr92W3ubpyyXXaq+QoAqVD9WM0+rYYpIgWq5RxFlr1BngHgxWMUjgzR/9R16PWtWpGDTOGhzoVxQO3f8mngcpoxpY/YMm4MLxCFjqnA9DxfIfahfR62W/f9fmUkw/3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(4326008)(8676002)(66476007)(66556008)(38350700002)(86362001)(8936002)(33656002)(6916009)(54906003)(66946007)(316002)(33716001)(38100700002)(186003)(2906002)(6506007)(1076003)(9686003)(26005)(53546011)(6512007)(52116002)(55236004)(6486002)(6666004)(508600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5irJtAWe0SMSTM6Sq57Ger20Zy2hdtfi7c9+h46VLngDH/S73q3HkTcpNTV+?=
 =?us-ascii?Q?iAoq7ylHIv+mh5eOz8xQH61LBwt7xKxMRsnxtthRCSiN1nATP49jpdwlmES4?=
 =?us-ascii?Q?6QgMjdQC41B8CnB/m8dkyzwZRVl7qQm+apxfh7nWLQROzHzL1rxXmJUVkw0+?=
 =?us-ascii?Q?iGL9p6LlwR5KSfiAEMZAHAyTU5dbV84Qpcz2UBePUcTqDZA+4RRVIvxdXwQC?=
 =?us-ascii?Q?mZ7HQWbesjiVUKQcgOmp6gpNk6/SS4yteyH8kM6OZ0lDYAqSaO+NlzDbVW/2?=
 =?us-ascii?Q?DLiiFKeP1SH5CYjHJVbhzCGnmBzZpZEI4kgJfIg0BoizkI5tMSss2iCI8hN+?=
 =?us-ascii?Q?SwRAtIqPcZ4Kyc9aH9H3QiU+0m4x03FUSsSmzez67VpFIZCkoNQXiQB7fRja?=
 =?us-ascii?Q?51yfAWAhQ/mF4GqN5tLNIMnyD9TAme7gvtlRAs781dnjCHZiVSLTBjfbOZkT?=
 =?us-ascii?Q?LPeEae37b+FOAOuJ7gUzDQ40uINlNH3p1V4Pa6lrwxe1051VHTxX1emtzpC3?=
 =?us-ascii?Q?dQuzgyV2ej1jmtmfsLRPxfPM1c5loOQVQrEVPhwwLvs6O89kVtEUWlMpELXB?=
 =?us-ascii?Q?Ev0FICwUJHIj8mhb45Nbgy0SmfvkwHRD2CCd5UPKtalllzuqc4UF9KznVl1u?=
 =?us-ascii?Q?ofSLMP60Rxx1LN9Sjj0Ind39s6nYNuzBI6WoQkfd28ui3o6KvgAxxGBXnHDM?=
 =?us-ascii?Q?xBN3fIDFEpQfllbEWC7RwDb4a+WP0R7vi3i4+0R7fswa5g+a+g5zYWOMmKNe?=
 =?us-ascii?Q?yfs6edgXTvkN1h6M+f0ooOc7765gKVNeMKMGZX3oe8bUN7UCAaVeccdtaebN?=
 =?us-ascii?Q?EjVK4La7qU1aMaf/5qPQpqkhSYrSjA3Lnded5gK+FCgLfX9urcgyhgeKiTK8?=
 =?us-ascii?Q?V9XuZK2QCYLWEuoa7sQt9eBr6KoD/Skw1QxWKZZ0loLs1UrFntkg5nXkU04N?=
 =?us-ascii?Q?ZvjUCCKT+FL1BK2lrmioK2w6I+d8ezdvX5uRoRzNbrg8fe5Rkz7w2L58lZjz?=
 =?us-ascii?Q?WksQiGpgOFpOktle5QJ26XE5fMKCAWkQNLvrHq/T//p/SCNVotTuC3Z1rfF3?=
 =?us-ascii?Q?RzDcfFj+SNEtyrwSIC94q/WYjMqYP6ZdFA1hQ95/D0fK4sTAoQoLpdh1/oVO?=
 =?us-ascii?Q?ruZhr3n69l4pwdmH/iC+qoUhxhzflY8RwGY9swBqkNWzPHygEFTUqTwu54vv?=
 =?us-ascii?Q?JUV6XeAv7Jfy2HtvqRB+HKM+sOi5vtWAlQQmLawErY1PoM0JUSnKaZGSrfO3?=
 =?us-ascii?Q?psu5W/uj5nCdPGzGCW/u+nBpXi0MKXRrYtCCgjtbjJh4uE+n7P2o2+VOusQf?=
 =?us-ascii?Q?MwcL/me+HNYDXdmLQteUjqFsZPTsID4GXcyxiKvHKVyWgqG5LvuIQuAIXLof?=
 =?us-ascii?Q?MHYLKb/bRHkPTzeR/6GoQt69vVRh7s6gw9c9w/yZRygNZlRdXCZQW5h5xDT2?=
 =?us-ascii?Q?XshKLSUZuWsKuh9LfZ7vrJZIzi3o1P0Ho9AtN+bdlxzxfC4GFB7HnhavuUoA?=
 =?us-ascii?Q?Pe7ej71xy4xkIWhVKxqZ/+DwdNXJIMCv1442WoDFFmKYzXZWhG/ScMcYRajK?=
 =?us-ascii?Q?ms/3pY2Rpf+TL3XX7KMxr+0swuaCNFih72a6LD61zykO6+eUdT1X4tJvktUK?=
 =?us-ascii?Q?6iLJ44TptWjojUYoR2Eiosg=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ce7a2d-b297-4522-fe82-08da0171e86d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:09:57.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRZl1fQla46JL/+hTVyVkTjqEMGtLaOYKiLz5OXuuR2w3p910eaFidp5B6jL7EgolUA19QMc6NW+inFplGqa1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5362
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:41:27AM -0800, Guenter Roeck wrote:
> On 3/8/22 02:10, Heikki Krogerus wrote:
> > On Tue, Mar 08, 2022 at 03:34:28PM +0800, Xin Ji wrote:
> > > As for convenience use TCPCI register definition, move tcpci.h to
> > > include/linux/usb/ directory.
> > 
> > To be honest, I was still hoping for a better explanation here.
> > 
> > The reason why this header is made global is because some USB PD
> > controllers - PD controllers consisting of a microcontroller
> > (acting as the TCPM) and a port controller (TCPC) - may require that
> > the driver for the PD controller accesses directly also the on-chip
> > port controller in some cases.
> > 
> > I was hoping that that was explained in the commit message somehow.
> > 
> 
> Same here.
> 
> Guenter

Hi heikki, Guenter, OK, I'll add it in the commit message.

Thanks,
Xin

> 
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > 
> > > ---
> > > V7 -> V8: Fix Guanter's comment, remove unnecessary explain.
> > > ---
> > >   drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
> > >   drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
> > >   drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
> > >   drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
> > >   {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
> > >   5 files changed, 5 insertions(+), 7 deletions(-)
> > >   rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> > > index e07d26a3cd8e..9c907296596f 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > > @@ -13,11 +13,10 @@
> > >   #include <linux/property.h>
> > >   #include <linux/regmap.h>
> > >   #include <linux/usb/pd.h>
> > > +#include <linux/usb/tcpci.h>
> > >   #include <linux/usb/tcpm.h>
> > >   #include <linux/usb/typec.h>
> > > -#include "tcpci.h"
> > > -
> > >   #define	PD_RETRY_COUNT_DEFAULT			3
> > >   #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
> > >   #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
> > > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > > index df2505570f07..4b6705f3d7b7 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > > @@ -11,11 +11,10 @@
> > >   #include <linux/module.h>
> > >   #include <linux/regmap.h>
> > >   #include <linux/usb/pd.h>
> > > +#include <linux/usb/tcpci.h>
> > >   #include <linux/usb/tcpm.h>
> > >   #include <linux/usb/typec.h>
> > > -#include "tcpci.h"
> > > -
> > >   #define PD_ACTIVITY_TIMEOUT_MS				10000
> > >   #define TCPC_VENDOR_ALERT				0x80
> > > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > index f1bd9e09bc87..9e0338bce7ef 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > @@ -11,10 +11,9 @@
> > >   #include <linux/of.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/regmap.h>
> > > +#include <linux/usb/tcpci.h>
> > >   #include <linux/usb/tcpm.h>
> > > -#include "tcpci.h"
> > > -
> > >   #define MT6360_REG_VCONNCTRL1	0x8C
> > >   #define MT6360_REG_MODECTRL2	0x8F
> > >   #define MT6360_REG_SWRESET	0xA0
> > > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > index b56a0880a044..3291ca4948da 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > @@ -10,9 +10,9 @@
> > >   #include <linux/i2c.h>
> > >   #include <linux/interrupt.h>
> > >   #include <linux/gpio/consumer.h>
> > > +#include <linux/usb/tcpci.h>
> > >   #include <linux/usb/tcpm.h>
> > >   #include <linux/regmap.h>
> > > -#include "tcpci.h"
> > >   #define RT1711H_VID		0x29CF
> > >   #define RT1711H_PID		0x1711
> > > diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
> > > similarity index 99%
> > > rename from drivers/usb/typec/tcpm/tcpci.h
> > > rename to include/linux/usb/tcpci.h
> > > index b2edd45f13c6..20c0bedb8ec8 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci.h
> > > +++ b/include/linux/usb/tcpci.h
> > > @@ -9,6 +9,7 @@
> > >   #define __LINUX_USB_TCPCI_H
> > >   #include <linux/usb/typec.h>
> > > +#include <linux/usb/tcpm.h>
> > >   #define TCPC_VENDOR_ID			0x0
> > >   #define TCPC_PRODUCT_ID			0x2
> > > -- 
> > > 2.25.1
> > 
