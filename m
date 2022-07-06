Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339655695D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiGFXYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiGFXYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:24:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6942C107
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:24:33 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b24so12231841qkn.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+0CAJbOyjsas1X7A1vkt4Tt9nvsPEUgYWuh48Q1k+k=;
        b=PenlFnQtOvbrIVbx4fB+YVDm8+n2VIAMykhGK9G+6FOlTdbYtyu3kLSVEDBSvAlAZ+
         f2iHQnngAIz5qe29sGJ3dPqvpRKJljyOJNLw/Ys3A6QUXGrN78ZyMX69LWl5Llj51iCh
         cUJfiffvUPPuXojlKXmzeGAc1wdSu+BzZ/rxY8iKGbzRZMu/klti1bk8we7qFoFw323K
         oLWCVkfkwi0qc66NFSRSXhQFTsY8JY0zmtLLyCaBIhILkrTAXlr+3mx/2EEXWnaVimwp
         qXpRsEBvRLivejzbm+VqwmBbvWSDRwJW2FEzYqlYA2t1PsOOwBu6WIWBvbGz7VkMvQ69
         1QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/+0CAJbOyjsas1X7A1vkt4Tt9nvsPEUgYWuh48Q1k+k=;
        b=wXBUMHsjmYDZ2ARTi9VoiV4oAwkyPMeA66y0iZfPD9CF7cSM4yNqfpz53ihXZghmcP
         JssV03ts8h3aRz/kNq8SXPDwJQU2rzRIz02HUA6qH2zwY3yzw6Zb1hzJqzUh0s0K8Ad+
         UTyzBhtf4nAgUGXHOtKKjUKNisOuziQDdjkPjckN+PeCyxR9+bDL2r2tit5neV2XLM0W
         CZi4Bua/vSJKbG1nXLVQv+MCM5XtuZtNLllomJMVi3qs3fYW1zHtms2l3GgzaGxXpjMv
         wenuY6Y39+1hlG+rRb2Xlo6Z+MhNpZeQXlGpNiAUHvnZoSfzElLtOjhD2fqqMQAlU1v4
         bTFw==
X-Gm-Message-State: AJIora+9ALnVBN0iapQWKysA9tiqeNi/iVIqZbBi+FXhqZX4T+V1UVxm
        mXDPSbMK10UTwIaPV6cAUNc=
X-Google-Smtp-Source: AGRyM1tCsm1ZSfHuKvJB8/AQX27IlEZAc0dkOVknITzngStP0p9FQANZ25tRLJpDRLfA1/gCwnhsYg==
X-Received: by 2002:a05:620a:46a5:b0:6af:6638:e811 with SMTP id bq37-20020a05620a46a500b006af6638e811mr29589349qkb.35.1657149872026;
        Wed, 06 Jul 2022 16:24:32 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a268400b006aee03a95dfsm30284284qkp.124.2022.07.06.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 16:24:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9E89B27C0054;
        Wed,  6 Jul 2022 19:24:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Jul 2022 19:24:30 -0400
X-ME-Sender: <xms:rhnGYlvpgp-bRAlaw7TlIT_KFL7YWIS211BqUDXzfycsV4EP0uzqrA>
    <xme:rhnGYuc5P9p2GpSoCPBt-RGpeeVsp7g3quq045vMXQpovEdsDamKPL3FOyroiRie7
    3ebWoV5XCAx18hsFA>
X-ME-Received: <xmr:rhnGYoyJRWU7TjEF2My_6-11Jzz_LMBO4q3oZbbOW4Q13Hr0otS7DXkrvoWpbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:rhnGYsPEIhKZAbjvF-htLSEoWtuXKvrPclueJaPdpUiVBBxbhNqqkA>
    <xmx:rhnGYl-9nK8V0ufRtqUovyoV4g61Ki4l7gL2Zjyjpu-sArM7yfYaVQ>
    <xmx:rhnGYsWXWg46DolVNLzMESPRv9HoJ1EWAoyFixVDCibujFjvyw_MqQ>
    <xmx:rhnGYomKxWQC1fTZoiP_18HDSzoTV0yBXhXlTbaptd7pNFxjHAd8Fw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Jul 2022 19:24:29 -0400 (EDT)
Date:   Wed, 6 Jul 2022 16:23:36 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] locking/qspinlock: remove pv_node abstraction
Message-ID: <YsYZeMJHsHwrOAe7@boqun-archlinux>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-2-npiggin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:08AM +1000, Nicholas Piggin wrote:
> There isn't much point trying to separate struct qnode from struct pv_node
> when struct qnode has to know about pv_node anyway.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/locking/qspinlock.c          |  3 ++-
>  kernel/locking/qspinlock_paravirt.h | 34 ++++++++++++-----------------
>  2 files changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 65a9a10caa6f..a0fc21d99199 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -82,7 +82,8 @@
>  struct qnode {
>  	struct mcs_spinlock mcs;
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
> -	long reserved[2];
> +	int			cpu;
> +	u8			state;
>  #endif
>  };
>  
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index e84d21aa0722..b6a175155f36 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -47,12 +47,6 @@ enum vcpu_state {
>  	vcpu_hashed,		/* = pv_hash'ed + vcpu_halted */
>  };
>  
> -struct pv_node {
> -	struct mcs_spinlock	mcs;
> -	int			cpu;
> -	u8			state;
> -};
> -
>  /*
>   * Hybrid PV queued/unfair lock
>   *
> @@ -170,7 +164,7 @@ static __always_inline int trylock_clear_pending(struct qspinlock *lock)
>   */
>  struct pv_hash_entry {
>  	struct qspinlock *lock;
> -	struct pv_node   *node;
> +	struct qnode   *node;
>  };
>  
>  #define PV_HE_PER_LINE	(SMP_CACHE_BYTES / sizeof(struct pv_hash_entry))
> @@ -209,7 +203,7 @@ void __init __pv_init_lock_hash(void)
>  	     offset < (1 << pv_lock_hash_bits);						\
>  	     offset++, he = &pv_lock_hash[(hash + offset) & ((1 << pv_lock_hash_bits) - 1)])
>  
> -static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
> +static struct qspinlock **pv_hash(struct qspinlock *lock, struct qnode *node)
>  {
>  	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
>  	struct pv_hash_entry *he;
> @@ -236,11 +230,11 @@ static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
>  	BUG();
>  }
>  
> -static struct pv_node *pv_unhash(struct qspinlock *lock)
> +static struct qnode *pv_unhash(struct qspinlock *lock)
>  {
>  	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
>  	struct pv_hash_entry *he;
> -	struct pv_node *node;
> +	struct qnode *node;
>  
>  	for_each_hash_entry(he, offset, hash) {
>  		if (READ_ONCE(he->lock) == lock) {
> @@ -264,7 +258,7 @@ static struct pv_node *pv_unhash(struct qspinlock *lock)
>   * in a running state.
>   */
>  static inline bool
> -pv_wait_early(struct pv_node *prev, int loop)
> +pv_wait_early(struct qnode *prev, int loop)
>  {
>  	if ((loop & PV_PREV_CHECK_MASK) != 0)
>  		return false;
> @@ -277,9 +271,9 @@ pv_wait_early(struct pv_node *prev, int loop)
>   */
>  static void pv_init_node(struct mcs_spinlock *node)
>  {
> -	struct pv_node *pn = (struct pv_node *)node;
> +	struct qnode *pn = (struct qnode *)node;
>  
> -	BUILD_BUG_ON(sizeof(struct pv_node) > sizeof(struct qnode));
> +	BUILD_BUG_ON(sizeof(struct qnode) > sizeof(struct qnode));

This line can actually be removed ;-)

Other part looks good to me.

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>  
>  	pn->cpu = smp_processor_id();
>  	pn->state = vcpu_running;
> @@ -292,8 +286,8 @@ static void pv_init_node(struct mcs_spinlock *node)
>   */
>  static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>  {
> -	struct pv_node *pn = (struct pv_node *)node;
> -	struct pv_node *pp = (struct pv_node *)prev;
> +	struct qnode *pn = (struct qnode *)node;
> +	struct qnode *pp = (struct qnode *)prev;
>  	int loop;
>  	bool wait_early;
>  
> @@ -359,7 +353,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>   */
>  static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
>  {
> -	struct pv_node *pn = (struct pv_node *)node;
> +	struct qnode *pn = (struct qnode *)node;
>  
>  	/*
>  	 * If the vCPU is indeed halted, advance its state to match that of
> @@ -402,7 +396,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
>  static u32
>  pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
>  {
> -	struct pv_node *pn = (struct pv_node *)node;
> +	struct qnode *pn = (struct qnode *)node;
>  	struct qspinlock **lp = NULL;
>  	int waitcnt = 0;
>  	int loop;
> @@ -492,7 +486,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
>  __visible void
>  __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
>  {
> -	struct pv_node *node;
> +	struct qnode *node;
>  
>  	if (unlikely(locked != _Q_SLOW_VAL)) {
>  		WARN(!debug_locks_silent,
> @@ -517,14 +511,14 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
>  	node = pv_unhash(lock);
>  
>  	/*
> -	 * Now that we have a reference to the (likely) blocked pv_node,
> +	 * Now that we have a reference to the (likely) blocked qnode,
>  	 * release the lock.
>  	 */
>  	smp_store_release(&lock->locked, 0);
>  
>  	/*
>  	 * At this point the memory pointed at by lock can be freed/reused,
> -	 * however we can still use the pv_node to kick the CPU.
> +	 * however we can still use the qnode to kick the CPU.
>  	 * The other vCPU may not really be halted, but kicking an active
>  	 * vCPU is harmless other than the additional latency in completing
>  	 * the unlock.
> -- 
> 2.35.1
> 
