Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5134FDD25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352149AbiDLK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355763AbiDLKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492382314
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B214C617E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6226C385A5;
        Tue, 12 Apr 2022 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649756433;
        bh=jVAiChky5XX869hnpykLtLDYrh8c1aa/BDWMt3amk14=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g8d6E3SHmnIbwDRuBR0k95nVWyQ+FaHlxYfPG31jWnLLSolp05CdsBP9e9VpmBYRM
         4K+plM2+vmPAGGDIy89SkpCtCoQ/5AW2324yq2wX+hwKMT45FRslo8TCK0z6qPFsXu
         efFdZrGUb/fd+OQpIfZ8XP5dG+jR8yadnBc4PNMfP4iU+A8RrFdPePlYK93lsg0sZk
         7HCyXWDBtRLfP6cBrGEWdiwItYBcyp1N0dbjeXMH1WBe/CEOn0gJK524UOqSIEAbzW
         dpC4ITvNriWYnrx8wBxrTmNfIY92/jT4zJiXF0MlmdZtwHosy660VsV52GpMgdxJav
         RagKazrobyMag==
Message-ID: <4d54f494-b143-8885-a31e-924a83409e2d@kernel.org>
Date:   Tue, 12 Apr 2022 17:40:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] f2fs: use separate list iterator variable to call
 list_move_tail()
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331221650.891790-1-jakobkoschel@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220331221650.891790-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/1 6:16, Jakob Koschel wrote:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element
> [1].
> 
> If no break is hit or the list is empty, 'next' will be NULL and
> list_move_tail() should be called explicitly on the head directly.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   fs/f2fs/segment.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 22dfeb991529..81ef2c3d08e5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4175,16 +4175,20 @@ static void release_sit_entry_set(struct sit_entry_set *ses)
>   static void adjust_sit_entry_set(struct sit_entry_set *ses,
>   						struct list_head *head)
>   {
> -	struct sit_entry_set *next = ses;
> +	struct sit_entry_set *next = NULL, *iter = ses;
>   
>   	if (list_is_last(&ses->set_list, head))
>   		return;
>   
> -	list_for_each_entry_continue(next, head, set_list)
> -		if (ses->entry_cnt <= next->entry_cnt)
> +	list_for_each_entry_continue(iter, head, set_list)
> +		if (ses->entry_cnt <= iter->entry_cnt) {
> +			next = iter;
> +			list_move_tail(&ses->set_list, &iter->set_list);
>   			break;

return;

> +		}
>   
> -	list_move_tail(&ses->set_list, &next->set_list);
> +	if (!next)
> +		list_move_tail(&ses->set_list, head);

list_move_tail(&ses->set_list, head);

Then we don't need @next variable, right?

Thanks,

>   }
>   
>   static void add_sit_entry(unsigned int segno, struct list_head *head)
> 
> base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550
