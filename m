Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F9B5893DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiHCVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiHCVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:01:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584BB5A15B;
        Wed,  3 Aug 2022 14:01:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ey23so3910583qtb.11;
        Wed, 03 Aug 2022 14:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T9SVcXZIiypxKKEMmP7A4qTxBDEdXU33xqss3X3ygWk=;
        b=C1lAddsWZ1RVLSuUivimZrRvubzVDowcXx0bUUio1FSzV6kS8n9t1wxtPljzoteFJx
         /XmUbAITw/WetCA2pPTwNvvWz98cTkqSTO0KKPkOPZDbP/IJeJ1gJzWUL3BomNA2H6xL
         w1YOjRx9Ddfq8DYEaSR+gObTtWt6YZ9lmBQo73ZZJ6X2Omc+A6Xqi7Zmi/1yZxoO41qt
         Orp/EQLMasZU4nCkGCb0zvo36LkvEIS691g5fsKsy33XMpDa4zCpXyN/iMq0Jq4lVmR1
         EZ94R/gKZR9CkvFXCEPcUtGkZYo9Xt4y57nOoaYiar3Ng13H6g3PWul0Q9CMnPlFmOBS
         AB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=T9SVcXZIiypxKKEMmP7A4qTxBDEdXU33xqss3X3ygWk=;
        b=FMqlvCgCBqNfTG48E9Lt88LTrOsVSAH67HxVPcfaPh/Lz2UCG4hZ7Ah4BGTlop2k3m
         Rrrdq1UXvh4w+Lyw3UNQklVmxZZkrIFC1jGEAPHJfGoqfeg40KpChgaQJX8eGr0qtgyQ
         saiJ1l7zAQCh7fKjpTTFwtWg8gs4zWL6QNt+fRaWSMJt7xKrFZWdCc7plz5YBPLTm/zd
         UySuzOs46+rvEfwhLBWqTm55MqT/ROoVgR82zISsmEXVXF68YBK7T782lUXL7OG5w07x
         e7AVUC/gen9KFX7IzQgvWGPhrHjCAP1uD1ha6d0JUyfFKDxTOWqs7E4+gzRo1Ot+4QmW
         Etxw==
X-Gm-Message-State: ACgBeo059h669rxwK8mNA6OWwjuYvs1CDRMui5iUVR1g2Mq8Y0vJ6wyK
        h1TBUhdbAz7QFNvxm1xqCt8=
X-Google-Smtp-Source: AA6agR5++uzLAg6kYjMWyq5gg0c8s+WEk8j/afQt7m1wcjEcSZ6dV4d6NLvecsnt9UaiyUC6nbp70w==
X-Received: by 2002:a05:622a:1a01:b0:338:f9cb:e3a5 with SMTP id f1-20020a05622a1a0100b00338f9cbe3a5mr8635838qtb.235.1659560499407;
        Wed, 03 Aug 2022 14:01:39 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id fy26-20020a05622a5a1a00b0031f41ea94easm11490160qtb.28.2022.08.03.14.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:01:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6CEF027C0054;
        Wed,  3 Aug 2022 17:01:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Aug 2022 17:01:38 -0400
X-ME-Sender: <xms:MeLqYsnxLJKaluWnlLbwtSZgUM6rm0w5qpCC72cuxy34LUxSygbMCQ>
    <xme:MeLqYr2knxk-Aa8r_viSc_4aZO9Uqn-K2XXTBl9uE_q1XRDhGjpAgX5aFQ7rHn9FU
    c55pGsGB9DenGcdHA>
X-ME-Received: <xmr:MeLqYqpKlxJnd3F7QHvFW7gsAJhx27ZFg3fMer_mNr2TNPvrMALQgA-GLcVAHw>
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
X-ME-Proxy: <xmx:MeLqYonyGl0_5ap5qwk4j0vlxz7WtFR3Nflv6JMWjYnBBpzOgN797g>
    <xmx:MeLqYq0e8Hqi21jBfnfJvTH1mW1cyhnF4bDLGyg8ebJISULVQg6CKA>
    <xmx:MeLqYvsZL-K0iXx6ks8HOIjvu__4kRznnd4T8O9PP7PZWjNS_G7u2g>
    <xmx:MuLqYnuhe_B9IcOR5ubEyDmma6rl3-NgLv8YGG1GZIchXxJZgWVmvA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 17:01:36 -0400 (EDT)
Date:   Wed, 3 Aug 2022 14:00:33 -0700
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
Subject: Re: [PATCH v8 08/31] locking/spinlock: introduce
 `_raw_spin_lock_init`
Message-ID: <Yurh8WVVRVN97GBB@boqun-archlinux>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-9-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802015052.10452-9-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:49:55AM +0200, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> A Rust helper (introduced in a later patch) needs to call
> `raw_spin_lock_init` with a passed key, rather than define
> one in place.
> 
> In order to do that, this changes the `raw_spin_lock_init` macro
> to call a new `_raw_spin_lock_init` function which takes the key
> as an extra parameter.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  include/linux/spinlock.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index ad1c91884ed8..27df5380c1e4 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -99,11 +99,17 @@
>    extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
>  				   struct lock_class_key *key, short inner);
>  
> +static inline void _raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
> +				       struct lock_class_key *key)
> +{
> +	__raw_spin_lock_init(lock, name, key, LD_WAIT_SPIN);
> +}
> +
>  # define raw_spin_lock_init(lock)					\
>  do {									\
>  	static struct lock_class_key __key;				\
>  									\
> -	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
> +	_raw_spin_lock_init((lock), #lock, &__key);			\
>  } while (0)
>  
>  #else
> -- 
> 2.37.1
> 
> 
