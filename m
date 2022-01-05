Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFAB484E86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiAEG4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:56:20 -0500
Received: from cavan.codon.org.uk ([176.126.240.207]:57178 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiAEG4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:56:20 -0500
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 01:56:19 EST
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 3DA474250A; Wed,  5 Jan 2022 06:48:27 +0000 (GMT)
Date:   Wed, 5 Jan 2022 06:48:27 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
Message-ID: <20220105064827.GA30988@srcf.ucam.org>
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com>
 <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 02:25:41PM +0800, Kai-Heng Feng wrote:

> This patch breaks ioperm() usage from userspace programs with CAP_SYS_RAWIO cap.
> 
> I wonder if it's possible to revert this commit?

When lockdown is enabled, or under all circumstances? It's expected to 
be blocked when lockdown is enabled - allowing userland to use port IO 
would potentially allow reconfiguration of PCI devices in ways that 
could alter kernel behaviour in ways relevant to security, which is what 
lockdown aims to prevent. What's being broken by this?
