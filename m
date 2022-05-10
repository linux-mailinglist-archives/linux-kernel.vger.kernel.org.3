Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACFA522675
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiEJVoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiEJVom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:44:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549824F0E2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:44:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 202so82610pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cRkXCipLYoGVSRY+467ehg8YbVI5Lg2aleUDMTOtglI=;
        b=gkquX5jr5crJurXv6r1mqypG/v1im8FoW2UmMwNgahqH7DSboWozm0zeWC+m4/oMwh
         gK42fID95D8RAHLKKBCASyeAlvplf7CA04EIuwb6+5Xh039SeDjsYID/k9ORMcYJHthx
         O/nO0MfK3kWmDMZ8LxUsQ9lQEKUwrZyNMD+s7JCsYO79fjBSq0d0qaxZXNVaTE+d33KT
         XD2t927t9Kd/z+WVmTEk5zDDzUXGdovX4ngAweWuS3tqDW0BZiUG+VXSSm3LqFTp4jkt
         ss9ZUWMAp27gq1ahPjZkuSK3p+WpoCOwAUjs01Zo27+5MSYtW1DVPBLc74b61GOQemNi
         76OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cRkXCipLYoGVSRY+467ehg8YbVI5Lg2aleUDMTOtglI=;
        b=4UZYgPROyZK+wxLUYcQ9cqGuM24TThWtMgkD3PiwviNqFeh92+7uFF0/uLK6s6u4YZ
         s7X09u65J7yycRAQcBSI73cJHf3FQepyNAh9aTEztHTu0JddirgjF2gUa2b/kU7fSRor
         mY28W1cB2700a9uTdk9udrcYJsTNrN/Qh0wHruP3yzWgQ2vqkBDtHVXJ6eDeDuvTpFY2
         1p4MWGawC3PMvsQXpTWmlVSEDczieCKuolND4V74xHO8G0TjY3X5u4GLpysd/QcWS7lu
         z6R+lFVtwt30uka6oglOHwpW8ciOzxO5MkWWUkNRMp73DRjCS1I58GQRH876OoQFM7V6
         5tYQ==
X-Gm-Message-State: AOAM530aQvDAQ2IvrzI7TSkYH+upsGW0Yuh24kAqUtviKnE6WL50myhL
        3nSssZ0W1tLrlVgio5vqrhs=
X-Google-Smtp-Source: ABdhPJyqcP+dGUm0MoBmIVRxS1p6FG2rnL9SGbry6JzBovjsPiYSoAwGpXONEDwrBpaDkRsPULHBqQ==
X-Received: by 2002:a63:88c8:0:b0:3ab:1871:13b4 with SMTP id l191-20020a6388c8000000b003ab187113b4mr18513536pgd.85.1652219080430;
        Tue, 10 May 2022 14:44:40 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:c98a:65b0:edca:b69a])
        by smtp.gmail.com with ESMTPSA id n24-20020a056a0007d800b0050dc7628150sm37511pfu.42.2022.05.10.14.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:44:40 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 10 May 2022 14:44:38 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Martin Liu <liumartin@google.com>
Subject: Re: [PATCH v3] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnrcxjN9SRgHS05s@google.com>
References: <20220510171100.48500-1-minchan@kernel.org>
 <Ynqr57CVLPOqwhZa@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynqr57CVLPOqwhZa@cmpxchg.org>
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

On Tue, May 10, 2022 at 02:16:07PM -0400, Johannes Weiner wrote:
> Hi Minchan,
> 
> The patch looks reasonable to me, but one thing stands out:
> 
> On Tue, May 10, 2022 at 10:11:00AM -0700, Minchan Kim wrote:
> > @@ -1391,6 +1391,10 @@ static enum page_references folio_check_references(struct folio *folio,
> >  	if (vm_flags & VM_LOCKED)
> >  		return PAGEREF_ACTIVATE;
> >  
> > +	/* page_referenced didn't work due to lock contention */
> > +	if (referenced_ptes == -1)
> > +		return PAGEREF_KEEP;
> > +
> >  	if (referenced_ptes) {
> >  		/*
> >  		 * All mapped folios start out with page table
> 
> This means contended inactive pages get rotated.
> 
> > @@ -2492,7 +2496,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
> >  		}
> >  
> >  		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> > -				     &vm_flags)) {
> > +				     &vm_flags) > 0) {
> >  			/*
> >  			 * Identify referenced, file-backed active pages and
> >  			 * give them one more trip around the active list. So
> 
> This means contended active pages do NOT get rotated.
> 
> It's a bit of an arbitrary choice what to do with reclaim candidates
> for which you can get no reference information, but staying consistent
> is likely a good idea. My preference would be to just rotate contended
> pages throughout rather than risk dropping the workingset on the floor.
> 
> 		/* Referenced or rmap lock contention: rotate */
> 		if (folio_referenced() != 0) {
> 			...
> 
> What do you think?

Sure, it's good start before adding more heuristic later.

Thanks for the review. I will post v4.
