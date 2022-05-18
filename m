Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982C952B1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiERFh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiERFhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:37:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417ACDCC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OWzOnyRGhSNWu55pQcD8xrowoz0GoENefMIUO4eEwjk=; b=q0mu0N5AlN1YSnpALMhm77VNam
        YipxR9GrpOqt3CyownScjSeTqTr8dhUEamMCggbshS4dITDFSem4K9oI8p6M8D4dxbl0MdLD2+H1Z
        +uY8Pd/37RpV2ZKkt8nIPhiwIeFnCMOPDeYaRcU5g3OA1kRYM34rQQvJt3NAEzBUIncj7CzWSH020
        QmCbVwm+s50tYOCGa1IwbafhlWOxbe7KuQEpkol+RKsxwEoFSLOFUocsCfXAytYJ1eaTArCmUcqkf
        MjSXclgH0gAJ7eRuC9EAMTzYyivDmTz63l/JNUd6NbR4CliN471tgI3kQiU9WAuXM/82ENA/l9jg7
        p6UnCdAw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrCN5-00Fx12-13; Wed, 18 May 2022 05:37:19 +0000
Date:   Wed, 18 May 2022 05:37:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoSGDwu++m4/gCIK@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
 <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
 <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
 <YoRHfB7lEGUwQBGU@zeniv-ca.linux.org.uk>
 <YoRS0L0ywSZkflq7@zeniv-ca.linux.org.uk>
 <YoR4XSN2fn2BjkXw@zeniv-ca.linux.org.uk>
 <YoR8yrgorv8QssX6@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoR8yrgorv8QssX6@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:57:46AM +0000, Al Viro wrote:

> Gotcha.
> percpu_ref_init():
>         ref->percpu_count_ptr = (unsigned long)
>                 __alloc_percpu_gfp(sizeof(unsigned long), align, gfp);
>         if (!ref->percpu_count_ptr)
>                 return -ENOMEM;
>         data = kzalloc(sizeof(*ref->data), gfp);
>         if (!data) {
>                 free_percpu((void __percpu *)ref->percpu_count_ptr);
>                 return -ENOMEM;
>         }
> 
> cgroup_create():
>         err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
>         if (err)
>                 goto err_free_css;
> 
>         err = cgroup_idr_alloc(&ss->css_idr, NULL, 2, 0, GFP_KERNEL);
>         if (err < 0)
>                 goto err_free_css;
> 
> Now note that we end up hitting the same path in case of successful and
> failed percpu_ref_init().  With no way to tell if css->refcnt.percpu_count_ptr
> is an already freed object or needs to be freed.  And sure enough, we have
> 
> err_free_css:
>         list_del_rcu(&css->rstat_css_node);
>         INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
>         queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> 
> with css_free_rwork_fn() starting with
>         percpu_ref_exit(&css->refcnt);
> 
> which will give that double free.  That might be not the only cause of
> trouble, but this looks like a bug and a plausible source of the
> symptoms observed here.  Let's see if this helps:
> 
> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> index af9302141bcf..e5c5315da274 100644
> --- a/lib/percpu-refcount.c
> +++ b/lib/percpu-refcount.c
> @@ -76,6 +76,7 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
>  	data = kzalloc(sizeof(*ref->data), gfp);
>  	if (!data) {
>  		free_percpu((void __percpu *)ref->percpu_count_ptr);
> +		ref->percpu_count_ptr = 0;
>  		return -ENOMEM;
>  	}
>  

... and it appears to fix the damn thing.  10 minutes and still running;
without that it usually fails within a few seconds.
