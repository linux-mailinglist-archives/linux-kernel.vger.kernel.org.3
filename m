Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091B159C4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiHVRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbiHVRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:25:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B902ED68
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:25:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C39993527E;
        Mon, 22 Aug 2022 17:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661189126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Y0wrBif2elD1Gfd80I1gu1pCUy6vvjs/IGtjgDdBHQ=;
        b=oKvlWLhDJLOfoUeFP7U4Q/OEKpTxF8UCYATHpe0wMTz5Hv2nwGuSzuteCdiZCGpmEglXdW
        YEho48Fr6DrMsbMRgyyZNI4U/nVZPYdmzffeXu9j7iECRaGJoaf031VMckm9aFlRcjPoey
        YywGCKr0MotL0a40PYGbiJ7Cxc7Z3v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661189126;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Y0wrBif2elD1Gfd80I1gu1pCUy6vvjs/IGtjgDdBHQ=;
        b=ZzOG+FPYNZZNJq2IAi8cq7Iyb3NdLhApD7DrddoTJizJejnwonedByCqKGRsl1t+5dq1q3
        1Ja8TZ2oaFhNu6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8124B1332D;
        Mon, 22 Aug 2022 17:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KYwWHga8A2PzRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 22 Aug 2022 17:25:26 +0000
Message-ID: <ece42e74-821e-662b-2c07-ea0756962bec@suse.cz>
Date:   Mon, 22 Aug 2022 19:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/slab_common: Deleting kobject in kmem_cache_destroy()
 without holding slab_mutex/cpu_hotplug_lock
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Xin Long <lucien.xin@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220809205901.76595-1-longman@redhat.com>
 <48b66d90-34ae-8666-d9ee-2d36c82a6653@suse.cz>
 <34d80543-322f-9c76-ad7d-d7c734163fa0@redhat.com>
 <ac08e3f6-f167-2382-5266-959e7339c04a@suse.cz> <YwOImVd+nRUsSAga@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YwOImVd+nRUsSAga@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 15:46, Hyeonggon Yoo wrote:
> On Mon, Aug 22, 2022 at 02:03:33PM +0200, Vlastimil Babka wrote:
>> On 8/10/22 16:08, Waiman Long wrote:
>>> On 8/10/22 05:34, Vlastimil Babka wrote:
>>>> On 8/9/22 22:59, Waiman Long wrote:
>>>>> A circular locking problem is reported by lockdep due to the following
>>>>> circular locking dependency.
>>>>>
>>>>>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active#126 --+
>>>>>    |                                                         |
>>>>>    +---------------------------------------------------------+
>>>>
>>>> This sounded familiar and I've found a thread from January:
>>>>
>>>> https://lore.kernel.org/all/388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com/
>>>>
>>>> But that seemed to be specific to RHEL-8 RT kernel and not reproduced with
>>>> mainline. Is it different this time? Can you share the splats?
>>>
>>> I think this is easier to reproduce on a RT kernel, but it also happens in a
>>> non-RT kernel. One example splat that I got was
>>>
>>> [ 1777.114757] ======================================================
>>> [ 1777.121646] WARNING: possible circular locking dependency detected
>>> [ 1777.128544] 4.18.0-403.el8.x86_64+debug #1 Not tainted
>>> [ 1777.134280] ------------------------------------------------------
>>
>> Yeah that's non-RT, but still 4.18 kernel, as in Xin Long's thread
>> referenced above. That wasn't reproducible in current mainline and I would
>> expect yours also isn't, because it would be reported by others too.
> 
> I can confirm this splat is reproducible on 6.0-rc1 when conditions below are met:
> 	1) Lockdep is enabled
> 	2) kmem_cache_destroy() is executed at least once (e.g. loading slub_kunit module)
> 	3) flush_all() is executed at least once (e.g. writing to /sys/kernel/<slab>/cpu_partial)

Oh, great, that's useful, thanks!

...

> 
>> Also in both cases the lockdep (in 4.18) seems to have issue with
>> cpus_read_lock() which is a rwsem taken for read, so not really exclusive in
>> order to cause the reported deadlock.
> 
> Agreed.
> 
>> So I suspected lockdep was improved since 4.18 to not report a false
>> positive, but we never confirmed.
> 
> Seems not improved as it reports on 6.0-rc1.
> May fix lockdep instead of fixing SLUB?

So after discussing with PeterZ, the lockdep splat is legitimate,
because there could be a writer waiting on the first reader to finish,
and in that case rwsems block further readers so they don't starve the
writer, and thus the deadlock could happen.
