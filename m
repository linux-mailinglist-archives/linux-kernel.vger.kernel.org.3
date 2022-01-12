Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBE48C3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353078AbiALML4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:11:56 -0500
Received: from out0.migadu.com ([94.23.1.103]:32716 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240575AbiALMLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:11:55 -0500
Date:   Wed, 12 Jan 2022 21:11:45 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641989512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuM9z/kOv66lQnlOHG6OsxdLRouFfUaxwKr3IxaFS1Y=;
        b=BLglUlONkt6HucRUVguqW3rFVa9/mFYhYDqnF+EeiP5x0Va4oyUxlikKiOrk2Sm4noS3tX
        VG4AHV5Lc6zN+5z1I4U2TvkNHmGmJf6AotLvBwOONRMvkwbikwLxB7Lf0obOxXzgEC6OED
        UCx8Q62rrwRIBK8D2Pn8mr7N3QQodtk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Youquan Song <youquan.song@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm/hwpoison: Fix error page recovered but reported "not
 recovered"
Message-ID: <20220112121145.GA889650@u2004>
References: <20220107194450.1687264-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220107194450.1687264-1-tony.luck@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:44:50AM -0800, Tony Luck wrote:
> From: Youquan Song <youquan.song@intel.com>
> 
> When an uncorrected memory error is consumed there is a race between
> the CMCI from the memory controller reporting an uncorrected error
> with a UCNA signature, and the core reporting and SRAR signature
> machine check when the data is about to be consumed.
> 
> If the CMCI wins that race, the page is marked poisoned when
> uc_decode_notifier() calls memory_failure() and the machine
> check processing code finds the page already poisoned. It calls
> kill_accessing_process() to make sure a SIGBUS is sent. But
> returns the wrong error code.
> 
> Console log looks like this:
> 
> [34775.674296] mce: Uncorrected hardware memory error in user-access at 3710b3400
> [34775.675413] Memory failure: 0x3710b3: recovery action for dirty LRU page: Recovered
> [34775.690310] Memory failure: 0x3710b3: already hardware poisoned
> [34775.696247] Memory failure: 0x3710b3: Sending SIGBUS to einj_mem_uc:361438 due to hardware memory corruption
> [34775.706072] mce: Memory error not recovered
> 
> Fix kill_accessing_process() to return -EHWPOISON to avoid the noise
> message "Memory error not recovered" and skip duplicate SIGBUS.
> 
> [Tony: Reworded some parts of commit message]
> 
> Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> This code is very subtle ... the fix makes the "not recovered" message
> go away ... but I'm not more than 75% confident that this is the right
> fix. Please check carefully :-)
> 
>  mm/memory-failure.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3a274468f193..a67f558b08ea 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -707,7 +707,8 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  	if (ret == 1 && priv.tk.addr)
>  		kill_proc(&priv.tk, pfn, flags);
>  	mmap_read_unlock(p->mm);
> -	return ret ? -EFAULT : -EHWPOISON;

Thank you for reporting, the original code was wrong and the trinary operation
returns opposite code.  -EHWPOISON here is to notify kill_me_maybe() that it
does not have to send SIGBUS in its own because kill_accessing_process() already
sent SIGBUS with proper virtual address info.

> +
> +	return (ret < 0) ? -EFAULT : -EHWPOISON;

It seems to me that this returns -EHWPOISON whether any hwpoison entry is
found or not, so this fix can cause another issue.
We want to return -EHWPOISON only when kill_accessing_process() sent SIGBUS,
so I think that the following diff should be what we want.
Could you check this fix works for you?

Thanks,
Naoya Horiguchi
---
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14ae5c18e776..4c9bd1d37301 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -707,8 +707,10 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 			      (void *)&priv);
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
+	else
+		ret = 0;
 	mmap_read_unlock(p->mm);
-	return ret ? -EFAULT : -EHWPOISON;
+	return ret > 0 ? -EHWPOISON : -EFAULT;
 }
 
 static const char *action_name[] = {
