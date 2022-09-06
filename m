Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA45AE67E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiIFLXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiIFLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:23:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F345726E;
        Tue,  6 Sep 2022 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lr2b8+2Ceub55ZbeDBzcLTRIdb9YlSmsltMwJPK6Y20=; b=dEhWkeCCkKC0swqU0nf+i0XV3U
        lovsX9dUPl7iNWiwZpxoyxzdz+w1unkH2mOdmqq24kgwstEtAkgX7pUMxMmpQhV4fxxLtnTukLnSn
        QqpCFMzONI3WidXrtue0IcPFhqBBl6GymEs5iEDXRUyDM+wEmfCEZBwggexb7Hf6cpJ9A11vLoFJb
        XZA4YWdA+gPp/SUnRQY7aiiNgebfpfV686sBPZhDH9jzp+/x9yUmATh2bKUj4meVaINK2c7ivYd5z
        OKHl6MdxLYAvcCqK4f4Rueh1a1vDUmpoHbDWYGmKKLjy8rPTqRZ49GYx6vHQBPdCAlRdx284HdVpJ
        ahKN+u5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVWfj-00A9An-TP; Tue, 06 Sep 2022 11:23:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E5DA3002A3;
        Tue,  6 Sep 2022 13:23:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 098E12B6641C8; Tue,  6 Sep 2022 13:23:14 +0200 (CEST)
Date:   Tue, 6 Sep 2022 13:23:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YxctoffFFPXONESt@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <YxR5Yauhd90WN/AY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxR5Yauhd90WN/AY@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 12:09:37PM +0200, Ingo Molnar wrote:

> BTW., we should probably mark/document all PF_ holes with a PF__RESERVED 
> kind of scheme? Something simple, like:
> 
>    #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
>    #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
>  + #define PF__RESERVED_04000	0x00004000	/* Unused */
>    #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
>  + #define PF__RESERVED_10000	0x00010000	/* Unused */
>    #define PF_KSWAPD		0x00020000	/* I am kswapd */
>    #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
>    #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */


How's this then, it immediately shows how holey it is :-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1722,7 +1722,9 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC		0x00000800	/* Allocating memory */
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
+#define PF__HOLE__00004000	0x00004000	/* A HOLE */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
+#define PF__HOLE__00010000	0x00010000	/* A HOLE */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
@@ -1730,9 +1732,14 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
+#define PF__HOLE__00800000	0x00800000	/* A HOLE */
+#define PF__HOLE__01000000	0x01000000	/* A HOLE */
+#define PF__HOLE__02000000	0x02000000	/* A HOLE */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
+#define PF__HOLE__20000000	0x20000000	/* A HOLE */
+#define PF__HOLE__40000000	0x40000000	/* A HOLE */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
 /*
