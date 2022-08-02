Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32AB5874BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiHBAMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHBAMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898846DBD;
        Mon,  1 Aug 2022 17:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D7060FE3;
        Tue,  2 Aug 2022 00:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E566CC433C1;
        Tue,  2 Aug 2022 00:12:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F0CRMSRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659399153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOb82cvKpN/G5yinMmXOhVVGry1/CjG49QTxuePoX+A=;
        b=F0CRMSRyYOeO/rtaCRakWQabL6yPhl2m2cwfYI2Xwdjk/FsZMQoW6BkhpZa5edyYvxvt6B
        MvTm4GtNWryg9ZBAVW6M+/3aoI7GfcEGJ3N8dfJ2gXF+8M16Q92pEdYQndnD2TeJb7XzTp
        qoqx5GpqlqWSaXB8JiXNtjCdR7t+NSs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2de3d1ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 2 Aug 2022 00:12:33 +0000 (UTC)
Date:   Tue, 2 Aug 2022 02:12:31 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v2] random: implement getrandom() in vDSO
Message-ID: <Yuhr79aSC9FtZeRe@zx2c4.com>
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
 <20220731013125.2103601-1-Jason@zx2c4.com>
 <87v8rbsn9j.ffs@tglx>
 <YuhkxqBIflCVo23l@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuhkxqBIflCVo23l@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 01:41:58AM +0200, Jason A. Donenfeld wrote:
> Hi Thomas,
> 
> On Mon, Aug 01, 2022 at 10:48:56PM +0200, Thomas Gleixner wrote:
> > On Sun, Jul 31 2022 at 03:31, Jason A. Donenfeld wrote:
> > You clearly forgot to tell people that they need a special config to
> > make this compile.
> 
> As I wrote in my patch body:
> 
> | The actual place that has the most work to do is in all of the other
> | files. Most of the vDSO shared page infrastructure is centered around
> | gettimeofday, and so the main structs are all in arrays for different
> | timestamp types, and attached to time namespaces, and so forth. I've
> | done the best I could to add onto this in an unintrusive way, but you'll
> | notice almost immediately from glancing at the code that it still needs
> | some untangling work. This also only works on x86 at the moment. I could
> | certainly use a hand with this part.
> 
> So I'm not surprised other things are screwed up. This works well in my
> test harness, indeed, but I imagine there are lots of fiddly bits like
> that to work out. I wanted to send an RFC to elicit comments on the idea
> and API before moving forward, as I have a strong sense this is one of
> those "90% 10%" things, where 10% of the details take 90% of the time.
> 
> Also, I haven't hooked up vdso32 yet.

Just to add, your "special config", "defconfig" remarks and such don't
strike me as very accurate. I had forgotten until a second ago that I'm
actually running this on my laptop's kernel, which is a fairly normal
"desktop distro" kernel with modules and lots of bloat turned on. So
c'mon now... the thing does work.

With that said, I've taken a stab at the various build, symbol, and
timens things you pointed out (thanks for that), and that's sitting now
in a branch, and will be part of a v3 if I ever post a v3:

https://git.zx2c4.com/linux-rng/commit/?h=jd/vdso

That pointer arithmetic around the timens stuff might not be super duper
appealing; I could add a symbol and have the linker resolve its location
and such. But also I wasn't keen on adding a symbol to a piece of data
that's not really there. So instead I calculate that offset from the
vdso_data and timens_vdso_data symbols.

By the way, in writing a test for that, I thought it was interesting
that CLONE_NEWTIME requires a new process, rather than just an execve.
You don't want to do it immediately, because that'd involve a
potentially racy remapping of the vvar pages. But at the very least it
could have been done on execve, right? Since all the maps are thrown out
then.

Jason
