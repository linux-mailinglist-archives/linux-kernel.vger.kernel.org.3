Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7137E4AC7DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbiBGRqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiBGRj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:39:27 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C11C0401E3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-54-ed;
 t=1644255559; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=1OcmxJk2OvDWG73G4pAq7/+nlEvhi8aORC9/Xya6+Ls=;
 b=skJSYiEROeRdLBRvlg5uybRGp9cxiPOKmua/5/VrltRlMb6TSofYBeJaX9ZUGyAg1Lnjr
 ZIxdfMW+DHN9/7lDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-54-rsa; t=1644255559; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=1OcmxJk2OvDWG73G4pAq7/+nlEvhi8aORC9/Xya6+Ls=;
 b=eoc8p5YNoCReCw2EZOIOZwfKnoffU/z/CN964bhabcwmhMHeL7t14l9bVDyMTWjNehndB
 qd4Lc9709tXxILj3O7IjfauU9rADrt4mpBVVuL5Oo7G69azMohTm/LPOItq8jf0hq4LfqhP
 llWMpGgK8c2qLfl0Unu0gFUAWo/6/UTaAjI5o8C2T9NUE4Hteln+3kRi0G31ti/vEdLuURm
 9KtpOqbv1sAdxEq7ZXK7A3ztUlpWE4Stwv2p7dVlniP9Os7v37/MCpLOTDOeSAP28DsZnkr
 ddwAN/Ibr6Rv4l8fNwKMn50WReE6lqznnEqbqyw0kw489WxtL5UIVg9Ro+vA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 6D766160B2F; Mon,  7 Feb 2022 09:39:19 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:39:19 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH v2 33/35] arm64/mm: attempt speculative mm faults first
Message-ID: <20220207173919.GB12302@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-34-michel@lespinasse.org>
 <YfZWtsC3QIzXR0LI@kernel.org>
 <20220131080729.GA785@lespinasse.org>
 <Yfj2G3oOC6cZx0IL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfj2G3oOC6cZx0IL@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:58:03AM +0200, Mike Rapoport wrote:
> On Mon, Jan 31, 2022 at 12:07:29AM -0800, Michel Lespinasse wrote:
> > On Sun, Jan 30, 2022 at 11:13:26AM +0200, Mike Rapoport wrote:
> > > The speculative page fault implementation here (and for PowerPC as well)
> > > looks very similar to x86. Can we factor it our rather than copy 3 (or
> > > more) times?
> > 
> > In each arch, the speculative code was written along the lines of the
> > existing non-speculative code, so that behavior would be unchanged
> > when speculation succeeds.
> > 
> > Now each arch's existing, non-speculative code paths are quite similar,
> > but they do have small differences as to how they implement various
> > permission checks, protection keys and the like. The same small
> > differences end up being reflected in the new speculative code paths.
> > 
> > I agree it would be nice if this code could be unified between archs,
> > but IMO this should start with the existing non-speculative code -
> > I don't think it would make sense to try unifying the new speculative
> > code while trying to follow the behavior of the non-unified old
> > non-speculative code paths...
> 
> Then maybe this unification can be done as the ground work for the
> speculative page fault handling?

I feel like this is quite unrelated, and that introducing such
artificial dependencies is a bad work habit we have here in linux MM...

That said, unifying the PF code between archs would be an interesting
project on its own. The way I see it, there could be a unified page
fault handler, with some arch specific parts defined as inline
functions.  I can see myself making an x86/arm64/powerpc initial
proposal if there is enough interest for it, but I'm not sure how
extending it to more exotic archs would go - I think this would have
to involve arch maintainers at least for testing purposes, and I'm not
sure if they'd have any bandwidth for such a project...

--
Michel "walken" Lespinasse
