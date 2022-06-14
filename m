Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6123154B1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356526AbiFNM72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbiFNM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:59:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82233373
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:59:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99F841F944;
        Tue, 14 Jun 2022 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655211542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMr1/XLuAOMxSe9sGiC+UXBNDWGlTqQ/hao0UnZOiCI=;
        b=aqiIxHDc67wDyQai+z0F83OzfB6xGkNrq/XkHJKxk4FcWvVQeetmOEq0jVM5nfkw4U6W0i
        AhDlvbtg2eMpBk0xaKpXpe8G3ER+p0aRY2dxxo2TcCUwYnfsopDv0v+Tl98P2bDPPILGPn
        dzb9IQ8M9zYiYajZIYWnGU+uxp2NuO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655211542;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMr1/XLuAOMxSe9sGiC+UXBNDWGlTqQ/hao0UnZOiCI=;
        b=hQCKkXMCzGmeos73iIO0EA1Qpu3C+txcsjMekPresAyq9BtOQv68ZbQfgxh2bnHPTSyi+n
        /+DygIGkVcahWSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FADE1361C;
        Tue, 14 Jun 2022 12:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fHpgGhaGqGKVGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Jun 2022 12:59:02 +0000
Message-ID: <66864da8-4eb4-f177-3518-dc4e16aa183a@suse.cz>
Date:   Tue, 14 Jun 2022 14:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] mm: slab: optimize memcg_slab_free_hook()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, smuchun@gmail.com
References: <20220429123044.37885-1-songmuchun@bytedance.com>
 <YqGUb0s5Jw5EgKne@FVFYT0MHHV2J.usts.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YqGUb0s5Jw5EgKne@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 08:34, Muchun Song wrote:
> On Fri, Apr 29, 2022 at 08:30:44PM +0800, Muchun Song wrote:
>> Most callers of memcg_slab_free_hook() already know the slab,  which could
>> be passed to memcg_slab_free_hook() directly to reduce the overhead of an
>> another call of virt_to_slab().  For bulk freeing of objects, the call of
>> slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
>> Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
>> those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
>> freeing in slab_free().
>> 
>> Move the calling site of memcg_slab_free_hook() from do_slab_free() to
>> slab_free() for slub to make the code clearer since the logic is weird
>> (e.g. the caller need to judge whether it needs to call
>> memcg_slab_free_hook()). It is easy to make mistakes like missing calling
>> of memcg_slab_free_hook() like fixes of:
>> 
>>   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
>>   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
>> 
>> This optimization is mainly for bulk objects freeing.  The following numbers
>> is shown for 16-object freeing.
>> 
>>                            before      after
>>   kmem_cache_free_bulk:   ~430 ns     ~400 ns
>> 
>> The overhead is reduced by about 7% for 16-object freeing.
>> 
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Hi Vlastimil,
> 
> Wolud you mind picking it up? I did not see this patch on the
> slab tree.

Sorry, was waiting for rc1 to start the for-5.20 branches and was away for
another week then. Now pushed to slab/for-5.20/optimizations

> Thanks.
> 

