Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22394CAAD7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiCBQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiCBQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:52:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E6FCFB99
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:51:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9EBE8219A6;
        Wed,  2 Mar 2022 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646239893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCaIN4NRq1zNm/Cv/yO1rRvuzmntwatXQ6uVNZcnFSQ=;
        b=ct4Xfp1snqnbqSKt3IQVOJVW0Qz+qWywPmqlDsL2R0w4GUZ9wvlXhFBx9Cj8EB8ArNvTbZ
        vJ9JxeTlzExKyJpjolWvjpGLUJc+Q1qCzqaeqGi7UTDeC3EvCzCS051nd0olWD95SfE8ZC
        ICX0koIkBuXpRdubK4/d6NHFH/zcxCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646239893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCaIN4NRq1zNm/Cv/yO1rRvuzmntwatXQ6uVNZcnFSQ=;
        b=iq+rEXHUQ6n3ylidmsfBwzJ/htC6EI9nCjbwLfqx6sWlgkal4LTkrfGidnKiCJ8rgj5spz
        2Y9Lmd+xHPrzPNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2470613A93;
        Wed,  2 Mar 2022 16:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FjUpCJWgH2KKPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Mar 2022 16:51:33 +0000
Message-ID: <4b6e9dbb-ba3e-f33c-956e-07b5f81deee8@suse.cz>
Date:   Wed, 2 Mar 2022 17:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/5] mm/slub: use stackdepot to save stack trace in
 objects
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-3-vbabka@suse.cz>
 <YhtH5o2+7r85THg1@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YhtH5o2+7r85THg1@ip-172-31-19-208.ap-northeast-1.compute.internal>
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

On 2/27/22 10:44, Hyeonggon Yoo wrote:
> On Fri, Feb 25, 2022 at 07:03:15PM +0100, Vlastimil Babka wrote:
>> From: Oliver Glitta <glittao@gmail.com>
>> 
>> Many stack traces are similar so there are many similar arrays.
>> Stackdepot saves each unique stack only once.
>>
>> Replace field addrs in struct track with depot_stack_handle_t handle.  Use
>> stackdepot to save stack trace.
>>
> 
> I think it's not a replacement?

It is, for the array 'addrs':

-#ifdef CONFIG_STACKTRACE
-	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
+#ifdef CONFIG_STACKDEPOT
+	depot_stack_handle_t handle;

Not confuse with 'addr' which is the immediate caller and indeed stays
for redundancy/kernels without stack trace enabled.

>> The benefits are smaller memory overhead and possibility to aggregate
>> per-cache statistics in the following patch using the stackdepot handle
>> instead of matching stacks manually.
>> 
>> [ vbabka@suse.cz: rebase to 5.17-rc1 and adjust accordingly ]
>> 
>> This was initially merged as commit 788691464c29 and reverted by commit
>> ae14c63a9f20 due to several issues, that should now be fixed.
>> The problem of unconditional memory overhead by stackdepot has been
>> addressed by commit 2dba5eb1c73b ("lib/stackdepot: allow optional init
>> and stack_table allocation by kvmalloc()"), so the dependency on
>> stackdepot will result in extra memory usage only when a slab cache
>> tracking is actually enabled, and not for all CONFIG_SLUB_DEBUG builds.
>> The build failures on some architectures were also addressed, and the
>> reported issue with xfs/433 test did not reproduce on 5.17-rc1 with this
>> patch.
> 
> This is just an idea and beyond this patch.
> 
> After this patch, now we have external storage that records stack traces.

Well, we had it before this patch too.

> It's possible that some rare stack traces are in stack depot, but
> not reachable because track is overwritten.

Yes.

> I think it's worth implementing a way to iterate through stacks in stack depot?

The question is for what use case? We might even not know who stored
them - could have been page_owner, or other stack depot users. But the
point is usually not to learn about all existing traces, but to
determine which ones cause an object lifetime bug, or memory leak.

>> 
>> Signed-off-by: Oliver Glitta <glittao@gmail.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Pekka Enberg <penberg@kernel.org>
>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 

