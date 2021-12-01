Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B299E46529C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351495AbhLAQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:19:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48856 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351596AbhLAQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:18:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3AD0DCE1F99
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8E9C53FCC;
        Wed,  1 Dec 2021 16:15:01 +0000 (UTC)
Date:   Wed, 1 Dec 2021 11:14:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] cgroup: Trace event cgroup id fields should be u64
Message-ID: <20211201111459.4ac7f84c@gandalf.local.home>
In-Reply-To: <20211201160746.726158-1-william.kucharski@oracle.com>
References: <20211201160746.726158-1-william.kucharski@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Dec 2021 09:07:46 -0700
William Kucharski <william.kucharski@oracle.com> wrote:

> Various trace event fields that store cgroup IDs were declared as
> ints, but cgroup_id(() returns a u64 and the structures and associated
> TP_printk() calls were not updated to reflect this.
> 
> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> ---
> V2: Do not remove spaces from macro arguments
> 
>  include/trace/events/cgroup.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
> index 7f42a3de59e6..1b68c842ac46 100644
> --- a/include/trace/events/cgroup.h
> +++ b/include/trace/events/cgroup.h
> @@ -59,7 +59,7 @@ DECLARE_EVENT_CLASS(cgroup,
>  
>  	TP_STRUCT__entry(
>  		__field(	int,		root			)
> -		__field(	int,		id			)
> +		__field(	u64,		id			)
>  		__field(	int,		level			)

It's best to move them around to prevent holes. This is not a packed
structure, and the above will create a structure on the ring buffer that
looks like:

	int		root;
	u64		id;
	int		level;
	short		path_offset;
	short		path_size;

(the string() macro is a 4 byte word where the half is the offset of the
actual string and the other half is the size of the string).

Having a 8 byte word between two 4 byte words, will add a 4 byte padding
after the first 4 byte word (before the 8 byte word), and waste space on
the ring buffer.

Better to move it around to be:

  	TP_STRUCT__entry(
  		__field(	int,		root			)
  		__field(	int,		level			)
		__field(	u64,		id			)

That way the two 4 byte words will be together followed directly by the 8
byte word.

>  		__string(	path,		path			)
>  	),
> @@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(cgroup,
>  		__assign_str(path, path);
>  	),
>  
> -	TP_printk("root=%d id=%d level=%d path=%s",
> +	TP_printk("root=%d id=%llu level=%d path=%s",
>  		  __entry->root, __entry->id, __entry->level, __get_str(path))
>  );
>  
> @@ -126,7 +126,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>  
>  	TP_STRUCT__entry(
>  		__field(	int,		dst_root		)
> -		__field(	int,		dst_id			)
> +		__field(	u64,		dst_id			)

Same here. Just move dst_level above dst_id.

>  		__field(	int,		dst_level		)
>  		__field(	int,		pid			)
>  		__string(	dst_path,	path			)
> @@ -142,7 +142,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>  		__assign_str(comm, task->comm);
>  	),
>  
> -	TP_printk("dst_root=%d dst_id=%d dst_level=%d dst_path=%s pid=%d comm=%s",
> +	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
>  		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
>  		  __get_str(dst_path), __entry->pid, __get_str(comm))
>  );
> @@ -171,7 +171,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
>  
>  	TP_STRUCT__entry(
>  		__field(	int,		root			)
> -		__field(	int,		id			)
> +		__field(	u64,		id			)

And here.

>  		__field(	int,		level			)
>  		__string(	path,		path			)
>  		__field(	int,		val			)
> @@ -185,7 +185,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
>  		__entry->val = val;
>  	),
>  
> -	TP_printk("root=%d id=%d level=%d path=%s val=%d",
> +	TP_printk("root=%d id=%llu level=%d path=%s val=%d",
>  		  __entry->root, __entry->id, __entry->level, __get_str(path),
>  		  __entry->val)
>  );



-- Steve
