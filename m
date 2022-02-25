Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B364C4246
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiBYK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiBYK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:27:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CA213E18
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:27:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l9so3984909pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VlerzNe8eIOBcDIzrEQYUfedpR86glDek4VqS/yVxF4=;
        b=f/PQ5mqnGPq7SOZ8dbS1/E01ZxX6SAV3QqEski4bn2XcCp3R2ffmvFa3+pFaodOI0H
         b/z3P7XQByiHnnE5RGynXmeLdWRfDwSDDcg1sQjSENjOzy8ch869eK/UAGkPvGYdZu73
         ztlPrdOPLgKN5D9jlz70J2IF5VWiFBtONm5kWaM+XnRXqGSjlYvKXsHeWtrAwP/XXCJT
         K6Z/wtdMfT67cRe1TDKe7mPftdXql8+Rs4CoGEABMAY4+phCZ7WXFSTcxLJL+pgUU1en
         AQiwvVu8c/iWVPbk71vFfK0Q54CvQPfpZvzGRH0JAWsxFTJxxqVaZQNnds+uYP3DjLz3
         Bf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlerzNe8eIOBcDIzrEQYUfedpR86glDek4VqS/yVxF4=;
        b=1og/v+6z4cyzMjeyAmxA+m9tAakQyuz0CTaLsmDgyUHvBiarWcMgK1G4s6GJrqYLUr
         gpH4EQj4O5FVCH9uCXV2Xrj/5wmSGdDX1bNBA1IgitLibH5BF7ziNruxE7qr0VECCfaJ
         BhN1Ntrz939LxoZFpTl/kLm2DD6no4VOGBiWWACa5b+ltfv+IJ4cRsqOes/tJuPTTDDf
         wngbNL3wM/8VgfhyEXLdYU6GzHeIcUZ8EeBfpVYbnieteCFBm+NLsSXjdTGokQFT+pNS
         Fimga2vbmAte5gDuTwiFgPcAmIhbjrjT6r94hAddRLoD645Bsn3icuUHIJPK8/MeEiUO
         ubbw==
X-Gm-Message-State: AOAM5308ucdAueHoRxf6qKPw/a/vLZ4UzVK/KxG0PxY0K2NHP92ugOYV
        gaiqqSy0ITxvyju4SgbvvzA=
X-Google-Smtp-Source: ABdhPJzwciMX8b1Hu4D80B19LWnk0yQS5EaCHa/k07xDfMjMGdLZXt34GC/c079Aog48/gFgBt9ZQw==
X-Received: by 2002:a17:903:2c5:b0:14f:4a29:1f64 with SMTP id s5-20020a17090302c500b0014f4a291f64mr7132999plk.90.1645784823669;
        Fri, 25 Feb 2022 02:27:03 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a00229200b004f3cb984582sm2563311pfe.136.2022.02.25.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 02:27:03 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:26:59 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 5/5] mm/slub: Refactor deactivate_slab()
Message-ID: <Yhiu8yZlY6sOW1Zl@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-6-42.hyeyoo@gmail.com>
 <cd4144f5-e769-cf73-ca25-b36f2c4bbf35@suse.cz>
 <YhiikbXALDX6fFyr@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <YhimVo7oKmnMSkYS@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <21c9fa1a-a003-3325-dd92-982ae3102336@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c9fa1a-a003-3325-dd92-982ae3102336@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:07:45AM +0100, Vlastimil Babka wrote:
> On 2/25/22 10:50, Hyeonggon Yoo wrote:
> > On Fri, Feb 25, 2022 at 09:34:09AM +0000, Hyeonggon Yoo wrote:
> >> On Thu, Feb 24, 2022 at 07:16:11PM +0100, Vlastimil Babka wrote:
> >> > On 2/21/22 11:53, Hyeonggon Yoo wrote:
> >> > > Simply deactivate_slab() by removing variable 'lock' and replacing
> >> > > 'l' and 'm' with 'mode'. Instead, remove slab from list and unlock
> >> > > n->list_lock when cmpxchg_double() fails, and then retry.
> >> > > 
> >> > > One slight functional change is releasing and taking n->list_lock again
> >> > > when cmpxchg_double() fails. This is not harmful because SLUB avoids
> >> > > deactivating slabs as much as possible.
> >> > > 
> >> > > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> > 
> >> > Hm I wonder if we could simplify even a bit more. Do we have to actually
> >> > place the slab on a partial (full) list before the cmpxchg, only to remove
> >> > it when cmpxchg fails? Seems it's to avoid anyone else seeing the slab
> >> > un-frozen, but not on the list, which would be unexpected. However if anyone
> >> > sees such slab, they have to take the list_lock first to start working with
> >> > the slab... so this should be safe, because we hold the list_lock here, and
> >> > will place the slab on the list before we release it. But it thus shouldn't
> >> > matter if the placement happens before or after a successful cmpxchg, no? So
> >> > we can only do it once after a successful cmpxchg and need no undo's?
> >> >
> >> 
> >> My thought was similar. But after testing I noticed that &n->list_lock prevents
> >> race between __slab_free() and deactivate_slab().
> >> 
> >> > Specifically AFAIK the only possible race should be with a __slab_free()
> >> > which might observe !was_frozen after we succeed an unfreezing cmpxchg and
> >> > go through the
> >> > "} else { /* Needs to be taken off a list */"
> >> > branch but then it takes the list_lock as the first thing, so will be able
> >> > to proceed only after the slab is actually on the list.
> >> > 
> >> > Do I miss anything or would you agree?
> >> >
> >> 
> >> It's so tricky.
> >> 
> >> I tried to simplify more as you said. Seeing frozen slab on list was not
> >> problem. But the problem was that something might interfere between
> >> cmpxchg_double() and taking spinlock.
> >> 
> >> This is what I faced:
> >> 
> >> 	CPU A				CPU B
> >> deactivate_slab() {			__slab_free() {
> >> 	/* slab is full */
> >> 	slab.frozen = 0;
> >> 	cmpxchg_double();
> >> 						/* Hmm... 
> >> 						slab->frozen == 0 &&
> >> 						slab->freelist != NULL?
> >> 						Oh This must be on the list.. */
> > 						Oh this is wrong.
> > 						slab->freelist must be
> > 						NULL because it's full
> > 						slab.
> > 
> > 						It's more complex
> > 						than I thought...
> > 
> > 
> >> 						spin_lock_irqsave();
> >> 						cmpxchg_double();
> >> 						/* Corruption: slab
> >> 						 * was not yet inserted to
> >> 						 * list but try removing */
> >> 						remove_full();
> >> 						spin_unlock_irqrestore();
> >> 					}
> >> 	spin_lock_irqsave();
> >> 	add_full();
> >> 	spin_unlock_irqrestore();
> >> }
> > 
> > So it was...
> > 
> >  	CPU A				CPU B
> >  deactivate_slab() {			__slab_free() {
> >  	/* slab is full */
> >  	slab.frozen = 0;
> >  	cmpxchg_double();
> >  						/*
> > 							Hmm... 
> > 							!was_frozen &&
> > 							prior == NULL?
> > 							Let's freeze this!
> > 						*/
> > 						put_cpu_partial();
> >  					}
> >  	spin_lock_irqsave();
> 
> Yeah in my proposal I didn't intend to only take spin_lock_irqsave() here.
> My idea for CPU A would be something like:
>
Oh, misunderstood your proposal.
I spent hours figuring what's wrong haha

> spin_lock_irqsave();
> slab.frozen = 0;
> if (cmpxchg_double()); {
> 	/* success */
> 	add_partial(); // (or add_full())
> 	spin_unlock_irqrestore();
> } else {
> 	/* fail */
> 	spin_unlock_irqrestore();
> 	goto redo;
> }
> 	
> So we would still have the list_lock protection around cmpxchg as in the
> current code. We just wouldn't do e.g. add_partial() before cmpxchg, only to
> remove_partial() when cmpxchg failed.

Now I got what you mean...
I think that would work. Will try that.

Thank you for nice proposal!

> 
> >  	add_full();
> > 	/* It's now frozen by CPU B and at the same time on full list */
> >  	spin_unlock_irqrestore();
> > 
> > And &n->list_lock prevents such a race.
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
