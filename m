Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3FC58EF16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiHJPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiHJPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:13:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4007696D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:13:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cr9so8137554qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+MoVzT70dgl0mrZk7FCfrLX/L2nz+J+RAFiYQSmi77Q=;
        b=ut7ty8IYr6nvoF8DmomdY0c0ZKH/1E4b9vQjdJzgG01Jur4RD2IQhKjY73UHj/JDQ0
         tSK7nFjF0qMpQlLbA52iprHneX586PS0ogRCLECHukFt64gEy9kfgB2AoJo8a2qrgvwX
         zNuwQAv3+R66dSDFDvgwej7mz2J9jYWRY55aMmzmnGxSILdVqBYNpPUzK0Q0CXYIVkFA
         gfZQwgmCvw3L0NuAs1Cyp1DU+0Ffi9F5Cr+4BPg8/BlpPhOcr0QMPzcnPKl6epveecLF
         AOy2DRuHHzpUZQdikwoPt4nDTfkzAnAlSDzaXgIT+VTPkJn/GNrHEEJhioGVn7rd9D6J
         15Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+MoVzT70dgl0mrZk7FCfrLX/L2nz+J+RAFiYQSmi77Q=;
        b=oti9rx1xbJAgkh9x9Qc9Db9odbMPGLBs7OmUzOhfABAFnNg30puWFmXogj71KS5mYm
         rqEHXqs92/QFXVa7uiokDqyFrSjUtSMlsgDktZRlIeZiCoPow0sPzWubWgFxUN/e1yU4
         jVbyzlV0S13VtvuWoFB2BHHNXOypCzZX2ymvNAs6x54x+Kdd7tCBBsg7wJI7l6knGktb
         1tsZVBMxC94zsbMGLvwvMjUf13CLcL9D5CfP8PwILTE1dXbocfNn4wAgrUm5oKlAWL3G
         zs6527NvlvYM1sKKftt3lRvi4t+/ULG3iD8ano3rWEhIBwP2lFpj6m9KKb9OA1YvChPm
         TYQA==
X-Gm-Message-State: ACgBeo1XcWZYBbhf+bM4BAf9W0JLshQHQDMIQ0fr9BCWxnxHBOEUcL6o
        2xDekNx8+yfbDwHloDQxfI9Ddw==
X-Google-Smtp-Source: AA6agR7vY4GYQ0CbLjTAsDH/FBPEK+GeSb0SHUsoDFZFYUGTRwKonj1tgkgiaePEC2EAmSfzYjYCEw==
X-Received: by 2002:ac8:59d3:0:b0:31e:ff86:f344 with SMTP id f19-20020ac859d3000000b0031eff86f344mr24108168qtf.199.1660144437339;
        Wed, 10 Aug 2022 08:13:57 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a0c4e00b006b6757a11fcsm13521998qki.36.2022.08.10.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:13:57 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:13:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sched/psi: psi bug fixes and cleanups
Message-ID: <YvPLNNlIyjLXv71v@cmpxchg.org>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
 <YvKbUbFCaf6WcF26@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvKbUbFCaf6WcF26@slm.duckdns.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 07:37:21AM -1000, Tejun Heo wrote:
> (cc'ing Johannes)
> 
> On Sat, Aug 06, 2022 at 08:05:07PM +0800, Hao Jia wrote:
> > These three patches are about PSI.
> > patch 1: Fixed PSI statistics error caused by unzeroed memory
> > in struct psi_group.
> > patch 2 and patch 3 are to clean up some unused functions
> > and parameters.
> > 
> > Hao Jia (3):
> >   sched/psi: Zero the memory of struct psi_group
> >   sched/psi: Remove unused parameter nbytes of psi_trigger_create()
> >   sched/psi: Remove redundant cgroup_psi() when !CONFIG_CGROUPS
> > 
> >  include/linux/cgroup.h |  5 -----
> >  include/linux/psi.h    |  2 +-
> >  kernel/cgroup/cgroup.c |  2 +-
> >  kernel/sched/psi.c     | 10 +++-------
> >  4 files changed, 5 insertions(+), 14 deletions(-)
> 
> Johannes, care to review these patches?

They look good to me.

Thanks!

