Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474155EA63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiF1Q5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiF1Q4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:56:31 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D321E1C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:56:16 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id u14so18265865qvv.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jqNLofw/D/PgB2PwZMkDfeM2ZVnMx72QWP1RSRdpmQo=;
        b=pHh6mjp31yvbo8A34LLzMDENTfRddWdvKsjXFp578aFN88WyGnMogyiV3dp3/v5EVH
         4jOMmiR2Qxitr1TmYkZbQU3o55SLX2qqGtZZUkY1NboZ5K9YVba9XWXMJ2HrBeI5rC9P
         mahSZs2mD1JH4sHb3p/1ImusiiICFxQzG4LXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqNLofw/D/PgB2PwZMkDfeM2ZVnMx72QWP1RSRdpmQo=;
        b=FwszwsTWNdBdN+UO74NfrHYM1zFEuOfk6U0Fbg7yc/kTpjuPylXxWQ1IZ5XWcifYt8
         S5jZ9Spq9nzE5AuLGMlHY/hVrTlIJaSA+4bt4usTr/C3DEZf+fK6CoMb5jDIIBxHU8GM
         6Rl4rF2Qik/AS1GYK8zQ0DFExf+0jQTnjW/LgU6oxuRpSTO5lJs42YmQ0TreQcAqtE78
         QI82nRGQTq2mg5GVuV/pX0kiQErCNDCWgBzcaq9hswvKa8lky3raLstOzNAkhjpwuh/C
         yhMY8lxG924a56tsmK5WEYEF8l2yLGD4nywgW+87oIOP4UEddpWfw2a1HRCIg9Zf690g
         tH0w==
X-Gm-Message-State: AJIora8O4Ev3h3Hv90VqegwNRK5/cM4grJTOjcTlmiMTiOveZ94Tbcb3
        GhFFJAYJZb3fXJzKB4l+1355sdN7+wtyupLR
X-Google-Smtp-Source: AGRyM1sudwCjEYgzNWIA35xMKylvU+kWeJ9NFoOzHVRhkAOGNX3RF7lsg0poVrifS0ZVdWOcv3Jl1Q==
X-Received: by 2002:a05:6214:1c0f:b0:470:9d07:2f5d with SMTP id u15-20020a0562141c0f00b004709d072f5dmr3204675qvc.12.1656435375174;
        Tue, 28 Jun 2022 09:56:15 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c190-20020ae9edc7000000b006a743b360bcsm10710238qkg.136.2022.06.28.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:56:14 -0700 (PDT)
Date:   Tue, 28 Jun 2022 16:56:14 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <YrsyrmDbfnkpfDEP@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > should return the number of freeable items, but if there are no objects
> > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > should be when we are unable to determine the number of objects, or the
> > > > > cache should be skipped for another reason.
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > >  		atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > >  	}
> > > > >  
> > > > > -	return count;
> > > > > +	return count == 0 ? SHRINK_EMPTY : count;
> > > > >  }
> > > > >  
> > > > >  static unsigned long
> > > > > -- 
> > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > 
> > > > Looks good to me!
> > > > 
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > Now that you mention it, this does look independent of the rest of
> > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > 
> > Thanks Paul and Vlad!
> > 
> > Paul, apologies for being quiet. I have been working on the series and the
> > review comments carefully. I appreciate your help with this work.
> 
> Not a problem.  After all, this stuff is changing some of the trickier
> parts of RCU.  We must therefore assume that some significant time and
> effort will be required to get it right.

To your point about trickier parts of RCU, the v2 series though I tested it
before submitting is now giving me strange results with rcuscale. Sometimes
laziness does not seem to be in effect (as pointed out by rcuscale), other
times I am seeing stalls.

So I have to carefully look through all of this again. I am not sure why I
was not seeing these issues with the exact same code before (frustrated).

thanks,

 - Joel

