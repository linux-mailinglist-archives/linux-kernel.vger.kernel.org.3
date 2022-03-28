Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9564E9A43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbiC1PAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiC1PAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:00:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979332228A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:59:07 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:59:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648479546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ryz55sTgOT9iLUvPycwDO52kBcgVZON9b2RpskvLecg=;
        b=avDxG7mHLlvWumdSHmf6zrhp8OLuJduxWSNcrDTfHI5RnZ0TlWgE3U9yMkoauS+BwbFWU1
        MWDZdfO/gkGTjeCQW0cCc0R3wRCUmQzIGzZ4NWVIzWB4zcffmkVMb6Q5xuqnWwAoN2evYO
        JJEzFwdQeHhj8UcRJ16Znb3YKIZ/+Ldee4VSeW6RJQ1VAlnNtaJATB9r++0vGRdtOmE7IV
        KfJ1a/Wzs1ZjrCMXg1uJCq7QXkxauqqjQ95bQulJJca5WHnZdl0Mnlf9JxhrNZAAnc/EM4
        COB7aKNzrBh+qMJpTBnI7SXyFTz3/KB/NGRLHARX7ZTEET+Dvg+GK3Y6jRqQBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648479546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ryz55sTgOT9iLUvPycwDO52kBcgVZON9b2RpskvLecg=;
        b=mXBh0rM6qQlIQK6wmbU8o0FK7zLQ5FO8kaVVeSZzxdtdwcwevAK9aqjkqTXUxyxZlpleYZ
        ELeAtt0QQBLP7bCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 0/3] Remove volatile from arch_raw_cpu_ptr() and revert
 the hacks.
Message-ID: <YkHNOBFb9YFHn97Z@linutronix.de>
References: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
 <20220324173927.2230447-1-bigeasy@linutronix.de>
 <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
 <20220328135514.GE8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220328135514.GE8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-28 15:55:14 [+0200], Peter Zijlstra wrote:
> On Thu, Mar 24, 2022 at 11:28:16AM -0700, Linus Torvalds wrote:
> 
> > So Ack on your series, but that additional comment might be worth it,
> > since I didn't even think of it until you mentioned it. Clearly much
> > too subtle.
> 
> Sebastian, were you going to resend these patches with that comment on,
> or should I go collect them as is for post -rc1?

Just did so. Sorry, had no time on FRI.

Sebastian
