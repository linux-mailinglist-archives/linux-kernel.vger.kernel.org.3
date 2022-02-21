Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480FC4BE683
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbiBUKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:08:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353325AbiBUJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:57:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAA47042
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sWzl2v9v4HujX86aJfCOVrh1k6oCTv+xUn/76FQ75FM=; b=LZ6EwgV7EF75a3KISk36Gc2ZRH
        O02ROAuni+7t1lYSu4iSkXJSsm9LKxVh6mbLsiZ/TSksq0H5yo8fA9t7t29+lJiylcd5RR+l8g4Ou
        a/VuJU9/DJjFuSFAFIBtWhQP5aFl0gpYQUuqhXX/bwO5+X9knRreKYcdIwIhrSbAYJ3jzxYGnmDSd
        DCeWqZ6huOtgmDzWvOP+Z9W5BjsOx1wc9/i6nNbOlOSNJX8OXflVbi/J6CismkoaeDHlfIvHC2xf/
        LE6ERqYgfXP6rno0hu66kiZ8MjBoNzbqsC1Bs88eeSQFFofdiAnDPVOIrSsbIkxvXb/M7lmSLnOcI
        W+9dBmrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nM4wJ-001esK-0l; Mon, 21 Feb 2022 09:25:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65C59988B05; Mon, 21 Feb 2022 10:24:56 +0100 (CET)
Date:   Mon, 21 Feb 2022 10:24:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 00/29] x86: Kernel IBT
Message-ID: <20220221092456.GJ23216@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
 <20220219095827.GI23216@worktop.programming.kicks-ass.net>
 <1C202B85-FCB1-4282-9CA6-ED9115F203BB@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C202B85-FCB1-4282-9CA6-ED9115F203BB@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 12:42:25AM -0800, Kees Cook wrote:

> >+void cet_disable(void)
> >+{
> >+	cr4_clear_bits(X86_CR4_CET);
> 
> I'd rather keep the pinning...

Uff. is that still enforced at this point?

> >+	wrmsrl(MSR_IA32_S_CET, 0);
> >+}
> 
> Eh, why not just require kexec to be IBT safe? That seems a reasonable
> exercise if we ever expect UEFI to enforce IBT when starting the
> kernel on a normal boot...

Well, it makes it impossible to kexec into an 'old' kernel. That might
not be very nice.
