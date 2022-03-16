Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398854DB1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348443AbiCPNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiCPNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:50:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C704560CE5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E3MQLTeQgpAMAzN5tiY3W9F+UmUbIsrkGZrUipXYgo0=; b=VGtwRSJXnqIveIbsyK+CGBD9Ot
        X/MGMfRepk85eFHjVtg8UMLIGxtIt8mRplrNs+ZiQyGvfXYZoQwJGvVKBoKxPVe9l/uqnq/CIjPbM
        RGc86ZDX1Xl+B8M5YsQt8eSqLhoWfoamqjErefubwI3H4wlMr6TBnVs0j5YYMrEm9/wknEG77Kw7a
        yOsKNYJkvoGGKU0vhKPI98dNsNgi+pZxel+wo+1EBXZAX1Z1EJFjaxwe2dYl63HNoKUHHrQ6xoyih
        MwvVvnc71Rx4uISndapS7H6tR9TCg1LENFU5Ttj8IA6z/QfIdMhbv39rU1ClXGdvlK7h86fbnEAlH
        nGSvVIRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUU0s-001Ycp-8a; Wed, 16 Mar 2022 13:48:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C6D930002E;
        Wed, 16 Mar 2022 14:48:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 060B02B364A01; Wed, 16 Mar 2022 14:48:26 +0100 (CET)
Date:   Wed, 16 Mar 2022 14:48:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V3 1/7] x86/entry: Use idtentry macro for
 entry_INT80_compat
Message-ID: <YjHqqskCnZDgN2NI@hirez.programming.kicks-ass.net>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <20220315073949.7541-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315073949.7541-2-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:43PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> entry_INT80_compat is identical to idtentry macro except a special
> handling for %rax in the prolog.
> 
> Add the prolog to idtentry and use idtentry for entry_INT80_compat.

I'm struggling to see the Xen case. Currently it has:

> -	/* In the Xen PV case we already run on the thread stack. */
> -	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV

But idtentry's error_entry() does not have that afaict.
