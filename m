Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E057C1FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiGUBwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGUBwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:52:14 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F213F05;
        Wed, 20 Jul 2022 18:52:12 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b25so328907qka.11;
        Wed, 20 Jul 2022 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CsU/tNfDXg1CfAo160Rii4oXZzSQ306g6OrfABTbLY8=;
        b=oPB7RRMnCTXVq/LO+25sGqQ0a1yiA1aYG55oF5a6Ea6rk5al7h+UC9x3JvwKvVprsi
         HLwR+35s3wHfVHpRY7UH3j0/6/9d8ParMeCcnLi0CM5b/kXNgXSpOTSRpImN7bHM1Rhd
         5wK9ZFZyYTvO3ZfZPMDKCvQSjqLhp4FZ88zWw/IbGKVeTLVfI8mqcjO7IIuBARv6kOKU
         6IwaYPiwUvDyB8S/D4QXxBQtkiU2+Itq9Dj20ApbfXbFu5xx27YXztjhCrLyiwbB80ly
         ymKudhQ3RtLuxKWR6NLy8I8hOKoQlRtoqZr4zLdNkqlQBWJAPnbYdiDBcDm7HoYB0DpN
         ompw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CsU/tNfDXg1CfAo160Rii4oXZzSQ306g6OrfABTbLY8=;
        b=JK3b7bo9r51kmZ68VhOeDkngtIOhRUXE43QsgXGnE5uWWmaE937cFdzIhf7vitlhRS
         gdHtrF/O7Q1+zRbY1KQtg1b8r4aU+aa39K4BdbvQkzlVizPO2WDafhYwkTXwecnOoQ4c
         jTU/hXKscC6haTFCEEfiWJgXP9SQ3n3txs7KBLfr03ZreRzZ32fO2zV4xLKj8XgRmMj5
         b0tW6A/gVzX28EFG1m8g5wzEWzirmff1T9Ro3s16cmj415AUuiWNlkvVRovKTquYg1Aa
         lpnpa6UIkk6MM0nIsNSGvO/fKfFp25xIXDP2EJuoh1Bq7aC2DReiJlFChuhB6joDFRjW
         tjfA==
X-Gm-Message-State: AJIora8bus4GaqY2wJpX6iEDh/g7EREpGHJtYy8cGd5vc/OtBe75nLwz
        rwArKXsZh7xnI14bxYci6/k=
X-Google-Smtp-Source: AGRyM1v7AaHcQGh5FeV96UeTAAyfnrCeQTI436PXQs12DTEpRUa+cBnhyPvKlND57AVAgsVYTabgFQ==
X-Received: by 2002:a05:620a:4690:b0:6b5:dbd5:e30 with SMTP id bq16-20020a05620a469000b006b5dbd50e30mr15572531qkb.35.1658368331292;
        Wed, 20 Jul 2022 18:52:11 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n14-20020a05622a040e00b0031b18d29864sm509900qtx.64.2022.07.20.18.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 18:52:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2EE8E27C0054;
        Wed, 20 Jul 2022 21:52:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Jul 2022 21:52:10 -0400
X-ME-Sender: <xms:SLHYYiYCeSEU-_r18d2xVhyjZGfwl5eO4CzkwQBcPy7k9anGVySIDw>
    <xme:SLHYYlYqci_8ZYvdGsjbMSfdKXQ-QjS5MMDZ0geABRms6fR_wuzR6T6bLBIVVruD2
    h0_geJW-XgxmBPPIg>
X-ME-Received: <xmr:SLHYYs-iTVjMrSpmq5_o4rgr_z-RKT_MtCdMj17liWzOrjxt64vkYY1EoOlIGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:SLHYYkq4CzcWleK4K0_cYxmez-9V3Iw7m6kXO6pXt4qjgkBRpJ0jDg>
    <xmx:SLHYYtq3C0REBn2yuVZTajmU9sOI33O3U79womvB8dXviyKvFhFh6A>
    <xmx:SLHYYiTACYrzzdaMkyhi2e-6cSJB1io1JBJlF6PCUEZa02ZMLnyt2w>
    <xmx:SbHYYhfddqSClstiYAkzGjEeTpZ5ogZIrcKX99hz67eROT8EekwOXw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Jul 2022 21:52:08 -0400 (EDT)
Date:   Wed, 20 Jul 2022 18:51:45 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH rcu 04/12] rcu: Switch polled grace-period APIs to
 ->gp_seq_polled
Message-ID: <YtixMeMCcqAyeTiH@boqun-archlinux>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
 <20220620225128.3842050-4-paulmck@kernel.org>
 <Ytijki0fkkyKaD9u@boqun-archlinux>
 <20220721010455.GR1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721010455.GR1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:04:55PM -0700, Paul E. McKenney wrote:
[...]
> > > @@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
> > >  	 * before the load from ->gp_seq.
> > >  	 */
> > >  	smp_mb();  /* ^^^ */
> > > -	return rcu_seq_snap(&rcu_state.gp_seq);
> > > +	return rcu_seq_snap(&rcu_state.gp_seq_polled);
> > 
> > I happened to run into this. There is one usage of
> > get_state_synchronize_rcu() in start_poll_synchronize_rcu(), in which
> > the return value of get_state_synchronize_rcu() ("gp_seq") will be used
> > for rcu_start_this_gp(). I don't think this is quite right, because
> > after this change, rcu_state.gp_seq and rcu_state.gp_seq_polled are
> > different values, in fact ->gp_seq_polled is greater than ->gp_seq
> > by how many synchronize_rcu() is called in early boot.
> > 
> > Am I missing something here?
> 
> It does not appear that your are missing anything, sad to say!
> 
> Does the following make it work better?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2122359f0c862..cf2fd58a93a41 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3571,7 +3571,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
>  unsigned long start_poll_synchronize_rcu(void)
>  {
>  	unsigned long flags;
> -	unsigned long gp_seq = get_state_synchronize_rcu();
> +	unsigned long gp_seq = rcu_seq_snap(&rcu_state.gp_seq);

get_state_synchronize_rcu() is still needed, because we need to return
a cookie for polling for this function. Something like below maybe? Hope
I didn't mess up the ordering ;-)

Regards,
Boqun

---------------
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 84d281776688..0f9134871289 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3571,11 +3583,39 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 unsigned long start_poll_synchronize_rcu(void)
 {
        unsigned long flags;
-       unsigned long gp_seq = get_state_synchronize_rcu();
+       unsigned long gp_seq_poll = get_state_synchronize_rcu();
+       unsigned long gp_seq;
        bool needwake;
        struct rcu_data *rdp;
        struct rcu_node *rnp;

+       /*
+        * Need to start a gp if no gp has been started yet.
+        *
+        * Note that we need to snapshot gp_seq after gp_seq_poll, otherwise
+        * consider the follow case:
+        *
+        *      <no gp in progress>     // gp# is 0
+        *      snapshot gp_seq         // gp #2 will be set as needed
+        *      <a gp passed>
+        *                              // gp# is 1
+        *      snapshot gp_seq_poll    // polling gets ready until gp #3
+        *
+        * then the following rcu_start_this_gp() won't mark gp #3 as needed,
+        * and polling won't become ready if others don't start a gp.
+        *
+        * And the following case is fine:
+        *
+        *      <no gp in progress>     // gp# is 0
+        *      snapshot gp_seq_poll    // polling gets ready until gp #2
+        *      <a gp passed>
+        *                              // gp# is 1
+        *      snapshot gp_seq         // gp #3 will be set as needed
+        *
+        * Also note, we rely on the smp_mb() in get_state_synchronize_rcu()
+        * to order the two snapshots.
+        */
+       gp_seq = rcu_seq_snap(&rcu_state.gp_seq);
        lockdep_assert_irqs_enabled();
        local_irq_save(flags);
        rdp = this_cpu_ptr(&rcu_data);
@@ -3585,7 +3625,7 @@ unsigned long start_poll_synchronize_rcu(void)
        raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
        if (needwake)
                rcu_gp_kthread_wake();
-       return gp_seq;
+       return gp_seq_poll;
 }
 EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
