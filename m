Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282595AA674
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiIBDh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiIBDhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:37:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B62529C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:37:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E877533D70;
        Fri,  2 Sep 2022 03:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662089831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DI3GzIroG9Z+gelwHW3Ud5RXkeyLPq2aEkpI5BDoZSw=;
        b=L2xXFpSmTEGE6FRw07qcHWG0VItqsbhBM2+jeEoRx/z3MpHrP1rnretBF1tisN7yaIssk6
        ZwI3GdIbDPgaQGbtlQMlVUDm7nf1/EvBiNonEnTvldEDxMicKQHY7/zIUPYJXajNnIx0wc
        XEkhtd0b+rQla/eN47IDlst49DM7IB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662089831;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DI3GzIroG9Z+gelwHW3Ud5RXkeyLPq2aEkpI5BDoZSw=;
        b=0bm2D7GTEKl/tCM8+DAcI8dU7ouMBIo0Ve525Q/ZRTSr/Q9HVfFhYL7PTWATjKErOSx8jn
        Py1vqPuOMmVaeOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E62C133DD;
        Fri,  2 Sep 2022 03:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id We8xGGd6EWPBDwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 02 Sep 2022 03:37:11 +0000
Date:   Fri, 2 Sep 2022 05:37:09 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Message-ID: <YxF6ZTY9frF5nUOj@localhost.localdomain>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-4-osalvador@suse.de>
 <YxBwAANmAAivHYA5@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBwAANmAAivHYA5@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:40:32AM +0200, Michal Hocko wrote:
> On Thu 01-09-22 06:42:49, Oscar Salvador wrote:
> [...]
> > +static ssize_t read_page_owner_threshold(struct file *file, char __user *buf,
> > +					 size_t count, loff_t *pos)
> > +{
> > +	char *kbuf;
> > +	int ret = 0;
> > +
> > +	count = min_t(size_t, count, PAGE_SIZE);
> > +
> > +	if (*pos >= count)
> > +		return 0;
> > +
> > +	kbuf = kmalloc(count, GFP_KERNEL);
> 
> No, you do not want to trigger user defined allocation like that. I
> would use seq_file.

Sure, will use that.

Thanks!


-- 
Oscar Salvador
SUSE Labs
