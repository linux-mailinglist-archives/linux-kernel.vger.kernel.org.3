Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8A5AAB6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiIBJbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiIBJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:30:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389302C67D;
        Fri,  2 Sep 2022 02:30:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF738342A7;
        Fri,  2 Sep 2022 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662111020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rd3pA8qgIDU8b5TFfRtTYXB5vFvZyeLlgLZGMf5H4xA=;
        b=GFigYEkmlXk35LHz5yFJR9FZflvsV06MWtczzY6e4BHvfMKWxhaTDECJrMkGR97r1/XxSf
        tDAb5fcR0XnKs5NgRKD/14Db53Z9BeBaARjhbGSEaa9ZFDEmtE35t1esbi3mAXSasOXmCP
        NFFgAdnVZzKcvsy6FlA6Grj7SezicZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662111020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rd3pA8qgIDU8b5TFfRtTYXB5vFvZyeLlgLZGMf5H4xA=;
        b=GqkxwC7jobr70fRwxJZncNc5CZwwtb3n21oJMDKEf3Y4GNsnWOYENYgnKr4gLLh4Fm5sWe
        nxfQ0pJQWzxSVuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A543413328;
        Fri,  2 Sep 2022 09:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ORWWJyzNEWNsFAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 02 Sep 2022 09:30:20 +0000
Message-ID: <75ad3ed3-7dcd-474c-472c-ca32c1734281@suse.cz>
Date:   Fri, 2 Sep 2022 11:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 02/18] mm/sl[au]b: rearrange struct slab fields to
 allow larger rcu_head
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com, Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-3-joel@joelfernandes.org>
 <e84c90f2-d76f-83d4-d40b-403f894eda33@suse.cz>
In-Reply-To: <e84c90f2-d76f-83d4-d40b-403f894eda33@suse.cz>
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

On 9/2/22 11:26, Vlastimil Babka wrote:
> On 9/2/22 00:17, Joel Fernandes (Google) wrote:
>> From: Vlastimil Babka <vbabka@suse.cz>
>> 
>> Joel reports [1] that increasing the rcu_head size for debugging
>> purposes used to work before struct slab was split from struct page, but
>> now runs into the various SLAB_MATCH() sanity checks of the layout.
>> 
>> This is because the rcu_head in struct page is in union with large
>> sub-structures and has space to grow without exceeding their size, while
>> in struct slab (for SLAB and SLUB) it's in union only with a list_head.
>> 
>> On closer inspection (and after the previous patch) we can put all
>> fields except slab_cache to a union with rcu_head, as slab_cache is
>> sufficient for the rcu freeing callbacks to work and the rest can be
>> overwritten by rcu_head without causing issues.
>> 
>> This is only somewhat complicated by the need to keep SLUB's
>> freelist+counters aligned for cmpxchg_double. As a result the fields
>> need to be reordered so that slab_cache is first (after page flags) and
>> the union with rcu_head follows. For consistency, do that for SLAB as
>> well, although not necessary there.
>> 
>> As a result, the rcu_head field in struct page and struct slab is no
>> longer at the same offset, but that doesn't matter as there is no
>> casting that would rely on that in the slab freeing callbacks, so we can
>> just drop the respective SLAB_MATCH() check.
>> 
>> Also we need to update the SLAB_MATCH() for compound_head to reflect the
>> new ordering.
>> 
>> While at it, also add a static_assert to check the alignment needed for
>> cmpxchg_double so mistakes are found sooner than a runtime GPF.
>> 
>> [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
>> 
>> Reported-by: Joel Fernandes <joel@joelfernandes.org>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I've added patches 01 and 02 to slab tree for -next exposure before Joel's
> full series posting, but it should be also ok if rcu tree carries them with
> the whole patchset. I can then drop them from slab tree (there are no
> dependencies with other stuff there) so we don't introduce duplicite commits
> needlessly, just give me a heads up.

Ah but in that case please apply the reviews from my posting [1]

patch 1:
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

patch 2
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

[1] https://lore.kernel.org/all/20220826090912.11292-1-vbabka@suse.cz/
