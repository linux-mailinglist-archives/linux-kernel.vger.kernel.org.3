Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9154B9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358152AbiFNSvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358136AbiFNSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:50:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA14F1CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:45:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x4so9318071pfj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16pqE78FIa7Vn0gONS3Mr3i/kFD37bxENtXTZbSNIFQ=;
        b=VKKn8qJyhwod3mgi0CI6lP3Ur7bQ6AY1/ev0p6s562DDaxLbNSbrJuw2f98+u9MmXt
         8jIjJ0fqlYujWH4pQjpzCuysA0HRkcLOOFP7bEbDNvgTDdKGy1ALbQpGfQJodFG1E3yC
         J+Tvo/i52kgWubacs1M2uV4qt4ctU5pTRtdEfyQtpZ8bfwv0C6TsmutMsV6CYJ6vzfwA
         9hriFxIO3xllf8tljqu8iNCXCLjnvgdBVzXAG02pz5XwZ237wCmXq4e0jBiOOFOmXXVh
         V/Rd8Sw17yqb0BVujRMXTKLP/XsQbp4mBRHzcvcKX2wNeGsGsopInbREKFGXE/dKhU5L
         kNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16pqE78FIa7Vn0gONS3Mr3i/kFD37bxENtXTZbSNIFQ=;
        b=gVF/yNtu8ABoTJUxu4Mi7OU4lgXN6sv+n76EXl1oKdf2f1Wj7H0aEp3GsbwrxFCiI5
         VSP4J9qhCkAQaotLGYBqqNhn9PGuSLPcXc1rZflCeWuW7uC/Dmquk0Ke3v05kaSpiiyD
         yLtfNWXv1tSYvaW9wOQopVua08CzK9FHo9VVytDpiA/hT8wznmrU1cjxWXWmuNoL073Z
         P+Sm0FbA0wj/9VeD2SbgfuAvR/UVKKGZeFn1D0WdwNjkPnCLMAIDONC34dmMVr0EUUYo
         xfneIOB+mTSfKGAqKZUk673MNOdZlm8zHytVED01zftdvYWRhfcpnLdlEjKifoK/qB6H
         3UDQ==
X-Gm-Message-State: AOAM530Y7zSbJkg6EvCs7bJ+H1P2o1rU4l22bU6FfYMn129dPxqH6Lgf
        jlRI+pvcT57fGXgS+TBTt5zapg==
X-Google-Smtp-Source: ABdhPJxB9munx6OcvzcGf4InmtZO8eaosh9UBWh4dIEDauGg41G+tx8wlbCns8L0ZfmE/wMq7zbYNQ==
X-Received: by 2002:a63:a0e:0:b0:3fd:a62e:fa5f with SMTP id 14-20020a630a0e000000b003fda62efa5fmr5692170pgk.126.1655232328628;
        Tue, 14 Jun 2022 11:45:28 -0700 (PDT)
Received: from google.com (249.189.233.35.bc.googleusercontent.com. [35.233.189.249])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001640537511esm7528770pla.71.2022.06.14.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:45:27 -0700 (PDT)
Date:   Tue, 14 Jun 2022 18:45:24 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@android.com, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sysfs: fix sysfs_kf_seq_show null pointer dereference
Message-ID: <YqjXRMg2HZyk7+Cl@google.com>
References: <20220614172401.3010509-1-willmcvicker@google.com>
 <YqjFPxuPO6SZuvg2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqjFPxuPO6SZuvg2@kroah.com>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2022, Greg Kroah-Hartman wrote:
> On Tue, Jun 14, 2022 at 05:24:01PM +0000, Will McVicker wrote:
> > When the kobj->ktype is null,
> 
> How can that happen?  What in-tree code does that?

This kernel panic happens randomly for me. The call trace shows that this
happens when the read syscall is invoked by Android. GDB gave me this line when
disassembling __arm64_sys_read+0x20/0x30:

fs/read_write.c:628
SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)

> 
> > sysfs_file_ops() returns a NULL pointer
> > for the sysfs_ops. When this happens, we hit a kernel panic in
> > sysfs_kf_seq_show() by dereferencing ops to check if ->show is NULL.
> > Based on commit 820879ee1865 ("sysfs: simplify sysfs_kf_seq_show"), it
> > sounds like we won't hit this often, but I have randomly hit this on my
> > Pixel 6 with 5.19-rc1. Refer to the crash stack below:
> > 
> >    Unable to handle kernel paging request at virtual address ...
> >    Internal error: Oops: 96000004 [#1] PREEMPT SMP
> >    Hardware name: Oriole EVT 1.0 (DT)
> >    pc : sysfs_kf_seq_show+0x3c/0x160
> >    lr : kernfs_seq_show+0x54/0xa0
> >    Call trace:
> >     sysfs_kf_seq_show+0x3c/0x160
> >     kernfs_seq_show+0x54/0xa0
> >     seq_read_iter+0x17c/0x638
> >     kernfs_fop_read_iter+0x70/0x1f4
> >     vfs_read+0x240/0x36c
> >     ksys_read+0x7c/0xf0
> >     __arm64_sys_read+0x20/0x30
> >     invoke_syscall+0x60/0x150
> >     el0_svc_common+0xb8/0x100
> >     do_el0_svc+0x30/0xd4
> >     el0_svc+0x30/0xc0
> >     el0t_64_sync_handler+0x88/0xf8
> >     el0t_64_sync+0x1a0/0x1a4
> > 
> > Fixes: 820879ee1865 ("sysfs: simplify sysfs_kf_seq_show")
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  fs/sysfs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index a12ac0356c69..f09f86f10410 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -45,7 +45,7 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
> >  	ssize_t count;
> >  	char *buf;
> >  
> > -	if (WARN_ON_ONCE(!ops->show))
> > +	if (WARN_ON_ONCE(!ops || !ops->show))
> >  		return -EINVAL;
> 
> Seems reasonable, but I want to track down how ops can be NULL here
> under normal operation.

Let me try to follow the code path through the call trace to see if I can track
down how ops could be NULL. It appears we could have hit this before commit
820879ee1865 ("sysfs: simplify sysfs_kf_seq_show") as well.

> 
> thanks,
> 
> greg k-h
