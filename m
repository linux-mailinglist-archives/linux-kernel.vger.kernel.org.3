Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC055AA673
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiIBDgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiIBDgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:36:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910C2A27D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:36:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44B2C33D6F;
        Fri,  2 Sep 2022 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662089793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkNCttB8nL0NEMNWZvlIH1QlSGEhIWYoquG6rqGhkS4=;
        b=u/quP4ARFHBcFudmWirOqpVneENd8QUD8egAiOsF70vkDJfMPUDtfPXDqi12XtZyKYWaOv
        xGe552Dw1y/PR9kH2GYQMMl2m2I8tMT0XTsCXNLdojcZjDEXwnsoDj6j3awV9YGL8vAy58
        ag3MaAWpET0+zw+wvnLjQITscmz1Wm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662089793;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkNCttB8nL0NEMNWZvlIH1QlSGEhIWYoquG6rqGhkS4=;
        b=c3yZR+H3YCJUB/52NbGOiumODHmObGSLt8iFdJiiRODpm5UaNl8jH2KS4lY24MFy7KHgOx
        JVxoOkUzLMpyyWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5FCC133DD;
        Fri,  2 Sep 2022 03:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oFutKUB6EWOdDwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 02 Sep 2022 03:36:32 +0000
Date:   Fri, 2 Sep 2022 05:36:31 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Message-ID: <YxF6P++FVKvIUiQq@localhost.localdomain>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-4-osalvador@suse.de>
 <3c69f09e-1e34-73f9-b38b-733971ef38cb@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c69f09e-1e34-73f9-b38b-733971ef38cb@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:31:51PM +0700, Ammar Faizi wrote:
> On 9/1/22 11:42 AM, Oscar Salvador wrote:> +static ssize_t read_page_owner_threshold(struct file *file, char __user *buf,
> > +	kbuf = kmalloc(count, GFP_KERNEL);
> > +	if (!kbuf)
> > +		return ENOMEM;
> 
> Missing a negative sign, return -ENOMEM.

Will fix.

> > +static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> > +					  size_t count, loff_t *pos)
> > +{
> > +	char *kbuf;
> > +	int ret = 0;
> > +
> > +	count = min_t(size_t, count, PAGE_SIZE);
> > +	kbuf = kmalloc(count, GFP_KERNEL);
> 
> This looks overestimating to me. For unsigned long, on a 64-bit system
> has max val 18446744073709551615 (20 chars).
> 
> You can use stack a allocated local variable with length 21. No need
> to use kmalloc(). The same way with the read() op.

Probably could do that, but I'll go with Michal's option and will use
seq_file.

Thanks!


-- 
Oscar Salvador
SUSE Labs
