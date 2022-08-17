Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6A596EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiHQMsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiHQMsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:48:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE1275F6;
        Wed, 17 Aug 2022 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1qmsUsB+4SBL13h98w97pLya6IvHEpIdUKliGvuz3Dw=; b=OWOFpkz+Ko9XgkcpKc1GMq7+TX
        ANlnrr10yPCb1OwelWivsKmunjQoAgn7A9GQd+Am39PQjMbuAJsXd/Pq/c+g05OdWn/PkfzXb7bp9
        rLOLVteaZlcASPS6sAIppv1VHJAppyCgHlOhOuM0W3MRSnmFsT8hhnWZhNdGOHMoJZ/jmEQM/bZzx
        jlJMeaXNueMP3TIu7Wp85XsfthG2V29eQyDUVcyRj3fhyWdQAIK23zXvHZCOTE3PELP2UecxBg0Ue
        uLF5CWcEScvwgUmZUzh/98YhCbDJNPGm7NJJULOA1gDY36pxvMJu1RsvAY9KnqifAnxlfkG/OPiYd
        tYq383Pw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOISg-003HpW-Mc; Wed, 17 Aug 2022 12:47:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3BE1980256; Wed, 17 Aug 2022 14:47:52 +0200 (CEST)
Date:   Wed, 17 Aug 2022 14:47:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/14] locking/percpu-rwsem: Add
 percpu_is_write_locked() and percpu_is_read_locked()
Message-ID: <YvzjeEHYX9d5dhAt@worktop.programming.kicks-ass.net>
References: <20220704150514.48816-1-elver@google.com>
 <20220704150514.48816-11-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704150514.48816-11-elver@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 05:05:10PM +0200, Marco Elver wrote:

> +bool percpu_is_read_locked(struct percpu_rw_semaphore *sem)
> +{
> +	return per_cpu_sum(*sem->read_count) != 0;
> +}
> +EXPORT_SYMBOL_GPL(percpu_is_read_locked);

I don't think this is correct; read_count can have spurious increments.

If we look at __percpu_down_read_trylock(), it does roughly something
like this:

	this_cpu_inc(*sem->read_count);
	smp_mb();
	if (!sem->block)
		return true;
	this_cpu_dec(*sem->read_count);
	return false;

So percpu_is_read_locked() needs to ensure the read_count is non-zero
*and* that block is not set.

That said; I really dislike the whole _is_locked family with a passion.
Let me try and figure out what you need this for.
