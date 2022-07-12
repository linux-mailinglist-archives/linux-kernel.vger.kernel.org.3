Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36D572082
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiGLQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiGLQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:13:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BEC8E85;
        Tue, 12 Jul 2022 09:13:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s21so8099085pjq.4;
        Tue, 12 Jul 2022 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IWdjtLNEB42yFFgH3P6p6IrvyJR66vGWHiS+uWXYhV4=;
        b=a9xMw4G8kjdnc/eyhcGadH+U0mYG9UveaTHdR8mrzpa5f+yJtLZLGpSJcchxHD4DD6
         r8UYER3z1T/xw6tH3y9nDLEsVHeu/1R1Y9zN4oXL9bjyek89KDiQ5wtZ7xwG9QS4DvEM
         TGWgCNtpgz5yidWpMSjG0akO5Use32n+nupl96TTK4fODdKAJH9kqG8tQsj7gQ93b0SC
         dJxsgWMwaGfI9CpAovd1ahFDNLTHhE5WoLevK7mqqGgSIA89nK3StJFGO58cL215AMU8
         4YFjAw1rfsteaYvu8FBuTVxUJTuL0fIV6Xfg6kxkOPHEVlOivTmXjQGDe8ztxHeyo9mc
         8ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IWdjtLNEB42yFFgH3P6p6IrvyJR66vGWHiS+uWXYhV4=;
        b=veLOWsLxx1ltlCq9MQmIRqzutLUnGIGx1WGvp1cOvg0qgA+pEM4IF/WQBoWtykt483
         5humUiE3ulkaQFOWKI1M+dstXm0ykESlxQ6qEcqYSbbHfEENxGH8FuA6N69VmfZJQlU+
         iwBdhZIkLe9pJ+hLAeFeG4BTDxi8iJ8iUxMWtMtGFoctLiRgX+pj8/nOh/jMuZLe1126
         Xdu2SgFrr88a7YxkxcYAuS7GN7Zbsg8wvm7LLNoBcGQdDLTNbNnx5GoCZzKvf0PUuVbj
         IhuloOliYv4UIivYJHMGgkQ1BeLca4v8NnLbkCEPw1bKnfluVHwrxMjKbfzy4YCVu4GN
         jsJw==
X-Gm-Message-State: AJIora+ZVRq5udjKoxhi4hBuZYwNOh2epfFJZP2Lv4VEQ4AjyBzhkwfd
        IJ0x/LTUta3Xf5DYjtfPDRc=
X-Google-Smtp-Source: AGRyM1ssXqyunm6PYL+kHJEnUtJ2uitfhXA1ZdEVZJhGUXwroPFpJPMSOq4Rwo9yOzTA+9ZCC8SWeQ==
X-Received: by 2002:a17:90b:224b:b0:1ef:e06a:32f1 with SMTP id hk11-20020a17090b224b00b001efe06a32f1mr5287353pjb.197.1657642429179;
        Tue, 12 Jul 2022 09:13:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b0015e8d4eb1d3sm7121424plh.29.2022.07.12.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:13:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Jul 2022 06:13:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <Ys2duuPDNq/q+oOz@slm.duckdns.org>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <20220712125702.yg4eqbaakvj56k6m@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712125702.yg4eqbaakvj56k6m@wubuntu>
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

On Tue, Jul 12, 2022 at 01:57:02PM +0100, Qais Yousef wrote:
> Is there a lot of subsystems beside cpuset that needs the cpus_read_lock()?
> A quick grep tells me it's the only one.
> 
> Can't we instead use cpus_read_trylock() in cpuset_can_attach() so that we
> either hold the lock successfully then before we go ahead and call
> cpuset_attach(), or bail out and cancel the whole attach operation which should
> unlock the threadgroup_rwsem() lock?

But now we're failing user-initiated operations randomly. I have a hard time
seeing that as an acceptable solution. The only thing we can do, I think, is
establishing a locking order between the two locks by either nesting
threadgroup_rwsem under cpus_read_lock or disallowing thread creation during
hotplug operations.

Thanks.

-- 
tejun
