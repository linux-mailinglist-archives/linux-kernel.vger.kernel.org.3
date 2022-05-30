Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300E2537AED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiE3M7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiE3M7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:59:15 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925256BFDE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653915551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiz7aVDcNY2C5DaoVVQ1O/WIClOVO3VkR8vm50Iz4JM=;
        b=COoj4gNxDwgLM/qDKrMQFbdKjxKCbZWOM1z2GQxdckjU5bwbYsSvN66KDh3tr9gHfdxlL1
        qGI4iJY/aP7es4VNMvggVJqbN4DvPWWtxX2USAXGOZI37/B9h2uikvNQaqQIW4IxzP/2sg
        oRUw9MKnSlIHQCD13WAclJBzgtlY5o4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-uImZabybM8egCv8vfSSOqw-1; Mon, 30 May 2022 14:59:10 +0200
X-MC-Unique: uImZabybM8egCv8vfSSOqw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfuRuzIpBW95t4EyPZLX8lO9Z/JlO1p4Q3HOFUGijv6N9uiWwmUz7S4tO5ClPTXwWeMmC9bH0W/2J4FspC1MlDlyNcJymaaEoDESxqnlmzXW8lQm0GZ3JlYk9fE6lgr/j1qBWJgSZjlk/mjyZ4tcjjNTlhAT5uFSZdgCO8Fmb6wyXI8zJ3GLFN+AkgomzDnC3XnLWaRmLWpnEQ6vZd9MCZbJvfl2xMiIZxlseu2bU3AGOu4d9+19HY2xD9TK9IA17bO1Khwn9La1M7zP89tJ2YVpRU/4zZ917pl2DHanrEV7k/L9xnzEe4uqEBKALugoetxLABVQD/AN9J7xzF4mSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiz7aVDcNY2C5DaoVVQ1O/WIClOVO3VkR8vm50Iz4JM=;
 b=cVwPb3acb15jsuEDC53r0TqxbX8RZpmGPgOkz2gDvboG18BLpLcjoVtgTvg2GB8qGLMlXfednLLvXtQndACAMuMSGb6Fm25vNVV2nfArPPHRF5Qp6x1lQ9GQcg2lwzztpeyjDY/vEM0Gn4kDoCRXXcGHVG45yPdRjyYscdUBd+ysk1u4SkxG47SiqXavVCIQMUm2+1nQ1WAoYK5keSDNR696AUj7J9wBX909lmvPXA0AW/u47zc5NczMN6qJnd8y7DJdpdshS6drCd2aVIcKrDT1FV2Y50K7LPuUbXzKxFzSs2PeQt8KLQglBP1Qd7ZDt4LnyegLX4NNTbWO6SwFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM6PR04MB5318.eurprd04.prod.outlook.com (2603:10a6:20b:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 12:59:08 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b51c:9a69:6f99:65c]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b51c:9a69:6f99:65c%4]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 12:59:08 +0000
Date:   Mon, 30 May 2022 20:58:54 +0800
From:   Chester Lin <clin@suse.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [GIT PULL] arm64: s32g changes for v5.19
Message-ID: <YpS/jhQf6zLXZSvy@linux-8mug>
References: <YpRiZpZU3kH2xprC@linux-8mug>
 <CAK8P3a2A_KHKWN3O2Wcy66yCC+T0eBsK8pNcGuLHN-BVeQ1ymw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2A_KHKWN3O2Wcy66yCC+T0eBsK8pNcGuLHN-BVeQ1ymw@mail.gmail.com>
X-ClientProxiedBy: AM6PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::32) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b83ae41-77a9-45ce-f717-08da423c2ee0
X-MS-TrafficTypeDiagnostic: AM6PR04MB5318:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5318A680BF5B73D7311BBFE4ADDD9@AM6PR04MB5318.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pIc9v2XhAWyzN2oDIwoGSh2HrBWOZPBjmZH9OY1WDywAucsPxNPpsDYrfhzsleI/2BHvDdx8DMhx9cMKIM3HTv0hMclyh/UHaufKF3PNOA6umtKlBQCWbk+4W1eBqFdApc3x9LhMNKfiB46qK0CLyYpX21EOek8YTI30Esyo6U3FzFL5ltZLR7w6WEr5mXkQnE4vRu4TTqbZiQBK3lZxbrV3kdA5ZYzyGBLI+17Naruee7FjfW880Elaj8XbzRwtgKs4STfJIrDM/LvphFGjfCmE/MRVTSVUlNMzkB5QY91RBTfzro3WQFVsQemQ1H9Z3RAbAZgqTiy74Z1oTAp0PdK0b3QC+3NNw3a8MyTLyQiFj31kA3u8M1to/WlVMj0Tmd5XT/K7s0/d4OVCL722aQrTzVWZounVSgojb6lzxVtzYjmJe5AjrXi148O5Oez6lrdNYA6zYMXULJqMOaH4ij+0rOaKSwpA5LIqjhZsogrtcKlA85oVpHB+iqd8/40nrJ+lpZciBogVDqbremscFlzdTJkv4ToFd0If3ZtqN8/uLFxnYGLwxvHF49fL7KMvTjfHQ2AZZIRFLpnQbM6Ra2V4DVrB0tkCHiwaIF8CbsKx+OKeXeTj34z/RpAKI4vywHrgNcjhOldowrl5oiSDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(8936002)(6916009)(54906003)(186003)(8676002)(66556008)(66476007)(6666004)(86362001)(4326008)(66946007)(26005)(9686003)(6506007)(6512007)(53546011)(38100700002)(6486002)(508600001)(2906002)(83380400001)(33716001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HvAr1QHKpPtf4Izjgd08dARVDhpB/JnpJICpA5tOdPAy2DBSP5L73pK6Leov?=
 =?us-ascii?Q?AFPhYDFxC4HUbF93alhNVu33cBz44gy7ncxd6xfdksfg5b6CjgWnt/aInBpk?=
 =?us-ascii?Q?0jLGnAq9Vefrf+GnLSWtWCTJin3um7PKSJv6bY1JI0RGzCl1aSQYtfYQVKXx?=
 =?us-ascii?Q?GCOSK5Rm1zZ5vSqwVJBYt2bQ+nzUKhEzmeTvMgM25/wNqsx/4yYRbI14Lo/B?=
 =?us-ascii?Q?7GUOrQ1XRQfUMQU8kRC6LLlyKZRLLEIjbugf4fDzWjDHc6A5vEsy0SG9XzSc?=
 =?us-ascii?Q?kQpVxd6RhgQWdC8+khclsFUerm3IGpexcftcz7D7GbLIs2Fdv9fzobfEV7L9?=
 =?us-ascii?Q?YzdyBFTLO2KqzztSLAWCd+cyfHeOTT9KpVAu72f7vHU9IxF1thovmdEA2WgN?=
 =?us-ascii?Q?foLC2qre7zUratamlNG6EDP277tKU8qpK6CMhg8qneM/fYADdlnUn9GHP/vA?=
 =?us-ascii?Q?JreZHXf2hvNM8akON1tUn5FI+PPngxBgattl2mXQTeOSKC3OCgEANGnysaur?=
 =?us-ascii?Q?w5bZD1u4xrXZz+SW3oZ9Cz99qiRG39OyreFXKHK0ss1MzsWAYSAfbQdBpFKu?=
 =?us-ascii?Q?+5fJm1xRfInEaP1eAbxeMvIEThGs7HK8YGB8lLwj8aX/s9RbUU6RUqIx+Fi3?=
 =?us-ascii?Q?yJ0cZ4RxL7En7gB7LX6kNnCwPv/7YWXsY6HRNr4X2mPk1pAD12ufT5YTsCVR?=
 =?us-ascii?Q?msmUWnTEKVoAux8JDy0+g29GiVHP+d4wbnBgjAwYrmsw7AjHSWrvDL1015ez?=
 =?us-ascii?Q?qWkqtCqvi10fJNoB5SRppQTmpzwnRs+T1uCsmh+Y+EzCY4fHOklTuVYuLIFd?=
 =?us-ascii?Q?eKGizHGs3CstYrwMHvGxJ2CNH2EMlo7bj75+/0M+hLJsCf2KgMJwi2iOfFvi?=
 =?us-ascii?Q?ITA4MH2Q51Ns6wm7BKODRny5gIlty7VnFkjT0p3t1yI7fTljlQljSJ3ktCvY?=
 =?us-ascii?Q?o07ZPeCrkf7KT5xqHt5+T9XdLJAx/okbmYhxoRPXw0WvvWFD4gJzZSbg7cel?=
 =?us-ascii?Q?VY81YkqPQWrnE2bJXweIA6QpPVkKeeW5CFruwTPApEyhb1vyKMltHFIxBPxR?=
 =?us-ascii?Q?ruUZl5VGGw0n7EYvXGeecLTUnUV9SGSgLpNUCsx2PxNA7MMAVooLSdnTPeqU?=
 =?us-ascii?Q?+cuF+PQ25r1nONXGz76B0xsCkvQq2GjT/VN61BKyUDfZPVRQ89WcPjOE941w?=
 =?us-ascii?Q?Meknnr09M0tJrcpokdK23AbYfDchbvnXVen6gJxGJph/QCvpuMyNQESKSxPL?=
 =?us-ascii?Q?s1Eu6mzVxTZo/X8FdgBtD2KyY+aCE8k+ekqG+oKiyGMWMMCbiFrfJKGuZ4lP?=
 =?us-ascii?Q?Xjjw74gD4KVTAF4I1e9yKFPZlb5vqiu3gK4E/KHolPdcDkXXagS+6iv8/MaM?=
 =?us-ascii?Q?/xZe5ZQfwU9eHC2vr6WD6nCQX77EP4XSuNXeK0NI6/24eD5BQkMXHfi55L5x?=
 =?us-ascii?Q?hbNRxL0TwIat/d2kQ0QS4GvWq0EHbWn4YveHuQjXBDCOJYMl9NViGJMIeO41?=
 =?us-ascii?Q?c4oHP52tUVZ0Ww/4x7hu2soRu8ip/F4qnkkfR0QVb+3BHZx4QInU7Q6D3xB4?=
 =?us-ascii?Q?MbuDIPSvcOfWBEqn8db+jeUfTz+EsnetCTf11R9y9hRnKzkt47pZJWZdtXlw?=
 =?us-ascii?Q?OSYsez2V7eEBeOSRZ9xrRY8HGyNsh0aNNA79uzb5wFft57GSCmKvXAHUbgyR?=
 =?us-ascii?Q?dJjzLnuWXA5IVt8PnAkeIvJtzLwR7o6Tte8R1oiI/EQrGKWJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b83ae41-77a9-45ce-f717-08da423c2ee0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 12:59:08.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/nzgHjh2LDOTdCU6epHtVcmSySRHAtxf/zNxB0F/zTOKNSSQYVmJZpVjBG35QB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5318
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Arnd,

 On Mon, May 30, 2022 at 08:58:47AM +0200, Arnd Bergmann wrote:
> On Mon, May 30, 2022 at 8:21 AM Chester Lin <clin@suse.com> wrote:
> >
> > ----------------------------------------------------------------
> > s32g changes for v5.19
> >
> > ----------------------------------------------------------------
> > Chester Lin (1):
> >       MAINTAINERS: add a new reviewer for S32G
> >
> > Fabio Estevam (1):
> >       Pass unit name to soc node to fix the following W=1 build warning:
> 
> The patches look fine, but there are a few minor problems with the
> submission:
> 
> - The branch is based on top of a random commit from the mainline repository,
>   you should instead always base this on top of an -rc tag in order to not
>   clutter up the git history or make bisection unnecessarily hard. My 'arm/late'
>   branch is currently based on a random commit 16477cdfefdb ("Merge tag
>   'asm-generic-5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic")
>   as well, but this is an exception and I will explain it when I send the pull
>   request ;-)
> 

Thanks for your guidance and sorry for any inconvenience this causes. I will
wait for the next cycle.

> - The tag description is only a single line, there should be at least some
>   content in here. Please have a look at other merge commits to see what
>   you can put in here. For a small number of independent patches like

Sure, I will describe more information.

>   these two, you can also just forward them to soc@kernel.org as
>   individual emails without a tag.
> 
> - The subject lines of the individual emails should have the right namespace
>   listed in them, e.g. 'arm64: s32g: ...'.  Fabio's patch originally had
>   this, but it looks like the entire subject line got lost.
>

Sorry for the missing subject line. Will fix it.

> - The subject for the pull request indicates that this is meant as your normal
>   submission, but this is the wrong time for that, because the merge window
>   is currently open. At this point, only bugfixes get merged, but I do classify
>   MAINTAINERS changes as bugfixes, so this is actually ok, just change the
>   subject.
> 

Thanks for the reminder.

> Please address these and resend.
> 
>          Arnd
> 

