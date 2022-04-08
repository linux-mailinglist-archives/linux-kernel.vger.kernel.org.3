Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB204F9F55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiDHVsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiDHVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:48:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BF160C37
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:46:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649454395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jv1XCzAA0sQnRATbKYwT40mQz2UjI4mAAOrGkzxjJ0=;
        b=oN4OzZ98SJpzhn99fiyr2x/tQm0k3Xg6UFZEviT7uYkq4Anlr1oPBg5AY5R6t0QqJDo89d
        /0eu8omXgmv2bJqj7eAs8rmTJA6PeWsdJ+WduCat+c7av47GH+DuSb6n5hehD7C4VXyM/1
        Kpw3DXP6iLFNwNzS7xoeBDDip3STref5cHm7n5du2fU6hWEagdtkzjWF4xnYsXBcwAhufq
        yUiv8/K7PspftKjQTy97FedXolVMkucDAuUjvqyiSyozSn9lsQ46aAa7c10NaP1ik5QDeE
        Mam29PAXKZjER0BWs+lNN+jlXUGSKzy/1ylU+/ZIHR/SY1yfWLKuhQRdXGegaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649454395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jv1XCzAA0sQnRATbKYwT40mQz2UjI4mAAOrGkzxjJ0=;
        b=z4nQH3vI3VTtHrctAJwIeHhOG7tShlqCZwY4sb/sWZjZhPcyXv+lhQxxudhDbgVpwEwBaj
        CHtnMcm1CuJTOdDw==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
In-Reply-To: <20220408165827.42475fb2@gandalf.local.home>
References: <20220407161745.7d6754b3@gandalf.local.home>
 <87pmlrkgi3.ffs@tglx>
 <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
 <87v8vjiaih.ffs@tglx> <20220408165827.42475fb2@gandalf.local.home>
Date:   Fri, 08 Apr 2022 23:46:34 +0200
Message-ID: <87pmlri6yt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2022 at 16:58, Steven Rostedt wrote:

> On Fri, 08 Apr 2022 22:29:58 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> What a shutdown function would prevent here is UAF, but I'm not entirely
>> sure whether it will simplify coordinated shutdown and remove the
>> requirement of a priv->shutdown flag all over the place. It might make
>> some of the driver muck just get stuck in the shutdown, but that's
>> definitely an improvement over a potential UAF which happens every blue
>> moons.
>
> Note, it is the cause of a large percentage of crash reports reported by
> ChromeOS.
>
> And we do not even know if it was this bluetooth issue that caused them.
> There's evidence they are mostly caused by the wifi code. I only used the
> bluetooth issue because it was the first one we found that looked obviously
> wrong.

I'm sure that there are hundres more...
