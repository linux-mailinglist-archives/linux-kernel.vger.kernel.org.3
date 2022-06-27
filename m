Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F755D84C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiF0N1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiF0N1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:27:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0E643C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oVD+QIl1BooxhQ4c9TLCTCyf9nUe8Yh23CWiTKDZtFw=; b=moT2H7vy0ds8RhMZueK4Hz5/u5
        kBF155FPvcg5S1mr37SB1xvpS5DY4Jg8VjxDBSKg42s8UR7mle7R/Uqs5rvWcVxmgQwLMR03ougHV
        iQN19lMVKCSJRK6nbBSLRsTHgxb6mxJO+NGkm6JcMM62+cGIEd6jZ9XxviONYb1cXtL8ErBg86/nT
        jBoUOwh0ZhKrrrgQIokaNNr9QUgE7fULEp7RikwFdChUmT4ZGnBpt2maxobOqnXI+no271CRRoEM5
        yNI42atW/+zXVmOBJkIFAjE2zwZ3N8ooYFueeOBDEYxvoJ/4iOVY3SlTam84gKpB10COQ1Fl5V3cf
        IWrm9qIA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5old-00BOMN-K8; Mon, 27 Jun 2022 13:27:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 668D6300478;
        Mon, 27 Jun 2022 15:27:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51AA7200B5F27; Mon, 27 Jun 2022 15:27:03 +0200 (CEST)
Date:   Mon, 27 Jun 2022 15:27:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        ebiederm@xmission.com,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] signal: break out of wait loops on kthread_stop()
Message-ID: <YrmwJyueoz1Z4ti0@hirez.programming.kicks-ass.net>
References: <20220627120020.608117-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627120020.608117-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:00:20PM +0200, Jason A. Donenfeld wrote:

> +bool __kthread_should_stop(struct task_struct *k)
> +{
> +	return (k->flags & PF_KTHREAD) &&
> +	       test_bit(KTHREAD_SHOULD_STOP, &to_kthread(k)->flags);
> +}

This used to be a racy pattern; not sure it still is since Eric poked at
this last, but please use __to_kthread() instead.
