Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37624AD669
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357323AbiBHLZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349659AbiBHKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:06:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09968C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:06:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 777D1210F0;
        Tue,  8 Feb 2022 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644314771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYrORe3vbzcD89PzHSw+5HK7RMII1r7ziVJYHhpEbvY=;
        b=1G97zkUeMoUg2asgGtkKTpcfWDbflaeBjia6xc6toNB3usuLthmDrzmslwlNFDcp3oeajy
        a/CZ4wv+1Axgc0UL23uKPu9gl3y8o9C6oRPqacVZ1cw7Ek2vQutdsydcbSoANblhvK/Lsc
        3UgYFGtuHddoAXHJcsaHpB2nJfDRCvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644314771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYrORe3vbzcD89PzHSw+5HK7RMII1r7ziVJYHhpEbvY=;
        b=BLDJBR5kBFT2606T2KG/4nXiSiOkRNicBmCdSRXn6G+O0k8joXqf3lxJaYSAI3TgAwYQ6n
        n0viQfq9FopNdADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1580D13BF9;
        Tue,  8 Feb 2022 10:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C7R6ApNAAmJUbwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 08 Feb 2022 10:06:11 +0000
Date:   Tue, 8 Feb 2022 11:06:08 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/memory_hotplug: avoid calling zone_intersects()
 for ZONE_NORMAL
Message-ID: <YgJAkJfEffpsmEuj@localhost.localdomain>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207133643.23427-3-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:36:41PM +0800, Miaohe Lin wrote:
> If zid reaches ZONE_NORMAL, the caller will always get the NORMAL zone no
> matter what zone_intersects() returns. So we can save some possible cpu
> cycles by avoid calling zone_intersects() for ZONE_NORMAL.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index cbc67c27e0dd..140809e60e9a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -826,7 +826,7 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
>  	struct pglist_data *pgdat = NODE_DATA(nid);
>  	int zid;
>  
> -	for (zid = 0; zid <= ZONE_NORMAL; zid++) {
> +	for (zid = 0; zid < ZONE_NORMAL; zid++) {
>  		struct zone *zone = &pgdat->node_zones[zid];
>  
>  		if (zone_intersects(zone, start_pfn, nr_pages))
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
