Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21C50066E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiDNGxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 02:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiDNGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:53:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA54505F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 23:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38AABCE2897
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50978C385A1;
        Thu, 14 Apr 2022 06:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649919052;
        bh=cYbubK9AB57IFaxLKwKzOx65Ex6FmM9jG7A94onuncM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SCpkEhdDMNx5PuGypTqsLr6YhwAlVEb7wjTyEeJL92fkhiZipeCeD3RQhGJv2rA5Q
         TgduuJjGeTOoUK1jilZd+XvUvcsctqYVq9kds3qkbRtKeI4TfI+nac6amNyV9Vs8NQ
         yB+q+ZdF0snVRJsZYWo4tiXIvV2LVBYYQiM+LswE=
Date:   Wed, 13 Apr 2022 23:50:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>, Yu Zhao <yuzhao@google.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Message-Id: <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 14:35:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Please add this patch set to your branch.  They are based on v5.18-rc1.

Do we get a nice [0/n] cover letter telling us all about this?

I have that all merged up and it compiles.

https://lkml.kernel.org/r/20220402094550.129-1-lipeifeng@oppo.com and
https://lkml.kernel.org/r/20220412081014.399-1-lipeifeng@oppo.com are
disabled for now.


Several patches were marked

From: Liam
Signed-off-by: Matthew
Signed-off-by: Liam

Which makes me wonder whether the attribution was correct.  Please
double-check.



I made a lame attempt to fix up mglru's get_next_vma(), and it probably
wants a revisit in the maple-tree world anyway.  Please check this and
send me a better version ;)

--- a/mm/vmscan.c~mglru-vs-maple-tree
+++ a/mm/vmscan.c
@@ -3704,7 +3704,7 @@ static bool get_next_vma(struct mm_walk
 
 	while (walk->vma) {
 		if (next >= walk->vma->vm_end) {
-			walk->vma = walk->vma->vm_next;
+			walk->vma = find_vma(walk->mm, walk->vma->vm_end);
 			continue;
 		}
 
@@ -3712,7 +3712,7 @@ static bool get_next_vma(struct mm_walk
 			return false;
 
 		if (should_skip_vma(walk->vma->vm_start, walk->vma->vm_end, walk)) {
-			walk->vma = walk->vma->vm_next;
+			walk->vma = find_vma(walk->mm, walk->vma->vm_end);
 			continue;
 		}
 
@@ -4062,7 +4062,7 @@ static void walk_mm(struct lruvec *lruve
 		/* the caller might be holding the lock for write */
 		if (mmap_read_trylock(mm)) {
 			unsigned long start = walk->next_addr;
-			unsigned long end = mm->highest_vm_end;
+			unsigned long end = TASK_SIZE;
 
 			err = walk_page_range(mm, start, end, &mm_walk_ops, walk);
 


I flung a tree up at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mmtemp containing
mglru and mapletree and a few other things.  Could the mglru and
mapletree people please runtime test it, send any fixes?

