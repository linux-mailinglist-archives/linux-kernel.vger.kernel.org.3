Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8949B169
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiAYKOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:14:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243031AbiAYKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:11:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E0191F380;
        Tue, 25 Jan 2022 10:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643105501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuI+jNij7ZPjm9a8uQJJ8LMvjCha8hdxxOquAm8i2AQ=;
        b=bPcWn+h1KGhccNbv/A0I46rDS1W5ystZ3W6W9y5PQ4iIi1HKpX3dHpkRgdWn+e2b5ZG6eb
        e8n8Eg6z2jCpBgbdfkw+iDpV205rlnTV+ZC0meiv+Pzg6O2pcSgpi+Jtv7QkAbfCIQbXNN
        emogd7htzQ9FmZ1wW8aOu6CKMQVtKVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643105501;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuI+jNij7ZPjm9a8uQJJ8LMvjCha8hdxxOquAm8i2AQ=;
        b=e81ccG092lk1h5kw4iSQLz1bOFgAoZD9AaSu1nfkTcXMMrOq+kGtS7U3Tf4RSnIV0SwXh6
        F+e3pCjJ+Zv39FDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 140F213DAE;
        Tue, 25 Jan 2022 10:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tUIZBN3M72FgXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 25 Jan 2022 10:11:41 +0000
Message-ID: <581f4247-83b1-df39-6724-af0565d0c7ea@suse.cz>
Date:   Tue, 25 Jan 2022 11:11:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        peterz@infradead.org, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
 <20220108081340.3oi2z2rm3cbqozzt@master>
 <20220123013852.mm7eyn3z26v3hkc2@master>
 <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
 <20220124225531.26yyse52yo5x3fr5@master>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220124225531.26yyse52yo5x3fr5@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 23:55, Wei Yang wrote:
> On Mon, Jan 24, 2022 at 11:30:10AM +0100, Vlastimil Babka wrote:
>>On 1/23/22 02:38, Wei Yang wrote:
>>> On Sat, Jan 08, 2022 at 08:13:40AM +0000, Wei Yang wrote:
>>>>On Sat, Jan 08, 2022 at 12:49:53AM +0000, Matthew Wilcox wrote:
>>>>>On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
>>>>
>>>>To me, if folio has the same layout of page, folio meets this requirement. I
>>>>still not catch the point why we need this check here.
>>>>
>>> 
>>> Hi, Matthew
>>> 
>>> Are you back from vocation? If you could give more insight on this check, I
>>> would be appreciated.
>>
>>I can offer my insight (which might be of course wrong). Ideally one day
>>page.lru will be gone and only folio will be used for LRU pages. Then there
>>won't be a  FOLIO_MATCH(lru, lru); and FOLIO_MATCH(compound_head, lru);
>>won't appear to be redundant anymore. lru is list_head so two pointers and
> 
> Thanks for your comment.
> 
> I can't imagine the final result. If we would remove page.lru, we could remove
> FOLIO_MATCH(lru, lru) and add FOLIO_MATCH(compound_head, lru) at that moment?

Yes, or we could forget to do it. Adding it right now is another option that
Matthew has chosen and I don't see a strong reason to change it. Can you
measure a kernel build speedup thanks to removing the now redundant check?

>>thus valid pointers are aligned in such a way they can't accidentaly set the
>>bit 0.
>>
> 

