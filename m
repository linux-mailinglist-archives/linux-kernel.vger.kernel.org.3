Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0EB4984FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbiAXQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiAXQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:39:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF2AC06173B;
        Mon, 24 Jan 2022 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9/+MlDi6lcUZjAUf3HbuHS32+cmOPkRXu63Gbss8eqg=; b=uVNfx9zQyzLorHQWoAKUtd2zIG
        LqUlQojo8mjLziqYVwE90LDkxqiTc5GLZp8qNZ0AElYG0tys3KaURgLIte3Y8aHvBhY61+eRRxXdy
        p4aKuRWNAiKNzrUjTPh0VQiK1FZmxfJDVBz2P6z7rsEHmTg2TWZlNv6yUXf3Y3t2ulqOi1BJEfqTa
        Qtb/Y8uSYfl2ixeGy3tZBdB+5JkHhUpVZDLIIbnhEqd3sNDq+wFuJz8nI0o3Wn5nTJitmTSJbNqFP
        cpMR/wE3pdwSIufHArmB+pSQYUzuA4lD0FG7+iQ8tTsrmemzmzFZQuCVKru0lpOTGq1sD9LHOn57Q
        pg/Nfpjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC2N2-000vCa-VY; Mon, 24 Jan 2022 16:39:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9580300222;
        Mon, 24 Jan 2022 17:39:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BDD52B54C621; Mon, 24 Jan 2022 17:39:08 +0100 (CET)
Date:   Mon, 24 Jan 2022 17:39:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <Ye7WLM+NyVQlEMXN@hirez.programming.kicks-ass.net>
References: <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 04:55:22PM +0200, Mathias Nyman wrote:
>  
> > [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
> > [    4.984106] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> > [    9.946159] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> > [    9.946163] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
> >
> > [   12.818364] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> > [   12.818373] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
> > [   12.820360] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> > [   12.820363] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
> > [   12.821036] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > [   12.821040] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> > [   12.823451] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > [   12.823453] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
> > [   17.115089] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
> > [   17.115163] usb usb4-port4: config error
> 
> Ok, I see it now.
> Your setup has two xhci controllers, earlypringk=dbc enables dbc on the first xhci
> it finds, which would be at 0000:00:0d.0.
> Your cable is connected to the second xhci host at 0000:00:14.0
> 
> does using "earlyprintk=xdbc1" work?

Very quick testing says it don't work.. but I'll try again later, need
to go cook dinner now.
