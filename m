Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563AB5AE6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiIFLk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIFLk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:40:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1E32EFA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:40:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v4so10358771pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=zLIlU5WRN/qpc/luGxAkx8MLhJShGTdf13t85Wt12A0=;
        b=efebxuxDyVJ+HBbIqVJTWYN02z371rCOW39ThMtiUrXxkRMJo5y/R4IW1BYsezfxSS
         dbLo3aDSWkZ3buIgH+W3V5FWYp2pLQrP84A9O/3bqK0cBaJgprHqFt4M9rSCiuYnc8y3
         HV4TEsnNjdQfhpOS5WDRHL8LjiNUJ+fb35F1iaP7DKi0iFru3xhCW1MrbGap/jeziMOC
         Q27Zn4X0fkLEZZcDsKhGzrPqWiGm83H1t04PrrvGeXZi+sHtRhUPR/RCFyCav6oPRloM
         +NWdQcmIzaUzI+ZuE7qcgXc6Pb6rS5Q8luniNlANvY84IC0P3XQjO7WTnqLBUdyUtIlJ
         VUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zLIlU5WRN/qpc/luGxAkx8MLhJShGTdf13t85Wt12A0=;
        b=eNrsWQHz47mjqgqPrHpuTUVc5l2jtNCmA6/yWQhpUxUfMak8+W0LKlUczk4s1KB6Fy
         Faq+Wt/nCKYQKMfak12J3qpff8+qE+Be9RhD0wZNq84S4Yv+Yx62DHQFj1N7ipNXJZTm
         KXGrqZfiD7PYVYOhL2OA7HCmm1zKUetN6vdMlREXfpthiwTUQLOtL+OR2w5OEx9Fpqoy
         R+UhiodlVwSyIMZ66kbMGTPXY/QJ5pX3CFnJpJdZ7GGxqq0GnlvCuWU162ozCU/RGn3P
         JSbpypYH9lZhiOEyyqUkXYWVeAsLBt2Vok7+CuzwVzANU64kpEHJ+KjkvyGuJLkI4vj5
         g5Ew==
X-Gm-Message-State: ACgBeo1h5p9oPoXkikAydEeP0QGRmGzOtlO9udo5Xl79twVDIgUQRY8K
        Xq2KzmujRDxsxmo0i8TeUK0=
X-Google-Smtp-Source: AA6agR7+UBOMZ/AkV+sOu5uGrhLmnFa2ga5eqFjqkr6N/KL6vXSIVV7mrEpM7cGsezMaGjvvdFNcCQ==
X-Received: by 2002:a63:1624:0:b0:430:c45:eb7d with SMTP id w36-20020a631624000000b004300c45eb7dmr27857067pgl.42.1662464454999;
        Tue, 06 Sep 2022 04:40:54 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 6-20020a620606000000b0053e3a6f7da4sm1197954pfg.12.2022.09.06.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 04:40:53 -0700 (PDT)
Message-ID: <631731c5.620a0220.8387b.1974@mx.google.com>
X-Google-Original-Message-ID: <20220906114051.GA337755@cgel.zte@gmail.com>
Date:   Tue, 6 Sep 2022 11:40:51 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, tj@kernel.org, axboe@kernel.dk,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgel <cgel@zte.com.cn>
Subject: Re: [RFC PATCH 1/2] psi: introduce memory.pressure.stat
References: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
 <Yup+W/EFzkfSqRnW@cmpxchg.org>
 <20220817025945.GA84631@cgel.zte@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817025945.GA84631@cgel.zte@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:59:48AM +0000, CGEL wrote:
> On Wed, Aug 03, 2022 at 09:55:39AM -0400, Johannes Weiner wrote:
> > On Mon, Aug 01, 2022 at 12:42:04AM +0000, cgel.zte@gmail.com wrote:
> > 
> > This doubles the psi cache footprint on every context switch, wakeup,
> > sleep, etc. in the scheduler. You're also adding more branches to
> > those same paths. It'll measurably affect everybody who is using psi.
> > 
> > Yet, in the years of using psi in production myself, I've never felt
> > the need for what this patch provides. There are event counters for
> > everything that contributes to pressure, and it's never been hard to
> > rootcause spikes. There are also things like bpftrace that let you
> > identify who is stalling for how long in order to do one-off tuning
> > and systems introspection.
> > 
> We think this patch is not for rootcause spikes, it's for automatic optimize
> memory besides oomd, especially for sysctl adjustment. For example if we see
> much pressure of direct reclaim the automatic optimize program might turn up
> watermark_scale_factor.
> The base idea is that this patch gives user a brief UI to know what kind of
> memory pressure the system is suffering, and to optimize the system in a fine
> grain. It could provide data for user to adjust watermark_boost_factor,
> extfrag_threshold, compaction_proactiveness,transparent_hugepage/defrag,
> swappiness, vfs_cache_pressure, madvise(), which may not easy for to do
> before.
> 
> It's not easy for automatic optimize program to use tools likes bpftrace or
> ftrace to do this.
> 
> While we may use CONFIG_PSI_XX or bootparam to turn on/off this patch to avoid
> additional footprint for user who not need this.

Hi
   Do you think this is praciseable?
