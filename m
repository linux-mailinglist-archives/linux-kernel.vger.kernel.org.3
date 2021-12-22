Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F3147CDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243216AbhLVIR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:17:57 -0500
Received: from verein.lst.de ([213.95.11.211]:49611 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243191AbhLVIR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:17:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C098768AFE; Wed, 22 Dec 2021 09:17:53 +0100 (CET)
Date:   Wed, 22 Dec 2021 09:17:53 +0100
From:   hch <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     hch <hch@lst.de>, anton ivanov <anton.ivanov@cambridgegreys.com>,
        x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: remove set_fs for UML
Message-ID: <20211222081753.GB22041@lst.de>
References: <20211215165612.554426-1-hch@lst.de> <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:05:03PM +0100, Richard Weinberger wrote:
> So far UML seems to work with these changes applied. :-)
> I have applied both patches to my UML tree for now, I assume x86 maintainers are fine with
> patch 1/2?

Looks like patch 1 needs this fixup for some configurations, where
pci.h doesn't get pulled into kvm by other means.

But we probably want an ACK from the x86 maintainers to be sure anyway..

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 0c76c45fdb686..fad546df0bbac 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -16,6 +16,7 @@
 #include "spte.h"
 
 #include <asm/e820/api.h>
+#include <asm/memtype.h>
 #include <asm/vmx.h>
 
 static bool __read_mostly enable_mmio_caching = true;
