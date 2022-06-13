Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99054835F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiFMJkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbiFMJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:40:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2134.outbound.protection.outlook.com [40.107.220.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3E13CE6;
        Mon, 13 Jun 2022 02:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNe0Qb5z8iyx6SycSzf9g7JNyjLaY/GRZDtvVnKez87xo9e4u6abYZ1Lj6WB3ZDNLq3K47k0m6ydJmxIMks98K/dGeYMXi3yb7sc+u3yVWW+I8gJXI+eQ3QXnGsGet3xvph10KXvATQRhT1y0F5GnMxOTBhGp5aFBUGrmrtF/5PE1j31pO5IAA8s78DuHd2vw23AtyrFa6Cfjs94WB5LqpuuRbUbvgjNiLdgF6vdP/DWgNYgOPdoNAgjPi4ohMxlVIx+Exh6X7hhv6t4gxsR3x0aBag4Ua/7At+gxXQ5zNYlQnG3m6JXVSXkidnUBrE/ucvQVqpLOiwulVs6CBacYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdToBZUtLn/PXoQNa86XXrO5eM+EwNY4u9N6PAO5wLc=;
 b=Dnyvp3EuFtJHqOceWpM3M7a2FMS5AA6zklb3HRLnK7sFue/pbNRzk920gYhNva3TbyPaCpHzxDZg/ekBPylUXW8HoaOWovurRJCoAN1MK8bwus19l1SP6cXHZ7nwCQUIY6Wtcr6Kg26LChHBkUSdYyf6BnuTIsNPY9Eny0THiFP5DlzFwKmXqcHyRwRHfEToVXmAXZ78I2NHTxungSjwHLkrPizn5UMH1l88guB80Kfl6Gx0FAohtYtQmnc+br0C8/kR5nebFiNL4okFCXTw5HQxxZPt0hKYlUGMHhCKE7RmPfDOqx5sNZFm+DtN8KUQEUEgRhxAz9J9OsuWw9/GeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdToBZUtLn/PXoQNa86XXrO5eM+EwNY4u9N6PAO5wLc=;
 b=xflzY4+hKwxl1GfE6YMzA634/0TR9ZlgnendS4f4Mh1oW46LfoutN1HSS+FUroyoa88GAfcMBCPLPtv8jOE/Sgec73n3GRVrpsLK/ecdXb2E9HSSP8QtiSUv702kDTf7a34ZNEwonzen8quqIZYWwesnFkLmUnem49w3iu1rOTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SJ0PR04MB7472.namprd04.prod.outlook.com (2603:10b6:a03:294::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 09:39:56 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 09:39:55 +0000
Date:   Mon, 13 Jun 2022 17:39:48 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <20220613093948.GA1454902@anxtwsw-Precision-3640-Tower>
References: <20220309023404.1221453-1-xji@analogixsemi.com>
 <YqMaUroS87rjnCny@kroah.com>
 <YqMyxQGzPSs/HwVi@kuha.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqMyxQGzPSs/HwVi@kuha.fi.intel.com>
X-ClientProxiedBy: TY2PR0101CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::34) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd966cc-10d7-467c-fe51-08da4d20ac7c
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7472:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR04MB7472CBB53C6517891F28ACC6C7AB9@SJ0PR04MB7472.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XASgv3aBIoK/9XrkqIjNWy+Zdqr99H8PrrDzV1we/m0uWhmXKt29RRAXrfnXATc6eLsW7X4527WrtCPuXKB/dYmcaXX9SSNcSVz5GNApbbogG4OJv2JZrnCkFq9Zu5lb6TM+mmQJnCvg2VVenuyyEfgh8Sec3EJBr310u6jPhpWOJ/FbiVvF25KtmbDB2f3c4GdSemvN9LwXtftevYDKEratFHpVHzXaQVT4FOf5dPBTUKT687vq2QHdgoPwf1s4N17Ur79PBSG2WRrDbGBlWsXmnhnxGNzHD9lMorBBTsqKa7UYXv8UqqX+SyG7DvhnOjib2arDeomOCeWr3fNQsseFg+wPhfMOjhWlvgcFUsWViutJtIhpkuOzgFGUxorzmbIbY5fIUD/bXCyDriz5z2r0wtvfSOmUWc/9GaZkCV/18s+5rOGVo9j+Gg92YUuy51BRAvA2LYQvgMSPkiprc8l53U/pxWJNFamGObPo7P57ly507Jmc0UyCrMAZU6b2VOr5HA4/A3nX4SqSKBZOv+Nfcibf0jbw9jJ/DBmsqgXjKpCZoyUiP4QGxJ4w1s7cMTwshwyyb3s8penAF6sAK0VtHzinFk66JqEQdB5fslVQcmCi6iFRK+j6T+5DRo2md5pMnPPJVA/3JS7MLafwGwBuWAoCKPQXHQw19lsIyHAr+tV3pudLjpuVOdzNIvlz9iu2DmzEVLh3C5OA8WDw2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(186003)(1076003)(8936002)(33716001)(83380400001)(6506007)(38100700002)(6666004)(38350700002)(55236004)(6916009)(9686003)(6512007)(52116002)(54906003)(508600001)(66946007)(316002)(6486002)(66556008)(8676002)(66476007)(4326008)(86362001)(2906002)(5660300002)(26005)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GzEc59HF21w03VxqlM6ReFS61Y6NstPTY+podrVQ7JXmjXXQVPNx1gfrrO3s?=
 =?us-ascii?Q?CA6wSULfXftIcpCm7GI1BKICBm0HHdVvcmMsytwvQzYpoN5g7Y5n6314MAmN?=
 =?us-ascii?Q?JJzUBvAdQIWJ6LvHNyCKv15PzX8htWCwmeb5qN64B7fSB+CfNDeAO8dcWWi9?=
 =?us-ascii?Q?s+AAQfGyQMCFd9iNFVw3qlBDv5iew0huZwEfaba8xaEFPfscft/gJwJQ70kk?=
 =?us-ascii?Q?fHCYzGcLXMVu1WHpKZ1b/FBIulCvXxL37h7pdx+oipIN0LltrvT2OB1KlqRG?=
 =?us-ascii?Q?5oGiziuuhHF6jrSlC/qfIA9ipDbcfAEVeadNNn+jUmcHyuEXULtxZf6giFhD?=
 =?us-ascii?Q?e8LwbE63vOdOeOzGrY5sJKHjskx5mEcTWruPoMpQp1c+M1k299fnkM/IUJIX?=
 =?us-ascii?Q?8pTWKL2HquFsjsDZNxkhynjErOLuUAjbZjxAomgUgb9oZbBkDTdEt/QviZF4?=
 =?us-ascii?Q?Cm4TXKUJNTFbrCpgxaF0CFHAwhPngdMqcL+hPNuSRN17Eq5UMHdsyiLwGqPI?=
 =?us-ascii?Q?gZ/csKIwCaa+N6XWZydcKMNFbbogRHoFdOGIupweTSyO86KYDSy4No2TKBvN?=
 =?us-ascii?Q?Fl6Pa00wev5ayZFuawm7E9ntojqSI7gKPUMPWdZ7+pdx+87YyOwSpSpPS41t?=
 =?us-ascii?Q?cMbDeFYqX8ws8/aHAJnbHhZQzw3YJBwUwT6PByPaGRPFrDeF/t8mj4xmRnHI?=
 =?us-ascii?Q?dQ7SeIuOSy5xSC7YcUDty8FuG+YPlfNPvb45upP4/I3Fa16V/lRpzRPM2iZ6?=
 =?us-ascii?Q?YiWwRS6/+sDRdgGjfCMG7rPVjDbiz3DvQPmJqYVmlPn+77r7l2QdDvGV3fvh?=
 =?us-ascii?Q?4rR6Iye3RKJkK9vFCVww5d81n4ZAvs8r85k6bq1Fb/CsoZkbQyfxxH7298mb?=
 =?us-ascii?Q?IAWtE05vMMjSAcJidMgVYrKeKjHr6RJKSma/ihbfUcVzv1lEd2FyOgzSWlL4?=
 =?us-ascii?Q?+/KBNNwuG083CG0GtO6PpytJd56CGm6xmWl5tmqDwOFOw1NQrkblnxhLsAE2?=
 =?us-ascii?Q?ZNF2VIwffQH914Ic45TFCRVzD6a8qxGlONt5rJw4yNxfm2kcrJ71bBxoTSTA?=
 =?us-ascii?Q?wd0nj/B2UEDkBQx1jtF2DYvuiD0kefPapTqJns2961dBPiYc050uhF2q6dvk?=
 =?us-ascii?Q?yvg5UHDkaVmdXw6kZv6BX4h+M5zZQ5g/hT+CcvdUC+eUwj79klS+Ebu08lte?=
 =?us-ascii?Q?XhioxXGFpGI5/Oa22kO0CqPysNujVDlgf79VvU5OGx3UjKJ0EWNVNUfwHqOf?=
 =?us-ascii?Q?O5norcfOKVQfA86TP8NLh0RB6+xi409uPdHGyTHRP9XwJXZ96YR2TkT+ykv7?=
 =?us-ascii?Q?Xn3FvRGMNABK3azHYUrvPESxXZ+AMuGF50CzdqBpez5TOpkDFWDvCoxqLWdN?=
 =?us-ascii?Q?D7nCNS5i4k2fJNUeMU2SlLCpUbsHwOLRsf/qNWfSDGwosRw9J3QzMNLlB24C?=
 =?us-ascii?Q?+qhVwU5B9n3XDAq7S8fFm0dXqX+LM1LB0bHTdbkwQkZc5uvDEX0OhrUniUCX?=
 =?us-ascii?Q?/loD8KftEGSQ5wcyJIY2/GsJvmGf14arx+aybspO79tUHn5DCGnV8P/2T1FG?=
 =?us-ascii?Q?ar70AOYtmMXlZfxYlA0MXqWZ2ePqmxUFJ45JiYbW7DxthL7Qw8v43OPUZ4Uz?=
 =?us-ascii?Q?lQD/3agOPWqSKH5vj4ygy+AhkD0AOK0NDJiWySTw0u7CQgUWoKFm8IxNUYJW?=
 =?us-ascii?Q?auVK+1kQLQXwU3UkoZ51gjPYrELNGZFyDM6exUtdCORfuYd19buNrZY/uqRG?=
 =?us-ascii?Q?4xaIAgy22g=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd966cc-10d7-467c-fe51-08da4d20ac7c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 09:39:55.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0wEW2GQxiWRUUwJybJePv1JpYuxIVdToU/sIvOTf5n1GWam8EspYFc5mtdrehc1QZWm7JvbGIA69X2KkPeWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7472
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 03:02:13PM +0300, Heikki Krogerus wrote:
> On Fri, Jun 10, 2022 at 12:17:54PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Mar 09, 2022 at 10:34:01AM +0800, Xin Ji wrote:
> > > USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> > > and a port controller (TCPC) - may require that the driver for the PD
> > > controller accesses directly also the on-chip port controller in some cases.
> > > 
> > > Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> > > 
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > 
> > > ---
> > > V8 -> V9: Add more commit message
> > > V7 -> V8: Fix Guanter's comment, remove unnecessary explain
> > > 
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
> > >  drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
> > >  drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
> > >  drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
> > >  {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
> > >  5 files changed, 5 insertions(+), 7 deletions(-)
> > >  rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> > 
> > I need an ack by the typec maintainers/developers before I can take this
> > (hint...)
> 
> I'm sorry for the delayed response.
> 
> Xin, you need to rebase this. It does not apply cleanly anymore.
> 
> thanks,
> 
> -- 
> heikki
Hi heikki, OK, I'll rebase on the latest code and resend.
Thanks,
Xin
