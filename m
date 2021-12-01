Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA05465335
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbhLAQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56280 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhLAQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:48:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 92A3ACE1FD0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED95C53FAD;
        Wed,  1 Dec 2021 16:44:55 +0000 (UTC)
Date:   Wed, 1 Dec 2021 11:44:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] cgroup: Trace event cgroup id fields should be u64
Message-ID: <20211201114453.6bbdb87c@gandalf.local.home>
In-Reply-To: <AF25430B-AE4E-443B-A231-3C93C6CD2901@oracle.com>
References: <20211201160746.726158-1-william.kucharski@oracle.com>
        <20211201111459.4ac7f84c@gandalf.local.home>
        <AF25430B-AE4E-443B-A231-3C93C6CD2901@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 16:27:54 +0000
William Kucharski <william.kucharski@oracle.com> wrote:

> I had pondered that as a consequence for two of the three uses but wasn't sure
> if it was worth reordering things; I can easily do so.
> 
> What do you suggest for cgroup_migrate as that will have a hole either way
> as it's:
> 
>         TP_STRUCT__entry(
>                 __field(        int,            dst_root                )
>                 __field(        u64,            dst_id                  )
>                 __field(        int,            dst_level               )
>                 __field(        int,            pid                     )
>                 __string(       dst_path,       path                    )
>                 __string(       comm,           task->comm              )
>         ),
> 
> if I put dst_level above dst_id, the int for pid field will leave a hole
> anyway because the string pointer for dst_path will want to be 64-bit
> aligned.
> 
> Thanks in advance.
> 

It's not actually a string pointer, both string() macros are really 4 byte
words. The above would be best compressed as:

         TP_STRUCT__entry(
                 __field(        int,            dst_root                )
                 __field(        int,            dst_level               )
                 __field(        u64,            dst_id                  )
                 __field(        int,            pid                     )
                 __string(       dst_path,       path                    )
                 __string(       comm,           task->comm              )
         ),

What that would turn into is:

	struct __entry {
		int		dst_root;
		int		dst_level;
		u64		dst_id;
		int		pid;
		int		dst_path_offset_size;
		int		comm_offset_size;
		char		strings[];
	}

Remember, this is used for storing data onto the ring buffer. I'll make up
two strings to show an example.

  dst_path = "/path/to/dst_path";
  comm = "bash";

The string(dst_path) and string(comm) would be where the data to find the
strings are. The strings will be stored in the strings[] field of the
structure, and the dst_path and comm fields will be used to find those
strings.

	dst_root = 1;
	dst_level = 2;
	dst_id = 3;
	pid = 4;

	dst_path = (28 << 16) | 18;
	comm = ((28 + 18) << 16 | 5;

	strings = "/path/to/dst_path\0bash\0";


The dst_path holds how to find the string it represents. It starts at
offset 28[*] (sizeof(int) * 5 + sizeof(u64))
And has size of 18 (strlen("/path/to/dst_path") + 1)

The comm string starts at offset 46 (28 + size of dst_path), and has he
size of 5 (strlen("bash") + 1).

So consider "string()" macros to be only 4 bytes in size. And leave the
"holes" at the end, especially if there's strings, because the will start
the actual strings nicely aligned.

-- Steve

[*] It really starts at a later offset, because there's common fields added
before the first field (common_type, common_flags, common_preempt_count,
common_pid) that is also included in that offset count.
