Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206015AA66F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiIBDdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiIBDdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:33:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14D4AB063
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:33:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B1F7E20A7E;
        Fri,  2 Sep 2022 03:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662089605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eIdTt/sIs/p9Y5wl0IOT0Yq8IRs/zFnc8Crxg9PtTRo=;
        b=V1uhk2dF/9U+V+IAOcbxe9njvdvA3xHj4GLDsJ9pPFDmko57bd+QSh5b2j9B/3veu28LxX
        YvESnUu4m62LHlYn6M0GW9shUzQyO8WDFM5jLqyeG6pREpI3nKuWDGedYLHf9nZw+EVC0n
        Cs7nusZ2UF1UZ/beb1OTbCwqvmmOpvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662089605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eIdTt/sIs/p9Y5wl0IOT0Yq8IRs/zFnc8Crxg9PtTRo=;
        b=lCcyAGqaOzmiGz+xtHfVjAi03RqCKlGGm29yRFeYGkR9bdVQhFL9+qal7Ux/+HSww6U4Rh
        7QGk9KWYn36K7QCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 234B3133DD;
        Fri,  2 Sep 2022 03:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZMTaBYV5EWNoDgAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 02 Sep 2022 03:33:25 +0000
Date:   Fri, 2 Sep 2022 05:33:23 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ammar Faizi <ammarfaizi2@gmail.com>
Subject: Re: [PATCH 2/3] mm, page_owner: Add page_owner_stacks file to print
 out only stacks and their counter
Message-ID: <YxF5g4Q1rpJztg59@localhost.localdomain>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-3-osalvador@suse.de>
 <9f2ef1ac-c0a1-eb77-8e68-e9a60bc8efd2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f2ef1ac-c0a1-eb77-8e68-e9a60bc8efd2@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:16:44PM +0700, Ammar Faizi wrote:
> On 9/1/22 11:42 AM, Oscar Salvador wrote:
> > +static unsigned long last_stack = 0;
> 
> This @last_stack can just be a static local variable in the new
> function you wrote, read_page_owner_stacks(), since no other
> functions use it.

We could certainly do that.

> 
> > +static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
> > +				      size_t count, loff_t *pos)
> > +{
> > +	char *kbuf;
> > +	int ret = 0;
> > +
> > +	count = min_t(size_t, count, PAGE_SIZE);
> > +	kbuf = kmalloc(count, GFP_KERNEL);
> > +	if (!kbuf)
> > +		return ENOMEM;
> 
> Missing a negative sign, return -ENOMEM;

Oh yes, I overlooked that.

Thanks!


-- 
Oscar Salvador
SUSE Labs
