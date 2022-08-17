Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E75968FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbiHQFtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiHQFsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:48:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1F95283D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erX1I/Qt4dUYf771DeY5lxPEe4w9xKZ6cIfTshYEERnndQkjUVp43UiQQl+FloKn8TuP5QYTs5UcLdhgKQxaklqeVwMc621tZi7GZGsAoJommeylURDbIgzy9TgqjHlLmDsTIk6mbCdv9siUVexTty2XwR3hA1aqiGJ757f7ktIRkzDjGeEohahV81XM8JEuMgPvwybjzkr+rAaCxw6azpV0rej8HyK0i46VxLwZmuwLkZlVozmhdLFMLJuLKvv21Pl7w7U1L7WiSRj3El3MwmL9r3BNkRWv3LVG3SLNYL5z2OssPtOiGzeFkX/xXd/GQL+N5Fuvl5ntmPsoCbnhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6R+HhB89XcuPChgRXjvqUN20trqP8MwXyovKPJcjS4=;
 b=TrAAdEGtyTbkXXMcEzSy9XX138iY0zqhuhZosLjGsIGAYOcuSEV+BsG0j94PBqpiCh2QUIWEAH6vKgsezU5HoX9r0PflPusD/xNsuG4O8xJq6LzsPtktzgeWNnBl7skXnbcvzji0vqi6k8nxPlNfCgMPiJon20MxHzvRXdrQ1+YdBCAttsAmmUZJB1wszK20KdOhcPIhHnJ+BcNaBhR3zELIR4KiwFOSQxps4gvJmc7XcMae7Q13NBKrFKszm8iUlV2AZiJeLaLpxwFIPlwqo6mDv9Ar3EmPQNJbtjCHHX2WkMToVsRJLu40OTEYVcGBzqel+vDynJodr+kGY8luJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6R+HhB89XcuPChgRXjvqUN20trqP8MwXyovKPJcjS4=;
 b=ffSqYSPFemWgjrj8Rslnup3tnk1wtGJqdOiOHNispQR59dtlCFIEWDSh2UnDWFp3XN3RwdpWLiEQLIIvYCYlOpv/SV7jREQ2H6pOa3fO8zsLuXya5oB021My80bZHeoBTLc/h7O//UtfC7ZwE0dsWW6ZKuX44oBbfCURK15i694=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BY5PR10MB3860.namprd10.prod.outlook.com
 (2603:10b6:a03:1fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 05:48:48 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee%4]) with mapi id 15.20.5504.027; Wed, 17 Aug 2022
 05:48:47 +0000
Date:   Tue, 16 Aug 2022 22:48:43 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: boot stuck at starting kernel, due to __genpd_dev_pm_attach?
Message-ID: <YvyBO/csrTaNP0P6@euler>
References: <Yvpd2pwUJGp7R+YE@euler>
 <20220815182307.GA4658@duo.ucw.cz>
 <YvrkjH6/FpIzyAv+@euler>
 <CAGETcx_1dDrfrctWMb1rLhZS1Q_hiuQyKBh_1uujE+6S0Fhj2Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_1dDrfrctWMb1rLhZS1Q_hiuQyKBh_1uujE+6S0Fhj2Q@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7047e875-c6f7-49af-2d5a-08da80142774
X-MS-TrafficTypeDiagnostic: BY5PR10MB3860:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rO0ljVTK24lAcDWlnvv+q141+DeDkoMmN3DSYJVT9jZgCxNTW+xWEvNWrDz7JQt0fh1ZtngZ7kw20JEcL0LlF3NlLUxhtc1YfLs8M4F5LuMT3RR0TlwkAVZFdW4JUEduAnYhtSSlz1KDDS1zPnYHMjcAO7KV/A24Sc7QaLnNaoZjOp1MarBnh0Nq85w2uO1oG9dlfR8X5V2jmQALoAKWm8o374f7gVBnFemtX50HCMb2eVgLl+zzPJ8Ec6SIpOXC1Z7Z/NZ8QMK4EbeZZxfkBJBWGmnQ3W/FAtnc37zW8aQBvpmiIbTcyd3hsWV41vpSRskX+xtRi3jp6XJHIbFC1FN07QdD/pQSkzAcm1OlrhlTP0YddEupxp+UX/zqm6D/7HMlMbkGJOmRuPnqjk6RgRhS7W09mHD3ljYXHImgx9HATZsG+Zhfmp3GoNcEXtGbQevfH6gi501YzF4Gbeui1BSZdcHdnxuGw9M86osqGvmzPEMCzFbQBPg2KrFskcq+BaDeqEiNV8Im2WO/EgnEk9ugwXdRJ4tWzRocUlAJ/yPNGld21s5Nww4oo4j++33J0CWjZLDTdnz3lhVLyhDlgc10RaTe3kteM6B3qTBiai1Jp8ghJ/Tz2pdMKw4S8fT9sT3i5zT60SNUgEH3XVi1UPJMxMHIZag457mtsAq88zbof6eSW+u4iMiq85aOOTrKfo4cvJsmY9I98xlY251Rfd8uYL1UqauabiKprynBvz7uJqOTGBMjFkXvG7e7X3213F2Vg5w+Dr7iJHG1WE41qziLfMqrNls/zqANf6NH8KdQC3pP3+WBwHAUCoxv2y7W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(39830400003)(396003)(136003)(2906002)(38100700002)(186003)(6486002)(966005)(41300700001)(478600001)(33716001)(6916009)(54906003)(8676002)(8936002)(5660300002)(44832011)(4326008)(9686003)(6666004)(6506007)(86362001)(6512007)(53546011)(26005)(316002)(66476007)(66556008)(66946007)(83380400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?64W6wGMmHahx5YvL5SLAiWWFYEUC+ZQuMXeA4LbOgcKks5+UIqWLzuWXQ6fh?=
 =?us-ascii?Q?9CQM1P6xndtKY1CtPjO13O2xo+JS3GKzH5mYw2nWWD+L96mYr+uKjakcdeyZ?=
 =?us-ascii?Q?qxD/yqbv4jlPl1b1tBO2ogYNaXF8IOMeh8pSvY/x9/pwaIGbJZ6WATkye0AW?=
 =?us-ascii?Q?cd5Is6gSflNGRUsw+HV2OM8Djy7nfmgBlGSxHmGYG6hxSWbzItZYQi6+idlc?=
 =?us-ascii?Q?iBOLhI2hvGyBBYLABQ0t+/oL7pMFy4sc7yMvw0dfFElXxpu2Psl8LGlCevHD?=
 =?us-ascii?Q?vR8R8zFDfRDT3+evitMHyVjS3whBXAejslxpA20OjqVkFQzTu6p6GszIL0iq?=
 =?us-ascii?Q?yzrwC5/uXtbeVhGWuAsOLWwMjM5Eecef0tAmlonBpZoXY2RWURj6ErVzuXfk?=
 =?us-ascii?Q?4IuCQ//mLkKQx/atso3uLBWtT5eTlTdMEcefP95G5FBPFVmhaD1e8z9tAZN8?=
 =?us-ascii?Q?wSeStDNOm1yVmQzMJhCIkkb2+gX901GlUlAQ7wBjq31dTUOpphCKXMkK+gHO?=
 =?us-ascii?Q?2Evl+Yp5aBcaWDl6QZrtkNcoubQY6DxBbIRWqIDWDSd6Rpo6yfBMT6UeIBPx?=
 =?us-ascii?Q?TMBf0nRB3WKJGQ9D9faaNh+4rucGBvbiIrPOXB40aTe3H1zCJ5D55hFUIqoe?=
 =?us-ascii?Q?qnQpKfH0hvJ2LpYOVQDE7Yvt0IlY7grOZZdy+vP6Lx1ITTF0A/exl9Zy4iHR?=
 =?us-ascii?Q?sGdD4x/kM1LAhpI47K10dX627YlD0xrfi4WVViUrYO+eD6VQzbZVevpjyUNM?=
 =?us-ascii?Q?1UBJvhyjD5k6VBLoBAcjx83+LIvEFm2A888XvPhK8MZQPnL3ND+i4SKE5zPi?=
 =?us-ascii?Q?aHr0jHcuGDWUz36WxbsvT84/Bf8pcoUGfK8sOOnn3dUA4L9DH4ufT7CuycHt?=
 =?us-ascii?Q?TY3bAg5vNXA4LIZG3qNfdg1zdbul/4GMAVntVFijRmWwju2/GLOvN+VrZL/V?=
 =?us-ascii?Q?RkVFs0NQISnuviv2pENzvvrsOqp9ChIOTXdYKyk1wAZnQTEpu6newwgjpi+w?=
 =?us-ascii?Q?UXNCJTzrx+WQmI3lQtxqUMiy6hVgiBVze7bo69IcfOyKmbrnXc8bf6SYClO4?=
 =?us-ascii?Q?DXbvs3Yubvs8qlht1ito/ODkghnl9cBH4hmUREZTqRgswDKMSYD+6eK6UI0L?=
 =?us-ascii?Q?fjtUMivf40IUhIiRexBbWbKbSM0ZWXnHNjUpjefnaJ4k38VQwnn85XLrRs7V?=
 =?us-ascii?Q?4nGIMIO4qUA63fZ93HDJmUuYAXHXO+0znvGVZBYDNxgTmWegUztL7qRIIW/i?=
 =?us-ascii?Q?nWhloecPAdYAH0hW+0QuDJYJrbrVphtRLFwQELAX8eOpddVoGVvum/BUWfEI?=
 =?us-ascii?Q?5o4mWlmuPfcZfeOubeCCzj/V6LCzlEHMJtPOWTP8IVw9o/MZp2bOlqQu9ZeX?=
 =?us-ascii?Q?eKI0VCCMMlHA2+SWAaGQRumFk4a8DLY9N67iiYtXtCAG+c9YxJyNTuWz6lPJ?=
 =?us-ascii?Q?g7/VbUzjOpk3NmOOnF9EKfU3B1+UnW1b7TGsu8FOwa9WkNL8TP5VZkv2o3iE?=
 =?us-ascii?Q?4C5T0wfRKiAjYCyfXIf6g0zUM0Xtf4EKBDy6swfGpesZOdI0cZrg1wM/2HE3?=
 =?us-ascii?Q?7hDyfIc1cZsy6PZnxmkOU3HUqhQfUqoAthhRgvtZwXyNjwKF1qKSzbNmAjet?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7047e875-c6f7-49af-2d5a-08da80142774
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 05:48:47.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHraxSVsyXRiPkog8eExCVl3gvRabSy7gwonhut4I6A67/jAR+yQ8RBU1Bgqc07ObQElUWdmg90Ft0IsChpZVF97rozTp1S30GZKCbwYNHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3860
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:43:19PM -0700, Saravana Kannan wrote:
> On Mon, Aug 15, 2022 at 5:28 PM Colin Foster
> <colin.foster@in-advantage.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 08:23:07PM +0200, Pavel Machek wrote:
> > > Hi!
> > >
> > > > You might have already gotten this report, but I tried running v6.0-rc1
> > > > on my BeagleBone Black and it gets stuck right after "Starting kernel
> > > > ..." from U-Boot.
> > > >
> > > > A bisect pointed me to commit 5a46079a9645 ("PM: domains: Delete usage
> > > > of driver_deferred_probe_check_state()").
> > > >
> > > > I don't have much more detail than that, other than I'm using the
> > > > in-tree am335x-boneblack.dts device tree and I believe I had tested with
> > > > the multi-v7-defconfig for this verification. I'm happy to test anything
> > > > that might offer more information.
> > >
> > > Well, standart next step is reverting 5a46079a9645 on top of v6.0-rc1,
> > > and if it starts working, either you get fix in your inbox, or you ask
> > > Linus to revert :-).
> >
> > I was able to revert 5a46079a9645 and 9cbffc7a5956 and successfully boot
> > v6.0-rc1 on the Beaglebone Black.
> >
> > I still don't know whether the root cause is the patch, or perhaps an
> > invalid boneblack DTS. I'll try and dig to get more info about what
> > might be failing. But I do think anyone using a Beaglebone will have
> > this issue, and I also think I'm not the only using the BBB.
> >
> 
> Hi Colin,
> 
> Thanks for the report. There have been other reports like this. This
> commit in question is probably the cause. I have two series going.
> 
> One [1] is to revert these patches. Probably more suited for 5.19.xxx releases.
> 
> The other [2] is to actually fix the issues you are seeing without
> reverting these patches (long term we do want to keep the patch that's
> causing the issue for you -- not going into the details here). Can you
> give this series[2] a shot and tell me if it fixes the issue? You
> might need to pull in this additional diff on top of [2] (I'll roll it
> into v2 of the series once I get some tests on this)

Hi Saravana,

I can confirm that series [2] fixes the boot issues I was having with
6.0-rc1 on the Beaglebone Black. I did not need to apply the diff you
posted below.

Thanks!

> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2f012e826986..866755d8ad95 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2068,7 +2068,11 @@ static int fw_devlink_create_devlink(struct device *con,
>                 device_links_write_unlock();
>         }
> 
> -       sup_dev = get_dev_from_fwnode(sup_handle);
> +       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> +               sup_dev = fwnode_get_next_parent_dev(sup_handle);
> +       else
> +               sup_dev = get_dev_from_fwnode(sup_handle);
> +
>         if (sup_dev) {
>                 /*
>                  * If it's one of those drivers that don't actually bind to
> 
> Thanks,
> Saravana
> 
> [1] - https://lore.kernel.org/lkml/20220727185012.3255200-1-saravanak@google.com/
> [2] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
