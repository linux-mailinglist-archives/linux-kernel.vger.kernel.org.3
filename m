Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D07E4DD88A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiCRK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiCRK5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:57:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89782D6390
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kaBZ8KjDbC/rb3g+TLUWGoLdFNQvbA6hXQr+dWf5eMM=; b=OLfKYG5sHQOWuRtWuM0VgFWO6B
        hV7PmU5dD0ZWMjo6/6M9xqsccm4EQjyL8m8sJluR0/8AsNT5p4wHvqxLw7GAoy2xQyJrRtpgSzUyu
        lKW/8+L4FjPC/dRmfdbMbBM/sObByZadpMkIJerv4wQUARC3RORaK96q+hgpTVZOi+PGcKNIciRKn
        sIfQHNcQvH2p9plCDItSx5OOsXTy99f9OCsaOW7K4s8QXz7wivorWqE6ffa6qhVxk8Yyqx5F5MIrS
        oQIKEp36hVETOlpDZ4QhoIIuSAIpt0I1hrMJjTmmHn1/E943gt5QazEt59DMefPK8eT2SyyQOpahi
        ai5ZshJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVAGH-007sEu-Uw; Fri, 18 Mar 2022 10:55:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C90C3001C7;
        Fri, 18 Mar 2022 11:55:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 447362D35E979; Fri, 18 Mar 2022 11:55:11 +0100 (CET)
Date:   Fri, 18 Mar 2022 11:55:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
Message-ID: <YjRlDytYjENcurpT@hirez.programming.kicks-ass.net>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx>
 <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
 <20220317202141.GO8939@worktop.programming.kicks-ass.net>
 <5b3bece3-5956-3116-a07c-a0b6f380fac8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3bece3-5956-3116-a07c-a0b6f380fac8@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:32:07PM -0700, Dave Hansen wrote:

> The TDX rules are *much* nicer than SEV.  They're also a lot nicer on
> TDX _now_ than they used to be.  There are a few stubborn people at
> Intel who managed to add some drops of sanity to the architecture.

Right; that is saner than it used to be. I have definite memories that
pages could be taken back by the TDX thing and would need
re-authentication. A pool of 'fixed' pages was talked about. I'm glad to
hear all that is gone.
