Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9611E53405E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbiEYP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiEYP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:28:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D472F03F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:28:10 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 418271EC04E4;
        Wed, 25 May 2022 17:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653492485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZUUIzFsb6TK4Z5Qa+FJOS644rqweyeaDLz9HrWqm3Es=;
        b=TeoxIIAh2rbOE0vadCTRzRoe2Zru5o12uFRQcXIYp+4NAL++D5ApN5MIig3NArHYk9rUqo
        xEatw69pXpRypDUooYyCw0ToK61Ph3s+4MNZAWlIh/k+sQ4BWuL3xTW3+A+3OJiehZEXF4
        ef4KZkCSs0w7Ko/mr6z2h+jHK1DyIXI=
Date:   Wed, 25 May 2022 17:28:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Message-ID: <Yo5LAenZIsYmM9Ie@zn.tnic>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
 <Yo3cpb1yZhwhHEga@zn.tnic>
 <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:50:59PM +0000, Luck, Tony wrote:
> Are taint flags in such short supply that you couldn't create a new
> one?

Yes, they can be as many as there are letters in the english alphabet,
it seems:

struct taint_flag {
        char c_true;    /* character printed when tainted */
	^^^^^^^^^^^^

and there are already

#define TAINT_FLAGS_COUNT               18

in use.

> The OUT_OF_SPEC one already seems to be used in some dubious
> ways:
> 1) Command line argument to clear a X86_FEATURES bit
> 2) Forcing PAE
> 3) Writing to an MSR not on the "approved" list
> 
> As you add more ways to set this taint bit, it becomes less useful
> for debugging ...

Look at the other taint flags - they're set in a bunch of different
places so it is hard to unambiguously decide where the taint was set. If
we wanna use it for debugging, then the taint_flag struct above should
probably save the caller address which set the taint... or something to
that effect.

> since now you have to dig into which of the possible cases set the bit
> to decide whether it might have contributed to the OOPS.

So I'm still not convinced this should have a special taint flag.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
