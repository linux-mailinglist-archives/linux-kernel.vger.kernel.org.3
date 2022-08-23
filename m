Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76A659E7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343521AbiHWQlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245164AbiHWQju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:39:50 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140052.outbound.protection.outlook.com [40.107.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202039AF9D;
        Tue, 23 Aug 2022 07:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM/l8M3Eg6ykkjCVcuPp4B8+JudTcrf0L1cko5gihqEAC68oCthzIK2sx1vsF04ICUdsFrMovlsjQ7GKuemvGu3MlZX/VWKX7GiH3pI6QcKyOp8x1W0Nky5Z/abUYPy4ltwxXraZLgCDmPx2lIqoeLcdMZayOiTIKZ64L6QTLWRpykRr2DqdGyfy4udjB6QLFZAarG+syE05OOmnKHeJqvpGFa4nnaLv2tBie16kyzsQwimlqV2+08NJTQD6dczT/yAcEJLj+WUAhZbXzL5AmAIPa1KcnJBc5zn0J0Xx7GN939ALVtLxhNb+Mv3HYt80d7mnXYcg+KhVlbT2rPqKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aOiVTt/MFX660a/yaBIgqdPkmS/1CkqL9ow9DomOGc=;
 b=aELzKwsELLT/uIaUcgOCbml9Jo44Rp/Im1o42OGkm5JaTH6Nh62H/k6eqCA9Ad4+Z4NSmLAXBerMx6cgTDz30aB5Li0UxO6v528Gmi/age3O+bvmKCmKTcxG47Yv1ylu1HmYel2TNDId1fYrGzoXgp4Pi0z8141BxNKx40jok4zlkquQdLQTRNfJMCfjbrbKMyoNR83/l3EwJiYZBWJvL12i7UT6K3s513z3lN2P0Ho5e+Bp11GvLNwBibyAVK/80O5Tlwy2rl9VVs6bnqpZp4eECO9DPNwuBDrY0RQ77gJZhGbK//FH3nU9hbnTDtZt5mi80mypG8j3EVnjTI2GVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aOiVTt/MFX660a/yaBIgqdPkmS/1CkqL9ow9DomOGc=;
 b=McApD+RQHsCjNnhNEKg/dCOCae8RdWodwKe/6d3kI1qZ01SOOCLnmhsCJV/HGSxVtsdT34gNjFoX6nxJqZWm5v5IWaddcqz6lo7buROfRQzThLxhcZi7MWYn/fdMFJwTbA0jDyjrdbYBpMgq5g76PlJw0qZpkTda6EV5G1qCEGoFxnAzvaLqdNo0YC8ibWNQ2DFGTjaav9qXEjpIEC5EgWqVf3lSI91nf1/J56toPHB4FBFbTjhXytUlPYGESyIyIchWr/ESeTJNKhBmlnhbu86fVI8mUOB5apBoBWi2DkIqCasXk8LlN/OhO3KSk+S0VwGgDYPnKiTeGgcI/+7I/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PA4PR10MB4463.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 14:42:10 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 14:42:10 +0000
Date:   Tue, 23 Aug 2022 16:42:07 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
 providing driver
Message-ID: <20220823164207.6de6c387@md1za8fc.ad001.siemens.net>
In-Reply-To: <YwTg86pKFtT0gax0@smile.fi.intel.com>
References: <20220805120343.5027-1-henning.schild@siemens.com>
        <YwTg86pKFtT0gax0@smile.fi.intel.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0669.eurprd06.prod.outlook.com
 (2603:10a6:20b:49c::14) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 387b8f0e-6983-4f6c-c208-08da8515a8bc
X-MS-TrafficTypeDiagnostic: PA4PR10MB4463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKwAnKStrmUGgwgUlsMzNA4HVz5UYfiRv31FKf7GdB7Z+FdLhpThecX/urCUOpMOZGAsb7BZWH2L64Db4b7vm31Aum8XGXsCYQhPsliyVDPT6rDmhB9ct/sv65k2FfjYc2t1Lyhw0HeI0tZ+gQDCfs/4xMxtwegNGFikmziz/2p0h/dEkgpawl6rizz5CGZFA8ibItuNtIlpU2uVXgF3JsYHMW43zVAQP+HcGjtPlWOCbq06pLkS/eGTUFuC7tttQMRUdEG65CDXG+i0ymPpr5azq3Rl3KgFzn77vePgdgrJ/gMWGUV+d2jZErSrp3yGoioYqfKAGdvgwp3Z5HCCZi0eX+Wh5S7ajtJCDzCnHLxB8YBC+p96jofcvC+ghoW1czEoB5xRyRr1i7in9Iag01qFWsK6oBMXCCuFJiulej/hh9frINW7NgCbGeo42sbjYvj3i2iZ+Nwl8QZqgbmtagsA4tVyhPrwnz+0+dcp5PXaUqOYMAPAYLrozdaP/pzYh+2gRUgrPQBWcJFtZ5CXE5cycSmJ8KRk1tufJxZaC19Z4DKExmgnMeloUuRANfVcrYgIfsnTBO5kSNfyefe5P02ztU3skRQ9jN9UttvX4uMZe4mv79NA8g9WRQU3bY7q4bGA2iEG7WCzF7ZDhpXpyIOrspyvWMM6jO3IMjQppWPAr8NoDwk2/S72oy/XoF1jXr23sa2UPROx0MF7umMidA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(38100700002)(316002)(6916009)(4326008)(86362001)(8936002)(2906002)(66556008)(66946007)(5660300002)(66476007)(82960400001)(6666004)(6506007)(9686003)(6512007)(6486002)(8676002)(478600001)(186003)(26005)(1076003)(83380400001)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97qWBfGGByp+NhFmac7FJBrxTU1wXr5vaBmQXDRBpyJ5uC60iTTC/QYJHCkx?=
 =?us-ascii?Q?9A97pSCaB1xGNvxVOTVsiNYmzcTCfQ+Ybb87ligF9AyQh8D88vF1vp+4g5Ud?=
 =?us-ascii?Q?KU5etjA/neDR+fH9x85jZqUmTVQ0aatrmeS/fwzqH7eogFwo4B346tYIMpIM?=
 =?us-ascii?Q?Tfhe6xm3Jc6J9CNInlUKtRHqJbm89P9n7EkbAQbXT5Qww/AQfap6xm8W2RFr?=
 =?us-ascii?Q?mv+SvAbmGrTmBQY4V7xhK2g2nWOXkD2jZmg+HrKscZpCEAx7xnFOo4urWFYI?=
 =?us-ascii?Q?VRl6DxbXJGVT3bB4Lc5KMeykU2oH7zqplK6sC3o5Iy5jZzLtLYAiZiMCg3IN?=
 =?us-ascii?Q?ZKBVM69T0Puc6eAZ8FWl6BJWd5/EHYZJnK/fI4Pi3Lqn79M1rGYAPAmH7JCN?=
 =?us-ascii?Q?HUdB2V37Eg22t50p2y73GPa6UPn41cxUMCPBputUsc6v4vcBHNZp4aIk4xKr?=
 =?us-ascii?Q?mbhtWCzjTTc6XtzyF1OEVPvVWNDlXx8axJwsQbfb6r2f8O9HSSXEz/ftDG4A?=
 =?us-ascii?Q?HbZd5hO+2YMwyFtx5r4LhNJtrw/Ns0pcp4UP0CYeYkTcWJfq3QMVihK9SEBC?=
 =?us-ascii?Q?EAgRgixTwJG/UhDr0IIrxFlBwZzkfhbj2JwJVi+/vHu2MKUpS0jGqaCUb9Gs?=
 =?us-ascii?Q?+r2+Q6i7AcqZkM5DLJZHpDpDkRetNHr2Lae9Ktc9csBF53pWVC7MU2zYsUmv?=
 =?us-ascii?Q?j8Bre5ubHqT8YlTHQ+XzzU7lhgQhqUVFzvYYkjqzw2AjFDzAKyAwujPyVo+O?=
 =?us-ascii?Q?06hQrXVQTI49spI9mpfy/2yqUInMLb90my7TOcXAzIih4QlIwlKKaV852Nt4?=
 =?us-ascii?Q?ZHDzn6k8LIMilo3J6WMvHoS40bt13hrAtRIYcZbJAvh30K6IKzTN5TEk0/D/?=
 =?us-ascii?Q?ItG7r3NUl02THC5Cb6sV1ElKxlgjCA3KARl81bOo9at+a/qDxDqKrbcLZfpA?=
 =?us-ascii?Q?Risw3n7lv1UAKxRKXDsJX4L0ea3zHx75VfL/cThNe0FokY0kk6paM93kpqS2?=
 =?us-ascii?Q?SOYE0uzxsrEB+BqBS9L03x/C34PFvS/Y133HsuCds7GvVCiPmjf+cBtCgvsx?=
 =?us-ascii?Q?LwGkqAHyCqfYsYj66IG9ESBN+GUqO+8s50rMNlNvb5D4oE6SUOW2CVFqBUuF?=
 =?us-ascii?Q?ugrFjGyOevBouybJPIhnEe8orSWHR8jE9D6ptpPGvpj4m8YxIKCO87EWzXDk?=
 =?us-ascii?Q?m6DWxW06pJ9ex9uqb898OECFNe3mlEM6nR0f7hsTwxbhc66Qjv8cHMIo7edh?=
 =?us-ascii?Q?MupqxOIxFIlLQ1BugGPAZJNPBVuwu0HhimSOmhqE3ACVhlea3hp2fjcClJ0F?=
 =?us-ascii?Q?eFXSDp8mBOo5jZ0Gdv1QC6AZEiFxwX99J9yhKfvoOGztTUjgJdPW11ZPBSyI?=
 =?us-ascii?Q?zIlmB/lP/7hj2jlGyS4ruLCK3JW/1mMsi8G+amKgjpl72mDyAKcKNGszetxh?=
 =?us-ascii?Q?uCVUpDfVmKyIVYK3rWJzNFwJ28oh1Wa/tkeZ9YJlLWxRZ9aPs8Ax2bPZbqFy?=
 =?us-ascii?Q?mVzhnH1XgO8SUAORe8IOk4QP1hpFfszm8PeZJR2YoGy0jhwE0mZFb8X5CeAU?=
 =?us-ascii?Q?qEPqv+n5R3v/cRcGn385Ci5JppUgpckYkuOt4ZDNKZ0d8igJCUReSQi5/AcU?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387b8f0e-6983-4f6c-c208-08da8515a8bc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 14:42:09.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iD5qe39Dyu5qyE0ih3HGsmgmDo+zmebhazU10G4uMG34plosBsdgDEvh16lTI1X4WVcuJNivon6HmHJQsXEA3KNq69Puhh/xgVS4EseRMso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4463
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 23 Aug 2022 17:15:15 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Fri, Aug 05, 2022 at 02:03:43PM +0200, Henning Schild wrote:
> > If we register a "leds-gpio" platform device for GPIO pins that do
> > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > later. If there is not driver to provide that pin we will poll
> > forever and also create a lot of log messages.
> > 
> > So check if that GPIO driver is configured, if so it will come up
> > eventually. If not we exit our probe function early and do not even
> > bother registering the "leds-gpio". This method was chosen over
> > "Kconfig depends" since this way we can add support for more
> > devices and GPIO backends more easily without "depends"ing on all
> > GPIO backends.  
> 
> Not sure what we should do with this patch due to your self-reply on
> it. So, if it's still needed, I would expect a new version / resend.

Ok i did not realize that the P2SB stuff made it in the meantime. This
patch is still relevant and should be picked on top, to deal with the
unlikely case that this driver is enabled where the gpio driver is not
... which would lead to an endless probing loop and a lot of logging.

Why would you expect a new version? I did not try but see no reason it
should not still apply. There has been no review comments, which means
no change needed.

Unless we want to give it a Fixes or something and consider that
probing loop a bug to make sure the patch makes it into all kernels
that carry my LED GPIO stuff based on the P2SB patches.

regards,
Henning
