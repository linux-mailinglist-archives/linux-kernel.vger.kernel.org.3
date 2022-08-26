Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A05A267B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbiHZLFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343565AbiHZLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:04:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E31B7A2;
        Fri, 26 Aug 2022 04:04:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D84A33A78;
        Fri, 26 Aug 2022 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661511849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFOOohnuss0N6Iie9i/7dzCuPjr92PFh/YAiHWF3gM4=;
        b=NatBhYTr6ApHxghgYmknxe6iN3Rr+EBBUSoY5mmnOzPzzwwArg7zWdJtYkxPrOeF2mlNgI
        klmIvSpO1fXEiWxdUEi0er1eDXTj4n8vKWTPMVOfHgTD7EIAIX2ltg7nvQRBd1Se1sdEew
        pIcmxtCCFuS6EfkuoTZDekdtwME53uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661511849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFOOohnuss0N6Iie9i/7dzCuPjr92PFh/YAiHWF3gM4=;
        b=oFYrTGr9oU6N1KQoe9qQFm1PH+3BubRR+/a2dPtLGQeGvVdJrFaTP3tCdiLTW3fIMO/95N
        +bBBpumRUSF9EXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D37E13A7E;
        Fri, 26 Aug 2022 11:04:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YsM3BqmoCGPYawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Aug 2022 11:04:09 +0000
Message-ID: <bf093f5c-bd0b-e843-d9e5-a4edf0f70cae@suse.cz>
Date:   Fri, 26 Aug 2022 13:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>,
        matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Meelis Roos <mroos@linux.ee>, Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.com
References: <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
 <20190219144454.GB12668@bombadil.infradead.org>
 <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
 <20190220094813.GA27474@quack2.suse.cz>
 <2381c264-92f5-db43-b6a5-8e00bd881fef@linux.ee>
 <20190221132916.GA22886@quack2.suse.cz>
 <97dbffaefa65a83b36e1ec134fd53a66@matoro.tk>
 <20220826105513.eo5otoujtz75u7dg@quack3>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220826105513.eo5otoujtz75u7dg@quack3>
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

On 8/26/22 12:55, Jan Kara wrote:
> On Thu 25-08-22 11:05:48, matoro wrote:
>> Hello all, I know this is quite an old thread.  I recently acquired some
>> alpha hardware and have run into this exact same problem on the latest
>> stable kernel (5.18 and 5.19).  CONFIG_COMPACTION seems to be totally broken
>> and causes userspace to be extremely unstable - random segfaults, corruption
>> of glibc data structures, gcc ICEs etc etc - seems most noticable during
>> tasks with heavy I/O load.
>> 
>> My hardware is a DS15 (Titan), so only slightly newer than the Tsunamis
>> mentioned earlier.  The problem is greatly exacerbated when using a
>> machine-optimized kernel (CONFIG_ALPHA_TITAN) over one with
>> CONFIG_ALPHA_GENERIC.  But it still doesn't go away on a generic kernel,
>> just pops up less often, usually very I/O heavy tasks like checking out a
>> tag in the kernel repo.
>> 
>> However all of this seems to be dependent on CONFIG_COMPACTION.  With this
>> toggled off all problems disappear, regardless of other options.  I tried
>> reverting the commit 88dbcbb3a4847f5e6dfeae952d3105497700c128 mentioned
>> earlier in the thread (the structure has moved to a different file but was
>> otherwise the same), but it unfortunately did not make a difference.
>> 
>> Since this doesn't seem to have a known cause or an easy fix, would it be
>> reasonable to just add a Kconfig dep to disable it automatically on alpha?
> 
> Thanks for report. I guess this just confirms that migration of pagecache
> pages is somehow broken on Alpha. Maybe we are missing to flush some cache
> specific for Alpha? Or maybe the page migration code is not safe wrt the
> peculiar memory ordering Alpha has... I think this will need someone with
> Alpha HW and willingness to dive into MM internals to debug this. Added
> Vlasta to CC mostly for awareness and in case it rings some bells :).

Hi, doesn't ring any bells unfortunately. Does corruption also happen when
mmapping a file and applying mbind() with MPOL_MF_MOVE or migrate_pages()?
That should allow more controlled migration experimens than through
compaction. But that would also need a NUMA machine or a fakenuma support,
dunno if alpha has that?
