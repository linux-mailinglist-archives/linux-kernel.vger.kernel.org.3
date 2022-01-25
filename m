Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931E249B26B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379615AbiAYK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiAYKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:54:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D5C061401;
        Tue, 25 Jan 2022 02:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3C26yCyaXzcVvHeWZfOkXSeuOkga4w7PGrbQGmRCHFU=; b=HrETcTbUllahnnU5GBR4Dd4EMz
        Pdv5BnIeodT7+zYAewTIOo3KfHQHagfZcdPShEueRJIrLoel288NVcNPrJu+6Mw61oAefybrA8wY+
        snQWvD+ceANIg2Jr7pIwcvvHH5iQHBqv+IukBc2BcfOUDQX2IlVOZbWWkQw1YA6YFQ6+zHzKhmbHA
        TSb4bLxwL6+JV66tVdZP72ONwyyZisTD82O5hLjSBgdMKPepiFZvcnqfKOSd3g/alyn7Oazcbzy1I
        1vi34EyIOzNUNJT9VAPLAbBF3RiVfkFHiSj2ubJDM4eEgHruF5jmkp/8VcEfBvJoPXrZO/KEZqZgF
        70yVy4rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCJSh-003Rt2-FS; Tue, 25 Jan 2022 10:54:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 439213002C5;
        Tue, 25 Jan 2022 11:54:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A346212DC040; Tue, 25 Jan 2022 11:54:06 +0100 (CET)
Date:   Tue, 25 Jan 2022 11:54:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <Ye/Wzte0qr/LVLfL@hirez.programming.kicks-ass.net>
References: <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye7WLM+NyVQlEMXN@hirez.programming.kicks-ass.net>
 <Ye7X5I4lm8gtRaBv@hirez.programming.kicks-ass.net>
 <6e2700c4-07dd-76ac-cd8f-d9e5b9b24e74@linux.intel.com>
 <Ye/VL4b1PUCsCeds@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye/VL4b1PUCsCeds@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:47:11AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 25, 2022 at 10:51:00AM +0200, Mathias Nyman wrote:
> > On 24.1.2022 18.46, Peter Zijlstra wrote:
> 
> > > FYI, I'm thinking early_xdbc_parse_parameter should've now given
> > > dpgp_num: 1 ?
> > > 
> > 
> > Yes, it should. 
> > 
> > Looks like there's a parsing issue.
> > "earlyprintk=xdbc1,keep" fails on our Tigerlake as well.
> >   
> > Without the "keep" option it works for me:
> > 
> > [    0.000000] Command line: console=ttyS0,115200n8 buildroot_hostname=tgl04 earlyprintk=xdbc1 dmi_entry_point=0x74374000
> > [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 1
> 
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc1,keep force_early_printk sched_verbose ft
> race=nop mitigations=off nokaslr
> 
> [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 1
> 
> [    0.399988] xhci_dbc:xdbc_start: DbC is running now, control 0x8d000003 port ID 15
> [    0.399998] xhci_dbc:xdbc_handle_port_status: connect status change event
> [    0.399999] xhci_dbc:xdbc_handle_port_status: port reset change event
> [    0.431217] printk: console [earlyxdbc0] enabled
> 
> Success!! I'll go submit proper patches for this then.

Next up, I don't suppose there's working patches for GRUB ? Because the
moment the thing gets stuck on a non-working kernel I'm screwed again :/
