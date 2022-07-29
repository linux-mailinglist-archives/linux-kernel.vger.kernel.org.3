Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD872585217
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiG2PIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiG2PIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:08:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A0980F5E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:08:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D83834179;
        Fri, 29 Jul 2022 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659107312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cHPQIB6zQDwcGtL276NpmzoSPq4JV+FEJd0yazhehc=;
        b=qxg01MO2yHUbuFhuXC8GxKwY03/nprCcVK+16yZnJawMOw4ADuMmgylbIT5ipEOFaYj68l
        ajxnl3gF8eytDOv29Bg18pUXEJcNNRbOwy9DENMSYug+51Gkk2xxwi2sI8nbDloR6kVLsC
        jP2o1Zy/oKOHBL8Gi86RZ6MKmk0hbx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659107312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cHPQIB6zQDwcGtL276NpmzoSPq4JV+FEJd0yazhehc=;
        b=UcQg6MB8qBcg7vTB/xVsUq9+KkBIhY4RGdXAr6P/TNOhdu5Gpsr/ce1E2JoQHoPqR5/WYY
        INdAwjURNsrnMyAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2BB213A1B;
        Fri, 29 Jul 2022 15:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I2iQOu/342ICdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Jul 2022 15:08:31 +0000
Message-ID: <e77f9820-c818-d7af-185b-b8814313048b@suse.cz>
Date:   Fri, 29 Jul 2022 17:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/15] common kmalloc v3
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 15:39, Hyeonggon Yoo wrote:
> This is v3 of common kmalloc series.
> 
> This series generalize most of kmalloc functions and move its
> implementation into mm/slab_common.c.
> 
> I believe this series give better maintainability of code for SLAB and SLUB.
> Please consider applying.
> 
> This series is based on slab/for-next and also available at
> https://github.com/hygoni/linux/tree/slab-common-v3r0
> 
> Any feedbacks/reviews will be appreciated.

Hi, thanks for all your efforts. It's shaping up nicely so I think the next
version will be ready to be added to -next after the 5.20 merge window.
As I've finished the individual reviews, I'm looking at the result and see a
bit more potential for cleanups, which could be perhaps incorporated to
existing patches, or additionally:

- kmalloc_large_node_notrace() has only one caller, can be removed and the
caller can call __kmalloc_large_node_notrace() directly, especially if it's
not __always_inline as I've IIRC suggested.

- kmem_cache_alloc_trace() and kmem_cache_alloc_node_trace() are weird ones,
they are in fact for kmalloc despite the name. They depend on
CONFIG_TRACING, yet if you look carefully, the !CONFIG_TRACING variant also
goes through a trace_* function. The actual difference seems that
slab_alloc() thus kasan_alloc() and kfence_alloc() don't get the orig_size
that way, which is dubious. It might be worth trying to unify this as well?
E.g.
  - use only the CONFIG_TRACING variant, discard the other
  - declare it in mm/slab.h, this is not for general usage
  - single implementation in mm/slab_common.c that calls
    __kmem_cache_alloc_node() from SLAB/SLUB and does the trace
