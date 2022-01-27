Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDDF49EA58
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbiA0S10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:27:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:32912 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiA0S1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:27:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EED2B210E4;
        Thu, 27 Jan 2022 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643308043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zk2r/XrL2I9M2jio/MO73dxCfXi5kcNty76XDbfCA04=;
        b=kaCevPFOebUrYtZIeSsQl/Nenll/xKHVI9d26xNpP2Jv/gtiEK40/Qw4N4a6RK0iQlwo9G
        IRnTWdg2dHxScobVExZ1f12j6cBKSeKLR/UHAxa09Xo+bhpjPWfKEYjIyZesXCpGGzfoeH
        Yl4x7QGS3XMe7kto4Rofoe0GSn6EwVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643308043;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zk2r/XrL2I9M2jio/MO73dxCfXi5kcNty76XDbfCA04=;
        b=ekdcCIxU79QmWvRUkgubRlAQ7C5usaznvpUOk5HdZGr9FAns2IyCl6TfpBoAZAiFuBAxxU
        0rjqXJEqMV0FzeDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912EC13D4F;
        Thu, 27 Jan 2022 18:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pSyYIgvk8mFoOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Jan 2022 18:27:23 +0000
Message-ID: <b7f580cb-84f7-5c78-5f68-7ab8f67b0811@suse.cz>
Date:   Thu, 27 Jan 2022 19:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/9] mm: add overflow and underflow checks for
 page->_refcount
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Hugh Dickins <hughd@google.com>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
 <20220126183429.1840447-2-pasha.tatashin@soleen.com>
 <YfGZ/0hhkqVeX04p@casper.infradead.org>
 <CA+CK2bDHkOQbTrK=GbsGbojAj_6gaAX_8w3cBCd_LWqXt--yZA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+CK2bDHkOQbTrK=GbsGbojAj_6gaAX_8w3cBCd_LWqXt--yZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 20:22, Pasha Tatashin wrote:
> On Wed, Jan 26, 2022 at 1:59 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Wed, Jan 26, 2022 at 06:34:21PM +0000, Pasha Tatashin wrote:
>> > The problems with page->_refcount are hard to debug, because usually
>> > when they are detected, the damage has occurred a long time ago. Yet,
>> > the problems with invalid page refcount may be catastrophic and lead to
>> > memory corruptions.
>> >
>> > Reduce the scope of when the _refcount problems manifest themselves by
>> > adding checks for underflows and overflows into functions that modify
>> > _refcount.
>>
>> If you're chasing a bug like this, presumably you turn on page
>> tracepoints.  So could we reduce the cost of this by putting the
>> VM_BUG_ON_PAGE parts into __page_ref_mod() et al?  Yes, we'd need to
>> change the arguments to those functions to pass in old & new, but that
>> should be a cheap change compared to embedding the VM_BUG_ON_PAGE.
> 
> This is not only about chasing a bug. This also about preventing
> memory corruption and information leaking that are caused by ref_count
> bugs from happening.

So you mean it like a security hardening feature, not just debugging? To me
it's dubious to put security hardening under CONFIG_DEBUG_VM. I think it's
just Fedora that uses DEBUG_VM in general production kernels?

> Several months ago a memory corruption bug was discovered by accident:
> an engineer was studying a process core from a production system and
> noticed that some memory does not look like it belongs to the original
> process. We tried to manually reproduce that bug but failed. However,
> later analysis by our team, explained that the problem occured due to
> ref_count bug in Linux, and the bug itself was root caused and fixed
> (mentioned in the cover letter).  This work would have prevented
> similar ref_count bugs from yielding to the memory corruption
> situation.
> 
> Pasha
> 

