Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53759E99D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiHWR2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiHWR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:26:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26517E019
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:04:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 079B7224F7;
        Tue, 23 Aug 2022 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661267077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cFTANejxhxOSG7GTBTGu700vzKAak6B7yGbxdS2/DM=;
        b=T0QqjOFd6oBtVDCJkYSzOLQRe6QHGWtLNxQvRrFFBYsHzTzAKJ811NnNnyX44eWA1Tdteg
        nq7/BFoRbN607DXjU52WByzmeZZ1Bo9Lu327AgLI2iKfEEBek9H45OqBEwub79AkHeXO46
        MydiT33+5SZz8ug2T36dwoM+IV1KDuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661267077;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cFTANejxhxOSG7GTBTGu700vzKAak6B7yGbxdS2/DM=;
        b=4cI74gBerp3rnvYEfNWoymhgI7UP9NAjzkmBXU9ebY5cEDQtAXjRUAVS58p3pGExh1+CSW
        WoZDn2xhu0qUaMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6FEF13A89;
        Tue, 23 Aug 2022 15:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z5+2L4TsBGPCEgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Aug 2022 15:04:36 +0000
Message-ID: <df514b30-3a9a-679e-1851-7589526960a1@suse.cz>
Date:   Tue, 23 Aug 2022 17:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 13/17] mm/sl[au]b: cleanup
 kmem_cache_alloc[_node]_trace()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-14-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220817101826.236819-14-42.hyeyoo@gmail.com>
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

On 8/17/22 12:18, Hyeonggon Yoo wrote:
> This patch does:

I've removed this line locally and re-idented the rest.

> 	- Despite its name, kmem_cache_alloc[_node]_trace() is hook for
> 	  inlined kmalloc. So rename it to kmalloc[_node]_trace().
> 
> 	- Move its implementation to slab_common.c by using
>           __kmem_cache_alloc_node(), but keep CONFIG_TRACING=n varients to
> 	  save a function call when CONFIG_TRACING=n.
> 
> 	- Use __assume_kmalloc_alignment for kmalloc[_node]_trace
> 	  instead of __assume_slab_alignement. Generally kmalloc has
> 	  larger alignment requirements.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

