Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6F46F4D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhLIU1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:27:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:52292 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhLIU1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:27:30 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1B9KGHTw015333;
        Thu, 9 Dec 2021 14:16:17 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 1B9KGGkw015329;
        Thu, 9 Dec 2021 14:16:16 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 9 Dec 2021 14:16:16 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Subject: Re: randomize_kstack: To init or not to init?
Message-ID: <20211209201616.GU614@gate.crashing.org>
References: <YbHTKUjEejZCLyhX@elver.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbHTKUjEejZCLyhX@elver.google.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
> Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> default since dcb7c0b9461c2, which is why this came on my radar. And
> Clang also performs auto-init of allocas when auto-init is on
> (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> allocas.

The space allocated by alloca is not an automatic variable, so of course
it is not affected by this compiler flag.  And it should not, this flag
is explicitly for *small fixed-size* stack variables (initialising
others can be much too expensive).

> 	C. Introduce a new __builtin_alloca_uninitialized().

That is completely backwards.  That is the normal behaviour of alloca
already.  Also you can get __builtin_alloca inserted by the compiler
(for a variable length array for example), and you typically do not want
those initialised either, for the same reasons.


Segher
