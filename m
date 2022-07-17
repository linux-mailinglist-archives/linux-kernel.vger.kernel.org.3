Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86753577827
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiGQUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGQUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:13:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996CD631B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:13:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658088791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kexTZTfmPKF4s2DqvpAl/OvqZteyp5V1sESoDgp4Y/M=;
        b=DbnyA62w02O9p2tcHFNKOZTm274xeRIps++TMB5tVU6ZxmQ/OK7f+luCB3L3XKKaT7Z3Mv
        SSmR4Mv2o10YXXzDl9wcd2LYhVp4GdPsFvOs5S2zbUtKguQ26EMDN3lOqGIh14IVUdBtA/
        B5nSkJsUMTqNPfx9Q8p/YmXUv9wy2UdcHh7m61s16AhaZTPLDn0yUbHgGHtZgk8TsSBteU
        0UPhp7ZLfXdETh7ZxD4m8oQQRxxZ6nQ3uUDCeGA11JsAiAubXSHEvqDFffL0Z4fq8mqrda
        CwTbCj0EyNTiBXz16kD6fEWV8d8SUkAb8K5bQlK0io4iIoqcrZwhMq2wMTNoYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658088791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kexTZTfmPKF4s2DqvpAl/OvqZteyp5V1sESoDgp4Y/M=;
        b=8rVQ2yNatV6QrpPK10MEDP7gM5wY7SmehIZYkhuh8bpcPdmSn4vLg1ui/fNZlIXovyTv+X
        +AQgwuYuZemUuFCw==
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
In-Reply-To: <87tu7fwlhr.ffs@tglx>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com> <87zgh7wo91.ffs@tglx>
 <87tu7fwlhr.ffs@tglx>
Date:   Sun, 17 Jul 2022 22:13:10 +0200
Message-ID: <87r12jwl9l.ffs@tglx>
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

On Sun, Jul 17 2022 at 22:08, Thomas Gleixner wrote:
> On Sun, Jul 17 2022 at 21:08, Thomas Gleixner wrote:
> loadsegment_simple() was a red herring. The gs segment is already zero.
>
> So what explodes here is the early boot when switching from early per
> CPU to the real per CPU area.
>
> start_kernel()
>         .....
>         setup_per_cpu_areas();
>         smp_prepare_boot_cpu()

Bah. switch_to_new_gdt() is already invoked from setup_per_cpu_areas()
and then again in smp_prepare_boot_cpu() and once more in cpu_init(),

What a mess.
