Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C64E7E06
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiCYULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiCYULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89603EB8B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8F961D09
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB724C2BBE4;
        Fri, 25 Mar 2022 20:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648238999;
        bh=U2Xz6H5GsLYeqmn4jr1ke0X4acjwp3OmRTeYeHGc3og=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qIvWa0w2vkbg7NoLId8mtNnMM2KFz4vLiIUfQGPDyBWmTYMleT201nxKQlnkIMfrD
         nMzYvJJdR3+8oDL0okhiKxooKLgd++ecqffLSx6MRPc2POnA6vOd6HPmJsnyGo46+g
         CvZEXq+gi2H1jYEGTW/Y4T4jf3pCD3rgs8OgCHqA=
Date:   Fri, 25 Mar 2022 13:09:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     david@redhat.com, yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn,
        yang.shi@linux.alibaba.com, dave.hansen@linux.intel.com,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v3] mm/vmstat: add events for ksm cow
Message-Id: <20220325130957.171a68dee88118082ab841c5@linux-foundation.org>
In-Reply-To: <20220324104332.2350482-1-yang.yang29@zte.com.cn>
References: <20220324104332.2350482-1-yang.yang29@zte.com.cn>
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

On Thu, 24 Mar 2022 10:43:33 +0000 cgel.zte@gmail.com wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> get to know how much memory ksm saved by reading
> /sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
> of ksm cow, and this is important of some delay sensitive tasks.
> 
> So add ksm cow events to help users evaluate whether or how to use ksm.

It's unclear (to me) how anyone will actually use this, how they will
interpret the output.

Some tutorial words added to Documentation/vm/ksm.rst would be helpful.
While in there, please check for any other /proc/vmstat fields which
we forgot to document.

> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -131,6 +131,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		SWAP_RA_HIT,
>  #ifdef CONFIG_KSM
>  		KSM_SWPIN_COPY,
> +		COW_KSM,

I agree that this name looks unpleasingly backwards.  Do we have an
expectation that we actually will be adding more COW_* fields?
