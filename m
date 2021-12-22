Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6E47CDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbhLVIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:16:46 -0500
Received: from verein.lst.de ([213.95.11.211]:49601 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231675AbhLVIQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:16:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AD4C68AFE; Wed, 22 Dec 2021 09:16:40 +0100 (CET)
Date:   Wed, 22 Dec 2021 09:16:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: build failure after merge of the uml tree
Message-ID: <20211222081640.GA22041@lst.de>
References: <20211222105521.31b14a32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222105521.31b14a32@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:55:21AM +1100, Stephen Rothwell wrote:
> I am not sure what caused this - presumably some include file tidying up.

Yes, it needs this as a fixup:

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

