Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1B58DD50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbiHIRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245288AbiHIRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:37:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E025C6D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:37:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g12so11422860pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=5bFOkJ69YAC/GqFcEKxJDVBhDvuBSyFSECWA/fYiV5E=;
        b=kOekSwfrewHBOeVCp8GRiX2Pn51rqkQeSXiw2HGoIZ/3DmzqZzwYQ3R8++Xc0O+ToQ
         +03pYo8FxZsNeoQfN07ffWCc0r/t9aEgTHoMaCQIxEYtH36VkJaf3HQjTL13CKpTxmTG
         lZTEXqd24XBiduP2EueilBeWpL4EZILN4Jux22qV6dK6S8uth1nTDBLUnVqxbjceMLSS
         36WRMbWAUL3ap8Jvf43YEWiG8Yrhm7KnCI5HufkIqsnKJcq4p+SR5S0wgvb+EtczVMe5
         m8MbKnVPDli9YbHhFuNGWMceqa0JCJSeMsfkw+i8dWLAr2DUnTTfwd5rHcwrt3OuaxR/
         ShIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=5bFOkJ69YAC/GqFcEKxJDVBhDvuBSyFSECWA/fYiV5E=;
        b=m69/NGOEp/7RxvQVrp19GB/8DGEhDSAg9A53BJKZiIQQ9lh6+50ziaCkD6IdBjnVdi
         uFAqT7g5umGGM2fgR9dzPdvVOgmv/rIJWHkA1HKYbgMdrwo9CopWrsSN3d2MYGCoTbaP
         H/aJvgWVe39H5LLAT9s5vw3AA6kkJaD5sv9F27WG+KdwNmDVwMohVnNHWztpSIBZHsip
         pIBVW/stzeYVLDXeaLHNeFzSuoTN6J7q2ND7C2Z/uf3aO/Zhx9sAuoAwc7M6KpdGIjtc
         K4lqeOeOLRK5683CbjmWx6qeSFNgnzyPHYy6lziZXsufkTAZq8AlURxpZCK6iNJXUAKJ
         NV9Q==
X-Gm-Message-State: ACgBeo3jpnNI/I0+NE3OplLvBrr8eQeAwxywOkgDVOV5OdODfXsatNbu
        dXA7Mb54Bd3ykGWsIEWdof4S/LNnIL8=
X-Google-Smtp-Source: AA6agR4NUYX2aQ8FAAtvQELOa2HGXWfbiBfZc148GW8QjRarLE+ntGPz2QbrI8nldzuv0lHhMXtkhQ==
X-Received: by 2002:a05:6a00:32cb:b0:52e:2756:3558 with SMTP id cl11-20020a056a0032cb00b0052e27563558mr23972500pfb.59.1660066643129;
        Tue, 09 Aug 2022 10:37:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t21-20020aa79475000000b0052a198c2046sm148756pfq.203.2022.08.09.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:37:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 Aug 2022 07:37:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/3] sched/psi: psi bug fixes and cleanups
Message-ID: <YvKbUbFCaf6WcF26@slm.duckdns.org>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806120510.96131-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Johannes)

On Sat, Aug 06, 2022 at 08:05:07PM +0800, Hao Jia wrote:
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

Johannes, care to review these patches?

Thanks.

-- 
tejun
