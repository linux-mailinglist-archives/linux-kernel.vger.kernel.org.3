Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA37587DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiHBN7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiHBN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:59:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740E6165;
        Tue,  2 Aug 2022 06:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8914B81F29;
        Tue,  2 Aug 2022 13:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBFFC433C1;
        Tue,  2 Aug 2022 13:59:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HifavJp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659448747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBo0+ydwkBuVutUpn2oqaBgFUKHYpcNRhAN0M0iP060=;
        b=HifavJp+XiFjfeb3n91xWAP3qxfIeO+6x2Vx/xVuRbuTVaYtLNsFgTs8pJXvF+f5E1ZwEU
        tEPcf5g16SFL30fdXQvQaNF8l/U4RzTW9EKJdfmOOHXDBoFlBlkFgAqIPDOB6+dOndD4I4
        kvROA04F35thyAxHEsP7xuKTR1yU+ZA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f4f02e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 2 Aug 2022 13:59:07 +0000 (UTC)
Date:   Tue, 2 Aug 2022 15:59:05 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
Message-ID: <YuktqQS7Rb0IbJNh@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com>
 <87zggnsqwj.ffs@tglx>
 <Yuhe6IIFXqNMZs5b@zx2c4.com>
 <87bkt2sqq4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkt2sqq4.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Aug 02, 2022 at 03:46:27PM +0200, Thomas Gleixner wrote:
> Right now the Linux VDSO functions are 1:1 replacements for system calls
> and not adding a magic pile of functionality which is otherwise not
> available.
> 
> What you are proposing is to have an implementation which is not
> available via a regular syscall. Which means you are creating a VDSO
> only syscall which still has the same problem as any other syscall in
> terms of API design and functionality which needs to be supported
> forever.

Wait, what? That's not correct. The WHOLE point is that vdso getrandom()
will generate bytes in the same way as the ordinary syscall, without
differences. Same function name, same algorithm. But just faster,
because vDSO. I explicitly don't want to dip into introducing something
different. That's the big selling point: that vDSO getrandom() and
syscall getrandom() are the same thing. If you trust one, you can trust
the other. If you expect properties of one, you get that from the other.
If you know the API of one, you can use the other.

There might be other valid objections to this whole thing, but "this is
different from the syscall" really isn't one of them. It's the same
ideaspace that motivated gettimeofday() and such.

Jason
