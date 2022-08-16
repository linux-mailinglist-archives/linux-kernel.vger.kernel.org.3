Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14A595FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiHPQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiHPQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:15:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276474BB8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:15:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01FF81FEFF;
        Tue, 16 Aug 2022 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660666534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JGYCZIggGlfUIHHMzwz/KU8LokBSNlpoRhr1ubb2OWI=;
        b=oFRDnSle8pJQBHcgnhkNaQzeVB8Z20yS3Cw6GlE2bZ6Mbnv1aYhStEl9usVeaB0UHCoqzo
        WERwWWdn7MQr53IKJsSOgzl65MjAcejPC+oHdEIY4m7+5KsV4CbfW8f5Cv57ILc+luGuQI
        +NZJfy3cbNjPqZWEr0TDHl7u7UW4AjA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4489139B7;
        Tue, 16 Aug 2022 16:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yLrrMKXC+2K/NAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 16 Aug 2022 16:15:33 +0000
Date:   Tue, 16 Aug 2022 18:15:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        pasha.tatashin@soleen.com, sieberf@amazon.com, shakeelb@google.com,
        sjpark@amazon.de, dhowells@redhat.com, willy@infradead.org,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YvvCpW0ep9N8CbDr@dhcp22.suse.cz>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
 <286e47e7-3d63-133c-aa6c-05100b557d42@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286e47e7-3d63-133c-aa6c-05100b557d42@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-08-22 15:04:01, Charan Teja Kalla wrote:
[...]
> >> @@ -183,19 +184,26 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
> >>  noinline void __set_page_owner(struct page *page, unsigned short order,
> >>  					gfp_t gfp_mask)
> >>  {
> >> -	struct page_ext *page_ext = lookup_page_ext(page);
> >> +	struct page_ext *page_ext = page_ext_get(page);
> >>  	depot_stack_handle_t handle;
> >>  
> >>  	if (unlikely(!page_ext))
> >>  		return;
> > Either add a comment like this
> > 	/* save_stack can sleep in general so we have to page_ext_put */
> 
> 
> Vlastimil suggested to go for save stack first since !page_ext is mostly
> unlikely.  Snip from his comments:
> Why not simply do the save_stack() first and then page_ext_get() just
> once? It should be really rare that it's NULL, so I don't think we save
> much by avoiding an unnecessary save_stack(), while the overhead of
> doing two get/put instead of one will affect every call.

right see below
> 
> https://lore.kernel.org/all/f5fd4942-b03e-1d1c-213b-9cd5283ced91@suse.cz/
> >> +	page_ext_put();
> >>  
> >>  	handle = save_stack(gfp_mask);
> > or just drop the initial page_ext_get altogether. This function is
> > called only when page_ext is supposed to be initialized and !page_ext
> > case above should be very unlikely. Or is there any reason to keep this?

^^^^^
-- 
Michal Hocko
SUSE Labs
