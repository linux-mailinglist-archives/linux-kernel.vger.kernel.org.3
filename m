Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3516849F724
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbiA1KTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:19:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57596 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244074AbiA1KTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:19:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A99E761E68;
        Fri, 28 Jan 2022 10:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81342C340E0;
        Fri, 28 Jan 2022 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365155;
        bh=aRjNrr6JfZGMor2sYsrMy3B0FPYOJjTbnEogKUClVis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Msuo97Xu9roIczJKbLy7DLCJ9O6J75VpJINVZMjPkdwvfkdAW3MYmFoX51F7PJrwj
         eeHVmvu9sUfAO8pWxEtxH7VQRyHc6G7kxZvxB8sifRlQ6cZ70nk83yPpJQmKC7dwIw
         w9zyhmHtZ08shYZisR8AaNUXv4xmguWePLZe7muA=
Date:   Fri, 28 Jan 2022 11:19:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: socfpga: Fix a memory leak bug in
 socfpga_gate_init()
Message-ID: <YfPDINOCa5jLx+a+@kroah.com>
References: <20220124165316.55449-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124165316.55449-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:53:16AM +0800, Zhou Qingyang wrote:
> In socfpga_gate_init(), when ops fails, socfpga_clk is not released or
> passed out, which could lead to a memleak.
> 
> Fix this bug by adding a kfree of socfpga_clk on the failure path of ops.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: a30a67be7b6e ("clk: socfpga: Don't have get_parent for single parent ops")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/clk/socfpga/clk-gate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
> index 53d6e3ec4309..0ca5e0000925 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -188,8 +188,10 @@ void __init socfpga_gate_init(struct device_node *node)
>  		return;
>  
>  	ops = kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
> -	if (WARN_ON(!ops))
> +	if (WARN_ON(!ops)) {
> +		kfree(socfpga_clk);
>  		return;
> +	}
>  
>  	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
>  	if (rc)
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

