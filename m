Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BFB5786DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiGRQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:00:36 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC1DF3A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mtkzJ8gYIfVJHGmdttrnhSApebA9lu35Rql+jSin4as=; b=qLZBllo2beUcZ4h47K6T14QkxU
        PEU68ddXgkJWQ+kM5WeuQpEmri4NJrW6H8GNwBeH0CNDG/5bbP4s1bund9sceoaQtfCOOnDBjfT/n
        y/TheW5S9/VKWrIxWSgqhSy6DpE8oj3dZ/ppNSioe0JBXOerhepdc4S7TTKLioz2AqnQogl6AF+fX
        wXiNOPPFR0MqrH6gY5byXYfnj3EJpEt98S7229giNLCVc8Rg0GL2ibbusUo648XNZqOua/Dl8yrWG
        jeuALN/KLuSYKCMyRzbvBH8/t5N2STz6cSW0jf2FKYXXn43iI8YAp0tH/DGQgMFquY5T34zjHHkAz
        C9vGxqYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33414)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oDTAG-0001mC-9n; Mon, 18 Jul 2022 17:00:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oDTAD-00024v-7W; Mon, 18 Jul 2022 17:00:05 +0100
Date:   Mon, 18 Jul 2022 17:00:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        tabba@google.com, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v4 01/18] arm64: stacktrace: Add shared header for common
 stack unwinding code
Message-ID: <YtWDhV4PPtTrYbMH@shell.armlinux.org.uk>
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-2-kaleshsingh@google.com>
 <YtVXokYGdlq1maQu@shell.armlinux.org.uk>
 <CAC_TJvfZG6CQOdSKeiNfVQhmL2TyeEuFbo9qo9yT20Qh49d3ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvfZG6CQOdSKeiNfVQhmL2TyeEuFbo9qo9yT20Qh49d3ZQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:26:14AM -0700, Kalesh Singh wrote:
> On Mon, Jul 18, 2022 at 5:52 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Hi,
> >
> > Can you please explain why you are targetting my @oracle.com email
> > address with this patch set?
> >
> > This causes me problems as I use Outlook's Web interface for that
> > which doesn't appear to cope with the threading, and most certainly
> > is only capable of top-reply only which is against Linux kernel email
> > standards.
> 
> Hi Russell,
> 
> Sorry I wasn't aware of it (I got your oracle email from
> get_maintainer script). Going forward I'll use the one you responded
> from instead.

Oh, this is the very annoying behaviour of get_maintainer.pl default
mode to think that if someone touches a file, they're interested in
future changes to it. In this case, it's because we both touched
arch/arm64/include/asm/memory.h back in November 2021, and this
silly script thinks I'll still be interested.

b89ddf4cca43 arm64/bpf: Remove 128MB limit for BPF JIT programs

(The patch was originally developed for Oracle's UEK kernels, hence
why it's got my @oracle.com address, but was later merged upstream.
Interestingly, no one spotted that Alan Maguire's s-o-b should've
been on it, as he was involved in the submission path to mainline.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
