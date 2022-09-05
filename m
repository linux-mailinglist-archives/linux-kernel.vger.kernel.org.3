Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6195AD34F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiIEM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiIEM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:58:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102721835
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:57:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k9so11310146wri.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sVX3iAMPHfNE9m948AyN7vtgEvv/ne7S2VCPHn9hPxw=;
        b=nXjsBdsvBFx7dVHjHIqIaw5qRuda38jMldXzdlhZj+7D5S7yYPMZxf/bhVMFtPA1Yi
         +az4K3aJ5oCIQS/Fv0qkALawWQiIw7X9CTcfw8rMzUi4754MN0QYOEPSurbf+yvdtsbe
         42lxVuzuSm6k2XeQNIfMOP68VLnWDLMo7Pwqav5TmkjCbPxGheDiUVb5H9a8iOJqHIBb
         zIbnpPftlX8QbWqnjbdgTYK8SNVUzUtZZAOJrQ4dHbwd6eiTD49cNqgWT5FE3dySPoOO
         rUrQwqWPBgYtncQUkjgg1r0jItlzDS3G3m5G3dc0CO2wqszcOttEQB6WoE1k7nqkSh3i
         Awdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sVX3iAMPHfNE9m948AyN7vtgEvv/ne7S2VCPHn9hPxw=;
        b=gI6MXF2ooO/VD3Azjf0vjph0WUv71pOCwS00PYhV375V9M5uDHtQukNusCFCjLyE6B
         PM92CyDZCJiuUjexUpUYeYEwp79Rv5QQnCf5YUvI9O5KBiTAsEBZGj2SdF9ixUDdYRkW
         GIKzj12UktDdaKs6rva2x6sdLlbp08yoYWpJ6feLQNbIRhkuHAYIY88cD/JU66rRKLZM
         dnR2MTOsL2JhkxWXfQYHB1s5g4RdyoBz/AbzUKBsrtYRFgPH+mlaYMeIU8DyaYp8G3a4
         ukSn5H5Hb2dEiesoq6wh4D42xLl2KqsK1W51F+NUscxBVmhnarhI+BCNq4cNa8dfP2s9
         8IhQ==
X-Gm-Message-State: ACgBeo199wu7eEkwYqn2aFqt8eyQG9g67rj7SLEWTejCvS/offyUxb5Q
        du1oMuHeI+v9LzRs6wfqy+EBLB0Qf/E+8g==
X-Google-Smtp-Source: AA6agR6Vaoz8In7nNSwx5DBxygsDb3tvzMbjqJ8pZdNHIGvJrOa4kL/d3FtqkhQt1z00rfIar7FBCw==
X-Received: by 2002:adf:d215:0:b0:228:6293:10ff with SMTP id j21-20020adfd215000000b00228629310ffmr5175300wrh.171.1662382676651;
        Mon, 05 Sep 2022 05:57:56 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:b57a:bbdd:c6f3:e092])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a32251c3f9sm18086051wmr.5.2022.09.05.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 05:57:55 -0700 (PDT)
Date:   Mon, 5 Sep 2022 14:57:50 +0200
From:   Marco Elver <elver@google.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counter
Message-ID: <YxXyThZanSl3wboo@elver.google.com>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905031012.4450-3-osalvador@suse.de>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:10AM +0200, Oscar Salvador wrote:
[...]
> +int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)

Can you add kernel-doc comment what this does (and also update
accordingly in 3/3 when you add 'threshold').

From what I see it prints *all* stacks that have a non-zero count.
Correct?

If so, should this be called stack_depot_print_all_count() (having
stack(s) in the name twice doesn't make it more obvious what it does)?
Then in the follow-up patch you add the 'threshold' arg.

> +{
> +	int i = *pos, ret = 0;
> +	struct stack_record **stacks, *stack;
> +	static struct stack_record *last = NULL;
> +	unsigned long stack_table_entries = stack_hash_mask + 1;
> +
> +	/* Continue from the last stack if we have one */
> +	if (last) {
> +		stack = last->next;

This is dead code?

> +	} else {
> +new_table:
> +		stacks = &stack_table[i];
> +		stack = (struct stack_record *)stacks;
> +	}
> +
> +	for (; stack; stack = stack->next) {
> +		if (!stack->size || stack->size < 0 ||
> +		    stack->size > size || stack->handle.valid != 1 ||
> +		    refcount_read(&stack->count) < 1)
> +			continue;
> +
> +		ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
> +		ret += scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
> +				 refcount_read(&stack->count));
> +		last = stack;
> +		return ret;
> +	}
> +
> +	i++;
> +	*pos = i;
> +	last = NULL;
> +
> +	/* Keep looking all tables for valid stacks */
> +	if (i < stack_table_entries)
> +		goto new_table;
> +
> +	return 0;
> +}

Either I'm missing something really obvious, but I was able to simplify
the above function to just this (untested!):

	int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
	{
		const unsigned long stack_table_entries = stack_hash_mask + 1;

		/* Iterate over all tables for valid stacks. */
		for (; *pos < stack_table_entries; (*pos)++) {
			for (struct stack_record *stack = stack_table[*pos]; stack; stack = stack->next) {
				if (!stack->size || stack->size < 0 || stack->size > size ||
				    stack->handle.valid != 1 || refcount_read(&stack->count) < 1)
					continue;

				return stack_trace_snprint(buf, size, stack->entries, stack->size, 0) +
				       scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
						 refcount_read(&stack->count));
			}
		}

		return 0;
	}

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 8730f377fa91..d88e6b4aefa0 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -664,6 +664,29 @@ static void init_early_allocated_pages(void)
>  		init_zones_in_node(pgdat);
>  }
>  
> +static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
> +				      size_t count, loff_t *pos)
> +{
> +	char *kbuf;
> +	int ret = 0;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	ret += stack_depot_print_stacks_threshold(kbuf, count, pos);

If I understood right, this will print *all* stacks that have non-zero
count, and this isn't related to page_owner per-se. Correct?

This might not be a problem right now, but once there might be more
users that want to count stack usage, you'll end up with page_owner +
other stacks here.
