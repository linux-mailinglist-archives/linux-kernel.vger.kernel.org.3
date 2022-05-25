Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E63533A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiEYKJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiEYKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:09:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD8590CE1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:09:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BFD651F905;
        Wed, 25 May 2022 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653473359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yo7FzjtiZvDRd+DFH4BFUlGj/8Afe054Q8uURtbD0/M=;
        b=yU1ERtijKkn5EuG/gZIGlqcfJroUdwuBP/DWW24Q8bFamTS94hSBnyf2otDMBLWttde2p1
        sikqfxNe9h/t5OU0uA3UXUkY+/gfGLipuXHizn9i2MpapG92QawYl8T1ATFrUoe08Q74i1
        g68K3irHsjIr4UEDL89hzQtFupVtWvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653473359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yo7FzjtiZvDRd+DFH4BFUlGj/8Afe054Q8uURtbD0/M=;
        b=9UlVVBrNvELvqaYdmefU30TxErcxGeb/i0zJI+CI5pqSa0GNnANIJE37ZMNNFFfAvWamqK
        lLPCFJ12a1J33lDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DD3413487;
        Wed, 25 May 2022 10:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q0z1JU8AjmJgZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 25 May 2022 10:09:19 +0000
Message-ID: <970bbb88-3fc7-d2b9-6bb5-9c315888a889@suse.cz>
Date:   Wed, 25 May 2022 12:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] mm: slab: optimize memcg_slab_free_hook()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com
References: <20220429123044.37885-1-songmuchun@bytedance.com>
 <86fdbde5-a010-9473-2f5d-807c86620509@suse.cz>
 <Yo2R3VA1LIwx10FM@FVFYT0MHHV2J.googleapis.com>
 <b34a75ac-389a-3965-9c56-0b18adc8440d@suse.cz>
 <Yo3zmQLzHqdeyr3V@FVFYT0MHHV2J.googleapis.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yo3zmQLzHqdeyr3V@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 11:15, Muchun Song wrote:
> On Wed, May 25, 2022 at 09:34:58AM +0200, Vlastimil Babka wrote:
>> On 5/25/22 04:18, Muchun Song wrote:
>> > On Tue, May 24, 2022 at 07:05:31PM +0200, Vlastimil Babka wrote:
>> >> On 4/29/22 14:30, Muchun Song wrote:
>> >> > Most callers of memcg_slab_free_hook() already know the slab,  which could
>> >> > be passed to memcg_slab_free_hook() directly to reduce the overhead of an
>> >> > another call of virt_to_slab().  For bulk freeing of objects, the call of
>> >> > slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
>> >> > Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
>> >> > those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
>> >> > freeing in slab_free().
>> >> > 
>> >> > Move the calling site of memcg_slab_free_hook() from do_slab_free() to
>> >> > slab_free() for slub to make the code clearer since the logic is weird
>> >> > (e.g. the caller need to judge whether it needs to call
>> >> > memcg_slab_free_hook()). It is easy to make mistakes like missing calling
>> >> > of memcg_slab_free_hook() like fixes of:
>> >> > 
>> >> >   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
>> >> >   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
>> >> 
>> >> Hm is this commit also fixing such bug? in mm/slab.c __cache_free():
>> >>
> 
> Sorry, I think I have misread it and misled you here.  I mean commit

My bad, I should have said "this patch" referring to yours, not "this
commit" which could refer to ae085d7f9365.

> ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> is a bug fix, this commit does not fix any issue since __cache_free()
> will be called from qlink_free() and __cache_free() will call
> memcg_slab_free_hook(), so there is no issues.  This commit is totally
> an improvements for memcg_slab_free_hook().

Ah, I see, indeed. The un-quarantining in kasan went through
memcg_slab_free_hook() before your patch. But yeah it's better to do it
earlier as the freed object's user is who charged it to the memcg, and is no
longer using it - no reason to keep it accounted while in kasan's quarantine.
