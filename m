Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA555E0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbiF0VSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiF0VSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:18:16 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096F18B21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:18:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y14so17214946qvs.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6zAww8yEhNK6GLlNUczVyELOljiluEBeFzWM46x8aA=;
        b=CIxqTz7Pb4j+yjZ1SOGQT1ADTPXFC11f8sIu4cWO56ObKpJwM/XR7vVhZtZduCC8ZA
         b8UX0eTC9tm8JcxHzznj5yJ3Y40kqiBNo6ZERLtgeTRijgP2s5zz4xsiBbrWae5utSOC
         tAO1lqmjRPy5WwTUQlp/xkuEP9n/SFAWPWcQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6zAww8yEhNK6GLlNUczVyELOljiluEBeFzWM46x8aA=;
        b=IT+uzkOQrsChNyiekEXWM5PL3d149Um8m/2ddDMxHNMq7pxvuPqo6bq2FsazPQWT5c
         pGhgQFlQLBdQsF+xlOY9xzK9L/kISMqwMLxPCDVc0uzDdI33b8yhABmNX42j/YkwkIly
         sT8greBBq3EkqM0NGCv8J/oWzQi9Q2zMUhFY3Jz5uicU4JT4rWbWJy50LieYjifE4JkT
         cfzRiVuCYb75+frhwqM3DThxyf+1HsI5ToBekhwIR3YjBdlAIhrH5Eb6e/bl6InipAwF
         9sLjLqzBVAnkpqKOI6tqOlQW1XOnEVX3Oj6kDXlvrgqQroYYnY+2oPu9KSrDRqBFJwk3
         +qGw==
X-Gm-Message-State: AJIora8V/LXjCIpdKCXy+xTeckJeSdrEad4V5chISutu3yWBg2tKrj0z
        96OC+u4cVpLnGTKruO583tPLog==
X-Google-Smtp-Source: AGRyM1ttpPclZvOBtCGqavKftRZC+sCxwGzwxyModoS07TXm6rabbdfstrb5jml5Gcb2KLaW+hw9nw==
X-Received: by 2002:a05:622a:120e:b0:315:4464:1dd1 with SMTP id y14-20020a05622a120e00b0031544641dd1mr11013497qtx.654.1656364694457;
        Mon, 27 Jun 2022 14:18:14 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a0f0c00b006a73654c19bsm10080506qkl.23.2022.06.27.14.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:18:14 -0700 (PDT)
Date:   Mon, 27 Jun 2022 21:18:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <YroelcGVNhQj91ab@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > should return the number of freeable items, but if there are no objects
> > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > should be when we are unable to determine the number of objects, or the
> > > cache should be skipped for another reason.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 711679d10cbb..935788e8d2d7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > >  		atomic_set(&krcp->backoff_page_cache_fill, 1);
> > >  	}
> > >  
> > > -	return count;
> > > +	return count == 0 ? SHRINK_EMPTY : count;
> > >  }
> > >  
> > >  static unsigned long
> > > -- 
> > > 2.37.0.rc0.104.g0611611a94-goog
> > > 
> > Looks good to me!
> > 
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Now that you mention it, this does look independent of the rest of
> the series.  I have pulled it in with Uladzislau's Reviewed-by.

Thanks Paul and Vlad!

Paul, apologies for being quiet. I have been working on the series and the
review comments carefully. I appreciate your help with this work.

thanks,

 - Joel

