Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF15AF7FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIFW14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIFW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:27:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC21DF7A;
        Tue,  6 Sep 2022 15:27:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id h27so9289745qkk.9;
        Tue, 06 Sep 2022 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date;
        bh=0QAInJ0rO3zMboDJklVEn7XuhNzPndw7J1Dim+/9qYU=;
        b=q5fqXrb83oFF0SHKb5t4llQCJugKT3iuOfMKSlMiEURbJknWMLUg7UMbrauEDn8gkB
         YU+4Z5Auy4EYBPNyX0C5CpceW8p+xHj+9zWigB5J7nZCWwsPI/Y93+i8qrtxwLQWguiA
         FfFQFZBUKJbYTKpCKmiSR0eQOkquH29sZLWsWGGFEjwsteFEgc7MUiupsar0PmIM9Su4
         u0hP+lJcZx67/dlodScBq7exYxJMLlSpHm6zGDk8D9OPX+T3Dms9y92uY+ZcA9WF0qcv
         wAqcKsjH+z4gfiLPbJJP63LfN20A3XLPnrFPfuPjnzg2sxg7S+MkIHxvDsbVhP4X7nex
         K3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0QAInJ0rO3zMboDJklVEn7XuhNzPndw7J1Dim+/9qYU=;
        b=VK8c6Ocsb+2McojbU91vZ97YwBPo/P+9uIR9xlrtDHalgB9KmMEq7RctVEbv3E6eOK
         o1vKiwdSSfPlZzfvbA1Wrd1ogFV5hYbL/9YQskfb3BSop9HC2uJb+Y/icOc/Z8fKqMry
         mR4msXJv6awNx7tDeuhNt1ph/9+m70gmbmj5cfvg2SwtqYxhB4V7n3/sgRXhLe3CmQ8K
         ZKjbag63p2rJ1Se113T/NJ0eX+kJhdYq5CARQ7l1vkHlJvVYLTC60j4Bs/+RiK0RUSQz
         PppPPbiFSxr9MFlWhFAGFKtZqlvNdRRQbGQwwUSGE4CGFRnB5ErP3z8bm+wjsivgmo7D
         JXwg==
X-Gm-Message-State: ACgBeo3H/bac+q18U/cqPNsbJMe0xBJN/I9HN7Nalr38SGBCc8wft6Bz
        6MpzsElBTuqGPkXqAiUD8Ng=
X-Google-Smtp-Source: AA6agR7k88P3nJjkeozrP/du1MqKUB0DDDznKJoQNOg8jKu2y1mOgggV2i+eymc/QNK1JCtipn8yTA==
X-Received: by 2002:a05:620a:1468:b0:6bb:822d:2c48 with SMTP id j8-20020a05620a146800b006bb822d2c48mr709502qkl.393.1662503271853;
        Tue, 06 Sep 2022 15:27:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q2-20020a05620a0d8200b006b555509398sm12967840qkl.136.2022.09.06.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 15:27:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A50D627C0054;
        Tue,  6 Sep 2022 18:27:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Sep 2022 18:27:50 -0400
X-ME-Sender: <xms:ZskXY_p6gCKU4PVFFRL59-GRrZvVI3V5kg-DJU8NV5JSG5jsStEYAQ>
    <xme:ZskXY5oUn5FFrcr4VUtHs5KnfuYLT-EVUfgo0Nlqk2sKvZo5My3YXnuOl1zz6bDl_
    tx1NF94UAGXaWPfjg>
X-ME-Received: <xmr:ZskXY8N5lm7dGSScDvgMyQ4YVo5DFT5nM0DTfUzADNOd6rxzltFuqNdlfts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ZskXYy52HubPOOE9AH8OU_IVCYR4yXQdxWppOJpbYcUuhOu1ubpTBg>
    <xmx:ZskXY-5p0WsYo7YqxKkAJnvuY6WQydxt7Iryb2LYGmmkEYOI9wfCZQ>
    <xmx:ZskXY6iKpJnFJgu5jCV3-FnrQhSq3b9iS9R2hF-_W2F7GPcV3Y1kfQ>
    <xmx:ZskXY3F-lZRXEbiAW_oOWdEpzKpiqfV8Nv46WAbdXV9Ih7Pr8ppWyw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Sep 2022 18:27:49 -0400 (EDT)
Date:   Tue, 6 Sep 2022 15:26:33 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org
Subject: Re: [PATCH v5 03/18] rcu/tree: Use READ_ONCE() for lockless read of
 rnp->qsmask
Message-ID: <YxfJGYP2l0xbxxdr@boqun-archlinux>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901221720.1105021-4-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:17:05PM +0000, Joel Fernandes (Google) wrote:
> The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
> may help avoid load/store tearing due to concurrent access, KCSAN

Nit: you can avoid only load tearing with READ_ONCE().

Regards,
Boqun

> issues, and preserve sanity of people reading the mask in tracing.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0ca21ac0f064..5ec97e3f7468 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2106,7 +2106,7 @@ int rcutree_dying_cpu(unsigned int cpu)
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
>  
> -	blkd = !!(rnp->qsmask & rdp->grpmask);
> +	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
>  	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
>  			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
>  	return 0;
> -- 
> 2.37.2.789.g6183377224-goog
> 
