Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E95512460
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiD0VQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiD0VQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:16:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1042B1BC;
        Wed, 27 Apr 2022 14:13:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651093979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NeS+l8WEdxmC3iVZmp9QGW6zT93E8/xcQVx8QLCkU5I=;
        b=FVFEFsyqTdRpC2PY+JRCpM6q7DwT3JkdOvd5DBDcUp0L9RY4bDLotZn9aSIRs5UU4m0/ti
        Q1UrvRXEZYyNX1GTAddDGqtcJSKQ/UxHp9qwhjtEXX55N17fXiPAjux/7wCDKjcDpWL0mb
        gjQe+izroNYC4KS7docDuy9p9EY/GAiNThq95KPNQoXfSEOqh5o72t39cBUn5xYbhuohGQ
        KPUapRQ4CxJgwygUuyNz9cE6a0kHpumASnhlFSv50v9GKOk9uGsM4eFq9ofsLWiwmq9MMW
        WX6TAlry0LeyEQ2LgHACjnW2+vh0bwXeADGy6AfyqTwtvC4NJtrGF2/UQLxN5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651093979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NeS+l8WEdxmC3iVZmp9QGW6zT93E8/xcQVx8QLCkU5I=;
        b=vaEo9sOfHUdgWt2ArDJKVf7pZKrmtV15jLq50JOW7QKFRB/biO+QCdMrU6iQ/0mHZ+tpvo
        pSJFAx8VCq7lXzCQ==
To:     Kurt Kanzenbach <kurt@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <87fslyw94e.fsf@kurt>
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-2-kurt@linutronix.de>
 <20220426175338.3807ca4f@gandalf.local.home> <87r15i9azg.fsf@kurt>
 <20220427112759.1cedda69@gandalf.local.home> <87fslyw94e.fsf@kurt>
Date:   Wed, 27 Apr 2022 23:12:58 +0200
Message-ID: <87mtg6w7qd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27 2022 at 22:42, Kurt Kanzenbach wrote:
> Anyway, with your patch applied [1] and the one below it looks way
> better:
>
> commit 81c4f2de420cc4ac08efc39e78ffd80e146bfbd7
> Author: Kurt Kanzenbach <kurt@linutronix.de>
> Date:   Wed Apr 27 21:59:58 2022 +0200
>
>     timekeeping: Mark mono fast time accessors as notrace

Can you please post that proper?
     
>     Mark the CLOCK_MONOTONIC fast time accessors as notrace. These functions are
>     used in tracing to retrieve timestamps.
>

That lacks a Fixes: tag. These accessors should have been notrace from
day one.

Thanks,

        tglx
