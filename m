Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12551C624
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382706AbiEERgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiEERgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:36:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D0452E64
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:32:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g8so4188538pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GzeX1LyyVzwlDtvqs6CtUnL/XfHH6XfCOHSbGbugfQY=;
        b=AadXKrU0Xof9olzjNcFiwKm0d1t8qgPo8U6TqpOPZOTi9+CU+lqt76Q5Eo/3uO8U0/
         m+pSIcD9/lq0CFyI4/Wy8LXX8sTKwdxHO6/c+gOPjIK6WHOPZ9E3wwuMFQXFc3pgOsV5
         +3/QHOkTWS8EWKF/eLQKrBFFsFG9VVaN8dG3VFnqT1Wfw+OgjLJR9qLEVanvFlc0nOzs
         5y78w/sH6lC9kwZ5l3wLpAJ0kYRAifAp0qxwlDO7UoFeHr0HqZ9h/pEnTAQ7LLG7wT4b
         Vv6wr4Yt9kYTBk+H5pQeTac+h2/E7Q3e9U9fJQABVuW98acoXfR7U3mjQfQxP7qy6gfm
         C16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GzeX1LyyVzwlDtvqs6CtUnL/XfHH6XfCOHSbGbugfQY=;
        b=yX25rloXr1hb+8oVxAUUdsqI98+DwWnnGMoKa76Skhr4rEi/A3TJ1XgTVZdPUeTJkx
         wzTb+4l85dCoy5kF+SW0eBtShw6AuAHDwkCYYeJzCV+jxXpResPHQHOiE/O1OFwFG3yi
         fZV9U+RGdxNFbiH0iAhb1xcODcntbshO55LbHAGnzjdbGZ9ipH00gliYDOVNTDM7ykvV
         3IlWdquqN5j6Y1IhkwMW60+MA6knCJK/c9Yi0bIvg5oTqWP5Tap6S8ObzUzIKPVyl7ko
         vKFVY5Irr0CBU1vVVwKl2sKhhRdjOuQqVB8u2OzHVS5CibyDm3lWUF+hiwSFszBzxt4N
         TAeg==
X-Gm-Message-State: AOAM531Vt+kEis1a51IJF4A4/zkFed7Ff49N2qln1yBIo9wU6KxX2vcN
        Qly/pJP9dboY7dL1vUFqv2o=
X-Google-Smtp-Source: ABdhPJyCdoRvJUN5XbLrVOxf8ZBjqAkw+NGlbhP1pHLDFIe5dyjJPBfr+POvjDVKRjLFOqCoFRfnGQ==
X-Received: by 2002:a05:6a00:1488:b0:510:4e64:fb80 with SMTP id v8-20020a056a00148800b005104e64fb80mr7171611pfu.58.1651771959283;
        Thu, 05 May 2022 10:32:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:29a5])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902b69600b0015e8d4eb2ccsm1775585pls.278.2022.05.05.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:32:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 May 2022 07:32:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] checkpatch: warn about flushing system-wide workqueues
Message-ID: <YnQKNea6KWFaWNis@slm.duckdns.org>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
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

Hello,

On Thu, May 05, 2022 at 10:42:19PM +0900, Tetsuo Handa wrote:
> Tejun, can we use this approach? If yes, when to apply?
>
> If we can include this patch into 5.18, can be applied as-is.
> If we can include this patch into 5.19, can be applied with checks for
> system_{long,unbound,highpri}_wq added because all flush_workqueue() users
> on system_*_wq are gone in next-20220505.
> 
> Now that all flush_workqueue() users on system_*_wq are gone in next-20220505,
> next step is to remove all flush_scheduled_work() users. Therefore, instead of
> using /\bflush_workqueue\s*\(\s*system(_\w*)?_wq\s*\)/ in scripts/checkpatch.pl ,
> I think we can ask BUILD_BUG_ON() for blocking new system_*_wq users, and ask
> scripts/checkpatch.pl for blocking new system_wq users.

Given that we'll need runtime check anyway, why not resurrect the original
runtime warning but exempt flush_schedule_work() if that's the only thing
remaining right now (using a special flag or whatever)? If we're sure that
we aren't triggering it spuriously, we can ask Andrew to take the warning
patch into -mm so that it floats on top of everything else and gets pulled
into the trunk during the coming merge window.

Thanks.

-- 
tejun
