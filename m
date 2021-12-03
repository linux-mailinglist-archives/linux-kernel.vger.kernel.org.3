Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8B46744C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbhLCJzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:55:06 -0500
Received: from mail-bn8nam08on2074.outbound.protection.outlook.com ([40.107.100.74]:3169
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232991AbhLCJzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:55:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB8XO5b/7n+2iwI4gfXv1i7HLtdYYZ+79Ep8BRMDY9caycX8JZMdGYrQjSgT+xjiRKeh/7UNsPo7HkpGuhgqDHlvPpb0eRnCh8S4NOFULPKuPDw3MFWRe9MJ3N9y6fLtzTiRH2ig3Sor0/F8/Pr0lctV8YnkNS6HLl9XL1JIg9YF52O4MdsO2Uv0bRNUreaZODYBWa0cHZD0nEEV502Sst0zBWeNT1oj43IqllpJ5QdIDgJaxiJ/OLUAstECqJOgiHH3eU42mDqGw4EW++c9Ou9d18oUsob5bRxiWNGXnBlySF3hGH/86zOZFXPeZIPfahr0lGHi1Pi4cWt9n03ZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngq88fEvgHVN90dh/UEUdsfELi+vPTCqnxblK+sCnmA=;
 b=YDhnM2Eil0Z6dhLAe2lHOWcN5sh47e1Pm+Z+hxCd04uYxSmQqnoaTRce4keFBjdqq/QBwn+ctFOGRd2XIhF/Mw//gJ4KDwy05yWT0ceWur0uWIznISM1QoUyBcGTWlzH/1ojEPNg79rJLtEfHQsAAEeuZ+J0dk7INbsWdNFULpa3s0njJwhb+cvdwi6yBmRcKGTQSzuukk/O9vfdQLNIaj3emW9IZz8YUjYzjyLwmeHmjTYYlhaYozf9I2224gjUBLWocV6cEkq7TjxamXxVpv1trYynW0CvDM4WMo1AJ2SmdGsMc97uq5HrgoMSghN04mpAd2LDqcu8DLeTqq10uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngq88fEvgHVN90dh/UEUdsfELi+vPTCqnxblK+sCnmA=;
 b=Ijtt0XyJzGDjcahsKLpfeO1Q3JVOa6yvQQh0W3LBt+GpNF4SrKq7czTe17a9GkyVIoaO4cve1kwPFt190mJNprha1QvOOVKzWs5AG4pyeqirYa5UEDVg0oalP1UIWkkVRoSh1VKRecrvmT94j0D1ZFU0jifmTxAlE+QZmSNxIJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 09:51:40 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::1804:427d:b7ae:49e2]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::1804:427d:b7ae:49e2%6]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 09:51:39 +0000
Date:   Fri, 3 Dec 2021 15:21:16 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in
 find_busiest_group
Message-ID: <YanolNkqDdlLN3rs@BLR-5CG11610CF.amd.com>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-2-mgorman@techsingularity.net>
 <CAGsJ_4z30yfw=kyBNZuSLMaCcMBmstD=bK4VOsVW3vKO3kO+fA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4z30yfw=kyBNZuSLMaCcMBmstD=bK4VOsVW3vKO3kO+fA@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
Received: from BLR-5CG11610CF.amd.com (165.204.159.242) by PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:98::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 09:51:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bb8f2f4-dbcc-4816-1f79-08d9b6428039
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4289A1A0806808A1FE9CA3C8966A9@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Wn8GMt32Dvv6LjnmUiD2qYz/eeXNb2gdyDq3XxWd6upBaXJqGiVhnxs0gCv74R+s7sTOdKGeNAg18z5K/5DgzFsWocsV/0WXf6zMlL/AcpwL2V/Rdoq5vQ+dSMfMjbHELOuDvLsDkBsyqlJMZSlebfFac3xf25bRo371sZ7UU6LyxmoLnePmoCXRFcrsih4nlZAYfNvztnmYvD8326iZ6M+A6WuDg0EJdubGKDzKIz+ZHwmV2L7frqObgYj71oUKlUO/k3XMEqLxMo4nUDDdzl0JpeN3YIYXKJeWNV/05Ht9hGwD3iaZK7FfxfOrCNF09vSJQJ6ifzhVHQ7lQdHJ+3QMfnyRDrc4NK/+jwK9k+liL1zPdqCixYu6DJ2jxnN+GPLYtl7dEi1LJKeY7BzZK4Z7pqRnUj9nrhsviHs58/r4o33ZgBdEDBG8BgKXeIYUDCLpErTQClQeUxoHL2RXeX4kNSATNyQVbAZ3Yqw7Oti+f1799vagnvlWlaatEj7K9nYS6uUa36ScKym4sTIweJD3FN3iXfH+sMqzAmuKOxTn++aepNJ2ltE3ZVPeXkPcq5N59jPHA+qU1Bz4zKHxmBnernG3G4O5do7jArqDvTrhYR1l293pZFtXZEGuxCtXadoQ8oBt5STfz8Z0Mc7JgCtVMb35dKPT7ucnoUmPc38hGyfMsrIo8dNrl2qrF8M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(5660300002)(66946007)(7416002)(2906002)(956004)(66476007)(86362001)(6666004)(6916009)(8676002)(186003)(83380400001)(55016003)(4326008)(508600001)(7696005)(26005)(54906003)(38100700002)(53546011)(316002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgXb/AG6Dxr8Nl/1qthzoHYY4l6Qi0/ed+60B6xzr8qMiMfN8WcztNo2sQjv?=
 =?us-ascii?Q?lCTRAL1NA9sYQnPZijnniqhYwkRdNY3BbHV32w9R/Ut1J9Pv6/7fg6IIK3IP?=
 =?us-ascii?Q?/weEBvRWgR1kFcQJUl4nfTd+6MN5v/YL7J1YagzWDV9KqKyzwotBXYMZrxLz?=
 =?us-ascii?Q?k55RwqKxiR36LMfhcvTxUvrNWyFgInXND5IsyCJLfXvU0E2qooQTW1YDNKVk?=
 =?us-ascii?Q?SjUYssIuDmVjkuGrNasiXx/oF7VelzZaWQ2NenI3mmYcd57CV2XMq+i6gbbx?=
 =?us-ascii?Q?Oc/9TcorNADwBmAiHQYCcnP2eEv1POeWTM1i/tQztpOukikoTHMtHPFUtdNS?=
 =?us-ascii?Q?7iA/1ulO8X+vD5c7sfyci7uWNeWy9VtYDr8uVq+Eu+IJKkjxGQVYUrpluLsx?=
 =?us-ascii?Q?CjBqXF2VrPz3PonDpmqITdxYe+cChDgTWBm3mCYs8RAVIuAmZQoKkPk5SDRn?=
 =?us-ascii?Q?/fSs8S0T2w4TO0OXRa3ln/XxdP/jeYTYc4j3a3KdOLuuRgMIlT/UKhXZN2pX?=
 =?us-ascii?Q?W6zTijzoz8Cb9aJ7sdkmbvwfyjM8JI8haOZWwUoEWZIzOH79Imim5kNliyBk?=
 =?us-ascii?Q?1czUzvULZg3qUU/2aP8T+lk8ads7hTN0wP82NuhomrHlbQ5nEi7crXk1ZqtQ?=
 =?us-ascii?Q?QOjSq+uTWkqEKYQCWt707Qlposjzmur9DBIGSGWiKeEhHKJA7cX5yaY4pZoW?=
 =?us-ascii?Q?olAtMI6169YNlbPtq6Rq5cc2w3w9svb6OnNp8wLCLPAdLoYJteXbivrU3x6y?=
 =?us-ascii?Q?iOcw21qGcVpCaYfLq1V9RkSuhHa0eL5DbBPvooRuvx/GGRhRct4bz2lifrA1?=
 =?us-ascii?Q?eAUbnUkFR7/YDqlGHcENJYhtxrHQsYEmJt6eHAkFahbvEeKfITVl5EW+jbSE?=
 =?us-ascii?Q?oURhzjDk3NXomF1aF90ODC9cwqrjJRZ65U4TPM9w6nieHXM3vAXwyI30gR4/?=
 =?us-ascii?Q?2vhwegZ820BiKD4fvrQeW5hLnzGFYM+uwW6HPhmpjvwY1xb8mxwrhKSpzBMl?=
 =?us-ascii?Q?OQNGf79wVzsJq3Wil9Qai/sOCsjMq/hWchJBMzGR3+TRa0HStz5ZNLf3uULS?=
 =?us-ascii?Q?So5yAS1Y40RyCDjBZ9ATl7t+nJLZN/RaPyISYoL6IigtJs3bjw9xJPncDVKE?=
 =?us-ascii?Q?2Pl3Cos0WvJPuCQ2gZn5IO8Wmr/8s+FwxdUw8o4h/GTyVbqoNZwwGrfzoJik?=
 =?us-ascii?Q?Tqw8nJrGel7Nwa0lyOEKax54IXI3gl5s/nxE2uixmNg4DkZ22KXFuu9Fe56Y?=
 =?us-ascii?Q?n26jxWv09NVNf+KWPnYeDJEF+/DIUQBBBCl4aIt6h2GW003BJ/92vug+2B3w?=
 =?us-ascii?Q?c5bJSnyRrZj79eKveyo1A8OHVBxzAJYZqHGlC1bcr4VovPwVB+Y5UCiuuumS?=
 =?us-ascii?Q?ivTC/Eh5j0WcmDWGusDs1GVDCyHxJNLE5Jtylpd9GcZpW26VSaQH25uKtowo?=
 =?us-ascii?Q?WiMQjSo8tuCgzyb5g3HN6xvzSFgmM1Z28gn+lHWn/T/BA9XW/JoJVR1Dgmrr?=
 =?us-ascii?Q?fSZ+EyYbqXPj1BPl/yXmCb6Hz9dl+EZFR3qw+wukM677CLF+3/zK9amcZ5uF?=
 =?us-ascii?Q?fvKxkC/QYIk17XEgtO/reUMQkMiFJ6tKro7pv+3OWZmJV3jjsuGrJs5j7mC1?=
 =?us-ascii?Q?S/w8AMwxIyfQuOuEyUeueAw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb8f2f4-dbcc-4816-1f79-08d9b6428039
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 09:51:39.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFmymz1i8IwJiESv23tweGUeRUqIeh/zQbhUEKyCt1F//ovHPkaG5Vzcqd5LgRJvCL5MNVPkGZ7pe4bev2qjYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Barry,

On Fri, Dec 03, 2021 at 09:38:33PM +1300, Barry Song wrote:
> On Fri, Dec 3, 2021 at 8:27 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > find_busiest_group uses the child domain's group weight instead of
> > the sched_domain's weight that has SD_NUMA set when calculating the
> > allowed imbalance between NUMA nodes. This is wrong and inconsistent
> > with find_idlest_group.
> >
> > This patch uses the SD_NUMA weight in both.
> >
> > Fixes: c4e8f691d926 ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCS")

> 
> Hi Mel,
> 
> sorry I might be missing something. but I have failed to figure out
> where this commit is.


I think it is supposed to be

Fixes: 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")
since it was the commit which introduced the "busiest->group_weight" change. 

> 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6e476f6d9435..0a969affca76 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9397,7 +9397,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >                 /* Consider allowing a small imbalance between NUMA groups */
> >                 if (env->sd->flags & SD_NUMA) {
> >                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> > -                               busiest->sum_nr_running, busiest->group_weight);
> > +                               busiest->sum_nr_running, env->sd->span_weight);



> >                 }
> >
> >                 return;
> > --
> > 2.31.1
> >
> 
> Thanks
> Barry

--
Thanks and Regards
gautham.
