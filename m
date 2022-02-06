Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7748A4AB27A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbiBFVuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiBFVuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:50:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC80C06173B;
        Sun,  6 Feb 2022 13:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYhRHqxCkUHKTTrVS6ypQppPy8pN9/E8VMnKemjP0yE=; b=PCQuNQJZFJc/hohvYN3oMbB7c4
        Bd7Q7Zp+Lu+UTf0+6YAgQ+afo6/qgHLrVKNgI//8DbWLYldG4CBLlyjr8Btr+ab22cPjiwFuzjazH
        GazIGv4hzFjSjHU2QjnIcO7L8zcxjAplIirtEifXxOv70IgJrqSyY7PDQ8xITLEeE9PEXpXpqMlEl
        NRGbhTNrZu6evhmOoR1CNy1rNG7qy6i2kq+iBYir0oEM/toP02c74Oy5/ggctJQPDV8gN00/Ofva/
        kNBXYTdcR5BlE33ZbE8AHMK2+Ggh0MJB1FpoZcYJlvlTYFfmPK3izDoA69l0zQCV2DaWeAak1e742
        sHmKiJUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGpPi-00FjsC-0h; Sun, 06 Feb 2022 21:49:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D0FB300470;
        Sun,  6 Feb 2022 22:49:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 588002B37BEDA; Sun,  6 Feb 2022 22:49:40 +0100 (CET)
Date:   Sun, 6 Feb 2022 22:49:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        libc-coord@lists.openwall.com
Subject: Re: [RFC PATCH 1/3] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
Message-ID: <YgBCdExhei7VmfHd@hirez.programming.kicks-ass.net>
References: <20220203193853.21511-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203193853.21511-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:38:51PM -0500, Mathieu Desnoyers wrote:

> @@ -286,6 +287,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	if (bprm->have_execfd) {
>  		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
>  	}
> +#ifdef CONFIG_RSEQ
> +	NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));

I've gotta ask, what's up with offsetof(, end) vs sizeof() ?

> +	NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
> +#endif
