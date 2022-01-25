Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAAA49B44F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245648AbiAYMuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455460AbiAYMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:46:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E537C061760;
        Tue, 25 Jan 2022 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/pi/hUUlS91esbzGCPX8RrA4mReY8qXH6MTNTD3QQsY=; b=nh0jtatPM+dv1vDo8NvVTs+zdo
        rKJGgiqzkMhmmKjHUcPHaQQLuW4v6utD/NacbzRNqPD5RKhrn8xvR1tMw+uSFvvdk1vjImrnIkzII
        CIcEXFn/nRwDCSv4C8gOabceTHfUzsN2D394Azj8YLUQKsJIFn6PHIkFvBGK9haUJuH+Cqj1p4oFL
        dm+KzDIN7t0RCPMud1uV4IsPmwD+PAwNc4tqw68B5d+kOFzvQjqgOsHWvsFd8S/+Naxy65RnZXSL1
        Qjb3qipXGUh1TsHVXsf/Sm//hUy8Zlr8DBb+rOUj1mRH05gHgXrPJQl8V5fTcFuaO1PhOYifdxS3M
        DIN/E3sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCLCq-003TIy-Tp; Tue, 25 Jan 2022 12:45:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49CE63002FC;
        Tue, 25 Jan 2022 13:45:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F24E12B37266D; Tue, 25 Jan 2022 13:45:50 +0100 (CET)
Date:   Tue, 25 Jan 2022 13:45:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
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

I suspect the first xhci controller is for the usb-c ports on the
machine, while the second one has the usb-a ports covered.

Now the documentation states we need this super speed A<->A cable, but
could you also update the documentation for usb-c ? There's a fair
number of usb-c only devices out there now.

C<->A and C<->C cables are fairly easy to come by, would they 'just
work' ?
