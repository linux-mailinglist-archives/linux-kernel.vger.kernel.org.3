Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F225252EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351578AbiELQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356673AbiELQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:46:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3FA268653
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:46:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x23so5313640pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/6qmbmcP5AokRkbZn/xg32IG6zFnvDICjqZUz86mKs=;
        b=oIhkT9a8+AOL4JI7Qk/U6odJZm+0v8MQsEwzhADBYZXDwvu58jVVmyYBMNMQl7v5ap
         9KkPPEmGEpKFtcDdq8B9f/4K/xMVoHNzFH2mbb9YOjFAWYmha8NvJPUvSM2D4WBiz0LK
         JMJfoSjl7jNgx6wZzPcy1U0cTM1SJcfU24lsUYglc3U6jLWRGTktN7TlojDq3dzJD+5s
         izETkmw4tM83dNMFn7+PNoeyx0GL3K4rJGMNM42/ptX822vNdPabInHByWiEtpxwWcYr
         p78E9khLDmr3WeCT2wJwcfu9KkCANu4rjcDoHL4Oq5+73rcwQC5w0gZQmfb++q5RZ+sQ
         sFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+/6qmbmcP5AokRkbZn/xg32IG6zFnvDICjqZUz86mKs=;
        b=0uu2agfSotJtL3jQqYeUvKbIXZqoQ5RvffocSukq+vNHU3yJg0gzzpMzxbhl0s7qyK
         Z/7CwUcAwZyhSpHrQV7c9oQVyCj4aQIaJ9VXvrmSBBN9ZlbCR0UfeV1/saOxIsqFyQq2
         6eJ9CK7+X/3uwjdn0LkvomWZa7WqX0A8uh2aC7FPHb2mbjWIXgDtVZlnjP9x/ZaiV/k2
         5GrSfxrsw6bu/dFi3Jfz+fMG0CH+y+PD+TZzdxAn2jSfs7Pe79NRPPglSS+Zz6kLSMrl
         Ya9p7/LE0ueaSoEwWQ8/mmRzRD+K7HG9EmpPtH4BAVCDa5TETMLu1//3z6CAF4sD42zg
         Oc9Q==
X-Gm-Message-State: AOAM532f8SKiZfT533l+ovQcg7kiXQROQH5wxbgkdesRbeVETKZX6uUz
        hMCEO1h1KUNGq24OxSk/uyY=
X-Google-Smtp-Source: ABdhPJwO+DuCUU5o9DMk576E6z5ybMRQPZuq7c1PyPVSqveeVp1yLTlHGjhOv8Y/Aq9/rrbdO8OgiA==
X-Received: by 2002:a63:64c2:0:b0:3c6:2d70:9188 with SMTP id y185-20020a6364c2000000b003c62d709188mr455077pgb.186.1652373986078;
        Thu, 12 May 2022 09:46:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902a3c900b0015e8d4eb210sm138646plb.90.2022.05.12.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:46:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 May 2022 06:46:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] checkpatch: warn about flushing system-wide workqueues
Message-ID: <Yn0538VavQPv+/Ws@slm.duckdns.org>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
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

On Fri, May 06, 2022 at 08:29:07AM +0900, Tetsuo Handa wrote:
> On 2022/05/06 2:32, Tejun Heo wrote:
> > Given that we'll need runtime check anyway, why not resurrect the original
> > runtime warning but exempt flush_schedule_work() if that's the only thing
> > remaining right now (using a special flag or whatever)?
> 
> Yes, we will also need runtime check for robustness, for we can't catch usage
> like
> 
> 	struct workqueue_struct *my_wq = alloc_workqueue();
> 	if (!my_wq)
> 		my_wq = system_long_wq;
> 	flush_workqueue(my_wq);
> 
> using compile time checks.
> 
> I found that it is not easy to trigger flush_workqueue() paths. For example,
> several modules are using flush_workqueue() only upon module unloading.

Ah, yeah, good point.

> Therefore, I'm trying to catch obvious flush_workqueue() paths at compile
> time when possible.
> 
> >                                                         If we're sure that
> > we aren't triggering it spuriously, we can ask Andrew to take the warning
> > patch into -mm so that it floats on top of everything else and gets pulled
> > into the trunk during the coming merge window.
> 
> OK, the coming merge window means 5.19.
> 
> The original runtime checking will be used anyway. Is "workqueue: Wrap
> flush_workqueue() using a macro" OK for you as a compile time check?

Sounds good to me.

Thanks.

-- 
tejun
