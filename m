Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C24B027C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiBJB4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:56:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiBJBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:55:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3D2BB1E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46267B823D9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4E8C340E7;
        Thu, 10 Feb 2022 00:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644453205;
        bh=LvshK/blNNVzjkEFCNCcODobmLPbLezmfObyMz21JLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iXFPm4+XAR1cgGN6izstu1RlRZRLR4ZLvjOpqVKT2tdGSkKHtwvb5jbU9bx5eXVGR
         X7HPykgv7WpYJkKx3lYLX72T1YIFOM+Olv02Jcf53F8baw3xh/wowyrhv/nT34+SGI
         3gJ6Bpv+EaRwkFV3R0P0VfnzVpeGr4oStgMDDHFY=
Date:   Wed, 9 Feb 2022 16:33:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] mm: Fix UAF when anon vma name is used after vma is
 freed
Message-Id: <20220209163324.bbf26e7462b217d453c5a34f@linux-foundation.org>
In-Reply-To: <20220210001801.15413-1-surenb@google.com>
References: <20220210001801.15413-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Feb 2022 16:18:01 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> When adjacent vmas are being merged it can result in the vma that was
> originally passed to madvise_update_vma being destroyed. In the current
> implementation, the name parameter passed to madvise_update_vma points
> directly to vma->anon_name->name and it is used after the call to
> vma_merge. In the cases when vma_merge merges the original vma and
> destroys it, this will result in use-after-free bug as shown below:
> 
> madvise_vma_behavior << passes vma->anon_name->name as name param
>   madvise_update_vma(name)
>     vma_merge
>       __vma_adjust
>         vm_area_free <-- frees the vma
>     replace_vma_anon_name(name) <-- UAF
> 
> Fix this by passing madvise_update_vma a copy of the name.
> 
> ...
>
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2263,7 +2263,6 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  
>  #ifdef CONFIG_ANON_VMA_NAME
>  
> -#define ANON_VMA_NAME_MAX_LEN		80
>  #define ANON_VMA_NAME_INVALID_CHARS	"\\`$[]"
>  
>  static inline bool is_valid_name_char(char ch)
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 5604064df464..f36a5a9942d8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -976,6 +976,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  {
>  	int error;
>  	unsigned long new_flags = vma->vm_flags;
> +	char name_buf[ANON_VMA_NAME_MAX_LEN];
> +	const char *anon_name;
>  
>  	switch (behavior) {
>  	case MADV_REMOVE:
> @@ -1040,8 +1042,18 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  		break;
>  	}
>  
> +	anon_name = vma_anon_name(vma);
> +	if (anon_name) {
> +		/*
> +		 * Make a copy of the name because vma might be destroyed when
> +		 * merged with another one and the name parameter might be used
> +		 * after that.
> +		 */
> +		strcpy(name_buf, anon_name);
> +		anon_name = name_buf;
> +	}
>  	error = madvise_update_vma(vma, prev, start, end, new_flags,
> -				   vma_anon_name(vma));
> +				   anon_name);

anon_name is refcounted.  Why not use kref_get()/kref_put() instead of
taking a copy?

