Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81556C862
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGIJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGIJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567DBC0B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423B160B83
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16F4C3411C;
        Sat,  9 Jul 2022 09:43:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gDUjfSib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657359836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFUI1pK9cWjLfZY0rBwfK5D5LDb+mJW3sT7oo6CGqoY=;
        b=gDUjfSibGj4pfqHuPXrQu+L3cBe+RjTDaCuPRF2RzQ86AGWeQkq1V3kDw4M/QK5MbVHJ34
        D5LTBxifVisoBNRgdezr9kcGXAPvn76h3wSN1pSI00mPcJJuNR171EPh7N4qx6II/2V6kx
        kzoy4fClitvF0pYfntMuoQltYQU7vtA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7fd87503 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 9 Jul 2022 09:43:55 +0000 (UTC)
Date:   Sat, 9 Jul 2022 11:43:49 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Message-ID: <YslN1bo2jnnxl3E3@zx2c4.com>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jul 08, 2022 at 06:51:16PM -0700, H. Peter Anvin wrote:
> On 7/8/22 04:39, Jason A. Donenfeld wrote:
> > 
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > index ca0796ac4403..2cbfe630230d 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -12,6 +12,7 @@
> >   #define SETUP_JAILHOUSE			6
> >   #define SETUP_CC_BLOB			7
> >   #define SETUP_IMA			8
> > +#define SETUP_RNG_SEED			9
> >   
> >   #define SETUP_INDIRECT			(1<<31)
> >   
> 
> Just one miss here: you need to bump SETUP_TYPE_MAX. It is a bit more 
> confusing than it needs to be that SETUP_INDIRECT sits in between, and 
> honestly I think SETUP_TYPE_MAX shouldn't include the SETUP_INDIRECT 
> bit; however, this is uapi and so we can't change that per se.
> 
> Perhaps we should do:
> 
> #define SETUP_ENUM_MAX	SETUP_RNG_SEED
> #define SETUP_INDIRECT	(1<<31)
> #define SETUP_TYPE_MAX	(SETUP_ENUM_MAX | SETUP_INDIRECT)

Thanks, nice catch. I'll do exactly that. v+1 incoming.

Jason
