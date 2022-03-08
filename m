Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6014D1F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348927AbiCHR6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiCHR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:58:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A33DF44
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PpZLv3q78rxILUILZuIRhQ5QDV8O6Gqy6pmSYzlsrRY=; b=mxK5QU6CKfNncBpjYK+OK0X9KT
        ed6Og1kPo+JglHMfFmJJGoWoqGXYOWpFbz13pq03Nb3ILCeKPWlFfV2aw1rN4jCgUY9RzjcC/Yvg+
        m+7+pP/ggxUA9wm42m79JuTCRsW/NrLK2FyBNQgFKvc2MlrdolV/5bPlBEMsgVrxzvg+U7hWX3OPR
        Q0ObX69IoWBgDtOnlI20vgoh2F5feKOuFxx02zXBnYbojdBLVL2yiLlu7zDefhg+BGcNP5WsR/EA6
        M1KJufsxzSN2XjdlcqO4h0iG3LI5iXr1RZd7yNiMZeJhR8mrQ0zMgMLp9Hultkxnd4raSXtFcjDQA
        x8A1dmXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57722)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nRe5i-0000iC-Mm; Tue, 08 Mar 2022 17:57:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nRe5i-00074Z-1a; Tue, 08 Mar 2022 17:57:46 +0000
Date:   Tue, 8 Mar 2022 17:57:46 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, joey.gouly@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] arm64: improve display about CPU architecture in
 cpuinfo
Message-ID: <YieZGoV+XR2kdHix@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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

Actually, it is impossible to do it reliably. I won't expand on this,
except what I said in my other reply - there are cases where the MIDR
value is not unique.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
