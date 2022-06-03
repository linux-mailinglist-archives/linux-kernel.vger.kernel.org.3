Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8734853C7F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiFCJvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiFCJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:51:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC636B66;
        Fri,  3 Jun 2022 02:51:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y32so11781543lfa.6;
        Fri, 03 Jun 2022 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=svAaMFjZ4+VkEP4KQDUcJdb5KNRMUW7J/+ROn1WanaU=;
        b=it29IbuY+WJWNxBS6SnjnZDNY+TAUHka2ckpyOsv3FmahI1wV6zi+qutn33ikCn/QI
         cQQqJuwzfCv4jq2xFTZAi6xTR9WQWv7XUxscLrUcFHfePig08ae2Mok4iHvXfF0bkpEg
         7rnughE81acJ0FZBNwhcYlNCJHVlv9/DMDqwkgM6sfM9+wYjLZgQfDGmc99dolqUxBV1
         6h2BlcGxvFZaAUiVIyfejg7flU1h807aVjsoC9DQJYalYxF/kGm836MP915ZkkWmW03L
         TnpHNzEnSG7KzdQ8lSTwF8zrHmo/2elFU7bTdwrCJMki8bIBPo/qC3I1ET6hhLyuZhAG
         3W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=svAaMFjZ4+VkEP4KQDUcJdb5KNRMUW7J/+ROn1WanaU=;
        b=HQXAuZ2TdMaNd9jgTQW/6018zxo+UsUf1CLWJzQqGf3Ftpfo08LRmLmyK1CCczWfT1
         TAfJkuSpcy7oHdDnumL1UAF9qdU0Fn0J7tW3gi/diVfoixJdAJSzFtp1Hi15ppBsdi3V
         Harzo3ey0Wmj3+krCvdA3QrzdTpgEkta1mA1cdCVz6/FgKbIkegnklj+Cyaj6e+oVZiU
         vC52Aat1qH5cKXd3CIMQNeRBbYg+cUaxXk9lC0BvlPHSurfqmxIsfnFYzfg986p4Vvg+
         fbDWOaDwwOpdDFhQayYH6xFMdGUT27as1evwQ1RW8Rvcqp6TFdz82pakatJbA+CCH/PI
         wolw==
X-Gm-Message-State: AOAM530hlerHdpNQAfbACrUZVZuA864danaUe+GqFiBTveZZ0ErUJK8/
        uRg3PQlDnp8qGkgLVEHWVRY=
X-Google-Smtp-Source: ABdhPJzfIQARb6Rm+l5QB9OMYlEfq48ZrCZSxd5jqFNxZv3wgvWQf1u2TG/tejYuB0x98tavZ82rZA==
X-Received: by 2002:a05:6512:3d10:b0:478:f2ae:73c with SMTP id d16-20020a0565123d1000b00478f2ae073cmr13047138lfv.675.1654249896639;
        Fri, 03 Jun 2022 02:51:36 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g2-20020a19e042000000b0047255d211e8sm1484873lfj.279.2022.06.03.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:51:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 3 Jun 2022 11:51:34 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Remove useless monitor_todo flag
Message-ID: <YpnZpopF7dR3NILz@pc638.lan>
References: <20220602080644.432156-1-urezki@gmail.com>
 <YplLK2BcTn2oM0hr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YplLK2BcTn2oM0hr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 02, 2022 at 10:06:43AM +0200, Uladzislau Rezki (Sony) wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > monitor_todo is not needed as the work struct already tracks
> > if work is pending. Just use that to know if work is pending
> > using schedule_delayed_work() helper.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 222d59299a2a..fd16c0b46d9e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3295,7 +3295,6 @@ struct kfree_rcu_cpu_work {
> >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> >   * @lock: Synchronize access to this structure
> >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> >   * @initialized: The @rcu_work fields have been initialized
> >   * @count: Number of objects for which GP not started
> >   * @bkvcache:
> > @@ -3320,7 +3319,6 @@ struct kfree_rcu_cpu {
> >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> >  	raw_spinlock_t lock;
> >  	struct delayed_work monitor_work;
> > -	bool monitor_todo;
> >  	bool initialized;
> >  	int count;
> >  
> > @@ -3500,6 +3498,18 @@ static void kfree_rcu_work(struct work_struct *work)
> >  	}
> >  }
> >  
> > +static bool
> > +need_offload_krc(struct kfree_rcu_cpu *krcp)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < FREE_N_CHANNELS; i++)
> > +		if (krcp->bkvhead[i])
> > +			return true;
> > +
> > +	return !!krcp->head;
> > +}
> 
> Thanks for modifying my original patch to do this, and thanks for giving me
> the attribution for the patch. This function is a nice addition.
> 
It was you who did it :) Actually the second patch depends on it therefore 
i decided to upload it on behalf of you with slight modification hoping that
you would not mind.

>
> For the patch in its entirety:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
Thanks for the review!

--
Uladzislau Rezki
