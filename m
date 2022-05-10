Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6AB5226C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiEJWSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiEJWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:18:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821166C54A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:18:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so168817pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=InNCa+xjWOlYGnWYWDC3xJ/eS8N5Jwfc81JekwauSRA=;
        b=XgtYlZ/dCAkrzwvZEDyVsySj5TSiVF/dDKregrx22WRD39pVwUZcxemUeP7nTgQjba
         ZCpQo5QtAyL2qT30j6wV9nr0O6tFtX/kYKOb8nswyOkrIjoIPG+7SMbO6lnuGW3up+lq
         HeUh1iG/VMrfEarCdU3yR1VhJZuE1Z9Y6U6ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=InNCa+xjWOlYGnWYWDC3xJ/eS8N5Jwfc81JekwauSRA=;
        b=Q9tUH59+CQfK/yEAsCUWxL7rJ/1e0OtHkKqURB9KIZehrhncP2f8T3TEq9Zqm6yM8e
         NAUslrpyoGsGG4qnvlnJZ9mWzH0pcXzA0b9vbVkdUSU//EXlTjwC2oa+t3EgeMvL3idz
         LiHkyx635068rscTbq8sgD9i7isByPcie53XeDqooZPLA8IYA1j8EiubZ/xFt6VPk6Ba
         axHIrL8aoldU9tegCcF0qc+DpOaBIwKwB6F2+lAv3jGnwutP6/y7papSzfbJpmHjJYWX
         hNB2v9Br6MTMwNGMucZnHqax1gNRFjwJrcqu1vsrhzPXzJ62t9YBWpEVAWkJvQ9+21oY
         QhIA==
X-Gm-Message-State: AOAM530gVLuqMJaAtadrBN7sHzmoWUsL4U7z9xbteP9DiWwILS3iwHh1
        W2ae+fCwJf/dT0RuYbQVhz5Mvg==
X-Google-Smtp-Source: ABdhPJykDdBjmf6E/+QD1MPnRy3T6XJmUj5VkOlEr3aIPGjL/svdAg5YZdWeuCvHLVkvcoHgfPX0CQ==
X-Received: by 2002:a63:181c:0:b0:3da:fe5d:90f3 with SMTP id y28-20020a63181c000000b003dafe5d90f3mr2938243pgl.350.1652221104014;
        Tue, 10 May 2022 15:18:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6-20020a1709026b0600b0015e8d4eb263sm120406plk.173.2022.05.10.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 15:18:23 -0700 (PDT)
Date:   Tue, 10 May 2022 15:18:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] big_keys: Use struct for internal payload
Message-ID: <202205101509.B5E3096@keescook>
References: <20220508175732.2693426-1-keescook@chromium.org>
 <YnmgLLcJfPRKEYuk@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnmgLLcJfPRKEYuk@sol.localdomain>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:13:48PM -0700, Eric Biggers wrote:
> On Sun, May 08, 2022 at 10:57:31AM -0700, Kees Cook wrote:
> > The randstruct GCC plugin gets upset when it sees struct path (which is
> > randomized) being assigned from a "void *" (which it cannot type-check).
> > 
> > There's no need for these casts, as the entire internal payload use is
> > following a normal struct layout. Convert the enum-based void * offset
> > dereferencing to the new big_key_payload struct. No meaningful machine
> > code changes result after this change, and source readability is improved.
> > 
> > Drop the randstruct exception now that there is no "confusing" cross-type
> > assignment.
> > 
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-hardening@vger.kernel.org
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  scripts/gcc-plugins/randomize_layout_plugin.c |  2 -
> >  security/keys/big_key.c                       | 64 ++++++++++---------
> >  2 files changed, 34 insertions(+), 32 deletions(-)
> 
> This looks fine to me, although the way that an array of void pointers is cast
> to/from another struct is still weird.  I'd prefer if the payload was just
> changed into a separate allocation.

Yeah, though I realized after sending this patch that I'd done it
before[1] back with the rest of the randstruct GCC plugin enabling,
and it seems David was against the separate allocation, which, given the
space available, isn't unreasonable right up until struct path doesn't fit
anymore, but that's why I've added the BUILD_BUG_ON() to check sizes. :)
And this version ended up quite close to what hwh suggested[2] in 2017.

> A couple nits below if you stay with your proposed solution:
> 
> >  void big_key_free_preparse(struct key_preparsed_payload *prep)
> >  {
> > +	struct big_key_payload *payload = to_big_key_payload(prep->payload);
> > +
> >  	if (prep->datalen > BIG_KEY_FILE_THRESHOLD) {
> > -		struct path *path = (struct path *)&prep->payload.data[big_key_path];
> > +		struct path *path = &payload->path;
> >  
> >  		path_put(path);
> >  	}
> 
> This could just do:
> 
> 	if (prep->datalen > BIG_KEY_FILE_THRESHOLD)
> 		path_put(&payload->path);

Sure, I can avoid the extra variable.

> 
> >  void big_key_destroy(struct key *key)
> >  {
> > -	size_t datalen = (size_t)key->payload.data[big_key_len];
> > +	struct big_key_payload *payload = to_big_key_payload(key->payload);
> >  
> > -	if (datalen > BIG_KEY_FILE_THRESHOLD) {
> > -		struct path *path = (struct path *)&key->payload.data[big_key_path];
> > +	if (payload->length > BIG_KEY_FILE_THRESHOLD) {
> > +		struct path *path = &payload->path;
> >  
> >  		path_put(path);
> >  		path->mnt = NULL;
> >  		path->dentry = NULL;
> >  	}
> 
> And similarly:
> 
> 	if (payload->length > BIG_KEY_FILE_THRESHOLD) {
> 		path_put(&payload->path);
> 		payload->path.mnt = NULL;
> 		payload->path.dentry = NULL;
> 	}

I will respin.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20170508214324.GA124468@beast/
[2] https://lore.kernel.org/lkml/20170528081249.GD22193@infradead.org/

-- 
Kees Cook
