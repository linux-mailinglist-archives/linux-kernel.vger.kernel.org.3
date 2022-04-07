Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5314F7C33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbiDGJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiDGJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:55:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056363FDA3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:53:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B81DC1F85A;
        Thu,  7 Apr 2022 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649325199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPQS79sLVrqFV4XwaFnDTVXqxw7hzvbSqQxSioBUTSM=;
        b=UNkpZDhavaEbb5JfrjpFroKXXXDEDsSgR8vFFoY0JLrW0/Do7ez5AkoMLmG7gluCoMSyPU
        gyAATZ1IegsJtXwkfqe9sONOAPBQt4cE/WwpINwm375QeuVzYK8PmHH92tSDWlzbkdDKPW
        4ZjtSJBohR070tX+DMV7kGBIExBJy0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649325199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPQS79sLVrqFV4XwaFnDTVXqxw7hzvbSqQxSioBUTSM=;
        b=279NkjqMDoHO5lz9hQarb6pWOcBkq4pz8Zwgl5Nzmo3SD8n7mRCK6LFdbZ8JVFwX7y4+IY
        tYfa68aifNfo5KCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A144C13485;
        Thu,  7 Apr 2022 09:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XgOtJo+0TmJYOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Apr 2022 09:53:19 +0000
Message-ID: <78a1ecd4-95a2-bd72-8be7-433db21364bd@suse.cz>
Date:   Thu, 7 Apr 2022 11:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] mm/page_alloc: add same penalty is enough to get
 round-robin order
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>
References: <20220123013537.20491-1-richard.weiyang@gmail.com>
 <c56564cd-87f0-25c8-bb78-2bb8d8ad2655@suse.cz>
 <20220406234754.4vpi5sjztcsusqiq@master>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220406234754.4vpi5sjztcsusqiq@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 01:47, Wei Yang wrote:
> On Tue, Apr 05, 2022 at 07:11:12PM +0200, Vlastimil Babka wrote:
>>On 1/23/22 02:35, Wei Yang wrote:
>>> To make node order in round-robin in the same distance group, we add a
>>> penalty to the first node we got in each round.
>>> 
>>> To get a round-robin order in the same distance group, we don't need to
>>> decrease the penalty since:
>>> 
>>>   * find_next_best_node() always iterates node in the same order
>>>   * distance matters more then penalty in find_next_best_node()
>>>   * in nodes with the same distance, the first one would be picked up
>>> 
>>> So it is fine to increase same penalty when we get the first node in the
>>> same distance group.
>>
>>With that logic I'm not even sure if we need nr_online_nodes as penalty or
>>it could be just 1. Would you know?
> 
> Yes, it has the same effect.

Good.

> [    0.031849] Fallback order for Node 0: 0 1 2 3 4 5 6 7
> [    0.031854] Fallback order for Node 1: 1 2 3 0 5 6 7 4
> [    0.031857] Fallback order for Node 2: 2 3 0 1 6 7 4 5
> [    0.031860] Fallback order for Node 3: 3 0 1 2 7 4 5 6
> [    0.031864] Fallback order for Node 4: 4 5 6 7 0 1 2 3
> [    0.031867] Fallback order for Node 5: 5 6 7 4 1 2 3 0
> [    0.031870] Fallback order for Node 6: 6 7 4 5 2 3 0 1
> [    0.031873] Fallback order for Node 7: 7 4 5 6 3 0 1 2
> 
> Do you prefer to set it to 1?

Yeah I think it's worth simplyfing as much as feasible, so the code is more
obvious. I think we can also then remove the MAX_NODE_LOAD #define and usage.

Also please Cc at least Oscar and David (added to Cc now) on v2 as they have
been active in memory hotplug area recently.

Thanks,
Vlastimil
