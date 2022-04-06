Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26CB4F5E80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiDFMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiDFMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:54:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259FD1DF644
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:55:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 547011F7AC;
        Wed,  6 Apr 2022 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649235342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QO0Y8UZBC0+bYJouZVh23+IhfwEOZuUtdQE1ESyBkMA=;
        b=NwU4C2e4Tn+oq/IPcFXOrXRJBPQor8IFoJW0eB49i2InkSAeDxJCveQInjCvigk6eIDOe2
        b+zWTvF+CO3H8S0NfrMV/qoUDM/amMK9GGotK5SRmXtwF4scBAEe97K7LpjW8dGKTJsXpg
        m7G+BRlWsXL9xKuRudEnb/xnDLmhdQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649235342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QO0Y8UZBC0+bYJouZVh23+IhfwEOZuUtdQE1ESyBkMA=;
        b=i1cRPUCsyUax9UIgUcTNp9pDge2UDw8eo9QCFVxn1HZQAtYOzk5H3WawFOhtD0cRfD8Jxe
        3ox4g6EA7xktCRDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F6EF139F5;
        Wed,  6 Apr 2022 08:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZgnxBo5VTWLbdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 06 Apr 2022 08:55:42 +0000
Message-ID: <9dfab603-5cc7-0e7d-50c3-c21bdb8598ca@suse.cz>
Date:   Wed, 6 Apr 2022 10:55:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/6] lib/stackdepot: allow requesting early
 initialization dynamically
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
References: <20220404164112.18372-1-vbabka@suse.cz>
 <20220404164112.18372-2-vbabka@suse.cz>
 <8a13e52b-f4ff-4fd9-1f8a-fdea3868bc1@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8a13e52b-f4ff-4fd9-1f8a-fdea3868bc1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 23:40, David Rientjes wrote:
> On Mon, 4 Apr 2022, Vlastimil Babka wrote:
>> +int __init stack_depot_early_init(void)
>> +{
>> +	size_t size;
>> +
>> +	/* This is supposed to be called only once, from mm_init() */
>> +	if (WARN_ON(__stack_depot_early_init_passed))
>> +		return 0;
>> +
>> +	__stack_depot_early_init_passed = true;
>> +
>> +	if (!__stack_depot_want_early_init || stack_depot_disable)
>> +		return 0;
>> +
>> +	pr_info("Stack Depot early init allocating hash table with memblock_alloc\n");
>> +	size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> 
> I think the kvcalloc() in the main init path is very unlikely to fail, but 
> perhaps this memblock_alloc() might?  If so, a nit might be to include 
> this size as part of the printk.

OK, added the hunk at the end of mail. Example:

[0.062264] Stack Depot early init allocating hash table with memblock_alloc, 8388608 bytes

> Either way:
> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks!

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 6c4644c9ed44..5ca0d086ef4a 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -186,8 +186,9 @@ int __init stack_depot_early_init(void)
        if (!__stack_depot_want_early_init || stack_depot_disable)
                return 0;
 
-       pr_info("Stack Depot early init allocating hash table with memblock_alloc\n");
        size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
+       pr_info("Stack Depot early init allocating hash table with memblock_alloc, %zu bytes\n",
+               size);
        stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
 
        if (!stack_table) {
