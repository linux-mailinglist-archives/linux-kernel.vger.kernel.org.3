Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6E4F1FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbiDDXNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350869AbiDDXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497591EAE0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D623D616C6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F070C2BBE4;
        Mon,  4 Apr 2022 22:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649112840;
        bh=qdF66H42BPEgvH1SOyYChQ8fvKv8/tr1wPWHNAXLe8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lQ+qVXCM3MvVO39DD3EqJUXPA/OLav4OqnGe3qPOZ3ChJerjjcwo6FuJ+X4ge0Jgq
         xrEs0YtKXLMUQQXuQ4QqX8snp6bGndn/oeEkGZUfUnoI5GJgCK7axYv3pKBr4av/80
         vmosjtQCFKTRsnspJ1/2iQ+w1jmWsxFJl0uKEsCY=
Date:   Mon, 4 Apr 2022 15:53:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/swapfile: unuse_pte can map random data if swap read
 fails
Message-Id: <20220404155359.d4867fb8717fe40b5a11647c@linux-foundation.org>
In-Reply-To: <20220401072926.45051-1-linmiaohe@huawei.com>
References: <20220401072926.45051-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 15:29:26 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> There is a bug in unuse_pte(): when swap page happens to be unreadable,
> page filled with random data is mapped into user address space. The fix
> is to check for PageUptodate and fail swapoff in case of error.
> 
> ...
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1795,6 +1795,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		ret = 0;
>  		goto out;
>  	}
> +	if (unlikely(!PageUptodate(page))) {
> +		ret = -EIO;
> +		goto out;
> +	}
>  
>  	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>  	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);

Failing the swapoff after -EIO seems a bit rude.  The user ends up with
a permanently mounted swap because a sector was bad?

That would be like failing truncate() or close() or umount after -EIO
on a regular file.  Somewhat.

Can we do something better?  Such as shooting down the page anyway and
permitting the swapoff to proceed?  Worst case, just leak the dang page
with an apologetic message.
