Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A675E522E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiEKIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiEKIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:37:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E06830D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:37:38 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CCBD1EC04EC;
        Wed, 11 May 2022 10:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652258253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UoVloFQ4Xl9HFnel7GHmF03+TGYLyO7LWlQCnb+R35I=;
        b=l3dOoSVxhX8OxWdn5IvEm2BlTXW/eeco/jsN6n5am2usrsuXp/1qIrhCmDvfGIDGxdLrSW
        HoPE4JYoKvvzTBo12ko8GO/V72BQl/ZwD9SaDNlGSV8Ow8com9tCiEy+w7gBmsDSUjcjj0
        wqEW2UgtiOLnWs/Gixx0/k7xVWRYdkc=
Date:   Wed, 11 May 2022 10:37:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Link: tag and links to submission and reports (was: Re: [GIT
 pull] core/urgent for v5.18-rc6)
Message-ID: <Ynt1z0eZ19eMqp8I@zn.tnic>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 01:27:54PM +0200, Thorsten Leemhuis wrote:
> Many thx for reminding people about the tag.  FWIW, that's a problem in
> a lot or subsystems and makes my regression tracking efforts hard, as my
> tracking bot relies on the 'Link:' tag. If it's missing I thus have to
> manually search if patches were posted or committed to fix a regression,
> which makes the tracking hard and annoying. :-/

Here's my experience with the Link thing:

So it is trivial to take the Message-ID and turn it into a link tag and
our automation does that.

- Now, it is not a problem when that link tag points to a patch which is
part of the thread which contains the initial bug report - you just go
up-thread.

- If the link tag points to a patch which is version N and it is the
version which passed all review and gets committed, it is a bit harder
to find the previous versions and find the whole discussion how it all
arrived at version N. You can search by the Subject, ofc, which, if it
hasn't been changed, will give you the previous threads. And so on ...

- The problem is when the discussion happened somewhere and the patch
got submitted separately. I can't think of a good way to automate
that so we have to pay attention and fix the link tag by hand and add
the relevant one. And I try to do that when I'm especially awake when
applying the patch.

So I think we should simply pay attention to making sure the link tags
point to the relevant discussion. And we even document that:

 "If related discussions or any other background information behind the
 change can be found on the web, add 'Link:' tags pointing to it."

so we better follow through with it.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
