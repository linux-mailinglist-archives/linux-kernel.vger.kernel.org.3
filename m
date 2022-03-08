Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE84D1BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbiCHPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiCHPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:32:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAED4E3A5;
        Tue,  8 Mar 2022 07:31:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DA191F37E;
        Tue,  8 Mar 2022 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646753487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0vmAh/kccjRH8guMo493NivfH2oji8DnSzxOP03BLQ=;
        b=mrMLGWOuBBlfsroDd6oYIT/7H1v5hOJXMp5a9QPISbpXl/ekUC+1iESI2GAUSNovV78Maj
        9NtPV5QtvFp7sAqRzPVyUrGOi2xg7es9JiM4YHxtUJZtm8NjSyEObJHMlrpvZygvjp4Fbl
        uonAlY5UhIUfagInBoDjjpcUDtVCOdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646753487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0vmAh/kccjRH8guMo493NivfH2oji8DnSzxOP03BLQ=;
        b=45qz6+e4yjrb0c3W0MEw6xycEFn3U5t98k4ELCcCVRhgC/GF4XdUa95qeeK4qgWSQ8SX8b
        bzSKLApuO61dPvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F07B013CCE;
        Tue,  8 Mar 2022 15:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JR+yOc52J2JoWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Mar 2022 15:31:26 +0000
Message-ID: <afc1212b-932f-0588-97c4-01e38b2e30ca@suse.cz>
Date:   Tue, 8 Mar 2022 16:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>, dgilbert@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220304171912.305060-1-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220304171912.305060-1-hannes@cmpxchg.org>
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

On 3/4/22 18:19, Johannes Weiner wrote:
> MADV_DONTNEED historically rejects mlocked ranges, but with
> MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
> there are valid use cases for depopulating locked ranges as well.
> 
> Users mlock memory to protect secrets. There are allocators for secure
> buffers that want in-use memory generally mlocked, but cleared and
> invalidated memory to give up the physical pages. This could be done
> with explicit munlock -> mlock calls on free -> alloc of course, but
> that adds two unnecessary syscalls, heavy mmap_sem write locks, vma
> splits and re-merges - only to get rid of the backing pages.
> 
> Users also mlockall(MCL_ONFAULT) to suppress sustained paging, but are
> okay with on-demand initial population. It seems valid to selectively
> free some memory during the lifetime of such a process, without having
> to mess with its overall policy.
> 
> Why add a separate flag? Isn't this a pretty niche usecase?
> 
> - MADV_DONTNEED has been bailing on locked vmas forever. It's at least
>   conceivable that someone, somewhere is relying on mlock to protect
>   data from perhaps broader invalidation calls. Changing this behavior
>   now could lead to quiet data corruption.
> 
> - It also clarifies expectations around MADV_FREE and maybe
>   MADV_REMOVE. It avoids the situation where one quietly behaves
>   different than the others. MADV_FREE_LOCKED can be added later.

Looks like the parameter is not a bitmask, so it makes sense to have
MADV_FREE_LOCKED instead of a generic flag that combines with one of those.

> - The combination of mlock() and madvise() in the first place is
>   probably niche. But where it happens, I'd say that dropping pages
>   from a locked region once they don't contain secrets or won't page
>   anymore is much saner than relying on mlock to protect memory from
>   speculative or errant invalidation calls. It's just that we can't
>   change the default behavior because of the two previous points.
> 
> Given that, an explicit new flag seems to make the most sense.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Acked-by: Michal Hocko <mhocko@suse.com>
