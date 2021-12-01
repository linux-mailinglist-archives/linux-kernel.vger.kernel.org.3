Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD446520C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbhLAPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:51:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39422 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351108AbhLAPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:49:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6FE57CE1F9C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE453C53FAD;
        Wed,  1 Dec 2021 15:45:59 +0000 (UTC)
Date:   Wed, 1 Dec 2021 10:45:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Trace event cgroup id fields should be u64
Message-ID: <20211201104558.230196a7@gandalf.local.home>
In-Reply-To: <20211201144043.557470-1-william.kucharski@oracle.com>
References: <20211201144043.557470-1-william.kucharski@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Dec 2021 07:40:43 -0700
William Kucharski <william.kucharski@oracle.com> wrote:

> Various trace event fields that store cgroup IDs were declared
> as ints, but cgroup_id(() returns a u64 and the conversion was
> not intended.
> 
> Also remove extraneous spaces in fields that are no longer proper C style.

Um, actually, please do not do this!

> 
> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  include/trace/events/cgroup.h | 42 +++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
> index 7f42a3de59e6..a85b01aa1fff 100644
> --- a/include/trace/events/cgroup.h
> +++ b/include/trace/events/cgroup.h
> @@ -15,9 +15,9 @@ DECLARE_EVENT_CLASS(cgroup_root,
>  	TP_ARGS(root),
>  
>  	TP_STRUCT__entry(
> -		__field(	int,		root			)
> -		__field(	u16,		ss_mask			)
> -		__string(	name,		root->name		)
> +		__field(int, root)
> +		__field(u16, ss_mask)
> +		__string(name, root->name)

The spaces are there for a reason. These are special macros and not C code.
It's defining a structure, and the spacing is to imitate just that!

struct __entry {
	int		root;
	u16		ss_mask;
	name		root->name;
};


See the difference. You just made it less readable than the original.

So leave it alone.

NACK on the style changes.

-- Steve


>  	),
>  
>  	TP_fast_assign(
> @@ -58,10 +58,10 @@ DECLARE_EVENT_CLASS(cgroup,
>  	TP_ARGS(cgrp, path),
>  
>  	TP_STRUCT__entry(
> -		__field(	int,		root			)
> -		__field(	int,		id			)
> -		__field(	int,		level			)
> -		__string(	path,		path			)
> +		__field(int, root)
> +		__field(u64, id)
> +		__field(int, level)
> +		__string(path, path)
>  	),
>  
>  	TP_fast_assign(
> @@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(cgroup,
>  		__assign_str(path, path);
>  	),
>  
> -	TP_printk("root=%d id=%d level=%d path=%s",
> +	TP_printk("root=%d id=%llu level=%d path=%s",
>  		  __entry->root, __entry->id, __entry->level, __get_str(path))
>  );
>  
> @@ -125,12 +125,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>  	TP_ARGS(dst_cgrp, path, task, threadgroup),
>  
>  	TP_STRUCT__entry(
> -		__field(	int,		dst_root		)
> -		__field(	int,		dst_id			)
> -		__field(	int,		dst_level		)
> -		__field(	int,		pid			)
> -		__string(	dst_path,	path			)
> -		__string(	comm,		task->comm		)
> +		__field(int, dst_root)
> +		__field(u64, dst_id)
> +		__field(int, dst_level)
> +		__field(int, pid)
> +		__string(dst_path, path)
> +		__string(comm, task->comm)
>  	),
>  
>  	TP_fast_assign(
> @@ -142,7 +142,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>  		__assign_str(comm, task->comm);
>  	),
>  
> -	TP_printk("dst_root=%d dst_id=%d dst_level=%d dst_path=%s pid=%d comm=%s",
> +	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
>  		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
>  		  __get_str(dst_path), __entry->pid, __get_str(comm))
>  );
> @@ -170,11 +170,11 @@ DECLARE_EVENT_CLASS(cgroup_event,
>  	TP_ARGS(cgrp, path, val),
>  
>  	TP_STRUCT__entry(
> -		__field(	int,		root			)
> -		__field(	int,		id			)
> -		__field(	int,		level			)
> -		__string(	path,		path			)
> -		__field(	int,		val			)
> +		__field(int, root)
> +		__field(u64, id)
> +		__field(int, level)
> +		__string(path, path)
> +		__field(int, val)
>  	),
>  
>  	TP_fast_assign(
> @@ -185,7 +185,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
>  		__entry->val = val;
>  	),
>  
> -	TP_printk("root=%d id=%d level=%d path=%s val=%d",
> +	TP_printk("root=%d id=%llu level=%d path=%s val=%d",
>  		  __entry->root, __entry->id, __entry->level, __get_str(path),
>  		  __entry->val)
>  );

