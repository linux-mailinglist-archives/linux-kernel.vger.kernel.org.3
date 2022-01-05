Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327FB484EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiAEHUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:20:13 -0500
Received: from cavan.codon.org.uk ([176.126.240.207]:57250 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiAEHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:20:12 -0500
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 9E43A4250A; Wed,  5 Jan 2022 07:20:10 +0000 (GMT)
Date:   Wed, 5 Jan 2022 07:20:10 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
Message-ID: <20220105072010.GA31134@srcf.ucam.org>
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com>
 <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
 <20220105064827.GA30988@srcf.ucam.org>
 <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 02:57:57PM +0800, Kai-Heng Feng wrote:

> The affected system from the customer has SecureBoot enabled (and
> hence lockdown), and the kernel upgrade surprisingly broke ioperm()
> usage.

Which kernel was being used that was signed but didn't implement 
lockdown? That sounds, uh, bad.

> The userspace program is proprietary so I can't share it here.

Ok. Are you able to describe anything about what it does so we can 
figure out a better solution?

> Basically this patch makes ioperm() a noop on SecureBoot enabled x86 systems.
> If reverting is not an option, what else can we do to circumvent the regression?

There's two main choices:

1) Disable secure boot on the system in question - if there's a need to 
run userland that can do arbitrary port IO then secure boot isn't 
providing any meaningful security benefit in any case.

2) Implement a kernel driver that abstracts the hardware access away 
from userland, and ensures that all the accesses are performed in a safe 
way.

Doing port IO from userland is almost always a terrible idea - it 
usually involves indexed accesses (you write an address to one port and 
then write or read data from another), and if two processes are trying 
to do this simultaneously (either because SMP or because one process 
gets preempted after writing the address but before accessing the data 
register), and in that case you can end up with accesses to the wrong 
register as a result. You really want this sort of thing to be mediated 
by the kernel, both from a safety perspective and to ensure appropriate 
synchronisation.
