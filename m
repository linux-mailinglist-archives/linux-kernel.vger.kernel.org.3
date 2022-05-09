Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2951F546
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiEIH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiEIHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:23:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14C12FEC3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ty1AgeIKh2EYFgs2k2ZbylGJHiYAUJfCHKZ+rmSmMaQ=; b=RoAnqLNllKj1hmkegOm01Xrm+D
        Cz0Tx3zj9aXC2bt73QRpqQYKllmFeswOUAvhK1nxKrs+IgAKwTfx+2dUKy1M0VPPsLfFeClcMayiZ
        C1ZNRWpY/BpppfQ93+0f9aQ4oSMXHAH8GQZzYcvXko90t8A9EI9jKAIhzXqhfXYI5AkuO4vLo9nhv
        SmSnnmoEF6Llw8DtgVnwb8sJjhFM54P9/lfGkqF1qfQDcKXSfOE95/VxDY3xrUeKNcFroU2fjVOQb
        xCtJv8/ws76Ez9CtCEirvWoSjtwUmjT8oIs6a3GxmL14Z2SGfXy8DN9qa71hMYS7/SRTsmwFt1lBg
        ohsuZp1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnxfx-003E3h-2F; Mon, 09 May 2022 07:19:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 391D9980E93; Mon,  9 May 2022 09:19:24 +0200 (CEST)
Date:   Mon, 9 May 2022 09:19:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Functions may simplify the use of return values
Message-ID: <20220509071924.GF76023@worktop.programming.kicks-ass.net>
References: <20220507150630.90399-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507150630.90399-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 11:06:30PM +0800, Li kunyu wrote:
> p4d_clear_huge may be optimized for void return type and function usage.
> vunmap_p4d_range function saves a few steps here.

This makes it different from all the other p??_clear_huge() functions,
which seems like an exceedingly bad idea.
