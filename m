Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD15276CA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiEOKD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiEOKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73D3D1E2;
        Sun, 15 May 2022 03:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4A160EF4;
        Sun, 15 May 2022 10:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC45C385B8;
        Sun, 15 May 2022 10:03:17 +0000 (UTC)
Date:   Sun, 15 May 2022 11:03:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 2/2] cpu/hotplug: Remove the input parameter
 primary_cpu of smp_shutdown_nonboot_cpus()
Message-ID: <YoDP4aYg7vdUg4sO@arm.com>
References: <20220512030619.13426-1-kernelfans@gmail.com>
 <20220512030619.13426-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030619.13426-3-kernelfans@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:06:19AM +0800, Pingfan Liu wrote:
> For all call sites of smp_shutdown_nonboot_cpus(),
> 
> $git grep smp_shutdown_nonboot_cpus -- arch | grep -v \*
> arch/arm/kernel/reboot.c:94:    smp_shutdown_nonboot_cpus(reboot_cpu);
> arch/arm64/kernel/process.c:89: smp_shutdown_nonboot_cpus(reboot_cpu);
> arch/ia64/kernel/process.c:578: smp_shutdown_nonboot_cpus(reboot_cpu);
> arch/riscv/kernel/machine_kexec.c:135:  smp_shutdown_nonboot_cpus(smp_processor_id());
> 
> As it shows, the input parameter seems a little arbitrary.
> 
> Since kernel_kexec()->migrate_to_reboot_cpu() has already pinned the
> rebooting thread on the selected CPU and the CPU hotplug keeps disabled
> before smp_shutdown_nonboot_cpus(). Let smp_shutdown_nonboot_cpus()
> deduce the rebooting CPU by smp_processor_id(), instead of passing the
> parameter primary_cpu to it.
> 
> As a result, all call sites look consistent.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> To: linux-ia64@vger.kernel.org
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
