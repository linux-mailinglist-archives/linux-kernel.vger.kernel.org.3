Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514A75AB662
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiIBQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiIBQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725AAC277
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CEDB6212E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350BC433C1;
        Fri,  2 Sep 2022 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662135424;
        bh=Yl0CvY2cQDQb6yeL6TcfJK7/w0lVfZxtsJZIiQXq0fo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LmBARlASMMFNtLL56hHrW9qMXLJF2LTMfWDy72+nXemQGz0G7X3gflzIbt4/coFwk
         M57KPCk2OcuCRqSRXzza5lgPJmFkzXKe1MnJ/KpfFpbSSwlcK8DtXpjNNc7nYQuz/i
         j5PJHfilgicicwOjdVQnRgtmolPdsnAa0xKYK8MY=
Date:   Fri, 2 Sep 2022 09:17:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        stable <stable@kernel.org>
Subject: Re: [PATCH] mm/damon/dbgfs: fix memory leak when using
 debugfs_lookup()
Message-Id: <20220902091703.dcee7737e7ce8857e3235fa7@linux-foundation.org>
In-Reply-To: <20220902125631.128329-1-gregkh@linuxfoundation.org>
References: <20220902125631.128329-1-gregkh@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Fri,  2 Sep 2022 14:56:31 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  Fix this up by properly
> calling dput().
> 
> ...
>

Fixes: 75c1c2b53c78b, I assume.

> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -915,6 +915,7 @@ static int dbgfs_rm_context(char *name)
>  		new_ctxs[j++] = dbgfs_ctxs[i];
>  	}
>  
> +	dput(dir);
>  	kfree(dbgfs_dirs);
>  	kfree(dbgfs_ctxs);
>  

dput() is also needed if either of the kmalloc_array() calls fail?
Maybe something like

--- a/mm/damon/dbgfs.c~a
+++ a/mm/damon/dbgfs.c
@@ -884,6 +884,7 @@ static int dbgfs_rm_context(char *name)
 	struct dentry *root, *dir, **new_dirs;
 	struct damon_ctx **new_ctxs;
 	int i, j;
+	int ret = 0;
 
 	if (damon_nr_running_ctxs())
 		return -EBUSY;
@@ -899,14 +900,12 @@ static int dbgfs_rm_context(char *name)
 	new_dirs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_dirs),
 			GFP_KERNEL);
 	if (!new_dirs)
-		return -ENOMEM;
+		goto out_dput;
 
 	new_ctxs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_ctxs),
 			GFP_KERNEL);
-	if (!new_ctxs) {
-		kfree(new_dirs);
-		return -ENOMEM;
-	}
+	if (!new_ctxs)
+		goto out_new_dirs;
 
 	for (i = 0, j = 0; i < dbgfs_nr_ctxs; i++) {
 		if (dbgfs_dirs[i] == dir) {
@@ -925,7 +924,13 @@ static int dbgfs_rm_context(char *name)
 	dbgfs_ctxs = new_ctxs;
 	dbgfs_nr_ctxs--;
 
-	return 0;
+	goto out_dput;
+
+out_new_dirs:
+	kfree(new_dirs);
+out_dput:
+	dput(dir);
+	return ret;
 }
 
 static ssize_t dbgfs_rm_context_write(struct file *file,
_

