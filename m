Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4751404A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353982AbiD2Bka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353975AbiD2Bk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28D8E3DDE8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651196230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hW9cFab8Ik/mglyLVYP+gASmTZotsBUclSU51ABUpQ0=;
        b=PT1/6tBaT/o32VIi1g8iaVkaKucAm3rCeTlqkC5GkXez/sO5SDvdhQ/Qs2oOziaAj2gihY
        foYoBePPXh/ve29MePd3gmLLJ7wdrH5OYX68ahYBGQwadnExTWXC3dw8s1d+7sfl5SJOXK
        J6JOy/zRYuvqsTbUrre49Vr9c65t/4U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-S-8xkbv3NMarFwKnTyZeZQ-1; Thu, 28 Apr 2022 21:37:09 -0400
X-MC-Unique: S-8xkbv3NMarFwKnTyZeZQ-1
Received: by mail-qk1-f199.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so4415254qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hW9cFab8Ik/mglyLVYP+gASmTZotsBUclSU51ABUpQ0=;
        b=VoaTrcnzloxtnNXviiLzGvH1Vuv8rsfGN6iOaM+driRgCymbdORRWpMLlRtT4rkgF6
         isiHYmWFuKNrPtCe0mrpmKyjpCYJXwufGYZmUwcpKr+uroaXb0aCS0XB7QpAq90CUqo6
         ZPeDUssbPVT7zA/Cz77RW9s/s3lSTHtrFy5+PAHgFRiJugK/de0tgftjLm3fyIHfpXr2
         MAvF0MCwEpZsGaR8zyMTxQH2BabK9t9t1BWgQ6h3ZGWeFzdZyNh9aqoFs5XcQfqMB2Jh
         bifMisbPQJerC/8M7vqWpBosP5dnsil7g+bJiJXiUa+gIXZ9mD/PZJykZK3QvlYyP+IT
         Wm8A==
X-Gm-Message-State: AOAM532uREhOmLApLfZjlMkE7oxNqbt4fUn7+XeIwi7W93960GmnNQ2B
        nFw+OaFGQUYCKaeDShKvfH/P8TGr6zYRS3prURBsznQ3S7gQ5068U0jBv+/1j3+IkiruzojrT7q
        Q/m2Bz48mdh4cPAZsVVmaVpqd
X-Received: by 2002:a05:6214:624:b0:441:42c0:7d41 with SMTP id a4-20020a056214062400b0044142c07d41mr26191361qvx.34.1651196228512;
        Thu, 28 Apr 2022 18:37:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7Yse6CBMrZfO14BHLXIwt9qxnIOlpImmfux0DWolt48lQgK4qbFnBjFh9ckK3IYFw+duTYg==
X-Received: by 2002:a05:6214:624:b0:441:42c0:7d41 with SMTP id a4-20020a056214062400b0044142c07d41mr26191349qvx.34.1651196228306;
        Thu, 28 Apr 2022 18:37:08 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002f1fc230725sm921519qta.31.2022.04.28.18.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 18:37:07 -0700 (PDT)
Date:   Thu, 28 Apr 2022 18:37:04 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <20220429013704.4n4lmadpstdioe7a@treble>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420004241.2093-2-joao@overdrivepizza.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 05:42:31PM -0700, joao@overdrivepizza.com wrote:
> +void __noendbr __fineibt_handler(void){
> +	unsigned i;
> +	unsigned long flags;
> +	bool skip;
> +	void * ret;
> +	void * caller;
> +
> +	DO_ALL_PUSHS;

So this function isn't C ABI compliant, right? e.g. the compiler just
calls the handler without regard for preserving registers?

If this function is going to be implemented in C, it should probably
have an asm thunk wrapper which can properly save/restore the registers
before calling into the C version.

Even better, if the compiler did an invalid op (UD2?), which I think you
mentioned elsewhere, instead of calling the handler directly, and there
were a way for the trap code to properly detect it as a FineIBT
violation, we could get rid of the pushes/pops, plus the uaccess objtool
warning from patch 7, plus I'm guessing a bunch of noinstr validation
warnings.

> +
> +	spin_lock_irqsave(&fineibt_lock, flags);
> +	skip = false;
> +
> +	asm("\t movq 0x90(%%rsp),%0" : "=r"(ret));
> +	asm("\t movq 0x98(%%rsp),%0" : "=r"(caller));

This is making some questionable assumptions about the stack layout.

I assume this function is still in the prototype stage ;-)

> +	if(!skip) {
> +		printk("FineIBT violation: %px:%px:%u\n", ret, caller,
> +				vlts_next);
> +	}
> +	DO_ALL_POPS;
> +}

Right now this handler just does a printk if it hasn't already for this
caller/callee combo, and then resumes control.  Which is fine for
debugging, but it really needs to behave similarly to an IBT violation,
by panicking unless "ibt=warn" on the cmdline.

Not sure what would happen for "ibt=off"?  Maybe apply_ibt_endbr() could
NOP out all the FineIBT stuff.

-- 
Josh

