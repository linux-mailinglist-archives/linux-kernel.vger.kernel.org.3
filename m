Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041024D1E82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiCHRTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348777AbiCHRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:19:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BF1EEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBC060C82
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE2EC340EB;
        Tue,  8 Mar 2022 17:18:11 +0000 (UTC)
Date:   Tue, 8 Mar 2022 17:18:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, joey.gouly@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] arm64: improve display about CPU architecture in
 cpuinfo
Message-ID: <YiePz/KpcE/S1+RR@arm.com>
References: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
 <87h78a178u.wl-maz@kernel.org>
 <a31431bf-24bb-71ac-8f3c-f9ca19f5c4f0@linux.alibaba.com>
 <87bkyi0x53.wl-maz@kernel.org>
 <1b94af8b-a294-5765-4e1e-896f70db621f@arm.com>
 <CAK8P3a3zA25=iZkVGPc=V+9tqqsWgQjoD9BSS60foGZtDwsujA@mail.gmail.com>
 <9296f97c-f894-001c-53e6-41bbfe36ce71@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9296f97c-f894-001c-53e6-41bbfe36ce71@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:05:06PM +0000, Robin Murphy wrote:
> On 2022-03-07 19:30, Arnd Bergmann wrote:
> > On Mon, Mar 7, 2022 at 5:48 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > 
> > > And arguably it's not even too late, because 10 years ago this *did* say
> > > "AArch64". I don't remember all the exact details behind commit
> > > 44b82b7700d0 ("arm64: Fix up /proc/cpuinfo") - this just tickled enough
> > > of a memory to go and look up the git history - but I don't think we
> > > changed any of those fields without a real reason.
> > > 
> > 
> > The patch description does state that this was done for compatibility with
> > 32-bit architectures, which does make some sense. I suppose for similar
> > reasons, the arch/arm/ version of /proc/cpuinfo is now stuck at
> > 'CPU architecture: 7', even for ARMv8 or higher in aarch32 mode.
> > 
> > The part that I find more annoying is how we leave out the one bit
> > of information that people are generally looking for in /proc/cpuinfo:
> > the name of the processor. Even though we already know the
> > exact processor type in order to handle the CPU errata, this is
> > always "model name\t: ARMv7 Processor rev %d (v7l)" on 32-bit,
> > and "model name\t: ARMv8 Processor rev %d (%s)" on 64-bit,
> > with the revision being the least important bit of information here...
> 
> Eh, it's hardly impossible to recompose a MIDR value from the implementer,
> part, variant and revision fields if one actually needs to. Maybe we could
> null-terminate the raw MIDR value and print it as a string of
> largely-unprintable characters in the "model name" field... I guess that
> might satisfy the crowd who want parity* with x86 CPUID, at least :)

You can get the MIDR from
/sys/devices/system/cpu/cpu*/regs/identification/midr_el1.

As for printing the actual names, we thought we'd leave it to tools like
lscpu. I'm not keen on maintaining a dictionary of MIDR to CPU marketing
names in the kernel, deal with rebranding and so on. For x86 you can get
the name from the CPU itself IIUC, that's not the case for arm.

-- 
Catalin
