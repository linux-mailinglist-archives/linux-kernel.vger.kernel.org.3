Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D4950ED68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiDZASc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiDZASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:18:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19E18D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:15:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650932123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=SHLnyye+kmTGtor0bLJF1M3srMoZkuilaHjIoJrpLEU=;
        b=T7hGqjpu1sS/cAAyib7/RqZHOd5sbw4Pj7nRTHkRGRxwWkImvRzaHvxg4fB/wokC0GwTYO
        k1LVc8mECT+yL36NNPTag2n1sWnC/50RMyZdWzW3ZGWqmOE5TPsSTmYuODoKW8D8OoLBTH
        oqmx3fPtAVjh1jSWAU9eVqcGsbsxVOcJI3yXw/avPmFc3buZccVy8CfJepVGVMOkEoE16r
        GiAf3wquTLX1nrDVpo+qDStB5d6oOgnsPn2an0/IXWvOo82+P3i+zsYfZ7BmIV4mPRJbX/
        46eu+2PXO79avWJGE1+cWTY5UL81MaNsLKKf9ez7xLcxQz4GFPN9jlIaaVOVdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650932123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=SHLnyye+kmTGtor0bLJF1M3srMoZkuilaHjIoJrpLEU=;
        b=wgdA9FOLD+dOFFAArK1US7aPymRPSiMvHy2Ys2heVjbyuUF2qZgkU8Ry8fhn8F1mJB7+Sb
        Xw/5K0v81eC8ADBA==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 04/13] add prctl task isolation prctl docs and samples
In-Reply-To: <20220315153313.908516477@fedora.localdomain>
Date:   Tue, 26 Apr 2022 02:15:22 +0200
Message-ID: <87r15kzomd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> +++ linux-2.6/samples/task_isolation/task_isol.c

> +#ifdef PR_ISOL_FEAT_GET

This ifdef is there because the kernel on which this sample is compiled
does not support PR_ISOL_FEAT_GET? Try again...

> +int task_isol_setup(int oneshot)
> +{
> +	int ret;
> +	int errnosv;
> +	unsigned long long fmask;
> +	struct task_isol_quiesce_extensions qext;
> +	struct task_isol_quiesce_control qctrl;
> +
> +	/* Retrieve supported task isolation features */
> +	ret = prctl(PR_ISOL_FEAT_GET, 0, &fmask, 0, 0);
> +	if (ret == -1) {
> +		perror("prctl PR_ISOL_FEAT");
> +		return ret;
> +	}
> +	printf("supported features bitmask: 0x%llx\n", fmask);
> +
> +	/* Retrieve supported ISOL_F_QUIESCE bits */
> +	ret = prctl(PR_ISOL_FEAT_GET, ISOL_F_QUIESCE, &qext, 0, 0);

It makes a lot of sense to query ISOL_F_QUIESCE if the supported
features bitmask has not set it, right?

> +	if (ret == -1) {
> +		perror("prctl PR_ISOL_FEAT (ISOL_F_QUIESCE)");
> +		return ret;
> +	}
> +	printf("supported ISOL_F_QUIESCE bits: 0x%llx\n",
> +		qext.supported_quiesce_bits);
> +
> +	fmask = 0;
> +	ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
> +	errnosv = errno;
> +	if (ret != -1 && fmask != 0) {
> +		printf("Task isolation parameters already configured!\n");
> +		return ret;
> +	}

Really useful because if that code is executed after a fork/clone then
it fails, not in that particular case, but this is _NOT_ a test case,
this is a sample to demonstrate usage.

> +	if (ret == -1 && errnosv != ENODATA) {

How exactly ends this prctl() up returning ENODATA?

> +		perror("prctl PR_ISOL_GET");
> +		return ret;
> +	}
> +	memset(&qctrl, 0, sizeof(struct task_isol_quiesce_control));
> +	qctrl.quiesce_mask = ISOL_F_QUIESCE_VMSTATS;
> +	if (oneshot)
> +		qctrl.quiesce_oneshot_mask = ISOL_F_QUIESCE_VMSTATS;
> +
> +	ret = prctl(PR_ISOL_CFG_SET, I_CFG_FEAT, ISOL_F_QUIESCE,
> +		    QUIESCE_CONTROL, &qctrl);
> +	if (ret == -1) {
> +		perror("prctl PR_ISOL_CFG_SET");
> +		return ret;
> +	}
> +	return ISOL_F_QUIESCE;

Very consistent return value:

     int task_isol_setup(int oneshot)

which just works because the whole definition of the ISOL_F_* feature
space is bogus and inconsistent hackery, but if that ever goes up to bit
31bit+ then all of this is just crap.

> +}
> +
> +int task_isol_activate_set(unsigned long long mask)

While you here make sure that @mask is properly sized. Btw. uint64_t
exists for a reason...

> +int main(void)
> +{
> +	int ret;
> +	void *buf = malloc(4096);
> +	unsigned long mask;

Works by chance...

> +	memset(buf, 1, 4096);
> +	ret = mlock(buf, 4096);
> +	if (ret) {
> +		perror("mlock");
> +		return EXIT_FAILURE;
> +	}
> +
> +	ret = task_isol_setup(0);
> +	if (ret == -1)
> +		return EXIT_FAILURE;
> +
> +	mask = ret;
> +	/* enable quiescing on system call return, oneshot */
> +	ret = task_isol_activate_set(mask);
> +	if (ret)
> +		return EXIT_FAILURE;
> +
> +#define NR_LOOPS 999999999
> +#define NR_PRINT 100000000
> +	/* busy loop */

Really readable code.... Not.

> +	while (ret < NR_LOOPS)  {
> +		memset(buf, 0, 4096);
> +		ret = ret+1;

The kernel has a well define coding style which is not optional for
samples.

> +int main(void)
> +{
> +	write_loops = 0;
> +	do {
> +#define NR_LOOPS 999999999
> +#define NR_PRINT 100000000

Groan.

> +		/* enable quiescing on system call return */
> +		ret = task_isol_activate_set(mask);
> +		if (ret)
> +			return EXIT_FAILURE;
> +
> +		/* busy loop */
> +		while (ret < NR_LOOPS)  {
> +			memset(buf, 0xf, 4096);
> +			ret = ret+1;
> +			if (!(ret % NR_PRINT))
> +				printf("wloop=%d loops=%d of %d\n", write_loops,
> +					ret, NR_LOOPS);

This is really a brilliant example of design fail at the conceptual level:

     task_isol_activate_set()
       set_thread_flag(TIF_TASK_ISOL);
       exit_to_user_mode()
          if (thread_flag(TIF_TASK_ISOL)) {
             handle_isol_muck() {
               clear_thread_flag(TIF_TASK_ISOL);
               ....
             }
     printf()
       sys_write()....
       exit_to_user_mode()
         ....
         
         --->  which might coincidentaly quiesce stuff or not just
               because something might have set TIF_TASK_ISOL or not.

Are you serious that setting TIF_TASK_ISOL from each of these envisioned
facilities which need quiescing is a maintainable approach?

That's a recipe for disaster and a guarantee for hard to diagnose
problems which ends up with a flood of non-sensical patches sprinkling
set_thread_flag(TIF_TASK_ISOL) all over the place just to cure the
symptoms.

Sure you can claim that this did not blow up in your face so far, but
that's a useless argument because _one_ out of the proposed 64 x 64 is
perhaps maintainable, but not anything beyond that.

Thanks,

        tglx


