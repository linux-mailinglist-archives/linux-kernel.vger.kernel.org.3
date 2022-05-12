Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2406A5241CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349778AbiELBDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344632AbiELBDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:03:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD306FD0E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:03:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q4so3433086plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ib18wyAnvSIua7ptS/vQLbuy/7W7pnuSm126r6BKOSs=;
        b=luNq9qJhTeqeDz3jT2Otg0cIhK29IpVjShyS2KDcJkwi7jSwu2hMrifrzrMN+6U6+u
         NwYNytU9esey4C8SeY5plISOZTfF4Mf/795/trgQPdZWIrW2wEib3yZbqIOcNXOKPihO
         SbF0keTJDEjxypzqMCtinwlmr7zuItC0HTNSoZO45KyTGZsLlNC0dG8Y+LzbVMksuo9G
         mriKEH5S5uLAgPe85v/cObdBIUhbEJHTtYg4AvS67zUBd236Dnfeezh7SAgQvzOh4/6o
         JLkWna84ndlHWY4T3Pd77NrEH/kjvmQ3kSinhKxiofT4zwcn0XO4ODng52INcp/+Pfaf
         PVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ib18wyAnvSIua7ptS/vQLbuy/7W7pnuSm126r6BKOSs=;
        b=WAolAfSQtR8EN4ib0KibhAbR2+uu2g/koYQg8ruCxJabzYvSavk8fK5Fqb/j7v76Lt
         xISff51birGQqjDZMxxAdeoehTFwYJ5XquS4+qou5JGKBf+i0PIg2HoJ1+Sggiu5TszI
         HoxGp6D/LFA/aB1Z42rirs7F0RK6mq8uIzewbfxdjLuCNhtJjuC18X5wB/FcR62uc1xF
         rjTqYmtKjtQ+SwEdc1rHI18wLaf2V3iv+VYKhg12yUBkD7RmMVaN+nto+BAzESYpbv3R
         iqygBF+NnjN/UJqnY7a659erbBzyiYp6txhrDIrHxHbvUb5x2tHhVp0Xzp2Bn1luhoYZ
         I+2A==
X-Gm-Message-State: AOAM5325/LAglbvi1kTvluMB61/WunwA33CNFGZyY3gkLTOjQN8SFVxK
        4HiaNrGYaK/q3ZwQEdudo1E=
X-Google-Smtp-Source: ABdhPJypZJJ+M7FuetbveO+yXJMaW8UPZDVSuK1xTeClfN77hv8ltvUPBR98KEUR0WPwoIGvGC52Tw==
X-Received: by 2002:a17:902:cf05:b0:156:8445:ce0f with SMTP id i5-20020a170902cf0500b001568445ce0fmr27880201plg.99.1652317392666;
        Wed, 11 May 2022 18:03:12 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b0015e8d4eb252sm2561773pln.156.2022.05.11.18.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:03:12 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 18:03:10 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YnxczoehQJ+x6m9Y@google.com>
References: <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
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

On Wed, May 11, 2022 at 05:49:49PM -0700, Paul E. McKenney wrote:
> On Wed, May 11, 2022 at 05:34:52PM -0700, John Hubbard wrote:
> > On 5/11/22 17:26, Minchan Kim wrote:
> > > > > Let me try to say this more clearly: I don't think that the following
> > > > > __READ_ONCE() statement can actually help anything, given that
> > > > > get_pageblock_migratetype() is non-inlined:
> > > > > 
> > > > > +	int __mt = get_pageblock_migratetype(page);
> > > > > +	int mt = __READ_ONCE(__mt);
> > > > > +
> > > > > +	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> > > > > +		return false;
> > > > > 
> > > > > 
> > > > > Am I missing anything here?
> > > > 
> > > > In the absence of future aggression from link-time optimizations (LTO),
> > > > you are missing nothing.
> > > 
> > > A thing I want to note is Android kernel uses LTO full mode.
> > 
> > Thanks Paul for explaining the state of things.
> > 
> > Minchan, how about something like very close to your original draft,
> > then, but with a little note, and the "&" as well:
> > 
> > int __mt = get_pageblock_migratetype(page);
> > 
> > /*
> >  * Defend against future compiler LTO features, or code refactoring
> >  * that inlines the above function, by forcing a single read. Because, this
> >  * routine races with set_pageblock_migratetype(), and we want to avoid
> >  * reading zero, when actually one or the other flags was set.
> >  */
> > int mt = __READ_ONCE(__mt);
> > 
> > if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> >     return false;
> > 
> > 
> > ...which should make everyone comfortable and protected from the
> > future sins of the compiler and linker teams? :)
> 
> This would work, but it would force a store to the stack and an immediate
> reload.  Which might be OK on this code path.
> 
> But using READ_ONCE() in (I think?) __get_pfnblock_flags_mask()
> would likely generate the same code that is produced today.
> 
> 	word = READ_ONCE(bitmap[word_bitidx]);
> 
> But I could easily have missed a turn in that cascade of functions.  ;-)
> 
> Or there might be some code path that really hates a READ_ONCE() in
> that place.

My worry about chaning __get_pfnblock_flags_mask is it's called
multiple hot places in mm codes so I didn't want to add overhead
to them.
