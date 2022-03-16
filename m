Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368CC4DB492
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353527AbiCPPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358038AbiCPPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:14:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839C674C8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1xct5ZzoDGRIULR+oIXCYrzSITgQyaIKfqXXCkUhatw=; b=FtGWrIASZ0PpGX86+dz6b9+yzE
        A1d2Tw9YXAW3QKV5AUe7Cmdx5z/gL3jOTCb6N2trBUovJ+p30Ik4wR4kXKkFkreo2WWu7nvciUjAQ
        1BB3BA79AwCy2HWpAP0yrfxnLMy/E0zbOYbWc95KuS9chaYfRAsGvVoRDJDO1qHR283JM4S5NAtjx
        7xwA7tRQcJH3ZPt6Xo6xcPiX5WGTFmo+5qbvh9LvSJbw8TEjnvgA/c/bz/NG64MMGEMYG6xRfzKLE
        YX+L3t/5XS03zwkYTgat+wTfW9JsP5bcrd6rrgrWHxNP5unRgoPEImbXEbOpEAswQtX9FNxyNRNSH
        8+hxvnXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUVK1-0065XM-Qt; Wed, 16 Mar 2022 15:12:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52BF730021B;
        Wed, 16 Mar 2022 16:12:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BDE92C47F850; Wed, 16 Mar 2022 16:12:21 +0100 (CET)
Date:   Wed, 16 Mar 2022 16:12:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH V3 0/7] x86/entry: Clean up entry code
Message-ID: <YjH+VdHIiHZM3maD@hirez.programming.kicks-ass.net>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315073949.7541-1-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:42PM +0800, Lai Jiangshan wrote:

> Lai Jiangshan (7):
>   x86/entry: Use idtentry macro for entry_INT80_compat
>   x86/traps: Move pt_regs only in fixup_bad_iret()
>   x86/entry: Switch the stack after error_entry() returns
>   x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
>   x86/entry: Move cld to the start of idtentry
>   x86/entry: Don't call error_entry for XENPV
>   x86/entry: Convert SWAPGS to swapgs and remove the definition of
>     SWAPGS

So AFAICT these patches are indeed correct.

I do however worry a little bit about the I$ impact of patch 4, and
there's a few niggles, but otherwise looks good.

I'd love for some of the other x86 people to also look at this, but a
tentative ACK on this.

