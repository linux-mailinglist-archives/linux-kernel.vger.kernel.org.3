Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4F51BBBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352323AbiEEJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiEEJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:21:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBD4C430
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:17:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8B711F8C4;
        Thu,  5 May 2022 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651742261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JO2wLegCpNrdgi3MVYiqJ6L67Rb0gjmlZdOJuBwN5MM=;
        b=sSKkse/oRcqJDa7vGLj6wdd6ebm7mMtVSS9h+6zEYLBcCAW1soT8G5oD0dIxWc370Z6fHm
        Y7w5gVyHh6whtPv+NxTuZBT3ujK0yyHgisSGfLr9gJLqqz8fmkYmITHwtZfBNkJooMA9Bl
        wRPCa6L3WP/fkQW3MMh56KRYu5tT7Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651742261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JO2wLegCpNrdgi3MVYiqJ6L67Rb0gjmlZdOJuBwN5MM=;
        b=V2qdi7vHEsH96XJaRR4lQFLYLxnB6M+SxzeClu6/tYmb1iLaXfLJB1P6YsGM2D40f3Hn1q
        vqcUJl3Mdb0junDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61F5D13B11;
        Thu,  5 May 2022 09:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8bYlFTWWc2LMJgAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 05 May 2022 09:17:41 +0000
Date:   Thu, 5 May 2022 11:17:39 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/memory_hotplug: Refactor hotadd_init_pgdat and
 try_online_node
Message-ID: <YnOWM1zHKNUNb/Yz@localhost.localdomain>
References: <20220307150725.6810-1-osalvador@suse.de>
 <20220307150725.6810-4-osalvador@suse.de>
 <7946f6ca-fe03-e286-32f9-b22ff1edb52f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7946f6ca-fe03-e286-32f9-b22ff1edb52f@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:35:11PM +0200, David Hildenbrand wrote:
> BUG_ON(ret);
> return ret;
> 
> hm? This will never return :)

Yes, this looks like a brainfart.
It will not return __only__ in the case where register_node_node()
fails, which is what we do right now, but then I do not know why added
"errno -> register_one_node() failed." in the comment.

I might have managed to confuse myself.

Thanks 

-- 
Oscar Salvador
SUSE Labs
