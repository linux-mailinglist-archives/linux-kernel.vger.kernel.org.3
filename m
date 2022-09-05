Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DAA5AD197
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiIELbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiIELbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:31:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F958DF9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:31:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE67A5FD4F;
        Mon,  5 Sep 2022 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662377463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jzv7p7mWnJpzEKfXFeYlUoUTdDmCc5e2LsD6bqOO4z8=;
        b=ch1mRR9TjNUDND0PSuYzTWQ+6mBEj2pmJl1DM8Br/6sc1HUoQAv3YN7Fdg3mZWtfmbc2FT
        rhgPkzJT5cyTUUTvoQuEiVB3mPWxyF6e5TcjU3wDkdBjn/Gy6nLkRTaLZlI7x70Ls4icrn
        HfxQSwV79RwWPwgALFbI36BClEiU2Hg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FD45139C7;
        Mon,  5 Sep 2022 11:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGM0JPfdFWMCZgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Sep 2022 11:31:03 +0000
Date:   Mon, 5 Sep 2022 13:31:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management Mailing List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Message-ID: <YxXd9qXnIutFOQZY@dhcp22.suse.cz>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-4-osalvador@suse.de>
 <573c4049045a5ff342ff9998c69dfae7-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573c4049045a5ff342ff9998c69dfae7-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-09-22 17:51:37, Ammar Faizi wrote:
> On Mon, 5 Sep 2022 05:10:12 +0200, Oscar Salvador wrote:
> > +static int page_owner_threshold_show(struct seq_file *p, void *v)
> > +{
> > +	 seq_printf(p, "%lu\n", threshold);
> 
> Remove a slipped leading 0x20 space here (before seq_printf()).
> 
> > +	return 0;
> > +}
> > +
> > +static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> > +					  size_t count, loff_t *pos)
> > +{
> > +	char *kbuf;
> > +	int ret = 0;
> > +
> > +	count = min_t(size_t, count, PAGE_SIZE);
> > +	kbuf = kmalloc(count, GFP_KERNEL);
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +
> > +	if (copy_from_user(kbuf, buf, count)) {
> > +		ret = -EFAULT;
> > +		goto out;
> > +	}
> > +
> > +	kbuf[count - 1] = '\0';
> > +
> > +	ret = kstrtoul(kbuf, 10, &threshold);
> > +
> > +out:
> > +	kfree(kbuf);
> > +	return ret ? ret : count;
> > +}
> 
> Still the same comment on this, kmalloc() is not really needed here.
> Capping the size to PAGE_SIZE (usually 4K) is too big. `unsinged long`
> is 64-bit at most, this means the max val is 18446744073709551615
> (20 chars). The lifetime of @kbuf is very short as well, using a stack
> allocated array of chars is fine?
> 
> Untested:
> 
> static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> 					  size_t count, loff_t *pos)
> {
> 	char kbuf[21];
> 	int ret;
> 
> 	count = min_t(size_t, count, sizeof(kbuf));
> 	if (copy_from_user(kbuf, buf, count))
> 		return -EFAULT;
> 
> 	kbuf[count - 1] = '\0';
> 	ret = kstrtoul(kbuf, 10, &threshold);
> 	return ret ? ret : count;
> }

Isn't there a proc_dointvec counterpart for debugfs?

-- 
Michal Hocko
SUSE Labs
