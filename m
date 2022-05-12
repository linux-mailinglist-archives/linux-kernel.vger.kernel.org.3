Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A2524DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354243AbiELNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354062AbiELNNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:13:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE960219C16
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:13:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv2so5114068pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgYuv7GhlzmnHluKCtUjBe8djdx9P7x4WT47WHSnm5Y=;
        b=m2Hu1kWiD8Oe7SJWUNIaRwWX/yyHHbsvTgpXIywYYyiz3jdMmVWMAearaH73sICApZ
         lsL6IK89F4OTYK5SdlbNZ6JEf2TLaMv+aw8vmAfEO78FCKTXOc0ITqMbkOLk8XdzFujA
         bFZYkjzAy11EZGX+dD/ooipayaky86LSgIA1qbMzgSyO7FrJZJYPMoDHIfWM+eWsP7sI
         4tUPSZtiGf9vS5GqpNxqmiXaqcFJpOhSlFUpgBAhi/e7bzgUubuLzSw/QLNQnfQmqPi1
         fCm7yeyL6Mhv1S0k7bemUU4Iw1yV675ByRbsQdGithSk8r3HOB+ogcm6/83v77HHk4fU
         fJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgYuv7GhlzmnHluKCtUjBe8djdx9P7x4WT47WHSnm5Y=;
        b=vPILS7ALdobmj2gQXRZs4Fi9M0+jo3xAgdBfO10+hPPi/0HITae2UkKniMbMBjloT0
         b7zFW7ZIy43f7TE/dd0CxmxZVnMYFoXopQkOJGINKdyEVC8U9VyUIistEcBu2sPKNYkc
         oENOPdcA/EcaZZmOqeMLlLSOK6OcQ+YCB7F5OAYvVI52j8CtVEC+e5gsetW7egI/IVQu
         j+lk2TbZI6PXHxsjZ+X+o4nt/wjnZyx6yR2KrCrCl8bTk0fepS3Qufw6v0Dcz6xyDe51
         gxMBChRMqdmRsfsYOlK5xwFQQXwEp7HA9+9goWyw6RymwDqdYOHi7eVzP9ocXaYXKq92
         Djcg==
X-Gm-Message-State: AOAM532LrMIcvi2+x6G4rAERFmqCVTqUOaoiCRi0XJ3fuUFpFu8i0EnW
        d7+t7XK2ydINmuQ8KahPPsg=
X-Google-Smtp-Source: ABdhPJwsq4luhYBe4ekuQOUAkGwvfCjEwDqPai96zigDre3xgmgH8Mf6X+q5c6yULebZYX2jtWbFVw==
X-Received: by 2002:a17:902:9043:b0:14f:aa08:8497 with SMTP id w3-20020a170902904300b0014faa088497mr30317153plz.109.1652361218699;
        Thu, 12 May 2022 06:13:38 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ad76:8fc:e2ba:172])
        by smtp.gmail.com with ESMTPSA id c2-20020a63ef42000000b003c14af50628sm1799292pgk.64.2022.05.12.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:13:37 -0700 (PDT)
Date:   Thu, 12 May 2022 06:13:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Message-ID: <Yn0H/68tagxaj/ke@google.com>
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
 <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
 <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
 <YjivtdkpY+reW0Gt@slm.duckdns.org>
 <YnzjrnnP622mad1y@google.com>
 <33772dcb-c5dd-c5e7-30c8-d2397d21b26c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33772dcb-c5dd-c5e7-30c8-d2397d21b26c@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:32:10PM +0900, Tetsuo Handa wrote:
> On 2022/05/12 19:38, Dmitry Torokhov wrote:
> > Hi Tejun,
> > 
> > On Mon, Mar 21, 2022 at 07:02:45AM -1000, Tejun Heo wrote:
> >> I'm willing to bet that the majority of the use cases can be converted to
> >> use flush_work() and that'd be the preference. We need a separate workqueue
> >> iff the flush requrement is complex (e.g. there are multiple dynamic work
> >> items in flight which need to be flushed together) or the work items needs
> >> some special attributes (such as MEM_RECLAIM or HIGHPRI) which don't apply
> >> to the system_wq users in the first place.
> > 
> > This means that now the code has to keep track of all work items that it
> > allocated, instead of being able "fire and forget" works (when dealing
> > with extremely infrequent events) and rely on flush_workqueue() to
> > cleanup.
> 
> Yes. Moreover, a patch to catch and refuse at compile time was proposed at
> https://lkml.kernel.org/r/738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp .

My comment was not a wholesale endorsement of Tejun's statement, but
rather a note of the fact that it again adds complexity (at least as far
as driver writers are concerned) to the kernel code.

Also as far as I can see the patch was rejected.

> 
> >          That flush typically happens in module unload path, and I
> > wonder if the restriction on flush_workqueue() could be relaxed to allow
> > calling it on unload.
> 
> A patch for drivers/input/mouse/psmouse-smbus.c is waiting for your response at
> https://lkml.kernel.org/r/25e2b787-cb2c-fb0d-d62c-6577ad1cd9df@I-love.SAKURA.ne.jp .
> Like many modules, flush_workqueue() happens on only module unload in your case.

Yes, I saw that patch, and that is what prompted my response. I find it
adding complexity and I was wondering if it could be avoided. It also
unclear to me if there is an additional cost coming from allocating a
dedicated workqueue.

> 
> We currently don't have a flag to tell whether the caller is inside module unload
> path. And even inside module unload path, flushing the system-wide workqueue is
> problematic under e.g. GFP_NOFS/GFP_NOIO context.

Sorry, I do not follow here. Are there module unloading code that runs
as GFP_NOFS/GFP_NOIO?

> Therefore, I don't think that
> the caller is inside module unload path as a good exception.
> 
> Removing flush_scheduled_work() is for proactively avoiding new problems like
> https://lkml.kernel.org/r/385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp
> and https://lkml.kernel.org/r/20220225112405.355599-10-Jerome.Pouiller@silabs.com .
> 
> Using local WQ also helps for documentation purpose.
> This change makes clear where the work's dependency is.
> Please grep the linux-next.git tree. Some have been already converted.

I understand that for some of them the change makes sense, but it would
be nice to continue using simple API under limited circumstances.

> 
> Any chance you have too many out-of-tree modules to convert?
> 

No, we are trying to get everything upstream.

Thanks.

-- 
Dmitry
