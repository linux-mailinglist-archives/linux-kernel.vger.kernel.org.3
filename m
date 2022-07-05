Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74C566196
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiGEC5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGEC5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:57:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2109.outbound.protection.outlook.com [40.107.94.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B9CC3;
        Mon,  4 Jul 2022 19:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKHdZHGbLjWiKC4J+aHAveiJa6UeH0Rj243n5p+sj624UGgq5fNoDuWPtOFIKDcRjTZmBqmtGbcvRL96pVu7TgSAl22tSxOV2Yb5nh6JYnH2yehlg3k10enLfQdgW+wzck8OwSftdvju0un2o/I1IuXI+EEY1fNH5LQysJ75zJBgxkvBFz1149KIeB8SGYLNR5oei7iPVLVnuo1kjipDQOlUax6rdE2YbVrDoEeBfYQfQpYSQaEQSvbCHWEEm7oqsS9V3PhJsJxd4H4qeWk0vBuvwiLQnDufD949c0XbhlCwuFu6q1DQv/W2XOTZtM6Pehi/yod+VmhDT2dUcKsPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3x4BktAALcOZuM9qXm9Ud0v85blvcy4Jwifnl9CaBw=;
 b=mSy56/rAUxMpO4CMOYrn39QLE/WOsa++rHn3Jh4PYousxjEs0FIxd4wTORjYLg/Z+us43S5FpTGxkVZWc7vpPDnRlVRPwusgbUSilCiRScaumUx3Zk+KanrOGCbhOTAx4/xR+38PcsR5KtNp0lxS92rTkXhrjSeivwcsrnqtOSpaCkfgdt1Zxzb445Ih85MXuAxMqwVvOfhLvn4GPu8Jr/BPvFvlp1oD+6d6BFZQpp+luyth1TNQY287nv5RkyYigJMVADk3C5GN3ibmiIOiKajhJwMGKo/Tm6OKerCOJhXiTNS2QzEElWJuEKisFiZFklD6Sp+qv4Slkv99NxbZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3x4BktAALcOZuM9qXm9Ud0v85blvcy4Jwifnl9CaBw=;
 b=GjRzury+kLh2+RslITsQqdczUqSUOEhqT5/1W9OMeMaYDPpL/OHdopE+ArOnXv4eqFuCnk363J8hErOmW8KxMCG/F6qha6kdTLAahmudRuBggvgaYPXkl4MeTT8+z/4wSG/Lo9Ajc/EYgHPQ7yhPLgnRXwK3LIXIyG8OnttxCgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB4137.namprd04.prod.outlook.com (2603:10b6:5:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 02:57:39 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 02:57:39 +0000
Date:   Tue, 5 Jul 2022 10:57:34 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v12 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220705025734.GD2303286@anxtwsw-Precision-3640-Tower>
References: <20220628044843.2257885-1-xji@analogixsemi.com>
 <20220628044843.2257885-3-xji@analogixsemi.com>
 <Yrrcj5rnP8y4mjqQ@kuha.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrrcj5rnP8y4mjqQ@kuha.fi.intel.com>
X-ClientProxiedBy: TYAPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:404::17)
 To BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4595d227-5162-4399-a4aa-08da5e321f27
X-MS-TrafficTypeDiagnostic: DM6PR04MB4137:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzShK3TEDmheuEfXGqnlO7pqfnr2zvoS0fMXIGaDdWxB9f/y7wPTvzpmzk47RMuYKiJowlhupXEAnEuwp3dV4Mp3nY8gnBFCtW/FCABTxaE9yO9NFxRS4PmMCkiBKBOuG40zQFahReR6o4Xvbi2djY9cFYHpz2njzXtTXjqQ85hp3FalzTjNrxjITueqOspIH9LcsbugdxGNIK0wYPatOTHjIT26Ag0kYdTfDigyTnyiygDLm/5CgYAjarL3mbJzGiGAnYrOWRDbkJ5br622ADZWVbkmNnUaBy++RaaS1RnHHpUyJ2qt4JmeC+t+CkquAP3PbG24DPDVMCth0EN8r8pjmZ6seMg7cIKmUyEYb3wHh3+JSPGIZScjHH/r/bhL5UTY5Yl7jRcBQtWUWAEllIcmXrP1rn9ianCO/ewwKj71RJoPHPNiEQgpa10WyVqyqRiJ7srERXgoN+oDa6HN7WUsI7zzYva5Xg640luM4JQKqtV1prVVICgMqWUmDO1M6sl4wX0K3O/j1T/ELKlTT8WYSLmLyo00apwa8tGvcXcdBgKspnbe7tVfEP9zqAtdKFkLJRO8GolVvAImwcVokjjtqOU2OSekEkbIUZ73yYfZhnnWqGLm3xeMn4kO3qazIFqUOYwLgBYlrLugJdzs2SsIizF3Q5ytFDbbC3qjT9Js691XkrAFCCfmFQdfIuBs1XF2oHu+xBAluuoxYE4C5+4vAuC8T6guXkPfK6lTaR7kPO4vDwcRhOUIh29G0ihw73idtVohdOgDq0YRVKpY+JImr7Kt/LR7i61bflkSop6dT3k1ZD2h4g2ycsrhPtyh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39840400004)(366004)(136003)(346002)(376002)(396003)(38100700002)(33656002)(66946007)(4326008)(66476007)(316002)(478600001)(8676002)(6486002)(38350700002)(66556008)(6512007)(55236004)(26005)(9686003)(6916009)(52116002)(33716001)(6666004)(8936002)(41300700001)(6506007)(5660300002)(2906002)(4744005)(1076003)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D0ExSks3A+xU3BqqYKrbnesdCQ6Bo9W4WdysAgOjkQva8DD31khUwII7lqJ6?=
 =?us-ascii?Q?4Byo+nOomXmXOP5pJLp8vV3h0dSb8Yj9nj1Jx9GglACxct4nyo7SPtrC/Owe?=
 =?us-ascii?Q?gl00DyVQ58wjj8VsLr1x7vHV+Pc5e/h79x+1MjeaXs+8EOLTSTr5IymXwBSY?=
 =?us-ascii?Q?dwIkIqLr4a+6VlMZJQJi/g15nmsj9e44t63eMcjzpKpgLSXW/2SeaSQM9dze?=
 =?us-ascii?Q?LbrS88qxH4ssYoKACiQIY9WsZn1HCpYJrlfapAp1qh5YBEort5yeCymnmFye?=
 =?us-ascii?Q?2eev61vXEorIutClSoVX1JUvG9ez+4hQOateVdE+KaJ0TpfruCqE+OqJT5fw?=
 =?us-ascii?Q?YNqUIxS9VeXV7K8S/+OB6hWMx8fI7GsMwNB65jCmLzkJWOfEcUHuk98UWU9x?=
 =?us-ascii?Q?NSBI2VHXdxNmxQNm3IUBBkBDlrb60h7ZsoNV11xdovtcu6wdxZ0njcEpxfqw?=
 =?us-ascii?Q?D4pzO7exPQ3CpkZwqG+cmez3/IGkkFyIWyOwKrA1BcU1y7X3asLonuJ3/kFc?=
 =?us-ascii?Q?r3zH5B5XtWW0YTYzUPtkm1u/XqxM/O0MTrHeCqPG4qZZ6vyLZrskm1S7yJzS?=
 =?us-ascii?Q?i2ypgZ+NhsQ/giuahnl/JY9MvKyxW4nV3kAW/jL35Az1MzwraR25km47AvwW?=
 =?us-ascii?Q?737xxHwU7iKgngMfgo0s5EHyauROEOVIQIaMKzol3cC2FA+Ynp4dVjBjnejK?=
 =?us-ascii?Q?AQsjV4c1n3CEEkJS1Baaj7RX9PzLeDZdMUymc8GtubA6a06uN7AFlfg2nYbZ?=
 =?us-ascii?Q?wGf5WUOHXRz46HoljfMSLCXroeOwSE5Xi+WSxs/zjS1irsQrKfiGOY2ldCB8?=
 =?us-ascii?Q?4pPuICkxLn7hNbKdNyEOvaR1nND8dbfXlovXW0bF4KSSkoHrOgNP8RVRD9hc?=
 =?us-ascii?Q?t1pYBD7f5s7rjkUQd3ltryXrB3KFbbnjzvsezYOmyiz3JfQ3ns6bGNGoo1p+?=
 =?us-ascii?Q?mRR1CEewhqIioDbn1f62pyh91jb4KG4MgxolbC7vh/YMpBroH4cQNpGU8jpu?=
 =?us-ascii?Q?IX/SBnufo09nZCGBsFT+poKnqelOc5dNEYcxVV0c8vg9F3FNffDqIbaJ2b/e?=
 =?us-ascii?Q?FsXepiCy5xsF6OC0nLNLNbENnYgtoDybZPM2AUK40mwQEBpsN8UOokdyimAS?=
 =?us-ascii?Q?YamNoZlW+9ym6/w8FqSW72me08/rr449ry3YU1qawfhMLUrjGyd2rrzvoVhx?=
 =?us-ascii?Q?rKWBRqVrT3fAkDt34uTLuyNqq1YXgBTGriuAp05H7IsLL/dop+mhsFE0mIBJ?=
 =?us-ascii?Q?butoboPs9xBBxJSWo5vyFunFnK9xmQYaCs0rs5U5bQRDt7kouhKXSsDrzI6l?=
 =?us-ascii?Q?BVoA/1RjowG6mfmogBcOaRhNwfVpJ49mNSxta5qtQ4PzqNxtSOQ3tn/q+jvM?=
 =?us-ascii?Q?IBCRuf2AhP8UeXTAOabb/ls5Jd2uNcN6EnzTWzkgXUwPKqgMhZXD9KRFfZ1N?=
 =?us-ascii?Q?YDcPMPzyT8wpLFDT2/5oGDBRhDOx6t8uWwYQt8dW4rvoL0nOErc1BCAmmxGX?=
 =?us-ascii?Q?A7YaWhjZV3CMmfSvaBS7JejDd7bZUtQnnD0mNeGW2gLSbu55bURmO8onVUiZ?=
 =?us-ascii?Q?IcfHOGInyjcxXbPenWgzbI8aM0thSifV4m4h+Oni?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4595d227-5162-4399-a4aa-08da5e321f27
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 02:57:39.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMqAPDMbyFtr7hRzrHWrx5k/zBQ34tQu8cVwbEMbgwnVGSgBEXHgor3bz1vXdt7Tj+m8954VfCpAUfBQaq15Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4137
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi heikki, OK. I'll add comment.
Thanks,
Xin

On Tue, Jun 28, 2022 at 01:48:47PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Tue, Jun 28, 2022 at 12:48:42PM +0800, Xin Ji wrote:
> > diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> > new file mode 100644
> > index 000000000000..76e4b5fc0d9e
> > --- /dev/null
> > +++ b/drivers/usb/typec/anx7411.c
> > @@ -0,0 +1,1564 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
> > + *
> > + */
> 
> Could you also add a line to that comment that tells what this driver
> is? So something like this:
> 
> /*
>  * Driver for Analogix ANX7411 USB Type-C and PD controller
>  *
>  * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
>  */
> 
> thanks,
> 
> -- 
> heikki
