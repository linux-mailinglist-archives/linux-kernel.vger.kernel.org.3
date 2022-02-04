Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267F4AA34D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351600AbiBDWle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:41:34 -0500
Received: from server.lespinasse.org ([63.205.204.226]:56713 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiBDWld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:41:33 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-54-ed;
 t=1644014493; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=6XiOkxTd7ZF/eRFGSH0vBhmdjaQxUXpaLiEfJFIQrUA=;
 b=VDZy9V4wnAaM1ZfzB5BN3NDq1QWW0eVo3rMKPHRBV1yyZseuYM+Tq/I1sRDmQPRMrsXX4
 nVtBFZt+2q74xwtBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-54-rsa; t=1644014493; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=6XiOkxTd7ZF/eRFGSH0vBhmdjaQxUXpaLiEfJFIQrUA=;
 b=Yz53iAF3nbAQWs032V+7D18WhqS8KOvhlql59JSibAOJ0hPeaAV5kzjn/p1DukCos3tZZ
 QQOInJMu6ox5qiBKOyscvJ47A+MFiyXZdoJuc0oJTmpziIrZbrg0uJ3rjdxbVJi0W9usE4u
 GkZ3Bz4q24ijmKrUUd/WYTN1VfpDTfZJxZ6FdNRVsTpDdoqrY2n7ZqBjwOQZeuSgCDTe/wd
 l8arsv7KghGR0rLO5YkrjOIgUFXoCXJXBhEDmXUQ8jyHY+ZoBBVnRb3t3QXzlfjqn2SjCTr
 76C1+S1Mwidt8O6+i2LWydFdhp9m28gblWuq4MHEYF4GV8TBUYT6TnnV/u8w==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 2440C160B1D; Fri,  4 Feb 2022 14:41:33 -0800 (PST)
Date:   Fri, 4 Feb 2022 14:41:33 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 12/35] mm: separate mmap locked assertion from find_vma
Message-ID: <20220204224133.GA1559@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-13-michel@lespinasse.org>
 <Yff152H3FFVdQBfy@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yff152H3FFVdQBfy@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 02:44:55PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 28, 2022 at 05:09:43AM -0800, Michel Lespinasse wrote:
> > This adds a new __find_vma() function, which implements find_vma minus
> > the mmap_assert_locked() assertion.
> > 
> > find_vma() is then implemented as an inline wrapper around __find_vma().
> 
> You might like to take inspiration from the maple tree patches
> where we assert that either the RCU lock is held or the mmap_lock
> is held.

I've been considering it, but I'm not sure we want to go that way:
it's not sufficient for the caller to have an RCU read lock,
they also need to do the proper mmap_seq_read_check() after
dereferencing the vma... So I think having this different set of
expectations for the two cases warrants using a different name
to keep things more explicit.

--
Michel "walken" Lespinasse
