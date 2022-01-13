Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9780E48DAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiAMPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:46:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiAMPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:46:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F129C1F387;
        Thu, 13 Jan 2022 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642088813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMMOJAr/nOnpKZlb714JwJhyEXP557sdSv675jlH2BI=;
        b=KxAtbzDG1pyPsyzqVmQlxbZId53X3xrbCB2dWLLkW8gb+o16O3JGeenJnHjBdXuP6kQ6DZ
        fCtOAqIRH9ZWHRNKfUwzYrTuDoYFeN+702Drbswj4rlrXylg8vPj10uuiV2XAHrHWDo6pP
        d2sTsJpNLve7hosSWaodZJC3E+wJMiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642088813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMMOJAr/nOnpKZlb714JwJhyEXP557sdSv675jlH2BI=;
        b=wS4tK9Fe0o85B2PtNRKsLE0hZKULejN2ObmGQYsEhGPKE564/JjCINO7xD+6s7I9luxB0e
        S2uZWXnfn+ZpdNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97CC11330C;
        Thu, 13 Jan 2022 15:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QLNdJGxJ4GHmHwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Jan 2022 15:46:52 +0000
Message-ID: <0ff40eb4-aa9b-ef12-5278-e9dce2354a59@suse.cz>
Date:   Thu, 13 Jan 2022 16:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 09/66] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-10-Liam.Howlett@oracle.com>
 <4207b5a3-efac-40f3-6b42-6713c9283cdd@suse.cz>
 <20211215180903.huv74nff62lgepsa@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211215180903.huv74nff62lgepsa@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 19:09, Liam Howlett wrote:
>> - the future lookup of address vma->vm_end will return this vma, although
>> the address doesn't belong to it. Wouldn't be surprised if this caused
>> infrequent mysterious bugs?
>>
>> Both will resolve with vmacache removal later, but better still fix this.
> This is certainly worth fixing.  I am surprised that I did not hit a
> random bug as you said above, I would expect it to occur as well.
> Although, I didn't run each patch individually for long unless I was
> tracking down an issue on a rebase.

Ah, it doesn't cause a bug because vmacache_find() checks the boundaries of
vmas in the vmacache.
