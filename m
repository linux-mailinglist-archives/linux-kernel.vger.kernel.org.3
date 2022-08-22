Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94959B9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiHVHA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiHVHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:00:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B971CFE3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:00:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1258D5C869;
        Mon, 22 Aug 2022 07:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661151634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5FqNMURrzSr65e1qd0Drb+fJqBgQJf99xfHlmHtTTg=;
        b=XcZ9XpuJEuCXQcr83vTsHnJytYeZiKe/7Ek4mPrLg4ix9YljzfvrRCSD2FQ0K6DdAm0c6h
        Qku+UVgdTbHckFPKxlf/H0yBH8QVQtfNrpZ80TB0Rf8E4qTN5kIIvXc9V6nurvzY1lp/4J
        bc8xlLQ+fJ0kEaypLV6Irsr3VThepCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661151634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5FqNMURrzSr65e1qd0Drb+fJqBgQJf99xfHlmHtTTg=;
        b=jalAuDnSXzGnvJgbSmpBBo26JP4ei8CB3TIGFlHQj9rk/RM2yKCNEbv2LjbigQTh4nYmnp
        3drJZKSxSKLtF1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3F4113523;
        Mon, 22 Aug 2022 07:00:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O3j2MpEpA2NoFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 22 Aug 2022 07:00:33 +0000
Message-ID: <fd6b2e3a-2cb3-5ba2-f376-8c3c5f8e8306@suse.cz>
Date:   Mon, 22 Aug 2022 09:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] page_ext: move up page_ext_init() to catch early page
 allocation if DEFERRED_STRUCT_PAGE_INIT is n
To:     lizhe.67@bytedance.com, mhocko@suse.com
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, mark-pk.tsai@mediatek.com,
        mhiramat@kernel.org, rostedt@goodmis.org, yuanzhu@bytedance.com
References: <Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz>
 <20220820010257.11488-1-lizhe.67@bytedance.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220820010257.11488-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 03:02, lizhe.67@bytedance.com wrote:
> On 2022-08-18 7:36 UTC, mhocko@suse.com wrote:
>>> From: Li Zhe <lizhe.67@bytedance.com>
>>> 
>>> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>>> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>>> problem. It seems that we cannot track early page allocations in current
>>> kernel even if page structure has been initialized early.
>>> 
>>> This patch move up page_ext_init() to catch early page allocations when
>>> DEFERRED_STRUCT_PAGE_INIT is n. After this patch, we only need to turn
>>> DEFERRED_STRUCT_PAGE_INIT to n then we are able to analyze the early page
>>> allocations. This is useful especially when we find that the free memory
>>> value is not the same right after different kernel booting.
>>
>>is this actually useful in practice? I mean who is going to disable
>>DEFERRED_STRUCT_PAGE_INIT and recompile the kernel for debugging early
>>allocations?
> 
> Yes it is useful. We use this method to catch the difference of early
> page allocations between two kernel.
> 
>> I do see how debugging those early allocations might be useful but that
>> would require a boot time option to be practical IMHO. Would it make
>> sense to add a early_page_ext parameter which would essentially disable
>> the deferred ipage initialization. That should be quite trivial to
>> achieve (just hook into defer_init AFAICS).
> 
> It is a good idea. A cmdline parameter is a flexible and dynamic method for
> us to decide whether to defer page's and page_ext's initilization. For
> comparison, this patch provides a static method to decide whether to defer
> page's and page_ext's initilization. They are not conflicting. My next
> work is trying to achieve your idea.

As we already have to pass page_owner=on parameter to enable the page
allocation tracking in the first place, maybe that alone could also disable
deffered init, and no need for another parameter?

> --
> Li Zhe

