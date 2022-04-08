Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75A4F9E78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiDHVAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiDHVAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF139142
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2779261F49
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAC2C385A3;
        Fri,  8 Apr 2022 20:58:29 +0000 (UTC)
Date:   Fri, 8 Apr 2022 16:58:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20220408165827.42475fb2@gandalf.local.home>
In-Reply-To: <87v8vjiaih.ffs@tglx>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <87pmlrkgi3.ffs@tglx>
        <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
        <87v8vjiaih.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2022 22:29:58 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> What a shutdown function would prevent here is UAF, but I'm not entirely
> sure whether it will simplify coordinated shutdown and remove the
> requirement of a priv->shutdown flag all over the place. It might make
> some of the driver muck just get stuck in the shutdown, but that's
> definitely an improvement over a potential UAF which happens every blue
> moons.

Note, it is the cause of a large percentage of crash reports reported by
ChromeOS.

And we do not even know if it was this bluetooth issue that caused them.
There's evidence they are mostly caused by the wifi code. I only used the
bluetooth issue because it was the first one we found that looked obviously
wrong.

-- Steve
