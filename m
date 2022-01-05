Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD84850D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiAEKOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiAEKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:14:39 -0500
X-Greylist: delayed 12369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jan 2022 02:14:39 PST
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D97C061761;
        Wed,  5 Jan 2022 02:14:38 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id BB17A4250A; Wed,  5 Jan 2022 10:14:37 +0000 (GMT)
Date:   Wed, 5 Jan 2022 10:14:37 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
Message-ID: <20220105101437.GA32516@srcf.ucam.org>
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com>
 <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
 <20220105064827.GA30988@srcf.ucam.org>
 <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
 <20220105072010.GA31134@srcf.ucam.org>
 <CAAd53p6VcAo0MVMWerTag42cWFE2ifzdQ=AFmGd9a=2gFjgv5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6VcAo0MVMWerTag42cWFE2ifzdQ=AFmGd9a=2gFjgv5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:05:26PM +0800, Kai-Heng Feng wrote:
> On Wed, Jan 5, 2022 at 3:20 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > On Wed, Jan 05, 2022 at 02:57:57PM +0800, Kai-Heng Feng wrote:
> >
> > > The affected system from the customer has SecureBoot enabled (and
> > > hence lockdown), and the kernel upgrade surprisingly broke ioperm()
> > > usage.
> >
> > Which kernel was being used that was signed but didn't implement
> > lockdown? That sounds, uh, bad.
> 
> It was upgraded from older distro release. Older kernels don't have lockdown.

But have a signed bootloader? Which releases?

> > There's two main choices:
> >
> > 1) Disable secure boot on the system in question - if there's a need to
> > run userland that can do arbitrary port IO then secure boot isn't
> > providing any meaningful security benefit in any case.
> 
> How so?
> Other security features are still incredible valuable, we don't want
> to toss them out just because someone has to use ioperm().

Because having the ability to do port io allows you to tamper with the 
running kernel and disable all the other security boundaries, making 
them pointless. Many PCI devices have a port IO side channel into MMIO 
BARs for use in early boot, so if an attacker can fill that BAR as they 
wish and then modify the BAR to map it into the kernel address space 
(and fix up the bridges appropriately), or if the port IO interface can 
be used to trigger DMA, the outcomes are pretty bad. The point of 
lockdown is to disable every plausible interface for userland (even uid 
0) to have access to any interfaces that would let them insert modified 
code into ring 0 - port IO is definitely one of those interfaces. An 
attacker could just take a kernel that allows ioperm(), add an initramfs 
containing their payload, boot, hotpatch the kernel to disable lockdown, 
and then kexec into their backdoored payload.

> >
> > 2) Implement a kernel driver that abstracts the hardware access away
> > from userland, and ensures that all the accesses are performed in a safe
> > way.
> >
> > Doing port IO from userland is almost always a terrible idea - it
> > usually involves indexed accesses (you write an address to one port and
> > then write or read data from another), and if two processes are trying
> > to do this simultaneously (either because SMP or because one process
> > gets preempted after writing the address but before accessing the data
> > register), and in that case you can end up with accesses to the wrong
> > register as a result. You really want this sort of thing to be mediated
> > by the kernel, both from a safety perspective and to ensure appropriate
> > synchronisation.
> 
> Agree, let me start a discussion with them.

Sounds good.
