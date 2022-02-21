Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1204BDBF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379917AbiBUQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:11:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346398AbiBUQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:11:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695302408B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dYsXggHn2A9n6FxteJ+9znoC/7uWDFSPYAMbC1idliw=; b=fx63exbLTFa3VqC1YJvNHgNPVO
        bN81YavyAlSLaELxD8HWBgg9kSXs3Qan1YVOjZvOeSNQM0yvofl7ie6dEWh0WqztTMOdAXp3Uocef
        z6+Ob/C0CIjiryNKIQ2Ye9+6c6JIbJSGbjceqBmTkBk3L1rRZgp+YBxD+PoyrBqIJIENH37fjTgSo
        OsPH48vyRIMZrNFIp/p6kZIHZaB1/Z9grh8ECrIZuMLTbNeZvoLZLR4uRkEz72Jdb3wjeL655KFb6
        F3X70qoVrJYylKz17DuA47pt7sAWcovs3BqqGoRIgxRXOf35dJfXO+o0rSimyspRt1B+VfYkTuSDT
        5/504Vtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMBH3-00Bg9S-2D; Mon, 21 Feb 2022 16:10:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B00ED30045A;
        Mon, 21 Feb 2022 17:10:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F3F1202411C1; Mon, 21 Feb 2022 17:10:51 +0100 (CET)
Date:   Mon, 21 Feb 2022 17:10:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 15/29] x86: Disable IBT around firmware
Message-ID: <YhO5i+DmY1+/l+PC@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.456054276@infradead.org>
 <831051EB-FF09-4B75-98EE-A7C8D0054CFE@chromium.org>
 <20220221100615.GK23216@worktop.programming.kicks-ass.net>
 <4DC4ECA7-902C-4496-8AAA-173D86C7C730@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DC4ECA7-902C-4496-8AAA-173D86C7C730@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 07:54:55AM -0800, Kees Cook wrote:
> A small bike shed: should __noendbr have an alias, like
> __never_indirect or something, so there is an arch-agnostic way to do
> this that actually says what it does? (yes, it's in x86-only code now,
> hence the bike shed...)

I actually asked Mark a related question last week somewhere, I think
the answer was that the annotation either wasn't working or not as
useful on ARM64.

I'm thinking it's easy enough to do a mass rename if/when we cross that
bridge though.
