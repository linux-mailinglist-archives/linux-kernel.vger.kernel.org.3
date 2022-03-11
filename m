Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB3F4D5D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiCKIk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCKIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:40:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9DE1BA157
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:39:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B6C8210FB;
        Fri, 11 Mar 2022 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646987994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DfiOPAX1UZrTsNaUT7mGjqf5TamzeUSqWkLnIoo2UwU=;
        b=gG8PlJp9pbRs1eBpWZC7+H0wQqLy+Kkdh1AryEQYNTsdYnDozxK/Nvlh3YFvpWrBcP4xmm
        aHlXY8ZGN2QY0q8X1LmasppV7+zBZfGJ9lNCCw4R6peXMtkyGUJePBdBMSNgtFKoc+NHFO
        z9zKwwQYFhIIo25sANnt7Ts0SMikwGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646987994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DfiOPAX1UZrTsNaUT7mGjqf5TamzeUSqWkLnIoo2UwU=;
        b=sKAntTxnRA5aJK6FzeKWowRAOyfxdjYdRzhwA+CjmNaoPc+V3pD5hhuB7aEQnzp2OFz3Me
        lMCyQX8/H7sxpRDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B80EA13A85;
        Fri, 11 Mar 2022 08:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RLi8KdkKK2LNPwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 11 Mar 2022 08:39:53 +0000
Date:   Fri, 11 Mar 2022 09:39:52 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
Message-ID: <YisK2PEkKAqtZPfp@localhost.localdomain>
References: <20220310120749.23077-1-osalvador@suse.de>
 <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 10:24:07AM +0800, Huang, Ying wrote:
> It may be unnecessary to be fixed in this patch.  But I think we need to
> cleanup the kernel config dependencies of the demotion code at some time.

I am glad you brought this up because it is something I have been
thinking about.
I already added it in my to-do list, but I would do it in a separate
patch if you do not mind.

Now, let us try to untangle this mess:

> 1. Even if !defined(CONFIG_HOTPLUG_CPU) &&
>    !defined(CONFIG_MEMORY_HOTPLUG), we still need to allocate
>    "node_demotion" and call set_migration_target_nodes() during boot time.
> 
> 2. If !defined(CONFIG_MEMORY_HOTPLUG), we don't need
>    migrate_on_reclaim_callback().
> 
> 3. We need defined(CONFIG_NUMA) && defined(CONFIG_MIGRATION) for all
>    these code.

Back in the early versions [1] I asked whether we could have some
scenario where this feature could be used when !CONFIG_MEMORY_HOTPLUG
[2].
The reason I was given is that in order to bind the expose PMEM memory
as RAM (add_memory_driver_managed()), we need MEMORY_HOTPLUG.

Now, as I said back then, I am not sure whether PMEM memory can be
exposed as RAM by other means, but as it was pointed out back then,
it really looks like we, at least, need CONFIG_MEMORY_HOTPLUG.

Ok, so we have our first dependency: CONFIG_MEMORY_HOTPLUG.

Now, about CONFIG_HOTPLUG_CPU, it seems that that is not a strong dependency,
as we do not need cpu-hotplug in order to use the feature.

We definitely need CONFIG_MIGRATION and CONFIG_NUMA though.

So, we have something like:

- Depends:
  * CONFIG_NUMA           (obvius)
  * CONFIG_MIGRATION      (to migrate between nodes)
  * CONFIG_MEMORY_HOTPLUG (to expose PMEM as RAM)

Sounds about right?

[1] https://patchwork.kernel.org/project/linux-mm/patch/20210401183221.977831DE@viggo.jf.intel.com/#24099405
[2] https://patchwork.kernel.org/project/linux-mm/patch/20210401183221.977831DE@viggo.jf.intel.com/#24103467

-- 
Oscar Salvador
SUSE Labs
