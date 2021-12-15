Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC6474EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhLNXve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:51:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238349AbhLNXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639525893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9NYbUOPUcxZkyHEXoKyTmUjVaSYf8j6Q3vRWjuqyAM=;
        b=Z9CY6T1i984irK89OkTZAVinu2BS0R/v6gktextMEbDHH+unkxaGHOI1TbkptVwy3SN6iG
        N0rx6HzmDUT2byIxt9uNy01q6hJ2y5G6KCuQKOos4ljMC0r4oq41UV06GiobeoropLfDX0
        8+y7WoBIFpkg+9QVoZkfvMviZdnApgE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-eqY_7KehNXSsEz_IhStEiw-1; Tue, 14 Dec 2021 18:51:32 -0500
X-MC-Unique: eqY_7KehNXSsEz_IhStEiw-1
Received: by mail-oi1-f198.google.com with SMTP id y21-20020aca4b15000000b002a819a3cd6dso13539032oia.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K9NYbUOPUcxZkyHEXoKyTmUjVaSYf8j6Q3vRWjuqyAM=;
        b=Y8E4nE94cK3RWZ6wekgcLUBbI38XWVrqTBIftuHOg1zJZ7W6x2SkNAouf5bGPH4tAU
         kkRqgBn4ix1jfKjJlqypt8sO5dhlICgtC1SIzuzDWJ22KCo06Uj8JwhLE3p4CxZNXpFI
         mTm2Tb7iMZukIR7semH+sw3d1McKt/hEqP8FUpHMt3BUifmaYWb8VDh+rzBkQqzlrVri
         miUgEFwHNzmhZ/qVq0pZwWorSGxEmLG7Kk6GWUlLi3T+G/cJrOuFD/egV/HXaj+sEjtu
         NsJx7yP/gHiLac3nADjLV+t4f9yQF+QHwcJspbfoR0viLffxasLY3so8O6vthL0PkfY3
         FZew==
X-Gm-Message-State: AOAM532frGUwAfNNG0RlO85ZdnZrgYvulIQEqD2j3Kbg5BkhTaLU71hl
        ie1cF0zjUDdoni/pbQ/XwLZirGW4uZnwPx5JqW6o38qeMx5LnilERzBg4HYeeWYqrEBoa+qb7eg
        GD9Ls1f8veQFutT0+xsoin9dn
X-Received: by 2002:a05:6830:1e8f:: with SMTP id n15mr6570241otr.259.1639525891791;
        Tue, 14 Dec 2021 15:51:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcprLwQPPJ/LrIGdx4P9HpCKGnM8goXoz4U3AqX5HlXIN9hbQ8W757KpIkChZSmqCzdIM2fQ==
X-Received: by 2002:a05:6830:1e8f:: with SMTP id n15mr6570217otr.259.1639525891491;
        Tue, 14 Dec 2021 15:51:31 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id p14sm88078oou.31.2021.12.14.15.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 15:51:31 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:51:28 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Vernet <void@manifault.com>
Cc:     pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, corbet@lwn.net, songliubraving@fb.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] livepatch: Fix leak on klp_init_patch_early failure
 path
Message-ID: <20211214235128.ckaozqsvcr6iqcnu@treble>
References: <20211214220124.2911264-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214220124.2911264-1-void@manifault.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 02:01:26PM -0800, David Vernet wrote:
> When enabling a klp patch with klp_enable_patch(), klp_init_patch_early()
> is invoked to initialize the kobjects for the patch itself, as well as the
> 'struct klp_object' and 'struct klp_func' objects that comprise it.
> However, there are some error paths in klp_enable_patch() where some
> kobjects may have been initialized with kobject_init(), but an error code
> is still returned due to e.g. a 'struct klp_object' having a NULL funcs
> pointer.
> 
> In these paths, the kobject of the 'struct klp_patch' may be leaked, along
> with one or more of its objects and their functions, as kobject_put() is
> not invoked on the cleanup path if klp_init_patch_early() returns an error
> code.
> 
> For example, if an object entry such as the following were added to the
> sample livepatch module's klp patch, it would cause the vmlinux klp_object,
> and its klp_func which updates 'cmdline_proc_show', to be leaked:
> 
> static struct klp_object objs[] = {
> 	{
> 		/* name being NULL means vmlinux */
> 		.funcs = funcs,
> 	},
> 	{
> 		.name = "kvm",
> 		/* NULL funcs -- would cause leak */
> 	}, { }
> };
> 
> Without this change, if CONFIG_DEBUG_KOBJECT is enabled, and the sample klp
> patch is loaded, the kobjects (the patch, the vmlinux 'struct klp_obj', and
> its func) are not observed to be released in the dmesg log output.  With
> the change, the kobjects are observed to be released.

This looks much better, thanks.

> Signed-off-by: David Vernet <void@manifault.com>
> ---
> v2:
>   - Move try_module_get() and the patch->objs NULL check out of
>     klp_init_patch_early() to ensure that it's safe to jump to the 'err' label
>     on the error path in klp_enable_patch().
>   - Fix the patch description to not use markdown, and to use imperative
>     language.

Looking good overall.

Though, klp_init_patch_early() still has a failure mode which looks a
little sketchy:

	klp_for_each_object_static(patch, obj) {
		if (!obj->funcs)
			return -EINVAL;

		klp_init_object_early(patch, obj);

		klp_for_each_func_static(obj, func) {
			klp_init_func_early(obj, func);
		}
	}


While I don't see any actual leaks associated with it, it'd be cleaner
and more robust to move the per-object !obj->funcs check to the top of
klp_enable_patch(), with the other EINVAL checks.  Like:


int klp_enable_patch(struct klp_patch *patch)
{
	struct klp_object *obj;
	int ret;

	if (!patch || !patch->mod || !patch->objs)
		return -EINVAL;

	klp_for_each_object_static(patch, obj) {
		if (!obj->funcs)
			return -EINVAL;
	}


Then klp_init_patch_early() can be changed to return void, and we can
more easily convince ourselves there aren't any remaining leaks.

-- 
Josh

