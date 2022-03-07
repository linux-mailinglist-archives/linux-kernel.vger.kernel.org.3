Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BFE4CF184
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiCGF7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiCGF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:59:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2111.outbound.protection.outlook.com [40.107.223.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844A50063;
        Sun,  6 Mar 2022 21:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMZsFUMw+RFQvSDuj2yYlhF10BMf1JSZho7jOh9IF6NxIM3o5kX5ZQduPg/5NlM5K74KFJTRz9wJJYxJztpneKtIo8IiBT8MD8YIxORo/Bqi9+2TI7R+BCgVMgfU++4MKRLmGyk8PI8ByWleMdQ4WHv0ruOwRW7wEzwjgqEkhbwD0bmDNwRmXWLpEri2fHMWwjOTP6oMQrHxV5SV8maAYFgSlSIkBV7Rwi3Oq+VUxK3M9nELdWxhCKwmdmHaSsUeXEEn0McBb9FDpqc/9Ooh/WTQm5I7YvlUn4itYP1aWPhIAw8+SS5z+oSd05T3MAXlRWKEygQ9UolOLY9m2QUW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K50aV1pr4oK1b3L/8sGPRxO5qZTrvTy7DG/KdXbj6ks=;
 b=jS2sWu2w6Gb9m0Nhot1ZgkGojcdMLQCdZrapf02BhE8gViVyyXUtHhmNHbg6dUOBIe+HNme5XurAvTzCRkGkedLXn4zypvp4RmYFVq0EWfBfzORNj1p0yzFLwmo9DwC8owlCX1osb7r7/RP/zRayOPxgL6lXjpzuoDn0PIt/MT4dIXJteu3W6QfDROyaqM4G+ek7lwwmahtgb0SmqMVsarPy/lI57OiP3JJkZ9TIV21g3qO4cTtSWZc+Tq/HvBVrhMMckEO3eqDpE2YVFoaHVUUE/VXHYMBck3fz7iulu/jA0p07CHmLY/JNUCyZiRWhDngtfX5tvAD26Y/flmJi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K50aV1pr4oK1b3L/8sGPRxO5qZTrvTy7DG/KdXbj6ks=;
 b=FX0+EoB8r9eg1XuI8MiWrcYOt4caZ23FAh/qNuyk6AENFQmkIQWL8w3Xx9HnXvuEv5n7jF750zj505PxjLR+hS2ZA1bTxNbwBnce3sWYqeRi7iUUN/LTcx0HaNwS1ZNlDCY/X1E4gRUowe2PmCJkaK5/4oxxj0oKesfLS3HwR6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
 by SN6PR04MB3966.namprd04.prod.outlook.com (2603:10b6:805:48::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 05:58:43 +0000
Received: from CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::ddb7:9604:5e6d:af43]) by CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::ddb7:9604:5e6d:af43%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 05:58:43 +0000
Date:   Mon, 7 Mar 2022 13:58:32 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220307055832.GB4174271@anxtwsw-Precision-3640-Tower>
References: <20220223102353.3833578-1-xji@analogixsemi.com>
 <20220223102353.3833578-2-xji@analogixsemi.com>
 <Yh9dBlrWm3OicQWa@kuha.fi.intel.com>
 <20220303024757.GA4159259@anxtwsw-Precision-3640-Tower>
 <YiC+/ccRvR/+mAkT@kuha.fi.intel.com>
 <20220304022936.GA4164495@anxtwsw-Precision-3640-Tower>
 <YiIF+PpuIeJMY+/T@kuha.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiIF+PpuIeJMY+/T@kuha.fi.intel.com>
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 809b8882-4e46-47a7-62f2-08d9ffff8935
X-MS-TrafficTypeDiagnostic: SN6PR04MB3966:EE_
X-Microsoft-Antispam-PRVS: <SN6PR04MB396652F456B7AD83938C10B4C7089@SN6PR04MB3966.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icBz3in/ZgIN2xJJ/haR+fL8ASbQ5kw6BVCasv8+Si/F1REI4mqgecq6qSVtFRKuTB7iT/ubERUP4G8H9CulfdQYxRVRShERfBzw2CpgCUF1YHemzzOSL+pUC5EamLMKW/7HiEu4EWQ6aZB6Ui7Ekj01QQ5A/LKndTHl4NS8c7v1aTyBMXxOVPUIGZVQWmXkYenznF9n0ONH75ApTHU91yqOlB8GnDs8RHZj8bmt6DfIehiRgkJ0qY1otKFH86kxMvRfuQjhkcywV8SKJBTwjFybB7WJd8laYiYbeft7eiBrwKlIElipsuVnmXIjBPvrEXzGFo8mMsNmQd5SePo78byfdRz9Iv2hbBDMJXl+lvlkPootIc6jNfVVvxoVcg/oCv3DmX/BxsrTPWbOcG0jn4zv0DNRd/rVcZ5Pgrc+6HKF2+C/bGHARj7MJOqvBmVYg56ccwe38Ur1TMMo5bjgV3Vv6nahI4v0stJrs34SaflV3a95yVMSD42nvwi/uTfMKS3GvBUPGROyKOhixp9THm/Yygz9jEfqXObOQ8pZqjP7MmfWIvef64nubA42j/lJnh9S1U1/JXJUdyRKGNKKTDoG9gWSgHAwF7nzDK4B3v1kYS6wNzlN8zGTxt52JmWSo5lUXPVTfzeFD6kcVGmAqvvMqBMnoj4OKS1ujy1/VZYwuvUu5GAgklujOGO/erAa58CAz1qGJn0udKgJqjBdww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6741.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(498600001)(33716001)(86362001)(186003)(1076003)(33656002)(26005)(38100700002)(38350700002)(9686003)(6512007)(55236004)(2906002)(6666004)(52116002)(6506007)(6486002)(8936002)(5660300002)(4326008)(66946007)(66476007)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EglJmQjZTyJDVVVnDrNFBf8WgwLNFQyx0vlqV64gJbgwwWaS/AdaVNdbVv7V?=
 =?us-ascii?Q?joYLLd1tXPZo6Q3pknnNTmWYo9nE/TGJsSxLrkvF0yEbwE5kIpl6CyIdJbpv?=
 =?us-ascii?Q?4LwS31GUFJXGYYzYFdhMII9mlgLxr2aUauVrLmfdva+rsns/68lfVVbkpiMN?=
 =?us-ascii?Q?mcNwMZM0plHRs72SKiylZIMFpwp4/qDbI3pp/DXLhNlmS6Jd7EAE1L2lVs/G?=
 =?us-ascii?Q?HQkEL237RXaknAaDAeCqBnmcvxHThVs2MfQsV86rr21hjaCGCiPP8l9TZgqy?=
 =?us-ascii?Q?CetsGtXxR8AOWDIebNPv1wVg9Ut2Zy+HN+5iY3LlhUhN2WK/9WcZ9RwiUdxR?=
 =?us-ascii?Q?1mAzhB3rzjU3JP2smloRzDQJjiLsfsj6DtWx4ad8weg5qmwLnaqBBzTloaH2?=
 =?us-ascii?Q?zb2LsK3+Tg0OQdpH7r/Cz8ownqAew2DmVGAZufniIhxkel+6PXUlHPH6beds?=
 =?us-ascii?Q?kLob6z+F3WWT+jfIq2jomZ+HnKp0jlZ80HiEB9rO2y7AjEcwBsdEOie0z+FH?=
 =?us-ascii?Q?Q4OrTtEQOu04d6mEgRKRbh3tfrKsPHPg0kAmk2FXSABcfWNOjPcDcOWI0/U2?=
 =?us-ascii?Q?H+zAiR6MRrOoNvvhd5BLtOQBgYxA2Mf0S5cLCgSXxt26HrfvQzkspWzzJ7Tr?=
 =?us-ascii?Q?4sFjAZC02SmjgyhkS6boqAewY99H7L0AoeTzc5o/WH9bsb/UjkCjaJ6tGgcG?=
 =?us-ascii?Q?OO8t65HngvWp9WneiTk8I7aEQlani90uHISRx15xN8Mre3JyOXd8Im8f6e+q?=
 =?us-ascii?Q?dP1+kfwTiYCWgCZrUj1NVPe9ABJu/92ixErOJpqC4+q+wSWlPhpraxN0grRg?=
 =?us-ascii?Q?jRYT5Lhkpeom+bQBOplZBZPyz7gXCw3/4EZ8KIC21V6cUk6K2P+sS0mrzw9Z?=
 =?us-ascii?Q?ddcfO3u9XehI/VpCyuqoytjt6buxFYUB+n8goTCaVHC/k0UONIBmJlq5ppbk?=
 =?us-ascii?Q?Y2M7BWz1JfWQ/IgQmm203eB7XVE7SRjUrFJgzKVDsr4H/l6uJpgYjZN/exMg?=
 =?us-ascii?Q?OipoOS6g2IHme1z1Vf9Nn3RqN9Ldv9oYTUDOHDjMAi3YWNcMDKy9+veW1bqz?=
 =?us-ascii?Q?20BZUnEd8jxfr2wFBloeXnhxQ3NybK10iI3MJFWvULjKcOlRF78qCG2atNaV?=
 =?us-ascii?Q?uJ9RB9XvihpTUzk6kcw7nuRRbvXVrvrRmP6dqowogAUz0z4QYSOrA6G1W4X3?=
 =?us-ascii?Q?DSTiugEfyDNlByFgIhQCPb9pd6uutxGu39/xppJnT5WRFwZVp0q31WI1B2Q6?=
 =?us-ascii?Q?PLMgn1elMr1E3rPOZcN+6zoKQ2hr8h+4/IPzF0y8TSBOmtYXAwL6yU6cUF07?=
 =?us-ascii?Q?rumhlZwY9EbEPgazPheSoKx11AufgQUr+NkT26PMr7yxsr2514MiRJKJ/kvo?=
 =?us-ascii?Q?xS5ilgezMkL5ojaTcYl0f/L4U750lWaca6VRRI9Knu5OGu6oujVyYNCQgg/i?=
 =?us-ascii?Q?zRuLoi+yT7/CNL1vjdxCsvNlu9B91uyXxHadxrdlqt068orjxMvejAXkHkrW?=
 =?us-ascii?Q?rZYeSfOza/zon5D5+sU/JLXxf4t3YSPnSc+UgpW+5E4SJmb7hDm2jk95tH4j?=
 =?us-ascii?Q?/7NVuTqcuwepcyEidjEqJOoiKGwrDpOcqnewogkx72YP6h5OuKdh77Rm/3oM?=
 =?us-ascii?Q?qNHLyTBaEDSQzb/r4BhCEfU=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809b8882-4e46-47a7-62f2-08d9ffff8935
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6741.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:58:43.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dO6k2jqrwX/r12NbfJfKo3YB7gA/lDjev1nwLvUoVkTnP3DsHLgovBg7Zv0H7Opkypm8yH24L5uSQdJYJLW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:28:40PM +0200, Heikki Krogerus wrote:
> On Fri, Mar 04, 2022 at 10:29:36AM +0800, Xin Ji wrote:
> > On Thu, Mar 03, 2022 at 03:13:33PM +0200, Heikki Krogerus wrote:
> > > On Thu, Mar 03, 2022 at 10:47:57AM +0800, Xin Ji wrote:
> > > > On Wed, Mar 02, 2022 at 02:03:18PM +0200, Heikki Krogerus wrote:
> > > > > Hi,
> > > > > 
> > > > > This does not apply on top of Greg's latest usb-next branch. You need
> > > > > to rebase this. There are also a few more nitpicks below.
> > > > 
> > > > Hi, I didn't found tcpci.h in include/linux/usb/
> > > 
> > > I'm asking you to create the file.
> > > 
> > > So create a separate patch where you move the register definitions and
> > > command definitions from drivers/usb/typec/tcpm/tcpci.h to
> > > include/linux/usb/tcpci.h
> > Hi heikki, I'm confused, do you mean move total tcpci.h to
> > include/linux/usb/ directory or just move our driver patch used register
> > definitions and command to "include/linux/usb/tcpci.h"?
> > 
> > And I think the other way is, our driver patch just include
> > "tcpm/tcpci.h" is better(no need to create new file). What do you think?
> 
> I would prefer that you just introduce the global header for them.
Hi heikki, I'll try to move the tcpci.h as global header.

Thanks,
Xin
> 
> thanks,
> 
> -- 
> heikki
