Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B994C0D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiBWHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiBWHMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:12:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E702E0D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:11:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so1379457pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eO4P8gNctIGm1EeUOiCxmIMQcDwPflV40V22xmuGQ1Y=;
        b=bBctnH/MZFlR4I0JUfB6Gqn3rQP8GWwrFKhCihvfRsVSV26vqP50YSur5zSj4Afa1U
         G7RTlvytoyBoMpOXekUbGCyvVn2KJJ3h20lzQr7OvBCrQH3VTscSKnOSuI+qyocYqyb+
         BTTKn+JeimFJLev56fTuW5vM+66C4No9wMjCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eO4P8gNctIGm1EeUOiCxmIMQcDwPflV40V22xmuGQ1Y=;
        b=KUoLWeW0pWzpz/396ZM6G6XP8oQVhBVUbZn22L22lhSA1MOMqGuaX0PxN401/rzRDq
         eQEV6Zede9VWDWLYJn3OLLrMpXlKA/hDH6j6n+whJKnT7ONNI4p+cuxR343BLMtq6CL9
         BRoIxQ83N1lhR7FyXY9Cyz+yUYdv6Z5Xiy91VMt7s9CEAYo8M5F2L9D7twVx6QtqWlTl
         taRanwmObzDtXMM9ewhkP4D2HXSNvIHgrRBCn0zWFqLRkXDkr5RlNv7xrH2683hvAXbb
         witGwv5/KCVAcfXdh2mJAgAwp86boC/7Th4iEUa5JLL4Vl4VWn/UK6x3/6fFGzpAu8Rb
         XMLg==
X-Gm-Message-State: AOAM531PdfIxKJU7G4rsoaAF4kf34R2vUsPubUZKBa4Wc6kYrW1Dx95j
        Xffu8zg3k1QjRZFDkmJNBefczQ==
X-Google-Smtp-Source: ABdhPJxxlJCmHoQ7UMp15+G8GXj41mXtG9w/xA5wheg6qRT0hvnTW3/qEjdvFqQjmDjErIbqyz/BHQ==
X-Received: by 2002:a17:90a:664b:b0:1bc:72df:54e4 with SMTP id f11-20020a17090a664b00b001bc72df54e4mr6776354pjm.10.1645600289667;
        Tue, 22 Feb 2022 23:11:29 -0800 (PST)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id k16sm20903338pfu.149.2022.02.22.23.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Feb 2022 23:11:29 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:11:23 +0900
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/3] mm/damon/core: Add damon_start_one()
Message-ID: <20220223071123.GB6270@swarm08>
References: <20220218102611.31895-3-tome01@ajou.ac.kr>
 <20220222095328.7962-1-sj@kernel.org>
 <20220223051113.GA3535@swarm08>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223051113.GA3535@swarm08>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:11:13PM +0900, Jonghyeon Kim wrote:
> On Tue, Feb 22, 2022 at 09:53:28AM +0000, SeongJae Park wrote:
> > Hello Jonghyeon,
> > 
> > On Fri, 18 Feb 2022 19:26:10 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:
> > 
> > > damon_start() function is designed to start multiple damon monitoring
> > > contexts. But, sometimes we need to start monitoring one context.
> > > Although __damon_start() could be considered to start for one monitoring
> > > context, it seems reasonable to adopt a new function that does not need
> > > to handle 'damon_lock' from the caller.
> > > 
> > > Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> > > ---
> > >  include/linux/damon.h |  1 +
> > >  mm/damon/core.c       | 25 +++++++++++++++++++++++++
> > >  2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > index c0adf1566603..069577477662 100644
> > > --- a/include/linux/damon.h
> > > +++ b/include/linux/damon.h
> > > @@ -511,6 +511,7 @@ int damon_register_ops(struct damon_operations *ops);
> > >  int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
> > >  
> > >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> > > +int damon_start_one(struct damon_ctx *ctx);
> > >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> > >  
> > >  #endif	/* CONFIG_DAMON */
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 290c9c0535ee..e43f138a3489 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -466,6 +466,31 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
> > >  	return err;
> > >  }
> > >  
> > > +/**
> > > + * damon_start_one() - Starts the monitorings for one context.
> > > + * @ctx:	monitoring context
> > > + *
> > > + * This function starts one monitoring thread for only one monitoring context
> > > + * handling damon_lock.
> > > + *
> > > + * Return: 0 on success, negative error code otherwise.
> > > + */
> > > +int damon_start_one(struct damon_ctx *ctx)
> > > +{
> > > +	int err = 0;
> > > +
> > > +	mutex_lock(&damon_lock);
> > > +	err = __damon_start(ctx);
> > > +	if (err) {
> > > +		mutex_unlock(&damon_lock);
> > > +		return err;
> > > +	}
> > > +	nr_running_ctxs++;
> > > +	mutex_unlock(&damon_lock);
> > > +
> > > +	return err;
> > > +}
> > > +
> > 
> > IMHO, this looks like an unnecessary duplication of code.  Unless this is
> > needed for a real usecase, this change might unnecessarily make the code only a
> > little bit more complicated.  And to my understanding of the next patch, this
> > is not really needed for this patchset.  I will left comments on the patch.  If
> > I'm missing something, please clarify why this is really needed.
> > 
> > Furthermore, damon_start() starts a set of DAMON contexts in exclusive manner,
> > to ensure there will be no interference.  This patch breaks the assumption.
> > That is, contexts that started with damon_start() could be interfered by other
> > contexts that started with damon_start_one().  I have a plan to make
> > damon_start() also work for non-exclusive contexts group[1], though.
> > 
> > [1] https://lore.kernel.org/linux-mm/20220217161938.8874-3-sj@kernel.org/
> > 
> > 
> > Thanks,
> > SJ
> > 
> 
> I understand your opinion, and it makes sense. I will drop this patch in the
> next version.
> 
> 
> Thanks,
> Jonghyeon
