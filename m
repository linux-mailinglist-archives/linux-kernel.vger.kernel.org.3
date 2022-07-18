Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C315577BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiGRGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiGRGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:54:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523A965AE
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:54:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658127281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3oMg+xgvxHikv+tJ6oZey82TaGFT5DoD5cvGkQB4iU=;
        b=ryHT9HdE6knXP+ik6pAtNLdqHISeKr0/wua7GfbXQ6XFzUOQ5XufTU1THvP1T5m6kpAx7/
        fIjSXgZCp62b1vaj8d+IK5PN9UKb54EMzZmmbenI1UvdlXg+3OkUsfALtg7OkgEFXIrtei
        TVqYXGwgWPB5h1nlqm68ZnCgAh8tRMge3bXxjvWaNK1UBD2AAuB0sRs/A5jSt4QoeOxDZ+
        pmSJ9RBmHop5RpE5hvR9rrskc6xfUTQojF2ZerVtU2v1kee+JBXVevcViOfdYXnvgMknFw
        U240yuCKlqI9yPVgkT2wfDHvpl3nen5oekXJ56/1+jtBU3excoe7hK7eKd79ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658127281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3oMg+xgvxHikv+tJ6oZey82TaGFT5DoD5cvGkQB4iU=;
        b=kDoDPFYp7z/wNjK3iD62+BH0V1nUNF/QdqIfNDmk8rvM5etzesX/WQC5n0vz7Pk5fll368
        nKwXIeQS5i0E0HBA==
To:     Juergen Gross <jgross@suse.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
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
In-Reply-To: <70b03d06-6ab9-1693-f811-f784a7dced76@suse.com>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com> <87zgh7wo91.ffs@tglx>
 <87tu7fwlhr.ffs@tglx> <87r12jwl9l.ffs@tglx> <87o7xnwgl3.ffs@tglx>
 <70b03d06-6ab9-1693-f811-f784a7dced76@suse.com>
Date:   Mon, 18 Jul 2022 08:54:41 +0200
Message-ID: <87lesqx64u.ffs@tglx>
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

On Mon, Jul 18 2022 at 07:11, Juergen Gross wrote:
> On 17.07.22 23:54, Thomas Gleixner wrote:
>>   void __init native_smp_prepare_boot_cpu(void)
>>   {
>>   	int me = smp_processor_id();
>> -	switch_to_new_gdt(me);
>> +
>> +	/* SMP invokes this from setup_per_cpu_areas() */
>> +	if (!IS_ENABLED(CONFIG_SMP))
>> +		switch_to_real_gdt(me);
>> +
>>   	/* already set me in cpu_online_mask in boot_cpu_init() */
>>   	cpumask_set_cpu(me, cpu_callout_mask);
>>   	cpu_set_state_online(me);
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -1164,7 +1164,7 @@ static void __init xen_setup_gdt(int cpu
>>   	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
>>   	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
>>   
>> -	switch_to_new_gdt(cpu);
>> +	switch_to_real_gdt(cpu);
>
> ... can't you use the paravirt variant of load_gdt in switch_to_real_gdt() ?

That does not solve the problem of having a disagreement between GDT and
GS_BASE. Let me dig into this some more.

Thanks,

        tglx
