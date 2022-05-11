Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E6C522FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiEKJsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiEKJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:48:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF73377FF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:47:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652262478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8gIOAVSb9Lnd1j0nle/z769EEvoHbIW5mPnMFdg2vU=;
        b=WZl1nd/LxNLdWjEf3AtHQMvb7D/wT0fsQURBIWXV/5D1BfEP3s4HsUNyF3uTBUA5uF/YSm
        +Se/8M9xQjgs0x+YwE2kgvp6IfH11K/e/bHt35fceqWu+xDYY8D3vn5805QNy5SB8W/sFe
        s6iCWsKFJpNMPDBizBKDPhyTAP52SWBo3vr3AyCwi6S7jsHdb/XeqWrBCBwOT47dKe8l0X
        z3bj5T69XCrxq+HVIw6Kq+u6iSkPSjDIEPOuEtG5PLzUh2zri5AxhwcY2DO3MQN7/Q2AEl
        Gac/kx1SJltxRedv4GYC7wJWry+o97tAwhMF5IAMlyhHonuyBexFWvcpIgW+wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652262478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8gIOAVSb9Lnd1j0nle/z769EEvoHbIW5mPnMFdg2vU=;
        b=y7rJtIcFJKbZDVPxCMswt74OasNVSo/j3/EyYX9CVr+mqdtw0MQOrLj2EIWGQeM8KW/xlU
        zMpUnm/Dv1yBNOBA==
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Balbir Singh <sblbir@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH 13/22] x86: smp: move cpumask_weight() out of for-loop
 in remove_siblinginfo
In-Reply-To: <20220510154750.212913-14-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-14-yury.norov@gmail.com>
Date:   Wed, 11 May 2022 11:47:57 +0200
Message-ID: <87k0ash036.ffs@tglx>
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

On Tue, May 10 2022 at 08:47, Yury Norov wrote:

Subject: x86: smp: move cpumask_weight() out of for-loop in remove_siblinginfo

Can you please format this according to

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

> Because argument of the function is constant inside for_each_cpu()
> loop, the cpumask_weight() does the same work O(NR_CPUS) times, while
> it may be calculated only once.
>
> This patch moves cpumask_weight() out of the loop and replaces it

Ditto.

Thanks,

        tglx
