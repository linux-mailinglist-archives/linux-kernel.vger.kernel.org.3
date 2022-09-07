Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B75B5AF8D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIGAGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGAG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:06:29 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85BB870B3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:06:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w18so9409967qki.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0x7lFEYok+4TSXWmfu3YrPmIsD3J9aswacolTfE5TUI=;
        b=OWqGECVLza5tiFQ1B2PGMCjXKvkfCKAFI/EAQlRx29gfMWZYXb02SG4h+vUskenfLh
         RuyRLbUCud/odSEWHEfLD9RdnQ1UMv/x0V3awA3+RPRNBh3tfPMCD5OrHCpaMcH9Nak6
         MDq1GT+QHnFDNxKc90+tfmW3UnR8EZ+gAzSOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0x7lFEYok+4TSXWmfu3YrPmIsD3J9aswacolTfE5TUI=;
        b=uBrMe4y2lFIycGiQtte01EPR9OPfYqeeN7nC5G1C4cpLy4xmWN32h2OwtWgNUpMZau
         TnnxtEcCrGTWKTMJCvY6h7YUuqfQvPVeZnmn4AkHfSj290Qi+dbcxmdk3YpvUJS/sjsI
         DAO8jNI6EbHZiy1PxdAfijtc0lJVG1ffrTnf9Rlvfbf9qf/CMvl6X3GurpGh0A/Ff8ZB
         PfSvjlwh4ZFm5+meiXuz/o2x06t6KQ9eFqDp4/1ezcscFp/hfBgRGK5fSkoEF+9E1XlD
         pM+y3kLilp6D3mHuIQvrfKJi6EZ18DaYPXdH81WS2VDFy9/DSahL+sDyaXCnxpE/xW0t
         nmTA==
X-Gm-Message-State: ACgBeo3mjM151iTFV+F4Q56T6FEkBKQ+/JBay69rSPvkiZ3rkdS5MZu+
        Se0jDkFqS7s/ItX5mzP86iFrMQ==
X-Google-Smtp-Source: AA6agR4uOmaamrYbScMsAINBw3DCa6o+DtlpA/abayjapOLkwoyvHGz/awMqdzEQ2E9PbzUOMtf/QQ==
X-Received: by 2002:a05:620a:130d:b0:6bb:724:1bd9 with SMTP id o13-20020a05620a130d00b006bb07241bd9mr966684qkj.554.1662509187003;
        Tue, 06 Sep 2022 17:06:27 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c8-20020a37e108000000b006b9264191b5sm11733673qkm.32.2022.09.06.17.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 17:06:26 -0700 (PDT)
Date:   Wed, 7 Sep 2022 00:06:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <Yxfggt1/cLBhUi/y@google.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906151757.GA183806@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:17:57PM +0200, Frederic Weisbecker wrote:
> On Tue, Sep 06, 2022 at 03:05:46AM +0000, Joel Fernandes wrote:
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 4dc86274b3e8..b201606f7c4f 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -256,6 +256,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> >  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
> >  }
> >  
> > +/*
> > + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
> > + * can elapse before lazy callbacks are flushed. Lazy callbacks
> > + * could be flushed much earlier for a number of other reasons
> > + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
> > + * left unsubmitted to RCU after those many jiffies.
> > + */
> > +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> > +unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
> 
> Still not static.
> 
> > @@ -293,12 +322,16 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >   * proves to be initially empty, just return false because the no-CB GP
> >   * kthread may need to be awakened in this case.
> >   *
> > + * Return true if there was something to be flushed and it succeeded, otherwise
> > + * false.
> > + *
> 
> This kind of contradict the comment that follows. Not sure you need to add
> that line because the existing comment seem to cover it.
> 
> >   * Note that this function always returns true if rhp is NULL.
> 
> >   */
> >  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -				     unsigned long j)
> > +				     unsigned long j, unsigned long flush_flags)
> >  {
> >  	struct rcu_cblist rcl;
> > +	bool lazy = flush_flags & FLUSH_BP_LAZY;
> >  
> >  	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> > @@ -326,13 +372,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >   * Note that this function always returns true if rhp is NULL.
> >   */
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -				  unsigned long j)
> > +				  unsigned long j, unsigned long flush_flags)
> >  {
> > +	bool ret;
> > +
> >  	if (!rcu_rdp_is_offloaded(rdp))
> >  		return true;
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> >  	rcu_nocb_bypass_lock(rdp);
> > -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> > +	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> > +
> > +	if (flush_flags & FLUSH_BP_WAKE)
> > +		wake_nocb_gp(rdp, true);
> 
> Why the true above?
> 
> Also should we check if the wake up is really necessary (otherwise it means we
> force a wake up for all rdp's from rcu_barrier())?
> 
>        was_alldone = rcu_segcblist_pend_cbs(&rdp->cblist);
>        ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
>        if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
>        	  wake_nocb_gp(rdp, false);

You mean something like the following right? Though I'm thinking if its
better to call wake_nocb_gp() from tree.c in entrain() and let that handle
the wake. That way, we can get rid of the extra FLUSH_BP flags as well and
let the flush callers deal with the wakeups..

Anyway, for testing this should be good...

---8<-----------------------

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index bd8f39ee2cd0..e3344c262672 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, unsigned long flush_flags)
 {
 	bool ret;
+	bool was_alldone;
 
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
+	if (flush_flags & FLUSH_BP_WAKE)
+		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+
 	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
 
-	if (flush_flags & FLUSH_BP_WAKE)
-		wake_nocb_gp(rdp, true);
+	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
+		wake_nocb_gp(rdp, false);
 
 	return ret;
 }
-- 
2.37.2.789.g6183377224-goog

