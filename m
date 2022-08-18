Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2505E5988E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbiHRQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344776AbiHRQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:31:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150118.outbound.protection.outlook.com [40.107.15.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995E96556A;
        Thu, 18 Aug 2022 09:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcubtjUc5sEkIlc4eF+Y2Fkd4dSZJA+PQ/q7atfVwG7NnF8P9xu0XL6QLe1c5oy3xEIP3zyOGR48DUNqor1KBqwgaArEhybxZDDNPwS8m8peVkRSemXfJrGBZ/fl0m5FJ3XNl584iY0ISxDjjGH3f7IYCpKRIu9CSXTcj8BGH31tm9WSz33HIT6fWvOo1FsGRMdFrAPD+IbsPqUy43f2lVWVRNd2j9YVzkWOLH7aN9uLysCqTalJQ+0mp5IE/J93bw8HHSaqVqV4t1bqpEHRuYQh081HT9IHeILuxmfU09G9a8/SsSAXEENa1nJCFIvkMencmXEpkeo9JdYV8QEXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9LWv6HPjVdFh+wnS+o5wQZYz+pLVck8T09pD1ZnMkk=;
 b=D3jDrKyM6MlzoLT3D1XxfMqWSEpTA2kFvbUn21wnM8O0t14ia+O1VUgAi0IUwzvfDqvXzUzxaSv3nBEQhM0q0kjP5l0jTr+uXYQG5iWDgHTExliuCepi2Wj0Y2kgXbrIIdY04ZxLNaBguJK35qcIlYdGFPTywlVgxQVa0IQHlVB9hdRTBZak6bQTEXORINX2WjjZlbeeqZC+OTFH+6zp7RSDHfeM4Oioa6pQ9RyIsrG+E0tEOx4sNVVtys82aiEP1Al33b5AhtVVanEinOUFVI/taVF8oHsROe6jqFR3TmRIwry/N1Uhu2lkcEELjdbv/58V68opElcbfRB4SzTt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9LWv6HPjVdFh+wnS+o5wQZYz+pLVck8T09pD1ZnMkk=;
 b=Q40xXHqn1gzjxLcINC4X/RY1lOqVAgORBVnf3HK0+T39ve2eGIVFHXPk61pTJJ57X4bGTRjYXhHOj6auuDYpJqqUZtLrf2cY3bEdyusEgIRQNpgIIRloMTS8ReAgSxA8TNYjqqmhYmnHKHtnx9ELDOVnalyWf/VLJeoBgCmdztM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by AS8PR09MB4568.eurprd09.prod.outlook.com (2603:10a6:20b:29a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 16:31:34 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::c5d5:f297:2a62:a4df]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::c5d5:f297:2a62:a4df%6]) with mapi id 15.20.5525.015; Thu, 18 Aug 2022
 16:31:33 +0000
Date:   Thu, 18 Aug 2022 12:31:26 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mark Gross <markgross@kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Message-ID: <20220818163126.GA47319@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
 <YrXtH1z2JSmwLS7W@T470>
 <20220624184431.GA4386@zipoli.concurrent-rt.com>
 <20220626123019.GA51149@zipoli.concurrent-rt.com>
 <Yv5j8NQ72KXu60nL@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv5j8NQ72KXu60nL@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:408:e8::19) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28168cee-0670-4abb-6bca-08da81371d17
X-MS-TrafficTypeDiagnostic: AS8PR09MB4568:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpwyRpLh9Y5jzauBbQGebvVVRXU6GNpw0MItOCF0wx5Otl4tIjWtV+FmnxjqKZmvjSrYuKOfIjoSW29xeibIl8qRUmBv+uJjFD9GMn6R69aKIvB2GgqSM+2Aaba3HGJ8HFOXbpaGZn7A5PAGYpcjVmQgTGF3QbUfDYcOW0w9p5yESRcgq6RkK+6Rv+a9SQwmqcbIwD2/EFvJjxrPNJrr/5kD/RtXkC8JcdkYfuZskwxZDf+pqXByCLUsZCoJktaG3Fs2kV/6pD5Oz2n1T2t3E3Brgp/bnK8wsAkezBnlJhhZI9QiaHKXisHmk9weBvKH8m/3jn6O2tGL5tfrPvFWPEenUExywEmAwU5f7y3NMRno5FysIhFGyQl5inmH5X4/IJFYBQYWedAPQssHGfKTB0wvV6WOsS76pNZnOjyw2yBnP4xGlpGxd/Fnp6RLGADzZFW0peFBXlaBtVK90EhZdNIdzV/6QsEpRXoTpOLaeYDhnpr44Dqrj4LG1AUi4OLM6+lJ4QR7ut8rUHpQ7Lzs9VIp8vFwUrV+O0Yq1o1BetWRoTYCsdYQHa6lGnNxjwuGl7clrx3IASODtY5wDTWqZPZw/pnL9dRGvWbEbqV4ZwbhOou7JpmKB7b/yp0no6Hyl3hJUOdAO96oQZg5zwzY04DjjRikOOqPHNgt09GttkobPq4Vq62zYtfgJ8aWl6UqDWCji4GCRMepkaUt0jvbw3H0maSili85T9QdivO86powAK2cNEDCjZ9elrvXnran
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(83380400001)(26005)(6506007)(52116002)(6512007)(1076003)(53546011)(186003)(38100700002)(38350700002)(8936002)(4744005)(44832011)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(3450700001)(2906002)(478600001)(6486002)(6666004)(41300700001)(316002)(54906003)(6916009)(33656002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMJajeL/kVDKrfbXtgf/PYrNkMX3JBggxU6l1nLUJh5aeATW0NryhszWsfsc?=
 =?us-ascii?Q?fGGMcfwOIV5zdy2jPhPQc0m5qJKMYhaOxCBPF+7Vilivjw0o076T9eAjM6b4?=
 =?us-ascii?Q?ysx2WUCnJBVf41fqr1sMPc7yb56q4aN+2uWkAWAKlGCq2Fq57FKauvmnv7g4?=
 =?us-ascii?Q?nWPNsXZOlpqQ0uY/Isp4K3Z07LzLaOvpBWCC31kDSQrB0z4H947BH/kF8Mlf?=
 =?us-ascii?Q?Pk9tvSTyN/34fGdXX0yezpU5gjrkBOwZGQ0frHFVsb1P6Ldhqtq+Vl90xH0r?=
 =?us-ascii?Q?YmvVp7Ym6AVTkv1xUUVmu+fp3nnF45+B892NbsZHhmqlo906DK5HeuAjHAHG?=
 =?us-ascii?Q?zVj54iKj4GzAMe/LjzhFeHzeYvOGALNG4JY1yN/Kmfl/hj09VKlapq5lGM4f?=
 =?us-ascii?Q?vI1Z5VtUuqtvoFHKH/tefLyFJjNtNN9NcD9nknM1/mxm65DYZDcbOstxmNuu?=
 =?us-ascii?Q?to/1SOHr0CSi53QsXAAhIn1cWfpTNDbaKkZBdUSTR67ulT9JVacYliDy3iur?=
 =?us-ascii?Q?7BP1ViP5CNuJuV08D4X7i2gnZn3U14juDWtUSLhBZdhduIHfe209+G+YmyaX?=
 =?us-ascii?Q?zvWDW47w8vraEMeI9wxCGWU8EMLcFX8TYqBTmSSXGJ8OGBXyhO8C0Qz6gvdv?=
 =?us-ascii?Q?uVHzgNvEuQRKIZk2lOqUoEl7yWQoBOjK1fWDC4HuFwOVmKQivOvQFh90W9S9?=
 =?us-ascii?Q?C4TY6anwMieTg5/bx3Aa+HynWAs+BExCreQegBEeF8Qf8ASOw4S9fBGp9WLp?=
 =?us-ascii?Q?CUCPdTHDud33V7cw16ZCnRku4370VzU1Fo/qtT6uT3w6mj1dVicAqPJS52Ri?=
 =?us-ascii?Q?Iq7Jx3r/abp+VpPpiX8Ev2g24bgiX2CZiDBtb3wmyiU0ZD4rpOO4a/NlGg89?=
 =?us-ascii?Q?I8bVM8JqFF06utkgT2AVh+sCT8HAxxOQaMUHqbHg93qWN+Lib7GlGdON/qMG?=
 =?us-ascii?Q?cNuYfjkxlQJCgmWuav4ZR7kfaWmmfe47npHyCwtr968KOotsKtsyLfj0mF92?=
 =?us-ascii?Q?lfO+ex+hU8A6tSYebdCbgqQ2rjIfNYEHA7gxdj5W/QKWI2deMqTC0QSE5UhK?=
 =?us-ascii?Q?Fo1xakfD4IynX79Mz8Oz+vfDC0YiUQYoXUpo6ZPXy/FdeRDhWr0ch0AB07Rm?=
 =?us-ascii?Q?LtqUcaBCF2FTeFy9nM7D/lsTWPm5eQvNek+7W50XcokcMF0jUH82c6DCU955?=
 =?us-ascii?Q?Z9uPRR/FNGHhzBKSrqO5k6XQNN6G1oMXIOEep8M39gWwjwrqAwpFvwbDAV/0?=
 =?us-ascii?Q?cV/qvn5r3NinKObGFkwC2rXvYWW3hkU/mMr4a+UMcaPdJtAOJvXw4z68GZlC?=
 =?us-ascii?Q?kZZ8hcrg+x1sSZ4GhZhYlOxqjn0GMgS8V6G8FX1mPUNjGg3qghNSGzl8v/yU?=
 =?us-ascii?Q?oJDFlfh9ymk0mSqDyVCSPO2IGnTkLeh5zmW9dmHiEcv4JXbm2adQhnxfzprt?=
 =?us-ascii?Q?QF5g3Ko1Sv/O47W5LTFAPPf+duqqNAMNURtDwR162y9JYi9a8W63HeM1n+h3?=
 =?us-ascii?Q?GDgtJkM8KpyT6GbH15XEthiCoC9x/3857CsL/tH+DFSIw3LUHOeCtSpiW1Hz?=
 =?us-ascii?Q?JVJQqRrZBIRA6ZmZFLcEgWJ6kREJE58Gsl971Nscv5wZWbBIAdxZsQa93YuK?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28168cee-0670-4abb-6bca-08da81371d17
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 16:31:33.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUNTd8eYgdHe+RA/Q6HIJqYm14leMnMPSi4+PjFMjgPWWs2Bp+Lp1lmTIp5PiSuh0EFGO+ofwyvAfLAfRlPEA2R+5Xn6pExu20gznP4P05k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB4568
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 06:08:16PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-06-26 08:30:19 [-0400], Joe Korty wrote:
> > Hi Mark,
> > Absent an actual test of your port of a99e09659e6c to 4.9-rt, I just
> > eye-verified that the change it makes to sigqueue_free_current looks
> > correct.  In detail,
> >
> >   matches the same change the Linus patch makes to __sigqueue_free (ie,
> >   to the routine that sigqueue_free_current is a copy of).
> >
> >   That the new variable 'up', in sigqueue_free_current, is being used
> >   in the patch (some variants of this fix do not have 'up'), and that
> >   variable is present in 4.9's version of sigqueue_free_current.
> >
> >   That atomic_dec_and_test, rather than the refcounting version of that
> >   some function, is being used (some versions of this patch are refcounted
> >   instead).
> 
> What is the status here? Is this still needed?

Hi Sebastian,
I just verified that 4.9.319-rt195 has this fix.
Regards,
Joe
