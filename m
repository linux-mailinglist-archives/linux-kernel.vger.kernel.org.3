Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2C4AF09A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiBIMDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiBIMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2AEC102FCE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9d9s0Zw5jafTlFFfFiZN8ZnxoxV8CYmJnXxLQUjolS8=; b=VeemKIC64TA/ef60FBzSX4esKn
        ZlW4Hr6fmfOVPavg0TtmyhUibqEDk1X/81muSvem7C4DtOltKejwRHjJmqSmXrjCnnbYkKkqjPytv
        me10ManmdIr26zOz9gJ/LVgEN/JoTFIIn0jdnUMLdVP8MT6GGDcnRBiQbGNm3nXcqGkgI9M5YDaOl
        1IWOKDyp34G7UX2e9UaVC068+UIg5bDwO3l0Wr3EP1PWCzhoqsOtWWCN+ydPWqNaN+SpP0hMlqgQf
        oVJFugGe59zJyeVPrTwopS3MUncqu7wXmMVzLNBnKxgsj9gakcXrON7IqoPYpgALYvoJRqyDyRCIH
        wjmacrxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHlPV-007YMo-BX; Wed, 09 Feb 2022 11:45:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E52BC9853C7; Wed,  9 Feb 2022 12:45:19 +0100 (CET)
Date:   Wed, 9 Feb 2022 12:45:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220209114519.GA65516@worktop.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <20211124193037.nu7q4pa3sianzqtc@treble>
 <202202081542.F685EC23@keescook>
 <20220209114141.GN23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209114141.GN23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 12:41:41PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 08, 2022 at 03:43:27PM -0800, Kees Cook wrote:

> > Why have the kernel do that work at every boot when it can be known at
> > link time?
> 
> I have patches that write a 4 byte #UD there instead of a nop. That
> would make !IBT hardware splat as well when it hits a sealed function
> (and in that case actually having those extra ENDBR generated is a
> bonus).
> 
> Anyway, I have some newer patches and some hardware, except it's a NUC
> and working with those things is a royal pain in the arse since they
> don't have serial. I finally did get XHCI debug port working, but
> there's no XDBC grub support, so now I managed to boot a dead kernel and
> the thing is a brick until I can be arsed to connect a keybaord and
> screen to it again :-(
> 
> KVM/qemu has no IBT support merged yet, so I can't use that either.

FWIW, those patches live here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
