Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B564F102C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377757AbiDDHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352836AbiDDHos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:44:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CE36169
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:42:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76C391F381;
        Mon,  4 Apr 2022 07:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649058170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+LWlYv9cz7gaJxOzL+xR1zHRqTA1ZXCYk0EA7akS3Q=;
        b=KJgPqp2gTIdVAhpodnARX8ZFr/hA/T/hJ2qux30lf/agq7dwFaBnIXpiK+zFZlz8lyJ1Jt
        ZU+LtfJHQOhv+Hc6+/IF5HPURrA3btikua+yTYwXGrd2+Vio7oZFbF+LhNZMOK+8XnXC2a
        ZaMkenl8WZCubwPR7gcvePE5fAyVufA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649058170;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+LWlYv9cz7gaJxOzL+xR1zHRqTA1ZXCYk0EA7akS3Q=;
        b=lVEFLsp17eaJoj062wqgYZ9ktKh/BXwfi4d94DCDyA7HIiF71X3LBdDtPe2Q2mLxdfanAk
        1QRGCO0ipqB4VqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E17313216;
        Mon,  4 Apr 2022 07:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yh9YEnqhSmKGbQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Apr 2022 07:42:50 +0000
Message-ID: <191c3fd8-b858-06b7-df1f-f2f40490d1b6@suse.cz>
Date:   Mon, 4 Apr 2022 09:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy
 page validation.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220401230804.1658207-1-zi.yan@sent.com>
 <20220401230804.1658207-2-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220401230804.1658207-2-zi.yan@sent.com>
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

On 4/2/22 01:08, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Whenever the buddy of a page is found from __find_buddy_pfn(),
> page_is_buddy() should be used to check its validity. Add a helper
> function find_buddy_page_pfn() to find the buddy page and do the check
> together.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-mm/CAHk-=wji_AmYygZMTsPMdJ7XksMt7kOur8oDfDdniBRMjm4VkQ@mail.gmail.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
