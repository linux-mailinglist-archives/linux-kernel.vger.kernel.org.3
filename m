Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E916598FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiHRVts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiHRVtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:49:43 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1598D3D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:49:42 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j1so2152314qvv.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc;
        bh=66ziqk9a5w7AK7kH9XTPaYYarrBuLvsGQCJBJsu7BtQ=;
        b=nZl66Fv5QEQkHJDxU+9vojyR3iHytxTr6LTUctb4uL3/+Lvty+rYxAGPR7SPJJc6KZ
         MmaFUHxuD2o7Q2TIkd83E6A3JbHSH3d76GPToYpJWg7Ey+h4mPNxMtPbKCkbzGP0yhaq
         z/t2UyRgZvF8bc6jSfqS2UPXr0o+KA2qUKxJcT7KtQpNKQvfKRW6KUMe3QURb9kzhmH8
         1lF4c1GTG1ebGYrGd9+uanP2TdYbXIw17SQx/tcls11dvEhcnXhOhz8taIyFw4ioCDtI
         /1CdWe0xDPPmOI1oy6DgzpLQZRxXho9DoqdkabRX7KzWK711Z/XmK2sYYvD884dDN+Z1
         xEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc;
        bh=66ziqk9a5w7AK7kH9XTPaYYarrBuLvsGQCJBJsu7BtQ=;
        b=HDS+tPMMQKR/PuSI8IFcZ6t1CvDXgdzx4/kWRvaf6avV7JnXXlLd1hz4PYVUjCkstA
         JfucvmtPcgRSUlnYcgLKw/XEUMXH/bkl/4gAAh9cdtgB1TWPMyKvoY5U6PLWn6rMa6ZK
         FbbzvT35dP/HZXHt9rvNJGpGAauudZLiqcXcWkDgROeVsR9bfnW3hBVlKYSGy36f6wF5
         sgJJteUojvKohkzUwF9WhEnJqnuDR2ECvlAUwgxFgz465hMOftQTWUt6LGuEyla9QGuq
         NyIwoYZbuQA4NrseXk4U13QWulz/EF3lkPyoYvv/my5y0BU3XdO5vH6Uce4aS9puUMCH
         UItQ==
X-Gm-Message-State: ACgBeo2QcM2SD48Hl8ClwiZW+g7ON0q40YZzYQWo+7Ac/bVrXJk37TxM
        zl0m3po9pi2LgPsIkKUhQFo=
X-Google-Smtp-Source: AA6agR40l+qk0FmwxD/ElHw32dhYgj8oKkrAwoxNU3IbLVmiAGWeDu9Zy0zinouvCCZ+e67gPuR2eQ==
X-Received: by 2002:a05:6214:528d:b0:476:b338:fb6 with SMTP id kj13-20020a056214528d00b00476b3380fb6mr4504608qvb.29.1660859381747;
        Thu, 18 Aug 2022 14:49:41 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v9-20020a05622a014900b00342f8d4d0basm1978729qtw.43.2022.08.18.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:49:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id BC7D327C007B;
        Thu, 18 Aug 2022 17:49:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Aug 2022 17:49:40 -0400
X-ME-Sender: <xms:87P-YgcTplXd3nJKxuZAnNHd5FJSRNL3nVS_MITA_xMsmIZvE60F7g>
    <xme:87P-YiOAOJF_D4nQvKVdUtU1Ge-A4DzWw2HYVc7VBrbdacs1NFpsOBO9UnppYelBy
    bEI8N5YPXIAOfbxHw>
X-ME-Received: <xmr:87P-YhhZ0gmkIZfb4xZmGLpYuKLhdWxlK6Jtn38ZdBFQ9EDwphYQTcuBfwy0wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeitddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:87P-Yl_rnmHCGWvNEKrJwQBjTubkobZfAZvx8vPYYggDnFStEQBaTg>
    <xmx:87P-YstV-fHInACO1AXCAoPRt9Q-C20Vcu-SlCABCsq_I5jSy0ZVIQ>
    <xmx:87P-YsGFSKwvMYHH6SFb9EpedJyjv44rRM1eijRtGyzk51ufYN99lQ>
    <xmx:9LP-YghI6vWHBXcjIAb9mFLnm2yHrDDV-KVFmez-sipzN68TVwZWgg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Aug 2022 17:49:38 -0400 (EDT)
Date:   Thu, 18 Aug 2022 14:49:17 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        kernel@axis.com, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: Panic on warning if panic_on_warn is set
Message-ID: <Yv6z3SlfpmN+ZeV1@boqun-archlinux>
References: <20220818114259.2203505-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818114259.2203505-1-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 18, 2022 at 01:42:58PM +0200, Vincent Whitchurch wrote:
> There does not seem to be any way to get the system to panic if a
> lockdep warning is emitted, since those warnings don't use the normal
> WARN() infrastructure.  Panicking on any lockdep warning can be
> desirable when the kernel is being run in a controlled environment
> solely for the purpose of testing.  Make lockdep respect panic_on_warn
> to allow this, similar to KASAN and others.
> 

I'm not completely against this, but could you explain why you want to
panic on lockdep warning? I assume you want to have a kdump so that you
can understand the lock bugs closely? But lockdep discovers lock issue
possiblity, so it's not an after-the-fact detector. In other words, when
lockdep warns, the deadlock cases don't happen in the meanwhile. And
also lockdep tries very hard to print useful information to locate the
issues.

This patch add lockdep_panic() to a few places, and it's a pain for
maintaining. So why do you want to panic on lockdep warning?

Regards,
Boqun

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  kernel/locking/lockdep.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 64a13eb56078..d184bba02630 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -124,6 +124,12 @@ static __always_inline bool lockdep_enabled(void)
>  	return true;
>  }
>  
> +static void lockdep_panic(void)
> +{
> +	if (panic_on_warn)
> +		panic("panic_on_warn set ...\n");
> +}
> +
>  /*
>   * lockdep_lock: protects the lockdep graph, the hashes and the
>   *               class/list/hash allocators.
> @@ -977,6 +983,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
>  		pr_err("you didn't initialize this object before use?\n");
>  		pr_err("turning off the locking correctness validator.\n");
>  		dump_stack();
> +		lockdep_panic();
>  		return false;
>  	}
>  
> @@ -2051,6 +2058,7 @@ static noinline void print_circular_bug(struct lock_list *this,
>  
>  	printk("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  static noinline void print_bfs_bug(int ret)
> @@ -2607,6 +2615,7 @@ print_bad_irq_dependency(struct task_struct *curr,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  static const char *state_names[] = {
> @@ -2986,6 +2995,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  /*
> @@ -3583,6 +3593,7 @@ static void print_collision(struct task_struct *curr,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  #endif
>  
> @@ -3959,6 +3970,7 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  /*
> @@ -4038,6 +4050,7 @@ print_irq_inversion_bug(struct task_struct *curr,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  /*
> @@ -4703,6 +4716,7 @@ print_lock_invalid_wait_context(struct task_struct *curr,
>  
>  	pr_warn("stack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  
>  	return 0;
>  }
> @@ -4892,6 +4906,7 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  static int __lock_is_held(const struct lockdep_map *lock, int read);
> @@ -5104,6 +5119,7 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  static noinstr int match_held_lock(const struct held_lock *hlock,
> @@ -5795,6 +5811,7 @@ static void print_lock_contention_bug(struct task_struct *curr,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  static void
> @@ -6420,6 +6437,7 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  static inline int not_in_range(const void* mem_from, unsigned long mem_len,
> @@ -6475,6 +6493,7 @@ static void print_held_locks_bug(void)
>  	lockdep_print_held_locks(current);
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  
>  void debug_check_no_locks_held(void)
> @@ -6593,5 +6612,6 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
>  	lockdep_print_held_locks(curr);
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +	lockdep_panic();
>  }
>  EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
> -- 
> 2.34.1
> 
