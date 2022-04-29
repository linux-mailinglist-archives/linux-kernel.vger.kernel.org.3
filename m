Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53552514C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377101AbiD2OK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377081AbiD2OKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:10:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10988A7CF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:05:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58F541F892;
        Fri, 29 Apr 2022 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651241115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9TwSQbH6wqCBuThjrzdtxN2LipJZ90ZPvowEWzdp+g=;
        b=L2e1yaoYyEVDYzHX0UrQ3YFliIwmEyhjL5+/bnJJUo1VCQ29dnAPTuZyp2gP7iqwJu8qoy
        ZkRPsXqD8ERWszn7TBVHUh2ejwzSVD0k26xC78zxTgg524wF9z6y+UwLS7P8qrH4EvxGco
        VOZGlycfuhzYXCb4uHEkJ4b4j8eX1K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651241115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9TwSQbH6wqCBuThjrzdtxN2LipJZ90ZPvowEWzdp+g=;
        b=MyAYPB2YFXeOxlUJ9UumhIPtf7PoNkqoqfscD1y9rpG736YCz7DQMYtVSr2KmU9mTUGTJn
        qbIuVb77XWNgj9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B62113AE0;
        Fri, 29 Apr 2022 14:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nhQiApvwa2IBDQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Apr 2022 14:05:15 +0000
Message-ID: <bbb97e3c-e597-dd6e-e213-55bc1779d901@suse.cz>
Date:   Fri, 29 Apr 2022 16:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-15-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 14/23] mm/slab_common: print cache name in tracepoints
In-Reply-To: <20220414085727.643099-15-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> Print cache name in tracepoints. If there is no corresponding cache
> (kmalloc in SLOB or kmalloc_large_node), use KMALLOC_{,LARGE_}NAME
> macro.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Regarding tracepoints, I'm not sure it's a good idea to unify kmalloc and
kmem_cache_alloc. I think the common use case is to trace kmalloc as there
are many different callers, and then I'm not interested in kmem_cache_alloc
callers much.

What I would suggest instead is:
- drop the _node versions, add node to normal versions
- drop the kmem_alloc EVENT_CLASS, as kmalloc is different enough from
kmem_cache_alloc (see next points), define separately as TRACE_EVENT().
- printing cache_name makes sense to add for kmem_cache_alloc (also allows
filtering events) but not for kmalloc.
- kmem_cache_alloc with name can then drop the bytes_req, bytes_alloc as
they are fixed for given name (and can be read from slabinfo).

Not using a common tracepoint will prevent some later unifications/cleanup
(patch 21?), but hopefully not too much?
