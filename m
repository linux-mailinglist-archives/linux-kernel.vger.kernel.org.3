Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4186583DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiG1LnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiG1LnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:43:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05686591
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:43:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8926E20CB1;
        Thu, 28 Jul 2022 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659008594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z37mKh5am0iSPoxqKLaBh81IaMsu7grRZr2YI8aH0X0=;
        b=HD5aGLQglAN+l0V3+9UbvD3ZMiZLguqIexOkA9AQ1E6/7XvIGAcGmjQsDDAhfxo2DWmgnm
        2ZXJIoud4uNWDv8eLjWgYgki64rfAUBP4gHKQHctQR8FuYSc1YHv4ZH1W8DME5MKKQeKqu
        0rOhlZ9o0QOYcdB8qpRldo5PM3NFqNg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B5E713A7E;
        Thu, 28 Jul 2022 11:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JI6lF1J24mL/EgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 28 Jul 2022 11:43:14 +0000
Date:   Thu, 28 Jul 2022 13:43:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     tujinjiang@bytedance.com
Cc:     shy828301@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmscan: Do not free nr_deferred for memcg aware
 shrinkers
Message-ID: <YuJ2UeYVpSe+21Xs@dhcp22.suse.cz>
References: <20220728091341.20820-1-tujinjiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728091341.20820-1-tujinjiang@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-07-22 17:13:41, tujinjiang@bytedance.com wrote:
> From: Jinjiang Tu <tujinjiang@bytedance.com>
> 
> When a memcg aware shrinker is registered by register_shrinker(),
> shrinker->nr_deferred will not be initialized. But when the shrinker
> is unregistered by unregister_shrinker(), shrinker->nr_deferred
> will be freed.
> 
> Luckily, the memcg aware shrinkers in the current kernel are pre-zeroed.
> But a new memcg aware shrinker may be added in the future, and we should
> not assume the shrinker is pre-zeroed.
> 
> Another unregister API free_prealloced_shrinker() does not assume the
> shrinker is pre-zered and free shrinker->nr_deferred only if it is
> not memcg aware. So unregister_shrinker() should do like
> free_prealloced_shrinker().
> 
> Signed-off-by: Jinjiang Tu <tujinjiang@bytedance.com>
> ---
>  mm/vmscan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..f8a9a5349b6e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -675,8 +675,11 @@ void unregister_shrinker(struct shrinker *shrinker)
>  	down_write(&shrinker_rwsem);
>  	list_del(&shrinker->list);
>  	shrinker->flags &= ~SHRINKER_REGISTERED;
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>  		unregister_memcg_shrinker(shrinker);
> +		up_write(&shrinker_rwsem);
> +		return;
> +	}
>  	up_write(&shrinker_rwsem);
>  
>  	kfree(shrinker->nr_deferred);

Can we get rid of the code duplication?
--- 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..308279414fe8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -632,12 +632,10 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	return 0;
 }
 
-void free_prealloced_shrinker(struct shrinker *shrinker)
+static void __free_shrinker(struct shrinker *shrinker)
 {
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		down_write(&shrinker_rwsem);
 		unregister_memcg_shrinker(shrinker);
-		up_write(&shrinker_rwsem);
 		return;
 	}
 
@@ -645,6 +643,13 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = NULL;
 }
 
+void free_prealloced_shrinker(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	__free_shrinker(shrinker);
+	up_write(&shrinker_rwsem);
+}
+
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
@@ -675,12 +680,9 @@ void unregister_shrinker(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
-	up_write(&shrinker_rwsem);
 
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
+	__free_shrinker(shrinker);
+	up_write(&shrinker_rwsem);
 }
 EXPORT_SYMBOL(unregister_shrinker);
 
-- 
Michal Hocko
SUSE Labs
