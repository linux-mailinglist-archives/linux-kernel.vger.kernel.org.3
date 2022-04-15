Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953D5030BB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbiDOVsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiDOVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:48:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006F62A0F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:46:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650059172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NtYrS5Xki2cCiSyLAX/4guij214yE5GekVuUVvefn+E=;
        b=s67Oz/CQfCjuBgy4XCH8KVlMRaHEDWi++qBY80nCug4H7ZISijQgwL0dGNxWNarusZoWrq
        pQp23TIIA95g8C3tbiTy+fp4T5JUYeha4QLSXTQ8HBKk7PAVDHIBEHfnowHyUOZChVfwY/
        0KDr5Zd1ElV/736aTJ3bfO2xOW6SRxFIcBlhWXlrB/muisnwWHCyK8EehOZoIth+zBhiF5
        w71MUjOKDII5ymH4t7DTzYjhMIs04tpJt0U0gTvAYA7QwIcBko95VxKIb+ZdPQlJ2/j/cz
        B+MWK+ugMEveetFXy8jsq1fWnejkvkDtoEgpiUVHp/mni/pfka/1OeqQOBVYsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650059172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NtYrS5Xki2cCiSyLAX/4guij214yE5GekVuUVvefn+E=;
        b=aQxZ5db7HezH81nqBnPUQsMYd4DB+YQ8rxldM5tbFQbW+5pknk8780ONFT4sZFA4K+pCLw
        25nKCwWJgj0zdNCQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [patch 1/3] timekeeping: Annotate ktime_get_boot_fast_ns() with
 data_race()
In-Reply-To: <YllgHEhwDOYqv5IX@hirez.programming.kicks-ass.net>
References: <20220415091223.187169221@linutronix.de>
 <20220415091920.956045162@linutronix.de>
 <YllgHEhwDOYqv5IX@hirez.programming.kicks-ass.net>
Date:   Fri, 15 Apr 2022 23:46:11 +0200
Message-ID: <87pmli9g0s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15 2022 at 14:07, Peter Zijlstra wrote:
> On Fri, Apr 15, 2022 at 11:19:35AM +0200, Thomas Gleixner wrote:
>> Accessing timekeeper::offset_boot in ktime_get_boot_fast_ns() is an
>> intended data race as the reader side cannot synchronize with a writer and
>> there is no space in struct tk_read_base of the NMI safe timekeeper.
>> 
>> Mark it so.
>
> If offs_boot actually ever changed?

Yes, during resume to compensate for the time spent in suspend. So, yes
the data_race() is more of documentary value.

Thanks,

        tglx
