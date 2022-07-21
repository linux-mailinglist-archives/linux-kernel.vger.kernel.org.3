Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125657C3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiGUFt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGUFty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:49:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064B2DC5;
        Wed, 20 Jul 2022 22:49:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r21so563916qtn.11;
        Wed, 20 Jul 2022 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNX5a0tfW2WJAh5eNBTKobwKPQoqU8dw2jsnN5jkG7w=;
        b=GaJHzn+8ZK3kOKKkiyyC4YOzzCOBRCM0COhhCm04+ZGDivSGwIXMIjMC4SpAekSk2+
         5J7TYK+kAEfaj246wV2xItJ0Cczemv9DdHNERXThoqbVpDAfkjoyJRTR4ONlDbkliLXR
         er8pz7/8eEbnoOODppwIv/5GQ1wS+E1y6MRqtU9LcQg1kK/d7+8q3nnYY1qMWe7x02EG
         YA8V27HMZ45f3JrsaWqy5r67Bu4OIQA2frR9IJGRepjvIJeh73ZsLsTjoqL0akyBjmfg
         2rXQnYPRRj98F0hk38qQjypYswpwWlDealGCpXCCh703pW9RkH76IuJb5u/tk5jFEIDa
         fKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VNX5a0tfW2WJAh5eNBTKobwKPQoqU8dw2jsnN5jkG7w=;
        b=lAf19ieLBzRolEBHE1TkmV6O/1SxCT6jRB35Up2hzW4BaZ/vSBITYC268NmNFp789d
         46K9PPOxKCcCk01ocodIvX1RokhX4rhZ26eLaPKceo9tZOVzvnKwfUTu3rQnLGQFYfJ5
         h8G63UPfc2A5HAn8EgntLv/mVecGC94gJFoVqY7wsGBil2JiA4wAhD2xBb7UREs59bIM
         fCMYPI9+SH/TFpX+t1wlI07LEu0gLDyVp1AX7/N/AcxeDyFECYIoPE2yqPf5eIBfnXpW
         P7yw7JsiMWpAXDILrA/S4N5zqQcS73/Y98UF4AbHmb1PH7h2WOvwBGO3DDWBMdkpb6jb
         gG/w==
X-Gm-Message-State: AJIora/71edWD37cX8auhdYDFu82uqncNqq+uqi8C6fHz8MLAGSfAyOU
        TZBtcMjsLjpSnk36E1h5RU8=
X-Google-Smtp-Source: AGRyM1td7BWqEr9DSNRFQjxKjKe0c9w8TaeNzEd+Bbnh42WDDLAVP3NIrHbutEIDBG5xgeY5vsczCQ==
X-Received: by 2002:ac8:5bcf:0:b0:31e:f981:184a with SMTP id b15-20020ac85bcf000000b0031ef981184amr10557360qtb.653.1658382591861;
        Wed, 20 Jul 2022 22:49:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ca24-20020a05622a1f1800b0031ea864d3b2sm770955qtb.30.2022.07.20.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 22:49:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D006427C005A;
        Thu, 21 Jul 2022 01:49:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Jul 2022 01:49:50 -0400
X-ME-Sender: <xms:_ujYYq9hX_i60Jb4fnHoPwq52ivljWnnDiIR7175fVnmZy5QSN0lwQ>
    <xme:_ujYYqvtqYkPvU_mmDTgKpKiGfiiX4RT0e_ufYgx2Q-KMQijMRzP8OSIqyx7l2l94
    D12CrO2Mf2SdKWX1w>
X-ME-Received: <xmr:_ujYYgAs5qPC4-2tKqilqUPUDcJZyMZ75XBt1vA3G61biYuGJb1Gf6_uriAEdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_ujYYicobGnRa9q63cKeb-nIFy0CB92LSeQZe3LS0Qu9sy26ap2U1w>
    <xmx:_ujYYvPmVyG90sP3bApRhoXIlBA2eOrMMw5hk8ox7W5ucBrYeE56vQ>
    <xmx:_ujYYslD1k5C-BR0RYtzuNn2Vo_T9E21O2XlZxRs-mv3JVC82a76Nw>
    <xmx:_ujYYogUeJGvVsuc6DASL-_h6Eklm48XcOkaOOOZ9ZWi2j09tASO6A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Jul 2022 01:49:49 -0400 (EDT)
Date:   Wed, 20 Jul 2022 22:49:26 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH rcu 04/12] rcu: Switch polled grace-period APIs to
 ->gp_seq_polled
Message-ID: <Ytjo5gPq0TnJEeZY@boqun-archlinux>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
 <20220620225128.3842050-4-paulmck@kernel.org>
 <Ytijki0fkkyKaD9u@boqun-archlinux>
 <20220721010455.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YtixMeMCcqAyeTiH@boqun-archlinux>
 <20220721044708.GU1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721044708.GU1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 09:47:08PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 20, 2022 at 06:51:45PM -0700, Boqun Feng wrote:
> > On Wed, Jul 20, 2022 at 06:04:55PM -0700, Paul E. McKenney wrote:
> > [...]
> > > > > @@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
> > > > >  	 * before the load from ->gp_seq.
> > > > >  	 */
> > > > >  	smp_mb();  /* ^^^ */
> > > > > -	return rcu_seq_snap(&rcu_state.gp_seq);
> > > > > +	return rcu_seq_snap(&rcu_state.gp_seq_polled);
> > > > 
> > > > I happened to run into this. There is one usage of
> > > > get_state_synchronize_rcu() in start_poll_synchronize_rcu(), in which
> > > > the return value of get_state_synchronize_rcu() ("gp_seq") will be used
> > > > for rcu_start_this_gp(). I don't think this is quite right, because
> > > > after this change, rcu_state.gp_seq and rcu_state.gp_seq_polled are
> > > > different values, in fact ->gp_seq_polled is greater than ->gp_seq
> > > > by how many synchronize_rcu() is called in early boot.
> > > > 
> > > > Am I missing something here?
> > > 
> > > It does not appear that your are missing anything, sad to say!
> > > 
> > > Does the following make it work better?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 2122359f0c862..cf2fd58a93a41 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3571,7 +3571,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
> > >  unsigned long start_poll_synchronize_rcu(void)
> > >  {
> > >  	unsigned long flags;
> > > -	unsigned long gp_seq = get_state_synchronize_rcu();
> > > +	unsigned long gp_seq = rcu_seq_snap(&rcu_state.gp_seq);
> > 
> > get_state_synchronize_rcu() is still needed, because we need to return
> > a cookie for polling for this function. Something like below maybe? Hope
> > I didn't mess up the ordering ;-)
> 
> My thought is to combine your comment with my functionally equivalent
> code that avoids the extra variable.  If that works for you (and if it
> works, for that matter), does Co-developed-by work for you?
> 

Sure! Thanks ;-)

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > ---------------
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 84d281776688..0f9134871289 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3571,11 +3583,39 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
> >  unsigned long start_poll_synchronize_rcu(void)
> >  {
> >         unsigned long flags;
> > -       unsigned long gp_seq = get_state_synchronize_rcu();
> > +       unsigned long gp_seq_poll = get_state_synchronize_rcu();
> > +       unsigned long gp_seq;
> >         bool needwake;
> >         struct rcu_data *rdp;
> >         struct rcu_node *rnp;
> > 
> > +       /*
> > +        * Need to start a gp if no gp has been started yet.
> > +        *
> > +        * Note that we need to snapshot gp_seq after gp_seq_poll, otherwise
> > +        * consider the follow case:
> > +        *
> > +        *      <no gp in progress>     // gp# is 0
> > +        *      snapshot gp_seq         // gp #2 will be set as needed
> > +        *      <a gp passed>
> > +        *                              // gp# is 1
> > +        *      snapshot gp_seq_poll    // polling gets ready until gp #3
> > +        *
> > +        * then the following rcu_start_this_gp() won't mark gp #3 as needed,
> > +        * and polling won't become ready if others don't start a gp.
> > +        *
> > +        * And the following case is fine:
> > +        *
> > +        *      <no gp in progress>     // gp# is 0
> > +        *      snapshot gp_seq_poll    // polling gets ready until gp #2
> > +        *      <a gp passed>
> > +        *                              // gp# is 1
> > +        *      snapshot gp_seq         // gp #3 will be set as needed
> > +        *
> > +        * Also note, we rely on the smp_mb() in get_state_synchronize_rcu()
> > +        * to order the two snapshots.
> > +        */
> > +       gp_seq = rcu_seq_snap(&rcu_state.gp_seq);
> >         lockdep_assert_irqs_enabled();
> >         local_irq_save(flags);
> >         rdp = this_cpu_ptr(&rcu_data);
> > @@ -3585,7 +3625,7 @@ unsigned long start_poll_synchronize_rcu(void)
> >         raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >         if (needwake)
> >                 rcu_gp_kthread_wake();
> > -       return gp_seq;
> > +       return gp_seq_poll;
> >  }
> >  EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
