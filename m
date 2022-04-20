Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD5508B57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379858AbiDTPBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A1983CFE8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650466727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gVlN8Zg4CYoppK6dzP2BhOdvAfuQF4ICX4dEGXbmFsY=;
        b=PpRiazzsg3UwxXzGlK00qr1Hn8Z7jmCWHXHNDGEL+vVBR9zlqTOsBTyT9j6XTzPDT0z9Xu
        IDAr1y3oM9XWZ2+qJPtCRo5+IxEso9O3uhO/C5cg3iPrH7Pc4u3jRDFj9RwN6Mq4S1vDnx
        JMwsJ7ZazUuK1SWpWmgQa7OE1Jr1aV4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-Jr6eas8WPJOxEPdCViPkwQ-1; Wed, 20 Apr 2022 10:58:45 -0400
X-MC-Unique: Jr6eas8WPJOxEPdCViPkwQ-1
Received: by mail-qk1-f200.google.com with SMTP id t3-20020a05620a034300b0069e60a0760cso1364092qkm.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gVlN8Zg4CYoppK6dzP2BhOdvAfuQF4ICX4dEGXbmFsY=;
        b=O9JOvX5B3GEzLCYaZMr0BZxu5oJUmMcXYbqBKtcuH2GnJApd1FDOYZKAGTc2ZzJAaZ
         RB3vn/V7hbRLECNrRCxN5bWT+Vq7usUp7SSboz9V37rSYy8WndZwiFqvmLuuB2++DAeI
         dHD3ykjc4PctzItc69nstK1hY8q0iWW3PccXh/mL88pVz6RPeQFC8r07ePAIc1YqcV1V
         hcOWL8rLO0vlsT2DnZBo1pDsVmZKQxEySdAd3xwqhbthnM4J/tmxFu16ZAUgrqGF6RwS
         RPvQ7Fxquoz0zEXi9df1e0gaCU4lwMkbIxUMbcF5kppqyweMiUuhD1Qaf4MGo55u5D6Q
         EiWQ==
X-Gm-Message-State: AOAM531UvXLZOdYIXzh2wiFvGwscHiUEjmEly+p2KZ1Dc92wwE0Lw3rm
        4l1EOwn/HB7RAvoqcEeUcVz6N0tyGq+Lmk66qBy/yH2OU5Fm+zVRc8SJV9lET1iFByaSTYLoQTx
        OKtiEIsEfyeonhYAzfuD1j9WQ
X-Received: by 2002:a05:622a:8:b0:2e1:cb36:9244 with SMTP id x8-20020a05622a000800b002e1cb369244mr14013039qtw.93.1650466725043;
        Wed, 20 Apr 2022 07:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq/ZRQJonnRQsfg4icRnn9DNb+9S7+/UnCmslakhte52WcKz4tNmErjGTi7BcnwZxiDd3Alw==
X-Received: by 2002:a05:622a:8:b0:2e1:cb36:9244 with SMTP id x8-20020a05622a000800b002e1cb369244mr14013027qtw.93.1650466724829;
        Wed, 20 Apr 2022 07:58:44 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c17-20020ac85a91000000b002e1dd8ae44bsm1861775qtc.29.2022.04.20.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:58:44 -0700 (PDT)
Date:   Wed, 20 Apr 2022 07:58:41 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220420145841.mgt2eya5hhe4abd5@treble>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.339242797@infradead.org>
 <20220420032123.6c344rjr4poockjr@treble>
 <20220420070730.GB2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420070730.GB2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:07:30AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 19, 2022 at 08:21:23PM -0700, Josh Poimboeuf wrote:
> > On Tue, Apr 19, 2022 at 10:41:11PM +0200, Peter Zijlstra wrote:
> > > Since the upper regs don't exist for ia32 code, preserving them
> > > doesn't hurt and it simplifies the code.
> > 
> > But an attacker can still control those registers, so clearing them on
> > the stack is better, as it reduces user control over the kernel stack.
> > 
> > 64-bit syscalls *do* have to save those registers to the stack, so
> > whether it truly matters if compat mode is made equally insecure, I
> > can't say.  But without evidence to the contrary, my feeling is that we
> > should err on the side of caution.
> 
> Right, so earlier Brian said simpler might be better, and I figured I'd
> try to see if I could make that stick, because I too like simpler ;-)

Simple is good.

> Also, since int80 already has to do this, attackers already have their
> attack surface.

Hm, probably true...

-- 
Josh

