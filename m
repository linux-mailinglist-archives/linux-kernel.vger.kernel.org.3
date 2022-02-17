Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D429D4B9C47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiBQJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:42:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiBQJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:42:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BED13CF9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:42:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78EEF2198B;
        Thu, 17 Feb 2022 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645090929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmVL2GYDhN1VFmtx9IfL5/C+kz1evNxXCS6Kv/s4HgU=;
        b=ZHdJNthK2g0RPIYnVRM/p3Q5ZMW83LBt0jMHt8WtevyBS1WEKFwfKsAOgcYtqDUHm6Rnio
        GnNa1qBidJqRr6FM7RGkv1J5Q5PJs/lQTQ5MKt4UrwzRpNDIQUWJJOaNblUVeFR/rDojyw
        20EPCAEwrQWv/MIluN8mAo96Dr3dqjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645090929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmVL2GYDhN1VFmtx9IfL5/C+kz1evNxXCS6Kv/s4HgU=;
        b=m5plmMifhjqXPOqwW0ysI7NX//dFVlmox3Iba58D5g0v1RSHNuLv2p3lczJbTMAPYI4egg
        yZEUpKn2PsawZlBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5901813BBF;
        Thu, 17 Feb 2022 09:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zd8ZFXEYDmJdKQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 17 Feb 2022 09:42:09 +0000
Message-ID: <25381c82-36b6-e62b-de20-db438bc85adb@suse.cz>
Date:   Thu, 17 Feb 2022 10:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/6] mm/page_alloc: Drain the requested list first during
 bulk free
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220217002227.5739-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 01:22, Mel Gorman wrote:
> Prior to the series, pindex 0 (order-0 MIGRATE_UNMOVABLE) was always
> skipped first and the precise reason is forgotten. A potential reason may
> have been to artificially preserve MIGRATE_UNMOVABLE but there is no reason
> why that would be optimal as it depends on the workload. The more likely
> reason is that it was less complicated to do a pre-increment instead of
> a post-increment in terms of overall code flow. As free_pcppages_bulk()
> now typically receives the pindex of the PCP list that exceeded high,
> always start draining that list.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dfc347a58ea6..635a4e0f70b4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1463,6 +1463,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	 * below while (list_empty(list)) loop.
>  	 */
>  	count = min(pcp->count, count);
> +
> +	/* Ensure requested pindex is drained first. */
> +	pindex = pindex - 1;
> +
>  	while (count > 0) {
>  		struct list_head *list;
>  		int nr_pages;

