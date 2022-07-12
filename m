Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2223571C13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiGLORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiGLOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55830B418A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657635400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0E800OOqW5ckhgP7sOdw5kGbfjGB1H4nNWnEL28pNs=;
        b=VjxO6nZA2z27c4BWucxDFgyC/q9jFHSr0ADPvL6ft13byi5OvBk1u/Q/gowjgkssr6mHc0
        SYA6oJN8yaH3vKQUyqjYxfKw6IPCeAqkzQgj/MwGF8fVnzOy7ZU3lF3NUZ7lMQpvT8ohil
        VstIOm3+pCbj22QiSR0uS4AQJ1lpUUc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-bOl8jFemMRmaSl7QFRkhtw-1; Tue, 12 Jul 2022 10:16:33 -0400
X-MC-Unique: bOl8jFemMRmaSl7QFRkhtw-1
Received: by mail-qk1-f200.google.com with SMTP id l189-20020a37bbc6000000b006af2596c5e8so7925666qkf.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U0E800OOqW5ckhgP7sOdw5kGbfjGB1H4nNWnEL28pNs=;
        b=VGRI8Eb7MkNW4BxdWRrSEGgGYD6p+/qg55nSpdxutJdjz0m1di/elqm6jAQ+XRe8NJ
         DoSB+pmYMb4Bq4NiA/w87F3ZQ/C5iW6uk1OS+/NRezLHQI4OyKb+8gLuKrlg4KHIHBnc
         aH3hdRx9SGR3bo1up1fGfJXUvzVYpX9FpQdu8n/54Khyilr+k9HyNwb6j5rtxhaQjz3M
         WXjGcDhO28ailv9NpDgWAp9Q/cqNK3Z9f8YfB/oyMOA8LEnr024VLdcTKPSlgJRA+nmU
         nejaXA1IGh790EpxTkTJyAe8P4bwlr8jwr7qd4IqafPtZr7lvLkgIL/P44UIY+ZaftC/
         zcaA==
X-Gm-Message-State: AJIora8cCgTmPpttvkLfNEPD19QL1hHYwNAct0mzMHfJWwIdg+8vhRuu
        sDYEXNCbLnJZ7O0itxMa4+O3Su9zI5hy3vXANg7wc4Rf5dcOz6B8vmM2fJbdzogr4yGq4nL4Obt
        kNPvOIBpgb6ghyNoIf96ZPOUA
X-Received: by 2002:a05:620a:16d3:b0:6b5:76f3:4f8e with SMTP id a19-20020a05620a16d300b006b576f34f8emr10386987qkn.473.1657635392040;
        Tue, 12 Jul 2022 07:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQdkvIRVXScoSRWjvtDqqmO0XeFQEDUJFQ6nwxHO07gf4piqkM62wZH6UFM1CoQhp+9r9GyQ==
X-Received: by 2002:a05:620a:16d3:b0:6b5:76f3:4f8e with SMTP id a19-20020a05620a16d300b006b576f34f8emr10386955qkn.473.1657635391661;
        Tue, 12 Jul 2022 07:16:31 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b0031eb0bb5c3csm6020743qtb.28.2022.07.12.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:16:31 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:16:28 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v4] proc: Fix a dentry lock race between release_task and
 lookup
Message-ID: <Ys2CPO4FodMlAqRR@bfoster>
References: <20220601062332.232439-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601062332.232439-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:23:32PM +0800, Zhihao Cheng wrote:
> Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> moved proc_flush_task() behind __exit_signal(). Then, process systemd
> can take long period high cpu usage during releasing task in following
> concurrent processes:
> 
>   systemd                                 ps
> kernel_waitid                 stat(/proc/tgid)
>   do_wait                       filename_lookup
>     wait_consider_task            lookup_fast
>       release_task
>         __exit_signal
>           __unhash_process
>             detach_pid
>               __change_pid // remove task->pid_links
>                                      d_revalidate -> pid_revalidate  // 0
>                                      d_invalidate(/proc/tgid)
>                                        shrink_dcache_parent(/proc/tgid)
>                                          d_walk(/proc/tgid)
>                                            spin_lock_nested(/proc/tgid/fd)
>                                            // iterating opened fd
>         proc_flush_pid                                    |
>            d_invalidate (/proc/tgid/fd)                   |
>               shrink_dcache_parent(/proc/tgid/fd)         |
>                 shrink_dentry_list(subdirs)               ↓
>                   shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock
> 

Curious... can this same sort of thing happen with /proc/<tgid>/task if
that dir similarly has a lot of dentries?

...
> Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  v1->v2: Add new helper proc_pid_make_base_inode that performs the extra
> 	 work of adding to the pid->list.
>  v2->v3: Add performance regression in commit message.
>  v3->v4: Make proc_pid_make_base_inode() static
>  fs/proc/base.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c1031843cc6a..d884933950fd 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
...
> @@ -1931,6 +1926,27 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>  	return NULL;
>  }
>  
> +static struct inode *proc_pid_make_base_inode(struct super_block *sb,
> +				struct task_struct *task, umode_t mode)
> +{
> +	struct inode *inode;
> +	struct proc_inode *ei;
> +	struct pid *pid;
> +
> +	inode = proc_pid_make_inode(sb, task, mode);
> +	if (!inode)
> +		return NULL;
> +
> +	/* Let proc_flush_pid find this directory inode */
> +	ei = PROC_I(inode);
> +	pid = ei->pid;
> +	spin_lock(&pid->lock);
> +	hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
> +	spin_unlock(&pid->lock);
> +
> +	return inode;
> +}
> +

Somewhat related to the question above.. it would be nice if this
wrapper had a line or two comment above it that explained when it should
or shouldn't be used over the underlying function (for example, why or
why not include /proc/<tgid>/task?). Otherwise the patch overall seems
reasonable to me..

Brian

>  int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		struct kstat *stat, u32 request_mask, unsigned int query_flags)
>  {
> @@ -3350,7 +3366,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
>  {
>  	struct inode *inode;
>  
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
> +					 S_IFDIR | S_IRUGO | S_IXUGO);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> @@ -3649,7 +3666,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
>  	struct task_struct *task, const void *ptr)
>  {
>  	struct inode *inode;
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
> +					 S_IFDIR | S_IRUGO | S_IXUGO);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> -- 
> 2.31.1
> 

