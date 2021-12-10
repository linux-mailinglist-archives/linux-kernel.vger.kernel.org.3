Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC164705A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhLJQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbhLJQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BFDC061353
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8QUciRH1wuQHaeRYFWtZi0HAk1519caBXq0KazDuiBc=; b=G9cb2b42mDduzFBil/8H3WkKF+
        tRSu4csTRDdYllZzgGrl9DKDF0Y+Q+Ec5DG//rxQOuisUZ8/Q9jVQ1+qXFX9AUKUiLD7OLQypaJtE
        0m5DD7ffs23qIsp4pVEAlY1yp/cwk0ktCvYvltfg/INCyrVh+Ps4psER5T8ogE08L999Z7JdSrZrj
        YCRfzV7WsuIwRa7PlVvKmt2RQuXBk0dZL4EN0L2DLZYJQCmmRbcdTdYDcrwMswOLNLFD5VVKfv9uJ
        1wxiSXRHxNq5067tCiP6txv1YZ79StZL8DP/51EL+0eTnHLum2kM6qE1EGtvQd6IYwt07+hU/9egN
        TVoCvzyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijl-00ATwn-9W; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 862D5300491;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 588CA2B3C36B4; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210161618.645249719@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 0/9] refcount: Improve code-gen
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now with Linus' favourite refcount scheme on :-)

Changes since RFC:

 - more cleanups in scripts/atomic/
 - rename atomic_*_ofl() to atomic_*_overflow() (null)
 - alternative x86 refcount scheme (Linus)
 - fix for refcount_dec_not_one()
 - opt __refcount_add_not_zero(.i=1)

Boots x86_64 and builds a kernel.

