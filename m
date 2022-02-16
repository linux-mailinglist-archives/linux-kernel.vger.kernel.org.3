Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C94B862F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiBPKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:51:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiBPKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:51:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341272641;
        Wed, 16 Feb 2022 02:51:33 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645008691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RXj5ZTdzVM7aAxJj6R3twf1VlvClYTUUk5x5NQ3cLKE=;
        b=TctxHfpEkSVGARrVvS1f/X+6g2iJq1RQeymvwqgYZ2RWSOvSIl3GrFBRgf5zEOdjzpBdS+
        sGDM9apOcrj5R7rUjCJhCqRc+hNxx5b9Sg25Yai8ORQSDV1JgFqlN61CvcG2IK7uTW0rQh
        wIai4CIHBMMjGdu7IPFXwdWpjbEE7/sUu05iay7dXMDc4RK4TOR+fl67tIh857bAxWPTH5
        HnMJ4mXlmm76v6DTIdSks5PZHsE/lEOuGt4ZU6mK77BjkZfGy8kBZFO9P3Fl7cU15O3Tqi
        n9R4GAqgZg01tME4ZJqHjHa3jgVF0nMjZ14vZ4qR6+7UsNhRxQDjizbtgqoLGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645008691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RXj5ZTdzVM7aAxJj6R3twf1VlvClYTUUk5x5NQ3cLKE=;
        b=+NR92/qnOp74JhQAP6QduKnaQAXXloLbY8e622zRvJThbxA7j5MKfpVlFmUqCfW6gWweG1
        xnsp9lSSI9c5nPBQ==
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [RFC V2 12/21] rv/reactor: Add the printk reactor
In-Reply-To: <05a593c4-0134-1449-7f30-305a0ffe1b49@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <fad2d358d57dfffc084d482684ecc1d13b62b262.1644830251.git.bristot@kernel.org>
 <10cf6003-6d2b-056b-11bb-3ae9c342a369@linuxfoundation.org>
 <c1657d1c-0d2b-4aa3-c1ed-2ae6fdfcda86@kernel.org>
 <87v8xg30qc.fsf@jogness.linutronix.de>
 <45179cdb-2391-207a-2f7b-2dea828d1606@kernel.org>
 <87r1842r1m.fsf@jogness.linutronix.de>
 <65172f14-bad6-37b1-d243-e91ca472d22e@kernel.org>
 <874k50hqmj.fsf@jogness.linutronix.de>
 <05a593c4-0134-1449-7f30-305a0ffe1b49@kernel.org>
Date:   Wed, 16 Feb 2022 11:57:30 +0106
Message-ID: <87fsojrsnh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-16, Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> So, I will keep printk(), add a depends on *!* fbcon, and remove the
> comment.  What do you think?

printk() and depends on !VT_CONSOLE. OK for me. Hopefully soon this
restriction can be removed.

John
