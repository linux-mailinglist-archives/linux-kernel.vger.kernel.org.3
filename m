Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7294CA64B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbiCBNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiCBNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:50:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE193BF9E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EFiW5epXAvMj3+Y4RhnOy43XObQbRYk+KnNyIX9yPps=; b=ZKYRDQpNY7oifdr6jJAlqDAVIa
        z8Cl5Wpt6WrMAj3zRivui5pjc0f2lnaJG1iCcmMeO2kuZMHITh/DJJcfPYDZQcwpLCeW45XR+NEjZ
        ZsGdW/gY6tXE3hXjSJAojECEpnMs1cTh2y6838hvjPKmq0PTgdR6td1GJ7Lr3kwapg6U01aLKfcke
        8kRdaQjH9I5XBDWQsZpNAQz51+30rzS0xFwfF6dkrxpTE6+XSizZ00upUqqsDG5hxVbsWTVDvrG7L
        ncler03mZZEGOjAlZ9Gm0M5pqFLnk0VMJhcRIL1tsd/qL/A5fgFTfhPwYqHsnf6VV0A2JFwgfMAAb
        2JIxOgBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPPLp-00AeJG-3i; Wed, 02 Mar 2022 13:49:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BA6530021B;
        Wed,  2 Mar 2022 14:49:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F5DC32201D61; Wed,  2 Mar 2022 14:49:08 +0100 (CET)
Date:   Wed, 2 Mar 2022 14:49:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <Yh911I6Oh9RbCQz1@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
 <Yh44YsW8viBscBD0@hirez.programming.kicks-ass.net>
 <20220301210245.GM11184@worktop.programming.kicks-ass.net>
 <20220301231303.pqexbxkpte6yjiww@treble>
 <c5e53502274a29e39c996627a35a7aa8e0795ca9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e53502274a29e39c996627a35a7aa8e0795ca9.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 01:59:46AM +0000, Edgecombe, Rick P wrote:
> As for pinning strength, I'm not understanding this kexec asm enough to
> say for sure how much better it is than just removing the bit from the
> pinning mask. I think some future hardening around preventing turning
> off IBT might still be worthwhile.
> 
> Kees, I think you brought up the pinning, what do you think of this?

IIRC the whole purpose of that was to ensure that the
cr4_update_irqsoff() function itself isn't a useful gadget to manipulate
CR4 with.

