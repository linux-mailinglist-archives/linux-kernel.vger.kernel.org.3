Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4B510A98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355069AbiDZUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355047AbiDZUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:37:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA01A8C10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C67AB82325
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB7C385A0;
        Tue, 26 Apr 2022 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651005242;
        bh=1nLv2uonWidEFj1pcSTMshyTONddZm1b5bjnp+01fFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gf0gHdt2okkMpp8c3Tx2/ENbPLTud5mAngEc563OHINdGlX00/CeEy71BKhr5D90G
         RVheA6Z6zLvlXxnCmGuoIWUPr0FbXthZk67HezG33K0HZY7ZRy/J3qJoUWlSdqGUs/
         7trds2YehtZeWFn+DTjtjNLZSzjGuplwtaWt1Xh0=
Date:   Tue, 26 Apr 2022 13:34:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     liusongtang <liusongtang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <young.liuyang@huawei.com>,
        <wangkefeng@huawei.com>
Subject: Re: [PATCH] mm/mprotect: reduce Committed_AS if memory protection
 is changed to PROT_NONE
Message-Id: <20220426133401.9404190c5a5c6ff58b694c59@linux-foundation.org>
In-Reply-To: <20220426112705.3323-1-liusongtang@huawei.com>
References: <20220426112705.3323-1-liusongtang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 19:27:05 +0800 liusongtang <liusongtang@huawei.com> wrote:

> If PROT_WRITE is set, the size of vm area will be added to Committed_AS.
> However, if memory protection is changed to PROT_NONE,
> the corresponding physical memory will not be used, but Committed_AS still
> count the size of the PROT_NONE memory.
> 
> This patch reduce Committed_AS and free the corresponding memory if
> memory protection is changed to PROT_NONE.
> 
> ...
>
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -497,6 +497,12 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>  	}
>  
>  success:
> +	if ((newflags & (VM_READ | VM_WRITE | VM_EXEC | VM_LOCKED | VM_ACCOUNT)) == VM_ACCOUNT) {
> +		zap_page_range(vma, start, end - start);
> +		newflags &= ~VM_ACCOUNT;
> +		vm_unacct_memory((end - start) >> PAGE_SHIFT);
> +	}
> +
>  	/*
>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>  	 * held in write mode.

Surprised.  If userspace does mprotect(addr, len.  PROT_NONE) then
mprotect(addr, len.  PROT_READ), what is now at *addr?  Zeroes?
