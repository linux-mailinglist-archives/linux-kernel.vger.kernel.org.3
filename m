Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57C57A19B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiGSOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiGSOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:32:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA925F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:21:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 277A1371C6;
        Tue, 19 Jul 2022 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658240493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=faZQzQJp2jSV+DEwY6aFeTWmsrjxRq7qoRQPFl/6u1I=;
        b=mU/9U99F7Mja/TVNusMso6UJt3JNZfrAwU/m7RuOHjNMYmbM3IMLAFzI3LmljUietyDFHL
        4BEypXLVeP3ZK2JnSXi6LG9W6Vbkndyos0ZecvxOXGoBJYDc/DDKgFYbn+PIPbrQmoql4M
        oyt1Xsv0WZ9IPXaML6It4Gxn4obebKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658240493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=faZQzQJp2jSV+DEwY6aFeTWmsrjxRq7qoRQPFl/6u1I=;
        b=zQvSlfD9IIuBT0QKqTBWrpRvke+MRcO7t/MeI6Uj6DIa6l1OPySi2AcTOnwo9QRXqd+lyH
        yLjK1WNkYosMYjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDA3C13488;
        Tue, 19 Jul 2022 14:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HBucOOy91mK6cwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 19 Jul 2022 14:21:32 +0000
Message-ID: <ad258412-2f8f-8e15-fbd0-c0933aeb1a6d@suse.cz>
Date:   Tue, 19 Jul 2022 16:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <69462916-2d1c-dd50-2e64-b31c2b61690e@suse.cz>
 <5344e023-29f0-9285-a402-19e2a556dbb0@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <5344e023-29f0-9285-a402-19e2a556dbb0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 16:15, Rongwei Wang wrote:
> 
...
>> +
>> +    slab_unlock(slab, &flags2);
>> +    spin_unlock_irqrestore(&n->list_lock, flags);
>> +    if (!ret)
>> +        slab_fix(s, "Object at 0x%p not freed", object);
>> +    if (slab_to_discard) {
>> +        stat(s, FREE_SLAB);
>> +        discard_slab(s, slab);
>> +    }
>> +
>> +    return ret;
>> +}
> I had test this patch, and it indeed deal with the bug that I described.

Thanks.

> Though I am also has prepared this part of code, your code is ok to me.

Aha, feel free to post your version, maybe it's simpler? We can compare.

