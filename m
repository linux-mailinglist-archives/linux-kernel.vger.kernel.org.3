Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF214B2A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351459AbiBKQYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:24:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiBKQYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:24:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D93B6;
        Fri, 11 Feb 2022 08:24:35 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:24:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644596672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w9FBzUJaxUaUqloJIitm2mdcnB7QrKXegO9P62+prTM=;
        b=xiZw248UeLoC3g67wqzAkRjUjwKLgeYx9o4Oltad9mL3jm8ER4ogHp1SUDjaxpSyd0pvEU
        mY9PEzhaJdFr4wcKAPngG9v1l5fzKp0JIc4TVh/WHkI0oLl/XHc8XwdS8EVwpeQJU3FAQx
        dP5FbjWx+CtTIC24gs5pS/Ax9hRE/NRx+wUm3jgM0pzjrKmTGLvktBjy7hcNm35VIytIDZ
        o9Wk0dmogjFtaPwffKW8aTvboM107MBF8JOzsPhGaPayFEp72X49tUEuVNTiNHA6sKsq6+
        B5czW12xKpEjWYsk+t0cblghxxvO8srI0C6w2QBtvFtBiY1ria7eJ+Z8GR/GDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644596672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w9FBzUJaxUaUqloJIitm2mdcnB7QrKXegO9P62+prTM=;
        b=oHUny/7EC0zgMFYaGvQpnGX2CGFIu7z6Ugu72SCHD3nW4d8ApaOvc4eRLRvBgUY/jGo+kj
        /WP5BaB9E0z+9jAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: ensure mix_interrupt_randomness() is consistent
Message-ID: <YgaNvnf5NHQEi5G3@linutronix.de>
References: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
 <20220211011446.392673-1-Jason@zx2c4.com>
 <YgYbRa+5cC0ivWrK@linutronix.de>
 <CAHmME9oBCt=bvjQLwmppr29W9FdJ612+d1a8gUExyWZuZHVWZw@mail.gmail.com>
 <YgZ36ShvikQhcQYl@linutronix.de>
 <CAHmME9p9RVRtD_GQ7FPdj64_a6aArQTtdE6Ch7X_8AQngi1pUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9p9RVRtD_GQ7FPdj64_a6aArQTtdE6Ch7X_8AQngi1pUQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 17:19:21 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi,

> I'll do the cmpxchg and send you a v+1. Sorry it wasn't in the last
> one. It only now clicked with me what that code would look like, after
> I stepped away from the screen for a bit to defrobulate my brains.

No worries. As much as I liked my first series, I like even more where
this is heading to ;)

> Jason

Sebastian
