Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E9E5AD207
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiIEMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiIEMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:02:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8985AC42
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:02:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0757738581;
        Mon,  5 Sep 2022 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662379330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/yf/30SPm6WVP7/4R/0HJ1EDnt2Hco2FZTEoWFA9dM=;
        b=oQWxyKzzhEoXAJdAAYzM13AblGSLMnwYYD2a7ZpN1ePAA/2hMybQsaFIZnLh1L7QNz2q+l
        x+ALz/yMCbIGoRt83UmKcRm6S/+XdzXtrYeiGxC3wT7srGb857mOs2259L5gmeg9aRam+M
        e2TUCUWVH4HhYosQ61w/bgmg9w6EX2o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC17E13A66;
        Mon,  5 Sep 2022 12:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aI1dM0HlFWNodQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Sep 2022 12:02:09 +0000
Date:   Mon, 5 Sep 2022 14:02:09 +0200
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
Message-ID: <YxXlQWy8LLEy6rcD@dhcp22.suse.cz>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-4-osalvador@suse.de>
 <573c4049045a5ff342ff9998c69dfae7-ammarfaizi2@gnuweeb.org>
 <YxXd9qXnIutFOQZY@dhcp22.suse.cz>
 <20220905115459.567583-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905115459.567583-1-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-09-22 18:54:59, Ammar Faizi wrote:
> On Mon, 5 Sep 2022 13:31:02 +0200, Michal Hocko wrote:
[...]
> > > static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> > > 					  size_t count, loff_t *pos)
> > > {
> > > 	char kbuf[21];
> > > 	int ret;
> > > 
> > > 	count = min_t(size_t, count, sizeof(kbuf));
> > > 	if (copy_from_user(kbuf, buf, count))
> > > 		return -EFAULT;
> > > 
> > > 	kbuf[count - 1] = '\0';
> > > 	ret = kstrtoul(kbuf, 10, &threshold);
> > > 	return ret ? ret : count;
> > > }
> > 
> > Isn't there a proc_dointvec counterpart for debugfs?
> 
> Ah, well. If that's much simpler, we should go with that. I am not
> familiar proc_dointvec() interface, so I couldn't say about it.

Just to clarify. proc_dointvec is rather specific to proc/sysctl
interface. I was too lazy to look whether debugfs has something similar
available. Maybe writing to debugfs is not all that common but I would
expect a shared code to write a simple value would be there.

-- 
Michal Hocko
SUSE Labs
