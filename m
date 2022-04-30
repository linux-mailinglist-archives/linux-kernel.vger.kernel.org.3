Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5B515BBE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382435AbiD3JMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382421AbiD3JMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 05:12:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707489CCF;
        Sat, 30 Apr 2022 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fmjKi3vzk5o50Dip5Ph0Bmr/f1E5Lj21/lbWqEwgHkk=; b=gP2jQek7ogrpQN1C4MXnP7aih6
        9MpJEvWzvlOJpxul3NuvKTM+1Aymo8v2WKGSWeTkjPuh9j5Kx6oalC9wJePh3SCBiQauChsIADQ2p
        awHTCsB7ByqI2tgdiudUdNwUPwJefZVeg1l4ofe5iiqvmn8WItr7C/7gjnoGx4MI1PTeAEK+Kce1l
        m1YgnfIbhxGraj+tYK/82m+XakPv3zCiqhetcFWQppvw2k+nTdjPrw9LuFPQL2QdjLx1kxy4K5nOQ
        HB4Fh5lHfvGCgodgr2tGjwSaUNzWQ3LPB+VFSFE1iRiJMLzYHDAcxE15A3g/1tBSl/kbjQgvf7UpB
        oaxIK3rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkj69-00DDvg-Aj; Sat, 30 Apr 2022 09:09:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60B393001EA;
        Sat, 30 Apr 2022 11:09:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 256252028EFE6; Sat, 30 Apr 2022 11:09:03 +0200 (CEST)
Date:   Sat, 30 Apr 2022 11:09:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 06/21] cfi: Switch to -fsanitize=kcfi
Message-ID: <Ymz8rwWGjkVCfMZ1@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429203644.2868448-7-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:29PM -0700, Sami Tolvanen wrote:

> +CC_FLAGS_CFI	:= -fsanitize=kcfi -fno-sanitize-blacklist

I'm somewhat surprised to see CFI is a sanitizer. It just doesn't seem
to fit in the line of {UB,KC,KA}SAN and friends.
