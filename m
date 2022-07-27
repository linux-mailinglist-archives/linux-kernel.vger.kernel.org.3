Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83B5828D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiG0On5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiG0Onz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:43:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9A2AE14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:43:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 86A9820A53;
        Wed, 27 Jul 2022 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658933033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kkS+z1gyLWQEs6DSXoLJrS0qljn+05KwBGJDeU5VgA=;
        b=TP5m414V+6XnHdBEAv1wa65n7nsYITMHjkZv2UlZAsyg5a8vkHsQtmnscZy3ZUdsO6R7Hv
        3tB5UIpI5HKhcC/3+yfPXC1ce7iVdDdrPrqkDluQUYPHcBhbJ+oZKNDRsly31xWRIG80gG
        7FATyyEAGjzQpHd5pud+uVPoxPT5zWY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B87313A8E;
        Wed, 27 Jul 2022 14:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id seX5FylP4WIdXAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 27 Jul 2022 14:43:53 +0000
Date:   Wed, 27 Jul 2022 16:43:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     tujinjiang@bytedance.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] vmscan: fix potential arbitrary pointer passed to kfree
 in unregister_shrinker
Message-ID: <YuFPKDx90+R3Qc6v@dhcp22.suse.cz>
References: <20220727090700.3238-1-tujinjiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727090700.3238-1-tujinjiang@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Yang Shi]
On Wed 27-07-22 17:07:00, tujinjiang@bytedance.com wrote:
> From: Jinjiang Tu <tujinjiang@bytedance.com>
> 
> when shrinker is registered with SHRINKER_MEMCG_AWARE flag,
> register_shrinker will not initialize shrinker->nr_deferred,
> but the pointer will be passed to kfree in unregister_shrinker
> when the shrinker is unregistered. This leads to kernel crash
> when the shrinker object is dynamically allocated.

Is this a real life problem? I thought shrinkers were pre-zeroed
already. Not that we should be relying on that but it would be good to
mention whether this is a code fortification or something that we should
be really worried about.

> To fix it, this patch initialize shrinker->nr_deferred at the
> beginning of prealloc_shrinker.

It would be great to add
Fixes: 476b30a0949a ("mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers")
 
> Signed-off-by: Jinjiang Tu <tujinjiang@bytedance.com>
> ---
>  mm/vmscan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..06ab5a398971 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -613,6 +613,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  	unsigned int size;
>  	int err;
>  
> +	shrinker->nr_deferred = NULL;
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>  		err = prealloc_memcg_shrinker(shrinker);
>  		if (err != -ENOSYS)

You should be able to move it under SHRINKER_MEMCG_AWARE branch, no?

-- 
Michal Hocko
SUSE Labs
