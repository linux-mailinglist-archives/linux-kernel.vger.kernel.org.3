Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325CD5A7847
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiHaH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiHaH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:58:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107318E01;
        Wed, 31 Aug 2022 00:58:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 362F221EE0;
        Wed, 31 Aug 2022 07:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661932717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFdzPnfHj+h3lWsL1pmRPphP+GywB+E2ELsebY/uEm8=;
        b=bbrGGvRm0LpJ5GZ5r4AqNCSlamvajydXEgtSaFSVrmABBFwcGaA7KNuPwVJR+E0oXiZu3k
        n1AlaHMrRRYhuWbWn+v0I+273u8SepSE0YhbFn3IRXhIT/2fCIPi4SA2+EKE8HZJmETVW6
        cNoyCA5Ls4whmRIh14SSKFgS1dCYL40=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171EF13A7C;
        Wed, 31 Aug 2022 07:58:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yyqqKqwUD2PGHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 31 Aug 2022 07:58:36 +0000
Date:   Wed, 31 Aug 2022 09:58:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, vbabka@suse.cz, mgorman@suse.de,
        hch@infradead.org, hannes@cmpxchg.org, dan.carpenter@oracle.com,
        akpm@linux-foundation.org
Subject: Re: +
 mm-reduce-noise-in-show_mem-for-lowmem-allocations-update-fix.patch added to
 mm-unstable branch
Message-ID: <Yw8Uq5rF19qVUQH+@dhcp22.suse.cz>
References: <20220831025744.B7956C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831025744.B7956C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-08-22 19:57:43, Andrew Morton wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-reduce-noise-in-show_mem-for-lowmem-allocations-update-fix
> Date: Tue Aug 30 06:53:22 PM PDT 2022
> 
> fix build, remove unneeded __show_mem() arg
> 
> lib/show_mem.c: In function '__show_mem':
> lib/show_mem.c:17:9: error: too many arguments to function 'show_free_areas'
>    17 |         show_free_areas(filter, nodemask, max_zone_idx);
>       |         ^~~~~~~~~~~~~~~
> In file included from lib/show_mem.c:8:
> ./include/linux/mm.h:1842:28: note: declared here
>  1842 | static void __maybe_unused show_free_areas(unsigned int flags, nodemask_t *nodemask)
>       |                            ^~~~~~~~~~~~~~~
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This should be addressed by
--- 
diff --git a/lib/show_mem.c b/lib/show_mem.c
index ade71096e241..0d7585cde2a6 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -14,7 +14,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 	unsigned long total = 0, reserved = 0, highmem = 0;
 
 	printk("Mem-Info:\n");
-	show_free_areas(filter, nodemask, max_zone_idx);
+	__show_free_areas(filter, nodemask, max_zone_idx);
 
 	for_each_online_pgdat(pgdat) {
 		int zoneid;

-- 
Michal Hocko
SUSE Labs
