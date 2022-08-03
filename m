Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4D58852A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiHCAqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiHCAqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:46:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C373C8DF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4DD5B810B0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD1C433C1;
        Wed,  3 Aug 2022 00:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659487598;
        bh=IYPfZV8Mr5MahS8LdQC+lkEFagmnqzDuiBAPlmClaKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SPb3Z3sfcbdOAZbQhAKbGIlSRYS1+7dZ5/2YF2m8v5qtQNT089kYHC9huOuSN/tCK
         iM59/Nm+lZoWC15GA2Vuz771vuIwJBFssBhAzLTafBBeFaA7+4xvIpE8KCjXN0uKbK
         09J2oXDiukZQIfc6LzzeIpiKPLPxLQtZyHkyhgFw=
Date:   Tue, 2 Aug 2022 17:46:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem: Update folio if shmem_replace_page() updates the
 page
Message-Id: <20220802174637.3bd3478d137b52ef3b67c3b3@linux-foundation.org>
In-Reply-To: <20220730042518.1264767-1-willy@infradead.org>
References: <20220730042518.1264767-1-willy@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2022 05:25:18 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> If we allocate a new page, we need to make sure that our folio matches
> that new page.  This will be solved by changing shmem_replace_page()
> to shmem_replace_folio(), but this is the minimal fix.
> 
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1771,6 +1771,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  
>  	if (shmem_should_replace_folio(folio, gfp)) {
>  		error = shmem_replace_page(&page, gfp, info, index);
> +		folio = page_folio(page);
>  		if (error)
>  			goto failed;
>  	}

What are the user-visible runtime effects of the bug?

Should we backport this into 5.19.X?
