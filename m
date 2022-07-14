Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB91E5745CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiGNHSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiGNHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:18:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38979B4A6;
        Thu, 14 Jul 2022 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hy6ATVtW3qTg9csBjNFE7NoUXp1j3O11i3rGU3Oly6A=; b=H6ZmTn0ZljpTt2Id6yblR8ab0u
        ykG1/IVzM05NrHnkE7ht9wJQn/O7nYCSpvliAsz/IAyfd3asLpOrXYrWS+45fgYeB5fT5wZOpZSnp
        p0PiQIGtAxZ74YzpP+b3vLGuFv+rYYSSTJZMGGsUGK6gIc1AzsZTpPcOPRJD7k+5PV9rhAapm4HNs
        XPhhiOv4mj3z893lBN2b4sPoREUXuvP0nnGjBzIlnC77Sv85093CrylFMISrWjioGt6/fHy7L1zBQ
        McaBbPGg7K0XcCbmf0R8iGFoisH0q2rP+NsHi2HPZ9XhSVd0gGpUICv5C0gB8pLEgURi6VPNMApSm
        BsZnqgJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBt6z-003mrT-K3; Thu, 14 Jul 2022 07:18:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69F62980083; Thu, 14 Jul 2022 09:18:12 +0200 (CEST)
Date:   Thu, 14 Jul 2022 09:18:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86: Allow for exclusions in checking RETHUNK
Message-ID: <Ys/DNIyc+4ju7Qmb@worktop.programming.kicks-ass.net>
References: <20220713213133.455599-1-keescook@chromium.org>
 <20220713235556.umnau6nd7u6bz72m@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713235556.umnau6nd7u6bz72m@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 04:55:56PM -0700, Josh Poimboeuf wrote:
> Here's the ANNOTATE_UNSAFE_RET idea.

Right, I suppose that strictly speaking the compiler can do whatever and
there's no actual guarantee the annotation hits the RET instruction, in
practise it should work, esp. since noinstr.

> Most of the diff is moving the
> annotation macros to objtool.h (where they belong anyway).

Yeah, moving those is a good idea.

