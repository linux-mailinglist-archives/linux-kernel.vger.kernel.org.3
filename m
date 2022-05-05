Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05FD51B7C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiEEGOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiEEGOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:14:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C146654
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:11:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k1so3488747pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IBbOZnTSEqAFzOW1mFDCOLOCAD06OzggQKmfl/tqan0=;
        b=ZWAdYohJZEYZJYDIP8h0O3j0RbhgrCZO8fu8ng+dhXIT8lmC5eNuOXl6Vakk6G1jz3
         tPXkormoNX3cF02GUARXqFJT9Bdkq7qHKnNFskzhDel4Dn7zntpVuVEzMUSIlhgLBsTs
         G9yLeMdvdHl/R0V0e4q0PdrvAcB7BZ4QMYBgtPE4XZQjs4KEK4ZA/HQ54Ru99PXnI9Ru
         6fxDrrKntknLkcf17zd4O2/QFys9y66xJVP2TYZ/IRz+QDtungHVesTYCDOJIfOM2ala
         ibIHKCBNnKmXb8RxjieM3BXPaxlmkJspdNN/tk/YlVX+6/tlsRsvuLekuy5bwKZ+vey4
         3x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IBbOZnTSEqAFzOW1mFDCOLOCAD06OzggQKmfl/tqan0=;
        b=LbRGxUsABynkVCIirqwLkH5Np0fsjzsAAlkVqsO9SQpOoy41qyMTEjG41/YwLaR0tH
         Nv1GywxP0ySbZHUsn0cYunqOT3EBs08iQkRUsP9rZsGJ/iCjU2xIIpJMcypczavQRGNb
         DGTl9srOZ0gY0tGv3luk6Gaml9EWe+Q7dx04LFdHYzjYyR8JWeqKdvRzR1bDDX0LP+XR
         EULixK7CP+ZfSwy+a66uQoHLabW1/khso9fFKdknhyoBwQccE17+g4OSbgWL69dGYSFC
         4GZeZ998S00Nm7daFFsK0JUbH7jpDa/4MpT0/LZwoodJ3p+QKD60eYjz16Ptq3UAC/Z3
         /cwA==
X-Gm-Message-State: AOAM530HSilMJvl2NrXsXIcpP1m/zApNk8dc0uixVBTpSy/zkRFMXhNA
        KrLuq7Xk0MvIybsK3LrOoLU=
X-Google-Smtp-Source: ABdhPJyxPgNQtsnhXBAjSa/+0PBF5EszwI+PJ7RFR2HsWS4kXzHZrKX+q6rWHO4BgIUPF6PsAdvPtw==
X-Received: by 2002:a17:90b:3ecd:b0:1dc:94f2:1bc0 with SMTP id rm13-20020a17090b3ecd00b001dc94f21bc0mr4232087pjb.32.1651731066924;
        Wed, 04 May 2022 23:11:06 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8435:b3e7:62fc:4dfa])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b0015e8d4eb2besm546170plb.264.2022.05.04.23.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 23:11:06 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 May 2022 23:11:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnNqeB5tUf6LZ57b@google.com>
References: <20220503170341.1413961-1-minchan@kernel.org>
 <YnHzvV2Uz2ynENnG@casper.infradead.org>
 <YnIBbjRYACzvuZpp@google.com>
 <YnIYofrw/GGEvc0U@casper.infradead.org>
 <YnKhLX+jzJc+2KwB@google.com>
 <YnKwBeRAWwIlEVqy@casper.infradead.org>
 <YnMQp/zJVHu9Qq/S@google.com>
 <YnMdaW67GEDF0Ynr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnMdaW67GEDF0Ynr@casper.infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:42:17AM +0100, Matthew Wilcox wrote:
> On Wed, May 04, 2022 at 04:47:51PM -0700, Minchan Kim wrote:
> > Since this patch introduces a new "contended" field as out param
> > in rmap_walk_control, it's not immutable any longer so remove
> > const keywords on rmap related functions. Since rmap walking
> > is already expensive operation, I doubt the const would help sizable
> > benefit(And we didn't have it until 5.17).
> 
> Um?  If it's now mutable, it surely can't be static as that means it
> would be shared by all callers, and you might write to the new fields
> in one caller and have them interpreted by the other caller!
> 
> Or if it is safe, then the comment needs to not be deleted, but modified
> to explain why it's safe to do so in this instance, and that other
> instances should not copy the approach unless they are similarly safe.

It's safe since rwc.contended is used only when rwc.try_lock is true.

> 
> > diff --git a/mm/page_idle.c b/mm/page_idle.c
> > index fc0435abf909..fdff8c6dcd2d 100644
> > --- a/mm/page_idle.c
> > +++ b/mm/page_idle.c
> > @@ -86,11 +86,8 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
> >  static void page_idle_clear_pte_refs(struct page *page)
> >  {
> >  	struct folio *folio = page_folio(page);
> > -	/*
> > -	 * Since rwc.arg is unused, rwc is effectively immutable, so we
> > -	 * can make it static const to save some cycles and stack.
> > -	 */
> > -	static const struct rmap_walk_control rwc = {
> > +
> > +	static struct rmap_walk_control rwc = {
> >  		.rmap_one = page_idle_clear_pte_refs_one,
> >  		.anon_lock = folio_lock_anon_vma_read,
> >  	};

So, delta is

diff --git a/mm/page_idle.c b/mm/page_idle.c
index fdff8c6dcd2d..bc08332a609c 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -87,6 +87,10 @@ static void page_idle_clear_pte_refs(struct page *page)
 {
        struct folio *folio = page_folio(page);

+       /*
+        * Since rwc.try_lock is unused, rwc is effectively immutable, so we
+        * can make it static to save some cycles and stack.
+        */
        static struct rmap_walk_control rwc = {
                .rmap_one = page_idle_clear_pte_refs_one,
                .anon_lock = folio_lock_anon_vma_read,

