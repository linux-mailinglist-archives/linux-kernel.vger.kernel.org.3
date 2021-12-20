Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3212947AC31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhLTOmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbhLTOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:40:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47FC061397;
        Mon, 20 Dec 2021 06:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0sDOaMAEBf8IDuNM3VlKvBLJKDD36giK/RqpFIAW/FI=; b=Tf5YZIRD7lFzczDIitIC5ORf40
        yLRnymyU1fuUwWmPGbSAFxhBprQPsSfW5T1jCoYrhuDIYSSOXwwPi9ttNxX5Gv7U3FJuoWMXDLmyq
        U9At0eMdjI1kWMpwFCjODb6MV2GPC6cxoxBR41OJ7nd3MscGq8BBLiiI0LjfJGCS+I3PJi1V0sncS
        0Y/6f/PDuWyubrZN1BXwnLvpZdBejzs4/NsY4lKi7sDaJR5t1Soz5KvB/fGdRYLBE8y4UywrUjZxq
        joYBRctNAtKrXK4G5TFame+lZ7SYY5ifepRKg6kBP2OSVoVVedV6EobwpmeG8evxaL2k2c8e4EYiu
        Er++puZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzJpr-002WLc-BP; Mon, 20 Dec 2021 14:40:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FB793004B2;
        Mon, 20 Dec 2021 15:40:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5F562C9C5155; Mon, 20 Dec 2021 15:40:17 +0100 (CET)
Date:   Mon, 20 Dec 2021 15:40:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YcCV0TECWE31fYV7@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YbyqeE39vqE9pEDD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbyqeE39vqE9pEDD@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 04:19:20PM +0100, Greg KH wrote:
> On Fri, Dec 17, 2021 at 02:55:07PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
> > > I can reproduce this.
> > > Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
> > > 
> > > 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
> > 
> > I can confirm, reverting that solves the boot hang, things aren't quite
> > working for me though.
> > 
> > > Seems to hang when read_poll_timeout_atomic() calls ktime_* functions.
> > > Maybe  it's too early for ktime.
> > 
> > It certainly is, using ktime for delay loops sounds daft to me anyhow.
> 
> It was a "find a pattern and replace it with a function call" type of
> cleanup series.  It's obviously wrong, I will go revert it now.

796eed4b2342 is definitely wrong, but instead of a straight up revert,
perhaps do something like this ?

---
Subject: usb: early: Revert from readl_poll_timeout_atomic()

Reverts commit 796eed4b2342 ("usb: early: convert to
readl_poll_timeout_atomic()") and puts in a comment to avoid the same
happening again.

Specifically that commit is wrong because readl_poll_timeout_atomic()
relies on ktime() working while this earlyprintk driver should be usable
long before that.

Fixes: 796eed4b2342 ("usb: early: convert to readl_poll_timeout_atomic()")
Debugged-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradaed.org>
---
 drivers/usb/early/xhci-dbc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 933d77ad0a64..ff279a830653 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -14,7 +14,6 @@
 #include <linux/pci_ids.h>
 #include <linux/memblock.h>
 #include <linux/io.h>
-#include <linux/iopoll.h>
 #include <asm/pci-direct.h>
 #include <asm/fixmap.h>
 #include <linux/bcd.h>
@@ -136,9 +135,20 @@ static int handshake(void __iomem *ptr, u32 mask, u32 done, int wait, int delay)
 {
 	u32 result;
 
-	return readl_poll_timeout_atomic(ptr, result,
-					 ((result & mask) == done),
-					 delay, wait);
+	/*
+	 * This must not be readl_poll_timeout_atomic(), as this is used
+	 * *early*, before ktime lives.
+	 */
+	do {
+		result = readl(ptr);
+		result &= mask;
+		if (result == done)
+			return 0;
+		udelay(delay);
+		wait -= delay;
+	} while (wait > 0);
+
+	return -ETIMEDOUT;
 }
 
 static void __init xdbc_bios_handoff(void)
