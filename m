Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAF4704E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhLJPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:52:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237200AbhLJPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639151288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pda/qc1prCCb2qrpGLUGKr4eMjz1JOr+GUpfjD/UcSk=;
        b=ODyp7XcjESGHZkOhZCelBcHLR26hrO5T7xgX5WxngcxDtEZB7Tmr2p5CL6TEB5Sy8OyiAN
        FL4lPqNQourEOQA1sJb+ruwOgW/0RSZrMocbNxst9a5FZQvnonH5br1cdSu2+ph7cYn2eb
        mH34oZwACw6b7cftntRTc8+NjTgDZdc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-TVophE6MP5GV_be_dfRSsg-1; Fri, 10 Dec 2021 10:48:07 -0500
X-MC-Unique: TVophE6MP5GV_be_dfRSsg-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso6887439wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pda/qc1prCCb2qrpGLUGKr4eMjz1JOr+GUpfjD/UcSk=;
        b=6GVIoBamtlrjVn91t88LBMlk6r3BvCglUlLGV7jLDlwGHY5WtsOdFEfeHiZ2jtzBs7
         ACTcBMXXanewCIMxpKG8tLkehT12Wb0GDV+XESRtEku7ZP2sNiR+GZDGT0qb4PHPnnyz
         pNLnrAMFWGAjjh5HynmnF8gEAKBK60lyPUeJS91gWVWFOx4hOLa3M8ql1nvl31tA+fjU
         rj5Zinlnp1fN7t5UZ9VXRTT93r9M1LdAEbYj9+Lro7ulZeZ5dUYsQC8J43mA2Uh6OznO
         JrDJyK3ZT4u3ieswPCckSXwNTtWUTctrcnSg9IrO6HJBw9mJStf2VBhU8Pookm96ce8W
         cKww==
X-Gm-Message-State: AOAM530CSEIGzKi/JrlgftUqW9FOnIBAeJtRY/JdFadNZ6Wz8iXxaY1z
        iabvUYUhEtE9UPUfm5V16max08JveMVOmShZbcdInpMMfSQ8hdc7Bs3hFjQS0sKo37I+0a9XwVI
        uLd4jfE4L8zuCD1y4UIjFJFo=
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr14348832wri.92.1639151285946;
        Fri, 10 Dec 2021 07:48:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVu7oc8TaeSUZ83BJetcvkRic9YzIu2tc5o9kQ2GOMJ3ScWZikKavI9pNdv1/MK9TeP0GLsg==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr14348799wri.92.1639151285712;
        Fri, 10 Dec 2021 07:48:05 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id w22sm3130257wmi.27.2021.12.10.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:48:05 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:48:04 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>, Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <20211210154804.zq4dyycwd4jlb3bg@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <YbKUUJUtjBk/n913@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbKUUJUtjBk/n913@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-12-09 15:42 -0800, Luis Chamberlain wrote:
> > Indeed - is this acceptable to you? I prefer this approach rather than
> > remove it from the aforementioned list solely based on the module name.
> 
> Sure, it makes sense to keep all the stupid ways we are harming the
> kernel. Makes sense. The other point I made about count though would
> be good, in case the taint was the same.

Agreed. So, just to confirm you'd prefer not remove any module that tainted
the kernel from the aforementioned list when the same module and taints
bitmask is reintroduced? If I understand correctly, we'd simply maintain a
list of modules that tainted the kernel during module deletion/or unload
and their respective unload count? If so then this was not my original
objective yet I'm happy with this approach too - I'll take on this
implementation in the next iteration.

> > It can be, once set to 0. Indeed, the limit specified above is arbitrary.
> > Personally, I prefer to have some limit that can be controlled by the user.
> > In fact, if agreed, I can incorporate the limit [when specified] into the
> > output generated via print_modules().
> 
> If someone enables this feature I can't think of a reason why they
> would want to limit this to some arbitrary number. So my preference
> is to remove that limitation completely. I see no point to it.

Fair enough. If necessary we could introduce the above later.

> > > > @@ -3703,6 +3778,16 @@ static noinline int do_init_module(struct module *mod)
> > > >  	mod->state = MODULE_STATE_LIVE;
> > > >  	blocking_notifier_call_chain(&module_notify_list,
> > > >  				     MODULE_STATE_LIVE, mod);
> > > > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > > > +	mutex_lock(&module_mutex);
> > > > +	old = find_mod_unload_taint(mod->name, strlen(mod->name),
> > > > +				mod->taints);
> > > > +	if (old) {
> > > > +		list_del_rcu(&old->list);
> > > > +		synchronize_rcu();
> > > > +	}
> > > > +	mutex_unlock(&module_mutex);
> > > 
> > > But here we seem to delete an old instance of the module taint
> > > history if it is loaded again and has the same taint properties.
> > > Why?

Yes, this was my original approach. Once the same module [with the same
taints bitmask] is reintroduced it will be listed on the 'modules' list
thus no need to track it on the unloaded list anymore. That being said, as
per the above, let's now keep track of each removal and maintain an unload
count.

> > At first glance, in this particular case, I believe this makes sense to
> > avoid duplication
> 
> If you just bump the count then its not duplication, it just adds
> more information that the same module name with the same taint flag
> has been unloaded now more than once.

Agreed.

> > All right. I will make the required changes. Thanks once again.
> 
> Sure, so hey just one more thing. Can you add a simple selftest
> lib/test_taint.c which can be used to test tainting and you new
> tracker ? You can add a new selftest on
> 
> tools/testing/selftests/module/
> 
> I had already written some module based testing on
> tools/testing/selftests/kmod/kmod.sh so you can borrow stuff
> from there if you find it useful. But I think we need to start
> doing basic testing for module. I know Lucas has tons of test
> on kmod, so we should also look at what is there and what needs
> testing outside of that.
> 
> Then there is the question of what should be tested using kunit and
> or selftests. From my experience, if you need a shell, use selftests.
> Also, if you need parallelization, use selftests, given kunit by
> default uses a uniprocessor architecture, user-mode-linux. I'll let
> you figure out what is the best place to add the test for this. It
> could just be its a better place to add these tests to kmod upstream
> as there are tons of tests there already. But kunit test can't be
> added there.
> 
> Live patching already has its own set of selftests.


Sure - will do. Thanks once again!

-- 
Aaron Tomlin

