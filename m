Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FFA58B7F5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiHFTig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHFTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:38:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA54FDE9
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:38:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so7064920edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gV67gzcQ5ee3YbaYZ2h8EvvzQ+8xDDRY33CCL2OFP80=;
        b=CndunnyFSCTPMhPhbjb8lq2Mb8bHRJIa/8sr9CaEcclSrxxJRlupB1oXmtwp7CtLs/
         EKI7ovhUE5iD5TOnaNDJVc90ENvXgRFWQecc9hwRiJhJYaO+MN6QK14B4kF48Msqcm1C
         Vu572/vVqJgBULhMcTV3qzWmpYNL5LEbaYWBiNNxacP/hVVDwFEcPIRiHVUUmCSANC58
         8Oum4ONGyE0mLaegHNfk7ZvygGUNdgcDQ/o8xF3JW1oCu08HxTkzGFmYhYM4Dbpw30Ee
         DI2Ne4nZMmcFO/PPfZUwe59xapqadmwP8CJyed3OdLBc3Y/xsvfRxYydI8B/+gae7O+f
         xz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gV67gzcQ5ee3YbaYZ2h8EvvzQ+8xDDRY33CCL2OFP80=;
        b=u2HKKdJDkxW0rWRuHBv/xxw9xsP7bJGSc6kJWtezi4Q2E+cnhsMbXvasnHA+nrpxkS
         cMUz7B9Q4RrZtu9v94z3P17sGI9QgQ3w0Z4S8uTACIoL0KE7YENlf0C/A3eQCdQqp114
         J2+LIyxWAyEszcXxrn8riClBi8dQ2MRuBR0SjHm2zRW7Cxwk9cv7egJwrZCCAWb+FVbD
         mHJ0jyROxJ0+pKyyEc+6aKcPMrT1Kl5PYnh06/RdZiH6Ou+p8wGs2TIpqUskoKJ2DY25
         Tv9bsgySMNU/fOw7ooNLvRb+CcjIY3mJPfKSu+8Gy+Hs0t5EwA6IcAYCmMhN43aavQUS
         y0Hg==
X-Gm-Message-State: ACgBeo0iegtHmSvh1i+Xcuukwt057vvVsNH3o4sE7eBZ0PkPfJ2tiWc2
        cRr7dA4R1ec4CbKV09fkUXM=
X-Google-Smtp-Source: AA6agR68n0MV4jwEuCcuYw80FZ7aJ07NgIYGaiRZyTtKT2h6IWQKUjE56wt6isrFZrlH6hPMkObJiA==
X-Received: by 2002:a05:6402:35d6:b0:43d:c3b0:1206 with SMTP id z22-20020a05640235d600b0043dc3b01206mr11801990edc.415.1659814712437;
        Sat, 06 Aug 2022 12:38:32 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b004404e290e7esm1902094edu.77.2022.08.06.12.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 12:38:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 21:38:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sched/psi: psi bug fixes and cleanups
Message-ID: <Yu7DNaeknjO9g9m9@gmail.com>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806120510.96131-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hao Jia <jiahao.os@bytedance.com> wrote:

> These three patches are about PSI.
> patch 1: Fixed PSI statistics error caused by unzeroed memory
> in struct psi_group.
> patch 2 and patch 3 are to clean up some unused functions
> and parameters.
> 
> Hao Jia (3):
>   sched/psi: Zero the memory of struct psi_group
>   sched/psi: Remove unused parameter nbytes of psi_trigger_create()
>   sched/psi: Remove redundant cgroup_psi() when !CONFIG_CGROUPS
> 
>  include/linux/cgroup.h |  5 -----
>  include/linux/psi.h    |  2 +-
>  kernel/cgroup/cgroup.c |  2 +-
>  kernel/sched/psi.c     | 10 +++-------
>  4 files changed, 5 insertions(+), 14 deletions(-)

LGTM, and I suspect the scheduler fix wants to go upstream via the tree 
that introduced the bug, the cgroup tree?

For the series:

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
