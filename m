Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5C4D5E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbiCKJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbiCKJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:24:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFFDECC63
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:23:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB322218FB;
        Fri, 11 Mar 2022 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646990626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAebBo2Ox/zCWG7q1Ozd2d4et9J9l1aqgs2UCakv6jo=;
        b=ooLRvzEnI4KmFKpBb9Pc+ki9faKRUrGslNUu+7nyxD19DSn5pgr189oGyTZz5oFFrlH6D4
        +TtkDOGMRtLBfcBc7wOhxWtdhS6uiCI3gF6yDcPTSH25fFKt3EO7tYUYsaTg3ly7U1etB+
        22xzAPqL0K84d/GWooPfI4GG8x6DH18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646990626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAebBo2Ox/zCWG7q1Ozd2d4et9J9l1aqgs2UCakv6jo=;
        b=ZTgzHVxnl1QG3AfrwIvrsL7F43IP0UancSHTbVFeKXYRTqqkqKjysVUu4LNi5COkDsbFTj
        A2ja3YO/jD0yWtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45B1913A82;
        Fri, 11 Mar 2022 09:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K14HDiIVK2KPVAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 11 Mar 2022 09:23:46 +0000
Date:   Fri, 11 Mar 2022 10:23:44 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
Message-ID: <YisVIIGcSgi7NL8N@localhost.localdomain>
References: <20220310120749.23077-1-osalvador@suse.de>
 <20220310183951.cb713c6ae926ea6ea8489a71@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310183951.cb713c6ae926ea6ea8489a71@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 06:39:51PM -0800, Andrew Morton wrote:
> What I'm not getting here (as so often happens) is a sense of how badly
> this affects our users.  Does anyone actually hotplug frequently enough
> to care?

Well, I would not say it is critical, it just regresses the time
hotplug operations take. How bad is that? I guess it depends.
Memory hotplug operations are already slow per se, so I would say
expectations are not that high.

But it speeds up the process, that is for sure.

e.g: In a system with 144 CPUs and 2 Numa-nodes,
set_migration_target_nodes()
gets called exactly 144 times at boot time(one per every time a CPU is
brought up), where only 2 calls would suffice, so you can get an idea.

> If "yes" then I'm inclined to merge this up for 5.18 with a cc:stable. 
> Not for 5.17 because it's late and things are looking rather creaky
> already.
> 
> And I'll add a
> 
> Fixes: 884a6e5d1f93b ("mm/migrate: update node demotion order on hotplug events")
> 
> which is that patch's fourth such bouquet.

Thanks Andrew!


-- 
Oscar Salvador
SUSE Labs
