Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE1501CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbiDNUqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiDNUqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:46:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2AED92E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B524B82762
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48DFC385A5;
        Thu, 14 Apr 2022 20:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649969017;
        bh=pg7qUZdxd9rKGnl8ewo2PzP6w1T6jlwI6CT52Cxs9dI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EfbN7CuumkY4po+UhvqGdXnRtzSvxQ3sPzxt3RlPeyZaMI0YVfUOdbdVzgpDfvnZr
         EWe8ynibbKkqFUKhw7Ek8iUgA/gtO8XvLz196hucwGxzR0WU/R+i0npEbpTliwWT8t
         pCVN7QddTCzyd10FiyyFcaF8dVSrVUA8dDThvsBo=
Date:   Thu, 14 Apr 2022 13:43:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmscan: fix comment for current_may_throttle
Message-Id: <20220414134335.f58a0e13fb2083180a164c1d@linux-foundation.org>
In-Reply-To: <20220414120202.30082-1-linmiaohe@huawei.com>
References: <20220414120202.30082-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 20:02:02 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Since commit 6d6435811c19 ("remove bdi_congested() and wb_congested() and
> related functions"), there is no congested backing device check anymore.
> Correct the comment accordingly.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2334,8 +2334,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
>  /*
>   * If a kernel thread (such as nfsd for loop-back mounts) services
>   * a backing device by writing to the page cache it sets PF_LOCAL_THROTTLE.
> - * In that case we should only throttle if the backing device it is
> - * writing to is congested.  In other cases it is safe to throttle.
> + * In that case we should not throttle it otherwise it is safe to do so.
>   */
>  static int current_may_throttle(void)
>  {

That's a bit awkward to read.  I tweaked it, and reflowed the comment
to 80 cols.

--- a/mm/vmscan.c~mm-vmscan-fix-comment-for-current_may_throttle-fix
+++ a/mm/vmscan.c
@@ -2332,9 +2332,9 @@ static unsigned int move_pages_to_lru(st
 }
 
 /*
- * If a kernel thread (such as nfsd for loop-back mounts) services
- * a backing device by writing to the page cache it sets PF_LOCAL_THROTTLE.
- * In that case we should not throttle it otherwise it is safe to do so.
+ * If a kernel thread (such as nfsd for loop-back mounts) services a backing
+ * device by writing to the page cache it sets PF_LOCAL_THROTTLE. In this case
+ * we should not throttle.  Otherwise it is safe to do so.
  */
 static int current_may_throttle(void)
 {
_

