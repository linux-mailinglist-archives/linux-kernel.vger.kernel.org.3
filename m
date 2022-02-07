Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF24AC7E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbiBGRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbiBGRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:39:54 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA100C0401D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:39:53 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-54-ed;
 t=1644255593; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=tmDPD28soEhWKnT4DxmAlJVsPBF7OE1oQKQpzgysMBQ=;
 b=JWSanQhlWOlcCshcpo0ZLiIFik09w09xx0LOoJpxqM/35WhVvLXux5ETCN/tYTwOPZOmH
 Sz+OEp1YBGocQSbDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-54-rsa; t=1644255593; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=tmDPD28soEhWKnT4DxmAlJVsPBF7OE1oQKQpzgysMBQ=;
 b=azqVTrJC2t9aHb73Mc7K5JF3T+Ei7qWcPfKtwXIkOLCBlUKpwcUefS5+HLMknaaJNR7tX
 09k3gRggYZbk6RtWhH4dLIy/iIqvJ1mtxDJYhJA0vrlg+DDxHMbSwE4oEQZGwu48sFU/O/H
 HKLYjp2GJkyyYBkNbcIspA33ASwU7aZ2YF7ilD7i05GCftosl6T4Gab299dyBrBjS89/M7Y
 ULbWqTUcGqS9ybPDUrMfFx/BhdL2OWcKqfx/Ru7gz73vplukNMscipuB9HYboK/J6I3Mkbm
 8bMdrDEZgMi7U0O5ugo7YkWZPidtJ9w/Vt627tq3RR1wLfmtdri8qwpugHSw==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 8910E160B2F; Mon,  7 Feb 2022 09:39:53 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:39:53 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
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
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 00/35] Speculative page faults
Message-ID: <20220207173953.GD12302@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220131171434.89870a8f1ae294912e7ff19e@linux-foundation.org>
 <YfiY9zRm8BhSp7eA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfiY9zRm8BhSp7eA@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:20:39AM +0000, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 05:14:34PM -0800, Andrew Morton wrote:
> > On Fri, 28 Jan 2022 05:09:31 -0800 Michel Lespinasse <michel@lespinasse.org> wrote:
> > > The next step is to walk down the existing page table tree to find the
> > > current pte entry. This is done with interrupts disabled to avoid
> > > races with munmap().
> > 
> > Sebastian, could you please comment on this from the CONFIG_PREEMPT_RT
> > point of view?
> 
> I am not a fan of this approach.  For other reasons, I think we want to
> switch to RCU-freed page tables, and then we can walk the page tables
> with the RCU lock held.  Some architectures already RCU-free the page
> tables, so I think it's just a matter of converting the rest.

Note - I have no problem with switching to RCU-freed page tables
everywhere when and if we end up needing to. I just don't see that
this need comes from the SPF patchset, so I don't think this should
be introduced as an artificial dependency.

--
Michel "walken" Lespinasse
