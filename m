Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8D4F492C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391365AbiDEWFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354966AbiDEKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:16:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CE140DD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:04:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4F71210E5;
        Tue,  5 Apr 2022 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649153058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gd5jq9JA78+ej6U2SXRWQGkkcWFy9lDISdWZvkme7M=;
        b=QRnYDueTv6FkkyOXeKf43xTyrX0Yg9FflXn2fWwaWwdJFLNu0c6HbZDoY7Ma0C2gSflO6o
        UmVMyuhlhQbviWmktRTT/xjHDVpE9ymF1UTcNlDEwUuXp04BRAT5vWg0SS8ssrIcxxZUZb
        Rekl/2oHVTABt8v9B6SLwW/BE7lc1zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649153058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gd5jq9JA78+ej6U2SXRWQGkkcWFy9lDISdWZvkme7M=;
        b=pM+1pMkGX4wEBvlh5Vkd7pClTEFyjosT5PfCpAt/FqHQtyEktuTgm6u4Ji7qiyMEiDeQzg
        M8gL++iLBDtrbDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C049313A04;
        Tue,  5 Apr 2022 10:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xt8kLiIUTGK2RgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Apr 2022 10:04:18 +0000
Message-ID: <76c63237-c489-b942-bdd9-5720042f52a9@suse.cz>
Date:   Tue, 5 Apr 2022 12:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] mm, slub: change percpu partial accounting from
 objects to pages
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
References: <20211012134651.11258-1-vbabka@suse.cz>
 <Yja4AlOHkpcKLu59@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yja4AlOHkpcKLu59@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/22 06:13, Hyeonggon Yoo wrote:
>> While this is no longer a problem in kmemcg context thanks to the accounting
>> rewrite in 5.9, the memory waste is still not ideal and it's questionable
>> whether it makes sense to perform free object count based control when object
>> counts can easily become so much inaccurate. So this patch converts the
>> accounting to be based on number of pages only (which is precise) and removes
>> the page->pobjects field completely. This is also ultimately simpler.
>> 
>> To retain the existing set_cpu_partial() heuristic, first calculate the target
>> number of objects as previously, but then convert it to target number of pages
>> by assuming the pages will be half-filled on average. This assumption might
>> obviously also be inaccurate in practice, but cannot degrade to actual number of
>> pages being equal to the target number of objects.
> 
> I have to agree that this half-filled assumption works pretty well and
> I believe the too-long-partial-list problem has gone. we're controlling
> its length clearly after this patch.
> 
> But my one concern here is that actual number of objects in
> percpu partial list can be decreased when we cannot allocate high order pages.
> 
> e.g.) oo_order(s->oo) is 3 and we can only allocate order-2 page,
> it can be shortened 2 times in worst case because the accounting logic
> assumes order of all slab in the percpu partial list is oo_order(s->oo).

That's true, but let's not forget the percpu partial lists are motivated by
peak performance in e.g. networking. Once we start having issues allocating
e.g. order-2 pages due to fragmentation, the system is probably far from
peak performance already, so this pessimism in slub partial lists is not the
main concern.

> I think using object based accounting, and assuming every slab is
> half-filled would be more consistent when the system is highly
> fragmented.

Based on reasoning above, I doubt it's worth the trouble.

Thanks.

> Thoughts?
> 

