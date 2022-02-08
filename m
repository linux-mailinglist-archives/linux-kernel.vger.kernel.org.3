Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6454AD9B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355342AbiBHNXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351396AbiBHNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:20:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E0C03BFFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8E5BCE182D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9BFC004E1;
        Tue,  8 Feb 2022 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644326226;
        bh=pyYWSe+Jjk7H9EMWk07P5RtmfXzKKM1LErV2wfS8qKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2Mb2BQlgKuqbJaDUtjCkPOrmzwYLXU48ytWbBxEOlY5sBc9caCg1cY5DFmj+Q0Q5
         VtQDkm/UyWabPnK13Y4FZilRsArQJb6LvzhbwSWxpiJofz2EMt42FvqfR2U4cXnqCn
         BTgXhYEtoXNWR8IrOUU7SihX8Nkj9aadSVugloSDB7u9GRd8Ffiz2k3PimkHOGfASe
         uJqt0eoPytb+fHeBNjqsLQglRLI37wL6wnK4bxiXNr0Mp1hwRGiAZQ1oKpM6tXESyA
         097YSjs9s2skEMTczes+grTL11i90cg9DB8WePmZayo5N2tdxYiMkfWpn6ZkqSowYM
         KHZR/mL9ePDxw==
Date:   Tue, 8 Feb 2022 14:17:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64le: `NOHZ tick-stop error: Non-RCU local softirq work is
 pending, handler #20!!!` when turning off SMT
Message-ID: <20220208131703.GA538566@lothringen>
References: <0baca95b-771f-2217-1098-2d0eee568ea7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0baca95b-771f-2217-1098-2d0eee568ea7@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 08:32:37AM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the POWER8 server IBM S822LC running Ubuntu 21.10, Linux 5.17-rc1+ built
> with
> 
>     $ grep HZ /boot/config-5.17.0-rc1+
>     CONFIG_NO_HZ_COMMON=y
>     # CONFIG_HZ_PERIODIC is not set
>     CONFIG_NO_HZ_IDLE=y
>     # CONFIG_NO_HZ_FULL is not set
>     CONFIG_NO_HZ=y
>     # CONFIG_HZ_100 is not set
>     CONFIG_HZ_250=y
>     # CONFIG_HZ_300 is not set
>     # CONFIG_HZ_1000 is not set
>     CONFIG_HZ=250
> 
> once warned about a NOHZ tick-stop error, when I executed `sudo
> /usr/sbin/ppc64_cpu --smt=off` (so that KVM would work).

I see, so I assume this sets some CPUs offline, right?

> 
> ```
> $ dmesg
> [    0.000000] Linux version 5.17.0-rc1+
> (pmenzel@flughafenberlinbrandenburgwillybrandt.molgen.mpg.de) (Ubuntu clang
> version 13.0.0-2, LLD 13.0.0) #1 SMP Fri Jan 28 17:13:04 CET 2022
> […]
> [271272.030262] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271272.305726] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271272.549790] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271274.885167] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271275.113896] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271275.412902] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271275.625245] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271275.833107] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271276.041391] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> [271277.244880] NOHZ tick-stop error: Non-RCU local softirq work is pending,
> handler #20!!!
> ```

That's IRQ_POLL_SOFTIRQ. The problem here is probably that some of these
softirqs are pending even though ksoftirqd has been parked.

I see there is irq_poll_cpu_dead() that migrates the pending queue once
the CPU is finally dead, so this is well handled.

I'm preparing a patch to fix the warning.

Thanks.
