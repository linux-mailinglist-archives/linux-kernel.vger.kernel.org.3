Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEF5893D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiHCVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiHCVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:00:07 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613E1FCF9;
        Wed,  3 Aug 2022 14:00:06 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d1so12291622qvs.0;
        Wed, 03 Aug 2022 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AA/axCT0z1EqYosf4XmzpaZPolRTikd9DE7PS6rJ/Qk=;
        b=PLVfpmbw7CZdYz1mtj5UaC4qGYu1PsISy37tdeIrmtQPJQgT4eonxtfjbnImvY+FSa
         2HXTIGEIIvMdLZvZih1lluyJfq+a0aFcsIfA675glquZB6U/hWeQ3kHX38jAooxl1ktV
         wtacNTge2Hao18uAsho5f8S1O1yNaHuZvyMclnf3M6Ctc8mkEk7ftTkF4nVhTmc67Ag/
         ZSv2ShLvoz/P4LGuo3O1Qu8+WdP7uko1g4L8FaiPs1feuU8srqZZStSFL5kFMwfHPqoP
         32eDFsZA5Wqrep3oJQR42ZsmX/bu/ZymQ+bHb5q2JYbmeSkz5GfHiFFJdlZ+U+dFp5Xy
         NZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AA/axCT0z1EqYosf4XmzpaZPolRTikd9DE7PS6rJ/Qk=;
        b=g1VUP0a+mBB4ye0+v5qiK1Foakyf8uzGuMVOsPjgLRzl3AEqbhHOqvpxkHLGfT+KPo
         5ZbUmI+O5TSvx42V0kzGMne46A8dVBxs/z7Xj4vvRS4LhkopES0rXg4/Hdxkk5Km610v
         khTcxDJA9IaQw3YZgWZTHIkOyfWfpszI7iR3q7oUlXVY87AM8nenixlOIJgVQzYNuvsZ
         uoFJFYFMc2tUUo31WaOm7zboGO+0vZ1EqhcRGiLK51JpkuNqBIGiaAXliMcHKTpoookJ
         /tkM3W4CWBxvOcYoBfTqNkkZrPP6NlUxcYKdi7uO9YZD7CvFGUp0/AIK2aj2Fq56a0UD
         qsDg==
X-Gm-Message-State: ACgBeo2tbIDOT9HpQuBnqgkxs8mJRbsGYQXa766Ejhj6k3bz19JY6J4m
        91zO4LqNZceDh858k+Y64hve2F17S+Q=
X-Google-Smtp-Source: AA6agR7d5C3tBJin6jN8J6hmGrzwwa1w9km4LdLcaSijPe9QLOuK+esEZZivPNzJd8bZfwfz4eMyVA==
X-Received: by 2002:a05:6214:c8b:b0:474:5279:4f7d with SMTP id r11-20020a0562140c8b00b0047452794f7dmr23104741qvr.33.1659560405383;
        Wed, 03 Aug 2022 14:00:05 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b006b5f371a19esm14558715qko.111.2022.08.03.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:00:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id BCD5F27C005B;
        Wed,  3 Aug 2022 17:00:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 03 Aug 2022 17:00:03 -0400
X-ME-Sender: <xms:0-HqYkxcEx7K8PxwcDUqBy8bsYjn7iIOb1CozIwjXd1ncc9LCmIMdg>
    <xme:0-HqYoSwMHmqAZQQ86R6eI8MVbvBR89gaAA6l76JJSF_8-T9ljN62BX_mxcKTPW34
    aOHgqQn0hDFlFxAcw>
X-ME-Received: <xmr:0-HqYmUYYoHeUo54ut8e7D1U1D_XFc17_YkUDlizq5YmQjjl9LvyRasTaIz4qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvjedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0-HqYiiNrpCIiVsu7zSht_3vs_O-rqyEJ7MGvchfMCzHtwVgwKh-QQ>
    <xmx:0-HqYmDOR3pMInkkbdwky8PB_nxfixtDKBevOXXrqAgrox1VCiZk1A>
    <xmx:0-HqYjK7Y5WI70WDlaDZA-luJRKX7mtgD0ohKkTTlQOnfg-EnR7HQw>
    <xmx:0-HqYnL-Bodg7vbWzsmPWk5WvfxP-SoOu01PFBxqoRH4snKQSVYAfw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 17:00:02 -0400 (EDT)
Date:   Wed, 3 Aug 2022 13:58:58 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 07/31] locking/spinlock: introduce `__spin_lock_init`
Message-ID: <Yurhktr8WEpn2k9h@boqun-archlinux>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-8-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802015052.10452-8-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:49:54AM +0200, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> A Rust helper (introduced in a later patch) needs to call
> `spin_lock_init` with a passed key, rather than define
> one in place.
> 
> In order to do that, this changes the `spin_lock_init` macro
> to call a new `__spin_lock_init` function which takes the key
> as an extra parameter.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Peter, Will & Waiman, could you take a look at this patch and patch #8?

These two are needed because currently there is no way to convert a C
macro to a Rust macro, a C macro can be called as a function on Rust
side, but that's not quite for generating a static key of lockdep. As
a result, __spin_lock_init() needs to be exposed.

I think these are tiny and harmless, but looking forwards to your
insight ;-)

Regards,
Boqun

> ---
>  include/linux/spinlock.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 5c0c5174155d..ad1c91884ed8 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -326,12 +326,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
>  
>  #ifdef CONFIG_DEBUG_SPINLOCK
>  
> +static inline void __spin_lock_init(spinlock_t *lock, const char *name,
> +				    struct lock_class_key *key)
> +{
> +	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> +}
> +
>  # define spin_lock_init(lock)					\
>  do {								\
>  	static struct lock_class_key __key;			\
>  								\
> -	__raw_spin_lock_init(spinlock_check(lock),		\
> -			     #lock, &__key, LD_WAIT_CONFIG);	\
> +	__spin_lock_init(lock, #lock, &__key);			\
>  } while (0)
>  
>  #else
> -- 
> 2.37.1
> 
> 
