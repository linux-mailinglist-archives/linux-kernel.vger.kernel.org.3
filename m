Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCFE46852A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385125AbhLDNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbhLDNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:55:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBFC061354
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=72FWvOgOs59PMNnwMsJ3qHgJ07cr3+tSoXCqyzZ10M0=; b=KCIAHQGKeZHkfjPO2UA/BQADws
        gj47eBz2CB9a5ye29pPUQkH25J2M86byb8o2bXDPH7cXJ5fX/ur3BasE4yGdS7Uzmdgs/J/co/t6M
        c6CKQ+GrtRP0jZBXuHBibicYfZeEQYcWL5scp/FMZBLIUQpNpQU5ZzeszWgh3GaHnhTtJ+jlCn4d0
        voIk5+SjZYWDYKyOGLoIQ7K7O87QujxsDwIgVfIEO2A2+M7Oli9ymNkjAIfUS5bMfcwgMsgs8Acx8
        5xdJizKfgCYCuB4X9555KBtd12yYwDLWOb1IKvk3H0i4vn3nnLRsGlslQqtS5dIVSRRUJYMeYiMVc
        CVN8iT4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtVRl-00DG35-Ny; Sat, 04 Dec 2021 13:51:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1E813002C5;
        Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7492824C0540F; Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Message-ID: <20211204134338.760603010@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 04 Dec 2021 14:43:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v2 0/6] x86: Add stright-line-speculation mitigations
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respin and split of the SLS patch.

Since the old patch hit a snag, I've split up the patch as per popular demand.

New this time are patches 1 and 5 and some minor edits to the last patch, the
rest is mostly identical.

Patch 1 removes a 32bit (abuse) of the RET macro; which got exposed by the
build robot due to a change in the last patch (defining RET even for
!CONFIG_SLS). It would've been possible to revert to the old method of relying
on AS being case insensitive and RET being a valid instruction etc.. but I
figured that code was convoluted enough to warrant cleaning up anyway.

Patch 5 is what made Boris' machine go BUG when he tried to use the SLS patch.

Combined it seems to boot and build a kernel for me, so it must be perfect this
time (fingers crossed).

