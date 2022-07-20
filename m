Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1133657B97B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbiGTPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiGTPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:22:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF815B7A0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:22:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c22so2892651wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=B7ZCcx3PFvqXIWmzEYEAMSZQUqgUbLEIYYRfsU6tLN0=;
        b=R/RPcBDANOBQ3L5w4es33+HWi93EMl03PM5JyRtbnHLwPuFc9nTEBM3RKadOYisxwh
         2eLIQArJifuOaKsBRDovJfv+t+UzwY+pMj/gH0zbQhgWtNHHBaXzyCKRYNFesd4Wkzq7
         s6UX64/ZYr/vz6uKvxb2qI4NjekbKWblDrq6A+IulCxND4W3AQtI6gJdFuJl9dfiYRDR
         a8q6bDUDHsAh52M4tM2P+oqNixSpy0+9kp1KcZg2MsUjXsASrkaRWG74w0YfO6YAxDOb
         lFoL75PuzNyKmHj/60SDh1z6h5LbKg53imTGwDsX+10xlDNBqPF8UZbGySb2LYc4hB3G
         U+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=B7ZCcx3PFvqXIWmzEYEAMSZQUqgUbLEIYYRfsU6tLN0=;
        b=AEh5oJKFRPdWSI8kHkKTw+/wF9XuQFAJMr4bYGcI8p/6iW2okm9bqp0yQ8Y/2NGVSA
         O11lLwxyXVol0pyUnWNePErFIvgzda5Y2b5pcWNtcDVR2liUIByoufX6H2J0YvD2J8b6
         iEOf1VyN2faJKeux5swDZH5UQq+zGeUbWTtaMXYEjTLdQaNNP9y5qGXjwskG2vx7GJ24
         IqpQyRgl9SHe6SCn6ONu+ZXyfbtzVQAWWTZ9Ln3odJkgupWj30FXy/GuXhrz3gbsvzcW
         wKTcZeOPyPTOUXMumSaoL3ndjMfd7I/Bizxw0BI/lyEmH/EHjoKsmoz1yHynFRynlSFR
         mc/w==
X-Gm-Message-State: AJIora/ZJZv2atusm9vExuOA2SuCkHZ0lUBE34XfKeVa2RCCwkfUQaDK
        SAxpzEyuEIIsaStjJ2hjXQ==
X-Google-Smtp-Source: AGRyM1uATRi5xkOFQt7n3uXCR0fTEliZH0uT5UwAwDQ8l56dlT3IQuADF8EOcXEWur7/LkNU0VLVtA==
X-Received: by 2002:a05:600c:3556:b0:3a3:2a9c:f26 with SMTP id i22-20020a05600c355600b003a32a9c0f26mr2945556wmq.58.1658330549436;
        Wed, 20 Jul 2022 08:22:29 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.107])
        by smtp.gmail.com with ESMTPSA id e39-20020a5d5967000000b0021badf3cb26sm19581921wri.63.2022.07.20.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:22:28 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:22:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: ftrace_kill() leads to kmalloc-512 UAF
Message-ID: <YtgdsW8UBSwCKtQW@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm debugging crash of our product which does live kernel patching together
with ISV security scanner which uses ftrace kprobes to do whatever it does.

What happens is that is ftrace ever detects .text change, refuses to patch
and prints a warning with FTRACE_WARN_ON_ONCE() then there is reliable way
to cause UAF on kmalloc-512 cache by trying to register kprobe with
perf_event_open() and then unregistering it by exiting the process.

1) live kernel patching happens, first instruction of some function changes

2) kprobe on that function is registered with perf_event_open()

	WARNING: CPU: 5 PID: 2109 at kernel/trace/ftrace.c:1853 ftrace_bug+0x25d/0x270
	 [<ffffffff811638ed>] ftrace_bug+0x25d/0x270
	 [<ffffffff81065571>] ftrace_replace_code+0x2b1/0x420
	 [<ffffffff81163f9a>] ftrace_modify_all_code+0x6a/0xb0
	 [<ffffffff810656f0>] arch_ftrace_update_code+0x10/0x20
	 [<ffffffff81164077>] ftrace_run_update_code+0x17/0x70
	 [<ffffffff81165512>] ftrace_set_hash+0x1c2/0x1f0
	 [<ffffffff8126fee0>] ? SyS_dup2+0x60/0x60
	 [<ffffffff8126fee0>] ? SyS_dup2+0x60/0x60
	 [<ffffffff811655a0>] ftrace_set_filter_ip+0x60/0x70
	 [<ffffffff8179624c>] arm_kprobe+0x9c/0x140
	 [<ffffffff81796368>] enable_kprobe+0x78/0xa0
	 [<ffffffff81187bab>] enable_trace_kprobe+0x7b/0x120
	 [<ffffffff81797e5f>] kprobe_register+0x2f/0x60
	 [<ffffffff8118348a>] perf_trace_event_init+0x1aa/0x230
	 [<ffffffff811836b7>] perf_kprobe_init+0xa7/0xf0
	 [<ffffffff811a8919>] perf_kprobe_event_init+0x49/0x70
	 [<ffffffff811aa569>] perf_try_init_event+0x99/0xc0
	 [<ffffffff811b29f2>] perf_init_event+0x92/0x150
	 [<ffffffff811b2fa1>] perf_event_alloc+0x4f1/0x910
	 [<ffffffff811b3789>] SYSC_perf_event_open+0x3c9/0xe50
	 [<ffffffff811b4679>] SyS_perf_event_open+0x9/0x10
	 [<ffffffff81799f92>] system_call_fastpath+0x25/0x2a
	ftrace failed to modify [<ffffffff8126fee0>] SyS_dup+0x0/0x120
	 actual: e9:4b:50:2e:3f

3) FTRACE_WARN_ON_ONCE() calls ftrace_kill() which sets ftrace_disabled:

	ftrace_disabled = 1;

4) process exits, all kprobes are unregistered but "ftrace_disabled" is 1 now
   so disarming fails with -ENODEV:

	[  253.042821] WARNING: CPU: 2 PID: 1682 at kernel/kprobes.c:1006 disarm_kprobe+0x102/0x180
	[  253.044424] Failed to disarm kprobe-ftrace at do_exit+0x0/0xa30 (-19)
	[  253.086658]  [<ffffffff811655a0>] ? ftrace_set_filter_ip+0x60/0x70
	[  253.089599]  [<ffffffff810a1810>] ? mm_update_next_owner+0x230/0x230
	[  253.090878]  [<ffffffff81796492>] disarm_kprobe+0x102/0x180
	[  253.092084]  [<ffffffff817965dd>] __disable_kprobe+0xcd/0xf0
	[  253.093242]  [<ffffffff81796c13>] disable_kprobe+0x23/0x40
	[  253.094390]  [<ffffffff81187d14>] disable_trace_kprobe+0xc4/0x100
	[  253.095751]  [<ffffffff81797e53>] kprobe_register+0x23/0x60
	[  253.097420]  [<ffffffff8118327c>] perf_trace_event_unreg.isra.1+0x3c/0xa0
	[  253.098866]  [<ffffffff81183730>] perf_kprobe_destroy+0x30/0x40
	[  253.100085]  [<ffffffff811af50a>] _free_event+0xfa/0x2f0
	[  253.101147]  [<ffffffff811af769>] put_event+0x19/0x20
	[  253.102154]  [<ffffffff811af993>] perf_event_release_kernel+0x223/0x300
	[  253.103457]  [<ffffffff811afa80>] perf_release+0x10/0x20
	[  253.106188]  [<ffffffff8125063c>] __fput+0xec/0x230

and more importantly underlying kprobe is not removed from "kprobe_table" hashtable:

	unregister_kprobe
	unregister_kprobes
	__unregister_kprobe_top
	__disable_kprobe
		ret = disarm_kprobe(orig_p, true);
			disarm_kprobe_ftrace
			__disarm_kprobe_ftrace
			ftrace_set_filter_ip
			ftrace_set_addr
			ftrace_set_hash
			        if (unlikely(ftrace_disabled))
			                return -ENODEV;

				// BOOM, function does nothing!!!

		if (ret) {
			p->flags &= ~KPROBE_FLAG_DISABLED;
			return ERR_PTR(ret);
		}	


perf_kprobe_destroy() will free the containing kprobe with inner kprobe
still in hashtable manifesting the bug as regular oopses, mystical oopses
in unrelated processes and doublefaults even.

	void perf_kprobe_destroy(struct perf_event *p_event)
	{
	        perf_trace_event_close(p_event);

		// does more or less nothing
	        perf_trace_event_unreg(p_event);
		// does kfree
	        destroy_local_trace_kprobe(p_event->tp_event);
	}


crash> p kprobe_table
kprobe_table = $1 =
 {{
  }, {
    first = 0xffff880135e9ddd8
  }, {
	...

crash> struct kprobe 0xffff880135e9ddd8
struct kprobe {
  hlist = {
    next = 0x6b6b6b6b6b6b6b6b,
    pprev = 0x6b6b6b6b6b6b6b6b
  },
  list = {
    next = 0x6b6b6b6b6b6b6b6b,
    prev = 0x6b6b6b6b6b6b6b6b
  },
  nmissed = 7740398493674204011,
  addr = 0x6b6b6b6b6b6b6b6b <Address 0x6b6b6b6b6b6b6b6b out of bounds>,
		....

This is much easier to reproduce by adding the following BUG_ON:

	--- a/kernel/trace/trace_kprobe.c.orig  2022-07-20 14:35:06.760511285 +0300
	+++ b/kernel/trace/trace_kprobe.c       2022-07-20 14:41:14.699877744 +0300
	@@ -512,8 +512,10 @@ static void __unregister_trace_kprobe(st
	        if (trace_probe_is_registered(&tk->tp)) {
	                if (trace_kprobe_is_return(tk))
	                        unregister_kretprobe(&tk->rp);
	-               else
	+               else {
	                        unregister_kprobe(&tk->rp.kp);
	+                       BUG_ON(!hlist_unhashed(&tk->rp.kp.hlist));
	+               }
	                tk->tp.flags &= ~TP_FLAG_REGISTERED;
	                /* Cleanup kprobe for reuse */
	                if (tk->rp.kp.symbol_name)

Basically, if ftrace_kill() is ever called ever there is a ticking UAFbomb.

	Alexey (CloudLinux)
