Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD3529E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbiEQJna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245296AbiEQJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:43:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6668847AD5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fQ18bOcZWJMyAOKMn21TJxJUQnxc5EQ7lV5e0eJOw3w=; b=NCJWKwPUDShydKFyRRzQuMq03g
        XLxK2W86U+yT80ivw3iDDPC0RpdoWXMW5hKMEwwhAUpAAZuQj9a84KM8kRKinDxclVfWG7kr2I3C6
        lE08zKXv6LjvnwXJeKSGauLcxiLyVvtrHONlzkyKCRsWuxaPKuuwe6ZCttplx3qQKN9YYPXXU59Ni
        TzBGFzQhUwvwVLboS4Y53SbEww9YPxlu0nLjUUogUfZ+zQMZkN+eA3mfUy+zW2C90OkMUF7d1+fG5
        BYqZbEnk5HWBqER1pCeNxbST2lVmpYee5adlJVSHpzRso4R3PDhsxtrIiQRSrduTjgZdc/RdVqYn6
        PeBm+ZGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqtiX-00AjnR-Es; Tue, 17 May 2022 09:42:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BF043003AA;
        Tue, 17 May 2022 11:42:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAD7C202BC439; Tue, 17 May 2022 11:42:12 +0200 (CEST)
Date:   Tue, 17 May 2022 11:42:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] objtool: fix objtool regression on x32 systems
Message-ID: <YoNt9GhFdKKqjuiu@hirez.programming.kicks-ass.net>
References: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com>
 <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net>
 <alpine.LRH.2.02.2205161145070.30905@file01.intranet.prod.int.rdu2.redhat.com>
 <20220516212517.GP76023@worktop.programming.kicks-ass.net>
 <738a941ba2ff4e2db8f2268b281d9bd5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738a941ba2ff4e2db8f2268b281d9bd5@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:26:42AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 16 May 2022 22:25
> ...
> > A quick look seems to suggest at least all the 'offset' fields should be
> > u64 or something. The only reason that works is because -mcmodel=kernel
> > keeps everything in the 2G range to make s32 immediates work. But it
> > isn't right.
> 
> Offsets in instructions are only 8bit or 32bit.
> The mod/reg/rm and SiB encodings don't support anything else.
> If offsets might be large then they have to be loaded into
> registers - which will slow things down.

Not relevant; these are Elf64_Addr fields, objtool currently uses
'unsigned long' for them, but that goes sideways if ILP32.
