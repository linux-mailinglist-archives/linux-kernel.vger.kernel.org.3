Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D085ACCDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiIEHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiIEHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:33:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60711183D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:33:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C962238779;
        Mon,  5 Sep 2022 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662363194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39bgkAvs9u3id1sAAJvSO5eKLLioMenaUUj0S5kesmo=;
        b=MvNrGdBdgkHVGCownMmnvspVKGc7or3wuKuZUQFzAnte2gJ7ZGqL2ZXmohsnYwCxMkKgJ+
        hnKS2oFWl8zp+cqfCQ5NO3vpm3AIGz4qU0fplToAS5cXbH1x1OcRoeOIIYx+mxjydfHZRp
        oBhwxztL6DGcqbz17tQqr8RXHiiUBFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662363194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39bgkAvs9u3id1sAAJvSO5eKLLioMenaUUj0S5kesmo=;
        b=2PBBExInd9LrA1vZbCEQnlAsHffcz2XQJ8zQA4rZyAtgIFNSjk6KncAuDOOU4ouz2RtQEu
        XUNZpnks5IbxWJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90BAB13A66;
        Mon,  5 Sep 2022 07:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V5OZIjqmFWMCcQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 05 Sep 2022 07:33:14 +0000
Message-ID: <f5057559-d4a7-552d-c5e8-1f1cd133a7f1@suse.cz>
Date:   Mon, 5 Sep 2022 09:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com> <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx> <YxRp5uz9KSY0S9id@hyeyoo>
 <YxRzCX8WqOv3KESJ@feng-clx> <YxSE6XmHl3itv4JY@hyeyoo>
 <YxVlB/YRj7SNLqml@feng-clx> <8ff805f4-76ae-fc0f-424f-4d230c08285e@suse.cz>
 <YxWgEZTxyI/4ISHa@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YxWgEZTxyI/4ISHa@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 09:06, Feng Tang wrote:
> On Mon, Sep 05, 2022 at 02:29:51PM +0800, Vlastimil Babka wrote:
>> 
>> How about get_partial() instantiates an on-stack structure that contains
>> gfpflags, ret_slab, orig_size and passes pointer to that to all the nested
>> functions.
>> 
>> Would be similar to "struct alloc_context" in page allocation.
>> Something like "struct partial_context pc"?
> 
> Yep! This would make the parameters passing much tidier. Will try
> this way. 
> 
> More aggressively is to also embed the 'kmem_cache' parameter into
> it, but this may make the code look ambiguous.

That one is used a lot everywhere, so it would be tedious to dereference it
from a struct, and also might be a bit better code if it's in a register.

> Thanks,
> Feng
> 
> 

