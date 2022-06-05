Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2F53DAE7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiFEIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEIwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:52:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE827FCF;
        Sun,  5 Jun 2022 01:52:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a15so18991250lfb.9;
        Sun, 05 Jun 2022 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v8sR2hSSQRtiyAhI2wkEkWaYslV5Z9m7G6sKixM8+lY=;
        b=OS/d+UJRqncc3/MgQOGFNnP8uCxvq/thjE2Ov3q2idnktN+dSvs3UzWYC6rNhcPvWy
         5BmLuck1aigJbX1u73f9jaux7CHbZwBonTNmsKNeN4riiGHIqgofULN0qMoIxeTiQS5j
         BRUGz6342cGBkg5onbA4d8pYvjrCfRci7RIZg/yezIugfcyV7bfSpMO97Zjp6DAzk2ts
         l4C5aHAesy81v52tt+TcgbcUCqjiKleCGOjae/X0zVZMp82BViuctJwoPriTwqb81D9M
         lt1O6zkmxvGXHBVu5YVSJrJBicdToP55+r8agjzI0DPH3lTUzJouLjrizKmkmT1VFhLA
         ucuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v8sR2hSSQRtiyAhI2wkEkWaYslV5Z9m7G6sKixM8+lY=;
        b=t4ft0TedGYRnj6KHhucfWS9281N9CtVbI6cfgD/DfpgT8l7cVPbqvP5QwY/jww+qGq
         ZGLwL3GQZJQV9M2M7B7PMYUEO26CNZEOpej4w4teWNr0mKExnuVZ4HraEZE6WRuXeOIT
         HXTrlPSOryXIvTG1o0T2hXUMEeLhI5R9nPdwIMQzEFD05jHBqU5FRe6vKloM09uTRvbV
         pYpwzSycvvHIE5Pnlg6n8VygypzaHO2CRiuxK2NaBwm+657hWd8adlNXAX00LvHLrle3
         2pGUytdMSaJfE5ooy+cIue3xh7uqLVh5AnXkC7wUdDMf/AYWApRfX53xkOIDH65+cx7r
         dUSg==
X-Gm-Message-State: AOAM532eZ3R8eCW9824X5vSXAXVHPPbTgcUzGvnXh2+qs37hZ9dokh5o
        74oRtjaUb03kFNwTNgcTj/o=
X-Google-Smtp-Source: ABdhPJzyl4/0j2yeuGHFZFbRntnxl/Mvvp5gtTnSyOIke4i+mq0HaVbEUcoQCqhmEJCGo+Q8K1i55Q==
X-Received: by 2002:a05:6512:696:b0:478:5a76:d2e with SMTP id t22-20020a056512069600b004785a760d2emr12012104lfe.224.1654419138212;
        Sun, 05 Jun 2022 01:52:18 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g27-20020a2eb5db000000b002539cd7b05dsm2082695ljn.46.2022.06.05.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 01:52:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sun, 5 Jun 2022 10:52:15 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Remove useless monitor_todo flag
Message-ID: <Ypxuv2dnnt2Sp0Zj@pc638.lan>
References: <20220602080644.432156-1-urezki@gmail.com>
 <YplLK2BcTn2oM0hr@google.com>
 <20220604160353.GV1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604160353.GV1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 02, 2022 at 11:43:39PM +0000, Joel Fernandes wrote:
> > On Thu, Jun 02, 2022 at 10:06:43AM +0200, Uladzislau Rezki (Sony) wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > monitor_todo is not needed as the work struct already tracks
> > > if work is pending. Just use that to know if work is pending
> > > using schedule_delayed_work() helper.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
> > >  1 file changed, 16 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 222d59299a2a..fd16c0b46d9e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3295,7 +3295,6 @@ struct kfree_rcu_cpu_work {
> > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > >   * @lock: Synchronize access to this structure
> > >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > > - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> > >   * @initialized: The @rcu_work fields have been initialized
> > >   * @count: Number of objects for which GP not started
> > >   * @bkvcache:
> > > @@ -3320,7 +3319,6 @@ struct kfree_rcu_cpu {
> > >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > >  	raw_spinlock_t lock;
> > >  	struct delayed_work monitor_work;
> > > -	bool monitor_todo;
> > >  	bool initialized;
> > >  	int count;
> > >  
> > > @@ -3500,6 +3498,18 @@ static void kfree_rcu_work(struct work_struct *work)
> > >  	}
> > >  }
> > >  
> > > +static bool
> > > +need_offload_krc(struct kfree_rcu_cpu *krcp)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < FREE_N_CHANNELS; i++)
> > > +		if (krcp->bkvhead[i])
> > > +			return true;
> > > +
> > > +	return !!krcp->head;
> > > +}
> > 
> > Thanks for modifying my original patch to do this, and thanks for giving me
> > the attribution for the patch. This function is a nice addition.
> > 
> > For the patch in its entirety:
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I pulled this one in for testing and further review, thank you both!
> 
> Given the description, I reversed the order of the Signed-off-by
> tags to indicate that the patch came through Uladzislau from Joel.
> 
Thanks! The author is Joel i might messed up with "Signed-off-by" tags :)

--
Uladzislau Rezki
