Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59604F4EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836543AbiDFAge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572876AbiDERNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:13:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA1E32989
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:11:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BEE1D210FD;
        Tue,  5 Apr 2022 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649178672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXZaguQgzHHMZTiLw5gbfQ9kh4XyH0tzaiUaS6uMhFw=;
        b=P1Niw4x7r4HvoVhVpJmYRniTerVWGNQa6wUn7Ui1YBWr3GPrTv/DDxtfkvC2CYjhu4hPwt
        vRo+RBTSUTI2wSww9e+aNNtAJDjdZK/C+6YaX98Vj07u/ft/IbH09AI6kOOthu2Z+1MU0T
        FXIgvSyFmpbK4wYkorchJoof5s0UgxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649178672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXZaguQgzHHMZTiLw5gbfQ9kh4XyH0tzaiUaS6uMhFw=;
        b=1mPAQK/8Tc5VWkJTuIOTeqpAAr7YKV2IrbOKQ8iV5kuhxX8JwS1ELK4F58khGigxtSLgop
        AGReuck+EL/60AAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB5D113A04;
        Tue,  5 Apr 2022 17:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AY4eKTB4TGK7HwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Apr 2022 17:11:12 +0000
Message-ID: <c56564cd-87f0-25c8-bb78-2bb8d8ad2655@suse.cz>
Date:   Tue, 5 Apr 2022 19:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] mm/page_alloc: add same penalty is enough to get
 round-robin order
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220123013537.20491-1-richard.weiyang@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220123013537.20491-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 02:35, Wei Yang wrote:
> To make node order in round-robin in the same distance group, we add a
> penalty to the first node we got in each round.
> 
> To get a round-robin order in the same distance group, we don't need to
> decrease the penalty since:
> 
>   * find_next_best_node() always iterates node in the same order
>   * distance matters more then penalty in find_next_best_node()
>   * in nodes with the same distance, the first one would be picked up
> 
> So it is fine to increase same penalty when we get the first node in the
> same distance group.

With that logic I'm not even sure if we need nr_online_nodes as penalty or
it could be just 1. Would you know?

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/page_alloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..f27afd517652 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6245,13 +6245,12 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>  static void build_zonelists(pg_data_t *pgdat)
>  {
>  	static int node_order[MAX_NUMNODES];
> -	int node, load, nr_nodes = 0;
> +	int node, nr_nodes = 0;
>  	nodemask_t used_mask = NODE_MASK_NONE;
>  	int local_node, prev_node;
>  
>  	/* NUMA-aware ordering of nodes */
>  	local_node = pgdat->node_id;
> -	load = nr_online_nodes;
>  	prev_node = local_node;
>  
>  	memset(node_order, 0, sizeof(node_order));
> @@ -6263,11 +6262,10 @@ static void build_zonelists(pg_data_t *pgdat)
>  		 */
>  		if (node_distance(local_node, node) !=
>  		    node_distance(local_node, prev_node))
> -			node_load[node] += load;
> +			node_load[node] += nr_online_nodes;
>  
>  		node_order[nr_nodes++] = node;
>  		prev_node = node;
> -		load--;
>  	}
>  
>  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);

