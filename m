Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C54525CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377945AbiEMHyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377854AbiEMHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:54:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B515A3EF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:54:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 968321F921;
        Fri, 13 May 2022 07:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652428486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ijA/xgUqWRx9xio/21UMMT78f/5jHH4GV/QBK+sDxA=;
        b=vJsHBr8spZUeBnqTnlnQEs2fzM4UELF4AYVTTmJNTTUeHfft1353smZmjErICScE/YSm56
        4mPO4lhVty6ta0wtcjQp99X70RgrN/8YRzGM1LeoEGyYwgj3l1UtbMTD5LTvbWIjIJUPCx
        YQ6Dx/WYhjuUNPAFL0B1TN342lXY0d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652428486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ijA/xgUqWRx9xio/21UMMT78f/5jHH4GV/QBK+sDxA=;
        b=Dl0MBN8rxb0aLplV+2u+DRxg8KKDUplMi9D2gIRw/v5UVYlt8h6wSrVlWqx9df4ssTshhS
        B5l++1SXAOpmvJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE19E13A84;
        Fri, 13 May 2022 07:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cUtcK8UOfmJFTwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 13 May 2022 07:54:45 +0000
Date:   Fri, 13 May 2022 09:54:44 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vvghjk1234@gmail.com, aquini@redhat.com, ddutile@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return
 pfn in the target zone
Message-ID: <Yn4OxDIsl3OfB+6W@localhost.localdomain>
References: <20220511044300.4069-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511044300.4069-1-yamamoto.rei@jp.fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:43:00PM +0900, Rei Yamamoto wrote:
> Prevent returning a pfn outside the target zone in case that not
> aligned with pageblock boundary.
> Otherwise isolate_migratepages_block() would handle pages not in
> the target zone.
> 
> Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/compaction.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index fe915db6149b..de42b8e48758 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1858,6 +1858,8 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>  
>  				update_fast_start_pfn(cc, free_pfn);
>  				pfn = pageblock_start_pfn(free_pfn);
> +				if (pfn < cc->zone->zone_start_pfn)
> +					pfn = cc->zone->zone_start_pfn;
>  				cc->fast_search_fail = 0;
>  				found_block = true;
>  				set_pageblock_skip(freepage);
> -- 
> 2.27.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
