Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905AB5117F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiD0MX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiD0MXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:23:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8A3A199
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:20:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B29B210E3;
        Wed, 27 Apr 2022 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651062027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZnZ1I8k+ftCApGqx0VMrkh9aJHI/MK3Cg/5kMjpBYg=;
        b=rUoTgBFB55yqwDfI1zBrwZae4p1SVlnDeLtfzrXlgrEkuYxhTuCGakMejE4G2herRvyvGA
        yIpBdMFptRNJH8YLv3JaqWZyhJKS+ndTxlHkfSYD5C5ILX7LYHLTehJbTLJNkVRw1rj6uZ
        hScYwAQbRXnbTNlwWLJIr9Fzqq8NGqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651062027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZnZ1I8k+ftCApGqx0VMrkh9aJHI/MK3Cg/5kMjpBYg=;
        b=QOhOFA2i8zVbsB8S1KdpFOlz2g88qj17xpn8NYoEpCQaHJco9Yz0T8RngKwIN+Uu3vdrsN
        RAM7A1+jHY6bpvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F4FF13A39;
        Wed, 27 Apr 2022 12:20:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DPsRCAk1aWLFNwAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 27 Apr 2022 12:20:25 +0000
Date:   Wed, 27 Apr 2022 14:20:22 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Message-ID: <Ymk1BkSEs5uCgV6e@localhost.localdomain>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:48:16PM +0200, David Hildenbrand wrote:
> I raised some time ago already that I don't quite see the value of
> allowing memory offlining with poisened pages.
> 
> 1) It overcomplicates the offlining code and seems to be partially
>    broken
> 2) It happens rarely (ever?), so do we even care?
> 3) Once the memory is offline, we can re-online it and lost HWPoison.
>    The memory can be happily used.
> 
> 3) can happen easily if our DIMM consists of multiple memory blocks and
> offlining of some memory block fails -> we'll re-online all already
> offlined ones. We'll happily reuse previously HWPoisoned pages, which
> feels more dangerous to me then just leaving the DIMM around (and
> eventually hwpoisoning all pages on it such that it won't get used
> anymore?).
> 
> So maybe we should just fail offlining once we stumble over a hwpoisoned
> page?
> 
> Yes, we would disallow removing a semi-broken DIMM from the system that
> was onlined MOVABLE. I wonder if we really need that and how often it
> happens in real life. Most systems I am aware of don't allow for
> replacing individual DIMMs, but only complete NUMA nodes. Hm.

I teend to agree with all you said.
And to be honest, the mechanism of making a semi-broken DIMM healthy
again has always been a mistery to me.

One would think that:

1- you hot-remove the memory
2- you fix/remove it
3- you hotplug memory again

but I am not sure how many times this came to be.

And there is also the thing about losing the hwpoison information
between offline<->online transitions, so, the thing is unreliable.

And for that to work, we would have to add a bunch of code
to keep track of "offlined" pages that are hwpoisoned, so we
flag them again once they get onlined, and that means more
room for errors.

So, I would lean towards the fact of not allowing to offline
memory that contain such pages in the first place, unless that
proves to be a no-go.


-- 
Oscar Salvador
SUSE Labs
