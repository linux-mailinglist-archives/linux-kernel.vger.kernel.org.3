Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EED598626
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbiHROjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbiHROjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:39:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AF914034
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:39:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z16so1960063wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=w6bPTRCq04c/Wiu/1kntUMcj++VRX08tLQSAafIMMmM=;
        b=YnFzSAwpqCnS8+HXDX+cedyRqdPliKutClbs5i0anlxsPgKKG1hKsBLBkp0bQ33VJJ
         nm10ZUMWoRUzv9MYtPdHDNLi5nLwItYd2KtifUPZJVySfD64z1C6xplaLGimmjQGp/qJ
         Acxy5IbFKw48jiXe/vYFcFPSuQLcOh+oWoXcO2TeztbLPXkH1Q2whncxdXXejI1+OPCj
         nfmhhif3q2Kwe0WsBDw9rG/Q35T4Wwszl5PTLFkfRvmwQBFPa+Xkdbs7gmTKEEpgTZQQ
         MEgl0Mc3IJk3F+Xf9Lrqkhz2J6kUZXoRMPJWoTnqX2679vEwD6CSkhZf4WsZAeDlTpiX
         4cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w6bPTRCq04c/Wiu/1kntUMcj++VRX08tLQSAafIMMmM=;
        b=B9AKHUc7cXWnHBqIq8QHi5kM5W6kyBNkAHlgCOXuGkAC6npR585QApXpQ9b4lGykAP
         VM9d/VIrJkmP7mE6mN+PYbxyVh0YZ4X3r/XTAQ3aOpDFebqTgdIevrWp/me+EBFzeBxy
         3iNtMZHTs4nYVdTfI9I5bedVwEz74S19xyLPj23laa2uquYxvRi8t8ZvsJcUdHrBNTnR
         GfBarck55Hcl0dmbG3R67CH3CcUhiqDjUxdm+4lYONPIF0tbHWjVHIwMCb6tPTi2vRil
         q13fyyHxugwt3Te/p2iutcaigcMrljCUP8tTKLercJ5Z604ztQJwFhN2tKG1Cxm+Kq9Q
         W2eg==
X-Gm-Message-State: ACgBeo1CpGsiuWx8l0g3rQUyi/FP8rf1NAjwW3IAitgGsBiuVFX3gb/u
        IPsbSEFPRURJkeI764OcesDmMTMennsF8TMSNqk=
X-Google-Smtp-Source: AA6agR7MSRvpS8CcOKLJqQjnCYXhf41sL8UgIjUkbfMTEIT+AOhVho29kMCrXR8OT+0TNc8X5x+Crlk0Vgz0OfmwlDE=
X-Received: by 2002:adf:a490:0:b0:225:2da4:10ff with SMTP id
 g16-20020adfa490000000b002252da410ffmr1850624wrb.1.1660833572685; Thu, 18 Aug
 2022 07:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-2-jiangshanlai@gmail.com> <YvwJs66gR71UAHi8@slm.duckdns.org>
In-Reply-To: <YvwJs66gR71UAHi8@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 18 Aug 2022 22:39:21 +0800
Message-ID: <CAJhGHyC4J4aCUs6NkyOmL-P9ftKQp500XjYHY90y5oM1q8fV_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] workqueue: Unconditionally set cpumask in worker_attach_to_pool()
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 5:18 AM Tejun Heo <tj@kernel.org> wrote:
>
> cc'ing Waiman.
>
> On Thu, Aug 04, 2022 at 04:41:28PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > If a worker is spuriously woken up after kthread_bind_mask() but before
> > worker_attach_to_pool(), and there are some cpu-hot-[un]plug happening
> > during the same interval, the worker task might be pushed away from its
> > bound CPU with its affinity changed by the scheduler and worker_attach_to_pool()
> > doesn't rebind it properly.
> >
> > Do unconditionally affinity binding in worker_attach_to_pool() to fix
> > the problem.
> >
> > Prepare for moving worker_attach_to_pool() from create_worker() to the
> > starting of worker_thread() which will really cause the said interval
> > even without spurious wakeup.
>
> So, this looks fine but I think the whole thing can be simplified if we
> integrate this with the persistent user cpumask change that Waiman is
> working on. We can just set the cpumask once during init and let the
> scheduler core figure out what the current effective mask is as CPU
> availability changes.
>
>  http://lkml.kernel.org/r/20220816192734.67115-4-longman@redhat.com
>

I like this approach.
