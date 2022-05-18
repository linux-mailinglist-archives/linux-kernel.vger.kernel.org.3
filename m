Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6917852C329
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbiERTRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiERTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:17:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489911078A2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:17:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d22so2677646plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7pSZ4gDx+VENEDy5UyTtlQIKK7PzzJMOZAJM4t5CZQg=;
        b=fgoj898mGrrcabwYuyrGj+2hV110iGSE30uwpPXGlhiREGUe0b2/yI2pG5b1CKGdfE
         P8HQF60tGDz7pg2qijdCIBB9S6/OBL63/D47pQ6h+iHuf4yCyl2QRqP1iSbjBsASe+4y
         1kQ/T9sasEGyxk5ZR3nXaOOjkVHEAjHfj2z3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7pSZ4gDx+VENEDy5UyTtlQIKK7PzzJMOZAJM4t5CZQg=;
        b=uQyM8lkiDQ4M6Objj1izD0rmt+jgno2xLqRNbKKALa/FNmgrw6ZcM9lZJHGIitEixO
         5g7Wx4gAIooe3Fk0O5+HlfSCMSh2xTcN5S3L0JLv+6CkUNRpbElOqNfS/FIZZgu4+ypl
         vMb1GYqlx6DqHBrAZoYO6jmvOTlUtM7KRPDSl5BQt5fGhNWS1OIezayBaBvnbjq6eMo0
         wkLKcEgkJMoV7HdKazPQIjJ+BzpUjfzwSCOxvpBxLQ0WQrs5eDxJlc08VbgsMpJk1QBu
         67mcEWLj3hq9y1uIZcVhoYip0jYhs6mr3JZEeI+n+4+gReUf4TbVIvUyny2n+EeA7IED
         /LDg==
X-Gm-Message-State: AOAM5305mTjhviENzNPYx+0c91SnNqysL+IwrgNr4ikPSDwFjd5WD2Kc
        w/DrFJ0/xQoyb6vcI1baAYiqGA==
X-Google-Smtp-Source: ABdhPJyxtdnH6BTrD9fTYRGjdho2AoPcg7/pbptofY1hp0hSyoIuktjx376JNQo2OqAAVwYRnmkcIQ==
X-Received: by 2002:a17:902:e0d4:b0:161:74ba:9def with SMTP id e20-20020a170902e0d400b0016174ba9defmr1083142pla.28.1652901466752;
        Wed, 18 May 2022 12:17:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ab8c00b0015e8d4eb22asm2063193plr.116.2022.05.18.12.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:17:46 -0700 (PDT)
Date:   Wed, 18 May 2022 12:17:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH -next] exec: Remove redundant check in
 do_open_execat/uselib
Message-ID: <202205181215.D448675BEA@keescook>
References: <20220518081227.1278192-1-chengzhihao1@huawei.com>
 <20220518104601.fc21907008231b60a0e54a8e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518104601.fc21907008231b60a0e54a8e@linux-foundation.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:46:01AM -0700, Andrew Morton wrote:
> On Wed, 18 May 2022 16:12:27 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
> > There is a false positive WARNON happening in execve(2)/uselib(2)
> > syscalls with concurrent noexec-remount.
> > 
> >        execveat                           remount
> > do_open_execat(path/bin)
> >   do_filp_open
> >     path_openat
> >       do_open
> >         may_open
> >           path_noexec() // PASS
> > 	                            remount(path->mnt, MS_NOEXEC)
> > WARNON(path_noexec(&file->f_path)) // path_noexec() checks fail

Did you encounter this in the real world?

> 
> You're saying this is a race condition?  A concurrent remount causes
> this warning?

It seems not an unreasonable thing to warn about. Perhaps since it's
technically reachable from userspace, it could be downgraded to
pr_warn(), but I certainly don't want to remove the checks.

> 
> > Since may_open() has already checked the same conditions, fix it by
> > removing 'S_ISREG' and 'path_noexec' check in do_open_execat()/uselib(2).
> > 
> > ...
> >
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -141,16 +141,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
> >  	if (IS_ERR(file))
> >  		goto out;
> >  
> > -	/*
> > -	 * may_open() has already checked for this, so it should be
> > -	 * impossible to trip now. But we need to be extra cautious
> > -	 * and check again at the very end too.
> > -	 */
> > -	error = -EACCES;
> > -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> > -			 path_noexec(&file->f_path)))
> > -		goto exit;
> > -
> 
> Maybe we should retain the `goto exit'.  The remount has now occurred,
> so the execution attempt should be denied.  If so, the comment should
> be updated to better explain what's happening.
> 
> I guess we'd still be racy against `mount -o exec', but accidentally
> denying something seems less serious than accidentally permitting it.

I'd like to leave this as-is, since we _do_ want to find the cases where
we're about to allow an exec and a very important security check was NOT
handled.

-- 
Kees Cook
