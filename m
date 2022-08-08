Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1840158C894
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbiHHMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiHHMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:48:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523A7C8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:48:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6DA537AB6;
        Mon,  8 Aug 2022 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659962883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1sGZxl3xXz477fHR3FYxaBFtzx2Vm8TywnLraTFFDk=;
        b=S0bPOeu0jS1g1dwW41BJKGxrsmfb9XkpqQD3GW5l5RNYPfuqNbVdjSarlTb/ze3ttYy+1B
        owAj1pKC1te4bt7lV05SN1mo/iJjqr4SouyiS2b38ExKCBQI65voqCQ22YF7dRKedfFEqW
        CdomP6sYVzOZCaevt4ejYX3yhHGrOyg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5FA913A7C;
        Mon,  8 Aug 2022 12:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bBWjLQMG8WJ/TwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 08 Aug 2022 12:48:03 +0000
Date:   Mon, 8 Aug 2022 14:48:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v5 22/32] mm/memcontrol.c: Convert to printbuf
Message-ID: <YvEGAxMrJwntyuTE@dhcp22.suse.cz>
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-23-willy@infradead.org>
 <YvDcBD7m1ZdQ/bd1@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvDcBD7m1ZdQ/bd1@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-08-22 11:48:53, Michal Hocko wrote:
> On Mon 08-08-22 03:41:18, Matthew Wilcox wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
> > simalar to seq_buf except that it heap allocates the string buffer:
> > here, we were already heap allocating the buffer with kmalloc() so the
> > conversion is trivial.
> 
> The changelog probably needs an update because the oom path doesn't
> allocated and for somebody just reading this patch in isolation the
> PRINTBUF_EXTERN doesn't really seem very obvious.
> 
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> 
> > -static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
> > +static void memory_stat_format(struct printbuf *out, struct mem_cgroup *memcg)
> >  {
> > -	struct seq_buf s;
> >  	int i;
> >  
> > -	seq_buf_init(&s, buf, bufsize);
> > -
> 
> When is the buffer cleared?
> 
> >  	/*
> >  	 * Provide statistics on the state of the memory subsystem as
> >  	 * well as cumulative event counters that show past behavior.
> [...]
> >  #define K(x) ((x) << (PAGE_SHIFT-10))
> > @@ -1573,7 +1570,8 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
> >  void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> >  {
> >  	/* Use static buffer, for the caller is holding oom_lock. */
> > -	static char buf[PAGE_SIZE];
> > +	static char _buf[PAGE_SIZE];
> > +	struct printbuf buf = PRINTBUF_EXTERN(_buf, sizeof(_buf));
> >  
> >  	lockdep_assert_held(&oom_lock);
> 
> the buffer is static here!

And answering to myself. THere is an internal pos field which gets
initialized by PRINTBUF_EXTERN even when not mentioned explicitly
because it gets a default 0 initialization

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
